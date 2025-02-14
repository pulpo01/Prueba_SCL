package com.tmmas.scl.framework.ProductDomain.dao;


import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.ProductDomain.dao.interfaces.DatosGeneralesDAOIT;
import com.tmmas.scl.framework.ProductDomain.dto.BodegaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CategoriaTributariaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CausaCamSerieDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CentralDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CuotaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.DatosCentralDTO;
import com.tmmas.scl.framework.ProductDomain.dto.MesesProrrogasDTO;
import com.tmmas.scl.framework.ProductDomain.dto.ModalidadPagoDTO;
import com.tmmas.scl.framework.ProductDomain.dto.ParametrosGeneralesDTO;
import com.tmmas.scl.framework.ProductDomain.dto.RestriccionesDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SerieDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TecnologiaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TipoDeContratoDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TipoTerminalDTO;
import com.tmmas.scl.framework.ProductDomain.dto.UsoArticuloDTO;
import com.tmmas.scl.framework.ProductDomain.dto.UsosVentaDTO;
import com.tmmas.scl.framework.ProductDomain.exception.ProductException;
import com.tmmas.scl.framework.ProductDomain.helper.Global;
import com.tmmas.scl.framework.aplicationDomain.dto.MensajeRetornoDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.OperadoraLocalDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.SesionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ArticuloDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosVerificaPlanComercialDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ParametrosCambioSerieDTO;


public class DatosGeneralesDAO extends ConnectionDAO implements DatosGeneralesDAOIT {

	private final Logger logger = Logger.getLogger(DatosGeneralesDAO.class);
	private final Global global = Global.getInstance();

	private String getSQLvalidaCausaCamSerie() {
		StringBuffer call = new StringBuffer();
		
		call.append("	DECLARE "); 
		call.append("		OE_SESION GE_SESION_QT := NEW GE_SESION_QT; ");
		call.append("		OE_CAUCASER GA_CAUCASER_QT := NEW GA_CAUCASER_QT; ");
		call.append("	BEGIN ");
		call.append("		oe_sesion.num_abonado    := ?; "); 		
		call.append("		oe_sesion.nom_usuario    := ?; ");
    	call.append("		oe_sesion.cod_programa   := ?; ");
		call.append("		oe_sesion.num_version    := ?; ");			     
		call.append("		oe_caucaser.cod_caucaser := ?; ");
		call.append("		pv_cambio_simcard_sb_pg.pv_val_cau_cam_serie_pr ( oe_sesion, oe_caucaser, ?, ?, ? ); ");
    	call.append("	END; ");
		return call.toString(); 		 		
	}		    	
	
	private String getSQLgetDatosCentral() {
		StringBuffer call = new StringBuffer();									
		call.append("		BEGIN  ");
		call.append("		  VE_parametros_comerciales_PG.VE_Obtiene_DatosCentral_PR( ?, ?, ?, ?, ?); ");		
		call.append("		END;  ");
		return call.toString(); 		 		
	}		
	
	private String getSQLgetParametroGeneral() {
		StringBuffer call = new StringBuffer();									
		call.append("		BEGIN  ");
		call.append("		  VE_intermediario_PG.VE_obtiene_valor_parametro_PR( ?, ?, ?, ?, ?, ?, ?); ");		
		call.append("		END;  ");
		return call.toString(); 		 		
	}		
	
	private String getSQLobtenertipoTerminal() {
		StringBuffer call = new StringBuffer();									
		call.append("		BEGIN  ");
		call.append("		  PV_CAMBIO_SERIE_SB_PG.pv_rec_tipo_terminal_pr( ?, ?, ?, ?, ?); ");		
		call.append("		END;  ");
		return call.toString(); 		 		
	}		
	
	private String getSQLobtenerModalidadPago() {
		StringBuffer call = new StringBuffer();		
		call.append("		DECLARE "); 
		call.append("		  ESO_CAUCASER GA_CAUCASER_QT := NEW GA_CAUCASER_QT;");
		call.append("		  ESO_sesion GE_SESION_QT     := NEW GE_SESION_QT;");						
		call.append("		BEGIN  ");
		call.append("		  ESO_sesion.num_abonado  := ?; ");		
		call.append("		  ESO_sesion.nom_usuario  := ?; ");
		call.append("		  ESO_sesion.cod_programa := ?; ");
		call.append("		  ESO_sesion.num_version  := ?; ");			
		call.append("		  ESO_CAUCASER.cod_caucaser := ?; ");
		call.append("		  PV_CAMBIO_SERIE_SB_PG.PV_REC_MODALIDAD_PAGO_PR ( ESO_CAUCASER, ESO_SESION, ?, ?, ?, ? ); ");		
		call.append("		END;  ");
		return call.toString(); 		 		
	}
	
	private String getSQLobtenerModalidadPagoSimcard() {
		StringBuffer call = new StringBuffer();		
		call.append("		DECLARE "); 
		call.append("		  ESO_CAUCASER GA_CAUCASER_QT := NEW GA_CAUCASER_QT;");
		call.append("		  ESO_sesion GE_SESION_QT     := NEW GE_SESION_QT;");						
		call.append("		BEGIN  ");
		call.append("		  ESO_sesion.num_abonado  := ?; ");		
		call.append("		  ESO_sesion.nom_usuario  := ?; ");
		call.append("		  ESO_sesion.cod_programa := ?; ");
		call.append("		  ESO_sesion.num_version  := ?; ");			
		call.append("		  ESO_CAUCASER.cod_caucaser := ?; ");
		call.append("		  pv_cambio_simcard_sb_pg.PV_REC_MODALIDAD_PAGO_PR ( ESO_CAUCASER, ESO_SESION, ?, ?, ?, ? ); ");		
		call.append("		END;  ");
		return call.toString(); 		 		
	}		
	  	 
	private String getSQLobtenerBodegas() {
		StringBuffer call = new StringBuffer();		
		call.append("		DECLARE "); 
		call.append("		    EO_SESION GE_SESION_QT := NEW GE_SESION_QT;");
		call.append("		BEGIN  ");
		call.append("		  EO_SESION.COD_CLIENTE := ?; "); 
		call.append("		  EO_SESION.NOM_USUARIO := ?; ");		
		call.append("		  PV_CAMBIO_SERIE_SB_PG.PV_RECUPERAR_BODEGAS_PR (EO_SESION, ?, ?, ?, ? ); ");
		call.append("		END;  ");
		return call.toString(); 		 		

	}

	private String getSQLobtenerCausaCambioSerie() {
		StringBuffer call = new StringBuffer();		
		call.append("BEGIN "); 
		call.append("PV_CAMBIO_SERIE_SB_PG.PV_REC_CAU_CAMBIO_SERIE_PR ( ?, ?, ?, ? ); "); 
		call.append("END; "); 		
		return call.toString(); 		 		
	}

