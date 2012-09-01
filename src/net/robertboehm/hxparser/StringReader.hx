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
class StringReader {
    
    public var content(default, null):String;
    
    public var counter(default, null):Int;
    
    
    public function new(content:String) {
        this.content = content;
        this.counter = 0;
    }
    
    
    public function peekChar():String {
        return content.charAt(counter);
    }
    
    public function peekCharCode():Int {
        return content.charCodeAt(counter);
    }
    
    public function nextChar():String {
        return content.charAt(counter++);
    }
    
    public function nextCharCode():Int {
        return content.charCodeAt(counter++);
    }
    
    public function skipWhitespace():Bool {
        var ch:String;
        var c:Int = 0;
        while(hasNext()) {
            ch = peekChar();
            if (ch == " " || ch == "\t" || ch == "\n" || ch == "\r") {
                c++;
                nextChar();
            } else {
                break;
            }
        }
        return c > 0;
    }
    
    public function readUntil(filter:EReg, remove:Bool = false, include:Bool = false):String {
        var buffer:StringBuf = new StringBuf();
        var ch:String;
        while (hasNext()) {
            ch = peekChar();
            if (filter.match(ch)) {
                if (include) buffer.add(peekChar());
                if (remove) nextChar();
                break;
            } else {
                buffer.add(nextChar());
            }
        }
        return buffer.toString();
    }
    
    public function readOnlyGroups(filter:EReg):EReg {
        var buffer:StringBuf = new StringBuf();
        var hasMatched:Bool = false;
        
        while (hasNext()) {
            if (!hasMatched) {
                buffer.add(nextChar());
                if (filter.match(buffer.toString())) {
                    hasMatched = true;
                }
            } else if (filter.match(buffer.toString() + peekChar())) {
                buffer.add(nextChar());
            } else {
                break;
            }
        }
        filter.match(buffer.toString());
        return filter;
    }
    
    public function readOnly(filter:EReg):String {
        var buffer:StringBuf = new StringBuf();
        var hasMatched:Bool = false;
        
        while (hasNext()) {
            if (!hasMatched) {
                buffer.add(nextChar());
                if (filter.match(buffer.toString())) {
                    hasMatched = true;
                }
            } else if (filter.match(buffer.toString() + peekChar())) {
                buffer.add(nextChar());
            } else {
                break;
            }
        }
        return buffer.toString();
    }
    
    public function revert(length:Int):Void {
        counter -= length;
    }
    
    public function hasNext():Bool {
        return counter < content.length;
    }
    
}
