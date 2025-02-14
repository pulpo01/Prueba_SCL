package com.tmmas.scl.operations.crm.fab.cim.manreq.web.action;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.dozer.util.mapping.DozerBeanMapper;
import net.sf.dozer.util.mapping.MapperIF;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.BaseAction;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.UsuarioDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.CargosDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.ObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.CartaDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.IOOSSDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.RegistrarOossEnLineaDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.RegistroNivelOOSSDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.framework.marketSalesDomain.contactLeadProspectABE.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.CabeceraArchivoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RegCargosDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.ResultadoRegCargosDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.CargosObtenidosDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.ParamMantencionProductoDTO;
import com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.OfertaComercialDTO;
import com.tmmas.scl.operations.crm.f.sel.negsal.helper.NegSalUtils;
import com.tmmas.scl.operations.crm.fab.cim.manreq.businessObject.bo.XMLDefault;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.DefaultPaginaCPUDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.SeccionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.TablaCargosDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.exception.ManReqException;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate.ManageRequestBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.CargosForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.ResumenForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.Global;

public class RegistrarAnulaSolicitudAction extends BaseAction {
	private final Logger logger = Logger.getLogger(RegistrarAnulaSolicitudAction.class);
	private Global global = Global.getInstance();
	//private static final String SIGUIENTE = "factura";
	private static final String PAGINA = "resultado";//"factura";
	private ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();

