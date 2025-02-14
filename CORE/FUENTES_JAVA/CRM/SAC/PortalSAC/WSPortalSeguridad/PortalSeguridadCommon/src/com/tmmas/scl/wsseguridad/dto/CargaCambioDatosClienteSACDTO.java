package com.tmmas.scl.wsseguridad.dto;


import java.math.BigDecimal;

import com.tmmas.scl.wsfranquicias.common.dto.cambiodatoscliente.bancarios.CargaCambioDatosBancariosDTO;
import com.tmmas.scl.wsfranquicias.common.dto.cambiodatoscliente.generales.CargaCambioDatosGeneralesClienteDTO;
import com.tmmas.scl.wsfranquicias.common.dto.cambiodatoscliente.personales.CargaCambioDatosPersonalesClienteDTO;
import com.tmmas.scl.wsfranquicias.common.dto.cambiodatoscliente.tributario.CargaCambioDatosTributariosClienteDTO;

/**
 * Copyright © 2008 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 07/07/2008     Héctor Hermosilla      			Versión Inicial 
 * 
 *
 * 
 * 
 * @author Héctor Hermosilla
 * @version 1.0
 **/

public class CargaCambioDatosClienteSACDTO {

	private static final long serialVersionUID = 1L;
	
	
	
	private String apellido1;
	private String apellido2;
	private Integer codActividad;
	private Long codCliente;
	private Long codCuenta;
	private String codIdioma;
	private String codOficina;
	private String codPais;
	private String codPinCliente;
	private String codTipIdent;
	private String codTipIdent2;
	private String codTipIdentTrib;
	private String desCuenta;
	private String desIdioma;
	private String desIndDebito;
	private String desSisPago;
	private String desTipIdent;
	private String desTipIdent2;
	private String desTipIdentTrib;
	private String email;
	private String indTraspaso;
	private String nomCliente;
	private String numFax;
	private String numIdent;
	private String numIdent2;
	private String numIdentTrib;
	private String numTelefono;
	private String numTelefono2;
	private int codNpi;
	private int codCatImpositiva;
	private String desNpi;
	private Integer codSisPago;
	private String numCuentaCte;
	private String tipoCuentaCte;
	private String numTarjeta;
	private String vencTarjeta;
	private BigDecimal limPago;
	private String codBanco;
	private String nomBanco;
	private String codSucursal;
	private String nomSucursal;
	private String codTipTarjeta;
	private String nomTipTarjeta;
	private String codBancoTarjeta;
	private String nomBancoTarjeta;
	
	private long nroOOSS;
	private String codError;
	private String desError;
	private String numTransaccion;
	private String nomUsuarioSCL;
	
	
	
	
	
