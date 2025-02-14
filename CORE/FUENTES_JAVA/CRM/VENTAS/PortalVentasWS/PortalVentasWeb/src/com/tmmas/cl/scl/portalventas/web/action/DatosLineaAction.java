package com.tmmas.cl.scl.portalventas.web.action;

import java.rmi.RemoteException;
import java.text.NumberFormat;
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

import uk.ltd.getahead.dwr.WebContext;
import uk.ltd.getahead.dwr.WebContextFactory;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto.ActivacionLineaOutDTO;
import com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto.AltaLineaWebDTO;
import com.tmmas.cl.scl.altacliente.presentacion.delegate.AltaClienteDelegate;
import com.tmmas.cl.scl.altacliente.presentacion.dto.RetornoListaAjaxDTO;
import com.tmmas.cl.scl.altacliente.presentacion.form.AltaClienteInicioForm;
import com.tmmas.cl.scl.altacliente.presentacion.form.ClienteFacturaForm;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.DatosClienteBuroDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.IdentificadorCivilComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.exception.AltaClienteException;
import com.tmmas.cl.scl.commonbusinessentities.commonapp.DireccionNegocioWebDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.DatosDireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.DireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.FormularioDireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.GaContactoAbonadoToDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ParametrosGlobalesDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.ListadoSSOutDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.UsuarioWebDTO;
import com.tmmas.cl.scl.commonbusinessentities.interfaz.TipoAtributoDireccion;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ListadoVentasDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.MonedaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosGeneralesDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosValidacionVentasDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ResultadoValidacionVentaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.ProductoOfertadoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.VentasException;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.GaVentasDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.OficinaDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.VendedorDTO;
import com.tmmas.cl.scl.portalventas.web.delegate.PortalVentasDelegate;
import com.tmmas.cl.scl.portalventas.web.dto.ClienteAjaxDTO;
import com.tmmas.cl.scl.portalventas.web.dto.NumeroAjaxDTO;
import com.tmmas.cl.scl.portalventas.web.dto.ResultadoSolicitudVentaDTO;
import com.tmmas.cl.scl.portalventas.web.dto.SerieAjaxDTO;
import com.tmmas.cl.scl.portalventas.web.dto.VentaAjaxDTO;
import com.tmmas.cl.scl.portalventas.web.form.ConsultaVentasVendedorForm;
import com.tmmas.cl.scl.portalventas.web.form.DatosLineaForm;
import com.tmmas.cl.scl.portalventas.web.form.DatosLineaScoringForm;
import com.tmmas.cl.scl.portalventas.web.form.DatosVentaForm;
import com.tmmas.cl.scl.portalventas.web.form.PlanesAdicionalesScoringForm;
import com.tmmas.cl.scl.portalventas.web.form.ServiciosSuplementariosForm;
import com.tmmas.cl.scl.portalventas.web.helper.ConsultaVentasVendedorAJAX;
import com.tmmas.cl.scl.portalventas.web.helper.Global;
import com.tmmas.cl.scl.productdomain.businessobject.dto.GrupoPrestacionDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.SeguroDTO;
import com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.DatosVentaDTO;

public class DatosLineaAction extends DispatchAction {

	private final Logger logger = Logger.getLogger(DatosLineaAction.class);

	private Global global = Global.getInstance();

	PortalVentasDelegate delegate = PortalVentasDelegate.getInstance();
	
	//P-CSR-11002 JLGN 14-06-2011
	AltaClienteDelegate delegate2 = AltaClienteDelegate.getInstance();

	private static final String NOMBRE_LOCALE_SESION = "Locale-PortalVentas";

	NumberFormat numberFormat = NumberFormat.getInstance(); // Valor por defecto
	
	//Inicio P-CSR-11002
	private PlanesAdicionalesScoringForm planesAdicionalesScoringForm;
	private PlanesAdicionalesScoringForm getPlanesAdicionalesScoringForm(HttpServletRequest request) {
		return planesAdicionalesScoringForm == null ? (PlanesAdicionalesScoringForm) request.getSession().getAttribute(
				"PlanesAdicionalesScoringForm") : planesAdicionalesScoringForm;
	}
	//Fin P-CSR-11002
	
	public ActionForward inicio(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		logger.debug("inicio, inicio");

		HttpSession sesion = request.getSession(false);
		DatosVentaForm datosVentaForm = (DatosVentaForm) sesion.getAttribute("DatosVentaForm");
		String codCliente = "";
		String codTipoCliente = "";
		if (datosVentaForm != null) {
			codCliente = datosVentaForm.getCodCliente();
			codTipoCliente = datosVentaForm.getCodTipoCliente();
		}

		DatosLineaForm datosLineaForm = (DatosLineaForm) form;
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

		datosLineaForm.setNumberFormat(numberFormat);
		limpiarForm(datosLineaForm, request);
		//(+)-- Carga de listas --
		//Grupo prestacion
		GrupoPrestacionDTO[] arrayGrpPrestacion = delegate.getGruposPrestacion();
		ArrayList arrayGrpPrestacionTmp = new ArrayList();
		String codGrpPrestMovil = global.getValor("grupo.prestacion.movil");

		if (codTipoCliente.equals(global.getValor("tipo.cliente.prepago"))) {
			for (int i = 0; i < arrayGrpPrestacion.length; i++) {
				if (arrayGrpPrestacion[i].getCodGrupoPrestacion().equals(codGrpPrestMovil)) {
					GrupoPrestacionDTO grupoPrestacionDTO = new GrupoPrestacionDTO();
					grupoPrestacionDTO.setCodGrupoPrestacion(arrayGrpPrestacion[i].getCodGrupoPrestacion());
					grupoPrestacionDTO.setDesGrupoPrestacion(arrayGrpPrestacion[i].getDesGrupoPrestacion());
					arrayGrpPrestacionTmp.add(grupoPrestacionDTO);
					break;
				}
			}
			datosLineaForm.setArrayGrpPrestacion((GrupoPrestacionDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					arrayGrpPrestacionTmp.toArray(), GrupoPrestacionDTO.class));
		}
		else {
			datosLineaForm.setArrayGrpPrestacion(arrayGrpPrestacion);//todos
		}

		//Region
		if (datosLineaForm.getArrayRegiones() == null) {
			DireccionDTO direccionDTO = null;
			DatosDireccionDTO[] arrayRegiones = null;

			logger.debug("getDatosDireccion:inicio()");
			direccionDTO = delegate.getDatosDireccion(direccionDTO);
			logger.debug("getDatosDireccion:fin()");
			if (direccionDTO != null && direccionDTO.getConceptoDireccionDTOs() != null) {
				for (int i = 0; i < direccionDTO.getConceptoDireccionDTOs().length; i++) {
					if (direccionDTO.getConceptoDireccionDTOs()[i].getCodigoConcepto() == TipoAtributoDireccion.region) {
						arrayRegiones = direccionDTO.getConceptoDireccionDTOs()[i].getDatosDireccionDTO();
						break;
					}
				}
			}
			datosLineaForm.setArrayRegiones(arrayRegiones);
		}

		//Credito de consumo
		/*if (datosLineaForm.getArrayCreditoConsumo()==null){
		 CreditoConsumoDTO[] arrayCreditoConsumo = null;
		 //buscar cliente
		 CreditoConsumoDTO creditoConsumoDTO = new CreditoConsumoDTO();
		 creditoConsumoDTO.setCodigoCliente(codCliente);
		 arrayCreditoConsumo = delegate.getListadoCreditoConsumo(creditoConsumoDTO);
		 datosLineaForm.setArrayCreditoConsumo(arrayCreditoConsumo);
		 }*/

		//Grupo cobro servicio
		/*if (datosLineaForm.getArrayGrpCobroServicio()==null){
		 GrupoCobroServicioDTO[] arrayGrpCobroServicio = delegate.getListadoGrupoCobroServicio();
		 datosLineaForm.setArrayGrpCobroServicio(arrayGrpCobroServicio);
		 }*/

		/*
		 //campanas vigentes --> DWR: 149995
		 if (datosLineaForm.getArrayCampanasVigentes()==null){
		 CampanaVigenteDTO[] arrayCampanasVigentes = delegate.getListadoCampanasVigentes();
		 datosLineaForm.setArrayCampanasVigentes(arrayCampanasVigentes);
		 }*/

		//seguros
		if (datosLineaForm.getArrayTiposSeguro() == null) {
			SeguroDTO[] arrayTiposSeguro = delegate.getSeguros();
			datosLineaForm.setArrayTiposSeguro(arrayTiposSeguro);
		}

		//Tipo identificacion
		if (datosLineaForm.getArrayIdentificadorUsuario() == null) {
			IdentificadorCivilComDTO[] arrayIdentificadores = delegate.getTipoIdentificadoresCiviles();
			datosLineaForm.setArrayIdentificadorUsuario(arrayIdentificadores);
		}

		//monedas
		if (datosLineaForm.getArrayMonedas() == null) {
			MonedaDTO[] arrayMonedas = delegate.listarMonedas();
			datosLineaForm.setArrayMonedas(arrayMonedas);
		}

		//(-)-- Carga de listas --

		/* Valores por defecto*/
		cargarValoresDefecto(request, datosLineaForm);

		datosLineaForm.setFlgMostrarFrecuentes(global.getValor("mostrar.frecuentes"));
		datosLineaForm.setCodTipoCliente(codTipoCliente);
		datosLineaForm.setCodTipoClientePrepago(global.getValor("tipo.cliente.prepago"));
		datosLineaForm.setCodTelefoniaMovil(global.getValor("grupo.prestacion.movil"));
		datosLineaForm.setCodTelefoniaFija(global.getValor("grupo.prestacion.fija"));
		datosLineaForm.setCodInternet(global.getValor("grupo.prestacion.internet"));
		datosLineaForm.setCodCarrier(global.getValor("grupo.prestacion.carrier"));
		datosLineaForm.setProcedenciaNumero("");
		datosLineaForm.setFlgActivarBtnFinalizar("0");
		datosLineaForm.setFlgSerieKit("0");
		datosLineaForm.setFlgSerieNumerada("0");
		datosLineaForm.setCodOperadora(delegate.getCodigoOperadora());
		datosLineaForm.setCodOperadoraSalvador(global.getValor("codigo.operadora.salvador"));
		datosLineaForm.setFlgConsultaPA("0");
		//P-CSR-11002 JLGN 18-08-2011
		datosLineaForm.setLimiteCreditoIngresado("0");

		ParametrosGeneralesDTO parametrosLargoCelular = new ParametrosGeneralesDTO();
		parametrosLargoCelular.setCodigoproducto(global.getValor("codigo.producto"));
		parametrosLargoCelular.setCodigomodulo(global.getValor("codigo.modulo.GE"));
		parametrosLargoCelular.setNombreparametro(global.getValor("parametro.largo_n_celular"));
		parametrosLargoCelular = delegate.getParametroGeneral(parametrosLargoCelular);
		datosLineaForm.setLargoNumCelular(parametrosLargoCelular.getValorparametro());

		int nroLineasActivas = (delegate.consultaVentasCliente(new Long(codCliente))).intValue();
		logger.debug("nroLineasActivas=" + nroLineasActivas);
		/*P-CSR-11002 JLGN 25-05-2011		
		String aplicaRenovacion = (nroLineasActivas > 0) ? "1" : "0";
		datosLineaForm.setAplicaRenovacion(aplicaRenovacion);*/
		datosLineaForm.setAplicaRenovacion("0");
		
		String valorGrpPrestacionesSinLC = global.getValor("cod.grupo.prestacion.limiteconsumo.noaplica");
		String[] grpPrestacionesSinLC = stringEnArray(valorGrpPrestacionesSinLC);

		String valorTiposPlanTarifarioSinLC = global.getValor("cod.tipoproducto.plantarifario.limiteconsumo.noaplica");
		String[] tiposPlanTarifarioSinLC = stringEnArray(valorTiposPlanTarifarioSinLC);

		datosLineaForm.setGrpPrestacionesSinLC(grpPrestacionesSinLC);
		datosLineaForm.setTiposPlanTarifarioSinLC(tiposPlanTarifarioSinLC);

		datosLineaForm.setCantidadLineas(0);
		
		datosLineaForm.setCodPlanServicioSeleccionado("01");
		datosLineaForm.setCodTipoTerminalSeleccionado("T");
		//Fin P-CSR-11002 JLGN 27-07-2011
		
		//Inicio P-CSR-11002 12/04/2011 JLGN
		logger.debug("RA-11002");
		String cedulaIdentidad = global.getValorExterno("modulo.web.cedula.identidad");
		logger.debug("cedulaIdentidad: "+ cedulaIdentidad);
		request.getSession().setAttribute("cedulaIdentidad", cedulaIdentidad);
		
		String cedulaJuridica = global.getValorExterno("modulo.web.cedula.juridica");
		logger.debug("cedulaJuridica: "+ cedulaJuridica);
		request.getSession().setAttribute("cedulaJuridica", cedulaJuridica);
		
		String cedulaOtras = global.getValorExterno("modulo.web.cedula.otras");
		logger.debug("cedulaOtras: "+ cedulaOtras);
		request.getSession().setAttribute("cedulaOtras", cedulaOtras);
		
		datosLineaForm.setFlagCalificacion("false");
		//P-CSR-11002 JLGN 17-08-2011
		request.getSession().setAttribute("flagObtPT", "false");
		String flagExisteClienteBuro = (String) sesion.getAttribute("noExisteClienteBuro");
		logger.debug("Valor Existe Cliente Buro: "+ flagExisteClienteBuro);
		datosLineaForm.setFlagExisteClienteBuro(flagExisteClienteBuro);
		request.getSession().setAttribute("flagMuestraCalificacion", "false");
		//Fin P-CSR-11002 12/04/2011 JLGN
		//Inicio P-CSR-11002 JLGN 05-07-2011
		request.getSession().setAttribute("flagCalcLC", "true");		
		//Inicio P-CSR-11002 JLGN 19-08-2011
		request.getSession().setAttribute("clienteExcepcionado", "false");
		//Fin P-CSR-11002 JLGN 19-08-2011 
		logger.debug("inicio, fin");

		return mapping.findForward("inicio");
	}

