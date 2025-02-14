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

package com.tmmas.cl.scl.customerdomain.businessobject.dao;

import java.rmi.RemoteException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.DetalleInformePresupuestoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ImpuestosDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ProcesoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.ProductDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.ClienteDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.FaConceptoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.RegistroFacturacionDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.helper.Global;

public class RegistroFacturacionDAO extends ConnectionDAO{

	private static Category cat = Category.getInstance(RegistroFacturacionDAO.class);
	Global global = Global.getInstance();
	
	
	private Connection getConection() throws CustomerDomainException
	{
		Connection conn = null;
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
		} catch (Exception e1) {
			conn = null;
			cat.error(" No se pudo obtener una conexión ", e1);
			throw new CustomerDomainException("No se pudo obtener una conexión", e1);
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
	 * @throws CustomerDomainException
	 */
		
	public RegistroFacturacionDTO getCodigoPromedioFacturado(RegistroFacturacionDTO entrada) 
		throws CustomerDomainException
	{
		RegistroFacturacionDTO resultado = new RegistroFacturacionDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:getCodigoPromedioFacturado");
			
			String call = getSQLPackage("VE_servicios_venta_PG","VE_obtiene_codpromedio_fact_PR",5);

			cat.debug("sql[" + call + "]");

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
			cat.debug("msgError[" + msgError + "]");

			if (codError==0)
				resultado.setCodigoPromedio(cstmt.getInt(2));
		
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener el codigo de promedio facturados",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
				cat.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				cat.debug("SQLException", e);
		  }
		}

		cat.debug("Fin:getCodigoPromedioFacturado");

