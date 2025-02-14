package com.tmmas.scl.framework.ProductDomain.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.ProductDomain.dao.interfaces.ServiciosSuplementariosDAOIT;
import com.tmmas.scl.framework.ProductDomain.dto.GaAboMailTODTO;
import com.tmmas.scl.framework.ProductDomain.dto.GaServSuPlDTO;
import com.tmmas.scl.framework.ProductDomain.dto.GaServSupDefDTO;
import com.tmmas.scl.framework.ProductDomain.dto.ReglasSSDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SSuplementarioDTO;
import com.tmmas.scl.framework.ProductDomain.exception.ProductException;
import com.tmmas.scl.framework.ProductDomain.helper.Global;
import com.tmmas.scl.framework.aplicationDomain.dto.SesionDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.UsuarioSistemaDTO;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;


public class ServiciosSuplementariosDAO  extends ConnectionDAO implements ServiciosSuplementariosDAOIT {
	private final Logger logger = Logger.getLogger(ServiciosSuplementariosDAO.class);
	private final Global global = Global.getInstance();

	// ----------------------------------------------------------------------------------------------------------------------------------------
	
	private String getSQLgetServiciosBBContratados()	{
		StringBuffer call = new StringBuffer();

		call.append("DECLARE "); 
		call.append("	EO_DAT_ABO pv_datos_abo_qt := NEW pv_datos_abo_qt; ");
		call.append("BEGIN  ");		
		call.append("	EO_DAT_ABO.num_abonado := ?; ");
		call.append("	Pv_Serv_Suplementario_Sb_Pg.pv_rec_ss_black_berry_abo_pr(EO_DAT_ABO, ?, ?, ?, ? ); ");
		call.append("END; ");

		return call.toString(); 		 		
	}

	// ----------------------------------------------------------------------------------------------------------------------------------------
	
	private String getSQLobtenerServiciosDisplonibles() {
		StringBuffer call = new StringBuffer();

		call.append("DECLARE "); 
		call.append("	EO_DAT_ABO pv_datos_abo_qt := NEW pv_datos_abo_qt; ");
		call.append("	EO_SESION GE_SESION_QT := NEW GE_SESION_QT; ");
		call.append("BEGIN  ");
		call.append("	EO_DAT_ABO.num_abonado := ?; ");
		call.append("	EO_SESION.nom_usuario  := ?; ");
		call.append("	EO_SESION.cod_programa := ?; ");
		call.append("	EO_SESION.num_version  := ?; ");
		//call.append("	PV_SERVICIO_SUPLEMENTARIO_PG.PV_REC_SERV_DISP_PR ( EO_DAT_ABO, EO_SESION, ?, ?, ?, ? ); "); 
		call.append("	PV_SERV_SUPLEMENTARIO_SB_PG.PV_REC_SERV_DISP_PR ( EO_DAT_ABO, EO_SESION, ?, ?, ?, ? ); "); 
		call.append("	END; "); 
		return call.toString(); 		 		
	}

	// ----------------------------------------------------------------------------------------------------------------------------------------
	
	private String getSQLobtenerServiciosContratados() {
		StringBuffer call = new StringBuffer();

		call.append("DECLARE "); 
		call.append("	EO_DAT_ABO pv_datos_abo_qt := NEW pv_datos_abo_qt; ");
		call.append("BEGIN  ");
		call.append("	EO_DAT_ABO.num_abonado := ?; ");
		call.append("	PV_SERV_SUPLEMENTARIO_SB_PG.PV_REC_SERV_SUPL_ABONADO_PR ( EO_DAT_ABO, ?, ?, ?, ?, ? ); "); 
		call.append("END; ");
		return call.toString(); 		 		
	}
	
	// ----------------------------------------------------------------------------------------------------------------------------------------
	
