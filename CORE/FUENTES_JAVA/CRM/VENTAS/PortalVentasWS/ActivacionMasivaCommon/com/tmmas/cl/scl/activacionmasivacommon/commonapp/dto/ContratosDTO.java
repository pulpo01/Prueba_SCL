package com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto;

import java.io.Serializable;
import java.util.ArrayList;

public class ContratosDTO implements Serializable{
	/**
	 * 
	 */
	
	private static final long serialVersionUID = 1L;
	private String codigoTipoContrato;
	private String codigoCliente;
	private int indicadorContratoNuevo; //0-Contrato Nuevo 1-Contrato Existente
	private String numeroContrato;
	private ArrayList contratos;
	
	private String descripcionTipoContrato;
	private int indComodato;
	private ArrayList numeroMesesContrato;
	private int numeroMesesSeleccionado;
	
	public int getNumeroMesesSeleccionado() {
		return numeroMesesSeleccionado;
	}
	public void setNumeroMesesSeleccionado(int numeroMesesSeleccionado) {
		this.numeroMesesSeleccionado = numeroMesesSeleccionado;
	}
	public String getDescripcionTipoContrato() {
		return descripcionTipoContrato;
	}
	public void setDescripcionTipoContrato(String descripcionTipoContrato) {
		this.descripcionTipoContrato = descripcionTipoContrato;
	}
	public int getIndComodato() {
		return indComodato;
	}
	public void setIndComodato(int indComodato) {
		this.indComodato = indComodato;
	}
	public ArrayList getNumeroMesesContrato() {
		return numeroMesesContrato;
	}
	public void setNumeroMesesContrato(ArrayList numeroMesesContrato) {
		this.numeroMesesContrato = numeroMesesContrato;
	}
	public String getCodigoCliente() {
		return codigoCliente;
	}
	public void setCodigoCliente(String codigoCliente) {
		this.codigoCliente = codigoCliente;
	}
	public String getCodigoTipoContrato() {
		return codigoTipoContrato;
	}
	public void setCodigoTipoContrato(String codigoTipoContrato) {
		this.codigoTipoContrato = codigoTipoContrato;
	}
	public ArrayList getContratos() {
		return contratos;
	}
	public void setContratos(ArrayList contratos) {
		this.contratos = contratos;
	}
	public int getIndicadorContratoNuevo() {
		return indicadorContratoNuevo;
	}
	public void setIndicadorContratoNuevo(int indicadorContratoNuevo) {
		this.indicadorContratoNuevo = indicadorContratoNuevo;
	}
	public String getNumeroContrato() {
		return numeroContrato;
	}
	public void setNumeroContrato(String numeroContrato) {
		this.numeroContrato = numeroContrato;
	}
}
