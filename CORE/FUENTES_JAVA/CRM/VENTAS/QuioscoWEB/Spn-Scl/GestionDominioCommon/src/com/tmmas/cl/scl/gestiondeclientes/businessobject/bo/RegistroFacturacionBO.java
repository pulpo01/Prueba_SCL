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

package com.tmmas.cl.scl.gestiondeclientes.businessobject.bo;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.gestiondeclientes.businessobject.dao.RegistroFacturacionDAO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ClienteDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.MensajeDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RegistroFacturacionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ImpuestosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosEjecucionFacturacionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ProcesoDTO;

public class RegistroFacturacionBO {
	
	private RegistroFacturacionDAO registroFacturacionDAO  = new RegistroFacturacionDAO();
	private Logger  cat= Logger.getLogger(RegistroFacturacionBO.class);
	
	/**
	 * Obtiene el codigo de Promedio facturado, según el monto promedio facturado por el cliente
	 * @param datos
	 * @return resultado
	 * @throws GeneralException
	 */
	public RegistroFacturacionDTO getCodigoPromedioFacturado(RegistroFacturacionDTO datos) throws GeneralException {
		cat.debug("getListadoTipoDocumento():start");
		RegistroFacturacionDTO resultado = registroFacturacionDAO.getCodigoPromedioFacturado(datos);
		cat.debug("getListadoTipoDocumento():end");
		return resultado;
	}
	
	/**
	 * Obtiene el codigo ciclo de facturación, en base al codigo ciclo del cliente.
	 * @param cliente
	 * @return resultado
	 * @throws GeneralException
	 */
	public RegistroFacturacionDTO getCodigoCicloFacturacion(ClienteDTO cliente) throws GeneralException {
		cat.debug("getCodigoCicloFacturacion():start");
		RegistroFacturacionDTO resultado = registroFacturacionDAO.getCodigoCicloFacturacion(cliente);
		cat.debug("getCodigoCicloFacturacion():end");
		return resultado;
	}
	
	/**
	 *Ejecuta prebilling
	 * @param entrada
	 * @return 
	 * @throws GeneralException
	 */

	public void ejecutaPrebilling(RegistroFacturacionDTO entrada) throws GeneralException{
		cat.debug("ejecutaPrebilling():start");
		registroFacturacionDAO.ejecutaPrebilling(entrada);
		cat.debug("ejecutaPrebilling():end");
	}
	
	/**
	 * Obtiene secuencia del paquete para agregar datos a tabla cargos
	 * @param parametroEntrada
	 * @return resultado
	 * @throws GeneralException
	 */
	
	public RegistroFacturacionDTO getSecuenciaProcesoFacturacion(RegistroFacturacionDTO parametroEntrada)
	throws GeneralException{
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
	 * @throws GeneralException
	 */
	public RegistroFacturacionDTO getModoGeneracion(RegistroFacturacionDTO registroFacturacion) 
	throws GeneralException{
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
	 * @throws GeneralException
	 */
	public ImpuestosDTO getDatosPresupuesto(ImpuestosDTO parametroEntrada) 
	throws GeneralException{
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
	 * @throws GeneralException
	 */
	public ProcesoDTO actualizaFacturacion(RegistroFacturacionDTO parametroEntrada) 
	throws GeneralException{
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
	 * @throws GeneralException
	 */
	public ImpuestosDTO[] getDetallePresupuesto(ImpuestosDTO parametroEntrada) throws GeneralException{
		
		cat.debug("Inicio:getDetallePresupuesto()");
		ImpuestosDTO[] resultado =registroFacturacionDAO.getDetallePresupuesto(parametroEntrada); 
		cat.debug("Fin:getDetallePresupuesto()");
		return resultado;
	}
	
	/**
	 * Obtiene detalle del presupuesto asociado a concpeto facturable.
	 * @param parametroEntrada
	 * @return resultado
	 * @throws GeneralException
	 */
	public ImpuestosDTO[] getDetallePresupuestoporConcepto(ImpuestosDTO parametroEntrada) throws GeneralException{
		
		cat.debug("Inicio:getDetallePresupuesto()");
		ImpuestosDTO[] resultado =registroFacturacionDAO.getDetallePresupuestoporConcepto(parametroEntrada); 
		cat.debug("Fin:getDetallePresupuesto()");
		return resultado;
	}

	/**
	 * Obtiene el valor del parametro que indica si se consume folio
	 * @param entrada
	 * @return resultado
	 * @throws GeneralException
	 */
	public RegistroFacturacionDTO getConsumeFolio() 
	throws GeneralException{
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
	 * @throws GeneralException
	 */
	public RegistroFacturacionDTO[] getListCiclosPostPago(RegistroFacturacionDTO entrada) 
	throws GeneralException{
		cat.debug("Inicio:getListCiclosPostPago()");
		RegistroFacturacionDTO[] resultado =registroFacturacionDAO.getListCiclosPostPago(entrada); 
		cat.debug("Fin:getListCiclosPostPago()");
		return resultado;
	}//getListCiclosPostPago

	/**
	 * Obtiene codigo de despacho
	 * @param N/A
	 * @return resultado
	 * @throws GeneralException
	 */
	public RegistroFacturacionDTO getCodigoDespacho() 
	throws GeneralException{
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
	 * @throws GeneralException
	 */
	public RegistroFacturacionDTO getCicloFacturacion() 
	throws GeneralException{
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
	throws GeneralException{
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
	throws GeneralException{
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
	 * @throws GeneralException
	 */
	public RegistroFacturacionDTO aplicaImpuestoImporte(RegistroFacturacionDTO registroFacturacionDTO) 
	throws GeneralException{
		RegistroFacturacionDTO resultado = null;
		cat.debug("Inicio:aplicaImpuestoImporte()");
		resultado = registroFacturacionDAO.aplicaImpuestoImporte(registroFacturacionDTO);
		cat.debug("Fin:aplicaImpuestoImporte()");
		return resultado;
	}//fin aplicaImpuestoImporte
	
	/**
	 * Guarda mensaje asociado a la facturacion
	 * @param entrada
	 * @return resultado
	 * @throws GeneralException
	 */
	public void guardarMensaje(MensajeDTO mensaje) 
		throws GeneralException
	{
		cat.debug("Inicio:guardarMensaje()");
		registroFacturacionDAO.guardarMensaje(mensaje);
		cat.debug("Fin:guardarMensaje()");		
	}//fin guardarMensaje
	
	/**
	 * Obtiene numero proceso facturacion
	 * @param entrada
	 * @return resultado
	 * @throws GeneralException
	 */
	public ParametrosEjecucionFacturacionDTO obtieneNroProceso(Long numVenta) 
		throws GeneralException
	{
		cat.debug("Inicio:obtieneNroProceso()");
		ParametrosEjecucionFacturacionDTO resultado = registroFacturacionDAO.obtieneNroProceso(numVenta);
		cat.debug("Fin:obtieneNroProceso()");
		return resultado;
	}//fin obtieneNroProceso	
	
	
	
}//fin class RegistroFacturacion
