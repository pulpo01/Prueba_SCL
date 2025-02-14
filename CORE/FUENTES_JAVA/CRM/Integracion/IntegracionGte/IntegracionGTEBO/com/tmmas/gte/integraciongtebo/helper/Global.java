/**
* Generated file - You can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/
package com.tmmas.gte.integraciongtebo.helper;

import java.io.Serializable;
import com.tmmas.cl.framework20.util.JndiProperties;
import org.apache.commons.configuration.CompositeConfiguration;
import com.tmmas.cl.framework20.util.UtilProperty;

public class Global implements Serializable {
	private static final long serialVersionUID = 1L;
	private static Global instance;
	private CompositeConfiguration config;
	private JndiProperties jndiDataSource0 = null;
	private JndiProperties jndiDataSource1 = null;

	
	private Global() {
		config = UtilProperty.getConfiguration("IntegracionGte.properties", "com/tmmas/gte/integraciongtebo/properties/IntegracionGTEBO.properties");
	}

	public static synchronized Global getInstance() {
		if (instance == null) {
			instance = new Global();
		}
		return instance;
	}

	/**
	 * Obtiene una propiedad del archivo de propiedades
	 * @param key
	 * @return
	 */
	public String getValor(String key) {
		return config.getString(key);
	}

	/**
	* Obtiene el jndi i-esimo
	* @return
	*/
	public JndiProperties getJndiForDataSource0(){
		if (jndiDataSource0 == null) {
			jndiDataSource0 = new JndiProperties();
			jndiDataSource0.setJndi(this.getValor("jndiDataSource0"));
			jndiDataSource0.setFactoryInitial(this.getValor("initial.context.factory")); /*initial.factory*/
			jndiDataSource0.setProviderUrl(this.getValor("url.IntegracionGTEWSSTLProvider")); /*url.provider*/
			jndiDataSource0.setSecurityPrincipal(this.getValor("security.principal"));
			jndiDataSource0.setSecurityCredentials(this.getValor("security.credentials"));
			jndiDataSource0.setUsaJndideOtraJVM(new java.lang.Boolean(this.getValor("usa.jndi.de.otra.JVM")).booleanValue());
		}
		return jndiDataSource0;
	}
	/**
	* Obtiene el jndi i-esimo
	* @return
	*/
	public JndiProperties getJndiForDataSource1(){
		if (jndiDataSource1 == null) {
			jndiDataSource1 = new JndiProperties();
			jndiDataSource1.setJndi(this.getValor("jndiDataSource1"));
			jndiDataSource1.setFactoryInitial(this.getValor("initial.context.factory")); /*initial.factory*/
			jndiDataSource1.setProviderUrl(this.getValor("url.IntegracionGTEWSSTLProvider")); /*url.provider*/
			jndiDataSource1.setSecurityPrincipal(this.getValor("security.principal"));
			jndiDataSource1.setSecurityCredentials(this.getValor("security.credentials"));
			jndiDataSource1.setUsaJndideOtraJVM(new java.lang.Boolean(this.getValor("usa.jndi.de.otra.JVM")).booleanValue());
		}
		return jndiDataSource1;
	}

}