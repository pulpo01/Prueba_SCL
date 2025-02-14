package com.tmmas.scl.operations.crm.fab.cim.manreq.web.action;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.SerializationUtils;
import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.BaseAction;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.UsuarioDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.CargoOcasionalDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.CargoOcasionalListDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.CargoRecurrenteDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.CargoRecurrenteListDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.CargosDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.marketSalesDomain.contactLeadProspectABE.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
//import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProcesoProductoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.CargoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.CargoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PaqueteListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoListDTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.LimiteConsumoPlanAdicionalListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.PerfilProvisionamientoDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.PerfilProvisionamientoListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.ProductoTasacionContratadoDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.CargosObtenidosDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.ParamMantencionLimiteConsumoDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.ParamMantencionProductoDTO;
import com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.OfertaComercialDTO;
import com.tmmas.scl.operations.crm.f.sel.negsal.helper.NegSalUtils;
import com.tmmas.scl.operations.crm.fab.cim.manreq.businessObject.bo.XMLDefault;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.DefaultPaginaCPUDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.SeccionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.TablaCargosDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate.ManageRequestBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.CargosForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.ResumenForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.Global;

public class RegistrarManLcPlanAction extends BaseAction {
	
	
	private final Logger logger = Logger.getLogger(RegistrarManLcPlanAction.class);
	private Global global = Global.getInstance();
	//private static final String SIGUIENTE = "factura";
	private static final String PAGINA = "factura";
	private static final String FIN = "fin";
	
	private ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();

	public ActionForward executeAction(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	throws Exception {

		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);
		logger.debug("execute():start");

		
		HttpSession session = request.getSession(false);
		ClienteOSSesionDTO sessionData = new ClienteOSSesionDTO();
		sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");		
		seteaNullCargosProdOfertados(sessionData);
		CargosObtenidosDTO cargosRegistro;
		cargosRegistro = sessionData.getCargosObtenidos();

		ParamMantencionLimiteConsumoDTO paramOServicio = new ParamMantencionLimiteConsumoDTO();
		
		paramOServicio.setCliente(sessionData.getCliente());
	    paramOServicio.setAbonado(sessionData.getAbonados()[0]);
	    paramOServicio.setNumOrdenServicio(String.valueOf(sessionData.getNumOrdenServicio()));
	    paramOServicio.setCodOrdenServicio(String.valueOf(sessionData.getCodOrdenServicio()));
	    paramOServicio.setCodProducto(1);
	    paramOServicio.setListaProdContraMantenidosLC((ProductoContratadoListDTO)session.getAttribute("listaProdContraMantenidosLC"));
	    
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
	    paramOServicio.setCodActAbo(sessionData.getCodActAbo());
	      
		
	    
	    
	    XMLDefault objetoXML    = new XMLDefault();
		DefaultPaginaCPUDTO objetoXMLSession = new DefaultPaginaCPUDTO();
		SeccionDTO seccion=new SeccionDTO();
		objetoXMLSession = sessionData.getDefaultPagina();
		seccion = objetoXML.obtenerSeccion(objetoXMLSession, "cargosPAG", "CondicionesComercialesSS");
	    
	    	    
	    CargosForm cargosForm = (CargosForm)session.getAttribute("CargosForm");
	    paramOServicio.setCodTipoDocumento(seccion.obtControl("TipoDocumentoCB").getValorDefecto());
	    paramOServicio.setModPago(seccion.obtControl("ModalidadCB").getValorDefecto());
	    paramOServicio.setACiclo(cargosForm!=null?cargosForm.getRbCiclo():"");
	    paramOServicio.setNomUsuaOra(sessionData.getUsuario());
	    

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
			
			//(+) evera 31/12/08 inc 031-032
			//AGREGAR LOS CARGOS MULTIPLICADOS POR LA CANTIDAD, CARGOS Y DESCUENTOS......
			if (cargosRegistro!=null && cargosRegistro.getOcacionales()!=null && cargosRegistro.getOcacionales().getCargos()!=null){
				CargosDTO[] cargos =cargosRegistro.getOcacionales().getCargos();
				int cantidad=0;
				float monto = 0;
				float descuento = 0;
				for(int i =0; i<cargos.length;i++){
					cantidad =cargos[i].getCantidad();
					monto =cargos[i].getPrecio().getMonto()*cantidad;
					logger.debug("cantidad="+cantidad);
					logger.debug("monto="+cargos[i].getPrecio().getMonto());
					logger.debug("montoTotal="+monto);
					cargos[i].getPrecio().setMonto(monto); 
					DescuentoDTO[] descuentos = cargos[i].getDescuento();
					if (descuentos!=null){
						for(int d=0; d<descuentos.length;d++){
							descuento = descuentos[d].getMonto()*cantidad;
							logger.debug("descuento="+descuentos[d].getMonto());
							logger.debug("descuentoTotal="+descuento);
							descuentos[d].setMonto(descuento);
						}
					}
				}
			}
			//(-) evera inc 031-032
			

			paramOServicio.setRegistroCargos(cargosRegistro);
		}
		
