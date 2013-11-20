package Particle.STATUS
{

	import graphic.Engine.Utils.Point3D;
	/**
	 * ...
	 * @author locke
	 */
	public class PARTICLE_STATUS extends Point3D
	{
		public var _start:Point3D = new Point3D();
		public var _end:Point3D = new Point3D();
		public var _lefttime:Number = 0 ;
		public function PARTICLE_STATUS(x:int=0,y:int=0,z:int=0) 
		{
			_start.x = x;
			_start.y = y;
			_start.z = z;
		}
		
	}

}