package com.tmmas.cl.scl.portalventas.web.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.scl.commonbusinessentities.dto.DetalleCargosSolicitudDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.DetalleLineaSolicitudDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.DetallePrecioSolicitudDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CargoSolicitudDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ObtencionCargosDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosObtencionCargosDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.VentasException;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.BusquedaClienteDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.ClienteDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.ContratoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.FichaContratoPrestacionDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.ProrrateoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.RegistroFacturacionDTO;
import com.tmmas.cl.scl.portalventas.web.delegate.PortalVentasDelegate;
import com.tmmas.cl.scl.portalventas.web.dto.VentaAjaxDTO;
import com.tmmas.cl.scl.portalventas.web.form.EvaluacionSolicitudForm;
import com.tmmas.cl.scl.portalventas.web.helper.Global;
import com.tmmas.cl.scl.portalventas.web.helper.Utilidades;
import com.tmmas.cl.scl.productdomain.businessobject.dto.ServicioSuplementarioDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.SolicitudVentaDTO;

public class EvaluacionSolicitudAction extends DispatchAction {
	private final Logger logger = Logger.getLogger(EvaluacionSolicitudAction.class);
	private Global global = Global.getInstance();
	
	PortalVentasDelegate delegate = PortalVentasDelegate.getInstance();	
	
