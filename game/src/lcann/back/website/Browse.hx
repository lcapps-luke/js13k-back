package lcann.back.website;
import lcann.back.website.SitePage;

/**
 * ...
 * @author Luke Cann
 */
class Browse implements SitePage {

	public function new() {
		
	}
	
	
	/* INTERFACE lcann.back.website.SitePage */
	
	public function load(site:Site) {
		var page:String = "";
		
		for(i in 0...3){
			var html:String = Main.getHtml("project-preview.html");
			var img:String = Main.getImg("book");
			html = replaceAll(html, [
				"{name}" => "Something 4 you", 
				"{current}" => "500", 
				"{target}" => "10000", 
				"{remain}" => "10 days", 
				"{creator}" => "Dodgy Bob", 
				"{country}" => "Suspicioustan", 
				"{img}" => img]);
			page += html;
		}
		
		site.setBodyContent(page);
	}
	
	private function replaceAll(html:String, repl:Map<String, String>){
		var res = html;
		for(r in repl.keys()){
			res = StringTools.replace(res, r, repl.get(r));
		}
		return res;
	}
	
}