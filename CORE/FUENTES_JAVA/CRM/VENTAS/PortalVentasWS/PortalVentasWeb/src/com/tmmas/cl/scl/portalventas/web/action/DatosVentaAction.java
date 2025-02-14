package com.tmmas.cl.scl.portalventas.web.action;

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
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto.CabeceraArchivoCOLDTO;
import com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto.CabeceraArchivoDTO;
import com.tmmas.cl.scl.altacliente.presentacion.delegate.AltaClienteDelegate;
import com.tmmas.cl.scl.altacliente.presentacion.form.AltaClienteInicioForm;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ClienteAltaDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.DatosClienteBuroDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.OficinaComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.exception.AltaClienteException;
import com.tmmas.cl.scl.commonbusinessentities.dto.DireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ParametrosGlobalesDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.NumeroCuotasListOutDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.BusquedaClienteDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.ClienteDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.DatosGeneralesDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.TipoSolicitudDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.UsuarioSCLDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.VendedorDTO;
import com.tmmas.cl.scl.portalventas.web.delegate.PortalVentasDelegate;
import com.tmmas.cl.scl.portalventas.web.dto.ClienteAjaxDTO;
import com.tmmas.cl.scl.portalventas.web.form.DatosVentaForm;
import com.tmmas.cl.scl.portalventas.web.helper.Global;

public class DatosVentaAction extends DispatchAction {
	private final Logger logger = Logger.getLogger(DatosVentaAction.class);
	private Global global = Global.getInstance();
	
	PortalVentasDelegate delegate = PortalVentasDelegate.getInstance();
	//Inicio P-CSR-11002 JLGN 12-05-2011
	AltaClienteDelegate delegate2 = AltaClienteDelegate.getInstance();
	//Fin P-CSR-11002 JLGN 12-05-2011
	
	public DatosVentaAction(){		
		logger.debug("DatosVentaAction():Begin");
		UtilLog.setLog(global.getValorExterno("PortalVentasWeb.log"));
		logger.debug("DatosVentaAction():End");
	}
	
