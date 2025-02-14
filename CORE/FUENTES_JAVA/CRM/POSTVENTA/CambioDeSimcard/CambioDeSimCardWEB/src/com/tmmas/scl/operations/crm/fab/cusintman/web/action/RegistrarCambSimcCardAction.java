package com.tmmas.scl.operations.crm.fab.cusintman.web.action;

import java.util.Calendar;
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

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.BaseAction;
import com.tmmas.scl.framework.ProductDomain.dto.BodegaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CausaCamSerieDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CuotaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.ModalidadPagoDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SerieDTO;
import com.tmmas.scl.framework.ProductDomain.dto.UsoArticuloDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.MensajeRetornoDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.SesionDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.UsuarioSistemaDTO;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DocumentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RegistrarOossEnLineaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RegistrarRenovaDTO; // ini-p-mix-09003 ocb
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.UsuarioDTO;
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CabeceraArchivoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegCargosDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegistroFacturacionDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PresupuestoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ResultadoRegCargosDTO;
import com.tmmas.scl.operation.crm.fab.cusintman.cambsimcard.common.dataTransferObject.RegistraCambioDeSimcardActionDTO;
import com.tmmas.scl.operations.crm.fab.cusintman.web.delegate.CambioSimCardBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cusintman.web.form.CambioDeSimCardForm;
import com.tmmas.scl.operations.frmkooss.web.dto.TablaCargosDTO;
import com.tmmas.scl.operations.frmkooss.web.form.CargosForm;
import com.tmmas.scl.operations.frmkooss.web.form.PresupuestoForm;
import com.tmmas.scl.operations.frmkooss.web.form.ResumenForm;
//import com.tmmas.scl.operations.crm.fab.cusintman.web.helper.Global;
import com.tmmas.scl.operations.frmkooss.web.helper.Global;
import com.tmmas.scl.vendedor.dto.VendedorDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CartaGeneralDTO;

