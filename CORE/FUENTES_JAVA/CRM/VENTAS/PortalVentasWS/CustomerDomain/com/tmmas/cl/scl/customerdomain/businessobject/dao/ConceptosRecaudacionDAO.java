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
import com.tmmas.cl.scl.customerdomain.businessobject.dto.ConceptosRecaudacionDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.helper.Global;

public class ConceptosRecaudacionDAO extends ConnectionDAO{

	private static Category cat = Category.getInstance(ConceptosRecaudacionDAO.class);
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
	
	private String getSQLPackage(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
        for (int n = 1; n <= paramCount; n++) {
            sb.append("?");
            if (n < paramCount) sb.append(",");
        }
        return sb.append(")}").toString();
	
	}//fin getSQLPackage

	/**
	 * Obtiene listado de bancos 
	 * @param entrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public ConceptosRecaudacionDTO[] getListBancosPAC(ConceptosRecaudacionDTO entrada) 
		throws CustomerDomainException
	{
		cat.debug("Inicio:getListBancosPAC()");
		ConceptosRecaudacionDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		ResultSet rs = null;
		try {
			String call = getSQLPackage("VE_alta_cliente_PG","VE_getListBancosPAC_PR",5);

			cat.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setInt(1,entrada.getIndicadorPAC());
			cstmt.registerOutParameter(2,OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getListBancosPAC:execute");
			cstmt.execute();
			cat.debug("Fin:getListBancosPAC:execute");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar bancos");
				throw new CustomerDomainException(
						"Ocurrió un error al recuperar bancos", String
								.valueOf(codError), numEvento, msgError);
			}else{
				cat.debug("Recuperando bancos");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(2);
				while (rs.next()) {
					ConceptosRecaudacionDTO conceptosRecaudacionDTO = new ConceptosRecaudacionDTO();
					conceptosRecaudacionDTO.setCodigoBanco(rs.getString(1));
					conceptosRecaudacionDTO.setDescripcionBanco(rs.getString(2));
					lista.add(conceptosRecaudacionDTO);
				}				
				resultado =(ConceptosRecaudacionDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), ConceptosRecaudacionDTO.class);
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar bancos",e);
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
		cat.debug("Fin:getListBancosPAC()");
		return resultado;
	}//fin getListBancosPAC
	
	/**
	 * Obtiene sucursales del banco 
	 * @param entrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public ConceptosRecaudacionDTO[] getListSucursalesBancos(ConceptosRecaudacionDTO entrada) 
		throws CustomerDomainException
	{
		cat.debug("Inicio:getListSucursalesBancos()");
		ConceptosRecaudacionDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		ResultSet rs = null;
		try {
			String call = getSQLPackage("VE_alta_cliente_PG","VE_getListSucursalesBanco_PR",5);

			cat.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,entrada.getCodigoBanco());
			cstmt.registerOutParameter(2,OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getListSucursalesBancos:execute");
			cstmt.execute();
			cat.debug("Fin:getListSucursalesBancos:execute");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar sucursales del banco");
				throw new CustomerDomainException(
						"Ocurrió un error al recuperar sucursales del banco", String
								.valueOf(codError), numEvento, msgError);
			}else{
				cat.debug("Recuperando sucursales del banco");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(2);
				while (rs.next()) {
					ConceptosRecaudacionDTO conceptosRecaudacionDTO = new ConceptosRecaudacionDTO();
					conceptosRecaudacionDTO.setCodigoSucursalBanco(rs.getString(1));
					conceptosRecaudacionDTO.setDescripcionSucursalBanco(rs.getString(2));
					lista.add(conceptosRecaudacionDTO);
				}				
				resultado =(ConceptosRecaudacionDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), ConceptosRecaudacionDTO.class);
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar sucursales del banco",e);
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
		cat.debug("Fin:getListSucursalesBancos()");
		return resultado;
	}//fin getListSucursalesBancos
	
	/**
	 * Obtiene listado de tarjetas 
	 * @param N/A
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public ConceptosRecaudacionDTO[] getListTarjetas() 
		throws CustomerDomainException
	{
		cat.debug("Inicio:getListTarjetas()");
		ConceptosRecaudacionDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		ResultSet rs = null;
		try {
			String call = getSQLPackage("VE_alta_cliente_PG","VE_getListTarjetas_PR",4);

			cat.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			cstmt.registerOutParameter(1,OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getListTarjetas:execute");
			cstmt.execute();
			cat.debug("Fin:getListTarjetas:execute");

			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);
			
			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar tarjetas");
				throw new CustomerDomainException(
						"Ocurrió un error al recuperar tarjetas", String
								.valueOf(codError), numEvento, msgError);
			}else{
				cat.debug("Recuperando tarjetas");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(1);
				while (rs.next()) {
					ConceptosRecaudacionDTO conceptosRecaudacionDTO = new ConceptosRecaudacionDTO();
					conceptosRecaudacionDTO.setCodigoTarjeta(rs.getString(1));
					conceptosRecaudacionDTO.setDescripcionTarjeta(rs.getString(2));
					lista.add(conceptosRecaudacionDTO);
				}				
				resultado =(ConceptosRecaudacionDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), ConceptosRecaudacionDTO.class);
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar tarjetas",e);
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
		cat.debug("Fin:getListTarjetas()");
		return resultado;
	}//fin getListTarjetas

	/**
	 * Obtiene modalidades de pago 
	 * @param entrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public ConceptosRecaudacionDTO[] getListModalidadPago(ConceptosRecaudacionDTO entrada) 
		throws CustomerDomainException
	{
		cat.debug("Inicio:getListModalidadPago()");
		ConceptosRecaudacionDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		ResultSet rs = null;
		try {
			String call = getSQLPackage("VE_alta_cliente_PG","VE_getListModalidadPago_PR",5);

			cat.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setInt(1,entrada.getIndicadorManual());
			cstmt.registerOutParameter(2,OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getListModalidadPago:execute");
			cstmt.execute();
			cat.debug("Fin:getListModalidadPago:execute");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar modalidad de pago");
				throw new CustomerDomainException(
						"Ocurrió un error al recuperar modalidad de pago", String
								.valueOf(codError), numEvento, msgError);
			}else{
				cat.debug("Recuperando modalidad de pago");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(2);
				while (rs.next()) {
					ConceptosRecaudacionDTO conceptosRecaudacionDTO = new ConceptosRecaudacionDTO();
					conceptosRecaudacionDTO.setCodigoModPago(rs.getInt(1));
					conceptosRecaudacionDTO.setDescripcionModPago(rs.getString(2));
					lista.add(conceptosRecaudacionDTO);
				}				
				resultado =(ConceptosRecaudacionDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), ConceptosRecaudacionDTO.class);
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar modalidad de pago",e);
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
		cat.debug("Fin:getListModalidadPago()");
		return resultado;
	}//fin getListModalidadPago

}//fin class ConceptosRecaudacionDAO 
