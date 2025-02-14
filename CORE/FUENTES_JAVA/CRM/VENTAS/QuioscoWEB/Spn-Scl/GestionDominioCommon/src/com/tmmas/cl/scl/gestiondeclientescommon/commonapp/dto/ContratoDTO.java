package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;
import java.util.ArrayList;

import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ProgramaDTO;


public class ContratoDTO implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String codigoTipoContrato;
	private String descripcionTipoContrato;
	private String codigoCliente;
	private String numeroContrato;
	private ArrayList contratos;
	private int indComodato;
	private ArrayList numeroMesesContrato;
	private String nombreUsuario;
	private String indContCel;
	private String indContSeg;
	
	
	/*Datos necesarios para realizar el alta*/
	private String codigoCuenta;
	private int codigoProducto;
	private String numeroAnexo;
	private int numeroMeses;
	private long numeroVenta;
	private int numeroAbonados;
	private String numAbonado;
	
	private ProgramaDTO datosPrograma;
	
	
	
	public ProgramaDTO getDatosPrograma() {
		return datosPrograma;
	}
	public void setDatosPrograma(ProgramaDTO datosPrograma) {
		this.datosPrograma = datosPrograma;
	}
	public String getCodigoCuenta() {
		return codigoCuenta;
	}
	public void setCodigoCuenta(String codigoCuenta) {
		this.codigoCuenta = codigoCuenta;
	}
	public int getNumeroAbonados() {
		return numeroAbonados;
	}
	public void setNumeroAbonados(int numeroAbonados) {
		this.numeroAbonados = numeroAbonados;
	}
	public String getNumeroAnexo() {
		return numeroAnexo;
	}
	public void setNumeroAnexo(String numeroAnexo) {
		this.numeroAnexo = numeroAnexo;
	}
	public int getNumeroMeses() {
		return numeroMeses;
	}
	public void setNumeroMeses(int numeroMeses) {
		this.numeroMeses = numeroMeses;
	}
	public long getNumeroVenta() {
		return numeroVenta;
	}
	public void setNumeroVenta(long numeroVenta) {
		this.numeroVenta = numeroVenta;
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
	
	public String getNumeroContrato() {
		return numeroContrato;
	}
	public void setNumeroContrato(String numeroContrato) {
		this.numeroContrato = numeroContrato;
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
	public int getCodigoProducto() {
		return codigoProducto;
	}
	public void setCodigoProducto(int codigoProducto) {
		this.codigoProducto = codigoProducto;
	}
	public String getIndContCel() {
		return indContCel;
	}
	public void setIndContCel(String indContCel) {
		this.indContCel = indContCel;
	}
	public String getIndContSeg() {
		return indContSeg;
	}
	public void setIndContSeg(String indContSeg) {
		this.indContSeg = indContSeg;
	}
	public String getNombreUsuario() {
		return nombreUsuario;
	}
	public void setNombreUsuario(String nombreUsuario) {
		this.nombreUsuario = nombreUsuario;
	}
	public String getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(String numAbonado) {
		this.numAbonado = numAbonado;
	}
	
}
