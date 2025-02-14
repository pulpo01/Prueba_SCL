package com.tmmas.scl.serviciospostventasiga.common.helper;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.Serializable;
import java.util.Properties;
import java.util.ResourceBundle;

import com.tmmas.cl.framework.base.JndiForDataSource;

public class Global implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private ResourceBundle recurso = null;
	private JndiForDataSource jndiForDataSource = null;
	private JndiForDataSource jndiDS =null;
	private static Global instance = null;
		
	/**
	 * Constructor en el cual se defina la propiedad que identifica el nombre del com.tmmas.scl.serviciospostventasiga.common.properties externo. 
	 * 
	 */
	private Global() {

		final String archivoRecurso = this.getValorExterno("GE.properties.interno.GE");
		this.recurso = ResourceBundle.getBundle(archivoRecurso);
	}

	public static synchronized Global getInstance() {
		if (instance == null) {
			instance = new Global();
		}
		return instance;
	}

	public String getValor(String valorClave) {
		try{
			String valor = this.recurso.getString(valorClave);
			return valor;
		}catch(Exception e){
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
			propFile = new FileInputStream(System.getProperty("user.dir") + "/properties/ServiciosPostVentaSigaExt.properties");
			propertieExterno.load(propFile);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return propertieExterno.getProperty(str);
	}
	
}
