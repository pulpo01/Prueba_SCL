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
 * 29-06-2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.customerDomain.businessObject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import oracle.jdbc.OracleCallableStatement;
import oracle.sql.STRUCT;
import oracle.sql.StructDescriptor;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.customerDomain.businessObject.dao.interfaces.CargoFacturadoDAOIT;
import com.tmmas.scl.framework.customerDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.CargoOcasionalDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.CargoRecurrenteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerBillException;
import com.tmmas.scl.framework.marketSalesDomain.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.DescuentoProductoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ProductoContratadoDTO;

public class CargoFacturadoDAO extends ConnectionDAO implements CargoFacturadoDAOIT
{
	private final Logger logger = Logger.getLogger(CargoFacturadoDAO.class);
	private final Global global = Global.getInstance();
	
	private String getSQLinformarCargoOcasional() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   REGISTRO FA_CARGOS_QT; ");
		call.append("   SN_COD_RETORNO NUMBER; ");
		call.append("   SV_MENS_RETORNO VARCHAR2(200); ");
		call.append("   SN_NUM_EVENTO NUMBER; ");
		call.append(" BEGIN ");
		call.append("   FA_CARGOS_SN_PG.FA_CARGOS_ALTA_PR(?,?,?,?); ");    
		call.append(" END; ");
		return call.toString();		
	}	
	
	private String getSQLinformarDescuentoOcasional() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   REGISTRO FA_CARGOS_QT; ");
		call.append("   SN_COD_RETORNO NUMBER; ");
		call.append("   SV_MENS_RETORNO VARCHAR2(200); ");
		call.append("   SN_NUM_EVENTO NUMBER; ");
		call.append(" BEGIN ");
		call.append("   FA_CARGOS_SN_PG.FA_CARGOS_ALTA_PR(?,?,?,?); ");    
		call.append(" END; ");
		return call.toString();		
	}
	
	private String getSQLinformarCargoRecurrente() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   REGISTRO FA_CARGOS_REC_QT; ");
		call.append("   SN_COD_RETORNO NUMBER; ");
		call.append("   SV_MENS_RETORNO VARCHAR2(200); ");
		call.append("   SN_NUM_EVENTO NUMBER; ");
		call.append(" BEGIN ");
		call.append("   FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_ALTA_PR(?,?,?,?); ");
		call.append(" END; ");
		return call.toString();		
	}	
	
	private String getSQLEliminarOcasionales()
	{
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   REGISTRO FA_CARGOS_QT; ");
		call.append("   SN_COD_RETORNO NUMBER; ");
		call.append("   SV_MENS_RETORNO VARCHAR2(200); ");
		call.append("   SN_NUM_EVENTO NUMBER; ");
		call.append(" BEGIN ");
		call.append("   FA_CARGOS_SN_PG.FA_CARGOS_BAJA_PR(?,?,?,?); ");
		call.append(" END; ");
		return call.toString();	
	}
	
	private String getSQLEliminarRecurrentes()
	{
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   REGISTRO FA_CARGOS_REC_QT; ");
		call.append("   SN_COD_RETORNO NUMBER; ");
		call.append("   SV_MENS_RETORNO VARCHAR2(200); ");
		call.append("   SN_NUM_EVENTO NUMBER; ");
		call.append(" BEGIN ");
		call.append("   FA_CARGOS_REC_SN_PG.FA_CARGOS_REC_BAJA_PR(?,?,?,?); ");
		call.append(" END; ");
		return call.toString();	
	}
	
	private String getSQLEliminarCargosRegistrados() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   fa_cargos PV_SOLICITUD_QT := PV_INICIA_ESTRUCTURAS_PG.FA_CARGOS_QT;");
		call.append(" BEGIN ");
		call.append("   fa_cargos.COD_PROD_CONTRATADO := ?;");
		call.append("   fa_cargos.NUM_VENTA := ?;");
		call.append("   fa_cargos.COD_CLIENTE := ?;");
		call.append("   fa_cargos.SEQ_CARG := ?;");
		call.append("   FA_CARGOS_SN_PG.FA_CARGOS_BAJA_PR( fa_cargos, ?, ?, ?);");
		call.append(" END;");	
		return call.toString();		
	}
	
	public RetornoDTO eliminarCargosRegistrados(CargoOcasionalDTO cargoOcacional) throws CustomerBillException 
	{		
		logger.debug("eliminarCargosRegistrados():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = new RetornoDTO();		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLEliminarCargosRegistrados();
		try {			
			
			//logger.debug("registro.getNumeroAutorizacion()[" + registro.getNumeroAutorizacion() + "]");
			//logger.debug("registro.getNumeroVenta()[" + registro.getNumeroVenta() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			cstmt = conn.prepareCall(call);
			
			//ini------------------CONTINUAR CARGA DE PARAMETROS-------------------
			//cstmt.setObject(1, oracleObject);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);			
		
			logger.debug("execute:antes");
			cstmt.execute();			
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(5);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(6);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(7);
			logger.debug("numEvento[" + numEvento + "]");
			//fin----------------------------------------------------------------------
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al eliminar los cargos registrados");
				throw new CustomerBillException(String.valueOf(codError),numEvento, msgError);
			}
			retorno.setCodigo(String.valueOf(codError));
			retorno.setDescripcion(msgError);
			
			//obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");
			//ini--------------RESCATAR RETORNO-------
			retorno = new RetornoDTO();			
			retorno.setCodigo(String.valueOf(codError));
			retorno.setDescripcion(msgError);
			//fin----------------------------------------------------------------------
		
		} catch (CustomerBillException e) {
			logger.debug("CustomerBillException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al eliminar los cargos registrados", e);
			throw new CustomerBillException("Ocurrió un error general al eliminar los cargos registrados",e);
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
		logger.debug("eliminarCargosRegistrados():end");
		return retorno;
	}
	
	public RetornoDTO informar(CargoOcasionalDTO cargoOcacional) throws CustomerBillException 
	{		
		logger.debug("informar():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;		
		Connection conn = null;
		OracleCallableStatement cstmt = null;
		
		String call = getSQLinformarCargoOcasional();
		try {			
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			StructDescriptor sd = StructDescriptor.createDescriptor("FA_CARGOS_QT", conn);			
			STRUCT oracleObject = new STRUCT(sd, conn, cargoOcacional.toStruct_FA_CARGOS_QT());
			
			cstmt = (OracleCallableStatement)conn.prepareCall(call);
			
			//ini------------------CONTINUAR CARGA DE PARAMETROS-------------------
			cstmt.setObject(1, oracleObject);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);			
		
			logger.debug("execute:antes");
			cstmt.execute();			
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(2);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(3);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(4);
			logger.debug("numEvento[" + numEvento + "]");
			//fin----------------------------------------------------------------------
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al eliminar fin ciclo");
				throw new CustomerBillException(String.valueOf(codError),numEvento, msgError);
			}
			
			//obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");
			//ini--------------RESCATAR RETORNO-------
			retorno = new RetornoDTO();			
			retorno.setCodigo(String.valueOf(codError));
			retorno.setDescripcion(msgError);
			//fin----------------------------------------------------------------------
		
		} catch (CustomerBillException e) {
			logger.debug("CustomerBillException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al eliminar fin ciclo", e);
			throw new CustomerBillException("Ocurrió un error general al eliminar fin ciclo",e);
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
	
	public RetornoDTO informarDescuentos(DescuentoProductoDTO descuento) throws CustomerBillException 
	{		
		logger.debug("informarDescuentos():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;		
		Connection conn = null;
		OracleCallableStatement cstmt = null;
		
		String call = getSQLinformarDescuentoOcasional();
		try {			
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			StructDescriptor sd = StructDescriptor.createDescriptor("FA_CARGOS_QT", conn);			
			STRUCT oracleObject = new STRUCT(sd, conn, descuento.toStruct_FA_CARGOS_QT());
			
			cstmt = (OracleCallableStatement)conn.prepareCall(call);
			
			//ini------------------CONTINUAR CARGA DE PARAMETROS-------------------
			cstmt.setObject(1, oracleObject);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);			
		
			logger.debug("execute:antes");
			cstmt.execute();			
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(2);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(3);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(4);
			logger.debug("numEvento[" + numEvento + "]");
			//fin----------------------------------------------------------------------
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al eliminar fin ciclo");
				throw new CustomerBillException(String.valueOf(codError),numEvento, msgError);
			}
			
			//obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");
			//ini--------------RESCATAR RETORNO-------
			retorno = new RetornoDTO();			
			retorno.setCodigo(String.valueOf(codError));
			retorno.setDescripcion(msgError);
			//fin----------------------------------------------------------------------
		
		} catch (CustomerBillException e) {
			logger.debug("CustomerBillException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al eliminar fin ciclo", e);
			throw new CustomerBillException("Ocurrió un error general al eliminar fin ciclo",e);
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
		logger.debug("informarDescuentos():end");
		return retorno;
	}

	public RetornoDTO informar(CargoRecurrenteDTO cargoRecurrente) throws CustomerBillException 
	{
		logger.debug("informar():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;		
		Connection conn = null;
		OracleCallableStatement cstmt = null;
		
		String call = getSQLinformarCargoRecurrente();
		try {			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());			
			cstmt = (OracleCallableStatement)conn.prepareCall(call);
			
			StructDescriptor sd = StructDescriptor.createDescriptor("FA_CARGOS_REC_QT", conn);			
			STRUCT oracleObject = new STRUCT(sd, conn, cargoRecurrente.toStruct_FA_CARGOS_REC_QT());
			
			//ini------------------CONTINUAR CARGA DE PARAMETROS-------------------
			cstmt.setObject(1, oracleObject);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);			
		
			logger.debug("execute:antes");
			cstmt.execute();			
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(2);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(3);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(4);
			logger.debug("numEvento[" + numEvento + "]");
			//fin----------------------------------------------------------------------
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al eliminar fin ciclo");
				throw new CustomerBillException(String.valueOf(codError),numEvento, msgError);
			}
			
			//obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");
			//ini--------------RESCATAR RETORNO-------
			retorno = new RetornoDTO();			
			retorno.setCodigo(String.valueOf(codError));
			retorno.setDescripcion(msgError);
			//fin----------------------------------------------------------------------
		
		} catch (CustomerBillException e) {
			logger.debug("CustomerBillException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al eliminar fin ciclo", e);
			throw new CustomerBillException("Ocurrió un error general al eliminar fin ciclo",e);
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

	public RetornoDTO obtenerEstado(VentaDTO ventaDTO) throws CustomerBillException 
	{
		logger.debug("obtenerEstado():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLinformarCargoOcasional();
		try {
			
			logger.debug(" ventaDTO.getIdVenta()[" + ventaDTO.getIdVenta() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			
			//ini------------------CONTINUAR CARGA DE PARAMETROS-------------------
			
			//cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			//cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			//cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);			
		
			logger.debug("execute:antes");
			//cstmt.execute();
			
			
			logger.debug("Recuperando salidas");
			//codError = cstmt.getInt(2);
			logger.debug("codError[" + codError + "]");
			//msgError = cstmt.getString(3);
			logger.debug("msgError[" + msgError + "]");
			//numEvento = cstmt.getInt(4);
			logger.debug("numEvento[" + numEvento + "]");
			//fin----------------------------------------------------------------------
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al eliminar fin ciclo");
				throw new CustomerBillException(String.valueOf(codError),numEvento, msgError);
			}
			
			//obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");
			//ini--------------RESCATAR RETORNO-------
			retorno = new RetornoDTO();
			
			logger.debug("CargoFacturadoDAO DAO [OK]");
			retorno.setCodigo("1");
			retorno.setDescripcion("LLEGO OK");
			logger.debug("execute:despues");
			//fin----------------------------------------------------------------------
		
		} catch (CustomerBillException e) {
			logger.debug("CustomerBillException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al eliminar fin ciclo", e);
			throw new CustomerBillException("Ocurrió un error general al eliminar fin ciclo",e);
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

	public RetornoDTO eliminarOcasionales(ProductoContratadoDTO productoContratado) throws CustomerBillException 
	{
		logger.debug("eliminarOcasionales():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;		
		Connection conn = null;
		OracleCallableStatement cstmt = null;
		
		String call = getSQLEliminarOcasionales();
		try {
			
			logger.debug("ELIMINANDO OCASIONAL ["+productoContratado.getIdProdContratado()+"]");			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());			
			cstmt = (OracleCallableStatement)conn.prepareCall(call);					
			StructDescriptor sd = StructDescriptor.createDescriptor("FA_CARGOS_QT", conn);			
			STRUCT oracleObject = new STRUCT(sd, conn, productoContratado.toStruct_FA_CARGOS_QT());			
			//ini------------------CONTINUAR CARGA DE PARAMETROS-------------------			
			cstmt.setObject(1, oracleObject);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);			
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			
			logger.debug("execute:antes");
			cstmt.execute();			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(2);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(3);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(4);
			logger.debug("numEvento[" + numEvento + "]");
			//fin----------------------------------------------------------------------
			
			if (codError != 0 && codError!=1) {
				logger.error(" Ocurrió un error al eliminar fin ciclo");
				throw new CustomerBillException(String.valueOf(codError),numEvento, msgError);
			}
			
			//obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");
			//ini--------------RESCATAR RETORNO-------
			retorno = new RetornoDTO();
			retorno.setCodigo(String.valueOf(codError));
			retorno.setDescripcion(msgError);
						
			logger.debug("execute:despues");
			//fin----------------------------------------------------------------------
		
		} catch (CustomerBillException e) {
			logger.debug("CustomerBillException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al eliminar fin ciclo", e);
			throw new CustomerBillException("Ocurrió un error general al eliminar fin ciclo",e);
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
		logger.debug("eliminarOcasionales():end");
		return retorno;		
	}

	public RetornoDTO eliminarRecurrente(ProductoContratadoDTO productoContratado) throws CustomerBillException 
	{
		logger.debug("eliminarRecurrente():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;		
		Connection conn = null;
		OracleCallableStatement cstmt = null;
		
		String call = getSQLEliminarRecurrentes();
		try {
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			cstmt = (OracleCallableStatement)conn.prepareCall(call);					
			StructDescriptor sd = StructDescriptor.createDescriptor("FA_CARGOS_REC_QT", conn);			
			STRUCT oracleObject = new STRUCT(sd, conn, productoContratado.toStruct_FA_CARGOS_REC_QT());		
			//conn.getMetaData().getUserName();
			//ini------------------CONTINUAR CARGA DE PARAMETROS-------------------			
			cstmt.setObject(1, oracleObject);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);			
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			
			logger.debug("execute:antes");
			cstmt.execute();			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(2);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(3);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(4);
			logger.debug("numEvento[" + numEvento + "]");
			//fin----------------------------------------------------------------------
			
			if (codError != 0 && codError!=1) {
				logger.error(" Ocurrió un error al eliminar fin ciclo");
				throw new CustomerBillException(String.valueOf(codError),numEvento, msgError);
			}
			
			//obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");
			//ini--------------RESCATAR RETORNO-------
			retorno = new RetornoDTO();
			retorno.setCodigo(String.valueOf(codError));
			retorno.setDescripcion(msgError);
						
			logger.debug("execute:despues");
			//fin----------------------------------------------------------------------
		
		} catch (CustomerBillException e) {
			logger.debug("CustomerBillException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al eliminar fin ciclo", e);
			throw new CustomerBillException("Ocurrió un error general al eliminar fin ciclo",e);
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
		logger.debug("eliminarRecurrente():end");
		return retorno;		
	}


}
