package com.tmmas.scl.serviciospostventasiga.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.base.JndiForDataSource;
import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.serviciospostventasiga.businessobject.dao.helper.ConnectionHelper;
import com.tmmas.scl.serviciospostventasiga.businessobject.dao.helper.DAOHelper;
import com.tmmas.scl.serviciospostventasiga.common.helper.Global;
import com.tmmas.scl.serviciospostventasiga.common.helper.ServiciosPostVentaSigaLoggerHelper;
import com.tmmas.scl.serviciospostventasiga.transport.MigracionDTO;
import com.tmmas.scl.serviciospostventasiga.transport.ResultadoValidacionDatosMigracionDTO;



public class ValidacionClientePostpagoDAO extends ConnectionDAO{


	Global global = Global.getInstance();
	ServiciosPostVentaSigaLoggerHelper logger = ServiciosPostVentaSigaLoggerHelper.getInstance();
	private String nombreClase = this.getClass().getName();

	private Connection getConection() throws GeneralException {
		logger.info("getConection(): inicio", nombreClase);
		Connection conn = null;
		
		JndiForDataSource jndi = new JndiForDataSource();
		jndi.setJndiDataSource(global.getValorExterno("GE.jndi.dataSource.DAO"));
		try {
			conn = this.getConnectionFromWLSInitialContext(jndi);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		logger.info("getConection(): fin", nombreClase);
		return conn;
	}// fin getConection
	
	private String getSQL(String packageName, String procedureName,
			int paramCount) {
		StringBuffer sb = new StringBuffer("{call " + packageName + "."
				+ procedureName + "(");
		for (int n = 1; n <= paramCount; n++) {
			sb.append("?");
			if (n < paramCount)
				sb.append(",");
		}
		return sb.append(")}").toString();

	}// fin getSQL
	
	
	public ResultadoValidacionDatosMigracionDTO estadoAbonadoSituacionAAA(MigracionDTO datosMigracionClienteDTO)
	throws GeneralException 
	{
		logger.info("estadoAbonadoSituacionAAA: inicio", nombreClase);
		ResultadoValidacionDatosMigracionDTO resultado = new ResultadoValidacionDatosMigracionDTO();
		String codError = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = this.getConection();
		CallableStatement cstmt = null;
		
		try {
			String call = this.getSQL("VE_MIGRA_PREPAGO_POSTPAGO_PG", "VE_estado_abonado_aaa_PR", 5);
			cstmt = conn.prepareCall(call);
			logger.debug("datosMigracionClienteDTO.getNumCelular():" + datosMigracionClienteDTO.getNumCelular().longValue(), nombreClase);
			cstmt.setLong(1, datosMigracionClienteDTO.getNumCelular().longValue());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			logger.debug("inicio: cstmt.execute()", nombreClase);
			cstmt.execute();
			logger.debug("fin: cstmt.execute()", nombreClase);
			codError = cstmt.getString(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			resultado.setResultadoBase(cstmt.getInt(2));
			resultado.setCodigoError(codError);
			resultado.setMensajeError(msgError);
			resultado.setNumeroEvento(numEvento);

			if (codError.equals("-1")) {
				throw new GeneralException(
						"Ocurrió un error al verificar la situacion del abonado AAA", String
								.valueOf(codError), numEvento, msgError);
			}
			
		} catch (Exception e) {
			e.printStackTrace();

			throw new GeneralException(
					"-2148",0,"Ocurrió un error al verificar situación del abonado AAA");
		} finally {

			try {
				if (!conn.isClosed()) {
					cstmt.close();
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		}
		logger.info("estadoAbonadoSituacionAAA: fin", nombreClase);
		return resultado;
	}
	
	
	public ResultadoValidacionDatosMigracionDTO estadoClienteSinAbonados(MigracionDTO datosMigracionClienteDTO)
	throws GeneralException 
	{
		logger.info("estadoClienteSinAbonados: inicio", nombreClase);
		ResultadoValidacionDatosMigracionDTO resultado = new ResultadoValidacionDatosMigracionDTO();
		String codError = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = this.getConection();
		CallableStatement cstmt = null;
		
		try {
			String call = this.getSQL("VE_MIGRA_PREPAGO_POSTPAGO_PG", "VE_cliente_sin_abonados_PR", 5);
			cstmt = conn.prepareCall(call);
			
			logger.debug("datosMigracionClienteDTO.getCodCliente():" + datosMigracionClienteDTO.getCodCliente().longValue(), nombreClase);
			cstmt.setLong(1, datosMigracionClienteDTO.getCodCliente().longValue());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			cstmt.execute();

			codError = cstmt.getString(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			resultado.setResultadoBase(cstmt.getInt(2));
			resultado.setCodigoError(codError);
			resultado.setMensajeError(msgError);
			resultado.setNumeroEvento(numEvento);
			
			
//			if (!codError.equals("0")) {
//				throw new GeneralException(
//						"Ocurrió un error al verificar la situacion del cliente", String
//								.valueOf(codError), numEvento, msgError);
//			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new GeneralException(
					"-2148",0,"Ocurrió un error al verificar la situacion del cliente");

		}finally{
			logger.debug("Cerrando conexiones...",nombreClase);
			try { 
				if (cstmt != null) cstmt.close();
				if (conn!=null && !conn.isClosed())	conn.close();	
			} catch (SQLException e) {
				logger.error("ERROR: ", nombreClase);
				logger.error("SQLException[" + e + "]",nombreClase);
			}
			
			
		}
		logger.info("estadoClienteSinAbonados: fin", nombreClase);
		return resultado;
	}
	
	
	public ResultadoValidacionDatosMigracionDTO estadoPlanVigente(MigracionDTO datosMigracionClienteDTO)
	throws GeneralException 
	{
		logger.info("estadoPlanVigente: inicio", nombreClase);
		ResultadoValidacionDatosMigracionDTO resultado = new ResultadoValidacionDatosMigracionDTO();
		String codError = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = this.getConection();
		CallableStatement cstmt = null;
		
		try {
			
			String call = getSQL("VE_MIGRA_PREPAGO_POSTPAGO_PG",
					"VE_estado_plan_vigente_PR", 5);
			cstmt = conn.prepareCall(call);
			logger.debug("datosMigracionClienteDTO.getCodPlanTarif():" + datosMigracionClienteDTO.getCodPlanTarif(), nombreClase);
			cstmt.setString(1, datosMigracionClienteDTO.getCodPlanTarif());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			cstmt.execute();

			
			codError = cstmt.getString(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			resultado.setResultadoBase(cstmt.getInt(2));
			resultado.setCodigoError(codError);
			resultado.setMensajeError(msgError);
			resultado.setNumeroEvento(numEvento);
			
			
//			if (!codError.equals("0")) {
//				throw new GeneralException(
//						"Ocurrió un error al verificar plan vigente", String
//								.valueOf(codError), numEvento, msgError);
//			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new GeneralException(
					"-2148",0,"Ocurrió un error al verificar plan vigente.");
		} finally {
			try {
				if (!conn.isClosed()) {
					cstmt.close();
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		}
		logger.info("estadoPlanVigente: fin", nombreClase);
		return resultado;
	}
	
	
	public ResultadoValidacionDatosMigracionDTO getEstadoPlanVigente(MigracionDTO datosMigracionClienteDTO)
	throws GeneralException 
	{
		logger.info("getEstadoPlanVigente: inicio", nombreClase);
		ResultadoValidacionDatosMigracionDTO resultado = null;
		String codError = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = this.getConection();
		CallableStatement cstmt = null;
		
		try {
			
			String call = getSQL("VE_MIGRA_PREPAGO_POSTPAGO_PG",
					"VE_obtiene_estado_plan_PR", 6);
			cstmt = conn.prepareCall(call);

			logger.debug("datosMigracionClienteDTO.getCodPlanTarif():" + datosMigracionClienteDTO.getCodPlanTarif(), nombreClase);
			cstmt.setString(1, datosMigracionClienteDTO.getCodPlanTarif());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			
			cstmt.execute();
						
			codError = cstmt.getString(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);
			resultado = new ResultadoValidacionDatosMigracionDTO();
			resultado.setEstadoPlanVigente(cstmt.getLong(2));
			resultado.setCodPlanComverse(cstmt.getString(3));
			resultado.setCodigoError(codError);
			resultado.setMensajeError(msgError);
			resultado.setNumeroEvento(numEvento);
			
			System.out.println("CodPlanComverse=[" + resultado.getCodPlanComverse() + "]");
			
//			if (!codError.equals("0")) {
//				throw new GeneralException(
//						"Ocurrió un error al obtener estado plan vigente", String
//								.valueOf(codError), numEvento, msgError);
//			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new GeneralException("ERR.01165",1165,global.getValor("ERR.01165")); 
		} finally {
			try {
				if (!conn.isClosed()) {
					cstmt.close();
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		logger.info("getEstadoPlanVigente: fin", nombreClase);
		return resultado;
	}
	
	
	
	public ResultadoValidacionDatosMigracionDTO estadoIMEIVigente(MigracionDTO datosMigracionClienteDTO)
	throws GeneralException 
	{
		logger.info("estadoIMEIVigente: inicio", nombreClase);
		ResultadoValidacionDatosMigracionDTO resultado = new ResultadoValidacionDatosMigracionDTO();
		String codError = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = this.getConection();
		CallableStatement cstmt = null;
		
		try {
			
			String call = getSQL("VE_MIGRA_PREPAGO_POSTPAGO_PG",
					"VE_estado_imei_vigente_PR", 4);
			cstmt = conn.prepareCall(call);
			System.out.println("DAO IMEI: " + datosMigracionClienteDTO.getImei());
			logger.debug("datosMigracionClienteDTO.getImei():" + datosMigracionClienteDTO.getImei(), nombreClase);
			cstmt.setString(1, datosMigracionClienteDTO.getImei());
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			
			cstmt.execute();
			
			codError = cstmt.getString(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);
			System.out.println("DAO IMEI RESP: " + cstmt.getString(2));
			if(cstmt.getString(2).equals("0")){
				resultado.setResultadoBase(1);
			} 
			else if(cstmt.getString(2).equals("-1")){
				resultado.setResultadoBase(0);
			}
			else if(cstmt.getString(2).equals("2")){
				codError = "000018";
				throw new GeneralException("ERR." + codError,new Integer(codError).intValue(),global.getValor("ERR." + codError));
			}
			
			resultado.setCodigoError(codError);
			resultado.setMensajeError(msgError);
			resultado.setNumeroEvento(numEvento);
			
//			if (!codError.equals("0")) {
//				throw new GeneralException(
//						"Ocurrió un error al obtener estado del IMEI vigente", String
//								.valueOf(codError), numEvento, msgError);
//			}
			
		} catch (Exception e) {
			e.printStackTrace();

			throw new GeneralException("ERR." + codError,new Integer(codError).intValue(),global.getValor("ERR." + codError));
		} finally {
			try {
				if (!conn.isClosed()) {
					cstmt.close();
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		}
		logger.info("estadoIMEIVigente: fin", nombreClase);
		return resultado;
	}
	
	
	public ResultadoValidacionDatosMigracionDTO estadoVendedorVigente(MigracionDTO datosMigracionClienteDTO)
	throws GeneralException 
	{
		logger.info("estadoVendedorVigente: inicio", nombreClase);	
		ResultadoValidacionDatosMigracionDTO resultado = new ResultadoValidacionDatosMigracionDTO();
		String codError = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = this.getConection();
		CallableStatement cstmt = null;
		
		try {
			
			String call = getSQL("VE_MIGRA_PREPAGO_POSTPAGO_PG",
					"VE_estado_vendedor_vigente_PR", 5);
			cstmt = conn.prepareCall(call);
			logger.debug("datosMigracionClienteDTO.getNomUsuarioVendedor():" + datosMigracionClienteDTO.getNomUsuarioVendedor(), nombreClase);
			cstmt.setString(1, datosMigracionClienteDTO.getNomUsuarioVendedor());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			cstmt.execute();

			codError = cstmt.getString(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			resultado.setResultadoBase(cstmt.getInt(2));
			resultado.setCodigoError(codError);
			resultado.setMensajeError(msgError);
			resultado.setNumeroEvento(numEvento);
			
//			if (!codError.equals("0")) {
//				throw new GeneralException(
//						"Ocurrió un error al verificar vendedor vigente", String
//								.valueOf(codError), numEvento, msgError);
//			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new GeneralException(
					"-2148",0,"Ocurrió un error al verificar vendedor vigente");
		} finally {

			try {
				if (!conn.isClosed()) {
					cstmt.close();
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		}
		logger.info("estadoVendedorVigente: fin", nombreClase);
		return resultado;
	}
	
	public ResultadoValidacionDatosMigracionDTO estadoDatosExistentes(MigracionDTO datosMigracionClienteDTO)
	throws GeneralException 
	{
		logger.info("estadoDatosExistentes: inicio", nombreClase);
		ResultadoValidacionDatosMigracionDTO resultado = new ResultadoValidacionDatosMigracionDTO();
		String codError = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = this.getConection();
		CallableStatement cstmt = null;
		try {
			String call = getSQL("VE_MIGRA_PREPAGO_POSTPAGO_PG",
					"PV_VAL_PARAMETROS_PR", 9);
			cstmt = conn.prepareCall(call);

			logger.debug("datosMigracionClienteDTO.getCodCliente():" + datosMigracionClienteDTO.getCodCliente().longValue(), nombreClase);
			cstmt.setLong(1, datosMigracionClienteDTO.getCodCliente().longValue());
			logger.debug("datosMigracionClienteDTO.getCodPlanTarif():" + datosMigracionClienteDTO.getCodPlanTarif(), nombreClase);
			cstmt.setString(2, datosMigracionClienteDTO.getCodPlanTarif());
			logger.debug("datosMigracionClienteDTO.getNumCelular():" + datosMigracionClienteDTO.getNumCelular().longValue(), nombreClase);
			cstmt.setLong(3, datosMigracionClienteDTO.getNumCelular().longValue());
			logger.debug("datosMigracionClienteDTO.getImei():" + datosMigracionClienteDTO.getImei(), nombreClase);
			cstmt.setString(4, datosMigracionClienteDTO.getImei());
			logger.debug("datosMigracionClienteDTO.getNomUsuarioVendedor():" + datosMigracionClienteDTO.getNomUsuarioVendedor(), nombreClase);
			cstmt.setString(5, datosMigracionClienteDTO.getNomUsuarioVendedor());
			logger.debug("datosMigracionClienteDTO.getCodOficina():" + datosMigracionClienteDTO.getCodOficina(), nombreClase);
			cstmt.setString(6, datosMigracionClienteDTO.getCodOficina());
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);

			cstmt.execute();

			codError = cstmt.getString(7);
			System.out.println("codError: "+codError);
			msgError = cstmt.getString(8);
			numEvento = cstmt.getInt(9);

			resultado.setCodigoError(codError);
			resultado.setMensajeError(msgError);
			resultado.setNumeroEvento(numEvento);
			
			if(codError.equals("0")){
				resultado.setResultadoBase(1);
			} 
			else 
			{
				resultado.setResultadoBase(0);
			}


		} catch (Exception e) {
			e.printStackTrace();

			throw new GeneralException("ERR." + codError,new Integer(codError).intValue(),"Ocurrió un error al verificar los datos existentes");

		}  finally {

			try {
				if (!conn.isClosed()) {
					cstmt.close();
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}

		}
		logger.info("estadoDatosExistentes: fin", nombreClase);
		return resultado;
	}
}
