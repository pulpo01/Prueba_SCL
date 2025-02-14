/**
 * Copyright © 2009 Telefonica Moviles, Soluciones y Aplicaciones, S.A.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informacion propietaria y confidencial de T-mAs S.A.
 * Usted no debe develar tal informacion y solo debe usarla en concordancia
 * con los terminos de derechos de licencias que sean adquiridos con T-mAs S.A.
 */
package com.tmmas.scl.wsportal.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Logger;

import com.tmmas.scl.wsportal.businessobject.dao.base.BaseDAO;
import com.tmmas.scl.wsportal.common.dto.CausalCambioDTO;
import com.tmmas.scl.wsportal.common.dto.ListaCausalCambioDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoReporteCamEquiGenDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoReporteIngrStatusEquiDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoReportePresEquiIntDTO;
import com.tmmas.scl.wsportal.common.dto.ReporteCamEquiGenDTO;
import com.tmmas.scl.wsportal.common.dto.ReporteIngrStatusEquiDTO;
import com.tmmas.scl.wsportal.common.dto.ReportePresEquiIntDTO;
import com.tmmas.scl.wsportal.common.exception.PortalSACException;

public class ReporteDAO extends BaseDAO
{
	private final Logger logger = Logger.getLogger(this.getClass());

	protected static final String CLAVE_TEXTO_PARA_DETALLE = "texto.detalle.producto";
	protected static final String TEXTO_PARA_DETALLE = config.getString(CLAVE_TEXTO_PARA_DETALLE);
	//protected static final String NOMBRE_PACKAGE_BD_SP_CONSULTASTP_PG = "SP_CONSULTASTP_PG";
	//Se cambia nombre del PKG
	protected static final String NOMBRE_PACKAGE_BD_SP_CONSULTASTP_PG = "PV_CONSULTA_STP_PG";
	

	public ReporteDAO(){
		
	}
	
	/**
	 * Cerrar recursos.
	 * @overwrite
	 * @param conn the conn
	 * @param cstmt the cstmt
	 * @param rs TODO
	 * @throws SQLException the SQL exception
	 *
	 */
	protected void cerrarRecursos(Connection conn, CallableStatement cstmt, ResultSet rs) throws SQLException{
	
		if(null != conn){
			rs.close();
		}
		if(null != cstmt){
			cstmt.close();
		}
		if(null != conn){
			conn.close();
		}
		
	}

	/*
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008 -F2
	 * Requisito: RSis-023 Generación de Reportes STP
	 * Caso de uso: CU-STP-045 Generar Reporte de cambios de equipo generados
	 * Developer: Gabriel Moraga L.
	 * Fecha: 24/08/2010
	 * Metodo: obtenerReporteCambioEquiGene
	 * Return: ListadoReporteCamEquiGenDTO
	 * Descripcion: Obtiene informacion por rango de fechas y causal de cambio de equipo
	 * throws: PortalSACException
	 * 
	 */
	
