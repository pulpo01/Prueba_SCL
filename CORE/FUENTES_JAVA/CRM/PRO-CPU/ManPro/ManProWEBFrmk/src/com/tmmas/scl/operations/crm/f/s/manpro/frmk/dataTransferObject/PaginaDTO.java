package com.tmmas.scl.operations.crm.f.s.manpro.frmk.dataTransferObject;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

public class PaginaDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	Map secciones=new HashMap();

	public Map getSecciones() {
		return secciones;
	}

	public void setSecciones(Map secciones) {
		this.secciones = secciones;
	}
	
	public void addSeccion(String id, SeccionDTO seccion){
		secciones.put(id, seccion);
	}
	
	public SeccionDTO obtSeccion(String id){
		return (SeccionDTO)secciones.get(id);
	}
	
}
