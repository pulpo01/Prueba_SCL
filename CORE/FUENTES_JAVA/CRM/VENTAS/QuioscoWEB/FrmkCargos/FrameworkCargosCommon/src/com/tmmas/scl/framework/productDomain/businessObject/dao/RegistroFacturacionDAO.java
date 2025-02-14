/**
 * Copyright © 2007 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 28/06/2007     Matias Guajardo      					Versión Inicial
 * 12/07/2007			Raúl Lozano				se modifica finally cierre de CallableStamtement
 * 19/07/2007			Raúl Lozano				se agrega metodo actualizaFacturacion         
 */


package com.tmmas.scl.framework.productDomain.businessObject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ImpuestosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ProcesoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RegistroCargosBatchDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces.RegistroFacturacionDAOIT;
import com.tmmas.scl.framework.productDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ArchivoFacturaDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegistroFacturacionDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;


public class RegistroFacturacionDAO extends ConnectionDAO implements RegistroFacturacionDAOIT{


	private final Logger logger = Logger.getLogger(RegistroFacturacionDAO.class);

	private final Global global = Global.getInstance();


	private String getSQLPackage(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
		for (int n = 1; n <= paramCount; n++) {
			sb.append("?");
			if (n < paramCount) sb.append(",");
		}
		return sb.append(")}").toString();

	}

	private String getSQLRegistraCargosBatch()
	{
		StringBuffer call = new StringBuffer();
		call.append("DECLARE ");                                                                                                                     
		  call.append("REG_PV_TRASPASO_CARGOS PV_TRASP_CARGOS := PV_INICIA_ESTRUCTURAS_PG.PV_INICIA_PV_TRASP_CARGOS_FN;");                                                                  
		call.append("BEGIN ");                                                                                                                      
		  call.append("Reg_pv_traspaso_cargos.NUM_OS        :=?;");                                                                                
		  call.append("Reg_pv_traspaso_cargos.NUM_CARGO     :=?;");                                                                              
		  call.append("Reg_pv_traspaso_cargos.COD_CONCEPTO  :=?;");                                                                                
		  call.append("Reg_pv_traspaso_cargos.FEC_ALTA      :=?;");                                                                                
		  call.append("Reg_pv_traspaso_cargos.IMP_CARGO     :=?;");                                                                                
		  call.append("Reg_pv_traspaso_cargos.COD_MONEDA    :=?;");                                                                                
		  call.append("Reg_pv_traspaso_cargos.COD_PLANCOM   :=?;");                                                                                
		  call.append("Reg_pv_traspaso_cargos.NUM_UNIDADES  :=?;");                                                                                
		  call.append("Reg_pv_traspaso_cargos.IND_FACTUR    :=?;");                                                                                
		  call.append("Reg_pv_traspaso_cargos.NUM_PAQUETE   :=?;");                                                                                
		  call.append("Reg_pv_traspaso_cargos.NUM_ABONADO   :=?;");                                                                                
		  call.append("Reg_pv_traspaso_cargos.COD_CICLFACT  :=?;");                                                                                
		  call.append("Reg_pv_traspaso_cargos.MES_GARANTIA  :=?;");                                                                                
		  call.append("Reg_pv_traspaso_cargos.NUM_PREGUIA   :=?;");                                                                                
		  call.append("Reg_pv_traspaso_cargos.NUM_GUIA      :=?;");                                                                                
		  call.append("Reg_pv_traspaso_cargos.NUM_FACTURA   :=?;");                                                                                
		  call.append("Reg_pv_traspaso_cargos.COD_CONCEPTO_DTO := ?;");                                                                            
		  call.append("Reg_pv_traspaso_cargos.VAL_DTO        := ?;");                                                                              
		  call.append("Reg_pv_traspaso_cargos.TIP_DTO        := ?;");                                                                              
		  call.append("Reg_pv_traspaso_cargos.IND_CUOTA      := ?;");                                                                              
		  call.append("Reg_pv_traspaso_cargos.IND_SUPERTEL   := ?;");                                                                              
		  call.append("Reg_pv_traspaso_cargos.IND_MANUAL     := ?;");                                                                              
		  call.append("Reg_pv_traspaso_cargos.NOM_USUARORA   := ?;");                                                                              
		  call.append("Reg_pv_traspaso_cargos.COD_CLIENTE    := ?;");                                                                              
		  call.append("Reg_pv_traspaso_cargos.COD_PRODUCTO   := ?;");                                                                              
		  call.append("Reg_pv_traspaso_cargos.NUM_TRANSACCION:= ?;");                                                                              
		  call.append("Reg_pv_traspaso_cargos.NUM_VENTA      := ?;");                                                                              
		  call.append("Reg_pv_traspaso_cargos.NUM_TERMINAL   := ?;");                                                                              
		  call.append("Reg_pv_traspaso_cargos.NUM_SERIE      := ?;");                                                                              
		  call.append("Reg_pv_traspaso_cargos.CAP_CODE       := ?;");                                                                              
		  call.append("Reg_pv_traspaso_cargos.NUM_SERIEMEC   := ?;");
		                                                                                
		call.append("PV_ORDEN_SERVICIO_PG.PV_INSERT_TRASPASO_CARGO_PR ( REG_PV_TRASPASO_CARGOS, ?, ?, ? );");
		call.append(" END;");


		return call.toString();		
	}
	
