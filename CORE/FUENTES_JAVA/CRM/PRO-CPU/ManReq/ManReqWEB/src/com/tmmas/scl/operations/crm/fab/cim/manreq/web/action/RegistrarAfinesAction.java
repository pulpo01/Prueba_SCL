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
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroListDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.CargosObtenidosDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.ParamMantencionAfinesDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.businessObject.bo.XMLDefault;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.DefaultPaginaCPUDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.SeccionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.TablaCargosDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate.ManageRequestBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.CargosForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.ResumenForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.Global;

public class RegistrarAfinesAction extends BaseAction {
	private final Logger logger = Logger.getLogger(RegistrarAfinesAction.class);
	private Global global = Global.getInstance();
	
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
		
	    
	    ParamMantencionAfinesDTO paramAfines = new ParamMantencionAfinesDTO();
	    
	    paramAfines.setCliente(sessionData.getCliente());
	    paramAfines.setAbonado(sessionData.getAbonados()[0]);
	    paramAfines.setNumOrdenServicio(String.valueOf(sessionData.getNumOrdenServicio()));
	    paramAfines.setCodOrdenServicio(String.valueOf(sessionData.getCodOrdenServicio()));
	    paramAfines.setCodProducto(1);
	    
	    if(sessionData.getCodCliente()!= 0){
	    	paramAfines.setTipInter(8);
	    	paramAfines.setCodInter(sessionData.getCliente().getCodCliente());
	    	paramAfines.setSujeto("C");
	    }else{
	    	paramAfines.setTipInter(1);
	    	paramAfines.setCodInter(sessionData.getAbonados()[0].getNumAbonado());
	    	paramAfines.setSujeto("A");
	    	
	    }
	    
	    paramAfines.setUsuario(sessionData.getUsuario());
	    Date fecha = new Date();
	    Timestamp fechaActual = new Timestamp(fecha.getTime());
	    paramAfines.setFecha(fechaActual);
	    //paramAfines.setComentario(sessionData.getComentarioOS());   // Debe ser seteada con el valor del form de Resumen
	    paramAfines.setCodActAbo(sessionData.getCodActAbo());	    
	    
	    paramAfines.setNumeroListAdd(numeroListAdd);
	    paramAfines.setNumeroListDel(numeroListDel);
	    
	    
	    XMLDefault objetoXML    = new XMLDefault();
		DefaultPaginaCPUDTO objetoXMLSession = new DefaultPaginaCPUDTO();
		SeccionDTO seccion=new SeccionDTO();
		objetoXMLSession = sessionData.getDefaultPagina();
		seccion = objetoXML.obtenerSeccion(objetoXMLSession, "cargosPAG", "CondicionesComercialesSS");
	    
	    	    
	    CargosForm cargosForm = (CargosForm)session.getAttribute("CargosForm");
	    paramAfines.setCodTipoDocumento(seccion.obtControl("TipoDocumentoCB").getValorDefecto());
	    paramAfines.setModPago(seccion.obtControl("ModalidadCB").getValorDefecto());
	    paramAfines.setACiclo(cargosForm.getRbCiclo());
	    paramAfines.setNomUsuaOra(sessionData.getUsuario());
	    

		if( (cargosForm!=null&&cargosForm.getRbCiclo().equals("NO")) || (cargosForm==null) ){
			paramAfines.setRegistroCargos(null);
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
				paramAfines.setRegistroCargos(null);
			}
			paramAfines.setRegistroCargos(cargosRegistro);
		}
		
		paramAfines.setComentario(((ResumenForm)form).getComentario());
		
        UsuarioDTO usuario = new UsuarioDTO();
        usuario.setNombre(sessionData.getUsuario());
        usuario = delegate.obtenerVendedor(usuario);
        
        paramAfines.setCodVendedor(usuario.getCodigo());
        
		
	    
	    logger.debug("Parametros Orden de Servicio");
	    logger.debug("paramAfines.getCliente().getCodCliente()              :"+paramAfines.getCliente().getCodCliente());
	    logger.debug("paramAfines.getAbonado().getNumAbonado()              :"+paramAfines.getAbonado().getNumAbonado());
	    logger.debug("paramAfines.getNumOrdenServicio()                     :"+paramAfines.getNumOrdenServicio());
	    logger.debug("paramAfines.getCodOrdenServicio()                     :"+paramAfines.getCodOrdenServicio());
	    logger.debug("paramAfines.getCodProducto()                          :"+paramAfines.getCodProducto());
	    logger.debug("paramAfines.getTipInter()                             :"+paramAfines.getTipInter());
	    logger.debug("paramAfines.getCodInter()                             :"+paramAfines.getCodInter());
	    logger.debug("paramAfines.getSujeto()                               :"+paramAfines.getSujeto());
	    logger.debug("paramAfines.getUsuario()                              :"+paramAfines.getUsuario());
	    logger.debug("paramAfines.getFecha()                                :"+paramAfines.getFecha());
	    logger.debug("paramAfines.getComentario()                           :"+paramAfines.getComentario());
	    logger.debug("paramAfines.getCodActAbo()                            :"+paramAfines.getCodActAbo());
	    logger.debug("paramAfines.getCodTipoDocumento()                     :"+paramAfines.getCodTipoDocumento());
	    logger.debug("paramAfines.getModPago()                              :"+paramAfines.getModPago());
	    logger.debug("paramAfines.getCodVendedor()                          :"+paramAfines.getCodVendedor());
	    logger.debug("paramAfines.getACiclo()                               :"+paramAfines.getACiclo());
	    logger.debug("paramAfines.getNomUsuaOra()                           :"+paramAfines.getNomUsuaOra());
	    
	    
	    logger.debug("ejecutarOrdenServicioAfinesOSJms: inicio");
	    delegate.ejecutarOrdenServicioAfinesOSJms(paramAfines);
	    logger.debug("ejecutarOrdenServicioAfinesOSJms: fin");
	    logger.debug("execute():end");
	    
	    //Si es factura a ciclo despliega pagina de finalización del registro de la OOSS,
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
