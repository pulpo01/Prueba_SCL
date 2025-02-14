package com.tmmas.scl.framework.CustomerDomain.CustomerBillABE.dto;

import java.io.Serializable;

public class RegistrarCargoDTO implements Serializable {
	private CargoDTO cargoDTO[];

	private long numProceso; // Secuencia

	private long codCliente; // codigo cliente

	private long codConcepto; // codigo cliente

	private long contadorColumna;// correlativo

	private long codProducto;// 1

	private String codMoneda;

	private String fecValor; // fecha sistema

	private String fecEfectividad; // fecha sistema

	private long impConcepto; // importe concepto

	private long impFacturable; // importe concepto

	private long impMontabase; // 0

	private String codRegion;

	private String codProvincia;

	private String codCiudad;

	private String codModulo;

	private long codPlanComercial;

	private long indFactura; // 1

	private long numUnidades;// la cantidad

	private long codCatImpositiva; //  

	private long indEstado;// 0

	private long codPortador;// 0

	private long codTipoConcepto;// // si es cargo (3) o descuento(2) validar

	private long codCicloFactura;// ""

	private long codConceRel;// ""

	private long columnaRel;// ""

	private long numAbonadosl;// ""

	private String numTerminal;// ""

	private long capCode;// ""

	private String numSerieEmec;// ""

	private String numSerieLe;// "0"

	private long flagimpues;// ""

	private long flagDTO;// si el cargo tiene descuento en el registro del

	// cargo se pone 1

	private long prcImpuesto;// ""

	private long valDscuento;// valor descuento

	private long tipDescuento;// P=1 M=0

	private long numVenta;// ""

	private long mesGarantia;// ""

	private long indAlta;// ""

	private long indSuperTel;// ""

	private long numPaquete;// ""

	private long numTransaccion;// ""

	private long indCuota;

	private long numGuia;

	private long numCuotas;

	private long ordCuota;

	private String desNotaCredito;

	private long indModVenta;

	private String recupIva;

	private long tipoDocum;

	private String codTecnologia;

	private String monedaImp;

	private long impConversion;

	private long impVolUnitario;

	private String glsDescrip;

	private String codMoneFac;

	private String cantidadDecimales;

	public String getCantidadDecimales() {
		return cantidadDecimales;
	}

	public void setCantidadDecimales(String cantidadDecimales) {
		this.cantidadDecimales = cantidadDecimales;
	}

	public String getCodTecnologia() {
		return codTecnologia;
	}

	public void setCodTecnologia(String codTecnologia) {
		this.codTecnologia = codTecnologia;
	}

	public String getDesNotaCredito() {
		return desNotaCredito;
	}

	public void setDesNotaCredito(String desNotaCredito) {
		this.desNotaCredito = desNotaCredito;
	}

	public String getGlsDescrip() {
		return glsDescrip;
	}

	public void setGlsDescrip(String glsDescrip) {
		this.glsDescrip = glsDescrip;
	}

	public long getImpConversion() {
		return impConversion;
	}

	public void setImpConversion(long impConversion) {
		this.impConversion = impConversion;
	}

	public long getImpVolUnitario() {
		return impVolUnitario;
	}

	public void setImpVolUnitario(long impVolUnitario) {
		this.impVolUnitario = impVolUnitario;
	}

	public long getIndCuota() {
		return indCuota;
	}

	public void setIndCuota(long indCuota) {
		this.indCuota = indCuota;
	}

	public long getIndModVenta() {
		return indModVenta;
	}

	public void setIndModVenta(long indModVenta) {
		this.indModVenta = indModVenta;
	}

	public String getMonedaImp() {
		return monedaImp;
	}

	public void setMonedaImp(String monedaImp) {
		this.monedaImp = monedaImp;
	}

	public long getNumCuotas() {
		return numCuotas;
	}

	public void setNumCuotas(long numCuotas) {
		this.numCuotas = numCuotas;
	}

	public long getNumGuia() {
		return numGuia;
	}

	public void setNumGuia(long numGuia) {
		this.numGuia = numGuia;
	}

	public long getOrdCuota() {
		return ordCuota;
	}

	public void setOrdCuota(long ordCuota) {
		this.ordCuota = ordCuota;
	}

	public String getRecupIva() {
		return recupIva;
	}

	public void setRecupIva(String recupIva) {
		this.recupIva = recupIva;
	}

	public long getTipoDocum() {
		return tipoDocum;
	}

	public void setTipoDocum(long tipoDocum) {
		this.tipoDocum = tipoDocum;
	}

	public long getCapCode() {
		return capCode;
	}

	public void setCapCode(long capCode) {
		this.capCode = capCode;
	}

	public long getCodCicloFactura() {
		return codCicloFactura;
	}

	public void setCodCicloFactura(long codCicloFactura) {
		this.codCicloFactura = codCicloFactura;
	}

	public String getCodCiudad() {
		return codCiudad;
	}

	public void setCodCiudad(String codCiudad) {
		this.codCiudad = codCiudad;
	}

