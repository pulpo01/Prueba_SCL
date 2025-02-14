package com.tmmas.scl.framework.ProductDomain.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.sql.Date;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.ProductDomain.dao.interfaces.SiniestroDAOIT;
import com.tmmas.scl.framework.ProductDomain.dto.CambioPlanPendienteDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CausaSiniestroDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SiniestrosDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SolicitudAvisoDeSiniestroDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TipoSiniestroDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TipoSuspencionDTO;
import com.tmmas.scl.framework.ProductDomain.exception.ProductException;
import com.tmmas.scl.framework.ProductDomain.helper.Global;
import com.tmmas.scl.framework.aplicationDomain.dto.SesionDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.UsuarioSistemaDTO;
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;

public class SiniestroDAO extends ConnectionDAO implements SiniestroDAOIT{

	private final Logger logger = Logger.getLogger(SiniestroDAO.class);
	private final Global global = Global.getInstance();

	private String getSQLobtenerTiposDeSiniestros() {
		StringBuffer call = new StringBuffer();

		call.append("DECLARE ");
		call.append("EO_DAT_ABO PV_DATOS_ABO_QT := NEW PV_DATOS_ABO_QT; ");		
		call.append("BEGIN ");
		call.append("eo_dat_abo.cod_tecnologia := ?; ");		
		call.append("eo_dat_abo.num_abonado := ?; ");		
		call.append("	pv_aviso_siniestro_web_pg.pv_tipos_siniestro_pr ( eo_dat_abo, ?, ?, ?, ? ); ");
		call.append("END; ");
		return call.toString(); 		 		
	}

	private String getSQLobtenerTiposDeSuspencion() {
		StringBuffer call = new StringBuffer();

		call.append("BEGIN ");
		call.append("	pv_aviso_siniestro_web_pg.pv_tipo_suspension_pr ( ?, ?, ?, ? ); ");
		call.append("END; ");
		return call.toString(); 		 		
	}	 



	private String getSQLobtenerCausasSiniestro() {
		StringBuffer call = new StringBuffer();

		call.append("DECLARE "); 
		call.append("  EO_DAT_ABO PV_DATOS_ABO_QT := NEW PV_DATOS_ABO_QT; ");
		call.append("BEGIN ");
		call.append("  eo_dat_abo.cod_plantarif := ?; ");
		call.append("  eo_dat_abo.cod_tecnologia := ?; ");				
		call.append("  PV_AVISO_SINIESTRO_WEB_PG.PV_CAUSA_SINIESTRO_PR ( EO_DAT_ABO, ?, ?, ?, ?, ? ); ");	 
		call.append("END; "); 
		return call.toString(); 	
	}
	
	private String getSQLgrabaAvisoDeSiniestro() {
		StringBuffer call = new StringBuffer();

		call.append("DECLARE "); 
		call.append("  eo_dat_abo pv_datos_abo_qt := new pv_datos_abo_qt; ");
		call.append("BEGIN ");
		call.append("  eo_dat_abo.cod_tecnologia := ?; ");
		call.append("  eo_dat_abo.num_abonado    := ?; ");
		call.append("  eo_dat_abo.num_imei       := ?; ");
		call.append("  eo_dat_abo.num_serie      := ?; ");
		call.append("  eo_dat_abo.cod_cliente    := ?; ");
		call.append("  eo_dat_abo.num_celular    := ?; ");
		call.append("  eo_dat_abo.cod_plantarif   := ?; ");
		call.append("  pv_aviso_siniestro_web_pg.pv_acepta_as_pr ( eo_dat_abo, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ); ");	 
		call.append("END; "); 
		return call.toString(); 	
	}	

	private String getSQLrecDatosSiniestroAboando() {
		StringBuffer call = new StringBuffer();

		call.append("DECLARE ");
		call.append("  RetVal BOOLEAN;");
		call.append("  eo_dat_abo pv_datos_abo_qt := new pv_datos_abo_qt; ");
		call.append("BEGIN ");
		call.append("  eo_dat_abo.num_abonado    := ?; ");		
		call.append("  RetVal := PV_ANULA_SINIESTRO_SB_PG.PV_REC_DATOS_SINIESTROS_FN ( EO_DAT_ABO, ?, ?, ?, ? );"); 
		call.append("  END; "); 
		return call.toString(); 	
	}
	
