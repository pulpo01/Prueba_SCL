package com.tmmas.cl.scl.customerdomain.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.UsuarioOutDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.UsuarioWebDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.VentasException;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.ClienteDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.UsuarioDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.UsuarioInDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.helper.Global;

public class UsuarioDAO extends ConnectionDAO{
	
	Global global = Global.getInstance();
	private static Category cat = Category.getInstance(UsuarioDAO.class);

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
	
	private String getSQLDatos(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
        for (int n = 1; n <= paramCount; n++) {
            sb.append("?");
            if (n < paramCount) sb.append(",");
        }
        return sb.append(")}").toString();	
	}
	
	public UsuarioDTO creaUsuario (UsuarioDTO entrada) 
		throws CustomerDomainException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		entrada.setExitoCreacionUsuario(false);		
				
		try {
			cat.debug("Inicio:creaUsuario()");
			
			String call = getSQLDatos("VE_crea_linea_venta_PG","VE_IN_ga_usuarios_PR",27);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);			
			
			
			cstmt.setLong(1,Long.parseLong(entrada.getCodigoUsuario()));
			cat.debug("Codigo Usuario:" + entrada.getCodigoUsuario());						
			cstmt.setLong(2,Long.parseLong(entrada.getDatosCliente().getCodigoCuenta()));
			cat.debug("Cuenta Cliente:" + entrada.getDatosCliente().getCodigoCuenta());			
			cstmt.setString(3,entrada.getDatosCliente().getCodigoSubCuenta());
			cat.debug("Sub cuenta:" + entrada.getDatosCliente().getCodigoSubCuenta());			
			cstmt.setString(4,entrada.getNombreUsuario().toUpperCase());
			cat.debug("Nombre Usuario [:" + entrada.getNombreUsuario().toUpperCase() + "]");			
			cstmt.setString(5,entrada.getNombreApell1()!=null?entrada.getNombreApell1().toUpperCase():entrada.getNombreApell1().toUpperCase());
			cat.debug("apellido1:" + entrada.getNombreApell1()!=null?entrada.getNombreApell1().toUpperCase():entrada.getNombreApell1().toUpperCase());			
			cstmt.setString(6,entrada.getNombreApell2().toUpperCase());
			cat.debug("apellido2:" + entrada.getNombreApell2().toUpperCase());			
			cstmt.setString(7,entrada.getNumeroIdentificador());
			cat.debug("numero iden:[" + entrada.getNumeroIdentificador() + "]");			
			cstmt.setString(8,entrada.getTipoIdentificador());
			cat.debug("tipo iden:" + entrada.getTipoIdentificador());			
			cstmt.setString(9,global.getEstadoIncompletoUsuario());
			cat.debug("estado:" + global.getEstadoIncompletoUsuario());			
			cstmt.setString(10, entrada.getFechaNacimiento());			
			String estadoCivil = entrada.getDatosCliente().getIndicadorEstadoCivil();
			estadoCivil = estadoCivil == null ? "X" : estadoCivil.toUpperCase().trim();
			cstmt.setString(11, estadoCivil);						
			String indSexo = entrada.getCodigoSexo();
			indSexo = indSexo == null ? "X" : indSexo.toUpperCase().trim();
			cstmt.setString(12, indSexo);
			cstmt.setString(13,null);
			cstmt.setString(14,null);
			cstmt.setString(15,null);
			cstmt.setString(16,null);
			cstmt.setString(17,null);
			cstmt.setString(18,null);
			cstmt.setString(19,null);
			cstmt.setString(20,null);
			cstmt.setString(21,null);
			cstmt.setString(22,null);
			cstmt.setString(23,entrada.getDatosCliente().getCodigoEstrato());
			cstmt.setString(24,entrada.getNombreMail());
			cstmt.registerOutParameter(25, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(26, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(27, java.sql.Types.NUMERIC);
			
						
			cat.debug("Inicio:creaUsuario:execute");			
			cstmt.execute();			
			cat.debug("Fin:creaUsuario:execute");

			msgError = cstmt.getString(25);
			cat.debug("msgError[" + msgError + "]");			
			
			
			if(cstmt.getInt(25)==0) 
				entrada.setExitoCreacionUsuario(true);
			else
				entrada.setExitoCreacionUsuario(false);
			
			codError=cstmt.getInt(25);
			cat.debug("codError: " + codError);
			numEvento=cstmt.getInt(27);
			cat.debug("numEvento: " + numEvento);
			
			if (codError != 0) {
				cat.error("Ocurrió un error al crear el usuario");
				throw new CustomerDomainException(String.valueOf(codError),
						numEvento, "Ocurrió un error al crear el usuario");
			}
		
		} catch (Exception e) {
			cat.error("Ocurrió un error al crear el usuario",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException ) throw (CustomerDomainException) e;
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

	
	public UsuarioDTO getSecuenciaUsuario() 
		throws CustomerDomainException
	{
		UsuarioDTO resultado = new UsuarioDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		
		try {
			cat.debug("Inicio:getSecuenciaUsuario()");
			
			String call = getSQLDatos("VE_intermediario_PG","VE_OBTIENE_SECUENCIA_PR",5);

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

			msgError = cstmt.getString(4);
			cat.debug("msgError[" + msgError + "]");

			resultado.setCodigoUsuario(cstmt.getString(2));
									
			codError=cstmt.getInt(3);
			numEvento=cstmt.getInt(5);
		
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
	 * Obtiene Datos del Usuario Postpago
	 * @param entrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	 public UsuarioOutDTO getUsuarioPospago(UsuarioDTO entrada) 
	 	throws CustomerDomainException
	 {	  
	  cat.debug("getUsuarioPospago:inicio");
	  UsuarioOutDTO resultado = null;
	  int codError = 0;
	  String msgError = null;
	  int numEvento = 0;
	  Connection conn = null;
	  conn = getConection();
	  cat.debug("Coneccion obtenida OK");
	  CallableStatement cstmt = null;
	  try {
	   String call = getSQLDatos("VE_Servs_ActivacionesWeb_PG","VE_GETLISTUSUARIO_PR",25);
	   cat.debug("sql[" + call + "]");
	   
	   cstmt = conn.prepareCall(call);
	   
	   cstmt.setString(1,entrada.getNumeroAbonado());
	   
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
	   
	   cstmt.registerOutParameter(17,java.sql.Types.VARCHAR);
	   cstmt.registerOutParameter(18,java.sql.Types.VARCHAR);
	   cstmt.registerOutParameter(19,java.sql.Types.VARCHAR);
	   cstmt.registerOutParameter(20,java.sql.Types.VARCHAR);
	   cstmt.registerOutParameter(21,java.sql.Types.VARCHAR);
	   cstmt.registerOutParameter(22,java.sql.Types.VARCHAR);
	   
	 
	   cstmt.registerOutParameter(23,java.sql.Types.NUMERIC);
	   cstmt.registerOutParameter(24,java.sql.Types.VARCHAR);
	   cstmt.registerOutParameter(25,java.sql.Types.NUMERIC);
	 
	   cat.debug("getUsuarioPospago:Execute Antes");
	   cstmt.execute();	   
	   cat.debug("getUsuarioPospago:Execute Despues");
	   
	   codError = cstmt.getInt(23);
	   msgError = cstmt.getString(24);
	   numEvento = cstmt.getInt(25);
	 
	   cat.debug("codError[" + codError + "]");
	   cat.debug("msgError[" + msgError + "]");
	   cat.debug("numEvento[" + numEvento + "]");
	   
	   if (codError != 0) {
	    cat.error("Ocurrió un error al obtener datos del usuario "+entrada.getCodigoUsuario());
	    throw new CustomerDomainException(
	      "Ocurrió un error al consultar el cliente", String
	        .valueOf(codError), numEvento, msgError);
	   }
	   else{
	    resultado = new UsuarioOutDTO();
	    resultado.setNombreUsuario(cstmt.getString(2));
	    resultado.setNombreApell1(cstmt.getString(3));
	    resultado.setNombreApell2(cstmt.getString(4));
	    resultado.setTipoIdentificador(cstmt.getString(5));
	    resultado.setNumeroIdentificador(cstmt.getString(6));
	    resultado.setCodigoProvincia(cstmt.getString(7));
	    resultado.setNombreProvincia(cstmt.getString(8));
	    resultado.setCodigoCiudad(cstmt.getString(9));
	    resultado.setNombreCiudad(cstmt.getString(10));
	    resultado.setNombreCalle(cstmt.getString(11));
	    resultado.setObservacionDireccion(cstmt.getString(12));
	    resultado.setFechaNacimiento(cstmt.getString(13));
	    resultado.setCodigoSexo(cstmt.getString(14));
	    resultado.setCodigoEstrato(cstmt.getString(15));
	    resultado.setNombreMail(cstmt.getString(16));
	    
	    
	    resultado.setCodigoRegion(cstmt.getString(17));
	    resultado.setDescripcionRegion(cstmt.getString(18));
	    resultado.setCodigoComuna(cstmt.getString(19));
	    resultado.setDescripcionComuna(cstmt.getString(20));
	    resultado.setCodigoTipoCalle(cstmt.getString(21));
	    resultado.setDescripcionTipoCalle(cstmt.getString(22));	    
	   }	   
	  } catch (Exception e) {
	   cat.error("Ocurrió un error al obtener datos del usuario",e);
	   if (cat.isDebugEnabled()) {
	    cat.debug("Codigo de Error[" + codError + "]");
	    cat.debug("Mensaje de Error[" + msgError + "]");
	    cat.debug("Numero de Evento[" + numEvento + "]");
	   }
	   if (e instanceof CustomerDomainException ){
           throw (CustomerDomainException) e;
	   }
	  } 
	  finally {
	    if (cat.isDebugEnabled())  cat.debug("Cerrando conexiones...");
		    try {
		      if (cstmt!=null) cstmt.close();
		      if (!conn.isClosed()) conn.close();
		    }
		    catch (SQLException e) {
		      cat.debug("SQLException", e);
		    }
	    }
	    cat.debug("getUsuarioPospago():end");
	    return resultado;
	 }//fin getUsuarioPospago
	 
	/**
	 * Actualiza datos del usuario
	 * @param entrada
	 * @return
	 * @throws CustomerDomainException
	 */
	 public void updUsuario(UsuarioInDTO entrada)
	 	throws CustomerDomainException 
	 {
	  cat.debug("updUsuario:inicio");
	  int codError = 0;
	  String msgError = null;
	  int numEvento = 0;
	  Connection conn = null;
	  conn = getConection();
	  cat.debug("Conexion obtenida OK");
	  CallableStatement cstmt = null;
	  try {
		   String call = getSQLDatos("VE_Servs_ActivacionesWeb_PG","VE_updUsuario_PR",22);
		   cat.debug("sql[" + call + "]");
		   
		   cstmt = conn.prepareCall(call);
		   
		   cstmt.setString(1,entrada.getNumeroAbonado());		   
		   cstmt.setString(2,entrada.getNombreUsuario());      
		   cstmt.setString(3,entrada.getNombreApell1());       
		   cstmt.setString(4,entrada.getNombreApell2());       
		   cstmt.setString(5,entrada.getTipoIdentificador());  
		   cstmt.setString(6,entrada.getNumeroIdentificador());
		   cstmt.setString(7,entrada.getCodigoProvincia());    
		   cstmt.setString(8,entrada.getCodigoCiudad());       
		   cstmt.setString(9,entrada.getNombreCalle());        
		   cstmt.setString(10,entrada.getObservacionDireccion());
		   cstmt.setString(11,entrada.getFechaNacimiento());     
		   cstmt.setString(12,entrada.getCodigoSexo());          
		   cstmt.setString(13,entrada.getCodigoEstrato());       
		   cstmt.setString(14,entrada.getNombreMail());         
		   cstmt.setString(15,entrada.getNombreUsuarioOra());    
		   
		   cstmt.setString(16,entrada.getTipoDireccion());
		   
		   cstmt.setString(17,entrada.getCodigoRegion());
		   cstmt.setString(18,entrada.getCodigoComuna());
		   cstmt.setString(19,entrada.getCodigoTipoCalle());
			  
		   cstmt.registerOutParameter(20,java.sql.Types.NUMERIC);
		   cstmt.registerOutParameter(21,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(22,java.sql.Types.NUMERIC);
	
		   cat.debug("updUsuario:Execute Antes");
		   cstmt.execute();
		   cat.debug("updUsuario:Execute Despues");
		   
		   codError = cstmt.getInt(20);
		   msgError = cstmt.getString(21);
		   numEvento = cstmt.getInt(22);
		 
		   cat.debug("codError[" + codError + "]");
		   cat.debug("msgError[" + msgError + "]");
		   cat.debug("numEvento[" + numEvento + "]");
	
		   if (codError !=0){
				cat.error("Ocurrió un error al obtener actualizar usuario");
				throw new CustomerDomainException(
						"Ocurrió un error al obtener actualizar usuario", String
								.valueOf(codError), numEvento, msgError);
			}
	   } 
	   catch (Exception e) {
		   cat.error("Ocurrió un error al obtener actualizar usuario",e);
		   if (cat.isDebugEnabled()) {
		    cat.debug("Codigo de Error[" + codError + "]");
		    cat.debug("Mensaje de Error[" + msgError + "]");
		    cat.debug("Numero de Evento[" + numEvento + "]");
		   }
		   if (e instanceof CustomerDomainException ){ 
			   throw (CustomerDomainException) e;
		   }
		   else {
			   CustomerDomainException c = new CustomerDomainException();
			   c.setMessage(e.getMessage());
			   throw c;
		   }	   
	  }
	  finally {
		    if (cat.isDebugEnabled()) 
		    cat.debug("Cerrando conexiones...");
		    try {
		       if (cstmt!=null) cstmt.close();
		       if (!conn.isClosed()) conn.close();
		    } 
		    catch (SQLException e) {
		      cat.debug("SQLException", e);
		    }
	  }
	  
	  
	 }//fin updUsuario
	 
	 
		 /**
		 * Inserta direccion del usuario
		 * @param usuarioDTO
		 * @return N/A
		 * @throws CustomerDomainException
		 */
		public void insDireccionUsuario(UsuarioDTO usuarioDTO) 
			throws CustomerDomainException
		{
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			conn = getConection();
			CallableStatement cstmt = null;
			try {
				cat.debug("Inicio:insDireccionUsuario");
				
				String call = getSQLDatos("VE_servicios_direcciones_PG","VE_insDireccionUsuario_PR",6);
				cat.debug("sql[" + call + "]");
				
				if ( usuarioDTO.getDireccionNegocioDTO()!=null ){
					for (int i=0; i<usuarioDTO.getDireccionNegocioDTO().length; i++){
						if (usuarioDTO.getDireccionNegocioDTO()[i]!=null ){
							cstmt = conn.prepareCall(call);
							cstmt.setString(1,String.valueOf(usuarioDTO.getDireccionNegocioDTO()[i].getCodigo()));
							cat.debug("codigo direccion :" + usuarioDTO.getDireccionNegocioDTO()[i].getCodigo());							
							cstmt.setString(2,usuarioDTO.getCodigoUsuario());
							cat.debug("codigo usuario :" + usuarioDTO.getCodigoUsuario());							
							cstmt.setString(3,String.valueOf(usuarioDTO.getDireccionNegocioDTO()[i].getTipo()));
							cat.debug("tipo :" + usuarioDTO.getDireccionNegocioDTO()[i].getTipo());							
							cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
							cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
							
							cat.debug("Inicio:insDireccionUsuario:execute");							
							cstmt.execute();							
							cat.debug("Fin:insDireccionUsuario:execute");
							
							codError = cstmt.getInt(4);
							msgError = cstmt.getString(5);
							numEvento = cstmt.getInt(6);
							
							if (codError !=0){
								cat.error("Ocurrió un error al insertar direccion del usuario");
								throw new CustomerDomainException(
										"Ocurrió un error al insertar direccion del usuario", String
												.valueOf(codError), numEvento, msgError);
							}
						}	
					}//fin for
				}
				
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
		
	public UsuarioWebDTO creaUsuarioWeb (UsuarioWebDTO usuario) 
		throws CustomerDomainException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		usuario.setExitoCreacionUsuario(false);		
				
		try {
			cat.debug("Inicio:creaUsuario()");
			
			String call = getSQLDatos("VE_crea_linea_venta_PG","VE_IN_ga_usuarios_PR",28);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);			
			
			
			cstmt.setLong(1,Long.parseLong(usuario.getCodigoUsuario()));
			cat.debug("Codigo Usuario:" + usuario.getCodigoUsuario());						
			cstmt.setLong(2,Long.parseLong(usuario.getCodigoCuenta()));
			cat.debug("Cuenta Cliente:" + usuario.getCodigoCuenta());			
			cstmt.setString(3,usuario.getCodigoSubCuenta());
			cat.debug("Sub cuenta:" + usuario.getCodigoSubCuenta());			
			cstmt.setString(4,usuario.getNomUsuario().toUpperCase());
			cat.debug("Nombre Usuario [:" + usuario.getNomUsuario().toUpperCase() + "]");			
			cstmt.setString(5,usuario.getNomApell1()!=null?usuario.getNomApell1().toUpperCase():usuario.getNomApell1().toUpperCase());
			cat.debug("apellido1:" + usuario.getNomApell1()!=null?usuario.getNomApell1().toUpperCase():usuario.getNomApell1().toUpperCase());			
			cstmt.setString(6,usuario.getNomApell2().toUpperCase());
			cat.debug("apellido2:" + usuario.getNomApell2().toUpperCase());			
			cstmt.setString(7,usuario.getNumIdent());
			cat.debug("numero iden:[" + usuario.getNumIdent() + "]");			
			cstmt.setString(8,usuario.getTipIdent());
			cat.debug("tipo iden:" + usuario.getTipIdent());			
			cstmt.setString(9,global.getEstadoIncompletoUsuario());
			cat.debug("estado:" + global.getEstadoIncompletoUsuario());			
			cstmt.setString(10, usuario.getFechaNacimiento());			
			String estadoCivil = usuario.getCodEstCivil();
			/*estadoCivil = estadoCivil == null ? "X" : estadoCivil.toUpperCase().trim();*/
			cstmt.setString(11, estadoCivil);						
			String indSexo = usuario.getIndSexo();
			/*indSexo = indSexo == null ? "X" : indSexo.toUpperCase().trim();*/
			cstmt.setString(12, indSexo);
			cstmt.setString(13,null);
			cstmt.setString(14,null);
			cstmt.setString(15,null);
			cstmt.setString(16,null);
			cstmt.setString(17,null);
			cstmt.setString(18,null);
			cstmt.setString(19,null);
			cstmt.setString(20,null);
			cstmt.setString(21,null);
			cstmt.setString(22,null);
			cstmt.setString(23,usuario.getCodigoEstrato());
			cstmt.setString(24,usuario.getEmail());
			cstmt.setString(25,usuario.getNumTelefono());
			
			cstmt.registerOutParameter(26, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(27, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(28, java.sql.Types.NUMERIC);
			
						
			cat.debug("Inicio:creaUsuario:execute");			
			cstmt.execute();			
			cat.debug("Fin:creaUsuario:execute");

			msgError = cstmt.getString(27);
			cat.debug("msgError[" + msgError + "]");			
			
			
			if(cstmt.getInt(26)==0) 
				usuario.setExitoCreacionUsuario(true);
			else
				usuario.setExitoCreacionUsuario(false);
			
			codError=cstmt.getInt(26);
			cat.debug("codError: " + codError);
			numEvento=cstmt.getInt(28);
			cat.debug("numEvento: " + numEvento);
			
			if (codError != 0) {
				cat.error("Ocurrió un error al crear el usuario");
				throw new CustomerDomainException(String.valueOf(codError),
						numEvento, "Ocurrió un error al crear el usuario");
			}
		
		} catch (Exception e) {
			cat.error("Ocurrió un error al crear el usuario",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException ) throw (CustomerDomainException) e;
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

		return usuario;
	}
	
	
	public void insDireccionUsuarioWeb(UsuarioWebDTO usuarioDTO) 
		throws CustomerDomainException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			cat.debug("Inicio:insDireccionUsuario");
			
			String call = getSQLDatos("VE_servicios_direcciones_PG","VE_insDireccionUsuario_PR",6);
			cat.debug("sql[" + call + "]");
			
			if ( usuarioDTO.getDirecciones()!=null ){
				for (int i=0; i<usuarioDTO.getDirecciones().length; i++){
					if (usuarioDTO.getDirecciones()[i]!=null ){
						cstmt = conn.prepareCall(call);
						cstmt.setString(1,String.valueOf(usuarioDTO.getDirecciones()[i].getCodigo()));
						cat.debug("codigo direccion :" + usuarioDTO.getDirecciones()[i].getCodigo());							
						cstmt.setString(2,usuarioDTO.getCodigoUsuario());
						cat.debug("codigo usuario :" + usuarioDTO.getCodigoUsuario());							
						cstmt.setString(3,String.valueOf(usuarioDTO.getDirecciones()[i].getTipo()));
						cat.debug("tipo :" + usuarioDTO.getDirecciones()[i].getTipo());							
						cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
						cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
						
						cat.debug("Inicio:insDireccionUsuario:execute");							
						cstmt.execute();							
						cat.debug("Fin:insDireccionUsuario:execute");
						
						codError = cstmt.getInt(4);
						msgError = cstmt.getString(5);
						numEvento = cstmt.getInt(6);
						
						if (codError !=0){
							cat.error("Ocurrió un error al insertar direccion del usuario");
							throw new CustomerDomainException(
									"Ocurrió un error al insertar direccion del usuario", String
											.valueOf(codError), numEvento, msgError);
						}
					}	
				}//fin for
			}
			
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
	
	public UsuarioWebDTO creaUsuarioWebPrepago (UsuarioWebDTO usuario) 
		throws CustomerDomainException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		usuario.setExitoCreacionUsuario(false);		
				
		try {
			cat.debug("Inicio:creaUsuario()");
			
			String call = getSQLDatos("VE_crea_linea_venta_PG","VE_INS_USUAMIST_PR",11);
	
			cat.debug("sql[" + call + "]");
	
			cstmt = conn.prepareCall(call);			
			
			
			cstmt.setLong(1,usuario.getNumAbonado());
			cat.debug("Num Abonado:" + usuario.getNumAbonado());			
			cstmt.setString(2,usuario.getTipIdent());
			cat.debug("Sub tipident:" + usuario.getTipIdent());			
			cstmt.setString(3,usuario.getNumIdent().toUpperCase());
			cat.debug("Num ident [:" + usuario.getNumIdent().toUpperCase() + "]");			
			cstmt.setLong(4,Long.parseLong(usuario.getCodigoUsuario()));
			cat.debug("Codigo Usuario:" + usuario.getCodigoUsuario());
			cstmt.setString(5, usuario.getFechaNacimiento());
			cat.debug("Fecha nacimiento:" + usuario.getFechaNacimiento());
			cstmt.setString(6,usuario.getNomUsuario()!=null?usuario.getNomUsuario().toUpperCase():usuario.getNomUsuario().toUpperCase());
			cat.debug("nomUsuario:" + usuario.getNomUsuario()!=null?usuario.getNomUsuario().toUpperCase():usuario.getNomUsuario().toUpperCase());
			cstmt.setString(7,usuario.getNomApell1()!=null?usuario.getNomApell1().toUpperCase():usuario.getNomApell1().toUpperCase());
			cat.debug("apellido1:" + usuario.getNomApell1()!=null?usuario.getNomApell1().toUpperCase():usuario.getNomApell1().toUpperCase());			
			cstmt.setString(8,usuario.getNomApell2().toUpperCase());
			cat.debug("apellido2:" + usuario.getNomApell2().toUpperCase());			
			
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);			
						
			cat.debug("Inicio:creaUsuario:execute");			
			cstmt.execute();			
			cat.debug("Fin:creaUsuario:execute");
	
			msgError = cstmt.getString(9);
			cat.debug("msgError[" + msgError + "]");			
			
			
			if(cstmt.getInt(9)==0) 
				usuario.setExitoCreacionUsuario(true);
			else
				usuario.setExitoCreacionUsuario(false);
			
			codError=cstmt.getInt(9);
			cat.debug("codError: " + codError);
			numEvento=cstmt.getInt(11);
			cat.debug("numEvento: " + numEvento);
			
			if (codError != 0) {
				cat.error("Ocurrió un error al crear el usuario");
				throw new CustomerDomainException(String.valueOf(codError),
						numEvento, "Ocurrió un error al crear el usuario");
			}
		
		} catch (Exception e) {
			cat.error("Ocurrió un error al crear el usuario",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException ) throw (CustomerDomainException) e;
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
	
		return usuario;
	}
	
	
	public void sendToMailPL(long ventaId) throws GeneralException {
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			cat.debug("Inicio:sendToMailPL");
			String call = getSQLDatos("VE_SERVICIOS_VENTA_PG","VE_Envia_CorreosInstalacion_PR",4);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1,ventaId);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cat.debug("Inicio:sendToMailPL:execute");							
			cstmt.execute();							
			cat.debug("Fin:sendToMailPL:execute");
			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);
			if (codError !=0){
				cat.error("Ocurrió un error al ejecutar el envío de Correo");
				throw new CustomerDomainException("Ocurrió un error al ejecutar el envío de Correo", String.valueOf(codError), numEvento, msgError);
				}//fin for
			
			
		} catch (Exception e) {
			cat.error("Ocurrió un error al ejecutar el envío de Correo",e);
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
	cat.debug("Fin:sendToMailPL()");
	}//fin insDireccionUsuario

}
