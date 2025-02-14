package com.tmmas.scl.wsventaenlace.common.utils.tests;

import junit.framework.Assert;
import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestSuite;

import com.tmmas.scl.wsventaenlace.common.utils.Validaciones;

public class ValidacionesTest extends TestCase
{
/*
	public static final int VAL_OK = 1;
	public static final int VAL_ERROR_NULO = 2;
	public static final int VAL_ERROR_LARGO = 3;
	public static final int VAL_ERROR_FORMATO = 4;
 */
	
	public void testEsStringValido()
	{
		try
		{
			System.out.println("Validaciones.esStringValido(null, true, 1, 8)");
			System.out.println("VAL_OK");
			Assert.assertTrue(Validaciones.esStringValido(null, true, 1, 8) == Validaciones.VAL_OK);
			System.out.println("VAL_ERROR_FORMATO");
			Assert.assertFalse(Validaciones.esStringValido(null, true, 1, 8) == Validaciones.VAL_ERROR_FORMATO);
			System.out.println("VAL_ERROR_LARGO");
			Assert.assertFalse(Validaciones.esStringValido(null, true, 1, 8) == Validaciones.VAL_ERROR_LARGO);
			System.out.println("VAL_ERROR_NULO");
			Assert.assertFalse(Validaciones.esStringValido(null, true, 1, 8) == Validaciones.VAL_ERROR_NULO);
			
			System.out.println("Validaciones.esStringValido(\"\", true, 1, 8)");
			System.out.println("VAL_OK");
			Assert.assertTrue(Validaciones.esStringValido("", true, 1, 8) == Validaciones.VAL_OK);	
			System.out.println("VAL_ERROR_FORMATO");
			Assert.assertFalse(Validaciones.esStringValido("", true, 1, 8) == Validaciones.VAL_ERROR_FORMATO);	
			System.out.println("VAL_ERROR_LARGO");
			Assert.assertFalse(Validaciones.esStringValido("", true, 1, 8) == Validaciones.VAL_ERROR_LARGO);	
			System.out.println("VAL_ERROR_NULO");
			Assert.assertFalse(Validaciones.esStringValido("", true, 1, 8) == Validaciones.VAL_ERROR_NULO);	
			
			System.out.println("Validaciones.esStringValido(null, false, 1, 8)");
			System.out.println("VAL_ERROR_NULO");
			Assert.assertTrue(Validaciones.esStringValido(null, false, 1, 8) == Validaciones.VAL_ERROR_NULO);	
			System.out.println("VAL_ERROR_FORMATO");
			Assert.assertFalse(Validaciones.esStringValido(null, false, 1, 8) == Validaciones.VAL_ERROR_FORMATO);	
			System.out.println("VAL_ERROR_LARGO");
			Assert.assertFalse(Validaciones.esStringValido(null, false, 1, 8) == Validaciones.VAL_ERROR_LARGO);	
			System.out.println("VAL_OK");
			Assert.assertFalse(Validaciones.esStringValido(null, false, 1, 8) == Validaciones.VAL_OK);	
			
			System.out.println("Validaciones.esStringValido(\"\", false, 1, 8)");
			System.out.println("VAL_ERROR_NULO");
			System.out.println(Validaciones.esStringValido("", false, 1, 8));
			Assert.assertTrue(Validaciones.esStringValido("", false, 1, 8) == Validaciones.VAL_ERROR_NULO);	
			System.out.println("VAL_ERROR_FORMATO");
			Assert.assertFalse(Validaciones.esStringValido("", false, 1, 8) == Validaciones.VAL_ERROR_FORMATO);	
			System.out.println("VAL_ERROR_LARGO");
			Assert.assertFalse(Validaciones.esStringValido("", false, 1, 8) == Validaciones.VAL_ERROR_LARGO);	
			System.out.println("VAL_OK");
			Assert.assertFalse(Validaciones.esStringValido("", false, 1, 8) == Validaciones.VAL_OK);	
			
			System.out.println("Validaciones.esStringValido(\"\", false, 1, 8)");
			System.out.println("VAL_ERROR_LARGO");
			Assert.assertTrue(Validaciones.esStringValido("", false, 1, 8) == Validaciones.VAL_ERROR_LARGO);	
			System.out.println("VAL_ERROR_NULO");
			Assert.assertFalse(Validaciones.esStringValido("", false, 1, 8) == Validaciones.VAL_ERROR_NULO);	
			System.out.println("VAL_ERROR_FORMATO");
			Assert.assertFalse(Validaciones.esStringValido("", false, 1, 8) == Validaciones.VAL_ERROR_FORMATO);	
			System.out.println("VAL_OK");
			Assert.assertFalse(Validaciones.esStringValido("", false, 1, 8) == Validaciones.VAL_OK);	
			
			System.out.println("Validaciones.esStringValido(\"12\", true, 1, 8)");
			System.out.println("VAL_OK");
			Assert.assertTrue(Validaciones.esStringValido("12", true, 1, 8) == Validaciones.VAL_OK);	
			System.out.println("VAL_ERROR_LARGO");
			Assert.assertFalse(Validaciones.esStringValido("12", true, 1, 8) == Validaciones.VAL_ERROR_LARGO);	
			System.out.println("VAL_ERROR_FORMATO");
			Assert.assertFalse(Validaciones.esStringValido("12", true, 1, 8) == Validaciones.VAL_ERROR_FORMATO);	
			System.out.println("VAL_ERROR_NULO");
			Assert.assertFalse(Validaciones.esStringValido("12", true, 1, 8) == Validaciones.VAL_ERROR_NULO);	
			
			System.out.println("Validaciones.esStringValido(\"123456789\", true, 1, 8)");
			System.out.println("VAL_ERROR_LARGO");
			Assert.assertTrue(Validaciones.esStringValido("123456789", true, 1, 8) == Validaciones.VAL_ERROR_LARGO);			
			System.out.println("VAL_OK");
			Assert.assertFalse(Validaciones.esStringValido("123456789", true, 1, 8) == Validaciones.VAL_OK);			
			System.out.println("VAL_ERROR_FORMATO");
			Assert.assertFalse(Validaciones.esStringValido("123456789", true, 1, 8) == Validaciones.VAL_ERROR_FORMATO);			
			System.out.println("VAL_ERROR_NULO");
			Assert.assertFalse(Validaciones.esStringValido("123456789", true, 1, 8) == Validaciones.VAL_ERROR_NULO);			
		}
		catch(Throwable t)
		{
			Assert.fail("Falla indebida");
		}
	}
	
