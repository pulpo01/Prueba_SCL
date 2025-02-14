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
 * 06/01/2007     Héctor Hermosilla      					Versión Inicial
 */
package com.tmmas.cl.scl.gestiondedirecciones.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.helper.Global;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.DatosDireccionDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.RegionDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.RegionDireccionDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.interfaz.OrdenaDatosDireccion;





public class RegionDAO extends ConnectionDAO{
	private final Logger logger = Logger.getLogger(RegionDAO.class);
	
	Global global = Global.getInstance();
	
	private Connection getConection() throws GeneralException
	{
		Connection conn = null;
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
		} catch (Exception e1) {
			conn = null;
			logger.error(" No se pudo obtener una conexión ", e1);
			throw new GeneralException("No se pudo obtener una conexión", e1);
		}
		
		return conn;
	}
	
	
	
	private String getSQLPackage(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
        for (int n = 1; n <= paramCount; n++) {
            sb.append("?");
            if (n < paramCount) sb.append(",");
        }
        return sb.append(")}").toString();
	
	}
	public RegionDTO[] getListadoRegiones() throws GeneralException{
		logger.debug("getListadoRegiones:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RegionDTO[] resultado = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		logger.debug("Coneccion obtenida OK");
		try {
			//INI-01 (AL) String call = getSQLPackage("VE_servicios_direcciones_PG","VE_listadoregiones_PR",5);
			String call = getSQLPackage("VE_servicios_direc_Quiosco_PG","VE_listadoregiones_PR",5);
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,OrdenaDatosDireccion.si);
			cstmt.registerOutParameter(2,OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			logger.debug("Execute Antes");
			cstmt.execute();
			logger.debug("Execute Despues");
			codError = cstmt.getInt(3);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(4);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(5);
			logger.debug("numEvento[" + numEvento + "]");
			if (codError != 0) {
				logger.error("Ocurrió un error al consultar las Regiones");
				throw new GeneralException(
						"Ocurrió un error al consultar las Regiones", String
								.valueOf(codError), numEvento, msgError);
				
			}else{
				logger.debug("Llenado Regiones");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(2);
				while (rs.next()) {
					RegionDTO region = new RegionDTO();
					region.setCodigoRegion(rs.getString(1));
					region.setDescripcionRegion(rs.getString(2));
					lista.add(region);
				}
				rs.close();
				resultado =(RegionDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), RegionDTO.class);
				
				logger.debug("Fin Llenado Regiones");
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			logger.error("Ocurrió un error al consultar las regiones",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw(e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al consultar las regiones",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al consultar las regiones",e);
		} finally {
		 	if (logger.isDebugEnabled()) 
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}

		logger.debug("getListadoRegiones():end");

		return resultado;
	}
	
	public RegionDireccionDTO getListadoRegionesDireccion() throws GeneralException{
		logger.debug("getListadoRegiones:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RegionDireccionDTO resultado = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		logger.debug("Coneccion obtenida OK");
		try {
			//INI-01 (AL) String call = getSQLPackage("VE_servicios_direcciones_PG","VE_listadoregiones_PR",5);
			String call = getSQLPackage("VE_servicios_direc_Quiosco_PG","VE_listadoregiones_PR",5);
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,OrdenaDatosDireccion.si);
			cstmt.registerOutParameter(2,OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			logger.debug("Execute Antes");
			cstmt.execute();
			logger.debug("Execute Despues");
			codError = cstmt.getInt(3);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(4);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(5);
			logger.debug("numEvento[" + numEvento + "]");
			if (codError != 0) {
				logger.error("Ocurrió un error al consultar las Regiones");
				throw new GeneralException(
						"Ocurrió un error al consultar las Regiones", String
								.valueOf(codError), numEvento, msgError);
				
			}else{
				resultado = new RegionDireccionDTO();
				logger.debug("Llenado Regiones");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(2);
				while (rs.next()) {
					DatosDireccionDTO region = new DatosDireccionDTO();
					region.setCodigo(rs.getString(1));
					region.setDescripcion(rs.getString(2));
					lista.add(region);
				}
				rs.close();
				resultado.setDatosDireccionDTO((DatosDireccionDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), DatosDireccionDTO.class));
				
				logger.debug("Fin Llenado Regiones");
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			logger.error("Ocurrió un error al consultar las regiones",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw(e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al consultar las regiones",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al consultar las regiones",e);
		} finally {
		 	if (logger.isDebugEnabled()) 
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}

		logger.debug("getListadoRegiones():end");

		return resultado;
	}
	
}


