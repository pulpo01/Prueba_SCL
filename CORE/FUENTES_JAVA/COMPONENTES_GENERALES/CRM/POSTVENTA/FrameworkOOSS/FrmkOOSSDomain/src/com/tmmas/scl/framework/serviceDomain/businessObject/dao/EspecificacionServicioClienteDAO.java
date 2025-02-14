package com.tmmas.scl.framework.serviceDomain.businessObject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import oracle.jdbc.OracleCallableStatement;
import oracle.sql.STRUCT;
import oracle.sql.StructDescriptor;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.productDomain.dataTransferObject.EspecProductoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ProductoOfertadoListDTO;
import com.tmmas.scl.framework.serviceDomain.businessObject.dao.interfaces.EspecificacionServicioClienteDAOIT;
import com.tmmas.scl.framework.serviceDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.EspecProvisionamientoListDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.EspecServicioClienteDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.EspecServicioClienteListDTO;
import com.tmmas.scl.framework.serviceDomain.exception.ServiceSpecEntitiesException;

public class EspecificacionServicioClienteDAO extends ConnectionDAO implements EspecificacionServicioClienteDAOIT{
	
	private final Logger logger = Logger.getLogger(EspecificacionServicioAltamiraDAO.class);
	private final Global global = Global.getInstance();
	
	
	
	private String getSQLobtenerEspecificacionServicioCliente() 
	{
		StringBuffer call = new StringBuffer();	
		call.append(" DECLARE ");
		call.append("   EO_DET_ESPEC_PRODUCTOS SE_DETALLE_ESPEC_TO_QT; ");
		call.append("   SO_LISTA_DET_ESPEC_PRODUCTOS SE_DET_ESPEC_PROD_PG.refCursor; ");
		call.append("   SN_COD_RETORNO NUMBER; ");
		call.append("   SV_MENS_RETORNO VARCHAR2(200); ");
		call.append("   SN_NUM_EVENTO NUMBER; ");
		call.append(" BEGIN ");
		call.append("   SE_DET_ESPEC_PROD_PG.SE_ESPEC_S_PR(?,?,?,?,?); ");   
		call.append(" END; ");
		return call.toString();		
	}
	
	
	
	private String getSQLobtenerEspecificacionesProvisionamiento() {
		StringBuffer call = new StringBuffer();
		//AGREGAR INVOCACION A PL
		return call.toString();		
	}
	
