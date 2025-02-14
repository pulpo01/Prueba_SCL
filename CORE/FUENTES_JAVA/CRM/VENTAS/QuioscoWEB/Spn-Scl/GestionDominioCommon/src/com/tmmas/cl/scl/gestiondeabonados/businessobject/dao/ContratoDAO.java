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
 * 27/02/2007     H&eacute;ctor Hermosilla      					Versión Inicial
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
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.DatosValidacionDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.helper.Global;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ContratoDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.TipoContratoClienteDTO;

public class ContratoDAO extends ConnectionDAO {
	private static Category cat = Category.getInstance(ContratoDAO.class);

	Global global = Global.getInstance();

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
	}

	private String getSQLPackage(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
		for (int n = 1; n <= paramCount; n++) {
			sb.append("?");
			if (n < paramCount) sb.append(",");
		}
		return sb.append(")}").toString();

	}



	public DatosValidacionDTO getValidaNuevoContratoCliente(ContratoDTO contrato) throws GeneralException{
		DatosValidacionDTO resultado = new DatosValidacionDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:getValidaContratoCliente");

			//INI-01 (AL) String call = getSQLPackage("VE_validacion_linea_PG","VE_existe_contrato_PR",5);
			String call = getSQLPackage("VE_validacion_linea_quiosco_PG","VE_existe_contrato_PR",5);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,contrato.getNumeroContrato());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getValidaContratoCliente:execute");
			cstmt.execute();
			cat.debug("Fin:getValidaContratoCliente:execute");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);

			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar abonados para la venta");
				throw new GeneralException(
						"Ocurrió un error al recuperar abonados para la venta", String
						.valueOf(codError), numEvento, msgError);

			}else			
				resultado.setExisteContrato(cstmt.getInt(2));

		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al verificar el Número de Contrato",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
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
		cat.debug("Fin:getValidaContratoCliente()");

		return resultado;
	}//fin getValidaClienteAgenteComercial

	public ContratoDTO[] getListadoTipoContrato(ContratoDTO contrato) throws GeneralException{
		cat.debug("getListadoTipoContrato:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ContratoDTO[] resultado = null;
		Connection conn = null;
		CallableStatement cstmt=null;
		conn = getConection();
		if (cat.isDebugEnabled())
			cat.debug("Coneccion obtenida OK");
		try {
			//INI-01 (AL) String call = getSQLPackage("VE_PARAMETROS_COMERCIALES_PG","VE_tipocontrato_PR",10);
			String call = getSQLPackage("VE_PARAMETROS_COMER_QUIOSCO_PG","VE_tipocontrato_PR",10);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,contrato.getNombreUsuario());
			cstmt.setInt(2,contrato.getCodigoProducto());
			cstmt.setString(3,contrato.getIndContCel());
			cstmt.setString(4,contrato.getIndContSeg());
			cstmt.setString(5,contrato.getDatosPrograma().getCodigoPrograma());
			cstmt.setInt(6,contrato.getDatosPrograma().getNumeroVersion());
			cstmt.registerOutParameter(7,OracleTypes.CURSOR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);
			if (cat.isDebugEnabled())
				cat.debug("Execute Antes");
			cstmt.execute();
			if (cat.isDebugEnabled())
				cat.debug("Execute Despues");

			codError = cstmt.getInt(8);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(9);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(10);
			cat.debug("numEvento[" + numEvento + "]");

			if (codError != 0) {
				cat.error("Ocurrió un error al consultar el tipo de contrato");
				throw new GeneralException(
						"Ocurrió un error al consultar el tipo de contrato", String
						.valueOf(codError), numEvento, msgError);

			}else{
				if (cat.isDebugEnabled())
					cat.debug("Llenado Tipo de Contrato");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(7);
				while (rs.next()) {
					ContratoDTO tipoContrato = new ContratoDTO();
					tipoContrato.setCodigoTipoContrato(rs.getString(1));
					tipoContrato.setDescripcionTipoContrato(rs.getString(2));
					lista.add(tipoContrato);
				}
				rs.close();
				resultado =(ContratoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
						lista.toArray(), ContratoDTO.class);
				if (cat.isDebugEnabled())
					cat.debug("Fin Llenado Tipo de Contrato");
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al consultar el tipo de contrato",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al consultar el tipo de contrato",e);
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

		cat.debug("getListadoTipoContrato():end");

		return resultado;
	}

	public ContratoDTO getListadoNumeroMesesContrato(ContratoDTO contrato) throws GeneralException{

		cat.debug("getListadoNumeroMesesContrato:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;

		ContratoDTO resultado = new ContratoDTO();
		Connection conn = null;
		CallableStatement cstmt=null;
		conn = getConection();
		if (cat.isDebugEnabled())
			cat.debug("Coneccion obtenida OK");
		try {
			//INI-01 (AL) String call = getSQLPackage("VE_PARAMETROS_COMERCIALES_PG","VE_nromesescontrato_PR",6);
			String call = getSQLPackage("VE_PARAMETROS_COMER_QUIOSCO_PG","VE_nromesescontrato_PR",6);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,contrato.getCodigoTipoContrato());
			cstmt.setInt(2,contrato.getCodigoProducto());
			cstmt.registerOutParameter(3,OracleTypes.CURSOR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			if (cat.isDebugEnabled())
				cat.debug("Execute Antes");
			cstmt.execute();
			if (cat.isDebugEnabled())
				cat.debug("Execute Despues");

			codError = cstmt.getInt(4);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(5);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(6);
			cat.debug("numEvento[" + numEvento + "]");

			if (codError != 0) {
				cat.error("Ocurrió un error al consultar Número de Meses");
				throw new GeneralException(
						"Ocurrió un error al consultar Número de Meses", String
						.valueOf(codError), numEvento, msgError);

			}else{
				if (cat.isDebugEnabled())
					cat.debug("Llenado Tipo de Contrato");
				ResultSet rs = (ResultSet) cstmt.getObject(3);
				ArrayList lista = new ArrayList();
				while (rs.next()) {
					lista.add(rs.getString(2));
					cat.debug("TipoContrato"+ rs.getString(1));
				}
				rs.close();
				resultado.setNumeroMesesContrato(lista);
				if (cat.isDebugEnabled())
					cat.debug("Fin Llenado Tipo de Contrato");
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al consultar el tipo de contrato",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al consultar el tipo de contrato",e);
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

		cat.debug("getListadoNumeroMesesContrato():end");

		return resultado;
	}

	/**
	 * Consulta tipo contrato
	 * @param contrato
	 * @return contrato
	 * @throws GeneralException
	 */
	public ContratoDTO getTipoContrato(ContratoDTO contrato) throws GeneralException{

		cat.debug("getTipoContrato:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt=null;
		conn = getConection();
		if (cat.isDebugEnabled())
			cat.debug("Coneccion obtenida OK");
		try {
			//INI-01 (AL) String call = getSQLPackage("Ve_Servicios_Venta_Pg","VE_con_tipocontrato_PR",7);
			String call = getSQLPackage("Ve_Servicios_Venta_Quiosco_Pg","VE_con_tipocontrato_PR",7);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setInt(1,contrato.getCodigoProducto());
			cstmt.setString(2,contrato.getCodigoTipoContrato());
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			if (cat.isDebugEnabled())
				cat.debug("Execute Antes");
			cstmt.execute();
			if (cat.isDebugEnabled())
				cat.debug("Execute Despues");

			codError = cstmt.getInt(5);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(6);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(7);
			cat.debug("numEvento[" + numEvento + "]");

			if (codError != 0) {
				cat.error("Ocurrió un error al consultar el tipo de contrato");
				throw new GeneralException(
						"Ocurrió un error al consultar el tipo de contrato", String
						.valueOf(codError), numEvento, msgError);

			}else
				contrato.setDescripcionTipoContrato(cstmt.getString(3)); 
			contrato.setIndComodato(cstmt.getInt(4));

			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al consultar el tipo de contrato",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al consultar el tipo de contrato",e);
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

		cat.debug("getTipoContrato():end");

		return contrato;
	}

	/**
	 * inserta contrato
	 * @param entrada
	 * @return
	 * @throws GeneralException
	 */

	public void altaContrato(ContratoDTO entrada)throws GeneralException{

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			cat.debug("Inicio:altaContrato()");

			//INI-01 (AL) String call = getSQLPackage("Ve_Servicios_Venta_Pg","VE_inserta_contrato_PR",12);
			String call = getSQLPackage("Ve_Servicios_Venta_Quiosco_Pg","VE_inserta_contrato_PR",12);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,entrada.getCodigoCuenta());
			cat.debug("entrada.getCodigoCuenta(): " + entrada.getCodigoCuenta());
			cstmt.setInt(2,entrada.getCodigoProducto());
			cat.debug("entrada.getCodigoProducto(): " + entrada.getCodigoProducto());
			cstmt.setString(3,entrada.getCodigoTipoContrato());
			cat.debug("entrada.getCodigoTipoContrato(): " + entrada.getCodigoTipoContrato());
			cstmt.setString(4,entrada.getNumeroContrato());
			cat.debug("entrada.getNumeroContrato(): " + entrada.getNumeroContrato());
			cstmt.setString(5,entrada.getNumeroAnexo());
			cat.debug("entrada.getNumeroAnexo(): " + entrada.getNumeroAnexo());
			cstmt.setInt(6,entrada.getNumeroMeses());
			cat.debug("entrada.getNumeroMeses(): " + entrada.getNumeroMeses());
			cstmt.setLong(7,entrada.getNumeroVenta());
			cat.debug("entrada.getNumeroVenta(): " + entrada.getNumeroVenta());
			cstmt.setInt(8,entrada.getNumeroAbonados());
			cat.debug("entrada.getNumeroAbonados(): " + entrada.getNumeroAbonados());
			cstmt.setString(9,entrada.getNumAbonado());
			cat.debug("entrada.getNumAbonado(): " + entrada.getNumAbonado());

			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(12, java.sql.Types.NUMERIC);

			cat.debug("Inicio:altaContrato:execute");
			cstmt.execute();
			cat.debug("Fin:altaContrato:execute");

			codError=cstmt.getInt(10);
			msgError = cstmt.getString(11);
			numEvento=cstmt.getInt(12);

			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				cat.error("Ocurrió un error al insertar en tabla GA_CONTCTA");
				throw new GeneralException(
						"Ocurrió un error al insertar en tabla GA_CONTCTA", String
						.valueOf(codError), numEvento, msgError);
			}		
		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al insertar en tabla GA_CONTCTA",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al insertar en tabla GA_CONTCTA",e);
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

		cat.debug("Fin:altaContrato()");

	}

	/**
	 * Busca el mayor numero de anexo asociado al contrato
	 * @param entrada
	 * @return
	 * @throws GeneralException
	 */
	public ContratoDTO getMaxAnexoContrato(ContratoDTO contrato) throws GeneralException{

		cat.debug("getMaxAnexoContrato:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt=null;
		conn = getConection();
		if (cat.isDebugEnabled())
			cat.debug("Coneccion obtenida OK");
		try {
			//INI-01 (AL) String call = getSQLPackage("Ve_Servicios_Venta_Pg","VE_con_max_anexo_contrato_PR",8);
			String call = getSQLPackage("Ve_Servicios_Venta_Quiosco_Pg","VE_con_max_anexo_contrato_PR",8);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,contrato.getCodigoCuenta());
			cstmt.setInt(2,contrato.getCodigoProducto());
			cstmt.setString(3,contrato.getCodigoTipoContrato());
			cstmt.setString(4,contrato.getNumeroContrato());
			cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			if (cat.isDebugEnabled())
				cat.debug("Execute Antes");
			cstmt.execute();
			if (cat.isDebugEnabled())
				cat.debug("Execute Despues");

			codError = cstmt.getInt(6);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(7);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(8);
			cat.debug("numEvento[" + numEvento + "]");

			if (codError != 0) {
				cat.error("Ocurrió un error al consultar el máximo anexo del contrato");
				throw new GeneralException(
						"Ocurrió un error al consultar el máximo anexo del contrato", String
						.valueOf(codError), numEvento, msgError);

			}else
				contrato.setNumeroAnexo(String.valueOf(cstmt.getInt(5)));

			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al consultar el máximo anexo del contrato",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al consultar el máximo anexo del contrato",e);
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

		cat.debug("getMaxAnexoContrato():end");

		return contrato;		
	}

	/**
	 * Busca el mayor numero de anexo asociado al contrato
	 * @param entrada
	 * @return
	 * @throws GeneralException
	 */
	public TipoContratoClienteDTO obtieneTipContratoCliente(Long codCliente)
	throws GeneralException		
	{		
		cat.debug("ContratoDAO.obtieneTipContratoCliente:start");
		TipoContratoClienteDTO resultado = new TipoContratoClienteDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt=null;
		conn = getConection();
		if (cat.isDebugEnabled())
			cat.debug("Coneccion obtenida OK");
		try {
			//INI-01 (AL) String call = getSQLPackage("Ve_Servicios_Venta_Pg","VE_obtiene_TipContrato_PR",10);
			String call = getSQLPackage("Ve_Servicios_Venta_Quiosco_Pg","VE_obtiene_TipContrato_PR",10);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1,codCliente.longValue());
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);
			if (cat.isDebugEnabled())
				cat.debug("Execute Antes");
			cstmt.execute();
			if (cat.isDebugEnabled())
				cat.debug("Execute Despues");

			codError = cstmt.getInt(8);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(9);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(10);
			cat.debug("numEvento[" + numEvento + "]");

			if (codError != 0) {
				cat.debug("No se encontro tipo contrato asociado a cliente");
				resultado.setCodCliente(new Long(0));

			}else{
				cat.debug("Encontro tipo contrato asociado a cliente");
				resultado.setCodCliente(codCliente);
				resultado.setCodPlanTarif(cstmt.getString(2));
				resultado.setCodUso(new Long(cstmt.getLong(3)));
				resultado.setCodProducto(new Long(cstmt.getLong(4)));
				resultado.setCodTipContrato(cstmt.getString(5));
				resultado.setNombreContrato(cstmt.getString(6));
				resultado.setNroMesesContrato(new Long(cstmt.getLong(7)));				
			}

			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			cat.error("Ocurrio un error al obtener tipo de contrato asociado a cliente",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrio un error al obtener tipo de contrato asociado a cliente",e);
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
		cat.debug("ContratoDAO.obtieneTipContratoCliente():end");

		return resultado;

	}

	/**
	 * Inserta tipo contrato asociado al cliente
	 * @param TipoContratoClienteDTO
	 * @throws GeneralException
	 */	
	public void insertaTipContratoCliente(TipoContratoClienteDTO entrada)
	throws GeneralException		
	{		
		cat.debug("ContratoDAO.insertaTipContratoCliente:start");		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt=null;
		conn = getConection();
		if (cat.isDebugEnabled())
			cat.debug("Coneccion obtenida OK");
		try {			

			//INI-01 (AL) String call = getSQLPackage("Ve_Servicios_Venta_Pg","VE_inserta_CteContrato_PR",9);
			String call = getSQLPackage("Ve_Servicios_Venta_Quiosco_Pg","VE_inserta_CteContrato_PR",9);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cat.debug("insertaTipContratoCliente codCliente : " + entrada.getCodCliente().longValue());
			cstmt.setLong(1,entrada.getCodCliente().longValue());
			cat.debug("insertaTipContratoCliente codPlanTarif : " + entrada.getCodPlanTarif());
			cstmt.setString(2,entrada.getCodPlanTarif());
			cat.debug("insertaTipContratoCliente codUso : " + entrada.getCodUso().longValue());
			cstmt.setLong(3,entrada.getCodUso().longValue());
			cat.debug("insertaTipContratoCliente codProducto : " + entrada.getCodProducto().longValue());
			cstmt.setLong(4,entrada.getCodProducto().longValue());
			cat.debug("insertaTipContratoCliente codTipContrato : " + entrada.getCodTipContrato());
			cstmt.setString(5,entrada.getCodTipContrato());
			cat.debug("insertaTipContratoCliente nombreUsuario : " + entrada.getNomUsuario());
			cstmt.setString(6,entrada.getNomUsuario());			
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);
			if (cat.isDebugEnabled())
				cat.debug("Execute Antes");
			cstmt.execute();
			if (cat.isDebugEnabled())
				cat.debug("Execute Despues");

			codError = cstmt.getInt(7);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(8);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(9);
			cat.debug("numEvento[" + numEvento + "]");

			if (codError != 0) {

				cat.error("No se pudo insertar el cliente contrato");
				throw new GeneralException(
						"No se pudo insertar el cliente contrato", String
						.valueOf(codError), numEvento, msgError);				
			}

			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		}catch (GeneralException e) {
			throw e;		
		} catch (Exception e) {
			cat.error("Ocurrio un error al insertar el cliente contrato",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrio un error al insertar el cliente contrato",e);
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

		cat.debug("ContratoDAO.insertaTipContratoCliente():end");		
	}


	public ContratoDTO getTipcontrato(ContratoDTO contrato) throws GeneralException{		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:getValidaContratoCliente");

			/*
              sn_cod_producto	 OUT NOCOPY ga_tipcontrato.cod_producto%TYPE,    
		      sv_cod_tipcontrato OUT NOCOPY ga_tipcontrato.cod_tipcontrato%TYPE,                
		      sv_des_tipcontrato OUT NOCOPY ga_tipcontrato.des_tipcontrato%TYPE,                
		      sv_ind_contseg     OUT NOCOPY ga_tipcontrato.ind_contseg%TYPE,                    
		      sv_ind_contcel     OUT NOCOPY ga_tipcontrato.ind_contcel%TYPE,                    
		      sn_ind_comodato    OUT NOCOPY ga_tipcontrato.ind_comodato%TYPE,                   
		      sn_canal_vta       OUT NOCOPY ga_tipcontrato.canal_vta%TYPE,                      
		      sn_meses_minimo    OUT NOCOPY ga_tipcontrato.meses_minimo%TYPE,                   
		      sv_ind_procequi    OUT NOCOPY ga_tipcontrato.ind_procequi%TYPE,                   
		      sv_ind_preciolista OUT NOCOPY ga_tipcontrato.ind_preciolista%TYPE,                
		      sv_ind_gmc         OUT NOCOPY ga_tipcontrato.ind_gmc%TYPE,

		      sn_cod_retorno     OUT NOCOPY ge_errores_td.cod_msgerror%TYPE,		      
		      sv_mens_retorno    OUT NOCOPY ge_errores_td.det_msgerror%TYPE,
		      sn_num_evento      OUT NOCOPY ge_errores_pg.evento 
			 */

			String call = getSQLPackage("VE_PORTABILIDAD_PG","ve_tip_contrato_pr",15);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,contrato.getCodigoTipoContrato());

			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);    
			cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);						
			cstmt.registerOutParameter(13, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(15, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getValidaContratoCliente:execute");
			cstmt.execute();
			cat.debug("Fin:getValidaContratoCliente:execute");

			msgError = cstmt.getString(4);
			cat.debug("msgError[" + msgError + "]");

			codError = cstmt.getInt(13);			
			msgError = cstmt.getString(14);			
			numEvento = cstmt.getInt(15);

			cat.debug("codError[" + codError + "]");
			cat.debug("msgError[" + msgError + "]");
			cat.debug("numEvento[" + numEvento + "]");

			if (codError != 0) {
				cat.error("Ocurrió un error al consultar contrato");
				throw new GeneralException(
						"Ocurrió un error al consultar contrato", String
						.valueOf(codError), numEvento, msgError);

			}			

			contrato.setCodigoProducto(cstmt.getInt(2)); 
			contrato.setCodigoTipoContrato(cstmt.getString(3));
			contrato.setDescripcionTipoContrato(cstmt.getString(4));
			contrato.setIndContSeg(cstmt.getString(5));
			contrato.setIndContCel(cstmt.getString(6));
			contrato.setIndComodato(cstmt.getInt(7));

			contrato.setNumeroMeses(cstmt.getInt(9));

		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al verificar el Número de Contrato",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
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
		cat.debug("Fin:getValidaContratoCliente()");

		return contrato;
	}//fin getValidaClienteAgenteComercial    


}





