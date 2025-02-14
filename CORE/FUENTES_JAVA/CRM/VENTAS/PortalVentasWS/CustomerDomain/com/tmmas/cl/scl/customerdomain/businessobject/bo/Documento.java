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
 * 06/02/2007     Héctor Hermosilla      					Versión Inicial
 */


package com.tmmas.cl.scl.customerdomain.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.scl.crmcommon.commonapp.dto.DatosComercialesDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.DocumentoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dao.DocumentoDAO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.DocumentoFacturacionDTO;

public class Documento  {
	
	private DocumentoDAO documentoDAO  = new DocumentoDAO();
	private static Category cat = Category.getInstance(Documento.class);
	
	/**
	 * Obtiene listado de Documentos. No se define atributos 
	 * debido a que el BO solo procesa y los datos
	 * se retornan a traves de un DTO. 
	 * 
	 * @param datos
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public DocumentoDTO[] getListadoTipoDocumento(DatosComercialesDTO datos) throws CustomerDomainException {
		cat.debug("getListadoTipoDocumento():start");
		DocumentoDTO[] resultado = documentoDAO.getListadoTipoDocumento(datos);
		cat.debug("getListadoTipoDocumento():end");
		return resultado;
	}
	
	/**
	 * Calcula Promedio de Documentos Facturados a un cliente especifico
	 * @param datos 
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public DocumentoFacturacionDTO getPromedioDocumentosFacturados(DocumentoFacturacionDTO datos) throws CustomerDomainException {
		cat.debug("getPromedioDocumentosFacturados():start");
		DocumentoFacturacionDTO resultado = documentoDAO.getPromedioDocumentosFacturados(datos);
		cat.debug("getPromedioDocumentosFacturados():end");
		return resultado;
	}
	

}
