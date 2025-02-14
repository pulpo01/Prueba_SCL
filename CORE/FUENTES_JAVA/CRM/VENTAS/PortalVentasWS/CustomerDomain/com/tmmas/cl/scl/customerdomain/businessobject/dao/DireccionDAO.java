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

package com.tmmas.cl.scl.customerdomain.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.scl.commonbusinessentities.commonapp.DireccionNegocioDTO;
import com.tmmas.cl.scl.commonbusinessentities.commonapp.DireccionNegocioWebDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ConceptoDireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.DatosConexionServidorDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.DatosDireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.DireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.FormularioDireccionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.helper.Global;
import com.tmmas.cl.scl.direccioncommon.commonapp.dto.DirecClienteDTO;
import com.tmmas.cl.scl.direccioncommon.commonapp.dto.DireccionOutDTO;
import com.tmmas.cl.scl.direccioncommon.commonapp.dto.DireccionesListOutDTO;


public class DireccionDAO extends ConnectionDAO{
	private static Category cat = Category.getInstance(DireccionDAO.class);

	Global global = Global.getInstance();
	
	private Connection getConection() throws CustomerDomainException
	{
		Connection conn = null;
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
		} catch (Exception e1) {
			conn = null;
			cat.error(" No se pudo obtener una conexión ", e1);
			throw new CustomerDomainException("No se pudo obtener una conexión", e1);
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
	 * @throws CustomerDomainException
	 */
	public DireccionDTO getConfiguracionDireccion(DireccionDTO direccionDTO) 
		throws CustomerDomainException
	{
		cat.debug("getConfiguracionDireccion:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ConceptoDireccionDTO[] resultado=null;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		ResultSet rs = null;
		cat.debug("Coneccion obtenida OK");
		try {
			
			String call = getSql("VE_servicios_direcciones_PG","VE_getListConfigDirecciones_PR",5);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,direccionDTO.getCodigoOperadora());
			cstmt.registerOutParameter(2, OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cat.debug("Execute Antes");
			cstmt.execute();
			cat.debug("Execute Despues");
			codError = cstmt.getInt(3);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(4);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(5);
			cat.debug("numEvento[" + numEvento + "]");
			
			rs = (ResultSet) cstmt.getObject(2);
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
			resultado =(ConceptoDireccionDTO[])ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), ConceptoDireccionDTO.class);
			direccionDTO.setConceptoDireccionDTOs(resultado);
			
		} catch (Exception e) {
			cat.error(global.errorgetListado(), e);
			throw new CustomerDomainException("Ocurrio un error al obtener la configuración de la dirección", e);

		 } finally {
		 	if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (rs!=null)
					rs.close();
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("getConfiguracionDireccion():end");
		return direccionDTO;
	}//fin getConfiguracionDireccion

	/**
	 * Obtiene direccion
	 * @param entrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public DireccionNegocioDTO getDireccion(DireccionNegocioDTO entrada) 
		throws CustomerDomainException
	{
		cat.debug("Inicio:getDireccion");
		DireccionNegocioDTO resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt =null;
		cat.debug("Coneccion obtenida OK");
		try {
			String call = getSql("VE_servicios_direcciones_PG","VE_getDireccion_PR",22);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,entrada.getCodigoSujeto());
			cat.debug("entrada.getCodigoSujeto(): " + entrada.getCodigoSujeto());
			cstmt.setInt(2,entrada.getTipoSujeto());
			cat.debug("entrada.getTipoSujeto(): " + entrada.getTipoSujeto());
			cstmt.setInt(3,entrada.getTipoDireccion());
			cat.debug("entrada.getTipoDireccion(): " + entrada.getTipoDireccion());
			cstmt.setInt(4,entrada.getTipoDisplay());
			cat.debug("entrada.getTipoDisplay(): " + entrada.getTipoDisplay());
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
			
			cstmt.registerOutParameter(20,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(21,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(22,java.sql.Types.NUMERIC);
			
			cat.debug("Iniico:getDireccion:Execute");
			cstmt.execute();
			cat.debug("Fin:getDireccion:Execute");

			codError = cstmt.getInt(20);
			msgError = cstmt.getString(21);
			numEvento = cstmt.getInt(22);

			if (codError != 0) {
				cat.error("Ocurrió un error al obtener direccion");
				throw new CustomerDomainException(
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
				resultado.setTipoCalle(cstmt.getString(19));
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} 
		catch (Exception e) {
			cat.error("Ocurrió un error al obtener direccion",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
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
		cat.debug("Fin:getDireccion()");
		return resultado;
	}//fin getDireccion
	
	/**
	 * Actualiza direccion
	 * @param entrada
	 * @return N/A
	 * @throws CustomerDomainException
	 */
	public void updDireccion(DireccionNegocioDTO entrada) 
		throws CustomerDomainException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:updDireccion");
			
			String call = getSql("VE_servicios_direcciones_PG","VE_updDireccion_PR",19);
			cat.debug("sql[" + call + "]");

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
			cstmt.setString(16,entrada.getTipoCalle());

			cstmt.registerOutParameter(17, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(18, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(19, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:updDireccion:execute");
			cstmt.execute();
			cat.debug("Fin:updDireccion:execute");
			
			codError = cstmt.getInt(17);
			msgError = cstmt.getString(18);
			numEvento = cstmt.getInt(19);

			if (codError !=0){
				cat.error("Ocurrió un error al actualizar direccion");
				throw new CustomerDomainException(
						"Ocurrió un error al actualizar direccion", String
								.valueOf(codError), numEvento, msgError);
			}
			
		} catch (Exception e) {
			cat.error("Ocurrió un error al actualizar direccion",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
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
		cat.debug("Fin:updDireccion()");
	}//fin updDireccion

	/**
	 * Obtiene direccion por codigo
	 * @param entrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public DireccionNegocioDTO getDireccionCodigo(DireccionNegocioDTO entrada) 
		throws CustomerDomainException
	{
		cat.debug("Inicio:getDireccionCodigo");
		DireccionNegocioDTO resultado = new DireccionNegocioDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt =null;
		cat.debug("Coneccion obtenida OK");
		try {
			String call = getSql("VE_servicios_direcciones_PG","VE_getDireccionCodigo_PR",19);
			cat.debug("sql[" + call + "]");

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
			cstmt.registerOutParameter(16,java.sql.Types.VARCHAR);
			
			cstmt.registerOutParameter(17,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(18,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(19,java.sql.Types.NUMERIC);
			
			cat.debug("Iniico:getDireccionCodigo:Execute");
			cstmt.execute();
			cat.debug("Fin:getDireccionCodigo:Execute");

			codError = cstmt.getInt(17);
			msgError = cstmt.getString(18);
			numEvento = cstmt.getInt(19);

			if (codError != 0) {
				cat.error("Ocurrió un error al obtener direccion por codigo");
				throw new CustomerDomainException(
						"Ocurrió un error al obtener direccion por codigo", String
								.valueOf(codError), numEvento, msgError);
			}
			else{
				resultado.setProvincia(cstmt.getString(2));
				cat.debug("resultado.getProvincia:" + resultado.getProvincia());
				resultado.setRegion(cstmt.getString(3));
				cat.debug("resultado.getRegion:" + resultado.getRegion());
				resultado.setCiudad(cstmt.getString(4));
				cat.debug("resultado.getCiudad:" + resultado.getCiudad());
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
				resultado.setTipoCalle(cstmt.getString(16));
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} 
		catch (Exception e) {
			cat.error("Ocurrió un error al obtener direccion por codigo",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
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
		cat.debug("Fin:getDireccionCodigo()");
		return resultado;
	}//fin getDireccionCodigo
	
	
	/**
	 * Inserta direccion
	 * 
	 * @author Héctor Hermosilla
	 * @param entrada
	 * @return N/A
	 * @throws CustomerDomainException
	 */
	public void setDireccion(DireccionNegocioWebDTO entrada) throws CustomerDomainException {
		// EN_cod_direccion IN NUMBER,
		// EV_cod_provincia IN VARCHAR2,
		// EV_cod_region IN VARCHAR2,
		// EV_cod_ciudad IN VARCHAR2,
		// EV_cod_comuna IN VARCHAR2,
		// EV_nom_calle IN VARCHAR2,
		// EV_num_calle IN VARCHAR2,
		// EV_num_piso IN VARCHAR2,
		// EV_num_casilla IN VARCHAR2,
		// EV_obs_direccion IN VARCHAR2,
		// EV_des_direc1 IN VARCHAR2,
		// EV_des_direc2 IN VARCHAR2,
		// EV_cod_pueblo IN VARCHAR2,
		// EV_cod_estado IN VARCHAR2,
		// EV_zip IN VARCHAR2,

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			cat.debug("Inicio:setDireccion");

			String call = getSql("VE_servicios_direcciones_PG", "VE_inserta_direccion_PR", 19);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setInt(1, Integer.parseInt(entrada.getCodigo()));

			cstmt.setString(2, entrada.getCodMunicipio());
			cat.debug("entrada.provincia/municipio:" + entrada.getCodMunicipio()); // cod_provincia

			cstmt.setString(3, entrada.getCodDepartamento());
			cat.debug("entrada.getRegion/departamento:" + entrada.getCodDepartamento()); // cod_region

			cstmt.setString(4, entrada.getCodZonaDistrito());
			cat.debug("entrada.getCodZonaDistrito()/Ciudad:" + entrada.getCodZonaDistrito()); // cod_ciudad

			//Incidencia 134089: setear el valor de comuna (Loc/Barrio) 
			cstmt.setString(5, entrada.getLocBarrio());
			cat.debug("entrada.getComuna/(Loc/Barrio): " + entrada.getLocBarrio());

			cstmt.setString(6, entrada.getNombreCalle());
			cstmt.setString(7, entrada.getNumeroCalle());
			cstmt.setString(8, null);
			cstmt.setString(9, null);
			cstmt.setString(10, entrada.getObservacionDireccion());
			
			//Incidencia 134089: setear el valor de comuna (Loc/Barrio)
			cstmt.setString(11, entrada.getDesDirec1()); //EV_des_direc1
			cat.debug("entrada.getDesDirec1()/Colonia: " + entrada.getDesDirec1());
			cstmt.setString(12, entrada.getDesDirec2()); //EV_des_direc2
			cat.debug("entrada.getDesDirec2()/Direccion 2: " + entrada.getDesDirec2());
			
			cstmt.setString(13, null);
			cstmt.setString(14, null);
			cstmt.setString(15, entrada.getCodigoPostalDireccion());
			cstmt.setString(16, entrada.getCodSiglaDomicilio());

			cstmt.registerOutParameter(17, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(18, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(19, java.sql.Types.NUMERIC);

			cat.debug("Inicio:setDireccion:execute");
			cstmt.execute();
			cat.debug("Fin:setDireccion:execute");

			codError = cstmt.getInt(17);
			msgError = cstmt.getString(18);
			numEvento = cstmt.getInt(19);

			if (codError != 0) {
				cat.error("Ocurrió un error al insertar la direccion");
				throw new CustomerDomainException("Ocurrió un error al insertar la direccion",
						String.valueOf(codError), numEvento, msgError);
			}

		}
		catch (Exception e) {
			cat.error("Ocurrió un error al insertar la direccion", e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally {
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:setDireccion");
	}// fin setDireccion
	
	
	
	public DireccionesListOutDTO lstDirecCliente(DirecClienteDTO entrada)
		throws CustomerDomainException 
	{	
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		DireccionesListOutDTO resultado=new DireccionesListOutDTO();
		DireccionOutDTO[] direccionesList;
		ResultSet rs = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		cat.debug("Coneccion obtenida OK");
		try {
			
			String call = getSql("Ve_Servs_ActivacionesWeb_Pg","VE_getListDirCliente_PR",5);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,String.valueOf(entrada.getcodCliente()));
			cstmt.registerOutParameter(2, OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			cat.debug("Execute Antes");
			cstmt.execute();
			cat.debug("Execute Despues");
			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			cat.debug("codError[" + codError + "]");
			cat.debug("msgError[" + msgError + "]");
			cat.debug("numEvento[" + numEvento + "]");

			
		    if (codError!=0) {
				throw new CustomerDomainException(
					      " Ocurrió un error al recuperar listado de direcciones:", String
					        .valueOf(codError), numEvento, msgError);
		    }
		    else {
		    	cat.debug("Recuperando listado de direcciones");
				ArrayList lista = new ArrayList();
				rs =  (ResultSet) cstmt.getObject(2);
				while (rs.next()) {
					DireccionOutDTO direccion = new DireccionOutDTO();
					direccion.setCod_tipdireccion(rs.getString(1));
					direccion.setDes_tipdireccion(rs.getString(2));
					direccion.setCod_provincia(rs.getString(3));
					direccion.setDes_provincia(rs.getString(4));
					direccion.setCod_ciudad(rs.getString(5));
					direccion.setDes_ciudad(rs.getString(6));
					direccion.setDireccion(rs.getString(9));
					direccion.setObservacion(rs.getString(10));	
					direccion.setCod_region(rs.getString(11));
					direccion.setDes_region(rs.getString(12));
					direccion.setCod_comuna(rs.getString(13));
					direccion.setDes_comuna(rs.getString(14));
					direccion.setCod_tipoCalle(rs.getString(15));
					direccion.setDes_tipoCalle(rs.getString(16));
					lista.add(direccion);
				}
				rs.close();
				direccionesList =(DireccionOutDTO[])ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), DireccionOutDTO.class);
				resultado.setallDireccionOutDTO(direccionesList);
				cat.debug("Fin recuperacion de listado de direcciones");
		    }	   	
		} 
		catch (Exception e) {
			   cat.error("Ocurrió un error al obtener listado de articulos",e);
			   if (cat.isDebugEnabled()) {
			    cat.debug("Codigo de Error[" + codError + "]");
			    cat.debug("Mensaje de Error[" + msgError + "]");
			    cat.debug("Numero de Evento[" + numEvento + "]");
			   }
			   if (e instanceof CustomerDomainException){
				  throw (CustomerDomainException) e;
			   }
		} 
		finally {
		 	if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (rs != null) {
					rs.close();
				}
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("lstDirecCliente():end");		
		return resultado;
	}
	
	/**
	 * Obtiene cadena para llamada a servicio Computec
	 * @param entrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public DatosDireccionDTO getCadenaLLamadaComputec() 
	throws CustomerDomainException{
		cat.debug("Inicio:getCadenaLLamadaComputec");
		DatosDireccionDTO resultado = new DatosDireccionDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt =null;
		cat.debug("Coneccion obtenida OK");
		try {
			String call = getSql("VE_alta_cliente_PG","VE_getStrComputec_PR",4);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			
			cstmt.registerOutParameter(1,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(2,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getCadenaLLamadaComputec:Execute");
			cstmt.execute();
			cat.debug("Fin:getCadenaLLamadaComputec:Execute");

			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);

			if (codError != 0) {
				cat.error("Ocurrió un error al obtener cadena de llamada a computec");
				throw new CustomerDomainException(
						"Ocurrió un error al obtener cadena de llamada a computec", String
								.valueOf(codError), numEvento, msgError);
			}
			else{
				resultado.setDescripcion(cstmt.getString(1));
			}
		} 
		catch (Exception e) {
			cat.error("Ocurrió un error cadena de llamada a computec",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException){
				throw (CustomerDomainException) e; 	
			}
		} 
		finally {
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
		cat.debug("Fin:getCadenaLLamadaComputec()");
		return resultado;
	}//fin getCadenaLLamadaComputec
	
	
	/**
	 * Obtiene los datos para conectarse al servidor de  Computec
	 * @param entrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public DatosConexionServidorDTO getDatosConexionComputec() 
		throws CustomerDomainException
	{
		cat.debug("Inicio:getDatosConexionComputec");
		DatosConexionServidorDTO resultado = new DatosConexionServidorDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt =null;
		cat.debug("Coneccion obtenida OK");
		try {
			String call = getSql("VE_alta_cliente_PG","ve_obtieneippuerto_pr",6);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.registerOutParameter(1,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(2,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6,java.sql.Types.NUMERIC);
			
			cat.debug("Iniico:getDatosConexionComputec:Execute");
			cstmt.execute();
			cat.debug("Fin:getDatosConexionComputec:Execute");

			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);

			if (codError != 0) {
				cat.error("Ocurrió un error al obtener datos de conexion a computec");
				throw new CustomerDomainException(
						"Ocurrió un error al obtener datos de conexion a computec", String
								.valueOf(codError), numEvento, msgError);
			}
			else{
				resultado.setNombreIPServidor(cstmt.getString(1));
				resultado.setPuerto(cstmt.getString(2));
				resultado.setCodigoRegistroDireccion(Integer.toString(cstmt.getInt(3)));
			}
		} 
		catch (Exception e) {
			cat.error("Ocurrió un error al obtener datos de conexion a computec ",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException){
				throw (CustomerDomainException) e; 	
			}
		} 
		finally {
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
		cat.debug("Fin:getDatosConexionComputec()");
		return resultado;
	}//fin getDatosConexionComputec

	
	/**
	 * Valida si la última fecha de modificación al día de hoy es mayor 
	 * que la fecha de vigencia que son 30 dias 
	 * @param entrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public DatosDireccionDTO validaFechaUsoComputec () 
		throws CustomerDomainException
	{
		cat.debug("Inicio:validaFechaUsoComputec");
		DatosDireccionDTO resultado = new DatosDireccionDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt =null;
		cat.debug("Coneccion obtenida OK");
		try {
			String call = getSql("VE_alta_cliente_PG","VE_FechaVigencia_PR",6);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			

			cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6,java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:validaFechaUsoComputec:Execute");
			cstmt.execute();
			cat.debug("Fin:validaFechaUsoComputec:Execute");

			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);

			if (codError != 0) {
				cat.error("Ocurrió un error al validar fecha de uso computec");
				throw new CustomerDomainException(
						"Ocurrió un error al obtener cadena de llamada a computec", String
								.valueOf(codError), numEvento, msgError);
			}
			else{
				resultado.setDescripcion(cstmt.getString(1));
				resultado.setDescripcion(cstmt.getString(2));
				resultado.setDescripcion(cstmt.getString(3));
			}
			
		} 
		catch (Exception e) {
			cat.error("Ocurrió un error cadena de llamada a computec",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException){
				throw (CustomerDomainException) e; 	
			}
		} 
		finally {
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
		cat.debug("Fin:validaFechaUsoComputec()");
		return resultado;
	}//fin validaFechaUsoComputec
	/**
	 * Valida direccion contra SCL
	 * @author MTI
	 * @param entrada
	 * @return N/A
	 * @throws CustomerDomainException
	*/
	
	public void validaDireccion (DireccionNegocioDTO entrada) 
		throws CustomerDomainException 
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:validaDireccion");
			
			String call = getSql("Ve_Servs_ActivacionesWeb_Pg","ve_valida_direccion_pr",7);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,entrada.getRegion());
			cat.debug("entrada.getRegion:" + entrada.getRegion());
			cstmt.setString(2,entrada.getProvincia());
			cat.debug("entrada.getProvincia:" + entrada.getProvincia());
			cstmt.setString(3,entrada.getCiudad());
			cat.debug("entrada.getCiudad:" + entrada.getCiudad());
			cstmt.setString(4,entrada.getComuna());
			cat.debug("entrada.getComuna:" + entrada.getComuna());

			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:validaDireccion:execute");
			cstmt.execute();
			cat.debug("Fin:validaDireccion:execute");
			
			codError = cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento = cstmt.getInt(7);

			if (codError!=0){
				cat.error("Ocurrió un error al validar la direccion");
				throw new CustomerDomainException(
						"Ocurrió un error al validar la direccion", String
								.valueOf(codError), numEvento, msgError);
			}
			
		} 
		catch (Exception e) {
			cat.error("Ocurrió un error al validar la direccion",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException ) throw (CustomerDomainException) e;			
		} 
		finally {
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
		cat.debug("Fin:validaDireccion");
	}//fin validaDireccion
	
	//Inicio P-CSR-11002 JLGN 28-04-2011
	
	/**
	 * Obtiene datos de direccion prepago defecto
	 * @param entrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public FormularioDireccionDTO getDireccionPrepago(String codDireccion) throws CustomerDomainException{
		cat.debug("Inicio:getDireccionPrepago");
		FormularioDireccionDTO resultado = new FormularioDireccionDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt =null;
		ResultSet rs = null;
		cat.debug("Coneccion obtenida OK");
		try {
			String call = getSql("VE_alta_cliente_PG","VE_getListDirecPre_PR",5);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			
			cat.debug("Codigo Direccion: "+ codDireccion);
			cstmt.setLong(1,Long.parseLong(codDireccion));			
			cstmt.registerOutParameter(2, OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getDireccionPrepago:Execute");
			cstmt.execute();
			cat.debug("Fin:getDireccionPrepago:Execute");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			cat.debug("Codigo Error: "+codError);
			cat.debug("Mensaje Error: "+msgError);
			cat.debug("Numero Error: "+numEvento);

			if (codError != 0) {
				cat.error("Ocurrió un error al obtener Direccion Prepago por defecto");
				throw new CustomerDomainException(
						"Ocurrió un error al obtener Direccion Prepago por defecto", String
								.valueOf(codError), numEvento, msgError);
			}			
			rs = (ResultSet) cstmt.getObject(2);
			while (rs.next()) {
				if(rs.getString(1) != null){ 
					resultado.setCOD_REGION(rs.getString(1));
				}else{
					resultado.setCOD_REGION("");
				}
				cat.debug("resultado.getCOD_REGION(): "+resultado.getCOD_REGION());
				if(rs.getString(2) != null){ 
					resultado.setCOD_PROVINCIA(rs.getString(2));
				}else{
					resultado.setCOD_PROVINCIA("");
				}
				cat.debug("resultado.getCOD_PROVINCIA(): "+resultado.getCOD_PROVINCIA());
				if(rs.getString(3) != null){ 
					resultado.setCOD_CIUDAD(rs.getString(3));
				}else{
					resultado.setCOD_CIUDAD("");
				}
				cat.debug("resultado.getCOD_CIUDAD(): "+resultado.getCOD_CIUDAD());
				if(rs.getString(4) != null){ 
					resultado.setCOD_COMUNA(rs.getString(4));
				}else{
					resultado.setCOD_COMUNA("");
				}
				cat.debug("resultado.getCOD_COMUNA(): "+resultado.getCOD_COMUNA());
				if(rs.getString(5) != null){ 
					resultado.setCOD_TIPOCALLE(rs.getString(5));
				}else{
					resultado.setCOD_TIPOCALLE("");
				}
				cat.debug("resultado.getCOD_TIPOCALLE(): "+resultado.getCOD_TIPOCALLE());
				if(rs.getString(6) != null){ 
					resultado.setNOM_CALLE(rs.getString(6));
				}else{
					resultado.setNOM_CALLE("");
				}
				cat.debug("resultado.getNOM_CALLE(): "+resultado.getNOM_CALLE());
				if(rs.getString(7) != null){ 
					resultado.setNUM_CALLE(rs.getString(7));
				}else{
					resultado.setNUM_CALLE("");
				}
				cat.debug("resultado.getNUM_CALLE(): "+resultado.getNUM_CALLE());
				if(rs.getString(8) != null){ 
					resultado.setOBS_DIRECCION(rs.getString(8));
				}else{
					resultado.setOBS_DIRECCION("");
				}
				cat.debug("resultado.getOBS_DIRECCION(): "+resultado.getOBS_DIRECCION());
				if(rs.getString(9) != null){ 
					resultado.setZIP(rs.getString(9));
				}else{
					resultado.setZIP("");
				}
				cat.debug("resultado.getZIP(): "+resultado.getZIP());
				if(rs.getString(10) != null){ 
					resultado.setDES_DIREC1(rs.getString(10));
				}else{
					resultado.setDES_DIREC1("");
				}
				cat.debug("resultado.getDES_DIREC1(): "+resultado.getDES_DIREC1());
				if(rs.getString(11) != null){ 
					resultado.setDES_DIREC2(rs.getString(11));
				}else{
					resultado.setDES_DIREC2("");
				}
				cat.debug("resultado.getDES_DIREC2(): "+resultado.getDES_DIREC2());
				if(rs.getString(12) != null){ 
					resultado.setDescripcionCOD_REGION(rs.getString(12));
				}else{
					resultado.setDescripcionCOD_REGION("");
				}
				cat.debug("resultado.getDescripcionCOD_REGION(): "+resultado.getDescripcionCOD_REGION());
				if(rs.getString(13) != null){ 
					resultado.setDescripcionCOD_PROVINCIA(rs.getString(13));
				}else{
					resultado.setDescripcionCOD_PROVINCIA("");
				}
				cat.debug("resultado.getDescripcionCOD_PROVINCIA(): "+resultado.getDescripcionCOD_PROVINCIA());
				if(rs.getString(14) != null){ 
					resultado.setDescripcionCOD_CIUDAD(rs.getString(14));
				}else{
					resultado.setDescripcionCOD_CIUDAD("");
				}
				cat.debug("resultado.getDescripcionCOD_CIUDAD(): "+resultado.getDescripcionCOD_CIUDAD());
				if(rs.getString(15) != null){ 
					resultado.setDescripcionCOD_COMUNA(rs.getString(15));
				}else{
					resultado.setDescripcionCOD_COMUNA("");
				}
				cat.debug("resultado.getDescripcionCOD_COMUNA(): "+resultado.getDescripcionCOD_COMUNA());
				if(rs.getString(16) != null){ 
					resultado.setDescripcionCOD_TIPOCALLE(rs.getString(16));
				}else{
					resultado.setDescripcionCOD_TIPOCALLE("");
				}
				cat.debug("resultado.getDescripcionCOD_TIPOCALLE(): "+resultado.getDescripcionCOD_TIPOCALLE());				
			}			
		} 
		catch (Exception e) {
			cat.error("Ocurrió un error al obtener Direccion Prepago por defecto",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException){
				throw (CustomerDomainException) e; 	
			}
		} 
		finally {
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
		cat.debug("Fin:getDireccionPrepago()");
		return resultado;
	}//fin getDireccionPrepago
	//Fin P-CSR-11002 JLGN 28-04-2011
	
	//Inicio P-CSR-11002 JLGN 14-06-2011
	
	/**
	 * Obtiene codigo de Direccion personal del cliente
	 * @param entrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public String obtenerDirecPerCli(String codCliente) throws CustomerDomainException{
		cat.debug("Inicio:obtenerDirecPerCli");
		String resultado ="";
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt =null;
		ResultSet rs = null;
		cat.debug("Coneccion obtenida OK");
		try {
			String call = getSql("VE_alta_cliente_PG","VE_direcPerso_PR",5);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			
			cat.debug("Codigo cliente: "+ codCliente);
			cstmt.setLong(1,Long.parseLong(codCliente));			
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:obtenerDirecPerCli:Execute");
			cstmt.execute();
			cat.debug("Fin:obtenerDirecPerCli:Execute");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			cat.debug("Codigo Error: "+codError);
			cat.debug("Mensaje Error: "+msgError);
			cat.debug("Numero Error: "+numEvento);

			if (codError != 0) {
				cat.error("Ocurrió un error al obtener Direccion Personal del Cliente");
				throw new CustomerDomainException(
						"Ocurrió un error al obtener Direccion Personal del Cliente", String
								.valueOf(codError), numEvento, msgError);
			}			
			
			resultado = cstmt.getString(2);			
			
		} 
		catch (Exception e) {
			cat.error("Ocurrió un error al obtener Direccion Personal del Cliente",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException){
				throw (CustomerDomainException) e; 	
			}
		} 
		finally {
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
		cat.debug("Fin:getDireccionPrepago()");
		return resultado;
	}//fin getDireccionPrepago
	//Fin P-CSR-11002 JLGN 14-06-2011
}//fin class DireccionDAO


