package maps.elements.player.base
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import gui.player.PlayerElement;
	import logger.Logger;
	import maps.elements.base.BoardElement;
	import maps.Map;
	import maps.Node;
	import models.connection.GetDamage;
	import models.connection.LoseDamage;
	import models.data.CardData;
	import models.data.PlayerData;
	import models.data.RobotData;
	import particles.ParticleManager;
	import screens.Playscreen;
	import screens.WinScreen;
	import utils.TutorialManager;
	
	/**
	 * ...
	 * @author ...
	 */
	public class PlayerBoardElement extends Sprite
	{
		private var _playerData:PlayerData;
		
		public var map:Map;
		public var checkPoint:Node;
		private var _destroyed:Boolean;
		public var aPlayerHud:PlayerElement;
		public var checkPoints:Array = new Array();
		private var _playerAction:PlayerActions;
		private var roundBox:Sprite;
		private var point:Sprite;
		private var pickups:Array = new Array();
		
		public function PlayerBoardElement(playerData:PlayerData)
		{
			_playerAction = new PlayerActions(this);
			
			_playerData = playerData;
			
			roundBox = new Sprite();
			addChild(roundBox);
			roundBox.x = -20;
			roundBox.y = 20;
			
			point = new Sprite();
			addChild(point);
			point.x = 5;
			point.y = -20;
			
			point.rotation = 45;
			
			roundBox.rotation = -90;
			draw();
			
			
			
		}
		
		private function draw():void
		{
			roundBox.graphics.beginFill(GlobalConstants.COLORS[playerData.id - 1]);
			roundBox.graphics.drawRoundRectComplex(0, 0, 40, 24, 20, 20, 0,0);
			point.graphics.beginFill(GlobalConstants.COLORS[playerData.id - 1]);
			point.graphics.drawRect(0, 0, Math.sqrt(20 * 20 + 20 * 20), Math.sqrt(20 * 20 + 20 * 20));
			
			
			var bitmap:Bitmap = new (GameData.robots[playerData.robotID] as RobotData).topimage;
			
			bitmap.x -= 20;
			bitmap.y += 20;
			
			bitmap.rotation = -90;
			addChild(bitmap);
		}
		
		public function initiate(map:Map, node:Node, aPlayerHud:PlayerElement):void
		{
			this.aPlayerHud = aPlayerHud;
			this.map = map;
			playerAction.setMap(map);
			this.x = node.xPos * 60 + 60 / 2;
			this.y = node.yPos * 60 + 60 / 2;
			
			playerAction.registerRobotToNode();
			setCheckPoint();
			
			
			
			map.addChild(this);
			Logger.getInstance().log("Adding " + playerData.id + " " + playerData.name + "to the board");
		}
		
		public function destroy():void
		{
			map.removeChild(this);
			Logger.getInstance().log("Removing " + playerData.id + " " + playerData.name + "from the board");
		}
		
		
		
		public function restore():void
		{
			x = checkPoint.xPos * 60 + 60 / 2;
			y = checkPoint.yPos * 60 + 60 / 2;
			rotation = 0;
			if (GlobalConstants.TUTORIAL_PLAY) {
				rotation = TutorialManager.getInstance().getDirection(playerData);
			}
			playerAction.registerRobotToNode();
			destroyed = false;
			
			trace("Restoring");
		}
		
		public function setCheckPoint():void
		{
			if (checkPoint != null) 
				checkPoint.removeRegisterMark(this);
			checkPoint = _playerAction.currentNode;
			checkPoint.addRegisterMark(this);
		
		}
		
		private function hasCheckPoint(id:int):Boolean
		{
			for each (var aCheckPoint:int in checkPoints)
			{
				if (aCheckPoint == id)
				{
					return true;
				}
			}
			return false;
		}
		
		public function addCheckPoint(id:int):void
		{
		
				checkPoints.push(id);
				
				if (GlobalConstants.TUTORIAL_PLAY) {
					_playerData.stageCount++;
					(map.game.currentScreen as screens.Playscreen).updateText(playerData.stageCount);
					
					if (_playerData.stageCount < 3) aPlayerHud.visible = false;
					else aPlayerHud.visible = true;
					//TutorialConstants.CURRENTSTAGE++;
				}
		
			
		}
		
		public function resolveCheckPoint(id:int):void
		{
			if (id == 0)
			{
				if (!hasCheckPoint(id))
				{
					 addCheckPoint(id);
				}
			}
			else
			{
				if (hasCheckPoint(id - 1) && !hasCheckPoint(id))
				{
					addCheckPoint(id);
				}
			}
		}
		
		public function addPickUp(pickup:BoardElement):void 
		{
			//Should be overwritten
		}
		
		public function doDamage():void
		{
			
			playerData.damage++;
			ParticleManager.getInstance().spawnLaserParticles(this.map, 10, new Point(this.x, this.y));
			
			if (playerData.damage >= 10) {
				destroyed = true;
				for (var i:int = 0; i < map.nodes.length; i++) 
				{
					for (var j:int = 0; j < (map.nodes[i] as Array).length; j++) 
					{
						var _node:Node = map.nodes[i][j];
						if (_node.robot != null) {
							_node.robot = null;
							break;
						}
					}
				}
				playerData.damage = 2;
			}
			
		}
		
		public function doRepair(value:Number):void
		{
			playerData.damage -= value
			
			if (playerData.damage <= 0) {
				playerData.damage = 0;
			}
		}
		
		public function get destroyed():Boolean
		{
			return _destroyed;
		}
		
		public function set destroyed(value:Boolean):void
		{
			_destroyed = value;
			if (_destroyed)
			{
				if(!GlobalConstants.TUTORIAL_PLAY)playerData.lives--;
				
				visible = false;
				(map.game.currentScreen as screens.Playscreen).Tutorial.text = "Destroyed robots will respawn on their last checkpoint.";
			}
			else
			{
				visible = true;
			}
		
		}
		
		public function get playerAction():PlayerActions 
		{
			return _playerAction;
		}
		
		public function get playerData():PlayerData 
		{
			return _playerData;
		}
	
	}

}