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
 * 19/06/2007     H&eacute;ctor Hermosilla      					Versión Inicial
 */

package com.tmmas.cl.scl.gestiondedirecciones.businessobject.dao;

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
import com.tmmas.cl.scl.gestiondeabonados.businessobject.helper.Global;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.ConceptoDireccionDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.DireccionDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.DireccionNegocioDTO;



public class DireccionDAO extends ConnectionDAO{
	private final Logger logger = Logger.getLogger(DireccionDAO.class);

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
	
	private String getSql(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
        for (int n = 1; n <= paramCount; n++) {
            sb.append("?");
            if (n < paramCount) sb.append(",");
        }
        return sb.append(")}").toString();
	}
	
	/**
	 *Obtiene configuración de las direcciones en la operadora
	 * 
	 * @author Héctor Hermosilla 
	 * @param direccionDTO
	 * @return direccionDTO
	 * @throws GeneralException
	 */
	public DireccionDTO getConfiguracionDireccion(DireccionDTO direccionDTO) throws GeneralException{
		logger.debug("getConfiguracionDireccion:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ConceptoDireccionDTO[] resultado=null;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		logger.debug("Coneccion obtenida OK");
		try {
			
			//INI-01 (AL) String call = getSql("VE_servicios_direcciones_PG","VE_getListConfigDirecciones_PR",5);
			String call = getSql("VE_servicios_direc_Quiosco_PG","VE_getListConfigDirecciones_PR",5);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,direccionDTO.getCodigoOperadora());
			cstmt.registerOutParameter(2, OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			logger.debug("Execute Antes");
			cstmt.execute();
			logger.debug("Execute Despues");
			codError = cstmt.getInt(3);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(4);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(5);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0){
				logger.error("Ocurrió un error al actualizar direccion");
				throw new GeneralException(
						"Ocurrió un error al actualizar direccion", String
								.valueOf(codError), numEvento, msgError);				
			}else{
			ResultSet rs = (ResultSet) cstmt.getObject(2);
			ArrayList lista = new ArrayList();
			while (rs.next()) {
				ConceptoDireccionDTO conceptoDireccionDTO = new ConceptoDireccionDTO();
				conceptoDireccionDTO.setCodigoConcepto(rs.getInt(1));
				conceptoDireccionDTO.setTipoControl(rs.getString(2));
				conceptoDireccionDTO.setCaption(rs.getString(4));
				conceptoDireccionDTO.setNombreColumna(rs.getString(5));
				conceptoDireccionDTO.setPosicion(rs.getInt(7));
				conceptoDireccionDTO.setObligatoriedad(rs.getInt(8)== 1?true:false);
				conceptoDireccionDTO.setLargoMaximo(rs.getInt(9));
				lista.add(conceptoDireccionDTO);
			}
			rs.close();
			resultado =(ConceptoDireccionDTO[])ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), ConceptoDireccionDTO.class);
			direccionDTO.setConceptoDireccionDTOs(resultado);
			}
		} catch (GeneralException e){
			throw (e);			
		} catch (Exception e) {
			logger.error(global.errorgetListado(), e);
			throw new GeneralException("Ocurrio un error al obtener la configuración de la dirección", e);

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
		logger.debug("getConfiguracionDireccion():end");
		return direccionDTO;
	}//fin getConfiguracionDireccion

	/**
	 * Obtiene direccion
	 * @param entrada
	 * @return resultado
	 * @throws GeneralException
	 */
	public DireccionNegocioDTO getDireccion(DireccionNegocioDTO entrada) 
	throws GeneralException{
		logger.debug("Inicio:getDireccion");
		DireccionNegocioDTO resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt =null;
		logger.debug("Coneccion obtenida OK");
		try {
			//INI-01 (AL) String call = getSql("VE_servicios_direcciones_PG","VE_getDireccion_PR",21);
			String call = getSql("VE_servicios_direc_Quiosco_PG","VE_getDireccion_PR",21);
			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,entrada.getCodigoSujeto());
			logger.debug("entrada.getCodigoSujeto(): " + entrada.getCodigoSujeto());
			cstmt.setInt(2,entrada.getTipoSujeto());
			logger.debug("entrada.getTipoSujeto(): " + entrada.getTipoSujeto());
			cstmt.setInt(3,entrada.getTipoDireccion());
			logger.debug("entrada.getTipoDireccion(): " + entrada.getTipoDireccion());
			cstmt.setInt(4,entrada.getTipoDisplay());
			logger.debug("entrada.getTipoDisplay(): " + entrada.getTipoDisplay());
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
			
			cstmt.registerOutParameter(19,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(20,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(21,java.sql.Types.NUMERIC);
			
			logger.debug("Iniico:getDireccion:Execute");
			cstmt.execute();
			logger.debug("Fin:getDireccion:Execute");

			codError = cstmt.getInt(19);
			msgError = cstmt.getString(20);
			numEvento = cstmt.getInt(21);

			if (codError != 0) {
				logger.error("Ocurrió un error al obtener direccion");
				throw new GeneralException(
						"Ocurrió un error al obtener direccion", String
								.valueOf(codError), numEvento, msgError);
			}
			else{
				resultado =new DireccionNegocioDTO();
				resultado.setRegion(cstmt.getString(5));
				resultado.setProvincia(cstmt.getString(6));
				resultado.setCiudad(cstmt.getString(7));
				resultado.setComuna(cstmt.getString(8));
				resultado.setCalle(cstmt.getString(9));
				resultado.setNumero(cstmt.getString(10));
				resultado.setPiso(cstmt.getString(11));
				resultado.setCasilla(cstmt.getString(12));
				resultado.setObservacionDescripcion(cstmt.getString(13));
				resultado.setDescripcionDireccion1(cstmt.getString(14));
				resultado.setDescripcionDireccion2(cstmt.getString(15));
				resultado.setPueblo(cstmt.getString(16));
				resultado.setEstado(cstmt.getString(17));
				resultado.setZip(cstmt.getString(18));
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		}catch (GeneralException e) {
			logger.error("Ocurrió un error al obtener direccion",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw(e);
		}catch (Exception e) {
			logger.error("Ocurrió un error al obtener direccion",e);
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
		logger.debug("Fin:getDireccion()");
		return resultado;
	}//fin getDireccion
	
	/**
	 * Actualiza direccion
	 * @param entrada
	 * @return N/A
	 * @throws GeneralException
	 */
	public void updDireccion(DireccionNegocioDTO entrada) 
	throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:updDireccion");
			
			//INI-01 (AL) String call = getSql("VE_servicios_direcciones_PG","VE_updDireccion_PR",18);
			String call = getSql("VE_servicios_direc_Quiosco_PG","VE_updDireccion_PR",18);
			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			
			cstmt.setInt(1,Integer.parseInt(entrada.getCodigo()));
			cstmt.setString(2,entrada.getProvincia());
			cstmt.setString(3,entrada.getRegion());
			cstmt.setString(4,entrada.getCiudad());
			cstmt.setString(5,entrada.getComuna());
			cstmt.setString(6,entrada.getCalle());
			cstmt.setString(7,entrada.getNumero());
			cstmt.setString(8,entrada.getPiso());
			cstmt.setString(9,entrada.getCasilla());
			cstmt.setString(10,entrada.getObservacionDescripcion());
			cstmt.setString(11,entrada.getDescripcionDireccion1());
			cstmt.setString(12,entrada.getDescripcionDireccion2());
			cstmt.setString(13,entrada.getPueblo());
			cstmt.setString(14,entrada.getEstado());
			cstmt.setString(15,entrada.getZip());

			cstmt.registerOutParameter(16, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(18, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:updDireccion:execute");
			cstmt.execute();
			logger.debug("Fin:updDireccion:execute");
			
			codError = cstmt.getInt(16);
			msgError = cstmt.getString(17);
			numEvento = cstmt.getInt(18);

			if (codError !=0){
				logger.error("Ocurrió un error al actualizar direccion");
				throw new GeneralException(
						"Ocurrió un error al actualizar direccion", String
								.valueOf(codError), numEvento, msgError);
			}
			
		}catch (GeneralException e) {
			logger.error("Ocurrió un error al actualizar direccion",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw(e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al actualizar direccion",e);
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
		logger.debug("Fin:updDireccion()");
	}//fin updDireccion

	/**
	 * Obtiene direccion por codigo
	 * @param entrada
	 * @return resultado
	 * @throws GeneralException
	 */
	public DireccionNegocioDTO getDireccionCodigo(DireccionNegocioDTO entrada) 
	throws GeneralException{
		logger.debug("Inicio:getDireccionCodigo");
		DireccionNegocioDTO resultado = new DireccionNegocioDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt =null;
		logger.debug("Coneccion obtenida OK");
		try {
			//INI-01 (AL) String call = getSql("VE_servicios_direcciones_PG","VE_getDireccionCodigo_PR",18);
			String call = getSql("VE_servicios_direc_Quiosco_PG","VE_getDireccionCodigo_PR",18);
			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,entrada.getCodigo());
			
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
			
			cstmt.registerOutParameter(16,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(17,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(18,java.sql.Types.NUMERIC);
			
			logger.debug("Iniico:getDireccionCodigo:Execute");
			cstmt.execute();
			logger.debug("Fin:getDireccionCodigo:Execute");

			codError = cstmt.getInt(16);
			msgError = cstmt.getString(17);
			numEvento = cstmt.getInt(18);

			if (codError != 0) {
				logger.error("Ocurrió un error al obtener direccion por codigo");
				throw new GeneralException(
						"Ocurrió un error al obtener direccion por codigo", String
								.valueOf(codError), numEvento, msgError);
			}
			else{
				resultado.setProvincia(cstmt.getString(2));
				logger.debug("resultado.getProvincia:" + resultado.getProvincia());
				resultado.setRegion(cstmt.getString(3));
				logger.debug("resultado.getRegion:" + resultado.getRegion());
				resultado.setCiudad(cstmt.getString(4));
				logger.debug("resultado.getCiudad:" + resultado.getCiudad());
				resultado.setComuna(cstmt.getString(5));
				resultado.setCalle(cstmt.getString(6));
				resultado.setNumero(cstmt.getString(7));
				resultado.setPiso(cstmt.getString(8));
				resultado.setCasilla(cstmt.getString(9));
				resultado.setObservacionDescripcion(cstmt.getString(10));
				resultado.setDescripcionDireccion1(cstmt.getString(11));
				resultado.setDescripcionDireccion2(cstmt.getString(12));
				resultado.setPueblo(cstmt.getString(13));
				resultado.setEstado(cstmt.getString(14));
				resultado.setZip(cstmt.getString(15));
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		}catch (GeneralException e) {
			logger.error("Ocurrió un error al obtener direccion por codigo",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw(e);
		}catch (Exception e) {
			logger.error("Ocurrió un error al obtener direccion por codigo",e);
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
		logger.debug("Fin:getDireccionCodigo()");
		return resultado;
	}//fin getDireccionCodigo
	
	
	/**
	 * Inserta direccion
	 * @author Héctor Hermosilla
	 * @param entrada
	 * @return N/A
	 * @throws GeneralException
	 */
	public void setDireccion(DireccionNegocioDTO entrada) 
	throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:setDireccion");
			
			String call = getSql("VE_servicios_direcciones_PG","VE_inserta_direccion_PR",19);
			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			
			cstmt.setInt(1,Integer.parseInt(entrada.getCodigo()));
			logger.debug("entrada.codigo:" + entrada.getCodigo());
			cstmt.setString(2,entrada.getProvincia());
			logger.debug("entrada.provincia:" + entrada.getProvincia());
			cstmt.setString(3,entrada.getRegion());
			logger.debug("entrada.getRegion:" + entrada.getRegion());
			cstmt.setString(4,entrada.getCiudad());
			logger.debug("entrada.getCiudad:" + entrada.getCiudad());
			cstmt.setString(5,entrada.getComuna());
			logger.debug("entrada.getComuna:" + entrada.getComuna());
			cstmt.setString(6,entrada.getCalle());
			logger.debug("entrada.calle:" + entrada.getCalle());
			cstmt.setString(7,entrada.getNumero());
			logger.debug("entrada.numero:" + entrada.getNumero());
			cstmt.setString(8,entrada.getPiso());
			logger.debug("entrada.piso:" + entrada.getPiso());
			cstmt.setString(9,entrada.getCasilla());
			logger.debug("entrada.casilla:" + entrada.getCasilla());
			cstmt.setString(10,entrada.getObservacionDescripcion());
			logger.debug("entrada.observacionDescripcion:" + entrada.getObservacionDescripcion());
			cstmt.setString(11,entrada.getDescripcionDireccion1());
			logger.debug("entrada.descripcionDireccion1:" + entrada.getDescripcionDireccion1());
			cstmt.setString(12,entrada.getDescripcionDireccion2());
			logger.debug("entrada.descripcionDireccion2:" + entrada.getDescripcionDireccion2());
			cstmt.setString(13,entrada.getPueblo());
			logger.debug("entrada.pueblo:" + entrada.getPueblo());
			cstmt.setString(14,entrada.getEstado());
			logger.debug("entrada.estado:" + entrada.getEstado());
			cstmt.setString(15,entrada.getZip());
			logger.debug("entrada.zip:" + entrada.getZip());
			cstmt.setString(16,entrada.getTipoCalle()); //CSR-11002
			logger.debug("entrada.tipoCalle:" + entrada.getTipoCalle());
			
			cstmt.registerOutParameter(17, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(18, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(19, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:setDireccion:execute");
			cstmt.execute();
			logger.debug("Fin:setDireccion:execute");
			
			codError = cstmt.getInt(17);
			msgError = cstmt.getString(18);
			numEvento = cstmt.getInt(19);

			if (codError !=0){
				logger.error("Ocurrió un error al insertar la direccion");
				throw new GeneralException(
						"Ocurrió un error al insertar la direccion", String
								.valueOf(codError), numEvento, msgError);
			}
			
		}catch (GeneralException e) {
			logger.error("Ocurrió un error al insertar la direccion",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw(e);
		}catch (Exception e) {
			logger.error("Ocurrió un error al insertar la direccion",e);
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
		logger.debug("Fin:setDireccion");
	}//fin setDireccion
	
	/**
	 * elimina direccion
	 * @param entrada
	 * @return N/A
	 * @throws GeneralException
	 */
	public void eliminaDireccion(DireccionNegocioDTO entrada) 
	throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:eliminaDireccion");
			
			//INI-01 (AL) String call = getSql("VE_servicios_direcciones_PG","VE_delDireccion_PR",4);
			String call = getSql("VE_servicios_direc_Quiosco_PG","VE_delDireccion_PR",4);
			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			
			cstmt.setInt(1,Integer.parseInt(entrada.getCodigo()));
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:eliminaDireccion:execute");
			cstmt.execute();
			logger.debug("Fin:eliminaDireccion:execute");
			
			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);

			if (codError !=0){
				logger.error("Ocurrió un error al eliminar la direccion");
				throw new GeneralException(
						"Ocurrió un error al eliminar la direccion", String
								.valueOf(codError), numEvento, msgError);
			}
			
		}catch (GeneralException e) {
			logger.error("Ocurrió un error al eliminar la direccion",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw(e);
		}catch (Exception e) {
			logger.error("Ocurrió un error al eliminar la direccion",e);
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
		logger.debug("Fin:eliminaDireccion()");
	}//fin eliminaDireccion
	
	
	
	
}//fin class DireccionDAO


