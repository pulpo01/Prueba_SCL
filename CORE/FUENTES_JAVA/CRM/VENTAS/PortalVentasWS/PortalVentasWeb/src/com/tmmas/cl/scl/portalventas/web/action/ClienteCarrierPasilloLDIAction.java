/**
 * 
 */
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
import com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto.AltaCarrierPasilloLDIDTO;
import com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto.ResultadoAltaCarrierPasilloLDIDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.FormularioDireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ParametrosGlobalesDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.LstPTaPlanTarifarioInDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.LstPTaPlanTarifarioOutDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosGeneralesDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.VentasException;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.UsuarioSCLDTO;
import com.tmmas.cl.scl.portalventas.web.delegate.PortalVentasDelegate;
import com.tmmas.cl.scl.portalventas.web.dto.ResultadoSolicitudVentaDTO;
import com.tmmas.cl.scl.portalventas.web.form.ClienteCarrierPasilloLDIForm;
import com.tmmas.cl.scl.portalventas.web.helper.Global;

/**
 * @author mwn40031
 */
public class ClienteCarrierPasilloLDIAction extends DispatchAction {

	private final Logger logger = Logger.getLogger(ClienteCarrierPasilloLDIAction.class);

	private Global global = Global.getInstance();

	PortalVentasDelegate delegate = PortalVentasDelegate.getInstance();

	public ActionForward inicio(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("Inicio");
		String forward = "inicio";
		HttpSession sesion = request.getSession(false);
		ClienteCarrierPasilloLDIForm f = (ClienteCarrierPasilloLDIForm) form;
		if (f.getArrayTipoCliente() == null) {
			f.setArrayTipoCliente(global.obtenerArrayTipoClientePasilloLDI());
		}

		f.limpiar();

		ParametrosGlobalesDTO parametrosGlobalesDTO = (ParametrosGlobalesDTO) sesion.getAttribute("paramGlobal");
		String nomUsuarioOra = parametrosGlobalesDTO.getCodUsuario();

		ParametrosGeneralesDTO parametrosGeneralesDTO = new ParametrosGeneralesDTO();
		parametrosGeneralesDTO.setCodigoproducto(global.getValor("codigo.producto"));
		parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GE"));
		parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.largo_n_celular"));
		parametrosGeneralesDTO = delegate.getParametroGeneral(parametrosGeneralesDTO);

		String largoNumTelefonoExterno = parametrosGeneralesDTO.getValorparametro();

		f.setLargoNumTelefonoExterno(largoNumTelefonoExterno);

		UsuarioSCLDTO usuarioSCLDTO = new UsuarioSCLDTO();
		usuarioSCLDTO.setUsuario(nomUsuarioOra);
		usuarioSCLDTO = delegate.validaUsuarioSinPerfil(usuarioSCLDTO);

		if (usuarioSCLDTO != null && usuarioSCLDTO.getCodigoVendedor() != 0) {
			f.setCodVendedor(new Long(usuarioSCLDTO.getCodigoVendedor()).toString());
			f.setCodOficina(usuarioSCLDTO.getCodigoOficina());
			f.setCodTipComis(usuarioSCLDTO.getCodTipcomis());
		}
		else {
			String mensaje = global.getValor("modulo.web.pasillo.ldi.mensaje.no.existe.vendedor");
			f.setMensaje(mensaje);
		}

		LstPTaPlanTarifarioInDTO dtoEntrada = new LstPTaPlanTarifarioInDTO();
		dtoEntrada.setTipoProducto(global.getValor("cod_uso.carrier"));
		dtoEntrada.setTipoPlan(global.getValor("tipo.plan.individual"));
		dtoEntrada.setCodTipPrestacion(global.getValor("cod_prestacion.carrier"));
		dtoEntrada.setClaPlanTarif(null); // Filtro no aplica
		dtoEntrada.setIndRenovacion(Integer.parseInt("0")); // Renovacion no aplica

		if (f.getArrayPlanTarifario() == null) {
			LstPTaPlanTarifarioOutDTO[] arrayPlanTarifario = delegate.lstPlanTarif(dtoEntrada)
					.getallLstPTaPlanTarifarioOutDTO();
			f.setArrayPlanTarifario(arrayPlanTarifario);
		}

		logger.info("Fin");
		return mapping.findForward(forward);
	}

