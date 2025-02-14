/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 07/06/2007	     	Elizabeth Vera        				Versión Inicial
 * 21/06/2007			Cristian Toledo						Se agrega el metodo activar()
 */
package com.tmmas.scl.framework.productDomain.businessObject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

import oracle.jdbc.OracleCallableStatement;
import oracle.sql.ARRAY;
import oracle.sql.ArrayDescriptor;
import oracle.sql.STRUCT;
import oracle.sql.StructDescriptor;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.OrdenServicioDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerOrderException;
import com.tmmas.scl.framework.marketSalesDomain.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces.ProductoContratadoDAOIT;
import com.tmmas.scl.framework.productDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.PaqueteContratadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ProductoContratadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ProductoOfertadoDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;

public class ProductoContratadoDAO extends ConnectionDAO implements
		ProductoContratadoDAOIT {

	private final Logger logger = Logger.getLogger(ProductoContratadoDAO.class);

	private final Global global = Global.getInstance();
//-------------------------------------------------------------------------------------------------------------	
		
	
	private String getSQLactualizarEstado() {
		StringBuffer call = new StringBuffer();
		//AGREGAR INVOCACION A PL
		return call.toString();		
	}
//	-------------------------------------------------------------------------------------------------------------	
		
	private String getSQLdesactivar()
	{
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   EO_LISTA_PRODUCTOS PR_PROD_CONTR_LST_QT; ");
		call.append("   SN_COD_RETORNO NUMBER; ");
		call.append("   SV_MENS_RETORNO VARCHAR2(200); ");
		call.append("   SN_NUM_EVENTO NUMBER; ");
		call.append(" BEGIN ");
		call.append("   PR_PRODUCTOS_CONTRATADOS_PG.PR_PRODUCTO_D_PR(?,?,?,?); ");    
		call.append(" END; ");
		return call.toString();
	}
//	-------------------------------------------------------------------------------------------------------------	
	private String getSQLactivar()
	{
		StringBuffer call = new StringBuffer();		
		call.append(" DECLARE ");
		call.append("   EO_PRODUCTOS PR_PRODUCTOS_CONTS_TO_QT; ");		
		call.append("   SN_COD_RETORNO NUMBER; ");
		call.append("   SV_MENS_RETORNO VARCHAR2(200); ");
		call.append("   SN_NUM_EVENTO NUMBER; ");
		call.append(" BEGIN ");
		call.append("   PR_PRODUCTOS_CONTRATADOS_PG.PR_CONTRATA_I_PR(?,?,?,?); ");    
		call.append(" END; ");		
		return call.toString();
	}
//	-------------------------------------------------------------------------------------------------------------	
	private String getSQLnotificar() {
		StringBuffer call = new StringBuffer();
		//AGREGAR INVOCACION A PL
		return call.toString();		
	}	
//	-------------------------------------------------------------------------------------------------------------	
	
		
	
		
		
	private String getSQLobtenerProductosContratados() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("  EO_productos PR_PRODUCTOS_CONTS_TO_QT := PR_PRODUCTOS_CONTS_TO_QT(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);");
		call.append(" BEGIN ");
		call.append("   EO_productos.COD_CLIENTE_CONTRATANTE := ?;");
		call.append("   EO_productos.NUM_ABONADO_CONTRATANTE := ?;");
		call.append("   EO_productos.TIPO_COMPORTAMIENTO := ?;");
		call.append("   PR_PRODUCTOS_CONTRATADOS_PG.PR_PRODUCTO_S_PR( EO_productos, ?, ?, ?, ?);");
		call.append(" END;");		        
		return call.toString();		
	}	
//	-------------------------------------------------------------------------------------------------------------	
	private String getSQLobtenerProductosContratadosPorPaquete() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("  EO_productos PR_PRODUCTOS_CONTS_TO_QT := PR_PRODUCTOS_CONTS_TO_QT(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);");
		call.append(" BEGIN ");
		call.append("   EO_productos.COD_CLIENTE_CONTRATANTE := ?;");
		call.append("   EO_productos.NUM_ABONADO_CONTRATANTE := ?;");
		call.append("   EO_productos.COD_PROD_CONTRATADO := ?;");
		call.append("   PR_PRODUCTOS_CONTRATADOS_PG.PR_PAQUETE_S_PR( EO_productos, ?, ?, ?, ?);");
		call.append(" END;");		        
		return call.toString();		
	}
