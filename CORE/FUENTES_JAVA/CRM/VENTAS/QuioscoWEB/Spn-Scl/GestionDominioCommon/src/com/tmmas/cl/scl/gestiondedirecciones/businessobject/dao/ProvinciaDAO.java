/**
 * Copyright � 2006 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal informaci�n y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 06/01/2007     H�ctor Hermosilla      					Versi�n Inicial
 */
package com.tmmas.cl.scl.gestiondedirecciones.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import oracle.jdbc.OracleTypes;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.helper.Global;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.DatosDireccionDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.ProvinciaDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.ProvinciaDireccionDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.RegionDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.interfaz.OrdenaDatosDireccion;



public class ProvinciaDAO extends ConnectionDAO{
	private final Logger logger = Logger.getLogger(ProvinciaDAO.class);

	Global global = Global.getInstance();
	
	private Connection getConection() throws GeneralException
	{
		Connection conn = null;
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
		} catch (Exception e1) {
			conn = null;
			logger.error(" No se pudo obtener una conexi�n ", e1);
			throw new GeneralException("No se pudo obtener una conexi�n", e1);
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
	public ProvinciaDTO[] getListadoProvincias(RegionDTO region) throws GeneralException{
		logger.debug("getListadoProvincias:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ProvinciaDTO[] resultado = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		logger.debug("Coneccion obtenida OK");
		try {
			//INI-01 (AL) String call = getSQLPackage("VE_servicios_direcciones_PG","VE_listadoprovincias_PR",6);
			String call = getSQLPackage("VE_servicios_direc_Quiosco_PG","VE_listadoprovincias_PR",6);
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,region.getCodigoRegion());
			logger.error("region.getCodigoRegion() ["+region.getCodigoRegion()+"]");
			cstmt.setString(2,OrdenaDatosDireccion.si);
			cstmt.registerOutParameter(3,OracleTypes.CURSOR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			logger.debug("Execute Antes");
			cstmt.execute();
			logger.debug("Execute Despues");
			codError = cstmt.getInt(4);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(5);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(6);
			logger.debug("numEvento[" + numEvento + "]");
			if (codError != 0) {
				logger.error("Ocurri� un error al consultar las Provincias");
				throw new GeneralException(
						"Ocurri� un error al consultar las Provincias", String
								.valueOf(codError), numEvento, msgError);
				
			}else{
				logger.debug("Llenado Provincias");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(3);
				while (rs.next()) {
					ProvinciaDTO provincia = new ProvinciaDTO();
					provincia.setCodigoProvincia(rs.getString(1));
					logger.error("provincia.setCodigoProvincia["+rs.getString(1)+"]");
				    provincia.setDescripcionProvincia(rs.getString(2));
				    logger.error("provincia.setDescripcionProvincia["+rs.getString(2)+"]");
					lista.add(provincia);
				}
				rs.close();
				resultado =(ProvinciaDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), ProvinciaDTO.class);
				
				logger.debug("Fin Llenado Provincias");
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecuci�n");
				logger.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			logger.error("Ocurri� un error al consultar las Provincias",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw(e);
		} catch (Exception e) {
			logger.error("Ocurri� un error al consultar las Provincias",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurri� un error al consultar las Provincias",e);
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

		logger.debug("getListadoProvincias():end");

		return resultado;
	}
	
	public ProvinciaDireccionDTO getListadoProvincias(ProvinciaDireccionDTO provinciaDireccionDTO) throws GeneralException{
		logger.debug("getListadoProvincias:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		logger.debug("Coneccion obtenida OK");
		try {
			//INI-01 (AL) String call = getSQLPackage("VE_servicios_direcciones_PG","VE_listadoprovincias_PR",6);
			String call = getSQLPackage("VE_servicios_direc_Quiosco_PG","VE_listadoprovincias_PR",6);
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,provinciaDireccionDTO.getCodigoRegion());
			cstmt.setString(2,OrdenaDatosDireccion.si);
			cstmt.registerOutParameter(3,OracleTypes.CURSOR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			logger.debug("Execute Antes");
			cstmt.execute();
			logger.debug("Execute Despues");
			codError = cstmt.getInt(4);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(5);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(6);
			logger.debug("numEvento[" + numEvento + "]");
			if (codError != 0) {
				logger.error("Ocurri� un error al consultar las Provincias");
				throw new GeneralException(
						"Ocurri� un error al consultar las Provincias", String
								.valueOf(codError), numEvento, msgError);
				
			}else{
				logger.debug("Llenado Provincias");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(3);
				while (rs.next()) {
					DatosDireccionDTO provincia = new DatosDireccionDTO();
					provincia.setCodigo(rs.getString(1));
				    provincia.setDescripcion(rs.getString(2));
					lista.add(provincia);
				}
				rs.close();
				provinciaDireccionDTO.setDatosDireccionDTO((DatosDireccionDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), DatosDireccionDTO.class));
				
				logger.debug("Fin Llenado Provincias");
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecuci�n");
				logger.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			logger.error("Ocurri� un error al consultar las Provincias",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw(e);
		} catch (Exception e) {
			logger.error("Ocurri� un error al consultar las Provincias",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurri� un error al consultar las Provincias",e);
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

		logger.debug("getListadoProvincias():end");

		return provinciaDireccionDTO;
	}
	
}


