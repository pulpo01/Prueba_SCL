package com.tmmas.scl.operations.crm.fab.cusintman.web.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.tmmas.scl.framework.ProductDomain.dto.DatosCentralDTO;
import com.tmmas.scl.framework.ProductDomain.dto.DatosNumeracionDTO;
import com.tmmas.scl.framework.ProductDomain.dto.NumeracionCelularDTO;
import com.tmmas.scl.framework.ProductDomain.dto.NumeroRangoAjaxDTO;
import com.tmmas.scl.framework.ProductDomain.dto.ParametrosGeneralesDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SeleccionNumeroCelularDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.UsuarioSistemaDTO;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.fab.cusintman.web.delegate.ServiciosSuplementariosBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cusintman.web.form.BuscaNumeroForm;
import com.tmmas.scl.operations.crm.fab.cusintman.web.helper.Global;
import com.tmmas.scl.operations.crm.fab.customerinterfacemanagement.common.exception.CusIntManException;
import com.tmmas.scl.operation.crm.fab.cusintman.servsup.common.dataTransfertObject.NumeroAjaxDTO;
import com.tmmas.scl.operation.crm.fab.cusintman.servsup.common.dataTransfertObject.RetornoValorDTO;
import com.tmmas.scl.framework.ProductDomain.dao.DatosGeneralesDAO;
import com.tmmas.scl.vendedor.dto.VendedorDTO;

public class BuscaNumeroAction extends DispatchAction {
	
	private final Logger logger = Logger.getLogger(BuscaNumeroAction.class);
	private Global global = Global.getInstance();
	private ServiciosSuplementariosBussinessDelegate delegate = ServiciosSuplementariosBussinessDelegate.getInstance();
	
	public ActionForward inicio(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		logger.info("inicio, inicio");
		
		HttpSession session= request.getSession(false);
		
		BuscaNumeroForm  buscaNumeroForm = (BuscaNumeroForm)form;
		
		// -- carga parametros ----------------------------------------------------------------------------------------------------
		try	{
			ParametrosGeneralesDTO parametrosTamPrefijo = new ParametrosGeneralesDTO();
			ParametrosGeneralesDTO parametrosLargoCelular = new ParametrosGeneralesDTO();
			
			if (session.getAttribute("parametrosTamPrefijo")==null){
				parametrosTamPrefijo.setCodigoproducto(global.getValor("codigo.producto"));
				parametrosTamPrefijo.setCodigomodulo(global.getValor("codigo.modulo.GA"));
				parametrosTamPrefijo.setNombreparametro(global.getValor("parametro.tam_prefijo"));
				parametrosTamPrefijo = delegate.getParametroGeneral(parametrosTamPrefijo);
				session.setAttribute("largoPrefijo", parametrosTamPrefijo.getValorparametro());
				buscaNumeroForm.setLargoPrefijo(parametrosTamPrefijo.getValorparametro());
			} // if
	
			if (session.getAttribute("parametrosLargoCelular")==null){
				parametrosLargoCelular.setCodigoproducto(global.getValor("codigo.producto"));
				parametrosLargoCelular.setCodigomodulo(global.getValor("codigo.modulo.GE"));
				parametrosLargoCelular.setNombreparametro(global.getValor("parametro.largo_n_celular"));
				parametrosLargoCelular = delegate.getParametroGeneral(parametrosLargoCelular);
				session.setAttribute("largoNumCelular", parametrosLargoCelular.getValorparametro());
				buscaNumeroForm.setLargoNumCelular(parametrosLargoCelular.getValorparametro());
			} // if
		}
		catch (CusIntManException ex)	{
			String mens = "Error " + ex.getCodigo() + "\n" + ex.getDescripcionEvento();
    		String stack = "No se encuentra disponible.";

    		delegate.guardaMensajesError(request, mens, stack);
    		return mapping.findForward("error");
		}
			
		// --------------------------------------------------------------------------------------------------------------------
		
		if (buscaNumeroForm.getNumeroAnteriorRes()== null) buscaNumeroForm.setNumeroAnteriorRes("");

		ClienteOSSesionDTO sessionData = new ClienteOSSesionDTO();
		sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");
		
		//(+)Actualiza numero ya ingresado
		if (session.getAttribute("numeroSel")!=null){
			buscaNumeroForm.setNumeroSel(((NumeroAjaxDTO)session.getAttribute("numeroSel")).getNumCelular());
		}else{
			buscaNumeroForm.setNumeroSel("");
			buscaNumeroForm.setNumeroAnteriorRes("");
		}
		//(-)
		
		buscaNumeroForm.setTablaNumeracionAut("");
		buscaNumeroForm.setCategoria("");
		
		if (session.getAttribute("clienteSel")!=null){
			String nombreCliente = (sessionData.getCliente().getNombres()!=null?sessionData.getCliente().getNombres():"") + " " ;
			nombreCliente = nombreCliente + (sessionData.getCliente().getApellido1()!=null?sessionData.getCliente().getApellido1():"") + " ";
			nombreCliente = nombreCliente + (sessionData.getCliente().getApellido2()!=null?sessionData.getCliente().getApellido2():"") + " ";
			buscaNumeroForm.setNombreCliente(nombreCliente);
		}
		
		logger.info("inicio, fin");
		
		return mapping.findForward("inicio");
	}

