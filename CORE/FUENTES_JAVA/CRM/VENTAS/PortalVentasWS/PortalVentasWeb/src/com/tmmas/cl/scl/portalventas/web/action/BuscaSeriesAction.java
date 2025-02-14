package com.tmmas.cl.scl.portalventas.web.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.ArticuloInDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosGeneralesDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.VentasException;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.DatosGeneralesDTO;
import com.tmmas.cl.scl.portalventas.web.delegate.PortalVentasDelegate;
import com.tmmas.cl.scl.portalventas.web.dto.ArticuloAjaxDTO;
import com.tmmas.cl.scl.portalventas.web.dto.SerieAjaxDTO;
import com.tmmas.cl.scl.portalventas.web.form.BuscaSeriesForm;
import com.tmmas.cl.scl.portalventas.web.form.DatosLineaForm;
import com.tmmas.cl.scl.portalventas.web.form.DatosVentaForm;
import com.tmmas.cl.scl.portalventas.web.helper.Global;
import com.tmmas.cl.scl.productdomain.businessobject.dto.ArticuloDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.BodegaDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.EquipoKitDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.NumeracionCelularDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.SimcardDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.TerminalDTO;

public class BuscaSeriesAction extends DispatchAction {

	private static final String ERROR_SERIE_SIMCARD_NO_DISPONIBLE = "El N° de Serie ya se encuentra asociado a un abonado.";
	
	private static final String ERROR_SERIE_IMEI_NO_DISPONIBLE = "El N° de Serie ya se encuentra asociado a un abonado.";

	private final Logger logger = Logger.getLogger(this.getClass());

	private Global global = Global.getInstance();

	PortalVentasDelegate delegate = PortalVentasDelegate.getInstance();

	public ActionForward inicioSimcard(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.debug("inicioSimcard, inicio");
		BuscaSeriesForm buscaSeriesForm = (BuscaSeriesForm) form;
		buscaSeriesForm.setLinkOrigen("SIMCARD");
		buscaSeriesForm.setCodProcedencia(global.getValor("serie.procedencia.interna"));
		inicializar(buscaSeriesForm, request);
		buscaSeriesForm.setMensajeError(null);
		logger.debug("inicioSimcard, fin");
		return mapping.findForward("inicio");
	}

	public ActionForward inicioEquipo(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.debug("inicioEquipo, inicio");
		BuscaSeriesForm buscaSeriesForm = (BuscaSeriesForm) form;
		buscaSeriesForm.setLinkOrigen("EQUIPO");
		buscaSeriesForm.setCodProcedencia("");
		buscaSeriesForm.setFlgEquipoFijo("0");
		buscaSeriesForm.setMensajeError(null);
		inicializar(buscaSeriesForm, request);
		//verifica si equipo corresponde al grupo prestacion Telefonia Fija, y setea flag
		HttpSession sesion = request.getSession(false);
		DatosLineaForm datosLineaForm = (DatosLineaForm) sesion.getAttribute("DatosLineaForm");
		if (datosLineaForm != null) {
			String codGrpPrestacion = datosLineaForm.getCodGrpPrestacion();
			String indInvFijo = datosLineaForm.getIndInvFijo();
			if (codGrpPrestacion.equals(global.getValor("grupo.prestacion.fija")) && indInvFijo.equals("1")) {
				buscaSeriesForm.setCodProcedencia(global.getValor("serie.procedencia.externa"));
				buscaSeriesForm.setFlgEquipoFijo("1");
			}
		}
		logger.debug("inicioEquipo, fin");
		return mapping.findForward("inicio");
	}

	public ActionForward buscarSerie(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("buscarSerie, inicio");
		logger.info("buscarSerie, fin");
		return mapping.findForward("inicio");
	}

