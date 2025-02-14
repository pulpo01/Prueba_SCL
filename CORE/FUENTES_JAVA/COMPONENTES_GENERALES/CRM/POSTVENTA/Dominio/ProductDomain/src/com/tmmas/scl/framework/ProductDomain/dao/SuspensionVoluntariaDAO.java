package com.tmmas.scl.framework.ProductDomain.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.Formatting;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.ProductDomain.dao.interfaces.SuspensionVoluntariaDAOIT;
import com.tmmas.scl.framework.ProductDomain.exception.ProductException;
import com.tmmas.scl.framework.ProductDomain.helper.Global;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CausasSuspensionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.DatosGeneralesSuspensionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.FechasSuspensionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.PeriodoSuspencionAbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.SuspensionAbonadoDTO;

public class SuspensionVoluntariaDAO extends ConnectionDAO implements SuspensionVoluntariaDAOIT{

	private final Logger logger = Logger.getLogger(SuspensionVoluntariaDAO.class);
	private final Global global = Global.getInstance();
		
	private String getSQLgetRecSuspensionAboando()	{
		StringBuffer call = new StringBuffer();		
		call.append("DECLARE "); 
		call.append("	pv_det_suspvolprog    pv_det_suspvolprog_qt := NEW pv_det_suspvolprog_qt; ");
		call.append("	resp                  boolean; ");		
		call.append("BEGIN  ");		
		call.append("	pv_det_suspvolprog.num_det_sus_vol_prg := ?; ");				
		call.append("	resp := PV_SUSPVOLPROG_PG.ga_rec_susp_volprog_fn(pv_det_suspvolprog, ?, ?, ? ); ");
		call.append("	?:= pv_det_suspvolprog.num_det_sus_vol_prg;");
		call.append("	?:= pv_det_suspvolprog.num_abonado;");
		call.append("	?:= pv_det_suspvolprog.num_periodosusp_1;");
    	call.append("	?:= pv_det_suspvolprog.num_periodosusp_2;");
		call.append("	?:= pv_det_suspvolprog.fec_solicitud;");
		call.append("	?:= pv_det_suspvolprog.fec_suspension;");
		call.append("	?:= pv_det_suspvolprog.fec_rehabilitacion;");
		call.append("	?:= pv_det_suspvolprog.fec_actualizacion;");
        call.append("	?:= pv_det_suspvolprog.dias_periodosusp_1;");
        call.append("	?:= pv_det_suspvolprog.dias_periodosusp_2;");
        call.append("	?:= pv_det_suspvolprog.estado;");
        call.append("	?:= pv_det_suspvolprog.cod_causal;");
        call.append("	?:= pv_det_suspvolprog.usuario;");
        call.append("	?:= pv_det_suspvolprog.num_os_sus;");
        call.append("	?:= pv_det_suspvolprog.num_os_reh;");							
		call.append("END; ");		
		return call.toString(); 		 		
	}	
	
	private String getSQLgetmodificarSuspension()	{
		StringBuffer call = new StringBuffer();		
		call.append("DECLARE "); 
		call.append("	pv_det_suspvolprog    pv_det_suspvolprog_qt := NEW pv_det_suspvolprog_qt; ");
		call.append("BEGIN  ");		
		call.append("	pv_det_suspvolprog.num_det_sus_vol_prg := ?; ");
		call.append("	pv_det_suspvolprog.num_abonado := ?; ");
		call.append("	pv_det_suspvolprog.num_periodosusp_1 := ?; ");
    	call.append("	pv_det_suspvolprog.num_periodosusp_2 := ?; ");
		call.append("	pv_det_suspvolprog.fec_solicitud := ?; ");
		call.append("	pv_det_suspvolprog.fec_suspension := ?; ");
		call.append("	pv_det_suspvolprog.fec_rehabilitacion := ?; ");
		call.append("	pv_det_suspvolprog.fec_actualizacion := ?; ");
        call.append("	pv_det_suspvolprog.dias_periodosusp_1 := ?; ");
        call.append("	pv_det_suspvolprog.dias_periodosusp_2 := ?; ");
        call.append("	pv_det_suspvolprog.estado := ?; ");
        call.append("	pv_det_suspvolprog.cod_causal := ?; ");
        call.append("	pv_det_suspvolprog.usuario := ?; ");
        call.append("	pv_det_suspvolprog.num_os_sus := ?; ");
        call.append("	pv_det_suspvolprog.num_os_reh := ?; ");				
		call.append("	PV_SUSPVOLPROG_PG.ga_modifica_suspension_pr(pv_det_suspvolprog, ?, ?, ? ); ");
		call.append("END; ");		
		return call.toString(); 		 		
	}
	
