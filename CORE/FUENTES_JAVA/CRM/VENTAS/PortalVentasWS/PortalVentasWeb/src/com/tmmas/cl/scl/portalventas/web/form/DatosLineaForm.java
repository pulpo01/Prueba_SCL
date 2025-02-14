package com.tmmas.cl.scl.portalventas.web.form;

import java.text.NumberFormat;
import java.util.ArrayList;

import org.apache.struts.action.ActionForm;

import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.IdentificadorCivilComDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.DatosDireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.FormularioDireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.FormularioNumerosSMSDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CreditoConsumoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.GrupoCobroServicioDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.MonedaDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.GrupoPrestacionDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.SeguroDTO;

public class DatosLineaForm extends ActionForm {
	private static final long serialVersionUID = 1L;
	
	NumberFormat numberFormat;

	private String codGrpPrestacion;

	private GrupoPrestacionDTO[] arrayGrpPrestacion;

	// (+) combo de tipo de prestacion
	private String codTipoPrestacion;

	private String codTipoPrestacionSeleccionada;

	private String codNivel1;

	private String codNivel2;

	private String codNivel3;

	private String codNivel1Seleccionado;

	private String codNivel2Seleccionado;

	private String codNivel3Seleccionado;

	private String tipoRed;

	private String indNumero;

	private String indDirInstalacion;

	private String indInvFijo;

	private String indSS;

	private String indNumeroPiloto;

	// (-)
	private String codRegion;

	private DatosDireccionDTO[] arrayRegiones;

	private String codCelda;

	private String codCeldaSeleccionada;

	private String codSubAlm;

	private String codProvincia;

	private String codProvinciaSeleccionada;

	private String codCentral;

	private String codCentralSeleccionada;

	private String codTecnologia;

	private String codCiudad;

	private String codCiudadSeleccionada;

	private String codUsoLinea;

	private String codUsoLineaSeleccionado;

	private String codPlanTarif;

	private String codPlanTarifSeleccionado;

	private String codTipoTerminal;

	private String codTipoTerminalSeleccionado;

	private String codCreditoConsumo;

	private CreditoConsumoDTO[] arrayCreditoConsumo;

	private String codLimiteConsumo;

	private String codLimiteConsumoSeleccionado;

	private String codPlanServicio;

	private String codPlanServicioSeleccionado;

	private String codGrupoCobroServ;

	private GrupoCobroServicioDTO[] arrayGrpCobroServicio;

	private String codCausaDescuento;

	private String codCausaDescuentoSeleccionada;

	private String codCampanaVigente;

	//private CampanaVigenteDTO[] arrayCampanasVigentes;

	//private double valorRefPorMinuto;
	
	//private Double valorRefPorMinuto;
	
	private String valorRefPorMinuto;

	private String codMoneda;

	private MonedaDTO[] arrayMonedas;

	private String numSerie;

	private String numCelularSimcard;

	private String fechaSimcard;

	private String flgSerieKit;

	private String flgSerieNumerada;

	private String codTipoSeguro;

	private SeguroDTO[] arrayTiposSeguro;

	private String vigenciaSeguro;

	private String codProcedencia;

	private String numEquipo;

	private String numCelularEquipo;

	private String fechaEquipo;

	private String codProcedenciaEquipo;

	private String codArticuloEquipo;

	private String glsArticuloEquipo;

	// (+) reserva y anulacion de numero celular
	private String numCelular;

	private String tablaNumeracion;

	private String categoriaNumeracion;

	private String codSubAlmNumeracion;

	private String codCentralNumeracion;

	private String codUsoNumeracion;

	private String numCelularInternet;

	private String rdProcedenciaNumero;

	private String procedenciaNumero;

	// (-)
	private String numIP;

	private String observacion;

	private String nomUsuario;

	private String apellido1;

	private String apellido2;

	private String telefono;

	private String tipoIdentificacionUsuario;

	private IdentificadorCivilComDTO[] arrayIdentificadorUsuario;

	private String numeroIdentificacionUsuario;

	private String direccionPersonal;

	private String direccionInstalacion;

	private FormularioDireccionDTO direccionPersonaForm;

	private FormularioDireccionDTO direccionInstalacionForm;

	private String flgMostrarFrecuentes;

	private String flgAplicaSeguro;