	public ActionForward executeAction(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	throws Exception {

		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);
		logger.debug("execute():start");
		
		HttpSession session = request.getSession(false);
		session.removeAttribute("mensajeError"); //EV
		
		try{
			ClienteOSSesionDTO sessionData = new ClienteOSSesionDTO();
			sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");	
			AbonadoDTO clienteAbo = (AbonadoDTO)session.getAttribute("clienteAbo");
			CargosObtenidosDTO cargosRegistro;
			cargosRegistro = sessionData.getCargosObtenidos();
			
			IOOSSDTO[] ordenServicioArr = (IOOSSDTO[])session.getAttribute("ordenServicioArr");
			
			ArrayList abonados = new ArrayList();
			abonados.add(clienteAbo);
			session.setAttribute("Abonados", abonados);
			
			ParamMantencionProductoDTO paramOServicio = new ParamMantencionProductoDTO();
			
		    paramOServicio.setCliente(sessionData.getCliente());
		    paramOServicio.setAbonado(sessionData.getAbonados()[0]);
		    paramOServicio.setNumOrdenServicio(clienteAbo!=null?String.valueOf(clienteAbo.getNumeroOS()):"0");
		    paramOServicio.setCodOrdenServicio(String.valueOf(sessionData.getCodOrdenServicio()));
		    paramOServicio.setCodProducto(1);
	    
		    
		    if(sessionData.getCodCliente()!= 0){
		    	paramOServicio.setTipInter(8);
		    	paramOServicio.setCodInter(sessionData.getCliente().getCodCliente());
		    	paramOServicio.setSujeto("C");
		    }else{
		    	paramOServicio.setTipInter(1);
		    	paramOServicio.setCodInter(sessionData.getAbonados()[0].getNumAbonado());
		    	paramOServicio.setSujeto("A");
		    	
		    }
	
		    paramOServicio.setUsuario(sessionData.getUsuario());
		    Date fecha = new Date();
		    Timestamp fechaActual = new Timestamp(fecha.getTime());
		    paramOServicio.setFecha(fechaActual);
		    //paramOServicio.setComentario(sessionData.getComentarioOS());
		    paramOServicio.setCodActAbo(sessionData.getCodActAbo());	    
		    		
		    XMLDefault objetoXML    = new XMLDefault();
			DefaultPaginaCPUDTO objetoXMLSession = new DefaultPaginaCPUDTO();
			SeccionDTO seccion=new SeccionDTO();
			objetoXMLSession = sessionData.getDefaultPagina();
			seccion = objetoXML.obtenerSeccion(objetoXMLSession, "cargosPAG", "CondicionesComercialesSS");
		    
		    	    
		    CargosForm cargosForm = (CargosForm)session.getAttribute("CargosForm");
		    paramOServicio.setCodTipoDocumento(seccion.obtControl("TipoDocumentoCB").getValorDefecto());
		    paramOServicio.setModPago(seccion.obtControl("ModalidadCB").getValorDefecto());
		    paramOServicio.setACiclo(cargosForm.getRbCiclo());
		    paramOServicio.setComentario(((ResumenForm)form).getComentario());
		    
	
			if( (cargosForm!=null&&cargosForm.getRbCiclo().equals("NO")) || (cargosForm==null) ){
				paramOServicio.setRegistroCargos(null);
			}else{
				if(cargosRegistro.isACiclo()&&cargosRegistro.getOcacionales()!=null&&cargosRegistro.getOcacionales().getCargos()!=null){
					CargosDTO[] cargos = cargosRegistro.getOcacionales().getCargos();
					List cargosList = new ArrayList();
	
					for(int i = 0;i<cargos.length;i++){
						if(aplicaCargo(cargos[i].getPrecio().getCodigoConcepto(),cargosForm)){
							cargosList.add(cargos[i]);
						}
					}
					CargosDTO [] cargosAprobados= new CargosDTO[cargosList.size()];
					for(int a = 0 ; a<cargosList.size();a++){
						cargosAprobados[a] = (CargosDTO)cargosList.get(a);
					}
					cargosRegistro.getOcacionales().setCargos(cargosAprobados);
				}else{
					paramOServicio.setRegistroCargos(null);
				}
				paramOServicio.setRegistroCargos(cargosRegistro);
			}
			
			
	        UsuarioDTO usuario = new UsuarioDTO();
	        usuario.setNombre(sessionData.getUsuario());
	        usuario = delegate.obtenerVendedor(usuario);
	        
	        paramOServicio.setCodVendedor(usuario.getCodigo());
	        
			
		    
		    logger.debug("Parametros Orden de Servicio");
		    logger.debug("paramOServicio.getCliente().getCodCliente()              :"+paramOServicio.getCliente().getCodCliente());
		    logger.debug("paramOServicio.getAbonado().getNumAbonado()              :"+paramOServicio.getAbonado().getNumAbonado());
		    logger.debug("paramOServicio.getNumOrdenServicio()                     :"+paramOServicio.getNumOrdenServicio());
		    logger.debug("paramOServicio.getCodOrdenServicio()                     :"+paramOServicio.getCodOrdenServicio());
		    logger.debug("paramOServicio.getCodProducto()                          :"+paramOServicio.getCodProducto());
		    logger.debug("paramOServicio.getTipInter()                             :"+paramOServicio.getTipInter());
		    logger.debug("paramOServicio.getCodInter()                             :"+paramOServicio.getCodInter());
		    logger.debug("paramOServicio.getSujeto()                               :"+paramOServicio.getSujeto());
		    logger.debug("paramOServicio.getUsuario()                              :"+paramOServicio.getUsuario());
		    logger.debug("paramOServicio.getFecha()                                :"+paramOServicio.getFecha());
		    logger.debug("paramOServicio.getComentario()                           :"+paramOServicio.getComentario());
		    logger.debug("paramOServicio.getCodActAbo()                            :"+paramOServicio.getCodActAbo());
		    logger.debug("paramOServicio.getCodTipoDocumento()                     :"+paramOServicio.getCodTipoDocumento());
		    logger.debug("paramOServicio.getModPago()                              :"+paramOServicio.getModPago());
		    logger.debug("paramOServicio.getCodVendedor()                          :"+paramOServicio.getCodVendedor());
		    logger.debug("paramOServicio.getACiclo()                               :"+paramOServicio.getACiclo());
		    
		    
		    //1. registraNivelOoss
		    RegistroNivelOOSSDTO registroNivel = new RegistroNivelOOSSDTO();
			registroNivel.setNumAbonado(paramOServicio.getAbonado().getNumAbonado());
			registroNivel.setCodCliente(paramOServicio.getCliente().getCodCliente());
			registroNivel.setCodTipMod(paramOServicio.getCodActAbo());
			registroNivel.setTipSujeto(paramOServicio.getSujeto());
			registroNivel.setFecModifica(paramOServicio.getFecha());
			registroNivel.setNomUsuaOra(paramOServicio.getUsuario());
			
			logger.debug("registroNivel.getNumAbonado()[" +  registroNivel.getNumAbonado() + "]");
			logger.debug("registroNivel.getCodCliente()[" + registroNivel.getCodCliente() + "]");
			logger.debug("registroNivel.getCodTipMod()[" + registroNivel.getCodTipMod() + "]");
			logger.debug("registroNivel.getTipSujeto()[" + registroNivel.getTipSujeto() + "]");
			logger.debug("registroNivel.getFecModifica()[" + registroNivel.getFecModifica() + "]");
			logger.debug("registroNivel.getNomUsuaOra()[" + registroNivel.getNomUsuaOra() + "]");
					
			logger.debug("registraNivelOoss() :inicio");
			RetornoDTO retorno = delegate.registraNivelOoss(registroNivel);
			logger.debug("registraNivelOoss() :fin");
			
			
			//2. anulaOossPendPlan  *** se ejecuta el metodo de forma iterativa???
			IOOSSDTO ordenServicio = null;
			IOOSSDTO ordenServiRes = delegate.anulaOossPendPlan(ordenServicioArr);
			/*for(int i=0;i<ordenServicioArr.length;i++)
			{
				ordenServicio = ordenServicioArr[i];
				IOOSSDTO ordenServiRes = delegate.anulaOossPendPlan(ordenServicio);
			}*/
			
			/*
			//3. obtenerSecuencia
			SecuenciaDTO secuencia=new SecuenciaDTO();
		    logger.debug("obtenerSecuencia:antes");
			secuencia.setNomSecuencia("GA_SEQ_TRANSACABO");
			secuencia = delegate.obtenerSecuencia(secuencia);
					
			//4. insertarCarta
			CartaDTO carta = new CartaDTO();
			if(secuencia != null){
				carta.setIdSecuencia(secuencia.getNumSecuencia());
			}
			carta.setIdSecuenciaOOSS(Long.parseLong(paramOServicio.getNumOrdenServicio()));
			carta.setCodActAbo(paramOServicio.getCodActAbo());
			carta.setCodError(0);
			carta.setCodProducto(1);
			carta.setTextoCarta(paramOServicio.getComentario());
				*/	
			
			
			//3. registrarOOSSEnLinea
			RegistrarOossEnLineaDTO registroLinea = new RegistrarOossEnLineaDTO();
			registroLinea.setCodOS(paramOServicio.getCodOrdenServicio());    
			registroLinea.setNumOs(Long.parseLong(paramOServicio.getNumOrdenServicio()));  
			registroLinea.setCodProducto(1);
			registroLinea.setTipInter(paramOServicio.getTipInter());
			registroLinea.setCodInter(paramOServicio.getCodInter());
			registroLinea.setUsuario(paramOServicio.getUsuario());
			registroLinea.setFecha(paramOServicio.getFecha());
			registroLinea.setComentario(paramOServicio.getComentario()); 
			registroLinea.setCodEstado(0);
			registroLinea.setCodModulo("GA");
			registroLinea.setIndGestor(0);
			
			logger.debug("registroLinea.getCodOS()[" + registroLinea.getCodOS() + "]");
			logger.debug("registroLinea.getNumOs()[" + registroLinea.getNumOs() + "]");
			logger.debug("registroLinea.getCodProducto()[" + registroLinea.getCodProducto() + "]");
			logger.debug("registroLinea.getTipInter()[" + registroLinea.getTipInter() + "]");
			logger.debug("registroLinea.getCodInter()[" + registroLinea.getCodInter() + "]");
			logger.debug("registroLinea.getUsuario()[" + registroLinea.getUsuario() + "]");
			logger.debug("registroLinea.getFecha()[" + registroLinea.getFecha() + "]");
			logger.debug("registroLinea.getComentario()[" + registroLinea.getComentario() + "]");
			logger.debug("registroLinea.getCodEstado()[" + registroLinea.getCodEstado() + "]");
			logger.debug("registroLinea.getCodModulo()[" + registroLinea.getCodModulo() + "]");
			logger.debug("registroLinea.getIndGestor()[" + registroLinea.getIndGestor() + "]");
					
			retorno = null;
			logger.debug("registrarOOSSEnLinea() :inicio");
			retorno = delegate.registrarOOSSEnLinea(registroLinea);
			logger.debug("registrarOOSSEnLinea() :fin");
			
			
			//Construccion y Registro de Cargos
			ObtencionCargosDTO obtencionCargos = sessionData.getCargosObtenidos().getOcacionales();
			RegCargosDTO regCargos = construirRegistroCargos(obtencionCargos);
			
			CabeceraArchivoDTO cabecera=new CabeceraArchivoDTO();
			cabecera.setPlanComercialCliente(String.valueOf(sessionData.getCliente().getCodPlanCom()));
			cabecera.setCodigoCliente(String.valueOf(registroNivel.getCodCliente()));
			cabecera.setFacturaCiclo(true);
			cabecera.setNumeroVenta(0);
			cabecera.setNumeroTransaccionVenta(0);
			cabecera.setCodigoDocumento(String.valueOf(1));  // corresponde al antiguo valor que estaba seteado en el xml de configuracion
			cabecera.setCodModalidadVenta(String.valueOf(1)); // corresponde al antiguo valor seteado en el xml de configuracion
			cabecera.setCodigoVendedor(String.valueOf(paramOServicio.getCodVendedor()));
			regCargos.setObjetoSesion(cabecera);
		
			parametrosRegistrarCargos(regCargos);
		} catch (ManReqException e) {
			String msg="Error al realizar la anulación";
			
			if(e.getCodigo()==null || e.getCodigo().equals("0")){
				logger.debug("ERROR (ManReqException) :"+e.getMessage());
				if (e.getMessage()!=null)	msg = e.getMessage();
				
			}else{
				logger.debug("ERROR (ManReqException) :"+e.getDescripcionEvento());
				msg  = e.getDescripcionEvento();
			}
			
			session.setAttribute("mensajeError", msg); //EV
			
		} catch (Exception e) {
			String msg="Error al realizar la anulación";
			logger.debug("ERROR (Exception) :"+e.getMessage());
			if (e.getMessage()!=null)	msg = e.getMessage();
			
			session.setAttribute("mensajeError", msg); //EV	
		}
		
		
		
		logger.debug("execute():end");
		return mapping.findForward(PAGINA);
	
		
	}
	
