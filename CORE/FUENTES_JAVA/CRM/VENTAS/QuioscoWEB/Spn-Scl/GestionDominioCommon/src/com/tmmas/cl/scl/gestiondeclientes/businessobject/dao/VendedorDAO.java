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
 * 23/01/2007     Héctor Hermosilla      					Versión Inicial
 */

package com.tmmas.cl.scl.gestiondeclientes.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.DatosValidacionDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ArticuloResDesInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.BodegaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ParametrosValidacionVentasDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ResultadoValidacionVentaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.VendedorDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsArticuloImeiInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsArticuloImeiOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsArticuloResDesOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsArticuloVendedorOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListadoCausalesVentasOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListTipoComisionistaOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsCausalesVentasOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsOficinaInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsTipoComisionistaOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsVendedorStockInDTO;
import com.tmmas.cl.scl.gestiondeclietnes.businessobject.helper.Global;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.DireccionNegocioDTO;


public class VendedorDAO extends ConnectionDAO{
	private final Logger logger = Logger.getLogger(VendedorDAO.class);
	Global global = Global.getInstance();
	
	private Connection getConection() throws GeneralException
	{
		Connection conn = null;
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
		} catch (Exception e1) {
			conn = null;
			logger.error(" No se pudo obtener una conexión ", e1);
			throw new GeneralException("No se pudo obtener una conexión", e1);
		}
		
