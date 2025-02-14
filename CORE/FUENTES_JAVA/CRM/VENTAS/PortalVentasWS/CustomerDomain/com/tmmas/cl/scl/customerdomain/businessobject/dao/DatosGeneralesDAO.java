/**
 * Copyright Â© 2007 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
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
package com.tmmas.cl.scl.customerdomain.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Category;

import weblogic.iiop.CodeSet;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.NumeroIdentificacionDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.TarjetaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.ProductDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.DatosContrato;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.DatosGeneralesDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.DatosLineaContratoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.DatosPlanAdicionalLineaDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.DatosServSupLineaDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.helper.Global;

public class DatosGeneralesDAO extends ConnectionDAO {

	private static Category cat = Category.getInstance(DatosGeneralesDAO.class);

	Global global = Global.getInstance();
	
	private Connection getConection() throws CustomerDomainException
	{
		Connection conn = null;
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
		} catch (Exception e1) {
			conn = null;
			cat.error(" No se pudo obtener una conexión ", e1);
			throw new CustomerDomainException("No se pudo obtener una conexión", e1);
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
	 * @throws CustomerDomainException
	 */
	
	public DatosGeneralesDTO getValorParametro(DatosGeneralesDTO datosGenerales) 
		throws CustomerDomainException
	{
		cat.debug("Inicio:getValorParametro()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		cat.debug("Coneccion obtenida OK");
		try {
			String call = getSQL("VE_intermediario_PG","VE_obtiene_valor_parametro_PR",7);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,datosGenerales.getCodigoParametro());
			cstmt.setString(2,datosGenerales.getCodigoModulo());
			cstmt.setInt(3,Integer.parseInt(datosGenerales.getCodigoProducto().trim()));
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
				throw new CustomerDomainException(
						"Ocurrió un error al consultar los Datos Generales", String
								.valueOf(codError), numEvento, msgError);
			}
			
			cat.debug("Valor Parametro[" + datosGenerales.getValorParametro() + "]");
			
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
			// Recuperacion de valores de salida

		} catch (Exception e) {
			cat.error("Ocurrió un error al consultar los Datos Generales",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
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
	 * @throws CustomerDomainException
	 */
	
	public String getCodigoOperadora() 
		throws CustomerDomainException
	{
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
			String call = getSQL("VE_intermediario_PG","VE_ObtieneOperadora_PR",4);
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
				cat.error("Ocurrió un error al obener codigo operadora");
				throw new CustomerDomainException(
						"Ocurrió un error al obener codigo operadora", String
								.valueOf(codError), numEvento, msgError);
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}

		} catch (Exception e) {
			cat.error("Ocurrió un error al obener codigo operadora",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
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
	 * @throws CustomerDomainException
	 */
	
	public String getDescripcionOperadora() 
		throws CustomerDomainException
	{
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
			String call = getSQL("VE_intermediario_PG","VE_ObtieneOperadora_PR",5);
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
				throw new CustomerDomainException(
						"Ocurrió un error al obener codigo operadora", String
								.valueOf(codError), numEvento, msgError);
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}

		} catch (Exception e) {
			cat.error("Ocurrió un error al obener codigo operadora",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
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
	 * @throws CustomerDomainException
	 */
	
	public DatosGeneralesDTO getResultadoTransaccion(DatosGeneralesDTO datosGenerales)	
		throws CustomerDomainException
	{
		cat.debug("Inicio:getResultadoTransaccion()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		cat.debug("Coneccion obtenida OK");
		try {
			String call = getSQL("VE_intermediario_PG","VE_obtiene_transaccion_PR",4);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,datosGenerales.getNumTransaccion());
			cstmt.registerOutParameter(2,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
			
			cat.debug("inicio:Execute");
			cstmt.execute();
			cat.debug("Fin:Execute");

			datosGenerales.setNumTransaccion(datosGenerales.getNumTransaccion());
			datosGenerales.setCodError(cstmt.getInt(2));
			datosGenerales.setMnsError(cstmt.getString(3));

			cat.debug("Valor Parametro[" + datosGenerales.getValorParametro() + "]");
			cat.debug("getNumTransaccion[" + datosGenerales.getNumTransaccion() + "]");
			cat.debug("getCodError[" + datosGenerales.getCodError() + "]");
			
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
			// Recuperacion de valores de salida

		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener resultado de la transaccion",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
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
	 * @throws CustomerDomainException
	 */
	public DatosGeneralesDTO getActuacionCentral(DatosGeneralesDTO datosGenerales) 
		throws CustomerDomainException
	{
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
				throw new CustomerDomainException(
						"Línea, no es posible aprovicionar en red", String
								.valueOf(codError), numEvento, msgError);
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener actuacion en central para la actuacion del abonado",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
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
	 * @throws CustomerDomainException
	 */
	
	public DatosGeneralesDTO getSecuencia(DatosGeneralesDTO datosGenerales) 
		throws CustomerDomainException
	{
		DatosGeneralesDTO resultado=new DatosGeneralesDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:getSecuencia");
			
			String call = getSQL("VE_intermediario_PG","VE_OBTIENE_SECUENCIA_PR",5);

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
				throw new CustomerDomainException(
						"Ocurrió un error al obtener Secuencia", String
								.valueOf(codError), numEvento, msgError);
			}else
				resultado.setSecuencia(Long.parseLong(cstmt.getString(2)));
		
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener la secuencia",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
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
	 * @throws CustomerDomainException
	 */
	public DatosGeneralesDTO[] getListCodigos(DatosGeneralesDTO entrada) 
		throws CustomerDomainException
	{
		cat.debug("Inicio:getListCodigos()");
		DatosGeneralesDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		ResultSet rs = null;
		try {
			String call = getSQL("VE_alta_cliente_PG","VE_getListGedCodigos_PR",7);

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
				throw new CustomerDomainException(
						"Ocurrió un error al recuperar lista de codigos", String
								.valueOf(codError), numEvento, msgError);
			}else{
				cat.debug("Recuperando lista de codigos");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(4);
				while (rs.next()) {
					DatosGeneralesDTO datosgeneralesDTO = new DatosGeneralesDTO();
					datosgeneralesDTO.setCodigoValor(rs.getString(1));
					datosgeneralesDTO.setDescripcionValor(rs.getString(2));
					
					lista.add(datosgeneralesDTO);
				}				
				resultado =(DatosGeneralesDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), DatosGeneralesDTO.class);
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar lista de codigos",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
		 	if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (rs!=null)
					rs.close();
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
		throws CustomerDomainException
	{
		cat.debug("Inicio:getProducto()");
		DatosGeneralesDTO resultado = entrada;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			String call = getSQL("Ve_Servicios_Venta_Pg","VE_con_producto_PR",5);
			
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
				throw new CustomerDomainException(
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
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar los datos del producto",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
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
		throws CustomerDomainException
	{
		cat.debug("Inicio:getDatosGener()");
		DatosGeneralesDTO resultado = entrada;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			String call = getSQL("VE_intermediario_PG","VE_getDatosGener_PR",5);
			
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
				throw new CustomerDomainException(
						"Ocurrió un error al obtener valor de columna de la tabla GA_DATOSGENER", String
								.valueOf(codError), numEvento, msgError);
			}
			else
				resultado.setValorParametro(cstmt.getString(2));
			if (cat.isDebugEnabled())
				cat.debug(" Finalizo ejecución");
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener valor de columna de la tabla GA_DATOSGENER",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
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
	 * @throws CustomerDomainException
	 */
	public DatosGeneralesDTO[] getListPaises() 
		throws CustomerDomainException
	{
		cat.debug("Inicio:getListPaises()");
		DatosGeneralesDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		ResultSet rs = null;
		try {
			String call = getSQL("VE_alta_cliente_PG","VE_getListPaises_PR",4);

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
				throw new CustomerDomainException(
						"Ocurrió un error al recuperar listado de paises", String
								.valueOf(codError), numEvento, msgError);
			}else{
				cat.debug("Recuperando listado de paises");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(1);
				while (rs.next()) {
					DatosGeneralesDTO datosgeneralesDTO = new DatosGeneralesDTO();
					datosgeneralesDTO.setCodigoValor(rs.getString(1));
					datosgeneralesDTO.setDescripcionValor(rs.getString(2));
					lista.add(datosgeneralesDTO);
				}				
				resultado =(DatosGeneralesDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), DatosGeneralesDTO.class);
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar listado de paises",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
		 	if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (rs!=null)
					rs.close();
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
	 * @throws CustomerDomainException
	 */
	public DatosGeneralesDTO[] getListActividades() 
		throws CustomerDomainException
	{
		cat.debug("Inicio:getListActividades()");
		DatosGeneralesDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		ResultSet rs = null;
		try {
			String call = getSQL("VE_alta_cliente_PG","VE_getListActividades_PR",4);

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
				throw new CustomerDomainException(
						"Ocurrió un error al recuperar listado de actividades", String
								.valueOf(codError), numEvento, msgError);
			}else{
				cat.debug("Recuperando listado de paises");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(1);
				while (rs.next()) {
					DatosGeneralesDTO datosgeneralesDTO = new DatosGeneralesDTO();
					datosgeneralesDTO.setCodigoValor(String.valueOf(rs.getInt(1)));
					datosgeneralesDTO.setDescripcionValor(rs.getString(2));
					lista.add(datosgeneralesDTO);
				}				
				resultado =(DatosGeneralesDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), DatosGeneralesDTO.class);
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar listado de actividades",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
		 	if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (rs!=null)
					rs.close();
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
	
	
	public NumeroIdentificacionDTO validarIdentificador(NumeroIdentificacionDTO entrada)   
		throws CustomerDomainException
	{
		cat.debug("Inicio:validarIdentificador()");
		NumeroIdentificacionDTO resultado = entrada;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			String call = getSQL("VE_intermediario_PG","VE_ValidarIdentificador_PR",8);
			
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);

			cstmt.setString(1,entrada.getCodigoModulo());
			cat.debug("entrada.getCodigoModulo(): " + entrada.getCodigoModulo());
			cstmt.setLong(2,entrada.getCorrelativo().longValue());
			cat.debug("entrada.getCorrelativo(): " + entrada.getCorrelativo());
			cstmt.setString(3,entrada.getNumIdentif());
			cat.debug("entrada.getNumIdentif(): " + entrada.getNumIdentif());
			cstmt.setString(4,entrada.getTipoIdentif());			
			cat.debug("entrada.getTipoIdentif(): " + entrada.getTipoIdentif());
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getDatosGener:execute");
			cstmt.execute();
			cat.debug("Fin:getDatosGener:execute");
			
			codError = cstmt.getInt(6);
			msgError = cstmt.getString(7);
			numEvento = cstmt.getInt(8);
			
			if (codError!=0){
				cat.error("Ocurrió un error validar el numero de identificacion");
				throw new CustomerDomainException("Ocurrió un error validar el numero de identificacion", String
								.valueOf(codError), numEvento, msgError);
			}
			else
				resultado.setFormatoNIT(cstmt.getString(5));
			if (cat.isDebugEnabled())
				cat.debug(" Finalizo ejecución");
		} catch (Exception e) {
			cat.error("Ocurrió un error validar el numero de identificacion",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException ) throw (CustomerDomainException) e;
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
		cat.debug("Fin:validarIdentificador");
		return resultado;
	}//fin getDatosGener
	
	public TarjetaDTO validarTarjeta(TarjetaDTO entrada) throws CustomerDomainException {
		cat.debug("Inicio:validarTarjeta()");
		TarjetaDTO r = entrada;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		final String nombrePackage = "CO_SERVICIOS_COBRANZA_PG".toUpperCase();
		final String nombrePL = "CO_ValidaTarjeta_PR".toUpperCase();
		final int cantidadParametros = 5;
		try {
			String call = getSQL(nombrePackage, nombrePL, cantidadParametros);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);

			cstmt.setString(1, entrada.getTipoTarjeta());
			cat.debug("entrada.getTipoTarjeta(): " + entrada.getTipoTarjeta());
			cstmt.setString(2, entrada.getNumTarjeta());
			cat.debug("entrada.getNumTarjeta(): " + entrada.getNumTarjeta());
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(cantidadParametros, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getDatosGener:execute");
			cstmt.execute();
			cat.debug("Fin:getDatosGener:execute");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(cantidadParametros);

			if (codError != 0) {
				cat.error("Ocurrió un error validar el numero de tarjeta");
				throw new CustomerDomainException("Ocurrió un error validar el numero de tarjeta", String
						.valueOf(codError), numEvento, msgError);
			}
			if (cat.isDebugEnabled())
				cat.debug(" Finalizo ejecución");
		}
		catch (Exception e) {
			cat.error("Ocurrió un error validar el numero de identificacion", e);
			if (cat.isDebugEnabled()) {
				cat.error("Codigo de Error[" + codError + "]");
				cat.error("Mensaje de Error[" + msgError + "]");
				cat.error("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally {
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:validarTarjeta");
		return r;
	}//fin validarTarjeta
	
	//Inicio P-CSR-11002 JLGN 27-05-2011
	public DatosContrato datoslinea(DatosContrato entrada) throws CustomerDomainException {
		cat.debug("Inicio:datoslinea()");
		DatosContrato r = entrada;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		Connection connFijo = null;
		conn = getConection();
		connFijo = getConection();
		CallableStatement cstmt = null;
		CallableStatement cstmtFijo = null;
		final String nombrePackage = "VE_parametros_comerciales_PG".toUpperCase();
		final String nombrePL = "ve_datos_linea_pr".toUpperCase();
		final int cantidadParametros = 13;
		final String nombrePackageFijo = "VE_parametros_comerciales_PG".toUpperCase();
		final String nombrePLFijo = "ve_datos_linea_fija_pr".toUpperCase();
		final int cantidadParametrosFijo = 9;
		try {
			String call = getSQL(nombrePackage, nombrePL, cantidadParametros);
			String callFija = getSQL(nombrePackageFijo, nombrePLFijo, cantidadParametrosFijo);
			cat.debug("sql[" + call + "]");
			cat.debug("sql[" + callFija + "]");
			cstmt = conn.prepareCall(call);
			cstmtFijo = connFijo.prepareCall(callFija);

			for(int i=0; i < r.getLineascontrato().length;i++){
				//Inicio P-CSR-11002 30-09-2011 JLGN  
				if(!entrada.getLineascontrato()[i].getTipRed().trim().equals("F")){
					//No es Fija
					cat.debug("No es Fija");
					cstmt.setLong(1, Long.parseLong(entrada.getLineascontrato()[i].getNumAbonado()));
					cat.debug("NumAbonado: " + entrada.getLineascontrato()[i].getNumAbonado());
					cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);//num_serie
					cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);//num_imei
					cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);//des_PT
					//cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);//cargo_PT
					cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);//cargo_PT
					cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);//des_terminal
					cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);//mod_venta
					cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);//num_meses
					cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);//procedencia
					cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);//codPT
					cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);
					cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(13, java.sql.Types.NUMERIC);
		
					cat.debug("Inicio:datoslinea:execute");
					cstmt.execute();
					cat.debug("Fin:datoslinea:execute");
		
					codError = cstmt.getInt(11);
					msgError = cstmt.getString(12);
					numEvento = cstmt.getInt(13);
		
					if (codError != 0) {
						cat.error("Ocurrio un error al Obtener datos de la Linea");
						throw new CustomerDomainException("Ocurrio un error al Obtener datos de la Linea", String
								.valueOf(codError), numEvento, msgError);
					}
					
					r.getLineascontrato()[i].setNumSerie(cstmt.getString(2));
					r.getLineascontrato()[i].setNumImei(cstmt.getString(3));
					r.getLineascontrato()[i].setPlanTarif(cstmt.getString(4));
					r.getLineascontrato()[i].setCargoPT("¢ "+cstmt.getString(5));
					
					r.getLineascontrato()[i].setDesTerminal(cstmt.getString(6));
					
					if(cstmt.getString(9).toUpperCase().equals("E")){ //Procedencia del Equipo
						r.getLineascontrato()[i].setTipTerminal("APORTADO");
					}else{
						/*if(String.valueOf(cstmt.getInt(7)).equals("1")){ //ModVenta 1 = contado
							r.getLineascontrato()[i].setTipTerminal("SUBSIDIO");
						}else{
							r.getLineascontrato()[i].setTipTerminal("FINANCIADO");
						}*/
						if(String.valueOf(cstmt.getInt(7)).equals("7")){ //ModVenta 7 = CREDITO
							r.getLineascontrato()[i].setTipTerminal("FINANCIADO");
						}else{							
							r.getLineascontrato()[i].setTipTerminal("SUBSIDIO");
						}
					}
					r.setNumMesesContrato(String.valueOf(cstmt.getInt(8)));
					r.getLineascontrato()[i].setCodPT(cstmt.getString(10));
				}else{
					//Es Fija
					cat.debug("Es Fija");
					cstmtFijo.setLong(1, Long.parseLong(entrada.getLineascontrato()[i].getNumAbonado()));
					cat.debug("NumAbonado: " + entrada.getLineascontrato()[i].getNumAbonado());
					cstmtFijo.registerOutParameter(2, java.sql.Types.VARCHAR);//des_PT
					cstmtFijo.registerOutParameter(3, java.sql.Types.VARCHAR);//cargo_PT
					cstmtFijo.registerOutParameter(4, java.sql.Types.NUMERIC);//mod_venta
					cstmtFijo.registerOutParameter(5, java.sql.Types.NUMERIC);//num_meses
					cstmtFijo.registerOutParameter(6, java.sql.Types.VARCHAR);//codPT
					cstmtFijo.registerOutParameter(7, java.sql.Types.NUMERIC);
					cstmtFijo.registerOutParameter(8, java.sql.Types.VARCHAR);
					cstmtFijo.registerOutParameter(9, java.sql.Types.NUMERIC);
		
					cat.debug("Inicio:datoslinea:execute");
					cstmtFijo.execute();
					cat.debug("Fin:datoslinea:execute");
		
					codError = cstmtFijo.getInt(7);
					msgError = cstmtFijo.getString(8);
					numEvento = cstmtFijo.getInt(9);
		
					if (codError != 0) {
						cat.error("Ocurrio un error al Obtener datos de la Linea");
						throw new CustomerDomainException("Ocurrio un error al Obtener datos de la Linea", String
								.valueOf(codError), numEvento, msgError);
					}
					
					r.getLineascontrato()[i].setNumSerie("");
					r.getLineascontrato()[i].setNumImei("");
					r.getLineascontrato()[i].setPlanTarif(cstmtFijo.getString(2));
					r.getLineascontrato()[i].setCargoPT("¢ "+cstmtFijo.getString(3));					
					r.getLineascontrato()[i].setDesTerminal("FIJA");
					r.getLineascontrato()[i].setTipTerminal("");
					r.setNumMesesContrato(String.valueOf(cstmtFijo.getInt(5)));
					r.getLineascontrato()[i].setCodPT(cstmtFijo.getString(6));
				}	
				//Fin P-CSR-11002 30-09-2011 JLGN 
			}	
		}
		catch (Exception e) {
			cat.error("Ocurrió un error al Obtener datos de la Linea", e);
			if (cat.isDebugEnabled()) {
				cat.error("Codigo de Error[" + codError + "]");
				cat.error("Mensaje de Error[" + msgError + "]");
				cat.error("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally {
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				cat.debug("SQLException", e);
			}
			
			try {
				if (cstmtFijo != null)
					cstmtFijo.close();
				if (!connFijo.isClosed()) {  
					connFijo.close();
				}
			}
			catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:datoslinea");
		return r;
	}//fin datoslinea
	//Fin P-CSR-11002 JLGN 27-05-2011
	
	//Inicio P-CSR-11002 JLGN 09-06-2011
	public DatosContrato datosPAporLinea(DatosContrato entrada) throws CustomerDomainException {
		cat.debug("Inicio:datosPAporLinea()");
		DatosContrato r = entrada;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		ResultSet rs = null;
		final String nombrePackage = "VE_parametros_comerciales_PG".toUpperCase();
		final String nombrePL = "ve_pa_por_linea_pr".toUpperCase();
		final int cantidadParametros = 6;
		try {
			
			String call = getSQL(nombrePackage, nombrePL, cantidadParametros);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cat.debug("Cantidad de Lineas Contratadas["+entrada.getLineascontrato().length+"]");

			for(int i=0; i < entrada.getLineascontrato().length; i++){
				cat.debug("Lineas Nº["+(i+1)+"]");
				cstmt.setLong(1, Long.parseLong(entrada.getLineascontrato()[i].getNumAbonado()));
				cat.debug("getNumAbonado(): " + entrada.getLineascontrato()[i].getNumAbonado());
				cstmt.setString(2, entrada.getLineascontrato()[i].getCodPT());
				cat.debug("getPT(): " + entrada.getLineascontrato()[i].getCodPT());
				cstmt.registerOutParameter(3, OracleTypes.CURSOR);
				cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
	
				cat.debug("Inicio:datosPAporLinea:execute");
				cstmt.execute();
				cat.debug("Fin:datosPAporLinea:execute");
	
				codError = cstmt.getInt(4);
				msgError = cstmt.getString(5);
				numEvento = cstmt.getInt(6);
				
				if (codError != 0) {
					if(codError == 1){
						cat.error("Codigo de Error[" + codError + "]");
						cat.error("Mensaje de Error[" + msgError + "]");
						cat.error("Numero de Evento[" + numEvento + "]");
						
						DatosPlanAdicionalLineaDTO plaAdi[] = new DatosPlanAdicionalLineaDTO[0];
						r.getLineascontrato()[i].setPlanesAdicionales(plaAdi);						
					}else{					
						cat.error("Ocurrio un error al Obtener PA de la Linea");
						throw new CustomerDomainException(
								"Ocurrio un error al Obtener PA de la Linea", String
										.valueOf(codError), numEvento, msgError);
					}	
				}else{
					cat.debug("Recuperando lista de PA");
					ArrayList lista = new ArrayList();
					rs = (ResultSet) cstmt.getObject(3);
					while (rs.next()) {
						DatosPlanAdicionalLineaDTO pa = new DatosPlanAdicionalLineaDTO();
						pa.setNomPlanAdi(rs.getString(1));
						//Inicio P-CSR-11002 JLGN 26-10-2011
						if(rs.getString(3).equals("001")){
							//Cod_Moneda es Colon
							pa.setValPlanAdi("¢ " + rs.getString(2));							
						}else{
							//Cod_Moneda es Dolar
							pa.setValPlanAdi("$ " + rs.getString(2));
						}
						//Fin P-CSR-11002 JLGN 26-10-2011											
						lista.add(pa);
					}				
					r.getLineascontrato()[i].setPlanesAdicionales((DatosPlanAdicionalLineaDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
							lista.toArray(), DatosPlanAdicionalLineaDTO.class));
				}						
			}			
		}
		catch (Exception e) {
			cat.error("Ocurrió un error al Obtener PA de la Linea", e);
			if (cat.isDebugEnabled()) {
				cat.error("Codigo de Error[" + codError + "]");
				cat.error("Mensaje de Error[" + msgError + "]");
				cat.error("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally {
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:datosPAporLinea");
		return r;
	}//fin datosPAporLinea
	//Fin P-CSR-11002 JLGN 09-06-2011
	
	//Inicio P-CSR-11002 JLGN 10-06-2011
	public DatosContrato datosSSporLinea(DatosContrato entrada) throws CustomerDomainException {
		cat.debug("Inicio:datosSSporLinea()");
		DatosContrato r = entrada;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		ResultSet rs = null;
		final String nombrePackage = "VE_parametros_comerciales_PG".toUpperCase();
		final String nombrePL = "ve_ss_por_linea_pr".toUpperCase();
		final int cantidadParametros = 6;
		try {
			
			String call = getSQL(nombrePackage, nombrePL, cantidadParametros);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cat.debug("Cantidad de Lineas Contratadas["+entrada.getLineascontrato().length+"]");

			for(int i=0; i < entrada.getLineascontrato().length; i++){
				cat.debug("Lineas NÂº["+(i+1)+"]");
				cstmt.setLong(1, Long.parseLong(entrada.getLineascontrato()[i].getNumAbonado()));
				cat.debug("getNumAbonado(): " + entrada.getLineascontrato()[i].getNumAbonado());
				cstmt.setString(2, entrada.getLineascontrato()[i].getCodPT());
				cat.debug("getPT(): " + entrada.getLineascontrato()[i].getCodPT());
				cstmt.registerOutParameter(3, OracleTypes.CURSOR);
				cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
	
				cat.debug("Inicio:datosSSporLinea:execute");
				cstmt.execute();
				cat.debug("Fin:datosSSporLinea:execute");
	
				codError = cstmt.getInt(4);
				msgError = cstmt.getString(5);
				numEvento = cstmt.getInt(6);
				
				if (codError != 0) {
					if(codError == 1){
						cat.error("Codigo de Error[" + codError + "]");
						cat.error("Mensaje de Error[" + msgError + "]");
						cat.error("Numero de Evento[" + numEvento + "]");
						
						DatosServSupLineaDTO servSup[] = new DatosServSupLineaDTO[0];
						r.getLineascontrato()[i].setServSupl(servSup);									
					}else{					
						cat.error("Ocurrió un error al Obtener SS de la Linea");
						throw new CustomerDomainException(
								"Ocurrió un error al Obtener SS de la Linea", String
										.valueOf(codError), numEvento, msgError);
					}	
				}else{
					cat.debug("Recuperando lista de SS");
					ArrayList lista = new ArrayList();
					rs = (ResultSet) cstmt.getObject(3);
					while (rs.next()) {
						DatosServSupLineaDTO ss = new DatosServSupLineaDTO();
						ss.setNomSS(rs.getString(1));
						ss.setValSS("¢ " + rs.getString(2));					
						lista.add(ss);
					}				
					r.getLineascontrato()[i].setServSupl((DatosServSupLineaDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
							lista.toArray(), DatosServSupLineaDTO.class));
				}						
			}			
		}
		catch (Exception e) {
			cat.error("Ocurrió un error al Obtener SS de la Linea", e);
			if (cat.isDebugEnabled()) {
				cat.error("Codigo de Error[" + codError + "]");
				cat.error("Mensaje de Error[" + msgError + "]");
				cat.error("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally {
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:datosSSporLinea");
		return r;
	}//fin datosSSporLinea
	//Fin P-CSR-11002 JLGN 09-06-2011
	
	//Inicio P-CSR-11002 JLGN 26-07-2011
	public DatosContrato precioTerminal(DatosContrato entrada) throws CustomerDomainException {
		cat.debug("Inicio:precioTerminal()");
		DatosContrato r = entrada;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		final String nombrePackage = "VE_parametros_comerciales_PG".toUpperCase();
		final String nombrePL = "ve_precio_terminal_pr".toUpperCase();
		final int cantidadParametros = 5;
		try {
			String call = getSQL(nombrePackage, nombrePL, cantidadParametros);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);

			for(int i=0; i < r.getLineascontrato().length;i++){
				//P-CSR-11002 JLGN 26-07-2011 Precio de Terminal se muestra solo para los Subsidios	
				if(r.getLineascontrato()[i].getTipTerminal().trim().equals(("SUBSIDIO"))){ 
					cstmt.setLong(1, Long.parseLong(entrada.getLineascontrato()[i].getNumAbonado()));
					cat.debug("NumAbonado: " + entrada.getLineascontrato()[i].getNumAbonado());
					cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
					cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
		
					cat.debug("Inicio:precioTerminal:execute");
					cstmt.execute();
					cat.debug("Fin:precioTerminal:execute");
		
					codError = cstmt.getInt(3);
					msgError = cstmt.getString(4);
					numEvento = cstmt.getInt(5);
		
					if (codError != 0) {
						cat.error("Ocurrio un error al Obtener Precio del Terminal");
						throw new CustomerDomainException("Ocurrio un error al Obtener Precio del Terminal", String
								.valueOf(codError), numEvento, msgError);
					}				
					r.getLineascontrato()[i].setTipTerminal(r.getLineascontrato()[i].getTipTerminal()+" (CC "+cstmt.getString(2)+")");
					r.getLineascontrato()[i].setPrecioTerminal("¢ "+cstmt.getString(2));
				}else{
					r.getLineascontrato()[i].setPrecioTerminal("");
				}	
			}	
		}
		catch (Exception e) {
			cat.error("Ocurrio un error al Obtener Precio del Terminal", e);
			if (cat.isDebugEnabled()) {
				cat.error("Codigo de Error[" + codError + "]");
				cat.error("Mensaje de Error[" + msgError + "]");
				cat.error("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally {
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:precioTerminal");
		return r;
	}//fin datoslinea
	//Fin P-CSR-11002 JLGN 26-07-2011
	
	//Inicio P-CSR-11002 JLGN 18-10-2011
	public String descripcionArticulo(String codArticulo) throws CustomerDomainException {
		cat.debug("Inicio:descripcionArticulo()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		final String nombrePackage = "VE_intermediario_PG".toUpperCase();
		final String nombrePL = "VE_desArticulo_PR".toUpperCase();
		final int cantidadParametros = 5;
		String resultado = null;
		try {
			String call = getSQL(nombrePackage, nombrePL, cantidadParametros);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);

			cstmt.setLong(1, Long.parseLong(codArticulo));
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cat.debug("Inicio:descripcionArticulo:execute");
			cstmt.execute();
			cat.debug("Fin:descripcionArticulo:execute");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
		
			if (codError != 0) {
				cat.error("Ocurrio un error al Obtener Descripcion del Articulo");
				throw new CustomerDomainException("Ocurrio un error al Obtener Descripcion del Articulo", String
						.valueOf(codError), numEvento, msgError);
			}else{
				resultado = cstmt.getString(2);
			}		
		}
		catch (Exception e) {
			cat.error("Ocurrio un error al Obtener Descripcion del Articulo", e);
			if (cat.isDebugEnabled()) {
				cat.error("Codigo de Error[" + codError + "]");
				cat.error("Mensaje de Error[" + msgError + "]");
				cat.error("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally {
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:descripcionArticulo");
		return resultado;
	}
	//Fin P-CSR-11002 JLGN 18-10-2011
	
	//Inicio P-CSR-11002 JLGN 10-11-2011
	public void insertRutaContrato(String numVenta, String rutaContrato) throws CustomerDomainException {
		cat.debug("Inicio:insertRutaContrato()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		final String nombrePackage = "VE_intermediario_PG".toUpperCase();
		final String nombrePL = "ve_in_ruta_contrato_pg".toUpperCase();
		final int cantidadParametros = 5;
		try {
			String call = getSQL(nombrePackage, nombrePL, cantidadParametros);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);

			cstmt.setLong(1, Long.parseLong(numVenta));
			cstmt.setString(2, rutaContrato);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cat.debug("Inicio:insertRutaContrato:execute");
			cstmt.execute();
			cat.debug("Fin:insertRutaContrato:execute");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
		
			if (codError != 0) {
				cat.error("Ocurrio un error al Insertar Ruta del Contrato");
				throw new CustomerDomainException("Ocurrio un error al Insertar Ruta del Contrato", String
						.valueOf(codError), numEvento, msgError);
			}		
		}
		catch (Exception e) {
			cat.error("Ocurrio un error al Insertar Ruta del Contrato", e);
			if (cat.isDebugEnabled()) {
				cat.error("Codigo de Error[" + codError + "]");
				cat.error("Mensaje de Error[" + msgError + "]");
				cat.error("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally {
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:insertRutaContrato");
	}
	//Fin P-CSR-11002 JLGN 10-11-2011
	
	//Inicio P-CSR-11002 JLGN 11-11-2011
	public String obtenerRutaContrato(long numVenta) throws CustomerDomainException {
		cat.debug("Inicio:obtenerRutaContrato()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		final String nombrePackage = "VE_intermediario_PG".toUpperCase();
		final String nombrePL = "ve_obt_ruta_contrato_pg".toUpperCase();
		final int cantidadParametros = 5;
		String resultado = null;
		try {
			String call = getSQL(nombrePackage, nombrePL, cantidadParametros);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);

			cstmt.setLong(1, numVenta);
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cat.debug("Inicio:obtenerRutaContrato:execute");
			cstmt.execute();
			cat.debug("Fin:obtenerRutaContrato:execute");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
		
			if (codError != 0) {
				cat.error("Ocurrio un error al Obtener Ruta del Contrato");
				throw new CustomerDomainException("Ocurrio un error al Obtener Ruta del Contrato", String
						.valueOf(codError), numEvento, msgError);
			}else{
				resultado = cstmt.getString(2);
			}		
		}
		catch (Exception e) {
			cat.error("Ocurrio un error al Obtener Ruta del Contrato", e);
			if (cat.isDebugEnabled()) {
				cat.error("Codigo de Error[" + codError + "]");
				cat.error("Mensaje de Error[" + msgError + "]");
				cat.error("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally {
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:obtenerRutaContrato");
		return resultado;
	}
	//Fin P-CSR-11002 JLGN 10-11-2011
	
}//fin CLASS DatosGeneralesDAO