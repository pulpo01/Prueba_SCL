package com.tmmas.cl.scl.tol.ServiceBundle.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.lang.SerializationUtils;
import org.apache.log4j.Category;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ParametroProcesoDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.exception.TOLException;
import com.tmmas.cl.scl.tol.ServiceBundle.businessobject.helper.Global;

public class ProcesoAsincronoDAO extends ConnectionDAO{
	private static Category cat = Category.getInstance(ProcesoAsincronoDAO.class);

	//Global global = Global.getInstance();
	
	// INICIO MA 69363 RRG 04-11-2008
	
	private CompositeConfiguration config;
	
	public ProcesoAsincronoDAO() {
		setPropFile();
	}
	
	private void setPropFile() {
//		 inicio MA
		String strArchivoLog;
		String strRuta = "com/tmmas/cl/tol/properties/";
		String srtRutaDeploy = System.getProperty("user.dir");
		String strRutaArchivoExterno = srtRutaDeploy + "/" + strRuta + "tol.webservice.properties";
		System.out.println("strRutaArchivoExterno:"+strRutaArchivoExterno);
		//config = UtilProperty.getConfigurationfromExternalFile(strRutaArchivoExterno);
		config = UtilProperty.getConfiguration(strRutaArchivoExterno,strRutaArchivoExterno);
		System.out.println("config.isEmpty():" + config.isEmpty());
		strArchivoLog = config.getString("tol.bo.log");
		System.out.println("strArchivoLog:" + strRuta+strArchivoLog);
		UtilLog.setLog("/" +strRuta+strArchivoLog);
		// fin MA	
	}
	
	public Connection getConnectionDAO(String strDataSource)
    throws Exception {

		Context ctx = null;
		ctx = new InitialContext();
		DataSource ds = null;
		
		cat.debug("parameters.getJndiDataSource() ["+ strDataSource +"]");
		try {
			//ds = ( DataSource ) ctx.lookup( strDataSource);
			ds = ( DataSource ) ctx.lookup( config.getString(strDataSource));
		}catch (Exception e ) {
			cat.debug("[getConnectionDAO][Conexion]" + e.getMessage());
			throw e;
		}
		Connection conn = null;
		conn = ds.getConnection();        
		return conn;
	}
	
	// FIN MA 69363 RRG 04-11-2008
	
	private String getSQLinscribeProceso()
	{
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append(" EO_Inscribe_Proceso TOL_INSCRIBE_PROCESO_QT := TOL_inicia_estructuras_sb_PG.TOL_Inicia_TOL_Insc_Proc_QT_FN;");
		call.append(" BEGIN ");
		call.append(" EO_Inscribe_Proceso.parametros := ?;"); 
		call.append(" EO_Inscribe_Proceso.glosa_proceso := ?;");
		call.append(" EO_Inscribe_Proceso.observacion := ?;");
		call.append(" EO_Inscribe_Proceso.num_reintentos := ?;");
		call.append(" EO_Inscribe_Proceso.num_proceso_sgte := 2;");
		call.append(" tol_procesos_sb_pg.tol_inscribir_proc_pr( EO_Inscribe_Proceso, ?, ?);");
		call.append(" ? := EO_Inscribe_Proceso.num_proceso;");
		call.append(" END;");
		
		return call.toString();		
			
	
	}
	
	public ParametroProcesoDTO inscribeProceso(ParametroProcesoDTO dto) throws TOLException
	{
		cat.debug("inscribeProceso:star");
		
		int codError = 0;
		String msgError = null;

		Connection conn = null;
		try {
			//conn = getConnectionFromWLSInitialContext(global.getJndiTOLForDataSource());
			conn = getConnectionDAO("jndi.tol25.tol.tol.dataSource");
		} catch (Exception e1) {
			cat.error(" No se pudo obtener una conexión ", e1);
			throw new TOLException("No se pudo obtener una conexión", e1);
		}

		try {
			String call = getSQLinscribeProceso();

			cat.debug("sql[" + call + "]");

			CallableStatement cstmt = conn.prepareCall(call);

			cat.debug("Registrando Entradas");
			cat.debug("getGlosa_proceso " + dto.getGlosa_proceso());
			cat.debug("getObservacion " + dto.getObservacion() );
			cat.debug("getNum_reintentos " + dto.getNum_reintentos());
			
			
			cstmt.setBytes(1, (byte[])SerializationUtils.serialize(dto.getParametro()) );
			cstmt.setString(2, dto.getGlosa_proceso() );
			cstmt.setString(3, dto.getObservacion() );
			cstmt.setInt(4, dto.getNum_reintentos() );
			
			
			

			cat.debug(" Registrando salidas");
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);

			cat.debug("Execute Antes");
			cstmt.execute();
			cat.debug("Execute Despues");
				
			codError = cstmt.getInt(5);
			cat.debug("codError[" + codError + "]");

			msgError = cstmt.getString(6);
			cat.debug("msgError[" + msgError + "]");
				
			if (codError != 0) {
				cat.error("Ocurrio un error al inscribir el proceso");
				throw new TOLException("Ocurrio un error al inscribir el proceso", String.valueOf(codError), 0, msgError);
			}
				
			dto.setNumeroProceso(cstmt.getInt(7));
			
			cat.debug(" Finalizo ejecución");
			
		} catch (TOLException e) {
			cat.error("TOLException", e);
			throw e;
			
		} catch (Exception e) {
			cat.error("Ocurrio un error al inscribir el proceso",	e);
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error: " + msgError + "]");

