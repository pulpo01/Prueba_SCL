package com.tmmas.scl.framework.commonDoman.dataTransferObject;


import java.io.Serializable;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CargosObtenidosDTO;

public class ClienteOSSesionDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	private long codCliente;
	private long numAbonado;
	private long codOrdenServicio;
	private long numOrdenServicio;
	
	private String usuario;
	private String clave;
	private String forward;
	
	private ClienteDTO cliente;
	private AbonadoDTO[] abonados;
	private ValoresJSPPorDefectoDTO defaultPagina;
	private String resumenOS;
	private String ComentarioOS;
	private CargosObtenidosDTO cargosObtenidos;
	
	private String [] codAbonado;
	private String sinCondicionesComerciales;
	private String codActAbo;
	private String tipoPantallaPrevia;
	private String obtenerCargos;
	private String codActAboCargosUso;
	private String flujoIndividualEmpresa;
	
	//Atributo usado exclusivamente para CPU
	private String codPlanTarifSelec;
	
	//Este atributo se utiliza para mantener sólo a 
	//los abonados a los que por regla de negocio les corresponde
	//pagar cargos
	private String [] codAbonadosAplicarCargos;
	
	private String modalidad;
	
	
	private boolean isExistVendUsuario;
	private String paramRenova;
	
	/***
	 * @author ggaletti
	 * @description se crea a parametro para datos Orden de Servicio de Siniestro 
	 * @return
	 */
	
	protected String tipoContrato;
	
	
	public boolean isExistVendUsuario() {
		return isExistVendUsuario;
	}
	public void setExistVendUsuario(boolean isExistVendUsuario) {
		this.isExistVendUsuario = isExistVendUsuario;
	}
	public String getModalidad() {
		return modalidad;
	}
	public void setModalidad(String modalidad) {
		this.modalidad = modalidad;
	}
	public String getObtenerCargos() {
		return obtenerCargos;
	}
	public void setObtenerCargos(String obtenerCargos) {
		this.obtenerCargos = obtenerCargos;
	}
	public String[] getCodAbonado() {
		return codAbonado;
	}
	public void setCodAbonado(String[] codAbonado) {
		this.codAbonado = codAbonado;
	}
	public String getCodActAbo() {
		return codActAbo;
	}
	public void setCodActAbo(String codActAbo) {
		this.codActAbo = codActAbo;
	}
	public String getSinCondicionesComerciales() {
		return sinCondicionesComerciales;
	}
	public void setSinCondicionesComerciales(String sinCondicionesComerciales) {
		this.sinCondicionesComerciales = sinCondicionesComerciales;
	}
	public String getTipoPantallaPrevia() {
		return tipoPantallaPrevia;
	}
	public void setTipoPantallaPrevia(String tipoPantallaPrevia) {
		this.tipoPantallaPrevia = tipoPantallaPrevia;
	}
	public CargosObtenidosDTO getCargosObtenidos() {
		return cargosObtenidos;
	}
	public void setCargosObtenidos(CargosObtenidosDTO cargosObtenidos) {
		this.cargosObtenidos = cargosObtenidos;
	}
	public AbonadoDTO[] getAbonados() {
		return abonados;
	}
	public void setAbonados(AbonadoDTO[] abonados) {
		this.abonados = abonados;
	}
	public String getClave() {
		return clave;
	}
	public void setClave(String clave) {
		this.clave = clave;
	}
	public ClienteDTO getCliente() {
		return cliente;
	}
	public void setCliente(ClienteDTO cliente) {
		this.cliente = cliente;
	}
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public long getCodOrdenServicio() {
		return codOrdenServicio;
	}
	public void setCodOrdenServicio(long codOrdenServicio) {
		this.codOrdenServicio = codOrdenServicio;
	}
	public ValoresJSPPorDefectoDTO getDefaultPagina() {
		return defaultPagina;
	}
	public void setDefaultPagina(ValoresJSPPorDefectoDTO defaultPagina) {
		this.defaultPagina = defaultPagina;
	}
	public String getForward() {
		return forward;
	}
	public void setForward(String forward) {
		this.forward = forward;
	}
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
	public long getNumOrdenServicio() {
		return numOrdenServicio;
	}
	public void setNumOrdenServicio(long numOrdenServicio) {
		this.numOrdenServicio = numOrdenServicio;
	}
	public String getUsuario() {
		return usuario;
	}
	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}
	public String getResumenOS() {
		return resumenOS;
	}
	public void setResumenOS(String resumenOS) {
		this.resumenOS = resumenOS;
	}
	public String getComentarioOS() {
		return ComentarioOS;
	}
	public void setComentarioOS(String comentarioOS) {
		ComentarioOS = comentarioOS;
	}
	public String[] getCodAbonadosAplicarCargos() {
		return codAbonadosAplicarCargos;
	}
	public void setCodAbonadosAplicarCargos(String[] codAbonadosAplicarCargos) {
		this.codAbonadosAplicarCargos = codAbonadosAplicarCargos;
	}
	public String getCodActAboCargosUso() {
		return codActAboCargosUso;
	}
	public void setCodActAboCargosUso(String codActAboCargosUso) {
		this.codActAboCargosUso = codActAboCargosUso;
	}
	public String getCodPlanTarifSelec() {
		return codPlanTarifSelec;
	}
	public void setCodPlanTarifSelec(String codPlanTarifSelec) {
		this.codPlanTarifSelec = codPlanTarifSelec;
	}
	public String getFlujoIndividualEmpresa() {
		return flujoIndividualEmpresa;
	}
	public void setFlujoIndividualEmpresa(String flujoIndividualEmpresa) {
		this.flujoIndividualEmpresa = flujoIndividualEmpresa;
	}
	public String getTipoContrato() {
		return tipoContrato;
	}
	public void setTipoContrato(String tipoContrato) {
		this.tipoContrato = tipoContrato;
	}
	public String getParamRenova() {
		return paramRenova;
	}
	public void setParamRenova(String paramRenova) {
		this.paramRenova = paramRenova;
	}
	
	
	
	

}
