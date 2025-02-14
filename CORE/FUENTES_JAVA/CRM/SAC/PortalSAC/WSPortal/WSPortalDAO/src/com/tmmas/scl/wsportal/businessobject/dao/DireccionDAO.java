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
import java.util.ArrayList;
import java.util.StringTokenizer;

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Logger;

import com.tmmas.scl.wsportal.businessobject.dao.base.BaseDAO;
import com.tmmas.scl.wsportal.common.dto.CampoDireccionDTO;
import com.tmmas.scl.wsportal.common.dto.CiudadDTO;
import com.tmmas.scl.wsportal.common.dto.ComunaDTO;
import com.tmmas.scl.wsportal.common.dto.DatosDireccionClienteINDTO;
import com.tmmas.scl.wsportal.common.dto.DetalleDireccionDTO;
import com.tmmas.scl.wsportal.common.dto.DireccionDTO;
import com.tmmas.scl.wsportal.common.dto.DireccionPorClienteDTO;
import com.tmmas.scl.wsportal.common.dto.EstadoDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoCamposDireccionDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoCiudadesDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoComunasDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoDireccionesDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoEstadosDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoProvinciasDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoPueblosDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoRegionesDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoTiposCalleDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoZipCodeDTO;
import com.tmmas.scl.wsportal.common.dto.ProvinciaDTO;
import com.tmmas.scl.wsportal.common.dto.PuebloDTO;
import com.tmmas.scl.wsportal.common.dto.RegionDTO;
import com.tmmas.scl.wsportal.common.dto.TipoCalleDTO;
import com.tmmas.scl.wsportal.common.dto.ValorCampoDireccionDTO;
import com.tmmas.scl.wsportal.common.dto.ZipCodeDTO;
import com.tmmas.scl.wsportal.common.exception.PortalSACException;

public class DireccionDAO extends BaseDAO
{

	private static Logger logger = Logger.getLogger(DireccionDAO.class);

	public DireccionDAO()
	{

	}

	/**
	 * Consulta el detalle de la direccion
	 * @param codDireccion, codTipDireccion
	 * @return {@link DetalleDireccionDTO}[]
	 * @throws {@link PortalSACException}
	 */
	public DetalleDireccionDTO getDetalleDireccion(Long codDireccion, String codTipDireccion) throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		DetalleDireccionDTO r = new DetalleDireccionDTO();

