package com.tmmas.cl.scl.customerdomain.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.ConceptosCobranzaDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.helper.Global;

public class ConceptosCobranzaDAO extends ConnectionDAO{

	private static Category cat = Category.getInstance(RegistroFacturacionDAO.class);
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
	 * Obtiene descripcion codigo 123
	 * @param parametroEntrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public ConceptosCobranzaDTO getDescripcion123(ConceptosCobranzaDTO parametroEntrada) 
		throws CustomerDomainException
	{
		ConceptosCobranzaDTO resultado=new ConceptosCobranzaDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:getDescripcion123");
			
			String call = getSQLPackage("CO_servicios_cobranza_PG","CO_getDescCodigo123_PR",5);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,parametroEntrada.getCodigo123());
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getDescripcion123:execute");
			cstmt.execute();
			cat.debug("Fin:getDescripcion123:execute");

			codError  = cstmt.getInt(3);
			msgError  = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			if (codError != 0){
				cat.error("Ocurrió un error al obtener descripcion codigo 123");
				throw new CustomerDomainException(
				"Ocurrió un error al obtener descripcion codigo 123", String
				.valueOf(codError), numEvento, msgError);
			}
			else{
				resultado.setDescripcion123(cstmt.getString(2));
			}
		
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener descripcion codigo 123",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
				cat.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				cat.debug("SQLException", e);
		  }
		}
		cat.debug("Fin:getDescripcion123");
		return resultado;
	}//fin getDescripcion123
	
    /**
	 * Obtiene descripcion codigo ABC
	 * @param parametroEntrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public ConceptosCobranzaDTO getDescripcionABC(ConceptosCobranzaDTO parametroEntrada) 
		throws CustomerDomainException
	{
		ConceptosCobranzaDTO resultado=new ConceptosCobranzaDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:getDescripcionABC");
			
			String call = getSQLPackage("CO_servicios_cobranza_PG","CO_getDescCodigoABC_PR",5);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,parametroEntrada.getCodigoABC());
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getDescripcionABC:execute");
			cstmt.execute();
			cat.debug("Fin:getDescripcionABC:execute");

			codError  = cstmt.getInt(3);
			msgError  = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			if (codError != 0){
				cat.error("Ocurrió un error al obtener descripcion codigo ABC");
				throw new CustomerDomainException(
				"Ocurrió un error al obtener descripcion codigo ABC", String
				.valueOf(codError), numEvento, msgError);
			}
			else{
				resultado.setDescripcion123(cstmt.getString(2));
			}
		
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener descripcion codigo ABC",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
				cat.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				cat.debug("SQLException", e);
		  }
		}
		cat.debug("Fin:getDescripcionABC");
		return resultado;
	}//fin getDescripcionABC

    /**
	 * Inserta pago automatico
	 * @param parametroEntrada
	 * @return N/A
	 * @throws CustomerDomainException
	 */
	public void insPagoAutomatico(ConceptosCobranzaDTO entrada) 
		throws CustomerDomainException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:insPagoAutomatico");
			
			String call = getSQLPackage("CO_servicios_cobranza_PG","CO_insPagoAutomatico_PR",9);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setString(1,entrada.getCodigoCliente());
			cat.debug("entrada.getCodigoCliente(): " + entrada.getCodigoCliente());
			cstmt.setString(2,entrada.getCodigoBanco());
			cat.debug("entrada.getCodigoBanco(): " + entrada.getCodigoBanco());
			cstmt.setString(3,entrada.getNumeroTelefono());
			cat.debug("entrada.getNumeroTelefono(): " + entrada.getNumeroTelefono());
			cstmt.setString(4,entrada.getCodigoZona());
			cat.debug("entrada.getCodigoZona(): " + entrada.getCodigoZona());
			cstmt.setString(5,entrada.getCodigoCentral());
			cat.debug("entrada.getCodigoCentral(): " + entrada.getCodigoCentral());
			cstmt.setString(6,entrada.getCodigoBcoi());
			cat.debug("entrada.getCodigoBcoi(): " + entrada.getCodigoBcoi());
			
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:insPagoAutomatico:execute");
			cstmt.execute();
			cat.debug("Fin:insPagoAutomatico:execute");

			codError  = cstmt.getInt(7);
			msgError  = cstmt.getString(8);
			numEvento = cstmt.getInt(9);
			
			if (codError != 0){
				cat.error("Ocurrió un error al insertar pago automatico");
				throw new CustomerDomainException(
				"Ocurrió un error al insertar pago automatico", String
				.valueOf(codError), numEvento, msgError);
			}

		} catch (Exception e) {
			cat.error("Ocurrió un error al insertar pago automatico",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new CustomerDomainException(
					"Ocurrió un error al insertar pago automatico", String
					.valueOf(codError), numEvento, msgError);
		} finally {
				cat.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				cat.debug("SQLException", e);
		  }
		}
		cat.debug("Fin:insPagoAutomatico");
	}//fin insPagoAutomatico

}//fin ConceptosCobranzaDAO
