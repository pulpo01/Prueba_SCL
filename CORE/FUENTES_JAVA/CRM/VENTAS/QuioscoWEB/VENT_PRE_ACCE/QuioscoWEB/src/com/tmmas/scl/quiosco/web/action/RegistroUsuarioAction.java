package com.tmmas.scl.quiosco.web.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.rpc.ServiceException;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.WSCentralQuioscoOutDTO;
import com.tmmas.cl.scl.spnsclws.pa.SpnSclWS;
import com.tmmas.cl.scl.spnsclws.pa.SpnSclWSService;
import com.tmmas.cl.scl.spnsclws.pa.SpnSclWSService_Impl;
import com.tmmas.cl.scl.spnsclwscommon.quiosco.dto.WsStructuraComercialOutDTO;
import com.tmmas.cl.scl.spnsclwscommon.quiosco.dto.WsStructuraLineaDTO;
import com.tmmas.cl.scl.spnsclwscommon.quiosco.dto.WsStructuraPagoDTO;
import com.tmmas.cl.scl.spnsclwscommon.quiosco.dto.WsStructuraSimcardDTO;
import com.tmmas.cl.scl.spnsclwscommon.quiosco.dto.WsStructuraTerminalDTO;
import com.tmmas.cl.scl.spnsclwscommon.quiosco.dto.WsStructuraUsuarioLineaDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.DatosClienteDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsTiendaVendedorOutDTO;
import com.tmmas.scl.quiosco.web.VO.AccesorioVO;
import com.tmmas.scl.quiosco.web.VO.LineaVO;
import com.tmmas.scl.quiosco.web.altaLinea.AltaLinea;
import com.tmmas.scl.quiosco.web.form.RegistroUsuarioForm;

/*import dto.businessobject.gestiondeabonados.scl.cl.tmmas.com.WSCentralQuioscoOutDTO;
import dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.DatosClienteDTO;
import dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.WsTiendaVendedorOutDTO;
import dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraComercialOutDTO;
import dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraLineaDTO;
import dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraPagoDTO;
import dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraSimcardDTO;
import dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraTerminalDTO;
import dto.quiosco.spnsclwscommon.scl.cl.tmmas.com.WsStructuraUsuarioLineaDTO;
*/

public class RegistroUsuarioAction extends Action {
	/**
	 * 
	 */
	private Logger logger = Logger.getLogger(this.getClass());
	
	private static final long serialVersionUID = 1L;

