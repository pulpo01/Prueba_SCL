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
 * 01/06/07     Héctor Hermosilla      					Versión Inicial
 */
package com.tmmas.cl.scl.customerdomain.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.RegistroSolicitudesDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.helper.Global;

public class RegistroSolicitudesDAO extends ConnectionDAO{
	
private static Category cat = Category.getInstance(RegistroSolicitudesDAO.class);
	
	Global global = Global.getInstance();
	
	private Connection getConection() throws CustomerDomainException
	{
		Connection conn = null;
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
		} 
		catch (Exception e1) {
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
	}//fin getSQLPackage
	
	/**
	 * Crea solicitud de aprobación del rango de descuento asociado al vendedor en una venta. 
	 * @param registroSolicitudes
	 * @return 
	 * @throws CustomerDomainException
	 */
	
	public void crearSolicitud(RegistroSolicitudesDTO registroSolicitudes)
		throws CustomerDomainException
	{
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			cat.debug("Inicio:crearSolicitud");
			String call = getSQLPackage("VE_servicios_venta_PG","VE_ins_sol_autorizacion_PR",25);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cat.debug("Numero Venta: "+registroSolicitudes.getNumeroVenta());
			cstmt.setLong(1,registroSolicitudes.getNumeroVenta());
			cat.debug("Linea Autorización: "+registroSolicitudes.getLinAutoriza());
			cstmt.setLong(2,registroSolicitudes.getLinAutoriza());
			cat.debug("getCodigoOficina(): "+registroSolicitudes.getCodigoOficina());
			cstmt.setString(3,registroSolicitudes.getCodigoOficina());
			cat.debug("getCodigoEstado: "+registroSolicitudes.getCodigoEstado());
			cstmt.setString(4, registroSolicitudes.getCodigoEstado());
			cat.debug("getNumeroAutorizacion: "+registroSolicitudes.getNumeroAutorizacion());
			cstmt.setLong(5,registroSolicitudes.getNumeroAutorizacion());
			cat.debug("getCodigoVendedor: "+registroSolicitudes.getCodigoVendedor());
			cstmt.setLong(6,registroSolicitudes.getCodigoVendedor());
			cat.debug("getNumeroUnidades: "+registroSolicitudes.getNumeroUnidades());
			cstmt.setLong(7,registroSolicitudes.getNumeroUnidades());
			cat.debug("getPrecioOrigen: "+registroSolicitudes.getPrecioOrigen());
			cstmt.setDouble(8,registroSolicitudes.getPrecioOrigen());
			cat.debug("getIndiceTipoVenta: "+registroSolicitudes.getIndicadorTipoVenta());
			cstmt.setInt(9,registroSolicitudes.getIndicadorTipoVenta());
			cat.debug("getCodigoCliente: "+registroSolicitudes.getCodigoCliente());
			cstmt.setLong(10,registroSolicitudes.getCodigoCliente());
			cat.debug("getCodigoModalidadVenta: "+registroSolicitudes.getCodigoModalidadVenta());
			cstmt.setInt(11,registroSolicitudes.getCodigoModalidadVenta());
			cat.debug("getNombreUsuarioVenta: "+registroSolicitudes.getNombreUsuarioVenta());
			cstmt.setString(12,registroSolicitudes.getNombreUsuarioVenta());
			cat.debug("getCodigoConcepto: "+registroSolicitudes.getCodigoConcepto());
			cstmt.setInt(13,registroSolicitudes.getCodigoConcepto());
			cat.debug("getImporteCargo: "+registroSolicitudes.getImporteCargo());
			cstmt.setDouble(14,registroSolicitudes.getImporteCargo());
			cat.debug("getCodigoMoneda: "+registroSolicitudes.getCodigoMoneda());
			cstmt.setString(15,registroSolicitudes.getCodigoMoneda());
			cat.debug("getNumeroAbonado: "+registroSolicitudes.getNumeroAbonado());
			cstmt.setLong(16,registroSolicitudes.getNumeroAbonado());
			cat.debug("getNumeroSerie: "+registroSolicitudes.getNumeroSerie());
			cstmt.setString(17,registroSolicitudes.getNumeroSerie());
			cat.debug("getCodigoConceptoDescuento: "+registroSolicitudes.getCodigoConceptoDescuento());
			cstmt.setInt(18,registroSolicitudes.getCodigoConceptoDescuento());
			cat.debug("getValorDescuento: "+registroSolicitudes.getValorDescuento());
			cstmt.setFloat(19,registroSolicitudes.getValorDescuento());
			cat.debug("getTipoDescuento: "+registroSolicitudes.getTipoDescuento());
			cstmt.setInt(20,registroSolicitudes.getTipoDescuento());
			cat.debug("getIndiceModificacion: "+registroSolicitudes.getIndicadorModificacion());
			cstmt.setInt(21,registroSolicitudes.getIndicadorModificacion());
			cat.debug("getCodigoOrigen: "+registroSolicitudes.getCodigoOrigen());
			cstmt.setString(22,registroSolicitudes.getCodigoOrigen());
			cstmt.registerOutParameter(23, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(24, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(25, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:crearSolicitud:execute");
			cstmt.execute();
			cat.debug("Fin:crearSolicitud:execute");
			
			codError=cstmt.getInt(23);
			msgError = cstmt.getString(24);
			numEvento=cstmt.getInt(25);
			cat.debug("msgError[" + msgError + "]");
			if (codError!=0){
				cat.error("Ocurrió un error al guardar la solicitud de descuento");
				throw new CustomerDomainException(
						"Ocurrió un error al guardar la solicitud de descuento", String
								.valueOf(codError), numEvento, msgError);
			}
		} 
		catch (Exception e) {
			cat.error("Ocurrió un error al guardar la solicitud de descuento",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		} 
		finally {
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
		cat.debug("Fin:crearSolicitud");
	}
	
	public RegistroSolicitudesDTO consultaEstadoSolicitud(RegistroSolicitudesDTO registroSolicitudesDTO) 
		throws CustomerDomainException 
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			cat.debug("Inicio:consultaEstadoSolicitud");
			String call = getSQLPackage("VE_servicios_venta_PG","VE_con_sol_autorizacion_PR",5);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			
			cat.debug("getNumeroAutorizacion: " + registroSolicitudesDTO.getNumeroAutorizacion());
			cstmt.setLong(1,registroSolicitudesDTO.getNumeroAutorizacion());
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:consultaEstadoSolicitud:execute");
			cstmt.execute();
			cat.debug("Fin:consultaEstadoSolicitud:execute");
			
			codError=cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento=cstmt.getInt(5);
			cat.debug("msgError[" + msgError + "]");
			if (codError ==0){
				registroSolicitudesDTO.setCodigoEstado(cstmt.getString(2));
			}
		} 
		catch (Exception e) {
			cat.error("Ocurrió un error al consultar el estado de la solicitud",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		} 
		finally {
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
		cat.debug("Fin:consultaEstadoSolicitud");
		return registroSolicitudesDTO;
	}	
	

}
