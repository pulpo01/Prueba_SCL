package com.tmmas.cl.scl.customerdomain.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosGeneralesDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.ClienteDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.FormasPagoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.RegistroVentaDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.helper.Global;

public class FormasPagoDAO extends ConnectionDAO{

	private static Category cat = Category.getInstance(FormasPagoDAO.class);

	Global global = Global.getInstance();
	
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
	}//fin getConection

	private String getSQLDatosFormasPago(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
        for (int n = 1; n <= paramCount; n++) {
            sb.append("?");
            if (n < paramCount) sb.append(",");
        }
        return sb.append(")}").toString();
	}
	
	public FormasPagoDTO[] getArrayFormasPago(ParametrosGeneralesDTO parametroOrdenCompra,RegistroVentaDTO registroventa,ClienteDTO cliente)
		throws CustomerDomainException
	{
		cat.debug("getArrayFormasPago");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		FormasPagoDTO[] resultado = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		ResultSet rs = null;
		cat.debug("Coneccion obtenida OK");
		try {
			String call  = getSQLDatosFormasPago("VE_servicios_venta_PG","VE_obtiene_formas_pago_PR",7);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,parametroOrdenCompra.getValorparametro());
			cstmt.setString(2,registroventa.existePlanFreedom()?"TRUE":"FALSE");
			cstmt.setString(3,cliente.getCategoriaTributaria());//BOLETA o FACTURA;
			cstmt.registerOutParameter(4,OracleTypes.CURSOR);
			cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7,java.sql.Types.NUMERIC);
			cat.debug("Inicio:getArrayFormasPago:Execute");
			cstmt.execute();
			cat.debug("Fin:getArrayFormasPago:Execute");
			codError = cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento = cstmt.getInt(7);
			
			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar formas pago");
				throw new CustomerDomainException("Ocurrió un error al recuperar formas pago", String.valueOf(codError),numEvento,msgError);
			}
			else{
				cat.debug("Recuperando formas de pago");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(4);
				while (rs.next()) {
					FormasPagoDTO formaspagoDTO = new FormasPagoDTO();
					formaspagoDTO.setTipoValor(rs.getString(1));
					formaspagoDTO.setDescripcionTipoValor(rs.getString(2));
					lista.add(formaspagoDTO);
				}				
				resultado =(FormasPagoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), FormasPagoDTO.class);
				cat.debug("Fin recuperacion formas de pago");
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
			}
			catch (Exception e) {
				cat.error("Ocurrió un error al formas de pago para la venta",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new CustomerDomainException(
					"Ocurrió un error al recuperar formas de pago para la venta",e);
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
		cat.debug("Fin:getArrayFormasPago()");

		return resultado;
	}//fin getArrayFormasPago
	
	
	
	
}