		try
		{
			logger.info(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();

			String call = daoHelper.getPackageBD("PV_CONSULTAS_PORTAL_PG", "PV_CONS_DIRECCION_DETALLE_PR", 6);
			cstmt = conn.prepareCall(call);

			logger.debug("SQL[" + call + "]");
			cstmt.setLong(1, codDireccion.longValue());
			logger.debug("codDireccion() : " + codDireccion);
			cstmt.setString(2, codTipDireccion.trim());
			logger.debug("codTipDireccion() : " + codTipDireccion);
			cstmt.registerOutParameter(3, OracleTypes.CURSOR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

			logger.debug("Execute Antes");
			cstmt.execute();
			logger.debug("Execute Despues");

			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);

			logger.debug("codError[" + codError + "]");
			logger.debug("msgError[" + msgError + "]");
			logger.debug("numEvento[" + numEvento + "]");

			if (codError != 0)
			{
				throw new PortalSACException(String.valueOf(codError), msgError, numEvento);
			}

			rs = (ResultSet) cstmt.getObject(3);
			if (rs.next())
			{
				r.setDesComuna(rs.getString(1));
				r.setDesCiudad(rs.getString(2));
				r.setDesProvincia(rs.getString(3));
				r.setDesRegion(rs.getString(4));
				r.setNomCalle(rs.getString(5));
				r.setNumCalle(rs.getString(6));
				r.setNumPiso(rs.getString(7));
				r.setZip(rs.getString(8));
				r.setObsDireccion(rs.getString(9));
				r.setCodComuna(rs.getString(10));
				r.setCodCiudad(rs.getString(11));
				r.setCodProvincia(rs.getString(12));
				r.setCodRegion(rs.getString(13));
				r.setObsDireccion2(rs.getString(14)); //Comentario 2 //Fecha: 04/08/2010 CU-003 Modificar OOSS Cambio de Direcciones de Clientes
				
			}
			else
			{
				r.setCodError(config.getString("COD.ERR_SAC.0015"));
				r.setDesError(config.getString("DES.ERR_SAC.0015"));
			}
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}
		finally
		{
			try
			{
				cerrarRecursos(conn, cstmt, rs);
			}
			catch (Exception e)
			{
				logger.error("Exception [" + e.getMessage() + "]", e);
			}
		}
		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/**
	 * permite obtener los campos que seran mostrados como direccion
	 * @return {@link ListadoCamposDireccionDTO}[]
	 * @throws {@link PortalSACException}
	 */
	public ListadoCamposDireccionDTO obtenerCamposDireccion() throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ListadoCamposDireccionDTO result = null;

		try
		{
			logger.info(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();

			String call = daoHelper.getPackageBD("PV_CONSULTAS_PORTAL_PG", "PV_OBTIENE_CAMPOS_DIR_PR", 4);
			cstmt = conn.prepareCall(call);

			logger.debug("SQL[" + call + "]");

			cstmt.registerOutParameter(1, OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);

			logger.debug("Execute Antes");
			cstmt.execute();
			logger.debug("Execute Despues");

			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);

			logger.debug("codError[" + codError + "]");
			logger.debug("msgError[" + msgError + "]");
			logger.debug("numEvento[" + numEvento + "]");

			if (codError != 0)
			{
				throw new PortalSACException(String.valueOf(codError), msgError, numEvento);
			}
			
			ArrayList campos = new ArrayList();
			
			CampoDireccionDTO campoDireccionDTO = null;
			
			rs = (ResultSet) cstmt.getObject(1);
			
			while (rs.next())
			{
				campoDireccionDTO = new CampoDireccionDTO();
				
				campoDireccionDTO.setCodParamDir(rs.getString(1));
				campoDireccionDTO.setTipDat(rs.getString(2));
				campoDireccionDTO.setSecDat(rs.getString(3));
				campoDireccionDTO.setCaption(rs.getString(4));
				campoDireccionDTO.setOrden(rs.getString(5));
				campoDireccionDTO.setLargo(rs.getString(6));
				campoDireccionDTO.setIndObligatorio(rs.getString(7));
				
				campos.add(campoDireccionDTO);
			}
			
			if (campos.size() == 0)
			{
				result = new ListadoCamposDireccionDTO();
				
				result.setCodError(config.getString("COD.ERR_SAC.0063"));
				result.setDesError(config.getString("DES.ERR_SAC.0063"));
				
			}else{
				
				result = new ListadoCamposDireccionDTO();
				
				CampoDireccionDTO[] camposDireccion = (CampoDireccionDTO[]) campos.toArray(new CampoDireccionDTO[campos.size()]);
				result.setArrayCampos(camposDireccion);
				
			}
			
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}
		finally
		{
			try
			{
				cerrarRecursos(conn, cstmt, rs);
			}
			catch (Exception e)
			{
				logger.error("Exception [" + e.getMessage() + "]", e);
			}
		}
		logger.info(MENSAJE_FIN_LOG);
		return result;
	}
	
	/**
	 * permite obtener los valores que seran mostrados como direccion para el cliente
	 * @param pIn
	 * @return {@link DireccionPorClienteDTO}[]
	 * @throws {@link PortalSACException}
	 */
	public DireccionPorClienteDTO obtenerDatosDireccionCliente(DatosDireccionClienteINDTO pIn) throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		DireccionPorClienteDTO result = null;

