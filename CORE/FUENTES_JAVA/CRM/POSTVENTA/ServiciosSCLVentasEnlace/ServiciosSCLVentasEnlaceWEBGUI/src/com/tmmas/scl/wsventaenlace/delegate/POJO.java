/**
 * @(#)POJO.java 2008
 *
 * Copyright 2008 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 */

package com.tmmas.scl.wsventaenlace.delegate;

import java.util.Enumeration;
import java.util.Iterator;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletContext;

import org.apache.axis2.context.ServiceContext;

import com.tmmas.scl.wsventaenlace.common.exception.ServicioVentasEnlaceException;
import com.tmmas.scl.wsventaenlace.common.helper.GlobalProperties;
import com.tmmas.scl.wsventaenlace.common.helper.LoggerHelper;
import com.tmmas.scl.wsventaenlace.helper.GeneraIDTransaccion;
import com.tmmas.scl.wsventaenlace.sender.Sender;
import com.tmmas.scl.wsventaenlace.transport.dto.OOSSDTO;
import com.tmmas.scl.wsventaenlace.transport.dto.OOSSFase2DTO;

public class POJO {

	protected static LoggerHelper logger = LoggerHelper.getInstance();
	protected GlobalProperties global = GlobalProperties.getInstance();
	private final String nombreClase = this.getClass().getName();

	protected void setObjetoContexto(OOSSDTO oossdto, ServletContext context) throws Exception {
		String idTransaccion = String.valueOf(GeneraIDTransaccion.getIDTransaccion());
		logger.debug("setObjetoContexto():idTransaccion:" + idTransaccion, nombreClase);
		oossdto.setNumTransaccion(idTransaccion);
		context.setAttribute(idTransaccion, oossdto);
		limpiarContexto(context);
	}

	protected OOSSDTO getObjetoContexto(String idTransaccion, ServletContext context) throws Exception {
		OOSSDTO oossdto = null;
		logger.debug("getObjetoContexto():idTransaccion" + idTransaccion, nombreClase);
		if (context.getAttribute(idTransaccion) != null) {
			oossdto = (OOSSDTO) context.getAttribute(idTransaccion);
		} else {
			logger.debug("No se encontro el objeto en el contexto", nombreClase);
			throw new ServicioVentasEnlaceException("ERR.0004", 4, global.getValor("ERR.0004"));
		}
		return oossdto;
	}

	/**
	 * Metodo utilizado para eliminar del contexto objetos obsoletos
	 * 
	 * @param ServiceContext
	 * @author Luis Bautista
	 * @return void
	 * @throws Exception
	 */

	protected void limpiarContexto(ServletContext context) throws Exception {
		
		try {
			// obtengo valor del tiempo maximo de vida en el contexto
			String tiempoencontexto = global.getValorExterno("GE.maxencontexto");
			/*
			 * Obtengo todas las keys del contexto para transformar a long y comparar con tiempo maximo de vida permitido para el contexto que obtuvimos desde el properties en el paso anterior
			 */

			// Iterator hash = (Iterator)contex.getPropertyNames();
			Enumeration enume = context.getAttributeNames();
			// transformo el tiempo maximo de vida de string a long
			long maxencontexto = (new Long(tiempoencontexto)).longValue();
			// itero sobre el arreglo de valores obtenidos desde el contexto

			while (enume.hasMoreElements()) {
				String key = (String) enume.nextElement();
				// me aseguro de obtener solo las keys numericas
				Pattern p = Pattern.compile("[0-9]+");
				Matcher m = p.matcher(key);
				boolean resultado = m.find();
				if (resultado)
					if (maxencontexto < (java.util.GregorianCalendar.getInstance().getTimeInMillis() - ((new Long(key.trim())).longValue()))) {
						context.removeAttribute(key);						
					}
			}

		} catch (Exception e) {
			logger.debug("limpiarContexto", nombreClase);

		}
	}

	protected void limpiarContexto(ServiceContext contex) throws Exception {
		try {
			// obtengo valor del tiempo maximo de vida en el contexto
			String tiempoencontexto = global.getValorExterno("GE.maxencontexto");
			/*
			 * Obtengo todas las keys del contexto para transformar a long y comparar con tiempo maximo de vida permitido para el contexto que obtuvimos desde el properties en el paso anterior
			 */
			Iterator hash = (Iterator) contex.getPropertyNames();
			// transformo el tiempo maximo de vida de string a long
			long maxencontexto = (new Long(tiempoencontexto)).longValue();
			// itero sobre el arreglo de valores obtenidos desde el contexto
			while (hash.hasNext()) {
				String key = (String) hash.next();
				// me aseguro de obtener solo las keys numericas
				Pattern p = Pattern.compile("[0-9]+");
				Matcher m = p.matcher(key);
				boolean resultado = m.find();
				if (resultado)
					if (maxencontexto < (java.util.GregorianCalendar.getInstance().getTimeInMillis() - ((new Long(key.trim())).longValue()))) {
						contex.removeProperty(key);
					}
			}

		} catch (Exception e) {
			logger.debug("limpiarContexto", nombreClase);

		}
	}

	protected void sendMessage(OOSSFase2DTO oossdto) throws ServicioVentasEnlaceException {
		Sender sender = new Sender();
		sender.send(oossdto);
	}
}
