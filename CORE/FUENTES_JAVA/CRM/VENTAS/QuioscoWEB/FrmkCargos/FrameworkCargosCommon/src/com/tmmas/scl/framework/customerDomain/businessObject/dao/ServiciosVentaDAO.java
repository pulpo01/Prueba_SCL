package com.tmmas.scl.framework.customerDomain.businessObject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.customerDomain.businessObject.dao.interfaces.ServiciosVentaDAOIT;
import com.tmmas.scl.framework.customerDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.TipoComisionistaDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerBillException;
import com.tmmas.scl.framework.productDomain.dataTransferObject.VendedorDTO;


public class ServiciosVentaDAO extends ConnectionDAO implements ServiciosVentaDAOIT{
	private final Logger logger = Logger.getLogger(ServiciosVentaDAO.class);

	private final Global global = Global.getInstance();
	
	private String getSQLObtieneComisPorVendedor() {
		StringBuffer call = new StringBuffer();

		call.append(" DECLARE ");
		call.append("    SO_TIPCOMIS VE_TIPOS_PG.TIP_VE_TIPCOMIS; ");
		call.append(" BEGIN  ");
		call.append("   VE_SERVICIOS_VENTA_PG.VE_OBTIENECOMISPORCODVENDEDOR ( SO_TIPCOMIS, ?, ?, ?, ? ); ");
		call.append("    ?:=SO_TipComis(1).fec_ultmod; ");
		call.append("    ?:=SO_TipComis(1).ind_cliente; ");
		call.append("    ?:=SO_TipComis(1).ind_bodega; ");
		call.append("    ?:=SO_TipComis(1).ind_vta_externa; ");
		call.append("    ?:=SO_TipComis(1).ind_riesgo; ");
		call.append("    ?:=SO_TipComis(1).ind_privilegio; ");
		call.append("    ?:=SO_TipComis(1).cod_tipcomis; ");
		call.append("    ?:=SO_TipComis(1).des_tipcomis; ");
		call.append("    ?:=SO_TipComis(1).nom_usuario;");
		call.append(" END;");
		
		return call.toString();		
	}
	
public TipoComisionistaDTO ObtieneComisPorVendedor(VendedorDTO vendedorDTO) throws CustomerBillException{
		
		logger.debug("Inicio:registraCargo");
		
		TipoComisionistaDTO retValue;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		String call = null;
		
		try{
			
			call=getSQLObtieneComisPorVendedor();
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			cstmt = conn.prepareCall(call);
			cstmt.setInt(1,Integer.parseInt(vendedorDTO.getCodigoVendedor()));
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			
			cstmt.registerOutParameter(5, java.sql.Types.TIMESTAMP);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
			
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(2);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(3);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(4);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError!=0){
				throw new CustomerBillException(String.valueOf(codError),numEvento,msgError);
			}
			else{
				retValue=new TipoComisionistaDTO();
				retValue.setFec_ultmod(cstmt.getTimestamp(5));
				retValue.setInd_cliente(cstmt.getInt(6));
				retValue.setInd_bodega(cstmt.getInt(7));
				retValue.setIndExterno(cstmt.getString(8));
				retValue.setInd_riesgo(cstmt.getInt(9));
				retValue.setInd_privilegio(cstmt.getInt(10));
				retValue.setCodigoTipoComisionista(cstmt.getString(11));
				retValue.setDescripcionTipoComisionista(cstmt.getString(12));
				retValue.setNom_usuario(cstmt.getString(13));
			}
			
			
			
		} catch (CustomerBillException e) {
			logger.debug("CustomerBillException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al registrar cargos", e);
			throw new CustomerBillException("Ocurrió un error general al registrar cargos",e);
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
		logger.debug("registraCargo():end");
		return retValue;
	}
	
	
}
