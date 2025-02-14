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
 * 16/01/2007     H&eacute;ctor Hermosilla      					Versión Inicial
 */

package com.tmmas.cl.scl.customerdomain.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CargoSolicitudDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CausalDescuentoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ListadoCargoSolicitudDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.VendedorDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.helper.Global;


public class CausalDescuentoDAO extends ConnectionDAO{
	private static Category cat = Category.getInstance(CausalDescuentoDAO.class);

	Global global = Global.getInstance();
	
	private Connection getConection() throws CustomerDomainException
	{
		Connection conn = null;
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
		} catch (Exception e1) {
			conn = null;
			cat.error(" No se pudo obtener una conexión ", e1);
			throw new CustomerDomainException("No se pudo obtener una conexión", e1);
		}
		
		return conn;
	}
	
	/*private String getSqlListaCausalDescuento()
	{
		StringBuffer sRet = new StringBuffer();
		sRet.append("SELECT COD_PLANSERV, DES_PLANSERV");
		sRet.append(" FROM GA_PLANSERV");
		sRet.append(" WHERE SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA, SYSDATE)");
		sRet.append(" AND COD_PRODUCTO = 1");
		return sRet.toString();
	}*/
	
	private String getSqlListaCausalDescuento(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
        for (int n = 1; n <= paramCount; n++) {
            sb.append("?");
            if (n < paramCount) sb.append(",");
        }
        return sb.append(")}").toString();
	
	}
	
	
	
	private CausalDescuentoDTO getResultset(ResultSet rs, int i) 
		throws CustomerDomainException
	{
		CausalDescuentoDTO plans = new CausalDescuentoDTO();
		
		try
		{
			if(global.ModoEjecucion().equals("prueba1"))
			{
				plans.setCodigoCausalDescuento("codPlans"+i);
				plans.setDescripcionCausalDescuento("desPlans"+i);
			}
			else
			{
				plans.setCodigoCausalDescuento(rs.getString(1));
				plans.setDescripcionCausalDescuento(rs.getString(2));
			}

		}
		catch(SQLException e)
		{
			throw new CustomerDomainException(global.errorgetListado() +  " [" + i + "]", e);
		}
		
		return plans;
	}

	public CausalDescuentoDTO[] getListadoCausalDescuento(Long codUso)
		throws CustomerDomainException
	{		
		cat.debug("getListadoCausalDescuento:star");
		CausalDescuentoDTO[] resultado=null;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		ResultSet rs = null;
		cat.debug("Coneccion obtenida OK");
		try {
		
			if(global.ModoEjecucion().equals("prueba1"))
			{
				ArrayList lista = new ArrayList();
				for(int i=0;i<=1080;i++)
				{
					CausalDescuentoDTO  CausalDescuento = null;
					CausalDescuento = getResultset(null, i);
					lista.add(CausalDescuento);
				}
				resultado = (CausalDescuentoDTO[])ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), 
							 CausalDescuentoDTO.class);
			}
			else
			{
				String call = getSqlListaCausalDescuento("VE_PARAMETROS_COMERCIALES_PG","VE_causaldescuento_PR",5);
				cat.debug("sql[" + call + "]");
				cstmt = conn.prepareCall(call);
				cat.debug("Execute Antes");
				
				cstmt.setLong(1,codUso.longValue());
				
				cstmt.registerOutParameter(2, OracleTypes.CURSOR);
				cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
				cstmt.execute();
				cat.debug("Execute Despues");
				rs = (ResultSet)cstmt.getObject(2);
				ArrayList lista = new ArrayList();
				while (rs.next()) {
					cat.debug("Procesando iteración :" + lista.size());
					CausalDescuentoDTO CausalDescuento = null;
					CausalDescuento= getResultset(rs, lista.size());
					lista.add(CausalDescuento);
				}
				
				resultado = (CausalDescuentoDTO[])ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(),
							 CausalDescuentoDTO.class);				
			}
		} catch (Exception e) {
			cat.error(global.errorgetListado(), e);
			throw new CustomerDomainException(global.errorgetListado(), e);

		} finally {
		 	if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (rs!=null)
					rs.close();
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}

		cat.debug("getListadoCausalDescuento():end");

		return resultado;
		}
	
	public void actualizarDsctosManuales(CargoSolicitudDTO entrada)
		throws CustomerDomainException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:actualizarDsctosManuales");
			
			String call = getSqlListaCausalDescuento("VE_SERVICIOS_VENTA_PG","VE_Act_MtoDescuento_PR",7);
	
			cat.debug("sql[" + call + "]");
	
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1,entrada.getNumCargo());
			cat.debug("entrada.getNumCargo():" + entrada.getNumCargo());			
			cstmt.setDouble(2,entrada.getMontoTotalDescuento());
			cat.debug("entrada.getMontoTotalDescuento():" + entrada.getMontoTotalDescuento());
			cstmt.setInt(3, entrada.getTipDcto());
			cat.debug("entrada.getTipDcto():" + entrada.getTipDcto());
			cstmt.setLong(4, entrada.getCodConceptoDctoManual());
			cat.debug("entrada.getCodConceptoDctoManual():" + entrada.getCodConceptoDctoManual());
						
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:actualizarDsctosManuales:execute");
			cstmt.execute();
			cat.debug("Fin:actualizarDsctosManuales:execute");
	
			codError = cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento = cstmt.getInt(7);
			
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");
			
			if (codError != 0) {
				cat.error("Ocurrió un error al actualizar el descuento");
				throw new CustomerDomainException(
						"Ocurrió un error al actualizar el descuento", String
								.valueOf(codError), numEvento, msgError);
			}
			
		} catch (Exception e) {
			cat.error("Ocurrió un error al actualizar el descuento",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException ){
		           throw (CustomerDomainException) e;
			   }
		} finally {
		 	if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
	
		cat.debug("Fin:actualizarDsctosManuales");
	
	}//fin actualizarDsctosManuales	
	
	
	
	
}




