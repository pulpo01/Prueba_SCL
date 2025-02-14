package com.tmmas.cl.scl.integracionsicsa.bo;

import com.tmmas.cl.scl.integracionsicsa.common.dto.CorreoDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.DatosCorreoDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.GrupoCorreosDTO;
import com.tmmas.cl.scl.integracionsicsa.common.exception.IntegracionSICSAException;
import com.tmmas.cl.scl.integracionsicsa.dao.GeneralDAO;

public class GeneralBO extends IntegracionSICSABO {

	private GeneralDAO generalDAO = new GeneralDAO();

	/*
	 * -------------------------------------------------------------------------
	 * INICIO BLOQUE METODOS HOM
	 * -------------------------------------------------------------------------
	 */
	
	/**
	 * Metodo que consulta los datos para el envio de correo
	 * 
	 * @author Hugo Olivares
	 * @throws IntegracionSICSAException
	 */
	public DatosCorreoDTO getDatosCorreo(String paramCorreo)
			throws IntegracionSICSAException {
		DatosCorreoDTO outDTO;
		loggerDebug("getDatosCorreo: inicio");
		outDTO = generalDAO.getDatosCorreo(paramCorreo);
		loggerDebug("getDatosCorreo: fin");
		return outDTO;
	}

	/**
	 * Metodo que consulta los grupos de correos
	 * 
	 * @author Hugo Olivares
	 * @throws IntegracionSICSAException
	 */
	public GrupoCorreosDTO[] getGruposCorreos ()
			throws IntegracionSICSAException {
		GrupoCorreosDTO[] outDTO;
		loggerDebug("getGruposCorreos: inicio");
		outDTO = generalDAO.getGruposCorreos();
		loggerDebug("getGruposCorreos: fin");
		return outDTO;
	}
	
	/**
	 * Metodo que consulta los correos asociados a un grupo
	 * 
	 * @author Hugo Olivares
	 * @throws IntegracionSICSAException
	 */
	public CorreoDTO[] getCorreos(String codGrupo)
			throws IntegracionSICSAException {
		loggerDebug("getCorreos: inicio");
		CorreoDTO[] outDTO = generalDAO.getCorreos(codGrupo);
		loggerDebug("getCorreos: fin");
		return outDTO;
	}
	
	/**
	 * Metodo que borra un correo
	 * 
	 * @author Hugo Olivares
	 * @throws IntegracionSICSAException
	 */
	public void borrarCorreo(String codGrupo, String mail)
			throws IntegracionSICSAException {

		loggerDebug("borrarCorreo: inicio");
		generalDAO.borrarCorreo(codGrupo, mail);
		loggerDebug("borrarCorreo: fin");
	}
	
	/**
	 * Metodo que modifica un correo
	 * 
	 * @author Hugo Olivares
	 * @throws IntegracionSICSAException
	 */
	public void modificarCorreo(String codGrupo, String antMail,String nueMail, String usuario)
			throws IntegracionSICSAException {

		loggerDebug("modificarCorreo: inicio");
		generalDAO.modificarCorreo(codGrupo, antMail, nueMail, usuario);
		loggerDebug("modificarCorreo: fin");
	}

	
	/**
	 * Metodo que inserta un correo
	 * 
	 * @author Hugo Olivares
	 * @throws IntegracionSICSAException
	 */
	public void insertarCorreo(String codGrupo, String mail, String usuario)
			throws IntegracionSICSAException {

		loggerDebug("insertarCorreo: inicio");
		generalDAO.insertarCorreo(codGrupo, mail, usuario);
		loggerDebug("insertarCorreo: fin");
	}
	/*
	 * -------------------------------------------------------------------------
	 * FIN BLOQUE METODOS HOM
	 * -------------------------------------------------------------------------
	 */

}