	public ActionForward aceptarEquipo(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.debug("aceptarEquipo, inicio");
		HttpSession sesion = request.getSession(false);
		BuscaSeriesForm buscaSeriesForm = (BuscaSeriesForm) form;
		final Long numImeiEquipo = new Long(buscaSeriesForm.getNumeroSerieSel());
		logger.debug("numImeiEquipo [" + numImeiEquipo + "]");
		String codModuloOrigen = "";
		//Inicio P-CSR-11002 JLGN 27-04-2011
		DatosLineaForm datosLineaForm2 = (DatosLineaForm) sesion.getAttribute("DatosLineaForm");
		//Fin P-CSR-11002 JLGN 27-04-2011
		try {

			// Incidencia 149133. 
			if (delegate.existeAbonadoXImei(numImeiEquipo)) {
				VentasException ex = new VentasException(ERROR_SERIE_IMEI_NO_DISPONIBLE);
				ex.setDescripcionEvento(ERROR_SERIE_IMEI_NO_DISPONIBLE);
				throw ex;
			}
			// Fin Incidencia 149133.
			
			logger.debug("Inicio aceptarEquipo");
			logger.debug("flgSerieKit: "+datosLineaForm2.getFlgSerieKit());
			logger.debug("FlgSerieNumerada: "+datosLineaForm2.getFlgSerieNumerada());

			//actualiza reserva solo si selecciona un numero distinto al anterior guardado, y si la procedencia es interna
			logger.debug("actualiza reserva");
			if (!buscaSeriesForm.getEquipoAnteriorRes().equals(buscaSeriesForm.getNumeroSerieSel())) {
				//busca numVenta
				long numVenta = 0;
				if (sesion.getAttribute("DatosVentaForm") != null) {
					DatosVentaForm datosVentaForm = (DatosVentaForm) sesion.getAttribute("DatosVentaForm");
					numVenta = datosVentaForm.getNumeroVenta();
				}
				//---- Actualizar stock, anular ------------------ ->EquipoAnteriorRes
				if (!buscaSeriesForm.getEquipoAnteriorRes().equals("")) {
					logger.debug("buscaSeriesForm.getEquipoAnteriorRes() [" + buscaSeriesForm.getEquipoAnteriorRes()
							+ "]");
					TerminalDTO terminalDTO = new TerminalDTO();
					terminalDTO.setNumeroSerie(buscaSeriesForm.getEquipoAnteriorRes());
					terminalDTO = delegate.getTerminal(terminalDTO);
					if (terminalDTO.getEstado().trim().equals(global.getValor("cod.estado.serie.reservada"))) {
						//actualizar stock
						ArticuloDTO articuloDTO = new ArticuloDTO();
						articuloDTO.setTipoMovimiento(global.getValor("tipo.movto.libventa"));
						articuloDTO.setTipoStock(Integer.parseInt(terminalDTO.getTipoStock()));
						articuloDTO.setCodigoBodega(Integer.parseInt(terminalDTO.getCodigoBodega()));
						articuloDTO.setCodigo(Long.parseLong(terminalDTO.getCodigoArticulo()));
						articuloDTO.setCodigoUso(terminalDTO.getCodigoUso());
						articuloDTO.setCodigoEstado(1);
						articuloDTO.setNumeroVenta(String.valueOf(numVenta));
						articuloDTO.setNumeroSerie(buscaSeriesForm.getEquipoAnteriorRes());
						logger.debug("articuloDTO.getCodigoEstado() [" + articuloDTO.getCodigoEstado() + "]");
						logger.debug("actualizandoStock...");
						delegate.actualizaStock(articuloDTO);
						buscaSeriesForm.setEquipoAnteriorRes("");
					}
					//limpia variable
					buscaSeriesForm.setEquipoAnteriorRes("");
				}
				if (buscaSeriesForm.getCodProcedencia().equals(global.getValor("serie.procedencia.interna"))) {
					logger.debug("buscaSeriesForm.getCodProcedencia() [" + buscaSeriesForm.getCodProcedencia() + "]");
					logger.debug("Serie Interna");
					//---- Actualizar stock, reservar ------------------ ->NumeroSerieSel
					TerminalDTO terminalDTO = new TerminalDTO();
					terminalDTO.setNumeroSerie(buscaSeriesForm.getNumeroSerieSel());
					terminalDTO = delegate.getTerminal(terminalDTO);
					//Verifica que la serie aun no se encuentre reservada
					if (!terminalDTO.getEstado().trim().equals(global.getValor("cod.estado.serie.reservada"))) {
						logger.debug("Serie no se encuentra reservada");
						logger.debug("terminalDTO.getEstado() [" + terminalDTO.getEstado() + "]");

						ArticuloDTO articuloDTO = new ArticuloDTO();
						articuloDTO.setTipoMovimiento(global.getValor("tipo.movto.resventa"));
						articuloDTO.setTipoStock(Integer.parseInt(terminalDTO.getTipoStock()));
						articuloDTO.setCodigoBodega(Integer.parseInt(terminalDTO.getCodigoBodega()));
						articuloDTO.setCodigo(Long.parseLong(terminalDTO.getCodigoArticulo()));
						articuloDTO.setCodigoUso(terminalDTO.getCodigoUso());
						articuloDTO.setCodigoEstado(Integer.parseInt(terminalDTO.getEstado()));
						articuloDTO.setNumeroVenta(String.valueOf(numVenta));
						articuloDTO.setNumeroSerie(buscaSeriesForm.getNumeroSerieSel());
						logger.debug("articuloDTO.getCodigoEstado() [" + articuloDTO.getCodigoEstado() + "]");
						logger.debug("actualizandoStock...");
						
						//Inicio P-CSR-11002 JLGN 27-04-2011 Antes de Reservar serie se valida el Cod_uso de la serie
						logger.debug("datosLineaForm2.getCodUsoLinea(): "+datosLineaForm2.getCodUsoLinea());
						logger.debug("datosLineaForm2.getCodUsoLineaSeleccionado(): "+datosLineaForm2.getCodUsoLineaSeleccionado());
						logger.debug("articuloDTO.getCodigoUso(): "+articuloDTO.getCodigoUso());
						logger.debug("articuloDTO.getCodigoUso(): "+datosLineaForm2.getNomUsuario());
						if(articuloDTO.getCodigoUso() != Integer.parseInt(datosLineaForm2.getCodUsoLinea())){
							delegate.actualizaUsoTerminal(articuloDTO,datosLineaForm2.getCodUsoLinea()); 
							articuloDTO.setCodigoUso(Integer.parseInt(datosLineaForm2.getCodUsoLinea()));
						} 
						//Fin P-CSR-11002 JLGN 27-04-2011
						delegate.actualizaStock(articuloDTO);
						//actualiza variable
						buscaSeriesForm.setEquipoAnteriorRes(buscaSeriesForm.getNumeroSerieSel());
					}
					else {
						buscaSeriesForm.setMensajeError("No se pudo reservar la serie. Por favor, seleccione otra.");
						return mapping.findForward("inicio");
					}
				}

				//Dejar serie en sesion para cargarla en Datos Linea
				SerieAjaxDTO serieSel = new SerieAjaxDTO();
				serieSel.setNumSerie(buscaSeriesForm.getNumeroSerieSel());
				serieSel.setCodProcedencia(buscaSeriesForm.getCodProcedencia());
				serieSel.setCodArticuloEquipo(buscaSeriesForm.getCodArticulo());
				if (buscaSeriesForm.getCodProcedencia().equals(global.getValor("serie.procedencia.externa"))) {

					//buscar glosa articulo
					ArticuloAjaxDTO[] articulos = buscaSeriesForm.getArrayArticulos();
					if (articulos != null) {
						for (int i = 0; i < articulos.length; i++) {
							if (articulos[i].getCodArticulo().equals(buscaSeriesForm.getCodArticulo())) {
								serieSel.setGlsArticloEquipo(articulos[i].getDesArticulo());
								break;
							}
						}//fin for
					}//fin if (articulos!=null)
				}

				//buscar otros datos
				SerieAjaxDTO[] listaSeries = (SerieAjaxDTO[]) sesion.getAttribute("listaSeries");
				if (listaSeries != null) {
					for (int i = 0; i < listaSeries.length; i++) {
						if (listaSeries[i].getNumSerie().equals(buscaSeriesForm.getNumeroSerieSel())) {
							serieSel.setNumTelefono(listaSeries[i].getNumTelefono());
							serieSel.setFecha(listaSeries[i].getFecha());
							serieSel.setGlsArticloEquipo(listaSeries[i].getGlsArticloEquipo());
							break;
						}
					}
				}

				sesion.setAttribute("serieSel", serieSel);

				//(+) ---------------- serie numerada ---------------------------
				DatosLineaForm datosLineaForm = (DatosLineaForm) sesion.getAttribute("DatosLineaForm");
				codModuloOrigen = datosLineaForm.getCodModuloOrigen();

				//datos iniciales
				String numCelularAnt = datosLineaForm.getNumCelular();
				String numCelularEquipoAnt = datosLineaForm.getNumCelularEquipo();
				String flgSerieNumeradaAnt = datosLineaForm.getFlgSerieNumerada();

				//si hay celular ingresado anteriormente y se ingreso por equipo numerado, solo se debe limpiar el campo
				if (!numCelularAnt.equals("") && flgSerieNumeradaAnt.equals("1")
						&& numCelularAnt.equals(numCelularEquipoAnt)) { //EQUIPO ANTERIOR NUMERADO
					datosLineaForm.setNumCelular("");
					datosLineaForm.setFlgSerieNumerada("0");//inicializa flg anterior				
				}
				//else mantener valor celular

				//si ahora selecciono una serie numerada, y antes ya habia ingresado numeracion, 
				//se debe anular reserva si corresponde y limpiar campos
				if ((serieSel.getNumTelefono() != null) && !serieSel.getNumTelefono().trim().equals("")) {//Es numerada
					logger.debug("Es numerada");

					//si hay celular ingresado anteriormente y no es serie numerada ni KIT, debe anular reserva
					if (!datosLineaForm.getNumCelular().equals("") && !flgSerieNumeradaAnt.equals("1")
							&& !datosLineaForm.getFlgSerieKit().equals("1")) {
						NumeracionCelularDTO numeracionCelularDTO = new NumeracionCelularDTO();
						numeracionCelularDTO.setNombreTabla(datosLineaForm.getTablaNumeracion());
						numeracionCelularDTO.setCodSubALM(datosLineaForm.getCodSubAlmNumeracion());
						numeracionCelularDTO.setCodCentral(datosLineaForm.getCodCentralNumeracion());
						numeracionCelularDTO.setCodCat(datosLineaForm.getCategoriaNumeracion());
						numeracionCelularDTO.setCodUso(datosLineaForm.getCodUsoNumeracion());
						numeracionCelularDTO.setNumCelular(new Long(datosLineaForm.getNumCelular()));
						logger.info("(DesReserva) Reponer Número Celular P_REPONER_NUMERACION");
						delegate.reponerNumeracion(numeracionCelularDTO);
						logger.info("(DesReserva) Borrar registro en la GA_RESNUMCEL");
						delegate.desReservaNumeroCelular(numeracionCelularDTO);
						datosLineaForm.setNumCelular("");
					}

					//carga datos en pagina principal
					datosLineaForm.setFlgSerieNumerada("1");
					datosLineaForm.setNumCelular(serieSel.getNumTelefono());

				}//fin if (!datosLineaForm.getNumCelular().equals("")

				//(-) ---------------- serie numerada ---------------------------

			}//fin if (!buscaSeriesForm.getEquipoAnteriorRes().equals(buscaSeriesForm.getNumeroSerieSel()))
			else {
				//verifica si es externo y si cambio articulo
				if (buscaSeriesForm.getCodProcedencia().equals(global.getValor("serie.procedencia.externa"))) {
					if (sesion.getAttribute("serieSel") != null) {
						SerieAjaxDTO serieSel = (SerieAjaxDTO) sesion.getAttribute("serieSel");
						if (!serieSel.getCodArticuloEquipo().equals(buscaSeriesForm.getCodArticulo())) {
							//Dejar serie en sesion para cargarla en Datos Linea
							serieSel.setNumSerie(buscaSeriesForm.getNumeroSerieSel());
							serieSel.setCodProcedencia(buscaSeriesForm.getCodProcedencia());
							serieSel.setCodArticuloEquipo(buscaSeriesForm.getCodArticulo());
							serieSel.setNumTelefono("");
							serieSel.setFecha("");
							//buscar glosa articulo
							ArticuloAjaxDTO[] articulos = buscaSeriesForm.getArrayArticulos();
							if (articulos != null) {
								for (int i = 0; i < articulos.length; i++) {
									if (articulos[i].getCodArticulo().equals(buscaSeriesForm.getCodArticulo())) {
										serieSel.setGlsArticloEquipo(articulos[i].getDesArticulo());
										break;
									}
								}//fin for
							}//fin if (articulos!=null)
							sesion.setAttribute("serieSel", serieSel);
						}
					}
				}
			}
			
			//Inicio P-CSR-11002 JLGN 18-10-2011
			
			//Fin P-CSR-11002 JLGN 18-10-2011
		
		}
		catch (VentasException e) {
			String mensaje = e.getDescripcionEvento() == null ? " " : e.getDescripcionEvento();
			final String mensajeError = "Ocurrió un error al seleccionar la serie: " + mensaje;
			logger.error(mensajeError);
			logger.error(StackTraceUtl.getStackTrace(e));
			buscaSeriesForm.setMensajeError(mensajeError + " Por favor, seleccione otro.");
			return mapping.findForward("inicio");
		}
		catch (Exception e) {
			String mensaje = e.getMessage() == null ? " " : e.getMessage();
			buscaSeriesForm.setMensajeError("Ocurrio un error al seleccionar la serie. Por favor, seleccione otra."
					+ mensaje);
			logger.error(StackTraceUtl.getStackTrace(e));
			logger.error("[Exception] Ocurrio un error al seleccionar la serie " + mensaje);
		}

		sesion.removeAttribute("listaSeries");
		DatosLineaForm datosLineaForm = (DatosLineaForm) sesion.getAttribute("DatosLineaForm");
		logger.debug("Fin aceptarEquipo");
		logger.debug("flgSerieKit: "+datosLineaForm.getFlgSerieKit());
		logger.debug("FlgSerieNumerada: "+datosLineaForm.getFlgSerieNumerada());
		logger.debug("aceptar, fin");

		if (codModuloOrigen.trim().equals(global.getValor("modulo.web.scoring"))) {
			return mapping.findForward("aceptarEquipoScoring");
		}
		else {
			return mapping.findForward("aceptarEquipo");
		}
	}

