package com.tmmas.cl.scl.customerdomain.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.UsuarioOutDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.UsuarioWebDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dao.UsuarioDAO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.ClienteDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.UsuarioDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.UsuarioInDTO;


public class Usuario extends PartyRoleProductInvolvement{
	private UsuarioDAO usuarioDAO  = new UsuarioDAO();
	
	private static Category cat = Category.getInstance(Usuario.class);
	
	
	public UsuarioDTO getSecuenciaUsuario()throws CustomerDomainException{
		UsuarioDTO resultado = new UsuarioDTO();
		cat.debug("Inicio:getSecuenciaUsuario()");
		resultado = usuarioDAO.getSecuenciaUsuario(); 
		cat.debug("Fin:getSecuenciaUsuario()");
		return resultado;
	}
	
	public UsuarioDTO creaNuevoUsuario(UsuarioDTO entrada)throws CustomerDomainException{
		UsuarioDTO resultado = new UsuarioDTO();
		cat.debug("Inicio:creaNuevoUsuario()");
		resultado = usuarioDAO.creaUsuario(entrada); 
		cat.debug("Fin:creaNuevoUsuario()");
		return resultado;
	}
	
	/**
	 * Obtiene Datos del Usuario Postpago
	 * @param entrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	 public UsuarioOutDTO getUsuarioPospago(UsuarioDTO entrada) 
	 throws CustomerDomainException{
	  UsuarioOutDTO resultado = null;
	  cat.debug("Inicio:getUsuarioPospago()");
	  resultado = usuarioDAO.getUsuarioPospago(entrada); 
	  cat.debug("Fin:getUsuarioPospago()");
	  return resultado;
	 }//fin getUsuarioPospago
	 
	 //Inicio COL-07011-Igor-
		/**
		 * Actualiza datos del usuario
		 * @param entrada
		 * @return 
		 * @throws CustomerDomainException
		 */
		 public void updUsuario(UsuarioInDTO entrada) 
		 throws CustomerDomainException{
		  cat.debug("Inicio:updUsuario()");
		  usuarioDAO.updUsuario(entrada); 
		  cat.debug("Fin:updUsuario()");
		 }//fin getUsuarioPospago
	
	 //Fin COL-07011-Igor-

	 /**
	 * Inserta direccion del usuario
	 * @param usuarioDTO
	 * @return N/A
	 * @throws CustomerDomainException
	 */
	public void insDireccionUsuario(UsuarioDTO usuarioDTO) 
		throws CustomerDomainException
	{
		cat.debug("Inicio:insDireccionUsuario()");
		usuarioDAO.insDireccionUsuario(usuarioDTO);
		cat.debug("Fin:insDireccionUsuario()");
	}
	
	public UsuarioWebDTO creaNuevoUsuarioWeb(UsuarioWebDTO entrada)
		throws CustomerDomainException
	{
		UsuarioWebDTO resultado = new UsuarioWebDTO();
		cat.debug("Inicio:creaNuevoUsuario()");
		resultado = usuarioDAO.creaUsuarioWeb(entrada); 
		cat.debug("Fin:creaNuevoUsuario()");
		return resultado;
	}
	
	 /**
	 * Inserta direccion del usuario
	 * @param usuarioDTO
	 * @return N/A
	 * @throws CustomerDomainException
	 */
	public void insDireccionUsuarioWeb(UsuarioWebDTO usuarioDTO) 
		throws CustomerDomainException
	{
		cat.debug("Inicio:insDireccionUsuario()");
		usuarioDAO.insDireccionUsuarioWeb(usuarioDTO);
		cat.debug("Fin:insDireccionUsuario()");
	}
	
	public UsuarioWebDTO creaNuevoUsuarioWebPrepago(UsuarioWebDTO entrada)
		throws CustomerDomainException
	{
		UsuarioWebDTO resultado = new UsuarioWebDTO();
		cat.debug("Inicio:creaNuevoUsuarioWebPrepago()");
		resultado = usuarioDAO.creaUsuarioWebPrepago(entrada); 
		cat.debug("Fin:creaNuevoUsuarioWebPrepago()");
		return resultado;
	}
	
	public void sendToMailPL(long ventaId)	throws GeneralException
	{
		cat.debug("Inicio:creaNuevoUsuarioWebPrepago()");
		usuarioDAO.sendToMailPL(ventaId); 
		cat.debug("Fin:creaNuevoUsuarioWebPrepago()");
	}

}