//	-------------------------------------------------------------------------------------------------------------	
	
	
	private String getSQLobtenerProductosContratadosVenta()
	{
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   EO_VENTA PR_VENTA_QT; ");
		call.append("   SO_LISTA_PRODUCTOS PR_PRODUCTOS_CONTRATADOS_PG.refCursor; ");
		call.append("   SN_COD_RETORNO NUMBER; ");
		call.append("   SV_MENS_RETORNO VARCHAR2(200); ");
		call.append("   SN_NUM_EVENTO NUMBER; ");
		call.append(" BEGIN ");
		call.append("   PR_PRODUCTOS_CONTRATADOS_PG.PR_VENTA_S_PR(?,?,?,?,?); ");    
		call.append(" END; ");
		return call.toString();				
	}	
	
	private String getSQLdescontratar()
	{
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append(" BEGIN ");
		call.append(" PR_PRODUCTOS_CONTRATADOS_PG.PR_PRODUCTO_U_PR(?,?,?,?); ");    
		call.append(" END; ");
		return call.toString();				
	}
	
	
	private String getSQLobtenerSecuencia() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   eo_secuencia PR_SECUENCIA_QT; ");
		call.append(" BEGIN ");
		call.append("   eo_secuencia := PR_SECUENCIA_QT(?,NULL); ");
		call.append("   PR_PRODUCTOS_CONTRATADOS_PG.PR_SECUENCIA_PRODUCTO_PR( eo_secuencia, ?, ?, ?); ");
		call.append("   			? := eo_secuencia.NUM_SECUENCIA; ");
		call.append(" END;");
		return call.toString();		
	}		
//	-------------------------------------------------------------------------------------------------------------
	
	private String getSQLobtenerDetalleProductoContratado()
	{
		StringBuffer call = new StringBuffer();
			call.append(" DECLARE ");
			call.append("   EO_LISTA_PRODUCTOS PR_PROD_CONTR_LST_QT; ");
			call.append("   SO_LISTA_PRODUCTOS PR_PRODUCTOS_CONTRATADOS_PG.refCursor; ");
			call.append("   SN_COD_RETORNO NUMBER; ");
			call.append("   SV_MENS_RETORNO VARCHAR2(200); ");
			call.append("   SN_NUM_EVENTO NUMBER; ");
			call.append(" BEGIN ");
			call.append("   PR_PRODUCTOS_CONTRATADOS_PG.PR_DETALLE_S_PR(?,?,?,?,?); ");
			call.append(" END; ");
		return call.toString();	
	}
	
