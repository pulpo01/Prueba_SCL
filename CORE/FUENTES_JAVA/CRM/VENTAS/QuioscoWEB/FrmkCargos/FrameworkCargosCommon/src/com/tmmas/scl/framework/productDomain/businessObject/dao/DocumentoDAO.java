package com.tmmas.scl.framework.productDomain.businessObject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
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
			
			String call = getSQLPackage("VE_servicios_venta_PG","VE_promfacturadocliente_PR",7);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			System.out.print("indiceCiclo " + entrada.getIndiceCiclo());
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
