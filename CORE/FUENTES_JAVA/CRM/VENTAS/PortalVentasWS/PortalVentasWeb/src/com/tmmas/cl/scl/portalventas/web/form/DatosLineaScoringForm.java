package com.tmmas.cl.scl.portalventas.web.form;

import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.IdentificadorCivilComDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.DatosDireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.FormularioNumerosSMSDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CampanaVigenteDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CreditoConsumoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.GrupoCobroServicioDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.MonedaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.LineaSolicitudScoringDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.GrupoPrestacionDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.SeguroDTO;

/**
 * @author JIB
 */
public class DatosLineaScoringForm extends ResumenScoringForm {

	private static final long serialVersionUID = 5880900591529907726L;

	private String aplicaRenovacion;

	private CampanaVigenteDTO[] arrayCampanasVigentes;

	private CreditoConsumoDTO[] arrayCreditoConsumo;

	private GrupoCobroServicioDTO[] arrayGrpCobroServicio;

	private GrupoPrestacionDTO[] arrayGrpPrestacion;

	private IdentificadorCivilComDTO[] arrayIdentificadorUsuario;

	private MonedaDTO[] arrayMonedas;

	private FormularioNumerosSMSDTO[] arrayNumerosSms;

	private DatosDireccionDTO[] arrayRegiones;

	private SeguroDTO[] arrayTiposSeguro;

	private String categoriaNumeracion;

	private String codArticuloEquipoSeleccionado;

	private String codCarrier;

	private String codCausaDescuentoSeleccionada;

	private String codCeldaSeleccionada;

	private String codCentralDefault;

	private String codCentralNumeracion;

	private String codCentralSeleccionada;

	private String codCiudadSeleccionada;

	private String codInternet;

	private String codLimiteConsumoSeleccionado;

	private String codOperadora;

	private String codPlanServicioSeleccionado;

	private String codPlanTarifSeleccionado;

	private String codProvinciaSeleccionada;

	private String codSubAlmNumeracion;

	private String codTelefoniaFija;

	private String codTelefoniaMovil;

	private String codTipoPrestacionSeleccionada;

	private String codTipoTerminalSeleccionado;

	private String codUsoLineaSeleccionado;

	private String codUsoNumeracion;

	private String descripcionColor;

	private String fechaEquipo;

	private String fechaSimcard;

	String flgActivarBtnFinalizar;

	private String flgAplicaSeguro;
	
	//private String flgConsultaFinalizar;
	//private String flgConsultaPA;

	private String glsArticuloEquipo;

	private String grpPrestacionesSinLC;

	private String indDirInstalacion;

	private String indEquipo;

	private String indInvFijo;

	private String indNumero;

	private String indNumeroCortoSMS;

	private String indNumeroPiloto;

	private String indSS;

	private LineaSolicitudScoringDTO linea = new LineaSolicitudScoringDTO();

	private String numCelularSimcard;

	private String numIP;

	private String procedenciaNumero;

	private String tablaNumeracion;

	private String tipoRed;

	private String tiposPlanTarifarioSinLC;

	private String vigenciaSeguro;

	private String descripcionSegmento;

	private int cantidadLineas;
	
	private String codCampanaVigenteSeleccionada;
	
	public String getCodCampanaVigenteSeleccionada() {
		return codCampanaVigenteSeleccionada;
	}

	public void setCodCampanaVigenteSeleccionada(String codCampanaVigenteSeleccionado) {
		this.codCampanaVigenteSeleccionada = codCampanaVigenteSeleccionado;
	}

	public int getCantidadLineas() {
		return cantidadLineas;
	}

	public void setCantidadLineas(int cantidadLineas) {
		this.cantidadLineas = cantidadLineas;
	}

	public String getAplicaRenovacion() {
		return aplicaRenovacion;
	}

	public CampanaVigenteDTO[] getArrayCampanasVigentes() {
		return arrayCampanasVigentes;
	}

	public CreditoConsumoDTO[] getArrayCreditoConsumo() {
		return arrayCreditoConsumo;
	}

	public GrupoCobroServicioDTO[] getArrayGrpCobroServicio() {
		return arrayGrpCobroServicio;
	}

	public GrupoPrestacionDTO[] getArrayGrpPrestacion() {
		return arrayGrpPrestacion;
	}

