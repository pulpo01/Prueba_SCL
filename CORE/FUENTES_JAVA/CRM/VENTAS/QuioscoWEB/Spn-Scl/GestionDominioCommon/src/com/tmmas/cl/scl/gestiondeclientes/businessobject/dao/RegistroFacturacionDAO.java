/**
 * Copyright © 2007 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 12/04/2007     H&eacute;ctor Hermosilla      					Versión Inicial
 */

package com.tmmas.cl.scl.gestiondeclientes.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Category;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ClienteDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.MensajeDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RegistroFacturacionDTO;
import com.tmmas.cl.scl.gestiondeclietnes.businessobject.helper.Global;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ImpuestosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosEjecucionFacturacionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ProcesoDTO;

public class RegistroFacturacionDAO extends ConnectionDAO{

	private Logger  logger = Logger.getLogger(this.getClass());
	Global global = Global.getInstance();
	
	
	private Connection getConection() throws GeneralException
	{
		Connection conn = null;
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
		} catch (Exception e1) {
			conn = null;
			logger.error(" No se pudo obtener una conexión ", e1);
			throw new GeneralException("No se pudo obtener una conexión", e1);
		}
		
		return conn;
	}
	
	
	
	private String getSQLPackage(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
        for (int n = 1; n <= paramCount; n++) {
            sb.append("?");
            if (n < paramCount) sb.append(",");
        }
        return sb.append(")}").toString();
	
	}
	
	/**
	 * Obtiene el codigo de Promedio facturado, según el monto promedio facturado por el cliente
	 * @param entrada
	 * @return resultado
	 * @throws GeneralException
	 */
		
	public RegistroFacturacionDTO getCodigoPromedioFacturado(RegistroFacturacionDTO entrada) throws GeneralException{
		RegistroFacturacionDTO resultado = new RegistroFacturacionDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:getCodigoPromedioFacturado");
			
			//INI-01 (AL) String call = getSQLPackage("VE_servicios_venta_PG","VE_obtiene_codpromedio_fact_PR",5);
			String call = getSQLPackage("VE_servicios_venta_quiosco_PG","VE_obtiene_codpromedio_fact_PR",5);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setFloat(1,entrada.getValorPromedio());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.execute();
			
			codError=cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento=cstmt.getInt(5);
			
			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");

			if (codError==0)
				resultado.setCodigoPromedio(cstmt.getInt(2));
			else{
				logger.error("Ocurrió un error al obtener el codigo de promedio facturados");
				throw new GeneralException(
				"Ocurrió un error al obtener el codigo de promedio facturados", String
				.valueOf(codError), numEvento, msgError);				
			}
		
		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener el codigo de promedio facturados",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
		} finally {
				logger.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				logger.debug("SQLException", e);
		  }
		}

		logger.debug("Fin:getCodigoPromedioFacturado");

		return resultado;
	}//fin getCodigoPromedioFacturado
	
	/**
	 * Obtiene el codigo ciclo de facturación, en base al codigo ciclo del cliente.
	 * @param cliente
	 * @return resultado
	 * @throws GeneralException
	 */

	public RegistroFacturacionDTO getCodigoCicloFacturacion(ClienteDTO cliente) throws GeneralException{
		RegistroFacturacionDTO resultado = new RegistroFacturacionDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:getCodigoCicloFacturacion");
			
			//INI-01 (AL) String call = getSQLPackage("VE_servicios_venta_PG","VE_consulta_ciclo_fact_PR",5);
			String call = getSQLPackage("VE_servicios_venta_quiosco_PG","VE_consulta_ciclo_fact_PR",5);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			
			cstmt.setInt(1,cliente.getCodigoCiclo());
			logger.debug("[getCodigoCicloFacturacion] CodigoCicloCliente: " + cliente.getCodigoCiclo());
			logger.debug("[getCodigoCicloFacturacion] CodigoCliente: " + cliente.getCodigoCliente());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.execute();
			
			codError=cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento=cstmt.getInt(5);
			
			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");
			
			if (codError==0)
				resultado.setCodigoCicloFacturacion(cstmt.getInt(2));
			else{
				logger.error("Ocurrió un error al obtener el codigo ciclo de facturados");
				throw new GeneralException(
				"Ocurrió un error al obtener el codigo ciclo de facturados", String
				.valueOf(codError), numEvento, msgError);
			}
			
			logger.debug("CodigoCicloFacturacion : " + cstmt.getInt(2));
		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener el codigo ciclo de facturación",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
		} finally {
				logger.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				logger.debug("SQLException", e);
		  }
		}

		logger.debug("Fin:getCodigoCicloFacturacion");
		return resultado;
	}//fin getCodigoCicloFacturacion
	
	
	/**
	 *Ejecuta prebilling
	 * @param entrada
	 * @return resultado
	 * @throws GeneralException
	 */

	public void ejecutaPrebilling(RegistroFacturacionDTO entrada) throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:ejecutaPrebilling");
			
			//INI-01 (AL) String call = getSQLPackage("VE_intermediario_PG","VE_ejecuta_prebilling_PR",12);
			String call = getSQLPackage("VE_intermediario_Quiosco_PG","VE_ejecuta_prebilling_PR",12);
			
			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,entrada.getSecuenciaTransacabo());
			logger.debug("getSecuenciaTransacabo: [" + entrada.getSecuenciaTransacabo() + "]");
			cstmt.setString(2,entrada.getActuacionPrebilling());
			logger.debug("getActuacionPrebilling: [" + entrada.getActuacionPrebilling() + "]");
			cstmt.setString(3,entrada.getProductoGeneral());
			logger.debug("getProductoGeneral: [" + entrada.getProductoGeneral() + "]");
			cstmt.setString(4,entrada.getCodigoCliente());
			logger.debug("getCodigoCliente: [" + entrada.getCodigoCliente() + "]");
			cstmt.setString(5,entrada.getNumeroVenta());
			logger.debug("getNumeroVenta: [" + entrada.getNumeroVenta() + "]");
			cstmt.setString(6,entrada.getNumeroTransaccionVenta());
			logger.debug("getNumeroTransaccionVenta: [" + entrada.getNumeroTransaccionVenta() + "]");
			cstmt.setString(7,entrada.getNumeroProcesoFacturacion());
			logger.debug("getNumeroProcesoFacturacion: [" + entrada.getNumeroProcesoFacturacion() + "]");
			cstmt.setString(8,entrada.getModoGeneracion());
			logger.debug("getModoGeneracion: [" + entrada.getModoGeneracion() + "]");
			cstmt.setString(9,entrada.getCategoriaTributaria());
			logger.debug("getCategoriaTributaria: [" + entrada.getCategoriaTributaria() + "]");
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(12, java.sql.Types.NUMERIC);
			cstmt.execute();
			
			codError=cstmt.getInt(10);
			msgError = cstmt.getString(11);
			numEvento=cstmt.getInt(12);
			
			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");
			
			if (codError != 0){
				logger.error("Ocurrió un error al ejecutar el prebilling");
				throw new GeneralException(
				"Ocurrió un error al ejecutar el prebilling", String
				.valueOf(codError), numEvento, msgError);
			}
			
		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			logger.error("Ocurrió un error al ejecutar el prebilling",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
		} finally {
				logger.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				logger.debug("SQLException", e);
		  }
		}

		logger.debug("Fin:ejecutaPrebilling");

	}//fin ejecutaPrebilling

	/**
	 * Obtiene secuencia de proceso de facturación
	 * @param parametroEntrada
	 * @return resultado
	 * @throws GeneralException
	 */
	
	public RegistroFacturacionDTO getSecuenciaProcesoFacturacion(RegistroFacturacionDTO parametroEntrada) throws GeneralException{
		RegistroFacturacionDTO resultado=new RegistroFacturacionDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:getSecuenciaProcesoFacturacion");
			
			//INI-01 (AL) String call = getSQLPackage("VE_intermediario_PG","VE_OBTIENE_SECUENCIA_PR",5);
			String call = getSQLPackage("VE_intermediario_Quiosco_PG","VE_OBTIENE_SECUENCIA_PR",5);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,parametroEntrada.getCodigoSecuencia());
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getSecuenciaProcesoFacturacion:execute");
			cstmt.execute();
			logger.debug("Fin:getSecuenciaProcesoFacturacion:execute");

			codError=cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento=cstmt.getInt(5);
			
			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");
			
			if (codError != 0){
				logger.error("Ocurrió un error al obtener secuencia del proceso de facturación");
				throw new GeneralException(
				"Ocurrió un error al obtener secuencia del proceso de facturación", String
				.valueOf(codError), numEvento, msgError);
			}
			else
				resultado.setNumeroProcesoFacturacion(cstmt.getString(2));
		
		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener la secuencia del proceso de facturación",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
		} finally {
				logger.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				logger.debug("SQLException", e);
		  }
		}

		logger.debug("Fin:getSecuenciaProcesoFacturacion");

		return resultado;
	}//fin getSecuenciaProcesoFacturacion
	
	
	/**
	 * Obtiene el modo de generación, utilizado para ejecutar el Prebilling
	 * @param registroFacturacion
	 * @return registroFacturacion
	 * @throws GeneralException
	 */

	public RegistroFacturacionDTO getModoGeneracion(RegistroFacturacionDTO registroFacturacion) throws GeneralException{
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:getModoGeneracion");
			
			//INI-01 (AL) String call = getSQLPackage("VE_servicios_venta_PG","VE_obtiene_modo_gener_fact_PR",13);
			String call = getSQLPackage("VE_servicios_venta_quiosco_PG","VE_obtiene_modo_gener_fact_PR",13);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,registroFacturacion.getCodigoOficina());
			logger.debug("[getModoGeneracion] getCodigoOficina: " +  registroFacturacion.getCodigoOficina());
			cstmt.setString(2,registroFacturacion.getCodigoTipoDocumento());
			logger.debug("[getModoGeneracion] getCodigoTipoDocumento: " + registroFacturacion.getCodigoTipoDocumento());
			cstmt.setString(3,registroFacturacion.getValorParametroFacturaGlobal());
			logger.debug("[getModoGeneracion] getValorParametroFacturaGlobal: " + registroFacturacion.getValorParametroFacturaGlobal());
			cstmt.setString(4,registroFacturacion.getValorParametroDocumentoGuia());
			logger.debug("[getModoGeneracion] getValorParametroDocumentoGuia: " + registroFacturacion.getValorParametroDocumentoGuia());
			cstmt.setString(5,registroFacturacion.getCodigoTipoFoliacion());
			logger.debug("[getModoGeneracion] getCodigoTipoFoliacion: " + registroFacturacion.getCodigoTipoFoliacion());
			cstmt.setString(6,registroFacturacion.getCodigoTipoMovimiento());
			logger.debug("[getModoGeneracion] getCategoriaTributaria: " + registroFacturacion.getCategoriaTributaria());
			cstmt.setString(7,registroFacturacion.getCategoriaTributaria());
			logger.debug("[getModoGeneracion] getValorParametroFlagCentroFact: " + registroFacturacion.getValorParametroFlagCentroFact());
			cstmt.setString(8,registroFacturacion.getValorParametroFlagCentroFact());
			logger.debug("[getModoGeneracion] getModalidadVenta: " + registroFacturacion.getModalidadVenta());
			cstmt.setString(9,registroFacturacion.getModalidadVenta());
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(13, java.sql.Types.NUMERIC);
			cstmt.execute();
			
			codError=cstmt.getInt(11);
			msgError = cstmt.getString(12);
			numEvento=cstmt.getInt(13);
			
			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");

			if (codError==0)
				registroFacturacion.setModoGeneracion(cstmt.getString(10));
			else{
				logger.error("Ocurrió un error al obtener el modo de generación");
				throw new GeneralException(
				"Ocurrió un error al obtener el modo de generación", String
				.valueOf(codError), numEvento, msgError);
			}
				
			logger.debug("CodigoCicloFacturacion : " + cstmt.getString(10));
		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener el modo de generación",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
		} finally {
				logger.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				logger.debug("SQLException", e);
		  }
		}

		logger.debug("Fin:getModoGeneracion");

		return registroFacturacion;
	}//fin getModoGeneracion
	
	  /**
	 * Obtiene Presupuesto
	 * @param parametroEntrada
	 * @return resultado
	 * @throws GeneralException
	 */
	
	public ImpuestosDTO getDatosPresupuesto(ImpuestosDTO parametroEntrada) throws GeneralException{
		ImpuestosDTO resultado=new ImpuestosDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:getDatosPresupuesto");
			
			//INI-01 (AL) String call = getSQLPackage("VE_intermediario_PG","VE_ObtienePresupuesto_PR",7);
			String call = getSQLPackage("VE_intermediario_Quiosco_PG","VE_ObtienePresupuesto_PR",7);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,parametroEntrada.getNumeroProceso());
			logger.debug("parametroEntrada.getNumeroProceso(): " + parametroEntrada.getNumeroProceso());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getDatosPresupuesto:execute");
			cstmt.execute();
			logger.debug("Fin:getDatosPresupuesto:execute");

			codError=cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento=cstmt.getInt(7);
			
			logger.debug("codError[" + codError + "]");
			logger.debug("msgError[" + msgError + "]");
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0){
				logger.error("Ocurrió un error al obtener el presupuesto");
				throw new GeneralException(
				"Ocurrió un error al obtener el presupuesto", String
				.valueOf(codError), numEvento, msgError);
			}
			else{
				resultado.setNumeroProceso(parametroEntrada.getNumeroProceso());
				resultado.setTotalCargos(cstmt.getFloat(2));
				resultado.setTotalDescuentos(cstmt.getFloat(3));
				resultado.setTotalImpuestos(cstmt.getFloat(4));
			}
		
		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener el presupuesto",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
		} finally {
				logger.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				logger.debug("SQLException", e);
		  }
		}

		logger.debug("Fin:getDatosPresupuesto");

		return resultado;
	}//fin getDatosPresupuesto
	
	
	public ProcesoDTO actualizaFacturacion(RegistroFacturacionDTO parametroEntrada) throws GeneralException{
		ProcesoDTO resultado=null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:actualizaFacturacion");
			
			//INI-01 (AL) String call = getSQLPackage("VE_SERVICIOS_VENTA_PG","VE_ACTUALIZA_FACTURACION_PR",13);
			String call = getSQLPackage("VE_SERVICIOS_VENTA_QUIOSCO_PG","VE_ACTUALIZA_FACTURACION_PR",13);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			logger.debug("Estado documento" + parametroEntrada.getEstadoDocumento());
			cstmt.setString(1,parametroEntrada.getEstadoDocumento());
			logger.debug("getEstadoProceso" + parametroEntrada.getEstadoProceso());
			cstmt.setString(2,parametroEntrada.getEstadoProceso());
			cstmt.setString(3,parametroEntrada.getCategoriaTributaria());
			cstmt.setString(4,parametroEntrada.getNumeroFolio());
			cstmt.setString(5,parametroEntrada.getPrefijoPlaza());
			logger.debug("getFechaVencimiento" + parametroEntrada.getFechaVencimiento());
			cstmt.setString(6,parametroEntrada.getFechaVencimiento());
			cstmt.setString(7,parametroEntrada.getNombreUsuarioEliminacion());
			cstmt.setString(8,parametroEntrada.getCausalEliminacion());
			cstmt.setString(9,parametroEntrada.getNumeroProcesoFacturacion());
			cstmt.setString(10,parametroEntrada.getNumeroVenta());
			cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(13, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:actualizaFacturacion:execute");
			cstmt.execute();
			logger.debug("Fin:actualizaFacturacion:execute");

			codError=cstmt.getInt(11);
			msgError = cstmt.getString(12);
			numEvento=cstmt.getInt(13);

			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");
			
			if (codError != 0){
				resultado = new ProcesoDTO();
				resultado.setCodigoError(codError);
				resultado.setEvento(numEvento);
			}
			
		} catch (Exception e) {
			logger.error("Ocurrió un error al actualizar la facturación",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
		} finally {
				logger.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				logger.debug("SQLException", e);
		  }
		}

		logger.debug("Fin:actualizaFacturacion");

		return resultado;
	}//fin actualizaFacturacion
	
	  /**
	 * Obtiene Detalle Presupuesto
	 * @param parametroEntrada
	 * @return resultado
	 * @throws GeneralException
	 */
	
	public ImpuestosDTO[] getDetallePresupuesto(ImpuestosDTO parametroEntrada) throws GeneralException{
		ImpuestosDTO[] resultado=null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:getDetallePresupuesto");
			
			String call = getSQLPackage("FA_Servicios_Facturacion_PG","FA_con_presupuesto_PR",5);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,parametroEntrada.getNumeroProceso());
			logger.debug("parametroEntrada.getNumeroProceso(): " + parametroEntrada.getNumeroProceso());
			
			cstmt.registerOutParameter(2, OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getDetallePresupuesto:execute");
			cstmt.execute();
			logger.debug("Fin:getDetallePresupuesto:execute");

			codError=cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento=cstmt.getInt(5);
			
			logger.debug("codError[" + codError + "]");
			logger.debug("msgError[" + msgError + "]");
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0){
				logger.error("Ocurrió un error al obtener el detalle del presupuesto");
				throw new GeneralException(
				"Ocurrió un error al obtener el detalle del presupuesto", String
				.valueOf(codError), numEvento, msgError);
			}
			else{
				logger.debug("Llenado detalle presupuesto");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(2);
				while (rs.next()) {
					ImpuestosDTO impuestosDTO = new ImpuestosDTO();
					impuestosDTO.setCodigoConcepto(rs.getInt(1)); //concepto
					impuestosDTO.setTotalCargos(rs.getFloat(2));  //importe base
					impuestosDTO.setTotalImpuestos(rs.getFloat(3)); //impuesto
					impuestosDTO.setTotalDescuentos(rs.getFloat(4)); //descuento
					impuestosDTO.setTotal(rs.getFloat(5)); // importe total
					lista.add(impuestosDTO);
				}
				rs.close();
				resultado =(ImpuestosDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), ImpuestosDTO.class);
				
				logger.debug("Fin llenado detalle presupuesto");
			}
		
		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener el detalle del presupuesto",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
		} finally {
		 	if (logger.isDebugEnabled()) 
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}

		logger.debug("Fin:getDetallePresupuesto");

		return resultado;
	}//fin getDetallePresupuesto

	/**
	 * Obtiene Detalle Presupuesto por concepto facturable
	 * @param parametroEntrada
	 * @return resultado
	 * @throws GeneralException
	 */

	public ImpuestosDTO[] getDetallePresupuestoporConcepto(ImpuestosDTO parametroEntrada) throws GeneralException{
		ImpuestosDTO[] resultado=null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:getDetallePresupuestoporConcepto");
			
			//INI-01 (AL) String call = getSQLPackage("FA_Servicios_Facturacion_PG","FA_det_concepto_presup_PR",6);
			String call = getSQLPackage("FA_SERVICIOS_FACT_QUIOSCO_PG","FA_det_concepto_presup_PR",6);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,parametroEntrada.getNumeroProceso());
			logger.debug("parametroEntrada.getNumeroProceso(): " + parametroEntrada.getNumeroProceso());
			cstmt.setInt(2,parametroEntrada.getCodigoConcepto());
			logger.debug("parametroEntrada.getCodigoConcepto(): " + parametroEntrada.getCodigoConcepto());
			cstmt.registerOutParameter(3, OracleTypes.CURSOR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getDetallePresupuesto:execute");
			cstmt.execute();
			logger.debug("Fin:getDetallePresupuesto:execute");

			codError=cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento=cstmt.getInt(6);
			
			logger.debug("codError[" + codError + "]");
			logger.debug("msgError[" + msgError + "]");
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0){
				logger.error("Ocurrió un error al obtener el detalle del presupuesto por concepto");
				throw new GeneralException(
				"Ocurrió un error al obtener el detalle del presupuesto por concepto", String
				.valueOf(codError), numEvento, msgError);
			}
			else{
				logger.debug("Llenado detalle presupuesto");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(3);
				while (rs.next()) {
					ImpuestosDTO impuestosDTO = new ImpuestosDTO();
					impuestosDTO.setTotalCargos(rs.getFloat(1));
					impuestosDTO.setTotalImpuestos(rs.getFloat(2));
					impuestosDTO.setTotalDescuentos(rs.getFloat(3));
					lista.add(impuestosDTO);
				}
				resultado =(ImpuestosDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), ImpuestosDTO.class);
				
				logger.debug("Fin llenado detalle presupuesto");
			}
		
		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener el detalle del presupuesto por concepto");
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
		} finally {
				logger.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				logger.debug("SQLException", e);
		  }
		}

		logger.debug("Fin:getDetallePresupuestoporConcepto");

		return resultado;
	}//fin getDetallePresupuesto

	/**
	 * Obtiene el valor del parametro que indica si se consume folio
	 * @param N/A
	 * @return resultado
	 * @throws GeneralException
	 */
	public RegistroFacturacionDTO getConsumeFolio() 
	throws GeneralException{
		RegistroFacturacionDTO resultado = new RegistroFacturacionDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:getConsumeFolio");
			
			//INI-01 (AL) String call = getSQLPackage("VE_intermediario_PG","VE_getConsumeFolio_PR",4);
			String call = getSQLPackage("VE_intermediario_Quiosco_PG","VE_getConsumeFolio_PR",4);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getConsumeFolio:execute");
			cstmt.execute();
			logger.debug("Inicio:getConsumeFolio:execute");
			
			codError=cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento=cstmt.getInt(4);
			
			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");

			if (codError==0)
				resultado.setValorParametroConsumeFolio(cstmt.getString(1));
			else{
				logger.error("Ocurrió un error al obtener valor parametro que indica si se consume folio");
				throw new GeneralException(
				"Ocurrió un error al obtener valor parametro que indica si se consume folio", String
				.valueOf(codError), numEvento, msgError);
			}
		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener valor parametro que indica si se consume folio",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
		} finally {
				logger.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				logger.debug("SQLException", e);
		  }
		}
		logger.debug("Fin:getConsumeFolio");
		return resultado;
	}//fin getConsumeFolio

	/**
	 * Obtiene Detalle Presupuesto por concepto facturable
	 * @param parametroEntrada
	 * @return resultado
	 * @throws GeneralException
	 */
	public RegistroFacturacionDTO[] getListCiclosPostPago(RegistroFacturacionDTO entrada) 
	throws GeneralException{
		RegistroFacturacionDTO[] resultado=null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:getListCiclosPostPago");
			
			//INI-01 (AL) String call = getSQLPackage("FA_Servicios_Facturacion_PG","FA_getListCiclosPostPago_PR",5);
			String call = getSQLPackage("FA_SERVICIOS_FACT_QUIOSCO_PG","FA_getListCiclosPostPago_PR",5);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setInt(1,entrada.getCicloPrePago());
			cstmt.registerOutParameter(2, OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getListCiclosPostPago:execute");
			cstmt.execute();
			logger.debug("Fin:getListCiclosPostPago:execute");

			codError=cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento=cstmt.getInt(5);
			
			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");
			
			if (codError != 0){
				logger.error("Ocurrió un error al obtener ciclos de facturacion postpago");
				throw new GeneralException(
				"Ocurrió un error al obtener ciclos de facturacion postpago", String
				.valueOf(codError), numEvento, msgError);
			}
			else{
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(2);
				while (rs.next()) {
					RegistroFacturacionDTO registroDTO = new RegistroFacturacionDTO();
					registroDTO.setCodigoCicloFacturacion(rs.getInt(1));
					registroDTO.setDescripcionCiclo(rs.getString(2));
					lista.add(registroDTO);
				}
				resultado =(RegistroFacturacionDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), RegistroFacturacionDTO.class);
			}
		
		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener ciclos de facturacion postpago");
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
		} finally {
				logger.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				logger.debug("SQLException", e);
		  }
		}
		logger.debug("Fin:getListCiclosPostPago");
		return resultado;
	}//fin getListCiclosPostPago
	
	/**
	 * Obtiene codigo de despacho
	 * @param N/A
	 * @return resultado
	 * @throws GeneralException
	 */
	public RegistroFacturacionDTO getCodigoDespacho() 
	throws GeneralException{
		RegistroFacturacionDTO resultado = new RegistroFacturacionDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:getCodigoDespacho");
			
			//INI-01 (AL) String call = getSQLPackage("FA_Servicios_Facturacion_PG","FA_getCodigoDespacho_PR",4);
			String call = getSQLPackage("FA_SERVICIOS_FACT_QUIOSCO_PG","FA_getCodigoDespacho_PR",4);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getCodigoDespacho:execute");
			cstmt.execute();
			logger.debug("Inicio:getCodigoDespacho:execute");
			
			codError=cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento=cstmt.getInt(4);
			
			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");

			if (codError==0)
				resultado.setCodigoDespacho(cstmt.getString(1));
			else{
				logger.error("Ocurrió un error al obtener codigo de despacho");
				throw new GeneralException(
				"Ocurrió un error al obtener codigo de despacho", String
				.valueOf(codError), numEvento, msgError);
			}
		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener codigo de despacho",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
		} finally {
				logger.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				logger.debug("SQLException", e);
		  }
		}
		logger.debug("Fin:getCodigoDespacho");
		return resultado;
	}//fin getCodigoDespacho

	/**
	 * Obtiene ciclo de facturacion calendario mas inmediato
	 * @param N/A
	 * @return resultado
	 * @throws GeneralException
	 */
	public RegistroFacturacionDTO getCicloFacturacion() 
	throws GeneralException{
		RegistroFacturacionDTO resultado = new RegistroFacturacionDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:getCicloFacturacion");
			
			//INI-01 (AL) String call = getSQLPackage("FA_Servicios_Facturacion_PG","FA_getCicloFacturacion_PR",28);
			String call = getSQLPackage("FA_SERVICIOS_FACT_QUIOSCO_PG","FA_getCicloFacturacion_PR",28);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(15, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(18, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(19, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(20, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(21, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(22, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(23, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(24, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(25, java.sql.Types.VARCHAR);
			
			cstmt.registerOutParameter(26, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(27, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(28, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getCicloFacturacion:execute");
			cstmt.execute();
			logger.debug("Inicio:getCicloFacturacion:execute");
			
			codError=cstmt.getInt(26);
			msgError = cstmt.getString(27);
			numEvento=cstmt.getInt(28);
			
			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");
			
			if (codError==0){
				resultado.setCodigoCicloFacturacion(cstmt.getInt(1));
				resultado.setAgno(cstmt.getString(2)); 
				resultado.setCodigoCiclo(cstmt.getString(3));
				resultado.setFechaVencimiento(cstmt.getString(4));
				resultado.setFechaEmision(cstmt.getString(5));
				resultado.setFechaCaducida(cstmt.getString(6)); 
				resultado.setFechaProxvenc(cstmt.getString(7));
				resultado.setFechaDesdellam(cstmt.getString(8)); 
				resultado.setFechaHastallam(cstmt.getString(9)); 
				resultado.setDiaPeriodo(cstmt.getString(10)); 
				resultado.setFechaDesdecfijos(cstmt.getString(11)); 
				resultado.setFechaHastacfijos(cstmt.getString(12));
				resultado.setFechaDesdeocargos(cstmt.getString(13)); 
				resultado.setFechaHastaocargos(cstmt.getString(14)); 
				resultado.setFechaDesderoa(cstmt.getString(15)); 
				resultado.setFechaHastaroa(cstmt.getString(16)); 
				resultado.setIndicadorFacturacion(cstmt.getString(17));
				resultado.setDireccionLogs(cstmt.getString(18)); 
				resultado.setDireccionSpool(cstmt.getString(19));
				resultado.setDescripcionLeyen1(cstmt.getString(20)); 
				resultado.setDescripcionLeyen2(cstmt.getString(21)); 
				resultado.setDescripcionLeyen3(cstmt.getString(22));
				resultado.setDescripcionLeyen4(cstmt.getString(23));
				resultado.setDescripcionLeyen5(cstmt.getString(24)); 
				resultado.setIndicadorTasador(cstmt.getString(25));	
			}else{
				logger.error("Ocurrió un error al obtener ciclo de facturacion calendario mas inmediato");
				throw new GeneralException(
				"Ocurrió un error al obtener ciclo de facturacion calendario mas inmediato", String
				.valueOf(codError), numEvento, msgError);
			}
		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener ciclo de facturacion calendario mas inmediato",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
		} finally {
				logger.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				logger.debug("SQLException", e);
		  }
		}
		logger.debug("Fin:getCicloFacturacion");
		return resultado;
	}//fin getCicloFacturacion
	
	/**
	 * Verifica si ciclo corresponde a un plan freedom
	 * @param entrada
	 * @return resultado
	 * @throws GeneralException
	 */
	public RegistroFacturacionDTO esCicloFredom(RegistroFacturacionDTO registroFacturacionDTO) 
	throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:esCicloFredom");

			//INI-01 (AL) String call = getSQLPackage("VE_alta_cliente_PG","VE_esCicloFreedom_PR",5);
			String call = getSQLPackage("VE_alta_cliente_Quiosco_PG","VE_esCicloFreedom_PR",5);
			logger.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);

			cstmt.setString(1,registroFacturacionDTO.getCodigoCiclo());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:esCicloFredom:execute");
			cstmt.execute();
			logger.debug("Fin:esCicloFredom:execute");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				registroFacturacionDTO.setCicloFreedom(false);
			}else
				registroFacturacionDTO.setCicloFreedom(cstmt.getInt(2)==1?true:false);
			
		} catch (Exception e) {
			logger.error("Ocurrió un error al verificar si ciclo corresponde a un plan freedom",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
		} finally {
		 	if (logger.isDebugEnabled()) 
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:esCicloFredom()");
		return registroFacturacionDTO;
	}//fin esCicloFredom
	
	/**
	 * Obtiene dias para realizar prorrateo de importe de plan tarifarios 
	 * tipo hibrido en icc_movimiento
	 * @param entrada
	 * @return resultado
	 * @throws GeneralException
	 */
	
	public RegistroFacturacionDTO getDiasProrrateo(RegistroFacturacionDTO registroFacturacionDTO)
	throws GeneralException{
		RegistroFacturacionDTO resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:getDiasProrrateo");
			
			//INI-01 (AL) String call = getSQLPackage("FA_Servicios_Facturacion_PG","FA_getDiasProrrateo_PR",7);
			String call = getSQLPackage("FA_SERVICIOS_FACT_QUIOSCO_PG","FA_getDiasProrrateo_PR",7);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			
			cstmt.setInt(1,registroFacturacionDTO.getCodigoCicloFacturacion());
			logger.debug("[getDiasProrrateo] CodigoCicloCliente: " + registroFacturacionDTO.getCodigoCicloFacturacion());
			cstmt.setString(2,registroFacturacionDTO.getFormatoFecha());
			logger.debug("[getDiasProrrateo] formato Fecha: " + registroFacturacionDTO.getFormatoFecha());
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC); // SV_diasProrrateo
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC); // SV_cantDias
			
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			cstmt.execute();
			
			codError=cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento=cstmt.getInt(7);

			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");

			if (codError==0){
				resultado = new RegistroFacturacionDTO();
				resultado.setDiasProrrateo(cstmt.getInt(3));
				resultado.setDiasDiferencia(cstmt.getInt(4));
			}else{
				logger.error("Ocurrió un error al obtener los dias de prorrateo");
				throw new GeneralException(
					"Ocurrió un error al obtener los dias de prorrateo", String
					.valueOf(codError), numEvento, msgError);
				}
			} catch (GeneralException e) {
				throw e;
			} catch (Exception e) {
			logger.error("Ocurrió un error al obtener los dias de prorrateo",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
		} finally {
				logger.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				logger.debug("SQLException", e);
		  }
		}

		logger.debug("Fin:getDiasProrrateo");

		return resultado;
	}//fin getDiasProrrateo
	
	
	/**
	 * Aplica impuesto al importe del plan tarifario informado
	 * (solo planes tipo hibridos)
	 * @param entrada
	 * @return resultado
	 * @throws GeneralException
	 */
	
	public RegistroFacturacionDTO aplicaImpuestoImporte(RegistroFacturacionDTO registroFacturacionDTO)
	throws GeneralException{
		RegistroFacturacionDTO resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:aplicaImpuestoImporte");
			
			//INI-01 (AL) String call = getSQLPackage("FA_Servicios_Facturacion_PG","FA_getImpuesto_PR",7);
			String call = getSQLPackage("FA_SERVICIOS_FACT_QUIOSCO_PG","FA_getImpuesto_PR",7);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,registroFacturacionDTO.getCodigoCliente());
			logger.debug("[aplicaImpuestoImporte] CodigoCliente: " + registroFacturacionDTO.getCodigoCliente());
			cstmt.setString(2,registroFacturacionDTO.getCodigoOficina());
			logger.debug("[aplicaImpuestoImporte] oficina: " + registroFacturacionDTO.getCodigoOficina());
			cstmt.setFloat(3,registroFacturacionDTO.getImportePlan());
			logger.debug("[aplicaImpuestoImporte] getImportePlan: " + registroFacturacionDTO.getImportePlan());
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC); // SV_importeTotal
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			cstmt.execute();
			
			codError=cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento=cstmt.getInt(7);
			
			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");
			
			if (codError==0){
				resultado = new RegistroFacturacionDTO();
				resultado.setImporteTotal(cstmt.getFloat(4));
			}else{
				logger.error("Ocurrió un error al aplicar impuesto");
				throw new GeneralException(
					"Ocurrió un error al aplicar impuesto", String
					.valueOf(codError), numEvento, msgError);
				}
		} catch (GeneralException e) {
				throw e;
		} catch (Exception e) {
			logger.error("Ocurrió un error al aplicar impuesto",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
		} finally {
				logger.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				logger.debug("SQLException", e);
		  }
		}

		logger.debug("Fin:aplicaImpuestoImporte");

		return resultado;
	}//fin aplicaImpuestoImporte
	
	/**
	 * Guarda mensaje asociado a la facturacion
	 * @param entrada
	 * @return resultado
	 * @throws GeneralException
	 */	
	public void guardarMensaje(MensajeDTO mensaje)
		throws GeneralException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:guardarMensaje");
			
			//INI-01 (AL) String call = getSQLPackage("FA_Servicios_Facturacion_PG","FA_recibe_mensaje_PR",7);
			String call = getSQLPackage("FA_SERVICIOS_FACT_QUIOSCO_PG","FA_recibe_mensaje_PR",7);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			
			cstmt.setLong(1,mensaje.getNumeroProceso());
			logger.debug("[guardarMensaje] NumeroProceso: " + mensaje.getNumeroProceso());
			cstmt.setString(2,mensaje.getSiglaMensaje());
			logger.debug("[guardarMensaje] SiglaMensaje: " + mensaje.getSiglaMensaje());
			cstmt.setString(3,mensaje.getDescMensaje());
			logger.debug("[guardarMensaje] Desc mensaje: " + mensaje.getDescMensaje());
			cstmt.setString(4,mensaje.getUsuarioConectado());
			logger.debug("[guardarMensaje] Usuario conectado: " + mensaje.getUsuarioConectado());
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			cstmt.execute();
			
			codError=cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento=cstmt.getInt(7);
			
			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");
			
			if (codError != 0){
				logger.error("Ocurrió un error guardar el mensaje");
				throw new GeneralException(
					"Ocurrió un error guardar el mensaje", String
					.valueOf(codError), numEvento, msgError);
				}
		} catch (GeneralException e) {
				throw e;
		} catch (Exception e) {
			logger.error("Ocurrió un error guardar el mensaje",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
		} finally {
				logger.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				logger.debug("SQLException", e);
		  }
		}

		logger.debug("Fin:guardarMensaje");
	}//fin guardarMensaje
	
	/**
	 * Obtiene numero proceso facturacion
	 * @param entrada
	 * @return resultado
	 * @throws GeneralException
	 */	
	public ParametrosEjecucionFacturacionDTO obtieneNroProceso(Long numVenta)throws GeneralException
	{
		logger.debug("Inicio:obtieneNroProceso DAO");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		ParametrosEjecucionFacturacionDTO resultado = null;
		try {
			logger.debug("Inicio:1");
			//INI-01 (AL) String call = getSQLPackage("FA_Servicios_Facturacion_PG","FA_obtiene_NumProceso_PR",5);
			String call = getSQLPackage("FA_SERVICIOS_FACT_QUIOSCO_PG","FA_obtiene_NumProceso_PR",5);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			logger.debug("Inicio:2");
			cstmt.setLong(1,numVenta.longValue());
			logger.debug("[obtieneNroProceso] NumeroVenta: " + numVenta.longValue());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.execute();
			
			codError=cstmt.getInt(3);			
			msgError = cstmt.getString(4);
			numEvento=cstmt.getInt(5);
			
			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");
			
			if (codError==0){
				resultado = new ParametrosEjecucionFacturacionDTO();
				resultado.setNumeroProcesoFacturacion(String.valueOf(cstmt.getLong(2)));
			}else{
				logger.error("Ocurrió un error guardar el mensaje");
				throw new GeneralException(
					"Ocurrió un error guardar el mensaje", String
					.valueOf(codError), numEvento, msgError);
				}
		} catch (GeneralException e) {
				throw e;
		} catch (Exception e) {
			logger.error("Ocurrió un error guardar el mensaje",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
		} finally {
				logger.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				logger.debug("SQLException", e);
		  }
		}

		logger.debug("Fin:obtieneNroProceso");
		return resultado;
	}//fin guardarMensaje
	
}//fin class RegistroFacturacionDAO


