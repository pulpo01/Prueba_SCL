package com.tmmas.scl.quiosco.web.action;

import java.rmi.RemoteException;
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

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.WSCentralQuioscoOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ClasificacionDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ValorClasificacionDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsClasificacionOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListadoCategoriaCambioDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.CiudadDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.ConceptoDireccionDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.DatosDireccionDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.ProvinciaDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.RegionDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.WsDatosDireccionOutDTO;
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
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.DireccionDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsTiendaVendedorOutDTO;
import com.tmmas.scl.quiosco.web.VO.AccesorioVO;
import com.tmmas.scl.quiosco.web.VO.LineaVO;
import com.tmmas.scl.quiosco.web.altaLinea.AltaLinea;
import com.tmmas.scl.quiosco.web.form.RegistroClienteForm;

public class RegistroClienteAction extends Action {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Logger logger = Logger.getLogger(this.getClass());
	CompositeConfiguration config;
	
	public RegistroClienteAction(){
		System.out.println("RegistroClienteAction:Start");
		config = UtilProperty.getConfigurationfromExternalFile("propiedadesQuioscoWEB.properties");
		UtilLog.setLog(config.getString("QuioscoWEB.log"));
		logger.error("RegistroClienteAction:End");
	}

	public ActionForward execute(ActionMapping mapping, ActionForm p_form, HttpServletRequest request, HttpServletResponse response) throws ServiceException, InterruptedException {
		RegistroClienteForm form = (RegistroClienteForm) p_form;
		String target=new String();
		
		SpnSclWSService service = new SpnSclWSService_Impl(config.getString("ruta.webservice"));    
		SpnSclWS port = service.getSpnSclWSSoapPort();
		
		HttpSession session = request.getSession();
		try {
		//LLamar el formulario de ingreso de usuarios
		if("registroFin".equals(form.getAccionRegCliente())){
			
			//Validar Formulario
			StringBuffer error = new StringBuffer();
			
			if(null==form.getCodCliente()||"".equals(form.getCodCliente().trim())||"0".equals(form.getCodCliente().trim())){
			
			if(form.getTipoIdentificacion().equals("seleccione"))
				error.append("Por favor seleccione un tipo de identificación para el cliente \\n");
			
			if(null==form.getNumeroIdentificacion()||"".equals(form.getNumeroIdentificacion().trim()))				
				error.append("Por favor ingrese un número de identificación \\n");
			
			if(null==form.getNombreCliente()||"".equals(form.getNombreCliente().trim()))
				error.append("Por favor ingrese un nombre para el cliente \\n");
			
			if(null==form.getPrimerApellido()||"".equals(form.getPrimerApellido().trim()))
				error.append("Por favor ingrese el primer apellido para el cliente \\n");
			
			if(form.getCategoria().equals("seleccione"))
				error.append("Por favor seleccione una categoria \\n");
			
			//P-CSR-11002
			if(form.getCategoriaCambio().equals("seleccione")){
				error.append("Por favor ingrese un tipo de Categoría Cambio\\n");
			}
			
			//CSR-11002
			//recorrer la coleccion de campos y validar solo aquellos que son obligatorios
			WsDatosDireccionOutDTO datosDireccion = (WsDatosDireccionOutDTO)session.getAttribute("datosDireccion");
			
			if(datosDireccion == null){
				
				datosDireccion = (WsDatosDireccionOutDTO)session.getAttribute("datosDireccion2");
				
			}
			
			ConceptoDireccionDTO[] conceptos = datosDireccion.getDireccionDTO().getConceptoDireccionDTOs();
			
			String valorVacio = null;
			String mensajeError = null;
			for (int i = 0; i < conceptos.length; i++) {
				
				ConceptoDireccionDTO conceptoDireccionDTO = conceptos[i];
				
				if("CMB".equals(conceptoDireccionDTO.getTipoControl())){
					valorVacio = "seleccione";
					mensajeError = "Por favor seleccione valor del campo ";
				}else if("TXT".equals(conceptoDireccionDTO.getTipoControl())){
					valorVacio = "";
					mensajeError = "Por favor ingrese valor al campo ";
				}

				if(conceptoDireccionDTO.getObligatoriedad()){
					
					if("COD_PROVINCIA".equals(conceptoDireccionDTO.getNombreColumna())){
						
						if(null==form.getProvincia() ||valorVacio.equals(form.getProvincia().trim())){
							error.append(mensajeError + conceptoDireccionDTO.getCaption() + " \\n");
						}
						
					}else if("COD_REGION".equals(conceptoDireccionDTO.getNombreColumna())){
						
						if(null==form.getRegion() ||valorVacio.equals(form.getRegion().trim())){
							error.append(mensajeError + conceptoDireccionDTO.getCaption() + " \\n");
						}
						
					}else if("COD_CIUDAD".equals(conceptoDireccionDTO.getNombreColumna())){
						
						if(null==form.getCiudad() ||valorVacio.equals(form.getCiudad().trim())){
							error.append(mensajeError + conceptoDireccionDTO.getCaption() + " \\n");
						}
						
					}else if("COD_COMUNA".equals(conceptoDireccionDTO.getNombreColumna())){
						
						if(null==form.getComuna() ||valorVacio.equals(form.getComuna().trim())){
							error.append(mensajeError + conceptoDireccionDTO.getCaption() + " \\n");
						}
						
					}else if("NOM_CALLE".equals(conceptoDireccionDTO.getNombreColumna())){
						
						if(null==form.getNombreCalle() ||valorVacio.equals(form.getNombreCalle().trim())){
							error.append(mensajeError + conceptoDireccionDTO.getCaption() + " \\n");
						}
					}else if("NUM_CALLE".equals(conceptoDireccionDTO.getNombreColumna())){
						if(null==form.getNumeroCalle() ||valorVacio.equals(form.getNumeroCalle().trim())){
							error.append(mensajeError + conceptoDireccionDTO.getCaption() + " \\n");
						}
					}else if("NUM_PISO".equals(conceptoDireccionDTO.getNombreColumna())){
						if(null==form.getNumPiso() ||valorVacio.equals(form.getNumPiso().trim())){
							error.append(mensajeError + conceptoDireccionDTO.getCaption() + " \\n");
						}
					}else if("NUM_CASILLA".equals(conceptoDireccionDTO.getNombreColumna())){
						if(null==form.getNumCasilla() ||valorVacio.equals(form.getNumCasilla().trim())){
							error.append(mensajeError + conceptoDireccionDTO.getCaption() + " \\n");
						}
					}else if("OBS_DIRECCION".equals(conceptoDireccionDTO.getNombreColumna())){
						if(null==form.getObsDireccion() ||valorVacio.equals(form.getObsDireccion().trim())){
							error.append(mensajeError + conceptoDireccionDTO.getCaption() + " \\n");
						}
					}else if("DES_DIREC1".equals(conceptoDireccionDTO.getNombreColumna())){
						if(null==form.getDesDirec1() ||valorVacio.equals(form.getDesDirec1().trim())){
							error.append(mensajeError + conceptoDireccionDTO.getCaption() + " \\n");
						}
					}else if("DES_DIREC2".equals(conceptoDireccionDTO.getNombreColumna())){
						if(null==form.getDesDirec2() ||valorVacio.equals(form.getDesDirec2().trim())){
							error.append(mensajeError + conceptoDireccionDTO.getCaption() + " \\n");
						}
					}else if("COD_PUEBLO".equals(conceptoDireccionDTO.getNombreColumna())){
						if(null==form.getCodPueblo() ||valorVacio.equals(form.getCodPueblo().trim())){
							error.append(mensajeError + conceptoDireccionDTO.getCaption() + " \\n");
						}
					}else if("COD_ESTADO".equals(conceptoDireccionDTO.getNombreColumna())){
						if(null==form.getCodEstado() ||valorVacio.equals(form.getCodEstado().trim())){
							error.append(mensajeError + conceptoDireccionDTO.getCaption() + " \\n");
						}
					}else if("ZIP".equals(conceptoDireccionDTO.getNombreColumna())){
						if(null==form.getZip() ||valorVacio.equals(form.getZip().trim())){
							error.append(mensajeError + conceptoDireccionDTO.getCaption() + " \\n");
						}
					}/*else if("COD_TIPOCALLE".equals(conceptoDireccionDTO.getNombreColumna())){
						if(null==form.getCodTipoCalle() ||valorVacio.equals(form.getCodTipoCalle().trim())){
							error.append(mensajeError + conceptoDireccionDTO.getCaption() + " \\n");
						}
					}*/ //P-CSR-11002
				}
				
			}
			
//			if(form.getRegion().equals("seleccione"))
//				error= error + "Por favor seleccione una Provincia \n";	
//			
//			if(form.getProvincia().equals("seleccione"))
//				error= error + "Por favor seleccione un Distrito \n";
//			
//			if(form.getCiudad().equals("seleccione"))
//				error= error + "Por favor seleccione un Corregimiento \n";
//			
//			if(form.getComuna().equals("seleccione"))
//				error= error + "Por favor seleccione una Estefa Postal \n";	
//				
//			
//			if(null==form.getNombreCalle()||"".equals(form.getNombreCalle().trim()))
//				error= error + "Por favor ingrese una calle\n";
//			
//			if(null==form.getNumeroCalle()||"".equals(form.getNumeroCalle().trim()))
//				error= error + "Por favor ingrese un número de calle\n";
//			
//			if(null==form.getZip()||"".equals(form.getZip().trim()))
//				error= error + "Por favor ingrese un tipo de Distribución\n";

			/*if(null==form.getSegundoApellido()||"".equals(form.getSegundoApellido().trim()))
				error="Por favor ingrese el segundo apellido para el cliente";	*/		
			}
			
			if(null!=error && error.toString().length() > 0){
				request.setAttribute("desError",error.toString());
				target="globalError";
				return mapping.findForward(target);
			}
			
			DatosClienteDTO clienteDTO = new DatosClienteDTO();

			clienteDTO.setCodigoTipIdentif(form.getTipoIdentificacion());
			clienteDTO.setNumIdent(form.getNumeroIdentificacion());
			clienteDTO.setNomCliente(form.getNombreCliente());
			clienteDTO.setApellidoPaterno(form.getPrimerApellido());
			clienteDTO.setApellidoMaterno(form.getSegundoApellido());
			clienteDTO.setCodCategoria(Integer.parseInt(form.getCategoria()));
			clienteDTO.setCodCrediticia(form.getCodCrediticia());
			clienteDTO.setCliente(new com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.ClienteDTO());
			clienteDTO.getCliente().setCodCliente(Long.parseLong(form.getCodCliente()));
			clienteDTO.getCliente().setCodCuenta(Long.parseLong(form.getCodCuenta()));
			clienteDTO.setDireccionDTO(new DireccionDTO());
			clienteDTO.getDireccionDTO().setCodigoRegion(limpiarValor(form.getRegion()));
			clienteDTO.getDireccionDTO().setCodigoProvincia(limpiarValor(form.getProvincia()));
			clienteDTO.getDireccionDTO().setCodigoComuna(limpiarValor(form.getComuna()));
			clienteDTO.getDireccionDTO().setCodigoCiudad(limpiarValor(form.getCiudad()));
			clienteDTO.getDireccionDTO().setNombreCalle(limpiarValor(form.getNombreCalle()));
			clienteDTO.getDireccionDTO().setNumeroCalle(limpiarValor(form.getNumeroCalle()));
			clienteDTO.getDireccionDTO().setNumPiso(limpiarValor(form.getNumPiso()));
			clienteDTO.getDireccionDTO().setNumCasilla(limpiarValor(form.getNumCasilla()));
			clienteDTO.getDireccionDTO().setObsDireccion(limpiarValor(form.getObsDireccion()));
			clienteDTO.getDireccionDTO().setDesDirec1(limpiarValor(form.getDesDirec1()));
			clienteDTO.getDireccionDTO().setDesDirec2(limpiarValor(form.getDesDirec2()));
			clienteDTO.getDireccionDTO().setCodPueblo(limpiarValor(form.getCodPueblo()));
			clienteDTO.getDireccionDTO().setCodEstado(limpiarValor(form.getCodEstado()));
			clienteDTO.getDireccionDTO().setCodTipoCalle("CL");//Se manda vacio P-CSR-11002
			clienteDTO.getDireccionDTO().setZip(limpiarValor(form.getZip()));
			
			//P-CSR-11002 - INICIO
			if (form.getAplicaCategoriaCambio().equals("1")){
				clienteDTO.setCodCategoriaCambio(form.getCategoriaCambio());
			} else {
				String categPorDefecto = obtieneCategoriaCambioPorDefecto();
				if (!categPorDefecto.equals("-1")){
					clienteDTO.setCodCategoriaCambio(categPorDefecto);
				} else {
					request.setAttribute("desError","Error al obtener valor de properties: "+"cod.categoria.cambio.pordefecto");
					target="globalError";
					return mapping.findForward(target);
				}
			}
			//P-CSR-11002 - FIN
			String usuarioPrincipal = (String)session.getAttribute("usuarioPrincipal");		
			WsTiendaVendedorOutDTO tiendaVendedorOutDTO = (WsTiendaVendedorOutDTO)session.getAttribute("tiendaVendedor");
			ArrayList<LineaVO> listaLinea =(ArrayList<LineaVO>) session.getAttribute("listaLineas");
			
			logger.error("CANTIDAD_LINEAS: " + listaLinea.size());
			
			session.setAttribute("clienteRegistrado", clienteDTO);
			request.setAttribute("lineaVO",listaLinea.get(0));
			listaLinea.get(0).setEsOcupada(new Boolean(true));
			
			//CSR-11002 - INI-01 (AL) Se comenta debido a que los codigos de centrales no son utilizados.		
//			if(null==listaLinea.get(0).getCelular()||"".equals(listaLinea.get(0).getCelular().trim())||"0".equals(listaLinea.get(0).getCelular())){
//				//Listar Centrales
//				try {
//					//GetCentralesQuiosco getCentralesQuiosco = new GetCentralesQuiosco();
//					
//					//GetCentralesQuioscoResponse centrales =proxy.getCentralesQuiosco(getCentralesQuiosco);
//					
//					WSCentralQuioscoOutDTO centrales = port.getCentralesQuiosco();
//					
//					request.setAttribute("centrales",centrales.getCentralDTOs());
//					logger.error("centrales largo: "+centrales.getCentralDTOs().length);
//					if(!"0".equals(centrales.getCodError())){
//						request.setAttribute("desError",centrales.getMsgError());
//						target="globalError";
//						return mapping.findForward(target);								
//					}
//				}catch(Exception e) {
//					request.setAttribute("desError","Error al intentar obtener centrales");
//					target="globalError";
//					return mapping.findForward(target);
//				} 
//			}
			//FIN-01 (AL)			
					
					
			session.setAttribute("listaLineas", listaLinea);
			//CSR-11002 INI-02 (AL) - Se comenta llamada al formulario de registro de usuario. 
//			target="formularioUsuario";
					
			//CSR-11002 INI-03 (AL) - Inicia proceso de realizado por el formulario de usuario.
					

			//SETEO USUARIO PARA LA LINEA
			WsStructuraUsuarioLineaDTO usuarioLineaDTO = new WsStructuraUsuarioLineaDTO();
			usuarioLineaDTO.setNumeroIdentificacion(clienteDTO.getNumIdent());
//			System.out.println("usuarioLineaDTO.getNumeroIdentificacion() -> "+usuarioLineaDTO.getNumeroIdentificacion());
			usuarioLineaDTO.setNombre(clienteDTO.getNomCliente());
//			System.out.println("usuarioLineaDTO.getNombre() -> "+usuarioLineaDTO.getNombre());
			usuarioLineaDTO.setPrimerApellido(clienteDTO.getApellidoPaterno());
//			System.out.println("usuarioLineaDTO.getPrimerApellido() -> "+usuarioLineaDTO.getPrimerApellido());
			usuarioLineaDTO.setSegundoApellido(clienteDTO.getApellidoMaterno());
//			System.out.println("usuarioLineaDTO.getSegundoApellido() -> "+usuarioLineaDTO.getSegundoApellido());
			usuarioLineaDTO.setTipIdentificacion(clienteDTO.getCodigoTipIdentif());
//			System.out.println("usuarioLineaDTO.getTipIdentificacion() -> "+usuarioLineaDTO.getTipIdentificacion());

			ArrayList<WsStructuraLineaDTO> listaStructura =(ArrayList<WsStructuraLineaDTO>) session.getAttribute("listaStructura");
			
			if(null==listaStructura){
				listaStructura = new ArrayList<WsStructuraLineaDTO>();
			}
			
			//INICIO FOR CSR-11002
			//listaLinea.get(0)
			for (int i = 0; i < listaLinea.size(); i++) {
				
				LineaVO linea = listaLinea.get(i);
				
			
				WsStructuraLineaDTO structuraLineaDTO = new WsStructuraLineaDTO();	
				
				//AQUI SE AGREGARÁ El CODIGO CENTRAL SELECCIONADO AL DTO DE ALTA
				//Si el campo viene cero, es por que la serie es numerada		
	//			logger.error("CODIGO CENTRAL SELECCIONADO: "+null);
				structuraLineaDTO.setCodigoCentral(null);
	//			System.out.println("structuraLineaDTO.getCodigoCentral() -> "+structuraLineaDTO.getCodigoCentral());
				
				structuraLineaDTO.setUsuarioLinea(usuarioLineaDTO);
				WsStructuraSimcardDTO wsStructuraSimcardDTO = new WsStructuraSimcardDTO();
				
				//wsStructuraSimcardDTO.setNumeroSerie(listaLinea.get(0).getSimcard());
				wsStructuraSimcardDTO.setNumeroSerie(linea.getSimcard());
	//			System.out.println("wsStructuraSimcardDTO.getNumeroSerie(): ->"+wsStructuraSimcardDTO.getNumeroSerie());
				structuraLineaDTO.setSimcard(wsStructuraSimcardDTO);
				
				WsStructuraTerminalDTO wsStructuraTerminal = new WsStructuraTerminalDTO();
				//if (null == listaLinea.get(0).getImei()){
				if (null == linea.getImei()){
					wsStructuraTerminal.setNumImei("");
				} else {
					wsStructuraTerminal.setNumImei(linea.getImei());
				}
	//			System.out.println("wsStructuraTerminal.getNumImei() ->: "+wsStructuraTerminal.getNumImei());
				structuraLineaDTO.setTerminal(wsStructuraTerminal);			 
				
				listaStructura.add(structuraLineaDTO);
			
			}
			//FIN FOR
			session.setAttribute("listaStructura", listaStructura);

			//CSR-11002 - Se comenta debido a que los codigos de centrales no son utilizados.				
//			int i;
//			for(i=0;i<=listaLinea.size()-1;i++){
//				if(!listaLinea.get(i).getEsOcupada().booleanValue()){
//					request.setAttribute("lineaVO",listaLinea.get(i));
//					listaLinea.get(i).setEsOcupada(new Boolean(true));
//					session.setAttribute("listaLineas", listaLinea);
//					
//					if(null==listaLinea.get(i).getCelular()||"".equals(listaLinea.get(i).getCelular().trim())||"0".equals(listaLinea.get(i).getCelular())){
//						//Listar Centrales
//						try {
//							//GetCentralesQuiosco getCentralesQuiosco = new GetCentralesQuiosco();
//							WSCentralQuioscoOutDTO centrales =port.getCentralesQuiosco();
//							
//							
//							
//							request.setAttribute("centrales",centrales.getCentralDTOs());
//							logger.error("centrales largo: "+centrales.getCentralDTOs().length);
//							if(!"0".equals(centrales.getCodError())){
//								request.setAttribute("desError",centrales.getMsgError());
//								target="globalError";
//								return mapping.findForward(target);								
//							}
//						}catch(Exception e) {
//							request.setAttribute("desError","Error al intentar obtener centrales");
//							target="globalError";
//							return mapping.findForward(target);
//						} 
//					}
//					
//					target="formularioUsuario";
//					return mapping.findForward(target);
//				}
//			}
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
			
			//Se eliminan todas las sessiones menos los datos de la tienda y el usuario	
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
			return mapping.findForward(target);	
			//CSR-11002 FIN-03 (AL) - Finaliza proceso de realizado por el formulario de usuario.
		}
		else if("buscarCliente".equals(form.getAccionRegCliente())){
			   
			/*ClientePorNumeroCelular clientePorNumeroCelular = new ClientePorNumeroCelular();
			clientePorNumeroCelular.setNumeroCelular(new Long(form.getNumCelular()));
			
			ClientePorNumeroCelularResponse clienteDTO = proxy.clientePorNumeroCelular(clientePorNumeroCelular);*/
			
			//Se valida el número celular ingresado, para realizar la busqueda.
			System.out.println("form.getNumCelular() : ["+form.getNumCelular()+"]");
			if (null != form.getNumCelular() && !"".equals(form.getNumCelular())){
				try{
					Long.parseLong(form.getNumCelular());
				}catch (NumberFormatException nfe){
					request.setAttribute("desError","Favor ingresar un número celular válido.");
					target="globalError";
					return mapping.findForward(target);
				}				
			} else {
				request.setAttribute("desError","Favor ingresar un número celular.");
				target="globalError";
				return mapping.findForward(target);
			}
			
			DatosClienteDTO clienteDTO = port.clientePorNumeroCelular(new Long(form.getNumCelular()));
			    
		    if(clienteDTO.getCodError()!=0){
				request.setAttribute("desError",clienteDTO.getMsgError());
				target="globalError";
				return mapping.findForward(target);
		    }
			request.setAttribute("cliente",clienteDTO);
			request.setAttribute("direccion",clienteDTO.getDireccionDTO());
			request.setAttribute("clienteCuenta", clienteDTO.getCliente());
			request.setAttribute("cargarCliente", "si");
			
			
				//P-CSR-11002 INI-01 - Listado Categorias Cambio.
				request.setAttribute("flgAplicaCategoriaCambio", aplicarCategoriaCambio());				
				//P-CSR-11002 FIN-01
				
			//INICIO CSR-11002
			WsDatosDireccionOutDTO datosDireccion = port.getDatosDireccion(null);
			
			if(!"0".equals(datosDireccion.getCodError())){
				logger.error("Error: "+ datosDireccion.getMensajseError());
				request.setAttribute("desError",datosDireccion.getMensajseError());
				target="globalError";
				return mapping.findForward(target);
			}
			
			ConceptoDireccionDTO[] conceptos = datosDireccion.getDireccionDTO().getConceptoDireccionDTOs();
			
			for (int i = 0; i < conceptos.length; i++) {
				ConceptoDireccionDTO concepto = conceptos[i];
				
				DatosDireccionDTO[] datosDireccionDTO = new DatosDireccionDTO[1];
				
				DatosDireccionDTO datoDireccion = new DatosDireccionDTO();
				
				if("COD_REGION".equals(concepto.getNombreColumna())){
					
					datoDireccion.setCodigo(clienteDTO.getDireccionDTO().getCodigoRegion());
					datoDireccion.setDescripcion(clienteDTO.getDireccionDTO().getDescripcionRegion());
					
				}else if("COD_PROVINCIA".equals(concepto.getNombreColumna())){
				
					datoDireccion.setCodigo(clienteDTO.getDireccionDTO().getCodigoProvincia());
					datoDireccion.setDescripcion(clienteDTO.getDireccionDTO().getDescripcionProvincia());
					
				}else if("COD_CIUDAD".equals(concepto.getNombreColumna())){
					
					datoDireccion.setCodigo(clienteDTO.getDireccionDTO().getCodigoCiudad());
					datoDireccion.setDescripcion(clienteDTO.getDireccionDTO().getDescripcionCiudad());
				
				}else if("COD_COMUNA".equals(concepto.getNombreColumna())){
					
					datoDireccion.setCodigo(clienteDTO.getDireccionDTO().getCodigoComuna());
					datoDireccion.setDescripcion(clienteDTO.getDireccionDTO().getDescripcionComuna());
				
				}else if("NOM_CALLE".equals(concepto.getNombreColumna())){
					
					datoDireccion.setCodigo(clienteDTO.getDireccionDTO().getNombreCalle());
					datoDireccion.setDescripcion(clienteDTO.getDireccionDTO().getNombreCalle());
				
				}else if("NUM_CALLE".equals(concepto.getNombreColumna())){
					
					datoDireccion.setCodigo(clienteDTO.getDireccionDTO().getNumeroCalle());
					datoDireccion.setDescripcion(clienteDTO.getDireccionDTO().getNumeroCalle());
				
				}else if("NUM_PISO".equals(concepto.getNombreColumna())){
					
					datoDireccion.setCodigo(clienteDTO.getDireccionDTO().getNumPiso());
					datoDireccion.setDescripcion(clienteDTO.getDireccionDTO().getNumPiso());
				
				}else if("NUM_CASILLA".equals(concepto.getNombreColumna())){
					
					datoDireccion.setCodigo(clienteDTO.getDireccionDTO().getNumCasilla());
					datoDireccion.setDescripcion(clienteDTO.getDireccionDTO().getNumCasilla());
				
				}else if("OBS_DIRECCION".equals(concepto.getNombreColumna())){
					
					datoDireccion.setCodigo(clienteDTO.getDireccionDTO().getObsDireccion());
					datoDireccion.setDescripcion(clienteDTO.getDireccionDTO().getObsDireccion());
				
				}else if("DES_DIREC1".equals(concepto.getNombreColumna())){
					
					datoDireccion.setCodigo(clienteDTO.getDireccionDTO().getDesDirec1());
					datoDireccion.setDescripcion(clienteDTO.getDireccionDTO().getDesDirec1());
				
				}else if("DES_DIREC2".equals(concepto.getNombreColumna())){
					
					datoDireccion.setCodigo(clienteDTO.getDireccionDTO().getDesDirec2());
					datoDireccion.setDescripcion(clienteDTO.getDireccionDTO().getDesDirec2());
				
				}else if("COD_PUEBLO".equals(concepto.getNombreColumna())){
					
					datoDireccion.setCodigo(clienteDTO.getDireccionDTO().getCodPueblo());
					datoDireccion.setDescripcion(clienteDTO.getDireccionDTO().getCodPueblo());
				
				}else if("COD_ESTADO".equals(concepto.getNombreColumna())){
					
					datoDireccion.setCodigo(clienteDTO.getDireccionDTO().getCodEstado());
					datoDireccion.setDescripcion(clienteDTO.getDireccionDTO().getDescripcionEstado());
				
				}else if("COD_TIPOCALLE".equals(concepto.getNombreColumna())){
					
					datoDireccion.setCodigo(clienteDTO.getDireccionDTO().getCodTipoCalle());
					datoDireccion.setDescripcion(clienteDTO.getDireccionDTO().getDescripcionTipoCalle());
				
				}else if("ZIP".equals(concepto.getNombreColumna())){
				 	
					datoDireccion.setCodigo(clienteDTO.getDireccionDTO().getZip());
					datoDireccion.setDescripcion(clienteDTO.getDireccionDTO().getZip());
				
				}
				
				datosDireccionDTO[0] = datoDireccion; 
				
				concepto.setDatosDireccionDTO(datosDireccionDTO);
			}
			
			//se setea coleccion de campos de direccion cuando se busca el cliente			
			session.setAttribute("datosDireccion2",datosDireccion );

			//anulamos si es que existe la coleccion de campos de direccion
			//que se usa cuando el cliente es nuevo
			session.setAttribute("datosDireccion",null );
			
			//obtener las clasificaciones
			WsClasificacionOutDTO clasificacionOutDTO = port.getClasificaciones();
			
			if(!"0".equals(clasificacionOutDTO.getCodError())){
				logger.error("Error: "+ clasificacionOutDTO.getMensajseError());
				request.setAttribute("desError",clasificacionOutDTO.getMensajseError());
				target="globalError";
				return mapping.findForward(target);
			}
			
			ClasificacionDTO[] clasificaciones = clasificacionOutDTO.getClasificaciones();
			
			for (int i = 0; i < clasificaciones.length; i++) {
				ClasificacionDTO clasificacion = clasificaciones[i];
				
				if (clasificacion.getCodElemento().equalsIgnoreCase(config.getString("codigo.clasificacion.crediticia"))){
					
					logger.debug("clasificacion.getIndVisible(): " + clasificacion.getIndVisible());
					//determina si es visible o invisible el campo crediticia
					if(clasificacion.getIndVisible()==1){
					
						session.setAttribute("flagCtrlClasifCrediticia", 1);
					}else{
						session.setAttribute("flagCtrlClasifCrediticia", 0);
					}
				}
			}
			
			//FIN CSR-11002
			
			target="formularioCliente";
		}
		else if("cargarProvincias".equals(form.getAccionRegCliente())){
			request.setAttribute("accionDireccion", form.getAccionRegCliente());
			RegionDTO regionDTO = new RegionDTO();
			RegionDTO region = new RegionDTO();
			region.setCodigoRegion(form.getRegion());
			//regionDTO.setRegionDTO(region);
			regionDTO.setCodigoRegion(region.getCodigoRegion());
			request.setAttribute("provincias",port.getListadoProvincias(regionDTO).getProvinciaDTOs());
			
			
			target="direcciones";	
		}
		else if("cargarCiudades".equals(form.getAccionRegCliente())){
			request.setAttribute("accionDireccion", form.getAccionRegCliente());
			ProvinciaDTO provinciaDTO = new ProvinciaDTO();
			provinciaDTO.setCodigoRegion(form.getRegion());
			provinciaDTO.setCodigoProvincia(form.getProvincia());
			
			ProvinciaDTO getListadoCiudades = new ProvinciaDTO();
			getListadoCiudades.setCodigoRegion(provinciaDTO.getCodigoRegion());
			getListadoCiudades.setCodigoProvincia(provinciaDTO.getCodigoProvincia());
			request.setAttribute("ciudades",port.getListadoCiudades(getListadoCiudades).getCiudadDTOs());
			target="direcciones";	
		}
		else if("cargarComunas".equals(form.getAccionRegCliente())){
			request.setAttribute("accionDireccion", form.getAccionRegCliente());
			CiudadDTO ciudadDTO = new CiudadDTO();
			ciudadDTO.setCodigoRegion(form.getRegion());
			ciudadDTO.setCodigoProvincia(form.getProvincia());
			ciudadDTO.setCodigoCiudad(form.getCiudad());
			CiudadDTO getListadoComunas = new CiudadDTO();
			getListadoComunas.setCodigoRegion(ciudadDTO.getCodigoRegion());
			getListadoComunas.setCodigoProvincia(ciudadDTO.getCodigoProvincia());
			getListadoComunas.setCodigoCiudad(ciudadDTO.getCodigoCiudad());
			request.setAttribute("comunas",port.getListadoComunas(getListadoComunas).getComunaSPNDTOs());	
			target="direcciones";	
		}
		else if("cargarZip".equals(form.getAccionRegCliente())){
			request.setAttribute("accionDireccion", form.getAccionRegCliente());
			DireccionDTO direccionDTO = new DireccionDTO();
			direccionDTO.setCodigoRegion(form.getRegion());
			direccionDTO.setCodigoProvincia(form.getProvincia());
			direccionDTO.setCodigoCiudad(form.getCiudad());
			direccionDTO.setCodigoComuna(form.getComuna());
			String zip;
			DireccionDTO getZip = new DireccionDTO();
			getZip.setCodigoRegion(direccionDTO.getCodigoRegion());
			getZip.setCodigoProvincia(direccionDTO.getCodigoProvincia());
			getZip.setCodigoCiudad(direccionDTO.getCodigoCiudad());
			getZip.setCodigoComuna(direccionDTO.getCodigoComuna());
			
			try{
			zip=port.getZip(getZip);
			
			}
			catch(GeneralException e){
				zip="";
			}
			catch(Exception e){
				zip="";
			}
			
			request.setAttribute("zip",zip);			
			target="direcciones";	
		}
		} catch (GeneralException e) {
			e.printStackTrace();
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (RemoteException e) {
			e.printStackTrace();
		}
		
		
		return mapping.findForward(target);
	}

	/**
	 * P-CSR-11002
	 * @param datosTributariosForm
	 *            Se configura en la operadora mostrar o no los campos de categoria de cambio. Se establece valor por
	 *            defecto de cat. de cambio, tabla: FA_TASA_CAMBIO_TD, columna: COD_CATEGORIA_CAMBIO.
	 */
	private String aplicarCategoriaCambio() {
		String strAplicaCategoriaCambio = "0";
		
			strAplicaCategoriaCambio = config.getString("aplica.categoria.cambio");
			logger.error("valorAplicaCategoriaCambio: " + strAplicaCategoriaCambio);
		if (null == strAplicaCategoriaCambio) {
			strAplicaCategoriaCambio = "-1";
			logger.error("Error al obtener valor de properties: " + "aplica.categoria.cambio");
		}
		return strAplicaCategoriaCambio;
	}
	

	/**
	 * P-CSR-11002 - Metodo que obtiene la categoria de cambio por defecto.
	 * @return
	 */
	private String obtieneCategoriaCambioPorDefecto(){
		String valorCategoriaCambioPorDefecto = null;
		final String claveCategoriaCambioPorDefecto = "cod.categoria.cambio.pordefecto";
		
			valorCategoriaCambioPorDefecto = config.getString(claveCategoriaCambioPorDefecto);
			logger.error("valorCategoriaCambioPorDefecto: " + valorCategoriaCambioPorDefecto);
		if (null == valorCategoriaCambioPorDefecto) {
			valorCategoriaCambioPorDefecto = "-1";
		}
		return valorCategoriaCambioPorDefecto;
	}
	
		/**
	 * permite limpiar el valor que se va a negocio
	 * @param region
	 * @return
	 */
	private String limpiarValor(String pValor) {

		String result = "";
		
		if(pValor == null){
			return pValor;
		}
		
		//si es un combo no obligatorio, envio nulo en ese valor
		if("seleccione".equals(pValor.trim())){
			return result;
		}
		
		return pValor;
	}
}
