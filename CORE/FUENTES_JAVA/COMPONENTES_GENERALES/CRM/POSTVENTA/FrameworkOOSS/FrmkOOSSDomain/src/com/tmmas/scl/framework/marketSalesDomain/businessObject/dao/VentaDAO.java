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
package com.tmmas.scl.framework.marketSalesDomain.businessObject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.marketSalesDomain.businessObject.dao.interfaces.VentaDAOIT;
import com.tmmas.scl.framework.marketSalesDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.marketSalesDomain.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.marketSalesDomain.exception.ContactLeadProspectException;

public class VentaDAO extends ConnectionDAO implements VentaDAOIT
{
	private final Logger logger = Logger.getLogger(VentaDAO.class);
	private final Global global = Global.getInstance();

	private String getSQLactualizarEstado() {
		/**
		 * DEBE CAMBIAR LA LLAMADA AL PL CORRESPONDIENTE 
		 */
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   eo_cliente PV_CLIENTE_QT := PV_INICIA_ESTRUCTURAS_PG.PV_INICIA_PV_CLIENTE_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_cliente.COD_CUENTA := ?;");
		call.append("   PV_CUENTA_PG.PV_OBTIENE_CLIENTE_CUENTA_PR( eo_cliente, ?, ?, ?, ?, ?, ?);");
		call.append(" END;");		
		return call.toString();		
	}
	
	
	public RetornoDTO actualizarEstado(VentaDTO venta) throws ContactLeadProspectException {
		logger.debug("actualizarEstado():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLactualizarEstado();
		try {
			
			logger.debug("venta.getIdVenta()[" + venta.getIdVenta() + "]");			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());			
			cstmt = conn.prepareCall(call);
			
			// SE LLENAN PARAMETROS SEGUN PL
			//cstmt.setArray(1, listaNumeros.getNumerosDTO());
			//ini------------------CONTINUAR CARGA DE PARAMETROS-------------------
			
			//cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			//cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			//cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);			
		
			logger.debug("execute:antes");
			//cstmt.execute();
				
			
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
				throw new ContactLeadProspectException(String.valueOf(codError),numEvento, msgError);
			}
			
			//obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");
			//ini--------------RESCATAR RETORNO-------
			retorno = new RetornoDTO();
			
			logger.debug("Venta DAO [OK]");
			retorno.setCodigo("1");
			retorno.setDescripcion("LLEGO OK");
			//fin----------------------------------------------------------------------
		
		} catch (ContactLeadProspectException e) {
			logger.debug("ContactLeadProspectException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al eliminar fin ciclo", e);
			throw new ContactLeadProspectException("Ocurrió un error general al eliminar fin ciclo",e);
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
		logger.debug("actualizarEstado():end");
		return retorno;		
	}
	

}