	public long getCodCliente() {
		return codCliente;
	}

	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}

	public long getCodConceRel() {
		return codConceRel;
	}

	public void setCodConceRel(long codConceRel) {
		this.codConceRel = codConceRel;
	}

	public String getCodModulo() {
		return codModulo;
	}

	public void setCodModulo(String codModulo) {
		this.codModulo = codModulo;
	}

	public String getCodMoneda() {
		return codMoneda;
	}

	public void setCodMoneda(String codMoneda) {
		this.codMoneda = codMoneda;
	}

	public long getCodPlanComercial() {
		return codPlanComercial;
	}

	public void setCodPlanComercial(long codPlanComercial) {
		this.codPlanComercial = codPlanComercial;
	}

	public long getCodPortador() {
		return codPortador;
	}

	public void setCodPortador(long codPortador) {
		this.codPortador = codPortador;
	}

	public long getCodProducto() {
		return codProducto;
	}

	public void setCodProducto(long codProducto) {
		this.codProducto = codProducto;
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

	public long getCodTipoConcepto() {
		return codTipoConcepto;
	}

	public void setCodTipoConcepto(long codTipoConcepto) {
		this.codTipoConcepto = codTipoConcepto;
	}

	public long getColumnaRel() {
		return columnaRel;
	}

	public void setColumnaRel(long columnaRel) {
		this.columnaRel = columnaRel;
	}

	public long getContadorColumna() {
		return contadorColumna;
	}

	public void setContadorColumna(long contadorColumna) {
		this.contadorColumna = contadorColumna;
	}

	public String getFecEfectividad() {
		return fecEfectividad;
	}

	public void setFecEfectividad(String fecEfectividad) {
		this.fecEfectividad = fecEfectividad;
	}

	public String getFecValor() {
		return fecValor;
	}

	public void setFecValor(String fecValor) {
		this.fecValor = fecValor;
	}

	public long getFlagDTO() {
		return flagDTO;
	}

	public void setFlagDTO(long flagDTO) {
		this.flagDTO = flagDTO;
	}

	public long getFlagimpues() {
		return flagimpues;
	}

	public void setFlagimpues(long flagimpues) {
		this.flagimpues = flagimpues;
	}

	public long getImpConcepto() {
		return impConcepto;
	}

	public void setImpConcepto(long impConcepto) {
		this.impConcepto = impConcepto;
	}

	public long getImpFacturable() {
		return impFacturable;
	}

	public void setImpFacturable(long impFacturable) {
		this.impFacturable = impFacturable;
	}

	public long getImpMontabase() {
		return impMontabase;
	}

	public void setImpMontabase(long impMontabase) {
		this.impMontabase = impMontabase;
	}

	public long getIndAlta() {
		return indAlta;
	}

	public void setIndAlta(long indAlta) {
		this.indAlta = indAlta;
	}

	public long getIndEstado() {
		return indEstado;
	}

	public void setIndEstado(long indEstado) {
		this.indEstado = indEstado;
	}

	public long getIndFactura() {
		return indFactura;
	}

	public void setIndFactura(long indFactura) {
		this.indFactura = indFactura;
	}

	public long getIndSuperTel() {
		return indSuperTel;
	}

	public void setIndSuperTel(long indSuperTel) {
		this.indSuperTel = indSuperTel;
	}

	public long getMesGarantia() {
		return mesGarantia;
	}

	public void setMesGarantia(long mesGarantia) {
		this.mesGarantia = mesGarantia;
	}

	public long getNumAbonadosl() {
		return numAbonadosl;
	}

	public void setNumAbonadosl(long numAbonadosl) {
		this.numAbonadosl = numAbonadosl;
	}

	public long getNumPaquete() {
		return numPaquete;
	}

	public void setNumPaquete(long numPaquete) {
		this.numPaquete = numPaquete;
	}

	public long getNumProceso() {
		return numProceso;
	}

	public void setNumProceso(long numProceso) {
		this.numProceso = numProceso;
	}

	public String getNumTerminal() {
		return numTerminal;
	}

	public void setNumTerminal(String numTerminal) {
		this.numTerminal = numTerminal;
	}

	public String getNumSerieEmec() {
		return numSerieEmec;
	}

	public void setNumSerieEmec(String numSerieEmec) {
		this.numSerieEmec = numSerieEmec;
	}

	public String getNumSerieLe() {
		return numSerieLe;
	}

	public void setNumSerieLe(String numSerieLe) {
		this.numSerieLe = numSerieLe;
	}

	public long getNumTransaccion() {
		return numTransaccion;
	}

	public void setNumTransaccion(long numTransaccion) {
		this.numTransaccion = numTransaccion;
	}

	public long getNumUnidades() {
		return numUnidades;
	}

	public void setNumUnidades(long numUnidades) {
		this.numUnidades = numUnidades;
	}

	public long getNumVenta() {
		return numVenta;
	}

	public void setNumVenta(long numVenta) {
		this.numVenta = numVenta;
	}

	public long getPrcImpuesto() {
		return prcImpuesto;
	}

	public void setPrcImpuesto(long prcImpuesto) {
		this.prcImpuesto = prcImpuesto;
	}

	public long getTipDescuento() {
		return tipDescuento;
	}

	public void setTipDescuento(long tipDescuento) {
		this.tipDescuento = tipDescuento;
	}

	public long getValDscuento() {
		return valDscuento;
	}

	public void setValDscuento(long valDscuento) {
		this.valDscuento = valDscuento;
	}

	public long getCodCatImpositiva() {
		return codCatImpositiva;
	}

	public void setCodCatImpositiva(long codCatImpositiva) {
		this.codCatImpositiva = codCatImpositiva;
	}

	public long getCodConcepto() {
		return codConcepto;
	}

	public void setCodConcepto(long codConcepto) {
		this.codConcepto = codConcepto;
	}

	public CargoDTO[] getCargoDTO() {
		return cargoDTO;
	}

	public void setCargoDTO(CargoDTO[] cargoDTO) {
		this.cargoDTO = cargoDTO;
	}

	public String getCodMoneFac() {
		return codMoneFac;
	}

	public void setCodMoneFac(String codMoneFac) {
		this.codMoneFac = codMoneFac;
	}

}
