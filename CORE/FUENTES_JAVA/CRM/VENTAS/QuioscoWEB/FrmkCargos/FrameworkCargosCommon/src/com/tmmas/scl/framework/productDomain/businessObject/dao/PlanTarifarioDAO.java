package com.tmmas.scl.framework.productDomain.businessObject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosDescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosValidacionTasacionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioCargoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ResultadoValidacionTasacionDTO;
import com.tmmas.scl.framework.productDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.productDomain.dataTransferObject.PlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductOfferingException;


public class PlanTarifarioDAO extends ConnectionDAO{

	private final Logger logger = Logger.getLogger(PlanTarifarioDAO.class);

	private final Global global = Global.getInstance();


	

	private String getSQLDatosPlanTarifario(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
		for (int n = 0; n < paramCount; n++) {
			sb.append("?");
			if ((n+1) < paramCount) sb.append(",");
		}
		return sb.append(")}").toString();
	}
	
	private String getSQLgetCodigoCategoria(){
		StringBuffer call =new StringBuffer();
		call.append("");
		call.append("BEGIN "); 
		call.append("  VE_SERVICIOS_VENTA_PG.VE_CONSULTA_CATEG_PTARIF_PR (?, ?, ?, ?, ? ); ");
		call.append("END;");
		return call.toString();
	}