	private String[] stringEnArray(String s) {
		String[] r = null;
		r = s.split(",");
		return r;
	}

	//---------- (+) buscar simcard ---------------------//	
	public ActionForward buscarSimcard(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		logger.debug("buscarSimcard, inicio");
		DatosLineaForm datosLineaForm = (DatosLineaForm) form;
		logger.debug("datosLineaForm.getLimiteCredito(): " + datosLineaForm.getLimiteCredito());
		logger.debug("datosLineaForm.getNomUsuario(): " + datosLineaForm.getNomUsuario());
		
		if (datosLineaForm.getNumSerie() != null && !datosLineaForm.getNumSerie().equals("")) {
			HttpSession sesion = request.getSession(false);
			SerieAjaxDTO serieSel = new SerieAjaxDTO();
			serieSel.setNumSerie(datosLineaForm.getNumSerie());
			serieSel.setCodProcedencia(global.getValor("serie.procedencia.interna"));
			serieSel.setNumTelefono(datosLineaForm.getNumCelularSimcard());
			serieSel.setFecha(datosLineaForm.getFechaSimcard());
			sesion.setAttribute("serieSel", serieSel);
		}

		logger.debug("buscarSimcard, fin");

		return mapping.findForward("buscarSimcard");
	}

	public ActionForward cargarSimcard(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		logger.debug("cargarSimcard, inicio");
		DatosLineaForm datosLineaForm = (DatosLineaForm) form;
		HttpSession sesion = request.getSession(false);
		logger.debug("datosLineaForm.getLimiteCredito(): " + datosLineaForm.getLimiteCredito());
		logger.debug("datosLineaForm.getNomUsuario(): " + datosLineaForm.getNomUsuario());

		if (sesion.getAttribute("serieSel") != null) {
			SerieAjaxDTO serieSel = (SerieAjaxDTO) sesion.getAttribute("serieSel");
			datosLineaForm.setNumSerie(serieSel.getNumSerie());
			datosLineaForm.setNumCelularSimcard(serieSel.getNumTelefono());
			datosLineaForm.setFechaSimcard(serieSel.getFecha());
			sesion.removeAttribute("serieSel");
		}
		
		//P-CSR-11002 12/04/2011 JLGN
		logger.debug("RA-11002");
		String cedulaIdentidad = global.getValorExterno("modulo.web.cedula.identidad");
		logger.debug("cedulaIdentidad: "+ cedulaIdentidad);
		request.getSession().setAttribute("cedulaIdentidad", cedulaIdentidad);
		
		String cedulaJuridica = global.getValorExterno("modulo.web.cedula.juridica");
		logger.debug("cedulaJuridica: "+ cedulaJuridica);
		request.getSession().setAttribute("cedulaJuridica", cedulaJuridica);
		
		String cedulaOtras = global.getValorExterno("modulo.web.cedula.otras");
		logger.debug("cedulaOtras: "+ cedulaOtras);
		request.getSession().setAttribute("cedulaOtras", cedulaOtras);
		
		logger.debug("cargarSimcard, fin");

		return mapping.findForward("inicio");
	}

	//---------- (-) buscar simcard ---------------------//

	//---------- (+) buscar equipo ---------------------//	
	public ActionForward buscarEquipo(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		logger.debug("buscarEquipo, inicio");
		DatosLineaForm datosLineaForm = (DatosLineaForm) form;
		if (datosLineaForm.getNumEquipo() != null && !datosLineaForm.getNumEquipo().equals("")) {
			HttpSession sesion = request.getSession(false);
			SerieAjaxDTO serieSel = new SerieAjaxDTO();
			serieSel.setNumSerie(datosLineaForm.getNumEquipo());
			serieSel.setCodProcedencia(datosLineaForm.getCodProcedenciaEquipo());
			serieSel.setCodArticuloEquipo(datosLineaForm.getCodArticuloEquipo());
			serieSel.setGlsArticloEquipo(datosLineaForm.getGlsArticuloEquipo());
			serieSel.setNumTelefono(datosLineaForm.getNumCelularEquipo());
			serieSel.setFecha(datosLineaForm.getFechaEquipo());
			sesion.setAttribute("serieSel", serieSel);
		}
		logger.debug("buscarEquipo, fin");

		return mapping.findForward("buscarEquipo");
	}

	public ActionForward cargarEquipo(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		logger.debug("cargarEquipo, inicio");
		DatosLineaForm datosLineaForm = (DatosLineaForm) form;
		HttpSession sesion = request.getSession(false);

		if (sesion.getAttribute("serieSel") != null) {
			SerieAjaxDTO serieSel = (SerieAjaxDTO) sesion.getAttribute("serieSel");
			datosLineaForm.setNumEquipo(serieSel.getNumSerie());
			datosLineaForm.setCodProcedenciaEquipo(serieSel.getCodProcedencia());
			datosLineaForm.setCodArticuloEquipo(serieSel.getCodArticuloEquipo());
			datosLineaForm.setGlsArticuloEquipo(serieSel.getGlsArticloEquipo());
			datosLineaForm.setNumCelularEquipo(serieSel.getNumTelefono());
			datosLineaForm.setFechaEquipo(serieSel.getFecha());
			sesion.removeAttribute("serieSel");
		}
		
		//P-CSR-11002 12/04/2011 JLGN
		logger.debug("RA-11002");
		String cedulaIdentidad = global.getValorExterno("modulo.web.cedula.identidad");
		logger.debug("cedulaIdentidad: "+ cedulaIdentidad);
		request.getSession().setAttribute("cedulaIdentidad", cedulaIdentidad);
		
		String cedulaJuridica = global.getValorExterno("modulo.web.cedula.juridica");
		logger.debug("cedulaJuridica: "+ cedulaJuridica);
		request.getSession().setAttribute("cedulaJuridica", cedulaJuridica);
		
		String cedulaOtras = global.getValorExterno("modulo.web.cedula.otras");
		logger.debug("cedulaOtras: "+ cedulaOtras);
		request.getSession().setAttribute("cedulaOtras", cedulaOtras);

		logger.debug("cargarEquipo, fin");

		return mapping.findForward("inicio");
	}

	//---------- (-) buscar equipo ---------------------//

	//---------- (+) cancelar busqueda de serie ----------//
	public ActionForward cancelarSerie(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		//P-CSR-11002 12/04/2011 JLGN
		logger.debug("RA-11002");
		String cedulaIdentidad = global.getValorExterno("modulo.web.cedula.identidad");
		logger.debug("cedulaIdentidad: "+ cedulaIdentidad);
		request.getSession().setAttribute("cedulaIdentidad", cedulaIdentidad);
		
		String cedulaJuridica = global.getValorExterno("modulo.web.cedula.juridica");
		logger.debug("cedulaJuridica: "+ cedulaJuridica);
		request.getSession().setAttribute("cedulaJuridica", cedulaJuridica);
		
		String cedulaOtras = global.getValorExterno("modulo.web.cedula.otras");
		logger.debug("cedulaOtras: "+ cedulaOtras);
		request.getSession().setAttribute("cedulaOtras", cedulaOtras);
		
		logger.debug("cancelarSerie, inicio");
		logger.debug("cancelarSerie, fin");

		return mapping.findForward("inicio");
	}

	//---------- (-) cancelar busqueda de serie ----------//

	//---------- (+) buscar numero ---------------------//	
	public ActionForward buscarNumero(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.debug("buscarNumero, inicio");
		DatosLineaForm datosLineaForm = (DatosLineaForm) form;
		if (datosLineaForm.getNumCelular() != null && !datosLineaForm.getNumCelular().equals("")) {
			HttpSession sesion = request.getSession(false);
			NumeroAjaxDTO numeroSel = new NumeroAjaxDTO();
			numeroSel.setNumCelular(datosLineaForm.getNumCelular());
			numeroSel.setTablaNumeracion(datosLineaForm.getTablaNumeracion());
			numeroSel.setCategoria(datosLineaForm.getCategoriaNumeracion());
			sesion.setAttribute("numeroSel", numeroSel);
		}
		logger.debug("buscarNumero, fin");
		return mapping.findForward("buscarNumero");
	}

	public ActionForward cargarNumero(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		logger.debug("cargarNumero, inicio");
		DatosLineaForm datosLineaForm = (DatosLineaForm) form;
		HttpSession sesion = request.getSession(false);

		if (sesion.getAttribute("numeroSel") != null) {
			NumeroAjaxDTO numeroSel = (NumeroAjaxDTO) sesion.getAttribute("numeroSel");
			datosLineaForm.setNumCelular(numeroSel.getNumCelular());
			datosLineaForm.setTablaNumeracion(numeroSel.getTablaNumeracion());
			datosLineaForm.setCategoriaNumeracion(numeroSel.getCategoria());
			sesion.removeAttribute("numeroSel");
			//(+) variables usadas en caso de anular la reserva
			datosLineaForm.setCodSubAlmNumeracion(datosLineaForm.getCodSubAlm());
			datosLineaForm.setCodCentralNumeracion(datosLineaForm.getCodCentral());
			datosLineaForm.setCodUsoNumeracion(datosLineaForm.getCodUsoLinea());
			//(-)
		}
		
		//P-CSR-11002 12/04/2011 JLGN
		logger.debug("RA-11002");
		String cedulaIdentidad = global.getValorExterno("modulo.web.cedula.identidad");
		logger.debug("cedulaIdentidad: "+ cedulaIdentidad);
		request.getSession().setAttribute("cedulaIdentidad", cedulaIdentidad);
		
		String cedulaJuridica = global.getValorExterno("modulo.web.cedula.juridica");
		logger.debug("cedulaJuridica: "+ cedulaJuridica);
		request.getSession().setAttribute("cedulaJuridica", cedulaJuridica);
		
		String cedulaOtras = global.getValorExterno("modulo.web.cedula.otras");
		logger.debug("cedulaOtras: "+ cedulaOtras);
		request.getSession().setAttribute("cedulaOtras", cedulaOtras);

		logger.debug("cargarNumero, fin");

		return mapping.findForward("inicio");
	}

	//---------- (-) buscar numero ---------------------//

	//---------- (+) cancelar busqueda de numero ----------//
	public ActionForward cancelarNumero(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		logger.debug("cancelarNumero, inicio");
		
		//P-CSR-11002 12/04/2011 JLGN
		logger.debug("RA-11002");
		String cedulaIdentidad = global.getValorExterno("modulo.web.cedula.identidad");
		logger.debug("cedulaIdentidad: "+ cedulaIdentidad);
		request.getSession().setAttribute("cedulaIdentidad", cedulaIdentidad);
		
		String cedulaJuridica = global.getValorExterno("modulo.web.cedula.juridica");
		logger.debug("cedulaJuridica: "+ cedulaJuridica);
		request.getSession().setAttribute("cedulaJuridica", cedulaJuridica);
		
		String cedulaOtras = global.getValorExterno("modulo.web.cedula.otras");
		logger.debug("cedulaOtras: "+ cedulaOtras);
		request.getSession().setAttribute("cedulaOtras", cedulaOtras);
		
		logger.debug("cancelarNumero, fin");

		return mapping.findForward("inicio");
	}

