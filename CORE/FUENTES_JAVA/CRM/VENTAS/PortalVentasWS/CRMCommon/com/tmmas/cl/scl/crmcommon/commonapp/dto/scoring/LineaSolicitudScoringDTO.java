package com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring;

import java.io.Serializable;
import java.util.ArrayList;

public class LineaSolicitudScoringDTO implements Serializable {

	private static final long serialVersionUID = 7245544804324226804L;

	private ArrayList arrayListServSup = new ArrayList();
	
	private ProductoOfertadoDTO[] arrayPA;

	private long codArticuloEquipo;

	private String codCampanaVigente;

	private String codCausaDescuento;

	private String codCelda;

	private long codCentral;

	private String codCreditoConsumo;

	private String codDepartamento;

	private String codGrpPrestacion;

	private String codLimiteConsumo;

	private String codMonedaArticulo;

	private String codMonedaCargoBasico;

	private String codMonedaSeguro;

	private String codMunicipio;

	private String codPlanServ;

	private String codPlantarif;

	private String codPrestacion;

	private String codProcedencia;

	private String codSeguro;

	private String codSubAlm;

	private String codTecnologia;

	private String codTipoTerminal;

	private int codUso;

	private String codZona;

	private String filtroPlan;

	private int flgCorte;

	private Double importeArticulo;

	private Double importeCargoBasico;

	private Double importeSeguro;

	private String indRenovacion;

	private double montoCons;

	private Double montoLimiteConsumo;

	private double montoMaximo;

	private double montoMinimo;

	private long numLineaScoring;

	private long numSolScoring;

	private String codGrupoCobroServ;

	private String codCalificacion;
	
	private String desPrestacion;
	
	private String desPlanTarifario;	

	public String getCodCalificacion() {
		return codCalificacion;
	}

	public void setCodCalificacion(String codCalificacion) {
		this.codCalificacion = codCalificacion;
	}

	public String getCodGrupoCobroServ() {
		return codGrupoCobroServ;
	}

	public void setCodGrupoCobroServ(String codGrupoCobroServ) {
		this.codGrupoCobroServ = codGrupoCobroServ;
	}

	public ArrayList getArrayListServSup() {
		return arrayListServSup;
	}

	public void setArrayListServSup(ArrayList arrayListServSup) {
		this.arrayListServSup = arrayListServSup;
	}

	public long getCodArticuloEquipo() {
		return codArticuloEquipo;
	}