	public ActionForward aceptarSimcard(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.debug("aceptarSimcard, inicio");
		HttpSession sesion = request.getSession(false);
		BuscaSeriesForm buscaSeriesForm = (BuscaSeriesForm) form;
		final Long numSerieSimcard = new Long(buscaSeriesForm.getNumeroSerieSel());
		logger.debug("numSerieSimcard [" + numSerieSimcard + "]");
		String codModuloOrigen = "";
		logger.debug("buscaSeriesForm.getCodArticulo()111 [" +buscaSeriesForm.getCodArticulo());
		try {
			// Incidencia 149133. 
			if (delegate.existeAbonadoXSimcard(numSerieSimcard)) {
				VentasException ex = new VentasException(ERROR_SERIE_SIMCARD_NO_DISPONIBLE);
				ex.setDescripcionEvento(ERROR_SERIE_SIMCARD_NO_DISPONIBLE);
				throw ex;
			}
			// Fin Incidencia 149133.

			//actualiza reserva solo si selecciona un numero distinto al anterior guardado
			if (!buscaSeriesForm.getSimcardAnteriorRes().equals(buscaSeriesForm.getNumeroSerieSel())) {
				//busca numVenta
				long numVenta = 0;
				if (sesion.getAttribute("DatosVentaForm") != null) {
					DatosVentaForm datosVentaForm = (DatosVentaForm) sesion.getAttribute("DatosVentaForm");
					numVenta = datosVentaForm.getNumeroVenta();
				}
				//---- Actualizar stock, anular ------------------ ->SimcardAnteriorRes
				if (!buscaSeriesForm.getSimcardAnteriorRes().equals("")) {
					SimcardDTO simcardDTO = new SimcardDTO();
					simcardDTO.setNumeroSerie(buscaSeriesForm.getSimcardAnteriorRes());
					simcardDTO = delegate.getSimcard(simcardDTO);

					if (simcardDTO.getEstado().trim().equals(global.getValor("cod.estado.serie.reservada"))) {
						//actualizar stock
						ArticuloDTO articuloDTO = new ArticuloDTO();
						articuloDTO.setTipoMovimiento(global.getValor("tipo.movto.libventa"));
						articuloDTO.setTipoStock(Integer.parseInt(simcardDTO.getTipoStock()));
						articuloDTO.setCodigoBodega(Integer.parseInt(simcardDTO.getCodigoBodega()));
						articuloDTO.setCodigo(Long.parseLong(simcardDTO.getCodigoArticulo()));
						articuloDTO.setCodigoUso(simcardDTO.getCodigoUso());
						articuloDTO.setCodigoEstado(1);
						articuloDTO.setNumeroVenta(String.valueOf(numVenta));
						articuloDTO.setNumeroSerie(buscaSeriesForm.getSimcardAnteriorRes());
						delegate.actualizaStock(articuloDTO);
						buscaSeriesForm.setSimcardAnteriorRes("");
					}
					else {
						buscaSeriesForm.setMensajeError("No se pudo liberar la serie. Por favor, seleccione otra.");
						return mapping.findForward("inicio");
					}
				}

				//---- Actualizar stock, reservar ------------------ ->NumeroSerieSel
				SimcardDTO simcardDTO = new SimcardDTO();
				simcardDTO.setNumeroSerie(buscaSeriesForm.getNumeroSerieSel());
				simcardDTO = delegate.getSimcard(simcardDTO);

				if (!simcardDTO.getEstado().trim().equals(global.getValor("cod.estado.serie.reservada"))) {

					ArticuloDTO articuloDTO = new ArticuloDTO();
					articuloDTO.setTipoMovimiento(global.getValor("tipo.movto.resventa"));
					articuloDTO.setTipoStock(Integer.parseInt(simcardDTO.getTipoStock()));
					articuloDTO.setCodigoBodega(Integer.parseInt(simcardDTO.getCodigoBodega()));
					articuloDTO.setCodigo(Long.parseLong(simcardDTO.getCodigoArticulo()));
					articuloDTO.setCodigoUso(simcardDTO.getCodigoUso());
					articuloDTO.setCodigoEstado(Integer.parseInt(simcardDTO.getEstado()));
					articuloDTO.setNumeroVenta(String.valueOf(numVenta));
					articuloDTO.setNumeroSerie(buscaSeriesForm.getNumeroSerieSel());
					delegate.actualizaStock(articuloDTO);
				}
				else {
					buscaSeriesForm.setMensajeError("No se pudo reservar la serie. Por favor, seleccione otra.");
					return mapping.findForward("inicio");
				}

				//actualiza variable
				buscaSeriesForm.setSimcardAnteriorRes(buscaSeriesForm.getNumeroSerieSel());

				//Dejar serie en sesion para cargarla en Datos Linea
				SerieAjaxDTO serieSel = new SerieAjaxDTO();
				serieSel.setNumSerie(buscaSeriesForm.getNumeroSerieSel());
				serieSel.setCodProcedencia(buscaSeriesForm.getCodProcedencia());

				//buscar otros datos
				SerieAjaxDTO[] listaSeries = (SerieAjaxDTO[]) sesion.getAttribute("listaSeries");
				if (listaSeries != null) {
					for (int i = 0; i < listaSeries.length; i++) {
						if (listaSeries[i].getNumSerie().equals(buscaSeriesForm.getNumeroSerieSel())) {
							serieSel.setNumTelefono(listaSeries[i].getNumTelefono());
							serieSel.setFecha(listaSeries[i].getFecha());
							//INI 185192 JVA INICIOSoporte Ventas 06-06-2012
							logger.debug("buscaSeriesForm.getCodArticulo()0101 [" +simcardDTO.getCodigoArticulo());
							logger.debug("listaSeries[i].getCodArticuloEquipo() 78[" +listaSeries[i].getCodArticuloEquipo());
							if (buscaSeriesForm.getCodCriterioBusqueda().equals("SE")){
								logger.debug("buscaSeriesForm.getCodArticulo()5655 [" +simcardDTO.getCodigoArticulo());
								logger.debug("listaSeries[i].getCodArticuloEquipo()999 [" +listaSeries[i].getCodArticuloEquipo());
								buscaSeriesForm.setCodArticulo(simcardDTO.getCodigoArticulo());	
							}							
							//FIN 185192 JVA INICIO Soporte Ventas 06-06-2012
							break;
						}
					}
				}

				sesion.setAttribute("serieSel", serieSel);

				//(+) ---------------- serie KIT ---------------------------
				//si ya hay un kit seleccionado se debe limpiar equipo y numero
				//busca tecnologia y flg KIT
				String codTecnologia = "";
				String flgHayKITSeleccionado = "0";
				DatosLineaForm datosLineaForm = (DatosLineaForm) sesion.getAttribute("DatosLineaForm");
				codModuloOrigen = datosLineaForm.getCodModuloOrigen();
				if (datosLineaForm != null) {
					codTecnologia = datosLineaForm.getCodTecnologia();
					flgHayKITSeleccionado = datosLineaForm.getFlgSerieKit();
				}
				if (flgHayKITSeleccionado.equals("1")) {
					datosLineaForm.setNumEquipo("");
					datosLineaForm.setNumCelular("");
					datosLineaForm.setFlgSerieKit("0");
				}
				//busca si articulo es KIT
				//INC 185192 JVA INICIO
				//if (buscaSeriesForm.getCodCriterioBusqueda().equals(global.getValor("criterio.busqueda.bodega"))) {
				logger.debug("185192 if antes");
				//INC 185192 JVA INICIO
				logger.debug("buscaSeriesForm.getCodCriterioBusqueda() - 185192"+buscaSeriesForm.getCodCriterioBusqueda());
				if (buscaSeriesForm.getCodCriterioBusqueda().equals(global.getValor("criterio.busqueda.bodega")) || buscaSeriesForm.getCodCriterioBusqueda().equals("SE") ){
				//INC 185192 JVA INICIO
					logger.debug("185192 despues");
					//buscar tipo de articulo seleccionado
					String tipoArticulo = "";
					ArticuloAjaxDTO[] arrayArticulos = buscaSeriesForm.getArrayArticulos();
					if (arrayArticulos != null && arrayArticulos.length > 0) {
						logger.debug("185192 1111");
						for (int i = 0; i < arrayArticulos.length; i++) {
							logger.debug("buscaSeriesForm.getCodArticulo()"+buscaSeriesForm.getCodArticulo());
							logger.debug("arrayArticulos[i].getCodArticulo()+"+arrayArticulos[i].getCodArticulo());
							if (arrayArticulos[i].getCodArticulo().equals(buscaSeriesForm.getCodArticulo())) {
								logger.debug("2222arrayArticulos[i].getCodArticulo()+"+arrayArticulos[i].getCodArticulo());
								tipoArticulo = arrayArticulos[i].getTipoArticulo();
								logger.debug("tipoArticulo: "+tipoArticulo);
								break;
							}
						}
					}
					logger.debug("JVA - 185192 buscaSeriesForm.getCodArticuloKIT()"+buscaSeriesForm.getCodArticuloKIT());
					logger.debug("tipoArticulo: "+tipoArticulo);
					if (tipoArticulo.equals(buscaSeriesForm.getCodArticuloKIT())) { //Es KIT
						logger.debug("Es KIT");
						EquipoKitDTO equipoKitDTO = new EquipoKitDTO();
						equipoKitDTO.setNumKit(buscaSeriesForm.getNumeroSerieSel());
						equipoKitDTO.setCodTecnologia(codTecnologia);
						equipoKitDTO = delegate.getSerieEquipoKit(equipoKitDTO);

						//si ahora selecciono un articulo KIT, y antes ya habia ingresado numeracion o equipo, 
						//se debe anular reserva si corresponde y limpiar campos

						//(+) anular equipo					
						if (!datosLineaForm.getNumEquipo().equals("")) {
							String codProcedenciaEquipo = datosLineaForm.getCodProcedenciaEquipo();
							if (codProcedenciaEquipo.equals(global.getValor("serie.procedencia.interna"))) {
								TerminalDTO terminalDTO = new TerminalDTO();
								terminalDTO.setNumeroSerie(datosLineaForm.getNumEquipo());
								terminalDTO = delegate.getTerminal(terminalDTO);

								//actualizar stock
								ArticuloDTO articuloDTOAnular = new ArticuloDTO();
								articuloDTOAnular.setTipoMovimiento(global.getValor("tipo.movto.libventa"));
								articuloDTOAnular.setTipoStock(Integer.parseInt(terminalDTO.getTipoStock()));
								articuloDTOAnular.setCodigoBodega(Integer.parseInt(terminalDTO.getCodigoBodega()));
								articuloDTOAnular.setCodigo(Long.parseLong(terminalDTO.getCodigoArticulo()));
								articuloDTOAnular.setCodigoUso(terminalDTO.getCodigoUso());
								articuloDTOAnular.setCodigoEstado(1);
								articuloDTOAnular.setNumeroVenta(String.valueOf(numVenta));
								articuloDTOAnular.setNumeroSerie(datosLineaForm.getNumEquipo());
								delegate.actualizaStock(articuloDTOAnular);

								datosLineaForm.setNumEquipo("");
								datosLineaForm.setCodProcedenciaEquipo("");
								datosLineaForm.setCodArticuloEquipo("");
								datosLineaForm.setGlsArticuloEquipo("");
							}
						}
						//(-) anular equipo

						//(+) anula numeracion
						if (!datosLineaForm.getNumCelular().equals("")
								&& !datosLineaForm.getFlgSerieNumerada().equals("1")) {
							NumeracionCelularDTO numeracionCelularDTO = new NumeracionCelularDTO();
							numeracionCelularDTO.setNombreTabla(datosLineaForm.getTablaNumeracion());
							numeracionCelularDTO.setCodSubALM(datosLineaForm.getCodSubAlmNumeracion());
							numeracionCelularDTO.setCodCentral(datosLineaForm.getCodCentralNumeracion());
							numeracionCelularDTO.setCodCat(datosLineaForm.getCategoriaNumeracion());
							numeracionCelularDTO.setCodUso(datosLineaForm.getCodUsoNumeracion());
							numeracionCelularDTO.setNumCelular(new Long(datosLineaForm.getNumCelular()));
							logger.info("(DesReserva) Reponer Número Celular P_REPONER_NUMERACION");
							delegate.reponerNumeracion(numeracionCelularDTO);
							logger.info("(DesReserva) Borrar registro en la GA_RESNUMCEL");
							delegate.desReservaNumeroCelular(numeracionCelularDTO);
							datosLineaForm.setNumCelular("");
						}
						//(-) anula numeracion

						//carga datos en pagina principal
						datosLineaForm.setFlgSerieKit("1");
						datosLineaForm.setNumEquipo(equipoKitDTO.getNumSerieEquipo());
						if (codTecnologia.equals("GSM")) {
							datosLineaForm.setNumCelular(String.valueOf(equipoKitDTO.getNumTelefonoSimcard()));
						}
						else {
							datosLineaForm.setNumCelular(String.valueOf(equipoKitDTO.getNumTelefonoEquipo()));
						}
					}//fin if (tipoArticulo.equals(buscaSeriesForm.getCodArticuloKIT()))

				}//fin if (buscaSeriesForm.getCodCriterioBusqueda().equals("BO"))
				//(-) ---------------- serie KIT ---------------------------

				//(+) ---------------- serie numerada ---------------------------
				//datos iniciales
				String numCelularAnt = datosLineaForm.getNumCelular();
				String numCelularSimcardAnt = datosLineaForm.getNumCelularSimcard();
				String flgSerieNumeradaAnt = datosLineaForm.getFlgSerieNumerada();

				//si hay celular ingresado anteriormente y se ingreso por simcard numerada, solo se debe limpiar el campo
				if (!numCelularAnt.equals("") && flgSerieNumeradaAnt.equals("1")
						&& numCelularAnt.equals(numCelularSimcardAnt)) { //SIMCARD ANTERIOR NUMERADA
					datosLineaForm.setNumCelular("");
					datosLineaForm.setFlgSerieNumerada("0");//inicializa flg anterior				
				}
				//else mantener valor celular

				//si ahora selecciono una serie numerada, y antes ya habia ingresado numeracion, 
				//se debe anular reserva si corresponde y limpiar campos
				if ((serieSel.getNumTelefono() != null) && !serieSel.getNumTelefono().trim().equals("")) {//Es numerada
					logger.debug("Es numerada");

					//si hay celular ingresado anteriormente y no es serie numerada ni KIT, debe anular reserva
					if (!datosLineaForm.getNumCelular().equals("") && !flgSerieNumeradaAnt.equals("1")
							&& !datosLineaForm.getFlgSerieKit().equals("1")) {
						NumeracionCelularDTO numeracionCelularDTO = new NumeracionCelularDTO();
						numeracionCelularDTO.setNombreTabla(datosLineaForm.getTablaNumeracion());
						numeracionCelularDTO.setCodSubALM(datosLineaForm.getCodSubAlmNumeracion());
						numeracionCelularDTO.setCodCentral(datosLineaForm.getCodCentralNumeracion());
						numeracionCelularDTO.setCodCat(datosLineaForm.getCategoriaNumeracion());
						numeracionCelularDTO.setCodUso(datosLineaForm.getCodUsoNumeracion());
						numeracionCelularDTO.setNumCelular(new Long(datosLineaForm.getNumCelular()));
						logger.info("(DesReserva) Reponer Número Celular P_REPONER_NUMERACION");
						delegate.reponerNumeracion(numeracionCelularDTO);
						logger.info("(DesReserva) Borrar registro en la GA_RESNUMCEL");
						delegate.desReservaNumeroCelular(numeracionCelularDTO);
						datosLineaForm.setNumCelular("");
					}//fin if (!datosLineaForm.getNumCelular().equals("") && !datosLineaForm.getFlgSerieKit().equals("1")){

					//carga datos en pagina principal
					datosLineaForm.setFlgSerieNumerada("1");
					datosLineaForm.setNumCelular(serieSel.getNumTelefono());
				}//fin if ((serieSel.getNumTelefono()!=null) && !serieSel.getNumTelefono().trim().equals(""))

				//(-) ---------------- serie numerada ---------------------------

			}//fin if (!buscaSeriesForm.getSimcardAnteriorRes().equals(buscaSeriesForm.getNumeroSerieSel())){		

		}
		catch (VentasException e) {
			String mensaje = e.getDescripcionEvento() == null ? " " : e.getDescripcionEvento();
			final String mensajeError = "Ocurrió un error al seleccionar la serie: " + mensaje;
			logger.error(mensajeError);
			logger.error(StackTraceUtl.getStackTrace(e));
			buscaSeriesForm.setMensajeError(mensajeError + " Por favor, seleccione otro.");
			return mapping.findForward("inicio");
		}
		catch (Exception e) {
			String mensaje = e.getMessage() == null ? " " : e.getMessage();
			buscaSeriesForm.setMensajeError("Ocurrio un error al seleccionar la serie. Por favor, seleccione otra."
					+ mensaje);
			logger.error(StackTraceUtl.getStackTrace(e));
			logger.error("[Exception] Ocurrio un error al seleccionar la serie " + mensaje);
		}

		sesion.removeAttribute("listaSeries");
		logger.debug("aceptarSimcard, fin");
		if (codModuloOrigen.trim().equals(global.getValor("modulo.web.scoring"))) {
			return mapping.findForward("aceptarSimcardScoring");
		}
		else {
			return mapping.findForward("aceptarSimcard");
		}
	}

