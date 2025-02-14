package com.tmmas.cl.scl.customerdomain.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.base.ParametersFromManualConnection;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.MenuUsuarioSCLDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.SeguridadPerfilesDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.UsuarioSCLDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.helper.Global;


public class UsuarioSCLDAO extends ConnectionDAO{
	private static Category cat = Category.getInstance(UsuarioDAO.class);
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
	
	private String getSQLDatosSeguridad(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
        for (int n = 1; n <= paramCount; n++) {
            sb.append("?");
            if (n < paramCount) sb.append(",");
        }
        return sb.append(")}").toString();
	}
	

    public boolean verificarConexionBD(UsuarioSCLDTO usuariodto)
    	throws SQLException 
    {
        boolean retorno; 
        Connection conn = null;
        ParametersFromManualConnection parametros = new ParametersFromManualConnection();
        parametros.setDatabaseUserName(usuariodto.getUsuario());
        parametros.setPassword(usuariodto.getClave());
        // Esto se debe poner en un archivo XML
        parametros.setDatabaseName(usuariodto.getBasedeDatos());
        parametros.setHostName(usuariodto.getHost());
        parametros.setPort(new Integer(Integer.parseInt(usuariodto.getPuerto())));
        try{ 
        	conn = getConnectionManualToOracleDB(parametros);
        	cat.debug("Conexion exitosa en usuario DAO");
        	retorno = true;
        }
        catch( SQLException x ){
        	cat.debug("Couldn't get connection whit this user!");
        	retorno = false;
        }
        
        finally {
			cat.debug("Cerrando conexiones...");
			try {
				if (conn!=null && !conn.isClosed()) {
					conn.close();
				}
			} 
			catch (SQLException e) {
			  cat.debug("Exception al cerrar conexion", e);
			}
	    }
        retorno = true;
        return retorno;

    }
	

