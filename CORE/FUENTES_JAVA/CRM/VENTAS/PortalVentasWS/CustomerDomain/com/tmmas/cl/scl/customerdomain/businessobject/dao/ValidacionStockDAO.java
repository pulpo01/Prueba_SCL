package com.tmmas.cl.scl.customerdomain.businessobject.dao;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import org.apache.log4j.Category;
import com.tmmas.cl.framework.base.JndiForDataSource;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.ParametrosValidacionStockDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.helper.Global;

public class ValidacionStockDAO 
{
    Global global = Global.getInstance();
    private static Category cat = Category.getInstance(ValidacionStockDAO.class);
	
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
	
	
	public ParametrosValidacionStockDTO ValidaStock( ParametrosValidacionStockDTO entrada)
		throws CustomerDomainException
	{		
		cat.debug("Validacion:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ParametrosValidacionStockDTO resultado=null;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		cat.debug("Coneccion obtenida OK");
		try {
			String call = getSQLPackage("Ve_Validacion_Linea_Pg","VE_RESTRINGESTOCK_PR",5);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,entrada.getCanal());
			cstmt.setString(2,entrada.getNumSerie());
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cat.debug("Execute Antes");
			cstmt.execute();
			cat.debug("Execute Despues");
			codError = cstmt.getInt(8);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(9);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(10);
			cat.debug("numEvento[" + numEvento + "]");
			if (codError != 0) 
			{
				cat.error("Tipo de Stock no permitido para ese Vendedor");
				throw new CustomerDomainException(
						"Tipo de Stock no permitido para ese Vendedor", String
								.valueOf(codError), numEvento, msgError);
		    }
		} catch (Exception e) {
			cat.error("Tipo de Stock no permitido para ese Vendedor",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new CustomerDomainException(
					"Tipo de Stock no permitido para ese Vendedor",e);
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
		cat.debug("ValidacionStock():end");
		return resultado;
	} 
}
