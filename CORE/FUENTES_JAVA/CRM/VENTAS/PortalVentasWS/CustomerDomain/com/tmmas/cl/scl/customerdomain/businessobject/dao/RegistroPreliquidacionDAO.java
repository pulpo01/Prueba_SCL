package com.tmmas.cl.scl.customerdomain.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.RegistroPreliquidacionDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.helper.Global;

public class RegistroPreliquidacionDAO extends ConnectionDAO {
	private static Category cat = Category.getInstance(RegistroPreliquidacionDAO.class);
	
	Global global = Global.getInstance();
	
	private Connection getConection() throws CustomerDomainException
	{
		Connection conn = null;
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
		} 
		catch (Exception e1) {
			conn = null;
			cat.error(" No se pudo obtener una conexión ", e1);
			throw new CustomerDomainException("No se pudo obtener una conexión", e1);
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
	
	public void registraMaestroPreliquidacion(RegistroPreliquidacionDTO preliquidacion)
		throws CustomerDomainException
	{		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			cat.debug("Inicio:registraMaestroPreliquidacion");
			String call = getSQLPackage("VE_servicios_venta_PG","VE_in_ga_preliquidacion_PR",9);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cat.debug("Numero Venta: "+preliquidacion.getNumeroVenta());
			cstmt.setLong(1,preliquidacion.getNumeroVenta());
			cat.debug("Codigo dealer: "+preliquidacion.getCodigoVendedor());
			cstmt.setString(2,preliquidacion.getCodigoVendedor());
			cat.debug("Codigo master dealer: "+preliquidacion.getCodigoVendedorRaiz());
			cstmt.setLong(3,preliquidacion.getCodigoVendedorRaiz());
			cat.debug("Codigo cliente: "+preliquidacion.getCodigoCliente());
			cstmt.setString(4, preliquidacion.getCodigoCliente());
			cat.debug("Codigo modalidad venta: "+preliquidacion.getCodigoModalidadVenta());
			cstmt.setInt(5,preliquidacion.getCodigoModalidadVenta());
			cstmt.setString(6,preliquidacion.getDatosPrograma().getCodigoPrograma());
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:registraMaestroPreliquidacion:execute");
			cstmt.execute();
			cat.debug("Fin:registraMaestroPreliquidacion:execute");
			
			codError=cstmt.getInt(7);
			msgError = cstmt.getString(8);
			numEvento=cstmt.getInt(9);
			cat.debug("msgError[" + msgError + "]");
		} 
		catch (Exception e) {
			cat.error("Ocurrió un error al insertar preliquidacion",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		} 
		finally {
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
		cat.debug("Fin:registraMaestroPreliquidacion");
	}
	
	
	public void actualizaMaestroPreliquidacion(RegistroPreliquidacionDTO preliquidacion)
		throws CustomerDomainException
	{		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		
		try {
			cat.debug("Inicio:actualizaMaestroPreliquidacion");
			String call = getSQLPackage("VE_servicios_venta_PG","VE_up_ga_preliquidacion_PR",4);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cat.debug("Numero Venta: "+preliquidacion.getNumeroVenta());
			cstmt.setLong(1,preliquidacion.getNumeroVenta());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cat.debug("Inicio:actualizaMaestroPreliquidacion:execute");
			cstmt.execute();
			cat.debug("Fin:actualizaMaestroPreliquidacion:execute");
			codError=cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento=cstmt.getInt(4);
			cat.debug("msgError[" + msgError + "]");
		} 
		catch (Exception e) {
			cat.error("Ocurrió un error al actualizar preliquidacion",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		} 
		finally {
				cat.debug("Cerrando conexiones...");
		    try {
		    	cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} 
		    catch (SQLException e) {
					cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:actualizaMaestroPreliquidacion");
	}

	
	
}