	// ------------------------------------------------------------------------------------------------------------------------
	
	public ActionForward validarAnularReservaNumAut(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		logger.info("validarAnularReservaNumAut, inicio");
		HttpSession session= request.getSession(false);
		BuscaNumeroForm  buscaNumeroForm= (BuscaNumeroForm)form;
		ClienteOSSesionDTO sessionData = new ClienteOSSesionDTO();
		sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");		
	
		try{
			delegate.reponerNumeracion(	buscaNumeroForm.getRdNumeroSel(), 
										buscaNumeroForm.getTablaNumeracionAut(), 
										buscaNumeroForm.getCategoria(),
										global.getValor("parametro.uso.fax"),
										String.valueOf(sessionData.getAbonados()[0].getCodCentral()));
		}
		catch(Exception e) {
    		String mens = "Error " + e.getMessage();
    		String stack = "No se encuentra disponible";

    		delegate.guardaMensajesError(request, mens, stack);
    		return mapping.findForward("error");
		}			
			
		
		//limpia variable
		buscaNumeroForm.setTablaNumeracionAut("");
		buscaNumeroForm.setCategoria("");
		buscaNumeroForm.setFechaBaja("");
		buscaNumeroForm.setLargoPrefijo((String)session.getAttribute("largoPrefijo"));
		buscaNumeroForm.setLargoNumCelular((String)session.getAttribute("largoNumCelular")); 		
		
		logger.info("validarAnularReservaNumAut, fin");
		
		return mapping.findForward("inicio");
		
	} // validarAnularReservaNumAut

	// ------------------------------------------------------------------------------------------------------------------------

	public ActionForward obtenerNumeracionReservada(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		logger.info("obtenerNumeracionReservada, inicio");
		BuscaNumeroForm  buscaNumeroForm= (BuscaNumeroForm)form;
		
		HttpSession session= request.getSession(false);		
		ClienteOSSesionDTO sessionData = new ClienteOSSesionDTO();
		sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");		
		com.tmmas.scl.vendedor.dto.VendedorDTO vendedor = (com.tmmas.scl.vendedor.dto.VendedorDTO) session.getAttribute("Vendedor");
		UsuarioSistemaDTO usuarioSistema = (UsuarioSistemaDTO)session.getAttribute("usuarioSistema");		
		
		try{
			String cantMaxCel = String.valueOf(session.getAttribute("cantidad.maxima.celulares"));
			NumeroAjaxDTO[] listaNumeros= null;
			
			listaNumeros = delegate.obtenerNumeracionReservada(	vendedor, 
																sessionData,
																global.getValor("parametro.uso.fax"),
																String.valueOf(sessionData.getAbonados()[0].getCodCentral()),
																cantMaxCel,
																usuarioSistema);
			session.setAttribute("listaNumeros", listaNumeros);			
		}
		catch(Exception e) {
    		String mens = "Error " + e.getMessage();
    		String stack = "No se encuentra disponible";

    		delegate.guardaMensajesError(request, mens, stack);
    		return mapping.findForward("error");
		}			
			
		
		//limpia variable
		buscaNumeroForm.setTablaNumeracionAut("");
		buscaNumeroForm.setCategoria("");
		buscaNumeroForm.setFechaBaja("");
		buscaNumeroForm.setLargoPrefijo((String)session.getAttribute("largoPrefijo"));
		buscaNumeroForm.setLargoNumCelular((String)session.getAttribute("largoNumCelular")); 		
		
		logger.info("obtenerNumeracionReservada, fin");
		
		return mapping.findForward("inicio");
		
	} // obtenerNumeracionReservada

