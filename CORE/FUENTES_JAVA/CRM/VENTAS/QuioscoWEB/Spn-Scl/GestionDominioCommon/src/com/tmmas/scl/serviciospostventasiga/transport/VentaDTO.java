package com.tmmas.scl.serviciospostventasiga.transport;

import java.io.Serializable;

public class VentaDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	
	private Long numVenta;
	private String codOficina;
	private Long codVendedor;
	private Long codVendedorAgente;
	private String codRegion;
	private String codProvincia;
	private String codCiudad;
	private Long impVenta;
	private String indEstVenta;
	private String tipContrato;
	private Long codCliente;
	private String modVenta;
	private String codMoneda;
	private String numContrato;
	private String indOfiter;
	private String nomUsuarVta;
	private String tipFoliacion;
	private String codTipDoc;
	private String codPlaza;
	private String codOperadora;
	private String codError;
	private String desError;
	private String chkDicom;
	private String codVenDealer;
	
	public String getCodVenDealer() {
		return codVenDealer;
	}
	public void setCodVenDealer(String codVenDealer) {
		this.codVenDealer = codVenDealer;
	}
	public String getChkDicom() {
		return chkDicom;
	}
	public void setChkDicom(String chkDicom) {
		this.chkDicom = chkDicom;
	}
	public String getCodError() {
		return codError;
	}
	public void setCodError(String codError) {
		this.codError = codError;
	}
	public String getDesError() {
		return desError;
	}
	public void setDesError(String desError) {
		this.desError = desError;
	}
	public String getCodCiudad() {
		return codCiudad;
	}
	public void setCodCiudad(String codCiudad) {
		this.codCiudad = codCiudad;
	}
	public Long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(Long codCliente) {
		this.codCliente = codCliente;
	}
	public String getCodMoneda() {
		return codMoneda;
	}
	public void setCodMoneda(String codMoneda) {
		this.codMoneda = codMoneda;
	}
	public String getCodOficina() {
		return codOficina;
	}
	public void setCodOficina(String codOficina) {
		this.codOficina = codOficina;
	}
	public String getCodOperadora() {
		return codOperadora;
	}
	public void setCodOperadora(String codOperadora) {
		this.codOperadora = codOperadora;
	}
	public String getCodPlaza() {
		return codPlaza;
	}
	public void setCodPlaza(String codPlaza) {
		this.codPlaza = codPlaza;
	}
	public String getCodProvincia() {
		return codProvincia;
	}
	public void setCodProvincia(String codProvincia) {
		this.codProvincia = codProvincia;
	}
	public String getCodRegion() {
		return codRegion;
	}
	public void setCodRegion(String codRegion) {
		this.codRegion = codRegion;
	}
	public String getCodTipDoc() {
		return codTipDoc;
	}
	public void setCodTipDoc(String codTipDoc) {
		this.codTipDoc = codTipDoc;
	}
	public Long getCodVendedor() {
		return codVendedor;
	}
	public void setCodVendedor(Long codVendedor) {
		this.codVendedor = codVendedor;
	}
	public Long getCodVendedorAgente() {
		return codVendedorAgente;
	}
	public void setCodVendedorAgente(Long codVendedorAgente) {
		this.codVendedorAgente = codVendedorAgente;
	}
	public Long getImpVenta() {
		return impVenta;
	}
	public void setImpVenta(Long impVenta) {
		this.impVenta = impVenta;
	}
	public String getIndEstVenta() {
		return indEstVenta;
	}
	public void setIndEstVenta(String indEstVenta) {
		this.indEstVenta = indEstVenta;
	}
	public String getIndOfiter() {
		return indOfiter;
	}
	public void setIndOfiter(String indOfiter) {
		this.indOfiter = indOfiter;
	}
	public String getModVenta() {
		return modVenta;
	}
	public void setModVenta(String modVenta) {
		this.modVenta = modVenta;
	}
	public String getNomUsuarVta() {
		return nomUsuarVta;
	}
	public void setNomUsuarVta(String nomUsuarVta) {
		this.nomUsuarVta = nomUsuarVta;
	}
	public String getNumContrato() {
		return numContrato;
	}
	public void setNumContrato(String numContrato) {
		this.numContrato = numContrato;
	}
	public Long getNumVenta() {
		return numVenta;
	}
	public void setNumVenta(Long numVenta) {
		this.numVenta = numVenta;
	}
	public String getTipContrato() {
		return tipContrato;
	}
	public void setTipContrato(String tipContrato) {
		this.tipContrato = tipContrato;
	}
	public String getTipFoliacion() {
		return tipFoliacion;
	}
	public void setTipFoliacion(String tipFoliacion) {
		this.tipFoliacion = tipFoliacion;
	}
	
}
