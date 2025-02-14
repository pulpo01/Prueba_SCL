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
 * 19/07/2007              Raúl Lozano             		 Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.businessObject.bo;

import org.apache.log4j.Logger;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosDescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioCargoDTO;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.ServicioSuplementarioBOIT;
import com.tmmas.scl.framework.productDomain.businessObject.dao.ServicioSuplementarioDAO;
import com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces.ServicioSuplementarioDAOIT;
import com.tmmas.scl.framework.productDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ServicioSuplementarioDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;


public class ServicioSuplementarioBO implements ServicioSuplementarioBOIT {

	private ServicioSuplementarioDAOIT servicioSuplementarioDAO  = new ServicioSuplementarioDAO();
	//private ServicioSuplementarioDAO servicioSuplementarioDAO  = new ServicioSuplementarioDAO();
	private final Logger logger = Logger.getLogger(ServicioSuplementarioBO.class);
	private Global global=Global.getInstance();
	
	public void creaSSAbonado(ServicioSuplementarioDTO entrada)throws ProductException{
		logger.debug("Inicio:creaSSAbonado()");
		servicioSuplementarioDAO.creaSSAbonado(entrada); 
		logger.debug("Fin:creaSSAbonado()");
	}//fin creaSSAbonado

	public ServicioSuplementarioDTO[] getSSAbonado(ServicioSuplementarioDTO entrada)throws ProductException{
		logger.debug("Inicio:getSSAbonado()");
		ServicioSuplementarioDTO[] resultado;
		resultado = servicioSuplementarioDAO.getListaSSAbonado(entrada); 
		logger.debug("Fin:getSSAbonado()");
		return resultado;
	}//fin getSSAbonado	

	public PrecioCargoDTO[] getCargoServSupl(ServicioSuplementarioDTO entrada) throws ProductException{
		PrecioCargoDTO[] resultado = null;
		logger.debug("Inicio:getCargoServSupl()");
		resultado = servicioSuplementarioDAO.getCargoServSupl(entrada);
		logger.debug("Fin:getCargoServSupl()");
		return resultado;
	}//fin getCargoServSupl
	
	/**
	 * Busca Descuentos asociados al cargo del Servicio Suplementario
	 * @param entrada
	 * @return resultado
	 * @throws ProductException
	 */
	public DescuentoDTO[] getDescuentoCargo(ParametrosDescuentoDTO entrada) throws ProductException{
		DescuentoDTO[] resultado = null;
		logger.debug("Inicio:getDescuentoCargo()");
		if (entrada.getClaseDescuento().equals(global.getValor("parametro.clase.descuento.articulo"))){
			resultado = servicioSuplementarioDAO.getDescuentoCargoArticulo(entrada);
		}
		if (entrada.getClaseDescuento().equals(global.getValor("parametro.clase.descuento.concepto"))){
			resultado = servicioSuplementarioDAO.getDescuentoCargoConcepto(entrada);
		}
		logger.debug("Fin:getDescuentoCargo()");
		return resultado;
	}//fin getDescuentoCargo
	
	/**
	 * Obtiene Codigo Concepto Facturable del descuento manual 
	 * @param entrada
	 * @return resultado
	 * @throws ProductException
	 */
	
	public DescuentoDTO getCodigoDescuentoManual(ParametrosDescuentoDTO entrada) throws ProductException{
		logger.debug("Inicio:getCodigoDescuentoManual()");
		DescuentoDTO resultado = servicioSuplementarioDAO.getCodigoDescuentoManual(entrada);
		logger.debug("Fin:getCodigoDescuentoManual()");
		return resultado;
	}//fin getCodigoDescuentoManual
	
	/**
	 * Obtiene lista de SS del abonado para enviar movimiento a centrales 
	 * @param entrada
	 * @return resultado
	 * @throws ProductException
	 */
	public ServicioSuplementarioDTO[] getSSAbonadoParaCentrales(ServicioSuplementarioDTO entrada)throws ProductException{
		logger.debug("Inicio:getSSAbonadoParaCentrales()");
		ServicioSuplementarioDTO[] resultado;
		resultado = servicioSuplementarioDAO.getListaSSAbonadoParaCentral(entrada); 
		logger.debug("Fin:getSSAbonadoParaCentrales()");
		return resultado;
	}//fin getSSAbonadoParaCentrales	

}//fin ServicioSuplementario