	public ListadoReporteCamEquiGenDTO obtenerReporteCambioEquiGene(String fechaDesde, String fechaHasta, String codCausalCam) throws PortalSACException{
		
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs0 = null;
		
		int codError = 0;
		int numEvento = 0;
		
		String msgError = null;
		final String nombrePL = "pv_reporte_cambio_equipo_pr";
		ListadoReporteCamEquiGenDTO listadoReporteCamEquiGenDTO = new ListadoReporteCamEquiGenDTO();
		ReporteCamEquiGenDTO[] reporteCamEquiGenDTO = null;
		ArrayList<ReporteCamEquiGenDTO> listaCamEquiGen = new ArrayList<ReporteCamEquiGenDTO>();

		try{
			
			logger.info(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();
			
			String call = daoHelper.getPackageBD(NOMBRE_PACKAGE_BD_SP_CONSULTASTP_PG, nombrePL, 7);
			cstmt = conn.prepareCall(call);
			
			if(logger.isDebugEnabled()){
				logger.debug("SQL[" + call + "]");
				logger.debug("fechaDesde: " + fechaDesde);
				logger.debug("fechaHasta: " + fechaHasta);
				logger.debug("codCasualCam: " + codCausalCam);
			}
			
			//Datos de entrada
			cstmt.setString(1, fechaDesde);
			cstmt.setString(2, fechaHasta);
			cstmt.setString(3, codCausalCam);
		
			//Datos de salida
			cstmt.registerOutParameter(4, OracleTypes.CURSOR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC); //Codigo retorno
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR); //Mensaje retorno
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC); //Numero de evento
			
			if(logger.isDebugEnabled()){
				logger.debug("Execute Antes");
			}
			
			cstmt.execute();
			
			if(logger.isDebugEnabled()){
				logger.debug("Execute Despues");
			}
			
			codError = cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento = cstmt.getInt(7);
			
			if(logger.isDebugEnabled()){
				logger.debug("codError[" + codError + "]");
				logger.debug("msgError[" + msgError + "]");
				logger.debug("numEvento[" + numEvento + "]");
			}
			if (0 != codError){
				throw new PortalSACException(String.valueOf(codError), msgError, numEvento);
			}
			
			rs0 = (ResultSet)cstmt.getObject(4);
			
			ReporteCamEquiGenDTO repAntDTO = null;
			
			int paso = 0;
			
			while(rs0.next()){
				
				//Se crea el objeto
				ReporteCamEquiGenDTO repCamEquiGenDTO = new ReporteCamEquiGenDTO();
				
				if(0 == paso){
					logger.info("paso:"+paso);
					//set de los datos del cursor
		            repCamEquiGenDTO.setAbonado(null == rs0.getString(1) ? "" : rs0.getString(1));
					repCamEquiGenDTO.setCelular(null == rs0.getString(2) ? "" : rs0.getString(2));
					repCamEquiGenDTO.setCodCliente(null == rs0.getString(3) ? "" : rs0.getString(3));
					repCamEquiGenDTO.setCausalCambio(null == rs0.getString(4) ? "" : rs0.getString(4));
					repCamEquiGenDTO.setFecCambio(null == rs0.getString(5) ? "" : rs0.getString(5));
					
					repCamEquiGenDTO.setEquiAnterior("");
					
					repCamEquiGenDTO.setEquiAntMarca(null == rs0.getString(6) ? "" : rs0.getString(6));				
					repCamEquiGenDTO.setEquiAntModelo(null == rs0.getString(7) ? "" : rs0.getString(7));
					repCamEquiGenDTO.setEquiAntSerie(null == rs0.getString(8) ? "" : rs0.getString(8));
					
					repCamEquiGenDTO.setEquiCambio("");
					
					repCamEquiGenDTO.setEquiCamMarca(null == rs0.getString(9) ? "" : rs0.getString(9));
					repCamEquiGenDTO.setEquiCamModelo(null == rs0.getString(10) ? "" : rs0.getString(10));
					repCamEquiGenDTO.setEquiCamSerie(null == rs0.getString(11) ? "" : rs0.getString(11));
					
					repCamEquiGenDTO.setTipTerminal(null == rs0.getString(12) ? "" : rs0.getString(12));
					
					repAntDTO = new ReporteCamEquiGenDTO();
					
					repAntDTO = repCamEquiGenDTO;
					
				}else{
					
					//set de los datos del cursor
					if(    !repAntDTO.getAbonado().equals(null == rs0.getString(1) ? "" : rs0.getString(1)) || !repAntDTO.getCelular().equals(null == rs0.getString(2) ? "" : rs0.getString(2))
						|| !repAntDTO.getCodCliente().equals(null == rs0.getString(3) ? "" : rs0.getString(3)) || !repAntDTO.getCausalCambio().equals(null == rs0.getString(4) ? "" : rs0.getString(4)) 
						|| !repAntDTO.getFecCambio().equals(null == rs0.getString(5) ? "" : rs0.getString(5)) ){
						
			            repCamEquiGenDTO.setAbonado(null == rs0.getString(1) ? "" : rs0.getString(1));
						repCamEquiGenDTO.setCelular(null == rs0.getString(2) ? "" : rs0.getString(2));
						repCamEquiGenDTO.setCodCliente(null == rs0.getString(3) ? "" : rs0.getString(3));
						repCamEquiGenDTO.setCausalCambio(null == rs0.getString(4) ? "" : rs0.getString(4));
						repCamEquiGenDTO.setFecCambio(null == rs0.getString(5) ? "" : rs0.getString(5));
						repCamEquiGenDTO.setTipTerminal(null == rs0.getString(12) ? "" : rs0.getString(12));
						
					}else{
						repCamEquiGenDTO.setAbonado("");
						repCamEquiGenDTO.setCelular("");
						repCamEquiGenDTO.setCodCliente("");
						repCamEquiGenDTO.setCausalCambio("");
						repCamEquiGenDTO.setFecCambio("");
						repCamEquiGenDTO.setTipTerminal("");
					}
					
					repCamEquiGenDTO.setEquiAnterior("");
					
					repCamEquiGenDTO.setEquiAntMarca(null == rs0.getString(6) ? "" : rs0.getString(6));				
					repCamEquiGenDTO.setEquiAntModelo(null == rs0.getString(7) ? "" : rs0.getString(7));
					repCamEquiGenDTO.setEquiAntSerie(null == rs0.getString(8) ? "" : rs0.getString(8));
					
					repCamEquiGenDTO.setEquiCambio("");
					
					repCamEquiGenDTO.setEquiCamMarca(null == rs0.getString(9) ? "" : rs0.getString(9));
					repCamEquiGenDTO.setEquiCamModelo(null == rs0.getString(10) ? "" : rs0.getString(10));
					repCamEquiGenDTO.setEquiCamSerie(null == rs0.getString(11) ? "" : rs0.getString(11));
					
					
					repAntDTO = new ReporteCamEquiGenDTO();
					
					//set de los datos del cursor para el DTO de Comparacion
					repAntDTO.setAbonado(null == rs0.getString(1) ? "" : rs0.getString(1));
					repAntDTO.setCelular(null == rs0.getString(2) ? "" : rs0.getString(2));
					repAntDTO.setCodCliente(null == rs0.getString(3) ? "" : rs0.getString(3));
					repAntDTO.setCausalCambio(null == rs0.getString(4) ? "" : rs0.getString(4));
					repAntDTO.setFecCambio(null == rs0.getString(5) ? "" : rs0.getString(5));
					
					repAntDTO.setEquiAnterior("");
					
					repAntDTO.setEquiAntMarca(null == rs0.getString(6) ? "" : rs0.getString(6));				
					repAntDTO.setEquiAntModelo(null == rs0.getString(7) ? "" : rs0.getString(7));
					repAntDTO.setEquiAntSerie(null == rs0.getString(8) ? "" : rs0.getString(8));
					
					repAntDTO.setEquiCambio("");
					
					repAntDTO.setEquiCamMarca(null == rs0.getString(9) ? "" : rs0.getString(9));
					repAntDTO.setEquiCamModelo(null == rs0.getString(10) ? "" : rs0.getString(10));
					repAntDTO.setEquiCamSerie(null == rs0.getString(11) ? "" : rs0.getString(11));
					
					repAntDTO.setTipTerminal(null == rs0.getString(12) ? "" : rs0.getString(12));
					
				}
				
				++paso;
				
				listaCamEquiGen.add(repCamEquiGenDTO);
				
			}
			
			//Set de los datos
			reporteCamEquiGenDTO = (ReporteCamEquiGenDTO[]) listaCamEquiGen.toArray(new ReporteCamEquiGenDTO[listaCamEquiGen.size()]);
			listadoReporteCamEquiGenDTO.setReporteCamEquiGenDTO(reporteCamEquiGenDTO);

			if (reporteCamEquiGenDTO == null || (reporteCamEquiGenDTO != null && reporteCamEquiGenDTO.length == 0))
			{
				listadoReporteCamEquiGenDTO.setCodError(config.getString("COD.ERR_SAC.0059"));
				listadoReporteCamEquiGenDTO.setDesError(config.getString("DES.ERR_SAC.0059"));
			}

		}catch (java.lang.Exception e){
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}finally{
			try{
				cerrarRecursos(conn, cstmt);
			}catch (Exception e){
				logger.error("Exception [" + e.getMessage() + "]", e);
			}
		}
		logger.debug(MENSAJE_FIN_LOG);
		return listadoReporteCamEquiGenDTO;
	}
	
	/*
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008 - F2
	 * Requisito: RSis-023 Generación de Reportes STP
	 * Caso de uso: CU-STP-046 Generar Reporte de ingreso de equipos y status del equipo
	 * Developer: Gabriel Moraga L.
	 * Fecha: 25/08/2010
	 * Metodo: obtenerReporteIngrStatusEqui
	 * Return: ListadoReporteIngrStatusEquiDTO
	 * Descripcion: Obtiene informacion por rango de fechas
	 * throws: PortalSACException
	 * 
	 */
	
	public ListadoReporteIngrStatusEquiDTO obtenerReporteIngrStatusEqui(String fechaDesde, String fechaHasta) throws PortalSACException{
		
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs0 = null;
		
		int codError = 0;
		int numEvento = 0;
		
		String msgError = null;
		final String nombrePL = "pv_reporte_ingreso_status_pr";
		ListadoReporteIngrStatusEquiDTO listadoReporteIngrStatusEquiDTO = new ListadoReporteIngrStatusEquiDTO();
		ReporteIngrStatusEquiDTO[] reporteIngrStatusEquiDTO = null;
		ArrayList<ReporteIngrStatusEquiDTO> listaIngrStatusEqui = new ArrayList<ReporteIngrStatusEquiDTO>();

		try{
			
			logger.info(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();
			
			String call = daoHelper.getPackageBD(NOMBRE_PACKAGE_BD_SP_CONSULTASTP_PG, nombrePL, 6);
			cstmt = conn.prepareCall(call);
			
			if(logger.isDebugEnabled()){
				logger.debug("SQL[" + call + "]");
				logger.debug("fechaDesde: " + fechaDesde);
				logger.debug("fechaHasta: " + fechaHasta);
			}
			
			//Datos de entrada
			cstmt.setString(1, fechaDesde);
			cstmt.setString(2, fechaHasta);
		
			//Datos de salida
			cstmt.registerOutParameter(3, OracleTypes.CURSOR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC); //Codigo retorno
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR); //Mensaje retorno
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC); //Numero de evento
			
			if(logger.isDebugEnabled()){
				logger.debug("Execute Antes");
			}
			
			cstmt.execute();
			
			if(logger.isDebugEnabled()){
				logger.debug("Execute Despues");
			}
			
			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);
			
			if(logger.isDebugEnabled()){
				logger.debug("codError[" + codError + "]");
				logger.debug("msgError[" + msgError + "]");
				logger.debug("numEvento[" + numEvento + "]");
			}
			if (0 != codError){
				throw new PortalSACException(String.valueOf(codError), msgError, numEvento);
			}
			
			rs0 = (ResultSet)cstmt.getObject(3);
			
			ReporteIngrStatusEquiDTO repAntDTO = null;
			
			int paso = 0;
			
			while(rs0.next()){
				
				//Se crea el objeto
				ReporteIngrStatusEquiDTO repIngrStatusEquiDTO = new ReporteIngrStatusEquiDTO();
				
				if(0 == paso){
					logger.info("paso:"+paso);
					//set de los datos del cursor
					repIngrStatusEquiDTO.setFecIngr(null == rs0.getString(1) ? "" : rs0.getString(1));
					
					repIngrStatusEquiDTO.setEquipo("");
					
					repIngrStatusEquiDTO.setEquiMarca(null == rs0.getString(2) ? "" : rs0.getString(2));
					repIngrStatusEquiDTO.setEquiModelo(null == rs0.getString(3) ? "" : rs0.getString(3));
					repIngrStatusEquiDTO.setEquiSerie(null == rs0.getString(4) ? "" : rs0.getString(4));
					
					repIngrStatusEquiDTO.setAbonado(null == rs0.getString(5) ? "" : rs0.getString(5));
					repIngrStatusEquiDTO.setCelular(null == rs0.getString(6) ? "" : rs0.getString(6));
					repIngrStatusEquiDTO.setCodCliente(null == rs0.getString(7) ? "" : rs0.getString(7));
					
					repIngrStatusEquiDTO.setStatus("");
					
					repIngrStatusEquiDTO.setStsStatus(null == rs0.getString(8) ? "" : rs0.getString(8));
					repIngrStatusEquiDTO.setStsFecha(null == rs0.getString(9) ? "" : rs0.getString(9));
					repIngrStatusEquiDTO.setStsUsuario(null == rs0.getString(10) ? "" : rs0.getString(10));
					
					repIngrStatusEquiDTO.setEtapa(null == rs0.getString(11) ? "" : rs0.getString(11));
					repIngrStatusEquiDTO.setTipTerminal(null == rs0.getString(12) ? "" : rs0.getString(12));
					
					repAntDTO = new ReporteIngrStatusEquiDTO();
					
		            repAntDTO = repIngrStatusEquiDTO;
					
				}else{
					
					//set de los datos del cursor
					if(    !repAntDTO.getFecIngr().equals(null == rs0.getString(1) ? "" : rs0.getString(1)) || !repAntDTO.getAbonado().equals(null == rs0.getString(5) ? "" : rs0.getString(5))
						|| !repAntDTO.getCelular().equals(null == rs0.getString(6) ? "" : rs0.getString(6)) || !repAntDTO.getCodCliente().equals(null == rs0.getString(7) ? "" : rs0.getString(7)) 
						|| !repAntDTO.getEtapa().equals(null == rs0.getString(11) ? "" : rs0.getString(11)) || !repAntDTO.getTipTerminal().equals(null == rs0.getString(12) ? "" : rs0.getString(12)) ){
						
						//set de los datos del cursor
						repIngrStatusEquiDTO.setFecIngr(null == rs0.getString(1) ? "" : rs0.getString(1));

						
						repIngrStatusEquiDTO.setAbonado(null == rs0.getString(5) ? "" : rs0.getString(5));
						repIngrStatusEquiDTO.setCelular(null == rs0.getString(6) ? "" : rs0.getString(6));
						repIngrStatusEquiDTO.setCodCliente(null == rs0.getString(7) ? "" : rs0.getString(7));

						
						repIngrStatusEquiDTO.setEtapa(null == rs0.getString(11) ? "" : rs0.getString(11));
						repIngrStatusEquiDTO.setTipTerminal(null == rs0.getString(12) ? "" : rs0.getString(12));
						
					}else{
						
						//set de los datos del cursor
						repIngrStatusEquiDTO.setFecIngr("");

						
						repIngrStatusEquiDTO.setAbonado("");
						repIngrStatusEquiDTO.setCelular("");
						repIngrStatusEquiDTO.setCodCliente("");

						
						repIngrStatusEquiDTO.setEtapa("");
						repIngrStatusEquiDTO.setTipTerminal("");
					}
					
					//set de los datos del cursor
					repIngrStatusEquiDTO.setEquipo("");
					
					repIngrStatusEquiDTO.setEquiMarca(null == rs0.getString(2) ? "" : rs0.getString(2));
					repIngrStatusEquiDTO.setEquiModelo(null == rs0.getString(3) ? "" : rs0.getString(3));
					repIngrStatusEquiDTO.setEquiSerie(null == rs0.getString(4) ? "" : rs0.getString(4));

					repIngrStatusEquiDTO.setStatus("");
					
					repIngrStatusEquiDTO.setStsStatus(null == rs0.getString(8) ? "" : rs0.getString(8));
					repIngrStatusEquiDTO.setStsFecha(null == rs0.getString(9) ? "" : rs0.getString(9));
					repIngrStatusEquiDTO.setStsUsuario(null == rs0.getString(10) ? "" : rs0.getString(10));
					
					
					repAntDTO = new ReporteIngrStatusEquiDTO();
					
					//set de los datos al DTO de comparacion
					repAntDTO.setFecIngr(null == rs0.getString(1) ? "" : rs0.getString(1));
					
					repAntDTO.setEquipo("");
					
					repAntDTO.setEquiMarca(null == rs0.getString(2) ? "" : rs0.getString(2));
					repAntDTO.setEquiModelo(null == rs0.getString(3) ? "" : rs0.getString(3));
					repAntDTO.setEquiSerie(null == rs0.getString(4) ? "" : rs0.getString(4));
					
					repAntDTO.setAbonado(null == rs0.getString(5) ? "" : rs0.getString(5));
					repAntDTO.setCelular(null == rs0.getString(6) ? "" : rs0.getString(6));
					repAntDTO.setCodCliente(null == rs0.getString(7) ? "" : rs0.getString(7));
					
					repAntDTO.setStatus("");
					
					repAntDTO.setStsStatus(null == rs0.getString(8) ? "" : rs0.getString(8));
					repAntDTO.setStsFecha(null == rs0.getString(9) ? "" : rs0.getString(9));
					repAntDTO.setStsUsuario(null == rs0.getString(10) ? "" : rs0.getString(10));
					
					repAntDTO.setEtapa(null == rs0.getString(11) ? "" : rs0.getString(11));
					repAntDTO.setTipTerminal(null == rs0.getString(12) ? "" : rs0.getString(12));
					
				}
				
				++paso;
				
				listaIngrStatusEqui.add(repIngrStatusEquiDTO);
				
			}
			
			//Set de los datos
			reporteIngrStatusEquiDTO = (ReporteIngrStatusEquiDTO[]) listaIngrStatusEqui.toArray(new ReporteIngrStatusEquiDTO[listaIngrStatusEqui.size()]);
			listadoReporteIngrStatusEquiDTO.setReporteIngrStatusEquiDTO(reporteIngrStatusEquiDTO);

			if (reporteIngrStatusEquiDTO == null || (reporteIngrStatusEquiDTO != null && reporteIngrStatusEquiDTO.length == 0))
			{
				listadoReporteIngrStatusEquiDTO.setCodError(config.getString("COD.ERR_SAC.0060"));
				listadoReporteIngrStatusEquiDTO.setDesError(config.getString("DES.ERR_SAC.0060"));
			}

		}catch (java.lang.Exception e){
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}finally{
			try{
				cerrarRecursos(conn, cstmt);
			}catch (Exception e){
				logger.error("Exception [" + e.getMessage() + "]", e);
			}
		}
		logger.debug(MENSAJE_FIN_LOG);
		return listadoReporteIngrStatusEquiDTO;
	}
	
	/*
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008 - F2
	 * Requisito: RSis-023 Generación de Reportes STP
	 * Caso de uso: CU-STP-047 Generar Reporte de préstamos de equipos internos
	 * Developer: Gabriel Moraga L.
	 * Fecha: 25/08/2010
	 * Metodo: obtenerReportePresEquiInt
	 * Return: ListadoReportePresEquiIntDTO
	 * Descripcion: Obtiene informacion por rango de fechas
	 * throws: PortalSACException
	 * 
	 */
	
	public ListadoReportePresEquiIntDTO obtenerReportePresEquiInt(String fechaDesde, String fechaHasta) throws PortalSACException{
		
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs0 = null;
		
		int codError = 0;
		int numEvento = 0;
		String msgError = null;
		
		final String nombrePL = "pv_reporte_prestamo_equipo_pr";
		ListadoReportePresEquiIntDTO listadoReportePresEquiIntDTO = new ListadoReportePresEquiIntDTO();
		ReportePresEquiIntDTO[] reportePresEquiIntDTO = null;
		ArrayList<ReportePresEquiIntDTO> listaPresEquiInt = new ArrayList<ReportePresEquiIntDTO>();

		try{
			logger.info(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();
			
			String call = daoHelper.getPackageBD(NOMBRE_PACKAGE_BD_SP_CONSULTASTP_PG, nombrePL, 6);
			cstmt = conn.prepareCall(call);
			
			if(logger.isDebugEnabled()){
				logger.debug("SQL[" + call + "]");
				logger.debug("fechaDesde: " + fechaDesde);
				logger.debug("fechaHasta: " + fechaHasta);
			}
			
			//Datos de entrada
			cstmt.setString(1, fechaDesde);
			cstmt.setString(2, fechaHasta);
		
			//Datos de salida
			cstmt.registerOutParameter(3, OracleTypes.CURSOR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC); //Codigo retorno
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR); //Mensaje retorno
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC); //Numero de evento
			
			if(logger.isDebugEnabled()){
				logger.debug("Execute Antes");
			}
			
			cstmt.execute();
			
			if(logger.isDebugEnabled()){
				logger.debug("Execute Despues");
			}
			
			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);
			
			if(logger.isDebugEnabled()){
				logger.debug("codError[" + codError + "]");
				logger.debug("msgError[" + msgError + "]");
				logger.debug("numEvento[" + numEvento + "]");
			}
			if (0 != codError){
				throw new PortalSACException(String.valueOf(codError), msgError, numEvento);
			}
			
			rs0 = (ResultSet)cstmt.getObject(3);
			
			ReportePresEquiIntDTO repAntDTO = null;
			
			int paso = 0;
			
			while(rs0.next()){
				
				//Se crea el objeto
				ReportePresEquiIntDTO RepPresEquiIntDTO = new ReportePresEquiIntDTO();
				
				if(0 == paso){
					logger.info("paso:"+paso);
					//set de los datos del cursor
					RepPresEquiIntDTO.setFecPrestamo(null == rs0.getString(1) ? "" : rs0.getString(1));
					RepPresEquiIntDTO.setEquipo("");
					
					RepPresEquiIntDTO.setEquiMarca(null == rs0.getString(2) ? "" : rs0.getString(2));
					RepPresEquiIntDTO.setEquiModelo(null == rs0.getString(3) ? "" : rs0.getString(3));
					RepPresEquiIntDTO.setEquiSerie(null == rs0.getString(4) ? "" : rs0.getString(4));
					
					RepPresEquiIntDTO.setAbonado(null == rs0.getString(5) ? "" : rs0.getString(5));
					RepPresEquiIntDTO.setCodCliente(null == rs0.getString(6) ? "" : rs0.getString(6));
					
					repAntDTO = new ReportePresEquiIntDTO();
					
		            repAntDTO = RepPresEquiIntDTO;
					
				}else{
					
					//set de los datos del cursor
					if(    !repAntDTO.getFecPrestamo().equals(null == rs0.getString(1) ? "" : rs0.getString(1)) || !repAntDTO.getAbonado().equals(null == rs0.getString(5) ? "" : rs0.getString(5))
						|| !repAntDTO.getCodCliente().equals(null == rs0.getString(6) ? "" : rs0.getString(6)) ){
						
						//set de los datos del cursor
						RepPresEquiIntDTO.setFecPrestamo(null == rs0.getString(1) ? "" : rs0.getString(1));

						RepPresEquiIntDTO.setAbonado(null == rs0.getString(5) ? "" : rs0.getString(5));
						RepPresEquiIntDTO.setCodCliente(null == rs0.getString(6) ? "" : rs0.getString(6));
						
					}else{
						
						//set de los datos del cursor
						RepPresEquiIntDTO.setFecPrestamo("");

						RepPresEquiIntDTO.setAbonado("");
						RepPresEquiIntDTO.setCodCliente("");
					}
					
					//set de los datos del cursor

					RepPresEquiIntDTO.setEquipo("");
					
					RepPresEquiIntDTO.setEquiMarca(null == rs0.getString(2) ? "" : rs0.getString(2));
					RepPresEquiIntDTO.setEquiModelo(null == rs0.getString(3) ? "" : rs0.getString(3));
					RepPresEquiIntDTO.setEquiSerie(null == rs0.getString(4) ? "" : rs0.getString(4));
					
					repAntDTO = new ReportePresEquiIntDTO();
					
					//set de los datos del DTO de comparacion
					repAntDTO.setFecPrestamo(null == rs0.getString(1) ? "" : rs0.getString(1));
					repAntDTO.setEquipo("");
					
					repAntDTO.setEquiMarca(null == rs0.getString(2) ? "" : rs0.getString(2));
					repAntDTO.setEquiModelo(null == rs0.getString(3) ? "" : rs0.getString(3));
					repAntDTO.setEquiSerie(null == rs0.getString(4) ? "" : rs0.getString(4));
					
					repAntDTO.setAbonado(null == rs0.getString(5) ? "" : rs0.getString(5));
					repAntDTO.setCodCliente(null == rs0.getString(6) ? "" : rs0.getString(6));
					
				}
				
				++paso;
				
				listaPresEquiInt.add(RepPresEquiIntDTO);
				
			}
			
			//Set de los datos
			reportePresEquiIntDTO = (ReportePresEquiIntDTO[]) listaPresEquiInt.toArray(new ReportePresEquiIntDTO[listaPresEquiInt.size()]);
			listadoReportePresEquiIntDTO.setReportePresEquiIntDTO(reportePresEquiIntDTO);

			if (reportePresEquiIntDTO == null || (reportePresEquiIntDTO != null && reportePresEquiIntDTO.length == 0))
			{
				listadoReportePresEquiIntDTO.setCodError(config.getString("COD.ERR_SAC.0061"));
				listadoReportePresEquiIntDTO.setDesError(config.getString("DES.ERR_SAC.0061"));
			}

		}catch (java.lang.Exception e){
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}finally{
			try{
				cerrarRecursos(conn, cstmt);
			}catch (Exception e){
				logger.error("Exception [" + e.getMessage() + "]", e);
			}
		}
		logger.debug(MENSAJE_FIN_LOG);
		return listadoReportePresEquiIntDTO;
	}
	
	/*
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008 -F2
	 * Requisito: RSis-023 Generación de Reportes STP
	 * Caso de uso: CU-STP-045 Generar Reporte de cambios de equipo generados
	 * Developer: Gabriel Moraga L.
	 * Fecha: 27/08/2010
	 * Metodo: obtenerCausalCambio
	 * Return: ListaCausalCambioDTO
	 * Descripcion: Obtiene las causales de cambio
	 * throws: PortalSACException
	 * 
	 */
	
	public ListaCausalCambioDTO obtenerCausalCambio() throws PortalSACException{
		
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs0 = null;
		
		int codError = 0;
		int numEvento = 0;
		
		String msgError = null;
		final String nombrePL = "sp_get_causa_cambio_pr";
		ListaCausalCambioDTO listaCausalCambioDTO = new ListaCausalCambioDTO();
		CausalCambioDTO[] causalCambioDTO = null;
		ArrayList<CausalCambioDTO> listaCausalCambio = new ArrayList<CausalCambioDTO>() ;

		try{
			
			logger.info(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();
			
			String call = daoHelper.getPackageBD(NOMBRE_PACKAGE_BD_SP_CONSULTASTP_PG, nombrePL, 4);
			cstmt = conn.prepareCall(call);
			
			if(logger.isDebugEnabled()){
				logger.debug("SQL[" + call + "]");
			}
			
			//Datos de entrada

			//Datos de salida
			cstmt.registerOutParameter(1, OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC); //Codigo retorno
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR); //Mensaje retorno
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC); //Numero de evento
			
			if(logger.isDebugEnabled()){
				logger.debug("Execute Antes");
			}
			
			cstmt.execute();
			
			if(logger.isDebugEnabled()){
				logger.debug("Execute Despues");
			}
			
			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);
			
			if(logger.isDebugEnabled()){
				logger.debug("codError[" + codError + "]");
				logger.debug("msgError[" + msgError + "]");
				logger.debug("numEvento[" + numEvento + "]");
			}
			if (0 != codError){
				throw new PortalSACException(String.valueOf(codError), msgError, numEvento);
			}
			
			rs0 = (ResultSet)cstmt.getObject(1);
			
			while(rs0.next()){
				
				//Se crea el objeto
				CausalCambioDTO cauCambioDTO = new CausalCambioDTO();
				
				//set de los datos del cursor
				cauCambioDTO.setCodCaucaser(rs0.getString(1));
				cauCambioDTO.setDesCaucaser(rs0.getString(2));
	
				
				listaCausalCambio.add(cauCambioDTO);
			}
			
			//Set de los datos
			causalCambioDTO = (CausalCambioDTO[]) listaCausalCambio.toArray(new CausalCambioDTO[listaCausalCambio.size()]);
			listaCausalCambioDTO.setCausalCambioDTO(causalCambioDTO);

			if (causalCambioDTO == null || (causalCambioDTO != null && causalCambioDTO.length == 0))
			{
				listaCausalCambioDTO.setCodError(config.getString("COD.ERR_SAC.0062"));
				listaCausalCambioDTO.setDesError(config.getString("DES.ERR_SAC.0062"));
			}

		}catch (java.lang.Exception e){
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}finally{
			try{
				cerrarRecursos(conn, cstmt);
			}catch (Exception e){
				logger.error("Exception [" + e.getMessage() + "]", e);
			}
		}
		logger.debug(MENSAJE_FIN_LOG);
		return listaCausalCambioDTO;
	}
	
}