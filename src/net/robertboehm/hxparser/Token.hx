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
class Token {
    
    public static var KEYWORDS:Array<String> = [
            "package", "import", "class", "var", "function", "if", "else"
        ];
    
    public static var MEMBER_ATTRIBUTES:Array<String> = [
            "public", "private", "static", "inline"
        ];
    
    public static var PROPERTY_ACCESSIBILITIES:Array<String> = [
            "default", "never"
        ];
    
    public static var OPERATORS:Array<String> = [
            "=", "+", "-", "*", "/", "%", "!", "&", "|"
        ];
    
    public static var DOUBLE_OPERATORS:Array<String> = [
            "+", "-", "&", "|"
        ];
    
    
    public var type(default, null):TokenType;
    
    public var location:Int;
    
    public var value:String;
    
    
    public function new(type:TokenType, location:Int, ?value:String) {
        this.type = type;
        this.location = location;
        this.value = value;
    }
    
    
    public static function fromString(data:String, location:Int):Token {
        if (data == null || data.length == 0 || StringTools.trim(data).length == 0) {
            return null;
        } else if (data == "(") {
            return new Token(TokenType.PARAMETER_BEGIN, location);
        } else if (data == ")") {
            return new Token(TokenType.PARAMETER_END, location);
        } else if (data == "{") {
            return new Token(TokenType.CODEBLOCK_BEGIN, location);
        } else if (data == "}") {
            return new Token(TokenType.CODEBLOCK_END, location);
        } else if (data == ";") {
            return new Token(TokenType.INSTRUCTION_DELIMITER, location);
        } else if (data == ",") {
            return new Token(TokenType.PARAMETER_DELIMITER, location);
        } else if (StringTools.startsWith(data, ":")) {
            return new Token(TokenType.TYPE, location, data.substr(1));
        } else if (Lambda.has(MEMBER_ATTRIBUTES, data)) {
            return new Token(TokenType.MEMBER_ATTRIBUTE, location, data);
        } else if (Lambda.has(PROPERTY_ACCESSIBILITIES, data)) {
            return new Token(TokenType.PROPERTY_ACCESSIBILITY, location, data);
        } else if (Lambda.has(KEYWORDS, data)) {
            return new Token(TokenType.KEYWORD, location, data);
        } else if (Lambda.has(OPERATORS, data)) {
            return new Token(TokenType.OPERATOR, location, data);
        } else if (~/^(0x)?[0-9]+$/.match(data)) {
            return new Token(TokenType.INT_LITERAL, location, data);
        } else if (~/^[0-9]*\.[0-9]+$/.match(data)) {
            return new Token(TokenType.FLOAT_LITERAL, location, data);
        } else {
            return new Token(TokenType.IDENTIFIER, location, data);
        }
    }
    
    public function toString():String {
        return "<#" + location + " " + Std.string(type) + ((value != null) ? (": " + value) : "") + ">";
    }
    
}
