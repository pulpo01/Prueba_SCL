package com.tmmas.cl.scl.ventadeaccesorios.businessobject.dao;

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
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.TipificaClientizaDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.TipificacionDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.helper.Global;

public class TipificacionDAO extends ConnectionDAO{
	private Global global = Global.getInstance();	
	private static Category cat = Category.getInstance(TipificacionDAO.class);

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
	
	public String consultaKit (String datoTipificacion) throws GeneralException {
		//primero se consulta si el dato entregado es de tipo kit o no
		cat.info("consultaKit():Inicio");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		String consulta = null;		
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		
		try
		{			
			String call = getSQLDatosAbonado("ve_tipificacion_pg", "ve_selc_kit_pr", 5);			
			cat.debug("sql[" + call + "]");			
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1, datoTipificacion);
			cat.debug("datoTipificacion [" + datoTipificacion + "]");
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			cstmt.execute();

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);

			cat.debug("codError: " + codError);
			cat.debug("msgError: " + msgError);
			cat.debug("numEvento: " + numEvento);
			
			if (codError != 0) {								
				cat.error("Ocurrió un error al consultar si es KIT");
				throw new GeneralException(
				msgError, String.valueOf(codError), numEvento, msgError);
			}else {
				
				consulta = cstmt.getString(2);				
				cat.error("Indicador: "+ consulta);				
			}
		}catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al consultar si es KIT",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al consultar si es KIT",e);
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
		cat.info("consultaKit():Fin");
		return consulta;
	}
	
	public TipificacionDTO recuperaDatoTipificacion (String datoTipificacion, String codVendedor) throws GeneralException {
		cat.info("recuperaDatoTipificacion():Inicio");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		TipificacionDTO tipificacionDTO = new TipificacionDTO();
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		
		try
		{			
			String call = getSQLDatosAbonado("ve_tipificacion_pg", "ve_recupera_articulo_pr", 15);			
			cat.debug("sql[" + call + "]");			
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1, datoTipificacion);
			cat.debug("datoTipificacion [" + datoTipificacion + "]");
			cstmt.setString(2, codVendedor);
			cat.debug("codVendedor [" + codVendedor + "]");
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
			
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(12, java.sql.Types.NUMERIC);
			
			cstmt.registerOutParameter(13, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(15, java.sql.Types.NUMERIC);
			
			cstmt.execute();

			codError = cstmt.getInt(13);
			msgError = cstmt.getString(14);
			numEvento=cstmt.getInt(15);

			cat.debug("codError: " + codError);
			cat.debug("msgError: " + msgError);
			cat.debug("numEvento: " + numEvento);
			
			if (codError != 0) {	
				cat.error("Ocurrió un error al recuperar interfaz");
				throw new GeneralException(
					msgError, String.valueOf(codError), numEvento, msgError);
			}else {
				tipificacionDTO.setCodArticulo(cstmt.getInt(3));
				cat.debug("Codigo Articulo: "+ tipificacionDTO.getCodArticulo());
				tipificacionDTO.setNumSerie(cstmt.getString(4));
				cat.debug("Numero de Serie: "+ tipificacionDTO.getNumSerie());
				tipificacionDTO.setDescripArticulo(cstmt.getString(5));
				cat.debug("Descripcion: "+ tipificacionDTO.getDescripArticulo());
				tipificacionDTO.setPrecioArticulo(cstmt.getDouble(6));
				cat.debug("Precio Articulo: "+ tipificacionDTO.getPrecioArticulo());
				tipificacionDTO.setNumCelular(Long.toString(cstmt.getLong(7)));
				cat.debug("Numero de Celular: "+ tipificacionDTO.getNumCelular());
				tipificacionDTO.setEquiAcc(cstmt.getString(8));
				cat.debug("EquiAcc: "+ tipificacionDTO.getEquiAcc());
				tipificacionDTO.setTipTerminal(cstmt.getString(9));
				cat.debug("TipTerminal: "+ tipificacionDTO.getTipTerminal());
				tipificacionDTO.setImpITMB(cstmt.getDouble(10));
				cat.debug("ImpITMB: "+ tipificacionDTO.getImpITMB());
				tipificacionDTO.setImpISC(cstmt.getDouble(11));
				cat.debug("ImpISC: "+ tipificacionDTO.getImpISC());
				tipificacionDTO.setDescuentoPrecio(cstmt.getDouble(12));
				cat.debug("DescuentoPrecio: "+ tipificacionDTO.getDescuentoPrecio());
				
				tipificacionDTO.setCodError(codError);
				tipificacionDTO.setMsgError(msgError);
				tipificacionDTO.setNumEvento(numEvento);			
			}
		}catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar interfaz",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al recuperar interfaz",e);

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
		cat.info("recuperaDatoTipificacion():Fin");
		return tipificacionDTO;
	}
	
	public TipificacionDTO[] recuperaKit (String datoTipificacion, String codVendedor) throws GeneralException {
		cat.info("recuperaKit():Inicio");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;		
		ResultSet rs = null;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		TipificacionDTO[] resultado = null;
		
		try
		{			
			String call = getSQLDatosAbonado("ve_tipificacion_pg", "ve_recupera_kit_pr", 6);			
			cat.debug("sql[" + call + "]");			
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1, datoTipificacion);
			cat.debug("datoTipificacion [" + datoTipificacion + "]");
			cstmt.setString(2, codVendedor);
			cat.debug("codVendedor [" + codVendedor + "]");
			cstmt.registerOutParameter(3, OracleTypes.CURSOR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			
			cstmt.execute();

			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);

			cat.debug("codError: " + codError);
			cat.debug("msgError: " + msgError);
			cat.debug("numEvento: " + numEvento);
			
			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar interfaz");
				throw new GeneralException(
					msgError, String.valueOf(codError), numEvento, msgError);
			}
			
			ArrayList lista = new ArrayList();
			TipificacionDTO tipificacionDTO = null;
			rs = (ResultSet) cstmt.getObject(3);
			
			while (rs.next()) {
				tipificacionDTO = new TipificacionDTO();
				
				tipificacionDTO.setCodArticulo(rs.getInt(1));
				cat.error("tipificacionDTO.setCodArticulo("+tipificacionDTO.getCodArticulo()+")");				
				tipificacionDTO.setNumSerie(rs.getString(2));
				cat.error("tipificacionDTO.setNumSerie("+tipificacionDTO.getNumSerie()+")");
				tipificacionDTO.setNumCelular(Long.toString(rs.getLong(3)));
				cat.error("tipificacionDTO.setNumCelular("+tipificacionDTO.getNumCelular()+")");
				tipificacionDTO.setDescripArticulo(rs.getString(4));
				cat.error("tipificacionDTO.setDescripArticulo("+tipificacionDTO.getDescripArticulo()+")");
				tipificacionDTO.setPrecioArticulo(rs.getDouble(5));
				cat.error("tipificacionDTO.getPrecioArticulo("+tipificacionDTO.getPrecioArticulo()+")");
				tipificacionDTO.setEquiAcc(global.getKit());
				cat.error("tipificacionDTO.getEquiAcc("+tipificacionDTO.getEquiAcc()+")");
				tipificacionDTO.setTipTerminal(rs.getString(7));
				cat.error("tipificacionDTO.getTipTerminal("+tipificacionDTO.getTipTerminal()+")");
				tipificacionDTO.setImpITMB(rs.getDouble(8));
				cat.error("tipificacionDTO.getImpITMB("+tipificacionDTO.getImpITMB()+")");
				tipificacionDTO.setImpISC(rs.getDouble(9));
				cat.error("tipificacionDTO.setImpISC("+tipificacionDTO.getImpISC()+")");
				
				tipificacionDTO.setCodError(codError);
				tipificacionDTO.setMsgError(msgError);
				tipificacionDTO.setNumEvento(numEvento);
				
				lista.add(tipificacionDTO);
			}			
			resultado =(TipificacionDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), TipificacionDTO.class);
			
		}catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar KIT",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al recuperar KIT",e);

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
		cat.info("recuperaDatoTipificacion():Fin");
		return resultado;
	}
	
	public void insertTipificacion (TipificaClientizaDTO tipificaClientizaDTO) throws GeneralException {
		cat.info("insertTipificacion():Inicio");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;		
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;		
		
		try
		{			
			String call = getSQLDatosAbonado("ve_tipificacion_pg", "ve_insert_tipificacion_pr", 8);			
			cat.debug("sql[" + call + "]");			
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1, tipificaClientizaDTO.getCodTipificacion());
			cstmt.setInt(2, tipificaClientizaDTO.getCodArticulo());
			cstmt.setInt(3, tipificaClientizaDTO.getFlagClientizable());
			cstmt.setString(4, tipificaClientizaDTO.getNomUsuario());
			cstmt.setString(5, tipificaClientizaDTO.getDesTipificacion());	
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			
			cstmt.execute();

			codError = cstmt.getInt(6);
			msgError = cstmt.getString(7);
			numEvento = cstmt.getInt(8);

			cat.debug("codError: " + codError);
			cat.debug("msgError: " + msgError);
			cat.debug("numEvento: " + numEvento);
			
			if (codError != 0) {								
				cat.error("Ocurrió un error al insertar Tipificacion");
				throw new GeneralException(
						"Ocurrió un error al insertar Tipificacion,", String.valueOf(codError), numEvento, msgError);
			}			
		}catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al insertar tipificacion en la tabla GA_TIPIFICACION",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al insertar tipificacion en la tabla GA_TIPIFICACION",e);

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
		cat.info("insertTipificacion():Fin");		
	}
	
	public TipificaClientizaDTO[] recuperaArrayTipificacion () throws GeneralException {
		cat.info("recuperaArrayTipificacion():Inicio");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;		
		ResultSet rs = null;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		TipificaClientizaDTO[] resultado = null;
				
		try
		{			
			String call = getSQLDatosAbonado("ve_tipificacion_pg", "ve_selec_curs_tipifica_pr",4);			
			cat.debug("sql[" + call + "]");			
			cstmt = conn.prepareCall(call);
			
			cstmt.registerOutParameter(1, OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			
			cstmt.execute();

			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);

			cat.debug("codError: " + codError);
			cat.debug("msgError: " + msgError);
			cat.debug("numEvento: " + numEvento);
			
			if (codError != 0) {	
				cat.error("Ocurrió un error al recuperar interfaz");
				throw new GeneralException(
					msgError, String.valueOf(codError), numEvento, msgError);
			}
			
			ArrayList lista = new ArrayList();
			TipificaClientizaDTO tipificaClientizaDTO = null;
			rs = (ResultSet) cstmt.getObject(1);
			
			while (rs.next()) {
				tipificaClientizaDTO = new TipificaClientizaDTO();
				tipificaClientizaDTO.setCodTipificacion(rs.getString(1));
				tipificaClientizaDTO.setCodArticulo(rs.getInt(2));
				tipificaClientizaDTO.setFlagClientizable(rs.getInt(3));
				tipificaClientizaDTO.setNomUsuario(rs.getString(4));
				tipificaClientizaDTO.setDesTipificacion(rs.getString(5));
				tipificaClientizaDTO.setCodError(codError);
				tipificaClientizaDTO.setMsgError(msgError);
				tipificaClientizaDTO.setNumEvento(numEvento);
				
				lista.add(tipificaClientizaDTO);
			}
			
			resultado =(TipificaClientizaDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), TipificaClientizaDTO.class);
		}catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar datos de Tipificacion",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al recuperar datos de Tipificacion",e);

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
		cat.info("recuperaDatoTipificacion():Fin");
		return resultado;
	}

	public TipificaClientizaDTO recuperaTipificacion (int codArticulo) throws GeneralException {
		cat.info("recuperaTipificacion():Inicio");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;		
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;	
		TipificaClientizaDTO tipificaClientizaDTO = new TipificaClientizaDTO();
				
		try
		{			
			String call = getSQLDatosAbonado("ve_tipificacion_pg", "ve_selec_tipifica_pr",7);			
			cat.debug("sql[" + call + "]");			
			cstmt = conn.prepareCall(call);
			
			cstmt.setInt(1, codArticulo);
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			
			cstmt.execute();

			codError = cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento = cstmt.getInt(7);

			cat.debug("codError: " + codError);
			cat.debug("msgError: " + msgError);
			cat.debug("numEvento: " + numEvento);
			
			if (codError != 0) {	
				cat.error("Ocurrió un error al recuperar Tipificacion");
				throw new GeneralException(
					msgError, String.valueOf(codError), numEvento, msgError);
			}
			
			tipificaClientizaDTO.setCodArticulo(codArticulo);
			tipificaClientizaDTO.setCodTipificacion(cstmt.getString(2));
			tipificaClientizaDTO.setFlagClientizable(cstmt.getInt(3));
			tipificaClientizaDTO.setNomUsuario(cstmt.getString(5));
			tipificaClientizaDTO.setCodError(codError);
			tipificaClientizaDTO.setMsgError(msgError);
			tipificaClientizaDTO.setNumEvento(numEvento);
			
		}catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar Tipificacion",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al recuperar Tipificacion",e);

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
		cat.info("recuperaTipificacion():Fin");
		return tipificaClientizaDTO;
	}
	
	public void updateTipificacion (TipificaClientizaDTO tipificaClientizaDTO) throws GeneralException {
		cat.info("updateTipificacion():Inicio");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;		
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;	
						
		try
		{			
			String call = getSQLDatosAbonado("ve_tipificacion_pg", "ve_update_tipifica_pr",8);			
			cat.debug("sql[" + call + "]");			
			cstmt = conn.prepareCall(call);
			
			cstmt.setInt(1, tipificaClientizaDTO.getCodArticulo());
			if(tipificaClientizaDTO.getCodTipificacion().equals("")){
				cstmt.setNull(2, java.sql.Types.NULL); 
			}else{
				cstmt.setString(2, tipificaClientizaDTO.getCodTipificacion());
			}
			if(tipificaClientizaDTO.getFlagClientizable()== 1){
				cstmt.setInt(3, tipificaClientizaDTO.getFlagClientizable());
			}else{
				cstmt.setInt(3, java.sql.Types.NULL);
			}

			cstmt.setString(4, tipificaClientizaDTO.getNomUsuario());
			cstmt.setString(5, tipificaClientizaDTO.getDesTipificacion());

			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			
			cstmt.execute();

			codError = cstmt.getInt(6);
			msgError = cstmt.getString(7);
			numEvento = cstmt.getInt(8);

			cat.debug("codError: " + codError);
			cat.debug("msgError: " + msgError);
			cat.debug("numEvento: " + numEvento);
			
			if (codError != 0) {		
				cat.error("Ocurrió un error al actualizar Tipificacion");
				throw new GeneralException(
					msgError, String.valueOf(codError), numEvento, msgError);
			}
		}catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al actualizar Tipificacion",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al actualizar Tipificacion",e);

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
		cat.info("updateTipificacion():Fin");		
	}
	
	/*
	 * Metodo: deleteTipificacion
	 * Descripcion: crea una tipificacion de un articulo
	 * Fecha: 09/06/2010
	 * Developer: Gabriel Moraga L.
	 */
	
	public void deleteTipificacion(Long codArticulo) throws GeneralException {
		cat.info("deleteTipificacion():Inicio");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;		
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;	
						
		try
		{			
			String call = getSQLDatosAbonado("ve_tipificacion_pg", "ve_delete_tipifica_pr",4);	
			if(cat.isDebugEnabled()){
				cat.debug("sql[" + call + "]");
			}
			cstmt = conn.prepareCall(call);
			
			cstmt.setLong(1,codArticulo.longValue()); //Codigo articulo
			cat.debug("codArticulo[" + codArticulo + "]");
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC); //Codigo retorno
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR); //Mensaje retorno
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC); //Numero evento
			
			cstmt.execute();

			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);

			if(cat.isDebugEnabled()){
				cat.debug("codError: " + codError);
				cat.debug("msgError: " + msgError);
				cat.debug("numEvento: " + numEvento);
			}
			if (codError != 0) {								
				cat.error("Ocurrió un error al eliminar una Tipificacion");
				throw new GeneralException(msgError, String.valueOf(codError), numEvento, msgError);
			}
		}catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al crear una Tipificacion",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException("Ocurrió un error al eliminar una Tipificacion",e);

		} finally {
			if(cat.isDebugEnabled()){
				cat.debug("Cerrando conexiones...");
			}
			try {
				if(null != cstmt){
					cstmt.close();
				}
				if(null != conn){
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.info("deleteTipificacion():Fin");		
	}
	
}
