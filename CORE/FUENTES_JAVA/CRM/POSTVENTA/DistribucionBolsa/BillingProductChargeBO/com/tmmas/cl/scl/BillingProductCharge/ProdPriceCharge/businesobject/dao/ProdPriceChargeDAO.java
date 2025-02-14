package com.tmmas.cl.scl.BillingProductCharge.ProdPriceCharge.businesobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Category;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.BillingProductCharge.ProdPriceCharge.businesobject.helper.Global;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.CargosRecCliAboDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ProductDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.exception.BillingProductChargeException;


public class ProdPriceChargeDAO extends ConnectionDAO {
	private static Category cat = Category.getInstance(ProdPriceChargeDAO.class);
	Global global = Global.getInstance();
	
	private CompositeConfiguration config;
	
	public ProdPriceChargeDAO() {
		setPropFile();
	}

	private void setPropFile() {
//		 inicio MA
		String strArchivoLog;
		String strRuta = "com/tmmas/cl/Billing/properties/";
		String srtRutaDeploy = System.getProperty("user.dir");
		String strRutaArchivoExterno = srtRutaDeploy + "/" + strRuta + "webservice.Billing.properties";
		System.out.println("strRutaArchivoExterno:"+strRutaArchivoExterno);
		//config = UtilProperty.getConfigurationfromExternalFile(strRutaArchivoExterno);
		config = UtilProperty.getConfiguration(strRutaArchivoExterno,strRutaArchivoExterno);
		System.out.println("config.isEmpty():" + config.isEmpty());
		strArchivoLog = config.getString("billing.bo.log");
		System.out.println("strArchivoLog:"+strRuta+strArchivoLog);
		UtilLog.setLog("/" + strRuta+ strArchivoLog);
		// fin MA	
	}
//	 FIN MA 69363 RRG 04-11-2008
	
