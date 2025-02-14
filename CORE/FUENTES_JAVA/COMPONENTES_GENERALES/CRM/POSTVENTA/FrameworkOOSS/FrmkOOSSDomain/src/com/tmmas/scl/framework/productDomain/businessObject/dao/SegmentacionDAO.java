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
 * 23/07/2007			  Raúl Lozano				   Versión Inicial         
 */


package com.tmmas.scl.framework.productDomain.businessObject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces.SegmentacionDAOIT;
import com.tmmas.scl.framework.productDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.productDomain.dataTransferObject.GaSegmentacionCargosDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.GaSegmentacionCargosListDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.GedCodigosDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.GedCodigosListDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;

public class SegmentacionDAO extends ConnectionDAO implements SegmentacionDAOIT{
	
	private final Logger logger = Logger.getLogger(SegmentacionDAO.class);

	private final Global global = Global.getInstance();

	
	private String getSQLobtenerListaSegmentacion() {
		StringBuffer call = new StringBuffer();

		call.append(" DECLARE"); 
		call.append("   SO_CARGOSSEGMENTACION PV_TIPOS_PG.TIP_GA_SEGMENTACION_CARGOS;");
		call.append(" BEGIN"); 
		call.append("    SO_CARGOSSEGMENTACION(1).cod_seg_orig :=?;");
		call.append("    SO_CARGOSSEGMENTACION(1).cod_seg_des:=?;");
		call.append("    SO_CARGOSSEGMENTACION(1).tipo_seg_des:=?;");
		call.append("    SO_CARGOSSEGMENTACION(1).tipo_seg_orig:=?;");
		call.append("    SO_CARGOSSEGMENTACION(1).Tipo_Cargo:=?; ");
		call.append("    PV_CARGOS_PG.PV_LISTA_SEGM_CARGOS_PR ( SO_CARGOSSEGMENTACION, ?, ?, ?, ? );");
		call.append("    END;");
		return call.toString();		
	}
	
	private String getSQLobtenerListaGedCodigos() {
		StringBuffer call = new StringBuffer();

		call.append(" DECLARE"); 
		call.append("   SO_GEDCODIGOS PV_TIPOS_PG.TIP_GED_CODIGOS;");
		call.append(" BEGIN"); 
		call.append("    SO_GEDCODIGOS(1).cod_modulo :=?;");
		call.append("    SO_GEDCODIGOS(1).nom_columna:=?;");
		call.append("    SO_GEDCODIGOS(1).nom_tabla:=?;");
		call.append("    PV_GENERALES_PG.PV_OBTIENE_GED_CODIGOS_PR( SO_GEDCODIGOS, ?, ?, ?, ? );");
		call.append("    END;");
		return call.toString();		
	}
	
