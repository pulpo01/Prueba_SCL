package com.tmmas.cl.scl.portalventas.web.action;

import java.text.NumberFormat;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Locale;

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
import com.tmmas.cl.scl.commonbusinessentities.dto.ParametrosGlobalesDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CargoSolicitudDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ObtencionCargosDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosObtencionCargosDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.VentasException;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.BusquedaClienteDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.ClienteDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.ContratoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.DetalleFichaContratoPrestacionDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.FichaContratoPrestacionDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.RegistroFacturacionDTO;
import com.tmmas.cl.scl.portalventas.web.delegate.PortalVentasDelegate;
import com.tmmas.cl.scl.portalventas.web.dto.VentaAjaxDTO;
import com.tmmas.cl.scl.portalventas.web.form.OverrideSolicitudForm;
import com.tmmas.cl.scl.portalventas.web.helper.Global;
import com.tmmas.cl.scl.portalventas.web.helper.Utilidades;
import com.tmmas.cl.scl.productdomain.businessobject.dto.ServicioSuplementarioDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.SolicitudVentaDTO;

public class OverrideSolicitudAction extends DispatchAction {
	
	private static final String NOMBRE_LOCALE_SESION = "Locale-PortalVentas";

	NumberFormat numberFormat = NumberFormat.getInstance(); // Valor por defecto

	private final Logger logger = Logger.getLogger(OverrideSolicitudAction.class);

	private Global global = Global.getInstance();

	PortalVentasDelegate delegate = PortalVentasDelegate.getInstance();

	public ActionForward inicioOverrideSolicitud(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("inicioOverrideSolicitud, inicio");
		final String codModuloOrigen = global.getValor("modulo.web.override.solicitud.venta");
		inicializar(mapping, form, request, response, codModuloOrigen);
		logger.info("inicioOverrideSolicitud, fin");
		return mapping.findForward("inicioOverride");
	}

	public ActionForward inicioOverrideFormalizacion(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.info("inicioOverrideFormalizacion, inicio");
		final String codModuloOrigen = global.getValor("modulo.web.override.formalizacion.venta");
		inicializar(mapping, form, request, response, codModuloOrigen);
		logger.info("inicioOverrideFormalizacion, fin");
		return mapping.findForward("inicioOverride");
	}

