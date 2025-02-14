package com.tmmas.cl.scl.portalventas.web.action;

import java.rmi.RemoteException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto.AltaLineaWebDTO;
import com.tmmas.cl.scl.altacliente.presentacion.form.ClienteFacturaForm;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.IdentificadorCivilComDTO;
import com.tmmas.cl.scl.commonbusinessentities.commonapp.DireccionNegocioWebDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.FormularioDireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ParametrosGlobalesDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.ListadoSSOutDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.UsuarioWebDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosGeneralesDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosValidacionVentasDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ResultadoValidacionVentaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.LineaSolicitudScoringDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.VentasException;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.BusquedaClienteDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.ClienteDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.VendedorDTO;
import com.tmmas.cl.scl.portalventas.web.delegate.PortalVentasDelegate;
import com.tmmas.cl.scl.portalventas.web.dto.ClienteAjaxDTO;
import com.tmmas.cl.scl.portalventas.web.dto.NumeroAjaxDTO;
import com.tmmas.cl.scl.portalventas.web.dto.ResultadoSolicitudVentaDTO;
import com.tmmas.cl.scl.portalventas.web.dto.SerieAjaxDTO;
import com.tmmas.cl.scl.portalventas.web.dto.SolicitudScoringAjaxDTO;
import com.tmmas.cl.scl.portalventas.web.form.DatosLineaForm;
import com.tmmas.cl.scl.portalventas.web.form.DatosVentaForm;
import com.tmmas.cl.scl.portalventas.web.form.GestionScoringForm;
import com.tmmas.cl.scl.portalventas.web.form.ServiciosSuplementariosForm;
import com.tmmas.cl.scl.portalventas.web.helper.Global;
import com.tmmas.cl.scl.productdomain.businessobject.dto.TipoPrestacionDTO;
import com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.DatosVentaDTO;

public class DatosAdicLineaScoringAction extends DispatchAction {
	private final Logger logger = Logger.getLogger(DatosAdicLineaScoringAction.class);
	private Global global = Global.getInstance();
	
	PortalVentasDelegate delegate = PortalVentasDelegate.getInstance();	
	
