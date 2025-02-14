/**
 * Copyright © 2007 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 12/04/2007     Héctor Hermosilla      					Versión Inicial
 */

package com.tmmas.cl.scl.customerdomain.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.scl.crmcommon.commonapp.dto.DetalleInformePresupuestoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ImpuestosDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ProcesoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.ProductDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dao.RegistroFacturacionDAO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.ClienteDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.FaConceptoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.RegistroFacturacionDTO;

public class RegistroFacturacion {
	
	private RegistroFacturacionDAO registroFacturacionDAO  = new RegistroFacturacionDAO();
	private static Category cat = Category.getInstance(RegistroFacturacion.class);
	
	/**
	 * Obtiene el codigo de Promedio facturado, según el monto promedio facturado por el cliente
	 * @param datos
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public RegistroFacturacionDTO getCodigoPromedioFacturado(RegistroFacturacionDTO datos) 
		throws CustomerDomainException 
	{
		cat.debug("getListadoTipoDocumento():start");
		RegistroFacturacionDTO resultado = registroFacturacionDAO.getCodigoPromedioFacturado(datos);
		cat.debug("getListadoTipoDocumento():end");
		return resultado;
	}
	
	/**
	 * Obtiene el codigo ciclo de facturación, en base al codigo ciclo del cliente.
	 * @param cliente
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public RegistroFacturacionDTO getCodigoCicloFacturacion(ClienteDTO cliente) 
		throws CustomerDomainException 
	{
		cat.debug("getCodigoCicloFacturacion():start");
		RegistroFacturacionDTO resultado = registroFacturacionDAO.getCodigoCicloFacturacion(cliente);
		cat.debug("getCodigoCicloFacturacion():end");
		return resultado;
	}
	
	/**
	 *Ejecuta prebilling
	 * @param entrada
	 * @return 
	 * @throws CustomerDomainException
	 */

	public void ejecutaPrebilling(RegistroFacturacionDTO entrada) 
		throws CustomerDomainException
	{
		cat.debug("ejecutaPrebilling():start");
		registroFacturacionDAO.ejecutaPrebilling(entrada);
		cat.debug("ejecutaPrebilling():end");
	}
	
