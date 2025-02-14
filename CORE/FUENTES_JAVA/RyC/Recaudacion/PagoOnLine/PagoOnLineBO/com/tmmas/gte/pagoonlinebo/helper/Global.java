/**
* Generated file - You can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/
package com.tmmas.gte.pagoonlinebo.helper;

import java.io.Serializable;
import com.tmmas.cl.framework20.util.JndiProperties;
import org.apache.commons.configuration.CompositeConfiguration;
import com.tmmas.cl.framework20.util.UtilProperty;

public class Global implements Serializable {
	private static final long serialVersionUID = 1L;
	private static Global instance;
	private CompositeConfiguration config;
	private JndiProperties jndiDataSource0 = null;

	private Global() {
		config = UtilProperty.getConfiguration("PagoOnLine.properties", "com/tmmas/gte/pagoonlinebo/properties/PagoOnLineBO.properties");
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
			jndiDataSource0.setFactoryInitial(this.getValor("initial.factory"));
			jndiDataSource0.setProviderUrl(this.getValor("url.provider"));
			jndiDataSource0.setSecurityPrincipal(this.getValor("security.principal"));
			jndiDataSource0.setSecurityCredentials(this.getValor("security.credentials"));
			jndiDataSource0.setUsaJndideOtraJVM(new java.lang.Boolean(this.getValor("usa.jndi.de.otra.JVM")).booleanValue());
		}
		return jndiDataSource0;
	}

}