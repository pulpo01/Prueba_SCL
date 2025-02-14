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
 * 16/01/2007     Héctor Hermosilla      					Versión Inicial
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
import com.tmmas.cl.scl.crmcommon.commonapp.dto.PlanServicioDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.helper.Global;


public class PlanServicioDAO extends ConnectionDAO{
	private static Category cat = Category.getInstance(PlanServicioDAO.class);

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
	
	private String getSqlListaPlanServicios(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
        for (int n = 1; n <= paramCount; n++) {
            sb.append("?");
            if (n < paramCount) sb.append(",");
        }
        return sb.append(")}").toString();
	}
	
	
	
	
	private PlanServicioDTO getResultset(ResultSet rs, int i) throws CustomerDomainException
	{
		PlanServicioDTO plans = new PlanServicioDTO();
		
		try
		{
			if(global.ModoEjecucion().equals("prueba1"))
			{
				plans.setCodigoPlanServicio("codPlans"+i);
				plans.setDescripcionPlanServicio("desPlans"+i);
			}
			else
			{
				plans.setCodigoPlanServicio(rs.getString(1));
				plans.setDescripcionPlanServicio(rs.getString(2));
			}

		}
		catch(SQLException e)
		{
			throw new CustomerDomainException(global.errorgetListado() +  " [" + i + "]", e);
		}
		
		return plans;
	}

	public PlanServicioDTO[] getListadoPlanServicio(PlanServicioDTO entrada)
		throws CustomerDomainException
	{
		cat.debug("getListadoPlanServicio:start");
		PlanServicioDTO[] resultado=null;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ResultSet rs = null;
		cat.debug("Coneccion obtenida OK");
		try {
		
				String call = getSqlListaPlanServicios("VE_PARAMETROS_COMERCIALES_PG","VE_planservicio_PR",6);
				cat.debug("sql[" + call + "]");
				cstmt = conn.prepareCall(call);
				cat.debug("Execute Antes");
				cstmt.setString(1,entrada.getCodPlanTarif());
				cstmt.setString(2,entrada.getCodTecnologia());
				cstmt.registerOutParameter(3, OracleTypes.CURSOR);
				cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
				cstmt.execute();
				cat.debug("Execute Despues");
				codError=cstmt.getInt(4);
				msgError = cstmt.getString(5);
				numEvento = cstmt.getInt(6);
				
				cat.debug("getListadoPlanServicio:codError : " + codError );
				cat.debug("getListadoPlanServicio:msgError : " + msgError );
				cat.debug("getListadoPlanServicio:numEvento : " + numEvento );
				
				if (codError!=0){
					cat.debug("No fue posible encontrar planes de servicios");
					//throw new CustomerDomainException("Ha ocurrido un error al buscar los planes de servicio");
				}
				else
				{
					rs = (ResultSet)cstmt.getObject(3);
					ArrayList lista = new ArrayList();
					
					while (rs.next()) {
						cat.debug("Procesando iteración :" + lista.size());
						PlanServicioDTO planServicio = new PlanServicioDTO();
						planServicio.setCodigoPlanServicio(rs.getString(1));
						planServicio.setDescripcionPlanServicio(rs.getString(2));
						
						lista.add(planServicio);
					}
					
					resultado =(PlanServicioDTO[])ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), PlanServicioDTO.class);
				}
		} catch (Exception e) {
			cat.error("Ha ocurrido un error al buscar los planes de servicio", e);
			throw new CustomerDomainException("Ha ocurrido un error al buscar los planes de servicio", e);

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
		cat.debug("getListadoPlanServicio():end");

		return resultado;
		}
	}


