package com.tmmas.cl.scl.gestiondeclientes.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.OficinaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.VendedorDTO;
import com.tmmas.cl.scl.gestiondeclietnes.businessobject.helper.Global;


public class OficinaDAO extends ConnectionDAO{
	
	private final Logger logger = Logger.getLogger(OficinaDAO.class);

	Global global = Global.getInstance();
	
	private Connection getConection() throws GeneralException
	{
		Connection conn = null;
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
		} catch (Exception e1) {
			conn = null;
			logger.error(" No se pudo obtener una conexión ", e1);
			throw new GeneralException("No se pudo obtener una conexión", e1);
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
	 * @throws GeneralException
	 */
	public OficinaDTO[] getListOficinasSCL() 
	throws GeneralException{
		logger.debug("Inicio:getListOficinasSCL()");
		OficinaDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			//INI-01 (AL) String call = getSQLDatosOficina("VE_alta_cliente_PG","VE_getListOficinasSCL_PR",4);
			String call = getSQLDatosOficina("VE_alta_cliente_Quiosco_PG","VE_getListOficinasSCL_PR",4);
			logger.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			cstmt.registerOutParameter(1,OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getListOficinasSCL:execute");
			cstmt.execute();
			logger.debug("Fin:getListOficinasSCL:execute");

			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);
			
			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error("Ocurrió un error al recuperar oficinas de SCL");
				throw new GeneralException(
						"Ocurrió un error al recuperar oficinas de SCL", String
								.valueOf(codError), numEvento, msgError);
			}else{
				logger.debug("Recuperando oficinas de SCL");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(1);
				while (rs.next()) {
					OficinaDTO oficinaDTO = new OficinaDTO();
					oficinaDTO.setCodigoOficina(rs.getString(1));
					oficinaDTO.setDescripcionOficina(rs.getString(2));
					
					lista.add(oficinaDTO);
				}
				rs.close();
				resultado =(OficinaDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), OficinaDTO.class);
				
				logger.debug("oficinas SCL");
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		}  catch (GeneralException e) {
			throw e;
		}  catch (Exception e) {
			logger.error("Ocurrió un error al recuperar oficinas de SCL",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
		 	if (logger.isDebugEnabled()) 
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:getListOficinasSCL()");
		return resultado;
	}//fin getListOficinasSCL
	
	
	/**
	 * @author Héctor Hermosilla
	 * 
	 * Obtiene datos de la oficina
	 * @param oficinaDTO
	 * @return resultado
	 * @throws GeneralException
	 */	
	public OficinaDTO getOficina(OficinaDTO oficinaDTO)throws GeneralException{
		logger.debug("getOficina:inicio");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		logger.debug("Coneccion obtenida OK");
		CallableStatement cstmt = null;
		OficinaDTO resultado = null;
		try {
			//INI-01 (AL) String call = getSQLDatosOficina("VE_parametros_comerciales_PG","VE_con_oficina_PR",12);
			String call = getSQLDatosOficina("VE_parametros_comer_quiosco_PG","VE_con_oficina_PR",12);
			logger.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			/*-- entrada --*/
			cstmt.setString(1,oficinaDTO.getCodigoOficina());
			/*-- salida --*/
			cstmt.registerOutParameter(2,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(11,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(12,java.sql.Types.NUMERIC);
			
			logger.debug("getOficina:Execute Antes");
			cstmt.execute();
			logger.debug("getOficina:Execute Despues");
			
			codError = cstmt.getInt(10);
			msgError = cstmt.getString(11);
			numEvento = cstmt.getInt(12);
			
			logger.debug("codError[" + codError + "]");
			logger.debug("msgError[" + msgError + "]");
			logger.debug("numEvento[" + numEvento + "]");

			if (codError == 0){ 
				resultado = new OficinaDTO();
				resultado.setDescripcionOficina(cstmt.getString(2));
				resultado.setCodigoDireccion(cstmt.getString(3));
				resultado.setRegion(cstmt.getString(4));
				resultado.setProvincia(cstmt.getString(5));
				resultado.setCiudad(cstmt.getString(6));
				resultado.setCodigoRegion(cstmt.getString(7));
				resultado.setCodigoProvincia(cstmt.getString(8));
				resultado.setCodigoCiudad(cstmt.getString(9));
			} else {
				logger.error("Ocurrió un error al obtener los datos de la oficina");
				throw new GeneralException(
						"Ocurrió un error al obtener los datos de la oficina", String
								.valueOf(codError), numEvento, msgError);			
			}

			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener los datos de la oficina",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
		 	if (logger.isDebugEnabled()) 
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("getOficina():end");
		return resultado;
	}//fin getOficina	
	
	public OficinaDTO[] getOficinasPorVendedor(VendedorDTO vendedorDTO)throws GeneralException{
		logger.debug("getOficina:inicio");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		logger.debug("Coneccion obtenida OK");
		CallableStatement cstmt = null;
		OficinaDTO[] resultado = null;
		try {
			String call = getSQLDatosOficina("GE_CONS_CATALOGO_PORTAB_PG","GE_REC_OFICINAS_X_VENDEDOR_PR",6);
			logger.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			/*-- entrada --*/
			cstmt.setString(1,vendedorDTO.getCodigoVendedor());
			cstmt.setString(2,vendedorDTO.isVendedorInterno()?"1":"0");
			/*-- salida --*/
			cstmt.registerOutParameter(3,OracleTypes.CURSOR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			
			logger.debug("getOficina:Execute Antes");
			cstmt.execute();
			logger.debug("getOficina:Execute Despues");
			
			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);
			
			logger.debug("codError[" + codError + "]");
			logger.debug("msgError[" + msgError + "]");
			logger.debug("numEvento[" + numEvento + "]");

			if (codError != 0) {
				logger.error("Ocurrió un error al recuperar getOficinasPorVendedor");
				throw new GeneralException(
						"Ocurrió un error al recuperar tipos getOficinasPorVendedor", String
								.valueOf(codError), numEvento, msgError);
			}else{
				logger.debug("Recuperando tipos");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(3);
				while (rs.next()) {
					OficinaDTO oficinaDTO = new OficinaDTO();
					oficinaDTO.setCodigoOficina(rs.getString(1));
					oficinaDTO.setDescripcionOficina(rs.getString(2));
					lista.add(oficinaDTO);
				}
				rs.close();
				resultado =(OficinaDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), OficinaDTO.class);
				
			}
			
			if (resultado.length < 1) {
				logger.error("No existen datos para el criterio de busqueda");
				throw new GeneralException(
						"No existen datos para el criterio de busqueda", String
								.valueOf(codError), numEvento, msgError);
			}

			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener los datos de la oficina",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
		} finally {
		 	if (logger.isDebugEnabled()) 
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("getOficina():end");
		return resultado;
	}//fin getOficina	
}//fin class OficinaDAO
