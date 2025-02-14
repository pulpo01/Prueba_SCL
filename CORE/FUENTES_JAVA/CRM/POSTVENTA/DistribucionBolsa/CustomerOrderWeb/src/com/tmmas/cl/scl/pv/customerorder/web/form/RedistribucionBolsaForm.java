package com.tmmas.cl.scl.pv.customerorder.web.form;



import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;



public class RedistribucionBolsaForm extends ActionForm {

	private static final long serialVersionUID = 1L;
	private String accion;
	private int minutesToAssign[];
	private int[] unidadesA;
	private int[] unidadesB;
	private String minutosTotal;
	private long unidadesLibres;
	private String moduloOrigen;
	private String codPlanTarifSelec;
	private String planCB;
	
	public String getPlanCB() {
		return planCB;
	}

	public void setPlanCB(String planCB) {
		this.planCB = planCB;
	}

	public void reset(ActionMapping mapping, HttpServletRequest request) {
		//accion = "mostrar";
		accion = "mostrarPlanes"; 
		minutesToAssign=null;
		minutosTotal = "";
	}

	public ActionErrors validate(ActionMapping mapping, HttpServletRequest request) {
        int i;
        int suma = 0;
        
		if (accion == "modificar"){
			
			if(unidadesA[0] == 0){
				for (i=0 ; i < minutesToAssign.length ; i++){
					suma =  suma + minutesToAssign[i];
				}
				if (suma == new Integer(minutosTotal).intValue()) {
					
				}
			}
			else if(unidadesA[1] == 0){
				
			}
		}
		
		return super.validate(mapping, request);
	}

	public String getAccion() {
		return accion;
	}

	public void setAccion(String accion) {
		this.accion = accion;
	}

	public int[] getMinutesToAssign() {
		return minutesToAssign;
	}

	public void setMinutesToAssign(int[] minutesToAssign) {
		this.minutesToAssign = minutesToAssign;
	}

	public int[] getUnidadesA() {
		return unidadesA;
	}

	public void setUnidadesA(int[] unidadesA) {
		this.unidadesA = unidadesA;
	}

	public int[] getUnidadesB() {
		return unidadesB;
	}

	public void setUnidadesB(int[] unidadesB) {
		this.unidadesB = unidadesB;
	}

	public String getMinutosTotal() {
		return minutosTotal;
	}

	public void setMinutosTotal(String minutosTotal) {
		this.minutosTotal = minutosTotal;
	}

	public long getUnidadesLibres() {
		return unidadesLibres;
	}

	public void setUnidadesLibres(long unidadesLibres) {
		this.unidadesLibres = unidadesLibres;
	}

	public String getModuloOrigen() {
		return moduloOrigen;
	}

	public void setModuloOrigen(String moduloOrigen) {
		this.moduloOrigen = moduloOrigen;
	}

	public String getCodPlanTarifSelec() {
		return codPlanTarifSelec;
	}

	public void setCodPlanTarifSelec(String codPlanTarifSelec) {
		this.codPlanTarifSelec = codPlanTarifSelec;
	}


}