	private String getSQLobtenerEspecificacionServicioLista() {
		StringBuffer call = new StringBuffer();
		//AGREGAR INVOCACION A PL
		return call.toString();		
	}
	
	
	/**
	 * Obtiene los servicios por default
	 * 
	 * @param CategoriaDTO
	 * @return ProductoOfertadoListDTO
	 * @throws ServiceSpecEntitiesException
	 */
	public EspecServicioClienteListDTO obtenerEspecificacionServicioCliente (EspecProductoDTO especProducto) throws ServiceSpecEntitiesException
	{
		logger.debug("obtenerEspecificacionServicioCliente():start");
		
		if(especProducto==null)
		{
			logger.debug("Parametros de entrada vienen NULOS");
			return null;
		}
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ProductoOfertadoListDTO retorno = null;
		Connection conn = null;
		OracleCallableStatement cstmt = null;
		EspecServicioClienteListDTO resultEspecServicioClienteList=new EspecServicioClienteListDTO();
		String call =getSQLobtenerEspecificacionServicioCliente();
		try {			
			
			logger.debug("listaEspecProducto[" + especProducto + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			cstmt = (OracleCallableStatement) conn.prepareCall(call);
			
			StructDescriptor sd = StructDescriptor.createDescriptor("SE_DETALLE_ESPEC_TO_QT", conn);
			STRUCT oracleObject=new STRUCT(sd, conn, especProducto.toStruct_SE_DETALLE_ESPEC_TO_QT());
			
			cstmt.setObject(1, oracleObject);			
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
			//fin----------------------------------------------------------------------
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al obtener obtener Productos Ofertables Por Paquete");
				throw new ServiceSpecEntitiesException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			//ini-----------OBTENER CURSORES DE SERVICIOS A ACTIVAR Y DESACTIVAR-------
			retorno = new ProductoOfertadoListDTO();
			ArrayList resultadoPL=new ArrayList();			
			EspecServicioClienteDTO dto=null;
			EspecServicioClienteDTO[] dtoList=null;
			
			ResultSet rs=(ResultSet)cstmt.getObject(2);
			
			while(rs.next())
			{				
				dto=new EspecServicioClienteDTO();				
				dto.setIdEspecProducto(rs.getString("COD_ESPEC_PROD")!=null?rs.getString("COD_ESPEC_PROD"):"");
				dto.setIdServicioBase(rs.getString("COD_SERVICIO_BASE")!=null?rs.getString("COD_SERVICIO_BASE"):"");
				dto.setTipoServicio(rs.getString("IND_TIPO_SERVICIO")!=null?rs.getString("IND_TIPO_SERVICIO"):"");
				dto.setIdEspecProvision(rs.getString("COD_PROV_SERV")!=null?rs.getString("COD_PROV_SERV"):"");
				dto.setCodPerfilLista(rs.getString("COD_PERFIL_LISTA")!=null?rs.getString("COD_PERFIL_LISTA"):"");
				resultadoPL.add(dto);
			}
			dtoList=(EspecServicioClienteDTO[]) ArrayUtl.copiaArregloTipoEspecifico(resultadoPL.toArray(), EspecServicioClienteDTO.class);
			resultEspecServicioClienteList.setEspServCliList(dtoList);
			
			
			//fin-------------------------------------------------------------------
		
		} catch (ServiceSpecEntitiesException e) {
			logger.debug("ServiceSpecEntitiesException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener la Especificacion de Servicio al Cliente", e);
			throw new ServiceSpecEntitiesException("Ocurrió un error general obtener la Especificacion de Servicio al Cliente",e);
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
		logger.debug("obtenerEspecificacionServicioCliente():end");
		return resultEspecServicioClienteList;
	}


	public EspecProvisionamientoListDTO obtenerEspecificacionesProvisionamiento(EspecServicioClienteListDTO espServCliList) throws ServiceSpecEntitiesException 
	{
		logger.debug("obtenerEspecificacionesProvisionamiento():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		EspecProvisionamientoListDTO retorno = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerEspecificacionesProvisionamiento();
		try {
		
			logger.debug("espServCliList.getEspServCliList().toString()[" + espServCliList.getEspServCliList().toString() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			// cstmt.setLong(1, param.getNumAbonado());
			//ini------------------CONTINUAR CARGA DE PARAMETROS-------------------
			
			//cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			//cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			//cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);			
		
			logger.debug("execute:antes");
			//cstmt.execute();
			
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			//codError = cstmt.getInt(2);
			logger.debug("codError[" + codError + "]");
			//msgError = cstmt.getString(3);
			logger.debug("msgError[" + msgError + "]");
			//numEvento = cstmt.getInt(4);
			logger.debug("numEvento[" + numEvento + "]");
			//fin----------------------------------------------------------------------
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al obtener la Especificaciones de Provisionamiento");
				throw new ServiceSpecEntitiesException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			//ini-----------OBTENER CURSORES DE SERVICIOS A ACTIVAR Y DESACTIVAR-------
			retorno = new EspecProvisionamientoListDTO();
			//fin-------------------------------------------------------------------
		
		} catch (ServiceSpecEntitiesException e) {
			logger.debug("ServiceSpecEntitiesException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener la Especificaciones de Provisionamiento", e);
			throw new ServiceSpecEntitiesException("Ocurrió un error general al obtener la Especificaciones de Provisionamiento",e);
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
		logger.debug("obtenerEspecificacionesProvisionamiento():end");
		return retorno;
	}

	public ProductoOfertadoListDTO obtenerEspecificacionServicioLista(ProductoOfertadoListDTO prodOferList) throws ServiceSpecEntitiesException {
		logger.debug("obtenerEspecificacionServicioLista():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ProductoOfertadoListDTO retorno = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerEspecificacionServicioLista();
		try {
		
			logger.debug("prodOferList.getCargoList() [" + prodOferList.getCargoList() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			// cstmt.setLong(1, param.getNumAbonado());
			//ini------------------CONTINUAR CARGA DE PARAMETROS-------------------
			
			//cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			//cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			//cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);			
		
			logger.debug("execute:antes");
			//cstmt.execute();
			
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			//codError = cstmt.getInt(2);
			logger.debug("codError[" + codError + "]");
			//msgError = cstmt.getString(3);
			logger.debug("msgError[" + msgError + "]");
			//numEvento = cstmt.getInt(4);
			logger.debug("numEvento[" + numEvento + "]");
			//fin----------------------------------------------------------------------
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al obtener Especificacion Servicio Lista");
				throw new ServiceSpecEntitiesException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			//ini-----------OBTENER CURSORES DE SERVICIOS A ACTIVAR Y DESACTIVAR-------
			retorno = new ProductoOfertadoListDTO();
			//fin-------------------------------------------------------------------
		
		} catch (ServiceSpecEntitiesException e) {
			logger.debug("ServiceSpecEntitiesException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener Especificacion Servicio Lista", e);
			throw new ServiceSpecEntitiesException("Ocurrió un error general al obtener Especificacion Servicio Lista",e);
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
		logger.debug("obtenerEspecificacionServicioLista():end");
		return retorno;
	}
}
