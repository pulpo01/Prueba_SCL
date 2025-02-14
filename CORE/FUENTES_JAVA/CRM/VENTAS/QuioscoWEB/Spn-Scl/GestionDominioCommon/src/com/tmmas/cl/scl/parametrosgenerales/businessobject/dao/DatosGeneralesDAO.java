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
 * 13/03/2007     Héctor Hermosilla      					Versión Inicial
 */
package com.tmmas.cl.scl.parametrosgenerales.businessobject.dao;

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
import com.tmmas.cl.scl.gestiondeabonados.businessobject.helper.Global;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.EstadoDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsNumeroSerieInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsNumeroSerieOutDTO;
import com.tmmas.cl.scl.parametrosgenerales.businessobject.dto.DatosGeneralesDTO;
import com.tmmas.cl.scl.parametrosgenerales.businessobject.dto.EstadoCivilDTO;
import com.tmmas.cl.scl.parametrosgenerales.businessobject.dto.OcupacionDTO;

public class DatosGeneralesDAO extends ConnectionDAO {

	private static Category cat = Category.getInstance(DatosGeneralesDAO.class);

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
	}//fin getConection

	private String getSQL(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
		for (int n = 1; n <= paramCount; n++) {
			sb.append("?");
			if (n < paramCount) sb.append(",");
		}
		return sb.append(")}").toString();

	}//fin getSQL

	/**
	 * Obtiene Valor del parametro pasando como filtro el nombre del parametro mas el código de producto y código de módulo.
	 * @param datosGenerales
	 * @return datosGenerales
	 * @throws GeneralException
	 */

	public DatosGeneralesDTO getValorParametro(DatosGeneralesDTO datosGenerales) throws GeneralException{
		cat.debug("Inicio:getValorParametro()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		cat.debug("Coneccion obtenida OK");
		try {
			//INI-01 (AL) String call = getSQL("VE_intermediario_PG","VE_obtiene_valor_parametro_PR",7);
			String call = getSQL("VE_intermediario_Quiosco_PG","VE_obtiene_valor_parametro_PR",7);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,datosGenerales.getCodigoParametro());
			cstmt.setString(2,datosGenerales.getCodigoModulo());
			cstmt.setInt(3,Integer.parseInt(datosGenerales.getCodigoProducto()));
			cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7,java.sql.Types.NUMERIC);
			cstmt.execute();

			datosGenerales.setValorParametro(cstmt.getString(4));

			codError = cstmt.getInt(5);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(6);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(7);
			cat.debug("numEvento[" + numEvento + "]");
			if (codError != 0) {
				cat.error("Ocurrió un error al consultar los Datos Generales");
				throw new GeneralException(
						"Ocurrió un error al consultar los Datos Generales", String
						.valueOf(codError), numEvento, msgError);
			}

			cat.debug("Valor Parametro[" + datosGenerales.getValorParametro() + "]");

			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
			// Recuperacion de valores de salida

		} catch (GeneralException e) {
			cat.error("Ocurrió un error al consultar los Datos Generales",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw(e);
		} catch (Exception e) {
			cat.error("Ocurrió un error al consultar los Datos Generales",e);
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

		cat.debug("Fin:getValorParametro()");

		return datosGenerales;
	}//fin getValorParametro

	/**
	 * Obtiene Valor del parametro pasando como filtro el nombre del parametro mas el código de producto y código de módulo.
	 * @param datosGenerales
	 * @return datosGenerales
	 * @throws GeneralException
	 */

	public String getCodigoOperadora() throws GeneralException{
		cat.debug("Inicio:getCodigoOperadora()");
		int codError = 0;
		String resultado = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		cat.debug("Coneccion obtenida OK");
		try {
			//INI-01 (AL) String call = getSQL("VE_intermediario_PG","VE_ObtieneOperadora_PR",4);
			String call = getSQL("VE_intermediario_Quiosco_PG","VE_ObtieneOperadora_PR",4);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.registerOutParameter(1,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(2,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);

			cat.debug("inicio:Execute");
			cstmt.execute();
			cat.debug("Fin:Execute");

			resultado = cstmt.getString(1);

			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);

			if (codError != 0) {
				cat.error("Ocurrió un error al obtener codigo operadora");
				throw new GeneralException(
						"Ocurrió un error al obener codigo operadora", String
						.valueOf(codError), numEvento, msgError);
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}

		} catch (GeneralException e) {
			cat.error("Ocurrió un error al obtener codigo operadora",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw(e);
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener codigo operadora",e);
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
		cat.debug("Fin:getCodigoOperadora()");
		return resultado;
	}//fin getCodigoOperadora


	/**
	 * Obtiene la descripción de la operadora
	 * @param datosGenerales
	 * @return datosGenerales
	 * @throws GeneralException
	 */

	public String getDescripcionOperadora() throws GeneralException{
		cat.debug("Inicio:getCodigoOperadora()");
		int codError = 0;
		String resultado = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		cat.debug("Coneccion obtenida OK");
		try {
			//INI-01 (AL) String call = getSQL("VE_intermediario_PG","VE_ObtieneOperadora_PR",5);
			String call = getSQL("VE_intermediario_Quiosco_PG","VE_ObtieneOperadora_PR",5);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.registerOutParameter(1,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(2,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);

			cat.debug("inicio:Execute");
			cstmt.execute();
			cat.debug("Fin:Execute");

			resultado = cstmt.getString(2);

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);

			if (codError != 0) {
				cat.error("Ocurrió un error al obener codigo operadora");
				throw new GeneralException(
						"Ocurrió un error al obener codigo operadora", String
						.valueOf(codError), numEvento, msgError);
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}

		} catch (GeneralException e) {
			cat.error("Ocurrió un error al obtener codigo operadora",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw(e);
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener codigo operadora",e);
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
		cat.debug("Fin:getCodigoOperadora()");
		return resultado;
	}//fin getDescripcionOperadora


	/**
	 * Obtiene Valor del parametro pasando como filtro el nombre del parametro mas el código de producto y código de módulo.
	 * @param datosGenerales
	 * @return datosGenerales
	 * @throws GeneralException
	 */

	public DatosGeneralesDTO getResultadoTransaccion(DatosGeneralesDTO datosGenerales) throws GeneralException{
		cat.debug("Inicio:getResultadoTransaccion()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		cat.debug("Coneccion obtenida OK");
		try {
			//INI-01 (AL) String call = getSQL("VE_intermediario_PG","VE_obtiene_transaccion_PR",4);
			String call = getSQL("VE_intermediario_Quiosco_PG","VE_obtiene_transaccion_PR",4);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,datosGenerales.getNumTransaccion());
			cstmt.registerOutParameter(2,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);

			cat.debug("inicio:Execute");
			cstmt.execute();
			cat.debug("Fin:Execute");		
			
			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);

			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				cat.error("currió un error al obtener resultado de la transaccion");
				throw new GeneralException(
						"currió un error al obtener resultado de la transaccion", String
						.valueOf(codError), numEvento, msgError);
			}else{

				datosGenerales.setNumTransaccion(datosGenerales.getNumTransaccion());
				datosGenerales.setCodError(cstmt.getInt(2));
				datosGenerales.setMnsError(cstmt.getString(3));

				cat.debug("Valor Parametro[" + datosGenerales.getValorParametro() + "]");
				cat.debug("getNumTransaccion[" + datosGenerales.getNumTransaccion() + "]");
				cat.debug("getCodError[" + datosGenerales.getCodError() + "]");
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
			// Recuperacion de valores de salida

		}  catch (GeneralException e) {
			cat.error("Ocurrió un error al obtener resultado de la transaccion",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw(e);
		}  catch (Exception e) {
			cat.error("Ocurrió un error al obtener resultado de la transaccion",e);
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
		cat.debug("Fin:getResultadoTransaccion()");
		return datosGenerales;
	}//fin getResultadoTransaccion

	/**
	 * Obtiene actuacion en central para la actuacion del abonado
	 * @param datosGenerales
	 * @return datosGenerales
	 * @throws GeneralException
	 */
	public DatosGeneralesDTO getActuacionCentral(DatosGeneralesDTO datosGenerales) 
	throws GeneralException{
		cat.debug("Inicio:getActuacionCentral()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		cat.debug("Coneccion obtenida OK");
		try {
			
			String call = getSQL("VE_servicios_venta_PG","VE_obtiene_actua_central_PR",7);

			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);

			cstmt.setString(1,datosGenerales.getCodigoActuacionAbonado());
			cat.debug("datosGenerales.getCodigoActuacionAbonado(): " + datosGenerales.getCodigoActuacionAbonado());
			cstmt.setString(2,datosGenerales.getCodigoProducto());
			cat.debug("datosGenerales.getCodigoProducto(): " + datosGenerales.getCodigoProducto());
			cstmt.setString(3,datosGenerales.getCodigoTecnologia());
			cat.debug("datosGenerales.getCodigoTecnologia(): " + datosGenerales.getCodigoTecnologia());
			cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7,java.sql.Types.NUMERIC);

			cat.debug("inicio:getActuacionCentral:Execute");
			cstmt.execute();
			cat.debug("Fin:getActuacionCentral:Execute");

			datosGenerales.setCodigoActuacionCentral(cstmt.getString(4));

			codError = cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento = cstmt.getInt(7);

			if (codError != 0) {
				cat.error("Línea, no es posible aprovicionar en red");
				throw new GeneralException(
						"Línea, no es posible aprovicionar en red", String
						.valueOf(codError), numEvento, msgError);
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			cat.error("Ocurrió un error al obtener actuacion en central para la actuacion del abonado",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw(e);
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener actuacion en central para la actuacion del abonado",e);
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
		cat.debug("Fin:getActuacionCentral()");
		return datosGenerales;
	}//fin getActuacionCentral

	/**
	 * Obtiene secuencia
	 * @param parametroEntrada
	 * @return resultado
	 * @throws GeneralException
	 */

	public DatosGeneralesDTO getSecuencia(DatosGeneralesDTO datosGenerales) 
	throws GeneralException{
		DatosGeneralesDTO resultado=new DatosGeneralesDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:getSecuencia");

			//INI-01 (AL) String call = getSQL("VE_intermediario_PG","VE_OBTIENE_SECUENCIA_PR",5);
			String call = getSQL("VE_intermediario_Quiosco_PG","VE_OBTIENE_SECUENCIA_PR",5);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setString(1,datosGenerales.getCodigoSecuencia());
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getSecuencia:execute");
			cstmt.execute();
			cat.debug("Fin:getSecuencia:execute");

			codError=cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento=cstmt.getInt(5);
			cat.debug("msgError[" + msgError + "]");

			if (codError != 0) {
				cat.error("Ocurrió un error al obtener Secuencia");
				throw new GeneralException(
						"Ocurrió un error al obtener Secuencia", String
						.valueOf(codError), numEvento, msgError);
			}else
				resultado.setSecuencia(Long.parseLong(cstmt.getString(2)));

		} catch (GeneralException e) {
			cat.error("Ocurrió un error al obtener la secuencia",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw(e);
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener la secuencia",e);
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

		cat.debug("Fin:getSecuencia");

		return resultado;
	}

	/**
	 * Obtiene lista de codigos 
	 * @param entrada
	 * @return resultado
	 * @throws GeneralException
	 */
	public DatosGeneralesDTO[] getListCodigos(DatosGeneralesDTO entrada) 
	throws GeneralException{
		cat.debug("Inicio:getListCodigos()");
		DatosGeneralesDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			//INI-01 (AL) String call = getSQL("VE_alta_cliente_PG","VE_getListGedCodigos_PR",7);
			String call = getSQL("VE_alta_cliente_Quiosco_PG","VE_getListGedCodigos_PR",7);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setString(1,entrada.getCodigoModulo());
			cstmt.setString(2,entrada.getTabla());
			cstmt.setString(3,entrada.getColumna());
			cstmt.registerOutParameter(4,OracleTypes.CURSOR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getListCodigos:execute");
			cstmt.execute();
			cat.debug("Fin:getListCodigos:execute");

			codError = cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento = cstmt.getInt(7);

			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar lista de codigos");
				throw new GeneralException(
						"Ocurrió un error al recuperar lista de codigos", String
						.valueOf(codError), numEvento, msgError);
			}else{
				cat.debug("Recuperando lista de codigos");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(4);
				while (rs.next()) {
					DatosGeneralesDTO datosgeneralesDTO = new DatosGeneralesDTO();
					datosgeneralesDTO.setCodigoValor(rs.getString(1));
					datosgeneralesDTO.setDescripcionValor(rs.getString(2));

					lista.add(datosgeneralesDTO);
				}
				rs.close();
				resultado =(DatosGeneralesDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
						lista.toArray(), DatosGeneralesDTO.class);
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			cat.error("Ocurrió un error al recuperar lista de codigos",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw(e);
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar lista de codigos",e);
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
		cat.debug("Fin:getListCodigos()");
		return resultado;
	}//fin getListCodigos

	/**
	 * Obtiene los datos del producto 
	 * @param entrada
	 * @return resultado
	 * @throws ProductDomainException
	 */
	public DatosGeneralesDTO getProducto(DatosGeneralesDTO entrada) 
	throws GeneralException{
		cat.debug("Inicio:getProducto()");
		DatosGeneralesDTO resultado = entrada;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			//INI-01 (AL) String call = getSQL("Ve_Servicios_Venta_Pg","VE_con_producto_PR",5);
			String call = getSQL("Ve_Servicios_Venta_quiosco_Pg","VE_con_producto_PR",5);

			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);

			cstmt.setInt(1,Integer.parseInt(entrada.getCodigoProducto()));
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getArticulo:execute");
			cstmt.execute();
			cat.debug("Fin:getArticulo:execute");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			cat.debug("msgError[" + msgError + "]");
			if (codError!=0){
				cat.error("Ocurrió un error al recuperar los datos del producto");
				throw new GeneralException(
						"Ocurrió un error al recuperar los datos del producto", String
						.valueOf(codError), numEvento, msgError);
			}
			else
			{
				resultado.setDescripcionProducto(cstmt.getString(2));

			}

			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			cat.error("Ocurrió un error al recuperar los datos del producto",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw(e);
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar los datos del producto",e);
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
		cat.debug("Fin:getProducto()");
		return resultado;
	}//fin getProducto

	/**
	 * Obtiene valor de columna de la tabla GA_DATOSGENER
	 * @param entrada
	 * @return resultado
	 * @throws ProductDomainException
	 */
	public DatosGeneralesDTO getDatosGener(DatosGeneralesDTO entrada) 
	throws GeneralException{
		cat.debug("Inicio:getDatosGener()");
		DatosGeneralesDTO resultado = entrada;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			//INI-01 (AL) String call = getSQL("VE_intermediario_PG","VE_getDatosGener_PR",5);
			String call = getSQL("VE_intermediario_Quiosco_PG","VE_getDatosGener_PR",5);

			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);

			cstmt.setString(1,entrada.getColumna());
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getDatosGener:execute");
			cstmt.execute();
			cat.debug("Fin:getDatosGener:execute");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);

			if (codError!=0){
				cat.error("Ocurrió un error al obtener valor de columna de la tabla GA_DATOSGENER");
				throw new GeneralException(
						"Ocurrió un error al obtener valor de columna de la tabla GA_DATOSGENER", String
						.valueOf(codError), numEvento, msgError);
			}
			else
				resultado.setValorParametro(cstmt.getString(2));
			if (cat.isDebugEnabled())
				cat.debug(" Finalizo ejecución");
		} catch (GeneralException e) {
			cat.error("Ocurrió un error al obtener valor de columna de la tabla GA_DATOSGENER",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw(e);
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener valor de columna de la tabla GA_DATOSGENER",e);
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
			} catch (SQLException e){ 
				cat.debug("SQLException", e);
			}	
		}
		cat.debug("Fin:getDatosGener");
		return resultado;
	}//fin getDatosGener

	/**
	 * Obtiene listado de paises
	 * @param N/A
	 * @return resultado
	 * @throws GeneralException
	 */
	public DatosGeneralesDTO[] getListPaises() 
	throws GeneralException{
		cat.debug("Inicio:getListPaises()");
		DatosGeneralesDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			//INI-01 (AL) String call = getSQL("VE_alta_cliente_PG","VE_getListPaises_PR",4);
			String call = getSQL("VE_alta_cliente_Quiosco_PG","VE_getListPaises_PR",4);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.registerOutParameter(1,OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getListPaises:execute");
			cstmt.execute();
			cat.debug("Fin:getListPaises:execute");

			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);

			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar listado de paises");
				throw new GeneralException(
						"Ocurrió un error al recuperar listado de paises", String
						.valueOf(codError), numEvento, msgError);
			}else{
				cat.debug("Recuperando listado de paises");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(1);
				while (rs.next()) {
					DatosGeneralesDTO datosgeneralesDTO = new DatosGeneralesDTO();
					datosgeneralesDTO.setCodigoValor(rs.getString(1));
					datosgeneralesDTO.setDescripcionValor(rs.getString(2));
					lista.add(datosgeneralesDTO);
				}
				rs.close();
				resultado =(DatosGeneralesDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
						lista.toArray(), DatosGeneralesDTO.class);
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			cat.error("Ocurrió un error al recuperar listado de paises",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw(e);
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar listado de paises",e);
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
		cat.debug("Fin:getListPaises()");
		return resultado;
	}//fin getListPaises

	/**
	 * Obtiene listado de actividades
	 * @param N/A
	 * @return resultado
	 * @throws GeneralException
	 */
	public DatosGeneralesDTO[] getListActividades() 
	throws GeneralException{
		cat.debug("Inicio:getListActividades()");
		DatosGeneralesDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			//INI-01 (AL) String call = getSQL("VE_alta_cliente_PG","VE_getListActividades_PR",4);
			String call = getSQL("VE_alta_cliente_Quiosco_PG","VE_getListActividades_PR",4);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.registerOutParameter(1,OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getListActividades:execute");
			cstmt.execute();
			cat.debug("Fin:getListActividades:execute");

			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);

			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar listado de actividades");
				throw new GeneralException(
						"Ocurrió un error al recuperar listado de actividades", String
						.valueOf(codError), numEvento, msgError);
			}else{
				cat.debug("Recuperando listado de paises");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(1);
				while (rs.next()) {
					DatosGeneralesDTO datosgeneralesDTO = new DatosGeneralesDTO();
					datosgeneralesDTO.setCodigoValor(String.valueOf(rs.getInt(1)));
					datosgeneralesDTO.setDescripcionValor(rs.getString(2));
					lista.add(datosgeneralesDTO);
				}
				rs.close();
				resultado =(DatosGeneralesDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
						lista.toArray(), DatosGeneralesDTO.class);
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			cat.error("Ocurrió un error al recuperar listado de actividades",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw(e);
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar listado de actividades",e);
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
		cat.debug("Fin:getListActividades()");
		return resultado;
	}//fin getListActividades	


	/**
	 * Obtiene valor de columna de la tabla GA_DATOSGENER
	 * @param entrada
	 * @return resultado
	 * @throws ProductDomainException
	 */
	public DatosGeneralesDTO validaIdentificador(DatosGeneralesDTO entrada) 
	throws GeneralException{
		cat.debug("Inicio:validaIdentificador()");
		DatosGeneralesDTO resultado = new DatosGeneralesDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			//INI-01 (AL) String call = getSQL("VE_intermediario_PG","VE_ValidarIdentificador_PR",7);
			String call = getSQL("VE_intermediario_Quiosco_PG","VE_ValidarIdentificador_PR",7);

			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);

			cstmt.setString(1,entrada.getCodigoModulo());
			cat.debug("entrada.getCodigoModulo() ["+entrada.getCodigoModulo()+"]");
			cstmt.setString(2,entrada.getCorrelativo());
			cat.debug("entrada.getCorrelativo() ["+entrada.getCorrelativo()+"]");
			cstmt.setString(3,entrada.getNumeroIdentificador());
			cat.debug("entrada.getNumeroIdentificador() ["+entrada.getNumeroIdentificador()+"]");
			cstmt.setString(4,entrada.getTipoIdentificador());
			cat.debug("entrada.getTipoIdentificador() ["+entrada.getTipoIdentificador()+"]");
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);

			cat.debug("Inicio:validaIdentificador:execute");
			cstmt.execute();
			cat.debug("Fin:validaIdentificador:execute");

			codError = cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento = cstmt.getInt(7);

			if (codError!=0){
				resultado.setBResultadoValidacion(false);
				cat.debug("entrada.getTipoIdentificador() ["+resultado.isBResultadoValidacion()+"]");
			}
			else
				resultado.setBResultadoValidacion(true);
			cat.debug("entrada.getTipoIdentificador() ["+resultado.isBResultadoValidacion()+"]");
			if (cat.isDebugEnabled())
				cat.debug(" Finalizo ejecución");
		} catch (Exception e) {
			cat.error("Ocurrió un error al validar el identificador",e);
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
			} catch (SQLException e){ 
				cat.debug("SQLException", e);
			}	
		}
		cat.debug("Fin:validaIdentificador");
		return resultado;
	}//fin validaIdentificador



	private String getSQLgetInformacionBodegaArticuloSerie(){
		StringBuffer call= new StringBuffer();
		call.append("BEGIN" +
				"	  GE_CONS_CATALOGO_PORTAB_PG.GE_REC_DATOS_SERIE_PR ( ?, ?, ?, ?, ?, ?, ?, ? );" +
		"END; ");

		return call.toString();			
	}

	/**
	 * Obtiene getinformacionBodegaArticuloSerie
	 * @param N/A
	 * @return resultado
	 * @throws GeneralException
	 */
	public WsNumeroSerieOutDTO getInformacionBodegaArticuloSerie(WsNumeroSerieInDTO wsNumeroSerieInDTO) throws GeneralException{
		cat.debug("Inicio:informacionBodegaArticuloSerie()");
		WsNumeroSerieOutDTO resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			resultado = new WsNumeroSerieOutDTO();
			String call = getSQLgetInformacionBodegaArticuloSerie();

			/*EV_NUM_SERIE VARCHAR2(200);
			  EN_COD_VENDEDOR NUMBER;
			  SN_COD_ARTICULO NUMBER;
			  SV_DES_ARTICULO VARCHAR2(200);
			  SN_COD_BODEGA NUMBER;
			  SN_COD_ERROR NUMBER;
			  SV_DES_ERROR VARCHAR2(200);
			  SN_NUM_EVENTO NUMBER;*/
			cat.debug("Número Serie ["+wsNumeroSerieInDTO.getNumSerie()+"]");
			cat.debug("Código Vendedor ["+wsNumeroSerieInDTO.getCodVendedor()+"]");

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setString(1,wsNumeroSerieInDTO.getNumSerie());
			cstmt.setInt(2,wsNumeroSerieInDTO.getCodVendedor());
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);

			cat.debug("Inicio:informacionBodegaArticuloSerie:execute");
			cstmt.execute();
			cat.debug("Fin:informacionBodegaArticuloSerie:execute");

			codError = cstmt.getInt(6);
			msgError = cstmt.getString(7);
			numEvento = cstmt.getInt(8);

			if (codError != 0) {
				cat.error("Ocurrió un error al informacionBodegaArticuloSerie");
				resultado.setMensajseError(msgError);
				resultado.setCodError(""+codError);
				throw new GeneralException(
						"Ocurrió un error al informacionBodegaArticuloSerie", String
						.valueOf(codError), numEvento, msgError);
			}else{
				cat.debug("Recuperando informacionBodegaArticuloSerie");
				resultado.setCodArticulo(cstmt.getLong(3));
				resultado.setDesArticulo(cstmt.getString(4));
				resultado.setCodBodega(cstmt.getLong(5));
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			cat.error("Ocurrió un error al informacionBodegaArticuloSerie",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw(e);
		} catch (Exception e) {
			cat.error("Ocurrió un error al informacionBodegaArticuloSerie",e);
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
		cat.debug("Fin:informacionBodegaArticuloSerie()");
		return resultado;
	}//fin getListActividades	


	public OcupacionDTO[] getListaOcupaciones() 
	throws GeneralException{
		cat.debug("Inicio:getListOcupaciones()");
		OcupacionDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {

			String call = getSQL("GE_CONS_CATALOGO_PORTAB_PG","ge_consulta_ocupaciones_pr",4);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.registerOutParameter(1,OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getListOcupaciones:execute");
			cstmt.execute();
			cat.debug("Fin:getListOcupaciones:execute");

			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);

			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar listado de ocupaciones");
				throw new GeneralException(
						"Ocurrió un error al recuperar listado de ocupaciones", String
						.valueOf(codError), numEvento, msgError);
			}else{
				cat.debug("Recuperando listado de ocupaciones");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(1);
				while (rs.next()) {
					OcupacionDTO ocupacionDTO= new OcupacionDTO();
					ocupacionDTO.setCodOcupacion(String.valueOf(rs.getInt(1)));
					ocupacionDTO.setDesOcupacion(rs.getString(2));
					lista.add(ocupacionDTO);
				}
				rs.close();
				resultado =(OcupacionDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
						lista.toArray(), OcupacionDTO.class);
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			cat.error("Ocurrió un error al recuperar listado de ocupaciones",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw(e);
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar listado de ocupaciones",e);
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
		cat.debug("Fin:getListActividades()");
		return resultado;
	}

	public EstadoCivilDTO[] getListaEstadoCivil() throws GeneralException{
		cat.debug("Inicio:getListOcupaciones()");
		EstadoCivilDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {

			String call = getSQL("GE_CONS_CATALOGO_PORTAB_PG","ge_lis_estado_civil",4);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.registerOutParameter(1,OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getListaEstadoCivil:execute");
			cstmt.execute();
			cat.debug("Fin:getListaEstadoCivil:execute");

			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);

			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar lista de Estado Civil");
				throw new GeneralException(
						"Ocurrió un error al recuperar lista de Estado Civil", String
						.valueOf(codError), numEvento, msgError);
			}else{
				cat.debug("Recuperando lista Estado Civil");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(1);
				while (rs.next()) {
					EstadoCivilDTO estadoCivilDTO= new EstadoCivilDTO();
					estadoCivilDTO.setCodEstado(rs.getString(1));
					estadoCivilDTO.setDesEstado(rs.getString(2));
					lista.add(estadoCivilDTO);
				}
				rs.close();
				resultado =(EstadoCivilDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
						lista.toArray(), EstadoCivilDTO.class);
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			cat.error("Ocurrió un error al recuperar lista de Estado Civil",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw(e);
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar lista de Estado Civil",e);
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
		cat.debug("Fin:getListaEstadoCivil()");
		return resultado;
	}

	public EstadoDTO[] getListaEstados() throws GeneralException{
		cat.debug("Inicio:getListaEstados()");
		EstadoDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {

			String call = getSQL("GE_CONS_CATALOGO_PORTAB_PG","ge_lis_estados",4);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.registerOutParameter(1,OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getListaEstados:execute");
			cstmt.execute();
			cat.debug("Fin:getListaEstados:execute");

			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);

			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar lista de Estados");
				throw new GeneralException(
						"Ocurrió un error al recuperar lista de Estados", String
						.valueOf(codError), numEvento, msgError);
			}else{
				cat.debug("Recuperando lista Estados");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(1);
				while (rs.next()) {
					EstadoDTO estadosDTO= new EstadoDTO();
					estadosDTO.setCodigoEstado(rs.getString(1));
					estadosDTO.setDescripcionEstado(rs.getString(2));
					lista.add(estadosDTO);
				}
				rs.close();
				resultado =(EstadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
						lista.toArray(), EstadoDTO.class);
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			cat.error("Ocurrió un error al recuperar lista de Estados",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw(e);
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar lista de Estados",e);
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
		cat.debug("variable retorno estado: "+ resultado[1].getCodigoEstado());
		cat.debug("variable retorno descripcion estado: "+ resultado[1].getDescripcionEstado());


		cat.debug("Fin:getListaEstados()");
		return resultado;
	}

}//fin CLASS DatosGeneralesDAO