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
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.DescuentoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ParametrosDescuentoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ParametrosValidacionTasacionDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.PlanTarifarioDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.PlanUsoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.PrecioCargoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ResultadoValidacionTasacionDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.WSPlanTarifarioInDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.WSPlanTarifarioOutDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.helper.Global;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsConsultaPlanTarifarioInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsConsultaPlanTarifarioOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListConsultaPlanTarifarioOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListPlanTarifarioOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListTipoPlanTarifarioOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsPlanTarifarioInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsPlanTarifarioOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsTipoPlanTarifarioOutDTO;

public class PlanTarifarioDAO extends ConnectionDAO{
	
	private static Category cat = Category.getInstance(PlanTarifarioDAO.class);

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
	 * Obtiene Lista de planes tarifario
	 * @param planTarifarioDTO 
	 * @return resultado
	 * @throws GeneralException
	 */
	public WsListPlanTarifarioOutDTO getListadoPlanesTarifarios(WsPlanTarifarioInDTO inWSLstPlanTarifDTO) throws GeneralException{
		//RSIS27
		WsListPlanTarifarioOutDTO resultado = null;
		WsPlanTarifarioOutDTO[] planesTarifarios = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:getListadoPlanesTarifarios()");
			resultado = new WsListPlanTarifarioOutDTO();
			String call = getSQLDatosPlanTarifario("GE_CONS_CATALOGO_PORTAB_PG","GE_REC_PLANES_TARIFARIOS_PR",9);

			cat.debug("sql[" + call + "]");
						
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,inWSLstPlanTarifDTO.getTipPlanTarif());
			cstmt.setString(2,inWSLstPlanTarifDTO.getCodigoTiplan() );
			cstmt.setString(3,inWSLstPlanTarifDTO.getIndicaodorFamiliar());
			cstmt.setString(4,inWSLstPlanTarifDTO.getTipoRed());
			cstmt.setString(5,inWSLstPlanTarifDTO.getCodigoTecnologia());
			cstmt.registerOutParameter(6,OracleTypes.CURSOR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getListadoPlanesTarifarios:execute");
			cstmt.execute();
			cat.debug("Fin:getListadoPlanesTarifarios:execute");

			codError  = cstmt.getInt(7);
			msgError  = cstmt.getString(8);
			numEvento = cstmt.getInt(9);
			
			cat.debug("codError ["+codError+"]");
			cat.debug("msgError ["+msgError+"]");
			cat.debug("numEvento ["+numEvento+"]");
			
			if (codError != 0) {
				cat.error("Ocurrió un error al obtener lista de planes tarifarios");
				resultado.setResultadoTransaccion(msgError);
				resultado.setCodError(""+codError);
				throw new GeneralException(
						  "Ocurrió un error al obtener lista de planes tarifarios", String
								.valueOf(codError), numEvento, msgError);
			}else{
				cat.debug("Recuperando lista de planes tarifarios");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(6);
				while (rs.next()) {
					WsPlanTarifarioOutDTO planTarifarioRS = new WsPlanTarifarioOutDTO();
				//	planTarifarioRS.setCodProducto(rs.getInt(1));
					planTarifarioRS.setCodPlanTarif(rs.getString(2));
					planTarifarioRS.setDesPlanTarif(rs.getString(3));
					planTarifarioRS.setCodTiplan(rs.getString(4));
					planTarifarioRS.setNumAbonados(rs.getString(5));
					lista.add(planTarifarioRS);
				}
				rs.close();
				planesTarifarios =(WsPlanTarifarioOutDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), WsPlanTarifarioOutDTO.class);
				resultado.setWsPlanTarifarioArrOutDTO(planesTarifarios);
				cat.debug("lista de planes tarifarios");
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener lista de planes tarifarios",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error [" + codError +  "]");
				cat.debug("Mensaje de Error[" + msgError +  "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
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
		cat.debug("Fin:getListadoPlanesTarifarios()");
		return resultado;
	}//fin getListadoPlanesTarifarios
	

