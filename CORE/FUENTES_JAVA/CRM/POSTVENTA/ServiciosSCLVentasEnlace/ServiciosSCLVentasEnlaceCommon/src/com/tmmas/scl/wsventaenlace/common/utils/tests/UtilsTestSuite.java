package com.tmmas.scl.wsventaenlace.common.utils.tests;

import junit.framework.Test;
import junit.framework.TestSuite;

public class UtilsTestSuite
{
    public static Test suite() 
    {
        TestSuite suite = new TestSuite();
  
        suite.addTestSuite(ValidacionesTest.class);
        
        return suite;
    }

    public static void main(String[] args) 
    {
        junit.textui.TestRunner.run(suite());
    }
}
