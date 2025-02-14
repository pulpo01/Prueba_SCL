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
 * 28/08/2006     Jimmy Lopez              					Versión Inicial
 */
package com.tmmas.cl.scl.pv.customerorder.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Category;
//import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.pv.customerorder.businessobject.helper.Global;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.OrdenServicioDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.exception.CustomerOrderException;

public class CustomerOrderDAO extends ConnectionDAO {
	//private static Category cat = Category.getInstance(CustomerOrderDAO.class);

	//Global global = Global.getInstance();
	
	//private static Logger logger = Logger.getLogger(CustomerAccountDAO.class);
	private static Category logger = Category.getInstance(CustomerOrderDAO.class);
	
	private CompositeConfiguration config;
	
	public CustomerOrderDAO() {
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
	

	private String getSQLsaveCustomerOrderProduct() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   so_orserv PV_CI_ORSERV_QT := PV_inicia_estructuras_sb_PG.pv_inicia_ci_orserv_fn;");
		call.append(" BEGIN ");
		call.append("   SO_orserv.NUM_OS := ?;");
		call.append("   SO_orserv.COD_OS := ?;");
		call.append("   SO_orserv.COD_INTER  := ?;");
		call.append("   SO_orserv.COMENTARIO := ?;");	
		call.append("   SO_orserv.TIP_INTER := ?;");
		call.append("   SO_orserv.NUM_CARGO := null;");
		call.append("   SO_orserv.COD_MODULO := 'PV';");
		call.append("   SO_orserv.ID_GESTOR := null;");
		call.append("   SO_orserv.NUM_MOVIMIENTO := null;");
		call.append("   SO_orserv.COD_ESTADO := null;");
		call.append("   SO_orserv.USUARIO := ?;");
		call.append("   PV_OOSS_SB_PG.pv_inscribir_ooss_pr( SO_orserv, ?, ?, ?);");
		call.append(" END;");
		return call.toString();
	}

	/**
	 * Guarda la informacion de la orden de servicio
	 * @param oS
	 * @throws CustomerOrderException
	 */
	public void saveCustomerOrderProduct(OrdenServicioDTO oS)
			throws CustomerOrderException {

		if (logger.isDebugEnabled()) {
			logger.debug("saveCustomerOrderProduct():start");
		}

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		try {
			//conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			conn = getConnectionDAO("jndi.tol25.Customer.scl.dataSource"); //MA
			
		} catch (Exception e1) {
			logger.error(" No se pudo obtener una conexión ", e1);
			throw new CustomerOrderException("No se pudo obtener una conexión",
					e1);
		}

		try {
			String call = getSQLsaveCustomerOrderProduct();

			if (logger.isDebugEnabled()) {
				logger.debug("sql[" + call + "]");
			}

			cstmt = conn.prepareCall(call);

			if (logger.isDebugEnabled()) {
				logger.debug("Registrando Entradas");
				logger.debug("numero orden servicio[" + oS.getNumeroOrdenServicio() + "]");
				logger.debug("orden servicio       [" + oS.getOrdenServicio() + "]");
				logger.debug("numero abonado (clte)[" + oS.getNumeroAbonado() + "]");
				logger.debug("comentario           [" + oS.getComentario() + "]");
				logger.debug("Tipo                 [" + oS.getTipo() + "]");
				logger.debug("Usuario              [" + oS.getUserName() + "]");
			}
			cstmt.setLong(1, oS.getNumeroOrdenServicio());
			cstmt.setLong(2, oS.getOrdenServicio());
			cstmt.setLong(3, oS.getNumeroAbonado());
			cstmt.setString(4, oS.getComentario());
			cstmt.setInt(5, oS.getTipo());
			cstmt.setString(6, oS.getUserName());

			if (logger.isDebugEnabled()) {
				logger.debug(" Registrando salidas");
			}
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);

			if (logger.isDebugEnabled()) {
				logger.debug(" Iniciando Ejecución");
			}

			logger.debug("Execute Antes");
			cstmt.execute();
			logger.debug("Execute Despues");

			codError = cstmt.getInt(7);
			logger.debug("codError [" + codError + "]");
			msgError = cstmt.getString(8);
			logger.debug("msgError [" + msgError + "]");
			numEvento = cstmt.getInt(9);
			logger.debug("numEvento[" + numEvento + "]");

			if (codError != 0) {
				logger.error(" Ocurrió un error al guardar la orden de servicio");
				throw new CustomerOrderException(
						"Ocurrió un error al guardar la orden de servicio", String
								.valueOf(codError), numEvento, msgError);
			}

			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
			// Recuperacion de valores de salida

		} catch (Exception e) {
			logger.error("Ocurrió un error general al guardar la orden de servicio",
							e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new CustomerOrderException(
					"Ocurrió un error general al guardar la orden de servicio",
					e);
		} finally {
			if (logger.isDebugEnabled()) {
				logger.debug("Cerrando conexiones...");
			}
			try {
				if (cstmt != null) {
					cstmt.close();
					cstmt = null;
				}
				if (conn != null) {
					if (!conn.isClosed()) {
						conn.close();
					}
					conn = null;
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				logger.debug("SQLException[" + e + "]");
			}
		}

		if (codError != 0) {
			logger.info("stop with errors");
			throw new CustomerOrderException(String.valueOf(codError),
					numEvento, msgError);
		}

		if (logger.isDebugEnabled()) {
			logger.debug("saveCustomerOrderProduct():end");
		}

	}
}
