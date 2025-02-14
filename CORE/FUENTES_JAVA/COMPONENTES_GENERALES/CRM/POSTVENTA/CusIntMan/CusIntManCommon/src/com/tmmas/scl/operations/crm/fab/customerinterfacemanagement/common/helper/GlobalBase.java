package com.tmmas.scl.operations.crm.fab.customerinterfacemanagement.common.helper;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.Serializable;
import java.util.Properties;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.util.MessageResourcesConfig;
//import com.tmmas.scl.operations.crm.fab.cusintman.web.helper.SecurityHandler;

public abstract class GlobalBase {

	protected MessageResourcesConfig recurso;
	protected String rutaRecurso;
	protected Properties defaultProp=new Properties();
    private Logger logger = Logger.getLogger(GlobalBase.class);
	private String archivoPropertiesDefault="/com/tmmas/scl/default.properties";
	private String path; //Ruta base del container
	private static final String regex="jndi.*acade|url\\..*|security.principal|security.credentials";
	//permite reconocer jndi.AnuSinFacade,url.AnuSinProvider

	protected GlobalBase(){
		System.out.println("Nothing");
	}
	protected GlobalBase(String archivoRecurso) {
		//System.out.println("REGEX="+regex);
		rutaRecurso = archivoRecurso;
		this.recurso = new MessageResourcesConfig(archivoRecurso);
		//System.out.println("Recurso ok");
		path=System.getProperty("user.dir");
		java.io.FileInputStream fis=null;
		try {
			fis = new java.io.FileInputStream
			(new java.io.File( path + archivoPropertiesDefault));
			defaultProp.load(fis);	 
		} catch (FileNotFoundException e) {
			System.out.println(e.getMessage());
			//e.printStackTrace();
		} catch (IOException e) {
			System.out.println(e.getMessage());
			//e.printStackTrace();
		}
		
		
	}

	public MessageResourcesConfig getMessageResourcesConfig() {
		return this.recurso;
	}

	public String getValor1(String valorClave) {
		if(!valorClave.matches(regex)){
			//System.out.println(valorClave +" NOMATCH ");
			String valor = this.recurso.obtenerValorClave(valorClave);
			return valor;
		}else{
			//System.out.println(valorClave+" MATCH ");
			String valor = this.defaultProp.getProperty(valorClave);
			return valor;			
		}
	}
	public String getValor(String valorClave) {
		String valor = null;
		try
		{
			if(!valorClave.matches(regex)){
				printMessage(valorClave +" NOMATCH ");
				valor = this.recurso.obtenerValorClave(valorClave);
				if(valor == null || valor == "")
				{
					logger.debug("<@><@><@><@><@><@> No se encuentra en (RutaRecurso) "+rutaRecurso+" el valor de "+valorClave);
				}
			}else{
				printMessage(valorClave+" MATCH ");
				valor = this.defaultProp.getProperty(valorClave);
				if(valor == null || valor == "")
				{
					logger.debug("<@><@><@><@><@><@> No se encuentra en (ArchPrpDefault) "+archivoPropertiesDefault+" el valor de "+valorClave);
					
				}			
			}
			
			if(valor == null || valor == "")
			{
				valor = this.recurso.obtenerValorClave(valorClave);
				logger.debug("<@><@><@><@><@><@> Se busca en properties original (RutaRecurso) "+rutaRecurso+" "+valorClave+":"+valor);
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
			logger.debug("GlobalBase.getValor "+e.getMessage());
			logger.debug("GlobalBase.getValor "+e.getClass());
			StackTraceElement[] t = e.getStackTrace();
			StackTraceElement tw = null;
			for(int i=0;i<t.length;i++)
			{
				tw = t[i];
				logger.debug("GlobalBase.getValor "+tw.toString());
			}
		}
		return valor;
	}
	
	protected void printMessage(String cadena) {
		String valor="SI";//getValor("mostrar.log");
		if ("SI".equals(valor))
			//System.out.println(cadena);
			logger.debug(cadena);
		
	};	
}
