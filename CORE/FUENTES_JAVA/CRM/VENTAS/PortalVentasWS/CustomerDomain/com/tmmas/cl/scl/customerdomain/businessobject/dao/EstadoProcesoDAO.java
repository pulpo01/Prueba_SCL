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
 * 08/02/2007     H&eacute;ctor Hermosilla      					Versión Inicial
 */

package com.tmmas.cl.scl.customerdomain.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.EstadoProcesoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.helper.Global;


public class EstadoProcesoDAO extends ConnectionDAO{
	private static Category cat = Category.getInstance(EstadoProcesoDAO.class);

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

	public EstadoProcesoDTO getProgreso(EstadoProcesoDTO progreso)
		throws CustomerDomainException
	{
		cat.debug("getProgreso:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		EstadoProcesoDTO resultado = new EstadoProcesoDTO();
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		cat.debug("Coneccion obtenida OK");
		try {
			String call = getSQLPackage("VE_estado_proceso_PG","VE_recuperaprogreso_PR",9);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,progreso.getCodigoProceso());
			cat.debug("claave progreso ():" + progreso.getCodigoProceso());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);
			cstmt.execute();
			codError = cstmt.getInt(7);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(8);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(9);
			cat.debug("numEvento[" + numEvento + "]");
			/*if (codError != 0) {
				cat.error("Ocurrió un error al consultar el Tipo de Documento");
				throw new CustomerDomainException(
						"Ocurrió un error al consultar el Tipo de Documento", String
								.valueOf(codError), numEvento, msgError);
				
			}else{*/
			resultado.setCodigoProceso(progreso.getCodigoProceso());
			resultado.setProgreso(Integer.toString(cstmt.getInt(2)));
			resultado.setIndiceSubProceso(Integer.toString(cstmt.getInt(3)));
			resultado.setTotalSubProceso(Integer.toString(cstmt.getInt(4)));
			resultado.setCodigoError(Integer.toString(cstmt.getInt(5)));
			resultado.setDescripcionError(cstmt.getString(6));
			//}
			if (cat.isDebugEnabled()) {
				
				resultado.setProgreso(Integer.toString(cstmt.getInt(2)));
				cat.debug("DAO resultado.getProgreso():" + resultado.getProgreso()) ;
				resultado.setIndiceSubProceso(Integer.toString(cstmt.getInt(3)));
				cat.debug("DAO resultado.setIndiceSubProceso():" + resultado.getIndiceSubProceso()) ;
				resultado.setTotalSubProceso(Integer.toString(cstmt.getInt(4)));
				cat.debug("DAO resultado.setTotalSubProceso():" + resultado.getTotalSubProceso()) ;
				resultado.setCodigoError(Integer.toString(cstmt.getInt(5)));
				cat.debug("DAO resultado.getCodigoError():" + resultado.getCodigoError()) ;
				resultado.setDescripcionError(cstmt.getString(6));
				cat.debug("DAO resultado.getDescripcionError():" + resultado.getDescripcionError()) ;
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
				
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al consultar el progreso",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new CustomerDomainException(
					"Ocurrió un error al consultar el progreso",e);
		} finally {
				cat.debug("Cerrando conexiones...");
	    try {
			if (!conn.isClosed()) {
				cstmt.close();
				conn.close();
			}
		  } catch (SQLException e) {
				cat.debug("SQLException", e);
		  }
		}

		cat.debug("getProgreso():end");

