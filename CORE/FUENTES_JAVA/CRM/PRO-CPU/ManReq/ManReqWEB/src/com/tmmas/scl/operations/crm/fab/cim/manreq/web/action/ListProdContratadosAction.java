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
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.DefaultPaginaCPUDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ParametrosCondicionesCPUDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ProdContratadoOfertadoDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.SeccionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.exception.ManReqException;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate.ManageRequestBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.ListaProdContratadosForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.Global;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.JCondicionesComerciales;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.PaqueteWeb;

public class ListProdContratadosAction extends BaseAction {

	private final Logger logger = Logger.getLogger(ListProdContratadosAction.class);

	private Global global = Global.getInstance();

	private ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();

	private PaqueteWeb productos;

	public ActionForward executeAction(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		String log = global.getValor("web.log");
		log = System.getProperty("user.dir") + log;
		PropertyConfigurator.configure(log);

		RetornoDTO retornoDTO = new RetornoDTO();
		retornoDTO.setCodigo("0");
		String fwdError = null;

		logger.debug("execute():start");
		boolean continua = true;
		String nombreAction = "cargarProductos";
		ClienteOSSesionDTO sessionData = new ClienteOSSesionDTO();
		HttpSession session = request.getSession(false);
		session.setAttribute("ultimaPagina", "inicio");
		session.removeAttribute("productosContratados");
		session.removeAttribute("productosContratadosListOriginal");
		session.removeAttribute("listaClientes"); // limpiar la lista de session CAMBIAR ESTO AL NUEVO ACTION QUE CONTROLARA LA LISTA?????????

		sessionData = (ClienteOSSesionDTO) session.getAttribute("ClienteOOSS");

		// Lectura de archivo XML de configuracion, parseo y carga en objeto de sesion
		DefaultPaginaCPUDTO definicionPagina = new DefaultPaginaCPUDTO();
		String dirXML = global.getValor("configAfines.xml");
		String dir = System.getProperty("user.dir") + dirXML;
		logger.debug("dir=" + dir);
		ParseoXML parseo = new ParseoXML();
		logger.debug("leyendo y parseando XML configuración:antes");
		definicionPagina = parseo.cargaXML(dir);
		logger.debug("leyendo y parseando XML configuracion:despues");
		sessionData.setDefaultPagina(definicionPagina);

		/*
		 * if(sessionData.getCodCliente()!= 0) { logger.debug("obtenerListaAbonados:antes"); listaAbonados = delegate.obtenerListaAbonados(sessionData.getCliente()); logger.debug("obtenerListaAbonados:despues"); sessionData.setAbonados(listaAbonados.getAbonados()); }else{ logger.debug("obtenerDatosAbonado:antes"); AbonadoDTO buscaAbonado=new AbonadoDTO();
		 * buscaAbonado.setNumAbonado(sessionData.getNumAbonado()); retornoAbonado = delegate.obtenerDatosAbonado(buscaAbonado); logger.debug("obtenerDatosAbonado:despues"); AbonadoDTO[] abonados=new AbonadoDTO[1]; abonados[0]=retornoAbonado; listaAbonados = new AbonadoListDTO(); listaAbonados.setAbonados(abonados); sessionData.setAbonados(listaAbonados.getAbonados()); }
		 */

		/*
		 * ClienteDTO cliente =sessionData.getCliente(); AbonadoDTO abonado=new AbonadoDTO(); AbonadoListDTO abonadoLista = new AbonadoListDTO(); AbonadoDTO[] abonados=new AbonadoDTO[1]; if(sessionData.getNumAbonado() != 0){ abonado.setNumAbonado(sessionData.getNumAbonado()); logger.debug("obtenerDatosAbonado :inicio"); abonado=delegate.obtenerDatosAbonado(abonado);
		 * logger.debug("obtenerDatosAbonado :fin"); }else{ abonado.setNumAbonado(0); } abonados[0]=abonado; abonadoLista.setAbonados(abonados); sessionData.setAbonados(abonadoLista.getAbonados()); cliente.setAbonados(abonadoLista); sessionData.setCliente(cliente);
		 */

		AbonadoListDTO listaAbonados = null;
		boolean isListAbonados = false;

		try {
			if (sessionData.getCodCliente() != 0) {
				session.removeAttribute("error");
				logger.debug("obtenerListaAbonados:antes");
				listaAbonados = delegate.obtenerListaAbonados(sessionData.getCliente());
				logger.debug("obtenerListaAbonados:despues");
				if (listaAbonados != null) {
					isListAbonados = true;
					AbonadoDTO[] abonados = listaAbonados.getAbonados();
					abonados[0].setNumAbonado(0);
					listaAbonados.setAbonados(abonados);
					sessionData.setAbonados(listaAbonados.getAbonados());
				}

				// validar ordenes pendientes plan
				ValidaOOSSDTO validaOS = new ValidaOOSSDTO();
				validaOS.setCodCliente(sessionData.getCliente().getCodCliente());
				validaOS.setCodPlanTarif(sessionData.getCliente().getCodPlanTarif());
				validaOS.setNumAbonado(sessionData.getAbonados()[0].getNumAbonado());
				logger.debug("validaOossPendPlan():inicio");
				validaOS = delegate.validaOossPendPlan(validaOS);
				logger.debug("validaOossPendPlan():fin");
				String codOssP = validaOS.getCodigo();
				codOssP = codOssP == null ? "" : codOssP.trim();
				if (codOssP.equals("1")) {
					//nombreAction = "noContinuaOS";
					nombreAction = "ErrorEnActionDeCarga";
					String osInvalida = global.getValor("osPendiente");
					session.setAttribute("error", osInvalida);
					continua = false;
				}

			} else {
				//nombreAction = "noContinuaOS";
				nombreAction = "ErrorEnActionDeCarga";
				String osInvalida = global.getValor("osNoAbonado");
				session.setAttribute("error", osInvalida);
				continua = false;
			}

			/**
			 * @author : rlozano
			 * @Description : Valida Condiciones Comerciales
			 */

			if (continua) {
				try {
					UsuarioDTO usuario = new UsuarioDTO();// vendedor

					usuario.setNombre(sessionData.getUsuario());
					usuario = delegate.obtenerVendedor(usuario);

					ParametrosCondicionesCPUDTO parametros = new ParametrosCondicionesCPUDTO();
					parametros.setCodOOSS(sessionData.getCodOrdenServicio());
					parametros.setCombinatoriaGenerada("-");
					parametros.setUsuario(String.valueOf(usuario.getCodigo()));
					parametros.setCodPlanTarifSelec(sessionData.getCliente().getCodPlanTarif());
					parametros.setTipoPlanTarifDestino(sessionData.getCliente().getCodTipoPlan());

					JCondicionesComerciales jCondicionesComerciales = new JCondicionesComerciales();
					retornoDTO = jCondicionesComerciales.getCondicionesComercialesOss(listaAbonados, parametros);
				} catch (ManReqException e) {
					e = (ManReqException) e.getCause();
					retornoDTO.setCodigo(e.getCodigo());
					retornoDTO.setDescripcion(e.getDescripcionEvento());
					retornoDTO.setResultado(true);
					logger.error(e.getMessage(), e);
				}
				if (!("0".equals(retornoDTO.getCodigo()))) {
					nombreAction = "ErrorEnActionDeCarga";
					String osInvalida = retornoDTO.getDescripcion();// global.getValor("valCondComOSS");
					session.setAttribute("error", osInvalida);
					continua = false;
				}
			}

			ClienteDTO cliente = sessionData.getCliente();
			cliente.setAbonados(listaAbonados);
			sessionData.setCliente(cliente);

			if (continua) { // puede procesar la orden de servicio, ya que el cliente no tiene OS pendiente y tampoco ingreso a nivel de abonado

				OrdenServicioDTO ordenServicio = new OrdenServicioDTO();
				ordenServicio.setCliente(sessionData.getCliente());
				ordenServicio.setTipoComportamiento("PAFN");

				List productosContratadosList = null;
				List productosContratadosListOriginal = null;
				logger.debug("obtenerProductoContratado : inicio");
				ProductoContratadoListDTO prodContratado = delegate.obtenerProductoContratado(ordenServicio);
				logger.debug("obtenerProductoContratado : fin");
				if (prodContratado != null) {
					productosContratadosList = new ArrayList();
					productosContratadosListOriginal = new ArrayList();
					ProductoContratadoDTO[] productosContratados = prodContratado.getProductosContratadosDTO();
					// Colocando en objeto NUEVO los datos rescatados desde la invocacion al metodo obtenerProductoContratado
					for (int i = 0; i < productosContratados.length; i++) {
						ProdContratadoOfertadoDTO producto = new ProdContratadoOfertadoDTO(); // Objeto NUEVO que almacenara los datos a procesar
						producto.setComportamiento(productosContratados[i].getTipoComportamiento()); // desde productosContratados
						producto.setIdProdContratado(productosContratados[i].getIdProdContratado()); // desde ProductosContratados
						producto.setIndCondicionContratacion(productosContratados[i].getIndCondicionContratacion()); // desde ProductosContratados
						ProductoOfertadoDTO productoOfertado = productosContratados[i].getProdOfertado();
						producto.setCodProducto(productoOfertado.getIdentificadorProductoOfertado()); // desde ProductosOfertados
						producto.setNombre(productoOfertado.getDesProdOfertado()); // desde ProductosOfertados
						producto.setMaxModificaciones(Integer.parseInt(productoOfertado.getMaxModificaciones())); // desde ProductosOfertados

						NumeroDTO numero = delegate.obtieneModificacionesProducto(productosContratados[i]);

						producto.setCantModificaciones(Integer.parseInt(numero.getNro()));

						// ----------- Para obtener el maximo de cada lista e indicador de auto afinidad -------------------------------------------------------------------------
						EspecProductoDTO especProducto = productoOfertado.getEspecificacionProducto();
						EspecServicioClienteListDTO especServClienteList = especProducto.getEspecServicioClienteList();
						EspecServicioListaListDTO especServLista = especServClienteList.getEspecSerLisList();
						EspecServicioListaDTO[] especServArreglo = especServLista.getEspecServicioListaList();
						String numMaximoLista = especServArreglo[0].getNumMaximoLista(); // para obtener el maximo de numeros de clientes por producto
						String indAutoAfinidad = especServArreglo[0].getIndAutoAfinidad(); // para obtener el indicador de auto afinidad
						producto.setMaximo(numMaximoLista);
						producto.setIndAutoAfinidad(indAutoAfinidad);

						// ----------------------------------------------------------------------------------------------------------------------------

						NumeroListDTO numeroList = new NumeroListDTO();
						numeroList = productosContratados[i].getListaNumero();
						producto.setListaNumeros(numeroList);
						producto.setPermitidos(numeroList.getNumerosDTO().length);
						productosContratadosList.add(producto);

						ProdContratadoOfertadoDTO productoOriginal = (ProdContratadoOfertadoDTO) producto.clone();
						productosContratadosListOriginal.add(productoOriginal);

						logger.debug("producto.getCodProducto()             " + i + " :" + producto.getCodProducto());
						logger.debug("producto.getNombre()                  " + i + " :" + producto.getNombre());
						logger.debug("producto.getComportamiento()          " + i + " :" + producto.getComportamiento());
						logger.debug("producto.getIndCondicionContratacion()" + i + " :" + producto.getIndCondicionContratacion());
						logger.debug("producto.getIdProdContratado()        " + i + " :" + producto.getIdProdContratado());
						NumeroListDTO listaNum = producto.getListaNumeros();
						NumeroDTO[] numArr = listaNum.getNumerosDTO();
						for (int z = 0; z < numArr.length; z++) {
							logger.debug("Numero    " + numArr[z].getNro());
						}
						logger.debug("-------------------------------------------------------");

					}

				}

				// List productosContratadosListOriginal = new ArrayList();

				// productosContratadosListOriginal = productosContratadosList; // Deja los valores de los prod. contratados en una lista original que se utilizara para comparacion
				session.setAttribute("productosContratadosListOriginal", productosContratadosListOriginal);

				// (+)06-12-07 Para setear la lista de numeros original obtenida

				// ----Crea una lista con TODOS los clientes de los productos cargados originalmente desde base de datos
				ArrayList listaClientesOriginal = new ArrayList();

				for (int x = 0; x < productosContratadosList.size(); x++) {
					NumeroListDTO listaNumPorProd = new NumeroListDTO();
					ProdContratadoOfertadoDTO productoObtenido = new ProdContratadoOfertadoDTO();
					productoObtenido = (ProdContratadoOfertadoDTO) productosContratadosList.get(x);
					listaNumPorProd = productoObtenido.getListaNumeros();
					NumeroDTO[] numPorProdArr = listaNumPorProd.getNumerosDTO();
					for (int z = 0; z < numPorProdArr.length; z++) {
						ClienteDTO clienteNuevo = new ClienteDTO();
						clienteNuevo.setCodCliente(Long.parseLong(numPorProdArr[z].getNro()));
						listaClientesOriginal.add(clienteNuevo);
					}
				}
				session.setAttribute("listaClientesOriginal", listaClientesOriginal);

				// ----Mostrar la lista con todos los clientes originales desde base de datos
				for (int j = 0; j < listaClientesOriginal.size(); j++) {
					ClienteDTO clienteLista = new ClienteDTO();
					clienteLista = (ClienteDTO) listaClientesOriginal.get(j);
					logger.debug("cliente [" + j + "]" + clienteLista.getCodCliente());
				}

				// (-)

				/*
				 * Iterator lista = productosContratados.iterator(); while (lista.hasNext()){ System.out.println("OBJETO :"+lista.next()); }
				 */

				session.removeAttribute("controlesList");
				XMLDefault objetoXML = new XMLDefault();
				DefaultPaginaCPUDTO objetoXMLSession = new DefaultPaginaCPUDTO();
				SeccionDTO seccion = new SeccionDTO();

				ArrayList controlesList = new ArrayList();
				objetoXMLSession = sessionData.getDefaultPagina();
				seccion = objetoXML.obtenerSeccion(objetoXMLSession, "piePaginaCargosPAG", "CargosCondicionesRegistroSS");
				controlesList.add(seccion.obtControl("condicionesCK"));

				session.setAttribute("controlesList", controlesList);
				session.setAttribute("productosContratados", productosContratadosList);

				ListaProdContratadosForm form1 = (ListaProdContratadosForm) form;
				// cuando carga la pagina por PRIMERA vez por defecto coloca el check marcado
				if (form1.getCondicH() == null) {
					form1.setCondicH("SI");
				}

				if (form1.getGuardarCancelar() != null) {
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
				ManReqException me = (ManReqException) e.getCause();
				if (me.getCodigo() != null && !(me.getCodigo().equals(""))) {
					retornoDTO.setCodigo(me.getCodigo());
					retornoDTO.setDescripcion(me.getDescripcionEvento());
					retornoDTO.setResultado(true);
				}
			}
			String mensajeError = retornoDTO.getDescripcion();
			session.setAttribute("error", mensajeError);
			fwdError = "ErrorEnActionDeCarga";
			logger.error(e.getMessage(), e);
		}
		if (fwdError != null) {
			return mapping.findForward(fwdError);
		}

		logger.debug("siguiente (nombreAction) :" + nombreAction);
		logger.debug("execute():end");
		return mapping.findForward(nombreAction);

	}

}
