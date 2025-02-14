package com.tmmas.scl.operations.crm.fab.cusintman.web.form;

import org.apache.struts.action.ActionForm;

public class CambioDeSerieForm extends ActionForm {
	private static final long serialVersionUID = 1L;
	
	private String procedNuevoEquipo;
	private String abonoDiferido;
	private String causaCambio;
	private String periodo;
	private String tipoContrato;
	private String modalidadPago;
	private String cuotas;
	private String hlr;
	private String tecnologia;
	private String tipoTerminal;
	private String central;
	private String mesesProrroga;
	private String cargaTributaria;
	private String nroContratoParte1;
	private String nroContratoParte2;
	private String nroContratoParte3;
	private String nroSerieEquip;
	private String nroSerieSim;
	private String usoVentaEquip;
	private String usoVentaSim;
	private String condicionError;
	private String mensajeError;
	private String mensajeStackTrace;
	private String condicH;
	private String condicionesCK;
	private String btnSeleccionado;
	private long   cod_bodega;
	private long   cod_articulo;
	private long   tip_stock;
	private long numTransaccionBloqDes;
	private String desFabricante;
	private String articulos;
	private String modelo;
	private String codArticuloTerminal;
	private String nroSerieEquipEx;
	private String nroSerieEquipExMec;
	private String flagBloqueo;
	private String flagBloqueoEquipo;
	private String flagBloqueoEquipoEx;
	private String numTransBloqDesSerie;
	private String numTransBloqDesEquipo;
	private String descripcionEquipo;
	
	private String nroSerie;
					
	public String getDescripcionEquipo() {
		return descripcionEquipo;
	}
	public void setDescripcionEquipo(String descripcionEquipo) {
		this.descripcionEquipo = descripcionEquipo;
	}
	public String getNumTransBloqDesEquipo() {
		return numTransBloqDesEquipo;
	}
	public void setNumTransBloqDesEquipo(String numTransBloqDesEquipo) {
		this.numTransBloqDesEquipo = numTransBloqDesEquipo;
	}
	public String getNumTransBloqDesSerie() {
		return numTransBloqDesSerie;
	}
	public void setNumTransBloqDesSerie(String numTransBloqDesSerie) {
		this.numTransBloqDesSerie = numTransBloqDesSerie;
	}
	public String getFlagBloqueoEquipo() {
		return flagBloqueoEquipo;
	}
	public void setFlagBloqueoEquipo(String flagBloqueoEquipo) {
		this.flagBloqueoEquipo = flagBloqueoEquipo;
	}
	public String getFlagBloqueo() {
		return flagBloqueo;
	}
	public void setFlagBloqueo(String flagBloqueo) {
		this.flagBloqueo = flagBloqueo;
	}
	public String getNroSerieEquipExMec() {
		return nroSerieEquipExMec;
	}
	public void setNroSerieEquipExMec(String nroSerieEquipExMec) {
		this.nroSerieEquipExMec = nroSerieEquipExMec;
	}
	public String getNroSerieEquipEx() {
		return nroSerieEquipEx;
	}
	public void setNroSerieEquipEx(String nroSerieEquipEx) {
		this.nroSerieEquipEx = nroSerieEquipEx;
	}
	public String getCodArticuloTerminal() {
		return codArticuloTerminal;
	}
	public void setCodArticuloTerminal(String codArticuloTerminal) {
		this.codArticuloTerminal = codArticuloTerminal;
	}
	public String getModelo() {
		return modelo;
	}
	public void setModelo(String modelo) {
		this.modelo = modelo;
	}
	public long getNumTransaccionBloqDes() {
		return numTransaccionBloqDes;
	}
	public void setNumTransaccionBloqDes(long numTransaccionBloqDes) {
		this.numTransaccionBloqDes = numTransaccionBloqDes;
	}
	public String getHlr() {
		return hlr;
	}
	public void setHlr(String hlr) {
		this.hlr = hlr;
	}
	public long getCod_articulo() {
		return cod_articulo;
	}
	public void setCod_articulo(long cod_articulo) {
		this.cod_articulo = cod_articulo;
	}
	public long getCod_bodega() {
		return cod_bodega;
	}
	public void setCod_bodega(long cod_bodega) {
		this.cod_bodega = cod_bodega;
	}
	public long getTip_stock() {
		return tip_stock;
	}
	public void setTip_stock(long tip_stock) {
		this.tip_stock = tip_stock;
	}
	public String getBtnSeleccionado() {
		return btnSeleccionado;
	}
	public void setBtnSeleccionado(String btnSeleccionado) {
		this.btnSeleccionado = btnSeleccionado;
	}
	public String getCondicionError() {
		return condicionError;
	}
	public void setCondicionError(String condicionError) {
		this.condicionError = condicionError;
	}
	public String getMensajeError() {
		return mensajeError;
	}
	public void setMensajeError(String mensajeError) {
		this.mensajeError = mensajeError;
	}
	public String getMensajeStackTrace() {
		return mensajeStackTrace;
	}
	public void setMensajeStackTrace(String mensajeStackTrace) {
		this.mensajeStackTrace = mensajeStackTrace;
	}
	
