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

package com.tmmas.cl.scl.gestiondeabonados.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.exception.GeneralException;
import org.apache.log4j.Category;
import com.tmmas.cl.framework.util.ArrayUtl;
import oracle.jdbc.driver.OracleTypes;

import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.TipoPrestacionDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.helper.Global;


public class PrestacionDAO extends ConnectionDAO{
	private static Category cat = Category.getInstance(PrestacionDAO.class);

	Global global = Global.getInstance();
	
	private Connection getConection() throws GeneralException
	{
		Connection conn = null;
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
		} catch (Exception e1) {
			conn = null;
			cat.error(" No se pudo obtener una conexión ", e1);
			throw new GeneralException("No se pudo obtener una conexión", e1);
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
	}//fin getSQLDatos
	
	/*getTiposPrestacion*/
	
	public TipoPrestacionDTO[] getTiposPrestacion(String codGrupoPrestacion, String tipoCliente) 
	/*throws ProductDomainException*/
	throws GeneralException
{
	cat.debug("Inicio:getTiposPrestacion()");
	int codError = 0;
	String msgError = null;
	int numEvento = 0;
	TipoPrestacionDTO[] resultado = null;
	Connection conn = null;
	CallableStatement cstmt =null;
	conn = getConection();
	ResultSet rs = null;
	cat.debug("Conexion obtenida OK");
	
	try {
		
	   String call = getSQLDatos("VE_PARAMETROS_COMERCIALES_PG", "VE_Obtiene_TipoPrest_PR",6);
	   cat.debug("sql[" + call + "]");
	   
	   cstmt = conn.prepareCall(call);
	   
	   cstmt.setString(1,codGrupoPrestacion);
	   cat.debug("getTiposPrestacion --> entrada.codGrupoPrestacion : " + codGrupoPrestacion);
	   
	   cstmt.setString(2,tipoCliente);
	   cat.debug("getTiposPrestacion --> entrada.tipoCliente : " + tipoCliente);
	   
	   cstmt.registerOutParameter(3,OracleTypes.CURSOR);
	   cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);
	   cstmt.registerOutParameter(5,java.sql.Types.VARCHAR);
	   cstmt.registerOutParameter(6,java.sql.Types.NUMERIC);
	     
	   cstmt.execute();		   
	   cat.debug("getGruposPrestacion:Execute Despues");
	   
	   codError = cstmt.getInt(4);
	   msgError = cstmt.getString(5);
	   numEvento = cstmt.getInt(6);
	 
	   cat.debug("codError[" + codError + "]");
	   cat.debug("msgError[" + msgError + "]");
	   cat.debug("numEvento[" + numEvento + "]");
	   
	   if (codError!=0) 
	   {   		    
		    cat.error("Ocurrió un error al recuperar listado de tipos prestaciones ");
		    throw new GeneralException("Ocurrió un error al recuperar listado tipos prestaciones", 
		    		String.valueOf(codError), numEvento, msgError);
	    
		}else{
			cat.debug("Recuperando listado de grupos de prestaciones");
			ArrayList lista = new ArrayList();
			rs = (ResultSet) cstmt.getObject(3);
			while (rs.next()) 
			{
				TipoPrestacionDTO tipoPrestacion = new TipoPrestacionDTO();
				tipoPrestacion.setCodPrestacion(rs.getString(1));
				tipoPrestacion.setDesPrestacion(rs.getString(2));
				tipoPrestacion.setTipVenta(rs.getInt(3));
				tipoPrestacion.setIndNumero(rs.getInt(4));
				tipoPrestacion.setIndDirInstalacion(rs.getInt(5));
				tipoPrestacion.setIndInventario(rs.getInt(6));
				tipoPrestacion.setCodPlantarifDefecto(rs.getString(7));
				tipoPrestacion.setCodCentralDefecto(rs.getInt(8));
				tipoPrestacion.setCodCeldaDefecto(rs.getString(9));
				tipoPrestacion.setIndSSInternet(rs.getInt(10));
				tipoPrestacion.setTipoRed(rs.getString(11));
				tipoPrestacion.setCodGrupoPrestacion(rs.getString(12));
				tipoPrestacion.setIndNumeroPiloto(rs.getInt(13));
				
				lista.add(tipoPrestacion);
			}				
			resultado =(TipoPrestacionDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
				lista.toArray(), TipoPrestacionDTO.class);
	  
			cat.debug("Fin recuperacion de listado de articulos");
		}
	   
	   if (cat.isDebugEnabled())
	    cat.debug(" Finalizo ejecución");
	  } 
	  catch (Exception e) {
		   cat.error("Ocurrió un error al obtener listado tipos prestaciones",e);
		   if (cat.isDebugEnabled()) {
		    cat.debug("Codigo de Error[" + codError + "]");
		    cat.debug("Mensaje de Error[" + msgError + "]");
		    cat.debug("Numero de Evento[" + numEvento + "]");
		   }
		   if (e instanceof GeneralException){
			  throw (GeneralException) e;
		   }
	  } 
	  finally {
	    if (cat.isDebugEnabled()) 
	    cat.debug("Cerrando conexiones...");
		   try {
			   if (rs != null) 
					rs.close();
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
	  cat.debug("getTiposPrestacion():end");
	return resultado;
}//fin getTiposPrestacion


	
}//fin class PrestacionDAO


