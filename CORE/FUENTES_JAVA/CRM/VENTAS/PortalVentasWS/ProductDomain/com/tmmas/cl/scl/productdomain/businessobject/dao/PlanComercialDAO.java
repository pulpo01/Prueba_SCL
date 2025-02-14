package com.tmmas.cl.scl.productdomain.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.ProductDomainException;
import com.tmmas.cl.scl.productdomain.businessobject.dto.PlanComercialDTO;
import com.tmmas.cl.scl.productdomain.businessobject.helper.Global;

public class PlanComercialDAO extends ConnectionDAO{
	
	private static Category cat = Category.getInstance(PlanTarifarioDAO.class);

	Global global = Global.getInstance();
	
	private Connection getConection() throws ProductDomainException
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
	
	private String getSQLDatosPlanComercial(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
        for (int n = 1; n <= paramCount; n++) {
            sb.append("?");
            if (n < paramCount) sb.append(",");
        }
        return sb.append(")}").toString();
	}//fin getSQLDatosPlanComercial

    /**
	 * Obtiene plan comercial
	 * @param parametroEntrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public PlanComercialDTO getPlanComercial(PlanComercialDTO parametroEntrada) 
		throws ProductDomainException
	{
		PlanComercialDTO resultado=new PlanComercialDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:getPlanComercial");
			
			String call = getSQLDatosPlanComercial("VE_validacion_linea_PG","VE_getPlanComercial_PR",6);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,parametroEntrada.getCodigoCalifCliente());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getPlanComercial:execute");
			cstmt.execute();
			cat.debug("Fin:getPlanComercial:execute");

			codError  = cstmt.getInt(4);
			msgError  = cstmt.getString(5);
			numEvento = cstmt.getInt(6);
			
			if (codError != 0){
				cat.error("Ocurrió un error al obtener plan comercial");
				throw new CustomerDomainException(
				"Ocurrió un error al obtener plan comercial", String
				.valueOf(codError), numEvento, msgError);
			}
			else{
				resultado.setCodigoPlanComercial(cstmt.getInt(2));
				resultado.setDescripcionPlanComercial(cstmt.getString(3));
			}
		
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener plan comercial",e);
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
		cat.debug("Fin:getPlanComercial");
		return resultado;
	}//fin getPlanComercial

	/**
	 * Obtiene listado de planes comerciales segun calificacion del cliente
	 * @param N/A
	 * @return clienteDTO[]
	 * @throws CustomerDomainException
	 */
	public PlanComercialDTO[] getListPlanComercialCalCte(PlanComercialDTO entrada) 
		throws ProductDomainException
	{
		cat.debug("Inicio:getListPlanComercialCalCte()");
		PlanComercialDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		ResultSet rs = null;
		CallableStatement cstmt =null;
		try {
			String call = getSQLDatosPlanComercial("VE_alta_cliente_PG","VE_getListPlanComCalCte_PR",5);

			cat.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,entrada.getCodigoCalifCliente());
			cstmt.registerOutParameter(2,OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getListPlanComercialCalCte:execute");
			cstmt.execute();
			cat.debug("Fin:getListPlanComercialCalCte:execute");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar listado de planes comerciales segun calificacion del cliente");
				throw new CustomerDomainException(
						"Ocurrió un error al recuperar listado de planes comerciales segun calificacion del cliente", String
								.valueOf(codError), numEvento, msgError);
			}else{
				cat.debug("Recuperando listado de planes comerciales segun calificacion del cliente");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(2);
				while (rs.next()) {
					PlanComercialDTO planComercialDTO = new PlanComercialDTO();
					planComercialDTO.setCodigoPlanComercial(rs.getInt(1));
					planComercialDTO.setDescripcionPlanComercial(rs.getString(2));
					lista.add(planComercialDTO);
				}
				rs.close();
				resultado =(PlanComercialDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), PlanComercialDTO.class);
				
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar listado de planes comerciales segun calificacion del cliente",e);
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
		cat.debug("Fin:getListPlanComercialCalCte()");
		return resultado;
	}//fin getListPlanComercialCalCte
	
}//fin PlanComercialDAO