		return resultado;
	}
	
	
	public void insertaProceso(EstadoProcesoDTO proceso) 
		throws CustomerDomainException
	{
		cat.debug("insertaProceso():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();
		cat.debug("Coneccion obtenida OK");
		try {
			String call = getSQLPackage("VE_estado_proceso_PG","VE_insertaproceso_PR",7);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,proceso.getCodigoProceso());
			cstmt.setInt(2,Integer.parseInt(proceso.getProgreso()));
			cstmt.setInt(3,Integer.parseInt(proceso.getIndiceSubProceso()));
			cstmt.setInt(4,Integer.parseInt(proceso.getTotalSubProceso()));
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			cstmt.execute();
			codError = cstmt.getInt(5);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(6);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(7);
			cat.debug("numEvento[" + numEvento + "]");
			/*if (codError != 0) {
				cat.error("Ocurrió un error al consultar el Tipo de Documento");
				throw new CustomerDomainException(
						"Ocurrió un error al consultar el Tipo de Documento", String
								.valueOf(codError), numEvento, msgError);
				
			}else{*/
			//}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al insertar el progreso",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new CustomerDomainException(
					"Ocurrió un error al insertar el progreso",e);
		} finally {
			cat.debug("Cerrando conexiones...");
		    try {
		    	if (!conn.isClosed()) {
		    		cstmt.close();
					conn.close();
				}
			} catch (SQLException e) {
					cat.debug("SQLException", e);
			}
		}
		cat.debug("insertaProceso():end");

	}
	
	public void modificaProceso(EstadoProcesoDTO proceso)
		throws CustomerDomainException
	{
		cat.debug("modificaProceso():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		cat.debug("Coneccion obtenida OK");
		CallableStatement cstmt = null;
		try {
			String call = getSQLPackage("VE_estado_proceso_PG","VE_modificaproceso_PR",9);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,proceso.getCodigoProceso());
			cat.debug("DAO1 proceso.getCodigoProceso():" + proceso.getCodigoProceso());
			cstmt.setInt(2,Integer.parseInt(proceso.getProgreso()));
			cat.debug("DAO1 proceso.getProgreso():" + proceso.getProgreso());
			cstmt.setInt(3,Integer.parseInt(proceso.getIndiceSubProceso()));
			cat.debug("DAO1 proceso.getIndiceSubProceso():" + proceso.getIndiceSubProceso());
			cstmt.setInt(4,Integer.parseInt(proceso.getTotalSubProceso()));
			cat.debug("DAO1 proceso.getTotalSubProceso():" + proceso.getTotalSubProceso());
			cstmt.setInt(5,Integer.parseInt(proceso.getCodigoError()));
			cat.debug("DAO1 proceso.getCodigoError():" + proceso.getCodigoError());
			cstmt.setString(6,proceso.getDescripcionError());
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);
			cstmt.execute();
			codError = cstmt.getInt(7);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(8);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(9);
			cat.debug("numEvento[" + numEvento + "]");
			/*if (codError != 0) {
				cat.error("Ocurrió un error al consultar el Tipo de Documento");
				throw new CustomerDomainException(
						"Ocurrió un error al consultar el Tipo de Documento", String
								.valueOf(codError), numEvento, msgError);
				
			}else{*/
			//}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al modificar el progreso",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new CustomerDomainException(
					"Ocurrió un error al modificar el progreso",e);
		} finally {
				cat.debug("Cerrando conexiones...");
	    try {
	    	if (!conn.isClosed()) {
	    		cstmt.close();	
				conn.close();
			}
		  } catch (SQLException e) {
				cat.debug("SQLException", e);
		  }
		}
		cat.debug("modificaProceso():end");

	}

	/**
	 * elimina estado de proceso
	 * @param N/A
	 * @return N/A
	 * @throws CustomerDomainException
	 */	
	public void eliminaProceso(EstadoProcesoDTO proceso) 
		throws CustomerDomainException
	{
		cat.debug("EliminaProceso():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();
		try {
			String call = getSQLPackage("VE_estado_proceso_PG","VE_EliminaProceso_PR",4);
			cat.debug("sql[" + call + "]");
						
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,proceso.getCodigoProceso());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);

			cat.debug("eliminaProceso:Inicio");
			cstmt.execute();
			cat.debug("eliminaProceso:Fin");

			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);

			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al eliminar proceso",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new CustomerDomainException(
					"Ocurrió un error al eliminar proceso",e);
		} finally {
			cat.debug("Cerrando conexiones...");
		    try {
		    	if (!conn.isClosed()) {
		    		cstmt.close();
					conn.close();
				}
			} catch (SQLException e) {
					cat.debug("SQLException", e);
			}
		}
		cat.debug("EliminaProceso():end");
	}//fin eliminaProceso

	
}//fin class EstadoProcesoDAO