	/**
	 * Obtiene Lista de tipos de planes tarifarios
	 * @return resultado
	 * @throws GeneralException
	 */
	public WsListTipoPlanTarifarioOutDTO getListadoTiposPlanesTarifarios() throws GeneralException{
		//RSIS26
		WsListTipoPlanTarifarioOutDTO resultado = null;
		WsTipoPlanTarifarioOutDTO[] tiposPlanesTarifarios= null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:getListadoTiposPlanesTarifarios()");
			resultado = new WsListTipoPlanTarifarioOutDTO();
			String call = getSQLDatosPlanTarifario("GE_CONS_CATALOGO_PORTAB_PG","GE_REC_TIP_PLANTARIF_PR",4);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.registerOutParameter(1,OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getListadoTiposPlanesTarifarios:execute");
			cstmt.execute();
			cat.debug("Fin:getListadoTiposPlanesTarifarios:execute");

			codError  = cstmt.getInt(2);
			msgError  = cstmt.getString(3);
			numEvento = cstmt.getInt(4);
			
			cat.debug("codError ["+codError+"]");
			cat.debug("msgError ["+msgError+"]");
			cat.debug("numEvento ["+numEvento+"]");
			
			if (codError != 0) {
				cat.error("Ocurrió un error al obtener lista de tipos de planes tarifarios");
				resultado.setMensajseError(msgError);
				resultado.setCodError(""+codError);
				throw new GeneralException(
						  "Ocurrió un error al obtener lista de tipos de planes tarifarios", String
								.valueOf(codError), numEvento, msgError);
			}else{
				cat.debug("Recuperando lista de tipos de planes tarifarios");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(1);
				while (rs.next()) {
					WsTipoPlanTarifarioOutDTO tipoPlanTarifarioRS = new WsTipoPlanTarifarioOutDTO();
					tipoPlanTarifarioRS.setTipPlanTarif(rs.getString(1));
					lista.add(tipoPlanTarifarioRS);
				}
				rs.close();
				tiposPlanesTarifarios =(WsTipoPlanTarifarioOutDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), WsTipoPlanTarifarioOutDTO.class);
				resultado.setWsTipoPlanTarifarioArrOutDTO(tiposPlanesTarifarios);
				
				cat.debug("lista de tipos de planes tarifarios");
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		}catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener lista de tipos de planes tarifarios",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error [" + codError +  "]");
				cat.debug("Mensaje de Error[" + msgError +  "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
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
		cat.debug("Fin:getListadoTiposPlanesTarifarios()");
		return resultado;
	}//fin getListadoTiposPlanesTarifarios
	
	
	public PlanTarifarioDTO getPlanTarifario(PlanTarifarioDTO planEntrada) throws GeneralException{
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
			//INI-01 (AL) String call = getSQLDatosPlanTarifario("VE_servicios_venta_PG","VE_consulta_plan_tarifario_PR",20);
			String call = getSQLDatosPlanTarifario("VE_servicios_venta_Quiosco_PG","VE_consulta_plan_tarifario_PR",20);
			cat.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,planEntrada.getCodigoPlanTarifario());
			cstmt.setInt(2,Integer.parseInt(planEntrada.getCodigoProducto()));
			cstmt.setString(3,planEntrada.getCodigoTecnologia());
			
