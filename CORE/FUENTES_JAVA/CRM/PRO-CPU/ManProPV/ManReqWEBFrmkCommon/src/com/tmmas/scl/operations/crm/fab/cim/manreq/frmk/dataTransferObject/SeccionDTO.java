package com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

public class SeccionDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	private String visible;
	Map controles=new HashMap();
	

	public Map getControles() {
		return controles;
	}

	public void setControles(Map controles) {
		this.controles = controles;
	}

	public String getVisible() {
		return visible;
	}

	public void setVisible(String visible) {
		this.visible = visible;
	}
	
	public void addControl(String id, ControlDTO control){
		controles.put(id, control);
	}
	
	public ControlDTO obtControl(String id){
		return (ControlDTO)controles.get(id);
	}
}
