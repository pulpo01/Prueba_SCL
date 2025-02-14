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
 * 14/08/2006     Jimmy Lopez              					Versión Inicial
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

import oracle.jdbc.driver.OracleTypes;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Category;
//import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.base.JndiForDataSource;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;

import com.tmmas.cl.scl.pv.customerorder.businessobject.bo.CustomerAccount;
import com.tmmas.cl.scl.pv.customerorder.businessobject.helper.Global;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.CustomerAccountDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.DistribucionBolsaDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.PlanTarifarioDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ProductDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ProductListDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.SecurityDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.exception.CustomerOrderException;
import com.tmmas.cl.scl.pv.customerorder.commonapp.exception.ProductDomainException;

public class CustomerAccountDAO extends ConnectionDAO {
	//private static logger.egory logger. = logger.egory.getInstance(CustomerAccountDAO.class);

	//Global global = Global.getInstance();

	public CustomerAccountDAO() {
		super();
		setLog();
		// TODO Auto-generated constructor stub
	}
	
	
	//private static Logger logger = Logger.getLogger(CustomerAccountDAO.class);
	private static Category logger = Category.getInstance(CustomerAccountDAO.class);
	
	private CompositeConfiguration config;
	
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
	
	public Connection getConnectionDAO(String strDataSource)
            throws Exception {

        Context ctx = null;
        ctx = new InitialContext();
        DataSource ds = null;
        
        logger.debug("parameters.getJndiDataSource() ["+ strDataSource +"]");
        try {
        	//ds = ( DataSource ) ctx.lookup( strDataSource);
        	ds = ( DataSource ) ctx.lookup( config.getString(strDataSource));
        }catch (Exception e ) {
        	logger.debug("[getConnectionDAO][Conexion]" + e.getMessage());
        	throw e;
        }
        Connection conn = null;
        conn = ds.getConnection();        
        return conn;
    }
	
	
	

