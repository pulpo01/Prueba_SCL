package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;

public class CargoDTO implements Serializable {
	private static final long serialVersionUID = 1L;

	protected String codCargoBasico;
	protected String idCargo;
	protected String importe;
	protected String moneda;
	protected String desMoneda;
	protected String tipoCargo;
	protected String descripcion;
	protected String indFacturacion;
	
	/*							*/
	protected String secuencia;
	protected String numMovimiento;
	protected String codActabo;
	protected String codProducto;
	protected String codTecnologia;
	protected String tipPantalla;
	protected String codConcepto;
	protected String codModulo;
	protected String codplantarifNuevo;
	protected String codplantarifAnt;
	protected String tipAbonado;
	protected String codOoss;
	protected String codCliente;
	protected String numAbonado;
	protected String codPlanServ;
	protected String codOperacion;
	protected String codTipContrato;
	protected String tipoCelular;
	protected String numMeses;
	protected String codAntiguedad;
	protected String codCiclo;
	protected String numCelular;
	protected String tipoServicio;
	protected String codPlanCom;
	protected String paramMens1;
	protected String paramMens2;
	protected String paramMens3;
	protected String codArticulo;
	protected String codCausa;
	protected String codCausaNueva;
	protected String codVendedor;
	protected String codCategoria;
	protected String codModVenta;
	protected String codCausaSiniestro;
	
	protected String indProrrateable;
	
	protected DescuentoProductoListDTO descuentos;	

	
	public String getDesMoneda() {
		return desMoneda;
	}
	public void setDesMoneda(String desMoneda) {
		this.desMoneda = desMoneda;
	}
	public DescuentoProductoListDTO getDescuentos() {
		return descuentos;
	}
	public void setDescuentos(DescuentoProductoListDTO descuentos) {
		this.descuentos = descuentos;
	}
	public String getIndProrrateable() {
		return indProrrateable;
	}
	public void setIndProrrateable(String indProrrateable) {
		this.indProrrateable = indProrrateable;
	}

	public String getCodCargoBasico() {
		return codCargoBasico;
	}

	public void setCodCargoBasico(String codCargoBasico) {
		this.codCargoBasico = codCargoBasico;
	}

	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

	public String getIdCargo() {
		return idCargo;
	}

	public void setIdCargo(String idCargo) {
		this.idCargo = idCargo;
	}

	public String getImporte() {
		return importe;
	}

	public void setImporte(String importe) {
		this.importe = importe;
	}

	public String getIndFacturacion() {
		return indFacturacion;
	}

	public void setIndFacturacion(String indFacturacion) {
		this.indFacturacion = indFacturacion;
	}

	public String getMoneda() {
		return moneda;
	}

	public void setMoneda(String moneda) {
		this.moneda = moneda;
	}

	public String getTipoCargo() {
		return tipoCargo;
	}

	public void setTipoCargo(String tipoCargo) {
		this.tipoCargo = tipoCargo;
	}

	public String getCodActabo() {
		return codActabo;
	}

	public void setCodActabo(String codActabo) {
		this.codActabo = codActabo;
	}

	public String getCodAntiguedad() {
		return codAntiguedad;
	}

	public void setCodAntiguedad(String codAntiguedad) {
		this.codAntiguedad = codAntiguedad;
	}

	public String getCodArticulo() {
		return codArticulo;
	}

	public void setCodArticulo(String codArticulo) {
		this.codArticulo = codArticulo;
	}

	public String getCodCategoria() {
		return codCategoria;
	}

	public void setCodCategoria(String codCategoria) {
		this.codCategoria = codCategoria;
	}

	public String getCodCausa() {
		return codCausa;
	}

	public void setCodCausa(String codCausa) {
		this.codCausa = codCausa;
	}

	public String getCodCausaNueva() {
		return codCausaNueva;
	}

	public void setCodCausaNueva(String codCausaNueva) {
		this.codCausaNueva = codCausaNueva;
	}

	public String getCodCausaSiniestro() {
		return codCausaSiniestro;
	}

	public void setCodCausaSiniestro(String codCausaSiniestro) {
		this.codCausaSiniestro = codCausaSiniestro;
	}

	public String getCodCiclo() {
		return codCiclo;
	}

	public void setCodCiclo(String codCiclo) {
		this.codCiclo = codCiclo;
	}

