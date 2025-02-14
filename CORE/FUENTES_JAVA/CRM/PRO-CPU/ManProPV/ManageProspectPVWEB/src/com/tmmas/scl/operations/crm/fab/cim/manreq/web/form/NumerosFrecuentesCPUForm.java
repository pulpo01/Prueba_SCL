/**
 * 
 */
package com.tmmas.scl.operations.crm.fab.cim.manreq.web.form;

import org.apache.struts.action.ActionForm;

/**
 * @author santiago
 *
 */
public class NumerosFrecuentesCPUForm extends ActionForm {
	
	private static final long serialVersionUID = 1L;		
	private String actualizaNumFrecCPU;
	private String cancelaNumFrec;	
	private String numFrecArr;
	private String tiposNumArr;
	private String codTiposNumArr;	
	
	private int cantidadFinalNumerosMoviles;
	private int cantidadFinalNumerosFijos;
	
	private String paginaRegreso;
	
	public String getNumFrecArr() {
		return numFrecArr;
	}

	public void setNumFrecArr(String numFrecArr) {
		this.numFrecArr = numFrecArr;
	}

	/**
	 * @return the actualizaNumFrecCPU
	 */
	public String getActualizaNumFrecCPU() {
		return actualizaNumFrecCPU;
	}

	/**
	 * @param actualizaNumFrecCPU the actualizaNumFrecCPU to set
	 */
	public void setActualizaNumFrecCPU(String actualizaNumFrecCPU) {
		this.actualizaNumFrecCPU = actualizaNumFrecCPU;
	}

	/**
	 * @return the codTiposNumArr
	 */
	public String getCodTiposNumArr() {
		return codTiposNumArr;
	}

	/**
	 * @param codTiposNumArr the codTiposNumArr to set
	 */
	public void setCodTiposNumArr(String codTiposNumArr) {
		this.codTiposNumArr = codTiposNumArr;
	}

	/**
	 * @return the tiposNumArr
	 */
	public String getTiposNumArr() {
		return tiposNumArr;
	}

	/**
	 * @param tiposNumArr the tiposNumArr to set
	 */
	public void setTiposNumArr(String tiposNumArr) {
		this.tiposNumArr = tiposNumArr;
	}

	/**
	 * @return the cancelaNumFrec
	 */
	public String getCancelaNumFrec() {
		return cancelaNumFrec;
	}

	/**
	 * @param cancelaNumFrec the cancelaNumFrec to set
	 */
	public void setCancelaNumFrec(String cancelaNumFrec) {
		this.cancelaNumFrec = cancelaNumFrec;
	}

	/**
	 * @return the cantidadFinalNumerosFijos
	 */
	public int getCantidadFinalNumerosFijos() {
		return cantidadFinalNumerosFijos;
	}

	/**
	 * @param cantidadFinalNumerosFijos the cantidadFinalNumerosFijos to set
	 */
	public void setCantidadFinalNumerosFijos(int cantidadFinalNumerosFijos) {
		this.cantidadFinalNumerosFijos = cantidadFinalNumerosFijos;
	}

	/**
	 * @return the cantidadFinalNumerosMoviles
	 */
	public int getCantidadFinalNumerosMoviles() {
		return cantidadFinalNumerosMoviles;
	}

	/**
	 * @param cantidadFinalNumerosMoviles the cantidadFinalNumerosMoviles to set
	 */
	public void setCantidadFinalNumerosMoviles(int cantidadFinalNumerosMoviles) {
		this.cantidadFinalNumerosMoviles = cantidadFinalNumerosMoviles;
	}

	public String getPaginaRegreso() {
		return paginaRegreso;
	}

	public void setPaginaRegreso(String paginaRegreso) {
		this.paginaRegreso = paginaRegreso;
	}
    
}
