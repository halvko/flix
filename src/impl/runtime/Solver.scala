package impl.runtime

import impl.logic.Symbol.{PredicateSymbol => PSym, VariableSymbol => VSym}
import impl.logic._
import util.collection.mutable

/**
 * A semi-naive solver.
 */
class Solver(val program: Program, hints: Map[PSym, Hint]) {

  /**
   * A set of predicate facts.
   */
  val facts = scala.collection.mutable.Set.empty[Predicate]

  /**
   * The tables for n-ary relations.
   */
  val relation1 = mutable.MultiMap1.empty[PSym, Value]
  val relation2 = mutable.MultiMap1.empty[PSym, (Value, Value)]
  val relation3 = mutable.MultiMap1.empty[PSym, (Value, Value, Value)]
  val relation4 = mutable.MultiMap1.empty[PSym, (Value, Value, Value, Value)]
  val relation5 = mutable.MultiMap1.empty[PSym, (Value, Value, Value, Value, Value)]

  /**
   * Maps for n-ary lattices.
   */
  val map1 = mutable.Map1.empty[PSym, Value]
  val map2 = mutable.Map1.empty[PSym, (Value, Value)]
  val map3 = mutable.Map1.empty[PSym, (Value, Value, Value)]
  val map4 = mutable.Map1.empty[PSym, (Value, Value, Value, Value)]
  val map5 = mutable.Map1.empty[PSym, (Value, Value, Value, Value, Value)]

  /**
   * A map of dependencies between predicate symbols and horn clauses.
   *
   * If a horn clause `h` contains a predicate `p` then the map contains the element `p -> h`.
   */
  val dependencies = mutable.MultiMap1.empty[PSym, HornClause]

  /**
   * A work list of pending horn clauses (and their associated environments).
   */
  val queue = scala.collection.mutable.Queue.empty[(HornClause, Map[VSym, Value])]

  /**
   * The fixpoint computation.
   */
  def solve(): Unit = {
    // Find dependencies between predicates and horn clauses.
    // A horn clause `h` depends on predicate `p` iff `p` occurs in the body of `h`.
    for (h <- program.clauses; p <- h.body) {
      dependencies.put(p.name, h)
    }

    // Satisfy all facts. Satisfying a fact adds violated horn clauses (and environments) to the work list.
    for (h <- program.facts) {

      hints.get(h.head.name) map {
        case Hint(Representation.Code) => // nop
        case Hint(Representation.Data) =>
          satisfy(h.head, program.interpretation(h.head.name), Map.empty[VSym, Value])
      }
    }

    // Iteratively try to satisfy pending horn clauses.
    // Satisfying a horn clause may cause additional items to be added to the work list.
    while (queue.nonEmpty) {
      val (h, env) = queue.dequeue()
      satisfy(h, env)
    }
  }

  /////////////////////////////////////////////////////////////////////////////
  // Evaluation                                                              //
  /////////////////////////////////////////////////////////////////////////////

  /**
   * Returns `true` iff the given predicate `p` under the environment `env0` is a known ground fact.
   */
  def isGroundFact(p: Predicate, env0: Map[VSym, Value]): Boolean = p.asGround(env0) match {
    case None => false
    case Some(pg) => facts contains pg
  }

  /**
   * Returns a list of models for the given horn clause `h` under the given environment `env`.
   */
  def evaluate(h: HornClause, env: Map[VSym, Value]): List[Map[VSym, Value]] = {
    def isData(p: Predicate): Boolean = hints.get(p.name).exists(_.repr == Representation.Data)

    // Evaluate relational predicates before functional predicates.
    val relationals = h.body filter (p => isData(p))
    val functionals = h.body filterNot (p => isData(p))
    val predicates = relationals ::: functionals

    // Fold each predicate over the intial environment.
    val init = List(env)
    (init /: predicates) {
      case (envs, p) => evaluate(p, program.interpretation(p.name), envs)
    }
  }

