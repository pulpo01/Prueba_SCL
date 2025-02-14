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

import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.BaseAction;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.UsuarioDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.CargosDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoVetadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoVetadoListDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.CargosObtenidosDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.ParamAbonVetadoRegOSDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.businessObject.bo.XMLDefault;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.DefaultPaginaCPUDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.SeccionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.TablaCargosDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate.ManageRequestBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.CargosForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.ResumenForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.Global;

public class RegistrarAbonadoVetadoAction extends BaseAction {
	private final Logger logger = Logger.getLogger(RegistrarAbonadoVetadoAction.class);
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
		
		List listaNoVetados=null;
		List listaVetados=null;

		
		HttpSession session = request.getSession(false);
		ClienteOSSesionDTO sessionData = new ClienteOSSesionDTO();
		sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");		
		
		CargosObtenidosDTO cargosRegistro;
		cargosRegistro = sessionData.getCargosObtenidos();
		
		listaNoVetados=(List)session.getAttribute("listaNoVetados");
		listaVetados=(List)session.getAttribute("listaVetados");
		AbonadoVetadoDTO[] abonadosNoVetadosDTO = null;
		if (listaNoVetados!=null&&listaNoVetados.size()>0){
			logger.debug("Abonados No Vetados:::"+listaNoVetados.size());
			abonadosNoVetadosDTO = (AbonadoVetadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(	listaNoVetados.toArray(), AbonadoVetadoDTO.class);
		}
		AbonadoVetadoDTO[] abonadosVetadosDTO = null;
		
		if (listaVetados!=null&&listaVetados.size()>0){
			logger.debug("Abonados Vetados:::"+listaVetados.size());
			abonadosVetadosDTO = (AbonadoVetadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(	listaVetados.toArray(), AbonadoVetadoDTO.class);
		}
		
		AbonadoVetadoListDTO listaAbonadosActualizados =new AbonadoVetadoListDTO ();
		listaAbonadosActualizados.setAbonadoVetadoList(abonadosVetadosDTO);
		AbonadoVetadoListDTO  listaAbonadosAgregados =new AbonadoVetadoListDTO ();//No Vetados
		listaAbonadosAgregados.setAbonadoVetadoList(abonadosNoVetadosDTO);
	    ParamAbonVetadoRegOSDTO paramAbonVetadoRegOSDTO = new ParamAbonVetadoRegOSDTO();
	    
	    paramAbonVetadoRegOSDTO.setCliente(sessionData.getCliente());
	    paramAbonVetadoRegOSDTO.setAbonado(sessionData.getAbonados()[0]);
	    paramAbonVetadoRegOSDTO.setNumOrdenServicio(String.valueOf(sessionData.getNumOrdenServicio()));
	    paramAbonVetadoRegOSDTO.setCodOrdenServicio(String.valueOf(sessionData.getCodOrdenServicio()));
	    paramAbonVetadoRegOSDTO.setCodProducto(1);
	    
	    if(sessionData.getCodCliente()!= 0){
	    	paramAbonVetadoRegOSDTO.setTipInter(8);
	    	paramAbonVetadoRegOSDTO.setCodInter(sessionData.getCliente().getCodCliente());
	    	paramAbonVetadoRegOSDTO.setSujeto("C");
	    }else{
	    	paramAbonVetadoRegOSDTO.setTipInter(1);
	    	paramAbonVetadoRegOSDTO.setCodInter(sessionData.getAbonados()[0].getNumAbonado());
	    	paramAbonVetadoRegOSDTO.setSujeto("A");
	    	
	    }
	    
	    paramAbonVetadoRegOSDTO.setUsuario(sessionData.getUsuario());
	    Date fecha = new Date();
	    Timestamp fechaActual = new Timestamp(fecha.getTime());
	    paramAbonVetadoRegOSDTO.setFecha(fechaActual);
	    //paramAbonVetadoRegOSDTO.setComentario(sessionData.getComentarioOS());   // Debe ser seteada con el valor del form de Resumen
	    paramAbonVetadoRegOSDTO.setCodActAbo(sessionData.getCodActAbo());	    
	    
	    paramAbonVetadoRegOSDTO.setActualizarAbonados(listaAbonadosActualizados);
	    paramAbonVetadoRegOSDTO.setAgregarAbonados(listaAbonadosAgregados);
	    
	    
	    XMLDefault objetoXML    = new XMLDefault();
		DefaultPaginaCPUDTO objetoXMLSession = new DefaultPaginaCPUDTO();
		SeccionDTO seccion=new SeccionDTO();
		objetoXMLSession = sessionData.getDefaultPagina();
		seccion = objetoXML.obtenerSeccion(objetoXMLSession, "cargosPAG", "CondicionesComercialesSS");
	    
	    	    
	    CargosForm cargosForm = (CargosForm)session.getAttribute("CargosForm");
	    paramAbonVetadoRegOSDTO.setCodTipoDocumento(seccion.obtControl("TipoDocumentoCB").getValorDefecto());
	    paramAbonVetadoRegOSDTO.setModPago(seccion.obtControl("ModalidadCB").getValorDefecto());
	    paramAbonVetadoRegOSDTO.setACiclo(cargosForm.getRbCiclo());
	    paramAbonVetadoRegOSDTO.setNomUsuaOra(sessionData.getUsuario());
	    

		if( (cargosForm!=null&&cargosForm.getRbCiclo().equals("NO")) || (cargosForm==null) ){
			paramAbonVetadoRegOSDTO.setRegistroCargos(null);
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
				paramAbonVetadoRegOSDTO.setRegistroCargos(null);
			}
			paramAbonVetadoRegOSDTO.setRegistroCargos(cargosRegistro);
		}
		
		paramAbonVetadoRegOSDTO.setComentario(((ResumenForm)form).getComentario());
		
        UsuarioDTO usuario = new UsuarioDTO();
        usuario.setNombre(sessionData.getUsuario());
        usuario = delegate.obtenerVendedor(usuario);
        
        paramAbonVetadoRegOSDTO.setCodVendedor(usuario.getCodigo());
        
		
	    
	    logger.debug("Parametros Orden de Servicio");
	    logger.debug("paramAbonVetadoRegOSDTO.getCliente().getCodCliente()              :"+paramAbonVetadoRegOSDTO.getCliente().getCodCliente());
	    logger.debug("paramAbonVetadoRegOSDTO.getAbonado().getNumAbonado()              :"+paramAbonVetadoRegOSDTO.getAbonado().getNumAbonado());
	    logger.debug("paramAbonVetadoRegOSDTO.getNumOrdenServicio()                     :"+paramAbonVetadoRegOSDTO.getNumOrdenServicio());
	    logger.debug("paramAbonVetadoRegOSDTO.getCodOrdenServicio()                     :"+paramAbonVetadoRegOSDTO.getCodOrdenServicio());
	    logger.debug("paramAbonVetadoRegOSDTO.getCodProducto()                          :"+paramAbonVetadoRegOSDTO.getCodProducto());
	    logger.debug("paramAbonVetadoRegOSDTO.getTipInter()                             :"+paramAbonVetadoRegOSDTO.getTipInter());
	    logger.debug("paramAbonVetadoRegOSDTO.getCodInter()                             :"+paramAbonVetadoRegOSDTO.getCodInter());
	    logger.debug("paramAbonVetadoRegOSDTO.getSujeto()                               :"+paramAbonVetadoRegOSDTO.getSujeto());
	    logger.debug("paramAbonVetadoRegOSDTO.getUsuario()                              :"+paramAbonVetadoRegOSDTO.getUsuario());
	    logger.debug("paramAbonVetadoRegOSDTO.getFecha()                                :"+paramAbonVetadoRegOSDTO.getFecha());
	    logger.debug("paramAbonVetadoRegOSDTO.getComentario()                           :"+paramAbonVetadoRegOSDTO.getComentario());
	    logger.debug("paramAbonVetadoRegOSDTO.getCodActAbo()                            :"+paramAbonVetadoRegOSDTO.getCodActAbo());
	    logger.debug("paramAbonVetadoRegOSDTO.getCodTipoDocumento()                     :"+paramAbonVetadoRegOSDTO.getCodTipoDocumento());
	    logger.debug("paramAbonVetadoRegOSDTO.getModPago()                              :"+paramAbonVetadoRegOSDTO.getModPago());
	    logger.debug("paramAbonVetadoRegOSDTO.getCodVendedor()                          :"+paramAbonVetadoRegOSDTO.getCodVendedor());
	    logger.debug("paramAbonVetadoRegOSDTO.getACiclo()                               :"+paramAbonVetadoRegOSDTO.getACiclo());
	    
	    
	    
	    logger.debug("ejecutarOrdenServicioAfinesOSJms: inicio");
	    delegate.ejecutarOrdenServicioAbonadoVetadoJms(paramAbonVetadoRegOSDTO);
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
