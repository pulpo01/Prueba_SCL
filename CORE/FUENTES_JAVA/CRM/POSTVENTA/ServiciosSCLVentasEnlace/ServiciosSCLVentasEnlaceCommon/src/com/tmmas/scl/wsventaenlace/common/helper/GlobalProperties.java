
package com.tmmas.scl.wsventaenlace.common.helper;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;
import java.util.ResourceBundle;

import com.tmmas.cl.framework.base.JndiForDataSource;

public class GlobalProperties {
	private ResourceBundle recurso = null;
	
	private JndiForDataSource jndiForDataSource = null;
    private JndiForDataSource jndiDS =null;
	private static GlobalProperties instance = null;

	
	// --------------------------------------------------------------------------
	private GlobalProperties() {
		Properties propertieExterno = new Properties();
		FileInputStream propFile = null;
		try {
			propFile = new FileInputStream(System.getProperty("user.dir") + "/Properties/VentaEnlaceValidaciones.properties");
			propertieExterno.load(propFile);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		final String archivoRecurso =propertieExterno.getProperty("GE.properties.interno.GE");
		recurso = ResourceBundle.getBundle(archivoRecurso);
	}

	// --------------------------------------------------------------------------
	public static synchronized GlobalProperties getInstance() {
		if (instance == null) {
			instance = new GlobalProperties();
		}
		return instance;
	}

	public String getValor(String valorClave) {
		try{
		String valor = this.recurso.getString(valorClave);
		return valor;
		}catch (Exception e) {
			return null;
		}
	}
	public JndiForDataSource getJndiForDataSource(String nombreJndi) {
		if (jndiForDataSource == null) {
			jndiForDataSource = new JndiForDataSource();
			jndiForDataSource.setJndiDataSource(this.getValorExterno(nombreJndi));
		}
		return jndiForDataSource;
	}
	
	/**
	 * 
	 * @param nombreJndi
	 * @param newDS true instancia un nuevo JndiForDataSource
	 * @return un objeto JndiForDataSource
	 * 02/09/2008 17:32:01
	 * @author Santiago Ventura
	 */
	public JndiForDataSource getJndiForDataSource(String nombreJndi, boolean newDS) {
		if (newDS && jndiDS==null) {			
			jndiDS = new JndiForDataSource();
			jndiDS.setJndiDataSource(this.getValor(nombreJndi));
		} 
		return jndiDS;
	}
	
	public String getValorExterno(String str) {
		Properties propertieExterno = new Properties();
		FileInputStream propFile = null;
		try {
			propFile = new FileInputStream(System.getProperty("user.dir") + "/Properties/VentaEnlaceValidaciones.properties");
			propertieExterno.load(propFile);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return propertieExterno.getProperty(str);
	}

}
