/**
 * Copyright © 2007 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 19/06/2007     Héctor Hermosilla      					Versión Inicial
 */
package com.tmmas.cl.scl.gestiondedirecciones.businessobject.bo;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dao.DireccionDAO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.DireccionDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.DireccionNegocioDTO;


public class DireccionBO  {
	
	private DireccionDAO direccionDAO  = new DireccionDAO();
	private final Logger logger = Logger.getLogger(DireccionBO.class);
	
	/**
	 * Obtiene configuración de las direcciones en la operadora
	 * 
	 * @author Héctor Hermosilla 
	 * @param direccionDTO
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public DireccionDTO getConfiguracionDireccion(DireccionDTO direccionDTO) 
	throws GeneralException{
		logger.debug("Inicio:getConfiguracionDireccion()");
		DireccionDTO resultado =direccionDAO.getConfiguracionDireccion(direccionDTO);
		logger.debug("Fin:getConfiguracionDireccion()");
		return resultado;
	}//fin getConfiguracionDireccion

	/**
	 * Obtiene direccion
	 * @param entrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public DireccionNegocioDTO getDireccion(DireccionNegocioDTO entrada) 
	throws GeneralException{
		logger.debug("Inicio:updDireccion()");
		DireccionNegocioDTO resultado = direccionDAO.getDireccion(entrada);
		logger.debug("Fin:updDireccion()");
		return resultado;
	}//fin updDireccion
	
	/**
	 * Actualiza direccion
	 * @param entrada
	 * @return N/A
	 * @throws GeneralException
	 */
	public void updDireccion(DireccionNegocioDTO entrada) 
	throws GeneralException{
		logger.debug("Inicio:updDireccion()");
		direccionDAO.updDireccion(entrada);
		logger.debug("Fin:updDireccion()");
	}//fin updDireccion

	public DireccionNegocioDTO getDireccionCodigo(DireccionNegocioDTO entrada) 
	throws GeneralException{
		logger.debug("Inicio:getDireccionCodigo()");
		DireccionNegocioDTO resultado = direccionDAO.getDireccionCodigo(entrada);
		logger.debug("Fin:getDireccionCodigo()");		
		return resultado;
	}//fin getDireccionCodigo
	
	/**
	 * Inserta direccion
	 * 
	 * @author Héctor Hermosilla
	 * @param entrada
	 * @return resultado
	 * @throws GeneralException
	 */
	public void setDireccion(DireccionNegocioDTO[] entrada) 
	throws GeneralException{
		logger.debug("Inicio:setDireccion()");
		for (int i=0; i< entrada.length; i++){
			direccionDAO.setDireccion(entrada[i]);
		}
		
		logger.debug("Fin:setDireccion()");
	}	                         
	public void setDireccion(DireccionNegocioDTO entrada) 
	throws GeneralException{
		logger.debug("Inicio:setDireccion()");
		direccionDAO.setDireccion(entrada);		
		logger.debug("Fin:setDireccion()");
	}	
	
	
	/**
	 * elimina direccion
	 * 
	 * @author Héctor Hermosilla
	 * @param entrada
	 * @return resultado
	 * @throws GeneralException
	 */
	public void eliminaDireccion(DireccionNegocioDTO entrada) 
	throws GeneralException{
		logger.debug("Inicio:eliminaDireccion()");
		direccionDAO.eliminaDireccion(entrada);
		logger.debug("Fin:eliminaDireccion()");
	}
	
}//fin class Direccion