	/**
	 * Obtiene todos los atributos del Plan Tarifario.
	 * 
	 * @param planEntrada
	 * @return resultado
	 * @throws ProductOfferingException
	 */
	public PlanTarifarioDTO getPlanTarifario(PlanTarifarioDTO planEntrada) throws ProductOfferingException{
		logger.debug("Inicio:getPlanTarifario()");
		PlanTarifarioDTO resultado = new PlanTarifarioDTO();
		resultado.setCodigoPlanTarifario(planEntrada.getCodigoPlanTarifario());
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		try {
			//INI-01 (AL) String call = getSQLDatosPlanTarifario("VE_servicios_venta_PG","VE_consulta_plan_tarifario_PR",20);
			String call = getSQLDatosPlanTarifario("VE_servicios_venta_quiosco_PG","VE_consulta_plan_tarifario_PR",20);
			logger.debug("sql[" + call + "]");
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,planEntrada.getCodigoPlanTarifario());
			logger.debug("planEntrada.getCodigoPlanTarifario() ["+planEntrada.getCodigoPlanTarifario()+"]");
			cstmt.setInt(2,Integer.parseInt(planEntrada.getCodigoProducto()));
			logger.debug("planEntrada.getCodigoProducto() ["+planEntrada.getCodigoProducto()+"]");
			cstmt.setString(3,planEntrada.getCodigoTecnologia());
			logger.debug("planEntrada.getCodigoTecnologia() ["+planEntrada.getCodigoTecnologia()+"]");
			
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR); 		// SV_desplantarif
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR); 		// SV_tipplantarif
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR); 		// SV_codlimconsumo
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC); 		// SN_numdias
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR); 		// SV_codplanserv
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR); 		// SN_ind_cargo_habil
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR); 	// SV_codcargobasico
			cstmt.registerOutParameter(11, java.sql.Types.VARCHAR); 	// SV_descargobasico
			cstmt.registerOutParameter(12, java.sql.Types.NUMERIC); 	// SN_importecargo
			cstmt.registerOutParameter(13, java.sql.Types.NUMERIC); 	// SN_importecargo
			cstmt.registerOutParameter(14, java.sql.Types.VARCHAR); 	// SV_codigotipoplan
			cstmt.registerOutParameter(15, java.sql.Types.NUMERIC); 	// SN_indfamiliar
			cstmt.registerOutParameter(16, java.sql.Types.NUMERIC); 	// SN_num_abonados
			cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);
			//-- control error
			cstmt.registerOutParameter(18, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(19, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(20, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getPlanTarifario:execute");
			cstmt.execute();
			logger.debug("Fin:getPlanTarifario:execute");

			codError = cstmt.getInt(18);
			msgError = cstmt.getString(19);
			numEvento = cstmt.getInt(20);

			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");
			
			//-- plan tarifario
			resultado.setDesPlanTarif(cstmt.getString(4));
			resultado.setTipoPlanTarifario(cstmt.getString(5));
			resultado.setCodigoLimiteConsumo(cstmt.getString(6));
			resultado.setNumDias(cstmt.getInt(7));
			resultado.setCodigoPlanServicio(cstmt.getString(8));
			resultado.setIndicadorCargoHabilitacion(cstmt.getString(9));
			
			//-- cargo basico
			resultado.setCodigoCargoBasico(cstmt.getString(10));
			resultado.setDesCargoBasico(cstmt.getString(11));
			resultado.setImporteCargoBasico(cstmt.getFloat(12));
			resultado.setCodigoMonedaCargoBasico(cstmt.getString(13));
			resultado.setCodigoTipoPlan(cstmt.getString(14));
			//resultado.setIndFamiliar(cstmt.getInt(15));
			//resultado.setNumAbonado(cstmt.getInt(16));
			//resultado.setPlanComverse(cstmt.getString(17));
			
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			logger.error("Ocurrió un error al recuperar Plan Tarifario",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
		 	if (logger.isDebugEnabled()) 
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:getPlanTarifario()");
		return resultado;
	}//fin getPlanTarifario
	/**
	 * Verifica si Existe o no un Plan Tarifario especifico 
	 * @param planEntrada
	 * @return resultado
	 * @throws ProductDomainException
	 */

	public ResultadoValidacionTasacionDTO existePlanTarifario(ParametrosValidacionTasacionDTO planEntrada) 
	throws ProductOfferingException{

		logger.debug("Inicio:existePlanTarifario()");

		ResultadoValidacionTasacionDTO resultado = new ResultadoValidacionTasacionDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		try {
			String call = getSQLDatosPlanTarifario("VE_validacion_linea_PG","VE_existe_plan_tarifario_PR",7);
			logger.debug("sql[" + call + "]");
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,planEntrada.getCodigoPlanTarifario());
			logger.debug("planEntrada.getCodigoPlanTarifario() ["+planEntrada.getCodigoPlanTarifario()+"]");
			cstmt.setInt(2,Integer.parseInt(planEntrada.getCodigoProducto()));
			logger.debug("planEntrada.getCodigoProducto() ["+planEntrada.getCodigoProducto()+"]");
			cstmt.setString(3,planEntrada.getCodigoTecnologia());
			logger.debug("planEntrada.getCodigoTecnologia() ["+planEntrada.getCodigoTecnologia()+"]");
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC); //SB_resultado
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);

			logger.debug("Inicio:existePlanTarifario:Execute");
			cstmt.execute();
			logger.debug("Fin:existePlanTarifario:Execute");

			msgError = cstmt.getString(6);
			logger.debug("msgError[" + msgError + "]");
			resultado.setResultadoBase(cstmt.getInt(4));
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			logger.error("Ocurrió un error al recuperar Plan Tarifario",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
			if (logger.isDebugEnabled()) 
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}

		logger.debug("Fin:existePlanTarifario()");
		return resultado;
	}


	/**
	 * Busca todos los Cargos Basicos asociados al Plan Tarifario
	 * @param entrada
	 * @return resultado
	 * @throws ProductOfferingException
	 */
	public PrecioCargoDTO[] getCargoBasico(PlanTarifarioDTO entrada) throws ProductOfferingException{

		logger.debug("Inicio:getCargoBasico()");

		PrecioCargoDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		

		try {
			String call = getSQLDatosPlanTarifario("VE_servicios_venta_PG","VE_precio_cargo_basico_PR",6);
			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());

			cstmt.setString(1,entrada.getCodigoProducto());
			cstmt.setString(2,entrada.getCodCargoBasico());
			cstmt.registerOutParameter(3,OracleTypes.CURSOR);
			//-- control error
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

			logger.debug("Inicio:getCargoBasico:Execute");
			cstmt.execute();
			logger.debug("Fin:getCargoBasico:Execute");

			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);

			if (codError != 0) {
				logger.error("Ocurrió un error al recuperar cargos basicos");
				throw new ProductOfferingException(
						"Ocurrió un error al recuperar cargos basicos", String
						.valueOf(codError), numEvento, msgError);

			}else{
				logger.debug("Recuperando cargos basicos");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(3);
				while (rs.next()) {
					PrecioCargoDTO precioDTO = new PrecioCargoDTO();
					precioDTO.setCodigoConcepto(rs.getString(1));
					precioDTO.setDescripcionConcepto(rs.getString(2));
					precioDTO.setMonto(rs.getFloat(3));
					precioDTO.setCodigoMoneda(rs.getString(4));
					precioDTO.setDescripcionMoneda(rs.getString(5));
					//-- VALORES CONSTANTES
					precioDTO.setIndicadorAutMan(rs.getString(6));
					precioDTO.setNumeroUnidades(rs.getString(7));
					precioDTO.setIndicadorEquipo(rs.getString(8));
					precioDTO.setIndicadorPaquete(rs.getString(9));
					precioDTO.setMesGarantia(rs.getString(10));
					precioDTO.setIndicadorAccesorio(rs.getString(11));
					precioDTO.setCodigoArticulo(rs.getString(12));
					precioDTO.setCodigoStock(rs.getString(13));
					precioDTO.setCodigoEstado(rs.getString(14));

					lista.add(precioDTO);
				}
				rs.close();
				resultado =(PrecioCargoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
						lista.toArray(), PrecioCargoDTO.class);

				logger.debug("Fin recuperacion de cargos basicos");
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			logger.error("Ocurrió un error al recuperar cargos basicos",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new ProductOfferingException(
					"Ocurrió un error al recuperar cargos basicos",e);
		} finally {
			if (logger.isDebugEnabled()) 
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:getCargoBasico()");

		return resultado;
	}//fin getCargoBasico


	/**
	 * Busca todos los Descuentos tipo Articulo asociados al Plan Tarifario(Cargo Basico) 
	 * @param entrada
	 * @return resultado
	 * @throws ProductOfferingException
	 */
	public DescuentoDTO[] getDescuentoCargoBasicoArticulo(ParametrosDescuentoDTO entrada) throws ProductOfferingException{

		logger.debug("Inicio:getDescuentoCargoBasicoArticulo()");

		DescuentoDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		try {
			String call = getSQLDatosPlanTarifario("VE_servicios_venta_PG","VE_obtiene_descuento_art_PR",14);
			logger.debug("sql[" + call + "]");
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());

			cstmt = conn.prepareCall(call);
			logger.debug("[getDescuentoCargoBasicoArticulo] cod operacion: " + entrada.getCodigoOperacion());
			logger.debug("[getDescuentoCargoBasicoArticulo] tipocontrato: " + entrada.getTipoContrato());
			logger.debug("[getDescuentoCargoBasicoArticulo] numero meses: " + entrada.getNumeroMesesContrato());
			logger.debug("[getDescuentoCargoBasicoArticulo] codigo antiguedad: " + entrada.getCodigoAntiguedad());
			logger.debug("[getDescuentoCargoBasicoArticulo] cod promedio: " + entrada.getCodigoPromedioFacturable());
			logger.debug("[getDescuentoCargoBasicoArticulo] estado: " + entrada.getEquipoEstado());
			logger.debug("[getDescuentoCargoBasicoArticulo] contrato: " + entrada.getTipoContrato());
			logger.debug("[getDescuentoCargoBasicoArticulo] numero meses: " + entrada.getNumeroMesesNuevo());
			logger.debug("[getDescuentoCargoBasicoArticulo] cod articulo: " + entrada.getCodigoArticulo());
			logger.debug("[getDescuentoCargoBasicoArticulo] clase desc: " + entrada.getClaseDescuento());
			cstmt.setString(1,entrada.getCodigoOperacion());
			cstmt.setString(2,entrada.getTipoContrato());
			cstmt.setInt(3,entrada.getNumeroMesesContrato());
			cstmt.setString(4,entrada.getCodigoAntiguedad());
			cstmt.setString(5,entrada.getCodigoPromedioFacturable());
			cstmt.setString(6,entrada.getEquipoEstado());
			cstmt.setString(7,entrada.getTipoContrato());
			cstmt.setInt(8,Integer.parseInt(entrada.getNumeroMesesNuevo()));
			cstmt.setString(9,entrada.getCodigoArticulo());
			cstmt.setString(10,entrada.getClaseDescuento());
			cstmt.registerOutParameter(11,OracleTypes.CURSOR);
			//-- control error
			cstmt.registerOutParameter(12, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(14, java.sql.Types.NUMERIC);

			logger.debug("Inicio:getDescuentoCargoBasicoArticulo:Execute");
			cstmt.execute();
			logger.debug("Fin:getDescuentoCargoBasicoArticulo:Execute");

			codError = cstmt.getInt(12);
			msgError = cstmt.getString(13);
			numEvento = cstmt.getInt(14);

			if (codError == 0) {
				logger.debug("Recuperando descuentos");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(11);
				while (rs.next()) {
					DescuentoDTO descuentoDTO = new DescuentoDTO();
					descuentoDTO.setTipoAplicacion(rs.getString(1));
					descuentoDTO.setDescripcionConcepto(rs.getString(2));
					descuentoDTO.setMonto(rs.getFloat(3));
					descuentoDTO.setCodigoConcepto(rs.getString(4));
					
					logger.debug("[getDescuentoCodigoConcpeto]: " + rs.getString(4));
					logger.debug("[getDescuentoDescripcionConcepto] : " + rs.getString(2));
					logger.debug("[getDescuentoMonto]: " + rs.getFloat(3));

					
					lista.add(descuentoDTO);
				}
				rs.close();
				resultado =(DescuentoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
						lista.toArray(), DescuentoDTO.class);
				logger.debug("Fin recuperacion de descuentos del cargo basico");
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			logger.error("Ocurrió un error al recuperar los descuentos del cargo basico",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new ProductOfferingException(
					"Ocurrió un error al recuperar los descuentos del cargo basico",e);
		} finally {
			if (logger.isDebugEnabled()) 
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:etDescuentoCargoBasicoArticulo()");

		return resultado;
	}//fin getDescuentoCargoBasicoArticulo


	/**
	 * Busca todos los Descuentos tipo concepto asociados al Plan Tarifario(Cargo Basico) 
	 * @param entrada
	 * @return resultado
	 * @throws ProductOfferingException
	 */
	public DescuentoDTO[] getDescuentoCargoBasicoConcepto(ParametrosDescuentoDTO entrada) throws ProductOfferingException{

		logger.debug("Inicio:PlanTarifarioDAO:getDescuentoCargoBasicoConcepto()");

		DescuentoDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		try {
			String call = getSQLDatosPlanTarifario("VE_servicios_venta_PG","VE_obtiene_descuento_con_PR",16);
			logger.debug("sql[" + call + "]");
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());

			cstmt = conn.prepareCall(call);

			cstmt.setString(1,entrada.getCodigoOperacion());
			cstmt.setString(2,entrada.getCodigoAntiguedad());
			cstmt.setString(3,entrada.getCodigoContratoNuevo());
			cstmt.setInt(4,Integer.parseInt(entrada.getNumeroMesesNuevo()));
			cstmt.setInt(5,Integer.parseInt(entrada.getIndiceVentaExterna()));
			cstmt.setLong(6,Long.parseLong(entrada.getCodigoVendedor()));
			cstmt.setString(7,entrada.getCodigoCausaVenta());
			cstmt.setString(8,entrada.getCodigoCategoria());
			cstmt.setInt(9,Integer.parseInt(entrada.getCodigoModalidadVenta()));
			cstmt.setInt(10,Integer.parseInt(entrada.getTipoPlanTarifario()));
			cstmt.setInt(11,Integer.parseInt(entrada.getConcepto()));
			cstmt.setString(12,entrada.getClaseDescuento());
			cstmt.registerOutParameter(13,OracleTypes.CURSOR);
			//-- control error
			cstmt.registerOutParameter(14, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(15, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(16, java.sql.Types.NUMERIC);

			cstmt.execute();

			codError = cstmt.getInt(14);
			msgError = cstmt.getString(15);
			numEvento = cstmt.getInt(16);

			if (codError == 0) {
				logger.debug("Recuperando descuentos");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(13);
				while (rs.next()) {
					DescuentoDTO descuentoDTO = new DescuentoDTO();
					descuentoDTO.setTipoAplicacion(rs.getString(1));
					descuentoDTO.setDescripcionConcepto(rs.getString(2));
					descuentoDTO.setMonto(rs.getFloat(3));
					descuentoDTO.setCodigoConcepto(rs.getString(4));

					lista.add(descuentoDTO);
				}
				rs.close();
				resultado =(DescuentoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
						lista.toArray(), DescuentoDTO.class);
				logger.debug("Fin recuperacion de descuentos del cargo basico");
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			logger.error("Ocurrió un error al recuperar los descuentos del cargo basico",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new ProductOfferingException(
					"Ocurrió un error al recuperar los descuentos del cargo basico",e);
		} finally {
			if (logger.isDebugEnabled()) 
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:PlanTarifarioDAO:getDescuentoCargoBasicoConcepto()");

		return resultado;
	}//fin getDescuentoCargoBasicoArticulo	


	/**
	 * Busca la categoria del Plan Tarifario
	 * @param planEntrada
	 * @return resultado
	 * @throws ProductDomainException
	 */
	public PlanTarifarioDTO getCategoriaPlanTarifario(PlanTarifarioDTO planEntrada) throws ProductOfferingException{

		logger.debug("Inicio:PlanTarifarioDAO:getCategoriaPlanTarifario()");

		PlanTarifarioDTO resultado = new PlanTarifarioDTO();
		resultado.setCodPlanTarif(planEntrada.getCodPlanTarif());
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		String codPlanTarif = null;
		
		try {
			logger.debug("Código Plan tarifario :: "+planEntrada.getCodigoPlanTarifario());
			logger.debug("planEntrada.getCodPlanTarif():: " + planEntrada.getCodPlanTarif());
			String call = getSQLgetCodigoCategoria();
			logger.debug("sql[" + call + "]");
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());

			cstmt = conn.prepareCall(call);



            // INI INC-79469; COL; 12-03-2009; AVC
			// cstmt.setString(1, planEntrada.getCodPlanTarif()); // AVC

			if (planEntrada.getCodPlanTarif()!=null){
                  codPlanTarif = planEntrada.getCodPlanTarif();
				 logger.debug("_AVC_ planEntrada.getCodPlanTarif())");
			}else{
              	 codPlanTarif = planEntrada.getCodigoPlanTarifario(); 
  				  logger.debug("_AVC_ planEntrada.getCodigoPlanTarifario()");
			}
			logger.debug("Consulta por codPlanTarif: [" + codPlanTarif + "]");
			
			// FIN INC-79469; COL; 12-03-2009; AVC

			cstmt.setString(1, codPlanTarif);
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR); 		// SV_tipplantarif
			//-- control error
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cstmt.execute();
			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento= cstmt.getInt(5);
			logger.debug("msgError[" + msgError + "]");

			if (codError != 0) {
				logger.error("Ocurrió un error al recuperar la Categoria del Plan Tarifario");
				throw new ProductOfferingException(
						"Ocurrió un error al recuperar la Categoria del Plan Tarifario", String
						.valueOf(codError), numEvento, msgError);
			}else
				resultado.setCodigoCategoria(cstmt.getString(2));


			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			logger.error("Ocurrió un error al recuperar la Categoria del Plan Tarifario",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
			if (logger.isDebugEnabled()) 
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}

		logger.debug("Fin:PlanTarifarioDAO:getCategoriaPlanTarifario()");

		return resultado;
	}//fin getCategoriaPlanTarifario


	/**
	 * Obtiene Codigo Concepto Facturable del descuento manual 
	 * @param entrada
	 * @return resultado
	 * @throws ProductOfferingException
	 */
	public DescuentoDTO getCodigoDescuentoManual(ParametrosDescuentoDTO entrada) throws ProductOfferingException{

		logger.debug("Inicio:getCodigoDescuentoManual()");

		DescuentoDTO resultado = new DescuentoDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		try {
			String call = getSQLDatosPlanTarifario("VE_servicios_venta_PG","VE_consulta_cod_desc_manual_PR",6);
			logger.debug("sql[" + call + "]");
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());

			cstmt = conn.prepareCall(call);

			cstmt.setString(1,entrada.getCodigoConcepto());
			cstmt.setString(2,entrada.getTipoConcepto());
			cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
			//-- control error
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

			cstmt.execute();

			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);

			if (codError == 0) 
				resultado.setCodigoConcepto(String.valueOf(cstmt.getInt(3)));

			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			logger.error("Ocurrió un error al recuperar el código de descuento manual",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new ProductOfferingException(
					"Ocurrió un error al recuperar el código de descuento manual",e);
		} finally {
			if (logger.isDebugEnabled()) 
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:getCodigoDescuentoManual()");

		return resultado;
	}//fin getCodigoDescuentoManual	

	/**
	 * Obtiene limite de consumo
	 * @param planEntrada
	 * @return resultado
	 * @throws ProductDomainException
	 */
	public PlanTarifarioDTO getLimiteConsumo(PlanTarifarioDTO entrada) throws ProductOfferingException{
		
		logger.debug("Inicio:getLimiteConsumo()");
		
		PlanTarifarioDTO resultado = new PlanTarifarioDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		try {
			String call = getSQLDatosPlanTarifario("VE_alta_cliente_PG","VE_getLimiteConsumo_PR",13);
			logger.debug("sql[" + call + "]");
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());

			cstmt = conn.prepareCall(call);

			cstmt.setString(1,entrada.getCodPlanTarif());
			cstmt.setString(2,entrada.getFormatoFecha1());
			cstmt.setString(3,entrada.getFormatoFecha2());

			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR); 	// codigo limite consumo
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR); 	// descripcion
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC); 	// importe limite
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR); 	// indicador unidades
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR); 	// indicador default
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR); 	// fecha desde
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);	// fecha hasta

			//-- control error
			cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(13, java.sql.Types.NUMERIC);

			logger.debug("Inicio:getLimiteConsumo:execute");
			cstmt.execute();
			logger.debug("Fin:getLimiteConsumo:execute");

			codError = cstmt.getInt(11);
			msgError = cstmt.getString(12);
			numEvento = cstmt.getInt(13);

			resultado.setCodPlanTarif(entrada.getCodPlanTarif());
			resultado.setLimiteConsumo(cstmt.getString(4));
			resultado.setDescripcionLimiteConsumo(cstmt.getString(5));
			resultado.setImporteLimite(cstmt.getLong(6));
			resultado.setIndicadorUnidades(cstmt.getString(7));
			resultado.setIndicadorDefault(cstmt.getString(8));
			resultado.setFechaDesde(cstmt.getString(9));
			resultado.setFechaHasta(cstmt.getString(10));
			
			

			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			logger.error("Ocurrió un error al recuperar Plan Tarifario",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
			if (logger.isDebugEnabled()) 
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:getLimiteConsumo()");
		return resultado;
	}//fin getLimiteConsumo


}//fin class PlanTarifarioDAO
