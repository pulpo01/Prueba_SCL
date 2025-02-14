/**
 * Copyright © 2006 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 03-07-2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.serviceDomain.businessObject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.marketSalesDomain.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.serviceDomain.businessObject.dao.interfaces.ProductoTasacionContratadoDAOIT;
import com.tmmas.scl.framework.serviceDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.ProductoTasacionContratadoListDTO;
import com.tmmas.scl.framework.serviceDomain.exception.ServiceException;

public class ProductoTasacionContratadoDAO extends ConnectionDAO implements ProductoTasacionContratadoDAOIT
{
	private final Logger logger = Logger.getLogger(ProductoTasacionContratadoDAO.class);
	private final Global global = Global.getInstance();
	
	private String getSQLeliminar() {
		StringBuffer call = new StringBuffer();
		//AGREGAR INVOCACION A PL
		return call.toString();		
	}
	private String getSQLinformar() {
		StringBuffer call = new StringBuffer();
		//AGREGAR INVOCACION A PL
		return call.toString();		
	}		
	private String getSQLobtenerEstado() {
		StringBuffer call = new StringBuffer();
		//AGREGAR INVOCACION A PL
		return call.toString();		
	}		
	
	public RetornoDTO eliminar(ProductoTasacionContratadoListDTO productoTasacion) throws ServiceException {
		logger.debug("eliminar():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLeliminar();
		try {
			
			logger.debug("productoTasacion.getProductosTasacionContratados().toString()[" + productoTasacion.getProductosTasacionContratados().toString() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			
			// SE LLENAN PARAMETROS SEGUN PL
			//cstmt.setArray(1, listaNumeros.getNumerosDTO());
			//ini------------------CONTINUAR CARGA DE PARAMETROS-------------------
			
			//cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			//cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			//cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);			
		
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			//codError = cstmt.getInt(2);
			logger.debug("codError[" + codError + "]");
			//msgError = cstmt.getString(3);
			logger.debug("msgError[" + msgError + "]");
			//numEvento = cstmt.getInt(4);
			logger.debug("numEvento[" + numEvento + "]");
			//fin----------------------------------------------------------------------
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al crear la lista de numeros");
				throw new ServiceException(String.valueOf(codError),numEvento, msgError);
			}
			
			//obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");
			//ini--------------RESCATAR RETORNO-------
			retorno = new RetornoDTO();
			//fin----------------------------------------------------------------------
		
		} catch (ServiceException e) {
			logger.debug("ServiceException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al eliminar fin ciclo", e);
			throw new ServiceException("Ocurrió un error general al eliminar fin ciclo",e);
		}
		finally {
			try {
				if (cstmt != null) {
					cstmt.close();
					cstmt = null;
				}
				if (conn != null) {
					if (!conn.isClosed()) {
						conn.close();
					}
					conn = null;
				}
			} catch (SQLException e) {
				cstmt = null;
				conn = null;
				logger.debug("SQLException[" + e + "]");
			}
		}
		logger.debug("eliminar():end");
		return retorno;
	}

	public RetornoDTO informar(ProductoTasacionContratadoListDTO productoTasacion) throws ServiceException 
	{
		logger.debug("informar():start");
		logger.debug("BO 2 : + "+logger.toString());
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLinformar();
		try {
			
			logger.debug("productoTasacion.getProductosTasacionContratados().toString()[" + productoTasacion.getProductosTasacionContratados().toString() + "]");
			logger.debug("BO 2 :");
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			logger.debug("BO 3 :");
			cstmt = conn.prepareCall(call);
			logger.debug("BO 4 :");
			// SE LLENAN PARAMETROS SEGUN PL
			//cstmt.setArray(1, listaNumeros.getNumerosDTO());
			//ini------------------CONTINUAR CARGA DE PARAMETROS-------------------
			
			//cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			//cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			//cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);			
		
			logger.debug("execute:antes");
			// // cstmt.execute();
			
			
			
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			//codError = cstmt.getInt(2);
			logger.debug("codError[" + codError + "]");
			//msgError = cstmt.getString(3);
			logger.debug("msgError[" + msgError + "]");
			//numEvento = cstmt.getInt(4);
			logger.debug("numEvento[" + numEvento + "]");
			logger.debug("BO 5 :FIN");
			//fin----------------------------------------------------------------------
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al crear la lista de numeros");
				throw new ServiceException(String.valueOf(codError),numEvento, msgError);
			}
			
			//obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");
			//ini--------------RESCATAR RETORNO-------
			retorno = new RetornoDTO();
			
			logger.debug("ProductoTasacionContratado DAO [OK]");
			retorno.setCodigo("1");
			retorno.setDescripcion("LLEGO OK");
			//fin----------------------------------------------------------------------
		
		} catch (ServiceException e) {
			logger.debug("ServiceException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al eliminar fin ciclo", e);
			throw new ServiceException("Ocurrió un error general al eliminar fin ciclo",e);
		}
		finally {
			try {
				if (cstmt != null) {
					cstmt.close();
					cstmt = null;
				}
				if (conn != null) {
					if (!conn.isClosed()) {
						conn.close();
					}
					conn = null;
				}
			} catch (SQLException e) {
				cstmt = null;
				conn = null;
				logger.debug("SQLException[" + e + "]");
			}
		}
		logger.debug("informar():end");
		return retorno;
	}

	public RetornoDTO obtenerEstado(VentaDTO ventaDTO) throws ServiceException {
		logger.debug("obtenerEstado():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerEstado();
		try {
			
			logger.debug("ventaDTO.getIdVenta()[" + ventaDTO.getIdVenta() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			
			// SE LLENAN PARAMETROS SEGUN PL
			//cstmt.setArray(1, listaNumeros.getNumerosDTO());
			//ini------------------CONTINUAR CARGA DE PARAMETROS-------------------
			
			//cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			//cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			//cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);			
		
			logger.debug("execute:antes");
			// cstmt.execute();
			
			
			
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			//codError = cstmt.getInt(2);
			logger.debug("codError[" + codError + "]");
			//msgError = cstmt.getString(3);
			logger.debug("msgError[" + msgError + "]");
			//numEvento = cstmt.getInt(4);
			logger.debug("numEvento[" + numEvento + "]");
			//fin----------------------------------------------------------------------
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al crear la lista de numeros");
				throw new ServiceException(String.valueOf(codError),numEvento, msgError);
			}
			
			//obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");
			//ini--------------RESCATAR RETORNO-------
			retorno = new RetornoDTO();
			
			logger.debug("ProductoTasacionContratado DAO [OK]");
			retorno.setCodigo("1");
			retorno.setDescripcion("LLEGO OK");
			//fin----------------------------------------------------------------------
		
		} catch (ServiceException e) {
			logger.debug("ServiceException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al eliminar fin ciclo", e);
			throw new ServiceException("Ocurrió un error general al eliminar fin ciclo",e);
		}
		finally {
			try {
				if (cstmt != null) {
					cstmt.close();
					cstmt = null;
				}
				if (conn != null) {
					if (!conn.isClosed()) {
						conn.close();
					}
					conn = null;
				}
			} catch (SQLException e) {
				cstmt = null;
				conn = null;
				logger.debug("SQLException[" + e + "]");
			}
		}
		logger.debug("obtenerEstado():end");
		return retorno;
	}

}
