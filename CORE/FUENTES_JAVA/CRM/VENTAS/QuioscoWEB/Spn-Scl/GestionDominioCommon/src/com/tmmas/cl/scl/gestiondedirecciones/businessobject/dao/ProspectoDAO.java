package com.tmmas.cl.scl.gestiondedirecciones.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.helper.Global;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.ProspectoDTO;


public class ProspectoDAO extends ConnectionDAO{
	private final Logger logger = Logger.getLogger(ProspectoDAO.class);

	Global global = Global.getInstance();
	
	private Connection getConection() 
	throws GeneralException
	{
		Connection conn = null;
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
		} catch (Exception e1) {
			conn = null;
			logger.error(" No se pudo obtener una conexión ", e1);
			throw new GeneralException("No se pudo obtener una conexión", e1);
		}
		return conn;
	}//fin getConection
	
	private String getSQLDatos(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
        for (int n = 1; n <= paramCount; n++) {
            sb.append("?");
            if (n < paramCount) sb.append(",");
        }
        return sb.append(")}").toString();
	}//fin getSQLDatos
	
	/**
	 * Obtiene prospecto del Cliente
	 * @param prospecto
	 * @return resultado
	 * @throws GeneralException
	 */
	public ProspectoDTO getProspectoCliente(ProspectoDTO entrada) 
	throws GeneralException{
		logger.debug("Inicio:getProspectoCliente");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		ProspectoDTO prospectoDTO =null;
		logger.debug("Coneccion obtenida OK");
		try {
			//INI-01 (AL) String call = getSQLDatos("VE_alta_cliente_PG","VE_getProspectoCliente_PR",19);
			String call = getSQLDatos("VE_alta_cliente_Quiosco_PG","VE_getProspectoCliente_PR",19);
			logger.debug("sql[" + call + "]");
			
			CallableStatement cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,entrada.getCodigoTipoIdent());
			cstmt.setString(2,entrada.getNumeroIdent());

			cstmt.registerOutParameter(3,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(12,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(13,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(14,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(15,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(16,java.sql.Types.VARCHAR);
			
			cstmt.registerOutParameter(17,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(18,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(19,java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getProspectoCliente:Execute");
			cstmt.execute();
			logger.debug("Fin:getProspectoCliente:Execute");

			codError = cstmt.getInt(17);
			msgError = cstmt.getString(18);
			numEvento = cstmt.getInt(19);

			if (codError == 0) {
				prospectoDTO = entrada;
				entrada.setNombre(cstmt.getString(3));
				entrada.setApellido1(cstmt.getString(4));
				entrada.setApellido2(cstmt.getString(5));
				entrada.setNumeroTelefono1(cstmt.getString(6));
				entrada.setNumeroTelefono2(cstmt.getString(7));
				entrada.setNumeroFax(cstmt.getString(8));
				entrada.setNombreReprLegal(cstmt.getString(9));
				entrada.setCodigoTipoIdentRepr(cstmt.getString(10));
				entrada.setNumeroIdentRepr(cstmt.getString(11));
				entrada.setCodigoRubro(cstmt.getInt(12));
				entrada.setCodigoBanco(cstmt.getString(13));
				entrada.setNumeroCuenta(cstmt.getString(14));
				entrada.setCodigoTipotarjeta(cstmt.getString(15));
				entrada.setNumeroTarjeta(cstmt.getString(16));
			}
			else{
				logger.error("Ocurrió un error al obtener prospecto del Cliente");
				if (logger.isDebugEnabled()) {
					logger.debug("Codigo de Error[" + codError + "]");
					logger.debug("Mensaje de Error[" + msgError + "]");
					logger.debug("Numero de Evento[" + numEvento + "]");
				}
				throw new GeneralException(
						"Ocurrió un error al obtener prospecto del Cliente", String
						.valueOf(codError), numEvento, msgError);
				
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			logger.error("Ocurrió un error al obtener prospecto del Cliente",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw(e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener prospecto del Cliente",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
				logger.debug("Cerrando conexiones...");
	    try {
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				logger.debug("SQLException", e);
		  }
		}
		logger.debug("Fin:getProspectoCliente");
		return prospectoDTO;
	}//fin getProspectoCliente

	/**
	 * Obtiene prospecto de la direccion
	 * @param prospecto
	 * @return resultado
	 * @throws GeneralException
	 */
	public ProspectoDTO getProspectoDireccion(ProspectoDTO entrada) 
	throws GeneralException{
		logger.debug("Inicio:getProspectoDireccion");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		logger.debug("Coneccion obtenida OK");
		try {
			//INI.01 (AL) String call = getSQLDatos("VE_alta_cliente_PG","VE_getProspectoDireccion_PR",6);
			String call = getSQLDatos("VE_alta_cliente_Quiosco_PG","VE_getProspectoDireccion_PR",6);
			logger.debug("sql[" + call + "]");
			
			CallableStatement cstmt = conn.prepareCall(call);
			
			cstmt.setInt(1,entrada.getCodigoProspecto());
			cstmt.setString(2,entrada.getTipoDireccion());

			cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
			
			cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6,java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getProspectoDireccion:Execute");
			cstmt.execute();
			logger.debug("Fin:getProspectoDireccion:Execute");

			
			
			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);

			if (codError == 0) {
				entrada.setCodigoDireccion(cstmt.getInt(3));	
			}
			else{
				logger.error("Ocurrió un error al obtener prospecto de la direccion");
				if (logger.isDebugEnabled()) {
					logger.debug("Codigo de Error[" + codError + "]");
					logger.debug("Mensaje de Error[" + msgError + "]");
					logger.debug("Numero de Evento[" + numEvento + "]");
				}
				throw new GeneralException(
						"Ocurrió un error al obtener prospecto de la direccion", String
						.valueOf(codError), numEvento, msgError);
				
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			logger.error("Ocurrió un error al obtener prospecto de la direccion",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw(e);
		}catch (Exception e) {
			logger.error("Ocurrió un error al obtener prospecto de la direccion",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
				logger.debug("Cerrando conexiones...");
	    try {
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				logger.debug("SQLException", e);
		  }
		}
		logger.debug("Fin:getProspectoDireccion");
		return entrada;
	}//fin getProspectoDireccion

}//fin class ProspectoDAO
