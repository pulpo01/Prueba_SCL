package com.tmmas.scl.operations.crm.fab.cim.manreq.web.action;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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


import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.BaseAction;


import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoBeneficiarioDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoBeneficiarioListDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.ParamAbonBenefRegOSDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate.ManageRequestBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.ManAboBeneForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.Global;

public class ManAbosBenefJmsAction extends BaseAction {
	private final Logger logger = Logger.getLogger(CargosAction.class);
	private Global global = Global.getInstance();
	private ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();
	protected long codigoCliente;
	protected long numAbonadoSessionData;
	
	protected ActionForward executeAction(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		String nombreAction="factura";
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);
		logger.debug("execute():start");
		ManAboBeneForm manAboBeneForm = (ManAboBeneForm)form;
		ClienteOSSesionDTO sessionData = new ClienteOSSesionDTO();
			
		HttpSession session = request.getSession(false);
		sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");
		
		AbonadoBeneficiarioListDTO listaAbonadosEliminados=null;
		AbonadoBeneficiarioListDTO listaAbonadosAgregados=null;
		sessionData.setCodCliente(sessionData.getCliente()!=null?sessionData.getCliente().getCodCliente():0);
		numAbonadoSessionData=sessionData.getNumAbonado();
		codigoCliente=sessionData.getCodCliente();
		if (manAboBeneForm.getListaEncolar()==null){
			System.out.println("::::Es Nulo:::::::");
		}
		else{
			// Retornar los Eliminados
			listaAbonadosEliminados=listaEliminados(manAboBeneForm);
			//Retorna Los Agregados
			listaAbonadosAgregados=listaAgregados(manAboBeneForm);
			
		}
		
		//TODO : Llamada a Encolar Jms
		//if (listaAbonadosEliminados!=null||listaAbonadosAgregados!=null){
		ParamAbonBenefRegOSDTO paramAbonBenefRegOSDTO =new ParamAbonBenefRegOSDTO();
		//Parametros para registrar Orden de servicio.
		
			
			paramAbonBenefRegOSDTO.setAbonadosBenefiariosEliminar(listaAbonadosEliminados);
			paramAbonBenefRegOSDTO.setAbonadosBenefiariosNuevos(listaAbonadosAgregados);
			logger.debug("ejecutarOrdenServicioJms:antes");
			delegate.ejecutarOrdenServicioAbonadoBeneficiarioJms(paramAbonBenefRegOSDTO);
			logger.debug("ejecutarOrdenServicioJms:despues");
		//}
		
