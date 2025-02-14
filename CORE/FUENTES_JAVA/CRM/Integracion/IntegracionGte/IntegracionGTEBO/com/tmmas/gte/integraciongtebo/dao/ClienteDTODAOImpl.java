/**
* Generated file - You can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/

package com.tmmas.gte.integraciongtebo.dao;
import java.util.Date;
import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.gte.integraciongtebo.helper.Global;
import com.tmmas.cl.framework20.util.ServiceLocator;

public class ClienteDTODAOImpl extends com.tmmas.cl.framework.base.ConnectionDAO implements ClienteDTODAO{
	private CompositeConfiguration config;
	private static Logger logger = Logger.getLogger(ClienteDTODAOImpl.class);
	private Global global = Global.getInstance();
	private ServiceLocator  serviceLocator = ServiceLocator.getInstance();

	public ClienteDTODAOImpl() {
		config = UtilProperty.getConfiguration("IntegracionGte.properties", "com/tmmas/gte/integraciongtebo/properties/IntegracionGTEBO.properties");
	}

	/**
	* Entrega Listado de Clientes por número de identificación del cliente (NIT) y el código de tipo de identificación
	*/
	public com.tmmas.gte.integraciongtecommon.dto.LstCliResponseDTO listarClientes(com.tmmas.gte.integraciongtecommon.dto.DatosLstCliNitDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("listadoClientesNit:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.LstCliResponseDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.LstCliResponseDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call GE_INTEGRACION_PG.ge_listar_cli_nit_pr(?,?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setString(1,inParam0.getNumIdem());
			logger.debug("numIdem[" + inParam0.getNumIdem() + "]");

			cstmt.setString(2,inParam0.getCodTipIdent());
			logger.debug("codTipIdent[" + inParam0.getCodTipIdent() + "]");

			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.ClienteAuxDTO outParam1 = new com.tmmas.gte.integraciongtecommon.dto.ClienteAuxDTO();
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
				com.tmmas.gte.integraciongtecommon.dto.ClienteAuxDTO dto3 = new com.tmmas.gte.integraciongtecommon.dto.ClienteAuxDTO();

				dto3.setCodCuenta(rs.getLong("cod_cuenta"));
				logger.debug("codCuenta[" + dto3.getCodCuenta() + "]");
				
				dto3.setDesCuenta(rs.getString("des_cuenta"));
				logger.debug("deCuenta[" + dto3.getDesCuenta() + "]");

				dto3.setCodCliente(rs.getLong("cod_cliente"));
				logger.debug("codCliente[" + dto3.getCodCliente() + "]");

				dto3.setNomCliente(rs.getString("nom_cliente"));
				logger.debug("nomCliente[" + dto3.getNomCliente() + "]");

				dto3.setNomApeClien1(rs.getString("nom_apeclien1"));
				logger.debug("nomApeClien1[" + dto3.getNomApeClien1() + "]");

				dto3.setNomApeClien2(rs.getString("nom_apeclien2"));
				logger.debug("nomApeClien2[" + dto3.getNomApeClien2() + "]");

				dto3.setCodTipo(rs.getString("cod_tipo"));
				logger.debug("CodTipo[" + dto3.getCodTipo() + "]");

				dto3.setDesValor(rs.getString("des_valor"));
				logger.debug("DesValor[" + dto3.getDesValor() + "]");

				lista3.add(dto3);
			}
			logger.info("Recuperando cursor3:despues");
			rs.close();
			logger.info("Seteando respuesta de cursor3 en clase de salida....");
			outParam0.setListadoClientes((com.tmmas.gte.integraciongtecommon.dto.ClienteAuxDTO[])
						com.tmmas.cl.framework.util.ArrayUtl.copiaArregloTipoEspecifico(lista3.toArray(),
												com.tmmas.gte.integraciongtecommon.dto.ClienteAuxDTO.class));

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

		logger.info("listadoClientesNit:end()");
		return outParam0;
	}

	/**
	* Entrega Listado de Clientes por código de Cuenta
	*/
	public com.tmmas.gte.integraciongtecommon.dto.LstCliResponseDTO listarClientes(com.tmmas.gte.integraciongtecommon.dto.DatosLstCliCueDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("listadoClienteCodCuenta:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.LstCliResponseDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.LstCliResponseDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call GE_INTEGRACION_PG.ge_listar_cli_cuenta_pr(?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setLong(1,inParam0.getCodCuenta());
			logger.debug("codCuenta[" + inParam0.getCodCuenta() + "]");

			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.ClienteAuxDTO outParam1 = new com.tmmas.gte.integraciongtecommon.dto.ClienteAuxDTO();
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
				com.tmmas.gte.integraciongtecommon.dto.ClienteAuxDTO dto2 = new com.tmmas.gte.integraciongtecommon.dto.ClienteAuxDTO();

				dto2.setCodCuenta(rs.getLong("cod_cuenta"));
				logger.debug("codCuenta[" + dto2.getCodCuenta() + "]");
				
				dto2.setDesCuenta(rs.getString("des_cuenta"));
				logger.debug("deCuenta[" + dto2.getDesCuenta() + "]");

				dto2.setCodCliente(rs.getLong("cod_cliente"));
				logger.debug("codCliente[" + dto2.getCodCliente() + "]");

				dto2.setNomCliente(rs.getString("nom_cliente"));
				logger.debug("nomCliente[" + dto2.getNomCliente() + "]");

				dto2.setNomApeClien1(rs.getString("nom_apeclien1"));
				logger.debug("nomApeClien1[" + dto2.getNomApeClien1() + "]");

				dto2.setNomApeClien2(rs.getString("nom_apeclien2"));
				logger.debug("nomApeClien2[" + dto2.getNomApeClien2() + "]");

				dto2.setCodTipo(rs.getString("cod_tipo"));
				logger.debug("CodTipo[" + dto2.getCodTipo() + "]");

				dto2.setDesValor(rs.getString("des_valor"));
				logger.debug("DesValor[" + dto2.getDesValor() + "]");

				lista2.add(dto2);
			}
			logger.info("Recuperando cursor2:despues");
			rs.close();
			logger.info("Seteando respuesta de cursor2 en clase de salida....");
			outParam0.setListadoClientes((com.tmmas.gte.integraciongtecommon.dto.ClienteAuxDTO[])
						com.tmmas.cl.framework.util.ArrayUtl.copiaArregloTipoEspecifico(lista2.toArray(),
												com.tmmas.gte.integraciongtecommon.dto.ClienteAuxDTO.class));

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

		logger.info("listadoClienteCodCuenta:end()");
		return outParam0;
	}

	/**
	* Entrega número de identificación del cliente (NIT) y el código de tipo de identificación
	*/
	public com.tmmas.gte.integraciongtecommon.dto.LstDatosCliNitDTO consultarDatosCliente(com.tmmas.gte.integraciongtecommon.dto.DatosLstCliCliDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("consultarDatosCliente:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.LstDatosCliNitDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.LstDatosCliNitDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call GE_INTEGRACION_PG.ge_cons_datos_cli_cod_pr(?,?,?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setLong(1,inParam0.getCodCliente());
			logger.debug("codCliente[" + inParam0.getCodCliente() + "]");

			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.DatosCliNitDTO outParam1 = new com.tmmas.gte.integraciongtecommon.dto.DatosCliNitDTO();
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam2 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(2,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7,java.sql.Types.NUMERIC);

			logger.info("execute():antes");
			cstmt.execute();
			logger.info("execute():despues");

			logger.info("setea respuesta de stored procedure...");
			outParam2.setCodigoError(cstmt.getInt(5));
			logger.debug("codigoError[" + outParam2.getCodigoError() + "]");

			outParam2.setMensajeError(cstmt.getString(6));
			logger.debug("mensajeError[" + outParam2.getMensajeError() + "]");

			outParam2.setNumeroEvento(cstmt.getLong(7));
			logger.debug("numeroEvento[" + outParam2.getNumeroEvento() + "]");

			logger.info("verifica condicion de error del stored procedure...");
			if(outParam2.getCodigoError() != 0 ) {
				logger.info("Codigo de error != 0");
				outParam0.setRespuesta(outParam2);
				return outParam0;
			}
			logger.info("seteando clase de  repuesta a la clase padre...");
			outParam0.setRespuesta(outParam2);

			outParam1.setNumIdem(cstmt.getString(2));
			logger.debug("numIdem[" + outParam1.getNumIdem() + "]");

			outParam1.setCodTipIdent(cstmt.getString(3));
			logger.debug("codTipIdent[" + outParam1.getCodTipIdent() + "]");

			outParam1.setCodCiclo(cstmt.getLong(4));
			logger.debug("codCiclo[" + outParam1.getCodCiclo() + "]");

			logger.info("Seteando propiedades hijas a la clase padre...");
			java.util.List listaNueva = new java.util.ArrayList();
			listaNueva.add(outParam1);
		
			outParam0.setListadoClientes((com.tmmas.gte.integraciongtecommon.dto.DatosCliNitDTO[])
					com.tmmas.cl.framework.util.ArrayUtl.copiaArregloTipoEspecifico(listaNueva.toArray(),
											com.tmmas.gte.integraciongtecommon.dto.DatosCliNitDTO.class));

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

		logger.info("consultarDatosCliente:end()");
		return outParam0;
	}

	/**
	* Entrega listado de cliente Pospago por número de teléfono
	*/
	public com.tmmas.gte.integraciongtecommon.dto.DatosClienteResponseDTO consultarClientePospago(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("consultarClientePospago:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.DatosClienteResponseDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.DatosClienteResponseDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call GE_INTEGRACION_PG.GE_CONS_CLIE_POS_PR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setLong(1,inParam0.getNumeroTelefono());
			logger.debug("numeroTelefono[" + inParam0.getNumeroTelefono() + "]");

			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.ClienteDTO outParam1 = new com.tmmas.gte.integraciongtecommon.dto.ClienteDTO();
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam2 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(2,java.sql.Types.DATE);
			cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5,java.sql.Types.DATE);
			cstmt.registerOutParameter(6,java.sql.Types.DATE);
			cstmt.registerOutParameter(7,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(12,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(13,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(14,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(15,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(16,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(17,java.sql.Types.DATE);
			cstmt.registerOutParameter(18,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(19,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(20,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(21,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(22,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(23,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(24,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(25,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(26,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(27,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(28,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(29,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(30,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(31,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(32,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(33,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(34,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(35,java.sql.Types.NUMERIC);

			logger.info("execute():antes");
			cstmt.execute();
			logger.info("execute():despues");

			logger.info("setea respuesta de stored procedure...");
			outParam2.setCodigoError(cstmt.getInt(33));
			logger.debug("codigoError[" + outParam2.getCodigoError() + "]");

			outParam2.setMensajeError(cstmt.getString(34));
			logger.debug("mensajeError[" + outParam2.getMensajeError() + "]");

			outParam2.setNumeroEvento(cstmt.getLong(35));
			logger.debug("numeroEvento[" + outParam2.getNumeroEvento() + "]");

			logger.info("verifica condicion de error del stored procedure...");
			if(outParam2.getCodigoError() != 0 ) {
				logger.info("Codigo de error != 0");
				outParam0.setRespuesta(outParam2);
				return outParam0;
			}
			logger.info("seteando clase de  repuesta a la clase padre...");
			outParam0.setRespuesta(outParam2);

			outParam1.setSysDate(new java.util.Date(cstmt.getDate(2).getTime()));
			logger.debug("sysDate[" + outParam1.getSysDate() + "]");

			outParam1.setNumCelular(cstmt.getLong(3));
			logger.debug("numCelular[" + outParam1.getNumCelular() + "]");

			outParam1.setCodCliente(cstmt.getLong(4));
			logger.debug("codCliente[" + outParam1.getCodCliente() + "]");

			outParam1.setFecAlta(new java.util.Date(cstmt.getDate(5).getTime()));
			logger.debug("fecAlta[" + outParam1.getFecAlta() + "]");

			outParam1.setFecFincontra(new java.util.Date(cstmt.getDate(6).getTime()));
			logger.debug("fecFincontra[" + outParam1.getFecFincontra() + "]");

			outParam1.setNomCliente(cstmt.getString(7));
			logger.debug("nomCliente[" + outParam1.getNomCliente() + "]");

			outParam1.setNomApeclien1(cstmt.getString(8));
			logger.debug("nomApeclien1[" + outParam1.getNomApeclien1() + "]");

			outParam1.setNomApeclien2(cstmt.getString(9));
			logger.debug("nomApeclien2[" + outParam1.getNomApeclien2() + "]");
			
			outParam1.setNumIdent(cstmt.getString(10));
			logger.debug("numIdent[" + outParam1.getNumIdent() + "]");

			outParam1.setCodTipident(cstmt.getString(11));
			logger.debug("codTipident[" + outParam1.getCodTipident() + "]");

			outParam1.setDesNit(cstmt.getString(12));
			logger.debug("desNit[" + outParam1.getDesNit() + "]");
			
			outParam1.setNumIdent2(cstmt.getString(13));
			logger.debug("numIdent2[" + outParam1.getNumIdent2() + "]");

			outParam1.setCodTipident2(cstmt.getString(14));
			logger.debug("codTipident2[" + outParam1.getCodTipident2() + "]");

			outParam1.setNumIdentapor(cstmt.getString(15));
			logger.debug("numIdentapor[" + outParam1.getNumIdentapor() + "]");

			outParam1.setCodTipidentapor(cstmt.getString(16));
			logger.debug("codTipidentapor[" + outParam1.getCodTipidentapor() + "]");
			
			Date fechaNac = cstmt.getDate(17);
			if(fechaNac != null){
				outParam1.setFecNacimien(new java.util.Date(cstmt.getDate(17).getTime()));
			}else{
				outParam1.setFecNacimien(fechaNac);
			}
			logger.debug("fecNacimien[" + outParam1.getFecNacimien() + "]");

			long actividad = cstmt.getLong(18); 
			
			if (actividad > 0){
				outParam1.setCodProfesion(cstmt.getLong(18));
			}else{
				outParam1.setCodProfesion(13);
			}
				
			logger.debug("codProfesion[" + outParam1.getCodProfesion() + "]");

			outParam1.setCodOcupacion(cstmt.getString(19));
			logger.debug("codOcupacion[" + outParam1.getCodOcupacion() + "]");
			
			outParam1.setNomApoderado(cstmt.getString(20));
			logger.debug("nomApoderado[" + outParam1.getNomApoderado() + "]");

			outParam1.setIndEstcivil(cstmt.getString(21));
			logger.debug("indEstcivil[" + outParam1.getIndEstcivil() + "]");

			outParam1.setEstadoCivil(cstmt.getString(22));
			logger.debug("estadoCivil[" + outParam1.getEstadoCivil() + "]");

			outParam1.setCodPais(cstmt.getString(23));
			logger.debug("codPais[" + outParam1.getCodPais() + "]");

			outParam1.setDesPais(cstmt.getString(24));
			logger.debug("desPais[" + outParam1.getDesPais() + "]");

			outParam1.setCodTecnologia(cstmt.getString(25));
			logger.debug("codTecnologia[" + outParam1.getCodTecnologia() + "]");

			outParam1.setNumSerie(cstmt.getString(26));
			logger.debug("numSerie[" + outParam1.getNumSerie() + "]");

			outParam1.setNumImei(cstmt.getString(27));
			logger.debug("numImei[" + outParam1.getNumImei() + "]");

			outParam1.setCodPlantarif(cstmt.getString(28));
			logger.debug("codPlantarif[" + outParam1.getCodPlantarif() + "]");

			outParam1.setDesPlantarif(cstmt.getString(29));
			logger.debug("desPlantarif[" + outParam1.getDesPlantarif() + "]");

			outParam1.setCodTipo(cstmt.getString(30));
			logger.debug("codTipo[" + outParam1.getCodTipo() + "]");

			outParam1.setTipCliente(cstmt.getString(31));
			logger.debug("tipCliente[" + outParam1.getTipCliente() + "]");

			outParam1.setTefCliente1(cstmt.getString(32));
			logger.debug("tefCliente1[" + outParam1.getTefCliente1() + "]");

			logger.info("Seteando propiedades hijas a la clase padre...");
			outParam0.setDatosCliente(outParam1);

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

		logger.info("consultarClientePospago:end()");
		return outParam0;
	}

	/**
	* Entrega listado de cliente Prepago por número de teléfono
	*/
	public com.tmmas.gte.integraciongtecommon.dto.DatosClienteResponseDTO consultarClientePrepago(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("consultarClientePrepago:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.DatosClienteResponseDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.DatosClienteResponseDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call GE_INTEGRACION_PG.GE_CONS_CLIE_PRE_PR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setLong(1,inParam0.getNumeroTelefono());
			logger.debug("numeroTelefono[" + inParam0.getNumeroTelefono() + "]");

			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.ClienteDTO outParam1 = new com.tmmas.gte.integraciongtecommon.dto.ClienteDTO();
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam2 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(2,java.sql.Types.DATE);
			cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(12,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(13,java.sql.Types.DATE);
			cstmt.registerOutParameter(14,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(15,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(16,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(17,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(18,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(19,java.sql.Types.NUMERIC);

			logger.info("execute():antes");
			cstmt.execute();
			logger.info("execute():despues");

			logger.info("setea respuesta de stored procedure...");
			outParam2.setCodigoError(cstmt.getInt(17));
			logger.debug("codigoError[" + outParam2.getCodigoError() + "]");

			outParam2.setMensajeError(cstmt.getString(18));
			logger.debug("mensajeError[" + outParam2.getMensajeError() + "]");

			outParam2.setNumeroEvento(cstmt.getLong(19));
			logger.debug("numeroEvento[" + outParam2.getNumeroEvento() + "]");

			logger.info("verifica condicion de error del stored procedure...");
			if(outParam2.getCodigoError() != 0 ) {
				logger.info("Codigo de error != 0");
				outParam0.setRespuesta(outParam2);
				return outParam0;
			}
			logger.info("seteando clase de  repuesta a la clase padre...");
			outParam0.setRespuesta(outParam2);

			outParam1.setSysDate(new java.util.Date(cstmt.getDate(2).getTime()));
			logger.debug("sysDate[" + outParam1.getSysDate() + "]");

			outParam1.setNumCelular(cstmt.getLong(3));
			logger.debug("numCelular[" + outParam1.getNumCelular() + "]");

			outParam1.setCodCliente(cstmt.getLong(4));
			logger.debug("codCliente[" + outParam1.getCodCliente() + "]");

			outParam1.setNomCliente(cstmt.getString(5));
			logger.debug("nomCliente[" + outParam1.getNomCliente() + "]");

			outParam1.setNomApeclien1(cstmt.getString(6));
			logger.debug("nomApeclien1[" + outParam1.getNomApeclien1() + "]");

			outParam1.setNomApeclien2(cstmt.getString(7));
			logger.debug("nomApeclien2[" + outParam1.getNomApeclien2() + "]");

			outParam1.setNumIdent(cstmt.getString(8));
			logger.debug("numIdent[" + outParam1.getNumIdent() + "]");

			outParam1.setCodTipident(cstmt.getString(9));
			logger.debug("codTipident[" + outParam1.getCodTipident() + "]");

			outParam1.setDesNit(cstmt.getString(10));
			logger.debug("desNit[" + outParam1.getDesNit() + "]");

			outParam1.setNumIdent2(cstmt.getString(11));
			logger.debug("numIdent2[" + outParam1.getNumIdent2() + "]");

			outParam1.setCodTipident2(cstmt.getString(12));
			logger.debug("codTipident2[" + outParam1.getCodTipident2() + "]");

			Date fechaNac = cstmt.getDate(13);
			if(fechaNac != null){
				outParam1.setFecNacimien(new java.util.Date(cstmt.getDate(13).getTime()));
			}else{
				outParam1.setFecNacimien(fechaNac);
			}
			logger.debug("fecNacimien[" + outParam1.getFecNacimien() + "]");

			outParam1.setCodTecnologia(cstmt.getString(14));
			logger.debug("codTecnologia[" + outParam1.getCodTecnologia() + "]");

			outParam1.setNumSerie(cstmt.getString(15));
			logger.debug("numSerie[" + outParam1.getNumSerie() + "]");

			outParam1.setNumImei(cstmt.getString(16));
			logger.debug("numImei[" + outParam1.getNumImei() + "]");

			logger.info("Seteando propiedades hijas a la clase padre...");
			outParam0.setDatosCliente(outParam1);

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

		logger.info("consultarClientePrepago:end()");
		return outParam0;
	}

	/**
	* Entrega listado cliente por código de cliente
	*/
	public com.tmmas.gte.integraciongtecommon.dto.DatosClienteResponseDTO consultarClienteXCodigo(com.tmmas.gte.integraciongtecommon.dto.CodClienteDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("consultarClienteXCodigo:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.DatosClienteResponseDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.DatosClienteResponseDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call GE_INTEGRACION_PG.GE_CONS_CLIE_COD_PR(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setLong(1,inParam0.getCodCliente());
			logger.debug("codCliente[" + inParam0.getCodCliente() + "]");

			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.ClienteDTO outParam1 = new com.tmmas.gte.integraciongtecommon.dto.ClienteDTO();
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam2 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(2,java.sql.Types.DATE);
			cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(12,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(13,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(14,java.sql.Types.DATE);
			cstmt.registerOutParameter(15,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(16,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(17,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(18,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(19,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(20,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(21,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(22,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(23,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(24,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(25,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(26,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(27,java.sql.Types.NUMERIC);

			logger.info("execute():antes");
			cstmt.execute();
			logger.info("execute():despues");

			logger.info("setea respuesta de stored procedure...");
			outParam2.setCodigoError(cstmt.getInt(25));
			logger.debug("codigoError[" + outParam2.getCodigoError() + "]");

			outParam2.setMensajeError(cstmt.getString(26));
			logger.debug("mensajeError[" + outParam2.getMensajeError() + "]");

			outParam2.setNumeroEvento(cstmt.getLong(27));
			logger.debug("numeroEvento[" + outParam2.getNumeroEvento() + "]");

			logger.info("verifica condicion de error del stored procedure...");
			if(outParam2.getCodigoError() != 0 ) {
				logger.info("Codigo de error != 0");
				outParam0.setRespuesta(outParam2);
				return outParam0;
			}
			logger.info("seteando clase de  repuesta a la clase padre...");
			outParam0.setRespuesta(outParam2);

			outParam1.setSysDate(new java.util.Date(cstmt.getDate(2).getTime()));
			logger.debug("sysDate[" + outParam1.getSysDate() + "]");

			outParam1.setCodCliente(cstmt.getLong(3));
			logger.debug("codCliente[" + outParam1.getCodCliente() + "]");

			outParam1.setNomCliente(cstmt.getString(4));
			logger.debug("nomCliente[" + outParam1.getNomCliente() + "]");

			outParam1.setNomApeclien1(cstmt.getString(5));
			logger.debug("nomApeclien1[" + outParam1.getNomApeclien1() + "]");

			outParam1.setNomApeclien2(cstmt.getString(6));
			logger.debug("nomApeclien2[" + outParam1.getNomApeclien2() + "]");

			outParam1.setNumIdent(cstmt.getString(7));
			logger.debug("numIdent[" + outParam1.getNumIdent() + "]");

			outParam1.setCodTipident(cstmt.getString(8));
			logger.debug("codTipident[" + outParam1.getCodTipident() + "]");

			outParam1.setDesNit(cstmt.getString(9));
			logger.debug("desNit[" + outParam1.getDesNit() + "]");

			outParam1.setNumIdent2(cstmt.getString(10));
			logger.debug("numIdent2[" + outParam1.getNumIdent2() + "]");

			outParam1.setCodTipident2(cstmt.getString(11));
			logger.debug("codTipident2[" + outParam1.getCodTipident2() + "]");

			outParam1.setNumIdentapor(cstmt.getString(12));
			logger.debug("numIdentapor[" + outParam1.getNumIdentapor() + "]");

			outParam1.setCodTipidentapor(cstmt.getString(13));
			logger.debug("codTipidentapor[" + outParam1.getCodTipidentapor() + "]");

			
			
			Date fechaNac = cstmt.getDate(14);
			if(fechaNac != null){
				outParam1.setFecNacimien(new java.util.Date(cstmt.getDate(14).getTime()));
			}else{
				outParam1.setFecNacimien(fechaNac);
			}

			outParam1.setCodProfesion(cstmt.getLong(15));
			logger.debug("codProfesion[" + outParam1.getCodProfesion() + "]");

			outParam1.setCodOcupacion(cstmt.getString(16));
			logger.debug("codOcupacion[" + outParam1.getCodOcupacion() + "]");
			
			outParam1.setNomApoderado(cstmt.getString(17));
			logger.debug("nomApoderado[" + outParam1.getNomApoderado() + "]");

			outParam1.setIndEstcivil(cstmt.getString(18));
			logger.debug("indEstcivil[" + outParam1.getIndEstcivil() + "]");

			outParam1.setEstadoCivil(cstmt.getString(19));
			logger.debug("estadoCivil[" + outParam1.getEstadoCivil() + "]");

			outParam1.setCodPais(cstmt.getString(20));
			logger.debug("codPais[" + outParam1.getCodPais() + "]");

			outParam1.setDesPais(cstmt.getString(21));
			logger.debug("desPais[" + outParam1.getDesPais() + "]");

			outParam1.setCodTipo(cstmt.getString(22));
			logger.debug("codTipo[" + outParam1.getCodTipo() + "]");

			outParam1.setTipCliente(cstmt.getString(23));
			logger.debug("tipCliente[" + outParam1.getTipCliente() + "]");

			outParam1.setTefCliente1(cstmt.getString(24));
			logger.debug("tefCliente1[" + outParam1.getTefCliente1() + "]");

			logger.info("Seteando propiedades hijas a la clase padre...");
			outParam0.setDatosCliente(outParam1);

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

		logger.info("consultarClienteXCodigo:end()");
		return outParam0;
	}

	/**
	* 
	*/
	public com.tmmas.gte.integraciongtecommon.dto.DatosClienteResponseDTO consultarTipoCliente(com.tmmas.gte.integraciongtecommon.dto.CodClienteDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("consultarTipoCliente:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.DatosClienteResponseDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.DatosClienteResponseDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call GE_INTEGRACION_PG.GE_CONS_TIPO_CLIENTE_PR(?,?,?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setLong(1,inParam0.getCodCliente());
			logger.debug("codCliente[" + inParam0.getCodCliente() + "]");

			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.ClienteDTO outParam1 = new com.tmmas.gte.integraciongtecommon.dto.ClienteDTO();
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam2 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(2,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7,java.sql.Types.NUMERIC);

			logger.info("execute():antes");
			cstmt.execute();
			logger.info("execute():despues");

			logger.info("setea respuesta de stored procedure...");
			outParam2.setCodigoError(cstmt.getInt(5));
			logger.debug("codigoError[" + outParam2.getCodigoError() + "]");

			outParam2.setMensajeError(cstmt.getString(6));
			logger.debug("mensajeError[" + outParam2.getMensajeError() + "]");

			outParam2.setNumeroEvento(cstmt.getLong(7));
			logger.debug("numeroEvento[" + outParam2.getNumeroEvento() + "]");

			logger.info("verifica condicion de error del stored procedure...");
			if(outParam2.getCodigoError() != 0 ) {
				logger.info("Codigo de error != 0");
				outParam0.setRespuesta(outParam2);
				return outParam0;
			}
			logger.info("seteando clase de  repuesta a la clase padre...");
			outParam0.setRespuesta(outParam2);

			outParam1.setCodCliente(cstmt.getLong(2));
			logger.debug("codCliente[" + outParam1.getCodCliente() + "]");

			outParam1.setCodTipo(cstmt.getString(3));
			logger.debug("codTipo[" + outParam1.getCodTipo() + "]");

			outParam1.setTipCliente(cstmt.getString(4));
			logger.debug("tipCliente[" + outParam1.getTipCliente() + "]");

			logger.info("Seteando propiedades hijas a la clase padre...");
			outParam0.setDatosCliente(outParam1);

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

		logger.info("consultarTipoCliente:end()");
		return outParam0;
	}
	/**
	* Entrega segmento del Cliente (Obtener Segmento del Cliente)
	*/
	public com.tmmas.gte.integraciongtecommon.dto.SegmentoClienteResponseDTO obtenerSegmentoCliente(com.tmmas.gte.integraciongtecommon.dto.CodClienteDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("obtenerSegmentoCliente:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.SegmentoClienteResponseDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.SegmentoClienteResponseDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call GE_INTEGRACION_PG.ge_obtener_seg_cliente_pr(?,?,?,?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setLong(1,inParam0.getCodCliente());
			logger.debug("codCliente[" + inParam0.getCodCliente() + "]");

			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam1 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(2,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8,java.sql.Types.NUMERIC);

			logger.info("execute():antes");
			cstmt.execute();
			logger.info("execute():despues");

			logger.info("setea respuesta de stored procedure...");
			outParam1.setCodigoError(cstmt.getInt(6));
			logger.debug("codigoError[" + outParam1.getCodigoError() + "]");

			outParam1.setMensajeError(cstmt.getString(7));
			logger.debug("mensajeError[" + outParam1.getMensajeError() + "]");

			outParam1.setNumeroEvento(cstmt.getLong(8));
			logger.debug("numeroEvento[" + outParam1.getNumeroEvento() + "]");

			logger.info("verifica condicion de error del stored procedure...");
			if(outParam1.getCodigoError() != 0 ) {
				logger.info("Codigo de error != 0");
				outParam0.setRespuesta(outParam1);
				return outParam0;
			}
			logger.info("seteando clase de  repuesta a la clase padre...");
			outParam0.setRespuesta(outParam1);

			outParam0.setCodSegmento(cstmt.getString(2));
			logger.debug("codSegmento[" + outParam0.getCodSegmento() + "]");

			outParam0.setDesSegmento(cstmt.getString(3));
			logger.debug("desSegmento[" + outParam0.getDesSegmento() + "]");

			outParam0.setCodTipo(cstmt.getString(4));
			logger.debug("codTipo[" + outParam0.getCodTipo() + "]");

			outParam0.setDesTipo(cstmt.getString(5));
			logger.debug("desTipo[" + outParam0.getDesTipo() + "]");

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

		logger.info("obtenerSegmentoCliente:end()");
		return outParam0;
	}
	
	/**
	* Consulta si Cliente es Facturable
	*/
	public com.tmmas.gte.integraciongtecommon.dto.RespBooleanDTO validarClieFacturable(com.tmmas.gte.integraciongtecommon.dto.ConsClieFacturableDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("validarClieFacturable:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.RespBooleanDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.RespBooleanDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call GE_INTEGRACION_PG.ge_val_clie_facturable_pr(?,?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setLong(1,inParam0.getCodCliente());
			logger.debug("codCliente[" + inParam0.getCodCliente() + "]");

			cstmt.setLong(2,inParam0.getNumAbonado());
			logger.debug("numAbonado[" + inParam0.getNumAbonado() + "]");

			cstmt.setLong(3,inParam0.getCodCicloFact());
			logger.debug("codCicloFact[" + inParam0.getCodCicloFact() + "]");

			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam1 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6,java.sql.Types.NUMERIC);

			logger.info("execute():antes");
			cstmt.execute();
			logger.info("execute():despues");

			logger.info("setea respuesta de stored procedure...");
			outParam1.setCodigoError(cstmt.getInt(4));
			logger.debug("codigoError[" + outParam1.getCodigoError() + "]");

			outParam1.setMensajeError(cstmt.getString(5));
			logger.debug("mensajeError[" + outParam1.getMensajeError() + "]");

			outParam1.setNumeroEvento(cstmt.getLong(6));
			logger.debug("numeroEvento[" + outParam1.getNumeroEvento() + "]");

			logger.info("verifica condicion de error del stored procedure...");
			if(outParam1.getCodigoError() != 0 ) {
				logger.info("Codigo de error != 0");
				outParam0.setRespuesta(outParam1);
				return outParam0;
			}
			logger.info("seteando clase de  repuesta a la clase padre...");
			outParam0.setRespuesta(outParam1);

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

		logger.info("validarClieFacturable:end()");
		return outParam0;
	}

	/**
	* Retorna los Datos del Distribuidor asociado al Código de Distribuidor ingresado
	*/
	public com.tmmas.gte.integraciongtecommon.dto.DistribuidorResponseDTO consultarDatosDistrib(com.tmmas.gte.integraciongtecommon.dto.DistribuidorDTO inParam0)
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
			String call = "{call GE_INTEGRACION_PG.ge_obtener_datos_distrib_pr(?,?,?,?,?,?,?,?,?)}";
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
			
			cstmt.registerOutParameter(7,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9,java.sql.Types.NUMERIC);

			logger.info("execute():antes");
			cstmt.execute();
			logger.info("execute():despues");

			logger.info("setea respuesta de stored procedure...");
			outParam1.setCodigoError(cstmt.getInt(7));
			logger.debug("codigoError[" + outParam1.getCodigoError() + "]");

			outParam1.setMensajeError(cstmt.getString(8));
			logger.debug("mensajeError[" + outParam1.getMensajeError() + "]");

			outParam1.setNumeroEvento(cstmt.getLong(9));
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

			/*outParam0.setCodTipContrato(cstmt.getString(7));
			logger.debug("codTipContrato[" + outParam0.getCodTipContrato() + "]");

			outParam0.setDesTipContrato(cstmt.getString(8));
			logger.debug("desTipContrato[" + outParam0.getDesTipContrato() + "]");

			outParam0.setNumContrato(cstmt.getString(9));
			logger.debug("numContrato[" + outParam0.getNumContrato() + "]");

			outParam0.setNumAnexo(cstmt.getString(10));
			logger.debug("numAnexo[" + outParam0.getNumAnexo() + "]");

			outParam0.setFecContrato(new java.util.Date(cstmt.getDate(11).getTime()));
			logger.debug("fecContrato[" + outParam0.getFecContrato() + "]");*/

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
	public com.tmmas.gte.integraciongtecommon.dto.DistribBodegasResponseDTO consultarBodegasDistrib(com.tmmas.gte.integraciongtecommon.dto.DistribuidorDTO inParam0)
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
			String call = "{call GE_INTEGRACION_PG.ge_obtener_bodegas_distrib_pr(?,?,?,?,?)}";
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
	public com.tmmas.gte.integraciongtecommon.dto.DistribPedidoResponseDTO consultarPedidoDistrib(com.tmmas.gte.integraciongtecommon.dto.DistribuidorDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("consPedidoDistrib:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.DistribPedidoResponseDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.DistribPedidoResponseDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call GE_INTEGRACION_PG.ge_obtener_pedido_distrib_pr(?,?,?,?,?,?,?,?,?,?)}";
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
			String call = "{call GE_INTEGRACION_PG.GE_CONS_DISTRIBUIDOR_PR(?,?,?,?,?)}";
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