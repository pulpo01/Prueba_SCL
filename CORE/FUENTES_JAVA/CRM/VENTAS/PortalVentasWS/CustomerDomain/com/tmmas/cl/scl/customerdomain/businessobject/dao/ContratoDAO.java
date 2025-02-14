/**
 * Copyright © 2007 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 27/02/2007     H&eacute;ctor Hermosilla      					Versión Inicial
 */
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
import com.tmmas.cl.scl.crmcommon.commonapp.dto.DatosValidacionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.TipoContratoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.ContratoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.helper.Global;

public class ContratoDAO extends ConnectionDAO {
	private static Category cat = Category.getInstance(ContratoDAO.class);

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
		

	
	public DatosValidacionDTO getValidaNuevoContratoCliente(ContratoDTO contrato)
		throws CustomerDomainException
	{
		DatosValidacionDTO resultado = new DatosValidacionDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:getValidaContratoCliente");

			String call = getSQLPackage("VE_validacion_linea_PG","VE_existe_contrato_PR",5);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,contrato.getNumeroContrato());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getValidaContratoCliente:execute");
			cstmt.execute();
			cat.debug("Fin:getValidaContratoCliente:execute");

			msgError = cstmt.getString(4);
			cat.debug("msgError[" + msgError + "]");
		
			resultado.setExisteContrato(cstmt.getInt(2));
			
		} catch (Exception e) {
			cat.error("Ocurrió un error al verificar el Número de Contrato",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
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
		cat.debug("Fin:getValidaContratoCliente()");

		return resultado;
	}//fin getValidaClienteAgenteComercial
	
	public ContratoDTO[] getListadoTipoContrato(ContratoDTO contrato)
		throws CustomerDomainException
	{
		cat.debug("getListadoTipoContrato:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ContratoDTO[] resultado = null;
		Connection conn = null;
		CallableStatement cstmt=null;
		conn = getConection();
		ResultSet rs = null;
		if (cat.isDebugEnabled())
			cat.debug("Coneccion obtenida OK");
		try {
			String call = getSQLPackage("VE_PARAMETROS_COMERCIALES_PG","VE_tipocontrato_PR",10);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,contrato.getNombreUsuario());
			cstmt.setInt(2,contrato.getCodigoProducto());
			cstmt.setString(3,contrato.getIndContCel());
			cstmt.setString(4,contrato.getIndContSeg());
			cstmt.setString(5,contrato.getDatosPrograma().getCodigoPrograma());
			cstmt.setInt(6,contrato.getDatosPrograma().getNumeroVersion());
			cstmt.registerOutParameter(7,OracleTypes.CURSOR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);
			if (cat.isDebugEnabled())
				cat.debug("Execute Antes");
			cstmt.execute();
			if (cat.isDebugEnabled())
				cat.debug("Execute Despues");
			codError = cstmt.getInt(8);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(9);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(10);
			cat.debug("numEvento[" + numEvento + "]");
			if (codError != 0) {
				cat.error("Ocurrió un error al consultar el tipo de contrato");
				throw new CustomerDomainException("Ocurrió un error al consultar el tipo de contrato", String
								.valueOf(codError), numEvento, msgError);
				
			}else{
				if (cat.isDebugEnabled())
					cat.debug("Llenado Tipo de Contrato");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(7);
				while (rs.next()) {
					ContratoDTO tipoContrato = new ContratoDTO();
					tipoContrato.setCodigoTipoContrato(rs.getString(1));
					tipoContrato.setDescripcionTipoContrato(rs.getString(2));
					lista.add(tipoContrato);
				}				
				resultado =(ContratoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), ContratoDTO.class);
				if (cat.isDebugEnabled())
					cat.debug("Fin Llenado Tipo de Contrato");
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al consultar el tipo de contrato",e);
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

		cat.debug("getListadoTipoContrato():end");

		return resultado;
	}
	
	public ContratoDTO getListadoNumeroMesesContrato(ContratoDTO contrato)
		throws CustomerDomainException
	{	
		cat.debug("getListadoNumeroMesesContrato:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		
		ContratoDTO resultado = new ContratoDTO();
		Connection conn = null;
		CallableStatement cstmt=null;
		conn = getConection();
		ResultSet rs = null;
		if (cat.isDebugEnabled())
			cat.debug("Coneccion obtenida OK");
		try {
			String call = getSQLPackage("VE_PARAMETROS_COMERCIALES_PG","VE_nromesescontrato_PR",6);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,contrato.getCodigoTipoContrato());
			cstmt.setInt(2,contrato.getCodigoProducto());
			cstmt.registerOutParameter(3,OracleTypes.CURSOR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			if (cat.isDebugEnabled())
				cat.debug("Execute Antes");
			cstmt.execute();
			if (cat.isDebugEnabled())
				cat.debug("Execute Despues");
			codError = cstmt.getInt(4);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(5);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(6);
			cat.debug("numEvento[" + numEvento + "]");
			if (codError != 0) {
				cat.error("Ocurrió un error al consultar Número de Meses");
				throw new CustomerDomainException(
						"Ocurrió un error al consultar Número de Meses", String
								.valueOf(codError), numEvento, msgError);
				
			}else{
				if (cat.isDebugEnabled())
					cat.debug("Llenado Tipo de Contrato");
				rs = (ResultSet) cstmt.getObject(3);
				ArrayList lista = new ArrayList();
				while (rs.next()) {
					lista.add(rs.getString(2));
					cat.debug("TipoContrato"+ rs.getString(1));
				}				
				resultado.setNumeroMesesContrato(lista);
				if (cat.isDebugEnabled())
					cat.debug("Fin Llenado Tipo de Contrato");
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al consultar el tipo de contrato",e);
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

		cat.debug("getListadoNumeroMesesContrato():end");

		return resultado;
		
		
	}
	
	/**
	 * Consulta tipo contrato
	 * @param contrato
	 * @return contrato
	 * @throws CustomerDomainException
	 */
	public ContratoDTO getTipoContrato(ContratoDTO contrato)
		throws CustomerDomainException
	{		
		cat.debug("getTipoContrato:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt=null;
		conn = getConection();
		if (cat.isDebugEnabled())
			cat.debug("Coneccion obtenida OK");
		try {
			String call = getSQLPackage("Ve_Servicios_Venta_Pg","VE_con_tipocontrato_PR",7);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setInt(1,contrato.getCodigoProducto());
			cstmt.setString(2,contrato.getCodigoTipoContrato());
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			if (cat.isDebugEnabled())
				cat.debug("Execute Antes");
			cstmt.execute();
			if (cat.isDebugEnabled())
				cat.debug("Execute Despues");
			codError = cstmt.getInt(5);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(6);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(7);
			cat.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				cat.error("Ocurrió un error al consultar el tipo de contrato");
				throw new CustomerDomainException(
						"Ocurrió un error al consultar el tipo de contrato", String
								.valueOf(codError), numEvento, msgError);
				
			}else
				contrato.setDescripcionTipoContrato(cstmt.getString(3)); 
				contrato.setIndComodato(cstmt.getInt(4));
			
			
			
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al consultar el tipo de contrato",e);
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

		cat.debug("getTipoContrato():end");

		return contrato;
		
		
	}
	
	
	/**
	 * inserta contrato
	 * @param entrada
	 * @return
	 * @throws CustomerDomainException
	 */
	
	public void altaContrato(ContratoDTO entrada)
		throws CustomerDomainException
	{		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			cat.debug("Inicio:altaContrato()");
			
			String call = getSQLPackage("Ve_Servicios_Venta_Pg","VE_inserta_contrato_PR",11);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,entrada.getCodigoCuenta());
			cat.debug("entrada.getCodigoCuenta(): " + entrada.getCodigoCuenta());
			cstmt.setInt(2,entrada.getCodigoProducto());
			cat.debug("entrada.getCodigoProducto(): " + entrada.getCodigoProducto());
			cstmt.setString(3,entrada.getCodigoTipoContrato());
			cat.debug("entrada.getCodigoTipoContrato(): " + entrada.getCodigoTipoContrato());
			cstmt.setString(4,entrada.getNumeroContrato());
			cat.debug("entrada.getNumeroContrato(): " + entrada.getNumeroContrato());
			cstmt.setString(5,entrada.getNumeroAnexo());
			cat.debug("entrada.getNumeroAnexo(): " + entrada.getNumeroAnexo());
			cstmt.setInt(6,entrada.getNumeroMeses());
			cat.debug("entrada.getNumeroMeses(): " + entrada.getNumeroMeses());
			cstmt.setLong(7,entrada.getNumeroVenta());
			cat.debug("entrada.getNumeroVenta(): " + entrada.getNumeroVenta());
			cstmt.setInt(8,entrada.getNumeroAbonados());
			cat.debug("entrada.getNumeroAbonados(): " + entrada.getNumeroAbonados());
			
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:altaContrato:execute");
			cstmt.execute();
			cat.debug("Fin:altaContrato:execute");
			codError=cstmt.getInt(9);
			msgError = cstmt.getString(10);
			numEvento=cstmt.getInt(11);
			cat.debug("msgError[" + msgError + "]");
			
			if (codError != 0) {
				cat.error("Ocurrió un error al insertar en tabla GA_CONTCTA");
				throw new CustomerDomainException(
						"Ocurrió un error al insertar en tabla GA_CONTCTA", String
								.valueOf(codError), numEvento, msgError);
			}		
		} catch (Exception e) {
			cat.error("Ocurrió un error al insertar en tabla GA_CONTCTA",e);
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

		cat.debug("Fin:altaContrato()");

		
	}
	
	/**
	 * Busca el mayor numero de anexo asociado al contrato
	 * @param entrada
	 * @return
	 * @throws CustomerDomainException
	 */
    public ContratoDTO getMaxAnexoContrato(ContratoDTO contrato) 
    	throws CustomerDomainException
    {		
		cat.debug("getMaxAnexoContrato:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt=null;
		conn = getConection();
		if (cat.isDebugEnabled())
			cat.debug("Coneccion obtenida OK");
		try {
			String call = getSQLPackage("Ve_Servicios_Venta_Pg","VE_con_max_anexo_contrato_PR",8);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,contrato.getCodigoCuenta());
			cstmt.setInt(2,contrato.getCodigoProducto());
			cstmt.setString(3,contrato.getCodigoTipoContrato());
			cstmt.setString(4,contrato.getNumeroContrato());
			cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			if (cat.isDebugEnabled())
				cat.debug("Execute Antes");
			cstmt.execute();
			if (cat.isDebugEnabled())
				cat.debug("Execute Despues");
			codError = cstmt.getInt(6);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(7);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(8);
			cat.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				cat.error("Ocurrió un error al consultar el máximo anexo del contrato");
				throw new CustomerDomainException(
						"Ocurrió un error al consultar el máximo anexo del contrato", String
								.valueOf(codError), numEvento, msgError);
				
			}else
				contrato.setNumeroAnexo(String.valueOf(cstmt.getInt(5)));
			
			
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al consultar el máximo anexo del contrato",e);
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

		cat.debug("getMaxAnexoContrato():end");

		return contrato;
		
		
	}
    
    
    
    public ContratoDTO getNroMesesContrato(ContratoDTO contrato) 
		throws CustomerDomainException
	{
    	cat.debug("getNroMesesContrato:start");
		ContratoDTO resultado = new ContratoDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			String call = getSQLPackage("VE_SERVS_ACTIVACIONESWEB_PG","VE_getNumMesesTipContrato_PR",5);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,contrato.getCodigoTipoContrato());			
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);			
			cstmt.execute();			
			
			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			cat.debug("msgError[" + msgError + "]");			
						
			resultado.setNumeroMeses(Integer.parseInt(cstmt.getString(2)));
			
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
	    	if (cstmt!=null)
				cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				cat.debug("SQLException", e);
		  }
		}
	
		cat.debug("obtieneHomeLinea:end");
	
		return resultado;
	}
	
    public TipoContratoDTO[] getTipoContrato() 
    	throws CustomerDomainException
    {		
		cat.debug("getTipoContrato:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		TipoContratoDTO[] resultado = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		ResultSet rs = null;
		cat.debug("Coneccion obtenida OK");
		try {
			String call = getSQLPackage("VE_SERVS_ACTIVACIONESWEB_PG","VE_getTipContrato_PR",4);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.registerOutParameter(1, OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cat.debug("Execute Antes");
			cstmt.execute();
			cat.debug("Execute Despues");
			codError = cstmt.getInt(2);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(3);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(4);
			cat.debug("numEvento[" + numEvento + "]");
			if (codError != 0) {
				cat.error("Ocurrió un error al consultar Número de Cuotas");
				throw new CustomerDomainException(
						"Ocurrió un error al consultar Número de Cuotas", String
								.valueOf(codError), numEvento, msgError);
				
			}else{
				cat.debug("Llenado Numero de Cuotas");
				rs = (ResultSet) cstmt.getObject(1);
				ArrayList lista = new ArrayList();
				while (rs.next()) {
					cat.debug("Procesando iteración :" + lista.size());
					TipoContratoDTO contratos = new TipoContratoDTO();
					contratos.setCodContrato(rs.getString(1));
					contratos.setDesContrato(rs.getString(2));
					contratos.setCanalVenta(rs.getString(3));
					contratos.setCantMeses(rs.getString(4));
					lista.add(contratos);
				}
				rs.close();
				resultado =(TipoContratoDTO[])ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), 
						TipoContratoDTO.class);;
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al consultar los tipos de contratos",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException ){ 
                throw (CustomerDomainException) e;
			}else {
				CustomerDomainException c = new CustomerDomainException();
				c.setMessage(e.getMessage());  
				throw c;
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

		cat.debug("getListadoNumeroCuotas():end");

		return resultado;
	}
}





