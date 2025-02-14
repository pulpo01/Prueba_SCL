package com.tmmas.cl.scl.customerdomain.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dao.RegistroSolicitudesDAO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.RegistroSolicitudesDTO;

public class RegistroSolicitudes {
	
	RegistroSolicitudesDAO registroSolicitudesDAO = new RegistroSolicitudesDAO();
	
	
	private static Category cat = Category.getInstance(RegistroSolicitudes.class);
	
	/**
	 * Crea solicitud de aprobación del rango de descuento asociado al vendedor en una venta. 
	 * @param registroSolicitudes
	 * @return 
	 * @throws CustomerDomainException
	 */
	public void crearSolicitud (RegistroSolicitudesDTO registroSolicitudes) throws CustomerDomainException {
		cat.debug("crearSolicitud():start");
		registroSolicitudesDAO.crearSolicitud(registroSolicitudes);
		cat.debug("crearSolicitud():end");
	}
	
	/**
	 * Consulta solicitud de aprobación de descuento. 
	 * @param registroSolicitudes
	 * @return 
	 * @throws CustomerDomainException
	 */
	public RegistroSolicitudesDTO consultaEstadoSolicitud(RegistroSolicitudesDTO registroSolicitudes) throws CustomerDomainException {
		cat.debug("consultaEstadoSolicitud():start");
		registroSolicitudes = registroSolicitudesDAO.consultaEstadoSolicitud(registroSolicitudes);
		cat.debug("consultaEstadoSolicitud():end");
		return registroSolicitudes;
	}

}