	/**
	 * Inserta en PV_TRASPASO_CARGOS los cargos Batch
	 * @param registro
	 * @return retorno
	 * @throws ProductException
	 */
	public RetornoDTO registraCargosBatch(RegistroCargosBatchDTO registro) throws ProductException{
		RetornoDTO retorno = new RetornoDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		String call = getSQLRegistraCargosBatch();
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());			
			cstmt = conn.prepareCall(call);			
			

			//ini------------------CONTINUAR CARGA DE PARAMETROS-------------------
			cstmt.setLong(1, registro.getNumOs());
			cstmt.setLong(2, registro.getNumCargo());
			cstmt.setLong(3, registro.getCodConcepto());
			cstmt.setDate(4, registro.getFecAlta());
			cstmt.setFloat(5, registro.getImpCargo());
			cstmt.setString(6, registro.getCodMoneda()==null?"":registro.getCodMoneda());
			cstmt.setLong(7, registro.getCodPlanCom());
			cstmt.setLong(8, registro.getNumUnidades());
			cstmt.setLong(9, registro.getIndFactur());
			cstmt.setLong(10, registro.getNumPaquete());
			cstmt.setLong(11, registro.getNumAbonado());
			cstmt.setLong(12, registro.getCodCiclFact());
			cstmt.setLong(13, registro.getMesGarantia());
			cstmt.setString(14, registro.getNumPreGuia()==null?"":registro.getNumPreGuia());
			cstmt.setString(15, registro.getNumGuia()==null?"":registro.getNumGuia());
			cstmt.setLong(16, registro.getNumFactura());
			cstmt.setString(17, registro.getCodConceptoDto()==0?null:String.valueOf(registro.getCodConceptoDto()));//Se debe insertar null si es 0 ya que 0 = null
			cstmt.setFloat(18, registro.getValDto());
			cstmt.setString(19, registro.getTipDto()==9?null:String.valueOf(registro.getTipDto()));//Se debe insertar null si es 9 ya que 9 = null
			cstmt.setLong(20, registro.getIndCuota());
			cstmt.setLong(21, registro.getIndSupertel());
			cstmt.setLong(22, registro.getIndManual());
			cstmt.setString(23, registro.getNomUsuarOra()==null?"":registro.getNomUsuarOra());
			cstmt.setLong(24, registro.getCodCliente());
			cstmt.setLong(25, registro.getCodProducto());
			cstmt.setLong(26, registro.getNumTransaccion());
			cstmt.setLong(27, registro.getNumVenta());
			cstmt.setString(28, registro.getNumTerminal()==null?"":registro.getNumTerminal());
			cstmt.setString(29, registro.getNumSerie()==null?"":registro.getNumSerie());
			cstmt.setLong(30, registro.getCapCode());
			cstmt.setString(31, registro.getNumSerieMec()==null?"":registro.getNumSerieMec());
			
			
			cstmt.registerOutParameter(32, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(33, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(34, java.sql.Types.NUMERIC);

			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");

			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(32);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(33);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(34);
			logger.debug("numEvento[" + numEvento + "]");
			//fin----------------------------------------------------------------------

			if (codError != 0) {
				logger.error(" Ocurrió un error al Registrar cargos Batch");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}
		}catch (ProductException e){
			throw e;
		} catch (Exception e) {
			if (logger.isDebugEnabled()) {
				throw new ProductException("Ocurrió un error General al Registrar cargos Batch");
			}
		} finally {
			logger.debug("Cerrando conexiones...");
			try {
				if(cstmt!=null){
					cstmt.close();
					cstmt=null;
				}
				if (!conn.isClosed()) {
					conn.close();
					conn=null;
				}
			} catch (SQLException e) {
				cstmt=null;
				conn=null;
				logger.debug("SQLException", e);
			}
		}

		logger.debug("Fin:getCodigoPromedioFacturado");

		return retorno;
	}


	
	public RegistroFacturacionDTO getCodigoPromedioFacturado(RegistroFacturacionDTO entrada) throws ProductException{
		RegistroFacturacionDTO resultado = new RegistroFacturacionDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null; 
		try {
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			logger.debug("Inicio:getCodigoPromedioFacturado");

			String call = getSQLPackage("VE_servicios_venta_PG","VE_obtiene_codpromedio_fact_PR",5);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			logger.debug("Valor Promedio: "+entrada.getValorPromedio());
			cstmt.setFloat(1,entrada.getValorPromedio());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.execute();
			codError=cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento=cstmt.getInt(5);
			logger.debug("msgError[" + msgError + "]");

			if (codError==0)
				resultado.setCodigoPromedio(cstmt.getInt(2));


		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener el codigo de promedio facturados",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
			logger.debug("Cerrando conexiones...");
			try {
				if(cstmt!=null){
					cstmt.close();
					cstmt=null;
				}
				if (!conn.isClosed()) {
					conn.close();
					conn=null;
				}
			} catch (SQLException e) {
				cstmt=null;
				conn=null;
				logger.debug("SQLException", e);
			}
		}

		logger.debug("Fin:getCodigoPromedioFacturado");

		return resultado;
	}


