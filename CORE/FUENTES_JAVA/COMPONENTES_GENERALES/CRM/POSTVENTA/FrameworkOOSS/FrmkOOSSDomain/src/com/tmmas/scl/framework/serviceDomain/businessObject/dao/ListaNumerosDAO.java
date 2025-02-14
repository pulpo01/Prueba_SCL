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
 * 25-06-2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.serviceDomain.businessObject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

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
import com.tmmas.scl.framework.productDomain.dataTransferObject.ProductoContratadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;
import com.tmmas.scl.framework.serviceDomain.businessObject.dao.interfaces.ListaNumerosDAOIT;
import com.tmmas.scl.framework.serviceDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.NumeroDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.NumeroListDTO;
import com.tmmas.scl.framework.serviceDomain.exception.ServiceException;

public class ListaNumerosDAO extends ConnectionDAO implements ListaNumerosDAOIT
{
	
	private final Logger logger = Logger.getLogger(ListaNumerosDAO.class);
	private final Global global = Global.getInstance();
	
	private String getSQLactualizarNumerosAfines() {
		StringBuffer call = new StringBuffer();
		//AGREGAR INVOCACION A PL
		return call.toString();		
	}		
	private String getSQLactualizarNumerosFrecuentes() {
		StringBuffer call = new StringBuffer();
		//AGREGAR INVOCACION A PL
		return call.toString();		
	}	
	private String getSQLcrearNumerosAfines() {
		StringBuffer call = new StringBuffer();
		//AGREGAR INVOCACION A PL
		return call.toString();		
	}		
	private String getSQLcrearNumerosFrecuentes() {
		StringBuffer call = new StringBuffer();
		//AGREGAR INVOCACION A PL
		return call.toString();		
	}
	
	private String getSQLCrear()
	{
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   EO_LIST_CONTRAT SV_LISTA_CONTRA_TO_LST_QT; ");
		call.append("   SN_COD_RETORNO NUMBER; ");
		call.append("   SV_MENS_RETORNO VARCHAR2(200); ");
		call.append("   SN_NUM_EVENTO NUMBER; ");
		call.append(" BEGIN ");
		call.append("   SV_LISTA_CONTRATADA_PG.SV_CONTRATA_I_PR(?,?,?,?); ");
		call.append(" END; ");
		return call.toString();			
	}
	
	private String getSQLEliminaNumero()
	{
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   EO_LIST_CONTRAT SV_LISTA_CONTRA_TO_LST_QT; ");
		call.append("   SN_COD_RETORNO NUMBER; ");
		call.append("   SV_MENS_RETORNO VARCHAR2(200); ");
		call.append("   SN_NUM_EVENTO NUMBER; ");
		call.append(" BEGIN ");
		call.append("   SV_LISTA_CONTRATADA_PG.SV_CONTRATA_U_PR(?,?,?,?); ");
		call.append(" END; ");
		return call.toString();			
	}
	
	private String getSQLEliminar()
	{
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   EO_LISTA_PRODUCTOS SV_PROD_CONTR_LST_QT; ");
		call.append("   SN_COD_RETORNO NUMBER; ");
		call.append("   SV_MENS_RETORNO VARCHAR2(200); ");
		call.append("   SN_NUM_EVENTO NUMBER; ");
		call.append(" BEGIN ");
		call.append("   SV_LISTA_CONTRATADA_PG.SV_PRODUCTO_D_PR(?,?,?,?); ");    
		call.append(" END; ");
		return call.toString();		
	}
	
	private String getSQLobtenerListaNumeros()
	{
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append(" EO_LIST_CONTRAT SV_PROD_CONTRA_QT; ");
		call.append(" BEGIN ");		
		call.append(" SV_LISTA_CONTRATADA_PG.SV_PRODUCTO_S_PR(?,?,?,?,?); ");    
		call.append(" END; ");
		return call.toString();		
	}
	