	public String getCodCliente() {
		return codCliente;
	}

	public void setCodCliente(String codCliente) {
		this.codCliente = codCliente;
	}

	public String getCodConcepto() {
		return codConcepto;
	}

	public void setCodConcepto(String codConcepto) {
		this.codConcepto = codConcepto;
	}

	public String getCodModulo() {
		return codModulo;
	}

	public void setCodModulo(String codModulo) {
		this.codModulo = codModulo;
	}

	public String getCodModVenta() {
		return codModVenta;
	}

	public void setCodModVenta(String codModVenta) {
		this.codModVenta = codModVenta;
	}

	public String getCodOoss() {
		return codOoss;
	}

	public void setCodOoss(String codOoss) {
		this.codOoss = codOoss;
	}

	public String getCodOperacion() {
		return codOperacion;
	}

	public void setCodOperacion(String codOperacion) {
		this.codOperacion = codOperacion;
	}

	public String getCodPlanCom() {
		return codPlanCom;
	}

	public void setCodPlanCom(String codPlanCom) {
		this.codPlanCom = codPlanCom;
	}

	public String getCodPlanServ() {
		return codPlanServ;
	}

	public void setCodPlanServ(String codPlanServ) {
		this.codPlanServ = codPlanServ;
	}

	public String getCodplantarifAnt() {
		return codplantarifAnt;
	}

	public void setCodplantarifAnt(String codplantarifAnt) {
		this.codplantarifAnt = codplantarifAnt;
	}

	public String getCodplantarifNuevo() {
		return codplantarifNuevo;
	}

	public void setCodplantarifNuevo(String codplantarifNuevo) {
		this.codplantarifNuevo = codplantarifNuevo;
	}

	public String getCodProducto() {
		return codProducto;
	}

	public void setCodProducto(String codProducto) {
		this.codProducto = codProducto;
	}

	public String getCodTecnologia() {
		return codTecnologia;
	}

	public void setCodTecnologia(String codTecnologia) {
		this.codTecnologia = codTecnologia;
	}

	public String getCodTipContrato() {
		return codTipContrato;
	}

	public void setCodTipContrato(String codTipContrato) {
		this.codTipContrato = codTipContrato;
	}

	public String getCodVendedor() {
		return codVendedor;
	}

	public void setCodVendedor(String codVendedor) {
		this.codVendedor = codVendedor;
	}


	public String getNumAbonado() {
		return numAbonado;
	}

	public void setNumAbonado(String numAbonado) {
		this.numAbonado = numAbonado;
	}

	public String getNumCelular() {
		return numCelular;
	}

	public void setNumCelular(String numCelular) {
		this.numCelular = numCelular;
	}

	public String getNumMeses() {
		return numMeses;
	}

	public void setNumMeses(String numMeses) {
		this.numMeses = numMeses;
	}

	public String getNumMovimiento() {
		return numMovimiento;
	}

	public void setNumMovimiento(String numMovimiento) {
		this.numMovimiento = numMovimiento;
	}

	public String getParamMens1() {
		return paramMens1;
	}

	public void setParamMens1(String paramMens1) {
		this.paramMens1 = paramMens1;
	}

	public String getParamMens2() {
		return paramMens2;
	}

	public void setParamMens2(String paramMens2) {
		this.paramMens2 = paramMens2;
	}

	public String getParamMens3() {
		return paramMens3;
	}

	public void setParamMens3(String paramMens3) {
		this.paramMens3 = paramMens3;
	}

	public String getSecuencia() {
		return secuencia;
	}

	public void setSecuencia(String secuencia) {
		this.secuencia = secuencia;
	}

	public String getTipAbonado() {
		return tipAbonado;
	}

	public void setTipAbonado(String tipAbonado) {
		this.tipAbonado = tipAbonado;
	}

	public String getTipoCelular() {
		return tipoCelular;
	}

	public void setTipoCelular(String tipoCelular) {
		this.tipoCelular = tipoCelular;
	}

	public String getTipoServicio() {
		return tipoServicio;
	}

	public void setTipoServicio(String tipoServicio) {
		this.tipoServicio = tipoServicio;
	}

	public String getTipPantalla() {
		return tipPantalla;
	}

	public void setTipPantalla(String tipPantalla) {
		this.tipPantalla = tipPantalla;
	}
	
	
}
