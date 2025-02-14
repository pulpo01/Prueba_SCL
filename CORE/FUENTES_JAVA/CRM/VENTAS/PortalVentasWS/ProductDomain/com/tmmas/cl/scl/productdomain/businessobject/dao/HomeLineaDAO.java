package com.tmmas.cl.scl.productdomain.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.HomeLineaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.ProductDomainException;
import com.tmmas.cl.scl.productdomain.businessobject.helper.Global;

public class HomeLineaDAO  extends ConnectionDAO{
	
	private static Category cat = Category.getInstance(HomeLineaDAO.class);
	
	Global global = Global.getInstance();
	
	private Connection getConection() throws ProductDomainException
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
	}
	
	private String getSQLDatos(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
        for (int n = 1; n <= paramCount; n++) {
            sb.append("?");
            if (n < paramCount) sb.append(",");
        }
        return sb.append(")}").toString();
	}
	
	public HomeLineaDTO getHomeLineaCelNumerado(HomeLineaDTO lineaEntrada) 
		throws ProductDomainException
	{
		cat.debug("obtieneHomeLinea:start");
		HomeLineaDTO resultado = new HomeLineaDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			String call = getSQLDatos("AL_Servicios_Almacenes_PG","AL_obtener_homenumerado_pr",12);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,lineaEntrada.getNum_icc());			
			cstmt.setInt(2,lineaEntrada.getCod_vendedor().intValue());			
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR); //cod_subalm
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC); //cod_central
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR); //cod_hlr 
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR); //cod_celda
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR); //cod_region
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR); //cod_provincia
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR); //cod_ciudad
			
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(12, java.sql.Types.NUMERIC);
			
			cstmt.execute();
			
			codError = cstmt.getInt(10);
			msgError = cstmt.getString(11);
			numEvento = cstmt.getInt(12);	
			
			cat.debug("getHomeLineaCelNumerado codError : " + codError);
			cat.debug("getHomeLineaCelNumerado msgError : " + msgError);
			cat.debug("getHomeLineaCelNumerado numEvento : " + numEvento);
			
			cat.debug("msgError[" + msgError + "]");
			
			if (codError != 0)
			{
				cat.error("SIMCARD NO PERTENECE AL HOME DEL VENDEDOR");
				if(msgError == null || msgError.trim().equals("")) msgError = "SIMCARD NO PERTENECE AL HOME DEL VENDEDOR";
				throw new ProductDomainException( String.valueOf(codError), numEvento,msgError);
			} else {	
				resultado.setCod_subAlm(cstmt.getString(3)); //cod_subalm
				resultado.setCod_central(new Long(cstmt.getInt(4))); //cod_central
				resultado.setCod_hlr(cstmt.getString(5)); //cod_hlr 
				resultado.setCod_celda(cstmt.getString(6)); //cod_celda
				resultado.setCod_region(cstmt.getString(7)); //cod_region
				resultado.setCod_provincia(cstmt.getString(8)); //cod_provincia
				resultado.setCod_ciudad(cstmt.getString(9)); //cod_ciudad
			}
			
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		}catch (Exception e) {
			cat.error("Ocurrió un error al validar tipo stock simcard",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof ProductDomainException ) throw (ProductDomainException) e;
		} finally {
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
		cat.debug("obtieneHomeLinea:end");
		return resultado;
	}
	
	public HomeLineaDTO getHomeLineaCelNoNumerado(HomeLineaDTO lineaEntrada)
		throws ProductDomainException
	{
		cat.debug("obtieneHomeLinea:start");
		HomeLineaDTO resultado = new HomeLineaDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			
			//Omite uso de venta cuando la serie es mayorista si cod_uso = 3 (prepago) se reemplaza por pospago
			if(lineaEntrada.getCod_uso() ==3)
			{
				lineaEntrada.setCod_uso(2);
			}
			
			String call = getSQLDatos("VE_intermediario_PG","VE_obtenerhomenonumerado_pr",15);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,lineaEntrada.getNum_icc());
			cstmt.setString(2,lineaEntrada.getCod_actabo());			
			cstmt.setInt(3,lineaEntrada.getCod_uso());			
			cstmt.setInt(4,lineaEntrada.getCod_vendedor().intValue());
			
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC); //num_celular
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR); //cod_subalm
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC); //cod_central
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR); //cod_hlr
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR); //cod_celda
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR); //cod_region
			cstmt.registerOutParameter(11, java.sql.Types.VARCHAR); //cod_provincia
			cstmt.registerOutParameter(12, java.sql.Types.VARCHAR); //cod_ciudad
			
			cstmt.registerOutParameter(13, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(15, java.sql.Types.NUMERIC);
			cstmt.execute();			
			
			codError = cstmt.getInt(13);
			msgError = cstmt.getString(14);
			numEvento = cstmt.getInt(15);
			
			cat.debug("msgError[" + msgError + "]");
			
			if (codError != 0)
			{
				cat.error("SIMCARD NO PERTENECE AL HOME DEL VENDEDOR");
				if(msgError == null || msgError.trim().equals("")) msgError = "SIMCARD NO PERTENECE AL HOME DEL VENDEDOR";
				throw new ProductDomainException( String.valueOf(codError), numEvento,msgError);				
			} else {
				resultado.setNum_celular(new Long(cstmt.getLong(5))); //num_celular				
				resultado.setCod_subAlm(cstmt.getString(6)); //cod_subalm				
				resultado.setCod_central(new Long(cstmt.getInt(7))); //cod_central				
				resultado.setCod_hlr(cstmt.getString(8)); //cod_hlr
				resultado.setCod_celda(cstmt.getString(9)); //cod_celda				
				resultado.setCod_region(cstmt.getString(10)); //cod_region				
				resultado.setCod_provincia(cstmt.getString(11)); //cod_provincia				
				resultado.setCod_ciudad(cstmt.getString(12)); //cod_ciudad				
			}
			
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (Exception e) {			
			cat.error("Ocurrió un error al validar tipo stock simcard",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof ProductDomainException ) throw (ProductDomainException) e;
		} finally {
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
		cat.debug("obtieneHomeLinea:end");
		return resultado;
	}


}
