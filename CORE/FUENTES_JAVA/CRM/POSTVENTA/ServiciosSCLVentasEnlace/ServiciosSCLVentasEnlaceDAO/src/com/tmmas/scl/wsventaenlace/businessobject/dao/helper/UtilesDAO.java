package com.tmmas.scl.wsventaenlace.businessobject.dao.helper;

import java.beans.Introspector;
import java.beans.PropertyDescriptor;

import com.tmmas.scl.wsventaenlace.common.helper.LoggerHelper;


public class UtilesDAO {
	
	private final LoggerHelper logger = LoggerHelper.getInstance();
	private final String nombreClase = this.getClass().getName(); 
	

	public void imprimirPropiedades(Class clazz, Object obj, String metodo) {
		try {
			PropertyDescriptor[] pd = Introspector.getBeanInfo(clazz).getPropertyDescriptors();
	        for (int i = 0; i < pd.length; i++) {
	              System.out.println(pd[i].getReadMethod().getName()+": "+pd[i].getReadMethod().invoke(obj, null));
	              logger.info("DAO ["+this.getClass().getName()+"] METODO["+metodo+"] CLASE["+clazz.getName()+"] "+ pd[i].getReadMethod().getName()+": "+pd[i].getReadMethod().invoke(obj, null), nombreClase);
	        }
		}catch(Exception e){
			
		}
	}

}