	// ------------------------------------------------------------------------------------------------------------------------

	public ActionForward aceptar(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		logger.info("aceptar, inicio");
	
		try{
			HttpSession session= request.getSession(false);
			ClienteOSSesionDTO sessionData = new ClienteOSSesionDTO();
			sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");	
			BuscaNumeroForm  buscaNumeroForm= (BuscaNumeroForm)form;
			NumeroAjaxDTO[] listaNumeros = new NumeroAjaxDTO[1];
			
			
			NumeroAjaxDTO numeroSel = delegate.aceptaNumeracion(session,
															sessionData, 
															buscaNumeroForm, 
															global.getValor("parametro.uso.fax"),
															String.valueOf(sessionData.getAbonados()[0].getCodCentral()));
			
			//actualiza variable
			buscaNumeroForm.setNumeroAnteriorRes(numeroSel.getNumCelular());
			listaNumeros[0] = numeroSel;
			
			session.setAttribute("listaNumeros", numeroSel);
			session.setAttribute("numeroSel", numeroSel);
			session.removeAttribute("listaNumerosRango");			
		}
		catch(Exception e) {
    		String mens = "Error " + e.getMessage();
    		String stack = "No se encuentra disponible";

    		delegate.guardaMensajesError(request, mens, stack);
    		return mapping.findForward("error");
		}			
		
		logger.info("aceptar, fin");
		
		return mapping.findForward("cerrar");
		
	} // aceptar

	// ------------------------------------------------------------------------------------------------------------------------	

	public ActionForward cancelar(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		logger.info("cancelar, inicio");
	
		HttpSession session= request.getSession(false);
		
		session.removeAttribute("numeroSel");
		session.removeAttribute("listaNumeros");
		session.removeAttribute("listaNumerosRango");
			
		
		logger.info("cancelar, fin");
		
		return mapping.findForward("cerrar");
		
	} // cancelar

	// ------------------------------------------------------------------------------------------------------------------------	

	public ActionForward cerrar(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		logger.info("cerrar, inicio");
		logger.info("cerrar, fin");
		
		return mapping.findForward("cerrar");
		
	} // cerrar

	// ------------------------------------------------------------------------------------------------------------------------	

