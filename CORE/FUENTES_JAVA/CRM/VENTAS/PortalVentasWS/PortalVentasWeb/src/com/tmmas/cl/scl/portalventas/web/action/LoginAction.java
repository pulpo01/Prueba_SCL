package com.tmmas.cl.scl.portalventas.web.action;

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
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.scl.commonbusinessentities.dto.ParametrosGlobalesDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.MenuUsuarioSCLDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.UsuarioSCLDTO;
import com.tmmas.cl.scl.portalventas.web.delegate.PortalVentasDelegate;
import com.tmmas.cl.scl.portalventas.web.dto.MenuInicioDTO;
import com.tmmas.cl.scl.portalventas.web.form.LoginActionForm;
import com.tmmas.cl.scl.portalventas.web.helper.ConnectionHelper;
import com.tmmas.cl.scl.portalventas.web.helper.Global;
import com.tmmas.cl.scl.portalventas.web.helper.Utilidades;

//public class LoginAction extends Action {
public class LoginAction extends DispatchAction{

	private static final String NOMBRE_LOCALE_SESION = "Locale-PortalVentas";

	private final Logger logger = Logger.getLogger(LoginAction.class);

	Locale locale = new Locale("es", "GT"); // Por defecto

	private Global global = Global.getInstance();

	PortalVentasDelegate delegate = PortalVentasDelegate.getInstance();

	public LoginAction() {
		UtilLog.setLog(global.getValorExterno("PortalVentasWeb.log"));
	}

