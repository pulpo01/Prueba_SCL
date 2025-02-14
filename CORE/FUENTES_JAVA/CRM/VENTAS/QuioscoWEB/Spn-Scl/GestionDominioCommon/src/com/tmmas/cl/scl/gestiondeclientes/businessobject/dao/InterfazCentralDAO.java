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

package com.tmmas.cl.scl.gestiondeclientes.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.InterfazCentralDTO;
import com.tmmas.cl.scl.gestiondeclietnes.businessobject.helper.Global;

public class InterfazCentralDAO extends ConnectionDAO{

	private Logger logger = Logger.getLogger(this.getClass());
	private Global global = Global.getInstance();
	
	
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
	
	/**
	 *Inserta movimiento en central
	 * @param entrada
	 * @return resultado
	 * @throws GeneralException
	 */

	public void provisionaLinea(InterfazCentralDTO entrada) throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:provisionaLinea");
			
			String call = getSQLPackage("VE_servicios_venta_PG","VE_crea_movimiento_central_PR",26);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			
			cstmt.setLong(1,entrada.getNumeroMovimiento());
			logger.debug("getNumeroMovimiento: [" + entrada.getNumeroMovimiento() + "]");
			cstmt.setLong(2,entrada.getNumeroAbonado());
			logger.debug("getNumeroAbonado: [" + entrada.getNumeroAbonado() + "]");
			cstmt.setInt(3,entrada.getCodigoEstado());
			logger.debug("getCodigoEstado: [" + entrada.getCodigoEstado() + "]");
			cstmt.setString(4,entrada.getCodActabo());
			logger.debug("getCodActabo: [" + entrada.getCodActabo() + "]");
			cstmt.setString(5,entrada.getCodigoModulo());
			logger.debug("getCodigoModulo: [" + entrada.getCodigoModulo() + "]");
			cstmt.setString(6,entrada.getCodigoActuacion());
			logger.debug("getCodigoActuacion: [" + entrada.getCodigoActuacion() + "]");
			cstmt.setString(7,entrada.getCodigoUsuario());
			logger.debug("getCodigoUsuario: [" + entrada.getCodigoUsuario() + "]");
			//cstmt.setString(8,entrada.getFechaIngreso()); csr-11002
			cstmt.setTimestamp(8, entrada.getFechaIngreso());
			logger.debug("getFechaIngreso: [" + entrada.getFechaIngreso() + "]");
			cstmt.setString(9,entrada.getTipoTerminal());
			logger.debug("getTipoTerminal: [" + entrada.getTipoTerminal() + "]");
			cstmt.setInt(10,entrada.getCodigoCentral());
			logger.debug("getCodigoCentral: [" + entrada.getCodigoCentral() + "]");
			cstmt.setLong(11,entrada.getNumeroCelular());
			logger.debug("getNumeroCelular: [" + entrada.getNumeroCelular() + "]");
			cstmt.setString(12,entrada.getNumeroSerie());
			logger.debug("getNumeroSerie: [" + entrada.getNumeroSerie() + "]");
			cstmt.setString(13,entrada.getCodigoServicio());
			logger.debug("getCodigoServicio: [" + entrada.getCodigoServicio() + "]");
			cstmt.setString(14,entrada.getNumMin());
			logger.debug("getNumMin: [" + entrada.getNumMin() + "]");
			cstmt.setString(15,entrada.getTipoTecnologia());
			logger.debug("getTipoTecnologia: [" + entrada.getTipoTecnologia() + "]");
			cstmt.setString(16,entrada.getImsi());
			logger.debug("getImsi: [" + entrada.getImsi() + "]");
			cstmt.setString(17,entrada.getImei());
			logger.debug("getImei: [" + entrada.getImei() + "]");
			cstmt.setString(18,entrada.getIcc());
			logger.debug("getIcc: [" + entrada.getIcc() + "]");
			
			cstmt.setString(19,entrada.getNumeroMovtoAnterior());
			logger.debug("getNumeroMovtoAnterior: [" + entrada.getNumeroMovtoAnterior() + "]");
			
			cstmt.setString(20,entrada.getPlan());
			logger.debug("getPlan: [" + entrada.getPlan() + "]");
			
			if (entrada.getValorPlan()>0)
				cstmt.setFloat(21,entrada.getValorPlan());
			else
				cstmt.setString(21,null);
			logger.debug("getValorPlan: [" + entrada.getValorPlan() + "]");
			
			cstmt.setString(22,entrada.getCarga());
			logger.debug("getCarga: [" + entrada.getCarga() + "]");
			
			cstmt.setLong(23,entrada.getNumFax());
			logger.debug("getNumFax [" + entrada.getNumFax() + "]");
			
			cstmt.registerOutParameter(24, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(25, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(26, java.sql.Types.NUMERIC);
			cstmt.execute();
			
			codError=cstmt.getInt(24);
			msgError = cstmt.getString(25);
			numEvento=cstmt.getInt(26);
			
			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");
			
			if (codError != 0){
				logger.error("Ocurrió un error al provisionar Linea en Central");
				throw new GeneralException(
				"Ocurrió un error al provisionar Linea en Central", String
				.valueOf(codError), numEvento, msgError);
			}
			
		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			logger.error("Ocurrió un error al provisionar Linea en Central",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");				
			}
			throw new GeneralException(
					"Ocurrió un error al insertar movimientos", String
							.valueOf(codError), numEvento, msgError);
		} finally {
				logger.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				logger.debug("SQLException", e);
		  }
		}

		logger.debug("Fin:provisionaLinea");

	}//fin provicionaLinea
	
}