	private String codTipoCliente;

	private String codTipoClientePrepago;

	private String flgActivarBtnFinalizar;

	private String codCentralDefault;

	private String codTelefoniaMovil;

	private String codTelefoniaFija;

	private String codInternet;

	private String codCarrier;

	private String codOperadora;

	private String codOperadoraSalvador;

	private String flgConsultaFinalizar;

	private String flgConsultaPA;

	private String filtroPlan;

	private double montoLimiteConsumo;

	private String largoNumCelular;

	private String descripcionColor;

	private String descripcionSegmento;

	private double montoMinimo;

	private double montoMaximo;

	private int flgCorte;

	private double montoCons;

	private String aplicaRenovacion;

	private String codRenovacion;
	
	private String indNumeroCortoSMS;
	
	private FormularioNumerosSMSDTO[] arrayNumerosSms;
	
	private String[] grpPrestacionesSinLC;
	
	private String[] tiposPlanTarifarioSinLC;
	
	private String codModuloOrigen="";
	
	private int cantidadLineas;
	
	private ArrayList arrayListServSup = new ArrayList();
	
	//Inicio P-CSR-11002 JLGN 16-05-2011
	private String passCalificacion;
	private String flagCalificacion;
	private String codCalificacion;
	private String codRegionAux;
	private String codProvinciaAux;
	private String codCiudadAux;
	private String flagExisteClienteBuro;
	//Fin P-CSR-11002 JLGN 16-05-2011
	//Inicio P-CSR-11002 JLGN 16-08-2011
	private String limiteCredito;
	private String limiteCreditoIngresado;
	private String codCalificacionIngresado;
	//Fin P-CSR-11002 JLGN 16-08-2011

	public String getFlagExisteClienteBuro() {
		return flagExisteClienteBuro;
	}

	public void setFlagExisteClienteBuro(String flagExisteClienteBuro) {
		this.flagExisteClienteBuro = flagExisteClienteBuro;
	}

	public String getCodCiudadAux() {
		return codCiudadAux;
	}

	public void setCodCiudadAux(String codCiudadAux) {
		this.codCiudadAux = codCiudadAux;
	}

	public String getCodProvinciaAux() {
		return codProvinciaAux;
	}

	public void setCodProvinciaAux(String codProvinciaAux) {
		this.codProvinciaAux = codProvinciaAux;
	}

	public String getCodRegionAux() {
		return codRegionAux;
	}

	public void setCodRegionAux(String codRegionAux) {
		this.codRegionAux = codRegionAux;
	}

	public ArrayList getArrayListServSup() {
		return arrayListServSup;
	}

	public void setArrayListServSup(ArrayList arrayListServSup) {
		this.arrayListServSup = arrayListServSup;
	}

	public String getCodModuloOrigen() {
		return codModuloOrigen;
	}

	public void setCodModuloOrigen(String codModuloOrigen) {
		this.codModuloOrigen = codModuloOrigen;
	}

	public FormularioNumerosSMSDTO[] getArrayNumerosSms() {
		return arrayNumerosSms;
	}

	public void setArrayNumerosSms(FormularioNumerosSMSDTO[] arrayNumerosSms) {
		this.arrayNumerosSms = arrayNumerosSms;
	}

	public String getIndNumeroCortoSMS() {
		return indNumeroCortoSMS;
	}

	public void setIndNumeroCortoSMS(String indNumeroCortoSMS) {
		this.indNumeroCortoSMS = indNumeroCortoSMS;
	}

	public String getCodRenovacion() {
		return codRenovacion;
	}

	public void setCodRenovacion(String codRenovacion) {
		this.codRenovacion = codRenovacion;
	}

	public String getAplicaRenovacion() {
		return aplicaRenovacion;
	}

	public void setAplicaRenovacion(String aplicaRenovacion) {
		this.aplicaRenovacion = aplicaRenovacion;
	}

	public String getDescripcionColor() {
		return descripcionColor;
	}

	public void setDescripcionColor(String descripcionColor) {
		this.descripcionColor = descripcionColor;
	}

	public String getDescripcionSegmento() {
		return descripcionSegmento;
	}

	public void setDescripcionSegmento(String descripcionSegmento) {
		this.descripcionSegmento = descripcionSegmento;
	}

