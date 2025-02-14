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
 * 11-07-2007     			 Esteban Conejeros              		Versión Inicial
 * 30-07-2007				 Cristian Toledo					Implementacion de llamada al metodo obtenerCategoriaPlanBasico 
 */
package com.tmmas.scl.framework.productDomain.businessObject.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import oracle.jdbc.OracleCallableStatement;
import oracle.sql.STRUCT;
import oracle.sql.StructDescriptor;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces.CategoriaPlanBasicoDAOIT;
import com.tmmas.scl.framework.productDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CategoriaDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CategoriaListDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.PlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductOfferingException;




public class CategoriaPlanBasicoDAO extends ConnectionDAO implements CategoriaPlanBasicoDAOIT
{
	private final Logger logger = Logger.getLogger(CategoriaPlanBasicoDAO.class);
	private Global global = Global.getInstance();
	
	private String getSQLobtenerCategoriaPlanBasico()
	{
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   EO_CAT_CARG PF_CLIEN_ABO_QT; ");
		call.append("   SO_LISTA_CAT_CARG PS_CATEGORIAS_BASICO_PG.refCursor; ");
		call.append("   SN_COD_RETORNO NUMBER; ");
		call.append("   SV_MENS_RETORNO VARCHAR2(200); ");
		call.append("   SN_NUM_EVENTO NUMBER; ");
		call.append(" 	BEGIN ");
		call.append("   PS_CATEGORIAS_BASICO_PG.PS_CATEGORIA_S_PR(?,?,?,?,?); ");    
		call.append(" END; ");
		return call.toString();		
	}
	
	public CategoriaListDTO obtenerCategoriaPlanBasico(PlanTarifarioDTO planTarif) throws ProductOfferingException	 
	{
		logger.debug("obtenerCategoriaPlanBasico():start");		
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		CategoriaListDTO retorno = null;		
		Connection conn = null;
		OracleCallableStatement cstmt = null;
		
		String call = getSQLobtenerCategoriaPlanBasico();		
		
		try {
			
			if(planTarif==null)
			{
				logger.debug("PARAMETROS DE ENTRADA MAL INGRESADOS");
				return null;
			}
			logger.debug("planTarif[" + planTarif+ "]");
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());			
			cstmt =(OracleCallableStatement)conn.prepareCall(call);
			
			StructDescriptor sd = StructDescriptor.createDescriptor("PF_CLIEN_ABO_QT", conn);			
			STRUCT oracleObject = new STRUCT(sd, conn, planTarif.toStruct_PF_CLIEN_ABO_QT());
			
//			 SE LLENAN PARAMETROS SEGUN PL
			cstmt.setObject(1, oracleObject);			
			cstmt.registerOutParameter(2, oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
						
			logger.debug("execute:antes");
			cstmt.execute();	
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(3);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(4);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(5);
			logger.debug("numEvento[" + numEvento + "]");
			//fin----------------------------------------------------------------------
			if (codError != 0) {
				logger.error(" Ocurrió un error al ");
				throw new ProductOfferingException(String.valueOf(codError),numEvento, msgError);
			}
			//obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");
			//ini--------------RESCATAR RETORNO-------
			retorno=new CategoriaListDTO();
			CategoriaDTO dto=null;
			CategoriaDTO[] dtoList=null;
			ArrayList retornoOracle=new ArrayList();
			ResultSet rs=(ResultSet)cstmt.getObject(2);
			
			while(rs.next())
			{ 
				dto=new CategoriaDTO();				
				dto.setIdCategoria(rs.getString("COD_CATEGORIA")!=null?rs.getString("COD_CATEGORIA"):"");
				dto.setCargoMinReq(rs.getString("MIN_CARGO_REQUERIDO")!=null?rs.getString("MIN_CARGO_REQUERIDO"):"");
				dto.setNombre(rs.getString("DES_CATEGORIA")!=null?rs.getString("DES_CATEGORIA"):"");
				dto.setTipoAplicacion(rs.getString("ID_CATEGORIA")!=null?rs.getString("ID_CATEGORIA"):"");
				retornoOracle.add(dto);
			}
			dtoList=(CategoriaDTO[]) ArrayUtl.copiaArregloTipoEspecifico(retornoOracle.toArray(), CategoriaDTO.class);
			retorno.setCategoriaList(dtoList);
			
			//fin----------------------------------------------------------------------
		
		} catch (ProductOfferingException e) {
			logger.debug("ProductOfferingException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener Categoria Plan Basico", e);
			throw new ProductOfferingException("Ocurrió un error general al obtener Categoria Plan Basico",e);
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
		logger.debug("obtenerCategoriaPlanBasico():end");
		return retorno;				
	}
}
