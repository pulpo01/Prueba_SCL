package com.tmmas.cl.scl.portalventas.web.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.tmmas.cl.scl.commonbusinessentities.dto.ParametrosGlobalesDTO;
import com.tmmas.cl.scl.portalventas.web.delegate.PortalVentasDelegate;
import com.tmmas.cl.scl.portalventas.web.dto.ClienteAjaxDTO;
import com.tmmas.cl.scl.portalventas.web.form.DatosVentaForm;
import com.tmmas.cl.scl.portalventas.web.form.PlanesAdicionalesForm;
import com.tmmas.cl.scl.portalventas.web.helper.Global;

public class PlanesAdicionalesAction extends DispatchAction {
	private final Logger logger = Logger.getLogger(PlanesAdicionalesAction.class);
	private Global global = Global.getInstance();
	
	PortalVentasDelegate delegate = PortalVentasDelegate.getInstance();	

	public ActionForward inicio(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		logger.debug("inicio, inicio");
		PlanesAdicionalesForm planesAdicionalesForm = (PlanesAdicionalesForm)form;
		HttpSession sesion =  request.getSession(false);
		
		DatosVentaForm datosVentaForm=(DatosVentaForm)sesion.getAttribute("DatosVentaForm");
		
		String codVendedor = datosVentaForm.getCodVendedor().trim().equals("")?datosVentaForm.getCodDistribuidor():datosVentaForm.getCodVendedor();
		
		String urlPlanesAdic  = global.getValorExterno("url.ManProWEB");
		urlPlanesAdic = urlPlanesAdic+"?cod_cliente="+datosVentaForm.getCodCliente()+
		"&num_venta="+datosVentaForm.getNumeroVenta()+"&num_transaccion="+datosVentaForm.getNumeroTransaccionVenta()+"&cod_vendedor="+codVendedor
		+"&flag_ciclo=0";  
		logger.debug("urlPlanesAdic="+urlPlanesAdic);
		planesAdicionalesForm.setUrlPlanesAdicionales(urlPlanesAdic);

		planesAdicionalesForm.setCodCliente(datosVentaForm.getCodCliente());
		planesAdicionalesForm.setCodTipoClientePrepago(datosVentaForm.getCodTipoClientePrepago());
		
		if (sesion.getAttribute("clienteSel")!=null){
			ClienteAjaxDTO clienteSel = (ClienteAjaxDTO)sesion.getAttribute("clienteSel");
			String nombreCliente = (clienteSel.getNombreCliente()!=null)?clienteSel.getNombreCliente():"";
			String apellido1 = (clienteSel.getNombreApellido1()!=null)?clienteSel.getNombreApellido1():"";
			String apellido2 = (clienteSel.getNombreApellido2()!=null)?clienteSel.getNombreApellido2():"";
			planesAdicionalesForm.setNombreCliente(nombreCliente+" "+apellido1+" "+apellido2);
		}
		
		//guardar informacion de venta
		ParametrosGlobalesDTO paramGlobal = (ParametrosGlobalesDTO)sesion.getAttribute("paramGlobal");
		
		//planesAdicionalesForm.setCodCliente
		planesAdicionalesForm.setCodUsuario(paramGlobal.getCodUsuario());
		planesAdicionalesForm.setCodOperadora(paramGlobal.getCodOperadora());
		planesAdicionalesForm.setVersionSistema(paramGlobal.getVersionSistema());
		planesAdicionalesForm.setTipoEjecucion(paramGlobal.getTipoEjecucion());
		planesAdicionalesForm.setFormatoNIT(paramGlobal.getFormatoNIT());
		planesAdicionalesForm.setCodigoIdentificadorNIT(paramGlobal.getCodigoIdentificadorNIT());
		planesAdicionalesForm.setNumeroVenta(String.valueOf(datosVentaForm.getNumeroVenta()));
		planesAdicionalesForm.setNumeroTransaccionVenta(String.valueOf(datosVentaForm.getNumeroTransaccionVenta()));

		logger.debug("inicio, fin");
		return mapping.findForward("inicio");
	}
	
