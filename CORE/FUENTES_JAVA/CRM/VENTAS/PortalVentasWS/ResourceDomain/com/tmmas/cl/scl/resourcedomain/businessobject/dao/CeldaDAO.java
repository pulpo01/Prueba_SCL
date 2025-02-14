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
 * 20/03/2007     Héctor Hermosilla     					Versión Inicial
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
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CiudadDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.ResourceDomainException;
import com.tmmas.cl.scl.resourcedomain.businessobject.dto.CeldaDTO;
import com.tmmas.cl.scl.resourcedomain.businessobject.helper.Global;

public class CeldaDAO extends ConnectionDAO{
	
		private static Category cat = Category.getInstance(CeldaDAO.class);

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
		
		public CeldaDTO obtieneDatosCelda(CeldaDTO entrada) 
			throws ResourceDomainException
		{
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			conn = getConection();
			CallableStatement cstmt = null; 
			try {
				cat.debug("Inicio:obtieneDatosCelda");
				
				String call = getSQLDatos("VE_PARAMETROS_COMERCIALES_PG","VE_obtienedatoscelda_PR",5);

				cat.debug("sql[" + call + "]");

				cstmt = conn.prepareCall(call);
				cstmt.setString(1, entrada.getCodigoCelda());
				cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
				
				cat.debug("Inicio:obtieneDatosCelda:execute");
				cstmt.execute();
				cat.debug("Fin:obtieneDatosCelda:execute");

				msgError = cstmt.getString(4);
				cat.debug("msgError[" + msgError + "]");

				entrada.setCodSubAlm(cstmt.getString(2));
			
			} catch (Exception e) {
				cat.error("Ocurrió un error al obtener los datos de la celda",e);
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

			cat.debug("Fin:obtieneDatosCelda");

			return entrada;
		}
		
		public CeldaDTO[] getListadoCeldas(CiudadDTO ciudad) 
			throws ResourceDomainException
		{
			int codError = 0;
			CeldaDTO[] resultado = null;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			conn = getConection();
			CallableStatement cstmt = null;
			ResultSet rs = null;
			try {
				cat.debug("Inicio:getListadoCeldas");
				
				String call = getSQLDatos("VE_PARAMETROS_COMERCIALES_PG","VE_listadoceldas_PR",7);

				cat.debug("sql[" + call + "]");

				cstmt = conn.prepareCall(call);
				cstmt.setString(1, ciudad.getCodigoRegion());
				cat.debug("region" + ciudad.getCodigoRegion());
				cstmt.setString(2, ciudad.getCodigoProvincia());
				cat.debug("provincia" + ciudad.getCodigoProvincia());
				cstmt.setString(3, ciudad.getCodigoCiudad());
				cat.debug("ciudad" + ciudad.getCodigoCiudad());
				cstmt.registerOutParameter(4,OracleTypes.CURSOR);
				cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
				
				cat.debug("Inicio:getListadoCeldas:execute");
				cstmt.execute();
				cat.debug("Fin:getListadoCeldas:execute");

				msgError = cstmt.getString(6);
				codError = cstmt.getInt(5);
				if (codError ==0){
					cat.debug("Llenado Celdas");
					ArrayList lista = new ArrayList();
					rs = (ResultSet)cstmt.getObject(4);
					
					while (rs.next()) {
						CeldaDTO celda = new CeldaDTO();
						celda.setCodigoCelda(rs.getString(1));
						celda.setDescripcionCelda(rs.getString(2));
						celda.setCodSubAlm(rs.getString(3));
						lista.add(celda);
					}					
					resultado =(CeldaDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
						lista.toArray(), CeldaDTO.class);
					
					cat.debug("Fin Llenado Celdas");
				}
				cat.debug("msgError[" + msgError + "]");
					

				
			
			} catch (Exception e) {
				cat.error("Ocurrió un error al obtener listado de celdas",e);
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

			cat.debug("Fin:getListadoCeldas");

			return resultado;
		}


}