  /**
   * Returns a list of environments for the given predicate `p` with interpretation `i` under *each* of the given environments `envs`.
   */
  def evaluate(p: Predicate, i: Interpretation, envs: List[Map[VSym, Value]]): List[Map[VSym, Value]] = {
    envs flatMap (evaluate(p, i, _))
  }

  /**
   * Returns a list of environments for the given predicate `p` with interpretation `i` under the given environment `env0`.
   */
  def evaluate(p: Predicate, i: Interpretation, env0: Map[VSym, Value]): List[Map[VSym, Value]] = {
    if (isGroundFact(p, env0)) {
      return List(env0)
    }

    // TODO: Use regular unification and then check if it as value?
    (i, hints.get(p.name)) match {
      case (Interpretation.Relation, Some(Hint(Representation.Data))) =>
        p.terms match {
          case ts@List(t1) => relation1.get(p.name).toList.flatMap {
            case v1 => Unification.unifyValues(ts, List(v1), env0)
          }
          case ts@List(t1, t2) => relation2.get(p.name).toList.flatMap {
            case (v1, v2) => Unification.unifyValues(ts, List(v1, v2), env0)
          }
          case ts@List(t1, t2, t3) => relation3.get(p.name).toList.flatMap {
            case (v1, v2, v3) => Unification.unifyValues(ts, List(v1, v2, v3), env0)
          }
          case ts@List(t1, t2, t3, t4) => relation4.get(p.name).toList.flatMap {
            case (v1, v2, v3, v4) => Unification.unifyValues(ts, List(v1, v2, v3, v4), env0)
          }
          case ts@List(t1, t2, t3, t4, t5) => relation5.get(p.name).toList.flatMap {
            case (v1, v2, v3, v4, v5) => Unification.unifyValues(ts, List(v1, v2, v3, v4, v5), env0)
          }
        }
      case _ => throw Error.UnsupportedInterpretation(p.name, i)
    }
  }

  /////////////////////////////////////////////////////////////////////////////
  // Satisfaction                                                            //
  /////////////////////////////////////////////////////////////////////////////

  /**
   * Satisfies the given horn clause `h` by finding all valid models of the given environment `env`.
   *
   * Adds all facts which satisfies the given horn clause `h`.
   */
  def satisfy(h: HornClause, env: Map[VSym, Value]): Unit = {
    val models = evaluate(h, env)
    for (model <- models) {
      satisfy(h.head, program.interpretation(h.head.name), model)
    }
  }

  /**
   * Satisfies the given predicate `p` under the given interpretation `i` and environment `env`.
   */
  def satisfy(p: Predicate, i: Interpretation, env: Map[VSym, Value]): Unit = {
    // Cache ground predicates (i.e. facts).
    facts += p.toGround(env)

    val repr = hints.get(p.name).map(_.repr).getOrElse(Representation.Code)

    (i, repr) match {
      case (Interpretation.Relation, Representation.Data) => p.terms match {
        case List(t1) =>
          val v1 = t1.toValue(env)
          val newFact = relation1.put(p.name, v1)
          if (newFact)
            propagate(Predicate(p.name, List(v1.asTerm)))

        case List(t1, t2) =>
          val (v1, v2) = (t1.toValue(env), t2.toValue(env))
          val newFact = relation2.put(p.name, (v1, v2))
          if (newFact)
            propagate(Predicate(p.name, List(v1.asTerm, v2.asTerm)))

        case List(t1, t2, t3) =>
          val (v1, v2, v3) = (t1.toValue(env), t2.toValue(env), t3.toValue(env))
          val newFact = relation3.put(p.name, (v1, v2, v3))
          if (newFact)
            propagate(Predicate(p.name, List(v1.asTerm, v2.asTerm, v3.asTerm)))

        case List(t1, t2, t3, t4) =>
          val (v1, v2, v3, v4) = (t1.toValue(env), t2.toValue(env), t3.toValue(env), t4.toValue(env))
          val newFact = relation4.put(p.name, (v1, v2, v3, v4))
          if (newFact)
            propagate(Predicate(p.name, List(v1.asTerm, v2.asTerm, v3.asTerm, v4.asTerm)))

        case List(t1, t2, t3, t4, t5) =>
          val (v1, v2, v3, v4, v5) = (t1.toValue(env), t2.toValue(env), t3.toValue(env), t4.toValue(env), t5.toValue(env))
          val newFact = relation5.put(p.name, (v1, v2, v3, v4, v5))
          if (newFact)
            propagate(Predicate(p.name, List(v1.asTerm, v2.asTerm, v3.asTerm, v4.asTerm, v5.asTerm)))
      }

      case (Interpretation.LatticeMap(lattice), Representation.Data) => p.terms match {
        case List(t1) =>
          val newValue = t1.toValue(env)
          val oldValue = map1.get(p.name).getOrElse(lattice.bot)
          val joinValue = join(lattice.join, newValue, oldValue)
          val newFact: Boolean = !leq(lattice.leq, joinValue, oldValue)
          if (newFact) {
            map1.put(p.name, joinValue)
            propagate(Predicate(p.name, List(joinValue.asTerm)))
          }
      }
    }
  }

