package com.tmmas.cl.scl.gestiondeabonados.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dao.UsuarioDAO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CuentaComDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.UsuarioDTO;


public class UsuarioBO {
	private UsuarioDAO usuarioDAO  = new UsuarioDAO();
	
	private static Category cat = Category.getInstance(UsuarioBO.class);
	
	
	public UsuarioDTO getSecuenciaUsuario()throws GeneralException{
		UsuarioDTO resultado = new UsuarioDTO();
		cat.debug("Inicio:getSecuenciaUsuario()");
		resultado = usuarioDAO.getSecuenciaUsuario(); 
		cat.debug("Fin:getSecuenciaUsuario()");
		return resultado;
	}
	
	public UsuarioDTO creaNuevoUsuario(UsuarioDTO entrada)throws GeneralException{
		UsuarioDTO resultado = new UsuarioDTO();
		cat.debug("Inicio:creaNuevoUsuario()");
		
		
		if( entrada.getTipUsuario().equalsIgnoreCase("PRE")) {
			resultado = usuarioDAO.creaUsuarioPrepago(entrada);	
		}else if (entrada.getTipUsuario().equalsIgnoreCase("POS")){
			resultado = usuarioDAO.creaUsuario(entrada);
		}else{
			throw new GeneralException("10044",0,"Error Creacion Ususario");	
		}		
		 
		cat.debug("Fin:creaNuevoUsuario()");
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
		cat.debug("Inicio:insDireccionUsuario()");
		usuarioDAO.insDireccionUsuario(usuarioDTO);
		cat.debug("Fin:insDireccionUsuario()");
	}
	
	/**
	 * Valida si usuario existe
	 * @param usuarioDTO
	 * @return N/A
	 * @throws GeneralException
	 */
	public Long existeUsuario(UsuarioDTO usuarioDTO) 
	throws GeneralException{
		cat.debug("Inicio:existeUsuario()");
		Long resultado = usuarioDAO.existeUsuario(usuarioDTO);
		cat.debug("Fin:existeUsuario()");
		return resultado;
	}
	
	public RetornoDTO getConsultaUsuario(UsuarioDTO usuario)throws GeneralException{
		cat.debug("Inicio:getConsultaUsuario()");
		RetornoDTO resultado = usuarioDAO.getConsultaUsuario(usuario);
		cat.debug("Fin:getConsultaUsuario()");
		return resultado;
	}
	
	public void ValidaUsuarioSCL(String nomUsuario)throws GeneralException
	{
		cat.debug("Inicio:getConsultaUsuario()");
		usuarioDAO.ValidaUsuarioSCL(nomUsuario);
		cat.debug("Fin:getConsultaUsuario()");		
	}	

}
