/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 18/05/2007	     	Elizabeth Vera        				Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;

public class ReordenamientoDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private long codClienteOrigen;
	private long codClienteDestino;
	private long codCuentaOrigen;
	private long codCuentaDestino;
	private long numAbonado;
	private String codSubCuentaOrigen;
	private String codSubCuentaDestino;	
	private String codPlanTarifDestino;
	private int codProducto;
	private String usuarioOracle;
	private String codActAbo;
	private String codTipoContrato;
	private String codTipoTraspaso;
	private String numContrato;
	private String numAnexo;
	private String usuarioOrigen;
	private String usuarioDestino;
	private String codTipoMovimiento;
	private long numCelular;
	private long empresaOrigen;
	private long empresaDestino;

	public String getCodTipoTraspaso() {
		return codTipoTraspaso;
	}
	public void setCodTipoTraspaso(String codTipoTraspaso) {
		this.codTipoTraspaso = codTipoTraspaso;
	}
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
	public String getCodActAbo() {
		return codActAbo;
	}
	public void setCodActAbo(String codActAbo) {
		this.codActAbo = codActAbo;
	}
	public long getCodClienteDestino() {
		return codClienteDestino;
	}
	public void setCodClienteDestino(long codClienteDestino) {
		this.codClienteDestino = codClienteDestino;
	}
	public long getCodClienteOrigen() {
		return codClienteOrigen;
	}
	public void setCodClienteOrigen(long codClienteOrigen) {
		this.codClienteOrigen = codClienteOrigen;
	}
	public long getCodCuentaDestino() {
		return codCuentaDestino;
	}
	public void setCodCuentaDestino(long codCuentaDestino) {
		this.codCuentaDestino = codCuentaDestino;
	}
	public long getCodCuentaOrigen() {
		return codCuentaOrigen;
	}
	public void setCodCuentaOrigen(long codCuentaOrigen) {
		this.codCuentaOrigen = codCuentaOrigen;
	}
	public String getCodPlanTarifDestino() {
		return codPlanTarifDestino;
	}
	public void setCodPlanTarifDestino(String codPlanTarifDestino) {
		this.codPlanTarifDestino = codPlanTarifDestino;
	}
	public int getCodProducto() {
		return codProducto;
	}
	public void setCodProducto(int codProducto) {
		this.codProducto = codProducto;
	}
	public String getCodSubCuentaDestino() {
		return codSubCuentaDestino;
	}
	public void setCodSubCuentaDestino(String codSubCuentaDestino) {
		this.codSubCuentaDestino = codSubCuentaDestino;
	}
	public String getCodSubCuentaOrigen() {
		return codSubCuentaOrigen;
	}
	public void setCodSubCuentaOrigen(String codSubCuentaOrigen) {
		this.codSubCuentaOrigen = codSubCuentaOrigen;
	}
	public String getCodTipoContrato() {
		return codTipoContrato;
	}
	public void setCodTipoContrato(String codTipoContrato) {
		this.codTipoContrato = codTipoContrato;
	}
	public String getCodTipoMovimiento() {
		return codTipoMovimiento;
	}
	public void setCodTipoMovimiento(String codTipoMovimiento) {
		this.codTipoMovimiento = codTipoMovimiento;
	}
	public long getEmpresaDestino() {
		return empresaDestino;
	}
	public void setEmpresaDestino(long empresaDestino) {
		this.empresaDestino = empresaDestino;
	}
	public long getEmpresaOrigen() {
		return empresaOrigen;
	}
	public void setEmpresaOrigen(long empresaOrigen) {
		this.empresaOrigen = empresaOrigen;
	}
	public String getNumAnexo() {
		return numAnexo;
	}
	public void setNumAnexo(String numAnexo) {
		this.numAnexo = numAnexo;
	}
	public long getNumCelular() {
		return numCelular;
	}
	public void setNumCelular(long numCelular) {
		this.numCelular = numCelular;
	}
	public String getNumContrato() {
		return numContrato;
	}
	public void setNumContrato(String numContrato) {
		this.numContrato = numContrato;
	}
	public String getUsuarioDestino() {
		return usuarioDestino;
	}
	public void setUsuarioDestino(String usuarioDestino) {
		this.usuarioDestino = usuarioDestino;
	}
	public String getUsuarioOracle() {
		return usuarioOracle;
	}
	public void setUsuarioOracle(String usuarioOracle) {
		this.usuarioOracle = usuarioOracle;
	}
	public String getUsuarioOrigen() {
		return usuarioOrigen;
	}
	public void setUsuarioOrigen(String usuarioOrigen) {
		this.usuarioOrigen = usuarioOrigen;
	}
	
}