	public String getLargoNumCelular() {
		return largoNumCelular;
	}

	public void setLargoNumCelular(String largoNumCelular) {
		this.largoNumCelular = largoNumCelular;
	}

	public String getCodCarrier() {
		return codCarrier;
	}

	public void setCodCarrier(String codCarrier) {
		this.codCarrier = codCarrier;
	}

	public String getCodInternet() {
		return codInternet;
	}

	public void setCodInternet(String codInternet) {
		this.codInternet = codInternet;
	}

	public String getCodTelefoniaFija() {
		return codTelefoniaFija;
	}

	public void setCodTelefoniaFija(String codTelefoniaFija) {
		this.codTelefoniaFija = codTelefoniaFija;
	}

	public String getCodTelefoniaMovil() {
		return codTelefoniaMovil;
	}

	public void setCodTelefoniaMovil(String codTelefoniaMovil) {
		this.codTelefoniaMovil = codTelefoniaMovil;
	}

	public String getCodCentralDefault() {
		return codCentralDefault;
	}

	public void setCodCentralDefault(String codCentralDefault) {
		this.codCentralDefault = codCentralDefault;
	}

	public String getTablaNumeracion() {
		return tablaNumeracion;
	}

	public void setTablaNumeracion(String tablaNumeracion) {
		this.tablaNumeracion = tablaNumeracion;
	}

	public String getFlgActivarBtnFinalizar() {
		return flgActivarBtnFinalizar;
	}

	public void setFlgActivarBtnFinalizar(String flgActivarBtnFinalizar) {
		this.flgActivarBtnFinalizar = flgActivarBtnFinalizar;
	}

	public String getCodTipoCliente() {
		return codTipoCliente;
	}

	public void setCodTipoCliente(String codTipoCliente) {
		this.codTipoCliente = codTipoCliente;
	}

	public String getFlgAplicaSeguro() {
		return flgAplicaSeguro;
	}

	public void setFlgAplicaSeguro(String flgAplicaSeguro) {
		this.flgAplicaSeguro = flgAplicaSeguro;
	}

	public String getFlgMostrarFrecuentes() {
		return flgMostrarFrecuentes;
	}

	public void setFlgMostrarFrecuentes(String flgMostrarFrecuentes) {
		this.flgMostrarFrecuentes = flgMostrarFrecuentes;
	}

	public String getApellido1() {
		return apellido1;
	}

	public void setApellido1(String apellido1) {
		this.apellido1 = apellido1;
	}

	public String getApellido2() {
		return apellido2;
	}

	public void setApellido2(String apellido2) {
		this.apellido2 = apellido2;
	}

	public String getCodCampanaVigente() {
		return codCampanaVigente;
	}

	public void setCodCampanaVigente(String codCampanaVigente) {
		this.codCampanaVigente = codCampanaVigente;
	}

	public String getCodCausaDescuento() {
		return codCausaDescuento;
	}

	public void setCodCausaDescuento(String codCausaDescuento) {
		this.codCausaDescuento = codCausaDescuento;
	}

	public String getCodCelda() {
		return codCelda;
	}

	public void setCodCelda(String codCelda) {
		this.codCelda = codCelda;
	}

	public String getCodCentral() {
		return codCentral;
	}

	public void setCodCentral(String codCentral) {
		this.codCentral = codCentral;
	}

	public String getCodCiudad() {
		return codCiudad;
	}

	public void setCodCiudad(String codCiudad) {
		this.codCiudad = codCiudad;
	}

	public String getCodCreditoConsumo() {
		return codCreditoConsumo;
	}

	public void setCodCreditoConsumo(String codCreditoConsumo) {
		this.codCreditoConsumo = codCreditoConsumo;
	}

	public String getCodGrupoCobroServ() {
		return codGrupoCobroServ;
	}

	public void setCodGrupoCobroServ(String codGrupoCobroServ) {
		this.codGrupoCobroServ = codGrupoCobroServ;
	}

	public String getCodLimiteConsumo() {
		return codLimiteConsumo;
	}

	public void setCodLimiteConsumo(String codLimiteConsumo) {
		this.codLimiteConsumo = codLimiteConsumo;
	}

	public String getCodPlanServicio() {
		return codPlanServicio;
	}

	public void setCodPlanServicio(String codPlanServicio) {
		this.codPlanServicio = codPlanServicio;
	}

