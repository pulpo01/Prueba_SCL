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
import com.tmmas.cl.scl.crmcommon.commonapp.dto.GrupoCobroServicioDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.helper.Global;


public class GrupoCobroServicioDAO extends ConnectionDAO{
	private static Category cat = Category.getInstance(GrupoCobroServicioDAO.class);

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
	
	private String getSqlListaGrupoCobroServicio(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
        for (int n = 1; n <= paramCount; n++) {
            sb.append("?");
            if (n < paramCount) sb.append(",");
        }
        return sb.append(")}").toString();
	}
	
	
	
	private GrupoCobroServicioDTO getResultset(ResultSet rs, int i) throws CustomerDomainException
	{
		GrupoCobroServicioDTO plans = new GrupoCobroServicioDTO();
		
		try
		{
			if(global.ModoEjecucion().equals("prueba1"))
			{
				plans.setCodigoGrupoCobroServicio("codPlans"+i);
				plans.setDescripcionGrupoCobroServicio("desPlans"+i);
			}
			else
			{
				plans.setCodigoGrupoCobroServicio(rs.getString(1));
				plans.setDescripcionGrupoCobroServicio(rs.getString(2));
			}

		}
		catch(SQLException e)
		{
			throw new CustomerDomainException(global.errorgetListado() +  " [" + i + "]", e);
		}
		
		return plans;
	}

	public GrupoCobroServicioDTO[] getListadoGrupoCobroServicio() 
		throws CustomerDomainException
	{
		
		cat.debug("getListadoGrupoCobroServicio:start");
		GrupoCobroServicioDTO[] resultado=null;
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
					cat.debug("Procesando iteración :" + i);
					GrupoCobroServicioDTO  GrupoCobroServicio = null;
					GrupoCobroServicio = getResultset(null, i);
					lista.add(GrupoCobroServicio);
				}
				resultado =(GrupoCobroServicioDTO[])ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), GrupoCobroServicioDTO.class);
			}
			else
			{
				String call = getSqlListaGrupoCobroServicio("VE_PARAMETROS_COMERCIALES_PG","VE_grupocobroservicio_PR",5);
				cat.debug("sql[" + call + "]");
				cstmt = conn.prepareCall(call);
				cat.debug("Execute Antes");
				cstmt.setInt(1,global.getValorCodigoProducto());
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
					GrupoCobroServicioDTO GrupoCobroServicio = null;
					GrupoCobroServicio= getResultset(rs, lista.size());
					lista.add(GrupoCobroServicio);
				}				
				resultado = (GrupoCobroServicioDTO[])ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), 
							 GrupoCobroServicioDTO.class);
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

		cat.debug("getListadoGrupoCobroServicio():end");

		return resultado;
		}
	
	/**
	 * Obtiene datos grupo cobro default
	 * @param entrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public GrupoCobroServicioDTO getGrupoCobroServicioDefault(Long entrada) 
		throws CustomerDomainException
	{
		GrupoCobroServicioDTO resultado = new GrupoCobroServicioDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:getGrupoCobroServicioDefault");	
			String call = getSqlListaGrupoCobroServicio("VE_PARAMETROS_COMERCIALES_PG","VE_grupocobroservicio_PR",6);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setLong(1,entrada.longValue());
			
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getCampanaVigente:execute");			
			cstmt.execute();			
			cat.debug("Fin:getCampanaVigente:execute");

			msgError = cstmt.getString(5);
			codError=cstmt.getInt(4);			
			numEvento=cstmt.getInt(6);
			
			if (codError != 0) {
				cat.error("Ocurrió un error al obtener el grupo cobro servicio");
				//throw new CustomerDomainException(
					//	"Ocurrió un error al obtener el grupo cobro servicio", String
						//		.valueOf(codError), numEvento, msgError);
			}
			resultado.setCodigoGrupoCobroServicio(cstmt.getString(2));
			resultado.setDescripcionGrupoCobroServicio(cstmt.getString(3));
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener el grupo cobro servicio",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			//throw new CustomerDomainException(
				//	"Ocurrió un error al obtener grupo cobro servicio",e);
		} finally {
				cat.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				cat.debug("SQLException", e);
		  }
		}
		cat.debug("Fin:getGrupoCobroServicioDefault");
		return resultado;
	}//fin getCampanaVigente
	
	
}




