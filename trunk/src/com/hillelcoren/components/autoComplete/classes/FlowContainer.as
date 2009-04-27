package com.hillelcoren.components.autoComplete.classes
{
	/**
	 * This class was written by Eric Cancil
	 * http://blog.appdivision.com/2009/02/18/flex-flowcontainer/
	 */
	
    import flash.display.DisplayObject;
    
    import mx.collections.ArrayCollection;
    import mx.containers.Canvas;
    import mx.core.UIComponent;
    
    [Style(name="verticalGap", type="Number", inherit="no")]
    [Style(name="horizontalGap", type="Number", inherit="no")]
    
    public class FlowContainer extends Canvas
    {
        private var _direction:String;
        private var rowHeights:ArrayCollection;
        private var columnWidths:ArrayCollection;
                
        public function set direction(val:String):void{
            _direction = val;
            if(_direction == FlowContainerLayout.HORIZONTAL){
                verticalScrollPolicy = "auto";
                horizontalScrollPolicy = "off"
            }else{
                verticalScrollPolicy = "off";
                horizontalScrollPolicy = "auto"
            }
            invalidateDisplayList();
        }
        
        public function get direction():String{
            return _direction;
        }
        
        public function FlowContainer()
        {
            super();
        }
        
        private function initStyles():void{
            if(_direction == null)direction = FlowContainerLayout.HORIZONTAL;
        }
        
        override public function initialize():void{
            super.initialize();
            rowHeights = new ArrayCollection();
            columnWidths = new ArrayCollection();
            initStyles();
        }
        
        override protected function childrenCreated():void{
            super.childrenCreated();
            
            initStyles();
        }
        
        override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void{
            super.updateDisplayList(unscaledWidth, unscaledHeight);
            var prevTallest:Number = 0;
            var prevWidest:Number = 0;
            var tallestForRow:Number = 0;
            var rowNumber:Number = -1;    
            var widestForColumn:Number = 0;
            var columnNumber:Number = -1;        
            
            for(var i:Number = 0; i < numChildren; i ++){
                var child:UIComponent = getChildAt(i) as UIComponent;
                if(_direction == FlowContainerLayout.HORIZONTAL){
                    if(child.height >= tallestForRow){
                        prevTallest = tallestForRow;
                        tallestForRow = child.height;
                    }
                    if(i ==0){
                        child.x = child.y = 0;
                    }else{
                        var prevChild:DisplayObject = getChildAt(i - 1);
                        var newWidth:Number = prevChild.width + prevChild.x + getStyle("horizontalGap");
                        var newHeight:Number = prevChild.y + getStyle("verticalGap");
                        if(newWidth + child.minWidth > width){
                            child.x = 0;
                            if(child.height == tallestForRow){
                                child.y = newHeight + prevTallest;
                                //trace(prevTallest+" - prevTallest");  ---------
                            }else{
                                child.y = newHeight + tallestForRow;
                                //trace(tallestForRow+" - tallestForRow");
                            }
                            tallestForRow = child.height;                            
                        }else{
                            child.x = newWidth;
                            child.y = prevChild.y;
                        }
                    }
                }else{
                    if(child.width >= widestForColumn){
                        prevWidest = widestForColumn;
                        widestForColumn = child.width;
                    }
                    if(i ==0 ){
                        child.x = child.y = 0;
                    }else{
                        prevChild = getChildAt(i - 1);
                        newWidth = prevChild.x + getStyle("horizontalGap");
                        newHeight = prevChild.height + prevChild.y + getStyle("verticalGap");
                        if(newHeight + child.height > height){
                            child.y = 0;
                            if(child.width == widestForColumn){
                                child.x = newWidth + prevWidest;
                            }else{
                                child.x = newWidth + widestForColumn;
                            }
                            widestForColumn = child.width;
                        }else{
                            child.x = prevChild.x;
                            child.y = newHeight;
                        }
                    }
                }
            }
        }
        
    }
}