	private final void inicializar(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response, String codModuloOrigen) throws Exception {
		logger.info("inicializar, Inicio");
		String codOperadora = ((ParametrosGlobalesDTO) request.getSession(false).getAttribute("paramGlobal"))
				.getCodOperadora().trim();
		logger.debug("codOperadora [" + codOperadora + "]");
		if (request.getSession().getAttribute(NOMBRE_LOCALE_SESION) != null) {
			Locale locale = (Locale) request.getSession().getAttribute(NOMBRE_LOCALE_SESION);
			logger.debug("locale.getDisplayCountry() [" + locale.getDisplayCountry() + "]");
			numberFormat = NumberFormat.getInstance(locale);
			logger.debug("numberFormat.toString() [" + numberFormat.toString() + "]");
		}
		else {
			logger.debug(NOMBRE_LOCALE_SESION + " en Session [null]");
			logger.debug("Se utiliza numberFormat por defecto [" + numberFormat.toString() + "]");
		}
		OverrideSolicitudForm f = (OverrideSolicitudForm) form;
		f.setCodModuloOrigen(codModuloOrigen);
		HttpSession sesion = request.getSession(false);
		final VentaAjaxDTO ventaSel = (VentaAjaxDTO) sesion.getAttribute("ventaSel");
		final String codOrigenTransVenta = global.getValor("codigo.origen.transaccion.venta");
		String titulo = null;
		if (codModuloOrigen.equals(global.getValor("modulo.web.override.solicitud.venta"))) {
			logger.debug("codModuloOrigen [" + codModuloOrigen + "] -> Solicitud");
			titulo = global.getValor("modulo.web.override.solicitud.venta.nombre");
		}
		else if (codModuloOrigen.equals(global.getValor("modulo.web.override.formalizacion.venta"))) {
			logger.debug("codModuloOrigen [" + codModuloOrigen + "] -> Formalización");
			titulo = global.getValor("modulo.web.override.formalizacion.venta.nombre");
		}
		f.setTitulo(titulo);
		
		try {

			final Long numVenta = new Long(ventaSel.getNroVenta());
			f.setNumVenta(numVenta.longValue());
			final String codTipoSolicitudNormal = global.getValor("codigo.tipo.solicitud.normal").trim();
			DetalleCargosSolicitudDTO[] cargosOverrideEnBD = delegate.recuperaCargosOverride(numVenta, codOrigenTransVenta);
			final int cantidadCargosOverride = cargosOverrideEnBD != null ? cargosOverrideEnBD.length : 0;
	
			logger.debug("cantidadCargosOverride [" + cantidadCargosOverride + "]");
			boolean aplicaOverrideSolicitud = false;
			boolean aplicaOverrideFormalizacion = false;
	
			if (cantidadCargosOverride == 0) {
				if (codOperadora.equals(global.getValor("codigo.operadora.guatemala"))) {
					if (codModuloOrigen.equals(global.getValor("modulo.web.override.solicitud.venta"))) {
						aplicaOverrideSolicitud = false;
					}
					else if (codModuloOrigen.equals(global.getValor("modulo.web.override.formalizacion.venta"))) {
						aplicaOverrideFormalizacion = true;
					}
				}
				else if (codOperadora.equals(global.getValor("codigo.operadora.salvador"))) {
					boolean esVentaNormal = false;
					if (!Utilidades.emptyOrNull(ventaSel.getCodTipoSolicitud())) {
						final String codTipoSolicitudVenta = ventaSel.getCodTipoSolicitud().trim();
						esVentaNormal = codTipoSolicitudVenta.equals(codTipoSolicitudNormal);
					}
					logger.debug("esVentaNormal [" + esVentaNormal + "]");
					if (codModuloOrigen.equals(global.getValor("modulo.web.override.solicitud.venta"))) {
						aplicaOverrideSolicitud = esVentaNormal;
					}
					else if (codModuloOrigen.equals(global.getValor("modulo.web.override.formalizacion.venta"))) {
						aplicaOverrideFormalizacion = !esVentaNormal;
					}
				}
				f.setMensajeError(null);
			}
			else {
				f.setMensajeError(global.getValor("mensaje.venta.tiene.override"));
			}
			logger.debug("aplicaOverrideSolicitud [" + aplicaOverrideSolicitud + "]");
			logger.debug("aplicaOverrideFormalizacion [" + aplicaOverrideFormalizacion + "]");
			f.setAplicaOverrideFormalizacion(aplicaOverrideFormalizacion);
			f.setAplicaOverrideSolicitud(aplicaOverrideSolicitud);
			final boolean activarOverride = aplicaOverrideSolicitud || aplicaOverrideFormalizacion;
			logger.debug("activarOverride [" + activarOverride + "]");
			f.setActivarOverride(activarOverride);
	
			SolicitudVentaDTO solicitudVentaDTO = new SolicitudVentaDTO();
			solicitudVentaDTO.setIndEstado(ventaSel.getIndEstVenta());
			BusquedaClienteDTO paramBusquedaDTO = new BusquedaClienteDTO();
			paramBusquedaDTO.setCodCliente(ventaSel.getCodCliente());
			ClienteDTO[] listaClientes = delegate.getDatosCliente(paramBusquedaDTO);
	
			if (listaClientes != null) {
				f.setDesTipoIdentificacion(listaClientes[0].getDescripcionTipoIdentificacion());
				f.setNumIdentificacion(listaClientes[0].getNumeroIdentificacion());
				f.setNombreCompleto(ventaSel.getNombreCliente());
				f.setMontoPreautorizado(String.valueOf(listaClientes[0].getMontoPreAutorizado()));
				f.setCalificacion(listaClientes[0].getCodCalificacion());
				f.setClasificacion(listaClientes[0].getCodCrediticia());
				f.setColor(listaClientes[0].getDescripcionColor());
				f.setSegmento(listaClientes[0].getDescripcionSegmento());
				f.setNombreEmpresa(listaClientes[0].getDescripcionEmpresa());
			}
	
			// obtiene tipo de contrato
			ContratoDTO contratoDTO = new ContratoDTO();
			contratoDTO.setCodigoTipoContrato(ventaSel.getCodTipoContrato());
			contratoDTO = delegate.getTipoContrato(contratoDTO);
			f.setDesTipoContrato(contratoDTO.getDescripcionTipoContrato());
	
			// obtiene datos de lineas
			FichaContratoPrestacionDTO fichaContratoPrestacionDTO = new FichaContratoPrestacionDTO();
			fichaContratoPrestacionDTO = delegate.obtenerDatosContratoPrestacion(new Long(ventaSel.getNroVenta()));
	
			final DetalleFichaContratoPrestacionDTO[] detalle = fichaContratoPrestacionDTO.getDetalle();
			logger.trace("detalle.length: " + detalle.length);
	
			CargoSolicitudDTO cargoSolicitud = new CargoSolicitudDTO();
			cargoSolicitud.setNumVenta(Long.valueOf(ventaSel.getNroVenta()).longValue());
			cargoSolicitud.setCodOficina(ventaSel.getCodOficina());
	
			ParametrosObtencionCargosDTO parametros = new ParametrosObtencionCargosDTO();
			parametros.setNumeroVenta(ventaSel.getNroVenta());
			parametros.setCodigoCliente(ventaSel.getCodCliente());
			parametros.setNumeroCuotas(ventaSel.getCodCuota());
			parametros.setCodigoModalidadVenta(ventaSel.getCodModVenta());
			parametros.setTipoContrato(ventaSel.getCodTipoContrato());
			parametros.setCodigoVendedor(ventaSel.getCodVendedor());
			parametros.setEsSolicitudVenta(false);
			parametros.setEsEvCrediticia(false);
			parametros.setEsOverride(true);
	
			// Cargos inmediatos adelantados (formalizacion), obtiene los asociado al cargo basico
			ObtencionCargosDTO detalleCargosAdelantados = delegate.getCargosSolicitudAdelantados(parametros);
	
			// Obtiene los cargos recurrentes asociados a plan adicional / seguro en la solicitud
			CargoSolicitudDTO[] detalleCargosPA = delegate.getCargosPARecSolicitud(cargoSolicitud);
	
			ParametrosGlobalesDTO parametrosGlobalesDTO = (ParametrosGlobalesDTO) sesion.getAttribute("paramGlobal");
			String nomUsuarioOra = parametrosGlobalesDTO.getCodUsuario();
	
			// modalidad de pago
			f.setDesModalidadVenta(fichaContratoPrestacionDTO.getDesModVenta());
			ArrayList arrayLineas = new ArrayList();
			if (detalle != null) {
				int correlativo = 0;
				for (int i = 0; i < detalle.length; i++) {
					DetalleLineaSolicitudDTO detalleLinea = new DetalleLineaSolicitudDTO();
					detalleLinea.setNumAbonado(detalle[i].getNumAbonado());
					detalleLinea.setPlanTarifario(detalle[i].getPlanTarifario());
					detalleLinea.setDesEquipo(detalle[i].getDesEquipo());
					detalleLinea.setCodUso(detalle[i].getCodUso());
					
					//Incidencia 144923 -- Mostrar num_celular en formalizacion de E1 - JIB
					detalleLinea.setNumCelular(detalle[i].getNumCelular());
	
					// agrega cargos para abonado
					double totalCargos = 0;
					double totalCargosRecurrentes = 0;
					DetalleCargosSolicitudDTO[] detalleCargosRecurrentes = new DetalleCargosSolicitudDTO[0];
					ArrayList arrayCargosRecurrentes = new ArrayList();
	
					for (int j = 0; j < detalleCargosPA.length; j++) {
						if (detalleCargosPA[j].getNumAbonado() == detalleLinea.getNumAbonado()) {
							DetalleCargosSolicitudDTO cargo = new DetalleCargosSolicitudDTO();
							cargo.setDesConcepto(detalleCargosPA[j].getDesConcepto());
							cargo.setCargos(detalleCargosPA[j].getImpCargo());
							cargo.setCodOrigenTransaccion(codOrigenTransVenta);
							cargo.setTipoServicio(global.getValor("tipo.servicio.planadicional"));
							correlativo += 1;
							cargo.setCorrelativoCargo(correlativo);
							cargo.setCodCliente(Long.valueOf(ventaSel.getCodCliente()).longValue());
							cargo.setNumAbonado(detalleLinea.getNumAbonado());
							cargo.setNumVenta(Long.valueOf(ventaSel.getNroVenta()).longValue());
							cargo.setNomUsuarora(nomUsuarioOra);
							cargo.setCodMoneda(detalleCargosPA[j].getCodMoneda());
							cargo.setDesMoneda(detalleCargosPA[j].getDesMoneda());
							cargo.setCodProductoContratado(detalleCargosPA[j].getCodProductoContratado());
							cargo.setCodCargoContratado(detalleCargosPA[j].getCodCargoContratado());
							cargo.setCodConcepto(detalleCargosPA[j].getCodConcepto());
							arrayCargosRecurrentes.add(cargo);
							totalCargosRecurrentes = totalCargosRecurrentes + cargo.getCargos();
						}
					}
	
					for (int j = 0; j < detalleCargosAdelantados.getCargos().length; j++) {
						if (detalleCargosAdelantados.getCargos()[j].getPrecio().getDatosAnexos().getNum_abonado()
								.longValue() == detalleLinea.getNumAbonado()) {
							DetalleCargosSolicitudDTO cargo = new DetalleCargosSolicitudDTO();
							cargo.setDesConcepto(detalleCargosAdelantados.getCargos()[j].getPrecio()
									.getDescripcionConcepto());
							cargo.setCargos(detalleCargosAdelantados.getCargos()[j].getPrecio().getMonto());
							cargo.setTipoServicio(global.getValor("tipo.servicio.cargobasico"));
							cargo.setCodOrigenTransaccion(codOrigenTransVenta);
							correlativo += 1;
							cargo.setCorrelativoCargo(correlativo);
							cargo.setCodCliente(Long.valueOf(ventaSel.getCodCliente()).longValue());
							cargo.setNumAbonado(detalleLinea.getNumAbonado());
							cargo.setNumVenta(Long.valueOf(ventaSel.getNroVenta()).longValue());
							cargo.setNomUsuarora(nomUsuarioOra);
							cargo.setCodMoneda(detalleCargosAdelantados.getCargos()[j].getPrecio().getUnidad().getCodigo());
							cargo.setDesMoneda(detalleCargosAdelantados.getCargos()[j].getPrecio().getUnidad()
									.getDescripcion());
							cargo.setCodPlantarif(detalleLinea.getPlanTarifario().split("\\(")[1].split("\\)")[0]);
							cargo.setCodConcepto(Long.valueOf(
									detalleCargosAdelantados.getCargos()[j].getPrecio().getCodigoConcepto()).longValue());
							arrayCargosRecurrentes.add(cargo);
							totalCargos = totalCargos + cargo.getCargos();
						}
					}
	
					// agrega ss para abonado
					ServicioSuplementarioDTO servicioSuplementarioDTO = new ServicioSuplementarioDTO();
					servicioSuplementarioDTO.setNumeroAbonado(String.valueOf(detalle[i].getNumAbonado()));
					servicioSuplementarioDTO.setCodigoProducto(global.getValor("codigo.producto"));
					servicioSuplementarioDTO.setCodigoPlanServicio(detalle[i].getCodPlanServ());
							
					String codActuacion = global.getValor("codigo.actuacion.movil.interna");		
					if(detalleLinea.getCodUso()== Integer.valueOf(global.getValor("codigo.uso.hibrido")).intValue())
					{
						codActuacion = global.getValor("codigo.actuacion.hibrido");
					}else {
						codActuacion = (ventaSel.getNombreDealer()==null || ventaSel.getNombreDealer().equals(""))?global.getValor("codigo.actuacion.movil.interna"):global.getValor("codigo.actuacion.movil.externa");
					}
					servicioSuplementarioDTO.setCodigoActuacion(codActuacion);				
					DetallePrecioSolicitudDTO[] detallePrecioSSAbonado = delegate.obtenerPrecioSSAbo(servicioSuplementarioDTO);
	
					// aplicar impuesto a ss
					if (detallePrecioSSAbonado != null && detallePrecioSSAbonado.length > 0) {
						for (int j = 0; j < detallePrecioSSAbonado.length; j++) {
							RegistroFacturacionDTO registroFacturacionDTO = new RegistroFacturacionDTO();
							registroFacturacionDTO.setCodigoCliente(ventaSel.getCodCliente());
							registroFacturacionDTO.setCodigoOficina(ventaSel.getCodOficina());
							registroFacturacionDTO.setImportePlan(detallePrecioSSAbonado[j].getPrecio());
							registroFacturacionDTO.setCodigoConcepto(new Long(detallePrecioSSAbonado[j].getCodConcepto()));
							detallePrecioSSAbonado[j].setPrecio(delegate.aplicaImpuestoImporte(registroFacturacionDTO)
									.getImporteTotal());
	
							DetalleCargosSolicitudDTO cargo = new DetalleCargosSolicitudDTO();
							cargo.setDesConcepto(detallePrecioSSAbonado[j].getDesConcepto());
							cargo.setCargos(detallePrecioSSAbonado[j].getPrecio());
							cargo.setTipoServicio(global.getValor("tipo.servicio.ss"));
							cargo.setCodOrigenTransaccion(codOrigenTransVenta);
							correlativo += 1;
							cargo.setCorrelativoCargo(correlativo);
							cargo.setCodCliente(Long.valueOf(ventaSel.getCodCliente()).longValue());
							cargo.setNumAbonado(detalleLinea.getNumAbonado());
							cargo.setNumVenta(Long.valueOf(ventaSel.getNroVenta()).longValue());
							cargo.setNomUsuarora(nomUsuarioOra);
							cargo.setCodMoneda(detallePrecioSSAbonado[j].getCodMoneda());
							cargo.setDesMoneda(detallePrecioSSAbonado[j].getDesMoneda());
							cargo.setCodServicio(detallePrecioSSAbonado[j].getCodigoServicio());
							// cargo.setCodServicio(servicioSuplementarioDTO.getCodigoPlanServicio());
							logger.trace("cargo.getDesConcepto(): " + cargo.getDesConcepto());
							logger.trace("cargo.getCodServicio(): " + cargo.getCodServicio());
	
							cargo.setCodConcepto(Long.valueOf(detallePrecioSSAbonado[j].getCodConcepto()).longValue());
							arrayCargosRecurrentes.add(cargo);
							totalCargos = totalCargos + cargo.getCargos();
						}
					}
	
					detalleCargosRecurrentes = (DetalleCargosSolicitudDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
							arrayCargosRecurrentes.toArray(), DetalleCargosSolicitudDTO.class);
	
					if (cantidadCargosOverride > 0) {
						for (int j = 0; j < detalleCargosRecurrentes.length; j++) {
							DetalleCargosSolicitudDTO dto = detalleCargosRecurrentes[j];
							final Double importeOverride = buscarImporteOverride(cargosOverrideEnBD, dto);
							dto.setImporteOverride(importeOverride);
						}
					}
	
					// total de cargos
					detalleLinea.setMontoTotal(totalCargos);
					detalleLinea.setCargosRecurrentes(detalleCargosRecurrentes);
					int nCargosRec = detalleLinea.getCargosRecurrentes().length;
					logger.debug("detalleLinea.getCargosRecurrentes().length:" + nCargosRec);
					arrayLineas.add(detalleLinea);
				}// fin for
			}// fin if fichaContratoPrestacionDTO
			DetalleLineaSolicitudDTO[] arrayLineasSol = (DetalleLineaSolicitudDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					arrayLineas.toArray(), DetalleLineaSolicitudDTO.class);

			f.setArrayLineasSol(arrayLineasSol);
		
		}catch(VentasException e){
	     	String mensaje = e.getDescripcionEvento()==null?"Ocurrio un error al actualizar estado ":e.getDescripcionEvento(); 
	     	request.setAttribute("mensajeError", mensaje );	  
	     	logger.debug("[VentasException] "+mensaje);	     	
		}catch(Exception e){
	     	String mensaje = e.getMessage()==null?"Ocurrio un error al actualizar estado ":e.getMessage(); 
	     	request.setAttribute("mensajeError", mensaje );
	     	logger.debug("[Exception]"+mensaje);	     	
	    }
		logger.info("inicializar, fin");
	}