	public IdentificadorCivilComDTO[] getArrayIdentificadorUsuario() {
		return arrayIdentificadorUsuario;
	}

	public MonedaDTO[] getArrayMonedas() {
		return arrayMonedas;
	}

	public FormularioNumerosSMSDTO[] getArrayNumerosSms() {
		return arrayNumerosSms;
	}

	public DatosDireccionDTO[] getArrayRegiones() {
		return arrayRegiones;
	}

	public SeguroDTO[] getArrayTiposSeguro() {
		return arrayTiposSeguro;
	}

	public String getCategoriaNumeracion() {
		return categoriaNumeracion;
	}

	public String getCodArticuloEquipo() {
		return this.linea.getCodArticuloEquipo() == 0 ? "" : new Long(linea.getCodArticuloEquipo()).toString();
	}

	public String getCodArticuloEquipoSeleccionado() {
		return codArticuloEquipoSeleccionado;
	}

	public String getCodCampanaVigente() {
		return this.linea.getCodCampanaVigente();
	}

	public String getCodCarrier() {
		return codCarrier;
	}

	public String getCodCausaDescuento() {
		return this.linea.getCodCausaDescuento();
	}

	public String getCodCausaDescuentoSeleccionada() {
		return codCausaDescuentoSeleccionada;
	}

	public String getCodCelda() {
		return this.linea.getCodCelda();
	}

	public String getCodCeldaSeleccionada() {
		return codCeldaSeleccionada;
	}

	public String getCodCentral() {
		return this.linea.getCodCentral() == 0 ? "" : new Long(linea.getCodCentral()).toString();
	}

	public String getCodCentralDefault() {
		return codCentralDefault;
	}

	public String getCodCentralNumeracion() {
		return codCentralNumeracion;
	}

	public String getCodCentralSeleccionada() {
		return codCentralSeleccionada;
	}

	public String getCodCiudad() {
		return this.linea.getCodZona();
	}

	public String getCodCiudadSeleccionada() {
		return codCiudadSeleccionada;
	}

	public String getCodCreditoConsumo() {
		return this.linea.getCodCreditoConsumo();
	}

	public String getCodGrpPrestacion() {
		return this.linea.getCodGrpPrestacion();
	}

	public String getCodGrupoCobroServ() {
		return this.linea.getCodGrupoCobroServ();
	}

	public String getCodInternet() {
		return codInternet;
	}

	public String getCodLimiteConsumo() {
		return this.linea.getCodLimiteConsumo();
	}

	public String getCodLimiteConsumoSeleccionado() {
		return codLimiteConsumoSeleccionado;
	}

	public String getCodMonedaArticulo() {
		return this.linea.getCodMonedaArticulo();
	}

	public String getCodMonedaCargoBasico() {
		return this.linea.getCodMonedaCargoBasico();
	}

	public String getCodMonedaSeguro() {
		return this.linea.getCodMonedaSeguro();
	}

	public String getCodOperadora() {
		return codOperadora;
	}

	public String getCodPlanServicio() {
		return this.linea.getCodPlanServ();
	}

	public String getCodPlanServicioSeleccionado() {
		return codPlanServicioSeleccionado;
	}

	public String getCodPlanTarif() {
		return this.linea.getCodPlantarif();
	}

	public String getCodPlanTarifSeleccionado() {
		return codPlanTarifSeleccionado;
	}

	//	public String getCodPrestacion() {
	//		return this.linea.getCodPrestacion();
	//	}

	public String getCodProcedencia() {
		return this.linea.getCodProcedencia();
	}

	public String getCodProvincia() {
		return this.linea.getCodMunicipio();
	}

	public String getCodProvinciaSeleccionada() {
		return codProvinciaSeleccionada;
	}

	public String getCodRegion() {
		return this.linea.getCodDepartamento();
	}

	public String getCodSeguro() {
		return this.linea.getCodSeguro();
	}

	public String getCodSubAlm() {
		return this.linea.getCodSubAlm();
	}

	public String getCodSubAlmNumeracion() {
		return codSubAlmNumeracion;
	}

	public String getCodTecnologia() {
		return this.linea.getCodTecnologia();
	}

	public String getCodTelefoniaFija() {
		return codTelefoniaFija;
	}

	public String getCodTelefoniaMovil() {
		return codTelefoniaMovil;
	}

