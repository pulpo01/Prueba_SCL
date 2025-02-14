package com.tmmas.cl.scl.spnsclwscommon.commonapp.dto.in;

import java.io.Serializable;



public class WsClienteInDTO implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private WsActivacionInDTO  Activaciones; 
/*--------------------------------------------*/	
	private WsResponsableInDTO Responsable;
    private WsApoderadoInDTO Apoderado;	
    private WsBancoInDTO     banco;
/*--------------------------------------------*/
	private  long   CodigoCliente;	
	
	private  String NombreCliente;
	private  String NombreApeclien1;
	private  String NombreApeclien2;	

	private  long   CodigoCiclo;	
	private  String NombreEmail;
	private  String NomUsuarioOra;
	private  String PagoAtumaticoManual;
	private  String codSistemaPago; //Parametro 9 Datos Bancarios
	 private String   CodigoTipoIdent;  
	 private String   NumeroIdent; 
	
	
	private WsDireccionInDTO[] direcciones;
	
	
	public String getNomUsuarioOra() {
		return NomUsuarioOra;
	}
	public void setNomUsuarioOra(String nomUsuarioOra) {
		NomUsuarioOra = nomUsuarioOra;
	}
	public long getCodigoCiclo() {
		return CodigoCiclo;
	}
	public void setCodigoCiclo(long codigoCiclo) {
		CodigoCiclo = codigoCiclo;
	}
	public long getCodigoCliente() {
		return CodigoCliente;
	}
	public void setCodigoCliente(long codigoCliente) {
		CodigoCliente = codigoCliente;
	}
	public String getNombreApeclien1() {
		return NombreApeclien1;
	}
	public void setNombreApeclien1(String nombreApeclien1) {
		NombreApeclien1 = nombreApeclien1;
	}
	public String getNombreApeclien2() {
		return NombreApeclien2;
	}
	public void setNombreApeclien2(String nombreApeclien2) {
		NombreApeclien2 = nombreApeclien2;
	}
	public String getNombreCliente() {
		return NombreCliente;
	}
	public void setNombreCliente(String nombreCliente) {
		NombreCliente = nombreCliente;
	}
	public String getNombreEmail() {
		return NombreEmail;
	}
	public void setNombreEmail(String nombreEmail) {
		NombreEmail = nombreEmail;
	}
	public WsDireccionInDTO[] getDirecciones() {
		return direcciones;
	}
	public void setDirecciones(WsDireccionInDTO[] direcciones) {
		this.direcciones = direcciones;
	}
	public WsApoderadoInDTO getApoderado() {
		return Apoderado;
	}
	public void setApoderado(WsApoderadoInDTO apoderado) {
		Apoderado = apoderado;
	}
	public WsBancoInDTO getBanco() {
		return banco;
	}
	public void setBanco(WsBancoInDTO banco) {
		this.banco = banco;
	}
	public WsResponsableInDTO getResponsable() {
		return Responsable;
	}
	public void setResponsable(WsResponsableInDTO responsable) {
		Responsable = responsable;
	}
	public WsActivacionInDTO getActivaciones() {
		return Activaciones;
	}
	public void setActivaciones(WsActivacionInDTO activaciones) {
		Activaciones = activaciones;
	}
	public String getPagoAtumaticoManual() {
		return PagoAtumaticoManual;
	}
	public void setPagoAtumaticoManual(String pagoAtumaticoManual) {
		PagoAtumaticoManual = pagoAtumaticoManual;
	}
	public String getCodSistemaPago() {
		return codSistemaPago;
	}
	public void setCodSistemaPago(String codSistemaPago) {
		this.codSistemaPago = codSistemaPago;
	}
	public String getCodigoTipoIdent() {
		return CodigoTipoIdent;
	}
	public void setCodigoTipoIdent(String codigoTipoIdent) {
		CodigoTipoIdent = codigoTipoIdent;
	}
	public String getNumeroIdent() {
		return NumeroIdent;
	}
	public void setNumeroIdent(String numeroIdent) {
		NumeroIdent = numeroIdent;
	}
	
}