	/**
	 * Busca un valor de importe sobreescrito en el arreglo dado
	 * 
	 * @author JIB
	 * @param cargos
	 * @param dto
	 * @return el valor de importe sobreescrito
	 */
	private Double buscarImporteOverride(DetalleCargosSolicitudDTO[] cargos, DetalleCargosSolicitudDTO dto) {
		logger.info("buscarImporteOverride, Inicio");
		Double toReturn = null;
		logger.trace("dto.getNumAbonado(): " + dto.getNumAbonado());
		logger.trace("dto.getCodConcepto(): " + dto.getCodConcepto());
		for (int i = 0; i < cargos.length; i++) {
			DetalleCargosSolicitudDTO item = cargos[i];
			logger.trace("cargo[" + i + "].getNumAbonado(): " + item.getNumAbonado());
			logger.trace("cargo[" + i + "].getCodConcepto(): " + item.getCodConcepto());
			boolean encontrado = item.getNumAbonado() == dto.getNumAbonado();
			encontrado = encontrado && item.getCodConcepto() == dto.getCodConcepto();

			if (encontrado) {
				toReturn = item.getImporteOverride();
				break;
			}
		}
		logger.debug("Valor de retorno: " + toReturn);
		logger.info("buscarImporteOverride, Fin");
		return toReturn;
	}

