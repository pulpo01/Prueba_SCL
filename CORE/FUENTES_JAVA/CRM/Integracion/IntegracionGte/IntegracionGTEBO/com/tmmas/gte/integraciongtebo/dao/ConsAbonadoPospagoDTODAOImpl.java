/**
* Generated file - You can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/

package com.tmmas.gte.integraciongtebo.dao;
import java.util.ArrayList;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.gte.integraciongtebo.helper.Global;
import com.tmmas.cl.framework20.util.ServiceLocator;

public class ConsAbonadoPospagoDTODAOImpl extends com.tmmas.cl.framework.base.ConnectionDAO implements ConsAbonadoPospagoDTODAO{
	private CompositeConfiguration config;
	private static Logger logger = Logger.getLogger(ConsAbonadoPospagoDTODAOImpl.class);
	private Global global = Global.getInstance();
	private ServiceLocator  serviceLocator = ServiceLocator.getInstance();

	public ConsAbonadoPospagoDTODAOImpl() {
		config = UtilProperty.getConfiguration("IntegracionGte.properties", "com/tmmas/gte/integraciongtebo/properties/IntegracionGTEBO.properties");
	}

	/**
	* Retorna numAbonado y codCliente a partir de un numCelular pospago
	*/
	public com.tmmas.gte.integraciongtecommon.dto.AbonadoPospagoOutDTO consultarAbonadoPospago(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("consultarAbonadoPospago:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.AbonadoPospagoOutDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.AbonadoPospagoOutDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call GE_INTEGRACION_PG.ge_cons_abo_pospago_pr(?,?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setLong(1,inParam0.getNumeroTelefono());
			logger.debug("numeroTelefono[" + inParam0.getNumeroTelefono() + "]");

			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.AbonadoPospagoDTO outParam1 = new com.tmmas.gte.integraciongtecommon.dto.AbonadoPospagoDTO();
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam2 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(2,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6,java.sql.Types.NUMERIC);

			logger.info("execute():antes");
			cstmt.execute();
			logger.info("execute():despues");

			logger.info("setea respuesta de stored procedure...");
			outParam2.setCodigoError(cstmt.getInt(4));
			logger.debug("codigoError[" + outParam2.getCodigoError() + "]");

			outParam2.setMensajeError(cstmt.getString(5));
			logger.debug("mensajeError[" + outParam2.getMensajeError() + "]");

			outParam2.setNumeroEvento(cstmt.getLong(6));
			logger.debug("numeroEvento[" + outParam2.getNumeroEvento() + "]");

			logger.info("verifica condicion de error del stored procedure...");
			if(outParam2.getCodigoError() != 0 ) {
				logger.info("Codigo de error != 0");
				outParam0.setRespuesta(outParam2);
				return outParam0;
			}
			logger.info("seteando clase de  repuesta a la clase padre...");
			outParam0.setRespuesta(outParam2);

			outParam1.setNumAbonado(cstmt.getLong(2));
			logger.debug("numAbonado[" + outParam1.getNumAbonado() + "]");

			outParam1.setCodCliente(cstmt.getLong(3));
			logger.debug("codCliente[" + outParam1.getCodCliente() + "]");

			logger.info("Seteando propiedades hijas a la clase padre...");
			ArrayList listaNueva = new ArrayList();
			listaNueva.add(outParam1);

			outParam0.setListadoClientes((com.tmmas.gte.integraciongtecommon.dto.AbonadoPospagoDTO[])
					com.tmmas.cl.framework.util.ArrayUtl.copiaArregloTipoEspecifico(listaNueva.toArray(),
											com.tmmas.gte.integraciongtecommon.dto.AbonadoPospagoDTO.class));
			
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

		logger.info("consultarAbonadoPospago:end()");
		return outParam0;
	}


}