	public ActionForward inicio(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		logger.debug("inicio, inicio");
		
		HttpSession sesion =  request.getSession(false);
	
		GestionScoringForm gestionScoringForm = (GestionScoringForm)sesion.getAttribute("GestionScoringForm");		
		String numLineaScoring = gestionScoringForm.getNumLineaSel();	
		
		SolicitudScoringAjaxDTO solicitudSel = (SolicitudScoringAjaxDTO)sesion.getAttribute("solicitudSel");
		Long numVenta = (Long)sesion.getAttribute("numVenta");
		Long numTransaccion = (Long)sesion.getAttribute("numTransaccion");
		
		//Obtiene los datos de la linea
		LineaSolicitudScoringDTO detalleLineaScoring = delegate.getDetalleLineaScoring(Long.valueOf(numLineaScoring.trim()));
		ArrayList listaServicios = detalleLineaScoring.getArrayListServSup();
		ArrayList listaServiciosDTO = new ArrayList(); 
		for(int i=0;i<listaServicios.size();i++){
			ListadoSSOutDTO ss = new ListadoSSOutDTO();
			ss.setCodigoServicio((String)listaServicios.get(i));		
			listaServiciosDTO.add(ss);
		}
		
		//Obtiene los datos de las prestacion
		TipoPrestacionDTO tipoPrestacion = delegate.getDatosPrestacion(detalleLineaScoring.getCodPrestacion());
		
		DatosLineaForm datosLineaForm = new DatosLineaForm();		
		datosLineaForm.setCodGrpPrestacion(detalleLineaScoring.getCodGrpPrestacion());
		datosLineaForm.setCodTipoPrestacion(detalleLineaScoring.getCodPrestacion());		
		datosLineaForm.setCodTecnologia(detalleLineaScoring.getCodTecnologia());
		datosLineaForm.setIndInvFijo(String.valueOf(tipoPrestacion.getIndInventario()));
		datosLineaForm.setIndNumero(String.valueOf(tipoPrestacion.getIndNumero()));
		datosLineaForm.setIndDirInstalacion(String.valueOf(tipoPrestacion.getIndDirInstalacion()));
		datosLineaForm.setIndNumeroPiloto(String.valueOf(tipoPrestacion.getIndNumeroPiloto()));
		datosLineaForm.setCodRegion(detalleLineaScoring.getCodMunicipio());
		datosLineaForm.setCodProvincia(detalleLineaScoring.getCodDepartamento());
		datosLineaForm.setCodCiudad(detalleLineaScoring.getCodZona());
		datosLineaForm.setCodCelda(detalleLineaScoring.getCodCelda());
		datosLineaForm.setCodCentral(String.valueOf(detalleLineaScoring.getCodCentral()));		
		datosLineaForm.setCodUsoLinea(String.valueOf(detalleLineaScoring.getCodUso()));
		datosLineaForm.setCodPlanTarif(detalleLineaScoring.getCodPlantarif());		
		datosLineaForm.setCodPlanServicio(detalleLineaScoring.getCodPlanServ());
		datosLineaForm.setCodSubAlm(detalleLineaScoring.getCodSubAlm());
		
		datosLineaForm.setCodTipoTerminal(detalleLineaScoring.getCodTipoTerminal());
		datosLineaForm.setFlgMostrarFrecuentes(global.getValor("mostrar.frecuentes"));
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
		datosLineaForm.setArrayListServSup(listaServiciosDTO);
		datosLineaForm.setCodCreditoConsumo(global.getValor("codigo.credito.consumo.nousado"));
		datosLineaForm.setCodGrupoCobroServ(global.getValor("codigo.grupo.cobroserv.cobroscelular"));
		datosLineaForm.setCodLimiteConsumo(detalleLineaScoring.getCodLimiteConsumo());
		datosLineaForm.setMontoLimiteConsumo(detalleLineaScoring.getMontoLimiteConsumo().doubleValue());
		
		ParametrosGeneralesDTO parametrosLargoCelular = new ParametrosGeneralesDTO();
		parametrosLargoCelular.setCodigoproducto(global.getValor("codigo.producto"));
		parametrosLargoCelular.setCodigomodulo(global.getValor("codigo.modulo.GE"));
		parametrosLargoCelular.setNombreparametro(global.getValor("parametro.largo_n_celular"));
		parametrosLargoCelular =delegate.getParametroGeneral(parametrosLargoCelular);
		datosLineaForm.setLargoNumCelular(parametrosLargoCelular.getValorparametro());
		
		//Tipo identificacion
		if (datosLineaForm.getArrayIdentificadorUsuario()==null){
			IdentificadorCivilComDTO[] arrayIdentificadores = delegate.getTipoIdentificadoresCiviles();
			datosLineaForm.setArrayIdentificadorUsuario(arrayIdentificadores);	
		}
		
		datosLineaForm.setNumCelular("");
		datosLineaForm.setNumCelularSimcard("");
		datosLineaForm.setCodModuloOrigen(global.getValor("modulo.web.scoring"));
		
		/* Valores por defecto*/
		cargarValoresDefecto(request, datosLineaForm);
		
		sesion.setAttribute("DatosLineaForm", datosLineaForm);
		
		//Instancio DatosVentaForm y DatosLineaForm ya que es usado en la busqueda de series
		DatosVentaForm datosVentaForm = new DatosVentaForm();
		sesion.setAttribute("DatosVentaForm", datosVentaForm);
		
		//Obtiene numero de venta y numero de transaccion de venta		
		datosVentaForm.setNumeroVenta(numVenta.longValue());
		datosVentaForm.setNumeroTransaccionVenta(numTransaccion.longValue());
		datosVentaForm.setCodDistribuidor(solicitudSel.getCodDistribuidor()); 
		datosVentaForm.setCodModalidadVenta(solicitudSel.getCodModVenta());
		datosVentaForm.setCodTipoContrato(solicitudSel.getCodTipoContrato());
		datosVentaForm.setIndVtaExterna("0"); //TODO		
		datosVentaForm.setCodCliente(solicitudSel.getCodCliente());
		datosVentaForm.setCodTipoSolicitud(global.getValor("codigo.tipo.solicitud.scoring"));
		
		ClienteAjaxDTO clienteSel = new ClienteAjaxDTO();
		clienteSel.setCodigoCliente(datosVentaForm.getCodCliente());
		BusquedaClienteDTO busquedaCliente = new BusquedaClienteDTO();
		busquedaCliente.setCodCliente(datosVentaForm.getCodCliente());
		ClienteDTO[] listaClientes  = delegate.getDatosCliente(busquedaCliente);		
		if (listaClientes!=null && listaClientes.length>0){
			clienteSel.setTipoCliente(listaClientes[0].getTipoCliente());
			clienteSel.setNumeroIdentificacion(listaClientes[0].getNumeroIdentificacion());
			clienteSel.setNombreApellido1(listaClientes[0].getNombreApellido1());
			clienteSel.setNombreApellido2(listaClientes[0].getNombreApellido2());
			clienteSel.setNombreCliente(listaClientes[0].getNombreCliente());
			clienteSel.setNumeroTelefono1(listaClientes[0].getNumeroTelefono());
			clienteSel.setDescripcionColor(listaClientes[0].getDescripcionColor());
			clienteSel.setDescripcionSegmento(listaClientes[0].getDescripcionSegmento());	
			datosVentaForm.setCodCalificacionCliente(listaClientes[0].getCodCalificacion());
			datosVentaForm.setCodTipoCliente(clienteSel.getTipoCliente());
		}
		sesion.setAttribute("clienteSel", clienteSel);
		
		//Datos vendedor
		datosVentaForm.setCodOficina(solicitudSel.getCodOficina());		
		datosVentaForm.setCodVendedor(solicitudSel.getCodVendedor());
		datosVentaForm.setCodTipoComisionista(solicitudSel.getCodTipoComisionista());//TODO
		
		//datosVentaForm.setMontoPreAutorizado(datosVentaForm.getMontoPreAutorizado());
		//datosVentaForm.setCodCrediticia(datosVentaForm.getCodCrediticia());
		//datosVentaForm.setFacturaTercero(datosVentaForm.getFacturaTercero());		
		
		
		logger.debug("inicio, fin");
		
		return mapping.findForward("inicio");
	}
	
	//---------- (+) buscar simcard ---------------------//	
	public ActionForward buscarSimcard(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		logger.debug("buscarSimcard, inicio");
		DatosLineaForm datosAdicLineaScoringForm = (DatosLineaForm)form;
		if (datosAdicLineaScoringForm.getNumSerie()!=null && !datosAdicLineaScoringForm.getNumSerie().equals("")){
			HttpSession sesion = request.getSession(false);
			SerieAjaxDTO serieSel = new SerieAjaxDTO();
			serieSel.setNumSerie(datosAdicLineaScoringForm.getNumSerie());
			serieSel.setCodProcedencia(global.getValor("serie.procedencia.interna"));		
			serieSel.setNumTelefono(datosAdicLineaScoringForm.getNumCelularSimcard());
			serieSel.setFecha(datosAdicLineaScoringForm.getFechaSimcard());
			sesion.setAttribute("serieSel", serieSel);
		}		
		
		logger.debug("buscarSimcard, fin");
		
		return mapping.findForward("buscarSimcard");
	}
	
