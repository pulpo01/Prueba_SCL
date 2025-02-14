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
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.scl.commonbusinessentities.dto.FormularioNumerosSMSDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.MonedaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.ProductDomainException;
import com.tmmas.cl.scl.productdomain.businessobject.dto.DatosGenerDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.EstadoSolicitudDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.GrupoPrestacionDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.IpDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.NivelPrestacionDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.SeguroDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.SolicitudVentaDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.TipoPrestacionDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.TipoTerminalDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.UsoDTO;
import com.tmmas.cl.scl.productdomain.businessobject.helper.Global;

public class PrestacionDAO extends ConnectionDAO{
	
	private static Category cat = Category.getInstance(PrestacionDAO.class);
	Global global = Global.getInstance();
	
	private Connection getConection() 
	throws ProductDomainException {
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
	
	private String getSQLDatos(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
        for (int n = 1; n <= paramCount; n++) {
            sb.append("?");
            if (n < paramCount) sb.append(",");
        }
        return sb.append(")}").toString();
	}//fin getSQLDatos
	
	public GrupoPrestacionDTO[] getGruposPrestacion() 
		throws ProductDomainException
	{
		cat.debug("Inicio:getGruposPrestacion()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		GrupoPrestacionDTO[] resultado = null;
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();
		ResultSet rs = null;
		cat.debug("Conexion obtenida OK");
		
		try {
			
		   String call = getSQLDatos("VE_PARAMETROS_COMERCIALES_PG", "VE_Obtiene_GruposPrest_PR",4);
		   cat.debug("sql[" + call + "]");
		   
		   cstmt = conn.prepareCall(call);
		   
		   cstmt.registerOutParameter(1,OracleTypes.CURSOR);
		   cstmt.registerOutParameter(2,java.sql.Types.NUMERIC);
		   cstmt.registerOutParameter(3,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);
		     
		   cstmt.execute();		   
		   cat.debug("getGruposPrestacion:Execute Despues");
		   
		   codError = cstmt.getInt(2);
		   msgError = cstmt.getString(3);
		   numEvento = cstmt.getInt(4);
		 
		   cat.debug("codError[" + codError + "]");
		   cat.debug("msgError[" + msgError + "]");
		   cat.debug("numEvento[" + numEvento + "]");
		   
		   if (codError!=0) 
		   {   		    
			    cat.error("Ocurrió un error al recuperar listado de grupos de prestaciones ");
			    throw new ProductDomainException("Ocurrió un error al recuperar listado de grupos de prestaciones", 
			    		String.valueOf(codError), numEvento, msgError);
		    
			}else{
				cat.debug("Recuperando listado de grupos de prestaciones");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(1);
				while (rs.next()) 
				{
					GrupoPrestacionDTO grupoPrestacion = new GrupoPrestacionDTO();
					grupoPrestacion.setCodGrupoPrestacion(rs.getString(1));
					grupoPrestacion.setDesGrupoPrestacion(rs.getString(2));										
					lista.add(grupoPrestacion);
				}				
				resultado =(GrupoPrestacionDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), GrupoPrestacionDTO.class);
		  
				cat.debug("Fin recuperacion de listado de articulos");
			}
		   
		   if (cat.isDebugEnabled())
		    cat.debug(" Finalizo ejecución");
		  } 
		  catch (Exception e) {
			   cat.error("Ocurrió un error al obtener listado de grupo de prestaciones",e);
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
		  cat.debug("getGruposPrestacion():end");
		return resultado;
	}//fin getGruposPrestacion
	
	public TipoPrestacionDTO[] getTiposPrestacion(String codGrupoPrestacion, String tipoCliente) 
		throws ProductDomainException
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
			    throw new ProductDomainException("Ocurrió un error al recuperar listado tipos prestaciones", 
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
			   if (e instanceof ProductDomainException){
				  throw (ProductDomainException) e;
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
	
	public UsoDTO[] getUsos( UsoDTO entrada ) 
		throws ProductDomainException
	{
		cat.debug("Inicio:getUsos()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		UsoDTO[] resultado = null;
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();
		ResultSet rs =  null;
		cat.debug("Conexion obtenida OK");
		
		try {
			
		   String call = getSQLDatos("VE_PARAMETROS_COMERCIALES_PG", "VE_Obtiene_Usos_PR",6);
		   cat.debug("sql[" + call + "]");
		   
		   cstmt = conn.prepareCall(call);
		   
		   cstmt.setString(1,entrada.getTipoRed());
		   cat.debug("getUsos --> entrada.getTipoRed() : " + entrada.getTipoRed());
		   cstmt.setString(2,entrada.getTipoCliente());
		   cat.debug("getUsos --> entrada.getTipoCliente()" + entrada.getTipoCliente());
		   
		   cstmt.registerOutParameter(3,OracleTypes.CURSOR);
		   cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);
		   cstmt.registerOutParameter(5,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(6,java.sql.Types.NUMERIC);
		     
		   cat.debug("getUsos:Execute Antes");
		   cstmt.execute();		   
		   cat.debug("getUsos:Execute Despues");
		   
		   codError = cstmt.getInt(4);
		   msgError = cstmt.getString(5);
		   numEvento = cstmt.getInt(6);
		 
		   cat.debug("codError[" + codError + "]");
		   cat.debug("msgError[" + msgError + "]");
		   cat.debug("numEvento[" + numEvento + "]");
		   
		   if (codError!=0) 
		   {   		    
			    cat.error("Ocurrió un error al recuperar listado de usos");
			    throw new ProductDomainException("Ocurrió un error al recuperar listado de usos", 
			    		String.valueOf(codError), numEvento, msgError);
		    
			}else{
				cat.debug("Recuperando listado de usos");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(3);
				while (rs.next()) 
				{
					UsoDTO uso = new UsoDTO();
					uso.setCodUso(rs.getLong(1));
					uso.setDesUso(rs.getString(2));
					uso.setIndRestPlan(rs.getInt(3));
					lista.add(uso);
				}				
				resultado =(UsoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), UsoDTO.class);
		  
				cat.debug("Fin recuperacion de listado de usos");
			}
		   
		   if (cat.isDebugEnabled())
		    cat.debug(" Finalizo ejecución");
		  } 
		  catch (Exception e) {
			   cat.error("Ocurrió un error al obtener listado de usos",e);
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
		  cat.debug("getUsos():end");
		return resultado;
	}//fin getUsos
	
	public SeguroDTO[] getSeguros() 
		throws ProductDomainException
	{
		cat.debug("Inicio:getSeguros()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		SeguroDTO[] resultado = null;
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();
		ResultSet rs = null;
		cat.debug("Conexion obtenida OK");
		
		try {
			
		   String call = getSQLDatos("VE_PARAMETROS_COMERCIALES_PG", "VE_Obtiene_Seguros_PR",4);
		   cat.debug("sql[" + call + "]");
		   
		   cstmt = conn.prepareCall(call);
		   
		   cstmt.registerOutParameter(1,OracleTypes.CURSOR);
		   cstmt.registerOutParameter(2,java.sql.Types.NUMERIC);
		   cstmt.registerOutParameter(3,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);
		     
		   cat.debug("getSeguros:Execute Antes");
		   cstmt.execute();		   
		   cat.debug("getSeguros:Execute Despues");
		   
		   codError = cstmt.getInt(2);
		   msgError = cstmt.getString(3);
		   numEvento = cstmt.getInt(4);
		 
		   cat.debug("codError[" + codError + "]");
		   cat.debug("msgError[" + msgError + "]");
		   cat.debug("numEvento[" + numEvento + "]");
		   
		   if (codError!=0) 
		   {   		    
			    cat.error("Ocurrió un error al recuperar listado de grupos de prestaciones ");
			    throw new ProductDomainException("Ocurrió un error al recuperar listado de grupos de prestaciones", 
			    		String.valueOf(codError), numEvento, msgError);
		    
			}else{
				cat.debug("Recuperando listado de grupos de prestaciones");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(1);
				while (rs.next()) 
				{
					SeguroDTO seguro = new SeguroDTO();
					seguro.setCodSeguro(rs.getString(1));
					seguro.setDesSeguro(rs.getString(2));										
					lista.add(seguro);
				}				
				resultado =(SeguroDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), SeguroDTO.class);
		  
				cat.debug("Fin recuperacion de listado de articulos");
			}
		   
		   if (cat.isDebugEnabled())
		    cat.debug(" Finalizo ejecución");
		  } 
		  catch (Exception e) {
			   cat.error("Ocurrió un error al obtener listado de grupo de prestaciones",e);
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
		  cat.debug("getSeguros():end");
		return resultado;
	}//fin getSeguros
	
	public Long getIndSeguro(Long entrada) 
		throws ProductDomainException
	{
		cat.debug("Inicio:getIndSeguro()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Long resultado = null;
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();
		cat.debug("Conexion obtenida OK");
		
		try {
			
		   String call = getSQLDatos("VE_PARAMETROS_COMERCIALES_PG", "VE_obtiene_indSeguroMod_PR",5);
		   cat.debug("sql[" + call + "]");
		   
		   cstmt = conn.prepareCall(call);
		   
		   cstmt.setLong(1,entrada.longValue());
		   cat.debug("modalidadVenta: " + entrada);
		   
		   
		   cstmt.registerOutParameter(2,java.sql.Types.NUMERIC);
		   cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
		   cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);
		     
		   cat.debug("getSeguros:Execute Antes");
		   cstmt.execute();		   
		   cat.debug("getSeguros:Execute Despues");
		   
		   codError = cstmt.getInt(3);
		   msgError = cstmt.getString(4);
		   numEvento = cstmt.getInt(5);
		 
		   cat.debug("codError[" + codError + "]");
		   cat.debug("msgError[" + msgError + "]");
		   cat.debug("numEvento[" + numEvento + "]");
		   
		   if (codError!=0) 
		   {   		    
			    cat.error("Ocurrió un error al recuperar indicador de seguro ");
			    throw new ProductDomainException("Ocurrió un error al recuperar indicador de seguro ", 
			    		String.valueOf(codError), numEvento, msgError);
		    
			}else{
				cat.debug("Recuperando indicador de seguro");				
				resultado = new Long(cstmt.getLong(2));
				cat.debug("Fin recuperacion indicador de seguro");
			}
		   
		   if (cat.isDebugEnabled())
		    cat.debug(" Finalizo ejecución");
		  } 
		  catch (Exception e) {
			   cat.error("Ocurrió un error al obtener indicador de seguro",e);
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
		  cat.debug("getIndSeguro():end");
		return resultado;
	}//fin getIndSeguro
	
	public void generarDatosIP(IpDTO entrada)
		throws ProductDomainException
	{
		cat.debug("Inicio:generarDatosIP()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;		
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();
		cat.debug("Conexion obtenida OK");
		
		try {
			
		   String call = getSQLDatos("PV_IPFIJA_PG", "pv_generar_datos_ip_pr",13);
		   cat.debug("sql[" + call + "]");
		   
		   cstmt = conn.prepareCall(call);
		   
		   cstmt.setLong(1,entrada.getNumAbonado());
		   
		   cstmt.setLong(2,entrada.getNumCelular());
		   cat.debug("generarDatosIP entrada.getNumCelular():" + entrada.getNumCelular());
		   cstmt.setInt(3,entrada.getCodProducto());
		   cat.debug("generarDatosIP entrada.getCodProducto():" + entrada.getCodProducto());
		   cstmt.setString(4,entrada.getCodServicio());
		   cat.debug("generarDatosIP entrada.getCodServicio():" + entrada.getCodServicio());
		   cstmt.setString(5,entrada.getFecAlta());
		   cat.debug("generarDatosIP entrada.getFecAlta():" + entrada.getFecAlta());
		   cstmt.setString(6,entrada.getCodSS());
		   cat.debug("generarDatosIP entrada.getCodSS():" + entrada.getCodSS());
		   cstmt.setLong(7,entrada.getCodNivel());
		   cat.debug("generarDatosIP entrada.getCodNivel():" + entrada.getCodNivel());
		   cstmt.setString(8,entrada.getAccion());
		   cat.debug("generarDatosIP entrada.getAccion():" + entrada.getAccion());
		   cstmt.setInt(9,entrada.getEstadoOld());
		   cat.debug("generarDatosIP entrada.getEstadoOld():" + entrada.getEstadoOld());
		   cstmt.setInt(10,entrada.getEstadoNew());
		   cat.debug("generarDatosIP entrada.getEstadoNew():" + entrada.getEstadoNew());
		   
		   cstmt.registerOutParameter(11,java.sql.Types.NUMERIC);
		   cstmt.registerOutParameter(12,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(13,java.sql.Types.NUMERIC);
		     
		   cat.debug("generarDatosIP:Execute Antes");
		   cstmt.execute();		   
		   cat.debug("generarDatosIP:Execute Despues");
		   
		   codError = cstmt.getInt(11);
		   msgError = cstmt.getString(12);
		   numEvento = cstmt.getInt(13);
		 
		   cat.debug("codError[" + codError + "]");
		   cat.debug("msgError[" + msgError + "]");
		   cat.debug("numEvento[" + numEvento + "]");
		   
		   if (codError!=0) 
		   {   		    
			    cat.error("Ocurrió un error al generar datos IP ");
			    throw new ProductDomainException("Ocurrió un error al generar datos IP ", 
			    		String.valueOf(codError), numEvento, msgError);
		    
			}
		   
		   if (cat.isDebugEnabled())
		    cat.debug(" Finalizo ejecución");
		  } 
		  catch (Exception e) {
			   cat.error("Ocurrió un error al generar datos IP",e);
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
		  cat.debug("generarDatosIP():end");		
	}//fin generarDatosIP
	
	public void insertaSeguroAbonado(SeguroDTO entrada)
		throws ProductDomainException
	{
		cat.debug("Inicio:insertaSeguroAbonado()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;		
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();
		cat.debug("Conexion obtenida OK");
		
		try {
			
		   String call = getSQLDatos("Ve_Servicios_Venta_Pg", "VE_insSeguroAbonado_PR",9);
		   cat.debug("sql[" + call + "]");
		   
		   cstmt = conn.prepareCall(call);
		   
		   cstmt.setLong(1,entrada.getNumAbonado());
		   cat.debug("insertaSeguroAbonado entrada.getNumAbonado():" + entrada.getNumAbonado());
		   cstmt.setString(2,entrada.getCodSeguro());
		   cat.debug("insertaSeguroAbonado entrada.getCodSeguro():" + entrada.getCodSeguro());
		   cstmt.setInt(3,entrada.getNumEventos());
		   cat.debug("insertaSeguroAbonado entrada.getNumEventos():" + entrada.getNumEventos());
		   cstmt.setDouble(4,entrada.getImporteEquipo());
		   cat.debug("insertaSeguroAbonado getImporteEquipo():" + entrada.getImporteEquipo());
		   cstmt.setString(5,entrada.getNomUsuarora());
		   cat.debug("insertaSeguroAbonado entrada.getNomUsuarora():" + entrada.getNomUsuarora());
		   cstmt.setString(6,entrada.getFechaFinContrato());
		   cat.debug("insertaSeguroAbonado entrada.getFechaFinContrato():" + entrada.getFechaFinContrato());
		   
		   cstmt.registerOutParameter(7,java.sql.Types.NUMERIC);
		   cstmt.registerOutParameter(8,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(9,java.sql.Types.NUMERIC);
		     
		   cat.debug("insertaSeguroAbonado:Execute Antes");
		   cstmt.execute();		   
		   cat.debug("insertaSeguroAbonado:Execute Despues");
		   
		   codError = cstmt.getInt(7);
		   msgError = cstmt.getString(8);
		   numEvento = cstmt.getInt(9);
		 
		   cat.debug("codError[" + codError + "]");
		   cat.debug("msgError[" + msgError + "]");
		   cat.debug("numEvento[" + numEvento + "]");
		   
		   if (codError!=0) 
		   {   		    
			    cat.error("Ocurrió un error al generar datos IP ");
			    throw new ProductDomainException("Ocurrió un error al generar datos IP ", 
			    		String.valueOf(codError), numEvento, msgError);		    
			}
		   
		   if (cat.isDebugEnabled())
		    cat.debug(" Finalizo ejecución");
		  } 
		  catch (Exception e) {
			   cat.error("Ocurrió un error al generar datos IP",e);
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
		  cat.debug("insertaSeguroAbonado():end");		
	}//fin insertaSeguroAbonado
	
	
		
	public SeguroDTO obtieneDatosSeguro(SeguroDTO entrada)
		throws ProductDomainException
	{
		cat.debug("Inicio:obtieneDatosSeguro()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;		
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();
		SeguroDTO resultado = new SeguroDTO();
		cat.debug("Conexion obtenida OK");
		
		try {
			
		   String call = getSQLDatos("VE_PARAMETROS_COMERCIALES_PG", "VE_ObtieneDatos_Seguro_PR",8);
		   cat.debug("sql[" + call + "]");
		   
		   cstmt = conn.prepareCall(call);
		   
		   cstmt.setString(1,entrada.getCodSeguro());
		   cstmt.setInt(2,entrada.getPeriodo());		   		   
		   cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
		   cstmt.registerOutParameter(4,java.sql.Types.DATE);
		   cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);
		   
		   cstmt.registerOutParameter(6,java.sql.Types.NUMERIC);
		   cstmt.registerOutParameter(7,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(8,java.sql.Types.NUMERIC);
		     
		   cat.debug("obtieneDatosSeguro:Execute Antes");
		   cstmt.execute();		   
		   cat.debug("obtieneDatosSeguro:Execute Despues");
		   
		   codError = cstmt.getInt(6);
		   msgError = cstmt.getString(7);
		   numEvento = cstmt.getInt(8);
		 
		   cat.debug("codError[" + codError + "]");
		   cat.debug("msgError[" + msgError + "]");
		   cat.debug("numEvento[" + numEvento + "]");
		   
		   if (codError!=0) 
		   {   		    
			    cat.error("Ocurrió un error al obtener datos seguro ");
			    throw new ProductDomainException("Ocurrió un error al obtener datos seguro ", 
			    		String.valueOf(codError), numEvento, msgError);
		    
			}
		   
		   SimpleDateFormat formatJava = new SimpleDateFormat("dd/MM/yyyy");
		   java.sql.Date fechaFin = cstmt.getDate(4);		   
		   
		   
		   resultado.setFechaFinContrato(formatJava.format(fechaFin));
		   resultado.setCodCargo(cstmt.getLong(5));
		   resultado.setCodConcepto(cstmt.getLong(3));
		   
		   
		   
		   if (cat.isDebugEnabled())
		    cat.debug(" Finalizo ejecución");
		  } 
		  catch (Exception e) {
			   cat.error("Ocurrió un error al obtener datos seguro",e);
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
		  cat.debug("obtieneDatosSeguro():end");
		  return resultado;
	}//fin obtieneDatosSeguro
	
	public TipoTerminalDTO[] listarTiposTerminal(String codTecnologia)
		throws ProductDomainException
	{
		cat.debug("Inicio:listarTiposTerminal()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		TipoTerminalDTO[] resultado = null;
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();
		ResultSet rs = null;
		cat.debug("Conexion obtenida OK");
		
		try {
			
		   String call = getSQLDatos("VE_PARAMETROS_COMERCIALES_PG", "VE_GetList_TipoTerminal_PR",5);
		   cat.debug("sql[" + call + "]");
		   
		   cstmt = conn.prepareCall(call);
		   
		   cstmt.setString(1,codTecnologia);
		   
		   cstmt.registerOutParameter(2,OracleTypes.CURSOR);
		   cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
		   cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);
		     
		   cat.debug("listarTiposTerminal:Execute Antes");
		   cstmt.execute();		   
		   cat.debug("listarTiposTerminal:Execute Despues");
		   
		   codError = cstmt.getInt(3);
		   msgError = cstmt.getString(4);
		   numEvento = cstmt.getInt(5);
		 
		   cat.debug("codError[" + codError + "]");
		   cat.debug("msgError[" + msgError + "]");
		   cat.debug("numEvento[" + numEvento + "]");
		   
		   if (codError!=0) 
		   {   		    
			    cat.error("Ocurrió un error al recuperar listado de tipos de terminales ");
			    throw new ProductDomainException("Ocurrió un error al recuperar listado de tipos de terminales", 
			    		String.valueOf(codError), numEvento, msgError);
		    
			}else{
				cat.debug("Recuperando listado de tipos de terminales");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(2);
				while (rs.next()) 
				{
					TipoTerminalDTO tipoTerminal = new TipoTerminalDTO();
					tipoTerminal.setDesTerminal(rs.getString(1));
					tipoTerminal.setTipTerminal(rs.getString(2));										
					lista.add(tipoTerminal);
				}				
				resultado =(TipoTerminalDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), TipoTerminalDTO.class);
		  
				cat.debug("Fin recuperacion de listado de tipos de terminales");
			}
		   
		   if (cat.isDebugEnabled())
		    cat.debug(" Finalizo ejecución");
		  } 
		  catch (Exception e) {
			   cat.error("Ocurrió un error al obtener listado de tipos de terminales",e);
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
		  cat.debug("listarTiposTerminal():end");
		return resultado;
	}//fin listarTiposTerminal
	
	public MonedaDTO[] listarMonedas()
		throws ProductDomainException
	{
		cat.debug("Inicio:listarMonedas()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		MonedaDTO[] resultado = null;
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();
		ResultSet rs = null;
		cat.debug("Conexion obtenida OK");
		
		try {
			
		   String call = getSQLDatos("VE_PARAMETROS_COMERCIALES_PG", "VE_getList_Monedas_PR",4);
		   cat.debug("sql[" + call + "]");
		   
		   cstmt = conn.prepareCall(call);
		   
		   cstmt.registerOutParameter(1,OracleTypes.CURSOR);
		   cstmt.registerOutParameter(2,java.sql.Types.NUMERIC);
		   cstmt.registerOutParameter(3,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);
		     
		   cat.debug("listarMonedas:Execute Antes");
		   cstmt.execute();		   
		   cat.debug("listarMonedas:Execute Despues");
		   
		   codError = cstmt.getInt(2);
		   msgError = cstmt.getString(3);
		   numEvento = cstmt.getInt(4);
		 
		   cat.debug("codError[" + codError + "]");
		   cat.debug("msgError[" + msgError + "]");
		   cat.debug("numEvento[" + numEvento + "]");
		   
		   if (codError!=0) 
		   {   		    
			    cat.error("Ocurrió un error al recuperar listado de monedas ");
			    throw new ProductDomainException("Ocurrió un error al recuperar listado de monedas", 
			    		String.valueOf(codError), numEvento, msgError);
		    
			}else{
				cat.debug("Recuperando listado de tipos de terminales");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(1);
				while (rs.next()) 
				{
					MonedaDTO moneda = new MonedaDTO();
					moneda.setCodigo(rs.getString(1));
					moneda.setDescripcion(rs.getString(2));										
					lista.add(moneda);
				}				
				resultado =(MonedaDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), MonedaDTO.class);
		  
				cat.debug("Fin recuperacion de listado de monedas");
			}
		   
		   if (cat.isDebugEnabled())
		    cat.debug(" Finalizo ejecución");
		  } 
		  catch (Exception e) {
			   cat.error("Ocurrió un error al obtener listado de monedas",e);
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
		  cat.debug("listarMonedas():end");
		return resultado;
	}//fin listarMonedas
	
	public TipoPrestacionDTO getDatosPrestacion(String codPrestacion) 
		throws ProductDomainException
	{
		cat.debug("Inicio:getDatosPrestacion()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		TipoPrestacionDTO resultado = new TipoPrestacionDTO();
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();		
		cat.debug("Conexion obtenida OK");
		
		try {
			
		   String call = getSQLDatos("Ve_Servicios_Venta_Pg", "VE_ObtieneDatosPrestacion_PR",18);
		   cat.debug("sql[" + call + "]");
		   
		   cstmt = conn.prepareCall(call);
		   
		   cstmt.setString(1,codPrestacion);
		   cat.debug("getDatosPrestacion --> entrada.codPrestacion : " + codPrestacion);
		   
		   
		   cstmt.registerOutParameter(2,java.sql.Types.VARCHAR); //desPrestacion
		   cstmt.registerOutParameter(3,java.sql.Types.VARCHAR); //grpPrestacion
		   cstmt.registerOutParameter(4,java.sql.Types.NUMERIC); //indActivo
		   cstmt.registerOutParameter(5,java.sql.Types.NUMERIC); //tipVenta 
		   cstmt.registerOutParameter(6,java.sql.Types.VARCHAR); //tipRed
		   cstmt.registerOutParameter(7,java.sql.Types.NUMERIC); //indNumero
		   cstmt.registerOutParameter(8,java.sql.Types.NUMERIC); //indDirInstalacion
		   cstmt.registerOutParameter(9,java.sql.Types.NUMERIC); //indInventarioFijo
		   cstmt.registerOutParameter(10,java.sql.Types.NUMERIC); //indSSInternet
		   cstmt.registerOutParameter(11,java.sql.Types.VARCHAR); //codPlanDefecto
		   cstmt.registerOutParameter(12,java.sql.Types.NUMERIC); //codCentralDefecto
		   cstmt.registerOutParameter(13,java.sql.Types.VARCHAR); //codCeldadefecto
		   cstmt.registerOutParameter(14,java.sql.Types.VARCHAR); //codServicioInstalacion
		   cstmt.registerOutParameter(15,java.sql.Types.NUMERIC); //indNumPiloto
		   
		   cstmt.registerOutParameter(16,java.sql.Types.NUMERIC);
		   cstmt.registerOutParameter(17,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(18,java.sql.Types.NUMERIC);
		     
		   cstmt.execute();		   
		   cat.debug("getDatosPrestacion:Execute Despues");
		   
		   codError = cstmt.getInt(16);
		   msgError = cstmt.getString(17);
		   numEvento = cstmt.getInt(18);
		 
		   cat.debug("codError[" + codError + "]");
		   cat.debug("msgError[" + msgError + "]");
		   cat.debug("numEvento[" + numEvento + "]");
		   
		   if (codError!=0) 
		   {   		    
			    cat.error("Ocurrió un error al recuperar listado de tipos prestaciones ");
			    throw new ProductDomainException("Ocurrió un error al recuperar listado tipos prestaciones", 
			    		String.valueOf(codError), numEvento, msgError);
		    
			}else{
				resultado.setDesPrestacion(cstmt.getString(2));
				resultado.setCodGrupoPrestacion(cstmt.getString(3));
				resultado.setIndActivo(cstmt.getInt(4));
				resultado.setTipVenta(cstmt.getInt(5));
				resultado.setTipoRed(cstmt.getString(6));
				resultado.setIndNumero(cstmt.getInt(7));
				resultado.setIndDirInstalacion(cstmt.getInt(8));
				resultado.setIndInventario(cstmt.getInt(9));
				resultado.setIndSSInternet(cstmt.getInt(10));
				resultado.setCodPlantarifDefecto(cstmt.getString(11));				
				resultado.setCodCentralDefecto(cstmt.getInt(12));				
				resultado.setCodCeldaDefecto(cstmt.getString(13));			
				resultado.setCodServicioInstalacion(cstmt.getString(14));	
				resultado.setIndNumeroPiloto(cstmt.getInt(15));
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
		  cat.debug("getDatosPrestacion():end");
		return resultado;
	}//fin getTiposPrestacion
	
	public void insertaCargoRecurrenteSeguro(SeguroDTO entrada)
		throws ProductDomainException
	{
		cat.debug("Inicio:insertaCargoRecurrenteSeguro()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;		
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();
		String resultado = "";
		cat.debug("Conexion obtenida OK");
		
		try {
			
		   String call = getSQLDatos("PV_SEGURO_ABON_PG", "PV_CARGO_RECSEGURO_PR",15);
		   cat.debug("sql[" + call + "]");
		   
		   cstmt = conn.prepareCall(call);
		   
		   cstmt.setLong(1,entrada.getNumAbonado());
		   cat.debug("entrada.getNumAbonado()[" + entrada.getNumAbonado() + "]");
		   cstmt.setLong(2,entrada.getCodCliente());
		   cat.debug("entrada.getCodCliente()[" + entrada.getCodCliente() + "]");
		   cstmt.setLong(3,0);
		   cstmt.setLong(4,entrada.getCodCargo());
		   cstmt.setLong(5,entrada.getNumAbonado());
		   cat.debug("entrada.getNumAbonado()[" + entrada.getNumAbonado() + "]");
		   cstmt.setLong(6,entrada.getCodCliente());
		   cat.debug("entrada.getCodCliente()[" + entrada.getCodCliente() + "]");
		   cstmt.setString(7,entrada.getCodPlanServ());
		   cat.debug("entrada.getCodPlanServ()[" + entrada.getCodPlanServ() + "]");
		   cstmt.setInt(8,1);
		   cstmt.setLong(9,entrada.getCodConcepto());
		   cat.debug("entrada.getCodConcepto()[" + entrada.getCodConcepto() + "]");
		   cstmt.setDate(10,entrada.getFechaAlta());
		   cat.debug("entrada.getFechaAlta()[" + entrada.getFechaAlta() + "]");
		   cstmt.setDate(11,entrada.getFechaBaja());
		   cat.debug("entrada.getFechaFinContrato()[" + entrada.getFechaBaja() + "]");
		   cstmt.setString(12,entrada.getNomUsuarora());
		   cat.debug("entrada.getNomUsuarora()[" + entrada.getNomUsuarora() + "]");
		   
		   cstmt.registerOutParameter(13,java.sql.Types.NUMERIC);
		   cstmt.registerOutParameter(14,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(15,java.sql.Types.NUMERIC);
		     
		   cat.debug("insertaCargoRecurrenteSeguro:Execute Antes");
		   cstmt.execute();		   
		   cat.debug("insertaCargoRecurrenteSeguro:Execute Despues");
		   
		   codError = cstmt.getInt(13);
		   msgError = cstmt.getString(14);
		   numEvento = cstmt.getInt(15);
		 
		   cat.debug("codError[" + codError + "]");
		   cat.debug("msgError[" + msgError + "]");
		   cat.debug("numEvento[" + numEvento + "]");
		   
		   if (codError!=0) 
		   {   		    
			    cat.error("Ocurrió un error al insertar el cargo asociado al aseguro ");
			    throw new ProductDomainException("Ocurrió un error al insertar el cargo asociado al seguro ", 
			    		String.valueOf(codError), numEvento, msgError);
		    
		   }
		   
		   if (cat.isDebugEnabled())
		    cat.debug(" Finalizo ejecución");
		  } 
		  catch (Exception e) {
			   cat.error("Ocurrió un error al insertar el cargo asociado al seguro",e);
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
		  cat.debug("insertaCargoRecurrenteSeguro():end");
	}
	
	
	public DatosGenerDTO getCantidadCarrier(Long numVenta) 
		throws ProductDomainException
	{
		DatosGenerDTO resultado=new DatosGenerDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;		
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:getCantidadCarrier");			
			String call = getSQLDatos("Ve_Servicios_Venta_Pg", "VE_ConsultaAbonadoCarrier_PR ",6);
			cat.debug("sql[" + call + "]");
	
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1,numVenta.longValue());
			cat.debug("numVenta: " + numVenta.longValue());		
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getCantidadCarrier:execute");
			cstmt.execute();
			cat.debug("Fin:getCantidadCarrier:execute");
	
			codError=cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento=cstmt.getInt(6);
			cat.debug("msgError[" + msgError + "]");
			cat.debug("Codigo de Error[" + codError + "]");
			if (codError==0){
				cat.debug("Abonados carrier: " + cstmt.getLong(2));
				cat.debug("Abonados: " + cstmt.getLong(3));
				
				resultado.setCantAbonadosCarrier(cstmt.getLong(2));
				resultado.setCantAbonados(cstmt.getLong(3));
			}
			else{
				cat.error("Ocurrió un error al obtener la cantidad de prestaciones carrier de la venta");
				throw new CustomerDomainException(
						"Ocurrió un error al obtener la cantidad de prestaciones carrier de la venta", String
								.valueOf(codError), numEvento, msgError);
			}
		
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener la cantidad de prestaciones carrier de la venta",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
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
	
		cat.debug("Fin:getCantidadCarrier");
	
		return resultado;
	}
	
	public void guardarSolicitudVenta(SolicitudVentaDTO entrada)
		throws ProductDomainException
	{
		cat.debug("Inicio:guardarSolicitudVenta()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;		
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();
		cat.debug("Conexion obtenida OK");
		
		try {
			
		   String call = getSQLDatos("VE_SERVICIOS_VENTA_PG", "VE_ins_SolicVta_PR",6);
		   cat.debug("sql[" + call + "]");
		   
		   cstmt = conn.prepareCall(call);
		   
		   cstmt.setLong(1,entrada.getNumVenta());
		   cat.debug("entrada.getNumVenta():" + entrada.getNumVenta());		   
		   cstmt.setString(2,entrada.getTipoSolicitud());
		   cat.debug("entrada.getTipoSolicitud():" + entrada.getTipoSolicitud());
		   cstmt.setString(3,entrada.getNomUsuarora());
		   cat.debug("entrada.getNomUsuarora():" + entrada.getNomUsuarora());		   
		   
		   cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);
		   cstmt.registerOutParameter(5,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(6,java.sql.Types.NUMERIC);
		     
		   cat.debug("guardarSolicitudVenta:Execute Antes");
		   cstmt.execute();		   
		   cat.debug("guardarSolicitudVenta:Execute Despues");
		   
		   codError = cstmt.getInt(4);
		   msgError = cstmt.getString(5);
		   numEvento = cstmt.getInt(6);
		 
		   cat.debug("codError[" + codError + "]");
		   cat.debug("msgError[" + msgError + "]");
		   cat.debug("numEvento[" + numEvento + "]");
		   
		   if (codError!=0) 
		   {   		    
			    cat.error("Ocurrió un error guardar la solicitud de venta ");
			    throw new ProductDomainException("Ocurrió un error al guardar la solicitud ", 
			    		String.valueOf(codError), numEvento, msgError);
		    
			}
		   
		   if (cat.isDebugEnabled())
		    cat.debug(" Finalizo ejecución");
		  } 
		  catch (Exception e) {
			   cat.error("Ocurrió un error al guardar la solicitud de venta",e);
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
		  cat.debug("guardarSolicitudVenta():end");		
	}//fin guardarSolicitudVenta
	
	public void actualizaSolVentaForm(Long numVenta)	
		throws ProductDomainException
	{
		cat.debug("Inicio:actualizaSolVentaForm()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;		
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();
		cat.debug("Conexion obtenida OK");
		
		try {
			
		   String call = getSQLDatos("VE_SERVICIOS_VENTA_PG", "VE_ActualizaVta_Sol_PR",4);
		   cat.debug("sql[" + call + "]");
		   
		   cstmt = conn.prepareCall(call);
		   
		   cstmt.setLong(1,numVenta.longValue());
		   cat.debug("numVenta):" + numVenta.longValue());		   
		  		   
		   cstmt.registerOutParameter(2,java.sql.Types.NUMERIC);
		   cstmt.registerOutParameter(3,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);
		     
		   cat.debug("actualizaSolVentaForm:Execute Antes");
		   cstmt.execute();		   
		   cat.debug("actualizaSolVentaForm:Execute Despues");
		   
		   codError = cstmt.getInt(2);
		   msgError = cstmt.getString(3);
		   numEvento = cstmt.getInt(4);
		 
		   cat.debug("codError[" + codError + "]");
		   cat.debug("msgError[" + msgError + "]");
		   cat.debug("numEvento[" + numEvento + "]");
		   
		   if (codError!=0) 
		   {   		    
			    cat.error("Ocurrió un error al actualizar la solicitud de venta ");
			    throw new ProductDomainException("Ocurrió un error al actualizar la solicitud ", 
			    		String.valueOf(codError), numEvento, msgError);
		    
			}
		   
		   if (cat.isDebugEnabled())
		    cat.debug(" Finalizo ejecución");
		  } 
		  catch (Exception e) {
			   cat.error("Ocurrió un error al actualizar la solicitud de venta",e);
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
		  cat.debug("actualizaSolVentaForm():end");		
	}//fin actualizaSolVentaForm

	
	public void actualizaSolVentaEval(SolicitudVentaDTO entrada)
		throws ProductDomainException
	{
		cat.debug("Inicio:actualizaSolVentaEval()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;		
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();
		cat.debug("Conexion obtenida OK");
		
		try {
			
		   String call = getSQLDatos("VE_SERVICIOS_VENTA_PG", "VE_ActualizaVta_Sol_PR",5);
		   cat.debug("sql[" + call + "]");
		   
		   cstmt = conn.prepareCall(call);
		   
		   cstmt.setLong(1,entrada.getNumVenta());
		   cat.debug("numVenta:" + entrada.getNumVenta());	
		   cstmt.setString(2,entrada.getIndEstado());
		   cat.debug("indEstado:" + entrada.getIndEstado());		
		  		   
		   cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
		   cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);
		     
		   cat.debug("actualizaSolVentaEval:Execute Antes");
		   cstmt.execute();		   
		   cat.debug("actualizaSolVentaEval:Execute Despues");
		   
		   codError = cstmt.getInt(3);
		   msgError = cstmt.getString(4);
		   numEvento = cstmt.getInt(5);
		 
		   cat.debug("codError[" + codError + "]");
		   cat.debug("msgError[" + msgError + "]");
		   cat.debug("numEvento[" + numEvento + "]");
		   
		   if (codError!=0) 
		   {   		    
			    cat.error("Ocurrió un error al actualizar la solicitud de venta ");
			    throw new ProductDomainException("Ocurrió un error al actualizar la solicitud ", 
			    		String.valueOf(codError), numEvento, msgError);
		    
			}
		   
		   if (cat.isDebugEnabled())
		    cat.debug(" Finalizo ejecución");
		  } 
		  catch (Exception e) {
			   cat.error("Ocurrió un error al actualizar la solicitud de venta",e);
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
		  cat.debug("actualizaSolVentaEval():end");		
	}//fin actualizaSolVentaEval
	
	
	public EstadoSolicitudDTO[] listarEstadosSolicitud(SolicitudVentaDTO entrada)	
		throws ProductDomainException
	{
		cat.debug("Inicio:listarEstadosSolicitud()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;		
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();
		ResultSet rs = null;
		EstadoSolicitudDTO[]  resultado = null;
		cat.debug("Conexion obtenida OK");
		
		try {
			
		   String call = getSQLDatos("VE_PARAMETROS_COMERCIALES_PG", "VE_getList_EstFinSol_PR",5);
		   cat.debug("sql[" + call + "]");
		   
		   cstmt = conn.prepareCall(call);
		   
		   cstmt.setString(1,entrada.getIndEstado());
		   cat.debug("estado:" + entrada.getIndEstado());	
		   	
		   cstmt.registerOutParameter(2,OracleTypes.CURSOR);		  		   
		   cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
		   cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);
		     
		   cat.debug("listarEstadosSolicitud:Execute Antes");
		   cstmt.execute();		   
		   cat.debug("listarEstadosSolicitud:Execute Despues");
		   
		   codError = cstmt.getInt(3);
		   msgError = cstmt.getString(4);
		   numEvento = cstmt.getInt(5);
		 
		   cat.debug("codError[" + codError + "]");
		   cat.debug("msgError[" + msgError + "]");
		   cat.debug("numEvento[" + numEvento + "]");
		   
		   if (codError!=0) 
		   {   		    
			    cat.error("Ocurrió un error al recuperar el listado de estados ");
			    throw new ProductDomainException("Ocurrió un error al recuperar el listado de estados ", 
			    		String.valueOf(codError), numEvento, msgError);
		    
			}else {
				cat.debug("Recuperando listado de estados");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(2);
				while (rs.next()) 
				{
					EstadoSolicitudDTO estado = new EstadoSolicitudDTO();
					estado.setCodEstado(rs.getString(1));
					estado.setDesEstado(rs.getString(2));										
					lista.add(estado);
				}				
				resultado =(EstadoSolicitudDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), EstadoSolicitudDTO.class);
		  
				cat.debug("Fin recuperacion listado de estados");
			}
			
			
		   
		   if (cat.isDebugEnabled())
		    cat.debug(" Finalizo ejecución");
		  } 
		  catch (Exception e) {
			   cat.error("Ocurrió un error al recuperar listado de estados",e);
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
		  cat.debug("listarEstadosSolicitud():end");	
		  return resultado;
	}//fin listarEstadosSolicitud
	
	/**
	 * Obtiene lista de niveles o subniveles asociados a una prestacion
	 * @param entrada
	 * @return NivelPrestacionDTO[]
	 * @throws ProductDomainException
	 */
	public NivelPrestacionDTO[] obtieneNivelesPrestacion(NivelPrestacionDTO entrada)	
		throws ProductDomainException
	{
		cat.debug("Inicio:obtieneNivelesPrestacion()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;		
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();
		ResultSet rs = null;
		NivelPrestacionDTO[]  resultado = null;
		
		try {
			
		   String call = getSQLDatos("Ve_Servicios_solicitud_Pg", "VE_obtiene_niveles_prest_PR",6);
		   cat.debug("sql[" + call + "]");
		   
		   cstmt = conn.prepareCall(call);
		   
		   cat.debug("CodPrestacion:" + entrada.getCodPrestacion());	
		   cat.debug("CodNivel:" + entrada.getCodNivel());
		   
		   cstmt.setString(1,entrada.getCodPrestacion());
		   cstmt.setInt(2,entrada.getCodNivel());
		   	
		   cstmt.registerOutParameter(3,OracleTypes.CURSOR);		  		   
		   cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);
		   cstmt.registerOutParameter(5,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(6,java.sql.Types.NUMERIC);
		     
		   cstmt.execute();		   

		   codError = cstmt.getInt(4);
		   msgError = cstmt.getString(5);
		   numEvento = cstmt.getInt(6);
		 
		   cat.debug("codError[" + codError + "]");
		   cat.debug("msgError[" + msgError + "]");
		   cat.debug("numEvento[" + numEvento + "]");
		   
		   if (codError!=0) 
		   {   		    
			    cat.error("Ocurrió un error al recuperar listado de niveles ");
			    throw new ProductDomainException("Ocurrió un error al recuperar listado de niveles ", 
			    		String.valueOf(codError), numEvento, msgError);
		    
			}else {
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(3);
				while (rs.next()) 
				{
					NivelPrestacionDTO nivel = new NivelPrestacionDTO();
					nivel.setCodNivel(rs.getInt(1));
					nivel.setDescripcionNivel(rs.getString(2));
					cat.debug("CodNivel="+nivel.getCodNivel());
					cat.debug("DescripcionNivel="+nivel.getDescripcionNivel());					
					lista.add(nivel);
				}				
				resultado =(NivelPrestacionDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), NivelPrestacionDTO.class);
		  
			}
			
			
		   
		   if (cat.isDebugEnabled())
		    cat.debug(" Finalizo ejecución");
		  } 
		  catch (Exception e) {
			   cat.error("Ocurrió un error al recuperar listado de niveles",e);
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
		  cat.debug("obtieneNivelesPrestacion():end");	
		  return resultado;
	}//fin obtieneNivelesPrestacion
	
	
	public void insertaNumerosSMS(FormularioNumerosSMSDTO entrada)
		throws ProductDomainException
	{
		cat.debug("Inicio:insertaNumerosSMS()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;		
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();
		cat.debug("Conexion obtenida OK");
		
		try {
			
		   String call = getSQLDatos("Ve_Servicios_Solicitud_Pg", "VE_inserta_numsms_PR",6);
		   cat.debug("sql[" + call + "]");
		   
		   cstmt = conn.prepareCall(call);
		   
		   cstmt.setLong(1,entrada.getNumAbonado());
		   cat.debug("insertaSeguroAbonado entrada.getNumAbonado():" + entrada.getNumAbonado());
		   cstmt.setLong(2,entrada.getNumeroCortoValor());
		   cat.debug("insertaSeguroAbonado entrada.getNumeroCortoValor():" + entrada.getNumeroCortoValor());
		   cstmt.setString(3,entrada.getNomUsuarora());
		   cat.debug("insertaSeguroAbonado entrada.getNomUsuarora():" + entrada.getNomUsuarora());
		   
		   cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);
		   cstmt.registerOutParameter(5,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(6,java.sql.Types.NUMERIC);
		     
		   cat.debug("insertaSeguroAbonado:Execute Antes");
		   cstmt.execute();		   
		   cat.debug("insertaSeguroAbonado:Execute Despues");
		   
		   codError = cstmt.getInt(4);
		   msgError = cstmt.getString(5);
		   numEvento = cstmt.getInt(6);
		 
		   cat.debug("codError[" + codError + "]");
		   cat.debug("msgError[" + msgError + "]");
		   cat.debug("numEvento[" + numEvento + "]");
		   
		   if (codError!=0) 
		   {   		    
			    cat.error(" Ocurrió un error al generar los datos del número sms ");
			    throw new ProductDomainException(" Ocurrió un error al generar los datos del número sms ", 
			    		String.valueOf(codError), numEvento, msgError);		    
			}
		   
		   if (cat.isDebugEnabled())
		    cat.debug(" Finalizo ejecución");
		  } 
		  catch (Exception e) {
			   cat.error(" Ocurrió un error al generar los datos del número sms ",e);
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
		  cat.debug("insertaNumerosSMS():end");		
	}//fin insertaNumerosSMS
	
	public void existeNumeroSMS(Long entrada)
		throws ProductDomainException
	{
		cat.debug("Inicio:existeNumeroSMS()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;		
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();
		cat.debug("Conexion obtenida OK");
		
		try {
			
		   String call = getSQLDatos("Ve_Servicios_Solicitud_Pg", "VE_existe_numsms_PR",4);
		   cat.debug("sql[" + call + "]");
		   
		   cstmt = conn.prepareCall(call);
		   
		   cstmt.setLong(1,entrada.longValue());
		   cat.debug("numSMS:" + entrada);
		   
		   cstmt.registerOutParameter(2,java.sql.Types.NUMERIC);
		   cstmt.registerOutParameter(3,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);
		     
		   cat.debug("insertaSeguroAbonado:Execute Antes");
		   cstmt.execute();		   
		   cat.debug("insertaSeguroAbonado:Execute Despues");
		   
		   codError = cstmt.getInt(2);
		   msgError = cstmt.getString(3);
		   numEvento = cstmt.getInt(4);
		 
		   cat.debug("codError[" + codError + "]");
		   cat.debug("msgError[" + msgError + "]");
		   cat.debug("numEvento[" + numEvento + "]");
		   
		   if (codError!=0) 
		   {   		    
			    cat.error(" Número sms ya se encuentra asignado ");
			    throw new ProductDomainException(" Numero sms ya se encuentra asignado ", 
			    		String.valueOf(codError), numEvento, msgError);		    
			}
		   
		   if (cat.isDebugEnabled())
		    cat.debug(" Finalizo ejecución");
		  } 
		  catch (Exception e) {
			   cat.error(" Numero sms ya se encuentra asignado ",e);
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
		  cat.debug("existeNumeroSMS():end");		
	}//fin existeNumeroSMS
	
}//fin class prestacion