	public ActionForward inicio(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		logger.info("inicio, inicio");
		EvaluacionSolicitudForm evaluacionSolicitudForm = (EvaluacionSolicitudForm)form;
		
		HttpSession sesion = request.getSession(false);
		VentaAjaxDTO ventaSel = (VentaAjaxDTO)sesion.getAttribute("ventaSel");	
		
		SolicitudVentaDTO solicitudVentaDTO =  new SolicitudVentaDTO();
		solicitudVentaDTO.setIndEstado(ventaSel.getIndEstVenta());
		
		try {
		
			evaluacionSolicitudForm.setArrayEstadosSol(delegate.listarEstadosSolicitud(solicitudVentaDTO));
			
			//indica si permite cambio de estado en la evaluacion
			if (ventaSel.getIndEstVenta().equals(global.getValor("estado.venta.pendiente.formalizacion"))
				|| ventaSel.getIndEstVenta().equals(global.getValor("estado.venta.rechazado"))){
				evaluacionSolicitudForm.setFlagPermiteCambioEstado("0");
			}else{
				evaluacionSolicitudForm.setFlagPermiteCambioEstado("1");
			}
			
			//indica si es cliente empresa
			if (ventaSel.getCodTipoCliente().equals(global.getValor("tipo.cliente.empresa"))
					||ventaSel.getCodTipoCliente().equals(global.getValor("tipo.cliente.pyme"))){
				evaluacionSolicitudForm.setFlagClienteEmpresa("1");
			}
			
			evaluacionSolicitudForm.setCodEstadoNuevo("");
			//indica estado actual
			evaluacionSolicitudForm.setDesEstadoActual(ventaSel.getEstado());
			
			BusquedaClienteDTO paramBusquedaDTO = new BusquedaClienteDTO();
			paramBusquedaDTO.setCodCliente(ventaSel.getCodCliente());
			ClienteDTO[] listaClientes = delegate.getDatosCliente(paramBusquedaDTO);
				
			if (listaClientes != null) {
				final ClienteDTO clienteDTO = listaClientes[0];
				evaluacionSolicitudForm.setDesTipoIdentificacion(clienteDTO.getDescripcionTipoIdentificacion());
				evaluacionSolicitudForm.setNumIdentificacion(clienteDTO.getNumeroIdentificacion());
				final String nombreCompleto = Utilidades.concatenar(clienteDTO.getNombreCliente(), clienteDTO
						.getNombreApellido1(), clienteDTO.getNombreApellido2());
				evaluacionSolicitudForm.setNombreCompleto(nombreCompleto);
				evaluacionSolicitudForm.setMontoPreautorizado(String.valueOf(clienteDTO.getMontoPreAutorizado()));
				evaluacionSolicitudForm.setCalificacion(clienteDTO.getCodCalificacion());
				evaluacionSolicitudForm.setClasificacion(clienteDTO.getCodCrediticia());
				evaluacionSolicitudForm.setColor(clienteDTO.getDescripcionColor());
				evaluacionSolicitudForm.setSegmento(clienteDTO.getDescripcionSegmento());
				evaluacionSolicitudForm.setNombreEmpresa(clienteDTO.getDescripcionEmpresa());
				evaluacionSolicitudForm.setNumVenta(Long.parseLong(ventaSel.getNroVenta()));
			}
			
			//obtiene tipo de contrato
			ContratoDTO contratoDTO = new ContratoDTO();
			contratoDTO.setCodigoTipoContrato(ventaSel.getCodTipoContrato());
			contratoDTO = delegate.getTipoContrato(contratoDTO);
			evaluacionSolicitudForm.setDesTipoContrato(contratoDTO.getDescripcionTipoContrato());
			
			//obtiene datos de lineas
			FichaContratoPrestacionDTO fichaContratoPrestacionDTO = new FichaContratoPrestacionDTO();
			fichaContratoPrestacionDTO = delegate.obtenerDatosContratoPrestacion(new Long(ventaSel.getNroVenta()));
			
			//Al cambiar el flujo de la venta al momento de la solucitud los cargos aun no se 
			//encuentran registrados en la tabla de presupuesto por lo que deben ser sacados desde la tabla de cargos		
			//DetalleInformePresupuestoDTO[] detalleCargos = delegate.obtenerDetallePresupuesto(new Long(ventaSel.getNroVenta()));
			
			CargoSolicitudDTO cargoSolicitud = new CargoSolicitudDTO();		
			cargoSolicitud.setNumVenta(Long.valueOf(ventaSel.getNroVenta()).longValue());
			cargoSolicitud.setCodOficina(ventaSel.getCodOficina());
	
			
			//Cargos inmediatos  (solicitid)
			CargoSolicitudDTO[]	 detalleCargos = delegate.getCargosSolicitud(cargoSolicitud);
			
			ParametrosObtencionCargosDTO parametros = new ParametrosObtencionCargosDTO();
			parametros.setNumeroVenta(ventaSel.getNroVenta());
			parametros.setCodigoCliente(ventaSel.getCodCliente());
			parametros.setNumeroCuotas(ventaSel.getCodCuota());
			parametros.setCodigoModalidadVenta(ventaSel.getCodModVenta());
			parametros.setTipoContrato(ventaSel.getCodTipoContrato());
			parametros.setCodigoVendedor(ventaSel.getCodVendedor());	
			parametros.setEsSolicitudVenta(false);
			parametros.setEsEvCrediticia(true);
			parametros.setEsOverride(false);
			
			//Cargos inmediatos adelantados (formalizacion), obtiene los asociado al cargo basico
			ObtencionCargosDTO detalleCargoBasico = delegate.getCargosSolicitudAdelantados(parametros);
			
			//Obtiene los cargos drecurrentes asociados a plan adicional / seguro en la solicitud
			CargoSolicitudDTO[]	 detalleCargosPA = delegate.getCargosPARecSolicitud(cargoSolicitud);
			
			//Obtiene los cargos que pasaron pro proceso de override en la solicitud
			DetalleCargosSolicitudDTO[] cargosOverrideBD = delegate.recuperaCargosOverride(Long.valueOf(ventaSel.getNroVenta()), 
					global.getValor("codigo.origen.transaccion.venta"));
			
			double aux0 = Math.pow(10,Integer.parseInt(global.getValor("decimales.bd")));
			
			//modalidad de pago		
			evaluacionSolicitudForm.setDesModalidadVenta(fichaContratoPrestacionDTO.getDesModVenta());
			ArrayList arrayLineas = new ArrayList();
			if (fichaContratoPrestacionDTO.getDetalle()!=null){
				for (int i=0;i<fichaContratoPrestacionDTO.getDetalle().length;i++){
					DetalleLineaSolicitudDTO detalleLinea = new DetalleLineaSolicitudDTO();
					detalleLinea.setNumAbonado(fichaContratoPrestacionDTO.getDetalle()[i].getNumAbonado());
					detalleLinea.setPlanTarifario(fichaContratoPrestacionDTO.getDetalle()[i].getPlanTarifario());
					detalleLinea.setDesEquipo(fichaContratoPrestacionDTO.getDetalle()[i].getDesEquipo());
					detalleLinea.setCodUso(fichaContratoPrestacionDTO.getDetalle()[i].getCodUso());
					
					
					//agrega cargos para abonado
					double totalCargos=0;
					double totalCargosRecurrentes=0;
					DetalleCargosSolicitudDTO[] detalleCargosAbonado = new DetalleCargosSolicitudDTO[0];
					DetalleCargosSolicitudDTO[] detalleCargosRecurrentes = new DetalleCargosSolicitudDTO[0];
					if (detalleCargos!=null)
					{
						ArrayList arrayCargosAbonado = new ArrayList();
						ArrayList arrayCargosRecurrentes = new ArrayList();
						for(int j=0;j<detalleCargos.length;j++)
						{
							if (detalleCargos[j].getNumAbonado()==detalleLinea.getNumAbonado()){
								DetalleCargosSolicitudDTO cargo = new DetalleCargosSolicitudDTO();
								cargo.setDesConcepto(detalleCargos[j].getDesConcepto());
						        cargo.setCargos( redondeaDecimal(detalleCargos[j].getImpCargo(), aux0 ) );		
								
								//Verifica si el cargo fue sobreescrito en la solicitud
								if (cargosOverrideBD != null && cargosOverrideBD.length > 0) {
									final Double importeOverride = buscarImporteOverride(cargosOverrideBD,
											detalleCargos[j].getNumAbonado(), detalleCargos[j].getCodConcepto());
									if (importeOverride != null)
										cargo.setCargos(importeOverride.doubleValue());
								}
								cargo.setDescuentos(detalleCargos[j].getMontoTotalDescuento());
								arrayCargosAbonado.add(cargo);
								totalCargos = totalCargos + cargo.getCargos() + cargo.getDescuentos();
							}
							
						}
						for(int j=0;j<detalleCargosPA.length;j++)
						{
							if (detalleCargosPA[j].getNumAbonado()==detalleLinea.getNumAbonado())
							{
								DetalleCargosSolicitudDTO cargo = new DetalleCargosSolicitudDTO();
								cargo.setDesConcepto(detalleCargosPA[j].getDesConcepto());
						        cargo.setCargos( redondeaDecimal(detalleCargosPA[j].getImpCargo(), aux0 ) );											
								
								//Verifica si el cargo fue sobreescrito en la solicitud
								if (cargosOverrideBD != null && cargosOverrideBD.length > 0) {
									final Double importeOverride = buscarImporteOverride(cargosOverrideBD,
											detalleCargosPA[j].getNumAbonado(), detalleCargosPA[j].getCodConcepto());
									if (importeOverride != null)
										cargo.setCargos(importeOverride.doubleValue());
								}
								cargo.setDescuentos(detalleCargosPA[j].getMontoTotalDescuento());
								arrayCargosRecurrentes.add(cargo);
								totalCargosRecurrentes = totalCargosRecurrentes + cargo.getCargos() + cargo.getDescuentos();
							}
							
						}
						
						for(int j=0;j<detalleCargoBasico.getCargos().length;j++)
						{
							if (detalleCargoBasico.getCargos()[j].getPrecio().getDatosAnexos().getNum_abonado().longValue()
									==detalleLinea.getNumAbonado())
							{
								DetalleCargosSolicitudDTO cargo = new DetalleCargosSolicitudDTO();
								DetalleCargosSolicitudDTO cargoRec = new DetalleCargosSolicitudDTO();
								
								cargoRec.setDesConcepto(detalleCargoBasico.getCargos()[j].getPrecio().getDescripcionConcepto());
								cargoRec.setCargos( redondeaDecimal(detalleCargoBasico.getCargos()[j].getPrecio().getMonto(), aux0 ) );
								
								if(detalleCargoBasico.getCargos()[j].getPrecio().getTipoCobro().trim().equals(
										global.getValor("tipo.cobro.adelantado")))
								{
									cargo.setDesConcepto(detalleCargoBasico.getCargos()[j].getPrecio().getDescripcionConcepto());
									cargo.setCargos( redondeaDecimal(detalleCargoBasico.getCargos()[j].getPrecio().getMonto(), aux0 ) );								
								}
								
								//Verifica si el cargo fue sobreescrito en la solicitud
								if (cargosOverrideBD != null && cargosOverrideBD.length > 0) {
									final Double importeOverride = buscarImporteOverride(cargosOverrideBD,
											detalleCargoBasico.getCargos()[j].getPrecio().getDatosAnexos()
													.getNum_abonado().longValue(), Long.valueOf(
													detalleCargoBasico.getCargos()[j].getPrecio().getCodigoConcepto())
													.longValue());
									if (importeOverride != null) {
										cargoRec.setCargos(importeOverride.doubleValue());
										if (detalleCargoBasico.getCargos()[j].getPrecio().getTipoCobro().trim().equals(
												global.getValor("tipo.cobro.adelantado"))) {
											cargo.setCargos(importeOverride.doubleValue());
										}
									}
								}
								
								//Los cargos adelantados deben aparecer en los cargos inmediatos con prorrateo 
								//y en los cargos recurrentes sin prorrateo
								arrayCargosRecurrentes.add(cargoRec);
								totalCargosRecurrentes = totalCargosRecurrentes + cargo.getCargos() + cargo.getDescuentos();
								if(detalleCargoBasico.getCargos()[j].getPrecio().getTipoCobro().trim().equals(
										global.getValor("tipo.cobro.adelantado")))
								{							
									//Prorrateo					
									ProrrateoDTO prorrateo = new ProrrateoDTO();
									prorrateo = this.getProrrateo(detalleLinea.getNumAbonado(), cargo.getCargos());
									cargo.setCargos( prorrateo.getImporte() );
									
									arrayCargosAbonado.add(cargo);
									totalCargos = totalCargos + cargo.getCargos() + cargo.getDescuentos();
								}
							}						
						}					
						
						//agrega ss para abonado
						ServicioSuplementarioDTO servicioSuplementarioDTO = new ServicioSuplementarioDTO();
						servicioSuplementarioDTO.setNumeroAbonado(String.valueOf(fichaContratoPrestacionDTO.getDetalle()[i].getNumAbonado()));
						servicioSuplementarioDTO.setCodigoProducto(global.getValor("codigo.producto"));
						servicioSuplementarioDTO.setCodigoPlanServicio(fichaContratoPrestacionDTO.getDetalle()[i].getCodPlanServ());
						String codActuacion = global.getValor("codigo.actuacion.movil.interna");
						if(detalleLinea.getCodUso()== Integer.valueOf(global.getValor("codigo.uso.hibrido")).intValue())
						{
							codActuacion = global.getValor("codigo.actuacion.hibrido");
						}else {
							codActuacion = (ventaSel.getNombreDealer()==null || ventaSel.getNombreDealer().equals(""))?global.getValor("codigo.actuacion.movil.interna"):global.getValor("codigo.actuacion.movil.externa");
						}
						servicioSuplementarioDTO.setCodigoActuacion(codActuacion);
						
						DetallePrecioSolicitudDTO[] detallePrecioSSAbonado = delegate.obtenerPrecioSSAbo(servicioSuplementarioDTO);
						
						//aplicar impuesto a ss
						if (detallePrecioSSAbonado!=null && detallePrecioSSAbonado.length>0)
						{
							for (int j=0; j<detallePrecioSSAbonado.length; j++)
							{
								RegistroFacturacionDTO registroFacturacionDTO= new RegistroFacturacionDTO();
								registroFacturacionDTO.setCodigoCliente(ventaSel.getCodCliente());
								registroFacturacionDTO.setCodigoOficina(ventaSel.getCodOficina());
								registroFacturacionDTO.setImportePlan(detallePrecioSSAbonado[j].getPrecio());
								registroFacturacionDTO.setCodigoConcepto(new Long(detallePrecioSSAbonado[j].getCodConcepto()));						
								detallePrecioSSAbonado[j].setPrecio(delegate.aplicaImpuestoImporte(registroFacturacionDTO).getImporteTotal());
								
								DetalleCargosSolicitudDTO cargoRec = new DetalleCargosSolicitudDTO();
								DetalleCargosSolicitudDTO cargo = new DetalleCargosSolicitudDTO();
								
								cargoRec.setDesConcepto(detallePrecioSSAbonado[j].getDesConcepto());
								cargoRec.setCargos( redondeaDecimal(detallePrecioSSAbonado[j].getPrecio(), aux0 ) );
						        
						        if(detallePrecioSSAbonado[j].getTipoCobro().trim().equals(global.getValor("tipo.cobro.adelantado")))
						        {
						        	cargo.setCargos(redondeaDecimal(detallePrecioSSAbonado[j].getPrecio(), aux0 ) );
						        	cargo.setDesConcepto(detallePrecioSSAbonado[j].getDesConcepto());
						        }
						        
						        //Verifica si el cargo fue sobreescrito en la solicitud
								if (cargosOverrideBD != null && cargosOverrideBD.length > 0) {
									final Double importeOverride = buscarImporteOverride(cargosOverrideBD, Long.valueOf(
											servicioSuplementarioDTO.getNumeroAbonado()).longValue(), Long.valueOf(
											detallePrecioSSAbonado[j].getCodConcepto()).longValue());
									if (importeOverride != null) {
										cargoRec.setCargos(importeOverride.doubleValue());
										if (detallePrecioSSAbonado[j].getTipoCobro().trim().equals(
												global.getValor("tipo.cobro.adelantado"))) {
											cargo.setCargos(importeOverride.doubleValue());
										}
									}
								}
								
								arrayCargosRecurrentes.add(cargoRec);
								totalCargosRecurrentes = totalCargosRecurrentes + cargo.getCargos() + cargo.getDescuentos();
								
								if(detallePrecioSSAbonado[j].getTipoCobro().trim().equals("A"))
								{
									//Prorrateo					
									ProrrateoDTO prorrateo = new ProrrateoDTO();
									prorrateo = this.getProrrateo(detalleLinea.getNumAbonado(), cargo.getCargos());
									cargo.setCargos(prorrateo.getImporte());
									
									arrayCargosAbonado.add(cargo);
									totalCargos = totalCargos + cargo.getCargos() + cargo.getDescuentos();						
								}
								
							}
						}
						
						detalleCargosAbonado = (DetalleCargosSolicitudDTO[]) 
						ArrayUtl.copiaArregloTipoEspecifico(arrayCargosAbonado.toArray(), DetalleCargosSolicitudDTO.class);
						
						detalleCargosRecurrentes = (DetalleCargosSolicitudDTO[]) 
						ArrayUtl.copiaArregloTipoEspecifico(arrayCargosRecurrentes.toArray(), DetalleCargosSolicitudDTO.class);
					}
					
					//total de cargos
			        detalleLinea.setMontoTotal( redondeaDecimal(totalCargos, aux0 ) );				
					
					detalleLinea.setCargos(detalleCargosAbonado);
					detalleLinea.setCargosRecurrentes(detalleCargosRecurrentes);
					arrayLineas.add(detalleLinea);
				}//fin for
			}//fin if fichaContratoPrestacionDTO
			DetalleLineaSolicitudDTO[] arrayLineasSol =(DetalleLineaSolicitudDTO[]) 
				ArrayUtl.copiaArregloTipoEspecifico(arrayLineas.toArray(), DetalleLineaSolicitudDTO.class);
			
			evaluacionSolicitudForm.setArrayLineasSol(arrayLineasSol);
			
		}catch(VentasException e){
	     	String mensaje = e.getDescripcionEvento()==null?"Ocurrio un error al actualizar estado ":e.getDescripcionEvento(); 
	     	request.setAttribute("mensajeError", mensaje );	  
	     	logger.debug("[VentasException] "+mensaje);
	     	return mapping.findForward("inicio");
		}catch(Exception e){
	     	String mensaje = e.getMessage()==null?"Ocurrio un error al actualizar estado ":e.getMessage(); 
	     	request.setAttribute("mensajeError", mensaje );
	     	logger.debug("[Exception]"+mensaje);
	     	return mapping.findForward("inicio");
	    }		
		logger.info("inicio, fin");		
		return mapping.findForward("inicio");
	}
	