	public ActionForward executeLogin(ActionMapping mapping, ActionForm actionForm, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("executeLogin():executeLogin JLGN");

		String usuario = ((LoginActionForm) actionForm).getUsuario();
		String clave = ((LoginActionForm) actionForm).getClave();

		if (usuario == null || usuario.trim().equals("")) {
			request.setAttribute("mensajeErrorLogin", "Debe ingresar Usuario");
			return mapping.findForward("failure");
		}

		if (clave == null || clave.trim().equals("")) {
			request.setAttribute("mensajeErrorLogin", "Debe ingresar Clave");
			return mapping.findForward("failure");
		}

		HttpSession session = request.getSession(false);
		if (session != null) {
			logger.debug("Session existente en pagina de login");
			logger.debug("Invalidando session existente");
			session.removeAttribute("paramGlobal");
			session.invalidate();
		}

		logger.debug("Creando session...");
		session = request.getSession(true);

		session.setAttribute("paramGlobal", new ParametrosGlobalesDTO());
		
		//Inicio P-CSR-11002 JLGN 04-04-2011
		String nomOperadora = global.getValorExterno("modulo.web.operadora");
		session.setAttribute("nomOperador", nomOperadora);
		session.setAttribute("nombreUsuarioSCL", usuario);
		//Fin P-CSR-11002 JLGN 04-04-2011
		
		final boolean conexionValida = ConnectionHelper.validaConexionUsuario(usuario, clave);
		if (!conexionValida) {
			request.setAttribute("mensajeErrorLogin", "Usuario Inválido");
			return mapping.findForward("failure");
		}

		String codOperadora = delegate.getCodigoOperadora();
		ParametrosGlobalesDTO param = new ParametrosGlobalesDTO();
		param.setCodUsuario(usuario);
		param.setCodOperadora(codOperadora);
		param.setVersionSistema("1.0");

		String tipoEjecucion = "0";
		try {
			tipoEjecucion = global.getValorExterno("tipo.ejecucion");
			if (tipoEjecucion == null)
				tipoEjecucion = "0";
			logger.debug("tipoEjecucion=" + tipoEjecucion);
		}
		catch (Exception e) {
		}
		param.setTipoEjecucion(tipoEjecucion);

		// NIT
		String formatoNIT = "";
		final boolean enGuatemala = codOperadora.equals(global.getValor("codigo.operadora.guatemala"));
		final boolean enElSalvador = codOperadora.equals(global.getValor("codigo.operadora.salvador"));
		if (enGuatemala) {
			formatoNIT = global.getValorExterno("formato.nit.operadora.TMG");
			locale = new Locale("es", "GT");
		}
		else if (enElSalvador) {
			formatoNIT = global.getValorExterno("formato.nit.operadora.TMS");
			locale = new Locale("es", "SV");
		}

		param.setFormatoNIT(formatoNIT);
		param.setCodigoIdentificadorNIT(global.getValor("codigo.identificador.NIT"));

		session.removeAttribute("paramGlobal");
		session.setAttribute("paramGlobal", param);

		session.removeAttribute(NOMBRE_LOCALE_SESION);
		session.setAttribute(NOMBRE_LOCALE_SESION, locale);

		// obtener menues asociados al usuario
		MenuUsuarioSCLDTO[] listaMenus;
		UsuarioSCLDTO usuarioSCL = new UsuarioSCLDTO();
		final String codPrograma = global.getValor("programa.codigo");
		logger.debug("codPrograma [" + codPrograma + "]");
		final String numVersion = global.getValor("programa.version.externa");
		logger.debug("numVersion [" + numVersion + "]");
		usuarioSCL.setCodigoPrograma(codPrograma);
		usuarioSCL.setNumVersion(Long.parseLong(numVersion));
		usuarioSCL.setNombreUsuario(usuario);
		usuarioSCL = delegate.getMenuUsuario(usuarioSCL);

		listaMenus = usuarioSCL.getArrayMenuUsuario();
		if (listaMenus == null) {
			listaMenus = new MenuUsuarioSCLDTO[0];
		}

		// Cargar arreglos con grupos
		MenuInicioDTO menuInicioDTO = new MenuInicioDTO();
		menuInicioDTO.setTotalMenusActivosUsuario(listaMenus.length);

		final String codProducto = global.getValor("codigo.producto");
		final String codModuloGA = global.getValor("codigo.modulo.GA");
		final String codModuloGE = global.getValor("codigo.modulo.GE");

		// Funcionalidad Override TMG y TMS
		boolean permiteOverride = false;
		permiteOverride = delegate.consultarParametro(codProducto, codModuloGE, global
				.getValor("parametro.permite.override"));
		logger.info("permiteOverride: " + permiteOverride);

		// Funcionalidad Scoring. Solo TMG
		boolean permiteScoring = false;
		if (enGuatemala) {
			permiteScoring = delegate.consultarParametro(codProducto, codModuloGA, global
					.getValor("parametro.permite.scoring"));
		}
		logger.info("permiteScoring: " + permiteScoring);
		final String valorFormularioOverride = global.getValor("valor.formulario.override").trim();
		final String valorFormularioScoring = global.getFormularioGestionScoring();
		final String valorFormularioReporteScoring = global.getFormularioReporteScoring();
		logger.debug("valorFormularioOverride [" + valorFormularioOverride + "]");
		logger.debug("valorFormularioScoring [" + valorFormularioScoring + "]");
		logger.debug("valorFormularioReporteScoring [" + valorFormularioReporteScoring + "]");

		// carga grupo venta
		ArrayList arrayMenus = new ArrayList();
		for (int i = 0; i < listaMenus.length; i++) {
			String formulario = listaMenus[i].getFormulario();
			logger.debug("formulario [" + formulario + "]");
			if (!Utilidades.emptyOrNull(formulario)) {
				if (formulario.equals(valorFormularioOverride)) {
					if (permiteOverride) {
						if (enGuatemala) {
							logger.debug("TMG - No incluye override en Menú");
						}
						if (enElSalvador) {
							logger.debug("TMS - Incluye override en Menú");
							arrayMenus.add(formulario);
						}
					}
				}
				else if (formulario.equals(valorFormularioScoring)) {
					if (permiteScoring) {
						arrayMenus.add(formulario);
						session.setAttribute("habilitarScoring", Boolean.TRUE);
					}
					else {
						session.setAttribute("habilitarScoring", Boolean.FALSE);
					}
				}
				else if (formulario.equals(valorFormularioReporteScoring)) {
					if (permiteScoring) {
						arrayMenus.add(formulario);
					}
				}
				else {
					arrayMenus.add(formulario);
				}
			}
		}

		menuInicioDTO.setTotalAreaVentas(arrayMenus.size());
		menuInicioDTO.setListaAreaVentas((String[]) ArrayUtl.copiaArregloTipoEspecifico(arrayMenus.toArray(),
				String.class));

		menuInicioDTO.setTotalAreaCredito(arrayMenus.size());
		menuInicioDTO.setListaAreaCredito((String[]) ArrayUtl.copiaArregloTipoEspecifico(arrayMenus.toArray(),
				String.class));

		menuInicioDTO.setTotalAreaActivaciones(arrayMenus.size());
		menuInicioDTO.setListaAreaActivaciones((String[]) ArrayUtl.copiaArregloTipoEspecifico(arrayMenus.toArray(),
				String.class));

		menuInicioDTO.setTotalAreaLDI(arrayMenus.size());
		menuInicioDTO.setListaAreaLDI((String[]) ArrayUtl
				.copiaArregloTipoEspecifico(arrayMenus.toArray(), String.class));

		menuInicioDTO.setTotalAreaInstalacion(arrayMenus.size());
		menuInicioDTO.setListaAreaInstalacion((String[]) ArrayUtl.copiaArregloTipoEspecifico(arrayMenus.toArray(),
				String.class));

		/*
		 * // carga grupo credito arrayMenus = new ArrayList(); for (int i = 0; i < listaMenus.length; i++) { if
		 * (listaMenus[i].getGrupo().equals(global.getValor("grupo.menu.credito"))) {
		 * arrayMenus.add(listaMenus[i].getFormulario()); } } menuInicioDTO.setTotalAreaCredito(arrayMenus.size());
		 * menuInicioDTO.setListaAreaCredito((String[]) ArrayUtl.copiaArregloTipoEspecifico(arrayMenus.toArray(),
		 * String.class)); // carga grupo activaciones arrayMenus = new ArrayList(); for (int i = 0; i <
		 * listaMenus.length; i++) { if (listaMenus[i].getGrupo().equals(global.getValor("grupo.menu.activaciones"))) {
		 * arrayMenus.add(listaMenus[i].getFormulario()); } } menuInicioDTO.setTotalAreaActivaciones(arrayMenus.size());
		 * menuInicioDTO.setListaAreaActivaciones((String[]) ArrayUtl.copiaArregloTipoEspecifico(arrayMenus.toArray(),
		 * String.class)); // carga grupo instalacion arrayMenus = new ArrayList(); for (int i = 0; i <
		 * listaMenus.length; i++) { if (listaMenus[i].getGrupo().equals(global.getValor("grupo.menu.instalacion"))) {
		 * arrayMenus.add(listaMenus[i].getFormulario()); } } menuInicioDTO.setTotalAreaInstalacion(arrayMenus.size());
		 * menuInicioDTO.setListaAreaInstalacion((String[]) ArrayUtl.copiaArregloTipoEspecifico(arrayMenus.toArray(),
		 * String.class)); // carga grupo LDI arrayMenus = new ArrayList(); for (int i = 0; i < listaMenus.length; i++) {
		 * if (listaMenus[i].getGrupo().equals(global.getValor("grupo.menu.ldi"))) {
		 * arrayMenus.add(listaMenus[i].getFormulario()); } } menuInicioDTO.setTotalAreaLDI(arrayMenus.size());
		 * menuInicioDTO.setListaAreaLDI((String[]) ArrayUtl .copiaArregloTipoEspecifico(arrayMenus.toArray(),
		 * String.class));
		 */

		session.removeAttribute("menuInicioDTO");
		session.setAttribute("menuInicioDTO", menuInicioDTO);

		logger.info("execute():fin");
		return mapping.findForward("success");
	}
	
	//Inicio P-CSR-11002 JLGN 09-05-2011
	public ActionForward inicioLogin(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		logger.info("inicioLoginAction, inicio");
		LoginActionForm actionForm = (LoginActionForm)form;		
		
		String nomOperador = global.getValorExterno("modulo.web.operadora");
		logger.info("nombre operador: "+ nomOperador);
		request.getSession().setAttribute("nomOperador", nomOperador);	
		
		actionForm.setFlagInicio("true");		
		logger.info("inicioLogin, fin");				
		return mapping.findForward("inicioLogin");
	}
	//Fin Inicio P-CSR-11002 JLGN 09-05-2011

}