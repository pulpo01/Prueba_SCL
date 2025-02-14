/**
* Generated file - You can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/
package com.tmmas.gte.integraciongte.ejb.helper;

import java.io.Serializable;
import org.apache.commons.configuration.CompositeConfiguration;
import com.tmmas.cl.framework20.util.UtilProperty;

public class Global implements Serializable {
	private static final long serialVersionUID = 1L;
	private static Global instance;
	private CompositeConfiguration config;

	private Global() {														 
		config = UtilProperty.getConfiguration("IntegracionGte.properties", "com/tmmas/gte/integraciongte/ejb/properties/IntegracionGTEEJB.properties");
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

}