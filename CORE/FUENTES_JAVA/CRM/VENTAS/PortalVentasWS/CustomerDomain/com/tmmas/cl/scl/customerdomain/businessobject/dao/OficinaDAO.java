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
import com.tmmas.cl.scl.customerdomain.businessobject.dto.OficinaDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.helper.Global;

public class OficinaDAO extends ConnectionDAO{
	
	private static Category cat = Category.getInstance(OficinaDAO.class);

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
	
	private String getSQLDatosOficina(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
        for (int n = 1; n <= paramCount; n++) {
            sb.append("?");
            if (n < paramCount) sb.append(",");
        }
        return sb.append(")}").toString();
	}//fin getSQLDatosPlanOficina

	/**
	 * Obtiene oficinas SCL 
	 * @param entrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public OficinaDTO[] getListOficinasSCL(String nombreUsuario) 
		throws CustomerDomainException
	{
		cat.debug("Inicio:getListOficinasSCL()");
		OficinaDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		ResultSet rs = null;
		try {
			String call = getSQLDatosOficina("VE_alta_cliente_PG","VE_getListOficinasSCL_PR",5);

			cat.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			//Inicio P-CSR-11002 JLGN 10-10-2011
			cstmt.setString(1,nombreUsuario);
			cat.debug("nombreUsuario: "+nombreUsuario);
			cstmt.registerOutParameter(2,OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getListOficinasSCL:execute");
			cstmt.execute();
			cat.debug("Fin:getListOficinasSCL:execute");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar oficinas de SCL");
				throw new CustomerDomainException(
						"Ocurrió un error al recuperar oficinas de SCL", String
								.valueOf(codError), numEvento, msgError);
			}else{
				cat.debug("Recuperando oficinas de SCL");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(2);
				while (rs.next()) {
					OficinaDTO oficinaDTO = new OficinaDTO();
					oficinaDTO.setCodigoOficina(rs.getString(1));
					oficinaDTO.setDescripcionOficina(rs.getString(2));
					
					lista.add(oficinaDTO);
				}				
				resultado =(OficinaDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), OficinaDTO.class);
				
				cat.debug("oficinas SCL");
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar oficinas de SCL",e);
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
		cat.debug("Fin:getListOficinasSCL()");
		return resultado;
	}//fin getListOficinasSCL
	
	
	public OficinaDTO getDireccionOficina(String codOficina)
		throws CustomerDomainException
	{
		cat.debug("Inicio:getDireccionOficina()");
		OficinaDTO resultado = new OficinaDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		ResultSet rs = null;
		try {
			String call = getSQLDatosOficina("VE_servicios_venta_PG","VE_ObtieneDirOficina_PR",7);

			cat.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,codOficina);
			cat.debug("Codigo oficina:" + codOficina);
			
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);			
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
						
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getDireccionOficina:execute");
			cstmt.execute();
			cat.debug("Fin:getDireccionOficina:execute");

			codError = cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento = cstmt.getInt(7);
			
			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar datos de oficina");
				throw new CustomerDomainException(
						"Ocurrió un error al recuperar datos de oficina", String
								.valueOf(codError), numEvento, msgError);
			}else{
				cat.debug("Recuperando datos oficina");
				resultado.setCodigoRegion(cstmt.getString(2));
				resultado.setCodigoProvincia(cstmt.getString(3));
				resultado.setCodigoCiudad(cstmt.getString(4));				
				cat.debug("oficinas SCL");
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar datos de oficina",e);
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
		cat.debug("Fin:getListOficinasSCL()");
		return resultado;
	}//fin getDireccionOficina
	
}//fin class OficinaDAO
