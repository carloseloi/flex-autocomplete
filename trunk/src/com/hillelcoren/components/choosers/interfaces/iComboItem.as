package com.hillelcoren.components.choosers.interfaces
{
	import flash.display.DisplayObject;
	
	public interface iComboItem
	{
		function setTextFocus():void
		function contains( x:DisplayObject ):Boolean
		function isCursorAtBeginning():Boolean
		function isCursorAtEnd():Boolean;
		function isEditable():Boolean;
		function get text():String;		
	}
}