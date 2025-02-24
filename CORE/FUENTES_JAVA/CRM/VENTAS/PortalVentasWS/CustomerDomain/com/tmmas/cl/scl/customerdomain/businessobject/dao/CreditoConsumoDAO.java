/**
 * Copyright � 2007 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal informaci�n y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 16/01/2007     H&eacute;ctor Hermosilla      					Versi�n Inicial
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
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CreditoConsumoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.helper.Global;


public class CreditoConsumoDAO extends ConnectionDAO{
	private static Category cat = Category.getInstance(CreditoConsumoDAO.class);

	Global global = Global.getInstance();
	
	private Connection getConection() throws CustomerDomainException
	{
		Connection conn = null;
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
		} catch (Exception e1) {
			conn = null;
			cat.error(" No se pudo obtener una conexi�n ", e1);
			throw new CustomerDomainException("No se pudo obtener una conexi�n", e1);
		}
		
		return conn;
	}
	
	private String getSqlListaCreditoConsumo(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
        for (int n = 1; n <= paramCount; n++) {
            sb.append("?");
            if (n < paramCount) sb.append(",");
        }
        return sb.append(")}").toString();
	}
	
	
	private CreditoConsumoDTO getResultset(ResultSet rs, int i) throws CustomerDomainException
	{
		CreditoConsumoDTO plans = new CreditoConsumoDTO();
		
		try
		{
			if(global.ModoEjecucion().equals("prueba1"))
			{
				plans.setCodigoCreditoConsumo("codPlans"+i);
				plans.setDescripcionCreditoConsumo("desPlans"+i);
			}
			else
			{
				plans.setCodigoCreditoConsumo(rs.getString(1));
				plans.setDescripcionCreditoConsumo(rs.getString(2));
			}

		}
		catch(SQLException e)
		{
			throw new CustomerDomainException(global.errorgetListado() +  " [" + i + "]", e);
		}
		
		return plans;
	}

	public CreditoConsumoDTO[] getListadoCreditoConsumo(CreditoConsumoDTO creditoConsumoDTO) 
		throws CustomerDomainException
	{		
		cat.debug("getListadoCreditoConsumo:start");
		CreditoConsumoDTO[] resultado=null;
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
					CreditoConsumoDTO  CreditoConsumo = null;
					CreditoConsumo = getResultset(null, i);
					lista.add(CreditoConsumo);
				}
				resultado = (CreditoConsumoDTO[])ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), 
							CreditoConsumoDTO.class);
			}
			else
			{
				String call = getSqlListaCreditoConsumo("VE_PARAMETROS_COMERCIALES_PG","VE_creditoconsumo_PR",6);
				cat.debug("sql[" + call + "]");
				cstmt = conn.prepareCall(call);
				cat.debug("Execute Antes");
				cstmt.setString(1,creditoConsumoDTO.getCodigoCliente());
				cstmt.setInt(2,creditoConsumoDTO.getCodigoProducto());
				cstmt.registerOutParameter(3, OracleTypes.CURSOR);
				cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

				//ResultSet rs = cstmt.executeQuery();
				cstmt.execute();
				cat.debug("Execute Despues");
				rs = (ResultSet)cstmt.getObject(3);
				ArrayList lista = new ArrayList();
				while (rs.next()) {
					cat.debug("Procesando iteraci�n :" + lista.size());
					CreditoConsumoDTO CreditoConsumo = null;
					CreditoConsumo= getResultset(rs, lista.size());
					lista.add(CreditoConsumo);
				}				
				resultado = (CreditoConsumoDTO[])ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(),
							 CreditoConsumoDTO.class);
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

		cat.debug("getListadoCreditoConsumo():end");

		return resultado;
		}
	}


