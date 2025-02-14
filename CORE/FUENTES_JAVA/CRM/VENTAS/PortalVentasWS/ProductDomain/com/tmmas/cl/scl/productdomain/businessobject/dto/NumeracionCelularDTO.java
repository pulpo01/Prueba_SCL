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
 * 14/07/2008 09:31     Nicol&aacute;s Contreras    		Versión Inicial 
 * 
 *
 * 
 * @author Nicolas Contreras
 * @version 1.0
 **/
package com.tmmas.cl.scl.productdomain.businessobject.dto;

import java.io.Serializable;

/**
 * @author mwn90113
 *
 */
public class NumeracionCelularDTO implements Serializable {

	private static final long serialVersionUID = -1606171962608054024L;
	/* VP_TRANSAC */
	private String secuencia; 
	/* VP_TABLA */
    private String nombreTabla;
	/* VP_SUBALM */
    private String codSubALM;
    /* VP_CENTRAL */
    private String codCentral;
	/* VP_CAT */
    private String codCat;
	/* VP_USO */
    private String codUso;
	/* VP_CELULAR */    
    private Long numCelular;
    /* VP_FECBAJA */
    private String fecBaja;
    /* COD_PRODUCTO */
    private Long codProducto;
    /* IND_EQUIPADO */
    private Long indEquipado;
    /* USO_ANTERIOR */
    private Long usoAnterior;
    /* IND_ENVIO_CENTRAL */
    private Long indEnvioCentral;        
    /* NUM_ABONADO */
    private Long numAbonado;
    /* NUM_LINEA */
    private Long numLinea;
    /* NUM_ORDEN */
    private Long numOrden;    
    /* IND_PROCNUM */
    private String indProcNum;
	/* NOM_USUARIO */
    private String nomUsuarioSCL;
    /*SN_COD_RETORNO_TRANS*/
    private Long codRetornoTrans;
    /*SV_DES_CADENA_TRANS*/
    private String desCadenaTrans;
    private Long CodVendealer;
    