	public String getCodPlanTarif() {
		return codPlanTarif;
	}

	public void setCodPlanTarif(String codPlanTarif) {
		this.codPlanTarif = codPlanTarif;
	}

	public String getCodProcedencia() {
		return codProcedencia;
	}

	public void setCodProcedencia(String codProcedencia) {
		this.codProcedencia = codProcedencia;
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

	public String getCodTipoPrestacion() {
		return codTipoPrestacion;
	}

	public void setCodTipoPrestacion(String codTipoPrestacion) {
		this.codTipoPrestacion = codTipoPrestacion;
	}

	public String getCodTipoSeguro() {
		return codTipoSeguro;
	}

	public void setCodTipoSeguro(String codTipoSeguro) {
		this.codTipoSeguro = codTipoSeguro;
	}

	public String getCodTipoTerminal() {
		return codTipoTerminal;
	}

	public void setCodTipoTerminal(String codTipoTerminal) {
		this.codTipoTerminal = codTipoTerminal;
	}

	public String getCodUsoLinea() {
		return codUsoLinea;
	}

	public void setCodUsoLinea(String codUsoLinea) {
		this.codUsoLinea = codUsoLinea;
	}

	public String getDireccionInstalacion() {
		return direccionInstalacion;
	}

	public void setDireccionInstalacion(String direccionInstalacion) {
		this.direccionInstalacion = direccionInstalacion;
	}

	public String getDireccionPersonal() {
		return direccionPersonal;
	}

	public void setDireccionPersonal(String direccionPersonal) {
		this.direccionPersonal = direccionPersonal;
	}

	public String getNomUsuario() {
		return nomUsuario;
	}

	public void setNomUsuario(String nomUsuario) {
		this.nomUsuario = nomUsuario;
	}

	public String getNumCelular() {
		return numCelular;
	}

	public void setNumCelular(String numCelular) {
		this.numCelular = numCelular;
	}

	public String getNumEquipo() {
		return numEquipo;
	}

	public void setNumEquipo(String numEquipo) {
		this.numEquipo = numEquipo;
	}

	public String getNumIP() {
		return numIP;
	}

	public void setNumIP(String numIP) {
		this.numIP = numIP;
	}

	public String getNumSerie() {
		return numSerie;
	}

	public void setNumSerie(String numSerie) {
		this.numSerie = numSerie;
	}

	public String getObservacion() {
		return observacion;
	}

	public void setObservacion(String observacion) {
		this.observacion = observacion;
	}

//	public Double getValorRefPorMinuto() {
//		return valorRefPorMinuto;
//	}
	
//	public String getValorRefPorMinuto() {
//		return numberFormat.format(new Double(valorRefPorMinuto));
//	}

//	public void setValorRefPorMinuto(Double valorRefPorMinuto) {
//		this.valorRefPorMinuto = valorRefPorMinuto;
//	}
	
//	public void setValorRefPorMinuto(String valorRefPorMinuto) {
//		this.valorRefPorMinuto = Double.parseDouble(valorRefPorMinuto);
//	}
	
	public String getValorRefPorMinuto() {
		return valorRefPorMinuto;
	}

	public void setValorRefPorMinuto(String valorRefPorMinuto) {
		this.valorRefPorMinuto = valorRefPorMinuto;
	}

	public String getCodGrpPrestacion() {
		return codGrpPrestacion;
	}

	public void setCodGrpPrestacion(String codGrpPrestacion) {
		this.codGrpPrestacion = codGrpPrestacion;
	}

	public String getCodMoneda() {
		return codMoneda;
	}

	public void setCodMoneda(String codMoneda) {
		this.codMoneda = codMoneda;
	}

	public String getVigenciaSeguro() {
		return vigenciaSeguro;
	}

	public void setVigenciaSeguro(String vigenciaSeguro) {
		this.vigenciaSeguro = vigenciaSeguro;
	}

	public IdentificadorCivilComDTO[] getArrayIdentificadorUsuario() {
		return arrayIdentificadorUsuario;
	}

	public void setArrayIdentificadorUsuario(IdentificadorCivilComDTO[] arrayIdentificadorUsuario) {
		this.arrayIdentificadorUsuario = arrayIdentificadorUsuario;
	}

	public String getNumeroIdentificacionUsuario() {
		return numeroIdentificacionUsuario;
	}

	public void setNumeroIdentificacionUsuario(String numeroIdentificacionUsuario) {
		this.numeroIdentificacionUsuario = numeroIdentificacionUsuario;
	}

	public String getTipoIdentificacionUsuario() {
		return tipoIdentificacionUsuario;
	}

	public void setTipoIdentificacionUsuario(String tipoIdentificacionUsuario) {
		this.tipoIdentificacionUsuario = tipoIdentificacionUsuario;
	}

	public GrupoPrestacionDTO[] getArrayGrpPrestacion() {
		return arrayGrpPrestacion;
	}

	public void setArrayGrpPrestacion(GrupoPrestacionDTO[] arrayGrpPrestacion) {
		this.arrayGrpPrestacion = arrayGrpPrestacion;
	}

	public String getCodTipoPrestacionSeleccionada() {
		return codTipoPrestacionSeleccionada;
	}

	public void setCodTipoPrestacionSeleccionada(String codTipoPrestacionSeleccionada) {
		this.codTipoPrestacionSeleccionada = codTipoPrestacionSeleccionada;
	}

	public DatosDireccionDTO[] getArrayRegiones() {
		return arrayRegiones;
	}

	public void setArrayRegiones(DatosDireccionDTO[] arrayRegiones) {
		this.arrayRegiones = arrayRegiones;
	}

	public String getCodCiudadSeleccionada() {
		return codCiudadSeleccionada;
	}

	public void setCodCiudadSeleccionada(String codCiudadSeleccionada) {
		this.codCiudadSeleccionada = codCiudadSeleccionada;
	}

	public String getCodProvinciaSeleccionada() {
		return codProvinciaSeleccionada;
	}

	public void setCodProvinciaSeleccionada(String codProvinciaSeleccionada) {
		this.codProvinciaSeleccionada = codProvinciaSeleccionada;
	}

	public FormularioDireccionDTO getDireccionInstalacionForm() {
		return direccionInstalacionForm;
	}

	public void setDireccionInstalacionForm(FormularioDireccionDTO direccionInstalacionForm) {
		this.direccionInstalacionForm = direccionInstalacionForm;
	}

	public FormularioDireccionDTO getDireccionPersonaForm() {
		return direccionPersonaForm;
	}

	public void setDireccionPersonaForm(FormularioDireccionDTO direccionPersonaForm) {
		this.direccionPersonaForm = direccionPersonaForm;
	}

	public String getCodCeldaSeleccionada() {
		return codCeldaSeleccionada;
	}

	public void setCodCeldaSeleccionada(String codCeldaSeleccionada) {
		this.codCeldaSeleccionada = codCeldaSeleccionada;
	}

	public String getCodCentralSeleccionada() {
		return codCentralSeleccionada;
	}

	public void setCodCentralSeleccionada(String codCentralSeleccionada) {
		this.codCentralSeleccionada = codCentralSeleccionada;
	}

	public String getCodSubAlm() {
		return codSubAlm;
	}

	public void setCodSubAlm(String codSubAlm) {
		this.codSubAlm = codSubAlm;
	}

	public CreditoConsumoDTO[] getArrayCreditoConsumo() {
		return arrayCreditoConsumo;
	}

	public void setArrayCreditoConsumo(CreditoConsumoDTO[] arrayCreditoConsumo) {
		this.arrayCreditoConsumo = arrayCreditoConsumo;
	}

	public GrupoCobroServicioDTO[] getArrayGrpCobroServicio() {
		return arrayGrpCobroServicio;
	}

	public void setArrayGrpCobroServicio(GrupoCobroServicioDTO[] arrayGrpCobroServicio) {
		this.arrayGrpCobroServicio = arrayGrpCobroServicio;
	}
	
	private String codCampanaVigenteSeleccionada;
	
	public String getCodCampanaVigenteSeleccionada() {
		return codCampanaVigenteSeleccionada;
	}

	public void setCodCampanaVigenteSeleccionada(String codCampanaVigenteSeleccionado) {
		this.codCampanaVigenteSeleccionada = codCampanaVigenteSeleccionado;
	}

//	public CampanaVigenteDTO[] getArrayCampanasVigentes() {
//		return arrayCampanasVigentes;
//	}
//
//	public void setArrayCampanasVigentes(CampanaVigenteDTO[] arrayCampanasVigentes) {
//		this.arrayCampanasVigentes = arrayCampanasVigentes;
//	}

	public String getCodPlanServicioSeleccionado() {
		return codPlanServicioSeleccionado;
	}

	public void setCodPlanServicioSeleccionado(String codPlanServicioSeleccionado) {
		this.codPlanServicioSeleccionado = codPlanServicioSeleccionado;
	}

	public String getCodUsoLineaSeleccionado() {
		return codUsoLineaSeleccionado;
	}

	public void setCodUsoLineaSeleccionado(String codUsoLineaSeleccionado) {
		this.codUsoLineaSeleccionado = codUsoLineaSeleccionado;
	}

	public String getCodPlanTarifSeleccionado() {
		return codPlanTarifSeleccionado;
	}

	public void setCodPlanTarifSeleccionado(String codPlanTarifSeleccionado) {
		this.codPlanTarifSeleccionado = codPlanTarifSeleccionado;
	}

	public String getCodLimiteConsumoSeleccionado() {
		return codLimiteConsumoSeleccionado;
	}

	public void setCodLimiteConsumoSeleccionado(String codLimiteConsumoSeleccionado) {
		this.codLimiteConsumoSeleccionado = codLimiteConsumoSeleccionado;
	}

	public String getCodTipoTerminalSeleccionado() {
		return codTipoTerminalSeleccionado;
	}

	public void setCodTipoTerminalSeleccionado(String codTipoTerminalSeleccionado) {
		this.codTipoTerminalSeleccionado = codTipoTerminalSeleccionado;
	}

	public String getCodCausaDescuentoSeleccionada() {
		return codCausaDescuentoSeleccionada;
	}

	public void setCodCausaDescuentoSeleccionada(String codCausaDescuentoSeleccionada) {
		this.codCausaDescuentoSeleccionada = codCausaDescuentoSeleccionada;
	}

	public SeguroDTO[] getArrayTiposSeguro() {
		return arrayTiposSeguro;
	}

	public void setArrayTiposSeguro(SeguroDTO[] arrayTiposSeguro) {
		this.arrayTiposSeguro = arrayTiposSeguro;
	}

	public MonedaDTO[] getArrayMonedas() {
		return arrayMonedas;
	}

	public void setArrayMonedas(MonedaDTO[] arrayMonedas) {
		this.arrayMonedas = arrayMonedas;
	}

	public String getCodTecnologia() {
		return codTecnologia;
	}

	public void setCodTecnologia(String codTecnologia) {
		this.codTecnologia = codTecnologia;
	}

	public String getCodProcedenciaEquipo() {
		return codProcedenciaEquipo;
	}

	public void setCodProcedenciaEquipo(String codProcedenciaEquipo) {
		this.codProcedenciaEquipo = codProcedenciaEquipo;
	}

	public String getTelefono() {
		return telefono;
	}

	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}

