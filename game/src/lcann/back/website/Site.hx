package lcann.back.website;
import js.html.DivElement;
import js.Browser;

/**
 * ...
 * @author Luke Cann
 */
class Site {
	private var body:DivElement;

	public function new() {
		var containerHtml:String = Main.getHtml("site-container.html");
		Main.setView(containerHtml);
		
		body = cast Browser.window.document.getElementsByClassName("body")[0];
	}
	
	public function setBodyContent(html:String){
		body.innerHTML = html;
	}
	
	public function gotoPage(page:SitePage){
		page.load(this);
	}
	
}