		paramOServicio.setComentario(((ResumenForm)form).getComentario());
		
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
	 
	       
	    logger.debug("ejecutarMantencionProductosOSJms: inicio");
	    delegate.ejecutarMantencionLimiteConsumoOSJms(paramOServicio);
	    logger.debug("ejecutarMantencionProductosOSJms: fin");

	    
		
		logger.debug("execute():end");
		//Si es factura a ciclo despliega pagina de finalización del registro de la OOSS,
		//en caso contrario despliega la factura
		/*if (cargosForm!=null && cargosForm.getRbCiclo()!=null && cargosForm.getRbCiclo().equals("SI"))
			return mapping.findForward(FIN);
		else
			return mapping.findForward(PAGINA);*/
		
		/**
		 * @author rlozano
		 * @description se asume que la orden de servicio 40001 es a ciclo por lo tanto no genera factura inmediata.
		 * @date 02-01-2009
		 */
		return mapping.findForward(FIN);
	
		
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
	
	private void seteaNullCargosProdOfertados(ClienteOSSesionDTO sessionData) throws GeneralException 
	{
		AbonadoDTO abonado = sessionData.getCliente().getAbonados().getAbonados()[0];
		
		ProductoOfertadoListDTO productosOfertadosAbonado = abonado.getProdOfertList();
		
		PaqueteListDTO paquetesOfertadosAbonado = abonado.getPaqueteList();
		
		CargoListDTO cargoListDTO = new CargoListDTO();
		
		for(int i=0;i<productosOfertadosAbonado.getProductoList().length;i++)
		{
			cargoListDTO=new CargoListDTO(); 
			cargoListDTO=productosOfertadosAbonado.getProductoList()[i].getCargoList();
			if (cargoListDTO !=null && cargoListDTO.getCargoList()!=null && cargoListDTO.getCargoList().length>0){
				for (int j=0;j<cargoListDTO.getCargoList().length;j++){
					if (!"R".equalsIgnoreCase(cargoListDTO.getCargoList()[j].getTipoCargo())){
						cargoListDTO.getCargoList()[j] = new CargoDTO();//null;
					}
				}
			}
		}
		
		/// PAQUETES
		
		for(int i=0;i<paquetesOfertadosAbonado.getPaqueteList().length;i++)
		{
			
			cargoListDTO = new CargoListDTO(); 
			cargoListDTO = paquetesOfertadosAbonado.getPaqueteList()[i].getCargoList();
			
			if (cargoListDTO !=null && cargoListDTO.getCargoList()!=null && cargoListDTO.getCargoList().length>0){
				for (int j=0;j<cargoListDTO.getCargoList().length;j++){
					if (!"R".equalsIgnoreCase(cargoListDTO.getCargoList()[j].getTipoCargo())){
						cargoListDTO.getCargoList()[j] = new CargoDTO();//null;
					}
				}
				
		
			}
		
		}
		
		
	}
	

}
