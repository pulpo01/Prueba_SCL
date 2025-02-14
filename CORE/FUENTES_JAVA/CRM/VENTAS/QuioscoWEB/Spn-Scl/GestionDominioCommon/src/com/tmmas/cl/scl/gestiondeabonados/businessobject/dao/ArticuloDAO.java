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
package com.tmmas.cl.scl.gestiondeabonados.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ArticuloDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.helper.Global;

public class ArticuloDAO extends ConnectionDAO{
	
	private static Category cat = Category.getInstance(ArticuloDAO.class);
	Global global = Global.getInstance();
	
	private Connection getConection() 
	throws GeneralException {
		Connection conn = null;
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
		} catch (Exception e1) {
			conn = null;
			cat.error(" No se pudo obtener una conexión ", e1);
			throw new GeneralException("No se pudo obtener una conexión", e1);
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
	 * @throws GeneralException
	 */

	
	public ArticuloDTO getArticulo(ArticuloDTO entrada) 
	throws GeneralException{
		cat.debug("Inicio:getArticulo()");
		ArticuloDTO resultado = entrada;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		try {
			//INI-01 (AL) String call = getSQLDatos("AL_Servicios_Almacenes_PG","AL_consulta_articulo_PR",9);
			String call = getSQLDatos("AL_SERVICIOS_ALMAC_QUIOSCO_PG","AL_consulta_articulo_PR",9);
			
			cat.debug("sql[" + call + "]");
			CallableStatement cstmt = conn.prepareCall(call);

			cstmt.setLong(1,entrada.getCodigo());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getArticulo:execute");
			cstmt.execute();
			cat.debug("Fin:getArticulo:execute");
			
			codError = cstmt.getInt(7);
			msgError = cstmt.getString(8);
			numEvento = cstmt.getInt(9);
						
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");
			
			if (codError!=0){
				cat.error("Ocurrió un error al recuperar los datos del articulo");
				throw new GeneralException(
						"Ocurrió un error al recuperar los datos del articulo", String
								.valueOf(codError), numEvento, msgError);
			}
			else
			{
				resultado.setTipo(cstmt.getString(2));
				resultado.setDescripcion(cstmt.getString(3));
				resultado.setCodigoConceptoArticulo(cstmt.getInt(4));
				resultado.setCodigoConceptoDescuento(cstmt.getString(5));
				resultado.setTipTerminal(cstmt.getString(6));
			}
			
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		}catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar los datos del articulo",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al recuperar los datos del articulo",e);
		} finally {
				cat.debug("Cerrando conexiones...");
	    try {
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
	
	public ArticuloDTO[] getListArticulo(ArticuloDTO entrada) throws GeneralException{
		cat.debug("Inicio:getListArticulo()");
		ArticuloDTO resultado = entrada;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		try {
			//INI-01 (AL) String call = getSQLDatos("AL_Servicios_Almacenes_PG","AL_consulta_articulo_PR",8);
			String call = getSQLDatos("AL_SERVICIOS_ALMAC_QUIOSCO_PG","AL_consulta_articulo_PR",8);
			
			cat.debug("sql[" + call + "]");
			CallableStatement cstmt = conn.prepareCall(call);

			cstmt.setLong(1,entrada.getCodigo());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getArticulo:execute");
			cstmt.execute();
			cat.debug("Fin:getArticulo:execute");
			
			codError = cstmt.getInt(6);
			msgError = cstmt.getString(7);
			numEvento = cstmt.getInt(8);
			
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");
			
			if (codError!=0){
				cat.error("Ocurrió un error al recuperar los datos del articulo");
				throw new GeneralException(
						"Ocurrió un error al recuperar los datos del articulo", String
								.valueOf(codError), numEvento, msgError);
			}
			else
			{
				resultado.setTipo(cstmt.getString(2));
				resultado.setDescripcion(cstmt.getString(3));
				resultado.setCodigoConceptoArticulo(cstmt.getInt(4));
				resultado.setCodigoConceptoDescuento(cstmt.getString(5));
			}
			
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		}catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar los datos del articulo",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al recuperar los datos del articulo",e);
		} finally {
				cat.debug("Cerrando conexiones...");
	    try {
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				cat.debug("SQLException", e);
		  }
		}
		cat.debug("Fin:getArticulo()");
		return null;//resultado;
	}//fin getArticulo
	
