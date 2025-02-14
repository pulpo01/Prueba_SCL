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
 * 06/02/2007     H&eacute;ctor Hermosilla      					Versión Inicial
 */

package com.tmmas.cl.scl.gestiondeclientes.businessobject.dao;

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
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.DatosComercialesDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.DocumentoDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.DocumentoFacturacionDTO;
import com.tmmas.cl.scl.gestiondeclietnes.businessobject.helper.Global;



public class DocumentoDAO extends ConnectionDAO{
	private static Category cat = Category.getInstance(DocumentoDAO.class);

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
	
	/**
	 * Obtiene un listado de tipos de documentos que son aplicables
	 * a un cliente
	 * 
	 * @param datos
	 * @return resultado
	 * @throws GeneralException
	 */
	public DocumentoDTO[] getListadoTipoDocumento(DatosComercialesDTO datos) throws GeneralException{
		cat.debug("getListadoTipoDocumento:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		DocumentoDTO[] resultado = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		cat.debug("Coneccion obtenida OK");
		try {
			//INI-01 (AL) String call = getSQLPackage("VE_PARAMETROS_COMERCIALES_PG","VE_tipodocumento_PR",10);
			String call = getSQLPackage("VE_PARAMETROS_COMER_QUIOSCO_PG","VE_tipodocumento_PR",10);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setInt(1,Integer.parseInt(datos.getCodigoCliente()));
			cstmt.setString(2,datos.getIndicadorAgente());
			cat.debug("INDICADOR AGENTE: " + datos.getIndicadorAgente());
			cstmt.setString(3,datos.getIndicadorSituacion());
			cat.debug("INDICADOR situacion: " + datos.getIndicadorSituacion());
			cstmt.setInt(4,Integer.parseInt(datos.getCodigoProducto()));
			cat.debug("CODIGO PRODUCTO: " + datos.getCodigoProducto());
			cstmt.setString(5,datos.getParametroAmiCiclo());
			cat.debug("PARAMETRO AMICICLO: " + datos.getParametroAmiCiclo());
			cstmt.setString(6,datos.getCodigoModulo());
			cat.debug("CODIGO MODULO: " + datos.getCodigoModulo());
			cstmt.registerOutParameter(7, OracleTypes.CURSOR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);
			cat.debug("Execute Antes");
			cstmt.execute();
			cat.debug("Execute Despues");
			
			codError = cstmt.getInt(8);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(9);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(10);
			cat.debug("numEvento[" + numEvento + "]");
			
			if (codError == 0) {
				cat.debug("Llenado Tipo de Documentos");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(7);
				while (rs.next()) {
					DocumentoDTO documento = new DocumentoDTO();
					documento.setCodigo(rs.getString(1));
					documento.setDescripcion(rs.getString(2));
					documento.setCategoriaTributaria(rs.getString(3));
					documento.setTipoFoliacion(rs.getString(4));
					lista.add(documento);
				}
				rs.close();
				resultado =(DocumentoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), DocumentoDTO.class);
				
				cat.debug("Fin Llenado Tipo de Documentos");
			}else {
				cat.error("Ocurrió un error al consultar el tipo de Documento");
				throw new GeneralException(
						"Ocurrió un error al consultar el tipo de Documento", String
								.valueOf(codError), numEvento, msgError);
			}
		} catch (GeneralException e) {
			throw e;	
		} catch (Exception e) {
			cat.error("Ocurrió un error al consultar el tipo de Documento",e);
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

		cat.debug("getListadoTipoDocumento():end");

		return resultado;
	}
	
	/**
	 * Obtiene Promedio de Documentos Facturados de un cliente especifico
	 * @param entrada 
	 * @return resultado
	 * @throws GeneralException
	 */

	
	public DocumentoFacturacionDTO getPromedioDocumentosFacturados(DocumentoFacturacionDTO entrada) throws GeneralException{
		DocumentoFacturacionDTO resultado = new DocumentoFacturacionDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:getPromedioDocumentosFacturados");
			
			//INI-01 (AL) String call = getSQLPackage("VE_servicios_venta_PG","VE_promfacturadocliente_PR",7);
			String call = getSQLPackage("VE_servicios_venta_Quiosco_PG","VE_promfacturadocliente_PR",7);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setInt(1,Integer.parseInt(entrada.getIndiceCiclo()));
			cstmt.setInt(2,entrada.getNumeroMeses());
			cstmt.setLong(3, Long.parseLong(entrada.getCodigoCliente()));
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			cstmt.execute();
			
			codError=cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento=cstmt.getInt(7);
			
			cat.debug("codError ["+codError+"]");
			cat.debug("msgError ["+msgError+"]");
			cat.debug("numEvento ["+numEvento+"]");

			if (codError!=0)
				resultado.setPromedioFacturado(cstmt.getFloat(4));
		
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener el promedio de documentos facturados",e);
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

		cat.debug("Fin:getPromedioDocumentosFacturados");

		return resultado;
	}//fin getPromedioDocumentosFacturados
	
	
}


