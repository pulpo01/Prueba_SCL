package com.tmmas.cl.scl.gestiondedirecciones.businessobject.dao;

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
import com.tmmas.cl.scl.gestiondeabonados.businessobject.helper.Global;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.DatosDireccionDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.TipoCalleDireccionDTO;

public class TipoCalleDAO extends ConnectionDAO{

	private final Logger logger = Logger.getLogger(RegionDAO.class);
	
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
	
	public TipoCalleDireccionDTO getListadoTiposCalles() throws GeneralException
	{
		logger.debug("getListadoTiposCalles:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		TipoCalleDireccionDTO tipoCalleDireccionDTO = null;	
		conn = getConection();
		ResultSet rs = null;
		logger.debug("Coneccion obtenida OK");
		try {
			String call = getSQLPackage("VE_servicios_direcciones_PG","VE_getListTiposCalles_PR",4);
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			
			cstmt.registerOutParameter(1,OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			logger.debug("Execute Antes");
			cstmt.execute();
			logger.debug("Execute Despues");
			codError = cstmt.getInt(2);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(3);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(4);
			logger.debug("numEvento[" + numEvento + "]");
			if (codError == 0) {
				logger.debug("Llenado tipos de calles");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(1);
				while (rs.next()) {
					DatosDireccionDTO datosDireccionDTO = new DatosDireccionDTO();
					datosDireccionDTO.setCodigo(rs.getString(1));
					datosDireccionDTO.setDescripcion(rs.getString(2));
					lista.add(datosDireccionDTO);
				}
				tipoCalleDireccionDTO = new TipoCalleDireccionDTO();
				tipoCalleDireccionDTO.setDatosDireccionDTO((DatosDireccionDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
						lista.toArray(), DatosDireccionDTO.class));			
				
				logger.debug("Fin Llenado Tipos Calles");
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			logger.error("Ocurrió un error al consultar las tipos de calles",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al consultar los tipos de calles",e);
		} finally {
		 	if (logger.isDebugEnabled()) 
		 		logger.debug("Cerrando conexiones...");
			try {
				if (rs!=null)
					rs.close();
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
	
		logger.debug("getListadoTiposCalles():end");
	
		return tipoCalleDireccionDTO;
	}
}