	public RegistroFacturacionDTO getCodigoCicloFacturacion(ClienteDTO cliente) throws ProductException{
		RegistroFacturacionDTO resultado = new RegistroFacturacionDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:getCodigoCicloFacturacion");
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			//INI-01 (AL) String call = getSQLPackage("VE_servicios_venta_PG","VE_consulta_ciclo_fact_PR",5);
			String call = getSQLPackage("VE_servicios_venta_quiosco_PG","VE_consulta_ciclo_fact_PR",5);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			logger.debug("[getCodigoCicloFacturacion] CodigoCliente: " + cliente.getCodigoCiclo());
			cstmt.setInt(1,cliente.getCodCiclo());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			codError=cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento=cstmt.getInt(5);
			logger.debug("msgError[" + msgError + "]");
			if (codError!=0){
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}else {
				resultado.setCodigoCicloFacturacion(cstmt.getInt(2));
			}
			logger.debug("CodigoCicloFacturacion : " + resultado.getCodigoCicloFacturacion());
		}
		catch (Exception e) {
			logger.error("Ocurrió un error al obtener el codigo ciclo de facturación",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
			logger.debug("Cerrando conexiones...");
			try {
				if(cstmt!=null){
					cstmt.close();
					cstmt=null;
				}
				if (!conn.isClosed()) {
					conn.close();
					conn=null;
				}
			} catch (SQLException e) {
				cstmt=null;
				conn=null;
				logger.debug("SQLException", e);
			}
		}

		logger.debug("Fin:getCodigoCicloFacturacion");

		return resultado;
	}//fin getCodigoCicloFacturacion

