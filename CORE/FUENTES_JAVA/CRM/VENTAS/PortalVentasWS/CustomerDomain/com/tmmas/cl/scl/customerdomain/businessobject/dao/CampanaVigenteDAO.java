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
 * 16/01/2007     H&eacute;ctor Hermosilla      					Versión Inicial
 */

package com.tmmas.cl.scl.customerdomain.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CampanaVigenteCOLDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CampanaVigenteDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.helper.Global;

public class CampanaVigenteDAO extends ConnectionDAO {

	protected Logger logger = Logger.getLogger(getClass());

	protected Global global = Global.getInstance();

	private Connection getConection() throws CustomerDomainException {
		Connection conn = null;
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
		}
		catch (Exception e1) {
			conn = null;
			logger.error(" No se pudo obtener una conexión ", e1);
			throw new CustomerDomainException("No se pudo obtener una conexión", e1);
		}
		return conn;
	}

	private String getSQLDatosCampana(String packageName, String procedureName, int paramCount) {
		StringBuffer sb = new StringBuffer("{call " + packageName + "." + procedureName + "(");
		for (int n = 1; n <= paramCount; n++) {
			sb.append("?");
			if (n < paramCount)
				sb.append(",");
		}
		return sb.append(")}").toString();
	}

	private CampanaVigenteDTO getResultset(ResultSet rs, int i) throws CustomerDomainException {
		CampanaVigenteDTO plans = new CampanaVigenteDTO();
		try {
			if (global.ModoEjecucion().equals("prueba1")) {
				plans.setCodigoCampanasVigentes("codPlans" + i);
				plans.setDescripcionCampanasVigentes("desPlans" + i);
			}
			else {
				plans.setCodigoCampanasVigentes(rs.getString(1));
				plans.setDescripcionCampanasVigentes(rs.getString(2));
			}
		}
		catch (SQLException e) {
			throw new CustomerDomainException(global.errorgetListado() + " [" + i + "]", e);
		}
		return plans;
	}

	/**
	 * @return
	 * @throws CustomerDomainException
	 */
	public CampanaVigenteDTO[] getListadoCampaniasVigentes() throws CustomerDomainException {
		logger.info("getListadoCampaniasVigentes, inicio");
		CampanaVigenteDTO[] r = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		final String nombrePackage = "VE_PARAMETROS_COMERCIALES_PG";
		final String nombrePL = "VE_campanavigente_PR";
		final int cantParametros = 4;
		try {
			conn = getConection();
			logger.debug("Conexión obtenida OK");
			if (global.ModoEjecucion().equals("prueba1")) {
				ArrayList lista = new ArrayList();
				for (int i = 0; i <= 1080; i++) {
					logger.debug("Procesando iteración :" + i);

					CampanaVigenteDTO CampanasVigentes = null;
					CampanasVigentes = getResultset(null, i);
					lista.add(CampanasVigentes);
				}
				r = (CampanaVigenteDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), CampanaVigenteDTO.class);
			}
			else {
				final String call = getSQLDatosCampana(nombrePackage, nombrePL, cantParametros);
				logger.debug("sql [" + call + "]");
				cstmt = conn.prepareCall(call);
				cstmt.registerOutParameter(1, OracleTypes.CURSOR);
				cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
				logger.debug("Execute Antes");
				cstmt.execute();
				logger.debug("Execute Despues");
				rs = (ResultSet) cstmt.getObject(1);
				ArrayList lista = new ArrayList();
				while (rs.next()) {
					logger.debug("Procesando iteración :" + lista.size());
					CampanaVigenteDTO CampanasVigentes = null;
					CampanasVigentes = getResultset(rs, lista.size());
					lista.add(CampanasVigentes);
				}
				r = (CampanaVigenteDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), CampanaVigenteDTO.class);
			}
		}
		catch (Exception e) {
			logger.error(global.errorgetListado(), e);
			throw new CustomerDomainException(global.errorgetListado(), e);
		}
		finally {
			logger.debug("Cerrando conexiones...");
			try {
				if (rs != null)
					rs.close();
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.info("getListadoCampaniasVigentes, fin");
		return r;
	}

	/**
	 * Obtiene campañas vigentes postpago
	 * @param N/A
	 * @return CampanaVigenteDTO[]
	 * @throws CustomerDomainException
	 */
	public CampanaVigenteDTO[] getListCampVigentesPostpago() throws CustomerDomainException {
		logger.debug("Inicio:getListCampVigentesPostpago()");
		CampanaVigenteDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			String call = getSQLDatosCampana("BP_servicios_benefpromo_PG", "BP_getListCampVigPostpago_PR", 4);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.registerOutParameter(1, OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.execute();

			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);

			if (codError != 0) {
				logger.error("Ocurrió un error al recuperar campañas vigentes postpago");
				throw new CustomerDomainException("Ocurrió un error al recuperar campañas vigentes postpago", String
						.valueOf(codError), numEvento, msgError);
			}
			else {
				logger.debug("Recuperando campañas vigentes postpago");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(1);
				while (rs.next()) {
					CampanaVigenteDTO campanaDTO = new CampanaVigenteDTO();
					campanaDTO.setCodigoCampanasVigentes(rs.getString(1));
					campanaDTO.setDescripcionCampanasVigentes(rs.getString(2));
					campanaDTO.setAplicaA(rs.getString(3));

					lista.add(campanaDTO);
				}
				resultado = (CampanaVigenteDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(),
						CampanaVigenteDTO.class);
				rs.close();
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		}
		catch (Exception e) {
			logger.error("Ocurrió un error al recuperar campañas vigentes postpago", e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		}
		finally {
			if (logger.isDebugEnabled())
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:getListCampVigentesPostpago()");
		return resultado;
	}//fin getListCampVigentesPostpago	

	/**
	 * Registra campaña vigente para el cliente
	 * @param entrada
	 * @return N/A
	 * @throws CustomerDomainException
	 */
	public void registraCampanaVigente(CampanaVigenteDTO entrada) throws CustomerDomainException {
		logger.debug("Inicio:registraCampanaVigente");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		logger.debug("Coneccion obtenida OK");
		try {
			String call = getSQLDatosCampana("BP_servicios_benefpromo_PG", "BP_registra_campana_PR", 6);
			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			logger.debug("entrada.getCodigoCampanasVigentes()" + entrada.getCodigoCampanasVigentes());
			cstmt.setString(1, entrada.getCodigoCampanasVigentes());
			logger.debug("entrada.getCodigoCliente()" + entrada.getCodigoCliente());
			cstmt.setLong(2, entrada.getCodigoCliente());
			logger.debug("entrada.getNumeroAbonado()" + entrada.getNumeroAbonado());
			cstmt.setLong(3, entrada.getNumeroAbonado());

			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

			logger.debug("Iniico:registraCampanaVigente:Execute");
			cstmt.execute();
			logger.debug("Fin:registraCampanaVigente:Execute");

			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);

			if (codError != 0) {
				logger.error("Ocurrió un error al registrar campaña vigente para el cliente");
				throw new CustomerDomainException("Ocurrió un error al registrar campaña vigente para el cliente",
						String.valueOf(codError), numEvento, msgError);
			}

			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		}
		catch (Exception e) {
			logger.error("Ocurrió un error al registrar campaña vigente para el cliente", e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		}
		finally {
			if (logger.isDebugEnabled())
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:registraCampanaVigente()");
	}//fin registraCampanaVigente

	/**
	 * Obtiene datos campaña
	 * @param entrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public CampanaVigenteDTO getCampanaVigente(CampanaVigenteDTO entrada) throws CustomerDomainException {
		CampanaVigenteDTO resultado = new CampanaVigenteDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			logger.debug("Inicio:getCampanaVigente");

			String call = getSQLDatosCampana("BP_servicios_benefpromo_PG", "VE_getCampana_PR", 5);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1, entrada.getCodigoCampanasVigentes());
			logger.debug("entrada.getCodigoCampanasVigentes(): "+entrada.getCodigoCampanasVigentes());
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			logger.debug("Inicio:getCampanaVigente:execute");
			cstmt.execute();
			logger.debug("Fin:getCampanaVigente:execute");

			msgError = cstmt.getString(4);
			codError = cstmt.getInt(3);
			numEvento = cstmt.getInt(5);

			if (codError != 0) {
				logger.error("Ocurrió un error al obtener tipo entidad de la campaña");
				throw new CustomerDomainException(String.valueOf(codError), numEvento,
						"Ocurrió un error al obtener tipo entidad de la campaña");
			}
			else
				resultado.setAplicaA(cstmt.getString(2));

		}
		catch (Exception e) {
			logger.error("Ocurrió un error al obtener tipo entidad de la campaña", e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally {
			logger.debug("Cerrando conexiones...");
			try {
				cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:getCampanaVigente");
		return resultado;
	}//fin getCampanaVigente

	/**
	 * Obtiene datos campaña
	 * @param entrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public CampanaVigenteDTO getCampanaVigenteDefault(CampanaVigenteCOLDTO entrada) throws CustomerDomainException {
		CampanaVigenteDTO resultado = new CampanaVigenteDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			logger.debug("Inicio:getCampanaVigente");

			String call = getSQLDatosCampana("VE_PARAMETROS_COMERCIALES_PG", "VE_campanavigenteDefault_PR", 8);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1, entrada.getCodPlantarif());
			cstmt.setString(2, entrada.getTipEntidad());
			cstmt.setString(3, entrada.getInd_default());
			cstmt.setString(4, entrada.getFormato_fecha());

			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);

			logger.debug("Inicio:getCampanaVigente:execute");
			cstmt.execute();
			logger.debug("Fin:getCampanaVigente:execute");

			msgError = cstmt.getString(7);
			codError = cstmt.getInt(6);
			numEvento = cstmt.getInt(8);

			if (codError != 0) {
				logger.error("Ocurrió un error al obtener tipo entidad de la campaña");
				//	throw new CustomerDomainException(String.valueOf(codError),
				//		numEvento, "Ocurrió un error al obtener tipo entidad de la campaña");
			}
			else
				resultado.setCodigoCampanasVigentes(cstmt.getString(5));

		}
		catch (Exception e) {
			logger.error("Ocurrió un error al obtener tipo entidad de la campaña", e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;

		}
		finally {
			logger.debug("Cerrando conexiones...");
			try {
				cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:getCampanaVigente");
		return resultado;
	}//fin getCampanaVigente

	/**
	 * @return
	 * @throws CustomerDomainException
	 */
	public CampanaVigenteDTO[] getListadoCampaniasVigentesXCodTiplan(String codTiplan) throws CustomerDomainException {
		logger.info("getCampaniasVigentesXCodTiplan, inicio");
		logger.debug("codTiplan [" + codTiplan + "]");
		CampanaVigenteDTO[] r = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		final String nombrePackage = "VE_PARAMETROS_COMERCIALES_PG";
		final String nombrePL = "VE_list_campVigXCodTiplan_PR";
		final int cantParametros = 5;
		String mensajeError = "Ocurrio un error al recuperar campañas vigentes";
		try {
			int i = 1;
			conn = getConection();
			logger.debug("Conexión obtenida OK");
			final String call = getSQLDatosCampana(nombrePackage, nombrePL, cantParametros);
			logger.debug("sql [" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(i++, codTiplan);
			cstmt.registerOutParameter(i++, OracleTypes.CURSOR);
			cstmt.registerOutParameter(i++, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(i++, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(i++, java.sql.Types.NUMERIC);
			logger.debug("Execute Antes");
			cstmt.execute();
			logger.debug("Execute Despues");
			
			codError  = cstmt.getInt(3);
			msgError  = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			if (codError != 0) {
				logger.error(mensajeError);
				throw new CustomerDomainException(mensajeError, String.valueOf(codError), numEvento, msgError);
			}
			
			ArrayList lista = new ArrayList();
			rs = (ResultSet) cstmt.getObject(2);
			while (rs.next()) {
				CampanaVigenteDTO dto = new CampanaVigenteDTO();
				dto.setCodigoCampanasVigentes(rs.getString(1));
				dto.setDescripcionCampanasVigentes(rs.getString(2));
				lista.add(dto);
			}
			r = (CampanaVigenteDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), CampanaVigenteDTO.class);
		}
		catch (CustomerDomainException e) {
			logger.error(StackTraceUtl.getStackTrace(e));
			throw e;
		}
		catch (Exception e) {
			logger.error("codError [" + codError + "]");
			logger.error("msgError [" + msgError + "]");
			logger.error("numEvento [" + numEvento + "]");
			logger.error(StackTraceUtl.getStackTrace(e));
		}
		finally {
			logger.debug("Cerrando conexiones...");
			try {
				if (rs != null)
					rs.close();
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("r.length [" + r.length + "]");
		logger.info("getCampaniasVigentesXCodTiplan, fin");
		return r;
	}
}//fin class CampanaVigenteDAO