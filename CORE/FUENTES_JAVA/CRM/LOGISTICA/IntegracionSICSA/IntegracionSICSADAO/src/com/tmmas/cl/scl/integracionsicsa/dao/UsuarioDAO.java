package com.tmmas.cl.scl.integracionsicsa.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import com.tmmas.cl.scl.integracionsicsa.common.dto.UsuarioDTO;
import com.tmmas.cl.scl.integracionsicsa.common.exception.IntegracionSICSAException;

public class UsuarioDAO extends IntegracionSICSADAO {
	/*
	 * -------------------------------------------------------------------------
	 * INICIO BLOQUE METODOS HOM
	 * -------------------------------------------------------------------------	

	/**
	 * Metodo que consulta los datos de un usuario
	 * 
	 * @author Hugo Olivares
	 * @throws IntegracionSICSAException
	 */
	public UsuarioDTO getDatosUsuario(String codUsuario)
			throws IntegracionSICSAException {

		loggerDebug("getDatosUsuario: inicio");
		UsuarioDTO outDTO = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;

		try {

			conn = obtenerConexion();
			String call = getSQL("al_integracion_sicsa_pg",
					"al_get_datos_usuario_pr", 8);
			cstmt = conn.prepareCall(call);
			loggerDebug("SQL[" + call + "]");
			// PARAMETROS DE ENTRADA
			cstmt.setString(1, codUsuario);
			loggerDebug("codUsuario: " + codUsuario);

			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.INTEGER);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.INTEGER);

			loggerDebug(" Iniciando Ejecución");
			loggerDebug("Execute Antes");

			cstmt.execute();

			loggerDebug("Execute Despues");
			loggerDebug(" Finalizo ejecución");

			evaluaResultado(cstmt.getInt(6), cstmt.getString(7), cstmt.getInt(8));

			outDTO = new UsuarioDTO();
			outDTO.setNomUsuario(cstmt.getString(2));
			outDTO.setAppUsuario(cstmt.getString(3));
			outDTO.setUidUsuario(cstmt.getString(4));
			outDTO.setEmailUsuario(cstmt.getString(5));
			outDTO.setCodUsuario(codUsuario);

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
		loggerDebug("getDatosUsuario: fin");
		return outDTO;
	}

}