	public ActionForward cargarSimcard(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		logger.debug("cargarSimcard, inicio");
		DatosLineaForm datosAdicLineaScoringForm = (DatosLineaForm)form;
		HttpSession sesion = request.getSession(false);
		
		if (sesion.getAttribute("serieSel")!=null){
			SerieAjaxDTO serieSel = (SerieAjaxDTO)sesion.getAttribute("serieSel");
			datosAdicLineaScoringForm.setNumSerie(serieSel.getNumSerie());
			datosAdicLineaScoringForm.setNumCelularSimcard(serieSel.getNumTelefono());
			datosAdicLineaScoringForm.setFechaSimcard(serieSel.getFecha());
			sesion.removeAttribute("serieSel");
		}		
		logger.debug("cargarSimcard, fin");
		
		return mapping.findForward("inicio");
	}
	//---------- (-) buscar simcard ---------------------//
	
	//---------- (+) buscar equipo ---------------------//	
	public ActionForward buscarEquipo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		logger.debug("buscarEquipo, inicio");
		DatosLineaForm datosAdicLineaScoringForm = (DatosLineaForm)form;
		if (datosAdicLineaScoringForm.getNumEquipo()!=null && !datosAdicLineaScoringForm.getNumEquipo().equals("")){
			HttpSession sesion = request.getSession(false);
			SerieAjaxDTO serieSel = new SerieAjaxDTO();
			serieSel.setNumSerie(datosAdicLineaScoringForm.getNumEquipo());
			serieSel.setCodProcedencia(datosAdicLineaScoringForm.getCodProcedenciaEquipo());
			serieSel.setCodArticuloEquipo(datosAdicLineaScoringForm.getCodArticuloEquipo());
			serieSel.setGlsArticloEquipo(datosAdicLineaScoringForm.getGlsArticuloEquipo());
			serieSel.setNumTelefono(datosAdicLineaScoringForm.getNumCelularEquipo());
			serieSel.setFecha(datosAdicLineaScoringForm.getFechaEquipo());
			sesion.setAttribute("serieSel", serieSel);
		}		
		logger.debug("buscarEquipo, fin");
		
