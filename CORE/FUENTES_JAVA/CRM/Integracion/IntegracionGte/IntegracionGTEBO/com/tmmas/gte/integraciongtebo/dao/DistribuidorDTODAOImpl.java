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

public class DistribuidorDTODAOImpl extends com.tmmas.cl.framework.base.ConnectionDAO implements DistribuidorDTODAO{
	private CompositeConfiguration config;
	private static Logger logger = Logger.getLogger(DistribuidorDTODAOImpl.class);
	private Global global = Global.getInstance();
	private ServiceLocator  serviceLocator = ServiceLocator.getInstance();

	public DistribuidorDTODAOImpl() {
		config = UtilProperty.getConfiguration("IntegracionGte.properties", "com/tmmas/gte/integraciongtebo/properties/IntegracionGTEBO.properties");
	}

	/**
	* Retorna los Datos del Distribuidor asociado al Código de Distribuidor ingresado
	*/
	public com.tmmas.gte.integraciongtecommon.dto.DistribuidorResponseDTO consDatosDistrib(com.tmmas.gte.integraciongtecommon.dto.DistribuidorDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("consDatosDistrib:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.DistribuidorResponseDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.DistribuidorResponseDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call GE_INT_ALEJANDRO_PG.ge_obtener_datos_distrib_pr(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setLong(1,inParam0.getCodDistribuidor());
			logger.debug("codDistribuidor[" + inParam0.getCodDistribuidor() + "]");

			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam1 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(2,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11,java.sql.Types.DATE);
			cstmt.registerOutParameter(12,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(13,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(14,java.sql.Types.NUMERIC);

			logger.info("execute():antes");
			cstmt.execute();
			logger.info("execute():despues");

			logger.info("setea respuesta de stored procedure...");
			outParam1.setCodigoError(cstmt.getInt(12));
			logger.debug("codigoError[" + outParam1.getCodigoError() + "]");

			outParam1.setMensajeError(cstmt.getString(13));
			logger.debug("mensajeError[" + outParam1.getMensajeError() + "]");

			outParam1.setNumeroEvento(cstmt.getLong(14));
			logger.debug("numeroEvento[" + outParam1.getNumeroEvento() + "]");

			logger.info("verifica condicion de error del stored procedure...");
			if(outParam1.getCodigoError() != 0 ) {
				logger.info("Codigo de error != 0");
				outParam0.setRespuesta(outParam1);
				return outParam0;
			}
			logger.info("seteando clase de  repuesta a la clase padre...");
			outParam0.setRespuesta(outParam1);

			outParam0.setNomVendedor(cstmt.getString(2));
			logger.debug("nomVendedor[" + outParam0.getNomVendedor() + "]");

			outParam0.setCodTipident(cstmt.getString(3));
			logger.debug("codTipident[" + outParam0.getCodTipident() + "]");

			outParam0.setDesTipident(cstmt.getString(4));
			logger.debug("desTipident[" + outParam0.getDesTipident() + "]");

			outParam0.setNumIdent(cstmt.getString(5));
			logger.debug("numIdent[" + outParam0.getNumIdent() + "]");

			outParam0.setCodCliente(cstmt.getString(6));
			logger.debug("codCliente[" + outParam0.getCodCliente() + "]");

			outParam0.setCodTipContrato(cstmt.getString(7));
			logger.debug("codTipContrato[" + outParam0.getCodTipContrato() + "]");

			outParam0.setDesTipContrato(cstmt.getString(8));
			logger.debug("desTipContrato[" + outParam0.getDesTipContrato() + "]");

			outParam0.setNumContrato(cstmt.getString(9));
			logger.debug("numContrato[" + outParam0.getNumContrato() + "]");

			outParam0.setNumAnexo(cstmt.getString(10));
			logger.debug("numAnexo[" + outParam0.getNumAnexo() + "]");

			outParam0.setFecContrato(new java.util.Date(cstmt.getDate(11).getTime()));
			logger.debug("fecContrato[" + outParam0.getFecContrato() + "]");

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

		logger.info("consDatosDistrib:end()");
		return outParam0;
	}

	/**
	* Retorna un listado de Bodegas asociadas al Código de Distribuidor ingresado
	*/
	public com.tmmas.gte.integraciongtecommon.dto.DistribBodegasResponseDTO consBodegasDistrib(com.tmmas.gte.integraciongtecommon.dto.DistribuidorDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("consBodegasDistrib:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.DistribBodegasResponseDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.DistribBodegasResponseDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call GE_INT_ALEJANDRO_PG.ge_obtener_bodegas_distrib_pr(?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setLong(1,inParam0.getCodDistribuidor());
			logger.debug("codDistribuidor[" + inParam0.getCodDistribuidor() + "]");

			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.DistribBodegasDTO outParam1 = new com.tmmas.gte.integraciongtecommon.dto.DistribBodegasDTO();
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam2 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(2,oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);

			logger.info("execute():antes");
			cstmt.execute();
			logger.info("execute():despues");

			logger.info("setea respuesta de stored procedure...");
			outParam2.setCodigoError(cstmt.getInt(3));
			logger.debug("codigoError[" + outParam2.getCodigoError() + "]");

			outParam2.setMensajeError(cstmt.getString(4));
			logger.debug("mensajeError[" + outParam2.getMensajeError() + "]");

			outParam2.setNumeroEvento(cstmt.getLong(5));
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
			java.sql.ResultSet rs = (java.sql.ResultSet) cstmt.getObject(2);
			java.util.List lista2 = new java.util.ArrayList();

			logger.info("Recuperando cursor2:antes");
			while (rs.next()) {
				com.tmmas.gte.integraciongtecommon.dto.DistribBodegasDTO dto2 = new com.tmmas.gte.integraciongtecommon.dto.DistribBodegasDTO();

				dto2.setCodBodega(rs.getLong("cod_bodega"));
				logger.debug("codBodega[" + dto2.getCodBodega() + "]");

				dto2.setDesBodega(rs.getString("des_bodega"));
				logger.debug("desBodega[" + dto2.getDesBodega() + "]");

				lista2.add(dto2);
			}
			logger.info("Recuperando cursor2:despues");
			rs.close();
			logger.info("Seteando respuesta de cursor2 en clase de salida....");
			outParam0.setListBodegas((com.tmmas.gte.integraciongtecommon.dto.DistribBodegasDTO[])
						com.tmmas.cl.framework.util.ArrayUtl.copiaArregloTipoEspecifico(lista2.toArray(),
												com.tmmas.gte.integraciongtecommon.dto.DistribBodegasDTO.class));

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

		logger.info("consBodegasDistrib:end()");
		return outParam0;
	}

	/**
	* Retorna los Datos del Pedido asociados al Código de Distribuidor y Código de Pedido ingresado
	*/
	public com.tmmas.gte.integraciongtecommon.dto.DistribuidorResponseDTO consPedidoDistrib(com.tmmas.gte.integraciongtecommon.dto.DistribuidorDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("consPedidoDistrib:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.DistribuidorResponseDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.DistribuidorResponseDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call GE_INT_ALEJANDRO_PG.ge_obtener_pedido_distrib_pr(?,?,?,?,?,?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setLong(1,inParam0.getCodClienteDistrib());
			logger.debug("codClienteDistrib[" + inParam0.getCodClienteDistrib() + "]");

			cstmt.setLong(2,inParam0.getCodPedido());
			logger.debug("codPedido[" + inParam0.getCodPedido() + "]");

			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.DistribPedidoDTO outParam1 = new com.tmmas.gte.integraciongtecommon.dto.DistribPedidoDTO();
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam2 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(9,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10,java.sql.Types.NUMERIC);

			logger.info("execute():antes");
			cstmt.execute();
			logger.info("execute():despues");

			logger.info("setea respuesta de stored procedure...");
			outParam2.setCodigoError(cstmt.getInt(8));
			logger.debug("codigoError[" + outParam2.getCodigoError() + "]");

			outParam2.setMensajeError(cstmt.getString(9));
			logger.debug("mensajeError[" + outParam2.getMensajeError() + "]");

			outParam2.setNumeroEvento(cstmt.getLong(10));
			logger.debug("numeroEvento[" + outParam2.getNumeroEvento() + "]");

			logger.info("verifica condicion de error del stored procedure...");
			if(outParam2.getCodigoError() != 0 ) {
				logger.info("Codigo de error != 0");
				outParam0.setRespuesta(outParam2);
				return outParam0;
			}
			logger.info("seteando clase de  repuesta a la clase padre...");
			outParam0.setRespuesta(outParam2);

			outParam1.setMtoNetoPedido(cstmt.getDouble(3));
			logger.debug("mtoNetoPedido[" + outParam1.getMtoNetoPedido() + "]");

			outParam1.setCantTotalPedido(cstmt.getLong(4));
			logger.debug("cantTotalPedido[" + outParam1.getCantTotalPedido() + "]");

			outParam1.setMtoTotalPedido(cstmt.getDouble(5));
			logger.debug("mtoTotalPedido[" + outParam1.getMtoTotalPedido() + "]");

			outParam1.setCodBodega(cstmt.getLong(6));
			logger.debug("codBodega[" + outParam1.getCodBodega() + "]");

			outParam1.setDesBodega(cstmt.getString(7));
			logger.debug("desBodega[" + outParam1.getDesBodega() + "]");

			logger.info("Seteando propiedades hijas a la clase padre...");
			outParam0.setDatosPedido(outParam1);

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

		logger.info("consPedidoDistrib:end()");
		return outParam0;
	}

	/**
	* ingresa el codigo del distribuidor para sacar el codigo del cliente
	*/
	public com.tmmas.gte.integraciongtecommon.dto.DistribuidorDTO consultarDistribuidor(com.tmmas.gte.integraciongtecommon.dto.DistribuidorDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("consultarDistribuidor:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.DistribuidorDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.DistribuidorDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call GE_INT_JUAN_PG.GE_CONS_DISTRIBUIDOR_PR(?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setLong(1,inParam0.getCodVendedor());
			logger.debug("codVendedor[" + inParam0.getCodVendedor() + "]");

			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam1 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(2,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);

			logger.info("execute():antes");
			cstmt.execute();
			logger.info("execute():despues");

			logger.info("setea respuesta de stored procedure...");
			outParam1.setCodigoError(cstmt.getInt(3));
			logger.debug("codigoError[" + outParam1.getCodigoError() + "]");

			outParam1.setMensajeError(cstmt.getString(4));
			logger.debug("mensajeError[" + outParam1.getMensajeError() + "]");

			outParam1.setNumeroEvento(cstmt.getLong(5));
			logger.debug("numeroEvento[" + outParam1.getNumeroEvento() + "]");

			logger.info("verifica condicion de error del stored procedure...");
			if(outParam1.getCodigoError() != 0 ) {
				logger.info("Codigo de error != 0");
				outParam0.setRespuesta(outParam1);
				return outParam0;
			}
			logger.info("seteando clase de  repuesta a la clase padre...");
			outParam0.setRespuesta(outParam1);

			outParam0.setCodCliente(cstmt.getLong(2));
			logger.debug("codCliente[" + outParam0.getCodCliente() + "]");

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

		logger.info("consultarDistribuidor:end()");
		return outParam0;
	}	
	
}

 