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
 * 16/03/2007     Héctor Hermosilla      					Versión Inicial
 */

package com.tmmas.cl.scl.customerdomain.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.LstVtaRegistroResultadoDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.LstVtaRegistroVentaOutDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CargoSolicitudDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ListadoVentasDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosGeneralesDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosRegistroCargosDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.ProductDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.AbonadoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.AlPetiGuiasAboDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.CelularDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.DatosContrato;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.DetalleFichaContratoPrestacionDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.DetalleFichaSalidaBodegaDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.FichaClienteDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.FichaContratoPrestacionDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.FichaSalidaBodegaDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.GaDocVentasDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.GaVentasDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.MatrizEstadosDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.PagareDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.RegistroVentaDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.TipoSolicitudDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.helper.Global;

public class RegistroVentaDAO extends ConnectionDAO{
	private static Category cat = Category.getInstance(RegistroVentaDAO.class);

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
	
	
	private String getSQLDatosVenta(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
        for (int n = 1; n <= paramCount; n++) {
            sb.append("?");
            if (n < paramCount) sb.append(",");
        }
        return sb.append(")}").toString();
	}
	
	/**
	 * Obtiene secuencia de la venta
	 * @param parametroEntrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	
	public RegistroVentaDTO getSecuenciaVenta(RegistroVentaDTO parametroEntrada) 
		throws CustomerDomainException
	{
		RegistroVentaDTO resultado=new RegistroVentaDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:getSecuenciaVenta");
			
			String call = getSQLDatosVenta("VE_intermediario_PG","VE_OBTIENE_SECUENCIA_PR",5);
			
			cat.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,parametroEntrada.getCodigoSecuencia());
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getSecuenciaVenta:execute");
			cstmt.execute();
			cat.debug("Fin:getSecuenciaVenta:execute");
			
			codError=cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento=cstmt.getInt(5);
			cat.debug("msgError[" + msgError + "]");
			
			resultado.setNumeroVenta(Long.parseLong(cstmt.getString(2)));
			
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener la secuencia de la venta",e);
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
		cat.debug("Fin:getSecuenciaVenta");
		return resultado;
	}

	/**
	 * Obtiene secuencia de transacabo
	 * @param parametroEntrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public RegistroVentaDTO getSecuenciaTransacabo(RegistroVentaDTO parametroEntrada) 
		throws CustomerDomainException
	{
		RegistroVentaDTO resultado=new RegistroVentaDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:getSecuenciaTransacabo");
			
			String call = getSQLDatosVenta("VE_intermediario_PG","VE_OBTIENE_SECUENCIA_PR",5);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,parametroEntrada.getCodigoSecuencia());
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getSecuenciaTransacabo:execute");
			cstmt.execute();
			cat.debug("Fin:getSecuenciaTransacabo:execute");

			codError=cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento=cstmt.getInt(5);
			cat.debug("msgError[" + msgError + "]");
			
			if (codError != 0){
				cat.error("Ocurrió un error al obtener secuencia transacabo");
				throw new CustomerDomainException(
				"Ocurrió un error al obtener secuencia transacabo", String
				.valueOf(codError), numEvento, msgError);
			}
			else
				resultado.setNumeroTransaccionVenta(Long.parseLong(cstmt.getString(2)));
		
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener la secuencia de la transacabo",e);
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

		cat.debug("Fin:getSecuenciaTransacabo");

		return resultado;
	}//fin getSecuenciaTransacabo
		
	/**
	 * Obtiene Prefijo de numero telefonico
	 * @param entrada
	 * @return entrada
	 * @throws CustomerDomainException
	 */
	public RegistroVentaDTO getPrefijoMin(RegistroVentaDTO entrada) 
		throws CustomerDomainException
	{
		RegistroVentaDTO resultado=null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:getPrefijoMin");
			
			String call = getSQLDatosVenta("VE_intermediario_PG","VE_OBTIENE_PREFIJO_NUM_PR",5);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			
			cstmt.setLong(1,entrada.getNumeroCelular());

			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getPrefijoMin:execute");
			cstmt.execute();
			cat.debug("Fin:getPrefijoMin:execute");

			codError=cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento=cstmt.getInt(5);
			cat.debug("Código Error: " +  cstmt.getInt(3));
			cat.debug("msgError: " +  cstmt.getString(4));
			cat.debug("numEvento: " +  cstmt.getInt(5));
			
			if (codError != 0){
				cat.error("Ocurrió un error al obtener prefijo numero celular");
				throw new CustomerDomainException(
				"Ocurrió un error al obtener prefijo numero celular", String
				.valueOf(codError), numEvento, msgError);
			}
			else{
				resultado = entrada;
				resultado.setPrefijoMin(cstmt.getString(2));
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener prefijo numero celular",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
				if (e instanceof CustomerDomainException)
					throw (CustomerDomainException)e;
				
							
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
		cat.debug("Fin:getPrefijoMin");
		return resultado;
	}//fin getPrefijoMin

	/**
	 * Obtiene numero celular automatico
	 * @param celular
	 * @return celular
	 * @throws CustomerDomainException
	 */
	public CelularDTO getNumeroCelularAut(CelularDTO celular) 
		throws CustomerDomainException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:getNumeroCelularAut");
			
			String call = getSQLDatosVenta("VE_intermediario_PG","VE_ObtieneNumeroCelularAut_PR",11);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,celular.getCodSubAlm());
			cat.debug("subalm:" + celular.getCodSubAlm());
			cstmt.setString(2,celular.getCentral());
			cat.debug("subalm:" + celular.getCentral());
			cstmt.setString(3,celular.getCodigoUso());
			cat.debug("codigo uso:" + celular.getCodigoUso());
			cstmt.setString(4,celular.getCodActabo());
			cat.debug("codigo actabo:" + celular.getCodActabo());

			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getNumeroCelularAut:execute");
			cstmt.execute();
			cat.debug("Fin:getNumeroCelularAut:execute");

			codError=cstmt.getInt(9);
			msgError = cstmt.getString(10);
			numEvento=cstmt.getInt(11);
			cat.debug("msgError[" + msgError + "]");
			
