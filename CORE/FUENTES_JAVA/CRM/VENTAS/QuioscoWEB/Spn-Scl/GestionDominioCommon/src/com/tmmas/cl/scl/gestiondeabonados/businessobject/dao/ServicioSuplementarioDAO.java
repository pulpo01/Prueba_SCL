package com.tmmas.cl.scl.gestiondeabonados.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.AbonadoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.DescuentoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ExisteSSAbonadoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ParametrosDescuentoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.PrecioCargoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ReglaCompatibilidadSSDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ReglasSSuplementariosDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.SSuplementariosDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ServicioSuplementarioDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.WsAgregaEliminaSSInDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.helper.Global;

public class ServicioSuplementarioDAO extends ConnectionDAO{
	private static Category cat = Category.getInstance(ServicioSuplementarioDAO.class);
	Global global = Global.getInstance();

	private Connection getConection() 
	throws GeneralException
	{
		Connection conn = null;
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
		} catch (Exception e1) {
			conn = null;
			cat.error(" No se pudo obtener una conexión ", e1);
			throw new GeneralException("No se pudo obtener una conexión", e1);
		}

		return conn;
	}//fin getConection

	private String getSQLDatosServSupl(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
		for (int n = 1; n <= paramCount; n++) {
			sb.append("?");
			if (n < paramCount) sb.append(",");
		}
		return sb.append(")}").toString();
	}//fin getSQLDatosServSupl

	public void creaSSAbonado(ServicioSuplementarioDTO entrada)
	throws GeneralException{

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			cat.debug("Inicio:creaSSAbonado");

			//INI-01 (AL) String call = getSQLDatosServSupl("VE_serv_suplem_abo_PG","VE_ProcesoSSAbonado_PR",7);
			String call = getSQLDatosServSupl("VE_serv_suplem_abo_quiosco_PG","VE_ProcesoSSAbonado_PR",7);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			//-- PARAMETROS DE ENTRADA
			cstmt.setString(1,entrada.getNumeroAbonado());
			cstmt.setString(2,entrada.getCodigoPlan());
			cstmt.setString(3,entrada.getNumeroTerminal());
			cstmt.setString(4,entrada.getNomUsuario());

			//-- PARAMETROS DE SALIDA
			cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7,java.sql.Types.NUMERIC);

			cat.debug("Inicio:creaSSAbonado:execute");
			cstmt.execute();
			cat.debug("Fin:creaSSAbonado:execute");

			codError=cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento=cstmt.getInt(7);
			
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				cat.error("Ocurrió un error al insertar al crear servicios suplemetarios del abonado");
				if (cat.isDebugEnabled()) {
					cat.debug("Codigo de Error[" + codError + "]");
					cat.debug("Mensaje de Error[" + msgError + "]");
					cat.debug("Numero de Evento[" + numEvento + "]");
				}
				throw new GeneralException(
						"Ocurrió un error al insertar al crear servicios suplemetarios del abonado", String
						.valueOf(codError), numEvento, msgError);
			}

		} catch (GeneralException e) {
			cat.error("Ocurrió un error al insertar al crear servicios suplemetarios del abonado",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw(e);
		} catch (Exception e) {
			cat.error("Ocurrió un error al insertar al crear servicios suplemetarios del abonado",e);
			throw new GeneralException(
			"Ocurrió un error al insertar al crear servicios suplemetarios del abonado");
		} finally {
			if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:creaSSAbonado");

	}//fin creaSSAbonado

	public ServicioSuplementarioDTO[] getListaSSAbonado(ServicioSuplementarioDTO servicioSuplementario) 
	throws GeneralException{
		cat.debug("Inicio:getListaSSAbonado()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ServicioSuplementarioDTO[] resultado = null;
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();
		cat.debug("Coneccion obtenida OK");
		try {
			//INI-01 (AL) String call = getSQLDatosServSupl("VE_serv_suplem_abo_PG","VE_obtiene_SS_abonado_PR",5);
			String call = getSQLDatosServSupl("VE_serv_suplem_abo_quiosco_PG","VE_obtiene_SS_abonado_PR",5);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setString(1,servicioSuplementario.getNumeroAbonado());
			cstmt.registerOutParameter(2,OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getListaSSAbonado:Execute");
			cstmt.execute();
			cat.debug("Fin:getListaSSAbonado:Execute");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar SS del abonado");
				throw new GeneralException(
						"Ocurrió un error al recuperar SS del abonado", String
						.valueOf(codError), numEvento, msgError);

			}else{
				cat.debug("Recuperando SS del abonado");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(2);
				while (rs.next()) {
					ServicioSuplementarioDTO servicioSuplementarioDTO = new ServicioSuplementarioDTO();
					servicioSuplementarioDTO.setNumeroAbonado(servicioSuplementario.getNumeroAbonado());
					servicioSuplementarioDTO.setCodigoServicio(rs.getString(1));
					servicioSuplementarioDTO.setCodigoServSupl(rs.getString(2));
					servicioSuplementarioDTO.setCodigoNivel(rs.getString(3));
					servicioSuplementarioDTO.setCodigoConcepto(rs.getString(4));
					lista.add(servicioSuplementarioDTO);
				}
				rs.close();
				resultado =(ServicioSuplementarioDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
						lista.toArray(), ServicioSuplementarioDTO.class);

				cat.debug("Fin recuperacion de SS del abonado");
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			throw (e);		
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar SS del abonado",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al recuperar SS del abonado",e);
		} finally {
			if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:getListaSSAbonado()");

		return resultado;
	}//fin getListaSSAbonado

	public PrecioCargoDTO[] getCargoServSupl(ServicioSuplementarioDTO entrada) 
	throws GeneralException{
		cat.debug("Inicio:getCargoServSupl()");
		PrecioCargoDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();
		try {
			//INI-01 (AL) String call = getSQLDatosServSupl("VE_servicios_venta_PG","VE_precio_cargo_servsupl_PR",8);
			String call = getSQLDatosServSupl("VE_servicios_venta_quiosco_PG","VE_precio_cargo_servsupl_PR",8);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);

			//-- PARAMETROS DE ENTRADA
			cstmt.setString(1,entrada.getCodigoProducto());
			cstmt.setString(2,entrada.getCodigoServicio());
			cstmt.setString(3,entrada.getCodigoPlanServicio());
			cstmt.setString(4,entrada.getCodigoActuacion());

			//-- PARAMETROS DE SALIDA
			cstmt.registerOutParameter(5,OracleTypes.CURSOR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getCargoServSupl:Execute");
			cstmt.execute();
			cat.debug("Fin:getCargoServSupl:Execute");

			codError = cstmt.getInt(6);
			msgError = cstmt.getString(7);
			numEvento = cstmt.getInt(8);
			
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar cargo servicio suplementario");
				throw new GeneralException(
						"Ocurrió un error al recuperar cargo servicio suplementario", String
						.valueOf(codError), numEvento, msgError);

			}else{
				cat.debug("Recuperando cargo servicio suplementario");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(5);
				while (rs.next()) {
					PrecioCargoDTO precioDTO = new PrecioCargoDTO();

					precioDTO.setCodigoConcepto(rs.getString(1));
					precioDTO.setDescripcionConcepto(rs.getString(2));
					precioDTO.setMonto(rs.getFloat(3));
					precioDTO.setCodigoMoneda(rs.getString(4));
					precioDTO.setDescripcionMoneda(rs.getString(5));
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
					cat.debug("ENCONTRO PRECIO" + precioDTO.getCodigoConcepto());
				}
				rs.close();
				resultado =(PrecioCargoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
						lista.toArray(), PrecioCargoDTO.class);

				cat.debug("Fin recuperacion cargo servicio suplementario");
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			throw (e);		
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar cargo servicio suplementario",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al recuperar cargo servicio suplementario",e);
		} finally {
			if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:getCargoServSupl()");

		return resultado;
	}//fin getCargoServSupl

	/**
	 * Busca todos los Descuentos tipo Articulo asociados al Servicio 
	 * @param entrada
	 * @return resultado
	 * @throws GeneralException
	 */
	public DescuentoDTO[] getDescuentoCargoArticulo(ParametrosDescuentoDTO entrada) throws GeneralException{
		cat.debug("Inicio:getDescuentoCargoArticulo()");
		DescuentoDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();
		try {
			//INI-01 (AL) String call = getSQLDatosServSupl("VE_servicios_venta_PG","VE_obtiene_descuento_art_PR",14);
			String call = getSQLDatosServSupl("VE_servicios_venta_quiosco_PG","VE_obtiene_descuento_art_PR",14);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cat.debug("[getDescuentoCargoBasicoArticulo] cod operacion: " + entrada.getCodigoOperacion());
			cat.debug("[getDescuentoCargoBasicoArticulo] tipocontrato: " + entrada.getTipoContrato());
			cat.debug("[getDescuentoCargoBasicoArticulo] numero meses: " + entrada.getNumeroMesesContrato());
			cat.debug("[getDescuentoCargoBasicoArticulo] codigo antiguedad: " + entrada.getCodigoAntiguedad());
			cat.debug("[getDescuentoCargoBasicoArticulo] cod promedio: " + entrada.getCodigoPromedioFacturable());
			cat.debug("[getDescuentoCargoBasicoArticulo] estado: " + entrada.getEquipoEstado());
			cat.debug("[getDescuentoCargoBasicoArticulo] contrato: " + entrada.getTipoContrato());
			cat.debug("[getDescuentoCargoBasicoArticulo] numero meses: " + entrada.getNumeroMesesNuevo());
			cat.debug("[getDescuentoCargoBasicoArticulo] cod articulo: " + entrada.getCodigoArticulo());
			cat.debug("[getDescuentoCargoBasicoArticulo] clase desc: " + entrada.getClaseDescuento());
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

			cat.debug("Inicio:getDescuentoCargoArticulo:Execute");
			cstmt.execute();
			cat.debug("Fin:getDescuentoCargoArticulo:Execute");

			codError = cstmt.getInt(12);
			msgError = cstmt.getString(13);
			numEvento = cstmt.getInt(14);
			
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar los descuentos del cargo basico");
				throw new GeneralException(
						"Ocurrió un error al recuperar los descuentos del cargo basico", String
						.valueOf(codError), numEvento, msgError);

			}else{
				cat.debug("Recuperando descuentos");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(11);
				while (rs.next()) {
					DescuentoDTO descuentoDTO = new DescuentoDTO();
					descuentoDTO.setTipoAplicacion(rs.getString(1));
					descuentoDTO.setDescripcionConcepto(rs.getString(2));
					descuentoDTO.setMonto(rs.getFloat(3));
					descuentoDTO.setCodigoConcepto(rs.getString(4));

					lista.add(descuentoDTO);
					cat.debug("[getDescuentoCodigoConcpeto]: " + rs.getString(4));
					cat.debug("[getDescuentoDescripcionConcepto] : " + rs.getString(2));
					cat.debug("[getDescuentoMonto]: " + rs.getFloat(3));

				}
				rs.close();
				resultado =(DescuentoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
						lista.toArray(), DescuentoDTO.class);
				cat.debug("Fin recuperacion de descuentos del cargo basico");
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			throw (e);		
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar los descuentos del cargo basico",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al recuperar los descuentos del cargo basico",e);
		} finally {
			if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:getDescuentoCargoArticulo()");

		return resultado;
	}//fin getDescuentoCargoArticulo


	/**
	 * Busca todos los Descuentos tipo concepto asociados al Servicio 
	 * @param entrada
	 * @return resultado
	 * @throws GeneralException
	 */
	public DescuentoDTO[] getDescuentoCargoConcepto(ParametrosDescuentoDTO entrada) throws GeneralException{
		cat.debug("Inicio:getDescuentoCargoConcepto()");
		DescuentoDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();
		try {
			//INI-01 (AL) String call = getSQLDatosServSupl("VE_servicios_venta_PG","VE_obtiene_descuento_con_PR",16);
			String call = getSQLDatosServSupl("VE_servicios_venta_quiosco_PG","VE_obtiene_descuento_con_PR",16);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setString(1,entrada.getCodigoOperacion());
			cstmt.setString(2,entrada.getCodigoAntiguedad());
			cstmt.setString(3,entrada.getTipoContrato());
			cstmt.setInt(4,Integer.parseInt(entrada.getNumeroMesesNuevo()));
			cstmt.setInt(5,Integer.parseInt(entrada.getIndiceVentaExterna()));
			cstmt.setLong(6,Long.parseLong(entrada.getCodigoVendedor()));
			cstmt.setString(7,entrada.getCodigoCausaDescuento());
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
			
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar los descuentos del cargo");
				throw new GeneralException(
						"Ocurrió un error al recuperar los descuentos del cargo", String
						.valueOf(codError), numEvento, msgError);

			}else{
				cat.debug("Recuperando descuentos");
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
				resultado =(DescuentoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
						lista.toArray(), DescuentoDTO.class);
				cat.debug("Fin recuperacion de descuentos del cargo");
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			throw (e);		
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar los descuentos del cargo",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al recuperar los descuentos del cargo",e);
		} finally {
			if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:getDescuentoCargoConcepto()");

		return resultado;
	}//fin getDescuentoCargoConcepto	

	/**
	 * Obtiene Codigo Concepto Facturable del descuento manual 
	 * @param entrada
	 * @return resultado
	 * @throws GeneralException
	 */
	public DescuentoDTO getCodigoDescuentoManual(ParametrosDescuentoDTO entrada) throws GeneralException{
		cat.debug("Inicio:getCodigoDescuentoManual()");
		DescuentoDTO resultado = new DescuentoDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();
		try {
			//INI-01 (AL) String call = getSQLDatosServSupl("VE_servicios_venta_PG","VE_consulta_cod_desc_manual_PR",6);
			String call = getSQLDatosServSupl("VE_servicios_venta_quiosco_PG","VE_consulta_cod_desc_manual_PR",6);
			cat.debug("sql[" + call + "]");

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
			
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError == 0) 
				resultado.setCodigoConcepto(String.valueOf(cstmt.getInt(3)));
			else{
				cat.error("Ocurrió un error al recuperar el código de descuento manual");
				throw new GeneralException(
						"Ocurrió un error al recuperar el código de descuento manual", String
						.valueOf(codError), numEvento, msgError);				
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			throw (e);		
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar el código de descuento manual",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al recuperar el código de descuento manual",e);
		} finally {
			if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:getCodigoDescuentoManual()");

		return resultado;
	}//fin getCodigoDescuentoManual	

	public ServicioSuplementarioDTO[] getListaSSAbonadoParaCentral(ServicioSuplementarioDTO servicioSuplementario) 
	throws GeneralException{
		cat.debug("Inicio:getListaSSAbonadoParaCentral()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ServicioSuplementarioDTO[] resultado = null;
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();
		cat.debug("Coneccion obtenida OK");
		try {
			//INI-01 (AL) String call = getSQLDatosServSupl("VE_serv_suplem_abo_PG","VE_obtiene_SSabo_paracent_PR",10);
			String call = getSQLDatosServSupl("VE_serv_suplem_abo_quiosco_PG","VE_obtiene_SSabo_paracent_PR",10);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cat.debug("WJRC...inicio");
			cat.debug("WJRC...NumeroAbonado   " + servicioSuplementario.getNumeroAbonado());
			cat.debug("WJRC...IndicadorEstado " + servicioSuplementario.getIndicadorEstado());
			cat.debug("WJRC...CodigoProducto  " + servicioSuplementario.getCodigoProducto());
			cat.debug("WJRC...CodigoModulo    " + servicioSuplementario.getCodigoModulo());
			cat.debug("WJRC...CodigoSistema   " + servicioSuplementario.getCodigoSistema());
			cat.debug("WJRC...CodigoActuacion " + servicioSuplementario.getCodigoActuacion());

			cstmt.setInt(1,Integer.parseInt(servicioSuplementario.getNumeroAbonado()));
			cstmt.setInt(2,servicioSuplementario.getIndicadorEstado());
			cstmt.setString(3,servicioSuplementario.getCodigoProducto());
			cstmt.setString(4,servicioSuplementario.getCodigoModulo());
			cstmt.setInt(5,servicioSuplementario.getCodigoSistema());
			cstmt.setString(6,servicioSuplementario.getCodigoActuacion());

			cstmt.registerOutParameter(7,OracleTypes.CURSOR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getListaSSAbonadoParaCentral:Execute");
			cstmt.execute();
			cat.debug("Fin:getListaSSAbonadoParaCentral:Execute");

			codError = cstmt.getInt(8);
			msgError = cstmt.getString(9);
			numEvento = cstmt.getInt(10);
			
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar SS del abonado");
				throw new GeneralException(
						"Ocurrió un error al recuperar SS del abonado", String
						.valueOf(codError), numEvento, msgError);

			}else{
				cat.debug("Recuperando SS del abonado");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(7);
				while (rs.next()) {
					ServicioSuplementarioDTO servicioSuplementarioDTO = new ServicioSuplementarioDTO();
					servicioSuplementarioDTO.setNumeroAbonado(servicioSuplementario.getNumeroAbonado());
					servicioSuplementarioDTO.setCodigoServicio(rs.getString(1));
					servicioSuplementarioDTO.setCodigoServSupl(rs.getString(2));
					servicioSuplementarioDTO.setCodigoNivel(rs.getString(3));
					servicioSuplementarioDTO.setCodigoConcepto(rs.getString(4));

					cat.debug("WJRC...");
					cat.debug("WJRC...setCodigoServicio   " + servicioSuplementarioDTO.getCodigoServicio());
					cat.debug("WJRC...setCodigoServSupl   " + servicioSuplementarioDTO.getCodigoServSupl());
					cat.debug("WJRC...setCodigoNivel      " + servicioSuplementarioDTO.getCodigoNivel());
					cat.debug("WJRC...setCodigoConcepto   " + servicioSuplementarioDTO.getCodigoConcepto());

					lista.add(servicioSuplementarioDTO);
				}
				rs.close();
				resultado =(ServicioSuplementarioDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
						lista.toArray(), ServicioSuplementarioDTO.class);

				cat.debug("Fin recuperacion de SS del abonado");
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			throw (e);		
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar SS del abonado",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al recuperar SS del abonado",e);
		} finally {
			if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("WJRC...fin");
		cat.debug("Fin:getListaSSAbonadoParaCentral()");

		return resultado;
	}//fin getListaSSAbonadoParaCentral

	/**
	 * Obtiene lista de SS del abonado que no son enviados a centrales
	   para completar cadena clase servicio del abonado
	 * @param entrada
	 * @return resultado
	 * @throws GeneralException
	 */

	public ServicioSuplementarioDTO[] getSSAbonadoNoCentrales(ServicioSuplementarioDTO servicioSuplementario) 
	throws GeneralException{
		cat.debug("Inicio:getSSAbonadoNoCentrales()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ServicioSuplementarioDTO[] resultado = null;
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();
		cat.debug("Coneccion obtenida OK");
		try {
			//INI-01 (AL) String call = getSQLDatosServSupl("VE_serv_suplem_abo_PG","VE_obtiene_SSabo_nocent_PR",10);
			String call = getSQLDatosServSupl("VE_serv_suplem_abo_quiosco_PG","VE_obtiene_SSabo_nocent_PR",10);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cat.debug("NumeroAbonado   " + servicioSuplementario.getNumeroAbonado());
			cat.debug("IndicadorEstado " + servicioSuplementario.getIndicadorEstado());
			cat.debug("CodigoProducto  " + servicioSuplementario.getCodigoProducto());
			cat.debug("CodigoModulo    " + servicioSuplementario.getCodigoModulo());
			cat.debug("CodigoSistema   " + servicioSuplementario.getCodigoSistema());
			cat.debug("CodigoActuacion " + servicioSuplementario.getCodigoActuacion());

			cstmt.setInt(1,Integer.parseInt(servicioSuplementario.getNumeroAbonado()));
			cstmt.setInt(2,servicioSuplementario.getIndicadorEstado());
			cstmt.setString(3,servicioSuplementario.getCodigoProducto());
			cstmt.setString(4,servicioSuplementario.getCodigoModulo());
			cstmt.setInt(5,servicioSuplementario.getCodigoSistema());
			cstmt.setString(6,servicioSuplementario.getCodigoActuacion());

			cstmt.registerOutParameter(7,OracleTypes.CURSOR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getSSAbonadoNoCentrales:Execute");
			cstmt.execute();
			cat.debug("Fin:getSSAbonadoNoCentrales:Execute");

			codError = cstmt.getInt(8);
			msgError = cstmt.getString(9);
			numEvento = cstmt.getInt(10);
			
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar SS del abonado");
				throw new GeneralException(
						"Ocurrió un error al recuperar SS del abonado", String
						.valueOf(codError), numEvento, msgError);

			}else{
				cat.debug("Recuperando SS del abonado");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(7);
				while (rs.next()) {
					ServicioSuplementarioDTO servicioSuplementarioDTO = new ServicioSuplementarioDTO();
					servicioSuplementarioDTO.setCadSSNivel(rs.getString(1));
					cat.debug("setCadSSNivel   " + servicioSuplementarioDTO.getCodigoConcepto());
					lista.add(servicioSuplementarioDTO);
				}
				rs.close();
				resultado =(ServicioSuplementarioDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
						lista.toArray(), ServicioSuplementarioDTO.class);
				cat.debug("Fin recuperacion de SS del abonado");
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}

		} catch (GeneralException e) {
			throw (e);		
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar SS del abonado",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al recuperar SS del abonado",e);
		} finally {
			if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:getSSAbonadoNoCentrales()");

		return resultado;
	}//fin getListaSSAbonadoDefPlan


	public SSuplementariosDTO[] getSSincluidosEnPlan(String codigoPlanTarifario) 
	throws GeneralException{
		cat.debug("Inicio:getSSincluidosEnPlan()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		SSuplementariosDTO[] resultado = null;
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();
		cat.debug("Coneccion obtenida OK");
		try {
			String call = getSQLDatosServSupl("VE_SERVICIOS_SUPLEM_PG","ve_rec_servicios_def_plan_pr",5);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cat.debug("Codigo Plan Tarifario   " + codigoPlanTarifario);

			cstmt.setString(1,codigoPlanTarifario);			
			cstmt.registerOutParameter(2,OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getSSincluidosEnPlan:Execute");
			cstmt.execute();
			cat.debug("Fin:getSSincluidosEnPlan:Execute");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar SS por defecto al plan");
				throw new GeneralException(
						"Ocurrió un error al recuperar SS por defecto al plan", String
						.valueOf(codError), numEvento, msgError);

			}else{
				cat.debug("Recuperando SS del plan");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(2);
				SSuplementariosDTO servicioSuplementario = null;
				while (rs.next()) {
					servicioSuplementario = new SSuplementariosDTO();

					servicioSuplementario.setCodigoServicio(rs.getString(1));
					servicioSuplementario.setDescripcionServicioS(rs.getString(2));										
					servicioSuplementario.setCodigoServSupl(rs.getString(3));
					servicioSuplementario.setCodigoNivel(rs.getString(4));
					servicioSuplementario.setCodConceptoActiva(rs.getString(5));
					servicioSuplementario.setImporteActiva(rs.getString(6));
					servicioSuplementario.setCodConceptoMensual(rs.getString(7));
					servicioSuplementario.setTarifaMensual(rs.getString(8));
					servicioSuplementario.setDuracion(rs.getString(9));

					lista.add(servicioSuplementario);
				}
				rs.close();
				resultado =(SSuplementariosDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
						lista.toArray(), SSuplementariosDTO.class);
				cat.debug("Fin recuperacion de SS del plan");
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			throw e;			
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar SS del plan",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al recuperar SS del plan",e);
		} finally {
			if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:getSSincluidosEnPlan()");

		return resultado;
	}//fin getListaSSAbonadoDefPlan	


	public SSuplementariosDTO[] getSSOpcionalesAlPlan(String codigoPlanTarifario, String codigoArticulo, String codigCentral) 
	throws GeneralException{
		cat.debug("Inicio:getSSincluidosEnPlan()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		SSuplementariosDTO[] resultado = null;
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();
		cat.debug("Coneccion obtenida OK");
		try {
			String call = getSQLDatosServSupl("VE_SERVICIOS_SUPLEM_PG","ve_rec_servicios_opc_plan_pr",8);			
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cat.debug("Codigo Plan Tarifario   " + codigoPlanTarifario);
			cat.debug("codigo de Articulo   " + codigoArticulo);

			cstmt.setString(1,codigoPlanTarifario);		
			cstmt.setLong(2,Long.valueOf(codigoArticulo).longValue());
			cstmt.setString(3, codigCentral);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, OracleTypes.CURSOR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getSSincluidosEnPlan:Execute");
			cstmt.execute();
			cat.debug("Fin:getSSincluidosEnPlan:Execute");

			codError = cstmt.getInt(6);
			msgError = cstmt.getString(7);
			numEvento = cstmt.getInt(8);
			
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar SS por defecto al plan");
				throw new GeneralException(
						"Ocurrió un error al recuperar SS por defecto al plan", String
						.valueOf(codError), numEvento, msgError);

			}else{
				cat.debug("Recuperando SS del plan");

				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(5);
				SSuplementariosDTO servicioSuplementario = null;
				while (rs.next()) {
					servicioSuplementario = new SSuplementariosDTO();					
					servicioSuplementario.setCodigoServicio(rs.getString(1));
					servicioSuplementario.setDescripcionServicioS(rs.getString(2));										
					servicioSuplementario.setCodigoServSupl(rs.getString(3));
					servicioSuplementario.setCodigoNivel(rs.getString(4));
					servicioSuplementario.setCodConceptoActiva(rs.getString(5));
					servicioSuplementario.setImporteActiva(rs.getString(6));
					servicioSuplementario.setCodConceptoMensual(rs.getString(7));
					servicioSuplementario.setTarifaMensual(rs.getString(8));
					servicioSuplementario.setDuracion(rs.getString(9));
					lista.add(servicioSuplementario);
				}
				rs.close();
				resultado =(SSuplementariosDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
						lista.toArray(), SSuplementariosDTO.class);
				cat.debug("Fin recuperacion de SS del plan");
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			throw e;			
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar SS del plan",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al recuperar SS del plan",e);
		} finally {
			if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:getSSincluidosEnPlan()");

		return resultado;
	}	

	public SSuplementariosDTO[] getSSOpcionalesAlPlanOpc(String codigoPlanTarifario, String codigoArticulo) 
	throws GeneralException{
		cat.debug("Inicio:getSSincluidosEnPlan()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		SSuplementariosDTO[] resultado = null;
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();
		cat.debug("Coneccion obtenida OK");
		try {
			String call = getSQLDatosServSupl("VE_SERVICIOS_SUPLEM_PG","ve_rec_servicios_opc2_plan_pr",7);			
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cat.debug("Codigo Plan Tarifario   " + codigoPlanTarifario);
			cat.debug("codigo de Articulo   " + codigoArticulo);

			cstmt.setString(1,codigoPlanTarifario);		
			cstmt.setString(2,codigoArticulo);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4,OracleTypes.CURSOR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getSSincluidosEnPlan:Execute");
			cstmt.execute();
			cat.debug("Fin:getSSincluidosEnPlan:Execute");

			codError = cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento = cstmt.getInt(7);
			
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar SS por defecto al plan");
				throw new GeneralException(
						"Ocurrió un error al recuperar SS por defecto al plan", String
						.valueOf(codError), numEvento, msgError);

			}else{
				cat.debug("Recuperando SS del plan");


				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(4);
				SSuplementariosDTO servicioSuplementario = null;
				while (rs.next()) {
					servicioSuplementario = new SSuplementariosDTO();					
					servicioSuplementario.setCodigoServicio(rs.getString(1));
					servicioSuplementario.setDescripcionServicioS(rs.getString(2));										
					servicioSuplementario.setCodigoServSupl(rs.getString(3));
					servicioSuplementario.setCodigoNivel(rs.getString(4));
					servicioSuplementario.setCodConceptoMensual(rs.getString(5));
					servicioSuplementario.setDuracion(rs.getString(6));
					lista.add(servicioSuplementario);
				}
				rs.close();
				resultado =(SSuplementariosDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
						lista.toArray(), SSuplementariosDTO.class);
				cat.debug("Fin recuperacion de SS del plan");
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			throw e;			
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar SS del plan",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al recuperar SS del plan",e);
		} finally {
			if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:getSSincluidosEnPlan()");

		return resultado;
	}		


	public ReglasSSuplementariosDTO[] getReglaSSporServicio(String codigoServicioS) 
	throws GeneralException{
		cat.debug("Inicio:getSSincluidosEnPlan()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ReglasSSuplementariosDTO[] resultado = null;
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();
		cat.debug("Coneccion obtenida OK");
		try {
			String call = getSQLDatosServSupl("VE_SERVICIOS_SUPLEM_PG","VE_regla_val_servicio_PR",5);			
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cat.debug("Codigo Servicio Suplementario [" + codigoServicioS +"]");							

			cstmt.setString(1,codigoServicioS);		
			cstmt.registerOutParameter(2,OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getReglaSSporServicio:Execute");
			cstmt.execute();
			cat.debug("Fin:getReglaSSporServicio:Execute");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);

			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");
			
			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar SS por defecto al plan");
				throw new GeneralException(
						"Ocurrió un error al recuperar SS por defecto al plan", String
						.valueOf(codError), numEvento, msgError);

			}else{
				cat.debug("Recuperando SS del plan");


				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(2);
				ReglasSSuplementariosDTO ReglasSSuplementarios = null;
				while (rs.next()) {

					ReglasSSuplementarios = new ReglasSSuplementariosDTO();	

					ReglasSSuplementarios.setCodigoServicio(rs.getString(2));
					cat.error("ReglasSSuplementarios.getCodigoServicio() ["+ReglasSSuplementarios.getCodigoServicio()+"]");
					ReglasSSuplementarios.setCodigoServicioDef(rs.getString(3));
					cat.error("ReglasSSuplementarios.getCodigoServicioDef() ["+ReglasSSuplementarios.getCodigoServicioDef()+"]");
					ReglasSSuplementarios.setTiporelacion(rs.getString(6));
					cat.error("ReglasSSuplementarios.getTiporelacion() ["+ReglasSSuplementarios.getTiporelacion()+"]");
					cat.error(" ");
					lista.add(ReglasSSuplementarios);
				}
				rs.close();
				resultado =(ReglasSSuplementariosDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
						lista.toArray(), ReglasSSuplementariosDTO.class);
				cat.debug("Fin recuperacion de SS del plan");
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			throw e;			
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar SS del plan",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al recuperar SS del plan",e);
		} finally {
			if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:getSSincluidosEnPlan()");

		return resultado;
	}	

	public void setAgregaSS(AbonadoDTO abonado, WsAgregaEliminaSSInDTO[] sSuplementarios) 
	throws GeneralException{
		cat.debug("Inicio:getAgregaSS()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();
		cat.debug("Coneccion obtenida OK");
		try {
			String call = getSQLDatosServSupl("VE_SERVICIOS_SUPLEM_PG","pv_agregar_ss_pr",11);			
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			for (int j=0; j< sSuplementarios.length ; j++){
				cstmt.setLong  (1, abonado.getNumAbonado());		
				cat.debug("abonado.getNumAbonado() ["+abonado.getNumAbonado()+"]");
				cstmt.setString(2, sSuplementarios[j].getCodigoServicio());
				cat.debug("sSuplementarios.getCodigoServicio() ["+sSuplementarios[j].getCodigoServicio()+"]");
				cstmt.setString(3, sSuplementarios[j].getCodigoServSupl());
				cat.debug("sSuplementarios.getCodigoServSupl() ["+sSuplementarios[j].getCodigoServSupl()+"]");
				cstmt.setString(4, sSuplementarios[j].getCodigoNivel());
				cat.debug("sSuplementarios.getCodigoNivel() ["+sSuplementarios[j].getCodigoNivel()+"]");
				cstmt.setLong  (5, abonado.getNumCelular());
				cat.debug("abonado.getNumCelular() ["+abonado.getNumCelular()+"]");
				cstmt.setString(6, abonado.getNomUsuarOra());
				cat.debug("abonado.getNomUsuarOra() ["+abonado.getNomUsuarOra()+"]");
				cstmt.setString(7, sSuplementarios[j].getCodigoConcepto());
				cat.debug("sSuplementarios.getCodigoConcepto() ["+sSuplementarios[j].getCodigoConcepto()+"]");
				if (sSuplementarios[j].getDuracion().trim().equals("N")){
					cstmt.setString(8, "");
					cat.debug("sSuplementarios.getDuracion() []");
				}else{
					cstmt.setString(8, sSuplementarios[j].getDuracion().trim());
					cat.debug("sSuplementarios.getDuracion() ["+sSuplementarios[j].getDuracion().trim()+"]");
				}

				cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);

				cat.debug("Inicio:getAgregaSS:Execute");
				cstmt.execute();
				cat.debug("Fin:getAgregaSS:Execute");

				codError = cstmt.getInt(9);
				msgError = cstmt.getString(10);
				numEvento = cstmt.getInt(11);

				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
				
				if (codError != 0) {
					cat.error("Ocurrió un error al agregar SS ");
					throw new GeneralException(
							"Ocurrió un error al agregar SS ", String
							.valueOf(codError), numEvento, msgError);

				}
			}

			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}

		} catch (GeneralException e) {
			throw e;			
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar SS del plan",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al recuperar SS del plan",e);
		} finally {
			if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:getAgregaSS()");
	}

	public void setEliminarSS(AbonadoDTO abonado, WsAgregaEliminaSSInDTO[] sSuplementarios)
	throws GeneralException{
		cat.debug("Inicio:getEliminarSS()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();
		cat.debug("Coneccion obtenida OK");
		try {
			String call = getSQLDatosServSupl("VE_SERVICIOS_SUPLEM_PG","pv_elimina_ss_pr",6);			
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			for (int j=0; j< sSuplementarios.length ; j++){

				cstmt.setLong  (1, abonado.getNumAbonado());		
				cat.debug("abonado.getNumAbonado() ["+abonado.getNumAbonado()+"]");
				cstmt.setString(2, sSuplementarios[j].getCodigoServicio());
				cat.debug("sSuplementarios.getCodigoServicio() ["+sSuplementarios[j].getCodigoServicio()+"]");
				cstmt.setString(3, sSuplementarios[j].getCodigoServSupl());
				cat.debug("sSuplementarios.getCodigoServSupl() ["+sSuplementarios[j].getCodigoServSupl()+"]");
				cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

				cat.debug("Inicio:getEliminarSS:Execute");
				cstmt.execute();
				cat.debug("Fin:getEliminarSS:Execute");

				codError = cstmt.getInt(4);
				msgError = cstmt.getString(5);
				numEvento = cstmt.getInt(6);
				
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");

				if (codError != 0) {
					cat.error("Ocurrió un error al recuperar SS por defecto al plan");
					throw new GeneralException(
							"Ocurrió un error al recuperar SS por defecto al plan", String
							.valueOf(codError), numEvento, msgError);				
				}
			}

			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar SS del plan",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al recuperar SS del plan",e);
		} finally {
			if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:getEliminarSS()");		
	}	
	
	
	public ReglaCompatibilidadSSDTO[] getReglasCompatibilidadSS() 
	throws GeneralException{
		cat.debug("Inicio:getReglasCompatibilidadSS()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ReglaCompatibilidadSSDTO[]  resultado = null;
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();
		cat.debug("Coneccion obtenida OK");
		try {
			String call = getSQLDatosServSupl("VE_SERVICIOS_SUPLEM_PG","pv_reglas_valid_vig_ss_pr",4);			
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.registerOutParameter(1,OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getReglasCompatibilidadSS:Execute");
			cstmt.execute();
			cat.debug("Fin:getReglasCompatibilidadSS:Execute");

			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);

			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");
			
			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar las reglas de compatibilidad de los SS");
				throw new GeneralException(
						"Ocurrió un error al recuperar las reglas de compatibilidad de los SS", String
						.valueOf(codError), numEvento, msgError);

			}else{
				cat.debug("Recuperando Reglas de compatibilidad de los SS");


				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(1);
				ReglaCompatibilidadSSDTO reglaCompatibilidadSSDTO = null;
				while (rs.next()) {

					reglaCompatibilidadSSDTO = new ReglaCompatibilidadSSDTO();	
					
					
					reglaCompatibilidadSSDTO.setCodProducto(rs.getString(1));
					cat.error("reglaCompatibilidadSSDTO.getCodProducto() ["+reglaCompatibilidadSSDTO.getCodProducto()+"]");
					reglaCompatibilidadSSDTO.setCodServicio(rs.getString(2));
					cat.error("reglaCompatibilidadSSDTO.getCodServicio() ["+reglaCompatibilidadSSDTO.getCodServicio()+"]");
					reglaCompatibilidadSSDTO.setCodServdef(rs.getString(3));
					cat.error("reglaCompatibilidadSSDTO.getCodServdef() ["+reglaCompatibilidadSSDTO.getCodServdef()+"]");
					reglaCompatibilidadSSDTO.setNomIsuario(rs.getString(4));
					cat.error("reglaCompatibilidadSSDTO.getNomIsuario() ["+reglaCompatibilidadSSDTO.getNomIsuario()+"]");
					reglaCompatibilidadSSDTO.setCodServorig(rs.getString(5));
					cat.error("reglaCompatibilidadSSDTO.getCodServorig() ["+reglaCompatibilidadSSDTO.getCodServorig()+"]");
					reglaCompatibilidadSSDTO.setTipRelacion(rs.getString(6));
					cat.error("reglaCompatibilidadSSDTO.getTipRelacion() ["+reglaCompatibilidadSSDTO.getTipRelacion()+"]");
					reglaCompatibilidadSSDTO.setCodActabo(rs.getString(7));
					cat.error("reglaCompatibilidadSSDTO.getCodActabo() ["+reglaCompatibilidadSSDTO.getCodActabo()+"]");
					lista.add(reglaCompatibilidadSSDTO);
				}
				rs.close();
				resultado =(ReglaCompatibilidadSSDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
						lista.toArray(), ReglaCompatibilidadSSDTO.class);
				cat.debug("Fin recuperacion reglas de compatibilidad SS");
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			throw e;			
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar SS del plan",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al recuperar SS del plan",e);
		} finally {
			if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:getReglasCompatibilidadSS()");

		return resultado;
	}
	
	
	public ExisteSSAbonadoDTO validaExisteSSAbondo(ExisteSSAbonadoDTO existeSSAbonadoDTO) 
	throws GeneralException{
		cat.debug("Inicio:validaExisteSSAbondo()");
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();
		cat.debug("Coneccion obtenida OK");
		existeSSAbonadoDTO.setCodigoError(new Long(0));
		existeSSAbonadoDTO.setDescripcionError(null);
		existeSSAbonadoDTO.setNumeroEvento(new Long(0));
		try {
			String call = getSQLDatosServSupl("VE_SERVICIOS_SUPLEM_PG","ve_val_servicios_activos_pr",6);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			
			cstmt.setLong(1,existeSSAbonadoDTO.getNumAbonado());
			cstmt.setString(2,existeSSAbonadoDTO.getCodigoServicio());
			cstmt.setString(3,existeSSAbonadoDTO.getCodigoServSupl());
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

			cat.debug("Inicio:validaExisteSSAbondo:Execute");
			cstmt.execute();
			cat.debug("Fin:validaExisteSSAbondo:Execute");

			existeSSAbonadoDTO.setCodigoError(new Long(cstmt.getInt(4)));
			existeSSAbonadoDTO.setDescripcionError(cstmt.getString(5));
			existeSSAbonadoDTO.setNumeroEvento(new Long(cstmt.getInt(6)));
			
			cat.debug("Codigo de Error[" + existeSSAbonadoDTO.getCodigoError() + "]");
			cat.debug("Mensaje de Error[" + existeSSAbonadoDTO.getDescripcionError() + "]");
			cat.debug("Numero de Evento[" + existeSSAbonadoDTO.getNumeroEvento() + "]");

			if (	existeSSAbonadoDTO.getCodigoError().longValue() != 0 &&
					existeSSAbonadoDTO.getCodigoError().longValue() != 10620 &&
					existeSSAbonadoDTO.getCodigoError().longValue() != 10621
			) {
				cat.error("Ocurrió un error al validar el servicio suplementario [" + existeSSAbonadoDTO.getCodigoServicio() +"]");
				throw new GeneralException(
						"Ocurrió un error al validar el servicio suplementario [" + existeSSAbonadoDTO.getCodigoServicio() +"]", String
						.valueOf(existeSSAbonadoDTO.getCodigoError()), existeSSAbonadoDTO.getNumeroEvento().longValue(), existeSSAbonadoDTO.getDescripcionError());

			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			throw e;			
		} catch (Exception e) {
			cat.error("Ocurrió un error al validar el servicio suplementario [" + existeSSAbonadoDTO.getCodigoServicio() +"]",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + existeSSAbonadoDTO.getCodigoError() + "]");
				cat.debug("Mensaje de Error[" + existeSSAbonadoDTO.getDescripcionError() + "]");
				cat.debug("Numero de Evento[" + existeSSAbonadoDTO.getNumeroEvento() + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al validar el servicio suplementario [" + existeSSAbonadoDTO.getCodigoServicio() +"]",e);
		} finally {
			if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:validaExisteSSAbondo()");

		return existeSSAbonadoDTO;
	}//fin validaExisteSSAbondo
	
	

}//fin ServicioSuplementarioDAO