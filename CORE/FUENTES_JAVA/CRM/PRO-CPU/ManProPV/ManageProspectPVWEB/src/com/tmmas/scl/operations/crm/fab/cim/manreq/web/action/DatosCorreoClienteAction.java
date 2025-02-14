package com.tmmas.scl.operations.crm.fab.cim.manreq.web.action;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.tmmas.cl.scl.commonbusinessentities.dto.FormularioDireccionDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.DireccionNegocioDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.DatosCorreoMovistarDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate.ManageRequestBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.DatosCorreoClienteForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.Global;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.PaqueteWeb;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.ProductoWeb;

public class DatosCorreoClienteAction extends DispatchAction {
	
	private final Logger logger = Logger.getLogger(DatosCorreoClienteAction.class);
	private Global global = Global.getInstance();
	ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();
	
	public ActionForward inicio(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		logger.info("inicio, inicio");
		DatosCorreoClienteForm datosCorreoClienteForm = (DatosCorreoClienteForm) form;
		
		//limpia datos
		datosCorreoClienteForm.setNombreProducto("");
		datosCorreoClienteForm.setNombreContacto("");
		datosCorreoClienteForm.setCorreoElectronicoPersonal("");
		datosCorreoClienteForm.setCorreoElectronicoEmpresa("");
		datosCorreoClienteForm.setDireccionInstalacion("");
		datosCorreoClienteForm.setTelefono("");

		//obtiene informacion asociada a ProductoWeb
		HttpSession sesion = request.getSession(false);
		PaqueteWeb paqueteWeb = (PaqueteWeb) sesion.getAttribute("paqueteWeb");
		ProductoWeb productoSeleccionado = (ProductoWeb) sesion.getAttribute("productoSeleccionado");
		
		DatosCorreoMovistarDTO datosCorreo = (DatosCorreoMovistarDTO)productoSeleccionado.getDatosCorreoCliente();
		FormularioDireccionDTO direccionCorreo = (FormularioDireccionDTO)productoSeleccionado.getDatosDireccionCorreoCliente();
		
		if (datosCorreo!=null){
			datosCorreoClienteForm.setNombreContacto(datosCorreo.getNomUsuario());
			datosCorreoClienteForm.setCorreoElectronicoPersonal(datosCorreo.getCorreoPersonal());
			datosCorreoClienteForm.setCorreoElectronicoEmpresa(datosCorreo.getCorreoCorporativo());
			datosCorreoClienteForm.setTelefono((datosCorreo.getTelefono()>0?String.valueOf(datosCorreo.getTelefono()):""));
		}
		
		if (direccionCorreo!=null){
			datosCorreoClienteForm.setDireccionInstalacion(obtenerDireccionAMostrar(direccionCorreo));
		}
		
		//tipo de correo
		String tipoCorreo = ""; //"PER:personal","EMP:empresarial", "PEREMP:personal y empresarial"
		String idEspecProvision = productoSeleccionado.getIdEspecProvision();
		HashMap parametrosCorreo = paqueteWeb.getParametrosCorreo();
		
		String x1 =(String) parametrosCorreo.get("X1");
		String x2 =(String) parametrosCorreo.get("X2");
		String x4 =(String) parametrosCorreo.get("X4");
		String x6 =(String) parametrosCorreo.get("X6");
				
		if (x1.equals( idEspecProvision)){//x1 muestra solo texto correo profesional
			tipoCorreo = "PER";
		}else if (x2.equals( idEspecProvision) || x4.equals( idEspecProvision) || x6.equals( idEspecProvision)){//x2,x4,x6 muestra solo texto correo empresarial
			tipoCorreo = "EMP";
		}else{//x3,x5,x7 muestra ambos
			tipoCorreo = "PEREMP";
		}

		datosCorreoClienteForm.setTipoCorreo(tipoCorreo);
		//nombre del producto
		datosCorreoClienteForm.setNombreProducto(productoSeleccionado.getNombre());
		
		//largo celular
		ParametroDTO param = new ParametroDTO();
		param.setCodModulo(global.getValor("codigo.modulo.GE"));
		param.setCodProducto(Integer.parseInt(global.getValor("codigo.producto")));
		param.setNomParametro(global.getValor("parametro.largo_n_celular"));
		ParametroDTO paramGral = delegate.obtenerParametroGeneral(param);
		datosCorreoClienteForm.setLargoNumCelular(paramGral.getValor());
			
		logger.info("inicio, fin");
		
		return mapping.findForward("inicio");
	}
	