	//Llamada a los bloques de datos específicos
	private CargaCambioDatosBancariosDTO cargaCambioDatosBancariosDTO;
	private CargaCambioDatosGeneralesClienteDTO cargaCambioDatosGeneralesClienteDTO;
	private CargaCambioDatosPersonalesClienteDTO cargaCambioDatosPersonalesClienteDTO;
	private CargaCambioDatosTributariosClienteDTO cargaCambioDatosTributariosClienteDTO;
	
	
	public CargaCambioDatosBancariosDTO getCargaCambioDatosBancariosDTO() {
		return cargaCambioDatosBancariosDTO;
	}
	public void setCargaCambioDatosBancariosDTO(
			CargaCambioDatosBancariosDTO cargaCambioDatosBancariosDTO) {
		this.cargaCambioDatosBancariosDTO = cargaCambioDatosBancariosDTO;
	}
	public CargaCambioDatosGeneralesClienteDTO getCargaCambioDatosGeneralesClienteDTO() {
		return cargaCambioDatosGeneralesClienteDTO;
	}
	public void setCargaCambioDatosGeneralesClienteDTO(
			CargaCambioDatosGeneralesClienteDTO cargaCambioDatosGeneralesClienteDTO) {
		this.cargaCambioDatosGeneralesClienteDTO = cargaCambioDatosGeneralesClienteDTO;
	}
	public CargaCambioDatosPersonalesClienteDTO getCargaCambioDatosPersonalesClienteDTO() {
		return cargaCambioDatosPersonalesClienteDTO;
	}
	public void setCargaCambioDatosPersonalesClienteDTO(
			CargaCambioDatosPersonalesClienteDTO cargaCambioDatosPersonalesClienteDTO) {
		this.cargaCambioDatosPersonalesClienteDTO = cargaCambioDatosPersonalesClienteDTO;
	}
	public CargaCambioDatosTributariosClienteDTO getCargaCambioDatosTributariosClienteDTO() {
		return cargaCambioDatosTributariosClienteDTO;
	}
	public void setCargaCambioDatosTributariosClienteDTO(
			CargaCambioDatosTributariosClienteDTO cargaCambioDatosTributariosClienteDTO) {
		this.cargaCambioDatosTributariosClienteDTO = cargaCambioDatosTributariosClienteDTO;
	}
	
	
	/**
	 * @return the codCliente
	 */
	public Long getCodCliente() {
		return codCliente;
	}
	/**
	 * @param codCliente the codCliente to set
	 */
	public void setCodCliente(Long codCliente) {
		this.codCliente = codCliente;
	}
	/**
	 * @return the codCuenta
	 */
	public Long getCodCuenta() {
		return codCuenta;
	}
	/**
	 * @param codCuenta the codCuenta to set
	 */
	public void setCodCuenta(Long codCuenta) {
		this.codCuenta = codCuenta;
	}
	/**
	 * @return the desCuenta
	 */
	public String getDesCuenta() {
		return desCuenta;
	}
	/**
	 * @param desCuenta the desCuenta to set
	 */
	public void setDesCuenta(String desCuenta) {
		this.desCuenta = desCuenta;
	}
	/**
	 * @return the nomCliente
	 */
	public String getNomCliente() {
		return nomCliente;
	}
	/**
	 * @param nomCliente the nomCliente to set
	 */
	public void setNomCliente(String nomCliente) {
		this.nomCliente = nomCliente;
	}
	/**
	 * @return the apellido1
	 */
	public String getApellido1() {
		return apellido1;
	}
	/**
	 * @param apellido1 the apellido1 to set
	 */
	public void setApellido1(String apellido1) {
		this.apellido1 = apellido1;
	}
	/**
	 * @return the apellido2
	 */
	public String getApellido2() {
		return apellido2;
	}
	/**
	 * @param apellido2 the apellido2 to set
	 */
	public void setApellido2(String apellido2) {
		this.apellido2 = apellido2;
	}
	/**
	 * @return
	 * 08/07/2008 16:48:33
	 */
	public String getCodTipIdent() {
		return codTipIdent;
	}
	/**
	 * @param codTipIdent
	 * 08/07/2008 16:48:38
	 */
	public void setCodTipIdent(String codTipIdent) {
		this.codTipIdent = codTipIdent;
	}
	/**
	 * @return
	 * 08/07/2008 16:48:42
	 */
	public String getDesTipIdent() {
		return desTipIdent;
	}
	/**
	 * @param desTipIdent
	 * 08/07/2008 16:48:45
	 */
	public void setDesTipIdent(String desTipIdent) {
		this.desTipIdent = desTipIdent;
	}
	/**
	 * @return
	 * 08/07/2008 17:47:32
	 */
	public String getNumIdent() {
		return numIdent;
	}
	/**
	 * @param numIdent
	 * 08/07/2008 17:47:35
	 */
	public void setNumIdent(String numIdent) {
		this.numIdent = numIdent;
	}
	public Integer getCodActividad() {
		return codActividad;
	}
	public void setCodActividad(Integer codActividad) {
		this.codActividad = codActividad;
	}
	public String getCodIdioma() {
		return codIdioma;
	}
	public void setCodIdioma(String codIdioma) {
		this.codIdioma = codIdioma;
	}
	
	/**
	 * @return the codNpi
	 */
	public int getCodNpi() {
		return codNpi;
	}
	/**
	 * @param codNpi the codNpi to set
	 */
	