	/**
	 * @param form
	 * @return
	 */
	private boolean recuperarValoresOverrideDesdePagina(OverrideSolicitudForm form) {
		logger.info("recuperarValoresOverrideDesdePagina, Inicio");
		String stringValoresOverride = form.getValoresOverrideTabla().trim();
		logger.debug("stringValoresOverride: " + stringValoresOverride);
		if (stringValoresOverride == null || stringValoresOverride.equals("")) {
			logger.debug("No existen valores para override en página.");
			logger.debug("recuperarValoresOverrideDesdePagina, Fin");
			return false;
		}
		String[] valoresOverrideEnPagina = stringValoresOverride.split("-");
		DetalleLineaSolicitudDTO[] lineas = form.getArrayLineasSol();
		for (int i = 0; i < lineas.length; i++) {
			DetalleLineaSolicitudDTO linea = lineas[i];
			for (int j = 0; j < valoresOverrideEnPagina.length; j++) {
				String valorOverride = valoresOverrideEnPagina[j];
				logger.debug("valoresOverrideEnPagina [" + j + "]: " + valorOverride);
				String[] detalleOverride = valorOverride.split(";");
				long numAbonadoOverride = new Long(detalleOverride[0]).longValue();
				logger.debug("numAbonado: " + numAbonadoOverride);
				if (linea.getNumAbonado() == numAbonadoOverride) {
					DetalleCargosSolicitudDTO[] cargos = linea.getCargosRecurrentes();
					for (int k = 0; k < cargos.length; k++) {
						DetalleCargosSolicitudDTO cargo = cargos[k];
						for (int l = 1; l < detalleOverride.length; l++) {
							if (l % 2 == 1) {
								if (cargo.getCorrelativoCargo() == new Integer(detalleOverride[l]).intValue()) {
									logger.debug("cargo.getCorrelativoCargo() [" + cargo.getCorrelativoCargo() + "]");
									try {
										String valorCargo = detalleOverride[l + 1];
										logger.debug("valorCargo [" + valorCargo + "]");
										Double x = new Double(0);
										if (valorCargo != null && !valorCargo.equals("")) {
											Object parsed = numberFormat.parseObject(valorCargo);
											logger.debug("despues de parseObject [" + parsed + "]");
											x = new Double(parsed.toString());
										}
										else {
											throw new Exception("No se pudo convertir a Double [" + valorCargo + "]");
										}
										cargo.setImporteOverride(x);
									}
									catch (ParseException e) {
										logger.error("Error al obtener los valores del override");
										logger.error(e.getMessage());
									}
									catch (Exception e) {
										logger.error("Error al obtener los valores del override");
										logger.error(e.getMessage());
									}
								}
							}
						}
					}
				}
			}
		}
		logger.info("recuperarValoresOverrideDesdePagina, Fin");
		return true;
	}

