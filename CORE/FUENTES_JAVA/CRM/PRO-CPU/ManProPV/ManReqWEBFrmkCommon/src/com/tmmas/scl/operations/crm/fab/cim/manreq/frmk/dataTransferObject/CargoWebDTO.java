package com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject;

import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.CargoDTO;

public class CargoWebDTO extends CargoDTO
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String cantidad;
	private String saldoTotal;
	private String totalDescuentosAutomaticos;

	public CargoWebDTO()
	{
		cantidad="1";
		saldoTotal="0";
		totalDescuentosAutomaticos="0";
	}
	
	public String getCantidad() {
		return cantidad;
	}

	public void setCantidad(String cantidad) {
		this.cantidad = cantidad;
	}
	
	public String getSaldoTotal() {
		return saldoTotal;
	}

	public void setSaldoTotal(String saldoTotal) {
		this.saldoTotal = saldoTotal;
	}

	public String getTotalDescuentosAutomaticos() {
		return totalDescuentosAutomaticos;
	}

	public void setTotalDescuentosAutomaticos(String totalDescuentosAutomaticos) {
		this.totalDescuentosAutomaticos = totalDescuentosAutomaticos;
	}

	public void setCargoDTO(CargoDTO cargo)
	{		
		 this.codCargoBasico=cargo.getCodCargoBasico();
		 this.idCargo=cargo.getIdCargo();
		 this.importe=cargo.getImporte();
		 this.moneda=cargo.getMoneda();
		 this.desMoneda=cargo.getDesMoneda();
		 this.tipoCargo=cargo.getTipoCargo();
		 this.descripcion=cargo.getDescripcion();
		 this.indFacturacion=cargo.getIndFacturacion();		
		 this.secuencia=cargo.getSecuencia();
		 this.numMovimiento=cargo.getNumMovimiento();
		 this.codActabo=cargo.getCodActabo();
		 this.codProducto=cargo.getCodProducto();
		 this.codTecnologia=cargo.getCodTecnologia();
		 this.tipPantalla=cargo.getTipPantalla();
		 this.codConcepto=cargo.getCodConcepto();
		 this.codModulo=cargo.getCodModulo();
		 this.codplantarifNuevo=cargo.getCodplantarifNuevo();
		 this.codplantarifAnt=cargo.getCodplantarifAnt();
		 this.tipAbonado=cargo.getTipAbonado();
		 this.codOoss=cargo.getCodOoss();
		 this.codCliente=cargo.getCodCliente();
		 this.numAbonado=cargo.getNumAbonado();
		 this.codPlanServ=cargo.getCodPlanServ();
		 this.codOperacion=cargo.getCodOperacion();
		 this.codTipContrato=cargo.getCodTipContrato();
		 this.tipoCelular=cargo.getTipoCelular();
		 this.numMeses=cargo.getNumMeses();
		 this.codAntiguedad=cargo.getCodAntiguedad();
		 this.codCiclo=cargo.getCodCiclo();
		 this.numCelular=cargo.getNumCelular();
		 this.tipoServicio=cargo.getTipoServicio();
		 this.codPlanCom=cargo.getCodPlanCom();
		 this.paramMens1=cargo.getParamMens1();
		 this.paramMens2=cargo.getParamMens2();
		 this.paramMens3=cargo.getParamMens3();
		 this.codArticulo=cargo.getCodArticulo();
		 this.codCausa=cargo.getCodCausa();
		 this.codCausaNueva=cargo.getCodCausaNueva();
		 this.codVendedor=cargo.getCodVendedor();
		 this.codCategoria=cargo.getCodCategoria();
		 this.codModVenta=cargo.getCodModVenta();
		 this.codCausaSiniestro=cargo.getCodCausaSiniestro();	
		 this.indProrrateable=cargo.getIndProrrateable();
		 this.setDescuentos(cargo.getDescuentos());
	}
}
