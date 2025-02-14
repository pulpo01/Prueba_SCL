package com.tmmas.scl.doblecuenta.form;

import org.apache.struts.action.ActionForm;

public class FacturacionDifForm extends ActionForm{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String estadoLista;
	private String activarChec;
	private String itemChequeadosCli[];
	private String itemChequeados [];
	private String buscar;
	private String enviaNumeroAbonado;
	private String checkbox;
	private String numeroAbonado;
	private String codigo;
	private String ingresoCod;
	private String guardarDatGrilla;
	private String asociarDat;
	private String numeroCelular;
	private String nombreUsuario;
	private String buscaAbon;
	private String buscaClien;
	private String codigoCliente;
	private String codigoClienteContratante;
	private String descClienteContratante;
	private String numeroIdentificacion;
	private String nombreCliente;
	private String apellidoPaterno;
	private String apellidoMaterno;
	private String codigoOperacion;
	private String descripOperacion;
	private String codigoModalidad;
	private String descModalidad;
	private String codigoTipoValor;
	private String descTipoValor;
	private String codigoConcepto;
	private String descConcepto;
	private String nombreAbonado;
	private String codClienAsociado;
	private String descClienAsociado;
	private String codigoAbonado;
	private String descAbonado;
	private String vieneCelular;
	private String codigoCiclo;
	
	private String operacion;
	private String modalidad;
	private String tipoValor;
	private String concepto;
	private String valor;
	private String abonado;
	private String clienteAsociado;
	private String id_abon;
	private String id_clien;
	private String id_concep;
    private String []listaCheckGrilla;    
    private String numSecuencialCliente;
    private String checkMasivo;
    private String mensajeBusqueda;
	
	
	public String getMensajeBusqueda() {
		return mensajeBusqueda;
	}
	public void setMensajeBusqueda(String mensajeBusqueda) {
		this.mensajeBusqueda = mensajeBusqueda;
	}
	public String getCheckMasivo() {
		return checkMasivo;
	}
	public void setCheckMasivo(String checkMasivo) {
		this.checkMasivo = checkMasivo;
	}
	public String getNumSecuencialCliente() {
		return numSecuencialCliente;
	}
	public void setNumSecuencialCliente(String numSecuencialCliente) {
		this.numSecuencialCliente = numSecuencialCliente;
	}
	public String getNombreUsuario() {
		return nombreUsuario;
	}
	public void setNombreUsuario(String nombreUsuario) {
		this.nombreUsuario = nombreUsuario;
	}
	public String getNumeroCelular() {
		return numeroCelular;
	}
	public void setNumeroCelular(String numeroCelular) {
		this.numeroCelular = numeroCelular;
	}
	public String getBuscaAbon() {
		return buscaAbon;
	}
	public void setBuscaAbon(String buscaAbon) {
		this.buscaAbon = buscaAbon;
	}
	
	public String getCodigoCliente() {
		return codigoCliente;
	}
	public void setCodigoCliente(String codigoCliente) {
		this.codigoCliente = codigoCliente;
	}
	public String getNombreCliente() {
		return nombreCliente;
	}
	public void setNombreCliente(String nombreCliente) {
		this.nombreCliente = nombreCliente;
	}

	public String getBuscaClien() {
		return buscaClien;
	}
	public void setBuscaClien(String buscaClien) {
		this.buscaClien = buscaClien;
	}