//---------------------------------------------------------------------------------------------------------------
	
	/**
	 * Recupera valor de una secuencia
	 * 
	 * @param secuencia
	 * @return SecuenciaDTO
	 * @throws ProductException 
	 * @throws CustomerOrderException
	 */
	public SecuenciaDTO obtenerSecuencia(SecuenciaDTO secuencia) throws ProductException {
		logger.debug("obtenerSecuencia():start");

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		SecuenciaDTO respuesta = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerSecuencia();

		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());

			logger.debug("secuencia.getNomSecuencia()[" + secuencia.getNomSecuencia() + "]");
			
			cstmt = conn.prepareCall(call);
			cstmt.setString(1, secuencia.getNomSecuencia());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC); //NUM_SECUENCIA
			
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
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al obtener el número de secuencia");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			
			long numSecuencia = cstmt.getLong(5);
			logger.debug("numSecuencia[" + numSecuencia + "]");
			
			respuesta = secuencia;
			respuesta.setNumSecuencia(numSecuencia);
			
		} catch (Exception e) {
			logger.debug("CustomerOrderException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw new ProductException(e);
			
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
		logger.debug("obtenerSecuencia():end");
		return respuesta;	
	}
	
	
	
	
	
	
		
		
	public RetornoDTO activar(ProductoContratadoDTO producto) throws ProductException 
	{
		logger.debug("activar():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;		
		Connection conn = null;
		OracleCallableStatement cstmt = null;
		RetornoDTO retorno=new RetornoDTO();
		
		String call = getSQLactivar();
		try {		
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());			
			cstmt = (OracleCallableStatement)conn.prepareCall(call);			
			
			StructDescriptor sd = StructDescriptor.createDescriptor("PR_PRODUCTOS_CONTS_TO_QT", conn);			
			STRUCT oracleObject = new STRUCT(sd, conn, producto.toStruct_PR_PRODUCTOS_CONTS_TO_QT());
			//ini------------------CONTINUAR CARGA DE PARAMETROS-------------------
			
			cstmt.setObject(1,oracleObject);						
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
				logger.error(" Ocurrió un error al registrar traspaso de un abonado a otro cliente");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}			
			
			retorno.setCodigo(String.valueOf(codError));
			retorno.setDescripcion(msgError);
			retorno.setResultado(true);			
			
			//fin-------------------------------------------------------------------
		
		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al registrar traspaso de un abonado a otro cliente", e);
			throw new ProductException("Ocurrió un error general al registrar traspaso de un abonado a otro cliente",e);
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
		logger.debug("activar():end");
		return retorno;
	}
	
//	-------------------------------------------------------------------------------------------------------------	
	public RetornoDTO activar(PaqueteContratadoDTO paquete) throws ProductException 
	{
		logger.debug("activar():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;		
		Connection conn = null;
		OracleCallableStatement cstmt = null;
		
		RetornoDTO retorno=new RetornoDTO();
		
		
		String call = getSQLactivar();
		try {		
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());			
			cstmt = (OracleCallableStatement)conn.prepareCall(call);			
			
			StructDescriptor sd = StructDescriptor.createDescriptor("PR_PRODUCTOS_CONTS_TO_QT", conn);			
			STRUCT oracleObject = new STRUCT(sd, conn, paquete.toStruct_PR_PRODUCTOS_CONTS_TO_QT());
			//ini------------------CONTINUAR CARGA DE PARAMETROS-------------------
			
			cstmt.setObject(1,oracleObject);						
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
				logger.error(" Ocurrió un error al registrar traspaso de un abonado a otro cliente");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}
			
			retorno.setCodigo(String.valueOf(codError));
			retorno.setDescripcion(msgError);
			retorno.setResultado(true);
			//fin-------------------------------------------------------------------
		
		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al registrar traspaso de un abonado a otro cliente", e);
			throw new ProductException("Ocurrió un error general al registrar traspaso de un abonado a otro cliente",e);
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
		logger.debug("activar():end");
		return retorno;
	}

	
//	-------------------------------------------------------------------------------------------------------------
	public RetornoDTO notificar(VentaDTO venta) throws ProductException {
		logger.debug("notificar():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLnotificar();
		try {
		
			logger.debug("venta.getIdVenta()()[" + venta.getIdVenta() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			//cstmt.setLong(1, datos.getNumAbonado());
			//ini------------------CONTINUAR CARGA DE PARAMETROS-------------------
			
			//cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			//cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			//cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);			
		
			logger.debug("execute:antes");
			cstmt.execute();
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
				logger.error(" Ocurrió un error al registrar traspaso de un abonado a otro cliente");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			//ini--------------OBTENER RETORNO-------
			retorno = new RetornoDTO();
			//fin-------------------------------------------------------------------
		
		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al registrar traspaso de un abonado a otro cliente", e);
			throw new ProductException("Ocurrió un error general al registrar traspaso de un abonado a otro cliente",e);
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
		logger.debug("notificar():end");
		return retorno;
	}
//	-------------------------------------------------------------------------------------------------------------
	public RetornoDTO actualizarEstado(VentaDTO venta) throws ProductException 
	{
		logger.debug("actualizarEstado():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLactualizarEstado();
		try {
		
			logger.debug("venta.getIdVenta()()[" + venta.getIdVenta() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			//cstmt.setLong(1, datos.getNumAbonado());
			//ini------------------CONTINUAR CARGA DE PARAMETROS-------------------
			
			//cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			//cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			//cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);			
		
			logger.debug("execute:antes");
			cstmt.execute();
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
				logger.error(" Ocurrió un error al registrar traspaso de un abonado a otro cliente");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			//ini--------------OBTENER RETORNO-------
			retorno = new RetornoDTO();
			//fin-------------------------------------------------------------------
		
		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al registrar traspaso de un abonado a otro cliente", e);
			throw new ProductException("Ocurrió un error general al registrar traspaso de un abonado a otro cliente",e);
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
		logger.debug("actualizarEstado():end");
		return retorno;
	}
//	-------------------------------------------------------------------------------------------------------------	
	
	/**
	 * Obtener datos cambio de plan
	 * 
	 * @param abonado
	 * @return ProductoContratadoListDTO
	 * @throws ProductException
	 */	
	public ProductoContratadoListDTO obtenerProductosContratados(OrdenServicioDTO ordenServicio) throws ProductException{
		logger.debug("obtenerProductosContratados():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ProductoContratadoListDTO retorno = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerProductosContratados();
		try {
		
			logger.debug("ordenServicio.getCliente().getCodCliente()[" + ordenServicio.getCliente().getCodCliente() + "]");
				
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, ordenServicio.getCliente().getCodCliente());
			
			
			if (ordenServicio.getCliente().getAbonados() != null )
			{
				AbonadoDTO abonadoContratante[] = ordenServicio.getCliente().getAbonados().getAbonados();
				cstmt.setLong(2, abonadoContratante[0].getNumAbonado() );
			}
			else 
				cstmt.setLong( 2, 0 );
			
			if ( ordenServicio.getTipoComportamiento() == null || ordenServicio.getTipoComportamiento().equalsIgnoreCase("")   )
				cstmt.setString(3, "");
			else 
				cstmt.setString(3, ordenServicio.getTipoComportamiento() ); 
			
			cstmt.registerOutParameter(4,oracle.jdbc.driver.OracleTypes.CURSOR);
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
				logger.error(" Ocurrió un error al obtener Productos Contratados");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			
			retorno = new ProductoContratadoListDTO();
			//retorno.setCodPlanServ(codPlanServNuevo);
		
			ProductoContratadoDTO dto=null;
			ProductoContratadoDTO[] dtoList=null;
			ArrayList retornoOracle=new ArrayList();
			ResultSet rs=(ResultSet)cstmt.getObject(4);
			ProductoOfertadoDTO prodOf = null;
			
			while(rs.next())
			{ 
				dto=new ProductoContratadoDTO();
				prodOf = new ProductoOfertadoDTO();
				dto.setIdProdContratado(rs.getString("COD_PROD_CONTRATADO")!=null?new Long(rs.getLong("COD_PROD_CONTRATADO")):new Long(-1));
				dto.setIdClienteBeneficiario(rs.getString("COD_CLIENTE_BENEFICIARIO")!=null?new Long(rs.getLong("COD_CLIENTE_BENEFICIARIO")):new Long(-1));
				dto.setIdAbonadoBeneficiario(rs.getString("NUM_ABONADO_BENEFICIARIO")!=null?new Long(rs.getLong("NUM_ABONADO_BENEFICIARIO")):new Long(-1));
				prodOf.setIdProductoOfertado(rs.getString("COD_PROD_OFERTADO")!=null?rs.getString("COD_PROD_OFERTADO"):"");
				dto.setProdOfertado(prodOf);
				dto.setIdProductoOfertado(rs.getString("COD_PROD_OFERTADO")!=null?new Long(rs.getLong("COD_PROD_OFERTADO")):new Long(-1));
				dto.setNumProceso(rs.getString("NUM_PROCESO")!=null?rs.getString("NUM_PROCESO"):"");
				dto.setFechaInicioVigencia(rs.getDate("FEC_INICIO_VIGENCIA")!=null?rs.getDate(("FEC_INICIO_VIGENCIA")):new Date());
				dto.setIdCanal(rs.getString("COD_CANAL")!=null?rs.getString("COD_CANAL"):"");
				dto.setOrigenProceso(rs.getString("ORIGEN_PROCESO")!=null?rs.getString(("ORIGEN_PROCESO")):"");
				dto.setFechaProceso(rs.getDate("FEC_PROCESO")!=null?rs.getDate(("FEC_PROCESO")):new Date());
				dto.setIdEstado(rs.getString("COD_ESTADO")!=null?rs.getString(("COD_ESTADO")):"");
				dto.setIndCondicionContratacion(rs.getString("IND_CONDICION_CONTRATACION")!=null?rs.getString(("IND_CONDICION_CONTRATACION")):"");
				dto.setIdClienteContratante(rs.getString("COD_CLIENTE_CONTRATANTE")!=null?new Long(rs.getLong("COD_CLIENTE_CONTRATANTE")):new Long(-1));
				dto.setNumAbonadoContratante(rs.getString("NUM_ABONADO_CONTRATANTE")!=null?new Long(rs.getLong("NUM_ABONADO_CONTRATANTE")):new Long(-1));
				dto.setFechaTerminoVigencia(rs.getDate("FEC_TERMINO_VIGENCIA")!=null?rs.getDate(("FEC_TERMINO_VIGENCIA")):new Date());
				dto.setIndPrioridad(rs.getString("IND_PRIORIDAD")!=null?new Long(rs.getLong("IND_PRIORIDAD")):new Long(-1));
				dto.setIdProdContraPadre(rs.getString("COD_PROD_CONTRA_PADRE")!=null?new Long(rs.getLong("COD_PROD_CONTRA_PADRE")):new Long(-1));
				dto.setCodPerfilLista(rs.getString("COD_PERFIL_LISTA")!=null?rs.getString(("COD_PERFIL_LISTA")):"");
				dto.setTipoComportamiento(rs.getString("TIPO_COMPORTAMIENTO")!=null?rs.getString(("TIPO_COMPORTAMIENTO")):"");
				dto.setIndPaquete(rs.getString("IND_PAQUETE")!=null?rs.getString(("IND_PAQUETE")):"");
				retornoOracle.add(dto);
			}
			dtoList=(ProductoContratadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(retornoOracle.toArray(), ProductoContratadoDTO.class);
			retorno.setProductosContratadosDTO(dtoList);
			
			
		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener Productos Contratados", e);
			throw new ProductException("Ocurrió un error general al obtener Productos Contratados",e);
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
		logger.debug("obtenerProductosContratados():end");
		return retorno;
	}
	
//	-------------------------------------------------------------------------------------------------------------	
	/**
	 * Obtener datos cambio de plan
	 * 
	 * @param abonado
	 * @return ProductoContratadoListDTO
	 * @throws ProductException
	 */	
	public PaqueteContratadoDTO obtenerProductosContratadosPorPaquete(PaqueteContratadoDTO paqueteContratado) throws ProductException{
		logger.debug("obtenerProductosContratadosPorPaquete():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		PaqueteContratadoDTO 	retorno = null;
		ProductoContratadoListDTO listaProdContratado = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerProductosContratadosPorPaquete();
		try {
		
			logger.debug("paqueteContratado.getNumAbonadoContratante()[" + paqueteContratado.getNumAbonadoContratante()+ "]");
				
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, paqueteContratado.getIdClienteContratante().longValue() );
			cstmt.setLong(2, paqueteContratado.getNumAbonadoContratante().longValue() );
			cstmt.setLong(3 , paqueteContratado.getIdProdContratado().longValue() );
			
			
			cstmt.registerOutParameter(4,oracle.jdbc.driver.OracleTypes.CURSOR);
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
				logger.error(" Ocurrió un error al obtener Productos Contratados");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			
			listaProdContratado = new ProductoContratadoListDTO();
			//retorno.setCodPlanServ(codPlanServNuevo);
		
			ProductoContratadoDTO dto=null;
			ProductoContratadoDTO[] dtoList=null;
			ArrayList retornoOracle=new ArrayList();
			ResultSet rs=(ResultSet)cstmt.getObject(4);
			ProductoOfertadoDTO prodOf = null;
			
			while(rs.next())
			{ 
				dto=new ProductoContratadoDTO();
				prodOf = new ProductoOfertadoDTO();
				dto.setIdProdContratado(rs.getString("COD_PROD_CONTRATADO")!=null?new Long(rs.getLong("COD_PROD_CONTRATADO")):new Long(-1));
				dto.setIdClienteBeneficiario(rs.getString("COD_CLIENTE_BENEFICIARIO")!=null?new Long(rs.getLong("COD_CLIENTE_BENEFICIARIO")):new Long(-1));
				dto.setIdAbonadoBeneficiario(rs.getString("NUM_ABONADO_BENEFICIARIO")!=null?new Long(rs.getLong("NUM_ABONADO_BENEFICIARIO")):new Long(-1));
				prodOf.setIdProductoOfertado(rs.getString("COD_PROD_OFERTADO")!=null?rs.getString("COD_PROD_OFERTADO"):"");
				dto.setProdOfertado(prodOf);
				dto.setIdProductoOfertado(rs.getString("COD_PROD_OFERTADO")!=null?new Long(rs.getLong("COD_PROD_OFERTADO")):new Long(-1));
				dto.setNumProceso(rs.getString("NUM_PROCESO")!=null?rs.getString("NUM_PROCESO"):"");
				dto.setFechaInicioVigencia(rs.getDate("FEC_INICIO_VIGENCIA")!=null?rs.getDate(("FEC_INICIO_VIGENCIA")):new Date());
				dto.setIdCanal(rs.getString("COD_CANAL")!=null?rs.getString("COD_CANAL"):"");
				dto.setOrigenProceso(rs.getString("ORIGEN_PROCESO")!=null?rs.getString(("ORIGEN_PROCESO")):"");
				dto.setFechaProceso(rs.getDate("FEC_PROCESO")!=null?rs.getDate(("FEC_PROCESO")):new Date());
				dto.setIdEstado(rs.getString("COD_ESTADO")!=null?rs.getString(("COD_ESTADO")):"");
				dto.setIndCondicionContratacion(rs.getString("IND_CONDICION_CONTRATACION")!=null?rs.getString(("IND_CONDICION_CONTRATACION")):"");
				dto.setIdClienteContratante(rs.getString("COD_CLIENTE_CONTRATANTE")!=null?new Long(rs.getLong("COD_CLIENTE_CONTRATANTE")):new Long(-1));
				dto.setNumAbonadoContratante(rs.getString("NUM_ABONADO_CONTRATANTE")!=null?new Long(rs.getLong("NUM_ABONADO_CONTRATANTE")):new Long(-1));
				dto.setFechaTerminoVigencia(rs.getDate("FEC_TERMINO_VIGENCIA")!=null?rs.getDate(("FEC_TERMINO_VIGENCIA")):new Date());
				dto.setIndPrioridad(rs.getString("IND_PRIORIDAD")!=null?new Long(rs.getLong("IND_PRIORIDAD")):new Long(-1));
				dto.setIdProdContraPadre(rs.getString("COD_PROD_CONTRA_PADRE")!=null?new Long(rs.getLong("COD_PROD_CONTRAT_PADRE")):new Long(-1));
				dto.setCodPerfilLista(rs.getString("COD_PERFIL_LISTA")!=null?rs.getString(("COD_PERFIL_LISTA")):"");
				dto.setTipoComportamiento(rs.getString("TIPO_COMPORTAMIENTO")!=null?rs.getString(("TIPO_COMPORTAMIENTO")):"");
				dto.setIndPaquete(rs.getString("IND_PAQUETE")!=null?rs.getString(("IND_PAQUETE")):"");
				retornoOracle.add(dto);
			}
			dtoList=(ProductoContratadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(retornoOracle.toArray(), ProductoContratadoDTO.class);
			listaProdContratado.setProductosContratadosDTO(dtoList);
			retorno = new PaqueteContratadoDTO();
			
			retorno.setListaProductosContratados(listaProdContratado);
		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener Productos Contratados", e);
			throw new ProductException("Ocurrió un error general al obtener Productos Contratados",e);
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
		logger.debug("obtenerProductosContratados():end");
		return retorno;
	}
//	-------------------------------------------------------------------------------------------------------------
	public ProductoContratadoListDTO obtenerProductosContratadosVenta(VentaDTO venta) throws ProductException 
	{
		logger.debug("obtenerProductosContratadosVenta():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ProductoContratadoListDTO retorno = null;
		Connection conn = null;
		OracleCallableStatement cstmt = null;
		
		String call = getSQLobtenerProductosContratadosVenta();
		try {		
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());			
			cstmt = (OracleCallableStatement)conn.prepareCall(call);
			
			StructDescriptor sd = StructDescriptor.createDescriptor("PR_VENTA_QT", conn);                   
            STRUCT oracleObject = new STRUCT(sd, conn, venta.toStruct_PR_VENTA_QT()); 
						
            cstmt.setObject(1, oracleObject);
			cstmt.registerOutParameter(2,oracle.jdbc.driver.OracleTypes.CURSOR);						
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
				logger.error(" Ocurrió un error al obtener Productos Contratados");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}					
			retorno = new ProductoContratadoListDTO();
			ProductoContratadoDTO dto=null;
			ProductoContratadoDTO[] dtoList=null;
			ArrayList plReturn=new ArrayList();
			ResultSet rs=(ResultSet)cstmt.getObject(2);			
			while(rs.next())
			{				
				dto=new ProductoContratadoDTO();
				dto.setIdProdContratado(new Long(rs.getString("COD_PROD_CONTRATADO")!=null?rs.getLong("COD_PROD_CONTRATADO"):-1));
				dto.setIdClienteBeneficiario(new Long(rs.getString("COD_CLIENTE_BENEFICIARIO")!=null?rs.getLong("COD_CLIENTE_BENEFICIARIO"):-1));
				dto.setIdAbonadoBeneficiario(new Long(rs.getString("NUM_ABONADO_BENEFICIARIO")!=null?rs.getLong("NUM_ABONADO_BENEFICIARIO"):-1));
				dto.setIdProductoOfertado(new Long(rs.getString("COD_PROD_OFERTADO")!=null?rs.getLong("COD_PROD_OFERTADO"):-1));
				dto.setFechaInicioVigencia(rs.getDate("FEC_INICIO_VIGENCIA")!=null?rs.getDate("FEC_INICIO_VIGENCIA"):new Date());
				dto.setIdCanal(rs.getString("COD_CANAL")!=null?rs.getString("COD_CANAL"):"");
				dto.setNumProceso(rs.getString("NUM_PROCESO")!=null?rs.getString("NUM_PROCESO"):"");
				dto.setOrigenProceso(rs.getString("ORIGEN_PROCESO")!=null?rs.getString("ORIGEN_PROCESO"):"");
				dto.setFechaProceso(rs.getDate("FEC_PROCESO")!=null?rs.getDate("FEC_PROCESO"):new Date());
				dto.setIdEstado(rs.getString("COD_ESTADO")!=null?rs.getString("COD_ESTADO"):"");
				dto.setIndCondicionContratacion(rs.getString("IND_CONDICION_CONTRATACION")!=null?rs.getString("IND_CONDICION_CONTRATACION"):"");
				dto.setIdClienteContratante(new Long(rs.getString("COD_CLIENTE_CONTRATANTE")!=null?rs.getLong("COD_CLIENTE_CONTRATANTE"):-1));
				dto.setNumAbonadoContratante(new Long(rs.getString("NUM_ABONADO_CONTRATANTE")!=null?rs.getLong("NUM_ABONADO_CONTRATANTE"):-1));
				dto.setFechaTerminoVigencia(rs.getDate("FEC_TERMINO_VIGENCIA")!=null?rs.getDate("FEC_TERMINO_VIGENCIA"):new Date());
				dto.setIndPrioridad(new Long(rs.getString("IND_PRIORIDAD")!=null?rs.getLong("IND_PRIORIDAD"):-1));
				dto.setIdProdContraPadre(new Long(rs.getString("COD_PROD_CONTRAT_PADRE")!=null?rs.getLong("COD_PROD_CONTRAT_PADRE"):-1));
				dto.setCodPerfilLista(rs.getString("COD_PERFIL_LISTA")!=null?rs.getString("COD_PERFIL_LISTA"):"");
				dto.setTipoComportamiento(rs.getString("TIPO_COMPORTAMIENTO")!=null?rs.getString("TIPO_COMPORTAMIENTO"):"");
				plReturn.add(dto);				
			}			
			dtoList=(ProductoContratadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(plReturn.toArray(), ProductoContratadoDTO.class);
			retorno.setProductosContratadosDTO(dtoList);
		
		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener Productos Contratados", e);
			throw new ProductException("Ocurrió un error general al obtener Productos Contratados",e);
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
		logger.debug("obtenerProductosContratadosVenta():end");
		return retorno;
	}
//	-------------------------------------------------------------------------------------------------------------
	public RetornoDTO desactivar(ProductoContratadoListDTO listaProductosContratados) throws ProductException 
	{
		logger.debug("desactivar():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;
		Connection conn = null;
		OracleCallableStatement cstmt = null;
		
		String call = getSQLdesactivar();
		try {		
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = (OracleCallableStatement)conn.prepareCall(call);
			StructDescriptor sd = StructDescriptor.createDescriptor("PR_PRODUCTOS_CONTS_TO_QT", conn);			
			ArrayDescriptor ad=null;
			ARRAY aux =null;			
			STRUCT[] arreglo=listaProductosContratados.getOracleArray_PR_PROD_CONTR_LST_QT(sd, conn);			
			ad = ArrayDescriptor.createDescriptor("PR_PROD_CONTR_LST_QT", conn);
			aux = new ARRAY(ad, conn, arreglo);
			
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
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al desactivar Productos Contratados");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}
			
			retorno = new RetornoDTO();
			retorno.setCodigo(String.valueOf(codError));
			retorno.setDescripcion(msgError);
			retorno.setResultado(true);
		
		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener Productos Contratados", e);
			throw new ProductException("Ocurrió un error general al obtener Productos Contratados",e);
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
		logger.debug("desactivar():end");
		return retorno;
	}
//	-------------------------------------------------------------------------------------------------------------	
	
	/**
	 * descontratar
	 * 
	 * @param ProductoContratadoListDTO
	 * @return RetornoDTO
	 * @throws ProductException
	 */	
	public RetornoDTO descontratar(ProductoContratadoListDTO productoContratadoList) throws ProductException{
		logger.debug("descontratar():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;
		Connection conn = null;
		OracleCallableStatement cstmt = null;
		
		String call = getSQLdescontratar();
		try {
		
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = (OracleCallableStatement)conn.prepareCall(call);
			StructDescriptor sd = StructDescriptor.createDescriptor("PR_PRODUCTO_DESCONTRATA_QT", conn);			
			ArrayDescriptor ad=null;
			ARRAY aux =null;			
			STRUCT[] arreglo = productoContratadoList.getOracleArray_PR_PRODUCTO_DESCONTRATA_QT(sd, conn);			
			ad = ArrayDescriptor.createDescriptor("PR_PRODUCTO_DES_LST_QT", conn);
			aux = new ARRAY(ad, conn, arreglo);
			
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
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al obtener lista de causas de baja");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}
			
			retorno = new RetornoDTO();
			retorno.setCodigo(String.valueOf(codError));
			retorno.setDescripcion(msgError);
			retorno.setResultado(true);
			
			
		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener lista de causas de baja", e);
			throw new ProductException("Ocurrió un error general al obtener lista de causas de baja",e);
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
		logger.debug("descontratar():end");
		return retorno;		
	}
//-------------------------------------------------------------------------------------------------------------
	public ProductoContratadoListDTO obtenerDetalleProductoContratado(ProductoContratadoListDTO listaProductos) throws ProductException 
	{
		logger.debug("obtenerDetalleProductoContratado():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;
		Connection conn = null;
		OracleCallableStatement cstmt = null;
		
		String call = getSQLobtenerDetalleProductoContratado();
		try {		
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = (OracleCallableStatement)conn.prepareCall(call);
			StructDescriptor sd = StructDescriptor.createDescriptor("PR_PRODUCTOS_CONTS_TO_QT", conn);			
			ArrayDescriptor ad=null;
			ARRAY aux =null;			
			STRUCT[] arreglo=listaProductos.getOracleArray_PR_PROD_CONTR_LST_QT(sd, conn);			
			ad = ArrayDescriptor.createDescriptor("PR_PROD_CONTR_LST_QT", conn);
			aux = new ARRAY(ad, conn, arreglo);
			
			cstmt.setARRAY(1, aux);	
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
				logger.error(" Ocurrió un error al desactivar Productos Contratados");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}
			
			retorno = new RetornoDTO();
			retorno.setCodigo(String.valueOf(codError));
			retorno.setDescripcion(msgError);
			retorno.setResultado(true);
			
			/**
			 * Rescatando datos
			 */
			ArrayList retornoOracle=new ArrayList();
			ResultSet rs=(ResultSet)cstmt.getObject(2);
			
			while(rs.next())
			{
				ProductoContratadoDTO dto=new ProductoContratadoDTO();
				ProductoOfertadoDTO prodOf = new ProductoOfertadoDTO();
				dto.setIdProdContratado(rs.getString("COD_PROD_CONTRATADO")!=null?new Long(rs.getLong("COD_PROD_CONTRATADO")):new Long(-1));
				dto.setIdClienteBeneficiario(rs.getString("COD_CLIENTE_BENEFICIARIO")!=null?new Long(rs.getLong("COD_CLIENTE_BENEFICIARIO")):new Long(-1));
				dto.setIdAbonadoBeneficiario(rs.getString("NUM_ABONADO_BENEFICIARIO")!=null?new Long(rs.getLong("NUM_ABONADO_BENEFICIARIO")):new Long(-1));
				prodOf.setIdProductoOfertado(rs.getString("COD_PROD_OFERTADO")!=null?rs.getString("COD_PROD_OFERTADO"):"");
				dto.setProdOfertado(prodOf);
				dto.setIdProductoOfertado(rs.getString("COD_PROD_OFERTADO")!=null?new Long(rs.getLong("COD_PROD_OFERTADO")):new Long(-1));
				dto.setNumProceso(rs.getString("NUM_PROCESO")!=null?rs.getString("NUM_PROCESO"):"");
				dto.setFechaInicioVigencia(rs.getDate("FEC_INICIO_VIGENCIA")!=null?rs.getDate(("FEC_INICIO_VIGENCIA")):new Date());
				dto.setIdCanal(rs.getString("COD_CANAL")!=null?rs.getString("COD_CANAL"):"");
				dto.setOrigenProceso(rs.getString("ORIGEN_PROCESO")!=null?rs.getString(("ORIGEN_PROCESO")):"");
				dto.setFechaProceso(rs.getDate("FEC_PROCESO")!=null?rs.getDate(("FEC_PROCESO")):new Date());
				dto.setIdEstado(rs.getString("COD_ESTADO")!=null?rs.getString(("COD_ESTADO")):"");
				dto.setIndCondicionContratacion(rs.getString("IND_CONDICION_CONTRATACION")!=null?rs.getString(("IND_CONDICION_CONTRATACION")):"");
				dto.setIdClienteContratante(rs.getString("COD_CLIENTE_CONTRATANTE")!=null?new Long(rs.getLong("COD_CLIENTE_CONTRATANTE")):new Long(-1));
				dto.setNumAbonadoContratante(rs.getString("NUM_ABONADO_CONTRATANTE")!=null?new Long(rs.getLong("NUM_ABONADO_CONTRATANTE")):new Long(-1));
				dto.setFechaTerminoVigencia(rs.getDate("FEC_TERMINO_VIGENCIA")!=null?rs.getDate(("FEC_TERMINO_VIGENCIA")):new Date());
				dto.setIndPrioridad(rs.getString("IND_PRIORIDAD")!=null?new Long(rs.getLong("IND_PRIORIDAD")):new Long(-1));
				dto.setIdProdContraPadre(rs.getString("COD_PROD_CONTRAT_PADRE")!=null?new Long(rs.getLong("COD_PROD_CONTRAT_PADRE")):new Long(-1));
				dto.setCodPerfilLista(rs.getString("COD_PERFIL_LISTA")!=null?rs.getString(("COD_PERFIL_LISTA")):"");
				dto.setTipoComportamiento(rs.getString("TIPO_COMPORTAMIENTO")!=null?rs.getString(("TIPO_COMPORTAMIENTO")):"");
				dto.setIndPaquete(rs.getString("IND_PAQUETE")!=null?rs.getString(("IND_PAQUETE")):"");
				retornoOracle.add(dto);
			}			
			ProductoContratadoDTO[] dtoArray=(ProductoContratadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(retornoOracle.toArray(), ProductoContratadoDTO.class);
			listaProductos.setProductosContratadosDTO(dtoArray);			
		
		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener Productos Contratados", e);
			throw new ProductException("Ocurrió un error general al obtener Productos Contratados",e);
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
		logger.debug("obtenerDetalleProductoContratado():end");
		return listaProductos;
	}
}
