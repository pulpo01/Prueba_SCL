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

public class AvisoSiniestroDTODAOImpl extends com.tmmas.cl.framework.base.ConnectionDAO implements AvisoSiniestroDTODAO{
	private CompositeConfiguration config;
	private static Logger logger = Logger.getLogger(AvisoSiniestroDTODAOImpl.class);
	private Global global = Global.getInstance();
	private ServiceLocator  serviceLocator = ServiceLocator.getInstance();

	public AvisoSiniestroDTODAOImpl() {
		config = UtilProperty.getConfiguration("IntegracionGte.properties", "com/tmmas/gte/integraciongtebo/properties/IntegracionGTEBO.properties");
	}
 
	/**
	* Entrega Datos del Aviso Siniestro
	*/
	public com.tmmas.gte.integraciongtecommon.dto.ConsAvisoSiniestroResponseDTO consultarAvisoSiniestro(com.tmmas.gte.integraciongtecommon.dto.ConsAvisoSiniestroInDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("consultarAvisoSiniestro:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.ConsAvisoSiniestroResponseDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.ConsAvisoSiniestroResponseDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call GE_INTEGRACION_PG.GE_AVISOSIN_PR(?,?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setLong(1,inParam0.getNumeroTelefono());
			logger.debug("numeroTelefono[" + inParam0.getNumeroTelefono() + "]");

			cstmt.setString(2,inParam0.getCodSiniestro());
			logger.debug("codSiniestro[" + inParam0.getCodSiniestro() + "]");

			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.AvisoSiniestroDTO outParam1 = new com.tmmas.gte.integraciongtecommon.dto.AvisoSiniestroDTO();
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam2 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(3,oracle.jdbc.driver.OracleTypes.CURSOR);
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

			logger.info("Recuperando cursor..");
			java.sql.ResultSet rs = (java.sql.ResultSet) cstmt.getObject(3);
			java.util.List lista3 = new java.util.ArrayList();

			logger.info("Recuperando cursor3:antes");
			while (rs.next()) {
				com.tmmas.gte.integraciongtecommon.dto.AvisoSiniestroDTO dto3 = new com.tmmas.gte.integraciongtecommon.dto.AvisoSiniestroDTO();

				dto3.setNumSiniestro(rs.getLong("num_siniestro"));
				logger.debug("numSiniestro[" + dto3.getNumSiniestro() + "]");

				dto3.setNumAbonado(rs.getLong("num_abonado"));
				logger.debug("numAbonado[" + dto3.getNumAbonado() + "]");

				dto3.setCodProducto(rs.getLong("cod_producto"));
				logger.debug("codProducto[" + dto3.getCodProducto() + "]");

				dto3.setCodCausa(rs.getString("cod_causa"));
				logger.debug("codCausa[" + dto3.getCodCausa() + "]");

				dto3.setDesCausa(rs.getString("des_causa"));
				logger.debug("desCausa[" + dto3.getDesCausa() + "]");

				dto3.setCodEstado(rs.getString("cod_estado"));
				logger.debug("codEstado[" + dto3.getCodEstado() + "]");

				dto3.setNumSerie(rs.getString("num_serie"));
				logger.debug("numSerie[" + dto3.getNumSerie() + "]");

				dto3.setFecSiniestro(new java.util.Date(rs.getDate("fec_siniestro").getTime()));
				logger.debug("fecSiniestro[" + dto3.getFecSiniestro() + "]");

				dto3.setCodServicio(rs.getString("cod_servicio"));
				logger.debug("codServicio[" + dto3.getCodServicio() + "]");

				dto3.setIndSusp(rs.getLong("ind_susp"));
				logger.debug("indSusp[" + dto3.getIndSusp() + "]");

				dto3.setTipTerminal(rs.getString("tip_terminal"));
				logger.debug("tipTerminal[" + dto3.getTipTerminal() + "]");

				dto3.setDesTerminal(rs.getString("des_terminal"));
				logger.debug("desTerminal[" + dto3.getDesTerminal() + "]");

				lista3.add(dto3);
			}
			logger.info("Recuperando cursor3:despues");
			rs.close();
			logger.info("Seteando respuesta de cursor3 en clase de salida....");
			outParam0.setListadoSiniestros((com.tmmas.gte.integraciongtecommon.dto.AvisoSiniestroDTO[])
						com.tmmas.cl.framework.util.ArrayUtl.copiaArregloTipoEspecifico(lista3.toArray(),
												com.tmmas.gte.integraciongtecommon.dto.AvisoSiniestroDTO.class));

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

		logger.info("consultarAvisoSiniestro:end()");
		return outParam0;
	}


	
}