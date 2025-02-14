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

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.BaseAction;
import com.tmmas.scl.framework.ProductDomain.dto.CausaSiniestroDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SolicitudAvisoDeSiniestroDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TipoSiniestroDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TipoSuspencionDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.UsuarioSistemaDTO;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DocumentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.UsuarioDTO;
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CabeceraArchivoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegCargosDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegistroFacturacionDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PresupuestoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ResultadoRegCargosDTO;
import com.tmmas.scl.operation.crm.fab.cusintman.avisinie.common.dataTransfertObject.RegistraAvisoDeSiniestroActionDTO;
import com.tmmas.scl.operations.crm.fab.cusintman.web.delegate.AvisoSiniestroBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cusintman.web.form.AvisoSiniestroForm;
import com.tmmas.scl.operations.crm.fab.cusintman.web.helper.Global;
import com.tmmas.scl.operations.frmkooss.web.delegate.FrmkOOSSBussinessDelegate;
import com.tmmas.scl.operations.frmkooss.web.dto.TablaCargosDTO;
import com.tmmas.scl.operations.frmkooss.web.form.CargaPdfForm;
import com.tmmas.scl.operations.frmkooss.web.form.CargosForm;
import com.tmmas.scl.operations.frmkooss.web.form.PresupuestoForm;
import com.tmmas.scl.operations.frmkooss.web.form.ResumenForm;

public class RegistrarAvisSiniesAction extends BaseAction{
	private final Logger logger = Logger.getLogger(RegistrarAvisSiniesAction.class);
	private Global global = Global.getInstance();
	private static final String SIGUIENTE = "factura";
	private static final String FIN = "fin";
	private FrmkOOSSBussinessDelegate delegateFrmkOOSS = FrmkOOSSBussinessDelegate.getInstance();
	private AvisoSiniestroBussinessDelegate delegate = AvisoSiniestroBussinessDelegate.getInstance();
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
		RegistraAvisoDeSiniestroActionDTO regviSinActDTO=new RegistraAvisoDeSiniestroActionDTO();
		
		AvisoSiniestroForm avisoSiniestroForm;
		avisoSiniestroForm =(AvisoSiniestroForm)session.getAttribute("AvisoSiniestroForm");
		PresupuestoForm formPresupuesto=(PresupuestoForm)session.getAttribute("PresupuestoForm");
		
		//LLeno todos los objetos para la grabacion
    	TipoSiniestroDTO tipoSiniestro = new TipoSiniestroDTO();
    	tipoSiniestro.setCod_TipoSiniestro(avisoSiniestroForm.getTipoSiniestro());
    	
    	TipoSuspencionDTO tipoSuspencion = new TipoSuspencionDTO();
    	tipoSuspencion.setCod_TipoSuspencion(avisoSiniestroForm.getTipoSuspencion());
    	
    	CausaSiniestroDTO causaSiniestro = new CausaSiniestroDTO();
    	causaSiniestro.setCod_causa(avisoSiniestroForm.getCausaSiniestro());
    	
    	UsuarioSistemaDTO usuarioSistema = new UsuarioSistemaDTO();
    	usuarioSistema.setNom_usuario(sessionData.getUsuario());
	    
    	String actAbo = global.getValor("ACT_AVISOSINIESTRO");
    	
    	String num_os = String.valueOf(sessionData.getNumOrdenServicio());

		ResumenForm resumenForm = (ResumenForm)session.getAttribute("ResumenForm");

    	// Grabo todos los datos
		UsuarioAbonadoDTO usuarioAbonadoDTO=new UsuarioAbonadoDTO();
		usuarioAbonadoDTO=(UsuarioAbonadoDTO)session.getAttribute("usuarioAbonado");
		regviSinActDTO.setUsuarioAbonadoDTO(usuarioAbonadoDTO);
		regviSinActDTO.setTipoSiniestroDTO(tipoSiniestro);
		regviSinActDTO.setTipoSuspencionDTO(tipoSuspencion);
		regviSinActDTO.setCausaSiniestroDTO(causaSiniestro);
		regviSinActDTO.setUsuarioSistemaDTO(usuarioSistema);
		regviSinActDTO.setNumOS(num_os);
		regviSinActDTO.setComentario(resumenForm.getComentario());
    	//SolicitudAvisoDeSiniestroDTO aviso = delegate.grabaAvisoDeSiniestro((UsuarioAbonadoDTO)session.getAttribute("usuarioAbonado"), tipoSiniestro, tipoSuspencion, causaSiniestro, usuarioSistema, actAbo, num_os, resumenForm.getComentario());
    	//Armo el mensaje a mostrar al usaurio
    	String mensaje = new String();
    	mensaje = "El Número de OO.SS. Generado es: \n" + num_os;

