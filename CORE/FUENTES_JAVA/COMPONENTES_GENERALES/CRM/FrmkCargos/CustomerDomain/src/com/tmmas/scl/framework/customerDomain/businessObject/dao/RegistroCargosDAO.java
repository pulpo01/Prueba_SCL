package com.tmmas.scl.framework.customerDomain.businessObject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.StackTraceUtl;

import com.tmmas.scl.framework.customerDomain.businessObject.dao.interfaces.RegistroCargosDAOIT;
import com.tmmas.scl.framework.customerDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RegistroCargosDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerBillException;

public class RegistroCargosDAO extends ConnectionDAO implements RegistroCargosDAOIT{
	
	private final Logger logger = Logger.getLogger(RegistroCargosDAO.class);
	private Global global = Global.getInstance();
	
	private String getSQLInsertCargos(){
		StringBuffer call=new StringBuffer();
		call.append(" ");
		call.append(" DECLARE "); 
		call.append("  Cargo FA_CARGOS_QT := PV_INICIA_ESTRUCTURAS_PG.FA_CARGOS_SN_QT_FN;");
		call.append(" BEGIN ");
		call.append("  Cargo.SEQ_CARGO:=?;");         
		call.append("  Cargo.COD_CLIENTE:=?;");       
		call.append("  Cargo.COD_PRODUCTO:=?;");      
		call.append("  Cargo.COD_CONCEPTO:=?;");      
		call.append("  Cargo.IMP_CARGO:=?;");	       	
		call.append("  Cargo.COD_MONEDA:=?;");        
		call.append("  Cargo.COD_PLANCOM:=?;");    	
		call.append("  Cargo.NUM_UNIDADES:=?;");   	
		call.append("  Cargo.IND_FACTUR:=?;");     	
		call.append("  Cargo.NUM_TRANSACCION:=?;");	
		call.append("  Cargo.NUM_VENTA:=?; ");     	
		call.append("  Cargo.NUM_PAQUETE:=?;");    	
		call.append("  Cargo.NUM_ABONADO:=?; ");      
		call.append("  Cargo.NUM_TERMINAL:=?;");	
		call.append("  Cargo.COD_CICLFACT:=?;");	
		call.append("  Cargo.NUM_SERIE:=?;");   	
		call.append("  Cargo.NUM_SERIEMEC:=?;");	
		call.append("  Cargo.CAP_CODE:=?;");     	
		call.append("  Cargo.MES_GARANTIA:=?;"); 	
		call.append("  Cargo.NUM_PREGUIA:=?;");  	
		call.append("  Cargo.NUM_GUIA:=?;");          
		call.append("  Cargo.NUM_FACTURA:=?;");       
		call.append("  Cargo.COD_CONCEPTO_DTO:=?;");  
		call.append("  Cargo.VAL_DTO:=?;");
		call.append("  Cargo.TIP_DTO:=?;");      	
		call.append("  Cargo.COD_CONCEREL:=?;");      
		call.append("  Cargo.COLUMNA_REL:=?;");       
		call.append("  Cargo.IND_MANUAL:=?;");  	
		call.append("  Cargo.PREF_PLAZA:=?;");        
		call.append("  Cargo.COD_TECNOLOGIA:=?;");    
		call.append("  Cargo.NOM_USUARIO:=?;");	
		call.append("  Cargo.COD_PROD_CONTRATADO:=?;");
		call.append("  Cargo.ID_CARGO:=?;");   
		call.append("  FA_CARGOS_SN_PG.FA_CARGOS_ALTA_PR ( Cargo, ?, ?, ? );");
		 
		call.append("  END; ");
		return call.toString();
	}
	
	private String getSQLPackage(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
        for (int n = 1; n <= paramCount; n++) {
            sb.append("?");
            if (n < paramCount) sb.append(",");
        }
        return sb.append(")}").toString();
	}
	
