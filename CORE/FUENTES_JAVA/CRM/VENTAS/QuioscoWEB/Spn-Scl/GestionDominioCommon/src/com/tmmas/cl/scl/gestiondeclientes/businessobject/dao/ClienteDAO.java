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
import java.util.Date;

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.Formatting;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.AbonadoActivoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ReglaCompatibilidadSSDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CategoriaCambioClienteDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CategoriaCambioDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ClasificacionCuentaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ClasificacionDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ClienteComDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ClienteDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ClienteImpDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CuentaComDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.FaMensProcesoDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.FaMensajesDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.GeModVentaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.PagosUltimosMesesDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ParametrosAnulacionVentaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ParametrosValidacionDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ResultadoValidacionVentaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.SucursalBancoDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.TipoPagoDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ValorClasificacionDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WSValidarTarjetaOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsBancoInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsBancoOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsClienteIdentInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsClienteIdentOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsContratoOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsCuotaOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsInfoComercialClienteDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsLinkDocumentoInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsLinkDocumentoOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListBancoOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListClienteIdentOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListCuotaOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListModalidadPagoOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListPlanTarifarioOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListTarjetaOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListTipoPagoOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsModalidadPagoOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsPlanTarifarioOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsTarjetaOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsValTarjetaInDTO;
import com.tmmas.cl.scl.gestiondeclietnes.businessobject.helper.Global;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.DireccionNegocioDTO;


public class ClienteDAO extends ConnectionDAO{
	private final Logger logger = Logger.getLogger(ClienteDAO.class);

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
	
	private String getSQLDatosCliente(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
        for (int n = 1; n <= paramCount; n++) {
            sb.append("?");
            if (n < paramCount) sb.append(",");
        }
        return sb.append(")}").toString();
	
	}
	
