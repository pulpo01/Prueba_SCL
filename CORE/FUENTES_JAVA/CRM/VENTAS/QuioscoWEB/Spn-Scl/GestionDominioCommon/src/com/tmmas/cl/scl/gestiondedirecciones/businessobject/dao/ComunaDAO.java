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
 * 06/01/2007     H&eacute;ctor Hermosilla      			Versión Inicial
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
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.CiudadDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.ComunaDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.ComunaDireccionDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.ComunaSPNDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.DatosDireccionDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.ProvinciaDTO;


public class ComunaDAO extends ConnectionDAO{
	private final Logger logger = Logger.getLogger(ComunaDAO.class);

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
	public ComunaDireccionDTO getListadoComunas(ComunaDireccionDTO comunaDireccionDTO) throws GeneralException{
		logger.debug("getListadoComunas:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		logger.debug("Coneccion obtenida OK");
		try {
			//INI-01 (AL) String call = getSQLPackage("VE_servicios_direcciones_PG","VE_getListComunas_PR",7);
			String call = getSQLPackage("VE_servicios_direc_Quiosco_PG","VE_getListComunas_PR",7);
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,comunaDireccionDTO.getCodigoRegion());
			logger.debug("codigo region:"  + comunaDireccionDTO.getCodigoRegion());
			cstmt.setString(2,comunaDireccionDTO.getCodigoProvincia());
			logger.debug("codigo provincia:"  + comunaDireccionDTO.getCodigoProvincia());
			cstmt.setString(3,comunaDireccionDTO.getCodigoCiudad());
			logger.debug("codigo ciudad:"  + comunaDireccionDTO.getCodigoCiudad());
			cstmt.registerOutParameter(4,OracleTypes.CURSOR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			logger.debug("Execute Antes");
			cstmt.execute();
			logger.debug("Execute Despues");
			codError = cstmt.getInt(5);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(6);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(7);
			logger.debug("numEvento[" + numEvento + "]");
			if (codError != 0) {
				logger.error("Ocurrió un error al consultar las Comunas");
				if (logger.isDebugEnabled()) {
					logger.debug("Codigo de Error[" + codError + "]");
					logger.debug("Mensaje de Error[" + msgError + "]");
					logger.debug("Numero de Evento[" + numEvento + "]");
				}
				throw new GeneralException(
						"Ocurrió un error al consultar las Comunas", String
						.valueOf(codError), numEvento, msgError);
			}
			else{
				logger.debug("Llenado Comunas");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(4);
				while (rs.next()) {
					DatosDireccionDTO datosDireccionDTO = new DatosDireccionDTO();
					datosDireccionDTO.setCodigo(rs.getString(1));
					datosDireccionDTO.setDescripcion(rs.getString(2));
					lista.add(datosDireccionDTO);
				}
				comunaDireccionDTO.setDatosDireccionDTO((DatosDireccionDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
						lista.toArray(), DatosDireccionDTO.class));
				rs.close();
				logger.debug("Fin Llenado Comunas");
			}			
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		}catch (GeneralException e) {
			logger.error("Ocurrió un error al consultar las Comunas",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw(e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al consultar las Comunas",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al consultar las Comunas",e);
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

		logger.debug("getListadoComunas():end");

		return comunaDireccionDTO;
	}
	
	
	public ComunaSPNDTO[] getListadoComunas(CiudadDTO ciudad) throws GeneralException{
		logger.debug("getListadoComunas:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		ComunaSPNDTO[] comunas = null;
		conn = getConection();
		logger.debug("Coneccion obtenida OK");
		try {
			//INI-01 (AL) String call = getSQLPackage("VE_servicios_direcciones_PG","VE_getListComunas_PR",7);
			String call = getSQLPackage("VE_servicios_direc_Quiosco_PG","VE_getListComunas_PR",7);
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,ciudad.getCodigoRegion());
			logger.debug("codigo region:"  + ciudad.getCodigoRegion());
			cstmt.setString(2,ciudad.getCodigoProvincia());
			logger.debug("codigo provincia:"  + ciudad.getCodigoProvincia());
			cstmt.setString(3,ciudad.getCodigoCiudad());
			logger.debug("codigo ciudad:"  + ciudad.getCodigoCiudad());
			cstmt.registerOutParameter(4,OracleTypes.CURSOR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			logger.debug("Execute Antes");
			cstmt.execute();
			logger.debug("Execute Despues");
			codError = cstmt.getInt(5);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(6);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(7);
			logger.debug("numEvento[" + numEvento + "]");
			if (codError == 0) {
				logger.debug("Llenado Comunas");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(4);
				while (rs.next()) {
					ComunaSPNDTO comuna = new ComunaSPNDTO();
					comuna.setCodigoComuna(rs.getString(1));
					comuna.setDescripcionComuna(rs.getString(2));
					lista.add(comuna);
				}
				comunas = (ComunaSPNDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), ComunaSPNDTO.class);
												
				rs.close();
				logger.debug("Fin Llenado Comunas");
			}
			else{
				logger.error("Ocurrió un error al consultar las Comunas");
				if (logger.isDebugEnabled()) {
					logger.debug("Codigo de Error[" + codError + "]");
					logger.debug("Mensaje de Error[" + msgError + "]");
					logger.debug("Numero de Evento[" + numEvento + "]");
				}
				throw new GeneralException(
						"Ocurrió un error al consultar las Comunas", String
						.valueOf(codError), numEvento, msgError);
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		}catch (GeneralException e) {
			logger.error("Ocurrió un error al consultar las Comunas",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw(e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al consultar las Comunas",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al consultar las Comunas",e);
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

		logger.debug("getListadoComunas():end");

		return comunas;
	}	
	
}


