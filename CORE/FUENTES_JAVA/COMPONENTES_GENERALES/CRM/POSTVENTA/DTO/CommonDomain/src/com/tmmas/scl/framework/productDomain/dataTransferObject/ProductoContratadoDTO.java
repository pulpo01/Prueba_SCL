/**
 * Copyright © 2006 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 25-06-2007     			 Esteban Conejeros              		Versión Inicial
 * 13-08-2007				 Cristian Toledo 					Se agrego estructura para types de Oracle 
 */
package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Date;

import com.tmmas.scl.framework.serviceDomain.dataTransferObject.NumeroListDTO;

public class ProductoContratadoDTO implements Serializable
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private Long idProdContratado;	
	private Long idClienteBeneficiario;
	private Long idAbonadoBeneficiario;
	private Date fechaInicioVigencia;
	private String idCanal;
	private String numProceso;
	private String origenProceso;
	private	Date fechaProceso;
	private String idEstado;
	private String indCondicionContratacion;
	private Long idClienteContratante;
	private Long numAbonadoContratante;
	private Date fechaTerminoVigencia;
	private Long indPrioridad;
	private Long idProdContraPadre;
	private String codPerfilLista;
	private String tipoComportamiento;
	private String indPaquete;
	//private Long idProductoOfertado;
	private Long idProductoOfertado;
	
	private String numProcesoDescontrata;
	private String origenProcesoDescontrata;
	private Date   fechaProcesoDescontrata;
	
	private ProductoOfertadoDTO prodOfertado;
	private NumeroListDTO listaNumero;
	
	public ProductoContratadoDTO()
	{
		Calendar cal=Calendar.getInstance();
		cal.set(3000, 11, 31);
		this.fechaInicioVigencia=new Date();
		this.fechaTerminoVigencia=new Date(cal.getTimeInMillis());
		this.fechaProceso=new Date();
	}
	
	public Object[] toStruct_FA_CARGOS_REC_QT()
	{
		
		Object[] obj={	idClienteContratante,
						numAbonadoContratante!=null?numAbonadoContratante:new Long("0"),
						idProdContratado,
						"0", // COD_CARGO_CONTRATADO
						null,
						null,
						null,
						null,
						null,
						null,
						"0", // COD_CONCEPTO
						fechaInicioVigencia!=null?new Timestamp(fechaInicioVigencia.getTime()):null,  //FEC_ALTA
						fechaTerminoVigencia!=null?new Timestamp(fechaTerminoVigencia.getTime()):null, //FEC_BAJA
						null,
						new Timestamp(new Date().getTime()), //FEC_HASTACOBR
						null,
						null,
						null,
						null,
						null,
						null,
						null,
						null,
						null
					 };		
		return obj;
	}	
	
	public Object[] toStruct_FA_CARGOS_QT()
	{
		Object[] obj={	null,
						idClienteContratante,
						numAbonadoContratante!=null?numAbonadoContratante:new Long("0"),
						idProdContratado,
						idProductoOfertado,
						null,
						null,
						null,
						null,
						null,
						null,
						null,
						null,
						null,
						null,
						null,
						null,
						null,
						null,
						null,
						null,
						null,
						null,
						null,
						null,
						null,
						null,
						null,
						null,
						null,
						null,
						null,
						null,
						null,
						null,
						null,
						null,
						null,
						null,
						null,
						null
					 };		
		return obj;
	}	
	
	public Object[] toStruct_PR_PRODUCTOS_CONTS_TO_QT()
	{
		Object[] obj= {	idProdContratado,
						idClienteBeneficiario,
						idAbonadoBeneficiario,
						idProductoOfertado,
						fechaInicioVigencia!=null?new Timestamp(fechaInicioVigencia.getTime()):null,
						idCanal,
						numProceso,
						origenProceso,
						fechaProceso!=null?new Timestamp(fechaProceso.getTime()):null,
						idEstado,
						indCondicionContratacion,						
						idClienteContratante,
						numAbonadoContratante,
						fechaTerminoVigencia!=null?new Timestamp(fechaTerminoVigencia.getTime()):null,
						indPrioridad,
						idProdContraPadre,
						codPerfilLista,
						tipoComportamiento
					  };		
		return obj;
	}
	
	public Object[] toStruct_SV_PROD_CONTRA_QT()
	{
		Object[] obj= {	idProdContratado,
						numProceso,
						origenProceso,
						null,
						idClienteContratante,
						numAbonadoContratante
			  		  };		
		return obj;
	}	
	
	public Object[] toStruct_SV_LISTA_CONTRA_TO_QT()
	{
		Object[] obj= {	idProdContratado,
						null,
						fechaInicioVigencia!=null?new Timestamp(fechaInicioVigencia.getTime()):null,
						fechaTerminoVigencia!=null?new Timestamp(fechaTerminoVigencia.getTime()):null,
						null,
						numProceso,
						origenProceso,
						fechaProceso!=null?new Timestamp(fechaProceso.getTime()):null,
						null,
						null
						};		
		return obj;
	}	
	
	public Object[] toStruct_TOL_BAJA_PRODUCTO_QT()
	{
		Object[] obj= {	idProdContratado,
						fechaTerminoVigencia!=null?new Timestamp(fechaTerminoVigencia.getTime()):null,
			  		  };
		return obj;
	}
	
	public Object[] PR_PRODUCTO_DESCONTRATA_QT()
	{		
		codPerfilLista = "".equals(codPerfilLista)?null:codPerfilLista;
		
		Object[] obj= {	origenProcesoDescontrata,
						numProcesoDescontrata,
						fechaProcesoDescontrata!=null?new Timestamp(fechaProcesoDescontrata.getTime()):null,
						tipoComportamiento,
						codPerfilLista,
						idProdContraPadre,
						indPrioridad,
						fechaTerminoVigencia!=null?new Timestamp(fechaTerminoVigencia.getTime()):null,
						numAbonadoContratante,
						idClienteContratante,
						indCondicionContratacion,
						idEstado,
						fechaProceso!=null?new Timestamp(fechaProceso.getTime()):null,
						origenProceso,
						numProceso,
						idCanal,
						fechaInicioVigencia!=null?new Timestamp(fechaInicioVigencia.getTime()):null,
						idProductoOfertado,
						idAbonadoBeneficiario,
						idClienteBeneficiario,
						idProdContratado,
					};
		return obj;
	}
	
	public void setProductoOfertadoDTO(ProductoOfertadoDTO productoOfer)
	{
		//idClienteBeneficiario=productoOfer.get;
		//idAbonadoBeneficiario=productoOfer.get;
		fechaInicioVigencia=productoOfer.getFecInicioVigencia();
		//idCanal=productoOfer.get;
		//numProceso=productoOfer.get;
		//origenProceso=productoOfer.get;
		//fechaProceso=productoOfer.get;
		//idEstado=productoOfer.get;
		//indCondicionContratacion=productoOfer.get;
		//idClienteContratante=productoOfer.get;
		//numAbonadoContratante=productoOfer.get;
		fechaTerminoVigencia=productoOfer.getFecTerminoVigencia();
		//indPrioridad=productoOfer.get;
		//idProdContraPadre=productoOfer.get;
		//codPerfilLista=productoOfer.get;
		//tipoComportamiento=productoOfer.get;
		//indPaquete=productoOfer.get;
		idProductoOfertado=new Long(productoOfer.getIdProductoOfertado());
	}
	
	public String getIdCanal() {
		return idCanal;
	}

	public void setIdCanal(String idCanal) {
		this.idCanal = idCanal;
	}

	public String getCodPerfilLista() {
		return codPerfilLista;
	}
	public void setCodPerfilLista(String codPerfilLista) {
		this.codPerfilLista = codPerfilLista;
	}
	public Date getFechaInicioVigencia() {
		return fechaInicioVigencia;
	}
	public void setFechaInicioVigencia(Date fechaInicioVigencia) {
		this.fechaInicioVigencia = fechaInicioVigencia;
	}
	public Date getFechaProceso() {
		return fechaProceso;
	}
	public void setFechaProceso(Date fechaProceso) {
		this.fechaProceso = fechaProceso;
	}
	public Date getFechaTerminoVigencia() {
		return fechaTerminoVigencia;
	}
	public void setFechaTerminoVigencia(Date fechaTerminoVigencia) {
		this.fechaTerminoVigencia = fechaTerminoVigencia;
	}
	public Long getIdAbonadoBeneficiario() {
		return idAbonadoBeneficiario;
	}
	public void setIdAbonadoBeneficiario(Long idAbonadoBeneficiario) {
		this.idAbonadoBeneficiario = idAbonadoBeneficiario;
	}	
	public Long getIdClienteBeneficiario() {
		return idClienteBeneficiario;
	}
	public void setIdClienteBeneficiario(Long idClienteBeneficiario) {
		this.idClienteBeneficiario = idClienteBeneficiario;
	}
	public Long getIdClienteContratante() {
		return idClienteContratante;
	}
	public void setIdClienteContratante(Long idClienteContratante) {
		this.idClienteContratante = idClienteContratante;
	}
	public String getIdEstado() {
		return idEstado;
	}
	public void setIdEstado(String idEstado) {
		this.idEstado = idEstado;
	}
	public String getIndCondicionContratacion() {
		return indCondicionContratacion;
	}
	public void setIndCondicionContratacion(String indCondicionContratacion) {
		this.indCondicionContratacion = indCondicionContratacion;
	}
	public Long getIndPrioridad() {
		return indPrioridad;
	}
	public void setIndPrioridad(Long indPrioridad) {
		this.indPrioridad = indPrioridad;
	}
	public Long getNumAbonadoContratante() {
		return numAbonadoContratante;
	}
	public void setNumAbonadoContratante(Long numAbonadoContratante) {
		this.numAbonadoContratante = numAbonadoContratante;
	}
	public String getNumProceso() {
		return numProceso;
	}
	public void setNumProceso(String numProceso) {
		this.numProceso = numProceso;
	}
	public String getOrigenProceso() {
		return origenProceso;
	}
	public void setOrigenProceso(String origenProceso) {
		this.origenProceso = origenProceso;
	}
	public String getTipoComportamiento() {
		return tipoComportamiento;
	}
	public void setTipoComportamiento(String tipoComportamiento) {
		this.tipoComportamiento = tipoComportamiento;
	}
	public Long getIdProdContraPadre() {
		return idProdContraPadre;
	}
	public void setIdProdContraPadre(Long idProdContraPadre) {
		this.idProdContraPadre = idProdContraPadre;
	}
	

	public Long getIdProdContratado() {
		return idProdContratado;
	}

	public void setIdProdContratado(Long idProdContratado) {
		this.idProdContratado = idProdContratado;
	}

	public ProductoOfertadoDTO getProdOfertado() {
		return prodOfertado;
	}
	public void setProdOfertado(ProductoOfertadoDTO prodOfertado) {
		this.prodOfertado = prodOfertado;
	}
	public String getIndPaquete() {
		return indPaquete;
	}
	public void setIndPaquete(String indPaquete) {
		this.indPaquete = indPaquete;
	}
	public Long getIdProductoOfertado() {
		return idProductoOfertado;
	}
	public void setIdProductoOfertado(Long idProductoOfertado) {
		this.idProductoOfertado = idProductoOfertado;
	}

	public NumeroListDTO getListaNumero() {
		return listaNumero;
	}

	public void setListaNumero(NumeroListDTO listaNumero) {
		this.listaNumero = listaNumero;
	}

	public Date getFechaProcesoDescontrata() {
		return fechaProcesoDescontrata;
	}

	public void setFechaProcesoDescontrata(Date fechaProcesoDescontrata) {
		this.fechaProcesoDescontrata = fechaProcesoDescontrata;
	}

	public String getNumProcesoDescontrata() {
		return numProcesoDescontrata;
	}

	public void setNumProcesoDescontrata(String numProcesoDescontrata) {
		this.numProcesoDescontrata = numProcesoDescontrata;
	}

	public String getOrigenProcesoDescontrata() {
		return origenProcesoDescontrata;
	}

	public void setOrigenProcesoDescontrata(String origenProcesoDescontrata) {
		this.origenProcesoDescontrata = origenProcesoDescontrata;
	}
	
}
