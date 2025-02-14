package com.tmmas.scl.operations.crm.fab.cusintman.web.action;

import java.util.Iterator;
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
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.aplicationDomain.dto.UsuarioSistemaDTO;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.CargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DocumentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.UsuarioDTO;
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CabeceraArchivoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CargosObtenidosDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegCargosDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.SuspensionAbonadoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PresupuestoDTO;
import com.tmmas.scl.operation.crm.fab.cusintman.suspvol.common.dataTransfertObject.RegistraSuspVoluntariaDTO;
import com.tmmas.scl.operations.crm.fab.cusintman.web.delegate.SuspensionVoluntariaBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cusintman.web.form.SuspensionVoluntariaForm;
import com.tmmas.scl.operations.frmkooss.web.delegate.FrmkOOSSBussinessDelegate;
import com.tmmas.scl.operations.frmkooss.web.dto.TablaCargosDTO;
import com.tmmas.scl.operations.frmkooss.web.form.CargosForm;
import com.tmmas.scl.operations.frmkooss.web.form.PresupuestoForm;
import com.tmmas.scl.operations.frmkooss.web.form.ResumenForm;
import com.tmmas.scl.operations.frmkooss.web.helper.Global;

public class RegistrarSuspVolAction extends BaseAction{
	private final Logger logger = Logger.getLogger(RegistrarSuspVolAction.class);
	private Global global = Global.getInstance();
	//private static final String SIGUIENTE = "factura";
	private static final String FIN = "fin";
	private FrmkOOSSBussinessDelegate delegateFrmkOOSS = FrmkOOSSBussinessDelegate.getInstance();
	private SuspensionVoluntariaBussinessDelegate delegate = SuspensionVoluntariaBussinessDelegate.getInstance();
	private String textoMensajeRestricciones;
	
