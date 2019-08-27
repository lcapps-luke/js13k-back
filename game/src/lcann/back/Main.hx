package lcann.back;
import lcann.back.resource.ResourceBuilder;
import js.Browser;
import js.html.DivElement;
import lcann.back.website.Browse;
import lcann.back.website.Site;

/**
 * ...
 * @author Luke Cann
 */
class Main {
	private static var r(default, null) = ResourceBuilder.build();
	
	private static var view:DivElement;

	public static function main() {
		view = cast Browser.window.document.getElementsByClassName("view")[0];
		//view.innerHTML = r.html[0].v;
		
		var site:Site = new Site();
		var browse:Browse = new Browse();
		site.gotoPage(browse);
	}
	
	public static function getHtml(name:String):String{
		for (i in r.html){
			if (i.k == name){
				return i.v;
			}
		}
		return "";
	}
	
	public static function getImg(name:String):String{
		for(i in r.img){
			if(i.k == name){
				return i.v;
			}
		}
		return "";
	}
	
	public static function clearView()
	{
		view.innerHTML = r.html[0].v;
	}
	
	public static function setView(html:String)
	{
		view.innerHTML = html;
	}
	
}