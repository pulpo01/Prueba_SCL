package com.tmmas.scl.framework.customerDomain.businessObject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.scl.framework.customerDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RegistroDetPreliquidacionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RegistroPreliquidacionDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerBillException;


public class RegistroDetPreliquidacionDAO extends ConnectionDAO {
	private static Category cat = Category.getInstance(RegistroPreliquidacionDAO.class);
	Global global = Global.getInstance();

	private Connection getConection() throws CustomerBillException
	{
		Connection conn = null;
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
		} 
		catch (Exception e1) {
			conn = null;
			cat.error(" No se pudo obtener una conexión ", e1);
			throw new CustomerBillException("No se pudo obtener una conexión", e1);
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
	
	public void registraDetallePreliquidacion(RegistroDetPreliquidacionDTO detpreliquidacion,RegistroPreliquidacionDTO cabpreliquidacion)throws CustomerBillException{
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			cat.debug("Inicio:registraDetallePreliquidacion");
			String call = getSQLPackage("PV_SERVICIOS_POSVENTA_PG","VE_in_ga_det_preliq_PR",13);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cat.debug("Numero Venta:"+cabpreliquidacion.getNumeroVenta());
			cstmt.setLong(1,cabpreliquidacion.getNumeroVenta());
			cat.debug("Numero Item:"+detpreliquidacion.getNumItem());
			cstmt.setInt(2,detpreliquidacion.getNumItem());
			cat.debug("Numero Abonado:"+detpreliquidacion.getNumeroAbonado());
			cstmt.setLong(3,detpreliquidacion.getNumeroAbonado());
			cat.debug("Numero Celular:"+detpreliquidacion.getNumeroCelular());
			cstmt.setLong(4,detpreliquidacion.getNumeroCelular());
			cat.debug("Numero Serie:"+detpreliquidacion.getNumeroSerie());
			cstmt.setString(5,detpreliquidacion.getNumeroSerie());
			cat.debug("Importe Cargo:"+detpreliquidacion.getImporteCargo());
			cstmt.setDouble(6,detpreliquidacion.getImporteCargo());
			cat.debug("Importe Final Cargo:"+detpreliquidacion.getImporteCargoFinal());
			cstmt.setDouble(7,detpreliquidacion.getImporteCargoFinal());
			cat.debug("Codigo Articulo:"+detpreliquidacion.getCodigoArticulo());
			cstmt.setDouble(8,detpreliquidacion.getCodigoArticulo());
			cat.debug("Tipo Descuento:"+detpreliquidacion.getTipoDescuento());
			cstmt.setDouble(9,detpreliquidacion.getTipoDescuento());
			cat.debug("Valor Descuento:"+detpreliquidacion.getValorDescuento());
			cstmt.setDouble(10,detpreliquidacion.getValorDescuento());
			
			cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(13, java.sql.Types.NUMERIC);
			cat.debug("Inicio:registraDetallePreliquidacion:execute");
			cstmt.execute();
			cat.debug("Fin:registraDetallePreliquidacion:execute");
			
			codError=cstmt.getInt(11);
			msgError = cstmt.getString(12);
			numEvento=cstmt.getInt(13);
			cat.debug("msgError[" + msgError + "]");
		} 
		catch (Exception e) {
			cat.error("Ocurrió un error al insertar detalle de preliquidacion",e);
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
		cat.debug("Fin:registraDetallePreliquidacion");
	}

	
	public ArrayList getMercaderiaEnConsignacion(RegistroPreliquidacionDTO preliquidacion) throws CustomerBillException{
		cat.debug("getMercaderiaEnConsignacion");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ArrayList lista = new ArrayList();
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		cat.debug("Coneccion obtenida OK");
		try {
			String call  = getSQLPackage("PV_SERVICIOS_POSVENTA_PG","VE_obtiene_articulos_consig_PR",5);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1,preliquidacion.getNumeroVenta());
			cstmt.registerOutParameter(2,OracleTypes.CURSOR);
			cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);
			cat.debug("Inicio:getMercaderiaEnConsignacion:Execute");
			cstmt.execute();
			cat.debug("Fin:getMercaderiaEnConsignacion:Execute");
			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			cat.debug("Recuperando mercaderia en consignacion");
			ResultSet rs = (ResultSet) cstmt.getObject(2);
			while (rs.next()) {
				RegistroDetPreliquidacionDTO registroDTO = new RegistroDetPreliquidacionDTO();
				registroDTO.setNumeroVenta(rs.getLong(1));
				registroDTO.setNumeroAbonado(rs.getLong(2));
				registroDTO.setNumeroCelular(rs.getLong(3));
				registroDTO.setNumeroSerie(rs.getString(4));
				registroDTO.setCodigoArticulo(rs.getInt(5));
				lista.add(registroDTO);
			}
			rs.close();
			cat.debug("Fin recuperacion formas de pago");
			
		}
		catch (Exception e) {
				cat.error("Ocurrió un error al formas de pago para la venta",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new CustomerBillException(
					"Ocurrió un error al recuperar formas de pago para la venta",e);
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
		cat.debug("Fin:getMercaderiaEnConsignacion()");

		return lista;
	}//fin getMercaderiaEnConsignacion

	
	
}
