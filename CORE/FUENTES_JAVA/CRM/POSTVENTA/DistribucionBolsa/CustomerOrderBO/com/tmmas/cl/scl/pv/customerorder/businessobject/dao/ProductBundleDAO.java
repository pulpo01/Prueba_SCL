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
 * 13/09/2006     Jimmy Lopez              					Versión Inicial
 */
package com.tmmas.cl.scl.pv.customerorder.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Category;
//import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.pv.customerorder.businessobject.helper.Global;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ReglasSSDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.exception.CustomerOrderException;

public class ProductBundleDAO extends ConnectionDAO {
	
	//private static Category cat = Category.getInstance(ProductBundleDAO.class);

	//Global global = Global.getInstance();
	
	//private static Logger logger = Logger.getLogger(CustomerAccountDAO.class);
	private static Category logger = Category.getInstance(ProductBundleDAO.class);
	private CompositeConfiguration config;
	
	public ProductBundleDAO() {
		setLog();
	}
	
	private void setLog() {
//		 inicio MA
		String strRuta = "/com/tmmas/cl/CustomerOrderBO/properties/";
		String srtRutaDeploy = System.getProperty("user.dir");
		String strArchivoProperties= "CustomerOrderBO.properties";
		String strArchivoLog="CustomerOrderDAO.log";
		String strRutaArchivoExterno = srtRutaDeploy + "/" + strRuta + strArchivoProperties;
	
		config = UtilProperty.getConfiguration(strRutaArchivoExterno, strRutaArchivoExterno);
		
		UtilLog.setLog(strRuta + config.getString(strArchivoLog) );
		
		// fin MA	
	}
	
	public Connection getConnectionDAO(
			String strDataSource  )
            throws Exception {

        Context ctx = null;
        ctx = new InitialContext();
        DataSource ds = null;
        logger.debug("parameters.getJndiDataSource() ["+ strDataSource +"]");
        ds = ( DataSource ) ctx.lookup( config.getString(strDataSource));
        Connection conn = null;
        conn = ds.getConnection();        
        return conn;
    }
	
	
	private String getSQLgetReglasdeValidacionSS(){
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call
				.append("   SO_SERVSUPL PV_SERVSUPL_QT := PV_inicia_estructuras_sb_PG.PV_INICIA_SERVSUPL_FN;");
		call.append("   SN_COD_RETORNO NUMBER;");
		call.append("   SV_MENS_RETORNO VARCHAR2(200);");
		call.append("   SN_NUM_EVENTO NUMBER;");
		call.append(" BEGIN ");
		call.append("   SN_COD_RETORNO := NULL;");
		call.append("   SV_MENS_RETORNO := NULL;");
		call.append("   SN_NUM_EVENTO := NULL;");
		call
				.append("   PV_SERVSUPL_SB_PG.PV_reglas_valid_vig_ss_PR( SO_SERVSUPL, ?, ?, ?, ?);");
		call.append(" END;");
		return call.toString();			
		
	}
	
	/**
	 * Obtine las reglas de validacion de servicios suplementarios
	 * @return
	 * @throws CustomerOrderException
	 */	
	public ReglasSSDTO[] getReglasdeValidacionSS() throws CustomerOrderException {
		if (logger.isDebugEnabled()) {
			logger.debug("getReglasdeValidacionSS():start");
		}

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ReglasSSDTO[] reglas = null;

		Connection conn = null;
		try {
			//conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			//conn = getConnectionDAO(config.getString("jndi.tol25.Customer.scl.dataSources"));//MA
			conn = getConnectionDAO("jndi.tol25.Customer.scl.dataSources");//MA
			
			
		} catch (Exception e1) {
			logger.error(" No se pudo obtener una conexión ", e1);
			throw new CustomerOrderException("No se pudo obtener una conexión",
					e1);
		}

		try {
			String call = getSQLgetReglasdeValidacionSS();

			if (logger.isDebugEnabled()) {
				logger.debug("sql[" + call + "]");
			}

			CallableStatement cstmt = conn.prepareCall(call);


			if (logger.isDebugEnabled()) {
				logger.debug(" Registrando salidas");
			}
			cstmt
					.registerOutParameter(1,
							oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);

			if (logger.isDebugEnabled()) {
				logger.debug(" Iniciando Ejecución");
			}

			cstmt.execute();

			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
			// Recuperacion de valores de salida

			codError = cstmt.getInt(2);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(3);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(4);
			logger.debug("numEvento[" + numEvento + "]");

			if (codError != 0) {
				logger.error(" Ocurrió un error al recuperar las reglas");

				throw new CustomerOrderException(String.valueOf(codError),
						numEvento, msgError);
			}

			logger.debug("Recuperando cursor...");
			ResultSet rs = (ResultSet) cstmt.getObject(1);
			ArrayList lista = new ArrayList();
			while (rs.next()) {
				ReglasSSDTO regla = new ReglasSSDTO();
				regla.setCodProducto(rs.getInt(1));
				regla.setCodServicio(rs.getString(2));				
				regla.setCodServDef(rs.getString(3));
				regla.setNomUsuario(rs.getString(4));
				regla.setCodServOrig(rs.getString(5));
				regla.setTipoRelacion(rs.getInt(6));
				regla.setCodActAbo(rs.getString(7));
				
				lista.add(regla);
			}

			reglas = (ReglasSSDTO[])ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), ReglasSSDTO.class);
			
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;		
			
		} catch (Exception e) {
			logger.error("Ocurrió un error general al recuperar al recuperar las reglas",
							e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new CustomerOrderException(
					"Ocurrió un error general al recuperar al recuperar las reglas",
					e);
		} finally {
			if (logger.isDebugEnabled()) {
				logger.debug("Cerrando conexiones...");
			}
			try {
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				logger.debug("SQLException[" + e + "]");
			}
		}


		if (logger.isDebugEnabled()) {
			logger.debug("getReglasdeValidacionSS():end");
		}
		return reglas;
	}	
}
