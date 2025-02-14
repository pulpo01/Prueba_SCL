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

import java.rmi.RemoteException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.ArticuloInDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.ProductDomainException;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.VentasException;
import com.tmmas.cl.scl.productdomain.businessobject.dto.ArticuloDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.ArticuloOutDTO;
import com.tmmas.cl.scl.productdomain.businessobject.helper.Global;

public class ArticuloDAO extends ConnectionDAO{
	
	private static Category cat = Category.getInstance(ArticuloDAO.class);
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
	
	
	/**
	 * Obtiene los datos del articulo 
	 * @param entrada
	 * @return resultado
	 * @throws ProductDomainException
	 */

	
	public ArticuloDTO getArticulo(ArticuloDTO entrada) 
		throws ProductDomainException
	{
		cat.debug("Inicio:getArticulo()");
		ArticuloDTO resultado = entrada;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt =null;
		try {
			String call = getSQLDatos("AL_Servicios_Almacenes_PG","AL_consulta_articulo_PR",7);
			
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1,entrada.getCodigo());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);			
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);			
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getArticulo:execute");
			cstmt.execute();
			cat.debug("Fin:getArticulo:execute");
			
			codError = cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento = cstmt.getInt(7);
			cat.debug("msgError[" + msgError + "]");
			if (codError!=0)
			{
				cat.error("Ocurrió un error al recuperar los datos del articulo");
				throw new ProductDomainException("Ocurrió un error al recuperar los datos del articulo", String
								.valueOf(codError), numEvento, msgError);
			}
			else
			{
				resultado.setTipo(cstmt.getString(2));
				resultado.setDescripcion(cstmt.getString(3));
				resultado.setCodigoConceptoArticulo(cstmt.getInt(4));				
			}
			
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar los datos del articulo",e);
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
		cat.debug("Fin:getArticulo()");
		return resultado;
	}//fin getArticulo
	
	/**
	 * Obtiene los datos del articulo 
	 * @param entrada
	 * @return N/A
	 * @throws ProductDomainException
    */
	public void insReservaArticulo(ArticuloDTO entrada) 
		throws ProductDomainException
	{
		cat.debug("Inicio:insReservaArticulo()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt =null;
		try {
			String call = getSQLDatos("Ve_Servicios_Venta_Pg","VE_insReservaArticulo_PR",13);
			
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);

			cat.debug("reserva:insReservaArticulo");
			cat.debug("reserva:NumeroLinea " + entrada.getNumeroLinea());
			cat.debug("reserva:NumeroOrden " + entrada.getNumeroOrden());
			cat.debug("reserva:Codigo " + entrada.getCodigo());
			cat.debug("reserva:CodigoProducto " + entrada.getCodigoProducto());
			cat.debug("reserva:CodigoBodega " + entrada.getCodigoBodega());
			cat.debug("reserva:TipoStock " + entrada.getTipoStock());
			cat.debug("reserva:CodigoUso " + entrada.getCodigoUso());
			cat.debug("reserva:CodigoEstado " + entrada.getCodigoEstado());
			cat.debug("reserva:NombreUsuario " + entrada.getNombreUsuario());
			cat.debug("reserva:NumeroSerie " + entrada.getNumeroSerie());
			
			cstmt.setString(1,String.valueOf(entrada.getNumeroLinea()));
			cstmt.setString(2,String.valueOf(entrada.getNumeroOrden()));
			cstmt.setString(3,String.valueOf(entrada.getCodigo()));
			cstmt.setString(4,String.valueOf(entrada.getCodigoProducto()));
			cstmt.setString(5,String.valueOf(entrada.getCodigoBodega()));
			cstmt.setString(6,String.valueOf(entrada.getTipoStock()));
			cstmt.setString(7,String.valueOf(entrada.getCodigoUso()));
			cstmt.setString(8,String.valueOf(entrada.getCodigoEstado()));
			cstmt.setString(9,entrada.getNombreUsuario());
			cstmt.setString(10,entrada.getNumeroSerie());
					   
			cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(13, java.sql.Types.NUMERIC);

			cat.debug("Inicio:insReservaArticulo:execute");
			cstmt.execute();
			cat.debug("Fin:insReservaArticulo:execute");
			
			codError = cstmt.getInt(11);
			msgError = cstmt.getString(12);
			numEvento = cstmt.getInt(13);
			
			cat.debug("reserva:[" + codError + "]");
			cat.debug("reserva:[" + msgError + "]");

			if (codError!=0){
				cat.error("Ocurrió un error al insertar reserva del articulo");
				throw new ProductDomainException(
						"Ocurrió un error al insertar reserva del articulo", String
								.valueOf(codError), numEvento, msgError);
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al insertar reserva del articulo",e);
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
		cat.debug("Fin:insReservaArticulo()");
	}//fin insReservaArticulo
	
	/**
	 * Obtiene los datos del articulo 
	 * @param entrada
	 * @return resultado
	 * @throws ProductDomainException
	*/
    public ArticuloDTO ActualizaStock(ArticuloDTO entrada) 
		throws ProductDomainException
	{
    	cat.debug("Inicio:ActualizaStock()");
		ArticuloDTO resultado = entrada;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			String call = getSQLDatos("VE_Servicios_Venta_PG","VE_ActualizaStock_PR",12);
			
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,entrada.getTipoMovimiento());
			cat.debug("entrada.getTipoMovimiento()" + entrada.getTipoMovimiento());			
			cstmt.setString(2,String.valueOf(entrada.getTipoStock()));
			cat.debug("entrada.getTipoStock()" + entrada.getTipoStock());			
			cstmt.setString(3,String.valueOf(entrada.getCodigoBodega()));			
			cat.debug("entrada.getCodigoBodega()" + entrada.getCodigoBodega());			
			cstmt.setString(4,String.valueOf(entrada.getCodigo()));
			cat.debug("entrada.getCodigo()" + entrada.getCodigo());			
			cstmt.setString(5,String.valueOf((entrada.getCodigoUso())));			
			cat.debug("entrada.getCodigoUso()" + entrada.getCodigoUso());			
			cstmt.setString(6,String.valueOf((entrada.getCodigoEstado())));
			cat.debug("entrada.getCodigoEstado()" + entrada.getCodigoEstado());			
			cstmt.setString(7,entrada.getNumeroVenta());
			cat.debug("entrada.getNumeroVenta()" + entrada.getNumeroVenta());			
			cstmt.setString(8,entrada.getNumeroSerie());
			cat.debug("entrada.getNumeroSerie()" + entrada.getNumeroSerie());			
			
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(12, java.sql.Types.NUMERIC);

			cat.debug("Inicio:ActualizaStock:execute");			
			cstmt.execute();			
			cat.debug("Fin:ActualizaStock:execute");
			
			codError = cstmt.getInt(10);
			msgError = cstmt.getString(11);
			numEvento = cstmt.getInt(12);
			
			cat.debug("msgError[" + msgError + "]");

			if (codError!=0){
				cat.error("Ocurrió un error al actualizar stock");
				throw new ProductDomainException(
						"Ocurrió un error al actualizar stock", String
								.valueOf(codError), numEvento, msgError);
			}
			else
				resultado.setNumeroMovimiento(cstmt.getString(9));
			
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (Exception e) {			
			e.printStackTrace();
			cat.error("Ocurrió un error al actualizar stock",e);
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
		cat.debug("Fin:ActualizaStock()");
		return resultado;
	}//fin ActualizaStock

    public ArticuloOutDTO[] getListadoArticulos(ArticuloInDTO articulo) 
		throws ProductDomainException
	{
		   cat.debug("Inicio:getListadoArticulo()");
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			ArticuloOutDTO[] resultado = null;
			Connection conn = null;
			CallableStatement cstmt =null;
			conn = getConection();
			ResultSet rs = null;
			cat.debug("Conexion obtenida OK");
		  try {
			  String call = getSQLDatos("Ve_Servs_ActivacionesWeb_Pg", "VE_getListArticulos_PR",6);
		   cat.debug("sql[" + call + "]");
		   
		   cstmt = conn.prepareCall(call);
		   
		   cstmt.setString(1,articulo.getCod_fabricante());
		   cat.debug("articulo.getCod_fabricante()" + articulo.getCod_fabricante());
		   cstmt.setString(2,articulo.getCod_tecnologia());
		   cat.debug("articulo.getCod_tecnologia()" + articulo.getCod_tecnologia());
		   cstmt.registerOutParameter(3,OracleTypes.CURSOR);
		   cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);
		   cstmt.registerOutParameter(5,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(6,java.sql.Types.NUMERIC);
		     
		   cstmt.execute();		   
		   cat.debug("getListadoArticulo:Execute Despues");
		   
		   codError = cstmt.getInt(4);
		   msgError = cstmt.getString(5);
		   numEvento = cstmt.getInt(6);
		 
		   cat.debug("codError[" + codError + "]");
		   cat.debug("msgError[" + msgError + "]");
		   cat.debug("numEvento[" + numEvento + "]");
		   
		   if (codError!=0) {			   
			
			if (codError==1){
			 msgError = "No existen articulos comercializables por Web"; 	
			}   
		    
		    cat.error("Ocurrió un error al recuperar listado de articulos ");
		    throw new ProductDomainException("Ocurrió un error al recuperar listado de articulos", 
		    		String.valueOf(codError), numEvento, msgError);
		    
			}else{
				cat.debug("Recuperando listado de articulos");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(3);
				while (rs.next()) {
					ArticuloOutDTO articuloOutDTO = new ArticuloOutDTO();
					articuloOutDTO.setCodigo(rs.getLong(1));
					articuloOutDTO.setDescripcion(rs.getString(2));
					articuloOutDTO.setCodModelo(rs.getString(3));
					articuloOutDTO.setCodFabricante(rs.getString(4));
					articuloOutDTO.setDesFabricante(rs.getString(5));
					lista.add(articuloOutDTO);
				}				
				resultado =(ArticuloOutDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), ArticuloOutDTO.class);
		  
				cat.debug("Fin recuperacion de listado de articulos");
			}
		   
		   if (cat.isDebugEnabled())
		    cat.debug(" Finalizo ejecución");
		  } 
		  catch (Exception e) {
			   cat.error("Ocurrió un error al obtener listado de articulos",e);
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
				   if (rs != null) {
						rs.close();
				   }
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
		  cat.debug("getListadoArticulo():end");
		return resultado;
	}//fin getArticulo
    
	/** Servicios Activaciones WEB - Colombia
	 * MAYORISTAS
	 * Obtine indicador valorar
	 * @param ArticuloDTO (entrada)
	 * @return ArticuloDTO (resultado)
	 * @throws ProductDomainException
     * wjrc - Agosto 2007 */    
	public ArticuloDTO getIndicadorValorar(ArticuloDTO entrada) 
		throws ProductDomainException
	{
		cat.debug("Inicio:getIndicadorValorar()");
		ArticuloDTO resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt =null;
		try {
			String call = getSQLDatos("AL_Servicios_Almacenes_PG","AL_indicador_valorar_PR",5);
			
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);

			cstmt.setString(1,entrada.getNumeroSerie());
			cat.debug("entrada.getNumeroSerie()" + entrada.getNumeroSerie());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getIndicadorValorar:execute");
			cstmt.execute();
			cat.debug("Fin:getIndicadorValorar:execute");
			
			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);

			if (codError!=0){
				cat.error("Ocurrió un error al recuperar indicador valorar");
				throw new ProductDomainException(
						"Ocurrió un error al recuperar indicador valorar", String
								.valueOf(codError), numEvento, msgError);
			}
			else
				resultado.setIndicadorValorar(cstmt.getString(2));
			
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar indicador valorar",e);
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
		cat.debug("Fin:getIndicadorValorar()");
		return resultado;
	}//fin getIndicadorValorar

	/** Servicios Activaciones WEB - Colombia
	 * MAYORISTAS
	 * Obtine verificacion venta mayorista
	 * @param ArticuloDTO (entrada)
	 * @return ArticuloDTO (resultado)
	 * @throws ProductDomainException
     * wjrc - Agosto 2007 */    
	public ArticuloDTO getVentaMayorista(ArticuloDTO entrada) 
		throws ProductDomainException
	{		
		cat.debug("Inicio:getVentaMayorista()");
		ArticuloDTO resultado = entrada;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt =null;
		try {
			String call = getSQLDatos("AL_Servicios_Almacenes_PG","AL_venta_mayorista_PR",8);
			
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);

			cstmt.setString(1,entrada.getNumeroSerie());
			cat.debug("entrada.getNumeroSerie()" + entrada.getNumeroSerie());			
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getVentaMayorista:execute");			
			cstmt.execute();			
			cat.debug("Fin:getVentaMayorista:execute");
			
			codError = cstmt.getInt(6);
			msgError = cstmt.getString(7);
			numEvento = cstmt.getInt(8);

			cat.debug("codError " + codError);
			cat.debug("msgError " + msgError);
			cat.debug("numEvento " + numEvento);

			if (codError!=0){
				cat.error("Ocurrió un error al verificar venta mayorista");
				throw new ProductDomainException(
						"Serie No recepcionada por Nota Pedido Web", String
								.valueOf(codError), numEvento, "Serie No recepcionada por Nota Pedido Web");
			}
			else{
				resultado.setCodigoUso(Integer.parseInt(cstmt.getString(2)));
				resultado.setDescripcionUso(cstmt.getString(3));
				resultado.setCodigo(Long.parseLong((cstmt.getString(4))));
				resultado.setDescripcion(cstmt.getString(5));

				cat.debug("setCodigoUso " + resultado.getCodigoUso());
				cat.debug("setDescripcionUso " + resultado.getDescripcionUso());
				cat.debug("setCodigo " + resultado.getCodigo());
				cat.debug("setDescripcion " + resultado.getDescripcion());
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al verificar venta mayorista",e);
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
		cat.debug("Fin:getVentaMayorista()");
		return resultado;
	}//fin getVentaMayorista
	
	public ArticuloInDTO[] getArticulos(ArticuloInDTO articulo) 
		throws ProductDomainException
	{
		cat.debug("Inicio:getArticulos()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ArticuloInDTO[] resultado = null;
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();
		ResultSet rs = null;
		cat.debug("Conexion obtenida OK");
		
		try {
			
		   String call = getSQLDatos("VE_PARAMETROS_COMERCIALES_PG", "VE_Obtiene_Articulos_PR",9);
		   cat.debug("sql[" + call + "]");
		   
		   cstmt = conn.prepareCall(call);
		   
		   cstmt.setString(1,articulo.getCod_tecnologia());
		   cat.debug("entrada.getCod_tecnologia()" + articulo.getCod_tecnologia());
		   cstmt.setString(2,articulo.getTipTerminal());
		   cat.debug("entrada.getTipTerminal()" + articulo.getTipTerminal());
		   cstmt.setString(3,articulo.getIndEquipo());	
		   cat.debug("entrada.getIndEquipo()" + articulo.getIndEquipo());
		   cstmt.setInt(4,articulo.getCodUso());
		   cat.debug("entrada.getCodUso()" + articulo.getCodUso());
		   //P-CSR-11002 JLGN 27-10-2011
		   cstmt.setLong(5,articulo.getCodBodega());
		   cat.debug("entrada.getCodBodega()" + articulo.getCodBodega());
		   cstmt.registerOutParameter(6,OracleTypes.CURSOR);
		   cstmt.registerOutParameter(7,java.sql.Types.NUMERIC);
		   cstmt.registerOutParameter(8,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(9,java.sql.Types.NUMERIC);
		     
		   cstmt.execute();		   
		   cat.debug("getListadoArticulo:Execute Despues");
		   
		   codError = cstmt.getInt(7);
		   msgError = cstmt.getString(8);
		   numEvento = cstmt.getInt(9);
		 
		   cat.debug("codError[" + codError + "]");
		   cat.debug("msgError[" + msgError + "]");
		   cat.debug("numEvento[" + numEvento + "]");
		   
		   if (codError!=0) 
		   {   		    
			    cat.error("Ocurrió un error al recuperar listado de articulos ");
			    throw new ProductDomainException("Ocurrió un error al recuperar listado de articulos", 
			    		String.valueOf(codError), numEvento, msgError);
		    
			}else{
				cat.debug("Recuperando listado de articulos");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(6);
				while (rs.next()) 
				{
					ArticuloInDTO articuloDTO = new ArticuloInDTO();
					articuloDTO.setCodArticulo(rs.getLong(1));
					articuloDTO.setDesArticulo(rs.getString(2));
					articuloDTO.setMesGarantia(rs.getInt(3));		
					articuloDTO.setTipoArticulo(rs.getLong(4));
					lista.add(articuloDTO);
				}				
				resultado =(ArticuloInDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), ArticuloInDTO.class);
		  
				cat.debug("Fin recuperacion de listado de articulos");
			}
		   
		   if (cat.isDebugEnabled())
		    cat.debug(" Finalizo ejecución");
		  } 
		  catch (Exception e) {
			   cat.error("Ocurrió un error al obtener listado de articulos",e);
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
				   if (rs != null) {
						rs.close();
					}
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
		  cat.debug("getArticulos():end");
		return resultado;
	}//fin getArticulo
	
	//Inicio P-CSR-11002 JLGN 27-04-2011
	public void actualizaUsoTerminal(ArticuloDTO articulo, String codUsoNuevo) 
	throws ProductDomainException
{
	cat.debug("Inicio:actualizaUsoTerminal()");
	int codError = 0;
	String msgError = null;
	int numEvento = 0;
	Connection conn = null;
	CallableStatement cstmt =null;
	conn = getConection();
	ResultSet rs = null;
	cat.debug("Conexion obtenida OK");
	
	try {
		
	   String call = getSQLDatos("VE_PARAMETROS_COMERCIALES_PG", "ve_cambio_uso_series_pr",6);
	   cat.debug("sql[" + call + "]");
	   
	   cstmt = conn.prepareCall(call);
	   
	   cstmt.setString(1,articulo.getNumeroSerie());
	   cat.debug("articulo.getNumeroSerie(): "+articulo.getNumeroSerie());
	   cstmt.setString(2, articulo.getNombreUsuario());
	   cat.debug("articulo.getNombreUsuario(): "+articulo.getNombreUsuario());
	   cstmt.setInt(3, Integer.parseInt(codUsoNuevo));
	   cat.debug("codUsoNuevo: "+codUsoNuevo);
	   cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);
	   cstmt.registerOutParameter(5,java.sql.Types.VARCHAR);
	   cstmt.registerOutParameter(6,java.sql.Types.NUMERIC);
	     
	   cstmt.execute();		   
	   cat.debug("actualizaUsoTerminal:Execute Despues");
	   
	   codError = cstmt.getInt(4);
	   msgError = cstmt.getString(5);
	   numEvento = cstmt.getInt(6);
	 
	   cat.debug("codError[" + codError + "]");
	   cat.debug("msgError[" + msgError + "]");
	   cat.debug("numEvento[" + numEvento + "]");
	   
	   if (codError!=0) 
	   {   		    
		    cat.error("Ocurrió un error al Actualizar Uso del terminal");
		    throw new ProductDomainException("Ocurrió un error al Actualizar Uso del terminal", 
		    		String.valueOf(codError), numEvento, msgError);
	    
		}			   
	   if (cat.isDebugEnabled())
	    cat.debug(" Finalizo ejecución");
	  } 
	  catch (Exception e) {
		   cat.error("Ocurrió un error al Actualizar Uso del terminal",e);
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
			   if (rs != null) {
					rs.close();
				}
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
	  cat.debug("actualizaUsoTerminal():end");
}//fin actualizaUsoTerminal
	//Fin P-CSR-11002 JLGN 27-04-2011
	
}//fin class Articulo