	public String getNroSerieEquip() {
		return nroSerieEquip;
	}
	public void setNroSerieEquip(String nroSerieEquip) {
		this.nroSerieEquip = nroSerieEquip;
	}
	public String getNroSerieSim() {
		return nroSerieSim;
	}
	public void setNroSerieSim(String nroSerieSim) {
		this.nroSerieSim = nroSerieSim;
	}
	public String getCondicH() {
		return condicH;
	}
	public void setCondicH(String condicH) {
		setCondicionesCK(condicH.equals("SI")?"on":null);
		this.condicH = condicH;
	}
	public String getAbonoDiferido() {
		return abonoDiferido;
	}
	public void setAbonoDiferido(String abonoDiferido) {
		this.abonoDiferido = abonoDiferido;
	}
	public String getCargaTributaria() {
		return cargaTributaria;
	}
	public void setCargaTributaria(String cargaTributaria) {
		this.cargaTributaria = cargaTributaria;
	}
	public String getCausaCambio() {
		return causaCambio;
	}
	public void setCausaCambio(String causaCambio) {
		this.causaCambio = causaCambio;
	}
	public String getCentral() {
		return central;
}
	public void setCentral(String central) {
		this.central = central;
	}
	public String getCuotas() {
		return cuotas;
	}
	public void setCuotas(String cuotas) {
		this.cuotas = cuotas;
	}
	public String getMesesProrroga() {
		return mesesProrroga;
	}
	public void setMesesProrroga(String mesesProrroga) {
		this.mesesProrroga = mesesProrroga;
	}
	public String getModalidadPago() {
		return modalidadPago;
	}
	public void setModalidadPago(String modalidadPago) {
		this.modalidadPago = modalidadPago;
	}
	public String getNroContratoParte1() {
		return nroContratoParte1;
	}
	public void setNroContratoParte1(String nroContratoParte1) {
		this.nroContratoParte1 = nroContratoParte1;
	}
	public String getNroContratoParte2() {
		return nroContratoParte2;
	}
	public void setNroContratoParte2(String nroContratoParte2) {
		this.nroContratoParte2 = nroContratoParte2;
	}
	public String getNroContratoParte3() {
		return nroContratoParte3;
	}
	public void setNroContratoParte3(String nroContratoParte3) {
		this.nroContratoParte3 = nroContratoParte3;
	}
	public String getPeriodo() {
		return periodo;
	}
	public void setPeriodo(String periodo) {
		this.periodo = periodo;
	}
	public String getProcedNuevoEquipo() {
		return procedNuevoEquipo;
	}
	public void setProcedNuevoEquipo(String procedNuevoEquipo) {
		this.procedNuevoEquipo = procedNuevoEquipo;
	}
	public String getTecnologia() {
		return tecnologia;
	}
	public void setTecnologia(String tecnologia) {
		this.tecnologia = tecnologia;
	}
	public String getTipoContrato() {
		return tipoContrato;
	}
	public void setTipoContrato(String tipoContrato) {
		this.tipoContrato = tipoContrato;
	}
	public String getTipoTerminal() {
		return tipoTerminal;
	}
	public void setTipoTerminal(String tipoTerminal) {
		this.tipoTerminal = tipoTerminal;
	}
	public String getCondicionesCK() {
		return condicionesCK;
	}
	public void setCondicionesCK(String condicionesCK) {
		this.condicionesCK = condicionesCK;
	}
	public String getUsoVentaEquip() {
		return usoVentaEquip;
	}
	public void setUsoVentaEquip(String usoVentaEquip) {
		this.usoVentaEquip = usoVentaEquip;
	}
	public String getUsoVentaSim() {
		return usoVentaSim;
	}
	public void setUsoVentaSim(String usoVentaSim) {
		this.usoVentaSim = usoVentaSim;
	}
	
	public String getDesFabricante() {
		return desFabricante;
	}
	public void setDesFabricante(String desFabricante) {
		this.desFabricante = desFabricante;
	}
	public String getArticulos() {
		return articulos;
	}
	public void setArticulos(String articulos) {
		this.articulos = articulos;
	}
	public String getFlagBloqueoEquipoEx() {
		return flagBloqueoEquipoEx;
	}
	public void setFlagBloqueoEquipoEx(String flagBloqueoEquipoEx) {
		this.flagBloqueoEquipoEx = flagBloqueoEquipoEx;
	}
	public String getNroSerie() {
		return nroSerie;
	}
	public void setNroSerie(String nroSerie) {
		this.nroSerie = nroSerie;
	}	
} // CambioDeSerieForm