	public UsuarioSCLDTO validaUsuarioSistema(UsuarioSCLDTO usuariodto) 
		throws CustomerDomainException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		
		try {
				String call = getSQLDatosSeguridad("SE_SEGURIDAD_PG","VE_valida_usuario_PR",8);
				cat.debug("sql[" + call + "]");
				CallableStatement cstmt = conn.prepareCall(call);
				cstmt.setString(1,usuariodto.getUsuario());
				cstmt.setString(2,usuariodto.getCodigoPrograma());
				cstmt.setString(3,usuariodto.getCodigoProceso());
				cstmt.setString(4,usuariodto.getCodigoOpcion());
				cstmt.registerOutParameter(5,java.sql.Types.NUMERIC); //SB_resultado
				cstmt.registerOutParameter(6,java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(7,java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(8,java.sql.Types.NUMERIC);
				cat.debug("validaUsuarioSistema antes de execute");
				cstmt.execute();
				cat.debug("validaUsuarioSistema despues de execute");
				int res = cstmt.getInt(5);
				res=1;
				codError = cstmt.getInt(6);
				msgError = cstmt.getString(7);
				numEvento = cstmt.getInt(8);
				
				usuariodto.setResultadoValidacion(res==1?true:false);
				usuariodto.setMensajeValidacion(res==1?"Usuario validado exitosamente":"Usuario no tiene permiso para ejecutar la aplicación");
				usuariodto.setMotivoError(res==1?"sinerror":"errorlogin");
				usuariodto.setUsuario(usuariodto.getUsuario().toUpperCase());
			
		} catch (Exception e) {
			cat.error("Ocurrió un error en UsuarioDAO",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
				cat.debug("Cerrando conexiones...");
		try {
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				cat.debug("SQLException", e);
		  }
		}
		cat.debug("validaUsuarioSistema:end");
		return usuariodto;
	}
	
	public UsuarioSCLDTO validaUsuarioSinPerfil(UsuarioSCLDTO usuariodto)
		throws CustomerDomainException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		UsuarioSCLDTO respuesta = new UsuarioSCLDTO();
		try {
				String call = getSQLDatosSeguridad("SE_SEGURIDAD_PG","VE_valida_usuario_PR",9);
				cat.debug("sql[" + call + "]");
				CallableStatement cstmt = conn.prepareCall(call);
				cstmt.setString(1,usuariodto.getUsuario());
				cstmt.registerOutParameter(2,java.sql.Types.NUMERIC); //SB_resultado
				cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(5,java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(6,java.sql.Types.VARCHAR);
				
				cstmt.registerOutParameter(7,java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(8,java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(9,java.sql.Types.NUMERIC);
				
				cat.debug("validaUsuarioSinPerfil antes de execute");
				cstmt.execute();
				cat.debug("validaUsuarioSinPerfil despues de execute");
				int res = cstmt.getInt(2);
				
				codError = cstmt.getInt(7);
				msgError = cstmt.getString(8);
				numEvento = cstmt.getInt(9);
				usuariodto.setResultadoValidacion(res==1?true:false);
				//usuariodto.setUsuario(usuariodto.getUsuario().toUpperCase());
				
				respuesta.setCodigoVendedor(cstmt.getLong(3));
				cat.debug("Vendedor " + respuesta.getCodigoVendedor());
				respuesta.setCodigoOficina(cstmt.getString(4)); 
				cat.debug("Oficina " + respuesta.getCodigoOficina());
				respuesta.setNombreUsuario(cstmt.getString(5));
				cat.debug("Nombre Usuario " + respuesta.getNombreUsuario());
				respuesta.setCodTipcomis(cstmt.getString(6));
				cat.debug("Tipo de comisionista " + respuesta.getCodTipcomis());
		} catch (Exception e) {
			cat.error("Ocurrió un error en UsuarioDAO",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
				cat.debug("Cerrando conexiones...");
		try {
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				cat.debug("SQLException", e);
		  }
		}
		cat.debug("validaUsuarioSinPerfil:end");
		return respuesta;
	}
	
	public UsuarioSCLDTO getMenuUsuario(UsuarioSCLDTO usuariodto)
		throws CustomerDomainException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		ResultSet rs = null;		
		UsuarioSCLDTO resultado = new UsuarioSCLDTO();
		try {
				String call = getSQLDatosSeguridad("SE_SEGURIDAD_PG","VE_obtiene_menu_pr",7);
				cat.debug("sql[" + call + "]");
				CallableStatement cstmt = conn.prepareCall(call);
				cstmt.setString(1,usuariodto.getCodigoPrograma());
				cat.debug("getMenuUsuario.usuariodto.getCodigoPrograma() : " + usuariodto.getCodigoPrograma());
				cstmt.setLong(2,usuariodto.getNumVersion());
				cat.debug("getMenuUsuario.usuariodto.getNumVersion():" + usuariodto.getNumVersion());
				cstmt.setString(3,usuariodto.getNombreUsuario());
				cat.debug("getMenuUsuario.usuariodto.getNombreUsuario():" + usuariodto.getNombreUsuario());
				cstmt.registerOutParameter(4,OracleTypes.CURSOR);
				
				cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(6,java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(7,java.sql.Types.NUMERIC);
				
				cat.debug("getMenuUsuario antes de execute");
				cstmt.execute();
				cat.debug("getMenuUsuario despues de execute");
				
				codError = cstmt.getInt(5);
				cat.debug("codError:" + codError);
				msgError = cstmt.getString(6);
				cat.debug("msgError:" + msgError);
				numEvento = cstmt.getInt(7);
				cat.debug("numEvento:" + numEvento);
				
				if(codError == 0)
				{
					ArrayList lista = new ArrayList();
					rs = (ResultSet) cstmt.getObject(4);
					while (rs.next()) {
						MenuUsuarioSCLDTO menu = new MenuUsuarioSCLDTO();
						menu.setFormulario(rs.getString(1));
						menu.setGrupo(rs.getString(2));
						lista.add(menu);
					}				
					resultado.setArrayMenuUsuario((MenuUsuarioSCLDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
						lista.toArray(), MenuUsuarioSCLDTO.class));
				}				
				
								
				
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener el menu asociado al usuario",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
				cat.debug("Cerrando conexiones...");
		try {
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				cat.debug("SQLException", e);
		  }
		}
		cat.debug("getMenuUsuario:end");
		return resultado;
	}
	
	public void validaFiltroImpresion(SeguridadPerfilesDTO seguridadPerfilesDTO) throws CustomerDomainException {
		cat.debug("validaFiltroImpresion:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		try {
				String call = getSQLDatosSeguridad("Ve_Servicios_solicitud_Pg","VE_Valida_FlitroImpresion_PR",7);
				cat.debug("sql[" + call + "]");
				CallableStatement cstmt = conn.prepareCall(call);
				
				cstmt.setString(1,seguridadPerfilesDTO.getNomUsuario());//EV_NomUsuario          IN GE_SEG_USUARIO.NOM_USUARIO%TYPE,
				cstmt.setString(2,seguridadPerfilesDTO.getCodPrograma());//EV_cod_Programa        IN GE_PROGRAMAS.COD_PROGRAMA%TYPE,
				cstmt.setString(3,seguridadPerfilesDTO.getNomProceso());//EV_NomProceso          IN GAD_PROCESOS_PERFILES.NOM_PERFIL_PROCESO%TYPE,  
				cstmt.setString(4,seguridadPerfilesDTO.getCodVersion());//EV_codVersion          IN GE_PROGRAMAS.NUM_VERSION%TYPE,           
				
				cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(6,java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(7,java.sql.Types.NUMERIC);
				
				cat.debug("validaFiltroImpresion antes de execute");
				cstmt.execute();
				cat.debug("validaFiltroImpresion despues de execute");
				
				codError = cstmt.getInt(5);
				msgError = cstmt.getString(6);
				numEvento = cstmt.getInt(7);
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
				seguridadPerfilesDTO.setGrupoImpresion(codError!=0?false:true);
		} catch (Exception e) {
			cat.error("Ocurrió un error en UsuarioDAO",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
			cat.debug("Cerrando conexiones...");
			try {
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("validaFiltroImpresion:end");
	}
}

