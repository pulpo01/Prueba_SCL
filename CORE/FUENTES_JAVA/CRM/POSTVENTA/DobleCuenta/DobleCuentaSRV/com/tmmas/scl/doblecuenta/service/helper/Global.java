package com.tmmas.scl.doblecuenta.service.helper;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.Serializable;
import java.util.Properties;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.util.MessageResourcesConfig;

public class Global implements Serializable{
	private static final long serialVersionUID = 1L;

	private MessageResourcesConfig recurso;
	private Properties recursoExterno = new Properties();
	

	private static Global instance;

	private static Logger logger = Logger.getLogger(Global.class);

	private final String archivoRecurso = "com.tmmas.scl.doblecuenta.service.properties.service";

	// --------------------------------------------------------------------------
	private Global() {
		this.recurso = new MessageResourcesConfig(archivoRecurso);
		String path = System.getProperty("user.dir") +"/"+recurso.obtenerValorClave("url.properties.externo");
		FileInputStream propFile = null;
		try {
			System.out.println("path:"+path);
			propFile = new FileInputStream(path);
			recursoExterno.load(propFile);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	// --------------------------------------------------------------------------
	public static synchronized Global getInstance() {
		if (instance == null) {
			instance = new Global();
		}
		return instance;
	}

	public MessageResourcesConfig getMessageResourcesConfig() {
		return this.recurso;
	}

	public String getValor(String valorClave) {
		String valor = recursoExterno.getProperty(valorClave);
		return valor;
	}
	
	public String getJndiFactory()
	{
		return this.recurso.obtenerValorClave("jndi.Factory");
	}	
	
	public String getJndiQueueOrdenServicio()
	{
		return this.recurso.obtenerValorClave("queue.OrdenServicio");
	}

}
