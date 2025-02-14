package com.tmmas.cl.scl.integracionsicsa.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import oracle.jdbc.driver.OracleTypes;

import com.tmmas.cl.scl.integracionsicsa.common.dto.CorreoDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.DatosCorreoDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.GrupoCorreosDTO;
import com.tmmas.cl.scl.integracionsicsa.common.exception.IntegracionSICSAException;

public class GeneralDAO extends IntegracionSICSADAO {
	/*
	 * -------------------------------------------------------------------------
	 * INICIO BLOQUE METODOS HOM
	 * -------------------------------------------------------------------------	

	/**
	 * Metodo que consulta los datos para el envio de correo
	 * 
	 * @author Hugo Olivares
	 * @throws IntegracionSICSAException
	 */
	public DatosCorreoDTO getDatosCorreo(String paramCorreo)
			throws IntegracionSICSAException {

		loggerDebug("getDatosCorreo: inicio");
		DatosCorreoDTO outDTO = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ResultSet rs = null;

		try {

			conn = obtenerConexion();
			String call = getSQL("al_integracion_sicsa_pg",
					"al_get_datos_correo_pr", 7);
			cstmt = conn.prepareCall(call);
			loggerDebug("SQL[" + call + "]");
			// PARAMETROS DE ENTRADA
			cstmt.setString(1, paramCorreo);
			loggerDebug("numProceso: " + paramCorreo);

			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, OracleTypes.CURSOR);
			cstmt.registerOutParameter(5, java.sql.Types.INTEGER);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.INTEGER);

			loggerDebug(" Iniciando Ejecución");
			loggerDebug("Execute Antes");

			cstmt.execute();

			loggerDebug("Execute Despues");
			loggerDebug(" Finalizo ejecución");

			evaluaResultado(cstmt.getInt(5), cstmt.getString(6), cstmt
					.getInt(7));

			outDTO = new DatosCorreoDTO();
			outDTO.setIpSmtp(cstmt.getString(2));
			outDTO.setRemitenteMail(cstmt.getString(3));

