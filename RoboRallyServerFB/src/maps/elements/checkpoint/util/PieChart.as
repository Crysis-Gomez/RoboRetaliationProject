package maps.elements.checkpoint.util{
    
    import flash.display.*;
        
    public class PieChart extends MovieClip{
        
        public var radius:Number;
        public var autoBalance:Boolean;
        private var info:PieChartInfo;
        public var TopOffSliceLabel:String;
        private var _sliceBorderWidth:Number;
        private var _sliceBorderColor:Number;
        private var _sliceBorderAlpha:Number;
        private var _outerBorderWidth:Number;
        private var _outerBorderColor:Number;
        private var _outerBorderAlpha:Number;
        public var topOffColor:Number
        public var topOffAlpha:Number
        
        public function PieChart(){
            //default values
            radius=100;
            autoBalance=false;
            TopOffSliceLabel="Remaining"
            info=new PieChartInfo();
            _sliceBorderWidth=0;
            _sliceBorderColor=0;
            _sliceBorderAlpha=0;
            _outerBorderWidth=3;
            _outerBorderColor=1;
            _outerBorderAlpha=1;
            topOffColor=0xFFFFFF
            topOffAlpha=1
        }
        
        public function setOuterBorder(ww:Number,cc:Number,aa:Number):void{
                _outerBorderWidth=ww
                _outerBorderColor=cc
                _outerBorderAlpha=aa
        }
        
         public function setSliceBorder(ww:Number,cc:Number,aa:Number):void{
                _sliceBorderWidth=ww
                _sliceBorderColor=cc
                _sliceBorderAlpha=aa
        }
        
        public function get slices():Array{
            return info.slices;
        }
        
        public function addSlice(label:String, percentage:Number, color:Number = 0, alpha:Number = 1):void {
            var slice:PieChartSliceInfo=new PieChartSliceInfo(label,percentage);
            slice.setFill(color,alpha);
            slice.setLine(_sliceBorderWidth,_sliceBorderColor,_sliceBorderAlpha);
            info.addSlice(slice);
        }
        
        public function destroy():void{
            graphics.clear();
            while(numChildren>0){
                removeChild(getChildAt(0))
            }
        }
        
        public function draw():void{
            
            destroy();
            
            if(info.slices.length==0){
                throw ("Nothing to draw!");
            }
            
            var i:int;
            var topOffSlice:PieChartSliceInfo;
            var remainder:Number;
            var startAngle:Number=0;
            
            if(autoBalance){
                //autobalance
                info.validateSlicesSum();
            }else{
                //get remainder and create a blank slice
                remainder=info.remainingPercentage
                topOffSlice = new PieChartSliceInfo(TopOffSliceLabel, remainder);
			
                topOffSlice.setFill(topOffColor,topOffAlpha);
                topOffSlice.setLine(_sliceBorderWidth,_sliceBorderColor,_sliceBorderAlpha);
                info.addSlice(topOffSlice)
            }
            
            for(i=0;i<info.slices.length;i++){
                //draw a cakeSlice
                var cs:CakeSlice=new CakeSlice();
                addChild(cs);
				cs.mouseEnabled = false;
                cs.radius=radius;
                cs.startAngle=startAngle;
                cs.setFill(info.slices[i].getFillColor(),info.slices[i].getFillAlpha())
                cs.setLine(_sliceBorderWidth,_sliceBorderColor,_sliceBorderAlpha)
                var angle:Number=(info.slices[i].percentage*360)/100
                cs.arc=angle;
                cs.draw();
                startAngle+=angle;
            }
            
            //outer border
            var outerBorder:Sprite = new Sprite();
			outerBorder.mouseEnabled = false;
            outerBorder.graphics.lineStyle(_outerBorderWidth,_outerBorderColor,_outerBorderAlpha)
            outerBorder.graphics.drawEllipse(-radius,-radius,radius*2,radius*2)
            addChild(outerBorder)
            
        }
		
		public function removeAllSlices():void 
		{
			info.removeAllSlices();
		}
		
		public function hasSlice(label:String):Boolean
		{
			for each(var aSlice:PieChartSliceInfo in slices) {
				if (aSlice.label == label) {
					return true;
				}
			}
			return false;
		}
        //
        
    }
}