	private String getSQLsetUninstallBillingProductCharge() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   SO_cargorecurrente  fa_cargorec_qt := PV_inicia_estructuras_sb_PG.pv_inicia_fa_cargorec_fn;");
		call.append(" BEGIN ");
		call.append("   SO_cargorecurrente.cod_clienteserv := ?;");
		call.append("   SO_cargorecurrente.num_abonadoserv := ?;");
		call.append("   SO_cargorecurrente.cod_servicio := ?;");		
		call.append("   FA_SERVSUPL_SB_PG.FA_DESACTIVAR_SS_PR( SO_cargorecurrente, ?, ?, ?);");
		call.append(" END;");
		return call.toString();		
	}			  
		  
	private String getSQLsetInstallBillingProductCharge() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   SO_cargorecurrente  fa_cargorec_qt := PV_inicia_estructuras_sb_PG.pv_inicia_fa_cargorec_fn;");
		call.append(" BEGIN ");
		call.append("   SO_cargorecurrente.cod_clienteserv := ?;");
		call.append("   SO_cargorecurrente.num_abonadoserv := ?;");
		call.append("   SO_cargorecurrente.cod_clientepago := ?;");
		call.append("   SO_cargorecurrente.num_abonadopago := ?;");
		call.append("   SO_cargorecurrente.cod_servicio := ?;");
		call.append("   FA_SERVSUPL_SB_PG.FA_ACTIVAR_SS_PR( SO_cargorecurrente, ?, ?, ?);");
		call.append(" END;");
		return call.toString();		
	}	

	
	/**
	 * Desactiva los servicios suplementarios 
	 * @param prodList
	 * @throws BillingProductChargeException
	 */	
	public void uninstallBillingProductCharge(CargosRecCliAboDTO prodList) throws BillingProductChargeException
	{
		cat.debug("uninstallBillingProductCharge():start");

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ProductDTO[] productos = null;

		Connection conn = null;
		try {
			conn = getConnectionFromWLSInitialContext(global
					.getJndiForDataSource());
		} catch (Exception e1) {
			cat.error(" No se pudo obtener una conexión ", e1);
			throw new BillingProductChargeException("No se pudo obtener una conexión",
					e1);
		}

		try {
			String call = getSQLsetUninstallBillingProductCharge();
			cat.debug("sql[" + call + "]");

			CallableStatement cstmt = conn.prepareCall(call);

			cat.debug("Registrando Entradas");
			cat.debug("Id de Cliente[" + prodList.getCod_clientepago() + "]");
			cstmt.setLong(1, prodList.getCod_clienteserv());
			cstmt.setLong(2, prodList.getNum_abonadoserv());
			
			cat.debug(" Registrando salidas");

			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

			cat.debug(" Iniciando Ejecución");
			
			productos = prodList.getSsDesactivar();
			if (productos != null ){			
			
				for (int i = 0; i < productos.length; i++) {
					cat.debug("Iteracion[" + i + "]");
					String serviceId = productos[i].getId(); 
					cat.debug("serviceId[" + serviceId + "]");
					cstmt.setString(3, serviceId);
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
						cat.error(" Ocurrio el siguiente error al desactivar el servicio suplementario:" + msgError);
						throw new BillingProductChargeException("Ocurrio el siguiente error al desactivar el servicio suplementario:" + msgError , String.valueOf(codError), numEvento, msgError);
					}
				
				}
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}

		} catch (BillingProductChargeException e) {
			cat.debug("[BillingProductChargeException", e);
			throw e;
			
		} catch (Exception e) {
			cat.error("[Exception]", e);
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");
			throw new BillingProductChargeException("Ocurrió un error general al desactivar servicios suplementarios",e);
		} finally {
			cat.debug("Cerrando conexiones...");
			try {
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (Exception e) {
				cat.debug("[Exception]: Ocurrio un error al cerrar la coneccion", e);
			}
		}

		cat.debug("uninstallBillingProductCharge():end");
	}
	
	

	/**
	 * Activa los servicios suplementarios 
	 * @param prodList
	 * @throws BillingProductChargeException
	 */	
	public void installBillingProductCharge(CargosRecCliAboDTO prodList) throws BillingProductChargeException 
	{
		cat.debug("installBillingProductCharge():start");

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ProductDTO[] productos = null;

		Connection conn = null;
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
		} catch (Exception e1) {
			cat.error(" No se pudo obtener una conexión ", e1);
			throw new BillingProductChargeException("No se pudo obtener una conexión",	e1);
		}

		try {
			String call = getSQLsetInstallBillingProductCharge();

			cat.debug("sql[" + call + "]");

			CallableStatement cstmt = conn.prepareCall(call);

			cat.debug("Registrando Entradas");
			cat.debug("Id de Cliente[" + prodList.getCod_clientepago() + "]");
			
			//Se debe repetir el cod_cliente y el num_abonado ya que representan a cod_clienteserv,
			//cod_clientepago,num_abonadoserv,num_abonadopago respectivamente
			
			cat.debug(" getCod_clienteserv =" + prodList.getCod_clienteserv());
			cat.debug(" getNum_abonadoserv =" + prodList.getNum_abonadoserv());
			cat.debug(" getCod_clientepago =" + prodList.getCod_clientepago());
			cat.debug(" getNum_abonadopago =" + prodList.getNum_abonadopago());
			
			cstmt.setLong(1, prodList.getCod_clienteserv());   //cod_clienteserv
			cstmt.setLong(2, prodList.getNum_abonadoserv());   //num_abonadoserv
			cstmt.setLong(3, prodList.getCod_clientepago()) ;  //cod_clientepago 
			cstmt.setLong(4, prodList.getNum_abonadopago()) ;  //num_abonadopago
			
			cat.debug(" Registrando salidas");
			
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);

			cat.debug(" Iniciando Ejecución");
			productos = prodList.getSsActivar();

			if (productos != null ){
			
				cat.debug("Elementos[" + productos.length + "]");
				for (int i = 0; i < productos.length; i++) {
					cat.debug("Iteracion[" + i + "]");
				
					String serviceId = productos[i].getId(); 
					cat.debug("productos["+ i + "].getId[" + serviceId + "]");					
					cstmt.setString(5, serviceId);				
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
						cat.error(" Ocurrio el siguiente error al activar el Servicio Suplementario");
						throw new BillingProductChargeException("Ocurrio el siguiente error al activar el Servicio Suplementario : " + msgError , String.valueOf(codError), numEvento, msgError);
					}				
				}			
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}

		} catch (BillingProductChargeException e) {
			cat.debug("[BillingProductChargeException]", e);
			throw e;
			
		} catch (Exception e) {
			cat.error("Ocurrio el siguiente error al activar el Servicio Suplementario", e);
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			throw new BillingProductChargeException("Ocurrio el siguiente error al activar el Servicio Suplementario", e);
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

		cat.debug("installBillingProductCharge():end");
	}
	
}