		//manAboBeneForm.setNumCelularAbo())
		logger.debug("execute():end");
		session.setAttribute("recalculado", "NO");
		return mapping.findForward(nombreAction);
	}
	
	protected AbonadoBeneficiarioListDTO listaEliminados(ManAboBeneForm manAboBeneForm){
		String numAbonadoDelegate=null;
		String numAbonadoForm=null;
		List listaAbonadosEliminados=new ArrayList();
		AbonadoBeneficiarioListDTO abonadosBeneficiarioListDTO=null;
		boolean existEliminado=false;
		
		for(int i=0;(manAboBeneForm.getAbonadosDTO()!=null&&i<manAboBeneForm.getAbonadosDTO().length);i++){
			int contNum=0;
			numAbonadoDelegate=String.valueOf(manAboBeneForm.getAbonadosDTO()[i].getNum_Abonado_Beneficiario());
			numAbonadoDelegate=numAbonadoDelegate.trim();
		
			//TODO : Se realiza búsqueda de los Eliminados
			for (int j=0;j<manAboBeneForm.getListaEncolar().length;j++){
				numAbonadoForm=manAboBeneForm.getListaEncolar()[j];
				numAbonadoForm=numAbonadoForm.trim();
				if (numAbonadoDelegate.equals(numAbonadoForm)){
					contNum++;
				}
			}
			
			if (contNum==0){
				existEliminado=true;
				System.out.println("numAbonadoEliminado::"+numAbonadoDelegate);
				listaAbonadosEliminados.add(manAboBeneForm.getAbonadosDTO()[i]);
			}
			
		}
		if (existEliminado){
			AbonadoBeneficiarioDTO[] abonadoBeneficiarioDTO = (AbonadoBeneficiarioDTO[]) ArrayUtl.copiaArregloTipoEspecifico(	listaAbonadosEliminados.toArray(), AbonadoBeneficiarioDTO.class);
			abonadosBeneficiarioListDTO = new AbonadoBeneficiarioListDTO();
			abonadosBeneficiarioListDTO.setAbonadoBeneficiarioList(abonadoBeneficiarioDTO);
		}	
		return abonadosBeneficiarioListDTO;
	}
	
	protected AbonadoBeneficiarioListDTO listaAgregados(ManAboBeneForm manAboBeneForm){
		String numAbonadoDelegate=null;
		String numAbonadoForm=null;
		List listaAbonadosAgregados=null;
		AbonadoBeneficiarioListDTO abonadosBeneficiarioListDTO=null;
		boolean existAgregado=false;
		for (int j=0;j<manAboBeneForm.getListaEncolar().length;j++){
			numAbonadoForm=manAboBeneForm.getListaEncolar()[j];
			numAbonadoForm=numAbonadoForm.trim();
			int contNum=0;
			
			for(int i=0;(manAboBeneForm.getAbonadosDTO()!=null&&i<manAboBeneForm.getAbonadosDTO().length);i++){
				numAbonadoDelegate=String.valueOf(manAboBeneForm.getAbonadosDTO()[i].getNum_Abonado_Beneficiario());
				numAbonadoDelegate=numAbonadoDelegate.trim();
			
			//TODO : Se realiza búsqueda de los Agregados
				if (numAbonadoForm.equals(numAbonadoDelegate)){
					contNum++;
				}
			}
			if (contNum==0){
				AbonadoBeneficiarioDTO abonadoBeneficiarioDTO=null;
				System.out.println("Numero Abonado Agregado::"+numAbonadoForm);
				for (int k=0;k<manAboBeneForm.getListaEncolar().length;k++){
					listaAbonadosAgregados=new ArrayList();
					if (manAboBeneForm.getListaEncolar()[k].equals(numAbonadoForm)){
						abonadoBeneficiarioDTO=new AbonadoBeneficiarioDTO();
						abonadoBeneficiarioDTO.setCodCliente(codigoCliente);
						abonadoBeneficiarioDTO.setNumAbonado(numAbonadoSessionData);
						abonadoBeneficiarioDTO.setNombre(manAboBeneForm.getListaEncolarNombre()[k]);
						abonadoBeneficiarioDTO.setNumCelular(Long.parseLong(manAboBeneForm.getListaEncolarNumCelular()[k]));
						abonadoBeneficiarioDTO.setNum_Abonado_Beneficiario(Long.parseLong(numAbonadoForm));
						abonadoBeneficiarioDTO.setTipo_Comportamiento(manAboBeneForm.getListaEncolarTipoComportamiento()[k]);
						abonadoBeneficiarioDTO.setFec_Inicio_Vigencia(new Timestamp(System.currentTimeMillis()));
						//Se setea Fecha de 30-12-3000 colocar en un properties
						String fecha="30-12-3000";
						//Date d=;
						try{
							abonadoBeneficiarioDTO.setFec_Termino_Vigencia(new Timestamp(new SimpleDateFormat("dd-MM-yyyy").parse(fecha).getTime()));
						}catch(ParseException e){
							e.printStackTrace();
						}	
						listaAbonadosAgregados.add(abonadoBeneficiarioDTO);
					}	
					
				}
				existAgregado=true;		
			}
		}
		if (existAgregado){
			AbonadoBeneficiarioDTO[] abonadoBeneficiarioDTO = (AbonadoBeneficiarioDTO[]) ArrayUtl.copiaArregloTipoEspecifico(	listaAbonadosAgregados.toArray(), AbonadoBeneficiarioDTO.class);
			abonadosBeneficiarioListDTO = new AbonadoBeneficiarioListDTO();
			abonadosBeneficiarioListDTO.setAbonadoBeneficiarioList(abonadoBeneficiarioDTO);
		}
		return abonadosBeneficiarioListDTO;
	}
	
}

