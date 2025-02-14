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
 * 11/08/2007     			 Cristian Toledo              		Versión Inicial
 * 25/10/2007     			 Fernando Mateluna             		
 */
package com.tmmas.scl.framework.serviceDomain.businessObject.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import oracle.jdbc.OracleCallableStatement;
import oracle.sql.ARRAY;
import oracle.sql.ArrayDescriptor;
import oracle.sql.STRUCT;
import oracle.sql.StructDescriptor;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.framework.serviceDomain.businessObject.dao.interfaces.ProductoTasacionContratadoTOLDAOIT;
import com.tmmas.scl.framework.serviceDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.ProductoTasacionContratadoListDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.SaldoProductoCliente;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.SaldoProductoTasacionDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.SaldoProductoTasacionListDTO;
import com.tmmas.scl.framework.serviceDomain.exception.ServiceException;

public class ProductoTasacionContratadoTOLDAO extends ConnectionDAO implements ProductoTasacionContratadoTOLDAOIT
{
	private final Logger logger = Logger.getLogger(ProductoTasacionContratadoTOLDAO.class);
	private final Global global = Global.getInstance();
	
	private String getSQLEliminar()
	{
		StringBuffer call=new StringBuffer();
		call.append(" DECLARE ");
		call.append("   EO_BAJAPROD TOL_BAJA_PRODUCTO_DET_QT; ");
		call.append("   SN_COD_RETORNO NUMBER; ");
		call.append("   SV_MENS_RETORNO VARCHAR2(200); ");
		call.append("   SN_NUM_EVENTO NUMBER; ");
		call.append(" BEGIN ");
		call.append("   TOL_PRODUCTO_CONTRATADO_PG.TOL_BAJA_PRODUCTO_PR(?,?,?,?); ");   
		call.append(" END; ");
		return call.toString();
	}
	
	
	private String getSQLInformar()
	{
		StringBuffer call=new StringBuffer();
		
		call.append(" DECLARE ");
		call.append("   EO_ALTAPROD TOL.TOL_ALTA_PRODUCTO_DET_QT; ");
		call.append(" EN_COD_CLIENTE NUMBER; ");
		call.append(" EV_CANAL_DISTRO VARCHAR2(200); ");
		call.append(" SN_COD_RETORNO NUMBER; ");
		call.append(" SV_MENS_RETORNO VARCHAR2(200); ");
		call.append(" SN_NUM_EVENTO NUMBER; ");
		call.append(" BEGIN ");
		call.append(" EN_COD_CLIENTE := NULL; ");
		call.append(" EV_CANAL_DISTRO := NULL; ");
		call.append(" TOL_PRODUCTO_CONTRATADO_PG.TOL_ALTA_PRODUCTO_PR(?,?,?,?,?,?,?); ");    
		call.append(" END; ");
		
		return call.toString();
	}
	
	private String getSQLSaldos()
	{
		StringBuffer call=new StringBuffer();

		call.append(" DECLARE ");
		call.append(" 	EN_COD_CLIENTE NUMBER;");
		call.append(" 	EN_COD_ABONADO NUMBER;");
		call.append(" 	EN_COD_PRODC NUMBER;");
		call.append(" 	SO_LISTA_SALDO TOL_PRODUCTO_CONTRATADO_PG.refCursor;");
		call.append(" 	SN_COD_RETORNO VARCHAR2(200);");
		call.append(" 	SV_MENS_RETORNO VARCHAR2(200);");
		call.append(" 	SN_NUM_EVENTO VARCHAR2(200);");
		call.append(" BEGIN ");
//		call.append(" 	EN_COD_CLIENTE := NULL;");
//		call.append(" 	EN_COD_ABONADO := NULL;");
//		call.append(" 	EN_COD_PRODC := NULL;");
//		call.append(" 	SO_LISTA_SALDO := NULL; ");
//		call.append(" 	SN_COD_RETORNO := NULL;");
//		call.append(" 	SV_MENS_RETORNO := NULL;");
//		call.append(" 	SN_NUM_EVENTO := NULL;");
		call.append(" 	TOL_PRODUCTO_CONTRATADO_PG.TOL_SALDO_PRODUCTO_PR ( ?, ?, ?, ?, ?, ?, ? );");
		call.append(" END; ");
		
		return call.toString();
	}
	
	public RetornoDTO eliminar(ProductoContratadoListDTO listProductoContratado) throws ServiceException 
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;		
		Connection conn = null;
		OracleCallableStatement cstmt = null;
		
		String call=getSQLEliminar();
		try 
		{		
			conn = getConnectionFromWLSInitialContext(global.getJndiForTOLDataSource());			
			cstmt = (OracleCallableStatement)conn.prepareCall(call);			
			StructDescriptor sd = StructDescriptor.createDescriptor("TOL_BAJA_PRODUCTO_QT", conn);			
			ArrayDescriptor ad=null;
			ARRAY aux =null;			
			STRUCT[] arreglo=listProductoContratado.getOracleArray_TOL_BAJA_PRODUCTO_DET_QT(sd, conn);			
			ad = ArrayDescriptor.createDescriptor("TOL_BAJA_PRODUCTO_DET_QT", conn);
			aux = new ARRAY(ad, conn, arreglo);
			
			cstmt.setARRAY(1, aux);			
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
				logger.error(" Ocurrió un error al crear la lista de numeros");
				throw new ServiceException(String.valueOf(codError),numEvento, msgError);
			}
			
