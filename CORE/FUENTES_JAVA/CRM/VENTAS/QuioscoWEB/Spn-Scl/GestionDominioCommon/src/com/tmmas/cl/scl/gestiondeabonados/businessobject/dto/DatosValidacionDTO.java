package com.tmmas.cl.scl.gestiondeabonados.businessobject.dto;

import java.io.Serializable;

public class DatosValidacionDTO implements Serializable{
	private static final long serialVersionUID = 1L;
	
	private int largoSerieSimcard;
	private int largoSerieTerminal;
	private int existeSerieEnAbonado;
	private int existeSerieTermialEnAbonado;
	private int serieTerminalListaNegra;
	private int existeSerieSimcard;
	private int existeSerieTerminal;
	private int clienteAgenteComercial;
	private int existeContrato;
	private int vendedorExisteBodegaSimcard;
	private int vendedorExisteBodegaTerminal;
	private int vendedorNumeroValido;
	private String codigoBodega;
	private String estadoSerie;
	private String indicadorProgramado;
	private String numeroCelular;
	private String codigoUso;
	private String tipoStock;
	private String tipoIdententificador;
	private String numeroIdentificador;
	private String codigoBodegaTerminal;
	private String estadoSerieTerminal;
	private String codigoUsoTerminal;
	private int codigoCentralTerminal;
	private double importeCargoBasico;
	private String codigoCargoBasico;
	private String codigoLimiteConsumo;
	private String tipoPlanTarifario;
	private String indProcEqTerminal;
	private String indProcEqSimcard;
	private int codigoCentral;
	private String codigoArticuloTerminal;
	private String tipoArticuloTerminal;
	private String codigoArticuloSimcard;
	private String tipoArticuloSimcard;
	private String capcodeTerminal;
	private String capcodeSimcard;
	private String tipoStockSimcard;
	private String tipoStockTerminal;
	private String desArticuloSimcard;
	private String desArticuloTerminal;
	private String codigoSubAlmSimcard;
	
	
	
	
    public String getCapcodeSimcard() {
		return capcodeSimcard;
	}

	public void setCapcodeSimcard(String capcodeSimcard) {
		this.capcodeSimcard = capcodeSimcard;
	}

	public String getCapcodeTerminal() {
		return capcodeTerminal;
	}

	public void setCapcodeTerminal(String capcodeTerminal) {
		this.capcodeTerminal = capcodeTerminal;
	}

	public String getCodigoArticuloSimcard() {
		return codigoArticuloSimcard;
	}

	public void setCodigoArticuloSimcard(String codigoArticuloSimcard) {
		this.codigoArticuloSimcard = codigoArticuloSimcard;
	}

	public String getCodigoArticuloTerminal() {
		return codigoArticuloTerminal;
	}

	public void setCodigoArticuloTerminal(String codigoArticuloTerminal) {
		this.codigoArticuloTerminal = codigoArticuloTerminal;
	}

	public String getTipoArticuloSimcard() {
		return tipoArticuloSimcard;
	}

	public void setTipoArticuloSimcard(String tipoArticuloSimcard) {
		this.tipoArticuloSimcard = tipoArticuloSimcard;
	}

	public String getTipoArticuloTerminal() {
		return tipoArticuloTerminal;
	}

	public void setTipoArticuloTerminal(String tipoArticuloTerminal) {
		this.tipoArticuloTerminal = tipoArticuloTerminal;
	}

	public double getImporteCargoBasico() {
		return importeCargoBasico;
	}

	public void setImporteCargoBasico(double importeCargoBasico) {
		this.importeCargoBasico = importeCargoBasico;
	}

	public String getNumeroIdentificador() {
		return numeroIdentificador;
	}
	
	public void setNumeroIdentificador(String numeroIdentificador) {
		this.numeroIdentificador = numeroIdentificador;
	}
	
	public String getTipoIdententificador() {
		return tipoIdententificador;
	}
	
	public void setTipoIdententificador(String tipoIdententificador) {
		this.tipoIdententificador = tipoIdententificador;
	}

	public int getExisteSerieSimcard() {
		return existeSerieSimcard;
	}
	
	public void setExisteSerieSimcard(int existeSerieSimcard) {
		this.existeSerieSimcard = existeSerieSimcard;
	}
	
	public String getCodigoBodega() {
		return codigoBodega;
	}
	
	public void setCodigoBodega(String codigoBodega) {
		this.codigoBodega = codigoBodega;
	}
	
	public String getCodigoUso() {
		return codigoUso;
	}
	
	public void setCodigoUso(String codigoUso) {
		this.codigoUso = codigoUso;
	}
	
	public String getEstadoSerie() {
		return estadoSerie;
	}
	
	public void setEstadoSerie(String estadoSerie) {
		this.estadoSerie = estadoSerie;
	}
	
	public String getIndicadorProgramado() {
		return indicadorProgramado;
	}
	
	public void setIndicadorProgramado(String indicadorProgramado) {
		this.indicadorProgramado = indicadorProgramado;
	}
	
	public String getNumeroCelular() {
		return numeroCelular;
	}
	
	public void setNumeroCelular(String numeroCelular) {
		this.numeroCelular = numeroCelular;
	}
	
	public String getTipoStock() {
		return tipoStock;
	}
	
	public void setTipoStock(String tipoStock) {
		this.tipoStock = tipoStock;
	}
	
	public int getLargoSerieSimcard() {
		return largoSerieSimcard;
	}
	
	public void setLargoSerieSimcard(int largoSerieSimcard) {
		this.largoSerieSimcard = largoSerieSimcard;
	}
	
	public int getLargoSerieTerminal() {
		return largoSerieTerminal;
	}
	
	public void setLargoSerieTerminal(int largoSerieTerminal) {
		this.largoSerieTerminal = largoSerieTerminal;
	}
	
