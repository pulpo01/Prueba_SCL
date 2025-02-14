package com.tmmas.scl.operations.crm.fab.cim.manreq.web.action;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework.util.BaseAction;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.UsuarioDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.OrdenServicioDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ValidaOOSSDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.EspecProductoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.EspecServicioClienteListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.EspecServicioListaDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.EspecServicioListaListDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.businessObject.bo.XMLDefault;
import com.tmmas.scl.operations.crm.fab.cim.manreq.businessObject.dao.ParseoXML;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.AbonadoFrmkDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ControlDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.DefaultPaginaCPUDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ParametrosCondicionesCPUDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ProdContratadoOfertadoDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ProductoContratadoFrecDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.SeccionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.exception.ManReqException;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate.ManageRequestBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.ListaProdContratadosForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.Global;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.JCondicionesComerciales;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.PaqueteWeb;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.ProductosContradosFrecUtil;

public class ListProdContratadosFrecAction extends BaseAction {
	
	private final Logger logger = Logger.getLogger(ListProdContratadosFrecAction.class);
	private Global global = Global.getInstance();
	
	private ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();
	private PaqueteWeb productos;
	
	String  CLASS_NAME = "ListProdContratadosFrecAction ";
	public ActionForward executeAction(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);
		
		logger.debug("execute():start");
		boolean continua = true;
		String siguiente = "cargarProductos";
		
		RetornoDTO retornoDTO = new RetornoDTO();	
		retornoDTO.setCodigo("0");		
		String fwdError = null;			
		
	    ClienteOSSesionDTO sessionData = new ClienteOSSesionDTO();
	    HttpSession session = request.getSession(false);
	    session.removeAttribute("productosContratados");
	    session.removeAttribute("productosContratadosFrecSess");
	    session.removeAttribute("Abonado");
	    //session.removeAttribute("listaClientes"); //limpiar la lista de session CAMBIAR ESTO AL NUEVO ACTION QUE CONTROLARA LA LISTA?????????
	    sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");
	    ProductoContratadoFrecDTO [] productosContratadosFrecSess = null;

