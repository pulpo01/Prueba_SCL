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
 * 14/05/2007     Héctor Hermosilla      					Versión Inicial
 */
package com.tmmas.cl.scl.productdomain.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.ProductDomainException;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.TOLException;
import com.tmmas.cl.scl.productdomain.businessobject.dto.BolsaAbonadoDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.CustomerAccountDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.DistribucionBolsaDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.EstadoSolicitudDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.FreeUnitStockDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.LimiteClienteDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.LimiteConsumoDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.PlanTarifarioDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.ProductDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.ProductListDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.SolicitudVentaDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.TipoPrestacionDTO;
import com.tmmas.cl.scl.productdomain.businessobject.helper.Global;

public class DistribucionBolsaDAO extends ConnectionDAO{
	
	private static Category cat = Category.getInstance(DistribucionBolsaDAO.class);
	Global global = Global.getInstance();
	
	private Connection getConection() 
		throws ProductDomainException 
	{
		Connection conn = null;
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
		} catch (Exception e1) {
			conn = null;
			cat.error(" No se pudo obtener una conexión ", e1);
			throw new ProductDomainException("No se pudo obtener una conexión", e1);
		}
		return conn;
	}//fin getConection
	
	private Connection getConectionTol() 
		throws ProductDomainException 
	{
		Connection conn = null;
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSourceTol());
		} catch (Exception e1) {
			conn = null;
			cat.error(" No se pudo obtener una conexión ", e1);
			throw new ProductDomainException("No se pudo obtener una conexión", e1);
		}
		return conn;
	}//fin getConectionTol
	
	private String getSQLDatos(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
        for (int n = 1; n <= paramCount; n++) {
            sb.append("?");
            if (n < paramCount) sb.append(",");
        }
        return sb.append(")}").toString();
	}//fin getSQLDatos
	
	public DistribucionBolsaDTO obtenerDatosBolsa(String codPlanTarif) 
		throws ProductDomainException
	{
		cat.debug("Inicio:obtenerDatosBolsa()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		DistribucionBolsaDTO resultado = new DistribucionBolsaDTO();
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();		
		cat.debug("Conexion obtenida OK");
		
		try {
			
		   String call = getSQLDatos("GA_Distribucion_Bolsa_Pg", "VE_obtiene_datos_Bolsa_PR",9);
		   cat.debug("sql[" + call + "]");
		   
		   cstmt = conn.prepareCall(call);
		   
		   cat.debug("codPlanTarif:" + codPlanTarif);
		   cstmt.setString(1,codPlanTarif);
		   
		   cstmt.registerOutParameter(2,java.sql.Types.VARCHAR); //des_plantarif
		   cstmt.registerOutParameter(3,java.sql.Types.VARCHAR); //cod_bolsa
		   cstmt.registerOutParameter(4,java.sql.Types.VARCHAR); //glosa_parametro
		   cstmt.registerOutParameter(5,java.sql.Types.NUMERIC); //cantidad_bolsa
		   cstmt.registerOutParameter(6,java.sql.Types.VARCHAR); //tipo_unidad
		   
		   cstmt.registerOutParameter(7,java.sql.Types.NUMERIC);
		   cstmt.registerOutParameter(8,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(9,java.sql.Types.NUMERIC);
		   
		   cat.debug("obtenerDatosBolsa:Execute Antes"); 		   
		   cstmt.execute();		  
		   cat.debug("obtenerDatosBolsa:Execute Despues");
		   
		   codError = cstmt.getInt(7);
		   msgError = cstmt.getString(8);
		   numEvento = cstmt.getInt(9);
		 
		   cat.debug("codError[" + codError + "]");
		   cat.debug("msgError[" + msgError + "]");
		   cat.debug("numEvento[" + numEvento + "]");
		   
		   if (codError!=0) 
		   {   		    
			    cat.error("Ocurrió un error al recuperar la distribuicion de bolsa ");
			    throw new ProductDomainException("Ocurrió un error al recuperar la distribucion de bolsa", 
			    		String.valueOf(codError), numEvento, msgError);
		    
			}else{
				resultado.setDes_planTarif(cstmt.getString(2));
				cat.debug("desPlanTarif:" + resultado.getDes_planTarif());
				resultado.setCod_bolsa(cstmt.getString(3));
				cat.debug("codBolsa:" + resultado.getCod_bolsa());
				resultado.setGlosa_Parametro(cstmt.getString(4));
				cat.debug("glosaParametro:" + resultado.getGlosa_Parametro());
				resultado.setCantidad_bolsa(cstmt.getLong(5));
				cat.debug("cantidadBolsa:" + resultado.getCantidad_bolsa());
				resultado.setInd_unidad(cstmt.getString(6));
				cat.debug("indUnidad:" + resultado.getInd_unidad());				
			}
		   
		   if (cat.isDebugEnabled())
		    cat.debug(" Finalizo ejecución");
		  } 
		  catch (Exception e) {
			   cat.error("Ocurrió un error al obtener la distribucion de bolsa",e);
			   if (cat.isDebugEnabled()) {
			    cat.debug("Codigo de Error[" + codError + "]");
			    cat.debug("Mensaje de Error[" + msgError + "]");
			    cat.debug("Numero de Evento[" + numEvento + "]");
			   }
			   if (e instanceof ProductDomainException){
				  throw (ProductDomainException) e;
			   }
		  } 
		  finally {
		    if (cat.isDebugEnabled()) 
		    cat.debug("Cerrando conexiones...");
			   try {				   
				   if (cstmt != null) {
						cstmt.close();
				   }
				   if (!conn.isClosed()) {
				     conn.close();
				   }
			   } catch (SQLException e) {
			    cat.debug("SQLException", e);
			   }
		  }
		  cat.debug("obtenerDatosBolsa():end");
		return resultado;
	}//fin obtenerDatosBolsa
	
	
	public TipoPrestacionDTO validarPlanDist(Long codCliente)
		throws ProductDomainException
	{
		cat.debug("Inicio:validarPlanDist()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		TipoPrestacionDTO resultado = new TipoPrestacionDTO();
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();		
		cat.debug("Conexion obtenida OK");
		
		try {
			
		   String call = getSQLDatos("GA_Distribucion_Bolsa_Pg", "VE_validaPlan_Dist_PR",6);
		   cat.debug("sql[" + call + "]");
		   
		   cstmt = conn.prepareCall(call);
		   
		   cat.debug("codCliente:" + codCliente);
		   cstmt.setLong(1,codCliente.longValue());
		   
		   cstmt.registerOutParameter(2,java.sql.Types.VARCHAR); //cod_plantarif
		   cstmt.registerOutParameter(3,java.sql.Types.VARCHAR); //cod_prestacion		  
		   
		   cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);
		   cstmt.registerOutParameter(5,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(6,java.sql.Types.NUMERIC);
		   
		   cat.debug("validarPlanDist:Execute Antes"); 		   
		   cstmt.execute();		  
		   cat.debug("validarPlanDist:Execute Despues");
		   
		   codError = cstmt.getInt(4);
		   msgError = cstmt.getString(5);
		   numEvento = cstmt.getInt(6);
		 
		   cat.debug("codError[" + codError + "]");
		   cat.debug("msgError[" + msgError + "]");
		   cat.debug("numEvento[" + numEvento + "]");
		   
		   if (codError!=0) 
		   {   		    
			    cat.error("Ocurrió un error al validar el plan distribuido ");
			    throw new ProductDomainException("Ocurrió un error al validar el plan distribuido", 
			    		String.valueOf(codError), numEvento, msgError);
		    
			}else{
				resultado.setCodPlantarifDefecto(cstmt.getString(2));
				cat.debug("codPlanTarif:" + resultado.getCodPlantarifDefecto());
				resultado.setCodPrestacion(cstmt.getString(3));
				cat.debug("codPrestacion:" + resultado.getCodPrestacion());			
			}
		   
		   if (cat.isDebugEnabled())
		    cat.debug(" Finalizo ejecución");
		  } 
		  catch (Exception e) {
			   cat.error("Ocurrió un error al validar el plan distribuido",e);
			   if (cat.isDebugEnabled()) {
			    cat.debug("Codigo de Error[" + codError + "]");
			    cat.debug("Mensaje de Error[" + msgError + "]");
			    cat.debug("Numero de Evento[" + numEvento + "]");
			   }
			   if (e instanceof ProductDomainException){
				  throw (ProductDomainException) e;
			   }
		  } 
		  finally {
		    if (cat.isDebugEnabled()) 
		    cat.debug("Cerrando conexiones...");
			   try {				   
				   if (cstmt != null) {
						cstmt.close();
				   }
				   if (!conn.isClosed()) {
				     conn.close();
				   }
			   } catch (SQLException e) {
			    cat.debug("SQLException", e);
			   }
		  }
		  cat.debug("validarPlanDist():end");
		return resultado;
	}//fin validarPlanDist

	
	/**
	 * Metodos de TOL
	 */
	
	public void createFreeUnitStock(FreeUnitStockDTO[] list) 
		throws TOLException
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
        call.append("   SO_actdist.prc_unidad := ?;");
        call.append("   SO_actdist.cnt_unidad := ?;");
        call.append("   SO_actdist.ind_venta := ?;");                        
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
		call.append("   TOL_BOLSA_SB_PG.TOL_OBTEN_DISTR_PR( SO_OBTDIST, ?, ?, ?, ?);");
		call.append(" END;");
		return call.toString();			
	}		
	
	public void installServiceBundle(ProductListDTO prodList) 
		throws TOLException 
	{
		cat.debug("installServiceBundle():start");

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		
		
		Connection conn = null;
		try {
			conn = getConectionTol();
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
	
	

	

	public void createStorageAndFreeUnitStock(DistribucionBolsaDTO dto) 
		throws TOLException
	{
		cat.info("createStorageAndFreeUnitStock:star");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		

		Connection conn = null;
		try {
			conn = getConectionTol();
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
               
	public void createStorageFreeUnitStock(DistribucionBolsaDTO dto) 
		throws TOLException
	{
		cat.info("createStorageFreeUnitStock:star");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		

		Connection conn = null;
		try {
			conn = getConectionTol();
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
	
	public void deleteStorageFreeUnitStock(DistribucionBolsaDTO dto) 
		throws TOLException
	{
		cat.info("deleteStorageFreeUnitStock:star");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;

		Connection conn = null;
		try {
			conn = getConectionTol();
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
	
	
	public void deleteFreeUnitStock(DistribucionBolsaDTO dto) 
		throws TOLException
	{
		cat.info("deleteFreeUnitStock:star");

		int codError = 0;
		String msgError = null;
		int numEvento = 0;

		Connection conn = null;
		try {
			conn = getConectionTol();
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
	
	public BolsaAbonadoDTO[] getFreeUnitStock(CustomerAccountDTO dto)
		throws TOLException
	{
		cat.info("getFreeUnitStock:star");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		BolsaAbonadoDTO[] ArregloBolsaAbonado = new BolsaAbonadoDTO[]{};
		BolsaAbonadoDTO bolsaAboando = null;

		Connection conn = null;
		try {
			conn = getConectionTol();
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
		
			cat.debug("Registrando salidas");
			cstmt.registerOutParameter(2, oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cat.debug(" Iniciando Ejecución");
					
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
				cat.error("Ocurrió un error al recuperar las unidades libres");
				throw new TOLException("Ocurrió un error al recuperar las unidades libres [getFreeUnitStock]", String.valueOf(codError), numEvento, msgError);
			}		
			cat.debug("antes de ResultSet cstmt.getObject(2)");			
			ResultSet rs = (ResultSet) cstmt.getObject(2);
			cat.debug("despues de ResultSet cstmt.getObject(2)");
			
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
	
	public boolean setFreeUnitStock(DistribucionBolsaDTO dto) 
		throws TOLException
	{
		cat.info("setFreeUnitStock:star");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		int i=0;

		Connection conn = null;
		try {
			conn = getConectionTol();
		} catch (Exception e1) {
			cat.error(" No se pudo obtener una conexión ", e1);
			throw new TOLException("No se pudo obtener una conexión", e1);
		}
		try {
			String call = getSQLsetFreeUnitStock();

			cat.debug("sql[" + call + "]");

			CallableStatement cstmt = conn.prepareCall(call);

			cat.debug("Registrando Entradas");			
			cat.debug("dto.getCod_cliente()" + dto.getCod_cliente());
			
			cstmt.setLong(1,dto.getCod_cliente());
			
			cat.debug("Cantidad de Abonados ["+dto.getBolsa().length+"]");
			for (i=0; i< dto.getBolsa().length; i++){
							
				cat.debug("Iteracion:" + i);
				cat.debug("Num_abonado ["+dto.getBolsa()[i].getNum_abonado()+"]");
				cat.debug("Prc_unidad ["+dto.getBolsa()[i].getPrc_unidad()+"]");
				cat.debug("Cnt_unidad ["+dto.getBolsa()[i].getCnt_unidad()+"]");
				cat.debug("ind_venta ["+dto.getBolsa()[i].getInd_venta()+"]");
				
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
				
				codError = cstmt.getInt(6);
				cat.debug("codError[" + codError + "]");
				msgError = cstmt.getString(7);
				cat.debug("msgError[" + msgError + "]");
				numEvento = cstmt.getInt(8);
				cat.debug("numEvento[" + numEvento + "]");		
			
				if (codError != 0) {
					cat.error("Ocurrió un error al recuperar la bolsa de servicios");
					throw new TOLException("A courrido un error al setiar las unidades libres [setFreeUnitStock]", String.valueOf(codError), numEvento, msgError);
				}
			}
			
			cat.debug(" Finalizo ejecución");
			cat.info("setFreeUnitStock:end");
			return true;
						
		} catch (TOLException e) {
			cat.error("TOLException", e);
			throw e;
			
		} catch (Exception e) {
			cat.error("A courrido un error al setiar las unidades libres",	e);
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error: " + msgError + "]");
			cat.debug("Numero de Evento: " + numEvento + "]");

			throw new TOLException("A courrido un error al setiar las unidades libres [setFreeUnitStock]", e);
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
	
	/**
	 * Actualiza los atributos de los servicios suplementarios 
	 * @param dto
	 * @return
	 * @throws TOLException
	 */
	public void uninstallServiceBundle(ProductListDTO prodList)
		throws TOLException
	{
		if (cat.isDebugEnabled()) {
			cat.debug("uninstallServiceBundle():start");
		}
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ProductDTO[] productos = null;

		Connection conn = null;
		try {
			conn = getConectionTol();
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
	
	public void validServiceBundleAttributes(ProductListDTO prodList) 
		throws TOLException
	{
		cat.debug("validServiceBundleAttributes():start");

		int codError = 0;
		String msgError = null;
		int numEvento = 0;

		Connection conn = null;
		try {
			conn = getConectionTol();
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
	
	public void modificaLimiteTOL(ProductListDTO prodList)
		throws TOLException
	{
		cat.debug("modificaLimiteTOL():start");

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ProductDTO[] productos = null;

		Connection conn = null;
		try {
			conn = getConectionTol();
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
	
	public void createServiceBundleAttributes(ProductListDTO prodList)
		throws TOLException
	{
		cat.debug("createServiceBundleAttributes():start");

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ProductDTO[] productos = null;

		Connection conn = null;
		try {
			conn = getConectionTol();
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
	
	public LimiteClienteDTO getServiceLimitProfileValue(LimiteClienteDTO dto) 
		throws TOLException
	{
		cat.info("getServiceLimitProfileValue:star");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		int i = 0;

		Connection conn = null;
		try {
			conn = getConectionTol();
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
	
	
	public PlanTarifarioDTO[] obtenerPlanesDistribuidos(Long numVenta) 
		throws ProductDomainException
	{
		cat.debug("Inicio:obtenerPlanesDistribuidos()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;		
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();
		ResultSet rs = null;
		PlanTarifarioDTO[]  resultado = null;
		cat.debug("Conexion obtenida OK");
		
		try {
			
		   String call = getSQLDatos("GA_DISTRIBUCION_BOLSA_PG", "VE_obtienePlan_Dist_PR",5);
		   cat.debug("sql[" + call + "]");
		   
		   cstmt = conn.prepareCall(call);
		   
		   cstmt.setLong(1,numVenta.longValue());
		   cat.debug("numVenta:" + numVenta.longValue());	
		   	
		   cstmt.registerOutParameter(2,OracleTypes.CURSOR);		  		   
		   cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
		   cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);
		     
		   cat.debug("obtenerPlanesDistribuidos:Execute Antes");
		   cstmt.execute();		   
		   cat.debug("obtenerPlanesDistribuidos:Execute Despues");
		   
		   codError = cstmt.getInt(3);
		   msgError = cstmt.getString(4);
		   numEvento = cstmt.getInt(5);
		 
		   cat.debug("codError[" + codError + "]");
		   cat.debug("msgError[" + msgError + "]");
		   cat.debug("numEvento[" + numEvento + "]");
		   
		   if (codError!=0) 
		   {   		    
			    cat.error("Ocurrió un error al recuperar los planes distribuidos ");
			    throw new ProductDomainException("Ocurrió un error al recuperar los planes distribuidos ", 
			    		String.valueOf(codError), numEvento, msgError);
		    
			}else {
				cat.debug("Recuperando listado de estados");
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
		  
				cat.debug("Fin recuperacion listado de planes distribuidos");
			}
		   
		   if (cat.isDebugEnabled())
		    cat.debug(" Finalizo ejecución");
		  } 
		  catch (Exception e) {
			   cat.error("Ocurrió un error al recuperar listado de planes distribuidos",e);
			   if (cat.isDebugEnabled()) {
			    cat.debug("Codigo de Error[" + codError + "]");
			    cat.debug("Mensaje de Error[" + msgError + "]");
			    cat.debug("Numero de Evento[" + numEvento + "]");
			   }
			   if (e instanceof ProductDomainException){
				  throw (ProductDomainException) e;
			   }
		  } 
		  finally {
		    if (cat.isDebugEnabled()) 
		    cat.debug("Cerrando conexiones...");
			   try {
				   if (cstmt != null) {
						cstmt.close();
				   }
				   if (!conn.isClosed()) {
				     conn.close();
				   }
			   } catch (SQLException e) {
			    cat.debug("SQLException", e);
			   }
		  }
		  cat.debug("obtenerPlanesDistribuidos():end");	
		  return resultado;
	}//fin obtenerPlanesDistribuidos

	public PlanTarifarioDTO[] obtenerPlanesDistribuidosAutomaticos(Long numVenta) 
	throws ProductDomainException
	{
		cat.debug("Inicio:obtenerPlanesDistribuidosAutomaticos()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;		
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();
		ResultSet rs = null;
		PlanTarifarioDTO[]  resultado = null;
		cat.debug("Conexion obtenida OK");
		
		try {
			
		   String call = getSQLDatos("GA_DISTRIBUCION_BOLSA_PG", "VE_obtienePlan_Dist_Auto_PR",5);
		   cat.debug("sql[" + call + "]");
		   
		   cstmt = conn.prepareCall(call);
		   
		   cstmt.setLong(1,numVenta.longValue());
		   cat.debug("numVenta:" + numVenta.longValue());	
		   	
		   cstmt.registerOutParameter(2,OracleTypes.CURSOR);		  		   
		   cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
		   cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);
		     
		   cat.debug("obtenerPlanesDistribuidosAutomaticos:Execute Antes");
		   cstmt.execute();		   
		   cat.debug("obtenerPlanesDistribuidosAutomaticos:Execute Despues");
		   
		   codError = cstmt.getInt(3);
		   msgError = cstmt.getString(4);
		   numEvento = cstmt.getInt(5);
		 
		   cat.debug("codError[" + codError + "]");
		   cat.debug("msgError[" + msgError + "]");
		   cat.debug("numEvento[" + numEvento + "]");
		   
		   if (codError!=0) 
		   {   		    
			    cat.error("Ocurrió un error al recuperar los planes distribuidos automaticos");
			    throw new ProductDomainException("Ocurrió un error al recuperar los planes distribuidos automaticos", 
			    		String.valueOf(codError), numEvento, msgError);
		    
			}else {
				cat.debug("Recuperando listado de estados");
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
		  
				cat.debug("Fin recuperacion listado de planes distribuidos automaticos");
			}
		   
		   if (cat.isDebugEnabled())
		    cat.debug(" Finalizo ejecución");
		  } 
		  catch (Exception e) {
			   cat.error("Ocurrió un error al recuperar listado de planes distribuidos automaticos",e);
			   if (cat.isDebugEnabled()) {
			    cat.debug("Codigo de Error[" + codError + "]");
			    cat.debug("Mensaje de Error[" + msgError + "]");
			    cat.debug("Numero de Evento[" + numEvento + "]");
			   }
			   if (e instanceof ProductDomainException){
				  throw (ProductDomainException) e;
			   }
		  } 
		  finally {
		    if (cat.isDebugEnabled()) 
		    cat.debug("Cerrando conexiones...");
			   try {
				   if (cstmt != null) {
						cstmt.close();
				   }
				   if (!conn.isClosed()) {
				     conn.close();
				   }
			   } catch (SQLException e) {
			    cat.debug("SQLException", e);
			   }
		  }
		  cat.debug("obtenerPlanesDistribuidosAutomaticos():end");	
		  return resultado;
	}//fin obtenerPlanesDistribuidosAutomaticos

	
}//fin class DistribucionBolsa
