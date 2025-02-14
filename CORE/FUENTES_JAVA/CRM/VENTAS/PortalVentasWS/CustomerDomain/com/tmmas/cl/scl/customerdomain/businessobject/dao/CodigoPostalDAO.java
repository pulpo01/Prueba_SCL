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
import com.tmmas.cl.scl.commonbusinessentities.dto.CodigoPostalDireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.DatosDireccionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.helper.Global;

public class CodigoPostalDAO extends ConnectionDAO{
	private static Category cat = Category.getInstance(ComunaDAO.class);

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
	public CodigoPostalDireccionDTO getListadoCodigosPostales(CodigoPostalDireccionDTO codigoPostalDireccionDTO)
		throws CustomerDomainException
	{
		cat.debug("getListadoCodigosPostales:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		ResultSet rs = null;
		cat.debug("Coneccion obtenida OK");
		try {
			String call = getSQLPackage("VE_servicios_direcciones_PG","VE_getListZip_PR",5);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,codigoPostalDireccionDTO.getCodigoZona());
			cat.debug("codigo zona:"  + codigoPostalDireccionDTO.getCodigoZona());
			cstmt.registerOutParameter(2,OracleTypes.CURSOR);
			cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);
			cat.debug("Execute Antes");
			cstmt.execute();
			cat.debug("Execute Despues");
			codError = cstmt.getInt(3);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(4);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(5);
			cat.debug("numEvento[" + numEvento + "]");
			if (codError == 0) {
				cat.debug("Llenado codigos postales");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(2);
				while (rs.next()) {
					DatosDireccionDTO datosDireccionDTO = new DatosDireccionDTO();
					datosDireccionDTO.setCodigo(rs.getString(1));
					datosDireccionDTO.setDescripcion(rs.getString(1));
					lista.add(datosDireccionDTO);
				}
				codigoPostalDireccionDTO.setDatosDireccionDTO((DatosDireccionDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
						lista.toArray(), DatosDireccionDTO.class));				
				cat.debug("Fin Llenado Codigos Postales");
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al consultar los codigos postales",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new CustomerDomainException(
					"Ocurrió un error al consultar las codigos postales",e);
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

		cat.debug("getListadoCodigosPostales():end");

		return codigoPostalDireccionDTO;
	}
	
}


