package com.tmmas.scl.vendedor.negocio.ejb.session.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.vendedor.dto.ConfiguracionVendedorCPUDTO;
import com.tmmas.scl.vendedor.dto.UsuarioSistemaDTO;
import com.tmmas.scl.vendedor.dto.UsuarioVendedorDTO;
import com.tmmas.scl.vendedor.dto.VendedorDTO;
import com.tmmas.scl.vendedor.exception.VendedorException;
import com.tmmas.scl.vendedor.negocio.ejb.session.helper.Global;

public class VendedorDAO extends ConnectionDAO {
	private final Logger logger = Logger.getLogger(VendedorDAO.class);
	private Global global = Global.getInstance();
	
	private String getSQLRecuperarInformacionVendedor() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   EO_PV_COMIS_OOSS PV_COMIS_OOSS_QT := NEW PV_COMIS_OOSS_QT; ");
		
		call.append(" BEGIN ");
		call.append(" EO_PV_COMIS_OOSS.COD_VENDEDOR	     := ?; ");
		call.append(" EO_PV_COMIS_OOSS.IND_INTERNO       := ?; ");

		call.append(" PV_COMIS_OOSS_PG.PV_OBTIENE_DATOS_VENDEDOR_PR( EO_PV_COMIS_OOSS, ?, ?, ?, ?); ");
		call.append(" END; ");
		return call.toString();
	}		
	
	/**
	 * Recupera la informacion del vendedor
	 * @param vendedor
	 * @return
	 * @throws VendedorException
	 */
	public VendedorDTO recuperarInformacionVendedor(VendedorDTO vendedor) throws VendedorException  {
		logger.debug("recuperarInformacionVendedor():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		VendedorDTO resultado = null;
		resultado = new VendedorDTO();

		String call = getSQLRecuperarInformacionVendedor();		
		try {
			
			logger.debug("getCod_vendedor()[" + vendedor.getCod_vendedor() + "]");
			logger.debug("isInd_interno()[" + vendedor.isInd_interno() + "]");
			byte ind ;
			if (vendedor.isInd_interno()) ind = 1;
			else ind = 0;
			logger.debug("ind[" + ind + "]");	
		
			
			logger.debug("Obteniendo conexion:antes");
			conn = getConnectionFromWLSInitialContext(global
					.getJndiForDataSource());
			logger.debug("Obteniendo conexion:despues");

			cstmt = conn.prepareCall(call);		
			

			cstmt.setString(1, vendedor.getCod_vendedor());
			cstmt.setInt(2, ind);
			
			cstmt.registerOutParameter(3,  oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);	
			
			
			resultado.setCod_vendedor(vendedor.getCod_vendedor())	;
			resultado.setInd_interno(vendedor.isInd_interno());
			resultado.setNumOOSS(vendedor.getNumOOSS());
			resultado.setUsuario(vendedor.getUsuario());
			resultado.setFecha(vendedor.getFecha());
			resultado.setCod_os(vendedor.getCod_os());	
			resultado.setSub_tipo(vendedor.getSub_tipo());	
			
			logger.debug("ind[" + ind + "]");	
			logger.debug("getNumOOSS()[" + resultado.getNumOOSS() + "]");	
			logger.debug("getUsuario()[" + resultado.getUsuario() + "]");
			logger.debug("getFecha()[" + resultado.getFecha() + "]");
			logger.debug("getCod_os()[" + resultado.getCod_os() + "]");
			logger.debug("getSub_tipo()[" + resultado.getSub_tipo() + "]");				
			
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(4);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(5);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(6);
			logger.debug("numEvento[" + numEvento + "]");
			// fin----------------------------------------------------------------------

			if (codError != 0) {
				logger.error(" Ocurrió un error al consultar la informacion de vendedor");
				throw new VendedorException(String.valueOf(codError),
						numEvento, msgError);
			}	
			
			logger.debug("Obteniendo el cursor...");
			rs = (ResultSet) cstmt.getObject(3);			
			while (rs.next()) {
				resultado.setCod_vendedor(rs.getString("COD_VENDEDOR"));
				resultado.setNom_vendedor(rs.getString("NOM_VENDEDOR"));
				resultado.setCod_vendealer(rs.getString("COD_VENDEALER"));
				resultado.setNom_vendealer(rs.getString("NOM_VENDEALER"));
				resultado.setInd_interno(vendedor.isInd_interno());
				resultado.setCod_oficina(rs.getString("COD_OFICINA"));
				resultado.setNom_oficina(rs.getString("DES_OFICINA"));
				resultado.setCod_tipcomis(rs.getString("COD_TIPCOMIS"));
				resultado.setNom_tipcomis(rs.getString("DES_TIPCOMIS"));
				

				
				resultado.setCod_region(rs.getString("COD_REGION"));
				resultado.setDes_region(rs.getString("DES_REGION"));	
				resultado.setCod_provincia(rs.getString("COD_PROVINCIA"));
				resultado.setDes_provincia(rs.getString("DES_PROVINCIA"));
				resultado.setCod_ciudad(rs.getString("COD_CIUDAD"));
				resultado.setDes_ciudad(rs.getString("DES_CIUDAD"));				
				

				logger.debug("getCod_vendedor()[" + resultado.getCod_vendedor() + "]");
				logger.debug("getNom_vendedor()[" + resultado.getNom_vendedor() + "]");	
				logger.debug("getCod_vendealer()[" + resultado.getCod_vendealer() + "]");
				logger.debug("getNom_vendealer()[" + resultado.getNom_vendealer() + "]");				
				logger.debug("isInd_interno()[" + resultado.isInd_interno() + "]");				
				
				logger.debug("getCod_oficina()[" + resultado.getCod_oficina() + "]");
				logger.debug("getNom_oficina()[" + resultado.getNom_oficina() + "]");
				logger.debug("getCod_tipcomis()[" + resultado.getCod_tipcomis() + "]");	
				logger.debug("getNom_tipcomis()[" + resultado.getNom_tipcomis() + "]");
				
				
				logger.debug("getCod_region()[" + resultado.getCod_region() + "]");	
				logger.debug("getDes_region()[" + resultado.getDes_region() + "]");
				logger.debug("getCod_provincia()[" + resultado.getCod_provincia() + "]");
				logger.debug("getDes_provincia()[" + resultado.getDes_provincia() + "]");
				logger.debug("getCod_ciudad()[" + resultado.getCod_ciudad() + "]");					
				logger.debug("getDes_ciudad()[" + resultado.getDes_ciudad() + "]");
			}			
		}
		catch (VendedorException e) {
			logger.error("Exception", e);
			throw e;
		}		
		catch (Exception e) {
			logger.error("Exception", e);			
			throw new VendedorException("Ocurrió un error general al la informacion de vendedor");			
		}
		finally {
			try {
				if (rs != null) {
					rs.close();
					rs = null;
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
		logger.debug("recuperarInformacionVendedor():end");
		return resultado;
	}
	
	private String getSQLRegistrarInformacionVendedor() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   EO_PV_COMIS_OOSS PV_COMIS_OOSS_QT := NEW PV_COMIS_OOSS_QT; ");
		
		call.append(" BEGIN ");
		call.append(" EO_PV_COMIS_OOSS.COD_VENDEDOR	     := ?; ");
		call.append(" EO_PV_COMIS_OOSS.COD_VENDEALER     := ?; ");
		call.append(" EO_PV_COMIS_OOSS.IND_INTERNO       := ?; ");
		call.append(" EO_PV_COMIS_OOSS.COD_OFICINA       := ?; ");		
		call.append(" EO_PV_COMIS_OOSS.COD_TIPCOMIS      := ?; ");
		call.append(" EO_PV_COMIS_OOSS.NUM_OS            := ?; ");
		call.append(" EO_PV_COMIS_OOSS.NOM_USUARIO       := ?; ");
		call.append(" EO_PV_COMIS_OOSS.FECHA             := ?; ");
		call.append(" EO_PV_COMIS_OOSS.COD_OS            := ?; ");
		call.append(" EO_PV_COMIS_OOSS.SUB_TIPO          := ?; ");

		call.append(" PV_COMIS_OOSS_PG.PV_REGISTRA_DATOS_COMIS_PR ( EO_PV_COMIS_OOSS, ?, ?, ?); ");
		call.append(" END; ");
		return call.toString();
	}		
	
	/**
	 * Guarda la informacion del vendedor
	 * @param vendedor
	 * @throws VendedorException
	 */
	public void registrarInformacionVendedor(VendedorDTO vendedor) throws VendedorException {
		logger.debug("registrarInformacionVendedor():start");

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;

		String call = getSQLRegistrarInformacionVendedor();		

		try {
			
			logger.debug("getCod_vendedor()[" + vendedor.getCod_vendedor() + "]");
			logger.debug("getCod_vendealer()[" + vendedor.getCod_vendealer() + "]");
			logger.debug("isInd_interno()[" + vendedor.isInd_interno() + "]");
			logger.debug("getCod_oficina()[" + vendedor.getCod_oficina() + "]");
			logger.debug("getCod_tipcomis()[" + vendedor.getCod_tipcomis() + "]");
			logger.debug("getNumOOSS()[" + vendedor.getNumOOSS() + "]");	
			
			logger.debug("getUsuario()[" + vendedor.getUsuario() + "]");
			logger.debug("getFecha()[" + vendedor.getFecha() + "]");
			logger.debug("getCod_os()[" + vendedor.getCod_os() + "]");	
			logger.debug("getSub_tipo()[" + vendedor.getSub_tipo() + "]");
		
			
			logger.debug("Obteniendo conexion:antes");
			conn = getConnectionFromWLSInitialContext(global
					.getJndiForDataSource());
			logger.debug("Obteniendo conexion:despues");

			cstmt = conn.prepareCall(call);		
			

			cstmt.setString(1, vendedor.getCod_vendedor());
			cstmt.setString(2, vendedor.getCod_vendealer());
			byte ind ;
			if (vendedor.isInd_interno()) ind = 1;
			else ind = 0;
			logger.debug("ind[" + ind + "]");
			cstmt.setInt(3, ind);
			cstmt.setString(4, vendedor.getCod_oficina());
			cstmt.setString(5, vendedor.getCod_tipcomis());	
			cstmt.setString(6, vendedor.getNumOOSS());
			cstmt.setString(7, vendedor.getUsuario());
			cstmt.setDate(8, new java.sql.Date(vendedor.getFecha().getTime()));
			cstmt.setString(9, vendedor.getCod_os());
			cstmt.setString(10, vendedor.getSub_tipo());				
			
			cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(13, java.sql.Types.NUMERIC);	
			
			
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");

			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(11);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(12);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(13);
			logger.debug("numEvento[" + numEvento + "]");
			// fin----------------------------------------------------------------------

			if (codError != 0) {
				logger.error(" Ocurrió un error al registrar la informacion de vendedor");
				throw new VendedorException(String.valueOf(codError),
						numEvento, msgError);
			}			
		}
		catch (VendedorException e) {
			logger.error("Exception", e);
			throw e;
		}		
		catch (Exception e) {
			logger.error("Exception", e);			
			throw new VendedorException("Ocurrió un error general al la informacion de vendedor");			
		}
		finally {
			try {
				if (rs != null) {
					rs.close();
					rs = null;
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
		logger.debug("registrarInformacionVendedor():end");
	}

	private String getSQLRecuperarConfiguracionVendedorCPU() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   EO_COMBINATORIA_OS pv_combinatoria_os_qt  := NEW pv_combinatoria_os_qt; ");
		
		call.append(" BEGIN ");
		call.append(" EO_COMBINATORIA_OS.cod_os 	      := ?; ");
		call.append(" EO_COMBINATORIA_OS.nom_combinatoria := ?; ");
		call.append(" Pv_Orden_Servicio_Pg.PV_CNSLTA_COMBINATORIA_PR ( EO_COMBINATORIA_OS, ?, ?, ?); ");
		call.append(" ? := EO_COMBINATORIA_OS.flg_estado;  ");
		call.append(" END; ");
		return call.toString();
	}	
	
	public ConfiguracionVendedorCPUDTO  recuperarConfiguracionVendedorCPU(ConfiguracionVendedorCPUDTO config) throws VendedorException {
		logger.debug(" recuperarConfiguracionVendedorCPU():start");

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;

		String call = getSQLRecuperarConfiguracionVendedorCPU();
		
		ConfiguracionVendedorCPUDTO resultado = new ConfiguracionVendedorCPUDTO();

		try {
			
			logger.debug("getCod_ooss()[" + config.getCod_ooss() + "]");
			logger.debug("getCombinatoria()[" + config.getCombinatoria() + "]");
			
			logger.debug("Obteniendo conexion:antes");
			conn = getConnectionFromWLSInitialContext(global
					.getJndiForDataSource());
			logger.debug("Obteniendo conexion:despues");

			cstmt = conn.prepareCall(call);		
			

			cstmt.setString(1, config.getCod_ooss());
			cstmt.setString(2, config.getCombinatoria());
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);	
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			
			
			
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");

			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(3);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(4);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(5);
			logger.debug("numEvento[" + numEvento + "]");
			// fin----------------------------------------------------------------------

			if (codError != 0) {
				logger.error(" Ocurrió un error al recuperar la configuracion de la combinatoria para la orden de servicio");
				throw new VendedorException(String.valueOf(codError),
						numEvento, msgError);
			}

			int flag_Estado = cstmt.getInt(6);
			logger.debug("flag_Estado[" + flag_Estado + "]");			
			resultado = config;
			resultado.setFlag_estado(flag_Estado);
		}
		catch (VendedorException e) {
			logger.error("Exception", e);
			throw e;
		}		
		catch (Exception e) {
			logger.error("Exception", e);			
			throw new VendedorException("Ocurrió un error al recuperar la configuracion de la combinatoria para la orden de servicio");			
		}
		finally {
			try {
				if (rs != null) {
					rs.close();
					rs = null;
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
		logger.debug(" recuperarConfiguracionVendedorCPU():end");
		return resultado;
	}
	/*public ConfiguracionVendedorCPUDTO  consultaDatosClienteconVendedorAsociado(ConfiguracionVendedorCPUDTO config) throws VendedorException {
		logger.debug(" recuperarConfiguracionVendedorCPU():start");

		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;

		String call = getSQLRecuperarConfiguracionVendedorCPU();
		
		ConfiguracionVendedorCPUDTO resultado = new ConfiguracionVendedorCPUDTO();

		try {
			
			logger.debug("getCod_ooss()[" + config.getCod_ooss() + "]");
			logger.debug("getCombinatoria()[" + config.getCombinatoria() + "]");
			
			logger.debug("Obteniendo conexion:antes");
			conn = getConnectionFromWLSInitialContext(global
					.getJndiForDataSource());
			logger.debug("Obteniendo conexion:despues");

			cstmt = conn.prepareCall(call);		
			

			cstmt.setString(1, config.getCod_ooss());
			cstmt.setString(2, config.getCombinatoria());
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);	
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);	
			
			
			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");

			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(3);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(4);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(5);
			logger.debug("numEvento[" + numEvento + "]");
			// fin----------------------------------------------------------------------

			if (codError != 0) {
				logger.error("Ocurrió un error al recuperar la informacion del vendedor asociada al usuario");
				throw new VendedorException(String.valueOf(codError),
						numEvento, msgError);
			}
			
			int flag_Estado = cstmt.getInt(6);
			logger.debug("flag_Estado[" + flag_Estado + "]");			
			resultado = config;
			resultado.setFlag_estado(flag_Estado);
		}
		catch (VendedorException e) {
			logger.error("Exception", e);
			throw e;
		}		
		catch (Exception e) {
			logger.error("Exception", e);			
			throw new VendedorException("Ocurrió un error al recuperar la informacion del vendedor asociada al usuario");			
		}
		finally {
			try {
				if (rs != null) {
					rs.close();
					rs = null;
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
		logger.debug(" recuperarConfiguracionVendedorCPU():end");
		return resultado;
	}*/
	
	private String getSQLobtenerInformacionUsuarioVendedor() {
		StringBuffer call = new StringBuffer();	
		call.append("DECLARE  "); 
		call.append("eso_seg_usuario ge_seg_usuario_qt := NEW ge_seg_usuario_qt;  ");
		call.append("EO_PV_COMIS_OOSS PV_COMIS_OOSS_QT :=NEW PV_COMIS_OOSS_QT;  ");
		call.append("RetVal BOOLEAN;");
		call.append("BEGIN  "); 
		call.append("eso_seg_usuario.nom_usuario := ?;  ");  
		call.append("Pv_Orden_Servicio_Pg.PV_CNSLTA_DATOS_COMIS_PR ( eso_seg_usuario, EO_PV_COMIS_OOSS, ?, ?, ? );  ");		
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
    	
    	
		call.append("? := EO_PV_COMIS_OOSS.COD_VENDEDOR;  ");
		call.append("? := EO_PV_COMIS_OOSS.NOM_VENDEDOR;  ");
		call.append("? := EO_PV_COMIS_OOSS.COD_OFICINA;  ");
		call.append("? := EO_PV_COMIS_OOSS.DES_OFICINA;  ");
		call.append("? := EO_PV_COMIS_OOSS.COD_TIPCOMIS;  ");
		call.append("? := EO_PV_COMIS_OOSS.DES_TIPCOMIS;  ");
		call.append("? := EO_PV_COMIS_OOSS.COD_REGION;  ");
		call.append("? := EO_PV_COMIS_OOSS.DES_REGION;  ");
		call.append("? := EO_PV_COMIS_OOSS.COD_PROVINCIA;  ");
		call.append("? := EO_PV_COMIS_OOSS.DES_PROVINCIA;  ");
		call.append("? := EO_PV_COMIS_OOSS.COD_VENDEALER;  ");
		call.append("? := EO_PV_COMIS_OOSS.NOM_VENDEALER;  ");
		call.append("? := EO_PV_COMIS_OOSS.COD_CIUDAD;  ");
		call.append("? := EO_PV_COMIS_OOSS.DES_CIUDAD;  ");
		call.append("? := EO_PV_COMIS_OOSS.ind_interno;  ");


		
    	
		call.append("END;  "); 		
		return call.toString(); 		 		
	}
		
	public UsuarioVendedorDTO obtenerInformacionUsuarioVendedor(UsuarioSistemaDTO usuarioSistema) throws VendedorException {
		logger.debug("obtenerInformacionUsuarioVendedor():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerInformacionUsuarioVendedor();
		
		UsuarioVendedorDTO resultado = new UsuarioVendedorDTO();
		VendedorDTO vendedor = new VendedorDTO();
		try {
			logger.debug("Parámetros de entrada");
			logger.debug("usuarioSistema.getNom_usuario()[" + usuarioSistema.getNom_usuario() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1, usuarioSistema.getNom_usuario());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);	
			
			//Vendedor
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
			
			//Vendedor 
			
			cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(18, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(19, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(20, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(21, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(22, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(23, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(24, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(25, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(26, java.sql.Types.VARCHAR);	
			cstmt.registerOutParameter(27, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(28, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(29, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(30, java.sql.Types.NUMERIC);				
			
			
			

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
				logger.error(" Ocurrió un error al recuperar los datos del usuario y vendedor");
				throw new VendedorException(String.valueOf(codError),numEvento, msgError);
			}

			//obtener info del usuario-vendedor y completar respuesta
			logger.debug("Recuperando data...");
			
			//Informacion de usuario
			logger.debug("Informacion de usuario.........................");
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
			
			logger.debug("getNom_usuario()[" + usuarioSistema.getNom_usuario() + "]");
			logger.debug("getNom_operador()[" + usuarioSistema.getNom_operador() + "]");
			logger.debug("getInd_adm()[" + usuarioSistema.getInd_adm() + "]");
			logger.debug("getCod_oficina()[" + usuarioSistema.getCod_oficina() + "]");
			logger.debug("getCod_tipcomis()[" + usuarioSistema.getCod_tipcomis() + "]");
			logger.debug("getCod_vendedor()[" + usuarioSistema.getCod_vendedor() + "]");
			logger.debug("getInd_excep_eriesgo()[" + usuarioSistema.getInd_excep_eriesgo() + "]");
			logger.debug("getDes_ofician()[" + usuarioSistema.getDes_ofician() + "]");
			logger.debug("getCod_comuna()[" + usuarioSistema.getCod_comuna() + "]");
			logger.debug("getDes_comuna()[" + usuarioSistema.getDes_comuna() + "]");	
			logger.debug("getCall_center()[" + usuarioSistema.getCall_center() + "]");
		
			logger.debug("Informacion de vendedor.........................");
			
			vendedor.setCod_vendedor(cstmt.getString(16));
			vendedor.setNom_vendedor(cstmt.getString(17));
			vendedor.setCod_oficina(cstmt.getString(18));
			vendedor.setNom_oficina(cstmt.getString(19));			
			vendedor.setCod_tipcomis(cstmt.getString(20));
			vendedor.setNom_tipcomis(cstmt.getString(21));			
			vendedor.setCod_region(cstmt.getString(22));
			vendedor.setDes_region(cstmt.getString(23));
			vendedor.setCod_provincia(cstmt.getString(24));
			vendedor.setDes_provincia(cstmt.getString(25));			
			vendedor.setCod_vendealer(cstmt.getString(26));
			vendedor.setNom_vendealer(cstmt.getString(27));	
			vendedor.setCod_ciudad(cstmt.getString(28));			
			vendedor.setDes_ciudad(cstmt.getString(29));
			int ind_interno = cstmt.getInt(30);
			logger.debug("ind_interno()[" + ind_interno + "]");
			if (ind_interno == 1)	vendedor.setInd_interno(true);
			else vendedor.setInd_interno(false);
			
			//Informacion de vendedor
			logger.debug("getCod_vendedor()[" + vendedor.getCod_vendedor() + "]");
			logger.debug("getNom_vendedor()[" + vendedor.getNom_vendedor() + "]");	
			logger.debug("getCod_vendealer()[" + vendedor.getCod_vendealer() + "]");
			logger.debug("getNom_vendealer()[" + vendedor.getNom_vendealer() + "]");				
			logger.debug("isInd_interno()[" + vendedor.isInd_interno() + "]");				
			
			logger.debug("getCod_oficina()[" + vendedor.getCod_oficina() + "]");
			logger.debug("getNom_oficina()[" + vendedor.getNom_oficina() + "]");
			logger.debug("getCod_tipcomis()[" + vendedor.getCod_tipcomis() + "]");	
			logger.debug("getNom_tipcomis()[" + vendedor.getNom_tipcomis() + "]");
			
			
			logger.debug("getCod_region()[" + vendedor.getCod_region() + "]");	
			logger.debug("getDes_region()[" + vendedor.getDes_region() + "]");
			logger.debug("getCod_provincia()[" + vendedor.getCod_provincia() + "]");
			logger.debug("getDes_provincia()[" + vendedor.getDes_provincia() + "]");
			logger.debug("getCod_ciudad()[" + vendedor.getCod_ciudad() + "]");					
			logger.debug("getDes_ciudad()[" + vendedor.getDes_ciudad() + "]");	
			
			resultado.setUsuario(usuarioSistema);
			resultado.setVendedor(vendedor);
			

			
		} catch (VendedorException e) {
			logger.debug("VendedorException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error al recuperar los datos del usuario y vendedor", e);
			throw new VendedorException("Ocurrió un error general al recuperar los datos del usuario-vendedor",e);
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
		logger.debug("obtenerInformacionUsuarioVendedor():end");
		return resultado;
	}	
}
