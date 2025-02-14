package com.tmmas.cl.scl.portalventas.web.helper;

import java.text.SimpleDateFormat;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import uk.ltd.getahead.dwr.WebContextFactory;

import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.scl.altacliente.presentacion.dto.RetornoListaAjaxDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.ArticuloInDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosValidacionVentasDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ResultadoValidacionVentaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.VentasException;
import com.tmmas.cl.scl.portalventas.web.delegate.PortalVentasDelegate;
import com.tmmas.cl.scl.portalventas.web.dto.ArticuloAjaxDTO;
import com.tmmas.cl.scl.portalventas.web.dto.ArticuloSeriesAjaxDTO;
import com.tmmas.cl.scl.portalventas.web.dto.SerieAjaxDTO;
import com.tmmas.cl.scl.portalventas.web.form.DatosLineaForm;
import com.tmmas.cl.scl.portalventas.web.form.DatosVentaForm;
import com.tmmas.cl.scl.productdomain.businessobject.dto.BodegaDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.SerieDTO;
import com.tmmas.cl.scl.resourcedomain.businessobject.dto.CentralDTO;

public class BuscaSeriesAJAX {

	private static final String DATOS_VENTA_FORM = "DatosVentaForm";

	private static final String DATOS_LINEA_FORM = "DatosLineaForm";

	private static final String MENSAJE_ERROR_SERIE_SIMCARD_YA_ASIGNADO = "El N° de serie de la simcard ya se encuentra asignado a esta línea";

	private static final String MENSAJE_ERROR_SERIE_EQUIPO_YA_ASIGNADO = "El N° de serie del equipo ya se encuentra asignado a esta línea";

	private static final String MENSAJE_ERROR_BUSQUEDA_SERIES = "Ocurrió un error al obtener series";

	private static final String MENSAJE_ERROR_SERIE_SIMCARD_EN_USO = "N° de Serie no disponible";

	private final Logger logger = Logger.getLogger(BuscaSeriesAJAX.class);

	private Global global = Global.getInstance();

	PortalVentasDelegate delegate = PortalVentasDelegate.getInstance();

