package com.tmmas.scl.operations.crm.f.s.manpro.web.action;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.DatosClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.PrestacionDTO;
import com.tmmas.scl.framework.marketSalesDomain.contactLeadProspectABE.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ParametroSerializableDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PaqueteDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RestriccionesContratacionDTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.TipoComportamientoListDTO;
import com.tmmas.scl.operations.crm.f.s.manpro.frmk.dataTransferObject.ClienteFrmkDTO;
import com.tmmas.scl.operations.crm.f.s.manpro.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.f.s.manpro.frmk.dataTransferObject.ValoresDefectoPaginaDTO;
import com.tmmas.scl.operations.crm.f.s.manpro.web.delegate.ManageProspectBussinessDelegate;
import com.tmmas.scl.operations.crm.f.s.manpro.web.form.VentaForm;
import com.tmmas.scl.operations.crm.f.s.manpro.web.helper.AbonadoWeb;
import com.tmmas.scl.operations.crm.f.s.manpro.web.helper.ClienteWeb;
import com.tmmas.scl.operations.crm.f.s.manpro.web.helper.Global;
import com.tmmas.scl.operations.crm.f.s.manpro.web.helper.NavegacionWeb;
import com.tmmas.scl.operations.crm.f.s.manpro.web.helper.ParseoXML;
import com.tmmas.scl.operations.crm.f.s.manpro.web.helper.ProductoWeb;

public class VentaAction extends Action{

	private final Logger logger = Logger.getLogger(VentaAction.class);	
	private Global global = Global.getInstance();	
	
