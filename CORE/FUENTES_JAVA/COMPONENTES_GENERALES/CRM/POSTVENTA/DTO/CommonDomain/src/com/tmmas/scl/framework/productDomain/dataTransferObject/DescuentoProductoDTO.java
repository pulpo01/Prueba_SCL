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
 * 20/08/2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;
import java.util.Date;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.CargoOcasionalDTO;

public class DescuentoProductoDTO extends CargoOcasionalDTO implements Serializable
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	
	
	private String codCanal;
	private String tipoVendedor;
	private String codVendedor;
	private Date   fecInicioVigencia;	
	private Date   fecTerminoVigencia;		
	private String codDescuento;		
	
	
	
	/*public Object[] toStruct_FA_CARGOS_QT()
	{
		Object[] obj={	 null,
						 this.getCodCliente(),
						 this.getNumAbonado(),
						 this.getCodProdContratado(),
						 this.getIdCargo(),
						 this.getCodConcepto(),
						 this.getColumna(),
						 new Timestamp(this.getFecAlta().getTime()),
						 this.getImpCargo(),
						 this.getCodMoneda(),
						 this.getCodPlanCom(),
						 this.getNumUnidades(),
						 this.getIndFactur(),
						 this.getNumTransaccion(),
						 this.getNumVenta(),
						 this.getNumPaquete(),
						 this.getNumTerminal(),
						 this.getCodCiclFact(),
						 this.getNumSerie(),
						 this.getNumSerieMec(),
						 this.getCapCode(),
						 this.getMesGarantia(),
						 this.getNumPreguia(),
						 this.getNumGuia(),
						 this.getCodConcerel(),
						 this.getColumnaRel(),	
						 this.getCodConceptoDescuento(),
						 this.getValDescuento(),
						 this.getTipDescuento(),
						 this.getIndCuota(),
						 this.getNumCuotas(),
						 this.getOrdCuota(),
						 this.getIndSupertel(),
						 this.getIndManual(),
						 this.getPrefPlaza(),
						 this.getCodTecnologia(),
						 this.getGlsDescrip(),
						 this.getNumFactura(),
						 new Timestamp(this.getFecUltMod().getTime()),
						 this.getNomUsuario()				
					 };		
		return obj;
	}*/
	
	public String getCodCanal() {
		return codCanal;
	}
	public void setCodCanal(String codCanal) {
		this.codCanal = codCanal;
	}	
	public String getCodDescuento() {
		return codDescuento;
	}
	public void setCodDescuento(String codDescuento) {
		this.codDescuento = codDescuento;
	}	
	public String getCodVendedor() {
		return codVendedor;
	}
	public void setCodVendedor(String codVendedor) {
		this.codVendedor = codVendedor;
	}
	public Date getFecInicioVigencia() {
		return fecInicioVigencia;
	}
	public void setFecInicioVigencia(Date fecInicioVigencia) {
		this.fecInicioVigencia = fecInicioVigencia;
	}
	public Date getFecTerminoVigencia() {
		return fecTerminoVigencia;
	}
	public void setFecTerminoVigencia(Date fecTerminoVigencia) {
		this.fecTerminoVigencia = fecTerminoVigencia;
	}
	
	public String getTipoVendedor() {
		return tipoVendedor;
	}
	public void setTipoVendedor(String tipoVendedor) {
		this.tipoVendedor = tipoVendedor;
	}
	
	
	
}
