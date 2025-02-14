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
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoBeneficiarioListDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.CargosObtenidosDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.ParamAbonBenefRegOSDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.businessObject.bo.XMLDefault;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.DefaultPaginaCPUDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.SeccionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.TablaCargosDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate.ManageRequestBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.CargosForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.ResumenForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.Global;

public class RegistrarAbonadoBeneficiarioAction extends BaseAction {
	private final Logger logger = Logger.getLogger(RegistrarAbonadoBeneficiarioAction.class);
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
		
		AbonadoBeneficiarioListDTO listaAbonadosEliminados=null;
		AbonadoBeneficiarioListDTO listaAbonadosAgregados=null;

		
		HttpSession session = request.getSession(false);
		ClienteOSSesionDTO sessionData = new ClienteOSSesionDTO();
		sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");		
		
		CargosObtenidosDTO cargosRegistro;
		cargosRegistro = sessionData.getCargosObtenidos();
		
		listaAbonadosEliminados=(AbonadoBeneficiarioListDTO)session.getAttribute("listaAbonadosEliminados");
		listaAbonadosAgregados=(AbonadoBeneficiarioListDTO)session.getAttribute("listaAbonadosAgregados");
		
	    ParamAbonBenefRegOSDTO paramAbonBenefRegOSDTO = new ParamAbonBenefRegOSDTO();
	    
	    paramAbonBenefRegOSDTO.setCliente(sessionData.getCliente());
	    paramAbonBenefRegOSDTO.setAbonado(sessionData.getAbonados()[0]);
	    paramAbonBenefRegOSDTO.setNumOrdenServicio(String.valueOf(sessionData.getNumOrdenServicio()));
	    paramAbonBenefRegOSDTO.setCodOrdenServicio(String.valueOf(sessionData.getCodOrdenServicio()));
	    paramAbonBenefRegOSDTO.setCodProducto(1);
	    
	    if(sessionData.getCodCliente()!= 0){
	    	paramAbonBenefRegOSDTO.setTipInter(8);
	    	paramAbonBenefRegOSDTO.setCodInter(sessionData.getCliente().getCodCliente());
	    	paramAbonBenefRegOSDTO.setSujeto("C");
	    }else{
	    	paramAbonBenefRegOSDTO.setTipInter(1);
	    	paramAbonBenefRegOSDTO.setCodInter(sessionData.getAbonados()[0].getNumAbonado());
	    	paramAbonBenefRegOSDTO.setSujeto("A");
	    	
	    }
	    
	    paramAbonBenefRegOSDTO.setUsuario(sessionData.getUsuario());
	    Date fecha = new Date();
	    Timestamp fechaActual = new Timestamp(fecha.getTime());
	    paramAbonBenefRegOSDTO.setFecha(fechaActual);
	    //paramAbonBenefRegOSDTO.setComentario(sessionData.getComentarioOS());   // Debe ser seteada con el valor del form de Resumen
	    paramAbonBenefRegOSDTO.setCodActAbo(sessionData.getCodActAbo());	    
	    
	    paramAbonBenefRegOSDTO.setAbonadosBenefiariosEliminar(listaAbonadosEliminados);
		paramAbonBenefRegOSDTO.setAbonadosBenefiariosNuevos(listaAbonadosAgregados);
	    
	    
	    XMLDefault objetoXML    = new XMLDefault();
		DefaultPaginaCPUDTO objetoXMLSession = new DefaultPaginaCPUDTO();
		SeccionDTO seccion=new SeccionDTO();
		objetoXMLSession = sessionData.getDefaultPagina();
		seccion = objetoXML.obtenerSeccion(objetoXMLSession, "cargosPAG", "CondicionesComercialesSS");
	    
	    	    
	    CargosForm cargosForm = (CargosForm)session.getAttribute("CargosForm");
	    paramAbonBenefRegOSDTO.setCodTipoDocumento(seccion.obtControl("TipoDocumentoCB").getValorDefecto());
	    paramAbonBenefRegOSDTO.setModPago(seccion.obtControl("ModalidadCB").getValorDefecto());
	    paramAbonBenefRegOSDTO.setACiclo(cargosForm.getRbCiclo());
	    paramAbonBenefRegOSDTO.setNomUsuaOra(sessionData.getUsuario());
	    

