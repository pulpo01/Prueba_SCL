package com.tmmas.scl.operations.crm.fab.cusintman.web.action;

import java.sql.Date;
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
import com.tmmas.scl.framework.ProductDomain.dto.SiniestrosDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.SesionDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.UsuarioSistemaDTO;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DocumentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.UsuarioDTO;
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CabeceraArchivoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegCargosDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PresupuestoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ResultadoRegCargosDTO;
import com.tmmas.scl.operation.crm.fab.cusintman.anulsinie.common.dataTransfertObject.RegistrarAnulacionSiniestroDTO;
import com.tmmas.scl.operations.crm.fab.cusintman.web.delegate.AnulacionSiniestroBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cusintman.web.form.AnulacionSiniestroForm;
import com.tmmas.scl.operations.crm.fab.cusintman.web.helper.Global;
import com.tmmas.scl.operations.crm.fab.customerinterfacemanagement.common.exception.CusIntManException;
import com.tmmas.scl.operations.frmkooss.web.delegate.FrmkOOSSBussinessDelegate;
import com.tmmas.scl.operations.frmkooss.web.dto.TablaCargosDTO;
import com.tmmas.scl.operations.frmkooss.web.form.CargosForm;
import com.tmmas.scl.operations.frmkooss.web.form.PresupuestoForm;
import com.tmmas.scl.operations.frmkooss.web.form.ResumenForm;


public class RegistrarAnulSiniAction extends BaseAction{
	private final Logger logger = Logger.getLogger(RegistrarAnulSiniAction.class);
	private Global global = Global.getInstance();
	//private static final String SIGUIENTE = "factura";
	private static final String FIN = "fin";
	private FrmkOOSSBussinessDelegate delegateFrmkOOSS = FrmkOOSSBussinessDelegate.getInstance();
	private AnulacionSiniestroBussinessDelegate delegate = AnulacionSiniestroBussinessDelegate.getInstance();
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
		
		
//		NEGOCIO OOSS
		UsuarioAbonadoDTO usuarioAbonado = (UsuarioAbonadoDTO)session.getAttribute("usuarioAbonado");
	    
	    
		SiniestrosDTO siniestro = new SiniestrosDTO();
		AnulacionSiniestroForm formBean = (AnulacionSiniestroForm)session.getAttribute("AnulacionSiniestroForm");
    	siniestro.setNum_siniestro(Long.valueOf(formBean.getNumSiniestro()).longValue());
    	Date fecSinistro = Date.valueOf(formBean.getFecSiniestro());
    	siniestro.setFec_siniestro(fecSinistro);
    	siniestro.setCod_causa(formBean.getCodCausa());
    	siniestro.setNum_serie(usuarioAbonado.getNum_serie());
   		//Incluido santiago ventura 23-03-2010
    	logger.info("Se obtiene del form el numero que anula constancia policial: "+formBean.getNumConstaPolAnula());
    	siniestro.setNumConstaPolAnula(formBean.getNumConstaPolAnula());
    	
    	//Estos dos parametros deben ser cambiados de orden en el DAO
    	siniestro.setCodOoss(String.valueOf(sessionData.getNumOrdenServicio()));
    	siniestro.setNumOoss(Long.valueOf(global.getValor(String.valueOf(sessionData.getCodOrdenServicio()))).longValue());
    	
    	
    	ResumenForm resumenForm = (ResumenForm)session.getAttribute("ResumenForm");
    	siniestro.setObs_detalle(resumenForm.getComentario()!=null?resumenForm.getComentario():"");
    	
    	AnulacionSiniestroForm anuForm=(AnulacionSiniestroForm)session.getAttribute("AnulacionSiniestroForm");
    	SesionDTO sesionDTO = new SesionDTO();
    	String codigoPrograma = global.getValor("codigoPrograma");
 	    String versionPrograma = global.getValor("versionPrograma");
 	    Long versionProgramaLong = new Long (versionPrograma);
 	   Long numAbonadoLong = new Long (sessionData.getNumAbonado());
    	
	    sesionDTO.setCodCliente(sessionData.getCliente().getCodCliente());
	    sesionDTO.setCod_programa(codigoPrograma);
	    sesionDTO.setNum_version(versionProgramaLong.longValue());
	    sesionDTO.setNumAbonado(numAbonadoLong.longValue());
	    
	    // Almaceno el usuario del sistema
	    UsuarioSistemaDTO usuarioSistema = new UsuarioSistemaDTO();
	    usuarioSistema.setNom_usuario(sessionData.getUsuario());
	    sesionDTO.setUsuario(usuarioSistema);
	    RegistrarAnulacionSiniestroDTO regAnuSinDTO =new RegistrarAnulacionSiniestroDTO();
	    
	    regAnuSinDTO.setUsuarioAbonadoDTO(usuarioAbonado);
	    regAnuSinDTO.setSesionDTO(sesionDTO);
	    String indLisNegra=anuForm.getVaListaNegra();
	    indLisNegra=indLisNegra==null?"":indLisNegra;
	    indLisNegra="on".equals(indLisNegra)?"1":"0";
	    siniestro.setIndlistaNegra(indLisNegra);
	    regAnuSinDTO.setSiniestrosDTO(siniestro);
	   	    
    	//delegate.anulaSinistroAbonado(siniestro, usuarioAbonado, sesionDTO);
    	
    	// Armo el mensaje a mostrar al usaurio
    	String mensaje = new String();
    	mensaje = "Gracias por Preferinos. Powered by TM-MAS.";
    	
    	request.setAttribute("mensajeOOSSAviso", mensaje);
		
		CargosForm cargosForm = (CargosForm)session.getAttribute("CargosForm");
		
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
				regAnuSinDTO.setCmbCiclo("NO");
				regAnuSinDTO.setPresupuestoDTO(presup);
				//delegateFrmkOOSS.aceptarPresupuesto(presup);
				logger.debug("aceptarPresupuesto:despues");
				session.removeAttribute("PresupuestoForm");
				//return mapping.findForward(SIGUIENTE);	
			}
		}//fin rbCiclo = NO
			/*------------------Fin Aceptar presupuesto-----------------*/

			//Registrar los Cargos
			RegCargosDTO retValConst=new RegCargosDTO();

			try{
				boolean isExistCargos=cargosForm.getCargosSeleccionados()!=null&&
						cargosForm.getCargosSeleccionados().getCargos()!=null&&cargosForm.getCargosSeleccionados().getCargos().length>0?true:false;
				if (isExistCargos){
				retValConst=this.delegateFrmkOOSS.construirRegistroCargos(cargosForm.getCargosSeleccionados());
				}
				CabeceraArchivoDTO objetoSesion=new CabeceraArchivoDTO();


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
				regAnuSinDTO.setRegCargosDTO(retValConst);
				//ResultadoRegCargosDTO resultado = delegateFrmkOOSS.parametrosRegistrarCargos(retValConst);
				RetornoDTO retValue=delegate.RegistrarAnulacionSiniestroAction(regAnuSinDTO); 
			}
			catch(Exception e){
				GeneralException ex=null;
				if (e instanceof CusIntManException) {
					ex = (CusIntManException) e;
					
				}
				ex=ex==null?new CusIntManException("Verique log para determinar el error"):ex;
				textoMensajeRestricciones="Error al Registrar Orden de Servicio y/o Cargos";
				delegate.guardaMensajesError(request, ex.getDescripcionEvento(), textoMensajeRestricciones);
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