			//obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");
			//ini--------------RESCATAR RETORNO-------
			retorno = new RetornoDTO();
			retorno.setCodigo(String.valueOf(codError));
			retorno.setDescripcion(msgError);
			retorno.setResultado(true);
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
	
	public RetornoDTO informar(ProductoTasacionContratadoListDTO listProductoTol) throws ServiceException 
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;		
		Connection conn = null;
		OracleCallableStatement cstmt = null;
		
		String call=getSQLInformar();
		try 
		{			
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForTOLDataSource());			
			cstmt = (OracleCallableStatement)conn.prepareCall(call);			
			StructDescriptor sd = StructDescriptor.createDescriptor("TOL_ALTA_PRODUCTO_QT", conn);			
			ArrayDescriptor ad=null;
			ARRAY aux =null;			
			STRUCT[] arreglo=listProductoTol.getOracleArray_TOL_ALTA_PRODUCTO_DET_QT(sd, conn);			
			ad = ArrayDescriptor.createDescriptor("TOL_ALTA_PRODUCTO_DET_QT", conn);
			aux = new ARRAY(ad, conn, arreglo);
			
			cstmt.setARRAY(1, aux);
			cstmt.setLong(2, Long.parseLong(listProductoTol.getCodCliente()));	
			cstmt.setString(3, listProductoTol.getCodCanal());	
			cstmt.setString(4, listProductoTol.getCodCicloFacturacion());
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);			
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			
			logger.debug("Actualizacion realizada");
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
				logger.error(" Ocurrió un error al crear la lista de numeros");
				throw new ServiceException(String.valueOf(codError),numEvento, msgError);
			}
			
			//obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");
			//ini--------------RESCATAR RETORNO-------
			retorno = new RetornoDTO();
			retorno.setCodigo(String.valueOf(codError));
			retorno.setDescripcion(msgError);
			retorno.setResultado(true);
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
	
	public SaldoProductoTasacionListDTO saldos(SaldoProductoCliente clienteProducto) throws ServiceException
	{
		logger.debug("eliminar():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		SaldoProductoTasacionListDTO retorno = new SaldoProductoTasacionListDTO();		
		Connection conn = null;
		OracleCallableStatement cstmt = null;
		
		String call = getSQLSaldos();
		try {			
			/*
			 * 
				PROCEDURE TOL_SALDO_PRODUCTO_PR
				(
				   EN_cod_cliente	   IN  tol_cliente.cod_cliente%type,
				   EN_cod_abonado	   IN  tol_cliente.cod_abonado%type,
				   EN_cod_prodc  	   IN  tol_ssclieabo_td.cod_prodc%type,
				   SO_Lista_Saldo      OUT NOCOPY refCursor,
				   SN_cod_retorno      OUT NOCOPY VARCHAR2,
				   SV_mens_retorno     OUT NOCOPY VARCHAR2,
				   SN_num_evento       OUT NOCOPY VARCHAR2
				)
			 * */
			conn = getConnectionFromWLSInitialContext(global.getJndiForTOLDataSource());			
			cstmt = (OracleCallableStatement)conn.prepareCall(call);

			cstmt.setLong(1, Long.parseLong(clienteProducto.getIdCliente()));	
			cstmt.setLong(2, Long.parseLong(clienteProducto.getNumAbonado()));
			cstmt.setLong(3, Long.parseLong(clienteProducto.getCodProduct()));
			cstmt.registerOutParameter(4,oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);			
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			
			retorno.setCodCliente(clienteProducto.getIdCliente());
			/*jaqueline soto*/			
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
				logger.error(" Ocurrió un error al crear la lista de numeros");
				throw new ServiceException(String.valueOf(codError),numEvento, msgError);
			}
			
			//obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");
			//ini--------------RESCATAR RETORNO-------
			SaldoProductoTasacionDTO dto=null;
			SaldoProductoTasacionDTO[] dtoList=null;
			ArrayList retornoOracle=new ArrayList();
			ResultSet rs=(ResultSet)cstmt.getObject(4);
						
			while(rs.next())
			{ 
				dto=new SaldoProductoTasacionDTO();
				
				//B.cod_cliente, B.cod_abonado, B.cod_prodc, B.val_inicial, B.val_consumido, B.val_disponible
				
				dto.setCodCliente(rs.getString("COD_CLIENTE")!=null?rs.getString("COD_CLIENTE") :"");
				dto.setIdAbonado(rs.getString("COD_ABONADO")!=null?rs.getString("COD_ABONADO") :"");
				dto.setCodProducdo(rs.getString("COD_PRODC")!=null?rs.getString("COD_PRODC") :"");
				dto.setValorInicial(rs.getString("VAL_INICIAL")!=null?rs.getString("VAL_INICIAL") :"");
				dto.setValorConsumido(rs.getString("VAL_CONSUMIDO")!=null?rs.getString("VAL_CONSUMIDO") :"");
				dto.setValorDisponible(rs.getString("VAL_DISPONIBLE")!=null?rs.getString("VAL_DISPONIBLE") :"");

				retornoOracle.add(dto);
			}			
			dtoList=(SaldoProductoTasacionDTO[]) ArrayUtl.copiaArregloTipoEspecifico(retornoOracle.toArray(), SaldoProductoTasacionDTO.class);
			retorno.setSaldoProducto(dtoList);
						
			//fin----------------------------------------------------------------------
		
		} catch (ServiceException e) {
			logger.debug("ServiceException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al crear lista de numeros", e);
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


}
