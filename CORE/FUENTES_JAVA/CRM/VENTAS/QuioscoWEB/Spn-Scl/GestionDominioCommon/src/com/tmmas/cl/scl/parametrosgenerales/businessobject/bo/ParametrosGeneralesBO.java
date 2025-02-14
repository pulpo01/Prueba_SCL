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
 * 23/02/2007     Roberto P&eacute;rez Varas      					Versión Inicial
 */
package com.tmmas.cl.scl.parametrosgenerales.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.parametrosgenerales.businessobject.dao.ParametrosGeneralesDAO;
import com.tmmas.cl.scl.parametrosgenerales.businessobject.dto.ParametrosGeneralesDTO;

public class ParametrosGeneralesBO {
		private ParametrosGeneralesDAO ParametrosGeneralesDAO  = new ParametrosGeneralesDAO();
		private static Category cat = Category.getInstance(ParametrosGeneralesBO.class);

		
		
		/**
		 * Obtiene Parametros Generales
		 * @param parametroGeneral 
		 * @return resultado
		 * @throws ProductDomainException
		 */
		
		public ParametrosGeneralesDTO getParametroGeneral(ParametrosGeneralesDTO parametrogeneral)
		throws GeneralException{
			ParametrosGeneralesDTO resultado = null;
			cat.debug("Inicio:ParametrosGenerales:obtieneParametroGeneral()");
			resultado = ParametrosGeneralesDAO.getParametroGeneral(parametrogeneral); 
			cat.debug("Fin:ParametrosGenerales:obtieneParametroGeneral()");
			return resultado;
		}//fin getParametroGeneral
		
		
		
		/**
		 * Obtiene Parametro de Facturación
		 * @param parametroGeneral 
		 * @return resultado
		 * @throws GeneralException
		 */
		
		public ParametrosGeneralesDTO getParametroFacturacion(ParametrosGeneralesDTO parametrogeneral)
		throws GeneralException{
			ParametrosGeneralesDTO resultado = new ParametrosGeneralesDTO();
			cat.debug("Inicio:ParametrosGenerales:getParametroFacturacion()");
			resultado = ParametrosGeneralesDAO.getParametroFacturacion(parametrogeneral); 
			cat.debug("Fin:ParametrosGenerales:getParametroFacturacion()");
			return resultado;
		}//fin getParametroFacturacion

		/**
		 * Obtiene Parametro de Grupo Tecnologico
		 * @param parametroGeneral 
		 * @return resultado
		 * @throws GeneralException
		 */
		
		public ParametrosGeneralesDTO getParametroGrupoTecnologico(ParametrosGeneralesDTO parametrogeneral)
		throws GeneralException{
			ParametrosGeneralesDTO resultado = new ParametrosGeneralesDTO();
			cat.debug("Inicio:ParametrosGenerales:getParametroGrupoTecnologico()");
			resultado = ParametrosGeneralesDAO.getParametroGrupoTecnologico(parametrogeneral); 
			cat.debug("Fin:ParametrosGenerales:getParametroGrupoTecnologico()");
			return resultado;
		}//fin getParametroGrupoTecnologico
		
		/**
		 * Obtiene Parametros desde Mas Generales
		 * @param parametroGeneral 
		 * @return resultado
		 * @throws GeneralException
		 */		
		public ParametrosGeneralesDTO getParametroMasGeneral(ParametrosGeneralesDTO parametrogeneral)
			throws GeneralException
		{
			ParametrosGeneralesDTO resultado = null;
			cat.debug("Inicio:ParametrosGenerales:getParametroMasGeneral()");
			resultado = ParametrosGeneralesDAO.getParametroMasGeneral(parametrogeneral); 
			cat.debug("Fin:ParametrosGenerales:getParametroMasGeneral()");
			return resultado;
		}//fin getParametroMasGeneral

}//fin ParametrosGenerales

