/**
 * Copyright © 2006 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 17/10/2007     			 Cristian Toledo              		Versión Inicial
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
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces.SCLProductoContratadoDAOIT;
import com.tmmas.scl.framework.productDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CambioPlanComercialDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CausaBajaDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CausaBajaListDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CuentaPersonalDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.DesactServFreDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ListaFrecuentesDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.PlanServicioDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ReordenamientoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.TraspasoPlanDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;

public class SCLProductoContratadoDAO extends ConnectionDAO implements SCLProductoContratadoDAOIT 
{

	
	private final Logger logger = Logger.getLogger(SCLProductoContratadoDAO.class);
	private final Global global = Global.getInstance();

	
	
	private String getSQLobtenerCausaBaja() {
		StringBuffer call = new StringBuffer();
		call.append(" BEGIN ");
		call.append("   PV_PRODUCTO_CONTRATADO_PG.PV_OBTENER_CAUSA_BAJA_PR( ?, ?, ?, ?);");
		call.append(" END;");	
		return call.toString();		
	}
//	-------------------------------------------------------------------------------------------------------------	
	
	private String getSQLobtenerDatosCambPlanServ() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   eo_abonado PV_OBT_CAMB_PLAN_SERV_QT := PV_INICIA_ESTRUCTURAS_PG.PV_OBT_CAMB_PLAN_SERV_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_abonado.COD_TECNOLOGIA := ?;");
		call.append("   eo_abonado.COD_PLANTARIF_NUEVO:= ?;");
		call.append("   PV_PRODUCTO_CONTRATADO_PG.PV_OBTENER_CAMB_PLAN_SERV_PR( eo_abonado, ?, ?, ?);");
		call.append("   				? := eo_abonado.COD_PLANSERV_NUEVO;");
		call.append(" END;");		
		return call.toString();		
	}	
//	-------------------------------------------------------------------------------------------------------------
	
	private String getSQLvalidaCuentaPersonal() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   eo_cuenta PV_NUMCEL_PERS_QT := PV_INICIA_ESTRUCTURAS_PG.PV_NUMCEL_PERS_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_cuenta.NUM_CELULAR_PERS := ?;");
		call.append("   eo_cuenta.NUM_CELULAR_CORP := ?;");
		call.append("   ? := PV_PRODUCTO_CONTRATADO_PG.PV_VALIDA_CUENTA_PERSONAL_FN( eo_cuenta, ?, ?, ?);");
		call.append(" END;");
		return call.toString();		
	}	
//	-------------------------------------------------------------------------------------------------------------
	private String getSQLregistraTraspasoPlan() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   eo_traspaso PV_TRASPASO_PLAN_QT := PV_INICIA_ESTRUCTURAS_PG.PV_TRASPASO_PLAN_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_traspaso.NUM_ABONADO:= ?;");
		call.append("   eo_traspaso.COD_CLIENUE:= ?;");
		call.append("   eo_traspaso.COD_CUENTANUE:= ?;");
		call.append("   eo_traspaso.COD_SUBCTANUE:= ?;");
		call.append("   eo_traspaso.COD_USUARNUE:= ?;");
		call.append("   eo_traspaso.COD_PRODUCTO:= ?;");
		call.append("   eo_traspaso.NUM_TERMINAL:= ?;");
		call.append("   eo_traspaso.NUM_ABONADOANT:= ?;");
		call.append("   eo_traspaso.COD_CLIENANT:= ?;");
		call.append("   eo_traspaso.COD_CUENTAANT:= ?;");
		call.append("   eo_traspaso.COD_SUBCTAANT:= ?;");
		call.append("   eo_traspaso.COD_USUARANT:= ?;");
		call.append("   eo_traspaso.IND_TRASDEUDA:= ?;");
		call.append("   eo_traspaso.NOM_USUARORA:= ?;");
		call.append("   eo_traspaso.IND_TRASPASO:= ?;");
		call.append("   eo_traspaso.COD_PLANTARIF_ORIG:= ?;");
		call.append("   eo_traspaso.COD_PLANTARIF_DEST:= ?;");
		call.append("   eo_traspaso.COD_VENDEDOR:= ?;");		
		call.append("   PV_PRODUCTO_CONTRATADO_PG.PV_REG_TRASPASO_PLAN_PR( eo_traspaso, ?, ?, ?);");
		call.append(" END;");
		return call.toString();		
	}	
//	-------------------------------------------------------------------------------------------------------------
	private String getSQLvalidaDesacListaFrecuente() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   eo_icgenerica PV_ICGENERICA_TO_QT := PV_INICIA_ESTRUCTURAS_PG.PV_ICGENERICA_TO_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_icgenerica.NUM_MOVIMIENTO := ?;");
		call.append("   eo_icgenerica.LISTAACTIVA := ?;");
		call.append("   PV_PRODUCTO_CONTRATADO_PG.PV_VAL_DESAC_LIST_FREC_PR( eo_icgenerica, ?, ?, ?);");
		call.append(" END;");
		return call.toString();		
	}	
//	-------------------------------------------------------------------------------------------------------------
	
	private String getSQLregistroCambPlanServ() {
		StringBuffer call = new StringBuffer();

		call.append(" DECLARE ");
		call.append("   eo_producto PV_REG_CAMB_PLAN_SERV_QT := PV_INICIA_ESTRUCTURAS_PG.PV_REG_CAMB_PLAN_SERV_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_producto.NUM_TRANSACCION := ?;");
		call.append("   eo_producto.COD_ACTABO := ?;");
		call.append("   eo_producto.COD_PRODUCTO := ?;");
		call.append("   eo_producto.NUM_ABONADO := ?;");
		call.append("   eo_producto.TIP_PLANTARIF := ?;");
		call.append("   eo_producto.COD_PLANTARIF_NUEVO := ?;");
		call.append("   eo_producto.COD_HOLDING := ?;");
		call.append("   eo_producto.COD_TIPLAN := ?;");
		call.append("   eo_producto.COD_PLANSERV := ?;");
		
		call.append("   PV_PRODUCTO_CONTRATADO_PG.PV_REG_CAMB_PLAN_SERV_PR( eo_producto, ?, ?, ?);");
		call.append(" END;");		
		return call.toString();		
	}		
//	-------------------------------------------------------------------------------------------------------------
	private String getSQLregistraDesActSerFre() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   eo_desact_servfrec PV_DESACT_SERVFREC_QT := PV_INICIA_ESTRUCTURAS_PG.PV_DESACT_SERVFREC_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_desact_servfrec.COD_PLANTARIF_NUEVO := ?;");
		call.append("   eo_desact_servfrec.COD_PLANTARIF_ACTUA := ?;");
		call.append("   eo_desact_servfrec.NUM_ABONADO := ?;");
		call.append("   eo_desact_servfrec.COD_CLIENTE := ?;");
		call.append("   eo_desact_servfrec.COD_PRODUCTO := ?;");
		call.append("   eo_desact_servfrec.COD_FYFCEL := ?;");
		call.append("   eo_desact_servfrec.IND_PLANTARIF := ?;");
		call.append("   eo_desact_servfrec.IND_ESTADO := ?;");
		call.append("   eo_desact_servfrec.FEC_BAJABD := ?;");
		call.append("   eo_desact_servfrec.FEC_BAJACEN := ?;");
		call.append("   eo_desact_servfrec.IND_FF := ?;");
		call.append("   eo_desact_servfrec.FEC_ALTABD := ?;");
		call.append("   eo_desact_servfrec.COD_SERVSUPL := ?;");
		call.append("   eo_desact_servfrec.COD_NIVEL := ?;");
		call.append("   eo_desact_servfrec.NUM_CELULAR := ?;");
		call.append("   eo_desact_servfrec.NOM_USUARORA := ?;");
		call.append("   eo_desact_servfrec.FEC_ALTACEN := ?;");
		call.append("   eo_desact_servfrec.COD_CONCEPTO := ?;");
		call.append("   eo_desact_servfrec.NUM_DIASNUM := ?;");
		call.append("   eo_desact_servfrec.COD_SERVICIO_FF := ?;");
		call.append("   eo_desact_servfrec.COD_TIPSERV := ?;");
		call.append("   eo_desact_servfrec.COD_ACTABO := ?;");
		call.append("   eo_desact_servfrec.NOM_PARAMETRO := ?;");
		call.append("   eo_desact_servfrec.COD_MODULO := ?;");
		call.append("   eo_desact_servfrec.VAL_PARAMETRO := ?;");
		call.append("   eo_desact_servfrec.DES_PARAMETRO := ?;");
		call.append("   eo_desact_servfrec.NOM_USUARIO := ?;");
		call.append("   eo_desact_servfrec.FEC_ALTA := ?;");
		call.append("   PV_PRODUCTO_CONTRATADO_PG.PV_REG_DESACT_SERV_FREC_PR( eo_desact_servfrec, ?, ?, ?);");
		call.append(" END;");
		return call.toString();		
	}	
//	-------------------------------------------------------------------------------------------------------------	
	private String getSQLregistraReordenamientoPlan() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   eo_datos PV_REG_REORD_PLAN_QT := PV_INICIA_ESTRUCTURAS_PG.PV_REG_REORD_PLAN_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_datos.COD_CLIENTE_ORI := ?;"); //1
		call.append("   eo_datos.COD_CLIENTE_DES := ?;"); //2
		call.append("   eo_datos.COD_CUENTA_ORI := ?;");  //3
		call.append("   eo_datos.COD_CUENTA_DES := ?;");  //4
		call.append("   eo_datos.NUM_ABONADO := ?;");     //5
		call.append("   eo_datos.COD_SUBCUENTA_ORI := ?;");//6
		call.append("   eo_datos.COD_SUBCUENTA_DES := ?;");//7
		call.append("   eo_datos.COD_PLANTARIF_NUEVO := ?;");//8
		call.append("   eo_datos.COD_PRODUCTO := ?;");    //9
		call.append("   eo_datos.ID_USER := ?;");         //10
		call.append("   eo_datos.COD_ACTABO := ?;");      //11
		call.append("   eo_datos.COD_TIPO_CONTRATO := ?;"); //12
		call.append("   eo_datos.TIPO_TRASPASO := ?;");   //13
		call.append("   eo_datos.NUM_CONTRATO := ?;");    //14
		call.append("   eo_datos.NUM_ANEXO := ?;");       //15
		call.append("   eo_datos.COD_USUARIO_DES := ?;"); //16
		call.append("   eo_datos.COD_USUARIO_ORI := ?;"); //17
		call.append("   eo_datos.NUM_CELULAR := ?;");     //18
		call.append("   eo_datos.COD_EMPRESA_ORI := ?;"); //19
		call.append("   eo_datos.COD_EMPRESA_DES := ?;"); //20
		call.append("   PV_PRODUCTO_CONTRATADO_PG.PV_REG_REORDENAMIENTO_PLAN_PR( eo_datos, ?, ?, ?);");
		call.append(" END;");
		return call.toString();
		
	
	}
//	-------------------------------------------------------------------------------------------------------------	
	private String getSQLregistroCambPlanComer() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   eo_datos PV_REG_CAMB_PLAN_COMER_QT := PV_INICIA_ESTRUCTURAS_PG.PV_REG_CAMB_PLAN_COMER_QT_FN;");
		call.append(" BEGIN ");
		call.append("   eo_datos.NUM_TRANSACCION := ?;");
		call.append("   eo_datos.COD_ACTABO := ?;");
		call.append("   eo_datos.COD_PRODUCTO := ?;");
		call.append("   eo_datos.NUM_ABONADO := ?;");
		call.append("   eo_datos.TIP_PLANTARIF := ?;");
		call.append("   eo_datos.COD_PLANTARIF_NUEVO := ?;");
		call.append("   eo_datos.COD_HOLDING := ?;");
		call.append("   eo_datos.COD_OS := ?;");
		call.append("   PV_PRODUCTO_CONTRATADO_PG.PV_REG_CAMB_PLAN_COMER_PR ( eo_datos, ?, ?, ?);");
		call.append(" END;");
		return call.toString();		
	}
	
//	-------------------------------------------------------------------------------------------------------------
	/**
	 * Obtener causa baja
	 * 
	 * @param 
	 * @return CausaBajaListDTO
	 * @throws ProductException
	 */	
	public CausaBajaListDTO obtenerCausaBaja() throws ProductException{
		logger.debug("obtenerCausaBaja():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		CausaBajaListDTO causasList = null;
		CausaBajaDTO[] causas = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerCausaBaja();
		try {
		
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			cstmt.registerOutParameter(1, oracle.jdbc.driver.OracleTypes.CURSOR);			
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
			
			logger.debug("Recuperando cursor...");
			logger.debug("object="+cstmt.getObject(1));
			ResultSet rs = (ResultSet) cstmt.getObject(1);
			
			ArrayList lista = new ArrayList();
			while (rs.next()) {
				CausaBajaDTO causa = new CausaBajaDTO();
				
				causa.setDesCausaBaja(rs.getString(1));
				logger.debug("desCausaBaja[" + causa.getDesCausaBaja() + "]");
				causa.setCodCausaBaja(rs.getString(2));
				logger.debug("codCausaBaja[" + causa.getCodCausaBaja() + "]");
				causa.setIndLn(rs.getInt(3));
				logger.debug("indLn[" + causa.getIndLn() + "]");
				causa.setIndCobro(rs.getInt(4));
				logger.debug("indCobro[" + causa.getIndCobro() + "]");
				causa.setIndPortable(rs.getInt(5));
				logger.debug("indPortable[" + causa.getIndPortable() + "]");

				lista.add(causa);
			}
			causas = (CausaBajaDTO[]) ArrayUtl.copiaArregloTipoEspecifico(	lista.toArray(), CausaBajaDTO.class);
			causasList = new CausaBajaListDTO();
			causasList.setCausas(causas);			
			rs.close();
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
		logger.debug("obtenerCausaBaja():end");
		return causasList;		
	}
//	-------------------------------------------------------------------------------------------------------------

	/**
	 * Obtener datos cambio de plan
	 * 
	 * @param abonado
	 * @return RetornoDTO
	 * @throws ProductException
	 */	
	public AbonadoDTO obtenerDatosCambPlanServ(AbonadoDTO abonado) throws ProductException{
		logger.debug("obtenerDatosCambPlanServ():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		AbonadoDTO retorno = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerDatosCambPlanServ();
		try {
		
			logger.debug("abonado.getCodTecnologia()[" + abonado.getCodTecnologia() + "]");
			logger.debug("abonado.getCodPlanTarif()[" + abonado.getCodPlanTarif() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			cstmt.setString(1, abonado.getCodTecnologia());
			cstmt.setString(2, abonado.getCodPlanTarif());
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);			
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			
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
				logger.error(" Ocurrió un error al obtener datos de cambio de plan");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			String codPlanServNuevo = cstmt.getString(6);
			logger.debug("codPlanServNuevo[" + codPlanServNuevo + "]");
			
			retorno = abonado;
			retorno.setCodPlanServ(codPlanServNuevo);
		
		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener datos de cambio de plan", e);
			throw new ProductException("Ocurrió un error general al obtener datos de cambio de plan",e);
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
		logger.debug("obtenerDatosCambPlanServ():end");
		return retorno;
	}
//	-------------------------------------------------------------------------------------------------------------	

	/**
	 * Valida cuenta personal
	 * 
	 * @param cuenta
	 * @return RetornoDTO
	 * @throws ProductException
	 */		
	public RetornoDTO validaCuentaPersonal(CuentaPersonalDTO cuenta) throws ProductException{
		logger.debug("validaCuentaPersonal():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLvalidaCuentaPersonal();
		try {
		
			logger.debug("cuenta.getNumCelular()[" + cuenta.getNumCelular() + "]");
			logger.debug("cuenta.getNumCelularCorp()[" + cuenta.getNumCelularCorp() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setLong(1, cuenta.getNumCelular());
			cstmt.setLong(2, cuenta.getNumCelularCorp());
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
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
				logger.error(" Ocurrió un error al validar cuenta personal");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			String res = cstmt.getString(3);
			logger.debug("res[" + res + "]");
			
			retorno = new RetornoDTO();
			retorno.setCodigo("0");
			retorno.setDescripcion(" ");
			retorno.setResultado(res.equalsIgnoreCase("TRUE")?true:false);
		
		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error al validar cuenta personal", e);
			throw new ProductException("Ocurrió un error al validar cuenta personal",e);
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
		logger.debug("validaCuentaPersonal():end");
		return retorno;			
	}
//	-------------------------------------------------------------------------------------------------------------

	/**
	 * Registra plan en tabla historica
	 * 
	 * @param traspaso
	 * @return RetornoDTO
	 * @throws ProductException
	 */	
	public RetornoDTO registraTraspasoPlan(TraspasoPlanDTO traspaso) throws ProductException{
		logger.debug("registraTraspasoPlan():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLregistraTraspasoPlan();
		try {
			logger.debug("traspaso.getNumAbonado()[" + traspaso.getNumAbonado() + "]");
			logger.debug("traspaso.getCodClienteNue()[" + traspaso.getCodClienteNue() + "]");
			logger.debug("traspaso.getCodCuentaNue()[" + traspaso.getCodCuentaNue() + "]");
			logger.debug("traspaso.getCodSubCtaNue()[" + traspaso.getCodSubCtaNue() + "]");
			logger.debug("traspaso.getCodUsuarioNue()[" + traspaso.getCodUsuarioNue() + "]");
			logger.debug("traspaso.getCodProducto()[" + traspaso.getCodProducto() + "]");
			logger.debug("traspaso.getNumTerminal()[" + traspaso.getNumTerminal() + "]");
			logger.debug("traspaso.getNumAbonadoAnt()[" + traspaso.getNumAbonadoAnt() + "]");
			logger.debug("traspaso.getCodClienteAnt()[" + traspaso.getCodClienteAnt() + "]");
			logger.debug("traspaso.getCodCuentaAnt()[" + traspaso.getCodCuentaAnt() + "]");
			logger.debug("traspaso.getCodSubCtaAnt()[" + traspaso.getCodSubCtaAnt() + "]");
			logger.debug("traspaso.getCodUsuarioAnt()[" + traspaso.getCodUsuarioAnt() + "]");
			logger.debug("traspaso.getIndTrasDeuda()[" + traspaso.getIndTrasDeuda() + "]");
			logger.debug("traspaso.getNomUsuarioOra()[" + traspaso.getNomUsuarioOra() + "]");
			logger.debug("traspaso.getIndTraspaso()[" + traspaso.getIndTraspaso() + "]");
			logger.debug("traspaso.getCodPlanTarifOrig()[" + traspaso.getCodPlanTarifOrig() + "]");
			logger.debug("traspaso.getCodPlanTarifDest()[" + traspaso.getCodPlanTarifDest() + "]");
			logger.debug("traspaso.getCodVendedor()[" + traspaso.getCodVendedor() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setLong(1, traspaso.getNumAbonado()); //NUM_ABONADO
			cstmt.setLong(2, traspaso.getCodClienteNue()); //COD_CLIENUE
			cstmt.setLong(3, traspaso.getCodCuentaNue()); //COD_CUENTANUE
			cstmt.setString(4, traspaso.getCodSubCtaNue()); //COD_SUBCTANUE
			cstmt.setLong(5, traspaso.getCodUsuarioNue()); //COD_USUARNUE
			cstmt.setInt(6, traspaso.getCodProducto()); //COD_PRODUCTO
			cstmt.setString(7, traspaso.getNumTerminal()); //NUM_TERMINAL
			cstmt.setLong(8, traspaso.getNumAbonadoAnt()); //NUM_ABONADOANT
			cstmt.setLong(9, traspaso.getCodClienteAnt()); //COD_CLIENANT
			cstmt.setLong(10, traspaso.getCodCuentaAnt()); //COD_CUENTAANT
			cstmt.setString(11, traspaso.getCodSubCtaAnt()); //COD_SUBCTAANT
			cstmt.setLong(12, traspaso.getCodUsuarioAnt()); //COD_USUARANT
			cstmt.setString(13, traspaso.getIndTrasDeuda()); //IND_TRASDEUDA
			cstmt.setString(14, traspaso.getNomUsuarioOra()); //NOM_USUARORA
			cstmt.setString(15, traspaso.getIndTraspaso()); //IND_TRASPASO
			cstmt.setString(16, traspaso.getCodPlanTarifOrig()); //COD_PLANTARIF_ORIG
			cstmt.setString(17, traspaso.getCodPlanTarifDest()); //COD_PLANTARIF_DEST
			cstmt.setInt(18, traspaso.getCodVendedor()); //COD_VENDEDOR
			
			cstmt.registerOutParameter(19, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(20, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(21, java.sql.Types.NUMERIC);			
		
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(19);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(20);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(21);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al registrar plan en tabla histórica");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			retorno = new RetornoDTO();
			retorno.setCodigo("0");
			retorno.setDescripcion(msgError);

		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al registrar plan en tabla histórica", e);
			throw new ProductException("Ocurrió un error general al registrar plan en tabla histórica",e);
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
		logger.debug("registraTraspasoPlan():end");
		return retorno;		
	}
//	-------------------------------------------------------------------------------------------------------------
	/**
	 * Registra numeros frecuentes desactivados
	 * 
	 * @param datos
	 * @return RetornoDTO
	 * @throws ProductException
	 */	
	public RetornoDTO validaDesacListaFrecuente(ListaFrecuentesDTO lista) throws ProductException{
		logger.debug("validaDesacListaFrecuente():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLvalidaDesacListaFrecuente();
		try {
		
			logger.debug("lista.getNumMovimiento()[" + lista.getNumMovimiento() + "]");
			logger.debug("lista.getListaActiva()[" + lista.getListaActiva() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, lista.getNumMovimiento());
			cstmt.setString(2, lista.getListaActiva());

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
				logger.error(" Ocurrió un error al registrar números frecuentes");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");

			retorno = new RetornoDTO();
		
		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al registrar números frecuentes", e);
			throw new ProductException("Ocurrió un error general al registrar números frecuentes",e);
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
		logger.debug("validaDesacListaFrecuente():end");
		return retorno;		
	}
//	-------------------------------------------------------------------------------------------------------------
	
	/**
	 * Informa plan de servicio
	 * 
	 * @param plan
	 * @return RetornoDTO
	 * @throws ProductException
	 */	
	public RetornoDTO registroCambPlanServ(PlanServicioDTO plan) throws ProductException{
		logger.debug("registroCambPlanServ():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLregistroCambPlanServ();
		try {
		
			logger.debug("plan.getIdSecuencia()[" + plan.getIdSecuencia() + "]");
			logger.debug("plan.getCodActAbo()[" + plan.getCodActAbo() + "]");
			logger.debug("plan.getCodProducto()[" + plan.getCodProducto() + "]");
			logger.debug("plan.getTipPlanTarif()[" + plan.getTipPlanTarif() + "]");
			logger.debug("plan.getCodPlanTarifNuevo()[" + plan.getCodPlanTarifNuevo() + "]");
			logger.debug("plan.getCodHolding()[" + plan.getCodHolding() + "]");
			logger.debug("plan.getCodTipPlan()[" + plan.getCodTipPlan() + "]");
			logger.debug("plan.getCodPlanServicio()[" + plan.getCodPlanServicio() + "]");

			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
					
			cstmt.setLong(1, plan.getIdSecuencia()); //NUM_TRANSACCION
			cstmt.setString(2, plan.getCodActAbo()); //COD_ACTABO
			cstmt.setInt(3, plan.getCodProducto()); //COD_PRODUCTO
			cstmt.setLong(4, plan.getNumAbonado()); //NUM_ABONADO
			cstmt.setString(5, plan.getTipPlanTarif()); //TIP_PLANTARIF
			cstmt.setString(6, plan.getCodPlanTarifNuevo()); //COD_PLANTARIF_NUEVO
			cstmt.setLong(7, plan.getCodHolding()); //COD_HOLDING
			cstmt.setString(8, plan.getCodTipPlan()); //COD_TIPLAN
			cstmt.setString(9, plan.getCodPlanServicio()); //COD_PLANSERV 
			
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(12, java.sql.Types.NUMERIC);			
		
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(10);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(11);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(12);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al informar plan de servicio");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			retorno = new RetornoDTO();
			retorno.setCodigo("0");
			retorno.setDescripcion(msgError);

		
		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error al informar plan de servicio", e);
			throw new ProductException("Ocurrió un error al informar plan de servicio",e);
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
		logger.debug("registroCambPlanServ():end");
		return retorno;				
	}
//	-------------------------------------------------------------------------------------------------------------

	/**
	 * Registra activación/desactivación de servicios frecuentes
	 * 
	 * @param traspaso
	 * @return RetornoDTO
	 * @throws ProductException
	 */	
	public RetornoDTO registraDesActSerFre(DesactServFreDTO param) throws ProductException{
		logger.debug("registraDesActSerFre():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLregistraDesActSerFre();
		try {
		
			logger.debug("param.getCodCliente()[" + param.getCodCliente() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
					
			cstmt.setString(1, param.getCodPlanTarifNuevo()); //COD_PLANTARIF_NUEVO
			cstmt.setString(2, param.getCodPlanTarifActual()); //COD_PLANTARIF_ACTUA
			cstmt.setLong(3, param.getNumAbonado()); //NUM_ABONADO
			cstmt.setLong(4, param.getCodCliente()); //COD_CLIENTE
			cstmt.setLong(5, param.getCodProducto()); //COD_PRODUCTO
			cstmt.setString(6, param.getCodFyfcel()); //COD_FYFCEL
			cstmt.setInt(7,param.getIndPlanTarif()); //IND_PLANTARIF
			cstmt.setInt(8,param.getIndEstado()); //IND_ESTADO
			
			long fechaBaja = param.getFecBajaBD().getTime();
			long fechaBajaCen = param.getFecBajaCen().getTime();
			long fechaAltaBD = param.getFecAltaBD().getTime();
			long fechaAltaCen = param.getFecAltaCen().getTime();
			
			cstmt.setDate(9, new java.sql.Date(fechaBaja)); //FEC_BAJABD
			cstmt.setDate(10, new java.sql.Date(fechaBajaCen)); //FEC_BAJACEN
			cstmt.setInt(11,param.getIndFF()); //IND_FF
			cstmt.setDate(12, new java.sql.Date(fechaAltaBD)); //FEC_ALTABD
			cstmt.setInt(13, param.getCodServSupl()); //COD_SERVSUPL
			cstmt.setInt(14, param.getCodNivel()); //COD_NIVEL
			cstmt.setLong(15, param.getNumCelular()); //NUM_CELULAR
			cstmt.setString(16, param.getNomUsuarioOra()); //NOM_USUARORA
			cstmt.setDate(17, new java.sql.Date(fechaAltaCen)); //FEC_ALTACEN
			cstmt.setInt(18, param.getCodConcepto()); //COD_CONCEPTO
			cstmt.setLong(19, param.getNumDiasNum()); //NUM_DIASNUM
			cstmt.setString(20, param.getCodServicioFF()); //COD_SERVICIO_FF
			cstmt.setString(21, param.getCodTipoServ()); //COD_TIPSERV
			cstmt.setString(22, param.getCodActAbo()); //COD_ACTABO
			cstmt.setString(23, param.getNomParametro()); //NOM_PARAMETRO
			cstmt.setString(24, param.getCodModulo()); //COD_MODULO
			cstmt.setString(25, param.getValParametro()); //VAL_PARAMETRO
			cstmt.setString(26, param.getDesParametro()); //DES_PARAMETRO
			cstmt.setString(27, param.getNomUsuario()); //NOM_USUARIO
			long fechaAlta = param.getFecAlta().getTime();
			cstmt.setDate(28, new java.sql.Date(fechaAlta)); //FEC_ALTA
			
			cstmt.registerOutParameter(29, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(30, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(31, java.sql.Types.NUMERIC);		
			
	
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(29);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(30);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(31);
			logger.debug("numEvento[" + numEvento + "]");

			
			if (codError != 0) {
				logger.error(" Ocurrió un error en la activación/desactivación de servicios frecuentes");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			retorno = new RetornoDTO();
			retorno.setCodigo(String.valueOf(codError));
			retorno.setDescripcion(msgError);
			
		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general en la activación/desactivación de servicios frecuentes", e);
			throw new ProductException("Ocurrió un error general en la activación/desactivación de servicios frecuentes",e);
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
		logger.debug("registraDesActSerFre():end");
		return retorno;		
	}
//	-------------------------------------------------------------------------------------------------------------	

	/**
	 * Registra traspaso de un abonado a otro cliente
	 * 
	 * @param datos
	 * @return RetornoDTO
	 * @throws ProductException
	 */
	public RetornoDTO registraReordenamientoPlan(ReordenamientoDTO datos)
			throws ProductException {
		logger.debug("registraReordenamientoPlan():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLregistraReordenamientoPlan();
		try {
		
			logger.debug("datos.getCodClienteOrigen()[" + datos.getCodClienteOrigen() + "]");
			logger.debug("datos.getCodClienteDestino()[" + datos.getCodClienteDestino() + "]");
			logger.debug("datos.getCodCuentaOrigen()[" + datos.getCodCuentaOrigen() + "]");
			logger.debug("datos.getCodCuentaDestino()[" + datos.getCodCuentaDestino() + "]");
			logger.debug("datos.getNumAbonado()[" + datos.getNumAbonado() + "]");
			logger.debug("datos.getCodSubCuentaOrigen()[" + datos.getCodSubCuentaOrigen() + "]");
			logger.debug("datos.getCodSubCuentaDestino()[" + datos.getCodSubCuentaDestino() + "]");
			logger.debug("datos.getCodPlanTarifDestino()[" + datos.getCodPlanTarifDestino() + "]");
			logger.debug("datos.getCodProducto()[" + datos.getCodProducto() + "]");
			logger.debug("datos.getUsuarioOracle()[" + datos.getUsuarioOracle() + "]");
			logger.debug("datos.getCodActAbo()[" + datos.getCodActAbo() + "]");
			logger.debug("datos.getCodTipoContrato()[" + datos.getCodTipoContrato() + "]");
			logger.debug("datos.getCodTipoTraspaso()[" + datos.getCodTipoTraspaso() + "]");
			logger.debug("datos.getNumContrato()[" + datos.getNumContrato() + "]");
			logger.debug("datos.getNumAnexo()[" + datos.getNumAnexo() + "]");
			logger.debug("datos.getUsuarioDestino()[" + datos.getUsuarioDestino() + "]");
			logger.debug("datos.getUsuarioOrigen()[" + datos.getUsuarioOrigen() + "]");
			logger.debug("datos.getNumCelular()[" + datos.getNumCelular() + "]");
			logger.debug("datos.getEmpresaOrigen()[" + datos.getEmpresaOrigen() + "]");
			logger.debug("datos.getEmpresaDestino()[" + datos.getEmpresaDestino() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, datos.getCodClienteOrigen());
			cstmt.setLong(2, datos.getCodClienteDestino());
			cstmt.setLong(3, datos.getCodCuentaOrigen());
			cstmt.setLong(4, datos.getCodCuentaDestino());
			cstmt.setLong(5, datos.getNumAbonado());
			cstmt.setString(6, datos.getCodSubCuentaOrigen());
			cstmt.setString(7, datos.getCodSubCuentaDestino());
			cstmt.setString(8, datos.getCodPlanTarifDestino());
			cstmt.setInt(9, datos.getCodProducto());
			cstmt.setString(10, datos.getUsuarioOracle());
			cstmt.setString(11, datos.getCodActAbo());
			cstmt.setString(12, datos.getCodTipoContrato());
			cstmt.setString(13, datos.getCodTipoTraspaso());
			cstmt.setString(14, datos.getNumContrato());
			cstmt.setString(15, datos.getNumAnexo());
			cstmt.setString(16, datos.getUsuarioDestino());
			cstmt.setString(17, datos.getUsuarioOrigen());
			cstmt.setLong(18, datos.getNumCelular());
			cstmt.setLong(19, datos.getEmpresaOrigen());
			cstmt.setLong(20, datos.getEmpresaDestino());
			
			cstmt.registerOutParameter(21, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(22, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(23, java.sql.Types.NUMERIC);			
		
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(21);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(22);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(23);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al registrar traspaso de un abonado a otro cliente");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			retorno = new RetornoDTO();
			retorno.setCodigo("0");
			retorno.setDescripcion(msgError);
		
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
		logger.debug("registraReordenamientoPlan():end");
		return retorno;
	}
//	-------------------------------------------------------------------------------------------------------------	

	/**
	 * Registra cambio de plan
	 * 
	 * @param datos
	 * @return RetornoDTO
	 * @throws ProductException
	 */	
	public RetornoDTO registroCambPlanComer(CambioPlanComercialDTO datos) throws ProductException{
		logger.debug("registroCambPlanComer():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLregistroCambPlanComer();
		try {
			
			logger.debug("datos.getIdSecuencia()[" + datos.getIdSecuencia() + "]");
			logger.debug("datos.getCodActAbo()[" + datos.getCodActAbo() + "]");
			logger.debug("datos.getCodProducto()[" + datos.getCodProducto() + "]");
			logger.debug("datos.getNumAbonado()[" + datos.getNumAbonado() + "]");
			logger.debug("datos.getCodTipoPlanTarif()[" + datos.getCodTipoPlanTarif() + "]");
			logger.debug("datos.getCodTipoPlanTarifDestino()[" + datos.getCodTipoPlanTarifDestino() + "]");
			logger.debug("datos.getCodHoldingEmpresa()[" + datos.getCodHoldingEmpresa() + "]");
			logger.debug("datos.getCodOOSS()[" + datos.getCodOOSS() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, datos.getIdSecuencia()); //NUM_TRANSACCION
			cstmt.setString(2, datos.getCodActAbo()); //COD_ACTABO
			cstmt.setInt(3, datos.getCodProducto()); //COD_PRODUCTO
			cstmt.setLong(4, datos.getNumAbonado()); //NUM_ABONADO
			cstmt.setString(5, datos.getCodTipoPlanTarif()); //TIP_PLANTARIF
			cstmt.setString(6, datos.getCodTipoPlanTarifDestino()); //COD_PLANTARIF_NUEVO
			cstmt.setString(7, datos.getCodHoldingEmpresa()); //COD_HOLDING
			cstmt.setLong(8, datos.getCodOOSS()); //COD_OS
			
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);			
		
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(9);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(10);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(11);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al registrar cambio de plan");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			retorno = new RetornoDTO();
			retorno.setDescripcion(msgError);
		
		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al registrar cambio de plan", e);
			throw new ProductException("Ocurrió un error general al registrar cambio de plan",e);
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
		logger.debug("registroCambPlanComer():end");
		return retorno;		
	}
//	-------------------------------------------------------------------------------------------------------------
}