		return conn;
	}
	
	private String getSQLDatosVendedor(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
        for (int n = 1; n <= paramCount; n++) {
            sb.append("?");
            if (n < paramCount) sb.append(",");
        }
        return sb.append(")}").toString();
	
	}
	
	public VendedorDTO getVendedor(VendedorDTO vendedor) throws GeneralException{
		if (logger.isDebugEnabled()) 
			logger.debug("getVendedor:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		if (logger.isDebugEnabled()) 
			logger.debug("Coneccion obtenida OK");
		try {
			//INI-01 (AL) - 07.07.2011 - String call = getSQLDatosVendedor("VE_servicios_venta_PG","VE_datosvendedor_PR",18);
			String call = getSQLDatosVendedor("VE_servicios_venta_quiosco_PG","VE_datosvendedor_PR",18);
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setInt(1,Integer.parseInt(vendedor.getCodigoVendedor()));
			logger.debug("vendedor.getCodigoVendedor() ["+vendedor.getCodigoVendedor()+"]");
			cstmt.setLong(2,vendedor.getCodigoVendedorDealer());
			logger.debug("vendedor.getCodigoVendedorDealer() ["+vendedor.getCodigoVendedorDealer()+"]");
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(13, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(14, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(15, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(16, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(18, java.sql.Types.NUMERIC);
			if (logger.isDebugEnabled()) 
				logger.debug("Execute Antes");
			cstmt.execute();
			if (logger.isDebugEnabled()) 
				logger.debug("Execute Despues");
			
			codError = cstmt.getInt(16);
			msgError = cstmt.getString(17);
			numEvento = cstmt.getInt(18);
			
			logger.debug("codError[" + codError + "]");
			logger.debug("msgError[" + msgError + "]");
			logger.debug("numEvento[" + numEvento + "]");
			
	
			if (codError != 0) {
				logger.error("Ocurrió un error al consultar el Vendedor");
				throw new GeneralException(
						"Ocurrió un error al consultar el vendedor", String
								.valueOf(codError), numEvento, msgError);
				
			}else{
				if (logger.isDebugEnabled()) 
					logger.debug("Llenado Vendedor");
				vendedor.setNombreVendedor(cstmt.getString(3));
				vendedor.setNombreDealer(cstmt.getString(4));
				vendedor.setCodigoCliente(String.valueOf(cstmt.getInt(5)));
				vendedor.setCodigoVendedorRaiz(cstmt.getLong(6));
				DireccionNegocioDTO direccion = new DireccionNegocioDTO();
				direccion.setRegion(cstmt.getString(7));
				direccion.setProvincia(cstmt.getString(8));
				direccion.setCiudad(cstmt.getString(9));
				vendedor.setDireccion(direccion);
				vendedor.setCodigoOficina(cstmt.getString(10));
				vendedor.setCodTipComisionista(cstmt.getString(11));
				vendedor.setDesTipComisionista(cstmt.getString(12));
				vendedor.setIndicadorTipoVenta(cstmt.getInt(13));
				vendedor.setIndicadorBloqueo(cstmt.getInt(14));				
				vendedor.setCodigoCuenta(cstmt.getString(15));
				if (logger.isDebugEnabled())
					logger.debug("Fin Llenado Vendedor");
			}
			if (vendedor.getCodigoVendedor() == null) {
				msgError = "No se pudo rescatar la Información";
				logger.error("Ocurrió un error al consultar el Vendedor");
				throw new GeneralException(
						"Ocurrió un error al consultar el vendedor", String
								.valueOf(12264), numEvento, "Error al recuperar informacion del Vendedor");
			}
			
			
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
			// Recuperacion de valores de salida

		} catch (GeneralException e) {
		throw e;
		
		} catch (Exception e) {
			logger.error("Ocurrió un error al consultar el vendedor",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al consultar el vendedor",e);
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
		if (logger.isDebugEnabled()) 
			logger.debug("getVendedorExterno():end");

		return vendedor;
	}
	
	
	public DatosValidacionDTO getVendedorNumero(ParametrosValidacionVentasDTO entradaVendedorNumero) throws GeneralException{
		DatosValidacionDTO resultado = new DatosValidacionDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			logger.debug("Inicio:getVendedorNumero()");
			
			//INI-01 (AL) String call = getSQLDatosVendedor("VE_validacion_linea_PG","VE_vendedor_numero_PR",7);
			String call = getSQLDatosVendedor("VE_validacion_linea_quiosco_PG","VE_vendedor_numero_PR",7);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setLong(1,Long.parseLong(entradaVendedorNumero.getNumeroCelular()));
			cstmt.setLong(2,Long.parseLong(entradaVendedorNumero.getCodigoCliente()));
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getVendedorNumero:execute");
			cstmt.execute();
			logger.debug("Fin:getVendedorNumero:execute");

			codError = cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento = cstmt.getInt(7);
			
			logger.debug("codError[" + codError + "]");
			logger.debug("msgError[" + msgError + "]");
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error("Ocurrió un error al obtener vendedor reserva numero");
				throw new GeneralException(
						"Ocurrió un error al obtener vendedor reserva numero", String
								.valueOf(codError), numEvento, msgError);
				
			}else
				resultado.setVendedorNumeroValido(cstmt.getInt(2));
		
		} catch (GeneralException e) {
			throw e;		
		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener vendedor reserva numero",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
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
		
		logger.debug("Fin:getVendedorNumero");

		return resultado;
		
	}
	
	public ResultadoValidacionVentaDTO getExisteVendedorEnBodegaSimcard(ParametrosValidacionVentasDTO entradaValidacionVentas) throws GeneralException{
		ResultadoValidacionVentaDTO resultado = new ResultadoValidacionVentaDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:getExisteVendedorEnBodegaSimcard");
			
			//INI-01 (AL) String call = getSQLDatosVendedor("VE_validacion_linea_PG","VE_vendedorbodega_PR",6);
			String call = getSQLDatosVendedor("VE_validacion_linea_quiosco_PG","VE_vendedorbodega_PR",6);

			logger.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,entradaValidacionVentas.getCodigoVendedor());
			logger.debug("entradaValidacionVentas.getCodigoVendedor() ["+entradaValidacionVentas.getCodigoVendedor()+"]");
			cstmt.setString(2,entradaValidacionVentas.getCodigoBodega());
			logger.debug("entradaValidacionVentas.getCodigoBodega() ["+entradaValidacionVentas.getCodigoBodega()+"]");
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getExisteVendedorEnBodegaSimcard:execute");
			cstmt.execute();
			logger.debug("Fin:getExisteVendedorEnBodegaSimcard:execute");

			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);
			
			logger.debug("codError[" + codError + "]");
			logger.debug("msgError[" + msgError + "]");
			logger.debug("numEvento[" + numEvento + "]");

			if (codError != 0) {
				logger.error("Ocurrió un error al buscar vendedor en bodega (simcard)");
				throw new GeneralException(
						"Ocurrió un error al buscar vendedor en bodega (simcard)", String
								.valueOf(codError), numEvento, msgError);				
			}else{
			
				if (cstmt.getInt(3) == 0)
					logger.debug("VENDEDOR <<< EXISTE >>> EN BODEGA");
				else
					logger.debug("VENDEDOR <<< NO EXISTE >>> EN BODEGA");
	
				resultado.setResultadoBase(cstmt.getInt(3));
			}
		} catch (GeneralException e) {
			throw e;		
		} catch (Exception e) {
			logger.error("Ocurrió un error al buscar vendedor en bodega (simcard)",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
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

		logger.debug("Fin:getExisteVendedorEnBodegaSimcard");

		return resultado;
	}//fin getExisteVendedorEnBodegaSimcard

	public ResultadoValidacionVentaDTO getExisteVendedorEnBodegaTerminal(ParametrosValidacionVentasDTO entradaValidacionVentas) throws GeneralException{
		ResultadoValidacionVentaDTO resultado = new ResultadoValidacionVentaDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:getExisteVendedorEnBodegaTerminal");
			
			//INI-01 (AL) String call = getSQLDatosVendedor("VE_validacion_linea_PG","VE_vendedorbodega_PR",6);
			String call = getSQLDatosVendedor("VE_validacion_linea_quiosco_PG","VE_vendedorbodega_PR",6);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,entradaValidacionVentas.getCodigoVendedor());
			cstmt.setString(2,entradaValidacionVentas.getCodigoBodega());
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getExisteVendedorEnBodegaTerminal:execute");
			cstmt.execute();
			logger.debug("Fin:getExisteVendedorEnBodegaTerminal:execute");

			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);
			
			logger.debug("codError[" + codError + "]");
			logger.debug("msgError[" + msgError + "]");
			logger.debug("numEvento[" + numEvento + "]");

			if (codError != 0) {
				logger.error("Ocurrió un error al buscar vendedor en bodega (terminal)");
				throw new GeneralException(
						"Ocurrió un error al buscar vendedor en bodega (terminal)", String
								.valueOf(codError), numEvento, msgError);				
			}else{
			
				if (cstmt.getInt(3)==1)
					logger.debug("VENDEDOR <<< EXISTE >>> EN BODEGA");
				else
					logger.debug("VENDEDOR <<< NO EXISTE >>> EN BODEGA");
	
				resultado.setResultadoBase(cstmt.getInt(3));
			}
		} catch (GeneralException e) {
			throw e;		
		} catch (Exception e) {
			logger.error("Ocurrió un error al buscar vendedor en bodega (terminal)",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
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

		logger.debug("Fin:getExisteVendedorEnBodegaTerminal");

		return resultado;
	}//fin getExisteVendedorEnBodegaTerminal

	public void setBloqueaDesbloqueaVendedor(VendedorDTO vendedor) throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:setBloqueaDesbloqueaVendedor");
			
			//INI-01 (AL) String call = getSQLDatosVendedor("VE_intermediario_PG","VE_bloqdesbloq_vendedor_PR",5);
			String call = getSQLDatosVendedor("VE_intermediario_Quiosco_PG","VE_bloqdesbloq_vendedor_PR",5);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,vendedor.getCodigoVendedor());
			cstmt.setString(2,vendedor.getCodigoAccionBloqueo());
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:setBloqueaDesbloqueaVendedor:execute");
			cstmt.execute();
			logger.debug("Fin:setBloqueaDesbloqueaVendedor:execute");

			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);
			
			logger.debug("codError[" + codError + "]");
			logger.debug("msgError[" + msgError + "]");
			logger.debug("numEvento[" + numEvento + "]");

			if (codError != 0) {
				logger.error("Ocurrió un error al bloquear/desbloquear el vendedor");
				throw new GeneralException(
						"Ocurrió un error al bloquear/desbloquear el vendedor", String
								.valueOf(codError), numEvento, msgError);				
			}else{
				
				if (cstmt.getInt(3)==0) 
					logger.debug("OPERACION SOBRE EL VENDEDOR <"+ vendedor.getCodigoVendedor() +"> OK ["+ vendedor.getCodigoAccionBloqueo()+" ]");
				else
					logger.debug("OPERACION SOBRE EL VENDEDOR <"+ vendedor.getCodigoVendedor() +"> NO OK ["+ vendedor.getCodigoAccionBloqueo()+" ]");
			}
		} catch (GeneralException e) {
			throw e;		
		} catch (Exception e) {
			logger.error("Ocurrió un error al bloquear/desbloquear el vendedor",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
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

		logger.debug("Fin:setBloqueaDesbloqueaVendedor");

	}//fin getExisteVendedorEnBodegaTerminal

	public ResultadoValidacionVentaDTO validaCodigoVendedor(VendedorDTO vendedordto) throws GeneralException{
		boolean resultado = false;
		int codError = 0;
		String msgError = null;
		ResultadoValidacionVentaDTO resultadovalidacion = new ResultadoValidacionVentaDTO();
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:validaCodigoVendedor");
			//INI-01 (AL) String call = getSQLDatosVendedor("VE_servicios_venta_PG","VE_valida_codigo_vendedor_PR",5);
			String call = getSQLDatosVendedor("VE_servicios_venta_quiosco_PG","VE_valida_codigo_vendedor_PR",5);
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setInt(1,Integer.parseInt(vendedordto.getCodigoVendedor()));
			cstmt.registerOutParameter(2,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.execute();
			
			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			logger.debug("codError[" + codError + "]");
			logger.debug("msgError[" + msgError + "]");
			logger.debug("numEvento[" + numEvento + "]");

			if (codError != 0) {
				logger.error("Ocurrió un error en validaCodigoVendedor");
				throw new GeneralException(
						"Ocurrió un error en validaCodigoVendedor", String
								.valueOf(codError), numEvento, msgError);				
			}else{
			
				int res = cstmt.getInt(2);
				resultado = res==1?true:false;
				String mensaje = res==1?"Validacion exitosa":"No se puede ejecutar, usuario no es vendedor"; 
				resultadovalidacion.setResultado(resultado);
				resultadovalidacion.setMensajeValidacion(mensaje);
			
			}
		
		} catch (GeneralException e) {
			throw e;		
		} catch (Exception e) {
			logger.error("Ocurrió un error en validaCodigoVendedor",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
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
		logger.debug("Fin:validaCodigoVendedor");
		return resultadovalidacion;
	}//fin validaCodigoVendedor
	
   
	// Verifica si un vendedor es externo
	public VendedorDTO verificaVendedorEsExterno (VendedorDTO vendedor) throws GeneralException{
		logger.debug("verificaVendedorEsExterno:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		logger.debug("Coneccion obtenida OK");
		try {
			//INI-01 (AL) String call = getSQLDatosVendedor("VE_servicios_venta_PG","VE_es_vendedor_externo_PR",5);
			String call = getSQLDatosVendedor("VE_servicios_venta_quiosco_PG","VE_es_vendedor_externo_PR",5);
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setInt(1,Integer.parseInt(vendedor.getCodigoVendedor()));
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			logger.debug("Execute Antes"+ vendedor.getCodigoVendedor());
			cstmt.execute();
			logger.debug("Execute Despues");
			
			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			logger.debug("codError[" + codError + "]");
			logger.debug("msgError[" + msgError + "]");
			logger.debug("numEvento[" + numEvento + "]");

			if (codError != 0) {
				logger.error("currió un error al consultar el vendedor");
				throw new GeneralException(
						"currió un error al consultar el vendedor", String
								.valueOf(codError), numEvento, msgError);				
			}else{			
				int res = cstmt.getInt(2);
				boolean resultado = res==1?true:false;
				vendedor.setVendedorInterno(!resultado);
			}
		} catch (GeneralException e) {
			throw e;		
		} catch (Exception e) {
			logger.error("Ocurrió un error al consultar el vendedor",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException("Ocurrió un error al consultar el vendedor",e);
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
		logger.debug("verificaVendedorEsExterno():end");
		return vendedor;
	}
	/**
	 * Obtiene rango de descuentos asignados al vendedor
	 * @param vendedor
	 * @return vendedor
	 * @throws GeneralException
	 */
	public VendedorDTO getRangoDescuento(VendedorDTO vendedor) throws GeneralException{
		logger.debug("getRangoDescuento():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		logger.debug("Coneccion obtenida OK");
		try {
			//INI-01 (AL) String call = getSQLDatosVendedor("Ve_Servicios_Venta_Pg","VE_con_rango_descto_vend_PR",9);
			String call = getSQLDatosVendedor("Ve_Servicios_Venta_Quiosco_Pg","VE_con_rango_descto_vend_PR",9);
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setInt(1,Integer.parseInt(vendedor.getCodigoVendedor()));
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);
			logger.debug("Execute Antes"+ vendedor.getCodigoVendedor());
			cstmt.execute();
			logger.debug("Execute Despues");
			
			codError = cstmt.getInt(7);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(8);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(9);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError == 0){
				vendedor.setPuntoDesctoInferior(cstmt.getFloat(2));
				vendedor.setPuntoDesctoSuperior(cstmt.getFloat(3));
				vendedor.setPorcentajeDesctoInferior(cstmt.getFloat(4));
				vendedor.setPorcentajeDesctoSuperior(cstmt.getFloat(5));
				vendedor.setAplicaDescuento(true);
				//vendedor.setAplicaDescuento(cstmt.getInt(6)==1 ? true:false);
			}
			else
				vendedor.setAplicaDescuento(false);
	
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}

		} catch (Exception e) {
			logger.error("Ocurrió un error al consultar el rango de descuento del vendedor",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al consultar el rango de descuento del vendedor",e);
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

		logger.debug("getRangoDescuento():end");

		return vendedor;
		}

	/**
	 * Obtiene Listado de motivos de descuentos manuales
	 * @return WsListMotivoDescuentoOutDTO
	 * @throws GeneralException
	 */
	public WsListadoCausalesVentasOutDTO getListadoMotivosDescuentosManuales(String CodigoUso) throws GeneralException{
		//RSIS29
		logger.debug("getListadoMotivosDescuentosManuales():start");
		WsListadoCausalesVentasOutDTO resultado = null;
		WsCausalesVentasOutDTO[] motivosDescuento = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		logger.debug("Coneccion obtenida OK");
		try {
			resultado = new WsListadoCausalesVentasOutDTO();
			                                                               
			String call = getSQLDatosVendedor("GE_CONS_CATALOGO_PORTAB_PG","ge_recupera_cuasales_dsctos_pr",5);
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1, CodigoUso);
			cstmt.registerOutParameter(2,OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cstmt.execute();
			logger.debug("Execute Despues");
			
			codError = cstmt.getInt(3);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(4);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(5);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error("Ocurrió un error al obtener motivos de descuentos manuales");
				resultado.setMensajseError(msgError);
				resultado.setCodError(""+codError);
				throw new GeneralException(
						"Ocurrió un error al obtener motivos de descuentos manuales", String
								.valueOf(codError), numEvento, msgError);
			}else{
				logger.debug("Recuperando motivos de descuentos manuales");
				ArrayList lista = new ArrayList();
				String codDescuento="";
				String desDescuento="";

				ResultSet rs = (ResultSet) cstmt.getObject(2);
				while (rs.next()) {
					WsCausalesVentasOutDTO motivoDescuentoDTO = new WsCausalesVentasOutDTO();
					codDescuento = rs.getString(1);
					logger.debug("codDescuent ["+codDescuento+"]");
					desDescuento = rs.getString(2);
					logger.debug("desDescuento["+desDescuento+"]");
					
					motivoDescuentoDTO.setCodCausalVentas(codDescuento);
					motivoDescuentoDTO.setDesCausalVentas(desDescuento);
					
					lista.add(motivoDescuentoDTO);
				}
				rs.close();
				motivosDescuento =(WsCausalesVentasOutDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), WsCausalesVentasOutDTO.class);
				resultado.setWsMotivoDescuentoArrOutDTO(motivosDescuento);
				
			}
	
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}

		} catch (GeneralException e) {
			throw e;		
		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener motivos de descuentos manuales",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error [" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al obtener motivos de descuentos manuales",e);
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

		logger.debug("getListadoMotivosDescuentosManuales():end");

		return resultado;
	}
	
	/**
	 * Obtiene listado de tipos de comisionistas
	 * @param N/A
	 * @return VendedorDTO[]
	 * @throws GeneralException
	 */
	public VendedorDTO[] getListTiposComisionistas() 
	throws GeneralException{
		logger.debug("Inicio:getListTiposComisionistas()");
		VendedorDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			//INI-01 (AL) String call = getSQLDatosVendedor("VE_alta_cliente_PG","VE_getListTipComisionistas_PR",4);
			String call = getSQLDatosVendedor("VE_alta_cliente_Quiosco_PG","VE_getListTipComisionistas_PR",4);

			logger.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			cstmt.registerOutParameter(1,OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getListTiposComisionistas:execute");
			cstmt.execute();
			logger.debug("Fin:getListTiposComisionistas:execute");

			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);
			
			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error("Ocurrió un error al recuperar tipos de comisionistas");
				throw new GeneralException(
						"Ocurrió un error al recuperar tipos de comisionistas", String
								.valueOf(codError), numEvento, msgError);
			}else{
				logger.debug("Recuperando tipos");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(1);
				while (rs.next()) {
					VendedorDTO vendedorDTO = new VendedorDTO();
					vendedorDTO.setCodTipComisionista(rs.getString(1));
					vendedorDTO.setDesTipComisionista(rs.getString(2));
					vendedorDTO.setIndicadorTipoVenta(rs.getInt(3));
					lista.add(vendedorDTO);
				}
				rs.close();
				resultado =(VendedorDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), VendedorDTO.class);
				
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			throw e;		
		} catch (Exception e) {
			logger.error("Ocurrió un error al recuperar tipos de comisionistas",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
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
		logger.debug("Fin:getListTiposComisionistas()");
		return resultado;
	}//fin getListTiposComisionistas	

	/**
	 * Verifica si el home del vendedor corresponde al home del celular
	 * @param vendedor
	 * @return VendedorDTO
	 * @throws GeneralException
	 */	
	public VendedorDTO validaHomeVendCel(VendedorDTO vendedor) 
	throws GeneralException{
		logger.debug("validaHomeVendCel:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		logger.debug("Coneccion obtenida OK");
		try {
			//INI-01 (AL) String call = getSQLDatosVendedor("VE_servicios_venta_PG","VE_validaHomeVendCel_PR",6);
			String call = getSQLDatosVendedor("VE_servicios_venta_quiosco_PG","VE_validaHomeVendCel_PR",6);
			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			logger.debug("codigo vendedor:" + vendedor.getCodigoVendedor());
			logger.debug("numero celulra:" + vendedor.getNumeroCelular());
			cstmt.setString(1,vendedor.getCodigoVendedor());
			cstmt.setString(2,vendedor.getNumeroCelular());

			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			
			logger.debug("validaHomeVendCel:Execute Antes");
			cstmt.execute();
			logger.debug("validaHomeVendCel:Execute Despues");

			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);
			
			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error("Ocurrió un error al recuperar tipos de comisionistas");
				throw new GeneralException(
						"Ocurrió un error al recuperar tipos de comisionistas", String
								.valueOf(codError), numEvento, msgError);
			}else{
				int res = cstmt.getInt(3);
				boolean resultado = res==0?false:true;
				logger.debug("res:" + vendedor.getNumeroCelular());
				vendedor.setIndicadorHomeVendCelular(resultado);
			}
		} catch (GeneralException e) {
			throw e;		
		} catch (Exception e) {
			logger.error("Ocurrió un error al verificar home del vendedor y celular",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException("Ocurrió un error al verificar home del vendedor y celular",e);
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
		logger.debug("validaHomeVendCel():end");
		return vendedor;
	}//fin validaHomeVendCel
	
	/**
	 * Obtiene listado de vendedores
	 * @param N/A
	 * @return VendedorDTO[]
	 * @throws GeneralException
	 */
	public VendedorDTO[] getListadoVendedores(VendedorDTO vendedorDTO) 
	throws GeneralException{
		logger.debug("Inicio:getListadoVendedores()");
		VendedorDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			//INI-01 (AL) String call = getSQLDatosVendedor("Ve_Servicios_Venta_Pg","VE_getListVendedores_PR",6);
			String call = getSQLDatosVendedor("Ve_Servicios_Venta_Quiosco_Pg","VE_getListVendedores_PR",6);

			logger.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,vendedorDTO.getCodigoOficina());
			cstmt.setString(2,vendedorDTO.getCodTipComisionista());
			cstmt.registerOutParameter(3,OracleTypes.CURSOR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getListadoVendedores:execute");
			cstmt.execute();
			logger.debug("Fin:getListadoVendedores:execute");

			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);
			
			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error("Ocurrió un error al recuperar listado de vendedores");
				throw new GeneralException(
						"Ocurrió un error al recuperar listado de vendedores", String
								.valueOf(codError), numEvento, msgError);
			}else{
				logger.debug("Recuperando vendedores");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(3);
				while (rs.next()) {
					VendedorDTO vendedorDTO2 = new VendedorDTO();
					vendedorDTO2.setCodigoVendedor(rs.getString(1));
					vendedorDTO2.setNombreVendedor(rs.getString(2));
					lista.add(vendedorDTO2);
				}
				rs.close();
				resultado =(VendedorDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), VendedorDTO.class);
				
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			throw e;		
		} catch (Exception e) {
			logger.error("Ocurrió un error al recuperar listado de vendedores",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
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
		logger.debug("Fin:getListadoVendedores()");
		return resultado;
	}//fin getListadoVendedores
	
	/**
	 * Obtiene listado de vendedores
	 * @param N/A
	 * @return VendedorDTO[]
	 * @throws GeneralException
	 */
	public VendedorDTO[] getListadoVendedoresDealer(VendedorDTO vendedorDTO) 
	throws GeneralException{
		logger.debug("Inicio:getListadoVendedores()");
		VendedorDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			//INI-01 (AL) String call = getSQLDatosVendedor("Ve_Servicios_Venta_Pg","VE_getListVendDealer_PR",5);
			String call = getSQLDatosVendedor("Ve_Servicios_Venta_Quiosco_Pg","VE_getListVendDealer_PR",5);

			logger.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,vendedorDTO.getCodigoVendedor());
			cstmt.registerOutParameter(2,OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getListadoVendedores:execute");
			cstmt.execute();
			logger.debug("Fin:getListadoVendedores:execute");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error("Ocurrió un error al recuperar listado de vendedores dealers");
				throw new GeneralException(
						"Ocurrió un error al recuperar listado de vendedores dealers", String
								.valueOf(codError), numEvento, msgError);
			}else{
				logger.debug("Recuperando vendedores");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(2);
				while (rs.next()) {
					VendedorDTO vendedorDTO2 = new VendedorDTO();
					vendedorDTO2.setCodigoVendedorDealer(Long.parseLong(rs.getString(1)));
					vendedorDTO2.setNombreDealer(rs.getString(2));
					lista.add(vendedorDTO2);
				}
				rs.close();
				resultado =(VendedorDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), VendedorDTO.class);
				
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			throw e;		
		} catch (Exception e) {
			logger.error("Ocurrió un error al recuperar listado de vendedores",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
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
		logger.debug("Fin:getListadoVendedores()");
		return resultado;
	}//fin getListadoVendedores	

	/**
	 * Obtiene listado de vendedores
	 * @param N/A
	 * @return VendedorDTO[]
	 * @throws GeneralException
	 */
	public VendedorDTO[] getListadoVendedoresXOficina(VendedorDTO vendedorDTO) 
		throws GeneralException
	{
		logger.debug("Inicio:getListadoVendedoresXOficina()");
		VendedorDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			//INI-01 (AL) String call = getSQLDatosVendedor("Ve_Servicios_Venta_Pg","VE_getListVendedores_PR",5);
			String call = getSQLDatosVendedor("Ve_Servicios_Venta_Quiosco_Pg","VE_getListVendedores_PR",5);

			logger.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,vendedorDTO.getCodigoOficina());			
			cstmt.registerOutParameter(2,OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getListadoVendedoresXOficina:execute");
			cstmt.execute();
			logger.debug("Fin:getListadoVendedoresXOficina:execute");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error("Ocurrió un error al recuperar listado de vendedores");
				throw new GeneralException(
						"Ocurrió un error al recuperar listado de vendedores", String
								.valueOf(codError), numEvento, msgError);
			}else{
				logger.debug("Recuperando vendedores");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(2);
				while (rs.next()) {
					VendedorDTO vendedorDTO2 = new VendedorDTO();
					vendedorDTO2.setCodigoVendedor(rs.getString(1));
					vendedorDTO2.setNombreVendedor(rs.getString(2));
					lista.add(vendedorDTO2);
				}
				rs.close();
				resultado =(VendedorDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), VendedorDTO.class);
				
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			throw e;		
		} catch (Exception e) {
			logger.error("Ocurrió un error al recuperar listado de vendedores",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
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
		logger.debug("Fin:getListadoVendedoresXOficina()");
		return resultado;
	}//fin getListadoVendedores
	
	
	public VendedorDTO[] getListadoVendedoresXOficinaEIndicador(VendedorDTO vendedorDTO) 
	throws GeneralException
	{
		//RSIS13
		logger.debug("Inicio:getListadoVendedoresXOficinaEIndicador()");
		VendedorDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			String call = getSQLDatosVendedor("GE_CONS_CATALOGO_PORTAB_PG","GE_REC_VENDEDORES_X_OFICINA_PR",6);
	
			logger.debug("sql[" + call + "]");
			logger.debug("Código Oficina [" + vendedorDTO.getCodigoOficina() + "]");
			logger.debug("Indicador Interno[" + vendedorDTO.isVendedorInterno() + "]");
			logger.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,vendedorDTO.getCodigoOficina());			
			cstmt.setString(2,vendedorDTO.isVendedorInterno()?"1":"0");
			cstmt.registerOutParameter(3,OracleTypes.CURSOR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getListadoVendedoresXOficina:execute");
			cstmt.execute();
			logger.debug("Fin:getListadoVendedoresXOficina:execute");
	
			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);
			
			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error("Ocurrió un error al recuperar listado de vendedores getListadoVendedoresXOficinaEIndicador");
				throw new GeneralException(
						"Ocurrió un error al recuperar listado de vendedores getListadoVendedoresXOficinaEIndicador", String
								.valueOf(codError), numEvento, msgError);
			}else{
				logger.debug("Recuperando vendedores");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(3);
				while (rs.next()) {
					VendedorDTO vendedorDTO2 = new VendedorDTO();
					vendedorDTO2.setCodigoVendedor(rs.getString(1));
					vendedorDTO2.setNombreVendedor(rs.getString(2));
					vendedorDTO2.setCodigoVendedorRaiz(rs.getLong(3));
					lista.add(vendedorDTO2);
				}
				rs.close();
				resultado =(VendedorDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), VendedorDTO.class);
				
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		}  catch (GeneralException e) {
			throw e;		
		} catch (Exception e) {
			logger.error("Ocurrió un error al recuperar listado de vendedores getListadoVendedoresXOficinaEIndicador",e);
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
		logger.debug("Fin:getListadoVendedoresXOficinaEIndicador()");
		return resultado;
	}//fin getListadoVendedoresXOficinaEIndicador

	public VendedorDTO[] getListadoVendedoresXTipo(VendedorDTO vendedorDTO) 
	throws GeneralException
	{
		//RSIS31
		logger.debug("Inicio:getListadoVendedoresXTipo()");
		VendedorDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			String call = getSQLDatosVendedor("GE_CONS_CATALOGO_PORTAB_PG","GE_REC_VENDEDORES_X_TIPO_PR",5);
	
			logger.debug("sql[" + call + "]");
			//logger.debug("Código Oficina [" + vendedorDTO.getCodigoOficina() + "]");
			logger.debug("Indicador Interno[" + vendedorDTO.isVendedorInterno() + "]");
			logger.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			//cstmt.setString(1,vendedorDTO.getCodigoOficina());			
			cstmt.setString(1,vendedorDTO.isVendedorInterno()?"1":"0");
			cstmt.registerOutParameter(2,OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getListadoVendedoresXOficina:execute");
			cstmt.execute();
			logger.debug("Fin:getListadoVendedoresXOficina:execute");
	
			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error("Ocurrió un error al recuperar listado de vendedores getListadoVendedoresXTipo");
				throw new GeneralException(
						"Ocurrió un error al recuperar listado de vendedores getListadoVendedoresXTipo", String
								.valueOf(codError), numEvento, msgError);
			}else{
				logger.debug("Recuperando vendedores");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(2);
				while (rs.next()) {
					VendedorDTO vendedorDTO2 = new VendedorDTO();
					vendedorDTO2.setCodigoVendedor(rs.getString(1));
					vendedorDTO2.setNombreVendedor(rs.getString(2));
					vendedorDTO2.setCodigoVendedorRaiz(rs.getLong(3));
					lista.add(vendedorDTO2);
				}
				rs.close();
				resultado =(VendedorDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), VendedorDTO.class);
				
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		}  catch (GeneralException e) {
			throw e;		
		} catch (Exception e) {
			logger.error("Ocurrió un error al recuperar listado de vendedores por tipo",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
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
		logger.debug("Fin:getListadoVendedoresXTipo()");
		return resultado;
	}//fin getListadoVendedoresXTipo
	
	/**
	 * Obtiene listado de vendedores
	 * @param N/A
	 * @return WsArticuloVendedorOutDTO[]
	 * @throws GeneralException
	 */
	public WsArticuloVendedorOutDTO[] getArticulosPorVendedor(WsVendedorStockInDTO vendedorStockDTO) 
		throws GeneralException
	{
		logger.debug("Inicio:getArticulosPorVendedor()");
		WsArticuloVendedorOutDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			//AL_PORTABILIDAD_PG.AL_CONSULTA_STOCK_PR ( EN_COD_VENDEDOR, EN_TIP_STOCK, EN_COD_BODEGA, EV_TIP_TERMINAL, EV_IND_EQUIACC, EN_COD_USO, EN_COD_ESTADO, EV_IND_MODULO, SC_STOCK, SN_COD_RETORNO, SV_MENS_RETORNO, SN_NUM_EVENTO
			
			
			
			//String call = getSQLDatosVendedor("GE_CONS_CATALOGO_PORTAB_PG","GE_REC_ARTICULOS_X_VENDEDOR_PR",8);
			String call = getSQLDatosVendedor("AL_PORTABILIDAD_PG","AL_CONSULTA_STOCK_PR",10);

			logger.debug("sql[" + call + "]");
			logger.debug("Código Vendedor : "+vendedorStockDTO.getCodVendedor());
			logger.debug("Indicador Interno : "+vendedorStockDTO.getIndInterno());
			logger.debug("Código Uso : "+vendedorStockDTO.getCodUso());
			logger.debug("Tipo Terminal : "+vendedorStockDTO.getTipTerminal());
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1,vendedorStockDTO.getCodVendedor());
			
			if (vendedorStockDTO.getTipTerminal().equals("G")){
				cstmt.setLong(2,vendedorStockDTO.getIndInterno().equals("1")?2:4);
			}else{
				cstmt.setLong(2,new Long(2).longValue());
			}
			//cstmt.setString(3,null);//cod_bodega
			cstmt.setString(3,vendedorStockDTO.getTipTerminal());
			cstmt.setString(4,"E");
			cstmt.setLong(5,vendedorStockDTO.getCodUso());
			cstmt.setLong(6,1);
			//cstmt.setString(7,"POR");
			
			cstmt.registerOutParameter(7,OracleTypes.CURSOR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getArticulosPorVendedor:execute");
			cstmt.execute();
			logger.debug("Fin:getArticulosPorVendedor:execute");

			codError = cstmt.getInt(8);
			msgError = cstmt.getString(9);
			numEvento = cstmt.getInt(10);
			
			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error("Ocurrió un error al recuperar listado de artículos por vendedor");
				throw new GeneralException(
						"Ocurrió un error al recuperar listado de artículos por vendedor", String
								.valueOf(codError), numEvento, msgError);
			}else{
				logger.debug("Recuperando de artículos por vendedor");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(7);
				while (rs.next()) {
					WsArticuloVendedorOutDTO articuloDTO = new WsArticuloVendedorOutDTO();
					//OLD B.des_articulo, b.cod_modelo, sum(a.can_stock) can_stock, a.cod_bodega
					//a.COD_ARTICULO,b.DES_ARTICULO,b.COD_MODELO,a.CAN_STOCK,a.COD_BODEGA,CAN_RESERVADA  
					articuloDTO.setCodArticulo(rs.getLong(1));
					articuloDTO.setDesArticulo(rs.getString(2));
					articuloDTO.setCodModelo(rs.getString(3));
					articuloDTO.setCantStock(rs.getLong(6));
					articuloDTO.setCodBodega(rs.getInt(4));
					articuloDTO.setCantReservada(rs.getInt(7));
					
					lista.add(articuloDTO);
				}
				rs.close();
				resultado =(WsArticuloVendedorOutDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), WsArticuloVendedorOutDTO.class);
				
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		}catch (GeneralException e) {
			logger.debug("e.getCodigo()[" + e.getCodigo() + "]");
			logger.debug("e.getDescripcionEvento()[" + e.getDescripcionEvento() + "]");
			logger.debug("e.getCodigoEvento()[" + e.getCodigoEvento() + "]");
			throw e;
		} catch (Exception e) {
			logger.error("Ocurrió un error al recuperar listado de vendedores",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
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
		logger.debug("Fin:getArticulosPorVendedor()");
		return resultado;
	}//fin getListadoVendedores
	
	/**
	 * Obtiene Articulo Por Imei
	 * @param N/A
	 * @return WsArticuloImeiOutDTO[]
	 * @throws GeneralException
	 */
	public WsArticuloImeiOutDTO getArticuloPorImei(WsArticuloImeiInDTO inWSLstNumSerieDTO) 
		throws GeneralException
	{
		//RSIS23
		logger.debug("Inicio:getArticuloPorImei()");
		WsArticuloImeiOutDTO resultado = new WsArticuloImeiOutDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			String call = getSQLDatosVendedor("GE_CONS_CATALOGO_PORTAB_PG","GE_REC_ARTICULO_X_IMEI_PR",7);

			logger.debug("sql[" + call + "]");
			logger.debug("Numero Serie : "+inWSLstNumSerieDTO.getNumSerie());

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,inWSLstNumSerieDTO.getNumSerie());	
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getArticuloPorImei:execute");
			cstmt.execute();
			logger.debug("Fin:getArticuloPorImei:execute");

			codError = cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento = cstmt.getInt(7);
			
			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error("Ocurrió un error al recuperar articulo por Imei");
				logger.debug("codError ["+codError+"]");
				logger.debug("msgError ["+msgError+"]");
				logger.debug("numEvento ["+numEvento+"]");
				resultado.setMensajseError(msgError);
				resultado.setCodError(""+codError);
				throw new GeneralException(
						"Ocurrió un error al recuperar articulo por Imei", String
								.valueOf(codError), numEvento, msgError);
			}else{
				logger.debug("Recuperando de articulo por Imei");

				resultado = new WsArticuloImeiOutDTO();
				resultado.setCodArticulo(cstmt.getInt(2));
				resultado.setDesArticulo(cstmt.getString(3));
				resultado.setCodModelo(cstmt.getString(4));
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			logger.error("Ocurrió un error al recuperar articulo por Imei",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
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
		logger.debug("Fin:getArticuloPorImei()");
		return resultado;
	}//fin getArticuloPorImei
	
	/**
	 * Obtiene listado de comisionistas segun oficina
	 * @param oficina
	 * @return TipoComisionistaDTO[]
	 * @throws GeneralException
	 */
	public WsListTipoComisionistaOutDTO getListadoComisionistasXOficina(WsOficinaInDTO wsOficinaInDTO) 
		throws GeneralException
	{
		//RSIS12
		logger.debug("Inicio:getListadoComisionistasXOficina()");
		WsListTipoComisionistaOutDTO resultado = null;
		WsTipoComisionistaOutDTO[] tiposComisionistas = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			resultado = new WsListTipoComisionistaOutDTO();
			String call = getSQLDatosVendedor("GE_CONS_CATALOGO_PORTAB_PG","GE_REC_TIPCOMIS_X_OFICINA_PR",5);

			logger.debug("sql[" + call + "]");
			logger.debug("Código Oficina : "+wsOficinaInDTO.getCodigoOficina());

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,wsOficinaInDTO.getCodigoOficina());	
			cstmt.registerOutParameter(2,OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getListadoComisionistasXOficina:execute");
			cstmt.execute();
			logger.debug("Fin:getListadoComisionistasXOficina:execute");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error("Ocurrió un error al recuperar listado de comisionistas por oficina");
				resultado.setMensajseError(msgError);
				resultado.setCodError(""+codError);
				throw new GeneralException(
						"Ocurrió un error al recuperar listado de comisionistas por oficina", String
								.valueOf(codError), numEvento, msgError);
			}else{
				logger.debug("Recuperando comisionistas por oficina");
				ArrayList lista = new ArrayList();
				String codigoTipoComisionista="";
				String descripcionTipoComisionista="";
				String indExterno="";
				
				ResultSet rs = (ResultSet) cstmt.getObject(2);
				while (rs.next()) {
					WsTipoComisionistaOutDTO tipoComisDTO = new WsTipoComisionistaOutDTO();
					codigoTipoComisionista = rs.getString(1);
					logger.debug("codigoTipoComisionista ="+codigoTipoComisionista);
					descripcionTipoComisionista = rs.getString(2);
					logger.debug("descripcionTipoComisionista ="+descripcionTipoComisionista);
					indExterno = rs.getString(3);
					logger.debug("indExterno ="+indExterno);
					
					tipoComisDTO.setCodigoTipoComisionista(codigoTipoComisionista);
					tipoComisDTO.setDescripcionTipoComisionista(descripcionTipoComisionista);
					tipoComisDTO.setIndExterno(indExterno);
					
					lista.add(tipoComisDTO);
				}
				rs.close();
				tiposComisionistas =(WsTipoComisionistaOutDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), WsTipoComisionistaOutDTO.class);
				resultado.setWsTipoComisionistaArrOutDTO(tiposComisionistas);
				
			}

		} catch (GeneralException e) {
			logger.error("Ocurrió un error al recuperar listado de vendedores",e);
			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");			
			throw e;

		} catch (Exception e) {
			logger.error("Ocurrió un error al recuperar listado de vendedores",e);
			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");
			
			throw new GeneralException(e);

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
		logger.debug("Fin:getListadoComisionistasXOficina()");
		return resultado;
	}//fin getListadoComisionistasXOficina
	
	  /**
	 *  Reserva Desreserva
	 * @param ArticuloResDesInDTO
	 * @return WsArticuloResDesOutDTO
	 * @throws GeneralException
	 */
	public WsArticuloResDesOutDTO reservaDesreserva(ArticuloResDesInDTO articuloDTO) throws GeneralException{
		WsArticuloResDesOutDTO resultado=new WsArticuloResDesOutDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:reservaDesreserva");
			logger.debug(" Parametros de Entrada ");
			
			logger.debug(" Cód Artículo  ["+articuloDTO.getCodArticulo()+"] ");
			logger.debug(" Tipo Stock    ["+articuloDTO.getTipStock()   +"] ");
			logger.debug(" Código Uso    ["+articuloDTO.getCodUso()     +"] ");
			logger.debug(" Código Estado ["+articuloDTO.getCodEstado()  +"] ");
			logger.debug(" Código Bodega ["+articuloDTO.getCodBodega()  +"] ");
			logger.debug(" Cantidad      ["+articuloDTO.getCantidad()   +"] ");
			logger.debug(" Ind Reserva   ["+articuloDTO.getIndReserva() +"] ");
			logger.debug(" Modulo        ["+articuloDTO.getModulo()     +"] ");

			String call = getSQLDatosVendedor("AL_PORTABILIDAD_PG","AL_RESDES_STOCK_PR",12);
			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			
			cstmt.setLong(1,articuloDTO.getCodArticulo());
			cstmt.setInt(2,articuloDTO.getTipStock());
			cstmt.setInt(3,articuloDTO.getCodUso());
			cstmt.setInt(4,articuloDTO.getCodEstado());
			cstmt.setLong(5,articuloDTO.getCodBodega());
			cstmt.setLong(6,articuloDTO.getCantidad());
			cstmt.setInt(7,articuloDTO.getIndReserva());
			cstmt.setString(8,articuloDTO.getModulo());
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);
			
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(12, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:reservaDesreserva:execute");
			cstmt.execute();
			logger.debug("Fin:reservaDesreserva:execute");

			codError  = cstmt.getInt(10);
			msgError  = cstmt.getString(11);
			numEvento = cstmt.getInt(12);
			
			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");
			
			if (codError != 0){
				logger.error("Ocurrió un error en reservaDesreserva");
				resultado.setMensajseError(msgError);
				resultado.setCodError(""+codError);
				resultado.setCantidadStock(cstmt.getString(9));
				throw new GeneralException(
				"Ocurrió un error al obtener reservaDesreserva", String
				.valueOf(codError), numEvento, msgError);
			}
			else{
				resultado.setCantidadStock(cstmt.getString(9));
				logger.debug("resultado.setCantidadStock [" + cstmt.getString(9) + "]");
			}
		}catch (GeneralException e) {
		   throw e;
		
		} catch (Exception e) {
			logger.error("Ocurrió un error en reservaDesreserva",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
		} finally {
				logger.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				logger.debug("SQLException", e);
		  }
		}
		logger.debug("Fin:reservaDesreserva");
		return resultado;
	}//fin reservaDesreserva
	
	
	
	private String getSQLgetCodVendedorRaizPorCodVendedor(){
		StringBuffer call = new StringBuffer();
				call.append("BEGIN " +
							" 	GE_CONS_CATALOGO_PORTAB_PG.ge_recupera_vend_raiz_pr(?,?,?,?,?); "+
							"END;");
	
		return call.toString();
	}
	
	public long getCodVendedorRaizPorCodVendedor(WsVendedorStockInDTO wsVendedorStockInDTO) throws GeneralException{
		if (logger.isDebugEnabled()) 
			logger.debug("getCodVendedorRaizPorCodVendedor:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		long codVendedorRaiz=0;
		if (logger.isDebugEnabled()) 
			logger.debug("Coneccion obtenida OK");
		try {
			String call = getSQLgetCodVendedorRaizPorCodVendedor();
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1,wsVendedorStockInDTO.getCodVendedor());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			if (logger.isDebugEnabled()) 
				logger.debug("Execute Antes");
			cstmt.execute();
			if (logger.isDebugEnabled()) 
				logger.debug("Execute Despues");
			
			codError = cstmt.getInt(3);			
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			logger.debug("codError[" + codError + "]");
			logger.debug("msgError[" + msgError + "]");
			logger.debug("numEvento[" + numEvento + "]");
			
	
			if (codError != 0) {
				logger.error("Ocurrió un error al getCodVendedorRaizPorCodVendedor");
				throw new GeneralException(
						"Ocurrió un error al consultar getCodVendedorRaizPorCodVendedor", String
								.valueOf(codError), numEvento, msgError);
				
			}else{
				if (logger.isDebugEnabled()) 
					logger.debug("Llenado Vendedor");
				codVendedorRaiz=cstmt.getInt(2);
				if (logger.isDebugEnabled())
					logger.debug("Fin Llenado Vendedor");
			}
			
			
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
			// Recuperacion de valores de salida

		}catch (GeneralException e) {			
			logger.error("Ocurrió un error al consultar getCodVendedorRaizPorCodVendedor",e);
			if (logger.isDebugEnabled()) {
				logger.debug("e.getCodigo()[" + e.getCodigo() + "]");
				logger.debug("e.getDescripcionEvento()[" + e.getDescripcionEvento() + "]");
				logger.debug("e.getCodigoEvento()[" + e.getCodigoEvento() + "]");
			}
			throw e;
		} catch (Exception e) {
			logger.error("Ocurrió un error al consultar getCodVendedorRaizPorCodVendedor",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al consultar getCodVendedorRaizPorCodVendedor",e);
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
		if (logger.isDebugEnabled()) 
			logger.debug("getCodVendedorRaizPorCodVendedor():end");

		return codVendedorRaiz;
	}
	
	public BodegaDTO[] getBodegasPorVendedor(String codigoVendedor) throws GeneralException{
		
		BodegaDTO[] bodegas = null;
		logger.debug("getBodegasPorVendedor:start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		
		logger.debug("Coneccion obtenida OK");
		
		try {
			String call = getSQLDatosVendedor("VE_PORTABILIDAD_PG","ve_rec_bodegas_vendedor_pr",5);
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			
			
			cstmt.setInt(1,Integer.parseInt(codigoVendedor));	
			cstmt.registerOutParameter(2,OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			
			logger.debug("Execute Antes");
			cstmt.execute();			
			logger.debug("Execute Despues");
			
			codError = cstmt.getInt(3);			
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			logger.debug("codError[" + codError + "]");
			logger.debug("msgError[" + msgError + "]");
			logger.debug("numEvento[" + numEvento + "]");
			
	
			if (codError != 0) {
				logger.error("Ocurrió un error al recuperar bodegas del vendedor");
				throw new GeneralException(
						"Ocurrió un error al recuperar bodegas del vendedor", String
								.valueOf(codError), numEvento, msgError);
				
			}else{
			
				ArrayList lista = new ArrayList();				
				ResultSet rs = (ResultSet) cstmt.getObject(2);
				BodegaDTO bodega = null;
				while (rs.next()) {
					
					bodega = new BodegaDTO();
					bodega.setCodigoBodega(rs.getString(1));
					bodega.setDescripcionBodega(rs.getString(2));					
					
					lista.add(bodega);
				}				
				bodegas =(BodegaDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), BodegaDTO.class);																															
			}
			
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
			// Recuperacion de valores de salida

		}catch (GeneralException e) {
			throw e;
		
		} catch (Exception e) {
			logger.error("Ocurrió un error al recuperar bodegas del vendedor",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al recuperar bodegas del vendedor",e);
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
		if (logger.isDebugEnabled()) 
			logger.debug("getBodegasPorVendedor():end");

		return bodegas;
	}	
	
}//fin VendedorDAO


