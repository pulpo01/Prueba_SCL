/*
 * Created on 12-may-2010
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package com.tmmas.scl.wsportal.businessobject.dao.testunit;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 * @author Administrador
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class GetConnection {
    public Connection getDBDatasource() {
    	Connection conn = null;
    	//DataSource ds = null;
   		 try{
   		 	Class.forName("oracle.jdbc.driver.OracleDriver");
  		 	String url = "jdbc:oracle:thin:@172.28.8.11:1565:DEIMOS_NICPAN";
   		    conn = DriverManager.getConnection(url,"NIC_10002_SCL","DES_10002_SCL");
   		 }catch(Exception e)
		 {
   		 	System.out.println(e);
   		 	conn=null;
   	    	//ds=null;
		 }
    	return conn;
    }
}
