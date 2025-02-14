package com.tmmas.scl.doblecuenta.businessobject.dao.test;

import java.io.IOException;

import javax.naming.NamingException;

import junit.framework.TestCase;

import com.javaranch.unittest.helper.sql.pool.JNDIUnitTestHelper;

public abstract class BaseTest extends TestCase {
	public BaseTest(){
		init();
	}
	protected void init(){
		try {
			if(JNDIUnitTestHelper.notInitialized()){
				JNDIUnitTestHelper.init("com/tmmas/scl/doblecuenta/businessobject/dao/test/jndi_unit_test_helper.properties");
			}
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