	/**
	 * Obtiene los datos del articulo 
	 * @param entrada
	 * @return N/A
	 * @throws GeneralException
    */
	public void insReservaArticulo(ArticuloDTO entrada) 
	throws GeneralException{
		cat.debug("Inicio:insReservaArticulo()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		try {
			//INI-01 (AL) String call = getSQLDatos("Ve_Servicios_Venta_Pg","VE_insReservaArticulo_PR",14);
			String call = getSQLDatos("Ve_Servicios_Venta_Quiosco_Pg","VE_insReservaArticulo_PR",14);
			
			cat.debug("sql[" + call + "]");
			CallableStatement cstmt = conn.prepareCall(call);

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
			cstmt.setString(11,entrada.getNumeroTransaccion());
					   
			cstmt.registerOutParameter(12, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(14, java.sql.Types.NUMERIC);

			cat.debug("Inicio:insReservaArticulo:execute");
			cstmt.execute();
			cat.debug("Fin:insReservaArticulo:execute");
			
			codError = cstmt.getInt(12);
			msgError = cstmt.getString(13);
			numEvento = cstmt.getInt(14);
			
			cat.debug("reserva:[" + codError + "]");
			cat.debug("reserva:[" + msgError + "]");

			if (codError!=0){
				cat.error("Ocurrió un error al insertar reserva del articulo");
				throw new GeneralException(
						"Ocurrió un error al insertar reserva del articulo", String
								.valueOf(codError), numEvento, msgError);
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		}catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al insertar reserva del articulo",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al insertar reserva del articulo",e);
			
		} finally {
				cat.debug("Cerrando conexiones...");
	    try {
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
	 * @throws GeneralException
	*/
    public ArticuloDTO ActualizaStock(ArticuloDTO entrada) 
	throws GeneralException{
		cat.debug("Inicio:ActualizaStock()");
		ArticuloDTO resultado = entrada;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		try {
			//INI-01 (AL) String call = getSQLDatos("VE_Servicios_Venta_PG","VE_ActualizaStock_PR",12);
			String call = getSQLDatos("VE_Servicios_Venta_Quiosco_PG","VE_ActualizaStock_PR",12);
			
			cat.debug("sql[" + call + "]");
			CallableStatement cstmt = conn.prepareCall(call);

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

			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError!=0){
				cat.error("Ocurrió un error al actualizar stock");
				throw new GeneralException(
						"Ocurrió un error al actualizar stock", String
								.valueOf(codError), numEvento, msgError);
			}
			else
				resultado.setNumeroMovimiento(cstmt.getString(9));
			
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
			
		}catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al actualizar stock",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al actualizar stock",e);
		} finally {
				cat.debug("Cerrando conexiones...");
	    try {
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
    
    
    public String SalidaDefArticulo(String codArticulo, String nomUsuario, String numVenta, String codVendedor, int numCantidad, String codBodega) 
	throws GeneralException{
		cat.debug("Inicio:ActualizaStock()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		String numMovimiento = new String();
		
		
		try {
			String call = getSQLDatos("al_series_portabilidad_pg","al_sal_def_art_vend_pr",10);
			
			cat.debug("sql[" + call + "]");
			CallableStatement cstmt = conn.prepareCall(call);

			cstmt.setString(1,codArticulo);
			cat.debug("codArticulo [" + codArticulo +"]");
			cstmt.setString(2,nomUsuario);
			cat.debug("nomUsuario [" + nomUsuario +"]");
			cstmt.setString(3,numVenta);
			cat.debug("numVenta [" + numVenta +"]");
			cstmt.setString(4,codVendedor);
			cat.debug("codVendedor [" + codVendedor +"]");
			cstmt.setInt(5,numCantidad);
			cat.debug("numCantidad [" + numCantidad +"]");
			cstmt.setLong(6, Long.valueOf(codBodega).longValue());
			cat.debug("codBodega [" + codBodega +"]");
			
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);

			cat.debug("Inicio:ActualizaStock:execute");
			cstmt.execute();
			cat.debug("Fin:ActualizaStock:execute");
			
			codError = cstmt.getInt(8);
			msgError = cstmt.getString(9);
			numEvento = cstmt.getInt(10);

			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError!=0){
				cat.error("Ocurrió un error al actualizar stock");
				throw new GeneralException(
						"Ocurrió un error al actualizar stock", String
								.valueOf(codError), numEvento, msgError);
			}
			else
				numMovimiento = cstmt.getString(7);
			
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
			
		}catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al actualizar stock",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al actualizar stock",e);
		} finally {
				cat.debug("Cerrando conexiones...");
	    try {
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				cat.debug("SQLException", e);
		  }
		}
		cat.debug("Fin:ActualizaStock()");
		return numMovimiento;
	}//fin ActualizaStock    
    
    
    public ArticuloDTO[] getListArticuloPorCodigo(ArticuloDTO articuloDTO)throws GeneralException{
		cat.debug("Inicio:getListArticuloPorCodigo()");
		ArticuloDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement  cstmt =null;
		ResultSet rs = null;
		conn = getConection();
		try {
			
			  /*EN_codarticulo     IN              al_series.cod_articulo%TYPE,
		      EN_codbodega      IN      al_series.cod_bodega%TYPE,
		      EN_codVendedor    IN      ve_vendalmac.cod_vendedor%TYPE,
		      EN_codUso    IN      al_series.cod_uso%TYPE,
		      sc_cursordatos    OUT NOCOPY      refcursor,
		      sn_cod_retorno    OUT NOCOPY      ge_errores_pg.coderror,
		      sv_mens_retorno   OUT NOCOPY      ge_errores_pg.msgerror,
		      sn_num_evento     OUT NOCOPY      ge_errores_pg.evento*/
			
			
			//INI-01 (AL) String call = getSQLDatos("VE_Servicios_Venta_PG","VE_consulta_seriexcodarti_PR",8);
			String call = getSQLDatos("VE_Servicios_Venta_Quiosco_PG","VE_consulta_seriexcodarti_PR",8);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			
			cat.debug("Articulo:DAO:CodigoArticulo      : " + articuloDTO.getCodigo());
			cat.debug("Articulo:DAO:CodigoBodega      : " + articuloDTO.getCodigoBodega());
			cat.debug("Articulo:DAO:CodigoVendedor : " + articuloDTO.getCodVendedor());
			cat.debug("Articulo:DAO:CodigoUso           : " + articuloDTO.getCodigoUso());
			
			//-- PARAMETROS DE ENTRADA
			cstmt.setLong(1,articuloDTO.getCodigo());
			cstmt.setInt(2,articuloDTO.getCodigoBodega());
			cstmt.setLong(3,articuloDTO.getCodVendedor());
			cstmt.setInt(4,articuloDTO.getCodigoUso());
			

			//-- PARAMETROS DE SALIDA
			cstmt.registerOutParameter(5,OracleTypes.CURSOR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getListArticuloPorCodigo:Execute");
			cstmt.execute();
			cat.debug("Fin:getListArticuloPorCodigo:Execute");
			
			codError = cstmt.getInt(6);
			msgError = cstmt.getString(7);
			numEvento = cstmt.getInt(8);

			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");
			
			if (codError != 0) {
				cat.error("Ocurrió un error al getListArticuloPorCodigo");
				throw new GeneralException(
						"Ocurrió un error getListArticuloPorCodigo", String
								.valueOf(codError), numEvento, msgError);
				
			}else{
				cat.debug("getListArticuloPorCodigo");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(5);
				while (rs.next()) {
					
					/* series.num_serie,series.num_telefono,
					   series.tip_stock*/
					
					ArticuloDTO articulo = new ArticuloDTO();
					articulo.setCodigo(rs.getLong(1));
					articulo.setCodigoConceptoArticulo(rs.getInt(2));
					articulo.setCodigoConceptoDescuento(rs.getString(3));
					articulo.setDescripcion(rs.getString(4));
					articulo.setTipo(rs.getString(5));
					articulo.setTipTerminal(rs.getString(6));
					articulo.setCodTecnologia(rs.getString(7));
					articulo.setCodigoBodega(rs.getInt(8));
					articulo.setCodCentral(rs.getString(9));
					articulo.setCodigoEstado(rs.getInt(10));
					articulo.setCodHLR(rs.getString(11));
					articulo.setCodPlaza(rs.getString(12));
					articulo.setCodSubAlm(rs.getString(13));
					articulo.setCodigoUso(rs.getInt(14));
					articulo.setNumeroSerie(rs.getString(15));
					articulo.setNumeroLinea(rs.getInt(16));
					articulo.setTipoStock(rs.getInt(17));
					
					lista.add(articulo);
					cat.debug("EgetListArticuloPorCodigo");
				}
				rs.close();
				resultado =(ArticuloDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), ArticuloDTO.class);
				
				cat.debug("Fin recuperacion getListArticuloPorCodigo");
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		}catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error getListArticuloPorCodigo",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error getListArticuloPorCodigo",e);
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
		
		cat.debug("Fin:getListArticuloPorCodigo()");

		return resultado;
	}//fin 

}//fin class Articulo