	public ActionForward grabar(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		logger.info("grabar, inicio");
		DatosCorreoClienteForm datosCorreoClienteForm = (DatosCorreoClienteForm) form;
		
		//guarda informacion asociada a ProductoWeb
		HttpSession sesion = request.getSession(false);
		ProductoWeb productoSeleccionado = (ProductoWeb) sesion.getAttribute("productoSeleccionado");
		
		DatosCorreoMovistarDTO datosCorreo = new DatosCorreoMovistarDTO();
		FormularioDireccionDTO direccionCorreo = new FormularioDireccionDTO();
		
		datosCorreo.setNomUsuario(datosCorreoClienteForm.getNombreContacto());
		datosCorreo.setCorreoPersonal(datosCorreoClienteForm.getCorreoElectronicoPersonal());
		datosCorreo.setCorreoCorporativo(datosCorreoClienteForm.getCorreoElectronicoEmpresa());
		datosCorreo.setTelefono((datosCorreoClienteForm.getTelefono()!=null)?Long.parseLong(datosCorreoClienteForm.getTelefono()):0);
		productoSeleccionado.setDatosCorreoCliente(datosCorreo); //guarda datos de pagina
		productoSeleccionado.getProductoDTO().setDatosCorreoMovistar(datosCorreo);//guarda en producto ofertado
		
		if (sesion.getAttribute("FormularioDireccionDTO")!=null){
			direccionCorreo = (FormularioDireccionDTO)((FormularioDireccionDTO)sesion.getAttribute("FormularioDireccionDTO")).clone();
			productoSeleccionado.setDatosDireccionCorreoCliente(direccionCorreo);//guarda datos de direccion
			productoSeleccionado.getProductoDTO().setDireccion(traspasarDatosDireccion(direccionCorreo));//guarda en producto ofertado
			sesion.removeAttribute("FormularioDireccionDTO");
		}
		
		//limpia variables utilizadas por la pagina
		sesion.removeAttribute("paqueteWeb");
		sesion.removeAttribute("productoSeleccionado");
		
		logger.info("grabar, fin");
		
		return mapping.findForward("volver");
	}
	
	public ActionForward ingresarDireccionInstalacion(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		logger.debug("ingresarDireccionInstalacion, inicio");
		
		HttpSession session = request.getSession(false);
		ProductoWeb productoSeleccionado = (ProductoWeb) session.getAttribute("productoSeleccionado");

		//datos de direccion(la primera vez es nulo)
		session.setAttribute("FormularioDireccionDTOSeleccionado", productoSeleccionado.getDatosDireccionCorreoCliente());
		
		logger.debug("ingresarDireccionInstalacion, fin");
		
		return mapping.findForward("ingresarDireccionInstalacion");
	}
	
	public ActionForward cancelarDireccion(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		logger.debug("cancelarDireccion, inicio");
		logger.debug("cancelarDireccion, fin");
		
		return mapping.findForward("inicio");
	}
	
	public ActionForward cargarDireccion(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		logger.debug("cargarDireccion, inicio");
		DatosCorreoClienteForm datosCorreoClienteForm = (DatosCorreoClienteForm) form;
		
		HttpSession sesion = request.getSession(false);
		if (sesion.getAttribute("FormularioDireccionDTO")!=null){
			FormularioDireccionDTO direccionAux = (FormularioDireccionDTO)((FormularioDireccionDTO)sesion.getAttribute("FormularioDireccionDTO")).clone();
			datosCorreoClienteForm.setDireccionInstalacion(obtenerDireccionAMostrar(direccionAux));//carga la glosa de la direccion
		}
		logger.debug("cargarDireccion, fin");
		
		return mapping.findForward("inicio");
	}
	
	private String obtenerDireccionAMostrar(FormularioDireccionDTO direccionForm) {
		
		String dirAMostrar = "";
		if (!direccionForm.getNOM_CALLE().equals("")){
			dirAMostrar = dirAMostrar + direccionForm.getNOM_CALLE()+" ";
		}
		if (!direccionForm.getNUM_CALLE().equals("")){
			dirAMostrar = dirAMostrar + direccionForm.getNUM_CALLE()+" ";
		}
		if (!direccionForm.getCOD_CIUDAD().equals("")){
			dirAMostrar = dirAMostrar + direccionForm.getDescripcionCOD_CIUDAD()+" ";
		}
		if (!direccionForm.getDES_DIREC1().equals("")){
			dirAMostrar = dirAMostrar + direccionForm.getDES_DIREC1()+" ";
		}
		if (!direccionForm.getCOD_COMUNA().equals("")){
			dirAMostrar = dirAMostrar + direccionForm.getDescripcionCOD_COMUNA()+" ";
		}
		if (!direccionForm.getZIP().equals("")){
			dirAMostrar = dirAMostrar + ". Código Postal "+direccionForm.getDescripcionZIP()+" ";
		}
		if (!direccionForm.getCOD_REGION().equals("")){
			dirAMostrar = dirAMostrar + ". Departamento "+direccionForm.getDescripcionCOD_REGION()+" ";
		}
		if (!direccionForm.getCOD_PROVINCIA().equals("")){
			dirAMostrar = dirAMostrar + ". Municipio "+direccionForm.getDescripcionCOD_PROVINCIA()+" ";
		}
		return dirAMostrar;
	}
	
    private DireccionNegocioDTO traspasarDatosDireccion(FormularioDireccionDTO direccionForm){

        DireccionNegocioDTO direccionAux =  new DireccionNegocioDTO();

        direccionAux.setCodigo("");
        direccionAux.setProvincia(direccionForm.getCOD_PROVINCIA());
        direccionAux.setRegion(direccionForm.getCOD_REGION());
        direccionAux.setCiudad(direccionForm.getCOD_CIUDAD());
        direccionAux.setComuna(direccionForm.getCOD_COMUNA());
        direccionAux.setCalle(direccionForm.getNOM_CALLE());
        direccionAux.setNumero(direccionForm.getNUM_CALLE());
        direccionAux.setObservacionDescripcion(direccionForm.getOBS_DIRECCION());
        direccionAux.setDescripcionDireccion1(direccionForm.getDES_DIREC1());
        direccionAux.setZip(direccionForm.getZIP());
        direccionAux.setTipoCalle(direccionForm.getCOD_TIPOCALLE());

        logger.debug("devuelve direccionNegocioDTO, traspasarDatosDireccion,direccionAux="+direccionAux);
        return direccionAux;
    }

}
