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
 * 16/01/2007     H&eacute;ctor Hermosilla      					Versión Inicial
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
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CausalDescuentoDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsMotivosDeDescuentoManualInDTO;
import com.tmmas.cl.scl.gestiondeclietnes.businessobject.helper.Global;


public class CausalDescuentoDAO extends ConnectionDAO{
	private static Category cat = Category.getInstance(CausalDescuentoDAO.class);

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
	
	/*private String getSqlListaCausalDescuento()
	{
		StringBuffer sRet = new StringBuffer();
		sRet.append("SELECT COD_PLANSERV, DES_PLANSERV");
		sRet.append(" FROM GA_PLANSERV");
		sRet.append(" WHERE SYSDATE BETWEEN FEC_DESDE AND NVL(FEC_HASTA, SYSDATE)");
		sRet.append(" AND COD_PRODUCTO = 1");
		return sRet.toString();
	}*/
	
	private String getSqlListaCausalDescuento(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
        for (int n = 1; n <= paramCount; n++) {
            sb.append("?");
            if (n < paramCount) sb.append(",");
        }
        return sb.append(")}").toString();
	
	}
	
	
	
	private CausalDescuentoDTO getResultset(ResultSet rs, int i) throws GeneralException
	{
		CausalDescuentoDTO plans = new CausalDescuentoDTO();
		
		try
		{
			if(global.ModoEjecucion().equals("prueba1"))
			{
				plans.setCodigoCausalDescuento("codPlans"+i);
				plans.setDescripcionCausalDescuento("desPlans"+i);
			}
			else
			{
				plans.setCodigoCausalDescuento(rs.getString(1));
				plans.setDescripcionCausalDescuento(rs.getString(2));
			}

		}
		catch(SQLException e)
		{
			throw new GeneralException(global.errorgetListado() +  " [" + i + "]", e);
		}
		
		return plans;
	}

	
	/**
	 * Obtiene listado de centros de costos
	 * @param causalDescuentoDTO
	 * @return CausalDescuentoDTO[]
	 * @throws GeneralException
	 */	
	public WsMotivosDeDescuentoManualInDTO[] getListMotivosJustificacion(CausalDescuentoDTO causalDescuentoDTO) 
	throws GeneralException{
		cat.debug("getListMotivosJustificacion:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		WsMotivosDeDescuentoManualInDTO[] resultado = null;
		Connection conn = null;
		conn = getConection();
		cat.debug("Coneccion obtenida OK");
		CallableStatement cstmt = null;
		try {
			String call = getSqlListaCausalDescuento("VE_PORTABILIDAD_PG","ve_justdocumdesc_pr",5);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);			
			cstmt.setString(1,causalDescuentoDTO.getTIP_DOCUMEN());
			cstmt.registerOutParameter(2,OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getListMotivosJustificacion:Execute");
			cstmt.execute();
			cat.debug("Fin:getListMotivosJustificacion:Execute");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar motivos de justificacion");
				throw new GeneralException(
						"Ocurrió un error al recuperar motivos de justificacion", String
								.valueOf(codError), numEvento, msgError);
				
			}else{
				cat.debug("Recuperando motivos de justificacion");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(2);
				while (rs.next()) {
					WsMotivosDeDescuentoManualInDTO causalDescuentoDTO2 = new WsMotivosDeDescuentoManualInDTO();
					causalDescuentoDTO2.setCodigoMotivosDeDescuentoManual(rs.getString(1));
					causalDescuentoDTO2.setDescripcionMotivosDeDescuentoManual(rs.getString(2));
					lista.add(causalDescuentoDTO2);
				}
				resultado =(WsMotivosDeDescuentoManualInDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), WsMotivosDeDescuentoManualInDTO.class);
				rs.close();
				cat.debug("Fin recuperacion de motivos de justificacion");
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar motivos de justificacion",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al recuperar motivos de justificacion",e);
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
		cat.debug("Fin:getListMotivosJustificacion()");

		return resultado;
	}//fin getListMotivosJustificacion



	/**
	 * Inserta documento con motivo de descuento
	 * @param CausalDescuentoDTO (entrada)
	 * @return N/A
	 * @throws GeneralException
	 */
	public void insDocumentoMotivo(CausalDescuentoDTO entrada)
	throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			cat.debug("Inicio:insDocumentoMotivo");
			
			String call = getSqlListaCausalDescuento("VE_PORTABILIDAD_PG","VE_insDocumentoMotivo_PR",14);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,entrada.getNUM_PROCESO());
			cstmt.setString(2,entrada.getCOD_CONCEPTO());
			cstmt.setString(3,entrada.getCOLUMNA());
			cstmt.setString(4,entrada.getCOD_JUSTIFICACION());
			cstmt.setString(5,entrada.getCOD_CENTCOS());
			cstmt.setString(6,entrada.getTIP_DOCUMEN());			
			cstmt.setString(7,entrada.getNUM_SECUENCI());
			cstmt.setString(8,entrada.getCOD_VENDEDOR());
			cstmt.setString(9,entrada.getLETRA());
			cstmt.setString(10,entrada.getCOD_CENTREMI());
			cstmt.setString(11,entrada.getNumVenta());
			
			cstmt.registerOutParameter(12, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(14, java.sql.Types.NUMERIC);
			
					    
			
			cat.debug("Inicio:insDocumentoMotivo:execute");
			cstmt.execute();
			cat.debug("Fin:insDocumentoMotivo:execute");

			codError=cstmt.getInt(12);
			msgError = cstmt.getString(13);
			numEvento=cstmt.getInt(14);
			
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");
			
			if (codError != 0) {
				cat.error("Ocurrió un error al insertar documento motivo de descuento");
				throw new GeneralException(
						"Ocurrió un error al insertar documento motivo de descuento", String
								.valueOf(codError), numEvento, msgError);				
			}					
		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al insertar documento motivo de descuento",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al insertar documento motivo de descuento",e);
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
		cat.debug("Fin:insDocumentoMotivo");
	}//fin insDocumentoMotivo


	
}//fin class CausalDescuentoDAO