	private String getSQLanulaSinistroAbonado() {
		StringBuffer call = new StringBuffer();

		call.append("DECLARE "); 
		call.append("  pv_anula_siniestro pv_anula_siniestro_ot := NEW pv_anula_siniestro_ot(); ");
		call.append("BEGIN "); 
		call.append("  pv_anula_siniestro.num_abonado       	:=?; ");
		call.append("  pv_anula_siniestro.num_siniestro     	:=?; ");
		call.append("  pv_anula_siniestro.num_serie         	:=?; ");
		call.append("  pv_anula_siniestro.fec_suspencion    	:=?; ");
		call.append("  pv_anula_siniestro.nom_usuario       	:=?; ");
		call.append("  pv_anula_siniestro.obs_detalle       	:=?; ");
		call.append("  pv_anula_siniestro.cod_modulo        	:=?; ");
    	call.append("  pv_anula_siniestro.cod_causa         	:=?; ");
		call.append("  pv_anula_siniestro.tarea             	:=?; ");
		call.append("  pv_anula_siniestro.num_ooss          	:=?; ");
		call.append("  pv_anula_siniestro.cod_ooss          	:=?; ");
		call.append("  pv_anula_siniestro.ind_mant_lista_negra 	:=?; ");
		call.append("  PV_ANULA_SINIESTRO_SB_PG.pv_graba_anula_siniestro_pr ( pv_anula_siniestro, ?, ?, ? ); "); 
		call.append("END; ");				
		return call.toString(); 	
	}	
	
	//Incluido santiago ventura 23-03-2010
	private String getSQLanulaNumeroConstanciaPolicial() {
		StringBuffer call = new StringBuffer();
		call.append("DECLARE "); 
		call.append("  pv_anula_siniestro pv_anula_siniestro_ot := NEW pv_anula_siniestro_ot(); ");
		call.append("BEGIN "); 
		call.append("  pv_anula_siniestro.num_siniestro     	:=?; ");		
		call.append("  PV_ANULA_SINIESTRO_SB_PG.pv_anulardenuncia_pr ( pv_anula_siniestro, ?, ?, ?, ? ); "); 
		call.append("END; ");				
		return call.toString(); 	
	}

