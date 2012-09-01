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
 * Tokenizes code for further usage.
 * 
 * @author Robert Böhm
 */
class Tokenizer {

    public function new() { }
    
    
    public function parse(data:String):TokenList {
        var t:TokenList = new TokenList();
        var buffer:StringBuf = new StringBuf();
        var i:Int = 0;
        while (i < data.length) {
            if (i + 1 < data.length && data.charAt(i) == "/" && data.charAt(i + 1) == "*") {
                // Multi-line comment:
                var buf:StringBuf = new StringBuf();
                i++;
                while (i < data.length - 2) {
                    if (data.charAt(++i) == "*" && data.charAt(i + 1) == "/") {
                        break;
                    } else {
                        buf.addChar(data.charCodeAt(i));
                    }
                }
                i++;
                if (buf.toString().length > 0) {
                    t.addToken(new Token(TokenType.COMMENT, i, StringTools.trim(buf.toString())));
                }
                
            } else if (i + 1 < data.length && data.charAt(i) == "/" && data.charAt(i + 1) == "/") {
                // Single line comment:
                i++;
                var buf:StringBuf = new StringBuf();
                while (i < data.length) {
                    if (data.charAt(++i) == "\n") {
                        break;
                    } else {
                        buf.addChar(data.charCodeAt(i));
                    }
                }
                i--; // \n will be kept
                if (buf.toString().length > 0) {
                    t.addToken(new Token(TokenType.LINE_COMMENT, i, StringTools.trim(buf.toString())));
                }
            
            } else if (~/\s/.match(data.charAt(i))) {
                // Whitespace characters:
                t.addToken(Token.fromString(buffer.toString(), i));
                buffer = new StringBuf();
            
            } else if (~/[(){},;]/.match(data.charAt(i)) || Lambda.has(Token.OPERATORS, data.charAt(i))) {
                // Symbol characters:
                t.addToken(Token.fromString(buffer.toString(), i));
                t.addToken(Token.fromString(data.charAt(i), i));
                buffer = new StringBuf();
            
            } else if (~/:/.match(data.charAt(i))) {
                // Type name:
                t.addToken(Token.fromString(buffer.toString(), i));
                buffer = new StringBuf();
                buffer.addChar(data.charCodeAt(i));
                
            } else {
                // By default, just copy the character to the new buffer:
                buffer.addChar(data.charCodeAt(i));
                
            }
            i++;
        }
        return t;
    }
    
}
