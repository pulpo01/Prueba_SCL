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
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.DescuentoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ParametrosCargoSimcardDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.PrecioCargoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.WSCentralQuioscoOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CentralDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.ArticuloDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.DireccionDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.ParametrosCargosAccesoriosDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.TiendaDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsTiendasOutDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsVentaAccesoriosDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsVentaAccesoriosOutDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.helper.Global;

public class VentaAccesoriosDAO extends ConnectionDAO{
	private Global global = Global.getInstance();	
	private static Category cat = Category.getInstance(VentaAccesoriosDAO.class);

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
	}//fin getConection
	
	private String getSQLDatosAbonado(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
		for (int n = 1; n <= paramCount; n++) {
			sb.append("?");
			if (n < paramCount) sb.append(",");
		}
		return sb.append(")}").toString();
	}//fin getSQLDatosAbonado

	
	/*
	 * Inserta Accesorio reservado en la tabla al_movimientos
	 */
	public void insertAccesReservMovim (WsVentaAccesoriosOutDTO ventaAccesorio)throws GeneralException
	{
		cat.info("InsertAccesReservMovim():Inicio");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		
		try
		{			
			String call = getSQLDatosAbonado("ve_venta_accesorios_pg", "ve_ins_acce_reserv_movim_pr", 10);			
			cat.debug("sql[" + call + "]");			
			cstmt = conn.prepareCall(call);

			for (int i = 0; i < ventaAccesorio.getArticulo().length; i++){

					cstmt.setInt(1, ventaAccesorio.getArticulo()[i].getCodbodega());
					cat.debug("ventaAccesorio.getArticulo()[i].getCodbodega() [" + ventaAccesorio.getArticulo()[i].getCodbodega() + "]");
					cstmt.setInt(2, ventaAccesorio.getArticulo()[i].getCodArticulo());
					cat.debug("ventaAccesorio.getArticulo()[i].getCodArticulo() [" + ventaAccesorio.getArticulo()[i].getCodArticulo() + "]");
					cstmt.setInt(3, ventaAccesorio.getArticulo()[i].getCodUso());
					cat.debug("ventaAccesorio.getArticulo()[i].getCodUso() [" + ventaAccesorio.getArticulo()[i].getCodUso() + "]");
					cstmt.setString(4, ventaAccesorio.getNombreUsuario());
					cat.debug("ventaAccesorio.getNombreUsuario() [" + ventaAccesorio.getNombreUsuario() + "]");
					cstmt.setInt(5, ventaAccesorio.getArticulo()[i].getNumUnidades());
					cat.debug("ventaAccesorio.getArticulo()[i].getNumUnidades() [" + ventaAccesorio.getArticulo()[i].getNumUnidades() + "]");
					cstmt.setString(6, ventaAccesorio.getArticulo()[i].getNumSerie());
					cat.debug("ventaAccesorio.getArticulo()[i].getNumSerie() [" + ventaAccesorio.getArticulo()[i].getNumSerie() + "]");
					cstmt.setLong(7, ventaAccesorio.getNumTransaccion());
					cat.debug("ventaAccesorio.getNumTransaccion() [" + ventaAccesorio.getNumTransaccion() + "]");
					cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
					cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);

					cstmt.execute();

					codError = cstmt.getInt(8);
					msgError = cstmt.getString(9);
					numEvento = cstmt.getInt(10);

					cat.debug("codError: " + codError);
					cat.debug("msgError: " + msgError);
					cat.debug("numEvento: " + numEvento);

					if (codError != 0) {
						cat.error("Ocurrió un error al insertar reserva de accesorio en la AL_MOVIMIENTOS");
						throw new GeneralException(
								msgError, String.valueOf(codError), numEvento, msgError);
					}							
			}

		}catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al insertar reserva de accesorio en la AL_MOVIMIENTOS",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al insertar reserva de accesorio en la AL_MOVIMIENTOS",e);

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
		cat.info("InsertAccesReservMovim():Fin");
	}

	/*
	 * Inserta Salida definitiva de Accesorio en la tabla al_movimientos
	 */
	public void insertSalidAccesMovim (WsVentaAccesoriosOutDTO ventaAccesoriosOutDTO)throws GeneralException
	{
		cat.info("InsertSalidAccesMovim():Inicio");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;		
		conn = getConection();
		CallableStatement cstmt = null;		
		try
		{			
			String call = getSQLDatosAbonado("ve_venta_accesorios_pg", "ve_ins_acce_salida_movim_pr", 10);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);

			for(int i = 0; i < ventaAccesoriosOutDTO.getArticulo().length; i++){


					cstmt.setInt(1, ventaAccesoriosOutDTO.getArticulo()[i].getCodbodega());
					cstmt.setInt(2, ventaAccesoriosOutDTO.getArticulo()[i].getCodArticulo());
					cstmt.setInt(3, ventaAccesoriosOutDTO.getArticulo()[i].getCodUso());
					cstmt.setString(4, ventaAccesoriosOutDTO.getNombreUsuario());
					cstmt.setInt(5, ventaAccesoriosOutDTO.getArticulo()[i].getNumUnidades());
					cstmt.setString(1, ventaAccesoriosOutDTO.getArticulo()[i].getNumSerie());
					cstmt.setLong(7, ventaAccesoriosOutDTO.getNumTransaccion());
					cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
					cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);

					cstmt.execute();

					codError = cstmt.getInt(8);
					msgError = cstmt.getString(9);
					numEvento = cstmt.getInt(10);

					cat.debug("codError: " + codError);
					cat.debug("msgError: " + msgError);
					cat.debug("numEvento: " + numEvento);

					if (codError != 0) {	
						cat.error("Ocurrió un error al insertar salida definitiva de accesorio en la AL_MOVIMIENTOS");
						throw new GeneralException(
								msgError, String.valueOf(codError), numEvento, msgError);
					}

			}
		}catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al insertar salida definitiva de accesorio en la AL_MOVIMIENTOS",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al insertar salida definitiva de accesorio en la AL_MOVIMIENTOS",e);

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
		cat.info("InsertSalidAccesMovim():Fin");
	}

	/*
	 * Obtiene Numero de Secuencia para Venta de Accesorios
	 */
	public long getObtieneSecuencia(String nombreSecuencia)throws GeneralException{
		cat.info("getObtieneSecuencia():Inicio");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;		
		long numTransaccion = 0;
		try
		{
			cat.debug("Inicio:getObtieneSecuencia");

			//INI-01 (AL) String call = getSQLDatosAbonado("VE_intermediario_PG","VE_OBTIENE_SECUENCIA_PR",5);			
			String call = getSQLDatosAbonado("VE_intermediario_Quiosco_PG","VE_OBTIENE_SECUENCIA_PR",5);
			
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1, nombreSecuencia);
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getObtieneSecuencia:execute");
			cstmt.execute();
			cat.debug("Fin:getObtieneSecuencia:execute");

			codError=cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento=cstmt.getInt(5);

			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				cat.error("Ocurrió un error al obtener la secuencia de Transaccion");
				throw new GeneralException(
						msgError, String.valueOf(codError), numEvento, msgError);
			}
			else
				numTransaccion = cstmt.getLong(2);

		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener la secuencia de Transaccion",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al obtener la secuencia de Transaccion",e);
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

		cat.debug("Fin:getObtieneSecuencia");

		return numTransaccion;
	}

	/*
	 * Valida existencia de numero de serie
	 */
	public boolean validaNumeroSerie(ArticuloDTO articuloDTO) throws GeneralException{

		cat.info("validaNumeroSerie():Inicio");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		boolean retValue = false;
		CallableStatement cstmt = null;		
		try
		{
			cat.debug("Inicio:validaNumeroSerie");

			String call = getSQLDatosAbonado("ve_venta_accesorios_pg","ve_existe_serie",6);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);



				cstmt.setString(1,articuloDTO.getNumSerie());				
				cstmt.setInt(2, articuloDTO.getCodArticulo());
				cstmt.setInt(3, articuloDTO.getCodUso());			
				cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

				cat.debug("Inicio:validaNumeroSerie:execute");
				cstmt.execute();
				cat.debug("Fin:validaNumeroSerie:execute");

				codError=cstmt.getInt(4);
				msgError = cstmt.getString(5);
				numEvento=cstmt.getInt(6);

				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");

				if (codError != 0) {
					cat.error("Ocurrió un error al Validar Numero de serie");
					throw new GeneralException(
							msgError, String.valueOf(codError), numEvento, msgError);
				}else{
					retValue=codError==0?true:false;
				}


		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al Validar Numero de serie",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al Validar Numero de serie",e);
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

		cat.debug("Fin:validaNumeroSerie");

		return retValue;
	}

	/*
	 * Inserta reserva articulo en la tabla GA_RESERVART
	 */
	public void insertReservArticulo (WsVentaAccesoriosOutDTO ventaAccesorio)throws GeneralException
	{
		cat.info("InsertReservArticulo():Inicio");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;		
		try
		{
			
			String call = getSQLDatosAbonado("ve_venta_accesorios_pg", "ve_insert_reserv_art_pr", 12);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);

			for (int i = 0; i < ventaAccesorio.getArticulo().length; i++){

					cstmt.setInt(1, ventaAccesorio.getArticulo()[i].getCodbodega());
					cstmt.setInt(2, ventaAccesorio.getArticulo()[i].getCodArticulo());
					cstmt.setInt(3, ventaAccesorio.getArticulo()[i].getCodUso());
					cstmt.setString(4, ventaAccesorio.getNombreUsuario());
					cstmt.setInt(5, ventaAccesorio.getArticulo()[i].getNumUnidades());
					cstmt.setString(6, ventaAccesorio.getArticulo()[i].getNumSerie());
					cstmt.setLong(7, ventaAccesorio.getNumTransaccion());
					cstmt.setInt(8, Integer.parseInt(ventaAccesorio.getVenta().getNumVenta()));
					cstmt.setInt(9, i+1);
					cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);
					cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(12, java.sql.Types.NUMERIC);

					cat.debug("Inicio:InsertReservArticulo:execute");
					cstmt.execute();
					cat.debug("Fin:InsertReservArticulo:execute");

					codError = cstmt.getInt(10);
					msgError = cstmt.getString(11);
					numEvento = cstmt.getInt(12);

					cat.debug("codError: " + codError);
					cat.debug("msgError: " + msgError);
					cat.debug("numEvento: " + numEvento);

					if (codError != 0) {	
						cat.error("Ocurrió un error al insertar reserva de accesorio en la GA_RESERVART");
						throw new GeneralException(
								msgError, String.valueOf(codError), numEvento, msgError);
					}					
			}
		}catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al insertar reserva de accesorio en la GA_RESERVART",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al insertar reserva de accesorio en la GA_RESERVART",e);			
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
		cat.info("InsertReservArticulo():Fin");
	}

	/*
	 * Obtiene datos del vendedor de la VE_VENDEDORES
	 */
	public WsVentaAccesoriosOutDTO obtieneDatosVendedor (WsVentaAccesoriosOutDTO ventaAccesoriosOutDTO)throws GeneralException
	{
		cat.info("obtieneTipoVenta():Inicio");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;	
		
		try
		{
			String call = getSQLDatosAbonado("ve_venta_accesorios_pg", "ve_select_datos_vendedor", 12);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);

			cstmt.setLong(1, ventaAccesoriosOutDTO.getVendedor().getCodVendedor());
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(12, java.sql.Types.NUMERIC);

			cat.debug("Inicio:obtieneTipoVenta:execute");
			cstmt.execute();
			cat.debug("Fin:obtieneTipoVenta:execute");

			codError = cstmt.getInt(10);
			msgError = cstmt.getString(11);
			numEvento = cstmt.getInt(12);

			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError!=0){
				cat.error("Ocurrió un error al obtener tipo de venta");
				throw new GeneralException(
						msgError, String.valueOf(codError), numEvento, msgError);
			}
			else{
				ventaAccesoriosOutDTO.getVendedor().setCodVendedor(ventaAccesoriosOutDTO.getVendedor().getCodVendedor());
				//INICIO CSR-11002
				//ventaAccesoriosOutDTO.getVendedor().setCodTipComis(String.valueOf(cstmt.getInt(2)));
				ventaAccesoriosOutDTO.getVendedor().setCodTipComis(cstmt.getString(2));
				//FIN CSR-11002
				ventaAccesoriosOutDTO.getVenta().setIndTipVenta(cstmt.getInt(3));
				ventaAccesoriosOutDTO.getVendedor().setCodVendedorAgente(cstmt.getInt(4));
				ventaAccesoriosOutDTO.getVendedor().setCodOficina(cstmt.getString(5));
				ventaAccesoriosOutDTO.getVendedor().setCodPlaza(cstmt.getString(6));
				ventaAccesoriosOutDTO.getVendedor().setCodCiudad(cstmt.getString(7));
				ventaAccesoriosOutDTO.getVendedor().setCodRegion(cstmt.getString(8));
				ventaAccesoriosOutDTO.getVendedor().setCodProvincia(cstmt.getString(9));	
				ventaAccesoriosOutDTO.setCodError(codError);
				ventaAccesoriosOutDTO.setMsgError(msgError);
				ventaAccesoriosOutDTO.setNumEvento(numEvento);
			}	

		}catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener tipo de venta",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al obtener tipo de venta",e);			
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
		cat.info("obtieneTipoVenta():Fin");	
		return ventaAccesoriosOutDTO;
	}
	/*
	 * Obtiene tipo documentacion de la tabla GE_TIPDOCUMEN
	 */
	public WsVentaAccesoriosOutDTO obtieneTipoDocumentacion (WsVentaAccesoriosOutDTO ventaAccesoriosOutDTO)throws GeneralException
	{
		cat.info("obtieneTipoDocumentacion():Inicio");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;	
	
		try
		{			
			String call = getSQLDatosAbonado("ve_venta_accesorios_pg", "ve_obt_tip_document_pr", 6);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);

			cstmt.setLong(1, ventaAccesoriosOutDTO.getCliente().getCodCliente());			
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

			cat.debug("Inicio:obtieneTipoDocumentacion:execute");
			cstmt.execute();
			cat.debug("Fin:obtieneTipoDocumentacion:execute");

			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);

			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError!=0){
				cat.error("Ocurrió un error al obtener tipo de venta");
				throw new GeneralException(
						msgError, String.valueOf(codError), numEvento, msgError);
			}
			else{
				ventaAccesoriosOutDTO.setCodTipDocument(cstmt.getInt(2));
				ventaAccesoriosOutDTO.setTipFoliacion(cstmt.getString(3));
				ventaAccesoriosOutDTO.setCodError(codError);
				ventaAccesoriosOutDTO.setMsgError(msgError);
				ventaAccesoriosOutDTO.setNumEvento(numEvento);
			}
		}catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener tipo de venta",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al obtener tipo de venta",e);			
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
		cat.info("obtieneTipoDocumentacion():Fin");
		return ventaAccesoriosOutDTO;
	}
	/*
	 * Inserta venta en la tabla GA_VENTAS
	 */
	public void insertaVenta(WsVentaAccesoriosOutDTO ventaAccesoriosOutDTO)throws GeneralException
	{
		cat.info("InsertaVenta():Inicio");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;		
		try
		{			
			String call = getSQLDatosAbonado("ve_venta_accesorios_pg", "ve_insert_venta_pr", 22);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);

			cstmt.setInt(1, Integer.parseInt(ventaAccesoriosOutDTO.getVenta().getNumVenta()));
			cat.debug("ventaAccesoriosOutDTO.getVenta().getNumVenta() [" + ventaAccesoriosOutDTO.getVenta().getNumVenta() + "]");
			cstmt.setInt(2,global.getCodigoProducto());
			cat.debug("global.getCodigoProducto() [" + global.getCodigoProducto() + "]");
			cstmt.setString(3, ventaAccesoriosOutDTO.getVendedor().getCodOficina());
			cat.debug("ventaAccesoriosOutDTO.getVendedor().getCodOficina() [" + ventaAccesoriosOutDTO.getVendedor().getCodOficina() + "]");
			cstmt.setString(4, ventaAccesoriosOutDTO.getVendedor().getCodTipComis());
			cat.debug("ventaAccesoriosOutDTO.getVendedor().getCodTipComis() [" + ventaAccesoriosOutDTO.getVendedor().getCodTipComis() + "]");
			cstmt.setLong(5,ventaAccesoriosOutDTO.getVendedor().getCodVendedor());
			cat.debug("ventaAccesoriosOutDTO.getVendedor().getCodVendedor() [" + ventaAccesoriosOutDTO.getVendedor().getCodVendedor() + "]");
			cstmt.setLong(6, ventaAccesoriosOutDTO.getVendedor().getCodVendedorAgente());
			cat.debug("ventaAccesoriosOutDTO.getVendedor().getCodVendedorAgente() [" + ventaAccesoriosOutDTO.getVendedor().getCodVendedorAgente() + "]");
			cstmt.setInt(7, global.numUnidTotalVenta(ventaAccesoriosOutDTO.getArticulo()));
			cat.debug("global.numUnidTotalVenta(ventaAccesoriosOutDTO.getArticulo()) [" + global.numUnidTotalVenta(ventaAccesoriosOutDTO.getArticulo()) + "]");
			cstmt.setString(8, ventaAccesoriosOutDTO.getVendedor().getCodRegion());
			cat.debug("ventaAccesoriosOutDTO.getVendedor().getCodRegion() [" + ventaAccesoriosOutDTO.getVendedor().getCodRegion() + "]");
			cstmt.setString(9, ventaAccesoriosOutDTO.getVendedor().getCodProvincia());
			cat.debug("ventaAccesoriosOutDTO.getVendedor().getCodProvincia() [" + ventaAccesoriosOutDTO.getVendedor().getCodProvincia() + "]");
			cstmt.setString(10, ventaAccesoriosOutDTO.getVendedor().getCodCiudad());
			cat.debug("ventaAccesoriosOutDTO.getVendedor().getCodCiudad() [" + ventaAccesoriosOutDTO.getVendedor().getCodCiudad() + "]");
			cstmt.setString(11, global.getIndVentaProceso());
			cat.debug("global.getIndVentaProceso() [" + global.getIndVentaProceso() + "]");
			cstmt.setLong(12, ventaAccesoriosOutDTO.getNumTransaccion());
			cat.debug("ventaAccesoriosOutDTO.getNumTransaccion() [" + ventaAccesoriosOutDTO.getNumTransaccion() + "]");
			cstmt.setString(13, ventaAccesoriosOutDTO.getNombreUsuario());
			cat.debug("ventaAccesoriosOutDTO.getNombreUsuario() [" + ventaAccesoriosOutDTO.getNombreUsuario() + "]");
			cstmt.setString(14, global.getIndVenta());
			cat.debug("global.getIndVenta() [" + global.getIndVenta() + "]");
			cstmt.setInt(15, ventaAccesoriosOutDTO.getVenta().getIndTipVenta());
			cat.debug("ventaAccesoriosOutDTO.getVenta().getIndTipVenta() [" + ventaAccesoriosOutDTO.getVenta().getIndTipVenta() + "]");
			cstmt.setLong(16, ventaAccesoriosOutDTO.getCliente().getCodCliente());			
			cat.debug("ventaAccesoriosOutDTO.getCliente().getCodCliente() [" + ventaAccesoriosOutDTO.getCliente().getCodCliente() + "]");
			cstmt.setString(17, ventaAccesoriosOutDTO.getTipFoliacion());
			cat.debug("ventaAccesoriosOutDTO.getTipFoliacion() [" + ventaAccesoriosOutDTO.getTipFoliacion() + "]");
			cstmt.setInt(18, ventaAccesoriosOutDTO.getCodTipDocument());
			cat.debug("ventaAccesoriosOutDTO.getCodTipDocument() [" + ventaAccesoriosOutDTO.getCodTipDocument() + "]");
			cstmt.setString(19, ventaAccesoriosOutDTO.getVendedor().getCodPlaza());						
			cat.debug("ventaAccesoriosOutDTO.getVendedor().getCodPlaza() [" + ventaAccesoriosOutDTO.getVendedor().getCodPlaza() + "]");
			cstmt.registerOutParameter(20, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(21, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(22, java.sql.Types.NUMERIC);

			cat.debug("Inicio:InsertaVenta:execute");
			cstmt.execute();
			cat.debug("Fin:InsertaVenta:execute");

			codError = cstmt.getInt(20);
			msgError = cstmt.getString(21);
			numEvento = cstmt.getInt(22);

			cat.debug("codError: " + codError);
			cat.debug("msgError: " + msgError);
			cat.debug("numEvento: " + numEvento);

			if (codError != 0) {	
				cat.error("Ocurrió un error al insertar venta en la GA_VENTAS");
				throw new GeneralException(
					msgError, String.valueOf(codError), numEvento, msgError);
			}

		}catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al insertar venta en la GA_VENTAS",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al insertar venta en la GA_VENTAS",e);			
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
		cat.info("InsertaVenta():Fin");
	}
	/*
	 * Obtiene ciclo de facturacion del cliente de la tabla FA_CICLFACT
	 */
	public WsVentaAccesoriosDTO obtieneCicloFactCliente (WsVentaAccesoriosDTO ventaAccesorio)throws GeneralException
	{
		cat.info("obtieneCicloFactCliente():Inicio");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;		
		try
		{			
			String call = getSQLDatosAbonado("ve_venta_accesorios_pg", "ve_ciclo_factura_cliente", 5);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);

			cstmt.setLong(1, ventaAccesorio.getCliente().getCodCliente());			
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cat.debug("Inicio:obtieneCicloFactCliente:execute");
			cstmt.execute();
			cat.debug("Fin:obtieneCicloFactCliente:execute");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);

			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError!=0){
				cat.error("Ocurrió un error al obtener tipo de venta");
				throw new GeneralException(
						msgError, String.valueOf(codError), numEvento, msgError);
			}
			else
				ventaAccesorio.getCliente().setCodCiclFact(cstmt.getInt(2));		
		}catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener tipo de venta",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al obtener tipo de venta",e);			
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
		cat.info("obtieneCicloFactCliente():Fin");
		return ventaAccesorio;	
	}

	/*
	 * actualiza venta en la tabla GA_VENTAS
	 */
	public WsVentaAccesoriosOutDTO updateVenta (WsVentaAccesoriosOutDTO ventaAccesoriosOutDTO)throws GeneralException
	{
		cat.info("updateVenta():Inicio");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;		
		try
		{			
			String call = getSQLDatosAbonado("ve_venta_accesorios_pg", "ve_update_venta_pr", 6);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			
			cstmt.setDouble(1,ventaAccesoriosOutDTO.getVenta().getImpVenta());
			cstmt.setString(2,global.getIndAceptacionVenta());
			cstmt.setLong(3, Long.parseLong(ventaAccesoriosOutDTO.getVenta().getNumVenta()));
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

			cat.debug("Inicio:updateVenta:execute");
			cstmt.execute();
			cat.debug("Fin:updateVenta:execute");

			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);

			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError!=0){				
				cat.error("Ocurrió un error al obtener tipo de venta");
				throw new GeneralException(
						msgError, String.valueOf(codError), numEvento, msgError);
			}			
		}catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener tipo de venta",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al obtener tipo de venta",e);			
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
		cat.info("updateVenta():Fin");
		return ventaAccesoriosOutDTO;
	}

	/*
	 * elimina reserva en la tabla GA_RESERVART
	 */
	public WsVentaAccesoriosOutDTO eliminaReserva (long numTransaccion)throws GeneralException
	{
		cat.info("eliminaReserva():Inicio");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;	
		WsVentaAccesoriosOutDTO accesoriosOutDTO = new WsVentaAccesoriosOutDTO();
		try
		{			
			String call = getSQLDatosAbonado("ve_venta_accesorios_pg", "ve_elimina_reserva_pr", 4);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);

			cstmt.setLong(1, numTransaccion);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);

			cat.debug("Inicio:eliminaReserva:execute");
			cstmt.execute();
			cat.debug("Fin:eliminaReserva:execute");

			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);

			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError!=0){
				cat.error("Ocurrió un error al obtener tipo de venta");
				throw new GeneralException(
						msgError, String.valueOf(codError), numEvento, msgError);
			}			
		}catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener tipo de venta",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al obtener tipo de venta",e);			
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
		cat.info("eliminaReserva():Fin");	
		return accesoriosOutDTO;
	}
	
	public PrecioCargoDTO[] getPrecioCargoAccesorio_PrecioLista(ParametrosCargosAccesoriosDTO entrada) 
	throws GeneralException{
		cat.debug("Inicio:getPrecioCargoAccesorio_PrecioLista()");
		PrecioCargoDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			
			String call = getSQLDatosAbonado("ve_cargos_accesorios_pg","ve_preccargoAcce_prelis_pr",10);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setInt(1,Integer.parseInt(entrada.getCodigoArticulo()));
			cat.debug("entrada.getCodigoArticulo() [" + entrada.getCodigoArticulo() + "]");
			cstmt.setInt(2,Integer.parseInt(entrada.getTipoStock()));
			cat.debug("entrada.getTipoStock() [" + entrada.getTipoStock() + "]");
			cstmt.setInt(3,Integer.parseInt(entrada.getCodigoUso()));
			cat.debug("entrada.getCodigoUso() [" + entrada.getCodigoUso() + "]");
			cstmt.setInt(4,Integer.parseInt(entrada.getEstado()));
			cat.debug("entrada.getEstado() [" + entrada.getEstado() + "]");
			cstmt.setString(5,entrada.getCodigoCategoria());
			cat.debug("entrada.getCodigoCategoria() [" + entrada.getCodigoCategoria() + "]");
			cstmt.setInt(6,Integer.parseInt(entrada.getIndiceRecambio()));
			cat.debug("entrada.getIndiceRecambio() [" + entrada.getIndiceRecambio() + "]");
			

			cstmt.registerOutParameter(7,OracleTypes.CURSOR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getPrecioCargoAccesorio_PrecioLista:execute");
			cstmt.execute();
			cat.debug("Fin:getPrecioCargoAccesorio_PrecioLista:execute");

			codError = cstmt.getInt(8);
			msgError = cstmt.getString(9);
			numEvento = cstmt.getInt(10);

			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar el precio de cargo de la Simcard (Precio Lista)");
				throw new GeneralException(
						"Ocurrió un error al recuperar el precio de cargo de la Simcard (Precio Lista)", String
						.valueOf(codError), numEvento, msgError);
			}else{
				cat.debug("Recuperando el precio de cargo de la Simcard (Precio Lista)");
				List lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(7);

				while (rs.next()) {
					PrecioCargoDTO precioDTO = new PrecioCargoDTO();
					
					precioDTO.setCodigoConcepto(rs.getString(1));
					cat.debug("precioDTO.setCodigoConcepto ["+rs.getString(1)+"]");
					precioDTO.setDescripcionConcepto(rs.getString(2));
					cat.debug("precioDTO.setDescripcionConcepto ["+rs.getString(2)+"]");
					precioDTO.setMonto(rs.getFloat(3));
					cat.debug("precioDTO.setMonto ["+rs.getFloat(3)+"]");
					precioDTO.setCodigoMoneda(rs.getString(4));
					cat.debug("precioDTO.setCodigoMoneda ["+rs.getString(4)+"]");
					precioDTO.setDescripcionMoneda(rs.getString(5));
					cat.debug("precioDTO.setDescripcionMoneda ["+rs.getString(5)+"]");

					//-- VALORES CONSTANTES
					precioDTO.setIndicadorAutMan(rs.getString(8));
					precioDTO.setNumeroUnidades(rs.getString(9));
					precioDTO.setIndicadorEquipo(rs.getString(10));
					precioDTO.setIndicadorPaquete(rs.getString(11));
					precioDTO.setMesGarantia(rs.getString(12));
					precioDTO.setIndicadorAccesorio(rs.getString(13));
					precioDTO.setCodigoArticulo(rs.getString(14));
					//precioDTO.setCodigoStock(rs.getString(15));
					//precioDTO.setCodigoEstado(rs.getString(16));
					lista.add(precioDTO);
				}
				rs.close();
				resultado =(PrecioCargoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
						lista.toArray(), PrecioCargoDTO.class);

				cat.debug("precio cargos Simcard (Precio Lista)");
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			throw(e);
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar el precio de cargo de la Simcard (Precio Lista)",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
			"Ocurrió un error al recuperar el precio de cargo de la Simcard (Precio Lista)",e);
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
		cat.debug("Fin:getPrecioCargoAccesorio_PrecioLista()");
		return resultado;
	}//fin getPrecioCargoSimcard_PrecioLista	
	
	public float getImpuesto(String codigoVendedor)throws GeneralException{
		cat.debug("Inicio:getImpuesto()");		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		float impuesto = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			
			String call = getSQLDatosAbonado("ve_portabilidad_impuesto_pg","ve_obtenerimpuesto_clie_pr",5);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setInt(1,Integer.parseInt(codigoVendedor));			
			cstmt.registerOutParameter(2,java.sql.Types.FLOAT);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getPrecioCargoAccesorio_PrecioLista:execute");
			cstmt.execute();
			cat.debug("Fin:getPrecioCargoAccesorio_PrecioLista:execute");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);

			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar el Impuesto");
				throw new GeneralException(
						"Ocurrió un error al recuperar el Impuesto", String
						.valueOf(codError), numEvento, msgError);
			}else{
				cat.debug("Recuperando el Impuesto");			
				impuesto = cstmt.getFloat(2);

				cat.debug("Impuesto: "+ impuesto +" del Vendedor: "+ codigoVendedor);
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			throw(e);
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar el Impuesto",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException("Ocurrió un error al recuperar el Impuesto",e);
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
		cat.debug("Fin:getImpuesto()");
		return impuesto;
	}//fin getImpuesto	
	
	public String getZip(DireccionDTO direccion)throws GeneralException{
		cat.debug("Inicio:getZip()");		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		String zip = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			
			String call = getSQLDatosAbonado("ve_tipificacion_pg","ve_recupera_zip_pr",8);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setString(1,direccion.getCodigoRegion());			
			cstmt.setString(2,direccion.getCodigoProvincia());
			cstmt.setString(3,direccion.getCodigoCiudad());
			cstmt.setString(4,direccion.getCodigoComuna());
			cstmt.registerOutParameter(5,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getPrecioCargoAccesorio_PrecioLista:execute");
			cstmt.execute();
			cat.debug("Fin:getPrecioCargoAccesorio_PrecioLista:execute");

			codError = cstmt.getInt(6);
			msgError = cstmt.getString(7);
			numEvento = cstmt.getInt(8);

			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar ZIP");
				throw new GeneralException(
						"Ocurrió un error al recuperar ZIP", String
						.valueOf(codError), numEvento, msgError);
			}else{
				cat.debug("Recuperando ZIP");			
				zip = cstmt.getString(5);
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			throw(e);
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar ZIP",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException("Ocurrió un error al recuperar ZIP",e);
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
		cat.debug("Fin:getZip()");
		return zip;
	}//fin getImpuesto	
	
	
	public String getNumCelularSeriePrepago(String numSerie, String numVenta)throws GeneralException{
		cat.debug("Inicio:getZip()");		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		String numeroCelular = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			
			String call = getSQLDatosAbonado("ve_tipificacion_pg","ve_rec_celular_serie_pr",6);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,numSerie);
			cat.debug("numSerie [" + numSerie + "]");
			cstmt.setString(2,numVenta);
			cat.debug("numVenta[" + numVenta + "]");
			cstmt.registerOutParameter(3,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getPrecioCargoAccesorio_PrecioLista:execute");
			cstmt.execute();
			cat.debug("Fin:getPrecioCargoAccesorio_PrecioLista:execute");

			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);

			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar Numero de Celular");
				throw new GeneralException(
						"Ocurrió un error al recuperar Numero de Celular", String
						.valueOf(codError), numEvento, msgError);
			}else{
				cat.debug("Recuperando ZIP");			
				numeroCelular = cstmt.getString(3);
				cat.debug("numeroCelular [" + numeroCelular + "]");
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			throw(e);
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar Numero de Celular",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException("Ocurrió un error al recuperar Numero de Celular",e);
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
		cat.debug("Fin:getZip()");
		return numeroCelular;
	}//fin getImpuesto	
	
	

	public WSCentralQuioscoOutDTO getCentralesQuiosco()throws GeneralException
	{
		cat.info("getCentralesQuiosco():Inicio");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		WSCentralQuioscoOutDTO resultado = new WSCentralQuioscoOutDTO();
		try
		{			
			conn = getConection();
			String call = getSQLDatosAbonado("ve_venta_accesorios_pg", "ve_obt_centrales_quiosco_pr", 4);			
			cat.debug("sql[" + call + "]");			
			cstmt = conn.prepareCall(call);
			
			
			//PARAMETROS DE SALIDA
			cstmt.registerOutParameter(1,OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getCentralesQuiosco:Execute");
			cstmt.execute();
			cat.debug("Fin:getCentralesQuiosco:Execute");
			
			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);

			cat.debug("codError: " + codError);
			cat.debug("msgError: " + msgError);
			cat.debug("numEvento: " + numEvento);
			
            resultado.setCodError(Integer.toString(codError));
            resultado.setMsgError(msgError);
            resultado.setNumEvento(Integer.toString(numEvento));
			
			if (codError != 0) {								
				cat.error("Ocurrió un error al  recuperar centrales");
				throw new GeneralException(
						"Ocurrió un error al  recuperar centrales", String
						.valueOf(codError), numEvento, msgError);

			}
			
			ArrayList lista = new ArrayList();
			CentralDTO central = null;
			rs = (ResultSet) cstmt.getObject(1);
			
			while (rs.next()) {
				central = new CentralDTO();
				central.setCodigoCentral(rs.getString(1));
				central.setDescripcionCentral(rs.getString(2)); 
				lista.add(central);
			}
			
			resultado.setCentralDTOs((CentralDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), CentralDTO.class));

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
		return resultado;
	}
	
	public DescuentoDTO[] getDescuentoAccesorio(ParametrosCargosAccesoriosDTO entrada) 
	throws GeneralException{
		cat.debug("Inicio:getDescuentoAccesorio()");
		DescuentoDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			
			
			String call = getSQLDatosAbonado("ve_cargos_accesorios_pg","ve_descuentoAcce_isc_pr",7);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setInt(1,Integer.parseInt(entrada.getCodigoArticulo()));
			cat.debug("entrada.getCodigoArticulo() [" + entrada.getCodigoArticulo() + "]");
			cstmt.setInt(2,Integer.parseInt(entrada.getTipoStock()));
			cat.debug("entrada.getTipoStock() [" + entrada.getTipoStock() + "]");
			cstmt.setInt(3,Integer.parseInt(entrada.getCodigoUso()));
			cat.debug("entrada.getCodigoUso() [" + entrada.getCodigoUso() + "]");

			cstmt.registerOutParameter(4,OracleTypes.CURSOR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getPrecioCargoAccesorio_PrecioLista:execute");
			cstmt.execute();
			cat.debug("Fin:getPrecioCargoAccesorio_PrecioLista:execute");

			codError = cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento = cstmt.getInt(7);

			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar el precio de cargo de la Simcard (Precio Lista)");
				throw new GeneralException(
						"Ocurrió un error al recuperar el precio de cargo de la Simcard (Precio Lista)", String
						.valueOf(codError), numEvento, msgError);
			}else{
				cat.debug("Recuperando el precio de cargo de la Simcard (Precio Lista)");
				List lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(4);

				while (rs.next()) {
					DescuentoDTO descuento = new DescuentoDTO();										
					descuento.setCodigoConcepto(rs.getString(1));
					cat.debug("precio cargos Simcard (Precio Lista)");
					
					descuento.setDescripcionConcepto(rs.getString(2));
					descuento.setMaxDescuento(rs.getFloat(3));
					descuento.setMinDescuento(0);
					descuento.setMonto(rs.getFloat(3));
					descuento.setTipo("0");
					descuento.setTipoAplicacion("0");	
					lista.add(descuento);
				}
				rs.close();
				resultado =(DescuentoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
						lista.toArray(), DescuentoDTO.class);

				cat.debug("precio cargos Simcard (Precio Lista)");
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			throw(e);
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar el precio de cargo de la Simcard (Precio Lista)",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
			"Ocurrió un error al recuperar el precio de cargo de la Simcard (Precio Lista)",e);
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
		cat.debug("Fin:getPrecioCargoAccesorio_PrecioLista()");
		return resultado;
	}//fin getPrecioCargoSimcard_PrecioLista	
}