	public ActionForward obtenerNumeracionAutomatica(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		logger.info("obtenerNumeracionAutomatica, inicio");
	
		HttpSession session= request.getSession(false);
		BuscaNumeroForm  buscaNumeroForm= (BuscaNumeroForm)form;
		ClienteOSSesionDTO sessionData = new ClienteOSSesionDTO();
		sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");		
	
		try{
			// Si ya se busco por numeracion automatica, se debe reponer numero anterior
			if (buscaNumeroForm.getRdNumeroSel() != null)	{
				delegate.reponerNumeracion(	buscaNumeroForm.getRdNumeroSel(), 
											buscaNumeroForm.getTablaNumeracionAut(), 
											buscaNumeroForm.getCategoria(),
											global.getValor("parametro.uso.fax"),
											String.valueOf(sessionData.getAbonados()[0].getCodCentral()));
			} // if
			
			NumeroAjaxDTO[] listaRetorno = delegate.obtieneNumeracionAutomatica(sessionData, global.getValor("parametro.uso.fax"), String.valueOf(sessionData.getAbonados()[0].getCodCentral()));
			
			/*
			document.getElementById("tablaNumeracionAut").value = data['tablaNumeracion'];
	        document.getElementById("categoria").value = data['categoria'];	        
	        document.getElementById("numeroSel").value = data['numero'];      
	        document.getElementById("fechaBaja").value = data['fechaBaja'];	       
			 */
			
			NumeroAjaxDTO numeroSel = new NumeroAjaxDTO();
			numeroSel.setNumCelular(listaRetorno[0].getNumCelular());
			session.setAttribute("numeroSel", numeroSel);
			
			session.setAttribute("listaNumeros", listaRetorno);
			session.removeAttribute("listaNumerosRango");	
			
		}
		catch(Exception e) {
    		String mens = "Error " + e.getMessage();
    		String stack = "No se encuentra disponible";

    		delegate.guardaMensajesError(request, mens, stack);
    		return mapping.findForward("error");
		}			
			
		
		logger.info("obtenerNumeracionAutomatica, fin");
		
		return mapping.findForward("cerrar");
		
	} // obtenerNumeracionAutomatica

	// ------------------------------------------------------------------------------------------------------------------------	

	public ActionForward obtenerNumeracionReutilizable(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		logger.info("obtenerNumeracionReutilizable, inicio");
	
		HttpSession session= request.getSession(false);
		BuscaNumeroForm  buscaNumeroForm= (BuscaNumeroForm)form;
		ClienteOSSesionDTO sessionData = new ClienteOSSesionDTO();
		sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");		
	
		
		try{
			String cantMaxCel = String.valueOf(session.getAttribute("cantidad.maxima.celulares"));
			NumeroAjaxDTO[] listaRetorno = delegate.obtenerNumeracionReutilizable(	buscaNumeroForm,
																					sessionData, 
																					global.getValor("parametro.uso.fax"), 
																					String.valueOf(sessionData.getAbonados()[0].getCodCentral()),
																					cantMaxCel);
			session.setAttribute("listaNumeros", listaRetorno);
			session.removeAttribute("listaNumerosRango");				
		}
		catch(Exception e) {
    		String mens = "Error " + e.getMessage();
    		String stack = "No se encuentra disponible";

    		delegate.guardaMensajesError(request, mens, stack);
    		return mapping.findForward("error");
		}			
			
		
		logger.info("obtenerNumeracionReutilizable, fin");
		
		return mapping.findForward("inicio");
		
	} // obtenerNumeracionReutilizable

	// ------------------------------------------------------------------------------------------------------------------------
	
	public ActionForward obtenerNumeracionRango(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		logger.info("obtenerNumeracionRango, inicio");
	
		HttpSession session= request.getSession(false);
		BuscaNumeroForm  buscaNumeroForm= (BuscaNumeroForm)form;
		ClienteOSSesionDTO sessionData = new ClienteOSSesionDTO();
		sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");		
	
		
		try{
			String cantMaxCel = String.valueOf(session.getAttribute("cantidad.maxima.celulares"));
			NumeroRangoAjaxDTO[] listaRetorno = delegate.obtenerNumeracionRango(	buscaNumeroForm,
																					sessionData, 
																					global.getValor("parametro.uso.fax"), 
																					String.valueOf(sessionData.getAbonados()[0].getCodCentral()),
																					cantMaxCel);
			session.setAttribute("listaNumerosRango", listaRetorno);
			session.removeAttribute("listaNumeros");
		}
		catch(Exception e) {
    		String mens = "Error " + e.getMessage();
    		String stack = "No se encuentra disponible";

    		delegate.guardaMensajesError(request, mens, stack);
    		return mapping.findForward("error");
		}			
			
		
		logger.info("obtenerNumeracionRango, fin");
		
		return mapping.findForward("inicio");
		
	} // obtenerNumeracionRango

	// ------------------------------------------------------------------------------------------------------------------------		


}
