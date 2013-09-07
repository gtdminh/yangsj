package app.modules.panel.test
{
	import com.riaidea.text.RichTextField;
	
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.text.TextFormat;
	
	import app.core.Alert;
	import app.core.components.controls.combo.ComboBox;
	import app.core.components.controls.combo.ComboData;
	import app.core.components.controls.combo.ComboItemVo;
	import app.modules.LoadingEffect;
	import app.utils.appStage;
	import app.utils.log;
	
	import victor.framework.components.scroll.GameScrollPanel;
	import victor.framework.core.BasePanel;
	import victor.framework.utils.HtmlText;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-28
	 */
	public class TestView extends BasePanel
	{
		private var itemContainer:Sprite;
		private var gameScroll:GameScrollPanel;
		
		public function TestView()
		{
			
		}
		
		override protected function setSkinWithName(skinName:String):void
		{
			super.setSkinWithName( skinName );
			
			itemContainer = new Sprite();
			itemContainer.x = 55;
			itemContainer.y = 35;
			addChild( itemContainer );
			gameScroll = new GameScrollPanel();
			gameScroll.setTargetShow(itemContainer, 0, 0, 440, 330);
		}
		
		override protected function onceInit():void
		{
			super.onceInit();
			
			for (var i:int = 0; i < 24; i++)
			{
				var item:TestItem = new TestItem();
				item.setIndex( i );
				itemContainer.addChild( item );
			}
			gameScroll.updateMainHeight( itemContainer.height );
			gameScroll.setPos( 0 );
			
			var rtf:RichTextField = new RichTextField();
			rtf.x = 10;
			rtf.y = 10;
			rtf.html = true;
			rtf.setSize( 500, 50 );
			addChild(rtf);
			rtf.textfield.selectable = false;
			rtf.defaultTextFormat = new TextFormat("Arial", 20, 0x000000);
			
			rtf.textfield.addEventListener(TextEvent.LINK, linkHandler );
			
//			rtf.append( HtmlText.urlEvent("this", "yangsj", 0xff0000)+ "  is test RichTextField",[{index:5, index:5, src:"ui_test_skin"}], true);
			
			var xml:XML = 	<rtf>
							  <htmlText></htmlText>
							  <sprites>
								<sprite src="ui_test_skin" index="4"/>
							  </sprites>
							</rtf>

			xml.htmlText[0] = HtmlText.urlEvent( "this", "yangsj,victor,king", 0xff0000) + "  is RichTextField";
			
			rtf.importXML( xml );
			
			trace( rtf.exportXML() );
			
//			addEventListener( MouseEvent.CLICK, onClickHandler );
			
			var comboData:ComboData = new ComboData();
			for (i = 0; i < 10; i++)
			{
				var vo:ComboItemVo = new ComboItemVo();
				vo.label = "label_" + i;
				comboData.addItem( vo );
			}
			
			var comboBox:ComboBox = new ComboBox( comboData );
			addChild( comboBox );
			
			var comboBox1:ComboBox = new ComboBox( comboData, 100 );
			addChild( comboBox1 );
			comboBox1.x = 200;
		}
		
		protected function onClickHandler(event:MouseEvent):void
		{
			Alert.show( "希望每个单身的人都能够相信爱情，一爱再爱不要低下头，最终有情人终成眷属。", function abc( type:uint ):void{ log( type )}, "下一关" );
		}
		
		protected function clickHandler(event:MouseEvent):void
		{
			appStage.removeEventListener(MouseEvent.CLICK, clickHandler );
			LoadingEffect.hide();
		}
		
		protected function linkHandler(event:TextEvent):void
		{
			log( event.text );
		}
		
		override protected function openComplete():void
		{
			
			LoadingEffect.show();
			
			appStage.addEventListener(MouseEvent.CLICK, clickHandler );
			
			appStage.addEventListener(KeyboardEvent.KEY_DOWN, keyboardHandler );
		}
		
		override public function hide():void
		{
			super.hide();
			
			appStage.removeEventListener(KeyboardEvent.KEY_DOWN, keyboardHandler );
		}
		
		protected function keyboardHandler(event:KeyboardEvent):void
		{
			log( event.charCode, event.keyCode );
		}
		
		override protected function get skinName():String
		{
			return "test.UITestViewPanel";
		}
		
		override protected function get resNames():Array
		{
			return [ "testPanel"];
		}
		
		override protected function get domainName():String
		{
			return "testPanel";
		}
		
	}
}