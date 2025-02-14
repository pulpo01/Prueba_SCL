package com.tmmas.scl.operations.crm.fab.cim.manreq.web.form;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Category;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

public class CambiarPlanForm extends ActionForm {
	
	private String condicH;
	private String radioTipoPlan;
	private String combopre;
	private String combopos;
	private String combohib;
	private String clienteDestPre;
	private String clienteDestPos;
	private String clienteDestHib;
	private String tipoPlanRB;
	private String radioPlanORango;
	private String subCuentaCB;
	private String rangoPlanCB;
	private boolean condicionesCK;
	private String codPlanTarifSelec;
	private String codClienteDestSelec;
	private String aplicaTraspaso;
	private String codPlanServNuevo;
	private long codOSAnt;
	private String codActuacion;
	private String codLimiteConsumo;
	private String desLimiteConsumo;
	private String cargoBasico;
	private String[] listaAbonados;
	private String combinatoria;
	private String causaBajaCB;
	private String cargoBasicoSelec;
	private String causaExcepcionCB;
	private String saldo;
	
	private String opcionPlanORango;
	private boolean checkTodos;
	private String tipoPlanTarifDestino;
	private String optDevEquiRB;
	private boolean sscAmistarCK;
	private String optEstadoRB;
	private String optCargadorRB;
	private String bodegaCB;
	private String codLimiteConsumoSelec;
	private String codCargoBasicoDestino;
	private int numDiasDestino;
	private String fecDesdeLlam;
	private int periodoFact;
	private String montoCargo;
	private String impFinalSelec;
	private String detalleControles;

	private String limConsumoEvalCred;
	private String codActAboAux;
	private long celularPers;
	private String botonSeleccionadoCambioPlan;
	//Ingreso de Numeros Frecuentes CPU santiago
	private String botonNumerosFrecuentesCPU;
	private int numFrecFijos;
	private int numFrecMovil;
	private int indFf;	
	private int numFrecIng;
	private String paginaRegreso;

	private int estadoPagina = 0;
	private String flgPaginaFiltro;
	private String flgAplicaEvaluacion;
	private String flgClienteDestinoEmpresa;
	private int numAbonadosPermitidosPlan;
	private int numAbonadosClienteDestino;
	private String indTraspaso;
	private String cambioDePlanRB;
	private int codCicloClienteDestino;
	private long codEmpresaDestino;
	private long codVendedor;
	
	private String codClienteFiltro;
	private int numMaxClientesLista;
	
	public int getNumMaxClientesLista() {
		return numMaxClientesLista;
	}
	public void setNumMaxClientesLista(int numMaxClientesLista) {
		this.numMaxClientesLista = numMaxClientesLista;
	}
	public String getCodClienteFiltro() {
		return codClienteFiltro;
	}
	public void setCodClienteFiltro(String codClienteFiltro) {
		this.codClienteFiltro = codClienteFiltro;
	}
	public long getCodVendedor() {
		return codVendedor;
	}
	public void setCodVendedor(long codVendedor) {
		this.codVendedor = codVendedor;
	}
	public long getCodEmpresaDestino() {
		return codEmpresaDestino;
	}
	public void setCodEmpresaDestino(long codEmpresaDestino) {
		this.codEmpresaDestino = codEmpresaDestino;
	}
	public int getCodCicloClienteDestino() {
		return codCicloClienteDestino;
	}
	public void setCodCicloClienteDestino(int codCicloClienteDestino) {
		this.codCicloClienteDestino = codCicloClienteDestino;
	}
	public String getIndTraspaso() {
		return indTraspaso;
	}
	public void setIndTraspaso(String indTraspaso) {
		this.indTraspaso = indTraspaso;
	}
	public String getFlgClienteDestinoEmpresa() {
		return flgClienteDestinoEmpresa;
	}
	public void setFlgClienteDestinoEmpresa(String flgClienteDestinoEmpresa) {
		this.flgClienteDestinoEmpresa = flgClienteDestinoEmpresa;
	}
	public String getFlgAplicaEvaluacion() {
		return flgAplicaEvaluacion;
	}
	public void setFlgAplicaEvaluacion(String flgAplicaEvaluacion) {
		this.flgAplicaEvaluacion = flgAplicaEvaluacion;
	}
	public String getFlgPaginaFiltro() {
		return flgPaginaFiltro;
	}
	public void setFlgPaginaFiltro(String flgPaginaFiltro) {
		this.flgPaginaFiltro = flgPaginaFiltro;
	}
	public int getEstadoPagina() {
		return estadoPagina;
	}
	public void setEstadoPagina(int estadoPagina) {
		this.estadoPagina = estadoPagina;
	}
	