	public String getCodArticuloEquipo() {
		return codArticuloEquipo;
	}

	public void setCodArticuloEquipo(String codArticuloEquipo) {
		this.codArticuloEquipo = codArticuloEquipo;
	}

	public String getFechaEquipo() {
		return fechaEquipo;
	}

	public void setFechaEquipo(String fechaEquipo) {
		this.fechaEquipo = fechaEquipo;
	}

	public String getFechaSimcard() {
		return fechaSimcard;
	}

	public void setFechaSimcard(String fechaSimcard) {
		this.fechaSimcard = fechaSimcard;
	}

	public String getNumCelularEquipo() {
		return numCelularEquipo;
	}

	public void setNumCelularEquipo(String numCelularEquipo) {
		this.numCelularEquipo = numCelularEquipo;
	}

	public String getNumCelularSimcard() {
		return numCelularSimcard;
	}

	public void setNumCelularSimcard(String numCelularSimcard) {
		this.numCelularSimcard = numCelularSimcard;
	}

	public String getCodTipoClientePrepago() {
		return codTipoClientePrepago;
	}

	public void setCodTipoClientePrepago(String codTipoClientePrepago) {
		this.codTipoClientePrepago = codTipoClientePrepago;
	}

	public String getCategoriaNumeracion() {
		return categoriaNumeracion;
	}