		return resultado;
	}//fin getCodigoPromedioFacturado
	
	/**
	 * Obtiene el codigo ciclo de facturación, en base al codigo ciclo del cliente.
	 * @param cliente
	 * @return resultado
	 * @throws CustomerDomainException
	 */

	public RegistroFacturacionDTO getCodigoCicloFacturacion(ClienteDTO cliente) 
		throws CustomerDomainException
	{
		RegistroFacturacionDTO resultado = new RegistroFacturacionDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:getCodigoCicloFacturacion");
			
			String call = getSQLPackage("VE_servicios_venta_PG","VE_consulta_ciclo_fact_PR",5);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			
			cstmt.setInt(1,cliente.getCodigoCiclo());
			cat.debug("[getCodigoCicloFacturacion] CodigoCicloCliente: " + cliente.getCodigoCiclo());
			cat.debug("[getCodigoCicloFacturacion] CodigoCliente: " + cliente.getCodigoCliente());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.execute();
			codError=cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento=cstmt.getInt(5);
			cat.debug("msgError[" + msgError + "]");
			if (codError==0)
				resultado.setCodigoCicloFacturacion(cstmt.getInt(2));
			else{
				throw new CustomerDomainException(String.valueOf(codError),
								numEvento, "Ocurrió un error al obtener el codigo ciclo de facturación");
			}
			cat.debug("CodigoCicloFacturacion : " + cstmt.getInt(2));
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener el codigo ciclo de facturación",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException ) throw (CustomerDomainException) e;
		} finally {
				cat.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				cat.debug("SQLException", e);
		  }
		}

		cat.debug("Fin:getCodigoCicloFacturacion");

		return resultado;
	}//fin getCodigoCicloFacturacion
	
	
	/**
	 *Ejecuta prebilling
	 * @param entrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */

	public void ejecutaPrebilling(RegistroFacturacionDTO entrada) 
		throws CustomerDomainException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {			
			cat.debug("Inicio:ejecutaPrebilling");
			
			String call = getSQLPackage("VE_intermediario_PG","VE_ejecuta_prebilling_PR",12);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,entrada.getSecuenciaTransacabo());
			cat.debug("getSecuenciaTransacabo: [" + entrada.getSecuenciaTransacabo() + "]");			
			cstmt.setString(2,entrada.getActuacionPrebilling());
			cat.debug("getActuacionPrebilling: [" + entrada.getActuacionPrebilling() + "]");			
			cstmt.setString(3,entrada.getProductoGeneral());
			cat.debug("getProductoGeneral: [" + entrada.getProductoGeneral() + "]");			
			cstmt.setString(4,entrada.getCodigoCliente());
			cat.debug("getCodigoCliente: [" + entrada.getCodigoCliente() + "]");			
			cstmt.setString(5,entrada.getNumeroVenta());
			cat.debug("getNumeroVenta: [" + entrada.getNumeroVenta() + "]");			
			cstmt.setString(6,entrada.getNumeroTransaccionVenta());
			cat.debug("getNumeroTransaccionVenta: [" + entrada.getNumeroTransaccionVenta() + "]");			
			cstmt.setString(7,entrada.getNumeroProcesoFacturacion());
			cat.debug("getNumeroProcesoFacturacion: [" + entrada.getNumeroProcesoFacturacion() + "]");			
			cstmt.setString(8,entrada.getModoGeneracion());
			cat.debug("getModoGeneracion: [" + entrada.getModoGeneracion() + "]");			
			cstmt.setString(9,entrada.getCategoriaTributaria());
			cat.debug("getCategoriaTributaria: [" + entrada.getCategoriaTributaria() + "]");			
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(12, java.sql.Types.NUMERIC);			
			cstmt.execute();			
			codError=cstmt.getInt(10);
			msgError = cstmt.getString(11);
			numEvento=cstmt.getInt(12);			
			
			cat.debug("msgError[" + msgError + "]");
			
		} catch (Exception e) {
			cat.error("Ocurrió un error al ejecutar el prebilling",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		} 
		finally {
		 	if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:ejecutaPrebilling");

	}//fin ejecutaPrebilling

	/**
	 * Obtiene secuencia de proceso de facturación
	 * @param parametroEntrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	
	public RegistroFacturacionDTO getSecuenciaProcesoFacturacion(RegistroFacturacionDTO parametroEntrada) 
		throws CustomerDomainException
	{
		RegistroFacturacionDTO resultado=new RegistroFacturacionDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:getSecuenciaProcesoFacturacion");
			
			String call = getSQLPackage("VE_intermediario_PG","VE_OBTIENE_SECUENCIA_PR",5);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,parametroEntrada.getCodigoSecuencia());
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getSecuenciaProcesoFacturacion:execute");
			cstmt.execute();
			cat.debug("Fin:getSecuenciaProcesoFacturacion:execute");

			codError=cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento=cstmt.getInt(5);
			cat.debug("msgError[" + msgError + "]");
			
			if (codError != 0){
				cat.error("Ocurrió un error al obtener secuencia del proceso de facturación");
				throw new CustomerDomainException(
				"Ocurrió un error al obtener secuencia transacabo", String
				.valueOf(codError), numEvento, msgError);
			}
			else
				resultado.setNumeroProcesoFacturacion(cstmt.getString(2));
		
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener la secuencia del proceso de facturación",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
				cat.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				cat.debug("SQLException", e);
		  }
		}

		cat.debug("Fin:getSecuenciaProcesoFacturacion");

		return resultado;
	}//fin getSecuenciaProcesoFacturacion
	
	
	/**
	 * Obtiene el modo de generación, utilizado para ejecutar el Prebilling
	 * @param registroFacturacion
	 * @return registroFacturacion
	 * @throws CustomerDomainException
	 */

	public RegistroFacturacionDTO getModoGeneracion(RegistroFacturacionDTO registroFacturacion) 
		throws CustomerDomainException
	{	
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:getModoGeneracion");
			
			String call = getSQLPackage("VE_servicios_venta_PG","VE_obtiene_modo_gener_fact_PR",13);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,registroFacturacion.getCodigoOficina());
			cat.debug("[getModoGeneracion] getCodigoOficina: " +  registroFacturacion.getCodigoOficina());			
			cstmt.setString(2,registroFacturacion.getCodigoTipoDocumento());
			cat.debug("[getModoGeneracion] getCodigoTipoDocumento: " + registroFacturacion.getCodigoTipoDocumento());			
			cstmt.setString(3,registroFacturacion.getValorParametroFacturaGlobal());
			cat.debug("[getModoGeneracion] getValorParametroFacturaGlobal: " + registroFacturacion.getValorParametroFacturaGlobal());			
			cstmt.setString(4,registroFacturacion.getValorParametroDocumentoGuia());
			cat.debug("[getModoGeneracion] getValorParametroDocumentoGuia: " + registroFacturacion.getValorParametroDocumentoGuia());			
			cstmt.setString(5,registroFacturacion.getCodigoTipoFoliacion());
			cat.debug("[getModoGeneracion] getCodigoTipoFoliacion: " + registroFacturacion.getCodigoTipoFoliacion());			
			cstmt.setString(6,registroFacturacion.getCodigoTipoMovimiento());
			cat.debug("[getModoGeneracion] getCategoriaTributaria: " + registroFacturacion.getCategoriaTributaria());			
			cstmt.setString(7,registroFacturacion.getCategoriaTributaria());
			cat.debug("[getModoGeneracion] getValorParametroFlagCentroFact: " + registroFacturacion.getValorParametroFlagCentroFact());			
			cstmt.setString(8,registroFacturacion.getValorParametroFlagCentroFact());
			cat.debug("[getModoGeneracion] getModalidadVenta: " + registroFacturacion.getModalidadVenta());			
			cstmt.setString(9,registroFacturacion.getModalidadVenta());
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(13, java.sql.Types.NUMERIC);			
			cstmt.execute();			
			codError=cstmt.getInt(11);
			cat.debug("codError: " + codError);
			msgError = cstmt.getString(12);
			cat.debug("msgError: " + msgError);
			numEvento=cstmt.getInt(13);
			cat.debug("numEvento: " + numEvento);

			if (codError==0)
				registroFacturacion.setModoGeneracion(cstmt.getString(10));
			else{
				cat.error("Ocurrió un error al obtener el modo de generación");
				throw new CustomerDomainException(
				"Ocurrió un error al obtener el modo de generación", String
				.valueOf(codError), numEvento, msgError);
			}
				
			cat.debug("CodigoCicloFacturacion : " + cstmt.getString(10));
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener el modo de generación",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
				cat.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				cat.debug("SQLException", e);
		  }
		}

		cat.debug("Fin:getModoGeneracion");

		return registroFacturacion;
	}//fin getModoGeneracion
	
	  /**
	 * Obtiene Presupuesto
	 * @param parametroEntrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	
	public ImpuestosDTO getDatosPresupuesto(ImpuestosDTO parametroEntrada)
		throws CustomerDomainException
	{
		ImpuestosDTO resultado=new ImpuestosDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		ResultSet rs = null;
		try {
			cat.debug("Inicio:getDatosPresupuesto");
			
			String call = getSQLPackage("VE_intermediario_PG","VE_ObtienePresupuestoDesc_PR",8);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,parametroEntrada.getNumeroProceso());
			cat.debug("parametroEntrada.getNumeroProceso(): " + parametroEntrada.getNumeroProceso());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC); //total cargos
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC); //total impuestos
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC); //total descuentos
			cstmt.registerOutParameter(5,OracleTypes.CURSOR);
			
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getDatosPresupuesto:execute");
			cstmt.execute();
			cat.debug("Fin:getDatosPresupuesto:execute");

			codError=cstmt.getInt(6);
			msgError = cstmt.getString(7);
			numEvento=cstmt.getInt(8);
			cat.debug("codError[" + codError + "]");
			cat.debug("msgError[" + msgError + "]");
			cat.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0){
				cat.error("Ocurrió un error al obtener el presupuesto");
				throw new CustomerDomainException(
				"Ocurrió un error al obtener el presupuesto", String
				.valueOf(codError), numEvento, msgError);
			}
			else{
				resultado.setNumeroProceso(parametroEntrada.getNumeroProceso());
				resultado.setTotalCargos(cstmt.getDouble(2));
				cat.debug("resultado.getTotalCargos[" + resultado.getTotalCargos() + "]");
				resultado.setTotalDescuentos(cstmt.getDouble(3));
				cat.debug("resultado.getTotalDescuentos[" + resultado.getTotalDescuentos() + "]");
				resultado.setTotalImpuestos(cstmt.getDouble(4));
				cat.debug("resultado.getTotalImpuestos[" + resultado.getTotalImpuestos() + "]");
				rs = (ResultSet) cstmt.getObject(5);
				double valorMayor0 = 0;
				double valorMenor0 = 0;
				
				while (rs.next()) {					
				    double valor = rs.getDouble(1);
				    if(valor >0) valorMayor0 = valorMayor0 + valor;
				    else valorMenor0 = valorMenor0 + valor;
				}
				resultado.setTotalCargos(valorMayor0);
				resultado.setTotalDescuentos(valorMenor0);
			}
		
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener el presupuesto",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
				cat.debug("Cerrando conexiones...");
	    try {
	    	if (rs!=null)  rs.close();
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				cat.debug("SQLException", e);
		  }
		}

		cat.debug("Fin:getDatosPresupuesto");

		return resultado;
	}//fin getDatosPresupuesto
	
	
	public ProcesoDTO actualizaFacturacion(RegistroFacturacionDTO parametroEntrada) 
		throws CustomerDomainException
	{
		ProcesoDTO resultado=null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:actualizaFacturacion");
			
			String call = getSQLPackage("VE_SERVICIOS_VENTA_PG","VE_ACTUALIZA_FACTURACION_PR",13);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cat.debug("Estado documento" + parametroEntrada.getEstadoDocumento());
			cstmt.setString(1,parametroEntrada.getEstadoDocumento());
			cat.debug("getEstadoProceso" + parametroEntrada.getEstadoProceso());
			cstmt.setString(2,parametroEntrada.getEstadoProceso());
			cstmt.setString(3,parametroEntrada.getCategoriaTributaria());
			cstmt.setString(4,parametroEntrada.getNumeroFolio());
			cstmt.setString(5,parametroEntrada.getPrefijoPlaza());
			cstmt.setString(6,parametroEntrada.getFechaVencimiento());
			cstmt.setString(7,parametroEntrada.getNombreUsuarioEliminacion());
			cstmt.setString(8,parametroEntrada.getCausalEliminacion());
			cstmt.setString(9,parametroEntrada.getNumeroProcesoFacturacion());
			cstmt.setString(10,parametroEntrada.getNumeroVenta());
			cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(13, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:actualizaFacturacion:execute");
			cstmt.execute();
			cat.debug("Fin:actualizaFacturacion:execute");

			codError=cstmt.getInt(11);
			msgError = cstmt.getString(12);
			numEvento=cstmt.getInt(13);
			cat.debug("msgError[" + msgError + "]");
			
			if (codError != 0){
				resultado = new ProcesoDTO();
				resultado.setCodigoError(codError);
				resultado.setEvento(numEvento);
				throw new GeneralException(String.valueOf(codError),numEvento, msgError);				
			}
			
		} catch (Exception e) {
			cat.error("Ocurrió un error al actualizar la facturación",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
				cat.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				cat.debug("SQLException", e);
		  }
		}

		cat.debug("Fin:actualizaFacturacion");

		return resultado;
	}//fin actualizaFacturacion
	
	  /**
	 * Obtiene Detalle Presupuesto
	 * @param parametroEntrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	
	public ImpuestosDTO[] getDetallePresupuesto(ImpuestosDTO parametroEntrada) 
		throws CustomerDomainException
	{
		ImpuestosDTO[] resultado=null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		ResultSet rs = null;
		try {
			cat.debug("Inicio:getDetallePresupuesto");
			
			String call = getSQLPackage("FA_Servicios_Facturacion_PG","FA_con_presupuesto_PR",5);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,parametroEntrada.getNumeroProceso());
			cat.debug("parametroEntrada.getNumeroProceso(): " + parametroEntrada.getNumeroProceso());
			
			cstmt.registerOutParameter(2, OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getDetallePresupuesto:execute");
			cstmt.execute();
			cat.debug("Fin:getDetallePresupuesto:execute");

			codError=cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento=cstmt.getInt(5);
			cat.debug("codError[" + codError + "]");
			cat.debug("msgError[" + msgError + "]");
			cat.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0){
				cat.error("Ocurrió un error al obtener el detalle del presupuesto");
				throw new CustomerDomainException(
				"Ocurrió un error al obtener el detalle del presupuesto", String
				.valueOf(codError), numEvento, msgError);
			}
			else{
				cat.debug("Llenado detalle presupuesto");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(2);
				while (rs.next()) {
					ImpuestosDTO impuestosDTO = new ImpuestosDTO();
					impuestosDTO.setCodigoConcepto(rs.getInt(1));
					impuestosDTO.setTotalCargos(rs.getInt(2));
					impuestosDTO.setTotalImpuestos(rs.getFloat(3));
					impuestosDTO.setTotalDescuentos(rs.getFloat(4));
					lista.add(impuestosDTO);
				}				
				resultado =(ImpuestosDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), ImpuestosDTO.class);
				
				cat.debug("Fin llenado detalle presupuesto");
			}
		
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener el detalle del presupuesto",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
		 	if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (rs!=null)
					rs.close();
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}

		cat.debug("Fin:getDetallePresupuesto");

		return resultado;
	}//fin getDetallePresupuesto

	/**
	 * Obtiene Detalle Presupuesto por concepto facturable
	 * @param parametroEntrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */

	public ImpuestosDTO[] getDetallePresupuestoporConcepto(ImpuestosDTO parametroEntrada) 
		throws CustomerDomainException
	{
		ImpuestosDTO[] resultado=null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		ResultSet rs = null;
		try {
			cat.debug("Inicio:getDetallePresupuestoporConcepto");
			
			String call = getSQLPackage("FA_Servicios_Facturacion_PG","FA_det_concepto_presup_PR",6);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,parametroEntrada.getNumeroProceso());
			cat.debug("parametroEntrada.getNumeroProceso(): " + parametroEntrada.getNumeroProceso());
			cstmt.setLong(2,parametroEntrada.getCodigoConcepto());
			cat.debug("parametroEntrada.getCodigoConcepto(): " + parametroEntrada.getCodigoConcepto());
			cstmt.registerOutParameter(3, OracleTypes.CURSOR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getDetallePresupuesto:execute");
			cstmt.execute();
			cat.debug("Fin:getDetallePresupuesto:execute");

			codError=cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento=cstmt.getInt(6);
			cat.debug("codError[" + codError + "]");
			cat.debug("msgError[" + msgError + "]");
			cat.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0){
				cat.error("Ocurrió un error al obtener el detalle del presupuesto por concepto");
				throw new CustomerDomainException(
				"Ocurrió un error al obtener el detalle del presupuesto por concepto", String
				.valueOf(codError), numEvento, msgError);
			}
			else{
				cat.debug("Llenado detalle presupuesto");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(3);
				while (rs.next()) {
					ImpuestosDTO impuestosDTO = new ImpuestosDTO();
					impuestosDTO.setTotalCargos(rs.getInt(1));
					impuestosDTO.setTotalImpuestos(rs.getFloat(2));
					impuestosDTO.setTotalDescuentos(rs.getFloat(3));
					lista.add(impuestosDTO);
				}
				resultado =(ImpuestosDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), ImpuestosDTO.class);
				
				cat.debug("Fin llenado detalle presupuesto");
			}
		
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener el detalle del presupuesto por concepto");
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
				cat.debug("Cerrando conexiones...");
	    try {
	    	if (rs!=null)
				rs.close();
			if (cstmt!=null)
				cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				cat.debug("SQLException", e);
		  }
		}

		cat.debug("Fin:getDetallePresupuestoporConcepto");

		return resultado;
	}//fin getDetallePresupuesto

	/**
	 * Obtiene el valor del parametro que indica si se consume folio
	 * @param N/A
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public RegistroFacturacionDTO getConsumeFolio() 
		throws CustomerDomainException
	{
		RegistroFacturacionDTO resultado = new RegistroFacturacionDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:getConsumeFolio");
			
			String call = getSQLPackage("VE_intermediario_PG","VE_getConsumeFolio_PR",4);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getConsumeFolio:execute");
			cstmt.execute();
			cat.debug("Inicio:getConsumeFolio:execute");
			
			codError=cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento=cstmt.getInt(4);

			if (codError==0)
				resultado.setValorParametroConsumeFolio(cstmt.getString(1));
		
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener valor parametro que indica si se consume folio",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
				cat.debug("Cerrando conexiones...");
	    try {	    	
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				cat.debug("SQLException", e);
		  }
		}
		cat.debug("Fin:getConsumeFolio");
		return resultado;
	}//fin getConsumeFolio

	/**
	 * Obtiene Detalle Presupuesto por concepto facturable
	 * @param parametroEntrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public RegistroFacturacionDTO[] getListCiclosPostPago(RegistroFacturacionDTO entrada) 
		throws CustomerDomainException
	{
		RegistroFacturacionDTO[] resultado=null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		ResultSet rs = null;
		try {
			cat.debug("Inicio:getListCiclosPostPago");
			
			String call = getSQLPackage("FA_Servicios_Facturacion_PG","FA_getListCiclosPostPago_PR",5);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setInt(1,entrada.getCicloPrePago());
			cstmt.registerOutParameter(2, OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getListCiclosPostPago:execute");
			cstmt.execute();
			cat.debug("Fin:getListCiclosPostPago:execute");

			codError=cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento=cstmt.getInt(5);
			
			if (codError != 0){
				cat.error("Ocurrió un error al obtener ciclos de facturacion postpago");
				throw new CustomerDomainException(
				"Ocurrió un error al obtener ciclos de facturacion postpago", String
				.valueOf(codError), numEvento, msgError);
			}
			else{
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(2);
				while (rs.next()) {
					RegistroFacturacionDTO registroDTO = new RegistroFacturacionDTO();
					registroDTO.setCodigoCicloFacturacion(rs.getInt(1));
					registroDTO.setDescripcionCiclo(rs.getString(2));
					lista.add(registroDTO);
				}
				resultado =(RegistroFacturacionDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), RegistroFacturacionDTO.class);
			}
		
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener ciclos de facturacion postpago");
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
				cat.debug("Cerrando conexiones...");
	    try {
	    	if (rs!=null)
				rs.close();
			if (cstmt!=null)
				cstmt.close();	    	
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				cat.debug("SQLException", e);
		  }
		}
		cat.debug("Fin:getListCiclosPostPago");
		return resultado;
	}//fin getListCiclosPostPago
	
	/**
	 * Obtiene codigo de despacho
	 * @param N/A
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public RegistroFacturacionDTO getCodigoDespacho() 
		throws CustomerDomainException
	{
		RegistroFacturacionDTO resultado = new RegistroFacturacionDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:getCodigoDespacho");
			
			String call = getSQLPackage("FA_Servicios_Facturacion_PG","FA_getCodigoDespacho_PR",4);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getCodigoDespacho:execute");
			cstmt.execute();
			cat.debug("Inicio:getCodigoDespacho:execute");
			
			codError=cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento=cstmt.getInt(4);

			if (codError==0)
				resultado.setCodigoDespacho(cstmt.getString(1));
		
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener codigo de despacho",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
				cat.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				cat.debug("SQLException", e);
		  }
		}
		cat.debug("Fin:getCodigoDespacho");
		return resultado;
	}//fin getCodigoDespacho

	/**
	 * Obtiene ciclo de facturacion calendario mas inmediato
	 * @param N/A
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public RegistroFacturacionDTO getCicloFacturacion() 
		throws CustomerDomainException
	{
		RegistroFacturacionDTO resultado = new RegistroFacturacionDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:getCicloFacturacion");
			
			String call = getSQLPackage("FA_Servicios_Facturacion_PG","FA_getCicloFacturacion_PR",28);

			cat.debug("sql[" + call + "]");

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
			
			cat.debug("Inicio:getCicloFacturacion:execute");
			cstmt.execute();
			cat.debug("Inicio:getCicloFacturacion:execute");
			
			codError=cstmt.getInt(26);
			msgError = cstmt.getString(27);
			numEvento=cstmt.getInt(28);
			
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
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener ciclo de facturacion calendario mas inmediato",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
				cat.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				cat.debug("SQLException", e);
		  }
		}
		cat.debug("Fin:getCicloFacturacion");
		return resultado;
	}//fin getCicloFacturacion
	
	/**
	 * Verifica si ciclo corresponde a un plan freedom
	 * @param entrada
	 * @return resultado
	 * @throws ProductDomainException
	 */
	public RegistroFacturacionDTO esCicloFredom(RegistroFacturacionDTO registroFacturacionDTO) 
		throws CustomerDomainException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:esCicloFredom");

			String call = getSQLPackage("VE_alta_cliente_PG","VE_esCicloFreedom_PR",5);
			cat.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);

			cstmt.setString(1,registroFacturacionDTO.getCodigoCiclo());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:esCicloFredom:execute");
			cstmt.execute();
			cat.debug("Fin:esCicloFredom:execute");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);

			if (codError != 0) {
				registroFacturacionDTO.setCicloFreedom(false);
			}else
				registroFacturacionDTO.setCicloFreedom(cstmt.getInt(2)==1?true:false);
			
		} catch (Exception e) {
			cat.error("Ocurrió un error al verificar si ciclo corresponde a un plan freedom",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
		 	if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:esCicloFredom()");
		return registroFacturacionDTO;
	}//fin esCicloFredom
	
	/**
	 * Obtiene dias para realizar prorrateo de importe de plan tarifarios 
	 * tipo hibrido en icc_movimiento
	 * @param entrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	
	public RegistroFacturacionDTO getDiasProrrateo(RegistroFacturacionDTO registroFacturacionDTO)
		throws CustomerDomainException
	{
		RegistroFacturacionDTO resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:getDiasProrrateo");
			
			String call = getSQLPackage("FA_Servicios_Facturacion_PG","FA_getDiasProrrateo_PR",7);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			
			cstmt.setInt(1,registroFacturacionDTO.getCodigoCicloFacturacion());
			cat.debug("[getDiasProrrateo] CodigoCicloCliente: " + registroFacturacionDTO.getCodigoCicloFacturacion());
			cstmt.setString(2,registroFacturacionDTO.getFormatoFecha());
			cat.debug("[getDiasProrrateo] formato Fecha: " + registroFacturacionDTO.getFormatoFecha());
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC); // SV_diasProrrateo
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC); // SV_cantDias
			
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			cstmt.execute();
			codError=cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento=cstmt.getInt(7);
			cat.debug("msgError[" + msgError + "]");

			if (codError==0){
				resultado = new RegistroFacturacionDTO();
				resultado.setDiasProrrateo(cstmt.getInt(3));
				resultado.setDiasDiferencia(cstmt.getInt(4));
			}
			
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener los dias de prorrateo",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
				cat.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				cat.debug("SQLException", e);
		  }
		}

		cat.debug("Fin:getDiasProrrateo");

		return resultado;
	}//fin getDiasProrrateo
	
	
	/**
	 * Aplica impuesto al importe del plan tarifario informado
	 * (solo planes tipo hibridos)
	 * @param entrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	
	public RegistroFacturacionDTO aplicaImpuestoImporte(RegistroFacturacionDTO registroFacturacionDTO)
		throws CustomerDomainException
	{
		RegistroFacturacionDTO resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:aplicaImpuestoImporte");
			
			String call = getSQLPackage("FA_Servicios_Facturacion_PG","FA_getImpuesto_PR",8);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,registroFacturacionDTO.getCodigoCliente());
			cat.debug("[aplicaImpuestoImporte] CodigoCliente: " + registroFacturacionDTO.getCodigoCliente());
			cstmt.setString(2,registroFacturacionDTO.getCodigoOficina());
			cat.debug("[aplicaImpuestoImporte] oficina: " + registroFacturacionDTO.getCodigoOficina());
			cstmt.setFloat(3,registroFacturacionDTO.getImportePlan());
			cat.debug("[aplicaImpuestoImporte] getImportePlan: " + registroFacturacionDTO.getImportePlan());
			cstmt.setLong(4,registroFacturacionDTO.getCodigoConcepto().longValue());
			cat.debug("[aplicaImpuestoImporte] getCodigoConcepto: " + registroFacturacionDTO.getCodigoConcepto());
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC); // SV_importeTotal
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			cstmt.execute();
			codError=cstmt.getInt(6);
			msgError = cstmt.getString(7);
			numEvento=cstmt.getInt(8);
			cat.debug("msgError[" + msgError + "]");
			
			if (codError==0){
				resultado = new RegistroFacturacionDTO();
				resultado.setImporteTotal(cstmt.getFloat(5));
			} else {
				throw new CustomerDomainException(
						"Ocurrió un error al aplicar impuesto", String
						.valueOf(codError), numEvento, msgError);				
			}
			
		} catch (Exception e) {
			cat.error("Ocurrió un error al aplicar impuesto",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException ){
		           throw (CustomerDomainException) e;
			   }
		} finally {
				cat.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				cat.debug("SQLException", e);
		  }
		}

		cat.debug("Fin:aplicaImpuestoImporte");

		return resultado;
	}//fin aplicaImpuestoImporte
	
	/**
	 * Aplica impuesto al concepto asociado a mayorista
	 * (solo planes tipo hibridos)
	 * @param entrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	
	public RegistroFacturacionDTO aplicaImpuestoConceptoMayorista(RegistroFacturacionDTO registroFacturacionDTO)
		throws CustomerDomainException
	{
		RegistroFacturacionDTO resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:aplicaImpuestoImporte");
			
			String call = getSQLPackage("FA_Servicios_Facturacion_PG","FA_getImpuesto_PR",8);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,registroFacturacionDTO.getCodigoCliente());
			cat.debug("[aplicaImpuestoImporte] CodigoCliente: " + registroFacturacionDTO.getCodigoCliente());
			cstmt.setString(2,registroFacturacionDTO.getCodigoOficina());
			cat.debug("[aplicaImpuestoImporte] oficina: " + registroFacturacionDTO.getCodigoOficina());
			cstmt.setFloat(3,registroFacturacionDTO.getImportePlan());
			cat.debug("[aplicaImpuestoImporte] getImportePlan: " + registroFacturacionDTO.getImportePlan());
			cstmt.setLong(4,registroFacturacionDTO.getCodigoConcepto().longValue());
			
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC); // SV_importeTotal			
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			cstmt.execute();
			codError=cstmt.getInt(6);
			msgError = cstmt.getString(7);
			numEvento=cstmt.getInt(8);
			cat.debug("msgError[" + msgError + "]");
			
			if (codError==0){
				resultado = new RegistroFacturacionDTO();
				resultado.setImporteTotal(cstmt.getFloat(5));
			} else {
				throw new CustomerDomainException(
						"Ocurrió un error al aplicar impuesto", String
						.valueOf(codError), numEvento, msgError);				
			}
			
		} catch (Exception e) {
			cat.error("Ocurrió un error al aplicar impuesto",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException ){
		           throw (CustomerDomainException) e;
			   }
		} finally {
				cat.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				cat.debug("SQLException", e);
		  }
		}

		cat.debug("Fin:aplicaImpuestoImporte");

		return resultado;
	}//fin aplicaImpuestoImporte
	
	public ImpuestosDTO getImpuestoDesctoManual(ImpuestosDTO impuesto)
		throws CustomerDomainException
	{
		ImpuestosDTO resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:getImpuestoDesctoManual");
			
			String call = getSQLPackage("FA_Servicios_Facturacion_PG","FA_getImpuesto_PR",8);
	
			cat.debug("sql[" + call + "]");
	
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,String.valueOf(impuesto.getCodigoCliente()));
			cat.debug("[getImpuestoDesctoManual] CodigoCliente: " + impuesto.getCodigoCliente());
			cstmt.setString(2,impuesto.getCodOficina());
			cat.debug("[getImpuestoDesctoManual] oficina: " + impuesto.getCodOficina());
			cstmt.setDouble(3,impuesto.getMontoDsctoManual());
			cat.debug("[getImpuestoDesctoManual] getMontoDsctoManual: " + impuesto.getMontoDsctoManual());
			cstmt.setDouble(4,impuesto.getCodigoConcepto());
			cat.debug("[getCodigoConcepto()] getCodigoConcepto(): " + impuesto.getCodigoConcepto());
			
			
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC); // SV_importeTotal
			
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			cstmt.execute();
			codError=cstmt.getInt(6);
			msgError = cstmt.getString(7);
			numEvento=cstmt.getInt(8);
			cat.debug("msgError[" + msgError + "]");
			
			if (codError==0){
				resultado = new ImpuestosDTO();
				resultado.setMontoDsctoManual(cstmt.getDouble(5));
			} else {
				throw new CustomerDomainException(
						"Ocurrió un error al aplicar impuesto", String
						.valueOf(codError), numEvento, msgError);				
			}
			
		} catch (Exception e) {
			cat.error("Ocurrió un error al aplicar impuesto",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException ){
		           throw (CustomerDomainException) e;
			   }
		} finally {
				cat.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				cat.debug("SQLException", e);
		  }
		}
	
		cat.debug("Fin:getImpuestoDesctoManual");
	
		return resultado;
	}//fin getImpuestoDesctoManual
	
	public void atualizaIndFacturCargos(Long numVenta)
		throws CustomerDomainException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:atualizaIndFacturCargos");
			
			String call = getSQLPackage("FA_Servicios_Facturacion_PG","FA_ActualizaIndFact_PR",4);
	
			cat.debug("sql[" + call + "]");
	
			cstmt = conn.prepareCall(call);
			
			cstmt.setLong(1,numVenta.longValue());
			cat.debug("[atualizaIndFacturCargos] numVenta: " + numVenta);
			
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.execute();
			codError=cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento=cstmt.getInt(4);
			cat.debug("msgError[" + msgError + "]");
			
			if (codError!=0)
			{				
				throw new CustomerDomainException(
						"Ocurrió un error al actualizar el indicador de factura", String
						.valueOf(codError), numEvento, msgError);				
			}
			
		} catch (Exception e) {
			cat.error("Ocurrió un error al actualizar el indicador de factura",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException ){
		           throw (CustomerDomainException) e;
			   }
		} finally {
				cat.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				cat.debug("SQLException", e);
		  }
		}
	
		cat.debug("Fin:atualizaIndFacturCargos");
	}//fin atualizaIndFacturCargos
	
	
	/**************************************************************************************************************************************/
	
	public FaConceptoDTO getFaConcepto(FaConceptoDTO faConceptoDTO)	throws CustomerDomainException{

		FaConceptoDTO resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:getFaConcepto");
			
			String call = getSQLPackage("FA_Servicios_Facturacion_PG","FA_obtieneConcepto_PR",7);
	
			cat.debug("sql[" + call + "]");
	
			cstmt = conn.prepareCall(call);
			cat.debug("Codigo Concepto ["+ faConceptoDTO.getCodConcepto()+"]");
			cstmt.setString(1,faConceptoDTO.getCodConcepto());
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			cstmt.execute();
			codError=cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento=cstmt.getInt(7);
			cat.debug("msgError[" + msgError + "]");
			
			if (codError==0){
				resultado = new FaConceptoDTO();
				resultado.setDesConcep(cstmt.getString(2));
				resultado.setCodTipConce(cstmt.getString(3));
				resultado.setCodMoneda(cstmt.getString(4));
			} else {
				throw new CustomerDomainException(
						"Ocurrió un error getFaConcepto", String
						.valueOf(codError), numEvento, msgError);				
			}
			
		} catch (Exception e) {
			cat.error("Ocurrió un error getFaConcepto",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException ){
		           throw (CustomerDomainException) e;
			   }
		} finally {
				cat.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				cat.debug("SQLException", e);
		  }
		}
	
		cat.debug("Fin:getFaConcepto");
	
		return resultado;
		
		
	}
	/**
	 * 
	 * @param numVenta
	 * @return DetalleInformePresupuestoDTO
	 * @throws CustomerDomainException
	 */
	public DetalleInformePresupuestoDTO[] obtenerDetallePresupuesto(Long numVenta)	throws CustomerDomainException{

		DetalleInformePresupuestoDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		ResultSet rs = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:obtenerDetallePresupuesto");
			String call = getSQLPackage("VE_SERVICIOS_VENTA_PG","VE_obtDetallePresup_PR",5);
	
			cat.debug("sql[" + call + "]");
	
			cstmt = conn.prepareCall(call);
			cat.debug("Numero Venta ["+ numVenta+"]");
			cstmt.setLong(1,numVenta.longValue());
			cstmt.registerOutParameter(2, OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.execute();
			codError=cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento=cstmt.getInt(5);
			cat.debug("msgError[" + msgError + "]");
			
			if (codError != 0){
				cat.error("Ocurrió un error al obtener cargos de presupuesto");
				throw new CustomerDomainException(
				"Ocurrió un error al obtener cargos de presupuesto", String
				.valueOf(codError), numEvento, msgError);
			}
			else{
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(2);
				while (rs.next()) {
					DetalleInformePresupuestoDTO cargosPresupuestoDTO = new DetalleInformePresupuestoDTO();
					cargosPresupuestoDTO.setDescripcionArticulo(rs.getString(1));
					cargosPresupuestoDTO.setCargos(rs.getDouble(2));
					cargosPresupuestoDTO.setImpuestos(rs.getDouble(3));
					cargosPresupuestoDTO.setDescuentos(rs.getDouble(4));
					cargosPresupuestoDTO.setTotal(rs.getDouble(5));
					cargosPresupuestoDTO.setNumAbonado(rs.getLong(6));
					
					lista.add(cargosPresupuestoDTO);
				}
				resultado =(DetalleInformePresupuestoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), DetalleInformePresupuestoDTO.class);
			}
			
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener cargos de presupuesto",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException ){
		           throw (CustomerDomainException) e;
			   }
		} finally {
				cat.debug("Cerrando conexiones...");
	    try {
	    	if (rs!=null)  rs.close();
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				cat.debug("SQLException", e);
		  }
		}
	
		cat.debug("Fin:obtenerDetallePresupuesto");
	
		return resultado;
		
		
	}
	
	//Inicio P-CSR-11002 JLGN 29-10-2011
	public String obtenerNombreFactura(long numVenta)throws CustomerDomainException{
		cat.debug("obtenerNombreFactura:Inicio");
		String resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			String call = getSQLPackage("VE_parametros_comerciales_PG","ve_nombre_factura_pr",5);	
			cat.debug("sql[" + call + "]");	
			cstmt = conn.prepareCall(call);
			cat.debug("Numero de Venta ["+ numVenta +"]");
			cstmt.setLong(1, numVenta);
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.execute();
			codError=cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento=cstmt.getInt(5);
			
			if (codError != 0){
				cat.debug("codError[" + codError + "]");
				cat.debug("msgError[" + msgError + "]");
				cat.debug("numEvento[" + numEvento + "]");
				cat.debug("Ocurrio un error al obtener el nombre de la factura");
				throw new CustomerDomainException("Ocurrio un error al obtener el nombre de la factura", String.valueOf(codError), numEvento, msgError);
			}
			resultado = cstmt.getString(2);			
		} catch (Exception e) {
			cat.error("Ocurrio un error al obtener el nombre de la factura",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException ){
		           throw (CustomerDomainException) e;
			   }
		} finally {
				cat.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				cat.debug("SQLException", e);
		  }
		}	
		cat.debug("Fin:obtenerNombreFactura");	
		return resultado;
	}
	
}//fin class RegistroFacturacionDAO


