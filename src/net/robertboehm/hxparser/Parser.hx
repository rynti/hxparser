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

import net.robertboehm.hxparser.data.Codeblock;
import net.robertboehm.hxparser.data.File;
import net.robertboehm.hxparser.data.Member;
import net.robertboehm.hxparser.data.Type;
import net.robertboehm.hxparser.data.TypeField;
import net.robertboehm.hxparser.data.TypeFunction;
import net.robertboehm.hxparser.data.Visibility;


/**
 * ...
 * @author Robert Böhm
 */
class Parser {
    
    public function new() { }
    
    
    public function parse(data:TokenList):File {
        var file:File = new File();
        file.start = 0;
        file.end = data.get(data.length - 1).location;
        if (data.get(data.length - 1).value != null) {
            file.end += data.get(data.length - 1).value.length;
        } else {
            // Default token length == 1
            file.end += 1;
        }
        
        var t:Token;
        while (data.hasNext()) {
            t = data.next();
            if (t.type == TokenType.KEYWORD) {
                if (t.value == "package") {
                    
                    // package ...
                    if (file.packagePath == null) {
                        if (data.peek().type == TokenType.IDENTIFIER) {
                            file.packagePath = data.next().value;
                            if (data.peek().type == TokenType.INSTRUCTION_DELIMITER) {
                                data.next();
                            } else {
                                // Error: Unexpected token, semicolon expected.
                            }
                            
                        } else if (data.peek().type == TokenType.INSTRUCTION_DELIMITER) {
                            // Empty package
                            file.packagePath = "";
                            
                        } else {
                            // Error: Unexpected token, semicolon or package expected.
                            
                        }
                    } else {
                        // Error: Multiple package definition.
                        
                    }
                    // ... package
                
                } else if (t.value == "import") {
                    // import ...
                    if (data.peek().type == TokenType.IDENTIFIER) {
                        file.imports.push(data.next().value);
                        if (data.peek().type == TokenType.INSTRUCTION_DELIMITER) {
                            data.next();
                        } else {
                            // Error: Unexpected token, semicolon expected.
                        }
                        
                    } else {
                        // Error: Unexpected token, import path expected.
                        
                    }
                    // ... import
                
                } else if (t.value == "class") {
                    // class ...
                    if (data.peek().type == TokenType.IDENTIFIER) {
                        var className:String = data.next().value;
                        if (data.peek().type == TokenType.CODEBLOCK_BEGIN) {
                            data.next();
                            var type:Type = new Type();
                            type.name = className;
                            type.codeblock = new Codeblock();
                            type.codeblock.start = data.peek().location;
                            parseClass(data, type);
                            type.codeblock.end = data.peek().location;
                            
                        } else {
                            // Error: Unexpected token.
                        }
                        
                    } else {
                        // Error: Unexpected token, class name expected.
                        
                    }
                    // ... class
                    
                } else {
                    // Error: Unknown keyword. (Shouldn't happen when you support all Token.KEYWORDS)
                    
                }
            }
        }
        
        return file;
    }
    
    private function parseClass(data:TokenList, type:Type):Codeblock {
        var code:Codeblock = new Codeblock();
        
        var attributes:AttributeTokenList = new AttributeTokenList();
        var t:Token;
        while (data.hasNext()) {
            t = data.next();
            
            if (t.type == TokenType.CODEBLOCK_END) {
                data.skip( -1);
                break;
            } else if (t.type == TokenType.MEMBER_ATTRIBUTE) {
                attributes.applyToken(t);
            } else if (t.type == TokenType.KEYWORD) {
                if (t.value == "var") {
                    if (data.peek().type == TokenType.IDENTIFIER) {
                        if (data.peek(1).type == TokenType.PARAMETER_BEGIN) {
                            // Property
                        } else {
                            var field:TypeField = new TypeField();
                            field.definitionLocation = data.peek().location;
                            field.name = data.next().value;
                            field.isExplicitType = (data.peek().type == TokenType.TYPE);
                            field.isReadOnly = attributes.isInline;
                            field.isStatic = attributes.isStatic;
                            field.visibility = attributes.isPublic ? Visibility.PUBLIC : Visibility.PRIVATE;
                            field.parent = type.codeblock;
                            field.type = field.isExplicitType ? data.next().value : "Dynamic";
                            trace(field);
                        }
                        attributes.reset();
                        if (data.peek().type != TokenType.INSTRUCTION_DELIMITER) {
                            // Error: Missing semicolon.
                        } else {
                            data.next();
                        }
                        
                    } else {
                        // Error: Unexpected token, expected member name.
                    }
                } else if (t.value == "function") {
                    if (data.peek().type == TokenType.IDENTIFIER) {
                        var func:TypeFunction = new TypeFunction();
                        func.definitionLocation = data.peek().location;
                        func.name = data.next().value;
                        func.isStatic = attributes.isStatic;
                        func.visibility = attributes.isPublic ? Visibility.PUBLIC : Visibility.PRIVATE;
                        func.parent = type.codeblock;
                        
                        t = data.next();
                        if (t.type == TokenType.PARAMETER_BEGIN) {
                            while (data.hasNext()) {
                                t = data.next();
                                if (t.type == TokenType.PARAMETER_END) {
                                    break;
                                } else if (t.type == TokenType.IDENTIFIER) {
                                    var parameter:Member = new Member();
                                    parameter.definitionLocation = t.location;
                                    parameter.isExplicitType = (data.peek().type == TokenType.TYPE);
                                    parameter.name = t.value;
                                    parameter.parent = null; // TODO: Function codeblock
                                    parameter.type = parameter.isExplicitType ? data.next().value : "Dynamic";
                                    func.parameters.push(parameter);
                                    t = data.next();
                                    if (t.type == TokenType.PARAMETER_DELIMITER) {
                                        continue;
                                    } else if(t.type == TokenType.PARAMETER_END) {
                                        break;
                                    } else {
                                        trace("// Unexpected token, expected parameter end.");
                                    }
                                } else {
                                    trace("// Unexpected token, expected parameters.");
                                }
                            }
                        } else {
                            trace("// Unexpected token, expected parameters.");
                            continue;
                        }
                        t = data.next();
                        
                        func.isExplicitType = (t.type == TokenType.TYPE);
                        func.type = func.isExplicitType ? t.value : "Dynamic";
                        
                        if (t.type == TokenType.TYPE) {
                            t = data.next();
                        }
                        if (t.type != TokenType.CODEBLOCK_BEGIN) {
                            trace("// Error: Unexpected token, expected codeblock: " + t);
                            break;
                        }
                        
                        while (data.hasNext()) {
                            t = data.next();
                            if (t.type == TokenType.CODEBLOCK_END) {
                                break;
                            } else {
                                trace(t);
                                break;
                            }
                        }
                        
                        trace(func);
                        attributes.reset();
                        
                    } else {
                        trace("// Error: Unexpected token, expected member name.");
                    }
                }
            } else {
                trace("// Error: Unexpected token: " + t);
            }
        }
        
        return code;
    }
    
}
