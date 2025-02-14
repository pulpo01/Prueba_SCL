package com.tmmas.cl.scl.customerdomain.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.ProspectoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.helper.Global;

public class ProspectoDAO extends ConnectionDAO{
	private static Category cat = Category.getInstance(ProspectoDAO.class);

	Global global = Global.getInstance();
	
	private Connection getConection() 
	throws CustomerDomainException
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
	
	private String getSQLDatos(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
        for (int n = 1; n <= paramCount; n++) {
            sb.append("?");
            if (n < paramCount) sb.append(",");
        }
        return sb.append(")}").toString();
	}//fin getSQLDatos
	
	/**
	 * Obtiene prospecto del Cliente
	 * @param prospecto
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public ProspectoDTO getProspectoCliente(ProspectoDTO entrada) 
		throws CustomerDomainException
	{
		cat.debug("Inicio:getProspectoCliente");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		ProspectoDTO prospectoDTO =null;
		CallableStatement cstmt = null;
		cat.debug("Coneccion obtenida OK");
		try {
			String call = getSQLDatos("VE_alta_cliente_PG","VE_getProspectoCliente_PR",19);
			cat.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,entrada.getCodigoTipoIdent());
			cstmt.setString(2,entrada.getNumeroIdent());

			cstmt.registerOutParameter(3,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(12,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(13,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(14,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(15,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(16,java.sql.Types.VARCHAR);
			
			cstmt.registerOutParameter(17,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(18,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(19,java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getProspectoCliente:Execute");
			cstmt.execute();
			cat.debug("Fin:getProspectoCliente:Execute");

			codError = cstmt.getInt(17);
			msgError = cstmt.getString(18);
			numEvento = cstmt.getInt(19);

			if (codError == 0) {
				prospectoDTO = entrada;
				entrada.setNombre(cstmt.getString(3));
				entrada.setApellido1(cstmt.getString(4));
				entrada.setApellido2(cstmt.getString(5));
				entrada.setNumeroTelefono1(cstmt.getString(6));
				entrada.setNumeroTelefono2(cstmt.getString(7));
				entrada.setNumeroFax(cstmt.getString(8));
				entrada.setNombreReprLegal(cstmt.getString(9));
				entrada.setCodigoTipoIdentRepr(cstmt.getString(10));
				entrada.setNumeroIdentRepr(cstmt.getString(11));
				entrada.setCodigoRubro(cstmt.getInt(12));
				entrada.setCodigoBanco(cstmt.getString(13));
				entrada.setNumeroCuenta(cstmt.getString(14));
				entrada.setCodigoTipotarjeta(cstmt.getString(15));
				entrada.setNumeroTarjeta(cstmt.getString(16));
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener prospecto del Cliente",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
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
		cat.debug("Fin:getProspectoCliente");
		return prospectoDTO;
	}//fin getProspectoCliente

	/**
	 * Obtiene prospecto de la direccion
	 * @param prospecto
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public ProspectoDTO getProspectoDireccion(ProspectoDTO entrada) 
		throws CustomerDomainException
	{
		cat.debug("Inicio:getProspectoDireccion");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		cat.debug("Coneccion obtenida OK");
		try {
			String call = getSQLDatos("VE_alta_cliente_PG","VE_getProspectoDireccion_PR",6);
			cat.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setInt(1,entrada.getCodigoProspecto());
			cstmt.setString(2,entrada.getTipoDireccion());

			cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
			
			cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6,java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getProspectoDireccion:Execute");
			cstmt.execute();
			cat.debug("Fin:getProspectoDireccion:Execute");

			
			
			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);

			if (codError == 0) {
				entrada.setCodigoDireccion(cstmt.getInt(3));	
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener prospecto de la direccion",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
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
		cat.debug("Fin:getProspectoDireccion");
		return entrada;
	}//fin getProspectoDireccion

}//fin class ProspectoDAO