		if( (cargosForm!=null&&cargosForm.getRbCiclo().equals("NO")) || (cargosForm==null) ){
			paramAbonBenefRegOSDTO.setRegistroCargos(null);
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
				paramAbonBenefRegOSDTO.setRegistroCargos(null);
			}
			paramAbonBenefRegOSDTO.setRegistroCargos(cargosRegistro);
		}
		
		paramAbonBenefRegOSDTO.setComentario(((ResumenForm)form).getComentario());
		
        UsuarioDTO usuario = new UsuarioDTO();
        usuario.setNombre(sessionData.getUsuario());
        usuario = delegate.obtenerVendedor(usuario);
        
        paramAbonBenefRegOSDTO.setCodVendedor(usuario.getCodigo());
        
		
	    
	    logger.debug("Parametros Orden de Servicio");
	    logger.debug("paramAbonBenefRegOSDTO.getCliente().getCodCliente()              :"+paramAbonBenefRegOSDTO.getCliente().getCodCliente());
	    logger.debug("paramAbonBenefRegOSDTO.getAbonado().getNumAbonado()              :"+paramAbonBenefRegOSDTO.getAbonado().getNumAbonado());
	    logger.debug("paramAbonBenefRegOSDTO.getNumOrdenServicio()                     :"+paramAbonBenefRegOSDTO.getNumOrdenServicio());
	    logger.debug("paramAbonBenefRegOSDTO.getCodOrdenServicio()                     :"+paramAbonBenefRegOSDTO.getCodOrdenServicio());
	    logger.debug("paramAbonBenefRegOSDTO.getCodProducto()                          :"+paramAbonBenefRegOSDTO.getCodProducto());
	    logger.debug("paramAbonBenefRegOSDTO.getTipInter()                             :"+paramAbonBenefRegOSDTO.getTipInter());
	    logger.debug("paramAbonBenefRegOSDTO.getCodInter()                             :"+paramAbonBenefRegOSDTO.getCodInter());
	    logger.debug("paramAbonBenefRegOSDTO.getSujeto()                               :"+paramAbonBenefRegOSDTO.getSujeto());
	    logger.debug("paramAbonBenefRegOSDTO.getUsuario()                              :"+paramAbonBenefRegOSDTO.getUsuario());
	    logger.debug("paramAbonBenefRegOSDTO.getFecha()                                :"+paramAbonBenefRegOSDTO.getFecha());
	    logger.debug("paramAbonBenefRegOSDTO.getComentario()                           :"+paramAbonBenefRegOSDTO.getComentario());
	    logger.debug("paramAbonBenefRegOSDTO.getCodActAbo()                            :"+paramAbonBenefRegOSDTO.getCodActAbo());
	    logger.debug("paramAbonBenefRegOSDTO.getCodTipoDocumento()                     :"+paramAbonBenefRegOSDTO.getCodTipoDocumento());
	    logger.debug("paramAbonBenefRegOSDTO.getModPago()                              :"+paramAbonBenefRegOSDTO.getModPago());
	    logger.debug("paramAbonBenefRegOSDTO.getCodVendedor()                          :"+paramAbonBenefRegOSDTO.getCodVendedor());
	    logger.debug("paramAbonBenefRegOSDTO.getACiclo()                               :"+paramAbonBenefRegOSDTO.getACiclo());
	    
	    
	    
	    logger.debug("ejecutarOrdenServicioAfinesOSJms: inicio");
	    delegate.ejecutarOrdenServicioAbonadoBeneficiarioJms(paramAbonBenefRegOSDTO);
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
