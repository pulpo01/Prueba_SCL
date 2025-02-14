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

import sun.security.util.Debug;

import com.tmmas.cl.framework.util.BaseAction;
import com.tmmas.scl.framework.aplicationDomain.dto.UsuarioSistemaDTO;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DocumentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RegistrarOossEnLineaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RegistrarRenovaDTO; // ini-p-mix-09003 ocb
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CabeceraArchivoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CartaGeneralDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ParametrosCambioSerieDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegCargosDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PresupuestoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ResultadoRegCargosDTO;
import com.tmmas.scl.operation.crm.fab.cusintman.cambserie.common.dataTransferObject.RegistraCambioDeSerieActionDTO;
import com.tmmas.scl.operations.crm.fab.cusintman.web.delegate.CambioSerieBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cusintman.web.form.CambioDeSerieForm;
import com.tmmas.scl.operations.crm.fab.cusintman.web.form.CambioNumYSimForm;
import com.tmmas.scl.operations.frmkooss.web.delegate.FrmkOOSSBussinessDelegate;
import com.tmmas.scl.operations.frmkooss.web.dto.TablaCargosDTO;
import com.tmmas.scl.operations.frmkooss.web.form.CargosForm;
import com.tmmas.scl.operations.frmkooss.web.form.PresupuestoForm;
import com.tmmas.scl.operations.frmkooss.web.form.ResumenForm;
import com.tmmas.scl.operations.frmkooss.web.helper.Global;
import com.tmmas.scl.vendedor.dto.VendedorDTO;

import com.tmmas.scl.operations.crm.fab.customerinterfacemanagement.common.exception.CusIntManException; // RRG
import com.tmmas.cl.framework.exception.GeneralException; //FPP

public class RegistrarCambSeriAction extends BaseAction{
	private final Logger logger = Logger.getLogger(RegistrarCambSeriAction.class);
	private Global global = Global.getInstance();
	//private static final String SIGUIENTE = "factura";
	//private static final String PAGINA = "resumen";
	private static final String FIN = "fin";
	private FrmkOOSSBussinessDelegate delegateFrmkOOSS = FrmkOOSSBussinessDelegate.getInstance();
	private CambioSerieBussinessDelegate delegate = CambioSerieBussinessDelegate.getInstance();
	
	private static final String CARTA_EN_SESION = "_CARTA_EN_SESION_";

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
		
		RegistraCambioDeSerieActionDTO registraCambioDeSerieActionDTO=new RegistraCambioDeSerieActionDTO();
		
//		NEGOCIO OOSS
		UsuarioAbonadoDTO usuarioAbonado = new UsuarioAbonadoDTO();
		usuarioAbonado = (UsuarioAbonadoDTO)session.getAttribute("usuarioAbonado");

		CambioDeSerieForm cambioDeSerieForm = new CambioDeSerieForm(); 
		cambioDeSerieForm = (CambioDeSerieForm)session.getAttribute("CambioDeSerieForm");
		
		CambioNumYSimForm cambioNumYSimForm = new CambioNumYSimForm(); 
		cambioNumYSimForm = (CambioNumYSimForm)session.getAttribute("CambioNumYSimForm");

		//UsuarioSistemaDTO usuario = new UsuarioSistemaDTO();
		UsuarioSistemaDTO usuario = (UsuarioSistemaDTO)session.getAttribute("usuarioSistema");

		VendedorDTO vendedor = (VendedorDTO)session.getAttribute("Vendedor");
		
		/**
    	 * @author rlozano
    	 * @description llenamos el vendedor en caso este null;
    	 */
    	
    	if (session.getAttribute("Vendedor") == null&&session.getAttribute("oossComisionable").toString().equals("SI")){
    		vendedor=new VendedorDTO();
    		vendedor.setCod_vendedor(String.valueOf(usuario.getCod_vendedor()));
    		vendedor.setNom_vendedor(usuario.getNom_usuario());
    		vendedor.setCod_os(String.valueOf(sessionData.getCodOrdenServicio()));
    		vendedor.setNumOOSS(String.valueOf(sessionData.getNumOrdenServicio()));
    		vendedor.setFecha(new Date());
    		vendedor.setCod_tipcomis(usuario.getCod_tipcomis());
    		vendedor.setInd_interno(true);
    		vendedor.setUsuario(usuario.getNom_usuario());
    		vendedor.setCod_oficina(usuario.getCod_oficina());
    		session.setAttribute("Vendedor", vendedor);
    	}
		
		
		// -----------------------------------------------------------------------------------------------------------------------
		
