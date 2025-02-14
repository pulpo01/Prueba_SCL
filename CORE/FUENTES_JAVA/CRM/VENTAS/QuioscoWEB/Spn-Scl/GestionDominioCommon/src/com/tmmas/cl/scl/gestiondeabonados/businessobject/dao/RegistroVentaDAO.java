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

package com.tmmas.cl.scl.gestiondeabonados.businessobject.dao;

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
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.CelularDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ListadoVentasDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.MatrizEstadosDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ParametrosRegistroCargosDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.helper.Global;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.GaDocVentasDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.GaVentasDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RegistroVentaDTO;
import com.tmmas.cl.scl.parametrosgenerales.businessobject.dto.ParametrosGeneralesDTO;

public class RegistroVentaDAO extends ConnectionDAO{
	private static Category cat = Category.getInstance(RegistroVentaDAO.class);

	Global global = Global.getInstance();

	private Connection getConection() throws GeneralException
	{
		Connection conn = null;
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
		} catch (Exception e1) {
			conn = null;
			cat.error(" No se pudo obtener una conexión ", e1);
			throw new GeneralException("No se pudo obtener una conexión", e1);
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
	 * @throws GeneralException
	 */

	public RegistroVentaDTO getSecuenciaVenta(RegistroVentaDTO parametroEntrada) throws GeneralException{
		RegistroVentaDTO resultado=new RegistroVentaDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;

		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:getSecuenciaVenta");

			//INI-01 (AL) String call = getSQLDatosVenta("VE_intermediario_PG","VE_OBTIENE_SECUENCIA_PR",5);
			String call = getSQLDatosVenta("VE_intermediario_Quiosco_PG","VE_OBTIENE_SECUENCIA_PR",5);

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
			
			cat.debug("codError ["+codError+"]");
			cat.debug("msgError ["+msgError+"]");
			cat.debug("numEvento ["+numEvento+"]");
			
			if (codError != 0){
				cat.error("Ocurrió un error al obtener la secuencia de la venta");
				throw new GeneralException(
						"Ocurrió un error al obtener la secuencia de la venta", String
						.valueOf(codError), numEvento, msgError);
			}
			else
				resultado.setNumeroVenta(Long.parseLong(cstmt.getString(2)));

		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener la secuencia de la venta",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
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
	 * @throws GeneralException
	 */
	public RegistroVentaDTO getSecuenciaTransacabo(RegistroVentaDTO parametroEntrada) throws GeneralException{
		RegistroVentaDTO resultado=new RegistroVentaDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:getSecuenciaTransacabo");

			//INI-01 (AL) String call = getSQLDatosVenta("VE_intermediario_PG","VE_OBTIENE_SECUENCIA_PR",5);
			String call = getSQLDatosVenta("VE_intermediario_Quiosco_PG","VE_OBTIENE_SECUENCIA_PR",5);

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
			
			cat.debug("codError ["+codError+"]");
			cat.debug("msgError ["+msgError+"]");
			cat.debug("numEvento ["+numEvento+"]");

			if (codError != 0){
				cat.error("Ocurrió un error al obtener secuencia transacabo");
				throw new GeneralException(
						"Ocurrió un error al obtener secuencia transacabo", String
						.valueOf(codError), numEvento, msgError);
			}
			else
				resultado.setNumeroTransaccionVenta(Long.parseLong(cstmt.getString(2)));

		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener la secuencia de la transacabo",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
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
	 * @throws GeneralException
	 */
	public RegistroVentaDTO getPrefijoMin(RegistroVentaDTO entrada) throws GeneralException{
		RegistroVentaDTO resultado=null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:getPrefijoMin");

			//INI-01 String call = getSQLDatosVenta("VE_intermediario_PG","VE_OBTIENE_PREFIJO_NUM_PR",5);
			String call = getSQLDatosVenta("VE_intermediario_Quiosco_PG","VE_OBTIENE_PREFIJO_NUM_PR",5);

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
			
			cat.debug("codError ["+codError+"]");
			cat.debug("msgError ["+msgError+"]");
			cat.debug("numEvento ["+numEvento+"]");

			if (codError != 0){
				cat.error("Ocurrió un error al obtener prefijo numero celular");
				throw new GeneralException(
						"Ocurrió un error al obtener prefijo numero celular", String
						.valueOf(codError), numEvento, msgError);
			}
			else{
				resultado = entrada;
				resultado.setPrefijoMin(cstmt.getString(2));
			}
		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener prefijo numero celular",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
				if (e instanceof GeneralException)
					throw (GeneralException)e;
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
	 * @throws GeneralException
	 */
	public CelularDTO getNumeroCelularAut(CelularDTO celular) throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:getNumeroCelularAut");

			//INI-01 (AL) String call = getSQLDatosVenta("VE_intermediario_PG","VE_ObtieneNumeroCelularAut_PR",11);
			String call = getSQLDatosVenta("VE_intermediario_Quiosco_PG","VE_ObtieneNumeroCelularAut_PR",11);

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
			
			cat.debug("codError ["+codError+"]");
			cat.debug("msgError ["+msgError+"]");
			cat.debug("numEvento ["+numEvento+"]");

			if (codError != 0){
				cat.error("Ocurrió un error al obtener numero celular automatico");
				throw new GeneralException(
						"Ocurrió un error al obtener numero celular automatico", String
						.valueOf(codError), numEvento, msgError);
			}
			else{
				celular.setNumeroCelular(Long.parseLong(cstmt.getString(5)));
				celular.setTipoCelular(cstmt.getString(6));
				celular.setCategoria(cstmt.getString(7));
				celular.setFecBajaCelular(cstmt.getString(8));
			}

		} catch (GeneralException e) {
			cat.error("Ocurrió un error al obtener numero celular automatico",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw e;

		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener numero celular automatico",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
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
	 * @throws GeneralException
	 */

	public CelularDTO setReservaNumeroCelular(CelularDTO celular) throws GeneralException{

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:setReservaNumeroCelular");

			//INI-01 (AL) String call = getSQLDatosVenta("VE_intermediario_PG","VE_reserva_numero_celular_PR",14);
			String call = getSQLDatosVenta("VE_intermediario_Quiosco_PG","VE_reserva_numero_celular_PR",14);

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
			cstmt.setString(11,celular.getNomUsuarioOra());
			
			cstmt.registerOutParameter(12, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(14, java.sql.Types.NUMERIC);

			cat.debug("Inicio:setReservaNumeroCelular:execute");
			cstmt.execute();
			cat.debug("Fin:setReservaNumeroCelular:execute");

			codError=cstmt.getInt(12);
			msgError = cstmt.getString(13);
			numEvento=cstmt.getInt(14);
			
			cat.debug("codError ["+codError+"]");
			cat.debug("msgError ["+msgError+"]");
			cat.debug("numEvento ["+numEvento+"]");

			if (codError != 0){
				cat.error("Ocurrió un error al insertar en GA_RESNUMCEL");
				throw new GeneralException(
						"Ocurrió un error al insertar en GA_RESNUMCEL", String
						.valueOf(codError), numEvento, msgError);
			}	

		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al insertar en GA_RESNUMCEL",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
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
	 * @throws GeneralException
	 */

	public RegistroVentaDTO getSecuenciaPaquete(RegistroVentaDTO parametroEntrada) throws GeneralException{
		RegistroVentaDTO resultado=new RegistroVentaDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:getSecuenciaPaquete");

			//INI-01 (AL) String call = getSQLDatosVenta("VE_intermediario_PG","VE_OBTIENE_SECUENCIA_PR",5);
			String call = getSQLDatosVenta("VE_intermediario_Quiosco_PG","VE_OBTIENE_SECUENCIA_PR",5);

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
			
			cat.debug("codError ["+codError+"]");
			cat.debug("msgError ["+msgError+"]");
			cat.debug("numEvento ["+numEvento+"]");

			if (codError != 0){
				cat.error("Ocurrió un error al obtener la secuencia del Paquete");
				throw new GeneralException(
						"Ocurrió un error al obtener la secuencia del Paquete", String
						.valueOf(codError), numEvento, msgError);
			}	
			else
				resultado.setNumeroPaquete(cstmt.getString(2));


		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener la secuencia del Paquete",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
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

	public RegistroVentaDTO existePlanFreedomEnVenta(ParametrosRegistroCargosDTO parametrosCargos,ParametrosGeneralesDTO parametroProporVta,ParametrosGeneralesDTO parametroProporc1,ParametrosGeneralesDTO parametroProporc2 ) 
	throws GeneralException{
		RegistroVentaDTO registroventadto =new RegistroVentaDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:existePlanFreedomEnVenta");
			//INI-01 (AL) String call = getSQLDatosVenta("VE_servicios_venta_PG","VE_hay_pfreedom_en_venta_PR",8);
			String call = getSQLDatosVenta("VE_servicios_venta_Quiosco_PG","VE_hay_pfreedom_en_venta_PR",8);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,parametroProporVta.getValorparametro());
			cstmt.setInt(2,Integer.parseInt(parametrosCargos.getNumeroVenta()));
			cstmt.setInt(3,Integer.parseInt(parametroProporc1.getValorparametro()));
			cstmt.setInt(4,Integer.parseInt(parametroProporc1.getValorparametro()));
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
			
			cat.debug("codError ["+codError+"]");
			cat.debug("msgError ["+msgError+"]");
			cat.debug("numEvento ["+numEvento+"]");
			
			if (codError != 0){
				cat.error("Ocurrió un error al obtener la secuencia del Paquete");
				throw new GeneralException(
						"Ocurrió un error al obtener la secuencia del Paquete", String
						.valueOf(codError), numEvento, msgError);
			}	
			else{
				int resultado = cstmt.getInt(5);
				registroventadto.setExistePlanFreedom(resultado==1?true:false);
				cat.debug("RegistroVtaDAO:"+resultado);
			}
		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al consultar si existe plan freedom en venta",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
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
		calling.append(  "   SO_VENTAS(1).COD_VENDEALER:=?;");
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
		//INI-01 (AL) calling.append(  "   SO_VENTAS(1).IND_PORTADO:=?;");		
		//INI-01 (AL) calling.append(  "   VE_Servicios_Venta_PG.GA_INSERT_VENTA_PR( SO_VENTAS,?,?,? );");
		calling.append(  "   VE_Servicios_Venta_Quiosco_PG.GA_INSERT_VENTA_PR( SO_VENTAS,?,?,? );");
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
		calling.append(  "   SO_VENTAS(1).COD_MODVENTA:=?;");
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
		calling.append(  "   SO_VENTAS(1).nom_usuar_acerec:=?;");
		calling.append(  "   SO_VENTAS(1).cod_cliente:=?;");
		calling.append(  "   SO_VENTAS(1).MTO_GARANTIA:=?;");		
		//INI-01 (AL) calling.append(  "   ve_alta_cliente_pg.ga_update_estado_venta_pr( SO_VENTAS, ?, ?, ? );");
		calling.append(  "   VE_alta_cliente_Quiosco_PG.ga_update_estado_venta_pr( SO_VENTAS, ?, ?, ? );");
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
	 * @throws GeneralException
	 */   
	public String  getCodProcesoVenta(MatrizEstadosDTO matrizEstadosDTO) throws GeneralException{

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
			throw new GeneralException("No se pudo obtener una conexión",e1);
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
				cat.error(" Ocurrió un error al recuperar codigo de proceso de venta");
				throw new GeneralException(String.valueOf(codError),
						numEvento, msgError); 
			}

			cat.debug("Recuperando data...");

			cat.debug("Codigo proceso venta[" + codigoProcesoVenta + "]");

		} catch (GeneralException e) {
			e.printStackTrace();
			cat.error("Ocurrió un error general al Recuperar codigo de proceso de venta",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw e;
		}catch (Exception e) 
		{
			e.printStackTrace();
			cat.error("Ocurrió un error general al recuperar codigo de proceso de venta",e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error general  al recuperar codigo de proceso de venta",e);

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
	 * @throws GeneralException
	 */   
	public String  getCodEstadoFinalVenta(MatrizEstadosDTO matrizEstadosDTO) throws GeneralException{

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
			throw new GeneralException("No se pudo obtener una conexión",e1);
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
				cat.error("Ocurrió un error al recuperar codigo de estado final de la venta");
				throw new GeneralException(String.valueOf(codError),
						numEvento, msgError); 
			}

			cat.debug("Recuperando data...");

			cat.debug("Codigo Estado venta[" + codigoEstadoFinalVenta + "]");

		} catch (GeneralException e) {

			e.printStackTrace();
			cat.error("Ocurrió un error general al recuperar codigo de estado final de la venta",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw e;
		}catch (Exception e) 
		{

			e.printStackTrace();
			cat.error("Ocurrió un error general al recuperar codigo de estado final de la venta",e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error general al recuperar codigo de estado final de la venta",e);

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
	 * @throws GeneralException
	 */   
	public void insertVenta(GaVentasDTO gaVentasDTO) throws GeneralException{

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
			throw new GeneralException("No se pudo obtener una conexión",e1);
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
			cstmt.setString(1,"1");
			cstmt.setString(2,gaVentasDTO.getCodOficina());
			cstmt.setString(3,gaVentasDTO.getCodTipcomis());
			cstmt.setLong(4,gaVentasDTO.getCodVendedor().longValue());
			cstmt.setLong(5,gaVentasDTO.getCodVendedorAgente().longValue());
			if (gaVentasDTO.getCodVenDealer().longValue() == 0)
				cstmt.setString(6,null);
			else
				cstmt.setString(6,String.valueOf(gaVentasDTO.getCodVenDealer().longValue()));
			cstmt.setLong(7,gaVentasDTO.getNumUnidades().longValue());
			//cstmt.setDate(8,gaVentasDTO.getFecVenta());
			cstmt.setTimestamp(8, new java.sql.Timestamp(gaVentasDTO.getFecVenta().getTime()));
			cstmt.setString(9,gaVentasDTO.getCodRegion());
			cstmt.setString(10,gaVentasDTO.getCodProvincia());
			cstmt.setString(11,gaVentasDTO.getCodCiudad());	    
			cstmt.setString(12,gaVentasDTO.getIndEstVenta());
			cstmt.setLong(13,gaVentasDTO.getNumTransaccion().longValue());
			cstmt.setLong(14,gaVentasDTO.getIndPasoCob().longValue());
			cstmt.setString(15,gaVentasDTO.getNomUsuarVta());
			cstmt.setString(16,gaVentasDTO.getIndVenta());
			cstmt.setString(17,gaVentasDTO.getCodMoneda());
			cstmt.setString(18,gaVentasDTO.getCodCausaRec());
			if (gaVentasDTO.getImpVenta()!=null)
				cstmt.setDouble(19,gaVentasDTO.getImpVenta().doubleValue());
			else
				cstmt.setString(19,null);
			cstmt.setString(20,gaVentasDTO.getCodTipContrato());
			cstmt.setString(21,gaVentasDTO.getNumContrato());
			cstmt.setLong(22,gaVentasDTO.getIndTipVenta().longValue());
			cstmt.setLong(23,gaVentasDTO.getCodCliente().longValue());
			cstmt.setLong(24,gaVentasDTO.getCodModVenta().longValue());
			cstmt.setString(25,gaVentasDTO.getTipValor());
			cstmt.setString(26,gaVentasDTO.getCodCuota());
			cstmt.setString(27,gaVentasDTO.getCodTipTarjeta());
			cstmt.setString(28,gaVentasDTO.getNumTarjeta());
			cstmt.setString(29,gaVentasDTO.getCodAutTarj());
			if(gaVentasDTO.getFecVenciTarj() == null){
				cstmt.setDate(30,null);
			}else{
				cstmt.setDate(30,new java.sql.Date(gaVentasDTO.getFecVenciTarj().getTime()));
			}
			cstmt.setString(31,gaVentasDTO.getCodBancoTarj());
			cstmt.setString(32,gaVentasDTO.getNumCTACORR());
			cstmt.setString(33,gaVentasDTO.getNumCheque());
			cstmt.setString(34,gaVentasDTO.getCodBanco());
			cstmt.setString(35,gaVentasDTO.getCodSucursal());
			cstmt.setDate(36,gaVentasDTO.getFecCumplimenta());
			cstmt.setTimestamp(37, new java.sql.Timestamp(gaVentasDTO.getFecRecDocum().getTime()));
			if (gaVentasDTO.getFecAcePrec() == null){
				cstmt.setDate(38, null);
			}
			else{
				cstmt.setTimestamp(38, new java.sql.Timestamp(gaVentasDTO.getFecAcePrec().getTime()));
			}
			cstmt.setString(39,gaVentasDTO.getNomUsuarAcerec());
			cstmt.setString(40,gaVentasDTO.getNomUsuarRecDoc());
			cstmt.setString(41,gaVentasDTO.getNomUsuarCumpl());
			cstmt.setLong(42,gaVentasDTO.getNumVenta().longValue());
			cstmt.setString(43,gaVentasDTO.getIndOfiter());
			cstmt.setString(44,gaVentasDTO.getIndChkDicom());
			cstmt.setString(45,gaVentasDTO.getTipFoliacion());
			cstmt.setString(46,gaVentasDTO.getCodTipDocumento());
			cstmt.setString(47,gaVentasDTO.getCodOperadora());
			cstmt.setString(48,gaVentasDTO.getCodPlaza());
			//INI-01 (AL) cstmt.setString(49,gaVentasDTO.getIndPortado());

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
				cat.error("Ocurrió un error al insertar la venta");
				throw new GeneralException(String.valueOf(codError),
						numEvento, msgError); 
			}

			cat.debug("Recuperando data...");

			cat.debug("Codigo Error PL[" + codError + "]");

		} catch (GeneralException e) {

			e.printStackTrace();
			cat.error("Ocurrió un error general al insertar la venta",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw e;
		}catch (Exception e) 
		{

			e.printStackTrace();
			cat.error("Ocurrió un error general al insertar la venta",e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error general al insertar la venta",e);

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
			cat.debug("insertVenta():end");
		}

	}

	public String getNumUnidades(String numVenta)throws GeneralException{

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
			throw new GeneralException("No se pudo obtener una conexión",e1);
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
				cat.error(" Ocurrió un error al recuperar numero de unidades");
				throw new GeneralException(String.valueOf(codError),
						numEvento, msgError); 
			}

			cat.debug("Recuperando data...");

			cat.debug("Numero Unidades[" + numUnidades + "]");

		} catch (GeneralException e) {

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
			throw new GeneralException(
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


	public String getCodPlazaCliente(Long CodCliente)throws GeneralException{

		if (cat.isDebugEnabled()) {
			cat.debug("getCodPlazaCliente():start");
		}
		int codError = 0;
		String msgError = null;
		int numEvento = 0;

		String call=null;
		String codPlazaCliente=null;
		Connection conn = null;
		CallableStatement cstmt=null;
		//se recuepera coneccion del DataSources
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
		} 
		catch (Exception e1) {
			cat.error(" No se pudo obtener una conexión ", e1);
			throw new GeneralException("No se pudo obtener una conexión",e1);
		}
		try {

			//INI-01 (AL) call="{call VE_intermediario_PG.VE_ObtienePlaza_Cliente_PR(?,?,?,?,?)}";
			call="{call VE_intermediario_Quiosco_PG.VE_ObtienePlaza_Cliente_PR(?,?,?,?,?)}";
			
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

			cstmt.registerOutParameter(2, oracle.jdbc.driver.OracleTypes.VARCHAR);
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
				cat.error(" Ocurrió un error al recuperar el Código Plaza por cliente");
				throw new GeneralException(String.valueOf(codError),
						numEvento, msgError); 
			}
			else
				codPlazaCliente=cstmt.getString(2);

			cat.debug("Recuperando data...");

			cat.debug("Codigo Plaza por Cliente[" + codPlazaCliente + "]");

		} catch (GeneralException e) {

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
			throw new GeneralException(
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
			cat.debug("getCodPlazaCliente():end");
		}

		return codPlazaCliente;

	} 	

	public String getCodPlazaOficina(String CodOficina)throws GeneralException{

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
			throw new GeneralException("No se pudo obtener una conexión",e1);
		}
		try {

			//INI-01 (AL) call="{call VE_intermediario_PG.VE_ObtienePlaza_Oficina_PR(?,?,?,?,?)}";
			call="{call VE_intermediario_Quiosco_PG.VE_ObtienePlaza_Oficina_PR(?,?,?,?,?)}";

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

			cstmt.registerOutParameter(2, oracle.jdbc.driver.OracleTypes.VARCHAR);

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
				throw new GeneralException(String.valueOf(codError),
						numEvento, msgError); 
			}

			cat.debug("Recuperando data...");

			cat.debug("Codigo Plaza por Oficina[" + codPlazaOficina + "]");

		} catch (GeneralException e) {

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
			throw new GeneralException(
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
			cat.debug("getCodPlazaOficina():end");
		}

		return codPlazaOficina;

	} 	
	public void updateVentasEscenarioB(GaVentasDTO gaVentasDTO)throws GeneralException{

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
			throw new GeneralException("No se pudo obtener una conexión",e1);
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
			cstmt.setString(3,gaVentasDTO.getTipValor());
			cstmt.setDouble(4,gaVentasDTO.getImpVenta().doubleValue());
			cstmt.setString(5,gaVentasDTO.getNumContrato());
			cstmt.setLong(6,gaVentasDTO.getNumVenta().longValue());			
			cstmt.setLong(7,gaVentasDTO.getCodModVenta().longValue());

			if (cat.isDebugEnabled()) {
				cat.debug(" Registrando salidas");
			}
			//Se procede a descomentar cuando devuelva errores

			cstmt.registerOutParameter(8, oracle.jdbc.driver.OracleTypes.NUMBER);
			cstmt.registerOutParameter(9, oracle.jdbc.driver.OracleTypes.VARCHAR);
			cstmt.registerOutParameter(10, oracle.jdbc.driver.OracleTypes.NUMBER);

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

			codError =cstmt.getInt(8);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(9);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(10);
			cat.debug("numEvento[" + numEvento + "]");
			cstmt=null;

			if (codError != 0) {
				cat.error(" Ocurrió un error al Insertar Escenario B");
				throw new GeneralException(String.valueOf(codError),
						numEvento, msgError); 
			}

			cat.debug("Recuperando data...");

			cat.debug("Codigo error Escenario B[" + codError + "]");

		} catch (GeneralException e) {

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
			throw new GeneralException(
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
	public void updateVentasEscenarioC(GaVentasDTO gaVentasDTO)throws GeneralException{

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
			throw new GeneralException("No se pudo obtener una conexión",e1);
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
			cstmt.setString(3,gaVentasDTO.getTipValor());
			cstmt.setDouble(4,gaVentasDTO.getImpVenta().doubleValue());
			cstmt.setString(5,gaVentasDTO.getNumContrato());
			cstmt.setFloat(6,gaVentasDTO.getMtoGarantia().floatValue());

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
				cat.error(" Ocurrió un error al Insertar Escenario C");
				throw new GeneralException(String.valueOf(codError),
						numEvento, msgError); 
			}

			cat.debug("Recuperando data...");

			cat.debug("Codigo error Escenario C[" + codError + "]");

		} catch (GeneralException e) {

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
			throw new GeneralException(
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
	public void updateVentasEscenarioD(GaVentasDTO gaVentasDTO)throws GeneralException{

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
			throw new GeneralException("No se pudo obtener una conexión",e1);
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
			cat.debug("gaVentasDTO.getIndEstVenta() ["+gaVentasDTO.getIndEstVenta()+"]");		
			cstmt.setLong(2,gaVentasDTO.getNumTransaccion().longValue());
			cat.debug("gaVentasDTO.getNumTransaccion() ["+gaVentasDTO.getNumTransaccion()+"]");			
			cstmt.setDouble(3,gaVentasDTO.getImpVenta().doubleValue());
			cat.debug("gaVentasDTO.getImpVenta() ["+gaVentasDTO.getImpVenta()+"]");
			cstmt.setString(4,gaVentasDTO.getNumContrato());
			cat.debug("gaVentasDTO.getNumContrato() ["+gaVentasDTO.getNumContrato()+"]");
			cstmt.setLong(5,gaVentasDTO.getNumVenta().longValue());
			cat.debug("gaVentasDTO.getNumVenta() ["+gaVentasDTO.getNumVenta()+"]");
			cstmt.setString(6,gaVentasDTO.getNomUsuarAcerec());
			cat.debug("gaVentasDTO.getNomUsuarAcerec() ["+gaVentasDTO.getNomUsuarAcerec()+"]");						
			cstmt.setString(7,gaVentasDTO.getCodCliente().toString() );
			cat.debug("gaVentasDTO.getNomUsuarAcerec() ["+gaVentasDTO.getNomUsuarAcerec()+"]");			
			cstmt.setFloat(8,gaVentasDTO.getMtoGarantia().floatValue());
			cat.debug("gaVentasDTO.getMtoGarantia() ["+gaVentasDTO.getMtoGarantia().floatValue()+"]");
			
			if (cat.isDebugEnabled()) {
				cat.debug(" Registrando salidas");
			}
			//Se procede a descomentar cuando devuelva errores

			cstmt.registerOutParameter(9, oracle.jdbc.driver.OracleTypes.NUMBER);
			cstmt.registerOutParameter(10, oracle.jdbc.driver.OracleTypes.VARCHAR);
			cstmt.registerOutParameter(11, oracle.jdbc.driver.OracleTypes.NUMBER);

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

			codError =cstmt.getInt(9);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(10);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(11);
			cat.debug("numEvento[" + numEvento + "]");
			cstmt=null;

			if (codError != 0) {
				cat.error(" Ocurrió un error al Insertar Escenario D");
				throw new GeneralException(String.valueOf(codError),
						numEvento, msgError); 
			}

			cat.debug("Recuperando data...");

			cat.debug("Codigo error Escenario D[" + codError + "]");

		} catch (GeneralException e) {
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
			cat.error("Ocurrió un error general al Insertar Escenario D",e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
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
	public void updateVentasEscenarioA(GaVentasDTO gaVentasDTO)throws GeneralException{

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
			throw new GeneralException("No se pudo obtener una conexión",e1);
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
			cstmt.setString(3,gaVentasDTO.getTipValor());
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
				throw new GeneralException(String.valueOf(codError),
						numEvento, msgError); 
			}

			cat.debug("Recuperando data...");

			cat.debug("Codigo error Escenario A[" + codError + "]");

		} catch (GeneralException e) {

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
			throw new GeneralException(
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

	public void updateVenta(GaVentasDTO gaVentasDTO)throws GeneralException{

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

			cstmt.setDouble(1,gaVentasDTO.getImpVenta().doubleValue());
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
				throw new GeneralException(String.valueOf(codError),
						numEvento, msgError); 
			}

			cat.debug("Recuperando data...");

			cat.debug("Codigo error[" + codError + "]");

		} catch (GeneralException e) {
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
			throw new GeneralException(
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
	 * @throws GeneralException
	 */
	public RegistroVentaDTO getMinMDN(RegistroVentaDTO entrada) 
	throws GeneralException{
		RegistroVentaDTO resultado= null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:getMinMDN");

			//INI-01 (AL) String call = getSQLDatosVenta("VE_intermediario_PG","VE_getMinMDN_PR",5);
			String call = getSQLDatosVenta("VE_intermediario_Quiosco_PG","VE_getMinMDN_PR",5);

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
				throw new GeneralException(
						"Ocurrió un error al obtener minMDN", String
						.valueOf(codError), numEvento, msgError);
			}
			else{
				resultado = entrada;
				resultado.setMinMDN(cstmt.getString(2));
			}

		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener minMDN",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
				if (e instanceof GeneralException)
					throw (GeneralException)e;
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

	/**
	 * realiza reversa de la venta
	 * @param entrada
	 * @return 
	 * @throws GeneralException
	 */
	public void reversaVenta(GaVentasDTO entrada) 
	throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:reversaVenta");

			//INI-01 (AL) String call = getSQLDatosVenta("Ve_Servicios_Venta_Pg","VE_reversaVentas_PR",8);
			String call = getSQLDatosVenta("Ve_Servicios_Venta_Quiosco_Pg","VE_reversaVentas_PR",8);

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
			cstmt.setLong(5,entrada.getNumTransaccion().longValue());
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			if (cat.isDebugEnabled())
				cat.debug("Inicio:reversaVenta:execute");
			cstmt.execute();
			if (cat.isDebugEnabled())
				cat.debug("Fin:reversaVenta:execute");

			codError=cstmt.getInt(6);
			msgError = cstmt.getString(7);
			numEvento=cstmt.getInt(8);
			
			if (cat.isDebugEnabled()){
				cat.debug("Código Error: " +  cstmt.getInt(6));
				cat.debug("msgError: " +  cstmt.getString(7));
				cat.debug("numEvento: " +  cstmt.getInt(8));
			}

			if (codError != 0){
				cat.error("Ocurrió un error al realizar reversa");
				throw new GeneralException(
						"Ocurrió un error al realizar reversa", String
						.valueOf(codError), numEvento, msgError);
			}

		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al realizar reversa",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
				if (e instanceof GeneralException)
					throw (GeneralException)e;
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

	//Incidencia 45086 15-11-2007
	/**
	 * Ejecuta PL numeración manual
	 * @param celular
	 * @return celular
	 * @throws GeneralException
	 */

	public void setNumeracionManual(CelularDTO celular) throws GeneralException{

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:setNumeracionManual");

			//INI-01 (AL) String call = getSQLDatosVenta("VE_intermediario_PG","VE_numeracion_manual_PR",5);
			String call = getSQLDatosVenta("VE_intermediario_Quiosco_PG","VE_numeracion_manual_PR",5);

			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			
			cstmt.setLong(1,celular.getNumeroCelular());
			cat.debug("celular.getNumeroCelular() ["+celular.getNumeroCelular()+"]");
			cstmt.setString(2,celular.getTipoCelular());
			cat.debug("celular.getTipoCelular() ["+celular.getTipoCelular()+"]");
			
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cat.debug("Inicio:setNumeracionManual:execute");
			cstmt.execute();
			cat.debug("Fin:setNumeracionManual:execute");

			codError=cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento=cstmt.getInt(5);
			
			cat.debug("codError ["+codError+"]");
			cat.debug("msgError ["+msgError+"]");
			cat.debug("numEvento ["+numEvento+"]");

			if (codError != 0){
				cat.error("Ocurrió un error al ejecutar Numeración Manual");
				throw new GeneralException(
						"Ocurrió un error al insertar en GA_RESNUMCEL", String
						.valueOf(codError), numEvento, msgError);
			}	

		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al ejecutar Numeración Manual",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
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

		cat.debug("Fin:setNumeracionManual");

	}//fin setNumeracionManual		

	/**
	 * realiza desreserva de numero celular
	 * @param entrada
	 * @return 
	 * @throws GeneralException
	 */
	public void desreservaCelular(GaVentasDTO entrada) 
	throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:desreservaCelular");

			//INI-01 (AL) String call = getSQLDatosVenta("Ve_Servicios_Venta_Pg","VE_eliminarescel_PR",5);
			String call = getSQLDatosVenta("Ve_Servicios_Venta_Quiosco_Pg","VE_eliminarescel_PR",5);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			if (cat.isDebugEnabled()){
				cat.debug("Numero Venta:" + entrada.getNumVenta().longValue());

			}
			cstmt.setLong(1,entrada.getNumVenta().longValue());
			cstmt.setLong(2,entrada.getNumTransaccion().longValue());
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			if (cat.isDebugEnabled())
				cat.debug("Inicio:desreservaCelular:execute");
			cstmt.execute();
			if (cat.isDebugEnabled())
				cat.debug("Fin:desreservaCelular:execute");

			codError=cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento=cstmt.getInt(5);
			
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");
			
			if (cat.isDebugEnabled()){
				cat.debug("Código Error: " +  cstmt.getInt(3));
				cat.debug("msgError: " +  cstmt.getString(4));
				cat.debug("numEvento: " +  cstmt.getInt(5));
			}

			if (codError != 0){
				cat.error("Ocurrió un error al realizar desreserva de celular");
				throw new GeneralException(
						"Ocurrió un error al realizar desreserva de celular", String
						.valueOf(codError), numEvento, msgError);
			}

		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al realizar desreserva de celular",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
				if (e instanceof GeneralException)
					throw (GeneralException)e;
			}
			throw new GeneralException(e);
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
		cat.debug("Fin:desreservaCelular");
	}//fin desreservaCelular

	/**
	 * Graba contrato en tabla ga_docventa
	 * @param gaVentasDTO
	 * @return gaDocVentasDTO
	 * @throws GeneralException
	 */

	public GaDocVentasDTO insertGaDocVentas(GaDocVentasDTO gaDocVentasDTO) 
	throws GeneralException {

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
			throw new GeneralException(
					"No se pudo obtener una conexión", e1);
		}
		try {
			//INI-01 (AL) call = getSQLDatosVenta("Ve_Servicios_Venta_Pg","VE_inserta_ga_docventa_PR",6);				
			call = getSQLDatosVenta("Ve_Servicios_Venta_Quiosco_Pg","VE_inserta_ga_docventa_PR",6);
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
				cat.error("Ocurrió un error general al insertar en tabla ga_docventa");
				throw new GeneralException(String.valueOf(codError),
						numEvento, msgError);
			}
			else{
				gaDocVentasDTO.setTransaccionOK(true);
			}

			cat.debug("Recuperando data...");

		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			System.out.println("error2 ");
			e.printStackTrace();
			cat.error("Ocurrió un error general al insertar en tabla ga_docventa", e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof GeneralException ) throw (GeneralException) e;

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
			cat.debug("uOcurrió un error general al insertar en tabla ga_docventa:end");
		}
		return gaDocVentasDTO;
	}	
	//Fin 45086 15-11-2007 

	public ListadoVentasDTO[] getVentasXVendedor(ListadoVentasDTO entrada) 
	throws GeneralException
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

			//INI-01 (AL) String call = getSQLDatosVenta("Ve_Servicios_Venta_Pg","VE_obtiene_VtasVendedor_PR",9);
			String call = getSQLDatosVenta("Ve_Servicios_Venta_Quiosco_Pg","VE_obtiene_VtasVendedor_PR",9);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cat.debug("Execute Antes");
			if(entrada.getCodigoVendedor().longValue() == -1 ) entrada.setCodigoVendedor(new Long(0));
			cstmt.setLong(1,entrada.getCodigoVendedor().longValue());
			cat.debug("Execute cod vendedor : " + entrada.getCodigoVendedor().longValue());
			if(entrada.getNroVenta() == null ) entrada.setNroVenta(new Long(0));
			cstmt.setLong(2,entrada.getNroVenta().longValue());
			cat.debug("Execute nro venta : " + entrada.getNroVenta().longValue());
			if(entrada.getCodOficina().trim().equals("-1") ) entrada.setCodOficina("0");
			cstmt.setString(3,entrada.getCodOficina());
			cat.debug("Execute cod oficina : " + entrada.getCodOficina());
			cstmt.setString(4,entrada.getFechaDesde());
			cat.debug("Execute fecha desde : " + entrada.getFechaDesde());
			cstmt.setString(5,entrada.getFechaHasta());
			cat.debug("Execute fecha hasta : " + entrada.getFechaHasta());
			cstmt.registerOutParameter(6, OracleTypes.CURSOR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);
			cstmt.execute();
			cat.debug("Execute Despues");

			codError = cstmt.getInt(7);
			msgError = cstmt.getString(8);
			numEvento = cstmt.getInt(9);

			cat.debug("codError ["+codError+"]");
			cat.debug("msgError ["+msgError+"]");
			cat.debug("numEvento ["+numEvento+"]");
			
			if (codError != 0) {
				cat.debug("NO encontro registros");
				throw new GeneralException(String.valueOf(codError),
						numEvento, msgError);
			} else {
				rs = (ResultSet)cstmt.getObject(6);
				ArrayList lista = new ArrayList();
				while (rs.next()) {
					ListadoVentasDTO venta = new ListadoVentasDTO();							
					venta.setNroVenta(new Long(rs.getLong(1)));							
					venta.setFechaVenta(rs.getString(2));							
					venta.setCodOficina(rs.getString(3));
					venta.setDescOficina(rs.getString(4));
					venta.setCodigoVendedor(new Long(rs.getLong(5)));
					venta.setDescVendedor(rs.getString(6));
					venta.setCantidadVendida(new Long(rs.getLong(7)));					
					venta.setMonto(new Long(rs.getLong(8)));							
					lista.add(venta);
				}

				resultado = (ListadoVentasDTO[])ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(),
						ListadoVentasDTO.class);	
			}

		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error(global.errorgetListado(), e);
			throw new GeneralException(global.errorgetListado(), e);

		} finally {
			if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {	
				if (rs != null) {
					rs.close();
				}
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

	/**
	 * @author rlozano
	 * @description Método que realiza la Inserción en GA_VENTAS
	 * @param gaVentasDTO
	 * @return  
	 * @throws GeneralException
	 */   
	public GaVentasDTO getVenta(GaVentasDTO gaVentasDTO) throws GeneralException{

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
			throw new GeneralException("No se pudo obtener una conexión",e1);
		}
		try {

			//INI-01 (AL) call = getSQLDatosVenta("VE_crea_linea_venta_PG","ge_rec_venta_pr",72);		
			call = getSQLDatosVenta("VE_crea_linea_venta_quiosco_PG","ge_rec_venta_pr",71);
			if (cat.isDebugEnabled()) {
				cat.debug("sql[" + call + "]");
			}
			cstmt = conn.prepareCall(call);

			if (cat.isDebugEnabled()) {
				cat.debug("Registrando Entradas");				
			}

			cstmt.setLong(1,gaVentasDTO.getNumVenta().longValue());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8, java.sql.Types.DATE);
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(13, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(14, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(15, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(18, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(19, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(20, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(21, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(22, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(23, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(24, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(25, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(26, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(27, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(28, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(29, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(30, java.sql.Types.DATE);
			cstmt.registerOutParameter(31, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(32, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(33, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(34, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(35, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(36, java.sql.Types.DATE);
			cstmt.registerOutParameter(37, java.sql.Types.DATE);
			cstmt.registerOutParameter(38, java.sql.Types.DATE);
			cstmt.registerOutParameter(39, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(40, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(41, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(42, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(43, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(44, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(45, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(46, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(47, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(48, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(49, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(50, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(51, java.sql.Types.DATE);
			cstmt.registerOutParameter(52, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(53, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(54, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(55, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(56, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(57, java.sql.Types.DATE);
			cstmt.registerOutParameter(58, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(59, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(60, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(61, java.sql.Types.DATE);
			cstmt.registerOutParameter(62, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(63, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(64, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(65, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(66, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(67, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(68, java.sql.Types.NUMERIC);
			//INI-01 (AL)cstmt.registerOutParameter(69, java.sql.Types.NUMERIC);
			
			cstmt.registerOutParameter(69, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(70, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(71, java.sql.Types.NUMERIC);

			if (cat.isDebugEnabled()) {
				cat.debug(" Registrando salidas");
			}

			cstmt.registerOutParameter(69, java.sql.Types.NUMERIC);		           
			cstmt.registerOutParameter(70, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(71, java.sql.Types.NUMERIC);
			//Se procede a descomentar cuando devuelva errores

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

			codError =cstmt.getInt(69);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(70);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(71);
			cat.debug("numEvento[" + numEvento + "]");

			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar la venta");
				throw new GeneralException(String.valueOf(codError),
						numEvento, msgError); 
			}

			cat.debug("Recuperando data...");

			gaVentasDTO.setCodProducto(new Long(cstmt.getInt(2)));
			gaVentasDTO.setCodOficina(cstmt.getString(3));
			gaVentasDTO.setCodTipcomis(cstmt.getString(4));
			gaVentasDTO.setCodVendedor(new Long(cstmt.getInt(5)));
			gaVentasDTO.setCodVendedorAgente(new Long(cstmt.getInt(6)));
			gaVentasDTO.setNumUnidades(new Long(cstmt.getInt(7)));
			gaVentasDTO.setFecVenta(cstmt.getDate(8));
			gaVentasDTO.setCodRegion(cstmt.getString(9));
			gaVentasDTO.setCodProvincia(cstmt.getString(10));
			gaVentasDTO.setCodCiudad(cstmt.getString(11));			
			gaVentasDTO.setIndEstVenta(cstmt.getString(12));
			cat.debug("gaVentasDTO.setIndEstVenta ["+gaVentasDTO.getIndEstVenta()+"]");
			gaVentasDTO.setNumTransaccion(new Long(cstmt.getInt(13)));
			gaVentasDTO.setIndPasoCob(new Long(cstmt.getInt(14)));
			gaVentasDTO.setNomUsuarVta(cstmt.getString(15));
			gaVentasDTO.setIndVenta(cstmt.getString(16));
			gaVentasDTO.setCodMoneda(cstmt.getString(17));
			gaVentasDTO.setCodCausaRec(cstmt.getString(18));
			gaVentasDTO.setImpVenta(new Float(cstmt.getFloat(19)));
			gaVentasDTO.setCodTipContrato(cstmt.getString(20));
			gaVentasDTO.setNumContrato(cstmt.getString(21));
			gaVentasDTO.setIndTipVenta(new Long(cstmt.getInt(22)));
			gaVentasDTO.setCodCliente(new Long(cstmt.getInt(23)));
			gaVentasDTO.setCodModVenta(new Long(cstmt.getInt(24)));
			gaVentasDTO.setTipValor(String.valueOf(cstmt.getInt(25)));
			gaVentasDTO.setCodCuota(cstmt.getString(26));
			gaVentasDTO.setCodTipTarjeta(cstmt.getString(27));
			gaVentasDTO.setNumTarjeta(cstmt.getString(28));
			gaVentasDTO.setCodAutTarj(cstmt.getString(29));
			gaVentasDTO.setFecVenciTarj(cstmt.getDate(30));
			gaVentasDTO.setCodBancoTarj(cstmt.getString(31));
			gaVentasDTO.setNumCTACORR(cstmt.getString(32));
			gaVentasDTO.setNumCheque(cstmt.getString(33));
			gaVentasDTO.setCodBanco(cstmt.getString(34));
			gaVentasDTO.setCodSucursal(cstmt.getString(35));
			gaVentasDTO.setFecCumplimenta(cstmt.getDate(36));
			gaVentasDTO.setFecRecDocum(cstmt.getDate(37));
			gaVentasDTO.setFecAcePrec(cstmt.getDate(38));
			gaVentasDTO.setNomUsuarAcerec(cstmt.getString(39));
			gaVentasDTO.setNomUsuarRecDoc(cstmt.getString(40));
			gaVentasDTO.setNomUsuarCumpl(cstmt.getString(41));
			gaVentasDTO.setIndOfiter(cstmt.getString(42));
			gaVentasDTO.setIndChkDicom(String.valueOf(cstmt.getInt(43)));
			gaVentasDTO.setNumConsulta(new Long(cstmt.getInt(44)));
			gaVentasDTO.setCodVenDealer(new Long(cstmt.getInt(45)));
			gaVentasDTO.setNumFolDealer(new Long(cstmt.getInt(46)));
			gaVentasDTO.setCodDocDealer(new Long(cstmt.getInt(47)));
			gaVentasDTO.setIndDocComp(new Long(cstmt.getInt(48)));
			gaVentasDTO.setObsInCump(cstmt.getString(49));
			gaVentasDTO.setCodCausaRep(new Long(cstmt.getInt(50)));
			gaVentasDTO.setFecRecProv(cstmt.getDate(51));
			gaVentasDTO.setNomUsuarRecProv(cstmt.getString(52));
			gaVentasDTO.setNumDias(new Long(cstmt.getInt(53)));
			gaVentasDTO.setObsRecProv(String.valueOf(cstmt.getInt(54)));
			gaVentasDTO.setImpAbono(new Long(cstmt.getInt(55)));
			gaVentasDTO.setIndAbono(new Long(cstmt.getInt(56)));
			gaVentasDTO.setFecRecepAdmVtas(cstmt.getDate(57));
			gaVentasDTO.setUsuRecepAdmVtas(cstmt.getString(58));
			gaVentasDTO.setObsGralCumpl(cstmt.getString(59));
			gaVentasDTO.setIndContTelef(new Long(cstmt.getInt(60)));
			gaVentasDTO.setFechaContTelef(cstmt.getDate(61));
			gaVentasDTO.setUsuarioContTelef(cstmt.getString(62));
			gaVentasDTO.setMtoGarantia(new Float(cstmt.getFloat(63)));
			gaVentasDTO.setTipFoliacion(cstmt.getString(64));
			gaVentasDTO.setCodTipDocumento(String.valueOf(cstmt.getInt(65)));
			gaVentasDTO.setCodPlaza(cstmt.getString(66));
			gaVentasDTO.setCodOperadora(cstmt.getString(67));
			gaVentasDTO.setNumProceso(new Long(cstmt.getInt(68)));     
			//INI-01 (AL) gaVentasDTO.setIndPortado(cstmt.getString(69));
			gaVentasDTO.setNumDecimalBD(2);


		} catch (GeneralException e) {

			e.printStackTrace();
			cat.error("Ocurrió un error general al insertar la venta",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw e;
		}catch (Exception e) 
		{

			e.printStackTrace();
			cat.error("Ocurrió un error general al insertar la venta",e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error general al insertar la venta",e);

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
			cat.debug("insertVenta():end");
		}

		return gaVentasDTO;
	}
	
	
	public CelularDTO getInfoCelular(CelularDTO celular) throws GeneralException{

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:getInfoCelular");

			String call = getSQLDatosVenta("ve_portabilidad_pg","ve_obtiene_info_mdn_pr",8);

			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			
			cstmt.setLong(1,celular.getNumeroCelular());
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getInfoCelular:execute");
			cstmt.execute();
			cat.debug("Fin:getInfoCelular:execute");

			codError=cstmt.getInt(6);
			msgError = cstmt.getString(7);
			numEvento=cstmt.getInt(8);
			
			cat.debug("codError ["+codError+"]");
			cat.debug("msgError ["+msgError+"]");
			cat.debug("numEvento ["+numEvento+"]");

			if (codError != 0){
				cat.error("Ocurrió un error getInfoCelular");
				throw new GeneralException(
						"Ocurrió un error getInfoCelular", String
						.valueOf(codError), numEvento, msgError);
			}else{
				celular.setCentral(cstmt.getString(2));
				celular.setCodigoUso(cstmt.getString(3));
				celular.setCategoria(cstmt.getString(4));
				celular.setCodSubAlm(cstmt.getString(5));
				
			}

		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error getInfoCelular",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
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
	
	
	private String getSQLUpdateAcepventa(){
		StringBuffer calling = new StringBuffer();		
		calling.append("");
		calling.append("DECLARE");                
		calling.append(  "   SO_VENTAS VE_TIPOS_PG.TIP_GA_VENTAS; ");
		calling.append(  " BEGIN ");
		calling.append(  "   SO_VENTAS(1).NUM_VENTA:=?;");
		calling.append(  "   SO_VENTAS(1).COD_CLIENTE:=?;");
		calling.append(  "   SO_VENTAS(1).IND_ESTVENTA:=?;");
		calling.append(  "   SO_VENTAS(1).nom_usuar_acerec:=?;");		
		//INI-01 (AL) calling.append(  "   VE_SERVICIOS_VENTA_PG.VE_ACEP_VENTA_PR ( SO_VENTAS, ?, ?, ? );"); 		
		calling.append(  "   VE_SERVICIOS_VENTA_QUIOSCO_PG.VE_ACEP_VENTA_PR ( SO_VENTAS, ?, ?, ? );");
		calling.append(  " END;");
		if (cat.isDebugEnabled()) 
			cat.debug("calling : " + calling);        
		return calling.toString();   
	}	

	/**
	 * realiza reversa de la venta
	 * @param entrada
	 * @return 
	 * @throws GeneralException
	 */
	public void setAceptacionVenta(GaVentasDTO entrada) 
	throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:setAceptacionVenta");


			String call = getSQLUpdateAcepventa();
			
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
								
			cstmt.setLong(1,entrada.getNumVenta().longValue());
			cat.debug("Numero Venta:" + entrada.getNumVenta().longValue());
			cstmt.setLong(2,entrada.getCodCliente().longValue());
			cat.debug("Numero getCodCliente:" + entrada.getCodCliente().longValue());
			cstmt.setString(3,entrada.getIndEstVenta());
			cat.debug("Numero getIndEstVenta:" + entrada.getIndEstVenta());
			cstmt.setString(4,entrada.getNomUsuarAcerec());
			cat.debug("Numero getNomUsuarAcerec:" + entrada.getNomUsuarAcerec());
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			
			
			cat.debug("Inicio:insertQuioscoVenta:execute");
			cstmt.execute();
		    cat.debug("Fin:insertQuioscoVenta:execute");

			codError=cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento=cstmt.getInt(7);
			
			cat.debug("Código Error: " +  codError);
			cat.debug("msgError: " +  msgError);
			cat.debug("numEvento: " +  numEvento);

			if (codError != 0){
				cat.error("Ocurrió un error al realizar validacion aceptacion venta");
				throw new GeneralException(
						"Ocurrió un error al realizar validacion aceptacion venta", String
						.valueOf(codError), numEvento, msgError);
			}

		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al realizar validacion aceptacion venta",e);			
			throw (GeneralException)e;			
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


	public void insertQuioscoVenta(GaVentasDTO gaVentasDTO) throws GeneralException{

		if (cat.isDebugEnabled()) {
			cat.debug("insertQuioscoVenta():start");
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
			throw new GeneralException("No se pudo obtener una conexión",e1);
		}
		try {

			call = getSQLDatosVenta("ve_cargos_pg","ve_ins_quios_vent_pr",6);
			
			cat.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);

			if (cat.isDebugEnabled()) {
				cat.debug("Registrando Entradas");				
			}
						
			cat.debug("gaVentasDTO.getNumVenta() [" + gaVentasDTO.getNumVenta() + "]");
			cat.debug("gaVentasDTO.getCodCliente()[" + gaVentasDTO.getCodCliente() + "]");
			cat.debug("gaVentasDTO.getNomUsuarVta()[" + gaVentasDTO.getNomUsuarVta() + "]");
			
			cstmt.setLong(1,gaVentasDTO.getNumVenta().longValue());
			cstmt.setLong(2,gaVentasDTO.getCodCliente().longValue());
			cstmt.setString(3,gaVentasDTO.getNomUsuarVta());
			

			if (cat.isDebugEnabled()) {
				cat.debug(" Registrando salidas");
			}

			cstmt.registerOutParameter(4, oracle.jdbc.driver.OracleTypes.NUMBER);
			cstmt.registerOutParameter(5, oracle.jdbc.driver.OracleTypes.VARCHAR);
			cstmt.registerOutParameter(6, oracle.jdbc.driver.OracleTypes.NUMBER);

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

			codError =cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);
			cat.debug("codError[" + codError + "]");
			cat.debug("msgError[" + msgError + "]");		
			cat.debug("numEvento[" + numEvento + "]");
			
			cstmt=null;

			if (codError != 0) {
				cat.error("Ocurrió un error al insertar la venta");
				throw new GeneralException(String.valueOf(codError),
						numEvento, msgError); 
			}

			cat.debug("Recuperando data...");

			cat.debug("Codigo Error PL[" + codError + "]");

		} catch (GeneralException e) {

			e.printStackTrace();
			cat.error("Ocurrió un error general al insertar la venta quiosco",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw e;
		}catch (Exception e) 
		{

			e.printStackTrace();
			cat.error("Ocurrió un error general al insertar la venta quiosco",e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error general al insertar la venta quiosco",e);

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
			cat.debug("insertVenta():end");
		}

	}	
	
}