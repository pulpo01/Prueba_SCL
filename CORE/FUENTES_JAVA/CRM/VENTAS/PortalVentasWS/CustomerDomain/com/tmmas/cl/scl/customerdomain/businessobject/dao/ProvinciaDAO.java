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
package com.tmmas.cl.scl.customerdomain.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.scl.commonbusinessentities.dto.DatosDireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ProvinciaDireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.interfaz.OrdenaDatosDireccion;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ProvinciaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.RegionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.helper.Global;


public class ProvinciaDAO extends ConnectionDAO{
	private static Category cat = Category.getInstance(ProvinciaDAO.class);

	Global global = Global.getInstance();
	
	private Connection getConection() throws CustomerDomainException
	{
		Connection conn = null;
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
		} catch (Exception e1) {
			conn = null;
			cat.error(" No se pudo obtener una conexión ", e1);
			throw new CustomerDomainException("No se pudo obtener una conexión", e1);
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
	public ProvinciaDTO[] getListadoProvincias(RegionDTO region) 
		throws CustomerDomainException
	{
		cat.debug("getListadoProvincias:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ProvinciaDTO[] resultado = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		ResultSet rs = null;
		cat.debug("Coneccion obtenida OK");
		try {
			String call = getSQLPackage("VE_servicios_direcciones_PG","VE_listadoprovincias_PR",6);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,region.getCodigoRegion());
			cstmt.setString(2,OrdenaDatosDireccion.si);
			cstmt.registerOutParameter(3,OracleTypes.CURSOR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cat.debug("Execute Antes");
			cstmt.execute();
			cat.debug("Execute Despues");
			codError = cstmt.getInt(4);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(5);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(6);
			cat.debug("numEvento[" + numEvento + "]");
			if (codError != 0) {
				cat.error("Ocurrió un error al consultar las Provincias");
				throw new CustomerDomainException(
						"Ocurrió un error al consultar las Provincias", String
								.valueOf(codError), numEvento, msgError);
				
			}else{
				cat.debug("Llenado Provincias");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(3);
				while (rs.next()) {
					ProvinciaDTO provincia = new ProvinciaDTO();
					provincia.setCodigoProvincia(rs.getString(1));
				    provincia.setDescripcionProvincia(rs.getString(2));
					lista.add(provincia);
				}				
				resultado =(ProvinciaDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), ProvinciaDTO.class);
				
				cat.debug("Fin Llenado Provincias");
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al consultar las Provincias",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new CustomerDomainException(
					"Ocurrió un error al consultar las Provincias",e);
		} finally {
		 	if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (rs!=null)
					rs.close();
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}

		cat.debug("getListadoProvincias():end");

		return resultado;
	}
	
	public ProvinciaDireccionDTO getListadoProvincias(ProvinciaDireccionDTO provinciaDireccionDTO) 
		throws CustomerDomainException
	{
		cat.debug("getListadoProvincias:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		ResultSet rs = null;
		cat.debug("Coneccion obtenida OK");
		try {
			String call = getSQLPackage("VE_servicios_direcciones_PG","VE_listadoprovincias_PR",6);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,provinciaDireccionDTO.getCodigoRegion());
			cstmt.setString(2,OrdenaDatosDireccion.si);
			cstmt.registerOutParameter(3,OracleTypes.CURSOR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cat.debug("Execute Antes");
			cstmt.execute();
			cat.debug("Execute Despues");
			codError = cstmt.getInt(4);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(5);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(6);
			cat.debug("numEvento[" + numEvento + "]");
			if (codError != 0) {
				cat.error("Ocurrió un error al consultar las Provincias");
				throw new CustomerDomainException(
						"Ocurrió un error al consultar las Provincias", String
								.valueOf(codError), numEvento, msgError);
				
			}else{
				cat.debug("Llenado Provincias");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(3);
				while (rs.next()) {
					DatosDireccionDTO provincia = new DatosDireccionDTO();
					provincia.setCodigo(rs.getString(1));
				    provincia.setDescripcion(rs.getString(2));
					lista.add(provincia);
				}				
				provinciaDireccionDTO.setDatosDireccionDTO((DatosDireccionDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), DatosDireccionDTO.class));
				
				cat.debug("Fin Llenado Provincias");
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al consultar las Provincias",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new CustomerDomainException(
					"Ocurrió un error al consultar las Provincias",e);
		} finally {
		 	if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (rs!=null)
					rs.close();
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}

		cat.debug("getListadoProvincias():end");

		return provinciaDireccionDTO;
	}
	
}


