package com.tmmas.cl.scl.portalventas.web.helper;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import uk.ltd.getahead.dwr.WebContext;
import uk.ltd.getahead.dwr.WebContextFactory;

import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.scl.altacliente.presentacion.delegate.AltaClienteDelegate;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.DatosClienteBuroDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.NumeroIdentificacionDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.PlanTarifarioComDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.CiudadDireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.DatosDireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.FormularioDireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ParametrosGlobalesDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ProvinciaDireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.ArticuloInDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.LstPTaPlanTarifarioInDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.LstPTaPlanTarifarioListOutDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.LstPTaPlanTarifarioOutDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CampanaVigenteDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CausalDescuentoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CiudadDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.PlanServicioDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.VentasException;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.RegistroVentaDTO;
import com.tmmas.cl.scl.portalventas.web.delegate.PortalVentasDelegate;
import com.tmmas.cl.scl.portalventas.web.dto.NumeroAjaxDTO;
import com.tmmas.cl.scl.portalventas.web.dto.RetornoBusquedaNumeracionAjaxDTO;
import com.tmmas.cl.scl.portalventas.web.dto.RetornoListaAjaxDTO;
import com.tmmas.cl.scl.portalventas.web.dto.RetornoValidacionAjaxDTO;
import com.tmmas.cl.scl.portalventas.web.dto.RetornoValorAjaxDTO;
import com.tmmas.cl.scl.portalventas.web.form.BuscaNumeroForm;
import com.tmmas.cl.scl.portalventas.web.form.DatosLineaForm;
import com.tmmas.cl.scl.portalventas.web.form.DatosVentaForm;
import com.tmmas.cl.scl.portalventas.web.form.PlanesAdicionalesScoringForm;
import com.tmmas.cl.scl.portalventas.web.form.TiposComportamientoForm;
import com.tmmas.cl.scl.productdomain.businessobject.dto.ArticuloDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.DatosNumeracionDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.NivelPrestacionDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.NumeracionCelularDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.NumeroInternetDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.SeguroDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.SimcardDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.TerminalDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.TipoPrestacionDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.TipoTerminalDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.UsoDTO;
import com.tmmas.cl.scl.resourcedomain.businessobject.dto.CeldaDTO;
import com.tmmas.cl.scl.resourcedomain.businessobject.dto.CentralDTO;

public class DatosLineaAJAX {
	private final Logger logger = Logger.getLogger(DatosLineaAJAX.class);

	private Global global = Global.getInstance();

	PortalVentasDelegate delegate = PortalVentasDelegate.getInstance();
	//Inicio Inc.179734 06-01-2012 JGLN 
	AltaClienteDelegate delegate2 = AltaClienteDelegate.getInstance();
	//Fin Inc.179734 06-01-2012 JGLN

	public RetornoValidacionAjaxDTO validarIdentificador(String tipoIdentif, String numIdentif) {
		logger.debug("validarIdentificador:inicio()");
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);
		RetornoValidacionAjaxDTO retorno = new RetornoValidacionAjaxDTO();

		if (!validarSesion(sesion)) {
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;
		}

