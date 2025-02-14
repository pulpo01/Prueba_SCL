package com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;

public class ScoreClienteDTO implements Serializable {

	private static final long serialVersionUID = 7245544804324226804L;

	private String anioVencimientoTarjeta;

	private String antiguedad_laboral;

	private String aplicaTarjeta; // SI-NO

	private String capacidad_pago;

	private long codCliente;

	private String codBancoTarjeta;

	private int codTipoCliente = 2;

	private DatosGeneralesScoringDTO datosGeneralesScoringDTO;

	private String documento;

	private EstadoScoringDTO estadoActualDTO;

	private DominioScoringDTO estadoCivil = new DominioScoringDTO();

	private Date fecha_creacion;

	private Date fecha_nacimiento;

	private double ingresosMensuales;

	private ArrayList lineas = new ArrayList();

	private String mesVencimientoTarjeta;

	private DominioScoringDTO nacionalidad = new DominioScoringDTO();

	private String nit;

	private DominioScoringDTO nivelAcademico = new DominioScoringDTO();

	private String nomUsuarioOra;

	private long numSolScoring;

	private String numTarjeta;

	private String primer_apellido;

	private String primer_nombre;

	private String segundo_apellido;

	private String segundo_nombre;

	private String tip_producto;
	
	private String codTipoTarjetaSCL;

	private DominioScoringDTO tipoDocumento = new DominioScoringDTO();

	private DominioScoringDTO tipoEmpresa = new DominioScoringDTO();

	private DominioScoringDTO tipoTarjeta = new DominioScoringDTO();

	public ScoreClienteDTO() {
		datosGeneralesScoringDTO = new DatosGeneralesScoringDTO();
		estadoActualDTO = new EstadoScoringDTO();
	}

	public String getAnioVencimientoTarjeta() {
		return anioVencimientoTarjeta;
	}

	public String getAntiguedad_laboral() {
		return antiguedad_laboral;
	}

	public String getAplicaTarjeta() {
		return aplicaTarjeta;
	}

	public String getCapacidad_pago() {
		return capacidad_pago;
	}

	public long getCodCliente() {
		return codCliente;
	}

	public String getCodEstadoCivil() {
		return estadoCivil.getCodigo();
	}

	public String getCodBancoTarjeta() {
		return codBancoTarjeta;
	}

	public String getCodNacionalidad() {
		return nacionalidad.getCodigo();
	}

	public String getCodNivelAcademico() {
		return nivelAcademico.getCodigo();
	}

	public int getCodTipoCliente() {
		return codTipoCliente;
	}

	public String getCodTipoDocumento() {
		return tipoDocumento.getCodigo();
	}

	public String getCodTipoEmpresa() {
		return tipoEmpresa.getCodigo();
	}

	public String getCodTipoTarjeta() {
		return tipoTarjeta.getCodigo();
	}

	public DatosGeneralesScoringDTO getDatosGeneralesScoringDTO() {
		return datosGeneralesScoringDTO;
	}

	public String getDesEstadoCivil() {
		return estadoCivil.getValor();
	}

	public String getDesNacionalidad() {
		return nacionalidad.getValor();
	}

	public String getDesNivelAcademico() {
		return nivelAcademico.getValor();
	}

	public String getDesTipoDocumento() {
		return tipoDocumento.getValor();
	}

	public String getDesTipoEmpresa() {
		return tipoEmpresa.getValor();
	}

	public String getDesTipoTarjeta() {
		return tipoTarjeta.getValor();
	}

	public String getDocumento() {
		return documento;
	}

	public EstadoScoringDTO getEstadoActualDTO() {
		return estadoActualDTO;
	}

	public Date getFecha_creacion() {
		return fecha_creacion;
	}

	public Date getFecha_nacimiento() {
		return fecha_nacimiento;
	}

	public String getI_cod_elementoid() {
		if (this.getDatosGeneralesScoringDTO().getIndVtaExterna() == "1") {
			return this.getDatosGeneralesScoringDTO().getCodVendedorDealer().toString();
		}
		else {
			return new Long(this.getDatosGeneralesScoringDTO().getCodVendedor()).toString();
		}
	}

	public String getI_creado_por() {
		if (this.getDatosGeneralesScoringDTO().getIndVtaExterna() == "1") {
			return this.getDatosGeneralesScoringDTO().getCodVendedorDealer().toString();
		}
		else {
			return new Long(this.getDatosGeneralesScoringDTO().getCodVendedor()).toString();
		}
	}

	public double getIngresosMensuales() {
		return ingresosMensuales;
	}

	public ArrayList getLineas() {
		return lineas;
	}

	public String getMesVencimientoTarjeta() {
		return mesVencimientoTarjeta;
	}

	public String getNit() {
		return nit;
	}

