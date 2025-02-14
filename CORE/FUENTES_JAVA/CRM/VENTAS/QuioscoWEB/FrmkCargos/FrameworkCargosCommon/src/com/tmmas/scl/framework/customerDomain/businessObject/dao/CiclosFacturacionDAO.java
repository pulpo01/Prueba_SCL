/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 06/06/2007	     	Elizabeth Vera        				Versión Inicial
 */
package com.tmmas.scl.framework.customerDomain.businessObject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.customerDomain.businessObject.dao.interfaces.CiclosFacturacionDAOIT;
import com.tmmas.scl.framework.customerDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.CicloDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.FinCicloDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerBillException;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;

public class CiclosFacturacionDAO extends ConnectionDAO implements
		CiclosFacturacionDAOIT {

	private final Logger logger = Logger.getLogger(CiclosFacturacionDAO.class);
	private final Global global = Global.getInstance();

	private String getSQLeliminaFinCiclo() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   ciclo PV_CICLOS_FACTURACION_QT:= PV_INICIA_ESTRUCTURAS_PG.PV_CICLOS_FACTURACION_QT_FN;");
		call.append(" BEGIN ");
		call.append("   ciclo.IDOOSS := ?;");
		call.append("   ciclo.CODOOSS := ?;");
		call.append("   ciclo.FECHAEJECUCION := ?;");
		call.append("   ciclo.CODCLIENTE := ?;");
		call.append("   ciclo.NUMABONADO := ?;");
		call.append("   PV_CICLOS_FACTURACION_PG.PV_ELIM_GA_FINCICLO_PR( ciclo, ?, ?, ?);");
		call.append(" END;");	
		return call.toString();		
	}	
	
	private String getSQLobtenerFechaCiclo() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   ciclo PV_FA_CICLFACT_QT := PV_INICIA_ESTRUCTURAS_PG.PV_FA_CICLFACT_QT_FN;");
		call.append(" BEGIN ");
		call.append("   ciclo.COD_CICLO := ?;");
		call.append("   PV_CICLOS_FACTURACION_PG.PV_OBTENER_FECHA_CICLO_PR( ciclo, ?, ?, ?);");
		call.append("   	?:=ciclo.FECHA_CICLO_FEC_DESDELLAM;");
		call.append("   	?:=ciclo.PERIODO_CICLO_COD_CICLFACT;");
		call.append(" END;");	
		return call.toString();		
	}

	private String getSQLvalidarPeriodoFact() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   eo_abonado GA_ABONADO_QT := PV_INICIA_ESTRUCTURAS_PG.PV_INICIA_GA_ABONADO_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_abonado.NUM_ABONADO := ?;");
		call.append("   eo_abonado.COD_CLIENTE := ?;");
		call.append("   eo_abonado.COD_CICLO := ?;");
		call.append("   ? := PV_CICLOS_FACTURACION_PG.PV_VALIDAR_PERIODOFACT_FN( eo_abonado, ?, ?, ?);");
		call.append(" END;");	
		return call.toString();		
	}

	/**
	 * Elimina de la tabla GA_FINCICLO
	 * 
	 * @param finCiclo
	 * @return RetornoDTO
	 * @throws CustomerBillException
	 */
	public RetornoDTO eliminaFinCiclo(FinCicloDTO finCiclo)
			throws CustomerBillException {
		
		logger.debug("eliminaFinCiclo():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLeliminaFinCiclo();
		try {
			
			logger.debug("finCiclo.getIdOSS()()[" + finCiclo.getIdOSS() + "]");
			logger.debug("finCiclo.getcodOSS()()[" + finCiclo.getCodOOSS() + "]");
			logger.debug("finCiclo.getFechaEjecucion()()[" + finCiclo.getFechaEjecucion() + "]");
			logger.debug("finCiclo.getCodCliente()()[" + finCiclo.getCodCliente() + "]");
			logger.debug("finCiclo.getNumAbonado()()[" + finCiclo.getNumAbonado() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, finCiclo.getIdOSS());
			cstmt.setString(2, finCiclo.getCodOOSS());
			cstmt.setString(3, finCiclo.getFechaEjecucion());
			cstmt.setLong(4, finCiclo.getCodCliente());
			cstmt.setLong(5, finCiclo.getNumAbonado());
			
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);			
		
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(6);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(7);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(8);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al eliminar fin ciclo");
				throw new CustomerBillException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			retorno = new RetornoDTO();
			retorno.setDescripcion(msgError);
		
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
		logger.debug("eliminaFinCiclo():end");
		return retorno;
		
	}

	/**
	 * Obtiene fecha y periodo de facturación de ciclo
	 * 
	 * @param ciclo
	 * @return cicloDTO
	 * @throws CustomerBillException
	 */	
	public CicloDTO obtenerFechaCiclo(CicloDTO ciclo) throws CustomerBillException{
		logger.debug("obtenerFechaCiclo():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		CicloDTO respuesta = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerFechaCiclo();
		try {
			
			logger.debug("ciclo.getCodCiclo()[" + ciclo.getCodCiclo() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setInt(1, ciclo.getCodCiclo()); //COD_CICLO
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);			
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR); //FECHA_CICLO_FEC_DESDELLAM
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC); //PERIODO_CICLO_COD_CICLFACT
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
				logger.error(" Ocurrió un error al obtener periodo facturación de ciclo");
				throw new CustomerBillException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			String fecCicloDesdeLlam = cstmt.getString(5);
			logger.debug("fecCicloDesdeLlam[" + fecCicloDesdeLlam + "]");
			int perCodCicloFact = cstmt.getInt(6);
			logger.debug("perCodCicloFact[" + perCodCicloFact + "]");
			
			respuesta = new CicloDTO();
			respuesta.setFecDesdeLlam(fecCicloDesdeLlam);
			respuesta.setPeriodoCodCiclFact(perCodCicloFact);
		
		} catch (CustomerBillException e) {
			logger.debug("CustomerBillException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener periodo facturación de ciclo", e);
			throw new CustomerBillException("Ocurrió un error general al obtener periodo facturación de ciclo",e);
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
		logger.debug("obtenerFechaCiclo():end");
		return respuesta;		
	}
	
	/**
	 * Valida perido de facturacion
	 * 
	 * @param abonado
	 * @return RetornoDTO
	 * @throws CustomerBillException
	 */	
	public RetornoDTO validarPeriodoFact(AbonadoDTO abonado) throws CustomerBillException{
		logger.debug("validarPeriodoFact():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO respuesta = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLvalidarPeriodoFact();
		try {
			
			logger.debug("abonado.getNumAbonado() [" + abonado.getNumAbonado() + "]");
			logger.debug("abonado.getCodCliente() [" + abonado.getCodCliente() + "]");
			logger.debug("abonado.getCodCiclo() [" + abonado.getCodCiclo() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setLong(1, abonado.getNumAbonado()); //NUM_ABONADO
			cstmt.setLong(2, abonado.getCodCliente()); //COD_CLIENTE
			cstmt.setInt(3, abonado.getCodCiclo()); //COD_CICLO
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR); //RESULTADO
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
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al validar periodo de facturación");
				throw new CustomerBillException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			String res = cstmt.getString(4);
			logger.debug("res[" + res + "]");
			
			respuesta = new RetornoDTO();
			respuesta.setResultado((res.equalsIgnoreCase("TRUE"))?true:false);

		
		} catch (CustomerBillException e) {
			logger.debug("CustomerBillException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al validar periodo de facturación", e);
			throw new CustomerBillException("Ocurrió un error general al validar periodo de facturación",e);
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
		logger.debug("validarPeriodoFact():end");
		return respuesta;		
	}
}
