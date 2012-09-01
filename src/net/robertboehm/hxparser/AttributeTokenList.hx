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
class AttributeTokenList {
    
    public var isPublic:Bool = false;
    public var isPrivate:Bool = false;
    public var isStatic:Bool = false;
    public var isInline:Bool = false;

    public function new() {
    }
    
    public function applyToken(t:Token):Void {
        switch(t.value) {
            case "public":
                isPublic = true;
                isPrivate = false;
            case "private":
                isPrivate = true;
                isPublic = false;
            case "static":
                isStatic = true;
            case "inline":
                isInline = true;
            default:
        }
    }
    
    public function reset():Void {
        isPublic = false;
        isPrivate = false;
        isStatic = false;
        isInline = false;
    }
    
}
