/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 *04/06/2007	     	Elizabeth Vera        				Versi�n Inicial
 */
package com.tmmas.scl.framework.productDomain.businessObject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ImpuestosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioCargoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioTerminalDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces.CargoDAOIT;
import com.tmmas.scl.framework.productDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CargoListDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.DatosGeneralesDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ParamCargosAbonadoCeroDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegistroFacturacionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.TerminalDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.CargoIndemnizQTDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.CargosDevlEquipoAccesorioQTDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.DetallePresupuestoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ParamBajaIndemnizacionQTDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PresupuestoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PvGaImpenalizaQTDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.exception.ProductOfferingPriceException;

public class CargoDAO extends ConnectionDAO implements CargoDAOIT {

	private final Logger logger = Logger.getLogger(CargoDAO.class);

	private final Global global = Global.getInstance();
	
	
	private String getSQLinsertarConceptoDescuento(){
		StringBuffer call = new StringBuffer();
		call.append(" BEGIN ");
		call.append("   p_concepto_descuento(?,?);");
		call.append(" END;");
		return call.toString();
	}
		
	private String getSQLObtieneCodConceptoDescuento(){
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append(" BEGIN ");
		call.append(" PV_CARGOS_PG.PV_OBTIENECODCONCEPTO_PR(?,?,?,?,?);");
		call.append(" END;");
		return call.toString();
	}
	
