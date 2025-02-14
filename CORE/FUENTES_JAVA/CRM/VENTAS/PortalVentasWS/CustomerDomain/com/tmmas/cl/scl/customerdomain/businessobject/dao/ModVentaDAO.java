package com.tmmas.cl.scl.customerdomain.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.base.JndiForDataSource;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ConceptoVenta;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.DependenciasModalidadDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.helper.Global;

public class ModVentaDAO {
	
	Global global = Global.getInstance();
    private static Category cat = Category.getInstance(ModVentaDAO.class);
	
    private Connection getConection() throws CustomerDomainException
	{
		Connection conn = null;
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
		} catch (Exception e1) {
			conn = null;
			cat.error(" No se pudo obtener una conexión ", e1);
			throw new CustomerDomainException("No se pudo obtener una conexión", e1);
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
	
	public Connection getConnectionFromWLSInitialContext(
			JndiForDataSource parameters) throws Exception {

		Context ctx = null;
		ctx = new InitialContext();
		DataSource ds = null;
		ds = (DataSource) ctx.lookup(parameters.getJndiDataSource());
		Connection conn = null;
		try {
			conn = ds.getConnection();
		} catch (SQLException e) {
			conn = null;
			cat.debug("Error obteniendo coneccion");
			cat.debug("SQLException", e);
			throw e;
		}
		return conn;
	}
	
	public ConceptoVenta calcularModalidad(DependenciasModalidadDTO entrada)
		throws CustomerDomainException
	{
		cat.debug("Validacion:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ConceptoVenta resultado=new ConceptoVenta(0, null);
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		cat.debug("Coneccion obtenida OK");
		try {
			String call = getSQLPackage("VE_SERVICIOS_VENTA_PG","VE_Cambia_modalidad_PR",8);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);			
			cstmt.setString(1,entrada.getProductos().getNumSerie());
			cstmt.setString(2,entrada.getAgente().getCanal());
			cstmt.setInt(3,entrada.getModalidad().getCodigo());
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			cat.debug("Execute Antes");			
			cstmt.execute();			
			cat.debug("Execute Despues");
			codError = cstmt.getInt(6);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(7);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(8);
			cat.debug("numEvento[" + numEvento + "]");			
			
			resultado.setCodigo(cstmt.getInt(4));			
			resultado.setDescripcion(cstmt.getString(5));			
			if (codError != 0)
			{
				//resultado.setValor(false);
				cat.error("Error en Cambio de Modalidad de Venta");
				throw new CustomerDomainException(
						"Error en Cambio de Modalidad de Venta o Serie Simcard no se encuentra", String
								.valueOf(codError), numEvento, "Error en Cambio de Modalidad de Venta o Serie Simcard no se encuentra");
		    }
			
		} catch (Exception e) {			
			cat.error("Error en Cambio de Modalidad de Venta",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException ) throw (CustomerDomainException) e;			
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
		cat.debug("CalculoModVenta():end");
		
//		resultado.setValor(true);
		return resultado;
	}
	
	public void updateModalidaVenta(Long numVenta, Long codModVenta)
		throws CustomerDomainException
	{
		cat.debug("updateModalidaVenta:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;		
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		cat.debug("Coneccion obtenida OK");
		try {
			String call = getSQLPackage("GA_VENTAS_SB_PG","GA_UPD_MODVENTA_PR",5);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);			
			cstmt.setLong(1,numVenta.longValue());
			cat.debug("numVenta:" + numVenta);
			cstmt.setLong(2,codModVenta.longValue());
			cat.debug("codModVenta:" + codModVenta);
			
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cat.debug("Execute Antes");			
			cstmt.execute();			
			cat.debug("Execute Despues");
			codError = cstmt.getInt(3);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(4);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(5);
			cat.debug("numEvento[" + numEvento + "]");			
			
						
			if (codError != 0)
			{
				cat.error("Error en cambio de Modalidad de Venta Regalo");
				throw new CustomerDomainException(
						"Error en cambio de Modalidad de Venta Regalo", String
								.valueOf(codError), numEvento, "Error en cambio de Modalidad de Venta Regalo");
		    }
			
		} catch (Exception e) {			
			cat.error("Error en cambio de Modalidad de Venta Regalo",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException ) throw (CustomerDomainException) e;			
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
		cat.debug("updateModalidaVenta():end");
	}  	
}
