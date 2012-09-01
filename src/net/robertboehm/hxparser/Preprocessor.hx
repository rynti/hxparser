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
 * The preprocessor of hxparser. Currently not doing anything.
 * 
 * @author Robert Böhm
 */
class Preprocessor {

    public function new() { }
    
    
    public function parse(data:String):String {
        // Preprocessor must not remove comments, as they may be useful for documentation!
        // TODO: Conditional instructions (#if, #else, etc.)
        // TODO: Translating character index to preprocessed string character index
        return data;
        
        /*
        var buffer:StringBuf = new StringBuf();
        var isComment:Bool = false;
        var i:Int = 0;
        while (i < data.length) {
            if (isComment) {
                if (i + 1 < data.length && data[i] == "*" && data[i + 1] == "/") {
                    // End a multi-line comment:
                    isComment = false;
                    i++;
                    
                }
            } else {
                if (i + 1 < data.length && data[i] == "/" && data[i + 1] == "*") {
                    // Start a multi-line comment:
                    isComment = true;
                    i++;
                    
                } else if (i + 1 < data.length && data[i] == "/" && data[i + 1] == "/") {
                    // On single line comment, ignore until line break:
                    while (i < data.length) {
                        if (data[++i] == "\n")
                            break;
                    }
                    
                } else {
                    // By default, just copy the character to the new buffer:
                    buffer.addChar(data.charCodeAt(i));
                    
                }
                
            }
            i++;
        }
        return buffer.toString();
        */
    }
    
}
