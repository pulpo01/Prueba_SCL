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
package com.tmmas.cl.scl.productdomain.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosGeneralesDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.ProductDomainException;
import com.tmmas.cl.scl.productdomain.businessobject.dto.DatosGenerDTO;
import com.tmmas.cl.scl.productdomain.businessobject.helper.Global;

public class ParametrosGeneralesDAO extends ConnectionDAO{
		private static Category cat = Category.getInstance(ParametrosGeneralesDAO.class);
		Global global = Global.getInstance();
		
		private Connection getConection() 
		throws ProductDomainException
		{
			Connection conn = null;
			try {
				conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			} catch (Exception e1) {
				conn = null;
				cat.error(" No se pudo obtener una conexión ", e1);
				throw new ProductDomainException("No se pudo obtener una conexión", e1);
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
		 * @throws ProductDomainException
		 */
		
		public ParametrosGeneralesDTO getParametroGeneral(ParametrosGeneralesDTO parametrogeneral) 
			throws ProductDomainException
		{
			ParametrosGeneralesDTO resultado = new ParametrosGeneralesDTO();
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			conn = getConection();
			CallableStatement cstmt = null; 
			try {
				cat.debug("Inicio:ParametrosGeneralesDAO:getParametroGeneral()");
				
				String call = getSQLDatosAbonado("VE_intermediario_PG","VE_obtiene_valor_parametro_PR",7);

				cat.debug("sql[" + call + "]");

				cstmt = conn.prepareCall(call);
				cstmt.setString(1,parametrogeneral.getNombreparametro());
				cstmt.setString(2, parametrogeneral.getCodigomodulo());
				cstmt.setString(3, parametrogeneral.getCodigoproducto());
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
				
				cat.debug("msgError[" + msgError + "]");
				if (codError!=0)
				{
					cat.error("Ocurrió un error al obtener parametro general");
					throw new ProductDomainException(
							"Ocurrió un error al obtener parametro general", String
									.valueOf(codError), numEvento, "Ocurrió un error al obtener parametro general");
				}else{
					resultado.setNombreparametro(parametrogeneral.getNombreparametro());
					resultado.setCodigomodulo(parametrogeneral.getCodigomodulo());
					resultado.setCodigoproducto(parametrogeneral.getCodigoproducto());
					resultado.setValorparametro(cstmt.getString(4));
				}			
			} catch (Exception e) {
				cat.error("Ocurrió un error al obtener parametro general",e);
				if (cat.isDebugEnabled()) {
					cat.debug("Codigo de Error[" + codError + "]");
					cat.debug("Mensaje de Error[" + msgError + "]");
					cat.debug("Numero de Evento[" + numEvento + "]");
				}
				if (e instanceof ProductDomainException ) throw (ProductDomainException) e;				
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
		 * @throws ProductDomainException
		 */

		
		public ParametrosGeneralesDTO getParametroFacturacion(ParametrosGeneralesDTO parametrogeneral) 
			throws ProductDomainException
		{
			ParametrosGeneralesDTO resultado = new ParametrosGeneralesDTO();
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			conn = getConection();
			CallableStatement cstmt = null; 
			try {
				cat.debug("Inicio:getParametroFacturacion()");
				
				String call = getSQLDatosAbonado("VE_servicios_venta_PG","VE_obtiene_parametro_fact_PR",5);

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
				
				cat.debug("msgError[" + msgError + "]");
				if (codError!=0)
				{
					cat.error("Ocurrió un error al obtener parametro general");
					throw new ProductDomainException("Ocurrió un error al obtener parametro de facturacion", String
									.valueOf(codError), numEvento, "Ocurrió un error al obtener parametro de facturacion");
				}else{
					resultado.setValorparametro(cstmt.getString(2));
				}			
			} catch (Exception e) {
				cat.error("Ocurrió un error al obtener parametro de facturacion",e);
				if (cat.isDebugEnabled()) {
					cat.debug("Codigo de Error[" + codError + "]");
					cat.debug("Mensaje de Error[" + msgError + "]");
					cat.debug("Numero de Evento[" + numEvento + "]");
				}
				if (e instanceof ProductDomainException ) throw (ProductDomainException) e;
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
		 * @throws ProductDomainException
		 */
		public ParametrosGeneralesDTO getParametroGrupoTecnologico(ParametrosGeneralesDTO parametroGeneral) 
			throws ProductDomainException
		{
			ParametrosGeneralesDTO resultado = new ParametrosGeneralesDTO();
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			conn = getConection();
			CallableStatement cstmt = null; 
			try {
				cat.debug("Inicio:ParametrosGeneralesDAO:getParametroGrupoTecnologico()");
				
				String call = getSQLDatosAbonado("VE_intermediario_PG","VE_ObtieneGrupoTecnologico_PR",5);

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
				
				cat.debug("msgError[" + msgError + "]");
				if (codError!=0)
				{
					cat.error("Ocurrió un error al obtener parametro general");
					throw new ProductDomainException("Ocurrió un error al obtener parametro general", String
									.valueOf(codError), numEvento, "Ocurrió un error al obtener parametro general");
				}else{
					resultado.setValorparametro(cstmt.getString(2));
				}
			
			} catch (Exception e) {
				cat.error("Ocurrió un error al obtener parametro general",e);
				if (cat.isDebugEnabled()) {
					cat.debug("Codigo de Error[" + codError + "]");
					cat.debug("Mensaje de Error[" + msgError + "]");
					cat.debug("Numero de Evento[" + numEvento + "]");
				}
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
		
		public DatosGenerDTO getParametrosGenerales()
			throws ProductDomainException 
		{
			if (cat.isDebugEnabled()) {
				cat.debug("getParametrosGenerales():start");
			}
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			CallableStatement cstmt = null;
			DatosGenerDTO datosGenerDTO = new DatosGenerDTO();

			String call = null;
			Connection conn = null;
			// se recuepera coneccion del DataSources
			try {
				conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			} catch (Exception e1) {
				cat.error(" No se pudo obtener una conexión ", e1);
				throw new ProductDomainException(	"No se pudo obtener una conexión", e1);
			}
			try {

				call = getSQLDatosAbonado("VE_CREA_LINEA_VENTA_PG","VE_GET_DATOS_GENERALES_PR",9);
				if (cat.isDebugEnabled()) {
					cat.debug("sql[" + call + "]");
				}
				cstmt = conn.prepareCall(call);

				if (cat.isDebugEnabled()) {
					cat.debug("Registrando Entradas");
				}

				if (cat.isDebugEnabled()) {
					cat.debug(" Registrando salidas");
				}				
				
				cstmt.registerOutParameter(1,oracle.jdbc.driver.OracleTypes.VARCHAR); //cod_calclien
				cstmt.registerOutParameter(2,oracle.jdbc.driver.OracleTypes.VARCHAR); //cod_abc
				cstmt.registerOutParameter(3,oracle.jdbc.driver.OracleTypes.NUMBER);  //cod_123
				cstmt.registerOutParameter(4,oracle.jdbc.driver.OracleTypes.VARCHAR); //codestcobros
				cstmt.registerOutParameter(5,oracle.jdbc.driver.OracleTypes.VARCHAR); //codgrpsrv
				cstmt.registerOutParameter(6,oracle.jdbc.driver.OracleTypes.VARCHAR); //cod_docanex 
				
				cstmt.registerOutParameter(7,oracle.jdbc.driver.OracleTypes.NUMBER);
				cstmt.registerOutParameter(8,oracle.jdbc.driver.OracleTypes.VARCHAR);
				cstmt.registerOutParameter(9,oracle.jdbc.driver.OracleTypes.NUMBER);

				if (cat.isDebugEnabled()) {
					cat.debug(" Iniciando Ejecución");
				}

				cat.debug("Execute Antes");				
				cstmt.execute();				
				cat.debug("Execute Despues");

				if (cat.isDebugEnabled()) {
					cat.debug(" Finalizo ejecución");
					cat.debug(" Recuperando salidas");
				}
				// Recuperacion de valores de salida

				datosGenerDTO.setCod_Calclien(cstmt.getString(1));
				datosGenerDTO.setCod_abc(cstmt.getString(2));
				datosGenerDTO.setCod_123(new Long(cstmt.getLong(3)));
				datosGenerDTO.setCod_DocAnex(new Long (cstmt.getLong(6)));

				codError = cstmt.getInt(7);
				cat.debug("codError[" + codError + "]");
				msgError = cstmt.getString(8);
				cat.debug("msgError[" + msgError + "]");
				numEvento = cstmt.getInt(9);
				cat.debug("numEvento[" + numEvento + "]");

				if (codError != 0) {
					cat.error(" Ocurrió un error general al recuperar parametros generales");
					throw new ProductDomainException(String.valueOf(codError),numEvento, msgError);
				}

				cat.debug("Recuperando data...");

				cat.debug("Cod_calclien[" + datosGenerDTO.getCod_Calclien() + "]");
				cat.debug("Cod_abc[" + datosGenerDTO.getCod_Abc() + "]");
				cat.debug("Cod_123[" + datosGenerDTO.getCod_123() + "]");
				cat.debug("Cod_DocAnex[" + datosGenerDTO.getCod_DocAnex() + "]");
			
			} catch (Exception e) {				
				e.printStackTrace();
				cat.error("Ocurrió un error general getParametrosGenerales", e);
				if (cat.isDebugEnabled()) {
					cat.debug("Codigo de Error[" + codError + "]");
					cat.debug("Mensaje de Error[" + msgError + "]");
					cat.debug("Numero de Evento[" + numEvento + "]");
				}
				if (e instanceof ProductDomainException ) throw (ProductDomainException) e;				
			} finally {
				if (cat.isDebugEnabled()) {
					cat.debug("Cerrando conexiones...");
				}
				try {
					if (cstmt != null) {
						cstmt.close();
					}
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					cat.debug("SQLException[" + e + "]");
				}
			}

			if (cat.isDebugEnabled()) {
				cat.debug("getParametrosGenerales():end");
			}

			return datosGenerDTO;
		}

}//fin ParametrosGeneralesDAO
