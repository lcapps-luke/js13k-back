package lcann.pack;

import sys.FileSystem;
import sys.io.File;

/**
 * ...
 * @author Luke Cann
 */
class FileAccumulator {

	public static function getAllContentFromFolder(dir:String):String {
		var content:String = "";
		
		for (f in FileSystem.readDirectory(dir)) {
			content += File.getContent(dir + "/" + f);
		}
		
		return content;
	}
	
}