package com.tmmas.cl.scl.ventadeaccesorios.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.PagoDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.helper.Global;

public class PagoDAO extends ConnectionDAO{
	private Global global = Global.getInstance();	
	private static Category cat = Category.getInstance(PagoDAO.class);

	private Connection getConection() throws GeneralException
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
	
	private String getSQLDatosPakages(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
		for (int n = 1; n <= paramCount; n++) {
			sb.append("?");
			if (n < paramCount) sb.append(",");
		}
		return sb.append(")}").toString();
	}//fin getSQLDatosAbonado	
	
	private String getSQLDatosProcedure(String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+procedureName+"(");
		for (int n = 1; n <= paramCount; n++) {
			sb.append("?");
			if (n < paramCount) sb.append(",");
		}
		return sb.append(")}").toString();
	}//fin getSQLDatosAbonado	
	
	public PagoDTO AplicaPago (PagoDTO pagoDTO) throws GeneralException {
		cat.info("AplicaPago():Inicio");		
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;		
		try
		{			
			//CSR-11002
//			String call = getSQLDatosProcedure("CE_APLICA_PAGO_PR",27);			
			String call = getSQLDatosProcedure("CE_APLICA_PAGO_QUIOSCO_PR",30);
			cat.debug("sql[" + call + "]");			
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,pagoDTO.getEmpRecaudadora());
			cat.debug("pagoDTO.getEmpRecaudadora() ["+pagoDTO.getEmpRecaudadora()+"]");
			
			cstmt.setString(2,pagoDTO.getCodCajaRecauda());
			cat.debug("pagoDTO.getCodCajaRecauda() ["+pagoDTO.getCodCajaRecauda()+"]");
			
			cstmt.setString(3,pagoDTO.getServSolicitado());
			cat.debug("pagoDTO.getServSolicitado() ["+pagoDTO.getServSolicitado()+"]");
			
			cstmt.setString(4,pagoDTO.getFecEfectividad());
			cat.debug("pagoDTO.getFecEfectividad() ["+pagoDTO.getFecEfectividad()+"]");
			
			cstmt.setString(5,pagoDTO.getNumTransaccion());
			cat.debug("pagoDTO.getNumTransaccion() ["+pagoDTO.getNumTransaccion()+"]");
			
			cstmt.setString(6,pagoDTO.getNomUsuarOra());
			cat.debug("pagoDTO.getNomUsuarOra() ["+pagoDTO.getNomUsuarOra()+"]");
			
			cstmt.setString(7,pagoDTO.getTipTransaccion());
			cat.debug("pagoDTO.getTipTransaccion() ["+pagoDTO.getTipTransaccion()+"]");
			
			cstmt.setString(8,pagoDTO.getSubTipoTransaccion());
			cat.debug("pagoDTO.getSubTipoTransaccion() ["+pagoDTO.getSubTipoTransaccion()+"]");
			
			cstmt.setString(9,pagoDTO.getCodServicio());
			cat.debug("pagoDTO.getCodServicio() ["+pagoDTO.getCodServicio()+"]");
			
			cstmt.setString(10,pagoDTO.getNumEjercicio());
			cat.debug("pagoDTO.getNumEjercicio() ["+pagoDTO.getNumEjercicio()+"]");
			
			cstmt.setString(11,pagoDTO.getCodCliente());
			cat.debug("pagoDTO.getCodCliente() ["+pagoDTO.getCodCliente()+"]");
			
			if (pagoDTO.getNumCelular().equals("")){
				cstmt.setNull(12, java.sql.Types.NULL);
			}else{
				cstmt.setString(12,pagoDTO.getNumCelular());
				cat.debug("pagoDTO.getNumCelular() ["+pagoDTO.getNumCelular()+"]");
			}			
			cstmt.setString(13,pagoDTO.getImportePago());
			cat.debug("pagoDTO.getImportePago() ["+pagoDTO.getImportePago()+"]");
			
			if (pagoDTO.getNumFolioCtc().equals("")){
				cstmt.setNull(14, java.sql.Types.NULL);
				cat.debug("pagoDTO.getNumFolioCtc() [NULL]");
			}else{
				cstmt.setString(14,pagoDTO.getNumFolioCtc());
				cat.debug("pagoDTO.getNumFolioCtc() ["+pagoDTO.getNumFolioCtc()+"]");
			}
			
			if (pagoDTO.getNumIdentificacion().equals("")){
				cstmt.setNull(15, java.sql.Types.NULL);
				cat.debug("pagoDTO.getNumIdentificacion() [NULL]");
			}else{
				cstmt.setString(15,pagoDTO.getNumIdentificacion());
				cat.debug("pagoDTO.getNumIdentificacion() ["+pagoDTO.getNumIdentificacion()+"]");
			}			
			cstmt.setString(16,pagoDTO.getTipValor());
			cat.debug("pagoDTO.getTipValor() ["+pagoDTO.getTipValor()+"]");
			
			if (pagoDTO.getNumDocumento().equals("")){
				cstmt.setNull(17, java.sql.Types.NULL);
				cat.debug("pagoDTO.getNumDocumento() [NULL]");
			}else{
				cstmt.setString(17,pagoDTO.getNumDocumento());
				cat.debug("pagoDTO.getNumDocumento() ["+pagoDTO.getNumDocumento()+"]");
			}	
			if (pagoDTO.getCodBanco().equals("")){
				cstmt.setNull(18, java.sql.Types.NULL);
				cat.debug("pagoDTO.getCodBanco() [NULL]");
			}else{
				cstmt.setString(18,pagoDTO.getCodBanco());
				cat.debug("pagoDTO.getCodBanco() ["+pagoDTO.getCodBanco()+"]");
			}
			if (pagoDTO.getCtaCorriente().equals("")){
				cstmt.setNull(19, java.sql.Types.NULL);
				cat.debug("pagoDTO.getCtaCorriente() [NULL]");
			}else{
				cstmt.setString(19,pagoDTO.getCtaCorriente());
				cat.debug("pagoDTO.getCtaCorriente() ["+pagoDTO.getCtaCorriente()+"]");
			}
			if (pagoDTO.getCodAutoriza().equals("")){
				cstmt.setNull(20, java.sql.Types.NULL);
				cat.debug("pagoDTO.getCodAutoriza() [NULL]");
			}else{
				cstmt.setString(20,pagoDTO.getCodAutoriza());
				cat.debug("pagoDTO.getCodAutoriza() ["+pagoDTO.getCodAutoriza()+"]");
			}
			if (pagoDTO.getNumTarjeta().equals("")){
				cstmt.setNull(21, java.sql.Types.NULL);
				cat.debug("pagoDTO.getNumTarjeta() [NULL]");
			}else{
				cstmt.setString(21,pagoDTO.getNumTarjeta());
				cat.debug("pagoDTO.getNumTarjeta() ["+pagoDTO.getNumTarjeta()+"]");
			}						
			cstmt.setString(24,pagoDTO.getCodOperacion());
			cat.debug("pagoDTO.getCodOperacion() ["+pagoDTO.getCodOperacion()+"]");
			if (pagoDTO.getNumVenta().equals("")){
				cstmt.setNull(25, java.sql.Types.NULL);
				cat.debug("pagoDTO.getNumVenta() [NULL]");
			}else{
				cstmt.setString(25,pagoDTO.getNumVenta());
				cat.debug("pagoDTO.getNumVenta() ["+pagoDTO.getNumVenta()+"]");
			}
			if (pagoDTO.getNumFolio().equals("")){
				cstmt.setNull(26, java.sql.Types.NULL);
				cat.debug("pagoDTO.getNumFolio() [NULL]");
			}else{
				cstmt.setString(26,pagoDTO.getNumFolio());
				cat.debug("pagoDTO.getNumFolio() ["+pagoDTO.getNumFolio()+"]");
			}
			if (pagoDTO.getCodPlanSrv().equals("")){
				cstmt.setNull(27, java.sql.Types.NULL);
				cat.debug("pagoDTO.getCodPlanSrv() [NULL]");
			}else{
				cstmt.setString(27,pagoDTO.getCodPlanSrv());
				cat.debug("pagoDTO.getCodPlanSrv() ["+pagoDTO.getCodPlanSrv()+"]");
			}
			
			//INICIO CSR-11002
			cstmt.setString(28, pagoDTO.getNumTransaccionEmp());
			cat.debug("pagoDTO.getNumTransaccionEmp() ["+pagoDTO.getNumTransaccionEmp()+"]");
			
			cstmt.setString(29, pagoDTO.getDesAgencia());
			cat.debug("pagoDTO.getDesAgencia() ["+pagoDTO.getDesAgencia()+"]");
			
			cstmt.setString(30, pagoDTO.getCodTipTarjeta());
			cat.debug("pagoDTO.getCodTipTarjeta() ["+pagoDTO.getCodTipTarjeta()+"]");
			//FIN CSR-11002
			
			cstmt.registerOutParameter(22,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(23,java.sql.Types.VARCHAR);
			
			cat.debug("Inicio:AplicaPago:execute");
			cstmt.execute();
			cat.debug("Fin:AplicaPago:execute");
			
			pagoDTO.setResultado(cstmt.getString(22));
			cat.debug("pagoDTO.setResultado("+cstmt.getString(22)+")");
			pagoDTO.setDescripcion(cstmt.getString(23));
			cat.debug("pagoDTO.setDescripcion("+cstmt.getString(23)+")");

		}catch (Exception e) {
			cat.error("Ocurrió un error al aplicar pago",e);		
			throw new GeneralException(
					"Ocurrió un error al aplicar pago",e);
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
		cat.debug("Fin:AplicaPago");
		return pagoDTO;
	}	
	
	
	
	public PagoDTO getEmpRecaudadora (PagoDTO pago) throws GeneralException {
		cat.info("AplicaPago():Inicio");		
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;		
		try
		{	
			
			String call = getSQLDatosPakages("ve_venta_accesorios_pg", "ve_sel_emp_recaudador_pr", 11);			
			   						
			cstmt = conn.prepareCall(call);
			cat.debug("sql[" + call + "]");
			
			cstmt.setString(1,pago.getCodCajaRecauda());
			cat.debug("pago.getCodCajaRecauda() ["+pago.getCodCajaRecauda()+"]");
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);			
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);
						
			cat.debug("Inicio:getEmpRecaudadora:execute");
			cstmt.execute();
			cat.debug("Fin:getEmpRecaudadora:execute");

			codError  = cstmt.getInt(9);
			msgError  = cstmt.getString(10);
			numEvento = cstmt.getInt(11);

			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				cat.error("Ocurrió un error en udpGaIntarcel");				
				throw new GeneralException(
						"Ocurrió un error en udpGaIntarcel", String
						.valueOf(codError), numEvento, msgError);
			}else{				
				pago.setEmpRecaudadora(cstmt.getString(2));
			}
			

		}catch (GeneralException e) {
			throw e;
		}catch (Exception e) {
			cat.error("Ocurrió un error al aplicar pago",e);		
			throw new GeneralException(
					"Ocurrió un error al aplicar pago",e);
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
		cat.debug("Fin:AplicaPago");
		return pago;
	}	

}