		return mapping.findForward("buscarEquipo");
	}
	
	public ActionForward cargarEquipo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		logger.debug("cargarEquipo, inicio");
		DatosLineaForm datosAdicLineaScoringForm = (DatosLineaForm)form;
		HttpSession sesion = request.getSession(false);
		
		if (sesion.getAttribute("serieSel")!=null){
			SerieAjaxDTO serieSel = (SerieAjaxDTO)sesion.getAttribute("serieSel");
			datosAdicLineaScoringForm.setNumEquipo(serieSel.getNumSerie());
			datosAdicLineaScoringForm.setCodProcedenciaEquipo(serieSel.getCodProcedencia());
			datosAdicLineaScoringForm.setCodArticuloEquipo(serieSel.getCodArticuloEquipo());
			datosAdicLineaScoringForm.setGlsArticuloEquipo(serieSel.getGlsArticloEquipo());			
			datosAdicLineaScoringForm.setNumCelularEquipo(serieSel.getNumTelefono());
			datosAdicLineaScoringForm.setFechaEquipo(serieSel.getFecha());
			sesion.removeAttribute("serieSel");
		}	
		
		logger.debug("cargarEquipo, fin");
		
		return mapping.findForward("inicio");
	}	
	//---------- (-) buscar equipo ---------------------//

	//---------- (+) cancelar busqueda de serie ----------//
	public ActionForward cancelarSerie(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		logger.debug("cancelarSerie, inicio");
		logger.debug("cancelarSerie, fin");
		
		return mapping.findForward("inicio");
	}	
	//---------- (-) cancelar busqueda de serie ----------//
	
	//---------- (+) buscar numero ---------------------//	
	public ActionForward buscarNumero(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		logger.debug("buscarNumero, inicio");
		
		DatosLineaForm datosAdicLineaScoringForm = (DatosLineaForm)form;
		if (datosAdicLineaScoringForm.getNumCelular()!=null && !datosAdicLineaScoringForm.getNumCelular().equals("")){
			HttpSession sesion = request.getSession(false);
			NumeroAjaxDTO numeroSel = new NumeroAjaxDTO();
			numeroSel.setNumCelular(datosAdicLineaScoringForm.getNumCelular());
			numeroSel.setTablaNumeracion(datosAdicLineaScoringForm.getTablaNumeracion());
			numeroSel.setCategoria(datosAdicLineaScoringForm.getCategoriaNumeracion());
			sesion.setAttribute("numeroSel", numeroSel);
		}		
		
		logger.debug("buscarNumero, fin");
		
		return mapping.findForward("buscarNumero");
	}	
	
	public ActionForward cargarNumero(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		logger.debug("cargarNumero, inicio");
		DatosLineaForm datosAdicLineaScoringForm = (DatosLineaForm)form;
		HttpSession sesion = request.getSession(false);
		
		if (sesion.getAttribute("numeroSel")!=null){
			NumeroAjaxDTO numeroSel = (NumeroAjaxDTO)sesion.getAttribute("numeroSel");
			datosAdicLineaScoringForm.setNumCelular(numeroSel.getNumCelular());
			datosAdicLineaScoringForm.setTablaNumeracion(numeroSel.getTablaNumeracion());
			datosAdicLineaScoringForm.setCategoriaNumeracion(numeroSel.getCategoria());
			sesion.removeAttribute("numeroSel");
			//(+) variables usadas en caso de anular la reserva
			datosAdicLineaScoringForm.setCodSubAlmNumeracion(datosAdicLineaScoringForm.getCodSubAlm());
			datosAdicLineaScoringForm.setCodCentralNumeracion(datosAdicLineaScoringForm.getCodCentral());
			datosAdicLineaScoringForm.setCodUsoNumeracion(datosAdicLineaScoringForm.getCodUsoLinea());
			//(-)
		}	
		
		logger.debug("cargarNumero, fin");
		
		return mapping.findForward("inicio");
	}		
	//---------- (-) buscar numero ---------------------//
	
	//---------- (+) cancelar busqueda de numero ----------//
	public ActionForward cancelarNumero(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		logger.debug("cancelarNumero, inicio");
		logger.debug("cancelarNumero, fin");
		
		return mapping.findForward("inicio");
	}	
	//---------- (-) cancelar busqueda de serie ----------//
	
	//---------- (+) ingreso de direcciones ---------------------//	
	public ActionForward ingresarDireccionPersonal(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		logger.debug("ingresarDireccionPersonal, inicio");
		DatosLineaForm datosAdicLineaScoringForm = (DatosLineaForm)form;		
		request.getSession(false).setAttribute("FormularioDireccionDTOSeleccionado", datosAdicLineaScoringForm.getDireccionPersonaForm());
		request.getSession(false).setAttribute("CodModuloOrigen", global.getValor("modulo.web.scoring"));
		logger.debug("ingresarDireccionPersonal, fin");
		
		return mapping.findForward("ingresarDireccionPersonal");
	}		
	
	public ActionForward ingresarDireccionInstalacion(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		logger.debug("ingresarDireccionInstalacion, inicio");
		DatosLineaForm datosAdicLineaScoringForm = (DatosLineaForm)form;
		request.getSession(false).setAttribute("FormularioDireccionDTOSeleccionado", datosAdicLineaScoringForm.getDireccionInstalacionForm());
		request.getSession(false).setAttribute("CodModuloOrigen", global.getValor("modulo.web.scoring"));
		logger.debug("ingresarDireccionInstalacion, fin");
		
		return mapping.findForward("ingresarDireccionInstalacion");
	}		
	
	public ActionForward cargarDireccion(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		logger.debug("cargarDireccion, inicio");
		DatosLineaForm datosAdicLineaScoringForm = (DatosLineaForm)form;
		HttpSession sesion = request.getSession(false);
		
		if (sesion.getAttribute("FormularioDireccionDTO")!=null){
			FormularioDireccionDTO direccionAux = (FormularioDireccionDTO)((FormularioDireccionDTO)sesion.getAttribute("FormularioDireccionDTO")).clone();

			String tipoDireccion = direccionAux.getTipoDireccion();
			if (tipoDireccion.equals("PERS_USU")){
				datosAdicLineaScoringForm.setDireccionPersonaForm(direccionAux);
				datosAdicLineaScoringForm.setDireccionPersonal(obtenerDireccionAMostrar(datosAdicLineaScoringForm.getDireccionPersonaForm()));
			}
			else if (tipoDireccion.equals("INST_USU")){
				datosAdicLineaScoringForm.setDireccionInstalacionForm(direccionAux);
				datosAdicLineaScoringForm.setDireccionInstalacion(obtenerDireccionAMostrar(datosAdicLineaScoringForm.getDireccionInstalacionForm()));
			}

		}
		logger.debug("cargarDireccion, fin");
		
		return mapping.findForward("inicio");
	}
	
	public ActionForward cancelarDireccion(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		logger.debug("cancelarDireccion, inicio");
		logger.debug("cancelarDireccion, fin");
		
		return mapping.findForward("inicio");
	}	
	
	//---------- (-) ingreso de direcciones ---------------------//	
	
	//---------- (+) ingreso de numeros frecuentes ---------------------//
	public ActionForward ingresarNumerosFrecuentes(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		logger.debug("ingresarNumerosFrecuentes, inicio");
		logger.debug("ingresarNumerosFrecuentes, fin");
		
		return mapping.findForward("ingresarNumerosFrecuentes");
	}	
	
	public ActionForward cargarNumerosFrecuentes(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		logger.debug("cargarNumerosFrecuentes, inicio");
		logger.debug("cargarNumerosFrecuentes, fin");
		
		return mapping.findForward("inicio");
	}		

	//---------- (-) ingreso de numeros frecuentes ---------------------//
	
	//---------- (+) agrega linea solicitud -------//
	public ActionForward agregarSolicitudScoring(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		logger.info("agregarSolicitud, inicio");
		
		HttpSession sesion = request.getSession(false);
		
		AltaLineaWebDTO linea = new AltaLineaWebDTO();
		
		GestionScoringForm gestionScoringForm = (GestionScoringForm)sesion.getAttribute("GestionScoringForm");		
		String numLineaScoring = gestionScoringForm.getNumLineaSel();	
		
		try {
			DatosVentaForm datosVentaForm=(DatosVentaForm)sesion.getAttribute("DatosVentaForm");
			ServiciosSuplementariosForm ssForm=(ServiciosSuplementariosForm)sesion.getAttribute("ServiciosSuplementariosForm");
			
			//DATOS VENTA
			if (datosVentaForm!=null){
				
				linea.setNumLineaScoring(Long.valueOf(numLineaScoring).longValue());
				
				//Datos vendedor
				linea.setCodOficina(datosVentaForm.getCodOficina());
				linea.setCodDistribuidor(datosVentaForm.getCodDistribuidor());
				linea.setCodVendedor(datosVentaForm.getCodVendedor());
				linea.setCodTipoComisionista(datosVentaForm.getCodTipoComisionista());
				
				//Datos del cliente
				linea.setCodCliente(datosVentaForm.getCodCliente());
				linea.setCodTipoCliente(datosVentaForm.getCodTipoCliente());
				linea.setCodCalificacion(datosVentaForm.getCodCalificacionCliente());
				linea.setMontoPreAutorizado(datosVentaForm.getMontoPreAutorizado());
				linea.setCodCrediticia(datosVentaForm.getCodCrediticia());
				linea.setFacturaTercero(datosVentaForm.getFacturaTercero());
				
				//Setea codigo de actuacion
				//Venta Movil --> VT (Venta Terreno/Externa) - VO(Venta Oficina))
				if(!linea.getCodTipoCliente().trim().equals(global.getValor("tipo.cliente.prepago")))
				{
					if(linea.getCodVendedor() != null && !linea.getCodVendedor().trim().equals("")
							&& !linea.getCodVendedor().trim().equals("0") )
					{
						linea.setCodActabo(global.getValor("codigo.actuacion.movil.externa").trim());
						linea.setIndOfiter(global.getValor("venta.terreno").trim());
					}else {
						linea.setCodActabo(global.getValor("codigo.actuacion.movil.interna").trim());
						linea.setIndOfiter(global.getValor("venta.oficina").trim());
					}
				}else {
					linea.setCodActabo(global.getValor("codigo.actuacion.prepago").trim());
					//Para prepago siempre es venta en oficina
					linea.setIndOfiter(global.getValor("venta.oficina").trim());
				}
				
				//Condiciones de venta
				linea.setCodTipoContrato(datosVentaForm.getCodTipoContrato());
				linea.setCodPeriodoContrato(datosVentaForm.getCodPeriodo());
				linea.setCodModalidadVenta(datosVentaForm.getCodModalidadVenta());
				if(!datosVentaForm.getCodModalidadVenta().trim().equals("1"))
				{
					linea.setCodCuotas(datosVentaForm.getNumCuotas());
				}
				
				linea.setNumeroVenta(datosVentaForm.getNumeroVenta());
				linea.setNumeroTransaccionVenta(datosVentaForm.getNumeroTransaccionVenta());
				
				//Tipo Solicitud
				linea.setCodTipoSolicitud(datosVentaForm.getCodTipoSolicitud());
				String codEstadoSolNormal = global.getValorExterno("scoring.estado.solnormal").trim();
				if(gestionScoringForm.getCodEstadoSol().trim().equals(codEstadoSolNormal)) 
				{
					linea.setActualizadaScoringNormal(1);
					linea.setCodTipoSolicitud(global.getValor("codigo.tipo.solicitud.normal"));
					datosVentaForm.setCodTipoSolicitud(global.getValor("codigo.tipo.solicitud.normal"));
				}
				
			}
			//DATOS LINEA
			DatosLineaForm datosLineaForm=(DatosLineaForm)sesion.getAttribute("DatosLineaForm");
			
			if (datosLineaForm!=null)
			{			
				
				linea.setCodGrpPrestacion(datosLineaForm.getCodGrpPrestacion());
				linea.setCodTipoPrestacion(datosLineaForm.getCodTipoPrestacion());			
				
				if(datosLineaForm.getCodGrpPrestacion().trim().equals(global.getValor("grupo.prestacion.movil").trim()))
				{	
					linea.setCodIndemnizacion(global.getValor("codigo.indemnizacion.movil").trim());				
				}else {				
					linea.setCodIndemnizacion(global.getValor("codigo.indemnizacion.fijo").trim());
				}
				//(+) EV 17/12/09
				linea.setCodNivel1(datosLineaForm.getCodNivel1());
				linea.setCodNivel2(datosLineaForm.getCodNivel2());
				linea.setCodNivel3(datosLineaForm.getCodNivel3());
				//(-) EV 17/12/09

				//Home de linea
				linea.setCodRegion(datosLineaForm.getCodRegion());
				linea.setCodProvincia(datosLineaForm.getCodProvincia());
				linea.setCodCiudad(datosLineaForm.getCodCiudad());
				linea.setCodCelda(datosLineaForm.getCodCelda());
				linea.setCodCentral(datosLineaForm.getCodCentral());
				
				//Datos Comerciales
				linea.setCodPlanTarif(datosLineaForm.getCodPlanTarif());
				linea.setCodUsoLinea(Integer.parseInt(datosLineaForm.getCodUsoLinea()));
				linea.setCodTipoTerminal(datosLineaForm.getCodTipoTerminal());
				linea.setCodCreditoConsumo(datosLineaForm.getCodCreditoConsumo());
				if(datosLineaForm.getCodLimiteConsumo() != null){
					String codLimTMP[] = datosLineaForm.getCodLimiteConsumo().split("-");
					linea.setCodLimiteConsumo(codLimTMP[0]);
				}
				linea.setImpLimiteConsumo(datosLineaForm.getMontoLimiteConsumo());
				linea.setCodPlanServicio(datosLineaForm.getCodPlanServicio());
				linea.setCodGrupoCobroServ(datosLineaForm.getCodGrupoCobroServ());
				linea.setCodCausaDescuento(datosLineaForm.getCodCausaDescuento());
				/*linea.setCodCampanaVigente(datosLineaForm.getCodCampanaVigente());			
				linea.setValorRefPorMinuto(datosLineaForm.getValorRefPorMinuto());
				linea.setCodMoneda(datosLineaForm.getCodMoneda());*/
				linea.setCodTecnologia(datosLineaForm.getCodTecnologia());
				
				//Determina si es kit
				linea.setFlgSerieKit(datosLineaForm.getFlgSerieKit());
				
				//Datos Simcard
				linea.setNumSerie(datosLineaForm.getNumSerie());
				
				//Datos Equipo
				linea.setNumEquipo(datosLineaForm.getNumEquipo());			
				linea.setCodProcedencia(datosLineaForm.getCodProcedenciaEquipo());
				linea.setCodArticuloSerieTerminal(datosLineaForm.getCodArticuloEquipo());	
				linea.setDescArticuloEquipo(datosLineaForm.getGlsArticuloEquipo());
				
				
				
				//Datos del seguro
				linea.setCodigoSeguro(datosLineaForm.getCodTipoSeguro());
				linea.setVigenciaSeguro(datosLineaForm.getVigenciaSeguro());			
				
				//Numeracion			
				linea.setNumCelular(datosLineaForm.getNumCelular());
				
				//Servicios				
				 
				if( datosLineaForm.getArrayListServSup() != null) 
				{
					linea.setListaServicios((ListadoSSOutDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
							datosLineaForm.getArrayListServSup().toArray(), ListadoSSOutDTO.class));				
				}
				
				
				if(ssForm != null && ssForm.getNumFax() != null )	linea.setNumFax(new Long(ssForm.getNumFax()).longValue());
				
				
				//Contactos
				/*ArrayList listaContactos = (ArrayList) sesion.getAttribute("listaContactos");
				if(listaContactos != null)
				{
					linea.setListaContactos((GaContactoAbonadoToDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
							listaContactos.toArray(), GaContactoAbonadoToDTO.class));						
				}*/
				
				
				//Numeros sms
				if(datosLineaForm != null && datosLineaForm.getArrayNumerosSms() != null &&
						datosLineaForm.getArrayNumerosSms().length > 0 )
				{
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
				if( datosLineaForm.getDireccionPersonaForm() != null && 
						datosLineaForm.getDireccionPersonaForm().getCOD_REGION() != null && 
						!datosLineaForm.getDireccionPersonaForm().getCOD_REGION().trim().equals(""))
				{				
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
				if( datosLineaForm.getDireccionInstalacionForm() != null && 
						datosLineaForm.getDireccionInstalacionForm().getCOD_REGION() != null && 
						!datosLineaForm.getDireccionInstalacionForm().getCOD_REGION().trim().equals(""))
				{
					direccion.setCodDepartamento(datosLineaForm.getDireccionInstalacionForm().getCOD_REGION());			
					direccion.setCodigoPostalDireccion(datosLineaForm.getDireccionInstalacionForm().getZIP());
					direccion.setCodMunicipio(datosLineaForm.getDireccionInstalacionForm().getCOD_PROVINCIA());
					direccion.setCodSiglaDomicilio(datosLineaForm.getDireccionInstalacionForm().getCOD_TIPOCALLE());
					direccion.setCodZonaDistrito(datosLineaForm.getDireccionInstalacionForm().getCOD_CIUDAD());
					direccion.setLocBarrio(datosLineaForm.getDireccionInstalacionForm().getCOD_COMUNA());
					direccion.setNombreCalle(datosLineaForm.getDireccionInstalacionForm().getNOM_CALLE());
					direccion.setNumeroCalle(datosLineaForm.getDireccionInstalacionForm().getNUM_CALLE());
					direccion.setObservacionDireccion(datosLineaForm.getDireccionInstalacionForm().getOBS_DIRECCION());
					direccion.setTipo(Integer.valueOf(global.getValor("codigo.tipo.dir.correspondencia").trim()).intValue());
					direccion.setReplicada(datosLineaForm.getDireccionInstalacionForm().isDireccionReplicada());
					direccion.setDesDirec1(datosLineaForm.getDireccionInstalacionForm().getDES_DIREC1());					
					direccion.setDesDirec2(datosLineaForm.getDireccionInstalacionForm().getDES_DIREC2());
					listaDir.add(direccion);
				}			
				
				listaDirecciones =(DireccionNegocioWebDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
						listaDir.toArray(), DireccionNegocioWebDTO.class);
				usuario.setDirecciones(listaDirecciones);
				
				linea.setUsuario(usuario);
				
				
				String user = ((ParametrosGlobalesDTO)sesion.getAttribute("paramGlobal")).getCodUsuario();
				linea.setNombreUsuarOra(user);
				
				//(+) Indica si es renovacion segunda linea
				int indRenovacionLinea = 0;
				if (datosLineaForm.getCodRenovacion()!=null && datosLineaForm.getCodRenovacion().equals("1")){
					indRenovacionLinea = 1;
				}
				linea.setIndRenovacion(indRenovacionLinea);
				//(-)
				
				//VALIDAR EXISTENCIA DE LOS PRECIOS CUANDO ES UNA VENTA MOVIL
				if(linea.getCodGrpPrestacion().trim().equals("TM") && ( linea.getCodTecnologia().trim().equals("GSM") || 
						linea.getCodTecnologia().trim().equals("CDMA")) )
				{
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
				delegate.altaLineaWeb(linea);		
				
				SolicitudScoringAjaxDTO solicitudSel = (SolicitudScoringAjaxDTO)sesion.getAttribute("solicitudSel");		
				
				//obtener lineas de la solicitud				
				LineaSolicitudScoringDTO[] listaLineasScoring = delegate.getlineasSolScoring(Long.valueOf(solicitudSel.getNroSolScoring()));		
				sesion.setAttribute("lineasScoring", listaLineasScoring);		
				if(listaLineasScoring == null || listaLineasScoring.length == 0) 
				{
					finalizarSolicitud(request);
					//limpia datos en pantalla
					inicializarLinea(datosLineaForm, request);

					//(+)EV 26/08/2010 Contrata PA
					String habilitarPA = global.getValorExterno("mostrar.planes.adicionales.scoring");
					logger.debug("habilitarPA [" + habilitarPA + "]");
					if (habilitarPA != null && habilitarPA.equals("SI")){//ELIMINAR ESTE IF

						String contratarPlanes = delegate.consultaExistenPlanes(Long.valueOf(solicitudSel.getNroSolScoring()));

						boolean bContratarPlanes = (contratarPlanes!=null && contratarPlanes.equalsIgnoreCase("TRUE"))?true:false;
						if (bContratarPlanes){
							return mapping.findForward("contratarPlanesAdicionales");
						}else {//contrata PA por defecto
							DatosVentaDTO datosVenta = new DatosVentaDTO();
							datosVenta.setNum_venta(String.valueOf(datosVentaForm.getNumeroVenta()));
							datosVenta.setCod_cliente(datosVentaForm.getCodCliente());
							datosVenta.setNum_transaccion(String.valueOf(datosVentaForm.getNumeroTransaccionVenta()));
							datosVenta.setNum_evento("0");
							datosVenta.setCod_vendedor(user);
							datosVenta.setFlag_ciclo("0");
							datosVenta.setCod_proceso(global.getValor("canal.pa.venta"));
							delegate.sendToQueueActivacionProductosPorDefecto(datosVenta);
						}
					}
					//(-)EV 26/08/2010 Contrata PA
					
					//limpiar sesion
					limpiarSesion(request);
					return mapping.findForward("mostrarResultado");
				}else {
					inicializarLinea(datosLineaForm, request);	
				}
				
			}		
		}
		catch (VentasException e) {
			String mensaje = e.getDescripcionEvento() == null ? " " : e.getDescripcionEvento();
			logger.error(StackTraceUtl.getStackTrace(e));
			request.setAttribute("mensajeError", "Ocurrio un error al agregar linea " + mensaje);
			logger.error("[VentasException] Ocurrio un error al agregar linea " + mensaje);
			return mapping.findForward("inicio");
		}
		catch (Exception e) {
			String mensaje = e.getMessage() == null ? " " : e.getMessage();
			request.setAttribute("mensajeError", "Ocurrio un error al agregar linea " + mensaje);
			logger.error(StackTraceUtl.getStackTrace(e));
			logger.error("[Exception] Ocurrio un error al agregar linea " + mensaje);
			return mapping.findForward("inicio");
		}
		logger.info("agregarSolicitud, fin");
		return mapping.findForward("anterior");
		
	}
	//---------- (-) agrega linea solicitud -------//
	
	//---------- (+) finaliza solicitud y muestra resultado -------//
	private void finalizarSolicitud(HttpServletRequest request )
			throws Exception 
	{
		
		logger.debug("finalizarSolicitud Datos Adicional Linea Scoring, inicio");
		HttpSession sesion = request.getSession(false);
		
		DatosVentaForm datosVentaForm=(DatosVentaForm)sesion.getAttribute("DatosVentaForm");
		
		
		AltaLineaWebDTO linea = new AltaLineaWebDTO();
		try{
			//DATOS VENTA
			if (datosVentaForm!=null){
				
				SolicitudScoringAjaxDTO solicitudSel = (SolicitudScoringAjaxDTO)sesion.getAttribute("solicitudSel");				
				linea.setNumSolScoring(Long.valueOf(solicitudSel.getNroSolScoring()).longValue());
				
				//Datos vendedor
				linea.setCodOficina(datosVentaForm.getCodOficina());
				linea.setCodDistribuidor(datosVentaForm.getCodDistribuidor());
				linea.setCodVendedor(datosVentaForm.getCodVendedor());
				linea.setCodTipoComisionista(datosVentaForm.getCodTipoComisionista());
				
				//Datos del cliente
				linea.setCodCliente(datosVentaForm.getCodCliente());
				linea.setCodTipoCliente(datosVentaForm.getCodTipoCliente());
				linea.setCodCalificacion(datosVentaForm.getCodCalificacionCliente());
				linea.setMontoPreAutorizado(datosVentaForm.getMontoPreAutorizado());
				linea.setCodCrediticia(datosVentaForm.getCodCrediticia());
				linea.setFacturaTercero(datosVentaForm.getFacturaTercero());
				
				//Setea codigo de actuacion
				//Venta Movil --> VT (Venta Terreno/Externa) - VO(Venta Oficina))
				if(!linea.getCodTipoCliente().trim().equals(global.getValor("tipo.cliente.prepago")))
				{
					if(linea.getCodVendedor() != null && !linea.getCodVendedor().trim().equals("")  
							&& !linea.getCodVendedor().trim().equals("0"))
					{
						linea.setCodActabo(global.getValor("codigo.actuacion.movil.externa").trim());
						linea.setIndOfiter(global.getValor("venta.terreno").trim());
					}else {
						linea.setCodActabo(global.getValor("codigo.actuacion.movil.interna").trim());
						linea.setIndOfiter(global.getValor("venta.oficina").trim());
					}
				}else {
					linea.setCodActabo(global.getValor("codigo.actuacion.prepago").trim());
					//Para prepago siempre es venta en oficina
					linea.setIndOfiter(global.getValor("venta.oficina").trim());
				}
				
				//Datos cliente facturable
				ClienteFacturaForm clienteFacturaForm = (ClienteFacturaForm)sesion.getAttribute("ClienteFacturaForm");
				if (clienteFacturaForm!=null)
				{
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
				if(!datosVentaForm.getCodModalidadVenta().trim().equals("1"))
				{
					linea.setCodCuotas(datosVentaForm.getNumCuotas());
				}			
				
				String user = ((ParametrosGlobalesDTO)sesion.getAttribute("paramGlobal")).getCodUsuario();
				logger.debug("Usuario ORACLE: "+ user);
				linea.setNombreUsuarOra(user);
				linea.setNumeroVenta(datosVentaForm.getNumeroVenta());
				linea.setNumeroTransaccionVenta(datosVentaForm.getNumeroTransaccionVenta());
				
				//Tipo Solicitud
				linea.setCodTipoSolicitud(datosVentaForm.getCodTipoSolicitud());				
			}
			
			linea.setCodEstadoEscoring(global.getValorExterno("scoring.estado.pendiente.preactivar"));
			
			//GRABAR
			delegate.altaVentaWeb(linea);			
		
		}catch(VentasException e){
	     	String mensaje = e.getDescripcionEvento()==null?" ":e.getDescripcionEvento(); 
	     	request.setAttribute("mensajeError", "Ocurrio un error al finalizar solicitud "+mensaje );
	     	logger.debug("[VentasException]Ocurrio un error al finalizar solicitud "+mensaje );			
		}catch(Exception e){
	     	String mensaje = e.getMessage()==null?" ":e.getMessage(); 
	     	request.setAttribute("mensajeError", "Ocurrio un error al finalizar solicitud "+mensaje );
	     	logger.debug("[Exception]Ocurrio un error al finalizar solicitud "+mensaje );
	    }
		
		logger.debug("finalizarSolicitud, fin");

		try{
			//desbloquear vendedor
			if (datosVentaForm!=null && !datosVentaForm.getCodDistribuidor().equals("")){
				VendedorDTO entrada= new VendedorDTO();
				entrada.setCodigoVendedor(datosVentaForm.getCodDistribuidor());
				entrada.setCodigoAccionBloqueo(global.getValor("accion.desbloqueo.vendedor"));
				delegate.bloqueaDesbloqueaVendedor(entrada);
			}
		}catch(Exception e){
			request.setAttribute("mensajeError", "Ocurrio un error al desbloquear vendedor" );
		}
		
		//Resultado
		ResultadoSolicitudVentaDTO resultadoSolVenta = new ResultadoSolicitudVentaDTO();
		resultadoSolVenta.setCodCliente(datosVentaForm.getCodCliente());
		resultadoSolVenta.setNumeroVenta(String.valueOf(datosVentaForm.getNumeroVenta()));
		sesion.setAttribute("resultadoSolVenta", resultadoSolVenta);
	}
	
	
	
	//---------- (-) finaliza solicitud y muestra resultado -------//	

	public ActionForward irAMenu(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		logger.debug("irAMenu, inicio");
		
		HttpSession sesion = request.getSession(false);
		//desbloquear vendedor 
		DatosVentaForm datosVentaForm=(DatosVentaForm)sesion.getAttribute("DatosVentaForm");
		//DATOS VENTA
		if (datosVentaForm!=null && !datosVentaForm.getCodDistribuidor().equals("")){
			VendedorDTO entrada= new VendedorDTO();
			entrada.setCodigoVendedor(datosVentaForm.getCodDistribuidor());
			entrada.setCodigoAccionBloqueo(global.getValor("accion.desbloqueo.vendedor"));
			delegate.bloqueaDesbloqueaVendedor(entrada);
		}
		
		//limpiar sesion
		limpiarSesion(request);
		
		logger.debug("irAMenu, fin");
		return mapping.findForward("irAMenu");
	}	
	
	public ActionForward irAMenuFinal(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		logger.debug("irAMenuFinal, inicio");
		
		logger.debug("irAMenuFinal, fin");
		return mapping.findForward("irAMenu");		
	}
	
	public ActionForward anterior(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		logger.debug("anterior, inicio");
		HttpSession sesion = request.getSession(false);
		
		SolicitudScoringAjaxDTO solicitudSel = (SolicitudScoringAjaxDTO)sesion.getAttribute("solicitudSel");		
		
		//obtener lineas de la solicitud				
		LineaSolicitudScoringDTO[] listaLineasScoring = delegate.getlineasSolScoring(Long.valueOf(solicitudSel.getNroSolScoring()));		
		sesion.setAttribute("lineasScoring", listaLineasScoring);
		if(listaLineasScoring!=null) sesion.setAttribute("totalLineas", new Integer(listaLineasScoring.length));	
		
		//limpiar sesion
		sesion.removeAttribute("BuscaSeriesForm");		
		sesion.removeAttribute("BuscaNumeroForm");		
		sesion.removeAttribute("listaSeries");
		sesion.removeAttribute("listaNumeros");
		sesion.removeAttribute("listaNumerosRango");
		sesion.removeAttribute("numeroSel");
		sesion.removeAttribute("serieSel");
		logger.debug("anterior, fin");	
		return mapping.findForward("anterior");		
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
		if (!direccionForm.getDES_DIREC2().equals("")){
			dirAMostrar = dirAMostrar + direccionForm.getDES_DIREC2()+" ";
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
	
	private void inicializarLinea(DatosLineaForm  datosLineaForm,HttpServletRequest request) throws Exception{
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
		datosLineaForm.setCodPlanServicioSeleccionado("");
		datosLineaForm.setCodLimiteConsumoSeleccionado("");
		datosLineaForm.setCodTipoTerminalSeleccionado("");
		datosLineaForm.setCodCausaDescuentoSeleccionada("");
		
		datosLineaForm.setFlgActivarBtnFinalizar("1");
		datosLineaForm.setFlgSerieKit("0");
		datosLineaForm.setFlgSerieNumerada("0");
		datosLineaForm.setFlgConsultaFinalizar("1");
	
	}//fin inicializarLinea

	private void cargarValoresDefecto(HttpServletRequest request, DatosLineaForm datosLineaForm) 
		throws VentasException, RemoteException 
	{
		
		HttpSession sesion =  request.getSession(false);
		if (sesion.getAttribute("clienteSel")!=null){
			ClienteAjaxDTO clienteSel = (ClienteAjaxDTO)sesion.getAttribute("clienteSel");
			datosLineaForm.setTipoIdentificacionUsuario(clienteSel.getCodigoTipoIdentificacion());
			datosLineaForm.setNumeroIdentificacionUsuario(clienteSel.getNumeroIdentificacion());
			datosLineaForm.setNomUsuario(clienteSel.getNombreCliente());
			datosLineaForm.setApellido1(clienteSel.getNombreApellido1());
			datosLineaForm.setApellido2(clienteSel.getNombreApellido2());
			datosLineaForm.setTelefono(clienteSel.getNumeroTelefono1());
			datosLineaForm.setDescripcionColor(clienteSel.getDescripcionColor());
			datosLineaForm.setDescripcionSegmento(clienteSel.getDescripcionSegmento());
		}
	}

	
	private void limpiarSesion(HttpServletRequest request){
		HttpSession sesion = request.getSession(false);		
		sesion.removeAttribute("DatosVentaForm");
		sesion.removeAttribute("BuscaSeriesForm");		
		sesion.removeAttribute("BuscaNumeroForm");
		sesion.removeAttribute("DireccionForm");
		sesion.removeAttribute("listaSeries");
		sesion.removeAttribute("listaNumeros");
		sesion.removeAttribute("listaNumerosRango");		
		sesion.removeAttribute("numeroSel");
		sesion.removeAttribute("serieSel");
		sesion.removeAttribute("clienteSel");
		sesion.removeAttribute("NumerosCortosSMSForm");		
	}
	
	


	
}
