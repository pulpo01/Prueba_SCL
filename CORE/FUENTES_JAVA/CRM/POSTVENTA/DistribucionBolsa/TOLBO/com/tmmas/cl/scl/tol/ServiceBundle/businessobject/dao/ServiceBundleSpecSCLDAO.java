package com.tmmas.cl.scl.tol.ServiceBundle.businessobject.dao;


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

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.BolsaAbonadoDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.CustomerAccountDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.DistribucionBolsaDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.LimiteClienteDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.LimiteConsumoDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ProductDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ProductListDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.exception.TOLException;
import com.tmmas.cl.scl.tol.ServiceBundle.businessobject.helper.Global;

public class ServiceBundleSpecSCLDAO extends ConnectionDAO {
	private static Category cat = Category.getInstance(ServiceBundleSpecSCLDAO.class);

	//Global global = Global.getInstance();
	
// INICIO MA 69363 RRG 04-11-2008
	
	private CompositeConfiguration config;

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
	
	
	
	public ServiceBundleSpecSCLDAO()
	{
		setPropFile();
		cat.info("ServiceBundleSpecSCLDAO Constructor");
	}
	
	private String getSQLcreateLimitProfileService() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   EO_sbas_ss TOL_LIM_CLIABO_TO_QT := TOL_SCL_INI_ESTRUCTURAS_SB_PG.TOL_inicia_LIM_CLIABO_QT_FN;");
		call.append(" BEGIN ");
        call.append("   EO_sbas_ss.cod_cliente := ?;");
        call.append("   EO_sbas_ss.num_abonado := ?;");
        call.append("   EO_sbas_ss.cod_limcons := ?;");
        call.append("   EO_sbas_ss.cod_plantarif := ?;");
		call.append("   EO_sbas_ss.aciclo := ?;");        
		call.append("   TOL_SCL_LC_SB_PG.TOL_CREA_LC_PR( EO_sbas_ss, ?, ?, ?);");
		call.append(" END;");
		return call.toString();		
		
	}	
	
	private String getSQLgetListProfile() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   SO_tol_limite_td tol_limite_td_qt:= TOL_SCL_INI_ESTRUCTURAS_SB_PG.TOL_inicia_tol_limitetd_FN;");
		call.append("   SN_COD_RETORNO NUMBER;");
		call.append("   SV_MENS_RETORNO VARCHAR2(200);");
		call.append("   SN_NUM_EVENTO NUMBER;");
		call.append(" BEGIN ");
		call.append("   SO_tol_limite_td.cod_plantarif  := ?;");
		call.append("   SN_COD_RETORNO := NULL;");
		call.append("   SV_MENS_RETORNO := NULL;");
		call.append("   SN_NUM_EVENTO := NULL;");
		call.append("   TOL_SCL_LC_SB_PG.tol_perfil_lc_ss_pr( SO_tol_limite_td, ?, ?, ?, ?);");
		call.append(" END;");
		return call.toString();
	}	
	
	
	private String getSQLdeleteLimitProfileService() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   EO_elimlimite tol_lim_cliabo_to_qt := TOL_SCL_INI_ESTRUCTURAS_SB_PG.TOL_inicia_LIM_CLIABO_QT_FN;");
		call.append("   SN_COD_RETORNO NUMBER;");
		call.append("   SV_MENS_RETORNO VARCHAR2(200);");
		call.append("   SN_NUM_EVENTO NUMBER;");
		call.append(" BEGIN ");
		call.append("   EO_elimlimite.COD_CLIENTE := ?;");
		call.append("   EO_elimlimite.num_abonado  := ?;");
		call.append("   EO_elimlimite.cod_plantarif  := ?;");
		call.append("   EO_elimlimite.cod_limcons := ?;");		
		call.append("   EO_elimlimite.aciclo := ?;");
		call.append("   SN_COD_RETORNO := NULL;");
		call.append("   SV_MENS_RETORNO := NULL;");
		call.append("   SN_NUM_EVENTO := NULL;");
		call.append("   TOL_SCL_LC_SB_PG.TOL_ELIMINA_LC_PR( EO_elimlimite, ?, ?, ?);");
		call.append(" END;");
		return call.toString();		
	}	
		
	
	private String getSQLgetFreeUnitBagId() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   EO_bolsa tol_bolsa_qt := tol_scl_ini_estructuras_sb_pg.tol_inicia_bolsa_fn;");
		call.append(" BEGIN ");
        call.append("   EO_bolsa.cod_plan := ?;");
		call.append("   tol_scl_bolsa_sb_pg.tol_obtiene_bolsa_cliente_pg( EO_bolsa, ?, ?, ?);");
		call.append("	? := EO_bolsa.cod_bolsa;");
		call.append("	? := EO_bolsa.ind_unidad;");		
		call.append("	? := EO_bolsa.cnt_bolsa;");				
		call.append(" END;");
		return call.toString();		
	
	}	
	
	
	private String getSQLgetDefaultServiceLimitProfile() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   so_obtcodlc tol_lim_cliabo_to_qt := TOL_SCL_INI_estructuras_SB_PG.TOL_inicia_LIM_CLIABO_QT_FN;");
		call.append(" BEGIN ");
        call.append("   SO_obtcodlc.cod_plantarif := ?;");
		call.append("   TOL_SCL_LC_SB_PG.tol_obtiene_codigo_lc_ss_pr( so_obtcodlc, ?, ?, ?);");
		call.append("	? := so_obtcodlc.cod_limcons;");
		call.append(" END;");
		return call.toString();		
		
	}	
	
	public void createLimitProfileService(ProductListDTO prodList) throws TOLException
	{
		cat.info("createLimitProfilesService:star");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ProductDTO[] productos = null;

		Connection conn = null;
		try {
			//conn = getConnectionFromWLSInitialContext(global.getJndiSCLForDataSource());
			conn = getConnectionDAO("jndi.tol25.tol.scl.dataSource");
		} catch (Exception e1) {
			cat.error(" No se pudo obtener una conexión ", e1);
			throw new TOLException("No se pudo obtener una conexión", e1);
		}

		try {
			String call = getSQLcreateLimitProfileService();

			cat.debug("sql[" + call + "]");

			CallableStatement cstmt = conn.prepareCall(call);

			cat.debug("Registrando Entradas");
			cat.debug("Id de Cliente[" + prodList.getCustomer().getCode() + "]");
			cat.debug("num_abonado[" + prodList.getCustomer().getAbonado().getNum_abonado() + "]");
			
			cstmt.setLong(1, prodList.getCustomer().getCode());
			cstmt.setLong( 2, prodList.getCustomer().getAbonado().getNum_abonado());				//num_abonado'

			cat.debug(" Registrando salidas");
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);

			cat.debug(" Iniciando Ejecución");
			
			productos = prodList.getProducts();
			
			cat.debug("Elementos[" + productos.length + "]");
			for (int i = 0; i < productos.length; i++) {
				cat.debug("Iteracion[" + i + "]");
				cat.debug("cod_limcons[" + productos[i].getProfileId() + "]");
				cat.debug("cod_plantarif[" + productos[i].getCodPlan() + "]");
				cat.debug("isAciclo[" + iif(prodList.isAciclo()) + "]");

				if(productos[i].getProfileId() == null || productos[i].getProfileId().trim().equals(""))
				{
					cat.debug("No se invocará el procedimiento, ya que no existe limite de consumo asociado");
				}else{
					cat.debug("productos[i].getProfileId() != null");
					
					cat.debug("cod_limcons[" + productos[i].getProfileId() + "]");
					cat.debug("cod_plantarif[" + productos[i].getCodPlan() + "]");
					cat.debug("isAciclo[" + iif(prodList.isAciclo()) + "]");
					
					
					cstmt.setString( 3, productos[i].getProfileId());		//cod_limcons
					cstmt.setString( 4, productos[i].getCodPlan());			//cod_plantarif
					cstmt.setInt(5, iif(prodList.isAciclo()));
	
					
					cat.debug("Execute Antes");
					cstmt.execute();
					cat.debug("Execute Despues");
					
					codError = cstmt.getInt(6);
					cat.debug("codError[" + codError + "]");
					msgError = cstmt.getString(7);
					cat.debug("msgError[" + msgError + "]");
					numEvento = cstmt.getInt(8);
					cat.debug("numEvento[" + numEvento + "]");		
					
					if (codError != 0) {
						cat.error(" Ocurrió un error al activar uno de los servicios");
						throw new TOLException("Ocurrió un error al activar los servicios [createLimitProfileService]", String.valueOf(codError), numEvento, msgError);
					}		
				}
			}
			
			cat.debug(" Finalizo ejecución");
			cat.debug(" Recuperando salidas");
			
		} catch (Exception e) {
			cat.error("Ocurrió un error general al recuperar al activar los servicios",	e);
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error: " + msgError + "]");
			cat.debug("Numero de Evento: " + numEvento + "]");

			throw new TOLException("Ocurrió un error general al actualizar al activar los servicios [createLimitProfileService]", e);
		} finally {
			cat.debug("Cerrando conexiones...");
			try {
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (Exception e) {
				cat.debug("Exception", e);
			}
		}

		if (codError != 0) {
			cat.info("stop with errors:" +codError + "(" + msgError + ")");
			throw new TOLException("Ocurrió un error general al actualizar al activar los servicios [createLimitProfileService]", String.valueOf(codError),numEvento, msgError);
		}
		
		cat.info("createLimitProfilesService:end");
	}
	
	private int iif(boolean b)
	{
		int ret = 0;	//inmediato
		if(b)
			ret = 1;	//aciclo
		return ret;
	}
	
	public void setLimitProfileService(ProductListDTO prodList) throws TOLException
	{
		cat.info("setLimitProfilesService:star");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ProductDTO[] productos = null;

		Connection conn = null;
		try {
			//conn = getConnectionFromWLSInitialContext(global.getJndiSCLForDataSource());
			conn = getConnectionDAO("jndi.tol25.tol.scl.dataSource");
		} catch (Exception e1) {
			cat.error(" No se pudo obtener una conexión ", e1);
			throw new TOLException("No se pudo obtener una conexión", e1);
		}

		try {
			String call = getSQLdeleteLimitProfileService();

			cat.debug("sql[" + call + "]");

			CallableStatement cstmt = conn.prepareCall(call);

			cat.debug("Registrando Entradas");
			cat.debug("Id de Cliente[" + prodList.getCustomer().getCode() + "]");
			cstmt.setLong(1, prodList.getCustomer().getCode());
			cstmt.setInt(2, 0);
			cstmt.setInt(5, iif(prodList.isAciclo()));

			cat.debug(" Registrando salidas");
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);

			cat.debug(" Iniciando Ejecución");
			
			productos = prodList.getProducts();
			
			cat.debug("Elementos[" + productos.length + "]");
			for (int i = 0; i < productos.length; i++) {
				cat.debug("Iteracion[" + i + "]");
				cat.debug("Id de Cliente[" + prodList.getCustomer().getCode() + "]");	
				cat.debug("EO_sbas_ss.num_abonado[0]");
				cat.debug("EO_sbas_ss.lim_cons[" + productos[i].getProfileId() + "]");
				cat.debug("EO_sbas_ss.cod_plantarif[" + productos[i].getCodPlan() + "]");
				
				cstmt.setString( 3, productos[i].getProfileId());				//EO_sbas_ss.lim_cons
				cstmt.setString( 4, productos[i].getCodPlan());				//EO_sbas_ss.lim_cons
			
				cat.debug("Execute Antes");
				cstmt.execute();
				cat.debug("Execute Despues");
				
				codError = cstmt.getInt(6);
				cat.debug("codError[" + codError + "]");
				msgError = cstmt.getString(7);
				cat.debug("msgError[" + msgError + "]");
				numEvento = cstmt.getInt(8);
				cat.debug("numEvento[" + numEvento + "]");		
				
				if (codError != 0) {
					cat.error("Ocurrió un error al actualizar los limites de consumo de un cliente");
					throw new TOLException("Ocurrió un error al actualizar los limites de consumo de un cliente [setLimitProfileService]", String.valueOf(codError), numEvento, msgError);
				}				
			}
			
			cat.debug(" Finalizo ejecución");
			cat.debug(" Recuperando salidas");
			
		} catch (Exception e) {
			cat.error("Ocurrió un error general al recuperar al actualizar los limites de consumo de un cliente",	e);
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error: " + msgError + "]");
			cat.debug("Numero de Evento: " + numEvento + "]");

			throw new TOLException("Ocurrió un error general al actualizar los limites de consumo de un cliente [setLimitProfileService]", e);
		} finally {
			cat.debug("Cerrando conexiones...");
			try {
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException[" + e + "]");
			}
		}

		if (codError != 0) {
			cat.info("stop with errors");
			throw new TOLException("Ocurrió un error general al actualizar los limites de consumo de un cliente [setLimitProfileService]", String.valueOf(codError),numEvento, msgError);
		}
		
		cat.info("setLimitProfilesService:end");
	}
	
	/**
	 * Obtiene la lista de perfiles dado un servicio suplementario
	 * @param prod
	 * @return
	 * @throws CustomerOrderException
	 */	
	public LimiteConsumoDTO[] getServiceLimitProfiles(
			ProductDTO prod) throws TOLException {
		if (cat.isDebugEnabled()) {
			cat.debug("getServiceLimitProfiles():start");
		}

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		LimiteConsumoDTO[] profiles = null;

		Connection conn = null;
		try {
			//conn = getConnectionFromWLSInitialContext(global.getJndiSCLForDataSource());
			conn = getConnectionDAO("jndi.tol25.tol.scl.dataSource");
		} catch (Exception e1) {
			cat.error("No se pudo obtener una conexión ", e1);
			throw new TOLException("No se pudo obtener una conexión", e1);
		}

		try {
			String call = getSQLgetListProfile();

			cat.debug("sql[" + call + "]");

			CallableStatement cstmt = conn.prepareCall(call);

			if (cat.isDebugEnabled()) {
				cat.debug("Registrando Entradas");
				cat.debug("Codigo de Plan tarifario[" + prod.getCodPlan() + "]");
			}
			
			cstmt.setString(1, prod.getCodPlan());

			cat.debug("Registrando salidas");
			cstmt.registerOutParameter(2, oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cat.debug("Iniciando Ejecución");


			cstmt.execute();

			if (cat.isDebugEnabled()) {
				cat.debug("Finalizo ejecución");
				cat.debug("Recuperando salidas");
			}
			// Recuperacion de valores de salida

			codError = cstmt.getInt(3);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(4);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(5);
			cat.debug("numEvento[" + numEvento + "]");

			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar los limites de consumo [getServiceLimitProfiles]");
				throw new TOLException("Ocurrió un error al recuperar los limites de consumo [getServiceLimitProfiles]", String.valueOf(codError), numEvento, msgError);
			}

			cat.debug("Recuperando cursor...");
			ResultSet rs = (ResultSet) cstmt.getObject(2);
			ArrayList lista = new ArrayList();
			while (rs.next()) {
				LimiteConsumoDTO prty = new LimiteConsumoDTO();
				prty.setProfileId(rs.getString(1));
				prty.setDescProfileId(rs.getString(2));
				if (cat.isDebugEnabled()) {
					cat.debug("ProfileId[" + prty.getProfileId() + "]");
					cat.debug("DescProfile[" + prty.getDescProfileId() + "]");
				}
				lista.add(prty);
			}

			profiles = (LimiteConsumoDTO[])ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), LimiteConsumoDTO.class);
			
		} catch (TOLException e) {
			cat.debug("TOLException", e);
			throw e;			
		} catch (Exception e) {
			if (cat.isDebugEnabled()) {
				cat.error("Ocurrió un error general al recuperar los limites de consumo", e);
				
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new TOLException("Ocurrió un error al recuperar los limites de consumo [getServiceLimitProfiles]", e);
		} finally {
			if (cat.isDebugEnabled()) {
				cat.debug("Cerrando conexiones...");
			}
			try {
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				cat.debug("SQLException", e);
			}
		}

		cat.debug("getServiceLimitProfiles():end");
		return profiles;
	}	
	
	/**
	 * Elimina los limites de consumo en tol
	 * @param prodList
	 * @throws TOLException
	 */
	public void deleteLimitProfileService(ProductListDTO prodList) throws TOLException{
		if (cat.isDebugEnabled()) {
			cat.debug("deleteLimitProfileService():start");
		}

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ProductDTO[] productos = null;

		Connection conn = null;
		try {
			//conn = getConnectionFromWLSInitialContext(global.getJndiSCLForDataSource());
			conn = getConnectionDAO("jndi.tol25.tol.scl.dataSource");
		} catch (Exception e1) {
			cat.error(" No se pudo obtener una conexión ", e1);
			throw new TOLException("No se pudo obtener una conexión", e1);
		}

		try {
			String call = getSQLdeleteLimitProfileService();

			cat.debug("sql[" + call + "]");

			CallableStatement cstmt = conn.prepareCall(call);

			if (cat.isDebugEnabled()) {
				cat.debug("Registrando Entradas");
				cat.debug("Id de Cliente[" + prodList.getCustomer().getCode() + "]");
				cat.debug("numero Abonado[" + prodList.getCustomer().getAbonado().getNum_abonado() + "]");
				cat.debug("isAciclo[" + iif(prodList.isAciclo()) + "]");
			}			
			cstmt.setLong(1, prodList.getCustomer().getCode());
			cstmt.setLong(2, prodList.getCustomer().getAbonado().getNum_abonado());
			cstmt.setInt(5, iif(prodList.isAciclo()));

			cat.debug(" Registrando salidas");

			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);

			cat.debug(" Iniciando Ejecución");
			
			productos = prodList.getProductsDisabled();

			cat.debug("Elementos[" + productos.length + "]");
			for (int i = 0; i < productos.length; i++) {
				String profileId = productos[i].getProfileId();
				cat.debug("Iteracion[" + i + "]");
				cat.debug("profileId[" + profileId + "]");
				cat.debug("Cod_plan_servicio[" + productos[i].getCodPlan() + "]");
				
				cstmt.setString(3, productos[i].getCodPlan());
				cstmt.setString(4, profileId);				

				cat.debug("Execute Antes");
				cstmt.execute();
				cat.debug("Execute Despues");
				
				codError = cstmt.getInt(6);
				cat.debug("codError[" + codError + "]");
				msgError = cstmt.getString(7);
				cat.debug("msgError[" + msgError + "]");
				numEvento = cstmt.getInt(8);
				cat.debug("numEvento[" + numEvento + "]");		
				
				if (codError != 0) {
					cat.error("Ocurrió un error al eliminar los servicios suplementatios");
					throw new TOLException("Ocurrió un error al eliminar los servicios suplementatios [deleteLimitProfileService]", String.valueOf(codError),numEvento, msgError);
				}				
			}
			
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
			// Recuperacion de valores de salida

		} catch (TOLException e) {
			cat.debug("TOLException", e);
			throw e;
			
		} catch (Exception e) {
			cat.error("Ocurrió un error general al actualizar el limite de consumo", e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new TOLException("Ocurrió un error al eliminar los servicios suplementatios [deleteLimitProfileService]",e);
		} finally {
			cat.debug("Cerrando conexiones...");
			try {
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				cat.debug("SQLException", e);
			}
		}

		cat.debug("deleteLimitProfileService():end");
	}		
	
	
	public CustomerAccountDTO getFreeUnitBagId(CustomerAccountDTO dto) throws TOLException{
		if (cat.isDebugEnabled()) {
			cat.debug("getFreeUnitBagId():start");
		}

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		CustomerAccountDTO respuesta = new CustomerAccountDTO();

		Connection conn = null;
		try {
			//conn = getConnectionFromWLSInitialContext(global.getJndiSCLForDataSource());
			conn = getConnectionDAO("jndi.tol25.tol.scl.dataSource");
		} catch (Exception e1) {
			cat.error(" No se pudo obtener una conexión ", e1);
			throw new TOLException("No se pudo obtener una conexión", e1);
		}

		try {
			String call = getSQLgetFreeUnitBagId();

			if (cat.isDebugEnabled()) {
				cat.debug("sql[" + call + "]");
			}

			CallableStatement cstmt = conn.prepareCall(call);


			if (cat.isDebugEnabled()) {
				cat.debug(" Registrando entrada");
				cat.debug("getCodePlanRate[" + dto.getCodePlanRate() + "]");
			}
			
			cstmt.setString(1, dto.getCodePlanRate());
			
			cat.debug(" Registrando salidas");
			
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			
			cat.debug("Execute Antes");
			cstmt.execute();
			cat.debug("Execute Despues");
				
			codError = cstmt.getInt(2);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(3);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(4);
			cat.debug("numEvento[" + numEvento + "]");		
				
			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar informacion de bolsa del cliente [getFreeUnitBagId]");
				throw new TOLException("Ocurrió un error al recuperar informacion de bolsa del cliente [getFreeUnitBagId]", String.valueOf(codError), numEvento, msgError);
			}
						
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
			// Recuperacion de valores de salida
			
			respuesta.setCodeStockMarket(cstmt.getString(5));			
			respuesta.setMeasuredUnit(cstmt.getString(6));
			respuesta.setFreeUnits(cstmt.getInt(7));
			
			
			if (cat.isDebugEnabled()) {
				cat.debug("CodeStockMarke[" + respuesta.getCodeStockMarket() + "]");
				cat.debug("MeasuredUnit[" + respuesta.getMeasuredUnit() + "]");
				cat.debug("FreeUnits[" + respuesta.getFreeUnits() + "]");
			}

		} catch (TOLException e) {
			cat.debug("TOLException", e);
			throw e;
			
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar informacion de bolsa del cliente", 	e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new TOLException("Ocurrió un error general al recuperar informacion de bolsa del cliente [getFreeUnitBagId]", e);
		} finally {
			if (cat.isDebugEnabled()) {
				cat.debug("Cerrando conexiones...");
			}
			try {
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				cat.debug("SQLException", e);
			}
		}

		cat.debug("getFreeUnitBagId():end");

		return respuesta;
	}
	
	/**
	 * Obtiene los limites de consumo dado un codigo de plan
	 * @param prodList
	 * @return
	 * @throws TOLException
	 */
	public ProductListDTO getDefaultServiceLimitProfile(ProductListDTO prodList) throws TOLException
	{
		cat.info("getDefaultServiceLimitProfile:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ProductDTO[] productos = null;
		ProductListDTO respuesta = new ProductListDTO();

		Connection conn = null;
		try {
			//conn = getConnectionFromWLSInitialContext(global.getJndiSCLForDataSource());
			conn = getConnectionDAO("jndi.tol25.tol.scl.dataSource");
		} catch (Exception e1) {
			cat.error(" No se pudo obtener una conexión ", e1);
			throw new TOLException("No se pudo obtener una conexión", e1);
		}

		try {
			String call = getSQLgetDefaultServiceLimitProfile();

			cat.debug("sql[" + call + "]");

			CallableStatement cstmt = conn.prepareCall(call);

			cat.debug(" Registrando salidas");
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);

			cat.debug(" Iniciando Ejecución");
			
			productos = prodList.getProducts();
			
			cat.debug("Elementos[" + productos.length + "]");
			for (int i = 0; i < productos.length; i++) {
				cat.debug("Iteracion[" + i + "]");
				
				cat.debug("cod_plan[" + productos[i].getCodPlan() + "]");
				cstmt.setString( 1, productos[i].getCodPlan());			//cod_plantarif
				
				cat.debug("Execute Antes");
				cstmt.execute();
				cat.debug("Execute Despues");
				
				codError = cstmt.getInt(2);
				cat.debug("codError[" + codError + "]");
				msgError = cstmt.getString(3);
				cat.debug("msgError[" + msgError + "]");
				numEvento = cstmt.getInt(4);
				cat.debug("numEvento[" + numEvento + "]");		
				
				if (codError != 0) {
					cat.error("Ocurrio un error servicio default");
					throw new TOLException("Ocurrio un error servicio default [getDefaultServiceLimitProfile]", String.valueOf(codError), numEvento, msgError);
				}	
				
				cat.debug("ProfileId[" + cstmt.getString(5) + "]");
				productos[i].setProfileId(cstmt.getString(5));
			}
			
			respuesta.setProducts(productos);
			cat.debug(" Finalizo ejecución");
			cat.debug(" Recuperando salidas");
			
		} catch (Exception e) {
			cat.error("Exception",	e);
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error: " + msgError + "]");
			cat.debug("Numero de Evento: " + numEvento + "]");

			throw new TOLException("Ocurrio un error servicio default [getDefaultServiceLimitProfile]", e);
		} finally {
			cat.debug("Cerrando conexiones...");
			try {
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}

		if (codError != 0) {
			cat.info("Ocurrio un error servicio default [getDefaultServiceLimitProfile]");
			throw new TOLException("Ocurrio un error servicio default [getDefaultServiceLimitProfile]", String.valueOf(codError),numEvento, msgError);
		}
		
		cat.info("getDefaultServiceLimitProfile:end");
		return respuesta;
	}	

	
	private String getSQLsetServiceLimitTemporally() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   SO_ACT_LCTEMP tol_lim_cliabo_to_qt :=TOL_SCL_INI_ESTRUCTURAS_SB_PG.TOL_inicia_LIM_CLIABO_QT_FN;");
		call.append(" BEGIN ");
        call.append("   SO_ACT_LCTEMP.cod_cliente := ?;");
        call.append("   SO_ACT_LCTEMP.imp_pago := ?;");
        call.append("   SO_ACT_LCTEMP.num_abonado := ?;");
        call.append("   SO_ACT_LCTEMP.cod_plan := ?;");
        call.append("   SO_ACT_LCTEMP.cod_limcons := ?;");
		call.append("   TOL_SCL_LC_SB_PG.TOL_ACTUALIZA_LC_TEMPORAL_PR ( SO_ACT_LCTEMP, ?, ?, ?);");
		call.append(" END;");
		return call.toString();		
		
	}	
	
	public void setServiceLimitTemporally(LimiteClienteDTO dto)  throws TOLException
	{
		cat.info("setServiceLimitTemporally:star");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;

		Connection conn = null;
		try {
			//conn = getConnectionFromWLSInitialContext(global.getJndiSCLForDataSource());
			conn = getConnectionDAO("jndi.tol25.tol.scl.dataSource");
		} catch (Exception e1) {
			cat.error(" No se pudo obtener una conexión ", e1);
			throw new TOLException("No se pudo obtener una conexión", e1);
		}

		try {
			String call = getSQLsetServiceLimitTemporally();
			cat.debug("sql[" + call + "]");

			CallableStatement cstmt = conn.prepareCall(call);

			cat.debug("Registrando Entradas");
			cat.debug("1 Cliente " + dto.getCod_cliente());
			cat.debug("3 Abonado " + dto.getNum_abonado());
			
			
			cstmt.setLong(1, dto.getCod_cliente());
			cstmt.setLong(3, dto.getNum_abonado() );
			

			cat.debug(" Registrando salidas");

			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);

			cat.debug(" Iniciando Ejecución");
			

			cat.debug("Elementos[" + dto.getLimites().length + "]");
			for(int i=0;i<dto.getLimites().length;i++)
			{
				cat.debug("Iteracion[" + i + "]");
				cat.debug("getMto_pago[" + dto.getLimites()[i].getMto_pago() + "]");
				cat.debug("getProfileId[" + dto.getLimites()[i].getProfileId() + "]");
				cat.debug("4 plan " + dto.getLimites()[i].getCod_plan());
				
				cstmt.setDouble(2, dto.getLimites()[i].getMto_pago());				
				cstmt.setString(5, dto.getLimites()[i].getProfileId());
				cstmt.setString(4, dto.getLimites()[i].getCod_plan() );

				cat.debug("Execute Antes");
				cstmt.execute();
				cat.debug("Execute Despues");
				
				codError = cstmt.getInt(6);
				cat.debug("codError[" + codError + "]");
				msgError = cstmt.getString(7);
				cat.debug("msgError[" + msgError + "]");
				numEvento = cstmt.getInt(8);
				cat.debug("numEvento[" + numEvento + "]");		
				
				if (codError != 0) {
					cat.error(" Ocurrió un error al setiar los limites temporales [setServiceLimitTemporally]");
					throw new TOLException(" Ocurrió un error al setiar los limites temporales [setServiceLimitTemporally]", String.valueOf(codError),numEvento, msgError);
				}				
			}
			
			cat.debug(" Finalizo ejecución");
			cat.debug(" Recuperando salidas");
			// Recuperacion de valores de salida

		} catch (TOLException e) {
			cat.debug("TOLException", e);
			throw e;
			
		} catch (Exception e) {
			cat.error(" Ocurrió un error al setiar los limites temporales [setServiceLimitTemporally]", e);
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");
			
			throw new TOLException(" Ocurrió un error al setiar los limites temporales [setServiceLimitTemporally]",e);
			
		} finally {
			cat.debug("Cerrando conexiones...");

			try {
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (Exception e) {
				cat.debug("[Exception]", e);
			}
		}
		
		cat.info("setServiceLimitTemporally:end");
	}
	
	
	private String getSQLobtieneLCdelPT() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   SO_ACT_LCTEMP tol_lim_cliabo_to_qt :=TOL_SCL_INI_ESTRUCTURAS_SB_PG.TOL_inicia_LIM_CLIABO_QT_FN;");
		call.append(" BEGIN ");
        call.append("   SO_ACT_LCTEMP.cod_plantarif := ?;");
		call.append("   TOL_SCL_LC_SB_PG.tol_obtiene_LC_del_PT_pr ( SO_ACT_LCTEMP, ?, ?, ?);");
		call.append("   ? := SO_ACT_LCTEMP.cod_limcons;");
		call.append(" END;");
		return call.toString();		
		
	}	
	
	
	public void obtieneLCdelPT(DistribucionBolsaDTO dto) throws TOLException
	{
		cat.info("obtieneLCdelPT:star");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ProductDTO[] productos = null;

		Connection conn = null;
		try {
			//conn = getConnectionFromWLSInitialContext(global.getJndiSCLForDataSource());
			conn = getConnectionDAO("jndi.tol25.tol.scl.dataSource");
		} catch (Exception e1) {
			cat.error(" No se pudo obtener una conexión ", e1);
			throw new TOLException("No se pudo obtener una conexión", e1);
		}

		try {
			String call = getSQLobtieneLCdelPT();

			cat.debug("sql[" + call + "]");

			CallableStatement cstmt = conn.prepareCall(call);

			cat.debug("Registrando Entradas");
			cat.debug("getCod_plan[" + dto.getCod_plan() + "]");

			
			cstmt.setString(1, dto.getCod_plan());

			cat.debug(" Registrando salidas");
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);

			cat.debug(" Iniciando Ejecución");
			cstmt.execute();
			cat.debug(" Finalizo ejecución");
			
			codError = cstmt.getInt(2);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(3);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(4);
			cat.debug("numEvento[" + numEvento + "]");		
			
			if (codError != 0) {
				cat.error(" Ocurrió un error al setiar los limites temporales [setServiceLimitTemporally]");
				throw new TOLException(" Ocurrió un error al setiar los limites temporales [setServiceLimitTemporally]", String.valueOf(codError),numEvento, msgError);
			}
			
			cat.debug("Limite de consumo recuperado [" + cstmt.getString(5) + "]");
			dto.setLimite_consumo(cstmt.getString(5));
			
			
			
		} catch (Exception e) {
			cat.error("Ocurrió un error general al recuperar al activar los servicios",	e);
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error: " + msgError + "]");
			cat.debug("Numero de Evento: " + numEvento + "]");

			throw new TOLException("Ocurrió un error general al actualizar al activar los servicios [createLimitProfileService]", e);
		} finally {
			cat.debug("Cerrando conexiones...");
			try {
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (Exception e) {
				cat.debug("Exception", e);
			}
		}

		if (codError != 0) {
			cat.info("stop with errors:" +codError + "(" + msgError + ")");
			throw new TOLException("Ocurrió un error general al actualizar al activar los servicios [createLimitProfileService]", String.valueOf(codError),numEvento, msgError);
		}
		
		cat.info("obtieneLCdelPT:end");		
	}
	
	private String getSQLcreaLCdelPTPorAbonado() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   SO_ACT_LCTEMP tol_lim_cliabo_to_qt :=TOL_SCL_INI_ESTRUCTURAS_SB_PG.TOL_inicia_LIM_CLIABO_QT_FN;");
		call.append(" BEGIN ");
        call.append("   SO_ACT_LCTEMP.cod_cliente := ?;");
        call.append("   SO_ACT_LCTEMP.num_abonado := ?;");
        call.append("   SO_ACT_LCTEMP.cod_plantarif := ?;");
        call.append("   SO_ACT_LCTEMP.cod_limcons := ?;");
		call.append("   TOL_SCL_LC_SB_PG.tol_creaLimiteConsumoSS_pr ( SO_ACT_LCTEMP, ?, ?, ?);");
		call.append(" END;");
		return call.toString();		
		
	}		
	
	
	public void creaLCdelPTPorAbonado(DistribucionBolsaDTO dto) throws TOLException
	{
		cat.info("creaLCdelPTPorAbonado:star");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		BolsaAbonadoDTO[] productos = null;

		Connection conn = null;
		try {
			//conn = getConnectionFromWLSInitialContext(global.getJndiSCLForDataSource());
			conn = getConnectionDAO("jndi.tol25.tol.scl.dataSource");
		} catch (Exception e1) {
			cat.error(" No se pudo obtener una conexión ", e1);
			throw new TOLException("No se pudo obtener una conexión", e1);
		}

		try {
			String call = getSQLcreaLCdelPTPorAbonado();

			cat.debug("sql[" + call + "]");

			CallableStatement cstmt = conn.prepareCall(call);
			cat.debug("Id de Cliente[" + dto.getCod_cliente() + "]");
			
			
			cat.debug("Registrando Entradas");
			cstmt.setLong(1, dto.getCod_cliente());
			cstmt.setString( 4, dto.getLimite_consumo());
			cstmt.setString( 3, dto.getCod_plan());
			
			cat.debug(" Registrando salidas");
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);

			cat.debug(" Iniciando Ejecución");
			
			productos = dto.getBolsa();
			
			cat.debug("Elementos[" + productos.length + "]");
			for (int i = 0; i < productos.length; i++) {
				cat.debug("Iteracion[" + i + "]");
				cat.debug("Abonado[" + dto.getBolsa()[i].getNum_abonado() + "]");

				cstmt.setInt( 2, productos[i].getNum_abonado());		//cod_limcons

				cat.debug("Execute Antes");
				cstmt.execute();
				cat.debug("Execute Despues");
					
				codError = cstmt.getInt(5);
				cat.debug("codError[" + codError + "]");
				msgError = cstmt.getString(6);
				cat.debug("msgError[" + msgError + "]");
				numEvento = cstmt.getInt(7);
				cat.debug("numEvento[" + numEvento + "]");		
					
				if (codError != 0) {
					cat.error(" Ocurrió un error al activar uno de los servicios");
					throw new TOLException("Ocurrio un error al crear LC por abonado [creaLCdelPTPorAbonado]", String.valueOf(codError), numEvento, msgError);
				}		
				
			}
			
			cat.debug(" Finalizo ejecución");
			
		} catch (Exception e) {
			cat.error("Ocurrió un error general al recuperar al activar los servicios",	e);
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error: " + msgError + "]");
			cat.debug("Numero de Evento: " + numEvento + "]");

			throw new TOLException("Ocurrio un error al crear LC por abonado [creaLCdelPTPorAbonado]", e);
		} finally {
			cat.debug("Cerrando conexiones...");
			try {
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (Exception e) {
				cat.debug("Exception", e);
			}
		}

		if (codError != 0) {
			cat.info("stop with errors:" +codError + "(" + msgError + ")");
			throw new TOLException("Ocurrió un error general al actualizar al activar los servicios [createLimitProfileService]", String.valueOf(codError),numEvento, msgError);
		}	
		
		cat.info("creaLCdelPTPorAbonado:end");
	}
	
}
