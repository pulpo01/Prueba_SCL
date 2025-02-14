package com.tmmas.scl.wsportal.common.helper;

public class Util
{
	public static final boolean enArray(String[] array, String s)
	{
		for (int i = 0; i < array.length; i++)
		{
			String string = array[i];
			if (string.equals(s))
			{
				return true;
			}
		}
		return false;
	}
}
