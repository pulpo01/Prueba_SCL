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
 * 20/03/2007     Héctor Hermosilla     					Versión Inicial
 */
package com.tmmas.cl.scl.gestiondeabonados.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dao.CeldaDAO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CeldaDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.CiudadDTO;

public class CeldaBO {
		private CeldaDAO celdaDAO  = new CeldaDAO();
		private static Category cat = Category.getInstance(CeldaBO.class);

		public CeldaDTO obtieneDatosCelda(CeldaDTO entrada)throws GeneralException{
			CeldaDTO resultado = new CeldaDTO();
			cat.debug("Inicio:obtieneDatosCelda()");
			resultado = celdaDAO.obtieneDatosCelda(entrada); 
			cat.debug("Fin:obtieneDatosCelda()");
			return resultado;
		}	

		public CeldaDTO[] getListadoCeldas(CiudadDTO entrada)throws GeneralException{
			CeldaDTO[] resultado = null;
			cat.debug("Inicio:getListadoCeldas()");
			resultado = celdaDAO.getListadoCeldas(entrada); 
			cat.debug("Fin:getListadoCeldas()");
			return resultado;
		}
		/**
		 * Obtiene celda asociada a la ciudad de la oficina
		 * @param entrada
		 * @return
		 * @throws GeneralException
		 */
		
		public CeldaDTO getCeldaDefectoCiudad(CiudadDTO entrada)throws GeneralException{
			CeldaDTO resultado = null;
			cat.debug("Inicio:getCeldaDefectoCiudad()");
			resultado = celdaDAO.getCeldaDefectoCiudad(entrada); 
			cat.debug("Fin:getCeldaDefectoCiudad()");
			return resultado;
		}
	}





