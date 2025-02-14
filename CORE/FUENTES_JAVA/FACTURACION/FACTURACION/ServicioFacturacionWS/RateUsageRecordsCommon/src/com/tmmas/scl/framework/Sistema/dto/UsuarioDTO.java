package com.tmmas.scl.framework.Sistema.dto;

import java.io.Serializable;

public class UsuarioDTO implements Serializable {
private String rol;
private String idUsuario;
public String getIdUsuario() {
	return idUsuario;
}
public void setIdUsuario(String idUsuario) {
	this.idUsuario = idUsuario;
}
public String getRol() {
	return rol;
}
public void setRol(String rol) {
	this.rol = rol;
}

}