			rs = (ResultSet) cstmt.getObject(4);
			String destinos= new String();
			int cont=0;
			while(rs.next()){
				if(0==cont){
					destinos=rs.getString(1);
				}else{
					destinos=destinos+","+rs.getString(1);
				}
				cont++;
			}
			outDTO.setDestinosMail(destinos);

		} catch (Exception e) {
			if (!(e instanceof IntegracionSICSAException)) {
				loggerError("ERROR:");
				loggerError(e);
				loggerError("Codigo de Error[" + codError + "]");
				loggerError("Mensaje de Error[" + msgError + "]");
				loggerError("Numero de Evento[" + numEvento + "]");
				throw new IntegracionSICSAException("ERR.0000", 0);
			} else {
				throw (IntegracionSICSAException) e;
			}
		} finally {

			loggerDebug("Cerrando conexiones...");

			try {
				if (cstmt != null) {
					cstmt.close();
				}
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}

			} catch (SQLException e) {
				loggerError("ERROR: ");
				loggerError("SQLException[" + e + "]");
			}

		}
		loggerDebug("getDatosCorreo: fin");
		return outDTO;
	}
	
	

	/**
	 * Metodo que consulta los grupos de correos
	 * 
	 * @author Hugo Olivares
	 * @throws IntegracionSICSAException
	 */
	public GrupoCorreosDTO[] getGruposCorreos ()
			throws IntegracionSICSAException {

		loggerDebug("getGruposCorreos: inicio");
		GrupoCorreosDTO[] outDTOs = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ResultSet rs = null;

		try {

			conn = obtenerConexion();
			String call = getSQL("al_integracion_sicsa_pg",
					"al_get_grupos_correos", 4);
			cstmt = conn.prepareCall(call);
			loggerDebug("SQL[" + call + "]");
			
			cstmt.registerOutParameter(1, OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.INTEGER);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.INTEGER);

			loggerDebug(" Iniciando Ejecución");
			loggerDebug("Execute Antes");

			cstmt.execute();

			loggerDebug("Execute Despues");
			loggerDebug(" Finalizo ejecución");

			evaluaResultado(cstmt.getInt(2), cstmt.getString(3), cstmt
					.getInt(4));


			rs = (ResultSet) cstmt.getObject(1);
			
			GrupoCorreosDTO dtoCorreosDTO = null;
			ArrayList lista = new ArrayList();
			while(rs.next()){
				dtoCorreosDTO= new GrupoCorreosDTO();
				dtoCorreosDTO.setCodGrupo(rs.getString(1));
				dtoCorreosDTO.setDesGrupo(rs.getString(2));
				dtoCorreosDTO.setFecCreacion(rs.getString(3));
				lista.add(dtoCorreosDTO);
			}
			
			outDTOs = (GrupoCorreosDTO[]) copiaArregloTipoEspecifico(lista.toArray(), GrupoCorreosDTO.class);

		} catch (Exception e) {
			if (!(e instanceof IntegracionSICSAException)) {
				loggerError("ERROR:");
				loggerError(e);
				loggerError("Codigo de Error[" + codError + "]");
				loggerError("Mensaje de Error[" + msgError + "]");
				loggerError("Numero de Evento[" + numEvento + "]");
				throw new IntegracionSICSAException("ERR.0000", 0);
			} else {
				throw (IntegracionSICSAException) e;
			}
		} finally {

			loggerDebug("Cerrando conexiones...");

			try {
				if (cstmt != null) {
					cstmt.close();
				}
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}

			} catch (SQLException e) {
				loggerError("ERROR: ");
				loggerError("SQLException[" + e + "]");
			}

		}
		loggerDebug("getGruposCorreos: fin");
		return outDTOs;
	}		
	
	
	/**
	 * Metodo que consulta los correos asociados a un grupo
	 * 
	 * @author Hugo Olivares
	 * @throws IntegracionSICSAException
	 */
	public CorreoDTO[] getCorreos(String codGrupo)
			throws IntegracionSICSAException {

		loggerDebug("getGruposCorreos: inicio");
		CorreoDTO[] outDTOs = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ResultSet rs = null;

		try {

			conn = obtenerConexion();
			String call = getSQL("al_integracion_sicsa_pg",
					"al_get_correos", 5);
			cstmt = conn.prepareCall(call);
			loggerDebug("SQL[" + call + "]");
			
			cstmt.setInt(1, Integer.parseInt(codGrupo));
			
			cstmt.registerOutParameter(2, OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.INTEGER);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.INTEGER);

			loggerDebug(" Iniciando Ejecución");
			loggerDebug("Execute Antes");

			cstmt.execute();

			loggerDebug("Execute Despues");
			loggerDebug(" Finalizo ejecución");

			evaluaResultado(cstmt.getInt(3), cstmt.getString(4), cstmt
					.getInt(5));


			rs = (ResultSet) cstmt.getObject(2);
			
			CorreoDTO correoDTO = null;
			ArrayList lista = new ArrayList();
			while(rs.next()){
				correoDTO= new CorreoDTO();
				correoDTO.setCodGrupo(codGrupo);
				correoDTO.setMail(rs.getString(1));
				correoDTO.setUsuario(rs.getString(2));
				lista.add(correoDTO);
			}
			
			outDTOs = (CorreoDTO[]) copiaArregloTipoEspecifico(lista.toArray(), CorreoDTO.class);

		} catch (Exception e) {
			if (!(e instanceof IntegracionSICSAException)) {
				loggerError("ERROR:");
				loggerError(e);
				loggerError("Codigo de Error[" + codError + "]");
				loggerError("Mensaje de Error[" + msgError + "]");
				loggerError("Numero de Evento[" + numEvento + "]");
				throw new IntegracionSICSAException("ERR.0000", 0);
			} else {
				throw (IntegracionSICSAException) e;
			}
		} finally {

			loggerDebug("Cerrando conexiones...");

			try {
				if (cstmt != null) {
					cstmt.close();
				}
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}

			} catch (SQLException e) {
				loggerError("ERROR: ");
				loggerError("SQLException[" + e + "]");
			}

		}
		loggerDebug("getGruposCorreos: fin");
		return outDTOs;
	}		
	
	
	/**
	 * Metodo que borra un correo
	 * 
	 * @author Hugo Olivares
	 * @throws IntegracionSICSAException
	 */
	public void borrarCorreo(String codGrupo, String mail)
			throws IntegracionSICSAException {

		loggerDebug("borrarCorreo: inicio");
		Connection conn = null;
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		

		try {

			conn = obtenerConexion();
			String call = getSQL("al_integracion_sicsa_pg",
					"al_borrar_correo", 5);
			cstmt = conn.prepareCall(call);
			loggerDebug("SQL[" + call + "]");
			
			cstmt.setInt(1, Integer.parseInt(codGrupo));
			cstmt.setString(2, mail);
			cstmt.registerOutParameter(3, java.sql.Types.INTEGER);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.INTEGER);

			loggerDebug(" Iniciando Ejecución");
			loggerDebug("Execute Antes");

			cstmt.execute();

			loggerDebug("Execute Despues");
			loggerDebug(" Finalizo ejecución");

			evaluaResultado(cstmt.getInt(3), cstmt.getString(4), cstmt
					.getInt(5));

		} catch (Exception e) {
			if (!(e instanceof IntegracionSICSAException)) {
				loggerError("ERROR:");
				loggerError(e);
				loggerError("Codigo de Error[" + codError + "]");
				loggerError("Mensaje de Error[" + msgError + "]");
				loggerError("Numero de Evento[" + numEvento + "]");
				throw new IntegracionSICSAException("ERR.0000", 0);
			} else {
				throw (IntegracionSICSAException) e;
			}
		} finally {

			loggerDebug("Cerrando conexiones...");

			try {
				if (cstmt != null) {
					cstmt.close();
				}
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}

			} catch (SQLException e) {
				loggerError("ERROR: ");
				loggerError("SQLException[" + e + "]");
			}

		}
		loggerDebug("borrarCorreo: fin");
	}		
	
	
	/**
	 * Metodo que modifica un correo
	 * 
	 * @author Hugo Olivares
	 * @throws IntegracionSICSAException
	 */
	public void modificarCorreo(String codGrupo, String antMail, String nueMail, String usuario)
			throws IntegracionSICSAException {

		loggerDebug("modificarCorreo: inicio");
		Connection conn = null;
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		

		try {

			conn = obtenerConexion();
			String call = getSQL("al_integracion_sicsa_pg",
					"al_modif_correo", 7);
			cstmt = conn.prepareCall(call);
			loggerDebug("SQL[" + call + "]");
			
			cstmt.setInt(1, Integer.parseInt(codGrupo));
			cstmt.setString(2, antMail);
			cstmt.setString(3, nueMail);
			cstmt.setString(4, usuario);
			cstmt.registerOutParameter(5, java.sql.Types.INTEGER);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.INTEGER);

			loggerDebug(" Iniciando Ejecución");
			loggerDebug("Execute Antes");

			cstmt.execute();

			loggerDebug("Execute Despues");
			loggerDebug(" Finalizo ejecución");

			evaluaResultado(cstmt.getInt(5), cstmt.getString(6), cstmt
					.getInt(7));

		} catch (Exception e) {
			if (!(e instanceof IntegracionSICSAException)) {
				loggerError("ERROR:");
				loggerError(e);
				loggerError("Codigo de Error[" + codError + "]");
				loggerError("Mensaje de Error[" + msgError + "]");
				loggerError("Numero de Evento[" + numEvento + "]");
				throw new IntegracionSICSAException("ERR.0000", 0);
			} else {
				throw (IntegracionSICSAException) e;
			}
		} finally {

			loggerDebug("Cerrando conexiones...");

			try {
				if (cstmt != null) {
					cstmt.close();
				}
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}

			} catch (SQLException e) {
				loggerError("ERROR: ");
				loggerError("SQLException[" + e + "]");
			}

		}
		loggerDebug("modificarCorreo: fin");
	}	
	
	/**
	 * Metodo que inserta un correo
	 * 
	 * @author Hugo Olivares
	 * @throws IntegracionSICSAException
	 */
	public void insertarCorreo(String codGrupo, String mail, String usuario)
			throws IntegracionSICSAException {

		loggerDebug("insertarCorreo: inicio");
		Connection conn = null;
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		

		try {

			conn = obtenerConexion();
			String call = getSQL("al_integracion_sicsa_pg",
					"al_ins_correo", 6);
			cstmt = conn.prepareCall(call);
			loggerDebug("SQL[" + call + "]");
			
			cstmt.setInt(1, Integer.parseInt(codGrupo));
			cstmt.setString(2, mail);
			cstmt.setString(3, usuario);
			cstmt.registerOutParameter(4, java.sql.Types.INTEGER);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.INTEGER);

			loggerDebug(" Iniciando Ejecución");
			loggerDebug("Execute Antes");

			cstmt.execute();

			loggerDebug("Execute Despues");
			loggerDebug(" Finalizo ejecución");

			evaluaResultado(cstmt.getInt(4), cstmt.getString(5), cstmt
					.getInt(6));

		} catch (Exception e) {
			if (!(e instanceof IntegracionSICSAException)) {
				loggerError("ERROR:");
				loggerError(e);
				loggerError("Codigo de Error[" + codError + "]");
				loggerError("Mensaje de Error[" + msgError + "]");
				loggerError("Numero de Evento[" + numEvento + "]");
				throw new IntegracionSICSAException("ERR.0000", 0);
			} else {
				throw (IntegracionSICSAException) e;
			}
		} finally {

			loggerDebug("Cerrando conexiones...");

			try {
				if (cstmt != null) {
					cstmt.close();
				}
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}

			} catch (SQLException e) {
				loggerError("ERROR: ");
				loggerError("SQLException[" + e + "]");
			}

		}
		loggerDebug("insertarCorreo: fin");
	}

}