package com.tmmas.cl.scl.altacliente.presentacion.form;

import org.apache.struts.action.ActionForm;

import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.CargoLaboralDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.DatosGeneralesComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ProfesionDTO;

public class DatosParticularForm extends ActionForm {
	private static final long serialVersionUID = 1L;

	private String nombreCliente;

	private String primerApellido;

	private String segundoApellido;

	private String codNacionalidad;

	private DatosGeneralesComDTO[] arrayNacionalidad;

	private String fechaNacimiento;

	private String sexo;

	private String estadoCivil;

	private DatosGeneralesComDTO[] arrayEstadoCivil;

	private String nombreConyuge;

	private String empresaTrabaja;

	private String codProfesion;

	private ProfesionDTO[] arrayProfesion;

	private String codCargo;

	private CargoLaboralDTO[] arrayCargo;

	private String telefonoOficina;

	private double ingresosMensuales;

	private String jefeInmediato;

	private String anosLaborando;

	private String largoNumCelular;

	String hoyMenosVeinte;
	
	//Inicio P-CSR-11002 JLGN 10-09-2011
	private String flagTipCliente; 

	public String getFlagTipCliente() {
		return flagTipCliente;
	}

	public void setFlagTipCliente(String flagTipCliente) {
		this.flagTipCliente = flagTipCliente;
	}
	//Fin P-CSR-11002 JLGN 10-09-2011

	public final String getHoyMenosVeinte() {
		return hoyMenosVeinte;
	}

	public final void setHoyMenosVeinte(String fechaMenosVeinte) {
		this.hoyMenosVeinte = fechaMenosVeinte;
	}

	public String getLargoNumCelular() {
		return largoNumCelular;
	}

	public void setLargoNumCelular(String largoNumCelular) {
		this.largoNumCelular = largoNumCelular;
	}

	public String getAnosLaborando() {
		return anosLaborando;
	}

	public void setAnosLaborando(String anosLaborando) {
		this.anosLaborando = anosLaborando;
	}

	public DatosGeneralesComDTO[] getArrayEstadoCivil() {
		return arrayEstadoCivil;
	}

	public void setArrayEstadoCivil(DatosGeneralesComDTO[] arrayEstadoCivil) {
		this.arrayEstadoCivil = arrayEstadoCivil;
	}

	public String getEmpresaTrabaja() {
		return empresaTrabaja;
	}

	public void setEmpresaTrabaja(String empresaTrabaja) {
		this.empresaTrabaja = empresaTrabaja;
	}

	public String getEstadoCivil() {
		return estadoCivil;
	}

	public void setEstadoCivil(String estadoCivil) {
		this.estadoCivil = estadoCivil;
	}

	public String getFechaNacimiento() {
		return fechaNacimiento;
	}

	public void setFechaNacimiento(String fechaNacimiento) {
		this.fechaNacimiento = fechaNacimiento;
	}

	public double getIngresosMensuales() {
		return ingresosMensuales;
	}

	public void setIngresosMensuales(double ingresosMensuales) {
		this.ingresosMensuales = ingresosMensuales;
	}

	public String getJefeInmediato() {
		return jefeInmediato;
	}

	public void setJefeInmediato(String jefeInmediato) {
		this.jefeInmediato = jefeInmediato;
	}

	public String getNombreCliente() {
		return nombreCliente;
	}

	public void setNombreCliente(String nombreCliente) {
		this.nombreCliente = nombreCliente;
	}

	public String getNombreConyuge() {
		return nombreConyuge;
	}

	public void setNombreConyuge(String nombreConyuge) {
		this.nombreConyuge = nombreConyuge;
	}

	public String getPrimerApellido() {
		return primerApellido;
	}

	public void setPrimerApellido(String primerApellido) {
		this.primerApellido = primerApellido;
	}

	public String getCodNacionalidad() {
		return codNacionalidad;
	}

	public void setCodNacionalidad(String codNacionalidad) {
		this.codNacionalidad = codNacionalidad;
	}

	public String getCodProfesion() {
		return codProfesion;
	}

	public void setCodProfesion(String codProfesion) {
		this.codProfesion = codProfesion;
	}

	public String getSegundoApellido() {
		return segundoApellido;
	}

	public void setSegundoApellido(String segundoApellido) {
		this.segundoApellido = segundoApellido;
	}

	public String getSexo() {
		return sexo;
	}

	public void setSexo(String sexo) {
		this.sexo = sexo;
	}

	public String getTelefonoOficina() {
		return telefonoOficina;
	}

	public void setTelefonoOficina(String telefonoOficina) {
		this.telefonoOficina = telefonoOficina;
	}

	public DatosGeneralesComDTO[] getArrayNacionalidad() {
		return arrayNacionalidad;
	}

	public void setArrayNacionalidad(DatosGeneralesComDTO[] arrayNacionalidad) {
		this.arrayNacionalidad = arrayNacionalidad;
	}

	public ProfesionDTO[] getArrayProfesion() {
		return arrayProfesion;
	}

	public void setArrayProfesion(ProfesionDTO[] arrayProfesion) {
		this.arrayProfesion = arrayProfesion;
	}

	public CargoLaboralDTO[] getArrayCargo() {
		return arrayCargo;
	}

	public void setArrayCargo(CargoLaboralDTO[] arrayCargo) {
		this.arrayCargo = arrayCargo;
	}

	public String getCodCargo() {
		return codCargo;
	}

	public void setCodCargo(String codCargo) {
		this.codCargo = codCargo;
	}

	// Incidencia 133761. Datos Cliente Particular mandatorios. Quedan configurables por la operadora.
	private String nomConyugeCasadoMandatorio = "NO";

	private String estadoCivilCasado;

	public String getNomConyugeCasadoMandatorio() {
		return nomConyugeCasadoMandatorio;
	}

	public void setNomConyugeCasadoMandatorio(String nomConyugeCasadoMandatorio) {
		this.nomConyugeCasadoMandatorio = nomConyugeCasadoMandatorio;
	}

	public String getEstadoCivilCasado() {
		return estadoCivilCasado;
	}

	public void setEstadoCivilCasado(String estadoCivilCasado) {
		this.estadoCivilCasado = estadoCivilCasado;
	}

	private String nomEmpresaMandatorio = "NO";

	private String nomJefeMandatorio = "NO";

	private String segundoApellidoMandatorio = "NO";

	public String getNomEmpresaMandatorio() {
		return nomEmpresaMandatorio;
	}

	public void setNomEmpresaMandatorio(String claveNomEmpresaMandatorio) {
		this.nomEmpresaMandatorio = claveNomEmpresaMandatorio;
	}

	public String getNomJefeMandatorio() {
		return nomJefeMandatorio;
	}

	public void setNomJefeMandatorio(String claveNomJefeMandatorio) {
		this.nomJefeMandatorio = claveNomJefeMandatorio;
	}

	public String getSegundoApellidoMandatorio() {
		return segundoApellidoMandatorio;
	}

	public void setSegundoApellidoMandatorio(String segundoApellidoMandatorio) {
		this.segundoApellidoMandatorio = segundoApellidoMandatorio;
	}

}
