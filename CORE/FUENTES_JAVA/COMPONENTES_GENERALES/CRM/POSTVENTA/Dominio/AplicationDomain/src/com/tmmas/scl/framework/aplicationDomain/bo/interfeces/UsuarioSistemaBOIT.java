package com.tmmas.scl.framework.aplicationDomain.bo.interfeces;

import com.tmmas.scl.framework.aplicationDomain.dto.UsuarioSistemaDTO;
import com.tmmas.scl.framework.aplicationDomain.exception.AplicationException;

public interface UsuarioSistemaBOIT {

	public UsuarioSistemaDTO obtenerInformacionUsuario(UsuarioSistemaDTO UsuarioSistema) throws AplicationException;
}
