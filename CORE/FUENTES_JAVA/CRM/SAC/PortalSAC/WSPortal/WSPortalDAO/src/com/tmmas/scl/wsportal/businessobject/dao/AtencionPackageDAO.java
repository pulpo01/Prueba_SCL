/**
 * Copyright © 2009 Telefonica Moviles, Soluciones y Aplicaciones, S.A.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informacion propietaria y confidencial de T-mAs S.A.
 * Usted no debe develar tal informacion y solo debe usarla en concordancia
 * con los terminos de derechos de licencias que sean adquiridos con T-mAs S.A.
 */
package com.tmmas.scl.wsportal.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Logger;

import com.tmmas.scl.wsportal.businessobject.dao.base.BaseDAO;
import com.tmmas.scl.wsportal.common.dto.AbonadoDTO;
import com.tmmas.scl.wsportal.common.dto.AtencionClienteDTO;
import com.tmmas.scl.wsportal.common.dto.ListaAtencionClienteDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoAbonadosDTO;
import com.tmmas.scl.wsportal.common.dto.ResgistroAtencionDTO;
import com.tmmas.scl.wsportal.common.dto.ResulTransaccionDTO;
import com.tmmas.scl.wsportal.common.exception.PortalSACException;

public class AtencionPackageDAO extends BaseDAO
{
	private final Logger logger = Logger.getLogger(this.getClass());

	protected static final String CLAVE_TEXTO_PARA_DETALLE = "texto.detalle.producto";

	protected static final String TEXTO_PARA_DETALLE = config.getString(CLAVE_TEXTO_PARA_DETALLE);

	public AtencionPackageDAO(){
		

	}
	
	/**
	 * Cerrar recursos.
	 * @overwrite
	 * @param conn the conn
	 * @param cstmt the cstmt
	 * @param rs TODO
	 * @throws SQLException the SQL exception
	 *
	 */
	protected void cerrarRecursos(Connection conn, CallableStatement cstmt, ResultSet rs) throws SQLException{
	
		if(null != conn){
			rs.close();
		}
		if(null != cstmt){
			cstmt.close();
		}
		if(null != conn){
			conn.close();
		}
		
	}

	/*
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008
	 * Requisito: RSis_010
	 * Caso de uso: CU-017 Registrar consulta de cliente/cuenta/abonado realizado por el usuario
	 * Developer: Gabriel Moraga L.
	 * Fecha: 13/07/2010
	 * Metodo: ObtenerDatosAbonado
	 * Return: AbonadoDTO
	 * Descripcion: Obtiene los datos de un abonado
	 * throws: PortalSACException
	 * 
	 */
	
	public AbonadoDTO obtenerDatosAbonado(Long numAbonado) throws PortalSACException{
		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		int codError = 0;
		int numEvento = 0;
		
		String msgError = null;
		final String nombrePL = "pv_consulta_abonado_pr";
		AbonadoDTO abonadoDTO = null;

		try{
			
			logger.info(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();
			
			String call = daoHelper.getPackageBD(NOMBRE_PACKAGE_BD_ATENCION, nombrePL, 8);
			cstmt = conn.prepareCall(call);
			
			if(logger.isDebugEnabled()){
				logger.debug("SQL[" + call + "]");
				logger.debug("numAbonado: " + numAbonado.longValue());
			}
			
			//Datos de entrada
			cstmt.setLong(1, numAbonado.longValue());
		
			//Datos de salida
			cstmt.registerOutParameter(2, OracleTypes.NUMERIC); //Numero celular
			cstmt.registerOutParameter(3, OracleTypes.VARCHAR); //Nombre usuario
			cstmt.registerOutParameter(4, OracleTypes.VARCHAR); //Apellido 1 (Paterno)
			cstmt.registerOutParameter(5, OracleTypes.VARCHAR); //Apellido 2 (Materno)
			 
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC); //Codigo retorno
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR); //Mensaje retorno
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC); //Numero de evento
			
			if(logger.isDebugEnabled()){
				logger.debug("Execute Antes");
			}
			
			cstmt.execute();
			
			if(logger.isDebugEnabled()){
				logger.debug("Execute Despues");
			}
			
			codError = cstmt.getInt(6);
			msgError = cstmt.getString(7);
			numEvento = cstmt.getInt(8);
			
			if(logger.isDebugEnabled()){
				logger.debug("codError[" + codError + "]");
				logger.debug("msgError[" + msgError + "]");
				logger.debug("numEvento[" + numEvento + "]");
			}
			if (0 != codError){
				throw new PortalSACException(String.valueOf(codError), msgError, numEvento);
			}

