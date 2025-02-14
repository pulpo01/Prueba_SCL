/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 17/05/2007	     	Elizabeth Vera        				Versión Inicial
 * 25/06/2007			Cristian Toledo						Parametros adicionales.
 * 28/06/2007			Matias Guajardo 					Parametros adicionales.
 * 07/07/2007			Elizabeth Vera						Parametros adicionales.
 * 26/07/2007           Raúl Lozano                         fec_AceptaVenta
 */
package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;
import java.util.Date;



public class AbonadoDTO implements Serializable {
	private static final long serialVersionUID = 1L;

	private long numCelular;
	private String codPlanTarif;
	private String desPlanTarif;
	private int codCiclo;
	private String codSituacion;
	private String codTipoTerminal;
	private String desTipoTerminal;
	private String limiteConsumo;
	private String desLimiteConsumo;	
	private String numSerie;
	private String simCard;
	private String codTecnologia;
	private String tipoCliente;
	private String desTipoCliente;
	private String codTipoPlanTarif;
	private String desTipoPlanTarif;
	private String codCargoBasico;
	private String desCargoBasico;
	private String impCargoBasico;	
	private String codPlanServ;
	private String codEmpresa;
	private String nroContrato;
	private long codCliente;
	private long numAbonado;
	private String desSituacion;
		
	private long codCuenta;
	private int	codCentral;
	private String codUso;
	private long codVendedor;
	private String CodTipContrato;
	private String CodCausaVenta;
	private String CodModVenta;
	
	private Date fecUltModificacion = new Date();
	private String numImei;
	private String codTipPlan;
	private String desTipPlan;
	private Date fecFinContrato;
	private Date fecAlta;
	private Date fecProrroga;
	private String indEqPrestado;
	private int flgRango;
	private int tipMov;
	
	private Date fecBaja;
	private Date fecBajaCen;
	
	// Cristian Toledo	
	private String codProdPadre;
	private String nombre;
	private CatalogoDTO catalogo;
	private PlanTarifarioDTO planTarifario;
	private PaqueteListDTO	 paqueteList;
	private ProductoOfertadoListDTO prodOfertList;
	
	private Date fecAcepVenta;	
	private long numVenta;
	
	private String codActAbo;
	private String claseServicio;
	private String usuarioOracle;
	
	private String numAnexo;
	private long codUsuario;
	private String codSubCuenta;
	private String numContrato;
	
	private String numMovimientoAlta;
	
	public String getNumContrato() {
		return numContrato;
	}
	public void setNumContrato(String numContrato) {
		this.numContrato = numContrato;
	}
	public String getCodSubCuenta() {
		return codSubCuenta;
	}
	public void setCodSubCuenta(String codSubCuenta) {
		this.codSubCuenta = codSubCuenta;
	}
	public long getCodUsuario() {
		return codUsuario;
	}
	public void setCodUsuario(long codUsuario) {
		this.codUsuario = codUsuario;
	}
	public String getNumAnexo() {
		return numAnexo;
	}
	public void setNumAnexo(String numAnexo) {
		this.numAnexo = numAnexo;
	}
	public String getUsuarioOracle() {
		return usuarioOracle;
	}
	public void setUsuarioOracle(String usuarioOracle) {
		this.usuarioOracle = usuarioOracle;
	}
	public String getClaseServicio() {
		return claseServicio;
	}
	public void setClaseServicio(String claseServicio) {
		this.claseServicio = claseServicio;
	}
	public String getCodActAbo() {
		return codActAbo;
	}
	public void setCodActAbo(String codActAbo) {
		this.codActAbo = codActAbo;
	}
	public CatalogoDTO getCatalogo() {
		return catalogo;
	}
	public void setCatalogo(CatalogoDTO catalogo) {
		this.catalogo = catalogo;
	}
	public long getNumVenta() {
		return numVenta;
	}
	public void setNumVenta(long numVenta) {
		this.numVenta = numVenta;
	}
	public String getCodCargoBasico() {
		return codCargoBasico;
	}
	public void setCodCargoBasico(String codCargoBasico) {
		this.codCargoBasico = codCargoBasico;
	}
	public String getCodCausaVenta() {
		return CodCausaVenta;
	}
	public void setCodCausaVenta(String codCausaVenta) {
		CodCausaVenta = codCausaVenta;
	}
	public int getCodCentral() {
		return codCentral;
	}
	public void setCodCentral(int codCentral) {
		this.codCentral = codCentral;
	}

