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
 * 23/02/2007     Roberto P&eacute;rez Varas      					Versión Inicial
 */
package com.tmmas.cl.scl.parametrosgenerales.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.helper.Global;
import com.tmmas.cl.scl.parametrosgenerales.businessobject.dto.ParametrosGeneralesDTO;

public class ParametrosGeneralesDAO extends ConnectionDAO{
	private static Category cat = Category.getInstance(ParametrosGeneralesDAO.class);
	Global global = Global.getInstance();

	private Connection getConection() 
	throws GeneralException
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

	/**
	 * Obtiene Parametros Generales
	 * @param parametroGeneral 
	 * @return resultado
	 * @throws GeneralException
	 */

	public ParametrosGeneralesDTO getParametroGeneral(ParametrosGeneralesDTO parametrogeneral) 
	throws GeneralException{
		ParametrosGeneralesDTO resultado = new ParametrosGeneralesDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:ParametrosGeneralesDAO:getParametroGeneral()");

			//INI-01 (AL) String call = getSQLDatosAbonado("VE_intermediario_PG","VE_obtiene_valor_parametro_PR",7);
			String call = getSQLDatosAbonado("VE_intermediario_Quiosco_PG","VE_obtiene_valor_parametro_PR",7);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,parametrogeneral.getNombreparametro());
			cat.debug("Nombreparametro() ["+parametrogeneral.getNombreparametro() +"]");
			cstmt.setString(2, parametrogeneral.getCodigomodulo());
			cat.debug("Codigomodulo() ["+parametrogeneral.getCodigomodulo() +"]");								
			cstmt.setString(3, parametrogeneral.getCodigoproducto());
			cat.debug("Codigoproducto() ["+parametrogeneral.getCodigoproducto() +"]");				
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);

			cat.debug("Inicio:ParametrosGeneralesDAO:getParametroGeneral:execute");
			cstmt.execute();
			cat.debug("Fin:ParametrosGeneralesDAO:getParametroGeneral:execute");

			codError = cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento = cstmt.getInt(7);

			cat.debug("codError[" + codError + "]");
			cat.debug("msgError[" + msgError + "]");
			cat.debug("numEvento["+numEvento+"]");

			if (codError == 0){
				resultado.setNombreparametro(parametrogeneral.getNombreparametro());
				resultado.setCodigomodulo(parametrogeneral.getCodigomodulo());
				resultado.setCodigoproducto(parametrogeneral.getCodigoproducto());
				resultado.setValorparametro(cstmt.getString(4));
			}else{
				cat.error("Ocurrió un error al obtener parametro general");
				throw new GeneralException(String.valueOf(codError),numEvento, msgError);
			}
		}catch (GeneralException e) {
			throw e;	
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener parametro general",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException (e);
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
		cat.debug("Fin:ParametrosGeneralesDAO:getParametroGeneral()");
		return resultado;
	}//fin getParametroGeneral

	/**
	 * Obtiene Parametro de Facturación
	 * @param parametroGeneral 
	 * @return resultado
	 * @throws GeneralException
	 */


	public ParametrosGeneralesDTO getParametroFacturacion(ParametrosGeneralesDTO parametrogeneral) throws GeneralException{
		ParametrosGeneralesDTO resultado = new ParametrosGeneralesDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:getParametroFacturacion()");

			//INI-01 (AL) String call = getSQLDatosAbonado("VE_servicios_venta_PG","VE_obtiene_parametro_fact_PR",5);
			String call = getSQLDatosAbonado("VE_servicios_venta_quiosco_PG","VE_obtiene_parametro_fact_PR",5);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,parametrogeneral.getNombreparametro());
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getParametroGeneral:execute");
			cstmt.execute();
			cat.debug("Fin:getParametroGeneral:execute");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);

			cat.debug("codError[" + codError + "]");
			cat.debug("msgError[" + msgError + "]");
			cat.debug("numEvento["+numEvento+"]");

			if (codError == 0){
				resultado.setValorparametro(cstmt.getString(2));
			}else{
				cat.error("Ocurrió un error al obtener parametro de facturacion");
				throw new GeneralException(String.valueOf(codError),numEvento, msgError);
			}
		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener parametro de facturacion",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException (e);
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
		cat.debug("Fin:getParametroFacturacion()");
		return resultado;
	}//fin getParametroFacturacion

	/**
	 * Obtiene Parametro de Grupo Tecnologico
	 * @param parametroGeneral 
	 * @return resultado
	 * @throws GeneralException
	 */
	public ParametrosGeneralesDTO getParametroGrupoTecnologico(ParametrosGeneralesDTO parametroGeneral) 
	throws GeneralException{
		ParametrosGeneralesDTO resultado = new ParametrosGeneralesDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:ParametrosGeneralesDAO:getParametroGrupoTecnologico()");

			//INI-01 (AL) String call = getSQLDatosAbonado("VE_intermediario_PG","VE_ObtieneGrupoTecnologico_PR",5);
			String call = getSQLDatosAbonado("VE_intermediario_Quiosco_PG","VE_ObtieneGrupoTecnologico_PR",5);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,parametroGeneral.getNombreparametro());
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cat.debug("Inicio:ParametrosGeneralesDAO:getParametroGrupoTecnologico:execute");
			cstmt.execute();
			cat.debug("Fin:ParametrosGeneralesDAO:getParametroGrupoTecnologico:execute");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);

			cat.debug("codError[" + codError + "]");
			cat.debug("msgError[" + msgError + "]");
			cat.debug("numEvento["+numEvento+"]");

			if (codError == 0){
				resultado.setValorparametro(cstmt.getString(2));
			}else{
				cat.error("Ocurrió un error al obtener parametro de facturacion");
				throw new GeneralException(String.valueOf(codError),numEvento, msgError);
			}
		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener parametro general",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException (e);
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
		cat.debug("Fin:ParametrosGeneralesDAO:getParametroGrupoTecnologico()");
		return resultado;
	}//fin getParametroGrupoTecnologico

	/**
	 * Obtiene Parametros desde Mas Generales
	 * @param parametroGeneral 
	 * @return resultado
	 * @throws GeneralException
	 */

	public ParametrosGeneralesDTO getParametroMasGeneral(ParametrosGeneralesDTO parametrogeneral) 
	throws GeneralException
	{
		ParametrosGeneralesDTO resultado = new ParametrosGeneralesDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:ParametrosGeneralesDAO:getParametroMasGeneral()");

			//INI-01 (AL) String call = getSQLDatosAbonado("Ve_Servicios_Venta_Pg","VE_obtiene_parametro_PR",7);
			String call = getSQLDatosAbonado("Ve_Servicios_Venta_Quiosco_Pg","VE_obtiene_parametro_PR",7);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,parametrogeneral.getNombreparametro());
			cstmt.setString(2, parametrogeneral.getCodigomodulo());
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);

			cat.debug("Inicio:ParametrosGeneralesDAO:getParametroMasGeneral:execute");
			cstmt.execute();
			cat.debug("Fin:ParametrosGeneralesDAO:getParametroMasGeneral:execute");

			codError = cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento = cstmt.getInt(7);

			cat.debug("codError[" + codError + "]");
			cat.debug("msgError[" + msgError + "]");
			cat.debug("numEvento["+numEvento+"]");

			if (codError == 0){
				resultado.setNombreparametro(parametrogeneral.getNombreparametro());
				resultado.setCodigomodulo(parametrogeneral.getCodigomodulo());				
				resultado.setValorparametro(String.valueOf(cstmt.getLong(4)));
			}else{
				cat.error("Ocurrió un error al obtener parametro de facturacion");
				throw new GeneralException(String.valueOf(codError),numEvento, msgError);
			}
		} catch (GeneralException e) {
			throw e;			
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener parametro mas general",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException (e);
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
		cat.debug("Fin:ParametrosGeneralesDAO:getParametroMasGeneral()");
		return resultado;
	}//fin getParametroGeneral

}//fin ParametrosGeneralesDAO
