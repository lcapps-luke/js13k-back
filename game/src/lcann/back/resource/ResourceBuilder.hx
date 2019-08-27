package lcann.back.resource;

#if macro
import sys.FileSystem;
import sys.io.File;
import haxe.macro.Context;
import haxe.io.Path;
#end

/**
 * ...
 * @author Luke Cann
 */
class ResourceBuilder {
	private inline static var htmlPath:String = "res/html/";
	private inline static var htmlMinPath:String = "build/res/html-min/";
	private inline static var imagePath:String = "res/img/";
	private inline static var imageMinPath:String = "build/res/img-min/";

	macro public static function build() {
		cleanDir(htmlMinPath);
		cleanDir(imageMinPath);
		
		var html:Array<Pair> = buildHtmlMap();
		var img:Array<Pair> = buildImgMap();
		
		// Construct resource type
		var c = macro class R {
			public var html:Array<lcann.back.resource.Pair> = $v { html };
			public var img:Array<lcann.back.resource.Pair> = $v { img };
			public function new() {};
		}

		Context.defineType(c);

		return macro new R();
	}
	
	#if macro
	
	private static function buildHtmlMap():Array<Pair>{
		var map:Array<Pair> = new Array<Pair>();

		for (f in FileSystem.readDirectory(htmlPath)){
			Sys.command("html-minifier", [
						"--collaspse-boolean-attributes",
						"--collapse-inline-tag-whitespace",
						"--collapse-whitespace",
						//"--decode-entities",
						"--html5",
						"--minify-css",
						"--minify-js",
						"--remove-attribute-quotes",
						"--remove-comments",
						"--remove-empty-attributes",
						"--remove-optional-tags",
						"--remove-redundant-attributes",
						"--use-short-doctype",
						"-o", htmlMinPath + f,
						htmlPath + f]);
			
			map.push({k: f, v: File.getContent(htmlMinPath + f)});
		}
		
		return map;
	}
	
	private static function buildImgMap():Array<Pair>{
		var map:Array<Pair> = new Array<Pair>();
		
		Sys.command("svgo", [
					"-f", imagePath,
					"-o", imageMinPath,
					"-p", "0",
					"--enable", "removeTitle",
					"--enable", "removeDesc",
					"--enable", "removeUselessDefs",
					"--enable", "removeEditorsNSData",
					"--enable", "removeViewBox",
					"--enable", "transformsWithOnePath"]);
		
		for (f in FileSystem.readDirectory(imageMinPath)) {
			var path:Path = new Path(imageMinPath + f);
			if (path.ext == "svg") {
				map.push({
					k: path.file,
					v: File.getContent(path.toString())
				});
			}
		}
		
		return map;
	}
	
	private static function cleanDir(dir){
		FileSystem.createDirectory(dir);
		
		for (f in FileSystem.readDirectory(dir)) {
			if(!FileSystem.isDirectory(dir + f)) {
				FileSystem.deleteFile(dir + f);
			}
		}
	}
	
	#end
}