	/*
	 * Carga la lista de series para numero de telefono y numero de serie
	 */
	public RetornoListaAjaxDTO obtenerSeries(int procedencia, String numTelefono, String numSerie,
			String codTipoArticulo) {
		logger.info("obtenerSeries, inicio()");
		logger.debug("procedencia [" + procedencia + "]");
		logger.debug("numTelefono [" + numTelefono + "]");
		logger.debug("numSerie [" + numSerie + "]");
		logger.debug("codTipoArticulo [" + codTipoArticulo + "]");
		final boolean buscandoSimcard = codTipoArticulo.equals("S");
		final boolean buscandoEquipo = codTipoArticulo.equals("E");
		logger.debug("buscandoSimcard [" + buscandoSimcard + "]");
		logger.debug("buscandoEquipo [" + buscandoEquipo + "]");
		HttpSession sesion = WebContextFactory.get().getHttpServletRequest().getSession(false);
		RetornoListaAjaxDTO retorno = new RetornoListaAjaxDTO();
		if (!SessionHelper.validarSesion(sesion)) {
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;
		}
		SerieAjaxDTO[] listaRetorno = null;
		SerieDTO[] listaSeries = null;
		SimpleDateFormat formaBD = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		SimpleDateFormat formatJava = new SimpleDateFormat("dd/MM/yyyy hh:mm:ss");
		String codHLR = "";
		try {
			String codVendedor = "0";
			String codModVenta = "0";
			//(+) busca modalidad de venta y vendedor
			if (sesion.getAttribute(DATOS_VENTA_FORM) != null) {
				DatosVentaForm datosVentaForm = (DatosVentaForm) sesion.getAttribute(DATOS_VENTA_FORM);
				codVendedor = datosVentaForm.getCodDistribuidor();
				codModVenta = datosVentaForm.getCodModalidadVenta();
				if (datosVentaForm.getCodVendedor() != null && !datosVentaForm.getCodVendedor().trim().equals("")) {
					procedencia = 1;
				}
			}
			//(-)
			SerieDTO serieDTO = new SerieDTO();
			serieDTO.setNumTelefono(numTelefono);
			serieDTO.setNumSerie(numSerie);
			serieDTO.setCodCanal(procedencia);
			serieDTO.setCodModVenta(Integer.parseInt(codModVenta));
			serieDTO.setCodVendedor(Long.parseLong(codVendedor));
			serieDTO.setTipArticulo(codTipoArticulo);

			if (sesion.getAttribute(DATOS_LINEA_FORM) != null) {
				DatosLineaForm datosLineaForm = (DatosLineaForm) sesion.getAttribute(DATOS_LINEA_FORM);
				serieDTO.setCodTecnologia(datosLineaForm.getCodTecnologia());
				serieDTO.setTipTerminal(datosLineaForm.getCodTipoTerminal());
				serieDTO.setCodUso(new Integer(datosLineaForm.getCodUsoLinea()).intValue());
				serieDTO.setCodCentral(new Long(datosLineaForm.getCodCentral()).longValue());
				CentralDTO centralDTO = new CentralDTO();
				centralDTO.setCodigoCentral(datosLineaForm.getCodCentral());
				CentralDTO[] listaCentral = delegate.getDatosCentral(centralDTO);
				if (listaCentral != null && listaCentral.length > 0) {
					codHLR = listaCentral[0].getCodigoHlr();
				}
				serieDTO.setCodHlr(codHLR);

				//Incidencia: 147105. JIB.
				//Se corrigen mensajes de búsqueda de series de simcard y equipo.
				if (buscandoSimcard && datosLineaForm.getNumSerie().equals(numSerie)) {
					logger.debug("datosLineaForm.getNumSerie() [" + datosLineaForm.getNumSerie() + "]");
					throw new VentasException(MENSAJE_ERROR_SERIE_SIMCARD_YA_ASIGNADO);
				}

				if (buscandoEquipo && datosLineaForm.getNumEquipo().equals(numSerie)) {
					logger.debug("datosLineaForm.getNumEquipo() [" + datosLineaForm.getNumEquipo() + "]");
					throw new VentasException(MENSAJE_ERROR_SERIE_EQUIPO_YA_ASIGNADO);
				}
			}

			//Incidencia: 147105. JIB. Se corrige el rechazo.
			//Se corrigen mensaje de búsqueda de serie cuando la serie existe pero está en uso.
			listaSeries = delegate.buscarSerie(serieDTO);
			if (buscandoSimcard && numSerie != null && numSerie != "") {
				if (listaSeries != null && listaSeries.length == 0) {
					logger.debug("listaSeries.length [" + listaSeries.length + "]");
					throw new VentasException(MENSAJE_ERROR_SERIE_SIMCARD_EN_USO);
				}
			}

			listaRetorno = new SerieAjaxDTO[listaSeries.length];
			for (int i = 0; i < listaSeries.length; i++) {
				SerieAjaxDTO serieAjaxDTO = new SerieAjaxDTO();
				SerieDTO item = listaSeries[i];
				serieAjaxDTO.setNumTelefono(item.getNumTelefono());
				serieAjaxDTO.setNumSerie(item.getNumSerie());
				serieAjaxDTO.setFecha(item.getFechaEntrada());
				serieAjaxDTO.setTipoStock(item.getTipoStock());
				//INC 185192 JVA INICIO
				logger.debug("JVA 185192 SERIEAJAX");
				serieAjaxDTO.setCodArticuloEquipo(String.valueOf(item.getCodArticulo()));
				logger.debug("serieAjaxDTO.getCodArticuloEquipo :"+serieAjaxDTO.getCodArticuloEquipo());	
				//INC 185192 JVA FIN
				if (serieAjaxDTO.getFecha() != null) {
					serieAjaxDTO.setFecha(formatJava.format(formaBD.parse(serieAjaxDTO.getFecha())));
				}
				serieAjaxDTO.setCodUso(new Integer(item.getCodUso()).toString());
				serieAjaxDTO.setDesUso(item.getDesUso().toString());
				listaRetorno[i] = serieAjaxDTO;
			}
			sesion.setAttribute("listaSeries", listaRetorno);
		}
		catch (Exception e) {
			logger.error(StackTraceUtl.getStackTrace(e));
			String mensaje = e.getMessage() == null ? " " : ", " + e.getMessage();
			logger.debug("obtenerSeriesError: "+ mensaje);
			retorno.setCodError("1");
			retorno.setMsgError(MENSAJE_ERROR_BUSQUEDA_SERIES + mensaje);
		}
		retorno.setLista(listaRetorno);
		logger.info("obtenerSeries, fin()");
		return retorno;
	}

