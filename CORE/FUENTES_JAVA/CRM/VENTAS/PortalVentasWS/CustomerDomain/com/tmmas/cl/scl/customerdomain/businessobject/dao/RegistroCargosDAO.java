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
 * 19/04/2007     Héctor Hermosilla      					Versión Inicial
 */
package com.tmmas.cl.scl.customerdomain.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import oracle.jdbc.OracleTypes;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.scl.commonbusinessentities.dto.DetalleCargosSolicitudDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ConversionMonetariaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.RegistroCargosDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.helper.Global;

public class RegistroCargosDAO extends ConnectionDAO {
	private static Category cat = Category.getInstance(RegistroCargosDAO.class);

	Global global = Global.getInstance();
	
	private Connection getConection() throws CustomerDomainException
	{
		Connection conn = null;
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
		} catch (Exception e1) {
			conn = null;
			cat.error(" No se pudo obtener una conexión ", e1);
			throw new CustomerDomainException("No se pudo obtener una conexión", e1);
		}
		return conn;
	}//fin getConection

	private String getSQLPackage(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
        for (int n = 1; n <= paramCount; n++) {
            sb.append("?");
            if (n < paramCount) sb.append(",");
        }
        return sb.append(")}").toString();
	}//fin getSQLDatosAbonado
	
	/**
	 * Registra Cargo de la venta
	 * @param cargo
	 * @return
	 * @throws CustomerDomainException
	 */

	// TODO: Cambiar una vez que se encuentre la solucion definitiva, se sincroniza temporalmente por problemas de concurrencia
	public synchronized void registraCargo(RegistroCargosDTO cargo)
		throws CustomerDomainException
	{	
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			cat.debug("Inicio:registraCargo");
			
			String call = getSQLPackage("VE_servicios_venta_PG","VE_inserta_cargo_PR",34);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			/*-- entrada --*/
			cat.debug("Numero Cargo: " + cargo.getNumeroCargo());
			cstmt.setLong(1,cargo.getNumeroCargo());
			cat.debug("codigo Cliente: " + Long.parseLong(cargo.getCodigoCliente()));
			cstmt.setLong(2,Long.parseLong(cargo.getCodigoCliente()));
			cat.debug("codigo Producto: " + cargo.getCodigoProducto());
			cstmt.setInt(3,cargo.getCodigoProducto());
			cat.debug("codigo Concepto Precio: " + cargo.getCodigoConceptoPrecio());
			cstmt.setInt(4,Integer.parseInt(cargo.getCodigoConceptoPrecio()));
			cat.debug("Importe Cargo: " + cargo.getImporteCargo());
			cstmt.setFloat(5,cargo.getImporteCargo());
			cat.debug("Codigo Moneda: "+cargo.getCodigoMoneda());
			cstmt.setString(6,cargo.getCodigoMoneda());
			cat.debug("Codigo Plan Comercial: " + cargo.getCodigoPlanComercial());
			cstmt.setLong(7,Long.parseLong(cargo.getCodigoPlanComercial()));
			cat.debug("Numero Unidades: " + cargo.getNumeroUnidades());
			cstmt.setInt(8,cargo.getNumeroUnidades());
			cat.debug("indiceCargoFacturable: " + cargo.getIndiceFacturacion());
			cstmt.setInt(9,cargo.getIndiceFacturacion());
			cat.debug("Numero Transaccion: " + cargo.getNumeroTransaccion());
			cstmt.setLong(10,cargo.getNumeroTransaccion());
			cat.debug("Numero venta: " + cargo.getNumeroVenta());
			cstmt.setLong(11,cargo.getNumeroVenta());
			cat.debug("Indicador numero Paquete: " + cargo.getNumeroPaquete());
			cstmt.setString(12,cargo.getNumeroPaquete());
			cat.debug("numero abonado: null");
			cstmt.setString(13,String.valueOf(cargo.getNum_abonado()));
			cat.debug("numero terminal: null");
			cstmt.setString(14,String.valueOf(cargo.getNum_terminal()));
			cat.debug("cod Ciclo Facturacion: " + cargo.getCodigoCicloFacturacion());
			cstmt.setInt(15,cargo.getCodigoCicloFacturacion());
			cat.debug("numero serie simcard: null");
			
			if( cargo.getNum_serie() != null ){
				cstmt.setString(16, cargo.getNum_serie());
			}else cstmt.setString(16, null);
			
			cat.debug("numero serie terminal: null");
			cstmt.setString(17, null);
			cat.debug("capcode: null");
			cstmt.setString(18, null);
			cat.debug("mes garantia: " + cargo.getMesGarantia());
			cstmt.setInt(19,cargo.getMesGarantia());
			cat.debug("num_preguia: null");
			cstmt.setString(20, null);
			cat.debug("num_guia: null");
			cstmt.setString(21, null);
			cat.debug("numero factura: " +  cargo.getNumeroFactura());
			cstmt.setLong(22, cargo.getNumeroFactura());
			cat.debug("Codigo Concepto descuento:" + cargo.getCodigoConceptoDescuento());
			cstmt.setString(23, cargo.getCodigoConceptoDescuento());
			
			
			if(cargo.getValorDescuento()==0){
				cat.debug("Valor Descuento: " + cargo.getValorDescuento());
				cstmt.setString(24, null);
				cat.debug("Tipo Descuento: " + cargo.getTipoDescuento());
				cstmt.setString(25, null);
			}else{
				cat.debug("Valor Descuento: " + cargo.getValorDescuento());
				cstmt.setFloat(24, cargo.getValorDescuento());
				cat.debug("Tipo Descuento: " + cargo.getTipoDescuento());
				cstmt.setString(25,  cargo.getTipoDescuento());
				
			}
			
			
			
			
			cat.debug("Indice Cuota: " + cargo.getIndiceCuota());
			cstmt.setString(26,cargo.getIndiceCuota());
			cat.debug("Indice Supertelefono: " + cargo.getIndiceSuperTelefono());
			cstmt.setInt(27,cargo.getIndiceSuperTelefono());
			cat.debug("indice manual: " + cargo.getIndiceManual());
			cstmt.setString(28, cargo.getIndiceManual());
			cat.debug("Prefijo Plaza: " + cargo.getPrefijoPlaza());
			cstmt.setString(29,cargo.getPrefijoPlaza());
			cat.debug("Codigo Tecnologia: " + cargo.getCodigoTecnologia());
			cstmt.setString(30,cargo.getCodigoTecnologia());
			cat.debug("Usuario: " + cargo.getNombreUsuario());
			cstmt.setString(31,cargo.getNombreUsuario());
			/*-- salida --*/
			cstmt.registerOutParameter(32, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(33, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(34, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:registraCargo:execute");			
			cstmt.execute();			
			cat.debug("Fin:registraCargo:execute");
			
			codError=cstmt.getInt(32);
			msgError = cstmt.getString(33);
			numEvento=cstmt.getInt(34);
			cat.debug("msgError[" + msgError + "]");
					
		} catch (Exception e) {
			cat.error("Ocurrió un error al insertar el Cargo",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
				cat.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				cat.debug("SQLException", e);
		  }
		}
		cat.debug("Fin:registraCargo");
	}
	
	public RegistroCargosDTO getSecuenciaCargo(RegistroCargosDTO entrada) 
		throws CustomerDomainException
	{
		RegistroCargosDTO resultado=new RegistroCargosDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:getSecuenciaCargo");
			
			String call = getSQLPackage("VE_intermediario_PG","VE_OBTIENE_SECUENCIA_PR",5);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,entrada.getCodigoSecuencia());
			cat.debug("getCodigoSecuencia: " + entrada.getCodigoSecuencia());
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getSecuenciaCargo:execute");
			cstmt.execute();
			cat.debug("Fin:getSecuenciaCargo:execute");

			codError=cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento=cstmt.getInt(5);
			cat.debug("msgError[" + msgError + "]");
			cat.debug("Codigo de Error[" + codError + "]");
			if (codError==0){
				cat.debug("Numero Cargo: " + cstmt.getString(2));
				resultado.setNumeroCargo(Long.parseLong(cstmt.getString(2)));
			}
			else{
				cat.error("Ocurrió un error al obtener la secuencia del Cargo");
				throw new CustomerDomainException(
						"Ocurrió un error al obtener la secuencia del Cargo", String
								.valueOf(codError), numEvento, msgError);
			}

			
			
		
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener la secuencia del Cargo",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
				cat.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				cat.debug("SQLException", e);
		  }
		}

		cat.debug("Fin:getSecuenciaCargo");

		return resultado;
	}
	
	public Long getCantidadCargosXVenta(Long numVenta) 
		throws CustomerDomainException
	{
		Long resultado=null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:getCantidadCargosXVenta");
			
			String call = getSQLPackage("VE_servicios_venta_PG","VE_ConsultaCargos_PR",5);
	
			cat.debug("sql[" + call + "]");
	
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1,numVenta.longValue());
			cat.debug("numVenta: " + numVenta.longValue());		
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getCantidadCargosXVenta:execute");
			cstmt.execute();
			cat.debug("Fin:getCantidadCargosXVenta:execute");
	
			codError=cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento=cstmt.getInt(5);
			cat.debug("msgError[" + msgError + "]");
			cat.debug("Codigo de Error[" + codError + "]");
			if (codError==0){
				cat.debug("Cantidad Cargos: " + cstmt.getLong(2));
				resultado = new Long(cstmt.getLong(2));
			}
			else{
				cat.error("Ocurrió un error al obtener la cantidad de cargos asociados a la venta");
				throw new CustomerDomainException(
						"Ocurrió un error al obtener la cantidad de cargos asociados a la venta", String
								.valueOf(codError), numEvento, msgError);
			}
		
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener la cantidad de cargos asociados a la venta",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
				cat.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				cat.debug("SQLException", e);
		  }
		}
		cat.debug("Fin:getCantidadCargosXVenta");
		return resultado;
	}

	public void insertaCargosOverride(DetalleCargosSolicitudDTO entrada) throws CustomerDomainException {
		cat.info("insertaCargosOverride, inicio");
		cat.debug(entrada.toString());
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		final String nombrePackage = "GE_OVERRIDE_PG";
		final String nombrePLSQL = "GE_INS_OVERRIDE_PR";
		final int cantidadParametros = 18;
		try {
			String call = getSQLPackage(nombrePackage, nombrePLSQL, cantidadParametros);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, entrada.getCodCliente());
			cstmt.setLong(2, entrada.getNumAbonado());
			cstmt.setString(3, entrada.getCodOrigenTransaccion());
			cstmt.setString(4, entrada.getTipoServicio());
			cstmt.setFloat(5, entrada.getCodProductoContratado());
			cstmt.setLong(6, entrada.getCodCargoContratado());
			cstmt.setString(7, entrada.getCodPlantarif());
			cstmt.setString(8, entrada.getCodCargoBasico());
			cstmt.setString(9, entrada.getCodServicio());
			cstmt.setDouble(10, entrada.getCargos());
			cstmt.setDouble(11, entrada.getImporteOverride().doubleValue());
			cstmt.setString(12, entrada.getCodMoneda());
			cstmt.setLong(13, entrada.getCodConcepto());
			cstmt.setLong(14, entrada.getNumVenta());
			cstmt.setString(15, entrada.getNomUsuarora());

			cstmt.registerOutParameter(16, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(18, java.sql.Types.NUMERIC);

			cat.debug("cstmt.execute(), antes");
			cstmt.execute();
			cat.debug("cstmt.execute(), despues");

			codError = cstmt.getInt(16);
			msgError = cstmt.getString(17);
			numEvento = cstmt.getInt(18);
			cat.debug("msgError[" + msgError + "]");
		}
		catch (Exception e) {
			cat.error("Ocurrió un error al insertar el Cargo Override", e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		}
		finally {
			cat.debug("Cerrando conexiones...");
			try {
				cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.info("insertaCargosOverride, fin");
	}
	
//FIN MERGE
	
	/**
	 * @author mwn40031
	 * @param numVenta
	 * @return
	 * @throws CustomerDomainException
	 */
	public DetalleCargosSolicitudDTO[] recuperaCargosOverride(Long numVenta, String codOrigenTransaccion)
		throws CustomerDomainException 
	{
		cat.debug("Inicio: recuperaCargosOverride");
		DetalleCargosSolicitudDTO[] r = null;
		final String nombrePackage = "GE_OVERRIDE_PG";
		final String nombrePLSQL = "GE_REC_OVERRIDE_PR";
		final int numeroParametrosPLSQL = 6;
		Connection conn = getConection();
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ResultSet rs = null;

		try {
			String call = getSQLPackage(nombrePackage, nombrePLSQL, numeroParametrosPLSQL);
			cat.debug("sql [" + call + "]");
			cstmt = conn.prepareCall(call);

			//VT
			cstmt.setLong(1, numVenta.longValue());
			cat.debug("numVenta: " + numVenta);
			cstmt.setString(2, codOrigenTransaccion);
			cat.debug("codOrigenTransaccion: " + codOrigenTransaccion);
			cstmt.registerOutParameter(3, OracleTypes.CURSOR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

			cat.debug("Antes de cstmt.execute()");
			cstmt.execute();
			cat.debug("Después de cstmt.execute()");

			codError = cstmt.getInt(4);
			cat.debug("codError [" + codError + "]");
			msgError = cstmt.getString(5);
			cat.debug("msgError [" + msgError + "]");
			numEvento = cstmt.getInt(6);
			cat.debug("numEvento [" + numEvento + "]");

			if (codError != 0) {
				throw new CustomerDomainException("Ocurrió un error al ejecutar recuperaCargosOverride", String
						.valueOf(codError), numEvento, msgError);
			}

			rs = (ResultSet) cstmt.getObject(3);
		
			ArrayList lista = new ArrayList();
			while (rs.next()) {
				DetalleCargosSolicitudDTO dto = new DetalleCargosSolicitudDTO();
				dto.setCodCliente(rs.getLong(1));
				dto.setNumAbonado(rs.getLong(2));
				dto.setCodOrigenTransaccion(rs.getString(3));
				dto.setTipoServicio(rs.getString(4));
				dto.setCodProductoContratado(rs.getLong(5));
				dto.setCodCargoContratado(rs.getLong(6));
				dto.setCodPlantarif(rs.getString(7));
				dto.setCodCargoBasico(rs.getString(8));
				dto.setCodServicio(rs.getString(9));
				dto.setCargos(rs.getDouble(10));
				dto.setImporteOverride(new Double(rs.getDouble(11)));
				dto.setCodMoneda(rs.getString(12));
				dto.setCodConcepto(rs.getLong(13));
				dto.setNumVenta(rs.getLong(14));				
				dto.setNomUsuarora(rs.getString(16));
				lista.add(dto);
			}
			r = (DetalleCargosSolicitudDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(),
					DetalleCargosSolicitudDTO.class);
		}
		catch (Exception e) {
			cat.error("Ocurrió un error al ejecutar recuperaCargosOverride", e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error [" + codError + "]");
				cat.debug("Mensaje de Error [" + msgError + "]");
				cat.debug("Numero de Evento [" + numEvento + "]");
			}
		}
		finally {
			cat.debug("Cerrando conexiones...");
			try {
				cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin: recuperaCargosOverride");
		return r;
	}
	
	public Float convertirMontoMonedaLocal(ConversionMonetariaDTO entrada) 
		throws CustomerDomainException
	{
		Float resultado=null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:convertirMontoMonedaLocal");
			
			String call = getSQLPackage("GA_CONVERSION_MONETARIA_PG","GA_CONVIERTE_MONTO_PR",7);
	
			cat.debug("sql[" + call + "]");
	
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1,entrada.getCodCliente());
			cat.debug("codCliente: " + entrada.getCodCliente());		
			cstmt.setFloat(2,entrada.getTotalCargosOrigen());
			cat.debug("totalCargosOrigen(): " + entrada.getTotalCargosOrigen());
			cstmt.setString(3,entrada.getFechaOrigen());
			cat.debug("fechaOrigen: " + entrada.getFechaOrigen());			
			
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:convertirMontoMonedaLocal:execute");
			cstmt.execute();
			cat.debug("Fin:convertirMontoMonedaLocal:execute");
	
			codError=cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento=cstmt.getInt(7);
			cat.debug("msgError[" + msgError + "]");
			cat.debug("Codigo de Error[" + codError + "]");
			if (codError==0){
				cat.debug("Monto convertido: " + cstmt.getLong(4));
				resultado = new Float(cstmt.getLong(4));
			}
			else{
				cat.error("Ocurrió un error realizar la conversion monetaria");
				throw new CustomerDomainException(
						"Ocurrió un error realizar la conversion monetaria", String
								.valueOf(codError), numEvento, msgError);
			}
		
		} catch (Exception e) {
			cat.error("Ocurrió un error realizar la conversion monetaria",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
				cat.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				cat.debug("SQLException", e);
		  }
		}
	
		cat.debug("Fin:convertirMontoMonedaLocal");
	
		return resultado;
	}
}
