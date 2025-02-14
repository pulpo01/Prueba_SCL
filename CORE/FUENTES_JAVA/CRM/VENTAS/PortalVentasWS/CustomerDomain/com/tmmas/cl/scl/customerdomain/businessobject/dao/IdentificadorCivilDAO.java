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
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.IdentificadorCivilDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.helper.Global;

public class IdentificadorCivilDAO extends ConnectionDAO{
	private static Category cat = Category.getInstance(IdentificadorCivilDAO.class);

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
	 * Obtiene listado tipos de identificadores
	 * @param N/A
	 * @return IdentificadorCivilDTO[]
	 * @throws CustomerDomainException
	 */
	public IdentificadorCivilDTO[] getListTiposIdentif() 
		throws CustomerDomainException
	{
		cat.debug("Inicio:getListTiposIdentif()");
		IdentificadorCivilDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();
		ResultSet rs = null;
		try {
			String call = getSQLDatos("VE_alta_cliente_PG","VE_getListTiposIdentif_PR",4);

			cat.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			cstmt.registerOutParameter(1,OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getListTiposIdentif:execute");
			cstmt.execute();
			cat.debug("Fin:getListTiposIdentif:execute");

			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);
			
			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar tipos de identificadores");
				throw new CustomerDomainException(
						"Ocurrió un error al recuperar tipos de identificadores", String
								.valueOf(codError), numEvento, msgError);
			}else{
				cat.debug("Recuperando tipos de identificadores");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(1);
				while (rs.next()) {
					IdentificadorCivilDTO identificadorDTO = new IdentificadorCivilDTO();
					identificadorDTO.setCodigoTipIdentif(rs.getString(1));
					identificadorDTO.setDescripcionTipIdentif(rs.getString(2));
					identificadorDTO.setIndicadorPertrib(rs.getString(3));
					identificadorDTO.setIndicadorSalefact(rs.getInt(4));
					
					lista.add(identificadorDTO);
				}				
				resultado =(IdentificadorCivilDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), IdentificadorCivilDTO.class);
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar tipos de identificadores",e);
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
		cat.debug("Fin:getListTiposIdentif()");
		return resultado;
	}//fin getListTiposIdentif	
	
	
}//fin class IdentificadorCivilDAO