	public ActionForward inicio(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.info("inicio, inicio");
		
		DatosVentaForm datosVentaForm = (DatosVentaForm)form;
		boolean estadoVendedor=true;		
		limpiarSesion(datosVentaForm,request);
		
		VendedorDTO entrada = new VendedorDTO();

		UsuarioSCLDTO usuarioSCL=new UsuarioSCLDTO();
		UsuarioSCLDTO respuesta = new UsuarioSCLDTO();
		String IndVtaExterna="";
		//(+)-- Carga de listas --

		
		HttpSession sesion = request.getSession(false);
		
		//Tipo de solicitudes
		TipoSolicitudDTO[] arrayTipoSolicitud = delegate.obtenerTiposSolicitudes();
		
		//Comprobar si la operadora y el usuario admiten tipo de solicitud SCORING desde la sesión
		Boolean habilitarScoring = Boolean.FALSE;
		if (sesion.getAttribute("habilitarScoring") != null) {
			habilitarScoring = (Boolean) sesion.getAttribute("habilitarScoring");
		}
		logger.debug("Usuario y operadora admiten SCORING: " + habilitarScoring);
		
		ArrayList arrayTipoSolicitudTmp = new ArrayList(); 
		String codTipoSolicitudScoring = global.getValor("codigo.tipo.solicitud.scoring");
		
		if (!habilitarScoring.booleanValue()) //Si no permite scoring se filtra scoring desde listado
		{
			for(int i=0; i<arrayTipoSolicitud.length; i++){
				if (!arrayTipoSolicitud[i].getCodTipoSolicitud().equals(codTipoSolicitudScoring))
				{
					TipoSolicitudDTO tipoSolicitudDTO =  new TipoSolicitudDTO();
					tipoSolicitudDTO.setCodTipoSolicitud(arrayTipoSolicitud[i].getCodTipoSolicitud());
					tipoSolicitudDTO.setGlsTipoSolicitud(arrayTipoSolicitud[i].getGlsTipoSolicitud());
					arrayTipoSolicitudTmp.add(tipoSolicitudDTO);					
				}
			}
			datosVentaForm.setArrayTipoSolicitud((TipoSolicitudDTO[])ArrayUtl.copiaArregloTipoEspecifico(arrayTipoSolicitudTmp.toArray(), 
					TipoSolicitudDTO.class));	
		}else{
			datosVentaForm.setArrayTipoSolicitud(arrayTipoSolicitud);
		}
		//Inicio P-CSR-11002 JLGN 17-05-2011
		datosVentaForm.setCodTipoSolicitud("2"); //Se deja Solicitud Fisica por defecto
		//Fin P-CSR-11002 JLGN 17-05-2011
		
		//Oficinas
		OficinaComDTO oficinaComDTO = new OficinaComDTO();
		OficinaComDTO[] arrayOficina = delegate.getOficinas(oficinaComDTO);
		datosVentaForm.setArrayOficina(arrayOficina);
		
		//Tipo comisionista
		VendedorDTO[] arrayTipoComisionista = delegate.getListTiposComisionistas();
		datosVentaForm.setArrayTipoComisionista(arrayTipoComisionista);
		
		//Cuotas
		NumeroCuotasListOutDTO arrayCuotas= delegate.listarCuotas();
		datosVentaForm.setArrayCuotas(arrayCuotas.getallNumeroCuotasDTO());
		
		//Distribuidor  DWR
		
		//Vendedor  --DWR
		
		//Tipo Contrato --DWR
		
		//Modalidad de venta  -- DWR
		
		//Periodo  -- DWR
		
		//Obtencion Datos por Defecto Oficina Vendedor
		String user = ((ParametrosGlobalesDTO)sesion.getAttribute("paramGlobal")).getCodUsuario();
		usuarioSCL.setUsuario(user);
		respuesta=delegate.validaUsuarioSinPerfil(usuarioSCL);
		datosVentaForm.setIndBusquedaVendedor(global.getValor("codigo.vendedor.uno"));
		if (respuesta.getCodigoVendedor()==(Long.valueOf(global.getValor("codigo.vendedor.cero")).longValue())) {
			datosVentaForm.setIndBusquedaVendedor(global.getValor("codigo.vendedor.cero"));
		}else{
			datosVentaForm.setCodOficina(respuesta.getCodigoOficina());
	        datosVentaForm.setCodTipoComisionista(respuesta.getCodTipcomis());
				
			VendedorDTO[] vendedores = datosVentaForm.getArrayTipoComisionista();
			for(int i=0; i<vendedores.length;i++){
				if (vendedores[i].getCodTipComisionista().equals(respuesta.getCodTipcomis())){
					logger.debug("tipoComisionista.IndVtaExterna"+vendedores[i].getIndVtaExterna());
					IndVtaExterna=(String.valueOf(vendedores[i].getIndVtaExterna()));
					break;
				}
			}
	        //Verificar Estado Vendedor
			
			/* P-CSR-11002 JLGN 14-10-2011
			if (("0").equals(IndVtaExterna)){
				entrada.setCodigoVendedor(new Long(respuesta.getCodigoVendedor()).toString());
				estadoVendedor=delegate.verificaEstadoVendedor(entrada);
				if (estadoVendedor==false)
				{
				//Se informa a la interfaz que vendedor se encuentra bloqueado
				datosVentaForm.setIndBloqueoVendedor("B");//bloqueado por otra sesion
				}
				else
				{
				//Se bloquea el Vendedor.
				entrada.setCodigoAccionBloqueo("B");
	            delegate.bloqueaDesbloqueaVendedor(entrada);
	            datosVentaForm.setIndBloqueoVendedor("BS");//bloqueado por sesion actual
				}
	        } */
			
			
			datosVentaForm.setCodDistribuidor(new Long (respuesta.getCodigoVendedor()).toString());
			datosVentaForm.setCodDistribuidorSeleccionado(new Long (respuesta.getCodigoVendedor()).toString());
			datosVentaForm.setIndVtaExterna(IndVtaExterna);
		}
		
		//(-)-- Carga de listas --
		
		
		//Obtiene numero de venta y numero de transaccion de venta
		CabeceraArchivoCOLDTO cabecera = new CabeceraArchivoCOLDTO();
		CabeceraArchivoDTO cabeceraPV = delegate.getParametrosVenta(cabecera);
		datosVentaForm.setNumeroVenta(cabeceraPV.getNumeroVenta());
		datosVentaForm.setNumeroTransaccionVenta(cabeceraPV.getNumeroTransaccionVenta());
		
		//parametro prepago
		datosVentaForm.setCodTipoClientePrepago(global.getValor("tipo.cliente.prepago"));
		
		aplicarFacturaTercero(datosVentaForm);
		
		logger.info("inicio, fin");
		return mapping.findForward("inicio");
	}
	
	//Inicio P-CSR-11002 JLGN 16-05-2011
	public ActionForward inicio2(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.info("inicio2, inicio");
		request.getSession().setAttribute("noExisteClienteBuro", "false");
		request.getSession().setAttribute("unaLineaBuro", "false");
		logger.info("inicio2, fin");
		return mapping.findForward("inicio2");
	}
	//Fin P-CSR-11002 JLGN 16-05-2011
	
	/**
	 * @author JIB
	 * @param datosVentaForm
	 * Se configura en la operadora mostrar o no los campos de factura a nombre de tercero.
	 * Incidencia: 130601.
	 */
	private void aplicarFacturaTercero(DatosVentaForm datosVentaForm) {
		logger.info("aplicarFacturaTercero, inicio");
		String valorAplicaFacturaTercero = "1";
		final String claveAplicaFacturaTercero = "modulo.web.solicitud.venta.aplica.factura.tercero";
		try {
			valorAplicaFacturaTercero = global.getValorExterno(claveAplicaFacturaTercero).trim();
			logger.info("valorAplicaFacturaTercero: " + valorAplicaFacturaTercero);
		}
		catch (NullPointerException e) {
			logger.error("Error al obtener valor de properties: " + claveAplicaFacturaTercero);
			logger.error(e.getMessage());
		}
		logger.info("aplicarFacturaTercero, fin");
		datosVentaForm.setAplicaFacturaTercero(valorAplicaFacturaTercero);
	}
	