	public int getCodCiclo() {
		return codCiclo;
	}
	public void setCodCiclo(int codCiclo) {
		this.codCiclo = codCiclo;
	}
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public long getCodCuenta() {
		return codCuenta;
	}
	public void setCodCuenta(long codCuenta) {
		this.codCuenta = codCuenta;
	}

	public String getCodEmpresa() {
		return codEmpresa;
	}
	public void setCodEmpresa(String codEmpresa) {
		this.codEmpresa = codEmpresa;
	}
	public String getCodModVenta() {
		return CodModVenta;
	}
	public void setCodModVenta(String codModVenta) {
		CodModVenta = codModVenta;
	}

	public String getCodPlanServ() {
		return codPlanServ;
	}
	public void setCodPlanServ(String codPlanServ) {
		this.codPlanServ = codPlanServ;
	}
	public String getCodPlanTarif() {
		return codPlanTarif;
	}
	public void setCodPlanTarif(String codPlanTarif) {
		this.codPlanTarif = codPlanTarif;
	}
	public String getCodSituacion() {
		return codSituacion;
	}
	public void setCodSituacion(String codSituacion) {
		this.codSituacion = codSituacion;
	}
	public String getCodTecnologia() {
		return codTecnologia;
	}
	public void setCodTecnologia(String codTecnologia) {
		this.codTecnologia = codTecnologia;
	}
	public String getCodTipContrato() {
		return CodTipContrato;
	}
	public void setCodTipContrato(String codTipContrato) {
		CodTipContrato = codTipContrato;
	}
	public String getCodTipoPlanTarif() {
		return codTipoPlanTarif;
	}
	public void setCodTipoPlanTarif(String codTipoPlanTarif) {
		this.codTipoPlanTarif = codTipoPlanTarif;
	}
	public String getCodTipoTerminal() {
		return codTipoTerminal;
	}
	public void setCodTipoTerminal(String codTipoTerminal) {
		this.codTipoTerminal = codTipoTerminal;
	}
	public String getCodTipPlan() {
		return codTipPlan;
	}
	public void setCodTipPlan(String codTipPlan) {
		this.codTipPlan = codTipPlan;
	}
	public String getCodUso() {
		return codUso;
	}
	public void setCodUso(String codUso) {
		this.codUso = codUso;
	}
	public long getCodVendedor() {
		return codVendedor;
	}
	public void setCodVendedor(long codVendedor) {
		this.codVendedor = codVendedor;
	}
	public String getDesLimiteConsumo() {
		return desLimiteConsumo;
	}
	public void setDesLimiteConsumo(String desLimiteConsumo) {
		this.desLimiteConsumo = desLimiteConsumo;
	}
	public String getDesPlanTarif() {
		return desPlanTarif;
	}
	public void setDesPlanTarif(String desPlanTarif) {
		this.desPlanTarif = desPlanTarif;
	}
	public String getDesSituacion() {
		return desSituacion;
	}
	public void setDesSituacion(String desSituacion) {
		this.desSituacion = desSituacion;
	}
	public String getDesTipoCliente() {
		return desTipoCliente;
	}
	public void setDesTipoCliente(String desTipoCliente) {
		this.desTipoCliente = desTipoCliente;
	}
	public String getDesTipoPlanTarif() {
		return desTipoPlanTarif;
	}
	public void setDesTipoPlanTarif(String desTipoPlanTarif) {
		this.desTipoPlanTarif = desTipoPlanTarif;
	}
	public String getDesTipoTerminal() {
		return desTipoTerminal;
	}
	public void setDesTipoTerminal(String desTipoTerminal) {
		this.desTipoTerminal = desTipoTerminal;
	}
	public String getDesTipPlan() {
		return desTipPlan;
	}
	public void setDesTipPlan(String desTipPlan) {
		this.desTipPlan = desTipPlan;
	}
	public Date getFecUltModificacion() {
		return fecUltModificacion;
	}
	public void setFecUltModificacion(Date fecUltModificacion) {
		this.fecUltModificacion = fecUltModificacion;
	}
	public String getLimiteConsumo() {
		return limiteConsumo;
	}
	public void setLimiteConsumo(String limiteConsumo) {
		this.limiteConsumo = limiteConsumo;
	}
	public String getNroContrato() {
		return nroContrato;
	}
	public void setNroContrato(String nroContrato) {
		this.nroContrato = nroContrato;
	}
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
	public long getNumCelular() {
		return numCelular;
	}
	public void setNumCelular(long numCelular) {
		this.numCelular = numCelular;
	}
	public String getNumImei() {
		return numImei;
	}
	public void setNumImei(String numImei) {
		this.numImei = numImei;
	}
	public String getNumSerie() {
		return numSerie;
	}
	public void setNumSerie(String numSerie) {
		this.numSerie = numSerie;
	}
	public String getSimCard() {
		return simCard;
	}
	public void setSimCard(String simCard) {
		this.simCard = simCard;
	}
	public String getTipoCliente() {
		return tipoCliente;
	}
	public void setTipoCliente(String tipoCliente) {
		this.tipoCliente = tipoCliente;
	}
	public PlanTarifarioDTO getPlanTarifario() {
		return planTarifario;
	}
	public void setPlanTarifario(PlanTarifarioDTO planTarifario) {
		this.planTarifario = planTarifario;
	}
	public PaqueteListDTO getPaqueteList() {
		return paqueteList;
	}
	public void setPaqueteList(PaqueteListDTO paqueteList) {
		this.paqueteList = paqueteList;
	}
	public ProductoOfertadoListDTO getProdOfertList() {
		return prodOfertList;
	}
	public void setProdOfertList(ProductoOfertadoListDTO prodOfertList) {
		this.prodOfertList = prodOfertList;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public String getCodProdPadre() {
		return codProdPadre;
	}
	public void setCodProdPadre(String codProdPadre) {
		this.codProdPadre = codProdPadre;
	}
	public String getDesCargoBasico() {
		return desCargoBasico;
	}
	public void setDesCargoBasico(String desCargoBasico) {
		this.desCargoBasico = desCargoBasico;
	}
	public Date getFecAcepVenta() {
		return fecAcepVenta;
	}
	public void setFecAcepVenta(Date fecAcepVenta) {
		this.fecAcepVenta = fecAcepVenta;
	}
	public String getImpCargoBasico() {
		return impCargoBasico;
	}
	public void setImpCargoBasico(String impCargoBasico) {
		this.impCargoBasico = impCargoBasico;
	}
	public Date getFecAlta() {
		return fecAlta;
	}
	public void setFecAlta(Date fecAlta) {
		this.fecAlta = fecAlta;
	}
	public Date getFecFinContrato() {
		return fecFinContrato;
	}
	public void setFecFinContrato(Date fecFinContrato) {
		this.fecFinContrato = fecFinContrato;
	}
	public Date getFecProrroga() {
		return fecProrroga;
	}
	public void setFecProrroga(Date fecProrroga) {
		this.fecProrroga = fecProrroga;
	}
	public String getIndEqPrestado() {
		return indEqPrestado;
	}
	public void setIndEqPrestado(String indEqPrestado) {
		this.indEqPrestado = indEqPrestado;
	}
	public int getFlgRango() {
		return flgRango;
	}
	public void setFlgRango(int flgRango) {
		this.flgRango = flgRango;
	}
	public int getTipMov() {
		return tipMov;
	}
	public void setTipMov(int tipMov) {
		this.tipMov = tipMov;
	}
	public Date getFecBaja() {
		return fecBaja;
	}
	public void setFecBaja(Date fecBaja) {
		this.fecBaja = fecBaja;
	}
	public Date getFecBajaCen() {
		return fecBajaCen;
	}
	public void setFecBajaCen(Date fecBajaCen) {
		this.fecBajaCen = fecBajaCen;
	}
	public String getNumMovimientoAlta() {
		return numMovimientoAlta;
	}
	public void setNumMovimientoAlta(String numMovimientoAlta) {
		this.numMovimientoAlta = numMovimientoAlta;
	}
	
	public Object[] toStruct_GA_Abonado_QT()
	{
		Object[] obj={String.valueOf(numAbonado),
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null,
						 null};		
		return obj;
	}
	
	
}
