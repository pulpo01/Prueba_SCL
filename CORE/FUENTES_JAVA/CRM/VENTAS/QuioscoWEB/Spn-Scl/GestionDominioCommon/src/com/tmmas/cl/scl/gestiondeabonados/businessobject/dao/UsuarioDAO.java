package com.tmmas.cl.scl.gestiondeabonados.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.helper.Global;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.UsuarioDTO;

public class UsuarioDAO extends ConnectionDAO{

	Global global = Global.getInstance();
	private static Category cat = Category.getInstance(UsuarioDAO.class);

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

	}

	public UsuarioDTO creaUsuario (UsuarioDTO entrada) throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		entrada.setExitoCreacionUsuario(false);

		try {
			cat.debug("Inicio:creaUsuario()");

			//INI-01 (AL) String call = getSQLDatos("VE_crea_linea_venta_PG","VE_IN_ga_usuarios_PR",25);
			String call = getSQLDatos("VE_crea_linea_venta_quiosco_PG","VE_IN_ga_usuarios_PR",25);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);



			cstmt.setLong(1,Long.parseLong(entrada.getCodigoUsuario()));
			cat.debug("Codigo Usuario:" + entrada.getCodigoUsuario());
			
			cstmt.setLong(2,Long.parseLong(entrada.getCodigoCuenta()));
			cat.debug("Cuenta Cliente:" + entrada.getCodigoCuenta());
			
			cstmt.setString(3,entrada.getCodigoSubCuenta());
			cat.debug("Sub cuenta:" + entrada.getCodigoSubCuenta());
			
			
			cstmt.setString(4,entrada.getNombre());
			cat.debug("Nombre Cliente:" + entrada.getNombre());					
			
			cstmt.setString(5,entrada.getPrimerApellido());
			cat.debug("apellido1:" + entrada.getPrimerApellido());
			
			cstmt.setString(6,entrada.getSegundoApellido());
			cat.debug("apellido2:" + entrada.getSegundoApellido());
			
			
			cstmt.setString(7,entrada.getNumeroIdentificacion());
			cat.debug("numero iden:" + entrada.getNumeroIdentificacion());
			
			cstmt.setString(8,entrada.getTipIdentificacion() );
			cat.debug("tipo iden:" + entrada.getTipIdentificacion());
			
			cstmt.setString(9,global.getEstadoIncompletoUsuario());
			cat.debug("estado:" + global.getEstadoIncompletoUsuario());
			
			cstmt.setString(10, null);			
			cstmt.setString(11,null);
			cstmt.setString(12,null);
			cstmt.setString(13,null);
			cstmt.setString(14,entrada.getNomEmpresa());
			cstmt.setString(15,null);
			cstmt.setString(16,entrada.getOcupacion());
			cstmt.setString(17,null);
			cstmt.setString(18,entrada.getIngresosBrutosAnuales());
			cstmt.setString(19,null);
			cstmt.setString(20,null);
			cstmt.setString(21,null);
			cstmt.setString(22,null);
			cstmt.registerOutParameter(23, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(24, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(25, java.sql.Types.NUMERIC);
			
			
			/*EV_codusuario	IN ga_usuarios.cod_usuario%TYPE,
				  					   EV_codcuenta		IN ga_usuarios.cod_cuenta%TYPE,
									   EV_codsubcuenta	IN ga_usuarios.cod_subcuenta%TYPE,
									   EV_nomusuario	IN ga_usuarios.nom_usuario%TYPE,
									   EV_nomapellido1	IN ga_usuarios.nom_apellido1%TYPE,
									   EV_nomapellido2	IN ga_usuarios.nom_apellido2%TYPE,
									   EV_numident		IN ga_usuarios.num_ident%TYPE,
									   EV_codtipident	IN ga_usuarios.cod_tipident%TYPE,
									   EV_indestado		IN ga_usuarios.ind_estado%TYPE,
									   EV_fecnacimien	IN VARCHAR2,
									   EV_codestcivil	IN VARCHAR2,
									   EV_indsexo		IN VARCHAR2,
									   EV_indtipotrab	IN ga_usuarios.ind_tipotrab%TYPE,
									   EV_nomempresa	IN ga_usuarios.nom_empresa%TYPE,
									   EV_codactemp		IN ga_usuarios.cod_actemp%TYPE,
									   EV_codocupacion	IN ga_usuarios.cod_ocupacion%TYPE,
									   EN_numpercargo	IN ga_usuarios.num_percargo%TYPE,
									   EN_impbruto		IN ga_usuarios.imp_bruto%TYPE,
									   EV_indprocoper	IN ga_usuarios.ind_procoper%TYPE,
									   EV_codoperador	IN ga_usuarios.cod_operador%TYPE,
									   EV_nomconyuge	IN ga_usuarios.nom_conyuge%TYPE,
									   EV_codpinusuar	IN ga_usuarios.cod_pinusuar%TYPE,*/

			cat.debug("Inicio:creaUsuario:execute");
			cstmt.execute();
			cat.debug("Fin:creaUsuario:execute");

			codError = cstmt.getInt(23);
			msgError = cstmt.getString(24);
			numEvento = cstmt.getInt(25);
			
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError !=0){
				cat.error("Ocurrió un error al creaUsuario");
				entrada.setExitoCreacionUsuario(false);
				throw new GeneralException(
						"Ocurrió un error al creaUsuario", String
						.valueOf(codError), numEvento, msgError);
			}
			
			entrada.setExitoCreacionUsuario(true);

		}catch (GeneralException e) {
			throw e;
		
		} catch (Exception e) {
			cat.error("Ocurrió un error al crear el usuario",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
			cat.debug("Cerrando conexiones...");
			try {
				cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}

		cat.debug("Fin:creaUsuario");

		return entrada;

	}

	public UsuarioDTO getSecuenciaUsuario() throws GeneralException{
		UsuarioDTO resultado = new UsuarioDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;

		try {
			cat.debug("Inicio:getSecuenciaUsuario()");

			//INI-01 (AL) String call = getSQLDatos("VE_intermediario_PG","VE_OBTIENE_SECUENCIA_PR",5);
			String call = getSQLDatos("VE_intermediario_Quiosco_PG","VE_OBTIENE_SECUENCIA_PR",5);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,global.getNombreSecuenciaUsuario());
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getSecuenciaUsuario:execute");
			cstmt.execute();
			cat.debug("Fin:getSecuenciaUsuario:execute");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError !=0){
				cat.error("Ocurrió un error al recuperar SecuenciaUsuario");			
				throw new GeneralException(
						"Ocurrió un error al creaUsuario", String
						.valueOf(codError), numEvento, msgError);
			}

			resultado.setCodigoUsuario(cstmt.getString(2));

		}catch (GeneralException e) {
			throw e;
			
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener la secuencia del usuario",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
			cat.debug("Cerrando conexiones...");
			try {
				cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}

		cat.debug("Fin:getSecuenciaUsuario");

		return resultado;

	}

	/**
	 * Inserta direccion del usuario
	 * @param usuarioDTO
	 * @return N/A
	 * @throws GeneralException
	 */
	public void insDireccionUsuario(UsuarioDTO usuarioDTO) 
	throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:insDireccionUsuario");

			//INI-01 (AL) String call = getSQLDatos("VE_servicios_direcciones_PG","VE_insDireccionUsuario_PR",6);
			String call = getSQLDatos("VE_servicios_direc_Quiosco_PG","VE_insDireccionUsuario_PR",6);
			cat.debug("sql[" + call + "]");

						
						cstmt = conn.prepareCall(call);
						
						cstmt.setString(1,usuarioDTO.getCodDireccion());
						cat.debug("codigo direccion :" + usuarioDTO.getCodDireccion());
						
						cstmt.setString(2,usuarioDTO.getCodigoUsuario());
						cat.debug("codigo usuario :" + usuarioDTO.getCodigoUsuario());
						
						cstmt.setString(3,"1");
						cat.debug("tipo :" + "1");
						
						cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
						cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

						cat.debug("Inicio:insDireccionUsuario:execute");
						cstmt.execute();
						cat.debug("Fin:insDireccionUsuario:execute");

						codError = cstmt.getInt(4);
						msgError = cstmt.getString(5);
						numEvento = cstmt.getInt(6);
						
						cat.debug("Codigo de Error[" + codError + "]");
						cat.debug("Mensaje de Error[" + msgError + "]");
						cat.debug("Numero de Evento[" + numEvento + "]");

						if (codError !=0){
							cat.error("Ocurrió un error al insertar direccion del usuario");
							throw new GeneralException(
									"Ocurrió un error al insertar direccion del usuario", String
									.valueOf(codError), numEvento, msgError);
						}
					

		} catch (GeneralException e) {
		  throw e;		
		} catch (Exception e) {
			cat.error("Ocurrió un error al insertar direccion del usuario",e);
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
		cat.debug("Fin:insDireccionUsuario()");
	}//fin insDireccionUsuario

	public Long existeUsuario(UsuarioDTO usuario)
	throws GeneralException
	{
		Long resultado = new Long(0);
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;

		try {
			cat.debug("Inicio:existeUsuario()");

			//INI-01 (AL) String call = getSQLDatos("Ve_Validacion_Linea_Pg","VE_existeUsuario_PR",6);
			String call = getSQLDatos("Ve_Validacion_Linea_Quiosco_Pg","VE_existeUsuario_PR",6);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,usuario.getNombre());
			cstmt.setString(2,usuario.getPrimerApellido());			
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

			cat.debug("Inicio:existeUsuario:execute");
			cstmt.execute();
			cat.debug("Fin:existeUsuario:execute");

			codError=cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento=cstmt.getInt(6);
			
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError !=0){
				cat.error("Ocurrió un error al obtener usuario");			
				throw new GeneralException(
						"Ocurrió un error al obtener usuario", String
						.valueOf(codError), numEvento, msgError);
			}
			
			resultado = Long.valueOf(cstmt.getString(3));	
			cat.debug("Existe usuario resultado : " + resultado );
			
		} catch (GeneralException e) {
		  throw e;		
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener usuario",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
			cat.debug("Cerrando conexiones...");
			try {
				cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}		
		cat.debug("Fin:existeUsuario");
		return resultado;
	}

	private String getSQLgetConsultaUsuario(){
		StringBuffer call= new StringBuffer();
		call.append("" +
				"BEGIN "+
				" GA_SERVICIOS_ABONADOS_PG.GA_CONS_USUARIO_PR ( ?, ?, ?, ?, ? ); "+
		"END;");

		return call.toString();
	}

	public RetornoDTO getConsultaUsuario(UsuarioDTO usuario)throws GeneralException
	{
		RetornoDTO resultado = new RetornoDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;

		try {
			cat.debug("Inicio:getConsultaUsuario()");

			String call = getSQLgetConsultaUsuario();

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,usuario.getNombre());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getConsultaUsuario:execute");
			cstmt.execute();
			cat.debug("Fin:getConsultaUsuario:execute");

			codError=cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento=cstmt.getInt(5);
			
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError !=0){
				cat.error("Ocurrió un error al obtener usuario");			
				throw new GeneralException(
						"Ocurrió un error al obtener usuario", String
						.valueOf(codError), numEvento, msgError);
			}			
			resultado.setCodError(String.valueOf(cstmt.getInt(2)));	
			cat.debug("Existe usuario resultado : " + resultado );
		} catch (GeneralException e) {
		  throw e;		
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener usuario",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
			cat.debug("Cerrando conexiones...");
			try {
				cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}		
		cat.debug("Fin:getConsultaUsuario");
		return resultado;
	}

	public UsuarioDTO creaUsuarioPrepago(UsuarioDTO usuarioDTO) throws GeneralException{
		cat.debug("Inicio:creaUsuarioPrepago()");
		int codError = 0;
		String resultado = null;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		cat.debug("Coneccion obtenida OK");
		try {
			//INI-01 (AL) String call = getSQLDatos("VE_CREA_LINEA_VENTA_PG","VE_IN_GA_USUAMIST_PR",24);
			String call = getSQLDatos("VE_CREA_LINEA_VENTA_QUIOSCO_PG","VE_IN_GA_USUAMIST_PR",24);

//			VE_CREA_LINEA_VENTA_PG.VE_IN_GA_USUAMIST_PR 

			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);		
			cstmt.setString(1,usuarioDTO.getNumeroAboando());				//EN_NUM_ABONADO NUMBER;
			
			cstmt.setString(2,usuarioDTO.getNombre());		//EV_NOMUSUARIO VARCHAR2(200);
			cstmt.setString(3,usuarioDTO.getPrimerApellido());			//EV_NOMAPELLIDO1 VARCHAR2(200);
			cstmt.setString(4,usuarioDTO.getSegundoApellido());			//EV_NOMAPELLIDO2 VARCHAR2(200);
			cstmt.setString(5,usuarioDTO.getNumeroIdentificacion());				//EV_NUMIDENT VARCHAR2(200);
			cstmt.setString(6,usuarioDTO.getTipIdentificacion());			//EV_CODTIPIDENT VARCHAR2(200);
			cstmt.setString(7,"C");   		//EV_INDESTADO CHAR(1);
			cstmt.setString(8,null);//EV_FECNACIMIEN VARCHAR2(200);			
			cstmt.setString(9,null);		//EV_CODESTCIVIL VARCHAR2(200);
			cstmt.setString(10,null);			//EV_INDSEXO VARCHAR2(200);
			cstmt.setString(11,null);		//EV_INDTIPOTRAB VARCHAR2(200);
			cstmt.setString(12,usuarioDTO.getNomEmpresa());		//EV_NOMEMPRESA VARCHAR2(200);
			cstmt.setString(13,null);			//EV_CODACTEMP NUMBER;
			cstmt.setString(14,usuarioDTO.getOcupacion());		//EV_CODOCUPACION VARCHAR2(200);
			cstmt.setString(15,null);			//EN_NUMPERCARGO NUMBER;
			cstmt.setString(16,usuarioDTO.getIngresosBrutosAnuales());				//EN_IMPBRUTO NUMBER;
			cstmt.setString(17,null);			//EV_INDPROCOPER NUMBER;
			cstmt.setString(18,null);			//EV_CODOPERADOR NUMBER;
			cstmt.setString(19,null);		//EV_NOMCONYUGE VARCHAR2(200);
			cstmt.setString(20,null);		//EV_CODPINUSUAR VARCHAR2(200);
			cstmt.setString(21,usuarioDTO.getCodigoUsuario());			//SN_CODUSUARIO NUMBER;  ---->despues cambiar como entrada
			cstmt.registerOutParameter(22,java.sql.Types.NUMERIC);			//SN_COD_RETORNO NUMBER;
			cstmt.registerOutParameter(23,java.sql.Types.VARCHAR);			//SV_MENS_RETORNO VARCHAR2(200);
			cstmt.registerOutParameter(24,java.sql.Types.NUMERIC);			//SN_NUM_EVENTO NUMBER;

			cat.debug("inicio:Execute");
			cstmt.execute();
			cat.debug("Fin:Execute");

			codError 	= cstmt.getInt(22);
			msgError 	= cstmt.getString(23);
			numEvento 	= cstmt.getInt(24);
			
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");			

			if (codError != 0) {
				cat.error("Ocurrió un error al crear usuario");
				usuarioDTO.setExitoCreacionUsuario(false);
				throw new GeneralException(
						"Ocurrió un error al crear usuario", String
						.valueOf(codError), numEvento, msgError);				
			}
			
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
			
			usuarioDTO.setExitoCreacionUsuario(true);
		}catch (GeneralException e) {
			throw e;
		
		} catch (Exception e) {
			cat.error("Ocurrió un error al crear usuario",e);
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
		cat.debug("Fin:creaUsuarioPrepago()");
		return usuarioDTO;
	}//fin creaUsuario()
	
	
	
	
	public void ValidaUsuarioSCL(String nomUsuario)throws GeneralException
	{		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;

		try {
			cat.debug("Inicio:ValidaUsuarioSCL()");

			String call = getSQLDatos("ve_portabilidad_pg","ve_val_usuario_scl_pr",4);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,nomUsuario);
			cat.debug("nomUsuario ["+nomUsuario+"]");
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getConsultaUsuario:execute");
			cstmt.execute();
			cat.debug("Fin:getConsultaUsuario:execute");

			codError=cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento=cstmt.getInt(4);
			
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError !=0){
				cat.error("Ocurrió un error al obtener usuario");			
				throw new GeneralException(
						"Ocurrió un error al obtener usuario", String
						.valueOf(codError), numEvento, msgError);
			}						
		} catch (GeneralException e) {
		  throw e;		
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener usuario",e);			
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
				throw new GeneralException(e);
		
		} finally {
			cat.debug("Cerrando conexiones...");
			try {
				cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}		
		cat.debug("Fin:getConsultaUsuario");		
	}
	
	

}
