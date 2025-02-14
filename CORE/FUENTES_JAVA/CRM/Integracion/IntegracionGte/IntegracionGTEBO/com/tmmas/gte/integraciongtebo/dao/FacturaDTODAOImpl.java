/**
* Generated file - You can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/

package com.tmmas.gte.integraciongtebo.dao;
import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.gte.integraciongtebo.helper.Global;
import com.tmmas.cl.framework20.util.ServiceLocator;

public class FacturaDTODAOImpl extends com.tmmas.cl.framework.base.ConnectionDAO implements FacturaDTODAO{
	private CompositeConfiguration config;
	private static Logger logger = Logger.getLogger(FacturaDTODAOImpl.class);
	private Global global = Global.getInstance();
	private ServiceLocator  serviceLocator = ServiceLocator.getInstance();

	public FacturaDTODAOImpl() {
		config = UtilProperty.getConfiguration("IntegracionGte.properties", "com/tmmas/gte/integraciongtebo/properties/IntegracionGTEBO.properties");
	}

	/**
	* Entrega Datos de Conceptos de Factura
	*/
	public com.tmmas.gte.integraciongtecommon.dto.LstConceptoFacturaDTO consultarConceptosFactura(com.tmmas.gte.integraciongtecommon.dto.ConsultarConscFactDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("consultarConceptosFactura:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.LstConceptoFacturaDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.LstConceptoFacturaDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call GE_INTEGRACION_PG.ge_cons_conc_factura_pr(?,?,?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setLong(1,inParam0.getCodCliente());
			logger.debug("codCliente[" + inParam0.getCodCliente() + "]");

			cstmt.setLong(2,inParam0.getCodTipDocum());
			logger.debug("codTipDocum[" + inParam0.getCodTipDocum() + "]");

			cstmt.setLong(3,inParam0.getNumFolio());
			logger.debug("numFolio[" + inParam0.getNumFolio() + "]");

			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam2 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(4,oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7,java.sql.Types.NUMERIC);

			logger.info("execute():antes");
			cstmt.execute();
			logger.info("execute():despues");

			logger.info("setea respuesta de stored procedure...");
			outParam2.setCodigoError(cstmt.getInt(5));
			logger.debug("codigoError[" + outParam2.getCodigoError() + "]");

			outParam2.setMensajeError(cstmt.getString(6));
			logger.debug("mensajeError[" + outParam2.getMensajeError() + "]");

			outParam2.setNumeroEvento(cstmt.getLong(7));
			logger.debug("numeroEvento[" + outParam2.getNumeroEvento() + "]");

			logger.info("verifica condicion de error del stored procedure...");
			if(outParam2.getCodigoError() != 0 ) {
				logger.info("Codigo de error != 0");
				logger.info("outParam0"+outParam0);
				outParam0.setRespuesta(outParam2);
				return outParam0;
			}
			logger.info("seteando clase de  repuesta a la clase padre...");
			outParam0.setRespuesta(outParam2);

			logger.info("Recuperando cursor..");
			java.sql.ResultSet rs = (java.sql.ResultSet) cstmt.getObject(4);
			java.util.List lista4 = new java.util.ArrayList();

			logger.info("Recuperando cursor4:antes");
			while (rs.next()) {
				com.tmmas.gte.integraciongtecommon.dto.ConceptoFacturasDTO dto4 = new com.tmmas.gte.integraciongtecommon.dto.ConceptoFacturasDTO();

				dto4.setCodConcepto(rs.getLong("cod_concepto"));
				logger.debug("codConcepto[" + dto4.getCodConcepto() + "]");

				dto4.setDesConcepto(rs.getString("des_concepto"));
				logger.debug("desConcepto[" + dto4.getDesConcepto() + "]");

				dto4.setImporteDebe(rs.getDouble("importe_debe"));
				logger.debug("importeDebe[" + dto4.getImporteDebe() + "]");

				dto4.setImporteHaber(rs.getDouble("importe_haber"));
				logger.debug("importeHaber[" + dto4.getImporteHaber() + "]");

				lista4.add(dto4);
			}
			logger.info("Recuperando cursor4:despues");
			rs.close();
			logger.info("Seteando respuesta de cursor4 en clase de salida....");
			outParam0.setListadoConcFactura((com.tmmas.gte.integraciongtecommon.dto.ConceptoFacturasDTO[])
						com.tmmas.cl.framework.util.ArrayUtl.copiaArregloTipoEspecifico(lista4.toArray(),
												com.tmmas.gte.integraciongtecommon.dto.ConceptoFacturasDTO.class));

		}
		catch (java.sql.SQLException e) {
			logger.error("SQLException", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("SQLException", e);
		}
		catch (java.lang.Exception e) {
			logger.error("Exception", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("Exception", e);
		}
		finally {
			try {
				if (cstmt != null) {
					cstmt.close();
					cstmt = null;
				}
				if (conn != null) {
					conn.close();
					conn = null;
				}
			}
			catch (java.sql.SQLException e) {
				logger.error("SQLException", e);
				cstmt = null;
				conn = null;
			}
		}

		logger.info("consultarConceptosFactura:end()");
		return outParam0;
	}

	/**
	* Ingresa como parametros el codigo del cliente, numero de iteraciones (devuelve una lista con facturas pagas e inpagas)
	*/
	public com.tmmas.gte.integraciongtecommon.dto.FacturaResponseDTO consultarFacturas(com.tmmas.gte.integraciongtecommon.dto.FacturaInDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("consultarFacturas:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.FacturaResponseDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.FacturaResponseDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call GE_INTEGRACION_PG.GE_CONS_FACT_CLIE_PR(?,?,?,?,?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setLong(1,inParam0.getCodCliente());
			logger.debug("codCliente[" + inParam0.getCodCliente() + "]");

			cstmt.setInt(2,inParam0.getCantidadIteracion());
			logger.debug("cantidadIteracion[" + inParam0.getCantidadIteracion() + "]");

			cstmt.setInt(3,inParam0.getOpcion());
			logger.debug("opcion[" + inParam0.getOpcion() + "]");

			cstmt.setString(4,null);
			cstmt.setString(5,null);
	
			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam2 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(6,oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(7,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9,java.sql.Types.NUMERIC);

			logger.info("execute():antes");
			cstmt.execute();
			logger.info("execute():despues");

			logger.info("setea respuesta de stored procedure...");
			outParam2.setCodigoError(cstmt.getInt(7));
			logger.debug("codigoError[" + outParam2.getCodigoError() + "]");

			outParam2.setMensajeError(cstmt.getString(8));
			logger.debug("mensajeError[" + outParam2.getMensajeError() + "]");

			outParam2.setNumeroEvento(cstmt.getLong(9));
			logger.debug("numeroEvento[" + outParam2.getNumeroEvento() + "]");

			logger.info("verifica condicion de error del stored procedure...");
			if(outParam2.getCodigoError() != 0 ) {
				logger.info("Codigo de error != 0");
				outParam0.setRespuesta(outParam2);
				return outParam0;
			}
			logger.info("seteando clase de  repuesta a la clase padre...");
			outParam0.setRespuesta(outParam2);

			logger.info("Recuperando cursor..");
			java.sql.ResultSet rs = (java.sql.ResultSet) cstmt.getObject(6);
			java.util.List lista3 = new java.util.ArrayList();

			logger.info("Recuperando cursor3:antes");
			while (rs.next()) {
				com.tmmas.gte.integraciongtecommon.dto.FacturaDTO dto3 = new com.tmmas.gte.integraciongtecommon.dto.FacturaDTO();

				dto3.setCodCliente(rs.getLong("cod_cliente"));
				logger.debug("codCliente[" + dto3.getCodCliente() + "]");

				dto3.setNumProceso(rs.getLong("num_proceso"));
				logger.debug("numProceso[" + dto3.getNumProceso() + "]");

				dto3.setImpSaldoAnt(rs.getDouble("imp_saldoant"));
				logger.debug("impSaldoAnt[" + dto3.getImpSaldoAnt() + "]");

				dto3.setNumFolio(rs.getLong("num_folio"));
				logger.debug("numFolio[" + dto3.getNumFolio() + "]");

				dto3.setEstado(rs.getString("estado"));
				logger.debug("estado[" + dto3.getEstado() + "]");

				dto3.setCodTipDocum(rs.getLong("cod_tipdocum"));
				logger.debug("codTipDocum[" + dto3.getCodTipDocum() + "]");

				dto3.setDesTipDocum(rs.getString("des_tipdocum"));
				logger.debug("desTipDocum[" + dto3.getDesTipDocum() + "]");

				dto3.setFecEmision(new java.util.Date(rs.getDate("fec_emision").getTime()));
				logger.debug("fecEmision[" + dto3.getFecEmision() + "]");

				dto3.setFecVencimie(new java.util.Date(rs.getDate("fec_vencimie").getTime()));
				logger.debug("fecVencimie[" + dto3.getFecVencimie() + "]");

				dto3.setTotalFactura(rs.getDouble("tot_factura"));
				logger.debug("totalFactura[" + dto3.getTotalFactura() + "]");

				dto3.setTotalPagar(rs.getDouble("tot_pagar"));
				logger.debug("totalPagar[" + dto3.getTotalPagar() + "]");

				dto3.setAcumIva(rs.getDouble("acum_iva"));
				logger.debug("acumIva[" + dto3.getAcumIva() + "]");

				dto3.setTotDescuento(rs.getDouble("tot_descuento"));
				logger.debug("totDescuento[" + dto3.getTotDescuento() + "]");

				dto3.setTotCargosMe(rs.getDouble("tot_cargosme"));
				logger.debug("totCargosMe[" + dto3.getTotCargosMe() + "]");

				dto3.setFecDesdeLlam(new java.util.Date(rs.getDate("fec_desdellam").getTime()));
				logger.debug("fecDesdeLlam[" + dto3.getFecDesdeLlam() + "]");

				dto3.setFecHastaLlam(new java.util.Date(rs.getDate("fec_hastallam").getTime()));
				logger.debug("fecHastaLlam[" + dto3.getFecHastaLlam() + "]");

				dto3.setCodCiclo(rs.getLong("cod_ciclfact"));
				logger.debug("codCiclo[" + dto3.getCodCiclo() + "]");
				
				if(rs.getDate("fec_cancelacion")==null){
					dto3.setFecCancelacion(null);
				}else{
					dto3.setFecCancelacion(new java.util.Date(rs.getDate("fec_cancelacion").getTime()));
				}
				logger.debug("fecCancelacion[" + dto3.getFecCancelacion() + "]");

				lista3.add(dto3);
			}
			logger.info("Recuperando cursor3:despues");
			rs.close();
			logger.info("Seteando respuesta de cursor3 en clase de salida....");
			outParam0.setLstListadoFacturas((com.tmmas.gte.integraciongtecommon.dto.FacturaDTO[])
						com.tmmas.cl.framework.util.ArrayUtl.copiaArregloTipoEspecifico(lista3.toArray(),
												com.tmmas.gte.integraciongtecommon.dto.FacturaDTO.class));

		}
		catch (java.sql.SQLException e) {
			logger.error("SQLException", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("SQLException", e);
		}
		catch (java.lang.Exception e) {
			logger.error("Exception", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("Exception", e);
		}
		finally {
			try {
				if (cstmt != null) {
					cstmt.close();
					cstmt = null;
				}
				if (conn != null) {
					conn.close();
					conn = null;
				}
			}
			catch (java.sql.SQLException e) {
				logger.error("SQLException", e);
				cstmt = null;
				conn = null;
			}
		}

		logger.info("consultarFacturas:end()");
		return outParam0;
	}

	/**
	* Ingresa como parametros el codigo del cliente, numero de iteraciones (devuelve una lista con facturas impagas)
	*/
	public com.tmmas.gte.integraciongtecommon.dto.FacturaResponseDTO consultarFacturasImpagas(com.tmmas.gte.integraciongtecommon.dto.FacturaInDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("consultarFacturasImpagas:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.FacturaResponseDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.FacturaResponseDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call GE_INTEGRACION_PG.GE_CONS_FACT_CLIE_PR(?,?,?,?,?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setLong(1,inParam0.getCodCliente());
			logger.debug("codCliente[" + inParam0.getCodCliente() + "]");

			cstmt.setInt(2,inParam0.getCantidadIteracion());
			logger.debug("cantidadIteracion[" + inParam0.getCantidadIteracion() + "]");
			
			cstmt.setInt(3,inParam0.getOpcion());
			logger.debug("opcion[" + inParam0.getOpcion() + "]");
			
			cstmt.setString(4,null);
			cstmt.setString(5,null);


			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam2 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(6,oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(7,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9,java.sql.Types.NUMERIC);

			logger.info("execute():antes");
			cstmt.execute();
			logger.info("execute():despues");

			logger.info("setea respuesta de stored procedure...");
			outParam2.setCodigoError(cstmt.getInt(7));
			logger.debug("codigoError[" + outParam2.getCodigoError() + "]");

			outParam2.setMensajeError(cstmt.getString(8));
			logger.debug("mensajeError[" + outParam2.getMensajeError() + "]");

			outParam2.setNumeroEvento(cstmt.getLong(9));
			logger.debug("numeroEvento[" + outParam2.getNumeroEvento() + "]");

			logger.info("verifica condicion de error del stored procedure...");
			if(outParam2.getCodigoError() != 0 ) {
				logger.info("Codigo de error != 0");
				outParam0.setRespuesta(outParam2);
				return outParam0;
			}
			logger.info("seteando clase de  repuesta a la clase padre...");
			outParam0.setRespuesta(outParam2);

			logger.info("Recuperando cursor..");
			java.sql.ResultSet rs = (java.sql.ResultSet) cstmt.getObject(6);
			java.util.List lista3 = new java.util.ArrayList();

			logger.info("Recuperando cursor3:antes");
			while (rs.next()) {
				com.tmmas.gte.integraciongtecommon.dto.FacturaDTO dto3 = new com.tmmas.gte.integraciongtecommon.dto.FacturaDTO();

				dto3.setCodCliente(rs.getLong("cod_cliente"));
				logger.debug("codCliente[" + dto3.getCodCliente() + "]");

				dto3.setNumProceso(rs.getLong("num_proceso"));
				logger.debug("numProceso[" + dto3.getNumProceso() + "]");

				dto3.setImpSaldoAnt(rs.getDouble("imp_saldoant"));
				logger.debug("impSaldoAnt[" + dto3.getImpSaldoAnt() + "]");

				dto3.setNumFolio(rs.getLong("num_folio"));
				logger.debug("numFolio[" + dto3.getNumFolio() + "]");

				dto3.setEstado(rs.getString("estado"));
				logger.debug("estado[" + dto3.getEstado() + "]");

				dto3.setCodTipDocum(rs.getLong("cod_tipdocum"));
				logger.debug("codTipDocum[" + dto3.getCodTipDocum() + "]");

				dto3.setDesTipDocum(rs.getString("des_tipdocum"));
				logger.debug("desTipDocum[" + dto3.getDesTipDocum() + "]");

				dto3.setFecEmision(new java.util.Date(rs.getDate("fec_emision").getTime()));
				logger.debug("fecEmision[" + dto3.getFecEmision() + "]");

				dto3.setFecVencimie(new java.util.Date(rs.getDate("fec_vencimie").getTime()));
				logger.debug("fecVencimie[" + dto3.getFecVencimie() + "]");

				dto3.setTotalFactura(rs.getDouble("tot_factura"));
				logger.debug("totalFactura[" + dto3.getTotalFactura() + "]");

				dto3.setTotalPagar(rs.getDouble("tot_pagar"));
				logger.debug("totalPagar[" + dto3.getTotalPagar() + "]");

				dto3.setAcumIva(rs.getDouble("acum_iva"));
				logger.debug("acumIva[" + dto3.getAcumIva() + "]");

				dto3.setTotDescuento(rs.getDouble("tot_descuento"));
				logger.debug("totDescuento[" + dto3.getTotDescuento() + "]");

				dto3.setTotCargosMe(rs.getDouble("tot_cargosme"));
				logger.debug("totCargosMe[" + dto3.getTotCargosMe() + "]");

				dto3.setFecDesdeLlam(new java.util.Date(rs.getDate("fec_desdellam").getTime()));
				logger.debug("fecDesdeLlam[" + dto3.getFecDesdeLlam() + "]");

				dto3.setFecHastaLlam(new java.util.Date(rs.getDate("fec_hastallam").getTime()));
				logger.debug("fecHastaLlam[" + dto3.getFecHastaLlam() + "]");

				dto3.setCodCiclo(rs.getLong("cod_ciclfact"));
				logger.debug("codCiclo[" + dto3.getCodCiclo() + "]");

				lista3.add(dto3);
			}
			logger.info("Recuperando cursor3:despues");
			rs.close();
			logger.info("Seteando respuesta de cursor3 en clase de salida....");
			outParam0.setLstListadoFacturas((com.tmmas.gte.integraciongtecommon.dto.FacturaDTO[])
						com.tmmas.cl.framework.util.ArrayUtl.copiaArregloTipoEspecifico(lista3.toArray(),
												com.tmmas.gte.integraciongtecommon.dto.FacturaDTO.class));

		}
		catch (java.sql.SQLException e) {
			logger.error("SQLException", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("SQLException", e);
		}
		catch (java.lang.Exception e) {
			logger.error("Exception", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("Exception", e);
		}
		finally {
			try {
				if (cstmt != null) {
					cstmt.close();
					cstmt = null;
				}
				if (conn != null) {
					conn.close();
					conn = null;
				}
			}
			catch (java.sql.SQLException e) {
				logger.error("SQLException", e);
				cstmt = null;
				conn = null;
			}
		}

		logger.info("consultarFacturasImpagas:end()");
		return outParam0;
	}

	/**
	* Consulta Link de Factura para un proceso ingresado
	*/
	public com.tmmas.gte.integraciongtecommon.dto.ConsLinkFacturaResponseDTO consultarLinkFactura(com.tmmas.gte.integraciongtecommon.dto.ConsLinkFacturaDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("consultarLinkFactura:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.ConsLinkFacturaResponseDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.ConsLinkFacturaResponseDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call GE_INTEGRACION_PG.ge_cons_link_fact_pr(?,?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setLong(1,inParam0.getNumProceso());
			logger.debug("numProceso[" + inParam0.getNumProceso() + "]");

			cstmt.setLong(2,inParam0.getCodCliente());
			logger.debug("codCliente[" + inParam0.getCodCliente() + "]");

			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam1 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(3,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6,java.sql.Types.NUMERIC);

			logger.info("execute():antes");
			cstmt.execute();
			logger.info("execute():despues");

			logger.info("setea respuesta de stored procedure...");
			outParam1.setCodigoError(cstmt.getInt(4));
			logger.debug("codigoError[" + outParam1.getCodigoError() + "]");

			outParam1.setMensajeError(cstmt.getString(5));
			logger.debug("mensajeError[" + outParam1.getMensajeError() + "]");

			outParam1.setNumeroEvento(cstmt.getLong(6));
			logger.debug("numeroEvento[" + outParam1.getNumeroEvento() + "]");

			logger.info("verifica condicion de error del stored procedure...");
			if(outParam1.getCodigoError() != 0 ) {
				logger.info("Codigo de error != 0");
				outParam0.setRespuesta(outParam1);
				return outParam0;
			}
			logger.info("seteando clase de  repuesta a la clase padre...");
			outParam0.setRespuesta(outParam1);

			outParam0.setRutaFactura(cstmt.getString(3));
			logger.debug("rutaFactura[" + outParam0.getRutaFactura() + "]");

		}
		catch (java.sql.SQLException e) {
			logger.error("SQLException", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("SQLException", e);
		}
		catch (java.lang.Exception e) {
			logger.error("Exception", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("Exception", e);
		}
		finally {
			try {
				if (cstmt != null) {
					cstmt.close();
					cstmt = null;
				}
				if (conn != null) {
					conn.close();
					conn = null;
				}
			}
			catch (java.sql.SQLException e) {
				logger.error("SQLException", e);
				cstmt = null;
				conn = null;
			}
		}

		logger.info("consultarLinkFactura:end()");
		return outParam0;
	}

	/**
	* Ingresa como parametros el codigo del cliente, y devuele una lista de 12 FacturaDTO pero solo con datos en el atributo fecHastallam
	*/
	public com.tmmas.gte.integraciongtecommon.dto.FacturaResponseDTO consultarFechasReporteConsumo(com.tmmas.gte.integraciongtecommon.dto.FacturaInDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("consultarFechasReporteConsumo:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.FacturaResponseDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.FacturaResponseDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call GE_INTEGRACION_PG.GE_CONS_FECH_REP_CON_PR(?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setLong(1,inParam0.getCodCliente());
			logger.debug("codCliente[" + inParam0.getCodCliente() + "]");

			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam2 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(2,oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);

			logger.info("execute():antes");
			cstmt.execute();
			logger.info("execute():despues");

			logger.info("setea respuesta de stored procedure...");
			outParam2.setCodigoError(cstmt.getInt(3));
			logger.debug("codigoError[" + outParam2.getCodigoError() + "]");

			outParam2.setMensajeError(cstmt.getString(4));
			logger.debug("mensajeError[" + outParam2.getMensajeError() + "]");

			outParam2.setNumeroEvento(cstmt.getLong(5));
			logger.debug("numeroEvento[" + outParam2.getNumeroEvento() + "]");

			logger.info("verifica condicion de error del stored procedure...");
			if(outParam2.getCodigoError() != 0 ) {
				logger.info("Codigo de error != 0");
				outParam0.setRespuesta(outParam2);
				return outParam0;
			}
			logger.info("seteando clase de  repuesta a la clase padre...");
			outParam0.setRespuesta(outParam2);

			logger.info("Recuperando cursor..");
			java.sql.ResultSet rs = (java.sql.ResultSet) cstmt.getObject(2);
			java.util.List lista2 = new java.util.ArrayList();

			logger.info("Recuperando cursor2:antes");
			while (rs.next()) {
				com.tmmas.gte.integraciongtecommon.dto.FacturaDTO dto2 = new com.tmmas.gte.integraciongtecommon.dto.FacturaDTO();

				dto2.setFecHastaLlam(new java.util.Date(rs.getDate("fec_hastallam").getTime()));
				logger.debug("fecHastallam[" + dto2.getFecDesdeLlam() + "]");

				lista2.add(dto2);
			}
			logger.info("Recuperando cursor2:despues");
			rs.close();
			logger.info("Seteando respuesta de cursor2 en clase de salida....");
			outParam0.setLstListadoFacturas((com.tmmas.gte.integraciongtecommon.dto.FacturaDTO[])
						com.tmmas.cl.framework.util.ArrayUtl.copiaArregloTipoEspecifico(lista2.toArray(),
												com.tmmas.gte.integraciongtecommon.dto.FacturaDTO.class));

		}
		catch (java.sql.SQLException e) {
			logger.error("SQLException", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("SQLException", e);
		}
		catch (java.lang.Exception e) {
			logger.error("Exception", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("Exception", e);
		}
		finally {
			try {
				if (cstmt != null) {
					cstmt.close();
					cstmt = null;
				}
				if (conn != null) {
					conn.close();
					conn = null;
				}
			}
			catch (java.sql.SQLException e) {
				logger.error("SQLException", e);
				cstmt = null;
				conn = null;
			}
		}

		logger.info("consultarFechasReporteConsumo:end()");
		return outParam0;
	}

	/**
	* Ingresa como parametros el codigo del cliente, numero de iteraciones (devuelve una lista con facturas pagadas)
	*/
	public com.tmmas.gte.integraciongtecommon.dto.FacturaResponseDTO consultarFacturasPagadas(com.tmmas.gte.integraciongtecommon.dto.FacturaInDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("consultarFacturasPagadas:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.FacturaResponseDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.FacturaResponseDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call GE_INTEGRACION_PG.GE_CONS_FACT_CLIE_PR(?,?,?,?,?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setLong(1,inParam0.getCodCliente());
			logger.debug("codCliente[" + inParam0.getCodCliente() + "]");

			cstmt.setInt(2,inParam0.getCantidadIteracion());
			logger.debug("cantidadIteracion[" + inParam0.getCantidadIteracion() + "]");

			cstmt.setInt(3,inParam0.getOpcion());
			logger.debug("opcion[" + inParam0.getOpcion() + "]");
			
			cstmt.setString(4,null);
			cstmt.setString(5,null);

			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam2 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(6,oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(7,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9,java.sql.Types.NUMERIC);

			logger.info("execute():antes");
			cstmt.execute();
			logger.info("execute():despues");

			logger.info("setea respuesta de stored procedure...");
			outParam2.setCodigoError(cstmt.getInt(7));
			logger.debug("codigoError[" + outParam2.getCodigoError() + "]");

			outParam2.setMensajeError(cstmt.getString(8));
			logger.debug("mensajeError[" + outParam2.getMensajeError() + "]");

			outParam2.setNumeroEvento(cstmt.getLong(9));
			logger.debug("numeroEvento[" + outParam2.getNumeroEvento() + "]");

			logger.info("verifica condicion de error del stored procedure...");
			if(outParam2.getCodigoError() != 0 ) {
				logger.info("Codigo de error != 0");
				outParam0.setRespuesta(outParam2);
				return outParam0;
			}
			logger.info("seteando clase de  repuesta a la clase padre...");
			outParam0.setRespuesta(outParam2);

			logger.info("Recuperando cursor..");
			java.sql.ResultSet rs = (java.sql.ResultSet) cstmt.getObject(6);
			java.util.List lista4 = new java.util.ArrayList();

			logger.info("Recuperando cursor4:antes");
			while (rs.next()) {
				com.tmmas.gte.integraciongtecommon.dto.FacturaDTO dto4 = new com.tmmas.gte.integraciongtecommon.dto.FacturaDTO();

				dto4.setCodCliente(rs.getLong("cod_cliente"));
				logger.debug("codCliente[" + dto4.getCodCliente() + "]");

				dto4.setNumProceso(rs.getLong("num_proceso"));
				logger.debug("numProceso[" + dto4.getNumProceso() + "]");

				dto4.setImpSaldoAnt(rs.getDouble("imp_saldoant"));
				logger.debug("impSaldoAnt[" + dto4.getImpSaldoAnt() + "]");

				dto4.setNumFolio(rs.getLong("num_folio"));
				logger.debug("numFolio[" + dto4.getNumFolio() + "]");

				dto4.setEstado(rs.getString("estado"));
				logger.debug("estado[" + dto4.getEstado() + "]");

				dto4.setCodTipDocum(rs.getLong("cod_tipdocum"));
				logger.debug("codTipDocum[" + dto4.getCodTipDocum() + "]");

				dto4.setDesTipDocum(rs.getString("des_tipdocum"));
				logger.debug("desTipDocum[" + dto4.getDesTipDocum() + "]");

				dto4.setFecEmision(new java.util.Date(rs.getDate("fec_emision").getTime()));
				logger.debug("fecEmision[" + dto4.getFecEmision() + "]");

				dto4.setFecVencimie(new java.util.Date(rs.getDate("fec_vencimie").getTime()));
				logger.debug("fecVencimie[" + dto4.getFecVencimie() + "]");

				dto4.setTotalFactura(rs.getDouble("tot_factura"));
				logger.debug("totalFactura[" + dto4.getTotalFactura() + "]");

				dto4.setTotalPagar(rs.getDouble("tot_pagar"));
				logger.debug("totalPagar[" + dto4.getTotalPagar() + "]");

				dto4.setAcumIva(rs.getDouble("acum_iva"));
				logger.debug("acumIva[" + dto4.getAcumIva() + "]");

				dto4.setTotDescuento(rs.getDouble("tot_descuento"));
				logger.debug("totDescuento[" + dto4.getTotDescuento() + "]");

				dto4.setTotCargosMe(rs.getDouble("tot_cargosme"));
				logger.debug("totCargosMe[" + dto4.getTotCargosMe() + "]");

				dto4.setFecDesdeLlam(new java.util.Date(rs.getDate("fec_desdellam").getTime()));
				logger.debug("fecDesdeLlam[" + dto4.getFecDesdeLlam() + "]");

				dto4.setFecHastaLlam(new java.util.Date(rs.getDate("fec_hastallam").getTime()));
				logger.debug("fecHastaLlam[" + dto4.getFecHastaLlam() + "]");

				dto4.setCodCiclo(rs.getLong("cod_ciclfact"));
				logger.debug("codCiclo[" + dto4.getCodCiclo() + "]");

				if(rs.getDate("fec_cancelacion")==null){
					dto4.setFecCancelacion(null);
				}else{
					dto4.setFecCancelacion(new java.util.Date(rs.getDate("fec_cancelacion").getTime()));
				}
				logger.debug("fecCancelacion[" + dto4.getFecCancelacion() + "]");

				lista4.add(dto4);
			}
			logger.info("Recuperando cursor4:despues");
			rs.close();
			logger.info("Seteando respuesta de cursor4 en clase de salida....");
			outParam0.setLstListadoFacturas((com.tmmas.gte.integraciongtecommon.dto.FacturaDTO[])
						com.tmmas.cl.framework.util.ArrayUtl.copiaArregloTipoEspecifico(lista4.toArray(),
												com.tmmas.gte.integraciongtecommon.dto.FacturaDTO.class));

		}
		catch (java.sql.SQLException e) {
			logger.error("SQLException", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("SQLException", e);
		}
		catch (java.lang.Exception e) {
			logger.error("Exception", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("Exception", e);
		}
		finally {
			try {
				if (cstmt != null) {
					cstmt.close();
					cstmt = null;
				}
				if (conn != null) {
					conn.close();
					conn = null;
				}
			}
			catch (java.sql.SQLException e) {
				logger.error("SQLException", e);
				cstmt = null;
				conn = null;
			}
		}

		logger.info("consultarFacturasPagadas:end()");
		return outParam0;
	}	
	
	/**
	* Retorna codCicloFacturacion a partir de un codCiclo pospago
	*/
	public com.tmmas.gte.integraciongtecommon.dto.ConsAbonadoPospagoDTO consultarCicloFact(com.tmmas.gte.integraciongtecommon.dto.ConsCicloFactDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("consultarCicloFact:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.ConsAbonadoPospagoDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.ConsAbonadoPospagoDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call GE_INTEGRACION_PG.ge_cons_ciclo_fact_pr(?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setLong(1,inParam0.getCodCiclo());
			logger.debug("codCiclo[" + inParam0.getCodCiclo() + "]");

			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam1 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(2,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);

			logger.info("execute():antes");
			cstmt.execute();
			logger.info("execute():despues");

			logger.info("setea respuesta de stored procedure...");
			outParam1.setCodigoError(cstmt.getInt(3));
			logger.debug("codigoError[" + outParam1.getCodigoError() + "]");

			outParam1.setMensajeError(cstmt.getString(4));
			logger.debug("mensajeError[" + outParam1.getMensajeError() + "]");

			outParam1.setNumeroEvento(cstmt.getLong(5));
			logger.debug("numeroEvento[" + outParam1.getNumeroEvento() + "]");

			logger.info("verifica condicion de error del stored procedure...");
			if(outParam1.getCodigoError() != 0 ) {
				logger.info("Codigo de error != 0");
				outParam0.setRespuesta(outParam1);
				return outParam0;
			}
			logger.info("seteando clase de  repuesta a la clase padre...");
			outParam0.setRespuesta(outParam1);

			outParam0.setCodCicloFact(cstmt.getLong(2));
			logger.debug("codCicloFact[" + outParam0.getCodCicloFact() + "]");

		}
		catch (java.sql.SQLException e) {
			logger.error("SQLException", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("SQLException", e);
		}
		catch (java.lang.Exception e) {
			logger.error("Exception", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("Exception", e);
		}
		finally {
			try {
				if (cstmt != null) {
					cstmt.close();
					cstmt = null;
				}
				if (conn != null) {
					conn.close();
					conn = null;
				}
			}
			catch (java.sql.SQLException e) {
				logger.error("SQLException", e);
				cstmt = null;
				conn = null;
			}
		}

		logger.info("consultarCicloFact:end()");
		return outParam0;
	}

	/**
	* Ingresa como parametros el codigo del cliente, numero de iteraciones, la opcion, fecha de inicio y de termino en formato (yyyymmdd)y devuelve yna lista con facturas 
	*/
	public com.tmmas.gte.integraciongtecommon.dto.FacturaResponseDTO consultarFacturasNoCicloCliente(com.tmmas.gte.integraciongtecommon.dto.FacturaInDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("consultarFacturasNoCicloCliente:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.FacturaResponseDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.FacturaResponseDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call GE_INTEGRACION_PG.GE_CONS_FACT_CLIE_PR(?,?,?,?,?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setLong(1,inParam0.getCodCliente());
			logger.debug("codCliente[" + inParam0.getCodCliente() + "]");

			cstmt.setInt(2,inParam0.getCantidadIteracion());
			logger.debug("cantidadIteracion[" + inParam0.getCantidadIteracion() + "]");

			cstmt.setInt(3,inParam0.getOpcion());
			logger.debug("opcion[" + inParam0.getOpcion() + "]");

			cstmt.setString(4,inParam0.getFechaDesde());
			logger.debug("fechaDesde[" + inParam0.getFechaDesde() + "]");

			cstmt.setString(5,inParam0.getFechaHasta());
			logger.debug("fechaHasta[" + inParam0.getFechaHasta() + "]");

			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam2 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(6,oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(7,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9,java.sql.Types.NUMERIC);

			logger.info("execute():antes");
			cstmt.execute();
			logger.info("execute():despues");

			logger.info("setea respuesta de stored procedure...");
			outParam2.setCodigoError(cstmt.getInt(7));
			logger.debug("codigoError[" + outParam2.getCodigoError() + "]");

			outParam2.setMensajeError(cstmt.getString(8));
			logger.debug("mensajeError[" + outParam2.getMensajeError() + "]");

			outParam2.setNumeroEvento(cstmt.getLong(9));
			logger.debug("numeroEvento[" + outParam2.getNumeroEvento() + "]");

			logger.info("verifica condicion de error del stored procedure...");
			if(outParam2.getCodigoError() != 0 ) {
				logger.info("Codigo de error != 0");
				outParam0.setRespuesta(outParam2);
				return outParam0;
			}
			logger.info("seteando clase de  repuesta a la clase padre...");
			outParam0.setRespuesta(outParam2);

			logger.info("Recuperando cursor..");
			java.sql.ResultSet rs = (java.sql.ResultSet) cstmt.getObject(6);
			java.util.List lista6 = new java.util.ArrayList();

			logger.info("Recuperando cursor6:antes");
			while (rs.next()) {
				com.tmmas.gte.integraciongtecommon.dto.FacturaDTO dto6 = new com.tmmas.gte.integraciongtecommon.dto.FacturaDTO();

				dto6.setCodCliente(rs.getLong("cod_cliente"));
				logger.debug("codCliente[" + dto6.getCodCliente() + "]");

				dto6.setNumProceso(rs.getLong("num_proceso"));
				logger.debug("numProceso[" + dto6.getNumProceso() + "]");

				dto6.setImpSaldoAnt(rs.getDouble("imp_saldoant"));
				logger.debug("impSaldoAnt[" + dto6.getImpSaldoAnt() + "]");

				dto6.setNumFolio(rs.getLong("num_folio"));
				logger.debug("numFolio[" + dto6.getNumFolio() + "]");

				dto6.setEstado(rs.getString("estado"));
				logger.debug("estado[" + dto6.getEstado() + "]");

				dto6.setCodTipDocum(rs.getLong("cod_tipdocum"));
				logger.debug("codTipDocum[" + dto6.getCodTipDocum() + "]");

				dto6.setDesTipDocum(rs.getString("des_tipdocum"));
				logger.debug("desTipDocum[" + dto6.getDesTipDocum() + "]");

				dto6.setFecEmision(new java.util.Date(rs.getDate("fec_emision").getTime()));
				logger.debug("fecEmision[" + dto6.getFecEmision() + "]");

				dto6.setFecVencimie(new java.util.Date(rs.getDate("fec_vencimie").getTime()));
				logger.debug("fecVencimie[" + dto6.getFecVencimie() + "]");

				dto6.setTotalFactura(rs.getDouble("tot_factura"));
				logger.debug("totalFactura[" + dto6.getTotalFactura() + "]");

				dto6.setTotalPagar(rs.getDouble("tot_pagar"));
				logger.debug("totalPagar[" + dto6.getTotalPagar() + "]");

				dto6.setAcumIva(rs.getDouble("acum_iva"));
				logger.debug("acumIva[" + dto6.getAcumIva() + "]");

				dto6.setTotDescuento(rs.getDouble("tot_descuento"));
				logger.debug("totDescuento[" + dto6.getTotDescuento() + "]");

				dto6.setTotCargosMe(rs.getDouble("tot_cargosme"));
				logger.debug("totCargosMe[" + dto6.getTotCargosMe() + "]");

				if(rs.getDate("fec_cancelacion")==null){
					dto6.setFecCancelacion(null);
				}else{
					dto6.setFecCancelacion(new java.util.Date(rs.getDate("fec_cancelacion").getTime()));
				}
				logger.debug("fecCancelacion[" + dto6.getFecCancelacion() + "]");

				lista6.add(dto6);
			}
			logger.info("Recuperando cursor6:despues");
			rs.close();
			logger.info("Seteando respuesta de cursor6 en clase de salida....");
			outParam0.setLstListadoFacturas((com.tmmas.gte.integraciongtecommon.dto.FacturaDTO[])
						com.tmmas.cl.framework.util.ArrayUtl.copiaArregloTipoEspecifico(lista6.toArray(),
												com.tmmas.gte.integraciongtecommon.dto.FacturaDTO.class));

		}
		catch (java.sql.SQLException e) {
			logger.error("SQLException", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("SQLException", e);
		}
		catch (java.lang.Exception e) {
			logger.error("Exception", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("Exception", e);
		}
		finally {
			try {
				if (cstmt != null) {
					cstmt.close();
					cstmt = null;
				}
				if (conn != null) {
					conn.close();
					conn = null;
				}
			}
			catch (java.sql.SQLException e) {
				logger.error("SQLException", e);
				cstmt = null;
				conn = null;
			}
		}

		logger.info("consultarFacturasNoCicloCliente:end()");
		return outParam0;
	}	
	
	/**
	* Obtiene la fecha de corte del ciclo de facturacion
	*/
	public com.tmmas.gte.integraciongtecommon.dto.MinutosConsumidosDTO obtenerFechaCorte(com.tmmas.gte.integraciongtecommon.dto.CodCicloFacturaDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("obtieneFechaCorte:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.MinutosConsumidosDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.MinutosConsumidosDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call GE_INTEGRACION_PG.ge_obtiene_fecha_corte_pr(?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setLong(1,inParam0.getCodCicloFactura());
			logger.debug("codCicloFactura[" + inParam0.getCodCicloFactura() + "]");

			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam1 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(2,java.sql.Types.DATE);
			cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);

			logger.info("execute():antes");
			cstmt.execute();
			logger.info("execute():despues");

			logger.info("setea respuesta de stored procedure...");
			outParam1.setCodigoError(cstmt.getInt(3));
			logger.debug("codigoError[" + outParam1.getCodigoError() + "]");

			outParam1.setMensajeError(cstmt.getString(4));
			logger.debug("mensajeError[" + outParam1.getMensajeError() + "]");

			outParam1.setNumeroEvento(cstmt.getLong(5));
			logger.debug("numeroEvento[" + outParam1.getNumeroEvento() + "]");

			logger.info("verifica condicion de error del stored procedure...");
			if(outParam1.getCodigoError() != 0 ) {
				logger.info("Codigo de error != 0");
				outParam0.setRespuesta(outParam1);
				return outParam0;
			}
			logger.info("seteando clase de  repuesta a la clase padre...");
			outParam0.setRespuesta(outParam1);

			outParam0.setCorteCiclo(new java.util.Date(cstmt.getDate(2).getTime()));
			logger.debug("corteCiclo[" + outParam0.getCorteCiclo() + "]");

		}
		catch (java.sql.SQLException e) {
			logger.error("SQLException", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("SQLException", e);
		}
		catch (java.lang.Exception e) {
			logger.error("Exception", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("Exception", e);
		}
		finally {
			try {
				if (cstmt != null) {
					cstmt.close();
					cstmt = null;
				}
				if (conn != null) {
					conn.close();
					conn = null;
				}
			}
			catch (java.sql.SQLException e) {
				logger.error("SQLException", e);
				cstmt = null;
				conn = null;
			}
		}

		logger.info("obtieneFechaCorte:end()");
		return outParam0;
	}	
	

	/**
	* Llama a la funcion FA_ObtenerImpuesto_FN
	*/
	public com.tmmas.gte.integraciongtecommon.dto.ImpuestoResponseDTO consultarImpuesto(com.tmmas.gte.integraciongtecommon.dto.FacturaDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		logger.info("consultarImpuesto:start()");
		java.sql.Connection conn = null;
		java.sql.CallableStatement cstmt = null;
		logger.info("declara parametro de salida...");
		com.tmmas.gte.integraciongtecommon.dto.ImpuestoResponseDTO outParam0 = new com.tmmas.gte.integraciongtecommon.dto.ImpuestoResponseDTO();

		try {
			conn = serviceLocator.getDataSource((global.getJndiForDataSource0())).getConnection();
		}catch (java.lang.Exception e) {
			logger.error(" No se pudo obtener una conexion", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("No se pudo obtener una conexion", e);
		}

		try {
			String call = "{call PV_CONSLLAMADA_PG.PV_IMPUESTO_PR(?,?,?,?,?,?)}";
			logger.info("call[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.info("armar parametros de entrada...");
			cstmt.setLong(1,inParam0.getCodCliente());
			logger.debug("codCliente[" + inParam0.getCodCliente() + "]");

			cstmt.setString(2,inParam0.getUsuario());
			logger.debug("usuario[" + inParam0.getUsuario() + "]");

			logger.info("declara parametros de salida...");
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam1 = new com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO();

			logger.info("armar parametros de salida...");
			cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6,java.sql.Types.NUMERIC);

			logger.info("execute():antes");
			cstmt.execute();
			logger.info("execute():despues");

			logger.info("setea respuesta de stored procedure...");
			outParam1.setCodigoError(cstmt.getInt(4));
			logger.debug("codigoError[" + outParam1.getCodigoError() + "]");

			outParam1.setMensajeError(cstmt.getString(5));
			logger.debug("mensajeError[" + outParam1.getMensajeError() + "]");

			outParam1.setNumeroEvento(cstmt.getLong(6));
			logger.debug("numeroEvento[" + outParam1.getNumeroEvento() + "]");

			logger.info("verifica condicion de error del stored procedure...");
			if(outParam1.getCodigoError() != 0 ) {
				logger.info("Codigo de error != 0");
				outParam0.setRespuesta(outParam1);
				return outParam0;
			}
			logger.info("seteando clase de  repuesta a la clase padre...");
			outParam0.setRespuesta(outParam1);

			outParam0.setImpuesto(cstmt.getDouble(3));
			logger.debug("impuesto[" + outParam0.getImpuesto() + "]");

		}
		catch (java.sql.SQLException e) {
			logger.error("SQLException", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("SQLException", e);
		}
		catch (java.lang.Exception e) {
			logger.error("Exception", e);
			throw new com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException("Exception", e);
		}
		finally {
			try {
				if (cstmt != null) {
					cstmt.close();
					cstmt = null;
				}
				if (conn != null) {
					conn.close();
					conn = null;
				}
			}
			catch (java.sql.SQLException e) {
				logger.error("SQLException", e);
				cstmt = null;
				conn = null;
			}
		}

		logger.info("consultarImpuesto:end()");
		return outParam0;
	}
	

}


