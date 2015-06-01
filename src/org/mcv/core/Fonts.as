package org.mcv.core
{
	import flash.text.Font;
	
	/**
	 * ...
	 * @author Matthew C. Valverde
	 */
	
	public class Fonts
	{
		// OpenSans-Regular.ttf
		[Embed(source="../../../../lib/fonts/OpenSans-Regular.ttf",fontName='OpenSans',fontFamily='font',fontWeight='normal',fontStyle='normal',mimeType='application/x-font-truetype',advancedAntiAliasing='true',embedAsCFF='false',unicodeRange='U+0020-U+002F,U+0030-U+0039,U+003A-U+0040,U+0041-U+005A,U+005B-U+0060,U+0061-U+007A,U+007B-U+007E')]
		public static var OpenSans:Class;
		Font.registerFont(OpenSans);
		
		// OpenSans-Bold.ttf
		[Embed(source="../../../../lib/fonts/OpenSans-Bold.ttf",fontName='OpenSansBold',fontFamily='font',fontWeight='normal',fontStyle='normal',mimeType='application/x-font-truetype',advancedAntiAliasing='true',embedAsCFF='false',unicodeRange='U+0020-U+002F,U+0030-U+0039,U+003A-U+0040,U+0041-U+005A,U+005B-U+0060,U+0061-U+007A,U+007B-U+007E')]
		public static var OpenSansBold:Class;
		Font.registerFont(OpenSansBold);
	}
}