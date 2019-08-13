package lcann.pack;

import haxe.Template;
import sys.FileSystem;
import sys.io.File;

/**
 * ...
 * @author Luke Cann
 */
class Main {
	private static inline var finalDir:String = "build/final/";
	private static inline var finalUncompressedDir:String = finalDir + "uncompressed/";
	private static inline var finalMinifiedDir:String = finalDir + "min/";
	private static inline var packageFile:String = finalDir + "back.zip";

	public static function main() {
		clean();
		build();
		minify();
		pack();
	}
	
	private static function clean() {
		FileSystem.createDirectory(finalUncompressedDir);
		FileSystem.createDirectory(finalMinifiedDir);
		
		function cleanDir(dir){
			
			for (f in FileSystem.readDirectory(dir)) {
				if(!FileSystem.isDirectory(dir + f)) {
					FileSystem.deleteFile(dir + f);
				}
			}
		}
		
		cleanDir(finalMinifiedDir);
		cleanDir(finalUncompressedDir);
		cleanDir(finalDir);
	}
	
	private static function build()
	{
		var pageTemplate:String = File.getContent("res/index.html");
		var script:String = File.getContent("build/Back.js");
		
		var tpl:Template = new Template(pageTemplate);
		var out:String = tpl.execute({src: script});
		
		File.saveContent(finalUncompressedDir + "index.html", out);
	}
	
	private static function minify()
	{
		Sys.command("html-minifier", [
						"--collaspse-boolean-attributes",
						"--collapse-inline-tag-whitespace",
						"--collapse-whitespace",
						"--decode-entities",
						"--html5",
						"--minify-css",
						"--minify-js",
						"--remove-attribute-quotes",
						"--remove-comments",
						"--remove-empty-attributes",
						"--remove-optional-tags",
						"--remove-redundant-attributes",
						"--use-short-doctype",
						"-o", finalMinifiedDir + "index.html",
						finalUncompressedDir + "index.html"]);
	}
	
	private static function pack()
	{
		Sys.command("7z", ["a", packageFile, "./" + finalMinifiedDir + "*"]);
		
		var bytes:Int = FileSystem.stat(packageFile).size;
		trace(Std.string(bytes / 1024) + " / 13kb bytes used!");
	}
}