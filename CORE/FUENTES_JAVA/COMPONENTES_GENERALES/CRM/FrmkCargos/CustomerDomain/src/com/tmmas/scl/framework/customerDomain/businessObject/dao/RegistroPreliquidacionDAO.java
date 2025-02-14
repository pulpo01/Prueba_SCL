package com.tmmas.scl.framework.customerDomain.businessObject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;


import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.scl.framework.customerDomain.businessObject.dao.interfaces.RegistroPreLiquidacionDAOIT;
import com.tmmas.scl.framework.customerDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RegistroPreliquidacionDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerBillException;


public class RegistroPreliquidacionDAO extends ConnectionDAO implements RegistroPreLiquidacionDAOIT {
	
	private final Logger logger = Logger.getLogger(RegistroVentaDAO.class);
	
	Global global = Global.getInstance();
	
	private Connection getConection() throws CustomerBillException
	{
		Connection conn = null;
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
		} 
		catch (Exception e1) {
			conn = null;
			logger.error(" No se pudo obtener una conexión ", e1);
			throw new CustomerBillException("No se pudo obtener una conexión", e1);
		}
		return conn;
	}//fin getConection

	private String getSQLPackage(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
        for (int n = 1; n <= paramCount; n++) {
            sb.append("?");
            if (n < paramCount) sb.append(",");
        }
        return sb.append(")}").toString();
	}//fin getSQLPackage
	
	public void registraMaestroPreliquidacion(RegistroPreliquidacionDTO preliquidacion)throws CustomerBillException{
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		//conn = getConection();
		CallableStatement cstmt = null;
		try {
			logger.debug("Inicio:registraMaestroPreliquidacion");
			String call = getSQLPackage("PV_SERVICIOS_POSVENTA_PG","VE_in_ga_preliquidacion_PR",9);
			logger.debug("sql[" + call + "]");
			conn=getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			cstmt = conn.prepareCall(call);
			logger.debug("Numero Venta: "+preliquidacion.getNumeroVenta());
			cstmt.setLong(1,preliquidacion.getNumeroVenta());
			logger.debug("Codigo dealer: "+preliquidacion.getCodigoVendedor());
			cstmt.setString(2,preliquidacion.getCodigoVendedor());
			logger.debug("Codigo master dealer: "+preliquidacion.getCodigoVendedorRaiz());
			cstmt.setLong(3,preliquidacion.getCodigoVendedorRaiz());
			logger.debug("Codigo cliente: "+preliquidacion.getCodigoCliente());
			cstmt.setString(4, preliquidacion.getCodigoCliente());
			logger.debug("Codigo modalidad venta: "+preliquidacion.getCodigoModalidadVenta());
			cstmt.setInt(5,preliquidacion.getCodigoModalidadVenta());
			cstmt.setString(6,preliquidacion.getDatosPrograma().getCodigoPrograma());
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:registraMaestroPreliquidacion:execute");
			cstmt.execute();
			logger.debug("Fin:registraMaestroPreliquidacion:execute");
			
			codError=cstmt.getInt(7);
			msgError = cstmt.getString(8);
			numEvento=cstmt.getInt(9);
			logger.debug("msgError[" + msgError + "]");
		} 
		catch (Exception e) {
			logger.error("Ocurrió un error al insertar preliquidacion",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		} 
		finally {
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
		logger.debug("Fin:registraMaestroPreliquidacion");
	}
	
	
	public void actualizaMaestroPreliquidacion(RegistroPreliquidacionDTO preliquidacion)throws CustomerBillException{
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		
		try {
			logger.debug("Inicio:actualizaMaestroPreliquidacion");
			String call = getSQLPackage("PV_SERVICIOS_POSVENTA_PG","VE_up_ga_preliquidacion_PR",4);
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			logger.debug("Numero Venta: "+preliquidacion.getNumeroVenta());
			cstmt.setLong(1,preliquidacion.getNumeroVenta());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			logger.debug("Inicio:actualizaMaestroPreliquidacion:execute");
			cstmt.execute();
			logger.debug("Fin:actualizaMaestroPreliquidacion:execute");
			codError=cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento=cstmt.getInt(4);
			logger.debug("msgError[" + msgError + "]");
		} 
		catch (Exception e) {
			logger.error("Ocurrió un error al actualizar preliquidacion",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		} 
		finally {
				logger.debug("Cerrando conexiones...");
		    try {
		    	cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} 
		    catch (SQLException e) {
					logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:actualizaMaestroPreliquidacion");
	}

	
	
}
