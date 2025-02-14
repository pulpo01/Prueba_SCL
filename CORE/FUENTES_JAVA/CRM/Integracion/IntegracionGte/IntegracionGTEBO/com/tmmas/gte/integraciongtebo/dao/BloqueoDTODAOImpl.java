/**
* Generated file - You can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/

package com.tmmas.gte.integraciongtebo.dao;
import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.gte.integraciongtebo.helper.Global;
import com.tmmas.cl.framework20.util.ServiceLocator;

public class BloqueoDTODAOImpl extends com.tmmas.cl.framework.base.ConnectionDAO implements BloqueoDTODAO{
	private CompositeConfiguration config;
	private static Logger logger = Logger.getLogger(BloqueoDTODAOImpl.class);
	private Global global = Global.getInstance();
	private ServiceLocator  serviceLocator = ServiceLocator.getInstance();

	public BloqueoDTODAOImpl() {
		config = UtilProperty.getConfiguration("IntegracionGte.properties", "com/tmmas/gte/integraciongtebo/properties/IntegracionGTEBO.properties");
	}

	/**
	* se ingresa un numero de abonado, el metodo retorna el BloqueoDTO Los datos correspondiente a pospago
	* 
	*/
	public com.tmmas.gte.integraciongtecommon.dto.BloqueoDTO consultarBloqueoTelefonoPospago(com.tmmas.gte.integraciongtecommon.dto.BloqueoInDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("consultarBloqueoTelefono:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.BloqueoDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.BloqueoDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call GE_INTEGRACION_PG.GE_CONS_TEL_BLOQ_POSP_PR(?,?,?,?,?,?,?,?,?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setLong(1,inParam0.getCodAbonado());
			logger.debug("codAbonado[" + inParam0.getCodAbonado() + "]");

			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam1 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(2,java.sql.Types.DATE);
			cstmt.registerOutParameter(3,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4,java.sql.Types.DATE);
			cstmt.registerOutParameter(5,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(10,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(12,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(13,java.sql.Types.NUMERIC);

			logger.info("execute():antes");
			cstmt.execute();
			logger.info("execute():despues");

			logger.info("setea respuesta de stored procedure...");
			outParam1.setCodigoError(cstmt.getInt(11));
			logger.debug("codigoError[" + outParam1.getCodigoError() + "]");

			outParam1.setMensajeError(cstmt.getString(12));
			logger.debug("mensajeError[" + outParam1.getMensajeError() + "]");

			outParam1.setNumeroEvento(cstmt.getLong(13));
			logger.debug("numeroEvento[" + outParam1.getNumeroEvento() + "]");

			logger.info("verifica condicion de error del stored procedure...");
			if(outParam1.getCodigoError() != 0 ) {
				logger.info("Codigo de error != 0");
				outParam0.setRespuesta(outParam1);
				return outParam0;
			}
			logger.info("seteando clase de  repuesta a la clase padre...");
			outParam0.setRespuesta(outParam1);

			outParam0.setFecSuspbd(new java.util.Date(cstmt.getDate(2).getTime()));
			logger.debug("fecSuspbd[" + outParam0.getFecSuspbd() + "]");

			outParam0.setNumTerminal(cstmt.getString(3));
			logger.debug("numTerminal[" + outParam0.getNumTerminal() + "]");

			outParam0.setFecSuspcen(new java.util.Date(cstmt.getDate(4).getTime()));
			logger.debug("fecSuspcen[" + outParam0.getFecSuspcen() + "]");

			outParam0.setCodCaususp(cstmt.getString(5));
			logger.debug("codCaususp[" + outParam0.getCodCaususp() + "]");

			outParam0.setDesCaususp(cstmt.getString(6));
			logger.debug("desCaususp[" + outParam0.getDesCaususp() + "]");

			outParam0.setIndFraude(cstmt.getLong(7));
			logger.debug("indFraude[" + outParam0.getIndFraude() + "]");

			outParam0.setCodTipfraude(cstmt.getString(8));
			logger.debug("codTipfraude[" + outParam0.getCodTipfraude() + "]");

			outParam0.setTipSuspencion(cstmt.getLong(9));
			logger.debug("tipSuspencion[" + outParam0.getTipSuspencion() + "]");

			outParam0.setDesValor(cstmt.getString(10));
			logger.debug("desValor[" + outParam0.getDesValor() + "]");

		}
		catch (java.sql.SQLException e) {
			logger.error("SQLException", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("SQLException", e);
		}
		catch (java.lang.Exception e) {
			logger.error("Exception", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("Exception", e);
		}
		finally {
			try {
				if (cstmt != null) {
					cstmt.close();
					cstmt = null;
				}
				if (conn != null) {
					conn.close();
					conn = null;
				}
			}
			catch (java.sql.SQLException e) {
				logger.error("SQLException", e);
				cstmt = null;
				conn = null;
			}
		}

		logger.info("consultarBloqueoTelefono:end()");
		return outParam0;
	}
	
	/**
	* se ingresa un numero de abonado, el metodo retorna el BloqueoDTO Los datos correspondiente a una prepago
	*/
	public com.tmmas.gte.integraciongtecommon.dto.BloqueoDTO consultarBloqueoTelefonoPrepago(com.tmmas.gte.integraciongtecommon.dto.BloqueoInDTO inParam0)
	 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("consultarBloqueoTelefonoPrepago:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.BloqueoDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.BloqueoDTO();
		
		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}
		
		try {
			String call = "{call GE_INTEGRACION_PG.GE_CONS_TEL_BLOQ_PREP_PR(?,?,?,?,?,?,?,?,?,?,?,?,?)}";
			logger.info("call[" + call + "]");
		
			cstmt = conn.prepareCall(call);
		
			logger.info("armar parametros de entrada...");
			cstmt.setLong(1,inParam0.getCodAbonado());
			logger.debug("codAbonado[" + inParam0.getCodAbonado() + "]");
		
			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam1 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();
		
			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(2,java.sql.Types.DATE);
			cstmt.registerOutParameter(3,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4,java.sql.Types.DATE);
			cstmt.registerOutParameter(5,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(10,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(12,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(13,java.sql.Types.NUMERIC);
		
			logger.info("execute():antes");
			cstmt.execute();
			logger.info("execute():despues");
		
			logger.info("setea respuesta de stored procedure...");
			outParam1.setCodigoError(cstmt.getInt(11));
			logger.debug("codigoError[" + outParam1.getCodigoError() + "]");
		
			outParam1.setMensajeError(cstmt.getString(12));
			logger.debug("mensajeError[" + outParam1.getMensajeError() + "]");
		
			outParam1.setNumeroEvento(cstmt.getLong(13));
			logger.debug("numeroEvento[" + outParam1.getNumeroEvento() + "]");
		
			logger.info("verifica condicion de error del stored procedure...");
			if(outParam1.getCodigoError() != 0 ) {
				logger.info("Codigo de error != 0");
				outParam0.setRespuesta(outParam1);
				return outParam0;
			}
			logger.info("seteando clase de  repuesta a la clase padre...");
			outParam0.setRespuesta(outParam1);
		
			outParam0.setFecSuspbd(new java.util.Date(cstmt.getDate(2).getTime()));
			logger.debug("fecSuspbd[" + outParam0.getFecSuspbd() + "]");
		
			outParam0.setNumTerminal(cstmt.getString(3));
			logger.debug("numTerminal[" + outParam0.getNumTerminal() + "]");
		
			outParam0.setFecSuspcen(new java.util.Date(cstmt.getDate(4).getTime()));
			logger.debug("fecSuspcen[" + outParam0.getFecSuspcen() + "]");
		
			outParam0.setCodCaususp(cstmt.getString(5));
			logger.debug("codCaususp[" + outParam0.getCodCaususp() + "]");
		
			outParam0.setDesCaususp(cstmt.getString(6));
			logger.debug("desCaususp[" + outParam0.getDesCaususp() + "]");
		
			outParam0.setIndFraude(cstmt.getLong(7));
			logger.debug("indFraude[" + outParam0.getIndFraude() + "]");
		
			outParam0.setCodTipfraude(cstmt.getString(8));
			logger.debug("codTipfraude[" + outParam0.getCodTipfraude() + "]");
		
			outParam0.setTipSuspencion(cstmt.getLong(9));
			logger.debug("tipSuspencion[" + outParam0.getTipSuspencion() + "]");
		
			outParam0.setDesTipsuspension(cstmt.getString(10));
			logger.debug("desTipsuspension[" + outParam0.getDesTipsuspension() + "]");
		
		}
		catch (java.sql.SQLException e) {
			logger.error("SQLException", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("SQLException", e);
		}
		catch (java.lang.Exception e) {
			logger.error("Exception", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("Exception", e);
		}
		finally {
			try {
				if (cstmt != null) {
					cstmt.close();
					cstmt = null;
				}
				if (conn != null) {
					conn.close();
					conn = null;
				}
			}
			catch (java.sql.SQLException e) {
				logger.error("SQLException", e);
				cstmt = null;
				conn = null;
			}
		}
		
		logger.info("consultarBloqueoTelefonoPrepago:end()");
		return outParam0;
	}

}