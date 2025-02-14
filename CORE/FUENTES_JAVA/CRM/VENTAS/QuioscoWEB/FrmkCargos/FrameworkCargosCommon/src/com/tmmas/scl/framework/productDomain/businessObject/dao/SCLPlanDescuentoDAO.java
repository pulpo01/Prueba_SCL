/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 13/07/2007	     	Elizabeth Vera        				Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.businessObject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces.SCLPlanDescuentoDAOIT;
import com.tmmas.scl.framework.productDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RegistroSolicitudDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.exception.ProductOfferingPriceException;

public class SCLPlanDescuentoDAO extends ConnectionDAO implements SCLPlanDescuentoDAOIT{

	private final Logger logger = Logger.getLogger(SCLPlanDescuentoDAO.class);

	private final Global global = Global.getInstance();
			 
	private String getSQLcrearSolicitud() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   so_solicitud PV_SOLICITUD_QT := PV_INICIA_ESTRUCTURAS_PG.PV_SOLICITUD_QT_FN;");
		call.append(" BEGIN ");
		call.append("   so_solicitud.NUM_VENTA := ?;");
		call.append("   so_solicitud.LIN_AUTORIZA := ?;");
		call.append("   so_solicitud.COD_OFICINA := ?;");
		call.append("   so_solicitud.COD_ESTADO := ?;");
		call.append("   so_solicitud.NUM_AUTORIZACION := ?;");
		call.append("   so_solicitud.COD_VENDEDOR := ?;");
		call.append("   so_solicitud.NUM_UNIDADES := ?;");
		call.append("   so_solicitud.PRECIO_ORIGEN := ?;");
		call.append("   so_solicitud.IND_TIPO_VENTA := ?;");
		call.append("   so_solicitud.COD_CLIENTE := ?;");
		call.append("   so_solicitud.COD_MOD_VENTA := ?;");
		call.append("   so_solicitud.NOM_USUARIO_VENTA := ?;");
		call.append("   so_solicitud.COD_CONCEPTO := ?;");
		call.append("   so_solicitud.IMP_CARGO := ?;");
		call.append("   so_solicitud.COD_MONEDA := ?;");
		call.append("   so_solicitud.NUM_ABONADO := ?;");
		call.append("   so_solicitud.NUM_SERIE := ?;");
		call.append("   so_solicitud.COD_CONCEPTO_DESC := ?;");
		call.append("   so_solicitud.VAL_DESCUENTO := ?;");
		call.append("   so_solicitud.TIP_DESCUENTO := ?;");
		call.append("   so_solicitud.IND_MODIFICACION := ?;");
		call.append("   so_solicitud.COD_ORIGEN := ?;");
		call.append("   PV_PLAN_DESCUENTO_PG.PV_CREAR_SOLICITUD_PR( so_solicitud, ?, ?, ?);");
		call.append(" END;");	
		return call.toString();		
	}	
	
	private String getSQLconsultarEstadoSolicitud() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   so_solicitud PV_SOLICITUD_QT := PV_INICIA_ESTRUCTURAS_PG.PV_SOLICITUD_QT_FN;");
		call.append(" BEGIN ");
		call.append("   so_solicitud.NUM_AUTORIZACION := ?;");
		call.append("   PV_PLAN_DESCUENTO_PG.PV_CONSULTAR_EST_SOLICITUD_PR( so_solicitud, ?, ?, ?);");
		call.append("   			? := so_solicitud.COD_ESTADO;");
		call.append(" END;");	
		return call.toString();		
	}
	
	private String getSQLEliminarSolicitudDescuento() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   so_solicitud PV_SOLICITUD_QT := PV_INICIA_ESTRUCTURAS_PG.PV_SOLICITUD_QT_FN;");
		call.append(" BEGIN ");
		call.append("   so_solicitud.NUM_AUTORIZACION := ?;");
		call.append("   so_solicitud.NUM_VENTA := ?;");
		call.append("   PV_PLAN_DESCUENTO_PG.PV_ELIMINAR_SOLICITUD_PR( so_solicitud, ?, ?, ?);");
		call.append(" END;");	
		return call.toString();		
	}
	
	/**
	 * Elimina la solicitud de descuento si su estado no es Autorizado
	 * 
	 * @param registro
	 * @return RegistroSolicitudDTO
	 * @throws ProductOfferingPriceException
	 */	
	public RetornoDTO eliminarSolicitudDescuento(RegistroSolicitudDTO registro) throws ProductOfferingPriceException{
		
		logger.debug("eliminarSolicitudDescuento():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = new RetornoDTO();
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLEliminarSolicitudDescuento();
		
		try {
	
			logger.debug("registro.getNumeroAutorizacion()[" + registro.getNumeroAutorizacion() + "]");
			logger.debug("registro.getNumeroVenta()[" + registro.getNumeroVenta() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			cstmt = conn.prepareCall(call);

			
			
			cstmt.setLong(1, registro.getNumeroAutorizacion()); //NUM_AUTORIZACION
			cstmt.setLong(2, registro.getNumeroVenta()); //NUM_VENTA
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);			
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			
			
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
				logger.error(" Ocurrió un error al eliminar la solicitud");
				throw new ProductOfferingPriceException(String.valueOf(codError),numEvento, msgError);
			}
						
			retorno.setCodigo(String.valueOf(codError));
			retorno.setDescripcion(msgError);
		
		} catch (ProductOfferingPriceException e) {
			logger.debug("ProductOfferingPriceException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener estado de la solictud", e);
			throw new ProductOfferingPriceException("Ocurrió un error general al obtener estado de la solicitud",e);
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
		logger.debug("consultarEstadoSolicitud():end");
		return retorno;		
	}
	
	
	/**
	 * Crea solicitud de aprobación del rango de descuento asociado al vendedor en una venta
	 * 
	 * @param registro
	 * @return RetornoDTO
	 * @throws ProductOfferingPriceException
	 */	
	public RetornoDTO crearSolicitud(RegistroSolicitudDTO registro) throws ProductOfferingPriceException{
		logger.debug("crearSolicitud():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLcrearSolicitud();
		
		try {
		
			logger.debug("registro.getNumeroVenta()[" + registro.getNumeroVenta() + "]");
			logger.debug("registro.getLinAutoriza()[" + registro.getLinAutoriza() + "]");
			logger.debug("registro.getCodigoOficina()[" + registro.getCodigoOficina() + "]");
			logger.debug("registro.getCodigoEstado()[" + registro.getCodigoEstado() + "]");
			logger.debug("registro.getNumeroAutorizacion()[" + registro.getNumeroAutorizacion() + "]");
			logger.debug("registro.getCodigoVendedor()[" + registro.getCodigoVendedor() + "]");
			logger.debug("registro.getNumeroUnidades()[" + registro.getNumeroUnidades() + "]");
			logger.debug("registro.getPrecioOrigen()[" + registro.getPrecioOrigen() + "]");
			logger.debug("registro.getIndicadorTipoVenta()[" + registro.getIndicadorTipoVenta() + "]");
			logger.debug("registro.getCodigoCliente()[" + registro.getCodigoCliente() + "]");
			logger.debug("registro.getCodigoModalidadVenta()[" + registro.getCodigoModalidadVenta() + "]");
			logger.debug("registro.getNombreUsuarioVenta()[" + registro.getNombreUsuarioVenta() + "]");
			logger.debug("registro.getCodigoConcepto()[" + registro.getCodigoConcepto() + "]");
			logger.debug("registro.getImporteCargo()[" + registro.getImporteCargo() + "]");
			logger.debug("registro.getCodigoMoneda()[" + registro.getCodigoMoneda() + "]");
			logger.debug("registro.getNumeroAbonado()[" + registro.getNumeroAbonado() + "]");
			logger.debug("registro.getNumeroSerie()[" + registro.getNumeroSerie() + "]");
			logger.debug("registro.getCodigoConceptoDescuento()[" + registro.getCodigoConceptoDescuento() + "]");
			logger.debug("registro.getValorDescuento()[" + registro.getValorDescuento() + "]");
			logger.debug("registro.getTipoDescuento()[" + registro.getTipoDescuento() + "]");
			logger.debug("registro.getIndicadorModificacion()[" + registro.getIndicadorModificacion() + "]");
			logger.debug("registro.getCodigoOrigen()[" + registro.getCodigoOrigen() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			cstmt = conn.prepareCall(call);

			cstmt.setLong(1, registro.getNumeroVenta()); //NUM_VENTA
			cstmt.setLong(2, registro.getLinAutoriza()); //LIN_AUTORIZA
			cstmt.setString(3, registro.getCodigoOficina()); //COD_OFICINA
			cstmt.setString(4, registro.getCodigoEstado()); //COD_ESTADO
			cstmt.setLong(5, registro.getNumeroAutorizacion()); //NUM_AUTORIZACION
			cstmt.setLong(6, registro.getCodigoVendedor()); //COD_VENDEDOR
			cstmt.setLong(7, registro.getNumeroUnidades()); //NUM_UNIDADES
			cstmt.setFloat(8, registro.getPrecioOrigen()); //PRECIO_ORIGEN
			cstmt.setInt(9, registro.getIndicadorTipoVenta()); //IND_TIPO_VENTA
			cstmt.setLong(10, registro.getCodigoCliente()); //COD_CLIENTE
			cstmt.setInt(11, registro.getCodigoModalidadVenta()); //COD_MOD_VENTA
			cstmt.setString(12, registro.getNombreUsuarioVenta()); //NOM_USUARIO_VENTA
			cstmt.setInt(13, registro.getCodigoConcepto()); //COD_CONCEPTO
			cstmt.setFloat(14, registro.getImporteCargo()); //IMP_CARGO
			cstmt.setString(15, registro.getCodigoMoneda()); //COD_MONEDA
			cstmt.setLong(16, registro.getNumeroAbonado()); //NUM_ABONADO
			cstmt.setString(17, registro.getNumeroSerie()); //NUM_SERIE
			cstmt.setInt(18, registro.getCodigoConceptoDescuento()); //COD_CONCEPTO_DESC
			cstmt.setFloat(19, registro.getValorDescuento()); //VAL_DESCUENTO
			cstmt.setInt(20, registro.getTipoDescuento()); //TIP_DESCUENTO
			cstmt.setInt(21, registro.getIndicadorModificacion()); //IND_MODIFICACION
			cstmt.setString(22, registro.getCodigoOrigen()); //COD_ORIGEN
			
			cstmt.registerOutParameter(23, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(24, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(25, java.sql.Types.NUMERIC);			
		
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(23);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(24);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(25);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al crear solicitud de aprobación de descuento");
				throw new ProductOfferingPriceException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");

			retorno = new RetornoDTO();
			retorno.setDescripcion(msgError);
		
		} catch (ProductOfferingPriceException e) {
			logger.debug("ProductOfferingPriceException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al crear solicitud de aprobación de descuento", e);
			throw new ProductOfferingPriceException("Ocurrió un error general al crear solicitud de aprobación de descuentol",e);
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
		logger.debug("crearSolicitud():end");
		return retorno;
	}
	
	/**
	 * Obtiene estado de la solicitud
	 * 
	 * @param registro
	 * @return RegistroSolicitudDTO
	 * @throws ProductOfferingPriceException
	 */	
	public RegistroSolicitudDTO consultarEstadoSolicitud(RegistroSolicitudDTO registro) throws ProductOfferingPriceException{
		
		logger.debug("consultarEstadoSolicitud():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RegistroSolicitudDTO retorno = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLconsultarEstadoSolicitud();
		
		try {
	
			logger.debug("registro.getNumeroAutorizacion()[" + registro.getNumeroAutorizacion() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			cstmt = conn.prepareCall(call);

			cstmt.setLong(1, registro.getNumeroAutorizacion()); //NUM_AUTORIZACION
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);			
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			
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
				logger.error(" Ocurrió un error al obtener estado de la solicitud");
				throw new ProductOfferingPriceException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			String codigoEstado = cstmt.getString(5);
			logger.debug("codigoEstado[" + codigoEstado + "]");
			
			retorno = registro;
			retorno.setCodigoEstado(codigoEstado);
		
		} catch (ProductOfferingPriceException e) {
			logger.debug("ProductOfferingPriceException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener estado de la solictud", e);
			throw new ProductOfferingPriceException("Ocurrió un error general al obtener estado de la solicitud",e);
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
		logger.debug("consultarEstadoSolicitud():end");
		return retorno;		
	}
}