	public boolean aplicaCargo(String codConcepto, CargosForm cargosForm){
		TablaCargosDTO[] tablaCargos = cargosForm.getTablaCargos();
		String checks[] = cargosForm.getSelectedValorCheck();
		if(tablaCargos!=null&&tablaCargos.length>0){
			if(checks!=null&&checks.length>0){
				for(int x = 0;x<checks.length;x++){
					for(int i = 0 ; i<tablaCargos.length; i++){
						if(checks[i].equalsIgnoreCase(tablaCargos[x].getValorCheck())){
							return true;
						}
					}
				}
			}else{
				return false;
			}
		}else{
			return false;
		}
		return false;
	}
	
	
	
	public RegCargosDTO construirRegistroCargos(com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.ObtencionCargosDTO Obtencioncargos) throws ManReqException{ 
		
		logger.debug("construirRegistroCargos():inicio");
		RegCargosDTO retRegCargos=null;
		
		logger.debug("::::::::::PARAMETROS ENTRADA CONSTRUIR CARGOS::::::::");
		logger.debug(":::::::::::::::::::::::::::::::::::::::::::::::::::::");
		logger.debug("ObtencionCargosDTO");
		logger.debug("monto               :"+Obtencioncargos.getMonto());
		logger.debug("tipo                :"+Obtencioncargos.getTipo());
		logger.debug("codigoConcepto      :"+Obtencioncargos.getCodigoConcepto());
		logger.debug("DescripcionConcepto :"+Obtencioncargos.getDescripcionConcepto());
		logger.debug("MinDescuento        :"+Obtencioncargos.getMinDescuento());
		logger.debug("MaxDescuento        :"+Obtencioncargos.getMaxDescuento());
		logger.debug("TipoAplicacion      :"+Obtencioncargos.getTipoAplicacion());
		logger.debug("NumAbonado          :"+Obtencioncargos.getNumAbonado());
		logger.debug("Aprobacion          :"+Obtencioncargos.isAprobacion());
		logger.debug("----------------------------------------------------------");
		logger.debug("CargosDTO");
		if (Obtencioncargos.getCargos()!= null) {
			for(int i=0; i<Obtencioncargos.getCargos().length;i++){
				logger.debug("IdProducto             :"+Obtencioncargos.getCargos()[i].getIdProducto());
				logger.debug("Cantidad               :"+Obtencioncargos.getCargos()[i].getCantidad());
				
				logger.debug("--------------------------------------------------------------------------");
				logger.debug("AtributosCargoDTO");
				logger.debug("getAtributo().getCuotas()            :"+Obtencioncargos.getCargos()[i].getAtributo().getCuotas());
				logger.debug("getAtributo().getFechaAplicacion()   :"+Obtencioncargos.getCargos()[i].getAtributo().getFechaAplicacion());
				logger.debug("getAtributo().getTipoProducto()      :"+Obtencioncargos.getCargos()[i].getAtributo().getTipoProducto());
				logger.debug("getAtributo().getClaseProducto()     :"+Obtencioncargos.getCargos()[i].getAtributo().getClaseProducto());
				logger.debug("getAtributo().getCicloFacturacion()  :"+Obtencioncargos.getCargos()[i].getAtributo().getCicloFacturacion());
				logger.debug("getAtributo().getCodigoArticuloServicio() :"+Obtencioncargos.getCargos()[i].getAtributo().getCodigoArticuloServicio());
				logger.debug("getAtributo().getNumAbonado()             :"+Obtencioncargos.getCargos()[i].getAtributo().getNumAbonado());
				logger.debug("getAtributo().isRecurrente()              :"+Obtencioncargos.getCargos()[i].getAtributo().isRecurrente());
				logger.debug("getAtributo().isObligatorio()             :"+Obtencioncargos.getCargos()[i].getAtributo().isObligatorio());
				logger.debug("getAtributo().isCiclo()                   :"+Obtencioncargos.getCargos()[i].getAtributo().isCiclo());
				
				logger.debug("--------------------------------------------------------------------------");
				logger.debug("PrecioDTO");
				logger.debug("getPrecio().getMonto()               :"+Obtencioncargos.getCargos()[i].getPrecio().getMonto());
				logger.debug("getPrecio().getCodigoConcepto()      :"+Obtencioncargos.getCargos()[i].getPrecio().getCodigoConcepto());
				logger.debug("getPrecio().getDescripcionConcepto() :"+Obtencioncargos.getCargos()[i].getPrecio().getDescripcionConcepto());
				logger.debug("getPrecio().getFechaAplicacion()     :"+Obtencioncargos.getCargos()[i].getPrecio().getFechaAplicacion());
				logger.debug("getPrecio().getValorMaximo()         :"+Obtencioncargos.getCargos()[i].getPrecio().getValorMaximo());
				logger.debug("getPrecio().getValorMinimo()         :"+Obtencioncargos.getCargos()[i].getPrecio().getValorMinimo());
				logger.debug("getPrecio().getIndicadorAutMan()     :"+Obtencioncargos.getCargos()[i].getPrecio().getIndicadorAutMan());
				
				logger.debug("--------------------------------------------------------------------------");
				logger.debug("AtributosMigracionDTO");
				logger.debug("getPrecio().getDatosAnexos().getInd_paquete() :"+Obtencioncargos.getCargos()[i].getPrecio().getDatosAnexos().getInd_paquete());
				logger.debug("getPrecio().getDatosAnexos().getInd_cuota()   :"+Obtencioncargos.getCargos()[i].getPrecio().getDatosAnexos().getInd_cuota());
				logger.debug("getPrecio().getDatosAnexos().getInd_equipo()  :"+Obtencioncargos.getCargos()[i].getPrecio().getDatosAnexos().getInd_equipo());
				logger.debug("getPrecio().getDatosAnexos().getCod_tecnologia() :"+Obtencioncargos.getCargos()[i].getPrecio().getDatosAnexos().getCod_tecnologia());
				logger.debug("getPrecio().getDatosAnexos().getCodTipPlantarifOrig() :"+Obtencioncargos.getCargos()[i].getPrecio().getDatosAnexos().getCodTipPlantarifOrig());
				logger.debug("getPrecio().getDatosAnexos().getCodTipPlantarifDes()  :"+Obtencioncargos.getCargos()[i].getPrecio().getDatosAnexos().getCodTipPlantarifDes());
				logger.debug("getPrecio().getDatosAnexos().getNumAbonado()          :"+Obtencioncargos.getCargos()[i].getPrecio().getDatosAnexos().getNumAbonado());
				logger.debug("getPrecio().getDatosAnexos().getNumeroCelular()       :"+Obtencioncargos.getCargos()[i].getPrecio().getDatosAnexos().getNumeroCelular());
				
				logger.debug("--------------------------------------------------------------------------");
				logger.debug("MonedaDTO");
				logger.debug("getPrecio().getUnidad().getCodigo()      :"+Obtencioncargos.getCargos()[i].getPrecio().getUnidad().getCodigo());
				logger.debug("getPrecio().getUnidad().getDescripcion() :"+Obtencioncargos.getCargos()[i].getPrecio().getUnidad().getDescripcion());
				if (Obtencioncargos.getCargos()[i].getDescuento()!=null){
					for(int j=0; j<Obtencioncargos.getCargos()[i].getDescuento().length;j++){
						logger.debug("=============================================================================");
						logger.debug("DescuentoDTO");
						logger.debug("Monto       :"+Obtencioncargos.getCargos()[i].getDescuento()[j].getMonto());
						logger.debug("Tipo        :"+Obtencioncargos.getCargos()[i].getDescuento()[j].getTipo());
						logger.debug("CodigoConceptoCargo :"+Obtencioncargos.getCargos()[i].getDescuento()[j].getCodigoConceptoCargo());
						logger.debug("CodigoConcepto      :"+Obtencioncargos.getCargos()[i].getDescuento()[j].getCodigoConcepto());
						logger.debug("DescripcionConcepto :"+Obtencioncargos.getCargos()[i].getDescuento()[j].getDescripcionConcepto());
						logger.debug("MinDescuento        : :"+Obtencioncargos.getCargos()[i].getDescuento()[j].getMinDescuento());
						logger.debug("MaxDescuento        :"+Obtencioncargos.getCargos()[i].getDescuento()[j].getMaxDescuento());
						logger.debug("TipoAplicacion      :"+Obtencioncargos.getCargos()[i].getDescuento()[j].getTipoAplicacion());
						logger.debug("MontoCalculado      :"+Obtencioncargos.getCargos()[i].getDescuento()[j].getMontoCalculado());
						logger.debug("CodigoMoneda        :"+Obtencioncargos.getCargos()[i].getDescuento()[j].getCodigoMoneda());
						logger.debug("NumTransaccion      :"+Obtencioncargos.getCargos()[i].getDescuento()[j].getNumTransaccion());
						logger.debug("isAprobacion()      :"+Obtencioncargos.getCargos()[i].getDescuento()[j].isAprobacion());
					}
					
				} // del if (descuentos)
			
		} //del for de imprimir
			
		}  // del if (cargos)
		
		
		retRegCargos=delegate.construirRegistroCargos(Obtencioncargos);
		logger.debug("construirRegistroCargos():fin");
		
		return retRegCargos;
		
	}
	