			//Set de los datos del abonado
			abonadoDTO = new AbonadoDTO();
			abonadoDTO.setNumAbonado(numAbonado);
			abonadoDTO.setNumCelular(cstmt.getLong(2));
			abonadoDTO.setNomUsuario(cstmt.getString(3));
			abonadoDTO.setApellidoPaterno(cstmt.getString(4));
			abonadoDTO.setApellidoMaterno(cstmt.getString(5));
			
			StringBuffer nomCompl =  new StringBuffer();
			nomCompl.append( null == cstmt.getString(3) ? "" : cstmt.getString(3) );
			nomCompl.append(" ");
			nomCompl.append( null == cstmt.getString(4) ? "" : cstmt.getString(4) );
			nomCompl.append(" ");
			nomCompl.append( null == cstmt.getString(5) ? "" : cstmt.getString(5) );
			
			abonadoDTO.setNomUsuario(nomCompl.toString());

		}catch (java.lang.Exception e){
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}finally{
			try{
				cerrarRecursos(conn, cstmt);
			}catch (Exception e){
				logger.error("Exception [" + e.getMessage() + "]", e);
			}
		}
		logger.debug(MENSAJE_FIN_LOG);
		return abonadoDTO;
	}
	
	/*
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008
	 * Requisito: RSis_010
	 * Caso de uso: CU-017 Registrar consulta de cliente/cuenta/abonado realizado por el usuario
	 * Developer: Gabriel Moraga L.
	 * Fecha: 13/07/2010
	 * Metodo: consultaAtencion
	 * Return: ListaAtencionClienteDTO
	 * Descripcion: Obtiene las atenciones de los clientes
	 * throws: PortalSACException
	 * 
	 */
	
	public ListaAtencionClienteDTO consultaAtencion() throws PortalSACException{
		
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		int codError = 0;
		int numEvento = 0;
		
		String msgError = null;
		final String nombrePL = "PV_Consulta_Atencion_Pr";
		ListaAtencionClienteDTO listaAtencionClienteDTO = null;
		AtencionClienteDTO[] atencionClienteArrayDTO = null;
		List<AtencionClienteDTO> listaAtenClie = null;
		AtencionClienteDTO atencionClienteDTO = null;
		
		try{
			
			logger.info(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();

			String call = daoHelper.getPackageBD(NOMBRE_PACKAGE_BD_ATENCION, nombrePL, 4);
			cstmt = conn.prepareCall(call);
			
			if(logger.isDebugEnabled()){
				logger.debug("SQL[" + call + "]");
			}
			
			//Datos de entrada
			//	N/A
		
			//Datos de salida
			cstmt.registerOutParameter(1, OracleTypes.CURSOR); //Cursor de datos de atencion cliente
			
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC); //Codigo retorno
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR); //Mensaje retorno
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC); //Numero de evento
			
			if(logger.isDebugEnabled()){
				logger.debug("Execute Antes");
			}
			
			cstmt.execute();
			
			if(logger.isDebugEnabled()){
				logger.debug("Execute Despues");
			}
			
			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);
			
			if(logger.isDebugEnabled()){
				logger.debug("codError[" + codError + "]");
				logger.debug("msgError[" + msgError + "]");
				logger.debug("numEvento[" + numEvento + "]");
			}
			if (0 != codError){
				throw new PortalSACException(String.valueOf(codError), msgError, numEvento);
			}

			rs = (ResultSet) cstmt.getObject(1);

			//Se cre el objeto ListaAtencionClienteDTO
			listaAtencionClienteDTO = new ListaAtencionClienteDTO();

            listaAtenClie = new ArrayList<AtencionClienteDTO>();
            
			while (rs.next()){
				//Set de los datos del DTO atencion cliente
				atencionClienteDTO = new AtencionClienteDTO();
				atencionClienteDTO.setDesAtencion(rs.getString(1));
				atencionClienteDTO.setGrpAtencion(rs.getLong(2));
				atencionClienteDTO.setNumNivel(rs.getLong(3));
				atencionClienteDTO.setCodAtencion(rs.getLong(4));
				atencionClienteDTO.setIndObserv(rs.getString(5));
				
				//Se agrega a la lista 
				listaAtenClie.add(atencionClienteDTO);
			
			}
			
			//Se inicializa el arreglo de AtencionClienteDTO
			atencionClienteArrayDTO = (AtencionClienteDTO[]) listaAtenClie.toArray(new AtencionClienteDTO[listaAtenClie.size()]);
			
			//Se crea el objeto de retorno
			listaAtencionClienteDTO = new ListaAtencionClienteDTO();
			
			listaAtencionClienteDTO.setArrayAtencionCliente(atencionClienteArrayDTO);

			if (atencionClienteArrayDTO == null || (atencionClienteArrayDTO != null && atencionClienteArrayDTO.length == 0)){
				listaAtencionClienteDTO.setCodError(config.getString("COD.ERR_SAC.0054"));
				listaAtencionClienteDTO.setDesError(config.getString("DES.ERR_SAC.0054"));
			}
		
		}catch (java.lang.Exception e){
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}finally{
			try{
				cerrarRecursos(conn, cstmt, rs);
			}catch (Exception e){
				logger.error("Exception [" + e.getMessage() + "]", e);
			}
		}
		logger.debug(MENSAJE_FIN_LOG);
		return listaAtencionClienteDTO;
	}

	/*
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008
	 * Requisito: RSis_010
	 * Caso de uso: CU-017 Registrar consulta de cliente/cuenta/abonado realizado por el usuario
	 * Developer: Gabriel Moraga L.
	 * Fecha: 13/07/2010
	 * Metodo: IngresoAtencion
	 * Return: ResulTransaccionDTO
	 * Descripcion: Inserta una gestion de atencion
	 * throws: PortalSACException
	 * 
	 */

	public ResulTransaccionDTO ingresoAtencion(ResgistroAtencionDTO resgistroAtencionDTO) throws PortalSACException{
		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		int codError = 0;
		int numEvento = 0;
		
		String msgError = null;
		final String nombrePL = "pv_ingreso_atencion_pr";
		ResulTransaccionDTO resulTransaccionDTO = null;
		
		try{

			logger.info(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();
			
			String call = daoHelper.getPackageBD(NOMBRE_PACKAGE_BD_ATENCION, nombrePL, 9);
			cstmt = conn.prepareCall(call);
			
			if(logger.isDebugEnabled()){
				logger.debug("SQL[" + call + "]");
			}
			/*
			java.sql.Date sqldateIni = null;
			java.sql.Date sqldateFin = null;
			
			try{
				//Cast java.util.Date to java.sql.Date
				sqldateIni = new java.sql.Date(resgistroAtencionDTO.getFechaIni().getTime());
				sqldateFin = new java.sql.Date(resgistroAtencionDTO.getFechaFin().getTime());
			}catch(ClassCastException cce){
				cce.printStackTrace();
			}
			*/
			//Datos de entrada
			cstmt.setString(1,resgistroAtencionDTO.getFechaIni()); //Fecha inicio
			cstmt.setString(2,resgistroAtencionDTO.getFechaFin()); //Fecha fin
			cstmt.setString(3,resgistroAtencionDTO.getNomUsua()); //Usuario
			cstmt.setLong(4,resgistroAtencionDTO.getNumAbonado()); //Numero abonado
			cstmt.setLong(5,resgistroAtencionDTO.getCodAtencion()); //Cod atencion
			cstmt.setString(6,resgistroAtencionDTO.getObservacion()); //Observacion
		
			//Datos de salida
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC); //Codigo retorno
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR); //Mensaje retorno
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC); //Numero de evento
			
			if(logger.isDebugEnabled()){
				logger.debug("Execute Antes");
			}
			
			cstmt.execute();
			
			if(logger.isDebugEnabled()){
				logger.debug("Execute Despues");
			}
			
			codError = cstmt.getInt(7);
			msgError = cstmt.getString(8);
			numEvento = cstmt.getInt(9);
			
			if(logger.isDebugEnabled()){
				logger.debug("codError[" + codError + "]");
				logger.debug("msgError[" + msgError + "]");
				logger.debug("numEvento[" + numEvento + "]");
			}
			
			//Se crea el objeto de retorno
			resulTransaccionDTO = new ResulTransaccionDTO();
		
			//set de lso datos de ejecucion del procedure
			resulTransaccionDTO.setCodRetorno(Long.valueOf(codError));
			resulTransaccionDTO.setMenRetorno(msgError);
			resulTransaccionDTO.setNumEvento(Long.valueOf(numEvento));
			
			/*
			if (0 != codError){
				throw new PortalSACException(String.valueOf(codError), msgError, numEvento);
			}
			*/
			
		}catch (java.lang.Exception e){		
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}finally{
			try{
				cerrarRecursos(conn, cstmt);
			}catch (Exception e){
				logger.error("Exception [" + e.getMessage() + "]", e);
			}
		}
		logger.debug(MENSAJE_FIN_LOG);
		return resulTransaccionDTO;
	}

	/*
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008
	 * Requisito: RSis_010
	 * Caso de uso: CU-017 Registrar consulta de cliente/cuenta/abonado realizado por el usuario 
	 * Developer: Gabriel Moraga L.
	 * Fecha: 13/07/2010
	 * Metodo: ObtenerListDatosAbonados
	 * Return: ListadoAbonadosDTO
	 * Descripcion: Obtiene los datos de de los abonados asociados a un cliente
	 * throws: PortalSACException
	 * 
	 */
	
	public ListadoAbonadosDTO obtenerListDatosAbonados(Long codCliente) throws PortalSACException{
		
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		int codError = 0;
		int numEvento = 0;
		
		String msgError = null;
		final String nombrePL = "PV_Consulta_Cliente_Pr";
		
		ListadoAbonadosDTO listadoAbonadosDTO = null;
		List<AbonadoDTO> listaAbonados = null;
		AbonadoDTO[] abonadoArrayDTO = null;
		AbonadoDTO abonadoDTO = null;

		try{
			
			logger.info(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();
			
			String call = daoHelper.getPackageBD(NOMBRE_PACKAGE_BD_ATENCION, nombrePL, 5);
			cstmt = conn.prepareCall(call);
			
			if(logger.isDebugEnabled()){
				logger.debug("SQL[" + call + "]");
				logger.debug("codCliente: " + codCliente);
			}
			
			//Datos de entrada
			cstmt.setLong(1, codCliente.longValue());
		
			//Datos de salida
			cstmt.registerOutParameter(2, OracleTypes.CURSOR); //Cursor con datos del cliente
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC); //Codigo retorno
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR); //Mensaje retorno
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC); //Numero de evento
			
			if(logger.isDebugEnabled()){
				logger.debug("Execute Antes");
			}
			
			cstmt.execute();
			
			if(logger.isDebugEnabled()){
				logger.debug("Execute Despues");
			}
			
			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			if(logger.isDebugEnabled()){
				logger.debug("codError[" + codError + "]");
				logger.debug("msgError[" + msgError + "]");
				logger.debug("numEvento[" + numEvento + "]");
			}
			if (0 != codError){
				throw new PortalSACException(String.valueOf(codError), msgError, numEvento);
			}

			rs = (ResultSet)cstmt.getObject(2);
			
			listaAbonados = new ArrayList<AbonadoDTO>();
			
			
			while(rs.next()){
				//Set de los datos del abonado
				abonadoDTO = new AbonadoDTO();
				abonadoDTO.setCodCliente(codCliente);
				abonadoDTO.setNumAbonado(rs.getLong(1));
				abonadoDTO.setNumCelular(rs.getLong(2));
				abonadoDTO.setNomUsuario(rs.getString(3));
				abonadoDTO.setApellidoPaterno(rs.getString(4));
				abonadoDTO.setApellidoMaterno(rs.getString(5));
				
				StringBuffer nomCompl =  new StringBuffer();
				nomCompl.append( null == cstmt.getString(3) ? "" : cstmt.getString(3) );
				nomCompl.append(" ");
				nomCompl.append( null == cstmt.getString(4) ? "" : cstmt.getString(4) );
				nomCompl.append(" ");
				nomCompl.append( null == cstmt.getString(5) ? "" : cstmt.getString(5) );
			
				abonadoDTO.setNomUsuario(nomCompl.toString());
				
				//Set de los datos abonados
				listaAbonados.add(abonadoDTO);
			}
			
			//Se inicializa el arreglo de abonadoArrayDTO
			abonadoArrayDTO = (AbonadoDTO[]) listaAbonados.toArray(new AbonadoDTO[listaAbonados.size()]);
			
			//Se crea el objeto de retorno
			listadoAbonadosDTO = new ListadoAbonadosDTO();
			
			listadoAbonadosDTO.setArrayAbonados(abonadoArrayDTO);

			if (abonadoArrayDTO == null || (abonadoArrayDTO != null && abonadoArrayDTO.length == 0)){
				listadoAbonadosDTO.setCodError(config.getString("COD.ERR_SAC.0057"));
				listadoAbonadosDTO.setDesError(config.getString("DES.ERR_SAC.0057"));
			}
			
		}catch (java.lang.Exception e){
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}finally{
			try{
				cerrarRecursos(conn, cstmt);
			}catch (Exception e){
				logger.error("Exception [" + e.getMessage() + "]", e);
			}
		}
		logger.debug(MENSAJE_FIN_LOG);
		return listadoAbonadosDTO;
	}
	
	/*
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008
	 * Requisito: RSis_010
	 * Caso de uso: CU-017 Registrar consulta de cliente/cuenta/abonado realizado por el usuario
	 * Developer: Gabriel Moraga L.
	 * Fecha: 13/07/2010
	 * Metodo: consultaCuenta
	 * Return: ListadoAbonadosDTO
	 * Descripcion: Obtiene los abonados asociados a una cuenta
	 * throws: PortalSACException
	 * 
	 */
	
	public ListadoAbonadosDTO consultaCuenta(Long codCuenta) throws PortalSACException{
		
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		int codError = 0;
		int numEvento = 0;
		
		String msgError = null;
		final String nombrePL = "PV_Consulta_Cuenta_Pr";
		
		ListadoAbonadosDTO listadoAbonadosDTO = null;
		List<AbonadoDTO> listaAbonados = null;
		AbonadoDTO[] abonadoArrayDTO = null;
		AbonadoDTO abonadoDTO = null;
		
		try{
			
			logger.info(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();
			
			String call = daoHelper.getPackageBD(NOMBRE_PACKAGE_BD_ATENCION, nombrePL, 5);
			cstmt = conn.prepareCall(call);
			
			if(logger.isDebugEnabled()){
				logger.debug("SQL[" + call + "]");
				logger.debug("codCuenta: " + codCuenta);
			}
			
			//Datos de entrada
			cstmt.setLong(1, codCuenta.longValue());
		
			//Datos de salida
			cstmt.registerOutParameter(2, OracleTypes.CURSOR); //Cursor de datos de atencion cliente
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC); //Codigo retorno
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR); //Mensaje retorno
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC); //Numero de evento
			
			if(logger.isDebugEnabled()){
				logger.debug("Execute Antes");
			}
			
			cstmt.execute();
			
			if(logger.isDebugEnabled()){
				logger.debug("Execute Despues");
			}
			
			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			if(logger.isDebugEnabled()){
				logger.debug("codError[" + codError + "]");
				logger.debug("msgError[" + msgError + "]");
				logger.debug("numEvento[" + numEvento + "]");
			}
			if (0 != codError){
				throw new PortalSACException(String.valueOf(codError), msgError, numEvento);
			}

			rs = (ResultSet) cstmt.getObject(2);

			//se inicializa el lista de abonados
			listaAbonados = new ArrayList<AbonadoDTO>();
			
			
			while(rs.next()){
				//Set de los datos del abonado
				abonadoDTO = new AbonadoDTO();
				abonadoDTO.setCodCuenta(codCuenta);
				abonadoDTO.setNumAbonado(rs.getLong(1));
				abonadoDTO.setNumCelular(rs.getLong(2));
				abonadoDTO.setNomUsuario(rs.getString(3));
				abonadoDTO.setApellidoPaterno(rs.getString(4));
				abonadoDTO.setApellidoMaterno(rs.getString(5));
				
				StringBuffer nomCompl =  new StringBuffer();
				nomCompl.append( null == cstmt.getString(3) ? "" : cstmt.getString(3) );
				nomCompl.append(" ");
				nomCompl.append( null == cstmt.getString(4) ? "" : cstmt.getString(4) );
				nomCompl.append(" ");
				nomCompl.append( null == cstmt.getString(5) ? "" : cstmt.getString(5) );
				
				abonadoDTO.setNomUsuario(nomCompl.toString());
				
				//Set de los datos abonados
				listaAbonados.add(abonadoDTO);
			}
			
			//Se inicializa el arreglo de abonadoArrayDTO
			abonadoArrayDTO = (AbonadoDTO[]) listaAbonados.toArray(new AbonadoDTO[listaAbonados.size()]);
			
			//Se crea el objeto de retorno
			listadoAbonadosDTO = new ListadoAbonadosDTO();
			
			listadoAbonadosDTO.setArrayAbonados(abonadoArrayDTO);

			if (abonadoArrayDTO == null || (abonadoArrayDTO != null && abonadoArrayDTO.length == 0)){
				listadoAbonadosDTO.setCodError(config.getString("COD.ERR_SAC.0058"));
				listadoAbonadosDTO.setDesError(config.getString("DES.ERR_SAC.0058"));
			}
		
		}catch (java.lang.Exception e){
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}finally{
			try{
				cerrarRecursos(conn, cstmt, rs);
			}catch (Exception e){
				logger.error("Exception [" + e.getMessage() + "]", e);
			}
		}
		logger.debug(MENSAJE_FIN_LOG);
		return listadoAbonadosDTO;
	}
	
}