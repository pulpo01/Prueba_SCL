package com.tmmas.scl.framework.aplicationDomain.dao.interfaces;

import com.tmmas.scl.framework.aplicationDomain.dto.UsuarioSistemaDTO;
import com.tmmas.scl.framework.aplicationDomain.exception.AplicationException;

public interface  UsuarioSistemaDAOIT {

	public UsuarioSistemaDTO obtenerInformacionUsuario(UsuarioSistemaDTO UsuarioSistema) throws AplicationException;
}