	/**
	 * Obtiene secuencia del paquete para agregar datos a tabla cargos
	 * @param parametroEntrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	
	public RegistroFacturacionDTO getSecuenciaProcesoFacturacion(RegistroFacturacionDTO parametroEntrada)
		throws CustomerDomainException
	{
		RegistroFacturacionDTO resultado = new RegistroFacturacionDTO();
		cat.debug("Inicio:getSecuenciaProcesoFacturacion()");
		resultado =registroFacturacionDAO.getSecuenciaProcesoFacturacion(parametroEntrada); 
		cat.debug("Fin:getSecuenciaProcesoFacturacion()");
		return resultado;
	}
	
	/**
	 * Obtiene el modo de generación, utilizado para ejecutar el Prebilling
	 * @param registroFacturacion
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public RegistroFacturacionDTO getModoGeneracion(RegistroFacturacionDTO registroFacturacion) 
		throws CustomerDomainException
	{
		RegistroFacturacionDTO resultado = new RegistroFacturacionDTO();
		cat.debug("Inicio:getSecuenciaProcesoFacturacion()");
		resultado =registroFacturacionDAO.getModoGeneracion(registroFacturacion); 
		cat.debug("Fin:getSecuenciaProcesoFacturacion()");
		return resultado;
	}
	
	/**
	 * Obtiene datos del presupuesto
	 * @param parametroEntrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public ImpuestosDTO getDatosPresupuesto(ImpuestosDTO parametroEntrada) 
		throws CustomerDomainException
	{
		ImpuestosDTO resultado = new ImpuestosDTO();
		cat.debug("Inicio:getDatosPresupuesto()");
		resultado =registroFacturacionDAO.getDatosPresupuesto(parametroEntrada); 
		cat.debug("Fin:getDatosPresupuesto()");
		return resultado;
	}
	
	/**
	 * Actualiza la facturación
	 * @param parametroEntrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public ProcesoDTO actualizaFacturacion(RegistroFacturacionDTO parametroEntrada) 
		throws CustomerDomainException
	{
		ProcesoDTO resultado;
		cat.debug("Inicio:actualizaFacturacion()");
		resultado =registroFacturacionDAO.actualizaFacturacion(parametroEntrada); 
		cat.debug("Fin:actualizaFacturacion()");
		return resultado;
	}
	/**
	 * Obtiene detalle del presupuesto
	 * @param parametroEntrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public ImpuestosDTO[] getDetallePresupuesto(ImpuestosDTO parametroEntrada) 
		throws CustomerDomainException
	{		
		cat.debug("Inicio:getDetallePresupuesto()");
		ImpuestosDTO[] resultado =registroFacturacionDAO.getDetallePresupuesto(parametroEntrada); 
		cat.debug("Fin:getDetallePresupuesto()");
		return resultado;
	}
	
	/**
	 * Obtiene detalle del presupuesto asociado a concpeto facturable.
	 * @param parametroEntrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public ImpuestosDTO[] getDetallePresupuestoporConcepto(ImpuestosDTO parametroEntrada) 
		throws CustomerDomainException
	{		
		cat.debug("Inicio:getDetallePresupuesto()");
		ImpuestosDTO[] resultado =registroFacturacionDAO.getDetallePresupuestoporConcepto(parametroEntrada); 
		cat.debug("Fin:getDetallePresupuesto()");
		return resultado;
	}

	/**
	 * Obtiene el valor del parametro que indica si se consume folio
	 * @param entrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public RegistroFacturacionDTO getConsumeFolio() 
		throws CustomerDomainException
	{
		RegistroFacturacionDTO resultado;
		cat.debug("Inicio:getConsumeFolio()");
		resultado =registroFacturacionDAO.getConsumeFolio(); 
		cat.debug("Fin:getConsumeFolio()");
		return resultado;	
	}//fin getConsumeFolio

	/**
	 * Obtiene Detalle Presupuesto por concepto facturable
	 * @param parametroEntrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public RegistroFacturacionDTO[] getListCiclosPostPago(RegistroFacturacionDTO entrada) 
		throws CustomerDomainException
	{
		cat.debug("Inicio:getListCiclosPostPago()");
		RegistroFacturacionDTO[] resultado =registroFacturacionDAO.getListCiclosPostPago(entrada); 
		cat.debug("Fin:getListCiclosPostPago()");
		return resultado;
	}//getListCiclosPostPago

	/**
	 * Obtiene codigo de despacho
	 * @param N/A
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public RegistroFacturacionDTO getCodigoDespacho() 
		throws CustomerDomainException
	{
		RegistroFacturacionDTO resultado;
		cat.debug("Inicio:getCodigoDespacho()");
		resultado = registroFacturacionDAO.getCodigoDespacho(); 
		cat.debug("Fin:getCodigoDespacho()");
		return resultado;
	}//fin getCodigoDespacho

	/**
	 * Obtiene ciclo de facturacion calendario mas inmediato
	 * @param N/A
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public RegistroFacturacionDTO getCicloFacturacion() 
		throws CustomerDomainException
	{
		RegistroFacturacionDTO resultado;
		cat.debug("Inicio:getCicloFacturacion()");
		resultado = registroFacturacionDAO.getCicloFacturacion(); 
		cat.debug("Fin:getCicloFacturacion()");
		return resultado;		
	}//fin getCicloFacturacion
	
	/**
	 * Verifica si ciclo corresponde a un plan freedom
	 * @param entrada
	 * @return resultado
	 * @throws ProductDomainException
	 */
	public RegistroFacturacionDTO esCicloFredom(RegistroFacturacionDTO registroFacturacionDTO) 
		throws CustomerDomainException
	{
		RegistroFacturacionDTO resultado = null;
		cat.debug("Inicio:esCicloFredom()");
		resultado = registroFacturacionDAO.esCicloFredom(registroFacturacionDTO);
		cat.debug("Fin:esCicloFredom()");
		return resultado;	
	}//fin esCicloFredom
	