	public ActionForward aceptar(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		logger.info("aceptar, inicio");
		EvaluacionSolicitudForm evaluacionSolicitudForm = (EvaluacionSolicitudForm)form;
		HttpSession sesion = request.getSession(false);
		VentaAjaxDTO ventaSel = (VentaAjaxDTO)sesion.getAttribute("ventaSel");		
		
		try{
			SolicitudVentaDTO solicitudVentaDTO = new SolicitudVentaDTO();
			solicitudVentaDTO.setNumVenta(Long.parseLong(ventaSel.getNroVenta()));
			solicitudVentaDTO.setIndEstado(evaluacionSolicitudForm.getCodEstadoNuevo());
			delegate.actualizaSolVentaEval(solicitudVentaDTO);
			//Si estado de la evaluacion es rechazada se cambia el estado de venta (RZ), abonado (RSV) y se liberan las series y numeros 
			if(evaluacionSolicitudForm.getCodEstadoNuevo().trim().equals(global.getValor("estado.venta.rechazado")))
			{
				delegate.liberarSeriesYTelefono(new Long(ventaSel.getNroVenta()));
				return mapping.findForward("rechazar");
			}
			
		}catch(VentasException e){
	     	String mensaje = e.getDescripcionEvento()==null?"Ocurrio un error al actualizar estado ":e.getDescripcionEvento(); 
	     	request.setAttribute("mensajeError", mensaje );	  
	     	logger.debug("[VentasException] "+mensaje);
	     	return mapping.findForward("inicio");
		}catch(Exception e){
	     	String mensaje = e.getMessage()==null?"Ocurrio un error al actualizar estado ":e.getMessage(); 
	     	request.setAttribute("mensajeError", mensaje );
	     	logger.debug("[Exception]"+mensaje);
	     	return mapping.findForward("inicio");
	    }
		
		ventaSel.setIndEstVenta(evaluacionSolicitudForm.getCodEstadoNuevo());
		ventaSel.setEstado(evaluacionSolicitudForm.getDesEstadoNuevo());
		logger.info("aceptar, fin");		
		return mapping.findForward("aceptar");
	}
	
