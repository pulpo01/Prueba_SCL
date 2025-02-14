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
 * 07/09/2006     Jimmy Lopez              					Versión Inicial
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
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.AbonadoDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.CustomerAccountDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ProductDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ProductListDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.exception.CustomerOrderException;

public class InvolvementProductBundleDAO extends ConnectionDAO {
	//private static Category cat = Category.getInstance(InvolvementProductBundleDAO.class);

	//Global global = Global.getInstance();
	
	//private static Logger logger = Logger.getLogger(CustomerAccountDAO.class);
	private static Category logger = Category.getInstance(InvolvementProductBundleDAO.class);
	private CompositeConfiguration config;
	
	public InvolvementProductBundleDAO() {
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
	

	private String getSQLgetInvolvementProductBundleData() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call
				.append("   SO_SERVSUPL PV_Servsupl_QT:= pv_inicia_estructuras_sb_PG.pv_inicia_servsupl_fn;");
		call.append("   SN_COD_RETORNO NUMBER;");
		call.append("   SV_MENS_RETORNO VARCHAR2(200);");
		call.append("   SN_NUM_EVENTO NUMBER;");
		call.append(" BEGIN ");
		call.append("   SO_SERVSUPL.num_abonado := ?;");
		call.append("   SN_COD_RETORNO := NULL;");
		call.append("   SV_MENS_RETORNO := NULL;");
		call.append("   SN_NUM_EVENTO := NULL;");
		call
				.append("   PV_DATOSABO_SB_PG.PV_OBTIENE_DATOS_ABO_PR ( SO_SERVSUPL, ?, ?, ?);");
		call.append("		? := so_SERVSUPL.COD_CLIENTE;");
		call.append("		? := so_SERVSUPL.NOM_CLIENTE;");
		call.append("		? := so_SERVSUPL.num_celular;");
		call.append("		? := so_SERVSUPL.cod_plantarif;");
		call.append("		? := so_SERVSUPL.DES_PLANTARIF;");
		call.append(" END;");
		return call.toString();
	}

	private String getSQLgetInstalledInvolvementProductBundle() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call
				.append("   SO_SERVSUPL pv_servsupl_qt:= PV_inicia_estructuras_sb_PG.PV_INICIA_SERVSUPL_FN;");
		call.append("   SN_COD_RETORNO NUMBER;");
		call.append("   SV_MENS_RETORNO VARCHAR2(200);");
		call.append("   SN_NUM_EVENTO NUMBER;");
		call.append(" BEGIN ");
		call.append("   SO_SERVSUPL.num_abonado := ?;");
		call.append("   SN_COD_RETORNO := NULL;");
		call.append("   SV_MENS_RETORNO := NULL;");
		call.append("   SN_NUM_EVENTO := NULL;");