			cat.debug(planEntrada.getCodigoPlanTarifario());
			cat.debug(planEntrada.getCodigoProducto());
			cat.debug(planEntrada.getCodigoTecnologia());
			
			
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
			//-- control error
			cstmt.registerOutParameter(18, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(19, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(20, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getPlanTarifario:execute");
			cstmt.execute();
			cat.debug("Fin:getPlanTarifario:execute");

			codError = cstmt.getInt(18);
			msgError = cstmt.getString(19);
			numEvento = cstmt.getInt(20);

			cat.debug("codError ["+codError+"]");
			cat.debug("msgError ["+msgError+"]");
			cat.debug("numEvento ["+numEvento+"]");
			
			if (codError == 1){
				codError = 12242;
				msgError = "Error el plan tarifario no existe o no esta vigente";
			}
			
			cat.debug("codError ["+codError+"]");
			cat.debug("msgError ["+msgError+"]");
			cat.debug("numEvento ["+numEvento+"]");
			
			if (codError != 0) {
				cat.error("Ocurrió un error al obtener planes tarifarios");
				throw new GeneralException(
						  "Ocurrió un error al obtener planes tarifarios", String
								.valueOf(codError), numEvento, msgError);
			}
			
			//-- plan tarifario
			resultado.setDescripcionPlanTarifario(cstmt.getString(4));
			cat.debug("resultado.getDescripcionPlanTarifario() ["+resultado.getDescripcionPlanTarifario()+"]");
			resultado.setTipoPlanTarifario(cstmt.getString(5));
			cat.debug("resultado.getTipoPlanTarifario() ["+resultado.getTipoPlanTarifario()+"]");
			resultado.setCodigoLimiteConsumo(cstmt.getString(6));
			cat.debug("resultado.getCodigoLimiteConsumo() ["+resultado.getCodigoLimiteConsumo()+"]");
			resultado.setNumDias(cstmt.getInt(7));
			cat.debug("resultado.getNumDias() ["+resultado.getNumDias()+"]");
			resultado.setCodigoPlanServicio(cstmt.getString(8));
			cat.debug("resultado.getCodigoPlanServicio() ["+resultado.getCodigoPlanServicio()+"]");
			resultado.setIndicadorCargoHabilitacion(cstmt.getString(9));
			cat.debug("resultado.getIndicadorCargoHabilitacion() ["+resultado.getIndicadorCargoHabilitacion()+"]");
			
			//-- cargo basico
			resultado.setCodigoCargoBasico(cstmt.getString(10));
			cat.debug("resultado.getCodigoCargoBasico() ["+resultado.getCodigoCargoBasico()+"]");
			resultado.setDescripcionCargoBasico(cstmt.getString(11));
			cat.debug("resultado.getDescripcionCargoBasico() ["+resultado.getDescripcionCargoBasico()+"]");
			resultado.setImporteCargoBasico(cstmt.getFloat(12));
			cat.debug("resultado.getImporteCargoBasico() ["+resultado.getImporteCargoBasico()+"]");
			resultado.setCodigoMonedaCargoBasico(cstmt.getString(13));
			cat.debug("resultado.getCodigoMonedaCargoBasico() ["+resultado.getCodigoMonedaCargoBasico()+"]");
			resultado.setCodigoTipoPlan(cstmt.getString(14));
			cat.debug("resultado.getCodigoTipoPlan() ["+resultado.getCodigoTipoPlan()+"]");
			resultado.setIndFamiliar(cstmt.getInt(15));
			cat.debug("resultado.getIndFamiliar() ["+resultado.getIndFamiliar()+"]");
			resultado.setNumeroAbonados(cstmt.getInt(16));
			cat.debug("resultado.getNumeroAbonados() ["+resultado.getNumeroAbonados()+"]");
			resultado.setPlanComverse(cstmt.getString(17));
			cat.debug("resultado.getPlanComverse() ["+resultado.getPlanComverse()+"]");
			
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		}catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar Plan Tarifario",e);
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
		cat.debug("Fin:getPlanTarifario()");
		return resultado;
	}//fin getPlanTarifario

	/**
	 * Verifica si Existe o no un Plan Tarifario especifico 
	 * @param planEntrada
	 * @return resultado
	 * @throws GeneralException
	 */
	
	public ResultadoValidacionTasacionDTO existePlanTarifario(ParametrosValidacionTasacionDTO planEntrada) 
	throws GeneralException{
		cat.debug("Inicio:existePlanTarifario()");
		ResultadoValidacionTasacionDTO resultado = new ResultadoValidacionTasacionDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			//INI-01 (AL) String call = getSQLDatosPlanTarifario("VE_validacion_linea_PG","VE_existe_plan_tarifario_PR",7);
			String call = getSQLDatosPlanTarifario("VE_validacion_linea_quiosco_PG","VE_existe_plan_tarifario_PR",7);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,planEntrada.getCodigoPlanTarifario());
			cat.debug("planEntrada.getCodigoPlanTarifario() ["+planEntrada.getCodigoPlanTarifario()+"]");
			cstmt.setInt(2,Integer.parseInt(planEntrada.getCodigoProducto()));
			cat.debug("planEntrada.getCodigoProducto() ["+planEntrada.getCodigoProducto()+"]");
			cstmt.setString(3,planEntrada.getCodigoTecnologia());
			cat.debug("planEntrada.getCodigoTecnologia() ["+planEntrada.getCodigoTecnologia()+"]");
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC); //SB_resultado
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:existePlanTarifario:Execute");
			cstmt.execute();
			cat.debug("Fin:existePlanTarifario:Execute");
			
			codError = cstmt.getInt(5);			
			msgError = cstmt.getString(6);
			numEvento = cstmt.getInt(7);
			
			cat.debug("codError ["+codError+"]");
			cat.debug("msgError ["+msgError+"]");
			cat.debug("numEvento ["+numEvento+"]");
						
