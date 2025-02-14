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

public class InterfazPagoDTODAOImpl extends com.tmmas.cl.framework.base.ConnectionDAO implements InterfazPagoDTODAO{
	private CompositeConfiguration config;
	private static Logger logger = Logger.getLogger(InterfazPagoDTODAOImpl.class);
	private Global global = Global.getInstance();
	private ServiceLocator  serviceLocator = ServiceLocator.getInstance();

	public InterfazPagoDTODAOImpl() {
		config = UtilProperty.getConfiguration("PagoOnLine.properties", "com/tmmas/gte/pagoonlinebo/properties/PagoOnLineBO.properties");
	}

	/**
	* Ingresa registro de Pago en la interfaz de Pagos (CO_INTERFAZ_PAGOS)
	*/
	public com.tmmas.gte.pagoonlinecommon.dto.RespuestaDTO ingresaPagoInterfaz(com.tmmas.gte.pagoonlinecommon.dto.InterfazPagoDTO inParam0)
			 throws com.tmmas.gte.pagoonlinecommon.exception.PagoOnLineException{
		logger.info("ingresaPagoInterfaz:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.pagoonlinecommon.dto.RespuestaDTO outParam0 = new com.tmmas.gte.pagoonlinecommon.dto.RespuestaDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.pagoonlinecommon.exception.PagoOnLineException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call CO_PAGOSONLINE_PG.CE_APLICA_PAGO_PR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setString(1,inParam0.getCodBanco());
			logger.debug("codBanco[" + inParam0.getCodBanco() + "]");

			cstmt.setInt(2,inParam0.getCodCaja());
			logger.debug("codCaja[" + inParam0.getCodCaja() + "]");

			cstmt.setString(3,inParam0.getServicioSolicitado());
			logger.debug("servicioSolicitado[" + inParam0.getServicioSolicitado() + "]");

			cstmt.setString(4,inParam0.getFecEfectividad());
			logger.debug("fecEfectividad[" + inParam0.getFecEfectividad() + "]");

			cstmt.setInt(5,inParam0.getNumTransaccion());
			logger.debug("numTransaccion[" + inParam0.getNumTransaccion() + "]");

			cstmt.setString(6,inParam0.getOperador());
			logger.debug("operador[" + inParam0.getOperador() + "]");

			cstmt.setString(7,inParam0.getTipTransaccion());
			logger.debug("tipTransaccion[" + inParam0.getTipTransaccion() + "]");

			cstmt.setString(8,inParam0.getSubTipo());
			logger.debug("subTipo[" + inParam0.getSubTipo() + "]");

			cstmt.setInt(9,inParam0.getCodServicio());
			logger.debug("codServicio[" + inParam0.getCodServicio() + "]");

			cstmt.setString(10,inParam0.getNumEjercicio());
			logger.debug("numEjercicio[" + inParam0.getNumEjercicio() + "]");

			cstmt.setLong(11,inParam0.getCodCliente());
			logger.debug("codCliente[" + inParam0.getCodCliente() + "]");

			cstmt.setLong(12,inParam0.getNumCelular());
			logger.debug("numCelular[" + inParam0.getNumCelular() + "]");

			cstmt.setDouble(13,inParam0.getMtoPago());
			logger.debug("mtoPago[" + inParam0.getMtoPago() + "]");

			cstmt.setString(14,inParam0.getNumFolioCTC());
			logger.debug("numFolioCTC[" + inParam0.getNumFolioCTC() + "]");

			cstmt.setInt(15,inParam0.getTipValor());
			logger.debug("tipValor[" + inParam0.getTipValor() + "]");

			cstmt.setInt(16,inParam0.getNumCheque());
			logger.debug("numCheque[" + inParam0.getNumCheque() + "]");

			cstmt.setString(17,inParam0.getBancoCheque());
			logger.debug("bancoCheque[" + inParam0.getBancoCheque() + "]");

			cstmt.setString(18,inParam0.getCtaCte());
			logger.debug("ctaCte[" + inParam0.getCtaCte() + "]");

			cstmt.setString(19,inParam0.getNumAutorizacion());
			logger.debug("numAutorizacion[" + inParam0.getNumAutorizacion() + "]");

			cstmt.setString(20,inParam0.getNumTarjeta());
			logger.debug("numTarjeta[" + inParam0.getNumTarjeta() + "]");

			cstmt.setString(21,inParam0.getAgencia());
			logger.debug("agencia[" + inParam0.getAgencia() + "]");

			cstmt.setInt(22,inParam0.getCodOperacion());
			logger.debug("codOperacion[" + inParam0.getCodOperacion() + "]");

			cstmt.setInt(23,inParam0.getNumTransaccionEmp());
			logger.debug("numTransaccionEmp[" + inParam0.getNumTransaccionEmp() + "]");

			cstmt.setString(24,inParam0.getTipTarjeta());
			logger.debug("tipTarjeta[" + inParam0.getTipTarjeta() + "]");
			
			logger.info("declara parametros de salida...");

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(25,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(26,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(27,java.sql.Types.NUMERIC);

			logger.info("execute():antes");
			cstmt.execute();
			logger.info("execute():despues");

			logger.info("setea respuesta de stored procedure...");
			outParam0.setCodigoError(cstmt.getInt(25));
			logger.debug("codigoError[" + outParam0.getCodigoError() + "]");

			outParam0.setMensajeError(cstmt.getString(26));
			logger.debug("mensajeError[" + outParam0.getMensajeError() + "]");

			outParam0.setNumeroEvento(cstmt.getString(27));
			logger.debug("numeroEvento[" + outParam0.getNumeroEvento() + "]");

			logger.info("verifica condicion de error del stored procedure...");
			if(outParam0.getCodigoError() != 0 ) {
				logger.info("Codigo de error != 0");
				return outParam0;
			}

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

		logger.info("ingresaPagoInterfaz:end()");
		return outParam0;
	}

}