			throw new TOLException("Ocurrio un error al inscribir el proceso", e);
		
		} finally {
			cat.debug("Cerrando conexiones...");
			try {
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (Exception e) {
				cat.debug("Exception al Cerrando conexiones...", e);
			}
		}		
		
		
		cat.debug("inscribeProceso:end");		
		
		return dto;
	}

	private String getSQactualizaProceso()
	{
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append(" EO_Inscribe_Proceso TOL_INSCRIBE_PROCESO_QT := TOL_inicia_estructuras_sb_PG.TOL_Inicia_TOL_Insc_Proc_QT_FN;");
		call.append(" BEGIN ");
		call.append(" EO_Inscribe_Proceso.num_proceso := ?;");
		call.append(" EO_Inscribe_Proceso.observacion := ?;");
		call.append(" EO_Inscribe_Proceso.error_tecnico := ?;");
		call.append(" EO_Inscribe_Proceso.estado := ?; ");
		call.append(" tol_procesos_sb_pg.tol_actualizar_proc_pr( EO_Inscribe_Proceso, ?, ?);");
		call.append(" END;");
																									
		return call.toString();		
			
	
	}	
	
	public ParametroProcesoDTO actualizaProceso(ParametroProcesoDTO dto) throws TOLException
	{
		cat.debug("actualizaProceso:star");
		
		int codError = 0;
		String msgError = null;

		Connection conn = null;
		try {
			//conn = getConnectionFromWLSInitialContext(global.getJndiTOLForDataSource());
			conn = getConnectionDAO("jndi.tol25.tol.tol.dataSource");
		} catch (Exception e1) {
			cat.error(" No se pudo obtener una conexión ", e1);
			throw new TOLException("No se pudo obtener una conexión", e1);
		}

		try {
			String call = getSQactualizaProceso();

			cat.debug("sql[" + call + "]");

			CallableStatement cstmt = conn.prepareCall(call);

			cat.debug("Registrando Entradas");
			cat.debug("getNumeroProceso " + dto.getNumeroProceso());
			cat.debug("getObservacion " + dto.getObservacion());
			cat.debug("getError_tecnico " + dto.getError_tecnico());
			cat.debug("getEstado " + dto.getEstado());
			
			
			cstmt.setInt(1, dto.getNumeroProceso() );
			cstmt.setString(2, dto.getObservacion());
			cstmt.setString(3, dto.getError_tecnico());
			cstmt.setInt(4, dto.getEstado() );
			

			cat.debug(" Registrando salidas");
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);

			cat.debug("Execute Antes");
			cstmt.execute();
			cat.debug("Execute Despues");
				
			codError = cstmt.getInt(5);
			cat.debug("codError[" + codError + "]");

			msgError = cstmt.getString(6);
			cat.debug("msgError[" + msgError + "]");
				
			if (codError != 0) {
				cat.error("Ocurrio un error al actualizar el estado del proceso");
				throw new TOLException("Ocurrio un error al actualizar el estado del proceso", String.valueOf(codError), 0, msgError);
			}
				
			cat.debug(" Finalizo ejecución");
			
		} catch (TOLException e) {
			cat.error("TOLException", e);
			throw e;
			
		} catch (Exception e) {
			cat.error("Ocurrio un error al actualizar el estado del proceso",	e);
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error: " + msgError + "]");

			throw new TOLException("Ocurrio un error al actualizar el estado del proceso", e);
			
		} finally {
			cat.debug("Cerrando conexiones...");
			try {
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (Exception e) {
				cat.debug("Exception al Cerrando conexiones...", e);
			}
		}		
		
		cat.debug("actualizaProceso:end");		
		return dto;
	}
}