    	// Por solicitud de testing se ha eliminado estos comentarios
//    	if (aviso.getNum_solucionequipo() != 0) mensaje = mensaje + " Aviso de siniestro del equipo : " + aviso.getNum_solucionequipo();
//    	if (aviso.getNum_solucionSimcard() != 0) mensaje = mensaje + " \n Aviso de siniestro de simcard : " + aviso.getNum_solucionSimcard();
    	
    	request.setAttribute("flagMensaje", "1");
    	session.setAttribute("mensajeOOSSAviso", mensaje);
    		
		CargosForm cargosForm = (CargosForm)session.getAttribute("CargosForm");
		regviSinActDTO.setCmbCiclo(cargosForm.getRbCiclo());
		
		//Inicio Inc. 174755/CSR-11002/06-09-2011/FDL
		regviSinActDTO.setNroCelularDesviado(avisoSiniestroForm.getNumeroDesviado());
		//Inicio Inc. 174755/CSR-11002/06-09-2011/FDL
		
		/*------------------Aceptar presupuesto-----------------*/
		 if(cargosForm!=null && cargosForm.getRbCiclo().equalsIgnoreCase("NO")){
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
				regviSinActDTO.setPresupuestoDTO(presup);
				//delegateFrmkOOSS.aceptarPresupuesto(presup);
				logger.debug("aceptarPresupuesto:despues");
				session.removeAttribute("PresupuestoForm");
				return mapping.findForward(SIGUIENTE);	
			}
		}//fin rbCiclo = NO
		/*------------------Fin Aceptar presupuesto-----------------*/
		 
		 //Registrar los Cargos
		 try{
			 RegCargosDTO retValConst=new RegCargosDTO();
			retValConst=this.delegateFrmkOOSS.construirRegistroCargos(cargosForm.getCargosSeleccionados());
			CabeceraArchivoDTO objetoSesion=new CabeceraArchivoDTO();
			
			
			UsuarioAbonadoDTO usuarioAbonado = (UsuarioAbonadoDTO)session.getAttribute("usuarioAbonado");
			
			objetoSesion.setPlanComercialCliente(String.valueOf(sessionData.getCliente().getCodPlanCom()));
			objetoSesion.setCodigoCliente(String.valueOf(usuarioAbonado.getCod_cliente()));
			
			objetoSesion.setFacturaCiclo(true);
			objetoSesion.setNumeroVenta(0);
			objetoSesion.setNumeroTransaccionVenta(0);
			objetoSesion.setCodigoDocumento(cargosForm.getCbTipoDocumento());
			objetoSesion.setCodModalidadVenta(cargosForm.getCbModPago());
			
			
			usuarioSistema = (UsuarioSistemaDTO)session.getAttribute("usuarioSistema");
			//TODO : Obtener vendedor
			UsuarioDTO usuario = new UsuarioDTO();
	        usuario.setNombre(usuarioSistema.getNom_usuario());//NOMBRE DE USUARIO DE ORACLE (getNom_usuario es correcto??)
	        usuario = delegateFrmkOOSS.obtenerVendedor(usuario);
			objetoSesion.setCodigoVendedor(String.valueOf(usuario.getCodigo()));
			
			
			
			retValConst.setObjetoSesion(objetoSesion);
			regviSinActDTO.setRegCargosDTO(retValConst);
			delegate.registrarAvisoDeSiniestroAction(regviSinActDTO);
			//ResultadoRegCargosDTO resultado = delegateFrmkOOSS.parametrosRegistrarCargos(retValConst);
		 }catch(Exception e){
				
				/**
				 * @author rlozano
				 * @description realizar rollback manual de presupuesto, cargos, venta
				 */
			 	GeneralException ce= (GeneralException)e;
				RetornoDTO retorno=new RetornoDTO();
				boolean isACiclo=cargosForm.getRbCiclo().trim().equals("NO")?true:false;
				RegistroFacturacionDTO registro = new RegistroFacturacionDTO();
				if (isACiclo){
					registro.setNumeroProcesoFacturacion(String.valueOf(formPresupuesto.getNumProceso()));
					retorno=delegateFrmkOOSS.eliminarPresupuesto(registro);
					retorno.setDescripcion("Se eliminó el presupuesto Nº "+formPresupuesto.getNumProceso());
				}
				textoMensajeRestricciones="Registrar Orden de servicio .: Aviso Siniestro:.";
				delegate.guardaMensajesError(request,textoMensajeRestricciones, ce.getDescripcionEvento());
				
				
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
