package com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject;

import java.io.Serializable;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.UsuarioDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.EstadoProcesoOOSSDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ListaFrecuentesDTO;

public class RegistroPlanDTO implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private ClienteDTO cliente;
	private AbonadoDTO abonado;
	private ListaFrecuentesDTO listaFrecuentes;
	private ParamRegistroPlanDTO paramRegistroPlan;
	private UsuarioDTO usuario;
	private OSAbonadoDTO[] osAbonados;
	
	
	public OSAbonadoDTO[] getOsAbonados() {
		return osAbonados;
	}
	public void setOsAbonados(OSAbonadoDTO[] osAbonados) {
		this.osAbonados = osAbonados;
	}
	public ParamRegistroPlanDTO getParamRegistroPlan() {
		return paramRegistroPlan;
	}
	public void setParamRegistroPlan(ParamRegistroPlanDTO paramRegistroPlan) {
		this.paramRegistroPlan = paramRegistroPlan;
	}
	public AbonadoDTO getAbonado() {
		return abonado;
	}
	public void setAbonado(AbonadoDTO abonado) {
		this.abonado = abonado;
	}
	public ClienteDTO getCliente() {
		return cliente;
	}
	public void setCliente(ClienteDTO cliente) {
		this.cliente = cliente;
	}
	public ListaFrecuentesDTO getListaFrecuentes() {
		return listaFrecuentes;
	}
	public void setListaFrecuentes(ListaFrecuentesDTO listaFrecuentes) {
		this.listaFrecuentes = listaFrecuentes;
	}
	public UsuarioDTO getUsuario() {
		return usuario;
	}
	public void setUsuario(UsuarioDTO usuario) {
		this.usuario = usuario;
	}
	
}
