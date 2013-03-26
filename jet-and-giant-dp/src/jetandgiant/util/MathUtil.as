package jetandgiant.util
{
public class MathUtil
{
	public static function clamp(value:Number, min:Number, max:Number):Number
	{
		return Math.max(min, Math.min(max, value));
	}
}
}
