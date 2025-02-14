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
 * 16/08/2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.serviceDomain.businessObject.dao;

import java.sql.Connection;
import java.sql.SQLException;

import oracle.jdbc.OracleCallableStatement;
import oracle.sql.ARRAY;
import oracle.sql.ArrayDescriptor;
import oracle.sql.STRUCT;
import oracle.sql.StructDescriptor;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.serviceDomain.businessObject.dao.interfaces.ProductoTasacionContratadoTOLServiceDAOIT;
import com.tmmas.scl.framework.serviceDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.NumeroListDTO;
import com.tmmas.scl.framework.serviceDomain.exception.ServiceException;

public class ProductoTasacionContratadoTOLServiceDAO extends ConnectionDAO implements ProductoTasacionContratadoTOLServiceDAOIT
{
	private final Logger logger = Logger.getLogger(ProductoTasacionContratadoTOLServiceDAO.class);
	private final Global global = Global.getInstance();
	
	private String getSQLinformarListaNumeros()
	{
		StringBuffer call=new StringBuffer();		
		call.append(" DECLARE ");
		call.append("   EN_COD_CLIENTE NUMBER; ");
    	call.append(" EN_COD_ABONADO NUMBER; ");
		call.append("   EN_COD_PRODC NUMBER; ");
    	call.append("   EV_TIPO_COMP VARCHAR2(200); ");
		call.append("   EO_AFINESFRECUENTES SV_TOL_LISTA_CONTRATADA_DET_QT; ");
		call.append("   SN_COD_RETORNO NUMBER; ");
		call.append("   SV_MENS_RETORNO VARCHAR2(200); ");
		call.append("   SN_NUM_EVENTO NUMBER; ");
		call.append(" BEGIN ");
		call.append("   EN_COD_CLIENTE := ?; ");
		call.append("   EN_COD_ABONADO := ?; ");
		call.append("   EN_COD_PRODC := ?; ");
		call.append("   EV_TIPO_COMP := ?; ");
		call.append("   EO_AFINESFRECUENTES := ?; ");
		call.append("   SV_TOL_LISTAS_CONTRATADAS_PG.SV_TOL_ALTA_LISTAS_PR(EN_COD_CLIENTE,EN_COD_ABONADO,EN_COD_PRODC,EV_TIPO_COMP,EO_AFINESFRECUENTES,?,?,?); ");  
		call.append(" END; ");		 
		return call.toString();
	}

	public RetornoDTO informarListaNumeros(NumeroListDTO listaNumeros) throws ServiceException {
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;		
		Connection conn = null;
		OracleCallableStatement cstmt = null;
		
		String call=getSQLinformarListaNumeros();
		try 
		{		
			conn = getConnectionFromWLSInitialContext(global.getJndiForTOLServiceDataSource());			
			cstmt = (OracleCallableStatement)conn.prepareCall(call);			
			StructDescriptor sd = StructDescriptor.createDescriptor("SV_TOL_LISTA_CONTRATADA_QT", conn);			
			ArrayDescriptor ad=null;
			ARRAY aux =null;			
			STRUCT[] arreglo=listaNumeros.getOracleArray_SV_TOL_LISTA_CONTRATADA_DET_QT(sd, conn);		
			ad = ArrayDescriptor.createDescriptor("SV_TOL_LISTA_CONTRATADA_DET_QT", conn);
			aux = new ARRAY(ad, conn, arreglo);
			
			cstmt.setString(1, listaNumeros.getCodCliente());
			cstmt.setString(2, listaNumeros.getNumAbonado());
			cstmt.setString(3, listaNumeros.getIdProducto());
			cstmt.setString(4, listaNumeros.getTipoComportamiento());			
			cstmt.setARRAY(5, aux);			
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);			
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(6);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(7);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(8);
			logger.debug("numEvento[" + numEvento + "]");
			//fin----------------------------------------------------------------------
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al crear la lista de numeros");
				throw new ServiceException(String.valueOf(codError),numEvento, msgError);
			}
			
			//obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");
			//ini--------------RESCATAR RETORNO-------
			retorno = new RetornoDTO();
			retorno.setCodigo(String.valueOf(codError));
			retorno.setDescripcion(msgError);
			retorno.setResultado(true);
			//fin----------------------------------------------------------------------
		
		} catch (ServiceException e) {
			logger.debug("ServiceException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al eliminar fin ciclo", e);
			throw new ServiceException("Ocurrió un error general al eliminar fin ciclo",e);
		}
		finally {
			try {
				if (cstmt != null) {
					cstmt.close();
					cstmt = null;
				}
				if (conn != null) {
					if (!conn.isClosed()) {
						conn.close();
					}
					conn = null;
				}
			} catch (SQLException e) {
				cstmt = null;
				conn = null;
				logger.debug("SQLException[" + e + "]");
			}
		}
		logger.debug("eliminar():end");
		return retorno;
	}
}