public class RegistrarCambSimcCardAction extends BaseAction{
	private final Logger logger = Logger.getLogger(RegistrarCambSimcCardAction.class);
	private Global global = Global.getInstance();
	private static final String SIGUIENTE = "factura";
	private static final String FIN = "fin";
	private static final String CARTA_EN_SESION = "_CARTA_EN_SESION_";//157171
	//private FrmkOOSSBussinessDelegate delegateFrmkOOSS = FrmkOOSSBussinessDelegate.getInstance();
	private CambioSimCardBussinessDelegate delegate = CambioSimCardBussinessDelegate.getInstance();
	private String textoMensajeRestricciones;
	public ActionForward executeAction(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	throws Exception {

		RegistraCambioDeSimcardActionDTO registraCambioDeSimcardActionDTO=new RegistraCambioDeSimcardActionDTO();
		logger.debug("execute():start");
		HttpSession session = request.getSession(false);
		ClienteOSSesionDTO sessionData;
		sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");
		SesionDTO sesionDTO = (SesionDTO)session.getAttribute("sesionDTO");
		UsuarioAbonadoDTO usuarioAbonado = (UsuarioAbonadoDTO) session.getAttribute("usuarioAbonado");
		PresupuestoForm formPresupuesto=(PresupuestoForm)session.getAttribute("PresupuestoForm");
		
//		UsuarioSistemaDTO usuario = new UsuarioSistemaDTO();
		UsuarioSistemaDTO usuarioSis = (UsuarioSistemaDTO)session.getAttribute("usuarioSistema");

		VendedorDTO vendedor = (VendedorDTO)session.getAttribute("Vendedor");
		
		/**
    	 * @author rlozano
    	 * @description llenamos el vendedor en caso este null;
    	 */
    	
    	if (session.getAttribute("Vendedor") == null&&session.getAttribute("oossComisionable").toString().equals("SI")){
    		vendedor=new VendedorDTO();
    		vendedor.setCod_vendedor(String.valueOf(usuarioSis.getCod_vendedor()));
    		vendedor.setNom_vendedor(usuarioSis.getNom_usuario());
    		vendedor.setCod_os(String.valueOf(sessionData.getCodOrdenServicio()));
    		vendedor.setNumOOSS(String.valueOf(sessionData.getNumOrdenServicio()));
    		vendedor.setFecha(new Date());
    		vendedor.setCod_tipcomis(usuarioSis.getCod_tipcomis());
    		vendedor.setInd_interno(true);
    		vendedor.setUsuario(usuarioSis.getNom_usuario());
    		vendedor.setCod_oficina(usuarioSis.getCod_oficina());
    		session.setAttribute("Vendedor", vendedor);
    	}
		
		
		
//		NEGOCIO OOSS
		Long numAbonadoLong = new Long (sessionData.getNumAbonado());
		 // ------------------------------------------------------------------------
		String codigoPrograma = global.getValor("codigoPrograma");
	    String versionPrograma = global.getValor("versionPrograma");
	    Long versionProgramaLong = new Long (versionPrograma);
	    
	    sesionDTO.setCod_programa(codigoPrograma);
	    sesionDTO.setNum_version(versionProgramaLong.longValue());
	    sesionDTO.setNumAbonado(numAbonadoLong.longValue());
		
		CambioDeSimCardForm formBeanCambioSimCard = (CambioDeSimCardForm)session.getAttribute("CambioDeSimCardForm");
		CargosForm cargosForm= (CargosForm)session.getAttribute("CargosForm");
		
		//VendedorDTO vendedor = (VendedorDTO)session.getAttribute("Vendedor");
		/*
		regServSuplemtDTO.setClienteOSSesionDTO(sessionData);
		regServSuplemtDTO.setMontoTotal(montoTotal);
		regServSuplemtDTO.setUsuarioSistemaDTO(usuarioSistema);
		regServSuplemtDTO.setVendedorDTO(vendedor);
		*/
		/***
		 * @author rlozano
		 * @description : se mueve el tema de aceptacion de presupuesto de Resumen Action a Registrar Cambio Simcard, 
		 * con el fin de unificar la funcionalidad con la de registrar la orden de servicio
		 */
		registraCambioDeSimcardActionDTO.setCmbCiclo(cargosForm.getRbCiclo());
		boolean isFacturaACliclo=cargosForm!=null&&cargosForm.getRbCiclo().equalsIgnoreCase("NO")?false:true;
		logger.debug("RegistrarCambSimcCardAction:isFacturaACliclo:::"+isFacturaACliclo);
		logger.debug("cargosForm.getRbCiclo():["+cargosForm.getRbCiclo()+"]");
		
		if(!isFacturaACliclo){
			logger.debug("::Ingresa No factura a Ciclo::");
			PresupuestoForm presupuestoForm = new PresupuestoForm();
			if(session.getAttribute("PresupuestoForm")!=null){
				presupuestoForm = (PresupuestoForm)session.getAttribute("PresupuestoForm");
			
				logger.debug("Presupuesto:Numero Proceso:["+presupuestoForm.getNumProceso()+"]");
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
				try{
					PresupuestoDTO presup = new PresupuestoDTO();
					presup.setNumVenta(cargosForm.getNumVenta());
					presup.setNumProceso(presupuestoForm.getNumProceso());
					presup.setTipoFoliacion(tipoFoliacion);
					logger.debug("aceptarPresupuesto:antes");
					
					
				    //delegate.aceptarPresupuesto(presup);
					
					registraCambioDeSimcardActionDTO.setAceptarPresupuestoDTO(presup);
					
					logger.debug("aceptarPresupuesto:despues");
					session.removeAttribute("PresupuestoForm");
				}
				
				catch(Exception e){
					textoMensajeRestricciones="Error en la Aceptación del Presupuesto";
					delegate.guardaMensajesError(request, "Aceptación del Presupuesto", textoMensajeRestricciones);
					return mapping.findForward("error");
				}

				
				//return mapping.findForward(FACTURA);	
			}
		}
		
		/***********************************************************************************************************/
		
		
		
		
		
		
		
		
		
		SerieDTO serie = new SerieDTO();
    	serie.setNum_serie(formBeanCambioSimCard.getNroSerie());
    	serie.setCod_articulo(formBeanCambioSimCard.getCod_articulo());
    	MensajeRetornoDTO mensajeRetornoDTO=new MensajeRetornoDTO();
    	mensajeRetornoDTO.setNumMovimientoBloqDesb(formBeanCambioSimCard.getNumTransaccionBloqDes());
    	serie.setMensajeRetorno(mensajeRetornoDTO);
    	
    	
    	UsoArticuloDTO usoArticulo = new UsoArticuloDTO();
    	usoArticulo.setCod_uso(formBeanCambioSimCard.getUsoVenta());
    	
    	CuotaDTO cuota = new CuotaDTO();
    	cuota.setCod_cuota(formBeanCambioSimCard.getCuotas());

    	ModalidadPagoDTO modalidadPago = new ModalidadPagoDTO();
    	//modalidadPago.setCod_modventa(formBeanCambioSimCard.getModalidadPago());
    	modalidadPago.setCod_modventa(Long.parseLong(sessionData.getModalidad()));
    	

    	CausaCamSerieDTO causaCamSerie = new CausaCamSerieDTO();
    	causaCamSerie.setCod_caucaser(formBeanCambioSimCard.getCausaCambio());
    	
    
    	BodegaDTO bodega = new BodegaDTO();
    	bodega.setCod_bodega(String.valueOf(formBeanCambioSimCard.getCod_bodega()));
    	
    	causaCamSerie.setNumeroVenta(cargosForm.getNumVenta());
    	
    	// Efectuo la grabacion
    	/*delegate.registraCambioSimcard(	usuarioAbonado, 
    									serie, 
    									usoArticulo, 
    									cuota, 
    									sesionDTO, 
    									modalidadPago, 
    									bodega, 
    									global.getValor("ACT_SIMCARD"), //falta
    									global.getValor("MODULO"), //falta
    									causaCamSerie);*/
    	
    	registraCambioDeSimcardActionDTO.setUsuarioAbonadoDTO(usuarioAbonado);
    	registraCambioDeSimcardActionDTO.setSerieDTO(serie);
    	registraCambioDeSimcardActionDTO.setUsoArticuloDTO(usoArticulo);
    	registraCambioDeSimcardActionDTO.setCuotaDTO(cuota);
    	registraCambioDeSimcardActionDTO.setSesionDTO(sesionDTO);
    	registraCambioDeSimcardActionDTO.setModalidadPagoDTO(modalidadPago);
    	registraCambioDeSimcardActionDTO.setBodegaDTO(bodega);
    	registraCambioDeSimcardActionDTO.setCausaCamSerieDTO(causaCamSerie);
    	registraCambioDeSimcardActionDTO.setVendedorDTO(vendedor);
    	
		
    	
		//CargosForm cargosForm = (CargosForm)session.getAttribute("CargosForm");
		
		/***
		 * @author rlozano
		 * @description se mueve el codigo para registrar siempre la orden de servicio en este caso en la CI_ORDSERV.
		 *************************************************************************************************************/
		
//		se registra la orden de Servicio
		Calendar sysdate=Calendar.getInstance();;
		
		RegistrarOossEnLineaDTO registrarOossEnLineaDTO = new RegistrarOossEnLineaDTO();
		
		registrarOossEnLineaDTO.setNumOs(sessionData.getNumOrdenServicio());
		registrarOossEnLineaDTO.setCodOS(String.valueOf(10271));//String.valueOf(sessionData.getCodOrdenServicio()));
		//Codigo Inter se define numero de abonado, por la Orden de servicio va por abonado por lo cual se agrega valor a la tipinter=1
		registrarOossEnLineaDTO.setCodInter(usuarioAbonado.getNum_abonado());
		registrarOossEnLineaDTO.setTipInter(1);

		// Tomo el comentario de pantalla y lo guardo
		String comentario = new String();
		comentario = ((ResumenForm)session.getAttribute("ResumenForm")).getComentario();
		registrarOossEnLineaDTO.setComentario(comentario);
		// ------------------------------------------------------------------------
		
		registrarOossEnLineaDTO.setUsuario(sessionData.getUsuario());
		registrarOossEnLineaDTO.setFecha(sysdate.getTime());
		registrarOossEnLineaDTO.setCodModulo(global.getValor("codigo.modulo.GA"));
		registrarOossEnLineaDTO.setCodProducto(Integer.parseInt(global.getValor("codigo.producto")));
		registrarOossEnLineaDTO.setIndGestor(0);//analizar y verificar 
		
		
		
	    //			 Actualiza Renovación siempre y cuando halla sido invocada por la OOSS de Renovación ----
		// ini- p-mix-09003 ocb
		RegistrarRenovaDTO registrarRenovaDTO = new RegistrarRenovaDTO();
		
		registrarRenovaDTO.setNumOs(sessionData.getNumOrdenServicio());
		registrarRenovaDTO.setNumOsRenova(sessionData.getParamRenova());
		registrarRenovaDTO.setCodOS(global.getValor("codigo.orden.servicio.cambioserie"));
		registrarRenovaDTO.setNumAbonado(usuarioAbonado.getNum_abonado());
		registraCambioDeSimcardActionDTO.setRegistrarRenovaDTO(registrarRenovaDTO);
		// fin- p-mix-09003 ocb

		
		
		
		//RetornoDTO retValue =delegateFrmkOOSS.registrarOOSSEnLinea(registrarOossEnLineaDTO);
		//RetornoDTO retValue =delegate.registrarOOSSEnLinea(registrarOossEnLineaDTO);
		
		
		registraCambioDeSimcardActionDTO.setRegistrarOossEnLineaDTO(registrarOossEnLineaDTO);
		
		//157171
		logger.debug("Recupera carta de sesión, inicio");
		CartaGeneralDTO cartaGeneralDTO = (CartaGeneralDTO) session.getAttribute(CARTA_EN_SESION);
		logger.debug("Recupera carta de sesión, fin");
		
		registraCambioDeSimcardActionDTO.setCartaGeneralDTO(cartaGeneralDTO);
		 
		 //Registrar los Cargos
		 try{
		 RegCargosDTO retValConst=new RegCargosDTO();
			//retValConst=this.delegateFrmkOOSS.construirRegistroCargos(sessionData.getCargosObtenidos().getOcacionales());
		  logger.debug("construirRegistroCargos:antes");
		  retValConst=this.delegate.construirRegistroCargos(cargosForm.getCargosSeleccionados());
		  logger.debug("construirRegistroCargos:despues");
			CabeceraArchivoDTO objetoSesion=new CabeceraArchivoDTO();
			
			  int codPlanCom;
			usuarioAbonado = (UsuarioAbonadoDTO)session.getAttribute("usuarioAbonado");
			 ClienteDTO clienteTMP = new ClienteDTO();
			    clienteTMP.setCodCliente(usuarioAbonado.getCod_cliente());
			    //clienteTMP = delegateFrmkOOSS.obtenerPlanComercial(clienteTMP);
			    logger.debug("obtenerPlanComercial:antes");
			    clienteTMP = delegate.obtenerPlanComercial(clienteTMP);
			    logger.debug("obtenerPlanComercial:despues");
			    codPlanCom = clienteTMP.getCodPlanCom();
			objetoSesion.setPlanComercialCliente(String.valueOf(codPlanCom));
			objetoSesion.setCodigoCliente(String.valueOf(usuarioAbonado.getCod_cliente()));
			
			objetoSesion.setFacturaCiclo(isFacturaACliclo);
			objetoSesion.setNumeroVenta(0);
			objetoSesion.setNumeroTransaccionVenta(0);
			objetoSesion.setCodigoDocumento(cargosForm.getCbTipoDocumento());
			objetoSesion.setCodModalidadVenta(cargosForm.getCbModPago());
			
			
			UsuarioSistemaDTO usuarioSistema = (UsuarioSistemaDTO)session.getAttribute("usuarioSistema");
			//TODO : Obtener vendedor
			UsuarioDTO usuario = new UsuarioDTO();
	        usuario.setNombre(usuarioSistema.getNom_usuario());//NOMBRE DE USUARIO DE ORACLE (getNom_usuario es correcto??)
	        //usuario = delegateFrmkOOSS.obtenerVendedor(usuario);
	        logger.debug("obtenerVendedor:antes");
	        usuario = delegate.obtenerVendedor(usuario);
	        logger.debug("obtenerVendedor:despues");
			objetoSesion.setCodigoVendedor(String.valueOf(usuario.getCodigo()));
			
			
			
			retValConst.setObjetoSesion(objetoSesion);
			logger.debug("parametrosRegistrarCargos():Start");
			//ResultadoRegCargosDTO resultado = delegateFrmkOOSS.parametrosRegistrarCargos(retValConst);
			
				//ResultadoRegCargosDTO resultado = delegate.parametrosRegistrarCargos(retValConst);
				registraCambioDeSimcardActionDTO.setRegCargosDTO(retValConst);
				
				
				
				if (registraCambioDeSimcardActionDTO.getAceptarPresupuestoDTO() == null) {
					logger.debug("registraCambioDeSimcardActionDTO.getAceptarPresupuestoDTO() nulo");
				}
				else {
					logger.debug("registraCambioDeSimcardActionDTO.getAceptarPresupuestoDTO() no nulo");
				}
				logger.debug("registrarCambioSimcardAction:antes");
				delegate.registrarCambioSimcardAction(registraCambioDeSimcardActionDTO);
				logger.debug("registrarCambioSimcardAction:despues");
				
			}
			catch(Exception e){
				logger.debug("Exception", e);
				/**
				 * @author rlozano
				 * @description realizar rollback manual de presupuesto, cargos, venta
				 */
				
				String msgerror = e.getMessage();
				RetornoDTO retorno=new RetornoDTO();
				boolean isACiclo=cargosForm.getRbCiclo().trim().equals("NO")?true:false;
				if(formPresupuesto != null)
				{
					RegistroFacturacionDTO registro = new RegistroFacturacionDTO();
					registro.setNumeroProcesoFacturacion(String.valueOf(formPresupuesto.getNumProceso()));
					if (isACiclo){
						logger.debug("eliminarPresupuesto:antes");
						retorno=delegate.eliminarPresupuesto(registro);
						logger.debug("eliminarPresupuesto:despues");
						retorno.setDescripcion("Se eliminó el presupuesto Nº "+formPresupuesto.getNumProceso());
						msgerror+=" "+retorno.getDescripcion();
					}	
				}
				else{
					logger.debug("formPresupuesto=====null ");
				}
				
				textoMensajeRestricciones="Registrar Cambio Simcard";
				
				logger.debug("guardaMensajesError:antes");
				logger.debug("msgerror       "+msgerror);
				System.out.println("msgerror       "+msgerror);
				delegate.guardaMensajesError(request,textoMensajeRestricciones, msgerror);
				logger.debug("guardaMensajesError:despues");

				return mapping.findForward("error");
				
				
			}
			logger.debug("parametrosRegistrarCargos():end");
			
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