	public String getApellidoMaterno() {
		return apellidoMaterno;
	}
	public void setApellidoMaterno(String apellidoMaterno) {
		this.apellidoMaterno = apellidoMaterno;
	}
	public String getApellidoPaterno() {
		return apellidoPaterno;
	}
	public void setApellidoPaterno(String apellidoPaterno) {
		this.apellidoPaterno = apellidoPaterno;
	}
	public String getNumeroIdentificacion() {
		return numeroIdentificacion;
	}
	public void setNumeroIdentificacion(String numeroIdentificacion) {
		this.numeroIdentificacion = numeroIdentificacion;
	}
	public String getDescConcepto() {
		return descConcepto;
	}
	public void setDescConcepto(String descConcepto) {
		this.descConcepto = descConcepto;
	}
	public String getDescModalidad() {
		return descModalidad;
	}
	public void setDescModalidad(String descModalidad) {
		this.descModalidad = descModalidad;
	}
	public String getDescripOperacion() {
		return descripOperacion;
	}
	public void setDescripOperacion(String descripOperacion) {
		this.descripOperacion = descripOperacion;
	}
	public String getDescTipoValor() {
		return descTipoValor;
	}
	public void setDescTipoValor(String descTipoValor) {
		this.descTipoValor = descTipoValor;
	}
	public String getCodigoConcepto() {
		return codigoConcepto;
	}
	public void setCodigoConcepto(String codigoConcepto) {
		this.codigoConcepto = codigoConcepto;
	}
	public String getCodigoModalidad() {
		return codigoModalidad;
	}
	public void setCodigoModalidad(String codigoModalidad) {
		this.codigoModalidad = codigoModalidad;
	}
	public String getCodigoOperacion() {
		return codigoOperacion;
	}
	public void setCodigoOperacion(String codigoOperacion) {
		this.codigoOperacion = codigoOperacion;
	}
	public String getCodigoTipoValor() {
		return codigoTipoValor;
	}
	public void setCodigoTipoValor(String codigoTipoValor) {
		this.codigoTipoValor = codigoTipoValor;
	}
	public String getCodClienAsociado() {
		return codClienAsociado;
	}
	public void setCodClienAsociado(String codClienAsociado) {
		this.codClienAsociado = codClienAsociado;
	}
	public String getCodigoAbonado() {
		return codigoAbonado;
	}
	public void setCodigoAbonado(String codigoAbonado) {
		this.codigoAbonado = codigoAbonado;
	}
	public String getDescAbonado() {
		return descAbonado;
	}
	public void setDescAbonado(String descAbonado) {
		this.descAbonado = descAbonado;
	}
	public String getDescClienAsociado() {
		return descClienAsociado;
	}
	public void setDescClienAsociado(String descClienAsociado) {
		this.descClienAsociado = descClienAsociado;
	}
	public String getNombreAbonado() {
		return nombreAbonado;
	}
	public void setNombreAbonado(String nombreAbonado) {
		this.nombreAbonado = nombreAbonado;
	}
	public String getVieneCelular() {
		return vieneCelular;
	}
	public void setVieneCelular(String vieneCelular) {
		this.vieneCelular = vieneCelular;
	}
	public String getCodigoCiclo() {
		return codigoCiclo;
	}
	public void setCodigoCiclo(String codigoCiclo) {
		this.codigoCiclo = codigoCiclo;
	}
	public String getAsociarDat() {
		return asociarDat;
	}
	public void setAsociarDat(String asociarDat) {
		this.asociarDat = asociarDat;
	}
	public String getAbonado() {
		return abonado;
	}
	public void setAbonado(String abonado) {
		this.abonado = abonado;
	}
	public String getClienteAsociado() {
		return clienteAsociado;
	}
	public void setClienteAsociado(String clienteAsociado) {
		this.clienteAsociado = clienteAsociado;
	}
	public String getConcepto() {
		return concepto;
	}
	public void setConcepto(String concepto) {
		this.concepto = concepto;
	}
	public String getModalidad() {
		return modalidad;
	}
	public void setModalidad(String modalidad) {
		this.modalidad = modalidad;
	}
	public String getOperacion() {
		return operacion;
	}
	public void setOperacion(String operacion) {
		this.operacion = operacion;
	}
	public String getTipoValor() {
		return tipoValor;
	}
	public void setTipoValor(String tipoValor) {
		this.tipoValor = tipoValor;
	}
	public String getValor() {
		return valor;
	}
	public void setValor(String valor) {
		this.valor = valor;
	}
	public String getGuardarDatGrilla() {
		return guardarDatGrilla;
	}
	public void setGuardarDatGrilla(String guardarDatGrilla) {
		this.guardarDatGrilla = guardarDatGrilla;
	}
	public String getIngresoCod() {
		return ingresoCod;
	}
	public void setIngresoCod(String ingresoCod) {
		this.ingresoCod = ingresoCod;
	}
	public String getCodigo() {
		return codigo;
	}
	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}
	public String getCodigoClienteContratante() {
		return codigoClienteContratante;
	}
	public void setCodigoClienteContratante(String codigoClienteContratante) {
		this.codigoClienteContratante = codigoClienteContratante;
	}
	public String getDescClienteContratante() {
		return descClienteContratante;
	}
	public void setDescClienteContratante(String descClienteContratante) {
		this.descClienteContratante = descClienteContratante;
	}
	public String getId_abon() {
		return id_abon;
	}
	public void setId_abon(String id_abon) {
		this.id_abon = id_abon;
	}
	public String getId_clien() {
		return id_clien;
	}
	public void setId_clien(String id_clien) {
		this.id_clien = id_clien;
	}
	public String getId_concep() {
		return id_concep;
	}
	public void setId_concep(String id_concep) {
		this.id_concep = id_concep;
	}
	public String getNumeroAbonado() {
		return numeroAbonado;
	}
	public void setNumeroAbonado(String numeroAbonado) {
		this.numeroAbonado = numeroAbonado;
	}
	public String getCheckbox() {
		return checkbox;
	}
	public void setCheckbox(String checkbox) {
		this.checkbox = checkbox;
	}
	public String getEnviaNumeroAbonado() {
		return enviaNumeroAbonado;
	}
	public void setEnviaNumeroAbonado(String enviaNumeroAbonado) {
		this.enviaNumeroAbonado = enviaNumeroAbonado;
	}
	public String getBuscar() {
		return buscar;
	}
	public void setBuscar(String buscar) {
		this.buscar = buscar;
	}
	public String[] getItemChequeados() {
		return itemChequeados;
	}
	public void setItemChequeados(String[] itemChequeados) {
		this.itemChequeados = itemChequeados;
	}
	public String[] getListaCheckGrilla() {
		return listaCheckGrilla;
	}
	public void setListaCheckGrilla(String[] listaCheckGrilla) {
		this.listaCheckGrilla = listaCheckGrilla;
	}
	public String getActivarChec() {
		return activarChec;
	}
	public void setActivarChec(String activarChec) {
		this.activarChec = activarChec;
	}
	public String getEstadoLista() {
		return estadoLista;
	}
	public void setEstadoLista(String estadoLista) {
		this.estadoLista = estadoLista;
	}
	public String[] getItemChequeadosCli() {
		return itemChequeadosCli;
	}
	public void setItemChequeadosCli(String[] itemChequeadosCli) {
		this.itemChequeadosCli = itemChequeadosCli;
	}
	
	
	

}