	public ActionForward cancelar(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.debug("cancelar, inicio");
		HttpSession sesion = request.getSession(false);
		sesion.removeAttribute("serieSel");
		sesion.removeAttribute("listaSeries");
		logger.debug("cancelar, fin");
		DatosLineaForm datosLineaForm = (DatosLineaForm) sesion.getAttribute("DatosLineaForm");
		String codModuloOrigen = datosLineaForm.getCodModuloOrigen();

		if (codModuloOrigen.trim().equals(global.getValor("modulo.web.scoring"))) {
			return mapping.findForward("cancelarSerieScoring");
		}
		else {
			return mapping.findForward("cancelar");
		}
	}

	public ActionForward irAMenu(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.debug("irAMenu, inicio");
		logger.debug("irAMenu, fin");
		return mapping.findForward("irAMenu");
	}

	private void inicializar(BuscaSeriesForm buscaSeriesForm, HttpServletRequest request) throws Exception {
		HttpSession sesion = request.getSession(false);
		SerieAjaxDTO serieSel = null;
		//(+)Actualiza numero ya ingresado
		if (sesion.getAttribute("serieSel") != null) {
			serieSel = (SerieAjaxDTO) sesion.getAttribute("serieSel");
			buscaSeriesForm.setNumeroSerieSel(serieSel.getNumSerie());
			buscaSeriesForm.setCodProcedencia(serieSel.getCodProcedencia());
			buscaSeriesForm.setCodArticulo(serieSel.getCodArticuloEquipo());
		}
		else {
			buscaSeriesForm.setNumeroSerieSel("");
			if (buscaSeriesForm.getLinkOrigen().equals("SIMCARD")) {
				buscaSeriesForm.setSimcardAnteriorRes("");
			}
			else {//EQUIPO
				buscaSeriesForm.setEquipoAnteriorRes("");
			}
		}
		//(-)
		
		//P-CSR-11002 JLGN 27-10-2011
		buscaSeriesForm.setCodArticuloSeleccionado("");

		//carga combo procedencia
		if (buscaSeriesForm.getArrayProcedencia() == null) {
			DatosGeneralesDTO[] arrayProcedencia = new DatosGeneralesDTO[2];
			DatosGeneralesDTO datosGenerales = new DatosGeneralesDTO();
			datosGenerales.setCodigoParametro(global.getValor("serie.procedencia.interna"));
			datosGenerales.setValorParametro("INTERNA");
			arrayProcedencia[0] = datosGenerales;
			datosGenerales = new DatosGeneralesDTO();
			datosGenerales.setCodigoParametro(global.getValor("serie.procedencia.externa"));
			datosGenerales.setValorParametro("EXTERNA");
			arrayProcedencia[1] = datosGenerales;
			buscaSeriesForm.setArrayProcedencia(arrayProcedencia);
		}

		//carga combo de bodegas
		if (buscaSeriesForm.getArrayBodegas() == null) {

			String codVendedor = "0";
			//(+) busca vendedor
			if (sesion.getAttribute("DatosVentaForm") != null) {
				DatosVentaForm datosVentaForm = (DatosVentaForm) sesion.getAttribute("DatosVentaForm");
				codVendedor = datosVentaForm.getCodDistribuidor();
			}
			//(-)
			
			logger.debug("Codigo Vendedor a inicializar: "+ codVendedor);
			
			BodegaDTO bodegaDTO = new BodegaDTO();
			bodegaDTO.setCodVendedor((Long.parseLong(codVendedor)));
			BodegaDTO[] arrayBodegas = delegate.getBodegasXVendedor(bodegaDTO);
			buscaSeriesForm.setArrayBodegas(arrayBodegas);
		}

		//carga combo de articulos

		String indEquipo = "E";
		if (buscaSeriesForm.getLinkOrigen().equals("SIMCARD"))
			indEquipo = "S";
		String codTecnologia = "";
		String tipTerminal = "";
		String codUso = "0";
		//(+) busca tecnologia, terminal, y uso
		if (sesion.getAttribute("DatosLineaForm") != null) {
			DatosLineaForm datosLineaForm = (DatosLineaForm) sesion.getAttribute("DatosLineaForm");
			codTecnologia = datosLineaForm.getCodTecnologia();
			tipTerminal = datosLineaForm.getCodTipoTerminal();
			codUso = datosLineaForm.getCodUsoLinea();
		}
		//(-)
		
		//Inicio P-CSR-11002 JLGN 27-10-2011
		logger.debug("Obtiene Lista de Articulos");
		sesion.setAttribute("indEquipoSerie", indEquipo);
		sesion.setAttribute("codTecnologiaSerie", codTecnologia);
		sesion.setAttribute("tipTerminalSerie", tipTerminal);
		sesion.setAttribute("codUsoSerie", codUso);
		
		
		ArticuloInDTO articuloDTO = new ArticuloInDTO();
		articuloDTO.setCod_tecnologia(codTecnologia);
		articuloDTO.setTipTerminal(tipTerminal);
		articuloDTO.setIndEquipo(indEquipo);
		articuloDTO.setCodUso(Integer.parseInt(codUso));
		articuloDTO.setCodBodega(8);
		logger.debug("codTecnologia=" + codTecnologia);
		logger.debug("tipTerminal=" + tipTerminal);
		logger.debug("indEquipo=" + indEquipo);
		logger.debug("codUso=" + codUso);
		ArticuloInDTO[] arrayArticulos = delegate.getArticulos(articuloDTO);
		if (arrayArticulos != null) {
			ArticuloAjaxDTO[] arrayArticulosAjax = new ArticuloAjaxDTO[arrayArticulos.length];

			for (int i = 0; i < arrayArticulos.length; i++) {
				ArticuloInDTO articuloIn = (ArticuloInDTO) arrayArticulos[i];
				ArticuloAjaxDTO articuloAjax = new ArticuloAjaxDTO();
				articuloAjax.setCodArticulo(String.valueOf(articuloIn.getCodArticulo()));
				articuloAjax.setDesArticulo(articuloIn.getDesArticulo());
				articuloAjax.setTipoArticulo(String.valueOf(articuloIn.getTipoArticulo()));
				arrayArticulosAjax[i] = articuloAjax;
			}
			buscaSeriesForm.setArrayArticulos(arrayArticulosAjax);
		}
		
		//limpia combos
		buscaSeriesForm.setCodCriterioBusqueda("");
		buscaSeriesForm.setCodBodega("");
		if (buscaSeriesForm.getSimcardAnteriorRes() == null)
			buscaSeriesForm.setSimcardAnteriorRes("");
		if (buscaSeriesForm.getEquipoAnteriorRes() == null)
			buscaSeriesForm.setEquipoAnteriorRes("");
		//carga datos anteriores
		if (!buscaSeriesForm.getNumeroSerieSel().equals("")
				&& buscaSeriesForm.getCodProcedencia().equals(global.getValor("serie.procedencia.interna"))) {
			SerieAjaxDTO[] listaSeries = new SerieAjaxDTO[1];
			listaSeries[0] = serieSel;
			sesion.setAttribute("listaSeries", listaSeries);
		}
		//obtener parametro TIP_ARTICULO_KIT
		ParametrosGeneralesDTO parametrosKit = new ParametrosGeneralesDTO();

		parametrosKit.setCodigoproducto(global.getValor("codigo.producto"));
		parametrosKit.setCodigomodulo(global.getValor("codigo.modulo.AL"));
		parametrosKit.setNombreparametro(global.getValor("parametro.tip_articulo_kit"));
		parametrosKit = delegate.getParametroGeneral(parametrosKit);
		buscaSeriesForm.setCodArticuloKIT(parametrosKit.getValorparametro());
	}//fin inicializar
}