    //TODO: 15DIC2008 BUG PF-PV-034, Se agregan atributos para recuperar los valores de la tabla GA_RESERVA.
    private Long codCliente;
    private Long codVendedor;
    private String origen;
    private String fecReserva;

    
	public Long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(Long codCliente) {
		this.codCliente = codCliente;
	}
	public Long getCodVendedor() {
		return codVendedor;
	}
	public void setCodVendedor(Long codVendedor) {
		this.codVendedor = codVendedor;
	}
	public String getFecReserva() {
		return fecReserva;
	}
	public void setFecReserva(String fecReserva) {
		this.fecReserva = fecReserva;
	}
	public String getOrigen() {
		return origen;
	}
	public void setOrigen(String origen) {
		this.origen = origen;
	}
	public Long getCodRetornoTrans() {
		return codRetornoTrans;
	}
	public void setCodRetornoTrans(Long codRetornoTrans) {
		this.codRetornoTrans = codRetornoTrans;
	}
	public String getDesCadenaTrans() {
		return desCadenaTrans;
	}
	public void setDesCadenaTrans(String desCadenaTrans) {
		this.desCadenaTrans = desCadenaTrans;
	}
	/**
	 * @return the numCelular
	 */
	public Long getNumCelular() {
		return numCelular;
	}
	/**
	 * @param numCelular the numCelular to set
	 */
	public void setNumCelular(Long numCelular) {
		this.numCelular = numCelular;
	}
	/**
	 * @return the nombreTabla
	 */
	public String getNombreTabla() {
		return nombreTabla;
	}
	/**
	 * @param nombreTabla the nombreTabla to set
	 */
	public void setNombreTabla(String nombreTabla) {
		this.nombreTabla = nombreTabla;
	}
	/**
	 * @return the secuencia
	 */
	public String getSecuencia() {
		return secuencia;
	}
	/**
	 * @param secuencia the secuencia to set
	 */
	public void setSecuencia(String secuencia) {
		this.secuencia = secuencia;
	}
	/**
	 * @return the codSubALM
	 */
	public String getCodSubALM() {
		return codSubALM;
	}
	/**
	 * @param codSubALM the codSubALM to set
	 */
	public void setCodSubALM(String codSubALM) {
		this.codSubALM = codSubALM;
	}
	/**
	 * @return the codCentral
	 */
	public String getCodCentral() {
		return codCentral;
	}
	/**
	 * @param codCentral the codCentral to set
	 */
	public void setCodCentral(String codCentral) {
		this.codCentral = codCentral;
	}
	/**
	 * @return the codCat
	 */
	public String getCodCat() {
		return codCat;
	}
	/**
	 * @param codCat the codCat to set
	 */
	public void setCodCat(String codCat) {
		this.codCat = codCat;
	}
	/**
	 * @return the codUso
	 */
	public String getCodUso() {
		return codUso;
	}
	/**
	 * @param codUso the codUso to set
	 */
	public void setCodUso(String codUso) {
		this.codUso = codUso;
	}
	/**
	 * @return the fecBaja
	 */
	public String getFecBaja() {
		return fecBaja;
	}
	/**
	 * @param fecBaja the fecBaja to set
	 */
	public void setFecBaja(String fecBaja) {
		this.fecBaja = fecBaja;
	}
	/**
	 * @return the codProducto
	 */
	public Long getCodProducto() {
		return codProducto;
	}
	/**
	 * @param codProducto the codProducto to set
	 */
	public void setCodProducto(Long codProducto) {
		this.codProducto = codProducto;
	}
	/**
	 * @return the indEquipado
	 */
	public Long getIndEquipado() {
		return indEquipado;
	}
	/**
	 * @param indEquipado the indEquipado to set
	 */
	public void setIndEquipado(Long indEquipado) {
		this.indEquipado = indEquipado;
	}
	/**
	 * @return the usoAnterior
	 */
	public Long getUsoAnterior() {
		return usoAnterior;
	}
	/**
	 * @param usoAnterior the usoAnterior to set
	 */
	public void setUsoAnterior(Long usoAnterior) {
		this.usoAnterior = usoAnterior;
	}
	/**
	 * @return the indEnvioCentral
	 */
	public Long getIndEnvioCentral() {
		return indEnvioCentral;
	}
	/**
	 * @param indEnvioCentral the indEnvioCentral to set
	 */
	public void setIndEnvioCentral(Long indEnvioCentral) {
		this.indEnvioCentral = indEnvioCentral;
	}
	/**
	 * @return the numAbonado
	 */
	public Long getNumAbonado() {
		return numAbonado;
	}
	/**
	 * @param numAbonado the numAbonado to set
	 */
	public void setNumAbonado(Long numAbonado) {
		this.numAbonado = numAbonado;
	}
	/**
	 * @return the numLinea
	 */
	public Long getNumLinea() {
		return numLinea;
	}
	/**
	 * @param numLinea the numLinea to set
	 */
	public void setNumLinea(Long numLinea) {
		this.numLinea = numLinea;
	}
	/**
	 * @return the numOrden
	 */
	public Long getNumOrden() {
		return numOrden;
	}
	/**
	 * @param numOrden the numOrden to set
	 */
	public void setNumOrden(Long numOrden) {
		this.numOrden = numOrden;
	}
	/**
	 * @return the indProcNum
	 */
	public String getIndProcNum() {
		return indProcNum;
	}
	/**
	 * @param indProcNum the indProcNum to set
	 */
	public void setIndProcNum(String indProcNum) {
		this.indProcNum = indProcNum;
	}
	/**
	 * @return the nomUsuarioSCL
	 */
	public String getNomUsuarioSCL() {
		return nomUsuarioSCL;
	}
	/**
	 * @param nomUsuarioSCL the nomUsuarioSCL to set
	 */
	public void setNomUsuarioSCL(String nomUsuarioSCL) {
		this.nomUsuarioSCL = nomUsuarioSCL;
	}
	public Long getCodVendealer() {
		return CodVendealer;
	}
	public void setCodVendealer(Long codVendealer) {
		CodVendealer = codVendealer;
	}
	
}
