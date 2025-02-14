package com.tmmas.scl.framework.customerDomain.businessObject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.scl.framework.customerDomain.businessObject.dao.interfaces.RegistroVentaDAOIT;
import com.tmmas.scl.framework.customerDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.CelularDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosGeneralesDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosRegistroCargosDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerBillException;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegistroVentaDTO;


public class RegistroVentaDAO extends ConnectionDAO implements RegistroVentaDAOIT{
	private final Logger logger = Logger.getLogger(RegistroVentaDAO.class);
	Global global = Global.getInstance();
	
	private Connection getConection() throws CustomerBillException
	{
		Connection conn = null;
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
		} catch (Exception e1) {
			conn = null;
			logger.error(" No se pudo obtener una conexión ", e1);
			throw new CustomerBillException("No se pudo obtener una conexión", e1);
		}
		return conn;
	}
	
	
	private String getSQLDatosVenta(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
        for (int n = 1; n <= paramCount; n++) {
            sb.append("?");
            if (n < paramCount) sb.append(",");
        }
        return sb.append(")}").toString();
	}
	
	/**
	 * Obtiene secuencia de la venta
	 * @param parametroEntrada
	 * @return resultado
	 * @throws CustomerBillException
	 */
	
	public RegistroVentaDTO getSecuenciaVenta(RegistroVentaDTO parametroEntrada) throws CustomerBillException{
		RegistroVentaDTO resultado=new RegistroVentaDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:getSecuenciaVenta");
			
			String call = getSQLDatosVenta("VE_intermediario_PG","VE_OBTIENE_SECUENCIA_PR",5);
			
			logger.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,parametroEntrada.getCodigoSecuencia());
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getSecuenciaVenta:execute");
			cstmt.execute();
			logger.debug("Fin:getSecuenciaVenta:execute");
			
			codError=cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento=cstmt.getInt(5);
			logger.debug("msgError[" + msgError + "]");
			
			resultado.setNumeroVenta(Long.parseLong(cstmt.getString(2)));
			
		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener la secuencia de la venta",e);
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
		logger.debug("Fin:getSecuenciaVenta");
		return resultado;
	}

	/**
	 * Obtiene secuencia de transacabo
	 * @param parametroEntrada
	 * @return resultado
	 * @throws CustomerBillException
	 */
	public RegistroVentaDTO getSecuenciaTransacabo(RegistroVentaDTO parametroEntrada) throws CustomerBillException{
		RegistroVentaDTO resultado=new RegistroVentaDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:getSecuenciaTransacabo");
			
			String call = getSQLDatosVenta("VE_intermediario_PG","VE_OBTIENE_SECUENCIA_PR",5);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,parametroEntrada.getCodigoSecuencia());
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getSecuenciaTransacabo:execute");
			cstmt.execute();
			logger.debug("Fin:getSecuenciaTransacabo:execute");

			codError=cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento=cstmt.getInt(5);
			logger.debug("msgError[" + msgError + "]");
			
			if (codError != 0){
				logger.error("Ocurrió un error al obtener secuencia transacabo");
				throw new CustomerBillException(
				"Ocurrió un error al obtener secuencia transacabo", String
				.valueOf(codError), numEvento, msgError);
			}
			else
				resultado.setNumeroTransaccionVenta(Long.parseLong(cstmt.getString(2)));
		
		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener la secuencia de la transacabo",e);
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

		logger.debug("Fin:getSecuenciaTransacabo");

		return resultado;
	}//fin getSecuenciaTransacabo
		
	/**
	 * Obtiene Prefijo de numero telefonico
	 * @param entrada
	 * @return entrada
	 * @throws CustomerBillException
	 */
	public RegistroVentaDTO getPrefijoMin(RegistroVentaDTO entrada) throws CustomerBillException{
		RegistroVentaDTO resultado=new RegistroVentaDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:getPrefijoMin");
			
			String call = getSQLDatosVenta("VE_intermediario_PG","VE_OBTIENE_PREFIJO_NUM_PR",5);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			
			cstmt.setLong(1,entrada.getNumeroCelular());

			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getPrefijoMin:execute");
			cstmt.execute();
			logger.debug("Fin:getPrefijoMin:execute");

			codError=cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento=cstmt.getInt(5);
			logger.debug("Código Error: " +  cstmt.getInt(3));
			logger.debug("msgError: " +  cstmt.getString(4));
			logger.debug("numEvento: " +  cstmt.getInt(5));
			
			if (codError != 0){
				logger.error("Ocurrió un error al obtener prefijo numero celular");
				throw new CustomerBillException(
				"Ocurrió un error al obtener prefijo numero celular", String
				.valueOf(codError), numEvento, msgError);
			}
			else
				entrada.setPrefijoMin(cstmt.getString(2));
		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener prefijo numero celular",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
				if (e instanceof CustomerBillException)
					throw (CustomerBillException)e;
				
							
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
		logger.debug("Fin:getPrefijoMin");
		return resultado;
	}//fin getPrefijoMin

	/**
	 * Obtiene numero celular automatico
	 * @param celular
	 * @return celular
	 * @throws CustomerBillException
	 */
	
	public CelularDTO getNumeroCelularAut(CelularDTO celular) throws CustomerBillException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:getNumeroCelularAut");
			
			String call = getSQLDatosVenta("VE_intermediario_PG","VE_ObtieneNumeroCelularAut_PR",10);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,celular.getCodSubAlm());
			logger.debug("subalm:" + celular.getCodSubAlm());
			cstmt.setString(2,celular.getCentral());
			logger.debug("subalm:" + celular.getCentral());
			cstmt.setString(3,celular.getCodigoUso());
			logger.debug("codigo uso:" + celular.getCodigoUso());
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getNumeroCelularAut:execute");
			cstmt.execute();
			logger.debug("Fin:getNumeroCelularAut:execute");

			codError=cstmt.getInt(8);
			msgError = cstmt.getString(9);
			numEvento=cstmt.getInt(10);
			logger.debug("msgError[" + msgError + "]");
			
			if (codError != 0){
				logger.error("Ocurrió un error al obtener numero celular automatico");
				throw new CustomerBillException(
				"Ocurrió un error al obtener numero celular automatico", String
				.valueOf(codError), numEvento, msgError);
			}
			else{
				celular.setNumeroCelular(Long.parseLong(cstmt.getString(4)));
				celular.setTipoCelular(cstmt.getString(5));
				celular.setCategoria(cstmt.getString(6));
				celular.setFecBajaCelular(cstmt.getString(7));
			}
		
		} catch (CustomerBillException e) {
			logger.error("Ocurrió un error al obtener numero celular automatico",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener numero celular automatico",e);
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

		logger.debug("Fin:getNumeroCelularAut");

		return celular;
	}//fin getNumeroCelularAut

	/**
	 * Genera reserva numero celular
	 * @param celular
	 * @return celular
	 * @throws CustomerBillException
	 */
	
	public CelularDTO setReservaNumeroCelular(CelularDTO celular) throws CustomerBillException{
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:setReservaNumeroCelular");
			
			String call = getSQLDatosVenta("VE_intermediario_PG","VE_reserva_numero_celular_PR",13);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setLong(1,celular.getNumeroTransaccion());
			cstmt.setString(2,celular.getNumeroLinea());
			cstmt.setString(3,celular.getNumeroOrden());
			cstmt.setLong(4,celular.getNumeroCelular());
			cstmt.setString(5,celular.getCodSubAlm());
			cstmt.setString(6,celular.getCentral());
			cstmt.setString(7,celular.getCategoria());
			cstmt.setString(8,celular.getCodigoUso());
			cstmt.setString(9,celular.getTipoCelular());
			cstmt.setString(10,celular.getFecBajaCelular());

			cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(13, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:setReservaNumeroCelular:execute");
			cstmt.execute();
			logger.debug("Fin:setReservaNumeroCelular:execute");

			codError=cstmt.getInt(11);
			msgError = cstmt.getString(12);
			numEvento=cstmt.getInt(13);
			logger.debug("msgError[" + msgError + "]");
			
			if (codError != 0){
				logger.error("Ocurrió un error al insertar en GA_RESNUMCEL");
				throw new CustomerBillException(
				"Ocurrió un error al insertar en GA_RESNUMCEL", String
				.valueOf(codError), numEvento, msgError);
			}	

		} catch (Exception e) {
			logger.error("Ocurrió un error al insertar en GA_RESNUMCEL",e);
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

		logger.debug("Fin:setReservaNumeroCelular");

		return celular;
	}//fin setReservaNumeroCelular
	
	/**
	 * Obtiene secuencia del paquete para agregar datos a tabla cargos
	 * @param parametroEntrada
	 * @return resultado
	 * @throws CustomerBillException
	 */
	
	public RegistroVentaDTO getSecuenciaPaquete(RegistroVentaDTO parametroEntrada) throws CustomerBillException{
		RegistroVentaDTO resultado=new RegistroVentaDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:getSecuenciaPaquete");
			
			String call = getSQLDatosVenta("VE_intermediario_PG","VE_OBTIENE_SECUENCIA_PR",5);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,parametroEntrada.getCodigoSecuencia());
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getSecuenciaPaquete:execute");
			cstmt.execute();
			logger.debug("Fin:getSecuenciaPaquete:execute");

			codError=cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento=cstmt.getInt(5);
			logger.debug("msgError[" + msgError + "]");

			if (codError != 0){
				logger.error("Ocurrió un error al obtener la secuencia del Paquete");
				throw new CustomerBillException(
				"Ocurrió un error al obtener la secuencia del Paquete", String
				.valueOf(codError), numEvento, msgError);
			}	
			else
				resultado.setNumeroPaquete(cstmt.getString(2));
			
		
		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener la secuencia del Paquete",e);
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

		logger.debug("Fin:getSecuenciaPaquete");

		return resultado;
	}
	
	public RegistroVentaDTO existePlanFreedomEnVenta(ParametrosRegistroCargosDTO parametrosCargos,ParametrosGeneralesDTO parametroProporVta,ParametrosGeneralesDTO parametroProporc1,ParametrosGeneralesDTO parametroProporc2 ) throws CustomerBillException{
		RegistroVentaDTO registroventadto =new RegistroVentaDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:existePlanFreedomEnVenta");
			String call = getSQLDatosVenta("PV_SERVICIOS_POSVENTA_PG","VE_hay_pfreedom_en_venta_PR",8);
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,parametroProporVta.getValorparametro());
			cstmt.setInt(2,Integer.parseInt(parametrosCargos.getNumeroVenta()));
			cstmt.setInt(3,Integer.parseInt(parametroProporc1.getValorparametro()));
			cstmt.setInt(4,Integer.parseInt(parametroProporc1.getValorparametro()));
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			logger.debug("Inicio:existePlanFreedomEnVenta:execute");
			cstmt.execute();
			logger.debug("Fin:existePlanFreedomEnVenta:execute");
		    codError= cstmt.getInt(6);
			msgError = cstmt.getString(7);
			numEvento = cstmt.getInt(8);
			int resultado = cstmt.getInt(5);
			registroventadto.setExistePlanFreedom(resultado==1?true:false);
			logger.debug("RegistroVtaDAO:"+resultado);

		} 
		catch (Exception e) {
			logger.error("Ocurrió un error al consultar si existe plan freedom en venta",e);
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
		logger.debug("Fin:existePlanFreedomEnVenta");
		return registroventadto;
	}
	
	
	   
	   private String getSQLCodProcesoVenta() {
			StringBuffer calling = new StringBuffer();		
	        calling.append("");
	        calling.append("DECLARE");                
			calling.append(  "   SO_MATRIZESTADOS   VE_TIPOS_PG. TIP_VE_MATRIZESTADOS_TD; ");
			calling.append(  " BEGIN ");
			calling.append(  "   SO_MATRIZESTADOS(1).cod_programa:=?;");
			calling.append(  "   SO_MATRIZESTADOS(1).ind_ofiter:=?;");
			calling.append(  "   SO_MATRIZESTADOS(1).formulario:= 'FrmVenta2';");
			calling.append(  "  VE_CIERREVENTA_SB_PG.VE_CODIGO_PROCS_VENTA_PR(SO_MATRIZESTADOS, ?,?,?);"); 		
	        calling.append(  "  ?:=SO_MATRIZESTADOS(1).cod_proceso;");        
			calling.append(  " END;");
			if (logger.isDebugEnabled()) 
	        	logger.debug("calling : " + calling);        
			return calling.toString();
	  }
	   
	   private String getSQLCodEstadoFinalVenta() {
			StringBuffer calling = new StringBuffer();		
	        calling.append("");
	        calling.append("DECLARE");                
			calling.append(  "   SO_MATRIZESTADOS   VE_TIPOS_PG. TIP_VE_MATRIZESTADOS_TD; ");
			calling.append(  "   FEC_VENTA			 ve_matrizestados_td.FEC_DESDE%TYPE;");
			calling.append(  " BEGIN ");
			calling.append(  "   SO_MATRIZESTADOS(1).cod_programa:= ?;");
			calling.append(  "   SO_MATRIZESTADOS(1).ind_ofiter:= ?;");
			calling.append(  "   SO_MATRIZESTADOS(1).cod_proceso:=?;");
			calling.append(  "   FEC_VENTA	:=?;");
			calling.append(  "   SO_MATRIZESTADOS(1).formulario:= 'FrmVenta2';");
			calling.append(  "   VE_CIERREVENTA_SB_PG.VE_CODIGO_ESTFINAL_VENTA_PR( SO_MATRIZESTADOS, FEC_VENTA,?,?,? );"); 		
	        calling.append(  "  ?:=SO_MATRIZESTADOS(1).cod_estadodestino;");        
			calling.append(  " END;");
			if (logger.isDebugEnabled()) 
	        	logger.debug("calling : " + calling);        
			return calling.toString();
	 }
	   
	   private String getSQLInsertVenta() {
			StringBuffer calling = new StringBuffer();		
	       calling.append("");
	       calling.append("DECLARE ");                
			calling.append(  "   SO_VENTAS GA_TIPOS_PG.TIP_GA_VENTAS; ");
			
			calling.append(  " BEGIN ");
			calling.append(  "   SO_VENTAS(1).COD_PRODUCTO:=?;"); 
			calling.append(  "   SO_VENTAS(1).COD_OFICINA:= ?;");
			calling.append(  "   SO_VENTAS(1).COD_TIPCOMIS:= ?;");
			calling.append(  "   SO_VENTAS(1).COD_VENDEDOR:= ?;");
			calling.append(  "   SO_VENTAS(1).COD_VENDEDOR_AGENTE:=?;"); 
			calling.append(  "   SO_VENTAS(1).NUM_UNIDADES:= ?;");
			calling.append(  "   SO_VENTAS(1).FEC_VENTA:= ?;");
			calling.append(  "   SO_VENTAS(1).COD_REGION:= ?;");
			calling.append(  "   SO_VENTAS(1).COD_PROVINCIA:=?;");
			calling.append(  "   SO_VENTAS(1).COD_CIUDAD:= ?;");
			calling.append(  "   SO_VENTAS(1).IND_ESTVENTA:=?; ");
			calling.append(  "   SO_VENTAS(1).NUM_TRANSACCION:=?; ");
			calling.append(  "   SO_VENTAS(1).IND_PASOCOB:= ?;");
			calling.append(  "   SO_VENTAS(1).NOM_USUAR_VTA:=?; ");
			calling.append(  "   SO_VENTAS(1).IND_VENTA:= ?;");
			calling.append(  "   SO_VENTAS(1).COD_MONEDA:= ?;");
			calling.append(  "   SO_VENTAS(1).COD_CAUSAREC:=?; ");
			calling.append(  "   SO_VENTAS(1).IMP_VENTA:= ?;");
			calling.append(  "   SO_VENTAS(1).COD_TIPCONTRATO:=?;");
			calling.append(  "   SO_VENTAS(1).NUM_CONTRATO:= ?;");
			calling.append(  "   SO_VENTAS(1).IND_TIPVENTA:= ?;");
			calling.append(  "   SO_VENTAS(1).COD_CLIENTE:= ?;");
	    	calling.append(  "   SO_VENTAS(1).COD_MODVENTA:= ?;");
			calling.append(  "   SO_VENTAS(1).TIP_VALOR:= ?;");
			calling.append(  "   SO_VENTAS(1).COD_CUOTA:= ?;");
			calling.append(  "   SO_VENTAS(1).COD_TIPTARJETA:=?;");
			calling.append(  "   SO_VENTAS(1).NUM_TARJETA:= ?;");
			calling.append(  "   SO_VENTAS(1).COD_AUTTARJ:= ?;");
			calling.append(  "   SO_VENTAS(1).FEC_VENCITARJ:=?; ");
			calling.append(  "   SO_VENTAS(1).COD_BANCOTARJ:= ?;");
			calling.append(  "   SO_VENTAS(1).NUM_CTACORR:= ?;");
			calling.append(  "   SO_VENTAS(1).NUM_CHEQUE:= ?;");
			calling.append(  "   SO_VENTAS(1).COD_BANCO:= ?;");
			calling.append(  "   SO_VENTAS(1).COD_SUCURSAL:=?; ");
			calling.append(  "   SO_VENTAS(1).FEC_CUMPLIMENTA:=?;");
			calling.append(  "   SO_VENTAS(1).FEC_RECDOCUM:= ?;");
			calling.append(  "   SO_VENTAS(1).FEC_ACEPREC:= ?;");
			calling.append(  "   SO_VENTAS(1).NOM_USUAR_ACEREC:=?;"); 
			calling.append(  "   SO_VENTAS(1).NOM_USUAR_RECDOC:=?;");
			calling.append(  "   SO_VENTAS(1).NOM_USUAR_CUMPL:=?;");
			calling.append(  "   SO_VENTAS(1).NUM_VENTA:=?;");
			calling.append(  "   GA_VENTAS_SB_PG.GA_INSERT_VENTA_PR( SO_VENTAS,?,?,? );");
			calling.append(  "   ?:=SO_VENTAS(1).NUM_VENTA;");
			calling.append(  "   ?:=SO_VENTAS(1).NUM_CONTRATO;");
			calling.append(  " END;");
			if (logger.isDebugEnabled()) 
	        	logger.debug("calling : " + calling);        
			return calling.toString();
	}
	   private String getSQLgetNumUnidades(){
			StringBuffer calling = new StringBuffer();		
	        calling.append("");
	        calling.append("DECLARE");                
			calling.append(  "   SO_ABOCEL GA_TIPOS_PG.TIP_GA_ABOCEL; ");
			calling.append(  "   NUM_UNIDADES NUMBER;");
			calling.append(  " BEGIN ");
			calling.append(  "   SO_ABOCEL(1).Num_venta :=?;");
			calling.append(  "   VE_CIERREVENTA_SB_PG.VE_NUM_UNIDADES_VENTA_PR ( SO_ABOCEL, NUM_UNIDADES,?,?,? );"); 		
	        calling.append(  "   ?:=NUM_UNIDADES;");        
			calling.append(  " END;");
			if (logger.isDebugEnabled()) 
	        	logger.debug("calling : " + calling);        
			return calling.toString();   
	   }
	   
	
	  
	    private String getSQLUpdate(){
			StringBuffer calling = new StringBuffer();		
	        calling.append("");
	        calling.append("DECLARE");                
			calling.append(  "   SO_VENTAS GA_TIPOS_PG.TIP_GA_VENTAS; ");
			calling.append(  " BEGIN ");
			calling.append(  "   SO_VENTAS(1).IMP_VENTA:=?;");
			calling.append(  "   SO_VENTAS(1).NUM_VENTA:=?;");
			calling.append(  "   GA_VENTAS_SB_PG.GA_UPDATE_VENTA_PR ( SO_VENTAS, ?, ?, ? );"); 		
	        calling.append(  " END;");
	        if (logger.isDebugEnabled()) 
	        	logger.debug("calling : " + calling);        
			return calling.toString();   
	   }
	   
	   
	 
	    
	   
	   public String getNumUnidades(String numVenta)throws CustomerBillException{
			
		   if (logger.isDebugEnabled()) {
	           logger.debug("getNumUnidades():start");
	       }
	       int codError = 0;
	       String msgError = null;
	       int numEvento = 0;
	       
	       String call=null;
	       String numUnidades=null;
	       Connection conn = null;
	       CallableStatement cstmt=null;
	       //se recuepera coneccion del DataSources
	       try {
				conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			} 
	       catch (Exception e1) {
				logger.error(" No se pudo obtener una conexión ", e1);
				throw new CustomerBillException("No se pudo obtener una conexión",e1);
			}
	       try {
				
	           call=getSQLgetNumUnidades();
	       	if (logger.isDebugEnabled()) {
					logger.debug("sql[" + call + "]");
				}
				cstmt = conn.prepareCall(call);
	           
	           if (logger.isDebugEnabled()) {
					logger.debug("Registrando Entradas");				
				}
	           cstmt.setString(1,numVenta);
	           
	           if (logger.isDebugEnabled()) {
					logger.debug(" Registrando salidas");
				}
				//Se procede a descomentar cuando devuelva errores
	           cstmt.registerOutParameter(2, oracle.jdbc.driver.OracleTypes.NUMBER);
				cstmt.registerOutParameter(3, oracle.jdbc.driver.OracleTypes.VARCHAR);
	           cstmt.registerOutParameter(4, oracle.jdbc.driver.OracleTypes.NUMBER);
	           
	           //Campos de devolución
	           cstmt.registerOutParameter(5, oracle.jdbc.driver.OracleTypes.NUMBER);
	                       
				if (logger.isDebugEnabled()) {
					logger.debug(" Iniciando Ejecución");
				}

				logger.debug("Execute Antes");
	          
				cstmt.execute();
	          
				logger.debug("Execute Despues");

				if (logger.isDebugEnabled()) {
					logger.debug(" Finalizo ejecución");
					logger.debug(" Recuperando salidas");
				}
				// Recuperacion de valores de salida
	           
				numUnidades=Integer.toString(cstmt.getInt(5));
	           
		        
				codError =cstmt.getInt(2);
				logger.debug("codError[" + codError + "]");
				msgError = cstmt.getString(3);
				logger.debug("msgError[" + msgError + "]");
	           numEvento = cstmt.getInt(4);
				logger.debug("numEvento[" + numEvento + "]");
	           cstmt=null;

	        

	           if (codError != 0) {
					logger.error(" Ocurrió un error al recuperar codigo de despacho");
					throw new CustomerBillException(String.valueOf(codError),
								numEvento, msgError); 
				}
	           
	           logger.debug("Recuperando data...");

				logger.debug("Numero Unidades[" + numUnidades + "]");
				
			} catch (CustomerBillException e) {
	          
	           e.printStackTrace();
	           logger.error("Ocurrió un error general al Recuperar el numero de Unidades",e);
				if (logger.isDebugEnabled()) {
					logger.debug("Codigo de Error[" + codError + "]");
					logger.debug("Mensaje de Error[" + msgError + "]");
					logger.debug("Numero de Evento[" + numEvento + "]");
				}
				throw e;
			}catch (Exception e) 
	           {
	                         
	           e.printStackTrace();
				logger.error("Ocurrió un error general al recuperar numero de unidades",e);
				if (logger.isDebugEnabled())
	                {
					logger.debug("Codigo de Error[" + codError + "]");
					logger.debug("Mensaje de Error[" + msgError + "]");
					logger.debug("Numero de Evento[" + numEvento + "]");
	               }
	                 throw new CustomerBillException(
						"Ocurrió un error general  al recuperar numero de unidades",e);
	               
	           }
	           finally {
	               if (logger.isDebugEnabled()) 
	               {
	                   logger.debug("Cerrando conexiones...");
	               }
	               try {
	                       if (cstmt!=null){
	                           cstmt.close();
	                           } 
	                       
	                       if (!conn.isClosed())
	                       {
	                           conn.close();
	                       }
	                   }
	               catch (SQLException e) 
	                   {
	                   // TODO Auto-generated catch block
	                   logger.debug("SQLException[" + e + "]");
	                   }        
			}

	       if (logger.isDebugEnabled()) {
				logger.debug("getCodestadoFinalVenta():end");
			}
	   
	       return numUnidades;

	   }
	   
	   
	 public Long getCodPlazaCliente(Long CodCliente)throws CustomerBillException{
			
		   if (logger.isDebugEnabled()) {
	           logger.debug("getCodPlazaCliente():start");
	       }
	       int codError = 0;
	       String msgError = null;
	       int numEvento = 0;
	       
	       String call=null;
	       Long codPlazaCliente=null;
	       Connection conn = null;
	       CallableStatement cstmt=null;
	       //se recuepera coneccion del DataSources
	       try {
				conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			} 
	       catch (Exception e1) {
				logger.error(" No se pudo obtener una conexión ", e1);
				throw new CustomerBillException("No se pudo obtener una conexión",e1);
			}
	       try {
				
	    	   call="{call VE_intermediario_PG.VE_ObtienePlaza_Cliente_PR(?,?,?,?,?)}";
	       	if (logger.isDebugEnabled()) {
					logger.debug("sql[" + call + "]");
				}
				cstmt = conn.prepareCall(call);
	           
	           if (logger.isDebugEnabled()) {
					logger.debug("Registrando Entradas");				
				}
	           cstmt.setLong(1,CodCliente.longValue());
	           
	           if (logger.isDebugEnabled()) {
					logger.debug(" Registrando salidas");
				}
				//Se procede a descomentar cuando devuelva errores
	           
	           cstmt.registerOutParameter(2, oracle.jdbc.driver.OracleTypes.NUMBER);
	           cstmt.registerOutParameter(3, oracle.jdbc.driver.OracleTypes.NUMBER);
	           cstmt.registerOutParameter(4, oracle.jdbc.driver.OracleTypes.VARCHAR);
	           cstmt.registerOutParameter(5, oracle.jdbc.driver.OracleTypes.NUMBER);
	                       
				if (logger.isDebugEnabled()) {
					logger.debug(" Iniciando Ejecución");
				}

				logger.debug("Execute Antes");
	          
				cstmt.execute();
	          
				logger.debug("Execute Despues");

				if (logger.isDebugEnabled()) {
					logger.debug(" Finalizo ejecución");
					logger.debug(" Recuperando salidas");
				}
				// Recuperacion de valores de salida
	           
				
	            
				codError =cstmt.getInt(3);
				logger.debug("codError[" + codError + "]");
				msgError = cstmt.getString(4);
				logger.debug("msgError[" + msgError + "]");
	           numEvento = cstmt.getInt(5);
				logger.debug("numEvento[" + numEvento + "]");
	           

	         
	           if (codError != 0) {
					logger.error(" Ocurrió un error al recuperar codigo de despacho");
					throw new CustomerBillException(String.valueOf(codError),
								numEvento, msgError); 
				}
	           else
	        	   codPlazaCliente=new Long(cstmt.getLong(2));
	           
	           logger.debug("Recuperando data...");

				logger.debug("Codigo Plaza por Cliente[" + codPlazaCliente + "]");
				
			} catch (CustomerBillException e) {
	          
	           e.printStackTrace();
	           logger.error("Ocurrió un error general al Recuperar el Código Plaza por cliente",e);
				if (logger.isDebugEnabled()) {
					logger.debug("Codigo de Error[" + codError + "]");
					logger.debug("Mensaje de Error[" + msgError + "]");
					logger.debug("Numero de Evento[" + numEvento + "]");
				}
				throw e;
			}catch (Exception e) 
	           {
	                         
	           e.printStackTrace();
				logger.error("Ocurrió un error general al recuperar Código Plaza por cliente",e);
				if (logger.isDebugEnabled())
	                {
					logger.debug("Codigo de Error[" + codError + "]");
					logger.debug("Mensaje de Error[" + msgError + "]");
					logger.debug("Numero de Evento[" + numEvento + "]");
	               }
	                 throw new CustomerBillException(
						"Ocurrió un error general  al recuperar Código Plaza por cliente",e);
	               
	           }
	           finally {
	               if (logger.isDebugEnabled()) 
	               {
	                   logger.debug("Cerrando conexiones...");
	               }
	               try {
	                       if (cstmt!=null){
	                           cstmt.close();
	                           } 
	                       
	                       if (!conn.isClosed())
	                       {
	                           conn.close();
	                       }
	                   }
	               catch (SQLException e) 
	                   {
	                   // TODO Auto-generated catch block
	                   logger.debug("SQLException[" + e + "]");
	                   }        
			}

	       if (logger.isDebugEnabled()) {
				logger.debug("getCodestadoFinalVenta():end");
			}
	   
	       return codPlazaCliente;

	   } 	
 
	 public Long getCodPlazaOficina(Long CodOficina)throws CustomerBillException{
			
		   if (logger.isDebugEnabled()) {
	           logger.debug("getCodPlazaOficina():start");
	       }
	       int codError = 0;
	       String msgError = null;
	       int numEvento = 0;
	       
	       String call=null;
	       Long codPlazaOficina=null;
	       Connection conn = null;
	       CallableStatement cstmt=null;
	       //se recuepera coneccion del DataSources
	       try {
				conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			} 
	       catch (Exception e1) {
				logger.error(" No se pudo obtener una conexión ", e1);
				throw new CustomerBillException("No se pudo obtener una conexión",e1);
			}
	       try {
				
	           call="{call VE_intermediario_PG.VE_ObtienePlaza_Oficina_PR(?,?,?,?,?)}";
	          
	       	if (logger.isDebugEnabled()) {
					logger.debug("sql[" + call + "]");
				}
				cstmt = conn.prepareCall(call);
	           
	           if (logger.isDebugEnabled()) {
					logger.debug("Registrando Entradas");				
				}
	           cstmt.setLong(1,CodOficina.longValue());
	           
	           if (logger.isDebugEnabled()) {
					logger.debug(" Registrando salidas");
				}
				//Se procede a descomentar cuando devuelva errores
	           
	           cstmt.registerOutParameter(2, oracle.jdbc.driver.OracleTypes.NUMBER);
					           
	           //Campos de devolución
	           cstmt.registerOutParameter(3, oracle.jdbc.driver.OracleTypes.NUMBER);
	           cstmt.registerOutParameter(4, oracle.jdbc.driver.OracleTypes.VARCHAR);
	           cstmt.registerOutParameter(5, oracle.jdbc.driver.OracleTypes.NUMBER);
	                       
				if (logger.isDebugEnabled()) {
					logger.debug(" Iniciando Ejecución");
				}

				logger.debug("Execute Antes");
	         
				cstmt.execute();
	          
				logger.debug("Execute Despues");

				if (logger.isDebugEnabled()) {
					logger.debug(" Finalizo ejecución");
					logger.debug(" Recuperando salidas");
				}
				// Recuperacion de valores de salida
	           
				codPlazaOficina=new Long(cstmt.getLong(2));
	            
				codError =cstmt.getInt(3);
				logger.debug("codError[" + codError + "]");
				msgError = cstmt.getString(4);
				logger.debug("msgError[" + msgError + "]");
	           numEvento = cstmt.getInt(5);
				logger.debug("numEvento[" + numEvento + "]");
	           cstmt=null;

	       
	           if (codError != 0) {
					logger.error(" Ocurrió un error al recuperar codigo plaza Oficina");
					throw new CustomerBillException(String.valueOf(codError),
								numEvento, msgError); 
				}
	           
	           logger.debug("Recuperando data...");

				logger.debug("Codigo Plaza por Oficina[" + codPlazaOficina + "]");
				
			} catch (CustomerBillException e) {
	           
	           e.printStackTrace();
	           logger.error("Ocurrió un error general al Recuperar el Código Plaza por oficina",e);
				if (logger.isDebugEnabled()) {
					logger.debug("Codigo de Error[" + codError + "]");
					logger.debug("Mensaje de Error[" + msgError + "]");
					logger.debug("Numero de Evento[" + numEvento + "]");
				}
				throw e;
			}catch (Exception e) 
	           {
	         
	           e.printStackTrace();
				logger.error("Ocurrió un error general al recuperar Código Plaza por oficina",e);
				if (logger.isDebugEnabled())
	                {
					logger.debug("Codigo de Error[" + codError + "]");
					logger.debug("Mensaje de Error[" + msgError + "]");
					logger.debug("Numero de Evento[" + numEvento + "]");
	               }
	                 throw new CustomerBillException(
						"Ocurrió un error general  al recuperar Código Plaza por oficina",e);
	               
	           }
	           finally {
	               if (logger.isDebugEnabled()) 
	               {
	                   logger.debug("Cerrando conexiones...");
	               }
	               try {
	                       if (cstmt!=null){
	                           cstmt.close();
	                           } 
	                       
	                       if (!conn.isClosed())
	                       {
	                           conn.close();
	                       }
	                   }
	               catch (SQLException e) 
	                   {
	                   // TODO Auto-generated catch block
	                   logger.debug("SQLException[" + e + "]");
	                   }        
			}

	       if (logger.isDebugEnabled()) {
				logger.debug("getCodestadoFinalVenta():end");
			}
	   
	       return codPlazaOficina;

	   } 	
	 
	 
}