	/**
	 * Obtiene dias para realizar prorrateo de importe de plan tarifarios 
	 * tipo hibrido en icc_movimiento
	 * @param entrada
	 * @return resultado
	 * @throws ProductDomainException
	 */
	public RegistroFacturacionDTO getDiasProrrateo(RegistroFacturacionDTO registroFacturacionDTO) 
		throws CustomerDomainException
	{
		RegistroFacturacionDTO resultado = null;
		cat.debug("Inicio:getDiasProrrateo()");
		resultado = registroFacturacionDAO.getDiasProrrateo(registroFacturacionDTO);
		cat.debug("Fin:getDiasProrrateo()");
		return resultado;	
	}//fin getDiasProrrateo
	
	/**
	 * Aplica impuesto al importe del plan tarifario informado
	 * (solo planes tipo hibridos)
	 * @param entrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public RegistroFacturacionDTO aplicaImpuestoImporte(RegistroFacturacionDTO registroFacturacionDTO) 
		throws CustomerDomainException
	{
		RegistroFacturacionDTO resultado = null;
		cat.debug("Inicio:aplicaImpuestoImporte()");
		resultado = registroFacturacionDAO.aplicaImpuestoImporte(registroFacturacionDTO);
		cat.debug("Fin:aplicaImpuestoImporte()");
		return resultado;
	}//fin aplicaImpuestoImporte
	
	/**
	 * Aplica impuesto a concepto mayorista
	 * (solo planes tipo hibridos)
	 * @param entrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public RegistroFacturacionDTO aplicaImpuestoConceptoMayorista(RegistroFacturacionDTO registroFacturacionDTO) 
		throws CustomerDomainException
	{
		RegistroFacturacionDTO resultado = null;
		cat.debug("Inicio:aplicaImpuestoImporte()");
		resultado = registroFacturacionDAO.aplicaImpuestoConceptoMayorista(registroFacturacionDTO);
		cat.debug("Fin:aplicaImpuestoImporte()");
		return resultado;
	}//fin aplicaImpuestoImporte
	
	public ImpuestosDTO getImpuestoDesctoManual(ImpuestosDTO impuesto) 
		throws CustomerDomainException
	{
		ImpuestosDTO resultado = null;
		cat.debug("Inicio:getImpuestoDesctoManual()");
		resultado = registroFacturacionDAO.getImpuestoDesctoManual(impuesto);
		cat.debug("Fin:getImpuestoDesctoManual()");
		return resultado;
	}//fin getImpuestoDesctoManual
	
	public void atualizaIndFacturCargos(Long numVenta) 
		throws CustomerDomainException
	{
		cat.debug("Inicio:atualizaIndFacturCargos()");
		registroFacturacionDAO.atualizaIndFacturCargos(numVenta);
		cat.debug("Fin:atualizaIndFacturCargos()");		
	}//fin atualizaIndFacturCargos
	
	public FaConceptoDTO getFaConcepto(FaConceptoDTO faConceptoDTO)	throws CustomerDomainException{
			cat.debug("Inicio:getFaConcepto()");
			faConceptoDTO=	registroFacturacionDAO.getFaConcepto(faConceptoDTO);
			cat.debug("Fin:getFaConcepto()");	
			return faConceptoDTO;
		}
	
	public DetalleInformePresupuestoDTO[] obtenerDetallePresupuesto(Long numVenta)	throws CustomerDomainException{
		cat.debug("Inicio:obtenerDetallePresupuesto()");
		DetalleInformePresupuestoDTO[] resultado =	registroFacturacionDAO.obtenerDetallePresupuesto(numVenta);
		cat.debug("Fin:obtenerDetallePresupuesto()");	
		return resultado;	
	}
	//Inicio P-CSR-11002 JLGN 29-10-2011
	public String obtenerNombreFactura(long numVenta)throws CustomerDomainException{
		cat.debug("obtenerNombreFactura:Inicio");
		String resultado = registroFacturacionDAO.obtenerNombreFactura(numVenta);
		cat.debug("obtenerNombreFactura:Fin");
		return resultado;
	}
	//Fin P-CSR-11002 JLGN 29-10-2011

}//fin class RegistroFacturacion