	public TipoSiniestroDTO[] obtenerTiposDeSiniestros (UsuarioAbonadoDTO usuarioAbonado) throws ProductException {

		logger.debug("obtenerTiposDeSiniestros():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		String call = getSQLobtenerTiposDeSiniestros();


		TipoSiniestroDTO[] tipoSiniestros; 
		try {

			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			cstmt = conn.prepareCall(call);
			
			logger.debug("Parámetros de entrada");
			logger.debug("usuarioAbonado.getCod_tecnologia() ["+usuarioAbonado.getCod_tecnologia()+"]");
			cstmt.setString(1, usuarioAbonado.getCod_tecnologia());
			cstmt.setLong(2, usuarioAbonado.getNum_abonado());			
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
				.error(" Ocurrió un error general al obtener Tipos de Siniestros");
				throw new ProductException(String.valueOf(codError),
						numEvento, msgError);
			}			
			
			logger.debug("Recuperando data...");
			logger.debug("Recuperando cursor...");
			logger.debug("object="+cstmt.getObject(3));

			ResultSet rs = (ResultSet) cstmt.getObject(3);
			ArrayList lista = new ArrayList();
			TipoSiniestroDTO tipoSiniestro;
			while (rs.next()) {			
				tipoSiniestro = new TipoSiniestroDTO();

				tipoSiniestro.setCod_TipoSiniestro(rs.getString(1));
				tipoSiniestro.setDes_TipoSiniestro(rs.getString(2));
				lista.add(tipoSiniestro);
			}

			tipoSiniestros = (TipoSiniestroDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), TipoSiniestroDTO.class);


		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger
			.error(
					"Ocurrió un error general al obtener obtener Tipos de Siniestros",
					e);
			throw new ProductException(
					"Ocurrió un error general al obtener obtener Tipos de Siniestros",
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
		logger.debug("obtenerTiposDeSiniestros():end");
		return tipoSiniestros;
	}	

	public CausaSiniestroDTO[] obtenerCausasSiniestro (UsuarioAbonadoDTO usuarioAbonado, String Actabo) throws ProductException {

		logger.debug("obtenerCausasSiniestro():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		String call = getSQLobtenerCausasSiniestro();

		CausaSiniestroDTO[] CausaSiniestros;  
		
		try {

			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			cstmt = conn.prepareCall(call);
			
			logger.debug("Parámetros de entrada");
			logger.debug("usuarioAbonado.getCodPlantarif() ["+usuarioAbonado.getCodPlantarif()+"]");
			logger.debug("usuarioAbonado.getCod_tecnologia() ["+usuarioAbonado.getCod_tecnologia()+"]");
			logger.debug("Actabo ["+Actabo+"]");
			cstmt.setString(1, usuarioAbonado.getCodPlantarif());
			cstmt.setString(2, usuarioAbonado.getCod_tecnologia());			
			cstmt.setString(3, Actabo);
			cstmt.registerOutParameter(4, oracle.jdbc.driver.OracleTypes.CURSOR);			
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
				logger
				.error(" Ocurrió un error general al obtener obtener Causas de Siniestros");
				throw new ProductException(String.valueOf(codError),
						numEvento, msgError);
			}

			// obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");

			logger.debug("Recuperando cursor...");
			logger.debug("object="+cstmt.getObject(4));

			ResultSet rs = (ResultSet) cstmt.getObject(4);
			ArrayList lista = new ArrayList();
			CausaSiniestroDTO causaSiniestro;
			while (rs.next()) {			
				causaSiniestro = new CausaSiniestroDTO();

				causaSiniestro.setDes_causa(rs.getString(1));//    ();
				causaSiniestro.setCod_causa(rs.getString(2));
				causaSiniestro.setCod_servicio(rs.getString(3));
				causaSiniestro.setCod_caususp(rs.getString(4));
				
				
				
				lista.add(causaSiniestro);
			}

			CausaSiniestros = (CausaSiniestroDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), CausaSiniestroDTO.class);
			
		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger
			.error(
					"Ocurrió un error general al obtener obtener Causas de Siniestros",
					e);
			throw new ProductException(
					"Ocurrió un error general al obtener obtener Causas de Siniestros",
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
		logger.debug("obtenerCausasSiniestro():end");
		return CausaSiniestros;
	}
	
	public TipoSuspencionDTO[] obtenerTiposDeSuspencion () throws ProductException {

		logger.debug("obtenerTiposDeSuspencion():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		String call = getSQLobtenerTiposDeSuspencion();

		TipoSuspencionDTO[] TipoSuspenciones;  


		try {

			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
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

			logger.debug("Recuperando cursor...");
			logger.debug("object="+cstmt.getObject(1));

			ResultSet rs = (ResultSet) cstmt.getObject(1);
			ArrayList lista = new ArrayList();
			TipoSuspencionDTO tipoSuspencion;
			while (rs.next()) {			
				tipoSuspencion = new TipoSuspencionDTO();

				tipoSuspencion.setCod_TipoSuspencion(rs.getString(1));//    ();
				tipoSuspencion.setDes_TipoSuspencion(rs.getString(2));
				lista.add(tipoSuspencion);
			}

			TipoSuspenciones = (TipoSuspencionDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), TipoSuspencionDTO.class);

			if (codError != 0) {
				logger
				.error(" Ocurrió un error general al obtener Tipos de Suspencion");
				throw new ProductException(String.valueOf(codError),
						numEvento, msgError);
			}

			// obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");


		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger
			.error(
					"Ocurrió un error general al obtener Tipos de Suspencion",
					e);
			throw new ProductException(
					"Ocurrió un error general al obtener Tipos de Suspencion",
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
		logger.debug("obtenerTiposDeSuspencion():end");
		return TipoSuspenciones;
	}		
	
	//Inicio Inc. 174755/CSR-11002/06-09-2011/FDL		
	//public SolicitudAvisoDeSiniestroDTO grabaAvisoDeSiniestro (UsuarioAbonadoDTO usuarioAbonado, TipoSiniestroDTO tipoSiniestro, TipoSuspencionDTO tipoSuspencion, CausaSiniestroDTO causaSiniestro, UsuarioSistemaDTO usuarioSistema, String actabo, String num_os, String comentario) throws ProductException {
	public SolicitudAvisoDeSiniestroDTO grabaAvisoDeSiniestro (UsuarioAbonadoDTO usuarioAbonado, TipoSiniestroDTO tipoSiniestro, TipoSuspencionDTO tipoSuspencion, CausaSiniestroDTO causaSiniestro, UsuarioSistemaDTO usuarioSistema, String actabo, String num_os, String comentario, String numeroDesvio) throws ProductException {
		logger.debug("grabaAvisoDeSiniestro():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		String call = getSQLgrabaAvisoDeSiniestro();
		
		SolicitudAvisoDeSiniestroDTO avisoDeSiniestro = new SolicitudAvisoDeSiniestroDTO();  

		try {
			  
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			cstmt = conn.prepareCall(call);
			
			logger.debug("Parámetros de entrada");
			logger.debug("usuarioAbonado.getCod_tecnologia() ["+usuarioAbonado.getCod_tecnologia()+"]");
			logger.debug("usuarioAbonado.getNum_abonado() ["+usuarioAbonado.getNum_abonado()+"]");
			logger.debug("usuarioAbonado.getNum_imei() ["+usuarioAbonado.getNum_imei()+"]");
			logger.debug("usuarioAbonado.getNum_serie() ["+usuarioAbonado.getNum_serie()+"]");
			logger.debug("usuarioAbonado.getCod_cliente() ["+usuarioAbonado.getCod_cliente()+"]");
			logger.debug("usuarioAbonado.getNum_celular() ["+usuarioAbonado.getNum_celular()+"]");
			logger.debug("usuarioAbonado.getCodPlantarif()["+usuarioAbonado.getCodPlantarif()+"]");
			logger.debug("actabo ["+actabo+"]");
			logger.debug("tipoSiniestro.getCod_TipoSiniestro() ["+tipoSiniestro.getCod_TipoSiniestro()+"]");
			logger.debug("tipoSuspencion.getCod_TipoSuspencion() ["+tipoSuspencion.getCod_TipoSuspencion()+"]");
			logger.debug("tipoSuspencion.getCod_TipoSuspencion() ["+tipoSuspencion.getCod_TipoSuspencion()+"]");
			logger.debug("usuarioSistema.getNom_usuario() ["+usuarioSistema.getNom_usuario()+"]");
			logger.debug("num_os() ["+num_os+"]");
			logger.debug("numeroDesvio() ["+numeroDesvio+"]");
			
			
			cstmt.setString(1, usuarioAbonado.getCod_tecnologia());
			cstmt.setLong(2, usuarioAbonado.getNum_abonado());
			cstmt.setString(3, usuarioAbonado.getNum_imei());
			cstmt.setString(4, usuarioAbonado.getNum_serie());
			cstmt.setLong(5, usuarioAbonado.getCod_cliente());
			cstmt.setLong(6, usuarioAbonado.getNum_celular());	
			cstmt.setString(7, usuarioAbonado.getCodPlantarif());
			cstmt.setString(8, actabo);
			cstmt.setString(9, tipoSiniestro.getCod_TipoSiniestro());
			cstmt.setString(10, tipoSuspencion.getCod_TipoSuspencion());
			cstmt.setString(11, causaSiniestro.getCod_causa());
			cstmt.setString(12, usuarioSistema.getNom_usuario());
			cstmt.setString(13, num_os);
			cstmt.setString(14, comentario);
			cstmt.setString(15, numeroDesvio);
			
			
			
			cstmt.registerOutParameter(16, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(17, java.sql.Types.NUMERIC);			
			cstmt.registerOutParameter(18, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(19, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(20, java.sql.Types.NUMERIC);	

			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");

			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(18);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(19);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(20);
			logger.debug("numEvento[" + numEvento + "]");

			if (codError != 0) {
				logger
				.error(" Ocurrió un error general al grabar el aviso de siniestro");
				throw new ProductException(String.valueOf(codError),
						numEvento, msgError);
			}

			// obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");
 
			avisoDeSiniestro.setNum_solucionequipo(cstmt.getInt(16));
			avisoDeSiniestro.setNum_solucionSimcard(cstmt.getInt(17));

		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger
			.error(
					"Ocurrió un error general al grabar el aviso de siniestro",
					e);
			throw new ProductException(
					"Ocurrió un error general al grabar el aviso de siniestro",
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
		logger.debug("grabaAvisoDeSiniestro():end");
		return avisoDeSiniestro;
	}	
	//Fin Inc. 174755/CSR-11002/06-09-2011/FDL

	public SiniestrosDTO[] recDatosSiniestroAboando (UsuarioAbonadoDTO usuarioAbonado) throws ProductException {
		
		logger.debug("recDatosSiniestroAboando():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		String call = getSQLrecDatosSiniestroAboando();
		
		SiniestrosDTO[] Siniestros;  

		try {
			  
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			cstmt = conn.prepareCall(call);
			
			logger.debug("Parámetros de entrada");
			logger.debug("usuarioAbonado.getNum_abonado() ["+usuarioAbonado.getNum_abonado()+"]");
			cstmt.setLong(1, usuarioAbonado.getNum_abonado());
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
				.error(" Ocurrió un error general al obtener los siniestros del abonado");
				throw new ProductException(String.valueOf(codError),
						numEvento, msgError);
			}

			// obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");

			logger.debug("Recuperando cursor...");
			logger.debug("object="+cstmt.getObject(2));

			ResultSet rs = (ResultSet) cstmt.getObject(2);
			ArrayList lista = new ArrayList();
			
			SiniestrosDTO Siniestro;
			while (rs.next()) {			
				Siniestro = new SiniestrosDTO();
				
				Siniestro.setNum_siniestro (rs.getLong(1));
				Siniestro.setCod_estado_d  (rs.getString(2));
				Siniestro.setDes_estado_d  (rs.getString(3));
				Siniestro.setCod_causa     (rs.getString(4));
				Siniestro.setDes_causa     (rs.getString(5));
				Siniestro.setFec_siniestro (rs.getDate(6));
				Siniestro.setFec_formaliza (rs.getDate(7));
				Siniestro.setFec_anula     (rs.getDate(8));
				Siniestro.setFec_restituc  (rs.getDate(9));
				Siniestro.setNum_constpol  (rs.getString(10));
				Siniestro.setObs_detalle   (rs.getString(11));
				Siniestro.setCod_estado    (rs.getString(12));
				Siniestro.setNum_serie     (rs.getString(13));
				Siniestro.setDes_terminal  (rs.getString(14));
				Siniestro.setNum_terminal  (rs.getString(15));
				
				lista.add(Siniestro);
			}

			Siniestros = (SiniestrosDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), SiniestrosDTO.class);

		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger
			.error(
					"Ocurrió un error general al obtener los siniestros del abonado",
					e);
			throw new ProductException(
					"Ocurrió un error general al obtener los siniestros del abonado",
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
		logger.debug("recDatosSiniestroAboando():end");		
	    return Siniestros;	
	}
	

	public void anulaSinistroAbonado (SiniestrosDTO siniestros, UsuarioAbonadoDTO usuarioAbonado, SesionDTO sesion) throws ProductException {
		
		logger.debug("anulaSinistroAbonado():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		String call = getSQLanulaSinistroAbonado();
		  
		try {
			  
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			cstmt = conn.prepareCall(call);
			
			logger.debug("Parámetros de entrada");
			logger.debug("usuarioAbonado.getNum_abonado() ["+usuarioAbonado.getNum_abonado()+"]");
			logger.debug("siniestros.getNum_siniestro() ["+siniestros.getNum_siniestro()+"]");
			logger.debug("siniestros.getNum_serie() ["+siniestros.getNum_serie()+"]");
			logger.debug("(Date)siniestros.getFec_siniestro() ["+(Date)siniestros.getFec_siniestro()+"]");
			logger.debug("sesion.getUsuario().getNom_usuario() ["+sesion.getUsuario().getNom_usuario()+"]");
			logger.debug("siniestros.getObs_detalle() ["+siniestros.getObs_detalle()+"]");
			logger.debug("NN [GA] //Por default");
			logger.debug("siniestros.getCod_causa() ["+siniestros.getCod_causa()+"]");
			logger.debug("sesion.getNumTarea() ["+sesion.getNumTarea()+"]");
			logger.debug("siniestros.getCodOoss() ["+siniestros.getCodOoss()+"]");
			logger.debug("siniestros.getNumOoss() ["+siniestros.getNumOoss()+"]");
			logger.debug("indlistaNegra ["+siniestros.getIndlistaNegra()+"]");
			cstmt.setLong  (1, usuarioAbonado.getNum_abonado());
			cstmt.setLong  (2, siniestros.getNum_siniestro());
			cstmt.setString(3, siniestros.getNum_serie());
			cstmt.setDate  (4, (Date)siniestros.getFec_siniestro());			
			cstmt.setString(5, sesion.getUsuario().getNom_usuario());
			cstmt.setString(6, siniestros.getObs_detalle());
			cstmt.setString(7, "GA");
			cstmt.setString(8, siniestros.getCod_causa());
			cstmt.setLong  (9, sesion.getNumTarea());
			cstmt.setString(10,siniestros.getCodOoss());
			cstmt.setLong(11,siniestros.getNumOoss());
			String indlista=siniestros.getIndlistaNegra();
			indlista=indlista==null||"".equals(indlista)?"0":indlista;
			cstmt.setInt(12,Integer.parseInt(indlista));				
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
				logger
				.error(" Ocurrió un error general al anular los siniestros del abonado");
				throw new ProductException(String.valueOf(codError),
						numEvento, msgError);
			}

			// obtener info del cliente y completar respuesta

		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger
			.error(
					"Ocurrió un error general al anular los siniestros del abonado",
					e);
			throw new ProductException(
					"Ocurrió un error general al anular los siniestros del abonado",
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
		logger.debug("anulaSinistroAbonado():end");			
	}

	public CambioPlanPendienteDTO validarCambioPlanPendiente(CambioPlanPendienteDTO cambioPlan) throws ProductException {
		logger.debug("validarCambioPlanPendiente():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		
        String call = "{CALL PV_VAL_CAMPLAN_A_CICLO_PG.PV_VAL_CAMPLAN_A_CICLO_PR(?,?,?,?,?,?,?,?,?,?,?)}";
        logger.debug( call );
        
        CambioPlanPendienteDTO resultado = new CambioPlanPendienteDTO();
		  
		try {
			  
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			cstmt = conn.prepareCall(call);
			
			logger.debug("Parámetros de entrada");
			logger.debug("cambioPlan.getCod_cliente() ["+ cambioPlan.getCod_cliente() + "]");
			logger.debug("cambioPlan.getNum_abonado() ["+ cambioPlan.getNum_abonado() + "]");	
			logger.debug("cambioPlan.getCod_ooss() ["+ cambioPlan.getCod_ooss() + "]");
			logger.debug("cambioPlan.getCod_plantarif ["+ cambioPlan.getCod_plantarif() + "]");
	
			
			cstmt.setLong  (1, cambioPlan.getCod_cliente());
			cstmt.setLong  (2, cambioPlan.getNum_abonado());
			cstmt.setString(3, cambioPlan.getCod_ooss());
			cstmt.setString  (4, cambioPlan.getCod_plantarif());			

			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			
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
				logger
				.error(" Ocurrió un error general al validar el cambio de plan pendiente");
				throw new ProductException(String.valueOf(codError),
						numEvento, msgError);
			}
			
			resultado.setCod_retorno(cstmt.getString(5));
			resultado.setGlosa_retorno(cstmt.getString(6));
			resultado.setPlan_nuevo(cstmt.getString(7));
			resultado.setNum_ooss(cstmt.getLong(8));			

			// obtener info del cliente y completar respuesta

		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger
			.error(
					"Ocurrió un error general al validar el cambio de plan pendiente",
					e);
			throw new ProductException(
					"Ocurrió un error general al validar el cambio de plan pendiente",
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
		logger.debug("validarCambioPlanPendiente():end");
		return resultado;
	}

	//Incluido santiago ventura 23-03-2010
	public void anulaNumeroConstanciaPolicial(SiniestrosDTO siniestros) throws ProductException {
		logger.debug("anulaNumeroConstanciaPolicial():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		String call = getSQLanulaNumeroConstanciaPolicial();
		  
		try {
			  
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			cstmt = conn.prepareCall(call);
			
			logger.debug("Parámetros de entrada");
			logger.debug("num sinientro ["+siniestros.getNum_siniestro()+"]");
			logger.debug("num Constancia anula siniestro ["+siniestros.getNumConstaPolAnula()+"]");

			cstmt.setLong  (1, siniestros.getNum_siniestro());		
			cstmt.setString  (2, siniestros.getNumConstaPolAnula());	
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);	

			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");

			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);			
			
			logger.debug("codError[" + codError + "]");
			logger.debug("msgError[" + msgError + "]");
			logger.debug("numEvento[" + numEvento + "]");

			if (codError != 0) {
				logger.error(" Ocurrió un error general al anular denuncia policial del siniestro");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}

		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger.error("Ocurrió un error general al anular denuncia policial del siniestro",e);
			throw new ProductException("Ocurrió un error general al anular denuncia policial del siniestro",e);
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
		logger.debug("anulaNumeroConstanciaPolicial():end");			
	}	
}