	public void setCategoriaNumeracion(String categoriaNumeracion) {
		this.categoriaNumeracion = categoriaNumeracion;
	}

	public String getCodCentralNumeracion() {
		return codCentralNumeracion;
	}

	public void setCodCentralNumeracion(String codCentralNumeracion) {
		this.codCentralNumeracion = codCentralNumeracion;
	}

	public String getCodSubAlmNumeracion() {
		return codSubAlmNumeracion;
	}

	public void setCodSubAlmNumeracion(String codSubAlmNumeracion) {
		this.codSubAlmNumeracion = codSubAlmNumeracion;
	}

	public String getCodUsoNumeracion() {
		return codUsoNumeracion;
	}

	public void setCodUsoNumeracion(String codUsoNumeracion) {
		this.codUsoNumeracion = codUsoNumeracion;
	}

	public String getIndDirInstalacion() {
		return indDirInstalacion;
	}

	public void setIndDirInstalacion(String indDirInstalacion) {
		this.indDirInstalacion = indDirInstalacion;
	}

	public String getIndInvFijo() {
		return indInvFijo;
	}

	public void setIndInvFijo(String indInvFijo) {
		this.indInvFijo = indInvFijo;
	}

	public String getIndNumero() {
		return indNumero;
	}

	public void setIndNumero(String indNumero) {
		this.indNumero = indNumero;
	}

