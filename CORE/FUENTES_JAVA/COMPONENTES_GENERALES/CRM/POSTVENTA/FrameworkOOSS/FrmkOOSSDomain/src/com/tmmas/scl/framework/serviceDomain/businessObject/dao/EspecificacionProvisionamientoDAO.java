/**
 * Copyright © 2006 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 11-07-2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.serviceDomain.businessObject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.PlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.framework.serviceDomain.businessObject.dao.interfaces.EspecificacionProvisionamientoDAOIT;
import com.tmmas.scl.framework.serviceDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.AprovisionamientoDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.BajaAtlantidaDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.BodegaDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.BodegaListDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.ConsultaBodegaDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.ConsultaPlanTarifDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.ConsultaPrepagosDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.EspecProvisionamientoListDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.EspecServicioClienteListDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.GestorCorpDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.LimiteConsumoDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.ListaActivaDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.ListaActivaListDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.MovAtlantidaDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.SaldoDTO;
import com.tmmas.scl.framework.serviceDomain.exception.ServiceSpecEntitiesException;

public class EspecificacionProvisionamientoDAO extends ConnectionDAO implements EspecificacionProvisionamientoDAOIT
{
	private final Logger logger = Logger.getLogger(EspecificacionProvisionamientoDAO.class);
	private final Global global = Global.getInstance();
	

	
	private String getSQLobtenerEspecificacionesProvisionamiento()
	{	
		StringBuffer call = new StringBuffer();
		//AGREGAR INVOCACION A PL
		return call.toString();		
	}

	private String getSQLconsultaPrepago()
	{	
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   so_param PV_CONS_PREPAGOS_QT := PV_INICIA_ESTRUCTURAS_PG.PV_CONS_PREPAGOS_QT_FN;");
		call.append(" BEGIN ");
		call.append("   so_param.NUM_ABONADO := ?;");
		call.append("   so_param.COD_TECNOLOGIA := ?;");
		call.append("   so_param.COD_PLANTARIF_ACTUAL := ?;");
		call.append("   so_param.COD_PLANSERV := ?;");
		call.append("   so_param.COD_ACTABO := ?;");
		call.append("   so_param.VN_SALDO := ?;");
		call.append("   PV_ESPEC_PROVISIONAMIENTO_PG.PV_CONSULTA_PREPAGOS_PR( so_param, ?, ?, ?);");
		call.append(" END;");	
		return call.toString();		
	}
	
	private String getSQLactualizarLimiteConsumo() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   eo_limite_consumo PV_LIMITE_CONSUMO_QT := PV_INICIA_ESTRUCTURAS_PG.PV_LIMITE_CONSUMO_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_limite_consumo.SUJETO := ?;");
		call.append("   eo_limite_consumo.TIP_SUJETO := ?;");
		call.append("   eo_limite_consumo.FEC_DES := ?;");
		call.append("   eo_limite_consumo.FEC_HAS := ?;");
		call.append("   eo_limite_consumo.COD_ACTABO := ?;");
		call.append("   eo_limite_consumo.COD_PLANTARIF_NUEVO := ?;");
		call.append("   eo_limite_consumo.TIPO_MOVIMIENTO := ?;");
		call.append("   eo_limite_consumo.COD_PRODUCTO := ?;");
		call.append("   PV_ESPEC_PROVISIONAMIENTO_PG.PV_ACTUALIZA_LIMITE_CONSUMO_PR( eo_limite_consumo, ?, ?, ?);");
		call.append(" END;");
		
		return call.toString();		
	}
	
	private String getSQLaprovisionamiento() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   eo_provisionar GA_APROVISIONAR_QT := PV_INICIA_ESTRUCTURAS_PG.GA_APROVISIONAR_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_provisionar.NUM_ABONADO := ?;");
		call.append("   eo_provisionar.COD_ACTABO := ?;");
		call.append("   eo_provisionar.TIP_TECNOLOGIA := ?;");
		call.append("   eo_provisionar.NOM_USUARORA := ?;");
		call.append("   eo_provisionar.TIP_TERMINAL := ?;");
		call.append("   eo_provisionar.COD_CENTRAL := ?;");
		call.append("   eo_provisionar.NUM_CELULAR := ?;");
		call.append("   eo_provisionar.NUM_SERIE := ?;");
		call.append("   eo_provisionar.IMEI := ?;");
		call.append("   eo_provisionar.VAL_OOSS := ?;");
		call.append("   eo_provisionar.COD_PLANTARIF_NUEVO := ?;");
		call.append("   eo_provisionar.NUN_OOSS := ?;");
		call.append("   eo_provisionar.COD_OOSS := ?;");
		call.append("   eo_provisionar.SEQ_NUMMOV := ?;");
		call.append("   eo_provisionar.COD_TIPLAN := ?;");
		call.append("   eo_provisionar.COD_SERVICIOS := ?;");
		call.append("   PV_ESPEC_PROVISIONAMIENTO_PG.PV_APROVISIONAR_CENTRAL_PR( eo_provisionar, ?, ?, ?);");
		call.append(" END;");
		return call.toString();		
	}	

	private String getSQLobtieneAtlantida() {
		StringBuffer call = new StringBuffer();
		//AGREGAR LLAMADA A PL		
		return call.toString();		
	}

	private String getSQLregistraProrrateo() {
		StringBuffer call = new StringBuffer();
		//AGREGAR LLAMADA A PL		
		return call.toString();		
	}
	
	private String getSQLvalidaBajaAtlantida() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   eo_baja PV_VAL_BAJA_ATLANTIDA_QT := PV_INICIA_ESTRUCTURAS_PG.PV_VAL_BAJA_ATLANTIDA_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_baja.NUM_MOVIMIENTO := ?;");  //1
		call.append("   eo_baja.NUM_ABONADO := ?;");     //2
		call.append("   eo_baja.COD_ESTADO := ?;");      //3
		call.append("   eo_baja.COD_ACTABO := ?;");      //4
		call.append("   eo_baja.COD_MODULO := ?;");      //5
		call.append("   eo_baja.NUM_INTENTOS := ?;");    //6
		call.append("   eo_baja.COD_CENTRAL_NUE := ?;"); //7
		call.append("   eo_baja.DES_RESPUESTA := ?;");   //8
		call.append("   eo_baja.COD_ACTUACION := ?;");   //9
		call.append("   eo_baja.NOM_USUARORA := ?;");    //10
		call.append("   eo_baja.FEC_INGRESO := ?;");     //11
		call.append("   eo_baja.TIP_TERMINAL := ?;");    //12
		call.append("   eo_baja.COD_CENTRAL := ?;");     //13
		call.append("   eo_baja.FEC_LECTURA := ?;");     //14
		call.append("   eo_baja.IND_BLOQUEO := ?;");     //15
		call.append("   eo_baja.FEC_EJECUCION := ?;");   //16
		call.append("   eo_baja.TIP_TERMINAL_NUE := ?;");//17
		call.append("   eo_baja.NUM_MOVANT := ?;");      //18 
		call.append("   eo_baja.NUM_CELULAR := ?;");     //19
		call.append("   eo_baja.NUM_MOVPOS := ?;");      //20
		call.append("   eo_baja.NUM_SERIE := ?;");       //21
		call.append("   eo_baja.NUM_PERSONAL := ?;");    //22
		call.append("   eo_baja.NUM_CELULAR_NUE := ?;"); //23
		call.append("   eo_baja.NUM_SERIE_NUE := ?;"); //24
		call.append("   eo_baja.NUM_PERSONAL_NUE := ?;"); //25
		call.append("   eo_baja.NUM_MSNB := ?;");        //26
		call.append("   eo_baja.NUM_MSNB_NUE := ?;");    //27
		call.append("   eo_baja.COD_SUSPREHA := ?;");    //28
		call.append("   eo_baja.COD_SERVICIOS := ?;");   //29
		call.append("   eo_baja.NUM_MIN := ?;");         //30
		call.append("   eo_baja.NUM_MIN_NUE := ?;");     //31
		call.append("   eo_baja.STA := ?;");             //32
		call.append("   eo_baja.COD_MENSAJE := ?;");     //33
		call.append("   eo_baja.PARAM1_MENS := ?;");     //34
		call.append("   eo_baja.PARAM2_MENS := ?;");     //35
		call.append("   eo_baja.PARAM3_MENS := ?;");     //36
		call.append("   eo_baja.COD_PLAN_ACTUAL := ?;"); //37
		call.append("   eo_baja.CARGA := ?;");           //38
		call.append("   eo_baja.VALOR_PLAN := ?;");      //39
		call.append("   eo_baja.PIN := ?;");             //40
		call.append("   eo_baja.FEC_EXPIRA := ?;");      //41
		call.append("   eo_baja.DES_MENSAJE := ?;");     //42
		call.append("   eo_baja.COD_PIN := ?;");         //43
		call.append("   eo_baja.COD_IDIOMA := ?;");      //44
		call.append("   eo_baja.COD_ENRUTAMIENTO := ?;");//45
		call.append("   eo_baja.TIP_ENRUTAMIENTO := ?;");//46
		call.append("   eo_baja.DES_ORIGEN_PIN := ?;");  //47
		call.append("   eo_baja.NUM_LOTE_PIN := ?;");    //48
		call.append("   eo_baja.NUM_SERIE_PIN := ?;");   //49
		call.append("   eo_baja.TIP_TECNOLOGIA := ?;");  //50
		call.append("   eo_baja.IMSI := ?;");            //51
		call.append("   eo_baja.IMSI_NUE := ?;");        //52
		call.append("   eo_baja.IMEI := ?;");            //53
		call.append("   eo_baja.IMEI_NUE := ?;");        //54
		call.append("   eo_baja.ICC := ?;");             //55
		call.append("   eo_baja.ICC_NUE := ?;");         //56
		call.append("   PV_ESPEC_PROVISIONAMIENTO_PG.PV_VALIDA_BAJA_ATLANTIDA_PR( eo_baja, ?, ?, ?);");
		call.append(" END;");	
		return call.toString();		
	}
	
	private String getSQLvalidaGestorCorp() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   eo_gestor PV_GESTOR_BCORP_QT := PV_INICIA_ESTRUCTURAS_PG.PV_GESTOR_BCORP_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_gestor.N_NUM_ABONADO := ?;");
		call.append("   eo_gestor.V_COD_ACTABO_GESTOR := ?;");
		call.append("   eo_gestor.V_NOM_USUARORA := ?;");
		call.append("   eo_gestor.V_COD_PLANTARIF_ACTUA := ?;");
		call.append("   eo_gestor.V_COD_PLANTARIF_NUEVO := ?;");
		call.append("   eo_gestor.V_TIP_MOVIMIENTO := ?;");
		call.append("   eo_gestor.V_COD_ACTABO_OOSS := ?;");
		call.append("   eo_gestor.V_ABONADO_GESTOR := ?;");
		call.append("   eo_gestor.V_ABONADO_GESTOR_DEF := ?;");
		call.append("   eo_gestor.N_SEQ_TRANS_ACABO := ?;");
		call.append("   PV_ESPEC_PROVISIONAMIENTO_PG.PV_VALIDA_GESTOR_CORP_PR( eo_gestor, ?, ?, ?, ?, ?, ?);");
		call.append(" END;");
		return call.toString();		
	}
	
	private String getSQLconsultaSaldo() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   so_consulta PV_CONSALDO_ABONADO_QT:= PV_INICIA_ESTRUCTURAS_PG.PV_CONSALDO_ABONADO_QT_FN;");
		call.append(" BEGIN ");
		call.append("   so_consulta.NUM_CELULAR := ?;");
		call.append("   so_consulta.COD_TECNOLOGIA := ?;");
		call.append("   PV_ESPEC_PROVISIONAMIENTO_PG.PV_CONSULTA_SALDO_PR( so_consulta, ?, ?, ?);");
		call.append("   				?:= so_consulta.SN_SALDO;");
		call.append(" END;");
		return call.toString();		
	}
	
	private String getSQLconsultaPlanActual() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   eo_aprovisionar GA_APROVISIONAR_QT := PV_INICIA_ESTRUCTURAS_PG.GA_APROVISIONAR_QT_FN;");
		call.append("   so_abonado GA_ABONADO_QT := PV_INICIA_ESTRUCTURAS_PG.PV_INICIA_GA_ABONADO_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_aprovisionar.COD_PLANTARIF_NUEVO := ?;");
		call.append("   eo_aprovisionar.COD_PLANTARIF := ?;");
		call.append("   eo_aprovisionar.TIP_TECNOLOGIA	 := ?;");
		call.append("   PV_ESPEC_PROVISIONAMIENTO_PG.PV_OBTENER_PLANACTUAL_PR( eo_aprovisionar, so_abonado, ?, ?, ?);");
		call.append("   				?:= so_abonado.COD_PLANTARIF;");
		call.append("   				?:= so_abonado.DES_PLANTARIF;");
		call.append(" END;");
		return call.toString();		
	}
	
	private String getSQLconsultaListaActivas() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   so_consulta PV_CONSALDO_ABONADO_QT := PV_INICIA_ESTRUCTURAS_PG.PV_CONSALDO_ABONADO_QT_FN;");
		call.append(" BEGIN ");
		call.append("   so_consulta.NUM_CELULAR := ?;");
		call.append("   so_consulta.COD_TECNOLOGIA := ?;");
		call.append("   PV_ESPEC_PROVISIONAMIENTO_PG.PV_CONSULTA_LISTAACTIVAS_PR( so_consulta,?, ?, ?, ?);");
		call.append(" END;");
		return call.toString();		
	}
	
	
	private String getSQLobtenerPlanAtlantida(){
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   eo_abonado GA_ABONADO_QT := PV_INICIA_ESTRUCTURAS_PG.PV_INICIA_GA_ABONADO_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_abonado.COD_PLANTARIF := ?;");
		call.append("   ? := PV_ESPEC_PROVISIONAMIENTO_PG.PV_OBTENER_PLANATLANTIDA_FN( eo_abonado, ?, ?, ?);");
		call.append(" END;");
		return call.toString();	
	}
	
	private String getSQLinsertaMovAtl(){
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   eo_mov GA_ABONADO_QT := PV_INICIA_ESTRUCTURAS_PG.PV_INICIA_GA_ABONADO_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_mov.NUM_ABONADO := ?;");
		call.append("   eo_mov.COD_PLANTARIF := ?;");
		call.append("   eo_mov.COD_CLIENTE := ?;");
		call.append("   eo_mov.TIPOPARAM := ?;");
		call.append("   PV_ESPEC_PROVISIONAMIENTO_PG.PV_INSERTA_MOVATL_PR( eo_mov, ?, ?, ?);");
		call.append(" END;");
		return call.toString();	
	}
	
	private String getSQLobtenerServContrato(){
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   so_abonado GA_ABONADO_QT := PV_INICIA_ESTRUCTURAS_PG.PV_INICIA_GA_ABONADO_QT_FN;");
		call.append(" BEGIN ");
		call.append("   so_abonado.COD_ACTABO := ?;");
		call.append("   so_abonado.COD_TECNOLOGIA := ?;");
		call.append("   so_abonado.TIP_TERMINAL := ?;");
		call.append("   so_abonado.COD_CENTRAL := ?;");
		call.append("   so_abonado.COD_PLANTARIF := ?;");
		call.append("   so_abonado.NUM_ABONADO := ?;");
		call.append("   PV_ESPEC_PROVISIONAMIENTO_PG.PV_OBTENER_SERV_CONTRATO_PR( so_abonado, ?, ?, ?);");
		call.append("   	? := so_abonado.CLASE_SERVICIO;");
		call.append(" END;");
		return call.toString();	
	}
	
	private String getSQLregistrarServContrato(){
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   eo_abonado PV_GA_ABOCEL_QT:= PV_INICIA_ESTRUCTURAS_PG.PV_GA_ABOCEL_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_abonado.CLASE_SERVICIO := ?;");
		call.append("   eo_abonado.NUM_ABONADO := ?;");
		call.append("   eo_abonado.NOM_USUARORA := ?;");
		call.append("   eo_abonado.NUM_CELULAR := ?;");
		call.append("   PV_ESPEC_PROVISIONAMIENTO_PG.PV_REGISTRAR_SERV_CONTRATO_PR( eo_abonado, ?, ?, ?);");
		call.append(" END;");
		return call.toString();	
	}
	
	private String getSQLobtenerListaBodegas() {
		StringBuffer call = new StringBuffer();

		call.append(" DECLARE ");
		call.append("   eo_venta GA_VENTA_QT := PV_INICIA_ESTRUCTURAS_PG.GA_VENTA_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_venta.COD_VENDEDOR := ?;");
		call.append("   PV_ESPEC_PROVISIONAMIENTO_PG.PV_OBTIENE_BODEGAS_PR( eo_venta, ?, ?, ?, ?);");
		call.append(" END;");
		return call.toString();		
	}	
	
	
	public EspecProvisionamientoListDTO obtenerEspecificacionesProvisionamiento(EspecServicioClienteListDTO espSerCliList) throws ServiceSpecEntitiesException 
	{
		logger.debug("obtenerEspecificacionesProvisionamiento():start");		
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		EspecProvisionamientoListDTO retorno = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerEspecificacionesProvisionamiento();		
		
		try {
			
			logger.debug("espSerCliList.getEspServCliList().toString()[" + espSerCliList.getEspServCliList().toString() + "]");
			
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSourceSCL());			
			cstmt = conn.prepareCall(call);
			
			// SE LLENAN PARAMETROS SEGUN PL
			//cstmt.setArray(1, listaNumeros.getNumerosDTO());
			//ini------------------CONTINUAR CARGA DE PARAMETROS-------------------
			
			//cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			//cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			//cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);			
		
			logger.debug("execute:antes");
			
			//cstmt.execute();	
			
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
				logger.error(" Ocurrió un error al ");
				throw new ServiceSpecEntitiesException(String.valueOf(codError),numEvento, msgError);
			}
			
			//obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");
			//ini--------------RESCATAR RETORNO-------
			retorno = new EspecProvisionamientoListDTO();
			
			logger.debug("EspecificacionProvisionamientoDAO DAO [OK]");
			
			//fin----------------------------------------------------------------------
		
		} catch (ServiceSpecEntitiesException e) {
			logger.debug("ServiceSpecEntitiesException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener Especificacion Plan Tasacion", e);
			throw new ServiceSpecEntitiesException("Ocurrió un error general al obtener Especificacion Plan Tasacion",e);
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
		logger.debug("obtenerEspecificacionesProvisionamiento():end");
		return retorno;					
	}
	
	/**
	 * Este metodo esta asociado a la consulta de saldo, 
	 * plantarifario actual  numeros frecuentes a la dll ICC_CONSULTA
	 * @param consulta
	 * @return RetornoDTO
	 * @throws ServiceSpecEntitiesException
	 */	
	public RetornoDTO consultaPrepago(ConsultaPrepagosDTO consulta) throws ServiceSpecEntitiesException{
		logger.debug("consultaPrepago():start");		
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLconsultaPrepago();		
		
		try {
			
			logger.debug("consulta.getNumAbonado()[" + consulta.getNumAbonado() + "]");
			logger.debug("consulta.getCodTecnologia()[" + consulta.getCodTecnologia() + "]");
			logger.debug("consulta.getCodPlanTarifActual()[" + consulta.getCodPlanTarifActual() + "]");
			logger.debug("consulta.getCodPlanServ()[" + consulta.getCodPlanServ() + "]");
			logger.debug("consulta.getCodActAbo()[" + consulta.getCodActAbo() + "]");
			logger.debug("consulta.getVnSaldo()[" + consulta.getVnSaldo() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSourceSCL());			
			cstmt = conn.prepareCall(call);
			
			cstmt.setLong(1, consulta.getNumAbonado());
			cstmt.setString(2, consulta.getCodTecnologia());
			cstmt.setString(3, consulta.getCodPlanTarifActual());
			cstmt.setString(4, consulta.getCodPlanServ());
			cstmt.setString(5, consulta.getCodActAbo());
			cstmt.setFloat(6, consulta.getVnSaldo());
			
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);			
		
			logger.debug("execute:antes");
			cstmt.execute();	
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(7);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(8);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(9);
			logger.debug("numEvento[" + numEvento + "]");

			if (codError != 0 & codError != 9998 ) {
				logger.error(" Ocurrió un error al ");
				throw new ServiceSpecEntitiesException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			retorno = new RetornoDTO();
			retorno.setCodigo(String.valueOf(codError));
			retorno.setDescripcion(msgError);
		
		} catch (ServiceSpecEntitiesException e) {
			logger.debug("ServiceSpecEntitiesException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al consultas prepagos", e);
			throw new ServiceSpecEntitiesException("Ocurrió un error general al consultar prepagos",e);
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
		logger.debug("consultaPrepago():end");
		return retorno;				
	}
	
	/**
	 * Actualiza límite de consumo
	 * 
	 * @param param
	 * @return RetornoDTO
	 * @throws ServiceSpecEntitiesException
	 */		
	public RetornoDTO actualizarLimiteConsumo(LimiteConsumoDTO param)
			throws ServiceSpecEntitiesException {
		logger.debug("actualizarLimiteConsumo():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLactualizarLimiteConsumo();
		try {
		
			logger.debug("param.getSujeto()[" + param.getSujeto() + "]");
			logger.debug("param.getTipSujeto()[" + param.getTipSujeto() + "]");
			logger.debug("param.getFechaDesde()[" + param.getFechaDesde() + "]");
			logger.debug("param.getFechaHasta()[" + param.getFechaHasta() + "]");
			logger.debug("param.getCodActAbo()[" + param.getCodActAbo() + "]");
			logger.debug("param.getCodPlanTarifDestino()[" + param.getCodPlanTarifDestino() + "]");
			logger.debug("param.getCodTipoMovimiento()[" + param.getCodTipoMovimiento() + "]");
			logger.debug("param.getCodProducto()[" + param.getCodProducto() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSourceSCL());
			
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, param.getSujeto()); //SUJETO
			cstmt.setString(2, param.getTipSujeto()); //TIP_SUJETO
			cstmt.setString(3, param.getFechaDesde());//FEC_DES
			cstmt.setString(4, param.getFechaHasta());//FEC_HAS
			cstmt.setString(5,param.getCodActAbo());//COD_ACTABO
			cstmt.setString(6,param.getCodPlanTarifDestino());//COD_PLANTARIF_NUEVO
			cstmt.setString(7,param.getCodTipoMovimiento());//TIPO_MOVIMIENTO
			cstmt.setInt(8, param.getCodProducto()); //COD_PRODUCTO

			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);			
		
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(9);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(10);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(11);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al actualizar límite de consumo");
				throw new ServiceSpecEntitiesException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			retorno = new RetornoDTO();
			retorno.setCodigo("0");
			retorno.setDescripcion(msgError);
			
		} catch (ServiceSpecEntitiesException e) {
			logger.debug("ServiceSpecEntitiesException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al actualizar límite de consumo", e);
			throw new ServiceSpecEntitiesException("Ocurrió un error al actualizar límite de consumo",e);
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
		logger.debug("actualizarLimiteConsumo():end");
		return retorno;
	}

	/**
	 * Registra movimientos a interfaz con central
	 * 
	 * @param param
	 * @return RetornoDTO
	 * @throws ServiceSpecEntitiesException
	 */		
	public RetornoDTO aprovisionamiento(AprovisionamientoDTO param)
			throws ServiceSpecEntitiesException {
		logger.debug("aprovisionamiento():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLaprovisionamiento();
		try {
			logger.debug("1-param.getNumAbonado()[" + param.getNumAbonado() + "]");
			logger.debug("2-param.getCodActAbo()[" + param.getCodActAbo() + "]");
			logger.debug("3-param.getTipoTecnologia()[" + param.getTipoTecnologia() + "]");
			logger.debug("4-param.getUsuarioOracle()[" + param.getUsuarioOracle() + "]");
			logger.debug("5-param.getCodTipoTerminal()[" + param.getCodTipoTerminal() + "]");
			logger.debug("6-param.getCodCentral()[" + param.getCodCentral() + "]");
			logger.debug("7-param.getNumCelular()[" + param.getNumCelular() + "]");
			logger.debug("8-param.getNumSerie()[" + param.getNumSerie() + "]");
			logger.debug("9-param.getImei()[" + param.getImei() + "]");
			logger.debug("10-param.getValorOOSS()[" + param.getValorOOSS() + "]");
			logger.debug("11-param.getCodPlanTarif()[" + param.getCodPlanTarif() + "]");
			logger.debug("12-param.getNumOOSS()[" + param.getNumOOSS() + "]");
			logger.debug("13-param.getCodOOSS()[" + param.getCodOOSS() + "]");
			logger.debug("14-param.getSeqNumMov()[" + param.getSeqNumMov() + "]");
			logger.debug("15-param.getCodTiPlan()[" + param.getCodTipPlan()+ "]");
			logger.debug("16-param.getCodServicios()[" + param.getCodServicios()+ "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSourceSCL());
			cstmt = conn.prepareCall(call);
			
			cstmt.setLong(1, param.getNumAbonado());  //NUM_ABONADO
			cstmt.setString(2, param.getCodActAbo());  //COD_ACTABO
			cstmt.setString(3, param.getTipoTecnologia()); //TIP_TECNOLOGIA
			cstmt.setString(4, param.getUsuarioOracle()); //NOM_USUARORA
			cstmt.setString(5, param.getCodTipoTerminal());  //TIP_TERMINAL
			cstmt.setInt(6, param.getCodCentral());  //COD_CENTRAL
			cstmt.setLong(7, param.getNumCelular()); //NUM_CELULAR
			cstmt.setString(8, param.getNumSerie()); //NUM_SERIE
			cstmt.setString(9, param.getImei()); //IMEI
			cstmt.setFloat(10, param.getValorOOSS()); //VALOR_OOSS
			cstmt.setString(11, param.getCodPlanTarif()); //COD_PLANTARIF_NUEVO
			cstmt.setLong(12, param.getNumOOSS()); //NUM_OOSS
			cstmt.setLong(13, param.getCodOOSS()); //COD_OOSS
			cstmt.setLong(14, param.getSeqNumMov()); //SEQ_NUMMOV
			cstmt.setString(15, param.getCodTipPlan()); //COD_TIPLAN
			cstmt.setString(16, param.getCodServicios()); //COD_SERVICIOS
			
			cstmt.registerOutParameter(17, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(18, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(19, java.sql.Types.NUMERIC);			
		
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(17);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(18);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(19);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al registrar movimientos a interfaz con central");
				throw new ServiceSpecEntitiesException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			retorno = new RetornoDTO();
			retorno.setDescripcion("0");
			retorno.setDescripcion(msgError);
			
		} catch (ServiceSpecEntitiesException e) {
			logger.debug("ServiceSpecEntitiesException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al registrar movimientos a interfaz con central", e);
			throw new ServiceSpecEntitiesException("Ocurrió un error al registrar movimientos a interfaz con central",e);
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
		logger.debug("aprovisionamiento():end");
		return retorno;
	}

	/**
	 * Obtiene parametro que indica si el cliente es Atlantida o no
	 * 
	 * @param cliente
	 * @return ParametroDTO
	 * @throws ServiceSpecEntitiesException
	 */	
	public ParametroDTO obtieneAtlantida(ClienteDTO cliente)
			throws ServiceSpecEntitiesException {
		logger.debug("obtieneAtlantida():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ParametroDTO parametro = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtieneAtlantida();
		try {
		
			logger.debug("cliente.getCodCliente()[" + cliente.getCodCliente() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSourceSCL());
			
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, cliente.getCodCliente());
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
				logger.error(" Ocurrió un error al obtener parámetro Atlantida");
				throw new ServiceSpecEntitiesException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			//AGREGAR RETORNO
			parametro = new ParametroDTO();
			
		} catch (ServiceSpecEntitiesException e) {
			logger.debug("ServiceSpecEntitiesException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener parámetro Atlantida", e);
			throw new ServiceSpecEntitiesException("Ocurrió un error al obtener parámetro Atlantida",e);
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
		logger.debug("obtieneAtlantida():end");
		return parametro;
	}

	/**
	 * Registra prorrateo al realizar una migración de prepago a hibrido(pospago)
	 * 
	 * @param 
	 * @return RetornoDTO
	 * @throws ServiceSpecEntitiesException
	 */
	public RetornoDTO registraProrrateo() throws ServiceSpecEntitiesException {
		logger.debug("registraProrrateo():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLregistraProrrateo();
		try {
		
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSourceSCL());
			
			cstmt = conn.prepareCall(call);
			
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
				logger.error(" Ocurrió un error al registrar prorrateo");
				throw new ServiceSpecEntitiesException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			//AGREGAR RETORNO
			retorno = new RetornoDTO();
			
		} catch (ServiceSpecEntitiesException e) {
			logger.debug("ServiceSpecEntitiesException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al registrar prorrateo", e);
			throw new ServiceSpecEntitiesException("Ocurrió un error al registrar prorrateo",e);
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
		logger.debug("registraProrrateo():end");
		return retorno;
	}

	/**
	 * Registra baja Atlantida
	 * 
	 * @param param
	 * @return RetornoDTO
	 * @throws ServiceSpecEntitiesException
	 */
	public RetornoDTO validaBajaAtlantida(BajaAtlantidaDTO param)
			throws ServiceSpecEntitiesException {
		logger.debug("validaBajaAtlantida():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;
		Connection conn = null;
		CallableStatement cstmt = null;

		java.sql.Date fechaIng = null;
		java.sql.Date fechaLec = null;
		java.sql.Date fechaEjec = null;
		java.sql.Date fechaExp = null;
		
		String call = getSQLvalidaBajaAtlantida();
		try {
			logger.debug("param.getNumAbonado()[" + param.getNumAbonado()+ "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSourceSCL());
			
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, param.getIdMovimiento()); //NUM_MOVIMIENTO
			cstmt.setLong(2, param.getNumAbonado()); //NUM_ABONADO
			cstmt.setInt(3, param.getCodEstado()); //COD_ESTADO
			cstmt.setString(4, param.getCodActAbo()); //COD_ACTABO
			cstmt.setString(5, param.getCodModulo()); //COD_MODULO
			cstmt.setInt(6, param.getCantidadIntentos()); //NUM_INTENTOS
			cstmt.setInt(7, param.getCodCentralDestino()); //COD_CENTRAL_NUE
			cstmt.setString(8, param.getDescripcionRespuesta()); //DES_RESPUESTA
			cstmt.setString(9, param.getCodActuacion()); //COD_ACTUACION
			cstmt.setString(10, param.getUsuarioOracle()); //NOM_USUARORA
			
			try{
				fechaIng = new java.sql.Date(param.getFechaIngreso().getTime());
			}catch(Exception e){}
			
			cstmt.setDate(11, fechaIng); //FEC_INGRESO
			cstmt.setString(12, param.getCodTipoTerminal()); //TIP_TERMINAL
			cstmt.setInt(13, param.getCodCentral()); //COD_CENTRAL

			try{
				fechaLec = new java.sql.Date(param.getFechaLectura().getTime());
			}catch(Exception e){}

			cstmt.setDate(14, fechaLec); //FEC_LECTURA
			cstmt.setLong(15, param.getIndBloqueo()); //IND_BLOQUEO
			
			try{
				fechaEjec = new java.sql.Date(param.getFechaEjecucion().getTime());
			}catch(Exception e){}

			cstmt.setDate(16, fechaEjec); //FEC_EJECUCION
			cstmt.setString(17, param.getCodTipoTerminalDestino()); //TIP_TERMINAL_NUE
			cstmt.setLong(18, param.getIdMovimientoAnterior()); //NUM_MOVANT
			cstmt.setLong(19, param.getNumCelular()); //NUM_CELULAR
			cstmt.setLong(20, param.getIdMovimientoPosterior()); //NUM_MOVPOS
			cstmt.setString(21, param.getNumSerie()); //NUM_SERIE
			cstmt.setString(22, param.getNumPersonal()); //NUM_PERSONAL
			cstmt.setLong(23, param.getNumCelularDestino()); //NUM_CELULAR_NUE
			cstmt.setString(24, param.getNumSerieDestino()); //NUM_SERIE_NUE
			cstmt.setString(25, param.getNumPersonalDestino()); //NUM_PERSONAL_NUE
			cstmt.setString(26, param.getCodMSNB()); //NUM_MSNB
			cstmt.setString(27, param.getCodMSNBDestino()); //NUM_MSNB_NUE
			cstmt.setString(28, param.getCodSupreha()); //COD_SUSPREHA
			cstmt.setString(29, param.getCodSupreha()); //COD_SERVICIOS
			cstmt.setString(30, param.getCodMIN()); //NUM_MIN
			cstmt.setString(31, param.getCodMINDestino()); //NUM_MIN_NUE
			cstmt.setString(32, param.getSta()); //STA
			cstmt.setInt(33, param.getCodMensaje()); //COD_MENSAJE
			cstmt.setString(34, param.getMensaje1()); //PARAM1_MENS
			cstmt.setString(35, param.getMensaje2()); //PARAM2_MENS
			cstmt.setString(36, param.getMensaje3()); //PARAM3_MENS
			cstmt.setString(37, param.getCodPlanTarifOrigen()); //COD_PLAN_ACTUAL
			cstmt.setFloat(38, param.getCarga()); //CARGA
			cstmt.setFloat(39, param.getValorPlan()); //VALOR_PLAN
			cstmt.setString(40, param.getPin()); //PIN
			
			try{
				fechaExp = new java.sql.Date(param.getFechaExpiracion().getTime());
			}catch(Exception e){}
			
			cstmt.setDate(41, fechaExp); //FEC_EXPIRA
			cstmt.setString(42, param.getDescripcionMensaje()); //DES_MENSAJE
			cstmt.setString(43, param.getCodPIN()); //COD_PIN
			cstmt.setString(44, param.getCodIdioma()); //COD_IDIOMA
			cstmt.setInt(45, param.getCodEnrutamiento()); //COD_ENRUTAMIENTO
			cstmt.setInt(46, param.getCodTipoEnrutamiento()); //TIP_ENRUTAMIENTO
			cstmt.setString(47, param.getDesOrigenPIN()); //DES_ORIGEN_PIN
			cstmt.setLong(48, param.getNumLotePIN()); //NUM_LOTE_PIN
			cstmt.setString(49, param.getNumSeriePIN()); //NUM_SERIE_PIN
			cstmt.setString(50, param.getCodTipoTecnologia()); //TIP_TECNOLOGIA
			cstmt.setString(51, param.getImsi()); //IMSI
			cstmt.setString(52, param.getImeiDestino()); //IMSI_NUE
			cstmt.setString(53, param.getImei()); //IMEI
			cstmt.setString(54, param.getImeiDestino()); //IMEI_NUE
			cstmt.setString(55, param.getIcc()); //ICC
			cstmt.setString(56, param.getIccDestino()); //ICC_NUE

			cstmt.registerOutParameter(57, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(58, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(59, java.sql.Types.NUMERIC);			

			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(57);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(58);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(59);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al validar baja Atlantida");
				throw new ServiceSpecEntitiesException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			retorno = new RetornoDTO();
			retorno.setCodigo("0");
			retorno.setDescripcion(msgError);
			
		} catch (ServiceSpecEntitiesException e) {
			logger.debug("ServiceSpecEntitiesException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al validar baja Atlantida", e);
			throw new ServiceSpecEntitiesException("Ocurrió un error al validar baja Atlantida",e);
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
		logger.debug("validaBajaAtlantida():end");
		return retorno;

	}

	/**
	 * Registra baja y/o alta de gestor corporativo
	 * 
	 * @param param
	 * @return RetornoDTO
	 * @throws ServiceSpecEntitiesException
	 */	
	public GestorCorpDTO validaGestorCorp(GestorCorpDTO param)
			throws ServiceSpecEntitiesException {
		
		logger.debug("validaGestorCorp():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		String generaComandOut;
		String abonadoGestorOut;
		String abonadoGestorDefOut;
		
		GestorCorpDTO retorno = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLvalidaGestorCorp();
		try {
			logger.debug("param.getNumAbonado()[" + param.getNumAbonado()+ "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSourceSCL());
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setLong(1, param.getNumAbonado());   //N_NUM_ABONADO
			cstmt.setString(2, param.getCodActAboGestor()); //V_COD_ACTABO_GESTOR
			cstmt.setString(3, param.getUsuarioOracle()); //V_NOM_USUARORA
			cstmt.setString(4, param.getCodPlanTarif()); //V_COD_PLANTARIF_ACTUA
			cstmt.setString(5, param.getCodPlanTarifDestino()); //V_COD_PLANTARIF_NUEVO
			cstmt.setString(6, param.getCodTipoMovimiento()); //V_TIP_MOVIMIENTO
			cstmt.setString(7, param.getCodActAbo()); //V_COD_ACTABO_OOSS
			cstmt.setString(8, param.getFlagGestor()); //V_ABONADO_GESTOR
			cstmt.setString(9, param.getFlagGestorDefault()); //V_ABONADO_GESTOR_DEF
			cstmt.setLong(10, param.getIdSecuencia()); //N_SEQ_TRANS_ACABO

			cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(14, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(15, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(16, java.sql.Types.NUMERIC);			
		
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			generaComandOut = cstmt.getString(11);
			logger.debug("generaComandOut[" + generaComandOut + "]");
			abonadoGestorOut = cstmt.getString(12);
			logger.debug("abonadoGestorOut[" + abonadoGestorOut + "]");
			abonadoGestorDefOut = cstmt.getString(13);
			logger.debug("abonadoGestorDefOut[" + abonadoGestorDefOut + "]");

			codError = cstmt.getInt(14);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(15);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(16);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al registrar baja y/o alta de gestor corporativo");
				throw new ServiceSpecEntitiesException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			retorno = new GestorCorpDTO();
			retorno.setGeneraComandOut(generaComandOut);
			retorno.setAbonadoGestorOut(abonadoGestorOut);
			retorno.setAbonadoGestorDefOut(abonadoGestorDefOut);
			
			
		} catch (ServiceSpecEntitiesException e) {
			logger.debug("ServiceSpecEntitiesException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al registrar baja y/o alta de gestor corporativo", e);
			throw new ServiceSpecEntitiesException("Ocurrió un error al registrar baja y/o alta de gestor corporativo",e);
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
		logger.debug("validaGestorCorp():end");
		return retorno;		

	}
	
	/**
	 * Consulta saldo
	 * 
	 * @param consulta
	 * @return SaldoDTO
	 * @throws ServiceSpecEntitiesException
	 */	
	public SaldoDTO consultaSaldo(SaldoDTO consulta) throws ServiceSpecEntitiesException{
		logger.debug("consultaSaldo():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		String saldo;
		
		SaldoDTO retornoSaldo = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLconsultaSaldo();
		try {
			logger.debug("consulta.getNumCelular()[" + consulta.getNumCelular()+ "]");
			logger.debug("consulta.getCodTecnologia()[" + consulta.getCodTecnologia()+ "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSourceSCL());
			
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, consulta.getNumCelular());   //NUM_CELULAR
			cstmt.setString(2, consulta.getCodTecnologia()); //COD_TECNOLOGIA
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);			
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR); //SALDO
			
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
				logger.error(" Ocurrió un error al consultar saldo");
				throw new ServiceSpecEntitiesException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			saldo = cstmt.getString(6);
			logger.debug("saldo[" + saldo + "]");

			retornoSaldo = consulta;
			retornoSaldo.setSaldo(saldo);
			
		} catch (ServiceSpecEntitiesException e) {
			logger.debug("ServiceSpecEntitiesException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al consultar saldo", e);
			throw new ServiceSpecEntitiesException("Ocurrió un error al consultar saldo",e);
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
		logger.debug("consultaSaldo():end");
		return retornoSaldo;
	}
	
	/**
	 * Consulta plan actual
	 * 
	 * @param consulta
	 * @return PlanTarifarioDTO
	 * @throws ServiceSpecEntitiesException
	 */	
	public PlanTarifarioDTO consultaPlanActual(ConsultaPlanTarifDTO consulta) throws ServiceSpecEntitiesException{
		logger.debug("consultaPlanActual():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		String codPlanTarif;
		String desPlanTarif;
		
		PlanTarifarioDTO plan = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLconsultaPlanActual();
		try {
			logger.debug("consulta.getCodPlanTarifNuevo()[" + consulta.getCodPlanTarifNuevo()+ "]");
			logger.debug("consulta.getCodPlantarif()[" + consulta.getCodPlantarif()+ "]");
			logger.debug("consulta.getCodTecnologia()[" + consulta.getCodTecnologia()+ "]");
						
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSourceSCL());
			
			cstmt = conn.prepareCall(call);
			cstmt.setString(1, consulta.getCodPlanTarifNuevo()); //COD_PLANTARIF_NUEVO
			cstmt.setString(2, consulta.getCodPlantarif()); //COD_PLANTARIF
			cstmt.setString(3, consulta.getCodTecnologia()); //TIP_TECNOLOGIA
						
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);			
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR); //COD_PLANTARIF
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR); //DES_PLANTARIF
			
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(4);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(5);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(6);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al consultar plan actual");
				throw new ServiceSpecEntitiesException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			codPlanTarif = cstmt.getString(7);
			logger.debug("codPlanTarif[" + codPlanTarif + "]");
			desPlanTarif = cstmt.getString(8);
			logger.debug("desPlanTarif["+ desPlanTarif + "]");

			plan = new PlanTarifarioDTO();
			plan.setCodPlanTarif(codPlanTarif);
			plan.setDesPlanTarif(desPlanTarif);
			
		} catch (ServiceSpecEntitiesException e) {
			logger.debug("ServiceSpecEntitiesException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al consultar plan actual", e);
			throw new ServiceSpecEntitiesException("Ocurrió un error al consultar plan actual",e);
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
		logger.debug("consultaPlanActual():end");
		return plan;	
	}

	/**
	 * Consulta listas activas
	 * 
	 * @param consulta
	 * @return ListaActivaListDTO
	 * @throws ServiceSpecEntitiesException
	 */	
	public ListaActivaListDTO consultaListaActivas(ConsultaPlanTarifDTO consulta) throws ServiceSpecEntitiesException{
		logger.debug("consultaListaActivas():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		
		ListaActivaListDTO listaActivaList = null;
		ListaActivaDTO[] arrayListaActiva = null;
		
		ListaActivaListDTO plan = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLconsultaListaActivas();
		try {
			
			logger.debug("consulta.getNumCelular()[" + consulta.getNumCelular()+ "]");
			logger.debug("consulta.getCodTecnologia()[" + consulta.getCodTecnologia()+ "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSourceSCL());
			
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, consulta.getNumCelular());   //NUM_CELULAR
			cstmt.setString(2, consulta.getCodTecnologia()); //COD_TECNOLOGIA
			cstmt.registerOutParameter(3, oracle.jdbc.driver.OracleTypes.CURSOR);	
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);			
			
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(4);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(5);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(6);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al consultar listas activas");
				throw new ServiceSpecEntitiesException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando cursor...");
			ResultSet rs = (ResultSet) cstmt.getObject(3);
			
			ArrayList lista = new ArrayList();
			while (rs.next()) {
				ListaActivaDTO listaActiva = new ListaActivaDTO();
				listaActiva.setCodigo(rs.getString(1));
				logger.debug("codigo[" + listaActiva.getCodigo() + "]");
				listaActiva.setValor(rs.getString(2));
				logger.debug("valor[" + listaActiva.getValor() + "]");
				
				lista.add(listaActiva);
			}
			
			arrayListaActiva = (ListaActivaDTO[]) ArrayUtl.copiaArregloTipoEspecifico(	lista.toArray(), ListaActivaDTO.class);
			listaActivaList = new ListaActivaListDTO();
			listaActivaList.setLista(arrayListaActiva);		

			rs.close();
			
		} catch (ServiceSpecEntitiesException e) {
			logger.debug("ServiceSpecEntitiesException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al consultar listas activas", e);
			throw new ServiceSpecEntitiesException("Ocurrió un error al consultar listas activas",e);
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
		logger.debug("consultaListaActivas():end");
		return listaActivaList;	
	}
	
	/**
	 * Obtiene info de plan tarifario en Atlantida
	 * 
	 * @param abonado
	 * @return RetornoDTO
	 * @throws ServiceSpecEntitiesException
	 */	
	public RetornoDTO obtenerPlanAtlantida(AbonadoDTO abonado) throws ServiceSpecEntitiesException{
		logger.debug("obtenerPlanAtlantida():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		String codPlanTarif;
		
		RetornoDTO retorno = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerPlanAtlantida();
		try {
			logger.debug("abonado.getCodPlanTarif()[" + abonado.getCodPlanTarif()+ "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSourceSCL());
			
			cstmt = conn.prepareCall(call);
			cstmt.setString(1, abonado.getCodPlanTarif()); 
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
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
				logger.error(" Ocurrió un error al obtener información de Atlántida");
				throw new ServiceSpecEntitiesException(String.valueOf(codError),numEvento, msgError);
			}
			String res = cstmt.getString(2);
			logger.debug("res[" + res + "]");
			
			retorno = new RetornoDTO();
			retorno.setCodigo("0");
			retorno.setDescripcion(msgError);
			retorno.setResultado(res.equalsIgnoreCase("TRUE")?true:false);
			
		} catch (ServiceSpecEntitiesException e) {
			logger.debug("ServiceSpecEntitiesException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener información de Atlántida", e);
			throw new ServiceSpecEntitiesException("Ocurrió un error al obtener información de Atlántida",e);
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
		logger.debug("obtenerPlanAtlantida():end");
		return retorno;	
		
	}
	
	/**
	 * Inserta movimiento Atlantida
	 * 
	 * @param mov
	 * @return RetornoDTO
	 * @throws ServiceSpecEntitiesException
	 */	
	public RetornoDTO insertaMovAtl(MovAtlantidaDTO mov) throws ServiceSpecEntitiesException
{
		logger.debug("insertaMovAtl():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		String codPlanTarif;
		
		RetornoDTO retorno = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLinsertaMovAtl();
		try {
			logger.debug("mov.getNumAbonado()[" + mov.getNumAbonado()+ "]");
			logger.debug("mov.getCodPlanTarifNuevo()[" + mov.getCodPlanTarifNuevo()+ "]");
			logger.debug("mov.getCodCliente()[" + mov.getCodCliente()+ "]");
			logger.debug("mov.getParam()[" + mov.getParam()+ "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSourceSCL());
			
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, mov.getNumAbonado()); //NUM_ABONADO
			cstmt.setString(2, mov.getCodPlanTarifNuevo()); //COD_PLANTARIF_NUE
			cstmt.setLong(3, mov.getCodCliente()); //COD_CLIENTE
			cstmt.setString(4, mov.getParam()); //PARAM
			
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
				logger.error(" Ocurrió un error al insertar movimiento Atlántida");
				throw new ServiceSpecEntitiesException(String.valueOf(codError),numEvento, msgError);
			}
			retorno = new RetornoDTO();
			retorno.setCodigo("0");
			retorno.setDescripcion(msgError);
			
		} catch (ServiceSpecEntitiesException e) {
			logger.debug("ServiceSpecEntitiesException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al insertar movimiento Atlántida", e);
			throw new ServiceSpecEntitiesException("Ocurrió un error al insertar movimiento Atlántida",e);
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
		logger.debug("insertaMovAtl():end");
		return retorno;	
	}
	
	/**
	 * Obtiene servicios contratatados
	 * 
	 * @param abonado
	 * @return AbonadoDTO
	 * @throws ServiceSpecEntitiesException
	 */	
	public AbonadoDTO obtenerServContrato(AbonadoDTO abonado) throws ServiceSpecEntitiesException{
		logger.debug("obtenerServContrato():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		String codPlanTarif;
		
		AbonadoDTO retorno = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerServContrato();
		try {
			logger.debug("abonado.getCodActAbo()[" + abonado.getCodActAbo()+ "]");
			logger.debug("abonado.getCodTecnologia()[" + abonado.getCodTecnologia()+ "]");
			logger.debug("abonado.getCodTipoTerminal()[" + abonado.getCodTipoTerminal()+ "]");
			logger.debug("abonado.getCodCentral()[" + abonado.getCodCentral()+ "]");
			logger.debug("abonado.getCodPlanTarif()[" + abonado.getCodPlanTarif()+ "]");
			logger.debug("abonado.getNumAbonado()[" + abonado.getNumAbonado()+ "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSourceSCL());
			
			cstmt = conn.prepareCall(call);
			cstmt.setString(1, abonado.getCodActAbo()); //COD_ACTABO
			cstmt.setString(2, abonado.getCodTecnologia()); //COD_TECNOLOGIA
			cstmt.setString(3, abonado.getCodTipoTerminal()); //TIP_TERMINAL
			cstmt.setInt(4, abonado.getCodCentral()); //COD_CENTRAL
			cstmt.setString(5, abonado.getCodPlanTarif()); //COD_PLANTARIF
			cstmt.setLong(6, abonado.getNumAbonado()); //NUM_ABONADO
			
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);			
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
			
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(7);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(8);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(9);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al obtener servicios contratados");
				throw new ServiceSpecEntitiesException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data");
			String servicios = cstmt.getString(10);
			
			retorno = abonado;
			retorno.setClaseServicio(servicios);
			
		} catch (ServiceSpecEntitiesException e) {
			logger.debug("ServiceSpecEntitiesException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener servicios contratados", e);
			throw new ServiceSpecEntitiesException("Ocurrió un error al obtener servicios contratados",e);
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
		logger.debug("obtenerServContrato():end");
		return retorno;			
	}
	
	/**
	 * Registra servicios contratatados
	 * 
	 * @param abonado
	 * @return RetornoDTO
	 * @throws ServiceSpecEntitiesException
	 */	
	public RetornoDTO registrarServContrato(AbonadoDTO abonado) throws ServiceSpecEntitiesException{
		logger.debug("registrarServContrato():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		String codPlanTarif;
		
		RetornoDTO retorno = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLregistrarServContrato();
		try {

			logger.debug("abonado.getClaseServicio()[" + abonado.getClaseServicio()+ "]");
			logger.debug("abonado.getNumAbonado()[" + abonado.getNumAbonado()+ "]");
			logger.debug("abonado.getUsuarioOracle()[" + abonado.getUsuarioOracle()+ "]");
			logger.debug("abonado.getNumCelular()[" + abonado.getNumCelular()+ "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSourceSCL());
			
			cstmt = conn.prepareCall(call);
			cstmt.setString(1, abonado.getClaseServicio()); //CLASE_SERVICIO
			cstmt.setLong(2, abonado.getNumAbonado()); //NUM_ABONADO
			cstmt.setString(3, abonado.getUsuarioOracle()); //NOM_USUAORA
			cstmt.setLong(4, abonado.getNumCelular()); //NUM_CELULAR
			
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
				logger.error(" Ocurrió un error al registrar servicios contratados");
				throw new ServiceSpecEntitiesException(String.valueOf(codError),numEvento, msgError);
			}
			
			retorno = new RetornoDTO();
			retorno.setCodigo("0");
			retorno.setDescripcion(msgError);
			
		} catch (ServiceSpecEntitiesException e) {
			logger.debug("ServiceSpecEntitiesException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al registrar servicios contratados", e);
			throw new ServiceSpecEntitiesException("Ocurrió un error al registrar servicios contratados",e);
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
		logger.debug("registrarServContrato():end");
		return retorno;				
	}

	public RetornoDTO generarMovimiento(ProductoContratadoListDTO listProductoContratado) throws ServiceSpecEntitiesException 
	{
		logger.debug("generarMovimiento():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		String codPlanTarif;
		
		RetornoDTO retorno = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLregistrarServContrato();
		try {

			
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSourceSCL());
			
			//cstmt = conn.prepareCall(call);
			
	/*		
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);			*/
			
			logger.debug("execute:antes");
			//cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			//codError = cstmt.getInt(5);
			logger.debug("codError[" + codError + "]");
			//msgError = cstmt.getString(6);
			logger.debug("msgError[" + msgError + "]");
			//numEvento = cstmt.getInt(7);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al registrar servicios contratados");
				throw new ServiceSpecEntitiesException(String.valueOf(codError),numEvento, msgError);
			}
			
			retorno = new RetornoDTO();
			retorno.setCodigo(String.valueOf(codError));
			retorno.setDescripcion(msgError);
			retorno.setResultado(true);
			
		} catch (ServiceSpecEntitiesException e) {
			logger.debug("ServiceSpecEntitiesException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al registrar servicios contratados", e);
			throw new ServiceSpecEntitiesException("Ocurrió un error al registrar servicios contratados",e);
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
		logger.debug("generarMovimiento():end");
		return retorno;				
	}
	
	/**
	 * Obtiene la lista de bodegas
	 * 
	 * @param param
	 * @return BodegaListDTO
	 * @throws ServiceSpecEntitiesException
	 */
	
	public BodegaListDTO obtenerListaBodegas(ConsultaBodegaDTO param) throws ServiceSpecEntitiesException {
		
		logger.debug("obtenerListaBodegas():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		BodegaListDTO bodegaList = null;
		BodegaDTO[] bodegas = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerListaBodegas();
		try {
		
			logger.debug("param.getCodVendedor()["+param.getCodVendedor() + "]");
						
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSourceSCL());
						
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, param.getCodVendedor()); //COD_VENDEDOR
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
				logger.error(" Ocurrió un error al obtener lista de bodegas");
				throw new ServiceSpecEntitiesException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando cursor...");
			logger.debug("object="+cstmt.getObject(2));
			ResultSet rs = (ResultSet) cstmt.getObject(2);
					
			ArrayList lista = new ArrayList();
			while (rs.next()) {
				BodegaDTO bodega = new BodegaDTO();
				bodega.setCodBodega(rs.getLong(1));
				logger.debug("codBodega    :"+bodega.getCodBodega());
				bodega.setDesBodega(rs.getString(2));
				logger.debug("desBodega    :"+bodega.getDesBodega());
				lista.add(bodega);
			}
			
			bodegas = (BodegaDTO[]) ArrayUtl.copiaArregloTipoEspecifico(	lista.toArray(), BodegaDTO.class);
			bodegaList = new BodegaListDTO();
			bodegaList.setBodegas(bodegas);
			rs.close();
		} catch (ServiceSpecEntitiesException e) {
			logger.debug("ServiceSpecEntitiesException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener lista de bodegas", e);
			throw new ServiceSpecEntitiesException("Ocurrió un error general al obtener lista de bodegas",e);
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
		logger.debug("obtenerListaBodegas():end");
		return bodegaList;

	}
	
	
}
