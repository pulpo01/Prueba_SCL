package com.tmmas.scl.operations.crm.fab.cusintman.web.action;

import java.util.Date;
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
import com.tmmas.scl.framework.aplicationDomain.dto.UsuarioSistemaDTO;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DocumentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.UsuarioDTO;
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CabeceraArchivoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegCargosDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PresupuestoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ResultadoRegCargosDTO;
import com.tmmas.scl.operation.crm.fab.cusintman.servsup.common.dataTransfertObject.NumeroAjaxDTO;
import com.tmmas.scl.operation.crm.fab.cusintman.servsup.common.dataTransfertObject.RegistraServSuplemtDTO;
import com.tmmas.scl.operations.crm.fab.cusintman.web.delegate.ServiciosSuplementariosBussinessDelegate;
import com.tmmas.scl.operations.frmkooss.web.delegate.FrmkOOSSBussinessDelegate;
import com.tmmas.scl.operations.frmkooss.web.dto.TablaCargosDTO;
import com.tmmas.scl.operations.frmkooss.web.form.CargosForm;
import com.tmmas.scl.operations.frmkooss.web.form.PresupuestoForm;
import com.tmmas.scl.operations.frmkooss.web.form.ResumenForm;
import com.tmmas.scl.operations.frmkooss.web.helper.Global;
import com.tmmas.scl.vendedor.dto.VendedorDTO;

public class RegistrarServSuplAction extends BaseAction{
	private final Logger logger = Logger.getLogger(RegistrarServSuplAction.class);
	private Global global = Global.getInstance();
	//private static final String SIGUIENTE = "factura";
	private static final String FIN = "fin";
	private FrmkOOSSBussinessDelegate delegateFrmkOOSS = FrmkOOSSBussinessDelegate.getInstance();
	private ServiciosSuplementariosBussinessDelegate delegateServiciosSuplementarios = ServiciosSuplementariosBussinessDelegate.getInstance();	
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
		RegistraServSuplemtDTO regServSuplemtDTO=new RegistraServSuplemtDTO(); 
		UsuarioSistemaDTO usuarioSistema;
		usuarioSistema = (UsuarioSistemaDTO)session.getAttribute("usuarioSistema");
		
		CargosForm cargosForm = (CargosForm)session.getAttribute("CargosForm");

		// ---------------------------------------------------------------------------------------------------------------------------------------
		// Registramos y desregistramos los servicios del abonado
		// Nota : Si el tipo de plan es prepago entonces se le pasa el monto total de los cargos, solo en ese caso
		String montoTotal = null;
		String contratTabla=null;
		String noContratTabla=null;
		String contactosTabla=null;
		
		if (sessionData.getAbonados()[0].getCodTipPlan().equals(global.getValor("COD_TIP_PLAN_PREPAGO=")))	{
			montoTotal = new String(cargosForm.getTotal());
		}
		
		if (session.getAttribute("contratadosTabla")!=null)
		{
			logger.debug("contratadosTabla ["+session.getAttribute("contratadosTabla").toString());
			contratTabla=session.getAttribute("contratadosTabla").toString();
		}
		if (session.getAttribute("nocontratadosTabla")!=null)
		{
			noContratTabla=session.getAttribute("nocontratadosTabla").toString();
			logger.debug("nocontratadosTabla ["+session.getAttribute("nocontratadosTabla").toString());
		}
		if (session.getAttribute("contactosTabla")!=null)
		{
			contactosTabla=session.getAttribute("contactosTabla").toString();
			logger.debug("contactosTabla ["+session.getAttribute("contactosTabla").toString());
		}
		
		logger.debug("montoTotal ["+montoTotal);
		
		VendedorDTO vendedor = (VendedorDTO)session.getAttribute("Vendedor");
		ResumenForm resumenForm = (ResumenForm) session.getAttribute("ResumenForm");
				
		
		
		/**
    	 * @author rlozano
    	 * @description llenamos el vendedor en caso este null;
    	 */
    	
    	if (session.getAttribute("Vendedor") == null&&session.getAttribute("oossComisionable").toString().equals("SI")){
    		vendedor=new VendedorDTO();
    		vendedor.setCod_vendedor(String.valueOf(usuarioSistema.getCod_vendedor()));
    		vendedor.setNom_vendedor(usuarioSistema.getNom_usuario());
    		vendedor.setCod_os(String.valueOf(sessionData.getCodOrdenServicio()));
    		vendedor.setNumOOSS(String.valueOf(sessionData.getNumOrdenServicio()));
    		vendedor.setFecha(new Date());
    		vendedor.setCod_tipcomis(usuarioSistema.getCod_tipcomis());
    		vendedor.setInd_interno(true);
    		vendedor.setUsuario(usuarioSistema.getNom_usuario());
    		vendedor.setCod_oficina(usuarioSistema.getCod_oficina());
    		session.setAttribute("Vendedor", vendedor);
    	}

		// Activo y desactivo los servicios sumplementarios
		
		
		regServSuplemtDTO.setClienteOSSesionDTO(sessionData);
		regServSuplemtDTO.setContratTabla(contratTabla);
		regServSuplemtDTO.setNoContratTabla(noContratTabla);
		regServSuplemtDTO.setContactosTabla(contactosTabla);
		regServSuplemtDTO.setMontoTotal(montoTotal);
		regServSuplemtDTO.setUsuarioSistemaDTO(usuarioSistema);
		regServSuplemtDTO.setVendedorDTO(vendedor);
		regServSuplemtDTO.setComentario(resumenForm.getComentario());
		
		if (session.getAttribute("oossComisionable").toString().equals("NO"))
			regServSuplemtDTO.setOossComisionable(false);
		else
			regServSuplemtDTO.setOossComisionable(true);
		// ---------------------------------------------------------------------------------------------------------------------------------------
		
		
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
				regServSuplemtDTO.setCmbCiclo("NO");
				regServSuplemtDTO.setPresupuestoDTO(presup);
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
				regServSuplemtDTO.setRegCargosDTO(retValConst);
				
				// Si se contrata el servicio de fax, debe grabar el numero elegido
				String grabarFax = (String)session.getAttribute("grabarFax");
				if (grabarFax.equals("true"))	{
					NumeroAjaxDTO numero =  new NumeroAjaxDTO();
					numero = (NumeroAjaxDTO)session.getAttribute("numeroSel");
					regServSuplemtDTO.setNumeroFax(numero.getNumCelular());				
				} // if
						
				//ResultadoRegCargosDTO resultado = delegateFrmkOOSS.parametrosRegistrarCargos(retValConst);
				delegateServiciosSuplementarios.registrarServiciosSuplementariosAction(regServSuplemtDTO);
			}
			catch(Exception e){
				textoMensajeRestricciones="Error al Registrar Cargos";
				delegateServiciosSuplementarios.guardaMensajesError(request, textoMensajeRestricciones, e);
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