	public ActionForward cancelar(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		logger.info("cancelar, inicio");
		logger.info("cancelar, fin");		
		return mapping.findForward("cancelar");
	}
	
	
	/**
	 * Busca un valor de importe sobreescrito en el arreglo dado
	 * @author JIB
	 * @param cargos
	 * @param dto
	 * @return el valor de importe sobreescrito
	 */
	private Double buscarImporteOverride(DetalleCargosSolicitudDTO[] cargosOverride, long numAbonado, long codConcepto) 
	{
		logger.info("buscarImporteOverride, Inicio");
		Double toReturn = null;
		logger.trace("Num. abonado(): " + numAbonado );		
		logger.trace("Cod. concepto(): " + codConcepto);
		logger.trace("Tipo servicio: " + codConcepto);
		
		for (int i = 0; i < cargosOverride.length; i++) {
			DetalleCargosSolicitudDTO item = cargosOverride[i];			
			logger.trace("cargo[" + i + "].getNumAbonado(): " + item.getNumAbonado());			
			logger.trace("cargo[" + i + "].getCodConcepto(): " + item.getCodConcepto());
			boolean encontrado = item.getNumAbonado() == numAbonado;			
			encontrado = encontrado && item.getCodConcepto() ==codConcepto;

			if (encontrado) {
				toReturn = item.getImporteOverride();
				break;
			}
		}
		logger.debug("Valor de retorno: " + toReturn);
		logger.info("buscarImporteOverride, Fin");
		return toReturn;
	}
	
	private ProrrateoDTO getProrrateo(long numAbonado, double importe)
	  throws VentasException
	{
		ProrrateoDTO prorrateo = new ProrrateoDTO();
		prorrateo.setNumAbonado(numAbonado);
		prorrateo.setImporte(importe);
		prorrateo = delegate.getProrrateo(prorrateo);
		return prorrateo;
	}
	
	private double redondeaDecimal(double importeCargo, double aux0 )
	{
		double aux = importeCargo * aux0;
        float tmp = (float) aux;
        return (tmp / aux0);
	}
	
}
