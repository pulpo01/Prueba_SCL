package com.tmmas.cl.scl.productdomain.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ResultadoValidacionLogisticaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.TipoStockValidoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.ProductDomainException;
import com.tmmas.cl.scl.productdomain.businessobject.helper.Global;

public class TipoStockSerieDAO  extends ConnectionDAO{
	
	private static Category cat = Category.getInstance(TipoStockSerieDAO.class);
	
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
	}
	
	private String getSQLDatos(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
        for (int n = 1; n <= paramCount; n++) {
            sb.append("?");
            if (n < paramCount) sb.append(",");
        }
        return sb.append(")}").toString();
	}
	
	public ResultadoValidacionLogisticaDTO getTipoStockSerieValido(TipoStockValidoDTO lineaEntrada) throws ProductDomainException{
		cat.debug("getTipoStockSerieValido:start");
		ResultadoValidacionLogisticaDTO resultado = new ResultadoValidacionLogisticaDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		try {
			String call = getSQLDatos("VE_validacion_linea_PG","VE_tipostock_valido_PR",8);
			cat.debug("sql[" + call + "]");
			CallableStatement cstmt = conn.prepareCall(call);
			cstmt.setInt(1,lineaEntrada.getTipoStockaValidar());
			cstmt.setInt(2,lineaEntrada.getModalidadVenta());
			cstmt.setInt(3,lineaEntrada.getCodigoProducto());
			cstmt.setString(4,lineaEntrada.getCodigoCanal());
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			
			cstmt.execute();
			
			codError = cstmt.getInt(6);
			msgError = cstmt.getString(7);
			numEvento = cstmt.getInt(8);
			cat.debug("msgError[" + msgError + "]");
			resultado.setResultadoBase(cstmt.getInt(5));
			
			cat.debug("stock simcard valido[" + resultado.getResultadoBase()+ "]");
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al validar tipo stock simcard",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
				cat.debug("Cerrando conexiones...");
	    try {
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				cat.debug("SQLException", e);
		  }
		}

		cat.debug("getTipoStockSerieValido:end");

		return resultado;
	}


}
