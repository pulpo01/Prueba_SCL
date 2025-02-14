/**
 * 
 */
package com.tmmas.scl.wsventaenlace.transport.vo;

import java.io.Serializable;


public class PlanTarifarioVO implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String desCargoBasico;
	private long valorCargoBasico;
	private String codCategoria;		
	
	private long codProducto;
	private String codPlanTarif;
	private String desPlanTarif;
	private String tipTerminal; 
	private String codLimconsumo;
	private String codCargoBasico;
	private long tipPlanconsumo; 
	private String tipPlantarif; 
	private long numMinutosff; 
	private long impMinutoff; 
	private String tipUnidades;
	private long numUnidades; 
	private long indArrastre; 
	private long numDias; 
	private long numAbonados; 
	private String fecDesde; 
	private String fecHasta; 
	private long indFamiliar; 
	private String nomUsuario;
	private String fecUltimamod; 
	private String tipUnitas; 
	private long indTarifadifer; 
	private String claPlanTarif;
	private long indProporcs; 
	private long indCargoHabil;
	private long numDiasExpira; 
	private String codPlanComverse; 
	private String indFrancons; 
	private String codServicio; 
	private String codTiplan; 
	private long indCobraSend; 
	private String indBolsadcto;
	private String codTecnologia;
	private String codPlanServ;
	private long numeroFrecuentesFijos;
	private long numeroFrecuentesMoviles;
	private long indFF;



	public long getIndFF() {
		return indFF;
	}



	public void setIndFF(long indFF) {
		this.indFF = indFF;
	}



	public long getNumeroFrecuentesFijos() {
		return numeroFrecuentesFijos;
	}



	public void setNumeroFrecuentesFijos(long numeroFrecuentesFijos) {
		this.numeroFrecuentesFijos = numeroFrecuentesFijos;
	}



	public long getNumeroFrecuentesMoviles() {
		return numeroFrecuentesMoviles;
	}



	public void setNumeroFrecuentesMoviles(long numeroFrecuentesMoviles) {
		this.numeroFrecuentesMoviles = numeroFrecuentesMoviles;
	}



	public String getCodTecnologia() {
		return codTecnologia;
	}



	public void setCodTecnologia(String codTecnologia) {
		this.codTecnologia = codTecnologia;
	}



	/**
	 * 
	 */
	public PlanTarifarioVO() {

	}



	/**
	 * @return long the codProducto 
	 */
	public long getCodProducto() {
		return codProducto;
	}



	/**
	 * @param codProducto long the codProducto to set
	 */
	public void setCodProducto(long codProducto) {
		this.codProducto = codProducto;
	}



	/**
	 * @return String the claPlanTarif 
	 */
	public String getClaPlanTarif() {
		return claPlanTarif;
	}

	/**
	 * @param claPlanTarif String the claPlanTarif to set
	 */
	public void setClaPlanTarif(String claPlanTarif) {
		this.claPlanTarif = claPlanTarif;
	}

	/**
	 * @return String the codCargoBasico 
	 */
	public String getCodCargoBasico() {
		return codCargoBasico;
	}

	/**
	 * @param codCargoBasico String the codCargoBasico to set
	 */
	public void setCodCargoBasico(String codCargoBasico) {
		this.codCargoBasico = codCargoBasico;
	}

	/**
	 * @return String the codPlanTarif 
	 */
	public String getCodPlanTarif() {
		return codPlanTarif;
	}

	/**
	 * @param codPlanTarif String the codPlanTarif to set
	 */
	public void setCodPlanTarif(String codPlanTarif) {
		this.codPlanTarif = codPlanTarif;
	}

	/**
	 * @return String the desCargoBasico 
	 */
	public String getDesCargoBasico() {
		return desCargoBasico;
	}

	/**
	 * @param desCargoBasico String the desCargoBasico to set
	 */
	public void setDesCargoBasico(String desCargoBasico) {
		this.desCargoBasico = desCargoBasico;
	}

	/**
	 * @return String the desPlanTarif 
	 */
	public String getDesPlanTarif() {
		return desPlanTarif;
	}

	/**
	 * @param desPlanTarif String the desPlanTarif to set
	 */
	public void setDesPlanTarif(String desPlanTarif) {
		this.desPlanTarif = desPlanTarif;
	}

	/**
	 * @return long the valorCargoBasico 
	 */
	public long getValorCargoBasico() {
		return valorCargoBasico;
	}

	/**
	 * @param valorCargoBasico long the valorCargoBasico to set
	 */
	public void setValorCargoBasico(long valorCargoBasico) {
		this.valorCargoBasico = valorCargoBasico;
	}

	/**
	 * @return String the codCategoria 
	 */
	public String getCodCategoria() {
		return codCategoria;
	}

	/**
	 * @param codCategoria String the codCategoria to set
	 */
	public void setCodCategoria(String codCategoria) {
		this.codCategoria = codCategoria;
	}



	public String getCodLimconsumo() {
		return codLimconsumo;
	}



	public void setCodLimconsumo(String codLimconsumo) {
		this.codLimconsumo = codLimconsumo;
	}



	public String getCodPlanComverse() {
		return codPlanComverse;
	}



	public void setCodPlanComverse(String codPlanComverse) {
		this.codPlanComverse = codPlanComverse;
	}



	public String getCodServicio() {
		return codServicio;
	}



	public void setCodServicio(String codServicio) {
		this.codServicio = codServicio;
	}



	public String getCodTiplan() {
		return codTiplan;
	}



	public void setCodTiplan(String codTiplan) {
		this.codTiplan = codTiplan;
	}



	public String getFecDesde() {
		return fecDesde;
	}



	public void setFecDesde(String fecDesde) {
		this.fecDesde = fecDesde;
	}



	public String getFecHasta() {
		return fecHasta;
	}



	public void setFecHasta(String fecHasta) {
		this.fecHasta = fecHasta;
	}



	public String getFecUltimamod() {
		return fecUltimamod;
	}



	public void setFecUltimamod(String fecUltimamod) {
		this.fecUltimamod = fecUltimamod;
	}



	public long getImpMinutoff() {
		return impMinutoff;
	}



	public void setImpMinutoff(long impMinutoff) {
		this.impMinutoff = impMinutoff;
	}



	public long getIndArrastre() {
		return indArrastre;
	}



	public void setIndArrastre(long indArrastre) {
		this.indArrastre = indArrastre;
	}



	public String getIndBolsadcto() {
		return indBolsadcto;
	}



	public void setIndBolsadcto(String indBolsadcto) {
		this.indBolsadcto = indBolsadcto;
	}



	public long getIndCargoHabil() {
		return indCargoHabil;
	}



	public void setIndCargoHabil(long indCargoHabil) {
		this.indCargoHabil = indCargoHabil;
	}



	public long getIndCobraSend() {
		return indCobraSend;
	}



	public void setIndCobraSend(long indCobraSend) {
		this.indCobraSend = indCobraSend;
	}



	public long getIndFamiliar() {
		return indFamiliar;
	}



	public void setIndFamiliar(long indFamiliar) {
		this.indFamiliar = indFamiliar;
	}



	public String getIndFrancons() {
		return indFrancons;
	}



	public void setIndFrancons(String indFrancons) {
		this.indFrancons = indFrancons;
	}



	public long getIndProporcs() {
		return indProporcs;
	}



	public void setIndProporcs(long indProporcs) {
		this.indProporcs = indProporcs;
	}



	public long getIndTarifadifer() {
		return indTarifadifer;
	}



	public void setIndTarifadifer(long indTarifadifer) {
		this.indTarifadifer = indTarifadifer;
	}



	public String getNomUsuario() {
		return nomUsuario;
	}



	public void setNomUsuario(String nomUsuario) {
		this.nomUsuario = nomUsuario;
	}



	public long getNumAbonados() {
		return numAbonados;
	}



	public void setNumAbonados(long numAbonados) {
		this.numAbonados = numAbonados;
	}



	public long getNumDias() {
		return numDias;
	}



	public void setNumDias(long numDias) {
		this.numDias = numDias;
	}



	public long getNumDiasExpira() {
		return numDiasExpira;
	}



	public void setNumDiasExpira(long numDiasExpira) {
		this.numDiasExpira = numDiasExpira;
	}



	public long getNumMinutosff() {
		return numMinutosff;
	}



	public void setNumMinutosff(long numMinutosff) {
		this.numMinutosff = numMinutosff;
	}



	public long getNumUnidades() {
		return numUnidades;
	}



	public void setNumUnidades(long numUnidades) {
		this.numUnidades = numUnidades;
	}



	public long getTipPlanconsumo() {
		return tipPlanconsumo;
	}



	public void setTipPlanconsumo(long tipPlanconsumo) {
		this.tipPlanconsumo = tipPlanconsumo;
	}



	public String getTipPlantarif() {
		return tipPlantarif;
	}



	public void setTipPlantarif(String tipPlantarif) {
		this.tipPlantarif = tipPlantarif;
	}



	public String getTipTerminal() {
		return tipTerminal;
	}



	public void setTipTerminal(String tipTerminal) {
		this.tipTerminal = tipTerminal;
	}



	public String getTipUnidades() {
		return tipUnidades;
	}



	public void setTipUnidades(String tipUnidades) {
		this.tipUnidades = tipUnidades;
	}



	public String getTipUnitas() {
		return tipUnitas;
	}



	public void setTipUnitas(String tipUnitas) {
		this.tipUnitas = tipUnitas;
	}



	public String getCodPlanServ() {
		return codPlanServ;
	}



	public void setCodPlanServ(String codPlanServ) {
		this.codPlanServ = codPlanServ;
	}
	

}
