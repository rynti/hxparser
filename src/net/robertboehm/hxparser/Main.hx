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

import haxe.Log;
import haxe.PosInfos;
import net.robertboehm.hxparser.data.Codeblock;
import net.robertboehm.hxparser.data.File;
import net.robertboehm.hxparser.data.Function;
import net.robertboehm.hxparser.data.Member;
import net.robertboehm.hxparser.data.PropertyVisibility;
import net.robertboehm.hxparser.data.Type;
import net.robertboehm.hxparser.data.TypeField;
import net.robertboehm.hxparser.data.TypeFunction;
import net.robertboehm.hxparser.data.TypeMember;
import net.robertboehm.hxparser.data.TypeProperty;
import net.robertboehm.hxparser.data.Visibility;
import net.robertboehm.hxparser.HaxeEnvironment;
import net.robertboehm.hxparser.Human;
import net.robertboehm.hxparser.HxParser;
import net.robertboehm.hxparser.Parser;
import net.robertboehm.hxparser.Preprocessor;
import net.robertboehm.hxparser.StringReader;
import net.robertboehm.hxparser.Token;
import net.robertboehm.hxparser.Tokenizer;
import net.robertboehm.hxparser.TokenList;
import net.robertboehm.hxparser.TokenType;


/**
 * The main class containing the entry point for hxparser.
 * 
 * @author Robert Böhm
 */
@:final
class Main {
    
    private function new() { }
    
    public static function myTrace(v:Dynamic, ?inf:PosInfos):Void {
        if (inf != null)
            Sys.stdout().writeString(inf.fileName + ":" + inf.lineNumber + ": ");
        Sys.stdout().writeString(Std.string(v) + "\n");
        Sys.stdout().flush();
    }
    
    
    public static function main():Void {
        Log.trace = myTrace;
        
        Sys.stdout().writeString("hxparser is not a standalone application (yet)\n");
        
        var rawData:String = sys.io.File.getContent("src/net/robertboehm/hxparser/Human.hx");
        var processedData:String = new Preprocessor().parse(rawData);
        var tokens:TokenList = new Tokenizer().parse(processedData);
        var file:File = new Parser().parse(tokens);
        trace(file.packagePath);
        trace("Imports:");
        for (i in file.imports) {
            trace("  " + i);
        }
        
        /*
        var Type_Void:Type = new Type();
        var Type_Main:Type = new Type();
        var TypeFunction_Main_main:TypeFunction = new TypeFunction();
        var Codeblock_Main:Codeblock = new Codeblock();
        var Codeblock_Main_main:Codeblock = new Codeblock();
        
        Type_Void.name = "Void";
        
        Type_Main.packagePath = "";
        Type_Main.name = "Main";
        Type_Main.isInterface = false;
        Type_Main.parent = null;
        Type_Main.interfaces = [];
        Type_Main.codeblock = Codeblock_Main;
        
        TypeFunction_Main_main.name = "main";
        TypeFunction_Main_main.parent = Codeblock_Main;
        TypeFunction_Main_main.visibility = Visibility.PUBLIC;
        TypeFunction_Main_main.type = Type_Void;
        TypeFunction_Main_main.isExplicitType = true;
        TypeFunction_Main_main.isStatic = true;
        TypeFunction_Main_main.base = null;
        TypeFunction_Main_main.code = Codeblock_Main_main;
        
        Codeblock_Main.file = "Main.hx";
        Codeblock_Main.children = [TypeFunction_Main_main.code];
        Codeblock_Main.members = [TypeFunction_Main_main];
        
        Codeblock_Main_main.file = "Main.hx";
        Codeblock_Main_main.children = [];
        Codeblock_Main_main.members = [];
        */
    }
    
}