	private String getSQLgetReglasdeValidacionSS(){
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("	EO_DAT_ABO pv_datos_abo_qt := NEW pv_datos_abo_qt; ");		
		call.append(" BEGIN ");
	
		call.append("	EO_DAT_ABO.cod_central := ?; ");
		call.append("	EO_DAT_ABO.cod_tecnologia := ?; ");
		call.append("	EO_DAT_ABO.tip_terminal := ?; ");
		
		call.append("   PV_SERV_SUPLEMENTARIO_SB_PG.PV_reglas_valid_vig_ss_PR( EO_DAT_ABO, ?, ?, ?, ?);");		
		call.append(" END;");
		return call.toString();                             
	}

//	 ----------------------------------------------------------------------------------------------------------------------------------------
	
	private String getSQLactDesactSS(){
		StringBuffer call = new StringBuffer();
		call.append(" BEGIN ");
		call.append("   PV_SERV_SUPLEMENTARIO_SB_PG.PV_ACT_DESACT_SS_PR( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? );");
		call.append(" END;");
		return call.toString();                             
	}
	
//	 ----------------------------------------------------------------------------------------------------------------------------------------
	
	private String getSQLServSuplDefecto(){
		StringBuffer call = new StringBuffer();
			call.append(" BEGIN ");
			call.append("   GA_SRVCRM_PG.GA_OBTIENESERVPORDEFECTO_PR ( ?, ?, ?, ?, ?, ? );");
			call.append(" END;");
		return call.toString();
	}
	
	private String getSQLEstadoCorreoServSupl(){
		StringBuffer call = new StringBuffer();
			call.append(" BEGIN ");
			call.append("   GA_SRVCRM_PG.GA_ESTADOSRVCORREODATA_PR ( ?, ?, ?, ?, ?, ?,?,? );");
			call.append(" END;");
		return call.toString();
	}
	private String getSQLGaAboMailTO(){
		StringBuffer call = new StringBuffer();
			call.append(" BEGIN ");
			call.append("   GA_SRVCRM_PG.GA_GETSRVDATOSABOMAILTO_PR ( ?,?,?,?,?);");
			call.append(" END;");
		return call.toString();
	}
	
	
		
