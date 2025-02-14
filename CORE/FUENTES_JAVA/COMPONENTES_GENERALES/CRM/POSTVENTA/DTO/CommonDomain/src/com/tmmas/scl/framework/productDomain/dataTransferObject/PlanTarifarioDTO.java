package com.tmmas.scl.framework.productDomain.dataTransferObject;
import java.io.Serializable;

public class PlanTarifarioDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private String codPlanTarif;
	private String codigoPlanTarifario;//FrameworkCargos
	
	private String desPlanTarif;
	private String limiteConsumo;
	private String codCargoBasico;
	private String codigoCargoBasico;
	private String desCargoBasico;
	private float impCargoBasico;
	private float impFinal;
	
	//* usados para frameworkcargossrv*//
	private int numDias;
	private String tipoPlanTarifario;
	private String codigoPlanServicio;
	
	
	private String codigoProducto;
	private String codigoTecnologia;
	private String indicadorCargoHabilitacion;
	private String codigoTipoPlan;

	private double importeCargoBasico;
	private String codigoMonedaCargoBasico;
    private String codigoConcepto;
	private String descripcionConcepto;
	private String codigoCategoria;
	
    /*-- Limite de Consumo --*/
	private String formatoFecha1; 
	private String formatoFecha2; 
	private String descripcionLimiteConsumo;
	private double importeLimite;
	private String indicadorUnidades;
	private String indicadorDefault;
	private String fechaDesde;
	private String fechaHasta;
	
	private CategoriaListDTO categorias;
	private PaqueteDTO paqueteDefault;
	
	private String codCliente;
	private String numAbonado;
	
	private float impLimiteConsumo;
	
	private String codigoLimiteConsumo;
	
	public String getCodigoLimiteConsumo() {
		return codigoLimiteConsumo;
	}
	public void setCodigoLimiteConsumo(String codigoLimiteConsumo) {
		this.codigoLimiteConsumo = codigoLimiteConsumo;
	}
	public float getImpLimiteConsumo() {
		return impLimiteConsumo;
	}
	public void setImpLimiteConsumo(float impLimiteConsumo) {
		this.impLimiteConsumo = impLimiteConsumo;
	}
	public Object[] toStruct_PF_CLIEN_ABO_QT()
	{
		Object[] obj={	codCliente,
						numAbonado						
					 };		
		return obj;
	}
	/**
	 *  COD_CLIENTE NUMBER(8),
  		NUM_ABONADO NUMBER(8)
	 * 
	 */
	
	
	public String getCodCargoBasico() {
		return codCargoBasico;
	}
	public void setCodCargoBasico(String codCargoBasico) {
		this.codCargoBasico = codCargoBasico;
	}
	public String getCodPlanTarif() {
		return codPlanTarif;
	}
	public void setCodPlanTarif(String codPlanTarif) {
		this.codPlanTarif = codPlanTarif;
	}
	public String getDesCargoBasico() {
		return desCargoBasico;
	}
	public void setDesCargoBasico(String desCargoBasico) {
		this.desCargoBasico = desCargoBasico;
	}
	public String getDesPlanTarif() {
		return desPlanTarif;
	}
	public void setDesPlanTarif(String desPlanTarif) {
		this.desPlanTarif = desPlanTarif;
	}
	public String getCodigoCategoria() {
		return codigoCategoria;
	}
	public void setCodigoCategoria(String codigoCategoria) {
		this.codigoCategoria = codigoCategoria;
	}
	public String getCodigoConcepto() {
		return codigoConcepto;
	}
	public void setCodigoConcepto(String codigoConcepto) {
		this.codigoConcepto = codigoConcepto;
	}
	public String getCodigoMonedaCargoBasico() {
		return codigoMonedaCargoBasico;
	}
	public void setCodigoMonedaCargoBasico(String codigoMonedaCargoBasico) {
		this.codigoMonedaCargoBasico = codigoMonedaCargoBasico;
	}
	public String getCodigoPlanServicio() {
		return codigoPlanServicio;
	}
	public void setCodigoPlanServicio(String codigoPlanServicio) {
		this.codigoPlanServicio = codigoPlanServicio;
	}
	public String getCodigoProducto() {
		return codigoProducto;
	}
	public void setCodigoProducto(String codigoProducto) {
		this.codigoProducto = codigoProducto;
	}
	public String getCodigoTecnologia() {
		return codigoTecnologia;
	}
	public void setCodigoTecnologia(String codigoTecnologia) {
		this.codigoTecnologia = codigoTecnologia;
	}
	public String getCodigoTipoPlan() {
		return codigoTipoPlan;
	}
	public void setCodigoTipoPlan(String codigoTipoPlan) {
		this.codigoTipoPlan = codigoTipoPlan;
	}
	public String getDescripcionConcepto() {
		return descripcionConcepto;
	}
	public void setDescripcionConcepto(String descripcionConcepto) {
		this.descripcionConcepto = descripcionConcepto;
	}
	public String getDescripcionLimiteConsumo() {
		return descripcionLimiteConsumo;
	}
	public void setDescripcionLimiteConsumo(String descripcionLimiteConsumo) {
		this.descripcionLimiteConsumo = descripcionLimiteConsumo;
	}
	public String getFechaDesde() {
		return fechaDesde;
	}
	public void setFechaDesde(String fechaDesde) {
		this.fechaDesde = fechaDesde;
	}
	public String getFechaHasta() {
		return fechaHasta;
	}
	public void setFechaHasta(String fechaHasta) {
		this.fechaHasta = fechaHasta;
	}
	public String getFormatoFecha1() {
		return formatoFecha1;
	}
	public void setFormatoFecha1(String formatoFecha1) {
		this.formatoFecha1 = formatoFecha1;
	}
	public String getFormatoFecha2() {
		return formatoFecha2;
	}
	public void setFormatoFecha2(String formatoFecha2) {
		this.formatoFecha2 = formatoFecha2;
	}
	public double getImporteCargoBasico() {
		return importeCargoBasico;
	}
	public void setImporteCargoBasico(double importeCargoBasico) {
		this.importeCargoBasico = importeCargoBasico;
	}
	public double getImporteLimite() {
		return importeLimite;
	}
	public void setImporteLimite(double importeLimite) {
		this.importeLimite = importeLimite;
	}
	public String getIndicadorCargoHabilitacion() {
		return indicadorCargoHabilitacion;
	}
	public void setIndicadorCargoHabilitacion(String indicadorCargoHabilitacion) {
		this.indicadorCargoHabilitacion = indicadorCargoHabilitacion;
	}
	public String getIndicadorDefault() {
		return indicadorDefault;
	}
	public void setIndicadorDefault(String indicadorDefault) {
		this.indicadorDefault = indicadorDefault;
	}
	public String getIndicadorUnidades() {
		return indicadorUnidades;
	}
	public void setIndicadorUnidades(String indicadorUnidades) {
		this.indicadorUnidades = indicadorUnidades;
	}
	public int getNumDias() {
		return numDias;
	}
	public void setNumDias(int numDias) {
		this.numDias = numDias;
	}
	public String getTipoPlanTarifario() {
		return tipoPlanTarifario;
	}
	public void setTipoPlanTarifario(String tipoPlanTarifario) {
		this.tipoPlanTarifario = tipoPlanTarifario;
	}	
	public PaqueteDTO getPaqueteDefault() {
		return paqueteDefault;
	}
	public void setPaqueteDefault(PaqueteDTO paqueteDefault) {
		this.paqueteDefault = paqueteDefault;
	}

	public String getLimiteConsumo() {
		return limiteConsumo;
	}
	public void setLimiteConsumo(String limiteConsumo) {
		this.limiteConsumo = limiteConsumo;
	}
	public float getImpCargoBasico() {
		return impCargoBasico;
	}
	public void setImpCargoBasico(float impCargoBasico) {
		this.impCargoBasico = impCargoBasico;
	}
	public float getImpFinal() {
		return impFinal;
	}
	public void setImpFinal(float impFinal) {
		this.impFinal = impFinal;
	}
	public String getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(String codCliente) {
		this.codCliente = codCliente;
	}
	public String getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(String numAbonado) {
		this.numAbonado = numAbonado;
	}
	public CategoriaListDTO getCategorias() {
		return categorias;
	}
	public void setCategorias(CategoriaListDTO categorias) {
		this.categorias = categorias;
	}
	public String getCodigoPlanTarifario() {
		return codigoPlanTarifario;
	}
	public void setCodigoPlanTarifario(String codigoPlanTarifario) {
		this.codigoPlanTarifario = codigoPlanTarifario;
	}
	public String getCodigoCargoBasico() {
		return codigoCargoBasico;
	}
	public void setCodigoCargoBasico(String codigoCargoBasico) {
		this.codigoCargoBasico = codigoCargoBasico;
	}
	
	
}
