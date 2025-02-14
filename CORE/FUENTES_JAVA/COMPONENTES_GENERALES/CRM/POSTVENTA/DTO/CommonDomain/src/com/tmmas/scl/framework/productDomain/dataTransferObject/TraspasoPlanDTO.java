/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 17/05/2007	     	Elizabeth Vera        				Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;

public class TraspasoPlanDTO implements Serializable {
	private static final long serialVersionUID = 1L;	
 	private long numAbonado;
 	private long codClienteNue;
 	private long codCuentaNue;
 	private String codSubCtaNue;
 	private long codUsuarioNue;
 	private int codProducto;
	private String numTerminal;
	private long numAbonadoAnt;
	private long codClienteAnt;
	private long codCuentaAnt;
	private String codSubCtaAnt; 
	private long codUsuarioAnt;
	private String indTrasDeuda;
	private String nomUsuarioOra;
	private String indTraspaso;
	private String codPlanTarifOrig;
	private String codPlanTarifDest;
	private int codVendedor;
	
	public long getCodClienteAnt() {
		return codClienteAnt;
	}
	public void setCodClienteAnt(long codClienteAnt) {
		this.codClienteAnt = codClienteAnt;
	}
	public long getCodClienteNue() {
		return codClienteNue;
	}
	public void setCodClienteNue(long codClienteNue) {
		this.codClienteNue = codClienteNue;
	}
	public long getCodCuentaAnt() {
		return codCuentaAnt;
	}
	public void setCodCuentaAnt(long codCuentaAnt) {
		this.codCuentaAnt = codCuentaAnt;
	}
	public long getCodCuentaNue() {
		return codCuentaNue;
	}
	public void setCodCuentaNue(long codCuentaNue) {
		this.codCuentaNue = codCuentaNue;
	}
	public String getCodPlanTarifDest() {
		return codPlanTarifDest;
	}
	public void setCodPlanTarifDest(String codPlanTarifDest) {
		this.codPlanTarifDest = codPlanTarifDest;
	}
	public String getCodPlanTarifOrig() {
		return codPlanTarifOrig;
	}
	public void setCodPlanTarifOrig(String codPlanTarifOrig) {
		this.codPlanTarifOrig = codPlanTarifOrig;
	}
	public int getCodProducto() {
		return codProducto;
	}
	public void setCodProducto(int codProducto) {
		this.codProducto = codProducto;
	}
	public String getCodSubCtaAnt() {
		return codSubCtaAnt;
	}
	public void setCodSubCtaAnt(String codSubCtaAnt) {
		this.codSubCtaAnt = codSubCtaAnt;
	}
	public String getCodSubCtaNue() {
		return codSubCtaNue;
	}
	public void setCodSubCtaNue(String codSubCtaNue) {
		this.codSubCtaNue = codSubCtaNue;
	}
	public long getCodUsuarioAnt() {
		return codUsuarioAnt;
	}
	public void setCodUsuarioAnt(long codUsuarioAnt) {
		this.codUsuarioAnt = codUsuarioAnt;
	}
	public long getCodUsuarioNue() {
		return codUsuarioNue;
	}
	public void setCodUsuarioNue(long codUsuarioNue) {
		this.codUsuarioNue = codUsuarioNue;
	}
	public int getCodVendedor() {
		return codVendedor;
	}
	public void setCodVendedor(int codVendedor) {
		this.codVendedor = codVendedor;
	}
	public String getIndTrasDeuda() {
		return indTrasDeuda;
	}
	public void setIndTrasDeuda(String indTrasDeuda) {
		this.indTrasDeuda = indTrasDeuda;
	}
	public String getIndTraspaso() {
		return indTraspaso;
	}
	public void setIndTraspaso(String indTraspaso) {
		this.indTraspaso = indTraspaso;
	}
	public String getNomUsuarioOra() {
		return nomUsuarioOra;
	}
	public void setNomUsuarioOra(String nomUsuarioOra) {
		this.nomUsuarioOra = nomUsuarioOra;
	}
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
	public long getNumAbonadoAnt() {
		return numAbonadoAnt;
	}
	public void setNumAbonadoAnt(long numAbonadoAnt) {
		this.numAbonadoAnt = numAbonadoAnt;
	}
	public String getNumTerminal() {
		return numTerminal;
	}
	public void setNumTerminal(String numTerminal) {
		this.numTerminal = numTerminal;
	}
	
}