	public String getTipoRed() {
		return tipoRed;
	}

	public void setTipoRed(String tipoRed) {
		this.tipoRed = tipoRed;
	}

	public String getIndSS() {
		return indSS;
	}

	public void setIndSS(String indSS) {
		this.indSS = indSS;
	}

	public String getRdProcedenciaNumero() {
		return rdProcedenciaNumero;
	}

	public void setRdProcedenciaNumero(String rdProcedenciaNumero) {
		this.rdProcedenciaNumero = rdProcedenciaNumero;
	}

	public String getNumCelularInternet() {
		return numCelularInternet;
	}

	public void setNumCelularInternet(String numCelularInternet) {
		this.numCelularInternet = numCelularInternet;
	}

	public String getProcedenciaNumero() {
		return procedenciaNumero;
	}

	public void setProcedenciaNumero(String procedenciaNumero) {
		this.procedenciaNumero = procedenciaNumero;
	}

	public String getFlgSerieKit() {
		return flgSerieKit;
	}

	public void setFlgSerieKit(String flgSerieKit) {
		this.flgSerieKit = flgSerieKit;
	}

	public String getFlgSerieNumerada() {
		return flgSerieNumerada;
	}

	public void setFlgSerieNumerada(String flgSerieNumerada) {
		this.flgSerieNumerada = flgSerieNumerada;
	}

	public String getGlsArticuloEquipo() {
		return glsArticuloEquipo;
	}

	public void setGlsArticuloEquipo(String glsArticuloEquipo) {
		this.glsArticuloEquipo = glsArticuloEquipo;
	}

	public String getCodOperadora() {
		return codOperadora;
	}

	public void setCodOperadora(String codOperadora) {
		this.codOperadora = codOperadora;
	}

	public String getCodOperadoraSalvador() {
		return codOperadoraSalvador;
	}

	public void setCodOperadoraSalvador(String codOperadoraSalvador) {
		this.codOperadoraSalvador = codOperadoraSalvador;
	}

	public String getFlgConsultaFinalizar() {
		return flgConsultaFinalizar;
	}

	public void setFlgConsultaFinalizar(String flgConsultaFinalizar) {
		this.flgConsultaFinalizar = flgConsultaFinalizar;
	}

	public String getFiltroPlan() {
		return filtroPlan;
	}

	public void setFiltroPlan(String filtroPlan) {
		this.filtroPlan = filtroPlan;
	}

	public double getMontoLimiteConsumo() {
		return montoLimiteConsumo;
	}

	public void setMontoLimiteConsumo(double montoLimiteConsumo) {
		this.montoLimiteConsumo = montoLimiteConsumo;
	}

	public int getFlgCorte() {
		return flgCorte;
	}

	public void setFlgCorte(int flgCorte) {
		this.flgCorte = flgCorte;
	}

	public double getMontoCons() {
		return montoCons;
	}

