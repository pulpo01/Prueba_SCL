package com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper;

import java.util.ArrayList;
import java.util.List;

public class FlujoNavegacionPag {
	
	private String pagSgte;
	private String pagAnte;
	private String pagBase;
	private String condicciCK;
	
	
	List pilaPag= new ArrayList();
	
	public void push(String param){
		pilaPag.add(param);
	}
	
	public String pop(){
		String anterior=null;
		if(!pilaPag.isEmpty()&&pilaPag.size()>0){
			anterior= String.valueOf(pilaPag.remove(pilaPag.size()-1));
		}
		return anterior;
		
	}
	
	public String getPagSgte() {
		return pagSgte;
	}
	public void setPagSgte(String pagSgte) {
		this.pagSgte = pagSgte;
	}

	public String getPagAnte() {
		return pagAnte;
	}

	public void setPagAnte(String pagAnte) {
		this.pagAnte = pagAnte;
	}

	public List getPilaPag() {
		return pilaPag;
	}

	public void setPilaPag(List pilaPag) {
		this.pilaPag = pilaPag;
	}
	
	
	public String getCondicciCK() {
		return condicciCK;
	}

	public void setCondicciCK(String condicciCK) {
		this.condicciCK = condicciCK;
	}

	public String getPagBase() {
		return pagBase;
	}

	public void setPagBase(String pagBase) {
		this.pagBase = pagBase;
	}
	
	

}