			cat.debug("msgError[" + msgError + "]");
			
			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar Plan Tarifario");				
				throw new GeneralException(
						  "Ocurrió un error al recuperar Plan Tarifario", String
								.valueOf(codError), numEvento, msgError);
			}
			
			resultado.setResultadoBase(cstmt.getInt(4));
			cat.debug("resultado.getResultadoBase() ["+resultado.getResultadoBase()+"]");
			
			
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		}catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar Plan Tarifario",e);
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

		cat.debug("Fin:existePlanTarifario()");

		return resultado;
	}
	
	/**
	 * Busca todos los Cargos Basicos asociados al Plan Tarifario
	 * @param entrada
	 * @return resultado
	 * @throws GeneralException
	 */
	public PrecioCargoDTO[] getCargoBasico(PlanTarifarioDTO entrada) throws GeneralException{
		cat.debug("Inicio:getCargoBasico()");
		PrecioCargoDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			//INI-01 (AL) String call = getSQLDatosPlanTarifario("VE_servicios_venta_PG","VE_precio_cargo_basico_PR",6);
			String call = getSQLDatosPlanTarifario("VE_servicios_venta_Quiosco_PG","VE_precio_cargo_basico_PR",6);
			cat.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,entrada.getCodigoProducto());
			cstmt.setString(2,entrada.getCodigoCargoBasico());
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
			
			cat.debug("codError ["+codError+"]");
			cat.debug("msgError ["+msgError+"]");
			cat.debug("numEvento ["+numEvento+"]");

			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar cargos basicos");
				throw new GeneralException(
						"Ocurrió un error al recuperar cargos basicos", String
								.valueOf(codError), numEvento, msgError);
				
			}else{
				cat.debug("Recuperando cargos basicos");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(3);
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
				rs.close();
				resultado =(PrecioCargoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), PrecioCargoDTO.class);
				
				cat.debug("Fin recuperacion de cargos basicos");
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		}catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar cargos basicos",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al recuperar cargos basicos",e);
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
		cat.debug("Fin:getCargoBasico()");

		return resultado;
	}//fin getCargoBasico
	
	/**
	 * Busca todos los Descuentos tipo Articulo asociados al Plan Tarifario(Cargo Basico) 
	 * @param entrada
	 * @return resultado
	 * @throws GeneralException
	 */
	public DescuentoDTO[] getDescuentoCargoBasicoArticulo(ParametrosDescuentoDTO entrada) throws GeneralException{
		cat.debug("Inicio:getDescuentoCargoBasicoArticulo()");
		DescuentoDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			//INI-01 (AL) String call = getSQLDatosPlanTarifario("VE_servicios_venta_PG","VE_obtiene_descuento_art_PR",14);
			String call = getSQLDatosPlanTarifario("VE_servicios_venta_Quiosco_PG","VE_obtiene_descuento_art_PR",14);
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
			
			cat.debug("codError ["+codError+"]");
			cat.debug("msgError ["+msgError+"]");
			cat.debug("numEvento ["+numEvento+"]");
			
			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar los descuentos del cargo basico");
				throw new GeneralException(
						"Ocurrió un error al recuperar los descuentos del cargo basico", String
								.valueOf(codError), numEvento, msgError);
			}

			if (codError == 0) {
				cat.debug("Recuperando descuentos");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(11);
				while (rs.next()) {
					DescuentoDTO descuentoDTO = new DescuentoDTO();
					descuentoDTO.setTipoAplicacion(rs.getString(1));
					descuentoDTO.setDescripcionConcepto(rs.getString(2));
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
		}catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar los descuentos del cargo basico",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
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
	 * @throws GeneralException
	 */
	public DescuentoDTO[] getDescuentoCargoBasicoConcepto(ParametrosDescuentoDTO entrada) throws GeneralException{
		cat.debug("Inicio:PlanTarifarioDAO:getDescuentoCargoBasicoConcepto()");
		DescuentoDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			//INI-01 (AL) String call = getSQLDatosPlanTarifario("VE_servicios_venta_PG","VE_obtiene_descuento_con_PR",16);
			String call = getSQLDatosPlanTarifario("VE_servicios_venta_Quiosco_PG","VE_obtiene_descuento_con_PR",16);
			cat.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,entrada.getCodigoOperacion());
			cstmt.setString(2,entrada.getCodigoAntiguedad());
			cstmt.setString(3,entrada.getTipoContrato());
			cstmt.setInt(4,Integer.parseInt(entrada.getNumeroMesesNuevo()));
			cstmt.setInt(5,Integer.parseInt(entrada.getIndiceVentaExterna()));
			cstmt.setLong(6,Long.parseLong(entrada.getCodigoVendedor()));
			cstmt.setString(7,entrada.getCodigoCausaDescuento());
			cstmt.setString(8,entrada.getCodigoCategoria());
			cstmt.setInt(9,Integer.parseInt(entrada.getCodigoModalidadVenta()));
			cstmt.setInt(10,Integer.parseInt(entrada.getTipoPlanTarifario()));
			cstmt.setInt(11,Integer.parseInt(entrada.getConcepto()));
			cstmt.setString(12,entrada.getClaseDescuento());
			cstmt.registerOutParameter(13,OracleTypes.CURSOR);
			//-- control error
			cstmt.registerOutParameter(14, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(15, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(16, java.sql.Types.NUMERIC);
			
			cstmt.execute();
			
			codError = cstmt.getInt(14);
			msgError = cstmt.getString(15);
			numEvento = cstmt.getInt(16);
			
			cat.debug("codError ["+codError+"]");
			cat.debug("msgError ["+msgError+"]");
			cat.debug("numEvento ["+numEvento+"]");
			
			if (codError != 0) {
				cat.error("Ocurrió un error getDescuentoCargoBasicoConcepto");
				throw new GeneralException(
						"Ocurrió un error getDescuentoCargoBasicoConcepto", String
								.valueOf(codError), numEvento, msgError);
			}

			if (codError == 0) {
				cat.debug("Recuperando descuentos");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(13);
				while (rs.next()) {
					DescuentoDTO descuentoDTO = new DescuentoDTO();
					descuentoDTO.setTipoAplicacion(rs.getString(1));
					descuentoDTO.setDescripcionConcepto(rs.getString(2));
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
		}catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error getDescuentoCargoBasicoConcepto",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
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
	 * @throws GeneralException
	 */
	public PlanTarifarioDTO getCategoriaPlanTarifario(PlanTarifarioDTO planEntrada) throws GeneralException{
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
			//INI-01 (AL) String call = getSQLDatosPlanTarifario("VE_servicios_venta_PG","VE_consulta_categ_ptarif_PR",5);
			String call = getSQLDatosPlanTarifario("VE_servicios_venta_Quiosco_PG","VE_consulta_categ_ptarif_PR",5);
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
			
			cat.debug("codError ["+codError+"]");
			cat.debug("msgError ["+msgError+"]");
			cat.debug("numEvento ["+numEvento+"]");
			
			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar la Categoria del Plan Tarifario");
				throw new GeneralException(
						"Ocurrió un error al recuperar la Categoria del Plan Tarifario", String
								.valueOf(codError), numEvento, msgError);
			}else
				resultado.setCodigoCategoria(cstmt.getString(2));
			
			
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		}catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar la Categoria del Plan Tarifario",e);
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

		cat.debug("Fin:PlanTarifarioDAO:getCategoriaPlanTarifario()");

		return resultado;
	}//fin getCategoriaPlanTarifario
	
	/**
	 * Obtiene Codigo Concepto Facturable del descuento manual 
	 * @param entrada
	 * @return resultado
	 * @throws GeneralException
	 */
	public DescuentoDTO getCodigoDescuentoManual(ParametrosDescuentoDTO entrada) throws GeneralException{
		cat.debug("Inicio:getCodigoDescuentoManual()");
		DescuentoDTO resultado = new DescuentoDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			//INI-01 (AL) String call = getSQLDatosPlanTarifario("VE_servicios_venta_PG","VE_consulta_cod_desc_manual_PR",6);
			String call = getSQLDatosPlanTarifario("VE_servicios_venta_Quiosco_PG","VE_consulta_cod_desc_manual_PR",6);
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
			
			cat.debug("codError ["+codError+"]");
			cat.debug("msgError ["+msgError+"]");
			cat.debug("numEvento ["+numEvento+"]");
			
			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar el código de descuento manual");
				throw new GeneralException(
						"Ocurrió un error al recuperar el código de descuento manual", String
								.valueOf(codError), numEvento, msgError);
			}

			if (codError == 0) 
				resultado.setCodigoConcepto(String.valueOf(cstmt.getInt(3)));
			
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar el código de descuento manual",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
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
	 * @throws GeneralException
	 */
	public PlanTarifarioDTO[] getListLimiteConsumo(PlanTarifarioDTO entrada)
	throws GeneralException{
		cat.debug("Inicio:getListLimiteConsumo()");
		PlanTarifarioDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			String call = getSQLDatosPlanTarifario("TO_servicios_tol_PG","TO_getListLimiteConsumo_PR",7);
			cat.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);

			cstmt.setString(1,entrada.getCodigoPlanTarifario());
			cstmt.setString(2,entrada.getFormatoFecha1());
			cstmt.setString(3,entrada.getFormatoFecha2());

			cstmt.registerOutParameter(4,OracleTypes.CURSOR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getListLimiteConsumo:execute");
			cstmt.execute();
			cat.debug("Fin:getListLimiteConsumo:execute");
			
			codError = cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento = cstmt.getInt(7);
			
			cat.debug("codError ["+codError+"]");
			cat.debug("msgError ["+msgError+"]");
			cat.debug("numEvento ["+numEvento+"]");
			
			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar limites de consumo para el plan tarifario");
				throw new GeneralException(
						"Ocurrió un error al recuperar limites de consumo para el plan tarifario", String
								.valueOf(codError), numEvento, msgError);
				
			}else{
				cat.debug("Recuperando SS del abonado");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(4);
				while (rs.next()) {
					PlanTarifarioDTO planTarifarioDTO = new PlanTarifarioDTO();
					planTarifarioDTO.setCodigoLimiteConsumo(rs.getString(1));
					planTarifarioDTO.setDescripcionLimiteConsumo(rs.getString(2));
					planTarifarioDTO.setImporteLimite(rs.getLong(3));
					planTarifarioDTO.setIndicadorUnidades(rs.getString(4));
					planTarifarioDTO.setIndicadorDefault(rs.getString(5));
					planTarifarioDTO.setFechaDesde(rs.getString(6));
					planTarifarioDTO.setFechaHasta(rs.getString(7));
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
		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar limites de consumo para el plan tarifario",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
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
	 * @throws GeneralException
	 */
	public PlanTarifarioDTO[] getListPlanTarifario(PlanTarifarioDTO entrada)
	throws GeneralException{
		cat.debug("Inicio:getListPlanTarifario()");
		PlanTarifarioDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			//INI-01 (AL) String call = getSQLDatosPlanTarifario("Ve_Servicios_Venta_Pg","VE_getListPlanTarifario_PR",5);
			String call = getSQLDatosPlanTarifario("Ve_Servicios_Venta_Quiosco_Pg","VE_getListPlanTarifario_PR",5);
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
			
			cat.debug("codError ["+codError+"]");
			cat.debug("msgError ["+msgError+"]");
			cat.debug("numEvento ["+numEvento+"]");
			
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
			}else {
				cat.error("Ocurrió un error al recuperar planes tarifarios (comercializables o no)");
				throw new GeneralException(
						"Ocurrió un error al recuperar planes tarifarios (comercializables o no)", String
								.valueOf(codError), numEvento, msgError);
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
			}
		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar planes tarifarios (comercializables o no)",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
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
	 * @throws GeneralException
	 */
	public PlanTarifarioDTO[] getListPlanTarifarioNumIdentTipoPlan(PlanTarifarioDTO entrada)
	throws GeneralException{
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
			
			cat.debug("codError ["+codError+"]");
			cat.debug("msgError ["+msgError+"]");
			cat.debug("numEvento ["+numEvento+"]");
			
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
			}else {
				cat.error("Ocurrió un error al recuperar planes tarifarios  segun numero identificador");
				throw new GeneralException(
						"Ocurrió un error al recuperar planes tarifarios  segun numero identificador", String
								.valueOf(codError), numEvento, msgError);
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
			}
		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar planes tarifarios  segun numero identificador",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
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
	
	/**
	 * Obtiene indicador vigencia relacion plan uso
	 * @param codCliente 
	 * @return resultado
	 * @throws GeneralException
	 */		
	public String obtieneVigenciaPlanUso(PlanUsoDTO entrada)
		throws GeneralException	
	{
		cat.debug("Inicio:getCodigoDescuentoManual()");
		String resultado = "";
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			//INI-01 (AL) String call = getSQLDatosPlanTarifario("VE_servicios_venta_PG","VE_obtiene_VigPlanUso_PR",6);
			String call = getSQLDatosPlanTarifario("VE_servicios_venta_Quiosco_PG","VE_obtiene_VigPlanUso_PR",6);
			cat.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,entrada.getCodPlanTarif());
			cstmt.setLong(2,entrada.getCodUso().longValue());			
			cstmt.registerOutParameter(3,java.sql.Types.VARCHAR);			
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			
			cstmt.execute();
			
			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);
			
			cat.debug("codError ["+codError+"]");
			cat.debug("msgError ["+msgError+"]");
			cat.debug("numEvento ["+numEvento+"]");

			if (codError == 0) 
				resultado = cstmt.getString(3);
			else{
				cat.error("Ocurrió un error al obtener Vigencia Plan Uso");
				throw new GeneralException(
						"Ocurrió un error al obtener Vigencia Plan Uso", String
								.valueOf(codError), numEvento, msgError);				
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener Vigencia Plan Uso",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al obtener Vigencia Plan Uso",e);
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
	 * Obtiene indicador vigencia relacion plan uso
	 * @param codCliente 
	 * @return resultado
	 * @throws GeneralException
	 */		
	public String obtieneVigenciaPlanUsoSimcard(PlanUsoDTO entrada)
		throws GeneralException	
	{
		cat.debug("Inicio:obtieneVigenciaPlanUsoSimcard()");
		String resultado = "";
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			//INI-01 (AL) String call = getSQLDatosPlanTarifario("VE_servicios_venta_PG","VE_obtiene_VigPlanSerie_PR",6);
			String call = getSQLDatosPlanTarifario("VE_servicios_venta_Quiosco_PG","VE_obtiene_VigPlanSerie_PR",6);
			cat.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,entrada.getCodPlanTarif());
			cstmt.setString(2,entrada.getNumSerie());			
			cstmt.registerOutParameter(3,java.sql.Types.VARCHAR);			
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			
			cstmt.execute();
			
			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);
			
			cat.debug("codError ["+codError+"]");
			cat.debug("msgError ["+msgError+"]");
			cat.debug("numEvento ["+numEvento+"]");

			if (codError == 0) 
				resultado = cstmt.getString(3);
			else{
				cat.error("Ocurrió un error al obtener Vigencia Plan Uso Simcard");
				throw new GeneralException(
						"Ocurrió un error al obtener Vigencia Plan Uso Simcard", String
								.valueOf(codError), numEvento, msgError);				
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener Vigencia Plan Uso Simcard",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al obtener Vigencia Plan Uso Simcard",e);
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
		cat.debug("Fin:obtieneVigenciaPlanUsoSimcard()");

		return resultado;
	}//fin obtieneVigenciaPlanUsoSimcard	
	
	/**
	 * Obtiene planes tarifarios segun numero identificador sin ER
	 * @param entrada
	 * @return PlanTarifarioDTO[]
	 * @throws GeneralException
	 */
	public PlanTarifarioDTO[] getListPlanTarifarioNumIdentTipoPlanSinER(PlanTarifarioDTO entrada)
	throws GeneralException{
		cat.debug("Inicio:getListPlanTarifarioNumIdentTipoPlanSinER()");
		PlanTarifarioDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		ResultSet rs = null;
		try {
			String call = getSQLDatosPlanTarifario("ER_servicios_evalriesgo_PG","ER_getListPlanTarifTipo_PR",5);
			cat.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);

			cat.debug("entrada.getTipoPlanTarifario(): " + entrada.getTipoPlanTarifario());
			cstmt.setString(1,entrada.getTipoPlanTarifario());
			cstmt.registerOutParameter(2,OracleTypes.CURSOR);
			cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getListPlanTarifarioNumIdentTipoPlanSinER:execute");
			cstmt.execute();
			cat.debug("Fin:getListPlanTarifarioNumIdentTipoPlanSinER:execute");
			
			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			cat.debug("codError ["+codError+"]");
			cat.debug("msgError ["+msgError+"]");
			cat.debug("numEvento ["+numEvento+"]");
			
			if (codError == 0) {
				cat.debug("Recuperando planes tarifarios");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(2);
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
			}else{
				cat.error("Ocurrió un error al recuperar planes tarifarios segun numero identificador");
				throw new GeneralException(
						"Ocurrió un error al recuperar planes tarifarios segun numero identificador", String
								.valueOf(codError), numEvento, msgError);				
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
			}
		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar planes tarifarios  segun numero identificador",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al recuperar planes tarifarios  segun numero identificador",e);
		} finally {
		 	if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				
				if(rs !=null) rs.close();
				
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:getListPlanTarifarioNumIdentTipoPlanSinER()");
		return resultado;
	}//fin getListPlanTarifarioNumIdentTipoPlanSinER

	/**
	 * Obtiene planes tarifarios comercializables y no comercializables
	 * @param entrada
	 * @return PlanTarifarioDTO[]
	 * @throws GeneralException
	 */
	public WSPlanTarifarioOutDTO getPlanTarifarioImporteImpuesto(WSPlanTarifarioInDTO entrada)
	throws GeneralException{
		cat.debug("Inicio:getPlanTarifarioImporteImpuesto()");
		WSPlanTarifarioOutDTO resultado = new WSPlanTarifarioOutDTO();;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			String call = getSQLDatosPlanTarifario("ve_portabilidad_pg","ve_rec_plan_imp_pre_pr",13);
			cat.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,entrada.getCodPlanTarifario());
			cstmt.setString(2,entrada.getCodigoVendedor());
			
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);
			
			cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(13, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getPlanTarifarioImporteImpuesto:execute");
			cstmt.execute();
			cat.debug("Fin:getPlanTarifarioImporteImpuesto:execute");
			
			codError = cstmt.getInt(11);
			msgError = cstmt.getString(12);
			numEvento = cstmt.getInt(13);
			
			cat.debug("codError ["+codError+"]");
			cat.debug("msgError ["+msgError+"]");
			cat.debug("numEvento ["+numEvento+"]");
			
			if (codError != 0) {
				cat.error("Ocurrió un error en getPlanTarifarioImporteImpuesto");
				throw new GeneralException(
						"Ocurrió un error en getPlanTarifarioImporteImpuesto", String
						.valueOf(codError), numEvento, msgError);
			}
			
			resultado.setCodigoPlantarif(cstmt.getString(3));
			resultado.setDescripcionPlantarif(cstmt.getString(4));
			resultado.setCodigoCargoBasico(cstmt.getString(5));
			resultado.setDescripcionCargoBasico(cstmt.getString(6));
			
			resultado.setImporteCargoBasico(new Float(cstmt.getFloat(7)));			
			resultado.setValorImpuesto(new Float(cstmt.getFloat(8)));
			resultado.setTotal(new Float(cstmt.getFloat(9)));
			resultado.setImpuesto(new Float(cstmt.getFloat(10)));
			
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
			}
		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error en getPlanTarifarioImporteImpuesto",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error en getPlanTarifarioImporteImpuesto",e);
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
		cat.debug("Fin:getPlanTarifarioImporteImpuesto()");
		return resultado;
	}//fin getPlanTarifarioImporteImpuesto	
	
	/**
	 * Obtiene Lista de planes tarifario
	 * @param planTarifarioDTO 
	 * @return resultado
	 * @throws GeneralException
	 */
	public WsListConsultaPlanTarifarioOutDTO getConsultaPlanesTarifarios(WsConsultaPlanTarifarioInDTO consultaPlanTarifarioIn) throws GeneralException{
		//RSIS27
		WsListConsultaPlanTarifarioOutDTO resultado = null;
		WsConsultaPlanTarifarioOutDTO[] planesTarifarios = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:getListadoPlanesTarifarios()");
			resultado = new WsListConsultaPlanTarifarioOutDTO();
			String call = getSQLDatosPlanTarifario("GE_CONS_CATALOGO_PORTAB_PG","GE_CONSULTA_PLANES_TARIF_PR",11);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,consultaPlanTarifarioIn.getTipProducto());
			cstmt.setString(2,consultaPlanTarifarioIn.getTipRed());
			cstmt.setString(3,consultaPlanTarifarioIn.getTipPlanTarif());
			cstmt.setInt(4,consultaPlanTarifarioIn.getIndFamiliar());
			cstmt.setString(5,consultaPlanTarifarioIn.getCodTecnologia());
			cstmt.setString(6,consultaPlanTarifarioIn.getCodCategoria());
			cstmt.setString(7,consultaPlanTarifarioIn.getCodSegmento());
			cstmt.registerOutParameter(8,OracleTypes.CURSOR);
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getListadoPlanesTarifarios:execute");
			cstmt.execute();
			cat.debug("Fin:getListadoPlanesTarifarios:execute");

			codError  = cstmt.getInt(9);
			msgError  = cstmt.getString(10);
			numEvento = cstmt.getInt(11);
			
			cat.debug("codError ["+codError+"]");
			cat.debug("msgError ["+msgError+"]");
			cat.debug("numEvento ["+numEvento+"]");
			
			if (codError != 0) {
				cat.error("Ocurrió un error al obtener lista de planes tarifarios");
				resultado.setMensajseError(msgError);
				cat.debug("msgError ["+msgError+"]");
				resultado.setCodError(""+codError);
				throw new GeneralException(
						  "Ocurrió un error al obtener lista de planes tarifarios", String
								.valueOf(codError), numEvento, msgError);
			}else{
				cat.debug("Recuperando lista de planes tarifarios");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(8);
				while (rs.next()) {
					WsConsultaPlanTarifarioOutDTO planTarifarioRS = new WsConsultaPlanTarifarioOutDTO();
					planTarifarioRS.setCodCargoBasico(rs.getString(1));
					planTarifarioRS.setDesCargoBasico(rs.getString(2));
					planTarifarioRS.setImpCargoBasico(rs.getFloat(3));
					planTarifarioRS.setCodMoneda(rs.getString(4));
					planTarifarioRS.setTipUnidades(rs.getString(5));
					planTarifarioRS.setTipUnitas(rs.getString(6));
					planTarifarioRS.setNumUnidades(rs.getInt(7));
					planTarifarioRS.setCodPlanTarif(rs.getString(8));
					planTarifarioRS.setDesPlantarif(rs.getString(9));
					planTarifarioRS.setCodTipPlan(rs.getString(10));
					
					
					lista.add(planTarifarioRS);
				}
				rs.close();
				planesTarifarios =(WsConsultaPlanTarifarioOutDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), WsConsultaPlanTarifarioOutDTO.class);
				resultado.setWsConsultaPlanTarifarioArrOutDTO(planesTarifarios);
				
				cat.debug("lista de planes tarifarios");
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener lista de planes tarifarios",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error [" + codError +  "]");
				cat.debug("Mensaje de Error[" + msgError +  "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
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
		cat.debug("Fin:getListadoPlanesTarifarios()");
		return resultado;
	}//fin getListadoPlanesTarifarios
	
	

	public void getPlanTarifarioClienteEMP(PlanTarifarioDTO planEntrada) throws GeneralException{
		cat.debug("Inicio:getPlanTarifario()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			//INI-01 (AL) String call = getSQLDatosPlanTarifario("VE_servicios_venta_PG","ve_cons_plan_tarif_clie_emp_pr",5);
			String call = getSQLDatosPlanTarifario("VE_servicios_venta_Quiosco_PG","ve_cons_plan_tarif_clie_emp_pr",5);
			cat.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,planEntrada.getCodigoPlanTarifario());
			cstmt.setInt(2,Integer.parseInt(planEntrada.getCodigoProducto()));
			
			cat.debug(planEntrada.getCodigoPlanTarifario());
			cat.debug(planEntrada.getCodigoProducto());
			//-- control error
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getPlanTarifario:execute");
			cstmt.execute();
			cat.debug("Fin:getPlanTarifario:execute");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);

			cat.debug("codError ["+codError+"]");
			cat.debug("msgError ["+msgError+"]");
			cat.debug("numEvento ["+numEvento+"]");
				
						
			if (codError != 0) {
				cat.error("Ocurrió un error al obtener planes tarifarios");
				throw new GeneralException(
						  "Ocurrió un error al obtener planes tarifarios", String
								.valueOf(codError), numEvento, msgError);
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		}catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar Plan Tarifario",e);
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
		cat.debug("Fin:getPlanTarifario()");
	}//fin getPlanTarifario	
}//fin class PlanTarifarioDAO