	public ActionForward enviar(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("Inicio");
		ActionForward toReturn = null;
		HttpSession sesion = request.getSession(false);
		ParametrosGlobalesDTO parametrosGlobalesDTO = (ParametrosGlobalesDTO) sesion.getAttribute("paramGlobal");
		String nomUsuarioOra = parametrosGlobalesDTO.getCodUsuario();
		String codOperadora = parametrosGlobalesDTO.getCodOperadora();

		ClienteCarrierPasilloLDIForm f = (ClienteCarrierPasilloLDIForm) form;
		AltaCarrierPasilloLDIDTO dto = f.getAltaCarrierPasilloLDIDTO();

		dto.setNomUsuarioOra(nomUsuarioOra);
		dto.setCodOperadora(codOperadora);

		dto.setCodCelda(global.getValorExterno("modulo.web.pasillo.ldi.linea.por.defecto.cod_celda"));
		dto.setCodCentral(global.getValorExterno("modulo.web.pasillo.ldi.linea.por.defecto.cod_central"));

		FormularioDireccionDTO formularioDireccionDTO = f.getFormularioDireccionDTO();

		if (formularioDireccionDTO != null) {
			dto.setCodRegion(formularioDireccionDTO.getCOD_REGION());
			dto.setCodProvincia(formularioDireccionDTO.getCOD_PROVINCIA());
			dto.setCodCiudad(formularioDireccionDTO.getCOD_CIUDAD());
			dto.setCodComuna(formularioDireccionDTO.getCOD_COMUNA());
			dto.setCodZIP(formularioDireccionDTO.getZIP());
			dto.setCodTipoCalle(formularioDireccionDTO.getCOD_TIPOCALLE());
			dto.setDesDireccion1(formularioDireccionDTO.getDES_DIREC1());
			dto.setNomCalle(formularioDireccionDTO.getNOM_CALLE());
			dto.setNumCalle(formularioDireccionDTO.getNUM_CALLE());
			dto.setObsDireccion(formularioDireccionDTO.getOBS_DIRECCION());
			dto.setDesDireccion2(formularioDireccionDTO.getDES_DIREC2());
			logger.trace("formularioDireccionDTO.getDES_DIREC2() [" + formularioDireccionDTO.getDES_DIREC2() + "]");
		}
		logger.debug(dto.toString());

		ResultadoSolicitudVentaDTO resultadoSolVenta = new ResultadoSolicitudVentaDTO();
		try {
			ResultadoAltaCarrierPasilloLDIDTO alta = delegate.altaCarrierPasilloLDI(dto);
			resultadoSolVenta.setCodCliente(alta.getCodCliente());
			resultadoSolVenta.setNumeroVenta(alta.getNumVenta());
			f.limpiar();
			sesion.setAttribute("resultadoSolVenta", resultadoSolVenta);
			toReturn = mapping.findForward("mostrarResultado");
		}
		catch (VentasException e) {
			logger.trace(e.getCodigo());
			if (e.getCodigo().equals("1")) {
				final String mensajeErrorCiclo = "Ocurrió un error al obtener el ciclo de facturación";
				f.setMensajeError(mensajeErrorCiclo);
				logger.error(mensajeErrorCiclo);
			}
			else {
				final String mensajeErrorLDI = "No se pudo realizar el alta";
				f.setMensajeError(mensajeErrorLDI);
				logger.error(mensajeErrorLDI);
			}
			logger.error(StackTraceUtl.getStackTrace(e));
			toReturn = mapping.findForward("inicio");
		}
		logger.info("Fin");
		return toReturn;
	}

	public ActionForward ingresarDireccionFacturacion(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("Inicio");
		String forward = "ingresarDireccionFacturacion";
		logger.debug("Fin");
		return mapping.findForward(forward);
	}

	public ActionForward irAMenu(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.debug("Inicio");
		String forward = "irAMenu";
		logger.debug("Fin");
		return mapping.findForward(forward);
	}

	public ActionForward cancelarDireccion(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("Inicio");
		String forward = "inicio";
		logger.info("Fin");
		return mapping.findForward(forward);
	}

	public ActionForward cargarDireccion(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("Inicio");
		String forward = "inicio";
		ClienteCarrierPasilloLDIForm f = (ClienteCarrierPasilloLDIForm) form;
		HttpSession sesion = request.getSession(false);
		if (sesion.getAttribute("FormularioDireccionDTO") != null) {
			FormularioDireccionDTO formularioDireccionDTO = (FormularioDireccionDTO) ((FormularioDireccionDTO) sesion
					.getAttribute("FormularioDireccionDTO")).clone();
			f.setFormularioDireccionDTO(formularioDireccionDTO);
			f.setDireccionFacturacion(formularioDireccionDTO.obtenerDireccionAMostrar());
			logger.debug(formularioDireccionDTO.getCOD_CIUDAD());
		}
		logger.info("Fin");
		return mapping.findForward(forward);
	}
}