	private String getSQLsetInstalledCustomerAccountProductBundle() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   SO_SERVSUPL PV_SERVSUPL_QT := PV_inicia_estructuras_sb_PG.PV_INICIA_SERVSUPL_FN;");
		call.append(" BEGIN ");
		call.append("   SO_SERVSUPL.COD_CLIENTE := ?;");
		call.append("   SO_SERVSUPL.COD_SERVICIO := ?;");
		call.append("   SO_SERVSUPL.DESBORDE := ?;");
		call.append("   SO_SERVSUPL.PRIORIDAD := ?;");
		call.append("   SO_SERVSUPL.PERFIL_LC := ?;");
		call.append("   PV_SERVSUPL_SB_PG.PV_Actualiza_Serv_PR( SO_SERVSUPL, ?, ?, ?);");
		call.append(" END;");
		return call.toString();		
	}	
	
	private String getSQLgetInstalledCustomerAccountProductBundle(){
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   SO_SERVSUPL PV_SERVSUPL_QT := PV_inicia_estructuras_sb_PG.PV_INICIA_SERVSUPL_FN;");
		call.append("   SN_COD_RETORNO NUMBER;");
		call.append("   SV_MENS_RETORNO VARCHAR2(200);");
		call.append("   SN_NUM_EVENTO NUMBER;");
		call.append(" BEGIN ");
		call.append("   SO_SERVSUPL.COD_CLIENTE := ?;");
		call.append("   SN_COD_RETORNO := NULL;");
		call.append("   SV_MENS_RETORNO := NULL;");
		call.append("   SN_NUM_EVENTO := NULL;");
		call.append("   PV_SERVSUPL_SB_PG.PV_OBTIENE_SS_ASOCIADOS_PR( SO_SERVSUPL, ?, ?, ?, ?);");
		call.append(" END;");
		return call.toString();			
		
	}
	
	private String getSQLgetInstalledCustomerAccountProductBundleSLC(){
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   SO_SERVSUPL PV_SERVSUPL_QT := PV_inicia_estructuras_sb_PG.PV_INICIA_SERVSUPL_FN;");
		call.append("   SN_COD_RETORNO NUMBER;");
		call.append("   SV_MENS_RETORNO VARCHAR2(200);");
		call.append("   SN_NUM_EVENTO NUMBER;");
		call.append(" BEGIN ");
		call.append("   SO_SERVSUPL.COD_CLIENTE := ?;");
		call.append("   SN_COD_RETORNO := NULL;");
		call.append("   SV_MENS_RETORNO := NULL;");
		call.append("   SN_NUM_EVENTO := NULL;");
		call.append("   PV_SERVSUPL_SB_PG.PV_OBTIENE_SS_ASOCIADOSSLC_PR( SO_SERVSUPL, ?, ?, ?, ?);");
		call.append(" END;");
		return call.toString();			
		
	}
	
	
	private String getSQLgetUnInstalledCustomerAccountProductBundle(){
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   SO_SERVSUPL PV_SERVSUPL_QT := PV_inicia_estructuras_sb_PG.PV_INICIA_SERVSUPL_FN;");
		call.append("   SN_COD_RETORNO NUMBER;");
		call.append("   SV_MENS_RETORNO VARCHAR2(200);");
		call.append("   SN_NUM_EVENTO NUMBER;");
		call.append(" BEGIN ");
		call.append("   SO_SERVSUPL.COD_CLIENTE := ?;");
		call.append("   SN_COD_RETORNO := NULL;");
		call.append("   SV_MENS_RETORNO := NULL;");
		call.append("   SN_NUM_EVENTO := NULL;");
		call.append("   PV_SERVSUPL_SB_PG.PV_OBTIENE_SS_OPCIONALES_PR( SO_SERVSUPL, ?, ?, ?, ?);");
		call.append(" END;");
		return call.toString();			
		
	}	
	
	
	private String getSQLgetCustomerAccountData() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   SO_SERVSUPL PV_SERVSUPL_QT := PV_inicia_estructuras_sb_PG.PV_INICIA_SERVSUPL_FN;");
		call.append("   SN_COD_RETORNO NUMBER;");
		call.append("   SV_MENS_RETORNO VARCHAR2(200);");
		call.append("   SN_NUM_EVENTO NUMBER;");
		call.append(" BEGIN ");
		call.append("   SO_SERVSUPL.COD_CLIENTE := ?;");
		call.append("   SN_COD_RETORNO := NULL;");
		call.append("   SV_MENS_RETORNO := NULL;");
		call.append("   SN_NUM_EVENTO := NULL;");
		call.append("   PV_DATOSCLI_SB_PG.PV_OBTIENE_DATOS_CLIE_PR( SO_SERVSUPL, ?, ?, ?);");
		call.append("		? := so_SERVSUPL.NOM_CLIENTE;");
		call.append("		? := so_SERVSUPL.cod_plantarif;");		
		call.append("		? := so_SERVSUPL.DES_PLANTARIF;");
		call.append(" END;");
		return call.toString();		
	}
	
	private String getSQLgetSecurityData() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   SO_seguridad PV_IDSEGURIDAD_QT := PV_inicia_estructuras_sb_PG.PV_inicia_IdSeguridad_FN;");
		call.append("   SN_COD_RETORNO NUMBER;");
		call.append("   SV_MENS_RETORNO VARCHAR2(200);");
		call.append("   SN_NUM_EVENTO NUMBER;");
		call.append(" BEGIN ");
		call.append("   SO_seguridad.id_user := ?;");
		call.append("   SN_COD_RETORNO := NULL;");
		call.append("   SV_MENS_RETORNO := NULL;");
		call.append("   SN_NUM_EVENTO := NULL;");
		call.append("   ge_seguridad_web_pg.PV_Id_VerificaSeg_PR( SO_seguridad, ?, ?, ?);");
		call.append("		? := SO_seguridad.resultado;");
		call.append(" END;");
		return call.toString();		
	}
	
	
	private String getSQLsetInstalledProductBundleList() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   SO_SERVSUPL PV_SERVSUPL_QT := PV_inicia_estructuras_sb_PG.PV_INICIA_SERVSUPL_FN;");
		call.append(" BEGIN ");
		call.append("   SO_SERVSUPL.cod_cliente := ?;");
		call.append("   SO_SERVSUPL.cod_servicio := ?;");
		call.append("   SO_SERVSUPL.cod_servsupl := ?;");   
        call.append("   SO_SERVSUPL.cod_nivel := ?;");
  		call.append("   SO_SERVSUPL.ind_desborde := ?;");
		call.append("   SO_SERVSUPL.ind_prioridad := ?;");
		call.append("   SO_SERVSUPL.perfil_lc := ?;");		
		call.append("   PV_SERVSUPL_SB_PG.PV_ACTIVAR_SS_PR( SO_SERVSUPL, ?, ?, ?);");
		call.append(" END;");
		return call.toString();		
	}	
	
	private String getSQLsetUnInstallProductBundleList() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   SO_SERVSUPL PV_SERVSUPL_QT := PV_inicia_estructuras_sb_PG.PV_INICIA_SERVSUPL_FN;");
		call.append("   SN_COD_RETORNO NUMBER;");
		call.append("   SV_MENS_RETORNO VARCHAR2(200);");
		call.append("   SN_NUM_EVENTO NUMBER;");
		call.append(" BEGIN ");
		call.append("   SO_SERVSUPL.cod_cliente := ?;");
		call.append("   SO_SERVSUPL.cod_servicio := ?;");
		call.append("   SN_COD_RETORNO := NULL;");
		call.append("   SV_MENS_RETORNO := NULL;");
		call.append("   SN_NUM_EVENTO := NULL;");
		call.append("   PV_SERVSUPL_SB_PG.PV_DESACTIVAR_SS_PR( SO_SERVSUPL, ?, ?, ?);");
		call.append(" END;");
		return call.toString();		
	}	

	/**
	 * Guarda la lista de servicios suplementarios contratados
	 * @param prodList
	 * @throws CustomerOrderException
	 */	
	public void setInstalledCustomerAccountProductBundle(
			ProductListDTO prodList) throws CustomerOrderException {
		if (logger.isDebugEnabled()) {
			logger.debug("setInstalledCustomerAccountProductBundle():start");
		}

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ProductDTO[] productos = null;

		Connection conn = null;
		try {
			//conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			//conn = getConnectionDAO( config.getString("jndi.tol25.Customer.scl.dataSource") ); // MA
			conn = getConnectionDAO("jndi.tol25.Customer.scl.dataSource"); // MA
		} catch (Exception e1) {
			logger.error(" No se pudo obtener una conexión ", e1);
			throw new CustomerOrderException("No se pudo obtener una conexión",
					e1);
		}

		try {
			String call = getSQLsetInstalledCustomerAccountProductBundle();

			if (logger.isDebugEnabled()) {
				logger.debug("sql[" + call + "]");
			}

			CallableStatement cstmt = conn.prepareCall(call);

			if (logger.isDebugEnabled()) {
				logger.debug("Registrando Entradas");
				logger.debug("Id de Cliente[" + prodList.getCustomer().getCode() + "]");
			}
			cstmt.setLong(1, prodList.getCustomer().getCode());

			if (logger.isDebugEnabled()) {
				logger.debug(" Registrando salidas");
			}
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);

			if (logger.isDebugEnabled()) {
				logger.debug(" Iniciando Ejecución");
			}
			
			productos = prodList.getProducts();
			
			logger.debug("Elementos[" + productos.length + "]");
			for (int i = 0; i < productos.length; i++) {
				String serviceId = productos[i].getId(); 
				String desbordeId = productos[i].getExceedId();
				String prioridadId = productos[i].getPriority();
				String profileId = productos[i].getProfileId();
				logger.debug("Iteracion[" + i + "]");
				logger.debug("serviceId[" + serviceId + "]");
				logger.debug("desbordeId[" + desbordeId + "]");
				logger.debug("prioridadId[" + prioridadId + "]");
				logger.debug("profileId[" + profileId + "]");
				cstmt.setString(2, serviceId);
				cstmt.setString(3, desbordeId);
				cstmt.setString(4, prioridadId);
				cstmt.setString(5, profileId);
				logger.debug("Execute Antes");
				cstmt.execute();
				logger.debug("Execute Despues");
				
				codError = cstmt.getInt(6);
				logger.debug("codError[" + codError + "]");
				msgError = cstmt.getString(7);
				logger.debug("msgError[" + msgError + "]");
				numEvento = cstmt.getInt(8);
				logger.debug("numEvento[" + numEvento + "]");		
				
				if (codError != 0) {
					logger.error(" Ocurrió un error al activar uno de los servicios");
					throw new CustomerOrderException(String.valueOf(codError),
							numEvento, msgError);
				}				
			}
			
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
			// Recuperacion de valores de salida

		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
			
		} catch (Exception e) {
			logger.error("Ocurrió un error general al activar uno de los servicios",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new CustomerOrderException(
					"Ocurrió un error general al activar uno de los servicios",
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
			logger.debug("setInstalledCustomerAccountProductBundle():end");
		}
	}
	
	/**
	 * Obtiene la lista de servicios suplementarios contratados
	 * @param cust
	 * @return
	 * @throws CustomerOrderException
	 */	
	public ProductListDTO getInstalledCustomerAccountProductBundleSLC(
			CustomerAccountDTO cust) throws CustomerOrderException {
		if (logger.isDebugEnabled()) {
			logger.debug("getInstalledCustomerAccountProductBundle():start");
		}

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ProductDTO[] productos = null;
		ProductListDTO productList = null;

		Connection conn = null;
		try {
			//conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			//conn = getConnectionDAO( config.getString("jndi.tol25.Customer.scl.dataSource") ); // MA
			conn = getConnectionDAO("jndi.tol25.Customer.scl.dataSource"); // MA
		} catch (Exception e1) {
			logger.error(" No se pudo obtener una conexión ", e1);
			throw new CustomerOrderException("No se pudo obtener una conexión",
					e1);
		}

		try {
			String call = getSQLgetInstalledCustomerAccountProductBundleSLC();

			if (logger.isDebugEnabled()) {
				logger.debug("sql[" + call + "]");
			}

			CallableStatement cstmt = conn.prepareCall(call);


			if (logger.isDebugEnabled()) {
				logger.debug("Registrando Entradas");
				logger.debug("Id de Cliente[" + cust.getCode() + "]");
			}
			cstmt.setLong(1, cust.getCode());

			if (logger.isDebugEnabled()) {
				logger.debug(" Registrando salidas");
			}
			cstmt.registerOutParameter(2, oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			logger.debug(" Iniciando Ejecución");

			cstmt.execute();

			logger.debug(" Finalizo ejecución");

			codError = cstmt.getInt(3);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(4);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(5);
			logger.debug("numEvento[" + numEvento + "]");

			if (codError != 0) {
				logger.error(" Ocurrió un error al recuperar los productos");

				throw new CustomerOrderException(String.valueOf(codError),
						numEvento, msgError);
			}

			logger.debug("Recuperando cursor...");
			ResultSet rs = (ResultSet) cstmt.getObject(2);
			ArrayList lista = new ArrayList();
			while (rs.next()) {
				ProductDTO prod = new ProductDTO();
				prod.setId(rs.getString(1));
				prod.setName(rs.getString(2));
				prod.setIdServSupl(rs.getLong(3));
				prod.setCodLevel(rs.getLong(4));
				prod.setIndicatorBagDiscount(rs.getString(5)+"");
				prod.setCodUpgradePhoneNumber(rs.getString(6));
				
				int modificable = rs.getInt(7);
				if (modificable == 0) {
					prod.setUpdate(false);
				} else {
					prod.setUpdate(true);
				}				
				prod.setPriority(rs.getString(8));
				prod.setExceedId(rs.getString(9));
				prod.setProfileId(rs.getString(10));
				prod.setCodPlan(rs.getString(11));
				

					logger.debug("Id[" + prod.getId() + "]");
					logger.debug("Name[" + prod.getName() + "]");
					logger.debug("idServSupl[" + prod.getIdServSupl() + "]");
					logger.debug("codLevel[" + prod.getCodLevel() + "]");
					logger.debug("getIndicatorBagDiscount[" + prod.getIndicatorBagDiscount() + "]");
					logger.debug("codUpgradePhone[" + prod.getCodUpgradePhoneNumber() + "]");
					logger.debug("Update[" + prod.isUpdate() + "]");
					logger.debug("Priority[" + prod.getPriority() + "]");
					logger.debug("ExceedId[" + prod.getExceedId() + "]");
					logger.debug("ProfileId[" + prod.getProfileId() + "]");
					logger.debug("CodPlan[" + prod.getCodPlan() + "]");				
				
				lista.add(prod);
			}

			productos = (ProductDTO[])ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), ProductDTO.class);
			productList = new ProductListDTO();
			productList.setProducts(productos);
			
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;			
			
		} catch (Exception e) {
			logger.error(
							"Ocurrió un error general al recuperar al recuperar los productos",
							e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new CustomerOrderException(
					"Ocurrió un error general al recuperar al recuperar los productos",
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
			logger.debug("getInstalledCustomerAccountProductBundle():end");
		}
		return productList;
	}
	
	
	
	/**
	 * Obtiene la lista de servicios suplementarios contratados
	 * @param cust
	 * @return
	 * @throws CustomerOrderException
	 */	
	public ProductListDTO getInstalledCustomerAccountProductBundle(
			CustomerAccountDTO cust) throws CustomerOrderException {
		if (logger.isDebugEnabled()) {
			logger.debug("getInstalledCustomerAccountProductBundle():start");
		}

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ProductDTO[] productos = null;
		ProductListDTO productList = null;

		Connection conn = null;
		try {
			//conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			//conn = getConnectionDAO( config.getString("jndi.tol25.Customer.scl.dataSource") ); // MA
			conn = getConnectionDAO("jndi.tol25.Customer.scl.dataSource"); // MA
		} catch (Exception e1) {
			logger.error(" No se pudo obtener una conexión ", e1);
			throw new CustomerOrderException("No se pudo obtener una conexión",
					e1);
		}

		try {
			String call = getSQLgetInstalledCustomerAccountProductBundle();

			if (logger.isDebugEnabled()) {
				logger.debug("sql[" + call + "]");
			}

			CallableStatement cstmt = conn.prepareCall(call);


			if (logger.isDebugEnabled()) {
				logger.debug("Registrando Entradas");
				logger.debug("Id de Cliente[" + cust.getCode() + "]");
			}
			cstmt.setLong(1, cust.getCode());

			if (logger.isDebugEnabled()) {
				logger.debug(" Registrando salidas");
			}
			cstmt
					.registerOutParameter(2,
							oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			if (logger.isDebugEnabled()) {
				logger.debug(" Iniciando Ejecución");
			}

			cstmt.execute();

			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
			// Recuperacion de valores de salida

			codError = cstmt.getInt(3);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(4);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(5);
			logger.debug("numEvento[" + numEvento + "]");

			if (codError != 0) {
				logger.
						error(" Ocurrió un error al recuperar los productos");

				throw new CustomerOrderException(String.valueOf(codError),
						numEvento, msgError);
			}

			logger.debug("Recuperando cursor...");
			ResultSet rs = (ResultSet) cstmt.getObject(2);
			ArrayList lista = new ArrayList();
			while (rs.next()) {
				ProductDTO prod = new ProductDTO();
				prod.setId(rs.getString(1));
				prod.setName(rs.getString(2));
				prod.setIdServSupl(rs.getLong(3));
				prod.setCodLevel(rs.getLong(4));
				prod.setIndicatorBagDiscount(rs.getString(5));
				prod.setCodUpgradePhoneNumber(rs.getString(6));
				
				int modificable = rs.getInt(7);
				if (modificable == 0) {
					prod.setUpdate(false);
				} else {
					prod.setUpdate(true);
				}				
				prod.setPriority(rs.getString(8));
				prod.setExceedId(rs.getString(9));
				prod.setProfileId(rs.getString(10));
				prod.setCodPlan(rs.getString(11));
				

					logger.debug("Id[" + prod.getId() + "]");
					logger.debug("Name[" + prod.getName() + "]");
					logger.debug("idServSupl[" + prod.getIdServSupl() + "]");
					logger.debug("codLevel[" + prod.getCodLevel() + "]");
					logger.debug("getIndicatorBagDiscount[" + prod.getIndicatorBagDiscount() + "]");
					logger.debug("codUpgradePhone[" + prod.getCodUpgradePhoneNumber() + "]");
					logger.debug("Update[" + prod.isUpdate() + "]");
					logger.debug("Priority[" + prod.getPriority() + "]");
					logger.debug("ExceedId[" + prod.getExceedId() + "]");
					logger.debug("ProfileId[" + prod.getProfileId() + "]");
					logger.debug("CodPlan[" + prod.getCodPlan() + "]");				
				
				lista.add(prod);
			}

			productos = (ProductDTO[])ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), ProductDTO.class);
			productList = new ProductListDTO();
			productList.setProducts(productos);
			
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;			
			
		} catch (Exception e) {
			logger.error("Ocurrió un error general al recuperar al recuperar los productos",
							e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new CustomerOrderException(
					"Ocurrió un error general al recuperar al recuperar los productos",
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
			logger.debug("getInstalledCustomerAccountProductBundle():end");
		}
		return productList;
	}

	/**
	 * Obtiene una lista de servicios no contratados
	 * @param cust
	 * @return
	 * @throws CustomerOrderException
	 */	
	public ProductListDTO getUnInstalledCustomerAccountProductBundle(
			CustomerAccountDTO cust) throws CustomerOrderException {
		if (logger.isDebugEnabled()) {
			logger.debug("getUnInstalledCustomerAccountProductBundle():start");
		}

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ProductDTO[] productos = null;
		ProductListDTO productList = null;

		Connection conn = null;
		try {
			
			//conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			conn = getConnectionDAO("jndi.tol25.Customer.scl.dataSource"); //MA
			//conn = getConnectionDAO(config.getString("jndi.tol25.Customer.scl.dataSource")); // MA
			
		} catch (Exception e1) {
			logger.error(" No se pudo obtener una conexión ", e1);
			throw new CustomerOrderException("No se pudo obtener una conexión",
					e1);
		}

		try {
			String call = getSQLgetUnInstalledCustomerAccountProductBundle();

			if (logger.isDebugEnabled()) {
				logger.debug("sql[" + call + "]");
			}

			CallableStatement cstmt = conn.prepareCall(call);


			if (logger.isDebugEnabled()) {
				logger.debug("Registrando Entradas");
				logger.debug("Id de Cliente[" + cust.getCode() + "]");
			}
			cstmt.setLong(1, cust.getCode());

			if (logger.isDebugEnabled()) {
				logger.debug(" Registrando salidas");
			}
			cstmt
					.registerOutParameter(2,
							oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			if (logger.isDebugEnabled()) {
				logger.debug(" Iniciando Ejecución");
			}

			cstmt.execute();

			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
			// Recuperacion de valores de salida

			codError = cstmt.getInt(3);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(4);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(5);
			logger.debug("numEvento[" + numEvento + "]");

			if (codError != 0) {
				logger.error(" Ocurrió un error al recuperar los productos");
				throw new CustomerOrderException(String.valueOf(codError),
						numEvento, msgError);
			}

			logger.debug("Recuperando cursor...");
			ResultSet rs = (ResultSet) cstmt.getObject(2);
			ArrayList lista = new ArrayList();
			while (rs.next()) {
				ProductDTO prod = new ProductDTO();
				prod.setId(rs.getString(1));
				prod.setName(rs.getString(2));
				prod.setIdServSupl(rs.getLong(3));
				prod.setCodLevel(rs.getLong(4));
				prod.setIndicatorBagDiscount(rs.getString(5));
				prod.setCodUpgradePhoneNumber(rs.getString(6));
				
				int modificable = rs.getInt(7);
				if (modificable == 0) {
					prod.setUpdate(false);
				} else {
					prod.setUpdate(true);
				}				
				prod.setPriority(rs.getString(8));
				prod.setExceedId(rs.getString(9));
				prod.setProfileId(rs.getString(10));
				prod.setCodPlan(rs.getString(11));
				
				if (logger.isDebugEnabled()) {
					logger.debug("Id[" + prod.getId() + "]");
					logger.debug("Name[" + prod.getName() + "]");
					logger.debug("idServSupl[" + prod.getIdServSupl() + "]");
					logger.debug("codLevel[" + prod.getCodLevel() + "]");
					logger.debug("getIndicatorBagDiscount[" + prod.getIndicatorBagDiscount()+ "]");
					logger.debug("codUpgradePhone[" + prod.getCodUpgradePhoneNumber() + "]");
					logger.debug("Update[" + prod.isUpdate() + "]");
					logger.debug("Priority[" + prod.getPriority() + "]");
					logger.debug("ExceedId[" + prod.getExceedId() + "]");
					logger.debug("ProfileId[" + prod.getProfileId() + "]");
					logger.debug("CodPlan[" + prod.getCodPlan() + "]");
				}				
				
				lista.add(prod);
			}

			productos = (ProductDTO[])ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), ProductDTO.class);
			productList = new ProductListDTO();
			productList.setProducts(productos);
			
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;			
			
		} catch (Exception e) {
			logger.error("Ocurrió un error general al recuperar al recuperar los productos",
							e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new CustomerOrderException(
					"Ocurrió un error general al recuperar al recuperar los productos",
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
			logger.debug("getUnInstalledCustomerAccountProductBundle():end");
		}
		return productList;
	}
	

	/**
	 * Obtiene los datos del cliente
	 * @param cust
	 * @return
	 * @throws CustomerOrderException
	 */	
	public CustomerAccountDTO getCustomerAccountData(CustomerAccountDTO cust) throws CustomerOrderException  {
		if (logger.isDebugEnabled()) {
			logger.debug("getCustomerAccountData():start");
		}

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		CustomerAccountDTO respuesta = null;

		Connection conn = null;
		try {
			//conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			//conn = getConnectionDAO( config.getString("jndi.tol25.Customer.scl.dataSource") ); // MA
			conn = getConnectionDAO("jndi.tol25.Customer.scl.dataSource"); //MA
		} catch (Exception e1) {
			logger.error(" No se pudo obtener una conexión ", e1);
			throw new CustomerOrderException("No se pudo obtener una conexión",
					e1);
		}

		try {
			String call = getSQLgetCustomerAccountData();

			if (logger.isDebugEnabled()) {
				logger.debug("sql[" + call + "]");
			}

			CallableStatement cstmt = conn.prepareCall(call);


			if (logger.isDebugEnabled()) {
				logger.debug("Registrando Entradas");
				logger.debug("Id de Cliente[" + cust.getCode() + "]");
			}
			cstmt.setLong(1, cust.getCode());

			if (logger.isDebugEnabled()) {
				logger.debug(" Registrando salidas");
			}
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);

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
				logger.error(" Ocurrió un error al recuperar los datos del cliente");
				throw new CustomerOrderException(String.valueOf(codError),
						numEvento, msgError);
			}

			logger.debug("Recuperando data...");

			String nomCliente  = cstmt.getString(5);
			logger.debug("nomCliente[" + nomCliente + "]");
			
			String codPlanTarifario  = cstmt.getString(6);
			logger.debug("codPlanTarifario[" + codPlanTarifario + "]");
			
			String planTarifario  = cstmt.getString(7);
			logger.debug("descripcion planTarifario[" + planTarifario + "]");	
			
			respuesta = new CustomerAccountDTO();
			respuesta.setNames(nomCliente);
			respuesta.setCodePlanRate(codPlanTarifario);			
			respuesta.setDesPlanRate(planTarifario);

		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;			
			
		} catch (Exception e) {
			logger.error("Ocurrió un error general al recuperar al recuperar los datos del cliente",
							e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new CustomerOrderException(
					"Ocurrió un error general al recuperar al recuperar los datos del cliente",
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
			logger.debug("getCustomerAccountData():end");
		}
		return respuesta;
		
	}

	/**
	 * Valida la seguridad dado un id de seguridad
	 * @param seg
	 * @return
	 * @throws CustomerOrderException
	 */	
	public SecurityDTO getSecurityData(SecurityDTO seg) throws CustomerOrderException{
		if (logger.isDebugEnabled()) {
			logger.debug("getSecurityData():start");
		}

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		SecurityDTO respuesta = null;

		Connection conn = null;
		try {
			//conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			//conn = getConnectionDAO( config.getString("jndi.tol25.Customer.scl.dataSource") ); // MA
			conn = getConnectionDAO("jndi.tol25.Customer.scl.dataSource"); // MA
		} catch (Exception e1) {
			logger.error(" No se pudo obtener una conexión ", e1);
			throw new CustomerOrderException("No se pudo obtener una conexión",
					e1);
		}

		try {
			String call = getSQLgetSecurityData();

			if (logger.isDebugEnabled()) {
				logger.debug("sql[" + call + "]");
			}

			CallableStatement cstmt = conn.prepareCall(call);


			if (logger.isDebugEnabled()) {
				logger.debug("Registrando Entradas");
				logger.debug("Id de seguridad[" + seg.getKey() + "]");
			}
			cstmt.setString(1, seg.getKey());

			if (logger.isDebugEnabled()) {
				logger.debug(" Registrando salidas");
			}
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);

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
				logger.error(" Ocurrió un error al recuperar los datos de seguridad");
				throw new CustomerOrderException(String.valueOf(codError),
						numEvento, msgError);
			}

			logger.debug("Recuperando data...");
			String resultado  = cstmt.getString(5);
			logger.debug("resultado[" + resultado + "]");
			
			if (resultado.equalsIgnoreCase("0")) {
				logger.
						error("No se encuentra el usuario logueado para el id de seguridad asociado");
				throw new CustomerOrderException(
						"No se encuentra el usuario logueado para el id de seguridad asociado");
			}			
			respuesta = new SecurityDTO();
			respuesta.setKey(resultado);
			respuesta.setUserName(seg.getUserName());
			
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;			
	
		} catch (Exception e) {
			logger.
					error(
							"Ocurrió un error general al recuperar al recuperar los datos de seguridad",
							e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new CustomerOrderException(
					"Ocurrió un error general al recuperar al recuperar los datos de seguridad",
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
			logger.debug("getSecurityData():end");
		}
		return respuesta;		
	}

	/**
	 * Guarda la lista de servicios contratados 
	 * @param prodList
	 * @throws CustomerOrderException
	 */
	public void setInstalledProductBundleList(
			ProductListDTO prodList) throws CustomerOrderException {
		if (logger.isDebugEnabled()) {
			logger.debug("setInstalledProductBundleList():start");
		}

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ProductDTO[] productos = null;

		Connection conn = null;
		try {
			//conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			//conn = getConnectionDAO( config.getString("jndi.tol25.Customer.scl.dataSource") ); // MA
			conn = getConnectionDAO("jndi.tol25.Customer.scl.dataSource"); // MA
		} catch (Exception e1) {
			logger.error(" No se pudo obtener una conexión ", e1);
			throw new CustomerOrderException("No se pudo obtener una conexión",
					e1);
		}

		try {
			String call = getSQLsetInstalledProductBundleList();

			if (logger.isDebugEnabled()) {
				logger.debug("sql[" + call + "]");
			}

			CallableStatement cstmt = conn.prepareCall(call);

			if (logger.isDebugEnabled()) {
				logger.debug("Registrando Entradas");
				logger.debug("Id de Cliente[" + prodList.getCustomer().getCode() + "]");
			}
			cstmt.setLong(1, prodList.getCustomer().getCode());

			if (logger.isDebugEnabled()) {
				logger.debug(" Registrando salidas");
			}
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);

			if (logger.isDebugEnabled()) {
				logger.debug(" Iniciando Ejecución");
			}
			
			productos = prodList.getProducts();
			
			logger.debug("Elementos[" + productos.length + "]");
			for (int i = 0; i < productos.length; i++) {
 
				logger.debug("Iteracion[" + i + "]");
				cstmt.setString(2, productos[i].getId());							
				cstmt.setLong(3, productos[i].getIdServSupl());
				cstmt.setLong(4, productos[i].getCodLevel());
				cstmt.setString(5, productos[i].getExceedId());
				cstmt.setString(6, productos[i].getPriority());				
				cstmt.setString(7, productos[i].getProfileId());												
				logger.debug("Execute Antes");
				cstmt.execute();
				logger.debug("Execute Despues");
				
				codError = cstmt.getInt(8);
				logger.debug("codError[" + codError + "]");
				msgError = cstmt.getString(9);
				logger.debug("msgError[" + msgError + "]");
				numEvento = cstmt.getInt(10);
				logger.debug("numEvento[" + numEvento + "]");		
				
				if (codError != 0) {
					logger.error(" Ocurrió un error al activar uno de los servicios");
					throw new CustomerOrderException(String.valueOf(codError),
							numEvento, msgError);
				}				
			}
			
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}

		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
			
		} catch (Exception e) {
			logger.error("Ocurrió un error general al recuperar al activar los servicios",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new CustomerOrderException(
					"Ocurrió un error general al actualizar al activar los servicios",
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
			logger.debug("setInstalledProductBundleList():end");
		}
	}

	/**
	 * Guarda la lista de servicios no contratados
	 * @param prodList
	 * @throws CustomerOrderException
	 */
	public void setUnInstallProductBundleList(
			ProductListDTO prodList) throws CustomerOrderException {
		if (logger.isDebugEnabled()) {
			logger.debug("setUnInstallProductBundleList():start");
		}

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ProductDTO[] productos = null;

		Connection conn = null;
		try {
			//conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			//conn = getConnectionDAO( config.getString("jndi.tol25.Customer.scl.dataSource") ); // MA
			conn = getConnectionDAO("jndi.tol25.Customer.scl.dataSource"); // MA
		} catch (Exception e1) {
			logger.error(" No se pudo obtener una conexión ", e1);
			throw new CustomerOrderException("No se pudo obtener una conexión",
					e1);
		}

		try {
			String call = getSQLsetUnInstallProductBundleList();

			if (logger.isDebugEnabled()) {
				logger.debug("sql[" + call + "]");
			}

			CallableStatement cstmt = conn.prepareCall(call);

			if (logger.isDebugEnabled()) {
				logger.debug("Registrando Entradas");
				logger.debug("Id de Cliente[" + prodList.getCustomer().getCode() + "]");
			}
			cstmt.setLong(1, prodList.getCustomer().getCode());

			if (logger.isDebugEnabled()) {
				logger.debug(" Registrando salidas");
			}
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			if (logger.isDebugEnabled()) {
				logger.debug(" Iniciando Ejecución");
			}
			
			productos = prodList.getProductsDisabled();
			
			logger.debug("Elementos[" + productos.length + "]");
			for (int i = 0; i < productos.length; i++) {
				String serviceId = productos[i].getId(); 
				logger.debug("Iteracion[" + i + "]");
				cstmt.setString(2, serviceId);
				logger.debug("Execute Antes");
				cstmt.execute();
				logger.debug("Execute Despues");
				
				codError = cstmt.getInt(3);
				logger.debug("codError[" + codError + "]");
				msgError = cstmt.getString(4);
				logger.debug("msgError[" + msgError + "]");
				numEvento = cstmt.getInt(5);
				logger.debug("numEvento[" + numEvento + "]");	
				
				if (codError != 0) {
					logger.error(" Ocurrió un error al desactivar uno de los servicios");
					throw new CustomerOrderException(String.valueOf(codError),
							numEvento, msgError);
				}				
			}
			
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}

		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
			
		} catch (Exception e) {
			logger.error("Ocurrió un error general al recuperar al desactivar los servicios",
							e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new CustomerOrderException(
					"Ocurrió un error general al actualizar al desactivar los servicios",
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
			logger.debug("setUnInstallProductBundleList():end");
		}
	}
	
	/*GTMSLV*/
	private String getSQLDatos(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
        for (int n = 1; n <= paramCount; n++) {
            sb.append("?");
            if (n < paramCount) sb.append(",");
        }
        return sb.append(")}").toString();
	}//fin getSQLDatos
	
	/**
	 * Obtiene planes Distribuidos
	 * @param cust
	 * @return
	 * @throws ProductDomainException
	 */
	public PlanTarifarioDTO[] obtenerPlanesDistribuidos(Long codigoCliente) 
	throws ProductDomainException
	{
		logger.debug("Inicio:obtenerPlanesDistribuidos()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;		
		Connection conn = null;
		CallableStatement cstmt =null;
		try {
			conn = getConnectionDAO("jndi.tol25.Customer.scl.dataSource"); //MA
		} catch (Exception e1) {
			logger.error(" No se pudo obtener una conexión ", e1);
			throw new ProductDomainException("No se pudo obtener una conexión",e1);
		}

		ResultSet rs = null;
		PlanTarifarioDTO[]  resultado = null;
		logger.debug("Conexion obtenida OK");
		
		try {

		   String call = getSQLDatos("GA_DISTRIBUCION_BOLSA_PG", "PV_OBTIENEPLAN_DIST_PR",5);
		   logger.debug("sql[" + call + "]");
		   
		   cstmt = conn.prepareCall(call);
		   
		   cstmt.setLong(1,codigoCliente.longValue());
		   logger.debug("codigoCliente:" + codigoCliente.longValue());	
		   	
		   cstmt.registerOutParameter(2,OracleTypes.CURSOR);		  		   
		   cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
		   cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);
		     
		   logger.debug("obtenerPlanesDistribuidos:Execute Antes");
		   cstmt.execute();		   
		   logger.debug("obtenerPlanesDistribuidos:Execute Despues");
		   
		   codError = cstmt.getInt(3);
		   msgError = cstmt.getString(4);
		   numEvento = cstmt.getInt(5);
		 
		   logger.debug("codError[" + codError + "]");
		   logger.debug("msgError[" + msgError + "]");
		   logger.debug("numEvento[" + numEvento + "]");
		   
		   if (codError!=0) 
		   {   		    
			    logger.error("Ocurrió un error al recuperar los planes distribuidos ");
			    throw new ProductDomainException("Ocurrió un error al recuperar los planes distribuidos ", 
			    		String.valueOf(codError), numEvento, msgError);
		    
			}else {
				logger.debug("Recuperando listado de estados");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(2);
				while (rs.next()) 
				{
					PlanTarifarioDTO plan = new PlanTarifarioDTO();
					plan.setCodigoPlanTarifario(rs.getString(1));
					plan.setDescripcionPlanTarifario(rs.getString(2));										
					lista.add(plan);
				}				
				resultado =(PlanTarifarioDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), PlanTarifarioDTO.class);
		  
				logger.debug("Fin recuperacion listado de planes distribuidos");
			}
		   
		   if (logger.isDebugEnabled())
		    logger.debug(" Finalizo ejecución");
		  } 
		  catch (Exception e) {
			   logger.error("Ocurrió un error al recuperar listado de planes distribuidos",e);
			   if (logger.isDebugEnabled()) {
			    logger.debug("Codigo de Error[" + codError + "]");
			    logger.debug("Mensaje de Error[" + msgError + "]");
			    logger.debug("Numero de Evento[" + numEvento + "]");
			   }
			   if (e instanceof ProductDomainException){
				  throw (ProductDomainException) e;
			   }
		  } 
		  finally {
		    if (logger.isDebugEnabled()) 
		    logger.debug("Cerrando conexiones...");
			   try {
				   if (cstmt != null) {
						cstmt.close();
				   }
				   if (!conn.isClosed()) {
				     conn.close();
				   }
			   } catch (SQLException e) {
			    logger.debug("SQLException", e);
			   }
		  }
		  logger.debug("obtenerPlanesDistribuidos():end");	
		  return resultado;
	}//fin obtenerPlanesDistribuidos

	public DistribucionBolsaDTO obtenerDatosBolsa(String codPlanTarif) 
	throws ProductDomainException
	{
		logger.debug("Inicio:obtenerDatosBolsa()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		DistribucionBolsaDTO resultado = new DistribucionBolsaDTO();
		Connection conn = null;
		CallableStatement cstmt =null;
		try {
			conn = getConnectionDAO("jndi.tol25.Customer.scl.dataSource"); //MA
		} catch (Exception e1) {
			logger.error(" No se pudo obtener una conexión ", e1);
			throw new ProductDomainException("No se pudo obtener una conexión",e1);
		}
		logger.debug("Conexion obtenida OK");
		
		try {
			
		   String call = getSQLDatos("GA_Distribucion_Bolsa_Pg", "VE_obtiene_datos_Bolsa_PR",9);
		   logger.debug("sql[" + call + "]");
		   
		   cstmt = conn.prepareCall(call);
		   
		   logger.debug("codPlanTarif:" + codPlanTarif);
		   cstmt.setString(1,codPlanTarif);
		   
		   cstmt.registerOutParameter(2,java.sql.Types.VARCHAR); //des_plantarif
		   cstmt.registerOutParameter(3,java.sql.Types.VARCHAR); //cod_bolsa
		   cstmt.registerOutParameter(4,java.sql.Types.VARCHAR); //glosa_parametro
		   cstmt.registerOutParameter(5,java.sql.Types.NUMERIC); //cantidad_bolsa
		   cstmt.registerOutParameter(6,java.sql.Types.VARCHAR); //tipo_unidad
		   
		   cstmt.registerOutParameter(7,java.sql.Types.NUMERIC);
		   cstmt.registerOutParameter(8,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(9,java.sql.Types.NUMERIC);
		   
		   logger.debug("obtenerDatosBolsa:Execute Antes"); 		   
		   cstmt.execute();		  
		   logger.debug("obtenerDatosBolsa:Execute Despues");
		   
		   codError = cstmt.getInt(7);
		   msgError = cstmt.getString(8);
		   numEvento = cstmt.getInt(9);
		 
		   logger.debug("codError[" + codError + "]");
		   logger.debug("msgError[" + msgError + "]");
		   logger.debug("numEvento[" + numEvento + "]");
		   
		   if (codError!=0) 
		   {   		    
			    logger.error("Ocurrió un error al recuperar la distribuicion de bolsa ");
			    throw new ProductDomainException("Ocurrió un error al recuperar la distribucion de bolsa", 
			    		String.valueOf(codError), numEvento, msgError);
		    
			}else{
				resultado.setDes_planTarif(cstmt.getString(2));
				logger.debug("desPlanTarif:" + resultado.getDes_planTarif());
				resultado.setCod_bolsa(cstmt.getString(3));
				logger.debug("codBolsa:" + resultado.getCod_bolsa());
				resultado.setGlosa_Parametro(cstmt.getString(4));
				logger.debug("glosaParametro:" + resultado.getGlosa_Parametro());
				resultado.setCantidad_bolsa(cstmt.getLong(5));
				logger.debug("cantidadBolsa:" + resultado.getCantidad_bolsa());
				resultado.setInd_unidad(cstmt.getString(6));
				logger.debug("indUnidad:" + resultado.getInd_unidad());				
			}
		   
		   if (logger.isDebugEnabled())
		    logger.debug(" Finalizo ejecución");
		  } 
		  catch (Exception e) {
			   logger.error("Ocurrió un error al obtener la distribucion de bolsa",e);
			   if (logger.isDebugEnabled()) {
			    logger.debug("Codigo de Error[" + codError + "]");
			    logger.debug("Mensaje de Error[" + msgError + "]");
			    logger.debug("Numero de Evento[" + numEvento + "]");
			   }
			   if (e instanceof ProductDomainException){
				  throw (ProductDomainException) e;
			   }
		  } 
		  finally {
		    if (logger.isDebugEnabled()) 
		    logger.debug("Cerrando conexiones...");
			   try {				   
				   if (cstmt != null) {
						cstmt.close();
				   }
				   if (!conn.isClosed()) {
				     conn.close();
				   }
			   } catch (SQLException e) {
			    logger.debug("SQLException", e);
			   }
		  }
		  logger.debug("obtenerDatosBolsa():end");
		return resultado;
	}//fin obtenerDatosBolsa
	
}
