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

import net.robertboehm.hxparser.Main;


/**
 * This is a simple class.
 * 
 * @author Robert Böhm
 */
class Human {
    
    public static var myStaticField:String;
    public var myField:String;
    public var myDynamicField=5;
    public var myProperty(default, null):Int;
    private var myPrivateField:String;
    
    private function new() {}
    
    public static function myStaticFunction(abc:Int):Void { }
    public function myFunction(def:String):Void { }
    public function myDynamicFunction(ghi) { }
    private function myPrivateFunction(jkl:Float):Void { }
    
}