	public ActionForward recargar(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.info("recargar, inicio");
		logger.info("recargar, fin");
		return mapping.findForward("inicio");
	}
	//---------- (+) buscar cliente ---------------------//
	public ActionForward buscarCliente(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		logger.info("buscarCliente, inicio");
		logger.info("buscarCliente, fin");
		
		return mapping.findForward("buscarCliente");
	}	
	
	public ActionForward cargarCliente(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		logger.info("cargarCliente, inicio");
		DatosVentaForm datosVentaForm = (DatosVentaForm)form;
		HttpSession sesion = request.getSession(false);
		
		if (sesion.getAttribute("clienteSel")!=null){
			ClienteAjaxDTO clienteSel = (ClienteAjaxDTO)sesion.getAttribute("clienteSel");
			datosVentaForm.setCodTipoCliente(clienteSel.getTipoCliente());
			datosVentaForm.setGlsTipoCliente(clienteSel.getGlsTipoCliente());
			datosVentaForm.setCodCliente(clienteSel.getCodigoCliente());
			datosVentaForm.setCodCrediticia(clienteSel.getCodCrediticia());
			datosVentaForm.setMontoPreAutorizado(clienteSel.getMontoPreAutorizado());
			datosVentaForm.setCodCalificacionCliente(clienteSel.getCodCalificacion());
		}
		logger.info("cargarCliente, fin");
		return mapping.findForward("inicio");
	}
	
	public ActionForward cancelarCliente(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.info("cancelarCliente, inicio");
		logger.info("cancelarCliente, fin");
		return mapping.findForward("inicio");
	}	
	//---------- (-) buscar cliente ---------------------//
	
	//---------- (+) alta cliente ---------------------//
	public ActionForward altaCliente(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.info("altaCliente, inicio");
		String forward = "altaCliente";
		logger.info("altaCliente, fin");
		
		//String forward = "altaCliente";
		return mapping.findForward(forward);
	}
	
	public ActionForward cargarClienteAlta(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.info("cargarClienteAlta, inicio");
		DatosVentaForm datosVentaForm = (DatosVentaForm)form;
		HttpSession sesion = request.getSession(false);
		if (sesion.getAttribute("clienteAlta")!=null){
			ClienteAltaDTO clienteAlta = (ClienteAltaDTO)sesion.getAttribute("clienteAlta");
			ClienteAjaxDTO clienteSel = new ClienteAjaxDTO();
			String glsTipoCliente = "";
			if (clienteAlta.getCodigoTipoCliente().equals(global.getValor("tipo.cliente.empresa"))){
				glsTipoCliente = "EMPRESA";
			}else if (clienteAlta.getCodigoTipoCliente().equals(global.getValor("tipo.cliente.particular"))){
				glsTipoCliente = "PARTICULAR";
			}else if  (clienteAlta.getCodigoTipoCliente().equals(global.getValor("tipo.cliente.prepago"))){
				glsTipoCliente = "PREPAGO";
			}else if  (clienteAlta.getCodigoTipoCliente().equals(global.getValor("tipo.cliente.pyme"))){
				glsTipoCliente = "PYME";
			}
			
			clienteSel.setTipoCliente(clienteAlta.getCodigoTipoCliente());
			clienteSel.setGlsTipoCliente(glsTipoCliente);	
			clienteSel.setCodigoCliente(clienteAlta.getCodigoCliente());
			clienteSel.setCodCrediticia(clienteAlta.getCodCrediticia());
			clienteSel.setMontoPreAutorizado(0);
			clienteSel.setCodigoTipoIdentificacion(clienteAlta.getCodigoTipoIdentificacion());
			clienteSel.setNumeroIdentificacion(clienteAlta.getNumeroIdentificacion());
			clienteSel.setNombreCliente(clienteAlta.getNombreCliente());
			clienteSel.setNombreApellido1(clienteAlta.getNombreApellido1());
			clienteSel.setNombreApellido2(clienteAlta.getNombreApellido2());
			clienteSel.setNumeroTelefono1(clienteAlta.getNumeroTelefono1());
			clienteSel.setCodCalificacion(clienteAlta.getCodCalificacion());
			
			datosVentaForm.setCodTipoCliente(clienteSel.getTipoCliente());
			datosVentaForm.setGlsTipoCliente(clienteSel.getGlsTipoCliente());
			datosVentaForm.setCodCliente(clienteSel.getCodigoCliente());
			datosVentaForm.setCodCrediticia(clienteSel.getCodCrediticia());
			datosVentaForm.setMontoPreAutorizado(clienteSel.getMontoPreAutorizado());
			datosVentaForm.setCodCalificacionCliente(clienteSel.getCodCalificacion());
			
			//obtiene descripcion de color y segmento
			BusquedaClienteDTO paramBusquedaDTO = new BusquedaClienteDTO();
			paramBusquedaDTO.setCodCliente(clienteAlta.getCodigoCliente());
			ClienteDTO[] listaClientes = delegate.getDatosCliente(paramBusquedaDTO);
			if (listaClientes!=null && listaClientes.length>0){
				clienteSel.setDescripcionColor(listaClientes[0].getDescripcionColor());
				clienteSel.setDescripcionSegmento(listaClientes[0].getDescripcionSegmento());
			}
			
			sesion.setAttribute("clienteSel", clienteSel);
			

		}
		logger.info("cargarClienteAlta, fin");
		return mapping.findForward("inicio");
	}
	
