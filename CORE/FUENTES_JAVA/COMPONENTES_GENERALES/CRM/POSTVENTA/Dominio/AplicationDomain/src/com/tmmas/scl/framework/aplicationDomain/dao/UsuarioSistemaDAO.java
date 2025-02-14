package com.tmmas.scl.framework.aplicationDomain.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.aplicationDomain.dao.interfaces.UsuarioSistemaDAOIT;
import com.tmmas.scl.framework.aplicationDomain.dto.UsuarioSistemaDTO;
import com.tmmas.scl.framework.aplicationDomain.exception.AplicationException;
import com.tmmas.scl.framework.aplicationDomain.helper.Global;

public class UsuarioSistemaDAO  extends ConnectionDAO implements UsuarioSistemaDAOIT {

	private final Logger logger = Logger.getLogger(UsuarioSistemaDAO.class);
	private final Global global = Global.getInstance();
	
	private String getSQLobtenerInformacionUsuario() {
		StringBuffer call = new StringBuffer();	
		call.append("DECLARE  "); 
		call.append("eso_seg_usuario ge_seg_usuario_qt := NEW ge_seg_usuario_qt;  ");
		call.append("RetVal BOOLEAN;");
		call.append("BEGIN  "); 
		call.append("eso_seg_usuario.nom_usuario := ?;  ");  
		call.append("RetVal := pv_cambio_serie_sb_pg.pv_rec_ge_seg_usuario_fn ( eso_seg_usuario, ?, ?, ? );  ");		
		call.append("? := eso_seg_usuario.nom_usuario;  ");
		call.append("? := eso_seg_usuario.nom_operador;  ");
		call.append("? := eso_seg_usuario.ind_adm;  ");
		call.append("? := eso_seg_usuario.cod_oficina;  ");
		call.append("? := eso_seg_usuario.cod_tipcomis;  ");
		call.append("? := eso_seg_usuario.cod_vendedor;  ");    
    	call.append("? := eso_seg_usuario.ind_excep_eriesgo;  ");        	
    	call.append("? := eso_seg_usuario.des_oficina;  ");
		call.append("? := eso_seg_usuario.cod_comuna;  ");    
    	call.append("? := eso_seg_usuario.des_comuna;  ");
    	call.append("? := eso_seg_usuario.grup_callcenter;  ");
    	
		call.append("END;  "); 		
		return call.toString(); 		 		
	}
		
	public UsuarioSistemaDTO obtenerInformacionUsuario(UsuarioSistemaDTO usuarioSistema) throws AplicationException {
		logger.debug("obtenerInformacionUsuario():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerInformacionUsuario();
		try {
			logger.debug("Parámetros de entrada");
			logger.debug("usuarioSistema.getNom_usuario()[" + usuarioSistema.getNom_usuario() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1, usuarioSistema.getNom_usuario());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);	
			
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
			
			cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(15, java.sql.Types.VARCHAR);
			
			
			

			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(2);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(3);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(4);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al recuperar los datos del vendedor");
				throw new AplicationException(String.valueOf(codError),numEvento, msgError);
			}

			//obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");
			
			usuarioSistema.setNom_usuario(cstmt.getString(5));
			usuarioSistema.setNom_operador(cstmt.getString(6));
			usuarioSistema.setInd_adm(cstmt.getString(7));
			usuarioSistema.setCod_oficina(cstmt.getString(8));
			usuarioSistema.setCod_tipcomis(cstmt.getString(9));
			usuarioSistema.setCod_vendedor(cstmt.getLong(10));
			usuarioSistema.setInd_excep_eriesgo(cstmt.getString(11));						
			usuarioSistema.setDes_ofician(cstmt.getString(12));
			usuarioSistema.setCod_comuna(cstmt.getString(13));
			usuarioSistema.setDes_comuna(cstmt.getString(14));			
			usuarioSistema.setCall_center(cstmt.getString(15));
			
		} catch (AplicationException e) {
			logger.debug("CustomerException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al recuperar al recuperar los datos del vendedor", e);
			throw new AplicationException("Ocurrió un error general al recuperar los datos del vendedor",e);
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
		logger.debug("obtenerInformacionUsuario():end");
		return usuarioSistema;
	}
}