		call
				.append("   PV_SERVSUPL_SB_PG.PV_OBTIENE_SS_abonado_PR ( SO_SERVSUPL, ?, ?, ?, ?);");
		call.append(" END;");
		return call.toString();

	}
	
	private String getSQLsetInvolvementProductBundleAttributes() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call
				.append("   SO_SERVSUPL PV_SERVSUPL_QT := PV_inicia_estructuras_sb_PG.PV_INICIA_SERVSUPL_FN;");
		call.append("   SN_COD_RETORNO NUMBER;");
		call.append("   SV_MENS_RETORNO VARCHAR2(200);");
		call.append("   SN_NUM_EVENTO NUMBER;");
		call.append(" BEGIN ");
		call.append("   SO_SERVSUPL.num_abonado := ?;");
		call.append("   SO_SERVSUPL.COD_SERVICIO := ?;");
		call.append("   SO_SERVSUPL.IND_DESBORDE := ?;");
		call.append("   SO_SERVSUPL.IND_PRIORIDAD := ?;");
		call.append("   SO_SERVSUPL.PERFIL_LC := ?;");
		call.append("   SN_COD_RETORNO := NULL;");
		call.append("   SV_MENS_RETORNO := NULL;");
		call.append("   SN_NUM_EVENTO := NULL;");
		call
				.append("   PV_SERVSUPL_SB_PG.pv_actualiza_serv_abo_pr( SO_SERVSUPL, ?, ?, ?);");
		call.append(" END;");
		return call.toString();		
	}	

	/**
	 * Recupera los datos del abonado por numero de abonado asi como la
	 * informacion del cliente
	 * 
	 * @param abo
	 * @return
	 * @throws CustomerOrderException
	 */
	public CustomerAccountDTO getInvolvementProductBundletData(AbonadoDTO abo)
			throws CustomerOrderException {
		if (logger.isDebugEnabled()) {
			logger.debug("getInvolvementProductBundletData():start");
		}

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		CustomerAccountDTO respuesta = null;

		Connection conn = null;
		try {
			//conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			conn = getConnectionDAO("jndi.tol25.Customer.scl.dataSource"); //MA
			
		} catch (Exception e1) {
			logger.error(" No se pudo obtener una conexión ", e1);
			throw new CustomerOrderException("No se pudo obtener una conexión",
					e1);
		}

		try {
			String call = getSQLgetInvolvementProductBundleData();

			if (logger.isDebugEnabled()) {
				logger.debug("sql[" + call + "]");
			}

			CallableStatement cstmt = conn.prepareCall(call);

			if (logger.isDebugEnabled()) {
				logger.debug("Registrando Entradas");
				logger.debug("numero Abonado[" + abo.getNum_abonado() + "]");
			}
			cstmt.setLong(1, abo.getNum_abonado());

			if (logger.isDebugEnabled()) {
				logger.debug(" Registrando salidas");
			}
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);

			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);

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
				logger.error(" Ocurrió un error al recuperar los datos del abonado");
				throw new CustomerOrderException(String.valueOf(codError),
						numEvento, msgError);
			}

			logger.debug("Recuperando data...");

			long codCliente = cstmt.getLong(5);
			logger.debug("codCliente[" + codCliente + "]");

			String nomCliente = cstmt.getString(6);
			logger.debug("nomCliente[" + nomCliente + "]");

			long numCelularCliente = cstmt.getLong(7);
			logger.debug("numCelularCliente[" + numCelularCliente + "]");

			String codPlanTarifario = cstmt.getString(8);
			logger.debug("codPlanTarifario[" + codPlanTarifario + "]");

			String planTarifario = cstmt.getString(9);
			logger.debug("descripcion planTarifario[" + planTarifario + "]");

			respuesta = new CustomerAccountDTO();
			respuesta.setCode(codCliente);
			respuesta.setNames(nomCliente);
			respuesta.setCodePlanRate(codPlanTarifario);
			respuesta.setDesPlanRate(planTarifario);

			AbonadoDTO abonado = new AbonadoDTO();
			abonado.setNum_abonado(abo.getNum_abonado());
			abonado.setNum_celular(numCelularCliente);

			respuesta.setAbonado(abonado);

		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;

		} catch (Exception e) {
			logger.error(
							"Ocurrió un error general al recuperar al recuperar los datos del abonado",
							e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new CustomerOrderException(
					"Ocurrió un error general al recuperar al recuperar los datos del abonado",
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
			logger.debug("getInvolvementProductBundletData():end");
		}
		return respuesta;
	}

	/**
	 * Obtiene la lista de servicios suplementarios contratados por abonado
	 * 
	 * @param abo
	 * @return
	 * @throws CustomerOrderException
	 */
	public ProductListDTO getInstalledInvolvementProductBundle(AbonadoDTO abo)
			throws CustomerOrderException {
		if (logger.isDebugEnabled()) {
			logger.debug("getInstalledInvolvementProductBundle():start");
		}

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ProductDTO[] productos = null;
		ProductListDTO productList = null;

		Connection conn = null;
		try {
			//conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			//conn = getConnectionDAO(config.getString("jndi.tol25.Customer.scl.dataSource")); //MA
			conn = getConnectionDAO("jndi.tol25.Customer.scl.dataSource"); //MA
		} catch (Exception e1) {
			logger.error(" No se pudo obtener una conexión ", e1);
			throw new CustomerOrderException("No se pudo obtener una conexión",
					e1);
		}

		try {
			String call = getSQLgetInstalledInvolvementProductBundle();

			if (logger.isDebugEnabled()) {
				logger.debug("sql[" + call + "]");
			}

			CallableStatement cstmt = conn.prepareCall(call);

			if (logger.isDebugEnabled()) {
				logger.debug("Registrando Entradas");
				logger.debug("Numero abonado[" + abo.getNum_abonado() + "]");
			}
			cstmt.setLong(1, abo.getNum_abonado());

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
					logger.debug("indicatorBagDiscount["
							+ prod.getIndicatorBagDiscount() + "]");
					logger.debug("codUpgradePhone["
							+ prod.getCodUpgradePhoneNumber() + "]");
					logger.debug("Update[" + prod.isUpdate() + "]");
					logger.debug("Priority[" + prod.getPriority() + "]");
					logger.debug("ExceedId[" + prod.getExceedId() + "]");
					logger.debug("ProfileId[" + prod.getProfileId() + "]");
					logger.debug("CodPlan[" + prod.getCodPlan() + "]");
				}

				lista.add(prod);
			}

			productos = (ProductDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), ProductDTO.class);
			productList = new ProductListDTO();
			productList.setProducts(productos);

		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;

		} catch (Exception e) {
			logger.error(
							"Ocurrió un error general al recuperar al recuperar los productos por abonado",
							e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new CustomerOrderException(
					"Ocurrió un error general al recuperar al recuperar los productos por abonado",
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
			logger.debug("getInstalledInvolvementProductBundle():end");
		}
		return productList;
	}
	
	
	/**
	 * Actualiza los servicios suplementarios por abonado
	 * @param prodList
	 * @throws CustomerOrderException
	 */
	public void setInvolvementProductBundleAttributes(
			ProductListDTO prodList) throws CustomerOrderException {
		if (logger.isDebugEnabled()) {
			logger.debug("setInvolvementProductBundleAttributes():start");
		}

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ProductDTO[] productos = null;

		Connection conn = null;
		try {
			//conn = getConnectionFromWLSInitialContext(global 				.getJndiForDataSource());
			//conn = getConnectionDAO(config.getString("jndi.tol25.Customer.scl.dataSource")); //MA
			conn = getConnectionDAO("jndi.tol25.Customer.scl.dataSource"); //MA
		} catch (Exception e1) {
			logger.error(" No se pudo obtener una conexión ", e1);
			throw new CustomerOrderException("No se pudo obtener una conexión",
					e1);
		}

		try {
			String call = getSQLsetInvolvementProductBundleAttributes();

			if (logger.isDebugEnabled()) {
				logger.debug("sql[" + call + "]");
			}

			CallableStatement cstmt = conn.prepareCall(call);

			if (logger.isDebugEnabled()) {
				logger.debug("Registrando Entradas");
				logger.debug("numero abonado[" + prodList.getCustomer().getAbonado().getNum_abonado() + "]");
			}
			cstmt.setLong(1, prodList.getCustomer().getAbonado().getNum_abonado());

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
					logger.error(" Ocurrió un error al activar uno de los servicios por abonado");
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
			logger.error("Ocurrió un error general al activar uno de los servicios por abonado",
							e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new CustomerOrderException(
					"Ocurrió un error general al activar uno de los servicios por abonado",
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
			logger.debug("setInvolvementProductBundleAttributes():end");
		}
	}


}