	public GaSegmentacionCargosListDTO obtenerListaSegmentacionCargos(GaSegmentacionCargosDTO gaSegCargos) throws ProductException {

		/*String log = global.getValor("bo.log");
		PropertyConfigurator.configure(log);
		logger.debug("obtenerListaAbonados():start");*/

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		GaSegmentacionCargosListDTO gaSegCargosList = null;
		GaSegmentacionCargosDTO[] gaSegCargosDTO = null;
		Connection conn = null;
		CallableStatement cstmt = null;

		String call = getSQLobtenerListaSegmentacion();
		try {

			logger.debug("gaSegCargos.getCod_seg_orig()[" + gaSegCargos.getCod_seg_orig() + "]");
			logger.debug("gaSegCargos.getCod_seg_des()[" + gaSegCargos.getCod_seg_des() +"]");
			logger.debug("gaSegCargos.getTipo_seg_des()[" + gaSegCargos.getTipo_seg_des() +"]");
			logger.debug("gaSegCargos.getTipo_seg_orig()[" + gaSegCargos.getTipo_seg_orig() +"]");
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());

			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, gaSegCargos.getCod_seg_orig());
			cstmt.setLong(2, gaSegCargos.getCod_seg_des());
			cstmt.setString(3, gaSegCargos.getTipo_seg_des());
			cstmt.setString(4, gaSegCargos.getTipo_seg_orig());
			cstmt.setString(5,gaSegCargos.getCodTipoCargoSegm());
			cstmt.registerOutParameter(6, oracle.jdbc.driver.OracleTypes.CURSOR);			
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);			


			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");

			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(7);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(8);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(9);
			logger.debug("numEvento[" + numEvento + "]");

			if (codError != 0) {
				logger.error(" Ocurrió un error al obtener lista de segmentación");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}

			logger.debug("Recuperando cursor...");
			ResultSet rs = (ResultSet) cstmt.getObject(6);

			ArrayList lista = new ArrayList();
			while (rs.next()) {
				GaSegmentacionCargosDTO segCargoDTO = new GaSegmentacionCargosDTO();
				
				/*segCargosDTO.setCod_seg_des(cod_seg_des);
				segCargosDTO.setCod_seg_orig(cod_seg_orig);
				segCargosDTO.setFec_desde(fec_desde);
				segCargosDTO.setFec_hasta(fec_hasta);
				segCargosDTO.setNom_usuario(nom_usuario);
				segCargosDTO.setTipo_seg_des(tipo_seg_des);
				segCargosDTO.setTipo_seg_orig(tipo_seg_orig);
				segCargosDTO.setTipo_valor(tipo_valor);*/
				
				segCargoDTO.setDes_concepto(rs.getString(1));
				segCargoDTO.setImp_cargo(rs.getLong(2));
				segCargoDTO.setDes_moneda(rs.getString(3));
				segCargoDTO.setCod_moneda(rs.getString(5));
				segCargoDTO.setCod_concepto(rs.getLong(4));
				segCargoDTO.setTipo_cargo(rs.getLong(6));
				segCargoDTO.setTipo_seg_orig(rs.getString(7));
				segCargoDTO.setTipo_seg_des(rs.getString(8));
				
				logger.debug("segCargosDTO.getCod_concepto[" + segCargoDTO.getCod_concepto() + "]");
				logger.debug("segCargoDTO.getDes_concepto[" + segCargoDTO.getDes_concepto()+ "]");
				logger.debug("segCargoDTO.getImp_cargo[" + segCargoDTO.getImp_cargo()+ "]");
				logger.debug("segCargoDTO.getDes_moneda[" + segCargoDTO.getDes_moneda()+ "]");
				logger.debug("segCargoDTO.getCod_moneda[" + segCargoDTO.getCod_moneda()+ "]");
				logger.debug("segCargoDTO.getCod_concepto[" + segCargoDTO.getCod_concepto()+ "]");
				logger.debug("segCargoDTO.getTipo_cargo[" +segCargoDTO.getTipo_cargo() + "]");
				logger.debug("segCargoDTO.getTipo_seg_orig[" +segCargoDTO.getTipo_seg_orig() + "]");
				logger.debug("segCargoDTO.getTipo_seg_des[" +segCargoDTO.getTipo_seg_des() + "]");

				lista.add(segCargoDTO);
			}

			gaSegCargosDTO = (GaSegmentacionCargosDTO[]) ArrayUtl.copiaArregloTipoEspecifico(	lista.toArray(), GaSegmentacionCargosDTO.class);
			gaSegCargosList = new GaSegmentacionCargosListDTO();
			gaSegCargosList.setGaSegmentacionCargosDTO(gaSegCargosDTO);			

			rs.close();
		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener lista de Segmentación de Cargos", e);
			throw new ProductException("Ocurrió un error general al obtener lista de Segmentacion de Cargos",e);
		}
		finally {
			try {
				if (cstmt != null) {
					cstmt.close();
					cstmt = null;
				}
				if (conn != null) {
					if (!conn.isClosed()) {
						conn.close();
					}
					conn = null;
				}
			} catch (SQLException e) {
				cstmt = null;
				conn = null;
				logger.debug("SQLException[" + e + "]");
			}
		}
		logger.debug("obtenerListaSegmentacion():end");
		return gaSegCargosList;

}
	public GedCodigosListDTO obtenerListaGedCodigos(GedCodigosDTO gedCodigosDTO) throws ProductException {

		/*String log = global.getValor("bo.log");
		PropertyConfigurator.configure(log);
		logger.debug("obtenerListaAbonados():start");*/

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		GedCodigosListDTO gedCodigosListDTO = null;
		GedCodigosDTO[] gedCodigosArrayDTO=null; 
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs =null;

		String call = getSQLobtenerListaGedCodigos();
		try {

			logger.debug("gedCodigosDTO.getCod_modulo()[" + gedCodigosDTO.getCod_modulo() + "]");
			logger.debug("gedCodigosDTO.getNom_columna()[" + gedCodigosDTO.getNom_columna() +"]");
			logger.debug("gedCodigosDTO.getNom_tabla()[" + gedCodigosDTO.getNom_tabla() +"]");

			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());

			cstmt = conn.prepareCall(call);
			cstmt.setString(1, gedCodigosDTO.getCod_modulo());
			cstmt.setString(2, gedCodigosDTO.getNom_columna());
			cstmt.setString(3, gedCodigosDTO.getNom_tabla());
			cstmt.registerOutParameter(4, oracle.jdbc.driver.OracleTypes.CURSOR);			
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);			


			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");

			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(5);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(6);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(7);
			logger.debug("numEvento[" + numEvento + "]");

			if (codError != 0) {
				logger.error(" Ocurrió un error al obtener lista de segmentación");
				throw new ProductException(String.valueOf(codError),numEvento, msgError);
			}

			logger.debug("Recuperando cursor...");
			rs = (ResultSet) cstmt.getObject(4);

			ArrayList lista = new ArrayList();
			while (rs.next()) {
				GedCodigosDTO gedCodigoDTO = new GedCodigosDTO();
				gedCodigoDTO.setCod_modulo(rs.getString(1));//cod_modulo, 
				gedCodigoDTO.setNom_tabla(rs.getString(2));//nom_tabla,
				gedCodigoDTO.setNom_columna(rs.getString(3));//nom_columna,
				gedCodigoDTO.setCod_valor(rs.getString(4));// cod_valor,
				gedCodigoDTO.setDes_valor(rs.getString(5));//des_valor, 
				gedCodigoDTO.setFec_ultmod(rs.getTimestamp(6));//fec_ultmod, 
				gedCodigoDTO.setNom_usuario(rs.getString(7));//nom_usuario
				
				logger.debug("gedCodigoDTO.setCod_modulo[" +(rs.getString(1)) + "]");//cod_modulo, 
				logger.debug("gedCodigoDTO.setNom_tabla[" +(rs.getString(2)) + "]");//nom_tabla,
				logger.debug("gedCodigoDTO.setNom_columna[" +(rs.getString(3)) + "]");//nom_columna,
				logger.debug("gedCodigoDTO.setCod_valor[" +(rs.getString(4)) + "]");// cod_valor,
				logger.debug("gedCodigoDTO.setDes_valor[" +(rs.getString(5)) + "]");//des_valor, 
				logger.debug("gedCodigoDTO.setFec_ultmod[" +(rs.getTimestamp(6)) + "]");//fec_ultmod, 
				logger.debug("gedCodigoDTO.setNom_usuario[" +(rs.getString(7)) + "]");//nom_usuario
				

				lista.add(gedCodigoDTO);
			}

			gedCodigosArrayDTO = (GedCodigosDTO[]) ArrayUtl.copiaArregloTipoEspecifico(	lista.toArray(), GedCodigosDTO.class);
			gedCodigosListDTO = new GedCodigosListDTO();
			gedCodigosListDTO.setGedCodigosDTO(gedCodigosArrayDTO);			
			
		} catch (ProductException e) {
			logger.debug("ProductException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;

		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener lista de Segmentación de Cargos", e);
			throw new ProductException("Ocurrió un error general al obtener lista de Segmentacion de Cargos",e);
		}
		finally {
			try {
				if (rs!=null){
					rs.close();
				}
				if (cstmt != null) {
					cstmt.close();
					cstmt = null;
				}
				if (conn != null) {
					if (!conn.isClosed()) {
						conn.close();
					}
					conn = null;
				}
			} catch (SQLException e) {
				cstmt = null;
				conn = null;
				logger.debug("SQLException[" + e + "]");
			}
		}
		logger.debug("obtenerListaSegmentacion():end");
		return gedCodigosListDTO;

}
	
}
