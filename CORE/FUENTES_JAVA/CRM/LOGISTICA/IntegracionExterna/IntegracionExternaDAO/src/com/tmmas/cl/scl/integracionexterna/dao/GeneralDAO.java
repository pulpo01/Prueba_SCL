package com.tmmas.cl.scl.integracionsicsa.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import oracle.jdbc.driver.OracleTypes;

import com.tmmas.cl.scl.integracionsicsa.common.dto.DatosCorreoDTO;
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

}