/**
 * Copyright © 2009 Telefonica Moviles, Soluciones y Aplicaciones, S.A.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informacion propietaria y confidencial de T-mAs S.A.
 * Usted no debe develar tal informacion y solo debe usarla en concordancia
 * con los terminos de derechos de licencias que sean adquiridos con T-mAs S.A.
 */
package com.tmmas.scl.wsportal.businessobject.bo;

import com.tmmas.scl.wsportal.businessobject.dao.ComunDAO;
import com.tmmas.scl.wsportal.common.dto.MuestraURLDTO;
import com.tmmas.scl.wsportal.common.dto.ResulTransaccionDTO;
import com.tmmas.scl.wsportal.common.exception.PortalSACException;

public class ComunBO{

	ComunDAO comunDAO = new ComunDAO();
	
	/*
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008
	 * Requisito: RSis_003 
	 * Caso de uso: CU-005 Agregar Comentario de OOSS Reversión de Cargos
	 * Requisito: RSis_003 
	 * Caso de uso: CU-006 Agregar Comentario de OOSS Ajuste por Excepción
	 * Developer: Gabriel Moraga L.
	 * Fecha: 04/08/2010
	 * Metodo: ObtenerDatosAbonado
	 * Return: AbonadoDTO
	 * Descripcion: Inserta un comentario
	 * throws: PortalSACException
	 * 
	 */
	

	public ResulTransaccionDTO insertComentario(String comentario, Long numOoss ) throws PortalSACException{
		return comunDAO.insertComentario(comentario, numOoss);
	}

	/*
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008
	 * Requisito: RSis_003 
	 * Caso de uso: CU-004 Agregar Comentario de OOSS Aviso de Siniestro
	 * Developer: Gabriel Moraga L.
	 * Fecha: 13/08/2010
	 * Metodo: insertComentarioPvIorserv
	 * Return: ResulTransaccionDTO
	 * Descripcion: Inserta un comentario en la tabla PV_IORSERV
	 * throws: PortalSACException
	 * 
	 */
	
	public ResulTransaccionDTO insertComentarioPvIorserv(String comentario, Long numOoss ) throws PortalSACException{
		return comunDAO.insertComentarioPvIorserv(comentario, numOoss);
	}
	
	/*
	 * Proyecto: P-CSR-11003 Mejoras al Portal SAC y Evolución Gestor Posventa P-CSR-11003
	 * Requisito: RSis_003 
	 * Developer: Rafael Aguero Vega.
	 * Fecha: 21/03/2011
	 * Metodo: solicitaUrlDominioPuertoBO
	 * Return: MuestraURLDTO
	 * Descripcion: ingresa el Codigo de orden de servicio y Solicitar URL con Dominio y Puerto
	 * throws: PortalSACException
	 * 
	 */
	
	public MuestraURLDTO solicitaUrlDominioPuertoBO(String strCodOrdenServ) throws PortalSACException{
		return comunDAO.solicitaUrlDominioPuerto(strCodOrdenServ);
	}
}