	public ActionForward cancelarAltaCliente(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("cancelarAltaCliente, inicio");
		DatosVentaForm datosVentaForm = (DatosVentaForm) form;
		HttpSession sesion = request.getSession(false);
		if (sesion.getAttribute("clienteSel") != null) {
			logger.trace("clienteSel != null");
			ClienteAjaxDTO clienteSel = (ClienteAjaxDTO) sesion.getAttribute("clienteSel");
			datosVentaForm.setCodTipoCliente(clienteSel.getTipoCliente());
			datosVentaForm.setGlsTipoCliente(clienteSel.getGlsTipoCliente());
			datosVentaForm.setCodCliente(clienteSel.getCodigoCliente());
			datosVentaForm.setCodCrediticia(clienteSel.getCodCrediticia());
			logger.trace("datosVentaForm.getCodCrediticia(): " + datosVentaForm.getCodCrediticia());
			datosVentaForm.setMontoPreAutorizado(clienteSel.getMontoPreAutorizado());
			datosVentaForm.setCodCalificacionCliente(clienteSel.getCodCalificacion());
		}
		logger.info("cancelarAltaCliente, fin");
		return mapping.findForward("inicio");
	}	
	
	//---------- (-) alta cliente ---------------------//
	
	public ActionForward ingresarDatosTercero(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.info("ingresarDatosTercero, inicio");
		logger.info("ingresarDatosTercero, fin");		
		return mapping.findForward("ingresarDatosTercero");
	}
	
	public ActionForward aceptarDatosTercero(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.info("aceptarDatosTercero, inicio");
		
		DatosVentaForm datosVentaForm = (DatosVentaForm)form;
		datosVentaForm.setFlagFacturacionTercero("1");
		
		logger.info("aceptarDatosTercero, fin");		
		return mapping.findForward("inicio");
	}
	
