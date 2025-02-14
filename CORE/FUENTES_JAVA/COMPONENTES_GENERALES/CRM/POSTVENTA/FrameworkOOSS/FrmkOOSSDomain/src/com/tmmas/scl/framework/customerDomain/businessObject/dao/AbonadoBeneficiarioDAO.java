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

import oracle.jdbc.OracleCallableStatement;
import oracle.sql.ARRAY;
import oracle.sql.ArrayDescriptor;
import oracle.sql.STRUCT;
import oracle.sql.StructDescriptor;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.customerDomain.businessObject.dao.interfaces.AbonadoBeneficiarioDAOIT;
import com.tmmas.scl.framework.customerDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerException;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoBeneficiarioDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoBeneficiarioListDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;
import com.tmmas.scl.framework.serviceDomain.exception.ServiceException;

public class AbonadoBeneficiarioDAO extends ConnectionDAO implements AbonadoBeneficiarioDAOIT {

	private final Logger logger = Logger.getLogger(AbonadoBeneficiarioDAO.class);

	private final Global global = Global.getInstance();
	
	private String getSQLobtenerListaAbonadosBeneficiarios() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE"); 
		call.append("   EO_ABONADO_BENEF CU_BENEF_PROD_QT:=CU_BENEF_PROD_QT(null,null,null,null,null,null,null,null);");
		call.append(" BEGIN ");
		call.append("   EO_ABONADO_BENEF.COD_CLIENTE_CONTRATANTE:=?;");
		call.append("   EO_ABONADO_BENEF.NUM_ABONADO_CONTRATANTE:=?; ");
		call.append("   CU_BENEF_PROD_PG.CU_ABOCONTRA_S_PR ( EO_ABONADO_BENEF, ?, ?,?,?);");
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
	
	
	private String getSQLCaducaAbonadosBeneficiarios()
	{
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   EO_ABONADO_BENEF CU_BENEF_PROD_QT; ");
		call.append("   SN_COD_RETORNO NUMBER; ");
		call.append("   SV_MENS_RETORNO VARCHAR2(200); ");
		call.append("   SN_NUM_EVENTO NUMBER; ");
		call.append(" BEGIN ");
		call.append("   CU_BENEF_PROD_PG.CU_CADUCA_U_PR(?,?,?,?); ");
		call.append(" END; ");
		return call.toString();			
	}
	
	private String getSQLEliminaAbonadosBeneficiarios()
	{
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   EO_ABONADO_BENEF CU_BENEF_PROD_QT; ");
		call.append(" SN_COD_RETORNO NUMBER; ");
		call.append("   SV_MENS_RETORNO VARCHAR2(200); ");
		call.append("   SN_NUM_EVENTO NUMBER; ");
		call.append(" BEGIN ");
		call.append("   CU_BENEF_PROD_PG.CU_ELIMINA_U_PR(?,?,?,?); ");
		call.append(" END; ");
		return call.toString();			
	}
	