	public String getNombreCompleto() {
		StringBuffer b = new StringBuffer();
		if (primer_nombre != null && !primer_nombre.equals("")) {
			b.append(primer_nombre);
		}
		if (segundo_nombre != null && !segundo_nombre.equals("")) {
			b.append(" ");
			b.append(segundo_nombre);
		}
		if (primer_apellido != null && !primer_apellido.equals("")) {
			b.append(" ");
			b.append(primer_apellido);
		}
		if (segundo_apellido != null && !segundo_apellido.equals("")) {
			b.append(" ");
			b.append(segundo_apellido);
		}
		return b.toString();
	}

	public String getNomUsuarioOra() {
		return nomUsuarioOra;
	}

	public long getNumSolScoring() {
		return numSolScoring;
	}

	public String getNumTarjeta() {
		return numTarjeta;
	}

	public String getPrimer_apellido() {
		return primer_apellido;
	}

	public String getPrimer_nombre() {
		return primer_nombre;
	}

	public String getSegundo_apellido() {
		return segundo_apellido;
	}

	public String getSegundo_nombre() {
		return segundo_nombre;
	}

	public String getTip_producto() {
		return tip_producto;
	}

	public void setAnioVencimientoTarjeta(String anioVencimientoTarjeta) {
		this.anioVencimientoTarjeta = anioVencimientoTarjeta;
	}

	public void setAntiguedad_laboral(String antiguedad_laboral) {
		this.antiguedad_laboral = antiguedad_laboral;
	}

	public void setAplicaTarjeta(String aplicaTarjeta) {
		this.aplicaTarjeta = aplicaTarjeta;
	}

