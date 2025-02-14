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
package com.tmmas.cl.scl.gestiondeclientes.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.gestiondeclientes.businessobject.dao.FacturacionDAO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.GaVentasDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsCicloFactInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListCicloFactOutDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.InfoFacturaDTO;


public class FacturacionBO {
		private FacturacionDAO facturacionDAO  = new FacturacionDAO();
		private static Category cat = Category.getInstance(FacturacionBO.class);

		/**
		 * Obtiene Lista de ciclos de postpago
		 * @param cicloFactDTO 
		 * @return resultado
		 * @throws GeneralException
		 */		
		public WsListCicloFactOutDTO getListadoCiclosPostPago(WsCicloFactInDTO cicloFactDTO)
		throws GeneralException
		{
			WsListCicloFactOutDTO resultado = null;
			cat.debug("Inicio:FacturacionDAO:getListadoCiclosPostPago()");
			resultado = facturacionDAO.getListadoCiclosPostPago(cicloFactDTO); 
			cat.debug("Fin:FacturacionDAO:getListadoCiclosPostPago()");
			return resultado;
		}//fin getListadoCiclosPostPago
		
		
		public void udpInterfazDeFacturación(GaVentasDTO gaVentas)
		throws GeneralException{			
			cat.debug("Inicio::udpGaIntarcel()");
		    facturacionDAO.udpInterfazDeFacturación(gaVentas); 
			cat.debug("Fin::udpGaIntarcel()");			
		}//fin udpGaIntarcel
		
		public InfoFacturaDTO getInforCargos(String numVenta, String numProceso) 
		throws GeneralException{
			cat.debug("Inicio::getInforCargos()");
			InfoFacturaDTO resultado = new InfoFacturaDTO();
			resultado = facturacionDAO.getInforCargos(numVenta, numProceso); 
			cat.debug("Fin::getInforCargos()");
			return resultado;			
		}//fin getInforCargos			
		

}//fin FacturacionBO