	public ActionForward ingresarDatosLinea(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		logger.info("ingresarDatosLinea, inicio");
		try{
			DatosVentaForm f = (DatosVentaForm) form;
			logger.debug("f.getCodDistribuidor() [" + f.getCodDistribuidor() + "]");
			logger.debug("f.getCodVendedor() [" + f.getCodVendedor() + "]");
			logger.info("ingresarDatosLinea, fin");
			
			//Inicio P-CSR-11002 JLGN 11-05-2011
			DireccionDTO direccionDTO = null;
			direccionDTO = delegate.getDatosDireccion(direccionDTO);
			
			for(int x=0; x< direccionDTO.getConceptoDireccionDTOs().length;x++){
				if(direccionDTO.getConceptoDireccionDTOs()[x].getCodigoConcepto() == 0){
					logger.debug("Obtuvo Provincia");
					request.getSession().setAttribute("provinciaVenta", direccionDTO.getConceptoDireccionDTOs()[x].getCaption());
				}
				if(direccionDTO.getConceptoDireccionDTOs()[x].getCodigoConcepto() == 1){
					logger.debug("Obtuvo Canton");
					request.getSession().setAttribute("cantonVenta", direccionDTO.getConceptoDireccionDTOs()[x].getCaption());
				}
				if(direccionDTO.getConceptoDireccionDTOs()[x].getCodigoConcepto() == 2){
					logger.debug("Obtuvo Distrito");
					request.getSession().setAttribute("distritoVenta", direccionDTO.getConceptoDireccionDTOs()[x].getCaption());
				}
			}
			//Inicio P-CSR-11002 JLGN 17-05-2011
			logger.debug("CodTipoCliente: "+ f.getCodTipoCliente());
			logger.debug("CodTipoClienteprepago: "+ f.getCodTipoClientePrepago());
			
			if (!f.getCodTipoCliente().equals(f.getCodTipoClientePrepago())){
				//No es Prepago
				logger.debug("No es Prepago");
				request.getSession().setAttribute("esPrepagoBuro", "true");
				String numIdent = "";
				String tipIdent = "";
				logger.debug("Codigo Cliente: "+ f.getCodCliente());
				logger.debug("Se obtiene datos del Cliente");
				ClienteDTO clienteDTO = null;
				clienteDTO = delegate.getDatosCliente(f.getCodCliente());
				numIdent = clienteDTO.getNumeroIdentificacion();
				tipIdent = clienteDTO.getCodigoTipoIdentificacion();
				logger.debug("Numero Identificacion: "+ numIdent);
				logger.debug("Tipo Identificacion: "+ tipIdent);			
				
				DatosClienteBuroDTO buroDTO = null;
				String tipoEstudio = "CGB";
				String desTipIdent = "";
				
				//Valida el tipo de identificacion que se le deba pasar a la URL
				if (tipIdent.equals("01")){
					desTipIdent = "CED";
				}else if (tipIdent.equals("02")){
					desTipIdent = "JUR";
				}else if (tipIdent.equals("03")){
					desTipIdent = "RES";
				}else if (tipIdent.equals("04")){
					desTipIdent = "PAS";
				}
				
				//MA-184592 JLGN 15-05-2012
				String usuario = (String)request.getSession().getAttribute("nombreUsuarioSCL");
				
				buroDTO = delegate2.consultaBuro(numIdent, desTipIdent, tipoEstudio, usuario);
				
				//Inicio Inc.179734 04-01-2012 JLGN
				//1º se valida el tipo de identificacion del cliente es Redidencia o Empresa
				//logger.debug("1º se valida el tipo de identificacion del cliente es Redidencia o Empresa");
				//if(desTipIdent.trim().equals("RES") || desTipIdent.trim().equals("JUR")){
					//2º Se valida si Cliente tiene mensaje de Error
					logger.debug("2º Se valida si Cliente tiene mensaje de Error");
					if(buroDTO.getFlagDDA().equals("true")){
						//3ºSe valida la forma de Pago del cliente
						logger.debug("3ºSe valida la forma de Pago del cliente");
						if(!delegate2.validaClienteDDA(f.getCodCliente())){
							logger.debug("Cliente no tiene Domiciliacián Automatica, se debe Ejecutar la OOSS Modificación Datos Bancarios del Cliente y luego realizar la Venta.");
							request.setAttribute("mensajeError", "Cliente no tiene Domiciliacián Automatica, se debe Ejecutar la OOSS Modificación Datos Bancarios del Cliente " +
																 "y luego realizar la Venta.");		        	
				        	return mapping.findForward("inicio");
						}else{
							//4º Se valida si el cliente tiene mas de 3 lineas contratadas
							logger.debug("4º Se valida si el cliente tiene mas de 3 lineas contratadas");
							if(!delegate2.validaLineasClienteDDA(tipIdent, numIdent)){
								logger.debug("No se puede activar más líneas por tener restricción del Buró y pago con Débito Automático");
								request.setAttribute("mensajeError", "No se puede activar más líneas por tener restricción del Buró y pago con Débito Automático");		        	
					        	return mapping.findForward("inicio");
							}	
							
							request.setAttribute("mensajeError", "Cliente puede contratar solo a una linea por tener restricción del Buró y pago con Débito Automático");
							//Se utiliza para ocultar el limite de credito y la calificacion 
							request.getSession().setAttribute("esPrepagoBuro", "false");
							//Se obtiene LC por defecto 
							logger.debug("5º Se obtiene LC por defecto");
							DatosGeneralesDTO lcDefecto = new DatosGeneralesDTO();			
							lcDefecto.setCodigoModulo(global.getValor("codigo.modulo.VE"));
							lcDefecto.setCodigoProducto(global.getValor("codigo.producto"));
							lcDefecto.setCodigoParametro(global.getValor("parametro.lc.defecto"));			
							lcDefecto = delegate2.getValorParametro(lcDefecto);							
							buroDTO.setLimiteDeCredito(lcDefecto.getValorParametro());	
							
							//Se obtiene Calificacion para los Clientes que no existen en Buro
							logger.debug("6º Se obtiene Calificacion para los Clientes que no existen en Buro");
							DatosGeneralesDTO calificacionDefecto = new DatosGeneralesDTO();			
							calificacionDefecto.setCodigoModulo(global.getValor("codigo.modulo.VE"));
							calificacionDefecto.setCodigoProducto(global.getValor("codigo.producto"));
							calificacionDefecto.setCodigoParametro(global.getValor("parametro.calificacion.defecto"));			
							calificacionDefecto = delegate2.getValorParametro(calificacionDefecto);							
							buroDTO.setResulCalificacion(calificacionDefecto.getValorParametro());
						}						
					}					
    			//}
				//Fin Inc.179734 04-01-2012 JLGN
				
				
				//Inicio P-CSR-11002 JLGN 01-07-2011
				long limConCliScl = 0;
				long auxLimCon = 0;
				limConCliScl = delegate2.obtineLimConsuCliente(numIdent, tipIdent);
				auxLimCon = (Long.parseLong(buroDTO.getLimiteDeCredito()) - limConCliScl);
				
				/*if(auxLimCon < 0){
					buroDTO.setLimiteDeCredito("0");					
				}else{
					buroDTO.setLimiteDeCredito(String.valueOf(auxLimCon));
				}*/				
				
				buroDTO.setLimiteDeCredito(String.valueOf(auxLimCon));
				//Fin P-CSR-11002 JLGN 01-07-2011
				//Inicio Inc.179734 04-01-2012 JLGN
				request.getSession().setAttribute("tipIdentDDA", tipIdent);
				request.getSession().setAttribute("numIdentDDA", numIdent);
				//Fin Inc.179734 04-01-2012 JLGN
				request.getSession().setAttribute("datosClienteBuro2", buroDTO);		
				request.getSession().setAttribute("noExisteClienteBuro", "false");
				request.getSession().setAttribute("unaLineaBuro", "false");
				request.getSession().setAttribute("flagConsultaCalificacion", "false");
			}else{
				//Es Prepago
				logger.debug("Es Prepago");
				DatosGeneralesDTO entrada = new DatosGeneralesDTO();			
				entrada.setCodigoModulo(global.getValor("codigo.modulo.GE"));
				entrada.setCodigoProducto(global.getValor("codigo.producto"));
				entrada.setCodigoParametro(global.getValor("parametro.calificacion"));			
				logger.debug("Obtiene Calificacion por Default");
				entrada = delegate2.getValorParametro(entrada);	
				logger.debug("Valor de Calificacion: "+entrada.getValorParametro());	
				DatosClienteBuroDTO buroDTO = new DatosClienteBuroDTO();
				//Inicio Inc.179734 04-01-2012 JLGN
				buroDTO.setFlagDDA("false");
				//Fin Inc.179734 04-01-2012 JLGN
				buroDTO.setResulCalificacion(entrada.getValorParametro());
				//Inicio Inc.179734 04-01-2012 JLGN
				request.getSession().setAttribute("tipIdentDDA", "");
				request.getSession().setAttribute("numIdentDDA", "");
				//Fin Inc.179734 04-01-2012 JLGN
				request.getSession().setAttribute("datosClienteBuro2", buroDTO);
				request.getSession().setAttribute("noExisteClienteBuro", "false");
				request.getSession().setAttribute("unaLineaBuro", "false");
				request.getSession().setAttribute("flagConsultaCalificacion", "false");		
				request.getSession().setAttribute("esPrepagoBuro", "false");
			}
			//Fin P-CSR-11002 JLGN 17-05-2011
		}catch(AltaClienteException e){
			String men3 = e.getDescripcionEvento();
			String codError = e.getCodigo();
			long numEvento = e.getCodigoEvento(); //--> 1 = Cliente no existe en Buro, 2 = Cliente Bloqueado en Buro
			if(codError.equals("1001")){ // Cliente Bloqueado o no Existe en Buro
				if(numEvento == 1){				
					request.setAttribute("mensajeError", "Ocurrio un error al Consultar Cliente en Buro, "+men3);        	
					logger.debug("Ocurrio un error al Consultar Cliente en Buro, "+men3);
					
					DatosGeneralesDTO entrada = new DatosGeneralesDTO();			
					entrada.setCodigoModulo(global.getValor("codigo.modulo.GE"));
					entrada.setCodigoProducto(global.getValor("codigo.producto"));
					entrada.setCodigoParametro(global.getValor("parametro.calificacion"));			
					logger.debug("Obtiene Calificacion por Default");
					entrada = delegate2.getValorParametro(entrada);	
					logger.debug("Valor de Calificacion: "+entrada.getValorParametro());	
					DatosClienteBuroDTO buroDTO = new DatosClienteBuroDTO();
					buroDTO.setResulCalificacion(entrada.getValorParametro());
					request.getSession().setAttribute("datosClienteBuro2", buroDTO);
					//Inicio Inc.179734 04-01-2012 JLGN
					request.getSession().setAttribute("tipIdentDDA", "");
					request.getSession().setAttribute("numIdentDDA", "");
					//Fin Inc.179734 04-01-2012 JLGN
					request.getSession().setAttribute("noExisteClienteBuro", "true");
					request.getSession().setAttribute("unaLineaBuro", "true");
					request.getSession().setAttribute("flagConsultaCalificacion", "false");
					request.getSession().setAttribute("esPrepagoBuro", "false");
					return mapping.findForward("ingresarDatosLinea");
					//return mapping.findForward("inicio");
				}else if (numEvento == 2){
					request.setAttribute("mensajeError", "Ocurrio un error al Consultar Cliente en Buro, "+men3);        	
					logger.debug("Ocurrio un error al Consultar Cliente en Buro, "+men3);
					
					DatosGeneralesDTO entrada = new DatosGeneralesDTO();			
					entrada.setCodigoModulo(global.getValor("codigo.modulo.GE"));
					entrada.setCodigoProducto(global.getValor("codigo.producto"));
					entrada.setCodigoParametro(global.getValor("parametro.calificacion"));			
					logger.debug("Obtiene Direccion por Default");
					entrada = delegate2.getValorParametro(entrada);	
					logger.debug("Valor de Direccion: "+entrada.getValorParametro());	
					DatosClienteBuroDTO buroDTO = new DatosClienteBuroDTO();
					buroDTO.setResulCalificacion(entrada.getValorParametro());
					request.getSession().setAttribute("datosClienteBuro2", buroDTO);	
					//Inicio Inc.179734 04-01-2012 JLGN
					request.getSession().setAttribute("tipIdentDDA", "");
					request.getSession().setAttribute("numIdentDDA", "");
					//Fin Inc.179734 04-01-2012 JLGN
					request.getSession().setAttribute("noExisteClienteBuro", "true");
					request.getSession().setAttribute("unaLineaBuro", "true");
					request.getSession().setAttribute("flagConsultaCalificacion", "false");
					return mapping.findForward("ingresarDatosLinea");
					//return mapping.findForward("inicio");
				}	
			}else if (codError.equals("1002")){	
				//No Existe conexion con Buro
				request.setAttribute("mensajeError", "Ocurrio un error al Consultar Cliente en Buro, "+men3+", la venta tendrá que posponerse o se debera cambiar a Prepago");
	        	logger.debug("Ocurrio un error al Consultar Cliente en Buro, "+men3+", la venta tendrá que posponerse o se debera cambiar a Prepago");
	        	return mapping.findForward("inicio");
			}else if (codError.equals("1003")){//Inicio P-CSR-11002 JLGN 09-08-2011	
				//Tag Cod_mensaje de Buro es distinto a 0
				request.setAttribute("mensajeError", "Cliente con problemas en Buro, "+men3);
	        	logger.debug("Cliente con problemas en Buro, "+men3);
	        	return mapping.findForward("inicio");			
	        	//Fin P-CSR-11002 JLGN 09-08-2011
			}else if (codError.equals("1004")){//Inicio Inc.179734 JLGN 09-01-2012
				//Inicio Inc.179734 09-01-2012 JLGN
				//1ºSe valida la forma de Pago del cliente
				DatosVentaForm f = (DatosVentaForm) form;
				ClienteDTO clienteDTO = null;
				clienteDTO = delegate.getDatosCliente(f.getCodCliente());
				String numIdent = clienteDTO.getNumeroIdentificacion();
				String tipIdent = clienteDTO.getCodigoTipoIdentificacion();
				DatosClienteBuroDTO buroDTO = new DatosClienteBuroDTO();
				
				logger.debug("1ºSe valida la forma de Pago del cliente");
				if(!delegate2.validaClienteDDA(f.getCodCliente())){
					logger.debug("Cliente no tiene Domiciliacián Automatica, se debe Ejecutar la OOSS Modificación Datos Bancarios del Cliente y luego realizar la Venta.");
					request.setAttribute("mensajeError", "Cliente no tiene Domiciliacián Automatica, se debe Ejecutar la OOSS Modificación Datos Bancarios del Cliente " +
														 "y luego realizar la Venta.");		        	
				   	return mapping.findForward("inicio");
				}else{
					//2º Se valida si el cliente tiene mas de 3 lineas contratadas
					logger.debug("2º Se valida si el cliente tiene mas de 3 lineas contratadas");
					if(!delegate2.validaLineasClienteDDA(tipIdent, numIdent)){
						logger.debug("No se puede activar más líneas por tener restricción del Buró y pago con Débito Automático");
						request.setAttribute("mensajeError", "No se puede activar más líneas por tener restricción del Buró y pago con Débito Automático");		        	
					    return mapping.findForward("inicio");
					}								
					//Se obtiene LC por defecto 
					logger.debug("3º Se obtiene LC por defecto");
					DatosGeneralesDTO lcDefecto = new DatosGeneralesDTO();			
					lcDefecto.setCodigoModulo(global.getValor("codigo.modulo.VE"));
					lcDefecto.setCodigoProducto(global.getValor("codigo.producto"));
					lcDefecto.setCodigoParametro(global.getValor("parametro.lc.defecto"));			
					lcDefecto = delegate2.getValorParametro(lcDefecto);							
					buroDTO.setLimiteDeCredito(lcDefecto.getValorParametro());	
							
					//Se obtiene Calificacion para los Clientes que no existen en Buro
					logger.debug("4º Se obtiene Calificacion para los Clientes que no existen en Buro");
					DatosGeneralesDTO calificacionDefecto = new DatosGeneralesDTO();			
					calificacionDefecto.setCodigoModulo(global.getValor("codigo.modulo.VE"));
					calificacionDefecto.setCodigoProducto(global.getValor("codigo.producto"));
					calificacionDefecto.setCodigoParametro(global.getValor("parametro.calificacion.defecto"));			
					calificacionDefecto = delegate2.getValorParametro(calificacionDefecto);							
					buroDTO.setResulCalificacion(calificacionDefecto.getValorParametro());
					buroDTO.setFlagDDA("true");
				}											
				long limConCliScl = 0;
				long auxLimCon = 0;
				limConCliScl = delegate2.obtineLimConsuCliente(numIdent, tipIdent);
				auxLimCon = (Long.parseLong(buroDTO.getLimiteDeCredito()) - limConCliScl);
				buroDTO.setLimiteDeCredito(String.valueOf(auxLimCon));			
				request.getSession().setAttribute("tipIdentDDA", tipIdent);
				request.getSession().setAttribute("numIdentDDA", numIdent);
				request.getSession().setAttribute("datosClienteBuro2", buroDTO);		
				request.getSession().setAttribute("noExisteClienteBuro", "false");
				request.getSession().setAttribute("unaLineaBuro", "false");
				request.getSession().setAttribute("flagConsultaCalificacion", "false");
				
				return mapping.findForward("ingresarDatosLinea");
				//Fin Inc.179734 JLGN 09-01-2012
			}else{
				request.setAttribute("mensajeError", "Ocurrio un error al Consultar Cliente en Buro, "+men3);        	
				logger.debug("Ocurrio un error al Consultar Cliente en Buro, "+men3);
				return mapping.findForward("inicio");
			}	
		}catch(Exception e){
        	request.setAttribute("mensajeError", "Ocurrio un error al Consultar Cliente en Buro, Se debe realizar nuevamente la consulta");
			request.getSession().setAttribute("flagDataBuro", "false");
        	logger.debug("Ocurrio un error al Validar Cliente en Buro, Se debe realizar nuevamente la consulta");
            return mapping.findForward("inicio");        	
		}		
		//Fin P-CSR-11002 JLGN 11-05-2011
		return mapping.findForward("ingresarDatosLinea");
	}
	