	public String getCodTipoPrestacion() {
		return this.linea.getCodPrestacion();
	}

	public String getCodTipoPrestacionSeleccionada() {
		return codTipoPrestacionSeleccionada;
	}

	public String getCodTipoSeguro() {
		return this.linea.getCodSeguro();
	}

	public String getCodTipoTerminal() {
		return this.linea.getCodTipoTerminal();
	}

	public String getCodTipoTerminalSeleccionado() {
		return codTipoTerminalSeleccionado;
	}

	public String getCodUsoLinea() {
		return this.linea.getCodUso() == 0 ? "" : new Integer(linea.getCodUso()).toString();
	}

	public String getCodUsoLineaSeleccionado() {
		return codUsoLineaSeleccionado;
	}

	public String getCodUsoNumeracion() {
		return codUsoNumeracion;
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

	public String getFechaEquipo() {
		return fechaEquipo;
	}

	public String getFechaSimcard() {
		return fechaSimcard;
	}

	public String getFiltroPlan() {
		return this.linea.getFiltroPlan();
	}

	public String getFlgActivarBtnFinalizar() {
		return flgActivarBtnFinalizar;
	}

	public String getFlgAplicaSeguro() {
		return flgAplicaSeguro;
	}

	//	public String getFlgConsultaFinalizar() {
	//		return flgConsultaFinalizar;
	//	}

	//	public String getFlgConsultaPA() {
	//		return flgConsultaPA;
	//	}

	public int getFlgCorte() {
		return this.linea.getFlgCorte();
	}

	public String getGlsArticuloEquipo() {
		return glsArticuloEquipo;
	}

	public String getGrpPrestacionesSinLC() {
		return grpPrestacionesSinLC;
	}

	public Double getImporteArticulo() {
		return this.linea.getImporteArticulo();
	}

	public Double getImporteCargoBasico() {
		return this.linea.getImporteCargoBasico();
	}

	public Double getImporteSeguro() {
		return this.linea.getImporteSeguro();
	}

	public String getIndDirInstalacion() {
		return indDirInstalacion;
	}

	public String getIndEquipo() {
		return indEquipo;
	}

	public String getIndInvFijo() {
		return indInvFijo;
	}

	public String getIndNumero() {
		return indNumero;
	}

	public String getIndNumeroCortoSMS() {
		return indNumeroCortoSMS;
	}

	public String getIndNumeroPiloto() {
		return indNumeroPiloto;
	}

	public String getIndRenovacion() {
		return this.linea.getIndRenovacion();
	}

	public String getIndSS() {
		return indSS;
	}

	public LineaSolicitudScoringDTO getLinea() {
		return this.linea;
	}

	public double getMontoCons() {
		return this.linea.getMontoCons();
	}

	public Double getMontoLimiteConsumo() {
		return this.linea.getMontoLimiteConsumo();
	}

	public double getMontoMaximo() {
		return this.linea.getMontoMaximo();
	}

	public double getMontoMinimo() {
		return this.linea.getMontoMinimo();
	}

	public String getNumCelularSimcard() {
		return numCelularSimcard;
	}

	public String getNumIP() {
		return numIP;
	}

	public long getNumLineaScoring() {
		return this.linea.getNumLineaScoring();
	}

	public String getProcedenciaNumero() {
		return procedenciaNumero;
	}

	public String getTablaNumeracion() {
		return tablaNumeracion;
	}

	public String getTipoRed() {
		return tipoRed;
	}

	public String getTiposPlanTarifarioSinLC() {
		return tiposPlanTarifarioSinLC;
	}

	public String getVigenciaSeguro() {
		return vigenciaSeguro;
	}

	public void setAplicaRenovacion(String aplicaRenovacion) {
		this.aplicaRenovacion = aplicaRenovacion;
	}

	public void setArrayCampanasVigentes(CampanaVigenteDTO[] arrayCampanasVigentes) {
		this.arrayCampanasVigentes = arrayCampanasVigentes;
	}

	public void setArrayCreditoConsumo(CreditoConsumoDTO[] arrayCreditoConsumo) {
		this.arrayCreditoConsumo = arrayCreditoConsumo;
	}

	public void setArrayGrpCobroServicio(GrupoCobroServicioDTO[] arrayGrpCobroServicio) {
		this.arrayGrpCobroServicio = arrayGrpCobroServicio;
	}

	public void setArrayGrpPrestacion(GrupoPrestacionDTO[] arrayGrpPrestacion) {
		this.arrayGrpPrestacion = arrayGrpPrestacion;
	}

	public void setArrayIdentificadorUsuario(IdentificadorCivilComDTO[] arrayIdentificadorUsuario) {
		this.arrayIdentificadorUsuario = arrayIdentificadorUsuario;
	}

	public void setArrayMonedas(MonedaDTO[] arrayMonedas) {
		this.arrayMonedas = arrayMonedas;
	}

	public void setArrayNumerosSms(FormularioNumerosSMSDTO[] arrayNumerosSms) {
		this.arrayNumerosSms = arrayNumerosSms;
	}

	public void setArrayRegiones(DatosDireccionDTO[] arrayRegiones) {
		this.arrayRegiones = arrayRegiones;
	}

	public void setArrayTiposSeguro(SeguroDTO[] arrayTiposSeguro) {
		this.arrayTiposSeguro = arrayTiposSeguro;
	}

	public void setCategoriaNumeracion(String categoriaNumeracion) {
		this.categoriaNumeracion = categoriaNumeracion;
	}

	public void setCodArticuloEquipo(String codArticuloEquipo) {
		long l = codArticuloEquipo == null || codArticuloEquipo.equals("") ? 0 : new Long(codArticuloEquipo)
				.longValue();
		this.linea.setCodArticuloEquipo(l);
	}

	public void setCodArticuloEquipoSeleccionado(String codArticuloSeleccionado) {
		this.codArticuloEquipoSeleccionado = codArticuloSeleccionado;
	}

	public void setCodCampanaVigente(String codCampanaVigente) {
		this.linea.setCodCampanaVigente(codCampanaVigente);
	}

	public void setCodCarrier(String codCarrier) {
		this.codCarrier = codCarrier;
	}

	public void setCodCausaDescuento(String codCausaDescuento) {
		this.linea.setCodCausaDescuento(codCausaDescuento);
	}

	public void setCodCausaDescuentoSeleccionada(String codCausaDescuentoSeleccionada) {
		this.codCausaDescuentoSeleccionada = codCausaDescuentoSeleccionada;
	}

	public void setCodCelda(String codCelda) {
		this.linea.setCodCelda(codCelda);
	}

	public void setCodCeldaSeleccionada(String codCeldaSeleccionada) {
		this.codCeldaSeleccionada = codCeldaSeleccionada;
	}

	public void setCodCentral(String codCentral) {
		long l = codCentral == null || codCentral.equals("") ? 0 : new Long(codCentral).longValue();
		this.linea.setCodCentral(l);
	}

	public void setCodCentralDefault(String codCentralDefault) {
		this.codCentralDefault = codCentralDefault;
	}

	public void setCodCentralNumeracion(String codCentralNumeracion) {
		this.codCentralNumeracion = codCentralNumeracion;
	}

	public void setCodCentralSeleccionada(String codCentralSeleccionada) {
		this.codCentralSeleccionada = codCentralSeleccionada;
	}

	public void setCodCiudad(String codCiudad) {
		this.linea.setCodZona(codCiudad);
	}

	public void setCodCiudadSeleccionada(String codCiudadSeleccionada) {
		this.codCiudadSeleccionada = codCiudadSeleccionada;
	}

	public void setCodCreditoConsumo(String codCreditoConsumo) {
		this.linea.setCodCreditoConsumo(codCreditoConsumo);
	}

	public void setCodGrpPrestacion(String codGrpPrestacion) {
		this.linea.setCodGrpPrestacion(codGrpPrestacion);
	}

	public void setCodGrupoCobroServ(String codGrupoCobroServ) {
		this.linea.setCodGrupoCobroServ(codGrupoCobroServ);
	}

	public void setCodInternet(String codInternet) {
		this.codInternet = codInternet;
	}

	public void setCodLimiteConsumo(String codLimiteConsumo) {
		this.linea.setCodLimiteConsumo(codLimiteConsumo);
	}

	public void setCodLimiteConsumoSeleccionado(String codLimiteConsumoSeleccionado) {
		this.codLimiteConsumoSeleccionado = codLimiteConsumoSeleccionado;
	}

	public void setCodMonedaArticulo(String codMonedaArticulo) {
		this.linea.setCodMonedaArticulo(codMonedaArticulo);
	}

	public void setCodMonedaCargoBasico(String codMonedaCargoBasico) {
		this.linea.setCodMonedaCargoBasico(codMonedaCargoBasico);
	}

	public void setCodMonedaSeguro(String codMonedaSeguro) {
		this.linea.setCodMonedaSeguro(codMonedaSeguro);
	}

	public void setCodMunicipio(String codMunicipio) {
		this.linea.setCodMunicipio(codMunicipio);
	}

	public void setCodOperadora(String codOperadora) {
		this.codOperadora = codOperadora;
	}

	public void setCodPlanServicio(String codPlanServicio) {
		this.linea.setCodPlanServ(codPlanServicio);
	}

	public void setCodPlanServicioSeleccionado(String codPlanServicioSeleccionado) {
		this.codPlanServicioSeleccionado = codPlanServicioSeleccionado;
	}

	public void setCodPlanTarif(String codPlantarif) {
		this.linea.setCodPlantarif(codPlantarif);
	}

	public void setCodPlanTarifSeleccionado(String codPlanTarifSeleccionado) {
		this.codPlanTarifSeleccionado = codPlanTarifSeleccionado;
	}

	//	public void setCodPrestacion(String codPrestacion) {
	//		this.linea.setCodPrestacion(codPrestacion);
	//	}

	public void setCodProcedencia(String codProcedencia) {
		this.linea.setCodProcedencia(codProcedencia);
	}

	public void setCodProvincia(String codProvincia) {
		this.linea.setCodMunicipio(codProvincia);
	}

	public void setCodProvinciaSeleccionada(String codProvinciaSeleccionada) {
		this.codProvinciaSeleccionada = codProvinciaSeleccionada;
	}

	public void setCodRegion(String codRegion) {
		this.linea.setCodDepartamento(codRegion);
	}

	public void setCodSeguro(String codSeguro) {
		this.linea.setCodSeguro(codSeguro);
	}

	public void setCodSubAlm(String codSubAlm) {
		this.linea.setCodSubAlm(codSubAlm);
	}

	public void setCodSubAlmNumeracion(String codSubAlmNumeracion) {
		this.codSubAlmNumeracion = codSubAlmNumeracion;
	}

	public void setCodTecnologia(String codTecnologia) {
		this.linea.setCodTecnologia(codTecnologia);
	}

	public void setCodTelefoniaFija(String codTelefoniaFija) {
		this.codTelefoniaFija = codTelefoniaFija;
	}

	public void setCodTelefoniaMovil(String codTelefoniaMovil) {
		this.codTelefoniaMovil = codTelefoniaMovil;
	}

	public void setCodTipoPrestacion(String codTipoPrestacion) {
		this.linea.setCodPrestacion(codTipoPrestacion);
	}

	public void setCodTipoPrestacionSeleccionada(String codTipoPrestacionSeleccionada) {
		this.codTipoPrestacionSeleccionada = codTipoPrestacionSeleccionada;
	}

	public void setCodTipoSeguro(String codTipoSeguro) {
		this.linea.setCodSeguro(codTipoSeguro);
	}

	public void setCodTipoTerminal(String codTipoTerminal) {
		this.linea.setCodTipoTerminal(codTipoTerminal);
	}

	public void setCodTipoTerminalSeleccionado(String codTipoTerminalSeleccionado) {
		this.codTipoTerminalSeleccionado = codTipoTerminalSeleccionado;
	}

	public void setCodUsoLinea(String codUsoLinea) {
		int codUso = codUsoLinea == null || codUsoLinea.equals("") ? 0 : new Integer(codUsoLinea).intValue();
		this.linea.setCodUso(codUso);
	}

	public void setCodUsoLineaSeleccionado(String codUsoLineaSeleccionado) {
		this.codUsoLineaSeleccionado = codUsoLineaSeleccionado;
	}

	public void setCodUsoNumeracion(String codUsoNumeracion) {
		this.codUsoNumeracion = codUsoNumeracion;
	}

	public void setFechaEquipo(String fechaEquipo) {
		this.fechaEquipo = fechaEquipo;
	}

	public void setFechaSimcard(String fechaSimcard) {
		this.fechaSimcard = fechaSimcard;
	}

	public void setFiltroPlan(String filtroPlan) {
		this.linea.setFiltroPlan(filtroPlan);
	}

	public void setFlgActivarBtnFinalizar(String flgActivarBtnFinalizar) {
		this.flgActivarBtnFinalizar = flgActivarBtnFinalizar;
	}

	public void setFlgAplicaSeguro(String flgAplicaSeguro) {
		this.flgAplicaSeguro = flgAplicaSeguro;
	}

	//	public void setFlgConsultaFinalizar(String flgConsultaFinalizar) {
	//		this.flgConsultaFinalizar = flgConsultaFinalizar;
	//	}

	//	public void setFlgConsultaPA(String flgConsultaPA) {
	//		this.flgConsultaPA = flgConsultaPA;
	//	}

	public void setFlgCorte(int flgCorte) {
		this.linea.setFlgCorte(flgCorte);
	}

	public void setGlsArticuloEquipo(String glsArticuloEquipo) {
		this.glsArticuloEquipo = glsArticuloEquipo;
	}

	public void setGrpPrestacionesSinLC(String grpPrestacionesSinLC) {
		this.grpPrestacionesSinLC = grpPrestacionesSinLC;
	}

	public void setImporteArticulo(Double importeArticulo) {
		this.linea.setImporteArticulo(importeArticulo);
	}

	public void setImporteCargoBasico(Double importeCargoBasico) {
		this.linea.setImporteCargoBasico(importeCargoBasico);
	}

	public void setImporteSeguro(Double importeSeguro) {
		this.linea.setImporteSeguro(importeSeguro);
	}

	public void setIndDirInstalacion(String indDirInstalacion) {
		this.indDirInstalacion = indDirInstalacion;
	}

	public void setIndEquipo(String indEquipo) {
		this.indEquipo = indEquipo;
	}

	public void setIndInvFijo(String indInvFijo) {
		this.indInvFijo = indInvFijo;
	}

	public void setIndNumero(String indNumero) {
		this.indNumero = indNumero;
	}

	public void setIndNumeroCortoSMS(String indNumeroCortoSMS) {
		this.indNumeroCortoSMS = indNumeroCortoSMS;
	}

	public void setIndNumeroPiloto(String indNumeroPiloto) {
		this.indNumeroPiloto = indNumeroPiloto;
	}

	public void setIndRenovacion(String indRenovacion) {
		this.linea.setIndRenovacion(indRenovacion);
	}

	public void setIndSS(String indSS) {
		this.indSS = indSS;
	}

	public void setLinea(LineaSolicitudScoringDTO linea) {
		this.linea = linea;
	}

	public void setMontoCons(double montoCons) {
		this.linea.setMontoCons(montoCons);
	}

	public void setMontoLimiteConsumo(Double montoLimiteConsumo) {
		this.linea.setMontoLimiteConsumo(montoLimiteConsumo);
	}

	public void setMontoMaximo(double montoMaximo) {
		this.linea.setMontoMaximo(montoMaximo);
	}

	public void setMontoMinimo(double montoMinimo) {
		this.linea.setMontoMinimo(montoMinimo);
	}

	public void setNumCelularSimcard(String numCelularSimcard) {
		this.numCelularSimcard = numCelularSimcard;
	}

	public void setNumIP(String numIP) {
		this.numIP = numIP;
	}

	public void setNumLineaScoring(long numLineaScoring) {
		this.linea.setNumLineaScoring(numLineaScoring);
	}

	public void setProcedenciaNumero(String procedenciaNumero) {
		this.procedenciaNumero = procedenciaNumero;
	}

	public void setTablaNumeracion(String tablaNumeracion) {
		this.tablaNumeracion = tablaNumeracion;
	}

	public void setTipoRed(String tipoRed) {
		this.tipoRed = tipoRed;
	}

	public void setTiposPlanTarifarioSinLC(String tiposPlanTarifarioSinLC) {
		this.tiposPlanTarifarioSinLC = tiposPlanTarifarioSinLC;
	}

	public void setVigenciaSeguro(String vigenciaSeguro) {
		this.vigenciaSeguro = vigenciaSeguro;
	}

	public String getCodCalificacion() {
		return linea.getCodCalificacion();
	}

	public void setCodCalificacion(String codCalificacion) {
		linea.setCodCalificacion(codCalificacion);
	}

}