		String tecnoActual = null;
		String tecnoNueva = null;
		String nroSimcard = null;
		
		tecnoActual = usuarioAbonado.getCod_tecnologia();
		tecnoNueva = cambioDeSerieForm.getTecnologia();
		tecnoNueva=tecnoNueva==null||"".equals(tecnoNueva)?"GSM":tecnoNueva;
//		tecnoNueva=tecnoNueva==null?"":tecnoNueva; //RRG 23-09-2008 70904

		/*
		 * 		-	Si no hay cambio de tecnología no se envía la serie (entiéndase por tecnología: GSM, CDMA, etc.)
		 * 		-	Si hay cambio de tecnología se debe enviar la serie siempre y cuando se esté pasando de un CDMA a un GSM
		*/
		
		if (!tecnoActual.equals(tecnoNueva) && tecnoActual.equals("CDMA") && tecnoNueva.equals("GSM")) 
			nroSimcard = cambioDeSerieForm.getNroSerieSim();
		
		// Número de operación de Salida
		String indOperacion = null;
		
		// Efectuo la grabacion de la OOSS		
		//indOperacion = delegate.registraCambioDeSerie(usuario, cambioDeSerieForm.getNroSerieEquip(), nroSimcard, usuarioAbonado);
    	session.setAttribute("indOperacion", indOperacion);
    	
		// ------------------------------------------------------------------------------------------------------------------------
		
		CargosForm cargosForm = (CargosForm)session.getAttribute("CargosForm");
		