	public ActionForward ingresarDatosSolScoring(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		logger.info("ingresarDatosSolScoring, inicio");
		logger.info("ingresarDatosSolScoring, fin");
		return mapping.findForward("ingresarDatosSolScoring");
	}
	
	public ActionForward irAMenu(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		logger.debug("irAMenu, inicio");
		//desbloquear vendedor
		DatosVentaForm datosVentaForm = (DatosVentaForm)form;
		if (!datosVentaForm.getCodDistribuidor().equals("")){
			if (datosVentaForm.getIndBloqueoVendedor().equals("BS")){
				VendedorDTO entrada= new VendedorDTO();
				entrada.setCodigoVendedor(datosVentaForm.getCodDistribuidor());
				entrada.setCodigoAccionBloqueo(global.getValor("accion.desbloqueo.vendedor"));
				delegate.bloqueaDesbloqueaVendedor(entrada);
			}
		}
		
		limpiarSesion(datosVentaForm, request);
		logger.debug("irAMenu, fin");
		
		return mapping.findForward("irAMenu");
	}
	private void limpiarSesion(DatosVentaForm datosVentaForm, HttpServletRequest request){
		logger.debug("limpiarSesion, inicio");
		
		HttpSession sesion = request.getSession(false);
		
		sesion.removeAttribute("BuscaClienteForm");
		sesion.removeAttribute("DatosLineaForm");
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
		sesion.removeAttribute("resultadoSolVenta");
		sesion.removeAttribute("NumerosCortosSMSForm");
		
		
		//datosVentaForm.setCodCalificacionCliente("");
		datosVentaForm.setCodCliente("");
		datosVentaForm.setCodCrediticia("");
		datosVentaForm.setCodDistribuidor("");
		datosVentaForm.setCodDistribuidorSeleccionado("");
		datosVentaForm.setCodModalidadVenta("");
		datosVentaForm.setCodModalidadVentaSeleccionada("");
		datosVentaForm.setCodOficina("");
		datosVentaForm.setCodPeriodo("");
		datosVentaForm.setCodPeriodoSeleccionado("");
		datosVentaForm.setCodTipoCliente("");
		datosVentaForm.setCodTipoClientePrepago("");
		datosVentaForm.setCodTipoComisionista("");
		datosVentaForm.setCodTipoContrato("");
		datosVentaForm.setCodTipoContratoSeleccionado("");
		datosVentaForm.setCodVendedor("");
		datosVentaForm.setCodVendedorSeleccionado("");
		datosVentaForm.setFacturaTercero("");
		datosVentaForm.setFlagFacturacionTercero("0");
		datosVentaForm.setGlsTipoCliente("");
		datosVentaForm.setIndBloqueoVendedor("");
		datosVentaForm.setIndVtaExterna("");
		datosVentaForm.setMontoPreAutorizado(0);
		datosVentaForm.setNumCuotas("");
		datosVentaForm.setNumCuotasSeleccionado("");
		datosVentaForm.setNumeroTransaccionVenta(0);
		datosVentaForm.setNumeroVenta(0);
		
		logger.debug("limpiarSesion, fin");
	}
	
	
	
}