	private String getSQLeliminaListaNumeros()
	{
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append(" BEGIN ");
		call.append(" SV_LISTA_CONTRATADA_PG.SV_PRODUCTO_U_PR(?,?,?,?); ");    
		call.append(" END; ");
		return call.toString();				
	}
	
	private String getSQLobtieneModificacionesProducto()
	{
		StringBuffer call = new StringBuffer();
		call.append(" BEGIN ");
		call.append(" SV_LISTA_CONTRATADA_PG.SV_PRODUCTO_CANT_PR(?,?,?,?,?); ");    
		call.append(" END; ");
		return call.toString();				
	}
	
	public RetornoDTO actualizarNumerosAfines(NumeroListDTO listaNumeros) throws ServiceException 
	{
		
		logger.debug("actualizarNumerosAfines():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLactualizarNumerosAfines();
		try {
			
			logger.debug("listaNumeros.getNumerosDTO()[" + listaNumeros.getNumerosDTO().toString() + "]");
			
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
		logger.debug("actualizarNumerosAfines():end");
		return retorno;
		
		
	}

	public RetornoDTO actualizarNumerosFrecuentes(NumeroListDTO listaNumeros) throws ServiceException 
	{
		logger.debug("actualizarNumerosFrecuentes():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLactualizarNumerosFrecuentes();
		try {
			
			logger.debug("listaNumeros.getNumerosDTO()[" + listaNumeros.getNumerosDTO().toString() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			
			// SE LLENAN PARAMETROS SEGUN PL
			//cstmt.setArray(1, listaNumeros.getNumerosDTO());
			//ini------------------CONTINUAR CARGA DE PARAMETROS-------------------
			
			//cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			//cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			//cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);			
		
			logger.debug("execute:antes");
			//  // cstmt.execute();
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
		logger.debug("actualizarNumerosFrecuentes():end");
		return retorno;
		
	}

	public RetornoDTO crearNumerosAfines(NumeroListDTO listaNumeros) throws ServiceException 
	{
		logger.debug("crearNumerosAfines():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLcrearNumerosAfines();
		try {
			
			logger.debug("listaNumeros.getNumerosDTO()[" + listaNumeros.getNumerosDTO().toString() + "]");
			
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
			
			logger.debug("LISTA NUMERO DAO [OK]");
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
		logger.debug("crearNumerosAfines():end");
		return retorno;		
	}

	public RetornoDTO crearNumerosFrecuentes(NumeroListDTO listaNumeros) throws ServiceException 
	{
		logger.debug("crearNumerosFrecuentes():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLcrearNumerosFrecuentes();
		try {
			
			logger.debug("listaNumeros.getNumerosDTO()[" + listaNumeros.getNumerosDTO().toString() + "]");
			
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
			logger.debug("LISTA NUMERO DAO [OK]");
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
		logger.debug("crearNumerosFrecuentes():end");
		return retorno;
	}
	public RetornoDTO eliminar(ProductoContratadoListDTO listaProductosContratados) throws ServiceException 
	{
		logger.debug("eliminar():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;		
		Connection conn = null;
		OracleCallableStatement cstmt = null;
		
		String call = getSQLEliminar();
		try {			
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());			
			cstmt = (OracleCallableStatement)conn.prepareCall(call);
			
			StructDescriptor sd = StructDescriptor.createDescriptor("SV_PROD_CONTRA_QT", conn);			
			ArrayDescriptor ad=null;
			ARRAY aux =null;			
			STRUCT[] arreglo=listaProductosContratados.getOracleArray_SV_PROD_CONTR_LST_QT(sd, conn);			
			ad = ArrayDescriptor.createDescriptor("SV_PROD_CONTR_LST_QT", conn);
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
	
	public NumeroListDTO obtenerListaNumeros(ProductoContratadoDTO productoContratado) throws ServiceException
	{
		logger.debug("eliminar():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		NumeroListDTO retorno = new NumeroListDTO();		
		Connection conn = null;
		OracleCallableStatement cstmt = null;
		
		String call = getSQLobtenerListaNumeros();
		try {			
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());			
			cstmt = (OracleCallableStatement)conn.prepareCall(call);
			
			StructDescriptor sd = StructDescriptor.createDescriptor("SV_PROD_CONTRA_QT", conn);
			STRUCT oracleObject = new STRUCT(sd, conn, productoContratado.toStruct_SV_PROD_CONTRA_QT());
			
			// SE LLENAN PARAMETROS SEGUN PL
			cstmt.setObject(1, oracleObject);
			//cstmt.setObject(1, productoContratado.toStruct_SV_PROD_CONTRA_QT() );
			//cstmt.setLong(1, productoContratado.getIdProdContratado().longValue() );
			cstmt.registerOutParameter(2,oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);			
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(3);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(4);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(5);
			logger.debug("numEvento[" + numEvento + "]");
			//fin----------------------------------------------------------------------
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al crear la lista de numeros");
				throw new ServiceException(String.valueOf(codError),numEvento, msgError);
			}
			
			//obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");
			//ini--------------RESCATAR RETORNO-------
			NumeroDTO dto=null;
			NumeroDTO[] dtoList=null;
			ArrayList retornoOracle=new ArrayList();
			ResultSet rs=(ResultSet)cstmt.getObject(2);
						
			while(rs.next())
			{ 
				dto=new NumeroDTO();
				
				dto.setIdProductoContratado(rs.getString("COD_PROD_CONTRATADO")!=null?rs.getString("COD_PROD_CONTRATADO") :"");
				dto.setNro(rs.getString("VALOR_ELEMENTO")!=null?rs.getString("VALOR_ELEMENTO"):"");
				dto.setFecInicioVigencia(rs.getDate("FEC_INICIO_VIGENCIA")!=null?rs.getDate(("FEC_INICIO_VIGENCIA")):new Date());
				dto.setFecTerminoVigencia(rs.getDate("FEC_TERMINO_VIGENCIA")!=null?rs.getDate(("FEC_TERMINO_VIGENCIA")):new Date());
				dto.setCodCategoriaDest(rs.getString("COD_CATEGORIA_DESTINO")!=null?rs.getString("COD_CATEGORIA_DESTINO"):"");
				dto.setNumProceso(rs.getString("NUM_PROCESO")!=null?rs.getString(("NUM_PROCESO")):"");
				dto.setOrigenProceso(rs.getString("ORIGEN_PROCESO")!=null?rs.getString(("ORIGEN_PROCESO")):"");
				dto.setFecProceso(rs.getDate("FEC_PROCESO")!=null?rs.getDate(("FEC_PROCESO")):new Date());
				retornoOracle.add(dto);
			}
			dtoList=(NumeroDTO[]) ArrayUtl.copiaArregloTipoEspecifico(retornoOracle.toArray(), NumeroDTO.class);
			retorno.setNumerosDTO(dtoList);
						
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
	public RetornoDTO crear(NumeroListDTO listaNumeros) throws ServiceException {
		logger.debug("crear():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;		
		Connection conn = null;
		OracleCallableStatement cstmt = null;
		
		String call = getSQLCrear();
		try {			
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());			
			cstmt = (OracleCallableStatement)conn.prepareCall(call);
			
			StructDescriptor sd = StructDescriptor.createDescriptor("SV_LISTA_CONTRA_TO_QT", conn);					
			STRUCT[] arreglo=listaNumeros.getOracleArray_SV_LISTA_CONTRA_TO_LST_QT(sd, conn);			
			ArrayDescriptor ad = ArrayDescriptor.createDescriptor("SV_LISTA_CONTRA_TO_LST_QT", conn);
			ARRAY aux = new ARRAY(ad, conn, arreglo);
			
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
		logger.debug("crear():end");
		return retorno;
	}
	
	public RetornoDTO eliminaNumero(NumeroDTO numero) throws ServiceException 
	{
		logger.debug("eliminaNumero():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;		
		Connection conn = null;
		OracleCallableStatement cstmt = null;
		
		String call = getSQLEliminaNumero();
		try {			
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());			
			cstmt = (OracleCallableStatement)conn.prepareCall(call);
			
			StructDescriptor sd = StructDescriptor.createDescriptor("SV_LISTA_CONTRA_TO_QT", conn);                   
            STRUCT oracleObject = new STRUCT(sd, conn, numero.toStruct_SV_LISTA_CONTRA_TO_QT());			
						
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
			logger.error("Ocurrió un error general al eliminar lista de numeros", e);
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
		logger.debug("eliminaNumero():end");
		return retorno;
	}
	
	/**
	 * eliminar Lista Numeros
	 * 
	 * @param ProductoContratadoListDTO
	 * @return RetornoDTO
	 * @throws ProductException
	 */	
	public RetornoDTO eliminaListaNumeros(ProductoContratadoListDTO productoContratadoList) throws ServiceException{
		logger.debug("eliminaListaNumeros():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;
		Connection conn = null;
		OracleCallableStatement cstmt = null;
		
		String call = getSQLeliminaListaNumeros();
		try {
		
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = (OracleCallableStatement)conn.prepareCall(call);
			StructDescriptor sd = StructDescriptor.createDescriptor("SV_PROD_CONTRA_QT", conn);			
			ArrayDescriptor ad=null;
			ARRAY aux =null;			
			STRUCT[] arreglo = productoContratadoList.getOracleArray_SV_PROD_CONTR_LST_QT(sd, conn);			
			ad = ArrayDescriptor.createDescriptor("SV_PROD_CONTR_LST_QT", conn);
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
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al obtener lista de causas de baja");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}
			
			retorno = new RetornoDTO();
			retorno.setCodigo(String.valueOf(codError));
			retorno.setDescripcion(msgError);
			retorno.setResultado(true);
			
			
		} catch (ServiceException e) {
			logger.debug("ServiceException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al eliminar Lista Numeros", e);
			throw new ServiceException("Ocurrió un error general al eliminar Lista Numeros",e);
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
		logger.debug("eliminaListaNumeros():end");
		return retorno;		
	}
	
	//---------------------------------------------------------------------------------------------
	/**
	 * eliminar obtiene Modificaciones Producto
	 * 
	 * @param ProductoContratadoDTO
	 * @return NumeroDTO
	 * @throws ProductException
	 */	
	public NumeroDTO obtieneModificacionesProducto(ProductoContratadoDTO productoContratado) throws ServiceException 
	{
		logger.debug("obtieneModificacionesProducto():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		NumeroDTO retorno = null;
		Connection conn = null;
		OracleCallableStatement cstmt = null;
		
		
		String call = getSQLobtieneModificacionesProducto();
		try {		
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());			
			cstmt = (OracleCallableStatement)conn.prepareCall(call);
			
			StructDescriptor sd = StructDescriptor.createDescriptor("SV_PROD_CONTRA_QT", conn);                   
            STRUCT oracleObject = new STRUCT(sd, conn, productoContratado.toStruct_SV_PROD_CONTRA_QT()); 
						
            cstmt.setObject(1, oracleObject);
        	cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);						
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
		
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(3);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(4);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(5);
			logger.debug("numEvento[" + numEvento + "]");
			
			retorno = new NumeroDTO();
			retorno.setNro(String.valueOf(cstmt.getLong(2)));
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al obtener Productos Contratados");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}					
			
		} catch (ServiceException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener Productos Contratados", e);
			throw new ServiceException("Ocurrió un error general al obtener Productos Contratados",e);
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
		logger.debug("obtieneModificacionesProducto():end");
		return retorno;
	}
}