  /**
   * Enqueues all horn clauses which depend on the given predicate.
   */
  def propagate(p: Predicate): Unit = {
    for (h <- dependencies.get(p.name)) {
      for (p2 <- h.body) {
        Unification.unify(p, p2, Map.empty[VSym, Term]) match {
          case None => // nop
          case Some(env0) => queue.enqueue((h, env0.mapValues(_.toValue)))
        }
      }
    }
  }

  /////////////////////////////////////////////////////////////////////////////
  // Top-down satisfiability                                                 //
  /////////////////////////////////////////////////////////////////////////////

  /**
   * Returns all satisfiable models for the given predicate `p` under the given environment `env0`.
   */
  // TODO: Must take cycles into account.
  def getSat(p: Predicate, env0: Map[VSym, Term] = Map.empty): List[Map[VSym, Term]] = {
    program.clauses.flatMap {
      h => Unification.unify(p, h.head, env0) match {
        case None =>
          // Head predicate is not satisfied. No need to look at body.
          List.empty
        case Some(env) =>
          // Head predicate is satisfied. Check whether the body can be made satisfiable.
          h.body.foldLeft(List(env)) {
            case (envs, p2) => envs.flatMap(e => getSat(p2, e))
          }
      }
    }
  }

  /**
   * Optionally returns the unique term of the variable `x` in all the given models `xs`.
   */
  def uniqueTerm(x: VSym, xs: List[Map[VSym, Term]]): Option[Term] = {
    val vs = xs.flatMap(_.get(x)).toSet
    if (vs.size == 1)
      Some(vs.head)
    else
      None
  }

  /**
   * Optionally returns the unique value of the variable `x` in all the given models `xs`.
   */
  def uniqueValue(x: VSym, xs: List[Map[VSym, Term]]): Option[Value] =
    uniqueTerm(x, xs).flatMap(t => t.asValue)

  /**
   * Returns `true` iff `v1` is less or equal to `v2`.
   */
  def leq(s: PSym, v1: Value, v2: Value): Boolean = {
    val p = Predicate(s, List(v1.asTerm, v2.asTerm))
    val models = getSat(p)
    models.nonEmpty
  }

  /**
   * Returns the join of `v1` and `v2`.
   */
  def join(s: PSym, v1: Value, v2: Value): Value = {
    val p = Predicate(s, List(v1.asTerm, v2.asTerm, Term.Variable(Symbol.VariableSymbol("!x"))))
    val models = getSat(p)
    val value = uniqueValue(Symbol.VariableSymbol("!x"), models)

    value match {
      case None => throw Error.NonUniqueModel(s)
      case Some(v) => v
    }
  }
}