	public void setCodNpi(int codNpi) {
		this.codNpi = codNpi;
	}
	public String getCodOficina() {
		return codOficina;
	}
	public void setCodOficina(String codOficina) {
		this.codOficina = codOficina;
	}
	public String getCodPais() {
		return codPais;
	}
	public void setCodPais(String codPais) {
		this.codPais = codPais;
	}
	public String getCodPinCliente() {
		return codPinCliente;
	}
	public void setCodPinCliente(String codPinCliente) {
		this.codPinCliente = codPinCliente;
	}
	public String getCodTipIdent2() {
		return codTipIdent2;
	}
	public void setCodTipIdent2(String codTipident2) {
		this.codTipIdent2 = codTipident2;
	}
	public String getCodTipIdentTrib() {
		return codTipIdentTrib;
	}
	public void setCodTipIdentTrib(String codTipIdentTrib) {
		this.codTipIdentTrib = codTipIdentTrib;
	}
	public String getDesIdioma() {
		return desIdioma;
	}
	public void setDesIdioma(String desIdioma) {
		this.desIdioma = desIdioma;
	}
	public String getDesIndDebito() {
		return desIndDebito;
	}
	public void setDesIndDebito(String desIndDebito) {
		this.desIndDebito = desIndDebito;
	}
	public String getDesSisPago() {
		return desSisPago;
	}
	public void setDesSisPago(String desSisPago) {
		this.desSisPago = desSisPago;
	}
	public String getDesTipIdent2() {
		return desTipIdent2;
	}
	public void setDesTipIdent2(String desTipident2) {
		this.desTipIdent2 = desTipident2;
	}
	public String getDesTipIdentTrib() {
		return desTipIdentTrib;
	}
	public void setDesTipIdentTrib(String desTipIdentTrib) {
		this.desTipIdentTrib = desTipIdentTrib;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getIndTraspaso() {
		return indTraspaso;
	}
	public void setIndTraspaso(String indTraspaso) {
		this.indTraspaso = indTraspaso;
	}
	public String getNumFax() {
		return numFax;
	}
	public void setNumFax(String numFax) {
		this.numFax = numFax;
	}
	public String getNumIdent2() {
		return numIdent2;
	}
	public void setNumIdent2(String numIdent2) {
		this.numIdent2 = numIdent2;
	}
	public String getNumIdentTrib() {
		return numIdentTrib;
	}
	public void setNumIdentTrib(String numIdentTrib) {
		this.numIdentTrib = numIdentTrib;
	}
	public String getNumTelefono() {
		return numTelefono;
	}
	public void setNumTelefono(String numTelefono) {
		this.numTelefono = numTelefono;
	}
	public String getNumTelefono2() {
		return numTelefono2;
	}
	public void setNumTelefono2(String numTelefono2) {
		this.numTelefono2 = numTelefono2;
	}
	/**
	 * @return the codBanco
	 */
	public String getCodBanco() {
		return codBanco;
	}
	/**
	 * @param codBanco the codBanco to set
	 */
	public void setCodBanco(String codBanco) {
		this.codBanco = codBanco;
	}
	/**
	 * @return the codBancoTarjeta
	 */
	public String getCodBancoTarjeta() {
		return codBancoTarjeta;
	}
	/**
	 * @param codBancoTarjeta the codBancoTarjeta to set
	 */
	public void setCodBancoTarjeta(String codBancoTarjeta) {
		this.codBancoTarjeta = codBancoTarjeta;
	}
	/**
	 * @return the codCatImpositiva
	 */
	public int getCodCatImpositiva() {
		return codCatImpositiva;
	}
	/**
	 * @param codCatImpositiva the codCatImpositiva to set
	 */
	public void setCodCatImpositiva(int codCatImpositiva) {
		this.codCatImpositiva = codCatImpositiva;
	}
	/**
	 * @return the codSisPago
	 */
	public Integer getCodSisPago() {
		return codSisPago;
	}
	/**
	 * @param codSisPago the codSisPago to set
	 */
	public void setCodSisPago(Integer codSisPago) {
		this.codSisPago = codSisPago;
	}
	/**
	 * @return the codSucursal
	 */
	public String getCodSucursal() {
		return codSucursal;
	}
	/**
	 * @param codSucursal the codSucursal to set
	 */
	public void setCodSucursal(String codSucursal) {
		this.codSucursal = codSucursal;
	}
	/**
	 * @return the codTipTarjeta
	 */
	public String getCodTipTarjeta() {
		return codTipTarjeta;
	}
	/**
	 * @param codTipTarjeta the codTipTarjeta to set
	 */
	public void setCodTipTarjeta(String codTipTarjeta) {
		this.codTipTarjeta = codTipTarjeta;
	}
	/**
	 * @return the desNpi
	 */
	public String getDesNpi() {
		return desNpi;
	}
	/**
	 * @param desNpi the desNpi to set
	 */
	public void setDesNpi(String desNpi) {
		this.desNpi = desNpi;
	}
	/**
	 * @return the limPago
	 */
	public BigDecimal getLimPago() {
		return limPago;
	}
	/**
	 * @param limPago the limPago to set
	 */
	public void setLimPago(BigDecimal limPago) {
		this.limPago = limPago;
	}
	/**
	 * @return the nomBanco
	 */
	public String getNomBanco() {
		return nomBanco;
	}
	/**
	 * @param nomBanco the nomBanco to set
	 */
	public void setNomBanco(String nomBanco) {
		this.nomBanco = nomBanco;
	}
	/**
	 * @return the nomBancoTarjeta
	 */
	public String getNomBancoTarjeta() {
		return nomBancoTarjeta;
	}
	/**
	 * @param nomBancoTarjeta the nomBancoTarjeta to set
	 */
	public void setNomBancoTarjeta(String nomBancoTarjeta) {
		this.nomBancoTarjeta = nomBancoTarjeta;
	}
	/**
	 * @return the nomSucursal
	 */
	public String getNomSucursal() {
		return nomSucursal;
	}
	/**
	 * @param nomSucursal the nomSucursal to set
	 */
	public void setNomSucursal(String nomSucursal) {
		this.nomSucursal = nomSucursal;
	}
	/**
	 * @return the nomTipTarjeta
	 */
	public String getNomTipTarjeta() {
		return nomTipTarjeta;
	}
	/**
	 * @param nomTipTarjeta the nomTipTarjeta to set
	 */
	public void setNomTipTarjeta(String nomTipTarjeta) {
		this.nomTipTarjeta = nomTipTarjeta;
	}
	/**
	 * @return the numCuentaCte
	 */
	public String getNumCuentaCte() {
		return numCuentaCte;
	}
	/**
	 * @param numCuentaCte the numCuentaCte to set
	 */
	public void setNumCuentaCte(String numCuentaCte) {
		this.numCuentaCte = numCuentaCte;
	}
	/**
	 * @return the numTarjeta
	 */
	public String getNumTarjeta() {
		return numTarjeta;
	}
	/**
	 * @param numTarjeta the numTarjeta to set
	 */
	public void setNumTarjeta(String numTarjeta) {
		this.numTarjeta = numTarjeta;
	}
	/**
	 * @return the tipoCuentaCte
	 */
	public String getTipoCuentaCte() {
		return tipoCuentaCte;
	}
	/**
	 * @param tipoCuentaCte the tipoCuentaCte to set
	 */
	public void setTipoCuentaCte(String tipoCuentaCte) {
		this.tipoCuentaCte = tipoCuentaCte;
	}
	/**
	 * @return the vencTarjeta
	 */
	public String getVencTarjeta() {
		return vencTarjeta;
	}
	/**
	 * @param vencTarjeta the vencTarjeta to set
	 */
	public void setVencTarjeta(String vencTarjeta) {
		this.vencTarjeta = vencTarjeta;
	}
	public String getCodError() {
		return codError;
	}
	public void setCodError(String codError) {
		this.codError = codError;
	}
	public String getDesError() {
		return desError;
	}
	public void setDesError(String desError) {
		this.desError = desError;
	}
	public String getNomUsuarioSCL() {
		return nomUsuarioSCL;
	}
	public void setNomUsuarioSCL(String nomUsuarioSCL) {
		this.nomUsuarioSCL = nomUsuarioSCL;
	}
	public long getNroOOSS() {
		return nroOOSS;
	}
	public void setNroOOSS(long nroOOSS) {
		this.nroOOSS = nroOOSS;
	}
	public String getNumTransaccion() {
		return numTransaccion;
	}
	public void setNumTransaccion(String numTransaccion) {
		this.numTransaccion = numTransaccion;
	}
	
	
	
	
}