	/*
	 * Carga la lista de series para bodega y articulo
	 */
	public RetornoListaAjaxDTO obtenerSeriesBodega(int procedencia, String codBodega, String codArticulo,
			String codTipoArticulo) {
		logger.info("obtenerSeriesBodega:inicio()");
		logger.debug("procedencia [" + procedencia + "]");
		logger.debug("codBodega [" + codBodega + "]");
		logger.debug("codArticulo [" + codArticulo + "]");
		logger.debug("codTipoArticulo [" + codTipoArticulo + "]");
		HttpSession sesion = WebContextFactory.get().getHttpServletRequest().getSession(false);
		RetornoListaAjaxDTO retorno = new RetornoListaAjaxDTO();
		if (!SessionHelper.validarSesion(sesion)) {
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;
		}
		SerieAjaxDTO[] listaRetorno = null;
		SerieDTO[] listaSeries = null;
		SimpleDateFormat formaBD = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		SimpleDateFormat formatJava = new SimpleDateFormat("dd/MM/yyyy hh:mm:ss");
		try {
			String codHLR = "";
			String codModVenta = "0";
			String codVendedor = "0";
			String codCentral = "";
			String codUso = "";
			//(+)busca modalidad de venta y vendedor
			if (sesion.getAttribute(DATOS_VENTA_FORM) != null) {
				DatosVentaForm datosVentaForm = (DatosVentaForm) sesion.getAttribute(DATOS_VENTA_FORM);
				codModVenta = datosVentaForm.getCodModalidadVenta();
				codVendedor = datosVentaForm.getCodDistribuidor();
				if (datosVentaForm.getCodVendedor() != null && !datosVentaForm.getCodVendedor().trim().equals("")) {
					procedencia = 1;
				}
			}
			//(-)

			//(+)busca central y uso
			if (sesion.getAttribute(DATOS_LINEA_FORM) != null) {
				DatosLineaForm datosLineaForm = (DatosLineaForm) sesion.getAttribute(DATOS_LINEA_FORM);
				codCentral = datosLineaForm.getCodCentral();
				codUso = datosLineaForm.getCodUsoLinea();
			}
			//(-)

			//(+)busca HLR
			CentralDTO centralDTO = new CentralDTO();
			centralDTO.setCodigoCentral(codCentral);
			CentralDTO[] listaCentral = delegate.getDatosCentral(centralDTO);
			if (listaCentral != null && listaCentral.length > 0) {
				codHLR = listaCentral[0].getCodigoHlr();
			}
			//(-)

			SerieDTO serieDTO = new SerieDTO();
			serieDTO.setCodBodega(Long.parseLong(codBodega));
			serieDTO.setCodArticulo(Long.parseLong(codArticulo));
			serieDTO.setCodHlr(codHLR);
			serieDTO.setCodModVenta(Integer.parseInt(codModVenta));
			serieDTO.setCodCanal(procedencia);
			serieDTO.setCodVendedor(Long.parseLong(codVendedor));
			serieDTO.setCodCentral(Long.parseLong(codCentral));
			serieDTO.setCodUso(Integer.parseInt(codUso));
			serieDTO.setTipArticulo(codTipoArticulo);
			listaSeries = delegate.listarSerie(serieDTO);
			listaRetorno = new SerieAjaxDTO[listaSeries.length];
			//P-CSR-11002 JLGN 21-07-2011
			if(listaSeries.length > 0){ 
				for (int i = 0; i < listaSeries.length; i++) {
					SerieAjaxDTO serieAjaxDTO = new SerieAjaxDTO();
					SerieDTO item = listaSeries[i];
					serieAjaxDTO.setNumTelefono(item.getNumTelefono());
					serieAjaxDTO.setNumSerie(item.getNumSerie());
					serieAjaxDTO.setFecha(item.getFechaEntrada());
					serieAjaxDTO.setTipoStock(item.getTipoStock());
					if (serieAjaxDTO.getFecha() != null) {
						serieAjaxDTO.setFecha(formatJava.format(formaBD.parse(serieAjaxDTO.getFecha())));
					}
					serieAjaxDTO.setCodUso(new Integer(item.getCodUso()).toString());
					serieAjaxDTO.setDesUso(item.getDesUso().toString());
					listaRetorno[i] = serieAjaxDTO;
				}
			}else{
					throw new VentasException("No existen Articulos en la Bodega Seleccionada");
				 }	
			
			sesion.setAttribute("listaSeries", listaRetorno);
		}
		catch (Exception e) {
			String mensaje = e.getMessage() == null ? " " : ", " + e.getMessage();
			logger.debug("obtenerSeriesBodegaError: "+ mensaje);
			logger.debug("jorge error: "+ e.getLocalizedMessage());
			retorno.setCodError("1");
			retorno.setMsgError(MENSAJE_ERROR_BUSQUEDA_SERIES + mensaje);
			logger.error(StackTraceUtl.getStackTrace(e));
		}
		logger.info("obtenerSeriesBodega:fin()");
		return retorno;
	}

