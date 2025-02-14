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
 * 22/03/2007     Héctor Hermosilla     					Versión Inicial
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
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CeldaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CentralDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ClasificacionCuentaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.DireccionCentralDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.HomeLineaDTO;
import com.tmmas.cl.scl.gestiondeclietnes.businessobject.helper.Global;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.DireccionDTO;

public class CentralDAO extends ConnectionDAO{
	private Logger cat = Logger.getLogger(CentralDAO.class);

	Global global = Global.getInstance();
	
	private Connection getConection() throws GeneralException
	{
		Connection conn = null;
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
		} catch (Exception e1) {
			conn = null;
			cat.error(" No se pudo obtener una conexión ", e1);
			throw new GeneralException("No se pudo obtener una conexión", e1);
		}
		
		return conn;
	}
	
	private String getSQLDatos(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
        for (int n = 1; n <= paramCount; n++) {
            sb.append("?");
            if (n < paramCount) sb.append(",");
        }
        return sb.append(")}").toString();
	}//fin getSQLDatosAbonado
	
	public CentralDTO[] getListadoCentrales(CeldaDTO entrada) throws GeneralException{
		int codError = 0;
		CentralDTO[] resultado = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:obtieneCentrales");
			
			String call = getSQLDatos("VE_PORTABILIDAD_PG","ve_rec_central_pr",5);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1, entrada.getCodigoCelda());
			cstmt.registerOutParameter(2,OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getListadoCentrales:execute");
			cstmt.execute();
			cat.debug("Fin:getListadoCentrales:execute");

			msgError = cstmt.getString(4);
			codError = cstmt.getInt(3);
			numEvento = cstmt.getInt(5);
			
			cat.debug("codError [" + codError + "]");
			cat.debug("msgError [" + msgError + "]");
			cat.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar el centrales");
				throw new GeneralException(
						"Ocurrió un error al recuperar el centrales", String
								.valueOf(codError), numEvento, msgError);
				
			}else{
				cat.debug("Llenado Centrales");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(2);
				while (rs.next()) {
					CentralDTO central = new CentralDTO();
					central.setCodigoCentral(rs.getString(1));
					central.setDescripcionCentral(rs.getString(2));
					central.setCodigoSubAlm(rs.getString(3));
					lista.add(central);
				}
				rs.close();
				resultado =(CentralDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), CentralDTO.class);
				
				cat.debug("Fin Llenado Centrales");
			}
			cat.debug("msgError[" + msgError + "]");

			
		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener listado de centrales",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
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

		cat.debug("Fin:getListadoCentrales");

		return resultado;
	}

	
	/**
	 * Obtiene datos de la central
	 * @param entrada
	 * @return entrada
	 * @throws GeneralException
	 */
	public CentralDTO getCentral(CentralDTO entrada) 
	throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:getCentral");
			
			//INI-01 (AL) String call = getSQLDatos("VE_servicios_venta_PG","VE_obtiene_central_PR",6);
			String call = getSQLDatos("VE_servicios_venta_quiosco_PG","VE_obtiene_central_PR",6);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			
			cstmt.setInt(1, entrada.getCodigoProducto());
			cstmt.setInt(2, Integer.parseInt(entrada.getCodigoCentral()));
			
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getCentral:execute");
			cstmt.execute();
			cat.debug("Fin:getCentral:execute");

			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);
			
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");
			
			if (codError != 0) {
				cat.error("Ocurrió un error al obtener los datos de la central");
				throw new GeneralException(
						"Ocurrió un error al obtener los datos de la central", String
								.valueOf(codError), numEvento, msgError);				
			}else
				entrada.setCodigoTecnologia(cstmt.getString(3));
		
		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener los datos de la central",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
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
		cat.debug("Fin:getCentral");
		return entrada;
	}//fin getCentral

	
	/**
	 * Obtiene datos de la central
	 * @param entrada
	 * @return entrada
	 * @throws GeneralException
	 */
	public CeldaDTO getCentral(CeldaDTO entrada) 
	throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:getCentral");
			
			//INI-01 (AL) String call = getSQLDatos("VE_alta_cliente_PG","VE_getcentral_PR",6);
			String call = getSQLDatos("VE_alta_cliente_Quiosco_PG","VE_getcentral_PR",6);			

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1, entrada.getCodHLR() );
			cstmt.setString(2, entrada.getCodigoCelda());
			
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getCentral:execute");
			cstmt.execute();
			cat.debug("Fin:getCentral:execute");

			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);
			
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				cat.error("Ocurrió un error al obtener los datos de la central");
				throw new GeneralException(
						"Ocurrió un error al obtener los datos de la central", String
								.valueOf(codError), numEvento, msgError);				
			}else			
				entrada.setCentral(cstmt.getString(3));
		
		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener los datos de la central",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
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
		cat.debug("Fin:getCentral");
		return entrada;
	}
	
	
	/**
	 * Obtiene datos de la central segun la dirección
	 * @param entrada
	 * @return entrada
	 * @throws GeneralException
	 */
	public HomeLineaDTO[] getHomeLinea(DireccionCentralDTO direccionCentralDTO) 
	throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		HomeLineaDTO[] homeLineaDTOs = null;
		try {
			cat.debug("Inicio:getHomeLinea");
			
			String call = getSQLDatos("ge_cons_catalogo_portab_pg","ge_home_linea_x_direccion",4);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
					
			
			
			cstmt.registerOutParameter(1, OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getCentral:execute");
			cstmt.execute();
			cat.debug("Fin:getCentral:execute");

			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);
			
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				cat.error("Ocurrió un error al obtener los datos de la central mediante la direccón");
				throw new GeneralException(
						"Ocurrió un error al obtener los datos de la central mediante la direccón", String
								.valueOf(codError), numEvento, msgError);				
			}else{
				cat.debug("Recuperando Sucursales del banco");


				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(1);
				HomeLineaDTO homeLineaDTO = null;
				while (rs.next()) {

					homeLineaDTO = new HomeLineaDTO();					
					homeLineaDTO.setCodCentral(rs.getString(1));
					homeLineaDTO.setNomCentral(rs.getString(2));
					homeLineaDTO.setCodCelda(rs.getString(3));
					
					lista.add(homeLineaDTO);
				}
				rs.close();
				homeLineaDTOs =(HomeLineaDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
						lista.toArray(), HomeLineaDTO.class);
				cat.debug("Fin recuperacion home linea");
				
			}
				
		
		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener los datos de la central",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
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
		cat.debug("Fin:getHomeLinea");
		return homeLineaDTOs;
	}
	
	
	
	/**
	 * Obtiene datos de la central segun la dirección
	 * @param entrada
	 * @return entrada
	 * @throws GeneralException
	 */
	public CentralDTO getCentralTecnologia(CentralDTO central) 
	throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 	
		try {
			cat.debug("Inicio:getCentralTecnologia");
			
			//INI-01 (AL) String call = getSQLDatos("ve_validacion_linea_pg","ve_rec_central_pr",18);
			String call = getSQLDatos("ve_validacion_linea_quiosco_pg","ve_rec_central_pr",18);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
						
			cstmt.setString(1, central.getCodigoCentral()  );
			//INI-01 (AL) - LOG
			cat.debug("central.getCodigoCentral(): ["+central.getCodigoCentral()+"]");
			cstmt.setString(2, central.getCodigoCelda() );
			//INI-01 (AL) - LOG
			cat.debug("central.getCodigoCelda(): ["+central.getCodigoCelda()+"]");
			
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(15, java.sql.Types.VARCHAR);
						
			cstmt.registerOutParameter(16, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(18, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getCentralTecnologia:execute");
			cstmt.execute();
			cat.debug("Fin:getCentralTecnologia:execute");

			codError = cstmt.getInt(16);
			msgError = cstmt.getString(17);
			numEvento = cstmt.getInt(18);
			
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				cat.error("Ocurrió un error al obtener los datos de la central mediante la direccón");
				throw new GeneralException(
						"Ocurrió un error al obtener los datos de la central mediante la direccón", String
								.valueOf(codError), numEvento, msgError);				
			}else{
				cat.debug("Recuperando Sucursales del banco");

				central.setCodigoCentral(cstmt.getString(3));
				central.setCodigoProducto(cstmt.getInt(4));
				central.setNomCentral(cstmt.getString(5));
				central.setCodNemotec(cstmt.getString(6));
				central.setCodAlm(cstmt.getString(7));
				central.setNumMaxintentos(cstmt.getString(8));
				central.setCodigoSistema(cstmt.getInt(9));
				central.setCodCobertura(cstmt.getString(10));
				central.setTieRespuesta(cstmt.getString(11));
				central.setNodocom(cstmt.getString(12));
				central.setCodigoTecnologia(cstmt.getString(13));
				central.setCodHlr(cstmt.getString(14));		
				central.setCodGrupoTecnologico(cstmt.getString(15));
				
				cat.debug("Fin recuperacion home linea");				
			}
						
		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener los datos de la central",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
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
		cat.debug("Fin:getCentralTecnologia");
		return central;
	}
	
		
	
	//fin getCentral	
	
}//Fin CentralDAO
