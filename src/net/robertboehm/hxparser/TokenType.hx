// Copyright (C) 2012 Robert Böhm
// 
// This file is part of hxparser.
// 
// hxparser is free software: you can redistribute it and/or modify it under the
// terms of the GNU Lesser General Public License as published by the Free
// Software Foundation, either version 3 of the License, or (at your option)
// any later version.
// 
// hxparser is distributed in the hope that it will be useful, but WITHOUT ANY
// WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
// more details.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with hxparser. If not, see: <http://www.gnu.org/licenses/>.

package net.robertboehm.hxparser;

/**
 * ...
 * @author Robert Böhm
 */
enum TokenType {
    IDENTIFIER;
    COMMENT;
    LINE_COMMENT;
    KEYWORD;
    MEMBER_ATTRIBUTE;
    PROPERTY_ACCESSIBILITY;
    STRING_LITERAL;
    FLOAT_LITERAL;
    INT_LITERAL;
    OPERATOR;
    TYPE;
    CODEBLOCK_BEGIN;
    CODEBLOCK_END;
    PARAMETER_BEGIN;
    PARAMETER_END;
    INSTRUCTION_DELIMITER;
    PARAMETER_DELIMITER;
}