	/*
	 * Carga la lista de bodegas
	 */
	public RetornoListaAjaxDTO obtenerBodegas() {
		logger.info("obtenerBodegas:inicio()");
		HttpSession sesion = WebContextFactory.get().getHttpServletRequest().getSession(false);
		RetornoListaAjaxDTO retorno = new RetornoListaAjaxDTO();
		if (!SessionHelper.validarSesion(sesion)) {
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;
		}
		BodegaDTO[] listaBodegas = null;
		try {
			String codVendedor = "0";
			//(+) busca vendedor
			if (sesion.getAttribute(DATOS_VENTA_FORM) != null) {
				DatosVentaForm datosVentaForm = (DatosVentaForm) sesion.getAttribute(DATOS_VENTA_FORM);
				codVendedor = datosVentaForm.getCodDistribuidor();
			}
			//(-)
			BodegaDTO bodegaDTO = new BodegaDTO();
			bodegaDTO.setCodVendedor((Long.parseLong(codVendedor)));
			listaBodegas = delegate.getBodegasXVendedor(bodegaDTO);
		}
		catch (Exception e) {
			String mensaje = e.getMessage() == null ? " " : ", " + e.getMessage();
			retorno.setCodError("1");
			retorno.setMsgError("Ocurrió un error al obtener bodegas " + mensaje);
			logger.error(StackTraceUtl.getStackTrace(e));
		}
		retorno.setLista(listaBodegas);
		logger.info("obtenerBodegas:fin()");
		return retorno;
	}

