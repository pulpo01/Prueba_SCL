package com.tmmas.scl.framework.commonDoman.common.helper;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.util.MessageResourcesConfig;

public abstract class GlobalBase {

	private final Logger logger = Logger.getLogger(this.getClass());
	protected MessageResourcesConfig recurso;
	protected Properties defaultProp=new Properties();
    private String archivoPropertiesDefault="/com/tmmas/scl/default.properties";
	private String path; //Ruta base del container
	private static final String regex="jndi.*acade|url\\..*|security.principal|security.credentials";
	//permite reconocer jndi.AnuSinFacade,url.AnuSinProvider

	protected GlobalBase(){		
		logger.debug("Nothing");
	}
	protected GlobalBase(String archivoRecurso) {
		logger.debug("REGEX="+regex);
		this.recurso = new MessageResourcesConfig(archivoRecurso);
		logger.debug("Recurso ok");
		path=System.getProperty("user.dir");
		java.io.FileInputStream fis=null;
		try {
			fis = new java.io.FileInputStream
			(new java.io.File( path + archivoPropertiesDefault));
			defaultProp.load(fis);	 
		} catch (FileNotFoundException e) {
			logger.debug(e.getMessage());
			//e.printStackTrace();
		} catch (IOException e) {
			logger.debug(e.getMessage());
			//e.printStackTrace();
		}
		
		
	}

	public MessageResourcesConfig getMessageResourcesConfig() {
		return this.recurso;
	}

	public String getValor(String valorClave) {
		if(!valorClave.matches(regex)){
			logger.debug(valorClave +" NOMATCH ");
			String valor = this.recurso.obtenerValorClave(valorClave);
			return valor;
		}else{
			logger.debug(valorClave+" MATCH ");
			String valor = this.defaultProp.getProperty(valorClave);
			return valor;			
		}
	}
		
}
