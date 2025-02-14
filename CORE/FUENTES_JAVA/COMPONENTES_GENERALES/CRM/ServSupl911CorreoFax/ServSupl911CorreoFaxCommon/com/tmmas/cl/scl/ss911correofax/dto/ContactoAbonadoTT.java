package com.tmmas.cl.scl.ss911correofax.dto;

import java.io.Serializable;

public class ContactoAbonadoTT implements Serializable{
	
	private long numAbonado;
	protected String codServicio;
	private GaContactoAbonadoToDTO contactoAbonadoToDTOs;
	private DireccionDTO direccionDTO;
	public ContactoAbonadoTT() {
		super();
	}
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
	public GaContactoAbonadoToDTO getContactoAbonadoToDTOs() {
		return contactoAbonadoToDTOs;
	}
	public void setContactoAbonadoToDTOs(
			GaContactoAbonadoToDTO contactoAbonadoToDTOs) {
		this.contactoAbonadoToDTOs = contactoAbonadoToDTOs;
	}
	public DireccionDTO getDireccionDTO() {
		return direccionDTO;
	}
	public void setDireccionDTO(DireccionDTO direccionDTO) {
		this.direccionDTO = direccionDTO;
	}
	public String getCodServicio() {
		return codServicio;
	}
	public void setCodServicio(String codServicio) {
		this.codServicio = codServicio;
	}
	
	
}