	//TODO: por terminar!!!
	public void testEsFechaValida()
	{
		try
		{
			System.out.println("Validaciones.esFechaValida(null, true, \"dd/MM/yyyy\"");
			System.out.println("VAL_OK");
			Assert.assertTrue(Validaciones.esFechaValida(null, true, "dd/MM/yyyy") == Validaciones.VAL_OK);
			System.out.println("VAL_ERROR_FORMATO");
			Assert.assertFalse(Validaciones.esFechaValida(null, true, "dd/MM/yyyy") == Validaciones.VAL_ERROR_FORMATO);
			System.out.println("VAL_ERROR_LARGO");
			Assert.assertFalse(Validaciones.esFechaValida(null, true, "dd/MM/yyyy") == Validaciones.VAL_ERROR_LARGO);
			System.out.println("VAL_ERROR_NULO");
			Assert.assertFalse(Validaciones.esFechaValida(null, true, "dd/MM/yyyy") == Validaciones.VAL_ERROR_NULO);
			
			System.out.println("Validaciones.esFechaValida(\"\", true, \"dd/MM/yyyy\"");
			System.out.println("VAL_OK");
			Assert.assertTrue(Validaciones.esFechaValida("", true, "dd/MM/yyyy") == Validaciones.VAL_OK);	
			System.out.println("VAL_ERROR_FORMATO");
			Assert.assertFalse(Validaciones.esFechaValida("", true, "dd/MM/yyyy") == Validaciones.VAL_ERROR_FORMATO);	
			System.out.println("VAL_ERROR_LARGO");
			Assert.assertFalse(Validaciones.esFechaValida("", true, "dd/MM/yyyy") == Validaciones.VAL_ERROR_LARGO);	
			System.out.println("VAL_ERROR_NULO");
			Assert.assertFalse(Validaciones.esFechaValida("", true, "dd/MM/yyyy") == Validaciones.VAL_ERROR_NULO);	
			
			System.out.println("Validaciones.esFechaValida(null, false, \"dd/MM/yyyy\"");
			System.out.println("VAL_ERROR_NULO");
			Assert.assertTrue(Validaciones.esFechaValida(null, false, "dd/MM/yyyy") == Validaciones.VAL_ERROR_NULO);	
			System.out.println("VAL_ERROR_FORMATO");
			Assert.assertFalse(Validaciones.esFechaValida(null, false, "dd/MM/yyyy") == Validaciones.VAL_ERROR_FORMATO);	
			System.out.println("VAL_ERROR_LARGO");
			Assert.assertFalse(Validaciones.esFechaValida(null, false, "dd/MM/yyyy") == Validaciones.VAL_ERROR_LARGO);	
			System.out.println("VAL_OK");
			Assert.assertFalse(Validaciones.esFechaValida(null, false, "dd/MM/yyyy") == Validaciones.VAL_OK);	
			
			System.out.println("Validaciones.esFechaValida(\"\", false, \"dd/MM/yyyy\")");
			System.out.println("VAL_ERROR_NULO");
			Assert.assertTrue(Validaciones.esFechaValida("", false, "dd/MM/yyyy") == Validaciones.VAL_ERROR_NULO);	
			System.out.println("VAL_ERROR_FORMATO");
			Assert.assertFalse(Validaciones.esFechaValida("", false, "dd/MM/yyyy") == Validaciones.VAL_ERROR_FORMATO);	
			System.out.println("VAL_ERROR_LARGO");
			Assert.assertFalse(Validaciones.esFechaValida("", false, "dd/MM/yyyy") == Validaciones.VAL_ERROR_LARGO);	
			System.out.println("VAL_OK");
			Assert.assertFalse(Validaciones.esFechaValida("", false, "dd/MM/yyyy") == Validaciones.VAL_OK);	
			
			System.out.println("Validaciones.esFechaValida(\"12/11/20\", false, \"dd/MM/yyyy\")");
			System.out.println("VAL_ERROR_LARGO");
			Assert.assertTrue(Validaciones.esFechaValida("12/11/20", false, "dd/MM/yyyy") == Validaciones.VAL_ERROR_LARGO);	
			System.out.println("VAL_ERROR_NULO");
			Assert.assertFalse(Validaciones.esFechaValida("12/11/20", false, "dd/MM/yyyy") == Validaciones.VAL_ERROR_NULO);	
			System.out.println("VAL_ERROR_FORMATO");
			Assert.assertFalse(Validaciones.esFechaValida("12/11/20", false, "dd/MM/yyyy") == Validaciones.VAL_ERROR_FORMATO);	
			System.out.println("VAL_OK");
			Assert.assertFalse(Validaciones.esFechaValida("12/11/20", false, "dd/MM/yyyy") == Validaciones.VAL_OK);	
			
			System.out.println("Validaciones.esFechaValida(\"12/12/2009\", true, \"dd/MM/yyyy\")");
			System.out.println("VAL_OK");
			Assert.assertTrue(Validaciones.esFechaValida("12/12/2009", true, "dd/MM/yyyy") == Validaciones.VAL_OK);	
			System.out.println("VAL_ERROR_LARGO");
			Assert.assertFalse(Validaciones.esFechaValida("12/12/2009", true, "dd/MM/yyyy") == Validaciones.VAL_ERROR_LARGO);	
			System.out.println("VAL_ERROR_FORMATO");
			Assert.assertFalse(Validaciones.esFechaValida("12/12/2009", true, "dd/MM/yyyy") == Validaciones.VAL_ERROR_FORMATO);	
			System.out.println("VAL_ERROR_NULO");
			Assert.assertFalse(Validaciones.esFechaValida("12/12/2009", true, "dd/MM/yyyy") == Validaciones.VAL_ERROR_NULO);	
			
			System.out.println("Validaciones.esFechaValida(\"12/12/2009\", false, \"dd/MM/yyyy\")");
			System.out.println("VAL_OK");
			Assert.assertTrue(Validaciones.esFechaValida("12/12/2009", false, "dd/MM/yyyy") == Validaciones.VAL_OK);	
			System.out.println("VAL_ERROR_LARGO");
			Assert.assertFalse(Validaciones.esFechaValida("12/12/2009", false, "dd/MM/yyyy") == Validaciones.VAL_ERROR_LARGO);	
			System.out.println("VAL_ERROR_FORMATO");
			Assert.assertFalse(Validaciones.esFechaValida("12/12/2009", false, "dd/MM/yyyy") == Validaciones.VAL_ERROR_FORMATO);	
			System.out.println("VAL_ERROR_NULO");
			Assert.assertFalse(Validaciones.esFechaValida("12/12/2009", false, "dd/MM/yyyy") == Validaciones.VAL_ERROR_NULO);	
			
			System.out.println("Validaciones.esFechaValida(\"12/XX/2009\", true, \"dd/MM/yyyy\")");
			System.out.println("VAL_OK");
			Assert.assertTrue(Validaciones.esFechaValida("12/XX/2009", true, "dd/MM/yyyy") == Validaciones.VAL_OK);	
			System.out.println("VAL_ERROR_LARGO");
			Assert.assertFalse(Validaciones.esFechaValida("12/XX/2009", true, "dd/MM/yyyy") == Validaciones.VAL_ERROR_LARGO);	
			System.out.println("VAL_ERROR_FORMATO");
			Assert.assertFalse(Validaciones.esFechaValida("12/XX/2009", true, "dd/MM/yyyy") == Validaciones.VAL_ERROR_FORMATO);	
			System.out.println("VAL_ERROR_NULO");
			Assert.assertFalse(Validaciones.esFechaValida("12/XX/2009", true, "dd/MM/yyyy") == Validaciones.VAL_ERROR_NULO);	
		}
		catch(Throwable t)
		{
			Assert.fail("Falla indebida");
		}
	}
	
	protected void setUp() 
	{ 
	}	
	
    protected void tearDown() 
    {
    }
	
	public static Test suite() 
	{ 
		return new TestSuite(ValidacionesTest.class); 
    } 
	
	public static void main(String args[])
	{
		
	}
}