	public RetornoListaAjaxDTO validaSerieExterna(String numSerie) {
		logger.info("validaSerieExterna:inicio()");
		logger.debug("numSerie [" + numSerie + "]");
		String codTecnologia = "";
		HttpSession sesion = WebContextFactory.get().getHttpServletRequest().getSession(false);
		RetornoListaAjaxDTO r = new RetornoListaAjaxDTO();
		if (!SessionHelper.validarSesion(sesion)) {
			r.setCodError("-100");
			r.setMsgError("Su sesión ha expirado");
			return r;
		}
		try {
			ParametrosValidacionVentasDTO entrada = new ParametrosValidacionVentasDTO();
			ResultadoValidacionVentaDTO resultado = new ResultadoValidacionVentaDTO();
			if (sesion.getAttribute(DATOS_LINEA_FORM) != null) {
				DatosLineaForm datosLineaForm = (DatosLineaForm) sesion.getAttribute(DATOS_LINEA_FORM);
				codTecnologia = datosLineaForm.getCodTecnologia();
			}
			if (("GSM").equals(codTecnologia)) {
				entrada.setNumeroSerieTerminal(numSerie);
				resultado = delegate.validaSeriesExternas(entrada);
				if (resultado.getEstado().equals("NOK")) {
					r.setCodError("4");
					r.setMsgError(resultado.getDetalleEstado());
				}
			}
		}
		catch (Exception e) {
			String mensaje = e.getMessage() == null ? " " : ", " + e.getMessage();
			r.setCodError("1");
			r.setMsgError("Ocurrió un error al validar series externas " + mensaje);
			logger.error(StackTraceUtl.getStackTrace(e));
		}
		try {
			logger.debug("Valida listas negras serie...");
			logger.debug("numSerie: " + numSerie);
			delegate.validaSerieLN(numSerie);
			logger.debug("...valida listas negras serie OK.");
		}
		catch (VentasException e) {
			logger.error(StackTraceUtl.getStackTrace(e));
			if (e.getCodigo().trim().equals("4")) {
				r.setCodError(e.getCodigo());
				String mensaje = global.getValor("mensaje.listas.negras.venta.serie");
				r.setMsgError(mensaje);
			}
		}
		logger.info("validaSerieExterna:fin()");
		return r;
	}
	
	//Inicio P-CSR-11002 JLGN 27-10-2011
	/*
	 * Carga la lista de Articulos
	 */
	public RetornoListaAjaxDTO obtenerArticulos(String codBodega) {
		logger.info("obtenerArticulos:inicio()");
		HttpSession sesion = WebContextFactory.get().getHttpServletRequest().getSession(false);
		RetornoListaAjaxDTO retorno = new RetornoListaAjaxDTO();
		if (!SessionHelper.validarSesion(sesion)) {
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;
		}
		ArticuloSeriesAjaxDTO[] arrayArticulosAjax = null;
		try {
			ArticuloInDTO articuloDTO = new ArticuloInDTO();

			articuloDTO.setCod_tecnologia((String)sesion.getAttribute("codTecnologiaSerie"));
			articuloDTO.setTipTerminal((String)sesion.getAttribute("tipTerminalSerie"));
			articuloDTO.setIndEquipo((String)sesion.getAttribute("indEquipoSerie"));
			articuloDTO.setCodUso(Integer.parseInt((String)sesion.getAttribute("codUsoSerie")));
			articuloDTO.setCodBodega(Long.parseLong(codBodega));
			logger.debug("codTecnologia=" + articuloDTO.getCod_tecnologia());
			logger.debug("tipTerminal=" + articuloDTO.getTipTerminal());
			logger.debug("indEquipo=" + articuloDTO.getIndEquipo());
			logger.debug("codUso=" + articuloDTO.getCodUso());
			logger.debug("codBodega=" + articuloDTO.getCodBodega());
			ArticuloInDTO[] arrayArticulos = delegate.getArticulos(articuloDTO);
			
			if (arrayArticulos != null) {
				arrayArticulosAjax = new ArticuloSeriesAjaxDTO[arrayArticulos.length];
				for (int i = 0; i < arrayArticulos.length; i++) {
					ArticuloSeriesAjaxDTO ajaxDTO = new ArticuloSeriesAjaxDTO();
					ajaxDTO.setCodigoArticulo(String.valueOf(arrayArticulos[i].getCodArticulo()));
					ajaxDTO.setDesArticulo(arrayArticulos[i].getDesArticulo());
					logger.debug("setCodigoArticulo: "+ ajaxDTO.getCodigoArticulo());
					logger.debug("setDesArticulo: "+ ajaxDTO.getDesArticulo());
					arrayArticulosAjax[i] = ajaxDTO;
				}
			}
		}
		catch (Exception e) {
			String mensaje = e.getMessage() == null ? " " : ", " + e.getMessage();
			retorno.setCodError("1");
			retorno.setMsgError("Ocurrió un error al obtener Articulos " + mensaje);
			logger.error(StackTraceUtl.getStackTrace(e));
		}
		logger.debug("largo arreglo: "+ arrayArticulosAjax.length);
		retorno.setLista(arrayArticulosAjax);
		logger.info("obtenerArticulos:fin()");
		return retorno;
	}
}
