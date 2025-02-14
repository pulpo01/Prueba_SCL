/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 06/06/2007	     	Elizabeth Vera        				Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.businessObject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces.PromocionDAOIT;
import com.tmmas.scl.framework.productDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.productDomain.dataTransferObject.EliminaPromocionDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductPromotionException;

public class PromocionDAO extends ConnectionDAO implements PromocionDAOIT {

	private final Logger logger = Logger.getLogger(PromocionDAO.class);

	private final Global global = Global.getInstance();
	
	private String getSQLeliminarPromocion() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   eo_promocion PV_GA_PROMOC_QT:= PV_INICIA_ESTRUCTURAS_PG.PV_GA_PROMOC_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_promocion.SV_COMBINATORIA := ?;");
		call.append("   eo_promocion.NUM_ABONADO := ?;");
		call.append("   eo_promocion.SN_APLICA := ?;");
		call.append("   eo_promocion.SV_MSG := ?;");
		call.append("   PV_PROMOCION_PG.PV_ELIMINAR_PROMOCION_PR( eo_promocion, ?, ?, ?);");
		call.append(" END;");
		return call.toString();
	}
	
	/**
	 * Elimina promocion
	 * 
	 * @param param
	 * @return RetornoDTO
	 * @throws ProductPromotionException
	 */	
	public RetornoDTO eliminarPromocion(EliminaPromocionDTO param)
			throws ProductPromotionException {
		logger.debug("eliminarPromocion():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLeliminarPromocion();
		try {
		
			logger.debug("param.getNumAbonado()[" + param.getNumAbonado() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSourceSCL());
			
			cstmt = conn.prepareCall(call);
			cstmt.setString(1, param.getSvCombinatoria());
			cstmt.setLong(2, param.getNumAbonado());
			cstmt.setInt(3, (param.isFlgAplica()?1:0));
			cstmt.setString(4,param.getSvMensaje());
			
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);			
		
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(5);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(6);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(7);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al eliminar promoción");
				throw new ProductPromotionException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			retorno = new RetornoDTO();
			retorno.setDescripcion(msgError);
		
		} catch (ProductPromotionException e) {
			logger.debug("ProductPromotionException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al eliminar promoción", e);
			throw new ProductPromotionException("Ocurrió un error general al eliminar promoción",e);
		}
		finally {
			try {
				if (cstmt != null) {
					cstmt.close();
					cstmt = null;
				}
				if (conn != null) {
					if (!conn.isClosed()) {
						conn.close();
					}
					conn = null;
				}
			} catch (SQLException e) {
				cstmt = null;
				conn = null;
				logger.debug("SQLException[" + e + "]");
			}
		}
		logger.debug("eliminarPromocion():end");
		return retorno;
	}

}