	private String getSQLEliminaCodConceptoDescuento(){
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append(" BEGIN ");
		call.append(" PV_CARGOS_PG.PV_ELIMINACODCONCEPTO_PR(?,?,?,?);");
		call.append(" END;");
		return call.toString();
	}
  // INICIO FPP COL 14/04/2009 85562
	private String getSQLEliminarFactura() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append(" EV_COD_ESTADOC VARCHAR2(200);");
		call.append(" EV_COD_ESTPROC VARCHAR2(200);");
		call.append(" EV_COD_CATRIBDOC VARCHAR2(200);");
		call.append(" EV_NUM_FOLIO VARCHAR2(200);");
		call.append(" EV_PREF_PLAZA VARCHAR2(200);");
		call.append(" EV_FEC_VENCIMIENTO VARCHAR2(200);");
		call.append(" EV_NOM_USUAELIM VARCHAR2(200);");
		call.append(" EV_COD_CAUSAELIM VARCHAR2(200);");
		call.append(" EV_NUM_PROCESO VARCHAR2(200);");
		call.append(" EV_NUM_VENTA VARCHAR2(200);");
		call.append(" SN_COD_RETORNO NUMBER;");
		call.append(" SV_MENS_RETORNO VARCHAR2(200);");
		call.append(" SN_NUM_EVENTO NUMBER;");
		call.append(" BEGIN ");
		call.append(" EV_COD_ESTADOC := ?;");
		call.append(" EV_COD_ESTPROC := ?;");
		call.append(" EV_COD_CATRIBDOC := ?;");
		call.append(" EV_NUM_FOLIO := ?;");
		call.append(" EV_PREF_PLAZA := ?;");
		call.append(" EV_FEC_VENCIMIENTO := ?;");
		call.append(" EV_NOM_USUAELIM := ?;");
		call.append(" EV_COD_CAUSAELIM := ?;");
		call.append(" EV_NUM_PROCESO := ?;");
		call.append(" EV_NUM_VENTA := ?;");
		call.append(" SN_COD_RETORNO := ?;");
		call.append(" SV_MENS_RETORNO := ?;");
		call.append(" SN_NUM_EVENTO := ?;");
		call.append(" VE_SERVICIOS_VENTA_PG.VE_ACTUALIZA_FACTURACION_PR ( EV_COD_ESTADOC, EV_COD_ESTPROC, EV_COD_CATRIBDOC, EV_NUM_FOLIO, EV_PREF_PLAZA, EV_FEC_VENCIMIENTO, EV_NOM_USUAELIM, EV_COD_CAUSAELIM, EV_NUM_PROCESO, EV_NUM_VENTA, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO );");
		call.append(" END; ");
		return call.toString();		
	}
	// FIN FPP COL 14/04/2009 85562
	private String getSQLobtenerImpuestos() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   so_presupuesto GA_PRESUPUESTO_QT := PV_INICIA_ESTRUCTURAS_PG.PV_INICIA_GA_PRESUPUESTO_QT_FN;");
		call.append(" BEGIN ");
		call.append("   so_presupuesto.NUM_PROCESO := ?;");
		call.append("   PV_CARGOS_PG.PV_OBTENER_IMPUESTOS_PR( so_presupuesto, ?, ?, ?);");
		call.append("		? := so_presupuesto.IMP_BASE;");
		call.append("		? := so_presupuesto.IMP_DTO;");		
		call.append("		? := so_presupuesto.IMP_IMPUESTO;");
		call.append(" END;");		
		return call.toString();		
	}	

	private String getSQLobtenerDetalleCargos() {
		StringBuffer call = new StringBuffer();
		//AGREGAR INVOCACION A PL
		return call.toString();		
	}
		
	private String getSQLaceptarPresupuesto() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   so_presupuesto GA_PRESUPUESTO_QT := PV_INICIA_ESTRUCTURAS_PG.PV_INICIA_GA_PRESUPUESTO_QT_FN;");
		call.append(" BEGIN ");
		call.append("   so_presupuesto.NUM_PROCESO := ?;");
		call.append("   so_presupuesto.NUM_VENTA := ?;");
		call.append("   so_presupuesto.TIP_FOLIACION := ?;");
		call.append("   so_presupuesto.FECHA_VCTO := ?;");
		call.append("   PV_CARGOS_PG.PV_ACEPTAR_PRESUPUESTO_PR( so_presupuesto, ?, ?, ?);");
		call.append(" END;");		
		return call.toString();		
	}	
	
	private String getSQLvalidarPlanFreedomEnVenta() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   so_param PV_VAL_FREEDOM_QT := PV_INICIA_ESTRUCTURAS_PG.PV_VAL_FREEDOM_QT_FN;");
		call.append(" BEGIN ");
		call.append("   so_param.PARAM_PROPOR_VTA := ?;");
		call.append("   so_param.NUM_VENTA := ?;");
		call.append("   so_param.PARAM_PROPOR1 := ?;");
		call.append("   so_param.PARAM_PROPOR2 := ?;");
		call.append("   PV_CARGOS_PG.PV_VALIDA_FREEDOM_VENTA_PR( so_param, ?, ?, ?);");
		call.append("   			? := so_param.RESULTADO;");		
		call.append(" END;");		
		return call.toString();		
	}	

	private String getSQLObtenerCargosDevlEquipo() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE"); 
		call.append("   EO_GAT_DEVLEQUIP PV_GAT_DEVLEQUIP_QT:= PV_INICIA_ESTRUCTURAS_PG.PV_GAT_DEVLEQUIP_QT_FN;");
		call.append(" BEGIN ");
		call.append("   EO_GAT_DEVLEQUIP.cod_producto    := ?;");       
		call.append("   EO_GAT_DEVLEQUIP.cod_concepto    := ?;");
		call.append("   EO_GAT_DEVLEQUIP.cod_categoria   := ?;");
		call.append("   EO_GAT_DEVLEQUIP.cod_modpago     := ?;"); 
		call.append("   EO_GAT_DEVLEQUIP.cod_estado_dev  := ?;"); 
		call.append("   EO_GAT_DEVLEQUIP.cod_tipcontrato := ?;");  
		call.append("   EO_GAT_DEVLEQUIP.num_meses       := ?;");  
		call.append("   EO_GAT_DEVLEQUIP.cod_antiguedad  := ?;");
		call.append("   EO_GAT_DEVLEQUIP.cod_operacion   := ?;"); 
		call.append("   EO_GAT_DEVLEQUIP.ind_causa       := ?;");
		call.append("   EO_GAT_DEVLEQUIP.cod_causa       := ?;");
		call.append(" PV_CARGOS_PG.PV_CARGOSESTDEVLEQUP_PR ( EO_GAT_DEVLEQUIP,? ,?, ?, ?);");
		
		call.append("END;");
	   return call.toString();
	}
	
	private String getSQLObtenerCargosPenalizacion() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE "); 
		call.append("   EO_GA_IMPPLZ PV_GA_IMPPENALIZA_QT:=PV_INICIA_ESTRUCTURAS_PG.PV_GA_IMPPENALIZA_QT_FN;");
		call.append("	BEGIN ");
		call.append("      EO_GA_IMPPLZ.COD_PRODUCTO:= ?;");
		call.append("      EO_GA_IMPPLZ.COD_PENALIZA:= ?;");
		call.append("      PV_CARGOS_PG.PV_CARGOSBAJAPENALIZ_PR ( EO_GA_IMPPLZ, ?,?, ?, ? );");
       
        call.append(" END;");
	   return call.toString();
	}
	
	private String getSQLObtenerParamIndemniz(){
		StringBuffer call = new StringBuffer();
			call.append(" 	DECLARE "); 
			call.append(" 	EO_GA_PINDEMNIZ_QT PV_GA_PARAMBAJAINDEMNIZ_QT:=PV_INICIA_ESTRUCTURAS_PG.PV_GA_PARAMBAJAINDEMNIZ_QT_FN; ");
			call.append(" 	BEGIN  ");
			call.append(" 	    EO_GA_PINDEMNIZ_QT.cod_producto :=?; ");
			call.append(" 	    EO_GA_PINDEMNIZ_QT.num_abonado  :=?; ");
		    call.append(" 	PV_CARGOS_PG.PV_OBTIENEPARAMBAJINDEMZ_PR ( EO_GA_PINDEMNIZ_QT,?, ?,?,? ); ");
			call.append(" 	END; ");
		return call.toString();
	}
	
	private String getSQLObtenerParamAbonadoCero(){
		StringBuffer call = new StringBuffer();
			call.append(" 	DECLARE "); 
			call.append(" 	BEGIN  ");
			call.append(" 	PV_CARGOS_PG.PV_CARGOSABONADOCERO_PR ( ?,?,?,?,?,? );");
			call.append(" 	END; ");
		return call.toString();
	}
	
	private String getSQLObtenerCargosIndemnizacion(){
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE"); 
		call.append("     EO_GA_CARGINDEMZ PV_GA_CARGOSBINDEMNIZ_QT:= PV_INICIA_ESTRUCTURAS_PG.PV_GA_CARGOSBINDEMNIZ_QT_FN;");
		call.append("  BEGIN");
		call.append("     EO_GA_CARGINDEMZ.cod_producto := ?;");
		call.append("     EO_GA_CARGINDEMZ.cod_actabo := ?;");
		call.append(" 	  EO_GA_CARGINDEMZ.cod_tipserv := ?;");
		call.append(" 	  EO_GA_CARGINDEMZ.cod_servicio := ?; ");
		call.append(" 	  EO_GA_CARGINDEMZ.meses_contrato:= ?;");
		call.append("     EO_GA_CARGINDEMZ.num_meses:= ?;");
		call.append("  PV_CARGOS_PG.PV_CARGOSBAJAINDEMNIZ_PR ( EO_GA_CARGINDEMZ,?,?,?,? );");
		call.append("  END;");
		return call.toString();
	}
	
	private String getSQLconsultarEstadoFacturado(){
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append(" 	numProceso NUMBER(8); ");
		call.append("  BEGIN");
		call.append("   numProceso:= ?;");
		call.append("  	? := PV_CARGOS_PG.PV_ConsultarEstadoFact_FN(numProceso,?,?,? );");
		call.append("  END;");
		return call.toString();
	}
	
	private String getSQLobtenerDetallePresupuesto(){
		StringBuffer call = new StringBuffer();
		call.append("  BEGIN");
		call.append("  		PV_CARGOS_PG.PV_ObtenerDetallePresup_PR ( ?,?,?,?,? );");
		call.append("  END;");
		return call.toString();
	}	

	private String getSQLEliminarPresupuesto() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   fa_presupuesto FA_PRESUPUESTO_QT := PV_INICIA_ESTRUCTURAS_PG.FA_PRESUPUESTO_QT_FN;");
		call.append(" BEGIN ");
		call.append("   fa_presupuesto.NUM_PROCESO := ?;");
		call.append("   FA_PRESUPUESTO_SN_PG.FA_PRESUPUESTO_BORRA_PR( fa_presupuesto, ?, ?, ?);");
		call.append(" END;");	
		return call.toString();		
	}
	
	private String getSQLobtenerCodigoModalidad() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   so_abonado GA_ABONADO_QT := PV_INICIA_ESTRUCTURAS_PG.PV_INICIA_GA_ABONADO_QT_FN;");
		call.append(" BEGIN ");
		call.append("   so_abonado.SERVICIO := ?;");
		call.append("   PV_CARGOS_PG.PV_OBTIENE_DESCRIP_MODPAGOS_PR( so_abonado, ?, ?, ?);");
		call.append("   			? := so_abonado.MODALIDAD_DE_PAGO;");	
		call.append(" END;");	
		return call.toString();		
	}
	
	private String getSQLConsultaCargoBasicoCliente(){
		StringBuffer call = new StringBuffer();
			call.append(" 	DECLARE "); 
			call.append(" 	BEGIN  ");
			call.append(" 	FA_DCTO_CLTE_SN_PG.FA_CONS_CARGO_BASICO_CLTE (?,?,?,?,?,? ); ");
			call.append(" 	END; ");
		return call.toString();
	}
	
	private String getSQLValidaAbonadoCeroPorCodCliente(){
		StringBuffer call = new StringBuffer();
			call.append(" 	DECLARE "); 
			call.append(" 	BEGIN  ");
			call.append(" 	VE_ABONADO_0_PG.VE_VALIDA_ABONADO_PR ( ?,?,?,? ); ");
			call.append(" 	END; ");
		return call.toString();		
	}
	
	private String getSQLPrecioEquipoActual(){
		StringBuffer call = new StringBuffer();
			call.append("");
			call.append("BEGIN"); 
			call.append("	PV_CAMBIO_SERIE_SB_PG.PV_REC_PREC_EQUIPO_ACTUAL_PR ( ?,?,?,?,?,?,?);");
			call.append("END;");
		return call.toString();
	}
	
	/**
	 * Eliminar Presupuesto
	 * 
	 * @param registro
	 * @return RetornoDTO
	 * @throws ProductOfferingPriceException
	 */	
	public RetornoDTO eliminarPresupuesto(RegistroFacturacionDTO registro)
			throws ProductOfferingPriceException {
		logger.debug("eliminarPresupuesto():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLEliminarPresupuesto();
		try {
		
			logger.debug("registro.getNumeroProcesoFacturacion()[" + registro.getNumeroProcesoFacturacion()+ "]");
		
			conn = getConnectionFromWLSInitialContext(global.getJndiForSCLDataSource());
			
			cstmt = conn.prepareCall(call);
			cstmt.setString(1, registro.getNumeroProcesoFacturacion());
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
				logger.error(" Ocurri� un error al eliminar el Presupuesto");
				throw new ProductOfferingPriceException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");

			retorno = new RetornoDTO();
			retorno.setCodigo("0");
			retorno.setDescripcion(msgError);
			
		} catch (ProductOfferingPriceException e) {
			logger.debug("ProductOfferingPriceException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurri� un error general al eliminar el Presupuesto", e);
			throw new ProductOfferingPriceException("Ocurri� un error general al eliminar el presupuesto",e);
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
		logger.debug("eliminarPresupuesto():end");
		return retorno;

	}
	
	
	
	/**
	 * Obtiene impuestos
	 * 
	 * @param  ImpuestosDTO
	 * @return ImpuestosDTO
	 * @throws ProductOfferingPriceException
	 */
	public ImpuestosDTO obtenerImpuestos(ImpuestosDTO impuestos) throws ProductOfferingPriceException{
		logger.debug("obtenerImpuestos():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ImpuestosDTO retorno = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerImpuestos();
		try {
		
			logger.debug("impuestos.getNumProceso()[" + impuestos.getNumProceso() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForSCLDataSource());
			
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, impuestos.getNumProceso());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);			
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC); //IMP_BASE
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC); //IMP_DTO
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC); //IMP_IMPUESTO
			
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
				logger.error(" Ocurri� un error al obtener impuestos");
				throw new ProductOfferingPriceException(String.valueOf(codError),numEvento, msgError);
			}
			
			//obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");
			float impBase = cstmt.getFloat(5);
			logger.debug("impBase[" + impBase + "]");
			float impDTO = cstmt.getFloat(6);
			logger.debug("impDTO[" + impDTO + "]");
			float impIMP = cstmt.getFloat(7);
			logger.debug("impIMP[" + impIMP + "]");
			retorno = impuestos;
			retorno.setTotalCargos(impBase);
			retorno.setTotalDescuentos(impDTO);
			retorno.setTotalImpuestos(impIMP);
		
		} catch (ProductOfferingPriceException e) {
			logger.debug("ProductOfferingPriceException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurri� un error general al obtener impuestos", e);
			throw new ProductOfferingPriceException("Ocurri� un error general al obtener impuestos",e);
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
		logger.debug("obtenerImpuestos():end");
		return retorno;
	}

	public CargoListDTO obtenerDetalleCargos(CargoListDTO cargoList) throws ProductOfferingPriceException 
	{
		logger.debug("obtenerDetalleCargos():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		CargoListDTO retorno = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerDetalleCargos();
		try {
		
			logger.debug("cargoList.getCargoList()[" +cargoList.getCargoList() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForSCLDataSource());
			
			cstmt = conn.prepareCall(call);
			//cstmt.setLong(1, bolsa.getCodCliente());
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
				logger.error(" Ocurri� un error al obtener el detalle de los cargos");
				throw new ProductOfferingPriceException(String.valueOf(codError),numEvento, msgError);
			}
			
			//obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");
			//ini--------------RESCATAR RETORNO-------
			retorno = new CargoListDTO();
			//fin----------------------------------------------------------------------
		
		} catch (ProductOfferingPriceException e) {
			logger.debug("ProductOfferingPriceException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurri� un error general al actualizar bolsa dinamica", e);
			throw new ProductOfferingPriceException("Ocurri� un error general al actualizar bolsa dinamica",e);
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
		logger.debug("obtenerDetalleCargos():end");
		return retorno;
	}
	
	/**
	 * Ejecuta Facturacion
	 * 
	 * @param  PresupuestoDTO
	 * @return RetornoDTO
	 * @throws ProductOfferingPriceException
	 */
	public RetornoDTO aceptarPresupuesto(PresupuestoDTO presup) throws ProductOfferingPriceException{
		logger.debug("aceptarPresupuesto():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLaceptarPresupuesto();
		try {
		
			logger.debug("presup.getNumProceso()[" + presup.getNumProceso() + "]");
			logger.debug("presup.getNumVenta()[" + presup.getNumVenta() + "]");
			logger.debug("presup.getTipoFoliacion()[" + presup.getTipoFoliacion() + "]");
			logger.debug("presup.getFechaVcto()[" + presup.getFechaVcto()+ "]");

			conn = getConnectionFromWLSInitialContext(global.getJndiForSCLDataSource());
		
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, presup.getNumProceso()); //NUM_PROCESO
			cstmt.setLong(2, presup.getNumVenta()); //NUM_VENTA
			cstmt.setString(3, presup.getTipoFoliacion()); //TIP_FOLIACION
			cstmt.setDate(4, new java.sql.Date(presup.getFechaVcto().getTime())); //FECHA_VCTO
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
				logger.error(" Ocurri� un error al aceptar presupuesto");
				throw new ProductOfferingPriceException(String.valueOf(codError),numEvento, msgError);
			}
			
			retorno = new RetornoDTO();
			retorno.setDescripcion(msgError);
		
		} catch (ProductOfferingPriceException e) {
			logger.debug("ProductOfferingPriceException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurri� un error general al aceptar presupuesto", e);
			throw new ProductOfferingPriceException("Ocurri� un error general al aceptar presupuesto",e);
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
		logger.debug("aceptarPresupuesto():end");
		return retorno;
	}
	
	public PrecioCargoDTO[] getCargosDevolucionEquipoAccesorio(CargosDevlEquipoAccesorioQTDTO cargosDevlEquipoAccesorioQTDTO)throws ProductOfferingPriceException{
		logger.debug("getCargosDevolucionEquipoAccesorio():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		PrecioCargoDTO[] retValue = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs=null;
		String call = getSQLObtenerCargosDevlEquipo();
		
		try {
			logger.debug("getCargosDevolucionEquipo()");
			conn = getConnectionFromWLSInitialContext(global.getJndiForSCLDataSource());
			cstmt = conn.prepareCall(call);
			logger.debug(" Valiables de Entrada");
			cstmt.setLong(1,cargosDevlEquipoAccesorioQTDTO.getCod_Producto());
			cstmt.setLong(2,cargosDevlEquipoAccesorioQTDTO.getCod_Concepto());
			cstmt.setString(3,cargosDevlEquipoAccesorioQTDTO.getCod_Categoria());
			cstmt.setLong(4,cargosDevlEquipoAccesorioQTDTO.getCod_Modpago());
			cstmt.setString(5,cargosDevlEquipoAccesorioQTDTO.getCod_Estado_Dev());
			cstmt.setString(6,cargosDevlEquipoAccesorioQTDTO.getCod_Tipcontrato());
			cstmt.setLong(7,cargosDevlEquipoAccesorioQTDTO.getNum_Meses());
			cstmt.setString(8,cargosDevlEquipoAccesorioQTDTO.getCod_Antiguedad());
			cstmt.setString(9,cargosDevlEquipoAccesorioQTDTO.getCod_Operacion());
			cstmt.setLong(10,cargosDevlEquipoAccesorioQTDTO.getInd_Causa());
			cstmt.setString(11,cargosDevlEquipoAccesorioQTDTO.getCod_Causa());
			
			logger.debug(" Valiables de Salida");
			cstmt.registerOutParameter(12, oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(13, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(15, java.sql.Types.NUMERIC);	
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(13);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(14);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(15);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
			    logger.error(" Ocurri� un error al obtener cargos por devoluci�n de equipo");
			     throw new ProductOfferingPriceException(String.valueOf(codError),numEvento, msgError);
			}
			else{
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(12);
				while (rs.next()) {
					PrecioCargoDTO precioDTO = new PrecioCargoDTO();
					precioDTO.setIndicadorAutMan(rs.getString(1));
					precioDTO.setDescripcionConcepto(rs.getString(2));
					precioDTO.setNumeroUnidades(rs.getString(3));
					precioDTO.setMonto(rs.getFloat(4));
					precioDTO.setDescripcionMoneda(rs.getString(5));
					precioDTO.setCodigoConcepto(rs.getString(6));
					precioDTO.setCodigoMoneda(rs.getString(7));
					precioDTO.setImpDevAcc(rs.getFloat(8));
					precioDTO.setValorMinimo(null);
					precioDTO.setValorMaximo(null);
					/*;
					
					precioDTO.setIndicadorEquipo(rs.getString(10));
					precioDTO.setIndicadorPaquete(rs.getString(11));
					precioDTO.setMesGarantia(rs.getString(12));
					precioDTO.setIndicadorAccesorio(rs.getString(13));
					precioDTO.setIndiceVenta(rs.getString(14));*/
					
					lista.add(precioDTO);
					logger.debug("ENCONTRO PRECIO" + precioDTO.getCodigoConcepto());
				}
				
				retValue =(PrecioCargoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
				lista.toArray(), PrecioCargoDTO.class);
				
			}
				} catch (ProductOfferingPriceException e) {
					logger.debug("ProductOfferingPriceException");
					String loge = StackTraceUtl.getStackTrace(e);
					logger.debug("log error[" + loge + "]");
					throw e;
					
				}
				catch (Exception e) {
					logger.error("Ocurri� un error general al obtener cargos por devoluci�n de equipo", e);
					throw new ProductOfferingPriceException("Ocurri� un error general al obtener cargos por devoluci�n de equipo",e);
				}
				finally {
					try {
						if (rs!=null){
							rs.close();
							rs=null;
						}
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
				logger.debug("getCargosDevolucionEquipo():end");
				return retValue;

				
			}
	
	public PrecioCargoDTO[] getCargosPenalizacion(PvGaImpenalizaQTDTO pvGaImpenalizaQTDTO)throws ProductOfferingPriceException{
		logger.debug("obtenerImpuestos():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		PrecioCargoDTO[] retValue = null;
		ResultSet rs=null;
		Connection conn = null;
		CallableStatement cstmt = null;
		String call = getSQLObtenerCargosPenalizacion();
		
		try {
			logger.debug("getCargosPenalizacion()");
			conn = getConnectionFromWLSInitialContext(global.getJndiForSCLDataSource());
			cstmt = conn.prepareCall(call);
			logger.debug(" Valiables de Entrada");
			cstmt.setLong(1,pvGaImpenalizaQTDTO.getCod_Producto());
			cstmt.setLong(2,pvGaImpenalizaQTDTO.getCod_Penaliza());
			
			logger.debug(" Valiables de Salida");
			cstmt.registerOutParameter(3, oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);				
			
			/*cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);//DES_PENALIZA; 
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);//IMP_PENALIZA
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);//DES_MONEDA
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);//COD_CONCEPTO
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);//COD_MONEDA
			cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);//SW_PENALIZA*/
			
			
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
			    logger.error(" Ocurri� un error al obtener cargos por Penalizacion");
			     throw new ProductOfferingPriceException(String.valueOf(codError),numEvento, msgError);
			}
			else{
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(3);
				while (rs.next()) {
					PrecioCargoDTO precioDTO = new PrecioCargoDTO();
					
					precioDTO.setCodigoConcepto(rs.getString(1));
					precioDTO.setDescripcionConcepto(rs.getString(2));
					precioDTO.setMonto(rs.getFloat(3));
					precioDTO.setCodigoMoneda(rs.getString(4));
					precioDTO.setDescripcionMoneda(rs.getString(5));
					//sw.Penaliza --- analizar empleo en otra query
					/*precioDTO.setImpDevAcc(rs.getFloat(6));
					precioDTO.setValorMinimo(null);
					precioDTO.setValorMaximo(null);
					precioDTO.setIndicadorAutMan(rs.getString(8));
					precioDTO.setNumeroUnidades(rs.getString(9));
					precioDTO.setIndicadorEquipo(rs.getString(10));
					precioDTO.setIndicadorPaquete(rs.getString(11));
					precioDTO.setMesGarantia(rs.getString(12));
					precioDTO.setIndicadorAccesorio(rs.getString(13));
					precioDTO.setIndiceVenta(rs.getString(14));*/
					
					lista.add(precioDTO);
					logger.debug("ENCONTRO PRECIO" + precioDTO.getCodigoConcepto());
				}
				
				retValue =(PrecioCargoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
				lista.toArray(), PrecioCargoDTO.class);
			}
			
			
				
				} catch (ProductOfferingPriceException e) {
					logger.debug("ProductOfferingPriceException");
					String loge = StackTraceUtl.getStackTrace(e);
					logger.debug("log error[" + loge + "]");
					throw e;
					
				}
				catch (Exception e) {
					logger.error("Ocurri� un error general al obtener cargos por Penalizacion", e);
					throw new ProductOfferingPriceException("Ocurri� un error general al obtener cargos por Penalizacion",e);
				}
				finally {
					try {
						if (rs!=null){
							rs.close();
							rs=null;
						}
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
				logger.debug("getCargosPenalizacion():end");
				return retValue;
	}
	
	public ParamBajaIndemnizacionQTDTO[] getParametrosbajaIndemnizacion(ParamBajaIndemnizacionQTDTO inValue)throws ProductOfferingPriceException{
		logger.debug("obtenerImpuestos():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ParamBajaIndemnizacionQTDTO[] retValue = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		String call = getSQLObtenerParamIndemniz();
		ResultSet rs=null;
		
		try {
			logger.debug("getCargosPenalizacion()");
			conn = getConnectionFromWLSInitialContext(global.getJndiForSCLDataSource());
			cstmt = conn.prepareCall(call);
			logger.debug(" Valiables de Entrada");
			cstmt.setLong(1,inValue.getCod_Producto());
			cstmt.setLong(2,inValue.getNum_Abonado());
			
			logger.debug(" Valiables de Salida");
			cstmt.registerOutParameter(3, oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);			
			
			/*cstmt.registerOutParameter(6, java.sql.Types.TIMESTAMP);//FECHA_ALTA; 
			cstmt.registerOutParameter(7, java.sql.Types.TIMESTAMP);//FECHA_PRORROGA
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);//COD_TIPCONTRATO
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);//NUM_MESES
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);//NUM_ABONADO*/
			
			
			
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
			    logger.error(" Ocurri� un error al obtener cargos por Penalizacion");
			     throw new ProductOfferingPriceException(String.valueOf(codError),numEvento, msgError);
			}
			else{
//				obtener info del cliente y completar respuesta
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(3);
				while (rs.next()) {
					ParamBajaIndemnizacionQTDTO retValue1=new ParamBajaIndemnizacionQTDTO();
				
					retValue1.setFec_Alta(rs.getTimestamp(1));
					retValue1.setFec_Prorroga(rs.getTimestamp(2));
					retValue1.setCod_TipContrato(rs.getString(3));
					String numMeses=rs.getString(4);
					numMeses=numMeses==null?"0":numMeses;
					retValue1.setNum_Meses(Long.parseLong(numMeses));
					String numAbo=rs.getString(5);
					numAbo=numAbo==null?"0":numAbo;
					retValue1.setNum_Abonado(Long.parseLong(numAbo));
				lista.add(retValue1);
			}
				
				retValue =(ParamBajaIndemnizacionQTDTO[]) ArrayUtl.copiaArregloTipoEspecifico( lista.toArray(), ParamBajaIndemnizacionQTDTO.class);
			}
			
			
				
				} catch (ProductOfferingPriceException e) {
					logger.debug("ProductOfferingPriceException");
					String loge = StackTraceUtl.getStackTrace(e);
					logger.debug("log error[" + loge + "]");
					throw e;
					
				}
				catch (Exception e) {
					logger.error("Ocurri� un error general al obtener cargos por Penalizacion", e);
					throw new ProductOfferingPriceException("Ocurri� un error general al obtener cargos por Penalizacion",e);
				}
				finally {
					try {
						if (rs!=null){
							rs.close();
							rs=null;
						}
						
						
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
				logger.debug("getCargosPenalizacion():end");
				return retValue;
	}
	
	public PrecioCargoDTO[] getCargosIndemnizacion(CargoIndemnizQTDTO inValue)throws ProductOfferingPriceException{
		logger.debug("getCargosIndemnizacion():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		PrecioCargoDTO[] retValue = null;
		ResultSet rs=null;
		Connection conn = null;
		CallableStatement cstmt = null;
		String call = getSQLObtenerCargosIndemnizacion();
		
		try {
			logger.debug("getCargosIndemnizacion()");
			conn = getConnectionFromWLSInitialContext(global.getJndiForSCLDataSource());
			cstmt = conn.prepareCall(call);
			logger.debug(" Valiables de Entrada");
			cstmt.setLong(1,inValue.getCod_Producto());
			cstmt.setString(2,inValue.getCod_Actabo());
			cstmt.setString(3, inValue.getCod_TipServ());
			cstmt.setString(4, inValue.getCod_Servicio());
			cstmt.setLong(5, inValue.getMeses_Contrato());
			cstmt.setLong(6, inValue.getNum_Meses());
			
			
			logger.debug(" Valiables de Salida");
			cstmt.registerOutParameter(7, oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);			
			
			/*
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);//DES_SERVICIO; 
			cstmt.registerOutParameter(11, java.sql.Types.DOUBLE);//VALOR
			cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);//DES_MONEDA
			cstmt.registerOutParameter(13, java.sql.Types.NUMERIC);//COD_CONCEPTO
			cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);//COD_MONEDA*/
			
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(8);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(9);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(10);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
			    logger.error(" Ocurri� un error al obtener cargos por Indemnizaci�n");
			     throw new ProductOfferingPriceException(String.valueOf(codError),numEvento, msgError);
			}
			else{
			
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(7);
				while (rs.next()) {
					PrecioCargoDTO precioDTO = new PrecioCargoDTO();
					
					precioDTO.setCodigoConcepto(rs.getString(1));
					precioDTO.setDescripcionConcepto(rs.getString(2));
					precioDTO.setMonto(rs.getFloat(3));
					precioDTO.setCodigoMoneda(rs.getString(4));
					precioDTO.setDescripcionMoneda(rs.getString(5));
					precioDTO.setIndicadorAutMan(rs.getString(6));
					//sw.Penaliza --- analizar empleo en otra query
					/*precioDTO.setImpDevAcc(rs.getFloat(6));
					precioDTO.setValorMinimo(null);
					precioDTO.setValorMaximo(null);
					precioDTO.setNumeroUnidades(rs.getString(9));
					precioDTO.setIndicadorEquipo(rs.getString(10));
					precioDTO.setIndicadorPaquete(rs.getString(11));
					precioDTO.setMesGarantia(rs.getString(12));
					precioDTO.setIndicadorAccesorio(rs.getString(13));
					precioDTO.setIndiceVenta(rs.getString(14));*/
					
					lista.add(precioDTO);
					logger.debug("ENCONTRO PRECIO" + precioDTO.getCodigoConcepto());
				}
				
				retValue =(PrecioCargoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
				lista.toArray(), PrecioCargoDTO.class);
				
			}
		} catch (ProductOfferingPriceException e) {
					logger.debug("ProductOfferingPriceException");
					String loge = StackTraceUtl.getStackTrace(e);
					logger.debug("log error[" + loge + "]");
					throw e;
					
				}
				catch (Exception e) {
					logger.error("Ocurri� un error general al obtener cargos por Indemnizaci�n", e);
					throw new ProductOfferingPriceException("Ocurri� un error general al obtener cargos por Indemnizaci�n",e);
				}
				finally {
					try {
						if (rs!=null){
							rs.close();
							rs=null;
						}
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
				logger.debug("getCargosIndemnizacion():end");
				return retValue;
	}
	
	/**
	 * Obtiene estado de factura
	 * 
	 * @param  numProceso
	 * @return RetornoDTO
	 * @throws ProductOfferingPriceException
	 */
	public RetornoDTO consultarEstadoFacturado(long numProceso) throws ProductOfferingPriceException{
		logger.debug("consultarEstadoFacturado():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLconsultarEstadoFacturado();
		try {

			logger.debug("numProceso[" + numProceso + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForSCLDataSource());
			
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, numProceso);
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR); //RESULTADO
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
				logger.error(" Ocurri� al obtener estado de factura");
				throw new ProductOfferingPriceException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			String resultado = cstmt.getString(2);
			logger.debug("resultado[" + resultado + "]");

			retorno = new RetornoDTO();
			retorno.setResultado(resultado.equalsIgnoreCase("TRUE")?true:false);
		
		} catch (ProductOfferingPriceException e) {
			logger.debug("ProductOfferingPriceException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurri� un error general al obtener estado de factura", e);
			throw new ProductOfferingPriceException("Ocurri� un error general al obtener estado de factura",e);
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
		logger.debug("consultarEstadoFacturado():end");
		return retorno;
	}
	
	/**
	 * Obtiene detalle presupuesto
	 * 
	 * @param  presup
	 * @return PresupuestoDTO
	 * @throws ProductOfferingPriceException
	 */
	public PresupuestoDTO obtenerDetallePresupuesto(PresupuestoDTO presup) throws ProductOfferingPriceException{
		logger.debug("obtenerDetallePresupuesto():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		PresupuestoDTO retorno = null;
		DetallePresupuestoDTO[] detalle = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		String call = getSQLobtenerDetallePresupuesto();
		try {

			logger.debug("presup.getNumProceso()[" + presup.getNumProceso() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForSCLDataSource());
			
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, presup.getNumProceso());
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
				logger.error(" Ocurri� al obtener detalle de presupuesto");
				throw new ProductOfferingPriceException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			ArrayList lista = new ArrayList();
			rs = (ResultSet) cstmt.getObject(2);
			while (rs.next()) {
				DetallePresupuestoDTO det = new DetallePresupuestoDTO();
				det.setDesConceptoRep(rs.getString(1));
				logger.debug("DesConceptoRep[" + det.getDesConceptoRep() + "]");
				det.setNumUnidades(rs.getInt(2));
				logger.debug("NumUnidades[" + det.getNumUnidades() + "]");
				det.setImpBase(rs.getFloat(3));
				logger.debug("ImpBase[" + det.getImpBase() + "]");
				det.setImpImpuesto(rs.getFloat(4));
				logger.debug("ImpImpuesto[" + det.getImpImpuesto() + "]");
				det.setImpDcto(rs.getFloat(5));
				logger.debug("ImpDcto[" + det.getImpDcto() + "]");
				det.setImpTotal(rs.getFloat(6));
				logger.debug("ImpTotal[" + det.getImpTotal() + "]");
				lista.add(det);
			}
			
			detalle =(DetallePresupuestoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), DetallePresupuestoDTO.class);
			retorno = presup;
			retorno.setDetalle(detalle);
		
		} catch (ProductOfferingPriceException e) {
			logger.debug("ProductOfferingPriceException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurri� un error general al obtener detalle de presupuesto", e);
			throw new ProductOfferingPriceException("Ocurri� un error general al obtener detalle de presupuesto",e);
		}
		finally {
			try {
				if (rs!=null){
					rs.close();
					rs=null;
				}
				
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
		logger.debug("obtenerDetallePresupuesto():end");
		return retorno;
		
	}
	
	/**
	 * Obtiene codigo de concepto de descuento
	 * 
	 * @param  RetornoDTO
	 * @return DescuentoDTO
	 * @throws ProductOfferingPriceException
	 */
	public DescuentoDTO obtenerCodConceptoDescuento(DatosGeneralesDTO sec) throws ProductOfferingPriceException{
		DescuentoDTO descuento = null;
		logger.debug("obtenerCodConceptoDescuento():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLObtieneCodConceptoDescuento();
		
		try {
			
			logger.debug("sec.getSecuencia()[" + sec.getSecuencia() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForSCLDataSource());
			
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, sec.getSecuencia());
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
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
				logger.error(" Ocurri� un error al obtener Cod Concepto Descuento");
				throw new ProductOfferingPriceException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			String cadena =  cstmt.getString(2);
			logger.debug("cadena[" + cadena + "]");
			
			descuento = new DescuentoDTO();
			String codigoDef = " ";
			
			if ( (cadena != null) && cadena.substring(0, 1).equals("/")){
				codigoDef = cadena.substring(1);
				logger.debug("codigoDef[" + codigoDef + "]");
			}
			
			descuento.setCodigoConcepto(codigoDef);
			
		} catch (ProductOfferingPriceException e) {
			logger.debug("ProductOfferingPriceException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurri� un error general al obtener Cod Concepto Descuento", e);
			throw new ProductOfferingPriceException("Ocurri� un error general al obtener Cod Concepto Descuento",e);
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
		
		logger.debug("obtenerCodConceptoDescuento():end");
		return descuento;
	}

	/**
	 * Elimina registo de la tabla ga_transacabo
	 * 
	 * @param  numTransaccion
	 * @return RetornoDTO
	 * @throws ProductOfferingPriceException
	 */
	public RetornoDTO eliminaCodConceptoDescuento(long numTransaccion) throws ProductOfferingPriceException{
		RetornoDTO retorno = null;
		logger.debug("eliminaCodConceptoDescuento():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLEliminaCodConceptoDescuento();
		
		try {
			
			logger.debug("numTransaccion[" + numTransaccion + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForSCLDataSource());
			
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, numTransaccion);
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
				logger.error(" Ocurri� un error al eliminar registro de la tabla ga_transacabo");
				throw new ProductOfferingPriceException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			String descripcionConcepto =  cstmt.getString(2);
			logger.debug("descripcionConcepto[" + descripcionConcepto + "]");
			
			retorno = new RetornoDTO();
			retorno.setCodigo("0");
			retorno.setDescripcion(msgError);
			
		} catch (ProductOfferingPriceException e) {
			logger.debug("ProductOfferingPriceException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurri� un error general al eliminar registro de la tabla ga_transacabo", e);
			throw new ProductOfferingPriceException("Ocurri� un error general al eliminar registro de la tabla ga_transacabo",e);
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
		
		logger.debug("eliminaCodConceptoDescuento():end");
		return retorno;
	}

	/**
	 * Inserta concepto descuento
	 * 
	 * @param  param
	 * @return DescuentoDTO
	 * @throws ProductOfferingPriceException
	 */
	public RetornoDTO insertarConceptoDescuento(DescuentoDTO param) throws ProductOfferingPriceException{
		RetornoDTO retorno = null;
		logger.debug("insertarConceptoDescuento():start");
		Connection conn = null;
		CallableStatement cstmt = null;

		String call = getSQLinsertarConceptoDescuento();
		
		try {
			
			logger.debug("param.getNumTransaccion()[" + param.getNumTransaccion() + "]");
			logger.debug("param.getCodigoConceptoCargo()[" + param.getCodigoConceptoCargo() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForSCLDataSource());
			
			cstmt = conn.prepareCall(call);
			cstmt.setString(1, param.getNumTransaccion());
			cstmt.setString(2, param.getCodigoConceptoCargo());
			
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
		}
		catch (Exception e) {
			logger.error("Ocurri� un error general al insertar concepto descuento", e);
			throw new ProductOfferingPriceException("Ocurri� un error general al insertar concepto descuento",e);
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
		
		logger.debug("insertarConceptoDescuento():end");
		return retorno;		
	}
	
	/**
	 * Obtiene codigo modalidad de pago
	 * 
	 * @param  abonado
	 * @return AbonadoDTO
	 * @throws ProductOfferingPriceException
	 */
	public AbonadoDTO obtenerCodigoModalidad(AbonadoDTO abonado) throws ProductOfferingPriceException{
		AbonadoDTO retorno = null;
		logger.debug("obtenerCodigoModalidad():start");
		Connection conn = null;
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		
		String call = getSQLobtenerCodigoModalidad();
		
		try {
			
			logger.debug("abonado.getClaseServicio()[" + abonado.getClaseServicio() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForSCLDataSource());
			
			cstmt = conn.prepareCall(call);
			cstmt.setString(1, abonado.getClaseServicio());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
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
				logger.error(" Ocurri� un error al obtener codigo modalidad de pago");
				throw new ProductOfferingPriceException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			int codModalidadPago =  cstmt.getInt(5);
			logger.debug("codModalidadPago[" + codModalidadPago + "]");
			
			retorno = abonado;
			retorno.setCodModVenta(String.valueOf(codModalidadPago));

		}
		catch (Exception e) {
			logger.error("Ocurri� un error general al obtener codigo modalidad de pago", e);
			throw new ProductOfferingPriceException("Ocurri� un error general al obtener codigo modalidad de pago",e);
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
		
		logger.debug("obtenerCodigoModalidad():end");
		return retorno;		
	}
    
    // INICIO FPP COL 14/04/2009 85562
	public RetornoDTO eliminarFactura(RegistroFacturacionDTO parametroEntrada) throws ProductOfferingPriceException{

		RetornoDTO resultado=null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null; 

		String strNumeroFolio;
		String strNumeroVenta;
		String strNumeroProcesoFacturacion;

		try {
			logger.debug("DAO:Inicio:eliminarFactura");

			String call =  getSQLEliminarFactura();
				//getSQLPackage("VE_SERVICIOS_VENTA_PG","VE_ACTUALIZA_FACTURACION_PR",13);

			logger.debug("2.-sql[" + call + "]");

			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			cstmt = conn.prepareCall(call);

			strNumeroFolio=parametroEntrada.getNumeroFolio();
			strNumeroVenta=parametroEntrada.getNumeroProcesoFacturacion();
			strNumeroProcesoFacturacion=parametroEntrada.getNumeroVenta();

			logger.debug("strNumeroFolio:"+strNumeroFolio);
			logger.debug("strNumeroProcesoFacturacion:"+strNumeroProcesoFacturacion);
			logger.debug("strNumeroVenta:"+strNumeroVenta);

			logger.debug("1");
			cstmt.setString(1,"900");
			logger.debug("2");
			cstmt.setString(2,"3");
			logger.debug("3");
			cstmt.setString(3,"B");
			logger.debug("4");
			cstmt.setString(4,strNumeroFolio);
			logger.debug("5");
			cstmt.setString(5,"");
			logger.debug("6");
			cstmt.setString(6,"12/03/2009");
			logger.debug("7");
			cstmt.setString(7,"prueba");
			logger.debug("8");
			cstmt.setString(8,"");
			logger.debug("9");
			cstmt.setString(9,strNumeroVenta);
			logger.debug("10");
			cstmt.setString(10,strNumeroProcesoFacturacion);

			logger.debug("11");
			cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);
			logger.debug("12");
			cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
			logger.debug("13");
			cstmt.registerOutParameter(13, java.sql.Types.NUMERIC);

			logger.debug("Inicio:eliminarFactura:execute");
			cstmt.execute();
			logger.debug("Fin:eliminarFactura:execute");

			codError=cstmt.getInt(11);
			msgError = cstmt.getString(12);
			numEvento=cstmt.getInt(13);
			logger.debug("msgError[" + msgError + "]");

			if (codError != 0){
				//resultado = new ProcesoDTO();
				//resultado.setCodigoError(codError);
				//resultado.setEvento(numEvento);

				//retorno = new RetornoDTO();
				resultado.setCodigo(codError+ "");
				resultado.setDescripcion(msgError);

			}

		} catch (Exception e) {
			logger.error("Ocurri� un error al Eliminar la facturaci�n",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
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

		logger.debug("DAO:Fin:eliminarFactura");

		return resultado;
	}//fin actualizaFacturacion
	// FIN FPP COL 14/04/2009 85562
	
	
	public PrecioCargoDTO[] getParametrosAbonadoCero(ParamCargosAbonadoCeroDTO inValue)throws ProductOfferingPriceException{
		logger.debug("getParametrosAbonadoCero():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		PrecioCargoDTO[] retValue = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		String call = getSQLObtenerParamAbonadoCero();
		ResultSet rs=null;
		
		try {
			logger.debug("getParametrosAbonadoCero()");
			conn = getConnectionFromWLSInitialContext(global.getJndiForSCLDataSource());
			cstmt = conn.prepareCall(call);
			logger.debug(" Valiables de Entrada");
			logger.debug("cod_Concepto:"+inValue.getCodConcepto());
			logger.debug("cod_Producto:"+inValue.getCodProducto());
			cstmt.setString(1,inValue.getCodConcepto());
			cstmt.setLong(2,inValue.getCodProducto());
			
			logger.debug(" Valiables de Salida");
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
			    logger.error(" Ocurri� un error al obtener parametros abonado cero");
			     throw new ProductOfferingPriceException(String.valueOf(codError),numEvento, msgError);
			}
			else{
//				obtener info del cliente y completar respuesta
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(3);
				while (rs.next()) {
					PrecioCargoDTO pAbonadoCeroDTO=new PrecioCargoDTO();
					pAbonadoCeroDTO.setCodigoConcepto(rs.getString(1));
					pAbonadoCeroDTO.setDescripcionConcepto(rs.getString(2));
					pAbonadoCeroDTO.setCodigoMoneda(rs.getString(3));
					pAbonadoCeroDTO.setDescripcionMoneda(rs.getString(4));
					pAbonadoCeroDTO.setIndicadorAutMan(rs.getString(5));
					pAbonadoCeroDTO.setNumeroUnidades(rs.getString(6));
				lista.add(pAbonadoCeroDTO);
			}
				
				retValue =(PrecioCargoDTO[]) ArrayUtl.copiaArregloTipoEspecifico( lista.toArray(), PrecioCargoDTO.class);
			}
			
			
				
				} catch (ProductOfferingPriceException e) {
					logger.debug("ProductOfferingPriceException");
					String loge = StackTraceUtl.getStackTrace(e);
					logger.debug("log error[" + loge + "]");
					throw e;
					
				}
				catch (Exception e) {
					logger.error("Ocurri� un error general al obtener parametros abonado cero", e);
					throw new ProductOfferingPriceException("Ocurri� un error general al obtener parametros abonado cero",e);
				}
				finally {
					try {
						if (rs!=null){
							rs.close();
							rs=null;
						}
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
				logger.debug("getParametrosAbonadoCero():end");
				return retValue;
	}
	
	public PrecioCargoDTO getValorCargoAbonadoCero(ParamCargosAbonadoCeroDTO inValue)throws ProductOfferingPriceException{
		logger.debug("getValorCargoAbonadoCero():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		PrecioCargoDTO retValue = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		String call = getSQLConsultaCargoBasicoCliente();
		try {
			logger.debug("getValorCargoAbonadoCero()");
			conn = getConnectionFromWLSInitialContext(global.getJndiForSCLDataSource());
			cstmt = conn.prepareCall(call);
			logger.debug(" Valiables de Entrada");
			logger.debug("cod_Cliente:"+inValue.getCodCliente());
			logger.debug("Fecha Vigencia:"+inValue.getFechaVigencia());
			cstmt.setLong(1,inValue.getCodCliente());
			cstmt.setDate(2,inValue.getFechaVigencia());
			
			logger.debug(" Valiables de Salida");
			cstmt.registerOutParameter(3, java.sql.Types.FLOAT);
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
			    logger.error(" Ocurri� un error al obtener valor del cargo");
			     throw new ProductOfferingPriceException(String.valueOf(codError),numEvento, msgError);
			}
			else{
				retValue=new PrecioCargoDTO();
				retValue.setMonto(cstmt.getFloat(3));
			}
			
				} catch (ProductOfferingPriceException e) {
					logger.debug("ProductOfferingPriceException");
					String loge = StackTraceUtl.getStackTrace(e);
					logger.debug("log error[" + loge + "]");
					throw e;
					
				}
				catch (Exception e) {
					logger.error("Ocurri� un error general al  obtener valor del cargo", e);
					throw new ProductOfferingPriceException("Ocurri� un error general al  obtener valor del cargo",e);
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
				logger.debug("getValorCargoAbonadoCero():end");
				return retValue;
	}
	
	public RetornoDTO getValidacionAbonadoCero(ParamCargosAbonadoCeroDTO inValue)throws ProductOfferingPriceException{
		logger.debug("getValidacionAbonadoCero():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retValue = new RetornoDTO();
		Connection conn = null;
		CallableStatement cstmt = null;
		String call = getSQLValidaAbonadoCeroPorCodCliente();
		try {
			logger.debug("getValorCargoAbonadoCero()");
			conn = getConnectionFromWLSInitialContext(global.getJndiForSCLDataSource());
			cstmt = conn.prepareCall(call);
			logger.debug(" Valiables de Entrada");
			logger.debug("cod_Cliente:"+inValue.getCodCliente());
			cstmt.setLong(1,inValue.getCodCliente());
			logger.debug(" Valiables de Salida");
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(3);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(4);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(2);
			logger.debug("codValidacion[" + numEvento + "]");
			
			if (codError != 0) {
			    logger.error(" Ocurri� un error al obtener valor del cargo");
			     throw new ProductOfferingPriceException(String.valueOf(codError),numEvento, msgError);
			}
			else{
				boolean aplicaAbonadoCero = (numEvento==1)?true:false;
				logger.debug("aplicaAbonadoCero[" + aplicaAbonadoCero + "]");
				
				retValue.setCodigo("0");
				retValue.setDescripcion(msgError);
				retValue.setResultado(aplicaAbonadoCero); //indica si aplica cargos abonado cero, EV 28/07/08
				
			}
			
				} catch (ProductOfferingPriceException e) {
					logger.debug("ProductOfferingPriceException");
					String loge = StackTraceUtl.getStackTrace(e);
					logger.debug("log error[" + loge + "]");
					throw e;
					
				}
				catch (Exception e) {
					logger.error("Ocurri� un error general al  obtener valor del cargo", e);
					throw new ProductOfferingPriceException("Ocurri� un error general al  obtener valor del cargo",e);
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
				logger.debug("getValorCargoAbonadoCero():end");
				return retValue;
	}
	
	public PrecioTerminalDTO getRecPrecioEquipoActual(TerminalDTO terminalDTO)throws ProductOfferingPriceException{
		logger.debug("getRecPrecioEquipoActual():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		PrecioTerminalDTO precioDTO = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs=null;
		String call = getSQLPrecioEquipoActual();
		
		try {
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForSCLDataSource());
			cstmt = conn.prepareCall(call);
			logger.debug(" Valiables de Entrada");
			logger.debug("Numero serie ::"+terminalDTO.getNumeroSerie());
			cstmt.setString(1,terminalDTO.getNumeroSerie());
			logger.debug(" Valiables de Salida");
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
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
			    logger.error(" Ocurri� un error al obtener precio del equipo actual");
			     throw new ProductOfferingPriceException(String.valueOf(codError),numEvento, msgError);
			}
			else{
				
					precioDTO = new PrecioTerminalDTO();
					precioDTO.setMonto(cstmt.getFloat(2));
					precioDTO.setValDescto(cstmt.getString(3));
					precioDTO.setTipDescto(cstmt.getString(4));
					logger.debug("ENCONTRO PRECIO" + precioDTO.getMonto());
				}
			} catch (ProductOfferingPriceException e) {
					logger.debug("ProductOfferingPriceException");
					String loge = StackTraceUtl.getStackTrace(e);
					logger.debug("log error[" + loge + "]");
					throw e;
					
		}
		catch (Exception e) {
					logger.error("Ocurri� un error general al obtener precio del equipo actual", e);
					throw new ProductOfferingPriceException("Ocurri� un error general al obtener precio del equipo actual",e);
				}
				finally {
					try {
						if (rs!=null){
							rs.close();
							rs=null;
						}
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
				logger.debug("getRecPrecioEquipoActual():end");
				return precioDTO;

				
			}
}