	public ActionForward execute(ActionMapping mapping, ActionForm p_form, HttpServletRequest request, HttpServletResponse response) throws InterruptedException, ServiceException{
		RegistroUsuarioForm form = (RegistroUsuarioForm) p_form;
		String target=new String();
		CompositeConfiguration config;
		config = UtilProperty.getConfigurationfromExternalFile("propiedadesQuioscoWEB.properties");
		UtilLog.setLog(config.getString("QuioscoWEB.log"));
		HttpSession session = request.getSession();
		DatosClienteDTO clienteDTO = (DatosClienteDTO)session.getAttribute("clienteRegistrado");
		WsTiendaVendedorOutDTO tiendaVendedorOutDTO = (WsTiendaVendedorOutDTO)session.getAttribute("tiendaVendedor");
		String usuarioPrincipal = (String)session.getAttribute("usuarioPrincipal");
		ArrayList<WsStructuraLineaDTO> listaStructura =(ArrayList<WsStructuraLineaDTO>) session.getAttribute("listaStructura");
		String url = config.getString("ruta.webservice");
		
		SpnSclWSService service = new SpnSclWSService_Impl(config.getString("ruta.webservice"));    
		SpnSclWS port = service.getSpnSclWSSoapPort();
		
		
		if(null==listaStructura){
			listaStructura = new ArrayList<WsStructuraLineaDTO>();
		}
		
		ArrayList<LineaVO> listaLineas = (ArrayList<LineaVO>)session.getAttribute("listaLineas");
		//LLamar el formulario de ingreso de usuarios
		if("registrarUsuario".equals(form.getAccionRegUsuario())){
			
			//Validar Formulario
			String error = null;
			
			if(null==form.getPrimerApellidoUsuario()||"".equals(form.getPrimerApellidoUsuario().trim()))
				error="Por favor ingrese un primer apellido para el usuario";
			
			if(null==form.getNomUsuario()||"".equals(form.getNomUsuario().trim()))
				error="Por favor ingrese un nombre para el usuario";
			
			if("seleccione".equals(form.getCodigoCentral()))
				error="Por favor seleccione una central";
			
					
			/*if(null==form.getEMailUsuario()||"".equals(form.getEMailUsuario().trim()))
				error="Por favor ingrese un mail para el usuario";
			
			if(null==form.getTelefonoContactoUsuario()||"".equals(form.getTelefonoContactoUsuario().trim()))
				error="Por favor ingrese un telefono de contacto para el usuario";*/

			if(null!=error){
				request.setAttribute("desError",error);
				target="globalError";
				return mapping.findForward(target);
			}
			
			
			WsStructuraLineaDTO structuraLineaDTO = new WsStructuraLineaDTO();
			
			

			
			//SETEO USUARIO PARA LA LINEA
			WsStructuraUsuarioLineaDTO usuarioLineaDTO = new WsStructuraUsuarioLineaDTO();
			usuarioLineaDTO.setNumeroIdentificacion(clienteDTO.getNumIdent());
			usuarioLineaDTO.setNombre(form.getNomUsuario());
			usuarioLineaDTO.setPrimerApellido(form.getPrimerApellidoUsuario());
			usuarioLineaDTO.setSegundoApellido(form.getSegundoApellidoUsuario());
			usuarioLineaDTO.setTipIdentificacion(clienteDTO.getCodigoTipIdentif());
			
				//AQUI SE AGREGARÁ El CODIGO CENTRAL SELECCIONADO AL DTO DE ALTA
				//Si el campo viene cero, es por que la serie es numerada		
			logger.error("CODIGO CENTRAL SELECCIONADO: "+form.getCodigoCentral());
			structuraLineaDTO.setCodigoCentral(form.getCodigoCentral());
			
			structuraLineaDTO.setUsuarioLinea(usuarioLineaDTO);
			WsStructuraSimcardDTO wsStructuraSimcardDTO = new WsStructuraSimcardDTO();
			
			wsStructuraSimcardDTO.setNumeroSerie(form.getSimcardUsuario());			
			structuraLineaDTO.setSimcard(wsStructuraSimcardDTO);
			
			WsStructuraTerminalDTO wsStructuraTerminal = new WsStructuraTerminalDTO();
			wsStructuraTerminal.setNumImei(form.getImeiUsuario());
			
			structuraLineaDTO.setTerminal(wsStructuraTerminal);
			
			
			
			listaStructura.add(structuraLineaDTO);
			session.setAttribute("listaStructura", listaStructura);
			
			int i;
			for(i=0;i<=listaLineas.size()-1;i++){
				if(!listaLineas.get(i).getEsOcupada().booleanValue()){
					request.setAttribute("lineaVO",listaLineas.get(i));
					listaLineas.get(i).setEsOcupada(new Boolean(true));
					session.setAttribute("listaLineas", listaLineas);
					
					if(null==listaLineas.get(i).getCelular()||"".equals(listaLineas.get(i).getCelular().trim())||"0".equals(listaLineas.get(i).getCelular())){
						//Listar Centrales
						try {
							//GetCentralesQuiosco getCentralesQuiosco = new GetCentralesQuiosco();
							
							WSCentralQuioscoOutDTO centrales =port.getCentralesQuiosco();
							
							
							
							request.setAttribute("centrales",centrales.getCentralDTOs());
							logger.error("centrales largo: "+centrales.getCentralDTOs().length);
							if(!"0".equals(centrales.getCodError())){
								request.setAttribute("desError",centrales.getMsgError());
								target="globalError";
								return mapping.findForward(target);								
							}
						}catch(Exception e) {
							request.setAttribute("desError","Error al intentar obtener centrales");
							target="globalError";
							return mapping.findForward(target);
						} 
					}
					
					
					target="formularioUsuario";
					return mapping.findForward(target);
				}
			}
			logger.error("********************INICIO TRAZADOR 157108**************************");
			//EJECUTO ALTA
			logger.error("********************ANTES SETEO ALTA DE LINEA**************************");
			AltaLinea altaLinea = new AltaLinea();
			logger.error("********************DESPUES SETEO ALTA DE LINEA**************************");
			
			logger.error("********************ANTES SETEO PAGO**************************");
			WsStructuraPagoDTO pagoDTO =(WsStructuraPagoDTO)session.getAttribute("pagoDTO");
			logger.error("********************DESPUES SETEO PAGO**************************");
			logger.error("********************ANTES SETEO LISTA ACCESORIOS **************************");
			ArrayList<AccesorioVO> listaAccesorios = (ArrayList<AccesorioVO>) session.getAttribute("listaAccesorios");
			logger.error("********************DESPUES SETEO LISTA ACCESORIOS **************************");
			
			String codPrestacion = (String) request.getSession().getAttribute("codPrestacion");
			logger.error("********************ANTES EJECUTAR ALTA DE LINEA**************************");
			WsStructuraComercialOutDTO structuraComercialOutDTO = altaLinea.altaLinea(clienteDTO, tiendaVendedorOutDTO, listaStructura, listaAccesorios,pagoDTO,usuarioPrincipal,null,codPrestacion);
			logger.error("********************DESPUES EJECUTAR ALTA DE LINEA**************************");
			
			if (structuraComercialOutDTO.getResultadoTransaccion()!= null){
				logger.error("RESULTADO ALTA LINEA : "+structuraComercialOutDTO.getResultadoTransaccion());
			}
			else {
				logger.error("ERROR EN ALTA DE LINEA");
			}
			
			if("0".equals(structuraComercialOutDTO.getResultadoTransaccion())){
				logger.error("********************EJECUTO BIEN ALTA LINEA**************************");
				logger.error("RESULTADO ALTA LINEA : "+structuraComercialOutDTO.getResultadoTransaccion());
				if(null==structuraComercialOutDTO.getPdfAsBytes()){
					request.setAttribute("sinFactura", "si");
				}else{
					request.setAttribute("sinFactura", "no");
					session.setAttribute("pdf",structuraComercialOutDTO.getPdfAsBytes());
				}
				System.out.println("VENTA: "+structuraComercialOutDTO.getNumVenta());
				if(null==structuraComercialOutDTO.getNumVenta()){
					structuraComercialOutDTO.setNumVenta("No es posible mostrar el número de venta en estos momentos");
				}
				request.setAttribute("ventaNumVenta", structuraComercialOutDTO.getNumVenta());
		        target="globalExitoVenta";
			}
			else{
				request.setAttribute("errores",structuraComercialOutDTO.getErrores());
				target="globalErrorAltaLinea";
			}

		}
		//Mato todas las sessiones menos los datos de la tienda y el usuario	
		//session.setAttribute("tiendaVendedor", null);
		//session.setAttribute("usuarioPrincipal", null);
		//session.setAttribute("tienda", null);
		//session.setAttribute("cajasDTO", null);
		session.setAttribute("listaLineas", null);
		session.setAttribute("clienteRegistrado", null);
		session.setAttribute("listaStructura", null);
		session.setAttribute("categorias", null);
		session.setAttribute("regiones", null);
		session.setAttribute("tiposIdentificacion",null);
		session.setAttribute("pagoDTO", null);	
		session.setAttribute("totalVO", null);	
		session.setAttribute("listaAccesorios", null);
		session.setAttribute("listaKit", null);
		session.setAttribute("codPrestacion", null);
		return mapping.findForward(target);	
		
		
	}

}
