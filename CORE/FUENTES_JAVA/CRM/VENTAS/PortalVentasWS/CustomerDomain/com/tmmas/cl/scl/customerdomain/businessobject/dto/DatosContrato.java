//P-CSR-11002 JLGN 25-05-2011
package com.tmmas.cl.scl.customerdomain.businessobject.dto;

import java.io.Serializable;

public class DatosContrato implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private String 	fecVenta;
	private String 	numVenta;
	//Datos Origen
	private String 	altaContrato;
	private String 	migracion;
	private String 	cambioTitular;
	private String 	solicPortabilidad;
	//Datos Punto de Venta
	private String 	codPuntoVenta;
	private String 	nomPuntoVenta;
	//Datos cliente
	private String  tipIdent;
	private String 	numIdent;
	private String 	tipCliParti;
	private String 	tipCliPyme;
	private String 	tipCliEmpre;	
	private String 	apellidosCliente;
	private String 	nombreCliente;
	private String 	desDomicilio;
	private String 	desProvincia;
	private String  desCanton;
	private String 	desMail;
	private String 	nomRepresentante;
	private String  tipIdentRepre;
	private String 	numIdentRepresentante;
	private String 	numMesesContrato;
	private String  mensPromSi;
	private String  mensPromNo;	
	private String  infTerSI;
	private String  infTerNO;
	//Datos Linea
	private DatosLineaContratoDTO lineascontrato[];
	//Datos Domiciliacion
	private String 	codBanco;
	private String 	moneda;
	private String 	numCuentaCorriente;
	private String	entidad;
	private String  tipTarjeta;
	private String	numTarjeta;
	
	public String getAltaContrato() {
		return altaContrato;
	}
	public void setAltaContrato(String altaContrato) {
		this.altaContrato = altaContrato;
	}
	public String getApellidosCliente() {
		return apellidosCliente;
	}
	public void setApellidosCliente(String apellidosCliente) {
		this.apellidosCliente = apellidosCliente;
	}
	public String getCambioTitular() {
		return cambioTitular;
	}
	public void setCambioTitular(String cambioTitular) {
		this.cambioTitular = cambioTitular;
	}
	public String getCodBanco() {
		return codBanco;
	}
	public void setCodBanco(String codBanco) {
		this.codBanco = codBanco;
	}
	public String getCodPuntoVenta() {
		return codPuntoVenta;
	}
	public void setCodPuntoVenta(String codPuntoVenta) {
		this.codPuntoVenta = codPuntoVenta;
	}
	public String getDesCanton() {
		return desCanton;
	}
	public void setDesCanton(String desCanton) {
		this.desCanton = desCanton;
	}
	public String getDesDomicilio() {
		return desDomicilio;
	}
	public void setDesDomicilio(String desDomicilio) {
		this.desDomicilio = desDomicilio;
	}
	public String getDesMail() {
		return desMail;
	}
	public void setDesMail(String desMail) {
		this.desMail = desMail;
	}
	public String getDesProvincia() {
		return desProvincia;
	}
	public void setDesProvincia(String desProvincia) {
		this.desProvincia = desProvincia;
	}
	public String getEntidad() {
		return entidad;
	}
	public void setEntidad(String entidad) {
		this.entidad = entidad;
	}
	public String getFecVenta() {
		return fecVenta;
	}
	public void setFecVenta(String fecVenta) {
		this.fecVenta = fecVenta;
	}
	public DatosLineaContratoDTO[] getLineascontrato() {
		return lineascontrato;
	}
	public void setLineascontrato(DatosLineaContratoDTO[] lineascontrato) {
		this.lineascontrato = lineascontrato;
	}
	public String getMensPromNo() {
		return mensPromNo;
	}
	public void setMensPromNo(String mensPromNo) {
		this.mensPromNo = mensPromNo;
	}
	public String getMensPromSi() {
		return mensPromSi;
	}
	public void setMensPromSi(String mensPromSi) {
		this.mensPromSi = mensPromSi;
	}
	public String getMigracion() {
		return migracion;
	}
	public void setMigracion(String migracion) {
		this.migracion = migracion;
	}
	public String getNombreCliente() {
		return nombreCliente;
	}
	public void setNombreCliente(String nombreCliente) {
		this.nombreCliente = nombreCliente;
	}
	public String getNomPuntoVenta() {
		return nomPuntoVenta;
	}
	public void setNomPuntoVenta(String nomPuntoVenta) {
		this.nomPuntoVenta = nomPuntoVenta;
	}
	public String getNomRepresentante() {
		return nomRepresentante;
	}
	public void setNomRepresentante(String nomRepresentante) {
		this.nomRepresentante = nomRepresentante;
	}
	public String getNumCuentaCorriente() {
		return numCuentaCorriente;
	}
	public void setNumCuentaCorriente(String numCuentaCorriente) {
		this.numCuentaCorriente = numCuentaCorriente;
	}
	public String getNumIdent() {
		return numIdent;
	}
	public void setNumIdent(String numIdent) {
		this.numIdent = numIdent;
	}
	public String getNumIdentRepresentante() {
		return numIdentRepresentante;
	}
	public void setNumIdentRepresentante(String numIdentRepresentante) {
		this.numIdentRepresentante = numIdentRepresentante;
	}
	public String getNumMesesContrato() {
		return numMesesContrato;
	}
	public void setNumMesesContrato(String numMesesContrato) {
		this.numMesesContrato = numMesesContrato;
	}
	public String getNumTarjeta() {
		return numTarjeta;
	}
	public void setNumTarjeta(String numTarjeta) {
		this.numTarjeta = numTarjeta;
	}
	public String getNumVenta() {
		return numVenta;
	}
	public void setNumVenta(String numVenta) {
		this.numVenta = numVenta;
	}
	public String getSolicPortabilidad() {
		return solicPortabilidad;
	}
	public void setSolicPortabilidad(String solicPortabilidad) {
		this.solicPortabilidad = solicPortabilidad;
	}
	public String getTipCliEmpre() {
		return tipCliEmpre;
	}
	public void setTipCliEmpre(String tipCliEmpre) {
		this.tipCliEmpre = tipCliEmpre;
	}
	public String getTipCliParti() {
		return tipCliParti;
	}
	public void setTipCliParti(String tipCliParti) {
		this.tipCliParti = tipCliParti;
	}
	public String getTipCliPyme() {
		return tipCliPyme;
	}
	public void setTipCliPyme(String tipCliPyme) {
		this.tipCliPyme = tipCliPyme;
	}
	public String getTipIdent() {
		return tipIdent;
	}
	public void setTipIdent(String tipIdent) {
		this.tipIdent = tipIdent;
	}
	public String getTipIdentRepre() {
		return tipIdentRepre;
	}
	public void setTipIdentRepre(String tipIdentRepre) {
		this.tipIdentRepre = tipIdentRepre;
	}
	public String getTipTarjeta() {
		return tipTarjeta;
	}
	public void setTipTarjeta(String tipTarjeta) {
		this.tipTarjeta = tipTarjeta;
	}
	public String getMoneda() {
		return moneda;
	}
	public void setMoneda(String moneda) {
		this.moneda = moneda;
	}
	public String getInfTerNO() {
		return infTerNO;
	}
	public void setInfTerNO(String infTerNO) {
		this.infTerNO = infTerNO;
	}
	public String getInfTerSI() {
		return infTerSI;
	}
	public void setInfTerSI(String infTerSI) {
		this.infTerSI = infTerSI;
	}
}