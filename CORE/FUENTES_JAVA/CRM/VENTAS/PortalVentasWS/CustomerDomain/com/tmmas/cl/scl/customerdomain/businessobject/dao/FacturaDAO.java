package com.tmmas.cl.scl.customerdomain.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.MonedaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.PrecioDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.CobroAdelantadoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.FacturaDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.FolioDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.ProrrateoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.helper.Global;

public class FacturaDAO extends ConnectionDAO{
	
	Global global = Global.getInstance();
	private static Category cat = Category.getInstance(FacturaDAO.class);
	

	private Connection getConection() 
	throws CustomerDomainException {
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
	
	private String getSQLDatos(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
        for (int n = 1; n <= paramCount; n++) {
            sb.append("?");
            if (n < paramCount) sb.append(",");
        }
        return sb.append(")}").toString();
	}//fin getSQLDatos
	
	/**
	 * Obtiene path PDF factura 
	 * @param 
	 * @return string
	 * @throws CustomerDomainException
	 */
	public String getPathPDFFactura() 
		throws CustomerDomainException
	{
		   cat.debug("Inicio:getPathPDFFactura()");
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			String sresultado = null;
			Connection conn = null;
			CallableStatement cstmt =null;
			conn = getConection();
			cat.debug("Conexion obtenida OK");
		  try {
			  String call = getSQLDatos("Ve_Servs_ActivacionesWeb_Pg", "VE_getPathPDFFactura_PR",4);
		   cat.debug("sql[" + call + "]");
		   
		   cstmt = conn.prepareCall(call);

		   cstmt.registerOutParameter(1,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(2,java.sql.Types.NUMERIC);
		   cstmt.registerOutParameter(3,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);
		   
		   
		 
		   cat.debug("Inicio:getPathPDFFactura:Execute");
		   cstmt.execute();		   
		   cat.debug("getPathPDFFactura:Execute Despues");
		   
		   codError = cstmt.getInt(2);
		   msgError = cstmt.getString(3);
		   numEvento = cstmt.getInt(4);
		 
		   cat.debug("codError[" + codError + "]");
		   cat.debug("msgError[" + msgError + "]");
		   cat.debug("numEvento[" + numEvento + "]");
		   
		   if (codError != 0) 
		   {
			   
		    codError = 10;
		    numEvento = 10;
		    msgError = "No se pudo recuperar información";
		    
		    cat.error("Ocurrió un error al recuperar path de factura ");
		    throw new CustomerDomainException(
		      "Ocurrió un error al recuperar path de factura", String
		        .valueOf(codError), numEvento, msgError);
		    
			}else
			{
				sresultado = cstmt.getString(1);
			}
		   
		   if (cat.isDebugEnabled())
		    cat.debug(" Finalizo ejecución");
		  } catch (Exception e) {
		   cat.error("Ocurrió un error al obtener path de factura",e);
		   if (cat.isDebugEnabled()) {
		    cat.debug("Codigo de Error[" + codError + "]");
		    cat.debug("Mensaje de Error[" + msgError + "]");
		    cat.debug("Numero de Evento[" + numEvento + "]");
		   }
		   /*retorna error a capa superior Igo*/	
		   if (e instanceof CustomerDomainException ){
                throw (CustomerDomainException) e;
		   }
		   
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
		  cat.debug("getPathPDFFactura():end");
		return sresultado;
	}//fin getPathPDFFactura

	/**
	 * Obtiene Nombre PDF factura 
	 * @param folio
	 * @return string
	 * @throws CustomerDomainException
	 */
	
	public String getNombrePDFFactura(String folio) 
		throws CustomerDomainException
	{
		cat.debug("Inicio:getNombrePDFFacturaa()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		String sresultado = null;
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();
		cat.debug("Conexion obtenida OK");
		try {
			
		   String call = getSQLDatos("Ve_Servs_ActivacionesWeb_Pg", "VE_getNombrePDFFactura_PR",5);
		   cat.debug("sql[" + call + "]");
		   
		   cstmt = conn.prepareCall(call);

		   cstmt.setString(1,folio);
		   cstmt.registerOutParameter(2,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
		   cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);
		   
		   cat.debug("getNombrePDFFactura:Execute antes");
		   cstmt.execute();		 
		   cat.debug("getNombrePDFFactura:Execute Despues");
		   
		   codError = cstmt.getInt(3);
		   msgError = cstmt.getString(4);
		   numEvento = cstmt.getInt(5);
		 
		   cat.debug("codError[" + codError + "]");
		   cat.debug("msgError[" + msgError + "]");
		   cat.debug("numEvento[" + numEvento + "]");
		   
		   if (codError != 0) {
			   
		   
			   
		    
		    if (codError == 5)
		    {
		        msgError="Folio ya fue consultado";
		    }
		    else
		    { 
		        codError=10;
		        msgError = "No se pudo recuperar información verifique existencia folio";	
		    }
		    
		    cat.error("Ocurrió un error al recuperar nombre de factura ");
		    throw new CustomerDomainException(
		      "Ocurrió un error al recuperar nombre de factura: "+ msgError, String
		        .valueOf(codError), numEvento, msgError);
		    
			}else
			{
				sresultado = cstmt.getString(2);
			}
		   
		   if (cat.isDebugEnabled())
		    cat.debug(" Finalizo ejecución");
		  } catch (Exception e) {
		   cat.error("Ocurrió un error al obtener nombre de factura",e);
		   if (cat.isDebugEnabled()) {
		    cat.debug("Codigo de Error[" + codError + "]");
		    cat.debug("Mensaje de Error[" + msgError + "]");
		    cat.debug("Numero de Evento[" + numEvento + "]");
		   }
		   /*retorna error a capa superior Igo*/	
		   if (e instanceof CustomerDomainException ){
                throw (CustomerDomainException) e;
		   }
		   
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
		  cat.debug("getNombrePDFFactura():end");
		return sresultado;
	}//fin getPathPDFFactura


	/**
	 * Obtiene datos del ciclo de facturacion mas procimo
	 * @param folio
	 * @return string
	 * @throws CustomerDomainException
	 */
	
	public FacturaDTO getDatosCicloFacturacion()
		throws CustomerDomainException
	{
		cat.debug("Inicio:getDatosCicloFacturacion()");
		
		FacturaDTO facturaDTO = null; 
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt =null;
		
		conn = getConection();
		cat.debug("Conexion obtenida OK");

		try {
		   String call = getSQLDatos("Ve_Servs_ActivacionesWeb_Pg", "VE_getCicloFactMasProx_PR",28);
		   cat.debug("sql[" + call + "]");
		   cstmt = conn.prepareCall(call);
		   cstmt.registerOutParameter(1,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(2,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(3,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(5,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(6,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(7,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(8,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(9,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(10,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(11,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(12,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(13,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(14,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(15,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(16,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(17,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(18,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(19,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(20,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(21,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(22,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(23,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(24,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(25,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(26,java.sql.Types.NUMERIC);
		   cstmt.registerOutParameter(27,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(28,java.sql.Types.NUMERIC);
		   cstmt.execute();
		   codError = cstmt.getInt(26);
		   msgError = cstmt.getString(27);
		   numEvento = cstmt.getInt(28);
		 
		   cat.debug("codError[" + codError + "]");
		   cat.debug("msgError[" + msgError + "]");
		   cat.debug("numEvento[" + numEvento + "]");
		   
		   if (codError != 0) {
			   codError = 10;
			   numEvento = 10;
			   msgError = "No se pudo recuperar información";
		       cat.error("Ocurrió un error al recuperar datos de facuracion");
		       throw new CustomerDomainException("Ocurrió un error al datos de facturación", String.valueOf(codError), numEvento, msgError);
		    }else{
		    	facturaDTO = new FacturaDTO();
		    	facturaDTO.setCodigoCiclo(cstmt.getString(1));
			}
		   
		
		} 
		catch (Exception e) {
		   cat.error("Ocurrió un error al obtener nombre de factura",e);
		   if (cat.isDebugEnabled()) {
		    cat.debug("Codigo de Error[" + codError + "]");
		    cat.debug("Mensaje de Error[" + msgError + "]");
		    cat.debug("Numero de Evento[" + numEvento + "]");
		   }
		} 
		finally {
		   if (cat.isDebugEnabled()) cat.debug("Cerrando conexiones...");
		   try {
			 if (cstmt!=null) cstmt.close();
			 if (!conn.isClosed()) conn.close();
		   } catch (SQLException e) {
			 cat.debug("SQLException", e);
		   }
		}
		cat.debug("getNombrePDFFactura():end");
		return facturaDTO;
	}
	
	public FolioDTO getFolio(FolioDTO entrada)
		throws CustomerDomainException
	{
		cat.debug("Inicio:getFolio()");
		
		FolioDTO folioDTO = null; 
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt =null;
		
		conn = getConection();
		cat.debug("Conexion obtenida OK");
	
		try {
		   String call = getSQLDatos("FA_Servicios_Facturacion_PG", "FA_getFolios_PR",8);
		   cat.debug("sql[" + call + "]");
		   cstmt = conn.prepareCall(call);
		   cstmt.setLong(1,entrada.getCodCliente());
		   cat.debug("entrada.getCodCliente()[" + entrada.getCodCliente() + "]");
		   cstmt.setString(2,entrada.getCodOficina());
		   cat.debug("entrada.getCodOficina()[" + entrada.getCodOficina() + "]");
		  
		   cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
		   cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(5,java.sql.Types.VARCHAR);
		   
		   cstmt.registerOutParameter(6,java.sql.Types.NUMERIC);
		   cstmt.registerOutParameter(7,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(8,java.sql.Types.NUMERIC);
		   cstmt.execute();
		   codError = cstmt.getInt(6);
		   msgError = cstmt.getString(7);
		   numEvento = cstmt.getInt(8);
		 
		   cat.debug("codError[" + codError + "]");
		   cat.debug("msgError[" + msgError + "]");
		   cat.debug("numEvento[" + numEvento + "]");
		   
		   if (codError != 0) {
			   codError = 10;
			   numEvento = 10;			   
		       cat.error("Ocurrió un error al recuperar los datos del folio");
		       throw new CustomerDomainException(msgError, String.valueOf(codError), numEvento, msgError);
		    }else{
		    	folioDTO = new FolioDTO();
		    	folioDTO.setCodTipDocum(cstmt.getLong(3));
		    	folioDTO.setDesTipDocum(cstmt.getString(4));
		    	folioDTO.setFolio(cstmt.getString(5));
			}
		   
		
		} 
		catch (Exception e) {
		   cat.error("Ocurrió un error al recuperar los datos del folio",e);
		   if (cat.isDebugEnabled()) {
		    cat.debug("Codigo de Error[" + codError + "]");
		    cat.debug("Mensaje de Error[" + msgError + "]");
		    cat.debug("Numero de Evento[" + numEvento + "]");
		   }
		    if (e instanceof CustomerDomainException ){ 
	            throw (CustomerDomainException) e;
		   }else {
				CustomerDomainException c = new CustomerDomainException();
				c.setMessage(e.getMessage());  
				throw c;
			}
		}
		finally {
		   if (cat.isDebugEnabled()) cat.debug("Cerrando conexiones...");
		   try {
			 if (cstmt!=null) cstmt.close();
			 if (!conn.isClosed()) conn.close();
		   } catch (SQLException e) {
			 cat.debug("SQLException", e);
		   }
		}
		cat.debug("getFolio():end");
		return folioDTO;

		}
	
	public void insertaCobroAdelantado(CobroAdelantadoDTO entrada)
		throws CustomerDomainException
	{
		cat.debug("Inicio:insertaCobroAdelantado()");		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt =null;
		
		conn = getConection();
		cat.debug("Conexion obtenida OK");
	
		try {
		   String call = getSQLDatos("FA_Servicios_Facturacion_PG", "FA_InsertaCobroAdelantadoUs_PR",12);
		   cat.debug("sql[" + call + "]");
		   
		   cstmt = conn.prepareCall(call);
		   cstmt.setLong(1,entrada.getCodCliente());
		   cat.debug("entrada.getCodCliente() : " + entrada.getCodCliente());
		   cstmt.setLong(2,entrada.getNumAbonado());
		   cat.debug("entrada.getNumAbonado() : " + entrada.getNumAbonado());
		   cstmt.setLong(3,entrada.getNumVenta());
		   cat.debug("entrada.getNumVenta() : " + entrada.getNumVenta());
		   cstmt.setLong(4,entrada.getCodCicloFacturacion());
		   cat.debug("entrada.getCodCicloFacturacion() : " + entrada.getCodCicloFacturacion());
		   cstmt.setLong(5,entrada.getCodConcepto());
		   cat.debug("entrada.getCodConcepto() : " + entrada.getCodConcepto());
		   cstmt.setLong(6,entrada.getNumProceso());
		   cat.debug("entrada.getNumProceso() : " + entrada.getNumProceso());
		   cstmt.setInt(7,entrada.getTipoServicioCobroAdelantado());
		   cat.debug("entrada.getTipoServicioCobroAdelantado() : " + entrada.getTipoServicioCobroAdelantado());
		   cstmt.setString(8,entrada.getUsuario());
		   cat.debug("entrada.getUsuario() : " + entrada.getUsuario());		   
		   cstmt.registerOutParameter(9,java.sql.Types.NUMERIC);
		   cstmt.registerOutParameter(10,java.sql.Types.NUMERIC);
		   cstmt.registerOutParameter(11,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(12,java.sql.Types.NUMERIC);
		   cstmt.execute();
		   codError = cstmt.getInt(10);
		   msgError = cstmt.getString(11);
		   numEvento = cstmt.getInt(12);
		 
		   cat.debug("codError[" + codError + "]");
		   cat.debug("msgError[" + msgError + "]");
		   cat.debug("numEvento[" + numEvento + "]");
		   
		   if (codError != 0) {			   		   
		       cat.error("Ocurrió un error al insertar el cobro adelantado");
		       throw new CustomerDomainException(msgError, String.valueOf(codError), numEvento, msgError);
		    }
		} catch (Exception e) {
		   cat.error("Ocurrió un error al insertar el cobro adelantado",e);
		   if (cat.isDebugEnabled()) {
		    cat.debug("Codigo de Error[" + codError + "]");
		    cat.debug("Mensaje de Error[" + msgError + "]");
		    cat.debug("Numero de Evento[" + numEvento + "]");
		   }
		    if (e instanceof CustomerDomainException ){ 
	            throw (CustomerDomainException) e;
		   }else {
				CustomerDomainException c = new CustomerDomainException();
				c.setMessage(e.getMessage());  
				throw c;
			}
		}
		finally {
		   if (cat.isDebugEnabled()) cat.debug("Cerrando conexiones...");
		   try {
			 if (cstmt!=null) cstmt.close();
			 if (!conn.isClosed()) conn.close();
		   } catch (SQLException e) {
			 cat.debug("SQLException", e);
		   }
		}
		cat.debug("insertaCobroAdelantado():end");	
	
		}
	
	public ProrrateoDTO getProrrateo(ProrrateoDTO entrada)
		throws CustomerDomainException
	{
		cat.debug("Inicio:getProrrateo()");
		
		ProrrateoDTO resultado = null; 
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt =null;
		
		conn = getConection();
		cat.debug("Conexion obtenida OK");
	
		try {
		   String call = getSQLDatos("FA_Servicios_Facturacion_PG", "FA_getProrrateo_PR",6);
		   cat.debug("sql[" + call + "]");
		   cstmt = conn.prepareCall(call);
		   cstmt.setLong(1,entrada.getNumAbonado());
		   cstmt.setDouble(2,entrada.getImporte());
		  
		   cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
		   
		   cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);
		   cstmt.registerOutParameter(5,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(6,java.sql.Types.NUMERIC);
		   
		   cstmt.execute();
		   
		   codError = cstmt.getInt(4);
		   msgError = cstmt.getString(5);
		   numEvento = cstmt.getInt(6);
		 
		   cat.debug("codError[" + codError + "]");
		   cat.debug("msgError[" + msgError + "]");
		   cat.debug("numEvento[" + numEvento + "]");
		   
		   if (codError != 0) {
			   
		       cat.error("Ocurrió un error al recuperar el prorrateo");
		       throw new CustomerDomainException(msgError, String.valueOf(codError), numEvento, 
		    		   "Ocurrió un error al recuperar el prorrateo");
		    }else{
		    	resultado = new ProrrateoDTO();
		    	resultado.setImporte(cstmt.getDouble(3));
			}
		} 
		catch (Exception e) {
		   cat.error("Ocurrió un error al recuperar el prorrateo",e);
		   if (cat.isDebugEnabled()) {
		    cat.debug("Codigo de Error[" + codError + "]");
		    cat.debug("Mensaje de Error[" + msgError + "]");
		    cat.debug("Numero de Evento[" + numEvento + "]");
		   }
		    if (e instanceof CustomerDomainException ){ 
	            throw (CustomerDomainException) e;
		   }else {
				CustomerDomainException c = new CustomerDomainException();
				c.setMessage(e.getMessage());  
				throw c;
			}
		}
		finally {
		   if (cat.isDebugEnabled()) cat.debug("Cerrando conexiones...");
		   try {
			 if (cstmt!=null) cstmt.close();
			 if (!conn.isClosed()) conn.close();
		   } catch (SQLException e) {
			 cat.debug("SQLException", e);
		   }
		}
		cat.debug("getProrrateo():end");
		return resultado;
	
		}
	
	public PrecioDTO obtenerMontoImporteCargoRec(Long codCargo)
		throws CustomerDomainException
	{
		cat.debug("Inicio:obtenerMontoImporteCargoRec()");
		
		PrecioDTO resultado = null; 
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt =null;
		String mensaje = "Ocurrió un error al obtener el importe del cargo recurrente";
		
		conn = getConection();
		cat.debug("Conexion obtenida OK");
	
		try {
		   String call = getSQLDatos("Ve_Servicios_Solicitud_Pg", "VE_obtiene_montoCargoRec_PR",6);
		   cat.debug("sql[" + call + "]");
		   cstmt = conn.prepareCall(call);
		   cstmt.setLong(1,codCargo.longValue());		   
		  
		   cstmt.registerOutParameter(2,java.sql.Types.NUMERIC);
		   cstmt.registerOutParameter(3,java.sql.Types.VARCHAR);
		   
		   cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);
		   cstmt.registerOutParameter(5,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(6,java.sql.Types.NUMERIC);
		   
		   cstmt.execute();
		   
		   codError = cstmt.getInt(4);
		   msgError = cstmt.getString(5);
		   numEvento = cstmt.getInt(6);
		 
		   cat.debug("codError[" + codError + "]");
		   cat.debug("msgError[" + msgError + "]");
		   cat.debug("numEvento[" + numEvento + "]");
		   
		   if (codError != 0) {
			   
		       cat.error(mensaje);
		       throw new CustomerDomainException(msgError, String.valueOf(codError), numEvento, mensaje);
		    }else{
		    	resultado = new PrecioDTO();
		    	resultado.setMonto(cstmt.getDouble(2));
		    	MonedaDTO moneda = new MonedaDTO();
		    	moneda.setCodigo(cstmt.getString(3));
		    	resultado.setUnidad(moneda);
			}
		} 
		catch (Exception e) {
		   cat.error(mensaje,e);
		   if (cat.isDebugEnabled()) {
		    cat.debug("Codigo de Error[" + codError + "]");
		    cat.debug("Mensaje de Error[" + msgError + "]");
		    cat.debug("Numero de Evento[" + numEvento + "]");
		   }
		    if (e instanceof CustomerDomainException ){ 
	            throw (CustomerDomainException) e;
		   }else {
				CustomerDomainException c = new CustomerDomainException();
				c.setMessage(e.getMessage());  
				throw c;
			}
		}
		finally {
		   if (cat.isDebugEnabled()) cat.debug("Cerrando conexiones...");
		   try {
			 if (cstmt!=null) cstmt.close();
			 if (!conn.isClosed()) conn.close();
		   } catch (SQLException e) {
			 cat.debug("SQLException", e);
		   }
		}
		cat.debug("obtenerMontoImporteCargoRec():end");
		return resultado;	
	}
}