			if (codError != 0){
				cat.error("Ocurrió un error al obtener numero celular automatico");
				throw new CustomerDomainException(
				"Ocurrió un error al obtener numero celular automatico", String
				.valueOf(codError), numEvento, msgError);
			}
			else{
				celular.setNumeroCelular(Long.parseLong(cstmt.getString(5)));
				celular.setTipoCelular(cstmt.getString(6));
				celular.setCategoria(cstmt.getString(7));
				celular.setFecBajaCelular(cstmt.getString(8));
			}
		
		} catch (CustomerDomainException e) {
			cat.error("Ocurrió un error al obtener numero celular automatico",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener numero celular automatico",e);
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

		cat.debug("Fin:getNumeroCelularAut");

		return celular;
	}//fin getNumeroCelularAut

	/**
	 * Genera reserva numero celular
	 * @param celular
	 * @return celular
	 * @throws CustomerDomainException
	 */
	
	public CelularDTO setReservaNumeroCelular(CelularDTO celular)
		throws CustomerDomainException
	{		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:setReservaNumeroCelular");
			
			String call = getSQLDatosVenta("VE_intermediario_PG","VE_reserva_numero_celular_PR",13);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setLong(1,celular.getNumeroTransaccion());
			cstmt.setString(2,celular.getNumeroLinea());
			cstmt.setString(3,celular.getNumeroOrden());
			cstmt.setLong(4,celular.getNumeroCelular());
			cstmt.setString(5,celular.getCodSubAlm());
			cstmt.setString(6,celular.getCentral());
			cstmt.setString(7,celular.getCategoria());
			cstmt.setString(8,celular.getCodigoUso());
			cstmt.setString(9,celular.getTipoCelular());
			cstmt.setString(10,celular.getFecBajaCelular());

			cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(13, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:setReservaNumeroCelular:execute");
			cstmt.execute();
			cat.debug("Fin:setReservaNumeroCelular:execute");

			codError=cstmt.getInt(11);
			msgError = cstmt.getString(12);
			numEvento=cstmt.getInt(13);
			cat.debug("msgError[" + msgError + "]");
			
			if (codError != 0){
				cat.error("Ocurrió un error al insertar en GA_RESNUMCEL");
				throw new CustomerDomainException(
				"Ocurrió un error al insertar en GA_RESNUMCEL", String
				.valueOf(codError), numEvento, msgError);
			}	

		} catch (Exception e) {
			cat.error("Ocurrió un error al insertar en GA_RESNUMCEL",e);
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

		cat.debug("Fin:setReservaNumeroCelular");

		return celular;
	}//fin setReservaNumeroCelular
	
	/**
	 * Obtiene secuencia del paquete para agregar datos a tabla cargos
	 * @param parametroEntrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	
	public RegistroVentaDTO getSecuenciaPaquete(RegistroVentaDTO parametroEntrada)
		throws CustomerDomainException
	{
		RegistroVentaDTO resultado=new RegistroVentaDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:getSecuenciaPaquete");
			
			String call = getSQLDatosVenta("VE_intermediario_PG","VE_OBTIENE_SECUENCIA_PR",5);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,parametroEntrada.getCodigoSecuencia());
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getSecuenciaPaquete:execute");
			cstmt.execute();
			cat.debug("Fin:getSecuenciaPaquete:execute");

			codError=cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento=cstmt.getInt(5);
			cat.debug("msgError[" + msgError + "]");

			if (codError != 0){
				cat.error("Ocurrió un error al obtener la secuencia del Paquete");
				throw new CustomerDomainException(
				"Ocurrió un error al obtener la secuencia del Paquete", String
				.valueOf(codError), numEvento, msgError);
			}	
			else
				resultado.setNumeroPaquete(cstmt.getString(2));
			
		
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener la secuencia del Paquete",e);
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

		cat.debug("Fin:getSecuenciaPaquete");

		return resultado;
	}
	
	public RegistroVentaDTO existePlanFreedomEnVenta(ParametrosRegistroCargosDTO parametrosCargos,ParametrosGeneralesDTO parametroProporVta,
										ParametrosGeneralesDTO parametroProporc1,ParametrosGeneralesDTO parametroProporc2 )
		throws CustomerDomainException
	{
		RegistroVentaDTO registroventadto =new RegistroVentaDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:existePlanFreedomEnVenta");
			String call = getSQLDatosVenta("VE_servicios_venta_PG","VE_hay_pfreedom_en_venta_PR",8);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,parametroProporVta.getValorparametro());
			cstmt.setInt(2,Integer.parseInt(parametrosCargos.getNumeroVenta()));
			cstmt.setInt(3,Integer.parseInt(parametroProporc1.getValorparametro()));
			cstmt.setInt(4,Integer.parseInt(parametroProporc2.getValorparametro()));
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			cat.debug("Inicio:existePlanFreedomEnVenta:execute");
			cstmt.execute();
			cat.debug("Fin:existePlanFreedomEnVenta:execute");
		    codError= cstmt.getInt(6);
			msgError = cstmt.getString(7);
			numEvento = cstmt.getInt(8);
			int resultado = cstmt.getInt(5);
			registroventadto.setExistePlanFreedom(resultado==1?true:false);
			cat.debug("RegistroVtaDAO:"+resultado);

		} 
		catch (Exception e) {
			cat.error("Ocurrió un error al consultar si existe plan freedom en venta",e);
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
		cat.debug("Fin:existePlanFreedomEnVenta");
		return registroventadto;
	}
	
	
	   
	   private String getSQLCodProcesoVenta() {
			StringBuffer calling = new StringBuffer();		
	        calling.append("");
	        calling.append("DECLARE");                
			calling.append(  "   SO_MATRIZESTADOS   VE_TIPOS_PG. TIP_VE_MATRIZESTADOS_TD; ");
			calling.append(  " BEGIN ");
			calling.append(  "   SO_MATRIZESTADOS(1).cod_programa:=?;");
			calling.append(  "   SO_MATRIZESTADOS(1).ind_ofiter:=?;");
			calling.append(  "   SO_MATRIZESTADOS(1).formulario:= 'FrmVenta2';");
			calling.append(  "  VE_CIERREVENTA_SB_PG.VE_CODIGO_PROCS_VENTA_PR(SO_MATRIZESTADOS, ?,?,?);"); 		
	        calling.append(  "  ?:=SO_MATRIZESTADOS(1).cod_proceso;");        
			calling.append(  " END;");
			if (cat.isDebugEnabled()) 
	        	cat.debug("calling : " + calling);        
			return calling.toString();
	  }
	   
	   private String getSQLCodEstadoFinalVenta() {
			StringBuffer calling = new StringBuffer();		
	        calling.append("");
	        calling.append("DECLARE");                
			calling.append(  "   SO_MATRIZESTADOS   VE_TIPOS_PG. TIP_VE_MATRIZESTADOS_TD; ");
			calling.append(  "   FEC_VENTA			 ve_matrizestados_td.FEC_DESDE%TYPE;");
			calling.append(  " BEGIN ");
			calling.append(  "   SO_MATRIZESTADOS(1).cod_programa:= ?;");
			calling.append(  "   SO_MATRIZESTADOS(1).ind_ofiter:= ?;");
			calling.append(  "   SO_MATRIZESTADOS(1).cod_proceso:=?;");
			calling.append(  "   FEC_VENTA	:=?;");
			calling.append(  "   SO_MATRIZESTADOS(1).formulario:= 'FrmVenta2';");
			calling.append(  "   VE_CIERREVENTA_SB_PG.VE_CODIGO_ESTFINAL_VENTA_PR( SO_MATRIZESTADOS, FEC_VENTA,?,?,? );"); 		
	        calling.append(  "  ?:=SO_MATRIZESTADOS(1).cod_estadodestino;");        
			calling.append(  " END;");
			if (cat.isDebugEnabled()) 
	        	cat.debug("calling : " + calling);        
			return calling.toString();
	 }
	   
	   private String getSQLInsertVenta() {
			StringBuffer calling = new StringBuffer();		
	       calling.append("");
	       calling.append("DECLARE ");                
			calling.append(  "   SO_VENTAS VE_TIPOS_PG.TIP_GA_VENTAS; ");			
			calling.append(  " BEGIN ");
			calling.append(  "   SO_VENTAS(1).COD_PRODUCTO:=?;"); 
			calling.append(  "   SO_VENTAS(1).COD_OFICINA:= ?;");
			calling.append(  "   SO_VENTAS(1).COD_TIPCOMIS:= ?;");
			calling.append(  "   SO_VENTAS(1).COD_VENDEDOR:= ?;");
			calling.append(  "   SO_VENTAS(1).COD_VENDEDOR_AGENTE:=?;"); 
			calling.append(  "   SO_VENTAS(1).NUM_UNIDADES:= ?;");
			calling.append(  "   SO_VENTAS(1).FEC_VENTA:= ?;");
			calling.append(  "   SO_VENTAS(1).COD_REGION:= ?;");
			calling.append(  "   SO_VENTAS(1).COD_PROVINCIA:=?;");
			calling.append(  "   SO_VENTAS(1).COD_CIUDAD:= ?;");
			calling.append(  "   SO_VENTAS(1).IND_ESTVENTA:=?; ");
			calling.append(  "   SO_VENTAS(1).NUM_TRANSACCION:=?; ");
			calling.append(  "   SO_VENTAS(1).IND_PASOCOB:= ?;");
			calling.append(  "   SO_VENTAS(1).NOM_USUAR_VTA:=?; ");
			calling.append(  "   SO_VENTAS(1).IND_VENTA:= ?;");
			calling.append(  "   SO_VENTAS(1).COD_MONEDA:= ?;");
			calling.append(  "   SO_VENTAS(1).COD_CAUSAREC:=?; ");
			calling.append(  "   SO_VENTAS(1).IMP_VENTA:= ?;");
			calling.append(  "   SO_VENTAS(1).COD_TIPCONTRATO:=?;");
			calling.append(  "   SO_VENTAS(1).NUM_CONTRATO:= ?;");
			calling.append(  "   SO_VENTAS(1).IND_TIPVENTA:= ?;");
			calling.append(  "   SO_VENTAS(1).COD_CLIENTE:= ?;");
	    	calling.append(  "   SO_VENTAS(1).COD_MODVENTA:= ?;");
			calling.append(  "   SO_VENTAS(1).TIP_VALOR:= ?;");
			calling.append(  "   SO_VENTAS(1).COD_CUOTA:= ?;");
			calling.append(  "   SO_VENTAS(1).COD_TIPTARJETA:=?;");
			calling.append(  "   SO_VENTAS(1).NUM_TARJETA:= ?;");
			calling.append(  "   SO_VENTAS(1).COD_AUTTARJ:= ?;");
			calling.append(  "   SO_VENTAS(1).FEC_VENCITARJ:=?; ");
			calling.append(  "   SO_VENTAS(1).COD_BANCOTARJ:= ?;");
			calling.append(  "   SO_VENTAS(1).NUM_CTACORR:= ?;");
			calling.append(  "   SO_VENTAS(1).NUM_CHEQUE:= ?;");
			calling.append(  "   SO_VENTAS(1).COD_BANCO:= ?;");
			calling.append(  "   SO_VENTAS(1).COD_SUCURSAL:=?; ");
			calling.append(  "   SO_VENTAS(1).FEC_CUMPLIMENTA:=?;");
			calling.append(  "   SO_VENTAS(1).FEC_RECDOCUM:= ?;");
			calling.append(  "   SO_VENTAS(1).FEC_ACEPREC:= ?;");
			calling.append(  "   SO_VENTAS(1).NOM_USUAR_ACEREC:=?;"); 
			calling.append(  "   SO_VENTAS(1).NOM_USUAR_RECDOC:=?;");
			calling.append(  "   SO_VENTAS(1).NOM_USUAR_CUMPL:=?;");
			calling.append(  "   SO_VENTAS(1).NUM_VENTA:=?;");
			calling.append(  "   SO_VENTAS(1).IND_OFITER:=?;");
			calling.append(  "   SO_VENTAS(1).IND_CHKDICOM:=?;");
			calling.append(  "   SO_VENTAS(1).TIP_FOLIACION:=?;");
			calling.append(  "   SO_VENTAS(1).COD_TIPDOCUM:=?;");
			calling.append(  "   SO_VENTAS(1).COD_OPERADORA:=?;");
			calling.append(  "   SO_VENTAS(1).COD_PLAZA:=?;");
			calling.append(  "   SO_VENTAS(1).COD_VENDEALER:=?;");
			calling.append(  "   GA_VENTAS_SB_PG.GA_INSERT_VENTA_PR( SO_VENTAS,?,?,? );");
			calling.append(  "   ?:=SO_VENTAS(1).NUM_VENTA;");
			calling.append(  "   ?:=SO_VENTAS(1).NUM_CONTRATO;");
			calling.append(  " END;");
			if (cat.isDebugEnabled()) 
	        	cat.debug("calling : " + calling);        
			return calling.toString();
	}
	   private String getSQLgetNumUnidades(){
			StringBuffer calling = new StringBuffer();		
	        calling.append("");
	        calling.append("DECLARE");                
			calling.append(  "   SO_ABOCEL VE_TIPOS_PG.TIP_GA_ABOCEL; ");
			calling.append(  "   NUM_UNIDADES NUMBER;");
			calling.append(  " BEGIN ");
			calling.append(  "   SO_ABOCEL(1).Num_venta :=?;");
			calling.append(  "   VE_CIERREVENTA_SB_PG.VE_NUM_UNIDADES_VENTA_PR ( SO_ABOCEL, NUM_UNIDADES,?,?,? );"); 		
	        calling.append(  "   ?:=NUM_UNIDADES;");        
			calling.append(  " END;");
			if (cat.isDebugEnabled()) 
	        	cat.debug("calling : " + calling);        
			return calling.toString();   
	   }
	   
	   private String getSQLUpdateVentaEscenarioA(){
			StringBuffer calling = new StringBuffer();		
	        calling.append("");
	        calling.append("DECLARE");                
			calling.append(  "   SO_VENTAS VE_TIPOS_PG.TIP_GA_VENTAS; ");
			calling.append(  " BEGIN ");
			calling.append(  "   SO_VENTAS(1).IND_ESTVENTA:=?;");
			calling.append(  "   SO_VENTAS(1).NUM_TRANSACCION:=?;");
			calling.append(  "   SO_VENTAS(1).TIP_VALOR:=?;");
			calling.append(  "   SO_VENTAS(1).IMP_VENTA:=?;");
			calling.append(  "   SO_VENTAS(1).NUM_CONTRATO:=?;");
			calling.append(  "   SO_VENTAS(1).NUM_VENTA:=?;");
			calling.append(  "   GA_VENTAS_SB_PG.GA_UPDATE_VENTA_ESCA_PR ( SO_VENTAS, ?, ?, ? );"); 		
	        calling.append(  " END;");
	        if (cat.isDebugEnabled()) 
	        	cat.debug("calling : " + calling);        
			return calling.toString();   
	   }
	   
	   private String getSQLUpdateVentaEscenarioB(){
			StringBuffer calling = new StringBuffer();		
	        calling.append("");
	        calling.append("DECLARE");                
			calling.append(  "   SO_VENTAS VE_TIPOS_PG.TIP_GA_VENTAS; ");
			calling.append(  " BEGIN ");
			calling.append(  "   SO_VENTAS(1).IND_ESTVENTA:=?;");
			calling.append(  "   SO_VENTAS(1).NUM_TRANSACCION:=?;");
			calling.append(  "   SO_VENTAS(1).TIP_VALOR:=?;");
			calling.append(  "   SO_VENTAS(1).IMP_VENTA:=?;");
			calling.append(  "   SO_VENTAS(1).NUM_CONTRATO:=?;");
			calling.append(  "   SO_VENTAS(1).NUM_VENTA:=?;");
			calling.append(  "   GA_VENTAS_SB_PG.GA_UPDATE_VENTA_ESCB_PR ( SO_VENTAS, ?, ?, ? );"); 		
	        calling.append(  " END;");
	        if (cat.isDebugEnabled()) 
	        	cat.debug("calling : " + calling);        
			return calling.toString();   
	   }
	   
	   private String getSQLUpdateVentaEscenarioC(){
			StringBuffer calling = new StringBuffer();		
	        calling.append("");
	        calling.append("DECLARE");                
			calling.append(  "   SO_VENTAS VE_TIPOS_PG.TIP_GA_VENTAS; ");
			calling.append(  " BEGIN ");
			calling.append(  "   SO_VENTAS(1).IND_ESTVENTA:=?;");
			calling.append(  "   SO_VENTAS(1).NUM_TRANSACCION:=?;");
			calling.append(  "   SO_VENTAS(1).TIP_VALOR:=?;");
			calling.append(  "   SO_VENTAS(1).IMP_VENTA:=?;");
			calling.append(  "   SO_VENTAS(1).NUM_CONTRATO:=?;");
			calling.append(  "   SO_VENTAS(1).NUM_VENTA:=?;");
			calling.append(  "   GA_VENTAS_SB_PG.GA_UPDATE_VENTA_ESCC_PR ( SO_VENTAS, ?, ?, ? );"); 		
	        calling.append(  " END;");
	        if (cat.isDebugEnabled()) 
	        	cat.debug("calling : " + calling);
		   
	       return calling.toString();   
	   }
	   
	   private String getSQLUpdateVentaEscenarioD(){
			StringBuffer calling = new StringBuffer();		
	        calling.append("");
	        calling.append("DECLARE");                
			calling.append(  "   SO_VENTAS VE_TIPOS_PG.TIP_GA_VENTAS; ");
			calling.append(  " BEGIN ");
			calling.append(  "   SO_VENTAS(1).IND_ESTVENTA:=?;");
			calling.append(  "   SO_VENTAS(1).NUM_TRANSACCION:=?;");
			
			calling.append(  "   SO_VENTAS(1).IMP_VENTA:=?;");
			calling.append(  "   SO_VENTAS(1).NUM_CONTRATO:=?;");
			calling.append(  "   SO_VENTAS(1).NUM_VENTA:=?;");
			calling.append(  "   GA_VENTAS_SB_PG.GA_UPDATE_VENTA_ESCD_PR ( SO_VENTAS, ?, ?, ? );"); 		
	        calling.append(  " END;");
	        if (cat.isDebugEnabled()) 
	        	cat.debug("calling : " + calling);        
			return calling.toString();   
	   }
	   
	    private String getSQLUpdate(){
			StringBuffer calling = new StringBuffer();		
	        calling.append("");
	        calling.append("DECLARE");                
			calling.append(  "   SO_VENTAS VE_TIPOS_PG.TIP_GA_VENTAS; ");
			calling.append(  " BEGIN ");
			calling.append(  "   SO_VENTAS(1).IMP_VENTA:=?;");
			calling.append(  "   SO_VENTAS(1).NUM_VENTA:=?;");
			calling.append(  "   GA_VENTAS_SB_PG.GA_UPDATE_VENTA_PR ( SO_VENTAS, ?, ?, ? );"); 		
	        calling.append(  " END;");
	        if (cat.isDebugEnabled()) 
	        	cat.debug("calling : " + calling);        
			return calling.toString();   
	   }
	   
	   
	   /**
	    * @author rlozano
	    * @description Método que retorna el código del proceso del Proceso de Venta
	    * @param matrizEstadosDTO
	    * @return String 
	    * @throws CustomerDomainException
	    */   
	   public String  getCodProcesoVenta(MatrizEstadosDTO matrizEstadosDTO) 
	   		throws CustomerDomainException
	   {
			
		   if (cat.isDebugEnabled()) {
	           cat.debug("getCodigoProcesoVenta():start");
	       }
	       int codError = 0;
	       String msgError = null;
	       int numEvento = 0;
	       
	       String call=null;
	       String codigoProcesoVenta=null;
	       Connection conn = null;
	       CallableStatement cstmt=null;
	       //se recuepera coneccion del DataSources
	       try {
				conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			} 
	       catch (Exception e1) {
				cat.error(" No se pudo obtener una conexión ", e1);
				throw new CustomerDomainException("No se pudo obtener una conexión",e1);
			}
	       try {
				
	           call=getSQLCodProcesoVenta();
	       	if (cat.isDebugEnabled()) {
					cat.debug("sql[" + call + "]");
				}
				cstmt = conn.prepareCall(call);
	           
	           if (cat.isDebugEnabled()) {
					cat.debug("Registrando Entradas");				
				}
	           cstmt.setString(1,matrizEstadosDTO.getCodPrograma() );
	           cstmt.setString(2,matrizEstadosDTO.getIndOfiter() );
	           
	                     
				if (cat.isDebugEnabled()) {
					cat.debug(" Registrando salidas");
				}
				
	           //Se procede a descomentar cuando devuelva errores
	           cstmt.registerOutParameter(3, oracle.jdbc.driver.OracleTypes.NUMBER);
				cstmt.registerOutParameter(4, oracle.jdbc.driver.OracleTypes.VARCHAR);
	           cstmt.registerOutParameter(5, oracle.jdbc.driver.OracleTypes.NUMBER);
	           
	           //Campos de devolución
	           cstmt.registerOutParameter(6, oracle.jdbc.driver.OracleTypes.VARCHAR);
	                       
				if (cat.isDebugEnabled()) {
					cat.debug(" Iniciando Ejecución");
				}

				cat.debug("Execute Antes");
	           cstmt.execute();
	           cat.debug("Execute Despues");

				if (cat.isDebugEnabled()) {
					cat.debug(" Finalizo ejecución");
					cat.debug(" Recuperando salidas");
				}
				// Recuperacion de valores de salida
	           
				codigoProcesoVenta=cstmt.getString(6);
	           
		        
				codError =cstmt.getInt(3);
				cat.debug("codError[" + codError + "]");
				msgError = cstmt.getString(4);
				cat.debug("msgError[" + msgError + "]");
	           numEvento = cstmt.getInt(5);
				cat.debug("numEvento[" + numEvento + "]");
	           cstmt=null;

	           
	           if (codError != 0) {
					cat.error(" Ocurrió un error al recuperar codigo de despacho");
					throw new CustomerDomainException(String.valueOf(codError),
								numEvento, msgError); 
				}
	           
	           cat.debug("Recuperando data...");

				cat.debug("Codigo proceso venta[" + codigoProcesoVenta + "]");
				
			} catch (CustomerDomainException e) {
	           e.printStackTrace();
	           cat.error("Ocurrió un error general al Recuperar el Ciclo de Facturación",e);
				if (cat.isDebugEnabled()) {
					cat.debug("Codigo de Error[" + codError + "]");
					cat.debug("Mensaje de Error[" + msgError + "]");
					cat.debug("Numero de Evento[" + numEvento + "]");
				}
				throw e;
			}catch (Exception e) 
	           {
	            e.printStackTrace();
				cat.error("Ocurrió un error general al recuperar ciclo de facturacion",e);
				if (cat.isDebugEnabled())
	                {
					cat.debug("Codigo de Error[" + codError + "]");
					cat.debug("Mensaje de Error[" + msgError + "]");
					cat.debug("Numero de Evento[" + numEvento + "]");
	               }
	                 throw new CustomerDomainException(
						"Ocurrió un error general  al recuperar ciclo de facturacion",e);
	               
	           }
	           finally {
	               if (cat.isDebugEnabled()) 
	               {
	                   cat.debug("Cerrando conexiones...");
	               }
	               try {
	                       if (cstmt!=null){
	                           cstmt.close();
	                           } 
	                       
	                       if (!conn.isClosed())
	                       {
	                           conn.close();
	                       }
	                   }
	               catch (SQLException e) 
	                   {
	                   // TODO Auto-generated catch block
	                   cat.debug("SQLException[" + e + "]");
	                   }        
			}

	       if (cat.isDebugEnabled()) {
				cat.debug("getCodigoProcesoVenta():end");
			}
	   
	       return codigoProcesoVenta;
		}

	   
	   /**
	    * @author rlozano
	    * @description Método que retorna el código del estado final de la Venta
	    * @param matrizEstadosDTO
	    * @return String 
	    * @throws CustomerDomainException
	    */   
	   public String  getCodEstadoFinalVenta(MatrizEstadosDTO matrizEstadosDTO) 
	   	throws CustomerDomainException
	   {
			
		   if (cat.isDebugEnabled()) {
	           cat.debug("getCodestadoFinalVenta():start");
	       }
	       int codError = 0;
	       String msgError = null;
	       int numEvento = 0;
	       
	       String call=null;
	       String codigoEstadoFinalVenta=null;
	       Connection conn = null;
	       CallableStatement cstmt=null;
	       //se recuepera coneccion del DataSources
	       try {
				conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			} 
	       catch (Exception e1) {
				cat.error(" No se pudo obtener una conexión ", e1);
				throw new CustomerDomainException("No se pudo obtener una conexión",e1);
			}
	       try {
				
	           call=getSQLCodEstadoFinalVenta();
	       	if (cat.isDebugEnabled()) {
					cat.debug("sql[" + call + "]");
				}
				cstmt = conn.prepareCall(call);
	           
	           if (cat.isDebugEnabled()) {
					cat.debug("Registrando Entradas");				
				}
	           cstmt.setString(1,matrizEstadosDTO.getCodPrograma());
	           cstmt.setString(2,matrizEstadosDTO.getIndOfiter());
	           cstmt.setString(3, matrizEstadosDTO.getCodProceso());
	           cstmt.setDate(4, matrizEstadosDTO.getFecVenta());
	           
	                     
				if (cat.isDebugEnabled()) {
					cat.debug(" Registrando salidas");
				}
				
	           
	           
	           //Se procede a descomentar cuando devuelva errores
	           cstmt.registerOutParameter(5, oracle.jdbc.driver.OracleTypes.NUMBER);
				cstmt.registerOutParameter(6, oracle.jdbc.driver.OracleTypes.VARCHAR);
	           cstmt.registerOutParameter(7, oracle.jdbc.driver.OracleTypes.NUMBER);
	           
	           //Campos de devolución
	           cstmt.registerOutParameter(8, oracle.jdbc.driver.OracleTypes.VARCHAR);
	                       
				if (cat.isDebugEnabled()) {
					cat.debug(" Iniciando Ejecución");
				}

				cat.debug("Execute Antes");
	           
				cstmt.execute();
	           
				cat.debug("Execute Despues");

				if (cat.isDebugEnabled()) {
					cat.debug(" Finalizo ejecución");
					cat.debug(" Recuperando salidas");
				}
				// Recuperacion de valores de salida
	           
				codigoEstadoFinalVenta=cstmt.getString(8);
	           
		        
				codError =cstmt.getInt(5);
				cat.debug("codError[" + codError + "]");
				msgError = cstmt.getString(6);
				cat.debug("msgError[" + msgError + "]");
	           numEvento = cstmt.getInt(7);
				cat.debug("numEvento[" + numEvento + "]");
	           cstmt=null;

	         

	           if (codError != 0) {
					cat.error(" Ocurrió un error al recuperar codigo de despacho");
					throw new CustomerDomainException(String.valueOf(codError),
								numEvento, msgError); 
				}
	           
	           cat.debug("Recuperando data...");

				cat.debug("Codigo Estado venta[" + codigoEstadoFinalVenta + "]");
				
			} catch (CustomerDomainException e) {
	          
	           e.printStackTrace();
	           cat.error("Ocurrió un error general al Recuperar el Ciclo de Facturación",e);
				if (cat.isDebugEnabled()) {
					cat.debug("Codigo de Error[" + codError + "]");
					cat.debug("Mensaje de Error[" + msgError + "]");
					cat.debug("Numero de Evento[" + numEvento + "]");
				}
				throw e;
			}catch (Exception e) 
	           {
	                          
	           e.printStackTrace();
				cat.error("Ocurrió un error general al recuperar ciclo de facturacion",e);
				if (cat.isDebugEnabled())
	                {
					cat.debug("Codigo de Error[" + codError + "]");
					cat.debug("Mensaje de Error[" + msgError + "]");
					cat.debug("Numero de Evento[" + numEvento + "]");
	               }
	                 throw new CustomerDomainException(
						"Ocurrió un error general  al recuperar ciclo de facturacion",e);
	               
	           }
	           finally {
	               if (cat.isDebugEnabled()) 
	               {
	                   cat.debug("Cerrando conexiones...");
	               }
	               try {
	                       if (cstmt!=null){
	                           cstmt.close();
	                           } 
	                       
	                       if (!conn.isClosed())
	                       {
	                           conn.close();
	                       }
	                   }
	               catch (SQLException e) 
	                   {
	                   // TODO Auto-generated catch block
	                   cat.debug("SQLException[" + e + "]");
	                   }        
			}

	       if (cat.isDebugEnabled()) {
				cat.debug("getCodestadoFinalVenta():end");
			}
	   
	       return codigoEstadoFinalVenta;
		}
	   
	   /**
	    * @author rlozano
	    * @description Método que realiza la Inserción en GA_VENTAS
	    * @param gaVentasDTO
	    * @return  
	    * @throws CustomerDomainException
	    */   
	   public void insertVenta(GaVentasDTO gaVentasDTO)
	   		throws CustomerDomainException
	   {
			
		   if (cat.isDebugEnabled()) {
	           cat.debug("insertVenta():start");
	       }
	       int codError = 0;
	       String msgError = null;
	       int numEvento = 0;
	       
	       
	       String call=null;
	       //String codigoEstadoFinalVenta=null;
	       Connection conn = null;
	       CallableStatement cstmt=null;
	       //se recuepera coneccion del DataSources
	       try {
				conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			} 
	       catch (Exception e1) {
				cat.error(" No se pudo obtener una conexión ", e1);
				throw new CustomerDomainException("No se pudo obtener una conexión",e1);
			}
	       try {
				
	           call=getSQLInsertVenta();
	       	if (cat.isDebugEnabled()) {
					cat.debug("sql[" + call + "]");
				}
				cstmt = conn.prepareCall(call);
	           
	           if (cat.isDebugEnabled()) {
					cat.debug("Registrando Entradas");				
				}
	           cstmt.setLong(1,gaVentasDTO.getCodProducto().longValue());
	           cstmt.setString(2,gaVentasDTO.getCodOficina());
	           cstmt.setString(3,gaVentasDTO.getCodTipcomis());
	           cstmt.setLong(4,gaVentasDTO.getCodVendedor().longValue());
	           cstmt.setLong(5,gaVentasDTO.getCodVendedorAgente().longValue());
	           cstmt.setLong(6,gaVentasDTO.getNumUnidades().longValue());
	           cstmt.setTimestamp(7,gaVentasDTO.getFecVenta());
	           cstmt.setString(8,gaVentasDTO.getCodRegion());
	           cstmt.setString(9,gaVentasDTO.getCodProvincia());
	           cstmt.setString(10,gaVentasDTO.getCodCiudad());	    
	           cstmt.setString(11,gaVentasDTO.getIndEstVenta());
	           cstmt.setLong(12,gaVentasDTO.getNumTransaccion().longValue());
	           cstmt.setLong(13,gaVentasDTO.getIndPasoCob().longValue());
	           cstmt.setString(14,gaVentasDTO.getNomUsuarVta());
	           cstmt.setString(15,gaVentasDTO.getIndVenta());
	           cstmt.setString(16,gaVentasDTO.getCodMoneda());
	           cstmt.setString(17,gaVentasDTO.getCodCausaRec());
	           if (gaVentasDTO.getImpVenta()!=null)
	        	   cstmt.setDouble(18,gaVentasDTO.getImpVenta().doubleValue());
	           else
	        	   cstmt.setString(18,null);
	           cstmt.setString(19,gaVentasDTO.getCodTipContrato());
	           cstmt.setString(20,gaVentasDTO.getNumContrato());
	           if (gaVentasDTO.getIndOfiter().equals("T")){
	        	   /*Si el IND_OFITER=T osea una venta en terreno el indicador de venta es T
	        	    de lo contrario es 1 osea una venta en OFICINA*/
	        	   gaVentasDTO.setIndTipVenta(new Long(0)); 
	           }else{
	        	   gaVentasDTO.setIndTipVenta(new Long(1));
	           }
	        	   
	        	   
	           
	           cstmt.setLong(21,gaVentasDTO.getIndTipVenta().longValue());
	           cstmt.setLong(22,gaVentasDTO.getCodCliente().longValue());
	           cstmt.setLong(23,gaVentasDTO.getCodModVenta().longValue());
	           if( gaVentasDTO.getTipValor() != null )
	           {
	        	   cstmt.setLong(24,gaVentasDTO.getTipValor().longValue());
	           }else cstmt.setString(24,null);
	           cstmt.setString(25,gaVentasDTO.getCodCuota());
	           cstmt.setString(26,gaVentasDTO.getCodTipTarjeta());
	           cstmt.setString(27,gaVentasDTO.getNumTarjeta());
	           cstmt.setString(28,gaVentasDTO.getCodAutTarj());
	           cstmt.setDate(29,gaVentasDTO.getFecVenciTarj());
	           cstmt.setString(30,gaVentasDTO.getCodBancoTarj());
	           cstmt.setString(31,gaVentasDTO.getNumCTACORR());
	           cstmt.setString(32,gaVentasDTO.getNumCheque());
	           cstmt.setString(33,gaVentasDTO.getCodBanco());
	           cstmt.setString(34,gaVentasDTO.getCodSucursal());
	           cstmt.setDate(35,gaVentasDTO.getFecCumplimenta());
	           cstmt.setDate(36,gaVentasDTO.getFecRecDocum());
	           cstmt.setDate(37,gaVentasDTO.getFecAcePrec());
	           cstmt.setString(38,gaVentasDTO.getNomUsuarAcerec());
	           cstmt.setString(39,gaVentasDTO.getNomUsuarRecDoc());
	           cstmt.setString(40,gaVentasDTO.getNomUsuarCumpl());
	           cstmt.setLong(41,gaVentasDTO.getNumVenta().longValue());
	           cstmt.setString(42,gaVentasDTO.getIndOfiter());
	           cstmt.setString(43,gaVentasDTO.getIndChkDicom());
	           cstmt.setString(44,gaVentasDTO.getTipFoliacion());
	           cstmt.setString(45,gaVentasDTO.getCodTipDocumento());
	           cstmt.setString(46,gaVentasDTO.getCodOperadora());
	           cstmt.setString(47,gaVentasDTO.getCodPlaza());
	           cstmt.setString(48, (gaVentasDTO.getCodVenDealer()==null?null:gaVentasDTO.getCodVenDealer().toString()));
	           
	           
	            if (cat.isDebugEnabled()) {
					cat.debug(" Registrando salidas");
				}
				
	           //Se procede a descomentar cuando devuelva errores
	           cstmt.registerOutParameter(49, oracle.jdbc.driver.OracleTypes.NUMBER);
				cstmt.registerOutParameter(50, oracle.jdbc.driver.OracleTypes.VARCHAR);
	           cstmt.registerOutParameter(51, oracle.jdbc.driver.OracleTypes.NUMBER);
	           //Campos de devolución
	           cstmt.registerOutParameter(52, oracle.jdbc.driver.OracleTypes.NUMBER);
	           cstmt.registerOutParameter(53, oracle.jdbc.driver.OracleTypes.VARCHAR);
	           
	                       
				if (cat.isDebugEnabled()) {
					cat.debug(" Iniciando Ejecución");
				}

				cat.debug("Execute Antes");
	          
				cstmt.execute();
	          
				cat.debug("Execute Despues");

				if (cat.isDebugEnabled()) {
					cat.debug(" Finalizo ejecución");
					cat.debug(" Recuperando salidas");
				}
				// Recuperacion de valores de salida
	           
				
		        
			   codError =cstmt.getInt(49);
			   cat.debug("codError[" + codError + "]");
			   msgError = cstmt.getString(50);
			   cat.debug("msgError[" + msgError + "]");
	           numEvento = cstmt.getInt(51);
			   cat.debug("numEvento[" + numEvento + "]");
	           cstmt=null;	           
	           

	           if (codError != 0) {
					cat.error(" Ocurrió un error al generar registro de venta (ga_ventas)");
					throw new CustomerDomainException(String.valueOf(codError),
								numEvento, "Ocurrió un error al generar registro de venta (ga_ventas)"); 
				}
	           
	           cat.debug("Recuperando data...");

				cat.debug("Codigo Error PL[" + codError + "]");
			}catch (Exception e) {	                          
	           e.printStackTrace();
				cat.error("Ocurrió un error al generar registro de venta (ga_ventas)",e);
				if (cat.isDebugEnabled())
	            {
					cat.debug("Codigo de Error[" + codError + "]");
					cat.debug("Mensaje de Error[" + msgError + "]");
					cat.debug("Numero de Evento[" + numEvento + "]");
	            }				
				if (e instanceof CustomerDomainException ) throw (CustomerDomainException) e;	               
	           }
	        finally {
	               if (cat.isDebugEnabled()) 
	               {
	                   cat.debug("Cerrando conexiones...");
	               }
	               try {
                       if (cstmt!=null) {
                           cstmt.close();
                       } 	                       
                       if (!conn.isClosed()) {
                           conn.close();
                       }
	               }catch (SQLException e) 
	                   {
	                   // TODO Auto-generated catch block
	                   cat.debug("SQLException[" + e + "]");
	               }        
			}

	       if (cat.isDebugEnabled()) {
				cat.debug("insertVenta():end");
			}
		}
	    
	   
	   public String getNumUnidades(String numVenta)
	   		throws CustomerDomainException
	   {
			
		   if (cat.isDebugEnabled()) {
	           cat.debug("getNumUnidades():start");
	       }
	       int codError = 0;
	       String msgError = null;
	       int numEvento = 0;
	       
	       String call=null;
	       String numUnidades=null;
	       Connection conn = null;
	       CallableStatement cstmt=null;
	       //se recuepera coneccion del DataSources
	       try {
				conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			} 
	       catch (Exception e1) {
				cat.error(" No se pudo obtener una conexión ", e1);
				throw new CustomerDomainException("No se pudo obtener una conexión",e1);
			}
	       try {
				
	           call=getSQLgetNumUnidades();
	       	if (cat.isDebugEnabled()) {
					cat.debug("sql[" + call + "]");
				}
				cstmt = conn.prepareCall(call);
	           
	           if (cat.isDebugEnabled()) {
					cat.debug("Registrando Entradas");				
				}
	           cstmt.setString(1,numVenta);
	           
	           if (cat.isDebugEnabled()) {
					cat.debug(" Registrando salidas");
				}
				//Se procede a descomentar cuando devuelva errores
	           cstmt.registerOutParameter(2, oracle.jdbc.driver.OracleTypes.NUMBER);
				cstmt.registerOutParameter(3, oracle.jdbc.driver.OracleTypes.VARCHAR);
	           cstmt.registerOutParameter(4, oracle.jdbc.driver.OracleTypes.NUMBER);
	           
	           //Campos de devolución
	           cstmt.registerOutParameter(5, oracle.jdbc.driver.OracleTypes.NUMBER);
	                       
				if (cat.isDebugEnabled()) {
					cat.debug(" Iniciando Ejecución");
				}

				cat.debug("Execute Antes");
	          
				cstmt.execute();
	          
				cat.debug("Execute Despues");

				if (cat.isDebugEnabled()) {
					cat.debug(" Finalizo ejecución");
					cat.debug(" Recuperando salidas");
				}
				// Recuperacion de valores de salida
	           
				numUnidades=Integer.toString(cstmt.getInt(5));
	           
		        
				codError =cstmt.getInt(2);
				cat.debug("codError[" + codError + "]");
				msgError = cstmt.getString(3);
				cat.debug("msgError[" + msgError + "]");
	           numEvento = cstmt.getInt(4);
				cat.debug("numEvento[" + numEvento + "]");
	           cstmt=null;

	        

	           if (codError != 0) {
					cat.error(" Ocurrió un error al recuperar codigo de despacho");
					throw new CustomerDomainException(String.valueOf(codError),
								numEvento, msgError); 
				}
	           
	           cat.debug("Recuperando data...");

				cat.debug("Numero Unidades[" + numUnidades + "]");
				
			} catch (CustomerDomainException e) {
	          
	           e.printStackTrace();
	           cat.error("Ocurrió un error general al Recuperar el numero de Unidades",e);
				if (cat.isDebugEnabled()) {
					cat.debug("Codigo de Error[" + codError + "]");
					cat.debug("Mensaje de Error[" + msgError + "]");
					cat.debug("Numero de Evento[" + numEvento + "]");
				}
				throw e;
			}catch (Exception e) 
	           {
	                         
	           e.printStackTrace();
				cat.error("Ocurrió un error general al recuperar numero de unidades",e);
				if (cat.isDebugEnabled())
	                {
					cat.debug("Codigo de Error[" + codError + "]");
					cat.debug("Mensaje de Error[" + msgError + "]");
					cat.debug("Numero de Evento[" + numEvento + "]");
	               }
	                 throw new CustomerDomainException(
						"Ocurrió un error general  al recuperar numero de unidades",e);
	               
	           }
	           finally {
	               if (cat.isDebugEnabled()) 
	               {
	                   cat.debug("Cerrando conexiones...");
	               }
	               try {
	                       if (cstmt!=null){
	                           cstmt.close();
	                           } 
	                       
	                       if (!conn.isClosed())
	                       {
	                           conn.close();
	                       }
	                   }
	               catch (SQLException e) 
	                   {
	                   // TODO Auto-generated catch block
	                   cat.debug("SQLException[" + e + "]");
	                   }        
			}

	       if (cat.isDebugEnabled()) {
				cat.debug("getCodestadoFinalVenta():end");
			}
	   
	       return numUnidades;

	   }
	   
	   
	 public Long getCodPlazaCliente(Long CodCliente)
	 	throws CustomerDomainException
	 {
			
		   if (cat.isDebugEnabled()) {
	           cat.debug("getCodPlazaCliente():start");
	       }
	       int codError = 0;
	       String msgError = null;
	       int numEvento = 0;
	       
	       String call=null;
	       Long codPlazaCliente=null;
	       Connection conn = null;
	       CallableStatement cstmt=null;
	       //se recuepera coneccion del DataSources
	       try {
				conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			} 
	       catch (Exception e1) {
				cat.error(" No se pudo obtener una conexión ", e1);
				throw new CustomerDomainException("No se pudo obtener una conexión",e1);
			}
	       try {
				
	    	   call="{call VE_intermediario_PG.VE_ObtienePlaza_Cliente_PR(?,?,?,?,?)}";
	       	if (cat.isDebugEnabled()) {
					cat.debug("sql[" + call + "]");
				}
				cstmt = conn.prepareCall(call);
	           
	           if (cat.isDebugEnabled()) {
					cat.debug("Registrando Entradas");				
				}
	           cstmt.setLong(1,CodCliente.longValue());
	           
	           if (cat.isDebugEnabled()) {
					cat.debug(" Registrando salidas");
				}
				//Se procede a descomentar cuando devuelva errores
	           
	           cstmt.registerOutParameter(2, oracle.jdbc.driver.OracleTypes.NUMBER);
	           cstmt.registerOutParameter(3, oracle.jdbc.driver.OracleTypes.NUMBER);
	           cstmt.registerOutParameter(4, oracle.jdbc.driver.OracleTypes.VARCHAR);
	           cstmt.registerOutParameter(5, oracle.jdbc.driver.OracleTypes.NUMBER);
	                       
				if (cat.isDebugEnabled()) {
					cat.debug(" Iniciando Ejecución");
				}

				cat.debug("Execute Antes");
	          
				cstmt.execute();
	          
				cat.debug("Execute Despues");

				if (cat.isDebugEnabled()) {
					cat.debug(" Finalizo ejecución");
					cat.debug(" Recuperando salidas");
				}
				// Recuperacion de valores de salida
	           
				
	            
				codError =cstmt.getInt(3);
				cat.debug("codError[" + codError + "]");
				msgError = cstmt.getString(4);
				cat.debug("msgError[" + msgError + "]");
	           numEvento = cstmt.getInt(5);
				cat.debug("numEvento[" + numEvento + "]");
	           

	         
	           if (codError != 0) {
					cat.error(" Ocurrió un error al recuperar codigo de despacho");
					throw new CustomerDomainException(String.valueOf(codError),
								numEvento, msgError); 
				}
	           else
	        	   codPlazaCliente=new Long(cstmt.getLong(2));
	           
	           cat.debug("Recuperando data...");

				cat.debug("Codigo Plaza por Cliente[" + codPlazaCliente + "]");
				
			} catch (CustomerDomainException e) {
	          
	           e.printStackTrace();
	           cat.error("Ocurrió un error general al Recuperar el Código Plaza por cliente",e);
				if (cat.isDebugEnabled()) {
					cat.debug("Codigo de Error[" + codError + "]");
					cat.debug("Mensaje de Error[" + msgError + "]");
					cat.debug("Numero de Evento[" + numEvento + "]");
				}
				throw e;
			}catch (Exception e) 
	           {
	                         
	           e.printStackTrace();
				cat.error("Ocurrió un error general al recuperar Código Plaza por cliente",e);
				if (cat.isDebugEnabled())
	                {
					cat.debug("Codigo de Error[" + codError + "]");
					cat.debug("Mensaje de Error[" + msgError + "]");
					cat.debug("Numero de Evento[" + numEvento + "]");
	               }
	                 throw new CustomerDomainException(
						"Ocurrió un error general  al recuperar Código Plaza por cliente",e);
	               
	           }
	           finally {
	               if (cat.isDebugEnabled()) 
	               {
	                   cat.debug("Cerrando conexiones...");
	               }
	               try {
	                       if (cstmt!=null){
	                           cstmt.close();
	                           } 
	                       
	                       if (!conn.isClosed())
	                       {
	                           conn.close();
	                       }
	                   }
	               catch (SQLException e) 
	                   {
	                   // TODO Auto-generated catch block
	                   cat.debug("SQLException[" + e + "]");
	                   }        
			}

	       if (cat.isDebugEnabled()) {
				cat.debug("getCodestadoFinalVenta():end");
			}
	   
	       return codPlazaCliente;

	   } 	
 
	 public String getCodPlazaOficina(String CodOficina)
	 	throws CustomerDomainException
	 {
			
		   if (cat.isDebugEnabled()) {
	           cat.debug("getCodPlazaOficina():start");
	       }
	       int codError = 0;
	       String msgError = null;
	       int numEvento = 0;
	       
	       String call=null;
	       String codPlazaOficina=null;
	       Connection conn = null;
	       CallableStatement cstmt=null;
	       //se recuepera coneccion del DataSources
	       try {
				conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			} 
	       catch (Exception e1) {
				cat.error(" No se pudo obtener una conexión ", e1);
				throw new CustomerDomainException("No se pudo obtener una conexión",e1);
			}
	       try {
				
	           call="{call VE_intermediario_PG.VE_ObtienePlaza_Oficina_PR(?,?,?,?,?)}";
	          
	       	if (cat.isDebugEnabled()) {
					cat.debug("sql[" + call + "]");
				}
				cstmt = conn.prepareCall(call);
	           
	           if (cat.isDebugEnabled()) {
					cat.debug("Registrando Entradas");				
				}
	           cstmt.setString(1,CodOficina);
	           
	           if (cat.isDebugEnabled()) {
					cat.debug(" Registrando salidas");
				}
				//Se procede a descomentar cuando devuelva errores
	           
	           cstmt.registerOutParameter(2, oracle.jdbc.driver.OracleTypes.VARCHAR); //Codigo de Plaza Formato ejemplo 001
					           
	           //Campos de devolución
	           cstmt.registerOutParameter(3, oracle.jdbc.driver.OracleTypes.NUMBER);
	           cstmt.registerOutParameter(4, oracle.jdbc.driver.OracleTypes.VARCHAR);
	           cstmt.registerOutParameter(5, oracle.jdbc.driver.OracleTypes.NUMBER);
	                       
				if (cat.isDebugEnabled()) {
					cat.debug(" Iniciando Ejecución");
				}

				cat.debug("Execute Antes");
	         
				cstmt.execute();
	          
				cat.debug("Execute Despues");

				if (cat.isDebugEnabled()) {
					cat.debug(" Finalizo ejecución");
					cat.debug(" Recuperando salidas");
				}
				// Recuperacion de valores de salida
	           
				codPlazaOficina=cstmt.getString(2);
	            
				codError =cstmt.getInt(3);
				cat.debug("codError[" + codError + "]");
				msgError = cstmt.getString(4);
				cat.debug("msgError[" + msgError + "]");
	           numEvento = cstmt.getInt(5);
				cat.debug("numEvento[" + numEvento + "]");
	           cstmt=null;

	       
	           if (codError != 0) {
					cat.error(" Ocurrió un error al recuperar codigo plaza Oficina");
					throw new CustomerDomainException(String.valueOf(codError),
								numEvento, msgError); 
				}
	           
	           cat.debug("Recuperando data...");

				cat.debug("Codigo Plaza por Oficina[" + codPlazaOficina + "]");
				
			} catch (CustomerDomainException e) {
	           
	           e.printStackTrace();
	           cat.error("Ocurrió un error general al Recuperar el Código Plaza por oficina",e);
				if (cat.isDebugEnabled()) {
					cat.debug("Codigo de Error[" + codError + "]");
					cat.debug("Mensaje de Error[" + msgError + "]");
					cat.debug("Numero de Evento[" + numEvento + "]");
				}
				throw e;
			}catch (Exception e) 
	           {
	         
	           e.printStackTrace();
				cat.error("Ocurrió un error general al recuperar Código Plaza por oficina",e);
				if (cat.isDebugEnabled())
	                {
					cat.debug("Codigo de Error[" + codError + "]");
					cat.debug("Mensaje de Error[" + msgError + "]");
					cat.debug("Numero de Evento[" + numEvento + "]");
	               }
	                 throw new CustomerDomainException(
						"Ocurrió un error general  al recuperar Código Plaza por oficina",e);
	               
	           }
	           finally {
	               if (cat.isDebugEnabled()) 
	               {
	                   cat.debug("Cerrando conexiones...");
	               }
	               try {
	                       if (cstmt!=null){
	                           cstmt.close();
	                           } 
	                       
	                       if (!conn.isClosed())
	                       {
	                           conn.close();
	                       }
	                   }
	               catch (SQLException e) 
	                   {
	                   // TODO Auto-generated catch block
	                   cat.debug("SQLException[" + e + "]");
	                   }        
			}

	       if (cat.isDebugEnabled()) {
				cat.debug("getCodestadoFinalVenta():end");
			}
	   
	       return codPlazaOficina;

	   } 	
	 public void updateVentasEscenarioB(GaVentasDTO gaVentasDTO)
	 	throws CustomerDomainException
	 {
			
		   if (cat.isDebugEnabled()) {
	           cat.debug("updateVentasEscenarioB():start");
	       }
	       int codError = 0;
	       String msgError = null;
	       int numEvento = 0;
	       
	       String call=null;
	       Connection conn = null;
	       CallableStatement cstmt=null;
	       //se recuepera coneccion del DataSources
	       try {
				conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			} 
	       catch (Exception e1) {
				cat.error(" No se pudo obtener una conexión ", e1);
				throw new CustomerDomainException("No se pudo obtener una conexión",e1);
			}
	       try {
			   call=getSQLUpdateVentaEscenarioB();
	       	if (cat.isDebugEnabled()) {
					cat.debug("sql[" + call + "]");
				}
				cstmt = conn.prepareCall(call);
	           
	           if (cat.isDebugEnabled()) {
					cat.debug("Registrando Entradas");				
				}
	           
	           cstmt.setString(1,gaVentasDTO.getIndEstVenta());
	           cstmt.setLong(2,gaVentasDTO.getNumTransaccion().longValue());
	           cstmt.setLong(3,gaVentasDTO.getTipValor().longValue());
	           cstmt.setDouble(4,gaVentasDTO.getImpVenta().doubleValue());
	           cstmt.setString(5,gaVentasDTO.getNumContrato());
	           cstmt.setLong(6,gaVentasDTO.getNumVenta().longValue());
	           	   
	           if (cat.isDebugEnabled()) {
					cat.debug(" Registrando salidas");
				}
				//Se procede a descomentar cuando devuelva errores
	           
	           cstmt.registerOutParameter(6, oracle.jdbc.driver.OracleTypes.NUMBER);
				cstmt.registerOutParameter(7, oracle.jdbc.driver.OracleTypes.VARCHAR);
	           cstmt.registerOutParameter(8, oracle.jdbc.driver.OracleTypes.NUMBER);
	           
	           
	           //Campos de devolución
	           
	                       
				if (cat.isDebugEnabled()) {
					cat.debug(" Iniciando Ejecución");
				}

				cat.debug("Execute Antes");
	     
				cstmt.execute();
	          
				cat.debug("Execute Despues");

				if (cat.isDebugEnabled()) {
					cat.debug(" Finalizo ejecución");
					cat.debug(" Recuperando salidas");
				}
				// Recuperacion de valores de salida
	           
				
	            
				codError =cstmt.getInt(6);
				cat.debug("codError[" + codError + "]");
				msgError = cstmt.getString(7);
				cat.debug("msgError[" + msgError + "]");
	           numEvento = cstmt.getInt(8);
				cat.debug("numEvento[" + numEvento + "]");
	           cstmt=null;

	         

	           if (codError != 0) {
					cat.error(" Ocurrió un error al Insertar Escenario B");
					throw new CustomerDomainException(String.valueOf(codError),
								numEvento, msgError); 
				}
	           
	           cat.debug("Recuperando data...");

				cat.debug("Codigo error Escenario B[" + codError + "]");
				
			} catch (CustomerDomainException e) {
	           
	           e.printStackTrace();
	           cat.error("Ocurrió un error general al  Insertar Escenario B",e);
				if (cat.isDebugEnabled()) {
					cat.debug("Codigo de Error[" + codError + "]");
					cat.debug("Mensaje de Error[" + msgError + "]");
					cat.debug("Numero de Evento[" + numEvento + "]");
				}
				throw e;
			}catch (Exception e) 
	           {
	         
	           e.printStackTrace();
				cat.error("Ocurrió un error general al  Insertar Escenario B",e);
				if (cat.isDebugEnabled())
	                {
					cat.debug("Codigo de Error[" + codError + "]");
					cat.debug("Mensaje de Error[" + msgError + "]");
					cat.debug("Numero de Evento[" + numEvento + "]");
	               }
	                 throw new CustomerDomainException(
						"Ocurrió un error general  al  Insertar Escenario B",e);
	               
	           }
	           finally {
	               if (cat.isDebugEnabled()) 
	               {
	                   cat.debug("Cerrando conexiones...");
	               }
	               try {
	                       if (cstmt!=null){
	                           cstmt.close();
	                           } 
	                       
	                       if (!conn.isClosed())
	                       {
	                           conn.close();
	                       }
	                   }
	               catch (SQLException e) 
	                   {
	                   // TODO Auto-generated catch block
	                   cat.debug("SQLException[" + e + "]");
	                   }        
			}

	       if (cat.isDebugEnabled()) {
				cat.debug("updateVentasEscenarioB():end");
			}
	   }
	 public void updateVentasEscenarioC(GaVentasDTO gaVentasDTO)
	 	throws CustomerDomainException
	 {
			
		   if (cat.isDebugEnabled()) {
	           cat.debug("updateVentasEscenarioC():start");
	       }
	       int codError = 0;
	       String msgError = null;
	       int numEvento = 0;
	       
	       String call=null;
	       Connection conn = null;
	       CallableStatement cstmt=null;
	       //se recuepera coneccion del DataSources
	       try {
				conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			} 
	       catch (Exception e1) {
				cat.error(" No se pudo obtener una conexión ", e1);
				throw new CustomerDomainException("No se pudo obtener una conexión",e1);
			}
	       try {
			   call=getSQLUpdateVentaEscenarioC();
	       	if (cat.isDebugEnabled()) {
					cat.debug("sql[" + call + "]");
				}
				cstmt = conn.prepareCall(call);
	           
	           if (cat.isDebugEnabled()) {
					cat.debug("Registrando Entradas");				
				}
	           
	           cstmt.setString(1,gaVentasDTO.getIndEstVenta());
	           cstmt.setLong(2,gaVentasDTO.getNumTransaccion().longValue());
	           cstmt.setLong(3,gaVentasDTO.getTipValor().longValue());
	           cstmt.setDouble(4,gaVentasDTO.getImpVenta().doubleValue());
	           cstmt.setString(5,gaVentasDTO.getNumContrato());
	           	   
	           if (cat.isDebugEnabled()) {
					cat.debug(" Registrando salidas");
				}
				//Se procede a descomentar cuando devuelva errores
	           
	           cstmt.registerOutParameter(6, oracle.jdbc.driver.OracleTypes.NUMBER);
				cstmt.registerOutParameter(7, oracle.jdbc.driver.OracleTypes.VARCHAR);
	           cstmt.registerOutParameter(8, oracle.jdbc.driver.OracleTypes.NUMBER);
	           
	           
	           //Campos de devolución
	           
	                       
				if (cat.isDebugEnabled()) {
					cat.debug(" Iniciando Ejecución");
				}

				cat.debug("Execute Antes");
	          
				cstmt.execute();
	           
				cat.debug("Execute Despues");

				if (cat.isDebugEnabled()) {
					cat.debug(" Finalizo ejecución");
					cat.debug(" Recuperando salidas");
				}
				// Recuperacion de valores de salida
	           
				
	            
				codError =cstmt.getInt(6);
				cat.debug("codError[" + codError + "]");
				msgError = cstmt.getString(7);
				cat.debug("msgError[" + msgError + "]");
	           numEvento = cstmt.getInt(8);
				cat.debug("numEvento[" + numEvento + "]");
	           cstmt=null;

	          
	           if (codError != 0) {
					cat.error(" Ocurrió un error al Insertar Escenario C");
					throw new CustomerDomainException(String.valueOf(codError),
								numEvento, msgError); 
				}
	           
	           cat.debug("Recuperando data...");

				cat.debug("Codigo error Escenario C[" + codError + "]");
				
			} catch (CustomerDomainException e) {

	           e.printStackTrace();
	           cat.error("Ocurrió un error general al  Insertar Escenario C",e);
				if (cat.isDebugEnabled()) {
					cat.debug("Codigo de Error[" + codError + "]");
					cat.debug("Mensaje de Error[" + msgError + "]");
					cat.debug("Numero de Evento[" + numEvento + "]");
				}
				throw e;
			}catch (Exception e) 
	           {
	           e.printStackTrace();
				cat.error("Ocurrió un error general al  Insertar Escenario C",e);
				if (cat.isDebugEnabled())
	                {
					cat.debug("Codigo de Error[" + codError + "]");
					cat.debug("Mensaje de Error[" + msgError + "]");
					cat.debug("Numero de Evento[" + numEvento + "]");
	               }
	                 throw new CustomerDomainException(
						"Ocurrió un error general  al  Insertar Escenario C",e);
	               
	           }
	           finally {
	               if (cat.isDebugEnabled()) 
	               {
	                   cat.debug("Cerrando conexiones...");
	               }
	               try {
	                       if (cstmt!=null){
	                           cstmt.close();
	                           } 
	                       
	                       if (!conn.isClosed())
	                       {
	                           conn.close();
	                       }
	                   }
	               catch (SQLException e) 
	                   {
	                   // TODO Auto-generated catch block
	                   cat.debug("SQLException[" + e + "]");
	                   }        
			}

	       if (cat.isDebugEnabled()) {
				cat.debug("updateVentasEscenarioC():end");
			}
	   }
	 public void updateVentasEscenarioD(GaVentasDTO gaVentasDTO)
	 	throws CustomerDomainException
	 {
			
		   if (cat.isDebugEnabled()) {
	           cat.debug("updateVentasEscenarioD():start");
	       }
	       int codError = 0;
	       String msgError = null;
	       int numEvento = 0;
	       
	       String call=null;
	       Connection conn = null;
	       CallableStatement cstmt=null;
	       //se recuepera coneccion del DataSources
	       try {
				conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			} 
	       catch (Exception e1) {
				cat.error(" No se pudo obtener una conexión ", e1);
				throw new CustomerDomainException("No se pudo obtener una conexión",e1);
			}
	       try {
			   call=getSQLUpdateVentaEscenarioD();
	       	if (cat.isDebugEnabled()) {
					cat.debug("sql[" + call + "]");
				}
				cstmt = conn.prepareCall(call);
	           
	           if (cat.isDebugEnabled()) {
					cat.debug("Registrando Entradas");				
				}
	           
	           cstmt.setString(1,gaVentasDTO.getIndEstVenta());
	           cstmt.setLong(2,gaVentasDTO.getNumTransaccion().longValue());
	           cstmt.setDouble(3,gaVentasDTO.getImpVenta().doubleValue());
	           cstmt.setString(4,gaVentasDTO.getNumContrato());
	           cstmt.setLong(5,gaVentasDTO.getNumVenta().longValue());
	           	   
	           if (cat.isDebugEnabled()) {
					cat.debug(" Registrando salidas");
				}
				//Se procede a descomentar cuando devuelva errores
	           
	           cstmt.registerOutParameter(6, oracle.jdbc.driver.OracleTypes.NUMBER);
				cstmt.registerOutParameter(7, oracle.jdbc.driver.OracleTypes.VARCHAR);
	           cstmt.registerOutParameter(8, oracle.jdbc.driver.OracleTypes.NUMBER);
	           
	           
	           //Campos de devolución
	           
	                       
				if (cat.isDebugEnabled()) {
					cat.debug(" Iniciando Ejecución");
				}

				cat.debug("Execute Antes");

				cstmt.execute();

				cat.debug("Execute Despues");

				if (cat.isDebugEnabled()) {
					cat.debug(" Finalizo ejecución");
					cat.debug(" Recuperando salidas");
				}
				// Recuperacion de valores de salida
	           
				
	            
				codError =cstmt.getInt(6);
				cat.debug("codError[" + codError + "]");
				msgError = cstmt.getString(7);
				cat.debug("msgError[" + msgError + "]");
	           numEvento = cstmt.getInt(8);
				cat.debug("numEvento[" + numEvento + "]");
	           cstmt=null;

	           if (codError != 0) {
					cat.error(" Ocurrió un error al Insertar Escenario D");
					throw new CustomerDomainException(String.valueOf(codError),
								numEvento, msgError); 
				}
	           
	           cat.debug("Recuperando data...");

				cat.debug("Codigo error Escenario D[" + codError + "]");
				
			} catch (CustomerDomainException e) {
	           e.printStackTrace();
	           cat.error("Ocurrió un error general al  Insertar Escenario D",e);
				if (cat.isDebugEnabled()) {
					cat.debug("Codigo de Error[" + codError + "]");
					cat.debug("Mensaje de Error[" + msgError + "]");
					cat.debug("Numero de Evento[" + numEvento + "]");
				}
				throw e;
			}catch (Exception e) 
	           {
	           e.printStackTrace();
				cat.error("Ocurrió un error general al  Insertar Escenario D",e);
				if (cat.isDebugEnabled())
	                {
					cat.debug("Codigo de Error[" + codError + "]");
					cat.debug("Mensaje de Error[" + msgError + "]");
					cat.debug("Numero de Evento[" + numEvento + "]");
	               }
	                 throw new CustomerDomainException(
						"Ocurrió un error general  al  Insertar Escenario D",e);
	               
	           }
	           finally {
	               if (cat.isDebugEnabled()) 
	               {
	                   cat.debug("Cerrando conexiones...");
	               }
	               try {
	                       if (cstmt!=null){
	                           cstmt.close();
	                           } 
	                       
	                       if (!conn.isClosed())
	                       {
	                           conn.close();
	                       }
	                   }
	               catch (SQLException e) 
	                   {
	                   // TODO Auto-generated catch block
	                   cat.debug("SQLException[" + e + "]");
	                   }        
			}

	       if (cat.isDebugEnabled()) {
				cat.debug("updateVentasEscenarioD():end");
			}
	   }
	 public void updateVentasEscenarioA(GaVentasDTO gaVentasDTO)
	 	throws CustomerDomainException
	 {
			
		   if (cat.isDebugEnabled()) {
	           cat.debug("updateVentasEscenarioA():start");
	       }
	       int codError = 0;
	       String msgError = null;
	       int numEvento = 0;
	       
	       String call=null;
	       Connection conn = null;
	       CallableStatement cstmt=null;
	       //se recuepera coneccion del DataSources
	       try {
				conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			} 
	       catch (Exception e1) {
				cat.error(" No se pudo obtener una conexión ", e1);
				throw new CustomerDomainException("No se pudo obtener una conexión",e1);
			}
	       try {
			   call=getSQLUpdateVentaEscenarioA();
	       	if (cat.isDebugEnabled()) {
					cat.debug("sql[" + call + "]");
				}
				cstmt = conn.prepareCall(call);
	           
	           if (cat.isDebugEnabled()) {
					cat.debug("Registrando Entradas");				
				}
	           
	           cstmt.setString(1,gaVentasDTO.getIndEstVenta());
	           cstmt.setLong(2,gaVentasDTO.getNumTransaccion().longValue());
	           cstmt.setLong(3,gaVentasDTO.getTipValor().longValue());
	           cstmt.setDouble(4,gaVentasDTO.getImpVenta().doubleValue());
	           cstmt.setString(5,gaVentasDTO.getNumContrato());
	           cstmt.setLong(6,gaVentasDTO.getNumVenta().longValue());
	           	   
	           if (cat.isDebugEnabled()) {
					cat.debug(" Registrando salidas");
				}
				//Se procede a descomentar cuando devuelva errores
	           
	           cstmt.registerOutParameter(7, oracle.jdbc.driver.OracleTypes.NUMBER);
				cstmt.registerOutParameter(8, oracle.jdbc.driver.OracleTypes.VARCHAR);
	           cstmt.registerOutParameter(9, oracle.jdbc.driver.OracleTypes.NUMBER);
	           
	           
	           //Campos de devolución
	           
	                       
				if (cat.isDebugEnabled()) {
					cat.debug(" Iniciando Ejecución");
				}

				cat.debug("Execute Antes");
				cstmt.execute();
				cat.debug("Execute Despues");

				if (cat.isDebugEnabled()) {
					cat.debug(" Finalizo ejecución");
					cat.debug(" Recuperando salidas");
				}
				// Recuperacion de valores de salida
	           
				
	            
				codError =cstmt.getInt(7);
				cat.debug("codError[" + codError + "]");
				msgError = cstmt.getString(8);
				cat.debug("msgError[" + msgError + "]");
	           numEvento = cstmt.getInt(9);
				cat.debug("numEvento[" + numEvento + "]");
	           cstmt=null;

	           
	           if (codError != 0) {
					cat.error(" Ocurrió un error al Insertar Escenario A");
					throw new CustomerDomainException(String.valueOf(codError),
								numEvento, msgError); 
				}
	           
	           cat.debug("Recuperando data...");

				cat.debug("Codigo error Escenario A[" + codError + "]");
				
			} catch (CustomerDomainException e) {
	           
	           e.printStackTrace();
	           cat.error("Ocurrió un error general al  Insertar Escenario A",e);
				if (cat.isDebugEnabled()) {
					cat.debug("Codigo de Error[" + codError + "]");
					cat.debug("Mensaje de Error[" + msgError + "]");
					cat.debug("Numero de Evento[" + numEvento + "]");
				}
				throw e;
			}catch (Exception e) 
	           {
	            e.printStackTrace();
				cat.error("Ocurrió un error general al  Insertar Escenario A",e);
				if (cat.isDebugEnabled())
	                {
					cat.debug("Codigo de Error[" + codError + "]");
					cat.debug("Mensaje de Error[" + msgError + "]");
					cat.debug("Numero de Evento[" + numEvento + "]");
	               }
	                 throw new CustomerDomainException(
						"Ocurrió un error general  al  Insertar Escenario A",e);
	               
	           }
	           finally {
	               if (cat.isDebugEnabled()) 
	               {
	                   cat.debug("Cerrando conexiones...");
	               }
	               try {
	                       if (cstmt!=null){
	                           cstmt.close();
	                           } 
	                       
	                       if (!conn.isClosed())
	                       {
	                           conn.close();
	                       }
	                   }
	               catch (SQLException e) 
	                   {
	                   // TODO Auto-generated catch block
	                   cat.debug("SQLException[" + e + "]");
	                   }        
			}

	       if (cat.isDebugEnabled()) {
				cat.debug("updateVentasEscenarioA():end");
			}
	   }
	 
	 public void updateVenta(GaVentasDTO gaVentasDTO)
	 	throws CustomerDomainException
	 {
		 
		 if (cat.isDebugEnabled()) {
			 cat.debug("updateVenta():start");
		 }
		 int codError = 0;
		 String msgError = null;
		 int numEvento = 0;
		 
		 String call=null;
		 Connection conn = null;
		 CallableStatement cstmt=null;
		 conn = getConection();
		 try {
			 call=getSQLUpdate();
			 if (cat.isDebugEnabled()) {
				 cat.debug("sql[" + call + "]");
			 }
			 cstmt = conn.prepareCall(call);
			 
			 if (cat.isDebugEnabled()) {
				 cat.debug("Registrando Entradas");				
			 }
			 
			 //cstmt.setDouble(1,gaVentasDTO.getImpVenta().doubleValue());
			 cat.debug("Asi es con Float " + gaVentasDTO.getImpVentaS());
			 cat.debug("Asi es con double " + gaVentasDTO.getImpVentaS());
			 cat.debug("Asi es con long " + gaVentasDTO.getImpVentaS());
			 
			 cstmt.setString(1,gaVentasDTO.getImpVentaS());
			 cstmt.setLong(2,gaVentasDTO.getNumVenta().longValue());
			 
			 if (cat.isDebugEnabled()) {
				 cat.debug(" Registrando salidas");
			 }
			 //Se procede a descomentar cuando devuelva errores
			 
			 cstmt.registerOutParameter(3, oracle.jdbc.driver.OracleTypes.NUMBER);
			 cstmt.registerOutParameter(4, oracle.jdbc.driver.OracleTypes.VARCHAR);
			 cstmt.registerOutParameter(5, oracle.jdbc.driver.OracleTypes.NUMBER);
			 
			 
			 //Campos de devolución
			 
			 
			 if (cat.isDebugEnabled()) {
				 cat.debug(" Iniciando Ejecución");
			 }
			 
			 cat.debug("Execute Antes");
			 cstmt.execute();
			 cat.debug("Execute Despues");
			 
			 if (cat.isDebugEnabled()) {
				 cat.debug(" Finalizo ejecución");
				 cat.debug(" Recuperando salidas");
			 }
			 // Recuperacion de valores de salida
			 
			 
			 
			 codError =cstmt.getInt(3);
			 cat.debug("codError[" + codError + "]");
			 msgError = cstmt.getString(4);
			 cat.debug("msgError[" + msgError + "]");
			 numEvento = cstmt.getInt(5);
			 cat.debug("numEvento[" + numEvento + "]");
			 cstmt=null;
			 
			 if (codError != 0) {
				 cat.error(" Ocurrió un error general al realizar update de la venta");
				 throw new CustomerDomainException(String.valueOf(codError),
						 numEvento, msgError); 
			 }
			 
			 cat.debug("Recuperando data...");
			 
			 cat.debug("Codigo error[" + codError + "]");
			 
		 } catch (CustomerDomainException e) {
			 e.printStackTrace();
			 cat.error("Ocurrió un error general al realizar update de la venta",e);
			 if (cat.isDebugEnabled()) {
				 cat.debug("Codigo de Error[" + codError + "]");
				 cat.debug("Mensaje de Error[" + msgError + "]");
				 cat.debug("Numero de Evento[" + numEvento + "]");
			 }
			 throw e;
		 }catch (Exception e) 
		 {
			 e.printStackTrace();
			 cat.error("Ocurrió un error general al realizar update de la venta",e);
			 if (cat.isDebugEnabled())
			 {
				 cat.debug("Codigo de Error[" + codError + "]");
				 cat.debug("Mensaje de Error[" + msgError + "]");
				 cat.debug("Numero de Evento[" + numEvento + "]");
			 }
			 throw new CustomerDomainException(
					 "Ocurrió un error general al realizar update de la venta",e);
			 
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
		 
		 if (cat.isDebugEnabled()) {
			 cat.debug("updateVenta():end");
		 }
	 }
	 
		/**
		 * Obtiene numMDN
		 * @param entrada
		 * @return entrada
		 * @throws CustomerDomainException
		 */
		public RegistroVentaDTO getMinMDN(RegistroVentaDTO entrada) 
			throws CustomerDomainException
		{
			RegistroVentaDTO resultado= null;
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			conn = getConection();
			CallableStatement cstmt = null; 
			try {
				cat.debug("Inicio:getMinMDN");
				
				String call = getSQLDatosVenta("VE_intermediario_PG","VE_getMinMDN_PR",5);

				cat.debug("sql[" + call + "]");

				cstmt = conn.prepareCall(call);
				
				cstmt.setLong(1,entrada.getNumeroCelular());

				cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
				
				cat.debug("Inicio:getMinMDN:execute");
				cstmt.execute();
				cat.debug("Fin:getMinMDN:execute");

				codError=cstmt.getInt(3);
				msgError = cstmt.getString(4);
				numEvento=cstmt.getInt(5);

				cat.debug("Código Error: " +  cstmt.getInt(3));
				cat.debug("msgError: " +  cstmt.getString(4));
				cat.debug("numEvento: " +  cstmt.getInt(5));
				
				if (codError != 0){
					cat.error("Ocurrió un error al obtener minMDN");
					throw new CustomerDomainException(
					"Ocurrió un error al obtener minMDN", String
					.valueOf(codError), numEvento, msgError);
				}
				else{
					resultado = entrada;
					resultado.setMinMDN(cstmt.getString(2));
				}
				
			} catch (Exception e) {
				cat.error("Ocurrió un error al obtener minMDN",e);
				if (cat.isDebugEnabled()) {
					cat.debug("Codigo de Error[" + codError + "]");
					cat.debug("Mensaje de Error[" + msgError + "]");
					cat.debug("Numero de Evento[" + numEvento + "]");
					if (e instanceof CustomerDomainException)
						throw (CustomerDomainException)e;
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
			cat.debug("Fin:getMinMDN");
			return resultado;
		}//fin getMinMDN

		public LstVtaRegistroResultadoDTO getListVentas(RegistroVentaDTO entrada) 
			throws CustomerDomainException
		{
			LstVtaRegistroResultadoDTO resultado = null;
			LstVtaRegistroVentaOutDTO[] registroVentas = null;
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			conn = getConection();
			CallableStatement cstmt = null;
			ResultSet rs = null;
			try {
				
				cat.debug("Inicio:getListVentas");
				
				String call = getSQLDatosVenta("Ve_Servs_ActivacionesWeb_Pg","VE_getListVentas_PR",12);
				cat.debug("sql[" + call + "]");
				
				cstmt = conn.prepareCall(call);
				
				cstmt.setString(1,entrada.getCodigo_vendedor());
				cstmt.setString(2,entrada.getCodigo_vendedor_dealer());
				cstmt.setString(3,entrada.getCanal_vendedor());
				cstmt.setString(4,entrada.getFecha_desde());
				cstmt.setString(5,entrada.getFecha_hasta());
				cstmt.setInt(6,entrada.getFiltro());
				cstmt.registerOutParameter(7,OracleTypes.CURSOR);
				cstmt.registerOutParameter(8,java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(9,java.sql.Types.VARCHAR);
				
				
				cstmt.registerOutParameter(10,java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(11,java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(12,java.sql.Types.NUMERIC);
				
				cat.debug("Inicio:getListVentas:execute");
				cstmt.execute();
				cat.debug("Fin:getListVentas:execute");
				
				codError = cstmt.getInt(10);
				msgError = cstmt.getString(11);
				numEvento = cstmt.getInt(12);
				
				if (codError != 0) {
					cat.error("Ocurrió un error al recuperar ventas");
					throw new CustomerDomainException(
							"Ocurrió un error al recuperar ventas" + " " + msgError, String
									.valueOf(codError), numEvento, msgError);
				}else{
					cat.debug("Recuperando ventas");
					String codigoVendedor = cstmt.getString(8);
					String nombreVendedor = cstmt.getString(9);
					resultado = new LstVtaRegistroResultadoDTO();
					resultado.setCodigoVendedor(codigoVendedor);
					resultado.setNombreVendedor(nombreVendedor);
					
					ArrayList lista = new ArrayList();
					rs = (ResultSet) cstmt.getObject(7);
					while (rs.next()) {
						LstVtaRegistroVentaOutDTO ventaDTO = new LstVtaRegistroVentaOutDTO();
						
						ventaDTO.setNumeroVenta(Long.parseLong(rs.getString(1)));
						ventaDTO.setCanalVendedor(rs.getString(2));
						ventaDTO.setTipoProducto(rs.getString(3));
						ventaDTO.setCodigoVendedor(rs.getString(4));
						ventaDTO.setNombreVendedor(rs.getString(5));
						ventaDTO.setNumeroCuenta(rs.getString(6));
						ventaDTO.setNumeroAbonado(rs.getString(7));
						//ventaDTO.setNumeroCelular(Long.parseLong(rs.getString(8)));
						cat.debug("Numero Celular:"+rs.getString(8));
						ventaDTO.setNumeroCelular(rs.getString(8)!=null?Long.parseLong(rs.getString(8)):0);
						ventaDTO.setTipoIdentificacion(rs.getString(9));
						ventaDTO.setNumeroIdentificacion(rs.getString(10));
						ventaDTO.setNombreCliente(rs.getString(11));
						ventaDTO.setApellido1Cliente(rs.getString(12));
						ventaDTO.setApellido2Cliente(rs.getString(13));
						ventaDTO.setFechaVenta(rs.getString(14));
						ventaDTO.setFechaAlta(rs.getString(15));
						ventaDTO.setCodigoPlantarif(rs.getString(16));
						ventaDTO.setDescripcionPlantarif(rs.getString(17));
						ventaDTO.setValorFactura(Double.valueOf(rs.getString(18)));
						ventaDTO.setNumeroFactura(rs.getString(19));
						ventaDTO.setIndicadorFacturaImpresa(rs.getString(20));
						ventaDTO.setCodigoCliente(rs.getString(21));
						ventaDTO.setNombreUsuario(rs.getString(22));
						ventaDTO.setIndEstVenta(rs.getString(23));
						ventaDTO.setCodSituacion(rs.getString(24));
						ventaDTO.setCodCiclo(new Integer(rs.getInt(25)));
						lista.add(ventaDTO);
					}
					registroVentas =(LstVtaRegistroVentaOutDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
						lista.toArray(), LstVtaRegistroVentaOutDTO.class);
					resultado.setRegistroVentas(registroVentas);					
					cat.debug("Fin recuperación ventas");
				}
				if (cat.isDebugEnabled()) {
					cat.debug(" Finalizo ejecución");
					cat.debug(" Recuperando salidas");
				}
			} catch (Exception e) {
				cat.error("Ocurrió un error al recuperar ventas",e);
				if (cat.isDebugEnabled()) {
					cat.debug("Codigo de Error[" + codError + "]");
					cat.debug("Mensaje de Error[" + msgError + "]");
					cat.debug("Numero de Evento[" + numEvento + "]");
				}
				if (e instanceof CustomerDomainException ){ 
	                throw (CustomerDomainException) e;
				}else {
					CustomerDomainException c = new CustomerDomainException();
					c.setMessage(e.getMessage());  
					throw c;
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
			cat.debug("Fin:getListVentas()");
			return resultado;
		}//fin getListVentas

		/** Servicios Activaciones WEB - Colombia
		 * Obtine origen de la venta
		 * @param RegistroVentaDTO (entrada)
		 * @return RegistroVentaDTO (resultado)
		 * @throws CustomerDomainException
	     * wjrc - Agosto 2007 */		
		public RegistroVentaDTO getOrigenVenta(RegistroVentaDTO entrada) 
			throws CustomerDomainException
		{
			RegistroVentaDTO resultado= null;
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			conn = getConection();
			CallableStatement cstmt = null; 
			try {
				cat.debug("Inicio:getOrigenVenta");
				
				String call = getSQLDatosVenta("VE_intermediario_PG","VE_getOrigenVenta_PR",8);
				cat.debug("sql[" + call + "]");

				cstmt = conn.prepareCall(call);
			
				cstmt.setString(1,entrada.getNumeroSerie());
				cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
				
				cat.debug("Inicio:getOrigenVenta:execute");
				cstmt.execute();
				cat.debug("Fin:getOrigenVenta:execute");

				codError=cstmt.getInt(6);
				msgError = cstmt.getString(7);
				numEvento=cstmt.getInt(8);
				
				if (codError != 0){
					cat.error("Ocurrió un error al obtener minMDN");
					throw new CustomerDomainException(
					"Ocurrió un error al obtener minMDN", String
					.valueOf(codError), numEvento, msgError);
				}
				else{
					resultado = entrada;
					resultado.setCodigoUso(cstmt.getString(2));
					resultado.setDescripcionUso(cstmt.getString(3));
					resultado.setCodigoArticulo(cstmt.getString(4));
					resultado.setDescripcionArticulo(cstmt.getString(5));
				}
			} catch (Exception e) {
				cat.error("Ocurrió un error al obtener minMDN",e);
				if (cat.isDebugEnabled()) {
					cat.debug("Codigo de Error[" + codError + "]");
					cat.debug("Mensaje de Error[" + msgError + "]");
					cat.debug("Numero de Evento[" + numEvento + "]");
					if (e instanceof CustomerDomainException)
						throw (CustomerDomainException)e;
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
			cat.debug("Fin:getOrigenVenta");
			return resultado;
		}//fin getOrigenVenta
		
		
		public GaDocVentasDTO insertGaDocVentas(GaDocVentasDTO gaDocVentasDTO) 
			throws CustomerDomainException 
		{

			if (cat.isDebugEnabled()) {
				cat.debug("insertGaDocVentas():start");
			}
			int codError = 0;
			String msgError = null;
			int numEvento = 0;

			String call = null;
			Connection conn = null;
			CallableStatement cstmt = null;
			// se recuepera coneccion del DataSources
			try {
				conn = getConnectionFromWLSInitialContext(global
						.getJndiForDataSource());
			} catch (Exception e1) {
				cat.error(" No se pudo obtener una conexión ", e1);
				throw new CustomerDomainException(
						"No se pudo obtener una conexión", e1);
			}
			try {
				call = getSQLDatosVenta("Ve_Servicios_Venta_Pg","VE_inserta_ga_docventa_PR",6);				
				if (cat.isDebugEnabled()) {
					cat.debug("sql[" + call + "]");
				}
				cstmt = conn.prepareCall(call);

				if (cat.isDebugEnabled()) {
					cat.debug("Registrando Entradas");
				}

				cstmt.setLong(1, gaDocVentasDTO.getNum_Venta().longValue());
				cstmt.setLong(2, gaDocVentasDTO.getCod_TipDocumento().longValue());
				cstmt.setString(3, gaDocVentasDTO.getNum_Folio());
				
				if (cat.isDebugEnabled()) {
					cat.debug(" Registrando salidas");
				}
				// Se procede a descomentar cuando devuelva errores

				cstmt.registerOutParameter(4,oracle.jdbc.driver.OracleTypes.NUMBER);
				cstmt.registerOutParameter(5,oracle.jdbc.driver.OracleTypes.VARCHAR);
				cstmt.registerOutParameter(6,oracle.jdbc.driver.OracleTypes.NUMBER);

				// Campos de devolución

				if (cat.isDebugEnabled()) {
					cat.debug(" Iniciando Ejecución");
				}

				cat.debug("Execute Antes");				
				cstmt.execute();				
				cat.debug("Execute Despues");

				if (cat.isDebugEnabled()) {
					cat.debug(" Finalizo ejecución");
					cat.debug(" Recuperando salidas");
				}
				// Recuperacion de valores de salida

				codError = cstmt.getInt(4);
				cat.debug("codError[" + codError + "]");
				msgError = cstmt.getString(5);
				cat.debug("msgError[" + msgError + "]");
				numEvento = cstmt.getInt(6);
				cat.debug("numEvento[" + numEvento + "]");
				cstmt = null;
				

				if (codError != 0) {
					cat.error(" Ocurrió un error al Insertar Escenario A");
					throw new CustomerDomainException(String.valueOf(codError),
							numEvento, msgError);
				}
				else{
					gaDocVentasDTO.setTransaccionOK(true);
				}

				cat.debug("Recuperando data...");

				cat.debug("Codigo error Escenario A[" + codError + "]");
			
			} catch (Exception e) {				
				e.printStackTrace();
				cat.error("Ocurrió un error general al  Insertar Escenario A", e);
				if (cat.isDebugEnabled()) {
					cat.debug("Codigo de Error[" + codError + "]");
					cat.debug("Mensaje de Error[" + msgError + "]");
					cat.debug("Numero de Evento[" + numEvento + "]");
				}
				if (e instanceof CustomerDomainException ) throw (CustomerDomainException) e;

			} finally {
				if (cat.isDebugEnabled()) {
					cat.debug("Cerrando conexiones...");
				}
				try {
					if (cstmt != null) {
						cstmt.close();
					}

					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					cat.debug("SQLException[" + e + "]");
				}
			}

			if (cat.isDebugEnabled()) {
				cat.debug("updateVentasEscenarioA():end");
			}
			return gaDocVentasDTO;
		}
		
		public AlPetiGuiasAboDTO insertAlPetiGuiasAbo(AlPetiGuiasAboDTO alPetiGuiasAboDTO) 
			throws CustomerDomainException
		{
		
			if (cat.isDebugEnabled()) {
				cat.debug("insertAlPetiGuiasAbo():start");
			}
			int codError = 0;
			String msgError = null;
			int numEvento = 0;

			String call = null;
			Connection conn = null;
			CallableStatement cstmt = null;
			// se recuepera coneccion del DataSources
			try {
				conn = getConnectionFromWLSInitialContext(global
						.getJndiForDataSource());
			} catch (Exception e1) {
				cat.error(" No se pudo obtener una conexión ", e1);
				throw new CustomerDomainException(
						"No se pudo obtener una conexión", e1);
			}
			try {
				call = getSQLDatosVenta("Ve_Servicios_Venta_Pg","VE_inserta_al_PetiGiasAbo_PR",18);
				if (cat.isDebugEnabled()) {
					cat.debug("sql[" + call + "]");
				}
				cstmt = conn.prepareCall(call);

				if (cat.isDebugEnabled()) {
					cat.debug("Registrando Entradas");
				}

				cstmt.setLong(1, alPetiGuiasAboDTO.getCod_articulo().longValue());
				cstmt.setLong(2, alPetiGuiasAboDTO.getCod_bodega().longValue());
				cstmt.setLong(3, alPetiGuiasAboDTO.getCod_cliente().longValue());
				cstmt.setLong(4, alPetiGuiasAboDTO.getCod_concepto().longValue());
				cstmt.setString(5, alPetiGuiasAboDTO.getCod_moneda());
				cstmt.setString(6, alPetiGuiasAboDTO.getCod_oficina());
				cstmt.setLong(7, alPetiGuiasAboDTO.getNum_abonado().longValue());
				cstmt.setLong(8, alPetiGuiasAboDTO.getNum_cantidad().longValue());
				cstmt.setLong(9, alPetiGuiasAboDTO.getNum_cargo().longValue());
				cstmt.setLong(10, alPetiGuiasAboDTO.getNum_orden().longValue());				
				cstmt.setLong(11, alPetiGuiasAboDTO.getNum_peticion().longValue());				
				cstmt.setString(12, alPetiGuiasAboDTO.getNum_serie());
				cstmt.setLong(13, alPetiGuiasAboDTO.getNum_telefono().longValue());
				cstmt.setLong(14, alPetiGuiasAboDTO.getNum_venta().longValue());
				cstmt.setDouble(15, alPetiGuiasAboDTO.getVal_linea().doubleValue());
				
				if (cat.isDebugEnabled()) {
					cat.debug(" Registrando salidas");
				}
				// Se procede a descomentar cuando devuelva errores

				cstmt.registerOutParameter(16,oracle.jdbc.driver.OracleTypes.NUMBER);
				cstmt.registerOutParameter(17,oracle.jdbc.driver.OracleTypes.VARCHAR);
				cstmt.registerOutParameter(18,oracle.jdbc.driver.OracleTypes.NUMBER);

				// Campos de devolución

				if (cat.isDebugEnabled()) {
					cat.debug(" Iniciando Ejecución");
				}

				cat.debug("Execute Antes");				
				cstmt.execute();				
				cat.debug("Execute Despues");

				if (cat.isDebugEnabled()) {
					cat.debug(" Finalizo ejecución");
					cat.debug(" Recuperando salidas");
				}
				// Recuperacion de valores de salida

				codError = cstmt.getInt(16);
				cat.debug("codError[" + codError + "]");
				msgError = cstmt.getString(17);
				cat.debug("msgError[" + msgError + "]");
				numEvento = cstmt.getInt(18);
				cat.debug("numEvento[" + numEvento + "]");
				cstmt = null;
				
				if (codError != 0) {
					cat.error(" Ocurrió un error al Insertar Al_PetiGuias_Abo");
					throw new CustomerDomainException(String.valueOf(codError),
							numEvento, msgError);
				}
				else{
					alPetiGuiasAboDTO.setTransaccionOK(true);
				}

				cat.debug("Recuperando data...");

				cat.debug("Codigo error Escenario A[" + codError + "]");				
			}catch (Exception e) {				
				e.printStackTrace();
				cat.error("Ocurrió un error general al  Insertar Al_PetiGuias_Abo", e);
				if (cat.isDebugEnabled()) {
					cat.debug("Codigo de Error[" + codError + "]");
					cat.debug("Mensaje de Error[" + msgError + "]");
					cat.debug("Numero de Evento[" + numEvento + "]");
				}
				if (e instanceof CustomerDomainException ) throw (CustomerDomainException) e;

			} finally {
				if (cat.isDebugEnabled()) {
					cat.debug("Cerrando conexiones...");
				}
				try {
					if (cstmt != null) {
						cstmt.close();
					}

					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					cat.debug("SQLException[" + e + "]");
				}
			}

			if (cat.isDebugEnabled()) {
				cat.debug("insertAlPetiGuiasAbo():end");
			}
			return alPetiGuiasAboDTO;
		}
		
		/**
		 * Obtiene secuencia generica
		 * @param parametroEntrada
		 * @return resultado
		 * @throws CustomerDomainException
		 */
		
		public Long getSecuenciaGenerica(String nombreSecuencia) 
			throws CustomerDomainException
		{
			Long resultado=null;
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			
			conn = getConection();
			CallableStatement cstmt = null; 
			try {
				cat.debug("Inicio:getSecuenciaVenta");
				
				String call = getSQLDatosVenta("VE_intermediario_PG","VE_OBTIENE_SECUENCIA_PR",5);
				
				cat.debug("sql[" + call + "]");
				
				cstmt = conn.prepareCall(call);
				cstmt.setString(1,nombreSecuencia);
				cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
				
				cat.debug("Inicio:getSecuenciaVenta:execute");
				cstmt.execute();
				cat.debug("Fin:getSecuenciaVenta:execute");
				
				codError=cstmt.getInt(3);
				msgError = cstmt.getString(4);
				numEvento=cstmt.getInt(5);
				cat.debug("msgError[" + msgError + "]");
				
				resultado = new Long(Long.parseLong(cstmt.getString(2)));				
				
			} catch (Exception e) {
				cat.error("Ocurrió un error al obtener la secuencia de la venta",e);
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
			cat.debug("Fin:getSecuenciaVenta");
			return resultado;
		}
		
		
		/**
		 * realiza reversa de la venta
		 * @param entrada
		 * @return 
		 * @throws CustomerDomainException
		 */
		public void reversaVenta(GaVentasDTO entrada) 
			throws CustomerDomainException
		{
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			conn = getConection();
			CallableStatement cstmt = null; 
			try {
				cat.debug("Inicio:reversaVenta");
				
				String call = getSQLDatosVenta("Ve_Servicios_Venta_Pg","VE_reversaVentas_PR",7);

				cat.debug("sql[" + call + "]");

				cstmt = conn.prepareCall(call);
				if (cat.isDebugEnabled()){
	      			cat.debug("Numero Venta:" + entrada.getNumVenta().longValue());
	      			cat.debug("codigo Vendedor:" + entrada.getCodVendedor().longValue());
	      		}
				cstmt.setLong(1,entrada.getNumVenta().longValue());
				cstmt.setLong(2,entrada.getCodVendedor().longValue());
				cstmt.setString(3,entrada.getNomUsuarVta());
				cstmt.setLong(4,entrada.getNumProceso().longValue());
				
				cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
				if (cat.isDebugEnabled())
					cat.debug("Inicio:reversaVenta:execute");
				cstmt.execute();
				if (cat.isDebugEnabled())
					cat.debug("Fin:reversaVenta:execute");

				codError=cstmt.getInt(5);
				msgError = cstmt.getString(6);
				numEvento=cstmt.getInt(7);
				
				if (cat.isDebugEnabled()){
					cat.debug("Código Error: " +  cstmt.getInt(5));
					cat.debug("msgError: " +  cstmt.getString(6));
					cat.debug("numEvento: " +  cstmt.getInt(7));
				}
				
				if (codError != 0){
					cat.error("Ocurrió un error al realizar reversa");
					throw new CustomerDomainException(
					"Ocurrió un error al realizar reversa", String
					.valueOf(codError), numEvento, msgError);
				}
				
			} catch (Exception e) {
				cat.error("Ocurrió un error al realizar reversa",e);
				if (cat.isDebugEnabled()) {
					cat.debug("Codigo de Error[" + codError + "]");
					cat.debug("Mensaje de Error[" + msgError + "]");
					cat.debug("Numero de Evento[" + numEvento + "]");
					if (e instanceof CustomerDomainException)
						throw (CustomerDomainException)e;
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
			cat.debug("Fin:reversaVenta");
		}//fin reversaVenta
		
	public ListadoVentasDTO[] getVentasXVendedor(ListadoVentasDTO entrada) 
		throws CustomerDomainException
	{			
		cat.debug("getVentasXVendedor:star");
		ListadoVentasDTO[] resultado=null;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ResultSet rs = null;
		cat.debug("Coneccion obtenida OK");
		try {
			
				String call = getSQLDatosVenta("Ve_Servicios_Venta_Pg","VE_obtiene_VtasVendedor_PR",12);
				cat.debug("sql[" + call + "]");
				cstmt = conn.prepareCall(call);				
				if(entrada.getCodigoVendedor().longValue() == -1 ) entrada.setCodigoVendedor(new Long(0));
				cstmt.setLong(1,entrada.getCodigoVendedor().longValue());
				cat.debug("getVentasXVendedor.cod vendedor : " + entrada.getCodigoVendedor().longValue());
				if(entrada.getNroVenta() == null ) entrada.setNroVenta(new Long(0));
				cstmt.setLong(2,entrada.getNroVenta().longValue());
				cat.debug("getVentasXVendedor.nro venta : " + entrada.getNroVenta().longValue());
				if(entrada.getCodOficina().trim().equals("-1") ) entrada.setCodOficina("0");
				cstmt.setString(3,entrada.getCodOficina());
				cat.debug("getVentasXVendedor.cod oficina : " + entrada.getCodOficina());
				cstmt.setString(4,entrada.getFechaDesde());
				cat.debug("getVentasXVendedor.fecha desde : " + entrada.getFechaDesde());
				cstmt.setString(5,entrada.getFechaHasta());
				cat.debug("getVentasXVendedor.fecha hasta : " + entrada.getFechaHasta());
				cstmt.setLong(6,entrada.getCodCliente().longValue());
				cat.debug("getVentasXVendedor.codigo cliente : " + entrada.getCodCliente());
				cstmt.setString(7,entrada.getCodEstadoVenta());
				cat.debug("getVentasXVendedor.codigo estado venta : " + entrada.getCodEstadoVenta());
				cstmt.setString(8,entrada.getOrigen());
				cat.debug("getVentasXVendedor.origen : " + entrada.getOrigen());
				
				cstmt.registerOutParameter(9, OracleTypes.CURSOR);
				
				cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(12, java.sql.Types.NUMERIC);
				cat.debug("Execute Antes:getVentasXVendedor");
				cstmt.execute();
				cat.debug("Execute Despues:getVentasXVendedor");				
				
				codError = cstmt.getInt(10);
				msgError = cstmt.getString(11);
				numEvento = cstmt.getInt(12);
				
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
				
				if (codError != 0) 
				{						
						cat.error("Ocurrió un error al consultar ventas por vendedor");
						throw new CustomerDomainException("Ocurrió un error al consultar ventas por vendedor", String.valueOf(codError),
								numEvento, msgError);
				} else {
					rs = (ResultSet)cstmt.getObject(9);
					ArrayList lista = new ArrayList();
					//P-CSR-11002 JLGN 15-06-2011
					boolean flagVacio = true;
					while (rs.next()) {
						flagVacio = false;
						ListadoVentasDTO venta = new ListadoVentasDTO();							
						venta.setNroVenta(new Long(rs.getLong(1)));							
						venta.setFechaVenta(rs.getString(2));				
						venta.setNombreCliente(rs.getString(3));
						venta.setNombreVendedor(rs.getString(4));
						venta.setTipoVenta(rs.getString(5));
						venta.setCodEstadoVenta(rs.getString(6));	
						venta.setCodOficina(rs.getString(7));
						venta.setCodigoVendedor(new Long(rs.getString(8)));
						venta.setCodCliente(new Long(rs.getString(9)));
						venta.setCodModVenta(rs.getString(10));
						venta.setIndTipoVenta(rs.getInt(11));
						venta.setNumTransaccionVenta(rs.getLong(12));
						venta.setCodTipoContrato(rs.getString(13));
						venta.setNombreDealer(rs.getString(14));
						venta.setCodTipoDocumento(rs.getInt(15));
						venta.setCodCuota(rs.getString(16));
						venta.setIndOfiter(rs.getString(17));
						venta.setCodTipoCliente(rs.getString(18));
						venta.setCodTipoSolicitud(rs.getString(19));
			            venta.setIndEstVenta(rs.getString(20));	
						lista.add(venta);
						
					}
					//P-CSR-11002 JLGN 15-06-2011
					if(flagVacio){
						cat.error("No se Encontraron Registros");
						throw new CustomerDomainException("No se Encontraron Registros", String.valueOf(1),
								1, "No se Encontraron Registros");						
					}else{					
						resultado = (ListadoVentasDTO[])ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(),
								ListadoVentasDTO.class);
					}	
				}
							
		} catch (Exception e) {
			cat.error("Ocurrió un error al consultar las venta por vendedor", e);
			if (e instanceof CustomerDomainException ){ 
                throw (CustomerDomainException) e;
			}else {
				CustomerDomainException c = new CustomerDomainException();
				c.setMessage(e.getMessage());  
				throw c;
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

		cat.debug("getVentasXVendedor():end");
		return resultado;
	}
	
	public CargoSolicitudDTO[] getCargosVta(CargoSolicitudDTO entrada) 
		throws CustomerDomainException
	{			
		cat.debug("getCargosVta:star");
		CargoSolicitudDTO[] resultado=null;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ResultSet rs = null;
		cat.debug("Coneccion obtenida OK");
		try {
			
				String call = getSQLDatosVenta("Ve_Servicios_Venta_Pg","VE_obtiene_CargosVTa_PR",6);
				cat.debug("sql[" + call + "]");
				cstmt = conn.prepareCall(call);				
				
				cstmt.setLong(1,entrada.getNumVenta());
				cat.debug("getCargosVta.Num Venta : " + entrada.getNumVenta());
				cstmt.setString(2,entrada.getCodOficina());
				cat.debug("getCargosVta.Cod Oficina : " + entrada.getCodOficina());
				
				cstmt.registerOutParameter(3, OracleTypes.CURSOR);
				
				cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
				cat.debug("Execute Antes:getCargosVta");
				cstmt.execute();
				cat.debug("Execute Despues:getCargosVta");				
				
				codError = cstmt.getInt(4);
				msgError = cstmt.getString(5);
				numEvento = cstmt.getInt(6);
				
				if (codError != 0) 
				{						
						cat.error("Ocurrió un error al consultar los carhos de la solicitud");
						throw new CustomerDomainException("Ocurrió un error al consultar los cargos de la solicitud", String.valueOf(codError),
								numEvento, msgError);
				} else {
					rs = (ResultSet)cstmt.getObject(3);
					ArrayList lista = new ArrayList();
					while (rs.next()) {
						CargoSolicitudDTO cargo = new CargoSolicitudDTO();							
						cargo.setNumCargo(rs.getLong(1));
						cargo.setCodCliente(rs.getLong(2));
						cargo.setCodConcepto(rs.getLong(3));
						cargo.setDesConcepto(rs.getString(4));
						//cargo.setImpCargo(rs.getLong(5));
						cargo.setImpCargo(rs.getDouble(5));
						
						cargo.setCodMoneda(rs.getString(6));
						cargo.setDesMoneda(rs.getString(7));
						cargo.setNumUnidades(rs.getLong(8));
						cargo.setNumVenta(rs.getLong(9));
						cargo.setCodConceptoDcto(rs.getLong(10));
						//cargo.setValDcto(rs.getLong(11));
						cargo.setValDcto(rs.getDouble(11));						
						cargo.setTipDcto(rs.getInt(12));
					    cargo.setValDctoSinImpuesto(rs.getDouble(13));
					    cargo.setNumAbonado(rs.getLong(14));
						
						lista.add(cargo);
					}
					
					resultado = (CargoSolicitudDTO[])ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(),
							CargoSolicitudDTO.class);
				}
							
		} catch (Exception e) {
			cat.error(global.errorgetListado(), e);
			throw new CustomerDomainException(global.errorgetListado(), e);
	
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
	
		cat.debug("getCargosVta():end");
		return resultado;
	}
	
	public void updateSituacionVenta(GaVentasDTO entrada) 
		throws CustomerDomainException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:updateSituacionVentas");
			
			String call = getSQLDatosVenta("GA_VENTAS_SB_PG","GA_UPD_SITVENTA_PR",7);
	
			cat.debug("sql[" + call + "]");
	
			cstmt = conn.prepareCall(call);
	  		
			cstmt.setLong(1,entrada.getNumVenta().longValue());
			cat.debug("entrada.getNumVenta():" + entrada.getNumVenta().longValue());
			cstmt.setString(2,entrada.getIndEstVenta());
			cat.debug("entrada.getIndEstVenta():" + entrada.getIndEstVenta());
			cstmt.setString(3,entrada.getImpVentaS());
			cat.debug("entrada.getImpVentaS():" + entrada.getImpVentaS());
			cstmt.setString(4,entrada.getNomUsuarora());
			cat.debug("entrada.getNomUsuarora():" + entrada.getNomUsuarVta());
			
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			if (cat.isDebugEnabled())
				cat.debug("Inicio:updateSituacionVentas:execute");
			cstmt.execute();
			if (cat.isDebugEnabled())
				cat.debug("Fin:updateSituacionVentas:execute");
	
			codError=cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento=cstmt.getInt(7);			
			
			cat.debug("Código Error: " +  cstmt.getInt(5));
			cat.debug("msgError: " +  cstmt.getString(6));
			cat.debug("numEvento: " +  cstmt.getInt(7));
			
			
			if (codError != 0){
				cat.error("Ocurrió un error al actualizar el estado de la venta");
				throw new CustomerDomainException(
				"Ocurrió un error al realizar reversa", String
				.valueOf(codError), numEvento, msgError);
			}
			
		} catch (Exception e) {
			cat.error("Ocurrió un error al actualizar el estado de la venta",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
				if (e instanceof CustomerDomainException)
					throw (CustomerDomainException)e;
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
		cat.debug("Fin:updateSituacionVentas");
	}//fin updateSituacionVentas
	
	public void updateVentaDesbloqueo(GaVentasDTO entrada) 
		throws CustomerDomainException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:updateVentaDesbloqueo");
			
			String call = getSQLDatosVenta("VE_SERVICIOS_VENTA_PG","VE_ActVtaDesbloq_PR",6);
	
			cat.debug("sql[" + call + "]");
	
			cstmt = conn.prepareCall(call);
	  		
			cstmt.setLong(1,entrada.getNumVenta().longValue());
			cat.debug("entrada.getNumVenta():" + entrada.getNumVenta().longValue());
			cstmt.setLong(2,entrada.getAbonado().getNumAbonado());
			cat.debug("entrada.getAbonado().getNumAbonado():" + entrada.getAbonado().getNumAbonado());
			cstmt.setString(3,entrada.getNomUsuarora());
			cat.debug("entrada.getNomUsuarora():" + entrada.getNomUsuarora());
			
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			if (cat.isDebugEnabled())
				cat.debug("Inicio:updateSituacionVentas:execute");
			cstmt.execute();
			if (cat.isDebugEnabled())
				cat.debug("Fin:updateSituacionVentas:execute");
	
			codError=cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento=cstmt.getInt(6);			
			
			cat.debug("Código Error: " +  cstmt.getInt(4));
			cat.debug("msgError: " +  cstmt.getString(5));
			cat.debug("numEvento: " +  cstmt.getInt(6));
			
			
			if (codError != 0){
				cat.error("Ocurrió un error al actualizar el desbloqueo de la venta");
				throw new CustomerDomainException(
				"Ocurrió un error al realizar reversa", String
				.valueOf(codError), numEvento, msgError);
			}
			
		} catch (Exception e) {
			cat.error("Ocurrió un error al actualizar el desbloqueo de la venta",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
				if (e instanceof CustomerDomainException)
					throw (CustomerDomainException)e;
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
		cat.debug("Fin:updateVentaDesbloqueo");
	}//fin updateVentaDesbloqueo
	
	public void reversaCargosFormalizacion(Long numVenta) 
		throws CustomerDomainException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:reversaCargosFormalizacion");
			
			String call = getSQLDatosVenta("VE_SERVICIOS_VENTA_PG","VE_ReversaCargos_PR",4);
	
			cat.debug("sql[" + call + "]");
	
			cstmt = conn.prepareCall(call);
	  		
			cstmt.setLong(1,numVenta.longValue());
			cat.debug("numVenta:" + numVenta.longValue());
			
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			
			cstmt.execute();
			
			codError=cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento=cstmt.getInt(4);			
			
			cat.debug("Código Error: " +  cstmt.getInt(2));
			cat.debug("msgError: " +  cstmt.getString(3));
			cat.debug("numEvento: " +  cstmt.getInt(4));
			
			
			if (codError != 0){
				cat.error("Ocurrió un error al reversar los cargos de la formalizacion");
				throw new CustomerDomainException(
				"Ocurrió un error al al reversar los cargos de la formalizacion", String
				.valueOf(codError), numEvento, msgError);
			}
			
		} catch (Exception e) {
			cat.error("Ocurrió un error al reversar los cargos de la formalizacion",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
				if (e instanceof CustomerDomainException)
					throw (CustomerDomainException)e;
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
		cat.debug("Fin:reversaCargosFormalizacion");
	}//fin reversaCargosFormalizacion
	
	
	public Long verificaVentaCero_Regalo(Long numVenta)
		throws CustomerDomainException
	{
		Long resultado=null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:verificaVentaCero_Regalo");
			
			String call = getSQLDatosVenta("VE_servicios_venta_PG","VE_verifica_VentaCero_PR",5);
			
			cat.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			cat.debug("numVenta:" + numVenta);
			cstmt.setLong(1,numVenta.longValue());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:verificaVentaCero_Regalo:execute");
			cstmt.execute();
			cat.debug("Fin:verificaVentaCero_Regalo:execute");
			
			codError=cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento=cstmt.getInt(5);
			cat.debug("msgError[" + msgError + "]");
			
			resultado = new Long(cstmt.getLong(2));				
			
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener el importe de la venta cero",e);
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
		cat.debug("Fin:verificaVentaCero_Regalo");
		return resultado;
	}
		
		
//FIN MERGE
	
	/**
	 * Obtiene Estado de Procesamiento de la contratacion de planes adicionales
	 * @param numVenta
	 * @return String
	 * @throws CustomerDomainException
	 */
	public String obtenerEstadoContratacionPA(Long numVenta) 
		throws CustomerDomainException
	{
		String resultado=null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:obtenerEstadoContratacionPA");
			
			String call = getSQLDatosVenta("VE_servicios_venta_PG","VE_consulta_EstadoConPA_PR",5);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			
			cat.debug("numVenta:" + numVenta);
			cstmt.setLong(1,numVenta.longValue());

			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:obtenerEstadoContratacionPA:execute");
			cstmt.execute();
			cat.debug("Fin:obtenerEstadoContratacionPA:execute");

			codError=cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento=cstmt.getInt(5);
			cat.debug("Código Error: " +  cstmt.getInt(3));
			cat.debug("msgError: " +  cstmt.getString(4));
			cat.debug("numEvento: " +  cstmt.getInt(5));
			
			if (codError != 0){
				cat.error("Ocurrió un error al obtener estado de contratacion de planes adicionales");
				throw new CustomerDomainException(
				"Ocurrió un error al obtener estado de contratacion de planes adicionales", String
				.valueOf(codError), numEvento, msgError);
			}
			else{
				resultado = cstmt.getString(2);
				cat.debug("estado:" + resultado);
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener estado de contratacion de planes adicionales",e);
			if (e instanceof CustomerDomainException) throw (CustomerDomainException)e;		
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
		cat.debug("Fin:obtenerEstadoContratacionPA");
		return resultado;
	}//fin obtenerEstadoContratacionPA
	
	/**
	 * Obtiene los datos para generar el pagare en la venta
	 * @param numVenta
	 * @return String
	 * @throws CustomerDomainException
	 */
	public PagareDTO obtenerDatosPagare(Long numVenta)
		throws CustomerDomainException
	{
		PagareDTO resultado=new PagareDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:obtenerDatosPagare");
			
			String call = getSQLDatosVenta("Ve_Servs_ActivacionesWeb_Pg","VE_OBTIENE_DATOS_PAGARE_PR",12);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			
			cat.debug("numVenta:" + numVenta);
			cstmt.setLong(1,numVenta.longValue());

			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC); //imp_equipo			
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR); //dinero_letra_eq
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR); //decimal_letas_eq
			
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC); //imp_limite
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR); //dinero_letras_lim
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR); //decimal_letras_lim
			
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR); //nom_cliente
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR); //glosa_dir
			
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(12, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:obtenerDatosPagare:execute");
			cstmt.execute();
			cat.debug("Fin:obtenerDatosPagare:execute");

			codError=cstmt.getInt(10);
			msgError = cstmt.getString(11);
			numEvento=cstmt.getInt(12);
			cat.debug("Código Error: " +  cstmt.getInt(10));
			cat.debug("msgError: " +  cstmt.getString(11));
			cat.debug("numEvento: " +  cstmt.getInt(12));
			
			if (codError != 0){
				cat.error("Ocurrió un error al obtener los datos del pagare");
				throw new CustomerDomainException(
				"Ocurrió un error al obtener los datos del pagare", String
				.valueOf(codError), numEvento, msgError);
			}
			else{
				resultado.setImp_equipo(cstmt.getDouble(2));
				cat.debug("impEquipo:" + resultado.getImp_equipo());
				resultado.setDineroLetrasEq(cstmt.getString(3));
				cat.debug("dineroLetrasEq:" + resultado.getDineroLetrasEq());
				resultado.setDecimalLetrasEq(cstmt.getString(4));	
				cat.debug("decimalLetrasEq:" + resultado.getDecimalLetrasEq());
				
				resultado.setImp_lim(cstmt.getDouble(5));
				cat.debug("impLim:" + resultado.getImp_lim());
				resultado.setDineroLetrasLimSinIva(cstmt.getString(6));
				cat.debug("dineroLetrasLimSinIva:" + resultado.getDineroLetrasLimSinIva());
				resultado.setDecimalLetrasLimSinIva(cstmt.getString(7));	
				cat.debug("decimalLetrasLimSinIva:" + resultado.getDecimalLetrasLimSinIva());				
				
				resultado.setNombreCliente(cstmt.getString(8));
				cat.debug("nombreCliente:" + resultado.getNombreCliente());
				resultado.setGlosaDireccion(cstmt.getString(9));	
				cat.debug("glosaDireccion:" + resultado.getGlosaDireccion());
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener los datos del pagare",e);			
			if (e instanceof CustomerDomainException) throw (CustomerDomainException)e;			
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
		cat.debug("Fin:obtenerDatosPagare");
		return resultado;
	}//fin obtenerDatosPagare
	
	
	/**
	 * Obtiene los datos para generar el la ficha del cliente
	 * @param numAbonado
	 * @return String
	 * @throws CustomerDomainException
	 */
	public FichaClienteDTO obtenerDatosFichaCliente(Long numAbonado)
		throws CustomerDomainException
	{
		FichaClienteDTO resultado=new FichaClienteDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:obtenerDatosFichaCliente");
			
			String call = getSQLDatosVenta("Ve_Servs_ActivacionesWeb_Pg","VE_OBTIENE_DATOS_FICHA_PR",19);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			
			cat.debug("numAbonado:" + numAbonado);
			cstmt.setLong(1,numAbonado.longValue());

			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);			
			cstmt.registerOutParameter(3, java.sql.Types.DATE);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(15, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(16, java.sql.Types.NUMERIC);
			
			cstmt.registerOutParameter(17, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(18, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(19, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:obtenerDatosFichaCliente:execute");
			cstmt.execute();
			cat.debug("Fin:obtenerDatosFichaCliente:execute");

			codError=cstmt.getInt(17);
			msgError = cstmt.getString(18);
			numEvento=cstmt.getInt(19);
			cat.debug("Código Error: " +  cstmt.getInt(17));
			cat.debug("msgError: " +  cstmt.getString(18));
			cat.debug("numEvento: " +  cstmt.getInt(19));
			
			if (codError != 0){
				cat.error("Ocurrió un error al obtener los datos de la ficha del cliente");
				throw new CustomerDomainException(
				"Ocurrió un error al obtener los datos de la ficha del cliente", String
				.valueOf(codError), numEvento, msgError);
			}
			else{
				resultado.setNomCliente(cstmt.getString(2));
				cat.debug("nomCliente:" + resultado.getNomCliente());
				
				SimpleDateFormat formatJava = new SimpleDateFormat("dd/MM/yyyy");
				java.sql.Date fechaNac = cstmt.getDate(3);		   
				resultado.setFecNacimiento(formatJava.format(fechaNac));
				cat.debug("fechaNacimiento:" + resultado.getFecNacimiento());
				resultado.setProfesion(cstmt.getString(4));	
				cat.debug("profesion:" + resultado.getProfesion());
				resultado.setTelefono(cstmt.getString(5));
				cat.debug("telefono:" + resultado.getTelefono());
				resultado.setGlosaDir(cstmt.getString(6));	
				cat.debug("glosaDir:" + resultado.getGlosaDir());
				resultado.setGlosaIdent(cstmt.getString(7));
				cat.debug("glosaIdent:" + resultado.getGlosaIdent());
				resultado.setCodVendealer(cstmt.getLong(8));
				cat.debug("codVendealer:" + resultado.getCodVendealer());
				resultado.setNomVendealer(cstmt.getString(9));
				cat.debug("nomVendealer:" + resultado.getNomVendealer());
				resultado.setDesOficina(cstmt.getString(10));
				cat.debug("desOficina:" + resultado.getDesOficina());
				resultado.setNomVendedor(cstmt.getString(11));
				cat.debug("nomVendedor:" + resultado.getNomVendedor());
				resultado.setDescTerminal(cstmt.getString(12));
				cat.debug("descTerminal:" + resultado.getDescTerminal());
				resultado.setIcc(cstmt.getString(13));
				cat.debug("icc:" + resultado.getIcc());
				resultado.setImei(cstmt.getString(14));
				cat.debug("imei:" + resultado.getImei());
				resultado.setNomUsuarora(cstmt.getString(15));
				cat.debug("nomUsuarora:" + resultado.getNomUsuarora());
				resultado.setNumCelular(cstmt.getLong(16));
				cat.debug("numCelular:" + resultado.getNumCelular());
				
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener los datos de la ficha del cliente",e);			
			if (e instanceof CustomerDomainException) throw (CustomerDomainException)e;			
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
		cat.debug("Fin:obtenerDatosFichaCliente");
		return resultado;
	}//fin obtenerDatosFichaCliente
	
	
	/**
	 * Obtiene los datos para generar los datos de la salida de bodega
	 * @param numAbonado
	 * @return String
	 * @throws CustomerDomainException
	 */
	public FichaSalidaBodegaDTO obtenerDatosSalidaBodega(Long numVenta) throws CustomerDomainException {
		FichaSalidaBodegaDTO resultado = new FichaSalidaBodegaDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		ResultSet rs = null;
		DetalleFichaSalidaBodegaDTO[] detalles = null;
		final String nombrePackage = "Ve_Servs_ActivacionesWeb_Pg";
		final String nombrePLSQL = "VE_OBTIENE_DATOS_SALBOD_PR";
		final int cantidadParametros = 9;
		try {
			cat.debug("Inicio:obtenerDatosSalidaBodega");
			String call = getSQLDatosVenta(nombrePackage, nombrePLSQL, cantidadParametros);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cat.debug("numVenta:" + numVenta);
			cstmt.setLong(1, numVenta.longValue());
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, OracleTypes.CURSOR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(cantidadParametros, java.sql.Types.NUMERIC);

			cat.debug("Inicio:obtenerDatosSalidaBodega:execute");
			cstmt.execute();
			cat.debug("Fin:obtenerDatosSalidaBodega:execute");

			codError = cstmt.getInt(7);
			msgError = cstmt.getString(8);
			numEvento = cstmt.getInt(cantidadParametros);
			cat.debug("Código Error: " + cstmt.getInt(7));
			cat.debug("msgError: " + cstmt.getString(8));
			cat.debug("numEvento: " + cstmt.getInt(cantidadParametros));

			if (codError != 0) {
				cat.error("Ocurrió un error al obtener los datos de la ficha de salida de bodega");
				throw new CustomerDomainException(
						"Ocurrió un error al obtener los datos de la ficha de salida de bodega", String
								.valueOf(codError), numEvento, msgError);
			}
			else {
				resultado.setEstadoVenta(cstmt.getString(2));
				cat.debug("estadoVenta:" + resultado.getEstadoVenta());
				resultado.setNomVendedor(cstmt.getString(3));
				cat.debug("nomVendedor:" + resultado.getNomVendedor());
				resultado.setNomCliente(cstmt.getString(4));
				cat.debug("nomCliente:" + resultado.getNomCliente());
				resultado.setNomUsuarora(cstmt.getString(5));
				cat.debug("nomUsuarora:" + resultado.getNomUsuarora());

				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(6);

				while (rs.next()) {
					DetalleFichaSalidaBodegaDTO detalle = new DetalleFichaSalidaBodegaDTO();
					detalle.setNumCelular(rs.getLong(1));
					detalle.setNumSerie(rs.getString(2));
					detalle.setNumImei(rs.getString(3));
					detalle.setCodBodega(rs.getLong(4));
					detalle.setIndProcEquipo(rs.getString(5));
					detalle.setCodArticulo(rs.getString(6));
					detalle.setDesArticulo(rs.getString(7));
					detalle.setCodPlanTarif(rs.getString(8));
					detalle.setDesPlanTarif(rs.getString(9));
					lista.add(detalle);
				}
				detalles = (DetalleFichaSalidaBodegaDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(),
						DetalleFichaSalidaBodegaDTO.class);
				resultado.setDetalle(detalles);
			}
		}
		catch (Exception e) {
			cat.error("Ocurrió un error al obtener los datos de la ficha de salida de bodega", e);
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally {
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try {
				if (rs != null)
					rs.close();
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:obtenerDatosSalidaBodega");
		return resultado;
	}//fin obtenerDatosSalidaBodega
	
	/**
	 * Obtiene los datos para generar los datos el contrato de prestacion
	 * @param numAbonado
	 * @return String
	 * @throws CustomerDomainException
	 */
	public FichaContratoPrestacionDTO obtenerDatosContratoPrestacion(Long numVenta)
		throws CustomerDomainException
	{
		FichaContratoPrestacionDTO resultado=new FichaContratoPrestacionDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		ResultSet rs = null;
		DetalleFichaContratoPrestacionDTO[] detalles = null;
		try {
			cat.debug("Inicio:obtenerDatosContratoPrestacion");
			
			String call = getSQLDatosVenta("Ve_Servs_ActivacionesWeb_Pg","VE_OBTIENE_DATOS_CPST_PR",14);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			
			cat.debug("numVenta:" + numVenta);
			cstmt.setLong(1,numVenta.longValue());

			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);			
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);	
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);	
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);	
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);	
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);
			
			cstmt.registerOutParameter(11, OracleTypes.CURSOR);
			
			cstmt.registerOutParameter(12, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(14, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:obtenerDatosContratoPrestacion:execute");
			cstmt.execute();
			cat.debug("Fin:obtenerDatosContratoPrestacion:execute");

			codError=cstmt.getInt(12);
			msgError = cstmt.getString(13);
			numEvento=cstmt.getInt(14);
			
			cat.debug("Código Error: " +  cstmt.getInt(12));
			cat.debug("msgError: " +  cstmt.getString(13));
			cat.debug("numEvento: " +  cstmt.getInt(14));
			
			if (codError != 0){
				cat.error("Ocurrió un error al obtener los datos del contrato de prestacion");
				throw new CustomerDomainException(
				"Ocurrió un error al obtener los datos del contrato de prestacion", String
				.valueOf(codError), numEvento, msgError);
			}
			else{
				resultado.setNomCliente(cstmt.getString(2));
				cat.debug("nomCliente:" + resultado.getNomCliente());
				resultado.setTelefono(cstmt.getString(3));
				cat.debug("telefono:" + resultado.getTelefono());
				resultado.setProfesion(cstmt.getString(4));	
				cat.debug("profesion:" + resultado.getProfesion());	
				resultado.setNumIdent2(cstmt.getString(5));	
				cat.debug("numIdent2:" + resultado.getNumIdent2());	
				resultado.setGlosaDir(cstmt.getString(6));	
				cat.debug("glosaDir:" + resultado.getGlosaDir());	
				resultado.setNumIdent(cstmt.getString(7));	
				cat.debug("numIdent:" + resultado.getNumIdent());	
				resultado.setDesModVenta(cstmt.getString(8));	
				cat.debug("desModVenta:" + resultado.getDesModVenta());	
				resultado.setNumMeses(cstmt.getLong(9));	
				cat.debug("numMeses:" + resultado.getNumMeses());	
				resultado.setNumFolio(cstmt.getLong(10));	
				cat.debug("numFolio:" + resultado.getNumFolio());	
				
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(11);	
				
				while (rs.next()) {
					DetalleFichaContratoPrestacionDTO detalle = new DetalleFichaContratoPrestacionDTO();
					detalle.setNumAbonado(rs.getLong(1));
					detalle.setNumSerie(rs.getString(2));
					detalle.setDesEquipo(rs.getString(3));
					detalle.setPlanTarifario(rs.getString(4));
					detalle.setImporteCargoBasico(rs.getDouble(5));
					detalle.setValorReferencia(rs.getDouble(6));
					detalle.setPrecioVenta(rs.getDouble(7));
					detalle.setCodPlanServ(rs.getString(8));
					detalle.setCodUso(rs.getInt(9));
					detalle.setNumCelular(rs.getLong(10));
					lista.add(detalle);
				}
				detalles =(DetalleFichaContratoPrestacionDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
						lista.toArray(), DetalleFichaContratoPrestacionDTO.class);
				resultado.setDetalle(detalles);					
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener los datos del contrato de prestacion",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
				if (e instanceof CustomerDomainException)
					throw (CustomerDomainException)e;
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
		cat.debug("Fin:obtenerDatosContratoPrestacion");
		return resultado;
	}//fin obtenerDatosContratoPrestacion
	
	public Long obtenerVentasAnteriores( Long numVenta, Long codCliente ) 
		throws CustomerDomainException
	{
		cat.debug("Inicio:obtenerVentasAnteriores()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Long resultado = null;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt =null;	
		cat.debug("Conexion obtenida OK");
		
		try {
			
		   String call = getSQLDatosVenta("GA_Distribucion_Bolsa_Pg", "VE_obtiene_ventas_ant_PR",6);
		   cat.debug("sql[" + call + "]");
		   
		   cstmt = conn.prepareCall(call);
		   
		   cat.debug("numVenta:" + numVenta);
		   cstmt.setLong(1,numVenta.longValue());
		   cat.debug("codCliente:" + codCliente);
		   cstmt.setLong(2,codCliente.longValue());		   
		   
		   cstmt.registerOutParameter(3,java.sql.Types.NUMERIC); 
		  
		   cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);
		   cstmt.registerOutParameter(5,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(6,java.sql.Types.NUMERIC);
		   
		   cat.debug("obtenerVentasAnteriores:Execute Antes"); 		   
		   cstmt.execute();		  
		   cat.debug("obtenerVentasAnteriores:Execute Despues");
		   
		   codError = cstmt.getInt(4);
		   msgError = cstmt.getString(5);
		   numEvento = cstmt.getInt(6);
		 
		   cat.debug("codError[" + codError + "]");
		   cat.debug("msgError[" + msgError + "]");
		   cat.debug("numEvento[" + numEvento + "]");
		   
		   if (codError!=0) 
		   {   		    
			    cat.error("Ocurrió un error al recuperar cantidad de ventas anteriores ");
			    throw new ProductDomainException("Ocurrió un error al recuperar cantidad de ventas anteriores", 
			    		String.valueOf(codError), numEvento, msgError);
		    
			}else{
			    resultado = new Long(cstmt.getLong(3));
				cat.debug("resultado:" + resultado);							
			}
		   
		   if (cat.isDebugEnabled())
		    cat.debug(" Finalizo ejecución");
		  } 
		  catch (Exception e) {
			   cat.error("Ocurrió un error al obtener la cantidad de ventas anteriores",e);
			   if (cat.isDebugEnabled()) {
			    cat.debug("Codigo de Error[" + codError + "]");
			    cat.debug("Mensaje de Error[" + msgError + "]");
			    cat.debug("Numero de Evento[" + numEvento + "]");
			   }
			   if (e instanceof CustomerDomainException){
				  throw (CustomerDomainException) e;
			   }
		  } 
		  finally {
		    if (cat.isDebugEnabled()) 
		    cat.debug("Cerrando conexiones...");
			   try {
				   if (cstmt != null) {
						cstmt.close();
				   }
				   if (!conn.isClosed()) {
				     conn.close();
				   }
			   } catch (SQLException e) {
			    cat.debug("SQLException", e);
			   }
		  }
		  cat.debug("obtenerVentasAnteriores():end");
		return resultado;
	}//fin obtenerVentasAnteriores

	public Long obtenerVentasAnterioresPorPlan( Long numVenta, Long codCliente, String codPlanTarif) 
		throws CustomerDomainException
	{
		cat.debug("Inicio:obtenerVentasAnterioresPorPlan()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Long resultado = null;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt =null;	
		cat.debug("Conexion obtenida OK");
		
		try {
			
		   String call = getSQLDatosVenta("GA_Distribucion_Bolsa_Pg", "VE_obtiene_vtas_ant_X_plan_PR",7);
		   cat.debug("sql[" + call + "]");
		   
		   cstmt = conn.prepareCall(call);
		   
		   cat.debug("numVenta:" + numVenta);
		   cstmt.setLong(1,numVenta.longValue());
		   cat.debug("codCliente:" + codCliente);
		   cstmt.setLong(2,codCliente.longValue());
		   cat.debug("codPlanTarif:" + codPlanTarif);
		   cstmt.setString(3,codPlanTarif);
		   
		   cstmt.registerOutParameter(4,java.sql.Types.NUMERIC); 
		  
		   cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);
		   cstmt.registerOutParameter(6,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(7,java.sql.Types.NUMERIC);
		   
		   cat.debug("obtenerVentasAnterioresPorPlan:Execute Antes"); 		   
		   cstmt.execute();		  
		   cat.debug("obtenerVentasAnterioresPorPlan:Execute Despues");
		   
		   codError = cstmt.getInt(5);
		   msgError = cstmt.getString(6);
		   numEvento = cstmt.getInt(7);
		 
		   cat.debug("codError[" + codError + "]");
		   cat.debug("msgError[" + msgError + "]");
		   cat.debug("numEvento[" + numEvento + "]");
		   
		   if (codError!=0) 
		   {   		    
			    cat.error("Ocurrió un error al recuperar cantidad de ventas por plan anteriores ");
			    throw new ProductDomainException("Ocurrió un error al recuperar cantidad de ventas por plan anteriores", 
			    		String.valueOf(codError), numEvento, msgError);
		    
			}else{
			    resultado = new Long(cstmt.getLong(4));
				cat.debug("resultado:" + resultado);							
			}
		   
		   if (cat.isDebugEnabled())
		    cat.debug(" Finalizo ejecución");
		  } 
		  catch (Exception e) {
			   cat.error("Ocurrió un error al obtener la cantidad de ventas por plan anteriores",e);
			   if (cat.isDebugEnabled()) {
			    cat.debug("Codigo de Error[" + codError + "]");
			    cat.debug("Mensaje de Error[" + msgError + "]");
			    cat.debug("Numero de Evento[" + numEvento + "]");
			   }
			   if (e instanceof CustomerDomainException){
				  throw (CustomerDomainException) e;
			   }
		  } 
		  finally {
		    if (cat.isDebugEnabled()) 
		    cat.debug("Cerrando conexiones...");
			   try {
				   if (cstmt != null) {
						cstmt.close();
				   }
				   if (!conn.isClosed()) {
				     conn.close();
				   }
			   } catch (SQLException e) {
			    cat.debug("SQLException", e);
			   }
		  }
		  cat.debug("obtenerVentasAnterioresPorPlan():end");
		return resultado;
	}//fin obtenerVentasAnterioresPorPlan
	
	/**
	 * Obtiene los tipos de solicitudes
	 * @return TipoSolicitudDTO[]
	 * @throws CustomerDomainException
	 */
	public TipoSolicitudDTO[] obtenerTiposSolicitudes() 
		throws CustomerDomainException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		ResultSet rs = null;
		TipoSolicitudDTO[] solicitudes = null;
		try {
			cat.debug("Inicio:obtenerTiposSolicitudes");
			
			String call = getSQLDatosVenta("VE_parametros_comerciales_PG","VE_getList_TipSol_PR",4);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			
			cstmt.registerOutParameter(1, OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:obtenerTiposSolicitudes:execute");
			cstmt.execute();
			cat.debug("Fin:obtenerTiposSolicitudes:execute");

			codError=cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento=cstmt.getInt(4);
			cat.debug("Código Error: " +  cstmt.getInt(2));
			cat.debug("msgError: " +  cstmt.getString(3));
			cat.debug("numEvento: " +  cstmt.getInt(4));
			
			if (codError != 0){
				cat.error("Ocurrió un error al obtener los tipos de solicitudes");
				throw new CustomerDomainException(
				"Ocurrió un error al obtener los tipos de solicitudes", String
				.valueOf(codError), numEvento, msgError);
			}
			else{
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(1);	
				
				while (rs.next()) {
					TipoSolicitudDTO tipoSolicitudDTO = new TipoSolicitudDTO();
					tipoSolicitudDTO.setCodTipoSolicitud(rs.getString(1));
					tipoSolicitudDTO.setGlsTipoSolicitud(rs.getString(2));					
					lista.add(tipoSolicitudDTO);
				}
				solicitudes =(TipoSolicitudDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
						lista.toArray(), TipoSolicitudDTO.class);
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener los tipos de solicitudes",e);			
			if (e instanceof CustomerDomainException) throw (CustomerDomainException)e;			
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
		cat.debug("Fin:obtenerTiposSolicitudes");
		return solicitudes;
	}//fin obtenerTiposSolicitudes
	
	
	public CargoSolicitudDTO[] getCargosPARecSolicitud(CargoSolicitudDTO entrada) 
		throws CustomerDomainException 
	{
		cat.debug("getCargosPARecSolicitud: Inicio");
		
		final String nombrePackage = "VE_SERVICIOS_SOLICITUD_PG";
		final String nombrePL = "VE_obtiene_Detalle_PA_PR";
		
		CargoSolicitudDTO[] resultado = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ResultSet rs = null;
		ResultSet rs2 = null;
		cat.debug("Conexion obtenida OK");
		try {
			String call = getSQLDatosVenta(nombrePackage, nombrePL, 6);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);

			cstmt.setLong(1, entrada.getNumVenta());
			cat.debug("getCargosVta.NumVenta: " + entrada.getNumVenta());

			cstmt.registerOutParameter(2, OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, OracleTypes.CURSOR);

			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			
			cat.debug("Execute Antes:getCargosPARecSolicitud");
			cstmt.execute();
			cat.debug("Execute Despues:getCargosPARecSolicitud");

			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);

			if (codError != 0) {
				cat.error("Ocurrió un error al consultar los cargos recurrentes de PA");
				throw new CustomerDomainException("Ocurrió un error al consultar los cargos recurrentes de PA", String
						.valueOf(codError), numEvento, msgError);
			}
			else {
				rs = (ResultSet) cstmt.getObject(2);
				rs2 = (ResultSet) cstmt.getObject(3);
				ArrayList lista = new ArrayList();
				while (rs.next()) {
					CargoSolicitudDTO cargo = new CargoSolicitudDTO();
					cargo.setNumAbonado(rs.getLong(1));
					cargo.setDesConcepto(rs.getString(2));
					cargo.setImpCargo(rs.getDouble(3));
					cargo.setCodMoneda(rs.getString(4));
					cargo.setCodProductoContratado(rs.getLong(5));
					cargo.setCodCargoContratado(rs.getLong(6));
					cargo.setCodConcepto(rs.getLong(7));
					cargo.setDesMoneda(rs.getString(8)); 
					lista.add(cargo);
				}
				while (rs2.next()) {
					CargoSolicitudDTO cargo = new CargoSolicitudDTO();
					cargo.setNumAbonado(rs2.getLong(1));
					cargo.setDesConcepto(rs2.getString(2));
					cargo.setImpCargo(rs2.getDouble(3));
					cargo.setCodMoneda(rs2.getString(4));
					cargo.setCodProductoContratado(rs2.getLong(5));
					cargo.setCodCargoContratado(rs2.getLong(6));
					cargo.setCodConcepto(rs2.getLong(7));
					cargo.setDesMoneda(rs2.getString(8));
					lista.add(cargo);
				}
				resultado = (CargoSolicitudDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(),
						CargoSolicitudDTO.class);
			}
		}
		catch (Exception e) {
			cat.error(global.errorgetListado(), e);
			throw new CustomerDomainException(global.errorgetListado(), e);

		}
		finally {
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try {
				if (rs != null)
					rs.close();
				if (rs2 != null)
					rs2.close();
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("getCargosPARecSolicitud():end");
		return resultado;
	}
	
	
	public void updateAbonadoPreactivo(Long numAbonado) 
		throws CustomerDomainException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:updateAbonadoPreactivo");
			
			String call = getSQLDatosVenta("Ve_Servicios_solicitud_Pg","VE_ACTUALIZA_MOVPREACTIVO_PR",4);
	
			cat.debug("sql[" + call + "]");
	
			cstmt = conn.prepareCall(call);
	  		
			cstmt.setLong(1,numAbonado.longValue());
			cat.debug("numAbonado:" + numAbonado.longValue());
			
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			if (cat.isDebugEnabled())
				cat.debug("Inicio:updateAbonadoPreactivo:execute");
			cstmt.execute();
			if (cat.isDebugEnabled())
				cat.debug("Fin:updateAbonadoPreactivo:execute");
	
			codError=cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento=cstmt.getInt(4);			
			
			cat.debug("Código Error: " +  cstmt.getInt(2));
			cat.debug("msgError: " +  cstmt.getString(3));
			cat.debug("numEvento: " +  cstmt.getInt(4));
			
			
			if (codError != 0){
				cat.error("Ocurrió un error al actualizar el estado del movimiento");
				throw new CustomerDomainException(
				"Ocurrió un error al realizar reversa", String
				.valueOf(codError), numEvento, msgError);
			}
			
		} catch (Exception e) {
			cat.error("Ocurrió un error al actualizar el estado del movimiento",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
				if (e instanceof CustomerDomainException)
					throw (CustomerDomainException)e;
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
		cat.debug("Fin:updateAbonadoPreactivo");
	}//fin updateAbonadoPreactivo
	
	
	public void liberarSeriesYTelefono(Long numAbonado) 
		throws CustomerDomainException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:liberarSeriesYTelefono");
			
			String call = getSQLDatosVenta("Ve_Servicios_solicitud_Pg","VE_LIBERAR_SERIESYTELEFONO_PR",4);
	
			cat.debug("sql[" + call + "]");
	
			cstmt = conn.prepareCall(call);
			if (cat.isDebugEnabled()){
	  			cat.debug("Numero Abonado:" + numAbonado.longValue());	  			
	  		}
			cstmt.setLong(1,numAbonado.longValue());
			
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			if (cat.isDebugEnabled())
				cat.debug("Inicio:liberarSeriesYTelefono:execute");
			cstmt.execute();
			if (cat.isDebugEnabled())
				cat.debug("Fin:liberarSeriesYTelefono:execute");
	
			codError=cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento=cstmt.getInt(4);
			
			if (cat.isDebugEnabled()){
				cat.debug("Código Error: " +  cstmt.getInt(2));
				cat.debug("msgError: " +  cstmt.getString(3));
				cat.debug("numEvento: " +  cstmt.getInt(4));
			}
			
			if (codError != 0){
				cat.error("Ocurrió un error al liberar series y telefono");
				throw new CustomerDomainException(
				"Ocurrió un error al liberar series y telefono", String
				.valueOf(codError), numEvento, msgError);
			}
			
		} catch (Exception e) {
			cat.error("Ocurrió un error al liberar series y telefono",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
				if (e instanceof CustomerDomainException)
					throw (CustomerDomainException)e;
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
		cat.debug("Fin:liberarSeriesYTelefono");
	}//fin liberarSeriesYTelefono
	
	//Inicio P-CSR-11002 JLGN 26-05-2011
	public DatosContrato datosVenta(String numVenta) 
	throws CustomerDomainException
{
	int codError = 0;
	String msgError = null;
	int numEvento = 0;
	Connection conn = null;
	conn = getConection();
	CallableStatement cstmt = null; 
	DatosContrato resultado = new DatosContrato();
	try {
		cat.debug("Inicio:datosVenta");
		
		String call = getSQLDatosVenta("VE_parametros_comerciales_PG","ve_datos_venta_pr",13);

		cat.debug("sql[" + call + "]");

		cstmt = conn.prepareCall(call);
		if (cat.isDebugEnabled()){
  			cat.debug("Numero Venta:" + numVenta);	  			
  		}
		cstmt.setLong(1,Long.parseLong(numVenta));
		cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
		cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
		cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
		cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
		cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
		cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
		cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
		cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
		cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
		cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);
		cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
		cstmt.registerOutParameter(13, java.sql.Types.NUMERIC);
		if (cat.isDebugEnabled())
			cat.debug("Inicio:datosVenta:execute");
		cstmt.execute();
		if (cat.isDebugEnabled())
			cat.debug("Fin:datosVenta:execute");

		codError=cstmt.getInt(11);
		msgError = cstmt.getString(12);
		numEvento=cstmt.getInt(13);
		
		if (cat.isDebugEnabled()){
			cat.debug("Código Error: " +  cstmt.getInt(11));
			cat.debug("msgError: " +  cstmt.getString(12));
			cat.debug("numEvento: " +  cstmt.getInt(13));
		}
		
		if (codError != 0){
			cat.error("Ocurrió un error al obtener datos de la venta");
			throw new CustomerDomainException(
			"Ocurrió un error al obtener datos de la venta", String
			.valueOf(codError), numEvento, msgError);
		}
		
		resultado.setNumVenta(numVenta);
		resultado.setFecVenta(cstmt.getString(2));
		resultado.setCodPuntoVenta(cstmt.getString(3));
		resultado.setNomPuntoVenta(cstmt.getString(4));
		//P-CSR-11002 JLGN 17-06-2011
		resultado.setCodBanco(cstmt.getString(5));
		resultado.setNumCuentaCorriente(cstmt.getString(6));
		resultado.setEntidad(cstmt.getString(7));
		resultado.setTipTarjeta(cstmt.getString(8));
		resultado.setNumTarjeta(cstmt.getString(9));
		resultado.setMoneda(cstmt.getString(10));
		
	} catch (Exception e) {
		cat.error("Ocurrió un error al obtener datos de la venta",e);
		if (cat.isDebugEnabled()) {
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException)e;
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
	cat.debug("Fin:datosVenta");
	return resultado;
}//fin liberarSeriesYTelefono
	//Fin P-CSR-11002 JLGN 26-05-2011
	
}