		NumeroIdentificacionDTO param = new NumeroIdentificacionDTO();
		retorno.setValido(true);
		try {
			param.setCodigoModulo(global.getValor("codigo.modulo.GE"));
			param.setCorrelativo(Long.valueOf(global.getValor("param.identificador.correlativo")));
			param.setTipoIdentif(tipoIdentif);
			param.setNumIdentif(numIdentif);
			param = delegate.validarIdentificador(param);
			retorno.setIdentificadorFormateado(param.getFormatoNIT());
		}
		catch (Exception e) {
			retorno.setValido(false);
		}
		logger.debug("validarIdentificador:fin()");
		return retorno;
	}

	/*
	 * Carga la lista de tipos de prestacion dependiendo del grupo de prestacion seleccionado Lista :
	 * "codPrestacion,desPrestacion,tipoRed,indNumero,indDirInstalacion,indInventario,indSSInternet,indNumeroPiloto"
	 */
	public RetornoListaAjaxDTO obtenerTiposPrestacion(String codGrupoPrestacion) {
		logger.info("obtenerTiposPrestacion, inicio");
		logger.debug("codGrupoPrestacion [" + codGrupoPrestacion + "]");
		RetornoListaAjaxDTO retorno = new RetornoListaAjaxDTO();
		TipoPrestacionDTO[] listaTiposPrestacion = null;
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);

		if (!validarSesion(sesion)) {
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;
		}

		try {
			if (sesion.getAttribute("DatosVentaForm") != null) {
				// obtener tipo de cliente
				DatosVentaForm datosVentaForm = (DatosVentaForm) sesion.getAttribute("DatosVentaForm");
				String codTipoCliente = datosVentaForm.getCodTipoCliente();
				listaTiposPrestacion = delegate.getTiposPrestacion(codGrupoPrestacion, codTipoCliente);
			}
		}
		catch (Exception e) {
			logger.debug("Ocurrio un error al obtener tipos de prestacion ", e);
			String mensaje = e.getMessage() == null ? " " : ", " + e.getMessage();
			retorno.setCodError("1");
			retorno.setMsgError("Ocurrio un error al obtener tipos de prestacion " + mensaje);
		}
		retorno.setLista(listaTiposPrestacion);
		logger.debug("encontrados [" + listaTiposPrestacion.length + "]");
		logger.info("obtenerTiposPrestacion, fin");
		return retorno;
	}

	/*
	 * Carga listas de niveles Lista : "codNivel,descripcionNivel"
	 */
	public RetornoListaAjaxDTO obtenerNivelesPrestacion(String codPrestacion, int codNivel) throws Exception {
		logger.debug("obtenerNivelesPrestacion:inicio()");
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);
		RetornoListaAjaxDTO retorno = new RetornoListaAjaxDTO();

		if (!validarSesion(sesion)) {
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;
		}

		NivelPrestacionDTO[] listaNiveles = null;
		NivelPrestacionDTO paramLista = new NivelPrestacionDTO();
		try {
			paramLista.setCodPrestacion(codPrestacion);
			paramLista.setCodNivel(codNivel);
			listaNiveles = delegate.obtieneNivelesPrestacion(paramLista);
		}
		catch (Exception e) {
			logger.debug("Ocurrio un error al obtener niveles de prestacion ", e);
			String mensaje = e.getMessage() == null ? " " : ", " + e.getMessage();
			retorno.setCodError("1");
			retorno.setMsgError("Ocurrio un error al obtener niveles de prestacion " + mensaje);

		}
		retorno.setLista(listaNiveles);
		logger.debug("obtenerNivelesPrestacion:fin()");
		return retorno;
	}

	public RetornoListaAjaxDTO obtenerProvincias(String codigoRegion) throws Exception {
		logger.debug("obtenerProvincias:inicio()");
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);
		RetornoListaAjaxDTO retorno = new RetornoListaAjaxDTO();

		if (!validarSesion(sesion)) {
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;
		}

		DatosDireccionDTO[] provincias = null;

		try {
			ProvinciaDireccionDTO provinciaDireccionDTO = new ProvinciaDireccionDTO();
			provinciaDireccionDTO.setCodigoRegion(codigoRegion);
			provinciaDireccionDTO = delegate.getProvincias(provinciaDireccionDTO);
			provincias = provinciaDireccionDTO.getDatosDireccionDTO();
		}
		catch (Exception e) {
			logger.debug("Ocurrio un error al obtener provincias ", e);
			String mensaje = e.getMessage() == null ? " " : ", " + e.getMessage();
			retorno.setCodError("1");
			retorno.setMsgError("Ocurrio un error al obtener provincias " + mensaje);
		}
		retorno.setLista(provincias);
		logger.debug("obtenerProvincias:fin()");
		return retorno;
	}

	public RetornoListaAjaxDTO obtenerCiudades(String codigoRegion, String codigoProvincia) throws Exception {
		logger.debug("obtenerCiudades:inicio()");
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);
		RetornoListaAjaxDTO retorno = new RetornoListaAjaxDTO();

		if (!validarSesion(sesion)) {
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;
		}

		DatosDireccionDTO[] ciudades = null;

		try {
			CiudadDireccionDTO ciudadDireccionDTO = new CiudadDireccionDTO();
			ciudadDireccionDTO.setCodigoRegion(codigoRegion);
			ciudadDireccionDTO.setCodigoProvincia(codigoProvincia);
			ciudadDireccionDTO = delegate.getCiudades(ciudadDireccionDTO);
			ciudades = ciudadDireccionDTO.getDatosDireccionDTO();
		}
		catch (Exception e) {
			logger.debug("Ocurrio un error al obtener ciudades ", e);
			String mensaje = e.getMessage() == null ? " " : ", " + e.getMessage();
			retorno.setCodError("1");
			retorno.setMsgError("Ocurrio un error al obtener ciudades " + mensaje);

		}
		retorno.setLista(ciudades);
		logger.debug("obtenerCiudades:fin()");
		return retorno;
	}

	/*
	 * Carga la lista de tipos de celdas dependiendo de region, provincia y ciudad seleccionadas Lista :
	 * "codigoCelda,descripcionCelda"
	 */
	public RetornoListaAjaxDTO obtenerCeldas(String codigoRegion, String codigoProvincia, String codigoCiudad)
			throws Exception {
		logger.debug("obtenerCeldas:inicio()");
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);
		RetornoListaAjaxDTO retorno = new RetornoListaAjaxDTO();

		if (!validarSesion(sesion)) {
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;
		}

		CeldaDTO[] celdas = null;
		try {
			CiudadDTO ciudadDTO = new CiudadDTO();
			ciudadDTO.setCodigoRegion(codigoRegion);
			ciudadDTO.setCodigoProvincia(codigoProvincia);
			ciudadDTO.setCodigoCiudad(codigoCiudad);
			celdas = delegate.getListadoCeldas(ciudadDTO);

		}
		catch (Exception e) {
			logger.debug("Ocurrio un error al obtener celdas ", e);
			String mensaje = e.getMessage() == null ? " " : ", " + e.getMessage();
			retorno.setCodError("1");
			retorno.setMsgError("Ocurrio un error al obtener celdas " + mensaje);

		}
		retorno.setLista(celdas);
		logger.debug("obtenerCeldas:fin()");
		return retorno;
	}

	/*
	 * Carga la lista de centrales dependiendo de la celda seleccionada Lista :
	 * "codigoCentral,descripcionCentral,codigoTecnologia"
	 */
	public RetornoListaAjaxDTO obtenerCentrales(String codSubAlm, String codPrestacion) throws Exception {
		logger.debug("obtenerCentrales:inicio()");
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);
		RetornoListaAjaxDTO retorno = new RetornoListaAjaxDTO();

		if (!validarSesion(sesion)) {
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;
		}

		CentralDTO[] centrales = null;
		try {
			CeldaDTO celdaDTO = new CeldaDTO();
			celdaDTO.setCodSubAlm(codSubAlm);
			celdaDTO.setCodigoProducto(global.getValor("codigo.producto"));
			celdaDTO.setCodigoPrestacion(codPrestacion);
			centrales = delegate.getListadoCentrales(celdaDTO);
			// concatena descripcion
			if (centrales != null) {
				for (int i = 0; i < centrales.length; i++) {
					centrales[i].setDescripcionCentral(centrales[i].getDescripcionCentral() + " "
							+ centrales[i].getCodigoTecnologia());
				}
			}

		}
		catch (Exception e) {
			logger.debug("Ocurrio un error al obtener centrales ", e);
			String mensaje = e.getMessage() == null ? " " : ", " + e.getMessage();
			retorno.setCodError("1");
			retorno.setMsgError("Ocurrio un error al obtener centrales " + mensaje);

		}
		retorno.setLista(centrales);
		logger.debug("obtenerCentrales:fin()");
		return retorno;
	}

	/*
	 * Carga la lista de usos dependiendo de tipoRed(Tipo Prestacion) y tipoCliente Lista : "codUso,desUso"
	 */
	public RetornoListaAjaxDTO obtenerUsos(String codTipoRed) throws Exception {
		logger.debug("obtenerUsos:inicio()");
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);
		RetornoListaAjaxDTO retorno = new RetornoListaAjaxDTO();

		if (!validarSesion(sesion)) {
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;
		}

		UsoDTO[] usos = null;
		try {

			if (sesion.getAttribute("DatosVentaForm") != null) {
				// obtener tipo de cliente
				DatosVentaForm datosVentaForm = (DatosVentaForm) sesion.getAttribute("DatosVentaForm");
				String codTipoCliente = datosVentaForm.getCodTipoCliente();

				UsoDTO usoDTO = new UsoDTO();
				usoDTO.setTipoRed(codTipoRed);
				usoDTO.setTipoCliente(codTipoCliente);
				usos = delegate.getUsos(usoDTO);
			}

		}
		catch (Exception e) {
			logger.debug("Ocurrio un error al obtener usos ", e);
			String mensaje = e.getMessage() == null ? " " : ", " + e.getMessage();
			retorno.setCodError("1");
			retorno.setMsgError("Ocurrio un error al obtener usos " + mensaje);

		}
		retorno.setLista(usos);
		logger.debug("obtenerUsos:fin()");
		return retorno;
	}

	/*
	 * Carga la lista de planes tarifarios dependiendo del uso seleccionado Lista :
	 * "codigoPlanTarifario,descripcionPlanTarifario"
	 */
	//P-CSR-11002 JLGN 17-05-2011
	/*public RetornoListaAjaxDTO obtenerPlanesTarifarios(String codUso, String codTipoPrestacion, String filtro,
			String indRenovacion) throws Exception {*/
	public RetornoListaAjaxDTO obtenerPlanesTarifarios(String codUso, String codTipoPrestacion, String filtro,
			String indRenovacion, String codCalificacion, String limiteCredito) throws Exception {
		
		logger.debug("obtenerPlanesTarifarios:inicio()");
		logger.debug("codCalificacion: "+codCalificacion);
		logger.debug("limiteCredito: "+limiteCredito);
		
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);
		RetornoListaAjaxDTO retorno = new RetornoListaAjaxDTO();

		if (!validarSesion(sesion)) {
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;
		}

		LstPTaPlanTarifarioListOutDTO planes = null;
		LstPTaPlanTarifarioOutDTO[] listaPlanes = null;
		try {
			LstPTaPlanTarifarioInDTO planDTO = new LstPTaPlanTarifarioInDTO();			
			//Inicio P-CSR-11002 JLGN 13-05-2011
			logger.debug("codCalificacion: "+codCalificacion);
			if(codCalificacion == null){			
				logger.debug("es null");
				DatosClienteBuroDTO buroDTO = (DatosClienteBuroDTO) sesion.getAttribute("datosClienteBuro2");
				planDTO.setCodClasificacion(buroDTO.getResulCalificacion());
			}else{
				if(codCalificacion.equals("")){
					logger.debug("es vacio");
					DatosClienteBuroDTO buroDTO = (DatosClienteBuroDTO) sesion.getAttribute("datosClienteBuro2");
					planDTO.setCodClasificacion(buroDTO.getResulCalificacion());					
				}else{
					logger.debug("no es vacio");
					//Inicio P-CSR-11002 JLGN 16-08-2011
					DatosClienteBuroDTO buroDTO = (DatosClienteBuroDTO) sesion.getAttribute("datosClienteBuro2");
					logger.debug("buroDTO.getNumeroCedula(): "+buroDTO.getNumeroCedula());
					buroDTO.setLimiteDeCredito(limiteCredito);
					sesion.removeAttribute("datosClienteBuro2");
					sesion.setAttribute("datosClienteBuro2", buroDTO);
					sesion.removeAttribute("flagObtPT");
					sesion.setAttribute("flagObtPT", "true");
					//Fin P-CSR-11002 JLGN 16-08-2011
					planDTO.setCodClasificacion(codCalificacion);	
					sesion.setAttribute("flagConsultaCalificacion", "true");
				}
			}	
			logger.debug("codCalificacionFinal: "+planDTO.getCodClasificacion());
			//Fin P-CSR-11002 JLGN 13-05-2011
			planDTO.setTipoProducto(codUso);
			planDTO.setTipoPlan(global.getValor("tipo.plan.individual"));
			planDTO.setCodTipPrestacion(codTipoPrestacion);
			planDTO.setClaPlanTarif(filtro);
			planDTO.setIndRenovacion(Integer.parseInt(indRenovacion));
			planes = delegate.lstPlanTarif(planDTO);
			listaPlanes = planes.getallLstPTaPlanTarifarioOutDTO();
		}
		catch (Exception e) {
			logger.debug("Ocurrio un error al obtener planes tarifarios ", e);
			String mensaje = e.getMessage() == null ? " " : ", " + e.getMessage();
			retorno.setCodError("1");
			retorno.setMsgError("Ocurrio un error al obtener planes tarifarios " + mensaje);

		}
		retorno.setLista(listaPlanes);
		logger.debug("obtenerPlanesTarifarios:fin()");
		return retorno;
	}

	/*
	 * Carga la lista de planes servicios dependiendo del plan tarifario y de la tecnologia(Central) seleccionados Lista :
	 * "codigoPlanServicio,descripcionPlanServicio"
	 */
	public RetornoListaAjaxDTO obtenerPlanesServicio(String codPlanTarif, String codTecnologia) throws Exception {
		logger.debug("obtenerPlanesServicio:inicio()");
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);
		RetornoListaAjaxDTO retorno = new RetornoListaAjaxDTO();

		if (!validarSesion(sesion)) {
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;
		}

		PlanServicioDTO[] listaPlanes = null;
		try {
			PlanServicioDTO planServicio = new PlanServicioDTO();
			planServicio.setCodPlanTarif(codPlanTarif);
			planServicio.setCodTecnologia(codTecnologia);
			logger.debug("codPlanTarif=" + planServicio.getCodPlanTarif());
			logger.debug("codTecnologia=" + planServicio.getCodTecnologia());
			listaPlanes = delegate.getListadoPlanServicio(planServicio);
		}
		catch (Exception e) {
			logger.debug("Ocurrio un error al obtener planes servicio ", e);
			String mensaje = e.getMessage() == null ? " " : ", " + e.getMessage();
			retorno.setCodError("1");
			retorno.setMsgError("Ocurrio un error al obtener planes servicio " + mensaje);

		}
		retorno.setLista(listaPlanes);
		logger.debug("obtenerPlanesServicio:fin()");
		return retorno;
	}

	/*
	 * Carga la limite de consumo dependiendo del plan tarifario selecionado Lista :
	 * "codigoLimiteConsumo,descripcionLimiteConsumo"
	 */
	public RetornoListaAjaxDTO obtenerLimitesConsumo(String codPlanTarif) throws Exception {
		logger.debug("obtenerLimitesConsumo:inicio()");
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);
		RetornoListaAjaxDTO retorno = new RetornoListaAjaxDTO();

		if (!validarSesion(sesion)) {
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;
		}
		String codCliente = "";
		if (sesion.getAttribute("DatosVentaForm") != null) {
			DatosVentaForm datosVentaForm = (DatosVentaForm) sesion.getAttribute("DatosVentaForm");
			codCliente = datosVentaForm.getCodCliente();
		}

		PlanTarifarioComDTO[] listaLimites = null;
		try {
			PlanTarifarioComDTO planTarifarioComDTO = new PlanTarifarioComDTO();
			planTarifarioComDTO.setCodigoPlanTarifario(codPlanTarif);
			planTarifarioComDTO.setCodigoCliente(codCliente);
			listaLimites = delegate.getLimitesConsumo(planTarifarioComDTO);

		}
		catch (Exception e) {
			logger.debug("Ocurrio un error al obtener limites consumo ", e);
			String mensaje = e.getMessage() == null ? " " : ", " + e.getMessage();
			retorno.setCodError("1");
			retorno.setMsgError("Ocurrio un error al obtener limites consumo " + mensaje);

		}
		retorno.setLista(listaLimites);
		logger.debug("obtenerLimitesConsumo:fin()");
		return retorno;
	}

	/*
	 * Carga tipos de terminal dependiendo de la tecnologia(Central) seleccionada Lista : "tipTerminal,desTerminal"
	 */
	public RetornoListaAjaxDTO obtenerTiposTerminal(String codTecnologia) throws Exception {
		logger.debug("listarTiposTerminal:inicio()");
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);
		RetornoListaAjaxDTO retorno = new RetornoListaAjaxDTO();

		if (!validarSesion(sesion)) {
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;
		}

		TipoTerminalDTO[] listaTiposTerminal = null;
		try {

			listaTiposTerminal = delegate.listarTiposTerminal(codTecnologia);
		}
		catch (Exception e) {
			logger.debug("Ocurrio un error al obtener tipos terminal ", e);
			String mensaje = e.getMessage() == null ? " " : ", " + e.getMessage();
			retorno.setCodError("1");
			retorno.setMsgError("Ocurrio un error al obtener tipos terminal " + mensaje);

		}
		retorno.setLista(listaTiposTerminal);
		logger.debug("listarTiposTerminal:fin()");
		return retorno;
	}

	/*
	 * Carga causas de descuento Lista : "codigoCausalDescuento,descripcionCausalDescuento"
	 */
	public RetornoListaAjaxDTO obtenerCausalDescuento(String codUso) throws Exception {
		logger.debug("obtenerCausalDescuento:inicio()");
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);
		RetornoListaAjaxDTO retorno = new RetornoListaAjaxDTO();

		if (!validarSesion(sesion)) {
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;
		}

		CausalDescuentoDTO[] listaCausas = null;
		try {
			listaCausas = delegate.getListadoCausalDescuento(new Long(codUso));
		}
		catch (Exception e) {
			logger.debug("Ocurrio un error al obtener causal de descuento ", e);
			String mensaje = e.getMessage() == null ? " " : ", " + e.getMessage();
			retorno.setCodError("1");
			retorno.setMsgError("Ocurrio un error al obtener causal de descuento " + mensaje);

		}
		retorno.setLista(listaCausas);
		logger.debug("obtenerCausalDescuento:fin()");
		return retorno;
	}

	/*
	 * Copia la direccion indicada en origen a la direccion indicada en destino
	 */
	public void copiarDireccion(String origen, String destino) {
		logger.debug("copiarDireccion:inicio()");

		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);

		if (!validarSesion(sesion)) {
			// retorno.setCodError("-100");
			// retorno.setMsgError("Su sesión ha expirado");
			return;
		}

		DatosLineaForm datosLineaForm = (DatosLineaForm) sesion.getAttribute("DatosLineaForm");
		if (datosLineaForm != null) {// carga direccion
			FormularioDireccionDTO direccionOrigen = null;
			FormularioDireccionDTO direccionDestino = new FormularioDireccionDTO();

			if (origen.equals("PERS_USU"))
				direccionOrigen = datosLineaForm.getDireccionPersonaForm();
			else if (origen.equals("INST_USU"))
				direccionOrigen = datosLineaForm.getDireccionInstalacionForm();

			direccionDestino.setCOD_REGION(direccionOrigen.getCOD_REGION());
			direccionDestino.setCOD_PROVINCIA(direccionOrigen.getCOD_PROVINCIA());
			direccionDestino.setCOD_CIUDAD(direccionOrigen.getCOD_CIUDAD());
			direccionDestino.setCOD_COMUNA(direccionOrigen.getCOD_COMUNA());
			direccionDestino.setCOD_TIPOCALLE(direccionOrigen.getCOD_TIPOCALLE());
			direccionDestino.setNOM_CALLE(direccionOrigen.getNOM_CALLE());
			direccionDestino.setNUM_CALLE(direccionOrigen.getNUM_CALLE());
			direccionDestino.setOBS_DIRECCION(direccionOrigen.getOBS_DIRECCION());
			direccionDestino.setZIP(direccionOrigen.getZIP());
			direccionDestino.setDES_DIREC1(direccionOrigen.getDES_DIREC1());
			direccionDestino.setDescripcionCOD_REGION(direccionOrigen.getDescripcionCOD_REGION());
			direccionDestino.setDescripcionCOD_PROVINCIA(direccionOrigen.getDescripcionCOD_PROVINCIA());
			direccionDestino.setDescripcionCOD_CIUDAD(direccionOrigen.getDescripcionCOD_CIUDAD());
			direccionDestino.setDescripcionCOD_COMUNA(direccionOrigen.getDescripcionCOD_COMUNA());
			direccionDestino.setDescripcionCOD_TIPOCALLE(direccionOrigen.getDescripcionCOD_TIPOCALLE());
			direccionDestino.setDescripcionZIP(direccionOrigen.getDescripcionZIP());
			direccionDestino.setDES_DIREC2(direccionOrigen.getDES_DIREC2());
			direccionDestino.setDireccionReplicada(true);
			if (destino.equals("PERS_USU"))
				datosLineaForm.setDireccionPersonaForm(direccionDestino);
			else if (destino.equals("INST_USU"))
				datosLineaForm.setDireccionInstalacionForm(direccionDestino);
		}
		logger.debug("copiarDireccion:fin()");
	}

	public RetornoValorAjaxDTO limpiarServiciosSuplementarios() {
		logger.info("limpiarServiciosSuplementarios(), inicio");
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);
		RetornoValorAjaxDTO retorno = new RetornoValorAjaxDTO();
		if (!validarSesion(sesion)) {
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			retorno.setResultado("0");
			return retorno;
		}
		String existeLista = "0";
		ArrayList listaServiciosAct = (ArrayList) sesion.getAttribute("listaServiciosAct");
		if (listaServiciosAct != null && listaServiciosAct.size() > 0) {
			existeLista = "1";
			sesion.removeAttribute("listaServiciosAct");
		}
		retorno.setResultado(existeLista);
		logger.info("limpiarServiciosSuplementarios(), fin");
		return retorno;
	}

	public RetornoValorAjaxDTO obtenerFechaVigenciaSeguro(String codSeguro) {
		logger.debug("obtenerFechaVigenciaSeguro:inicio()");
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);
		RetornoValorAjaxDTO retorno = new RetornoValorAjaxDTO();

		if (!validarSesion(sesion)) {
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;
		}

		String fechaVigencia = "";
		try {

			if (sesion.getAttribute("DatosVentaForm") != null) {
				// obtener periodo
				DatosVentaForm datosVentaForm = (DatosVentaForm) sesion.getAttribute("DatosVentaForm");
				String codPeriodo = datosVentaForm.getCodPeriodo();

				SeguroDTO seguro = new SeguroDTO();
				seguro.setCodSeguro(codSeguro);
				seguro.setPeriodo(Integer.parseInt(codPeriodo));
				seguro = delegate.obtieneDatosSeguro(seguro);
				fechaVigencia = seguro.getFechaFinContrato();
			}
		}
		catch (Exception e) {
			String msgError = "Ocurrio un error al obtener fecha de vigencia del seguro ";
			logger.debug(msgError, e);
			String mensaje = e.getMessage() == null ? " " : ", " + e.getMessage();
			retorno.setCodError("1");
			retorno.setMsgError(msgError + mensaje);

		}
		retorno.setResultado(fechaVigencia);
		logger.debug("obtenerFechaVigenciaSeguro:fin()");
		return retorno;
	}

	/* anula reserva Simcard */
	public RetornoValorAjaxDTO anularReservaSimcard(String numSerie) throws Exception {
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);
		RetornoValorAjaxDTO retorno = new RetornoValorAjaxDTO();

		if (!validarSesion(sesion)) {
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;
		}

		try {
			long numVenta = 0;
			if (sesion.getAttribute("DatosVentaForm") != null) {
				DatosVentaForm datosVentaForm = (DatosVentaForm) sesion.getAttribute("DatosVentaForm");
				numVenta = datosVentaForm.getNumeroVenta();
			}

			SimcardDTO simcardDTO = new SimcardDTO();
			simcardDTO.setNumeroSerie(numSerie);
			simcardDTO = delegate.getSimcard(simcardDTO);

			// actualizar stock
			ArticuloDTO articuloDTO = new ArticuloDTO();
			articuloDTO.setTipoMovimiento(global.getValor("tipo.movto.libventa"));
			articuloDTO.setTipoStock(Integer.parseInt(simcardDTO.getTipoStock()));
			articuloDTO.setCodigoBodega(Integer.parseInt(simcardDTO.getCodigoBodega()));
			articuloDTO.setCodigo(Long.parseLong(simcardDTO.getCodigoArticulo()));
			articuloDTO.setCodigoUso(simcardDTO.getCodigoUso());
			articuloDTO.setCodigoEstado(1);
			articuloDTO.setNumeroVenta(String.valueOf(numVenta));
			articuloDTO.setNumeroSerie(numSerie);
			delegate.actualizaStock(articuloDTO);

		}
		catch (Exception e) {
			String msgError = "Ocurrio un error al anular reserva simcard ";
			logger.debug(msgError, e);
			String mensaje = e.getMessage() == null ? " " : ", " + e.getMessage();
			retorno.setCodError("1");
			retorno.setMsgError(msgError + mensaje);

		}

		return retorno;
	}

	/* anula reserva de equipo procedencia interna */
	public RetornoValorAjaxDTO anularReservaEquipo(String numEquipo) throws Exception {
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);
		RetornoValorAjaxDTO retorno = new RetornoValorAjaxDTO();

		if (!validarSesion(sesion)) {
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;
		}

		try {
			long numVenta = 0;
			if (sesion.getAttribute("DatosVentaForm") != null) {
				DatosVentaForm datosVentaForm = (DatosVentaForm) sesion.getAttribute("DatosVentaForm");
				numVenta = datosVentaForm.getNumeroVenta();
			}

			TerminalDTO terminalDTO = new TerminalDTO();
			terminalDTO.setNumeroSerie(numEquipo);
			terminalDTO = delegate.getTerminal(terminalDTO);

			// actualizar stock
			ArticuloDTO articuloDTO = new ArticuloDTO();
			articuloDTO.setTipoMovimiento(global.getValor("tipo.movto.libventa"));
			articuloDTO.setTipoStock(Integer.parseInt(terminalDTO.getTipoStock()));
			articuloDTO.setCodigoBodega(Integer.parseInt(terminalDTO.getCodigoBodega()));
			articuloDTO.setCodigo(Long.parseLong(terminalDTO.getCodigoArticulo()));
			articuloDTO.setCodigoUso(terminalDTO.getCodigoUso());
			articuloDTO.setCodigoEstado(1);
			articuloDTO.setNumeroVenta(String.valueOf(numVenta));
			articuloDTO.setNumeroSerie(numEquipo);
			delegate.actualizaStock(articuloDTO);

		}
		catch (Exception e) {
			String msgError = "Ocurrio un error al anular reserva equipo ";
			logger.debug(msgError, e);
			String mensaje = e.getMessage() == null ? " " : ", " + e.getMessage();
			retorno.setCodError("1");
			retorno.setMsgError(msgError + mensaje);

		}

		return retorno;
	}

	/* anula reserva numero celular */
	public RetornoValorAjaxDTO anularReservaNumeracion(String numCelular) throws Exception {
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);
		RetornoValorAjaxDTO retorno = new RetornoValorAjaxDTO();

		if (!validarSesion(sesion)) {
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;
		}

		try {
			String tablaNumeracion = "";
			String codSubAlm = "";
			String codCentral = "";
			String codCategoria = "";
			String codUso = "";
			if (sesion.getAttribute("DatosLineaForm") != null) {
				DatosLineaForm datosLineaForm = (DatosLineaForm) sesion.getAttribute("DatosLineaForm");
				tablaNumeracion = datosLineaForm.getTablaNumeracion();
				codSubAlm = datosLineaForm.getCodSubAlmNumeracion();
				codCentral = datosLineaForm.getCodCentralNumeracion();
				codCategoria = datosLineaForm.getCategoriaNumeracion();
				codUso = datosLineaForm.getCodUsoNumeracion();
			}

			NumeracionCelularDTO numeracionCelularDTO = new NumeracionCelularDTO();
			numeracionCelularDTO.setNombreTabla(tablaNumeracion);
			numeracionCelularDTO.setCodSubALM(codSubAlm);
			numeracionCelularDTO.setCodCentral(codCentral);
			numeracionCelularDTO.setCodCat(codCategoria);
			numeracionCelularDTO.setCodUso(codUso);
			numeracionCelularDTO.setNumCelular(new Long(numCelular));
			logger.info("(DesReserva) Reponer Número Celular P_REPONER_NUMERACION");
			delegate.reponerNumeracion(numeracionCelularDTO);
			logger.info("(DesReserva) Borrar registro en la GA_RESNUMCEL");
			delegate.desReservaNumeroCelular(numeracionCelularDTO);

		}
		catch (Exception e) {
			String msgError = "Ocurrio un error al anular reserva numeracion ";
			logger.debug(msgError, e);
			String mensaje = e.getMessage() == null ? " " : ", " + e.getMessage();
			retorno.setCodError("1");
			retorno.setMsgError(msgError + mensaje);

		}

		return retorno;
	}

	public RetornoValidacionAjaxDTO validarNumeroInternet(String numCelular, String procedencia) {
		logger.debug("validarNumeroFrecuente:inicio()");
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);
		RetornoValidacionAjaxDTO retorno = new RetornoValidacionAjaxDTO();

		if (!validarSesion(sesion)) {
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;
		}

		NumeroInternetDTO numeroInternetDTO = new NumeroInternetDTO();
		retorno.setValido(true);
		try {
			String codCliente = "";
			if (sesion.getAttribute("DatosVentaForm") != null) {
				DatosVentaForm datosVentaForm = (DatosVentaForm) sesion.getAttribute("DatosVentaForm");
				codCliente = datosVentaForm.getCodCliente();
			}

			numeroInternetDTO.setNumero(numCelular);
			numeroInternetDTO.setProcedencia(procedencia);
			numeroInternetDTO.setCodCliente(Long.parseLong(codCliente));
			delegate.validaNumeroInternet(numeroInternetDTO);
		}
		catch (Exception e) {
			retorno.setValido(false);
		}
		logger.debug("validarNumeroFrecuente:fin()");
		return retorno;
	}

	public RetornoValidacionAjaxDTO validarPlanCompartido(String codPlanTarif) {
		logger.debug("validarPlanCompartido:inicio()");
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);
		RetornoValidacionAjaxDTO retorno = new RetornoValidacionAjaxDTO();

		if (!validarSesion(sesion)) {
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;
		}

		retorno.setValido(true);
		try {
			String codCliente = "0";
			if (sesion.getAttribute("DatosVentaForm") != null) {
				DatosVentaForm datosVentaForm = (DatosVentaForm) sesion.getAttribute("DatosVentaForm");
				codCliente = datosVentaForm.getCodCliente();
			}

			delegate.validarPlanCompartido(new Long(codCliente), codPlanTarif);

		}
		catch (VentasException e) {
			retorno.setValido(false);
			String mensaje = e.getDescripcionEvento() == null ? e.getMessage() : e.getDescripcionEvento();
			retorno.setCodError("1");
			retorno.setMsgError(mensaje);
			logger.debug("[VentasException]" + mensaje);
		}
		catch (Exception e) {
			retorno.setValido(false);
			String mensaje = e.getMessage() == null ? " " : e.getMessage();
			retorno.setCodError("1");
			retorno.setMsgError(mensaje);
			logger.debug("[Exception]" + mensaje);
		}

		logger.debug("validarPlanCompartido:fin()");
		return retorno;
	}

	private boolean validarSesion(HttpSession sesion) {

		if (sesion == null)
			return false;

		ParametrosGlobalesDTO sessionData = (ParametrosGlobalesDTO) sesion.getAttribute("paramGlobal");
		if (sessionData == null)
			return false;

		return true;
	}

	/**
	 * @author JIB
	 * @param codGrupoPrestacion
	 * @param codTipoCliente
	 * @return
	 */
	public RetornoListaAjaxDTO obtenerTiposPrestacionXTipoCliente(String codGrupoPrestacion, String codTipoCliente) {
		logger.info("obtenerTiposPrestacionXTipoCliente, inicio");
		logger.debug("codGrupoPrestacion [" + codGrupoPrestacion + "]");
		logger.debug("codTipoCliente [" + codTipoCliente + "]");
		RetornoListaAjaxDTO retorno = new RetornoListaAjaxDTO();
		TipoPrestacionDTO[] lista = null;
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);
		if (!validarSesion(sesion)) {
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;
		}
		try {
			lista = delegate.getTiposPrestacion(codGrupoPrestacion, codTipoCliente);
		}
		catch (Exception e) {
			logger.error("Ocurrio un error al obtener tipos de prestacion ", e);
			String mensaje = e.getMessage() == null ? " " : ", " + e.getMessage();
			retorno.setCodError("1");
			retorno.setMsgError("Ocurrio un error al obtener tipos de prestacion " + mensaje);
		}
		retorno.setLista(lista);
		logger.debug("encontrados [" + lista.length + "]");
		logger.info("obtenerTiposPrestacionXTipoCliente, fin");
		return retorno;
	}

	/**
	 * @author JIB
	 * @param codTipoRed
	 * @param codTipoCliente
	 * @return
	 */
	public RetornoListaAjaxDTO obtenerUsosXTipoCliente(String codTipoRed, String codTipoCliente) throws Exception {
		logger.info("obtenerUsosXTipoCliente, inicio");
		logger.debug("codTipoRed [" + codTipoRed + "]");
		logger.debug("codTipoCliente [" + codTipoCliente + "]");
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);
		RetornoListaAjaxDTO retorno = new RetornoListaAjaxDTO();
		if (!validarSesion(sesion)) {
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;
		}
		UsoDTO[] lista = null;
		try {
			UsoDTO usoDTO = new UsoDTO();
			usoDTO.setTipoRed(codTipoRed);
			usoDTO.setTipoCliente(codTipoCliente);
			lista = delegate.getUsos(usoDTO);
		}
		catch (Exception e) {
			logger.error("Ocurrio un error al obtener usos ", e);
			String mensaje = e.getMessage() == null ? " " : ", " + e.getMessage();
			retorno.setCodError("1");
			retorno.setMsgError("Ocurrio un error al obtener usos " + mensaje);
		}
		retorno.setLista(lista);
		logger.debug("encontrados [" + lista.length + "]");
		logger.info("obtenerUsosXTipoCliente, inicio");
		return retorno;
	}

	/**
	 * @author JIB
	 * @param codSeguro
	 * @param codPeriodo
	 * @return
	 */
	public RetornoValorAjaxDTO obtenerFechaVigenciaSeguroXPeriodo(String codSeguro, String codPeriodo) {
		logger.info("obtenerFechaVigenciaSeguro, inicio()");
		logger.debug("codSeguro [" + codSeguro + "]");
		logger.debug("codPeriodo [" + codPeriodo + "]");
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);
		RetornoValorAjaxDTO retorno = new RetornoValorAjaxDTO();
		if (!validarSesion(sesion)) {
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;
		}
		String fechaVigencia = "";
		try {
			SeguroDTO seguro = new SeguroDTO();
			seguro.setCodSeguro(codSeguro);
			seguro.setPeriodo(Integer.parseInt(codPeriodo));
			seguro = delegate.obtieneDatosSeguro(seguro);
			fechaVigencia = seguro.getFechaFinContrato();
		}
		catch (Exception e) {
			String msgError = "Ocurrio un error al obtener fecha de vigencia del seguro ";
			logger.debug(msgError, e);
			String mensaje = e.getMessage() == null ? " " : ", " + e.getMessage();
			retorno.setCodError("1");
			retorno.setMsgError(msgError + mensaje);
		}
		logger.debug("fechaVigencia [" + fechaVigencia + "]");
		retorno.setResultado(fechaVigencia);
		logger.info("obtenerFechaVigenciaSeguro, fin()");
		return retorno;
	}

	/**
	 * @author JIB
	 * @param indEquipo
	 * @param codSeguro
	 * @param codPeriodo
	 * @return
	 */
	public RetornoListaAjaxDTO obtenerArticulos(String cod_tecnologia, int codUso, String tipTerminal, String indEquipo) {
		logger.info("obtenerArticulos, inicio()");
		logger.debug("cod_tecnologia [" + cod_tecnologia + "]");
		logger.debug("indEquipo  [" + indEquipo + "]");
		logger.debug("codUso [" + codUso + "]");
		logger.debug("tipTerminal  [" + tipTerminal + "]");
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);
		RetornoListaAjaxDTO retorno = new RetornoListaAjaxDTO();
		ArticuloInDTO[] array = new ArticuloInDTO[0];
		if (!validarSesion(sesion)) {
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;
		}
		try {
			ArticuloInDTO entrada = new ArticuloInDTO();
			entrada.setCod_tecnologia(cod_tecnologia);
			entrada.setIndEquipo(indEquipo);// "E" para equipos
			entrada.setCodUso(codUso);
			entrada.setTipTerminal(tipTerminal);
			array = delegate.getArticulos(entrada);
		}
		catch (Exception e) {
			String msgError = "Ocurrio un error al obtener articulos";
			logger.debug(msgError, e);
			String mensaje = e.getMessage() == null ? " " : ", " + e.getMessage();
			retorno.setCodError("1");
			retorno.setMsgError(msgError + mensaje);
		}
		retorno.setLista(array);
		logger.debug("encontrados [" + array.length);
		logger.info("obtenerArticulos, fin()");
		return retorno;
	}

	public RetornoListaAjaxDTO obtenerLimitesConsumoXPlanTarifYCodCliente(String codPlanTarif, String codCliente)
			throws Exception {
		logger.info("obtenerLimitesConsumoXPlanTarifYCodCliente, inicio");
		logger.debug("codPlanTarif [" + codPlanTarif + "]");
		logger.debug("codCliente [" + codCliente + "]");
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);
		RetornoListaAjaxDTO retorno = new RetornoListaAjaxDTO();
		long recuperados = 0;
		if (!validarSesion(sesion)) {
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;
		}
		PlanTarifarioComDTO[] listaLimites = null;
		try {
			PlanTarifarioComDTO planTarifarioComDTO = new PlanTarifarioComDTO();
			planTarifarioComDTO.setCodigoPlanTarifario(codPlanTarif);
			planTarifarioComDTO.setCodigoCliente(codCliente);
			listaLimites = delegate.getLimitesConsumo(planTarifarioComDTO);
			if (listaLimites != null) {
				recuperados = listaLimites.length;
			}
		}
		catch (Exception e) {
			logger.debug("Ocurrio un error al obtener limites consumo ", e);
			String mensaje = e.getMessage() == null ? " " : ", " + e.getMessage();
			retorno.setCodError("1");
			retorno.setMsgError("Ocurrio un error al obtener limites consumo " + mensaje);
		}
		retorno.setLista(listaLimites);
		logger.debug("recuperados [" + recuperados + "]");
		logger.info("obtenerLimitesConsumoXPlanTarifYCodCliente, fin");
		return retorno;
	}

	/**
	 * @author JIB
	 * @param codPlanTarif
	 * @param codCliente
	 * @return
	 */
	public RetornoValidacionAjaxDTO validarPlanCompartidoXCodPlanTarifYCodCliente(String codPlanTarif, String codCliente) {
		logger.info("validarPlanCompartidoXCodPlanTarifYCodCliente, inicio");
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);
		RetornoValidacionAjaxDTO retorno = new RetornoValidacionAjaxDTO();
		if (!validarSesion(sesion)) {
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;
		}
		retorno.setValido(true);
		try {
			delegate.validarPlanCompartido(new Long(codCliente), codPlanTarif);
		}
		catch (Exception e) {
			logger.error(StackTraceUtl.getStackTrace(e));
			String mensaje = e.getMessage() == null ? " Ocurrio un error al validar plan " : e.getMessage();
			retorno.setValido(false);
			retorno.setCodError("1");
			retorno.setMsgError(mensaje);
		}
		logger.info("validarPlanCompartidoXCodPlanTarifYCodCliente, fin");
		return retorno;
	}

	private TiposComportamientoForm tiposComportamientoForm;

	private PlanesAdicionalesScoringForm planesAdicionalesScoringForm;

	/**
	 * @author JIB
	 * @return
	 */
	private TiposComportamientoForm getTiposComportamientoForm(HttpServletRequest request) {
		return tiposComportamientoForm == null ? (TiposComportamientoForm) request.getSession().getAttribute(
				"TiposComportamientoForm") : tiposComportamientoForm;
	}

	/**
	 * @author JIB
	 * @return
	 */
	private PlanesAdicionalesScoringForm getPlanesAdicionalesScoringForm(HttpServletRequest request) {
		return planesAdicionalesScoringForm == null ? (PlanesAdicionalesScoringForm) request.getSession().getAttribute(
				"PlanesAdicionalesScoringForm") : planesAdicionalesScoringForm;
	}

	/**
	 * @author JIB
	 * @return
	 */
	public RetornoValidacionAjaxDTO limpiarPAScoring() {
		logger.info("limpiarPAScoring, inicio");
		RetornoValidacionAjaxDTO retorno = new RetornoValidacionAjaxDTO();
		final HttpServletRequest request = WebContextFactory.get().getHttpServletRequest();
		if (!SessionHelper.validarSesion(request.getSession(false))) {
			retorno.setValido(false);
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;
		}
		if (getTiposComportamientoForm(request) != null) {
			logger.debug("Limpia tipos de comportamiento PA");
			getTiposComportamientoForm(request).setTiposSeleccionadosEnCSV(null);
		}
		if (getPlanesAdicionalesScoringForm(request) != null) {
			logger.debug("Limpia productos PA");
			getPlanesAdicionalesScoringForm(request).setProductosSeleccionadosEnCSV(null);
		}
		retorno.setValido(true);
		logger.info("limpiarPAScoring, fin");
		return retorno;
	}

	/**
	 * @param codUso
	 * @return
	 * @throws Exception
	 */
	public RetornoListaAjaxDTO getListadoCampaniasVigentesXCodUso(String codUso) throws Exception {
		logger.info("getListadoCampaniasVigentesXCodUso, inicio");
		HttpSession sesion = WebContextFactory.get().getHttpServletRequest().getSession(false);
		RetornoListaAjaxDTO r = new RetornoListaAjaxDTO();
		if (!validarSesion(sesion)) {
			r.setCodError("-100");
			r.setMsgError("Su sesión ha expirado");
			return r;
		}
		CampanaVigenteDTO[] a = null;
		try {
			a = delegate.getListadoCampaniasVigentesXCodUso(codUso);
		}
		catch (Exception e) {
			logger.debug("Ocurrió un error al obtener campañas vigentes", e);
			String mensaje = e.getMessage() == null ? " " : ", " + e.getMessage();
			r.setCodError("1");
			r.setMsgError("Ocurrió un error al obtener campañas vigentes" + mensaje);

		}
		r.setLista(a);
		logger.info("getListadoCampaniasVigentesXCodUso, fin");
		return r;
	}
	
	//Inicio P-CSR-11002 JLGN 01-07-2011
	public RetornoListaAjaxDTO getCargoPlanTarif(String codPlanTarif) throws Exception {
		logger.info("getCargoPlanTarif, inicio");
		HttpSession sesion = WebContextFactory.get().getHttpServletRequest().getSession(false);
		RetornoListaAjaxDTO r = new RetornoListaAjaxDTO();
		if (!validarSesion(sesion)) {
			r.setCodError("-100");
			r.setMsgError("Su sesión ha expirado");
			return r;
		}
		long a = 0;
		try {
			a = delegate.getCargoPlanTarif(codPlanTarif);
		}
		catch (Exception e) {
			logger.debug("Ocurrió un error al obtener cargo Plan Tarifario", e);
			String mensaje = e.getMessage() == null ? " " : ", " + e.getMessage();
			r.setCodError("1");
			r.setMsgError("Ocurrió un error al obtener cargo Plan Tarifario" + mensaje);
		}
		r.setCargoPT(a);
		logger.info("getCargoPlanTarif, fin");
		return r;
	}
	//Fin P-CSR-11002 JLGN 01-07-2011
	
	//Inicio P-CSR-11002 JLGN 03-08-2011
	
	private String obtenerActuacion(String indVentaExterna, String codTipoCliente, String codUso) throws Exception{
		String codActuacion = "";
		
		if (!(codTipoCliente.equals(global.getValor("tipo.cliente.prepago"))))
		{
			if (codUso.equals(global.getValor("codigo.uso.hibrido"))){
			    codActuacion=global.getValor("codigo.actuacion.hibrido");
			}else{
			   	if (indVentaExterna.equals("1")){
				    codActuacion=global.getValor("codigo.actuacion.movil.externa");
			    }else{
				    codActuacion=global.getValor("codigo.actuacion.movil.interna");
			    }
		    }
		}else{
			codActuacion = global.getValor("codigo.actuacion.prepago");
		}    
		logger.debug("codActuacion="+codActuacion);
		return codActuacion;
	}
	
	public RetornoBusquedaNumeracionAjaxDTO obtenerNumeracionAutomatica(String codCelda,String codCentral,String codUso, String codSubAlm) throws Exception {
		logger.debug("obtenerNumeracionAutomatica:inicio()");
		HttpSession sesion = WebContextFactory.get().getHttpServletRequest().getSession(false);
		
		RetornoBusquedaNumeracionAjaxDTO retorno = new RetornoBusquedaNumeracionAjaxDTO();
		
		if (!validarSesion(sesion)){
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;	
		}
		
		NumeroAjaxDTO[] listaRetorno = new NumeroAjaxDTO[1];
		
		try{
			/*String codCelda = "";
			String codCentral ="";
			String codUso = "";*/			
			String indVentaExterna = "";
			String codTipoCliente="";
			//String codSubAlm = "";
			
			//(+) indVentaExterna
			if (sesion.getAttribute("DatosVentaForm")!=null){
				DatosVentaForm datosVentaForm = (DatosVentaForm)sesion.getAttribute("DatosVentaForm");
				indVentaExterna = datosVentaForm.getIndVtaExterna();
				codTipoCliente=datosVentaForm.getCodTipoCliente();
				logger.debug("indVentaExterna: "+indVentaExterna);
				logger.debug("codTipoCliente: "+codTipoCliente);
			}
			//(-)
			
			//(+) busca  celda, central , uso
			/*if (sesion.getAttribute("DatosLineaForm")!=null){
				DatosLineaForm datosLineaForm = (DatosLineaForm)sesion.getAttribute("DatosLineaForm");
				codCelda = datosLineaForm.getCodCelda();
				codCentral = datosLineaForm.getCodCentral();
				codUso = datosLineaForm.getCodUsoLinea();
				
				logger.debug("PASO 1");
				logger.debug("codCelda: "+codCelda);
				logger.debug("codCentral: "+codCentral);				
				logger.debug("codUso: "+codUso);
			}*/
			//(-)
			
			logger.debug("codCelda: "+codCelda);
			logger.debug("codCentral: "+codCentral);				
			logger.debug("codUso: "+codUso);
			
			DatosNumeracionDTO datosNumeracionDTO = new DatosNumeracionDTO();
			datosNumeracionDTO.setCodCeldNue(codCelda);
			datosNumeracionDTO.setCodCentNue(codCentral);
			datosNumeracionDTO.setCodCodUsoNue(codUso);
			datosNumeracionDTO.setCodActabo(obtenerActuacion(indVentaExterna, codTipoCliente, codUso));
			logger.debug("Tipo Cliente " + codTipoCliente);
			datosNumeracionDTO = delegate.obtieneNumeracionAutomatica(datosNumeracionDTO);
			NumeroAjaxDTO numero = new NumeroAjaxDTO();
			numero.setNumCelular(String.valueOf(datosNumeracionDTO.getNumCelular()));
			numero.setFechaBaja(datosNumeracionDTO.getFecBaja());
			listaRetorno[0] = numero;
			
			sesion.setAttribute("listaNumeros", listaRetorno);
			sesion.removeAttribute("listaNumerosRango");
			
			//(+)------ Reservar ------------------------------------
			/*if (sesion.getAttribute("DatosLineaForm")!=null){
				DatosLineaForm datosLineaForm = (DatosLineaForm)sesion.getAttribute("DatosLineaForm");
				codUso = datosLineaForm.getCodUsoLinea();
				codCentral = datosLineaForm.getCodCentral();
				codSubAlm = datosLineaForm.getCodSubAlm();
			}*/
			//Numero transaccion
			RegistroVentaDTO secuenciaTransaccion = delegate.getSecuenciaTransacabo();
		
			String tabla = datosNumeracionDTO.getNomtabla();
			String categoria = datosNumeracionDTO.getCodCatNue();
			String fechaBaja = datosNumeracionDTO.getFecBaja();
			String user = "";
			
			logger.debug("secuenciaTransaccion: "+secuenciaTransaccion.getCodigoSecuencia());
			logger.debug("tabla: "+tabla);
			logger.debug("categoria: "+categoria);
			logger.debug("fechaBaja: "+fechaBaja);
			
			NumeracionCelularDTO numeracionCelularDTO = new NumeracionCelularDTO();
			numeracionCelularDTO.setSecuencia(String.valueOf(secuenciaTransaccion.getNumeroTransaccionVenta()));
			numeracionCelularDTO.setNombreTabla(tabla);
			numeracionCelularDTO.setCodSubALM(codSubAlm);
			numeracionCelularDTO.setCodCentral(codCentral);
			numeracionCelularDTO.setCodCat(categoria);
			numeracionCelularDTO.setCodUso(codUso);
			numeracionCelularDTO.setNumCelular(datosNumeracionDTO.getNumCelular());
			
			//Paso 1
			numeracionCelularDTO.setNumLinea(new Long("1"));
			numeracionCelularDTO.setNumOrden(new Long("1"));
			user = ((ParametrosGlobalesDTO)sesion.getAttribute("paramGlobal")).getCodUsuario();
			numeracionCelularDTO.setNomUsuarioSCL(user);
			numeracionCelularDTO.setIndProcNum(tabla);
			numeracionCelularDTO.setFecBaja(fechaBaja);
			logger.info("(Reserva) Inserta GA_RESNUMCEL");
			delegate.insertarNumeroCelularReservado(numeracionCelularDTO);
			
			//Inicio P-CSR-11002 JLGN 14-11-2011
			//Se valida si el numero celular obtenido se encuentra asociado a un abonado
			//distindo de BAA y BAP
			delegate.validaDisponibilidadNumero(String.valueOf(datosNumeracionDTO.getNumCelular()));
			//Fin P-CSR-11002 JLGN 14-11-2011			
			
			//Dejar numero en sesion para cargarlo en Datos Linea
			NumeroAjaxDTO numeroSel = new NumeroAjaxDTO();
			numeroSel.setNumCelular(String.valueOf(datosNumeracionDTO.getNumCelular()));
			numeroSel.setTablaNumeracion(tabla);
			numeroSel.setCategoria(categoria);			

			sesion.removeAttribute("listaNumeros");
			sesion.removeAttribute("listaNumerosRango");		
			sesion.setAttribute("numeroSel", numeroSel);
			
			retorno.setTablaNumeracion(datosNumeracionDTO.getNomtabla());
			retorno.setCategoria(datosNumeracionDTO.getCodCatNue());
			retorno.setNumero(String.valueOf(datosNumeracionDTO.getNumCelular()));
			retorno.setFechaBaja(datosNumeracionDTO.getFecBaja());
			
		}catch(Exception e){
			logger.debug("Exception: "+ e);
        	String mensaje = e.getMessage()==null?"Ocurrió un error al obtener numeración automática":e.getMessage();
        	retorno.setCodError("1");
			retorno.setMsgError(mensaje);
		}

		logger.debug("obtenerNumeracionAutomatica:fin()");		
		return retorno;
	}
	
	/*
	 * Anula reserva automatica
	 */
	public RetornoValorAjaxDTO reponerNumeracionAutomatica(String numCelular, String tabla, String codCateg)throws Exception {
		logger.debug("reponerNumeracionAutomatica:inicio()");
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);
		
		RetornoValorAjaxDTO retorno = new RetornoValorAjaxDTO();
		
		if (!validarSesion(sesion)){
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;	
		}
		
		try{
			String codCentral ="";
			String codUso = "";			
			String codSubAlm = "";
			
			//(+) busca  celda, central  uso
			if (sesion.getAttribute("DatosLineaForm")!=null){
				DatosLineaForm datosLineaForm = (DatosLineaForm)sesion.getAttribute("DatosLineaForm");
				codCentral = datosLineaForm.getCodCentralSeleccionada();
				codUso = datosLineaForm.getCodUsoLineaSeleccionado();
				codSubAlm = datosLineaForm.getCodSubAlm();
			}
			//(-)
			
			NumeracionCelularDTO numeracionCelularDTO = new NumeracionCelularDTO();
			numeracionCelularDTO.setNombreTabla(tabla);
			numeracionCelularDTO.setCodSubALM(codSubAlm);
			numeracionCelularDTO.setCodCentral(codCentral);
			numeracionCelularDTO.setCodCat(codCateg);
			numeracionCelularDTO.setCodUso(codUso);
			numeracionCelularDTO.setNumCelular(new Long(numCelular));
			logger.info("(DesReserva) Reponer Número Celular P_REPONER_NUMERACION");
			delegate.reponerNumeracion(numeracionCelularDTO);

		}catch(Exception e){
        	String mensaje = e.getMessage()==null?"Ocurrió un error al reponer numeración automática":e.getMessage();
        	retorno.setCodError("1");
			retorno.setMsgError(mensaje);
		}

		logger.debug("reponerNumeracionAutomatica:fin()");		
		return retorno;

	}
	//Fin P-CSR-11002 JLGN 03-08-2011
	
	//Inicio Inc.179734 06-01-2012 JLGN
	public RetornoValorAjaxDTO validaLineasClienteDDA(String tipIdent, String numIdent) throws Exception {
		logger.info("validaLineasClienteDDA, inicio");
		HttpSession sesion = WebContextFactory.get().getHttpServletRequest().getSession(false);
		RetornoValorAjaxDTO r = new RetornoValorAjaxDTO();
		if (!validarSesion(sesion)) {
			r.setCodError("-100");
			r.setMsgError("Su sesión ha expirado");
			return r;
		}
		try {
			if(!delegate2.validaLineasClienteDDA(tipIdent, numIdent)){
				logger.debug("No se puede activar más líneas por tener restricción del Buró y pago con Débito Automático");
				r.setResultado("1");
				r.setCodError("1");
				r.setMsgError("No se puede activar más líneas por tener restricción del Buró y pago con Débito Automático");
				return r;
			}	
			r.setResultado("0");
		}
		catch (Exception e) {
			logger.debug("Ocurrió un error al Validar cantidad de Lineas", e);
			String mensaje = e.getMessage() == null ? " " : ", " + e.getMessage();
			r.setCodError("1");
			r.setMsgError("Ocurrió un error al Validar cantidad de Lineas" + mensaje);
		}
		logger.info("validaLineasClienteDDA, fin");
		return r;
	}
	//Fin Inc.179734 06-01-2012 JLGN 
}