	public void registraCargo(RegistroCargosDTO cargo) throws CustomerBillException{
		
		logger.debug("Inicio:registraCargo");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		//String call = getSQLPackage("PV_SERVICIOS_POSVENTA_PG","VE_inserta_cargo_PR",34);
		String call = getSQLInsertCargos();
		
		try{
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			cstmt = conn.prepareCall(call);
			/*-- entrada --*/
			logger.debug("Numero Cargo          [" + cargo.getNumeroCargo()+"]");
			cstmt.setLong(1,cargo.getNumeroCargo());
			logger.debug("Codigo Cliente        [" + Long.parseLong(cargo.getCodigoCliente())+"]");
			cstmt.setLong(2,Long.parseLong(cargo.getCodigoCliente()));
			logger.debug("Codigo Producto       [" + cargo.getCodigoProducto()+"]");
			cstmt.setInt(3,cargo.getCodigoProducto());
			logger.debug("Codigo Concepto Precio[" + cargo.getCodigoConceptoPrecio()+"]");
			cstmt.setInt(4,Integer.parseInt(cargo.getCodigoConceptoPrecio()));
			logger.debug("Importe Cargo         [" + cargo.getImporteCargo()+"]");
			cstmt.setFloat(5,cargo.getImporteCargo());
			logger.debug("Codigo Moneda         ["+cargo.getCodigoMoneda()+"]");
			cstmt.setString(6,cargo.getCodigoMoneda());
			logger.debug("Codigo Plan Comercial [" + cargo.getCodigoPlanComercial()+"]");
			cstmt.setLong(7,Long.parseLong(cargo.getCodigoPlanComercial()));
			logger.debug("Numero Unidades       [" + cargo.getNumeroUnidades()+"]");
			cstmt.setInt(8,cargo.getNumeroUnidades());
			logger.debug("IndiceCargoFacturable [" + cargo.getIndiceFacturacion()+"]");
			cstmt.setInt(9,cargo.getIndiceFacturacion());
			logger.debug("Numero Transaccion    [" + cargo.getNumeroTransaccion()+"]");
			cstmt.setLong(10,cargo.getNumeroTransaccion());
			logger.debug("Numero venta          [" + cargo.getNumeroVenta()+"]");
			cstmt.setLong(11,cargo.getNumeroVenta());
			logger.debug("Indicador nume Paquete[" + cargo.getNumeroPaquete()+"]");
			cstmt.setString(12,cargo.getNumeroPaquete());
			cstmt.setString(13,cargo.getNumAbonado());
			cstmt.setString(14,cargo.getNumeroTerminal());
			logger.debug("Cod Ciclo Facturacion [" + cargo.getCodigoCicloFacturacion()+"]");
			cstmt.setString(15,cargo.getCodigoCicloFacturacion());
			cstmt.setString(16, cargo.getNumeroSerie());
			cstmt.setString(17, cargo.getNumeroImei());
			cstmt.setString(18, null);
			logger.debug("Mes garantia          [" + cargo.getMesGarantia()+"]");
			cstmt.setInt(19,cargo.getMesGarantia());
			cstmt.setString(20, null);
			cstmt.setString(21, null);
			logger.debug("Numero factura        [" +  cargo.getNumeroFactura()+"]");
			cstmt.setLong(22, cargo.getNumeroFactura());
			logger.debug("Cod Concepto descuento[" + cargo.getCodigoConceptoDescuento()+"]");
			cstmt.setString(23, cargo.getCodigoConceptoDescuento());
			logger.debug("numero abonado:       [null]");
			logger.debug("numero terminal:      [null]");
			logger.debug("numero serie simcard: [null]");
			logger.debug("numero serie terminal:[null]");
			logger.debug("capcode:              [null]");
			logger.debug("num_preguia:          [null]");
			logger.debug("num_guia:             [null]");
			/*cargo.getNumAbonado()
			cargo.getNumeroTerminal()
			cargo.getNumeroSerie()
			cargo.getNumeroImei()*/

			if(cargo.getValorDescuento()==0){
				logger.debug("Valor Descuento[" + cargo.getValorDescuento()+"]");
				cstmt.setString(24, null);
				logger.debug("Tipo Descuento[" + cargo.getTipoDescuento()+"]");
				cstmt.setString(25, null);
			}else{
				logger.debug("Valor Descuento[" + cargo.getValorDescuento()+"]");
				cstmt.setFloat(24, cargo.getValorDescuento());
				logger.debug("Tipo Descuento[" + cargo.getTipoDescuento()+"]");
				cstmt.setString(25,  cargo.getTipoDescuento());
				
			}
			logger.debug("Indice Cuota[" + cargo.getIndiceCuota()+"]");
			cstmt.setString(26,cargo.getIndiceCuota());
			logger.debug("Indice Supertelefono[" + cargo.getIndiceSuperTelefono()+"]");
			cstmt.setInt(27,cargo.getIndiceSuperTelefono());
			logger.debug("indice manual[" + cargo.getIndiceManual()+"]");
			cstmt.setString(28, cargo.getIndiceManual());
			
			logger.debug("Prefijo Plaza[" + cargo.getPrefijoPlaza()+"]");
			if (cargo.getPrefijoPlaza() != null)
				cstmt.setString(29,cargo.getPrefijoPlaza());
			else
				cstmt.setString(29, " ");
				
			logger.debug("Codigo Tecnologia[" + cargo.getCodigoTecnologia()+"]");
			cstmt.setString(30,cargo.getCodigoTecnologia());
			logger.debug("Usuario[" + cargo.getNombreUsuario()+"]");
			cstmt.setString(31,cargo.getNombreUsuario());
			logger.debug("Cod_producto_contratado[" + cargo.getCodigoProducto()+"]");
			cstmt.setString(32,String.valueOf(cargo.getCodigoProducto()));
			logger.debug("Numero Cargo[" + cargo.getNumeroCargo()+"]");
			cstmt.setLong(33,cargo.getNumeroCargo());
			
			/*-- salida --*/
			cstmt.registerOutParameter(34, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(35, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(36, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:registraCargo:execute");
			cstmt.execute();
			logger.debug("Fin:registraCargo:execute");
			
			codError=cstmt.getInt(34);
			logger.debug("codError ["+codError+"]");
			msgError = cstmt.getString(35);
			logger.debug("msgError ["+msgError+"]");
			numEvento=cstmt.getInt(36);
			logger.debug("numEvento["+ numEvento + "]");
			
			if (codError != 0) {
				logger.error("Ocurrió un error al Registrar Los Cargos");
				throw new CustomerBillException(
						"Ocurrió un error al Registrar Los Cargos", String
								.valueOf(codError), numEvento, msgError);
			}
		}
		catch (Exception e) {
			logger.error("[Exception]Ocurrió un error general al registrar cargos", e);
			throw new CustomerBillException("[Exception]Ocurrió un error general al registrar cargos",e);
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
		logger.debug("registraCargo():end");
	}
	
	public RegistroCargosDTO getSecuenciaCargo(RegistroCargosDTO entrada) throws CustomerBillException{
		RegistroCargosDTO resultado=new RegistroCargosDTO();
		
		logger.debug("Inicio:getSecuenciaCargo");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		//conn = getConection();
		CallableStatement cstmt = null; 
		
		String call = getSQLPackage("VE_intermediario_PG","VE_OBTIENE_SECUENCIA_PR",5);
		
		try{
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			cstmt = conn.prepareCall(call);
			
			logger.debug("Variables de Entrada");
			logger.debug("Codigo Secuencia::"+entrada.getCodigoSecuencia());
			cstmt.setString(1, entrada.getCodigoSecuencia());
			
			logger.debug("Variables de Salida");
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			
			resultado.setNumeroCargo(cstmt.getLong(2));
			
			codError = cstmt.getInt(3);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(4);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(5);
			logger.debug("numEvento[" + numEvento + "]");
			
			
		} catch (CustomerBillException e) {
			logger.debug("CustomerBillException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al registrar cargos", e);
			throw new CustomerBillException("Ocurrió un error general al registrar cargos",e);
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
			logger.debug("getSecuenciaCargo():end");
		}
	return resultado ;
	}

}
