package com.tmmas.scl.framework.customerDomain.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.ProductDomain.dto.BodegaDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.SesionDTO;
import com.tmmas.scl.framework.customerDomain.dao.interfaces.VendedorDAOIT;
import com.tmmas.scl.framework.customerDomain.dto.VendedorDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerException;
import com.tmmas.scl.framework.customerDomain.helper.Global;

public class VendedorDAO extends ConnectionDAO implements VendedorDAOIT {
	
	private final Logger logger = Logger.getLogger(ClienteDAO.class);
	private final Global global = Global.getInstance();
	
	private String getSQLobtenerEstadoVendedor() {
		StringBuffer call = new StringBuffer();
		
		call.append(" BEGIN ");
		call.append("   VE_BLOQUE_VENDEDOR_PG.VE_REC_ESTADO_VENDEDOR_PR ( ?, ?, ?, ?, ? );");		
		call.append(" END;");
		
		return call.toString();		
	}		
	
	private String getSQLdesbloquearVendedor() {
		StringBuffer call = new StringBuffer();
		
		call.append(" BEGIN ");
		call.append("   VE_BLOQUE_VENDEDOR_PG.VE_DESBLOQUEO_VENDEDOR_PR ( ?, ?, ?, ? );");		
		call.append(" END;");
		
		return call.toString();		
	}		
	
	private String getSQLbloquearVendedor() {
		StringBuffer call = new StringBuffer();
		
		call.append(" BEGIN ");
		call.append("   VE_BLOQUE_VENDEDOR_PG.VE_BLOQUEO_VENDEDOR_PR ( ?, ?, ?, ? );");		
		call.append(" END;");
		
		return call.toString();		
	}	
	
	
	private String getSQLvalidaVendedorbodega() {
		StringBuffer call = new StringBuffer();
		
		call.append(" DECLARE ");
		call.append(" RetVal BOOLEAN; ");
		call.append(" BEGIN ");
		call.append("   RetVal := PV_CAMBIO_SIMCARD_SB_PG.PV_VERIFICA_VENDEDOR_BODEGA_FN ( ?, ?, ?, ?, ?, ? );");		
		call.append(" END;");
		
		return call.toString();		
	}	
 
	
	
	
	public VendedorDTO obtenerEstadoVendedor(VendedorDTO Vendedor)
	throws CustomerException {
		
		logger.debug("obtenerEstadoVendedor():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerEstadoVendedor();
		try {
			logger.debug("Parámetros de entrada");
			logger.debug("cliente.getCodCliente()[" + Vendedor.getCod_vendedor() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setLong(1, Vendedor.getCod_vendedor());
			cstmt.registerOutParameter(2, java.sql.Types.BOOLEAN);
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
			
			if (codError != 0) {
				logger.error("Ocurrió un error al recuperar los datos del vendedor");
				throw new CustomerException(String.valueOf(codError),numEvento, msgError);
			}

			//obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");
			
			Vendedor.setVe_indbloqueo(cstmt.getBoolean(2));
			
		} catch (CustomerException e) {
			logger.debug("CustomerException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al recuperar al recuperar los datos del vendedor", e);
			throw new CustomerException("Ocurrió un error general al recuperar los datos del vendedor",e);
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
		logger.debug("obtenerEstadoVendedor():end");
		return Vendedor;
		
	}	
	
	public void bloquearVendedor(VendedorDTO vendedor)
	throws CustomerException {

		logger.debug("bloquearVendedor():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLbloquearVendedor();
		try {
		
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			logger.debug("Parámetros de entrada");
			logger.debug("vendedor.getCod_vendedor() [" + vendedor.getCod_vendedor()+"]");
			
			cstmt.setLong(1, vendedor.getCod_vendedor());
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
				logger.error(" Ocurrió un error al bloquear al vendedor");
				throw new CustomerException(String.valueOf(codError),numEvento, msgError);
			}

			
		} catch (CustomerException e) {
			logger.debug("CustomerException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al bloquear al vendedor", e);
			throw new CustomerException("Ocurrió un error general al bloquear al vendedor",e);
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
		logger.debug("bloquearVendedor():end");		
		
	}
	
	public void desbloquearVendedor(VendedorDTO vendedor) 
	throws CustomerException {
	
		
		
		logger.debug("desbloquearVendedor():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLdesbloquearVendedor();
		try {
		
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			logger.debug("Parámetros de entrada");
			logger.debug("vendedor.getCod_vendedor() ["+vendedor.getCod_vendedor()+"]");
			cstmt.setLong(1, vendedor.getCod_vendedor());
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
				logger.error(" Ocurrió un error al recuperar desbloquear al vendedor");
				throw new CustomerException(String.valueOf(codError),numEvento, msgError);
			}

			
		} catch (CustomerException e) {
			logger.debug("CustomerException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al recuperar al desbloquear al vendedor", e);
			throw new CustomerException("Ocurrió un error general al desbloquear al vendedor",e);
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
		logger.debug("desbloquearVendedor():end");				
	}			
	
	public void validaVendedorbodega(VendedorDTO vendedor, SesionDTO sesion, BodegaDTO bodega) throws CustomerException {

		
		logger.debug("validaVendedorbodega():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLvalidaVendedorbodega();
		try {
		
			logger.debug("78629");
			logger.debug(call);
	
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			cstmt = conn.prepareCall(call);
			logger.debug("Parámetros de entrada");
			logger.debug("vendedor.getCod_vendedor() [" + vendedor.getCod_vendedor()+"]");
			logger.debug("sesion.getCodCliente() ["+sesion.getCodCliente()+"]");
			logger.debug("bodega.getCod_bodega() ["+bodega.getCod_bodega()+"]");
			cstmt.setLong(1, vendedor.getCod_vendedor());
			cstmt.setLong(2, sesion.getCodCliente());
			cstmt.setString(3, bodega.getCod_bodega());								
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);	

			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(4);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(5);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(6);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al validar al vendedor bodega");
				throw new CustomerException(String.valueOf(codError),numEvento, msgError);
			}

			//obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");
			
		} catch (CustomerException e) {
			logger.debug("CustomerException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al recuperar al validar al vendedor bodega", e);
			throw new CustomerException("Ocurrió un error general al validar al vendedor bodega",e);
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
		logger.debug("validaVendedorbodega():end");				
	}		
}
