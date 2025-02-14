/**
 * Copyright © 2006 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 10-07-2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.serviceDomain.businessObject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.scl.framework.productDomain.exception.ProductSpecificationException;
import com.tmmas.scl.framework.serviceDomain.businessObject.dao.interfaces.CategoriasNumeroDestinoDAOIT;
import com.tmmas.scl.framework.serviceDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.NumeroDTO;
import com.tmmas.scl.framework.serviceDomain.exception.ServiceSpecEntitiesException;

public class CategoriasNumeroDestinoDAO extends ConnectionDAO implements CategoriasNumeroDestinoDAOIT 
{
	private final Logger logger = Logger.getLogger(CategoriasNumeroDestinoDAO.class);

	private final Global global = Global.getInstance();
	
	private Connection getConection() throws ServiceSpecEntitiesException
	{
		Connection conn = null;
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
		} catch (Exception e1) {
			conn = null;
			logger.error(" No se pudo obtener una conexión ", e1);
			throw new ServiceSpecEntitiesException("No se pudo obtener una conexión", e1);
		}

		return conn;
	}

	
	private String getSQLobtenerTipoNumero()
	{
		/**
		 *  COD_CATEGORIA_DEST VARCHAR2(5),
  		   DES_CATEGORIA VARCHAR2(30),
  		   NUM_CELULAR NUMBER(15)
		 */
		
		StringBuffer sql=new StringBuffer();
		sql.append(" DECLARE "); 
		sql.append("   EO_CATEG_NUM SE_CATEGORIAS_QT; ");
		sql.append("   SN_COD_RETORNO NUMBER; ");
		sql.append("   SV_MENS_RETORNO VARCHAR2(200); ");
		sql.append("   SN_NUM_EVENTO NUMBER; ");
		sql.append(" BEGIN ");
		sql.append("   EO_CATEG_NUM:=SE_CATEGORIAS_QT(NULL,NULL,NULL); ");		
		sql.append("   EO_CATEG_NUM.NUM_CELULAR			  := ?; ");
		sql.append("   SE_CATEGORIA_NUM_DESTINO_PG.SE_DETERMINA_CATEGORIA_PR(EO_CATEG_NUM,?,?,?); ");		
		sql.append("   ?	:=	EO_CATEG_NUM.COD_CATEGORIA_DEST	 ; ");
		sql.append("   ?	:=  EO_CATEG_NUM.DES_CATEGORIA ; ");
		sql.append(" END; ");		
		return sql.toString();
		
	}
	
	public NumeroDTO obtenerTipoNumero(NumeroDTO numero) throws ServiceSpecEntitiesException 
	{		
		logger.debug("Inicio:obtenerTipoNumero()");		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			String call = getSQLobtenerTipoNumero();
			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);			
			
//			 SE LLENAN PARAMETROS SEGUN PL
			cstmt.setLong(1, Long.parseLong(numero.getNro()));					
			//---- ERRORES
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);	
			
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
		
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(2);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(3);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(4);
			logger.debug("numEvento[" + numEvento + "]");
			//fin----------------------------------------------------------------------
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al obtener Restricciones Contratacion");
				throw new ProductSpecificationException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			//ini-----------OBTENER Datos Salida DE SERVICIOS A ACTIVAR Y DESACTIVAR-------				
			
			numero.setCodCategoriaDest(cstmt.getString(5)!=null?cstmt.getString(5):"");
			numero.setDesCategoria(cstmt.getString(6)!=null?cstmt.getString(6):"");
			
			
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			logger.error("Ocurrió un error al recuperar CargosProductos",e);
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

		logger.debug("Fin:obtenerTipoNumero()");

		return numero;
	}

}