		registraCambioDeSerieActionDTO.setCmbCiclo(cargosForm.getRbCiclo());
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
				registraCambioDeSerieActionDTO.setPresupuestoDTO(presup);
				//delegateFrmkOOSS.aceptarPresupuesto(presup);
				logger.debug("aceptarPresupuesto:despues");
				session.removeAttribute("PresupuestoForm");
					
			}
		}//fin rbCiclo = NO
		/*------------------Fin Aceptar presupuesto-----------------*/
		 
		 //Registrar los Cargos
		 RegCargosDTO retValConst=new RegCargosDTO();
		
		 boolean seRegistroCargosInmediatos = false;
		 if(session.getAttribute("seRegistroCargosInmediatos") != null && 
					"SI".equals(session.getAttribute("seRegistroCargosInmediatos")))
		 {
			 seRegistroCargosInmediatos = true;
		 }
		 logger.debug("seRegistroCargosInmediatos["+seRegistroCargosInmediatos+"]");
		 CabeceraArchivoDTO objetoSesion=new CabeceraArchivoDTO();
		 //Sino se han registrado los cargos a través del presupuesto, se registran ahora
		 if(!seRegistroCargosInmediatos)
		 {
			 //original
			 //retValConst=this.delegateFrmkOOSS.construirRegistroCargos(sessionData.getCargosObtenidos().getOcacionales());
			 logger.debug("construirRegistroCargos:antes");
			 retValConst=this.delegateFrmkOOSS.construirRegistroCargos(sessionData.getCargosObtenidos().getOcacionales());
			 if(retValConst!=null && retValConst.getCargos()!=null && retValConst.getCargos().length>0)
			 {
				 logger.debug("Aciclo construirRegistroCargos, numero de cargos construidos["+retValConst.getCargos().length+"]");
			 }else{
				 logger.debug("Aciclo construirRegistroCargos, no hay cargos construidos");
			 }
			 logger.debug("construirRegistroCargos:despues");
		 }
		//original 
		//objetoSesion.setPlanComercialCliente(sessionData.getAbonados()[0].getCodPlanTarif());
		//Se debe invocar un método que obtenga el plan comercial de cliente
		ClienteDTO clienteTMP = new ClienteDTO();
	    clienteTMP.setCodCliente(usuarioAbonado.getCod_cliente());
	    clienteTMP = delegate.obtenerPlanComercial(clienteTMP);
	    
		objetoSesion.setPlanComercialCliente(""+clienteTMP.getCodPlanCom());
		objetoSesion.setCodigoCliente(String.valueOf(usuarioAbonado.getCod_cliente()));
		
		objetoSesion.setFacturaCiclo(true);
		if(cargosForm!=null && cargosForm.getRbCiclo().equalsIgnoreCase("NO")){
			objetoSesion.setFacturaCiclo(false);
		}
		
		objetoSesion.setNumeroVenta(0);
		objetoSesion.setNumeroTransaccionVenta(0);
		objetoSesion.setCodigoDocumento(cargosForm.getCbTipoDocumento());
		objetoSesion.setCodModalidadVenta(cargosForm.getCbModPago());
		objetoSesion.setCodigoVendedor(vendedor.getCod_vendedor());
		retValConst.setObjetoSesion(objetoSesion);
		
		if(!seRegistroCargosInmediatos)	{
		//original al 10092009:
		//ResultadoRegCargosDTO resultado = delegateFrmkOOSS.parametrosRegistrarCargos(retValConst);
			if(retValConst!=null && retValConst.getCargos()!=null && retValConst.getCargos().length>0) {
				logger.debug("Saldo total: "+retValConst.getCargos()[0].getSaldoTotal());
				logger.debug("Saldo unitario: "+retValConst.getCargos()[0].getSaldoUnitario());
				if(retValConst.getCargos().length==1) {
					logger.debug("Saldo total: "+retValConst.getCargos()[0].getSaldoTotal());
					logger.debug("Saldo unitario: "+retValConst.getCargos()[0].getSaldoUnitario());
					if (retValConst.getCargos()[0].getSaldoUnitario()>0 && retValConst.getCargos()[0].getSaldoTotal()>0) {
						logger.debug("Aciclo parametrosRegistrarCargos:antes");
						ResultadoRegCargosDTO resultado = delegateFrmkOOSS.parametrosRegistrarCargos(retValConst);
						logger.debug("Aciclo parametrosRegistrarCargos:despues");
					}
				 } else if(retValConst.getCargos().length>1) { 
					logger.debug("Aciclo parametrosRegistrarCargos:antes");
					ResultadoRegCargosDTO resultado = delegateFrmkOOSS.parametrosRegistrarCargos(retValConst);
					logger.debug("Aciclo parametrosRegistrarCargos:despues");
				 } 		
			}
		}

		registraCambioDeSerieActionDTO.setRegCargosDTO(retValConst);
		
		//TODO : parametros ---> Registro orden de servicio
		
		Calendar sysdate=Calendar.getInstance();
		
		RegistrarOossEnLineaDTO registrarOossEnLineaDTO = new RegistrarOossEnLineaDTO();
		
		registrarOossEnLineaDTO.setNumOs(sessionData.getNumOrdenServicio());
		registrarOossEnLineaDTO.setCodOS(global.getValor("codigo.orden.servicio.cambioserie"));//String.valueOf(sessionData.getCodOrdenServicio()));
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
		registraCambioDeSerieActionDTO.setRegistrarRenovaDTO(registrarRenovaDTO);
		// fin- p-mix-09003 ocb

		
		
		
		
		
		registraCambioDeSerieActionDTO.setCodTecnAnt(sessionData.getAbonados()[0].getCodTecnologia()); //RRG 23-09-2008 70904
		
		//RetornoDTO retValue =delegateFrmkOOSS.registrarOOSSEnLinea(registrarOossEnLineaDTO);
		//RetornoDTO retValue =delegate.registrarOOSSEnLinea(registrarOossEnLineaDTO);
		
		
		registraCambioDeSerieActionDTO.setRegistrarOossEnLineaDTO(registrarOossEnLineaDTO);
		String montoTerminal=(String)session.getAttribute("montoTerminal");
		montoTerminal=montoTerminal==null||montoTerminal==""?"0.0":montoTerminal;
		logger.debug("Valor del Terminal : "+montoTerminal);
		//TODO : parametros para el cambio de serie
		ParametrosCambioSerieDTO parametros =new ParametrosCambioSerieDTO();
		parametros.setNumCelular(usuarioAbonado.getNum_celular());
		parametros.setNumSerieEquipo(cambioDeSerieForm.getNroSerieEquip());
		parametros.setNumSerieSimcard(cambioDeSerieForm.getNroSerieSim());
		
		parametros.setCodVendedor(usuario.getCod_vendedor());
		parametros.setNomUsuario(sessionData.getUsuario());
		parametros.setCodCentral(cambioDeSerieForm.getCentral());
		parametros.setImpCargo(Float.parseFloat(montoTerminal));
		String codTipContrato= cambioDeSerieForm.getTipoContrato();
		codTipContrato=codTipContrato==null||"".equals(codTipContrato)?"0":codTipContrato.trim();
		parametros.setCodTipContrato(Long.parseLong(codTipContrato));
		parametros.setNumContrato(usuarioAbonado.getNumContrato());
		parametros.setNumAnexo(usuarioAbonado.getNumAnexo());
		parametros.setCodCausa(cambioDeSerieForm.getCausaCambio());
		parametros.setNumTransBloqEquipo(cambioDeSerieForm.getNumTransBloqDesEquipo());
		parametros.setNumTransBloqSerie(cambioDeSerieForm.getNumTransBloqDesSerie());
		parametros.setFlagBloqueoEquipoEx(cambioDeSerieForm.getFlagBloqueoEquipoEx());
		parametros.setCodArticulo(cambioDeSerieForm.getCodArticuloTerminal());
		parametros.setUsoVentaEquip(cambioDeSerieForm.getUsoVentaEquip());
		parametros.setDescrEquipoEx(cambioDeSerieForm.getDescripcionEquipo());
		TablaCargosDTO[]tablaCargosDTO=(TablaCargosDTO[])session.getAttribute("listCarogos");
		String codigoTerminal=(String)session.getAttribute("codigoTerminal");
		codigoTerminal=codigoTerminal==null?"":codigoTerminal;
		String codigoSimcard=(String)session.getAttribute("codigoSimcard");
		codigoSimcard=codigoSimcard==null?"":codigoSimcard;
		
		if (tablaCargosDTO!=null){
			String codConcepto=null;
			
			
			for ( int i=0;i<tablaCargosDTO.length;i++){
				codConcepto=tablaCargosDTO[i].getCodConcepto();
				codConcepto=codConcepto==null?"":codConcepto;
				
				if (codConcepto.equals(codigoSimcard)){
					
					parametros.setMntoSimcard(tablaCargosDTO[i].getImporteCargo());
				}
				if (codConcepto.equals(codigoTerminal)){

					if (tablaCargosDTO[i].getTipoDescuentoManual()!=null && tablaCargosDTO[i].getTipoDescuentoManual().equals("0") && !tablaCargosDTO[i].getDescuentoUnitarioMan().equals("")) {
						parametros.setTipoDescuento(tablaCargosDTO[i].getTipoDescuentoManual());
						parametros.setDescuentoUnitario(tablaCargosDTO[i].getDescuentoUnitarioMan());
						logger.debug("Tipo Descuento Manual: "+parametros.getTipoDescuento());
						logger.debug("Descuento Unitario Manual: "+parametros.getDescuentoUnitario());						
					} else if(tablaCargosDTO[i].getTipoDescuentoAut()!=null && tablaCargosDTO[i].getTipoDescuentoAut().equals("1") && !tablaCargosDTO[i].getDescuentoUnitarioAut().equals("")){
						parametros.setTipoDescuento(tablaCargosDTO[i].getTipoDescuentoAut());
						parametros.setDescuentoUnitario(tablaCargosDTO[i].getDescuentoUnitarioAut());
						logger.debug("Tipo Descuento Automatico: "+parametros.getTipoDescuento());
						logger.debug("Descuento Unitario Automatico: "+parametros.getDescuentoUnitario());												
					} else {
						logger.debug("No hay tipo de descuento ");
						logger.debug("No hay descuento ");
					}
					
					logger.debug(" Terminal dato importe total seteo (precio de venta): "+tablaCargosDTO[i].getImporteTotal());
					parametros.setMntoTerminal(tablaCargosDTO[i].getImporteTotal());
					String saldo = tablaCargosDTO[i].getSaldo();
					logger.debug("Monto Terminal con descuento: "+saldo);					
					saldo = saldo.replaceAll(",", "");
					logger.debug("Monto Terminal con descuento(sin ,): "+saldo);
					parametros.setImpCargo(Float.parseFloat(saldo));
				}
				codConcepto=null;
				
			}
		}
		
		
		
		registraCambioDeSerieActionDTO.setParametrosCambioSerieDTO(parametros);
		registraCambioDeSerieActionDTO.setVendedorDTO(vendedor);
		boolean buscaSocketPS="2".equals(usuarioAbonado.getCod_tiplan())?false:true; //RRG 23-09-2008 70904
		
		//(+) EV 13/07/2010, valida parametro para consulta de saldo
		if (buscaSocketPS){
			ParametroDTO paramGral=new ParametroDTO();
			paramGral.setCodModulo(global.getValor("codigo.modulo.GA"));
			paramGral.setCodProducto(Integer.parseInt(global.getValor("codigo.producto")));
			paramGral.setNomParametro(global.getValor("parametro.cons_saldo_prepago"));
			paramGral=delegate.obtenerParametroGeneral(paramGral);
			logger.debug("CONS_SALDO_PREPAGO="+paramGral.getValor());
			
			buscaSocketPS =(paramGral.getValor().equalsIgnoreCase("S"))?true:false;
		}
		//(-) EV 13/07/2010
		
		logger.debug("usuarioAbonado.getCod_tiplan():" + usuarioAbonado.getCod_tiplan());  // RRG
		logger.debug("buscaSocketPS:" + buscaSocketPS);									   // RRG	

		registraCambioDeSerieActionDTO.setBuscaSocketPS(buscaSocketPS); //RRG 23-09-2008 70904
		
		/**
		 * @author JIB
		 * 
		 * Incidencia 155633
		 */
		logger.debug("Recupera carta de sesión, inicio");
		CartaGeneralDTO cartaGeneralDTO = (CartaGeneralDTO) session.getAttribute(CARTA_EN_SESION);
		logger.debug("Recupera carta de sesión, fin");
		
		
		registraCambioDeSerieActionDTO.setCartaGeneralDTO(cartaGeneralDTO);
		

        // INICIO RRR 15-04-2009 COL 86243

		// delegate.registraCambioSerieAction(registraCambioDeSerieActionDTO);	 
		try {
			logger.debug("getNumOs [" + registraCambioDeSerieActionDTO.getRegistrarOossEnLineaDTO().getNumOs() + "]");
			delegate.registraCambioSerieAction(registraCambioDeSerieActionDTO);	 
		}
		/*catch (CusIntManException e )
		{
			logger.debug("e.getMessage():" + e.getMessage() ); // RRG
			logger.debug("e.getCause():" + e.getCause() );		// RRG
			logger.debug("e.getCodigo():" + e.getCodigo() );	// RRG
			logger.debug("e.getCodigoEvento():" + e.getCodigoEvento() ); // RRG
			logger.debug("e.getDescripcionEvento():" + e.getDescripcionEvento() ); // RRG

			throw new CusIntManException("Tiempo de Espera Agotado al Ejecutar el registro del Cambio de Serie, Consulte Administrador",e.getCause() , e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		*/
		catch (GeneralException e){
			logger.debug("GeneralException:INI" ); // FPP
			logger.debug("e.getMessage():" + e.getMessage() ); // RRG
			logger.debug("e.getCause():" + e.getCause() );		// RRG
			logger.debug("e.getCodigo():" + e.getCodigo());
			logger.debug("e.getDescripcionEvento() :" + e.getDescripcionEvento());
			logger.debug("e.getCodigoEvento():" + e.getCodigoEvento());

    	//String mens = e.getMessage();							 // RRG
			
			String mens = e.getDescripcionEvento();
			String stack = "Codigo:" + e.getCodigo() + " Evento:" + e.getCodigoEvento(); // RRG
			if (e.getCodigo() == null){
				stack = e.getMessage() + " -->" + e.getCause(); // FPP
			}
			//String stack = "Codigo:" + e.getCodigo() + " Evento:" + e.getCodigoEvento(); // FPP
		delegate.guardaMensajesError(request, mens, stack);		 // RRG
		logger.debug("GeneralException:END" ); // FPP
		return mapping.findForward("error");					 // RRG				
		}catch (Exception e) {
			logger.debug("Exception:INI" ); // FPP
			logger.debug("e.getMessage():" + e.getMessage() ); // RRG
			logger.debug("e.getCause():" + e.getCause() );		// RRG
			/*logger.debug("e.getCodigo():" + e.getCodigo());
			logger.debug("e.getDescripcionEvento() :" + e.getDescripcionEvento());
			logger.debug("e.getCodigoEvento():" + e.getCodigoEvento());

    	//String mens = e.getMessage();							 // RRG
			*/
			
			String mens = e.getMessage();
			String stack = ""; // RRG
		delegate.guardaMensajesError(request, mens, stack);		 // RRG
		logger.debug("Exception:END" ); // FPP
		return mapping.findForward("error");					 // RRG

			//throw new CusIntManException(e);
		}
		//  RRR 15-04-2009 COL 86243
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
