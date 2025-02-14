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
 * 19/03/2007              Wildo Ramos             		 Versión Inicial
 */
package com.tmmas.cl.scl.productdomain.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.scl.commonbusinessentities.dto.ws.ListadoSSInDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.ListadoSSOutDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.DescuentoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosDescuentoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.PrecioCargoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ReglaSSDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.ProductDomainException;
import com.tmmas.cl.scl.productdomain.businessobject.dao.ServicioSuplementarioDAO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.ServicioSuplementarioDTO;

public class ServicioSuplementario extends ProductComponent{

	private ServicioSuplementarioDAO servicioSuplementarioDAO  = new ServicioSuplementarioDAO();
	private static Category cat = Category.getInstance(ServicioSuplementario.class);
	
	public void creaSSAbonado(ServicioSuplementarioDTO entrada)
		throws ProductDomainException
	{
		cat.debug("Inicio:creaSSAbonado()");
		servicioSuplementarioDAO.creaSSAbonado(entrada); 
		cat.debug("Fin:creaSSAbonado()");
	}//fin creaSSAbonado

	public ServicioSuplementarioDTO[] getSSAbonado(ServicioSuplementarioDTO entrada)
		throws ProductDomainException
	{
		cat.debug("Inicio:getSSAbonado()");
		ServicioSuplementarioDTO[] resultado;
		resultado = servicioSuplementarioDAO.getListaSSAbonado(entrada); 
		cat.debug("Fin:getSSAbonado()");
		return resultado;
	}//fin getSSAbonado	

	public ServicioSuplementarioDTO[] getSSAbonadoEV(ServicioSuplementarioDTO entrada)
	throws ProductDomainException
	{
		cat.debug("Inicio:getSSAbonadoEV()");
		ServicioSuplementarioDTO[] resultado;
		resultado = servicioSuplementarioDAO.getListaSSAbonadoEV(entrada); 
		cat.debug("Fin:getSSAbonadoEV()");
		return resultado;
	}//fin getSSAbonado	
	
	public PrecioCargoDTO[] getCargoServSupl(ServicioSuplementarioDTO entrada)
		throws ProductDomainException
	{
		PrecioCargoDTO[] resultado = null;
		cat.debug("Inicio:getCargoServSupl()");
		resultado = servicioSuplementarioDAO.getCargoServSupl(entrada);
		cat.debug("Fin:getCargoServSupl()");
		return resultado;
	}//fin getCargoServSupl
	
	/**
	 * Busca Descuentos asociados al cargo del Servicio Suplementario
	 * @param entrada
	 * @return resultado
	 * @throws ProductDomainException
	 */
	public DescuentoDTO[] getDescuentoCargo(ParametrosDescuentoDTO entrada)
		throws ProductDomainException
	{
		DescuentoDTO[] resultado = null;
		cat.debug("Inicio:getDescuentoCargo()");
		if (entrada.getClaseDescuentoArticulo().equals(entrada.getClaseDescuento()))
			resultado = servicioSuplementarioDAO.getDescuentoCargoArticulo(entrada);
		else
			resultado = servicioSuplementarioDAO.getDescuentoCargoConcepto(entrada);
		cat.debug("Fin:getDescuentoCargo()");
		return resultado;
	}//fin getDescuentoCargo
	
	/**
	 * Obtiene Codigo Concepto Facturable del descuento manual 
	 * @param entrada
	 * @return resultado
	 * @throws ProductDomainException
	 */
	
	public DescuentoDTO getCodigoDescuentoManual(ParametrosDescuentoDTO entrada) 
		throws ProductDomainException
	{
		cat.debug("Inicio:getCodigoDescuentoManual()");
		DescuentoDTO resultado = servicioSuplementarioDAO.getCodigoDescuentoManual(entrada);
		cat.debug("Fin:getCodigoDescuentoManual()");
		return resultado;
	}//fin getCodigoDescuentoManual
	
	/**
	 * Obtiene lista de SS del abonado para enviar movimiento a centrales 
	 * @param entrada
	 * @return resultado
	 * @throws ProductDomainException
	 */
	public ServicioSuplementarioDTO[] getSSAbonadoParaCentrales(ServicioSuplementarioDTO entrada)
		throws ProductDomainException
	{
		cat.debug("Inicio:getSSAbonadoParaCentrales()");
		ServicioSuplementarioDTO[] resultado;
		resultado = servicioSuplementarioDAO.getListaSSAbonadoParaCentral(entrada); 
		cat.debug("Fin:getSSAbonadoParaCentrales()");
		return resultado;
	}//fin getSSAbonadoParaCentrales	

	/**
	 * Obtiene Listado de SS 
	 * @param entrada
	 * @return resultado
	 * @throws ProductDomainException
	 */
	public ListadoSSOutDTO[] getListadoSS(ListadoSSInDTO entrada)
		throws ProductDomainException
	{
		cat.debug("Inicio:getListadoSS()");
		ListadoSSOutDTO[] resultado;
		resultado = servicioSuplementarioDAO.getListadoSS(entrada); 
		cat.debug("Fin:getListadoSS()");
		return resultado;
	}//fin getSSAbonado	

	 /**
	 * Obtiene inserta SS adicionales 
	 * @param ServicioSuplementarioDTO (entrada)
	 * @return ServicioSuplementarioDTO (resultado)
	 * @throws ProductDomainException
	 */	 
	public ServicioSuplementarioDTO insSSAdicionales(ServicioSuplementarioDTO entrada)
		throws ProductDomainException
	{
		cat.debug("Inicio:insSSAdicionales()");
		ServicioSuplementarioDTO resultado;
		resultado = servicioSuplementarioDAO.insSSAdicionales(entrada); 
		cat.debug("Fin:insSSAdicionales()");
		return resultado;
	}//fin insSSAdicionales
	
	/**
	 * Obtiene lista de SS del abonado que no son enviados a centrales
	   para completar cadena clase servicio del abonado
	 * @param entrada
	 * @return resultado
	 * @throws ProductDomainException
	 */
	public ServicioSuplementarioDTO[] getSSAbonadoNoCentrales(ServicioSuplementarioDTO entrada)
		throws ProductDomainException
	{
		cat.debug("Inicio:getSSAbonadoNoCentrales()");
		ServicioSuplementarioDTO[] resultado;
		resultado = servicioSuplementarioDAO.getSSAbonadoNoCentrales(entrada); 
		cat.debug("Fin:getSSAbonadoNoCentrales()");
		return resultado;
	}//fin getSSAbonadoNoCentrales
	
	public PrecioCargoDTO[] getCargoServSuplCargoInstalacion(ServicioSuplementarioDTO entrada)
		throws ProductDomainException
	{
		PrecioCargoDTO[] resultado = null;
		cat.debug("Inicio:getCargoServSupl()");
		resultado = servicioSuplementarioDAO.getCargoServSuplCargoInstalacion(entrada);
		cat.debug("Fin:getCargoServSupl()");
		return resultado;
	}//fin getCargoServSupl
	
	public ReglaSSDTO[] getReglasdeValidacionSS(ReglaSSDTO entrada)
		throws ProductDomainException
	{
		ReglaSSDTO[] resultado = null;
		cat.debug("Inicio:getReglasdeValidacionSS()");
		resultado = servicioSuplementarioDAO.getReglasdeValidacionSS(entrada);
		cat.debug("Fin:getReglasdeValidacionSS()");
		return resultado;
	}//fin getReglasdeValidacionSS
	
}//fin ServicioSuplementario