	public void setCodArticuloEquipo(long codArticuloEquipo) {
		this.codArticuloEquipo = codArticuloEquipo;
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

	public long getCodCentral() {
		return codCentral;
	}

	public void setCodCentral(long codCentral) {
		this.codCentral = codCentral;
	}

	public String getCodCreditoConsumo() {
		return codCreditoConsumo;
	}

	public void setCodCreditoConsumo(String codCreditoConsumo) {
		this.codCreditoConsumo = codCreditoConsumo;
	}

	public String getCodDepartamento() {
		return codDepartamento;
	}

	public void setCodDepartamento(String codDepartamento) {
		this.codDepartamento = codDepartamento;
	}

	public String getCodGrpPrestacion() {
		return codGrpPrestacion;
	}

	public void setCodGrpPrestacion(String codGrpPrestacion) {
		this.codGrpPrestacion = codGrpPrestacion;
	}

	public String getCodLimiteConsumo() {
		return codLimiteConsumo;
	}

	public void setCodLimiteConsumo(String codLimiteConsumo) {
		this.codLimiteConsumo = codLimiteConsumo;
	}

	public String getCodMonedaArticulo() {
		return codMonedaArticulo;
	}

	public void setCodMonedaArticulo(String codMonedaArticulo) {
		this.codMonedaArticulo = codMonedaArticulo;
	}

	public String getCodMonedaCargoBasico() {
		return codMonedaCargoBasico;
	}

	public void setCodMonedaCargoBasico(String codMonedaCargoBasico) {
		this.codMonedaCargoBasico = codMonedaCargoBasico;
	}

	public String getCodMonedaSeguro() {
		return codMonedaSeguro;
	}

	public void setCodMonedaSeguro(String codMonedaSeguro) {
		this.codMonedaSeguro = codMonedaSeguro;
	}

	public String getCodMunicipio() {
		return codMunicipio;
	}

	public void setCodMunicipio(String codMunicipio) {
		this.codMunicipio = codMunicipio;
	}

	public String getCodPlanServ() {
		return codPlanServ;
	}

	public void setCodPlanServ(String codPlanServ) {
		this.codPlanServ = codPlanServ;
	}

	public String getCodPlantarif() {
		return codPlantarif;
	}

	public void setCodPlantarif(String codPlantarif) {
		this.codPlantarif = codPlantarif;
	}

	public String getCodPrestacion() {
		return codPrestacion;
	}

	public void setCodPrestacion(String codPrestacion) {
		this.codPrestacion = codPrestacion;
	}

	public String getCodProcedencia() {
		return codProcedencia;
	}

	public void setCodProcedencia(String codProcedencia) {
		this.codProcedencia = codProcedencia;
	}

	public String getCodSeguro() {
		return codSeguro;
	}

	public void setCodSeguro(String codSeguro) {
		this.codSeguro = codSeguro;
	}

	public String getCodSubAlm() {
		return codSubAlm;
	}

	public void setCodSubAlm(String codSubAlm) {
		this.codSubAlm = codSubAlm;
	}

	public String getCodTecnologia() {
		return codTecnologia;
	}

	public void setCodTecnologia(String codTecnologia) {
		this.codTecnologia = codTecnologia;
	}

	public String getCodTipoTerminal() {
		return codTipoTerminal;
	}

	public void setCodTipoTerminal(String codTipoTerminal) {
		this.codTipoTerminal = codTipoTerminal;
	}

	public int getCodUso() {
		return codUso;
	}

	public void setCodUso(int codUso) {
		this.codUso = codUso;
	}

	public String getCodZona() {
		return codZona;
	}

	public void setCodZona(String codZona) {
		this.codZona = codZona;
	}

	public String getFiltroPlan() {
		return filtroPlan;
	}

	public void setFiltroPlan(String filtroPlan) {
		this.filtroPlan = filtroPlan;
	}

	public int getFlgCorte() {
		return flgCorte;
	}

	public void setFlgCorte(int flgCorte) {
		this.flgCorte = flgCorte;
	}

	public Double getImporteArticulo() {
		return importeArticulo;
	}

	public void setImporteArticulo(Double importeArticulo) {
		this.importeArticulo = importeArticulo;
	}

	public Double getImporteCargoBasico() {
		return importeCargoBasico;
	}

	public void setImporteCargoBasico(Double importeCargoBasico) {
		this.importeCargoBasico = importeCargoBasico;
	}

	public Double getImporteSeguro() {
		return importeSeguro;
	}

	public void setImporteSeguro(Double importeSeguro) {
		this.importeSeguro = importeSeguro;
	}

	public String getIndRenovacion() {
		return indRenovacion;
	}

	public void setIndRenovacion(String indRenovacion) {
		this.indRenovacion = indRenovacion;
	}

	public double getMontoCons() {
		return montoCons;
	}

	public void setMontoCons(double montoCons) {
		this.montoCons = montoCons;
	}

	public Double getMontoLimiteConsumo() {
		return montoLimiteConsumo;
	}

	public void setMontoLimiteConsumo(Double montoLimiteConsumo) {
		this.montoLimiteConsumo = montoLimiteConsumo;
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

	public long getNumLineaScoring() {
		return numLineaScoring;
	}

	public void setNumLineaScoring(long numLineaScoring) {
		this.numLineaScoring = numLineaScoring;
	}

	public long getNumSolScoring() {
		return numSolScoring;
	}

	public void setNumSolScoring(long numSolScoring) {
		this.numSolScoring = numSolScoring;
	}

	/**
	 * Constructs a <code>String</code> with all attributes in name = value format.
	 * 
	 * @return a <code>String</code> representation of this object.
	 */
	public String toString() {
		final String newline = "\n";

		StringBuffer b = new StringBuffer();

		b.append("LineaSolicitudScoringDTO ( ").append(super.toString()).append(newline);
		b.append("arrayListServSup = ").append(this.arrayListServSup).append(newline);
		b.append("codArticuloEquipo = ").append(this.codArticuloEquipo).append(newline);
		b.append("codCalificacion = ").append(this.codCalificacion).append(newline);
		b.append("codCampanaVigente = ").append(this.codCampanaVigente).append(newline);
		b.append("codCausaDescuento = ").append(this.codCausaDescuento).append(newline);
		b.append("codCelda = ").append(this.codCelda).append(newline);
		b.append("codCentral = ").append(this.codCentral).append(newline);
		b.append("codCreditoConsumo = ").append(this.codCreditoConsumo).append(newline);
		b.append("codDepartamento = ").append(this.codDepartamento).append(newline);
		b.append("codGrpPrestacion = ").append(this.codGrpPrestacion).append(newline);
		b.append("codLimiteConsumo = ").append(this.codLimiteConsumo).append(newline);
		b.append("codMonedaArticulo = ").append(this.codMonedaArticulo).append(newline);
		b.append("codMonedaCargoBasico = ").append(this.codMonedaCargoBasico).append(newline);
		b.append("codMonedaSeguro = ").append(this.codMonedaSeguro).append(newline);
		b.append("codMunicipio = ").append(this.codMunicipio).append(newline);
		b.append("codPlanServ = ").append(this.codPlanServ).append(newline);
		b.append("codPlantarif = ").append(this.codPlantarif).append(newline);
		b.append("codPrestacion = ").append(this.codPrestacion).append(newline);
		b.append("codProcedencia = ").append(this.codProcedencia).append(newline);
		b.append("codSeguro = ").append(this.codSeguro).append(newline);
		b.append("codSubAlm = ").append(this.codSubAlm).append(newline);
		b.append("codTecnologia = ").append(this.codTecnologia).append(newline);
		b.append("codTipoTerminal = ").append(this.codTipoTerminal).append(newline);
		b.append("codUso = ").append(this.codUso).append(newline);
		b.append("codZona = ").append(this.codZona).append(newline);
		b.append("filtroPlan = ").append(this.filtroPlan).append(newline);
		b.append("flgCorte = ").append(this.flgCorte).append(newline);
		b.append("importeArticulo = ").append(this.importeArticulo).append(newline);
		b.append("importeCargoBasico = ").append(this.importeCargoBasico).append(newline);
		b.append("importeSeguro = ").append(this.importeSeguro).append(newline);
		b.append("indRenovacion = ").append(this.indRenovacion).append(newline);
		b.append("montoCons = ").append(this.montoCons).append(newline);
		b.append("montoLimiteConsumo = ").append(this.montoLimiteConsumo).append(newline);
		b.append("montoMaximo = ").append(this.montoMaximo).append(newline);
		b.append("montoMinimo = ").append(this.montoMinimo).append(newline);
		b.append("numLineaScoring = ").append(this.numLineaScoring).append(newline);
		b.append("numSolScoring = ").append(this.numSolScoring).append(newline);
		b.append(" )");
		return b.toString();
	}	

	public String getDesPlanTarifario() {
		return desPlanTarifario;
	}

	public void setDesPlanTarifario(String desPlanTarifario) {
		this.desPlanTarifario = desPlanTarifario;
	}

	public String getDesPrestacion() {
		return desPrestacion;
	}

	public void setDesPrestacion(String desPrestacion) {
		this.desPrestacion = desPrestacion;
	}

	public ProductoOfertadoDTO[] getArrayPA() {
		return arrayPA;
	}

	public void setArrayPA(ProductoOfertadoDTO[] arrayPA) {
		this.arrayPA = arrayPA;
	}

}