	public String getCombinatoria() {
		return combinatoria;
	}
	public void setCombinatoria(String combinatoria) {
		this.combinatoria = combinatoria;
	}
	public String[] getListaAbonados() {
		return listaAbonados;
	}
	public void setListaAbonados(String[] listaAbonados) {
		this.listaAbonados = listaAbonados;
	}
	public String getRadioTipoPlan() {
		return radioTipoPlan;
	}
	public void setRadioTipoPlan(String radioTipoPlan) {
		this.radioTipoPlan = radioTipoPlan;
	}
	public String getCombohib() {
		return combohib;
	}
	public void setCombohib(String combohib) {
		this.combohib = combohib;
	}
	public String getCombopos() {
		return combopos;
	}
	public void setCombopos(String combopos) {
		this.combopos = combopos;
	}
	public String getCombopre() {
		return combopre;
	}
	public void setCombopre(String combopre) {
		this.combopre = combopre;
	}
	public String getCondicH() {
		return condicH;
	}
	public void setCondicH(String condicH) {
		this.condicH = condicH;
	}
	public String getCodActuacion() {
		return codActuacion;
	}
	public void setCodActuacion(String codActuacion) {
		this.codActuacion = codActuacion;
	}
	public long getCodOSAnt() {
		return codOSAnt;
	}
	public void setCodOSAnt(long codOSAnt) {
		this.codOSAnt = codOSAnt;
	}
	public String getCodPlanTarifSelec() {
		return codPlanTarifSelec;
	}
	public void setCodPlanTarifSelec(String codPlanTarifSelec) {
		this.codPlanTarifSelec = codPlanTarifSelec;
	}
	public String getAplicaTraspaso() {
		return aplicaTraspaso;
	}
	public void setAplicaTraspaso(String aplicaTraspaso) {
		this.aplicaTraspaso = aplicaTraspaso;
	}
	public String getCodPlanServNuevo() {
		return codPlanServNuevo;
	}
	public void setCodPlanServNuevo(String codPlanServNuevo) {
		this.codPlanServNuevo = codPlanServNuevo;
	}
	public String getTipoPlanRB() {
		return tipoPlanRB;
	}
	public void setTipoPlanRB(String tipoPlanRB) {
		this.tipoPlanRB = tipoPlanRB;
	}
	public String getSubCuentaCB() {
		return subCuentaCB;
	}
	public void setSubCuentaCB(String subCuentaCB) {
		this.subCuentaCB = subCuentaCB;
	}
	public String getClienteDestHib() {
		return clienteDestHib;
	}
	public void setClienteDestHib(String clienteDestHib) {
		this.clienteDestHib = clienteDestHib;
	}
	public String getClienteDestPos() {
		return clienteDestPos;
	}
	public void setClienteDestPos(String clienteDestPos) {
		this.clienteDestPos = clienteDestPos;
	}
	public String getClienteDestPre() {
		return clienteDestPre;
	}
	public void setClienteDestPre(String clienteDestPre) {
		this.clienteDestPre = clienteDestPre;
	}
	public String getRangoPlanCB() {
		return rangoPlanCB;
	}
	public void setRangoPlanCB(String rangoPlanCB) {
		this.rangoPlanCB = rangoPlanCB;
	}
	public boolean isCondicionesCK() {
		return condicionesCK;
	}
	public void setCondicionesCK(boolean condicionesCK) {
		this.condicionesCK = condicionesCK;
	}
	
