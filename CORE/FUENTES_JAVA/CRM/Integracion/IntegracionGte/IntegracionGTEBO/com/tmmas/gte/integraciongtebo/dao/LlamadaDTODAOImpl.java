/**
* Generated file - You can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/

package com.tmmas.gte.integraciongtebo.dao;



import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework20.util.ServiceLocator;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.gte.integraciongtebo.helper.Global;

public class LlamadaDTODAOImpl extends com.tmmas.cl.framework.base.ConnectionDAO implements LlamadaDTODAO{
	private CompositeConfiguration config;
	public static final String FORMATO_FECHA_ISO = "yyyyMMdd"; 
	private static Logger logger = Logger.getLogger(LlamadaDTODAOImpl.class);
	private Global global = Global.getInstance();
	private ServiceLocator  serviceLocator = ServiceLocator.getInstance();

	public LlamadaDTODAOImpl() {
		config = UtilProperty.getConfiguration("IntegracionGte.properties", "com/tmmas/gte/integraciongtebo/properties/IntegracionGTEBO.properties");
	}

	public String fechaDateTOfechaString(String formato,Date fecha){
        try {
    		SimpleDateFormat format = new SimpleDateFormat(formato);
    		return format.format(fecha);
           }
        catch (Exception e) {
             System.out.println(e.getMessage());
             System.out.println("Fecha incorrecta");
             return null;
       }
	} 	
	

	/**
	* Ingresa como parametros un LlamadaInDTO y despues devuelve un cursor con datos, este se setean los datos en LlamadaDTO y se genera una lista
	*/
	public com.tmmas.gte.integraciongtecommon.dto.LlamadoResponseDTO lstLlamadasNoFacturadas(com.tmmas.gte.integraciongtecommon.dto.LlamadaInDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("lstLlamadasNoFacturadas:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.LlamadoResponseDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.LlamadoResponseDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource1())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call TOL_CONSULTA_TRAFICO_PG.TOL_DETALLETRAF_CLIENTE_PR(?,?,?,?,?,?,?,?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setLong(1,inParam0.getCodCliente());
			logger.debug("codCliente[" + inParam0.getCodCliente() + "]");

			cstmt.setLong(2,inParam0.getNumAbonado());
			logger.debug("numAbonado[" + inParam0.getNumAbonado() + "]");

			cstmt.setString(3,inParam0.getNumCelular());
			logger.debug("numCelular[" + inParam0.getNumCelular() + "]");

			cstmt.setLong(4,inParam0.getCodCiclo());
			logger.debug("codCiclo[" + inParam0.getCodCiclo() + "]");

			cstmt.setString(5,inParam0.getFecTasa());
			logger.debug("fecTasa[" + inParam0.getFecTasa() + "]");

			cstmt.setString(6,inParam0.getFecDesde());
			logger.debug("fecDesde[" + inParam0.getFecDesde() + "]");

			cstmt.setString(7,inParam0.getFecHasta());
			logger.debug("fecHasta[" + inParam0.getFecHasta() + "]");

			cstmt.setLong(8,inParam0.getImpuesto());
			logger.debug("impuesto[" + inParam0.getImpuesto() + "]");

			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.LlamadaDTO outParam1 = new com.tmmas.gte.integraciongtecommon.dto.LlamadaDTO();
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
				com.tmmas.gte.integraciongtecommon.dto.LlamadaDTO dto9 = new com.tmmas.gte.integraciongtecommon.dto.LlamadaDTO();

				dto9.setFechaLlamada(rs.getString("Fecha_llamada"));
				logger.debug("fechaLlamada[" + dto9.getFechaLlamada() + "]");

				dto9.setHoraLlamada(rs.getString("hora_llamada"));
				logger.debug("horaLlamada[" + dto9.getHoraLlamada() + "]");

				dto9.setNumeroDestino(rs.getString("numero_destino"));
				logger.debug("numeroDestino[" + dto9.getNumeroDestino() + "]");

				dto9.setMtoLlamSinImp(rs.getLong("mto_fact_sin_impuesto"));
				logger.debug("mtoLlamSinImp[" + dto9.getMtoLlamSinImp() + "]");

				dto9.setMtoLlamConImp(rs.getLong("mto_fact_con_impuesto"));
				logger.debug("mtoLlamConImp[" + dto9.getMtoLlamConImp() + "]");

				dto9.setTipoLlamada(rs.getString("tipo_llamada"));
				logger.debug("tipoLlamada[" + dto9.getTipoLlamada() + "]");

				dto9.setDuración(rs.getLong("duracion"));
				logger.debug("duración[" + dto9.getDuración() + "]");

				dto9.setUnidad(rs.getString("unidad"));
				logger.debug("unidad[" + dto9.getUnidad() + "]");

				lista9.add(dto9);
			}
			logger.info("Recuperando cursor9:despues");
			rs.close();
			logger.info("Seteando respuesta de cursor9 en clase de salida....");
			outParam0.setLstListadoLlamados((com.tmmas.gte.integraciongtecommon.dto.LlamadaDTO[])
						com.tmmas.cl.framework.util.ArrayUtl.copiaArregloTipoEspecifico(lista9.toArray(),
												com.tmmas.gte.integraciongtecommon.dto.LlamadaDTO.class));

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

		logger.info("lstLlamadasNoFacturadas:end()");
		return outParam0;
	}

	
	/**
	* se ingresa el codigo de ciclo + las fechas (inicio y termino ), las fechas puede variar pueden ir hasta nulas o una de ella nula, de vuelve las fechas correspondiente al ciclo.
	*/
	public com.tmmas.gte.integraciongtecommon.dto.ConsLlamadaInternaDTO validacionFechasCicloFacturacion(com.tmmas.gte.integraciongtecommon.dto.ConsLlamadaInternaDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("validacionFechasCicloFacturacion:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.ConsLlamadaInternaDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.ConsLlamadaInternaDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call GE_INTEGRACION_PG.GE_VALIDA_FECHA_CICLO_PR(?,?,?,?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");

			cstmt.setLong(1,inParam0.getCicloFacturacion());
			logger.debug("cicloFacturacion[" + inParam0.getCicloFacturacion() + "]");

			cstmt.setString(2,inParam0.getFecDesde());
			logger.debug("fecDesde[" + inParam0.getFecDesde() + "]");

			cstmt.setString(3, inParam0.getFecHasta());
			logger.debug("fecHasta[" + inParam0.getFecHasta() + "]");

			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam1 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();

			logger.info("armar parametros de salida...");
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

			
			outParam0.setFecDesde(cstmt.getString(4));
			logger.debug("fecDesde[" + outParam0.getFecDesde() + "]");

			outParam0.setFecHasta(cstmt.getString(5));	
			logger.debug("fecHasta[" + outParam0.getFecHasta() + "]");

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

		logger.info("validacionFechasCicloFacturacion:end()");
		return outParam0;
	}
	
}