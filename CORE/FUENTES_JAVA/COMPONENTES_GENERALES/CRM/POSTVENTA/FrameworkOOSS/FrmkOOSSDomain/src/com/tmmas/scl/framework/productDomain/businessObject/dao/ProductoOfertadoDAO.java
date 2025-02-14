/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 31/05/2007	     	Esteban Conejeros        				Versión Inicial
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
import com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces.ProductoOfertadoDAOIT;
import com.tmmas.scl.framework.productDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ProductoOfertadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ProductoOfertadoListDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductOfferingException;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.ReglasListaNumerosListDTO;


public class ProductoOfertadoDAO extends ConnectionDAO implements
	ProductoOfertadoDAOIT {

	private final Logger logger = Logger.getLogger(ProductoOfertadoDAO.class);

	private final Global global = Global.getInstance();
	
	private String getSQLobtenerDetalleProductos() {
		StringBuffer call = new StringBuffer();
		call.append("DECLARE");
		call.append("	EO_LISTA_PRODUCTOS PF_PROD_OFERT_LISTA_QT;");
		call.append("	SO_LISTA_PRODUCTOS PF_PRODUCTO_OFERTADO_PG.refCursor;");
		call.append("	SN_COD_RETORNO NUMBER;");
		call.append("	SV_MENS_RETORNO VARCHAR2(200);");
		call.append("	SN_NUM_EVENTO NUMBER;");
		call.append("	BEGIN");
		call.append("		EO_LISTA_PRODUCTOS := ?;");
		call.append("		PF_PRODUCTO_OFERTADO_PG.PF_PRODUCTO_S_PR(EO_LISTA_PRODUCTOS,?,?,?,?);");									
		call.append("	END;");
		
		return call.toString();		
	}
	
	
	private String getSQLobtenerProductosOfertables() 
	{
		StringBuffer call = new StringBuffer();
		
		call.append(" DECLARE ");
		call.append("  EO_LISTA_CATEGORIA PF_PRODUCTO_OFER_LISTA_QT; ");
		call.append("  SO_LISTA_CATEGORIA PF_PRODUCTO_OFERTADO_PG.refCursor; ");
		call.append("  SN_COD_RETORNO NUMBER; ");
		call.append("  SV_MENS_RETORNO VARCHAR2(200); ");
		call.append("  SN_NUM_EVENTO NUMBER; ");
		call.append(" BEGIN ");
		call.append("   PF_PRODUCTO_OFERTADO_PG.PF_CATEGORIA_S_PR(?,?,?,?,?); ");    
		call.append(" END; ");
		
		return call.toString();		
	}

	private String getSQLobtenerRestriccionesLista() {
		StringBuffer call = new StringBuffer();
		//AGREGAR INVOCACION A PL
		return call.toString();		
	}
	
	
	/**
	 * Obtiene los servicios por default
	 * 
	 * @param ProductoOfertadoListDTO
	 * @return ProductoOfertadoListDTO
	 * @throws ProductOfferingException
	 */
	public ProductoOfertadoListDTO obtenerDetalleProductos(ProductoOfertadoListDTO listaProductos) throws ProductOfferingException{
		logger.debug("obtenerDetalleProductos():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ProductoOfertadoListDTO listaProductosRetorno = null;
		Connection conn = null;
		OracleCallableStatement cstmt = null;		
		
		String call = getSQLobtenerDetalleProductos();
		try {
		
			logger.debug("listaProductos.getProductoList()[" + listaProductos+ "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());			
			cstmt = (OracleCallableStatement) conn.prepareCall(call);
					
			
			StructDescriptor sd = StructDescriptor.createDescriptor("PF_PRODUCTO_OFERTADO_QT", conn);
			
			ArrayDescriptor ad=null;
			ARRAY aux =null;
			STRUCT[] arreglo=listaProductos.getOracleArray_PF_PRODUCTO_OFERTADO_LISTA_QT(sd, conn);
			
			ad = ArrayDescriptor.createDescriptor("PF_PROD_OFERT_LISTA_QT", conn);
			aux = new ARRAY(ad, conn, arreglo);
			
			//ini------------------CONTINUAR CARGA DE PARAMETROS-------------------			
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
			//fin----------------------------------------------------------------------
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al obtener obtener Detalle Productos");
				throw new ProductOfferingException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			//ini-----------OBTENER CURSORES DE SERVICIOS A ACTIVAR Y DESACTIVAR-------
			
			logger.debug("Recuperando cursor de productos ofertados...");
			ResultSet rs = (ResultSet) cstmt.getObject(2);
			
			listaProductosRetorno = new ProductoOfertadoListDTO();
			
			ArrayList listProdOfertados=new ArrayList();
			ProductoOfertadoDTO productoDTO=null;
			
			while(rs.next())
			{
				String idProdOfertado=rs.getString("COD_PROD_OFERTADO")!=null?rs.getString("COD_PROD_OFERTADO"):"";
				
				for(int i=0;i<listaProductos.getProductoList().length;i++)
				{
					if(listaProductos.getProductoList()[i].getIdProductoOfertado().equals(idProdOfertado))
					{
						productoDTO=listaProductos.getProductoList()[i];					
						productoDTO.setIdProductoOfertado(rs.getString("COD_PROD_OFERTADO")!=null?rs.getString("COD_PROD_OFERTADO"):"");
						productoDTO.setCodCategoriaPlanBasico(rs.getString("COD_CATEGORIA")!=null?rs.getString("COD_CATEGORIA"):"");
						productoDTO.setIndPaquete(rs.getString("IND_PAQUETE")!=null?rs.getString("IND_PAQUETE"):"");
						productoDTO.setDesProdOfertado(rs.getString("DES_PROD_OFERTADO")!=null?rs.getString("DES_PROD_OFERTADO"):"");	
						productoDTO.setCodEspecProd(rs.getString("COD_ESPEC_PROD")!=null?rs.getString("COD_ESPEC_PROD"):"");
						productoDTO.setFecInicioVigencia(rs.getString("FEC_INICIO_VIGENCIA")!=null?rs.getDate("FEC_INICIO_VIGENCIA"):new Date());				
						productoDTO.setIndAplica(rs.getString("IND_NIVEL_APLICA")!=null?rs.getString("IND_NIVEL_APLICA"):"");
						productoDTO.setFecTerminoVigencia(rs.getString("FEC_TERMINO_VIGENCIA")!=null?rs.getDate("FEC_TERMINO_VIGENCIA"):new Date());
						productoDTO.setIdentificadorProductoOfertado(rs.getString("ID_PROD_OFERTADO")!=null?rs.getString("ID_PROD_OFERTADO"):"");				
						productoDTO.setPeriodoContratacion(rs.getString("PERIODO_CONTRATACION")!=null?rs.getString("PERIODO_CONTRATACION"):"");				
						productoDTO.setIndTipoPlataforma(rs.getString("TIPO_PLATAFORMA")!=null?rs.getString("TIPO_PLATAFORMA"):"");
						productoDTO.setMaxContrataciones(rs.getString("MAX_CONTRATACIONES")!=null?rs.getString("MAX_CONTRATACIONES"):"");
						productoDTO.setMaxModificaciones(rs.getString("MAX_MODIFICACIONES")!=null?rs.getString("MAX_MODIFICACIONES"):"");
						
						listProdOfertados.add(productoDTO);
					}
					
				}				
			}
			
			ProductoOfertadoDTO[] prodList=(ProductoOfertadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(listProdOfertados.toArray(), ProductoOfertadoDTO.class);
			listaProductosRetorno.setProductoList(prodList);
			
			//fin-------------------------------------------------------------------
		
		} catch (ProductOfferingException e) {
			logger.debug("ProductOfferingException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener Detalle Productos", e);
			throw new ProductOfferingException("Ocurrió un error general al obtener Detalle Productos",e);
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
		logger.debug("obtenerDetalleProductos():end");
		return listaProductosRetorno;
	}
	
	
	public ProductoOfertadoListDTO obtenerProductosOfertables(AbonadoDTO abonado) throws ProductOfferingException {
		logger.debug("obtenerProductosOfertables():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ProductoOfertadoListDTO listaProductosRetorno = abonado.getProdOfertList();
		
		
		Connection conn = null;
		OracleCallableStatement cstmt = null;
		
		String call = getSQLobtenerProductosOfertables();
		try {
		
			logger.debug("abonado[" + abonado + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = (OracleCallableStatement)conn.prepareCall(call);
			
			
			StructDescriptor sd = StructDescriptor.createDescriptor("PF_PRODUCTO_OFERTADO_QT", conn);
			
			ArrayDescriptor ad=null;
			ARRAY aux =null;
			STRUCT[] arreglo=listaProductosRetorno.getOracleArray_PF_PRODUCTO_OFERTADO_LISTA_QT(sd, conn);
			
			ad = ArrayDescriptor.createDescriptor("PF_PRODUCTO_OFER_LISTA_QT", conn);
			aux = new ARRAY(ad, conn, arreglo);
			
			//ini------------------CONTINUAR CARGA DE PARAMETROS-------------------			
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
			//fin----------------------------------------------------------------------
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al obtener obtener Productos Ofertables");
				throw new ProductOfferingException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			//ini-----------OBTENER CURSORES DE SERVICIOS A ACTIVAR Y DESACTIVAR-------
			ArrayList retornoPL=new ArrayList();
			ProductoOfertadoDTO dto=null;
			ProductoOfertadoDTO[] dtoList=null;
			ResultSet rs=(ResultSet)cstmt.getObject(2);
			
			while(rs.next())
			{
				dto=new ProductoOfertadoDTO();
				
				dto.setCodCategoriaPlanBasico(rs.getString("COD_CATEGORIA")!=null?rs.getString("COD_CATEGORIA"):"");
				dto.setIdProductoOfertado(rs.getString("COD_PROD_OFERTADO")!=null?rs.getString("COD_PROD_OFERTADO"):"");
				dto.setIndAplica(rs.getString("IND_NIVEL_APLICA")!=null?rs.getString("IND_NIVEL_APLICA"):"");
				dto.setIndPaquete(rs.getString("IND_PAQUETE")!=null?rs.getString("IND_PAQUETE"):"");
				retornoPL.add(dto);				
			}
			dtoList=(ProductoOfertadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(retornoPL.toArray(), ProductoOfertadoDTO.class);
			listaProductosRetorno.setProductoList(dtoList);	
			
			//fin-------------------------------------------------------------------
		
		} catch (ProductOfferingException e) {
			logger.debug("ProductOfferingException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener Productos Ofertables", e);
			throw new ProductOfferingException("Ocurrió un error general al obtener Productos Ofertables",e);
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
		logger.debug("obtenerProductosOfertables():end");
		return listaProductosRetorno;
	}	

	public ReglasListaNumerosListDTO obtenerRestriccionesLista(ProductoOfertadoListDTO listaProductos) throws ProductOfferingException {
		logger.debug("obtenerProductosOfertables():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ReglasListaNumerosListDTO listaReglaNumeros = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerRestriccionesLista();
		try {
		
			logger.debug("listaProductos.getProductoList()[" + listaProductos.getProductoList() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			// cstmt.setLong(1, param.getNumAbonado());
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
				logger.error(" Ocurrió un error al obtener obtener Productos Ofertables");
				throw new ProductOfferingException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			//ini-----------OBTENER CURSORES DE SERVICIOS A ACTIVAR Y DESACTIVAR-------
			listaReglaNumeros = new ReglasListaNumerosListDTO();
			//fin-------------------------------------------------------------------
		
		} catch (ProductOfferingException e) {
			logger.debug("ProductOfferingException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener Productos Ofertables", e);
			throw new ProductOfferingException("Ocurrió un error general al obtener Productos Ofertables",e);
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
		logger.debug("obtenerProductosOfertables():end");
		return listaReglaNumeros;
	}




	}