		try
		{
			logger.info(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();

			String call = daoHelper.getPackageBD("PV_CONSULTAS_PORTAL_PG", "PV_OBTIENE_DIR_POR_CLIENTE_PR", 8);
			cstmt = conn.prepareCall(call);

			logger.debug("SQL[" + call + "]");

			cstmt.setString(1, pIn.getCodCliente());
			logger.debug("codCliente : " + pIn.getCodCliente());
			
			cstmt.setInt(2, pIn.getTipSujeto());
			logger.debug("tipSujeto : " + pIn.getTipSujeto());
			
			cstmt.setInt(3, pIn.getCodTipDireccion());
			logger.debug("codTipDireccion : " + pIn.getCodTipDireccion());
			
			cstmt.setInt(4, pIn.getCodDisplay());
			logger.debug("codDisplay : " + pIn.getCodDisplay());
			
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);

			logger.debug("Execute Antes");
			cstmt.execute();
			logger.debug("Execute Despues");

			codError = cstmt.getInt(6);
			msgError = cstmt.getString(7);
			numEvento = cstmt.getInt(8);

			logger.debug("codError[" + codError + "]");
			logger.debug("msgError[" + msgError + "]");
			logger.debug("numEvento[" + numEvento + "]");

			if (codError != 0)
			{
				throw new PortalSACException(String.valueOf(codError), msgError, numEvento);
			}
			
			//se obtiene los datos de la direccion acompañado con el cod_paramdir al que pertenece
			String datosDireccion = cstmt.getString(5);
			
			logger.debug("datosDireccion: " + datosDireccion);
			
			ArrayList arrayDatosDireccion = convertirADatosDireccionArray(datosDireccion);
			
			if (arrayDatosDireccion.size() == 0)
			{
				result = new DireccionPorClienteDTO();
				
				result.setCodError(config.getString("COD.ERR_SAC.0064"));
				result.setDesError(config.getString("DES.ERR_SAC.0064"));
				
			}else{
				
				result = new DireccionPorClienteDTO();
				
				ValorCampoDireccionDTO[] listaDatosDireccion = (ValorCampoDireccionDTO[]) arrayDatosDireccion.toArray(new ValorCampoDireccionDTO[arrayDatosDireccion.size()]);
				result.setArrayValorCampos(listaDatosDireccion);
				
				
			}
			
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}
		finally
		{
			try
			{
				cerrarRecursos(conn, cstmt, rs);
			}
			catch (Exception e)
			{
				logger.error("Exception [" + e.getMessage() + "]", e);
			}
		}
		logger.info(MENSAJE_FIN_LOG);
		return result;
	}	
	
	/**
	 * permite retornar en base al String que contiene los datos de una direccion de cliente
	 * una ArrayList con ValorCampoDireccionDTO el cual contiene el par cod_paramdir y valor.
	 * @param datosDireccion
	 * @return
	 */
	private ArrayList convertirADatosDireccionArray(String datosDireccion) {

		ArrayList result = new ArrayList();
		
		if(datosDireccion == null ){
			
			return result;
		}
		
		if(datosDireccion.length() == 0){
			return result;
		}
		
       
		//separo con el StringTokenizer por punto y coma
		StringTokenizer stPuntoComa = new StringTokenizer(datosDireccion, ";");
		
		while(stPuntoComa.hasMoreTokens()){
			
			//dato contiene el par cod_paramdir y valor direccion separado por dos puntos
			String dato = stPuntoComa.nextToken(); 
			
			if(dato != null && dato.trim().length() > 0){
				
				StringTokenizer stDosPuntos = new StringTokenizer(dato, ":");
				
				if(stDosPuntos.hasMoreTokens()){
				
					String codParamDir = stDosPuntos.nextToken();
					logger.debug("codParamDir : " + codParamDir);
					
					if(codParamDir != null && codParamDir.length() > 0){
						
						ValorCampoDireccionDTO valorCampoDTO = new ValorCampoDireccionDTO();
						
						//asignar codParamDir al DTO
						valorCampoDTO.setCodParamDir(codParamDir); 
						
						//como existe un codParamDir busco su valor
						
						if(stDosPuntos.hasMoreTokens()){
							
							String valorCodParamDir = stDosPuntos.nextToken();
							logger.debug("valorCodParamDir : " + valorCodParamDir);
							
							if(valorCodParamDir != null){
								
								//asignar valor del codParamDir al DTO
								valorCampoDTO.setCodValor(valorCodParamDir);
							}
						}
						
						//agrego campo-valor al arreglo
						logger.debug("agregando campo-valor al arreglo ");
						result.add(valorCampoDTO);
					}
				}
			}
			
		}
		
		return result;
		
	}

	/**
	 * Consulta las direcciones de un cliente
	 * @param codCliente
	 * @return {@link ListadoDireccionesDTO}[]
	 * @throws {@link PortalSACException}
	 */
	public ListadoDireccionesDTO direccionesXCodCliente(Long codCliente) throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ListadoDireccionesDTO r = new ListadoDireccionesDTO();
		DireccionDTO[] direccionesDTO = null;

		try
		{
			logger.info(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();

			String call = daoHelper.getPackageBD("PV_CONSULTAS_PORTAL_PG", "PV_CONS_GRILLA_DIR_X_CLI_PR", 5);
			cstmt = conn.prepareCall(call);

			logger.debug("SQL[" + call + "]");
			cstmt.setLong(1, codCliente.longValue());
			logger.debug("codCliente : " + codCliente);
			cstmt.registerOutParameter(2, OracleTypes.CURSOR);
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

			if (codError != 0)
			{
				throw new PortalSACException(String.valueOf(codError), msgError, numEvento);
			}

			rs = (ResultSet) cstmt.getObject(2);

			ArrayList direcciones = new ArrayList();
			while (rs.next())
			{
				DireccionDTO direccion = new DireccionDTO();
				direccion.setCodTipDireccion(rs.getString(1));
				direccion.setDesTipDireccion(rs.getString(2));
				direccion.setCodDireccion(new Long(rs.getLong(3)));
				direcciones.add(direccion);
			}
			direccionesDTO = (DireccionDTO[]) direcciones.toArray(new DireccionDTO[direcciones.size()]);
			r.setArrayDirecciones(direccionesDTO);

			if (direccionesDTO == null || (direccionesDTO != null && direccionesDTO.length == 0))
			{
				r.setCodError(config.getString("COD.ERR_SAC.0016"));
				r.setDesError(config.getString("DES.ERR_SAC.0016"));
			}

		}
		catch (Exception e)
		{
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}
		finally
		{
			try
			{
				cerrarRecursos(conn, cstmt, rs);
			}
			catch (Exception e)
			{
				logger.error("Exception [" + e.getMessage() + "]", e);
			}
		}
		logger.info(MENSAJE_FIN_LOG);
		return r;
	}
	
	public ListadoRegionesDTO obtenerRegiones() throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ListadoRegionesDTO r = null;
		final String nombrePL = "GE_CONSREGION_PR";
		try
		{
			logger.debug(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();
			String call = daoHelper.getPackageBD(NOMBRE_PACKAGE_BD_CONSULTA_DIRECCIONES, nombrePL, 4);
			cstmt = conn.prepareCall(call);
			logger.debug("SQL [" + call + "]");
			cstmt.registerOutParameter(1, OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			logger.debug("Execute Antes");
			cstmt.execute();
			logger.debug("Execute Despues");
			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);
			logger.debug("codError[" + codError + "]");
			logger.debug("msgError[" + msgError + "]");
			logger.debug("numEvento[" + numEvento + "]");

			if (codError != 0)
			{
				throw new PortalSACException(String.valueOf(codError), msgError, numEvento);
			}

			rs = (ResultSet) cstmt.getObject(1);
			ArrayList a = new ArrayList();

			while (rs.next())
			{
				RegionDTO dto = new RegionDTO();
				dto.setCodRegion(rs.getString(1));
				dto.setDesRegion(rs.getString(2));
				a.add(dto);
			}
			r = new ListadoRegionesDTO();
			RegionDTO[] toArray = (RegionDTO[]) a.toArray(new RegionDTO[a.size()]);
			if (toArray == null || (toArray != null && toArray.length == 0))
			{
				r.setCodError(config.getString("COD.ERR_SAC.0045"));
				r.setDesError(config.getString("DES.ERR_SAC.0045"));
			}
			else
			{
				r.setArrayRegiones(toArray);
			}
		}
		catch (java.lang.Exception e)
		{
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}
		finally
		{
			try
			{
				cerrarRecursos(conn, cstmt, rs);
			}
			catch (Exception e)
			{
				logger.error("Exception [" + e.getMessage() + "]", e);
			}
		}
		logger.debug(MENSAJE_FIN_LOG);
		return r;
	}
	
	public ListadoProvinciasDTO obtenerProvincias(String codRegion) throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ListadoProvinciasDTO r = null;
		final String nombrePL = "GE_CONSPROVINCIA_PR";
		try
		{
			logger.debug(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();
			String call = daoHelper.getPackageBD(NOMBRE_PACKAGE_BD_CONSULTA_DIRECCIONES, nombrePL, 5);
			cstmt = conn.prepareCall(call);
			logger.debug("SQL [" + call + "]");
			
			cstmt.setString(1, codRegion);
			logger.debug("codRegion: " + codRegion);
			
			cstmt.registerOutParameter(2, OracleTypes.CURSOR);
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

			if (codError != 0)
			{
				throw new PortalSACException(String.valueOf(codError), msgError, numEvento);
			}

			rs = (ResultSet) cstmt.getObject(2);
			ArrayList a = new ArrayList();

			while (rs.next())
			{
				ProvinciaDTO dto = new ProvinciaDTO();
				dto.setCodProvincia(rs.getString(1));
				dto.setDesProvincia(rs.getString(2));
				a.add(dto);
			}
			r = new ListadoProvinciasDTO();
			ProvinciaDTO[] toArray = (ProvinciaDTO[]) a.toArray(new ProvinciaDTO[a.size()]);
			if (toArray == null || (toArray != null && toArray.length == 0))
			{
				r.setCodError(config.getString("COD.ERR_SAC.0046"));
				r.setDesError(config.getString("DES.ERR_SAC.0046"));
			}
			else
			{
				r.setArrayProvincias(toArray);
			}
		}
		catch (java.lang.Exception e)
		{
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}
		finally
		{
			try
			{
				cerrarRecursos(conn, cstmt, rs);
			}
			catch (Exception e)
			{
				logger.error("Exception [" + e.getMessage() + "]", e);
			}
		}
		logger.debug(MENSAJE_FIN_LOG);
		return r;
	}
	
	public ListadoComunasDTO obtenerComunas(String codRegion, String codProvincia, String codCiudad) throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ListadoComunasDTO r = null;
		final String nombrePL = "GE_CONSCOMUNA_PR";
		try
		{
			logger.debug(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();
			String call = daoHelper.getPackageBD(NOMBRE_PACKAGE_BD_CONSULTA_DIRECCIONES, nombrePL, 7);
			cstmt = conn.prepareCall(call);
			logger.debug("SQL [" + call + "]");
			
			cstmt.setString(1, codRegion);
			logger.debug("codRegion: " + codRegion);
			
			cstmt.setString(2, codProvincia);
			logger.debug("codProvincia: " + codProvincia);
			
			cstmt.setString(3, codCiudad);
			logger.debug("codCiudad: " + codCiudad);
			
			cstmt.registerOutParameter(4, OracleTypes.CURSOR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			logger.debug("Execute Antes");
			cstmt.execute();
			logger.debug("Execute Despues");
			codError = cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento = cstmt.getInt(7);
			logger.debug("codError[" + codError + "]");
			logger.debug("msgError[" + msgError + "]");
			logger.debug("numEvento[" + numEvento + "]");

			if (codError != 0)
			{
				throw new PortalSACException(String.valueOf(codError), msgError, numEvento);
			}

			rs = (ResultSet) cstmt.getObject(4);
			ArrayList a = new ArrayList();

			while (rs.next())
			{
				ComunaDTO dto = new ComunaDTO();
				dto.setCodComuna(rs.getString(1));
				dto.setDesComuna(rs.getString(2));
				a.add(dto);
			}
			r = new ListadoComunasDTO();
			ComunaDTO[] toArray = (ComunaDTO[]) a.toArray(new ComunaDTO[a.size()]);
			if (toArray == null || (toArray != null && toArray.length == 0))
			{
				r.setCodError(config.getString("COD.ERR_SAC.0047"));
				r.setDesError(config.getString("DES.ERR_SAC.0047"));
			}
			else
			{
				r.setArrayComunas(toArray);
			}
		}
		catch (java.lang.Exception e)
		{
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}
		finally
		{
			try
			{
				cerrarRecursos(conn, cstmt, rs);
			}
			catch (Exception e)
			{
				logger.error("Exception [" + e.getMessage() + "]", e);
			}
		}
		logger.debug(MENSAJE_FIN_LOG);
		return r;
	}
	
	public ListadoCiudadesDTO obtenerCiudades(String codRegion, String codProvincia) throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ListadoCiudadesDTO r = null;
		final String nombrePL = "GE_CONSCIUDAD_PR";
		try
		{
			logger.debug(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();
			String call = daoHelper.getPackageBD(NOMBRE_PACKAGE_BD_CONSULTA_DIRECCIONES, nombrePL, 6);
			cstmt = conn.prepareCall(call);
			logger.debug("SQL [" + call + "]");
			
			cstmt.setString(1, codRegion);
			logger.debug("codRegion: " + codRegion);
			
			cstmt.setString(2, codProvincia);
			logger.debug("codProvincia: " + codProvincia);
			
			cstmt.registerOutParameter(3, OracleTypes.CURSOR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			logger.debug("Execute Antes");
			cstmt.execute();
			logger.debug("Execute Despues");
			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);
			logger.debug("codError[" + codError + "]");
			logger.debug("msgError[" + msgError + "]");
			logger.debug("numEvento[" + numEvento + "]");

			if (codError != 0)
			{
				throw new PortalSACException(String.valueOf(codError), msgError, numEvento);
			}

			rs = (ResultSet) cstmt.getObject(3);
			ArrayList a = new ArrayList();

			while (rs.next())
			{
				CiudadDTO dto = new CiudadDTO();
				dto.setCodCiudad(rs.getString(1));
				dto.setDesCiudad(rs.getString(2));
				a.add(dto);
			}
			r = new ListadoCiudadesDTO();
			CiudadDTO[] toArray = (CiudadDTO[]) a.toArray(new CiudadDTO[a.size()]);
			if (toArray == null || (toArray != null && toArray.length == 0))
			{
				r.setCodError(config.getString("COD.ERR_SAC.0048"));
				r.setDesError(config.getString("DES.ERR_SAC.0048"));
			}
			else
			{
				r.setArrayCiudades(toArray);
			}
		}
		catch (java.lang.Exception e)
		{
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}
		finally
		{
			try
			{
				cerrarRecursos(conn, cstmt, rs);
			}
			catch (Exception e)
			{
				logger.error("Exception [" + e.getMessage() + "]", e);
			}
		}
		logger.debug(MENSAJE_FIN_LOG);
		return r;
	}
	
	public ListadoEstadosDTO obtenerEstados() throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ListadoEstadosDTO r = null;
		final String nombrePL = "PV_OBTIENE_ESTADOS_PR";
		try
		{
			logger.debug(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();
			String call = daoHelper.getPackageBD("Pv_Consultas_Portal_Pg", nombrePL, 4);
			cstmt = conn.prepareCall(call);
			logger.debug("SQL [" + call + "]");
			cstmt.registerOutParameter(1, OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			logger.debug("Execute Antes");
			cstmt.execute();
			logger.debug("Execute Despues");
			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);
			logger.debug("codError[" + codError + "]");
			logger.debug("msgError[" + msgError + "]");
			logger.debug("numEvento[" + numEvento + "]");

			if (codError != 0)
			{
				throw new PortalSACException(String.valueOf(codError), msgError, numEvento);
			}

			rs = (ResultSet) cstmt.getObject(1);
			ArrayList a = new ArrayList();

			while (rs.next())
			{
				EstadoDTO dto = new EstadoDTO();
				dto.setCodEstado(rs.getString(1));
				dto.setDesEstado(rs.getString(2));
				a.add(dto);
			}
			r = new ListadoEstadosDTO();
			EstadoDTO[] toArray = (EstadoDTO[]) a.toArray(new EstadoDTO[a.size()]);
			if (toArray == null || (toArray != null && toArray.length == 0))
			{
				r.setCodError(config.getString("COD.ERR_SAC.0065"));
				r.setDesError(config.getString("DES.ERR_SAC.0065"));
			}
			else
			{
				r.setArrayEstados(toArray);
			}
		}
		catch (java.lang.Exception e)
		{
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}
		finally
		{
			try
			{
				cerrarRecursos(conn, cstmt, rs);
			}
			catch (Exception e)
			{
				logger.error("Exception [" + e.getMessage() + "]", e);
			}
		}
		logger.debug(MENSAJE_FIN_LOG);
		return r;
	}
	
	public ListadoPueblosDTO obtenerPueblos(String codEstado) throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ListadoPueblosDTO r = null;
		final String nombrePL = "PV_OBTIENE_PUEBLO_POR_EST_PR";
		try
		{
			logger.debug(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();
			String call = daoHelper.getPackageBD("Pv_Consultas_Portal_Pg", nombrePL, 5);
			cstmt = conn.prepareCall(call);
			logger.debug("SQL [" + call + "]");
			
			cstmt.setString(1, codEstado);
			logger.debug("codEstado: " + codEstado);
			
			cstmt.registerOutParameter(2, OracleTypes.CURSOR);
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

			if (codError != 0)
			{
				throw new PortalSACException(String.valueOf(codError), msgError, numEvento);
			}

			rs = (ResultSet) cstmt.getObject(2);
			ArrayList a = new ArrayList();

			while (rs.next())
			{
				PuebloDTO dto = new PuebloDTO();
				dto.setCodPueblo(rs.getString(1));
				dto.setDesPueblo(rs.getString(2));
				a.add(dto);
			}
			r = new ListadoPueblosDTO();
			PuebloDTO[] toArray = (PuebloDTO[]) a.toArray(new PuebloDTO[a.size()]);
			if (toArray == null || (toArray != null && toArray.length == 0))
			{
				r.setCodError(config.getString("COD.ERR_SAC.0066"));
				r.setDesError(config.getString("DES.ERR_SAC.0066"));
			}
			else
			{
				r.setArrayPueblos(toArray);
			}
		}
		catch (java.lang.Exception e)
		{
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}
		finally
		{
			try
			{
				cerrarRecursos(conn, cstmt, rs);
			}
			catch (Exception e)
			{
				logger.error("Exception [" + e.getMessage() + "]", e);
			}
		}
		logger.debug(MENSAJE_FIN_LOG);
		return r;
	}
	
	public ListadoTiposCalleDTO obtenerTiposCalle() throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ListadoTiposCalleDTO r = null;
		final String nombrePL = "PV_OBTIENE_TIPO_CALLE_PR";
		try
		{
			logger.debug(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();
			String call = daoHelper.getPackageBD("Pv_Consultas_Portal_Pg", nombrePL, 4);
			cstmt = conn.prepareCall(call);
			logger.debug("SQL [" + call + "]");
			cstmt.registerOutParameter(1, OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			logger.debug("Execute Antes");
			cstmt.execute();
			logger.debug("Execute Despues");
			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);
			logger.debug("codError[" + codError + "]");
			logger.debug("msgError[" + msgError + "]");
			logger.debug("numEvento[" + numEvento + "]");

			if (codError != 0)
			{
				throw new PortalSACException(String.valueOf(codError), msgError, numEvento);
			}

			rs = (ResultSet) cstmt.getObject(1);
			ArrayList a = new ArrayList();

			while (rs.next())
			{
				TipoCalleDTO dto = new TipoCalleDTO();
				dto.setCodTipoCalle(rs.getString(1));
				dto.setDesTipoCalle(rs.getString(2));
				a.add(dto);
			}
			r = new ListadoTiposCalleDTO();
			TipoCalleDTO[] toArray = (TipoCalleDTO[]) a.toArray(new TipoCalleDTO[a.size()]);
			if (toArray == null || (toArray != null && toArray.length == 0))
			{
				r.setCodError(config.getString("COD.ERR_SAC.0067"));
				r.setDesError(config.getString("DES.ERR_SAC.0067"));
			}
			else
			{
				r.setArrayTiposCalle(toArray);
			}
		}
		catch (java.lang.Exception e)
		{
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}
		finally
		{
			try
			{
				cerrarRecursos(conn, cstmt, rs);
			}
			catch (Exception e)
			{
				logger.error("Exception [" + e.getMessage() + "]", e);
			}
		}
		logger.debug(MENSAJE_FIN_LOG);
		return r;
	}
	
	public ListadoZipCodeDTO obtenerZipCode(String codZone) throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ListadoZipCodeDTO r = null;
		final String nombrePL = "PV_OBTIENE_ZIP_CODE_PR";
		try
		{
			logger.debug(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();
			String call = daoHelper.getPackageBD("Pv_Consultas_Portal_Pg", nombrePL, 5);
			cstmt = conn.prepareCall(call);
			logger.debug("SQL [" + call + "]");
			cstmt.setString(1, codZone);
			cstmt.registerOutParameter(2, OracleTypes.CURSOR);
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

			if (codError != 0)
			{
				throw new PortalSACException(String.valueOf(codError), msgError, numEvento);
			}

			rs = (ResultSet) cstmt.getObject(2);
			ArrayList a = new ArrayList();

			while (rs.next())
			{
				ZipCodeDTO dto = new ZipCodeDTO();
				dto.setCodZip(rs.getString(1));
				a.add(dto);
			}
			r = new ListadoZipCodeDTO();
			ZipCodeDTO[] toArray = (ZipCodeDTO[]) a.toArray(new ZipCodeDTO[a.size()]);
			if (toArray == null || (toArray != null && toArray.length == 0))
			{
				r.setCodError(config.getString("COD.ERR_SAC.0068"));
				r.setDesError(config.getString("DES.ERR_SAC.0068"));
			}
			else
			{
				r.setArrayZipCode(toArray);
			}
		}
		catch (java.lang.Exception e)
		{
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}
		finally
		{
			try
			{
				cerrarRecursos(conn, cstmt, rs);
			}
			catch (Exception e)
			{
				logger.error("Exception [" + e.getMessage() + "]", e);
			}
		}
		logger.debug(MENSAJE_FIN_LOG);
		return r;
	}
	
	public String obtenerParametroZipCode() throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		String result = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		final String nombrePL = "PV_OBTIENE_PARAM_ZIP_CODE_PR";
		try
		{
			logger.debug(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();
			String call = daoHelper.getPackageBD("Pv_Consultas_Portal_Pg", nombrePL, 4);
			cstmt = conn.prepareCall(call);
			logger.debug("SQL [" + call + "]");
			cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			logger.debug("Execute Antes");
			cstmt.execute();
			logger.debug("Execute Despues");
			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);
			logger.debug("codError[" + codError + "]");
			logger.debug("msgError[" + msgError + "]");
			logger.debug("numEvento[" + numEvento + "]");

			if (codError != 0)
			{
				throw new PortalSACException(String.valueOf(codError), msgError, numEvento);
			}

			result = cstmt.getString(1);

		}
		catch (java.lang.Exception e)
		{
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}
		finally
		{
			try
			{
				cerrarRecursos(conn, cstmt);
			}
			catch (Exception e)
			{
				logger.error("Exception [" + e.getMessage() + "]", e);
			}
		}
		logger.debug(MENSAJE_FIN_LOG);
		return result;
	}
}
