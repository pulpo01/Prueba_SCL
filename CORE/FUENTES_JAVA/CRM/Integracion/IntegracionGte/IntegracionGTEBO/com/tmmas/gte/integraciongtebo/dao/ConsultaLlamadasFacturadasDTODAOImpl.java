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

public class ConsultaLlamadasFacturadasDTODAOImpl extends com.tmmas.cl.framework.base.ConnectionDAO implements ConsultaLlamadasFacturadasDTODAO{
	private CompositeConfiguration config;
	private static Logger logger = Logger.getLogger(ConsultaLlamadasFacturadasDTODAOImpl.class);
	private Global global = Global.getInstance();
	private ServiceLocator  serviceLocator = ServiceLocator.getInstance();

	public ConsultaLlamadasFacturadasDTODAOImpl() {
		config = UtilProperty.getConfiguration("IntegracionGte.properties", "com/tmmas/gte/integraciongtebo/properties/IntegracionGTEBO.properties");
	}

	/**
	* Servicio que entrega un listado de las llamadas facturadas para un número de teléfono y una factura específica
	*/
	public com.tmmas.gte.integraciongtecommon.dto.ConsultaLlamadasFacturadasResponseDTO consultarLlamadasFacturadas(com.tmmas.gte.integraciongtecommon.dto.ConsultaLlamadasFacturadasInDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("consultarLlamadasFacturadas:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.ConsultaLlamadasFacturadasResponseDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.ConsultaLlamadasFacturadasResponseDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call PV_CONSLLAMADA_PG.PV_DETALLE_FACTURADO_PR(?,?,?,?,?,?,?,?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setLong(1,inParam0.getNumTelefono());
			logger.debug("numTelefono[" + inParam0.getNumTelefono() + "]");

			cstmt.setString(2,inParam0.getCodCicloFact());
			logger.debug("codCicloFact[" + inParam0.getCodCicloFact() + "]");

			cstmt.setLong(3,inParam0.getNumFolio());
			logger.debug("numFolio[" + inParam0.getNumFolio() + "]");

			cstmt.setString(4,inParam0.getFecIni());
			logger.debug("fecIni[" + inParam0.getFecIni() + "]");

			cstmt.setString(5,inParam0.getFecTerm());
			logger.debug("fecTerm[" + inParam0.getFecTerm() + "]");

			cstmt.setString(6,inParam0.getUsuario());
			logger.debug("usuario[" + inParam0.getUsuario() + "]");

			cstmt.setString(7,inParam0.getCampoOrden());
			logger.debug("campoOrden[" + inParam0.getCampoOrden() + "]");

			cstmt.setString(8,inParam0.getTipoOrden());
			logger.debug("tipoOrden[" + inParam0.getTipoOrden() + "]");

			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.ConsultaLlamadasFacturadasDTO outParam1 = new com.tmmas.gte.integraciongtecommon.dto.ConsultaLlamadasFacturadasDTO();
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam2 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(9,oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(10,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(11,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(12,java.sql.Types.NUMERIC);

			logger.info("execute():antes");
			cstmt.execute();
			logger.info("execute():despues");

			logger.info("setea respuesta de stored procedure...");
			outParam2.setCodigoError(cstmt.getInt(10));
			logger.debug("codigoError[" + outParam2.getCodigoError() + "]");

			outParam2.setMensajeError(cstmt.getString(11));
			logger.debug("mensajeError[" + outParam2.getMensajeError() + "]");

			outParam2.setNumeroEvento(cstmt.getLong(12));
			logger.debug("numeroEvento[" + outParam2.getNumeroEvento() + "]");

			logger.info("verifica condicion de error del stored procedure...");
			if(outParam2.getCodigoError() != 0 ) {
				logger.info("Codigo de error != 0");
				outParam0.setRespuesta(outParam2);
				return outParam0;
			}
			logger.info("seteando clase de  repuesta a la clase padre...");
			outParam0.setRespuesta(outParam2);

			logger.info("Recuperando cursor..");
			java.sql.ResultSet rs = (java.sql.ResultSet) cstmt.getObject(9);
			java.util.List lista9 = new java.util.ArrayList();

			logger.info("Recuperando cursor9:antes");
			while (rs.next()) {
				com.tmmas.gte.integraciongtecommon.dto.ConsultaLlamadasFacturadasDTO dto9 = new com.tmmas.gte.integraciongtecommon.dto.ConsultaLlamadasFacturadasDTO();

				dto9.setNumFolio(rs.getLong("num_Folio"));
				logger.debug("numFolio[" + dto9.getNumFolio() + "]");

				dto9.setFecLlamada(new java.util.Date(rs.getDate("fec_Llamada").getTime()));
				logger.debug("fecLlamada[" + dto9.getFecLlamada() + "]");

				dto9.setHoraLlamada(rs.getString("hora_Llamada"));
				logger.debug("horaLlamada[" + dto9.getHoraLlamada() + "]");

				dto9.setNumDestino(rs.getLong("num_Destino"));
				logger.debug("numDestino[" + dto9.getNumDestino() + "]");

				dto9.setMtoLlamSinImp(rs.getLong("mto_Llam_Sin_Imp"));
				logger.debug("mtoLlamSinImp[" + dto9.getMtoLlamSinImp() + "]");

				dto9.setMtoLlamConImp(rs.getLong("mto_Llam_Con_Imp"));
				logger.debug("mtoLlamConImp[" + dto9.getMtoLlamConImp() + "]");

				dto9.setDesLlamada(rs.getString("des_Llamada"));
				logger.debug("desLlamada[" + dto9.getDesLlamada() + "]");

				lista9.add(dto9);
			}
			logger.info("Recuperando cursor9:despues");
			rs.close();
			logger.info("Seteando respuesta de cursor9 en clase de salida....");
			outParam0.setLstLlamadasFact((com.tmmas.gte.integraciongtecommon.dto.ConsultaLlamadasFacturadasDTO[])
						com.tmmas.cl.framework.util.ArrayUtl.copiaArregloTipoEspecifico(lista9.toArray(),
												com.tmmas.gte.integraciongtecommon.dto.ConsultaLlamadasFacturadasDTO.class));

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

		logger.info("consultarLlamadasFacturadas:end()");
		return outParam0;
	}

}