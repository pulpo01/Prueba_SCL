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
 * 26/02/2007     H&eacute;ctor Hermosilla				Versión Inicial
 */

package com.tmmas.cl.scl.productdomain.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Category;

import com.linar.spi.Logger;
import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.LstPTaPlanTarifarioInDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.LstPTaPlanTarifarioListOutDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.LstPTaPlanTarifarioOutDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.DescuentoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosDescuentoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosValidacionTasacionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.PrecioCargoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ResultadoValidacionTasacionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.ProductDomainException;
import com.tmmas.cl.scl.productdomain.businessobject.dto.PlanTarifarioDTO;
import com.tmmas.cl.scl.productdomain.businessobject.helper.Global;

public class PlanTarifarioDAO extends ConnectionDAO{
	
	private static Category cat = Category.getInstance(PlanTarifarioDAO.class);

	Global global = Global.getInstance();
	
	private Connection getConection() throws ProductDomainException
	{
		Connection conn = null;
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
		} catch (Exception e1) {
			conn = null;
			cat.error(" No se pudo obtener una conexión ", e1);
			throw new ProductDomainException("No se pudo obtener una conexión", e1);
		}
		
		return conn;
	}
	private String getSQLDatosPlanTarifario(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
        for (int n = 1; n <= paramCount; n++) {
            sb.append("?");
            if (n < paramCount) sb.append(",");
        }
        return sb.append(")}").toString();
	}
	
	/**
	 * Obtiene todos los atributos del Plan Tarifario.
	 * 
	 * @param planEntrada
	 * @return resultado
	 * @throws ProductDomainException
	 */

	public PlanTarifarioDTO getPlanTarifario(PlanTarifarioDTO planEntrada) 
		throws ProductDomainException
	{
		cat.debug("Inicio:getPlanTarifario()");		
		PlanTarifarioDTO resultado = new PlanTarifarioDTO();
		resultado.setCodigoPlanTarifario(planEntrada.getCodigoPlanTarifario());
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			String call = getSQLDatosPlanTarifario("VE_servicios_venta_PG","VE_consulta_plan_tarifario_PR",21);
			cat.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,planEntrada.getCodigoPlanTarifario());
			cstmt.setInt(2,Integer.parseInt(planEntrada.getCodigoProducto()));
			cstmt.setString(3,planEntrada.getCodigoTecnologia());
			
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR); 		// SV_desplantarif
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR); 		// SV_tipplantarif
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR); 		// SV_codlimconsumo
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC); 		// SN_numdias
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR); 		// SV_codplanserv
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR); 		// SN_ind_cargo_habil
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR); 	// SV_codcargobasico
			cstmt.registerOutParameter(11, java.sql.Types.VARCHAR); 	// SV_descargobasico
			cstmt.registerOutParameter(12, java.sql.Types.NUMERIC); 	// SN_importecargo
			cstmt.registerOutParameter(13, java.sql.Types.NUMERIC); 	// SN_importecargo
			cstmt.registerOutParameter(14, java.sql.Types.VARCHAR); 	// SV_codigotipoplan
			cstmt.registerOutParameter(15, java.sql.Types.NUMERIC); 	// SN_indfamiliar
			cstmt.registerOutParameter(16, java.sql.Types.NUMERIC); 	// SN_num_abonados
			cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(18, java.sql.Types.VARCHAR);     // Tipo Cobro
			//-- control error
			cstmt.registerOutParameter(19, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(20, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(21, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getPlanTarifario:execute");			
			cstmt.execute();			
			cat.debug("Fin:getPlanTarifario:execute");

			codError = cstmt.getInt(19);			
			msgError = cstmt.getString(20);
			numEvento = cstmt.getInt(21);

			cat.debug("codError[" + codError + "]");
			cat.debug("msgError[" + msgError + "]");
			cat.debug("numEvento[" + numEvento + "]");
			
			
			//-- plan tarifario
			resultado.setDescripcionPlanTarifario(cstmt.getString(4));
			resultado.setTipoPlanTarifario(cstmt.getString(5));
			resultado.setCodigoLimiteConsumo(cstmt.getString(6));
			resultado.setNumDias(cstmt.getInt(7));
			resultado.setCodigoPlanServicio(cstmt.getString(8));
			resultado.setIndicadorCargoHabilitacion(cstmt.getString(9));
			
			//-- cargo basico
			resultado.setCodigoCargoBasico(cstmt.getString(10));
			resultado.setDescripcionCargoBasico(cstmt.getString(11));
			resultado.setImporteCargoBasico(cstmt.getFloat(12));
			resultado.setCodigoMonedaCargoBasico(cstmt.getString(13));
			resultado.setCodigoTipoPlan(cstmt.getString(14));
			resultado.setIndFamiliar(cstmt.getInt(15));
			
			resultado.setPlanComverse(cstmt.getString(17));
			resultado.setTipoCobro(cstmt.getString(18));
			
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar Plan Tarifario",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof ProductDomainException ) throw (ProductDomainException) e;
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
		cat.debug("Fin:getPlanTarifario()");
		return resultado;
	}//fin getPlanTarifario
	
	/**
	 * Verifica si Existe o no un Plan Tarifario especifico 
	 * @param planEntrada
	 * @return resultado
	 * @throws ProductDomainException
	 */
	
	public ResultadoValidacionTasacionDTO existePlanTarifario(ParametrosValidacionTasacionDTO planEntrada) 
		throws ProductDomainException
	{
		cat.debug("Inicio:existePlanTarifario()");
		ResultadoValidacionTasacionDTO resultado = new ResultadoValidacionTasacionDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			String call = getSQLDatosPlanTarifario("VE_validacion_linea_PG","VE_existe_plan_tarifario_PR",7);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,planEntrada.getCodigoPlanTarifario());
			cstmt.setInt(2,Integer.parseInt(planEntrada.getCodigoProducto()));
			cstmt.setString(3,planEntrada.getCodigoTecnologia());
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC); //SB_resultado
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:existePlanTarifario:Execute");
			cstmt.execute();
			cat.debug("Fin:existePlanTarifario:Execute");
			
			msgError = cstmt.getString(6);
			cat.debug("msgError[" + msgError + "]");
			resultado.setResultadoBase(cstmt.getInt(4));
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar Plan Tarifario",e);
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

		cat.debug("Fin:existePlanTarifario()");

		return resultado;
	}
	
	/**
	 * Busca todos los Cargos Basicos asociados al Plan Tarifario
	 * @param entrada
	 * @return resultado
	 * @throws ProductDomainException
	 */
	public PrecioCargoDTO[] getCargoBasico(PlanTarifarioDTO entrada) 
		throws ProductDomainException
	{
		cat.debug("Inicio:getCargoBasico()");
		cat.debug("entrada.getCodigoProducto() [" +  entrada.getCodigoProducto() + "]");
		PrecioCargoDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		ResultSet rs = null;
		try {
			String call = getSQLDatosPlanTarifario("VE_servicios_venta_PG","VE_precio_cargo_basico_PR",6);
			cat.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,entrada.getCodigoProducto());
			cat.debug("entrada.getCodigoProducto():" + entrada.getCodigoProducto());
			cstmt.setString(2,entrada.getCodigoCargoBasico());
			cat.debug("entrada.getCodigoCargoBasico():" + entrada.getCodigoCargoBasico());
			cstmt.registerOutParameter(3,OracleTypes.CURSOR);
			//-- control error
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getCargoBasico:Execute");
			cstmt.execute();
			cat.debug("Fin:getCargoBasico:Execute");
			
			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);
			
			cat.debug("codError[" + codError + "]");
			cat.debug("msgError[" + msgError + "]");
			cat.debug("numEvento[" + numEvento + "]");

			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar cargos basicos");
				throw new CustomerDomainException(
						"Ocurrió un error al recuperar cargos basicos", String
								.valueOf(codError), numEvento, msgError);
				
			}else{
				cat.debug("Recuperando cargos basicos");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(3);
				while (rs.next()) {
					PrecioCargoDTO precioDTO = new PrecioCargoDTO();
					precioDTO.setCodigoConcepto(rs.getString(1));
					precioDTO.setDescripcionConcepto(rs.getString(2));
					precioDTO.setMonto(rs.getFloat(3));
					precioDTO.setCodigoMoneda(rs.getString(4));
					precioDTO.setDescripcionMoneda(rs.getString(5));
					//-- VALORES CONSTANTES
					precioDTO.setIndicadorAutMan(rs.getString(6));
					precioDTO.setNumeroUnidades(rs.getString(7));
					precioDTO.setIndicadorEquipo(rs.getString(8));
					precioDTO.setIndicadorPaquete(rs.getString(9));
					precioDTO.setMesGarantia(rs.getString(10));
					precioDTO.setIndicadorAccesorio(rs.getString(11));
					precioDTO.setCodigoArticulo(rs.getString(12));
					precioDTO.setCodigoStock(rs.getString(13));
					precioDTO.setCodigoEstado(rs.getString(14));
					
					lista.add(precioDTO);
				}				
				resultado =(PrecioCargoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), PrecioCargoDTO.class);
				
				cat.debug("Fin recuperacion de cargos basicos");
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar cargos basicos",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new ProductDomainException(
					"Ocurrió un error al recuperar cargos basicos",e);
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
		cat.debug("Fin:getCargoBasico()");

		return resultado;
	}//fin getCargoBasico
	
	/**
	 * Busca todos los Descuentos tipo Articulo asociados al Plan Tarifario(Cargo Basico) 
	 * @param entrada
	 * @return resultado
	 * @throws ProductDomainException
	 */
	public DescuentoDTO[] getDescuentoCargoBasicoArticulo(ParametrosDescuentoDTO entrada)
		throws ProductDomainException
	{
		cat.debug("Inicio:getDescuentoCargoBasicoArticulo()");
		DescuentoDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			String call = getSQLDatosPlanTarifario("VE_servicios_venta_PG","VE_obtiene_descuento_art_PR",14);
			cat.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			cat.debug("[getDescuentoCargoBasicoArticulo] cod operacion: " + entrada.getCodigoOperacion());
			cat.debug("[getDescuentoCargoBasicoArticulo] tipocontrato: " + entrada.getTipoContrato());
			cat.debug("[getDescuentoCargoBasicoArticulo] numero meses: " + entrada.getNumeroMesesContrato());
			cat.debug("[getDescuentoCargoBasicoArticulo] codigo antiguedad: " + entrada.getCodigoAntiguedad());
			cat.debug("[getDescuentoCargoBasicoArticulo] cod promedio: " + entrada.getCodigoPromedioFacturable());
			cat.debug("[getDescuentoCargoBasicoArticulo] estado: " + entrada.getEquipoEstado());
			cat.debug("[getDescuentoCargoBasicoArticulo] contrato: " + entrada.getTipoContrato());
			cat.debug("[getDescuentoCargoBasicoArticulo] numero meses: " + entrada.getNumeroMesesNuevo());
			cat.debug("[getDescuentoCargoBasicoArticulo] cod articulo: " + entrada.getCodigoArticulo());
			cat.debug("[getDescuentoCargoBasicoArticulo] clase desc: " + entrada.getClaseDescuento());
			cstmt.setString(1,entrada.getCodigoOperacion());
			cstmt.setString(2,entrada.getTipoContrato());
			cstmt.setInt(3,entrada.getNumeroMesesContrato());
			cstmt.setString(4,entrada.getCodigoAntiguedad());
			cstmt.setString(5,entrada.getCodigoPromedioFacturable());
			cstmt.setString(6,entrada.getEquipoEstado());
			cstmt.setString(7,entrada.getTipoContrato());
			cstmt.setInt(8,Integer.parseInt(entrada.getNumeroMesesNuevo()));
			cstmt.setString(9,null);
			cstmt.setString(10,entrada.getClaseDescuento());
			cstmt.registerOutParameter(11,OracleTypes.CURSOR);
			//-- control error
			cstmt.registerOutParameter(12, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(14, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getDescuentoCargoBasicoArticulo:Execute");
			cstmt.execute();
			cat.debug("Fin:getDescuentoCargoBasicoArticulo:Execute");
			
			codError = cstmt.getInt(12);
			msgError = cstmt.getString(13);
			numEvento = cstmt.getInt(14);
			
			cat.debug("codError[" + codError + "]");
			cat.debug("msgError[" + msgError + "]");
			cat.debug("numEvento[" + numEvento + "]");

			if (codError == 0) {
				cat.debug("Recuperando descuentos");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(11);
				while (rs.next()) {
					DescuentoDTO descuentoDTO = new DescuentoDTO();
					descuentoDTO.setTipoAplicacion(rs.getString(1));
					descuentoDTO.setCodMoneda(rs.getString(2));
					descuentoDTO.setMonto(rs.getFloat(3));
					descuentoDTO.setCodigoConcepto(rs.getString(4));
					
					lista.add(descuentoDTO);
					cat.debug("[getDescuentoCodigoConcpeto]: " + rs.getString(4));
					cat.debug("[getDescuentoDescripcionConcepto] : " + rs.getString(2));
					cat.debug("[getDescuentoMonto]: " + rs.getFloat(3));
					
				}
				rs.close();
				resultado =(DescuentoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), DescuentoDTO.class);
				cat.debug("Fin recuperacion de descuentos del cargo basico");
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar los descuentos del cargo basico",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new ProductDomainException(
					"Ocurrió un error al recuperar los descuentos del cargo basico",e);
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
		cat.debug("Fin:etDescuentoCargoBasicoArticulo()");

		return resultado;
	}//fin getDescuentoCargoBasicoArticulo
	
	
	/**
	 * Busca todos los Descuentos tipo concepto asociados al Plan Tarifario(Cargo Basico) 
	 * @param entrada
	 * @return resultado
	 * @throws ProductDomainException
	 */
	public DescuentoDTO[] getDescuentoCargoBasicoConcepto(ParametrosDescuentoDTO entrada) 
		throws ProductDomainException
	{
		cat.debug("Inicio:PlanTarifarioDAO:getDescuentoCargoBasicoConcepto()");
		DescuentoDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			String call = getSQLDatosPlanTarifario("VE_servicios_venta_PG","VE_obtiene_descuento_con_PR",19);
			cat.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,entrada.getCodigoOperacion());
			cat.debug("getDescuentoCargoBasicoConcepto().entrada.getCodigoOperacion()" + entrada.getCodigoOperacion());
			cstmt.setString(2,entrada.getCodigoAntiguedad());
			cat.debug("getDescuentoCargoBasicoConcepto().entrada.getCodigoAntiguedad()" + entrada.getCodigoAntiguedad());
			cstmt.setString(3,entrada.getTipoContrato());
			cat.debug("getDescuentoCargoBasicoConcepto().entrada.getTipoContrato()" + entrada.getTipoContrato());
			cstmt.setInt(4,Integer.parseInt(entrada.getNumeroMesesNuevo()));
			cat.debug("getDescuentoCargoBasicoConcepto().entrada.getNumeroMesesNuevo()" + entrada.getNumeroMesesNuevo());
			cstmt.setInt(5,Integer.parseInt(entrada.getIndiceVentaExterna()));
			cat.debug("getDescuentoCargoBasicoConcepto().entrada.getIndiceVentaExterna()" + entrada.getIndiceVentaExterna());
			cstmt.setLong(6,Long.parseLong(entrada.getCodigoVendedor()));
			cat.debug("getDescuentoCargoBasicoConcepto().entrada.getCodigoVendedor()" + entrada.getCodigoVendedor());
			cstmt.setString(7,entrada.getCodigoCausaVenta());
			cat.debug("getDescuentoCargoBasicoConcepto().entrada.getCodigoCausaVenta()" + entrada.getCodigoCausaVenta());
			cstmt.setString(8,entrada.getCodigoCategoria());
			cat.debug("getDescuentoCargoBasicoConcepto().entrada.getCodigoCategoria()" + entrada.getCodigoCategoria());
			cstmt.setInt(9,Integer.parseInt(entrada.getCodigoModalidadVenta()));
			cat.debug("getDescuentoCargoBasicoConcepto().entrada.getCodigoModalidadVenta()" + entrada.getCodigoModalidadVenta());
			cstmt.setInt(10,Integer.parseInt(entrada.getTipoPlanTarifario()));
			cat.debug("getDescuentoCargoBasicoConcepto().entrada.getTipoPlanTarifario()" + entrada.getTipoPlanTarifario());
			cstmt.setInt(11,Integer.parseInt(entrada.getConcepto()));
			cat.debug("getDescuentoCargoBasicoConcepto().entrada.getConcepto()" + entrada.getConcepto());
			cstmt.setString(12,entrada.getClaseDescuento());
			cat.debug("getDescuentoCargoBasicoConcepto().entrada.getClaseDescuento()" + entrada.getClaseDescuento());
			cstmt.setString(13,entrada.getCodigoCalificaion());
			cat.debug("getDescuentoCargoBasicoConcepto().entrada.getCodigoCalificaion()" + entrada.getCodigoCalificaion());
			cstmt.setInt(14,entrada.getIndRenovacion());
			cat.debug("getIndRenovacion()" + entrada.getIndRenovacion());
			cstmt.setInt(15,entrada.getIndRenovacion());
			cat.debug("Ind PriSeg :"+entrada.getIndRenovacion());
			
			cstmt.registerOutParameter(16,OracleTypes.CURSOR);
			//-- control error
			cstmt.registerOutParameter(17, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(18, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(19, java.sql.Types.NUMERIC);
			
			cstmt.execute();
			
			codError = cstmt.getInt(17);
			msgError = cstmt.getString(18);
			numEvento = cstmt.getInt(19);
			
			cat.debug("codError[" + codError + "]");
			cat.debug("msgError[" + msgError + "]");
			cat.debug("numEvento[" + numEvento + "]");

			if (codError == 0) {
				cat.debug("Recuperando descuentos");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(16);
				while (rs.next()) {
					DescuentoDTO descuentoDTO = new DescuentoDTO();
					descuentoDTO.setTipoAplicacion(rs.getString(1));
					descuentoDTO.setCodMoneda(rs.getString(2));
					descuentoDTO.setMonto(rs.getFloat(3));
					descuentoDTO.setCodigoConcepto(rs.getString(4));
					
					lista.add(descuentoDTO);
				}
				rs.close();
				resultado =(DescuentoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), DescuentoDTO.class);
				cat.debug("Fin recuperacion de descuentos del cargo basico");
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar los descuentos del cargo basico",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new ProductDomainException(
					"Ocurrió un error al recuperar los descuentos del cargo basico",e);
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
		cat.debug("Fin:PlanTarifarioDAO:getDescuentoCargoBasicoConcepto()");

		return resultado;
	}//fin getDescuentoCargoBasicoArticulo	
	
	/**
	 * Busca la categoria del Plan Tarifario
	 * @param planEntrada
	 * @return resultado
	 * @throws ProductDomainException
	 */
	public PlanTarifarioDTO getCategoriaPlanTarifario(PlanTarifarioDTO planEntrada)
		throws ProductDomainException
	{
		cat.debug("Inicio:PlanTarifarioDAO:getCategoriaPlanTarifario()");		
		PlanTarifarioDTO resultado = new PlanTarifarioDTO();
		resultado.setCodigoPlanTarifario(planEntrada.getCodigoPlanTarifario());
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			String call = getSQLDatosPlanTarifario("VE_servicios_venta_PG","VE_consulta_categ_ptarif_PR",5);
			cat.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,planEntrada.getCodigoPlanTarifario());
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR); 		// SV_tipplantarif
			//-- control error
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			cstmt.execute();
			
			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			
			cat.debug("codError[" + codError + "]");
			cat.debug("msgError[" + msgError + "]");
			   
			
			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar la Categoria del Plan Tarifario");
				throw new CustomerDomainException(
						"Ocurrió un error al recuperar la Categoria del Plan Tarifario", String
								.valueOf(codError), numEvento, msgError);
			}else
				resultado.setCodigoCategoria(cstmt.getString(2));
			
			
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar la Categoria del Plan Tarifario",e);
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

		cat.debug("Fin:PlanTarifarioDAO:getCategoriaPlanTarifario()");

		return resultado;
	}//fin getCategoriaPlanTarifario
	
	/**
	 * Obtiene Codigo Concepto Facturable del descuento manual 
	 * @param entrada
	 * @return resultado
	 * @throws ProductDomainException
	 */
	public DescuentoDTO getCodigoDescuentoManual(ParametrosDescuentoDTO entrada)
		throws ProductDomainException
	{
		cat.debug("Inicio:getCodigoDescuentoManual()");
		DescuentoDTO resultado = new DescuentoDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			String call = getSQLDatosPlanTarifario("VE_servicios_venta_PG","VE_consulta_cod_desc_manual_PR",6);
			cat.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,entrada.getCodigoConcepto());
			cstmt.setString(2,entrada.getTipoConcepto());
			cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
			//-- control error
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			
			cstmt.execute();
			
			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);
			
			cat.debug("codError[" + codError + "]");
			cat.debug("msgError[" + msgError + "]");
			cat.debug("numEvento[" + numEvento + "]");

			if (codError == 0) 
				resultado.setCodigoConcepto(String.valueOf(cstmt.getInt(3)));
			
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar el código de descuento manual",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new ProductDomainException(
					"Ocurrió un error al recuperar el código de descuento manual",e);
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
		cat.debug("Fin:getCodigoDescuentoManual()");

		return resultado;
	}//fin getCodigoDescuentoManual	

	/**
	 * Obtiene limites de consumos para el plan tarifario
	 * @param entrada
	 * @return PlanTarifarioDTO[]
	 * @throws ProductDomainException
	 */
	public PlanTarifarioDTO[] getListLimiteConsumo(PlanTarifarioDTO entrada)
		throws ProductDomainException
	{
		cat.debug("Inicio:getListLimiteConsumo()");
		PlanTarifarioDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			String call = getSQLDatosPlanTarifario("VE_PARAMETROS_COMERCIALES_PG","VE_getListLimiteConsumo_PR",8);
			cat.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);

			cstmt.setString(1,entrada.getCodigoPlanTarifario());
			cstmt.setString(2,entrada.getFormatoFecha1());
			cstmt.setString(3,entrada.getFormatoFecha2());
			cstmt.setLong(4, (new Long(entrada.getCodigoCliente())).longValue());

			cstmt.registerOutParameter(5,OracleTypes.CURSOR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getListLimiteConsumo:execute");
			cstmt.execute();
			cat.debug("Fin:getListLimiteConsumo:execute");
			
			codError = cstmt.getInt(6);
			msgError = cstmt.getString(7);
			numEvento = cstmt.getInt(8);
			
			cat.debug("codError[" + codError + "]");
			cat.debug("msgError[" + msgError + "]");
			cat.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar limites de consumo para el plan tarifario");
				throw new ProductDomainException("Ocurrió un error al recuperar SS del abonado", String
								.valueOf(codError), numEvento, msgError);
				
			}else{
				cat.debug("Recuperando SS del abonado");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(5);
				while (rs.next()) {
					PlanTarifarioDTO planTarifarioDTO = new PlanTarifarioDTO();
					planTarifarioDTO.setCodigoLimiteConsumo(rs.getString(1));
					planTarifarioDTO.setDescripcionLimiteConsumo(rs.getString(2));
				    planTarifarioDTO.setImporteLimite(String.valueOf(rs.getLong(3)));
					planTarifarioDTO.setIndicadorUnidades(rs.getString(4));
					planTarifarioDTO.setIndicadorDefault(rs.getString(5));
					planTarifarioDTO.setFechaDesde(rs.getString(6));
					planTarifarioDTO.setFechaHasta(rs.getString(7));
					planTarifarioDTO.setMontoMinimo(rs.getDouble(8));
					planTarifarioDTO.setMontoMaximo(rs.getDouble(9));
					planTarifarioDTO.setFlgCorte(rs.getInt(10));
					planTarifarioDTO.setMontoCons(rs.getDouble(11));
					lista.add(planTarifarioDTO);
				}
				rs.close();
				resultado =(PlanTarifarioDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), PlanTarifarioDTO.class);
		  
				cat.debug("Fin recuperacion limites de consumo para el plan tarifario");
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar limites de consumo para el plan tarifario",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new ProductDomainException(
					"Ocurrió un error al recuperar limites de consumo para el plan tarifario",e);
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
		cat.debug("Fin:getListLimiteConsumo()");
		return resultado;
	}//fin getListLimiteConsumo

	/**
	 * Obtiene planes tarifarios comercializables y no comercializables
	 * @param entrada
	 * @return PlanTarifarioDTO[]
	 * @throws ProductDomainException
	 */
	public PlanTarifarioDTO[] getListPlanTarifario(PlanTarifarioDTO entrada)
	throws ProductDomainException{
		cat.debug("Inicio:getListPlanTarifario()");
		PlanTarifarioDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			String call = getSQLDatosPlanTarifario("Ve_Servicios_Venta_Pg","VE_getListPlanTarifario_PR",5);
			cat.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);

			cstmt.setInt(1,entrada.getIndicadorComercializable());

			cstmt.registerOutParameter(2,OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getListPlanTarifario:execute");
			cstmt.execute();
			cat.debug("Fin:getListPlanTarifario:execute");
			
			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			cat.debug("codError[" + codError + "]");
			cat.debug("msgError[" + msgError + "]");
			cat.debug("numEvento[" + numEvento + "]");
			
			if (codError == 0) {
				cat.debug("Recuperando planes tarifarios (comercializables o no)");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(2);
				while (rs.next()) {
					PlanTarifarioDTO planTarifarioDTO = new PlanTarifarioDTO();
					planTarifarioDTO.setCodigoPlanTarifario(rs.getString(1));
					planTarifarioDTO.setDescripcionPlanTarifario(rs.getString(2));
					lista.add(planTarifarioDTO);
				}
				rs.close();
				resultado =(PlanTarifarioDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), PlanTarifarioDTO.class);
		  
				cat.debug("Fin recuperacion planes tarifarios (comercializables o no)");
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar planes tarifarios (comercializables o no)",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new ProductDomainException(
					"Ocurrió un error al recuperar planes tarifarios (comercializables o no)",e);
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
		cat.debug("Fin:getListPlanTarifario()");
		return resultado;
	}//fin getListPlanTarifario
	
	/**
	 * Obtiene planes tarifarios segun numero identificador
	 * @param entrada
	 * @return PlanTarifarioDTO[]
	 * @throws ProductDomainException
	 */
	public PlanTarifarioDTO[] getListPlanTarifarioNumIdentTipoPlan(PlanTarifarioDTO entrada)
	throws ProductDomainException{
		cat.debug("Inicio:getListPlanTarifarioNumIdentTipoPlan()");
		PlanTarifarioDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			String call = getSQLDatosPlanTarifario("ER_servicios_evalriesgo_PG","ER_getListPlanTarifTipo_PR",7);
			cat.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);

			cstmt.setString(1,entrada.getCodigoTipoIdentificador());
			cat.debug("entrada.getCodigoTipoIdentificador(): " + entrada.getCodigoTipoIdentificador());
			cstmt.setString(2,entrada.getNumeroIdentificador());
			cat.debug("entrada.getNumeroIdentificador(): " + entrada.getNumeroIdentificador());
			cstmt.setString(3,entrada.getTipoPlanTarifario());
			cat.debug("entrada.getTipoPlanTarifario(): " + entrada.getTipoPlanTarifario());

			cstmt.registerOutParameter(4,OracleTypes.CURSOR);
			cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7,java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getListPlanTarifarioNumIdentTipoPlan:execute");
			cstmt.execute();
			cat.debug("Fin:getListPlanTarifarioNumIdentTipoPlan:execute");
			
			codError = cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento = cstmt.getInt(7);
			
			cat.debug("codError[" + codError + "]");
			cat.debug("msgError[" + msgError + "]");
			cat.debug("numEvento[" + numEvento + "]");
			
			if (codError == 0) {
				cat.debug("Recuperando planes tarifarios");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(4);
				while (rs.next()) {
					PlanTarifarioDTO planTarifarioDTO = new PlanTarifarioDTO();
					planTarifarioDTO.setCodigoPlanTarifario(rs.getString(1));
					planTarifarioDTO.setDescripcionPlanTarifario(rs.getString(2));
					lista.add(planTarifarioDTO);
				}
				rs.close();
				resultado =(PlanTarifarioDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), PlanTarifarioDTO.class);
		  
				cat.debug("Fin recuperacion planes tarifarios  segun numero identificador");
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar planes tarifarios  segun numero identificador",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new ProductDomainException(
					"Ocurrió un error al recuperar planes tarifarios  segun numero identificador",e);
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
		cat.debug("Fin:getListPlanTarifarioNumIdentTipoPlan()");
		return resultado;
	}//fin getListPlanTarifarioNumIdentTipoPlan

	/** Servicios Activaciones WEB - Colombia
	 * Obtine planes tarifarios 
	 * @param PlanTarifarioDTO (entrada)
	 * @return PlanTarifarioDTO (resultado)
	 * @throws ProductDomainException
     * wjrc - Agosto 2007 */		
	public PlanTarifarioDTO[] getListPlanTarif(PlanTarifarioDTO entrada)
	throws ProductDomainException{
		cat.debug("Inicio:getListPlanTarif");
		PlanTarifarioDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			String call = getSQLDatosPlanTarifario("Ve_Servs_ActivacionesWeb_Pg","VE_getListPlanTarif_PR",9);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setString(1,entrada.getTipoProducto( ));
			cstmt.setString(2,entrada.getCodigoClasificacion());
			cstmt.setString(3,entrada.getCodigoDCifra());
			//cstmt.setDouble(4,entrada.getImporteLimite());
			cstmt.setString(4,entrada.getImporteLimite());
			cstmt.setString(5,entrada.getCodigoCliente() );

			cstmt.registerOutParameter(6,OracleTypes.CURSOR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getListPlanTarif:execute");
			cstmt.execute();
			cat.debug("Fin:getListPlanTarif:execute");
			
			codError = cstmt.getInt(7);
			msgError = cstmt.getString(8);
			numEvento = cstmt.getInt(9);
			
			cat.debug("codError[" + codError + "]");
			cat.debug("msgError[" + msgError + "]");
			cat.debug("numEvento[" + numEvento + "]");
			
			if (codError == 0) {
				cat.debug("Recuperando planes tarifarios ");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(6);
				while (rs.next()) {
					PlanTarifarioDTO planTarifarioDTO = new PlanTarifarioDTO();
					planTarifarioDTO.setCodigoPlanTarifario(rs.getString(1));
					planTarifarioDTO.setDescripcionPlanTarifario(rs.getString(2));
					
					lista.add(planTarifarioDTO);
				}
				rs.close();
				resultado =(PlanTarifarioDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), PlanTarifarioDTO.class);
		  
				cat.debug("Fin recuperacion planes tarifarios ");
			}else
				throw new ProductDomainException(
						"Ocurrió un error al recuperar planes tarifarios " + " " + msgError,String
						.valueOf(codError), numEvento, msgError);
			{
				
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar planes tarifarios ",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
	
			if (e instanceof ProductDomainException ){
	                throw (ProductDomainException) e;
	        }} finally {
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
		cat.debug("Fin:getListPlanTarif");
		return resultado;
	}//fin getListPlanTarif

	/** COL08009
	/**
	 * Obtiene planes tarifarios segun numero identificador
	 * @param entrada
	 * @return PlanTarifarioDTO[]
	 * @throws ProductDomainException
	 */
	public PlanTarifarioDTO[] getListPlanTarifarioPorPlanORango(PlanTarifarioDTO entrada)
	throws ProductDomainException{
		cat.debug("Inicio:getListPlanTarifarioNumIdentTipoPlan()");
		PlanTarifarioDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			String call = getSQLDatosPlanTarifario("ER_servicios_evalriesgo_PG","ER_getListPlanTarifTipo_PR",8);
			cat.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);

			cstmt.setString(1,entrada.getCodigoTipoIdentificador());
			cat.debug("entrada.getCodigoTipoIdentificador(): " + entrada.getCodigoTipoIdentificador());
			cstmt.setString(2,entrada.getNumeroIdentificador());
			cat.debug("entrada.getNumeroIdentificador(): " + entrada.getNumeroIdentificador());
			cstmt.setString(3,entrada.getTipoPlanTarifario());
			cat.debug("entrada.getTipoPlanTarifario(): " + entrada.getTipoPlanTarifario());
			cstmt.setString(4,entrada.getSeleccionPlanORango());

			cstmt.registerOutParameter(5,OracleTypes.CURSOR);
			cstmt.registerOutParameter(6,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8,java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getListPlanTarifarioNumIdentTipoPlan:execute");
			cstmt.execute();
			cat.debug("Fin:getListPlanTarifarioNumIdentTipoPlan:execute");
			
			codError = cstmt.getInt(6);
			msgError = cstmt.getString(7);
			numEvento = cstmt.getInt(8);
			
			cat.debug("codError[" + codError + "]");
			cat.debug("msgError[" + msgError + "]");
			cat.debug("numEvento[" + numEvento + "]");
			   
			if (codError == 0) {
				cat.debug("Recuperando planes tarifarios");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(5);
				while (rs.next()) {
					PlanTarifarioDTO planTarifarioDTO = new PlanTarifarioDTO();
					planTarifarioDTO.setCodigoPlanTarifario(rs.getString(1));
					planTarifarioDTO.setDescripcionPlanTarifario(rs.getString(2)); 
					planTarifarioDTO.setCodigoLimiteConsumo(rs.getString(3));     
					planTarifarioDTO.setDescripcionLimiteConsumo(rs.getString(4));
					planTarifarioDTO.setCodigoCargoBasico(rs.getString(5));
					planTarifarioDTO.setDescripcionCargoBasico(rs.getString(6));
					float importeCargoBasico = rs.getString(7)!=null?Float.parseFloat(rs.getString(7)):0.0f; 
					planTarifarioDTO.setImporteCargoBasico(importeCargoBasico);
					float importeFinal = rs.getString(8)!=null?Float.parseFloat(rs.getString(8)):0.0f; 
					planTarifarioDTO.setImpFinal(importeFinal);
					int numDias = rs.getString(9)!=null?Integer.parseInt(rs.getString(9)):0;
					planTarifarioDTO.setNumDias(numDias);
					planTarifarioDTO.setTipoPlanTarifario(rs.getString(10));
					double importeLimite =  rs.getString(11)!=null?Double.parseDouble(rs.getString(11)):0.0d;
					planTarifarioDTO.setImporteLimite(String.valueOf(importeLimite));
					lista.add(planTarifarioDTO);
				}
				rs.close();
				resultado =(PlanTarifarioDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), PlanTarifarioDTO.class);
		  
				cat.debug("Fin recuperacion planes tarifarios  segun numero identificador");
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar planes tarifarios  segun numero identificador",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new ProductDomainException(
					"Ocurrió un error al recuperar planes tarifarios  segun numero identificador",e);
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
		cat.debug("Fin:getListPlanTarifarioNumIdentTipoPlan()");
		return resultado;
	}//fin getListPlanTarifarioNumIdentTipoPlan
   
	/* mti - abril 2008 */	
	public LstPTaPlanTarifarioListOutDTO lstPlanTarif(LstPTaPlanTarifarioInDTO entrada)
		throws ProductDomainException
	{
		cat.debug("Inicio:lstPlanTarif");
		LstPTaPlanTarifarioListOutDTO resultado = new LstPTaPlanTarifarioListOutDTO();
		LstPTaPlanTarifarioOutDTO[] arrayPlanes = null;
		
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			String call = getSQLDatosPlanTarifario("ER_servicios_evalriesgo_web_PG","ER_getListaPlanesTarif_PR",10);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setString(1,entrada.getTipoProducto());
			cat.debug("entrada.getTipoProducto(): " + entrada.getTipoProducto());
			cstmt.setString(2,entrada.getTipoPlan());
			cat.debug("entrada.getTipoPlan(): " + entrada.getTipoPlan());			
			cstmt.setString(3,entrada.getCodTipPrestacion());
			cat.debug("entrada.getCodTipPrestacion(): " + entrada.getCodTipPrestacion());
			cstmt.setString(4, entrada.getClaPlanTarif());
			cat.debug("entrada.getClaPlanTarif(): " + entrada.getClaPlanTarif());
			cstmt.setInt(5, entrada.getIndRenovacion());
			cat.debug("entrada.getIndRenovacion(): " + entrada.getIndRenovacion());
			//P-CSR-11002 JLGN 13-05-2011
			cstmt.setString(6, entrada.getCodClasificacion());
			cat.debug("entrada.getCodClasificacion(): " + entrada.getCodClasificacion());
			//Salida			
			cstmt.registerOutParameter(7,OracleTypes.CURSOR);
			
			cstmt.registerOutParameter(8,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(9,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10,java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:lstPlanTarif:execute");
			cstmt.execute();
			cat.debug("Fin:lstPlanTarif:execute");
			
			codError = cstmt.getInt(8);
			msgError = cstmt.getString(9);
			numEvento = cstmt.getInt(10);
			
			cat.debug("codError[" + codError + "]");
			cat.debug("msgError[" + msgError + "]");
			cat.debug("numEvento[" + numEvento + "]");
			
			if( codError != 0)
			{
				throw new ProductDomainException(
						"Ocurrió un error al recuperar planes tarifarios " + " " + msgError,String
						.valueOf(codError), numEvento, msgError);
			}			
			else {
				ArrayList lista = new ArrayList();
			    ResultSet rs = (ResultSet) cstmt.getObject(7);
			    while (rs.next()) {
				       LstPTaPlanTarifarioOutDTO plan = new LstPTaPlanTarifarioOutDTO();
				       plan.setCodigoPlanTarifario(rs.getString(1)); 
				       plan.setDescripcionPlanTarifario(rs.getString(2));
				       plan.setTipoProducto(Integer.toString(rs.getInt(3))); 
				       plan.setTipoPlan(rs.getString(4));
				       plan.setCanLineas(new Long(rs.getLong(5)));
				       lista.add(plan);
			    }
			    rs.close();
			    arrayPlanes =(LstPTaPlanTarifarioOutDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(),LstPTaPlanTarifarioOutDTO.class);
			    resultado.setallLstPTaPlanTarifarioOutDTO(arrayPlanes); 
			    cat.debug("Fin recuperacion planes tarifarios ");
			}
		} 
		catch (Exception e) {
			cat.error("Ocurrió un error al recuperar planes tarifarios ",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof ProductDomainException )  throw (ProductDomainException) e;
		} 
		finally {
		 	if (cat.isDebugEnabled()) cat.debug("Cerrando conexiones...");
		 	try {
				if (cstmt!=null) cstmt.close();
				if (!conn.isClosed()) conn.close();
			} 
			catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:lstPlanTarif");
		return resultado;
	}//fin lstPlanTarif
	
	/* mti - julio 2008 */	
	public LstPTaPlanTarifarioListOutDTO lstPlanTarifPosventa(LstPTaPlanTarifarioInDTO entrada)
	throws ProductDomainException{
		cat.debug("Inicio:lstPlanTarifPosventa");
		LstPTaPlanTarifarioListOutDTO resultado = null;
		LstPTaPlanTarifarioOutDTO[] arrayPlanes = null;
		
		int numSolicitud = 0;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			String call = getSQLDatosPlanTarifario("ER_servicios_evalriesgo_web_PG","PV_getListaPlanesTarif_PR",9);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setString(1,entrada.getTipoProducto());
			cat.debug("entrada.getTipoProducto(): " + entrada.getTipoProducto());
			cstmt.setString(2,entrada.getTipoPlan());
			cat.debug("entrada.getTipoPlan(): " + entrada.getTipoPlan());
			cstmt.setString(3,entrada.getTipIdent());
			cat.debug("entrada.getTipIdent(): " + entrada.getTipIdent());
			cstmt.setString(4,entrada.getNumIdent());
			cat.debug("entrada.getNumIdent(): " + entrada.getNumIdent());
			
			cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);	
			cstmt.registerOutParameter(6,OracleTypes.CURSOR);
			cstmt.registerOutParameter(7,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9,java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:lstPlanTarifPosventa:execute");
			cstmt.execute();
			cat.debug("Fin:lstPlanTarifPosventa:execute");
			
			codError = cstmt.getInt(7);
			msgError = cstmt.getString(8);
			numEvento = cstmt.getInt(9);
			
			cat.debug("codError[" + codError + "]");
			cat.debug("msgError[" + msgError + "]");
			cat.debug("numEvento[" + numEvento + "]");
			
			if (codError == 0) {
				resultado = new LstPTaPlanTarifarioListOutDTO();
				numSolicitud = cstmt.getInt(5);
				resultado.setNumSol(Integer.toString(numSolicitud));
				cat.debug("Recuperando planes tarifarios de posventa ");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(6);
				while (rs.next()) {
					LstPTaPlanTarifarioOutDTO plan = new LstPTaPlanTarifarioOutDTO();
					plan.setCodigoPlanTarifario(rs.getString(1)); 
					plan.setDescripcionPlanTarifario(rs.getString(2));
					plan.setTipoProducto(Integer.toString(rs.getInt(3))); 
					plan.setTipoPlan(rs.getString(4));
					plan.setCanLineas(new Long(rs.getLong(5)));
					lista.add(plan);
				}
				rs.close();
				arrayPlanes =(LstPTaPlanTarifarioOutDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(),LstPTaPlanTarifarioOutDTO.class);
				resultado.setallLstPTaPlanTarifarioOutDTO(arrayPlanes); 
				cat.debug("Fin recuperacion planes tarifarios posventa ");
			}
			else {
				throw new ProductDomainException(
						"Ocurrió un error al recuperar planes tarifarios posventa" + " " + msgError,String
						.valueOf(codError), numEvento, msgError);
			}
		} 
		catch (Exception e) {
			cat.error("Ocurrió un error al recuperar planes tarifarios posventa ",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof ProductDomainException )  throw (ProductDomainException) e;
		} 
		finally {
		 	if (cat.isDebugEnabled()) cat.debug("Cerrando conexiones...");
		 	try {
				if (cstmt!=null) cstmt.close();
				if (!conn.isClosed()) conn.close();
			} 
			catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:lstPlanTarifPosventa");
		return resultado;
	}//fin lstPlanTarif
	
	//Inicio P-CSR-11002 JLGN 04-07-2011
	public long getCargoPlanTarif(String codPlanTarif)
	throws CustomerDomainException, ProductDomainException{
		cat.debug("Inicio:getCargoPlanTarif");
	
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		long resultado = 0;
		
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			String call = getSQLDatosPlanTarifario("VE_parametros_comerciales_PG","ve_cargos_pt_pr",5);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setString(1, codPlanTarif);
			cat.debug("codPlanTarif(): " + codPlanTarif);
			cstmt.registerOutParameter(2,java.sql.Types.NUMERIC);	
			cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getCargoPlanTarif:execute");
			cstmt.execute();
			cat.debug("Fin:getCargoPlanTarif:execute");
			
			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			cat.debug("codError[" + codError + "]");
			cat.debug("msgError[" + msgError + "]");
			cat.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				throw new CustomerDomainException(
						"Ocurrió un error al recuperar cargo basico del plan tarifario " + msgError,String
						.valueOf(codError), numEvento, msgError);
			}else{
				resultado = cstmt.getLong(2);
				cat.debug("Cargo Basico PT: "+ resultado);
			}
		} 
		catch (Exception e) {
			cat.error("Ocurrió un error al recuperar cargo basico del plan tarifario ",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)  throw (CustomerDomainException) e;
		} 
		finally {
		 	if (cat.isDebugEnabled()) cat.debug("Cerrando conexiones...");
		 	try {
				if (cstmt!=null) cstmt.close();
				if (!conn.isClosed()) conn.close();
			} 
			catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:getCargoPlanTarif");
		return resultado;
	}//fin lstPlanTarif
	
	//Fin P-CSR-11002 JLGN 04-07-2011	

}//fin class PlanTarifarioDAO
