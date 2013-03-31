package jetandgiant.model
{
public class ObjectPool
{
	private var pool:Array;
	public function ObjectPool(classRef:Class, count:int)
	{
		pool = [];
		while(count-- > 0)
		{
			pool.push(new classRef());
		}
	}

	public function getObject():*
	{
		return pool.pop();
	}

	public function returnObject(object:*):void
	{
		pool.push(object);
	}
}
}