	public ActionForward aceptar(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("aceptar, Inicio");
		OverrideSolicitudForm overrideSolicitudForm = (OverrideSolicitudForm) form;
		if (recuperarValoresOverrideDesdePagina(overrideSolicitudForm)) {
			try {
				delegate.insertaCargosOverride(overrideSolicitudForm.getArrayLineasSol());
			}
			catch (VentasException e) {
				String mensaje = e.getDescripcionEvento() == null ? "Ocurrio un error al generar el override " : e
						.getDescripcionEvento();
				request.setAttribute("mensajeError", mensaje);
				logger.debug("[VentasException] " + mensaje);
				return mapping.findForward("inicio");
			}
			catch (Exception e) {
				String mensaje = e.getMessage() == null ? "Ocurrio un error al generar el override " : e.getMessage();
				request.setAttribute("mensajeError", mensaje);
				logger.debug("[Exception]" + mensaje);
				return mapping.findForward("inicio");
			}
		}
		logger.info("aceptar, Fin");
		final ActionForward forward = mapping.findForward("cancelar");
		return forward;
	}

	public ActionForward continuarACargos(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("continuarACargos, Inicio");
		OverrideSolicitudForm f = (OverrideSolicitudForm) form;
		final DetalleLineaSolicitudDTO[] arrayLineasSol = f.getArrayLineasSol();
		if (recuperarValoresOverrideDesdePagina(f)) {
			for (int i = 0; i < arrayLineasSol.length; i++) {
				final DetalleLineaSolicitudDTO linea = arrayLineasSol[i];
				logger.debug(linea.toString());
				final DetalleCargosSolicitudDTO[] cargos = linea.getCargosRecurrentes();
				for (int j = 0; j < cargos.length; j++) {
					final DetalleCargosSolicitudDTO cargo = cargos[j];
					logger.debug(cargo.toString());
				}
			}
			try {
				delegate.insertaCargosOverride(arrayLineasSol);
				request.getSession().setAttribute("arrayLineasSol", arrayLineasSol);
			}
			catch (VentasException e) {
				String mensaje = e.getDescripcionEvento() == null ? "Ocurrio un error al generar el override " : e
						.getDescripcionEvento();
				request.setAttribute("mensajeError", mensaje);
				logger.debug("[VentasException] " + mensaje);
				return mapping.findForward("inicio");
			}
			catch (Exception e) {
				String mensaje = e.getMessage() == null ? "Ocurrio un error al generar el override " : e.getMessage();
				request.setAttribute("mensajeError", mensaje);
				logger.debug("[Exception]" + mensaje);
				return mapping.findForward("inicio");
			}
		}
		logger.info("continuarACargos, Fin");
		return mapping.findForward("continuarACargos");
	}

	/**
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward cancelar(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("cancelar, Inicio");
		logger.info("cancelar, Fin");
		return mapping.findForward("cancelar");
	}

	/**
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward cancelarOverrideFormalizacion(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.info("cancelarOverrideFormalizacion, Inicio");
		logger.info("cancelarOverrideFormalizacion, Fin");
		return mapping.findForward("cancelarOverrideFormalizacion");
	}
}
