package com.tmmas.scl.framework.productDomain.businessObject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DatosComercialesDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DocumentoDTO;
import com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces.DocumentoDAOIT;
import com.tmmas.scl.framework.productDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.productDomain.dataTransferObject.DocumentoFacturacionDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;



public class DocumentoDAO extends ConnectionDAO implements DocumentoDAOIT{
	
	private final Logger logger = Logger.getLogger(DocumentoDAO.class);

	private final Global global = Global.getInstance();
	
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
	 * @throws CustomerDomainException
	 */
	public DocumentoDTO[] getListadoTipoDocumento(DatosComercialesDTO datos) throws ProductException{
		
		logger.debug("getListadoTipoDocumento:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		DocumentoDTO[] resultado = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		logger.debug("Coneccion obtenida OK");
		try {
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			String call = getSQLPackage("VE_PARAMETROS_COMERCIALES_PG","VE_tipodocumento_PR",10);
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setInt(1,Integer.parseInt(datos.getCodigoCliente()));
			cstmt.setString(2,datos.getIndicadorAgente());
			logger.debug("INDICADOR AGENTE: " + datos.getIndicadorAgente());
			cstmt.setString(3,datos.getIndicadorSituacion());
			logger.debug("INDICADOR situacion: " + datos.getIndicadorSituacion());
			cstmt.setInt(4,Integer.parseInt(datos.getCodigoProducto()));
			logger.debug("CODIGO PRODUCTO: " + datos.getCodigoProducto());
			cstmt.setString(5,datos.getParametroAmiCiclo());
			logger.debug("PARAMETRO AMICICLO: " + datos.getParametroAmiCiclo());
			cstmt.setString(6,datos.getCodigoModulo());
			logger.debug("CODIGO MODULO: " + datos.getCodigoModulo());
			cstmt.registerOutParameter(7, OracleTypes.CURSOR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);
			logger.debug("Execute Antes");
			cstmt.execute();
			logger.debug("Execute Despues");
			codError = cstmt.getInt(8);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(9);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(10);
			logger.debug("numEvento[" + numEvento + "]");
			if (codError != 0) {
				logger.error("Ocurrió un error al consultar el Tipo de Documento");
				throw new ProductException(
						"Ocurrió un error al consultar el Tipo de Documento", String
								.valueOf(codError), numEvento, msgError);
				
			}else{
				logger.debug("Llenado Tipo de Documentos");
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
				
				logger.debug("Fin Llenado Tipo de Documentos");
			}
		} catch (Exception e) {
			logger.error("Ocurrió un error al consultar el tipo de Documento",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new ProductException(
					"Ocurrió un error al consultar el tipo de contrato",e);
		} finally {
		 	if (logger.isDebugEnabled()) 
		 		logger.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}

		logger.debug("getListadoTipoDocumento():end");

		return resultado;
	}
	
	/**
	 * Obtiene Promedio de Documentos Facturados de un cliente especifico
	 * @param entrada 
	 * @return resultado
	 * @throws CustomerDomainException
	 */

	
	public DocumentoFacturacionDTO getPromedioDocumentosFacturados(DocumentoFacturacionDTO entrada) throws ProductException{
		DocumentoFacturacionDTO resultado = new DocumentoFacturacionDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		
		CallableStatement cstmt = null; 
		try {
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			logger.debug("Inicio:getPromedioDocumentosFacturados");
			
			String call = getSQLPackage("PV_SERVICIOS_POSVENTA_PG","VE_promfacturadocliente_PR",7);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			logger.debug("indiceCiclo " + entrada.getIndiceCiclo());
			cstmt.setInt(1,Integer.parseInt(entrada.getIndiceCiclo()));
			logger.debug("numMeses" + entrada.getNumeroMeses());
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
			logger.debug("msgError[" + msgError + "]");

			if (codError!=0){
				throw new ProductException(String.valueOf(codError), numEvento, msgError);
			}
			else{
				resultado.setPromedioFacturado(cstmt.getFloat(4));
			}
		
		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener el promedio de documentos facturados",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
		 	if (logger.isDebugEnabled()) 
		 		logger.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}

		logger.debug("Fin:getPromedioDocumentosFacturados");

		return resultado;
	}//fin getPromedioDocumentosFacturados

}
