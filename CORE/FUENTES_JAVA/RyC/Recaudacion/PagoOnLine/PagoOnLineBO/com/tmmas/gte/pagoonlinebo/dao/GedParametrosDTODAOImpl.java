/**
* Generated file - You can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/

package com.tmmas.gte.pagoonlinebo.dao;
import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.gte.pagoonlinebo.helper.Global;
import com.tmmas.cl.framework20.util.ServiceLocator;

public class GedParametrosDTODAOImpl extends com.tmmas.cl.framework.base.ConnectionDAO implements GedParametrosDTODAO{
	private CompositeConfiguration config;
	private static Logger logger = Logger.getLogger(GedParametrosDTODAOImpl.class);
	private Global global = Global.getInstance();
	private ServiceLocator  serviceLocator = ServiceLocator.getInstance();

	public GedParametrosDTODAOImpl() {
		config = UtilProperty.getConfiguration("PagoOnLine.properties", "com/tmmas/gte/pagoonlinebo/properties/PagoOnLineBO.properties");
	}

	/**
	* Obtiene Valor de un parametro en la GED_PARAMETROS
	*/
	public com.tmmas.gte.pagoonlinecommon.dto.GedParametrosDTO obtenerParametro(com.tmmas.gte.pagoonlinecommon.dto.GedParametrosDTO inParam0)
			 throws com.tmmas.gte.pagoonlinecommon.exception.PagoOnLineException{
		logger.info("obtenerParametro:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.pagoonlinecommon.dto.GedParametrosDTO outParam0 = new com.tmmas.gte.pagoonlinecommon.dto.GedParametrosDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.pagoonlinecommon.exception.PagoOnLineException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call CO_PAGOSONLINE_PG.CO_OBTIENE_PARAMETRO_PR(?,?,?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setString(1,inParam0.getCodModulo());
			logger.debug("codModulo[" + inParam0.getCodModulo() + "]");

			cstmt.setInt(2,inParam0.getCodProducto());
			logger.debug("codProducto[" + inParam0.getCodProducto() + "]");

			cstmt.setString(3,inParam0.getNomParametro());
			logger.debug("nomParametro[" + inParam0.getNomParametro() + "]");

			logger.info("declara parametros de salida...");
			com.tmmas.gte.pagoonlinecommon.dto.RespuestaDTO outParam1 = new com.tmmas.gte.pagoonlinecommon.dto.RespuestaDTO();

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7,java.sql.Types.NUMERIC);

			logger.info("execute():antes");
			cstmt.execute();
			logger.info("execute():despues");

			logger.info("setea respuesta de stored procedure...");
			outParam1.setCodigoError(cstmt.getInt(5));
			logger.debug("codigoError[" + outParam1.getCodigoError() + "]");

			outParam1.setMensajeError(cstmt.getString(6));
			logger.debug("mensajeError[" + outParam1.getMensajeError() + "]");

			outParam1.setNumeroEvento(cstmt.getString(7));
			logger.debug("numeroEvento[" + outParam1.getNumeroEvento() + "]");

			logger.info("verifica condicion de error del stored procedure...");
			if(outParam1.getCodigoError() != 0 ) {
				logger.info("Codigo de error != 0");
				outParam0.setRespuesta(outParam1);
				return outParam0;
			}
			logger.info("seteando clase de  repuesta a la clase padre...");
			outParam0.setRespuesta(outParam1);

			outParam0.setValParametro(cstmt.getString(4));
			logger.debug("valParametro[" + outParam0.getValParametro() + "]");

		}
		catch (java.sql.SQLException e) {
			logger.error("SQLException", e);
			throw new com.tmmas.gte.pagoonlinecommon.exception.PagoOnLineException("SQLException", e);
		}
		catch (java.lang.Exception e) {
			logger.error("Exception", e);
			throw new com.tmmas.gte.pagoonlinecommon.exception.PagoOnLineException("Exception", e);
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

		logger.info("obtenerParametro:end()");
		return outParam0;
	}

}