	public ActionForward executeAction(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	throws Exception {

		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);
		logger.debug("execute():start");
		HttpSession session = request.getSession(false);
		ClienteOSSesionDTO sessionData;
		sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");
		RegistraSuspVoluntariaDTO regServSuplemtDTO = new RegistraSuspVoluntariaDTO(); 
		UsuarioSistemaDTO usuarioSistema;
		usuarioSistema = (UsuarioSistemaDTO)session.getAttribute("usuarioSistema");
		
		CargosForm cargosForm = (CargosForm)session.getAttribute("CargosForm");

		// ---------------------------------------------------------------------------------------------------------------------------------------
		// Registramos y desregistramos los servicios del abonado
		// Nota : Si el tipo de plan es prepago entonces se le pasa el monto total de los cargos, solo en ese caso
		String montoTotal = null;
		if (sessionData.getAbonados()[0].getCodTipPlan().equals(global.getValor("COD_TIP_PLAN_PREPAGO")))	{
			if(cargosForm != null && cargosForm.getTotal() != null)
			{
				montoTotal = new String(cargosForm.getTotal());	
			}
		}
		
		logger.debug("montoTotal ["+montoTotal+"]");
		
		ResumenForm resumenForm = (ResumenForm) session.getAttribute("ResumenForm");
				
		// ----------------------------------------------------------------------------------------
		// Efecto la OOSS
		SuspensionAbonadoDTO suspension = (SuspensionAbonadoDTO)session.getAttribute("suspensionAbonado");
		SuspensionVoluntariaForm suspensionVoluntariaForm = (SuspensionVoluntariaForm)session.getAttribute("suspensionVoluntariaForm");		

		// ----------------------------------------------------------------------------------------
		
		if (session.getAttribute("oossComisionable").toString().equals("NO"))
			regServSuplemtDTO.setOossComisionable(false);
		else
			regServSuplemtDTO.setOossComisionable(true);
		// ---------------------------------------------------------------------------------------------------------------------------------------
		
		
		/*------------------Aceptar presupuesto-----------------*/
		 if(cargosForm!=null && cargosForm.getRbCiclo().equalsIgnoreCase("NO")){
			logger.debug("cargosForm.getRbCiclo() = [NO]==> verifica si hay presupuesto");
			PresupuestoForm presupuestoForm = new PresupuestoForm();
			if(session.getAttribute("PresupuestoForm")!=null){
				presupuestoForm = (PresupuestoForm)session.getAttribute("PresupuestoForm");

				String codTipoDocumento = cargosForm.getCbTipoDocumento();
				String tipoFoliacion = " ";
				
				//busca tipo foliacion:
				List listaTiposDoc = cargosForm.getDocumentosList();
				if (listaTiposDoc!= null){
					Iterator ite = listaTiposDoc.iterator();
				    while (ite.hasNext()) {
				    	DocumentoDTO doc = (DocumentoDTO)ite.next();
			        	if (doc.getCodigo().equals(codTipoDocumento)){
			        		tipoFoliacion = doc.getTipoFoliacion();
			        		break;
			        	}
				    }
				}
				
				PresupuestoDTO presup = new PresupuestoDTO();
				presup.setNumVenta(cargosForm.getNumVenta());
				presup.setNumProceso(presupuestoForm.getNumProceso());
				presup.setTipoFoliacion(tipoFoliacion);
				logger.debug("aceptarPresupuesto:antes");
				regServSuplemtDTO.setCmbCiclo("NO");
				regServSuplemtDTO.setPresupuestoDTO(presup);
			
				logger.debug("aceptarPresupuesto:despues");
				session.removeAttribute("PresupuestoForm");
					
			}
		}else//fin rbCiclo = NO
		{
			if(cargosForm!=null)
			{
				logger.debug("cargosForm.getRbCiclo() = ["+cargosForm.getRbCiclo()+"]");
			}else{
				logger.debug("cargosForm=null");
			}
			
		}
		/*------------------Fin Aceptar presupuesto-----------------*/

		//Registrar los Cargos
		RegCargosDTO retValConst=new RegCargosDTO();

		try{
			// Hay que preguntar por nulo en caso de que sea anular, para que no se caiga en la llamada al metodo
			retValConst=this.delegateFrmkOOSS.construirRegistroCargos(cargosForm==null?null:cargosForm.getCargosSeleccionados());
			if(retValConst!=null && retValConst.getCargos()!=null && retValConst.getCargos().length>0)
			{
				logger.debug("construirRegistroCargos, numero de cargos construidos["+retValConst.getCargos().length+"]");
			}else{
				logger.debug("construirRegistroCargos, no hay cargos construidos");
			}
			CabeceraArchivoDTO objetoSesion=new CabeceraArchivoDTO();

			UsuarioAbonadoDTO usuarioAbonado = (UsuarioAbonadoDTO)session.getAttribute("usuarioAbonado");

			objetoSesion.setPlanComercialCliente(String.valueOf(sessionData.getCliente().getCodPlanCom()));
			objetoSesion.setCodigoCliente(String.valueOf(usuarioAbonado.getCod_cliente()));

			objetoSesion.setFacturaCiclo(true);
			//revisar 081009 con OC// se verifica getCargosObtenidos 151009 
			if(cargosForm!=null && cargosForm.getRbCiclo().equalsIgnoreCase("NO")){
				objetoSesion.setFacturaCiclo(false);
				if(sessionData.getCargosObtenidos() != null){
					sessionData.getCargosObtenidos().setACiclo(false);
				}
			}else
			{//081009 para que guarde los cargos a ciclo pv
				objetoSesion.setFacturaCiclo(true);
				if(sessionData.getCargosObtenidos() != null){
					sessionData.getCargosObtenidos().setACiclo(true);
				}
			}

			logger.debug("objetoSesion.isFacturaCiclo["+objetoSesion.isFacturaCiclo()+"]");
			objetoSesion.setNumeroVenta(0);
			objetoSesion.setNumeroTransaccionVenta(0);

			// Hay que preguntar por nulo en caso de que sea anular, para que no se caiga en la llamada al metodo				
			objetoSesion.setCodigoDocumento(cargosForm==null?null:cargosForm.getCbTipoDocumento());
			// Hay que preguntar por nulo en caso de que sea anular, para que no se caiga en la llamada al metodo
			objetoSesion.setCodModalidadVenta(cargosForm==null?null:cargosForm.getCbModPago());


			usuarioSistema = (UsuarioSistemaDTO)session.getAttribute("usuarioSistema");
			//TODO : Obtener vendedor
			UsuarioDTO usuario = new UsuarioDTO();
			usuario.setNombre(usuarioSistema.getNom_usuario());//NOMBRE DE USUARIO DE ORACLE (getNom_usuario es correcto??)
			usuario = delegateFrmkOOSS.obtenerVendedor(usuario);
			objetoSesion.setCodigoVendedor(String.valueOf(usuario.getCodigo()));
			
			retValConst.setObjetoSesion(objetoSesion);
			regServSuplemtDTO.setRegCargosDTO(retValConst);
			regServSuplemtDTO.setSuspension(suspension);
			regServSuplemtDTO.setOpcionProceso(suspensionVoluntariaForm.getOpcionProceso());
			regServSuplemtDTO.setSessionData(sessionData);

			// Tomo el comentario de pantalla y lo guardo
			String comentario = new String();
			comentario = ((ResumenForm)session.getAttribute("ResumenForm")).getComentario();
			sessionData.setComentarioOS(comentario);
			logger.debug("delegate.registrarSuspensionVoluntaria(regServSuplemtDTO) ini---------------------------->");
			delegate.registrarSuspensionVoluntaria(regServSuplemtDTO);
			logger.debug("delegate.registrarSuspensionVoluntaria(regServSuplemtDTO) fin---------------------------->");
		}
		catch(Exception e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("Exception[" + loge + "]");
			delegate.guardaMensajesError(request, e.getMessage(), e);
			return mapping.findForward("error");
		}			
		
		logger.debug("execute():end");
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
}
