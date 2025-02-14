/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 16/10/2007           Raúl Lozano   						Versión Inicial                             
 **/
package com.tmmas.scl.framework.customerDomain.businessObject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.customerDomain.businessObject.dao.interfaces.AbonadoVetadoDAOIT;
import com.tmmas.scl.framework.customerDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.customerDomain.exception.CustomerException;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoVetadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoVetadoListDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;

public class AbonadoVetadoDAO extends ConnectionDAO implements AbonadoVetadoDAOIT {

	private final Logger logger = Logger.getLogger(AbonadoVetadoDAO.class);

	private final Global global = Global.getInstance();
	
	private String getSQLobtenerListaAbonadosVetados() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE"); 
		call.append("   EO_ABONADO_VETADO CU_VETADOS_PROD_QT:=CU_VETADOS_PROD_QT(null,null,null,null,null);");
		call.append(" BEGIN ");
		call.append("   EO_ABONADO_VETADO.COD_CLIENTE:=?;");
		call.append("   CU_VETADOS_PROD_PG.CU_VETADOS_S_PR ( EO_ABONADO_VETADO,?, ?,?,?);");
		call.append(" END; ");

		return call.toString();		
	}	

	private String getSQLobtenerListaAbonadosBeneficiariosPorNumCelular() {
		StringBuffer call = new StringBuffer();
		
		call.append(" DECLARE "); 
		call.append("   EN_NUMCELULAR NUMBER; ");
		call.append(" BEGIN  ");
		call.append("   EN_NUMCELULAR := ?; ");
		call.append("   CU_BENEF_PROD_PG.CU_BENEFICIA_S_PR ( EN_NUMCELULAR, ?, ?,?,? ); ");
		call.append(" END; ");
		
		return call.toString();		
	}
	
	private String getSQLInsertAbonadosBeneficiarios()
	{
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append(" BEGIN ");
		call.append("   CU_BENEF_PROD_PG.CU_BENEFICIA_I_PR (?, ?,?,? ); ");
		call.append(" END; ");
		return call.toString();			
	}
	
	private String getSQLDeleteAbonadosBeneficiarios() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE"); 
		call.append("   EO_ABONADO_BENEF CU_BENEF_PROD_QT:=CU_BENEF_PROD_QT(null,null,null,null,null,null,null,null);");
		call.append(" BEGIN ");
		call.append("   EO_ABONADO_BENEF.COD_CLIENTE_CONTRATANTE:=?;");
		call.append("   EO_ABONADO_BENEF.NUM_ABONADO_CONTRATANTE:=?; ");
		call.append("   EO_ABONADO_BENEF.NUM_ABONADO_BENEFICIARIO:=?; ");
		call.append("   CU_BENEF_PROD_PG.CU_BENEFICIA_U_PR ( EO_ABONADO_BENEF,?,?,?);");
		call.append(" END; ");

		return call.toString();		
	}	
	
	/**
	 * 
	 */
	public AbonadoVetadoListDTO obtieneAbonadosVetados(AbonadoDTO abonadoDTO) throws CustomerException {
		
		logger.debug("obtieneAbonadosVetados():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		AbonadoVetadoListDTO abonadosVetadoList=null;
		String call = getSQLobtenerListaAbonadosVetados();
		try {
		
			logger.debug("abonadoDTO.getCodCliente()[" + abonadoDTO.getCodCliente() + "]");
			conn = getConnectionFromWLSInitialContext(global.getCustomJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, abonadoDTO.getCodCliente());
			cstmt.registerOutParameter(2, oracle.jdbc.driver.OracleTypes.CURSOR);			
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);			
			
			
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(3);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(4);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(5);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al obtener lista de abonados vetados");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando cursor...");
			ResultSet rs = (ResultSet) cstmt.getObject(2);
			ArrayList lista = new ArrayList();
			boolean existData=false;
			while (rs.next()) {
				existData=true;
				AbonadoVetadoDTO abonadoVetadoDTO = new AbonadoVetadoDTO();
				
				abonadoVetadoDTO.setNumCelular(rs.getLong(1));
				logger.debug("NumCelular[" + abonadoVetadoDTO.getNumCelular() + "]");
				abonadoVetadoDTO.setNombre(rs.getString(2));
				logger.debug("Nombre[" + abonadoVetadoDTO.getNombre() + "]");
				abonadoVetadoDTO.setCodCliente(rs.getLong(3));
				logger.debug("codCliente[" + abonadoVetadoDTO.getCodCliente() + "]");
				abonadoVetadoDTO.setNumAbonado(rs.getLong(4));
				logger.debug("NumAbonado[" + abonadoVetadoDTO.getNumAbonado() + "]");
				abonadoVetadoDTO.setTipo_Comportamiento(rs.getString(5));
				logger.debug("Tipo_Comportamiento[" + abonadoVetadoDTO.getTipo_Comportamiento() + "]");
				abonadoVetadoDTO.setFec_Inicio_Vigencia(rs.getTimestamp(6));
				logger.debug("Fec_Inicio_Vigencia[" + abonadoVetadoDTO.getFec_Inicio_Vigencia() + "]");
				abonadoVetadoDTO.setFec_Termino_Vigencia(rs.getTimestamp(7));
				logger.debug("Fec_Termino_Vigencia[" + abonadoVetadoDTO.getFec_Termino_Vigencia() + "]");	
				
				lista.add(abonadoVetadoDTO);
			}
			if (existData){
				AbonadoVetadoDTO[] abonadoVetadoDTO = (AbonadoVetadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(	lista.toArray(), AbonadoVetadoDTO.class);
				abonadosVetadoList = new AbonadoVetadoListDTO();
				abonadosVetadoList.setAbonadoVetadoList(abonadoVetadoDTO);
			}
			rs.close();
		} catch (CustomerException e) {
			logger.debug("CustomerException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener lista de abonados  vetados", e);
			throw new CustomerException("Ocurrió un error general al obtener lista de abonados  vetados",e);
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
		logger.debug("obtieneAbonadosVetados():end");
		return abonadosVetadoList;

	}
	
}