	private String getSQLgetAnularSuspension()	{
		StringBuffer call = new StringBuffer();		
		call.append("DECLARE "); 
		call.append("	pv_det_suspvolprog    pv_det_suspvolprog_qt := NEW pv_det_suspvolprog_qt; ");
		call.append("BEGIN  ");		
		call.append("	pv_det_suspvolprog.num_det_sus_vol_prg := ?; ");
		call.append("	pv_det_suspvolprog.num_abonado := ?; ");
		call.append("	pv_det_suspvolprog.num_periodosusp_1 := ?; ");
    	call.append("	pv_det_suspvolprog.num_periodosusp_2 := ?; ");
		call.append("	pv_det_suspvolprog.fec_solicitud := ?; ");
		call.append("	pv_det_suspvolprog.fec_suspension := ?; ");
		call.append("	pv_det_suspvolprog.fec_rehabilitacion := ?; ");
		call.append("	pv_det_suspvolprog.fec_actualizacion := ?; ");
        call.append("	pv_det_suspvolprog.dias_periodosusp_1 := ?; ");
        call.append("	pv_det_suspvolprog.dias_periodosusp_2 := ?; ");
        call.append("	pv_det_suspvolprog.estado := ?; ");
        call.append("	pv_det_suspvolprog.cod_causal := ?; ");
        call.append("	pv_det_suspvolprog.usuario := ?; ");
        call.append("	pv_det_suspvolprog.num_os_sus := ?; ");
        call.append("	pv_det_suspvolprog.num_os_reh := ?; ");		
		call.append("	PV_SUSPVOLPROG_PG.ga_anula_susvolprog_pr(pv_det_suspvolprog, ?, ?, ? ); ");
		call.append("END; ");

		return call.toString(); 		 		
	}	
	
	
	private String getSQLDatos(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
        for (int n = 1; n <= paramCount; n++) {
            sb.append("?");
            if (n < paramCount) sb.append(",");
        }
        return sb.append(")}").toString();
	}//fin getSQLDatos
	