	public void setCapacidad_pago(String capacidad_pago) {
		this.capacidad_pago = capacidad_pago;
	}

	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}

	public void setCodEstadoCivil(String codEstadoCivil) {
		estadoCivil.setCodigo(codEstadoCivil);
	}

	public void setCodBancoTarjeta(String codigoBanco) {
		this.codBancoTarjeta = codigoBanco;
	}

	public void setCodNacionalidad(String codNacionalidad) {
		nacionalidad.setCodigo(codNacionalidad);
	}

	public void setCodNivelAcademico(String codNivelAcademico) {
		nivelAcademico.setCodigo(codNivelAcademico);
	}

	public void setCodTipoCliente(int codTipoCliente) {
		this.codTipoCliente = codTipoCliente;
	}

	public void setCodTipoDocumento(String codTipoDocumento) {
		this.tipoDocumento.setCodigo(codTipoDocumento);
	}

	public void setCodTipoEmpresa(String codTipoEmpresa) {
		tipoEmpresa.setCodigo(codTipoEmpresa);
	}

	public void setCodTipoTarjeta(String codTipoTarjeta) {
		tipoTarjeta.setCodigo(codTipoTarjeta);
	}

	public void setDatosGeneralesScoringDTO(DatosGeneralesScoringDTO datosGeneralesScoringDTO) {
		this.datosGeneralesScoringDTO = datosGeneralesScoringDTO;
	}

	public void setDesEstadoCivil(String desEstadoCivil) {
		estadoCivil.setValor(desEstadoCivil);
	}

	public void setDesNacionalidad(String desNacionalidad) {
		nacionalidad.setValor(desNacionalidad);
	}

	public void setDesNivelAcademico(String desNivelAcademico) {
		nivelAcademico.setValor(desNivelAcademico);
	}

	public void setDesTipoDocumento(String desTipoDocumento) {
		this.tipoDocumento.setValor(desTipoDocumento);
	}

	public void setDesTipoEmpresa(String desTipoEmpresa) {
		tipoEmpresa.setValor(desTipoEmpresa);
	}

	public void setDesTipoTarjeta(String desTipoTarjeta) {
		tipoTarjeta.setValor(desTipoTarjeta);
	}

	public void setDocumento(String documento) {
		this.documento = documento;
	}

	public void setEstadoActualDTO(EstadoScoringDTO estadoScoringDTO) {
		this.estadoActualDTO = estadoScoringDTO;
	}

	public void setFecha_creacion(Date fecha_creacion) {
		this.fecha_creacion = fecha_creacion;
	}

	public void setFecha_nacimiento(Date fechaNacimiento) {
		this.fecha_nacimiento = fechaNacimiento;
	}

	public void setIngresosMensuales(double ingresosMensuales) {
		this.ingresosMensuales = ingresosMensuales;
	}

	public void setLineas(ArrayList lineas) {
		for (Iterator iter = lineas.iterator(); iter.hasNext();) {
			LineaSolicitudScoringDTO element = (LineaSolicitudScoringDTO) iter.next();
			element.setNumSolScoring(numSolScoring);
		}
		this.lineas = lineas;
	}

	public void setMesVencimientoTarjeta(String mesVencimientoTarjeta) {
		this.mesVencimientoTarjeta = mesVencimientoTarjeta;
	}

	public void setNit(String nit) {
		this.nit = nit;
	}

	public void setNomUsuarioOra(String nomUsuarioOra) {
		this.nomUsuarioOra = nomUsuarioOra;
	}

	public void setNumSolScoring(long numSolScoring) {
		this.numSolScoring = numSolScoring;
	}

	public void setNumTarjeta(String numTarjeta) {
		this.numTarjeta = numTarjeta;
	}

	public void setPrimer_apellido(String primer_apellido) {
		this.primer_apellido = primer_apellido;
	}

	public void setPrimer_nombre(String primer_nombre) {
		this.primer_nombre = primer_nombre;
	}

	public void setSegundo_apellido(String segundo_apellido) {
		this.segundo_apellido = segundo_apellido;
	}

	public void setSegundo_nombre(String segundo_nombre) {
		this.segundo_nombre = segundo_nombre;
	}

	public void setTip_producto(String tip_producto) {
		this.tip_producto = tip_producto;
	}

	public String toString() {
		StringBuffer b = new StringBuffer();
		b.append(super.toString() + "\n");
		b.append("getAnioVencimientoTarjeta() [" + getAnioVencimientoTarjeta() + "]\n");
		b.append("getAntiguedad_laboral() [" + getAntiguedad_laboral() + "]\n");
		b.append("getAplicaTarjeta() [" + getAplicaTarjeta() + "]\n");
		b.append("getNumSolScoring() [" + getNumSolScoring() + "]\n");
		b.append("getCapacidad_pago() [" + getCapacidad_pago() + "]\n");
		b.append("getCodCliente() [" + getCodCliente() + "]\n");
		b.append("getCodBancoTarjeta() [" + getCodBancoTarjeta() + "]\n");
		b.append("getDocumento() [" + getDocumento() + "]\n");
		b.append("getFecha_creacion() [" + getFecha_creacion() + "]\n");
		b.append("getFecha_nacimiento() [" + getFecha_nacimiento() + "]\n");
		b.append("getMesVencimientoTarjeta() [" + getMesVencimientoTarjeta() + "]\n");
		b.append("getNit() [" + getNit() + "]\n");
		b.append("getNomUsuarioOra() [" + getNomUsuarioOra() + "]\n");
		b.append("getPrimer_apellido() [" + getPrimer_apellido() + "]\n");
		b.append("getPrimer_nombre() [" + getPrimer_nombre() + "]\n");
		b.append("getSegundo_apellido() [" + getSegundo_apellido() + "]\n");
		b.append("getSegundo_nombre() [" + getSegundo_nombre() + "]\n");
		b.append("getTarjeta() [" + getAplicaTarjeta() + "]\n");
		b.append("getTip_producto() [" + getTip_producto() + "]\n");
		b.append("getCodTipoDocumento() [" + getCodTipoDocumento() + "]\n");
		b.append("getDesTipoDocumento() [" + getDesTipoDocumento() + "]\n");
		b.append("getCodEstadoCivil() [" + getCodEstadoCivil() + "]\n");
		b.append("getDesEstadoCivil() [" + getDesEstadoCivil() + "]\n");
		b.append("getCodNacionalidad() [" + getCodNacionalidad() + "]\n");
		b.append("getDesNacionalidad() [" + getDesNacionalidad() + "]\n");
		b.append("getCodNivelAcademico() [" + getCodNivelAcademico() + "]\n");
		b.append("getDesNivelAcademico() [" + getDesNivelAcademico() + "]\n");
		b.append("getCodTipoEmpresa() [" + getCodTipoEmpresa() + "]\n");
		b.append("getDesTipoEmpresa() [" + getDesTipoEmpresa() + "]\n");
		b.append("getCodTipoTarjeta() [" + getCodTipoTarjeta() + "]\n");
		b.append("getDesTipoTarjeta() [" + getDesTipoTarjeta() + "]\n");
		b.append("getI_cod_elementoid() [" + getI_cod_elementoid() + "]\n");
		b.append("getI_creado_por() [" + getI_creado_por() + "]\n");
		b.append("getNumTarjeta() [" + getNumTarjeta() + "]\n");
		b.append("getCodTipoTarjetaSCL() [" + getCodTipoTarjetaSCL() + "]\n");

		b.append(getDatosGeneralesScoringDTO().toString());
		b.append(getEstadoActualDTO().toString());
		for (Iterator iter = getLineas().iterator(); iter.hasNext();) {
			LineaSolicitudScoringDTO linea = (LineaSolicitudScoringDTO) iter.next();
			b.append(linea.toString());
		}
		return b.toString();
	}

	public String getCodTipoTarjetaSCL() {
		return codTipoTarjetaSCL;
	}

	public void setCodTipoTarjetaSCL(String codTipoTarjetaSCL) {
		this.codTipoTarjetaSCL = codTipoTarjetaSCL;
	}

}
