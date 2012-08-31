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
 * The main class containing the entry point for hxparser.
 * 
 * @author Robert Böhm
 */
@:final
class Main {
    
    private function new() { }
    
    
    public static function main():Void {
        Sys.stdout().writeString("hxparser is not a standalone application (yet)\n");
    }
    
}
