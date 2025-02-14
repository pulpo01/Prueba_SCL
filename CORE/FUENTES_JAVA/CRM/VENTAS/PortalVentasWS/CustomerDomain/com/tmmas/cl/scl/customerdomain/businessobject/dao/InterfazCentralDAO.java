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
 * 12/04/2007     H&eacute;ctor Hermosilla      					Versión Inicial
 */

package com.tmmas.cl.scl.customerdomain.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.InterfazCentralDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.helper.Global;

public class InterfazCentralDAO extends ConnectionDAO{

	private static Category cat = Category.getInstance(InterfazCentralDAO.class);
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
	
		
	/**
	 *Inserta movimiento en central
	 * @param entrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */

	public void provisionaLinea(InterfazCentralDTO entrada) 
		throws CustomerDomainException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;		
		try {
			cat.debug("Inicio:provisionaLinea");
			
			String call = getSQLPackage("VE_servicios_venta_PG","VE_crea_movimiento_central_PR",26);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			
			cstmt.setLong(1,entrada.getNumeroMovimiento());
			cat.debug("getNumeroMovimiento: [" + entrada.getNumeroMovimiento() + "]");
			cstmt.setLong(2,entrada.getNumeroAbonado());
			cat.debug("getNumeroAbonado: [" + entrada.getNumeroAbonado() + "]");
			cstmt.setInt(3,entrada.getCodigoEstado());
			cat.debug("getCodigoEstado: [" + entrada.getCodigoEstado() + "]");
			cstmt.setString(4,entrada.getCodActabo());
			cat.debug("getCodActabo: [" + entrada.getCodActabo() + "]");
			cstmt.setString(5,entrada.getCodigoModulo());
			cat.debug("getCodigoModulo: [" + entrada.getCodigoModulo() + "]");
			cstmt.setString(6,entrada.getCodigoActuacion());
			cat.debug("getCodigoActuacion: [" + entrada.getCodigoActuacion() + "]");
			cstmt.setString(7,entrada.getCodigoUsuario());
			cat.debug("getCodigoUsuario: [" + entrada.getCodigoUsuario() + "]");
			cstmt.setTimestamp(8,entrada.getFechaIngreso());
			cat.debug("getFechaIngreso: [" + entrada.getFechaIngreso() + "]");
			cstmt.setString(9,entrada.getTipoTerminal());
			cat.debug("getTipoTerminal: [" + entrada.getTipoTerminal() + "]");
			cstmt.setInt(10,entrada.getCodigoCentral());
			cat.debug("getCodigoCentral: [" + entrada.getCodigoCentral() + "]");
			cstmt.setLong(11,entrada.getNumeroCelular());
			cat.debug("getNumeroCelular: [" + entrada.getNumeroCelular() + "]");
			cstmt.setString(12,entrada.getNumeroSerie());
			cat.debug("getNumeroSerie: [" + entrada.getNumeroSerie() + "]");
			cstmt.setString(13,entrada.getCodigoServicio());
			cat.debug("getCodigoServicio: [" + entrada.getCodigoServicio() + "]");
			cstmt.setString(14,entrada.getNumMin());
			cat.debug("getNumMin: [" + entrada.getNumMin() + "]");
			cstmt.setString(15,entrada.getTipoTecnologia());
			cat.debug("getTipoTecnologia: [" + entrada.getTipoTecnologia() + "]");
			cstmt.setString(16,entrada.getImsi());
			cat.debug("getImsi: [" + entrada.getImsi() + "]");
			cstmt.setString(17,entrada.getImei());
			cat.debug("getImei: [" + entrada.getImei() + "]");
			cstmt.setString(18,entrada.getIcc());
			cat.debug("getIcc: [" + entrada.getIcc() + "]");
			
			cstmt.setString(19,entrada.getNumeroMovtoAnterior());
			cat.debug("getNumeroMovtoAnterior: [" + entrada.getNumeroMovtoAnterior() + "]");
			
			cstmt.setString(20,entrada.getPlan());
			cat.debug("getPlan: [" + entrada.getPlan() + "]");
			
			if (entrada.getValorPlan()>0)
				cstmt.setFloat(21,entrada.getValorPlan());
			else
				cstmt.setString(21,null);
			cat.debug("getValorPlan: [" + entrada.getValorPlan() + "]");
			
			cstmt.setString(22,entrada.getCarga());
			cat.debug("getNumeroMovtoAnterior: [" + entrada.getCarga() + "]");			
			
			cstmt.setLong(23,entrada.getNumFax());
			cat.debug("getNumFax [" + entrada.getNumFax() + "]");
			
			cstmt.registerOutParameter(24, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(25, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(26, java.sql.Types.NUMERIC);		
			
			cstmt.execute();			
			
			codError=cstmt.getInt(24);
			msgError = cstmt.getString(25);
			numEvento=cstmt.getInt(26);
			
			cat.debug("codError[" + codError + "]");
			cat.debug("msgError[" + msgError + "]");
			cat.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0){
				cat.error("Ocurrió un error al provisionar Linea en Central");
				throw new CustomerDomainException(
				"Ocurrió un error al provisionar Linea en Central", String
				.valueOf(codError), numEvento, msgError);
			}
			
		} catch (Exception e) {
			cat.error("Ocurrió un error al provisionar Linea en Central",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
				cat.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				cat.debug("SQLException", e);
		  }
		}

		cat.debug("Fin:provisionaLinea");

	}//fin provicionaLinea
	
}

