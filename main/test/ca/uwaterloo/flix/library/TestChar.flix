/*
 * Copyright 2020 Stephen Tetley
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

namespace TestChar {

/////////////////////////////////////////////////////////////////////////////
// isAscii                                                                 //
/////////////////////////////////////////////////////////////////////////////

@test
def isAscii01(): Bool = Char.isAscii('a') == true

@test
def isAscii02(): Bool = Char.isAscii('A') == true

@test
def isAscii03(): Bool = Char.isAscii(' ') == true

@test
def isAscii04(): Bool = Char.isAscii('+') == true

@test
def isAscii05(): Bool = Char.isAscii('0') == true

@test
def isAscii06(): Bool = Char.isAscii('9') == true

@test
def isAscii07(): Bool = Char.isAscii('†') == false

@test
def isAscii08(): Bool = Char.isAscii('\u00FE') == false     // lower-case thorn

@test
def isAscii09(): Bool = Char.isAscii('\u00B1') == false     // plus-minus sign

@test
def isAscii10(): Bool = Char.isAscii('â') == false

@test
def isAscii11(): Bool = Char.isAscii('Â') == false

/////////////////////////////////////////////////////////////////////////////
// isLetter                                                                //
/////////////////////////////////////////////////////////////////////////////

@test
def isLetter01(): Bool = Char.isLetter('a') == true

@test
def isLetter02(): Bool = Char.isLetter('A') == true

@test
def isLetter03(): Bool = Char.isLetter(' ') == false

@test
def isLetter04(): Bool = Char.isLetter('+') == false

@test
def isLetter05(): Bool = Char.isLetter('0') == false

@test
def isLetter06(): Bool = Char.isLetter('9') == false

@test
def isLetter07(): Bool = Char.isLetter('†') == false

@test
def isLetter08(): Bool = Char.isLetter('\u00FE') == true        // lower-case thorn

@test
def isLetter09(): Bool = Char.isLetter('\u00B1') == false       // plus-minus sign

@test
def isLetter10(): Bool = Char.isLetter('â') == true

@test
def isLetter11(): Bool = Char.isLetter('Â') == true

/////////////////////////////////////////////////////////////////////////////
// isDigit                                                                 //
/////////////////////////////////////////////////////////////////////////////

@test
def isDigit01(): Bool = Char.isDigit('a') == false

@test
def isDigit02(): Bool = Char.isDigit('A') == false

@test
def isDigit03(): Bool = Char.isDigit(' ') == false

@test
def isDigit04(): Bool = Char.isDigit('+') == false

@test
def isDigit05(): Bool = Char.isDigit('0') == true

@test
def isDigit06(): Bool = Char.isDigit('9') == true

@test
def isDigit07(): Bool = Char.isDigit('†') == false

@test
def isDigit08(): Bool = Char.isDigit('\u00FE') == false         // lower-case thorn

@test
def isDigit09(): Bool = Char.isDigit('\u00B1') == false         // plus-minus sign

@test
def isDigit10(): Bool = Char.isDigit('â') == false

@test
def isDigit11(): Bool = Char.isDigit('Â') == false

@test
def isDigit12(): Bool = Char.isDigit('\u0660') == true          // Arabic-Indic digit zero

@test
def isDigit13(): Bool = Char.isDigit('\u0669') == true          // Arabic-Indic digit nine

@test
def isDigit14(): Bool = Char.isDigit('\u0966') == true          // Devanagari digit zero

@test
def isDigit15(): Bool = Char.isDigit('\u096F') == true          // Devanagari digit nine

/////////////////////////////////////////////////////////////////////////////
// isAsciiDigit                                                            //
/////////////////////////////////////////////////////////////////////////////

@test
def isAsciiDigit01(): Bool = Char.isAsciiDigit('a') == false

@test
def isAsciiDigit02(): Bool = Char.isAsciiDigit('A') == false

@test
def isAsciiDigit03(): Bool = Char.isAsciiDigit(' ') == false

@test
def isAsciiDigit04(): Bool = Char.isAsciiDigit('+') == false

@test
def isAsciiDigit05(): Bool = Char.isAsciiDigit('0') == true

@test
def isAsciiDigit06(): Bool = Char.isAsciiDigit('9') == true

@test
def isAsciiDigit07(): Bool = Char.isAsciiDigit('†') == false

@test
def isAsciiDigit08(): Bool = Char.isAsciiDigit('\u00FE') == false        // lower-case thorn

@test
def isAsciiDigit09(): Bool = Char.isAsciiDigit('\u00B1') == false       // plus-minus sign

@test
def isAsciiDigit10(): Bool = Char.isAsciiDigit('â') == false

@test
def isAsciiDigit11(): Bool = Char.isAsciiDigit('Â') == false

@test
def isAsciiDigit12(): Bool = Char.isAsciiDigit('\u0660') == false       // Arabic-Indic digit zero

@test
def isAsciiDigit13(): Bool = Char.isAsciiDigit('\u0669') == false       // Arabic-Indic digit nine

@test
def isAsciiDigit14(): Bool = Char.isAsciiDigit('\u0966') == false       // Devanagari digit zero

@test
def isAsciiDigit15(): Bool = Char.isAsciiDigit('\u096F') == false       // Devanagari digit nine

/////////////////////////////////////////////////////////////////////////////
// isOctDigit                                                              //
/////////////////////////////////////////////////////////////////////////////

@test
def isOctDigit01(): Bool = Char.isOctDigit('a') == false

@test
def isOctDigit02(): Bool = Char.isOctDigit('A') == false

@test
def isOctDigit03(): Bool = Char.isOctDigit(' ') == false

@test
def isOctDigit04(): Bool = Char.isOctDigit('+') == false

@test
def isOctDigit05(): Bool = Char.isOctDigit('0') == true

@test
def isOctDigit06(): Bool = Char.isOctDigit('9') == false

@test
def isOctDigit07(): Bool = Char.isOctDigit('†') == false

@test
def isOctDigit08(): Bool = Char.isOctDigit('\u00FE') == false        // lower-case thorn

@test
def isOctDigit09(): Bool = Char.isOctDigit('\u00B1') == false       // plus-minus sign

@test
def isOctDigit10(): Bool = Char.isOctDigit('â') == false

@test
def isOctDigit11(): Bool = Char.isOctDigit('Â') == false

@test
def isOctDigit12(): Bool = Char.isOctDigit('7') == true

@test
def isOctDigit13(): Bool = Char.isOctDigit('8') == false

/////////////////////////////////////////////////////////////////////////////
// isHexDigit                                                              //
/////////////////////////////////////////////////////////////////////////////

@test
def isHexDigit01(): Bool = Char.isHexDigit('a') == true

@test
def isHexDigit02(): Bool = Char.isHexDigit('A') == true

@test
def isHexDigit03(): Bool = Char.isHexDigit(' ') == false

@test
def isHexDigit04(): Bool = Char.isHexDigit('+') == false

@test
def isHexDigit05(): Bool = Char.isHexDigit('0') == true

@test
def isHexDigit06(): Bool = Char.isHexDigit('9') == true

@test
def isHexDigit07(): Bool = Char.isHexDigit('†') == false

@test
def isHexDigit08(): Bool = Char.isHexDigit('\u00FE') == false        // lower-case thorn

@test
def isHexDigit09(): Bool = Char.isHexDigit('\u00B1') == false       // plus-minus sign

@test
def isHexDigit10(): Bool = Char.isHexDigit('â') == false

@test
def isHexDigit11(): Bool = Char.isHexDigit('Â') == false

@test
def isHexDigit12(): Bool = Char.isHexDigit('7') == true

@test
def isHexDigit13(): Bool = Char.isHexDigit('8') == true

@test
def isHexDigit14(): Bool = Char.isHexDigit('F') == true

@test
def isHexDigit15(): Bool = Char.isHexDigit('f') == true

@test
def isHexDigit16(): Bool = Char.isHexDigit('G') == false

@test
def isHexDigit17(): Bool = Char.isHexDigit('g') == false

/////////////////////////////////////////////////////////////////////////////
// isLowerCase                                                             //
/////////////////////////////////////////////////////////////////////////////

@test
def isLowerCase01(): Bool = Char.isLowerCase('a') == true

@test
def isLowerCase02(): Bool = Char.isLowerCase('A') == false

@test
def isLowerCase03(): Bool = Char.isLowerCase(' ') == false

@test
def isLowerCase04(): Bool = Char.isLowerCase('+') == false

@test
def isLowerCase05(): Bool = Char.isLowerCase('0') == false

@test
def isLowerCase06(): Bool = Char.isLowerCase('9') == false

@test
def isLowerCase07(): Bool = Char.isLowerCase('†') == false

@test
def isLowerCase08(): Bool = Char.isLowerCase('\u00FE') == true        // lower-case thorn

@test
def isLowerCase09(): Bool = Char.isLowerCase('\u00B1') == false       // plus-minus sign

@test
def isLowerCase10(): Bool = Char.isLowerCase('â') == true

@test
def isLowerCase11(): Bool = Char.isLowerCase('Â') == false

/////////////////////////////////////////////////////////////////////////////
// isUpperCase                                                             //
/////////////////////////////////////////////////////////////////////////////

@test
def isUpperCase01(): Bool = Char.isUpperCase('a') == false

@test
def isUpperCase02(): Bool = Char.isUpperCase('A') == true

@test
def isUpperCase03(): Bool = Char.isUpperCase(' ') == false

@test
def isUpperCase04(): Bool = Char.isUpperCase('+') == false

@test
def isUpperCase05(): Bool = Char.isUpperCase('0') == false

@test
def isUpperCase06(): Bool = Char.isUpperCase('9') == false

@test
def isUpperCase07(): Bool = Char.isUpperCase('†') == false

@test
def isUpperCase08(): Bool = Char.isUpperCase('\u00FE') == false        // lower case thorn

@test
def isUpperCase09(): Bool = Char.isUpperCase('\u00B1') == false       // plus-minus sign

@test
def isUpperCase10(): Bool = Char.isUpperCase('â') == false

@test
def isUpperCase11(): Bool = Char.isUpperCase('Â') == true

/////////////////////////////////////////////////////////////////////////////
// isWhiteSpace                                                            //
/////////////////////////////////////////////////////////////////////////////

@test
def isWhiteSpace01(): Bool = Char.isWhiteSpace('a') == false

@test
def isWhiteSpace02(): Bool = Char.isWhiteSpace('A') == false

@test
def isWhiteSpace03(): Bool = Char.isWhiteSpace(' ') == true

@test
def isWhiteSpace04(): Bool = Char.isWhiteSpace('+') == false

@test
def isWhiteSpace05(): Bool = Char.isWhiteSpace('0') == false

@test
def isWhiteSpace06(): Bool = Char.isWhiteSpace('9') == false

@test
def isWhiteSpace07(): Bool = Char.isWhiteSpace('†') == false

@test
def isWhiteSpace08(): Bool = Char.isWhiteSpace('\u00FE') == false     // lower-case thorn

@test
def isWhiteSpace09(): Bool = Char.isWhiteSpace('\u00B1') == false     // plus-minus sign

@test
def isWhiteSpace10(): Bool = Char.isWhiteSpace('â') == false

@test
def isWhiteSpace11(): Bool = Char.isWhiteSpace('Â') == false

@test
def isWhiteSpace12(): Bool = Char.isWhiteSpace('\u0009') == true    // tab

@test
def isWhiteSpace13(): Bool = Char.isWhiteSpace('\t') == true        // tab

@test
def isWhiteSpace14(): Bool = Char.isWhiteSpace('\u000A') == true    // line-feed

@test
def isWhiteSpace15(): Bool = Char.isWhiteSpace('\n') == true        // line-feed

@test
def isWhiteSpace16(): Bool = Char.isWhiteSpace('\u000D') == true    // carriage-return

@test
def isWhiteSpace17(): Bool = Char.isWhiteSpace('\r') == true        // carriage-return

/////////////////////////////////////////////////////////////////////////////
// toLowerCase                                                             //
/////////////////////////////////////////////////////////////////////////////

@test
def toLowerCase01(): Bool = Char.toLowerCase('a') == 'a'

@test
def toLowerCase02(): Bool = Char.toLowerCase('A') == 'a'

@test
def toLowerCase03(): Bool = Char.toLowerCase(' ') == ' '

@test
def toLowerCase04(): Bool = Char.toLowerCase('+') == '+'

@test
def toLowerCase05(): Bool = Char.toLowerCase('0') == '0'

@test
def toLowerCase06(): Bool = Char.toLowerCase('9') == '9'

@test
def toLowerCase07(): Bool = Char.toLowerCase('†') == '†'

@test
def toLowerCase08(): Bool = Char.toLowerCase('\u00FE') == '\u00FE'     // lower-case thorn

@test
def toLowerCase09(): Bool = Char.toLowerCase('\u00B1') == '\u00B1'     // plus-minus sign

@test
def toLowerCase10(): Bool = Char.toLowerCase('â') == 'â'

@test
def toLowerCase11(): Bool = Char.toLowerCase('Â') == 'â'

/////////////////////////////////////////////////////////////////////////////
// toUpperCase                                                             //
/////////////////////////////////////////////////////////////////////////////

@test
def toUpperCase01(): Bool = Char.toUpperCase('a') == 'A'

@test
def toUpperCase02(): Bool = Char.toUpperCase('A') == 'A'

@test
def toUpperCase03(): Bool = Char.toUpperCase(' ') == ' '

@test
def toUpperCase04(): Bool = Char.toUpperCase('+') == '+'

@test
def toUpperCase05(): Bool = Char.toUpperCase('0') == '0'

@test
def toUpperCase06(): Bool = Char.toUpperCase('9') == '9'

@test
def toUpperCase07(): Bool = Char.toUpperCase('†') == '†'

@test
def toUpperCase08(): Bool = Char.toUpperCase('\u00FE') == '\u00DE'     // thorn (lower to upper)

@test
def toUpperCase09(): Bool = Char.toUpperCase('\u00B1') == '\u00B1'     // plus-minus sign

@test
def toUpperCase10(): Bool = Char.toUpperCase('â') == 'Â'

@test
def toUpperCase11(): Bool = Char.toUpperCase('Â') == 'Â'

/////////////////////////////////////////////////////////////////////////////
// toString                                                                //
/////////////////////////////////////////////////////////////////////////////

@test
def toString01(): Bool = Char.toString('a') == "a"

@test
def toString02(): Bool = Char.toString('A') == "A"

@test
def toString03(): Bool = Char.toString(' ') == " "

@test
def toString04(): Bool = Char.toString('+') == "+"

@test
def toString05(): Bool = Char.toString('0') == "0"

@test
def toString06(): Bool = Char.toString('9') == "9"

@test
def toString07(): Bool = Char.toString('†') == "†"

@test
def toString08(): Bool = Char.toString('\u00FE') == "þ"    // lower-case thorn

@test
def toString09(): Bool = Char.toString('\u00B1') == "±"     // plus-minus sign

@test
def toString10(): Bool = Char.toString('â') == "â"

@test
def toString11(): Bool = Char.toString('Â') == "Â"

/////////////////////////////////////////////////////////////////////////////
// toInt32                                                                 //
/////////////////////////////////////////////////////////////////////////////

@test
def toInt3201(): Bool = Char.toInt32('a') == 0x0061

@test
def toInt3202(): Bool = Char.toInt32('A') == 0x0041

@test
def toInt3203(): Bool = Char.toInt32(' ') == 0x0020

@test
def toInt3204(): Bool = Char.toInt32('+') == 0x002B

@test
def toInt3205(): Bool = Char.toInt32('0') == 0x0030

@test
def toInt3206(): Bool = Char.toInt32('9') == 0x0039

@test
def toInt3207(): Bool = Char.toInt32('†') == 0x2020         // dagger

@test
def toInt3208(): Bool = Char.toInt32('\u00FE') == 0x00FE    // lower-case thorn

@test
def toInt3209(): Bool = Char.toInt32('\u00B1') == 0x00B1    // plus-minus sign

@test
def toInt3210(): Bool = Char.toInt32('â') == 0x00E2         // a-circumflex (lower case)

@test
def toInt3211(): Bool = Char.toInt32('Â') == 0x00C2         // A-circumflex (upper-case)

/////////////////////////////////////////////////////////////////////////////
// fromInt32                                                               //
/////////////////////////////////////////////////////////////////////////////

@test
def fromInt3201(): Bool = Char.fromInt32(0x0061) == 'a'

@test
def fromInt3202(): Bool = Char.fromInt32(0x0041) == 'A'

@test
def fromInt3203(): Bool = Char.fromInt32(0x0020) == ' '

@test
def fromInt3204(): Bool = Char.fromInt32(0x002B) == '+'

@test
def fromInt3205(): Bool = Char.fromInt32(0x0030) == '0'

@test
def fromInt3206(): Bool = Char.fromInt32(0x0039) == '9'

@test
def fromInt3207(): Bool = Char.fromInt32(0x2020) == '†'         // dagger

@test
def fromInt3208(): Bool = Char.fromInt32(0x00FE) == '\u00FE'    // lower-case thorn

@test
def fromInt3209(): Bool = Char.fromInt32(0x00B1) == '\u00B1'    // plus-minus sign

@test
def fromInt3210(): Bool = Char.fromInt32(0x00E2) == 'â'         // a-circumflex (lower case)

@test
def fromInt3211(): Bool = Char.fromInt32(0x00C2) == 'Â'         // A-circumflex (upper-case)

}