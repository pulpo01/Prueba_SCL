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
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.BolsaAbonadoDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.CustomerAccountDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.DistribucionBolsaDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.FreeUnitStockDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.LimiteClienteDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.LimiteConsumoDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ProductDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ProductListDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.exception.TOLException;
import com.tmmas.cl.scl.tol.ServiceBundle.businessobject.helper.Global;


public class ServiceBundleSpecTOLDAO extends ConnectionDAO  {
	private static Category cat = Category.getInstance(ServiceBundleSpecTOLDAO.class);

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
		cat.debug("config.getString(strDataSource):" + config.getString(strDataSource));
		
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
	
	
	public ServiceBundleSpecTOLDAO()
	{
		setPropFile();
		cat.info("ServiceBundleSpecDAO Constructor");
	}
	
	
	public void createFreeUnitStock(FreeUnitStockDTO[] list) throws TOLException
	{
		cat.info("createFreeUnitStock:star");
		cat.info("createFreeUnitStock:end");
	}

	private String getSQLUninstallServiceBundle() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   EO_sbas_ss TOL_sbas_ss_qt:= TOL_INICIA_ESTRUCTURAS_SB_PG.TOL_Inicia_TOL_SBas_SS_QT_FN;");
		call.append("   SN_COD_RETORNO NUMBER;");
		call.append("   SV_MENS_RETORNO VARCHAR2(200);");
		call.append("   SN_NUM_EVENTO NUMBER;");
		call.append(" BEGIN ");
		call.append("   EO_sbas_ss.COD_CLIENTE := ?;");
		call.append("   EO_sbas_ss.num_abonado  := ?;");
		call.append("   EO_sbas_ss.cod_plan  := ?;");
		call.append("   EO_sbas_ss.COD_SERV := ?;");		
        call.append("   EO_sbas_ss.aciclo  := ?;");
		call.append("   SN_COD_RETORNO := NULL;");
		call.append("   SV_MENS_RETORNO := NULL;");
		call.append("   SN_NUM_EVENTO := NULL;");
		call.append("   TOL_ServSupl_SB_PG.TOL_Desactivar_SS_PR( EO_sbas_ss, ?, ?, ?);");
		call.append(" END;");
		return call.toString();		
	}
	
	
	private String getSQLInstallServiceBundle() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   EO_sbas_ss tol_sbas_ss_qt := TOL_INICIA_ESTRUCTURAS_SB_PG.TOL_inicia_TOL_SBAS_SS_QT_FN;");
		call.append("   SN_COD_RETORNO NUMBER;");
		call.append("   SV_MENS_RETORNO VARCHAR2(200);");
		call.append("   SN_NUM_EVENTO NUMBER;");
		call.append(" BEGIN ");
        call.append("   EO_sbas_ss.cod_cliente := ?;");
        call.append("   EO_sbas_ss.num_abonado := 0;");
        call.append("   EO_sbas_ss.ind_bolsadcto := ?;");
        call.append("   EO_sbas_ss.cod_plan := ?;");
        call.append("   EO_sbas_ss.ind_aplica := ?;");
        call.append("   EO_sbas_ss.ind_serv := ?;");
        call.append("   EO_sbas_ss.cod_serv  := ?;");
        call.append("   EO_sbas_ss.ind_prioridad  := ?;");
        call.append("   EO_sbas_ss.cod_servsupl := ?;");
        call.append("   EO_sbas_ss.cod_nivel := ?;");
        call.append("   EO_sbas_ss.ind_desborde := ?;");
        call.append("   EO_sbas_ss.aciclo  := ?;");
        call.append("   SN_COD_RETORNO := NULL;");
		call.append("   SV_MENS_RETORNO := NULL;");
		call.append("   SN_NUM_EVENTO := NULL;");
		call.append("   TOL_SERVSUPL_SB_PG.TOL_ACTIVAR_SS_PR( EO_sbas_ss, ?, ?, ?);");
		call.append(" END;");
		return call.toString();		
	}
	
	private String getSQLCreateStorageAndFreeUnitStock() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   EO_bolsa_sb tol_bolsa_sb_qt := TOL_INICIA_ESTRUCTURAS_SB_PG.TOL_Inicia_TOL_Bolsa_SB_QT_FN;");
		call.append("   SN_COD_RETORNO NUMBER;");
		call.append("   SV_MENS_RETORNO VARCHAR2(200);");
		call.append("   SN_NUM_EVENTO NUMBER;");
		call.append(" BEGIN ");
        call.append("   EO_bolsa_sb.cod_cliente := ?;");
        call.append("   EO_bolsa_sb.num_abonado := ?;");
        call.append("   EO_bolsa_sb.cod_plan := ?;");
        call.append("   EO_bolsa_sb.cod_bolsa := ?;");
        call.append("   EO_bolsa_sb.ind_unidad := ?;");
        call.append("   EO_bolsa_sb.prc_unidad := ?;");
        call.append("   EO_bolsa_sb.cnt_unidad := ?;");
        call.append("   EO_bolsa_sb.ind_venta := ?;");
        call.append("   SN_COD_RETORNO := NULL;");
		call.append("   SV_MENS_RETORNO := NULL;");
		call.append("   SN_NUM_EVENTO := NULL;");
		call.append("   TOL_Bolsa_SB_PG.TOL_CREA_BOLSA_DISTR_PR( EO_bolsa_sb, ?, ?, ?);");
		
		
		call.append(" END;");
		return call.toString();			
	}	
	
	private String getSQLCreateStorageFreeUnitStock() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   EO_bolsa_sb tol_bolsa_sb_qt := TOL_INICIA_ESTRUCTURAS_SB_PG.TOL_Inicia_TOL_Bolsa_SB_QT_FN;");
		call.append("   SN_COD_RETORNO NUMBER;");
		call.append("   SV_MENS_RETORNO VARCHAR2(200);");
		call.append("   SN_NUM_EVENTO NUMBER;");
		call.append(" BEGIN ");
        call.append("   EO_bolsa_sb.cod_cliente := ?;");
        call.append("   EO_bolsa_sb.num_abonado := ?;");
        call.append("   EO_bolsa_sb.cnt_unidad := ?;");
		call.append("   TOL_Bolsa_SB_PG.TOL_Crea_Acum_Distr_PR( EO_bolsa_sb, ?, ?, ?);");
		call.append(" END;");
		return call.toString();			
	}
		
	private String getSQLsetFreeUnitStock() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   SO_actdist TOL_BOLSA_SB_QT := TOL_INICIA_ESTRUCTURAS_SB_PG.TOL_Inicia_TOL_Bolsa_SB_QT_FN;");
		call.append(" BEGIN ");
        call.append("   SO_actdist.cod_cliente := ?;");
        call.append("   SO_actdist.num_abonado := ?;");
        call.append("   SO_actdist.prc_unidad  := ?;");
        call.append("   SO_actdist.cnt_unidad  := ?;");
        call.append("   SO_actdist.ind_venta   := ?;");                        
		call.append("   TOL_Bolsa_SB_PG.TOL_actualiza_bolsa_Distr_PR( SO_actdist, ?, ?, ?);");
		call.append(" END;");
		return call.toString();			
	}	
	
	private String getSQLGetFreeUnitStock() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   SO_OBTDIST TOL_BOLSA_SB_QT := TOL_INICIA_ESTRUCTURAS_SB_PG.TOL_Inicia_TOL_Bolsa_SB_QT_FN;");
		call.append("   O_CURSOR TOL_Bolsa_SB_PG.refcursor;");
		call.append("   SN_COD_RETORNO NUMBER;");
		call.append("   SV_MENS_RETORNO VARCHAR2(200);");
		call.append("   SN_NUM_EVENTO NUMBER;");
		call.append(" BEGIN ");
        call.append("   SO_OBTDIST.cod_cliente := ?;");
        call.append("   SO_OBTDIST.cod_plan := ?;");
		call.append("   TOL_BOLSA_SB_PG.TOL_OBTEN_DISTR_PR( SO_OBTDIST, ?, ?, ?, ?);");
		call.append(" END;");
		return call.toString();			
	}		
	
	public void installServiceBundle(ProductListDTO prodList) throws TOLException {
		cat.debug("installServiceBundle():start");

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		

		Connection conn = null;
		try {
			//conn = getConnectionFromWLSInitialContext(global.getJndiTOLForDataSource());
			conn = getConnectionDAO("jndi.tol25.tol.tol.dataSource");
		} catch (Exception e1) {
			cat.error(" No se pudo obtener una conexión ", e1);
			throw new TOLException("No se pudo obtener una conexión", e1);
		}

		try {
			String call = getSQLInstallServiceBundle();

			cat.debug("sql[" + call + "]");

			CallableStatement cstmt = conn.prepareCall(call);

			cat.debug("Registrando Entradas");
			cat.debug("Id de Cliente[" + prodList.getCustomer().getCode() + "]");
			cat.debug("isAciclo[" + prodList.isAciclo() + "]");
			cstmt.setLong(1, prodList.getCustomer().getCode());
			cstmt.setInt(11, iif(prodList.isAciclo()));

			cat.debug(" Registrando salidas");
			cstmt.registerOutParameter(12, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(14, java.sql.Types.NUMERIC);

			cat.debug(" Iniciando Ejecución");
			
			ProductDTO[] productos = prodList.getProducts();
			cat.debug("Elementos[" + productos.length + "]");
			for (int i = 0; i < productos.length; i++) {
				cat.debug("Iteracion[" + i + "]");
				cat.debug("getIndicatorBagDiscount[" + productos[i].getIndicatorBagDiscount() + "]");
				cat.debug("getCodPlan[" + productos[i].getCodPlan() + "]");
				
				cstmt.setString( 2, productos[i].getIndicatorBagDiscount());				//ind_bolsadcto
				cstmt.setString( 3, productos[i].getCodPlan());			//cod_plan
				
				if(prodList.getCustomer().getAbonado().getNum_abonado() == 0)
					cstmt.setString( 4, "CS");								//ind_aplica
				else
					cstmt.setString( 4, "CA");								//ind_aplica
				
				cstmt.setString( 5, "SS");								//ind_serv
				cstmt.setString( 6, productos[i].getId());				//cod_serv
				cstmt.setString( 7, productos[i].getPriority());		//ind_prioridad
				cstmt.setLong( 8, productos[i].getIdServSupl());		//cod_servsupl
				cstmt.setLong( 9, productos[i].getCodLevel());			//cod_nivel
				cstmt.setString(10, productos[i].getExceedId());		//ind_desborde			
				
				cat.debug("cod_cliente ["+prodList.getCustomer().getCode() + "]");
				cat.debug("ind_bolsadcto ["+productos[i].getIndicatorBagDiscount() + "]");
				cat.debug("cod_plan ["+productos[i].getCodPlan() + "]");
				cat.debug("ind_aplica [CS]");
				cat.debug("ind_serv [SS]");
				cat.debug("cod_serv ["+productos[i].getId() + "]");
				cat.debug("ind_prioridad ["+productos[i].getPriority() + "]");
				cat.debug("cod_servsupl ["+productos[i].getIdServSupl() + "]");
				cat.debug("cod_nivel ["+productos[i].getCodLevel() + "]");
				cat.debug("ind_desborde ["+productos[i].getExceedId() + "]");
				
				cat.debug("Execute Antes");
				cstmt.execute();
				cat.debug("Execute Despues");
				
				codError = cstmt.getInt(12);
				cat.debug("codError[" + codError + "]");
				msgError = cstmt.getString(13);
				cat.debug("msgError[" + msgError + "]");
				numEvento = cstmt.getInt(14);
				cat.debug("numEvento[" + numEvento + "]");		
				
				if (codError != 0) {
					cat.error(" Ocurrió un error al activar uno de los servicios");
					throw new TOLException("Ocurrió un error al activar los servicios [installServiceBundle]", String.valueOf(codError), numEvento, msgError);
				}				
			}
			
			cat.debug(" Finalizo ejecución");
			cat.debug(" Recuperando salidas");
			
		} catch (TOLException e) {
			cat.error("TOLException", e);
			throw e;
			
		} catch (Exception e) {
			cat.error("Ocurrió un error al activar los servicios [installServiceBundle]",	e);
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error: " + msgError + "]");
			cat.debug("Numero de Evento: " + numEvento + "]");

			throw new TOLException("Ocurrió un error al activar los servicios [installServiceBundle]", e);
			
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

		cat.debug("installServiceBundle():end");
	}
	
	

	

	public void createStorageAndFreeUnitStock(DistribucionBolsaDTO dto) throws TOLException
	{
		cat.info("createStorageAndFreeUnitStock:star");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		

		Connection conn = null;
		try {
			//conn = getConnectionFromWLSInitialContext(global.getJndiTOLForDataSource());
			conn = getConnectionDAO("jndi.tol25.tol.tol.dataSource");
		} catch (Exception e1) {
			cat.error(" No se pudo obtener una conexión ", e1);
			throw new TOLException("No se pudo obtener una conexión", e1);
		}

		try {
			String call = getSQLCreateStorageAndFreeUnitStock();

			cat.debug("sql[" + call + "]");

			CallableStatement cstmt = conn.prepareCall(call);

			cat.debug("Registrando Entradas");
			cat.debug("Id de Cliente[" + dto.getCod_cliente()+ "]");
			cstmt.setLong(1, dto.getCod_cliente());		//call.append("   EO_bolsa_sb.cod_cliente := ?;");

			cat.debug(" Registrando salidas");
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);			

			BolsaAbonadoDTO[] productos = dto.getBolsa();
			cat.debug("dto.getBolsa()[" + productos.length + "]");
			for (int i = 0; i < productos.length; i++) {
				cat.debug("Iteracion[" + i + "]");
				cat.debug("2 getNum_abonado[" + productos[i].getNum_abonado() + "]");
				cat.debug("3 getCod_plan[" + dto.getCod_plan() + "]");
				cat.debug("4 getCod_bolsa[" + dto.getCod_bolsa() + "]");
				cat.debug("5 getInd_unidad[" + dto.getInd_unidad() + "]");
				cat.debug("6 getPrc_unidad[" + productos[i].getPrc_unidad() + "]");
				cat.debug("7 getCnt_unidad[" + productos[i].getCnt_unidad() + "]");
				cat.debug("8 getInd_venta[" + productos[i].getInd_venta() + "]");
				
				cstmt.setLong( 2, productos[i].getNum_abonado());
				cstmt.setString( 3, dto.getCod_plan());
				cstmt.setString( 4, dto.getCod_bolsa());
				cstmt.setString( 5, dto.getInd_unidad());
				cstmt.setFloat( 6, productos[i].getPrc_unidad());
				cstmt.setInt( 7, productos[i].getCnt_unidad());
				cstmt.setLong( 8, productos[i].getInd_venta());
				
				cat.debug("Execute Antes");
				cstmt.execute();
				cat.debug("Execute Despues");
				
				codError = cstmt.getInt(9);
				cat.debug("codError[" + codError + "]");
				msgError = cstmt.getString(10);
				cat.debug("msgError[" + msgError + "]");
				numEvento = cstmt.getInt(11);
				cat.debug("numEvento[" + numEvento + "]");		
				
				if (codError != 0) {
					cat.error(" Crear las unidades libres de almacenaliento");
					throw new TOLException("Crear las unidades libres de almacenaliento [createStorageAndFreeUnitStock]", String.valueOf(codError), numEvento, msgError);
				}				
			}

			cat.debug(" Finalizo ejecución");
			cat.debug(" Recuperando salidas");
		} catch (TOLException e) {
			cat.error("TOLException", e);
			throw e;
			
		} catch (Exception e) {
			cat.error("Ocurrió un error general al recuperar al activar los servicios",	e);
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error: " + msgError + "]");
			cat.debug("Numero de Evento: " + numEvento + "]");

			throw new TOLException("Crear las unidades libres de almacenaliento [createStorageAndFreeUnitStock]", e);
		} finally {
			cat.debug("Cerrando conexiones...");
			try {
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (Exception e) {
				cat.debug("Exception Cerrando conexiones...", e);
			}
		}

		cat.info("createStorageAndFreeUnitStock:end");
	}
               
	public void createStorageFreeUnitStock(DistribucionBolsaDTO dto) throws TOLException
	{
		cat.info("createStorageFreeUnitStock:star");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		

		Connection conn = null;
		try {
			//conn = getConnectionFromWLSInitialContext(global.getJndiTOLForDataSource());
			conn = getConnectionDAO("jndi.tol25.tol.tol.dataSource");
		} catch (Exception e1) {
			cat.error(" No se pudo obtener una conexión ", e1);
			throw new TOLException("No se pudo obtener una conexión", e1);
		}

		try {
			String call = getSQLCreateStorageFreeUnitStock();

			cat.debug("sql[" + call + "]");

			CallableStatement cstmt = conn.prepareCall(call);

			cat.debug("Registrando Entradas");
			cat.debug("Id de Cliente[" + dto.getCod_cliente()+ "]");
			cstmt.setLong(1, dto.getCod_cliente());		//call.append("   EO_bolsa_sb.cod_cliente := ?;");

			cat.debug(" Registrando salidas");
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);			

			BolsaAbonadoDTO[] productos = dto.getBolsa();
			cat.debug("dto.getBolsa()[" + productos.length + "]");
			for (int i = 0; i < productos.length; i++) {
				cat.debug("Iteracion[" + i + "]");
				cat.debug("getNum_abonado[" + productos[i].getNum_abonado() + "]");
				cat.debug("getCnt_unidad[" + productos[i].getCnt_unidad() + "]");
				
				cstmt.setLong( 2, productos[i].getNum_abonado());
				cstmt.setInt( 3,  productos[i].getCnt_unidad());
				
				cat.debug("Execute Antes");
				cstmt.execute();
				cat.debug("Execute Despues");
				
				codError = cstmt.getInt(4);
				cat.debug("codError[" + codError + "]");
				msgError = cstmt.getString(5);
				cat.debug("msgError[" + msgError + "]");
				numEvento = cstmt.getInt(6);
				cat.debug("numEvento[" + numEvento + "]");		
				
				if (codError != 0) {
					cat.error("Crear las unidades libres de almacenaliento");
					throw new TOLException("Crear las unidades libres de almacenaliento [createStorageFreeUnitStock]", String.valueOf(codError), numEvento, msgError);
				}				
			}			
						
			cat.debug(" Finalizo ejecución");
			cat.debug(" Recuperando salidas");
			
			
		} catch (TOLException e) {
			cat.error("TOLException", e);
			throw e;
			
		} catch (Exception e) {
			cat.error("Crear las unidades libres de almacenaliento", e);
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error: " + msgError + "]");
			cat.debug("Numero de Evento: " + numEvento + "]");

			throw new TOLException("Crear las unidades libres de almacenaliento [createStorageFreeUnitStock]", e);
		} finally {
			cat.debug("Cerrando conexiones...");
			try {
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (Exception e) {
				cat.debug("Exception Cerrando conexiones...", e);
			}
		}

		cat.info("createStorageFreeUnitStock:end");
	}
	
	
	private String getSQLDeleteFreeUnitStock() {
		StringBuffer call = new StringBuffer();
		call.append("DECLARE "); 
		call.append("  EO_BOLSA_SB tol_bolsa_sb_qt; ");
		call.append("  SN_COD_RETORNO NUMBER; ");
		call.append("  SV_MENS_RETORNO VARCHAR2(200); ");
		call.append("  SN_NUM_EVENTO NUMBER; ");
		call.append("BEGIN  ");
		call.append("  EO_BOLSA_SB := TOL_INICIA_ESTRUCTURAS_SB_PG.TOL_INICIA_TOL_BOLSA_SB_QT_FN; ");
		call.append("  EO_BOLSA_SB.COD_CLIENTE := ?; ");
		call.append("  EO_BOLSA_SB.num_abonado := ?; ");
		call.append("  SN_COD_RETORNO := NULL; ");
		call.append("  SV_MENS_RETORNO := NULL; ");
		call.append("  SN_NUM_EVENTO := NULL; ");
		call.append("  TOL_BOLSA_SB_PG.TOL_ELIMINA_BOLSA_DISTR_PR( EO_BOLSA_SB, ?, ?, ?); ");
		call.append("END; ");  
		return call.toString();		
	
	}
	
	private String getSQLDeleteStorageFreeUnitStock()
	{
		StringBuffer call = new StringBuffer();
		call.append("DECLARE "); 
		call.append("  EO_BOLSA_SB tol_bolsa_sb_qt; ");
		call.append("  SN_COD_RETORNO NUMBER; ");
		call.append("  SV_MENS_RETORNO VARCHAR2(200); ");
		call.append("  SN_NUM_EVENTO NUMBER; ");
		call.append("BEGIN  ");
		call.append("  EO_BOLSA_SB := TOL_INICIA_ESTRUCTURAS_SB_PG.TOL_INICIA_TOL_BOLSA_SB_QT_FN; ");
		call.append("  EO_BOLSA_SB.COD_CLIENTE := ?; ");
		call.append("  EO_BOLSA_SB.NUM_ABONADO := ?; ");
		call.append("  SN_COD_RETORNO := NULL; ");
		call.append("  SV_MENS_RETORNO := NULL; ");
		call.append("  SN_NUM_EVENTO := NULL; ");
		call.append("  TOL_BOLSA_SB_PG.TOL_ELIMINA_ACUM_DISTR_PR( EO_BOLSA_SB, ?, ?, ? ); ");
		call.append("END; ");
		
		return call.toString();		
	}
	
	public void deleteStorageFreeUnitStock(DistribucionBolsaDTO dto) throws TOLException
	{
		cat.info("deleteStorageFreeUnitStock:star");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;

		Connection conn = null;
		try {
			//conn = getConnectionFromWLSInitialContext(global.getJndiTOLForDataSource());
			conn = getConnectionDAO("jndi.tol25.tol.tol.dataSource");
		} catch (Exception e1) {
			cat.error(" No se pudo obtener una conexión ", e1);
			throw new TOLException("No se pudo obtener una conexión", e1);
		}

		try {
			String call = getSQLDeleteStorageFreeUnitStock();

			cat.debug("sql[" + call + "]");

			CallableStatement cstmt = conn.prepareCall(call);

			cat.debug("Registrando Entradas");
			cat.debug("Id de Cliente[" + dto.getCod_cliente()+ "]");
			cstmt.setLong(1, dto.getCod_cliente());		//call.append("   EO_bolsa_sb.cod_cliente := ?;");

			cat.debug(" Registrando salidas");
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);			

			BolsaAbonadoDTO[] productos = dto.getBolsa();
			cat.debug("dto.getBolsa()[" + productos.length + "]");
			for (int i = 0; i < productos.length; i++) {
				cat.debug("Iteracion[" + i + "]");
				cat.debug("getNum_abonado[" + productos[i].getNum_abonado() + "]");
				cstmt.setLong( 2, productos[i].getNum_abonado());
				
				cat.debug("Execute Antes");
				cstmt.execute();
				cat.debug("Execute Despues");
				
				codError = cstmt.getInt(3);
				cat.debug("codError[" + codError + "]");
				msgError = cstmt.getString(4);
				cat.debug("msgError[" + msgError + "]");
				numEvento = cstmt.getInt(5);
				cat.debug("numEvento[" + numEvento + "]");		
				
				if (codError != 0) {
					cat.error(" Ocurrio un error al eliminar las unidades libres");
					throw new TOLException("Ocurrio un error al eliminar las unidades libres [deleteStorageFreeUnitStock]", String.valueOf(codError), numEvento, msgError);
				}				
			}	
			
			
		} catch (TOLException e) {
			cat.error("TOLException", e);
			throw e;
			
		} catch (Exception e) {
			cat.error("Ocurrio un error al eliminar las unidades libres",	e);
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error: " + msgError + "]");
			cat.debug("Numero de Evento: " + numEvento + "]");

			throw new TOLException("Ocurrio un error al eliminar las unidades libres [deleteStorageFreeUnitStock]", e);
		} finally {
			cat.debug("Cerrando conexiones...");
			try {
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (Exception e) {
				cat.debug("Exception Cerrando conexiones...", e);
			}
		}
		
		cat.info("deleteStorageFreeUnitStock:end");	
	}
	
	
	public void deleteFreeUnitStock(DistribucionBolsaDTO dto) throws TOLException
	{
		cat.info("deleteFreeUnitStock:star");

		int codError = 0;
		String msgError = null;
		int numEvento = 0;

		Connection conn = null;
		try {
			//conn = getConnectionFromWLSInitialContext(global.getJndiTOLForDataSource());
			conn = getConnectionDAO("jndi.tol25.tol.tol.dataSource");
		} catch (Exception e1) {
			cat.error(" No se pudo obtener una conexión ", e1);
			throw new TOLException("No se pudo obtener una conexión", e1);
		}

		try {
			String call = getSQLDeleteFreeUnitStock();

			cat.debug("sql[" + call + "]");

			CallableStatement cstmt = conn.prepareCall(call);

			cat.debug("Registrando Entradas");
			cat.debug("Id de Cliente[" + dto.getCod_cliente() + "]");
			//cstmt.setLong(1, dto.getCod_cliente());
			cstmt.setLong(1, dto.getCod_cliente());
		
			cat.debug(" Registrando salidas");
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			
			BolsaAbonadoDTO productos[] = dto.getBolsa();
			cat.debug("Elementos[" + productos.length + "]");
			for (int i = 0; i < productos.length; i++) {
				cat.debug("Iteracion[" + i + "]");
				cat.debug("getNum_abonado[" + productos[i].getNum_abonado() + "]");
				
				cstmt.setLong( 2, productos[i].getNum_abonado());
							
				cat.debug("Execute Antes");
				cstmt.execute();
				cat.debug("Execute Despues");
				
				codError = cstmt.getInt(3);
				cat.debug("codError[" + codError + "]");
				msgError = cstmt.getString(4);
				cat.debug("msgError[" + msgError + "]");
				numEvento = cstmt.getInt(5);
				cat.debug("numEvento[" + numEvento + "]");		
				
				if (codError != 0) {
					cat.error(" Ocurrio un error al eliminar las unidades libres");
					throw new TOLException("Ocurrio un error al eliminar las unidades libres [deleteFreeUnitStock]", String.valueOf(codError), numEvento, msgError);
				}				
			}
			
			cat.debug(" Finalizo ejecución");
			cat.debug(" Recuperando salidas");
			
			
		} catch (TOLException e) {
			cat.error("TOLException", e);
			throw e;
			
		} catch (Exception e) {
			cat.error("Ocurrio un error al eliminar las unidades libres",	e);
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error: " + msgError + "]");
			cat.debug("Numero de Evento: " + numEvento + "]");

			throw new TOLException("Ocurrio un error al eliminar las unidades libres [deleteFreeUnitStock]", e);
		} finally {
			cat.debug("Cerrando conexiones...");
			try {
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (Exception e) {
				cat.debug("Exception Cerrando conexiones...", e);
			}
		}
		
		cat.info("deleteFreeUnitStock:end");		
	}
	
	public BolsaAbonadoDTO[] getFreeUnitStock(CustomerAccountDTO dto) throws TOLException{
		cat.info("getFreeUnitStock:star");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		BolsaAbonadoDTO[] ArregloBolsaAbonado = new BolsaAbonadoDTO[]{};
		BolsaAbonadoDTO bolsaAboando = null;

		Connection conn = null;
		try {
			//conn = getConnectionFromWLSInitialContext(global.getJndiTOLForDataSource());
			conn = getConnectionDAO("jndi.tol25.tol.tol.dataSource");
		} catch (Exception e1) {
			cat.error(" No se pudo obtener una conexión ", e1);
			throw new TOLException("No se pudo obtener una conexión", e1);
		}

		try {
			String call = getSQLGetFreeUnitStock();

			cat.debug("sql[" + call + "]");

			CallableStatement cstmt = conn.prepareCall(call);

			cat.debug("Registrando Entradas");
			cat.debug("Id de Cliente[" + dto.getCode() + "]");
			cstmt.setLong(1,dto.getCode());
			cat.debug("codePlanRate [" + dto.getCodePlanRate() + "]");
			cstmt.setString(2,dto.getCodePlanRate());
			cat.debug("Registrando salidas");
			cstmt.registerOutParameter(3, oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

			cat.debug(" Iniciando Ejecución");
					
			cat.debug("Execute Antes");
			cstmt.execute();
			cat.debug("Execute Despues");
				
			codError = cstmt.getInt(4);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(5);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(6);
			cat.debug("numEvento[" + numEvento + "]");		
			
			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar las unidades libres");
				throw new TOLException("Ocurrió un error al recuperar las unidades libres [getFreeUnitStock]", String.valueOf(codError), numEvento, msgError);
			}		
			cat.debug("antes de ResultSet cstmt.getObject(3)");			
			ResultSet rs = (ResultSet) cstmt.getObject(3);
			cat.debug("despues de ResultSet cstmt.getObject(3)");
			
			ArrayList lista = new ArrayList();
			while (rs.next()) {
				cat.debug("while (rs.next()) {");
				bolsaAboando = new BolsaAbonadoDTO();
				
				cat.debug("get(1)");
				bolsaAboando.setNum_abonado(rs.getInt(1));				
				cat.debug("get(2)");	
				bolsaAboando.setNum_celular(rs.getString(2));
				cat.debug("get(3)");
				bolsaAboando.setPrc_unidad(rs.getFloat(3));
				cat.debug("get(3)");				
				bolsaAboando.setCnt_unidad(rs.getInt(4));
				cat.debug("get(3)");				
				bolsaAboando.setInd_venta(rs.getInt(5));			
				cat.debug("cat.isDebugEnabled()");
				
				if (cat.isDebugEnabled()) {
					cat.debug("Num_abonado[" + bolsaAboando.getNum_abonado() + "]");
					cat.debug("Cod_plan[" + bolsaAboando.getNum_celular() + "]");
					cat.debug("Prc_unidad[" + bolsaAboando.getPrc_unidad() + "]");
					cat.debug("Cnt_unidad[" + bolsaAboando.getCnt_unidad() + "]");
					cat.debug("Ind_venta[" + bolsaAboando.getInd_venta() + "]");
				}				
				
				lista.add(bolsaAboando);
			}

			ArregloBolsaAbonado = (BolsaAbonadoDTO[])ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), BolsaAbonadoDTO.class);

			cat.debug(" Finalizo ejecución");
			cat.debug(" Recuperando salidas");			
			
			return ArregloBolsaAbonado;
						
		} catch (TOLException e) {
			cat.error("TOLException", e);
			throw e;
			
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar las unidades libres",	e);
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error: " + msgError + "]");
			cat.debug("Numero de Evento: " + numEvento + "]");

			throw new TOLException("Ocurrió un error al recuperar las unidades libres [getFreeUnitStock]", e);
		} finally {
			cat.debug("Cerrando conexiones...");
			try {
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (Exception e) {
				cat.debug("SQLException[" + e + "]");
			}
		}		
				
	}
	
	public boolean setFreeUnitStock(DistribucionBolsaDTO dto) throws TOLException{
		cat.debug("-----------------------------ini setFreeUnitStock");
		cat.info("setFreeUnitStock:star");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		int i=0;

		Connection conn = null;
		CallableStatement cstmt = null;
		try {
			//conn = getConnectionFromWLSInitialContext(global.getJndiTOLForDataSource());
			conn = getConnectionDAO("jndi.tol25.tol.tol.dataSource");
		} catch (Exception e1) {
			cat.error(" No se pudo obtener una conexión ", e1);
			throw new TOLException("No se pudo obtener una conexión", e1);
		}
		try {
			String call = getSQLsetFreeUnitStock();

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cat.debug("Registrando Entradas");
			cat.debug("cod_cliente[" + dto.getCod_cliente()+"]");
			cstmt.setLong(1,dto.getCod_cliente());
			
			cat.debug("abonados.length["+dto.getBolsa().length+"]");
			cat.debug("--------------------------Xabo");
			for (i=0; i< dto.getBolsa().length; i++){
							
				cat.debug("Iteracion  [" + i+"]");
				cat.debug("Num_abonado["+dto.getBolsa()[i].getNum_abonado()+"]");
				cat.debug("Prc_unidad ["+dto.getBolsa()[i].getPrc_unidad()+"]");
				cat.debug("Cnt_unidad ["+dto.getBolsa()[i].getCnt_unidad()+"]");
				cat.debug("ind_venta  ["+dto.getBolsa()[i].getInd_venta()+"]");
				
				cstmt.setInt(2,dto.getBolsa()[i].getNum_abonado());
				cstmt.setFloat(3,dto.getBolsa()[i].getPrc_unidad());
				cstmt.setInt(4,dto.getBolsa()[i].getCnt_unidad());
				cstmt.setInt(5,dto.getBolsa()[i].getInd_venta());
	
				cat.debug("Registrando salidas");
				cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);

				cat.debug(" Iniciando Ejecución");
					
				cat.debug("Execute Antes");
				cstmt.execute();
				cat.debug("Execute Despues");
				
				cstmt.getInt(6);
				cat.debug("codError [" + codError + "]");
				msgError = cstmt.getString(7);
				cat.debug("msgError [" + msgError + "]");
				numEvento = cstmt.getInt(8);
				cat.debug("numEvento[" + numEvento + "]");
			
				if (codError != 0) {
					cat.error("Ocurrió un error al recuperar la bolsa de servicios");
					throw new TOLException("Ha ocurrido un error al setear las unidades libres [setFreeUnitStock]", String.valueOf(codError), numEvento, msgError);
				}
				cat.debug("--------------------------fin abo");
			}
			
			cat.debug(" Finalizo ejecución");
			cat.info("setFreeUnitStock:end");
			cat.debug("-----------------------------fin setFreeUnitStock");
			return true;
						
		} catch (TOLException e) {
			cat.error("TOLException", e);
			throw e;
			
		} catch (Exception e) {
			cat.error("Ha ocurrido un error al setear las unidades libres",	e);
			cat.debug("Codigo de Error [" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			throw new TOLException("Ha ocurrido un error al setear las unidades libres [setFreeUnitStock]", e);
		} finally {
			cat.debug("Cerrando conexiones...");
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
			} catch (Exception e) {
				cat.debug("SQLException[" + e + "]");
			}
		}		
					
	}
	
	/**
	 * Actualiza los atributos de los servicios suplementarios 
	 * @param dto
	 * @return
	 * @throws TOLException
	 */
	public void uninstallServiceBundle(ProductListDTO prodList) throws TOLException{
		if (cat.isDebugEnabled()) {
			cat.debug("uninstallServiceBundle():start");
		}
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ProductDTO[] productos = null;

		Connection conn = null;
		try {
			//conn = getConnectionFromWLSInitialContext(global.getJndiTOLForDataSource());
			conn = getConnectionDAO("jndi.tol25.tol.tol.dataSource");
		} catch (Exception e1) {
			cat.error(" No se pudo obtener una conexión ", e1);
			throw new TOLException("No se pudo obtener una conexión", e1);
		}

		try {
			String call = getSQLUninstallServiceBundle();

			if (cat.isDebugEnabled()) {
				cat.debug("sql[" + call + "]");
			}

			CallableStatement cstmt = conn.prepareCall(call);
			
			if (cat.isDebugEnabled()) {
				cat.debug("Registrando Entradas");
				cat.debug("Id de Cliente[" + prodList.getCustomer().getCode() + "]");
				cat.debug("numero Abonado[" + prodList.getCustomer().getAbonado().getNum_abonado() + "]");
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

			if ( productos != null ){
				cat.debug("Elementos[" + productos.length + "]");
				for (int i = 0; i < productos.length; i++) {
					String serviceId = productos[i].getId(); 
					String desbordeId = productos[i].getExceedId();
					String prioridadId = productos[i].getPriority();
					cat.debug("Iteracion[" + i + "]");
					cat.debug("cod_plan[" + productos[i].getCodPlan() + "]");
					cat.debug("serviceId[" + serviceId + "]");
					cat.debug("prioridadId[" + prioridadId + "]");				
					cat.debug("desbordeId[" + desbordeId + "]");
	
					cstmt.setString(3, productos[i].getCodPlan());
					cstmt.setString(4, serviceId);
					//cstmt.setLong(5, Long.parseLong(prioridadId));				
					//cstmt.setString(6, desbordeId);
	
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
						cat.error("Ocurrió un error al actualizar los atributos");
						throw new TOLException("Ocurrió un error al actualizar los atributos [uninstallServiceBundle]", String.valueOf(codError), numEvento, msgError);
					}				
				}
				
				if (cat.isDebugEnabled()) {
					cat.debug(" Finalizo ejecución");
					cat.debug(" Recuperando salidas");
				}
			}

		} catch (TOLException e) {
			cat.debug("TOLException");
			String log = StackTraceUtl.getStackTrace(e);
			cat.debug("log error[" + log + "]");
			throw e;
			
		} catch (Exception e) {
			cat.error("Ocurrió un error general al actualizar los atributos", e);
			
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new TOLException("Ocurrió un error general al actualizar los atributos [uninstallServiceBundle]", e);
			
		} finally {
			cat.debug("Cerrando conexiones...");
			try {
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				cat.debug("SQLException", e);
			}
		}

		if (cat.isDebugEnabled()) {
			cat.debug("uninstallServiceBundle():end");
		}
	}

	private String getSQLvalidServiceBundleAttributes() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   EO_sbas_ss TOL_sbas_ss_qt:= TOL_INICIA_ESTRUCTURAS_SB_PG.TOL_Inicia_TOL_SBas_SS_QT_FN;");
		call.append(" BEGIN ");
		call.append("   EO_sbas_ss.cod_cliente := ?;");
		call.append("   TOL_ServSupl_SB_PG.tol_obtiene_fec_term_ciclo_pr( EO_sbas_ss, ?, ?, ?);");
		call.append("   ? := EO_sbas_ss.fec_hasta;");
		call.append("   ? := EO_sbas_ss.cod_ciclo;");
		call.append("   ? := EO_sbas_ss.fec_tasa;");
		call.append(" END;");
		return call.toString();		
	}
	
	public void validServiceBundleAttributes(ProductListDTO prodList) throws TOLException
	{
		cat.debug("validServiceBundleAttributes():start");

		int codError = 0;
		String msgError = null;
		int numEvento = 0;

		Connection conn = null;
		try {
			//conn = getConnectionFromWLSInitialContext(global.getJndiTOLForDataSource());
			conn = getConnectionDAO("jndi.tol25.tol.tol.dataSource");
		} catch (Exception e1) {
			cat.error(" No se pudo obtener una conexión ", e1);
			throw new TOLException("No se pudo obtener una conexión", e1);
		}

		try {
			String call = getSQLvalidServiceBundleAttributes();

			cat.debug("sql[" + call + "]");

			CallableStatement cstmt = conn.prepareCall(call);
			
			if (cat.isDebugEnabled()) {
				cat.debug("Registrando Entradas");
				cat.debug("Id de Cliente[" + prodList.getCustomer().getCode() + "]");
			}			

			cstmt.setLong(1, prodList.getCustomer().getCode());
			cat.debug(" Registrando salidas");
		
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			
			cstmt.registerOutParameter(5, java.sql.Types.DATE);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);

			cat.debug(" Iniciando Ejecución");

			cat.debug("Execute Antes");
			cstmt.execute();
			cat.debug("Execute Despues");

				
			codError = cstmt.getInt(2);
			cat.debug("codError[" + codError + "]");
			
			if (codError != 0) {
				cat.error("Ocurrió un error al actualizar los atributos");
				throw new TOLException("Ocurrió un error al actualizar los atributos [setServiceBundleAttributes]", String.valueOf(codError), numEvento, msgError);
			}			
			
			msgError = cstmt.getString(3);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(4);
			cat.debug("numEvento[" + numEvento + "]");
			
			prodList.setFec_hasta(cstmt.getDate(5));
			prodList.setCod_cliclo(cstmt.getLong(6));
			prodList.setFec_tasa(cstmt.getString(7));
			
			cat.debug(" Finalizo ejecución");


		} catch (TOLException e) {
			cat.debug("TOLException", e);
			throw e;
			
		} catch (Exception e) {
			cat.error("Ocurrió un error general al actualizar los atributos", e);
			throw new TOLException("Ocurrió un error general al actualizar los atributos [setServiceBundleAttributes]", e);
			
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

		cat.debug("validServiceBundleAttributes():end");
	}		
	
	


	private String getSQLModificaLimiteTOL() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append(" BEGIN ");
		call.append("   TOL_LIMITE_CLIABO_PG.tol_borra_pr( ?, ?, ?, ?, ?, ?, ?, ?, ?);");
		call.append(" END;");
		return call.toString();		
	}
	
	public void modificaLimiteTOL(ProductListDTO prodList) throws TOLException
	{
		cat.debug("modificaLimiteTOL():start");

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ProductDTO[] productos = null;

		Connection conn = null;
		try {
			//conn = getConnectionFromWLSInitialContext(global.getJndiTOLForDataSource());
			conn = getConnectionDAO("jndi.tol25.tol.tol.dataSource");
		} catch (Exception e1) {
			cat.error(" No se pudo obtener una conexión ", e1);
			throw new TOLException("No se pudo obtener una conexión", e1);
		}

		try {
			String call = getSQLModificaLimiteTOL();

			cat.debug("sql[" + call + "]");

			CallableStatement cstmt = conn.prepareCall(call);
			
			if (cat.isDebugEnabled()) {
				cat.debug("Registrando Entradas");
				cat.debug("Id de Cliente[" + prodList.getCustomer().getCode() + "]");
				cat.debug("numero Abonado[" + prodList.getCustomer().getAbonado().getNum_abonado() + "]");
				cat.debug("prodList.isAciclo[" + prodList.isAciclo() + "]");
			}			

			cstmt.setLong(1, prodList.getCustomer().getCode());
			cstmt.setLong(2, prodList.getCustomer().getAbonado().getNum_abonado());
			
			cstmt.setLong(5, prodList.getCod_cliclo());
			cstmt.setString(6, prodList.getFec_tasa());


			cat.debug(" Registrando salidas");
		
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);

			cat.debug(" Iniciando Ejecución");
			
			productos = prodList.getProducts();

			cat.debug("Elementos[" + productos.length + "]");
			for (int i = 0; i < productos.length; i++) {
				String serviceId = productos[i].getProfileId(); 
				
				cat.debug("Iteracion[" + i + "]");
				cat.debug("serviceId[" + serviceId + "]");
				cat.debug("cod_plan[" + productos[i].getCodPlan() + "]");


				cstmt.setString(3, serviceId);
				cstmt.setString(4, productos[i].getCodPlan());
				
				cat.debug("Execute Antes");
				cstmt.execute();
				cat.debug("Execute Despues");
				
				codError = cstmt.getInt(7);
				cat.debug("codError[" + codError + "]");
				msgError = cstmt.getString(8);
				cat.debug("msgError[" + msgError + "]");
				numEvento = cstmt.getInt(9);
				cat.debug("numEvento[" + numEvento + "]");		
				
				if (codError != 0) {
					cat.error("Ocurrió un error al actualizar los atributos en tol");
					throw new TOLException("Ocurrió un error al actualizar los atributos [modificaLimiteTOL]", String.valueOf(codError), numEvento, msgError);
				}				
			}
			
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
			// Recuperacion de valores de salida

		} catch (TOLException e) {
			cat.debug("TOLException");
			String log = StackTraceUtl.getStackTrace(e);
			cat.debug("log error[" + log + "]");
			throw e;
			
		} catch (Exception e) {
			cat.error("Ocurrió un error general al actualizar los atributos", e);
			
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new TOLException("Ocurrió un error general al actualizar los atributos [setServiceBundleAttributes]", e);
			
		} finally {
			cat.debug("Cerrando conexiones...");
			try {
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				cat.debug("SQLException", e);
			}
		}

		cat.debug("modificaLimiteTOL():end");
	}
	
	private String getSQLcreateServiceBundleAttributes() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   EO_sbas_ss TOL_sbas_ss_qt:= TOL_INICIA_ESTRUCTURAS_SB_PG.TOL_Inicia_TOL_SBas_SS_QT_FN;");
		call.append("   SN_COD_RETORNO NUMBER;");
		call.append("   SV_MENS_RETORNO VARCHAR2(200);");
		call.append("   SN_NUM_EVENTO NUMBER;");
		call.append(" BEGIN ");
		call.append("   EO_sbas_ss.COD_CLIENTE := ?;");
		call.append("   EO_sbas_ss.num_abonado  := ?;");
		call.append("   EO_sbas_ss.cod_plan  := ?;");
		call.append("   EO_sbas_ss.COD_SERV := ?;");		
		call.append("   EO_sbas_ss.ind_prioridad := ?;");		
		call.append("   EO_sbas_ss.ind_desborde := ?;");
        call.append("   EO_sbas_ss.aciclo  := ?;");
		call.append("   SN_COD_RETORNO := NULL;");
		call.append("   SV_MENS_RETORNO := NULL;");
		call.append("   SN_NUM_EVENTO := NULL;");
		call.append("   TOL_ServSupl_SB_PG.tol_agrega_atributos_ss_pr( EO_sbas_ss, ?, ?, ?);");
		call.append(" END;");
		return call.toString();		
	}	
	
	public void createServiceBundleAttributes(ProductListDTO prodList) throws TOLException
	{
		cat.debug("createServiceBundleAttributes():start");

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ProductDTO[] productos = null;

		Connection conn = null;
		try {
			//conn = getConnectionFromWLSInitialContext(global.getJndiTOLForDataSource());
			conn = getConnectionDAO("jndi.tol25.tol.tol.dataSource");
		} catch (Exception e1) {
			cat.error(" No se pudo obtener una conexión ", e1);
			throw new TOLException("No se pudo obtener una conexión", e1);
		}

		try {
			String call = getSQLcreateServiceBundleAttributes();

			cat.debug("sql[" + call + "]");

			CallableStatement cstmt = conn.prepareCall(call);
			
			if (cat.isDebugEnabled()) {
				cat.debug("Registrando Entradas");
				cat.debug("Id de Cliente[" + prodList.getCustomer().getCode() + "]");
				cat.debug("numero Abonado[" + prodList.getCustomer().getAbonado().getNum_abonado() + "]");
				cat.debug("prodList.isAciclo[" + prodList.isAciclo() + "]");
			}			

			cstmt.setLong(1, prodList.getCustomer().getCode());
			cstmt.setLong(2, prodList.getCustomer().getAbonado().getNum_abonado());
			cstmt.setInt(7, iif(prodList.isAciclo()));


			cat.debug(" Registrando salidas");
		
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);

			cat.debug(" Iniciando Ejecución");
			
			productos = prodList.getProducts();

			cat.debug("Elementos[" + productos.length + "]");
			for (int i = 0; i < productos.length; i++) {
				String serviceId = productos[i].getId(); 
				String desbordeId = productos[i].getExceedId();
				String prioridadId = productos[i].getPriority();
				cat.debug("Iteracion[" + i + "]");
				cat.debug("cod_plan[" + productos[i].getCodPlan() + "]");
				cat.debug("serviceId[" + serviceId + "]");
				cat.debug("prioridadId[" + prioridadId + "]");				
				cat.debug("desbordeId[" + desbordeId + "]");

				cstmt.setString(3, productos[i].getCodPlan());
				cstmt.setString(4, serviceId);
				cstmt.setLong(5, Long.parseLong(prioridadId));				
				cstmt.setString(6, desbordeId);

				cat.debug("Execute Antes");
				cstmt.execute();
				cat.debug("Execute Despues");
				
				codError = cstmt.getInt(8);
				cat.debug("codError[" + codError + "]");
				msgError = cstmt.getString(9);
				cat.debug("msgError[" + msgError + "]");
				numEvento = cstmt.getInt(10);
				cat.debug("numEvento[" + numEvento + "]");		
				
				if (codError != 0) {
					cat.error("Ocurrió un error al actualizar los atributos");
					throw new TOLException("Ocurrió un error al actualizar los atributos [setServiceBundleAttributes]", String.valueOf(codError), numEvento, msgError);
				}				
			}
			
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
			// Recuperacion de valores de salida

		} catch (TOLException e) {
			cat.debug("TOLException");
			String log = StackTraceUtl.getStackTrace(e);
			cat.debug("log error[" + log + "]");
			throw e;
			
		} catch (Exception e) {
			cat.error("Ocurrió un error general al actualizar los atributos", e);
			
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new TOLException("Ocurrió un error general al actualizar los atributos [setServiceBundleAttributes]", e);
			
		} finally {
			cat.debug("Cerrando conexiones...");
			try {
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				cat.debug("SQLException", e);
			}
		}

		cat.debug("createServiceBundleAttributes():end");
	}
	
	private int iif(boolean b)
	{
		int ret = 0;	//inmediato
		if(b)
			ret = 1;	//aciclo
		return ret;
	}
	
	private String getSQLgetServiceLimitProfileValue() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   SO_OBTMONTOLC TOL_LC_QT:= TOL_INICIA_ESTRUCTURAS_SB_PG.TOL_INICIA_TOL_LC_QT_FN;");
		call.append(" BEGIN ");
		call.append("   SO_OBTMONTOLC.cod_cliente := ?;");
		call.append("   SO_OBTMONTOLC.num_abonado := ?;");
		call.append("   SO_OBTMONTOLC.cod_limcons := ?;");
		call.append("   SO_OBTMONTOLC.cod_plan := ?;");
		call.append("   TOL_LC_SB_PG.TOL_OBTIENE_MONTO_Y_MINIMO_PR ( SO_OBTMONTOLC, ?, ?, ?);");
		call.append("   ? := SO_OBTMONTOLC.MTO_LIMITE;");
		call.append("   ? := SO_OBTMONTOLC.MIN_LC;");
		call.append(" END;");
		return call.toString();		
	}
	
	public LimiteClienteDTO getServiceLimitProfileValue(LimiteClienteDTO dto) throws TOLException
	{
		cat.info("getServiceLimitProfileValue:star");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		int i = 0;

		Connection conn = null;
		try {
			//conn = getConnectionFromWLSInitialContext(global.getJndiTOLForDataSource());
			conn = getConnectionDAO("jndi.tol25.tol.tol.dataSource");
		} catch (Exception e1) {
			cat.error(" No se pudo obtener una conexión ", e1);
			throw new TOLException("No se pudo obtener una conexión", e1);
		}

		try {
			String call = getSQLgetServiceLimitProfileValue();
			cat.debug("sql[" + call + "]");

			CallableStatement cstmt = conn.prepareCall(call);

			cat.debug("Registrando Entradas");			
			
			cstmt.setLong(1, dto.getCod_cliente());
			cstmt.setLong(2, dto.getNum_abonado());
			
			LimiteConsumoDTO[] limites = new LimiteConsumoDTO[dto.getLimites().length];
			int j = 0;
			for (i=0; i< dto.getLimites().length; i++){
				 
				
							
				cat.debug("Iteracion " + i);
				cat.debug("getCod_cliente() ["+dto.getCod_cliente()+"]");
				cat.debug("getNum_abonado() ["+dto.getNum_abonado()+"]");
				cat.debug("getProfileId() ["+dto.getLimites()[i].getProfileId()+"]");
				cat.debug("getcod_plan() ["+dto.getLimites()[i].getCod_plan()+"]");
				if(dto.getLimites()[i].getProfileId() == null || dto.getLimites()[i].getProfileId().trim().equals(""))
				{
					cat.debug("No se invocará el procedimiento, ya que no existe limite de consulo asociado");
				}else{				
				
					LimiteConsumoDTO limite = new LimiteConsumoDTO();
					cstmt.setString(4,dto.getLimites()[i].getCod_plan() );
				
					cat.debug("Registrando salidas");
					cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
					cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
					cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
					cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);
	
					cat.debug(" Iniciando Ejecución");
						
					cstmt.setString(3,dto.getLimites()[i].getProfileId() );
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
						cat.error("Al consultar los montos minimos y maximos del abonado");
						throw new TOLException("Al consultar los montos minimos y maximos del abonado [getServiceLimitProfileValue]", String.valueOf(codError), numEvento, msgError);
					}
					
					limite.setCod_servicio(dto.getLimites()[i].getProfileId());
					limite.setMto_pago(cstmt.getInt(8));
					limite.setMin_lc(cstmt.getInt(9));
					limites[j] = limite; 
					//limites[i] = limite;
					
					cat.debug("dto.getLimites()[i].getProfileId() ["+dto.getLimites()[i].getProfileId()+"]");
					cat.debug("limite.setMto_pago ["+cstmt.getInt(8)+"]");
					cat.debug("limite.setMin_lc ["+cstmt.getInt(9)+"]");
					j++;
				}								
			}
			
			dto.setLimites(limites);
			
			cat.info("getServiceLimitProfileValue:end");
			return dto;
						
		} catch (TOLException e) {
			cat.error("TOLException", e);
			throw e;
			
		} catch (Exception e) {
			cat.error("Al consultar los montos minimos y maximos del abonado",	e);
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error: " + msgError + "]");
			cat.debug("Numero de Evento: " + numEvento + "]");

			throw new TOLException("Al consultar los montos minimos y maximos del abonado [getServiceLimitProfileValue]", e);
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
	}
}