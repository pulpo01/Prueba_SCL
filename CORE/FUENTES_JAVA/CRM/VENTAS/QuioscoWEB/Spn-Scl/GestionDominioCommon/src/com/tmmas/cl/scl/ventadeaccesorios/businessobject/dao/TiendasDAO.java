package com.tmmas.cl.scl.ventadeaccesorios.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.CajaDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.TiendaDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.TipificacionDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsCajaOutDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsInsertTiendaOutDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsTiendaVendedorOutDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsTiendasOutDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsUpdateTiendaOutDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.helper.Global;

public class TiendasDAO extends ConnectionDAO{
	private Global global = Global.getInstance();	
	private static Category cat = Category.getInstance(TiendasDAO.class);

	private Connection getConection() throws GeneralException
	{
		System.out.println("antes de conectarse");
		Connection conn = null;
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
		} catch (Exception e1) {
			conn = null;
			cat.error(" No se pudo obtener una conexión ", e1);
			System.out.println("DAO: No se pudo obtener una conexión");
			throw new GeneralException("No se pudo obtener una conexión con la Base de Datos", e1);
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
	}//fin getSQLDatosAbonado


	//Busca todas las tiendas configuradas en scl
	public WsTiendasOutDTO getTiendas ()throws GeneralException
	{
		cat.info("getTiendas():Inicio");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		WsTiendasOutDTO tiendasOutDTO = new WsTiendasOutDTO();
		try
		{			
			conn = getConection();
			String call = getSQLDatos("ve_tiendas_quiosco_pg", "ve_get_tiendas_pr", 4);			
			cat.debug("sql[" + call + "]");			
			cstmt = conn.prepareCall(call);
			
			
			//PARAMETROS DE SALIDA
			cstmt.registerOutParameter(1,OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getListArticuloPorCodigo:Execute");
			cstmt.execute();
			cat.debug("Fin:getListArticuloPorCodigo:Execute");
			
			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);

			cat.debug("codError: " + codError);
			cat.debug("msgError: " + msgError);
			cat.debug("numEvento: " + numEvento);
			
			tiendasOutDTO.setCodError(codError);
			tiendasOutDTO.setMsgError(msgError);
			tiendasOutDTO.setNumEvento(numEvento);
			
			if (codError != 0) {								
				cat.error("Ocurrió un error al  recuperar las tiendas");
				throw new GeneralException(
						"Ocurrió un error al  recuperar las tiendas", String
						.valueOf(codError), numEvento, msgError);

			}
			
			ArrayList lista = new ArrayList();
			TiendaDTO tienda = null;
			rs = (ResultSet) cstmt.getObject(1);
			
			while (rs.next()) {
				tienda = new TiendaDTO();
				tienda.setCodTienda(rs.getString(1));
				tienda.setDesTienda(rs.getString(2)); 
				tienda.setNomUsuarioVendedor(rs.getString(3));
				tienda.setNomUsuarioCajero(rs.getString(4));
				tienda.setNomUsuario(rs.getString(5));
				tienda.setCodCliente(rs.getString(6));
				tienda.setCodCaja(rs.getString(7));
				tienda.setDesCaja(rs.getString(8));
				tienda.setIndApliPago(rs.getString(9));
				lista.add(tienda);
			}
			
			tiendasOutDTO.setTiendaDTOs((TiendaDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), TiendaDTO.class));

		}catch (GeneralException e) {
			System.out.println("rescato la excepción y la lanzo");
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al  recuperar las tiendas",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al  recuperar las tiendas",e);

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
		cat.info("getTiendass():Fin");
		return tiendasOutDTO;
	}
	
	
	//Busca info de la tienda y el usuario
	public WsTiendaVendedorOutDTO getTiendaVendedor(String codTienda)throws GeneralException
	{
		cat.info("getTiendaVendedor():Inicio");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;		
		WsTiendaVendedorOutDTO resultado = new WsTiendaVendedorOutDTO();
		try
		{			
			conn = getConection();
			String call = getSQLDatos("ve_tiendas_quiosco_pg", "ve_get_infoVend_tienda_pr", 18);			
			cat.debug("sql[" + call + "]");			
			cstmt = conn.prepareCall(call);
			
			//PARAMETRO DE ENTRADA
			cstmt.setString(1,codTienda);
			
			//PARAMETROS DE SALIDA

			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR); //COD Caja
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR); // Des CAJA
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR); //Codigo vendedor
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR); //Codigo Oficina
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR); //Num Ident Cliente
			cstmt.registerOutParameter(11, java.sql.Types.VARCHAR); //Num Ident Cliente
			cstmt.registerOutParameter(12, java.sql.Types.VARCHAR); //Num Ident Cliente
			cstmt.registerOutParameter(13, java.sql.Types.VARCHAR); //Num Ident Cliente
			cstmt.registerOutParameter(14, java.sql.Types.VARCHAR); //cod_bodega
			cstmt.registerOutParameter(15, java.sql.Types.VARCHAR); //ind aplica pago	
			cstmt.registerOutParameter(16, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(18, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getListArticuloPorCodigo:Execute");
			cstmt.execute();
			cat.debug("Fin:getListArticuloPorCodigo:Execute");
			
			codError = cstmt.getInt(16);
			msgError = cstmt.getString(17);
			numEvento = cstmt.getInt(18);

			cat.debug("codError: " + codError);
			cat.debug("msgError: " + msgError);
			cat.debug("numEvento: " + numEvento);

			if (codError != 0) {								
				cat.error("Ocurrió un error al  recuperar los datos de la tienda y el usuario");
				throw new GeneralException(
						"Ocurrió un error al  recuperar datos de la tienda y el usuario", String
						.valueOf(codError), numEvento, msgError);

			}
			
			resultado.setDesTienda(cstmt.getString(2));
			resultado.setNomUsuario(cstmt.getString(3));
			resultado.setDesBodega(cstmt.getString(4));
			resultado.setNomVendedor(cstmt.getString(5));
			resultado.setCodCaja(cstmt.getString(6));
			resultado.setDesCaja(cstmt.getString(7));
			resultado.setCodVendedor(cstmt.getString(8));
			resultado.setCodOficina(cstmt.getString(9));
			resultado.setNumIdentCli(cstmt.getString(10));
			resultado.setCodCliente(cstmt.getString(11)); 
			resultado.setCodCuenta(cstmt.getString(12)); 
			resultado.setCodDireccion(cstmt.getString(13)); 
			resultado.setCodBodega(cstmt.getString(14));
			resultado.setIndApliPAgo(cstmt.getString(15));
			resultado.setCodError(codError);
			resultado.setMsgError(msgError);
			resultado.setNumEvento(numEvento);

		}catch (GeneralException e) {
			cat.debug("rescato la excepción y la lanzo");
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al  recuperar las tiendas",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al  recuperar las tiendas",e);

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
		cat.info("getTiendaVendedor():Fin");
		return resultado;
	}
	
	/*
	 * Metodo: insertTienda
	 * Descripcion: crea una tienda
	 * Fecha: 10/06/2010
	 * Developer: Gabriel Moraga L.
	 */
	
	public WsInsertTiendaOutDTO insertTienda(TiendaDTO tiendaDTO)throws GeneralException{
		
		cat.info("insertTienda():Inicio");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		//variable de salida
		Long codTienda = null;
		WsInsertTiendaOutDTO wsInsertTiendaOutDTO = null;

		try{
			
			conn = getConection();
			String call = getSQLDatos("ve_tiendas_quiosco_pg", "ve_insert_tienda_pr", 11);
			
			if(cat.isDebugEnabled()){
				cat.debug("sql[" + call + "]");
			}
			
			cstmt = conn.prepareCall(call);
	
			//PARAMETRO DE ENTRADA
			cstmt.setString(1,tiendaDTO.getDesTienda()); //Descripcion de la tienda
			cstmt.setString(2,tiendaDTO.getNomUsuarioVendedor()); //Nombre usuario vendedor
			cstmt.setString(3,tiendaDTO.getNomUsuarioCajero()); //Nombre usuario cajero
			cstmt.setString(4,tiendaDTO.getNomUsuario()); //Nombre Usuario
			cstmt.setString(5,tiendaDTO.getCodCliente()); //Codigo cliente
			cstmt.setString(6,tiendaDTO.getCodCaja()); //Codigo caja
			cstmt.setString(7,tiendaDTO.getIndApliPago()); //Ind aplica pago
			
			//PARAMETROS DE SALIDA
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR); //Codigo tienda
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC); //Codigo retorno
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR); //Mensaje retorno
			cstmt.registerOutParameter(11, java.sql.Types.NUMERIC); //Numero evento
			
			if(cat.isDebugEnabled()){
				cat.debug("Inicio:insertTienda:Execute");
			}
			cstmt.execute();
			
			if(cat.isDebugEnabled()){
				cat.debug("Fin:insertTienda:Execute");
			}
			
			//Asignacion codigo tienda
			codTienda = null == cstmt.getString(8) ? null : Long.valueOf(cstmt.getString(8));
			
			codError = cstmt.getInt(9);
			msgError = cstmt.getString(10);
			numEvento = cstmt.getInt(11);
			
			//Instancia DTO respuesta
			wsInsertTiendaOutDTO = new WsInsertTiendaOutDTO();

			wsInsertTiendaOutDTO.setCodTienda(codTienda);
			wsInsertTiendaOutDTO.setCodError(codError);
			wsInsertTiendaOutDTO.setMsgError(msgError);
			wsInsertTiendaOutDTO.setNumEvento(numEvento);
			
			if(cat.isDebugEnabled()){
				cat.debug("codError: " + codError);
				cat.debug("msgError: " + msgError);
				cat.debug("numEvento: " + numEvento);
			}
			
			if (codError != 0 && codError != 222) {
				
				cat.error("Ocurrió un error al crear la tienda");
				throw new GeneralException("Ocurrió un error al crear la tienda, ", String.valueOf(codError), numEvento, msgError);
			}

		}catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al crear la tiendas",e);
			
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			
			throw new GeneralException("Ocurrió un error al crear la tienda",e);

		} finally {
			if(cat.isDebugEnabled()){
				cat.debug("Cerrando conexiones...");
			}
			try {
				if( null != cstmt){
					cstmt.close();
				}
				if( null != conn ) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		
		cat.info("insertTienda():Fin");

		return wsInsertTiendaOutDTO;
		
	}
	
	/*
	 * Metodo: obtieneListaTienda
	 * Descripcion: Obtiene una lista de tienda
	 * Fecha: 10/06/2010
	 * Developer: Gabriel Moraga L.
	 */
	
	public List obtieneListaTienda()throws GeneralException{
		
		cat.info("obtieneListaTienda():Inicio");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		//variable de salida
		List listaTienda = null;
		TiendaDTO tiendaDTO = null;

		try{
			
			conn = getConection();
			String call = getSQLDatos("ve_tiendas_quiosco_pg", "ve_selec_curs_tienda_pr", 4);
			
			if(cat.isDebugEnabled()){
				cat.debug("sql[" + call + "]");
			}
			
			cstmt = conn.prepareCall(call);
	
			//PARAMETRO DE ENTRADA
			
			//PARAMETROS DE SALIDA
			cstmt.registerOutParameter(1, OracleTypes.CURSOR); //Codigo tienda
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC); //Codigo retorno
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR); //Mensaje retorno
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC); //Numero evento
			
			if(cat.isDebugEnabled()){
				cat.debug("Inicio:obtieneListaTienda:Execute");
			}
			cstmt.execute();
			
			if(cat.isDebugEnabled()){
			cat.debug("Fin:obtieneListaTienda:Execute");
			}
			
			//Asignacion cursor
			rs = (ResultSet) cstmt.getObject(1);
		
			//Fecha actual del sistema
			//java.util.Date fechaActual = new java.util.Date();
		
			listaTienda = new ArrayList(); 
			
			while (rs.next()) {
				
				tiendaDTO = new TiendaDTO();
				tiendaDTO.setCodTienda(rs.getString(1)); //COD_TIENDA
				tiendaDTO.setDesTienda(rs.getString(2)); //DES_TIENDA
				tiendaDTO.setNomUsuarioVendedor(rs.getString(3)); //NOM_USUARIO_VENDEDOR
				tiendaDTO.setNomUsuarioCajero(rs.getString(4)); //NOM_USUARIO_CAJERO
				tiendaDTO.setNomUsuario(rs.getString(5)); //NOM_USUARIO
				tiendaDTO.setCodCliente(rs.getString(6)); //COD_CLIENTE
				tiendaDTO.setCodCaja(rs.getString(7)); //COD_CAJA
				tiendaDTO.setDesCaja(rs.getString(8)); //DES_CAJA
				tiendaDTO.setIndApliPago(rs.getString(9)); //aplica pago
				
				listaTienda.add(tiendaDTO);
				
				//elimina referencia
				tiendaDTO = null;
				
			}
	
			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);

			if(cat.isDebugEnabled()){
				cat.debug("codError: " + codError);
				cat.debug("msgError: " + msgError);
				cat.debug("numEvento: " + numEvento);
			}
			
			if (codError != 0) {								
				cat.error("Ocurrió un error al recuperar las tiendas");
				throw new GeneralException("Ocurrió un error al recuperar las tiendas", String.valueOf(codError), numEvento, msgError);
			}

		}catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar las tiendas",e);
			
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			
			throw new GeneralException("Ocurrió un error al recuperar las tiendas",e);

		} finally {
			if(cat.isDebugEnabled()){
				cat.debug("Cerrando conexiones...");
			}
			try {
				if( null != rs){
					rs.close();
				}
				if( null != cstmt){
					cstmt.close();
				}
				if( null != conn ) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		
		cat.info("obtieneListaTienda():Fin");

		return listaTienda;
		
	}
	
	/*
	 * Metodo: updateTienda
	 * Descripcion: Actualiza una tienda
	 * Fecha: 10/06/2010
	 * Developer: Gabriel Moraga L.
	 */
	
	public WsUpdateTiendaOutDTO updateTienda(TiendaDTO tiendaDTO)throws GeneralException{
		
		cat.info("updateTienda():Inicio");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		WsUpdateTiendaOutDTO wsUpdateTiendaOutDTO = null;

		try{
			
			conn = getConection();
			String call = getSQLDatos("ve_tiendas_quiosco_pg", "ve_update_tienda_pr", 11);
			
			if(cat.isDebugEnabled()){
				cat.debug("sql[" + call + "]");
			}
			
			cstmt = conn.prepareCall(call);

			//PARAMETRO DE ENTRADA
            cstmt.setString(1,tiendaDTO.getCodTienda()); //Codigo tienda
            cat.debug("Codigo Tienda: "+tiendaDTO.getCodTienda());
			cstmt.setString(2,tiendaDTO.getDesTienda()); //Descripcion (Nombre) de la tienda
			cat.debug("Descripcion (Nombre) de la tienda: "+tiendaDTO.getDesTienda());
			cstmt.setString(3,tiendaDTO.getNomUsuarioVendedor()); //Nombre usuario vendedor
			cat.debug("Nombre usuario vendedor: "+tiendaDTO.getNomUsuarioVendedor());
			cstmt.setString(4,tiendaDTO.getNomUsuarioCajero()); //Nombre usuario cajero
			cat.debug("Nombre usuario cajero: "+tiendaDTO.getNomUsuarioCajero());
			cstmt.setString(5,tiendaDTO.getNomUsuario()); //Nombre Usuario
			cat.debug("Nombre Usuario: "+tiendaDTO.getNomUsuario());
			cstmt.setString(6,tiendaDTO.getCodCliente()); //Codigo cliente
			cat.debug("Codigo cliente: "+tiendaDTO.getCodCliente());
			cstmt.setString(7,tiendaDTO.getCodCaja()); //Codigo caja
			cat.debug("Codigo caja: "+tiendaDTO.getCodCaja());
			cstmt.setString(8,tiendaDTO.getIndApliPago()); //ind aplica pago
			cat.debug("ind aplica pago: "+tiendaDTO.getIndApliPago());
            
			//PARAMETROS DE SALIDA
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC); //Codigo retorno
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR); //Mensaje retorno
			cstmt.registerOutParameter(11, java.sql.Types.NUMERIC); //Numero evento
			
			if(cat.isDebugEnabled()){
				cat.debug("Inicio:updateTienda:Execute");
			}
			cstmt.execute();
			
			if(cat.isDebugEnabled()){
				cat.debug("Fin:updateTienda:Execute");
			}
			
			codError = cstmt.getInt(9);
			msgError = cstmt.getString(10);
			numEvento = cstmt.getInt(11);

			wsUpdateTiendaOutDTO = new WsUpdateTiendaOutDTO();
			wsUpdateTiendaOutDTO.setCodError(codError);
			wsUpdateTiendaOutDTO.setMsgError(msgError);
			wsUpdateTiendaOutDTO.setNumEvento(numEvento);
			
			if(cat.isDebugEnabled()){
				cat.debug("codError: " + codError);
				cat.debug("msgError: " + msgError);
				cat.debug("numEvento: " + numEvento);
			}
			
			if (codError != 0 && codError != 222) {								
				cat.error("Ocurrió un error al actualiza la tienda");
				throw new GeneralException("Ocurrió un error al actualizar la tienda", String.valueOf(codError), numEvento, msgError);
			}

		}catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al actualizar la tiendas",e);
			
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			
			throw new GeneralException("Ocurrió un error al actualizar la tienda",e);

		} finally {
			if(cat.isDebugEnabled()){
				cat.debug("Cerrando conexiones...");
			}
			try {
				if( null != cstmt){
					cstmt.close();
				}
				if( null != conn ) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		
		cat.info("updateTienda():Fin");
		
		return wsUpdateTiendaOutDTO;
	}
	
	/*
	 * Metodo: deleteTienda
	 * Descripcion: elimina una tienda
	 * Fecha: 10/06/2010
	 * Developer: Gabriel Moraga L.
	 */
	
	public void deleteTienda(Long codTienda)throws GeneralException{
		
		cat.info("deleteTienda():Inicio");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;

		try{
			
			conn = getConection();
			String call = getSQLDatos("ve_tiendas_quiosco_pg", "ve_delete_tienda_pr", 4);
			
			if(cat.isDebugEnabled()){
				cat.debug("sql[" + call + "]");
			}
			
			cstmt = conn.prepareCall(call);

			//PARAMETRO DE ENTRADA
            cstmt.setLong(1,codTienda.longValue()); //Codigo tienda
            
			//PARAMETROS DE SALIDA
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC); //Codigo retorno
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR); //Mensaje retorno
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC); //Numero evento
			
			if(cat.isDebugEnabled()){
				cat.debug("Inicio:deleteTienda:Execute");
			}
			cstmt.execute();
			
			if(cat.isDebugEnabled()){
				cat.debug("Fin:deleteTienda:Execute");
			}
			
			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);

			if(cat.isDebugEnabled()){
				cat.debug("codError: " + codError);
				cat.debug("msgError: " + msgError);
				cat.debug("numEvento: " + numEvento);
			}
			
			if (codError != 0) {								
				cat.error("Ocurrió un error al eliminar la tienda");
				throw new GeneralException("Ocurrió un error al eliminar la tienda", String.valueOf(codError), numEvento, msgError);
			}

		}catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al eliminar la tienda",e);
			
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			
			throw new GeneralException("Ocurrió un error al eliminar la tiendas",e);

		} finally {
			if(cat.isDebugEnabled()){
				cat.debug("Cerrando conexiones...");
			}
			try {
				if( null != cstmt){
					cstmt.close();
				}
				if( null != conn ) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		
		cat.info("deleteTienda():Fin");
		
	}
	
	/*
	 * Metodo: obtieneListaCaja
	 * Descripcion: Obtiene una lista de Caja
	 * Fecha: 02/07/2010
	 * Developer: Jorge González N.
	 */
	
	public WsCajaOutDTO getListaCaja(String codOficina)throws GeneralException{
		
		cat.info("getListaCaja():Inicio");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		//variable de salida
		List listaCaja = null;
		CajaDTO cajaDTO = null;
		WsCajaOutDTO cajaOutDTO = new WsCajaOutDTO();

		try{			
			conn = getConection();
			String call = getSQLDatos("ve_tiendas_quiosco_pg", "ve_get_cajas_pr", 5);
			
			if(cat.isDebugEnabled()){
				cat.debug("sql[" + call + "]");
			}			
			cstmt = conn.prepareCall(call);
	
			//PARAMETRO DE ENTRADA
			cstmt.setString(1, codOficina);
			
			//PARAMETROS DE SALIDA
			cstmt.registerOutParameter(2, OracleTypes.CURSOR); //Codigo caja, Descripcion Caja
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC); //Codigo retorno
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR); //Mensaje retorno
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC); //Numero evento
			
			if(cat.isDebugEnabled()){
				cat.debug("Inicio:getListaCaja:Execute");
			}
			cstmt.execute();
			
			if(cat.isDebugEnabled()){
			cat.debug("Fin:getListaCaja:Execute");
			}
			
			//Asignacion cursor
			rs = (ResultSet) cstmt.getObject(2);
		
			listaCaja = new ArrayList(); 
			
			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);

			cajaOutDTO.setCodError(codError);
			cajaOutDTO.setMsgError(msgError);
			cajaOutDTO.setNumEvento(numEvento);
			
			if(cat.isDebugEnabled()){
				cat.debug("codError: " + codError);
				cat.debug("msgError: " + msgError);
				cat.debug("numEvento: " + numEvento);
			}
			
			if (codError != 0) {								
				cat.error("Ocurrió un error al recuperar las cajas");
				throw new GeneralException("Ocurrió un error al recuperar las cajas", String.valueOf(codError), numEvento, msgError);
			}
			
			while (rs.next()) {
				
				cajaDTO = new CajaDTO();				
				cajaDTO.setCodCaja(rs.getString(1)); //COD_CAJA
				cajaDTO.setDesCaja(rs.getString(2)); //DES_CAJA
				listaCaja.add(cajaDTO);
			}
			
			cajaOutDTO.setCajaDTOs((CajaDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					listaCaja.toArray(), CajaDTO.class));
			
		}catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar las cajas",e);
			
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			
			throw new GeneralException("Ocurrió un error al recuperar las cajas",e);

		} finally {
			if(cat.isDebugEnabled()){
				cat.debug("Cerrando conexiones...");
			}
			try {
				if( null != rs){
					rs.close();
				}
				if( null != cstmt){
					cstmt.close();
				}
				if( null != conn ) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		
		cat.info("obtieneListaTienda():Fin");

		return cajaOutDTO;
		
	}
	
}