	//---------- (-) cancelar busqueda de serie ----------//

	//---------- (+) servicios suplementarios ---------------------//
	public ActionForward serviciosSupl(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		logger.debug("serviciosSupl, inicio");
		logger.debug("serviciosSupl, fin");

		return mapping.findForward("serviciosSupl");
	}

	public ActionForward cargarServiciosSupl(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		logger.debug("cargarServiciosSupl, inicio");
		
		//P-CSR-11002 12/04/2011 JLGN
		logger.debug("RA-11002");
		String cedulaIdentidad = global.getValorExterno("modulo.web.cedula.identidad");
		logger.debug("cedulaIdentidad: "+ cedulaIdentidad);
		request.getSession().setAttribute("cedulaIdentidad", cedulaIdentidad);
		
		String cedulaJuridica = global.getValorExterno("modulo.web.cedula.juridica");
		logger.debug("cedulaJuridica: "+ cedulaJuridica);
		request.getSession().setAttribute("cedulaJuridica", cedulaJuridica);
		
		String cedulaOtras = global.getValorExterno("modulo.web.cedula.otras");
		logger.debug("cedulaOtras: "+ cedulaOtras);
		request.getSession().setAttribute("cedulaOtras", cedulaOtras);
		
		logger.debug("cargarServiciosSupl, fin");

		return mapping.findForward("inicio");
	}

	//---------- (-) servicios suplementarios ---------------------//

	//---------- (+) ingreso de direcciones ---------------------//	
	public ActionForward ingresarDireccionPersonal(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		logger.debug("ingresarDireccionPersonal, inicio");
		DatosLineaForm datosLineaForm = (DatosLineaForm) form;
		request.getSession(false).setAttribute("FormularioDireccionDTOSeleccionado",
				datosLineaForm.getDireccionPersonaForm());
		request.getSession(false).setAttribute("CodModuloOrigen", global.getValor("modulo.web.solicitudventa"));
		logger.debug("ingresarDireccionPersonal, fin");

		return mapping.findForward("ingresarDireccionPersonal");
	}