	public ReglasSSDTO[] getReglasdeValidacionSS(UsuarioAbonadoDTO usuarioAbonado, AbonadoDTO abonado) throws ProductException {


		logger.debug("getReglasdeValidacionSS():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ReglasSSDTO[] reglas = null;
		Connection conn = null;
		CallableStatement cstmt = null;

		try {

			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			String call = getSQLgetReglasdeValidacionSS();
			cstmt = conn.prepareCall(call);

			logger.debug("Parámetros de entrada");
			logger.debug("abonado.getCodCentral() [" + String.valueOf(abonado.getCodCentral()) + "]");
			logger.debug("usuarioAbonado.getCod_tecnologia() [" + usuarioAbonado.getCod_tecnologia() + "]");
			logger.debug("usuarioAbonado.getTip_terminal() [" + usuarioAbonado.getTip_terminal() + "]");
			
			cstmt.setLong(1, abonado.getCodCentral());
			cstmt.setString(2, usuarioAbonado.getCod_tecnologia());
			cstmt.setString(3, usuarioAbonado.getTip_terminal());
			
			cstmt.registerOutParameter(4,oracle.jdbc.driver.OracleTypes.CURSOR);
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
				logger.error(" Ocurrió un error general al obtener las Reglas de ValidacionSS");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}
			// obtener info del cliente y completar respuesta

			logger.debug("Recuperando cursor...");

			ResultSet rs = (ResultSet) cstmt.getObject(4);

			ArrayList lista = new ArrayList();

			while (rs.next()) {
				ReglasSSDTO regla = new ReglasSSDTO();
				regla.setCodProducto(rs.getInt(1));
				regla.setCodServicio(rs.getString(2));                                       
				regla.setCodServDef(rs.getString(3));
				regla.setNomUsuario(rs.getString(4));
				regla.setCodServOrig(rs.getString(5));
				regla.setTipoRelacion(rs.getInt(6));
				regla.setCodActAbo(rs.getString(7));
				lista.add(regla);
			}
			reglas = (ReglasSSDTO[])ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), ReglasSSDTO.class);

		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger.error(" Ocurrió un error general al obtener las Reglas de ValidacionSS",	e);
			throw new ProductException(" Ocurrió un error general al obtener las Reglas de ValidacionSS",e);
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
		logger.debug("getReglasdeValidacionSS():end");
		return reglas;
	}

	// ----------------------------------------------------------------------------------------------------------------------------------------
	
	public SSuplementarioDTO[] obtenerServiciosDisplonibles(UsuarioAbonadoDTO usuarioAbonado, SesionDTO sesion)  throws ProductException {

		logger.debug("obtenerServiciosDisplonibles():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		String call = getSQLobtenerServiciosDisplonibles();


		SSuplementarioDTO[] ServiciosSuplementarios; 
		try {

			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			cstmt = conn.prepareCall(call);
			logger.debug("Parámetros de entrada");
			logger.debug("usuarioAbonado.getNum_abonado() ["+usuarioAbonado.getNum_abonado()+"]");
			logger.debug("sesion.getUsuario().getNom_usuario() ["+sesion.getUsuario().getNom_usuario()+"]");
			logger.debug("sesion.getCod_programa() ["+sesion.getCod_programa()+"]");
			logger.debug("sesion.getNum_version() ["+sesion.getNum_version()+"]");
			cstmt.setLong(1, usuarioAbonado.getNum_abonado());
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
				.error(" Ocurrió un error general al obtener los servicios disponibles");
				throw new ProductException(String.valueOf(codError),
						numEvento, msgError);
			}			
			
			logger.debug("Recuperando cursor...");
			logger.debug("object="+cstmt.getObject(5));

			ResultSet rs = (ResultSet) cstmt.getObject(5);
			ArrayList lista = new ArrayList();
			SSuplementarioDTO servicioSuplementario;
						
			while (rs.next()) {			
				servicioSuplementario = new SSuplementarioDTO();

				servicioSuplementario.setCod_servicio(rs.getString(1));
				servicioSuplementario.setDes_servicio(rs.getString(2));
				servicioSuplementario.setCod_servsupl(rs.getLong(3));
				servicioSuplementario.setCod_nivel(rs.getLong(4));
				servicioSuplementario.setImp_tarifa_ss(rs.getFloat(5));
				servicioSuplementario.setDes_moneda_ss(rs.getString(6));
				servicioSuplementario.setCod_concepto_ss(rs.getLong(7));
				servicioSuplementario.setImp_tarifa_fa(rs.getFloat(8));
				servicioSuplementario.setDes_moneda_fa(rs.getString(9));
				servicioSuplementario.setCod_concepto_fa(rs.getLong(10));
				servicioSuplementario.setEstado_servicio(rs.getString(11));
				servicioSuplementario.setInd_altamira(rs.getLong(12));				

				lista.add(servicioSuplementario);
			}

			ServiciosSuplementarios = (SSuplementarioDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), SSuplementarioDTO.class);



			// obtener info del cliente y completar respuesta



		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger
			.error(
					"Ocurrió un error general al obtener obtener los servicios disponibles",
					e);
			throw new ProductException(
					"Ocurrió un error general al obtener obtener los servicios disponibles",
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
		logger.debug("obtenerServiciosDisplonibles():end");
		return ServiciosSuplementarios;
	}

	// ----------------------------------------------------------------------------------------------------------------------------------------
	
	public SSuplementarioDTO[] obtenerServiciosContratados(UsuarioAbonadoDTO usuarioAbonado, long opcion) throws ProductException {

		logger.debug("obtenerServiciosContratados():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		String call = getSQLobtenerServiciosContratados();


		SSuplementarioDTO[] ServiciosSuplementarios; 
		try {

			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			cstmt = conn.prepareCall(call);
			logger.debug("Parámetros de entrada");
			logger.debug("usuarioAbonado.getNum_abonado() ["+usuarioAbonado.getNum_abonado()+"]");
			logger.debug("opcion ["+opcion+"]");
			cstmt.setLong(1, usuarioAbonado.getNum_abonado());				
			cstmt.setLong(2, opcion);
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

			logger.debug("Recuperando cursor...");
			logger.debug("object="+cstmt.getObject(3));

			ResultSet rs = (ResultSet) cstmt.getObject(3);
			ArrayList lista = new ArrayList();
			SSuplementarioDTO servicioSuplementario;
			while (rs.next()) {			
				servicioSuplementario = new SSuplementarioDTO();

				servicioSuplementario.setCod_servicio(rs.getString(1));
				servicioSuplementario.setDes_servicio(rs.getString(2));
				servicioSuplementario.setCod_servsupl(rs.getLong(3));
				servicioSuplementario.setCod_nivel(rs.getLong(4));
				servicioSuplementario.setImp_tarifa_ss(rs.getFloat(5));
				servicioSuplementario.setDes_moneda_ss(rs.getString(6));
				servicioSuplementario.setCod_concepto_ss(rs.getLong(7));
				servicioSuplementario.setImp_tarifa_fa(rs.getFloat(8));
				servicioSuplementario.setDes_moneda_fa(rs.getString(9));
				servicioSuplementario.setCod_concepto_fa(rs.getLong(10));
				servicioSuplementario.setEstado_servicio(rs.getString(11));
				servicioSuplementario.setInd_altamira(rs.getLong(12));				

				lista.add(servicioSuplementario);
			}

			ServiciosSuplementarios = (SSuplementarioDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), SSuplementarioDTO.class);

			if (codError != 0) {
				logger
				.error(" Ocurrió un error general al obtener servicios contratados");
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
					"Ocurrió un error general al obtener obtener servicios contratados",
					e);
			throw new ProductException(
					"Ocurrió un error general al obtener obtener servicios contratados",
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
		logger.debug("obtenerServiciosContratados():end");
		return ServiciosSuplementarios;
	}


	// ----------------------------------------------------------------------------------------------------------------------------------------

	public void actDesactSS(ClienteOSSesionDTO sessionData, String listServAct, String listServDesac, String montoTotal, UsuarioSistemaDTO usuarioSistema, String comentario) throws ProductException {

		logger.debug("actDesactSS():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		String call = getSQLactDesactSS();
		try {

			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());

			cstmt = conn.prepareCall(call);
			logger.debug("Parámetros de entrada");
			logger.debug("string de servicios para activar [" + listServAct + "]");
			logger.debug("string de servicios para desactivar [" + listServDesac + "]");
			logger.debug("sessionData.getNumAbonado() [" + String.valueOf(sessionData.getNumAbonado()) + "]");
			logger.debug("sessionData.getAbonados()[0].getNumCelular() [" + String.valueOf(sessionData.getAbonados()[0].getNumCelular()) + "]");
			logger.debug("sessionData.getNumOrdenServicio() [" + String.valueOf(sessionData.getNumOrdenServicio()) + "]");
			logger.debug("sessionData.getCodOrdenServicio() [" + String.valueOf(sessionData.getCodOrdenServicio()) + "]");			
			logger.debug("montoTotal [" + montoTotal + "]");
			logger.debug("usuarioSistema.getNom_usuario() [" + usuarioSistema.getNom_usuario() + "]");
			logger.debug("comentario [" + comentario + "]");
			
			cstmt.setLong(1, sessionData.getNumAbonado());
			cstmt.setLong(2, sessionData.getAbonados()[0].getNumCelular());
			cstmt.setString(3, listServAct);
			cstmt.setString(4, listServDesac);
			cstmt.setLong(5, sessionData.getNumOrdenServicio());
			cstmt.setLong(6, sessionData.getCodOrdenServicio());
			cstmt.setString(7, montoTotal);
			cstmt.setString(8, usuarioSistema.getNom_usuario());
			cstmt.setString(9, comentario);
			
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(12, java.sql.Types.NUMERIC);	

			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");

			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(10);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(11);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(12);
			logger.debug("numEvento[" + numEvento + "]");

			if (codError != 0) {
				logger.error(" Ocurrió un error general al registrar los servicios suplementarios");
				throw new ProductException(String.valueOf(codError), numEvento,
						msgError);
			}

			logger.debug("Recuperando data...");

		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger.error("Ocurrió un error general al registrar los servicios suplementarios", e);
			throw new ProductException("Ocurrió un error general al registrar los servicios suplementarios", e);
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
		logger.debug("registrarSS():end");
	}
	
	// ----------------------------------------------------------------------------------------------------------------------------------------

	public SSuplementarioDTO[] getServiciosBBContratados(UsuarioAbonadoDTO usuarioAbonado) throws ProductException	{
		
		logger.debug("getServiciosBBContratados():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		String call = getSQLgetServiciosBBContratados();

		SSuplementarioDTO[] ServiciosSuplementarios; 
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

			logger.debug("Recuperando cursor...");
			logger.debug("object="+cstmt.getObject(2));

			ResultSet rs = (ResultSet) cstmt.getObject(2);
			ArrayList lista = new ArrayList();
			SSuplementarioDTO servicioSuplementario;
			while (rs.next()) {			
				servicioSuplementario = new SSuplementarioDTO();
				servicioSuplementario.setCod_servicio(rs.getString(1));
				lista.add(servicioSuplementario);
			}

			ServiciosSuplementarios = (SSuplementarioDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), SSuplementarioDTO.class);

			if (codError != 0) {
				logger.error("Ocurrió un error general al obtener los servicios blackberry definidos para el abonado.");
				throw new ProductException(String.valueOf(codError), numEvento, msgError);
			} // if

			// obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");

		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger
			.error("Ocurrió un error general al obtener los servicios blackberry definidos para el abonado.", e);
			throw new ProductException("Ocurrió un error general al obtener los servicios blackberry definidos para el abonado.", e);
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
		logger.debug("getServiciosBBContratados():end");
		return ServiciosSuplementarios;
		
	} // getServiciosBBContratados
	
	// ----------------------------------------------------------------------------------------------------------------------------------------
	
	public GaServSupDefDTO[] getObtieneListCodServPorDef(GaServSupDefDTO gaServSupDefDTO) throws ProductException {


		logger.debug("getObtieneListCodServPorDef():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		GaServSupDefDTO[] listGaServSupDefDTO = null;
		Connection conn = null;
		CallableStatement cstmt = null;

		try {

			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			String call = getSQLServSuplDefecto();
			cstmt = conn.prepareCall(call);

			logger.debug("Parámetros de entrada");
			logger.debug("Código de Servicio [" + gaServSupDefDTO.getCodServicio() + "]");
			logger.debug("Tipo Relación [" + gaServSupDefDTO.getTipRelacion() + "]");
			
			
			cstmt.setString(1, gaServSupDefDTO.getCodServicio());
			cstmt.setLong(2, gaServSupDefDTO.getTipRelacion());
						
			cstmt.registerOutParameter(3,oracle.jdbc.driver.OracleTypes.CURSOR);
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
				logger.error(" Ocurrió un error general al obtener Lista de código de servicio por defecto");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}
			// obtener info del cliente y completar respuesta

			logger.debug("Recuperando cursor...");

			ResultSet rs = (ResultSet) cstmt.getObject(3);

			ArrayList lista = new ArrayList();

			while (rs.next()) {
				GaServSupDefDTO regla = new GaServSupDefDTO();
							
				regla.setCodServicio(rs.getString(1));
				regla.setCodServicioDef(rs.getString(2));                                       
				regla.setFecDesde(rs.getTimestamp(3));
				regla.setNomUsuario(rs.getString(4));
				regla.setFecHasta(rs.getTimestamp(5));
				regla.setCodServicioOrig(rs.getString(6));
				regla.setTipRelacion(rs.getInt(7));
				lista.add(regla);
			}
			listGaServSupDefDTO = (GaServSupDefDTO[])ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), GaServSupDefDTO.class);

		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger.error(" Ocurrió un error general al obtener al obtener Lista de código de servicio por defecto",	e);
			throw new ProductException(" Ocurrió un error general al obtener Lista de código de servicio por defecto",e);
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
		logger.debug("getObtieneListCodServPorDef():end");
		return listGaServSupDefDTO;
	}
	
//	 ----------------------------------------------------------------------------------------------------------------------------------------

	public GaServSuPlDTO getEstadoCorreoServSupl(GaServSuPlDTO gaServSuPlDTO) throws ProductException {

		logger.debug("getEstadoCorreoServSupl():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		String call = getSQLEstadoCorreoServSupl();
		GaServSuPlDTO retValue=new GaServSuPlDTO();
		try {

			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());

			cstmt = conn.prepareCall(call);
			logger.debug("Parámetros de entrada");
			logger.debug("Numero Abonado [" + gaServSuPlDTO.getNumAbonado()+ "]");
			logger.debug("Estado [" + gaServSuPlDTO.getEstado() + "]");
			
			cstmt.setLong(1, gaServSuPlDTO.getNumAbonado());
			cstmt.setString(2,gaServSuPlDTO.getEstado());
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
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
				logger.error(" Ocurrió un error general al obtener estado de servicio de correo");
				throw new ProductException(String.valueOf(codError), numEvento,
						msgError);
			}
			
			retValue.setCodServsupl(cstmt.getInt(3));  //
			retValue.setCodNivel(cstmt.getInt(4));
			retValue.setEstado(cstmt.getString(5));//Plataforma

			logger.debug("Recuperando data...");

		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger.error("Ocurrió un error general al obtener estado de servicio de correo", e);
			throw new ProductException("Ocurrió un error general al obtener estado de servicio de correo", e);
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
		logger.debug("getEstadoCorreoServSupl():end");
		
		return retValue;
	}
	
	// ----------------------------------------------------------------------------------------------------------------------------------------
	
	public GaAboMailTODTO[] getAbomailTOxNumAbonado (GaAboMailTODTO gaAboMailTODTO)throws  ProductException{
		logger.debug("getObtieneListCodServPorDef():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		GaAboMailTODTO[] listGaAboMailTODTO = null;
		Connection conn = null;
		CallableStatement cstmt = null;

		try {

			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			String call = getSQLGaAboMailTO();
			cstmt = conn.prepareCall(call);

			logger.debug("Parámetros de entrada");
			logger.debug("Numero Abonado [" + gaAboMailTODTO.getNumAbonado() + "]");
			
			
			cstmt.setLong(1, gaAboMailTODTO.getNumAbonado());
			
						
			cstmt.registerOutParameter(2,oracle.jdbc.driver.OracleTypes.CURSOR);
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
				logger.error(" Ocurrió un error general al obtener registro de correo tabla ga_abomail_to");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}
			// obtener info del cliente y completar respuesta

			logger.debug("Recuperando cursor...");

			ResultSet rs = (ResultSet) cstmt.getObject(2);

			ArrayList lista = new ArrayList();

			while (rs.next()) {
				GaAboMailTODTO regla = new GaAboMailTODTO();
				regla.setNumAbonado(rs.getLong(1));
				regla.setCodProducto(rs.getLong(2));
				regla.setCodServicio(rs.getString(3));
				regla.setAbomail(rs.getString(4));
				regla.setUsername(rs.getString(5));
				regla.setPasswAbo(rs.getString(6));
				regla.setUsuario(rs.getString(7));
				regla.setFechaAlta(rs.getTimestamp(8));
				regla.setObservacion(rs.getString(9));
				regla.setIndEstado(rs.getLong(10));
				regla.setFecBaja(rs.getTimestamp(11));
				
				lista.add(regla);
			}
			listGaAboMailTODTO = (GaAboMailTODTO[])ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), GaAboMailTODTO.class);

		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger.error(" Ocurrió un error general al obtener al registro de correo tabla ga_abomail_to",	e);
			throw new ProductException(" Ocurrió un error general al registro de correo tabla ga_abomail_to",e);
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
		logger.debug("getObtieneListCodServPorDef():end");
		return listGaAboMailTODTO;
		
		
	}
	
}  // ServiciosSuplementariosDAO