	public int getExisteSerieEnAbonado() {
		return existeSerieEnAbonado;
	}
	
	public void setExisteSerieEnAbonado(int existeSerieEnAbonado) {
		this.existeSerieEnAbonado = existeSerieEnAbonado;
	}
	
	public int getSerieTerminalListaNegra() {
		return serieTerminalListaNegra;
	}
	
	public void setSerieTerminalListaNegra(int serieTerminalListaNegra) {
		this.serieTerminalListaNegra = serieTerminalListaNegra;
	}

	public int getClienteAgenteComercial() {
		return clienteAgenteComercial;
	}

	public void setClienteAgenteComercial(int clienteAgenteComercial) {
		this.clienteAgenteComercial = clienteAgenteComercial;
	}

	public int getExisteSerieTermialEnAbonado() {
		return existeSerieTermialEnAbonado;
	}

	public void setExisteSerieTermialEnAbonado(int existeSerieTermialEnAbonado) {
		this.existeSerieTermialEnAbonado = existeSerieTermialEnAbonado;
	}

	public int getExisteSerieTerminal() {
		return existeSerieTerminal;
	}

	public void setExisteSerieTerminal(int existeSerieTerminal) {
		this.existeSerieTerminal = existeSerieTerminal;
	}

	public String getCodigoBodegaTerminal() {
		return codigoBodegaTerminal;
	}

	public void setCodigoBodegaTerminal(String codigoBodegaTerminal) {
		this.codigoBodegaTerminal = codigoBodegaTerminal;
	}

	public String getCodigoUsoTerminal() {
		return codigoUsoTerminal;
	}

	public void setCodigoUsoTerminal(String codigoUsoTerminal) {
		this.codigoUsoTerminal = codigoUsoTerminal;
	}

	public String getEstadoSerieTerminal() {
		return estadoSerieTerminal;
	}

	public void setEstadoSerieTerminal(String estadoSerieTerminal) {
		this.estadoSerieTerminal = estadoSerieTerminal;
	}

	public String getTipoStockTerminal() {
		return tipoStockTerminal;
	}

	public void setTipoStockTerminal(String tipoStockTerminal) {
		this.tipoStockTerminal = tipoStockTerminal;
	}

	public int getExisteContrato() {
		return existeContrato;
	}

	public void setExisteContrato(int existeContrato) {
		this.existeContrato = existeContrato;
	}


	public int getVendedorExisteBodegaTerminal() {
		return vendedorExisteBodegaTerminal;
	}

	public void setVendedorExisteBodegaTerminal(int vendedorExisteBodegaTerminal) {
		this.vendedorExisteBodegaTerminal = vendedorExisteBodegaTerminal;
	}


	public int getVendedorExisteBodegaSimcard() {
		return vendedorExisteBodegaSimcard;
	}

	public void setVendedorExisteBodegaSimcard(int vendedorExisteBodegaSimcard) {
		this.vendedorExisteBodegaSimcard = vendedorExisteBodegaSimcard;
	}

	public int getVendedorNumeroValido() {
		return vendedorNumeroValido;
	}

	public void setVendedorNumeroValido(int vendedorNumeroValido) {
		this.vendedorNumeroValido = vendedorNumeroValido;
	}

	public String getCodigoCargoBasico() {
		return codigoCargoBasico;
	}

	public void setCodigoCargoBasico(String codigoCargoBasico) {
		this.codigoCargoBasico = codigoCargoBasico;
	}

	public String getCodigoLimiteConsumo() {
		return codigoLimiteConsumo;
	}

	public void setCodigoLimiteConsumo(String codigoLimiteConsumo) {
		this.codigoLimiteConsumo = codigoLimiteConsumo;
	}

	public int getCodigoCentral() {
		return codigoCentral;
	}

	public void setCodigoCentral(int codigoCentral) {
		this.codigoCentral = codigoCentral;
	}

	public int getCodigoCentralTerminal() {
		return codigoCentralTerminal;
	}

	public void setCodigoCentralTerminal(int codigoCentralTerminal) {
		this.codigoCentralTerminal = codigoCentralTerminal;
	}

	public String getTipoPlanTarifario() {
		return tipoPlanTarifario;
	}

	public void setTipoPlanTarifario(String codigoPlanTarifario) {
		this.tipoPlanTarifario = codigoPlanTarifario;
	}

	public String getIndProcEqSimcard() {
		return indProcEqSimcard;
	}

	public void setIndProcEqSimcard(String indProcEqSimcard) {
		this.indProcEqSimcard = indProcEqSimcard;
	}

	public String getIndProcEqTerminal() {
		return indProcEqTerminal;
	}

	public void setIndProcEqTerminal(String indProcEqTerminal) {
		this.indProcEqTerminal = indProcEqTerminal;
	}

	public String getTipoStockSimcard() {
		return tipoStockSimcard;
	}

	public void setTipoStockSimcard(String tipoStockSimcard) {
		this.tipoStockSimcard = tipoStockSimcard;
	}

	public String getDesArticuloSimcard() {
		return desArticuloSimcard;
	}

	public void setDesArticuloSimcard(String desArticuloSimcard) {
		this.desArticuloSimcard = desArticuloSimcard;
	}

	public String getDesArticuloTerminal() {
		return desArticuloTerminal;
	}

	public void setDesArticuloTerminal(String desArticuloTerminal) {
		this.desArticuloTerminal = desArticuloTerminal;
	}

	public String getCodigoSubAlmSimcard() {
		return codigoSubAlmSimcard;
	}

	public void setCodigoSubAlmSimcard(String codigoSubAlmSimcard) {
		this.codigoSubAlmSimcard = codigoSubAlmSimcard;
	}

		
}//fin class DatosValidacionArchivo