	public ActionForward inicioScoring(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		logger.debug("inicioScoring, inicio");
		PlanesAdicionalesForm planesAdicionalesForm = (PlanesAdicionalesForm)form;
		HttpSession sesion =  request.getSession(false);
		
		DatosVentaForm datosVentaForm=(DatosVentaForm)sesion.getAttribute("DatosVentaForm");
		
		String codVendedor = datosVentaForm.getCodVendedor().trim().equals("")?datosVentaForm.getCodDistribuidor():datosVentaForm.getCodVendedor();
		logger.debug("codVendedor="+codVendedor);
		
		String urlPlanesAdic  = global.getValorExterno("url.ManProWEB");
		urlPlanesAdic = urlPlanesAdic+"?cod_cliente="+datosVentaForm.getCodCliente()+
		"&num_venta="+datosVentaForm.getNumeroVenta()+"&num_transaccion="+datosVentaForm.getNumeroTransaccionVenta()+"&cod_vendedor="+codVendedor
		+"&flag_ciclo=0&origen=SCORING";  
		logger.debug("urlPlanesAdic="+urlPlanesAdic);
		planesAdicionalesForm.setUrlPlanesAdicionales(urlPlanesAdic);

		planesAdicionalesForm.setCodCliente(datosVentaForm.getCodCliente());
		//parametro prepago
		planesAdicionalesForm.setCodTipoClientePrepago(global.getValor("tipo.cliente.prepago"));
		
		if (sesion.getAttribute("clienteSel")!=null){
			ClienteAjaxDTO clienteSel = (ClienteAjaxDTO)sesion.getAttribute("clienteSel");
			String nombreCliente = (clienteSel.getNombreCliente()!=null)?clienteSel.getNombreCliente():"";
			String apellido1 = (clienteSel.getNombreApellido1()!=null)?clienteSel.getNombreApellido1():"";
			String apellido2 = (clienteSel.getNombreApellido2()!=null)?clienteSel.getNombreApellido2():"";
			planesAdicionalesForm.setNombreCliente(nombreCliente+" "+apellido1+" "+apellido2);
		}
		
		//guardar informacion de venta
		ParametrosGlobalesDTO paramGlobal = (ParametrosGlobalesDTO)sesion.getAttribute("paramGlobal");
		
		planesAdicionalesForm.setCodUsuario(paramGlobal.getCodUsuario());
		planesAdicionalesForm.setCodOperadora(paramGlobal.getCodOperadora());
		planesAdicionalesForm.setVersionSistema(paramGlobal.getVersionSistema());
		planesAdicionalesForm.setTipoEjecucion(paramGlobal.getTipoEjecucion());
		planesAdicionalesForm.setFormatoNIT(paramGlobal.getFormatoNIT());
		planesAdicionalesForm.setCodigoIdentificadorNIT(paramGlobal.getCodigoIdentificadorNIT());
		planesAdicionalesForm.setNumeroVenta(String.valueOf(datosVentaForm.getNumeroVenta()));
		planesAdicionalesForm.setNumeroTransaccionVenta(String.valueOf(datosVentaForm.getNumeroTransaccionVenta()));

		logger.debug("inicioScoring, fin");
		return mapping.findForward("inicio");
	}
	
	public ActionForward continuar(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.debug("continuar, inicio");
		HttpSession sesion =  request.getSession(false);
		DatosVentaForm datosVentaForm=(DatosVentaForm)sesion.getAttribute("DatosVentaForm");
		delegate.updEstadoMovProductoSolicitud(new Long(datosVentaForm.getNumeroVenta()));
		limpiarSesion(request);	
		logger.debug("continuar, fin");
		
		return mapping.findForward("mostrarResultado");
	}	
	
	private void limpiarSesion(HttpServletRequest request){
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
	}	
}
