package com.tmmas.scl.operations.crm.fab.cim.manreq.web.action;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
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
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.UsuarioDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.CargosDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ParametroSerializableDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroListDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.CargosObtenidosDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.ParamMantencionFrecuentesDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.businessObject.bo.XMLDefault;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.DefaultPaginaCPUDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.SeccionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.TablaCargosDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate.ManageRequestBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.CargosForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.ResumenForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.Global;

public class RegistrarFrecAction extends BaseAction {
	private final Logger logger = Logger.getLogger(RegistrarFrecAction.class);
	private Global global = Global.getInstance();
	//private static final String SIGUIENTE = "factura";
	private static final String PAGINA = "factura";
	private static final String FIN = "fin";
	private ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();

	public ActionForward executeAction(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	throws Exception {

		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);
		logger.debug("execute():start");

		
		HttpSession session = request.getSession(false);
		ClienteOSSesionDTO sessionData = new ClienteOSSesionDTO();
		sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");		
		CargosObtenidosDTO cargosRegistro;
		cargosRegistro = sessionData.getCargosObtenidos();
		
		NumeroListDTO numeroListAdd =  (NumeroListDTO)session.getAttribute("numeroListAdd");
		NumeroListDTO numeroListDel =  (NumeroListDTO)session.getAttribute("numeroListDel");
		//String idProceso = (String)session.getAttribute("idProceso");
	    
	    ParamMantencionFrecuentesDTO paramFrecuentes = new ParamMantencionFrecuentesDTO();
	    
	    paramFrecuentes.setCliente(sessionData.getCliente());
	    paramFrecuentes.setAbonado(sessionData.getAbonados()[0]);
	    paramFrecuentes.setNumOrdenServicio(String.valueOf(sessionData.getNumOrdenServicio()));
	    paramFrecuentes.setCodOrdenServicio(String.valueOf(sessionData.getCodOrdenServicio()));
	    paramFrecuentes.setCodProducto(1);
	    
	    if(sessionData.getCodCliente()!= 0){
	    	paramFrecuentes.setTipInter(8);
	    	paramFrecuentes.setCodInter(sessionData.getCliente().getCodCliente());
	    	paramFrecuentes.setSujeto("C");
	    }else{
	    	paramFrecuentes.setTipInter(1);
	    	paramFrecuentes.setCodInter(sessionData.getAbonados()[0].getNumAbonado());
	    	paramFrecuentes.setSujeto("A");
	    	
	    }
	    
	    paramFrecuentes.setUsuario(sessionData.getUsuario());
	    Date fecha = new Date();
	    Timestamp fechaActual = new Timestamp(fecha.getTime());
	    paramFrecuentes.setFecha(fechaActual);
	    //paramFrecuentes.setComentario(sessionData.getComentarioOS());
	    paramFrecuentes.setCodActAbo(sessionData.getCodActAbo());	    
	    
	    paramFrecuentes.setNumeroListAdd(numeroListAdd);
	    paramFrecuentes.setNumeroListDel(numeroListDel);
	    
	    
	    XMLDefault objetoXML    = new XMLDefault();
		DefaultPaginaCPUDTO objetoXMLSession = new DefaultPaginaCPUDTO();
		SeccionDTO seccion=new SeccionDTO();
		objetoXMLSession = sessionData.getDefaultPagina();
		seccion = objetoXML.obtenerSeccion(objetoXMLSession, "cargosPAG", "CondicionesComercialesSS");
	    
	    	    
	    CargosForm cargosForm = (CargosForm)session.getAttribute("CargosForm");
	    paramFrecuentes.setCodTipoDocumento(seccion.obtControl("TipoDocumentoCB").getValorDefecto());
	    paramFrecuentes.setModPago(seccion.obtControl("ModalidadCB").getValorDefecto());
	    paramFrecuentes.setACiclo(cargosForm.getRbCiclo());
	    paramFrecuentes.setNomUsuaOra(sessionData.getUsuario());
	    

		if( (cargosForm!=null&&cargosForm.getRbCiclo().equals("NO")) || (cargosForm==null) ){
			paramFrecuentes.setRegistroCargos(null);
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
				paramFrecuentes.setRegistroCargos(null);
			}
			paramFrecuentes.setRegistroCargos(cargosRegistro);
		}
		
		paramFrecuentes.setComentario(((ResumenForm)form).getComentario());
		
        UsuarioDTO usuario = new UsuarioDTO();
        usuario.setNombre(sessionData.getUsuario());
        usuario = delegate.obtenerVendedor(usuario);
        
        paramFrecuentes.setCodVendedor(usuario.getCodigo());
        
		
	    
	    logger.debug("Parametros Orden de Servicio");
	    logger.debug("paramFrecuentes.getCliente().getCodCliente()              :"+paramFrecuentes.getCliente().getCodCliente());
	    logger.debug("paramFrecuentes.getAbonado().getNumAbonado()              :"+paramFrecuentes.getAbonado().getNumAbonado());
	    logger.debug("paramFrecuentes.getNumOrdenServicio()                     :"+paramFrecuentes.getNumOrdenServicio());
	    logger.debug("paramFrecuentes.getCodOrdenServicio()                     :"+paramFrecuentes.getCodOrdenServicio());
	    logger.debug("paramFrecuentes.getCodProducto()                          :"+paramFrecuentes.getCodProducto());
	    logger.debug("paramFrecuentes.getTipInter()                             :"+paramFrecuentes.getTipInter());
	    logger.debug("paramFrecuentes.getCodInter()                             :"+paramFrecuentes.getCodInter());
	    logger.debug("paramFrecuentes.getSujeto()                               :"+paramFrecuentes.getSujeto());
	    logger.debug("paramFrecuentes.getUsuario()                              :"+paramFrecuentes.getUsuario());
	    logger.debug("paramFrecuentes.getFecha()                                :"+paramFrecuentes.getFecha());
	    logger.debug("paramFrecuentes.getComentario()                           :"+paramFrecuentes.getComentario());
	    logger.debug("paramFrecuentes.getCodActAbo()                            :"+paramFrecuentes.getCodActAbo());
	    logger.debug("paramFrecuentes.getCodTipoDocumento()                     :"+paramFrecuentes.getCodTipoDocumento());
	    logger.debug("paramFrecuentes.getModPago()                              :"+paramFrecuentes.getModPago());
	    logger.debug("paramFrecuentes.getCodVendedor()                          :"+paramFrecuentes.getCodVendedor());
	    logger.debug("paramFrecuentes.getACiclo()                               :"+paramFrecuentes.getACiclo());      
	    
	    
	    
	    logger.debug("ejecutarOrdenServicioAfinesOSJms: inicio");
	    delegate.ejecutarMantencionFrecuentesOSJms(paramFrecuentes);
	    logger.debug("ejecutarOrdenServicioAfinesOSJms: fin");

	    
		
		logger.debug("execute():end");
		//		Si es factura a ciclo despliega pagina de finalización del registro de la OOSS,
		//en caso contrario despliega la factura
		if (cargosForm!=null && cargosForm.getRbCiclo()!=null && cargosForm.getRbCiclo().equals("SI"))
			return mapping.findForward(FIN);
		else
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

	

}
