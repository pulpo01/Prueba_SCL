/**
 * Copyright © 2007 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 22/03/2007     Héctor Hermosilla     					Versión Inicial
 */

package com.tmmas.cl.scl.resourcedomain.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.ResourceDomainException;
import com.tmmas.cl.scl.resourcedomain.businessobject.dto.CeldaDTO;
import com.tmmas.cl.scl.resourcedomain.businessobject.dto.CentralDTO;
import com.tmmas.cl.scl.resourcedomain.businessobject.helper.Global;

public class CentralDAO extends ConnectionDAO{
	private static Category cat = Category.getInstance(CentralDAO.class);

	Global global = Global.getInstance();
	
	private Connection getConection() 
		throws ResourceDomainException
	{
		Connection conn = null;
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
		} catch (Exception e1) {
			conn = null;
			cat.error(" No se pudo obtener una conexión ", e1);
			throw new ResourceDomainException("No se pudo obtener una conexión", e1);
		}
		
		return conn;
	}
	
	private String getSQLDatos(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
        for (int n = 1; n <= paramCount; n++) {
            sb.append("?");
            if (n < paramCount) sb.append(",");
        }
        return sb.append(")}").toString();
	}//fin getSQLDatosAbonado
	
	public CentralDTO[] getListadoCentrales(CeldaDTO entrada) 
		throws ResourceDomainException
	{
		int codError = 0;
		CentralDTO[] resultado = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		ResultSet rs = null;
		try {
			cat.debug("Inicio:obtieneCentrales");
			
			String call = getSQLDatos("VE_PARAMETROS_COMERCIALES_PG","VE_listadocentrales_PR",7);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1, entrada.getCodSubAlm());
			cat.debug("entrada.getCodSubAlm():"+ entrada.getCodSubAlm());
			cstmt.setInt(2,Integer.parseInt(entrada.getCodigoProducto()));
			cat.debug("entrada.getCodigoProducto():" + entrada.getCodigoProducto());		
			cstmt.setString(3,entrada.getCodigoPrestacion());
			cat.debug("entrada.getCodigoPrestacion():" + entrada.getCodigoPrestacion());
			cstmt.registerOutParameter(4,OracleTypes.CURSOR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getListadoCentrales:execute");
			cstmt.execute();
			cat.debug("Fin:getListadoCentrales:execute");

			codError = cstmt.getInt(5);
			msgError = cstmt.getString(6);
			
			if (codError ==0){
				cat.debug("Llenado Centrales");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(4);
				while (rs.next()) {
					CentralDTO central = new CentralDTO();
					central.setCodigoCentral(rs.getString(1));
					central.setDescripcionCentral(rs.getString(2));
					central.setCodigoTecnologia(rs.getString(3));
					lista.add(central);
				}				
				resultado =(CentralDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), CentralDTO.class);
				
				cat.debug("Fin Llenado Centrales");
			}
			cat.debug("msgError[" + msgError + "]");

			
		
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener listado de centrales",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
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

		cat.debug("Fin:getListadoCentrales");

		return resultado;
	}

	
	/**
	 * Obtiene datos de la central
	 * @param entrada
	 * @return entrada
	 * @throws ResourceDomainException
	 */
	public CentralDTO getCentral(CentralDTO entrada) 
		throws ResourceDomainException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:getCentral");
			
			String call = getSQLDatos("VE_servicios_venta_PG","VE_obtiene_central_PR",6);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			
			cstmt.setInt(1, entrada.getCodigoProducto());
			cstmt.setInt(2, Integer.parseInt(entrada.getCodigoCentral()));
			
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getCentral:execute");
			cstmt.execute();
			cat.debug("Fin:getCentral:execute");

			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);

			entrada.setCodigoTecnologia(cstmt.getString(3));
		
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener los datos de la central",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
		 	if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:getCentral");
		return entrada;
	}//fin getCentral
	
	
	public CentralDTO[] getDatosCentral(CentralDTO entrada) 
		throws ResourceDomainException
	{
		int codError = 0;
		CentralDTO[] resultado = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:getDatosCentral");
			
			String call = getSQLDatos("VE_PARAMETROS_COMERCIALES_PG","VE_Obtiene_DatosCentral_PR",5);
	
			cat.debug("sql[" + call + "]");
	
			cstmt = conn.prepareCall(call);
			cstmt.setString(1, entrada.getCodigoCentral());			
			cstmt.registerOutParameter(2,OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getDatosCentral:execute");
			cstmt.execute();
			cat.debug("Fin:getDatosCentral:execute");
	
			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			if (codError ==0){
				cat.debug("Llenado Centrales");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(2);
				while (rs.next()) {
					CentralDTO central = new CentralDTO();
					central.setCodigoCentral(rs.getString(1));
					central.setDescripcionCentral(rs.getString(2));
					central.setCodigoHlr(rs.getString(3));
					central.setCodigoSubAlm(rs.getString(4));
					central.setCodigoTecnologia(rs.getString(5));
					lista.add(central);
				}
				rs.close();
				resultado =(CentralDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), CentralDTO.class);
				
				cat.debug("Fin Llenado Centrales");
			}
			cat.debug("msgError[" + msgError + "]");
	
			
		
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener listado de centrales",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
		 	if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
	
		cat.debug("Fin:getListadoCentrales");
	
		return resultado;
	}
	
	public void validarActuacion(CentralDTO entrada) 
		throws ResourceDomainException
	{
		int codError = 0;		
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:validarActuacion");
			
			String call = getSQLDatos("VE_SERVICIOS_VENTA_PG","VE_ValidaActuacion_PR",5);
	
			cat.debug("sql[" + call + "]");
	
			cstmt = conn.prepareCall(call);
			cstmt.setString(1, entrada.getCodActabo());
			cstmt.setString(2, entrada.getCodigoTecnologia());
			
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:validarActuacion:execute");
			cstmt.execute();
			cat.debug("Fin:validarActuacion:execute");
	
			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			if (codError !=0 )
			{
				cat.error("Ocurrió un error validando actuacion");
				throw new ResourceDomainException(String.valueOf(codError), numEvento, msgError);
			
			}
			cat.debug("msgError[" + msgError + "]");
	
			
		
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener listado de centrales",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
		 	if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
	
		cat.debug("Fin:validarActuacion");
	}// fin validarActuacion

}//Fin CentralDAO
