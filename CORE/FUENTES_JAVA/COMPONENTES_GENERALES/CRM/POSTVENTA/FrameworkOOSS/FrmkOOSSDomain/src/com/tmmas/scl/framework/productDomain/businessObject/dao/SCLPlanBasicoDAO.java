/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 31/05/2007	     	Elizabeth Vera        				Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.businessObject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.CicloFactDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces.SCLPlanBasicoDAOIT;
import com.tmmas.scl.framework.productDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.BusquedaPlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.BusquedaServiciosDefaultDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.PaqueteDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.PlanCicloDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.PlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.PlanTarifarioListDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ProductoOfertadoListDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ServiciosDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductOfferingException;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.BolsaDinamicaDTO;

public class SCLPlanBasicoDAO extends ConnectionDAO implements
		SCLPlanBasicoDAOIT {

	private final Logger logger = Logger.getLogger(SCLPlanBasicoDAO.class);

	private final Global global = Global.getInstance();
	
	private String getSQLobtenerPlanesTarifarios() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   eo_planes PV_PLANES_TARIFARIOS_QT := PV_INICIA_ESTRUCTURAS_PG.PV_PLANES_TARIFARIOS_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_planes.COD_CLIENTE := ?;");
		call.append("   eo_planes.COD_PLANTARIF:= ?;");		  
		call.append("   eo_planes.TIP_PLANTARIF := ?;");
		call.append("   eo_planes.COD_TIPLAN := ?;");		
		call.append("   eo_planes.COD_TECNOLOGIA:= ?;");
		call.append("   eo_planes.NUM_ABONADO:= ?;");
		call.append("   eo_planes.NOM_USUARORA:= ?;");
		call.append("   eo_planes.CAMBIO_PLANFAMILIAR := ?;");
		call.append("   PV_PLAN_BASICO_PG.PV_OBTIENE_PLANES_PR( eo_planes,?, ?, ?, ?, ?, ?, ?);");
		call.append(" END;");		
		return call.toString();		
	}	

	private String getSQLregistroHistoricoPlan() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   eo_ciclo PV_FA_CICLFACT_QT := PV_INICIA_ESTRUCTURAS_PG.PV_FA_CICLFACT_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_ciclo.COD_CICLO := ?;");
		call.append("   eo_ciclo.NUM_ABONADO := ?;");
		call.append("   PV_PLAN_BASICO_PG.PV_REGISTRO_HIST_PLAN_PR( eo_ciclo, ?, ?, ?);");
		call.append(" END;");		
		return call.toString();		
	}

	private String getSQLobtenerServiciosDefaultPlan() {
		StringBuffer call = new StringBuffer();
		//AGREGAR INVOCACION A PL
		return call.toString();		
	}
	
	private String getSQLobtenerProductosPorDefectoPlan() {
		StringBuffer call = new StringBuffer();
		//AGREGAR INVOCACION A PL
		return call.toString();		
	}
	
	private String getSQLanularCargoBolsaDinamica() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   eo_bolsa PV_BOLSAS_DINAMICAS_QT := PV_INICIA_ESTRUCTURAS_PG.PV_BOLSAS_DINAMICAS_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_bolsa.SECUENCIA := ?;");
		call.append("   eo_bolsa.COD_CLIENTE := ?;");
		call.append("   eo_bolsa.COD_CICLO:= ?;");
		call.append("   eo_bolsa.COD_PLANTARIF1:= ?;");
		call.append("   PV_PLAN_BASICO_PG.PV_ANU_CARGO_BOLSDINAMICA_PR( eo_bolsa, ?, ?, ?);");
		call.append(" END;");
		return call.toString();		
	}
	
	private String getSQLvalidaFreedom() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   eo_cliente PV_CLIENTE_QT := PV_INICIA_ESTRUCTURAS_PG.PV_INICIA_PV_CLIENTE_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_cliente.COD_CLIENTE := ?;");
		call.append("   PV_PLAN_BASICO_PG.PV_VALIDA_FREEDOM_PR( eo_cliente, ?, ?, ?);");
		call.append("   		? := eo_cliente.PLAN_FREEDOM;");
		call.append(" END;");	
		return call.toString();		
	}

	private String getSQLobtenerCicloFreedom() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   so_abonado GA_ABONADO_QT := PV_INICIA_ESTRUCTURAS_PG.PV_INICIA_GA_ABONADO_QT_FN;");
		call.append(" BEGIN ");
		call.append("   so_abonado.COD_PLANTARIF := ?;");
		call.append("   PV_PLAN_BASICO_PG.PV_OBT_CICLO_FREEDOM_PRasoc_PR( so_abonado, ?, ?, ?);");
		call.append("   		? := so_abonado.COD_CICLO;");
		call.append(" END;");	
		return call.toString();		
	}	
	
	private String getSQLobtenerCategPlan() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   so_plan PV_PLANES_TARIFARIOS_QT := PV_INICIA_ESTRUCTURAS_PG.PV_PLANES_TARIFARIOS_QT_FN;");
		call.append(" BEGIN ");
		call.append("   so_plan.COD_PLANTARIF := ?;");
		call.append("   PV_PLAN_BASICO_PG.PV_OBTENER_CATEG_PLAN_PR( so_plan, ?, ?, ?);");
		call.append("   		? := so_plan.COD_CATEGORIA;");
		call.append(" END;");	
		return call.toString();		
	}
	
	private String getSQLobtenerPlanComercial() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   so_cliente PV_CLIENTE_QT := PV_INICIA_ESTRUCTURAS_PG.PV_INICIA_PV_CLIENTE_QT_FN;");
		call.append(" BEGIN ");
		call.append("   so_cliente.COD_CLIENTE := ?;");
		call.append("   PV_PLAN_BASICO_PG.PV_OBTENER_PLAN_COMERCIAL_PR( so_cliente, ?, ?, ?);");
		call.append("   		? := so_cliente.COD_PLANCOM;");
		call.append(" END;");	
		return call.toString();		
	}
	
	private String getSQLobtenerDetallePlanTarif()
	{
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE "); 
		call.append("   EO_PLANTARIF TA_PLANTARIF_QT; ");
		call.append("   SO_PANTARIF PV_PLAN_BASICO_PG.refcursor; ");
		call.append("   SN_COD_RETORNO NUMBER; ");
		call.append("   SV_MENS_RETORNO VARCHAR2(200); ");
		call.append("   SN_NUM_EVENTO NUMBER; ");
		call.append(" BEGIN  ");
		call.append("   EO_PLANTARIF:=TA_PLANTARIF_QT('','','','','','','','',''); ");
		call.append("   EO_PLANTARIF.COD_PLANTARIF:=?; ");
		call.append("   EO_PLANTARIF.COD_PRODUCTO := 1; ");
		call.append("   SN_COD_RETORNO := NULL; ");
		call.append("   SV_MENS_RETORNO := NULL; ");
		call.append("   SN_NUM_EVENTO := NULL; ");
		call.append("   PV_PLAN_BASICO_PG.PV_CONSULTA_PLANTARIF_PR (EO_PLANTARIF,?,?,?,?); ");
		call.append(" END; ");
		return call.toString();	
	}
	
	
	/**
	 * Obtiene una lista de planes tarifarios
	 * 
	 * @param param
	 * @return PlanTarifarioListDTO
	 * @throws ProductOfferingException
	 */
	
	public PlanTarifarioListDTO obtenerPlanesTarifarios(
			BusquedaPlanTarifarioDTO param) throws ProductOfferingException {
		
		logger.debug("obtenerPlanesTarifarios():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		
		PlanTarifarioListDTO planes = null;
		PlanTarifarioDTO[] planesPrepago = null;
		PlanTarifarioDTO[] planesPospago = null;
		PlanTarifarioDTO[] planesHibrido = null;
		PlanTarifarioDTO[] planesPospagoRango = null;
		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerPlanesTarifarios();
		try {
		
			
			logger.debug("param.getCodCliente()[" + param.getCodCliente() + "]");
			logger.debug("param.getCodPlanTarif()[" + param.getCodPlanTarif() + "]");
			logger.debug("param.getTipPlanTarif()[" + param.getTipPlanTarif() + "]");
			logger.debug("param.getCodTipoPlan()[" + param.getCodTipoPlan() + "]");
			logger.debug("param.getCodTecnologia()[" + param.getCodTecnologia() + "]");
			logger.debug("param.getNumAbonado()[" + param.getNumAbonado() + "]");
			logger.debug("param.getUsuarioOracle()[" + param.getUsuarioOracle() + "]");
			logger.debug("param.getCambioPlanFamiliar()[" + param.getCambioPlanFamiliar() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
		
			cstmt.setLong(1, param.getCodCliente()); //COD_CLIENTE
			cstmt.setString(2, param.getCodPlanTarif()); //COD_PLANTARIF
			cstmt.setString(3, param.getTipPlanTarif()); //TIP_PLANTARIF
			cstmt.setString(4, param.getCodTipoPlan());	//COD_TIPLAN		
			cstmt.setString(5, param.getCodTecnologia()); //COD_TECNOLOGIA
			cstmt.setLong(6, param.getNumAbonado()); //NUM_ABONADO
			cstmt.setString(7, param.getUsuarioOracle()); //NOM_USUARORA
			cstmt.setString(8, param.getCambioPlanFamiliar()); //CAMBIO_PLANFAMILIAR
			cstmt.registerOutParameter(9, oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(10, oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(11, oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(12, oracle.jdbc.driver.OracleTypes.CURSOR);			
			cstmt.registerOutParameter(13, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(15, java.sql.Types.NUMERIC);	
			
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(13);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(14);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(15);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al obtener planes tarifarios");
				throw new ProductOfferingException(String.valueOf(codError),numEvento, msgError);
			}

			planes = new PlanTarifarioListDTO();
			ArrayList listaPrepago = new ArrayList();
			ArrayList listaPospago = new ArrayList();
			ArrayList listaHibrido = new ArrayList();
			ArrayList listaPospagoRango = new ArrayList();
			
			logger.debug("Recuperando cursor prepago...");
			ResultSet rs = null;
			try{
				rs = (ResultSet)cstmt.getObject(9);
				while (rs.next()) {
					PlanTarifarioDTO planPrepago = new PlanTarifarioDTO();
					planPrepago.setCodPlanTarif(rs.getString(1));
					logger.debug("codPlanTarif[" + planPrepago.getCodPlanTarif() + "]");
					planPrepago.setDesPlanTarif(rs.getString(2));
					logger.debug("desPlanTarif[" + planPrepago.getDesPlanTarif() + "]");
					planPrepago.setLimiteConsumo(rs.getString(3));
					logger.debug("codLimiteConsumo[" + planPrepago.getLimiteConsumo() + "]");
					planPrepago.setDescripcionLimiteConsumo(rs.getString(4));
					logger.debug("descripcionLimiteConsumo[" + planPrepago.getDescripcionLimiteConsumo() + "]");
					planPrepago.setCodCargoBasico(rs.getString(5));
					logger.debug("codCargoBasico[" + planPrepago.getCodCargoBasico() + "]");
					planPrepago.setDesCargoBasico(rs.getString(6));
					logger.debug("desCargoBasico[" + planPrepago.getDesCargoBasico() + "]");
					planPrepago.setImpCargoBasico(rs.getFloat(7));
					logger.debug("impCargoBasico[" + planPrepago.getImpCargoBasico() + "]");
					planPrepago.setImpFinal(rs.getFloat(8));
					logger.debug("impFinal[" + planPrepago.getImpFinal() + "]");
					
					planPrepago.setNumDias(rs.getInt(9));
					logger.debug("numDias[" + planPrepago.getNumDias() + "]");					
					planPrepago.setTipoPlanTarifario(rs.getString(10));
					logger.debug("tipoPlanTarifario[" + planPrepago.getTipoPlanTarifario() + "]");					
					planPrepago.setImpLimiteConsumo(rs.getFloat(11));
					logger.debug("impLimiteConsumo[" + planPrepago.getImpLimiteConsumo() + "]");					
					
					listaPrepago.add(planPrepago);
				}	
				rs.close();
			}catch(Exception e){
				logger.debug("error en cursor prepago...",e);
				
			}

			logger.debug("Recuperando cursor pospago...");
			ResultSet rspos = null;
			try{
				rspos = (ResultSet) cstmt.getObject(10);
				while (rspos.next()) {
					PlanTarifarioDTO planPospago = new PlanTarifarioDTO();

					planPospago.setCodPlanTarif(rspos.getString(1));
					logger.debug("codPlanTarif[" + planPospago.getCodPlanTarif() + "]");
					planPospago.setDesPlanTarif(rspos.getString(2));
					logger.debug("desPlanTarif[" + planPospago.getDesPlanTarif() + "]");
					planPospago.setLimiteConsumo(rspos.getString(3));
					logger.debug("codLimiteConsumo[" + planPospago.getLimiteConsumo() + "]");
					planPospago.setDescripcionLimiteConsumo(rspos.getString(4));
					logger.debug("descripcionLimiteConsumo[" + planPospago.getDescripcionLimiteConsumo() + "]");
					planPospago.setCodCargoBasico(rspos.getString(5));
					logger.debug("codCargoBasico[" + planPospago.getCodCargoBasico() + "]");
					planPospago.setDesCargoBasico(rspos.getString(6));
					logger.debug("desCargoBasico[" + planPospago.getDesCargoBasico() + "]");
					planPospago.setImpCargoBasico(rspos.getFloat(7));					
					logger.debug("impCargoBasico[" + planPospago.getImpCargoBasico() + "]");
					planPospago.setImpFinal(rspos.getFloat(8));
					logger.debug("impFinal[" + planPospago.getImpFinal() + "]");
					
					planPospago.setNumDias(rspos.getInt(9));
					logger.debug("numDias[" + planPospago.getNumDias() + "]");					
					planPospago.setTipoPlanTarifario(rspos.getString(10));
					logger.debug("tipoPlanTarifario[" + planPospago.getTipoPlanTarifario() + "]");					
					planPospago.setImpLimiteConsumo(rspos.getFloat(11));
					logger.debug("impLimiteConsumo[" + planPospago.getImpLimiteConsumo() + "]");	
					
					listaPospago.add(planPospago);
				}	
				rspos.close();
			}catch(Exception e){
				logger.debug("error en cursor pospago...",e);
			}
			
			logger.debug("Recuperando cursor hibrido...");
			ResultSet rshib = null;
			try{
				rshib = (ResultSet) cstmt.getObject(11);
				while (rshib.next()) {
					PlanTarifarioDTO planHibrido = new PlanTarifarioDTO();

					planHibrido.setCodPlanTarif(rshib.getString(1));
					logger.debug("codPlanTarif[" + planHibrido.getCodPlanTarif() + "]");
					planHibrido.setDesPlanTarif(rshib.getString(2));
					logger.debug("desPlanTarif[" + planHibrido.getDesPlanTarif() + "]");
					planHibrido.setLimiteConsumo(rshib.getString(3));
					logger.debug("codLimiteConsumo[" + planHibrido.getLimiteConsumo() + "]");
					planHibrido.setDescripcionLimiteConsumo(rshib.getString(4));
					logger.debug("descripcionLimiteConsumo[" + planHibrido.getDescripcionLimiteConsumo() + "]");
					planHibrido.setCodCargoBasico(rshib.getString(5));
					logger.debug("codCargoBasico[" + planHibrido.getCodCargoBasico() + "]");
					planHibrido.setDesCargoBasico(rshib.getString(6));
					logger.debug("desCargoBasico[" + planHibrido.getDesCargoBasico() + "]");
					planHibrido.setImpCargoBasico(rshib.getFloat(7));	
					logger.debug("impCargoBasico[" + planHibrido.getImpCargoBasico() + "]");
					planHibrido.setImpFinal(rshib.getFloat(8));
					logger.debug("impFinal[" + planHibrido.getImpFinal() + "]");

					planHibrido.setNumDias(rshib.getInt(9));
					logger.debug("numDias[" + planHibrido.getNumDias() + "]");					
					planHibrido.setTipoPlanTarifario(rshib.getString(10));
					logger.debug("tipoPlanTarifario[" + planHibrido.getTipoPlanTarifario() + "]");					
					planHibrido.setImpLimiteConsumo(rshib.getFloat(11));
					logger.debug("impLimiteConsumo[" + planHibrido.getImpLimiteConsumo() + "]");
					
					listaHibrido.add(planHibrido);
				}	
				rshib.close();
			}catch(Exception e){
				logger.debug("error en cursor hibrido...",e);
			}

			logger.debug("Recuperando cursor pospago rango...");
			ResultSet rsposrango = null;
			try{
				rsposrango = (ResultSet) cstmt.getObject(12);
				while (rsposrango.next()) {
					PlanTarifarioDTO planPospagoRango = new PlanTarifarioDTO();

					planPospagoRango.setCodPlanTarif(rsposrango.getString(1));
					logger.debug("codPlanTarif[" + planPospagoRango.getCodPlanTarif() + "]");
					planPospagoRango.setDesPlanTarif(rsposrango.getString(2));
					logger.debug("desPlanTarif[" + planPospagoRango.getDesPlanTarif() + "]");
					planPospagoRango.setLimiteConsumo(rsposrango.getString(3));
					logger.debug("codLimiteConsumo[" + planPospagoRango.getLimiteConsumo() + "]");
					planPospagoRango.setDescripcionLimiteConsumo(rsposrango.getString(4));
					logger.debug("descripcionLimiteConsumo[" + planPospagoRango.getDescripcionLimiteConsumo() + "]");
					planPospagoRango.setCodCargoBasico(rsposrango.getString(5));
					logger.debug("codCargoBasico[" + planPospagoRango.getCodCargoBasico() + "]");
					planPospagoRango.setDesCargoBasico(rsposrango.getString(6));
					logger.debug("desCargoBasico[" + planPospagoRango.getDesCargoBasico() + "]");
					planPospagoRango.setImpCargoBasico(rsposrango.getFloat(7));
					logger.debug("impCargoBasico[" + planPospagoRango.getImpCargoBasico() + "]");
					planPospagoRango.setImpFinal(rsposrango.getFloat(8));
					logger.debug("impFinal[" + planPospagoRango.getImpFinal() + "]");

					planPospagoRango.setNumDias(rsposrango.getInt(9));
					logger.debug("numDias[" + planPospagoRango.getNumDias() + "]");					
					planPospagoRango.setTipoPlanTarifario(rsposrango.getString(10));
					logger.debug("tipoPlanTarifario[" + planPospagoRango.getTipoPlanTarifario() + "]");					
					planPospagoRango.setImpLimiteConsumo(rsposrango.getFloat(11));
					logger.debug("impLimiteConsumo[" + planPospagoRango.getImpLimiteConsumo() + "]");
					
					listaPospagoRango.add(planPospagoRango);
				}
				rsposrango.close();
			}catch(Exception e){
				logger.debug("error en pospago rango...",e);
			}
			planesPrepago = (PlanTarifarioDTO[]) ArrayUtl.copiaArregloTipoEspecifico(listaPrepago.toArray(), PlanTarifarioDTO.class);
			planesPospago = (PlanTarifarioDTO[]) ArrayUtl.copiaArregloTipoEspecifico(listaPospago.toArray(), PlanTarifarioDTO.class);
			planesHibrido = (PlanTarifarioDTO[]) ArrayUtl.copiaArregloTipoEspecifico(listaHibrido.toArray(), PlanTarifarioDTO.class);			
			planesPospagoRango = (PlanTarifarioDTO[]) ArrayUtl.copiaArregloTipoEspecifico(listaPospagoRango.toArray(), PlanTarifarioDTO.class);
			
			planes.setPlanesPrepago(planesPrepago);			
			planes.setPlanesPospago(planesPospago);
			planes.setPlanesHibrido(planesHibrido);
			planes.setPlanesPospagoRango(planesPospagoRango);

		
		} catch (ProductOfferingException e) {
			logger.debug("ProductOfferingException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener planes tarifarios", e);
			throw new ProductOfferingException("Ocurrió un error general al obtener planes tarifarios",e);
		}
		finally {
			try {
				if (cstmt != null) {
					cstmt.close();
					cstmt = null;
				}
				if (conn != null) {
					if (!conn.isClosed()) {
						conn.close();
					}
					conn = null;
				}
			} catch (SQLException e) {
				cstmt = null;
				conn = null;
				logger.debug("SQLException[" + e + "]");
			}
		}
		logger.debug("obtenerPlanesTarifarios():end");
		return planes;
	}
	
	/**
	 * Paso historico de datos del plan tarifario
	 * 
	 * @param abonado
	 * @return RetornoDTO
	 * @throws ProductOfferingException
	 */
	public RetornoDTO registroHistoricoPlan(CicloFactDTO ciclo) throws ProductOfferingException{	
		logger.debug("registroHistoricoPlan():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLregistroHistoricoPlan();
		try {
		
			logger.debug("ciclo.getCodCiclo()[" + ciclo.getCodCiclo() + "]");
			logger.debug("ciclo.getNumAbonado()[" + ciclo.getNumAbonado() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			cstmt.setInt(1, ciclo.getCodCiclo());
			cstmt.setLong(2, ciclo.getNumAbonado());

			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);			
		
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(3);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(4);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(5);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error(" Ocurrió un error en el paso histórico de datos del plan");
				throw new ProductOfferingException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			retorno = new RetornoDTO();
			retorno.setCodigo("0");
			retorno.setDescripcion(msgError);
		
		} catch (ProductOfferingException e) {
			logger.debug("ProductOfferingException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general en el paso histórico de datos del plan", e);
			throw new ProductOfferingException("Ocurrió un error general en el paso histórico de datos del plan",e);
		}
		finally {
			try {
				if (cstmt != null) {
					cstmt.close();
					cstmt = null;
				}
				if (conn != null) {
					if (!conn.isClosed()) {
						conn.close();
					}
					conn = null;
				}
			} catch (SQLException e) {
				cstmt = null;
				conn = null;
				logger.debug("SQLException[" + e + "]");
			}
		}
		logger.debug("registroHistoricoPlan():end");
		return retorno;
	}	

	/**
	 * Obtiene los servicios por default
	 * 
	 * @param param
	 * @return ServiciosDefaultDTO
	 * @throws ProductOfferingException
	 */
	public ServiciosDTO obtenerServiciosDefaultPlan(BusquedaServiciosDefaultDTO param) throws ProductOfferingException{
		logger.debug("obtenerServiciosDefaultPlan():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ServiciosDTO servicios = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerServiciosDefaultPlan();
		try {
		
			logger.debug("param.getNumAbonado()[" + param.getNumAbonado() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, param.getNumAbonado());
			//ini------------------CONTINUAR CARGA DE PARAMETROS-------------------
			
			//cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			//cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			//cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);			
		
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			//codError = cstmt.getInt(2);
			logger.debug("codError[" + codError + "]");
			//msgError = cstmt.getString(3);
			logger.debug("msgError[" + msgError + "]");
			//numEvento = cstmt.getInt(4);
			logger.debug("numEvento[" + numEvento + "]");
			//fin----------------------------------------------------------------------
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al obtener servicios por default");
				throw new ProductOfferingException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			//ini-----------OBTENER CURSORES DE SERVICIOS A ACTIVAR Y DESACTIVAR-------
			servicios = new ServiciosDTO();
			//fin-------------------------------------------------------------------
		
		} catch (ProductOfferingException e) {
			logger.debug("ProductOfferingException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener servicios por default", e);
			throw new ProductOfferingException("Ocurrió un error general al obtener servicios por default",e);
		}
		finally {
			try {
				if (cstmt != null) {
					cstmt.close();
					cstmt = null;
				}
				if (conn != null) {
					if (!conn.isClosed()) {
						conn.close();
					}
					conn = null;
				}
			} catch (SQLException e) {
				cstmt = null;
				conn = null;
				logger.debug("SQLException[" + e + "]");
			}
		}
		logger.debug("obtenerServiciosDefaultPlan():end");
		return servicios;
	}
	
	/**
	 * Anula bolsa dinamica
	 * 
	 * @param bolsa
	 * @return ServiciosDefaultDTO
	 * @throws ProductOfferingException
	 */
	public RetornoDTO anularCargoBolsaDinamica(BolsaDinamicaDTO bolsa) throws ProductOfferingException{
		logger.debug("anularCargoBolsaDinamica():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLanularCargoBolsaDinamica();
		try {
		
			logger.debug("bolsa.getCodCliente()[" + bolsa.getCodCliente() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, bolsa.getIdSecuencia());
			cstmt.setLong(2, bolsa.getCodCliente());
			cstmt.setInt(3, bolsa.getCodCiclo());
			cstmt.setString(4, bolsa.getCodPlanTarif());
			
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);			
		
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(5);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(6);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(7);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al anular bolsa dinámica");
				throw new ProductOfferingException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			retorno = new RetornoDTO();
			retorno.setDescripcion(msgError);
		
		} catch (ProductOfferingException e) {
			logger.debug("ProductOfferingException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al anular bolsa dinámica", e);
			throw new ProductOfferingException("Ocurrió un error general al anular bolsa dinámica",e);
		}
		finally {
			try {
				if (cstmt != null) {
					cstmt.close();
					cstmt = null;
				}
				if (conn != null) {
					if (!conn.isClosed()) {
						conn.close();
					}
					conn = null;
				}
			} catch (SQLException e) {
				cstmt = null;
				conn = null;
				logger.debug("SQLException[" + e + "]");
			}
		}
		logger.debug("anularCargoBolsaDinamica():end");
		return retorno;
	}

	/**
	 * Valida si posee plan freedom
	 * 
	 * @param cliente
	 * @return RetornoDTO
	 * @throws ProductOfferingException
	 */
	public RetornoDTO validaFreedom(ClienteDTO cliente) throws ProductOfferingException{
		logger.debug("validaFreedom():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLvalidaFreedom();
		try {
		
			logger.debug("cliente.getCodCliente()[" + cliente.getCodCliente() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, cliente.getCodCliente());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);			
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(2);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(3);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(4);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al validar plan freedom");
				throw new ProductOfferingException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			String planFreedom = cstmt.getString(5);
			logger.debug("planFreedom[" + planFreedom + "]");
				
			retorno = new RetornoDTO();
			retorno.setDescripcion(msgError);
			retorno.setResultado(planFreedom.equalsIgnoreCase("TRUE")?true:false);
		
		} catch (ProductOfferingException e) {
			logger.debug("ProductOfferingException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al validar plan freedom", e);
			throw new ProductOfferingException("Ocurrió un error general al validar plan freedom",e);
		}
		finally {
			try {
				if (cstmt != null) {
					cstmt.close();
					cstmt = null;
				}
				if (conn != null) {
					if (!conn.isClosed()) {
						conn.close();
					}
					conn = null;
				}
			} catch (SQLException e) {
				cstmt = null;
				conn = null;
				logger.debug("SQLException[" + e + "]");
			}
		}
		logger.debug("validaFreedom():end");
		return retorno;
	}
	
	
	/**
	 * Obtiene lista de productos por defecto para el plan del abonado
	 * 
	 * @param AbonadoDTO
	 * @return ProductoOfertadoListDTO
	 * @throws ProductOfferingException
	 */
	public ProductoOfertadoListDTO obtenerProductosPorDefectoPlan(AbonadoDTO abonado) throws ProductOfferingException{
		logger.debug("obtenerProductosPorDefectoPlan():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ProductoOfertadoListDTO listaProducto = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerProductosPorDefectoPlan();
		try {
		
			logger.debug("param.getNumAbonado()[" + abonado.getNumAbonado() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, abonado.getNumAbonado());
			//ini------------------CONTINUAR CARGA DE PARAMETROS-------------------
			
			//cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			//cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			//cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);			
		
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			//codError = cstmt.getInt(2);
			logger.debug("codError[" + codError + "]");
			//msgError = cstmt.getString(3);
			logger.debug("msgError[" + msgError + "]");
			//numEvento = cstmt.getInt(4);
			logger.debug("numEvento[" + numEvento + "]");
			//fin----------------------------------------------------------------------
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al obtener obtener Productos Por Defecto Plan");
				throw new ProductOfferingException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			//ini-----------OBTENER CURSORES DE SERVICIOS A ACTIVAR Y DESACTIVAR-------
			listaProducto = new ProductoOfertadoListDTO();
			//fin-------------------------------------------------------------------
		
		} catch (ProductOfferingException e) {
			logger.debug("ProductOfferingException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener obtener Productos Por Defecto Plan", e);
			throw new ProductOfferingException("Ocurrió un error general al obtener obtener Productos Por Defecto Plan",e);
		}
		finally {
			try {
				if (cstmt != null) {
					cstmt.close();
					cstmt = null;
				}
				if (conn != null) {
					if (!conn.isClosed()) {
						conn.close();
					}
					conn = null;
				}
			} catch (SQLException e) {
				cstmt = null;
				conn = null;
				logger.debug("SQLException[" + e + "]");
			}
		}
		logger.debug("obtenerProductosPorDefectoPlan():end");
		return listaProducto;
	}

	/**
	 * Obtiene ciclo de plan freedom
	 * 
	 * @param  plan
	 * @return PlanCicloDTO
	 * @throws ProductOfferingException
	 */
	public PlanCicloDTO obtenerCicloFreedom(PlanCicloDTO plan) throws ProductOfferingException{
		logger.debug("obtenerCicloFreedom():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		PlanCicloDTO retorno = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerCicloFreedom();
		try {
		
			logger.debug("plan.getCodPlanTarif()[" + plan.getCodPlanTarif() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			cstmt.setString(1, plan.getCodPlanTarif() );//COD_PLANTARIF
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);			
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(2);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(3);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(4);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al obtener ciclo de plan freedom");
				throw new ProductOfferingException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			int ciclo = cstmt.getInt(5);
			logger.debug("ciclo[" + ciclo + "]");
			
			retorno = plan;
			retorno.setCodCiclo(ciclo);
		
		} catch (ProductOfferingException e) {
			logger.debug("ProductOfferingException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener ciclo de plan freedom", e);
			throw new ProductOfferingException("Ocurrió un error general al obtener ciclo de plan freedom",e);
		}
		finally {
			try {
				if (cstmt != null) {
					cstmt.close();
					cstmt = null;
				}
				if (conn != null) {
					if (!conn.isClosed()) {
						conn.close();
					}
					conn = null;
				}
			} catch (SQLException e) {
				cstmt = null;
				conn = null;
				logger.debug("SQLException[" + e + "]");
			}
		}
		logger.debug("obtenerCicloFreedom():end");
		return retorno;
	
	}
	
	/**
	 * Obtiene la categoria del plan
	 * 
	 * @param  plan
	 * @return PlanTarifarioDTO
	 * @throws ProductOfferingException
	 */	
	public PlanTarifarioDTO obtenerCategPlan(PlanTarifarioDTO plan) throws ProductOfferingException{
		logger.debug("obtenerCategPlan():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		PlanTarifarioDTO retorno = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerCategPlan();
		try {
		
			logger.debug("plan.getCodPlanTarif()[" + plan.getCodPlanTarif() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			cstmt.setString(1, plan.getCodPlanTarif() );//COD_PLANTARIF
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);			
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR); //COD_PLANTARIF
			
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(2);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(3);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(4);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al obtener categoria del plan");
				throw new ProductOfferingException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			String codCateg = cstmt.getString(5);
			logger.debug("codCateg[" + codCateg + "]");
			
			retorno = plan;
			retorno.setCodigoCategoria(codCateg);
		
		} catch (ProductOfferingException e) {
			logger.debug("ProductOfferingException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener categoria del plan", e);
			throw new ProductOfferingException("Ocurrió un error general al obtener categoria del plan",e);
		}
		finally {
			try {
				if (cstmt != null) {
					cstmt.close();
					cstmt = null;
				}
				if (conn != null) {
					if (!conn.isClosed()) {
						conn.close();
					}
					conn = null;
				}
			} catch (SQLException e) {
				cstmt = null;
				conn = null;
				logger.debug("SQLException[" + e + "]");
			}
		}
		logger.debug("obtenerCategPlan():end");
		return retorno;		
	}
	
	/**
	 * Obtiene plan comercial del cliente
	 * 
	 * @param  cliente
	 * @return ClienteDTO
	 * @throws ProductOfferingException
	 */	
	public ClienteDTO obtenerPlanComercial(ClienteDTO cliente) throws ProductOfferingException{
		logger.debug("obtenerPlanComercial():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ClienteDTO retorno = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerPlanComercial();
		try {
		
			logger.debug("cliente.getCodCliente()[" + cliente.getCodCliente() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, cliente.getCodCliente() );//COD_CLIENTE
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);			
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC); //COD_PLANCOM
			
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(2);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(3);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(4);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al obtener plan comercial cliente");
				throw new ProductOfferingException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			int codPlanCom = cstmt.getInt(5);
			logger.debug("codPlanCom[" + codPlanCom + "]");
			
			retorno = cliente;
			retorno.setCodPlanCom(codPlanCom);
		
		} catch (ProductOfferingException e) {
			logger.debug("ProductOfferingException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener plan comercial cliente", e);
			throw new ProductOfferingException("Ocurrió un error general al obtener plan comercial cliente",e);
		}
		finally {
			try {
				if (cstmt != null) {
					cstmt.close();
					cstmt = null;
				}
				if (conn != null) {
					if (!conn.isClosed()) {
						conn.close();
					}
					conn = null;
				}
			} catch (SQLException e) {
				cstmt = null;
				conn = null;
				logger.debug("SQLException[" + e + "]");
			}
		}
		logger.debug("obtenerPlanComercial():end");
		return retorno;				
	}
	
	public PlanTarifarioDTO obtenerDetallePlanTarif(PlanTarifarioDTO planTarif) throws ProductOfferingException	
	{		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = this.getSQLobtenerDetallePlanTarif();
		try {
		
			logger.debug("planTarif.getCodPlanTarif()[" + planTarif.getCodPlanTarif() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			cstmt.setString(1, planTarif.getCodPlanTarif() );
			
			cstmt.registerOutParameter(2, oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);			
						
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(3);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(4);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(5);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al obtener el detalle del plan tarifario");
				throw new ProductOfferingException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");			
			ResultSet rs=(ResultSet)cstmt.getObject(2);
			
			if(rs.next())
			{				
				PaqueteDTO paquete=new PaqueteDTO(); 
				planTarif.setCodCargoBasico(rs.getString("cod_cargobasico")!=null?rs.getString("cod_cargobasico"):"");
				planTarif.setCodigoLimiteConsumo(rs.getString("cod_limconsumo")!=null?rs.getString("cod_limconsumo"):"");
				planTarif.setCodigoPlanTarifario(rs.getString("cod_plantarif")!=null?rs.getString("cod_plantarif"):"");
				planTarif.setCodigoProducto(rs.getString("cod_producto")!=null?rs.getString("cod_producto"):"");
				planTarif.setCodigoTipoPlan(rs.getString("cod_tiplan")!=null?rs.getString("cod_tiplan"):"");
				planTarif.setCodPlanTarif(rs.getString("cod_plantarif")!=null?rs.getString("cod_plantarif"):"");
				planTarif.setDesPlanTarif(rs.getString("des_plantarif")!=null?rs.getString("des_plantarif"):"");
				planTarif.setFechaDesde(rs.getString("fec_desde")!=null?rs.getString("fec_desde"):"");
				planTarif.setFechaHasta(rs.getString("fec_hasta")!=null?rs.getString("fec_hasta"):"");
				planTarif.setIndicadorCargoHabilitacion(rs.getString("ind_cargo_habil")!=null?rs.getString("ind_cargo_habil"):"");
				planTarif.setNumDias(rs.getString("num_dias")!=null?Integer.parseInt(rs.getString("num_dias")):0);
				planTarif.setTipoPlanTarifario(rs.getString("tip_plantarif")!=null?rs.getString("tip_plantarif"):"");				
				paquete.setCodProdPadre(rs.getString("cod_prod_padre")!=null?rs.getString("cod_prod_padre"):"");
				paquete.setIdPaquete(rs.getString("cod_prod_padre")!=null?rs.getString("cod_prod_padre"):"");
				planTarif.setPaqueteDefault(paquete);				
			}	
		
		} catch (ProductOfferingException e) {
			logger.debug("ProductOfferingException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener plan comercial cliente", e);
			throw new ProductOfferingException("Ocurrió un error general al obtener plan comercial cliente",e);
		}
		finally {
			try {
				if (cstmt != null) {
					cstmt.close();
					cstmt = null;
				}
				if (conn != null) {
					if (!conn.isClosed()) {
						conn.close();
					}
					conn = null;
				}
			} catch (SQLException e) {
				cstmt = null;
				conn = null;
				logger.debug("SQLException[" + e + "]");
			}
		}
		logger.debug("obtenerDetallePlanTarifario():end");			
		
		return planTarif;
	}
}


