package particles
{
	import flash.geom.Point;
	import maps.Map;
	/**
	 * ...
	 * @author Jerry
	 */
	

	public class ParticleManager 
	{
		static private var instance:ParticleManager;
		
		public function ParticleManager(caller:Function= null) 
		{
			if (caller != ParticleManager.getInstance)
				throw new Error("Singleton is a singleton class, use getInstance() instead");
			if (ParticleManager.instance != null)
				throw new Error("Only one Singleton instance should be instantieted");
				
		}
		
		static public function getInstance():ParticleManager
		{
			if (instance == null)
				instance = new ParticleManager(arguments.callee);
			return instance;
		}
		
		public function spawnLaserParticles(map:Map,lenght:int,position:Point):void 
		{
			
			for (var i:int = 0; i < lenght; i++) 
			{
				var particle:Particle = new Particle();
				var particle2:Particle = new Particle();
				var particle3:Particle = new Particle();
				particle.alpha = 1;
				particle.initialize(map, 20, position, new Point(Math.floor(Math.random() * -3 + Math.random()*2.5), Math.floor(Math.random() * -2.5 + Math.random()*2.5)), 0x555555,3);
				particle2.initialize(map, 20, position, new Point(Math.floor(Math.random() * -2.5 + Math.random() * 2.5), Math.floor(Math.random() * -2.5 + Math.random() * 2.5)), 0x444444, 3);
				particle3.initialize(map, 10, position, new Point(Math.floor(Math.random() * -2 + Math.random() * 2), Math.floor(Math.random() * -2 + Math.random() * 2)), 0xAA0000, 2.5);

				

			}
			
		}

	}

}