package com.tmmas.cl.scl.gestiondeclientes.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.RoamingInDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.RoamingOUTDTO;
import com.tmmas.cl.scl.gestiondeclietnes.businessobject.helper.Global;

public class TasacionDAO extends ConnectionDAO{
	private Logger  logger = Logger.getLogger(this.getClass());
	Global global = Global.getInstance();
	
	
	private String getSQLgetDetalleUltimaLlamadasRomingTOL(){
		StringBuffer call =new StringBuffer();
		call.append("BEGIN	 " +
						"tol_portabilidad_pg.tol_rec_trafico_roaming_pr(?,?,?,?,?,? ); " +
					"END;");

		return call.toString();
	}
	
	
	public RoamingOUTDTO getDetalleUltimaLlamadasRomingTOL(RoamingInDTO rommingDTO)throws GeneralException {
		RoamingOUTDTO retValue=new RoamingOUTDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt=null;
		try{
			logger.debug("Inicio getDetalleLlamadasRomingTOL");
			conn= getConnectionFromWLSInitialContext(global.getJndiForDataSourceTOL());
			String call = getSQLgetDetalleUltimaLlamadasRomingTOL();
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
	
			cstmt.setString(1,rommingDTO.getNumCelular());
			logger.debug("rommingDTO.getNumCelular() ["+rommingDTO.getNumCelular()+"]");
			cstmt.setLong(2,rommingDTO.getDias());
			logger.debug("rommingDTO.getDias() ["+rommingDTO.getDias()+"]");
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			
			logger.debug("Inicio:getDetalleLlamadasRomingTOL:execute");
			cstmt.execute();
			logger.debug("Fin:getDetalleLlamadasRomingTOL:execute");
	
			codError=cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento=cstmt.getInt(5);
	
			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error("Ocurrió un error al getDetalleLlamadasRomingTOL");
				throw new GeneralException("Ocurrió un error al getDetalleLlamadasRomingTOL", String.valueOf(codError), numEvento, msgError);
			}else {
				retValue.setFechaLlamada(cstmt.getString(3));
				retValue.setDetalle(cstmt.getString(4));
				retValue.setCodError(String.valueOf(cstmt.getInt(5)));
				retValue.setMensajseError(cstmt.getString(6));
			}
		} catch (GeneralException e) {
				throw e;
		} catch (Exception e) {
			logger.error("Ocurrió un error al getDetalleLlamadasRomingTOL",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al getDetalleLlamadasRomingTOL",e);
		} finally {
				logger.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				logger.debug("SQLException", e);
		  }
		}
		logger.debug("fin getDetalleLlamadasRomingTOL");
		return retValue;
	}
}
