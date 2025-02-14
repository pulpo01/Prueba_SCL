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
 * 16/01/2007     Héctor Hermosilla      					Versión Inicial
 */

package com.tmmas.cl.scl.gestiondeclientes.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.gestiondeclientes.businessobject.dao.CausalDescuentoDAO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CausalDescuentoDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsMotivosDeDescuentoManualInDTO;


public class CausalDescuentoBO  {
	
	private CausalDescuentoDAO CausalDescuentoDAO  = new CausalDescuentoDAO();
	private static Category cat = Category.getInstance(CausalDescuentoBO.class);
	

	
	/**
	 * Obtiene listado de centros de costos
	 * @param causalDescuentoDTO
	 * @return CausalDescuentoDTO[]
	 * @throws CustomerDomainException
	 */	
	public WsMotivosDeDescuentoManualInDTO[] getListMotivosDeDescuentoManual(CausalDescuentoDTO causalDescuentoDTO) 
	throws GeneralException{
		cat.debug("getListMotivosJustificacion():start");
		WsMotivosDeDescuentoManualInDTO[] resultado = CausalDescuentoDAO.getListMotivosJustificacion(causalDescuentoDTO);
		cat.debug("getListMotivosJustificacion():end");
		return resultado;
	}//fin getListMotivosJustificacion

	

	/**
	 * Inserta documento con motivo de descuento
	 * @param CausalDescuentoDTO (entrada)
	 * @return N/A
	 * @throws GeneralException
	 */
	public void insDocumentoMotivo(CausalDescuentoDTO entrada)
	throws GeneralException{
		cat.debug("Inicio:insDocumentoMotivo()");
		CausalDescuentoDAO.insDocumentoMotivo(entrada); 
		cat.debug("Fin:insDocumentoMotivo()");		
	}//fin insDocumentoMotivo

	
	

}