	/**
	 * 
	 */
	public AbonadoBeneficiarioListDTO obtieneAbonadosBeneficiarios(AbonadoDTO abonadoDTO) throws CustomerException {
		
		logger.debug("obtieneAbonadosBeneficiarios():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		AbonadoBeneficiarioListDTO abonadosBeneficiarioList=null;
		String call = getSQLobtenerListaAbonadosBeneficiarios();
		try {
		
			logger.debug("abonadoDTO.getCodCliente()[" + abonadoDTO.getCodCliente() + "]");
			logger.debug("abonadoDTO.getnumAbonado()[" + abonadoDTO.getNumAbonado() + "]");
			conn = getConnectionFromWLSInitialContext(global.getCustomJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, abonadoDTO.getCodCliente());
			cstmt.setLong(2, abonadoDTO.getNumAbonado());
			cstmt.registerOutParameter(3, oracle.jdbc.driver.OracleTypes.CURSOR);			
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);			
			
			
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(4);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(5);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(6);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al obtener lista de abonados beneficiarios");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando cursor...");
			logger.debug("object="+cstmt.getObject(3));
			ResultSet rs = (ResultSet) cstmt.getObject(3);
			ArrayList lista = new ArrayList();
			boolean existData=false;
			while (rs.next()) {
				existData=true;
				AbonadoBeneficiarioDTO abonadoBeneficiarioDTO = new AbonadoBeneficiarioDTO();
				
				abonadoBeneficiarioDTO.setNumCelular(rs.getLong(1));
				logger.debug("NumCelular[" + abonadoBeneficiarioDTO.getNumCelular() + "]");
				abonadoBeneficiarioDTO.setNombre(rs.getString(2));
				logger.debug("Nombre[" + abonadoBeneficiarioDTO.getNombre() + "]");
				abonadoBeneficiarioDTO.setCodCliente(rs.getLong(3));
				logger.debug("codCliente[" + abonadoBeneficiarioDTO.getCodCliente() + "]");
				abonadoBeneficiarioDTO.setNumAbonado(rs.getLong(4));
				logger.debug("NumAbonado[" + abonadoBeneficiarioDTO.getNumAbonado() + "]");
				abonadoBeneficiarioDTO.setTipo_Comportamiento(rs.getString(5));
				logger.debug("Tipo_Comportamiento[" + abonadoBeneficiarioDTO.getTipo_Comportamiento() + "]");
				abonadoBeneficiarioDTO.setFec_Inicio_Vigencia(rs.getTimestamp(6));
				logger.debug("Fec_Inicio_Vigencia[" + abonadoBeneficiarioDTO.getFec_Inicio_Vigencia() + "]");
				abonadoBeneficiarioDTO.setNum_Abonado_Beneficiario(rs.getLong(7));
				logger.debug("NumAbonadoBeneficiario[" + abonadoBeneficiarioDTO.getNum_Abonado_Beneficiario() + "]");
				abonadoBeneficiarioDTO.setFec_Termino_Vigencia(rs.getTimestamp(8));
				logger.debug("Fec_Termino_Vigencia[" + abonadoBeneficiarioDTO.getFec_Termino_Vigencia() + "]");	
				
				lista.add(abonadoBeneficiarioDTO);
			}
			if (existData){
				AbonadoBeneficiarioDTO[] abonadoBeneficiarioDTO = (AbonadoBeneficiarioDTO[]) ArrayUtl.copiaArregloTipoEspecifico(	lista.toArray(), AbonadoBeneficiarioDTO.class);
				abonadosBeneficiarioList = new AbonadoBeneficiarioListDTO();
				abonadosBeneficiarioList.setAbonadoBeneficiarioList(abonadoBeneficiarioDTO);
			}
			rs.close();
		} catch (CustomerException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener lista de abonados beneficiarios", e);
			throw new CustomerException("Ocurrió un error general al obtener lista de abonados beneficiarios",e);
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
		logger.debug("obtieneAbonadosBeneficiarios():end");
		return abonadosBeneficiarioList;

	}
	
public AbonadoBeneficiarioListDTO obtieneAbonadosBeneficiariosPorNumCelular(AbonadoDTO abonadoDTO) throws CustomerException {
		
		logger.debug("obtieneAbonadosBeneficiariosPorNumCelular():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		AbonadoBeneficiarioListDTO abonadosBeneficiarioList=null;
		String call = getSQLobtenerListaAbonadosBeneficiariosPorNumCelular();
		try {
		
			logger.debug("abonadoDTO.getCodCliente()[" + abonadoDTO.getCodCliente() + "]");
			logger.debug("abonadoDTO.getnumAbonado()[" + abonadoDTO.getNumAbonado() + "]");
			conn = getConnectionFromWLSInitialContext(global.getCustomJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, abonadoDTO.getNumCelular());
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
				logger.error(" Ocurrió un error al obtener lista de abonados beneficiarios Por Numero Celular");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando cursor...");
			logger.debug("object="+cstmt.getObject(2));
			ResultSet rs = (ResultSet) cstmt.getObject(2);
			ArrayList lista = new ArrayList();
			boolean existData=false;
			while (rs.next()) {
				existData=true;
				AbonadoBeneficiarioDTO abonadoBeneficiarioDTO = new AbonadoBeneficiarioDTO();
				
				abonadoBeneficiarioDTO.setNumCelular(rs.getLong(1));
				logger.debug("NumCelular[" + abonadoBeneficiarioDTO.getNumCelular() + "]");
				abonadoBeneficiarioDTO.setNumAbonado(rs.getLong(2));
				logger.debug("NumAbonado[" + abonadoBeneficiarioDTO.getNumAbonado() + "]");
				abonadoBeneficiarioDTO.setCodCliente(rs.getLong(3));
				logger.debug("codCliente[" + abonadoBeneficiarioDTO.getCodCliente() + "]");
				abonadoBeneficiarioDTO.setNombre(rs.getString(4));
				logger.debug("Nombre[" + abonadoBeneficiarioDTO.getNombre() + "]");
				/*abonadoBeneficiarioDTO.setTipo_Comportamiento(rs.getString(5));
				logger.debug("Nombre[" + abonadoBeneficiarioDTO.getTipo_Comportamiento() + "]");
				abonadoBeneficiarioDTO.setFec_Inicio_Vigencia(rs.getTimestamp(6));
				logger.debug("Nombre[" + abonadoBeneficiarioDTO.getFec_Inicio_Vigencia() + "]");
				abonadoBeneficiarioDTO.setFec_Termino_Vigencia(rs.getTimestamp(7));
				logger.debug("Nombre[" + abonadoBeneficiarioDTO.getFec_Termino_Vigencia() + "]");*/
				lista.add(abonadoBeneficiarioDTO);
			}
			if (existData){
				AbonadoBeneficiarioDTO[] abonadoBeneficiarioDTO = (AbonadoBeneficiarioDTO[]) ArrayUtl.copiaArregloTipoEspecifico(	lista.toArray(), AbonadoBeneficiarioDTO.class);
				abonadosBeneficiarioList = new AbonadoBeneficiarioListDTO();
				abonadosBeneficiarioList.setAbonadoBeneficiarioList(abonadoBeneficiarioDTO);
			}
			rs.close();
		} catch (CustomerException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener lista de abonados beneficiarios Por Numero Celular", e);
			throw new CustomerException("Ocurrió un error general al obtener lista de abonados beneficiarios Por Numero Celular",e);
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
		logger.debug("obtieneAbonadosBeneficiariosPorNumCelular():end");
		return abonadosBeneficiarioList;

	}

	public RetornoDTO insertAbonadosBeneficiarios(AbonadoBeneficiarioListDTO abonadoBeneficiarioListDTO) throws CustomerException {
		logger.debug("insertAbonadosBeneficiarios():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;		
		Connection conn = null;
		OracleCallableStatement cstmt = null;
		
		String call = getSQLInsertAbonadosBeneficiarios();
		try {			
			
			conn = getConnectionFromWLSInitialContext(global.getCustomJndiForDataSource());			
			cstmt = (OracleCallableStatement)conn.prepareCall(call);
			
			StructDescriptor sd = StructDescriptor.createDescriptor("CU_BENEF_PROD_QT", conn);					
			STRUCT[] arreglo=abonadoBeneficiarioListDTO.getOracleArray_SV_LISTA_ABONADO_BENEFICIARIO_TO_LST_QT(sd, conn);			
			ArrayDescriptor ad =  ArrayDescriptor.createDescriptor("CU_BENEF_PROD_QT_LISTA_QT", conn);
			ARRAY aux = new ARRAY(ad, conn, arreglo);
			
			cstmt.setARRAY(1, aux);			
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);			
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			
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
			//fin----------------------------------------------------------------------
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al insertar abbonados beneficiarios");
				throw new ServiceException(String.valueOf(codError),numEvento, msgError);
			}
			
			//obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");
			//ini--------------RESCATAR RETORNO-------
			retorno = new RetornoDTO();
			retorno.setCodigo(String.valueOf(codError));
			retorno.setDescripcion(msgError);
			retorno.setResultado(true);
						
			//fin----------------------------------------------------------------------
		
		} catch (CustomerException e) {
			logger.debug("ServiceException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al insertar abbonados beneficiarios", e);
			throw new CustomerException("Ocurrió un error general al insertar abbonados beneficiarios",e);
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
		logger.debug("insertAbonadosBeneficiarios():end");
		return retorno;
	}

	public RetornoDTO deleteAbonadoBeneficiario(AbonadoBeneficiarioDTO abonadoBeneficiarioDTO) throws CustomerException {
		
		logger.debug("deleteAbonadoBeneficiario():start");
		RetornoDTO retornoDTO=null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLDeleteAbonadosBeneficiarios();
		try {
		
			logger.debug("abonadoBeneficiarioDTO.getCodCliente()[" + abonadoBeneficiarioDTO.getCodCliente() + "]");
			logger.debug("abonadoBeneficiarioDTO.getNumAbonado()[" + abonadoBeneficiarioDTO.getNumAbonado() + "]");
			logger.debug("abonadoBeneficiarioDTO.getNum_Abonado_Beneficiario()[" + abonadoBeneficiarioDTO.getNum_Abonado_Beneficiario() + "]");
			conn = getConnectionFromWLSInitialContext(global.getCustomJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, abonadoBeneficiarioDTO.getCodCliente());
			cstmt.setLong(2, abonadoBeneficiarioDTO.getNumAbonado());
			cstmt.setLong(3, abonadoBeneficiarioDTO.getNum_Abonado_Beneficiario());
			
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);			
			
			
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(4);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(5);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(6);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al obtener lista de abonados beneficiarios Por Numero Celular");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}
			else{
				retornoDTO=new RetornoDTO(); 
				retornoDTO.setCodigo(String.valueOf(codError));
				retornoDTO.setDescripcion(msgError);
				retornoDTO.setResultado(true);
			}
			
			
		} catch (CustomerException e) {
			logger.debug("CustomerException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al eliminar abonado beneficiario", e);
			throw new CustomerException("Ocurrió un error general al eliminar abonado beneficiario",e);
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
		logger.debug("deleteAbonadoBeneficiario():end");
		return retornoDTO;

	}

	public RetornoDTO caducaAbonadoBeneficiario(AbonadoBeneficiarioDTO abonadoBeneficiarioDTO) throws CustomerException 
	{
		logger.debug("caducaAbonadoBeneficiario():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;		
		Connection conn = null;
		OracleCallableStatement cstmt = null;
		
		String call = this.getSQLCaducaAbonadosBeneficiarios();
		try {			
			
			conn = getConnectionFromWLSInitialContext(global.getCustomJndiForDataSource());			
			cstmt = (OracleCallableStatement)conn.prepareCall(call);
			
			cstmt =  (OracleCallableStatement) conn.prepareCall(call);
			StructDescriptor sd = StructDescriptor.createDescriptor("CU_BENEF_PROD_QT", conn);			
			STRUCT oracleObject = new STRUCT(sd, conn, abonadoBeneficiarioDTO.toStruct_CU_BENEF_PROD_QT());
			
			cstmt.setObject(1, oracleObject);			
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);			
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			
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
			//fin----------------------------------------------------------------------
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al insertar abbonados beneficiarios");
				throw new ServiceException(String.valueOf(codError),numEvento, msgError);
			}
			
			//obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");
			//ini--------------RESCATAR RETORNO-------
			retorno = new RetornoDTO();
			retorno.setCodigo(String.valueOf(codError));
			retorno.setDescripcion(msgError);
			retorno.setResultado(true);
						
			//fin----------------------------------------------------------------------
		
		} catch (CustomerException e) {
			logger.debug("ServiceException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al caducar abonados beneficiarios", e);
			throw new CustomerException("Ocurrió un error general al insertar abbonados beneficiarios",e);
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
		logger.debug("caducaAbonadoBeneficiario():end");
		return retorno;
	}

	public RetornoDTO eliminaAbonadoBeneficiario(AbonadoBeneficiarioDTO abonadoBeneficiarioDTO) throws CustomerException 
	{
		logger.debug("eliminaAbonadoBeneficiario():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;		
		Connection conn = null;
		OracleCallableStatement cstmt = null;
		
		String call = this.getSQLEliminaAbonadosBeneficiarios();
		try {			
			
			conn = getConnectionFromWLSInitialContext(global.getCustomJndiForDataSource());			
			cstmt = (OracleCallableStatement)conn.prepareCall(call);
			
			cstmt =  (OracleCallableStatement) conn.prepareCall(call);
			StructDescriptor sd = StructDescriptor.createDescriptor("CU_BENEF_PROD_QT", conn);			
			STRUCT oracleObject = new STRUCT(sd, conn, abonadoBeneficiarioDTO.toStruct_CU_BENEF_PROD_QT());
			
			cstmt.setObject(1, oracleObject);			
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);			
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			
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
			//fin----------------------------------------------------------------------
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al insertar abbonados beneficiarios");
				throw new ServiceException(String.valueOf(codError),numEvento, msgError);
			}
			
			//obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");
			//ini--------------RESCATAR RETORNO-------
			retorno = new RetornoDTO();
			retorno.setCodigo(String.valueOf(codError));
			retorno.setDescripcion(msgError);
			retorno.setResultado(true);
						
			//fin----------------------------------------------------------------------
		
		} catch (CustomerException e) {
			logger.debug("ServiceException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al eliminar abonados beneficiarios", e);
			throw new CustomerException("Ocurrió un error general al insertar abbonados beneficiarios",e);
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
		logger.debug("eliminaAbonadoBeneficiario():end");
		return retorno;
	}


}

