package com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Date;

import com.tmmas.cl.framework.util.Formatting;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.AbonadoSecuenciaDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.NumeroFrecuenteDTO;

public class ParamRegistroPlanDTO implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private String sujeto;
	private String codTipModi;
	private long codOOSS;
	private String codOS;
	//private String codOOSSString;//Eliminar cuando se normalize el Codigo
	private String tipOOSS;
	private String codPlanTarifDestino;
	private String combinatoria;
	private String codActAbo;
	private String codActAboAux;
	private String nomUsuaOra;
	private float valorOOSS;
	private String codPlanTarifario;
	private long numOOSS;
	private String nomSecuencia;
	private long numSecuencia;
	private String valorListaActiva;
	private String aplicaTraspaso;
	private String codPlanServNuevo;
	private String fecDesdeLlam;
	private String fecDesdeLlamAux;
	private Timestamp fecDesdeLlamTS;
	private String codTipoMovimiento;
	private int periodoFact;
	private String tipPlanTarifDestino;
	private String codTipPlanDestino;
	private String codEstadoPend;
	private String comentario;
	private String codCatCtaSegNue;
	private String maxIntentos;
	private String estRespCentral;
	private String codEstTrxPend;
	private String aplicaAtlantida;
	private Timestamp fechaActual;
	private int codEstadoPendInt;
	private long codClienteDestino;
	private String codLimiteConsumoDestino;
	private double montoLimiteConsumoDestino;
	private String codCargoBasicoDestino;
	private float impCargoBasicoDestino;
	private long codCuentaDestino;
	private String codSubCuentaDestino;
	private String codTipPlanDest;
	private String moduloEspecial;
	private String[] numAbonados;
	private int numDiaDestino;
	private long codSujeto;
	private String codCausaBajaSel;
	private String codTipoDocumento;
	private String modPago;
	private Date fechaDesde;
	private int codCausaExcepcion;
	private int enCambioPlanFamiliar;
	private String fechaActualFmt;
	private int indPortable;
	private long celularPers;
	private AbonadoDTO[] abonadosSel;
	private AbonadoSecuenciaDTO[] abonadosEmpresa;
	private String indTraspaso;
	private Date fechaProgramacion;
	private NumeroFrecuenteDTO[] arrNumerosFrecuentesDTO;
	private int codCicloClienteDestino;
	private int numFrecFijos;
	private int numFrecMovil;
	private int indFF;
	private int numFrecIng;
	private String codHolding;
	private long codEmpresaDestino;
	private float importePlan;
	private String textoCarta;
	private int cantLineasCodPlanTarifDestino;
	private String paramRenova; // ini-Proyecto p-mix-09003 OCB; 
	private String codCausaCambioPlan;
	private int inmdCiclo;
	private long periodoFactAux;
	private String indEjecucion;
	private Date fechaFutura;
	private int codAccioncal;

	public Date getFechaFutura() {
		return fechaFutura;
	}

	public void setFechaFutura(Date fechaFutura) {
		this.fechaFutura = fechaFutura;
	}

	public String getTextoCarta() {
		return textoCarta;
	}

	public void setTextoCarta(String textoCarta) {
		this.textoCarta = textoCarta;
	}

	public float getImportePlan() {
		return importePlan;
	}

	public void setImportePlan(float importePlan) {
		this.importePlan = importePlan;
	}

	public long getCodEmpresaDestino() {
		return codEmpresaDestino;
	}

	public void setCodEmpresaDestino(long codEmpresaDestino) {
		this.codEmpresaDestino = codEmpresaDestino;
	}

	public String getCodHolding() {
		return codHolding;
	}

	public void setCodHolding(String codHolding) {
		this.codHolding = codHolding;
	}

	public int getNumFrecIng() {
		return numFrecIng;
	}

	public void setNumFrecIng(int numFrecIng) {
		this.numFrecIng = numFrecIng;
	}

	public int getIndFF() {
		return indFF;
	}

	public void setIndFF(int indFF) {
		this.indFF = indFF;
	}

	public int getNumFrecFijos() {
		return numFrecFijos;
	}

	public void setNumFrecFijos(int numFrecFijos) {
		this.numFrecFijos = numFrecFijos;
	}

	public int getNumFrecMovil() {
		return numFrecMovil;
	}

	public void setNumFrecMovil(int numFrecMovil) {
		this.numFrecMovil = numFrecMovil;
	}

	public int getCodCicloClienteDestino() {
		return codCicloClienteDestino;
	}

	public void setCodCicloClienteDestino(int codCicloClienteDestino) {
		this.codCicloClienteDestino = codCicloClienteDestino;
	}

	public long getCelularPers() {
		return celularPers;
	}

	public void setCelularPers(long celularPers) {
		this.celularPers = celularPers;
	}

	public String getFechaActualFmt() {
		if (this.fechaActualFmt==null || this.fechaActualFmt.trim().equals(""))
			return Formatting.dateTime(this.fechaActual, "dd-MM-yyyy");
		else
			return this.fechaActualFmt;
	}

	public void setFechaActualFmt(String fechaActualFmt) {
		this.fechaActualFmt = fechaActualFmt;
	}

	public int getEnCambioPlanFamiliar() {
		return enCambioPlanFamiliar;
	}

	public void setEnCambioPlanFamiliar(int enCambioPlanFamiliar) {
		this.enCambioPlanFamiliar = enCambioPlanFamiliar;
	}

	public Date getFechaDesde() {
		return fechaDesde;
	}

	public void setFechaDesde(Date fechaDesde) {
		this.fechaDesde = fechaDesde;
	}

	public String getCodTipoDocumento() {
		return codTipoDocumento;
	}
	public void setCodTipoDocumento(String codTipoDocumento) {
		this.codTipoDocumento = codTipoDocumento;
	}
	public String getModPago() {
		return modPago;
	}
	public void setModPago(String modPago) {
		this.modPago = modPago;
	}
	public String getCodCausaBajaSel() {
		return codCausaBajaSel;
	}
	public void setCodCausaBajaSel(String codCausaBajaSel) {
		this.codCausaBajaSel = codCausaBajaSel;
	}
	public long getCodSujeto() {
		return codSujeto;
	}
	public void setCodSujeto(long codSujeto) {
		this.codSujeto = codSujeto;
	}
	public int getNumDiaDestino() {
		return numDiaDestino;
	}
	public void setNumDiaDestino(int numDiaDestino) {
		this.numDiaDestino = numDiaDestino;
	}
	public String[] getNumAbonados() {
		return numAbonados;
	}
	public void setNumAbonados(String[] numAbonados) {
		this.numAbonados = numAbonados;
	}
	public String getCodCargoBasicoDestino() {
		return codCargoBasicoDestino;
	}
	public void setCodCargoBasicoDestino(String codCargoBasicoDestino) {
		this.codCargoBasicoDestino = codCargoBasicoDestino;
	}
	public long getCodClienteDestino() {
		return codClienteDestino;
	}
	public void setCodClienteDestino(long codClienteDestino) {
		this.codClienteDestino = codClienteDestino;
	}
	public long getCodCuentaDestino() {
		return codCuentaDestino;
	}
	public void setCodCuentaDestino(long codCuentaDestino) {
		this.codCuentaDestino = codCuentaDestino;
	}
	public String getCodLimiteConsumoDestino() {
		return codLimiteConsumoDestino;
	}
	public void setCodLimiteConsumoDestino(String codLimiteConsumoDestino) {
		this.codLimiteConsumoDestino = codLimiteConsumoDestino;
	}
	public String getCodSubCuentaDestino() {
		return codSubCuentaDestino;
	}
	public void setCodSubCuentaDestino(String codSubCuentaDestino) {
		this.codSubCuentaDestino = codSubCuentaDestino;
	}
	public float getImpCargoBasicoDestino() {
		return impCargoBasicoDestino;
	}
	public void setImpCargoBasicoDestino(float impCargoBasicoDestino) {
		this.impCargoBasicoDestino = impCargoBasicoDestino;
	}
	public String getModuloEspecial() {
		return moduloEspecial;
	}
	public void setModuloEspecial(String moduloEspecial) {
		this.moduloEspecial = moduloEspecial;
	}
	public String getAplicaAtlantida() {
		return aplicaAtlantida;
	}
	public void setAplicaAtlantida(String aplicaAtlantida) {
		this.aplicaAtlantida = aplicaAtlantida;
	}
	public String getCodCatCtaSegNue() {
		return codCatCtaSegNue;
	}
	public void setCodCatCtaSegNue(String codCatCtaSegNue) {
		this.codCatCtaSegNue = codCatCtaSegNue;
	}
	public String getCodEstTrxPend() {
		return codEstTrxPend;
	}
	public void setCodEstTrxPend(String codEstTrxPend) {
		this.codEstTrxPend = codEstTrxPend;
	}
	public String getEstRespCentral() {
		return estRespCentral;
	}
	public void setEstRespCentral(String estRespCentral) {
		this.estRespCentral = estRespCentral;
	}
	public String getMaxIntentos() {
		return maxIntentos;
	}
	public void setMaxIntentos(String maxIntentos) {
		this.maxIntentos = maxIntentos;
	}
	public String getCodEstadoPend() {
		return codEstadoPend;
	}
	public void setCodEstadoPend(String codEstadoPend) {
		this.codEstadoPend = codEstadoPend;
	}
	public String getCodTipoMovimiento() {
		return codTipoMovimiento;
	}
	public void setCodTipoMovimiento(String codTipoMovimiento) {
		this.codTipoMovimiento = codTipoMovimiento;
	}
	public String getCodTipPlanDestino() {
		return codTipPlanDestino;
	}
	public void setCodTipPlanDestino(String codTipPlanDestino) {
		this.codTipPlanDestino = codTipPlanDestino;
	}
	public String getComentario() {
		return comentario;
	}
	public void setComentario(String comentario) {
		this.comentario = comentario;
	}
	public String getFecDesdeLlam() {
		return fecDesdeLlam;
	}
	public void setFecDesdeLlam(String fecDesdeLlam) {
		this.fecDesdeLlam = fecDesdeLlam;
	}

	public int getPeriodoFact() {
		return periodoFact;
	}
	public void setPeriodoFact(int periodoFact) {
		this.periodoFact = periodoFact;
	}
	public String getTipPlanTarifDestino() {
		return tipPlanTarifDestino;
	}
	public void setTipPlanTarifDestino(String tipPlanTarifDestino) {
		this.tipPlanTarifDestino = tipPlanTarifDestino;
	}
	public String getCodPlanServNuevo() {
		return codPlanServNuevo;
	}
	public void setCodPlanServNuevo(String codPlanServNuevo) {
		this.codPlanServNuevo = codPlanServNuevo;
	}
	public String getAplicaTraspaso() {
		return aplicaTraspaso;
	}
	public void setAplicaTraspaso(String aplicaTraspaso) {
		this.aplicaTraspaso = aplicaTraspaso;
	}
	public String getValorListaActiva() {
		return valorListaActiva;
	}
	public void setValorListaActiva(String valorListaActiva) {
		this.valorListaActiva = valorListaActiva;
	}
	public String getCombinatoria() {
		return combinatoria;
	}
	public void setCombinatoria(String combinatoria) {
		this.combinatoria = combinatoria;
	}
	public String getCodPlanTarifDestino() {
		return codPlanTarifDestino;
	}
	public void setCodPlanTarifDestino(String codPlanTarifDestino) {
		this.codPlanTarifDestino = codPlanTarifDestino;
	}
	public long getCodOOSS() {
		return codOOSS;
	}
	public void setCodOOSS(long codOOSS) {
		this.codOOSS = codOOSS;
	}
	public String getCodTipModi() {
		return codTipModi;
	}
	public void setCodTipModi(String codTipModi) {
		this.codTipModi = codTipModi;
	}
	public String getSujeto() {
		return sujeto;
	}
	public void setSujeto(String sujeto) {
		this.sujeto = sujeto;
	}
	public String getTipOOSS() {
		return tipOOSS;
	}
	public void setTipOOSS(String tipOOSS) {
		this.tipOOSS = tipOOSS;
	}
	public String getCodActAbo() {
		return codActAbo;
	}
	public void setCodActAbo(String codActAbo) {
		this.codActAbo = codActAbo;
	}
	public String getCodPlanTarifario() {
		return codPlanTarifario;
	}
	public void setCodPlanTarifario(String codPlanTarifario) {
		this.codPlanTarifario = codPlanTarifario;
	}
	public String getNomUsuaOra() {
		return nomUsuaOra;
	}
	public void setNomUsuaOra(String nomUsuaOra) {
		this.nomUsuaOra = nomUsuaOra;
	}
	public String getNomSecuencia() {
		return nomSecuencia;
	}
	public void setNomSecuencia(String nomSecuencia) {
		this.nomSecuencia = nomSecuencia;
	}
	public long getNumSecuencia() {
		return numSecuencia;
	}
	public void setNumSecuencia(long numSecuencia) {
		this.numSecuencia = numSecuencia;
	}
	public long getNumOOSS() {
		return numOOSS;
	}
	public void setNumOOSS(long numOOSS) {
		this.numOOSS = numOOSS;
	}
	public float getValorOOSS() {
		return valorOOSS;
	}

	public void setValorOOSS(float valorOOSS) {
		this.valorOOSS = valorOOSS;
	}

	public int getCodEstadoPendInt() {
		return codEstadoPendInt;
	}
	public void setCodEstadoPendInt(int codEstadoPendInt) {
		this.codEstadoPendInt = codEstadoPendInt;
	}

	public String getCodOS() {
		return String.valueOf(codOOSS);
	}
	public void setCodOS(String codOS) {
		this.codOS = codOS;
	}
	public String getCodTipPlanDest() {
		return codTipPlanDest;
	}
	public void setCodTipPlanDest(String codTipPlanDest) {
		this.codTipPlanDest = codTipPlanDest;
	}
	public Timestamp getFechaActual() {
		return fechaActual;
	}
	public void setFechaActual(Timestamp fechaActual) {
		this.fechaActual = fechaActual;
	}
	public int getCodCausaExcepcion() {
		return codCausaExcepcion;
	}
	public void setCodCausaExcepcion(int codCausaExcepcion) {
		this.codCausaExcepcion = codCausaExcepcion;
	}
	public String getCodActAboAux() {
		return codActAboAux;
	}
	public void setCodActAboAux(String codActAboAux) {
		this.codActAboAux = codActAboAux;
	}

	public int getIndPortable() {
		return indPortable;
	}

	public void setIndPortable(int indPortable) {
		this.indPortable = indPortable;
	}

	public AbonadoDTO[] getAbonadosSel() {
		return abonadosSel;
	}

	public void setAbonadosSel(AbonadoDTO[] abonadosSel) {
		this.abonadosSel = abonadosSel;
	}

	public String getIndTraspaso() {
		return indTraspaso;
	}

	public void setIndTraspaso(String indTraspaso) {
		this.indTraspaso = indTraspaso;
	}

	public Date getFechaProgramacion() {
		return fechaProgramacion;
	}

	public void setFechaProgramacion(Date fechaProgramacion) {
		this.fechaProgramacion = fechaProgramacion;
	}

	public Timestamp getFecDesdeLlamTS() {
		return fecDesdeLlamTS;
	}

	public void setFecDesdeLlamTS(Timestamp fecDesdeLlamTS) {
		this.fecDesdeLlamTS = fecDesdeLlamTS;
	}

	public NumeroFrecuenteDTO[] getArrNumerosFrecuentesDTO() {
		return arrNumerosFrecuentesDTO;
	}

	public void setArrNumerosFrecuentesDTO(
			NumeroFrecuenteDTO[] arrNumerosFrecuentesDTO) {
		this.arrNumerosFrecuentesDTO = arrNumerosFrecuentesDTO;
	}

	public String getFecDesdeLlamAux() {
		return fecDesdeLlamAux;
	}

	public void setFecDesdeLlamAux(String fecDesdeLlamAux) {
		this.fecDesdeLlamAux = fecDesdeLlamAux;
	}

	public AbonadoSecuenciaDTO[] getAbonadosEmpresa() {
		return abonadosEmpresa;
	}

	public void setAbonadosEmpresa(AbonadoSecuenciaDTO[] abonadosEmpresa) {
		this.abonadosEmpresa = abonadosEmpresa;
	}

	public int getCantLineasCodPlanTarifDestino() {
		return cantLineasCodPlanTarifDestino;
	}

	public void setCantLineasCodPlanTarifDestino(int cantLineasCodPlanTarifDestino) {
		this.cantLineasCodPlanTarifDestino = cantLineasCodPlanTarifDestino;
	}

	public String getParamRenova() {
		return paramRenova;
	}

	public void setParamRenova(String paramRenova) {
		this.paramRenova = paramRenova;
	}

	public String getCodCausaCambioPlan() {
		return codCausaCambioPlan;
	}

	public void setCodCausaCambioPlan(String codCausaCambioPlan) {
		this.codCausaCambioPlan = codCausaCambioPlan;
	}

	public int getInmdCiclo() {
		return inmdCiclo;
	}

	public void setInmdCiclo(int inmdCiclo) {
		this.inmdCiclo = inmdCiclo;
	}

	public double getMontoLimiteConsumoDestino() {
		return montoLimiteConsumoDestino;
	}

	public void setMontoLimiteConsumoDestino(double montoLimiteConsumoDestino) {
		this.montoLimiteConsumoDestino = montoLimiteConsumoDestino;
	}

	public String getIndEjecucion() {
		return indEjecucion;
	}

	public void setIndEjecucion(String indEjecucion) {
		this.indEjecucion = indEjecucion;
	}

	public long getPeriodoFactAux() {
		return periodoFactAux;
	}

	public void setPeriodoFactAux(long periodoFactAux) {
		this.periodoFactAux = periodoFactAux;
	}

	public int getCodAccioncal() {
		return codAccioncal;
	}

	public void setCodAccioncal(int codAccioncal) {
		this.codAccioncal = codAccioncal;
	}


	
}
