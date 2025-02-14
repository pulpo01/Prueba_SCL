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
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CreditoMorosidadDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.DatosComercialesDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.helper.Global;


public class CreditoMorosidadDAO extends ConnectionDAO{
	private static Category cat = Category.getInstance(CreditoMorosidadDAO.class);

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
	
	private String getSqlListaCreditoMorosidad(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
        for (int n = 1; n <= paramCount; n++) {
            sb.append("?");
            if (n < paramCount) sb.append(",");
        }
        return sb.append(")}").toString();
	
	}
	
	private CreditoMorosidadDTO getResultset(ResultSet rs, int i) throws CustomerDomainException
	{
		CreditoMorosidadDTO plans = new CreditoMorosidadDTO();
		
		try
		{
			if(global.ModoEjecucion().equals("prueba1"))
			{
				plans.setCodigoCreditoMorosidad("codPlans"+i);
				plans.setDescripcionCreditoMorosidad("desPlans"+i);
			}
			else
			{
				plans.setCodigoCreditoMorosidad(rs.getString(1));
				plans.setDescripcionCreditoMorosidad(rs.getString(2));
			}

		}
		catch(SQLException e)
		{
			throw new CustomerDomainException(global.errorgetListado() +  " [" + i + "]", e);
		}
		
		return plans;
	}

	public CreditoMorosidadDTO[] getListadoCreditoMorosidad(DatosComercialesDTO cabecera)
		throws CustomerDomainException
	{		
		cat.debug("getListadoCreditoMorosidad:star");
		CreditoMorosidadDTO[] resultado=null;
		Connection conn = null;
		conn = getConection();
		cat.debug("Coneccion obtenida OK");
		CallableStatement cstmt = null;
		ResultSet rs = null;
		try {
		
			if(global.ModoEjecucion().equals("prueba1"))
			{
				ArrayList lista = new ArrayList();
				for(int i=0;i<=1080;i++)
				{
					CreditoMorosidadDTO  CreditoMorosidad = null;
					CreditoMorosidad = getResultset(null, i);
					lista.add(CreditoMorosidad);
				}
				resultado =(CreditoMorosidadDTO[])ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), 
							CreditoMorosidadDTO.class);
			}
			else
			{
				String call = getSqlListaCreditoMorosidad("VE_PARAMETROS_COMERCIALES_PG","VE_creditomorosidad_PR",5);
				cat.debug("sql[" + call + "]");
				cstmt = conn.prepareCall(call);
				cat.debug("Execute Antes");
				cstmt.setString(1,cabecera.getCodigoCliente());
				cstmt.registerOutParameter(2, OracleTypes.CURSOR);
				cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

				//ResultSet rs = cstmt.executeQuery();
				cstmt.execute();
				rs = (ResultSet)cstmt.getObject(2);
				cat.debug("Execute Despues");
				ArrayList lista = new ArrayList();
				
				while (rs.next()) {
					cat.debug("Procesando iteración :" + lista.size());
					CreditoMorosidadDTO CreditoMorosidad = null;
					CreditoMorosidad= getResultset(rs, lista.size());
					lista.add(CreditoMorosidad);
				}
					
				resultado = (CreditoMorosidadDTO[])ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), 
							CreditoMorosidadDTO.class);
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

		cat.debug("leerListaArchivos():end");

		return resultado;
		}
	}


