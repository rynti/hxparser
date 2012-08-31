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
 * Represents one type. This could be either a class, typedef or struct.
 * Example: class Human {}
 * 
 * @author Robert Böhm
 */
class Type {
    
    public var packagePath:String;
    public var name:String;
    
    public var isPublic:Bool;
    public var isInterface:Bool;
    
    public var parent:Type;
    public var interfaces:Array<Type>;
    
    public var codeblock:Codeblock;
    
    
    public function new() {
        
    }
    
}
