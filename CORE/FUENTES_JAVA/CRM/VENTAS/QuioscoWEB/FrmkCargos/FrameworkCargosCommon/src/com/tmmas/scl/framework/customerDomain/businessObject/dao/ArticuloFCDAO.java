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
package com.tmmas.scl.framework.customerDomain.businessObject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.scl.framework.customerDomain.businessObject.dao.interfaces.ArticuloFCDAOIT;
import com.tmmas.scl.framework.customerDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ArticuloDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerBillException;

public class ArticuloFCDAO extends ConnectionDAO implements ArticuloFCDAOIT{
	
	private final Logger logger = Logger.getLogger(ArticuloFCDAO.class);
	Global global = Global.getInstance();
	
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
	 * @throws CustomerBillException
	 */

	
	public ArticuloDTO getArticulo(ArticuloDTO entrada) throws CustomerBillException{
		logger.debug("Inicio:getArticulo()");
		ArticuloDTO resultado = entrada;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		try {
			String call = getSQLDatos("AL_Servicios_Almacenes_PG","AL_consulta_articulo_PR",8);
			
			logger.debug("sql[" + call + "]");
			conn=getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			CallableStatement cstmt = conn.prepareCall(call);

			//cstmt.setLong(1,entrada.getCodigo());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);

			logger.debug("Inicio:getArticulo:execute");
			cstmt.execute();
			logger.debug("Fin:getArticulo:execute");
			
			codError = cstmt.getInt(6);
			msgError = cstmt.getString(7);
			numEvento = cstmt.getInt(8);
			logger.debug("msgError[" + msgError + "]");
			if (codError!=0){
				logger.error("Ocurrió un error al recuperar los datos del articulo");
				throw new CustomerBillException(
						"Ocurrió un error al recuperar los datos del articulo", String
								.valueOf(codError), numEvento, msgError);
			}
			else
			{
				/*resultado.setTipo(cstmt.getString(2));
				resultado.setDescripcion(cstmt.getString(3));
				resultado.setCodigoConceptoArticulo(cstmt.getInt(4));
				resultado.setCodigoConceptoDescuento(cstmt.getString(5));*/
			}
			
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			logger.error("Ocurrió un error al recuperar los datos del articulo",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
				logger.debug("Cerrando conexiones...");
	    try {
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				logger.debug("SQLException", e);
		  }
		}
		logger.debug("Fin:getArticulo()");
		return resultado;
	}//fin getArticulo
	
	/**
	 * Obtiene los datos del articulo 
	 * @param entrada
	 * @return N/A
	 * @throws CustomerBillException
    */
	/*
	public void insReservaArticulo(ArticuloDTO entrada)	throws CustomerBillException{
		logger.debug("Inicio:insReservaArticulo()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		
		try {
			String call = getSQLDatos("Ve_Servicios_Venta_Pg","VE_insReservaArticulo_PR",13);
			conn=getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			logger.debug("sql[" + call + "]");
			CallableStatement cstmt = conn.prepareCall(call);

			logger.debug("reserva:insReservaArticulo");
			logger.debug("reserva:NumeroLinea " + entrada.getNumeroLinea());
			logger.debug("reserva:NumeroOrden " + entrada.getNumeroOrden());
			logger.debug("reserva:Codigo " + entrada.getCodigo());
			logger.debug("reserva:CodigoProducto " + entrada.getCodigoProducto());
			logger.debug("reserva:CodigoBodega " + entrada.getCodigoBodega());
			logger.debug("reserva:TipoStock " + entrada.getTipoStock());
			logger.debug("reserva:CodigoUso " + entrada.getCodigoUso());
			logger.debug("reserva:CodigoEstado " + entrada.getCodigoEstado());
			logger.debug("reserva:NombreUsuario " + entrada.getNombreUsuario());
			logger.debug("reserva:NumeroSerie " + entrada.getNumeroSerie());
			
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

			logger.debug("Inicio:insReservaArticulo:execute");
			cstmt.execute();
			logger.debug("Fin:insReservaArticulo:execute");
			
			codError = cstmt.getInt(11);
			msgError = cstmt.getString(12);
			numEvento = cstmt.getInt(13);
			
			logger.debug("reserva:[" + codError + "]");
			logger.debug("reserva:[" + msgError + "]");

			if (codError!=0){
				logger.error("Ocurrió un error al insertar reserva del articulo");
				throw new CustomerBillException(
						"Ocurrió un error al insertar reserva del articulo", String
								.valueOf(codError), numEvento, msgError);
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			logger.error("Ocurrió un error al insertar reserva del articulo",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
				logger.debug("Cerrando conexiones...");
	    try {
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				logger.debug("SQLException", e);
		  }
		}
		logger.debug("Fin:insReservaArticulo()");
	}//fin insReservaArticulo
	
	/**
	 * Obtiene los datos del articulo 
	 * @param entrada
	 * @return resultado
	 * @throws CustomerBillException
	*/
   /* public ArticuloDTO ActualizaStock(ArticuloDTO entrada) 
	throws CustomerBillException{
		logger.debug("Inicio:ActualizaStock()");
		ArticuloDTO resultado = entrada;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		
		try {
			String call = getSQLDatos("VE_Servicios_Venta_PG","VE_ActualizaStock_PR",12);
			conn=getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			logger.debug("sql[" + call + "]");
			CallableStatement cstmt = conn.prepareCall(call);

			cstmt.setString(1,entrada.getTipoMovimiento());
			logger.debug("entrada.getTipoMovimiento()" + entrada.getTipoMovimiento());
			cstmt.setString(2,String.valueOf(entrada.getTipoStock()));
			logger.debug("entrada.getTipoStock()" + entrada.getTipoStock());
			cstmt.setString(3,String.valueOf(entrada.getCodigoBodega()));
			logger.debug("entrada.getCodigoBodega()" + entrada.getCodigoBodega());
			cstmt.setString(4,String.valueOf(entrada.getCodigo()));
			logger.debug("entrada.getCodigo()" + entrada.getCodigo());
			cstmt.setString(5,String.valueOf((entrada.getCodigoUso())));
			logger.debug("entrada.getCodigoUso()" + entrada.getCodigoUso());
			cstmt.setString(6,String.valueOf((entrada.getCodigoEstado())));
			logger.debug("entrada.getCodigoEstado()" + entrada.getCodigoEstado());
			cstmt.setString(7,entrada.getNumeroVenta());
			logger.debug("entrada.getNumeroVenta()" + entrada.getNumeroVenta());
			cstmt.setString(8,entrada.getNumeroSerie());
			logger.debug("entrada.getNumeroSerie()" + entrada.getNumeroSerie());
			
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(12, java.sql.Types.NUMERIC);

			logger.debug("Inicio:ActualizaStock:execute");
			cstmt.execute();
			logger.debug("Fin:ActualizaStock:execute");
			
			codError = cstmt.getInt(10);
			msgError = cstmt.getString(11);
			numEvento = cstmt.getInt(12);

			logger.debug("msgError[" + msgError + "]");

			if (codError!=0){
				logger.error("Ocurrió un error al actualizar stock");
				throw new CustomerBillException(
						"Ocurrió un error al actualizar stock", String
								.valueOf(codError), numEvento, msgError);
			}
			else
				resultado.setNumeroMovimiento(cstmt.getString(9));
			
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			logger.error("Ocurrió un error al actualizar stock",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
				logger.debug("Cerrando conexiones...");
	    try {
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				logger.debug("SQLException", e);
		  }
		}
		logger.debug("Fin:ActualizaStock()");
		return resultado;
	}//fin ActualizaStock
    //07011 Inicio Igo
	public ArticuloOutDTO[] getListadoArticulos() throws CustomerBillException{
		   System.out.println(" ************** Ingreso a getListadoArticulo **************** ");
			logger.debug("Inicio:getListadoArticulo()");
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			ArticuloOutDTO[] resultado = null;
			Connection conn = null;
			CallableStatement cstmt =null;
			
			logger.debug("Conexion obtenida OK");
		  try {
			  String call = getSQLDatos("Ve_Servs_ActivacionesWeb_Pg", "VE_getListArticulos_PR",5);
		   logger.debug("sql[" + call + "]");
		   conn=getConnectionFromWLSInitialContext(global.getJndiForDataSource());
		   cstmt = conn.prepareCall(call);

		   cstmt.registerOutParameter(2,java.sql.Types.NUMERIC);
		   cstmt.registerOutParameter(3,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);
		   
		   System.out.println(" getListadoArticulo ANTES EXECUTE");
		 
		   System.out.println(" Inicio:getListadoArticulo:Execute");
		   cstmt.execute();
		   System.out.println(" Fin:getListadoArticulo:Execute");
		   logger.debug("getListadoArticulo:Execute Despues");
		   
		   codError = cstmt.getInt(3);
		   msgError = cstmt.getString(4);
		   numEvento = cstmt.getInt(5);
		 
		   logger.debug("codError[" + codError + "]");
		   logger.debug("msgError[" + msgError + "]");
		   logger.debug("numEvento[" + numEvento + "]");
		   
		   if (codError != 0) {
			   System.out.println(" ************** getListadoArticulo codError : " + codError);
		    codError = 10;
		    numEvento = 10;
		    msgError = "No se pudo recuperar información";
		    
		    logger.error("Ocurrió un error al recuperar listado de articulos ");
		    throw new CustomerBillException(
		      "Ocurrió un error al recuperar listado de articulos", String
		        .valueOf(codError), numEvento, msgError);
		    
			}else{
				logger.debug("Recuperando listado de articulos");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(3);
				while (rs.next()) {
					ArticuloOutDTO articuloOutDTO = new ArticuloOutDTO();
					articuloOutDTO.setCodigo(rs.getLong(1));
					articuloOutDTO.setDescripcion(rs.getString(2));
					articuloOutDTO.setCodModelo(rs.getString(3));
					articuloOutDTO.setCodFabricante(rs.getString(4));
					articuloOutDTO.setDesFabricante(rs.getString(5));
					lista.add(articuloOutDTO);
				}
				rs.close();
				resultado =(ArticuloOutDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), ArticuloOutDTO.class);
		  
				logger.debug("Fin recuperacion de listado de articulos");
			}
		   
		   if (logger.isDebugEnabled())
		    logger.debug(" Finalizo ejecución");
		  } catch (Exception e) {
		   logger.error("Ocurrió un error al obtener listado de articulos",e);
		   if (logger.isDebugEnabled()) {
		    logger.debug("Codigo de Error[" + codError + "]");
		    logger.debug("Mensaje de Error[" + msgError + "]");
		    logger.debug("Numero de Evento[" + numEvento + "]");
		   }
		  } finally {
		    if (logger.isDebugEnabled()) 
		    logger.debug("Cerrando conexiones...");
		   try {
		    if (cstmt!=null)
		     cstmt.close();
		    if (!conn.isClosed()) {
		     conn.close();
		    }
		   } catch (SQLException e) {
		    logger.debug("SQLException", e);
		   }
		  }
		  logger.debug("getListadoArticulo():end");
		return resultado;
	}//fin getArticulo
    
	/** Servicios Activaciones WEB - Colombia
	 * MAYORISTAS
	 * Obtine indicador valorar
	 * @param ArticuloDTO (entrada)
	 * @return ArticuloDTO (resultado)
	 * @throws CustomerBillException
     * wjrc - Agosto 2007 */    
	/*public ArticuloDTO getIndicadorValorar(ArticuloDTO entrada) throws CustomerBillException{
		logger.debug("Inicio:getIndicadorValorar()");
		ArticuloDTO resultado = null;

		logger.debug("Fin:getIndicadorValorar()");
		return resultado;
	}//fin getIndicadorValorar*/
	
}//fin class Articulo
