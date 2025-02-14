package com.tmmas.cl.scl.direccion.presentacion.helper;

import java.util.Collection;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.Properties;
import java.util.StringTokenizer;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.util.MessageResourcesConfig;

public abstract class GlobalBase {

	protected MessageResourcesConfig recurso;
	protected String rutaRecurso;
	protected Properties defaultProp=new Properties();
    private Logger logger = Logger.getLogger(GlobalBase.class);
	private String archivoPropertiesDefault="/com/tmmas/scl/general/Direccion.properties";
	private String path; //Ruta base del container
	//private static final String regex="jndi.*acade|url\\..*|security.principal|security.credentials";
	//private static final String regex="jndi.*|url\\..*|security.principal|security.credentials";
	
	private static String regex1="jndi.*acade|url\\..*|security.principal|security.credentials|initial.context.factory|DireccionEJB.log";
	private static String regex = regex1+"|jndi.*acadeSTL";


	protected GlobalBase(){
		printMessage("Nothing");
	}
	protected GlobalBase(String archivoRecurso) {
		printMessage("REGEX="+regex);
		
		/*
		 * @author : pvargas
		 * @date : 28-11-2008
		 * @description : Se agrega if para usar el properties de producto, eso funciona cuando es invocado de la instancia de producto
		 * 
		 */
		
		String defaultPDTProp = "";
		StringTokenizer st = new StringTokenizer(archivoRecurso,"|");
		int indiceSeparador = archivoRecurso.indexOf("|");
		if(indiceSeparador > -1)
		{
			logger.debug("archivoRecurso "+archivoRecurso);
			try {
				defaultPDTProp = archivoRecurso.substring(indiceSeparador+1,archivoRecurso.length());
				archivoRecurso = archivoRecurso.substring(0,indiceSeparador);
				archivoPropertiesDefault = defaultPDTProp;
			} catch (Exception e) {
				logger.debug("Exception archivoRecurso "+e.getMessage());
				e.printStackTrace();
			}
		}

		/****pv 281108 fin****/
		
		rutaRecurso = archivoRecurso;
		this.recurso = new MessageResourcesConfig(archivoRecurso);
		printMessage("Recurso ok");
		path=this.getPathInstancia();
		
		java.io.FileInputStream fis=null;
		try {
			fis = new java.io.FileInputStream
			(new java.io.File( path + archivoPropertiesDefault));
			defaultProp.load(fis);
			try {
				Enumeration enu = defaultProp.propertyNames();
				Collection col = defaultProp.values();
				String propname = null;
				String propval = null;
				Iterator it = col.iterator();
				while(enu.hasMoreElements())
				{
					propname = (String)enu.nextElement();
					propval = (String)it.next();
					logger.debug(propname+"  "+propval);
				}
			}
			catch(Exception e)
			{
				e.printStackTrace();
				logger.debug("defaultProp.propertyNames() "+e.getMessage());
				logger.debug("defaultProp.propertyNames() "+e.getClass());
				StackTraceElement[] t = e.getStackTrace();
				StackTraceElement tw = null;
				for(int i=0;i<t.length;i++)
				{
					tw = t[i];
					logger.debug("defaultProp.propertyNames() "+tw.toString());
				}
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
			logger.debug("GlobalBase(ARec) "+e.getMessage());
			logger.debug("GlobalBase(ARec) getClass "+e.getClass());
			StackTraceElement[] t = e.getStackTrace();
			StackTraceElement tw = null;
			for(int i=0;i<t.length;i++)
			{
				tw = t[i];
				logger.debug("GlobalBase(ARec) "+tw.toString());
			}
		}
		/*catch (FileNotFoundException e) {
			printMessage(e.getMessage());
			//e.printStackTrace();
		} catch (IOException e) {
			printMessage(e.getMessage());
			//e.printStackTrace();
		}*/
		
		
	}

	public MessageResourcesConfig getMessageResourcesConfig() {
		return this.recurso;
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
				//printMessage(valorClave+" MATCH ");
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
	
	public String getPathInstancia(){
		//logger.debug ("getPathInstancia():start");
		String ruta="";
		String oracleHome="";
		String weblogicHome="";
		String nameInstancia="home";
		try{
			
			//logger.debug("oracleHome : antes");
			oracleHome=System.getProperty("oracle.home");
			
			/*logger.debug("oracleHome : "+oracleHome);
			logger.debug("oracleHome : despues");
			
			logger.debug("nameInstancia : antes");
			//nameInstancia=System.getProperty("oracle.oc4j.instancename");
			logger.debug("nameInstancia : "+nameInstancia);
			logger.debug("nameInstancia : despues");
			
			logger.debug("ruta : antes");
			
			logger.debug("weblogicHome : antes");*/
			weblogicHome=System.getProperty("weblogic.home");
			//logger.debug("weblogicHome1 : "+weblogicHome);
			
			weblogicHome=System.getProperty("weblogic.system.home");
			//logger.debug("weblogicHome2 : "+weblogicHome);
			
			//String home = System.getProperty("user.home"); 
			//logger.debug("home : "+home);
			
			ruta=oracleHome+"/j2ee/"+nameInstancia;
			
			if(oracleHome == null || "".equals(oracleHome))
			{
				ruta=System.getProperty("user.dir");
				logger.debug("ruta user.dir : "+ruta);
			}
		}
		catch(Exception e){
			logger.debug("Exception:: "+e);
		}
		finally{
			if (nameInstancia==null){
				logger.debug("nameInstancia es null");
				ruta=System.getProperty("user.dir");
				logger.debug("ruta::"+ruta);
			}
		}
		
		//logger.debug ("getPathInstancia():end");
		return ruta;
	}
}