	public ActionForward ingresarDireccionInstalacion(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {

		logger.debug("ingresarDireccionInstalacion, inicio");
		DatosLineaForm datosLineaForm = (DatosLineaForm) form;
		request.getSession(false).setAttribute("FormularioDireccionDTOSeleccionado",
				datosLineaForm.getDireccionInstalacionForm());
		request.getSession(false).setAttribute("CodModuloOrigen", global.getValor("modulo.web.solicitudventa"));
		logger.debug("ingresarDireccionInstalacion, fin");

		return mapping.findForward("ingresarDireccionInstalacion");
	}

	public ActionForward cargarDireccion(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		logger.debug("cargarDireccion, inicio");
		DatosLineaForm datosLineaForm = (DatosLineaForm) form;
		HttpSession sesion = request.getSession(false);

		if (sesion.getAttribute("FormularioDireccionDTO") != null) {
			FormularioDireccionDTO direccionAux = (FormularioDireccionDTO) ((FormularioDireccionDTO) sesion
					.getAttribute("FormularioDireccionDTO")).clone();

			String tipoDireccion = direccionAux.getTipoDireccion();
			if (tipoDireccion.equals("PERS_USU")) {
				datosLineaForm.setDireccionPersonaForm(direccionAux);
				datosLineaForm.setDireccionPersonal(obtenerDireccionAMostrar(datosLineaForm.getDireccionPersonaForm()));
			}
			else if (tipoDireccion.equals("INST_USU")) {
				datosLineaForm.setDireccionInstalacionForm(direccionAux);
				datosLineaForm.setDireccionInstalacion(obtenerDireccionAMostrar(datosLineaForm
						.getDireccionInstalacionForm()));
			}

		}
		logger.debug("cargarDireccion, fin");

		return mapping.findForward("inicio");
	}

	public ActionForward cancelarDireccion(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		logger.debug("cancelarDireccion, inicio");
		logger.debug("cancelarDireccion, fin");

		return mapping.findForward("inicio");
	}

	//---------- (-) ingreso de direcciones ---------------------//	

	//---------- (+) ingreso de numeros frecuentes ---------------------//
	public ActionForward ingresarNumerosFrecuentes(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		logger.debug("ingresarNumerosFrecuentes, inicio");
		logger.debug("ingresarNumerosFrecuentes, fin");

		return mapping.findForward("ingresarNumerosFrecuentes");
	}

	public ActionForward cargarNumerosFrecuentes(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		logger.debug("cargarNumerosFrecuentes, inicio");
		
		//P-CSR-11002 12/04/2011 JLGN
		logger.debug("RA-11002");
		String cedulaIdentidad = global.getValorExterno("modulo.web.cedula.identidad");
		logger.debug("cedulaIdentidad: "+ cedulaIdentidad);
		request.getSession().setAttribute("cedulaIdentidad", cedulaIdentidad);
		
		String cedulaJuridica = global.getValorExterno("modulo.web.cedula.juridica");
		logger.debug("cedulaJuridica: "+ cedulaJuridica);
		request.getSession().setAttribute("cedulaJuridica", cedulaJuridica);
		
		String cedulaOtras = global.getValorExterno("modulo.web.cedula.otras");
		logger.debug("cedulaOtras: "+ cedulaOtras);
		request.getSession().setAttribute("cedulaOtras", cedulaOtras);
		logger.debug("cargarNumerosFrecuentes, fin");

		return mapping.findForward("inicio");
	}

	//---------- (-) ingreso de numeros frecuentes ---------------------//

	//---------- (+) agrega linea solicitud -------//
	public ActionForward agregarSolicitud(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("agregarSolicitud, inicio");
		HttpSession sesion = request.getSession(false);
		AltaLineaWebDTO linea = new AltaLineaWebDTO();
		//Inicio P-CSR-11002 JLGN 24-04-2011
		ActivacionLineaOutDTO datosLinea = new ActivacionLineaOutDTO();
		ActivacionLineaOutDTO[] arrDatosLinea = null;
		int numDatos = 0;
		//Inicio Inc.179734 JLGN 05-01-2012
		String tipIdent = "";
		String numIdent = "";
		//Fin Inc.179734 JLGN 05-01-2012
		//Fin Inicio P-CSR-11002 JLGN 24-04-2011
		
		try {
			DatosVentaForm datosVentaForm = (DatosVentaForm) sesion.getAttribute("DatosVentaForm");
			ServiciosSuplementariosForm ssForm = (ServiciosSuplementariosForm) sesion
					.getAttribute("ServiciosSuplementariosForm");
			//DATOS LINEA		
			DatosLineaForm datosLineaForm = (DatosLineaForm) form;
			
			//Inicio Inc.179734 JLGN 09-01-2012
			DatosClienteBuroDTO buroDDA = (DatosClienteBuroDTO)request.getSession(false).getAttribute("datosClienteBuro2");			
			if(buroDDA.getFlagDDA().equals("true")){
				if(!delegate2.validaLineasClienteDDA(datosLineaForm.getTipoIdentificacionUsuario(), datosLineaForm.getNumeroIdentificacionUsuario())){
					logger.debug("No se puede activar más líneas por tener restricción del Buró y pago con Débito Automático");
					request.setAttribute("mensajeError", "No se puede activar más líneas por tener restricción del Buró y pago con Débito Automático");
					return mapping.findForward("inicio");
				}					
			}
			//Fin Inc.179734 JLGN 09-01-2012

			//DATOS VENTA
			if (datosVentaForm != null) {
				logger.info("datosVentaForm != null");
				//Datos vendedor y Datos del cliente
				setearDatosVenta(linea, datosVentaForm);

				//Setea codigo de actuacion
				//Venta Movil --> VT (Venta Terreno/Externa) - VO(Venta Oficina))
				if (!linea.getCodTipoCliente().trim().equals(global.getValor("tipo.cliente.prepago"))) {
					if (linea.getCodVendedor() != null && !linea.getCodVendedor().trim().equals("")) {
						linea.setCodActabo(global.getValor("codigo.actuacion.movil.externa").trim());
						linea.setIndOfiter(global.getValor("venta.terreno").trim());
					}
					else {
						linea.setCodActabo(global.getValor("codigo.actuacion.movil.interna").trim());
						linea.setIndOfiter(global.getValor("venta.oficina").trim());
					}
				}
				else {
					linea.setCodActabo(global.getValor("codigo.actuacion.prepago").trim());
					//Para prepago siempre es venta en oficina
					linea.setIndOfiter(global.getValor("venta.oficina").trim());
				}

				//Condiciones de venta
				linea.setCodTipoContrato(datosVentaForm.getCodTipoContrato());
				linea.setCodPeriodoContrato(datosVentaForm.getCodPeriodo());
				linea.setCodModalidadVenta(datosVentaForm.getCodModalidadVenta());
				if (!datosVentaForm.getCodModalidadVenta().trim().equals("1")) {
					linea.setCodCuotas(datosVentaForm.getNumCuotas());
				}

				linea.setNumeroVenta(datosVentaForm.getNumeroVenta());
				linea.setNumeroTransaccionVenta(datosVentaForm.getNumeroTransaccionVenta());

				//Tipo Solicitud
				linea.setCodTipoSolicitud(datosVentaForm.getCodTipoSolicitud());
			}
			

			if (datosLineaForm != null) {

				linea.setCodGrpPrestacion(datosLineaForm.getCodGrpPrestacion());
				linea.setCodTipoPrestacion(datosLineaForm.getCodTipoPrestacion());

				if (datosLineaForm.getCodGrpPrestacion().trim()
						.equals(global.getValor("grupo.prestacion.movil").trim())) {
					linea.setCodIndemnizacion(global.getValor("codigo.indemnizacion.movil").trim());
				}
				else {
					linea.setCodIndemnizacion(global.getValor("codigo.indemnizacion.fijo").trim());
				}
				//(+) EV 17/12/09
				linea.setCodNivel1(datosLineaForm.getCodNivel1());
				linea.setCodNivel2(datosLineaForm.getCodNivel2());
				linea.setCodNivel3(datosLineaForm.getCodNivel3());
				//(-) EV 17/12/09

				//Home de linea
				//Inicio P-CSR-11002 JLGN 16-05-2011
				logger.debug("getCodRegion: "+datosLineaForm.getCodRegion());
				logger.debug("getCodProvincia: "+datosLineaForm.getCodProvincia());
				logger.debug("getCodCiudad: "+datosLineaForm.getCodCiudad());
				logger.debug("getCodRegionAux: "+datosLineaForm.getCodRegionAux());
				logger.debug("getCodProvinciaAux: "+datosLineaForm.getCodProvinciaAux());
				logger.debug("getCodCiudadAux: "+datosLineaForm.getCodCiudadAux());
				
				linea.setCodRegion(datosLineaForm.getCodRegionAux());
				linea.setCodProvincia(datosLineaForm.getCodProvinciaAux());
				linea.setCodCiudad(datosLineaForm.getCodCiudadAux());
				
				//linea.setCodRegion(datosLineaForm.getCodRegion());
				//linea.setCodProvincia(datosLineaForm.getCodProvincia());
				//linea.setCodCiudad(datosLineaForm.getCodCiudad());
				//Fin P-CSR-11002 JLGN 16-05-2011
				
				linea.setCodCelda(datosLineaForm.getCodCelda());
				linea.setCodCentral(datosLineaForm.getCodCentral());
				

				//Datos Comerciales
				linea.setCodPlanTarif(datosLineaForm.getCodPlanTarif());
				linea.setCodUsoLinea(Integer.parseInt(datosLineaForm.getCodUsoLinea()));
				linea.setCodTipoTerminal(datosLineaForm.getCodTipoTerminal());
				linea.setCodCreditoConsumo(datosLineaForm.getCodCreditoConsumo());
				String codLimTMP[] = datosLineaForm.getCodLimiteConsumo().split("-");
				linea.setCodLimiteConsumo(codLimTMP[0]);
				linea.setImpLimiteConsumo(datosLineaForm.getMontoLimiteConsumo());
				linea.setCodPlanServicio(datosLineaForm.getCodPlanServicio());
				linea.setCodGrupoCobroServ(datosLineaForm.getCodGrupoCobroServ());
				//linea.setCodCausaDescuento(datosLineaForm.getCodCausaDescuento()); P-CSR-11002 JLGN 25-05-2011
				linea.setCodCausaDescuento("SD"); // Sin descuento P-CSR-11002 JLGN 25-05-2011
				linea.setCodCampanaVigente(datosLineaForm.getCodCampanaVigente());
				logger.debug("linea.getCodCampanaVigente() [" + linea.getCodCampanaVigente() + "]");
				try {
					final double valorRefXMinuto = new Double(datosLineaForm.getValorRefPorMinuto()).doubleValue();
					logger.debug("valorRefXMinuto [" + valorRefXMinuto + "]");
					linea.setValorRefPorMinuto(valorRefXMinuto);
				}
				catch (Exception ex) {
					throw new VentasException("No se pudo obtener el valor de referencia por minuto", ex);
				}

				linea.setCodMoneda(datosLineaForm.getCodMoneda());
				linea.setCodTecnologia(datosLineaForm.getCodTecnologia());

				//Determina si es kit
				linea.setFlgSerieKit(datosLineaForm.getFlgSerieKit());

				//Datos Simcard
				linea.setNumSerie(datosLineaForm.getNumSerie());

				//Datos Equipo
				//Inicio P-CSR-11002 JLGN 18-10-2011
				if(datosLineaForm.getNumEquipo().trim().equals("SIN NUMERO")){
					logger.debug("Entro en la Opcion de Sin Numero");					
					//Se genera numero de Serie Dummy
					String numSerie = generaImeiDummy();
					//Se Llama a funcion que genera un numero de Serie Dummy cuando se Selecciono la opcion de Sin Numero de Equipo
					linea.setNumEquipo(numSerie);
					linea.setCodProcedencia("1");//Procedencia de Equipo Externa
					
					ParametrosGeneralesDTO paramArticuDummy = new ParametrosGeneralesDTO();
					paramArticuDummy.setCodigoproducto(global.getValor("codigo.producto"));
					paramArticuDummy.setCodigomodulo(global.getValor("codigo.modulo.GE"));
					paramArticuDummy.setNombreparametro(global.getValor("parametro.art_ter_dummy"));
					paramArticuDummy = delegate.getParametroGeneral(paramArticuDummy);
					linea.setCodArticuloSerieTerminal(paramArticuDummy.getValorparametro());					
					String desArticulo = delegate.descripcionArticulo(paramArticuDummy.getValorparametro());
					linea.setDescArticuloEquipo(desArticulo);					
				}else{
					linea.setNumEquipo(datosLineaForm.getNumEquipo());
					linea.setCodProcedencia(datosLineaForm.getCodProcedenciaEquipo());
					linea.setCodArticuloSerieTerminal(datosLineaForm.getCodArticuloEquipo());
					linea.setDescArticuloEquipo(datosLineaForm.getGlsArticuloEquipo());
				}
				//Fin P-CSR-11002 JLGN 18-10-2011

				//Datos del seguro
				linea.setCodigoSeguro(datosLineaForm.getCodTipoSeguro());
				linea.setVigenciaSeguro(datosLineaForm.getVigenciaSeguro());

				//Numeracion			
				linea.setNumCelular(datosLineaForm.getNumCelular());

				//Servicios
				ArrayList listaServicios = (ArrayList) sesion.getAttribute("listaServiciosAct");

				if (listaServicios != null) {
					linea.setListaServicios((ListadoSSOutDTO[]) ArrayUtl.copiaArregloTipoEspecifico(listaServicios
							.toArray(), ListadoSSOutDTO.class));
				}
				
				
				//Inicio P-CSR-11002 JLGN 21-04-2011
				if (this.getPlanesAdicionalesScoringForm(request) != null) {
					final String csvPA = this.getPlanesAdicionalesScoringForm(request).getProductosSeleccionadosEnCSV();
					this.getPlanesAdicionalesScoringForm(request).setProductosSeleccionadosEnCSV(null);
					logger.debug("csvPA [" + csvPA + "]");
					if (csvPA != null && !csvPA.equals("")) {
						String[] seleccionados = csvPA.split(",");
						final int cantPASeleccionados = seleccionados.length;
						logger.debug("Cant. PP.AA. Seleccionados [" + cantPASeleccionados + "]");
						ProductoOfertadoDTO[] arrayPA = new ProductoOfertadoDTO[cantPASeleccionados];
						for (int i = 0; i < cantPASeleccionados; i++) {
							final String[] splitted = seleccionados[i].split("=");
							ProductoOfertadoDTO dto = arrayPA[i] = new ProductoOfertadoDTO();
							dto.setCodProductoOfertado(Long.parseLong(splitted[0]));
							dto.setCantidad(Long.parseLong(splitted[1]));
							dto.setCodCliente(Long.parseLong(datosVentaForm.getCodCliente()));
						}
						linea.setArrayPA(arrayPA);
						if (linea.getArrayPA() != null) {
							logger.debug("linea.getArrayPA().length [" + linea.getArrayPA().length + "]");
							for (int i = 0; i < linea.getArrayPA().length; i++) {
								logger.debug("linea.getArrayPA()[i].toString() [" + linea.getArrayPA()[i].toString() + "]");
							}
						}
						else {
							logger.debug("linea.getArrayPA() tiene valor [null]");
						}
					}
					else {
						linea.setArrayPA(null);
						logger.debug("linea.getArrayPA() tiene valor [null] 2");
					}
				}
				else {
					linea.setArrayPA(null);
					logger.debug("linea.getArrayPA() tiene valor [null] 3");
				}
				
				/*inicio JMO 16-11-2010 INC-155400
				 * Si no existen Planes Adicionales seleccionados, se obtienen los planes opcionales
				 * obligatorios al Plan Tarifario.
				 * */
				logger.debug("linea.getCodTipoCliente().trim()["+linea.getCodTipoCliente().trim()+"]");
				if(!linea.getCodTipoCliente().trim().equals(global.getValor("tipo.cliente.prepago"))){ //INC 185192 JVA Soporte Ventas 06-06-2012
					if(linea.getArrayPA() == null){
					logger.debug("no se selecciono PA ");	
				
					final String codCanal = global.getValor("canal.pa.venta");
					final String nivel = global.getValor("nivel.pa.abonado");
					
					//final String codPlanTarif = (String)request.getSession().getAttribute("codPlanTarif");
					//final String codPrestacion = (String)request.getSession().getAttribute("codPrestacion");
					
					final String codPlanTarif = datosLineaForm.getCodPlanTarif();
					final String codPrestacion = datosLineaForm.getCodTipoPrestacion();
					
					logger.debug("codCanal: "+codCanal);
					logger.debug("nivel: "+nivel);
					logger.debug("codPlanTarif: "+codPlanTarif);
					logger.debug("codPrestacion: "+codPrestacion);
					
						ProductoOfertadoDTO[] productosOblig = delegate.obtenerProductosObligatoriosPT(codPlanTarif, codCanal,
										  nivel, codPrestacion);
					
						if(productosOblig != null){
							
							int cantPAObligatorios = productosOblig.length;
							
							ProductoOfertadoDTO[] arrayPA = new ProductoOfertadoDTO[cantPAObligatorios];
							for (int i = 0; i < cantPAObligatorios; i++) {
								ProductoOfertadoDTO dto = arrayPA[i] = new ProductoOfertadoDTO();
								dto.setCodProductoOfertado(productosOblig[i].getCodProductoOfertado());
								dto.setCantidad(productosOblig[i].getCantidad());
								dto.setCodCliente(Long.parseLong(datosVentaForm.getCodCliente()));
							}
							linea.setArrayPA(arrayPA);
							
							if (linea.getArrayPA() != null) {
								logger.debug("PA_Obligatorios linea.getArrayPA().length [" + linea.getArrayPA().length + "]");
								for (int i = 0; i < linea.getArrayPA().length; i++) {
									logger.debug("PA_Obligatorios linea.getArrayPA()[i].toString() [" + linea.getArrayPA()[i].toString() + "]");
								}
							}else {
								logger.debug("PA_Obligatorios linea.getArrayPA() tiene valor [null]");
							}
						}else{
							logger.debug("No existen PA obligatorios configurados. productosOblig = null ");
						}
					}
				}//fin JMO 16-11-2010 INC-155400
				
				
				//Fin P-CSR-11002 JLGN 21-04-2011

				if (ssForm != null && ssForm.getNumFax() != null)
					linea.setNumFax(new Long(ssForm.getNumFax()).longValue());

				//Contactos
				/*ArrayList listaContactos = (ArrayList) sesion.getAttribute("listaContactos");
				 if(listaContactos != null)
				 {
				 linea.setListaContactos((GaContactoAbonadoToDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
				 listaContactos.toArray(), GaContactoAbonadoToDTO.class));						
				 }*/

				if (ssForm != null && ssForm.getContactosTabla() != null && !ssForm.getContactosTabla().equals("")) {
					String listaContactosString = ssForm.getContactosTabla();
					logger.debug("listaContactosString: [" + listaContactosString + "]");
					GaContactoAbonadoToDTO[] listaContactos = string2ArrayContactos(listaContactosString);
					linea.setListaContactos(listaContactos);
				}

				//Numeros sms
				if (datosLineaForm != null && datosLineaForm.getArrayNumerosSms() != null
						&& datosLineaForm.getArrayNumerosSms().length > 0) {
					linea.setListaNumerosSMS(datosLineaForm.getArrayNumerosSms());
				}

				//Datos de red
				linea.setObservacion(datosLineaForm.getObservacion());

				//Datos de usuario
				UsuarioWebDTO usuario = new UsuarioWebDTO();
				usuario.setNomUsuario(datosLineaForm.getNomUsuario());
				usuario.setTipIdent(datosLineaForm.getTipoIdentificacionUsuario());
				usuario.setNumIdent(datosLineaForm.getNumeroIdentificacionUsuario());
				usuario.setNomApell1(datosLineaForm.getApellido1());
				usuario.setNomApell2(datosLineaForm.getApellido2());
				usuario.setNumTelefono(datosLineaForm.getTelefono());

				/* Direcciones */
				ArrayList listaDir = new ArrayList();
				DireccionNegocioWebDTO[] listaDirecciones = null;
				DireccionNegocioWebDTO direccion = new DireccionNegocioWebDTO();

				/*Direccion Personal*/
				if (datosLineaForm.getDireccionPersonaForm() != null
						&& datosLineaForm.getDireccionPersonaForm().getCOD_REGION() != null
						&& !datosLineaForm.getDireccionPersonaForm().getCOD_REGION().trim().equals("")) {
					direccion = new DireccionNegocioWebDTO();
					direccion.setCodDepartamento(datosLineaForm.getDireccionPersonaForm().getCOD_REGION());
					direccion.setCodigoPostalDireccion(datosLineaForm.getDireccionPersonaForm().getZIP());
					direccion.setCodMunicipio(datosLineaForm.getDireccionPersonaForm().getCOD_PROVINCIA());
					direccion.setCodSiglaDomicilio(datosLineaForm.getDireccionPersonaForm().getCOD_TIPOCALLE());
					direccion.setCodZonaDistrito(datosLineaForm.getDireccionPersonaForm().getCOD_CIUDAD());
					direccion.setLocBarrio(datosLineaForm.getDireccionPersonaForm().getCOD_COMUNA());
					logger.trace("direccion.getLocBarrio() [" + direccion.getLocBarrio() + "]");
					direccion.setDesDirec1(datosLineaForm.getDireccionPersonaForm().getDES_DIREC1());
					logger.trace("direccion.getDesDireccion1() [" + direccion.getDesDirec1() + "]");
					direccion.setNombreCalle(datosLineaForm.getDireccionPersonaForm().getNOM_CALLE());
					direccion.setNumeroCalle(datosLineaForm.getDireccionPersonaForm().getNUM_CALLE());
					direccion.setObservacionDireccion(datosLineaForm.getDireccionPersonaForm().getOBS_DIRECCION());
					direccion.setDesDirec2(datosLineaForm.getDireccionPersonaForm().getDES_DIREC2());
					direccion.setTipo(Integer.valueOf(global.getValor("codigo.tipo.dir.personal").trim()).intValue());
					direccion.setReplicada(false);
					listaDir.add(direccion);
				}
				direccion = new DireccionNegocioWebDTO();

				/*Direccion Instalacion (Se guardara en la direccion de correspondencia) */
				if (datosLineaForm.getDireccionInstalacionForm() != null
						&& datosLineaForm.getDireccionInstalacionForm().getCOD_REGION() != null
						&& !datosLineaForm.getDireccionInstalacionForm().getCOD_REGION().trim().equals("")) {
					direccion.setCodDepartamento(datosLineaForm.getDireccionInstalacionForm().getCOD_REGION());
					direccion.setCodigoPostalDireccion(datosLineaForm.getDireccionInstalacionForm().getZIP());
					direccion.setCodMunicipio(datosLineaForm.getDireccionInstalacionForm().getCOD_PROVINCIA());
					direccion.setCodSiglaDomicilio(datosLineaForm.getDireccionInstalacionForm().getCOD_TIPOCALLE());
					direccion.setCodZonaDistrito(datosLineaForm.getDireccionInstalacionForm().getCOD_CIUDAD());
					direccion.setLocBarrio(datosLineaForm.getDireccionInstalacionForm().getCOD_COMUNA());
					direccion.setNombreCalle(datosLineaForm.getDireccionInstalacionForm().getNOM_CALLE());
					direccion.setNumeroCalle(datosLineaForm.getDireccionInstalacionForm().getNUM_CALLE());
					direccion.setObservacionDireccion(datosLineaForm.getDireccionInstalacionForm().getOBS_DIRECCION());
					direccion.setTipo(Integer.valueOf(global.getValor("codigo.tipo.dir.correspondencia").trim())
							.intValue());
					direccion.setReplicada(datosLineaForm.getDireccionInstalacionForm().isDireccionReplicada());
					direccion.setDesDirec1(datosLineaForm.getDireccionInstalacionForm().getDES_DIREC1());
					direccion.setDesDirec2(datosLineaForm.getDireccionInstalacionForm().getDES_DIREC2());
					listaDir.add(direccion);
				}

				listaDirecciones = (DireccionNegocioWebDTO[]) ArrayUtl.copiaArregloTipoEspecifico(listaDir.toArray(),
						DireccionNegocioWebDTO.class);
				usuario.setDirecciones(listaDirecciones);

				linea.setUsuario(usuario);

				String user = ((ParametrosGlobalesDTO) sesion.getAttribute("paramGlobal")).getCodUsuario();
				linea.setNombreUsuarOra(user);

				//(+) Indica si es renovacion segunda linea
				int indRenovacionLinea = 0;
				if (datosLineaForm.getCodRenovacion() != null && datosLineaForm.getCodRenovacion().equals("1")) {
					indRenovacionLinea = 1;
				}
				linea.setIndRenovacion(indRenovacionLinea);
				//(-)

				//VALIDAR EXISTENCIA DE LOS PRECIOS CUANDO ES UNA VENTA MOVIL
				if (linea.getCodGrpPrestacion().trim().equals("TM")
						&& (linea.getCodTecnologia().trim().equals("GSM") || linea.getCodTecnologia().trim().equals(
								"CDMA"))) {
					ParametrosValidacionVentasDTO parametros = new ParametrosValidacionVentasDTO();
					parametros.setNumeroSerie(linea.getNumSerie());
					parametros.setCodigoPlanTarifario(linea.getCodPlanTarif());
					parametros.setModalidadVenta(Integer.parseInt(linea.getCodModalidadVenta()));
					parametros.setCodigoTipoContrato(linea.getCodTipoContrato());
					parametros.setCodigoUsoLinea(linea.getCodUsoLinea());
					parametros.setNumeroSerieTerminal(linea.getNumEquipo());
					parametros.setCodigoCalificacion(linea.getCodCalificacion());
					parametros.setTipoCliente(linea.getCodTipoCliente());
					parametros.setCodigoActuacion(linea.getCodActabo());
					parametros.setCodigoTecnologia(linea.getCodTecnologia());
					parametros.setIndRenovacion(indRenovacionLinea);
					ResultadoValidacionVentaDTO resultado = delegate.validacionLineaWeb(parametros);
					linea.setImporteSeguro(resultado.getPrecioEquipo());
				}
				linea.setTipoPrimariaCarrier(global.getValorExterno("valor.tipo.primaria"));
				//GRABAR
				//Inicio P-CSR-11002 JLGN 17-05-2011
				String flagConsultaCalificacion = (String) sesion.getAttribute("flagConsultaCalificacion");
				if (flagConsultaCalificacion.equals("true")){
					//Inserta en la tabla ve_excepcion_calificacion_td
					logger.debug("Inserta en la tabla ve_excepcion_calificacion_td");						
					logger.debug("usuario oracle: "+user);
					logger.debug("cod cliente: "+datosVentaForm.getCodCliente());
					logger.debug("cod plantarif: "+datosLineaForm.getCodPlanTarif());
					logger.debug("cod password: "+datosLineaForm.getPassCalificacion());
					logger.debug("cod Calificacion: "+datosLineaForm.getCodCalificacion());
					logger.debug("Limite de Credito: "+datosLineaForm.getLimiteCredito());
					logger.debug("Limite de Credito Ingresado: "+datosLineaForm.getLimiteCreditoIngresado());
					//P-CSR-11002 JLGN 18-08-2011
					DatosClienteBuroDTO buro = (DatosClienteBuroDTO)request.getSession(false).getAttribute("datosClienteBuro2");
					logger.debug("buro.getLimiteDeCredito(): "+buro.getLimiteDeCredito());
					delegate.insExcepcioCalificacion(datosVentaForm.getCodCliente(), datosLineaForm.getCodPlanTarif(), user, datosLineaForm.getPassCalificacion(), datosLineaForm.getLimiteCredito());
				}				
				//Fin P-CSR-11002 JLGN 17-05-2011
				//Inicio P-CSR-11002 JLGN 24-04-2011
				//delegate.altaLineaWeb(linea);
				datosLinea = delegate.altaLineaWeb(linea);
				logger.debug("Fin delegate.altaLineaWeb(linea)");
				logger.debug("Obtiene Arreglo de Sesion");
				arrDatosLinea = (ActivacionLineaOutDTO[])request.getSession().getAttribute("datosLineas");
				
				if (arrDatosLinea == null){
					logger.debug("Arreglo de Sesion es NULL");
					logger.debug("Largo del Arreglo: "+ numDatos);
					arrDatosLinea = new ActivacionLineaOutDTO[numDatos + 1];
					logger.debug("Inicio Traspaso de Datos");
					arrDatosLinea[numDatos] = datosLinea;
					logger.debug("Fin Traspaso de Datos");
					logger.debug("Guarda Datos en Sesion");
					request.getSession().setAttribute("datosLineas", arrDatosLinea);
				}else{
					logger.debug("Arreglo de Sesion no es NULL");
					numDatos = arrDatosLinea.length;
					logger.debug("Largo del Arreglo: "+ numDatos);
					ActivacionLineaOutDTO[] arrDatosLinea2 = new ActivacionLineaOutDTO[numDatos+1];
					
					for(int i=0; i <numDatos;i++){
						arrDatosLinea2[i]=arrDatosLinea[i]; 
					}
					logger.debug("Inicio Traspaso de Datos");
					arrDatosLinea2[numDatos] = datosLinea;
					logger.debug("Fin Traspaso de Datos");
					logger.debug("Guarda Datos en Sesion");
					request.getSession().setAttribute("datosLineas", arrDatosLinea2);					
				}
				
				//request.getSession().setAttribute("datosLineas", datosLinea);				
				//Fin P-CSR-11002 JLGN 24-04-2011			
				//Inicio P-CSR-11002 JLGN 05-07-2011
				logger.debug("datosLineaForm.getCodUsoLinea(): "+datosLineaForm.getCodUsoLinea());
				if(!datosLineaForm.getCodUsoLinea().equals("3")){
					long cargoPT = delegate.getCargoPlanTarif(datosLineaForm.getCodPlanTarif());
					DatosClienteBuroDTO buroDTO = (DatosClienteBuroDTO)request.getSession(false).getAttribute("datosClienteBuro2");
					logger.debug("CargoPT: "+cargoPT);
					logger.debug("Limite de Credito Antiguo: "+buroDTO.getLimiteDeCredito());
					long auxCargoPT = 0;
					auxCargoPT = Long.parseLong(buroDTO.getLimiteDeCredito())-cargoPT;
					logger.debug("Limite de Credito Nuevo: "+ auxCargoPT);
					buroDTO.setLimiteDeCredito(String.valueOf(auxCargoPT));
					logger.debug("Guarda variable de sesion");
					request.getSession().setAttribute("datosClienteBuro2", buroDTO);
					request.getSession().setAttribute("flagCalcLC", "true");
				}
				//limpia datos en pantalla
				inicializarLinea(datosLineaForm, request);		
				//Inicio P-CSR-11002 JLGN 19-08-2011
				String unaLineaBuro = (String) sesion.getAttribute("unaLineaBuro");
				
				logger.debug("unaLineaBuro: "+unaLineaBuro);
				if(unaLineaBuro.equals("true")){
					request.getSession().removeAttribute("clienteExcepcionado");
					request.getSession().setAttribute("clienteExcepcionado", "true");
				}
				//Fin P-CSR-11002 JLGN 19-08-2011
				
				//Inicio Inc.179734 25-01-2012 JLGN
				logger.debug("1º Se valida si Cliente tiene mensaje de Error");
				
				DatosClienteBuroDTO buroDAA = (DatosClienteBuroDTO)request.getSession(false).getAttribute("datosClienteBuro2");
				tipIdent = (String)request.getSession(false).getAttribute("tipIdentDDA");
				numIdent = (String)request.getSession(false).getAttribute("numIdentDDA");
				
				if(buroDAA.getFlagDDA().equals("true")){
					logger.debug("3ºSe valida la forma de Pago del cliente");
					if(!delegate2.validaClienteDDA(datosVentaForm.getCodCliente())){
						logger.debug("Cliente no tiene Domiciliacián Automatica, se debe Ejecutar la OOSS Modificación Datos Bancarios del Cliente y luego realizar la Venta.");
						request.setAttribute("mensajeError", "Cliente no tiene Domiciliacián Automatica, se debe Ejecutar la OOSS Modificación Datos Bancarios del Cliente " +
															 "y luego realizar la Venta.");		        	
					}else{
						//4º Se valida si el cliente tiene mas de 3 lineas contratadas
						logger.debug("4º Se valida si el cliente tiene mas de 3 lineas contratadas");
						if(!delegate2.validaLineasClienteDDA(tipIdent, numIdent)){
							logger.debug("No se puede activar más líneas por tener restricción del Buró y pago con Débito Automático");
							request.setAttribute("mensajeError", "No se puede activar más líneas por tener restricción del Buró y pago con Débito Automático");		        	
						}
					}	
					
				}
				
				//Fin Inc.179734 25-01-2012 JLGN
			}
		}
		catch (VentasException e) {
			String mensaje = e.getDescripcionEvento() == null ? " " : e.getDescripcionEvento();
			logger.error(StackTraceUtl.getStackTrace(e));
			request.setAttribute("mensajeError", "Ocurrio un error al agregar linea " + mensaje);
			logger.error("[VentasException] Ocurrio un error al agregar linea " + mensaje);
		}
		catch (Exception e) {
			String mensaje = e.getMessage() == null ? " " : e.getMessage();
			request.setAttribute("mensajeError", "Ocurrio un error al agregar linea " + mensaje);
			logger.error(StackTraceUtl.getStackTrace(e));
			logger.error("[Exception] Ocurrio un error al agregar linea " + mensaje);
		}
		logger.info("agregarSolicitud, fin");
		return mapping.findForward("inicio");
	}

	//---------- (-) agrega linea solicitud -------//

	//---------- (+) finaliza solicitud y muestra resultado -------//
	public ActionForward finalizarSolicitud(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.debug("finalizarSolicitud Datos Linea Action, inicio");
		HttpSession sesion = request.getSession(false);
		AltaLineaWebDTO linea = new AltaLineaWebDTO();
		
		//Inicio P-CSR-11002 JLGN 24-04-2011
		ActivacionLineaOutDTO[] arrDatosLinea = null;
		long[]arrayNumAbonado;
		long[]arrayNumMovimiento;
		//Fin P-CSR-11002 JLGN 24-04-2011
		DatosVentaForm datosVentaForm = (DatosVentaForm) sesion.getAttribute("DatosVentaForm");
		DatosLineaForm datosLineaForm = (DatosLineaForm) form;

		try {
			//DATOS VENTA
			if (datosVentaForm != null) {
				//Datos vendedor y Datos del cliente
				setearDatosVenta(linea, datosVentaForm);

				//Setea codigo de actuacion
				//Venta Movil --> VT (Venta Terreno/Externa) - VO(Venta Oficina))
				if (!linea.getCodTipoCliente().trim().equals(global.getValor("tipo.cliente.prepago"))) {
					if (linea.getCodVendedor() != null && !linea.getCodVendedor().trim().equals("")) {
						linea.setCodActabo(global.getValor("codigo.actuacion.movil.externa").trim());
						linea.setIndOfiter(global.getValor("venta.terreno").trim());
					}
					else {
						linea.setCodActabo(global.getValor("codigo.actuacion.movil.interna").trim());
						linea.setIndOfiter(global.getValor("venta.oficina").trim());
					}
				}
				else {
					linea.setCodActabo(global.getValor("codigo.actuacion.prepago").trim());
					//Para prepago siempre es venta en oficina
					linea.setIndOfiter(global.getValor("venta.oficina").trim());
				}

				//Datos cliente facturable
				ClienteFacturaForm clienteFacturaForm = (ClienteFacturaForm) sesion.getAttribute("ClienteFacturaForm");
				if (clienteFacturaForm != null) {
					linea.setNombreClienteFactura(clienteFacturaForm.getNombreClienteFactura());
					linea.setApellido1ClienteFactura(clienteFacturaForm.getApellido1ClienteFactura());
					linea.setApellido2ClienteFactura(clienteFacturaForm.getApellido2ClienteFactura());
					linea.setTipoIdentClienteFactura(clienteFacturaForm.getTipoIdentClienteFactura());
					linea.setNumeroIdentClienteFactura(clienteFacturaForm.getNumeroIdentClienteFactura());
				}

				//Condiciones de venta
				linea.setCodTipoContrato(datosVentaForm.getCodTipoContrato());
				linea.setCodPeriodoContrato(datosVentaForm.getCodPeriodo());
				linea.setCodModalidadVenta(datosVentaForm.getCodModalidadVenta());
				if (!datosVentaForm.getCodModalidadVenta().trim().equals("1")) {
					linea.setCodCuotas(datosVentaForm.getNumCuotas());
				}

				//TODO
				String user = ((ParametrosGlobalesDTO) sesion.getAttribute("paramGlobal")).getCodUsuario();
				logger.debug("usuario ORACLE: "+user);
				linea.setNombreUsuarOra(user);
				linea.setNumeroVenta(datosVentaForm.getNumeroVenta());
				linea.setNumeroTransaccionVenta(datosVentaForm.getNumeroTransaccionVenta());

				//Tipo Solicitud
				linea.setCodTipoSolicitud(datosVentaForm.getCodTipoSolicitud());
			}
			//GRABAR
			
			//Inicio P-CSR-11002 JLGN 24-04-2011
			arrDatosLinea = (ActivacionLineaOutDTO[])request.getSession().getAttribute("datosLineas");
			
			arrayNumAbonado = new long[arrDatosLinea.length];
			arrayNumMovimiento = new long[arrDatosLinea.length];
			
			for(int i=0;i<arrDatosLinea.length;i++){
				arrayNumAbonado[i] = arrDatosLinea[i].getNumAbonado().longValue();
				arrayNumMovimiento[i] = arrDatosLinea[i].getNumMovimiento();				
			}
			
			linea.setArrayNumAbonado(arrayNumAbonado);
			linea.setArrayNumMovimiento(arrayNumMovimiento);
			
			//Fin P-CSR-11002 JLGN 24-04-2011
			
			delegate.altaVentaWeb(linea);
		}
		catch (VentasException e) {
			String mensaje = e.getDescripcionEvento() == null ? " " : e.getDescripcionEvento();
			request.setAttribute("mensajeError", "Ocurrio un error al finalizar solicitud " + mensaje);
			logger.debug("[VentasException]Ocurrio un error al finalizar solicitud " + mensaje);
			return mapping.findForward("inicio");
		}
		catch (Exception e) {
			String mensaje = e.getMessage() == null ? " " : e.getMessage();
			request.setAttribute("mensajeError", "Ocurrio un error al finalizar solicitud " + mensaje);
			logger.debug("[Exception]Ocurrio un error al finalizar solicitud " + mensaje);
			return mapping.findForward("inicio");
		}

		logger.debug("finalizarSolicitud, fin");

		try {
			//desbloquear vendedor
			logger.debug("Desbloquea Vendedor");
			if (datosVentaForm != null && !datosVentaForm.getCodDistribuidor().equals("")) {
				VendedorDTO entrada = new VendedorDTO();
				entrada.setCodigoVendedor(datosVentaForm.getCodDistribuidor());
				entrada.setCodigoAccionBloqueo(global.getValor("accion.desbloqueo.vendedor"));
				delegate.bloqueaDesbloqueaVendedor(entrada);
			}
		}
		catch (Exception e) {
			request.setAttribute("mensajeError", "Ocurrio un error al desbloquear vendedor");
		}

		//Resultado
		logger.debug("Resultado Venta");
		ResultadoSolicitudVentaDTO resultadoSolVenta = new ResultadoSolicitudVentaDTO();
		resultadoSolVenta.setCodCliente(datosVentaForm.getCodCliente());
		resultadoSolVenta.setNumeroVenta(String.valueOf(datosVentaForm.getNumeroVenta()));
		sesion.setAttribute("resultadoSolVenta", resultadoSolVenta);
		logger.debug("datosLineaForm.getCodTipoCliente(): "+datosLineaForm.getCodTipoCliente());
		logger.debug("datosLineaForm.getCodTipoClientePrepago(): "+datosLineaForm.getCodTipoClientePrepago());

		//Inicio P-CSR-11002 26-04-2011 JLGN 		
		//if (datosLineaForm.getCodTipoCliente().equals(datosLineaForm.getCodTipoClientePrepago())) {
			//limpiar sesion
			logger.debug("limpia sesion");
			limpiarSesion(request);
			return mapping.findForward("mostrarResultado");
		/*}
		else {
			logger.debug("retorna mapping.findforware");
			datosLineaForm.setFlgConsultaPA("1");
			return mapping.findForward("inicio");
		}Fin P-CSR-11002 26-04-2011 JLGN*/
			

	}

	public ActionForward contratarPlanesDefecto(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.debug("contratarPlanesDefecto, inicio");
		HttpSession sesion = request.getSession(false);
		DatosVentaForm datosVentaForm = (DatosVentaForm) sesion.getAttribute("DatosVentaForm");
		try {
			DatosVentaDTO datosVenta = new DatosVentaDTO();
			datosVenta.setNum_venta(String.valueOf(datosVentaForm.getNumeroVenta()));
			datosVenta.setCod_cliente(datosVentaForm.getCodCliente());
			datosVenta.setNum_transaccion(String.valueOf(datosVentaForm.getNumeroTransaccionVenta()));
			datosVenta.setNum_evento("0");
			String user = ((ParametrosGlobalesDTO) sesion.getAttribute("paramGlobal")).getCodUsuario();
			datosVenta.setCod_vendedor(user);
			datosVenta.setFlag_ciclo("0");
			datosVenta.setCod_proceso("VT");
			delegate.sendToQueueActivacionProductosPorDefecto(datosVenta);

		}
		catch (VentasException e) {
			logger.debug("[VentasException]");
			String mensaje = e.getDescripcionEvento() == null ? " Ocurrió un error al contratar planes por defecto" : e
					.getDescripcionEvento();
			logger.debug(mensaje);
		}
		catch (Exception e) {
			logger.debug("[Exception]");
			String mensaje = e.getMessage() == null ? " Ocurrió un error al contratar planes por defecto" : e
					.getMessage();
			logger.debug(mensaje);
		}

		limpiarSesion(request);
		logger.debug("contratarPlanesDefecto, fin");

		return mapping.findForward("mostrarResultado");
	}

//	public ActionForward irAPlanesAdicionales(ActionMapping mapping, ActionForm form, HttpServletRequest request,
//			HttpServletResponse response) throws Exception {
//		logger.debug("irAPlanesAdicionales, inicio");
//		logger.debug("irAPlanesAdicionales, fin");
//		return mapping.findForward("contratarPlanesAdicionales");
//	}

	//Inicio P-CSR-11002 19-04-2011 JLGN
	public ActionForward irAPlanesAdicionales(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("irAPlanesAdicionales, inicio");
		logger.info("irAPlanesAdicionales, fin");
		
		DatosLineaForm datosLineaForm = (DatosLineaForm) form;
		
		logger.info("codPlantarif: "+datosLineaForm.getCodPlanTarif());
		logger.info("codPlantarifSeleccionado: "+datosLineaForm.getCodPlanTarifSeleccionado());
				
		request.getSession().setAttribute("codPlanTarif", datosLineaForm.getCodPlanTarif());
		request.getSession().setAttribute("codPrestacion", datosLineaForm.getCodTipoPrestacion());
		
		return mapping.findForward("irAPlanesAdicionales");
	}
	//Fin P-CSR-11002 19-04-2011 JLGN
	
	//---------- (-) finaliza solicitud y muestra resultado -------//
	public ActionForward irAMenu(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.debug("irAMenu, inicio");
		HttpSession sesion = request.getSession(false);
		//desbloquear vendedor 
		DatosVentaForm datosVentaForm = (DatosVentaForm) sesion.getAttribute("DatosVentaForm");
		//DATOS VENTA
		if (datosVentaForm != null && !datosVentaForm.getCodDistribuidor().equals("")) {
			VendedorDTO entrada = new VendedorDTO();
			entrada.setCodigoVendedor(datosVentaForm.getCodDistribuidor());
			entrada.setCodigoAccionBloqueo(global.getValor("accion.desbloqueo.vendedor"));
			delegate.bloqueaDesbloqueaVendedor(entrada);
		}
		//limpiar sesion
		limpiarSesion(request);
		logger.debug("irAMenu, fin");
		return mapping.findForward("irAMenu");
	}

	public ActionForward irAMenuFinal(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.debug("irAMenuFinal, inicio");
		logger.debug("irAMenuFinal, fin");
		return mapping.findForward("irAMenu");
	}

	public ActionForward anterior(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.debug("anterior, inicio");
		HttpSession sesion = request.getSession(false);
		DatosLineaForm datosLineaForm = (DatosLineaForm) form;
		if (datosLineaForm.getFlgActivarBtnFinalizar().equals("1")) {//reversar
			try {
				DatosVentaForm datosVentaForm = (DatosVentaForm) sesion.getAttribute("DatosVentaForm");
				String user = ((ParametrosGlobalesDTO) sesion.getAttribute("paramGlobal")).getCodUsuario();
				String codVendedor = datosVentaForm.getCodVendedor().trim().equals("") ? datosVentaForm
						.getCodDistribuidor() : datosVentaForm.getCodVendedor();
				GaVentasDTO gaVentasDTO = new GaVentasDTO();
				gaVentasDTO.setNumVenta(new Long(datosVentaForm.getNumeroVenta()));
				gaVentasDTO.setCodVendedor(new Long(codVendedor));
				gaVentasDTO.setNomUsuarVta(user);
				gaVentasDTO.setNumProceso(new Long(0));
				delegate.reversaVenta(gaVentasDTO);
			}
			catch (VentasException e) {
				String mensaje = e.getDescripcionEvento() == null ? " Ocurrio un error al reversar venta" : e
						.getDescripcionEvento();
				request.setAttribute("mensajeError", mensaje);
				logger.debug("[VentasException]" + mensaje);
				return mapping.findForward("inicio");
			}
			catch (Exception e) {
				String mensaje = e.getMessage() == null ? " Ocurrio un error al reversar venta" : e.getMessage();
				request.setAttribute("mensajeError", mensaje);
				logger.debug("[Exception]" + mensaje);
				return mapping.findForward("inicio");
			}
		}

		//limpiar sesion
		sesion.removeAttribute("BuscaSeriesForm");
		sesion.removeAttribute("BuscaNumeroForm");
		sesion.removeAttribute("ServiciosSuplementariosForm");
		sesion.removeAttribute("DireccionForm");
		sesion.removeAttribute("listaSeries");
		sesion.removeAttribute("listaNumeros");
		sesion.removeAttribute("listaNumerosRango");
		sesion.removeAttribute("listaServiciosDef");
		sesion.removeAttribute("listaServiciosAct");
		sesion.removeAttribute("listaServiciosDisp");
		sesion.removeAttribute("numeroSel");
		sesion.removeAttribute("serieSel");
		//sesion.removeAttribute("DatosLineaForm");

		logger.debug("anterior, fin");
		return mapping.findForward("anterior");
	}

	/**
	 * @author JIB
	 * @param linea
	 * @param f
	 * 
	 * Incidencia 144182 - Error al limpiar vendedor dealer
	 */
	private void setearDatosVenta(AltaLineaWebDTO linea, DatosVentaForm f) {
		logger.info("setearDatosVenta, inicio");
		linea.setCodTipoComisionista(f.getCodTipoComisionista());
		linea.setCodOficina(f.getCodOficina());
		linea.setCodDistribuidor(f.getCodDistribuidor());
		linea.setCodVendedor(f.getCodVendedor());
		logger.debug("f.getIndVtaExterna() [" + f.getIndVtaExterna() + "]");
		if (f.getIndVtaExterna().equals("0")) {
			linea.setCodVendedor(null); //No se guarda dealer
		}
		logger.debug("linea.getCodTipoComisionista() [" + linea.getCodTipoComisionista() + "]");
		logger.debug("linea.getCodOficina() [" + linea.getCodOficina() + "]");
		logger.debug("linea.getCodDistribuidor() [" + linea.getCodDistribuidor() + "]");
		logger.debug("linea.getCodVendedor() [" + linea.getCodVendedor() + "]");
		linea.setCodCliente(f.getCodCliente());
		linea.setCodTipoCliente(f.getCodTipoCliente());
		linea.setCodCalificacion(f.getCodCalificacionCliente());
		linea.setMontoPreAutorizado(f.getMontoPreAutorizado());
		linea.setCodCrediticia(f.getCodCrediticia());
		linea.setFacturaTercero(f.getFacturaTercero());
		logger.info("setearDatosVenta, fin");
	}

	private String obtenerDireccionAMostrar(FormularioDireccionDTO direccionForm) {

		String dirAMostrar = "";
		if (!direccionForm.getNOM_CALLE().equals("")) {
			dirAMostrar = dirAMostrar + direccionForm.getNOM_CALLE() + " ";
		}
		if (!direccionForm.getNUM_CALLE().equals("")) {
			dirAMostrar = dirAMostrar + direccionForm.getNUM_CALLE() + " ";
		}
		if (!direccionForm.getCOD_CIUDAD().equals("")) {
			dirAMostrar = dirAMostrar + direccionForm.getDescripcionCOD_CIUDAD() + " ";
		}
		if (!direccionForm.getDES_DIREC1().equals("")) {
			dirAMostrar = dirAMostrar + direccionForm.getDES_DIREC1() + " ";
		}
		if (!direccionForm.getDES_DIREC2().equals("")) {
			dirAMostrar = dirAMostrar + direccionForm.getDES_DIREC2() + " ";
		}
		if (!direccionForm.getCOD_COMUNA().equals("")) {
			dirAMostrar = dirAMostrar + direccionForm.getDescripcionCOD_COMUNA() + " ";
		}
		if (!direccionForm.getZIP().equals("")) {
			dirAMostrar = dirAMostrar + ". Código Postal " + direccionForm.getDescripcionZIP() + " ";
		}
		if (!direccionForm.getCOD_REGION().equals("")) {
			dirAMostrar = dirAMostrar + ". Departamento " + direccionForm.getDescripcionCOD_REGION() + " ";
		}
		if (!direccionForm.getCOD_PROVINCIA().equals("")) {
			dirAMostrar = dirAMostrar + ". Municipio " + direccionForm.getDescripcionCOD_PROVINCIA() + " ";
		}

		return dirAMostrar;
	}

	private void inicializarLinea(DatosLineaForm datosLineaForm, HttpServletRequest request) throws Exception {
		logger.info("inicializarLinea [inicio]");
		HttpSession sesion = request.getSession(false);
		datosLineaForm.setCodTipoPrestacion("");
		datosLineaForm.setCodNivel1("");
		datosLineaForm.setCodNivel2("");
		datosLineaForm.setCodNivel3("");
		datosLineaForm.setCodRenovacion("");
		//Home de linea
		datosLineaForm.setCodRegion("");
		datosLineaForm.setCodProvincia("");
		datosLineaForm.setCodCiudad("");
		datosLineaForm.setCodCelda("");
		datosLineaForm.setCodCentral("");
		//Datos Comerciales
		datosLineaForm.setCodPlanTarif("");
		datosLineaForm.setCodUsoLinea("");
		datosLineaForm.setCodTipoTerminal("");
		datosLineaForm.setCodCreditoConsumo("");
		datosLineaForm.setCodLimiteConsumo("");
		datosLineaForm.setMontoLimiteConsumo(0);
		datosLineaForm.setCodPlanServicio("");
		datosLineaForm.setCodGrupoCobroServ("");
		datosLineaForm.setCodCausaDescuento("");
		datosLineaForm.setCodCampanaVigente("");
		datosLineaForm.setValorRefPorMinuto("0.0");
		datosLineaForm.setCodMoneda("");
		datosLineaForm.setCodTecnologia("");
		//Datos Simcard
		datosLineaForm.setNumSerie("");

		//Datos Equipo
		datosLineaForm.setNumEquipo("");
		datosLineaForm.setCodProcedencia("");
		datosLineaForm.setCodProcedenciaEquipo("");

		//Datos del seguro
		datosLineaForm.setCodTipoSeguro("");
		datosLineaForm.setVigenciaSeguro("");

		//Numeracion			
		datosLineaForm.setNumCelular("");
		datosLineaForm.setProcedenciaNumero("");
		datosLineaForm.setNumCelularInternet("");
		sesion.removeAttribute("BuscaNumeroForm");

		//Servicios
		sesion.removeAttribute("serviciosAContratar");

		//Contactos
		sesion.removeAttribute("listaContactos");

		//Datos de usuario
		datosLineaForm.setNomUsuario("");
		datosLineaForm.setTipoIdentificacionUsuario("");
		datosLineaForm.setNumeroIdentificacionUsuario("");
		datosLineaForm.setApellido1("");
		datosLineaForm.setApellido2("");
		datosLineaForm.setObservacion("");

		/* Direcciones */
		datosLineaForm.setDireccionPersonal("");
		datosLineaForm.setDireccionInstalacion("");
		datosLineaForm.setDireccionPersonaForm(null);
		datosLineaForm.setDireccionInstalacionForm(null);

		/* Valores por defecto*/
		cargarValoresDefecto(request, datosLineaForm);

		/* Valores seleccionados*/
		datosLineaForm.setCodTipoPrestacionSeleccionada("");
		datosLineaForm.setCodNivel1Seleccionado("");
		datosLineaForm.setCodNivel2Seleccionado("");
		datosLineaForm.setCodNivel3Seleccionado("");
		datosLineaForm.setCodCeldaSeleccionada("");
		datosLineaForm.setCodCentralSeleccionada("");
		datosLineaForm.setCodUsoLineaSeleccionado("");
		datosLineaForm.setCodPlanTarifSeleccionado("");
		//datosLineaForm.setCodPlanServicioSeleccionado("");//P-CSR-11002 JLGN 08-08-2011
		datosLineaForm.setCodPlanServicioSeleccionado("01");//P-CSR-11002 JLGN 08-08-2011
		datosLineaForm.setCodLimiteConsumoSeleccionado("");
		//datosLineaForm.setCodTipoTerminalSeleccionado("");//P-CSR-11002 JLGN 08-08-2011
		datosLineaForm.setCodTipoTerminalSeleccionado("T");//P-CSR-11002 JLGN 08-08-2011
		datosLineaForm.setCodCausaDescuentoSeleccionada("");
		datosLineaForm.setCodCampanaVigenteSeleccionada("");
		datosLineaForm.setFlgActivarBtnFinalizar("1");
		datosLineaForm.setFlgSerieKit("0");
		datosLineaForm.setFlgSerieNumerada("0");
		datosLineaForm.setFlgConsultaFinalizar("1");
		datosLineaForm.setCantidadLineas(datosLineaForm.getCantidadLineas() + 1);
		logger.info("inicializarLinea [fin]");
	}//fin inicializarLinea

	private void cargarValoresDefecto(HttpServletRequest request, DatosLineaForm datosLineaForm)
			throws VentasException, RemoteException, AltaClienteException, CustomerDomainException {
		HttpSession sesion = request.getSession(false);
		DatosVentaForm datosVentaForm = (DatosVentaForm) sesion.getAttribute("DatosVentaForm");

		if (datosVentaForm != null) {
			String codOficina = datosVentaForm.getCodOficina();

			OficinaDTO oficina = new OficinaDTO();
			oficina = delegate.getDireccionOficina(codOficina);
			datosLineaForm.setCodRegion(oficina.getCodigoRegion());
			datosLineaForm.setCodProvinciaSeleccionada(oficina.getCodigoProvincia());
			datosLineaForm.setCodCiudadSeleccionada(oficina.getCodigoCiudad());

			String codModPago = datosVentaForm.getCodModalidadVenta();
			datosLineaForm.setFlgAplicaSeguro(String.valueOf(delegate.getIndSeguro(new Long(codModPago))));

			datosLineaForm.setCodCreditoConsumo(global.getValor("codigo.credito.consumo.nousado"));
			datosLineaForm.setCodGrupoCobroServ(global.getValor("codigo.grupo.cobroserv.cobroscelular"));
		}

		if (sesion.getAttribute("clienteSel") != null) {
			ClienteAjaxDTO clienteSel = (ClienteAjaxDTO) sesion.getAttribute("clienteSel");
			datosLineaForm.setTipoIdentificacionUsuario(clienteSel.getCodigoTipoIdentificacion());
			datosLineaForm.setNumeroIdentificacionUsuario(clienteSel.getNumeroIdentificacion());
			datosLineaForm.setNomUsuario(clienteSel.getNombreCliente());
			datosLineaForm.setApellido1(clienteSel.getNombreApellido1());
			datosLineaForm.setApellido2(clienteSel.getNombreApellido2());
			datosLineaForm.setTelefono(clienteSel.getNumeroTelefono1());
			datosLineaForm.setDescripcionColor(clienteSel.getDescripcionColor());
			datosLineaForm.setDescripcionSegmento(clienteSel.getDescripcionSegmento());
			//P-CSR-11002 JLGN 14-06-2011
			FormularioDireccionDTO direcPerDTO = null;
			logger.debug("Direccion personal del cliente: "+ clienteSel.getCodigoCliente());
			String codDireccion = delegate.obtenerDirecPerCli(clienteSel.getCodigoCliente());
			
			direcPerDTO = delegate2.getDireccionPrepago(codDireccion);			
			datosLineaForm.setDireccionPersonaForm(direcPerDTO);
			datosLineaForm.setDireccionPersonal(obtenerDireccionAMostrar(datosLineaForm.getDireccionPersonaForm()));
		}
	}

	private void limpiarForm(DatosLineaForm datosLineaForm, HttpServletRequest request) throws Exception {
		HttpSession sesion = request.getSession(false);

		datosLineaForm.setCodGrpPrestacion("");
		datosLineaForm.setCodTipoPrestacion("");
		datosLineaForm.setCodNivel1("");
		datosLineaForm.setCodNivel2("");
		datosLineaForm.setCodNivel3("");
		datosLineaForm.setCodRenovacion("");

		//Home de linea
		datosLineaForm.setCodRegion("");
		datosLineaForm.setCodProvincia("");
		datosLineaForm.setCodCiudad("");
		datosLineaForm.setCodCelda("");
		datosLineaForm.setCodCentral("");
		//Datos Comerciales
		datosLineaForm.setCodPlanTarif("");
		datosLineaForm.setCodUsoLinea("");
		datosLineaForm.setCodTipoTerminal("");
		datosLineaForm.setCodCreditoConsumo("");
		datosLineaForm.setCodLimiteConsumo("");
		datosLineaForm.setMontoLimiteConsumo(0);
		datosLineaForm.setCodPlanServicio("");
		datosLineaForm.setCodGrupoCobroServ("");
		datosLineaForm.setCodCausaDescuento("");
		datosLineaForm.setCodCampanaVigente("");
		datosLineaForm.setValorRefPorMinuto("0.0");
		datosLineaForm.setCodMoneda("");
		datosLineaForm.setCodTecnologia("");
		//Datos Simcard
		datosLineaForm.setNumSerie("");

		//Datos Equipo
		datosLineaForm.setNumEquipo("");
		datosLineaForm.setCodProcedencia("");

		//Datos del seguro
		datosLineaForm.setCodTipoSeguro("");
		datosLineaForm.setVigenciaSeguro("");

		//Numeracion			
		datosLineaForm.setNumCelular("");
		datosLineaForm.setProcedenciaNumero("");
		datosLineaForm.setNumCelularInternet("");

		sesion.removeAttribute("BuscaNumeroForm");

		//Servicios
		sesion.removeAttribute("serviciosAContratar");

		//Contactos
		sesion.removeAttribute("listaContactos");

		//Datos de usuario

		datosLineaForm.setNomUsuario("");
		datosLineaForm.setTipoIdentificacionUsuario("");
		datosLineaForm.setNumeroIdentificacionUsuario("");
		datosLineaForm.setApellido1("");
		datosLineaForm.setApellido2("");
		datosLineaForm.setObservacion("");

		/* Direcciones */
		datosLineaForm.setDireccionPersonal("");
		datosLineaForm.setDireccionInstalacion("");
		datosLineaForm.setDireccionPersonaForm(null);
		datosLineaForm.setDireccionInstalacionForm(null);

		datosLineaForm.setFlgSerieKit("0");
		datosLineaForm.setFlgSerieNumerada("0");

		/* Valores seleccionados*/
		datosLineaForm.setCodTipoPrestacionSeleccionada("");
		datosLineaForm.setCodNivel1Seleccionado("");
		datosLineaForm.setCodNivel2Seleccionado("");
		datosLineaForm.setCodNivel3Seleccionado("");
		datosLineaForm.setCodCeldaSeleccionada("");
		datosLineaForm.setCodCentralSeleccionada("");
		datosLineaForm.setCodUsoLineaSeleccionado("");
		datosLineaForm.setCodPlanTarifSeleccionado("");
		datosLineaForm.setCodPlanServicioSeleccionado("");
		datosLineaForm.setCodLimiteConsumoSeleccionado("");
		datosLineaForm.setCodTipoTerminalSeleccionado("");
		datosLineaForm.setCodCausaDescuentoSeleccionada("");
	}//fin limpiarForm

	private void limpiarSesion(HttpServletRequest request) {
		HttpSession sesion = request.getSession(false);
		sesion.removeAttribute("BuscaClienteForm");
		sesion.removeAttribute("DatosVentaForm");
		sesion.removeAttribute("BuscaSeriesForm");
		sesion.removeAttribute("BuscaNumeroForm");
		sesion.removeAttribute("ServiciosSuplementariosForm");
		sesion.removeAttribute("DireccionForm");
		sesion.removeAttribute("ClienteFacturaForm");
		sesion.removeAttribute("listaClientes");
		sesion.removeAttribute("listaSeries");
		sesion.removeAttribute("listaNumeros");
		sesion.removeAttribute("listaNumerosRango");
		sesion.removeAttribute("listaServiciosDef");
		sesion.removeAttribute("listaServiciosAct");
		sesion.removeAttribute("listaServiciosDisp");
		sesion.removeAttribute("clienteSel");
		sesion.removeAttribute("numeroSel");
		sesion.removeAttribute("serieSel");
		sesion.removeAttribute("NumerosCortosSMSForm");
	}

	private GaContactoAbonadoToDTO[] string2ArrayContactos(String strArray) {

		String separadorObjecto = new String("###");
		String[] coleccion = strArray.split(separadorObjecto);
		String campo = new String();
		GaContactoAbonadoToDTO[] contactos911 = new GaContactoAbonadoToDTO[coleccion.length];
		for (int fila = 0; fila < coleccion.length; fila++) {
			GaContactoAbonadoToDTO contacto = new GaContactoAbonadoToDTO();
			logger.trace(coleccion[fila]);
			String[] campos = coleccion[fila].split("[|]");
			campo = campos[0];
			if (!(campo.trim().equals("")))
				contacto.setApellido1Contacto(campo);
			campo = campos[1];
			if (!(campo == null) && !(campo.trim().equals("")))
				contacto.setNombreContacto(campo);
			campo = campos[3];
			if (!(campo.trim().equals("")))
				contacto.setTelefono(Long.parseLong(campo));
			campo = campos[4];
			if (!(campo.trim().equals("")))
				contacto.setPlacaVehicular(campo);
			campo = campos[5];
			if (!(campo.trim().equals("")))
				contacto.setColorVehiculo(campo);
			campo = campos[6];
			if (!(campo.trim().equals("")))
				contacto.setAnioVehiculo(Long.parseLong(campo));
			campo = campos[8];
			if (!(campo.trim().equals("")))
				contacto.setCodServicio(campo);
			campo = campos[9];
			if (!(campo.trim().equals("")))
				contacto.setNumContacto(Long.parseLong(campo));
			campo = campos[10];
			if (!(campo.trim().equals("")))
				contacto.setApellido2Contacto(campo);
			campo = campos[11];
			if (!(campo.trim().equals("")))
				contacto.setCodParentesco(campo);
			contactos911[fila] = contacto;
			contacto = null;
		} // for
		return contactos911;
	} // string2Array
	
	//Inicio P-CSR-11002 JLGN 21-04-2011
	public ActionForward volverPAScoring(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("volverPAScoring, inicio");
		logger.info("volverPAScoring, fin");
		return mapping.findForward("inicio");
	}
	
	public ActionForward aceptarPAScoring(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("aceptarPAScoring, inicio");
		logger.info("aceptarPAScoring, fin");		
		return mapping.findForward("inicio");
	}
	
/*	public ActionForward cancelarPAScoring(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("cancelarPAScoring, inicio");
		DatosLineaForm f = (DatosLineaForm) form;
		f.getLinea().setArrayPA(null);
		logger.info("cancelarPAScoring, fin");
		return mapping.findForward("inicio");
	}*/
	
	//Fin P-CSR-11002 JLGN 21-04-2011
	
	//Inicio P-CSR-11002 JLGN 16-05-2011
	public ActionForward validarPass(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		logger.info("validarPass, inicio");		
		DatosLineaForm datosLineaForm = (DatosLineaForm) form;
		
		String passCalificacion = datosLineaForm.getPassCalificacion();
		logger.debug("passCalificacion: "+ passCalificacion);
		if (delegate.validaPassClasificacion(passCalificacion)){
			datosLineaForm.setFlagCalificacion("true");	
			request.getSession().setAttribute("flagMuestraCalificacion", "true");
			//Inicio P-CSR-11002 JLGN 05-07-2011
			request.getSession().setAttribute("flagCalcLC", "true");
		}else{
			datosLineaForm.setFlagCalificacion("false");
			request.setAttribute("mensajeError", "Password Ingresada Incorrecta");
			request.getSession().setAttribute("flagMuestraCalificacion", "false");
		}
		//P-CSR-11002 JLGN 17-08-2011
		datosLineaForm.setPassCalificacion("");
		logger.debug("FlagCalificacion: "+datosLineaForm.getFlagCalificacion());
		request.getSession().setAttribute("noExisteClienteBuro", "false");
		logger.info("validarPass, fin");		
		return mapping.findForward("inicio");
	}
	
	//Fin P-CSR-11002 JLGN 16-05-2011
	
	//Inicio P-CSR-11002 JLGN 10-10-2011
	public ActionForward formalizaSolicitud(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		logger.info("formalizaSolicitud, inicio");	
		ResultadoSolicitudVentaDTO resultadoSolVenta = (ResultadoSolicitudVentaDTO) request.getSession().getAttribute("resultadoSolVenta");		
		RetornoListaAjaxDTO lista = null;
		
		logger.info("Obtiene Venta");	
		lista = obtenerVentasxVendedor(request,resultadoSolVenta.getNumeroVenta(),
				global.getValor("estado.venta.pendiente.formalizacion"), global.getValor("ind.consulta.formalizacion"));
		
		logger.info("formalizaSolicitud, Fin");	
		return mapping.findForward("formalizarSolicitud");
	}	
	
	public RetornoListaAjaxDTO obtenerVentasxVendedor(HttpServletRequest request, String numVenta , String codEstadoVenta, String indOrigen) {
		logger.info("obtenerVentasxVendedor, inicio()");
		logger.debug("numVenta [" + numVenta + "]");
		RetornoListaAjaxDTO retorno = new RetornoListaAjaxDTO();
		VentaAjaxDTO[] listaRetorno = null;
		ListadoVentasDTO[] listaVentas = null;
		HttpSession sesion = request.getSession(false);
		long encontrados = 0;
		final String mensajeError = "Ocurrio un error al obtener ventas";
		try {
			if (numVenta.trim().equals(""))
				numVenta = "0";
			if (codEstadoVenta.equals(""))
				codEstadoVenta = "0";
			ListadoVentasDTO listadoVentasDTO = new ListadoVentasDTO();
			listadoVentasDTO.setNroVenta(new Long(numVenta));
			listadoVentasDTO.setCodigoVendedor(new Long(0));
			listadoVentasDTO.setCodCliente(new Long(0));
			listadoVentasDTO.setCodOficina("0");
			listadoVentasDTO.setFechaDesde("");
			listadoVentasDTO.setFechaHasta("");
			listadoVentasDTO.setCodEstadoVenta(codEstadoVenta);
			listadoVentasDTO.setOrigen(indOrigen);
			listaVentas = delegate.getVentasXVendedor(listadoVentasDTO);
			if (listaVentas != null) {
				listaRetorno = new VentaAjaxDTO[listaVentas.length];
				for (int i = 0; i < listaVentas.length; i++) {
					VentaAjaxDTO venta = new VentaAjaxDTO();
					venta.setNroVenta(listaVentas[i].getNroVenta().toString());
					venta.setFechaVenta(listaVentas[i].getFechaVenta());
					venta.setNombreCliente(listaVentas[i].getNombreCliente());
					venta.setNombreVendedor(listaVentas[i].getNombreVendedor());
					venta.setNombreDealer(listaVentas[i].getNombreDealer());
					venta.setTipoVenta(listaVentas[i].getTipoVenta());
					venta.setEstado(listaVentas[i].getCodEstadoVenta());
					venta.setCodOficina(listaVentas[i].getCodOficina());
					venta.setCodVendedor(listaVentas[i].getCodigoVendedor().toString());
					venta.setCodCliente(listaVentas[i].getCodCliente().toString());
					venta.setCodModVenta(listaVentas[i].getCodModVenta());
					venta.setIndTipoVenta(listaVentas[i].getIndTipoVenta());
					venta.setNumTransaccionVenta(listaVentas[i].getNumTransaccionVenta());
					venta.setCodTipoContrato(listaVentas[i].getCodTipoContrato());
					venta.setCodTipoDocumento(listaVentas[i].getCodTipoDocumento());
					venta.setCodCuota(listaVentas[i].getCodCuota());
					venta.setIndOfiter(listaVentas[i].getIndOfiter());
					venta.setCodTipoCliente(listaVentas[i].getCodTipoCliente());
					venta.setCodTipoSolicitud(listaVentas[i].getCodTipoSolicitud());
					venta.setIndEstVenta(listaVentas[i].getIndEstVenta());
					listaRetorno[i] = venta;
				}
				encontrados = listaRetorno.length;
			}
			sesion.setAttribute("listaPreVenta", listaRetorno);
		}
		catch (VentasException e) {
			String mensaje = e.getDescripcionEvento() == null ? mensajeError : e.getDescripcionEvento();
			retorno.setMsgError(mensaje);
			retorno.setCodError(e.getCodigo());
			logger.error("retorno.getMsgError() [" + retorno.getMsgError() + "]");
			logger.error("retorno.getCodError() [" + retorno.getCodError() + "]");
			logger.error(StackTraceUtl.getStackTrace(e));
		}
		catch (Exception e) {
			String mensaje = e.getMessage() == null ? mensajeError : e.getMessage();
			retorno.setCodError("1");
			retorno.setMsgError(mensaje);
			logger.error("retorno.getMsgError() [" + retorno.getMsgError() + "]");
			logger.error("retorno.getCodError() [" + retorno.getCodError() + "]");
			logger.error(StackTraceUtl.getStackTrace(e));
		}
		logger.debug("encontrados [" + encontrados + "]");
		retorno.setLista(listaRetorno);
		logger.info("obtenerVentasxVendedor, fin");
		return retorno;
	}
	//Fin P-CSR-11002 JLGN 10-10-2011
	
	//Inicio P-CSR-11002 JLGN 18-10-2011
	public String generaImeiDummy() throws RemoteException, GeneralException{
		logger.debug("Inicio: generaImeiDummy()");
		String resultado = null;
		String resultadoFinal = "";
		String numSecuencia = String.valueOf(delegate.getSecuencia(global.getValor("secuencia.numDummy")));
		
		resultado = "A"+numSecuencia;
		logger.debug("1 numero de Serie: "+ resultado);
		logger.debug("Largo "+ resultado.length());
		
		if(resultado.length() < 15){//Se utiliza el 15 ya que este es el largo maximo de una serie Terminal
			for(int x = 0 ; x < (15-resultado.length()) ;x++){
				resultadoFinal = resultadoFinal + "0";
			}
			resultado = "";
			resultado = "A"+ resultadoFinal + numSecuencia;
		}		
		logger.debug("Numero de Serie Dummy: " + resultado);
		logger.debug("Fin: generaImeiDummy()");
		return resultado; 
	}
	//Fin P-CSR-11002 JLGN 18-10-2011

}
