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

package net.robertboehm.hxparser.data;


/**
 * Represents a function of a type.
 * Example (Inside a class): function doSomething() {}
 * 
 * @author Robert Böhm
 */
class TypeFunction extends TypeMember {
    
    public var base:Function;
    public var code:Codeblock;
    public var parameters:Array<Member>;
    
    
    public function new() {
        super();
        
        parameters = new Array<Member>();
    }
    
    
    override public function toString():String {
        return Std.string(visibility).toLowerCase() + " " + (isStatic ? "static " : "") + "function " + name + "(" + parameters.join(", ") + "):" + type;
    }
    
}
