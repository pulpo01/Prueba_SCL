package com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper;

public interface InterBitaForm {

	public abstract void setPagina(String pagina);
	public abstract String getPagina();
	public abstract void setAccion(int accion);
	public abstract int getAccion();
	public int CANCELAR=0;
	public int ACEPTAR=1;
}