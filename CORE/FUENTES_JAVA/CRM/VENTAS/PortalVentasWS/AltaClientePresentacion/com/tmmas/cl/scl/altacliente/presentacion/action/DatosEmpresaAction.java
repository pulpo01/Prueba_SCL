package com.tmmas.cl.scl.altacliente.presentacion.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.tmmas.cl.scl.altacliente.presentacion.delegate.AltaClienteDelegate;
import com.tmmas.cl.scl.altacliente.presentacion.form.DatosEmpresaForm;
import com.tmmas.cl.scl.altacliente.presentacion.helper.Global;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.DatosClienteBuroDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.IdentificadorCivilComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.TipoNombramientoDTO;

public class DatosEmpresaAction extends DispatchAction {
	private final Logger logger = Logger.getLogger(DatosEmpresaAction.class);

	private Global global = Global.getInstance();

	AltaClienteDelegate delegate = AltaClienteDelegate.getInstance();

	final private static String CLAVE_REP_LEGAL_MAND = "modulo.web.alta.cliente.datos.rep_legal.mandatorio";

	public ActionForward inicio(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("DatosEmpresaAction, inicio");

		DatosEmpresaForm f = (DatosEmpresaForm) form;
		DatosEmpresaForm datosEmpresaFormInicio = new DatosEmpresaForm();
		HttpSession sesion = request.getSession(false);
		//Inicio P-CSR-11002 JLGN 18-07-2011
		//Se limpian datos
		datosEmpresaFormInicio.setNombreEmpresa("");
		f.setNombreEmpresa("");
		datosEmpresaFormInicio.setRazonSocial("");							
		f.setRazonSocial("");
		
		//Fin P-CSR-11002 JLGN 18-07-2011
		
		//Inicio P-CSR-11002 JLGN 09-05-2011
		DatosClienteBuroDTO buroDTO = (DatosClienteBuroDTO)sesion.getAttribute("datosClienteBuro");
		//Fin P-CSR-11002 JLGN 09-05-2011

		// Tipo identificacion
		if (f.getArrayIdentificadorCliente() == null) {
			IdentificadorCivilComDTO[] arrayIdentificadores = delegate.getTipoIdentificadoresCiviles();
			f.setArrayIdentificadorCliente(arrayIdentificadores);
		}

		// guarda formulario inicial
		datosEmpresaFormInicio.setNombreEmpresa(f.getNombreEmpresa());
		datosEmpresaFormInicio.setNombreRepLegal(f.getNombreRepLegal());
		datosEmpresaFormInicio.setNumeroIdentificacionRepLegal(f.getNumeroIdentificacionRepLegal());
		datosEmpresaFormInicio.setPatenteComercio(f.getPatenteComercio());
		datosEmpresaFormInicio.setRazonSocial(f.getRazonSocial());
		datosEmpresaFormInicio.setTipoIdentificacionRepLegal(f.getTipoIdentificacionRepLegal());

		String conf = global.getValorExterno(CLAVE_REP_LEGAL_MAND);
		logger.debug("datosRepLegalMandatorio [" + conf + "]");
		f.setDatosRepLegalMandatorio(conf != null && !conf.equals("") ? conf : "SI"); //Valor por defecto SI
		datosEmpresaFormInicio.setDatosRepLegalMandatorio(f.getDatosRepLegalMandatorio());
		
		if (buroDTO != null ){
			logger.debug("Buro no es mulo");
			logger.debug("Nombre Empresa: "+buroDTO.getNombre());
			datosEmpresaFormInicio.setNombreEmpresa(buroDTO.getNombre());
			f.setNombreEmpresa(buroDTO.getNombre());
			logger.debug("Razon Social: "+buroDTO.getRazonSocial());
			datosEmpresaFormInicio.setRazonSocial(buroDTO.getRazonSocial());							
			f.setRazonSocial(buroDTO.getRazonSocial());
			//Inicio P-CSR-11002 JLGN 01-08-2011
			TipoNombramientoDTO tipoNombramientoDTO [] = null;
			tipoNombramientoDTO = buroDTO.getTipoNombramientoDTO();
			logger.debug("Numero de nombramientos: "+ tipoNombramientoDTO.length);
			for(int x = 0; x < tipoNombramientoDTO.length;x++){
				if(tipoNombramientoDTO[x].getTipNombramiento().toUpperCase().trim().equals("PRESIDENTE")){
					logger.debug("Es Presidente");
					String nombreRepLegal = tipoNombramientoDTO[x].getNombreNombramiento()+" "+tipoNombramientoDTO[x].getApellido1Nombramiento()+" "+tipoNombramientoDTO[x].getApellido2Nombramiento();
					logger.debug("Nombre Presidente: "+ nombreRepLegal);	
					datosEmpresaFormInicio.setNombreRepLegal(nombreRepLegal);
					f.setNombreRepLegal(nombreRepLegal);
					String numeroIdentificacionRepLegal = tipoNombramientoDTO[x].getNumidentNombramiento(); 
					logger.debug("Numero Identificacion Presidente: "+ nombreRepLegal);
					datosEmpresaFormInicio.setNumeroIdentificacionRepLegal(numeroIdentificacionRepLegal);
					f.setNumeroIdentificacionRepLegal(numeroIdentificacionRepLegal);
					//Se dejara Por defecto Tipo de Identificacion Cedula
					datosEmpresaFormInicio.setTipoIdentificacionRepLegal("01");
					f.setTipoIdentificacionRepLegal("01");
				}				
			}			
			//Fin P-CSR-11002 JLGN 01-08-2011
		}
		//Fin P-CSR-11002 JLGN 09-05-2011

		sesion.setAttribute("datosEmpresaFormInicio", datosEmpresaFormInicio);
		logger.info("DatosEmpresaAction, fin");

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
		
		return mapping.findForward("inicio");
	}

	public ActionForward aceptar(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("aceptar, inicio");
		HttpSession sesion = request.getSession(false);
		sesion.removeAttribute("datosEmpresaFormInicio");
		logger.info("aceptar, fin");
		return mapping.findForward("aceptar");
	}

	public ActionForward cancelar(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("cancelar, inicio");
		DatosEmpresaForm datosEmpresaForm = (DatosEmpresaForm) form;
		HttpSession sesion = request.getSession(false);
		DatosEmpresaForm datosEmpresaFormInicio = (DatosEmpresaForm) sesion.getAttribute("datosEmpresaFormInicio");
		// vuelve a setear datos originales
		datosEmpresaForm.setNombreEmpresa(datosEmpresaFormInicio.getNombreEmpresa());
		datosEmpresaForm.setNombreRepLegal(datosEmpresaFormInicio.getNombreRepLegal());
		datosEmpresaForm.setNumeroIdentificacionRepLegal(datosEmpresaFormInicio.getNumeroIdentificacionRepLegal());
		datosEmpresaForm.setPatenteComercio(datosEmpresaFormInicio.getPatenteComercio());
		datosEmpresaForm.setRazonSocial(datosEmpresaFormInicio.getRazonSocial());
		datosEmpresaForm.setTipoIdentificacionRepLegal(datosEmpresaFormInicio.getTipoIdentificacionRepLegal());
		sesion.removeAttribute("datosEmpresaFormInicio");
		logger.info("cancelar,fin");
		return mapping.findForward("cancelar");
	}
}