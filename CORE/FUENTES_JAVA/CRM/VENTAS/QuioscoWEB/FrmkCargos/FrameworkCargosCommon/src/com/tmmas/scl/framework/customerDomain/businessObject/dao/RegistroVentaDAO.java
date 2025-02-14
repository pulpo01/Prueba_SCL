package com.tmmas.scl.framework.customerDomain.businessObject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.scl.framework.customerDomain.businessObject.dao.interfaces.RegistroVentaDAOIT;
import com.tmmas.scl.framework.customerDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.GaVentasDTO;
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
	
	  private String getSQLUpdateVentaEscenarioA(){
			StringBuffer calling = new StringBuffer();		
	        calling.append("");
	        calling.append("DECLARE");                
			calling.append(  "   SO_VENTAS VE_TIPOS_PG.TIP_GA_VENTAS; ");
			calling.append(  " BEGIN ");
			calling.append(  "   SO_VENTAS(1).IND_ESTVENTA:=?;");
			calling.append(  "   SO_VENTAS(1).NUM_TRANSACCION:=?;");
			calling.append(  "   SO_VENTAS(1).TIP_VALOR:=?;");
			calling.append(  "   SO_VENTAS(1).IMP_VENTA:=?;");
			calling.append(  "   SO_VENTAS(1).NUM_CONTRATO:=?;");
			calling.append(  "   SO_VENTAS(1).NUM_VENTA:=?;");
			calling.append(  "   GA_VENTAS_SB_PG.GA_UPDATE_VENTA_ESCA_PR ( SO_VENTAS, ?, ?, ? );"); 		
	        calling.append(  " END;");
	        if (logger.isDebugEnabled()) 
	        	logger.debug("calling : " + calling);        
			return calling.toString();   
	   }
	   
	   private String getSQLUpdateVentaEscenarioB(){
			StringBuffer calling = new StringBuffer();		
	        calling.append("");
	        calling.append("DECLARE");                
			calling.append(  "   SO_VENTAS VE_TIPOS_PG.TIP_GA_VENTAS; ");
			calling.append(  " BEGIN ");
			calling.append(  "   SO_VENTAS(1).IND_ESTVENTA:=?;");
			calling.append(  "   SO_VENTAS(1).NUM_TRANSACCION:=?;");
			calling.append(  "   SO_VENTAS(1).TIP_VALOR:=?;");
			calling.append(  "   SO_VENTAS(1).IMP_VENTA:=?;");
			calling.append(  "   SO_VENTAS(1).NUM_CONTRATO:=?;");
			calling.append(  "   SO_VENTAS(1).NUM_VENTA:=?;");
			calling.append(  "   GA_VENTAS_SB_PG.GA_UPDATE_VENTA_ESCB_PR ( SO_VENTAS, ?, ?, ? );"); 		
	        calling.append(  " END;");
	        if (logger.isDebugEnabled()) 
	        	logger.debug("calling : " + calling);        
			return calling.toString();   
	   }
	   
	   private String getSQLUpdateVentaEscenarioC(){
			StringBuffer calling = new StringBuffer();		
	        calling.append("");
	        calling.append("DECLARE");                
			calling.append(  "   SO_VENTAS VE_TIPOS_PG.TIP_GA_VENTAS; ");
			calling.append(  " BEGIN ");
			calling.append(  "   SO_VENTAS(1).IND_ESTVENTA:=?;");
			calling.append(  "   SO_VENTAS(1).NUM_TRANSACCION:=?;");
			calling.append(  "   SO_VENTAS(1).TIP_VALOR:=?;");
			calling.append(  "   SO_VENTAS(1).IMP_VENTA:=?;");
			calling.append(  "   SO_VENTAS(1).NUM_CONTRATO:=?;");
			calling.append(  "   SO_VENTAS(1).NUM_VENTA:=?;");
			calling.append(  "   GA_VENTAS_SB_PG.GA_UPDATE_VENTA_ESCC_PR ( SO_VENTAS, ?, ?, ? );"); 		
	        calling.append(  " END;");
	        if (logger.isDebugEnabled()) 
	        	logger.debug("calling : " + calling);
		   
	       return calling.toString();   
	   }
	   
	   private String getSQLUpdateVentaEscenarioD(){
			StringBuffer calling = new StringBuffer();		
	        calling.append("");
	        calling.append("DECLARE");                
			calling.append(  "   SO_VENTAS VE_TIPOS_PG.TIP_GA_VENTAS; ");
			calling.append(  " BEGIN ");
			calling.append(  "   SO_VENTAS(1).IND_ESTVENTA:=?;");
			calling.append(  "   SO_VENTAS(1).NUM_TRANSACCION:=?;");
			
			calling.append(  "   SO_VENTAS(1).IMP_VENTA:=?;");
			calling.append(  "   SO_VENTAS(1).NUM_CONTRATO:=?;");
			calling.append(  "   SO_VENTAS(1).NUM_VENTA:=?;");
			calling.append(  "   GA_VENTAS_SB_PG.GA_UPDATE_VENTA_ESCD_PR ( SO_VENTAS, ?, ?, ? );"); 		
	        calling.append(  " END;");
	        if (logger.isDebugEnabled()) 
	        	logger.debug("calling : " + calling);        
			return calling.toString();   
	   }
	   
	    private String getSQLUpdate(){
			StringBuffer calling = new StringBuffer();		
	        calling.append("");
	        calling.append("DECLARE");                
			calling.append(  "   SO_VENTAS VE_TIPOS_PG.TIP_GA_VENTAS; ");
			calling.append(  " BEGIN ");
			calling.append(  "   SO_VENTAS(1).IMP_VENTA:=?;");
			calling.append(  "   SO_VENTAS(1).NUM_VENTA:=?;");
			calling.append(  "   SO_VENTAS(1).IMP_ABONO:=?;");
			calling.append(  "   SO_VENTAS(1).IND_ABONO:=?;");
			calling.append(  "   GA_VENTAS_SB_PG.GA_UPDATE_VENTA_PR ( SO_VENTAS, ?, ?, ? );"); 		
	        calling.append(  " END;");
	        if (logger.isDebugEnabled()) 
	        	logger.debug("calling : " + calling);        
			return calling.toString();   
	   }
	    
	    
	    private String getSSQLEliminaResCel(){
	    	StringBuffer call=new StringBuffer();
	    	
	    	call.append(" DECLARE "); 
	    	call.append("  	BEGIN ");
	    	call.append("  	  VE_SERVICIOS_VENTA_PG.VE_ELIMINARESCEL_PR ( ?,?,?,?,? );");
	    	call.append("  	END; ");
	    	
	    	return call.toString();
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
	
	
	 public String getCodPlazaCliente(Long CodCliente)throws CustomerBillException{
			
		   if (logger.isDebugEnabled()) {
	           logger.debug("getCodPlazaCliente():start");
	       }
	       int codError = 0;
	       String msgError = null;
	       int numEvento = 0;
	       
	       String call=null;
	       String codPlazaCliente=null;
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
	           
	           cstmt.registerOutParameter(2, oracle.jdbc.driver.OracleTypes.VARCHAR);
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
					logger.error(" Ocurrió un error al recuperar el Código Plaza por cliente");
					throw new CustomerBillException(String.valueOf(codError),
								numEvento, msgError); 
				}
	           else
	        	   codPlazaCliente=cstmt.getString(2);
	           
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
				logger.debug("getCodPlazaCliente():end");
			}
	   
	       return codPlazaCliente;

	   } 	

	 public String getCodPlazaOficina(String CodOficina)throws CustomerBillException{
			
		   if (logger.isDebugEnabled()) {
	           logger.debug("getCodPlazaOficina():start");
	       }
	       int codError = 0;
	       String msgError = null;
	       int numEvento = 0;
	       
	       String call=null;
	       String codPlazaOficina=null;
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
	           cstmt.setString(1,CodOficina);
	           
	           if (logger.isDebugEnabled()) {
					logger.debug(" Registrando salidas");
				}
				//Se procede a descomentar cuando devuelva errores
	           
	           cstmt.registerOutParameter(2, oracle.jdbc.driver.OracleTypes.VARCHAR);
					           
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
	           
				codPlazaOficina=cstmt.getString(2);
	            
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
				logger.debug("getCodPlazaOficina():end");
			}
	   
	       return codPlazaOficina;

	   } 	
	 public void updateVentasEscenarioB(GaVentasDTO gaVentasDTO)throws CustomerBillException{
			
		   if (logger.isDebugEnabled()) {
	           logger.debug("updateVentasEscenarioB():start");
	       }
	       int codError = 0;
	       String msgError = null;
	       int numEvento = 0;
	       
	       String call=null;
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
			   call=getSQLUpdateVentaEscenarioB();
	       	if (logger.isDebugEnabled()) {
					logger.debug("sql[" + call + "]");
				}
				cstmt = conn.prepareCall(call);
	           
	           if (logger.isDebugEnabled()) {
					logger.debug("Registrando Entradas");				
				}
	           
	           cstmt.setString(1,gaVentasDTO.getIndEstVenta());
	           cstmt.setLong(2,gaVentasDTO.getNumTransaccion().longValue());
	           cstmt.setString(3,gaVentasDTO.getTipValor());
	           Long lValorImporteMultAux = new Long(Math.round(gaVentasDTO.getImpVenta().doubleValue()*Math.pow(10,2)));
	   			Double  dValorImporteAux = new Double(lValorImporteMultAux.longValue()/Math.pow(10,2));
	           cstmt.setDouble(4,dValorImporteAux.doubleValue());
	           cstmt.setString(5,gaVentasDTO.getNumContrato());
	           cstmt.setLong(6,gaVentasDTO.getNumVenta().longValue());
	           	   
	           if (logger.isDebugEnabled()) {
					logger.debug(" Registrando salidas");
				}
				//Se procede a descomentar cuando devuelva errores
	           
	           cstmt.registerOutParameter(7, oracle.jdbc.driver.OracleTypes.NUMBER);
				cstmt.registerOutParameter(8, oracle.jdbc.driver.OracleTypes.VARCHAR);
	           cstmt.registerOutParameter(9, oracle.jdbc.driver.OracleTypes.NUMBER);
	           
	           
	           //Campos de devolución
	           
	                       
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
	           
				
	            
				codError =cstmt.getInt(7);
				logger.debug("codError[" + codError + "]");
				msgError = cstmt.getString(8);
				logger.debug("msgError[" + msgError + "]");
	           numEvento = cstmt.getInt(9);
				logger.debug("numEvento[" + numEvento + "]");
	           cstmt=null;

	         

	           if (codError != 0) {
					logger.error(" Ocurrió un error al Insertar Escenario B");
					throw new CustomerBillException(String.valueOf(codError),
								numEvento, msgError); 
				}
	           
	           logger.debug("Recuperando data...");

				logger.debug("Codigo error Escenario B[" + codError + "]");
				
			} catch (CustomerBillException e) {
	           
	           e.printStackTrace();
	           logger.error("Ocurrió un error general al  Insertar Escenario B",e);
				if (logger.isDebugEnabled()) {
					logger.debug("Codigo de Error[" + codError + "]");
					logger.debug("Mensaje de Error[" + msgError + "]");
					logger.debug("Numero de Evento[" + numEvento + "]");
				}
				throw e;
			}catch (Exception e) 
	           {
	         
	           e.printStackTrace();
				logger.error("Ocurrió un error general al  Insertar Escenario B",e);
				if (logger.isDebugEnabled())
	                {
					logger.debug("Codigo de Error[" + codError + "]");
					logger.debug("Mensaje de Error[" + msgError + "]");
					logger.debug("Numero de Evento[" + numEvento + "]");
	               }
	                 throw new CustomerBillException(
						"Ocurrió un error general  al  Insertar Escenario B",e);
	               
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
				logger.debug("updateVentasEscenarioB():end");
			}
	   }
	 public void updateVentasEscenarioC(GaVentasDTO gaVentasDTO)throws CustomerBillException{
			
		   if (logger.isDebugEnabled()) {
	           logger.debug("updateVentasEscenarioC():start");
	       }
	       int codError = 0;
	       String msgError = null;
	       int numEvento = 0;
	       
	       String call=null;
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
			   call=getSQLUpdateVentaEscenarioC();
	       	if (logger.isDebugEnabled()) {
					logger.debug("sql[" + call + "]");
				}
				cstmt = conn.prepareCall(call);
	           
	           if (logger.isDebugEnabled()) {
					logger.debug("Registrando Entradas");				
				}
	           
	           cstmt.setString(1,gaVentasDTO.getIndEstVenta());
	           cstmt.setLong(2,gaVentasDTO.getNumTransaccion().longValue());
	           cstmt.setString(3,gaVentasDTO.getTipValor());
	           cstmt.setDouble(4,gaVentasDTO.getImpVenta().doubleValue());
	           cstmt.setString(5,gaVentasDTO.getNumContrato());
	           cstmt.setLong(6,gaVentasDTO.getNumVenta().longValue());
	           
	           	   
	           if (logger.isDebugEnabled()) {
					logger.debug(" Registrando salidas");
				}
				//Se procede a descomentar cuando devuelva errores
	           
	           cstmt.registerOutParameter(7, oracle.jdbc.driver.OracleTypes.NUMBER);
				cstmt.registerOutParameter(8, oracle.jdbc.driver.OracleTypes.VARCHAR);
	           cstmt.registerOutParameter(9, oracle.jdbc.driver.OracleTypes.NUMBER);
	           
	           
	           //Campos de devolución
	           
	                       
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
	           
				
	            
				codError =cstmt.getInt(7);
				logger.debug("codError[" + codError + "]");
				msgError = cstmt.getString(8);
				logger.debug("msgError[" + msgError + "]");
	           numEvento = cstmt.getInt(9);
				logger.debug("numEvento[" + numEvento + "]");
	           cstmt=null;

	          
	           if (codError != 0) {
					logger.error(" Ocurrió un error al Insertar Escenario C");
					throw new CustomerBillException(String.valueOf(codError),
								numEvento, msgError); 
				}
	           
	           logger.debug("Recuperando data...");

				logger.debug("Codigo error Escenario C[" + codError + "]");
				
			} catch (CustomerBillException e) {

	           e.printStackTrace();
	           logger.error("Ocurrió un error general al  Insertar Escenario C",e);
				if (logger.isDebugEnabled()) {
					logger.debug("Codigo de Error[" + codError + "]");
					logger.debug("Mensaje de Error[" + msgError + "]");
					logger.debug("Numero de Evento[" + numEvento + "]");
				}
				throw e;
			}catch (Exception e) 
	           {
	           e.printStackTrace();
				logger.error("Ocurrió un error general al  Insertar Escenario C",e);
				if (logger.isDebugEnabled())
	                {
					logger.debug("Codigo de Error[" + codError + "]");
					logger.debug("Mensaje de Error[" + msgError + "]");
					logger.debug("Numero de Evento[" + numEvento + "]");
	               }
	                 throw new CustomerBillException(
						"Ocurrió un error general  al  Insertar Escenario C",e);
	               
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
				logger.debug("updateVentasEscenarioC():end");
			}
	   }
	 public void updateVentasEscenarioD(GaVentasDTO gaVentasDTO)throws CustomerBillException{
			
		   if (logger.isDebugEnabled()) {
	           logger.debug("updateVentasEscenarioD():start");
	       }
	       int codError = 0;
	       String msgError = null;
	       int numEvento = 0;
	       
	       String call=null;
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
			   call=getSQLUpdateVentaEscenarioD();
	       	if (logger.isDebugEnabled()) {
					logger.debug("sql[" + call + "]");
				}
				cstmt = conn.prepareCall(call);
	           
	           if (logger.isDebugEnabled()) {
					logger.debug("Registrando Entradas");				
				}
	           
	           cstmt.setString(1,gaVentasDTO.getIndEstVenta());
	           cstmt.setLong(2,gaVentasDTO.getNumTransaccion().longValue());
	           cstmt.setDouble(3,gaVentasDTO.getImpVenta().doubleValue());
	           cstmt.setString(4,gaVentasDTO.getNumContrato());
	           cstmt.setLong(5,gaVentasDTO.getNumVenta().longValue());
	           	   
	           if (logger.isDebugEnabled()) {
					logger.debug(" Registrando salidas");
				}
				//Se procede a descomentar cuando devuelva errores
	           
	           cstmt.registerOutParameter(6, oracle.jdbc.driver.OracleTypes.NUMBER);
				cstmt.registerOutParameter(7, oracle.jdbc.driver.OracleTypes.VARCHAR);
	           cstmt.registerOutParameter(8, oracle.jdbc.driver.OracleTypes.NUMBER);
	           
	           
	           //Campos de devolución
	           
	                       
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
	           
				
	            
				codError =cstmt.getInt(6);
				logger.debug("codError[" + codError + "]");
				msgError = cstmt.getString(7);
				logger.debug("msgError[" + msgError + "]");
	           numEvento = cstmt.getInt(8);
				logger.debug("numEvento[" + numEvento + "]");
	           cstmt=null;

	           if (codError != 0) {
					logger.error(" Ocurrió un error al Insertar Escenario D");
					throw new CustomerBillException(String.valueOf(codError),
								numEvento, msgError); 
				}
	           
	           logger.debug("Recuperando data...");

				logger.debug("Codigo error Escenario D[" + codError + "]");
				
			} catch (CustomerBillException e) {
	           e.printStackTrace();
	           logger.error("Ocurrió un error general al  Insertar Escenario D",e);
				if (logger.isDebugEnabled()) {
					logger.debug("Codigo de Error[" + codError + "]");
					logger.debug("Mensaje de Error[" + msgError + "]");
					logger.debug("Numero de Evento[" + numEvento + "]");
				}
				throw e;
			}catch (Exception e) 
	           {
	           e.printStackTrace();
				logger.error("Ocurrió un error general al  Insertar Escenario D",e);
				if (logger.isDebugEnabled())
	                {
					logger.debug("Codigo de Error[" + codError + "]");
					logger.debug("Mensaje de Error[" + msgError + "]");
					logger.debug("Numero de Evento[" + numEvento + "]");
	               }
	                 throw new CustomerBillException(
						"Ocurrió un error general  al  Insertar Escenario D",e);
	               
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
				logger.debug("updateVentasEscenarioD():end");
			}
	   }
	 public void updateVentasEscenarioA(GaVentasDTO gaVentasDTO)throws CustomerBillException{
			
		   if (logger.isDebugEnabled()) {
	           logger.debug("updateVentasEscenarioA():start");
	       }
	       int codError = 0;
	       String msgError = null;
	       int numEvento = 0;
	       
	       String call=null;
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
			   call=getSQLUpdateVentaEscenarioA();
	       	if (logger.isDebugEnabled()) {
					logger.debug("sql[" + call + "]");
				}
				cstmt = conn.prepareCall(call);
	           
	           if (logger.isDebugEnabled()) {
					logger.debug("Registrando Entradas");				
				}
	           
	           cstmt.setString(1,gaVentasDTO.getIndEstVenta());
	           cstmt.setLong(2,gaVentasDTO.getNumTransaccion().longValue());
	           cstmt.setString(3,gaVentasDTO.getTipValor());
	           cstmt.setDouble(4,gaVentasDTO.getImpVenta().doubleValue());
	           cstmt.setString(5,gaVentasDTO.getNumContrato());
	           cstmt.setLong(6,gaVentasDTO.getNumVenta().longValue());
	           	   
	           if (logger.isDebugEnabled()) {
					logger.debug(" Registrando salidas");
				}
				//Se procede a descomentar cuando devuelva errores
	           
	           cstmt.registerOutParameter(7, oracle.jdbc.driver.OracleTypes.NUMBER);
				cstmt.registerOutParameter(8, oracle.jdbc.driver.OracleTypes.VARCHAR);
	           cstmt.registerOutParameter(9, oracle.jdbc.driver.OracleTypes.NUMBER);
	           
	           
	           //Campos de devolución
	           
	                       
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
	           
				
	            
				codError =cstmt.getInt(7);
				logger.debug("codError[" + codError + "]");
				msgError = cstmt.getString(8);
				logger.debug("msgError[" + msgError + "]");
	           numEvento = cstmt.getInt(9);
				logger.debug("numEvento[" + numEvento + "]");
	           cstmt=null;

	           
	           if (codError != 0) {
					logger.error(" Ocurrió un error al Insertar Escenario A");
					throw new CustomerBillException(String.valueOf(codError),
								numEvento, msgError); 
				}
	           
	           logger.debug("Recuperando data...");

				logger.debug("Codigo error Escenario A[" + codError + "]");
				
			} catch (CustomerBillException e) {
	           
	           e.printStackTrace();
	           logger.error("Ocurrió un error general al  Insertar Escenario A",e);
				if (logger.isDebugEnabled()) {
					logger.debug("Codigo de Error[" + codError + "]");
					logger.debug("Mensaje de Error[" + msgError + "]");
					logger.debug("Numero de Evento[" + numEvento + "]");
				}
				throw e;
			}catch (Exception e) 
	           {
	            e.printStackTrace();
				logger.error("Ocurrió un error general al  Insertar Escenario A",e);
				if (logger.isDebugEnabled())
	                {
					logger.debug("Codigo de Error[" + codError + "]");
					logger.debug("Mensaje de Error[" + msgError + "]");
					logger.debug("Numero de Evento[" + numEvento + "]");
	               }
	                 throw new CustomerBillException(
						"Ocurrió un error general  al  Insertar Escenario A",e);
	               
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
				logger.debug("updateVentasEscenarioA():end");
			}
	   }
	 
	 public void updateVenta(GaVentasDTO gaVentasDTO)throws CustomerBillException{
		 
		 if (logger.isDebugEnabled()) {
			 logger.debug("updateVenta():start");
		 }
		 int codError = 0;
		 String msgError = null;
		 int numEvento = 0;
		 
		 String call=null;
		 Connection conn = null;
		 CallableStatement cstmt=null;
		 conn = getConection();
		 try {
			 call=getSQLUpdate();
			 if (logger.isDebugEnabled()) {
				 logger.debug("sql[" + call + "]");
			 }
			 cstmt = conn.prepareCall(call);
			 
			 if (logger.isDebugEnabled()) {
				 logger.debug("Registrando Entradas");				
			 }
			 
			 cstmt.setDouble(1,gaVentasDTO.getImpVenta().doubleValue());
			 cstmt.setLong(2,gaVentasDTO.getNumVenta().longValue());
			 cstmt.setDouble(3,gaVentasDTO.getImpAbono().doubleValue());
			 cstmt.setLong(4,gaVentasDTO.getIndAbono().longValue());
					 
			 if (logger.isDebugEnabled()) {
				 logger.debug(" Registrando salidas");
			 }
			 //Se procede a descomentar cuando devuelva errores
			 
			 cstmt.registerOutParameter(5, oracle.jdbc.driver.OracleTypes.NUMBER);
			 cstmt.registerOutParameter(6, oracle.jdbc.driver.OracleTypes.VARCHAR);
			 cstmt.registerOutParameter(7, oracle.jdbc.driver.OracleTypes.NUMBER);
			 
			 
			 //Campos de devolución
			 
			 
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
			 
			 
			 
			 codError =cstmt.getInt(5);
			 logger.debug("codError[" + codError + "]");
			 msgError = cstmt.getString(6);
			 logger.debug("msgError[" + msgError + "]");
			 numEvento = cstmt.getInt(7);
			 logger.debug("numEvento[" + numEvento + "]");
			 cstmt=null;
			 
			 if (codError != 0) {
				 logger.error(" Ocurrió un error general al realizar update de la venta");
				 throw new CustomerBillException(String.valueOf(codError),
						 numEvento, msgError); 
			 }
			 
			 logger.debug("Recuperando data...");
			 
			 logger.debug("Codigo error[" + codError + "]");
			 
		 } catch (CustomerBillException e) {
			 e.printStackTrace();
			 logger.error("Ocurrió un error general al realizar update de la venta",e);
			 if (logger.isDebugEnabled()) {
				 logger.debug("Codigo de Error[" + codError + "]");
				 logger.debug("Mensaje de Error[" + msgError + "]");
				 logger.debug("Numero de Evento[" + numEvento + "]");
			 }
			 throw e;
		 }catch (Exception e) 
		 {
			 e.printStackTrace();
			 logger.error("Ocurrió un error general al realizar update de la venta",e);
			 if (logger.isDebugEnabled())
			 {
				 logger.debug("Codigo de Error[" + codError + "]");
				 logger.debug("Mensaje de Error[" + msgError + "]");
				 logger.debug("Numero de Evento[" + numEvento + "]");
			 }
			 throw new CustomerBillException(
					 "Ocurrió un error general al realizar update de la venta",e);
			 
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
		 
		 if (logger.isDebugEnabled()) {
			 logger.debug("updateVenta():end");
		 }
	 }
	 
	 
	 /**
		 * realiza desreserva de numero celular
		 * @param entrada
		 * @return 
		 * @throws CustomerBillException
		 */
		public void desreservaCelular(GaVentasDTO entrada) throws CustomerBillException{
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			conn = getConection();
			CallableStatement cstmt = null; 
			try {
				logger.debug("Inicio:desreservaCelular");
				
				String call = getSSQLEliminaResCel();

				logger.debug("sql[" + call + "]");

				cstmt = conn.prepareCall(call);
				if (logger.isDebugEnabled()){
	      			logger.debug("Numero Venta:" + entrada.getNumVenta().longValue());
	      			
	      		}
				cstmt.setLong(1,entrada.getNumVenta().longValue());
				cstmt.setLong(2,entrada.getNumTransaccion().longValue());
				cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
				if (logger.isDebugEnabled())
					logger.debug("Inicio:desreservaCelular:execute");
				cstmt.execute();
				if (logger.isDebugEnabled())
					logger.debug("Fin:desreservaCelular:execute");

				codError=cstmt.getInt(3);
				msgError = cstmt.getString(4);
				numEvento=cstmt.getInt(5);
				if (logger.isDebugEnabled()){
					logger.debug("Código Error: " +  cstmt.getInt(3));
					logger.debug("msgError: " +  cstmt.getString(4));
					logger.debug("numEvento: " +  cstmt.getInt(5));
				}
				
				if (codError != 0){
					logger.error("Ocurrió un error al realizar desreserva de celular");
					throw new CustomerBillException(
					"Ocurrió un error al realizar desreserva de celular", String
					.valueOf(codError), numEvento, msgError);
				}
				
			} catch (Exception e) {
				logger.error("Ocurrió un error al realizar desreserva de celular",e);
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
			logger.debug("Fin:desreservaCelular");
		}//fin desreservaCelular
	 
}