	private String getSQLobtenerTiposDeContrato() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   eo_sesion GE_SESION_QT := NEW GE_SESION_QT;");		
		call.append("BEGIN "); 
		call.append("   eo_sesion.num_abonado := ?;");
		call.append("   eo_sesion.nom_usuario := ?;");
		call.append("   eo_sesion.cod_programa := ?;");
		call.append("   eo_sesion.num_version := ?;");		
		call.append("PV_CAMBIO_SERIE_SB_PG.PV_REC_TIPOS_CONTRATO_PR (eo_sesion, ?, ?, ?, ? ); "); 
		call.append("END; "); 		
		return call.toString(); 		 		
	}	
	
	// INICIO RRG 07032009 COL 78629
	private String getSQLobtenerTiposDeContratoOOSSWeb() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   eo_sesion GE_SESION_QT := NEW GE_SESION_QT;");		
		call.append("BEGIN "); 
		call.append("   eo_sesion.num_abonado := ?;");
		call.append("   eo_sesion.nom_usuario := ?;");
		call.append("   eo_sesion.cod_programa := ?;");
		call.append("   eo_sesion.num_version := ?;");		
		call.append("PV_CAMBIO_SERIE_SB_PG.pv_rec_tip_contrato_pr_oossweb (eo_sesion, ?, ?, ?, ? ); "); 
		call.append("END; "); 		
		return call.toString(); 		 		
	}	 
	// FIN RRG 07032009 COL 78629

	private String getSQLobtenerTecnologia() {
		StringBuffer call = new StringBuffer();		
		call.append("BEGIN "); 
		call.append("PV_CAMBIO_SERIE_SB_PG.PV_RECUPERAR_TECNOLOGIAS_PR ( ?, ?, ?, ? ); "); 
		call.append("END; "); 		
		return call.toString(); 		 		
	}

	private String getSQLobtenerUsos() {
		StringBuffer call = new StringBuffer();		
		call.append("BEGIN "); 
		call.append("PV_CAMBIO_SERIE_SB_PG.PV_RECUPERAR_USOS_PR ( ?, ?, ?, ? ); "); 
		call.append("END; "); 		
		return call.toString(); 		 		
	}

	private String getSQLobtenerMesesProrroga() {
		StringBuffer call = new StringBuffer();		
		call.append("BEGIN "); 
		call.append("PV_CAMBIO_SERIE_SB_PG.PV_REC_MESES_PRORROGA_PR ( ?, ?, ?, ? ); "); 
		call.append("END; "); 		
		return call.toString(); 		 		
	}	
	
	
	private String getSQLobtenerCuotas() {
		StringBuffer call = new StringBuffer();		
		call.append(" DECLARE"); 
		call.append("    eo_sesion ge_sesion_qt      := NEW ge_sesion_qt;");
		call.append("    eo_modventa ge_modventa_qt  := NEW ge_modventa_qt;");
		call.append(" BEGIN");
		call.append("   eo_sesion.nom_usuario := ?;");
		call.append("   eo_sesion.num_version := ?;");		
		call.append("   eo_sesion.cod_programa := ?;");
		call.append("    eo_modventa.cod_modventa  := ?;");
		call.append("    pv_cambio_serie_sb_pg.pv_recuperar_cuotas_pr ( eo_sesion, eo_modventa, ?, ?, ?, ?);");
		call.append(" END;"); 		
		return call.toString(); 		 		
	}	
		
	private String getSQLobtenerCatTributaria() {
		StringBuffer call = new StringBuffer();		
		call.append(" DECLARE"); 
		call.append("    eo_sesion ge_sesion_qt := NEW ge_sesion_qt;");
		call.append(" BEGIN");
		call.append("   eo_sesion.cod_cliente := ?;");
		call.append("   pv_cambio_serie_sb_pg.pv_rec_cat_tributaria_pr ( eo_sesion, ?, ?, ?, ?);");
		call.append(" END;"); 		
		return call.toString(); 		 		
	}	
	
	private String getSQLobtenerUsosVenta() {
		StringBuffer call = new StringBuffer();		
		call.append("BEGIN "); 
		call.append("pv_cambio_serie_sb_pg.pv_rec_usos_ventas_pr ( ?, ?, ?, ? ); "); 
		call.append("END; "); 		
		return call.toString(); 		 		
	}
	
	private String getSQLobtenerCentralTecnologiaHlr() {
		StringBuffer call = new StringBuffer();		
		
		call.append("DECLARE");
		call.append("  EO_ICG_CENTRAL ICG_CENTRAL_QT := NEW ICG_CENTRAL_QT;");		
		call.append("  EO_AL_SERIE    AL_SERIE_QT    := NEW AL_SERIE_QT   ;");  
		call.append("BEGIN "); 
		call.append("  EO_ICG_CENTRAL.cod_tecnologia := ?;"); 
		call.append("  EO_AL_SERIE.num_serie := ?;");		
		call.append("  PV_CAMBIO_SERIE_SB_PG.PV_REC_CENTRAL_HLR_PR ( EO_ICG_CENTRAL, EO_AL_SERIE, ?, ?, ?, ? ); "); 
		call.append("END; "); 		
		return call.toString(); 		 		
	}		
	
	private String getSQLobtenerlistArticulos() {
		StringBuffer call = new StringBuffer();		
			call.append("DECLARE ");
			call.append("  EN_COD_PRODUCTO NUMBER;");
			call.append("  EV_TIP_TERMINAL VARCHAR2(200);");
			call.append("BEGIN ");
			call.append("EN_COD_PRODUCTO := ?;");
			call.append("EV_TIP_TERMINAL := ?;");
			call.append("PV_CAMBIO_SERIE_SB_PG.PV_CNSLTA_ARTICULOS_PR ( EN_COD_PRODUCTO, EV_TIP_TERMINAL, ?,?,?,? );");
			call.append("END; ");
		return call.toString();
		
	}
	
	private String getSQLejecutaRestrccion() {
		StringBuffer call = new StringBuffer();
		
		call.append(" DECLARE "); 
	    call.append("   PV_RESTRICCIONES pv_restricciones_qt := NEW pv_restricciones_qt; ");
   		call.append(" BEGIN ");
		call.append("   pv_restricciones.cod_modulo    := ?; ");     
		call.append("   pv_restricciones.cod_actuacion := ?; ");
    	call.append("   pv_restricciones.cod_evento    := ?; ");
		call.append("   pv_restricciones.parametros    := ?; ");
		call.append("   ve_general_servicios_pg.pv_ejec_restriccion_pr ( PV_RESTRICCIONES, ?, ?, ?, ?, ? ); "); 
		call.append(" END; ");
		return call.toString();		
	}	
	
	private String getSQLobtenerEventosRestriccion() {
		StringBuffer call = new StringBuffer();
		
		call.append(" DECLARE "); 
	    call.append("   PV_RESTRICCIONES pv_restricciones_qt := NEW pv_restricciones_qt; ");
   		call.append(" BEGIN ");     
		call.append("   pv_restricciones.cod_actuacion := ?; ");
		call.append("   ve_general_servicios_pg.pv_rec_eventos_restriccion_pr  ( PV_RESTRICCIONES, ?, ?, ?, ?); "); 
		call.append(" END; ");
		return call.toString();		
	}	
	

	private String getSQLverificaPlancomercial() {
		StringBuffer call = new StringBuffer();		
		
		call.append("DECLARE");
		call.append("  RetVal BOOLEAN; ");		
		call.append("  OE_SESION GE_SESION_QT                  := NEW GE_SESION_QT ;");		
		call.append("  OE_CAUCASER GA_CAUCASER_QT              := NEW GA_CAUCASER_QT ;");		
		call.append("  OE_MODVENTA GE_MODVENTA_QT              := NEW GE_MODVENTA_QT ;");		
		call.append("  OE_USO AL_USO_QT                        := NEW AL_USO_QT ;");
		call.append("  eo_al_serie AL_SERIE_QT                 := NEW AL_SERIE_QT;");
		call.append("  OE_TIP_TERMINAL AL_TIPOS_TERMINALES_QT  := NEW AL_TIPOS_TERMINALES_QT ;");		
		call.append("BEGIN "); 
		call.append("  oe_sesion.num_abonado := ?; "); 
		call.append("  oe_caucaser.COD_CAUCASER := ?; ");
		call.append("  oe_MODVENTA.COD_MODVENTA := ?; ");		
		call.append("  oe_uso.cod_uso := ?; ");		
		call.append("  OE_TIP_TERMINAL.TIP_TERMINAL := ?; ");
		call.append("  eo_al_serie.num_serie := ?;");
		call.append("  RetVal := PV_CAMBIO_SIMCARD_SB_PG.PV_VERIFICA_PLAN_COMERCIAL_FN ( OE_SESION, OE_CAUCASER, OE_MODVENTA, OE_USO, OE_TIP_TERMINAL, eo_al_serie, ?, ?, ? ); "); 
		call.append("END; "); 		
		return call.toString(); 		 		
	}
	
	private String getSQLVerificaPlanComercialTerminal(){
		StringBuffer call = new StringBuffer();
			call.append(" DECLARE ");
			call.append("   RetVal BOOLEAN;");
			call.append("   resultado NUMERIC;");
			call.append("   EO_SESION GE_SESION_QT :=new GE_SESION_QT;");
			call.append("   EO_CAUCASER GA_CAUCASER_QT:=new GA_CAUCASER_QT;");
			call.append(" 	EO_MODVENTA GE_MODVENTA_QT:=new GE_MODVENTA_QT;");
			call.append("   EO_USO AL_USO_QT:=new AL_USO_QT;");
			call.append(" 	EO_TIP_TERMINAL AL_TIPOS_TERMINALES_QT:=new AL_TIPOS_TERMINALES_QT;");
			call.append(" 	EO_AL_SERIE AL_SERIE_QT:=new AL_SERIE_QT;");
			call.append(" 	EO_DAT_ABO PV_DATOS_ABO_QT:=new PV_DATOS_ABO_QT;");
			call.append(" BEGIN ");
			call.append(" 	EO_SESION.num_abonado :=?;");
			call.append(" 	EO_SESION.nom_usuario :=?;");
			call.append(" 	EO_SESION.cod_programa :=?;");
			call.append(" 	EO_SESION.num_version :=?;");
			call.append(" 	EO_CAUCASER.cod_caucaser:=?;"); 
			call.append(" 	EO_MODVENTA.cod_modventa:=?;");
			call.append(" 	EO_USO.cod_uso :=?;");
			call.append(" 	EO_TIP_TERMINAL.tip_terminal :=?;"); 
			call.append(" 	EO_AL_SERIE.num_serie :=?;");
			call.append(" 	EO_DAT_ABO.cod_tipcontrato:=?;");
			call.append(" 	EO_DAT_ABO.cod_tecnologia :=?;");
			call.append(" 	RetVal := PV_CAMBIO_SERIE_SB_PG.PV_VERIFICA_PLAN_COMERCIAL_FN ( EO_SESION, EO_CAUCASER, EO_MODVENTA, EO_USO, EO_TIP_TERMINAL, EO_AL_SERIE, EO_DAT_ABO, ?, ?, ? );");
			call.append(" 	IF (RetVal)THEN resultado:=1;"); 
			call.append(" 	ELSE resultado:=0;");
			call.append(" 	END IF;");
			call.append(" 	?:=resultado;");
			call.append(" END;"); 
		
		return call.toString();
	}
	
	public String getSQLVerificaConcFactGarantia(){
		StringBuffer call =new StringBuffer();
		call.append("");
		
		call.append("DECLARE"); 
		call.append("  RetVal NUMBER;");
		call.append("BEGIN ");
		call.append("  IF (PV_CAMBIO_SERIE_SB_PG.PV_VAL_CONCEP_FACT_GTIA_PR ( ?,?,? ))THEN");
		call.append("	 	RetVal:=1;");
		call.append("  ELSE");
		call.append("		RetVal:=0;");
		call.append("  END IF;");
		call.append("	 ?:=RetVal;");
		call.append("END; ");
		return call.toString();
	}
	
	private String getSQLValidaSeleccionCausa(){
		StringBuffer call =new StringBuffer();
		call.append(" BEGIN"); 
		call.append("	PV_CAMBIO_SERIE_SB_PG.PV_VAL_SELECCION_CAUSAS_PR ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ? );");
		call.append(" END; ");        
		return call.toString();
	}
	
	private String getSQLObtenerOperadoraLocal(){
		StringBuffer call =new StringBuffer();
		call.append(" BEGIN"); 
		call.append("	?:=GE_OBTIENE_OPERADORA_LOCAL_FN ( ?, ?, ?);");
		call.append(" END; ");        
		return call.toString();
	}
	
	private String getSQLConsultarSeguroAbonado(){
		StringBuffer call = new StringBuffer();		
		call.append("BEGIN "); 
		call.append("	GE_INTEGRACION_PG.GE_CONS_SEGURO_PR ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ); "); 
		call.append("END; "); 		
		return call.toString(); 	
	}
	
	//Inicio Inc. 174755/CSR-11002/06-09-2011/FDL
	private String getSQLverificaNumeroDesviado() {
		StringBuffer call = new StringBuffer();	
		call.append("BEGIN "); 
		call.append("? := pv_cambio_simcard_sb_pg.pv_verifica_numero_desviado_fn ( ?, ?, ?, ? ); "); 
		call.append("END; "); 	
		return call.toString(); 		 		
	}	
	//FIN Inc. 174755/CSR-11002/06-09-2011/FDL

	//INICIO CSR-11002 PAH	
	private String getSQLCambioUsoSeries(){
		StringBuffer call = new StringBuffer();		
		call.append("BEGIN "); 
		call.append("VE_PARAMETROS_COMERCIALES_PG.ve_cambio_uso_series_pr ( ?, ?, ?, ?, ?, ? ); "); 
		call.append("END; "); 		
		return call.toString(); 
	}
	//FIN CSR-11002 PAH
	
	
	public CausaCamSerieDTO[] obtenerCausaCambioSerie() throws ProductException {


		logger.debug("obtenerCausaCambioSerie():start");

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		CausaCamSerieDTO[] causasCamSerie;
		String call = getSQLobtenerCausaCambioSerie();
		try {

			conn = getConnectionFromWLSInitialContext(global
					.getJndiForDataSource());

			cstmt = conn.prepareCall(call);
			logger.debug("Parámetros de entrada");
			logger.debug("No utiliza parámetros de entrada");
			cstmt.registerOutParameter(1, oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);	

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
				logger
				.error(" Ocurrió un error al obtener Causa Cambio de Serie ");
				throw new ProductException(String.valueOf(codError),
						numEvento, msgError);
			}

			// obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");

			logger.debug("Recuperando cursor...");
			logger.debug("object="+cstmt.getObject(1));
			ResultSet rs = (ResultSet) cstmt.getObject(1);

			ArrayList lista = new ArrayList();
			while (rs.next()) {
				CausaCamSerieDTO causaCamSerie = new CausaCamSerieDTO();	

				causaCamSerie.setCod_caucaser(rs.getString("cod_caucaser"));
				logger.debug("cod_caucaser="+rs.getString("cod_caucaser"));
				causaCamSerie.setDes_caucaser(rs.getString("des_caucaser"));
				logger.debug("des_caucaser="+rs.getString("des_caucaser"));
				causaCamSerie.setInd_antiguedad(rs.getLong("ind_antiguedad"));
				logger.debug("ind_antiguedad="+rs.getLong("ind_antiguedad"));
				causaCamSerie.setInd_cargo(rs.getLong("ind_cargo"));
				logger.debug("ind_cargo="+rs.getLong("ind_cargo"));
				causaCamSerie.setInd_dev_almacen(rs.getLong("ind_dev_almacen"));
				logger.debug("ind_dev_almacen="+rs.getLong("ind_dev_almacen"));
				causaCamSerie.setCod_estado_dev(rs.getLong("cod_estado_dev"));
				logger.debug("Cod_estado_dev = ["+rs.getLong("cod_estado_dev"));
				causaCamSerie.setIndSeguro(rs.getInt("IND_SEGURO"));
				logger.debug("IND_SEGURO = ["+causaCamSerie.getIndSeguro());
				lista.add(causaCamSerie);

				logger.debug("Largo Lista ["+lista.size());  
			}

			logger.debug("Largo Lista Final ["+lista.size());
			causasCamSerie = (CausaCamSerieDTO[]) ArrayUtl.copiaArregloTipoEspecifico(	lista.toArray(), CausaCamSerieDTO.class);			
			logger.debug("Largo CausasCamSerie ["+causasCamSerie.length );

		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger
			.error(
					"Ocurrió un error general al obtener Causa Cambio de Serie",
					e);
			throw new ProductException(
					"Ocurrió un error general al obtener Causa Cambio de Serie",
					e);
		} finally {
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
		logger.debug("obtenerCausaCambioSerie():end");
		return causasCamSerie;
	}


	public TipoDeContratoDTO[] obtenerTiposDeContrato (SesionDTO sesion) throws ProductException {

		logger.debug("obtenerTiposDeContrato():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		TipoDeContratoDTO[] tiposDeContratos;
		String call;
		
		//call = getSQLobtenerTiposDeContrato();   RRG col 07-03-2009 78629

		try {


			// inicio RRG RRG col 07-03-2009 78629
			if (sesion.getOrigenSerie() !=null || sesion.getOrigenSerie() !="")
			{
				call = getSQLobtenerTiposDeContratoOOSSWeb();
			} else  {
				call = getSQLobtenerTiposDeContrato();
			}
			// fin RRG col 07-03-2009 78629

			logger.debug(call); // RRG col 07-03-2009 78629

			conn = getConnectionFromWLSInitialContext(global
					.getJndiForDataSource());

			cstmt = conn.prepareCall(call);
			logger.debug("Parámetros de entrada");
			logger.debug("sesion.getNumAbonado() ["+sesion.getNumAbonado()+"]");
			logger.debug("sesion.getUsuario().getNom_usuario() ["+sesion.getUsuario().getNom_usuario()+"]");
			logger.debug("sesion.getCod_programa() ["+sesion.getCod_programa()+"]");
			logger.debug("sesion.getNum_version() ["+sesion.getNum_version()+"]");

			logger.debug("sesion.getCod_programa() ["+sesion.getCod_programa()+"]"); // RRG col 07-03-2009 78629
			logger.debug("sesion.getOrigenSerie() ["+sesion.getOrigenSerie()+"]"); // RRG col 07-03-2009 78629

			cstmt.setLong(1, sesion.getNumAbonado());
			cstmt.setString(2, sesion.getUsuario().getNom_usuario());
			cstmt.setString(3, sesion.getCod_programa());
			cstmt.setLong(4, sesion.getNum_version());
			
			cstmt.registerOutParameter(5, oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);	

			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");

			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(6);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(7);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(8);
			logger.debug("numEvento[" + numEvento + "]");

			if (codError != 0) {
				logger
				.error(" Ocurrió un error al recuperar los tipos de contrato");
				throw new ProductException(String.valueOf(codError),
						numEvento, msgError);
			}

			// obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");

			logger.debug("Recuperando cursor...");
			logger.debug("object="+cstmt.getObject(5));
			ResultSet rs = (ResultSet) cstmt.getObject(5);

			ArrayList lista = new ArrayList();
			while (rs.next()) {
				TipoDeContratoDTO tipoDeContrato = new TipoDeContratoDTO();	

				tipoDeContrato.setCod_tipcontrato(rs.getString("cod_tipcontrato"));
				tipoDeContrato.setDes_tipcontrato(rs.getString("des_tipcontrato"));
				tipoDeContrato.setFec_desde(rs.getDate("fec_desde"));
				tipoDeContrato.setFec_desde(rs.getDate("fec_desde"));
				tipoDeContrato.setInd_contseg(rs.getString("ind_contseg"));
				tipoDeContrato.setInd_contcel(rs.getString("ind_contcel"));
				tipoDeContrato.setInd_comodato(rs.getLong("ind_comodato"));
				tipoDeContrato.setCanal_vta(rs.getLong("canal_vta"));
				tipoDeContrato.setMeses_minimo(rs.getLong("meses_minimo"));
				tipoDeContrato.setInd_procequi(rs.getString("ind_procequi"));
				tipoDeContrato.setInd_preciolista(rs.getString("ind_preciolista"));
				tipoDeContrato.setInd_gmc(rs.getString("ind_gmc"));
				tipoDeContrato.setNum_meses(rs.getString("num_meses"));

				lista.add(tipoDeContrato);
			}			
			tiposDeContratos = (TipoDeContratoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(	lista.toArray(), TipoDeContratoDTO.class);

		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger
			.error(
					"Ocurrió un error general al recuperar los tipos de contrato",
					e);
			throw new ProductException(
					"Ocurrió un error general al recuperar los tipos de contrato",
					e);
		} finally {
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
		logger.debug("obtenerTiposDeContrato():end");
		return tiposDeContratos;
	}	

	public BodegaDTO[] obtenerBodegas (SesionDTO sesion) throws ProductException {

		logger.debug("obtenerBodegas():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		BodegaDTO[] bodegas;
		String call = getSQLobtenerBodegas();
		try {

			conn = getConnectionFromWLSInitialContext(global
					.getJndiForDataSource());

			cstmt = conn.prepareCall(call);
			logger.debug("Parámetros de entrada");
			logger.debug("sesion.getCodCliente() ["+sesion.getCodCliente()+"]");
			logger.debug("sesion.getUsuario().getNom_usuario() ["+sesion.getUsuario().getNom_usuario()+"]");
			cstmt.setLong(1, sesion.getCodCliente() );
			cstmt.setString(2, sesion.getUsuario().getNom_usuario());			
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
				logger
				.error(" Ocurrió un error general al obtener Bodegas");
				throw new ProductException(String.valueOf(codError),
						numEvento, msgError);
			}

			// obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");

			logger.debug("Recuperando cursor...");
			logger.debug("object="+cstmt.getObject(3));
			ResultSet rs = (ResultSet) cstmt.getObject(3);

			ArrayList lista = new ArrayList();
			while (rs.next()) {
				BodegaDTO bodega = new BodegaDTO();	

				bodega.setCod_bodega(rs.getString(1));
				bodega.setDes_bodega(rs.getString(1));
				bodega.setTip_bodega(rs.getLong(3));
				bodega.setCod_direccion(rs.getLong(4));
				bodega.setInd_asignada(rs.getLong(5));
				bodega.setCod_bodega_padre(rs.getLong(6));
				bodega.setNum_telefono1(rs.getString(7));
				bodega.setNum_telefono2(rs.getString(8));
				bodega.setNum_fax(rs.getString(9));
				bodega.setNom_responsable(rs.getString(10));
				bodega.setCod_grpconcepto(rs.getLong(11));	

				lista.add(bodega);
			}			
			bodegas = (BodegaDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), BodegaDTO.class);

		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger
			.error(
					"Ocurrió un error general al Obtener Bodegas",
					e);
			throw new ProductException(
					"Ocurrió un error general al obtener Bodegas",
					e);
		} finally {
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
		logger.debug("obtenerBodegas():end");
		return bodegas;
	}	

	public TecnologiaDTO[] obtenerTecnologia () throws ProductException {

		logger.debug("obtenerTecnologia():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		TecnologiaDTO[] Tecnologias;
		String call = getSQLobtenerTecnologia();
		try {

			conn = getConnectionFromWLSInitialContext(global
					.getJndiForDataSource());

			cstmt = conn.prepareCall(call);
			logger.debug("Parámetros de entrada");
			logger.debug("No utiliza parámetros de entrada");
			cstmt.registerOutParameter(1, oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);	

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
				logger
				.error(" Ocurrió un error general al Obtener Tecnologia");
				throw new ProductException(String.valueOf(codError),
						numEvento, msgError);
			}

			// obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");

			logger.debug("Recuperando cursor...");
			logger.debug("object="+cstmt.getObject(1));
			ResultSet rs = (ResultSet) cstmt.getObject(1);

			ArrayList lista = new ArrayList();
			while (rs.next()) {
				TecnologiaDTO Tecnologia = new TecnologiaDTO();	

				Tecnologia.setCod_tecnologia(rs.getString(1));
				Tecnologia.setDes_tecnologia(rs.getString(2));	

				lista.add(Tecnologia);
			}			
			Tecnologias = (TecnologiaDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), TecnologiaDTO.class);

		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger
			.error(
					"Ocurrió un error general al Obtener Tecnologia",
					e);
			throw new ProductException(
					"Ocurrió un error general al Obtener Tecnologia",
					e);
		} finally {
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
		logger.debug("obtenerTecnologia():end");
		return Tecnologias;
	}



	public UsoArticuloDTO[] obtenerUsos () throws ProductException {

		logger.debug("obtenerUsos():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		UsoArticuloDTO[] UsosArticulos;
		String call = getSQLobtenerUsos();
		try {

			conn = getConnectionFromWLSInitialContext(global
					.getJndiForDataSource());

			cstmt = conn.prepareCall(call);
			logger.debug("Parámetros de entrada");
			logger.debug("No utiliza parámetros de entrada");
			cstmt.registerOutParameter(1, oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);	

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
				logger
				.error(" Ocurrió un error general al obtener Usos");
				throw new ProductException(String.valueOf(codError),
						numEvento, msgError);
			}

			// obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");

			logger.debug("Recuperando cursor...");
			logger.debug("object="+cstmt.getObject(1));
			ResultSet rs = (ResultSet) cstmt.getObject(1);

			ArrayList lista = new ArrayList();
			while (rs.next()) {
				UsoArticuloDTO UsoArticulo = new UsoArticuloDTO();	

				UsoArticulo.setCod_uso(rs.getInt(1));
				UsoArticulo.setDes_uso(rs.getString(2));	

				lista.add(UsoArticulo);
			}			
			UsosArticulos = (UsoArticuloDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), UsoArticuloDTO.class);

		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger
			.error(
					"Ocurrió un error general al obtener Usos",
					e);
			throw new ProductException(
					"Ocurrió un error general al obtener Usos",
					e);
		} finally {
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
		logger.debug("obtenerusos():end");
		return UsosArticulos;
	}



	public MesesProrrogasDTO[] obtenerMesesProrroga () throws ProductException {

		logger.debug("obtenerMesesProrroga():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		MesesProrrogasDTO[] MesesProrrogas;
		String call = getSQLobtenerMesesProrroga();
		try {

			conn = getConnectionFromWLSInitialContext(global
					.getJndiForDataSource());

			cstmt = conn.prepareCall(call);
			logger.debug("Parámetros de entrada");
			logger.debug("No utiliza parámetros de entrada");
			cstmt.registerOutParameter(1, oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);	

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
				logger
				.error(" Ocurrió un error general al obtener Meses Prorroga");
				throw new ProductException(String.valueOf(codError),
						numEvento, msgError);
			}

			// obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");

			logger.debug("Recuperando cursor...");
			logger.debug("object="+cstmt.getObject(1));
			ResultSet rs = (ResultSet) cstmt.getObject(1);

			ArrayList lista = new ArrayList();
			while (rs.next()) {
				MesesProrrogasDTO Mesprorro = new MesesProrrogasDTO();	

				Mesprorro.setNum_meses(rs.getInt(1));
				Mesprorro.setDes_prorroga(rs.getString(2));

				lista.add(Mesprorro);
			}			
			MesesProrrogas = (MesesProrrogasDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), MesesProrrogasDTO.class);

		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger
			.error(
					"Ocurrió un error general al obtener Meses Prorroga",
					e);
			throw new ProductException(
					"Ocurrió un error general al obtener Meses Prorroga",
					e);
		} finally {
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
		logger.debug("obtenerMesesProrroga():end");
		return MesesProrrogas;
	}
	
	
	public ModalidadPagoDTO[] obtenerModalidadPago (SesionDTO sesion, CausaCamSerieDTO causaCamSerie) throws ProductException {

		logger.debug("obtenerModalidadPago():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		ModalidadPagoDTO[] modalidadespago;
		String call = getSQLobtenerModalidadPago();
		try {
			logger.debug(call);
			conn = getConnectionFromWLSInitialContext(global
					.getJndiForDataSource());

			cstmt = conn.prepareCall(call);
			
			logger.debug("Parámetros de entrada");
			logger.debug("sesion.getNumAbonado() ["+sesion.getNumAbonado()+"]");
			logger.debug("sesion.getUsuario().getNom_usuario() ["+sesion.getUsuario().getNom_usuario()+"]");
			logger.debug("sesion.getCod_programa() ["+sesion.getCod_programa()+"]");
			logger.debug("sesion.getNum_version() ["+sesion.getNum_version()+"]");
			logger.debug("causaCamSerie.getCod_caucaser()["+causaCamSerie.getCod_caucaser()+"]");
			cstmt.setLong  (1, sesion.getNumAbonado());
			cstmt.setString(2, sesion.getUsuario().getNom_usuario());
			cstmt.setString(3, sesion.getCod_programa());
			cstmt.setLong  (4, sesion.getNum_version());			
			cstmt.setString(5, causaCamSerie.getCod_caucaser());								
			cstmt.registerOutParameter(6, oracle.jdbc.driver.OracleTypes.CURSOR);
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

			if (codError != 0) {
				logger
				.error(" Ocurrió un error general al obtener modalidad de pago");
				throw new ProductException(String.valueOf(codError),
						numEvento, msgError);
			}

			// obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");

			logger.debug("Recuperando cursor...");
			logger.debug("object="+cstmt.getObject(6));
			ResultSet rs = (ResultSet) cstmt.getObject(6);

			ArrayList lista = new ArrayList();
			while (rs.next()) {
				ModalidadPagoDTO modalidadPago = new ModalidadPagoDTO();	
				modalidadPago.setCod_modventa(rs.getLong(1));
				logger.debug("modalidadPago.getCod_modventa(): ..."+modalidadPago.getCod_modventa());
				modalidadPago.setDes_modventa(rs.getString(2)); 
				logger.debug("modalidadPago.getDes_modventa(): ..."+modalidadPago.getDes_modventa());
				modalidadPago.setInd_cuotas(rs.getLong(3)); 
				logger.debug("modalidadPago.getInd_cuotas(): ..."+modalidadPago.getInd_cuotas());
				modalidadPago.setInd_pagado(rs.getLong(4)); 
				logger.debug("modalidadPago.getInd_pagado(): ..."+modalidadPago.getInd_pagado());
				modalidadPago.setCod_caupago(rs.getLong(5)); 
				logger.debug("modalidadPago.getCod_caupago(): ..."+modalidadPago.getCod_caupago());
				modalidadPago.setInd_abono(rs.getLong(6));
				logger.debug("modalidadPago.getInd_abono(): ..."+modalidadPago.getInd_abono());
				lista.add(modalidadPago);
			}			
			logger.debug("Cantidad de modalidades de pago: ..."+lista.size());
			modalidadespago = (ModalidadPagoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), ModalidadPagoDTO.class);
			logger.debug("Cantidad de modalidades de pago: ..."+modalidadespago.length);
		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger
			.error(
					"Ocurrió un error general al obtener modalidad de pago",
					e);
			throw new ProductException(
					"Ocurrió un error general al obtener modalidad de pago",
					e);
		} finally {
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
		logger.debug("obtenerMesesProrroga():end");
		return modalidadespago;
	}
	
	public ModalidadPagoDTO[] obtenerModalidadPagoSimcard (SesionDTO sesion, CausaCamSerieDTO causaCamSerie) throws ProductException {

		logger.debug("obtenerModalidadPagoSimcard():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		ModalidadPagoDTO[] modalidadespago;
		String call = getSQLobtenerModalidadPagoSimcard();
		try {

			conn = getConnectionFromWLSInitialContext(global
					.getJndiForDataSource());

			cstmt = conn.prepareCall(call);
			
			logger.debug("Parámetros de entrada");
			logger.debug("sesion.getNumAbonado()["+sesion.getNumAbonado()+"]");
			logger.debug("sesion.getUsuario().getNom_usuario()["+sesion.getUsuario().getNom_usuario()+"]");
			logger.debug("sesion.getCod_programa()["+sesion.getCod_programa()+"]");
			logger.debug("sesion.getNum_version()["+sesion.getNum_version()+"]");
			logger.debug("causaCamSerie.getCod_caucaser()["+causaCamSerie.getCod_caucaser()+"]");
			cstmt.setLong  (1, sesion.getNumAbonado());
			cstmt.setString(2, sesion.getUsuario().getNom_usuario());
			cstmt.setString(3, sesion.getCod_programa());
			cstmt.setLong  (4, sesion.getNum_version());			
			cstmt.setString(5, causaCamSerie.getCod_caucaser());								
			cstmt.registerOutParameter(6, oracle.jdbc.driver.OracleTypes.CURSOR);
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

			if (codError != 0) {
				logger
				.error(" Ocurrió un error general al obtener modalidad de pago Simcard");
				throw new ProductException(String.valueOf(codError),
						numEvento, msgError);
			}

			// obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");

			logger.debug("Recuperando cursor...");
			logger.debug("object="+cstmt.getObject(6));
			ResultSet rs = (ResultSet) cstmt.getObject(6);

			ArrayList lista = new ArrayList();
			while (rs.next()) {
				ModalidadPagoDTO modalidadPago = new ModalidadPagoDTO();	


				modalidadPago.setCod_modventa(rs.getLong(1));
				modalidadPago.setDes_modventa(rs.getString(2)); 
				modalidadPago.setInd_cuotas(rs.getLong(3)); 
				modalidadPago.setInd_pagado(rs.getLong(4)); 
				modalidadPago.setCod_caupago(rs.getLong(5)); 
				modalidadPago.setInd_abono(rs.getLong(6));
								
				lista.add(modalidadPago);
			}			
			modalidadespago = (ModalidadPagoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), ModalidadPagoDTO.class);

		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger
			.error(
					"Ocurrió un error general al obtener modalidad de pago Simcard",
					e);
			throw new ProductException(
					"Ocurrió un error general al obtener modalidad de pago Simcard",
					e);
		} finally {
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
		logger.debug("obtenerModalidadPagoSimcard():end");
		return modalidadespago;
	}	
	
	public TipoTerminalDTO[] obtenerTipoterminal (TecnologiaDTO tecnologia) throws ProductException {

		logger.debug("obtenerTipoterminal():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		TipoTerminalDTO[] tipoTerminales;
		String call = getSQLobtenertipoTerminal();
		try {

			conn = getConnectionFromWLSInitialContext(global
					.getJndiForDataSource());

			cstmt = conn.prepareCall(call);
			
			logger.debug("Parámetros de entrada");
			logger.debug("tecnologia.getCod_tecnologia()["+tecnologia.getCod_tecnologia()+"]");
			cstmt.setString(1, tecnologia.getCod_tecnologia());								
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
				logger
				.error(" Ocurrió un error general al obtener tipo de terminal");
				throw new ProductException(String.valueOf(codError),
						numEvento, msgError);
			}

			// obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");

			logger.debug("Recuperando cursor...");
			logger.debug("object="+cstmt.getObject(2));
			ResultSet rs = (ResultSet) cstmt.getObject(2);

			ArrayList lista = new ArrayList();
			while (rs.next()) {
				TipoTerminalDTO TipoTerminal = new TipoTerminalDTO();	
				
				TipoTerminal.setTip_terminal(rs.getString(1));
				TipoTerminal.setDes_terminal(rs.getString(2));
				
				lista.add(TipoTerminal);
			}			
			tipoTerminales = (TipoTerminalDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), TipoTerminalDTO.class);

		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger
			.error(
					"Ocurrió un error general al obtener tipo de terminal",
					e);
			throw new ProductException(
					"Ocurrió un error general al obtener tipo de terminal",
					e);
		} finally {
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
		logger.debug("obtenerTipoterminal():end");
		return tipoTerminales;
	}	
	
		
	public CuotaDTO[] obtenerCuotas (SesionDTO sesion, ModalidadPagoDTO modalidadPago) throws ProductException {

		logger.debug("obtenerCuotas():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		CuotaDTO[] cuotas;
		String call = getSQLobtenerCuotas();
		try {

			conn = getConnectionFromWLSInitialContext(global
					.getJndiForDataSource());

			cstmt = conn.prepareCall(call);
			
			logger.debug("Parámetros de entrada");
			logger.debug("sesion.getUsuario().getNom_usuario() ["+sesion.getUsuario().getNom_usuario()+"]");
			logger.debug("sesion.getUsuario().getNom_usuario()["+sesion.getUsuario().getNom_usuario()+"]");
			logger.debug("sesion.getNum_version() ["+sesion.getNum_version()+"]");
			logger.debug("modalidadPago.getCod_modventa() ["+modalidadPago.getCod_modventa()+"]");
			cstmt.setString(1, sesion.getUsuario().getNom_usuario());
			cstmt.setString(2, sesion.getCod_programa());
			cstmt.setLong  (3, sesion.getNum_version());
			cstmt.setLong  (4, modalidadPago.getCod_modventa());			
			cstmt.registerOutParameter(5, oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);	

			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");

			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(6);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(7);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(8);
			logger.debug("numEvento[" + numEvento + "]");

			if (codError != 0) {
				logger
				.error(" Ocurrió un error general al obtener cuotas");
				throw new ProductException(String.valueOf(codError),
						numEvento, msgError);
			}

			// obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");

			logger.debug("Recuperando cursor...");
			logger.debug("object="+cstmt.getObject(5));
			ResultSet rs = (ResultSet) cstmt.getObject(5);

			ArrayList lista = new ArrayList();
			while (rs.next()) {
				CuotaDTO cuota = new CuotaDTO();	
				
				cuota.setCod_cuota(rs.getString(1));
				cuota.setDes_cuota(rs.getString(2));
				cuota.setNum_cuota(rs.getLong(3));
				cuota.setPor_interes(rs.getLong(4));
				cuota.setNum_dias(rs.getLong(5));
				cuota.setInd_forminteres(rs.getLong(6));
				
				lista.add(cuota);
			}			
			cuotas = (CuotaDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), CuotaDTO.class);

		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger
			.error(
					"Ocurrió un error general al obtener cuotas",
					e);
			throw new ProductException(
					"Ocurrió un error general al obtener cuotas",
					e);
		} finally {
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
		logger.debug("obtenerCuotas():end");
		return cuotas;
	}	
	
	
	public CategoriaTributariaDTO[] obtenerCatTributaria (SesionDTO sesion) throws ProductException {

		logger.debug("obtenerCatTributaria():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		CategoriaTributariaDTO[] categoriasTributarias;
		String call = getSQLobtenerCatTributaria();
		try {

			conn = getConnectionFromWLSInitialContext(global
					.getJndiForDataSource());

			cstmt = conn.prepareCall(call);
			logger.debug("Parámetros de entrada");
			logger.debug("sesion.getCodCliente() ["+sesion.getCodCliente()+"]");
			cstmt.setLong(1, sesion.getCodCliente());			
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
				logger
				.error(" Ocurrió un error general al obtener la categoria tributaria");
				throw new ProductException(String.valueOf(codError),
						numEvento, msgError);
			}

			// obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");

			logger.debug("Recuperando cursor...");
			logger.debug("object="+cstmt.getObject(2));
			ResultSet rs = (ResultSet) cstmt.getObject(2);

			ArrayList lista = new ArrayList();
			while (rs.next()) {
				
				CategoriaTributariaDTO categoriaTributaria = new CategoriaTributariaDTO();
				
				categoriaTributaria.setCod_tipdocum(rs.getLong(1));
				categoriaTributaria.setDes_tipdocum(rs.getString(2));
				categoriaTributaria.setTip_foliacion(rs.getString(3));
				categoriaTributaria.setCod_catribut(rs.getString(4));
				
				lista.add(categoriaTributaria);
			}			
			categoriasTributarias = (CategoriaTributariaDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), CategoriaTributariaDTO.class);

		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger
			.error(
					"Ocurrió un error general al obtener la categoria tributaria",
					e);
			throw new ProductException(
					"Ocurrió un error general al obtener la categoria tributaria",
					e);
		} finally {
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
		logger.debug("obtenerCuotas():end");
		return categoriasTributarias;
	}	
	
	
	public UsosVentaDTO[] obtenerUsosVenta () throws ProductException {

		logger.debug("obtenerUsosVenta():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		UsosVentaDTO[] UsosVenta;
		String call = getSQLobtenerUsosVenta();
		try {

			conn = getConnectionFromWLSInitialContext(global
					.getJndiForDataSource());

			cstmt = conn.prepareCall(call);
			logger.debug("Parámetros de entrada");
			logger.debug("No utiliza parámetros de entrada");
			cstmt.registerOutParameter(1, oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);	

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
				logger
				.error(" Ocurrió un error general al obtener usos para venta");
				throw new ProductException(String.valueOf(codError),
						numEvento, msgError);
			}

			// obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");

			logger.debug("Recuperando cursor...");
			logger.debug("object="+cstmt.getObject(1));
			ResultSet rs = (ResultSet) cstmt.getObject(1);

			ArrayList lista = new ArrayList();
			while (rs.next()) {
				
				UsosVentaDTO UsoVenta = new UsosVentaDTO();							
				
				UsoVenta.setCod_uso(rs.getLong(1));
				UsoVenta.setDes_uso(rs.getString(2));
				UsoVenta.setInd_restplan(rs.getLong(3));				
				UsoVenta.setInd_cargopro(rs.getLong(4));				
				UsoVenta.setInd_usoventa(rs.getLong(5));
				UsoVenta.setNum_dias_hibernacion(rs.getLong(6));
				
				lista.add(UsoVenta);
			}			
			UsosVenta = (UsosVentaDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), UsosVentaDTO.class);

		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger
			.error(
					"Ocurrió un error general al obtener usos para venta",
					e);
			throw new ProductException(
					"Ocurrió un error general al obtener usos para venta",
					e);
		} finally {
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
		logger.debug("obtenerUsosVenta():end");
		return UsosVenta;
	}	
	
	
	
	public CentralDTO[] obtenerCentralTecnologiaHlr (SerieDTO serie, TecnologiaDTO tecnologia) throws ProductException {

		logger.debug("obtenerCentralTecnologiaHlr():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		CentralDTO[] centrales;
		String call = getSQLobtenerCentralTecnologiaHlr();
		try {

			conn = getConnectionFromWLSInitialContext(global
					.getJndiForDataSource());

			cstmt = conn.prepareCall(call);
			logger.debug("Parámetros de entrada");
			logger.debug("tecnologia.getCod_tecnologia() ["+tecnologia.getCod_tecnologia()+"]");
			cstmt.setString(1, tecnologia.getCod_tecnologia());
			cstmt.setString(2, serie.getNum_serie());
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);			
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
				logger
				.error(" Ocurrió un error general al obtener Central Tecnologia Hlr");
				throw new ProductException(String.valueOf(codError),
						numEvento, msgError);
			}

			// obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");

			logger.debug("Recuperando cursor...");
			logger.debug("object="+cstmt.getObject(3));
			ResultSet rs = (ResultSet) cstmt.getObject(3);

			ArrayList lista = new ArrayList();
			while (rs.next()) {
				
				CentralDTO central = new CentralDTO();
				  
				central.setCod_central(rs.getLong(1));
				central.setCod_producto(rs.getLong(2));
				central.setNom_central(rs.getString(3));
				central.setCod_nemotec(rs.getString(3));
				central.setCod_alm(rs.getString(5));
				central.setNum_maxintentos(rs.getLong(6));
				central.setCod_sistema(rs.getLong(7));
				central.setCod_cobertura(rs.getLong(8));
				central.setTie_respuesta(rs.getLong(9));
				central.setNodocom(rs.getString(10));
				central.setCod_tecnologia(rs.getString(11));
				central.setCod_hlr(rs.getString(12));						
				
				lista.add(central);
			}			
			centrales = (CentralDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), CentralDTO.class);

		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger
			.error(
					"Ocurrió un error general al obtener Central Tecnologia Hlr",
					e);
			throw new ProductException(
					"Ocurrió un error general al obtener Central Tecnologia Hlr",
					e);
		} finally {
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
		logger.debug("obtenerCentralTecnologiaHlr():end");
		return centrales;
	}				
	
	public void validaCausaCamSerie (SesionDTO sesion, CausaCamSerieDTO causaCamSerie) throws ProductException {

		logger.debug("validaCausaCamSerie():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		String call = getSQLvalidaCausaCamSerie();
		try {

			conn = getConnectionFromWLSInitialContext(global
					.getJndiForDataSource());

			cstmt = conn.prepareCall(call);
			logger.debug("Parámetros de entrada");
			logger.debug("sesion.getNumAbonado() ["+sesion.getNumAbonado()+"]");
			logger.debug("sesion.getUsuario().getNom_usuario() ["+sesion.getUsuario().getNom_usuario()+"]");
			logger.debug("sesion.getCod_programa() ["+sesion.getCod_programa()+"]");
			logger.debug("sesion.getNum_version() ["+sesion.getNum_version()+"]");
			logger.debug("causaCamSerie.getCod_caucaser() ["+causaCamSerie.getCod_caucaser()+"]");
			cstmt.setLong(1, sesion.getNumAbonado());
			cstmt.setString(2, sesion.getUsuario().getNom_usuario());
			cstmt.setString(3, sesion.getCod_programa());
			cstmt.setLong(4, sesion.getNum_version());
			cstmt.setString(5, causaCamSerie.getCod_caucaser());			
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);	

			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");

			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(6);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(7);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(8);
			logger.debug("numEvento[" + numEvento + "]");

			if (codError != 0) {
				logger
				.error(" Ocurrió un error general al Validar causa cambio de serie");
				throw new ProductException(String.valueOf(codError),
						numEvento, msgError);
			}


		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger
			.error(
					"Ocurrió un error general al Validar causa cambio de serie",
					e);
			throw new ProductException(
					"Ocurrió un error general al Validar causa cambio de serie",
					e);
		} finally {
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
		logger.debug("validaCausaCamSerie():end");
	}
	
	public MensajeRetornoDTO ejecutaRestrccion(RestriccionesDTO restricciones) throws ProductException {
		
		logger.debug("ejecutaRestrccion():start");
		MensajeRetornoDTO mensajeRestriccion = new MensajeRetornoDTO(); 
		int codError = 0;
		String msgError = null;
		int numEvento = 0;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLejecutaRestrccion();
		try {
				
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());			
			cstmt = conn.prepareCall(call);
			
			logger.debug("Parámetros de entrada");
			logger.debug("restricciones.getCod_modulo() ["+restricciones.getCod_modulo()+"]");
			logger.debug("restricciones.getCod_actuacion() ["+restricciones.getCod_actuacion()+"]");
			logger.debug("restricciones.getCod_evento() ["+restricciones.getCod_evento()+"]");
			logger.debug("restricciones.getParam_entrada() ["+restricciones.getParam_entrada()+"]");
			cstmt.setString(1, restricciones.getCod_modulo());
			cstmt.setString(2, restricciones.getCod_actuacion() );
			cstmt.setString(3, restricciones.getCod_evento());
			cstmt.setString(4, restricciones.getParam_entrada());			
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
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
			
			
			mensajeRestriccion.setCodigo(cstmt.getInt(5));
			mensajeRestriccion.setMensaje(cstmt.getString(6));
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al ejecutar restricción");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}

			
		} catch (ProductException e) {
			logger.debug("CustomerException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al ejecutar restricción", e);
			throw new ProductException("Ocurrió un error general al ejecutar restricción",e);
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
		logger.debug("ejecutaRestrccion():end");	
		return mensajeRestriccion;
	}	
	
	
	public RestriccionesDTO obtenerEventosRestriccion(RestriccionesDTO restricciones) throws ProductException {

		String[] eventos; 
		
		logger.debug("obtenerEventosRestriccion():start"); 
		int codError = 0;
		String msgError = null;
		int numEvento = 0;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerEventosRestriccion();
		try {
				
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());			
			cstmt = conn.prepareCall(call);
			logger.debug("Parámetros de entrada");
			logger.debug("restricciones.getCod_actuacion() ["+restricciones.getCod_actuacion()+"]");
			cstmt.setString(1, restricciones.getCod_actuacion() );
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
			
			
			logger.debug("Recuperando cursor...");
			logger.debug("object="+cstmt.getObject(2));
			ResultSet rs = (ResultSet) cstmt.getObject(2);

			ArrayList lista = new ArrayList();
			while (rs.next()) {
				
				String evento = new String();				  
				evento = rs.getString(1);																
				lista.add(evento);
			}			
			eventos = (String[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), String.class);
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al obtener eventos de restricción");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}

			
		} catch (ProductException e) {
			logger.debug("CustomerException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener eventos de restricción", e);
			throw new ProductException("Ocurrió un error general al obtener eventos de restricción",e);
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
		logger.debug("obtenerEventosRestriccion():end");	
		return restricciones;
	}	
	
	public void verificaPlancomercial(SesionDTO sesion, CausaCamSerieDTO causaCamSerie, ModalidadPagoDTO modalidadPago, UsoArticuloDTO usoArticulo, TipoTerminalDTO tipoTerminal, SerieDTO serie) throws ProductException {
	 
		
		logger.debug("verificaPlancomercial():start"); 
		int codError = 0;
		String msgError = null;
		int numEvento = 0;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLverificaPlancomercial();
		try {
		
				
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());			
			cstmt = conn.prepareCall(call);
			
			logger.debug("Parámetros de entrada");
			logger.debug("sesion.getNumAbonado() ["+sesion.getNumAbonado()+"]");
			logger.debug("causaCamSerie.getCod_caucaser() ["+causaCamSerie.getCod_caucaser()+"]");
			logger.debug("modalidadPago.getCod_modventa() ["+modalidadPago.getCod_modventa()+"]");
			logger.debug("usoArticulo.getCod_uso() ["+usoArticulo.getCod_uso()+"]");
			logger.debug("tipoTerminal.getTip_terminal() ["+tipoTerminal.getTip_terminal()+"]");
			logger.debug("serie.getNum_serie() ["+serie.getNum_serie()+"]");
			cstmt.setLong(1, sesion.getNumAbonado());
			cstmt.setString(2, causaCamSerie.getCod_caucaser());
			cstmt.setLong(3, modalidadPago.getCod_modventa());			
			cstmt.setLong(4, usoArticulo.getCod_uso());
			cstmt.setString(5, tipoTerminal.getTip_terminal());
			cstmt.setString(6, serie.getNum_serie());
			
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
						
			if (codError != 0) {
				logger.error(" Ocurrió un error al verificar el Plan comercial");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}

			
		} catch (ProductException e) {
			logger.debug("CustomerException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al verificar el Plan comercial", e);
			throw new ProductException("Ocurrió un error general al verificar el Plan comercial",e);
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
		logger.debug("verificaPlancomercial():end");	
	}	
/**********************************************************************************************************************/
	public ArticuloDTO[] obtenerListaArticulos (ArticuloDTO articuloDTO) throws ProductException {

		logger.debug("obtenerListaArticulos():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		ArticuloDTO[] articulosDTO;
		String call = getSQLobtenerlistArticulos();
		try {

			conn = getConnectionFromWLSInitialContext(global
					.getJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			logger.debug("Parámetros de entrada");
			logger.debug("articuloDTO.getCod_producto ["+articuloDTO.getCod_producto()+"]");
			logger.debug("articuloDTO.getTip_terminal ["+articuloDTO.getTip_terminal()+"]");
			cstmt.setInt(1, articuloDTO.getCod_producto());
			cstmt.setString(2, articuloDTO.getTip_terminal());
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
				logger
				.error(" Ocurrió un error general al obtener lista de Artículos");
				throw new ProductException(String.valueOf(codError),
						numEvento, msgError);
			}

			// obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");

			logger.debug("Recuperando cursor...");
			logger.debug("object="+cstmt.getObject(3));
			ResultSet rs = (ResultSet) cstmt.getObject(3);

			ArrayList lista = new ArrayList();
			while (rs.next()) {
				
				ArticuloDTO articulo = new ArticuloDTO();
				articulo.setCod_articulo(rs.getInt(1));
				articulo.setDes_articulo(rs.getString(2));
				articulo.setMes_garantia(rs.getInt(3));
				articulo.setCod_modelo(rs.getString(4));
				articulo.setCod_fabricante(rs.getInt(5));
				articulo.setRef_fabricante(rs.getString(6));
									
				
				lista.add(articulo);
			}			
			articulosDTO = (ArticuloDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), ArticuloDTO.class);

		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger
			.error(
					"Ocurrió un error general al obtener lista de Artículos",
					e);
			throw new ProductException(
					"Ocurrió un error general al obtener lista de Artículos",
					e);
		} finally {
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
		logger.debug("obtenerListaArticulos():end");
		return articulosDTO;
	}
/*************************************************************************************************************************/
	
public RetornoDTO verificaPlanComercialTerminal(ParametrosVerificaPlanComercialDTO parametros) throws ProductException {
	 
		logger.debug("verificaPlanComercialTerminal():start");
		RetornoDTO retValue=new RetornoDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLVerificaPlanComercialTerminal();
		try {
		
				
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());			
			cstmt = conn.prepareCall(call);
			
			logger.debug("Parámetros de entrada");
			logger.debug("SQL["+call+"]");
			logger.debug("Numero Abonado 		["+parametros.getNumAbonado()+"]");
			logger.debug("Nombre Usuario 		["+parametros.getNomUsuario()+"]");
			logger.debug("Codigo Programa		["+parametros.getCodPrograma()+"]");
			logger.debug("Numero version 		["+parametros.getNumVersion()+"]");
			logger.debug("Codigo Causa   		["+parametros.getCodCausaServicio()+"]");
			
			logger.debug("Codigo Modalidad Venta["+parametros.getCodModVenta()+"]");
			logger.debug("Codigo Uso 			["+parametros.getCodUso()+"]");
			logger.debug("Tipo Terminal  		["+parametros.getTipTerminal()+"]");
			logger.debug("Numero Serie 	 		["+parametros.getNumSerie()+"]");
			logger.debug("Codigo Tipo Contrato 	["+parametros.getCodTipContrato()+"]");
			logger.debug("Codigo tecnologia 	["+parametros.getCodTecnologia()+"]");
					
			
			cstmt.setLong(1,parametros.getNumAbonado());
			cstmt.setString(2,parametros.getNomUsuario());
			cstmt.setString(3,parametros.getCodPrograma());
			cstmt.setString(4,parametros.getNumVersion());
			cstmt.setString(5,parametros.getCodCausaServicio());
			cstmt.setLong(6,parametros.getCodModVenta());
			cstmt.setString(7,parametros.getCodUso());
			cstmt.setString(8,parametros.getTipTerminal());
			cstmt.setString(9,parametros.getNumSerie());
			cstmt.setString(10,parametros.getCodTipContrato());
			cstmt.setString(11,parametros.getCodTecnologia());
			//cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(12, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(14, java.sql.Types.NUMERIC);	
			cstmt.registerOutParameter(15, java.sql.Types.NUMERIC);
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(12);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(13);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(14);
			logger.debug("numEvento[" + numEvento + "]");
						
			if (codError != 0) {
				logger.error(" Ocurrió un error al verificar el Plan comercial");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}
			retValue.setResultado(cstmt.getInt(15)==1?true:false);

			
		} catch (ProductException e) {
			logger.debug("CustomerException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al verificar el Plan comercial", e);
			throw new ProductException("Ocurrió un error general al verificar el Plan comercial",e);
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
		
		logger.debug("verificaPlancomercial():end");
		return retValue;
	}
/*************************************************************************************************************************/


public RetornoDTO verificaConcFactGarantia(ParametroDTO parametrosDTO )throws GeneralException{
	 
	logger.debug("verificaConcFactGarantia():start");
	RetornoDTO retValue=new RetornoDTO();
	int codError = 0;
	String msgError = null;
	int numEvento = 0;		
	Connection conn = null;
	CallableStatement cstmt = null;
	
	String call = getSQLVerificaConcFactGarantia();
	try {
	
		conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());			
		cstmt = conn.prepareCall(call);
		
		logger.debug("Parámetros de entrada");
		logger.debug("SQL["+call+"]");
		
		logger.debug("Parametro CONCEPTO GARANTIA 	["+parametrosDTO.getNomParametro()+"]");
		cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);
		cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);	
		cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
		cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
		logger.debug("execute:antes");
		cstmt.execute();
		logger.debug("execute:despues");
		
		logger.debug("Recuperando salidas");
		codError = cstmt.getInt(1);
		logger.debug("codError[" + codError + "]");
		msgError = cstmt.getString(2);
		logger.debug("msgError[" + msgError + "]");
		numEvento = cstmt.getInt(3);
		logger.debug("numEvento[" + numEvento + "]");
					
		if (codError != 0) {
			logger.error(" Ocurrió un error al verificar el concepto facturable garantía");
			throw new ProductException(String.valueOf(codError),numEvento, msgError);
		}
		retValue.setResultado(cstmt.getInt(4)==1?true:false);

		
	} catch (ProductException e) {
		logger.debug("CustomerException");
		String loge = StackTraceUtl.getStackTrace(e);
		logger.debug("log error[" + loge + "]");
		throw e;
		
	}
	catch (Exception e) {
		logger.error("Ocurrió un error general al verificar el concepto facturable garantía", e);
		throw new ProductException("Ocurrió un error general al verificar el concepto facturable garantía",e);
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
	
	logger.debug("verificaConcFactGarantia():end");
	return retValue;
}

/*************************************************************************************************************************/
public RetornoDTO validaSeleccionCausa(ParametrosCambioSerieDTO parametrosCambioSerieDTO )throws GeneralException{
	 
	logger.debug("validaSeleccionCausa():start");
	RetornoDTO retValue=new RetornoDTO();
	int codError = 0;
	String msgError = null;
	int numEvento = 0;		
	Connection conn = null;
	CallableStatement cstmt = null;
	
	String call = getSQLValidaSeleccionCausa();
	String msjError= "Ocurrió un error al verificar la seleccion de causa";	
	try {
	
		conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());			
		cstmt = conn.prepareCall(call);
		
		logger.debug("Parámetros de entrada");
		logger.debug("SQL["+call+"]");
		
		logger.debug("Indicador de Procedencia 	["+parametrosCambioSerieDTO.getIndProcEquipo()+"]");
		logger.debug("Código de Causa 	["+parametrosCambioSerieDTO.getCodCausa()+"]");
		logger.debug("Numero Serie	["+parametrosCambioSerieDTO.getNumSerieEquipo()+"]");
		logger.debug("Numero Abonado	["+parametrosCambioSerieDTO.getNumAbonado()+"]");
		logger.debug("Nombre Tabla 	["+parametrosCambioSerieDTO.getNomTabla()+"]");
		logger.debug("Nombre Usuario["+parametrosCambioSerieDTO.getNomUsuario()+"]");
		cstmt.setString(1, parametrosCambioSerieDTO.getIndProcEquipo());
		cstmt.setString(2, parametrosCambioSerieDTO.getCodCausa());
		cstmt.setString(3, parametrosCambioSerieDTO.getNumSerieEquipo());
		cstmt.setLong(4, parametrosCambioSerieDTO.getNumAbonado());
		cstmt.setString(5, parametrosCambioSerieDTO.getNomTabla());
		cstmt.setString(6, parametrosCambioSerieDTO.getNomUsuario());
		cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
		cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);	
		cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
		cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);
		logger.debug("execute:antes");
		cstmt.execute();
		logger.debug("execute:despues");
		

		logger.debug("Recuperando salidas");
		codError = cstmt.getInt(8);
		logger.debug("codError[" + codError + "]");
		msgError = cstmt.getString(9);
		logger.debug("msgError[" + msgError + "]");
		numEvento = cstmt.getInt(10);
		logger.debug("numEvento[" + numEvento + "]");
				
		if (codError != 0) {
			logger.error(msjError);
			throw new ProductException(String.valueOf(codError),numEvento, msgError);
		}
		String msg=cstmt.getString(9);
		msg=msg==null?"":msg;

		retValue.setResultado(!"".equals(msg)?true:false);
		retValue.setDescripcion(msg);

		
	} catch (ProductException e) {
		logger.debug("CustomerException");
		String loge = StackTraceUtl.getStackTrace(e);
		logger.debug("log error[" + loge + "]");
		throw e;
		
	}
	catch (Exception e) {
		logger.error(msjError, e);
		throw new ProductException(msjError,e);
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
	
	logger.debug("validaSeleccionCausa():end");
	return retValue;
}

/*************************************************************************************************************************/

	public OperadoraLocalDTO obtenerOperadoraLocal()throws GeneralException{
		 
		logger.debug("obtenerOperadoraLocal():start");
		OperadoraLocalDTO retValue=new OperadoraLocalDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLObtenerOperadoraLocal();
		try {
		
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());			
			cstmt = conn.prepareCall(call);
			logger.debug("SQL["+call+"]");

			cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);	
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			

			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(2);
			logger.debug("codError [" + codError + "]");
			msgError = cstmt.getString(3);
			logger.debug("msgError [" + msgError + "]");
			numEvento = cstmt.getInt(4);
			logger.debug("numEvento[" + numEvento + "]");
						
			if (codError != 0) {
				logger.error("cErr!=0 Ocurrió un error al obtener operadora local");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}
			
			retValue.setOperadora(cstmt.getString(1));
			logger.error("retValue.getOperadora() ["+retValue.getOperadora()+"]");
	
			
		} catch (ProductException e) {
			logger.debug("CustomerException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Exception Ocurrió un error general al obtener operadora local", e);
			throw new ProductException("Exception Ocurrió un error general al obtener operadora local",e);
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
		
		logger.debug("obtenerOperadoraLocal():end");
		return retValue;
	}
	
	
	/*************************************************************************************************************************/

	public ParametrosGeneralesDTO getParametroGeneral(ParametrosGeneralesDTO parametrogeneral) throws GeneralException {
		 
		logger.debug("getParametroGeneral():start");
		ParametrosGeneralesDTO retValue = new ParametrosGeneralesDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;		
		Connection conn = null;
		CallableStatement cstmt = null;

		String call = getSQLgetParametroGeneral();
		try {
		
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			cstmt = conn.prepareCall(call);
			logger.debug("SQL["+call+"]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,parametrogeneral.getNombreparametro());
			cstmt.setString(2, parametrogeneral.getCodigomodulo());
			cstmt.setString(3, parametrogeneral.getCodigoproducto());
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
            

			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(5);
			logger.debug("codError [" + codError + "]");
			msgError = cstmt.getString(6);
			logger.debug("msgError [" + msgError + "]");
			numEvento = cstmt.getInt(7);
			logger.debug("numEvento[" + numEvento + "]");
						
			if (codError != 0) {
				logger.error("Ocurrió un error al obtener parametro general.");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}
			
			retValue.setNombreparametro(parametrogeneral.getNombreparametro());
			retValue.setCodigomodulo(parametrogeneral.getCodigomodulo());
			retValue.setCodigoproducto(parametrogeneral.getCodigoproducto());
			retValue.setValorparametro(cstmt.getString(4));
              
			
		} catch (ProductException e) {
			logger.debug("CustomerException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Exception Ocurrió un error general al obtener operadora local", e);
			throw new ProductException("Ocurrió un error al obtener parametro general",e);
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
		
		logger.debug("obtenerOperadoraLocal():end");
		return retValue;
	}
	
	
	public DatosCentralDTO obtenerDatosCentral(int codCentral) throws ProductException {

		logger.debug("obtenerDatosCentral():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		DatosCentralDTO datosCentralDTO = new DatosCentralDTO();
		String call = getSQLgetDatosCentral();
		try {

			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			logger.debug("Parámetros de entrada");
			logger.debug("codCentral [" + codCentral + "]");
			cstmt.setInt(1, codCentral);
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
				logger
				.error(" Ocurrió un error general al obtener los datos de la central.");
				throw new ProductException(String.valueOf(codError),
						numEvento, msgError);
			}

			// obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");
			ResultSet rs = (ResultSet) cstmt.getObject(2);

			while (rs.next()) {
				datosCentralDTO.setCod_central(rs.getInt(1));
				datosCentralDTO.setNom_central(rs.getString(2));
				datosCentralDTO.setCod_hlr(rs.getString(3));
				datosCentralDTO.setCod_subAlm(rs.getString(4));
				datosCentralDTO.setCod_tecnologia(rs.getString(5));
			}			

		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger
			.error(
					"Ocurrió un error general al obtener los datos de la central.",
					e);
			throw new ProductException(
					"Ocurrió un error general al obtener los datos de la central.",
					e);
		} finally {
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
		logger.debug("obtenerDatosCentral():end");
		return datosCentralDTO;
	} // 
	
	public  String consultarSeguroAbonado(Long numAbonado) throws ProductException {

		logger.debug("consultarSeguroAbonado():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		String codigoSeguro = "";
		String call = getSQLConsultarSeguroAbonado();
		try {

			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			logger.debug("Parametros de entrada");
			logger.debug("numAbonado [" + numAbonado + "]");
			cstmt.setLong(1, numAbonado.longValue());
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR); //COD_SEGURO
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR); //DES_SEGURO
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC); //NUM_EVENTOS
			cstmt.registerOutParameter(5, java.sql.Types.FLOAT); //importe_equipo 
			cstmt.registerOutParameter(6, java.sql.Types.DATE); //fec_alta  
			cstmt.registerOutParameter(7, java.sql.Types.DATE); //SN_fec_fincontrato  
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC); //num_maxev
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC); //tip_cobert
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR); //des_valor
			cstmt.registerOutParameter(11, java.sql.Types.FLOAT); //deducible 
			cstmt.registerOutParameter(12, java.sql.Types.FLOAT); //imp_segur 
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
				codigoSeguro = "";
			}else{
				codigoSeguro = cstmt.getString(2);
			}
			logger.debug("codigoSeguro = " + codigoSeguro);
			

		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger.error("Ocurrió un error general al consultar seguro.",e);
			throw new ProductException(	"Ocurrió un error general al consultar seguro.",e);
		} finally {
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
		logger.debug("consultarSeguroAbonado():end");
		return codigoSeguro;
	} // 
	
	//Inicio Inc. 174755/CSR-11002/06-09-2011/FDL
	public  String verificaNumeroDesviado(String numeroDesviado) throws GeneralException {

		logger.debug("verificaNumeroDesviado():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		String verificacionNumero = "";
		String call = getSQLverificaNumeroDesviado();
		try {

			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			logger.debug("Parametros de entrada");
			
			cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);		
			
			long numDesviado = Long.parseLong(numeroDesviado);
			logger.debug("numDesviado [" + numDesviado + "]");
			cstmt.setLong(2, numDesviado);
			
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
				verificacionNumero = "FALSE";
			}else{
				verificacionNumero = cstmt.getString(1);
			}
			logger.debug("verificacionNumero = " + verificacionNumero);
			

		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger.error("Ocurrió un error general al consultar seguro.",e);
			throw new ProductException(	"Ocurrió un error general al consultar seguro.",e);
		} finally {
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
		logger.debug("verificaNumeroDesviado():end");
		return verificacionNumero;
	} // 
	//Fin Inc. 174755/CSR-11002/06-09-2011/FDL
	
	//INICIO CSR-11002 PAH
	public void cambioUsoSeries(ParametrosVerificaPlanComercialDTO parametros) throws ProductException {
		 
		logger.debug("cambioUsoSeries():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLCambioUsoSeries();
		try {
		
				
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());			
			cstmt = conn.prepareCall(call);
			
			logger.debug("Parámetros de entrada");
			logger.debug("SQL["+call+"]");
			logger.debug("Numero Serie 	 		["+parametros.getNumSerie()+"]");
			logger.debug("Nombre Usuario 		["+parametros.getNomUsuario()+"]");
			//Inicio Inc. 177697 - 20/12/2011 - FADL
			//logger.debug("Codigo Uso 			["+parametros.getCodUso()+"]");
			logger.debug("Numero Abonado 			["+parametros.getNumAbonado()+"]");
			//Fin Inc. 177697 - 20/12/2011 - FADL
			

			cstmt.setString(1,parametros.getNumSerie());
			cstmt.setString(2,parametros.getNomUsuario());
			cstmt.setString(3,parametros.getCodUso());
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
				logger.error(" Ocurrió un error al cambiar el uso de la serie");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}
			
		} catch (ProductException e) {
			logger.debug("CustomerException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error al cambiar el uso de la serie", e);
			throw new ProductException("Ocurrió un error al cambiar el uso de la serie",e);
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
		
		logger.debug("cambioUsoSeries():end");
	}
	//FIN CSR-11002 PAH
/*************************************************************************************************************************/

	
}//fin getParametroGeneral


