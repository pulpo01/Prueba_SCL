package com.tmmas.cl.scl.customerdomain.businessobject.bo;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dao.UsuarioSCLDAO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.SeguridadPerfilesDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.UsuarioSCLDTO;

public class UsuarioSCL {
	private UsuarioSCLDAO usuarioDAO = new UsuarioSCLDAO();
	
	public UsuarioSCLDTO validaUsuarioSistema(UsuarioSCLDTO usuario)
		throws CustomerDomainException 
	{
		return usuarioDAO.validaUsuarioSistema(usuario);
	}
	
	public UsuarioSCLDTO validaUsuarioSinPerfil(UsuarioSCLDTO usuario)
		throws CustomerDomainException 
	{
		UsuarioSCLDTO respuesta = new UsuarioSCLDTO();
		respuesta=usuarioDAO.validaUsuarioSinPerfil(usuario);
		return respuesta;
	}
	
	public UsuarioSCLDTO getMenuUsuario(UsuarioSCLDTO usuario)
		throws CustomerDomainException 
	{
		UsuarioSCLDTO respuesta = new UsuarioSCLDTO();
		respuesta=usuarioDAO.getMenuUsuario(usuario);
		return respuesta;
	}
	
	public void validaFiltroImpresion(SeguridadPerfilesDTO seguridadPerfilesDTO) throws CustomerDomainException {
		usuarioDAO.validaFiltroImpresion(seguridadPerfilesDTO);
	}
	
}
