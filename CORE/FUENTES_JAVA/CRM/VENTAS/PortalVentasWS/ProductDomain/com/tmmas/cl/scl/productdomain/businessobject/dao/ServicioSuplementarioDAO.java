package com.tmmas.cl.scl.productdomain.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.ListadoSSInDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.ListadoSSOutDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.DescuentoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosDescuentoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.PrecioCargoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ReglaSSDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.ProductDomainException;
import com.tmmas.cl.scl.productdomain.businessobject.dto.ServicioSuplementarioDTO;
import com.tmmas.cl.scl.productdomain.businessobject.helper.Global;

public class ServicioSuplementarioDAO extends ConnectionDAO{
	private static Category cat = Category.getInstance(ServicioSuplementarioDAO.class);
	Global global = Global.getInstance();
	
	private Connection getConection() 
	throws ProductDomainException
	{
		Connection conn = null;
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
		} catch (Exception e1) {
			conn = null;
			cat.error(" No se pudo obtener una conexión ", e1);
			throw new ProductDomainException("No se pudo obtener una conexión", e1);
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
		throws ProductDomainException
	{		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {			
			cat.debug("Inicio:creaSSAbonado");

			String call = getSQLDatosServSupl("VE_serv_suplem_abo_PG","VE_ProcesoSSAbonado_PR",9);
			cat.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);

			//-- PARAMETROS DE ENTRADA
			cstmt.setString(1,entrada.getNumeroAbonado());
			cstmt.setString(2,entrada.getCodigoPlan());
			cstmt.setString(3,entrada.getNumeroTerminal());
			cstmt.setString(4,entrada.getNomUsuario());
			cstmt.setString(5,entrada.getCodTecnologia());
			cstmt.setString(6,entrada.getTipoTerminal());
			
			
			//-- PARAMETROS DE SALIDA
			cstmt.registerOutParameter(7,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9,java.sql.Types.NUMERIC);

			cat.debug("Inicio:creaSSAbonado:execute");			
			cstmt.execute();			
			cat.debug("Fin:creaSSAbonado:execute");

			codError=cstmt.getInt(7);
			msgError = cstmt.getString(8);
			numEvento=cstmt.getInt(9);
			
			cat.debug("INICIO creaSSAbonado DAO codError: " + codError );
			cat.debug("INICIO creaSSAbonado DAO msgError: " + msgError);
			cat.debug("INICIO creaSSAbonado DAO numEvento : " + numEvento);
			
			if (codError != 0) {
				cat.error("Ocurrió un error al insertar al crear servicios suplemetarios del abonado");
				if (cat.isDebugEnabled()) {
					cat.debug("Codigo de Error[" + codError + "]");
					cat.debug("Mensaje de Error[" + msgError + "]");
					cat.debug("Numero de Evento[" + numEvento + "]");
				}
				throw new ProductDomainException(
						"Ocurrió un error al insertar al crear servicios suplemetarios del abonado", String
								.valueOf(codError), numEvento, msgError);
			}			
		} catch (Exception e) {
			cat.error("Ocurrió un error al insertar al crear servicios suplemetarios del abonado",e);
			if (e instanceof ProductDomainException ) throw (ProductDomainException) e;
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
		throws ProductDomainException
	{
		cat.debug("Inicio:getListaSSAbonado()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ServicioSuplementarioDTO[] resultado = null;
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();
		ResultSet rs = null;
		cat.debug("Coneccion obtenida OK");
		try {
			String call = getSQLDatosServSupl("VE_serv_suplem_abo_PG","VE_obtiene_SS_abonado_PR",5);
			
			cat.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,servicioSuplementario.getNumeroAbonado());
			cat.debug("servicioSuplementario.getNumeroAbonado():" + servicioSuplementario.getNumeroAbonado());
			cstmt.registerOutParameter(2,OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getListaSSAbonado:Execute");
			cstmt.execute();
			cat.debug("Fin:getListaSSAbonado:Execute");
			
			codError = cstmt.getInt(3);
			cat.debug("codError:" + codError);
			msgError = cstmt.getString(4);
			cat.debug("msgError:" + msgError);
			numEvento = cstmt.getInt(5);
			cat.debug("numEvento:" + numEvento);

			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar SS del abonado");
				throw new ProductDomainException("Ocurrió un error al recuperar SS del abonado", String
								.valueOf(codError), numEvento, msgError);
				
			}else{
				cat.debug("Recuperando SS del abonado");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(2);
				while (rs.next()) {
					ServicioSuplementarioDTO servicioSuplementarioDTO = new ServicioSuplementarioDTO();
					servicioSuplementarioDTO.setNumeroAbonado(servicioSuplementario.getNumeroAbonado());
					servicioSuplementarioDTO.setCodigoServicio(rs.getString(1));
					servicioSuplementarioDTO.setCodigoServSupl(rs.getString(2));
					servicioSuplementarioDTO.setCodigoNivel(rs.getString(3));
					servicioSuplementarioDTO.setCodigoConcepto(rs.getString(4));
					lista.add(servicioSuplementarioDTO);
				}				
				resultado =(ServicioSuplementarioDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), ServicioSuplementarioDTO.class);
		  
				cat.debug("Fin recuperacion de SS del abonado");
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar SS del abonado",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof ProductDomainException ) throw (ProductDomainException) e;
		} finally {
		 	if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (rs!=null)
					rs.close();
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

	public ServicioSuplementarioDTO[] getListaSSAbonadoEV(ServicioSuplementarioDTO servicioSuplementario) 
		throws ProductDomainException
	{
		cat.debug("Inicio:getListaSSAbonadoEV()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ServicioSuplementarioDTO[] resultado = null;
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();
		ResultSet rs = null;
		cat.debug("Conexion obtenida OK");
		try {
			String call = getSQLDatosServSupl("VE_serv_suplem_abo_PG","VE_obtiene_SS_abonadoEV_PR",5);
			
			cat.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,servicioSuplementario.getNumeroAbonado());
			cat.debug("servicioSuplementario.getNumeroAbonado():" + servicioSuplementario.getNumeroAbonado());
			cstmt.registerOutParameter(2,OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getListaSSAbonado:Execute");
			cstmt.execute();
			cat.debug("Fin:getListaSSAbonado:Execute");
			
			codError = cstmt.getInt(3);
			cat.debug("codError:" + codError);
			msgError = cstmt.getString(4);
			cat.debug("msgError:" + msgError);
			numEvento = cstmt.getInt(5);
			cat.debug("numEvento:" + numEvento);
	
			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar SS del abonado");
				throw new ProductDomainException("Ocurrió un error al recuperar SS del abonado", String
								.valueOf(codError), numEvento, msgError);
				
			}else{
				cat.debug("Recuperando SS del abonado");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(2);
				while (rs.next()) {
					ServicioSuplementarioDTO servicioSuplementarioDTO = new ServicioSuplementarioDTO();
					servicioSuplementarioDTO.setNumeroAbonado(servicioSuplementario.getNumeroAbonado());
					servicioSuplementarioDTO.setCodigoServicio(rs.getString(1));
					servicioSuplementarioDTO.setCodigoServSupl(rs.getString(2));
					servicioSuplementarioDTO.setCodigoNivel(rs.getString(3));
					servicioSuplementarioDTO.setCodigoConcepto(rs.getString(4));
					lista.add(servicioSuplementarioDTO);
				}				
				resultado =(ServicioSuplementarioDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), ServicioSuplementarioDTO.class);
		  
				cat.debug("Fin recuperacion de SS del abonado");
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar SS del abonado",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof ProductDomainException ) throw (ProductDomainException) e;
		} finally {
		 	if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (rs!=null)
					rs.close();
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:getListaSSAbonadoEV()");
	
		return resultado;
	}//fin getListaSSAbonado

	public PrecioCargoDTO[] getCargoServSupl(ServicioSuplementarioDTO entrada) 
		throws ProductDomainException
	{
		cat.debug("Inicio:getCargoServSupl()");
		PrecioCargoDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();
		ResultSet rs = null;
		try {
			String call = getSQLDatosServSupl("VE_servicios_venta_PG","VE_precio_cargo_servsupl_PR",8);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			
			//-- PARAMETROS DE ENTRADA
			cstmt.setString(1,entrada.getCodigoProducto());
			cat.debug("entrada.getCodigoProducto():" + entrada.getCodigoProducto());
			cstmt.setString(2,entrada.getCodigoServicio());
			cat.debug("entrada.getCodigoServicio():" + entrada.getCodigoServicio());
			cstmt.setString(3,entrada.getCodigoPlanServicio());
			cat.debug("entrada.getCodigoPlanServicio():"+entrada.getCodigoPlanServicio());
			cstmt.setString(4,entrada.getCodigoActuacion());
			cat.debug("entrada.getCodigoActuacion():"+entrada.getCodigoActuacion());
			
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
			
			
			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar cargo servicio suplementario");
				throw new ProductDomainException("Ocurrió un error al recuperar cargo servicio suplementario", String
								.valueOf(codError), numEvento, "No se encuentra precio asociado al SS configurado");
				
			}else{
				cat.debug("Recuperando cargo servicio suplementario");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(5);
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
					precioDTO.setTipoCobro(rs.getString(15));

					lista.add(precioDTO);
					cat.debug("ENCONTRO PRECIO" + precioDTO.getCodigoConcepto());
				}				
				resultado =(PrecioCargoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), PrecioCargoDTO.class);
				
				cat.debug("Fin recuperacion cargo servicio suplementario");
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar cargo servicio suplementario",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof ProductDomainException ) throw (ProductDomainException) e;
		} finally {
		 	if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (rs!=null)
					rs.close();
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
	 * @throws ProductDomainException
	 */
	public DescuentoDTO[] getDescuentoCargoArticulo(ParametrosDescuentoDTO entrada) 
		throws ProductDomainException
	{
		cat.debug("Inicio:getDescuentoCargoArticulo()");
		DescuentoDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();
		ResultSet rs = null;
		try {
			String call = getSQLDatosServSupl("VE_servicios_venta_PG","VE_obtiene_descuento_art_PR",14);
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

			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar los descuentos del cargo basico");
				throw new ProductDomainException("Ocurrió un error al recuperar los descuentos del cargo basico", String
								.valueOf(codError), numEvento, msgError);
				
			}else{
				cat.debug("Recuperando descuentos");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(11);
				while (rs.next()) {
					DescuentoDTO descuentoDTO = new DescuentoDTO();
					descuentoDTO.setTipoAplicacion(rs.getString(1));
					descuentoDTO.setCodMoneda(rs.getString(2));
					descuentoDTO.setMonto(rs.getFloat(3));
					descuentoDTO.setCodigoConcepto(rs.getString(4));
					
					lista.add(descuentoDTO);
					cat.debug("[getDescuentoCodigoConcpeto]: " + rs.getString(4));
					cat.debug("[getDescuentoDescripcionConcepto] : " + rs.getString(2));
					cat.debug("[getDescuentoMonto]: " + rs.getFloat(3));
					
				}				
				resultado =(DescuentoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), DescuentoDTO.class);
				cat.debug("Fin recuperacion de descuentos del cargo basico");
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar los descuentos del cargo basico",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}			
		} finally {
		 	if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (rs!=null)
					rs.close();
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
	 * @throws ProductDomainException
	 */
	public DescuentoDTO[] getDescuentoCargoConcepto(ParametrosDescuentoDTO entrada)
		throws ProductDomainException
	{
		cat.debug("Inicio:getDescuentoCargoConcepto()");
		DescuentoDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();
		ResultSet rs = null;
		try {
			String call = getSQLDatosServSupl("VE_servicios_venta_PG","VE_obtiene_descuento_con_PR",19);
			cat.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,entrada.getCodigoOperacion());
			cat.debug("getDescuentoCargoConcepto SS entrada.getCodigoOperacion():" + entrada.getCodigoOperacion() + "]");
			cstmt.setString(2,entrada.getCodigoAntiguedad());
			cat.debug("getDescuentoCargoConcepto SS entrada.getCodigoAntiguedad():" + entrada.getCodigoAntiguedad() + "]");
			cstmt.setString(3,entrada.getTipoContrato());
			cat.debug("getDescuentoCargoConcepto SS entrada.getTipoContrato():" + entrada.getTipoContrato() + "]");
			cstmt.setInt(4,Integer.parseInt(entrada.getNumeroMesesNuevo()));
			cat.debug("getDescuentoCargoConcepto SS entrada.getNumeroMesesNuevo():" + entrada.getNumeroMesesNuevo() + "]");
			cstmt.setInt(5,Integer.parseInt(entrada.getIndiceVentaExterna()));
			cat.debug("getDescuentoCargoConcepto SS entrada.getIndiceVentaExterna():" + entrada.getIndiceVentaExterna() + "]");
			cstmt.setLong(6,Long.parseLong(entrada.getCodigoVendedor()));
			cat.debug("getDescuentoCargoConcepto SS entrada.getCodigoVendedor():" + entrada.getCodigoVendedor() + "]");
			cstmt.setString(7,entrada.getCodigoCausaVenta());
			cat.debug("getDescuentoCargoConcepto SS entrada.getCodigoCausaVenta():" + entrada.getCodigoCausaVenta() + "]");
			cstmt.setString(8,entrada.getCodigoCategoria());
			cat.debug("getDescuentoCargoConcepto SS entrada.getCodigoCategoria():" + entrada.getCodigoCategoria() + "]");
			cstmt.setInt(9,Integer.parseInt(entrada.getCodigoModalidadVenta()));
			cat.debug("getDescuentoCargoConcepto SS entrada.getCodigoModalidadVenta():" + entrada.getCodigoModalidadVenta() + "]");
			cstmt.setInt(10,Integer.parseInt(entrada.getTipoPlanTarifario()));
			cat.debug("getDescuentoCargoConcepto SS entrada.getTipoPlanTarifario():" + entrada.getTipoPlanTarifario() + "]");
			cstmt.setLong(11,Long.valueOf(entrada.getConcepto()).longValue());
			cat.debug("getDescuentoCargoConcepto SS entrada.getConcepto():" + entrada.getConcepto() + "]");
			cstmt.setString(12,entrada.getClaseDescuento());
			cat.debug("getDescuentoCargoConcepto SS entrada.getClaseDescuento():" + entrada.getClaseDescuento() + "]");
			cstmt.setString(13,entrada.getCodigoCalificaion());
			cat.debug("getDescuentoCargoConcepto SS entrada.getCodigoCalificaion():" + entrada.getCodigoCalificaion() + "]");
			cstmt.setInt(14,entrada.getIndRenovacion());
			cat.debug("getDescuentoCargoConcepto SS entrada.getIndRenovacion():" + entrada.getIndRenovacion() + "]");
			cstmt.setInt(15,entrada.getIndRenovacion());
			cat.debug("getDescuentoCargoConcepto SS Ind PriSeg:"+entrada.getIndRenovacion() );

			
			cstmt.registerOutParameter(16,OracleTypes.CURSOR);
			//-- control error
			cstmt.registerOutParameter(17, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(18, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(19, java.sql.Types.NUMERIC);
			
			cstmt.execute();
			
			codError = cstmt.getInt(17);
			msgError = cstmt.getString(18);
			numEvento = cstmt.getInt(19);

			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar los descuentos del cargo");
				throw new ProductDomainException(
						"Ocurrió un error al recuperar los descuentos del cargo", String
								.valueOf(codError), numEvento, msgError);
				
			}else{
				cat.debug("Recuperando descuentos");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(16);
				while (rs.next()) {
					DescuentoDTO descuentoDTO = new DescuentoDTO();
					descuentoDTO.setTipoAplicacion(rs.getString(1));
					descuentoDTO.setCodMoneda(rs.getString(2));
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
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar los descuentos del cargo",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}			
		} finally {
		 	if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (rs!=null)
					rs.close();
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
	 * @throws ProductDomainException
	 */
	public DescuentoDTO getCodigoDescuentoManual(ParametrosDescuentoDTO entrada)
		throws ProductDomainException
	{
		cat.debug("Inicio:getCodigoDescuentoManual()");
		DescuentoDTO resultado = new DescuentoDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();
		try {
			String call = getSQLDatosServSupl("VE_servicios_venta_PG","VE_consulta_cod_desc_manual_PR",6);
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

			if (codError == 0) 
				resultado.setCodigoConcepto(String.valueOf(cstmt.getInt(3)));
			
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar el código de descuento manual",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof ProductDomainException ) throw (ProductDomainException) e;
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
		throws ProductDomainException
	{
		cat.debug("Inicio:getListaSSAbonadoParaCentral()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ServicioSuplementarioDTO[] resultado = null;
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();
		ResultSet rs = null;
		cat.debug("Coneccion obtenida OK");
		try {
			String call = getSQLDatosServSupl("VE_serv_suplem_abo_PG","VE_obtiene_SSabo_paracent_PR",11);
			
			cat.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);

			cstmt.setInt(1,Integer.parseInt(servicioSuplementario.getNumeroAbonado()));
			cat.debug("[getListaSSAbonadoParaCentral] num abonado: " + servicioSuplementario.getNumeroAbonado());
			cstmt.setInt(2,servicioSuplementario.getIndicadorEstado());
			cat.debug("[getListaSSAbonadoParaCentral] indicador estado: " + servicioSuplementario.getIndicadorEstado());
			cstmt.setString(3,servicioSuplementario.getCodigoProducto());
			cat.debug("[getListaSSAbonadoParaCentral] codigo producto: " + servicioSuplementario.getCodigoProducto());
			cstmt.setString(4,servicioSuplementario.getCodigoModulo());
			cat.debug("[getListaSSAbonadoParaCentral] codigo modulo: " + servicioSuplementario.getCodigoModulo());
			cstmt.setInt(5,servicioSuplementario.getCodigoSistema());
			cat.debug("[getListaSSAbonadoParaCentral] codigo sistema: " + servicioSuplementario.getCodigoSistema());
			cstmt.setString(6,servicioSuplementario.getCodigoActuacion());
			cat.debug("[getListaSSAbonadoParaCentral] codigo actuacion: " + servicioSuplementario.getCodigoActuacion());
			cstmt.setString(7,servicioSuplementario.getTipoTerminal());
			cat.debug("[getListaSSAbonadoParaCentral] tipo terminal: " + servicioSuplementario.getTipoTerminal());

			cstmt.registerOutParameter(8,OracleTypes.CURSOR);
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getListaSSAbonadoParaCentral:Execute");
			cstmt.execute();
			cat.debug("Fin:getListaSSAbonadoParaCentral:Execute");
			
			codError = cstmt.getInt(9);
			msgError = cstmt.getString(10);
			numEvento = cstmt.getInt(11);

			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar SS del abonado");
				throw new ProductDomainException("Ocurrió un error al recuperar SS del abonado", String
								.valueOf(codError), numEvento, msgError);
				
			}else{
				cat.debug("Recuperando SS del abonado");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(8);
				while (rs.next()) {
					ServicioSuplementarioDTO servicioSuplementarioDTO = new ServicioSuplementarioDTO();
					servicioSuplementarioDTO.setNumeroAbonado(servicioSuplementario.getNumeroAbonado());
					servicioSuplementarioDTO.setCodigoServicio(rs.getString(1));
					servicioSuplementarioDTO.setCodigoServSupl(rs.getString(2));
					servicioSuplementarioDTO.setCodigoNivel(rs.getString(3));
					servicioSuplementarioDTO.setCodigoConcepto(rs.getString(4));

					lista.add(servicioSuplementarioDTO);
				}				
				resultado =(ServicioSuplementarioDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), ServicioSuplementarioDTO.class);
		  
				cat.debug("Fin recuperacion de SS del abonado");
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar SS del abonado",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof ProductDomainException ) throw (ProductDomainException) e;
		} finally {
		 	if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (rs!=null)
					rs.close();
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:getListaSSAbonadoParaCentral()");
		return resultado;
    }

		/**
		 * Obtiene Listado de SS 
		 * @param entrada
		 * @return resultado
		 * @throws ProductDomainException
		 */
	 public ListadoSSOutDTO[] getListadoSS(ListadoSSInDTO servicioSuplementario) 
	 	throws ProductDomainException
	 {	   
		cat.debug("Inicio:getListadoSS()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ListadoSSOutDTO[] resultado = null;
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();
		ResultSet rs = null;
		cat.debug("Conexion obtenida OK");
		  try {
			   String call = getSQLDatosServSupl("Ve_Servs_ActivacionesWeb_Pg", "VE_getListServSupl_PR",8);
			   cat.debug("sql[" + call + "]");
			   
			   cstmt = conn.prepareCall(call);
		
			   cstmt.setString(1,servicioSuplementario.getCodigoPlan() );
			   cstmt.setString(2,servicioSuplementario.getIndCompatible());
			   cstmt.setString(3,servicioSuplementario.getCodTecnologica());
			   cstmt.setString(4,servicioSuplementario.getCodActAbo());
			   
			   cstmt.registerOutParameter(5,OracleTypes.CURSOR);
			   cstmt.registerOutParameter(6,java.sql.Types.NUMERIC);
			   cstmt.registerOutParameter(7,java.sql.Types.VARCHAR);
			   cstmt.registerOutParameter(8,java.sql.Types.NUMERIC);
			 
			   cat.debug("getListadoSS:Execute Antes");
			   cstmt.execute();
			   cat.debug("getListadoSS:Execute Despues");
			   
			   codError = cstmt.getInt(6);
			   msgError = cstmt.getString(7);
			   numEvento = cstmt.getInt(8);
			 
			   if (codError != 0) {
				   cat.error("Ocurrió un error al recuperar listado de SS ");
				   throw new ProductDomainException("Ocurrió un error al recuperar listado SS", String.valueOf(codError), 
						   numEvento, msgError);
			    
				}else{
					cat.debug("Recuperando listado de SS");
					ArrayList lista = new ArrayList();
					rs = (ResultSet) cstmt.getObject(5);
					while (rs.next()) {
						ListadoSSOutDTO listadoSSOutDTO = new ListadoSSOutDTO();
						listadoSSOutDTO.setCodigoServicio(rs.getString(1));
						listadoSSOutDTO.setCodigoGrupo(rs.getString(2));
						listadoSSOutDTO.setDescripServicio(rs.getString(3));
						listadoSSOutDTO.setCodigoNivel(rs.getString(4));
						listadoSSOutDTO.setIndSS(rs.getString(5));
						if (listadoSSOutDTO.getIndSS().equals("DEFAULT"))
						{
							listadoSSOutDTO.setIndSS("D");
						}
						else 
						{
							listadoSSOutDTO.setIndSS("O");
						}						
						listadoSSOutDTO.setTarifaConexion(rs.getString(6));
						listadoSSOutDTO.setMonedaConexion(rs.getString(7));
						listadoSSOutDTO.setTarifaMensual(rs.getString(8));
						listadoSSOutDTO.setMonedaMensual(rs.getString(9));
						listadoSSOutDTO.setIndIP(rs.getString(10));
						listadoSSOutDTO.setTipoCobro(rs.getString(11));
						listadoSSOutDTO.setTipoRed(rs.getString(12));
						
						lista.add(listadoSSOutDTO);
					}					
					resultado =(ListadoSSOutDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
						lista.toArray(), ListadoSSOutDTO.class);
			  
					cat.debug("Fin recuperacion de listado de SS");
				}
			   
			   if (cat.isDebugEnabled())
			    cat.debug(" Finalizo ejecución");
		  } catch (Exception e) {
		   cat.error("Ocurrió un error al obtener listado SS",e);
		   if (cat.isDebugEnabled()) {
		    cat.debug("Codigo de Error[" + codError + "]");
		    cat.debug("Mensaje de Error[" + msgError + "]");
		    cat.debug("Numero de Evento[" + numEvento + "]");
		   }
		  
		   if (e instanceof ProductDomainException ){           
			   	throw (ProductDomainException) e;
		   }
	   } finally {
		    if (cat.isDebugEnabled()) 
		    cat.debug("Cerrando conexiones...");
		    try {
			   if (rs!=null)
				   rs.close();
			   if (cstmt!=null)
			       cstmt.close();
			   if (!conn.isClosed()) {
			        conn.close();
			   }
		    } catch (SQLException e) {
		     cat.debug("SQLException", e);
		    }
	   }
	   cat.debug("getListadoSS():end");
	   return resultado;
	 }//fin getListadoSS

	 /**
		 * Obtiene inserta SS adicionales 
		 * @param ServicioSuplementarioDTO (entrada)
		 * @return ServicioSuplementarioDTO (resultado)
		 * @throws ProductDomainException
	 */	 
	public ServicioSuplementarioDTO insSSAdicionales(ServicioSuplementarioDTO entrada)
		throws ProductDomainException
	{
			ServicioSuplementarioDTO resultado = entrada;
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			conn = getConection();
			CallableStatement cstmt = null;
			try {
				cat.debug("Inicio:insSSAdicionales");

				String call = getSQLDatosServSupl("VE_serv_suplem_abo_PG","VE_insServSuplAdicionales_PR",8);
				cat.debug("sql[" + call + "]");
				
				cstmt = conn.prepareCall(call);
						   
				//-- PARAMETROS DE ENTRADA
				cstmt.setString(1,entrada.getNumeroAbonado());
				cstmt.setString(2,entrada.getCadenaCodServs());
				cstmt.setString(3,entrada.getNumeroTerminal());
				cstmt.setString(4,entrada.getNomUsuario());
				
				cat.debug("INGRESO insSSAdicionales DAO entrada.getNumeroAbonado() : " + entrada.getNumeroAbonado());
				cat.debug("INGRESO insSSAdicionales DAO entrada.getCadenaCodServs() : " + entrada.getCadenaCodServs());
				cat.debug("INGRESO insSSAdicionales DAO entrada.getNumeroTerminal() : " + entrada.getNumeroTerminal());
				cat.debug("INGRESO insSSAdicionales DAO entrada.getNomUsuario() : " + entrada.getNomUsuario());
				
				//-- PARAMETROS DE SALIDA
				cstmt.registerOutParameter(5,java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(6,java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(7,java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(8,java.sql.Types.NUMERIC);

				cat.debug("Inicio:insSSAdicionales:execute");				
				cstmt.execute();				
				cat.debug("Fin:insSSAdicionales:execute");

				codError=cstmt.getInt(6);
				msgError = cstmt.getString(7);
				numEvento=cstmt.getInt(8);
				
				cat.debug("INGRESO insSSAdicionales DAO codError : " + codError);
				cat.debug("INGRESO insSSAdicionales DAO msgError : " + msgError);
				cat.debug("INGRESO insSSAdicionales DAO numEvento : " + numEvento);
				
				if (codError != 0) {
					cat.error("Ocurrió un error al insertar servicios suplemetarios adicionales del abonado");
					if (cat.isDebugEnabled()) {
						cat.debug("Codigo de Error[" + codError + "]");
						cat.debug("Mensaje de Error[" + msgError + "]");
						cat.debug("Numero de Evento[" + numEvento + "]");
					}
					throw new ProductDomainException("Ocurrió un error al insertar servicios suplemetarios adicionales del abonado", String
									.valueOf(codError), numEvento, msgError);
				}
				else
					resultado.setCadenaServNivel(cstmt.getString(5));
			} catch (Exception e) {
				cat.error("Ocurrió un error al insertar servicios suplemetarios adicionales del abonado",e);
				if (e instanceof ProductDomainException ) throw (ProductDomainException) e;
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
			cat.debug("Fin:insSSAdicionales");
			return resultado;
	}//fin insSSAdicionales
	
	/**
	 * Obtiene lista de SS del abonado que no son enviados a centrales
	   para completar cadena clase servicio del abonado
	 * @param entrada
	 * @return resultado
	 * @throws ProductDomainException
	 */
	
	public ServicioSuplementarioDTO[] getSSAbonadoNoCentrales(ServicioSuplementarioDTO servicioSuplementario) 
		throws ProductDomainException
	{
		cat.debug("Inicio:getSSAbonadoNoCentrales()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ServicioSuplementarioDTO[] resultado = null;
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();
		ResultSet rs = null;
		cat.debug("Coneccion obtenida OK");
		try {
			String call = getSQLDatosServSupl("VE_serv_suplem_abo_PG","VE_obtiene_SSabo_nocent_PR",10);
			
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

			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar SS del abonado");
				throw new ProductDomainException(
						"Ocurrió un error al recuperar SS del abonado", String
								.valueOf(codError), numEvento, msgError);
				
			}else{
				cat.debug("Recuperando SS del abonado");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(7);
				while (rs.next()) {
					ServicioSuplementarioDTO servicioSuplementarioDTO = new ServicioSuplementarioDTO();
					servicioSuplementarioDTO.setCadSSNivel(rs.getString(1));
					cat.debug("setCadSSNivel   " + servicioSuplementarioDTO.getCodigoConcepto());
					lista.add(servicioSuplementarioDTO);
				}				
				resultado =(ServicioSuplementarioDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), ServicioSuplementarioDTO.class);
				cat.debug("Fin recuperacion de SS del abonado");
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar SS del abonado",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new ProductDomainException(
					"Ocurrió un error al recuperar SS del abonado",e);
		} finally {
		 	if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (rs!=null)
					rs.close();
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
	
	public PrecioCargoDTO[] getCargoServSuplCargoInstalacion(ServicioSuplementarioDTO entrada) 
		throws ProductDomainException
	{	
		cat.debug("Inicio:getCargoServSuplCargoAdicional()");
		PrecioCargoDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();
		ResultSet rs = null;
		try {
			String call = getSQLDatosServSupl("VE_servicios_venta_PG","VE_precio_cargo_servOc_PR",8);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			
			//-- PARAMETROS DE ENTRADA
			cstmt.setString(1,entrada.getCodigoProducto());
			cat.debug("entrada.getCodigoProducto():" + entrada.getCodigoProducto());
			cstmt.setString(2,entrada.getCodigoServicio());
			cat.debug("entrada.getCodigoServicio():" + entrada.getCodigoServicio());
			cstmt.setString(3,entrada.getCodigoPlanServicio());
			cat.debug("entrada.getCodigoPlanServicio():"+entrada.getCodigoPlanServicio());
			cstmt.setString(4,entrada.getCodigoActuacion());
			cat.debug("entrada.getCodigoActuacion():"+entrada.getCodigoActuacion());
			
			//-- PARAMETROS DE SALIDA
			cstmt.registerOutParameter(5,OracleTypes.CURSOR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getCargoServSuplCargoAdicional:Execute");
			cstmt.execute();
			cat.debug("Fin:getCargoServSuplCargoAdicional:Execute");
			
			codError = cstmt.getInt(6);
			msgError = cstmt.getString(7);
			numEvento = cstmt.getInt(8);

			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar cargo de instalacion");
				throw new ProductDomainException("Ocurrió un error al recuperar cargo de instalacion", String
								.valueOf(codError), numEvento, msgError);
				
			}else{
				cat.debug("Recuperando cargo instalacion");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(5);
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
				resultado =(PrecioCargoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), PrecioCargoDTO.class);
				
				cat.debug("Fin recuperacion cargo instalacion");
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar cargo instalacion",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof ProductDomainException ) throw (ProductDomainException) e;
		} finally {
		 	if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (rs!=null)
					rs.close();
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
	
	public ReglaSSDTO[] getReglasdeValidacionSS(ReglaSSDTO entrada) 
		throws ProductDomainException
	{	
		cat.debug("Inicio:getReglasdeValidacionSS()");
		ReglaSSDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();
		ResultSet rs = null;
		String mensajeError = "Ocurrió un error al obtener número de scoring asociado a la venta";
		try {
			String call = getSQLDatosServSupl("VE_parametros_comerciales_PG","VE_reglas_valid_vig_ss_pr",7);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			
			//-- PARAMETROS DE ENTRADA
			cstmt.setString(1,entrada.getCodCentral());
			cat.debug("entrada.getCodCentral():" + entrada.getCodCentral());
			cstmt.setString(2,entrada.getTipTerminal());
			cat.debug("entrada.getTipTerminal():" + entrada.getTipTerminal());
			cstmt.setString(3,entrada.getCodTecnologia());
			cat.debug("entrada.getCodTecnologia():"+entrada.getCodTecnologia());
			
			//-- PARAMETROS DE SALIDA
			cstmt.registerOutParameter(4,OracleTypes.CURSOR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getReglasdeValidacionSS:Execute");
			cstmt.execute();
			cat.debug("Fin:getReglasdeValidacionSS:Execute");
			
			codError = cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento = cstmt.getInt(7);
	
			if (codError != 0) {
				cat.error(mensajeError);
				throw new ProductDomainException(mensajeError, String.valueOf(codError), numEvento, msgError);
				
			}else{
				cat.debug("Recuperando cargo instalacion");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(4);
				while (rs.next()) {
					ReglaSSDTO reglaSSDTO = new ReglaSSDTO();
					reglaSSDTO.setCodProducto(rs.getInt(1));
					reglaSSDTO.setCodServicio(rs.getString(2));                                       
					reglaSSDTO.setCodServDef(rs.getString(3));
					reglaSSDTO.setNomUsuario(rs.getString(4));
					reglaSSDTO.setCodServOrig(rs.getString(5));
					reglaSSDTO.setTipoRelacion(rs.getInt(6));
					reglaSSDTO.setCodActAbo(rs.getString(7));
					lista.add(reglaSSDTO);
					cat.debug("ENCONTRO reglas asociadas a incompatibilidad de ss");
				}				
				resultado =(ReglaSSDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), ReglaSSDTO.class);
				
				cat.debug("Fin reglas ss");
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			cat.error(mensajeError,e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof ProductDomainException ) throw (ProductDomainException) e;
		} finally {
		 	if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (rs!=null)
					rs.close();
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
	}//fin getReglasdeValidacionSS
	 
	
}//fin ServicioSuplementarioDAO