	public CausasSuspensionDTO[] obtenerCausasSuspension() throws ProductException {
		logger.debug("obtenerCausasSuspension():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		CausasSuspensionDTO[] causasSuspensiones; 
		String call = getSQLDatos("pv_suspvolprog_pg","ga_rec_causa_suspension_pr",4);

		try {

			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			cstmt = conn.prepareCall(call);
			
			logger.debug("Procedimiento a ejecutar ["+call+"]");
			
			logger.debug("Parámetros de entrada");
			
												
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
				.error(" Ocurrió un error general al obtener Causas de Suspension Voluntaria");
				throw new ProductException(String.valueOf(codError),
						numEvento, msgError);
			}			

			logger.debug("Recuperando data...");			
			
			logger.debug("Recuperando cursor...");
			logger.debug("object="+cstmt.getObject(1));

			ResultSet rs = (ResultSet) cstmt.getObject(1);
			ArrayList lista = new ArrayList();
			CausasSuspensionDTO causasSuspension;
			while (rs.next()) {			
				causasSuspension = new CausasSuspensionDTO();

				causasSuspension.setCodigoCausa(rs.getString(1));
				causasSuspension.setDescripcionCausa(rs.getString(2));
				
				lista.add(causasSuspension);
			}

			causasSuspensiones = (CausasSuspensionDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), CausasSuspensionDTO.class);


		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger
			.error(
					"Ocurrió un error general al obtener Causas de Suspension Voluntaria",
					e);
			throw new ProductException(
					"Ocurrió un error general al obtener Causas de Suspension Voluntaria",
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
		logger.debug("obtenerCausasSuspension():end");
		return causasSuspensiones;
	}

	public DatosGeneralesSuspensionDTO obtenerDatosGeneralesSuspension() throws ProductException {
		// TODO Auto-generated method stub
		logger.debug("obtenerDatosGeneralesSuspension():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		DatosGeneralesSuspensionDTO DatosGeneralesSuspension = new DatosGeneralesSuspensionDTO(); 
		String call = getSQLDatos("pv_suspvolprog_pg","ga_param_general_susp_vol_pr",5);

		try {

			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			cstmt = conn.prepareCall(call);
			
			logger.debug("Procedimiento a ejecutar ["+call+"]");
			
			logger.debug("Parámetros de entrada");		
			
			cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);											
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
				logger
				.error("Ocurrió un error general al obtener parámetros generales de suspensión voluntaria");
				throw new ProductException(String.valueOf(codError),
						numEvento, msgError);
			}
			
			
			logger.debug("Recuperando data...");
			
			DatosGeneralesSuspension.setMaxDiasSuspVol(cstmt.getInt(1));
			logger.debug("MaxDiasSuspVol[" + DatosGeneralesSuspension.getMaxDiasSuspVol() + "]");
			
			DatosGeneralesSuspension.setMaxDiasAntelacionSusp(cstmt.getInt(2));
			logger.debug("MaxDiasAntelacionSusp[" + DatosGeneralesSuspension.getMaxDiasAntelacionSusp() + "]");			

		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger
			.error(
					"Ocurrió un error general al obtener parámetros generales de suspensión voluntaria",
					e);
			throw new ProductException(
					"Ocurrió un error general al obtener parámetros generales de suspensión voluntaria",
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
		logger.debug("obtenerDatosGeneralesSuspension():end");
		return DatosGeneralesSuspension;
		
	}

	public SuspensionAbonadoDTO[] obtenerSuspensionesAbonado(UsuarioAbonadoDTO usuarioAbonado) throws ProductException {
		// TODO Auto-generated method stub
		logger.debug("obtenerSuspensionesAbonado():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		SuspensionAbonadoDTO[] SuspensionesAbonado; 
		String call = getSQLDatos("pv_suspvolprog_pg","ga_cons_suspension_vol_pr",5);

		try {

			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			cstmt = conn.prepareCall(call);
			
			logger.debug("Procedimiento a ejecutar ["+call+"]");
			
			logger.debug("Parámetros de entrada");		
			logger.debug("Num_abonado ["+ usuarioAbonado.getNum_abonado() + "]");
			
			cstmt.setLong(1, usuarioAbonado.getNum_abonado()  );								
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

			logger.debug("Recuperando data...");
			
			logger.debug("Recuperando cursor...");
			logger.debug("object="+cstmt.getObject(2));

			ResultSet rs = (ResultSet) cstmt.getObject(2);
			ArrayList lista = new ArrayList();
			SuspensionAbonadoDTO SuspensionAbonado;
			CausasSuspensionDTO causasSuspension;
			while (rs.next()) {			
				SuspensionAbonado = new SuspensionAbonadoDTO();
				causasSuspension = new CausasSuspensionDTO();
				
				SuspensionAbonado.setNum_det_sus_vol_prg(rs.getLong(1));				
				SuspensionAbonado.setNum_abonado(rs.getLong(2));
				SuspensionAbonado.setNumPeriodoSus1(rs.getLong(3));
				SuspensionAbonado.setNumPeriodoSus2(rs.getLong(4));
				SuspensionAbonado.setFechaSolicitud(new java.util.Date(rs.getDate(5).getTime()));				
				SuspensionAbonado.setFechaSuspension(new java.util.Date(rs.getDate(6).getTime()));				
				SuspensionAbonado.setFechaRehabilitacion(new java.util.Date(rs.getDate(7).getTime()));				
				SuspensionAbonado.setFechaActualizacion(new java.util.Date( rs.getDate(8).getTime()));				
				SuspensionAbonado.setDiasSus1(rs.getLong(9));
				SuspensionAbonado.setDiasSus2(rs.getLong(10));
				SuspensionAbonado.setEstado(rs.getString(11));
				causasSuspension.setCodigoCausa(rs.getString(12));
				causasSuspension.setDescripcionCausa(rs.getString(13));				
				SuspensionAbonado.setCausaSuspension(causasSuspension);				
				SuspensionAbonado.setUsuario(rs.getString(14));				
				SuspensionAbonado.setNumOsSus(rs.getLong(15));
				SuspensionAbonado.setNumOsReh(rs.getLong(16));
						
				lista.add(SuspensionAbonado);																		
			}


			
			SuspensionesAbonado = (SuspensionAbonadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), SuspensionAbonadoDTO.class);

			if (codError != 0) {
				logger
				.error("Ocurrió un error general al obtener Suspension Voluntarias de Abonado");
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
					"Ocurrió un error general al obtener Suspension Voluntarias de Abonado",
					e);
			throw new ProductException(
					"Ocurrió un error general al obtener Suspension Voluntarias de Abonado",
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
		logger.debug("obtenerSuspensionesAbonado():end");
		return SuspensionesAbonado;
		
		
		
	}
	
	
	public SuspensionAbonadoDTO[] obtenerSuspensionesHistoricasAbonado(long numAbonado, java.sql.Date fecIni, java.sql.Date fecFin ) throws ProductException {
		// TODO Auto-generated method stub
		logger.debug("obtenerSuspensionesHistoricasAbonado():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		SuspensionAbonadoDTO[] SuspensionesAbonado; 
		
		String call = getSQLDatos("pv_suspvolprog_pg","ga_cons_hist_suspension_vol_pr",7);
		
		try {

			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			cstmt = conn.prepareCall(call);
			
			logger.debug("Procedimiento a ejecutar ["+call+"]");
			
			logger.debug("Parámetros de entrada");		
			logger.debug("Num_abonado ["+ numAbonado + "]");
			logger.debug("Fec_Inicio ["+ fecIni + "]");
			logger.debug("Fec_Fin ["+ fecFin + "]");
			
			cstmt.setLong(1, numAbonado);			
			cstmt.setDate(2, fecIni);
			cstmt.setDate(3, fecFin);
			
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

			logger.debug("Recuperando data...");
			
			logger.debug("Recuperando cursor...");
			logger.debug("object="+cstmt.getObject(4));

			ResultSet rs = (ResultSet) cstmt.getObject(4);
			ArrayList lista = new ArrayList();
			SuspensionAbonadoDTO SuspensionAbonado;
			CausasSuspensionDTO causasSuspension;
			while (rs.next()) {			
				SuspensionAbonado = new SuspensionAbonadoDTO();
				causasSuspension = new CausasSuspensionDTO();
								
				SuspensionAbonado.setNum_det_sus_vol_prg(rs.getLong(1)); 
				SuspensionAbonado.setNum_abonado(rs.getLong(2));
				SuspensionAbonado.setNumPeriodoSus1(rs.getLong(3));
				SuspensionAbonado.setNumPeriodoSus2(rs.getLong(4));
				SuspensionAbonado.setFechaSolicitud(new java.util.Date(rs.getDate(5).getTime()));
				SuspensionAbonado.setFechaSuspension(new java.util.Date(rs.getDate(6).getTime()));
				SuspensionAbonado.setFechaRehabilitacion(new java.util.Date(rs.getDate(7).getTime()));
				SuspensionAbonado.setFechaActualizacion(new java.util.Date(rs.getDate(8).getTime()));
				SuspensionAbonado.setDiasSus1(rs.getLong(9));
				SuspensionAbonado.setDiasSus2(rs.getLong(10));
				SuspensionAbonado.setEstado(rs.getString(11));
				causasSuspension.setCodigoCausa(rs.getString(12));
				causasSuspension.setDescripcionCausa(rs.getString(13));
				SuspensionAbonado.setCausaSuspension(causasSuspension);
				SuspensionAbonado.setUsuario(rs.getString(14));
				SuspensionAbonado.setNumOsSus(rs.getLong(15));
				SuspensionAbonado.setNumOsReh(rs.getLong(16));
									
				lista.add(SuspensionAbonado);
			}

			SuspensionesAbonado = (SuspensionAbonadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), SuspensionAbonadoDTO.class);

			if (codError != 0) {
				logger
				.error("Ocurrió un error general al obtener Suspension Voluntaria Historicas de Abonado");
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
					"Ocurrió un error general al obtener Suspension Voluntaria Historicas de Abonado",
					e);
			throw new ProductException(
					"Ocurrió un error general al obtener Suspension Voluntaria Historicas de Abonado",
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
		logger.debug("obtenerSuspensionesHistoricasAbonado():end");
		return SuspensionesAbonado;
					
	}	
	
	public PeriodoSuspencionAbonadoDTO[] obtenerPeriodosSuspensioAbonado(UsuarioAbonadoDTO usuarioAbonado ) throws ProductException {
		logger.debug("obtenerPeriodosSuspensioAbonado():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		PeriodoSuspencionAbonadoDTO[] PeriodosSuspencionesAbonado; 
		
		String call = getSQLDatos("pv_suspvolprog_pg","ga_rec_periodo_suspension_pr",5);
		
		try {

			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			cstmt = conn.prepareCall(call);
			
			logger.debug("Procedimiento a ejecutar ["+call+"]");
			
			logger.debug("Parámetros de entrada");		
			logger.debug("Num_abonado ["+ usuarioAbonado.getNum_abonado() + "]");

			
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

			logger.debug("Recuperando data...");
			
			logger.debug("Recuperando cursor...");
			logger.debug("object="+cstmt.getObject(2));

			ResultSet rs = (ResultSet) cstmt.getObject(2);
			ArrayList lista = new ArrayList();
			PeriodoSuspencionAbonadoDTO PeriodoSuspencionAbonado;

			while (rs.next()) {			
				PeriodoSuspencionAbonado = new PeriodoSuspencionAbonadoDTO();						
				
				PeriodoSuspencionAbonado.setNumPeriodoSus(rs.getLong(1));
				PeriodoSuspencionAbonado.setNum_abonado(rs.getLong(2));
				PeriodoSuspencionAbonado.setCod_cliente(rs.getLong(3));
				PeriodoSuspencionAbonado.setFechaInicio(rs.getDate(4));;
				PeriodoSuspencionAbonado.setFechaFin(rs.getDate(5));
				PeriodoSuspencionAbonado.setDiasAcumulados(rs.getLong(6));
														
				lista.add(PeriodoSuspencionAbonado);
			}

			PeriodosSuspencionesAbonado = (PeriodoSuspencionAbonadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), PeriodoSuspencionAbonadoDTO.class);

			if (codError != 0) {
				logger
				.error(" Ocurrió un error general al obtener Periodos de Suspensión de Abonados");
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
					"Ocurrió un error general al obtener Periodos de Suspensión de Abonados",
					e);
			throw new ProductException(
					"Ocurrió un error general al obtener Periodos de Suspensión de Abonados",
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
		logger.debug("obtenerPeriodosSuspensioAbonado():end");
		return PeriodosSuspencionesAbonado;
					
	}

	public void modificarSuspension(SuspensionAbonadoDTO suspensionAbonado) throws ProductException {
		logger.debug("modificarSuspension():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;

		try {

			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			String call = getSQLgetmodificarSuspension();
			cstmt = conn.prepareCall(call);

			logger.debug("Parámetros de entrada");
			logger.debug("Num_det_sus_vol_prg [" + suspensionAbonado.getNum_det_sus_vol_prg()              + "]");
			logger.debug("Num_abonado         [" + suspensionAbonado.getNum_abonado()                      + "]");
			logger.debug("NumPeriodoSus1      [" + suspensionAbonado.getNumPeriodoSus1()                   + "]");
			logger.debug("NumPeriodoSus2      [" + suspensionAbonado.getNumPeriodoSus2()                   + "]");
			logger.debug("FechaSolicitud      [" + suspensionAbonado.getFechaSolicitud()                   + "]");
			logger.debug("FechaSuspension     [" + suspensionAbonado.getFechaSuspension()                  + "]");
			logger.debug("FechaRehabilitacion [" + suspensionAbonado.getFechaRehabilitacion()              + "]");
			logger.debug("FechaActualizacion  [" + suspensionAbonado.getFechaActualizacion()               + "]");
			logger.debug("DiasSus1            [" + suspensionAbonado.getDiasSus1()                         + "]");
			logger.debug("DiasSus2            [" + suspensionAbonado.getDiasSus2()                         + "]");
			logger.debug("Estado              [" + suspensionAbonado.getEstado()                           + "]");
			logger.debug("CodigoCausa         [" + suspensionAbonado.getCausaSuspension().getCodigoCausa() + "]");
			logger.debug("Usuario             [" + suspensionAbonado.getUsuario()                          + "]");
			logger.debug("NumOsReh            [" + suspensionAbonado.getNumOsReh()                         + "]");
			logger.debug("NumOsSus            [" + suspensionAbonado.getNumOsSus()                         + "]");
												
			cstmt.setLong(1, suspensionAbonado.getNum_det_sus_vol_prg());	
			cstmt.setLong(2, suspensionAbonado.getNum_abonado());
			cstmt.setLong(3, suspensionAbonado.getNumPeriodoSus1());
			cstmt.setLong(4, suspensionAbonado.getNumPeriodoSus2());			
			cstmt.setDate(5, new java.sql.Date(suspensionAbonado.getFechaSolicitud().getTime()));			
			cstmt.setDate(6, new java.sql.Date(suspensionAbonado.getFechaSuspension().getTime()));
			cstmt.setDate(7, new java.sql.Date(suspensionAbonado.getFechaRehabilitacion().getTime()));
			cstmt.setDate(8, new java.sql.Date(suspensionAbonado.getFechaActualizacion().getTime()));			
			cstmt.setLong(9, suspensionAbonado.getDiasSus1());
			cstmt.setLong(10, suspensionAbonado.getDiasSus2());						
			cstmt.setString(11, suspensionAbonado.getEstado());
			cstmt.setString(12, suspensionAbonado.getCausaSuspension().getCodigoCausa());
			cstmt.setString(13, suspensionAbonado.getUsuario());
			cstmt.setLong(14, suspensionAbonado.getNumOsReh());
			cstmt.setLong(15, suspensionAbonado.getNumOsSus());										
			cstmt.registerOutParameter(16, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(18, java.sql.Types.NUMERIC);

			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");

			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(16);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(17);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(18);
			logger.debug("numEvento[" + numEvento + "]");


			if (codError != 0) {
				logger.error("Ocurrió un error general al modificar Suspensión voluntaria");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}
			// obtener info del cliente y completar respuesta

		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger.error("Ocurrió un error general al modificar Suspensión voluntaria",	e);
			throw new ProductException("Ocurrió un error general al modificar Suspensión voluntaria",e);
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
		logger.debug("modificarSuspension():end");		
	}	

	public void programarSuspension(SuspensionAbonadoDTO suspensionAbonado, ClienteOSSesionDTO sessionData) throws ProductException {
		logger.debug("programarSuspension():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLDatos("pv_suspvolprog_pg","ga_ins_suspension_prg_pr",11);
		
		try {

			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			cstmt = conn.prepareCall(call);
			
			logger.debug("Procedimiento a ejecutar ["+call+"]");
		
			logger.debug("Parámetros de entrada");
			logger.debug("Num_abonado         [" + suspensionAbonado.getNum_abonado()                      + "]");
			logger.debug("FechaSuspension     [" + suspensionAbonado.getFechaSuspension()                  + "]");
			logger.debug("FechaRehabilitacion [" + suspensionAbonado.getFechaRehabilitacion()              + "]");
			logger.debug("CodigoCausa         [" + suspensionAbonado.getCausaSuspension().getCodigoCausa() + "]");
			logger.debug("Usuario             [" + suspensionAbonado.getUsuario()                          + "]");
			logger.debug("NumOsReh            [" + suspensionAbonado.getNumOsReh()                         + "]");
			logger.debug("NumOsSus            [" + suspensionAbonado.getNumOsSus()                         + "]");					
			logger.debug("ComentarioOS        [" + sessionData.getComentarioOS()                           + "]");
			
			logger.debug("Fechas Antes de Ejecutar");
			
			logger.debug("FechaSuspension Formatting ["+ Formatting.dateTime(suspensionAbonado.getFechaSuspension(),"dd-MM-yyyy") + "]");
			logger.debug("FechaRehabilitacion Formatting["+ Formatting.dateTime(suspensionAbonado.getFechaRehabilitacion(),"dd-MM-yyyy")+ "]");
			
			
			cstmt.setLong(1, suspensionAbonado.getNum_abonado());
			cstmt.setDate(2, new java.sql.Date(suspensionAbonado.getFechaSuspension().getTime()));
			cstmt.setDate(3, new java.sql.Date(suspensionAbonado.getFechaRehabilitacion().getTime()));
			cstmt.setString(4, suspensionAbonado.getCausaSuspension().getCodigoCausa());
			cstmt.setString(5, suspensionAbonado.getUsuario());
			cstmt.setLong(6, suspensionAbonado.getNumOsSus() );
			cstmt.setLong(7, suspensionAbonado.getNumOsReh());
			cstmt.setString(8, sessionData.getComentarioOS());			
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

			logger.debug("Recuperando data...");
			

			if (codError != 0) {
				logger
				.error("Ocurrió un error general al agregar Suspensión de Abonado");
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
					"Ocurrió un error general al agregar Suspensión de Abonado",
					e);
			throw new ProductException(
					"Ocurrió un error general al agregar Suspensión de Abonado",
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
		logger.debug("programarSuspension():end");
		
	}	
	
	
	public FechasSuspensionDTO[] recuperarFechasSuspension(ClienteOSSesionDTO sessionData) throws ProductException {
		logger.debug("recuperarFechasSuspension():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		FechasSuspensionDTO[] FechasSuspension;
		
		String call = getSQLDatos("pv_suspvolprog_pg","ga_rec_fec_susp_vol_pr",5);
		
		try {

			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			cstmt = conn.prepareCall(call);
			
			logger.debug("Procedimiento a ejecutar ["+call+"]");

			logger.debug("Parámetros de entrada");							
			
			cstmt.setLong(1, sessionData.getNumAbonado());			
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
				.error("Ocurrió un error general al recuperar fechas de  Suspensión");
				throw new ProductException(String.valueOf(codError),
						numEvento, msgError);
			}			

			logger.debug("Recuperando data...");			
			
			logger.debug("Recuperando cursor...");
			logger.debug("object="+cstmt.getObject(2));

			ResultSet rs = (ResultSet) cstmt.getObject(2);
			ArrayList lista = new ArrayList();
			FechasSuspensionDTO FechaSuspension;
			while (rs.next()) {											
				FechaSuspension = new FechasSuspensionDTO();

				FechaSuspension.setFechaSuspencion(rs.getDate(1));											
				lista.add(FechaSuspension);
			}
			FechasSuspension = (FechasSuspensionDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), FechasSuspensionDTO.class);			

		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger
			.error(
					"Ocurrió un error general al recuperar fechas de  Suspensión",
					e);
			throw new ProductException(
					"Ocurrió un error general al recuperar fechas de  Suspensión",
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
		logger.debug("recuperarFechasSuspension():end");
		return FechasSuspension;
	}	

	
	public void agregaPeriodoSuspension(PeriodoSuspencionAbonadoDTO periodoSuspencionAbonado) throws ProductException {
		logger.debug("agregaPeriodoSuspension():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLDatos("pv_suspvolprog_pg","ga_ins_periodo_suspension_pr",6);
		
		try {

			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			cstmt = conn.prepareCall(call);
			
			logger.debug("Procedimiento a ejecutar ["+call+"]");
			

			logger.debug("Parámetros de entrada");	

			logger.debug("Parámetros de entrada");		
			logger.debug("Num_abonado ["+ periodoSuspencionAbonado.getNum_abonado() + "]");			
			logger.debug("FechaInicio ["+ periodoSuspencionAbonado.getFechaInicio() + "]");
			logger.debug("FechaFin ["+ periodoSuspencionAbonado.getFechaFin() + "]");
			logger.debug("DiasAcumulados ["+ periodoSuspencionAbonado.getDiasAcumulados() + "]");
			
			
			cstmt.setLong(1, periodoSuspencionAbonado.getNum_abonado() );
			cstmt.setNull(2,java.sql.Types.DATE );
			cstmt.setNull(3,java.sql.Types.DATE );
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
				.error("Ocurrió un error general al agregar periodo de  Suspensión");
				throw new ProductException(String.valueOf(codError),
						numEvento, msgError);
			}			

			logger.debug("Recuperando data...");			
						

		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger
			.error(
					"Ocurrió un error general al agregar periodo de  Suspensión",
					e);
			throw new ProductException(
					"Ocurrió un error general al agregar periodo de  Suspensión",
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
		logger.debug("agregaPeriodoSuspension():end");

	}	
	
	public void anularSuspension(SuspensionAbonadoDTO suspensionAbonado) throws ProductException{
		logger.debug("anularSuspension():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;

		try {

			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			String call = getSQLgetAnularSuspension();
			cstmt = conn.prepareCall(call);

			logger.debug("Parámetros de entrada");
			logger.debug("Num_det_sus_vol_prg [" + suspensionAbonado.getNum_det_sus_vol_prg()              + "]");
			logger.debug("Num_abonado         [" + suspensionAbonado.getNum_abonado()                      + "]");
			logger.debug("NumPeriodoSus1      [" + suspensionAbonado.getNumPeriodoSus1()                   + "]");
			logger.debug("NumPeriodoSus2      [" + suspensionAbonado.getNumPeriodoSus2()                   + "]");
			logger.debug("FechaSolicitud      [" + suspensionAbonado.getFechaSolicitud()                   + "]");
			logger.debug("FechaSuspension     [" + suspensionAbonado.getFechaSuspension()                  + "]");
			logger.debug("FechaRehabilitacion [" + suspensionAbonado.getFechaRehabilitacion()              + "]");
			logger.debug("FechaActualizacion  [" + suspensionAbonado.getFechaActualizacion()               + "]");
			logger.debug("DiasSus1            [" + suspensionAbonado.getDiasSus1()                         + "]");
			logger.debug("DiasSus2            [" + suspensionAbonado.getDiasSus2()                         + "]");
			logger.debug("Estado              [" + suspensionAbonado.getEstado()                           + "]");
			logger.debug("CodigoCausa         [" + suspensionAbonado.getCausaSuspension().getCodigoCausa() + "]");
			logger.debug("Usuario             [" + suspensionAbonado.getUsuario()                          + "]");
			logger.debug("NumOsReh            [" + suspensionAbonado.getNumOsReh()                         + "]");
			logger.debug("NumOsSus            [" + suspensionAbonado.getNumOsSus()                         + "]");
			
			
			cstmt.setLong(1, suspensionAbonado.getNum_det_sus_vol_prg());	
			cstmt.setLong(2, suspensionAbonado.getNum_abonado());
			cstmt.setLong(3, suspensionAbonado.getNumPeriodoSus1());
			cstmt.setLong(4, suspensionAbonado.getNumPeriodoSus2());			
			cstmt.setDate(5, new java.sql.Date(suspensionAbonado.getFechaSolicitud().getTime()));			
			cstmt.setDate(6, new java.sql.Date(suspensionAbonado.getFechaSuspension().getTime()));
			cstmt.setDate(7, new java.sql.Date(suspensionAbonado.getFechaRehabilitacion().getTime()));
			cstmt.setDate(8, new java.sql.Date(suspensionAbonado.getFechaActualizacion().getTime()));			
			cstmt.setLong(9, suspensionAbonado.getDiasSus1());
			cstmt.setLong(10, suspensionAbonado.getDiasSus2());						
			cstmt.setString(11, suspensionAbonado.getEstado());
			cstmt.setString(12, suspensionAbonado.getCausaSuspension().getCodigoCausa());
			cstmt.setString(13, suspensionAbonado.getUsuario());
			cstmt.setLong(14, suspensionAbonado.getNumOsReh());
			cstmt.setLong(15, suspensionAbonado.getNumOsSus());
										
			cstmt.registerOutParameter(16, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(18, java.sql.Types.NUMERIC);

			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");

			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(16);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(17);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(18);
			logger.debug("numEvento[" + numEvento + "]");


			if (codError != 0) {
				logger.error("Ocurrió un error general al anular Suspensión voluntaria");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}
			// obtener info del cliente y completar respuesta

		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger.error("Ocurrió un error general al anular Suspensión voluntaria",	e);
			throw new ProductException("Ocurrió un error general al anular Suspensión voluntaria",e);
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
		logger.debug("anularSuspension():end");		
	}
	
	public SuspensionAbonadoDTO recSuspencionAbonado(SuspensionAbonadoDTO suspensionAbonado) throws ProductException {
		logger.debug("recSuspencionAboando():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		SuspensionAbonadoDTO suspensionAbonadoR = new SuspensionAbonadoDTO(); 
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			String call = getSQLgetRecSuspensionAboando();
			cstmt = conn.prepareCall(call);

			logger.debug("Parámetros de entrada");
			logger.debug("Num_det_sus_vol_prg [" + suspensionAbonado.getNum_det_sus_vol_prg()              + "]");
									
			cstmt.setLong(1, suspensionAbonado.getNum_det_sus_vol_prg());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(9, java.sql.Types.DATE );
			cstmt.registerOutParameter(10, java.sql.Types.DATE);
			cstmt.registerOutParameter(11, java.sql.Types.DATE);
			cstmt.registerOutParameter(12, java.sql.Types.DATE);
			cstmt.registerOutParameter(13, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(14, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(15, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(18, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(19, java.sql.Types.NUMERIC);

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

			logger.debug("Recuperando Parámetros de salida");
			
			CausasSuspensionDTO causa = new CausasSuspensionDTO();
			
			suspensionAbonadoR.setNum_det_sus_vol_prg(cstmt.getInt(5));
			suspensionAbonadoR.setNum_abonado(cstmt.getInt(6));
			suspensionAbonadoR.setNumPeriodoSus1(cstmt.getInt(7));
			suspensionAbonadoR.setNumPeriodoSus2(cstmt.getInt(8));
			suspensionAbonadoR.setFechaSolicitud(cstmt.getDate(9));
			suspensionAbonadoR.setFechaSuspension(cstmt.getDate(10));
			suspensionAbonadoR.setFechaRehabilitacion(cstmt.getDate(11));
			suspensionAbonadoR.setFechaActualizacion(cstmt.getDate(12));
			suspensionAbonadoR.setDiasSus2(cstmt.getInt(13));
			suspensionAbonadoR.setDiasSus2(cstmt.getInt(14));
			suspensionAbonadoR.setEstado(cstmt.getString(15));
			causa.setCodigoCausa(cstmt.getString(16));
			suspensionAbonadoR.setUsuario(cstmt.getString(17));
			suspensionAbonadoR.setNumOsSus(cstmt.getInt(18));
			suspensionAbonadoR.setNumOsReh(cstmt.getInt(19));
			suspensionAbonadoR.setCausaSuspension(causa);


			if (codError != 0) {
				logger.error("Ocurrió un error general al recuperar Suspensión voluntaria");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}
			// obtener info del cliente y completar respuesta

		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		} catch (Exception e) {
			logger.error("Ocurrió un error general al recuperar Suspensión voluntaria",	e);
			throw new ProductException("Ocurrió un error general al recuperar Suspensión voluntaria",e);
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
		logger.debug("recSuspencionAboando():end");		
		return suspensionAbonadoR;
	}

	public void obtenerPeriodosHistAbonado(long numAbonado, SuspensionAbonadoDTO[] SuspensionAbonado) throws ProductException {
		// TODO Auto-generated method stub
		logger.debug("obtenerPeriodosHistAbonado():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		Map periodoMap = new HashMap();
		
		String call = getSQLDatos("pv_suspvolprog_pg","pv_rec_periodos_histabonado_pr",5);
		
		try {

			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			cstmt = conn.prepareCall(call);
			
			logger.debug("Procedimiento a ejecutar ["+call+"]");
			
			logger.debug("Parámetros de entrada");		
			logger.debug("Num_abonado ["+ numAbonado + "]");
			
			cstmt.setLong(1, numAbonado);			
			
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

			logger.debug("Recuperando data...");
			
			logger.debug("Recuperando cursor...");
			logger.debug("object="+cstmt.getObject(2));

			ResultSet rs = (ResultSet) cstmt.getObject(2);
			int j=0;
			while (rs.next()) {
				j++;
				PeriodoSuspencionAbonadoDTO PeriodoSuspencionAbonado = new PeriodoSuspencionAbonadoDTO();
				logger.debug("Cargando Objeto PeriodoSuspencionAbonado...");
				
				PeriodoSuspencionAbonado.setNumPeriodoSus(rs.getLong(1));
				PeriodoSuspencionAbonado.setCod_cliente(rs.getLong(2));
				PeriodoSuspencionAbonado.setFechaInicio(new java.util.Date(rs.getDate(3).getTime()));
				PeriodoSuspencionAbonado.setFechaFin(new java.util.Date(rs.getDate(4).getTime()));
				PeriodoSuspencionAbonado.setDiasAcumulados(rs.getLong(5));

				logger.debug("Registro " + j + ", Objeto PeriodoSuspencionAbonado...Cargado!!");
				
				periodoMap.put(new Long(PeriodoSuspencionAbonado.getNumPeriodoSus()), PeriodoSuspencionAbonado);

				logger.debug("Map " + j + ", Objeto PeriodoSuspencionAbonado...Cargado!!");
			}

			for(int i=0;i<SuspensionAbonado.length;i++){
				PeriodoSuspencionAbonadoDTO PeriodoSuspencionAbonado = null;
				PeriodoSuspencionAbonado = (PeriodoSuspencionAbonadoDTO) periodoMap.get(new Long(SuspensionAbonado[i].getNumPeriodoSus1()));
				
				logger.debug("-----objeto para periodosuspension1: " + PeriodoSuspencionAbonado);
				logger.debug("-----fecha de inicio: " + PeriodoSuspencionAbonado.getFechaInicio());
				logger.debug("-----fecha de fin: " + PeriodoSuspencionAbonado.getFechaFin());
				
				if (PeriodoSuspencionAbonado!=null) {
					SuspensionAbonado[i].setFechaInicioPeriodo1(PeriodoSuspencionAbonado.getFechaInicio());
					SuspensionAbonado[i].setFechaFinPeriodo1(PeriodoSuspencionAbonado.getFechaFin());
				}
				logger.debug("-----objeto para periodosuspension2: " + PeriodoSuspencionAbonado);
				logger.debug("-----fecha de inicio: " + PeriodoSuspencionAbonado.getFechaInicio());
				logger.debug("-----fecha de fin: " + PeriodoSuspencionAbonado.getFechaFin());
				
				PeriodoSuspencionAbonado = (PeriodoSuspencionAbonadoDTO) periodoMap.get(new Long(SuspensionAbonado[i].getNumPeriodoSus2()));
				if ((PeriodoSuspencionAbonado!=null) && (SuspensionAbonado[i].getNumPeriodoSus1()!=SuspensionAbonado[i].getNumPeriodoSus2())) {
					SuspensionAbonado[i].setFechaInicioPeriodo2(PeriodoSuspencionAbonado.getFechaInicio());
					SuspensionAbonado[i].setFechaFinPeriodo2(PeriodoSuspencionAbonado.getFechaFin());
				}
			}

			if (codError != 0) {
				logger
				.error("Ocurrió un error general al obtener Periodos Suspensión Historicos para consulta Historica de Abonado");
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
					"Ocurrió un error general al obtener Periodos Suspensión Historicos para consulta Historica de Abonado",
					e);
			throw new ProductException(
					"Ocurrió un error general al obtener Periodos Suspensión Historicos para consulta Historica de Abonado",
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
		logger.debug("obtenerPeriodosHistAbonado():end");
	}		
	
}
