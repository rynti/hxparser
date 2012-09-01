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
class TokenList {
    
    public var length(getLength, never):Int;
    
    public var counter:Int;
    
    private var tokens:Array<Token>;
    
    
    public function new() {
        this.counter = 0;
        this.tokens = [];
    }
    
    
    public function addToken(token:Token):Void {
        if (token != null) {
            if (token.type == TokenType.LINE_COMMENT && tokens.length > 0 &&
                    tokens[tokens.length - 1].type == TokenType.LINE_COMMENT) {
                
                tokens[tokens.length - 1].value += "\n" + token.value;
            
            } else if (token.type == TokenType.OPERATOR && tokens.length > 0 &&
                    tokens[tokens.length - 1].type == TokenType.OPERATOR &&
                    tokens[tokens.length - 1].value == token.value &&
                    Lambda.has(Token.DOUBLE_OPERATORS, token.value)) {
                
                tokens[tokens.length - 1].value += token.value;
                
            } else {
                tokens.push(token);
            }
        }
    }
    
    public function skip(count:Int = 1):Void {
        counter += count;
    }
    
    public function get(index:Int):Token {
        return tokens[index];
    }
    
    public function hasNext():Bool {
        return counter < tokens.length;
    }
    
    public function next():Token {
        return tokens[counter++];
    }
    
    public function peek(offset:Int = 0):Token {
        return tokens[counter + offset];
    }
    
    public function toString():String {
        return "Tokens {\n    " + tokens.join("\n    ") + "\n}";
    }
    
    
    private function getLength():Int {
        return tokens.length;
    }
    
}
