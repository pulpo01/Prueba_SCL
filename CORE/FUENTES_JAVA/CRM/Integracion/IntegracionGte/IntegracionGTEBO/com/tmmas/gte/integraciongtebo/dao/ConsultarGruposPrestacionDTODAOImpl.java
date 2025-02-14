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

public class ConsultarGruposPrestacionDTODAOImpl extends com.tmmas.cl.framework.base.ConnectionDAO implements ConsultarGruposPrestacionDTODAO{
	private CompositeConfiguration config;
	private static Logger logger = Logger.getLogger(ConsultarGruposPrestacionDTODAOImpl.class);
	private Global global = Global.getInstance();
	private ServiceLocator  serviceLocator = ServiceLocator.getInstance();

	public ConsultarGruposPrestacionDTODAOImpl() {
		config = UtilProperty.getConfiguration("IntegracionGte.properties", "com/tmmas/gte/integraciongtebo/properties/IntegracionGTEBO.properties");
	}

	/**
	* Entrega datos de los grupos de prestación existentes
	*/
	public com.tmmas.gte.integraciongtecommon.dto.ConsultarGruposPrestacionResponseDTO consultarGruposPrestacion()
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("consultarGruposPrestacion:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.ConsultarGruposPrestacionResponseDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.ConsultarGruposPrestacionResponseDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call VE_PARAMETROS_COMERCIALES_PG.VE_OBTIENE_GRUPOSPREST_PR(?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.ConsultarGruposPrestacionDTO outParam1 = new com.tmmas.gte.integraciongtecommon.dto.ConsultarGruposPrestacionDTO();
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam2 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(1,oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(2,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);

			logger.info("execute():antes");
			cstmt.execute();
			logger.info("execute():despues");

			logger.info("setea respuesta de stored procedure...");
			outParam2.setCodigoError(cstmt.getInt(2));
			logger.debug("codigoError[" + outParam2.getCodigoError() + "]");

			outParam2.setMensajeError(cstmt.getString(3));
			logger.debug("mensajeError[" + outParam2.getMensajeError() + "]");

			outParam2.setNumeroEvento(cstmt.getLong(4));
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
			java.sql.ResultSet rs = (java.sql.ResultSet) cstmt.getObject(1);
			java.util.List lista1 = new java.util.ArrayList();

			logger.info("Recuperando cursor1:antes");
			while (rs.next()) {
				com.tmmas.gte.integraciongtecommon.dto.ConsultarGruposPrestacionDTO dto1 = new com.tmmas.gte.integraciongtecommon.dto.ConsultarGruposPrestacionDTO();

				dto1.setCodValor(rs.getString("cod_valor"));
				logger.debug("codValor[" + dto1.getCodValor() + "]");

				dto1.setDesValor(rs.getString("des_valor"));
				logger.debug("desValor[" + dto1.getDesValor() + "]");

				lista1.add(dto1);
			}
			logger.info("Recuperando cursor1:despues");
			rs.close();
			logger.info("Seteando respuesta de cursor1 en clase de salida....");
			outParam0.setListadoPrestaciones((com.tmmas.gte.integraciongtecommon.dto.ConsultarGruposPrestacionDTO[])
						com.tmmas.cl.framework.util.ArrayUtl.copiaArregloTipoEspecifico(lista1.toArray(),
												com.tmmas.gte.integraciongtecommon.dto.ConsultarGruposPrestacionDTO.class));

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

		logger.info("consultarGruposPrestacion:end()");
		return outParam0;
	}

}