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

public class AbonadoDTODAOImpl extends com.tmmas.cl.framework.base.ConnectionDAO implements AbonadoDTODAO{
	private CompositeConfiguration config;
	private static Logger logger = Logger.getLogger(AbonadoDTODAOImpl.class);
	private Global global = Global.getInstance();
	private ServiceLocator  serviceLocator = ServiceLocator.getInstance();

	public AbonadoDTODAOImpl() {
		config = UtilProperty.getConfiguration("IntegracionGte.properties", "com/tmmas/gte/integraciongtebo/properties/IntegracionGTEBO.properties");
	}
 
	/**
	* Entrega Datos del Abonado
	*/
	public com.tmmas.gte.integraciongtecommon.dto.AbonadoOutDTO consultarAbonadoCliTel(com.tmmas.gte.integraciongtecommon.dto.EsClieTelefDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("consultarAbonadoCliTel:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.AbonadoOutDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.AbonadoOutDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call GE_INTEGRACION_PG.ge_cons_abo_clie_telef_pr(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setLong(1,inParam0.getCodCliente());
			logger.debug("codCliente[" + inParam0.getCodCliente() + "]");

			cstmt.setLong(2,inParam0.getNumeroTelefono());
			logger.debug("numeroTelefono[" + inParam0.getNumeroTelefono() + "]");

			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.AbonadoDTO outParam1 = new com.tmmas.gte.integraciongtecommon.dto.AbonadoDTO();
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam2 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(12,java.sql.Types.DATE);
			cstmt.registerOutParameter(13,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(14,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(15,java.sql.Types.NUMERIC);

			logger.info("execute():antes");
			cstmt.execute();
			logger.info("execute():despues");

			logger.info("setea respuesta de stored procedure...");
			outParam2.setCodigoError(cstmt.getInt(13));
			logger.debug("codigoError[" + outParam2.getCodigoError() + "]");

			outParam2.setMensajeError(cstmt.getString(14));
			logger.debug("mensajeError[" + outParam2.getMensajeError() + "]");

			outParam2.setNumeroEvento(cstmt.getLong(15));
			logger.debug("numeroEvento[" + outParam2.getNumeroEvento() + "]");

			logger.info("verifica condicion de error del stored procedure...");
			if(outParam2.getCodigoError() != 0 ) {
				logger.info("Codigo de error != 0");
				outParam0.setRespuesta(outParam2);
				return outParam0;
			}
			logger.info("seteando clase de  repuesta a la clase padre...");
			outParam0.setRespuesta(outParam2);

			outParam1.setNumAbonado(cstmt.getInt(3));
			logger.debug("numAbonado[" + outParam1.getNumAbonado() + "]");

			outParam1.setCodCuenta(cstmt.getLong(4));
			logger.debug("codCuenta[" + outParam1.getCodCuenta() + "]");

			outParam1.setCodUso(cstmt.getInt(5));
			logger.debug("codUso[" + outParam1.getCodUso() + "]");

			outParam1.setCodSituacion(cstmt.getString(6));
			logger.debug("codSituacion[" + outParam1.getCodSituacion() + "]");

			outParam1.setCodVendedor(cstmt.getInt(7));
			logger.debug("codVendedor[" + outParam1.getCodVendedor() + "]");

			outParam1.setTipPlantarif(cstmt.getString(8));
			logger.debug("tipPlantarif[" + outParam1.getTipPlantarif() + "]");

			outParam1.setTipTerminal(cstmt.getString(9));
			logger.debug("tipTerminal[" + outParam1.getTipTerminal() + "]");

			outParam1.setCodPlantarif(cstmt.getString(10));
			logger.debug("codPlantarif[" + outParam1.getCodPlantarif() + "]");

			outParam1.setNumSerie(cstmt.getString(11));
			logger.debug("numSerie[" + outParam1.getNumSerie() + "]");

			outParam1.setFecAlta(new java.util.Date(cstmt.getDate(12).getTime()));
			logger.debug("fecAlta[" + outParam1.getFecAlta() + "]");

			logger.info("Seteando propiedades hijas a la clase padre...");
			java.util.List listaNueva = new java.util.ArrayList();
			listaNueva.add(outParam1);
			outParam0.setListadoAbonados((com.tmmas.gte.integraciongtecommon.dto.AbonadoDTO[])
					com.tmmas.cl.framework.util.ArrayUtl.copiaArregloTipoEspecifico(listaNueva.toArray(),
											com.tmmas.gte.integraciongtecommon.dto.AbonadoDTO.class));

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

		logger.info("consultarAbonadoCliTel:end()");
		return outParam0;
	}
	/**
	* Retorna datos del cliente a partir de un número de telefono.
	*/
	public com.tmmas.gte.integraciongtecommon.dto.AbonadoOutDTO consultarAbonadoTelefono(com.tmmas.gte.integraciongtecommon.dto.EsTelefIgualClieDTO inParam0)
	 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("consultarAbonadoTelefono:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.AbonadoOutDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.AbonadoOutDTO();
		
		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}
		
		try {
			String call = "{call GE_INTEGRACION_PG.ge_cons_abo_tel_pr(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
			logger.info("call[" + call + "]");
		
			cstmt = conn.prepareCall(call);
		
			logger.info("armar parametros de entrada...");
			cstmt.setLong(1,inParam0.getNum_telefono1());
			logger.debug("num_telefono1[" + inParam0.getNum_telefono1() + "]");
		
			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.AbonadoDTO outParam1 = new com.tmmas.gte.integraciongtecommon.dto.AbonadoDTO();
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam2 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();
		
			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(2,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(10,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(12,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(13,java.sql.Types.VARCHAR);
			
			cstmt.registerOutParameter(14,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(15,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(16,java.sql.Types.NUMERIC);
		
			logger.info("execute():antes");
			cstmt.execute();
			logger.info("execute():despues");
		
			logger.info("setea respuesta de stored procedure...");
			outParam2.setCodigoError(cstmt.getInt(14));
			logger.debug("codigoError[" + outParam2.getCodigoError() + "]");
		
			outParam2.setMensajeError(cstmt.getString(15));
			logger.debug("mensajeError[" + outParam2.getMensajeError() + "]");
		
			outParam2.setNumeroEvento(cstmt.getLong(16));
			logger.debug("numeroEvento[" + outParam2.getNumeroEvento() + "]");
		
			logger.info("verifica condicion de error del stored procedure...");
			if(outParam2.getCodigoError() != 0 ) {
				logger.info("Codigo de error != 0");
				outParam0.setRespuesta(outParam2);
				return outParam0;
			}
			logger.info("seteando clase de  repuesta a la clase padre...");
			outParam0.setRespuesta(outParam2);
		
			outParam1.setNumAbonado(cstmt.getInt(2));
			logger.debug("numAbonado[" + outParam1.getNumAbonado() + "]");
		
			outParam1.setCodCliente(cstmt.getInt(3));
			logger.debug("codCliente[" + outParam1.getCodCliente() + "]");
		
			outParam1.setTipAbonado(cstmt.getString(4));
			logger.debug("tipAbonado[" + outParam1.getTipAbonado() + "]");
		
			outParam1.setCodTecnologia(cstmt.getString(5));
			logger.debug("codTecnologia[" + outParam1.getCodTecnologia() + "]");
		
			outParam1.setNumSerie(cstmt.getString(6));
			logger.debug("numSerie[" + outParam1.getNumSerie() + "]");
		
			outParam1.setNumImei(cstmt.getString(7));
			logger.debug("numImei[" + outParam1.getNumImei() + "]");
		
			outParam1.setCodPrestacion(cstmt.getString(8));
			logger.debug("codPrestacion[" + outParam1.getCodPrestacion() + "]");
		
			outParam1.setCodCuenta(cstmt.getLong(9));
			logger.debug("codCuenta[" + outParam1.getCodCuenta() + "]");
		
			outParam1.setCodPlanTarif(cstmt.getString(10));
			logger.debug("codPlanTarif[" + outParam1.getCodPlanTarif() + "]");
		
			outParam1.setDesPrestacion(cstmt.getString(11));
			logger.debug("desPrestacion[" + outParam1.getDesPrestacion() + "]");
		
			outParam1.setCodTiplan(cstmt.getString(12));
			logger.debug("codTiplan[" + outParam1.getCodTiplan() + "]");

			outParam1.setCodPlanServi(cstmt.getString(13));
			logger.debug("codPlanServi[" + outParam1.getCodPlanServi() + "]");
		
			logger.info("Seteando propiedades hijas a la clase padre...");
			java.util.List listaNueva = new java.util.ArrayList();
			listaNueva.add(outParam1);
		
			outParam0.setListadoAbonados((com.tmmas.gte.integraciongtecommon.dto.AbonadoDTO[])
					com.tmmas.cl.framework.util.ArrayUtl.copiaArregloTipoEspecifico(listaNueva.toArray(),
											com.tmmas.gte.integraciongtecommon.dto.AbonadoDTO.class));
			
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
		
		logger.info("consultarAbonadoTelefono:end()");
		return outParam0;
		}	
	/**
	* Retorna numAbonado y codCliente a partir de un numCelular pospago o hibrido
	*/
	public com.tmmas.gte.integraciongtecommon.dto.AbonadoPospagoOutDTO consAbonadoPospagoHibrido(com.tmmas.gte.integraciongtecommon.dto.NumeroPlanTarifDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("consAbonadoPospagoHibrido:start()");
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
			String call = "{call GE_INTEGRACION_PG.ge_val_pospago_hib_pr(?,?,?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setLong(1,inParam0.getNumeroTelefono());
			logger.debug("numeroTelefono[" + inParam0.getNumeroTelefono() + "]");

			cstmt.setString(2,inParam0.getDesPlanTarifario());
			logger.debug("desPlanTarifario[" + inParam0.getDesPlanTarifario() + "]");

			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.AbonadoPospagoDTO outParam1 = new com.tmmas.gte.integraciongtecommon.dto.AbonadoPospagoDTO();
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam2 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
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

			outParam1.setNumAbonado(cstmt.getLong(3));
			logger.debug("numAbonado[" + outParam1.getNumAbonado() + "]");

			outParam1.setCodCliente(cstmt.getLong(4));
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

		logger.info("consAbonadoPospagoHibrido:end()");
		return outParam0;
	}
	/**
	* Consulta la fecha de Alta de un numero ingresado
	*/
	public com.tmmas.gte.integraciongtecommon.dto.AltaPrepagoResponseDTO consultarFechaAlta(com.tmmas.gte.integraciongtecommon.dto.AltaPrepagoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("consultarFechaAlta:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.AltaPrepagoResponseDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.AltaPrepagoResponseDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call GE_INTEGRACION_PG.GE_CONS_FECALTA_PREPAGO_PR(?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setLong(1,inParam0.getNumTelefono());
			logger.debug("numTelefono[" + inParam0.getNumTelefono() + "]");

			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam1 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(2,java.sql.Types.DATE);
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

			outParam0.setFechaAlta(new java.util.Date(cstmt.getDate(2).getTime()));
			logger.debug("fechaAlta[" + outParam0.getFechaAlta() + "]");

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

		logger.info("consultarFechaAlta:end()");
		return outParam0;
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
	
	/**
	* se ingresa un código de OOSS y un numero de abonado, el metodo retorna el OrdenServicioOutDTO
	*/
	public com.tmmas.gte.integraciongtecommon.dto.OrdenServicioOutDTO consultarOOSSEjec(com.tmmas.gte.integraciongtecommon.dto.OrdenServicioDTO inParam0)
	 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("consultarOOSSEjec:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.OrdenServicioDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.OrdenServicioDTO();
		com.tmmas.gte.integraciongtecommon.dto.OrdenServicioOutDTO outParam2 = new com.tmmas.gte.integraciongtecommon.dto.OrdenServicioOutDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}
		
		try {
			String call = "{call GE_INTEGRACION_PG.GE_CONS_ULT_OOSS_EJEC_PR(?,?,?,?,?,?,?)}";
			logger.info("call[" + call + "]");
		
			cstmt = conn.prepareCall(call);
		
			logger.info("armar parametros de entrada...");
			cstmt.setString(1,inParam0.getCodOs());
			logger.debug("codOs[" + inParam0.getCodOs() + "]");
		
			cstmt.setLong(2,inParam0.getCodInter());
			logger.debug("codInter[" + inParam0.getCodInter() + "]");

			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam1 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();
		
			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4,java.sql.Types.DATE);
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
		
			outParam1.setNumeroEvento(cstmt.getLong(7));
			logger.debug("numeroEvento[" + outParam1.getNumeroEvento() + "]");
		
			logger.info("verifica condicion de error del stored procedure...");
			if(outParam1.getCodigoError() != 0 ) {
				logger.info("Codigo de error != 0");
				outParam2.setRespuesta(outParam1);
				return outParam2;
			}
			logger.info("seteando clase de  repuesta a la clase padre...");
			outParam2.setRespuesta(outParam1);
		
			outParam0.setNumOs(cstmt.getLong(3));
			logger.debug("numOs[" + outParam0.getNumOs() + "]");
		
			if(cstmt.getDate(4)==null){
				outParam0.setFechaOs(null);
			}else{
				outParam0.setFechaOs(new java.util.Date(cstmt.getDate(4).getTime()));
			}

			logger.debug("fechaOs[" + outParam0.getFechaOs() + "]");

			logger.info("Seteando propiedades hijas a la clase padre...");
			outParam2.setOrdenServicio(outParam0);
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
		
		logger.info("consultarOOSSEjec:end()");
		return outParam2;
	}	
	
	/**
	* se ingresa un código de orden de servicio y un numero de orden de servicio, el metodo retorna el ConsRenovacionDTO
	*/
	public com.tmmas.gte.integraciongtecommon.dto.ConsRenovacionDTO consultarIndRenova(com.tmmas.gte.integraciongtecommon.dto.OrdenServicioDTO inParam0)
	 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("consultarIndRenova:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.ConsRenovacionDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.ConsRenovacionDTO();
		
		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}
		
		try {
			String call = "{call GE_INTEGRACION_PG.GE_CONS_RENOVACION_PR(?,?,?,?,?,?)}";
			logger.info("call[" + call + "]");
		
			cstmt = conn.prepareCall(call);
		
			logger.info("armar parametros de entrada...");
			cstmt.setString(1,inParam0.getCodOs());
			logger.debug("codOs[" + inParam0.getCodOs() + "]");
		
			cstmt.setLong(2,inParam0.getNumOs());
			logger.debug("numOs[" + inParam0.getNumOs() + "]");
		
			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam1 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();
		
			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
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
		
			outParam0.setIndRenovacion(new Long(cstmt.getLong(3)));
			logger.debug("indRenovacion[" + outParam0.getIndRenovacion() + "]");
		
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
		
		logger.info("consultarIndRenova:end()");
		return outParam0;
	}	

}