	public void ejecutaPrebilling(RegistroFacturacionDTO entrada) throws ProductException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;

		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:ejecutaPrebilling");
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			String call = getSQLPackage("VE_intermediario_PG","VE_ejecuta_prebilling_PR",12);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setString(1,entrada.getSecuenciaTransacabo());
			logger.debug("getSecuenciaTransacabo: [" + entrada.getSecuenciaTransacabo() + "]");
			cstmt.setString(2,entrada.getActuacionPrebilling());
			logger.debug("getActuacionPrebilling: [" + entrada.getActuacionPrebilling() + "]");
			cstmt.setString(3,entrada.getProductoGeneral());
			logger.debug("getProductoGeneral: [" + entrada.getProductoGeneral() + "]");
			cstmt.setString(4,entrada.getCodigoCliente());
			logger.debug("getCodigoCliente: [" + entrada.getCodigoCliente() + "]");
			cstmt.setString(5,entrada.getNumeroVenta());
			logger.debug("getNumeroVenta: [" + entrada.getNumeroVenta() + "]");
			cstmt.setString(6,entrada.getNumeroTransaccionVenta());
			logger.debug("getNumeroTransaccionVenta: [" + entrada.getNumeroTransaccionVenta() + "]");
			cstmt.setString(7,entrada.getNumeroProcesoFacturacion());
			logger.debug("getNumeroProcesoFacturacion: [" + entrada.getNumeroProcesoFacturacion() + "]");
			cstmt.setString(8,entrada.getModoGeneracion());
			logger.debug("getModoGeneracion: [" + entrada.getModoGeneracion() + "]");
			cstmt.setString(9,entrada.getCategoriaTributaria());
			logger.debug("getCategoriaTributaria: [" + entrada.getCategoriaTributaria() + "]");
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(12, java.sql.Types.NUMERIC);
			cstmt.execute();
			codError=cstmt.getInt(10);
			msgError = cstmt.getString(11);
			numEvento=cstmt.getInt(12);
			logger.debug("msgError[" + msgError + "]");

		} catch (Exception e) {
			logger.error("Ocurrió un error al ejecutar el prebilling",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
			logger.debug("Cerrando conexiones...");
			try {
				if(cstmt!=null){
					cstmt.close();
					cstmt=null;
				}
				if (!conn.isClosed()) {
					conn.close();
					conn=null;
				}
			} catch (SQLException e) {
				cstmt=null;
				conn=null;
				logger.debug("SQLException", e);
			}
		}

		logger.debug("Fin:ejecutaPrebilling");

	}//fin ejecutaPrebilling

	/**
	 * Obtiene secuencia de proceso de facturación
	 * @param parametroEntrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */

	public RegistroFacturacionDTO getSecuenciaProcesoFacturacion(RegistroFacturacionDTO parametroEntrada) throws ProductException{
		RegistroFacturacionDTO resultado=new RegistroFacturacionDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;

		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:getSecuenciaProcesoFacturacion");
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			String call = getSQLPackage("VE_intermediario_PG","VE_OBTIENE_SECUENCIA_PR",5);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,parametroEntrada.getCodigoSecuencia());
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			logger.debug("Inicio:getSecuenciaProcesoFacturacion:execute");
			cstmt.execute();
			logger.debug("Fin:getSecuenciaProcesoFacturacion:execute");

			codError=cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento=cstmt.getInt(5);
			logger.debug("msgError[" + msgError + "]");

			if (codError != 0){
				logger.error("Ocurrió un error al obtener secuencia del proceso de facturación");
				throw new ProductException(
						"Ocurrió un error al obtener secuencia transacabo", String
						.valueOf(codError), numEvento, msgError);
			}
			else
				resultado.setNumeroProcesoFacturacion(cstmt.getString(2));

		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener la secuencia del proceso de facturación",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
			logger.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null){
					cstmt.close();
					cstmt=null;
				}
				if (!conn.isClosed()) {
					conn.close();
					conn=null;
				}
			} catch (SQLException e) {
				cstmt=null;
				conn=null;
				logger.debug("SQLException", e);
			}
		}

		logger.debug("Fin:getSecuenciaProcesoFacturacion");

		return resultado;
	}//fin getSecuenciaProcesoFacturacion

	/**
	 * Obtiene el modo de generación, utilizado para ejecutar el Prebilling
	 * @param registroFacturacion
	 * @return registroFacturacion
	 * @throws CustomerDomainException
	 */

	public RegistroFacturacionDTO getModoGeneracion(RegistroFacturacionDTO registroFacturacion) throws ProductException{

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;

		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:getModoGeneracion");
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			String call = getSQLPackage("VE_servicios_venta_PG","VE_obtiene_modo_gener_fact_PR",13);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,registroFacturacion.getCodigoOficina());
			logger.debug("[getModoGeneracion] getCodigoOficina: " +  registroFacturacion.getCodigoOficina());
			cstmt.setString(2,registroFacturacion.getCodigoTipoDocumento());
			logger.debug("[getModoGeneracion] getCodigoTipoDocumento: " + registroFacturacion.getCodigoTipoDocumento());
			cstmt.setString(3,registroFacturacion.getValorParametroFacturaGlobal());
			logger.debug("[getModoGeneracion] getValorParametroFacturaGlobal: " + registroFacturacion.getValorParametroFacturaGlobal());
			cstmt.setString(4,registroFacturacion.getValorParametroDocumentoGuia());
			logger.debug("[getModoGeneracion] getValorParametroDocumentoGuia: " + registroFacturacion.getValorParametroDocumentoGuia());
			cstmt.setString(5,registroFacturacion.getCodigoTipoFoliacion());
			logger.debug("[getModoGeneracion] getCodigoTipoFoliacion: " + registroFacturacion.getCodigoTipoFoliacion());
			cstmt.setString(6,registroFacturacion.getCodigoTipoMovimiento());
			logger.debug("[getModoGeneracion] getCategoriaTributaria: " + registroFacturacion.getCategoriaTributaria());
			cstmt.setString(7,registroFacturacion.getCategoriaTributaria());
			logger.debug("[getModoGeneracion] getValorParametroFlagCentroFact: " + registroFacturacion.getValorParametroFlagCentroFact());
			cstmt.setString(8,registroFacturacion.getValorParametroFlagCentroFact());
			logger.debug("[getModoGeneracion] getModalidadVenta: " + registroFacturacion.getModalidadVenta());
			cstmt.setString(9,registroFacturacion.getModalidadVenta());
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(13, java.sql.Types.NUMERIC);
			cstmt.execute();
			codError=cstmt.getInt(11);
			msgError = cstmt.getString(12);
			numEvento=cstmt.getInt(13);
			logger.debug("msgError[" + msgError + "]");

			if (codError==0)
				registroFacturacion.setModoGeneracion(cstmt.getString(10));
			else{
				logger.error("Ocurrió un error al obtener el modo de generación");
				throw new ProductException("Ocurrió un error al obtener el modo de generación", String.valueOf(codError), numEvento, msgError);
			}

			logger.debug("CodigoCicloFacturacion : " + cstmt.getString(10));
		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener el modo de generación",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
			logger.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null){
					cstmt.close();
					cstmt=null;
				}
				if (!conn.isClosed()) {
					conn.close();
					conn=null;
				}
			} catch (SQLException e) {
				cstmt=null;
				conn=null;
				logger.debug("SQLException", e);
			}
		}

		logger.debug("Fin:getModoGeneracion");

		return registroFacturacion;
	}//fin getModoGeneracion

	/**
	 * Obtiene Presupuesto
	 * @param parametroEntrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */

	public ImpuestosDTO getDatosPresupuesto(ImpuestosDTO parametroEntrada) throws ProductException{
		ImpuestosDTO resultado=new ImpuestosDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;

		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:getDatosPresupuesto");
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			String call = getSQLPackage("VE_intermediario_PG","VE_ObtienePresupuesto_PR",7);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,parametroEntrada.getNumeroProceso());
			logger.debug("parametroEntrada.getNumeroProceso(): " + parametroEntrada.getNumeroProceso());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);

			logger.debug("Inicio:getDatosPresupuesto:execute");
			cstmt.execute();
			logger.debug("Fin:getDatosPresupuesto:execute");

			codError=cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento=cstmt.getInt(7);
			logger.debug("codError[" + codError + "]");
			logger.debug("msgError[" + msgError + "]");
			logger.debug("numEvento[" + numEvento + "]");

			if (codError != 0){
				logger.error("Ocurrió un error al obtener el presupuesto");
				throw new ProductException(
						"Ocurrió un error al obtener el presupuesto", String
						.valueOf(codError), numEvento, msgError);
			}
			else{
				resultado.setNumeroProceso(parametroEntrada.getNumeroProceso());
				resultado.setTotalCargos(cstmt.getFloat(2));
				resultado.setTotalDescuentos(cstmt.getFloat(3));
				resultado.setTotalImpuestos(cstmt.getFloat(4));
			}

		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener el presupuesto",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
			logger.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null){
					cstmt.close();
					cstmt=null;
				}
				if (!conn.isClosed()) {
					conn.close();
					conn=null;
				}
			} catch (SQLException e) {
				cstmt=null;
				conn=null;
				logger.debug("SQLException", e);
			}
		}

		logger.debug("Fin:getDatosPresupuesto");

		return resultado;
	}//fin getDatosPresupuesto

	public ProcesoDTO actualizaFacturacion(RegistroFacturacionDTO parametroEntrada) throws ProductException{
		ProcesoDTO resultado=null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null; 

		try {
			logger.debug("Inicio:actualizaFacturacion");

			String call = getSQLPackage("VE_SERVICIOS_VENTA_PG","VE_ACTUALIZA_FACTURACION_PR",13);

			logger.debug("sql[" + call + "]");
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,parametroEntrada.getEstadoDocumento());
			cstmt.setString(2,parametroEntrada.getEstadoProceso());
			cstmt.setString(3,parametroEntrada.getCategoriaTributaria());
			cstmt.setString(4,parametroEntrada.getNumeroFolio());
			cstmt.setString(5,parametroEntrada.getPrefijoPlaza());
			cstmt.setString(6,parametroEntrada.getFechaVencimiento());
			cstmt.setString(7,parametroEntrada.getNombreUsuarioEliminacion());
			cstmt.setString(8,parametroEntrada.getCausalEliminacion());
			cstmt.setString(9,parametroEntrada.getNumeroProcesoFacturacion());
			cstmt.setString(10,parametroEntrada.getNumeroVenta());
			cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(13, java.sql.Types.NUMERIC);

			logger.debug("Inicio:actualizaFacturacion:execute");
			cstmt.execute();
			logger.debug("Fin:actualizaFacturacion:execute");

			codError=cstmt.getInt(11);
			msgError = cstmt.getString(12);
			numEvento=cstmt.getInt(13);
			logger.debug("msgError[" + msgError + "]");

			if (codError != 0){
				resultado = new ProcesoDTO();
				resultado.setCodigoError(codError);
				resultado.setEvento(numEvento);
			}

		} catch (Exception e) {
			logger.error("Ocurrió un error al actualizar la facturación",e);
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

		logger.debug("Fin:actualizaFacturacion");

		return resultado;
	}//fin actualizaFacturacion

	/**
	 * Obtiene directorio donde se encuentra la factura
	 * @param factura
	 * @return ArchivoFacturaDTO
	 * @throws ProductException
	 */
	public ArchivoFacturaDTO obtenerRutaFactura(ArchivoFacturaDTO factura) throws ProductException{
		ArchivoFacturaDTO resultado = new ArchivoFacturaDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null; 
		try {
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			logger.debug("Inicio:obtenerRutaFactura");

			String call = getSQLPackage("FA_PRESUPUESTO_SP_PG","FA_CONS_ARCH_FACT_PR",5);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, factura.getNumProceso());
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.execute();
			codError  = cstmt.getInt(3);
			msgError  = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			logger.debug("msgError[" + msgError + "]");

			if (codError != 0){
				logger.error("Ocurrió un error al obtener ruta de la factura");
				throw new ProductException(	"Ocurrió un error al obtener ruta de la factura", String.valueOf(codError), numEvento, msgError);
			}
			else
				resultado.setRutaFactura(cstmt.getString(2));

		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener ruta de la factura",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
			logger.debug("Cerrando conexiones...");
			try {
				if(cstmt!=null){
					cstmt.close();
					cstmt=null;
				}
				if (!conn.isClosed()) {
					conn.close();
					conn=null;
				}
			} catch (SQLException e) {
				cstmt=null;
				conn=null;
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:obtenerRutaFactura");

		return resultado;
	}
}