	    ProductosContradosFrecUtil pfu = new ProductosContradosFrecUtil();
	    // Lectura de archivo XML de configuracion, parseo y carga en objeto de sesion
	 	DefaultPaginaCPUDTO definicionPagina= new DefaultPaginaCPUDTO();
	 	String dirXML = global.getValor("configFrecuentes.xml");//TODO revisar si debo crear un configFrec.xml
	 	String dir = System.getProperty("user.dir") +dirXML;
	 	logger.debug("dir="+dir);
	 	ParseoXML parseo=new ParseoXML();
		logger.debug("leyendo y parseando XML configuración:antes");
		definicionPagina=parseo.cargaXML(dir);
		logger.debug("leyendo y parseando XML configuracion:despues");
		sessionData.setDefaultPagina(definicionPagina);
		
		
		//AbonadoListDTO listaAbonados=null;
	    AbonadoDTO retornoAbonado=null;
	    AbonadoDTO abonado=new AbonadoDTO();
	    AbonadoListDTO abonadoLista = new AbonadoListDTO();
	    AbonadoDTO[] abonados=new AbonadoDTO[1];
	    ClienteDTO cliente =sessionData.getCliente();
	     boolean isListAbonados=false;
	    try {
			if(sessionData.getNumAbonado()!=0 ){
				session.removeAttribute("error");
				abonado.setNumAbonado(sessionData.getNumAbonado());
				logger.debug("obtenerDatosAbonado :inicio");
				abonado=delegate.obtenerDatosAbonado(abonado);
				logger.debug("obtenerDatosAbonado :fin");
				abonados[0]=abonado;
			    abonadoLista.setAbonados(abonados);
			    sessionData.setAbonados(abonadoLista.getAbonados());
			    isListAbonados=true;
			    cliente.setCodCliente(abonado.getCodCliente());
			    sessionData.setCliente(cliente);
				cliente.setAbonados(abonadoLista);
				
				
				
				//	validar ordenes pendientes plan
				ValidaOOSSDTO validaOS = new ValidaOOSSDTO();
				validaOS.setCodCliente(sessionData.getCliente().getCodCliente());
				validaOS.setCodPlanTarif(sessionData.getCliente().getCodPlanTarif());
				validaOS.setNumAbonado(sessionData.getAbonados()[0].getNumAbonado());
			    logger.debug("validaOossPendPlan():inicio");
				validaOS = delegate.validaOossPendPlan(validaOS);
				logger.debug("validaOossPendPlan():fin");
				String codOssP=validaOS.getCodigo();
				codOssP=codOssP==null?"":codOssP.trim();
				if(codOssP.equals("1")){
					//siguiente="noContinuaOS";
					siguiente = "ErrorEnActionDeCarga";
					String osInvalida = global.getValor("osPendiente");
					session.setAttribute("error", osInvalida);
					continua=false;
				}
				
				
			}
			/***
			 * @author  rlozano
			 * @description se comenta para q la orden de servicio pueda ejecutarse a través de cliente
			 */
			/*else{
				siguiente="noContinuaOS";
				String osInvalida = global.getValor("osNoCliente");
				session.setAttribute("error", osInvalida);
				continua=false;
				
			}*/
			
			
			if (continua){
				
				 if(sessionData.getCodCliente()!=0){
			    	session.removeAttribute("error");
			    	logger.debug("obtenerListaAbonados:antes");
			    	abonadoLista = delegate.obtenerListaAbonados(sessionData.getCliente());
			    	logger.debug("obtenerListaAbonados:despues");
			    	if(abonadoLista!=null){
			    		isListAbonados=true;
			    		abonados = abonadoLista.getAbonados();
				    	abonados[0].setNumAbonado(0);
				    	abonadoLista.setAbonados(abonados);
				    	//sessionData.setAbonados(abonadoLista.getAbonados());
			    	}
			    }
				
			    try{	
			    	
			    	UsuarioDTO usuario=new UsuarioDTO();//vendedor
			    	
					usuario.setNombre(sessionData.getUsuario());
					usuario= delegate.obtenerVendedor(usuario);

			    	ParametrosCondicionesCPUDTO parametros = new ParametrosCondicionesCPUDTO();
			    	parametros.setCodOOSS(sessionData.getCodOrdenServicio());
			    	parametros.setCombinatoriaGenerada("-");
			    	parametros.setUsuario(String.valueOf(usuario.getCodigo()));
			    	parametros.setCodPlanTarifSelec(sessionData.getCliente().getCodPlanTarif());
			    	parametros.setTipoPlanTarifDestino(sessionData.getCliente().getCodTipoPlan());
			    	JCondicionesComerciales jCondicionesComerciales =new JCondicionesComerciales();
			    	retornoDTO=jCondicionesComerciales.getCondicionesComercialesOss(abonadoLista,parametros);
					
					
			    }
			    catch(ManReqException e){
			    	e=(ManReqException)e.getCause();
			    	retornoDTO.setCodigo(e.getCodigo());
			    	retornoDTO.setDescripcion(e.getDescripcionEvento());
			    	retornoDTO.setResultado(true);
			    }
			}
			    
			    if (!("0".equals(retornoDTO.getCodigo()))){
					siguiente="ErrorEnActionDeCarga";
			    	String osInvalida = retornoDTO.getDescripcion();//global.getValor("valCondComOSS");
			    	session.setAttribute("error", osInvalida);
			    	continua=false;
				}
			
			
/*	    
			
			ClienteDTO cliente =sessionData.getCliente();
			AbonadoDTO abonado=new AbonadoDTO();
			AbonadoListDTO abonadoLista = new AbonadoListDTO();
			AbonadoDTO[] abonados=new AbonadoDTO[1];
			if(sessionData.getNumAbonado() != 0){
				abonado.setNumAbonado(sessionData.getNumAbonado());
				logger.debug("obtenerDatosAbonado :inicio");
				abonado=delegate.obtenerDatosAbonado(abonado);
				logger.debug("obtenerDatosAbonado :fin");
			}else{
				abonado.setNumAbonado(0);
			}
			abonados[0]=abonado;
			abonadoLista.setAbonados(abonados);
			sessionData.setAbonados(abonadoLista.getAbonados());
			cliente.setAbonados(abonadoLista);
			sessionData.setCliente(cliente);
			
*/	
			
			if (continua){
				AbonadoFrmkDTO abonadoFmk = new AbonadoFrmkDTO(abonado.getNumAbonado(), abonado.getNumCelular(), 
						                        abonado.getNombre(), cliente.getCodCliente());// = clienteVTA.getAbonado(Long.parseLong(idAbonado));
				
				OrdenServicioDTO ordenServicio = new OrdenServicioDTO(); 
				ordenServicio.setCliente(sessionData.getCliente());
				ordenServicio.setTipoComportamiento("PFRC");//PFRC PAFN
				//ordenServicio.setIdOrdenServicio(sessionData.getCodOrdenServicio());
						
				
				List productosContratadosList =new ArrayList();
				logger.debug("obtenerProductoContratado : inicio");
				ProductoContratadoListDTO prodContratado = delegate.obtenerProductoContratado(ordenServicio);
				logger.debug("obtenerProductoContratado : fin");
				if(prodContratado != null){
					
					productosContratadosFrecSess = pfu.generaProductoContratadoList(prodContratado, null,
			                abonado.getCodCliente(),abonado.getNumAbonado());
					ProductoContratadoDTO[] productosContratados = prodContratado.getProductosContratadosDTO();
					// Colocando en objeto NUEVO los datos rescatados desde la invocacion al metodo obtenerProductoContratado			
					for(int i=0; i<productosContratados.length; i++){
						ProdContratadoOfertadoDTO producto = new ProdContratadoOfertadoDTO();  // Objeto NUEVO que almacenara los datos a procesar
						producto.setComportamiento(productosContratados[i].getTipoComportamiento());  //desde productosContratados
						producto.setIdProdContratado(productosContratados[i].getIdProdContratado()); //desde ProductosContratados
						producto.setIndCondicionContratacion(productosContratados[i].getIndCondicionContratacion()); //desde ProductosContratados
						ProductoOfertadoDTO productoOfertado = productosContratados[i].getProdOfertado();
						producto.setCodProducto(productoOfertado.getIdentificadorProductoOfertado()); // desde ProductosOfertados
						producto.setNombre(productoOfertado.getDesProdOfertado()); // desde ProductosOfertados
						
						//----------- Para obtener el maximo de cada lista e indicador de auto afinidad -------------------------------------------------------------------------
						EspecProductoDTO especProducto = productoOfertado.getEspecificacionProducto();
						EspecServicioClienteListDTO especServClienteList = especProducto.getEspecServicioClienteList();
						EspecServicioListaListDTO especServLista = especServClienteList.getEspecSerLisList();
						EspecServicioListaDTO[] especServArreglo = especServLista.getEspecServicioListaList();
						String numMaximoLista = especServArreglo[0].getNumMaximoLista(); //para obtener el maximo de numeros de clientes por producto
						String indAutoAfinidad = especServArreglo[0].getIndAutoAfinidad(); // para obtener el indicador de auto afinidad
						producto.setMaximo(numMaximoLista);
						producto.setIndAutoAfinidad(indAutoAfinidad);
										
						//----------------------------------------------------------------------------------------------------------------------------
						
						NumeroListDTO numeroList = new NumeroListDTO();
						numeroList = productosContratados[i].getListaNumero();
						producto.setListaNumeros(numeroList);
						producto.setPermitidos(numeroList.getNumerosDTO().length); 
						productosContratadosList.add(producto);
									
						
						logger.debug("producto.getCodProducto()             "+ i +" :"+producto.getCodProducto());
						logger.debug("producto.getNombre()                  "+ i +" :"+producto.getNombre());
						logger.debug("producto.getComportamiento()          "+ i +" :"+producto.getComportamiento());
						logger.debug("producto.getIndCondicionContratacion()"+ i +" :"+producto.getIndCondicionContratacion());
						logger.debug("producto.getIdProdContratado()        "+ i +" :"+producto.getIdProdContratado());
						NumeroListDTO listaNum = producto.getListaNumeros();
						NumeroDTO[] numArr = listaNum.getNumerosDTO();
						for(int z=0; z<numArr.length; z++){
							logger.debug("Numero    " + numArr[z].getNro());
						}
						logger.debug("-------------------------------------------------------");
						
						
						
					}
					
				}
				
				
				session.removeAttribute("controlesList");
				XMLDefault objetoXML	= new XMLDefault();
			    DefaultPaginaCPUDTO objetoXMLSession = new DefaultPaginaCPUDTO();
			    SeccionDTO seccion=new SeccionDTO();
			    
			    ArrayList controlesList=new ArrayList();
			    objetoXMLSession = sessionData.getDefaultPagina();
			    seccion = objetoXML.obtenerSeccion(objetoXMLSession, "piePaginaCargosPAG", "CargosCondicionesRegistroSS");
			    ControlDTO control = seccion.obtControl("condicionesCK");
			    controlesList.add(control);
			    
			    
			    
			    session.setAttribute("controlesList", controlesList);
			   // log2(CLASS_NAME+"session.setAttribute(productosContratados, productosContratadosList);");
			    session.setAttribute("productosContratadosFrec", productosContratadosList);
				session.setAttribute("productosContratadosFrecSess", productosContratadosFrecSess);
				session.setAttribute("Abonado", abonadoFmk);
				ListaProdContratadosForm form1 = (ListaProdContratadosForm) form;
				// cuando carga la pagina por PRIMERA vez por defecto coloca el check marcado 
				if(form1.getCondicH()== null){
			    	form1.setCondicH("SI");//form1.setCondicH(control.getValorDefecto());
			    }
				
				if(form1.getGuardarCancelar()!=null){
					form1.setGuardarCancelar(""); // inicializa estado para validacion
				}
				
				form1.setEstadoValidacion(null);
				form1.setInicio(null);
				form1.setPersonalizados(false);
					
			
			} // del if continua
		} catch (Exception e) {					
			retornoDTO.setCodigo("NO HAY UN CODIGO DEFINIDO");
			retornoDTO.setDescripcion(e.getMessage());
			retornoDTO.setResultado(true);		
			
			if (e instanceof ManReqException) {				
				ManReqException me =(ManReqException)e.getCause();		
				if (me.getCodigo()!=null && !(me.getCodigo().equals(""))){
					retornoDTO.setCodigo(me.getCodigo());
					retornoDTO.setDescripcion(me.getDescripcionEvento());
					retornoDTO.setResultado(true);		
				} 
			}		
	    	String mensajeError = retornoDTO.getDescripcion();
	    	session.setAttribute("error", mensajeError);
	    	fwdError="ErrorEnActionDeCarga";	
			logger.error(e.getMessage(), e);	    	
		}
		if (fwdError!=null){return mapping.findForward(fwdError);}
		session.setAttribute("ultimaPagina","inicio");		
		logger.debug("execute():end");
		return mapping.findForward(siguiente);
		
	}
	
	
	public void log2(Object o)
	{
		System.out.println(o);
	}
}