	public ClienteDTO getCliente(ClienteDTO cliente) throws GeneralException{
		logger.debug("getCliente:inicio");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		Date fecNaci = null; 
		
		logger.debug("Coneccion obtenida OK");
		CallableStatement cstmt = null;
		try {
			//INI-01 (AL) String call = getSQLDatosCliente("VE_servicios_venta_PG","VE_consulta_cliente_PR",24);
			String call = getSQLDatosCliente("VE_servicios_venta_quiosco_PG","VE_consulta_cliente_PR",24);
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1,Long.parseLong(cliente.getCodigoCliente()));
			cstmt.registerOutParameter(2,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8,java.sql.Types.DATE);
			cstmt.registerOutParameter(9,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(12,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(13,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(14,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(15,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(16,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(17,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(18,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(19,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(20,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(21,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(22,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(23,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(24,java.sql.Types.NUMERIC);
			logger.debug("Execute Antes");
			cstmt.execute();
			logger.debug("Execute Despues");
			
			codError = cstmt.getInt(22);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(23);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(24);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				codError = 12243;
				msgError = "No se pudo rescatar la Información en ClienteDTO getCliente";				
				logger.error("Ocurrió un error al consultar el Cliente");
				throw new GeneralException(
						"Ocurrió un error al consultar el cliente", String
								.valueOf(codError), numEvento, msgError);
			}
			else{
				cliente.setNumeroIdentificacion(cstmt.getString(2));
				cliente.setCodigoTipoIdentificacion(cstmt.getString(3));
				cliente.setNombreCliente(cstmt.getString(4));
				cliente.setCodigoCuenta(String.valueOf(cstmt.getLong(5)));
				cliente.setNombreApellido1(cstmt.getString(6));
				cliente.setNombreApellido2(cstmt.getString(7));
				fecNaci = cstmt.getDate(8);
				cliente.setFechaNacimiento(String.valueOf(Formatting.dateTime(fecNaci,"dd/MM/yyyy")));
				logger.debug("FECHA NACIMIENTO [" + cstmt.getString(8) + "]");
				cliente.setIndicadorEstadoCivil(cstmt.getString(9));
				logger.debug("INDICADOR ESTADO CIVIL [" + cstmt.getString(9) + "]");
				cliente.setIndicadorSexo(cstmt.getString(10));
				logger.debug("INDICADOR SEXO [" + cstmt.getString(10) +"]");
				cliente.setCodigoActividad(String.valueOf(cstmt.getLong(11)));
				
				ArrayList lista = new ArrayList();
				
				DireccionNegocioDTO[] direcciones = null;				
				DireccionNegocioDTO direccion = new DireccionNegocioDTO();;
								
				direccion.setRegion(cstmt.getString(12));
				direccion.setCiudad(cstmt.getString(13));
				direccion.setProvincia(cstmt.getString(14));
				direccion.setCodigo(cstmt.getString(20));
				
				lista.add(direccion);
								
				direcciones =(DireccionNegocioDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), DireccionNegocioDTO.class);
				
				
				cliente.setDirecciones(direcciones);
				cliente.setCodigoCelda(cstmt.getString(15));
				cliente.setCodigoCalidadCliente(cstmt.getString(16));
				cliente.setIndicativoFacturable(cstmt.getInt(17));
				cliente.setCodigoCiclo(cstmt.getInt(18));
				if (cstmt.getLong(19) > 0){
					cliente.setCodigoEmpresa(cstmt.getLong(19));
					cliente.setCodigoPlanTarifario(cstmt.getString(21));
					cliente.setTipoCliente("E");
				}else{
					cliente.setTipoCliente("I");
				}
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
			// Recuperacion de valores de salida
		}catch(GeneralException e ){
			throw (e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al consultar el cliente",e);
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

		logger.debug("getCliente():end");

		return cliente;
	}	
	
	
	public CuentaComDTO getCliente(CuentaComDTO CuentaCom) throws GeneralException{
		logger.debug("getCliente:inicio");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		
		ClienteComDTO clientecom = new ClienteComDTO();
		
		Connection conn = null;
		conn = getConection();
		logger.debug("Coneccion obtenida OK");
		CallableStatement cstmt = null;
		try {
			//INI-01 (AL) String call = getSQLDatosCliente("ve_alta_cliente_pg","ve_getcliente_pr",84);
			String call = getSQLDatosCliente("VE_alta_cliente_Quiosco_PG","ve_getcliente_pr",84);
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1,Long.parseLong(CuentaCom.getClienteComDTO().getCodigoCliente()));
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
			cstmt.registerOutParameter(26,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(27,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(28,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(29,java.sql.Types.VARCHAR);			
			cstmt.registerOutParameter(30,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(31,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(32,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(33,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(34,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(35,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(36,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(37,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(38,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(39,java.sql.Types.VARCHAR);			
			cstmt.registerOutParameter(40,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(41,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(42,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(43,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(44,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(45,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(46,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(47,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(48,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(49,java.sql.Types.VARCHAR);			
			cstmt.registerOutParameter(50,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(51,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(52,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(53,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(54,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(55,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(56,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(57,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(58,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(59,java.sql.Types.VARCHAR);			
			cstmt.registerOutParameter(60,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(61,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(62,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(63,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(64,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(65,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(66,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(67,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(68,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(69,java.sql.Types.VARCHAR);			
			cstmt.registerOutParameter(70,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(71,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(72,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(73,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(74,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(75,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(76,java.sql.Types.VARCHAR);
			
			cstmt.registerOutParameter(77,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(78,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(79,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(80,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(81,java.sql.Types.VARCHAR);
			
			cstmt.registerOutParameter(82,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(83,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(84,java.sql.Types.NUMERIC);			
						
			logger.debug("Execute Antes");
			cstmt.execute();
			logger.debug("Execute Despues");
			
			codError = cstmt.getInt(82);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(83);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(84);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				codError = 12244;
				numEvento = 10;
				msgError = "No se pudo rescatar la Información en CuentaComDTO getCliente";
				
				logger.error("Ocurrió un error al consultar el Cliente");
				throw new GeneralException(
						"Ocurrió un error al consultar el cliente", String
								.valueOf(codError), numEvento, msgError);
			}			
			else{
				
				CuentaCom.getClienteComDTO().setCodigoCliente(cstmt.getString(2));
				CuentaCom.getClienteComDTO().setNombreCliente(cstmt.getString(3));
				CuentaCom.getClienteComDTO().setCodigoTipoIdentificacion(cstmt.getString(4));
				CuentaCom.getClienteComDTO().setNumeroIdentificacion(cstmt.getString(5));
				CuentaCom.getClienteComDTO().setCodigoCalidadCliente(cstmt.getString(6));
				CuentaCom.getClienteComDTO().setIndicadorSituacion(cstmt.getString(7));
				//clientecom.setfecalta
				//clientecom.setindicador  factur
				CuentaCom.getClienteComDTO().setIndicadorTraspaso(cstmt.getString(10));
				CuentaCom.getClienteComDTO().setIndicadorAgente(cstmt.getString(11));
				//clientecom.setfec ultmod
				CuentaCom.getClienteComDTO().setNumeroFax(cstmt.getString(13));
				CuentaCom.getClienteComDTO().setIndicadorMandato(cstmt.getString(14));
				CuentaCom.getClienteComDTO().setNombreUsuarOra(cstmt.getString(15));
				CuentaCom.getClienteComDTO().setIndicadorAlta(cstmt.getString(16));
				CuentaCom.setCodigoCuenta(cstmt.getString(17));
				CuentaCom.getClienteComDTO().setIndicadorAcepVenta(cstmt.getString(18));
				CuentaCom.getClienteComDTO().setCodigoABC(cstmt.getString(19));
				CuentaCom.getClienteComDTO().setCodigo123(cstmt.getString(20));
				CuentaCom.getClienteComDTO().setCodigoActividad(cstmt.getString(21));
				CuentaCom.getClienteComDTO().setCodigoPais(cstmt.getString(22));
				//clientecom.sette cliente1
				CuentaCom.getClienteComDTO().setNumeroAbocel(cstmt.getString(24));
				//clientecom.settefcliente2
				CuentaCom.getClienteComDTO().setNumeroAbobeep(cstmt.getString(26));
				CuentaCom.getClienteComDTO().setIndicadorDebito(cstmt.getString(27));
				CuentaCom.getClienteComDTO().setNumeroAbotrunk(cstmt.getString(28));
				CuentaCom.getClienteComDTO().setCodigoProspecto(cstmt.getString(29));
				CuentaCom.getClienteComDTO().setNumeroAbotrek(cstmt.getString(30));
				CuentaCom.getClienteComDTO().setCodigoSistemaPago(cstmt.getString(31));
				CuentaCom.getClienteComDTO().setNombreApellido1(cstmt.getString(32));
				CuentaCom.getClienteComDTO().setDireccionEMail(cstmt.getString(33));
				CuentaCom.getClienteComDTO().setNumeroAborent(cstmt.getString(34));
				CuentaCom.getClienteComDTO().setNombreApellido2(cstmt.getString(35));
				CuentaCom.getClienteComDTO().setNumeroAboroaming(cstmt.getString(36));
				CuentaCom.getClienteComDTO().setFechaAcepVenta(cstmt.getString(37));
				CuentaCom.getClienteComDTO().setImporteLimiteDebito(cstmt.getString(38));
				CuentaCom.getClienteComDTO().setCodigoBanco(cstmt.getString(39));
				CuentaCom.getClienteComDTO().setCodigoSucursal(cstmt.getString(40));
				CuentaCom.getClienteComDTO().setIndicadorTipoCuenta(cstmt.getString(41));
				CuentaCom.getClienteComDTO().setCodigoTipoTarjeta(cstmt.getString(42));
				CuentaCom.getClienteComDTO().setNumeroCuentaCorriente(cstmt.getString(43));
				CuentaCom.getClienteComDTO().setNumeroTarjeta(cstmt.getString(44));
				CuentaCom.getClienteComDTO().setFechaVencimientoTarjeta(cstmt.getString(45));
				CuentaCom.getClienteComDTO().setCodigoBancoTarjeta(cstmt.getString(46));
				CuentaCom.getClienteComDTO().setCodigoTipoIdentificacionTributaria(cstmt.getString(47));
				CuentaCom.getClienteComDTO().setNumeroIdentificacionTributaria(cstmt.getString(48));
				CuentaCom.getClienteComDTO().setCodigoTipoIdentificacionApoderado(cstmt.getString(49));
				CuentaCom.getClienteComDTO().setNumeroIdentificacionApoderado(cstmt.getString(50));
				CuentaCom.getClienteComDTO().setNombreApoderado(cstmt.getString(51));
				CuentaCom.getClienteComDTO().setCodigoOficina(cstmt.getString(52));
				//clientecom.setfecbaja
				CuentaCom.getClienteComDTO().setCodigoCobrador(cstmt.getString(54));
				CuentaCom.getClienteComDTO().setCodigoPincli(cstmt.getString(55));
				CuentaCom.getClienteComDTO().setCodigoCiclo(cstmt.getInt(56));
				logger.debug("CuentaCom.getClienteComDTO().setCodigoCiclo ["+CuentaCom.getClienteComDTO().getCodigoCiclo()+"]");
				CuentaCom.getClienteComDTO().setNumeroCelular(cstmt.getString(57));
				CuentaCom.getClienteComDTO().setIndicadirTipPersona(cstmt.getString(58));
				CuentaCom.getClienteComDTO().setCodigoCicloNuevo(cstmt.getString(59));
				CuentaCom.getClienteComDTO().setCodigoCategoria(cstmt.getString(60));
				CuentaCom.getClienteComDTO().setCodigoSector(cstmt.getString(61));
				CuentaCom.getClienteComDTO().setCodigoSupervisor(cstmt.getString(62));
				CuentaCom.getClienteComDTO().setIndicadorEstadoCivil(cstmt.getString(63));
				//clientecom.setfecnacimien
				CuentaCom.getClienteComDTO().setIndicadorSexo(cstmt.getString(65));
				CuentaCom.getClienteComDTO().setNumeroIntGrupoFam(cstmt.getString(66));
				CuentaCom.getClienteComDTO().setCodigoNPI(cstmt.getString(67));
				CuentaCom.getClienteComDTO().setCodigoSubCategoria(cstmt.getString(68));
				CuentaCom.getClienteComDTO().setCodigoUso(cstmt.getString(69));
				CuentaCom.getClienteComDTO().setCodigoIdioma(cstmt.getString(70));
				CuentaCom.getClienteComDTO().setCodigoTipIdent2(cstmt.getString(71));
				CuentaCom.getClienteComDTO().setNumIdent2(cstmt.getString(72));
				CuentaCom.getClienteComDTO().setNombreUsuarioAsesor(cstmt.getString(73));
				CuentaCom.getClienteComDTO().setCodigoOperadora(cstmt.getString(74));
			//	clientecom.setidsegmento
			//	clientecom.setcodigotecnologia
									
				
				CuentaCom.getClienteComDTO().setCodigoEmpresa(new Long(cstmt.getString(77)).longValue());
				CuentaCom.getClienteComDTO().setPlanTarifario(cstmt.getString(78));
				logger.debug("CuentaCom.getClienteComDTO().getPlanTarifario() ["+CuentaCom.getClienteComDTO().getPlanTarifario()+"]");
				CuentaCom.getClienteComDTO().setCodigoPlanTarifario(CuentaCom.getClienteComDTO().getPlanTarifario()); 
				
				
				CuentaCom.getClienteComDTO().setDescripcionEmpresa(cstmt.getString(79));
				CuentaCom.getClienteComDTO().setNumeroAbonados(new Integer(cstmt.getString(80)).intValue());
				
				if (CuentaCom.getClienteComDTO().getCodigoEmpresa() > 0){				
					CuentaCom.getClienteComDTO().setTipoCliente("E");
					CuentaCom.getClienteComDTO().setCodigoCategoriaEmpresa("E");
					CuentaCom.getClienteComDTO().setNumeroAbonadosPorPlan(cstmt.getString(81));
				}else{
					CuentaCom.getClienteComDTO().setTipoCliente("I");
					CuentaCom.getClienteComDTO().setCodigoCategoriaEmpresa("I");
					CuentaCom.getClienteComDTO().setNumeroAbonadosPorPlan("0");
				}
				
				
				logger.debug("cuenta.getClienteComDTO().getCodigoPlanTarifario() ["+CuentaCom.getClienteComDTO().getCodigoPlanTarifario());
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
			// Recuperacion de valores de salida
		}catch(GeneralException e ){
			throw (e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al consultar el cliente",e);
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

		logger.debug("getCliente():end");

		return CuentaCom;
	}
	
	
	public ClienteDTO getCategoriaTributariaCliente(ClienteDTO cliente) throws GeneralException{
		logger.debug("getCategoriaTributariaCliente:inicio");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		logger.debug("Coneccion obtenida OK");
		CallableStatement cstmt =null;
		try {
			//INI-01 (AL) String call = getSQLDatosCliente("VE_servicios_venta_PG","VE_obtiene_cat_trib_cliente_PR",5);
			String call = getSQLDatosCliente("VE_servicios_venta_quiosco_PG","VE_obtiene_cat_trib_cliente_PR",5);
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setInt(1,Integer.parseInt(cliente.getCodigoCliente()));
			cstmt.registerOutParameter(2,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);
			
			logger.debug("Execute Antes");
			cstmt.execute();
			logger.debug("Execute Despues");
			
			String resultado = cstmt.getString(2);
			String categoria = null;
			
			if (resultado.equalsIgnoreCase("B")){
				categoria = "BOLETA";
			}
			else if (resultado.equalsIgnoreCase("F")){
				categoria = "FACTURA";
			}
			else{
				throw new GeneralException("Ocurrió un problema en consulta de categoria, no retornó ni Boleta(B) ni Factura(F)", String
								.valueOf(codError), numEvento, msgError);
			}
			
			cliente.setCategoriaTributaria(categoria);
			
			codError = cstmt.getInt(3);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(4);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(5);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error("Ocurrió un error al consultar categoria tributaria cliente");
				throw new GeneralException(
						"Ocurrió un error al consultar categoria tributaria del cliente", String
								.valueOf(codError), numEvento, msgError);
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
			// Recuperacion de valores de salida

		}catch(GeneralException e ){
			throw (e);	
		}catch (Exception e) {
			logger.error("Ocurrió un error al consultar categoria tributaria cliente",e);
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
		logger.debug("getCategoriaTributariaCliente():end");
		return cliente;
		}

	public WsContratoOutDTO getContratoCliente(WsContratoOutDTO contrato) throws GeneralException{
		logger.debug("getContratoCliente:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		WsContratoOutDTO resultado=new WsContratoOutDTO();
		Connection conn = null;
		conn = getConection();
		logger.debug("Coneccion obtenida OK");
		CallableStatement cstmt = null;
		try {
			//INI-01 (AL) String call = getSQLDatosCliente("VE_PARAMETROS_COMERCIALES_PG","VE_contratocliente_PR",6);
			String call = getSQLDatosCliente("VE_PARAMETROS_COMER_QUIOSCO_PG","VE_contratocliente_PR",6);
			
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			logger.debug("Execute Antes");
			cstmt.setInt(1,Integer.parseInt(contrato.getCodigoCliente()));
			logger.debug("contrato.getCodigoCliente[" + contrato.getCodigoCliente() + "]");
			cstmt.setString(2,contrato.getCodigoTipoContrato());
			logger.debug("contrato.getCodigoTipoContrato[" + contrato.getCodigoTipoContrato() + "]");
			cstmt.registerOutParameter(3,OracleTypes.CURSOR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			
			cstmt.execute();
			logger.debug("Execute Despues");
			
			codError = cstmt.getInt(4);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(5);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(6);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error("Ocurrió un error al consultar los contratos del cliente");
				throw new GeneralException(
						"Ocurrió un error al consultar los contratos del cliente", String
								.valueOf(codError), numEvento, msgError);
			}			
			
			ResultSet rs = (ResultSet)cstmt.getObject(3);
			ArrayList lista = new ArrayList();
			
			logger.debug("inicio llenado");
			while ( rs.next() ) {
				lista.add(rs.getString(2));
			}
			rs.close();
			logger.debug("fin llenado");
			resultado.setContratos(lista);
			if (resultado.getContratos() == null) {
				codError = 12245;
				numEvento = 10;
				msgError = "No se pudo rescatar la Información WsContratoOutDTO getContratoCliente";
				logger.error("Ocurrió un error al consultar los contratos del cliente");
				throw new GeneralException(
						"Ocurrió un error al consultar los contratos del cliente", String
								.valueOf(codError), numEvento, msgError);
				/*throw new GeneralException(
				"Ocurrió un error al consultar el cliente");*/
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
			// Recuperacion de valores de salida

		}catch(GeneralException e ){
			throw (e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al consultar los contratos del cliente",e);
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

		logger.debug("getContratoCliente():end");

		return resultado;
		}
	
	public ResultadoValidacionVentaDTO getExisteCliente(ParametrosValidacionDTO parametros) throws GeneralException{
		logger.debug("getExisteCliente:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ResultadoValidacionVentaDTO resultado=new ResultadoValidacionVentaDTO();
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt =null;
		logger.debug("Coneccion obtenida OK");
		try {
			//INI-01 (AL) String call = getSQLDatosCliente("VE_validacion_linea_PG","VE_existe_cliente_PR",5);
			String call = getSQLDatosCliente("VE_validacion_linea_quiosco_PG","VE_existe_cliente_PR",5);
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1,Integer.parseInt(parametros.getCodigoCliente()));
			cstmt.registerOutParameter(2,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);
			
			
			logger.debug("Execute Antes");
			cstmt.execute();
			logger.debug("Execute Despues");
			
			resultado.setResultadoBase(cstmt.getInt(2));
			
			codError = cstmt.getInt(3);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(4);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(5);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error("Ocurrió un error al consultar el Cliente");
				throw new GeneralException(
						"Ocurrió un error al consultar el cliente", String
								.valueOf(codError), numEvento, msgError);
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
			// Recuperacion de valores de salida

		} catch(GeneralException e ){
			throw (e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al consultar el cliente",e);
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

		logger.debug("getExisteCliente():end");

		return resultado;
	}

	public ResultadoValidacionVentaDTO getExisteClienteEmpresa(ParametrosValidacionDTO parametros) throws GeneralException{
		logger.debug("getExisteClienteEmpresa:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ResultadoValidacionVentaDTO resultado=new ResultadoValidacionVentaDTO();
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		logger.debug("Coneccion obtenida OK");
		try {
			//INI-01 (AL) String call = getSQLDatosCliente("VE_validacion_linea_PG","VE_existe_cliente_empresa_PR",5);
			String call = getSQLDatosCliente("VE_validacion_linea_quiosco_PG","VE_existe_cliente_empresa_PR",5);
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1,Integer.parseInt(parametros.getCodigoCliente()));
			cstmt.registerOutParameter(2,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);
			cstmt.execute();
			resultado.setResultadoBase(cstmt.getInt(2));
			
			codError = cstmt.getInt(3);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(4);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(5);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error("Ocurrió un error al consultar el Cliente Empresa");
				throw new GeneralException(
						"Ocurrió un error al consultar el cliente Empresa", String
								.valueOf(codError), numEvento, msgError);
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
			// Recuperacion de valores de salida
		} catch(GeneralException e ){
			throw (e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al consultar el cliente Empresa",e);
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

		logger.debug("getExisteClienteEmpresa():end");

		return resultado;
	}
	
	public ResultadoValidacionVentaDTO getValidaClienteAgenteComercial(ParametrosValidacionDTO entradaValidacionVentas) throws GeneralException{
		ResultadoValidacionVentaDTO resultado = new ResultadoValidacionVentaDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:getValidaClienteAgenteComercial");
			
			//INI-01 (AL) String call = getSQLDatosCliente("VE_validacion_linea_PG","VE_agente_comercial_PR",5);
			String call = getSQLDatosCliente("VE_validacion_linea_quiosco_PG","VE_agente_comercial_PR",5);
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setInt(1,Integer.parseInt(entradaValidacionVentas.getCodigoCliente()));
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getValidaClienteAgenteComercial:execute");
			cstmt.execute();
			logger.debug("Fin:getValidaClienteAgenteComercial:execute");
				
			codError = cstmt.getInt(3);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(4);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(5);
			logger.debug("numEvento[" + numEvento + "]");

			if (codError != 0) {
				logger.error("Ocurrió un error al verificar si cliente es agente comercial");
				throw new GeneralException(
						"Ocurrió un error al verificar si cliente es agente comercial", String
								.valueOf(codError), numEvento, msgError);
			}else			
				resultado.setResultadoBase(cstmt.getInt(2));
			
		} catch(GeneralException e ){
			throw (e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al verificar si cliente es agente comercial",e);
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

		logger.debug("Fin:getValidaClienteAgenteComercial()");

		return resultado;
	}//fin getValidaClienteAgenteComercial
	
	
	public ClienteDTO getPlanComercial(ClienteDTO cliente) throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:getPlanComercial");
			
			//INI-01 (AL) String call = getSQLDatosCliente("VE_parametros_comerciales_PG","VE_plan_comercial_cliente_PR",5);
			String call = getSQLDatosCliente("VE_parametros_comer_quiosco_PG","VE_plan_comercial_cliente_PR",5);
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setInt(1,Integer.parseInt(cliente.getCodigoCliente()));
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getValidaClienteAgenteComercial:execute");
			cstmt.execute();
			logger.debug("Fin:getValidaClienteAgenteComercial:execute");
			
			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			logger.debug("codError ["+codError+"]" );
			logger.debug("msgError ["+msgError+"]" );
			logger.debug("numEvento ["+numEvento+"]" );
	
			if (codError ==0){
				cliente.setPlanComercial(String.valueOf(cstmt.getLong(2)));
			}else{
				logger.error("Ocurrió un error al buscar plan comercial");
				throw new GeneralException(
						"Ocurrió un error al buscar plan comercial", String
								.valueOf(codError), numEvento, msgError);
			}
				
		}catch(GeneralException e ){
			throw (e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al buscar plan comercial",e);
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

		logger.debug("Fin:getPlanComercial()");

		return cliente;
	}//fin getPlanComercial
	
	/**
	 * Obtiene subcategoria impositiva 
	 * @param cliente
	 * @return ClienteDTO[]
	 * @throws GeneralException
	 */
	public ClienteDTO[] getListSubCategImpos(ClienteDTO cliente) 
	throws GeneralException{
		ClienteDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:getListSubCategImpos");
			
			//INI-01 (AL) String call = getSQLDatosCliente("VE_alta_cliente_PG","VE_getListSubCategImpos_PR",5);
			String call = getSQLDatosCliente("VE_alta_cliente_Quiosco_PG","VE_getListSubCategImpos_PR",5);
			logger.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setInt(1,Integer.parseInt(cliente.getCodigoCategImpos()));
			cstmt.registerOutParameter(2,OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getListSubCategImpos:execute");
			cstmt.execute();
			logger.debug("Fin:getListSubCategImpos:execute");
			
			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			logger.debug("codError ["+codError+"]" );
			logger.debug("msgError ["+msgError+"]" );
			logger.debug("numEvento ["+numEvento+"]" );

			if (codError != 0) {
				logger.error("Ocurrió un error al recuperar sub categorias impositivas");
				throw new GeneralException(
						"Ocurrió un error al recuperar aub categorias impositivas", String
								.valueOf(codError), numEvento, msgError);
			}else{
				logger.debug("Recuperando sub categorias");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(2);
				while (rs.next()) {
					ClienteDTO clienteDTO = new ClienteDTO();
					clienteDTO.setCodigoSubCategImpos(rs.getString(1));
					clienteDTO.setDescripcionSubCategImpos(rs.getString(2));
					
					lista.add(clienteDTO);
				}
				resultado =(ClienteDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), ClienteDTO.class);
				rs.close();
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		}catch(GeneralException e ){
			throw (e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al recuperar sub categorias impositivas",e);
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
		logger.debug("Fin:getListSubCategImpos()");
		return resultado;
	}//fin getListSubCategImpos

	/**
	 * Obtiene listado de categorias impositivas
	 * @param N/A
	 * @return clienteDTO[]
	 * @throws GeneralException
	 */
	public ClienteDTO[] getListCategImpositivas() 
	throws GeneralException{
		logger.debug("Inicio:getListCategImpositivas()");
		ClienteDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt =null;
		try {
			//INI-01 (AL) String call = getSQLDatosCliente("VE_alta_cliente_PG","VE_getListCategImpositivas_PR",4);
			String call = getSQLDatosCliente("VE_alta_cliente_Quiosco_PG","VE_getListCategImpositivas_PR",4);

			logger.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			cstmt.registerOutParameter(1,OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getListCategImpositivas:execute");
			cstmt.execute();
			logger.debug("Fin:getListCategImpositivas:execute");

			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);
			
			logger.debug("codError ["+codError+"]" );
			logger.debug("msgError ["+msgError+"]" );
			logger.debug("numEvento ["+numEvento+"]" );
			
			if (codError != 0) {
				logger.error("Ocurrió un error al recuperar categorias impositivas");
				throw new GeneralException(
						"Ocurrió un error al recuperar categorias impositivas", String
								.valueOf(codError), numEvento, msgError);
			}else{
				logger.debug("Recuperando categorias");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(1);
				while (rs.next()) {
					ClienteDTO clienteDTO = new ClienteDTO();
					clienteDTO.setCodigoCategImpos(rs.getString(1));
					clienteDTO.setDescripcionCategImpos(rs.getString(2));
					
					lista.add(clienteDTO);
				}
				resultado =(ClienteDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), ClienteDTO.class);
				rs.close();
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		}catch(GeneralException e ){
			throw (e);	
		} catch (Exception e) {
			logger.error("Ocurrió un error al recuperar categorias impositivas",e);
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
		logger.debug("Fin:getListCategImpositivas()");
		return resultado;
	}//fin getListCategImpositivas	
	
	/**
	 * Obtiene categorias del cliente
	 * @param N/A
	 * @return clienteDTO[]
	 * @throws GeneralException
	 */
	public ClienteDTO[] getListCategorias() 
	throws GeneralException{
		logger.debug("Inicio:getListCategorias()");
		ClienteDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt =null;
		try {
			//INI-01 (AL) String call = getSQLDatosCliente("VE_alta_cliente_PG","VE_getListCategorias_PR",4);
			String call = getSQLDatosCliente("VE_alta_cliente_Quiosco_PG","VE_getListCategorias_PR",4);

			logger.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			cstmt.registerOutParameter(1,OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getListCategorias:execute");
			cstmt.execute();
			logger.debug("Fin:getListCategorias:execute");

			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);
			
			logger.debug("codError ["+codError+"]" );
			logger.debug("msgError ["+msgError+"]" );
			logger.debug("numEvento ["+numEvento+"]" );
			
			if (codError != 0) {
				logger.error("Ocurrió un error al recuperar categorias");
				throw new GeneralException(
						"Ocurrió un error al recuperar categorias", String
								.valueOf(codError), numEvento, msgError);
			}else{
				logger.debug("Recuperando categorias");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(1);
				while (rs.next()) {
					ClienteDTO clienteDTO = new ClienteDTO();
					clienteDTO.setCodigoCategoria(rs.getString(1));
					clienteDTO.setDescripcionCategoria(rs.getString(2));
					lista.add(clienteDTO);
				}
				rs.close();
				resultado =(ClienteDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), ClienteDTO.class);
				
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		}catch(GeneralException e ){
			throw (e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al recuperar categorias",e);
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
		logger.debug("Fin:getListCategorias()");
		return resultado;
	}//fin getListCategorias	
	
	/**
	 * Obtiene relacion cliente vendedor
	 * @param entrada
	 * @return resultado
	 * @throws GeneralException
	 */
	public ClienteDTO getClienteVendedor(ClienteDTO entrada) 
	throws GeneralException{
		logger.debug("Inicio:getClienteVendedor");
		ClienteDTO resultado = new ClienteDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		logger.debug("Coneccion obtenida OK");
		CallableStatement cstmt =null;
		try {
			
			//INI-01 (AL) String call = getSQLDatosCliente("VE_alta_cliente_PG","VE_getClienteVendedor_PR",9);
			String call = getSQLDatosCliente("VE_alta_cliente_Quiosco_PG","VE_getClienteVendedor_PR",9);
			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,entrada.getCodigoTipoIdentificacion());
			cstmt.setString(2,entrada.getNumeroIdentificacion());

			cstmt.registerOutParameter(3,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9,java.sql.Types.NUMERIC);
			
			logger.debug("Iniico:getClienteVendedor:Execute");
			cstmt.execute();
			logger.debug("Fin:getClienteVendedor:Execute");

			codError = cstmt.getInt(7);
			msgError = cstmt.getString(8);
			numEvento = cstmt.getInt(9);
			
			logger.debug("codError ["+codError+"]" );
			logger.debug("msgError ["+msgError+"]" );
			logger.debug("numEvento ["+numEvento+"]" );

			if (codError != 0) {
				logger.error("Ocurrió un error al obtener relacion cliente vendedor");
				throw new GeneralException(
						"Ocurrió un error al obtener relacion cliente vendedor", String
								.valueOf(codError), numEvento, msgError);
			}
			else{
				resultado.setCodigoCategoria(cstmt.getString(3));
				resultado.setCodigoSector(cstmt.getString(4));
				resultado.setCodigoSupervisor(cstmt.getString(5));
				resultado.setCodigoVendedor(cstmt.getInt(6));
			}

			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		}catch(GeneralException e ){
			throw (e);
		}catch (Exception e) {
			logger.error("Ocurrió un error al obtener relacion cliente vendedor",e);
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
		logger.debug("Fin:getClienteVendedor()");
		return resultado;
		}//fin getClienteVendedor
	
	/**
	 * Obtiene codigo de la nueva empresa
	 * @param N/A
	 * @return resultado
	 * @throws GeneralException
	 */
	public ClienteDTO getCodigoNuevaEmpresa() 
	throws GeneralException{
		logger.debug("Inicio:getCodigoNuevaEmpresa");
		ClienteDTO resultado = new ClienteDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		logger.debug("Coneccion obtenida OK");
		CallableStatement cstmt =null;
		try {
			//INI-01 (AL) String call = getSQLDatosCliente("VE_alta_cliente_PG","getCodigoNuevaEmpresa",4);
			String call = getSQLDatosCliente("VE_alta_cliente_Quiosco_PG","getCodigoNuevaEmpresa",4);
			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			
			cstmt.registerOutParameter(1,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(2,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);
			
			logger.debug("Iniico:getCodigoNuevaEmpresa:Execute");
			cstmt.execute();
			logger.debug("Fin:getCodigoNuevaEmpresa:Execute");

			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);
			
			logger.debug("codError ["+codError+"]" );
			logger.debug("msgError ["+msgError+"]" );
			logger.debug("numEvento ["+numEvento+"]" );

			if (codError != 0) {
				logger.error("Ocurrió un error al obtener codigo nueva empresa");
				throw new GeneralException(
						"Ocurrió un error al obtener codigo nueva empresa", String
								.valueOf(codError), numEvento, msgError);
			}
			else
				resultado.setCodigoEmpresa(cstmt.getLong(1));

			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		}catch(GeneralException e ){
			throw (e);
		}catch (Exception e) {
			logger.error("Ocurrió un error al obtener codigo nueva empresa",e);
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
		logger.debug("Fin:getCodigoNuevaEmpresa()");
		return resultado;
		}//fin getCodigoNuevaEmpresa

	/**
	 * Obtiene nuevo codigo de cliente
	 * @param N/A
	 * @return resultado
	 * @throws GeneralException
	 */
	public ClienteDTO getNuevoCliente() 
	throws GeneralException{
		logger.debug("Inicio:getNuevoCliente");
		ClienteDTO resultado = new ClienteDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt =null;
		logger.debug("Coneccion obtenida OK");
		try {
			//INI-01 (AL) String call = getSQLDatosCliente("VE_alta_cliente_PG","VE_getNuevoCliente_PR",4);
			String call = getSQLDatosCliente("VE_alta_cliente_Quiosco_PG","VE_getNuevoCliente_PR",4);
			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			
			cstmt.registerOutParameter(1,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(2,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);
			
			logger.debug("Iniico:getNuevoCliente:Execute");
			cstmt.execute();
			logger.debug("Fin:getNuevoCliente:Execute");

			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);
			
			logger.debug("codError ["+codError+"]" );
			logger.debug("msgError ["+msgError+"]" );
			logger.debug("numEvento ["+numEvento+"]" );

			if (codError != 0) {
				logger.error("Ocurrió un error al obtener nuevo codigo de cliente");
				throw new GeneralException(
						"Ocurrió un error al obtener nuevo codigo de cliente", String
								.valueOf(codError), numEvento, msgError);
			}
			else
				resultado.setCodigoCliente(cstmt.getString(1));

			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		}catch(GeneralException e ){
			throw (e);
		} 
		catch (Exception e) {
			logger.error("Ocurrió un error al obtener nuevo codigo de cliente",e);
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
		logger.debug("Fin:getNuevoCliente()");
		return resultado;
		}//fin getNuevoCliente
	
	/**
	 * Inserta cliente
	 * @param cliente
	 * @return N/A
	 * @throws GeneralException
	 */
	public void insCliente(CuentaComDTO cuenta) 
	throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:insCliente");
			
			//INI-01 (AL) String call = getSQLDatosCliente("VE_alta_cliente_PG","VE_insCliente_PR",75);
			String call = getSQLDatosCliente("VE_alta_cliente_Quiosco_PG","VE_insCliente_PR",76);
			logger.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
		
			cstmt.setString(1,cuenta.getClienteComDTO().getCodigoCliente());
			logger.debug("cuenta.getClienteComDTO().getCodigoCliente(): " + cuenta.getClienteComDTO().getCodigoCliente());
			cstmt.setString(2,cuenta.getClienteComDTO().getNombreCliente());
			logger.debug("cuenta.getClienteComDTO().getNombreCliente(): " + cuenta.getClienteComDTO().getNombreCliente());
			cstmt.setString(3,cuenta.getClienteComDTO().getCodigoTipoIdentificacion());
			logger.debug("cuenta.getClienteComDTO().getCodigoTipoIdentificacion(): " + cuenta.getClienteComDTO().getCodigoTipoIdentificacion());
			cstmt.setString(4,cuenta.getClienteComDTO().getNumeroIdentificacion());
			logger.debug("cuenta.getClienteComDTO().getNumeroIdentificacion(): " + cuenta.getClienteComDTO().getNumeroIdentificacion());
			cstmt.setString(5,cuenta.getClienteComDTO().getCodigoCalidadCliente());
			logger.debug("cuenta.getClienteComDTO().getCodigoCalidadCliente(): " + cuenta.getClienteComDTO().getCodigoCalidadCliente());
			cstmt.setString(6,cuenta.getClienteComDTO().getIndicadorSituacion());
			logger.debug("cuenta.getClienteComDTO().getIndicadorSituacion(): " + cuenta.getClienteComDTO().getIndicadorSituacion());
			cstmt.setString(7,String.valueOf(cuenta.getClienteComDTO().getIndicativoFacturable()));
			logger.debug("cuenta.getClienteComDTO().getIndicativoFacturable(): " + cuenta.getClienteComDTO().getIndicativoFacturable());
			cstmt.setString(8,cuenta.getClienteComDTO().getIndicadorTraspaso());
			logger.debug("cuenta.getClienteComDTO().getIndicadorTraspaso(): " + cuenta.getClienteComDTO().getIndicadorTraspaso());
			cstmt.setString(9,cuenta.getClienteComDTO().getIndicadorAgente());
			logger.debug("cuenta.getClienteComDTO().getIndicadorAgente(): " + cuenta.getClienteComDTO().getIndicadorAgente());
			cstmt.setString(10,cuenta.getClienteComDTO().getNumeroFax());
			logger.debug("cuenta.getClienteComDTO().getNumeroFax(): " + cuenta.getClienteComDTO().getNumeroFax());
			cstmt.setString(11,cuenta.getClienteComDTO().getIndicadorMandato());
			logger.debug("cuenta.getClienteComDTO().getIndicadorMandato(): " + cuenta.getClienteComDTO().getIndicadorMandato());
			cstmt.setString(12,cuenta.getClienteComDTO().getNombreUsuarOra());
			logger.debug("cuenta.getClienteComDTO().getNombreUsuarOra(): " + cuenta.getClienteComDTO().getNombreUsuarOra());
			cstmt.setString(13,cuenta.getClienteComDTO().getIndicadorAlta());
			logger.debug("cuenta.getClienteComDTO().getIndicadorAlta(): " + cuenta.getClienteComDTO().getIndicadorAlta());
			cstmt.setString(14,cuenta.getCodigoCuenta());
			logger.debug("cuenta.getCodigoCuenta(): " + cuenta.getCodigoCuenta());
			cstmt.setString(15,cuenta.getClienteComDTO().getIndicadorAcepVenta());
			logger.debug("cuenta.getClienteComDTO().getIndicadorAcepVenta(): " + cuenta.getClienteComDTO().getIndicadorAcepVenta());
			cstmt.setString(16,cuenta.getClienteComDTO().getCodigoABC());
			logger.debug("cuenta.getClienteComDTO().getCodigoABC(): " + cuenta.getClienteComDTO().getCodigoABC());
			cstmt.setString(17,cuenta.getClienteComDTO().getCodigo123());
			logger.debug("cuenta.getClienteComDTO().getCodigo123(): " + cuenta.getClienteComDTO().getCodigo123());
			cstmt.setString(18,cuenta.getClienteComDTO().getCodigoActividad());
			logger.debug("cuenta.getClienteComDTO().getCodigoActividad(): " + cuenta.getClienteComDTO().getCodigoActividad());
			cstmt.setString(19,cuenta.getClienteComDTO().getCodigoPais());
			logger.debug("cuenta.getClienteComDTO().getCodigoPais()): " + cuenta.getClienteComDTO().getCodigoPais());
			cstmt.setString(20,cuenta.getClienteComDTO().getNumeroTelefono1());
			logger.debug("cuenta.getClienteComDTO().getNumeroTelefono1(): " + cuenta.getClienteComDTO().getNumeroTelefono1());
			cstmt.setString(21,cuenta.getClienteComDTO().getNumeroAbocel());
			logger.debug("cuenta.getClienteComDTO().getNumeroAbocel(): " + cuenta.getClienteComDTO().getNumeroAbocel());
			cstmt.setString(22,cuenta.getClienteComDTO().getNumeroTelefono2());
			logger.debug("cuenta.getClienteComDTO().getNumeroTelefono2(): " + cuenta.getClienteComDTO().getNumeroTelefono2());
			cstmt.setString(23,cuenta.getClienteComDTO().getNumeroAbobeep());
			logger.debug("cuenta.getClienteComDTO().getNumeroAbobeep(): " + cuenta.getClienteComDTO().getNumeroAbobeep());
			cstmt.setString(24,cuenta.getClienteComDTO().getIndicadorDebito());
			logger.debug("cuenta.getClienteComDTO().getIndicadorDebito(): " + cuenta.getClienteComDTO().getIndicadorDebito());
			cstmt.setString(25,cuenta.getClienteComDTO().getNumeroAbotrunk());
			logger.debug("cuenta.getClienteComDTO().getNumeroAbotrunk(): " + cuenta.getClienteComDTO().getNumeroAbotrunk());
			cstmt.setString(26,cuenta.getClienteComDTO().getCodigoProspecto());
			logger.debug("cuenta.getClienteComDTO().getCodigoProspecto(): " + cuenta.getClienteComDTO().getCodigoProspecto());
			cstmt.setString(27,cuenta.getClienteComDTO().getNumeroAbotrek());
			logger.debug("cuenta.getClienteComDTO().getNumeroAbotrek(): " + cuenta.getClienteComDTO().getNumeroAbotrek());
			cstmt.setString(28,cuenta.getClienteComDTO().getCodigoSistemaPago());
			logger.debug("cuenta.getClienteComDTO().getCodigoSistemaPago(): " + cuenta.getClienteComDTO().getCodigoSistemaPago());
			cstmt.setString(29,cuenta.getClienteComDTO().getNombreApellido1());
			logger.debug("cuenta.getClienteComDTO().getNombreApellido1(): " + cuenta.getClienteComDTO().getNombreApellido1());
			cstmt.setString(30,cuenta.getClienteComDTO().getDireccionEMail());
			logger.debug("cuenta.getClienteComDTO().getDireccionEMail(): " + cuenta.getClienteComDTO().getDireccionEMail());
			cstmt.setString(31,cuenta.getClienteComDTO().getNumeroAborent());
			logger.debug("cuenta.getClienteComDTO().getNumeroAborent(): " + cuenta.getClienteComDTO().getNumeroAborent());
			cstmt.setString(32,cuenta.getClienteComDTO().getNombreApellido2());
			logger.debug("cuenta.getClienteComDTO().getNombreApellido2(): " + cuenta.getClienteComDTO().getNombreApellido2());
			cstmt.setString(33,cuenta.getClienteComDTO().getNumeroAboroaming());
			logger.debug("cuenta.getClienteComDTO().getNumeroAboroaming(): " + cuenta.getClienteComDTO().getNumeroAboroaming());
			cstmt.setString(34,cuenta.getClienteComDTO().getFechaAcepVenta());
			logger.debug("cuenta.getClienteComDTO().getFechaAcepVenta(): " + cuenta.getClienteComDTO().getFechaAcepVenta());
			cstmt.setString(35,cuenta.getClienteComDTO().getImporteLimiteDebito());
			logger.debug("cuenta.getClienteComDTO().getImporteLimiteDebito(): " + cuenta.getClienteComDTO().getImporteLimiteDebito());
			cstmt.setString(36,cuenta.getClienteComDTO().getCodigoBanco());
			logger.debug("cuenta.getClienteComDTO().getCodigoBanco(): " + cuenta.getClienteComDTO().getCodigoBanco());
			cstmt.setString(37,cuenta.getClienteComDTO().getCodigoSucursal());
			logger.debug("cuenta.getClienteComDTO().getCodigoSucursal(): " + cuenta.getClienteComDTO().getCodigoSucursal());
			cstmt.setString(38,cuenta.getClienteComDTO().getIndicadorTipoCuenta());
			logger.debug("cuenta.getClienteComDTO().getIndicadorTipoCuenta(): " + cuenta.getClienteComDTO().getIndicadorTipoCuenta());
			cstmt.setString(39,cuenta.getClienteComDTO().getCodigoTipoTarjeta());
			logger.debug("cuenta.getClienteComDTO().getCodigoTipoTarjeta(): " + cuenta.getClienteComDTO().getCodigoTipoTarjeta());
			cstmt.setString(40,cuenta.getClienteComDTO().getNumeroCuentaCorriente());
			logger.debug("cuenta.getClienteComDTO().getNumeroCuentaCorriente(): " + cuenta.getClienteComDTO().getNumeroCuentaCorriente());
			cstmt.setString(41,cuenta.getClienteComDTO().getNumeroTarjeta());
			logger.debug("cuenta.getClienteComDTO().getNumeroTarjeta(): " + cuenta.getClienteComDTO().getNumeroTarjeta());
			cstmt.setString(42,cuenta.getClienteComDTO().getFechaVencimientoTarjeta());
			logger.debug("cuenta.getClienteComDTO().getFechaVencimientoTarjeta(): " + cuenta.getClienteComDTO().getFechaVencimientoTarjeta());
			cstmt.setString(43,cuenta.getClienteComDTO().getCodigoBancoTarjeta());
			logger.debug("cuenta.getClienteComDTO().getCodigoBancoTarjeta(): " + cuenta.getClienteComDTO().getCodigoBancoTarjeta());
			cstmt.setString(44,cuenta.getClienteComDTO().getCodigoTipoIdentificacionTributaria());
			logger.debug("cuenta.getClienteComDTO().getCodigoTipoIdentificacionTributaria(): " + cuenta.getClienteComDTO().getCodigoTipoIdentificacionTributaria());
			cstmt.setString(45,cuenta.getClienteComDTO().getNumeroIdentificacionTributaria());
			logger.debug("cuenta.getClienteComDTO().getNumeroIdentificacionTributaria(): " + cuenta.getClienteComDTO().getNumeroIdentificacionTributaria());
			cstmt.setString(46,cuenta.getClienteComDTO().getCodigoTipoIdentificacionApoderado());
			logger.debug("cuenta.getClienteComDTO().getCodigoTipoIdentificacionApoderado(): " + cuenta.getClienteComDTO().getCodigoTipoIdentificacionApoderado());
			cstmt.setString(47,cuenta.getClienteComDTO().getNumeroIdentificacionApoderado());
			logger.debug("cuenta.getClienteComDTO().getNumeroIdentificacionApoderado(): " + cuenta.getClienteComDTO().getNumeroIdentificacionApoderado());
			cstmt.setString(48,cuenta.getClienteComDTO().getNombreApoderado());
			logger.debug("cuenta.getClienteComDTO().getNombreApoderado(): " + cuenta.getClienteComDTO().getNombreApoderado());
			cstmt.setString(49,cuenta.getClienteComDTO().getCodigoOficina());
			logger.debug("cuenta.getClienteComDTO().getCodigoOficina(): " + cuenta.getClienteComDTO().getCodigoOficina());
			cstmt.setString(50,cuenta.getClienteComDTO().getFechaBaja());
			logger.debug("cuenta.getClienteComDTO().getFechaBaja(): " + cuenta.getClienteComDTO().getFechaBaja());
			cstmt.setString(51,cuenta.getClienteComDTO().getCodigoCobrador());
			logger.debug("cuenta.getClienteComDTO().getCodigoCobrador(): " + cuenta.getClienteComDTO().getCodigoCobrador());
			cstmt.setString(52,cuenta.getClienteComDTO().getCodigoPincli());
			logger.debug("cuenta.getClienteComDTO().getCodigoPincli(): " + cuenta.getClienteComDTO().getCodigoPincli());
			cstmt.setString(53,cuenta.getClienteComDTO().getCodigoCicloFacturacion());
			logger.debug("cuenta.getClienteComDTO().getCodigoCicloFacturacion(): " + cuenta.getClienteComDTO().getCodigoCicloFacturacion());
			cstmt.setString(54,cuenta.getClienteComDTO().getNumeroCelular());
			logger.debug("cuenta.getClienteComDTO().getNumeroCelular(): " + cuenta.getClienteComDTO().getNumeroCelular());
			cstmt.setString(55,cuenta.getClienteComDTO().getIndicadirTipPersona());
			logger.debug("cuenta.getClienteComDTO().getIndicadirTipPersona(): " + cuenta.getClienteComDTO().getIndicadirTipPersona());
			cstmt.setString(56,cuenta.getClienteComDTO().getCodigoCicloNuevo());
			logger.debug("cuenta.getClienteComDTO().getCodigoCicloNuevo(): " + cuenta.getClienteComDTO().getCodigoCicloNuevo());
			cstmt.setString(57,cuenta.getClienteComDTO().getCodigoCategoria());
			logger.debug("cuenta.getClienteComDTO().getCodigoCategoria(): " + cuenta.getClienteComDTO().getCodigoCategoria());
			cstmt.setString(58,cuenta.getClienteComDTO().getCodigoSector());
			logger.debug("cuenta.getClienteComDTO().getCodigoSector(): " + cuenta.getClienteComDTO().getCodigoSector());
			cstmt.setString(59,cuenta.getClienteComDTO().getCodigoSupervisor());
			logger.debug("cuenta.getClienteComDTO().getCodigoSupervisor(): " + cuenta.getClienteComDTO().getCodigoSupervisor());
			cstmt.setString(60,cuenta.getClienteComDTO().getIndicadorEstadoCivil());
			logger.debug("cuenta.getClienteComDTO().getIndicadorEstadoCivil(): " + cuenta.getClienteComDTO().getIndicadorEstadoCivil());
			cstmt.setString(61,cuenta.getClienteComDTO().getFechaNacimiento());
			logger.debug("cuenta.getClienteComDTO().getFechaNacimiento(): " + cuenta.getClienteComDTO().getFechaNacimiento());
			cstmt.setString(62,cuenta.getClienteComDTO().getIndicadorSexo());
			logger.debug("cuenta.getClienteComDTO().getIndicadorSexo(): " + cuenta.getClienteComDTO().getIndicadorSexo());
			cstmt.setString(63,cuenta.getClienteComDTO().getNumeroIntGrupoFam());
			logger.debug("cuenta.getClienteComDTO().getNumeroIntGrupoFam(): " + cuenta.getClienteComDTO().getNumeroIntGrupoFam());
			cstmt.setString(64,cuenta.getClienteComDTO().getCodigoNPI());
			logger.debug("cuenta.getClienteComDTO().getCodigoNPI(): " + cuenta.getClienteComDTO().getCodigoNPI());
			cstmt.setString(65,cuenta.getClienteComDTO().getCodigoSubCategoria());
			logger.debug("cuenta.getClienteComDTO().getCodigoSubCategoria(): " + cuenta.getClienteComDTO().getCodigoSubCategoria());
			cstmt.setString(66,cuenta.getClienteComDTO().getCodigoUso());
			logger.debug("cuenta.getClienteComDTO().getCodigoUso(): " + cuenta.getClienteComDTO().getCodigoUso());
			cstmt.setString(67,cuenta.getClienteComDTO().getCodigoIdioma());
			logger.debug("cuenta.getClienteComDTO().getCodigoIdioma(): " + cuenta.getClienteComDTO().getCodigoIdioma());
			cstmt.setString(68,cuenta.getClienteComDTO().getCodigoTipIdent2());
			logger.debug("cuenta.getClienteComDTO().getCodigoTipIdent2(): " + cuenta.getClienteComDTO().getCodigoTipIdent2());
			cstmt.setString(69,cuenta.getClienteComDTO().getNumIdent2());
			logger.debug("cuenta.getClienteComDTO().getNumIdent2(): " + cuenta.getClienteComDTO().getNumIdent2());
			cstmt.setString(70,cuenta.getClienteComDTO().getNombreUsuarioAsesor());
			logger.debug("cuenta.getClienteComDTO().getNombreUsuarioAsesor(): " + cuenta.getClienteComDTO().getNombreUsuarioAsesor());
			cstmt.setString(71,cuenta.getClienteComDTO().getCodigoOperadora());
			logger.debug("cuenta.getClienteComDTO().getCodigoOperadora(): " + cuenta.getClienteComDTO().getCodigoOperadora());
			cstmt.setString(72,cuenta.getClienteComDTO().getIndentificadorSegmento());
			logger.debug("cuenta.getClienteComDTO().getIndentificadorSegmento(): " + cuenta.getClienteComDTO().getIndentificadorSegmento());

			//INICIO CSR_11002
			cstmt.setString(73,cuenta.getClienteComDTO().getCodCrediticia());
			logger.debug("cuenta.getClienteComDTO().getCodCrediticia(): " + cuenta.getClienteComDTO().getCodCrediticia());
			//FIN CSR-11002
			
			cstmt.registerOutParameter(74, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(75, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(76, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:insCliente:execute");
			cstmt.execute();
			logger.debug("Fin:insCliente:execute");
			
			codError = cstmt.getInt(74);
			msgError = cstmt.getString(75);
			numEvento = cstmt.getInt(76);
			
			logger.debug("codError ["+codError+"]" );
			logger.debug("msgError ["+msgError+"]" );
			logger.debug("numEvento ["+numEvento+"]" );
			
			if (codError !=0){
				logger.error("Ocurrió un error al insertar cliente");
				throw new GeneralException(
						"Ocurrió un error al insertar cliente", String
								.valueOf(codError), numEvento, msgError);
			}
		}catch(GeneralException e ){
			throw (e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al insertar cliente",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al insertar cliente", String
							.valueOf(codError), numEvento, msgError);
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
		logger.debug("Fin:insCliente()");
	}//fin insCliente
	
	/**
	 * Actualiza categoria del cliente
	 * @param cliente
	 * @return N/A
	 * @throws GeneralException
	 */
	public void updCategCliente(ClienteDTO cliente) 
	throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:updCategCliente");
			
			//INI-01 (AL) String call = getSQLDatosCliente("VE_alta_cliente_PG","VE_updCategCliente_PR",6);
			String call = getSQLDatosCliente("VE_alta_cliente_Quiosco_PG","VE_updCategCliente_PR",6);
			logger.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,cliente.getCodigoCliente());
			cstmt.setString(2,String.valueOf(cliente.getCodigoCategoria()));

			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:updCategCliente:execute");
			cstmt.execute();
			logger.debug("Fin:updCategCliente:execute");
			
			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			logger.debug("codError ["+codError+"]" );
			logger.debug("msgError ["+msgError+"]" );
			logger.debug("numEvento ["+numEvento+"]" );

			if (codError !=0){
				logger.error("Ocurrió un error al actualizar categoria del cliente");
				throw new GeneralException(
						"Ocurrió un error al actualizar categoria del cliente", String
								.valueOf(codError), numEvento, msgError);
			}
		}catch(GeneralException e ){
			throw (e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al actualizar categoria del cliente",e);
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
		logger.debug("Fin:updCategCliente()");
	}//fin updCategCliente

	/**
	 * Inserta registro en tabla GE_MODCLI
	 * @param cliente
	 * @return N/A
	 * @throws GeneralException
	 */
	public void setModificacionCliente(ClienteComDTO cliente) 
	throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:setModificacionCliente");
			
			//INI-01 (AL) String call = getSQLDatosCliente("VE_alta_cliente_PG","VE_insModCliente_PR",59);
			String call = getSQLDatosCliente("VE_alta_cliente_Quiosco_PG","VE_insModCliente_PR",59);
			logger.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,cliente.getCodigoCliente());
			logger.debug("cliente.getCodigoCliente(): " + cliente.getCodigoCliente());
			cstmt.setString(2,cliente.getCodigoModificacion());
			logger.debug("cliente.getCodigoModificacion(): " + cliente.getCodigoModificacion());
			cstmt.setString(3,null);
			logger.debug("fecha modificacion: null");
			cstmt.setString(4,cliente.getNombreUsuarOra());
			logger.debug("cliente.getNombreUsuarOra(): " + cliente.getNombreUsuarOra());
			cstmt.setString(5,cliente.getNombreCliente());
			logger.debug("cliente.getNombreCliente(): " + cliente.getNombreCliente());
			cstmt.setString(6,cliente.getCodigoTipoIdentificacion());
			logger.debug("cliente.getCodigoTipoIdentificacion(): " + cliente.getCodigoTipoIdentificacion());
			cstmt.setString(7,cliente.getNumeroIdentificacion());
			logger.debug("cliente.getNumeroIdentificacion(): " + cliente.getNumeroIdentificacion());
			cstmt.setString(8,cliente.getCodigoCalidadCliente());
			logger.debug("cliente.getCodigoCalidadCliente(): " + cliente.getCodigoCalidadCliente());
			cstmt.setString(9,cliente.getCodigoPlanComercial());
			logger.debug("cliente.getCodigoPlanComercial(): " + cliente.getCodigoPlanComercial());
			cstmt.setString(10,String.valueOf(cliente.getIndicativoFacturable()));
			logger.debug("cliente.getIndicativoFacturable(): " + cliente.getIndicativoFacturable());
			cstmt.setString(11,cliente.getIndicadorTraspaso());
			logger.debug("cliente.getIndicadorTraspaso(): " + cliente.getIndicadorTraspaso());
			cstmt.setString(12,cliente.getCodigoActividad());
			logger.debug("cliente.getCodigoActividad(): " + cliente.getCodigoActividad());
			cstmt.setString(13,cliente.getCodigoPais());
			logger.debug("cliente.getCodigoPais()): " + cliente.getCodigoPais());
			cstmt.setString(14,cliente.getNumeroTelefono1());
			logger.debug("cliente.getNumeroTelefono1(): " + cliente.getNumeroTelefono1());
			cstmt.setString(15,cliente.getNumeroTelefono2());
			logger.debug("cliente.getNumeroTelefono2(): " + cliente.getNumeroTelefono2());
			cstmt.setString(16,cliente.getNumeroFax());
			logger.debug("cliente.getNumeroFax(): " + cliente.getNumeroFax());
			cstmt.setString(17,cliente.getIndicadorDebito());
			logger.debug("cliente.getIndicadorDebito(): " + cliente.getIndicadorDebito());
			cstmt.setString(18,cliente.getCodigoSistemaPago());
			logger.debug("cliente.getCodigoSistemaPago(): " + cliente.getCodigoSistemaPago());
			cstmt.setString(19,cliente.getNombreApellido1());
			logger.debug("cliente.getNombreApellido1(): " + cliente.getNombreApellido1());
			cstmt.setString(20,cliente.getNombreApellido2());
			logger.debug("cliente.getNombreApellido2(): " + cliente.getNombreApellido2());
			cstmt.setString(21,cliente.getImporteLimiteDebito());
			logger.debug("cliente.getImporteLimiteDebito(): " + cliente.getImporteLimiteDebito());
			cstmt.setString(22,cliente.getCodigoBanco());
			logger.debug("cliente.getCodigoBanco(): " + cliente.getCodigoBanco());
			cstmt.setString(23,cliente.getCodigoSucursal());
			logger.debug("cliente.getCodigoSucursal(): " + cliente.getCodigoSucursal());
			cstmt.setString(24,cliente.getIndicadorTipoCuenta());
			logger.debug("cliente.getIndicadorTipoCuenta(): " + cliente.getIndicadorTipoCuenta());
			cstmt.setString(25,cliente.getCodigoTipoTarjeta());
			logger.debug("cliente.getCodigoTipoTarjeta(): " + cliente.getCodigoTipoTarjeta());
			cstmt.setString(26,cliente.getNumeroCuentaCorriente());
			logger.debug("cliente.getNumeroCuentaCorriente(): " + cliente.getNumeroCuentaCorriente());
			cstmt.setString(27,cliente.getNumeroTarjeta());
			logger.debug("cliente.getNumeroTarjeta(): " + cliente.getNumeroTarjeta());
			cstmt.setString(28,cliente.getFechaVencimientoTarjeta());
			logger.debug("cliente.getFechaVencimientoTarjeta(): " + cliente.getFechaVencimientoTarjeta());
			cstmt.setString(29,cliente.getCodigoBancoTarjeta());
			logger.debug("cliente.getCodigoBancoTarjeta(): " + cliente.getCodigoBancoTarjeta());
			cstmt.setString(30,cliente.getCodigoTipoIdentificacionTributaria());
			logger.debug("cliente.getCodigoTipoIdentificacionTributaria(): " + cliente.getCodigoTipoIdentificacionTributaria());
			cstmt.setString(31,cliente.getNumeroIdentificacionTributaria());
			logger.debug("cliente.getNumeroIdentificacionTributaria(): " + cliente.getNumeroIdentificacionTributaria());
			cstmt.setString(32,cliente.getCodigoTipoIdentificacionApoderado());
			logger.debug("cliente.getCodigoTipoIdentificacionApoderado(): " + cliente.getCodigoTipoIdentificacionApoderado());
			cstmt.setString(33,cliente.getNumeroIdentificacionApoderado());
			logger.debug("cliente.getNumeroIdentificacionApoderado(): " + cliente.getNumeroIdentificacionApoderado());
			cstmt.setString(34,cliente.getNombreApoderado());
			logger.debug("cliente.getNombreApoderado(): " + cliente.getNombreApoderado());
			cstmt.setString(35,cliente.getCodigoOficina());
			logger.debug("cliente.getCodigoOficina(): " + cliente.getCodigoOficina());
			cstmt.setString(36,cliente.getCodigoIdentificacionCliente());
			logger.debug("cliente.getCodigoIdentificacionCliente(): " + cliente.getCodigoIdentificacionCliente());
			cstmt.setString(37,cliente.getDireccionEMail());
			logger.debug("cliente.getDireccionEMail(): " + cliente.getDireccionEMail());
			cstmt.setString(38,cliente.getCodigoCicloFacturacion());
			logger.debug("cliente.getCodigoCicloFacturacion(): " + cliente.getCodigoCicloFacturacion());
			cstmt.setString(39,cliente.getCodigoCategoria());
			logger.debug("cliente.getCodigoCategoria(): " + cliente.getCodigoCategoria());
			cstmt.setString(40,String.valueOf(cliente.getCodigoSector()));
			logger.debug("cliente.getCodigoSector(): " + cliente.getCodigoSector());
			cstmt.setString(41,String.valueOf(cliente.getCodigoSupervisor()));
			logger.debug("cliente.getCodigoSupervisor(): " + cliente.getCodigoSupervisor());
			cstmt.setString(42,cliente.getIndicadorPrivacidad());
			logger.debug("cliente.getIndicadorPrivacidad(): " + cliente.getIndicadorPrivacidad());
			cstmt.setString(43,String.valueOf(cliente.getCodigoEmpresa()));
			logger.debug("cliente.getCodigoEmpresa(): " + cliente.getCodigoEmpresa());
			cstmt.setString(44,cliente.getTipoPlanTarifario());
			logger.debug("cliente.getTipoPlanTarifario(): " + cliente.getTipoPlanTarifario());
			cstmt.setString(45,cliente.getCodigoPlanTarifario());
			logger.debug("cliente.getCodigoPlanTarifario(): " + cliente.getCodigoPlanTarifario());
			cstmt.setString(46,cliente.getCodigoCargoBasico());
			logger.debug("cliente.getCodigoCargoBasico(): " + cliente.getCodigoCargoBasico());
			cstmt.setString(47,cliente.getNumeroOrdenServicio());
			logger.debug("cliente.getNumeroOrdenServicio(): " + cliente.getNumeroOrdenServicio());
			cstmt.setString(48,cliente.getNumeroCiclos());
			logger.debug("cliente.getNumeroCiclos(): " + cliente.getNumeroCiclos());
			cstmt.setString(49,cliente.getNumeroMinutos());
			logger.debug("cliente.getNumeroMinutos(): " + cliente.getNumeroMinutos());
			cstmt.setString(50,cliente.getCodigoIdioma());
			logger.debug("cliente.getCodigoIdioma(): " + cliente.getCodigoIdioma());
			cstmt.setString(51,cliente.getCodigoTipIdent2());
			logger.debug("cliente.getCodigoTipIdent2(): " + cliente.getCodigoTipIdent2());
			cstmt.setString(52,cliente.getNumIdent2());
			logger.debug("cliente.getNumIdent2(): " + cliente.getNumIdent2());
			cstmt.setString(53,cliente.getCodigoPlaza());
			logger.debug("cliente.getCodigoPlaza(): " + cliente.getCodigoPlaza());
			cstmt.setString(54,cliente.getDescripcionReferenciaDocumento());
			logger.debug("cliente.getDescripcionReferenciaDocumento(): " + cliente.getDescripcionReferenciaDocumento());
			cstmt.setString(55,cliente.getCodigoLimiteConsumo());
			logger.debug("cliente.getCodigoLimiteConsumo(): " + cliente.getCodigoLimiteConsumo());
			cstmt.setString(56,cliente.getCodigoSubCategoria());
			logger.debug("cliente.getCodigoSubCategoria(): " + cliente.getCodigoSubCategoria());
			cstmt.registerOutParameter(57, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(58, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(59, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:setModificacionCliente:execute");
			cstmt.execute();
			logger.debug("Fin:setModificacionCliente:execute");
			
			codError = cstmt.getInt(57);
			msgError = cstmt.getString(58);
			numEvento = cstmt.getInt(59);
			
			logger.debug("codError ["+codError+"]" );
			logger.debug("msgError ["+msgError+"]" );
			logger.debug("numEvento ["+numEvento+"]" );
			
			if (codError !=0){
				logger.error("Ocurrió un error al insertar registro de modificación del cliente");
				throw new GeneralException(
						"Ocurrió un error al insertar registro de modificación del cliente", String
								.valueOf(codError), numEvento, msgError);
			}
		}catch(GeneralException e ){
			throw (e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al insertar registro de modificación del cliente",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al insertar cliente", String
							.valueOf(codError), numEvento, msgError);
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
		logger.debug("Fin:setModificacionCliente()");
	}//fin setModificacionCliente
	
	
	/**
	 * Inserta registro en tabla GA_CLIENTE_PCOM
	 * @param cliente
	 * @return N/A
	 * @throws GeneralException
	 */
	public void setClientePlanComercial(ClienteComDTO cliente) 
	throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:setClientePlanComercial");
			
			//INI-01 (AL) String call = getSQLDatosCliente("VE_alta_cliente_PG","VE_insPlanComCliente_PR",6);
			String call = getSQLDatosCliente("VE_alta_cliente_Quiosco_PG","VE_insPlanComCliente_PR",6);
			logger.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,cliente.getCodigoCliente());
			logger.debug("cliente.getCodigoCliente(): " + cliente.getCodigoCliente());
			cstmt.setString(2,cliente.getCodigoPlanComercial());
			logger.debug("cliente.getCodigoPlanComercial(): " + cliente.getCodigoPlanComercial());
			cstmt.setString(3,cliente.getNombreUsuarOra());
			logger.debug("cliente.getNombreUsuarOra(): " + cliente.getNombreUsuarOra());
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:setClientePlanComercial:execute");
			cstmt.execute();
			logger.debug("Fin:setClientePlanComercial:execute");
			
			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);
			
			logger.debug("codError ["+codError+"]" );
			logger.debug("msgError ["+msgError+"]" );
			logger.debug("numEvento ["+numEvento+"]" );
			
			if (codError !=0){
				logger.error("Ocurrió un error al insertar registro en plan comercial");
				throw new GeneralException(
						"Ocurrió un error al insertar registroen plan comercial", String
								.valueOf(codError), numEvento, msgError);
			}
		}catch(GeneralException e ){
			throw (e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al insertar registroen plan comercial",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al insertar registro en plan comercial", String
							.valueOf(codError), numEvento, msgError);
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
		logger.debug("Fin:setClientePlanComercial()");
	}//fin setClientePlanComercial
	
	
	/**
	 * Inserta registro en tabla GA_RESPCLIENTES (Resonsables del cliente)
	 * @param cliente
	 * @return N/A
	 * @throws GeneralException
	 */
	public void setResponsablesDelCliente(ClienteComDTO cliente) 
	throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			
			
		for (int i=0;i<cliente.getRepresentanteLegalComDTO().length;i++){
				
			logger.debug("Inicio:setResponsablesDelCliente");
			//INI-01 (AL) String call = getSQLDatosCliente("VE_alta_cliente_PG","VE_insRespCliente_PR",8);
			String call = getSQLDatosCliente("VE_alta_cliente_Quiosco_PG","VE_insRespCliente_PR",8);
			logger.debug("sql[" + call + "]");			
			cstmt = conn.prepareCall(call);			
			cstmt.setString(1,cliente.getCodigoCliente());
			logger.debug("cliente.getCodigoCliente(): " + cliente.getCodigoCliente());			
			cstmt.setString(2, String.valueOf(cliente.getRepresentanteLegalComDTO()[i].getNumeroOrdenRepresentanteLegal()));			
			logger.debug("cliente.getNumeroOrdenRepresentante(): " + cliente.getRepresentanteLegalComDTO()[i].getNumeroOrdenRepresentanteLegal());						
			cstmt.setString(3,cliente.getRepresentanteLegalComDTO()[i].getCodigoTipoIdentificacion());								
			logger.debug(".getCodigoTipoIdentificacion(): " + cliente.getRepresentanteLegalComDTO()[i].getCodigoTipoIdentificacion());			
			cstmt.setString(4,cliente.getRepresentanteLegalComDTO()[i].getNumeroTipoIdentificacion());			
			logger.debug(".getNumeroTipoIdentificacion(): " + cliente.getRepresentanteLegalComDTO()[i].getNumeroTipoIdentificacion());						
			cstmt.setString(5,cliente.getRepresentanteLegalComDTO()[i].getNombre());
			logger.debug(".getNombre(): " + cliente.getRepresentanteLegalComDTO()[i].getNombre());						
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:setResponsablesDelCliente:execute");
			cstmt.execute();
			logger.debug("Fin:setResponsablesDelCliente:execute");
			
			codError = cstmt.getInt(6);
			msgError = cstmt.getString(7);
			numEvento = cstmt.getInt(8);
			
			logger.debug("codError ["+codError+"]" );
			logger.debug("msgError ["+msgError+"]" );
			logger.debug("numEvento ["+numEvento+"]" );
			
			
			if (codError !=0){
				logger.error("Ocurrió un error al insertar representante");
				throw new GeneralException(
						"Ocurrió un error al insertar representante", String
								.valueOf(codError), numEvento, msgError);
			}			
		}
			
		}catch(GeneralException e ){
			throw (e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al insertar representante",e);
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
		logger.debug("Fin:setResponsablesDelCliente()");
	}//fin setResponsablesDelCliente
	
	/**
	 * Inserta empresa
	 * @param cliente
	 * @return N/A
	 * @throws GeneralException
	 */
	public void insEmpresa(ClienteComDTO cliente) 
	throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:insEmpresa");
			
			//INI-01 (AL) String call = getSQLDatosCliente("VE_alta_cliente_PG","VE_insEmpresa_PR",10);
			String call = getSQLDatosCliente("VE_alta_cliente_Quiosco_PG","VE_insEmpresa_PR",10);
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,cliente.getDescripcionEmpresa());
			logger.debug("cliente.getDescripcionEmpresa(): " + cliente.getDescripcionEmpresa());
			cstmt.setInt(2,cliente.getCodigoProducto());
			logger.debug("cliente.getCodigoProducto(): " + cliente.getCodigoProducto());
			cstmt.setString(3,cliente.getCodigoPlanTarifario());
			logger.debug("cliente.getPlanTarifario(): " + cliente.getCodigoPlanTarifario());
			cstmt.setInt(4,Integer.parseInt(cliente.getCodigoCicloFacturacion()));
			logger.debug("cliente.getCodigoCiclo(): " + cliente.getCodigoCicloFacturacion());
			cstmt.setLong(5,Long.parseLong(cliente.getCodigoCliente()));
			logger.debug("cliente.getCodigoCliente(): " + cliente.getCodigoCliente());
			cstmt.setInt(6,cliente.getNumeroAbonados());
			logger.debug("cliente.getNumeroAbonados(): " + cliente.getNumeroAbonados());
			cstmt.setString(7,cliente.getNombreUsuarOra());
			logger.debug("cliente.getUsuario(): " + cliente.getNombreUsuarOra());
			
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:insEmpresa:execute");
			cstmt.execute();
			logger.debug("Fin:insEmpresa:execute");
			
			codError = cstmt.getInt(8);
			msgError = cstmt.getString(9);
			numEvento = cstmt.getInt(10);
			
			logger.debug("codError ["+codError+"]" );
			logger.debug("msgError ["+msgError+"]" );
			logger.debug("numEvento ["+numEvento+"]" );

			if (codError !=0){
				logger.error("Ocurrió un error al insertar empresa");
				throw new GeneralException(
						"Ocurrió un error al insertar empresa", String
								.valueOf(codError), numEvento, msgError);
			}
		}catch(GeneralException e ){
			throw (e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al insertar empresa",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al insertar empresa", String
							.valueOf(codError), numEvento, msgError);
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
		logger.debug("Fin:insEmpresa()");
	}//fin insEmpresa

	/**
	 * Inserta secuencia de despacho
	 * @param cliente
	 * @return N/A
	 * @throws GeneralException
	 */
	public void insSecDespachoCliente(ClienteComDTO  cliente) 
	throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:insSecDespachoCliente");
			
			//INI-01 (AL) String call = getSQLDatosCliente("VE_alta_cliente_PG","VE_insSecDespachoCliente_PR",5);
			String call = getSQLDatosCliente("VE_alta_cliente_Quiosco_PG","VE_insSecDespachoCliente_PR",5);
			logger.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,cliente.getCodigoCliente());
			cstmt.setString(2,cliente.getNombreUsuarOra());

			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:insSecDespachoCliente:execute");
			cstmt.execute();
			logger.debug("Fin:insSecDespachoCliente:execute");
			
			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			logger.debug("codError ["+codError+"]" );
			logger.debug("msgError ["+msgError+"]" );
			logger.debug("numEvento ["+numEvento+"]" );

			if (codError !=0){
				logger.error("Ocurrió un error al insertar secuencia despacho del cliente");
				throw new GeneralException(
						"Ocurrió un error al insertar secuencia despacho del cliente", String
								.valueOf(codError), numEvento, msgError);
			}
		}catch(GeneralException e ){
			throw (e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al insertar secuencia despacho",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al insertar secuencia despacho del cliente", String
							.valueOf(codError), numEvento, msgError);
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
		logger.debug("Fin:insSecDespachoCliente()");
	}//fin insSecDespachoCliente

	/**
	 * Inserta categoria tributaria del cliente
	 * @param cliente
	 * @return N/A
	 * @throws GeneralException
	 */
	public void insCategTributCliente(ClienteComDTO cliente) 
	throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:insCategTributCliente");
			
			//INI-01 (AL) String call = getSQLDatosCliente("VE_alta_cliente_PG","VE_insCategoriaTributaria_PR",5);
			String call = getSQLDatosCliente("VE_alta_cliente_Quiosco_PG","VE_insCategoriaTributaria_PR",5);
			logger.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,cliente.getCodigoCliente());
			logger.debug("getCodigoCliente() ["+cliente.getCodigoCliente()+"]");
			cstmt.setString(2,cliente.getCategoriaTributaria());
			logger.debug("getCategoriaTributaria() ["+cliente.getCategoriaTributaria()+"]");
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:insCategTributCliente:execute");
			cstmt.execute();
			logger.debug("Fin:insCategTributCliente:execute");
			
			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			logger.debug("codError ["+codError+"]" );
			logger.debug("msgError ["+msgError+"]" );
			logger.debug("numEvento ["+numEvento+"]" );

			if (codError !=0){
				logger.error("Ocurrió un error al insertar categoria tributaria del cliente");
				throw new GeneralException(
						"Ocurrió un error al insertar categoria tributaria del cliente", String
								.valueOf(codError), numEvento, msgError);
			}
		}catch(GeneralException e ){
			throw (e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al insertar categoria tributaria del cliente",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al insertar categoria tributaria del cliente", String
							.valueOf(codError), numEvento, msgError);
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
		logger.debug("Fin:insCategTributCliente()");
	}//fin insCategTributCliente

	/**
	 * Inserta categoria impositiva del cliente
	 * @param cliente
	 * @return N/A
	 * @throws GeneralException
	 */
	public void insCategImposCliente(ClienteComDTO cliente) 
	throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:insCategImposCliente");
			
			//INI-01 (AL) String call = getSQLDatosCliente("VE_alta_cliente_PG","VE_insCatImposCliente_PR",5);
			String call = getSQLDatosCliente("VE_alta_cliente_Quiosco_PG","VE_insCatImposCliente_PR",5);
			logger.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,cliente.getCodigoCliente());
			cstmt.setString(2,String.valueOf(cliente.getCodigoCategImpos()));

			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:insCategImposCliente:execute");
			cstmt.execute();
			logger.debug("Fin:insCategImposCliente:execute");
			
			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			logger.debug("codError ["+codError+"]" );
			logger.debug("msgError ["+msgError+"]" );
			logger.debug("numEvento ["+numEvento+"]" );

			if (codError !=0){
				logger.error("Ocurrió un error al insertar categoria impositiva del cliente");
				throw new GeneralException(
						"Ocurrió un error al insertar categoria impositiva del cliente", String
								.valueOf(codError), numEvento, msgError);
			}
		}catch(GeneralException e ){
			throw (e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al insertar categoria impositiva del cliente",e);
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
		logger.debug("Fin:insCategImposCliente()");
	}//fin insCategImposCliente

	/**
	 * Inserta direccion del cliente
	 * @param cliente
	 * @return N/A
	 * @throws GeneralException
	 */
	public void insDireccionCliente(ClienteComDTO cliente) 
	throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:insDireccionCliente");
			
			String call = getSQLDatosCliente("VE_alta_cliente_PG","VE_insDireccionCliente_PR",6);
			logger.debug("sql[" + call + "]");
			
			if ( cliente.getDirecciones()!=null ){
				for (int i=0; i<cliente.getDirecciones().length; i++){
					if (cliente.getDirecciones()[i]!=null ){
						cstmt = conn.prepareCall(call);
						cstmt.setString(1,cliente.getCodigoCliente());
						cstmt.setString(2,String.valueOf(cliente.getDirecciones()[i].getTipoDireccion()));
						cstmt.setString(3,String.valueOf(cliente.getDirecciones()[i].getCodigo()));
						cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
						cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
						
						logger.debug("Inicio:insDireccionCliente:execute");
						cstmt.execute();
						logger.debug("Fin:insDireccionCliente:execute");
						
						codError = cstmt.getInt(4);
						msgError = cstmt.getString(5);
						numEvento = cstmt.getInt(6);
						
						logger.debug("codError ["+codError+"]" );
						logger.debug("msgError ["+msgError+"]" );
						logger.debug("numEvento ["+numEvento+"]" );
			
						if (codError !=0){
							logger.error("Ocurrió un error al insertar direccion del cliente");
							throw new GeneralException(
									"Ocurrió un error al insertar direccion del cliente", String
											.valueOf(codError), numEvento, msgError);
						}
					}	
				}//fin for
			}
		}catch(GeneralException e ){
			throw (e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al insertar direccion del cliente",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al insertar direccion del cliente", String
							.valueOf(codError), numEvento, msgError);
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
		logger.debug("Fin:insDireccionCliente()");
	}//fin insDireccionCliente

	/**
	 * Inserta relacion vendedor cliente
	 * @param cliente
	 * @return N/A
	 * @throws GeneralException
	 */
	public void insVendCliente(ClienteDTO cliente) 
	throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:insVendCliente");
			
			//INI-01 (AL) String call = getSQLDatosCliente("VE_alta_cliente_PG","VE_insVendCliente_PR",6);
			String call = getSQLDatosCliente("VE_alta_cliente_Quiosco_PG","VE_insVendCliente_PR",6);
			logger.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,String.valueOf(cliente.getCodigoVendedor()));
			cstmt.setString(2,cliente.getCodigoCliente());
			cstmt.setString(3,cliente.getNombreUsuarOra());

			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:insVendCliente:execute");
			cstmt.execute();
			logger.debug("Fin:insVendCliente:execute");
			
			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);
			
			logger.debug("codError ["+codError+"]" );
			logger.debug("msgError ["+msgError+"]" );
			logger.debug("numEvento ["+numEvento+"]" );

			if (codError !=0){
				logger.error("Ocurrió un error al insertar relacion vendedor cliente");
				throw new GeneralException(
						"Ocurrió un error al insertar relacion vendedor cliente", String
								.valueOf(codError), numEvento, msgError);
			}
		}catch(GeneralException e ){
			throw (e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al insertar relacion vendedor cliente",e);
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
		logger.debug("Fin:insVendCliente()");
	}//fin insVendCliente
	
	/**
	 * Actualiza categoria de los clientes por la categoria de la cuenta
	 * @param cliente
	 * @return N/A
	 * @throws GeneralException
	 */
	public void actualizaCategoriasClientes(CuentaComDTO cuenta) 
	throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:actualizaCategoriasClientes");
			
			//INI-01 (AL) String call = getSQLDatosCliente("VE_alta_cliente_PG","VE_updCategClienteCta_PR",5);
			String call = getSQLDatosCliente("VE_alta_cliente_Quiosco_PG","VE_updCategClienteCta_PR",5);
			logger.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,cuenta.getCodigoCuenta());
			cstmt.setString(2,String.valueOf(cuenta.getClienteComDTO().getCodigoCategoria()));

			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:actualizaCategoriasClientes:execute");
			cstmt.execute();
			logger.debug("Fin:actualizaCategoriasClientes:execute");
			
			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			logger.debug("codError ["+codError+"]" );
			logger.debug("msgError ["+msgError+"]" );
			logger.debug("numEvento ["+numEvento+"]" );

			if (codError !=0){
				logger.error("Ocurrió un error al actualizar categorias de los clientes");
				throw new GeneralException(
						"Ocurrió un error al actualizar categorias de los clientes", String
								.valueOf(codError), numEvento, msgError);
			}
		}catch(GeneralException e ){
			throw (e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al actualizar categorias de los clientes",e);
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
		logger.debug("Fin:actualizaCategoriasClientes()");
	}//fin actualizaCategoriasClientes

	/**
	 * Actualiza categoria de los clientes por la categoria de la cuenta
	 * @param cliente
	 * @return N/A
	 * @throws GeneralException
	 */
	public void actualizaCodigoUsoClientes(CuentaComDTO cuenta) 
	throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:actualizaCodigoUsoClientes");
			
			//INI-01 (AL) String call = getSQLDatosCliente("VE_alta_cliente_PG","VE_updCodigoUsoCliente_PR",5);
			String call = getSQLDatosCliente("VE_alta_cliente_Quiosco_PG","VE_updCodigoUsoCliente_PR",5);
			logger.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,cuenta.getCodigoCuenta());
			cstmt.setString(2,cuenta.getClienteComDTO().getCodigoUso());

			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:actualizaCodigoUsoClientes:execute");
			cstmt.execute();
			logger.debug("Fin:actualizaCodigoUsoClientes:execute");
			
			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			logger.debug("codError ["+codError+"]" );
			logger.debug("msgError ["+msgError+"]" );
			logger.debug("numEvento ["+numEvento+"]" );

			if (codError !=0){
				logger.error("Ocurrió un error al actualizar codigo uso de los clientes");
				throw new GeneralException(
						"Ocurrió un error al actualizar codigo uso de los clientes", String
								.valueOf(codError), numEvento, msgError);
			}
		}catch(GeneralException e ){
			throw (e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al actualizar codigo uso de los clientes",e);
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
		logger.debug("Fin:actualizaCodigoUsoClientes()");
	}//fin actualizaCodigoUsoClientes
	
	/**
	 * Actualiza subcategoria impositiva del cliente por la subcategoria de la cuenta}
	 * en base al resultado del analisis de categoria de la cuenta realizado en la
	 * alta del cliente.
	 * @param cliente
	 * @return N/A
	 * @throws GeneralException
	 */
	public void actualizaSubCategoriaImpositiva(ClienteComDTO cliente) 
	throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:actualizaSubCategoriaImpositiva");
			
			//INI-01 (AL) String call = getSQLDatosCliente("VE_alta_cliente_PG","VE_updSubCategCliente_PR",5);
			String call = getSQLDatosCliente("VE_alta_cliente_Quiosco_PG","VE_updSubCategCliente_PR",5);
			logger.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,cliente.getCodigoCliente());
			cstmt.setString(2,String.valueOf(cliente.getCodigoSubCategoria()));

			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:actualizaSubCategoriaImpositiva:execute");
			cstmt.execute();
			logger.debug("Fin:actualizaSubCategoriaImpositiva:execute");
			
			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			logger.debug("codError ["+codError+"]" );
			logger.debug("msgError ["+msgError+"]" );
			logger.debug("numEvento ["+numEvento+"]" );

			if (codError !=0){
				logger.error("Ocurrió un error al actualizar la subcategoria impositva del cliente");
				throw new GeneralException(
						"Ocurrió un error al actualizar la subcategoria impositva del cliente", String
								.valueOf(codError), numEvento, msgError);
			}
		}catch(GeneralException e ){
			throw (e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al actualizar la subcategoria impositva del cliente",e);
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
		logger.debug("Fin:actualizaSubCategoriaImpositiva()");
	}//fin actualizaSubCategoriaImpositiva
		
	/**
	 * Consulta datos del cliente tipo empresa
	 * @param clienteDTO
	 * @return resultado
	 * @throws GeneralException
	 */
	public ClienteDTO getDatosEmpresa(ClienteDTO clienteDTO) throws GeneralException{
		logger.debug("getDatosEmpresa:inicio");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		logger.debug("Coneccion obtenida OK");
		CallableStatement cstmt = null;
		ClienteDTO resultado = null;
		try {
			//INI-01 (AL) String call = getSQLDatosCliente("VE_servicios_venta_PG","VE_consulta_cliente_PR",22);
			String call = getSQLDatosCliente("VE_servicios_venta_Quiosco_PG","VE_consulta_cliente_PR",22);
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1,Long.parseLong(clienteDTO.getCodigoCliente()));
			cstmt.registerOutParameter(2,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);
			cstmt.execute();
			
			codError = cstmt.getInt(3);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(4);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(5);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError !=0){
				logger.error("Ocurrió un error al consultar el cliente tipo empresa");
				throw new GeneralException(
						"Ocurrió un error al consultar el cliente tipo empresa", String
								.valueOf(codError), numEvento, msgError);
			}
			
				resultado = clienteDTO;
				resultado.setNumeroAbonados(cstmt.getInt(2));	
			
				
		}catch(GeneralException e ){
			throw (e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al consultar el cliente tipo empresa",e);
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
		logger.debug("getDatosEmpresa():end");
		return resultado;
	}

	/**
	 * Obtine plaza del cliente
	 * @param clienteDTO
	 * @return resultado
	 * @throws GeneralException
	 */	
	public ClienteDTO ObtienePlazaCliente(ClienteDTO cliente) 
	throws GeneralException{
		logger.debug("ObtienePlazaCliente:inicio");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		logger.debug("Coneccion obtenida OK");
		CallableStatement cstmt = null;
		try {
			//INI-01 (AL) String call = getSQLDatosCliente("VE_intermediario_PG","VE_ObtienePlazaCliente_PR",5);
			String call = getSQLDatosCliente("VE_intermediario_Quiosco_PG","VE_ObtienePlazaCliente_PR",5);
			logger.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			/*-- entrada --*/
			cstmt.setString(1,cliente.getCodigoCliente());
			/*-- salida --*/
			cstmt.registerOutParameter(2,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);
			
			logger.debug("ObtienePlazaCliente:Execute Antes");
			cstmt.execute();
			logger.debug("ObtienePlazaCliente:Execute Despues");
			
			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			logger.debug("codError ["+codError+"]" );
			logger.debug("msgError ["+msgError+"]" );
			logger.debug("numEvento ["+numEvento+"]" );

			if (codError != 0) {
				logger.error("Ocurrió un error al obtener codigo de la plaza del cliente");
				throw new GeneralException(
						"Ocurrió un error al obtener codigo de la plaza del cliente", String
								.valueOf(codError), numEvento, msgError);
			}
			else
				cliente.setCodigoPlaza(cstmt.getString(2));

			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		}catch(GeneralException e ){
			throw (e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener codigo de la plaza del cliente",e);
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
		logger.debug("ObtienePlazaCliente():end");
		return cliente;
	}//fin ObtienePlazaCliente
	
	/**
	 * @author Héctor Hermosilla
	 * 
	 * Obtiene numero de abonados del cliente
	 * @param clienteDTO
	 * @return clienteDTO
	 * @throws GeneralException
	 */	
	public ClienteDTO getNumeroAbonadosporCliente(ClienteDTO clienteDTO) 
	throws GeneralException{
		logger.debug("getNumeroAbonadosporCliente:inicio");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		logger.debug("Coneccion obtenida OK");
		CallableStatement cstmt = null;
		try {
			//INI-01 (AL) String call = getSQLDatosCliente("Ve_Servicios_Venta_Pg","VE_num_abonados_cliente_PR",6);
			String call = getSQLDatosCliente("Ve_Servicios_Venta_Quiosco_Pg","VE_num_abonados_cliente_PR",6);
			logger.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			/*-- entrada --*/
			cstmt.setString(1,clienteDTO.getCodigoCliente());
			cstmt.setString(2,clienteDTO.getCodigoPlanTarifario());
			/*-- salida --*/
			cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6,java.sql.Types.NUMERIC);
			
			logger.debug("getNumeroAbonadosporCliente:Execute Antes");
			cstmt.execute();
			logger.debug("getNumeroAbonadosporCliente:Execute Despues");
			
			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);
			
			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");
			
			if (codError !=0){
				logger.error("Ocurrió un error al obtener numero de abonados por cliente");
				throw new GeneralException(
						"Ocurrió un error al obtener numero de abonados por cliente", String
								.valueOf(codError), numEvento, msgError);
			}

			if (codError == 0) 
				clienteDTO.setNumeroAbonados(cstmt.getInt(3));

			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		}catch(GeneralException e ){
			throw (e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener numero de abonados por cliente",e);
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
		logger.debug("getNumeroAbonadosporCliente():end");
		return clienteDTO;
	}//fin getNumeroAbonadosporCliente	
	
	/**
	 * Obtiene listado de Tarjetas.
	 * @return WsListTarjetaOutDTO
	 * @throws GeneralException
	 */
	public WsListTarjetaOutDTO getListadoTarjetas() 
	throws GeneralException{
		//RSIS19
		WsListTarjetaOutDTO resultado = null;
		WsTarjetaOutDTO[] tarjetas = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:getListadoTarjetas");
			resultado = new WsListTarjetaOutDTO();
			//INI-01 (AL) String call = getSQLDatosCliente("VE_alta_cliente_PG","VE_getListTarjetas_PR",4);
			String call = getSQLDatosCliente("VE_alta_cliente_Quiosco_PG","VE_getListTarjetas_PR",4);
			logger.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			cstmt.registerOutParameter(1,OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getListadoTarjetas:execute");
			cstmt.execute();
			logger.debug("Fin:getListadoTarjetas:execute");
			
			codError  = cstmt.getInt(2);
			msgError  = cstmt.getString(3);
			numEvento = cstmt.getInt(4);
			
			logger.debug("codError ["+codError+"]" );
			logger.debug("msgError ["+msgError+"]" );
			logger.debug("numEvento ["+numEvento+"]" );

			if (codError != 0) {
				logger.error("Ocurrió un error al obtener listado de tarjetas");
				resultado.setMensajseError(msgError);
				resultado.setCodError(""+codError);
				throw new GeneralException(
						  "Ocurrió un error al obtener listado de tarjetas", String
								.valueOf(codError), numEvento, msgError);
			}else{
				logger.debug("Recuperando listado de tarjetas");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(1);
				while (rs.next()) {
					WsTarjetaOutDTO tarjetaRS = new WsTarjetaOutDTO();
					tarjetaRS.setCodTarjeta(rs.getString(1));
					tarjetaRS.setDesTarjeta(rs.getString(2));
					lista.add(tarjetaRS);
				}
				rs.close();
				tarjetas =(WsTarjetaOutDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), WsTarjetaOutDTO.class);
				resultado.setWsTarjetaArrOutDTO(tarjetas);
				logger.debug("listado de tarjetas");
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		}catch(GeneralException e ){
			throw (e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener listado de tarjetas",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error [" + codError + "]");
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
		logger.debug("Fin:getListadoTarjetas()");
		return resultado;
	}//fin getListadoTarjetas	
	
	/**
	 * Obtiene listado de modalidad de pago.
	 * @param cliente
	 * @return WsListModalidadPagoOutDTO
	 * @throws GeneralException
	 */
	public WsListModalidadPagoOutDTO getListadoModalidadPago() 
	throws GeneralException{
		//RSIS17
		WsListModalidadPagoOutDTO resultado = null;
		WsModalidadPagoOutDTO[] modalidadesPago = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:getListadoModalidadPago");
			resultado = new WsListModalidadPagoOutDTO();
			//INI-01 (AL) String call = getSQLDatosCliente("VE_alta_cliente_PG","VE_getListModalidadPago_PR",4);
			String call = getSQLDatosCliente("VE_alta_cliente_Quiosco_PG","VE_getListModalidadPago_PR",4);
			logger.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			//cstmt.setInt(1,wsModalidadPagoInDTO.getIndManual());
			cstmt.registerOutParameter(1,OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getListadoModalidadPago:execute");
			cstmt.execute();
			logger.debug("Fin:getListadoModalidadPago:execute");
			
			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);
			
			logger.debug("codError ["+codError+"]" );
			logger.debug("msgError ["+msgError+"]" );
			logger.debug("numEvento ["+numEvento+"]" );

			if (codError != 0) {
				logger.error("Ocurrió un error al obtener listado de modalidad de pago");
				resultado.setMensajseError(msgError);
				resultado.setCodError(""+codError);
				throw new GeneralException(
						  "Ocurrió un error al obtener listado de modalidad de pago", String
								.valueOf(codError), numEvento, msgError);
			}else{
				logger.debug("Recuperando listado modalidad de pago");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(1);
				while (rs.next()) {
					WsModalidadPagoOutDTO wsModalidadPagoOutRS = new WsModalidadPagoOutDTO();
					wsModalidadPagoOutRS.setCodSisPago(rs.getInt(1));
					wsModalidadPagoOutRS.setDesSisPago(rs.getString(2));
					lista.add(wsModalidadPagoOutRS);
				}
				rs.close();
				modalidadesPago =(WsModalidadPagoOutDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), WsModalidadPagoOutDTO.class);
				resultado.setWsModalidadPagoArrOutDTO(modalidadesPago);
				
				logger.debug("listado de modalidad de pago");
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		}catch(GeneralException e ){
			throw (e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener listado de modalidad de pago",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error [" + codError + "]");
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
		logger.debug("Fin:getListadoModalidadPago()");
		return resultado;
	}//fin getListadoModalidadPago	
	
	
	/**
	 * Obtiene listado de Bancos PAC.
	 * @param cliente
	 * @return WsListBancoOutDTO
	 * @throws GeneralException
	 */
	public WsListBancoOutDTO getListadoBancosPAC(WsBancoInDTO wsBancoInDTO) 
	throws GeneralException{
	   //RSIS18		
		WsListBancoOutDTO resultado = null;
		WsBancoOutDTO[] bancos = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:getListadoBancosPAC");
			resultado = new WsListBancoOutDTO();
			//INI-01 (AL) String call = getSQLDatosCliente("VE_alta_cliente_PG","VE_getListBancosPAC_PR",5);
			String call = getSQLDatosCliente("VE_alta_cliente_Quiosco_PG","VE_getListBancosPAC_PR",5);
			logger.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			logger.debug("wsBancoInDTO.getIndPAC ["+wsBancoInDTO.getIndPAC()+"]");
			cstmt.setInt(1,wsBancoInDTO.getIndPAC());
			cstmt.registerOutParameter(2,OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getListadoBancosPAC:execute");
			cstmt.execute();
			logger.debug("Fin:getListadoBancosPAC:execute");
			
			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			logger.debug("codError ["+codError+"]" );
			logger.debug("msgError ["+msgError+"]" );
			logger.debug("numEvento ["+numEvento+"]" );

			if (codError != 0) {
				logger.error("Ocurrió un error al obtener listado de Bancos PAC");
				resultado.setMensajseError(msgError);
				resultado.setCodError(""+codError);
				throw new GeneralException(
						  "Ocurrió un error al obtener listado de Bancos PAC", String
								.valueOf(codError), numEvento, msgError);
			}else{
				logger.debug("Recuperando listado de Bancos PAC");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(2);
				while (rs.next()) {
					WsBancoOutDTO bancoRS = new WsBancoOutDTO();
					bancoRS.setCodBanco(rs.getString(1));
					bancoRS.setDesBanco(rs.getString(2));
					lista.add(bancoRS);
				}
				rs.close();
				bancos =(WsBancoOutDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), WsBancoOutDTO.class);
				resultado.setWsBancoArrOutDTO(bancos);
				logger.debug("listado de Bancos PAC");
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		}catch(GeneralException e ){
			throw (e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener listado de Bancos PAC",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error [" + codError + "]");
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
		logger.debug("Fin:getListadoBancosPAC()");
		return resultado;
	}//fin getListadoBancosPAC	
	
	/**
	 * Obtiene listado de Cuotas.
	 * @return WsListCuotaOutDTO
	 * @throws GeneralException
	 */
	public WsListCuotaOutDTO getListadoCuotas() 
	throws GeneralException{
		//RSIS25
		WsListCuotaOutDTO resultado = null;
		WsCuotaOutDTO[] cuotas = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:getListadoCuotas");
			resultado = new WsListCuotaOutDTO();
			String call = getSQLDatosCliente("GE_cons_catalogo_portab_PG","GE_rec_cuotas_PR",4);
			logger.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			cstmt.registerOutParameter(1,OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getListadoCuotas:execute");
			cstmt.execute();
			logger.debug("Fin:getListadoCuotas:execute");
			
			codError  = cstmt.getInt(2);
			msgError  = cstmt.getString(3);
			numEvento = cstmt.getInt(4);

			logger.debug("codError ["+codError+"]" );
			logger.debug("msgError ["+msgError+"]" );
			logger.debug("numEvento ["+numEvento+"]" );
			
			if (codError != 0) {
				logger.error("Ocurrió un error al obtener listado de cuotas");
				resultado.setMensajseError(msgError);
				resultado.setCodError(""+codError);
				throw new GeneralException(
						  "Ocurrió un error al obtener listado de cuotas", String
								.valueOf(codError), numEvento, msgError);
			}else{
				logger.debug("Recuperando listado de cuotas");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(1);
				while (rs.next()) {
					WsCuotaOutDTO cuotaRS = new WsCuotaOutDTO();
					cuotaRS.setCodCuota(rs.getString(1));
					cuotaRS.setDesCuota(rs.getString(2));
					lista.add(cuotaRS);
				}
				rs.close();
				cuotas =(WsCuotaOutDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), WsCuotaOutDTO.class);
				resultado.setWsCuotaArrOutDTO(cuotas);
				logger.debug("listado de cuotas");
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		}catch(GeneralException e ){
			throw (e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener listado de cuotas",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error [" + codError + "]");
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
		logger.debug("Fin:getListadoCuotas()");
		return resultado;
	}//fin getListadoCuotas
	
	private String getSQLgetListVigenciasContratos(){
		StringBuffer call=new StringBuffer();
		call.append("BEGIN ");
		call.append(" GE_CONS_CATALOGO_PORTAB_PG.GE_REC_VIGENCIAS_CONTRATOS_PR ( ?, ?, ?, ? ); ");
		call.append("END;");
		return call.toString();
	}
	
	public WsContratoOutDTO[] getListVigenciasContratos() throws GeneralException{
		Logger logger =Logger.getLogger(this.getClass());
		WsContratoOutDTO[] retValue=null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try{
			logger.debug("Inicio DAO:  getListVigenciasContratos");
			String call=getSQLgetListVigenciasContratos();
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.registerOutParameter(1,OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			logger.debug("Inicio:getListVigenciasContratos:execute");
			cstmt.execute();
			logger.debug("Fin:getListVigenciasContratos:execute");

			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);
			
			logger.debug("codError ["+codError+"]" );
			logger.debug("msgError ["+msgError+"]" );
			logger.debug("numEvento ["+numEvento+"]" );
			
			if (codError != 0) {
				logger.error("Ocurrió un error al recuperar getListVigenciasContratos");
				throw new GeneralException(
						"Ocurrió un error al recuperar getListVigenciasContratos", String
								.valueOf(codError), numEvento, msgError);
			}else{
				logger.debug("Recuperando getListVigenciasContratos");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(1);
				while (rs.next()) {
					WsContratoOutDTO contratoDTO = new WsContratoOutDTO();
					contratoDTO.setCodigoProducto(rs.getInt(1));
					contratoDTO.setCodigoTipoContrato(rs.getString(2));
					contratoDTO.setDescripcionTipoContrato(rs.getString(3));
					
					
					lista.add(contratoDTO);
				}
				rs.close();
				retValue =(WsContratoOutDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), WsContratoOutDTO.class);
				
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		}catch(GeneralException e ){
			throw (e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al recuperar getListVigenciasContratos",e);
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
		logger.debug("Inicio DAO:  getListVigenciasContratos");
		return retValue;
	}
	
	private String getSQLgetListModalidadVenta(){
		StringBuffer call=new StringBuffer();
		call.append("BEGIN ");
		call.append(" GE_CONS_CATALOGO_PORTAB_PG.GE_REC_MODALIDAD_VENTAS_PR ( ?, ?, ?, ? );");
		call.append("END;");
		return call.toString();
	}
	
	public GeModVentaDTO[] getListModalidadVenta() throws GeneralException{
		Logger logger =Logger.getLogger(this.getClass());
		GeModVentaDTO[] retValue=null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try{
			logger.debug("Inicio DAO:  getListModalidadVenta");
			String call=getSQLgetListModalidadVenta();
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.registerOutParameter(1,OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			logger.debug("Inicio:getListModalidadVenta:execute");
			cstmt.execute();
			logger.debug("Fin:getListModalidadVenta:execute");

			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);
			
			logger.debug("codError ["+codError+"]" );
			logger.debug("msgError ["+msgError+"]" );
			logger.debug("numEvento ["+numEvento+"]" );
			
			if (codError != 0) {
				logger.error("Ocurrió un error al recuperar getListModalidadVenta");
				throw new GeneralException(
						"Ocurrió un error al recuperar getListModalidadVenta", String
								.valueOf(codError), numEvento, msgError);
			}else{
				logger.debug("Recuperando getListModalidadVenta");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(1);
				while (rs.next()) {
					GeModVentaDTO geModVentaDTO = new GeModVentaDTO();
					geModVentaDTO.setCodModVenta(rs.getInt(1));
					geModVentaDTO.setDesModVenta(rs.getString(2));
					lista.add(geModVentaDTO);
				}
				rs.close();
				retValue =(GeModVentaDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), GeModVentaDTO.class);
				
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		}catch(GeneralException e ){
			throw (e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al recuperar getListModalidadVenta",e);
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
		logger.debug("Inicio DAO:  getListModalidadVenta");
		return retValue;
	}

	/**
	 * Obtiene listado de clientes por número de identificación
	 * @param cliente
	 * @return WsListClienteIdentOutDTO
	 * @throws GeneralException
	 */
	public WsListClienteIdentOutDTO getListadoClientesXIdentificacion(WsClienteIdentInDTO cliente) throws GeneralException{
		//RSIS14
		Logger logger =Logger.getLogger(this.getClass());
		logger.debug("Inicio DAO:  getListadoClientesXIdentificacion");
		WsListClienteIdentOutDTO retValue=null;
		WsClienteIdentOutDTO[] clientes=null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		ArrayList listaErrores=new ArrayList();
		RetornoDTO errores = new RetornoDTO();
		try{
			retValue= new WsListClienteIdentOutDTO();
			String call = getSQLDatosCliente("GE_CONS_CATALOGO_PORTAB_PG","GE_REC_CLIENTE_X_IDENT_PR",6);
			logger.debug("sql[" + call + "]");
			logger.debug("Código Tipo Identificación : " + cliente.getCodigoTipoIdentificacion());
			logger.debug("Número Identificación : " + cliente.getNumeroIdentificacion());
			
			cstmt = conn.prepareCall(call);
			cstmt.setString(1, cliente.getCodigoTipoIdentificacion());
			cstmt.setString(2, cliente.getNumeroIdentificacion());
			cstmt.registerOutParameter(3,OracleTypes.CURSOR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			logger.debug("Inicio:getListadoClientesXIdentificacion:execute");
			cstmt.execute();
			logger.debug("Fin:getListadoClientesXIdentificacion:execute");

			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);
			
			logger.debug("codError ["+codError+"]" );
			logger.debug("msgError ["+msgError+"]" );
			logger.debug("numEvento ["+numEvento+"]" );
			
			if (codError != 0) {
				logger.error("Ocurrió un error al obtener listado de clientes por número de identificación");
				errores.setCodError(""+codError);
				errores.setMensajseError(msgError);
				listaErrores.add(errores);
				
				retValue.setErrores((RetornoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(listaErrores.toArray(), RetornoDTO.class));
				throw new GeneralException(
						"Ocurrió un error al obtener listado de clientes por número de identificación", String
								.valueOf(codError), numEvento, msgError);
			}else{
				logger.debug("Recuperando getListadoClientesXIdentificacion");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(3);
				while (rs.next()) {
					WsClienteIdentOutDTO clienteIdentDTO = new WsClienteIdentOutDTO();
					clienteIdentDTO.setCodCliente(rs.getLong(1));
					clienteIdentDTO.setCodCuenta(rs.getLong(2));
					clienteIdentDTO.setNomCliente(rs.getString(3));
					clienteIdentDTO.setNomApeClien1(rs.getString(4));
					clienteIdentDTO.setNomApeClien2(rs.getString(5));
					clienteIdentDTO.setFecAlta(rs.getString(6));
					clienteIdentDTO.setCodPlanTarif(rs.getString(7));
					clienteIdentDTO.setCodCategoria(rs.getInt(8));
					clienteIdentDTO.setUsoCliente(rs.getString(9));
					clienteIdentDTO.setIndDebito(rs.getString(10));
					clienteIdentDTO.setIndTipcuenta(rs.getString(11));
					clienteIdentDTO.setCodBanco(rs.getString(12));
					clienteIdentDTO.setDesBanco(rs.getString(13));
					clienteIdentDTO.setNumCtaCte(rs.getString(14));
					clienteIdentDTO.setCodTipotarjeta(rs.getString(15));
					clienteIdentDTO.setDesTipoTarjeta(rs.getString(16));
					clienteIdentDTO.setNumeroTarjeta(rs.getString(17));
					clienteIdentDTO.setFechaVencimientoTarjeta(rs.getDate(18));
										 																												 
					lista.add(clienteIdentDTO);
				}
				rs.close();
				clientes =(WsClienteIdentOutDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), WsClienteIdentOutDTO.class);
				retValue.setWsClienteIdentArrOutDTO(clientes);
				
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		}catch(GeneralException e ){
			throw (e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener listado de clientes por número de identificación",e);
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
		logger.debug("Inicio DAO:  getListadoClientesXIdentificacion");
		return retValue;
	}
	
	private String getSQLgetAbonadosActivosCliente(){
		StringBuffer call = new StringBuffer();
			 call.append("	BEGIN " +
			 				"GE_CONS_CATALOGO_PORTAB_PG.GE_REC_ABONADOS_X_CLIE_PR (?,?,?, ?, ?); "+
					 	 "	END;");
		return call.toString();	 
	}
	/**
	 * Obtiene listado de Abonados Activos por Cliente
	 * @param cliente
	 * @return ClienteIdentDTO[]
	 * @throws GeneralException
	 */
	public AbonadoActivoDTO[]  getAbonadosActivosCliente(long cliente) throws GeneralException{
		logger.debug("Inicio DAO:  getAbonadosActivosCliente");
		
		AbonadoActivoDTO[] retValue=null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try{
			String call = getSQLgetAbonadosActivosCliente();
			logger.debug("sql[" + call + "]");
			logger.debug("Código Cliente: " + cliente);
			
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, cliente);
			cstmt.registerOutParameter(2,OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			logger.debug("Inicio:getAbonadosActivosCliente:execute");
			cstmt.execute();
			logger.debug("Fin:getAbonadosActivosCliente:execute");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			logger.debug("codError ["+codError+"]" );
			logger.debug("msgError ["+msgError+"]" );
			logger.debug("numEvento ["+numEvento+"]" );
			
			if (codError != 0) {
				logger.error("Ocurrió un error al obtener listado de abonados activos por código de cliente ");
				throw new GeneralException(
						"Ocurrió un error al obtener listado  de abonados activos por código de cliente", String
								.valueOf(codError), numEvento, msgError);
			}else{
				logger.debug("Recuperando getAbonadosActivosCliente");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(2);
				while (rs.next()) {
					AbonadoActivoDTO abonadoActivoDTO = new AbonadoActivoDTO();
						 abonadoActivoDTO.setNumAbonado(rs.getLong(1));
						 abonadoActivoDTO.setNumCelular(rs.getLong(2));
						 abonadoActivoDTO.setMtoGarantia(rs.getFloat(3));
						 abonadoActivoDTO.setFecPago(rs.getString(4));
						 abonadoActivoDTO.setImpCargobasico(rs.getFloat(5));
						 abonadoActivoDTO.setCodMoneda(rs.getString(6));
						 abonadoActivoDTO.setDesMoneda(rs.getString(7));
					lista.add(abonadoActivoDTO);
				}
				rs.close();
				retValue =(AbonadoActivoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), AbonadoActivoDTO.class);
				
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		}catch(GeneralException e ){
			throw (e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener listado de abonados activos por código de cliente",e);
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
		logger.debug("Inicio DAO:  getAbonadosActivosCliente");
		return retValue;
	}
	
	private String getSQLgetLinkFactura(){
		StringBuffer call = new StringBuffer();
						call.append("BEGIN  " +
										"GE_CONS_CATALOGO_PORTAB_PG.GE_REC_LINK_DOCUMENTO_PR ( ?, ?, ?, ?, ? ); " +
									"END; ");
		return call.toString();
	}
	
	public WsLinkDocumentoOutDTO getLinkFactura(WsLinkDocumentoInDTO wsLinkDocumentoInDTO) throws GeneralException{
		logger.debug("getLinkFactura:inicio");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		logger.debug("Coneccion obtenida OK");
		CallableStatement cstmt = null;
		WsLinkDocumentoOutDTO retValue=new WsLinkDocumentoOutDTO();
		try {
			String call = getSQLgetLinkFactura();
			logger.debug("sql[" + call + "]");
			logger.debug("Numero proceso ["+wsLinkDocumentoInDTO.getNumProceso()+"]");
		//	logger.debug("Codigo tipo documento["+wsLinkDocumentoInDTO.getCodTipDocumento()+"]");
			
			cstmt = conn.prepareCall(call);
			
			/*-- entrada --*/
			cstmt.setLong(1,wsLinkDocumentoInDTO.getNumProceso());
			//cstmt.setLong(2,wsLinkDocumentoInDTO.getCodTipDocumento());
			/*-- salida --*/
			cstmt.registerOutParameter(2,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);
			
			logger.debug("getLinkFactura:Execute Antes");
			cstmt.execute();
			logger.debug("getLinkFactura:Execute Despues");
			
			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);

			logger.debug("codError ["+codError+"]" );
			logger.debug("msgError ["+msgError+"]" );
			logger.debug("numEvento ["+numEvento+"]" );
			
			if (codError != 0) {
				logger.error("Ocurrió un error al obtener getLinkFactura ");
				throw new GeneralException(
						"Ocurrió un error al obtener getLinkFactura", String
								.valueOf(codError), numEvento, msgError);
			}else{
				retValue.setLinkDocumento(cstmt.getString(2));
				
			}

			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		}catch(GeneralException e ){
			throw (e);
		}catch (Exception e) {
			logger.error("Ocurrió un error al obtener getLinkFactura",e);
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
		logger.debug("getLinkFactura():end");
		return retValue;
	}
	
	private String getSQLgetDatosCredCliente(){
		StringBuffer call = new StringBuffer();
				call.append("BEGIN" +
							"	GE_CONS_CATALOGO_PORTAB_PG.GE_REC_DATOS_CRED_CLIE_PR ( ?, ?, ?, ?, ?, ? ); " +
							"END;"); 
		
		return call.toString();
	}
	
	public WsInfoComercialClienteDTO[] getDatosCredCliente(ClienteDTO clienteDTO)throws GeneralException{
		WsInfoComercialClienteDTO[] retValue=null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try{
			String call = getSQLgetDatosCredCliente();
			logger.debug("sql[" + call + "]");
			logger.debug("Código Tipo Identificación: " + clienteDTO.getCodigoTipoIdentificacion());
			logger.debug("Número de Identificación: " + clienteDTO.getNumeroIdentificacion());
			
			cstmt = conn.prepareCall(call);
			cstmt.setString(1, clienteDTO.getCodigoTipoIdentificacion());
			cstmt.setString(2, clienteDTO.getNumeroIdentificacion());
			cstmt.registerOutParameter(3,OracleTypes.CURSOR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			logger.debug("Inicio:getDatosCredCliente:execute");
			cstmt.execute();
			logger.debug("Fin:getDatosCredCliente:execute");

			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);
			
			logger.debug("codError ["+codError+"]" );
			logger.debug("msgError ["+msgError+"]" );
			logger.debug("numEvento ["+numEvento+"]" );
			
			if (codError != 0) {
				logger.error("Ocurrió un error al obtener getDatosCredCliente ");
				throw new GeneralException(
						"Ocurrió un error al obtener getDatosCredCliente", String
								.valueOf(codError), numEvento, msgError);
			}else{
				logger.debug("Recuperando getDatosCredCliente");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(3);
				while (rs.next()) {
					WsInfoComercialClienteDTO clienteMoraDTO = new WsInfoComercialClienteDTO();
						clienteMoraDTO.setCodCliente(rs.getLong(1));
						clienteMoraDTO.setTipoCuenta(rs.getString(2));
						clienteMoraDTO.setFecAlta(rs.getString(3));
						clienteMoraDTO.setCodSisPago(rs.getLong(4));
						clienteMoraDTO.setNumTarjeta(rs.getString(5));
						clienteMoraDTO.setDiasCartera(rs.getFloat(6));
						clienteMoraDTO.setValorCartera(rs.getFloat(7));
					lista.add(clienteMoraDTO);
				}
				rs.close();
				retValue =(WsInfoComercialClienteDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), WsInfoComercialClienteDTO.class);
								
				if (retValue.length < 1){
					logger.debug("No existen datos para el criterio de busqueda");
					throw new GeneralException("12246",0,"No existen datos para el criterio de busqueda");
					
				}
				
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		}catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener getDatosCredCliente",e);
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
		logger.debug("Inicio DAO:  getDatosCredCliente");
		return retValue;
	}
	
	
	private String getSQLgetRecPagosClie(){
		StringBuffer call = new StringBuffer();
				call.append("BEGIN" +
						"    	GE_CONS_CATALOGO_PORTAB_PG.GE_REC_PAGOS_CLIE_PR ( ?, ?, ?, ?, ?, ? );" +
						"	END;");
		return call.toString();
	}
	
	public PagosUltimosMesesDTO[] getRecPagosClie(ClienteDTO clienteDTO)throws GeneralException{
		PagosUltimosMesesDTO[] retValue=null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try{
			String call = getSQLgetRecPagosClie();
			logger.debug("sql[" + call + "]");
			logger.debug("Código de Cliente: " + clienteDTO.getCodigoCliente());
			logger.debug("Número de Meses: " + clienteDTO.getNumMesesCobro());
			
			cstmt = conn.prepareCall(call);
			cstmt.setString(1, clienteDTO.getCodigoCliente());
			cstmt.setLong(2, clienteDTO.getNumMesesCobro());
			cstmt.registerOutParameter(3,OracleTypes.CURSOR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			logger.debug("Inicio:getRecPagosClie:execute");
			cstmt.execute();
			logger.debug("Fin:getRecPagosClie:execute");

			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);
			
			logger.debug("codError ["+codError+"]" );
			logger.debug("msgError ["+msgError+"]" );
			logger.debug("numEvento ["+numEvento+"]" );
			
			if (codError != 0) {
				logger.error("Ocurrió un error al obtener getRecPagosClie ");
				throw new GeneralException(
						"Ocurrió un error al obtener getRecPagosClie", String
								.valueOf(codError), numEvento, msgError);
			}else{
				logger.debug("Recuperando getRecPagosClie");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(3);
				while (rs.next()) {
					PagosUltimosMesesDTO coPagoDTO = new PagosUltimosMesesDTO();
					coPagoDTO.setAnioPago(rs.getLong(1));
					coPagoDTO.setMesPago(rs.getLong(2));
					coPagoDTO.setImpPago(rs.getFloat(3));
				
					lista.add(coPagoDTO);
				}
				rs.close();
				retValue =(PagosUltimosMesesDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), PagosUltimosMesesDTO.class);
				
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		}catch(GeneralException e ){
			throw (e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener getRecPagosClie",e);
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
		logger.debug("Inicio DAO:  getRecPagosClie");
		return retValue;
	}
	private String getSQLsetAnulacionVenta(){
		StringBuffer call = new StringBuffer();
		
		call.append(" BEGIN " +
						" GA_ANULA_VENTA_PORTADO_PG.GA_ANULA_VENTA_PR (?,?,?,?,?,?,?,?,?,?,?,?);" +
				"END; ");
			return call.toString();
	}
	
	public RetornoDTO setAnulacionVenta(ParametrosAnulacionVentaDTO parametrosAnulacionVentaDTO)throws GeneralException{
		
		RetornoDTO resultado = new RetornoDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		
		try {
			logger.debug("Inicio:setAnulacionVenta()");
			
			String call = getSQLsetAnulacionVenta();
	
			logger.debug("sql[" + call + "]");
			
			logger.debug("CodCliente ["+	parametrosAnulacionVentaDTO.getCodCliente()+"]");
			logger.debug("NumAbonado ["+	parametrosAnulacionVentaDTO.getNumAbonado()+"]"); 
			logger.debug("TipAbonado ["+	parametrosAnulacionVentaDTO.getTipAbonado()+"]");
			logger.debug("ClaseServ	 ["+    parametrosAnulacionVentaDTO.getClaseServ()+"]");
			logger.debug("CodCausaBaja ["+  parametrosAnulacionVentaDTO.getCodCausaBaja()+"]");
			logger.debug("CodActabo  ["+    parametrosAnulacionVentaDTO.getCodActabo()+"]");
			logger.debug("Usuario ["+       parametrosAnulacionVentaDTO.getUsuario()+"]");
			logger.debug("Mnd   ["+         parametrosAnulacionVentaDTO.getMnd()+"]");
			logger.debug("Uso  ["+          parametrosAnulacionVentaDTO.getUso()+"]");							
	
			cstmt = conn.prepareCall(call);
			
			
			cstmt.setLong(1,parametrosAnulacionVentaDTO.getCodCliente());   
			cstmt.setLong(2,parametrosAnulacionVentaDTO.getNumAbonado());   
			cstmt.setString(3,parametrosAnulacionVentaDTO.getTipAbonado());   
			cstmt.setString(4,parametrosAnulacionVentaDTO.getClaseServ());    
			cstmt.setString(5,parametrosAnulacionVentaDTO.getCodCausaBaja()); 
			cstmt.setString(6,parametrosAnulacionVentaDTO.getCodActabo());    
			cstmt.setString(7,parametrosAnulacionVentaDTO.getUsuario());      
			cstmt.setLong(8,parametrosAnulacionVentaDTO.getMnd());          
			cstmt.setLong(9,parametrosAnulacionVentaDTO.getUso()  );     
			
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(12, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:setAnulacionVenta:execute");
			cstmt.execute();
			logger.debug("Fin:setAnulacionVenta:execute");
						
			codError=cstmt.getInt(10);
			msgError = cstmt.getString(11);			
			numEvento=cstmt.getInt(12);
			
			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error("Ocurrió un error al setAnulacionVenta");
				throw new GeneralException(
						"Ocurrió un error al setAnulacionVenta", String
								.valueOf(codError), numEvento, msgError);
			}
			
		}catch (GeneralException e) {
			 throw (e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al setAnulacionVenta",e);
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
		logger.debug("Fin:setAnulacionVenta");
		return resultado;
	}
	
	private String getSQLgetValidaCodigoCausa(){
		StringBuffer call= new StringBuffer();
			call.append(" BEGIN  " +
						"	GA_SERVICIOS_ABONADOS_PG.GA_VALIDA_CAUSA_BAJA_PR ( ?, ?, ?, ? ); "+
					
		    			"END;");
		return call.toString();
	}
	
	public boolean isExisteCodCausaBaja(String codCausaBaja)throws GeneralException{
		logger.debug("isExisteCodCausaBaja:inicio");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		logger.debug("Coneccion obtenida OK");
		CallableStatement cstmt = null;
		boolean retValue=false;
		try {
			String call = getSQLgetValidaCodigoCausa();
			logger.debug("sql[" + call + "]");
			logger.debug("Código Causa Baja["+codCausaBaja+"]");
				
			cstmt = conn.prepareCall(call);
			
			/*-- entrada --*/
			cstmt.setString(1,codCausaBaja);
			/*-- salida --*/
			cstmt.registerOutParameter(2,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);
			
			logger.debug("isExisteCodCausaBaja:Execute Antes");
			cstmt.execute();
			logger.debug("isExisteCodCausaBaja:Execute Despues");
			
			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);
			
			logger.debug("codError ["+codError+"]" );
			logger.debug("msgError ["+msgError+"]" );
			logger.debug("numEvento ["+numEvento+"]" );

			if (codError != 0) {
				logger.error("Ocurrió un error al obtener isExisteCodCausaBaja ");
				throw new GeneralException(
						"Ocurrió un error al obtener isExisteCodCausaBaja", String
								.valueOf(codError), numEvento, msgError);
			}else{
				retValue=codError==0?true:false;
				
			}

			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		}catch(GeneralException e ){
			throw (e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener isExisteCodCausaBaja",e);
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
		logger.debug("isExisteCodCausaBaja():end");
		return retValue;
	}
	
	private String getSQLValidarTarjeta(){
		StringBuffer call= new StringBuffer();
			call.append(" BEGIN  " +
						"	GE_CONS_CATALOGO_PORTAB_PG.GE_EXISTE_TARJETA_CRED_PR (?, ?, ?, ?, ?, ? ); "+
					
		    			"END;");
		return call.toString();
	}
	
	public WSValidarTarjetaOutDTO validarTarjeta(WsValTarjetaInDTO valTarjeta)throws GeneralException{
		
		WSValidarTarjetaOutDTO respuesta = new WSValidarTarjetaOutDTO();
		logger.debug("validarTarjeta:inicio");
		String existe;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		logger.debug("Coneccion obtenida OK");
		CallableStatement cstmt = null;
		boolean retValue=false;
		try {
			String call = getSQLValidarTarjeta();
			logger.debug("sql[" + call + "]");
				
			cstmt = conn.prepareCall(call);
			
			/*-- entrada --*/
			cstmt.setString(1,valTarjeta.getTipoTarjeta());
			cstmt.setString(2,valTarjeta.getNumeroTarjeta());
			
			/*-- salida --*/
			cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6,java.sql.Types.NUMERIC);
			
			logger.debug("validarTarjeta:Execute Antes");
			cstmt.execute();
			logger.debug("validarTarjeta:Execute Despues");
			
			
			existe = cstmt.getString(3);
			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);
			
			logger.debug("codError ["+codError+"]" );
			logger.debug("msgError ["+msgError+"]" );
			logger.debug("numEvento ["+numEvento+"]" );

			RetornoDTO retorno = new RetornoDTO();
			retorno.setCodError(String.valueOf(codError));
			retorno.setMensajseError(msgError);
			
			respuesta = new WSValidarTarjetaOutDTO();
			respuesta.setExiste(existe);
			respuesta.setCodError(retorno.getCodError());
			respuesta.setMensajseError(retorno.getMensajseError());
			
			if (codError != 0) {
				logger.error("Ocurrió un error al obtener validarTarjeta ");
				throw new GeneralException(
						"Ocurrió un error al obtener validarTarjeta", String
								.valueOf(codError), numEvento, msgError);
			}else{
				retValue=codError==0?true:false;
				
			}

			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		}catch(GeneralException e ){
			throw (e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener validarTarjeta",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
				if (e instanceof GeneralException ){
					throw (GeneralException)e;
				}
				else{
					GeneralException ge = new GeneralException();
					ge.setDescripcionEvento(e.getMessage());
					throw ge;
				}
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
		logger.debug("validarTarjeta():end");
		return respuesta;
	}
	
	public CuentaComDTO getEmpresa(CuentaComDTO cuenta) 
	throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:insEmpresa");
			
			//INI-01 (AL) String call = getSQLDatosCliente("VE_alta_cliente_PG","VE_selEmpresa_PR",14);
			String call = getSQLDatosCliente("VE_alta_cliente_Quiosco_PG","VE_selEmpresa_PR",14);
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,cuenta.getClienteComDTO().getCodigoCliente());
			logger.debug("cliente.getCodigoCliente(): " + cuenta.getClienteComDTO().getCodigoCliente());			
			
			cstmt.registerOutParameter(2,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);			
			cstmt.registerOutParameter(5,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6,java.sql.Types.DATE);
			cstmt.registerOutParameter(7,java.sql.Types.VARCHAR);			
			cstmt.registerOutParameter(8,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(9,java.sql.Types.NUMERIC);			
			cstmt.registerOutParameter(10,java.sql.Types.VARCHAR);			
			cstmt.registerOutParameter(11,java.sql.Types.NUMERIC);			
			cstmt.registerOutParameter(12, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(14, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:insEmpresa:execute");
			cstmt.execute();
			logger.debug("Fin:insEmpresa:execute");
			
			codError = cstmt.getInt(12);
			msgError = cstmt.getString(13);
			numEvento = cstmt.getInt(14);
			
			logger.debug("codError ["+codError+"]" );
			logger.debug("msgError ["+msgError+"]" );
			logger.debug("numEvento ["+numEvento+"]" );

			if (codError !=0){
				logger.error("Ocurrió un error al recuperar empresa");
				throw new GeneralException(
						"Ocurrió un error al recuperar empresa", String
								.valueOf(codError), numEvento, msgError);
			}
			
			 /*sn_cod_empresa    OUT NOCOPY ga_empresa.cod_empresa%TYPE, 
			   sv_des_empresa    OUT NOCOPY ga_empresa.des_empresa%TYPE, 
			   sn_cod_producto   OUT NOCOPY ga_empresa.cod_producto%TYPE, 
			   sv_cod_plantarif  OUT NOCOPY ga_empresa.cod_plantarif%TYPE, 
			   sd_fec_alta       OUT NOCOPY ga_empresa.fec_alta%TYPE, 
               sv_nom_usuarora   OUT NOCOPY ga_empresa.nom_usuarora%TYPE, 
			   sn_cod_ciclo      OUT NOCOPY ga_empresa.cod_ciclo%TYPE, 
			   sn_cod_cliente    OUT NOCOPY ga_empresa.cod_cliente%TYPE, 
			   sv_tip_terminal   OUT NOCOPY ga_empresa.tip_terminal%TYPE, 
			   sn_num_abonados   OUT NOCOPY ga_empresa.num_abonados%TYPE,*/
			
			cuenta.getClienteComDTO().setCodigoEmpresa  (new Long(cstmt.getString(2)).longValue());
			cuenta.getClienteComDTO().setDescripcionEmpresa(cstmt.getString(3));
			cuenta.getClienteComDTO().setCodigoProducto(cstmt.getInt(4));
			cuenta.getClienteComDTO().setCodigoPlanTarifario(cstmt.getString(5));
			cuenta.getClienteComDTO().setNumeroAbonados(cstmt.getInt(11));
			
		}catch(GeneralException e ){
			throw (e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al recuperar empresa",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al recuperar empresa", String
							.valueOf(codError), numEvento, msgError);
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
		logger.debug("Fin:insEmpresa()");
		return cuenta;
	}//fin insEmpresa
	
	public void udpEmpresa(CuentaComDTO cuenta) 
	throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:insEmpresa");
			
			//INI-01 (AL) String call = getSQLDatosCliente("VE_alta_cliente_PG","VE_updEmpresa_PR",6);
			String call = getSQLDatosCliente("VE_alta_cliente_Quiosco_PG","VE_updEmpresa_PR",6);
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			
			cstmt.setLong(1,cuenta.getClienteComDTO().getCodigoEmpresa());
			logger.debug("cliente.getCodigoEmpresa(): " + cuenta.getClienteComDTO().getCodigoEmpresa());			
			cstmt.setInt(2,cuenta.getClienteComDTO().getNumeroAbonados());
			logger.debug("cliente.getCodigoEmpresa(): " + cuenta.getClienteComDTO().getNumeroAbonados());					
			cstmt.setString(3,cuenta.getClienteComDTO().getNombreUsuarOra());
			logger.debug("cliente.getCodigoEmpresa(): " + cuenta.getClienteComDTO().getNombreUsuarOra());
			
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:insEmpresa:execute");
			cstmt.execute();
			logger.debug("Fin:insEmpresa:execute");
			
			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);
			
			logger.debug("codError ["+codError+"]" );
			logger.debug("msgError ["+msgError+"]" );
			logger.debug("numEvento ["+numEvento+"]" );

			if (codError !=0){
				logger.error("Ocurrió un error al modificar empresa");
				throw new GeneralException(
						"Ocurrió un error al modificar empresa", String
								.valueOf(codError), numEvento, msgError);
			}
			
		}catch(GeneralException e ){
			throw (e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al modificar empresa",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al modificar empresa", String
							.valueOf(codError), numEvento, msgError);
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
		logger.debug("Fin:insEmpresa()");
	}//fin insEmpresa
	

	private String getSQLInsertFaMensProceso(){
		StringBuffer call= new StringBuffer();
			call.append(" BEGIN  " +
						"	FA_MENSPROCESO_I_PG.PV_AGREGAR_PR ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? );"+
						"END;");
		return call.toString();
	}
	
	public RetornoDTO InsertFaMensProceso(FaMensProcesoDTO faMensProcesoDTO)throws GeneralException{
		
		RetornoDTO retValue=new RetornoDTO(); ;
		logger.debug("setObservacionFactura:inicio");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		logger.debug("Coneccion obtenida OK");
		CallableStatement cstmt = null;
		
		try {
			
			/*
			 EN_NUM_PROCESO     IN FA_MENSPROCESO.NUM_PROCESO%TYPE,
             EN_COD_FORMUL     IN FA_MENSPROCESO.COD_FORMULARIO%TYPE,
             EN_COD_BLOQUE     IN FA_MENSPROCESO.COD_BLOQUE%TYPE,
             EN_CORRELATIVO    IN FA_MENSPROCESO.CORR_MENSAJE%TYPE,
             EN_LINEAS         IN FA_MENSPROCESO.NUM_LINEAS%TYPE,
             EV_COD_ORIG       IN FA_MENSPROCESO.COD_ORIGEN%TYPE,
             EV_TEXTO          IN FA_MENSPROCESO.DESC_MENSAJE%TYPE,
             EV_IND_FACTUR     IN FA_MENSPROCESO.IND_FACTURADO%TYPE,
             EV_cod_prog       IN VARCHAR2,
             SN_p_filasafectas OUT NOCOPY  NUMBER,
             SN_p_retornora    OUT NOCOPY  NUMBER,
             SN_p_nroevento    OUT NOCOPY  NUMBER,
             SV_p_vcod_retorno OUT NOCOPY VARCHAR2
*/
			
			String call = getSQLInsertFaMensProceso();
			logger.debug("sql[" + call + "]");
				
			cstmt = conn.prepareCall(call);
			
			/*-- entrada --*/
			cstmt.setLong(1,faMensProcesoDTO.getNumProceso());
			cstmt.setLong(2,faMensProcesoDTO.getCodFormulario());
			cstmt.setLong(3,faMensProcesoDTO.getCodBloque());
			cstmt.setLong(4,faMensProcesoDTO.getCorrMensaje());
			cstmt.setLong(5,faMensProcesoDTO.getNumLineas());
			cstmt.setString(6,faMensProcesoDTO.getCodOrigen());
			if (faMensProcesoDTO.getDescMensaje().length() > 40){
				cstmt.setString(7,faMensProcesoDTO.getDescMensaje().substring(1, 40));
			}else{
				cstmt.setString(7,faMensProcesoDTO.getDescMensaje());
			}
			
			cstmt.setString(8,faMensProcesoDTO.getIndFacturado());
			cstmt.setString(9,"");
			
			/*-- salida --*/
			cstmt.registerOutParameter(10,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(11,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(12,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(13,java.sql.Types.VARCHAR);
			
			logger.debug("setObservacionFactura:Execute Antes");
			cstmt.execute();
			logger.debug("setObservacionFactura:Execute Despues");
			
			codError = cstmt.getInt(11);
			msgError = cstmt.getString(13);
			numEvento = cstmt.getInt(12);

			logger.debug("codError ["+codError+"]" );
			logger.debug("msgError ["+msgError+"]" );
			logger.debug("numEvento ["+numEvento+"]" );
			
			//respuesta.setRetornoDTO(retorno);
			
			if (codError != 0) {
				logger.error("Ocurrió un error al InsertFaMensProceso ");
				throw new GeneralException(
						"Ocurrió un error al InsertFaMensProceso", String
								.valueOf(codError), numEvento, msgError);
			}else{
				
				retValue.setCodError(String.valueOf(codError));
				retValue.setMensajseError("OK");
				
			}

			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		}catch(GeneralException e ){
			throw (e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al InsertFaMensProceso",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
				if (e instanceof GeneralException ){
					throw (GeneralException)e;
				}
				else{
					GeneralException ge = new GeneralException();
					ge.setDescripcionEvento(e.getMessage());
					throw ge;
				}
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
		logger.debug("setObservacionFactura():end");
		return retValue;
	}
	
	private String getSQLInsertFaMensajes(){
		StringBuffer call= new StringBuffer();
			call.append(" BEGIN  " +
						"	FA_MENSAJES_I_PG.PV_AGREGAR_PR ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ); "+
					
		    			"END;");
		return call.toString();
	}
	
	public RetornoDTO setObservacionFactura(FaMensajesDTO faMensajesDTO)throws GeneralException{
		
		RetornoDTO retValue=new RetornoDTO(); ;
		logger.debug("setObservacionFactura:inicio");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		logger.debug("Coneccion obtenida OK");
		CallableStatement cstmt = null;
		
		try {
			
			/*EN_CORRELATIVO    IN FA_MENSAJES.CORR_MENSAJE%TYPE,
              EN_LINEAS         IN FA_MENSAJES.NUM_LINEA%TYPE,
              EV_MENSAJE        IN FA_MENSAJES.DESC_MENSAJE%TYPE,
              EV_MENSLIN        IN ga_Abocel.CLASE_SERVICIO%type,
              EV_IDIOMA             IN FA_MENSAJES.COD_IDIOMA%TYPE,
              EN_LINEASMEN      IN FA_MENSAJES.CANT_LINEASMEN%TYPE,
              EN_CARACTLIN      IN FA_MENSAJES.CANT_CARACTLIN%TYPE,
              EV_cod_prog               IN VARCHAR2,
              SN_p_filasafectas OUT NOCOPY  NUMBER,
              SN_p_retornora    OUT NOCOPY  NUMBER,
              SN_p_nroevento    OUT NOCOPY  NUMBER,
              SV_p_vcod_retorno OUT NOCOPY VARCHAR2*/
			
			String call = getSQLInsertFaMensajes();
			logger.debug("sql[" + call + "]");
				
			cstmt = conn.prepareCall(call);
			
			/*-- entrada --*/
			cstmt.setLong(1,faMensajesDTO.getCorrMensaje());
			cstmt.setString(2,faMensajesDTO.getNumLinea());
			cstmt.setString(3,faMensajesDTO.getDescMensaje());
			cstmt.setString(4,faMensajesDTO.getDescMesLin());
			cstmt.setString(5,faMensajesDTO.getCodIdioma());
			cstmt.setLong(6,faMensajesDTO.getCantLineasMen());
			cstmt.setLong(7,faMensajesDTO.getCantCaractLin());
			cstmt.setString(8,"");
			
			
			/*-- salida --*/
			cstmt.registerOutParameter(9,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(10,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(11,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(12,java.sql.Types.VARCHAR);
			
			logger.debug("setObservacionFactura:Execute Antes");
			cstmt.execute();
			logger.debug("setObservacionFactura:Execute Despues");
			
			codError = cstmt.getInt(10);
			msgError = cstmt.getString(11);
			numEvento = cstmt.getInt(9);
			
			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");
			
			//respuesta.setRetornoDTO(retorno);
			
			if (codError != 0) {
				logger.error("Ocurrió un error al setObservacionFactura ");
				throw new GeneralException(
						"Ocurrió un error al setObservacionFactura", String
								.valueOf(codError), numEvento, msgError);
			}else{
				
				retValue.setCodError(String.valueOf(codError));
				retValue.setMensajseError("OK");
				
			}

			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		}catch(GeneralException e ){
			throw (e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al setObservacionFactura",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
				if (e instanceof GeneralException ){
					throw (GeneralException)e;
				}
				else{
					GeneralException ge = new GeneralException();
					ge.setDescripcionEvento(e.getMessage());
					throw ge;
				}
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
		logger.debug("setObservacionFactura():end");
		return retValue;
	}
	
	
	/**
	 * Metodos que retorna las sucursales de un banco según su código.
	 * @param sucursalBancoDTO
	 * @return
	 * @throws GeneralException
	 */
	public SucursalBancoDTO[] getSucursalesBanco(SucursalBancoDTO sucursalBancoDTO) 
	throws GeneralException{
		logger.debug("Inicio:getSucursalesBanco()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		SucursalBancoDTO[]  resultado = null;
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();
		logger.debug("Coneccion obtenida OK");
		try {
			
			
			String call = getSQLDatosCliente("GE_CONS_CATALOGO_PORTAB_PG","ge_consulta_sucursal_banco_pr",5);			
			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setString(1, sucursalBancoDTO.getCodBanco());
			cstmt.registerOutParameter(2,OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			logger.debug("Inicio:getSucursalesBanco:Execute");
			cstmt.execute();
			logger.debug("Fin:getSucursalesBanco:Execute");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);

			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error("Ocurrió un error al recuperar las sucursales del banco");
				throw new GeneralException(
						"Ocurrió un error al recuperar las sucursales del banco", String
						.valueOf(codError), numEvento, msgError);

			}else{
				logger.debug("Recuperando Sucursales del banco");


				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(2);
				SucursalBancoDTO sucursalBancoDTO2 = null;
				while (rs.next()) {

					sucursalBancoDTO2 = new SucursalBancoDTO();					
					sucursalBancoDTO2.setCodBanco(rs.getString(1));
					logger.error("sucursalBancoDTO2.getCodBanco() ["+sucursalBancoDTO2.getCodBanco()+"]");
					sucursalBancoDTO2.setCodSucursal(rs.getString(2));
					logger.error("sucursalBancoDTO2.getCodSucursal() ["+sucursalBancoDTO2.getCodSucursal()+"]");
					sucursalBancoDTO2.setDesSucursal(rs.getString(3));
					logger.error("sucursalBancoDTO2.getDesSucursal() ["+sucursalBancoDTO2.getDesSucursal()+"]");
					sucursalBancoDTO2.setCodDireccion(rs.getString(4));
					logger.error("sucursalBancoDTO2.getCodDireccion() ["+sucursalBancoDTO2.getCodDireccion()+"]");

					lista.add(sucursalBancoDTO2);
				}
				rs.close();
				resultado =(SucursalBancoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
						lista.toArray(), SucursalBancoDTO.class);
				logger.debug("Fin recuperacion sucursales del banco");
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			throw e;			
		} catch (Exception e) {
			logger.error("Ocurrió un error al recuperar las sucursales del banco",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al recuperar las sucursales del banco",e);
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
		logger.debug("Fin:getSucursalesBanco()");

		return resultado;
	}	
	
	
	public ClasificacionCuentaDTO[] getClasificacionCuenta() 
	throws GeneralException{
		logger.debug("Inicio:getClasificacionCuenta()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ClasificacionCuentaDTO[]  resultado = null;
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();
		logger.debug("Coneccion obtenida OK");
		try {
			
			
			String call = getSQLDatosCliente("GE_CONS_CATALOGO_PORTAB_PG","ge_consulta_clasif_cuenta_pr",4);			
			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.registerOutParameter(1,OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);

			logger.debug("Inicio:getClasificacionCuenta:Execute");
			cstmt.execute();
			logger.debug("Fin:getClasificacionCuenta:Execute");

			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);

			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error("Ocurrió un error al recuperar las clasificaciones de cuenta");
				throw new GeneralException(
						"Ocurrió un error al recuperar las clasificaciones de cuenta", String
						.valueOf(codError), numEvento, msgError);

			}else{
				logger.debug("Recuperando clasificacion de cuenta");


				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(1);
				ClasificacionCuentaDTO clasificacionCuentaDTO = null;
				while (rs.next()) {

					clasificacionCuentaDTO = new ClasificacionCuentaDTO();					
					clasificacionCuentaDTO.setCodClasCuenta(rs.getString(1));
					logger.error("clasificacionCuentaDTO.getCodClasCuenta() ["+clasificacionCuentaDTO.getCodClasCuenta()+"]");
					clasificacionCuentaDTO.setDesClasCuenta(rs.getString(2));
					logger.error("clasificacionCuentaDTO.getDesClasCuenta() ["+clasificacionCuentaDTO.getDesClasCuenta()+"]");
					
					lista.add(clasificacionCuentaDTO);
				}
				rs.close();
				resultado =(ClasificacionCuentaDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
						lista.toArray(), ClasificacionCuentaDTO.class);
				logger.debug("Fin recuperacion clasificacion de cuenta");
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			throw e;			
		} catch (Exception e) {
			logger.error("Ocurrió un error al recuperar las clasificaciones de cuenta",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al recuperar las clasificaciones de cuenta",e);
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
		logger.debug("Fin:getClasificacionCuenta()");

		return resultado;
	}	
	
	
	
	public String getLimConsClieEmpresa(String codigoCliente) 
	throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		String limConsClieEmp;
		try {
			logger.debug("Inicio:getLimConsClieEmpresa");
			
			String call = getSQLDatosCliente("ve_portabilidad_pg","ve_rec_limc_clie_emp_pr ",5);
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,codigoCliente);
			logger.debug("codigoCliente(): " + codigoCliente);													
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getLimConsClieEmpresa:execute");
			cstmt.execute();
			logger.debug("Fin:getLimConsClieEmpresa:execute");
			
			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			logger.debug("codError ["+codError+"]" );
			logger.debug("msgError ["+msgError+"]" );
			logger.debug("numEvento ["+numEvento+"]" );

			if (codError !=0){
				logger.error("Ocurrió un error al recuperar limite de consumo cliente empresa");
				throw new GeneralException(
						"Ocurrió un error al recuperar limite de consumo cliente empresa", String
								.valueOf(codError), numEvento, msgError);
			}else{
				limConsClieEmp = cstmt.getString(2);
			}
			
		}catch(GeneralException e ){
			throw (e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al recuperar limite de consumo cliente empresa",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al modificar empresa", String
							.valueOf(codError), numEvento, msgError);
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
		logger.debug("Fin:getLimConsClieEmpresa()");
		return limConsClieEmp;
	}//fin insEmpresa
		
	/**
	 * CSR-11002 - (AL) - 2011.07.27
	 * Metodo de categorias para cambio asociadas al cliente.
	 * @return resultado
	 * @throws GeneralException
	 */
	public CategoriaCambioDTO[] getCategoriasCambio() 
	throws GeneralException
	{
		logger.debug("getCategoriasCambio:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		CategoriaCambioDTO[] resultado = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		ResultSet rs = null;
		logger.debug("Coneccion obtenida OK");
		try
		{
			String call = getSQLDatosCliente("VE_alta_cliente_PG", "VE_getListCategoriaCambio_PR", 4);
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.registerOutParameter(1, OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			logger.debug("Execute Antes");
			cstmt.execute();
			logger.debug("Execute Despues");
			codError = cstmt.getInt(2);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(3);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(4);
			logger.debug("numEvento[" + numEvento + "]");
			if (codError != 0)
			{
				logger.error("Ocurrió un error al consultar categorias de cambio");
				throw new GeneralException("Ocurrió un error al consultar categorias de cambio", String
						.valueOf(codError), numEvento, msgError);

			}
			else
			{
				logger.debug("Listado categorias cambio");
				rs = (ResultSet) cstmt.getObject(1);
				ArrayList lista = new ArrayList();
				while (rs.next())
				{
					CategoriaCambioDTO categoriaCambio = new CategoriaCambioDTO();
					categoriaCambio.setCodCategoria(rs.getString(1));
					categoriaCambio.setDesCategoria(rs.getString(2));
					lista.add(categoriaCambio);
				}
				resultado = (CategoriaCambioDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), CategoriaCambioDTO.class);
				;
			}
			if (logger.isDebugEnabled())
			{
				logger.debug(" Finalizo ejecución");
			}
		}
		catch (Exception e)
		{
			logger.error("Ocurrió un error al consultar categorias de cambio", e);
			if (logger.isDebugEnabled())
			{
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof GeneralException)
			{
				throw (GeneralException) e;
			}
			else
			{
				GeneralException c = new GeneralException();
				c.setMessage(e.getMessage());
				throw c;
			}
		}
		finally
		{
			if (logger.isDebugEnabled())
				logger.debug("Cerrando conexiones...");
			try
			{
				if (rs != null)
					rs.close();
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				logger.debug("SQLException", e);
			}
		}
		logger.debug("getCategoriasCambio():end");
		return resultado;
	}
	
	
	/**
	 * CSR-11002 - (AL) - 2011.07.27 - Inserta categoria de cambio del cliente
	 * @param categCambioCliente
	 * @return N/A
	 * @throws GeneralException
	 */
	public void insCategoriaCambioCliente(CategoriaCambioClienteDTO categCambioCliente) throws GeneralException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try
		{
			logger.debug("Inicio:insCategoriaCambioCliente");
			String call = getSQLDatosCliente("VE_alta_cliente_PG", "VE_insCategCambioCliente_PR", 6);
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, categCambioCliente.getCodCliente());
			logger.debug("categCambioCliente.getCodCliente(): " + categCambioCliente.getCodCliente());
			cstmt.setInt(2, categCambioCliente.getCodCategoriaCambio());
			logger.debug("categCambioCliente.getCodCategoriaCambio(): " + categCambioCliente.getCodCategoriaCambio());
			cstmt.setString(3, categCambioCliente.getNomUsuario());
			logger.debug("categCambioCliente.getNomUsuario(): " + categCambioCliente.getNomUsuario());

			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

			logger.debug("Inicio:insCategoriaCambioCliente:execute");
			cstmt.execute();
			logger.debug("Fin:insCategoriaCambioCliente:execute");

			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);

			if (codError != 0)
			{
				logger.error("Ocurrió un error al insertar categoria de cambio del cliente");
				throw new GeneralException("Ocurrió un error al insertar categoria de cambio del cliente", String
						.valueOf(codError), numEvento, msgError);
			}
		}
		catch (Exception e)
		{
			logger.error("Ocurrió un error al insertar categoria de cambio del cliente", e);
			if (logger.isDebugEnabled())
			{
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof GeneralException)
				throw (GeneralException) e;
		}
		finally
		{
			if (logger.isDebugEnabled())
				logger.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:insCategoriaCambioCliente()");
	}// fin insCategoriaCambioCliente

	/**
	 * CSR-11002
	 * permite obtener las clasificaciones crediticia
	 * @return
	 * @throws GeneralException
	 */
	public ValorClasificacionDTO[] getCrediticia()
	throws GeneralException{
		
		logger.debug("Inicio:getCrediticia()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ValorClasificacionDTO[]  resultado = null;
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();
		logger.debug("Coneccion obtenida OK");
		try {
			
			
			String call = getSQLDatosCliente("VE_alta_cliente_PG", "VE_getListCrediticia_PR", 4);			
			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.registerOutParameter(1,OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);

			logger.debug("Inicio:getClasificacionCuenta:Execute");
			cstmt.execute();
			logger.debug("Fin:getClasificacionCuenta:Execute");

			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);

			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error("Ocurrió un error al consultar clasificacion crediticia");
				throw new GeneralException(
						"Ocurrió un error al consultar clasificacion crediticia", String
						.valueOf(codError), numEvento, msgError);

			}else{
				logger.debug("Listado clasificacion crediticia");


				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(1);
				ValorClasificacionDTO valorClasificacion = null;
				while (rs.next()) {

					valorClasificacion = new ValorClasificacionDTO();					
					valorClasificacion.setCodClasificacion(rs.getString(1));
					valorClasificacion.setDesClasificacion(rs.getString(2));
					valorClasificacion.setIndDefecto(rs.getInt(3));
					
					lista.add(valorClasificacion);
				}
				rs.close();
				resultado =(ValorClasificacionDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
						lista.toArray(), ValorClasificacionDTO.class);
				logger.debug("Fin recuperacion clasificacion crediticia");
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			throw e;			
		} catch (Exception e) {
			logger.error("Ocurrió un error al recuperar las clasificaciones crediticia",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al recuperar las clasificaciones crediticia",e);
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
		logger.debug("Fin:getCrediticia()");

		return resultado;
		
	}
	
	/**
	 * CSR-11002
	 * permite obtener las clasificaciones
	 * @return
	 * @throws GeneralException
	 */
	public ClasificacionDTO[] getClasificaciones()
	throws GeneralException{
		
		logger.debug("Inicio:getClasificaciones()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ClasificacionDTO[]  resultado = null;
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();
		logger.debug("Coneccion obtenida OK");
		try {
			
			
			String call = getSQLDatosCliente("VE_alta_cliente_PG", "VE_getListClasificaciones_PR", 4);			
			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.registerOutParameter(1,OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);

			logger.debug("Inicio:getClasificacionCuenta:Execute");
			cstmt.execute();
			logger.debug("Fin:getClasificacionCuenta:Execute");

			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);

			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error("Ocurrió un error al consultar clasificaciones");
				throw new GeneralException(
						"Ocurrió un error al consultar clasificaciones", String
						.valueOf(codError), numEvento, msgError);

			}else{
				logger.debug("Listado clasificaciones");


				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(1);
				ClasificacionDTO clasificacion = null;
				while (rs.next()) {

					clasificacion = new ClasificacionDTO();
					clasificacion.setCodElemento(rs.getString(1));
					clasificacion.setDesElemento(rs.getString(2));
					clasificacion.setIndActivo(rs.getInt(3));
					clasificacion.setIndVisible(rs.getInt(4));
					
					lista.add(clasificacion);
				}
				rs.close();
				resultado =(ClasificacionDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
						lista.toArray(), ClasificacionDTO.class);
				logger.debug("Fin recuperacion clasificacion clasificacion");
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			throw e;			
		} catch (Exception e) {
			logger.error("Ocurrió un error al recuperar las clasificaciones",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al recuperar las clasificaciones",e);
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
		logger.debug("Fin:getClasificaciones()");

		return resultado;
		
	}
	
	public void insMontoPreautorizado(ClienteComDTO entrada) 
	throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:insMontoPreautorizado");
			
			String call = getSQLDatosCliente("VE_alta_cliente_PG", "VE_insMontoPreautorizado_PR", 6);
			logger.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setLong(1, Long.valueOf(entrada.getCodigoCliente()).longValue());
			logger.debug("entrada.getCodigoCliente(): " + entrada.getCodigoCliente());
			cstmt.setString(2, entrada.getMontoPreAutorizado());
			logger.debug("entrada.getMontoPreAutorizado(): " + entrada.getMontoPreAutorizado());
			cstmt.setString(3, entrada.getNombreUsuarOra());
			logger.debug("entrada.getNombreUsuarOra(): " + entrada.getNombreUsuarOra());
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:insMontoPreautorizado:execute");
			cstmt.execute();
			logger.debug("Fin:insMontoPreautorizado:execute");
			
			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);
			
			logger.debug("codError ["+codError+"]" );
			logger.debug("msgError ["+msgError+"]" );
			logger.debug("numEvento ["+numEvento+"]" );

			if (codError !=0){
				logger.error("Ocurrió un error al insertar monto preautorizado");
				throw new GeneralException(
						"Ocurrió un error al insertar monto preautorizado", String
								.valueOf(codError), numEvento, msgError);
			}
		}catch(GeneralException e ){
			throw (e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al insertar monto preautorizado",e);
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
		logger.debug("Fin:insMontoPreautorizado()");
	}//fin insMontoPreautorizado
	
	//CSR-11002
	/**
	 * Obtiene listado de tipos de pago.
	 * @return WsListModalidadPagoOutDTO
	 * @throws GeneralException
	 */
	public WsListTipoPagoOutDTO getListadoTipoPago() 
	throws GeneralException{
		
		WsListTipoPagoOutDTO resultado = null;
		TipoPagoDTO[] tiposPago = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		
		try {

			logger.debug("Inicio:getListadoTipoPago");
			resultado = new WsListTipoPagoOutDTO();

			String call = getSQLDatosCliente("VE_SERVICIOS_VENTA_QUIOSCO_PG","ve_obtiene_formas_pago_pr",7);
			logger.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setNull(1,java.sql.Types.NULL);
			cstmt.setString(2,"FALSE");
			cstmt.setNull(3,java.sql.Types.NULL);
			cstmt.registerOutParameter(4,OracleTypes.CURSOR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getListadoTipoPago:execute");
			cstmt.execute();
			logger.debug("Fin:getListadoTipoPago:execute");
			
			codError = cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento = cstmt.getInt(7);
			
			logger.debug("codError ["+codError+"]" );
			logger.debug("msgError ["+msgError+"]" );
			logger.debug("numEvento ["+numEvento+"]" );

			if (codError != 0) {
				logger.error("Ocurrió un error al obtener listado de tipos de pago");
				resultado.setMensajseError(msgError);
				resultado.setCodError(""+codError);
				throw new GeneralException(
						  "Ocurrió un error al obtener listado de tipos de pago", String
								.valueOf(codError), numEvento, msgError);
			}else{
				logger.debug("Recuperando listado tipos de pago");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(4);
				while (rs.next()) {
					TipoPagoDTO tipoPagoRS = new TipoPagoDTO();
					tipoPagoRS.setTipValor(rs.getString(1));
					tipoPagoRS.setDescripcionTipValor(rs.getString(2));
					lista.add(tipoPagoRS);
				}
				rs.close();
				tiposPago =(TipoPagoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), TipoPagoDTO.class);
				resultado.setTipoPagoArrOutDTO(tiposPago);
				
				logger.debug("listado de tipos de pago");
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		}catch(GeneralException e ){
			throw (e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener listado de tipos de pago",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error [" + codError + "]");
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
		logger.debug("Fin:getListadoTipoPago()");
		return resultado;
	}//fin getListadoTipoPago	
	
	//JLGN PT
	/**
	 * Obtiene listado de Planes Tarifarios Prepago.
	 * @return WsListPlanTarifarioOutDTO
	 * @throws GeneralException
	 */
	public WsListPlanTarifarioOutDTO getListadoPlanTarifario(String tipProducto, String tipPlan, String codTipPrestacion, int indRenova, String codCalificacion) 
	throws GeneralException{
		
		WsListPlanTarifarioOutDTO resultado = null;
		WsPlanTarifarioOutDTO[] planTarifarios = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		
		try {

			logger.debug("Inicio:getListadoPlanTarifario");
			resultado = new WsListPlanTarifarioOutDTO();

			String call = getSQLDatosCliente("ER_servicios_evalriesgo_web_PG","ER_getListaPlanesTarif_PR",10);
			logger.debug("sql[" + call + "]");			
			cstmt = conn.prepareCall(call);
			
			logger.debug("Parametros de Entrada");
			
			logger.debug("tipProducto: "+tipProducto);
			cstmt.setString(1,tipProducto);
			logger.debug("tipPlan: "+tipPlan);
			cstmt.setString(2,tipPlan);
			logger.debug("codTipPrestacion: "+codTipPrestacion);
			cstmt.setString(3,codTipPrestacion);
			logger.debug("origen: ");
			cstmt.setString(4,"");
			logger.debug("indRenova: "+indRenova);
			cstmt.setInt(5,indRenova);
			logger.debug("codCalificacion: "+codCalificacion);
			cstmt.setString(6,codCalificacion);			
			
			logger.debug("Parametros de Salida");
			cstmt.registerOutParameter(7,OracleTypes.CURSOR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getListadoPlanTarifario:execute");
			cstmt.execute();
			logger.debug("Fin:getListadoPlanTarifario:execute");
			
			codError = cstmt.getInt(8);
			msgError = cstmt.getString(9);
			numEvento = cstmt.getInt(10);
			
			logger.debug("codError ["+codError+"]" );
			logger.debug("msgError ["+msgError+"]" );
			logger.debug("numEvento ["+numEvento+"]" );

			if (codError != 0) {
				logger.error("Ocurrió un error al obtener listado de Planes Tarifarios");
				resultado.setMensajseError(msgError);
				resultado.setCodError(""+codError);
				throw new GeneralException(
						  "Ocurrió un error al obtener listado de Planes Tarifarios", String
								.valueOf(codError), numEvento, msgError);
			}else{
				logger.debug("Recuperando listado Planes Tarifarios");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(7);
				while (rs.next()) {
					WsPlanTarifarioOutDTO plan = new WsPlanTarifarioOutDTO();
					plan.setCodPlanTarif(rs.getString(1));
					plan.setDesPlanTarif(rs.getString(2));	
					plan.setTipPlanTarif(rs.getString(4));
					lista.add(plan);				
				}
				rs.close();
				planTarifarios =(WsPlanTarifarioOutDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), WsPlanTarifarioOutDTO.class);
				resultado.setWsPlanTarifarioArrOutDTO(planTarifarios);
				
				logger.debug("Finalizando listado Planes Tarifarios");
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		}catch(GeneralException e ){
			throw (e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener listado de Planes Tarifarios",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error [" + codError + "]");
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
		logger.debug("Fin:getListadoPlanTarifario()");
		return resultado;
	}//fin getListadoPlanTarifario	
	
}//fin CLASS ClienteDAO