	public void reset(ActionMapping mapping, HttpServletRequest request){
		condicionesCK=false;
		checkTodos=false;
		sscAmistarCK=false;
		
	}
	public String getCargoBasico() {
		return cargoBasico;
	}
	public void setCargoBasico(String cargoBasico) {
		this.cargoBasico = cargoBasico;
	}
	public String getCodLimiteConsumo() {
		return codLimiteConsumo;
	}
	public void setCodLimiteConsumo(String codLimiteConsumo) {
		this.codLimiteConsumo = codLimiteConsumo;
	}
	public String getDesLimiteConsumo() {
		return desLimiteConsumo;
	}
	public void setDesLimiteConsumo(String desLimiteConsumo) {
		this.desLimiteConsumo = desLimiteConsumo;
	}
	public String getCodClienteDestSelec() {
		return codClienteDestSelec;
	}
	public void setCodClienteDestSelec(String codClienteDestSelec) {
		this.codClienteDestSelec = codClienteDestSelec;
	}
	public String getCausaBajaCB() {
		return causaBajaCB;
	}
	public void setCausaBajaCB(String causaBajaCB) {
		this.causaBajaCB = causaBajaCB;
	}
	public String getCargoBasicoSelec() {
		return cargoBasicoSelec;
	}
	public void setCargoBasicoSelec(String cargoBasicoSelec) {
		this.cargoBasicoSelec = cargoBasicoSelec;
	}
	