	public ActionForward execute(ActionMapping mapping,
	ActionForm form,
	HttpServletRequest request,
	HttpServletResponse response)
	throws Exception
	{
		logger.debug("execute ini");
		
		String frmNumVenta;
		ClienteFrmkDTO clienteVTA;
		ArrayList listadoAbonado;
		VentaDTO venta;	
		ClienteDTO clienteDTO;	
		long frmCodCliente;	
		
		try
		{
		//105 -  
				logger.debug("Entro a la venta");
				logger.debug("--------ManageProspectWEB.ear CREADO 08/09/2010 16:40 : EV--------");	
				boolean saltarListaAbonados=false;
				NavegacionWeb navegacion = new NavegacionWeb();		
				VentaForm ingresoVentaForm = (VentaForm) form;
				
				String codCliente = request.getParameter("cod_cliente")!=null?request.getParameter("cod_cliente"):String.valueOf(ingresoVentaForm.getCodCliente());
				String numVenta = request.getParameter("num_venta")!=null?request.getParameter("num_venta"):ingresoVentaForm.getNumVenta();
				String numTransaccion = request.getParameter("num_transaccion")!=null?request.getParameter("num_transaccion"):"111";
				String numEvento = request.getParameter("num_evento")!=null?request.getParameter("num_evento"):"111";
				String codVendedor = request.getParameter("cod_vendedor")!=null?request.getParameter("cod_vendedor"):"111";
				String flagCiclo = request.getParameter("flag_ciclo")!=null?request.getParameter("flag_ciclo"):"1";
				String origen = request.getParameter("origen")!=null?request.getParameter("origen"):"VENTA";
				
				logger.debug("--------------------Datos Llamada Manpro ini --------------------");
				logger.debug("codCliente    ["+codCliente+"]");
				logger.debug("numVenta      ["+numVenta+"]");
				logger.debug("numTransaccion["+numTransaccion+"]");
				logger.debug("numEvento     ["+numEvento+"]");
				logger.debug("codVendedor   ["+codVendedor+"]");
				logger.debug("flagCiclo     ["+flagCiclo+"]");
				logger.debug("origen     	["+origen+"]");
				logger.debug("ipCliente		["+request.getRemoteAddr()+"]");
				logger.debug("--------------------Datos Llamada Manpro fin --------------------");
				navegacion.setNumEvento(numEvento);
				navegacion.setNumTransaccion(numTransaccion);
				navegacion.setCodVendedor(codVendedor);
				navegacion.setFlagCiclo(flagCiclo);
				navegacion.setOrigen(origen);
				
				frmNumVenta = numVenta;
				frmCodCliente = Long.parseLong(codCliente);
		
				String log = global.getValor("web.log");
				log = global.getPathInstancia() + log;
				logger.debug(log);
				PropertyConfigurator.configure(log);	
				
				ManageProspectBussinessDelegate delegate=ManageProspectBussinessDelegate.getInstance();
				/**/
				//otra informacion del cliente
				DatosClienteDTO datosCliente  = delegate.obtenerDatosAdicCliente(new Long(codCliente));
				ClienteOSSesionDTO sessionData = new ClienteOSSesionDTO();
				sessionData.setClColor(datosCliente.getDescripcionColor());
				sessionData.setClSegmento(datosCliente.getDescripcionSegmento());
				sessionData.setNumVenta((numVenta!=null)?Long.parseLong(numVenta):0);
				/**/
				
			    //(+)05/04/10 Lectura de archivo XML de configuracion, parseo y carga en objeto de sesion
			 	ValoresDefectoPaginaDTO definicionPagina= new ValoresDefectoPaginaDTO();
			 	String dirXML = global.getValor("config.xml");
			 	String dir = System.getProperty("user.dir") +dirXML;
			 	logger.debug("dir="+dir);
			 	ParseoXML parseo=new ParseoXML();
				logger.debug("leyendo y parseando XML configuración:antes");
				definicionPagina=parseo.cargaXML(dir);
				logger.debug("leyendo y parseando XML configuración:despues");
				sessionData.setValoresDefecto(definicionPagina);
			    //(-)05/04/10 Lectura de archivo XML de configuracion, parseo y carga en objeto de sesion
				
				//(+)17/05/10 Parametro que indica maximo de productos a desplegar en grilla de productos disponibles
				
				ParametroDTO param = new ParametroDTO();
				param.setCodModulo(global.getValor("codigo.modulo.GA").trim());
				param.setCodProducto(Integer.parseInt(global.getValor("codigo.producto").trim())); 
				param.setNomParametro(global.getValor("parametro.max_lista_producto").trim());
				ParametroDTO paramGral = delegate.obtenerParametroGeneral(param);
				
				sessionData.setMaxListaProductos(Integer.parseInt(paramGral.getValor()));
				//(-)17/05/10 Parametro que indica maximo de productos a desplegar en grilla de productos disponibles
				
				clienteDTO=new ClienteDTO();
				clienteDTO.setCodCliente(frmCodCliente);
				
				venta=new VentaDTO();	
				venta.setIdVenta(frmNumVenta);	
				venta.setCliente(clienteDTO);
				
				/**
				 * Creacion del proceso
				 */
				ParametroSerializableDTO proceso=delegate.crearProceso(venta);
				venta.setNumEvento(proceso.getIdProceso());
				clienteDTO=delegate.obtenerDatosClienteCuenta(venta);
				
				logger.debug("Ingreso la venta = " + frmNumVenta);
				logger.debug("Para cliente = " + clienteDTO.getNombres());		
				
				if (false) {
					request.setAttribute("exception", "uffff");
					return mapping.findForward("mensajeError");
				}
				ClienteWeb clienteWeb=null;
				
				HttpSession session = request.getSession(false);
				if (session != null) {
		            logger.debug("Session existente en pagina de login. Invalidando session existente");            
					//session.removeAttribute("ClienteOOSS");
					session.invalidate();
				}
				
				/*********************************************************************************/
				//HttpSession session = request.getSession();
				/*if (session != null) {
					session.invalidate();
					logger.debug("Creando session...");
					session = request.getSession(true);
				}*/
				/*********************************************************************************/
				/***
				 * @author rlozano
				 * @description se realiza búsqueda de usuario a través de código de vendedor
				 */
				
				RetornoDTO retValue=delegate.getUsuariosPorNumVenta(frmNumVenta);
				venta.setNomUsuaOra(retValue.getDescripcion());
				
				session = request.getSession(true);
				
				//(+) EV 22/01/2010 carga tipos de comportamiento
				session.setAttribute("tiposCompList", delegate.obtenerTiposComportamiento());
				//(-) EV 22/01/2010 carga tipos de comportamiento
				
				///159602 INIC
				clienteDTO.setPrimeraVenta("S");	
				logger.debug("clienteDTO.setPrimeraVenta(S)");
				///159602 INIC
				
				if("S".equalsIgnoreCase(clienteDTO.getPrimeraVenta()))
				{			
					logger.debug("Es primera venta");
					saltarListaAbonados=(clienteDTO.getAbonados()==null || clienteDTO.getAbonados().getAbonados().length==0)?true:false;
					
					logger.debug("saltarListaAbonados="+saltarListaAbonados);
					
					PlanTarifarioDTO planTarifario=new PlanTarifarioDTO();
					PaqueteDTO paqueteDefault=new PaqueteDTO();
					paqueteDefault.setCodProdPadre(String.valueOf(clienteDTO.getCodProdPadre()));
					paqueteDefault.setIdPaquete(String.valueOf(clienteDTO.getCodProdPadre()));
					planTarifario.setPaqueteDefault(paqueteDefault);
					
					AbonadoDTO[] abonadosFinales=null;
					AbonadoDTO porClienteAbon=new AbonadoDTO();
					porClienteAbon.setPlanTarifario(planTarifario);
					porClienteAbon.setNumAbonado(0);
					porClienteAbon.setNumVenta(Long.parseLong(frmNumVenta));
					porClienteAbon.setCodCliente(clienteDTO.getCodCliente());
					porClienteAbon.setTipoCliente(clienteDTO.getCodTipoPlanTarif());

					if(!saltarListaAbonados)
					{
						abonadosFinales=new AbonadoDTO[clienteDTO.getAbonados().getAbonados().length+1];
						for(int i=0;i<clienteDTO.getAbonados().getAbonados().length;i++)
						{
							abonadosFinales[i]=clienteDTO.getAbonados().getAbonados()[i];
							abonadosFinales[i]=delegate.obtenerNumeroMovimientoAlta(abonadosFinales[i]);
						}
						
						//(+) 07/04/10 EV, se necesita codPlanTarif para correo movistar
						//y codTipPlan para obtener lista de productos
						if (clienteDTO.getAbonados().getAbonados().length>0){
							porClienteAbon.setCodPlanTarif(clienteDTO.getAbonados().getAbonados()[0].getCodPlanTarif());
							porClienteAbon.setCodTipPlan(clienteDTO.getAbonados().getAbonados()[0].getCodTipPlan());							
						}
						//(-)
						
						abonadosFinales[clienteDTO.getAbonados().getAbonados().length]=porClienteAbon;												
					}
					else
					{
						abonadosFinales=new AbonadoDTO[1];
						abonadosFinales[0]=porClienteAbon;
					}
					clienteDTO.getAbonados().setAbonados(abonadosFinales);					
					session.setAttribute("EnableCliente", "TRUE");
					
				}				
				
				/*else if("E".equalsIgnoreCase(clienteDTO.getCodTipoPlanTarif()) && "N".equalsIgnoreCase(clienteDTO.getPrimeraVenta()))
				{
					puedeContratar=false;
				}*/
				
				//if(puedeContratar)
				//{
					//obtiene prestaciones
					PrestacionDTO[] prestaciones = delegate.obtenerPrestaciones().getPrestaciones();
					
					//carga informacion cliente abonado web
					clienteVTA= new ClienteFrmkDTO(clienteDTO,prestaciones);		
					logger.debug("Cliente desde frk Nombre :>" + clienteVTA.getNombre());
					
					listadoAbonado=clienteVTA.getListadoAbonados();
					ingresoVentaForm.setListadoAbonado(listadoAbonado);			
					/**
					 * Cristian Toledo {
					 */
						venta.setCliente(clienteDTO);
						session.setAttribute("VentaDTO", venta);				
					/**
					 * }
					 */				
					AbonadoDTO[] abonadosTest = clienteDTO.getAbonados().getAbonados();		
					logger.debug("cantidad de abonados = " + abonadosTest.length);		
					clienteWeb= new ClienteWeb(String.valueOf(frmCodCliente));		
					clienteWeb.setCodCliente(frmCodCliente);
					for(int i=0;i<abonadosTest.length;i++)
					{
						abonadosTest[i].setCodCliente(frmCodCliente);
						AbonadoWeb abonadoWeb = new AbonadoWeb();
						abonadoWeb.setIdAbonado(String.valueOf(abonadosTest[i].getNumAbonado())); // TODO VALIDAR QUE ESTE CORRECTO
						clienteWeb.AgregarAbonWeb(String.valueOf(abonadosTest[i].getNumAbonado()), abonadoWeb);
						
						//abonadosTest[i]=delegate.obtenerNumeroMovimientoAlta(abonadosTest[i]);
						/**
						 * Agregar abonados HashMap 
						 */
						
						navegacion.creaProductoPorAbonado(abonadosTest[i],sessionData);
						
					/* INICIO INC 155400 18112010
						 * Se agrega la siguiente logica, para seleccionar los planes por obligatorios
						 * Se recorren los planes obtenidos, y se cargan los obligatorios, para que si, se selecciona 
						 * contrarar sin entrar a la pagina de planes estos, obligatorios, ya se encuentren cargados.
						 * */
						ProductoWeb prodWEB;
						ArrayList productoPorDefecto;
						String listaProductosDef="";
						productoPorDefecto = navegacion.getPaqueteWeb(abonadosTest[i].getNumAbonado()+"").getProductosDisponible();
						String[] cantidades = new String[productoPorDefecto.size()];
						
						for (int cont=0; cont< productoPorDefecto.size() ; cont++){
							
							prodWEB = (ProductoWeb)productoPorDefecto.get(cont);
							
							
							if ("2".equals(prodWEB.getTipoPlanAdic()) ){
								if (listaProductosDef == "")
									listaProductosDef = "B."+ prodWEB.getCodPadre() +"."+prodWEB.getCodigo();
								else
									listaProductosDef = listaProductosDef + "|"+"B."+ prodWEB.getCodPadre() +"."+prodWEB.getCodigo();
							}
							
							cantidades[cont] = prodWEB.getCantidadContratado()+"";
						}
						
						navegacion.setPagina("productos");
						navegacion.setAccion(1);	
						navegacion.setIdPagina(abonadosTest[i].getNumAbonado()+"");
						navegacion.setBitacora(listaProductosDef);
						navegacion.Grabar();
						navegacion.setCantidadesPorProductoOfertado(abonadosTest[i].getNumAbonado()+"",cantidades);	
						// TERMINO INC 155400 18112010
					}	
				//luego de guardar los cambios .. se asocia a la variable de sesion
				
				//}
					
				RestriccionesContratacionDTO resdto=new RestriccionesContratacionDTO();
				//RestriccionesContratacionListDTO listRestricciones=delegate.obtenerRestriccionesContratacion(resdto);
				navegacion.AgregarElementoWeb(String.valueOf(frmCodCliente), clienteWeb);
				
				session.setAttribute("ClienteVTA",clienteVTA); // se setea para mostrar datos en las paginas 
				navegacion.setClienteWeb(clienteVTA);
				session.setAttribute("navegacion",navegacion);
				session.setAttribute("ClienteOOSS", sessionData);
				
				logger.debug("ip="+request.getRemoteAddr()+"codCliente="+codCliente); 

				logger.debug("execute fin");
				if(!saltarListaAbonados)
					return mapping.getInputForward();
				else
					return mapping.findForward("despliegaProductos");
		
		}
		catch(Exception e)
		{			
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			request.setAttribute("exception", e.getMessage());
			logger.debug("execute fin");
			return mapping.findForward("mensajeError");
		}
	}

}