	public void setMontoCons(double montoCons) {
		this.montoCons = montoCons;
	}

	public double getMontoMaximo() {
		return montoMaximo;
	}

	public void setMontoMaximo(double montoMaximo) {
		this.montoMaximo = montoMaximo;
	}

	public double getMontoMinimo() {
		return montoMinimo;
	}

	public void setMontoMinimo(double montoMinimo) {
		this.montoMinimo = montoMinimo;
	}

	public String getIndNumeroPiloto() {
		return indNumeroPiloto;
	}

	public void setIndNumeroPiloto(String indNumeroPiloto) {
		this.indNumeroPiloto = indNumeroPiloto;
	}

	public String getCodNivel1() {
		return codNivel1;
	}

	public void setCodNivel1(String codNivel1) {
		this.codNivel1 = codNivel1;
	}

	public String getCodNivel1Seleccionado() {
		return codNivel1Seleccionado;
	}

	public void setCodNivel1Seleccionado(String codNivel1Seleccionado) {
		this.codNivel1Seleccionado = codNivel1Seleccionado;
	}

	public String getCodNivel2() {
		return codNivel2;
	}

	public void setCodNivel2(String codNivel2) {
		this.codNivel2 = codNivel2;
	}

	public String getCodNivel2Seleccionado() {
		return codNivel2Seleccionado;
	}

	public void setCodNivel2Seleccionado(String codNivel2Seleccionado) {
		this.codNivel2Seleccionado = codNivel2Seleccionado;
	}

	public String getCodNivel3() {
		return codNivel3;
	}

	public void setCodNivel3(String codNivel3) {
		this.codNivel3 = codNivel3;
	}

	public String getCodNivel3Seleccionado() {
		return codNivel3Seleccionado;
	}

	public void setCodNivel3Seleccionado(String codNivel3Seleccionado) {
		this.codNivel3Seleccionado = codNivel3Seleccionado;
	}

	public String getFlgConsultaPA() {
		return flgConsultaPA;
	}

	public void setFlgConsultaPA(String flgConsultaPA) {
		this.flgConsultaPA = flgConsultaPA;
	}

	public final String[] getGrpPrestacionesSinLC() {
		return grpPrestacionesSinLC;
	}

	public final void setGrpPrestacionesSinLC(String[] grpPrestacionesSinLC) {
		this.grpPrestacionesSinLC = grpPrestacionesSinLC;
	}

	public final String[] getTiposPlanTarifarioSinLC() {
		return tiposPlanTarifarioSinLC;
	}

	public final void setTiposPlanTarifarioSinLC(String[] tiposPlanTarifarioSinLC) {
		this.tiposPlanTarifarioSinLC = tiposPlanTarifarioSinLC;
	}

	public NumberFormat getNumberFormat() {
		return numberFormat;
	}

	public void setNumberFormat(NumberFormat numberFormat) {
		this.numberFormat = numberFormat;
	}

	public int getCantidadLineas() {
		return cantidadLineas;
	}

	public void setCantidadLineas(int cantidadLineas) {
		this.cantidadLineas = cantidadLineas;
	}

	public String getCodCalificacion() {
		return codCalificacion;
	}

	public void setCodCalificacion(String codCalificacion) {
		this.codCalificacion = codCalificacion;
	}

	public String getFlagCalificacion() {
		return flagCalificacion;
	}

	public void setFlagCalificacion(String flagCalificacion) {
		this.flagCalificacion = flagCalificacion;
	}

	public String getPassCalificacion() {
		return passCalificacion;
	}

	public void setPassCalificacion(String passCalificacion) {
		this.passCalificacion = passCalificacion;
	}

	public String getLimiteCredito() {
		return limiteCredito;
	}

	public void setLimiteCredito(String limiteCredito) {
		this.limiteCredito = limiteCredito;
	}

	public String getLimiteCreditoIngresado() {
		return limiteCreditoIngresado;
	}

	public void setLimiteCreditoIngresado(String limiteCreditoIngresado) {
		this.limiteCreditoIngresado = limiteCreditoIngresado;
	}

	public String getCodCalificacionIngresado() {
		return codCalificacionIngresado;
	}

	public void setCodCalificacionIngresado(String codCalificacionIngresado) {
		this.codCalificacionIngresado = codCalificacionIngresado;
	}
}