	public String getRadioPlanORango() {
		return radioPlanORango;
	}
	public void setRadioPlanORango(String radioPlanORango) {
		this.radioPlanORango = radioPlanORango;
	}
	public String getOpcionPlanORango() {
		return opcionPlanORango;
	}
	public void setOpcionPlanORango(String opcionPlanORango) {
		this.opcionPlanORango = opcionPlanORango;
	}
	public boolean isCheckTodos() {
		return checkTodos;
	}
	public void setCheckTodos(boolean checkTodos) {
		this.checkTodos = checkTodos;
	}
	public String getTipoPlanTarifDestino() {
		return tipoPlanTarifDestino;
	}
	public void setTipoPlanTarifDestino(String tipoPlanTarifDestino) {
		this.tipoPlanTarifDestino = tipoPlanTarifDestino;
	}
	public String getOptDevEquiRB() {
		return optDevEquiRB;
	}
	public void setOptDevEquiRB(String optDevEquiRB) {
		this.optDevEquiRB = optDevEquiRB;
	}
	public boolean isSscAmistarCK() {
		return sscAmistarCK;
	}
	public void setSscAmistarCK(boolean sscAmistarCK) {
		this.sscAmistarCK = sscAmistarCK;
	}
	public String getOptEstadoRB() {
		return optEstadoRB;
	}
	public void setOptEstadoRB(String optEstadoRB) {
		this.optEstadoRB = optEstadoRB;
	}
	public String getOptCargadorRB() {
		return optCargadorRB;
	}
	public void setOptCargadorRB(String optCargadorRB) {
		this.optCargadorRB = optCargadorRB;
	}
	public String getBodegaCB() {
		return bodegaCB;
	}
	public void setBodegaCB(String bodegaCB) {
		this.bodegaCB = bodegaCB;
	}
	public String getCodLimiteConsumoSelec() {
		return codLimiteConsumoSelec;
	}
	public void setCodLimiteConsumoSelec(String codLimiteConsumoSelec) {
		this.codLimiteConsumoSelec = codLimiteConsumoSelec;
	}
	public String getCodCargoBasicoDestino() {
		return codCargoBasicoDestino;
	}
	public void setCodCargoBasicoDestino(String codCargoBasicoDestino) {
		this.codCargoBasicoDestino = codCargoBasicoDestino;
	}
	public int getNumDiasDestino() {
		return numDiasDestino;
	}
	public void setNumDiasDestino(int numDiasDestino) {
		this.numDiasDestino = numDiasDestino;
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
	public String getMontoCargo() {
		return montoCargo;
	}
	public void setMontoCargo(String montoCargo) {
		this.montoCargo = montoCargo;
	}
	public String getImpFinalSelec() {
		return impFinalSelec;
	}
	public void setImpFinalSelec(String impFinalSelec) {
		this.impFinalSelec = impFinalSelec;
	}
	public String getDetalleControles() {
		return detalleControles;
	}
	public void setDetalleControles(String detalleControles) {
		this.detalleControles = detalleControles;
	}
	public String getLimConsumoEvalCred() {
		return limConsumoEvalCred;
	}
	public void setLimConsumoEvalCred(String limConsumoEvalCred) {
		this.limConsumoEvalCred = limConsumoEvalCred;
	}
	public String getCausaExcepcionCB() {
		return causaExcepcionCB;
	}
	public void setCausaExcepcionCB(String causaExcepcionCB) {
		this.causaExcepcionCB = causaExcepcionCB;
	}
	public String getSaldo() {
		return saldo;
	}
	public void setSaldo(String saldo) {
		this.saldo = saldo;
	}
	public String getCodActAboAux() {
		return codActAboAux;
	}
	public void setCodActAboAux(String codActAboAux) {
		this.codActAboAux = codActAboAux;
	}
		public String getBotonSeleccionadoCambioPlan() {
		return botonSeleccionadoCambioPlan;
	}
	public void setBotonSeleccionadoCambioPlan(String botonSeleccionadoCambioPlan) {
		this.botonSeleccionadoCambioPlan = botonSeleccionadoCambioPlan;
	}
	public long getCelularPers() {
		return celularPers;
	}
	public void setCelularPers(long celularPers) {
		this.celularPers = celularPers;
	}
	public int getNumAbonadosPermitidosPlan() {
		return numAbonadosPermitidosPlan;
	}
	public void setNumAbonadosPermitidosPlan(int numAbonadosPermitidosPlan) {
		this.numAbonadosPermitidosPlan = numAbonadosPermitidosPlan;
	}
	public int getNumAbonadosClienteDestino() {
		return numAbonadosClienteDestino;
	}
	public void setNumAbonadosClienteDestino(int numAbonadosClienteDestino) {
		this.numAbonadosClienteDestino = numAbonadosClienteDestino;
	}
	public String getCambioDePlanRB() {
		return cambioDePlanRB;
	}
	public void setCambioDePlanRB(String cambioDePlanRB) {
		this.cambioDePlanRB = cambioDePlanRB;
	}
		
	/**
	 * @return the botonNumerosFrecuentesCPU
	 */
	public String getBotonNumerosFrecuentesCPU() {
		return botonNumerosFrecuentesCPU;
	}
	/**
	 * @param botonNumerosFrecuentesCPU the botonNumerosFrecuentesCPU to set
	 */
	public void setBotonNumerosFrecuentesCPU(String botonNumerosFrecuentesCPU) {
		this.botonNumerosFrecuentesCPU = botonNumerosFrecuentesCPU;
	}
	/**
	 * @return the indFf
	 */
	public int getIndFf() {
		return indFf;
	}
	/**
	 * @param indFf the indFf to set
	 */
	public void setIndFf(int indFf) {
		this.indFf = indFf;
	}

	public int getNumFrecMovil() {
		return numFrecMovil;
	}
	public void setNumFrecMovil(int numFrecMovil) {
		this.numFrecMovil = numFrecMovil;
	}

	public int getNumFrecIng() {
		return numFrecIng;
	}
	public void setNumFrecIng(int numFrecIng) {
		this.numFrecIng = numFrecIng;
	}
	public int getNumFrecFijos() {
		return numFrecFijos;
	}
	public void setNumFrecFijos(int numFrecFijos) {
		this.numFrecFijos = numFrecFijos;
	}
	public String getPaginaRegreso() {
		return paginaRegreso;
	}
	public void setPaginaRegreso(String paginaRegreso) {
		this.paginaRegreso = paginaRegreso;
	}
	
}
