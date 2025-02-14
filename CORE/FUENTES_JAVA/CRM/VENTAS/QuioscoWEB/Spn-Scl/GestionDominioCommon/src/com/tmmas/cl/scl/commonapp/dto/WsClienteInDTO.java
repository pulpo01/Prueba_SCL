package com.tmmas.cl.scl.commonapp.dto;

import java.io.Serializable;
import java.util.Date;



public class WsClienteInDTO implements Serializable{

	private static final long serialVersionUID = 1L;
	 
/*--------------------------------------------*/	
	private WsResponsableInDTO Responsable;
    private WsApoderadoInDTO Apoderado;	
    private WsBancoInDTO     banco;
/*--------------------------------------------*/	
	
	private  String NombreCliente;
	private  String NombreApeclien1;
	private  String NombreApeclien2;	

	private  long   CodigoCiclo;	
	private  String NombreEmail;
	private  String PagoAtumaticoManual;
	private  String codSistemaPago; //Parametro 9 Datos Bancarios
	private String CodigoTipoIdent;  
	private String NumeroIdent;
	private String TelefonoContac1;
	private String TelefonoContac2;
	private String   FechaNacimiento;
	private String IndicadorEstadoCivil;
	private String IndicadorSexo;	
	private String codDireccionFacturacion;
	private String codDireccionPersonal;
	private String codDireccionCorrespondencia;	
    private String codigoPlanTarifario;
    private String codigoOficina; 
    private String CodigoUso;  // 2-3-10
    private String CodigoPais;
    
    private String NumeroFax;
    private String NumeroIntGrupoFam;
    private String CodigoTipIdent2;
    private String NumIdent2;
    private String CodigoCategImpos;
    
    private String codigoCategoria;
    private String codCrediticia; //CSR-11002
    
	
	public String getCodigoPais() {
		return CodigoPais;
	}
	public void setCodigoPais(String codigoPais) {
		CodigoPais = codigoPais;
	}
	public String getCodDireccionCorrespondencia() {
		return codDireccionCorrespondencia;
	}
	public void setCodDireccionCorrespondencia(String codDireccionCorrespondencia) {
		this.codDireccionCorrespondencia = codDireccionCorrespondencia;
	}
	public String getCodDireccionFacturacion() {
		return codDireccionFacturacion;
	}
	public void setCodDireccionFacturacion(String codDireccionFacturacion) {
		this.codDireccionFacturacion = codDireccionFacturacion;
	}
	public String getCodDireccionPersonal() {
		return codDireccionPersonal;
	}
	public void setCodDireccionPersonal(String codDireccionPersonal) {
		this.codDireccionPersonal = codDireccionPersonal;
	}
	public String getCodigoOficina() {
		return codigoOficina;
	}
	public void setCodigoOficina(String codigoOficina) {
		this.codigoOficina = codigoOficina;
	}
	public String getCodigoPlanTarifario() {
		return codigoPlanTarifario;
	}
	public void setCodigoPlanTarifario(String codigoPlanTarifario) {
		this.codigoPlanTarifario = codigoPlanTarifario;
	}
	public String getFechaNacimiento() {
		return FechaNacimiento;
	}
	public void setFechaNacimiento(String fechaNacimiento) {
		FechaNacimiento = fechaNacimiento;
	}
	public String getIndicadorEstadoCivil() {
		return IndicadorEstadoCivil;
	}
	public void setIndicadorEstadoCivil(String indicadorEstadoCivil) {
		IndicadorEstadoCivil = indicadorEstadoCivil;
	}
	public String getIndicadorSexo() {
		return IndicadorSexo;
	}
	public void setIndicadorSexo(String indicadorSexo) {
		IndicadorSexo = indicadorSexo;
	}
	public String getTelefonoContac1() {
		return TelefonoContac1;
	}
	public void setTelefonoContac1(String telefonoContac1) {
		TelefonoContac1 = telefonoContac1;
	}
	public String getTelefonoContac2() {
		return TelefonoContac2;
	}
	public void setTelefonoContac2(String telefonoContac2) {
		TelefonoContac2 = telefonoContac2;
	}
	public long getCodigoCiclo() {
		return CodigoCiclo;
	}
	public void setCodigoCiclo(long codigoCiclo) {
		CodigoCiclo = codigoCiclo;
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
	public String getCodigoUso() {
		return CodigoUso;
	}
	public void setCodigoUso(String codigoUso) {
		CodigoUso = codigoUso;
	}
	public String getCodigoCategImpos() {
		return CodigoCategImpos;
	}
	public void setCodigoCategImpos(String codigoCategImpos) {
		CodigoCategImpos = codigoCategImpos;
	}
	public String getCodigoTipIdent2() {
		return CodigoTipIdent2;
	}
	public void setCodigoTipIdent2(String codigoTipIdent2) {
		CodigoTipIdent2 = codigoTipIdent2;
	}
	public String getNumeroFax() {
		return NumeroFax;
	}
	public void setNumeroFax(String numeroFax) {
		NumeroFax = numeroFax;
	}
	public String getNumeroIntGrupoFam() {
		return NumeroIntGrupoFam;
	}
	public void setNumeroIntGrupoFam(String numeroIntGrupoFam) {
		NumeroIntGrupoFam = numeroIntGrupoFam;
	}
	public String getNumIdent2() {
		return NumIdent2;
	}
	public void setNumIdent2(String numIdent2) {
		NumIdent2 = numIdent2;
	}
	public String getCodigoCategoria() {
		return codigoCategoria;
	}
	public void setCodigoCategoria(String codigoCategoria) {
		this.codigoCategoria = codigoCategoria;
	}
	public String getCodCrediticia() {
		return codCrediticia;
	}
	public void setCodCrediticia(String codCrediticia) {
		this.codCrediticia = codCrediticia;
	}
	
}