	public ResultadoRegCargosDTO parametrosRegistrarCargos(com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RegCargosDTO retValConst) throws ManReqException{
		
		logger.debug("parametrosRegistrarCargos():inicio");
		ResultadoRegCargosDTO retParamRegCargos=null;
		
		//-------------inicio log------------------------
		logger.debug("PARAMETROS ENTRADA A REGISTRAR CARGOS");
		logger.debug(":::::::::::::::::::::::::::::::::::::");
		
		logger.debug("RegCargosDTO");
		logger.debug("---------------------------------------------------------------------------------");
		logger.debug("PuntoDesctoInferior   :"+retValConst.getPuntoDesctoInferior());
		logger.debug("PuntoDesctoSuperior   :"+retValConst.getPuntoDesctoSuperior());
		logger.debug("PorcentajeDesctoInferior :"+retValConst.getPorcentajeDesctoInferior());
		logger.debug("PorcentajeDesctoSuperior :"+retValConst.getPorcentajeDesctoSuperior());
		logger.debug("AplicaDescuentoVendedor  :"+retValConst.isAplicaDescuentoVendedor());
		logger.debug("AplicaTipoCargo          :"+retValConst.isAplicaTipoCargo());
		
		logger.debug("---------------------------------------------------------------------------------");
		logger.debug("CabeceraArchivoDTO");
		logger.debug("getObjetoSesion().getCodigoOperadora()        :"+retValConst.getObjetoSesion().getCodigoOperadora());
		logger.debug("getObjetoSesion().getCodigoVendedorRaiz()     :"+retValConst.getObjetoSesion().getCodigoVendedorRaiz());
		logger.debug("getObjetoSesion().getCodigoVenDealer()        :"+retValConst.getObjetoSesion().getCodigoVenDealer());
		logger.debug("getObjetoSesion().getIndicadorTipoVenta()     :"+retValConst.getObjetoSesion().getIndicadorTipoVenta());
		logger.debug("getObjetoSesion().getCodigoCliente()          :"+retValConst.getObjetoSesion().getCodigoCliente());
		logger.debug("getObjetoSesion().getCodigoTipoIdentificacion()  :"+retValConst.getObjetoSesion().getCodigoTipoIdentificacion());
		logger.debug("getObjetoSesion().getNumeroIdentificacion()      :"+retValConst.getObjetoSesion().getNumeroIdentificacion());
		logger.debug("getObjetoSesion().getNombreCliente()             :"+retValConst.getObjetoSesion().getNombreCliente());
		logger.debug("getObjetoSesion().getCodigoCuentaCliente()       :"+retValConst.getObjetoSesion().getCodigoCuentaCliente());
		logger.debug("getObjetoSesion().getCodigoSubCuentaCliente()    :"+retValConst.getObjetoSesion().getCodigoSubCuentaCliente());
		logger.debug("getObjetoSesion().getNombreApellido1Cliente()    :"+retValConst.getObjetoSesion().getNombreApellido1Cliente());
		logger.debug("getObjetoSesion().getNombreApellido2Cliente()    :"+retValConst.getObjetoSesion().getNombreApellido2Cliente());
		logger.debug("getObjetoSesion().getIndicadorEstadoCivilCliente() :"+retValConst.getObjetoSesion().getIndicadorEstadoCivilCliente());
		logger.debug("getObjetoSesion().getIndicadorSexoCliente()        :"+retValConst.getObjetoSesion().getIndicadorSexoCliente());
		logger.debug("getObjetoSesion().getCodigoActividadCliente()      :"+retValConst.getObjetoSesion().getCodigoActividadCliente());
		logger.debug("getObjetoSesion().getTipoCliente()                 :"+retValConst.getObjetoSesion().getTipoCliente());
		logger.debug("getObjetoSesion().getCodigoCeldaCliente()          :"+retValConst.getObjetoSesion().getCodigoCeldaCliente());
		logger.debug("getObjetoSesion().getCodigoCalidadCliente()        :"+retValConst.getObjetoSesion().getCodigoCalidadCliente());
		logger.debug("getObjetoSesion().getIndicativoFacturableCliente() :"+retValConst.getObjetoSesion().getIndicativoFacturableCliente());
		logger.debug("getObjetoSesion().getCodigoCicloCliente()          :"+retValConst.getObjetoSesion().getCodigoCicloCliente());
		logger.debug("getObjetoSesion().getCodigoEmpresa()               :"+retValConst.getObjetoSesion().getCodigoEmpresa());
		logger.debug("getObjetoSesion().getCodigoDealer()                :"+retValConst.getObjetoSesion().getCodigoDealer());
		logger.debug("getObjetoSesion().getCodigoVendedor()              :"+retValConst.getObjetoSesion().getCodigoVendedor());
		logger.debug("getObjetoSesion().getOficinaVendedor()             :"+retValConst.getObjetoSesion().getOficinaVendedor());
		logger.debug("getObjetoSesion().getIdentificadorEmpresa()        :"+retValConst.getObjetoSesion().getIdentificadorEmpresa());
		logger.debug("getObjetoSesion().getNombreUsuario()               :"+retValConst.getObjetoSesion().getNombreUsuario());
		logger.debug("getObjetoSesion().getNombreArchivo()               :"+retValConst.getObjetoSesion().getNombreArchivo());
		logger.debug("getObjetoSesion().getNumeroSeries()                :"+retValConst.getObjetoSesion().getNumeroSeries());
		logger.debug("getObjetoSesion().getParametroCalCliente()         :"+retValConst.getObjetoSesion().getParametroCalCliente());
		logger.debug("getObjetoSesion().getParametroCodigoAbc()          :"+retValConst.getObjetoSesion().getParametroCodigoAbc());
		logger.debug("getObjetoSesion().getParametroCodigo123()          :"+retValConst.getObjetoSesion().getParametroCodigo123());
		logger.debug("getObjetoSesion().getParametroCodigoEstadoCobros() :"+retValConst.getObjetoSesion().getParametroCodigoEstadoCobros());
		logger.debug("getObjetoSesion().getParametroCodigoSimcardGSM()   :"+retValConst.getObjetoSesion().getParametroCodigoSimcardGSM());
		logger.debug("getObjetoSesion().getParametroCodigoTerminalGSM()  :"+retValConst.getObjetoSesion().getParametroCodigoTerminalGSM());
		logger.debug("getObjetoSesion().getPlanComercialCliente()        :"+retValConst.getObjetoSesion().getPlanComercialCliente());
		logger.debug("getObjetoSesion().getTipoPlanPostpago()            :"+retValConst.getObjetoSesion().getTipoPlanPostpago());
		logger.debug("getObjetoSesion().getTipoPlanHibrido()             :"+retValConst.getObjetoSesion().getTipoPlanHibrido());
		logger.debug("getObjetoSesion().getCodigoDocumento()             :"+retValConst.getObjetoSesion().getCodigoDocumento());
		logger.debug("getObjetoSesion().getCategoriaTributaria()         :"+retValConst.getObjetoSesion().getCategoriaTributaria());
		logger.debug("getObjetoSesion().getTipoFoliacion()               :"+retValConst.getObjetoSesion().getTipoFoliacion());
		logger.debug("getObjetoSesion().getTotalImpuestoVenta()          :"+retValConst.getObjetoSesion().getTotalImpuestoVenta());
		logger.debug("getObjetoSesion().getTotalCargosVenta()            :"+retValConst.getObjetoSesion().getTotalCargosVenta());
		logger.debug("getObjetoSesion().getTotalDescuentosVenta()        :"+retValConst.getObjetoSesion().getTotalDescuentosVenta());
		logger.debug("getObjetoSesion().isFacturaCiclo()                 :"+retValConst.getObjetoSesion().isFacturaCiclo());
		logger.debug("getObjetoSesion().getCodigoFormaPago()             :"+retValConst.getObjetoSesion().getCodigoFormaPago());
		logger.debug("getObjetoSesion().getNumeroProcesoFacturacion()    :"+retValConst.getObjetoSesion().getNumeroProcesoFacturacion());
		logger.debug("getObjetoSesion().isPrebillingOK()                 :"+retValConst.getObjetoSesion().isPrebillingOK());
		logger.debug("getObjetoSesion().getNumeroVenta()                 :"+retValConst.getObjetoSesion().getNumeroVenta());
		logger.debug("getObjetoSesion().getNumeroTransaccionVenta()      :"+retValConst.getObjetoSesion().getNumeroTransaccionVenta());
		logger.debug("getObjetoSesion().getMontoGarantia()               :"+retValConst.getObjetoSesion().getMontoGarantia());
		logger.debug("getObjetoSesion().getTipoVentaOficinaTerreno()     :"+retValConst.getObjetoSesion().getTipoVentaOficinaTerreno());
		logger.debug("getObjetoSesion().getTotalPresupuestoVenta()       :"+retValConst.getObjetoSesion().getTotalPresupuestoVenta());
		logger.debug("getObjetoSesion().getDecimalesFormulario()         :"+retValConst.getObjetoSesion().getDecimalesFormulario());
		logger.debug("getObjetoSesion().getDecimalesBD()                 :"+retValConst.getObjetoSesion().getDecimalesBD());
		logger.debug("getObjetoSesion().getDecimalesPorcentajeDescuento() :"+retValConst.getObjetoSesion().getDecimalesPorcentajeDescuento());
		logger.debug("getObjetoSesion().getTipoPlanTarifario()            :"+retValConst.getObjetoSesion().getTipoPlanTarifario());
		logger.debug("getObjetoSesion().getCodModalidadVenta()            :"+retValConst.getObjetoSesion().getCodModalidadVenta());
		logger.debug("---------------------------------------------------------------------------------");
		if (retValConst.getCargos()!=null) {
			for(int i=0; i<retValConst.getCargos().length;i++){
				logger.debug("CargoFrameworkCargosDTO[" + i + "]");
				logger.debug("-----------------------------------------------------");
				logger.debug("getTipoProducto()     :"+retValConst.getCargos()[i].getTipoProducto());
				logger.debug("getIdProducto()       :"+retValConst.getCargos()[i].getIdProducto());
				logger.debug("getCantidad()         :"+retValConst.getCargos()[i].getCantidad());
				logger.debug("getCodigoDescuento()  :"+retValConst.getCargos()[i].getCodigoDescuento());
				logger.debug("getDescripcionDescuento() :"+retValConst.getCargos()[i].getDescripcionDescuento());
				logger.debug("getTipoDescuento()        :"+retValConst.getCargos()[i].getTipoDescuento());
				logger.debug("getMontoDescuento()       :"+retValConst.getCargos()[i].getMontoDescuento());
				logger.debug("getDescuentoManual()      :"+retValConst.getCargos()[i].getDescuentoManual());
				logger.debug("getTipoDescuentoManual()  :"+retValConst.getCargos()[i].getTipoDescuentoManual());
				logger.debug("getMontoDescuentoManual() :"+retValConst.getCargos()[i].getMontoDescuentoManual());
				logger.debug("getCodigoConceptoPrecio() :"+retValConst.getCargos()[i].getCodigoConceptoPrecio());
				logger.debug("getDescripcionConceptoPrecio() :"+retValConst.getCargos()[i].getDescripcionConceptoPrecio());
				logger.debug("getClase()                     :"+retValConst.getCargos()[i].getClase());
				logger.debug("getCodigoMoneda()              :"+retValConst.getCargos()[i].getCodigoMoneda());
				logger.debug("getMontoConceptoPrecio()       :"+retValConst.getCargos()[i].getMontoConceptoPrecio());
				logger.debug("getMontoConceptoTotal()        :"+retValConst.getCargos()[i].getMontoConceptoTotal());
				logger.debug("getSaldoUnitario()             :"+retValConst.getCargos()[i].getSaldoUnitario());
				logger.debug("getSaldoTotal()                :"+retValConst.getCargos()[i].getSaldoTotal());
				logger.debug("getDescripcionMoneda()         :"+retValConst.getCargos()[i].getDescripcionMoneda());
				logger.debug("getInd_paquete()               :"+retValConst.getCargos()[i].getInd_paquete());
				logger.debug("getInd_cuota()                 :"+retValConst.getCargos()[i].getInd_cuota());
				logger.debug("getInd_equipo()                :"+retValConst.getCargos()[i].getInd_equipo());
				logger.debug("getCod_tecnologia()            :"+retValConst.getCargos()[i].getCod_tecnologia());
				logger.debug("getCodigoArticuloServicio()    :"+retValConst.getCargos()[i].getCodigoArticuloServicio());
				logger.debug("getTipoCargo()                 :"+retValConst.getCargos()[i].getTipoCargo());
				logger.debug("getNumAbonado()                :"+retValConst.getCargos()[i].getNumAbonado());
				logger.debug("getDescCPUCargo()              :"+retValConst.getCargos()[i].getDescCPUCargo());
			}
			
		}
		
		retParamRegCargos=delegate.parametrosRegistrarCargos(retValConst);
		logger.debug("parametrosRegistrarCargos():fin");
		
		return retParamRegCargos;
		
	}

	
}
