package com.tmmas.scl.operations.crm.fab.cim.manreq.web.action;

import java.util.ArrayList;
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
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.LstPTaPlanTarifarioListOutDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.SalidaOutDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.CargosDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.DocumentoDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.RegistroCargosDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.AbonadoSecuenciaDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.DetEstadoProcesoOSSDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.EstadoProcesoOOSSDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.NumeroFrecuenteDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ObtencionSecuenciasDTO;
import com.tmmas.scl.framework.productDomain.productABE.interfaz.TipoDescuentos;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.PresupuestoDTO;
import com.tmmas.scl.operations.crm.f.oh.clocusord.common.exception.CloCusOrdException;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.CargosObtenidosDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.ParamRegistroOrdenServicioDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.RegistroPlanDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.exception.IssCusOrdException;
import com.tmmas.scl.operations.crm.fab.cim.manreq.businessObject.bo.XMLDefault;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.AbonadoNumerosFrecuentesDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.DefaultPaginaCPUDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.NumeroFrecuenteTipoListDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.SeccionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.TablaCargosDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.exception.ManReqException;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate.ManageRequestBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.CambiarPlanForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.CargosForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.PresupuestoForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.ResumenForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.Global;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.VendedorComisionable;
import com.tmmas.scl.vendedor.dto.UsuarioVendedorDTO;
import com.tmmas.scl.vendedor.dto.VendedorDTO;
import com.tmmas.scl.vendedor.dto.UsuarioSistemaDTO; // INC-71897; AVC; 20-10-2008
 
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RegistroColaDTO; // RRG

public class RegistrarAction extends BaseAction {
	private final Logger logger = Logger.getLogger(RegistrarAction.class);
	private Global global = Global.getInstance();
	private static final String SIGUIENTE = "factura";
	//private static final String ANTERIOR = "controlNavegacion";
	//private static String PAGINA = "resultado";// "resumen";

	private ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();

	public ActionForward executeAction(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	throws Exception {
		String PAGINA = "resultado";// "resumen";
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);
		logger.debug("execute():start");

		ParamRegistroOrdenServicioDTO paramOservicio = new ParamRegistroOrdenServicioDTO();
		RegistroPlanDTO registroPlan=new RegistroPlanDTO();
		HttpSession session = request.getSession(false);
		CambiarPlanForm cambiarPlanForm = (CambiarPlanForm)session.getAttribute("CambiarPlanForm");
		registroPlan=(RegistroPlanDTO)session.getAttribute("registroPlan");		
		ClienteOSSesionDTO sessionData = new ClienteOSSesionDTO();
		sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");		
		CargosObtenidosDTO cargosRegistro;
		cargosRegistro = sessionData.getCargosObtenidos();
		paramOservicio.setRegistroPlan(registroPlan);
		paramOservicio.setNomUsuaOra(registroPlan.getParamRegistroPlan().getNomUsuaOra());//010708
		logger.debug("RegistrarAction.ParamRegistroOrdenServicioDTO: paramOservicio.getNomUsuaOra() "+paramOservicio.getNomUsuaOra());
		ResumenForm resumenForm = (ResumenForm)form;
		
				
		logger.debug("resumenForm.getComentario():"+resumenForm.getComentario()); // RRG




		registroPlan.getParamRegistroPlan().setComentario(resumenForm.getComentario());
			
		
		//Se obtiene de la sesion el objeto con la lista de numeros frecuentes
		ArrayList numerosFrecuentesTipoListDTO = null;		
		if (session.getAttribute("abonadoNumerosFrecuentesListDTO")!=null){
			numerosFrecuentesTipoListDTO = (ArrayList)session.getAttribute("abonadoNumerosFrecuentesListDTO");
		}			 	
			
		if (numerosFrecuentesTipoListDTO!=null){
			ArrayList cont = new ArrayList();
			for(int n = 0; n < numerosFrecuentesTipoListDTO.size(); n++){
				NumeroFrecuenteTipoListDTO numeroFrecuenteTipoListDTO = (NumeroFrecuenteTipoListDTO)numerosFrecuentesTipoListDTO.get(n);			
				com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.NumeroFrecuenteDTO[] numFrecuentesIngresadosList = numeroFrecuenteTipoListDTO.getNumFrecuentesIngresadosList();
				NumeroFrecuenteDTO numFDTO = null;
							
				for (int k = 0; k < numFrecuentesIngresadosList.length; k++) {
					numFDTO = new NumeroFrecuenteDTO();
					if(numFrecuentesIngresadosList[k].getCodTipo().equals("ONN")||numFrecuentesIngresadosList[k].getTipo().equals("MOVILES")){
						numFDTO.setTipoNumeroFrecuente("M");	
					} else {
						numFDTO.setTipoNumeroFrecuente("F");
					}					
					numFDTO.setNumeroFrecuente(numFrecuentesIngresadosList[k].getNumero());				
					cont.add(numFDTO);				
				}
			}
			NumeroFrecuenteDTO[] arrNumerosFrecuentesDTO = new NumeroFrecuenteDTO[cont.size()];
			for (int y = 0; y <cont.size();y++) {
				arrNumerosFrecuentesDTO[y]= (NumeroFrecuenteDTO)cont.get(y);
			}
	
			registroPlan.getParamRegistroPlan().setArrNumerosFrecuentesDTO(arrNumerosFrecuentesDTO);
			logger.debug("SE ASIGNO A ParamRegistroPlan EL ARREGLO DE NumeroFrecuenteDTO[] SIZE: "+arrNumerosFrecuentesDTO.length);
		}
		
		session.setAttribute("desde","registrar");
		
		logger.debug("Sujeto                 : "+ registroPlan.getParamRegistroPlan().getSujeto());
		logger.debug("CodSujeto              : "+ registroPlan.getParamRegistroPlan().getCodSujeto());
		logger.debug("combinatoria           : "+ registroPlan.getParamRegistroPlan().getCombinatoria());
		logger.debug("codTipModi             : "+ registroPlan.getParamRegistroPlan().getCodTipModi());
		logger.debug("codOOSS                : "+ registroPlan.getParamRegistroPlan().getCodOOSS());
		logger.debug("tipOOSS                : "+ registroPlan.getParamRegistroPlan().getTipOOSS());
		logger.debug("codPlanTarifarioDestino: "+ registroPlan.getParamRegistroPlan().getCodPlanTarifDestino());
		logger.debug("nomUsuaOra             : "+ registroPlan.getParamRegistroPlan().getNomUsuaOra());
		logger.debug("numOOSS                : "+ registroPlan.getParamRegistroPlan().getNumOOSS());
		logger.debug("aplicaTraspado         : "+ registroPlan.getParamRegistroPlan().getAplicaTraspaso());
		logger.debug("codActAbo              : "+ registroPlan.getParamRegistroPlan().getCodActAbo());
		logger.debug("codPlanServNuevo       : "+ registroPlan.getParamRegistroPlan().getCodPlanServNuevo());
		logger.debug("Comentario			 : "+ registroPlan.getParamRegistroPlan().getComentario());

		logger.debug("Fecha Programacion	 : "+ registroPlan.getParamRegistroPlan().getFechaProgramacion() ); // RRG

//		getFechaProgramacion
		
		if (numerosFrecuentesTipoListDTO!=null){
			NumeroFrecuenteDTO[] arrNumDTO = registroPlan.getParamRegistroPlan().getArrNumerosFrecuentesDTO();
			for(int n = 0; n < arrNumDTO.length; n++){
				logger.debug("Numero Frecuente: "+arrNumDTO[n].getNumeroFrecuente()+ "Tipo: "+ arrNumDTO[n].getTipoNumeroFrecuente());
			}
		}
		
		session.setAttribute("anbonadoNumFrecDTO", null);
		session.setAttribute("abonadoNumerosFrecuentesListDTO", null);
		
		// Encolar el objeto
		sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");    

		//registroPlan.getParamRegistroPlan().setComentario(null);
		paramOservicio.setRegistroPlan(registroPlan);

		
		XMLDefault objetoXML    = new XMLDefault();
		DefaultPaginaCPUDTO objetoXMLSession = new DefaultPaginaCPUDTO();
		SeccionDTO seccion=new SeccionDTO();
		objetoXMLSession = sessionData.getDefaultPagina();
		seccion = objetoXML.obtenerSeccion(objetoXMLSession, "cargosPAG", "CondicionesComercialesSS");
		
		

		
		CargosForm cargosForm = (CargosForm)session.getAttribute("CargosForm");
		registroPlan.getParamRegistroPlan().setCodTipoDocumento(seccion.obtControl("TipoDocumentoCB").getValorDefecto());
		registroPlan.getParamRegistroPlan().setModPago(sessionData.getModalidad());
		logger.debug("Modalidad			: "+ sessionData.getModalidad());
		if( (cargosForm!=null&&cargosForm.getRbCiclo().equals("NO")) || (cargosForm==null) ){
			paramOservicio.setRegistroCargos(null);
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
				paramOservicio.setRegistroCargos(null);
			}
			paramOservicio.setRegistroCargos(cargosRegistro);
		}
		
		AbonadoDTO[] lista = null;
	    if (session.getAttribute("AbonadosSeleccionados")!= null){
	    	lista = (AbonadoDTO[])session.getAttribute("AbonadosSeleccionados");
	    	paramOservicio.getRegistroPlan().getParamRegistroPlan().setAbonadosSel(lista);
	    	
	    	logger.debug("-------------Abonados a procesar------------");
	    	for(int i=0; i< lista.length; i++){
	    		logger.debug("NumAbonado="+lista[i].getNumAbonado());
	    	}
	    	logger.debug("--------------------------------------------");
	    }

	    String combinatoria = registroPlan.getParamRegistroPlan().getCombinatoria();
		boolean esPrepagoPrepago = false;
		if (combinatoria.equalsIgnoreCase("PREPAGOPREPAGO")) { 
			//obtener y calcular informacion de cargos para origen prepago

			esPrepagoPrepago  = true;
			CargosDTO[] cargos = paramOservicio.getRegistroCargos()==null?null:paramOservicio.getRegistroCargos().getOcacionales()==null?null:paramOservicio.getRegistroCargos().getOcacionales().getCargos();
			
			if (cargos==null || cargos.length == 0)
				logger.debug("NO HAY CARGOS PREPAGO");
			
			//por cada abonado obtener sus cargos y calcular monto
			for(int j = 0; j<(lista==null?0:lista.length);j++){
				AbonadoDTO abonado =(AbonadoDTO)lista[j];
				float valorOOSSxAbonado = 0;
				
				for(int i = 0; i<(cargos==null?0:cargos.length);i++){
					 if (abonado.getNumAbonado() == Long.parseLong(cargos[i].getAtributo().getNumAbonado())){ //acumular
						 float impCargo = cargos[i].getPrecio().getMonto(); 
						 //int numUnidades = cargos[i].getCantidad();
						 float valorDscto = 0;
						 float valorOOSSxCargo = 0;
						 
						 DescuentoDTO[] descuentos = cargos[i].getDescuento();
						 for (int k=0; k< (descuentos==null?0:cargos[i].getDescuento().length);k++){
							 float monto = descuentos[k].getMonto();
							 float montoCalculado = descuentos[k].getMontoCalculado();
							 
							 if(descuentos[k].getTipoAplicacion().equals(String.valueOf(TipoDescuentos.Porcentaje)) 
										&& descuentos[k].getMonto() > 0){
								valorDscto = valorDscto +((impCargo * descuentos[k].getMonto()) /100);
							 }else{
								valorDscto = valorDscto + monto;
							 }
							 logger.debug("descuento "+k);
							 logger.debug("monto ="+monto);
							 logger.debug("montoCalculado="+montoCalculado);
							 logger.debug("valor descuento="+valorDscto);
						 }//fin ciclo descuentos por cargo
						 
						 valorOOSSxCargo   = (impCargo * 1) - valorDscto;
						 valorOOSSxAbonado = valorOOSSxAbonado + valorOOSSxCargo; 
						 
						 logger.debug("impCargo="+impCargo);
						 logger.debug("valorOOSSxCargo="+valorOOSSxCargo);
						 logger.debug("valorOOSSxAbonado="+valorOOSSxAbonado);
					 }//fin if
				}//fin ciclo de cargos
				
				abonado.setValorOOSS(valorOOSSxAbonado);
				
			}//fin ciclo de abonados
				
		}//fin if (combinatoria.equalsIgnoreCase("PREPAGOPREPAGO"))

		paramOservicio.getRegistroPlan().getParamRegistroPlan().setComentario(((ResumenForm)form).getComentario());
		
		if(cambiarPlanForm!=null&&cambiarPlanForm.getListaAbonados()!=null&&cambiarPlanForm.getListaAbonados().length>0){
			paramOservicio.getRegistroPlan().getParamRegistroPlan().setNumAbonados(cambiarPlanForm.getListaAbonados());
		}
		
		String OOSSEmpresa = global.getValor("EMPRESA");
		
		EstadoProcesoOOSSDTO estado=new EstadoProcesoOOSSDTO();
		estado.setCodOOSS(String.valueOf(paramOservicio.getRegistroPlan().getParamRegistroPlan().getTipOOSS()));
		estado.setNumProceso(0); // indica que debe INSCRIBIR la OOSS
		estado.setFechaActualizacion(new Date());
		logger.debug("estado.getCodOOSS()[" + estado.getCodOOSS() + "]");
		logger.debug("estado.getNumProceso()[" + estado.getNumProceso() + "]");
		logger.debug("estado.getFechaActualizacion()[" + estado.getFechaActualizacion() + "]");

		DetEstadoProcesoOSSDTO[] listaDetalles = null;
		
		if (sessionData.getCliente().getCodTipoPlanTarif().equals("E") && (registroPlan.getParamRegistroPlan().getTipOOSS().equals(OOSSEmpresa))){
			logger.debug("Cliente Empresa");
			
			AbonadoSecuenciaDTO[] abonadosSecuencias = paramOservicio.getRegistroPlan().getParamRegistroPlan().getAbonadosEmpresa(); 
			
			listaDetalles = new DetEstadoProcesoOSSDTO[paramOservicio.getRegistroPlan().getParamRegistroPlan().getAbonadosEmpresa().length];


			for(int i=0; i<abonadosSecuencias.length; i++){
				DetEstadoProcesoOSSDTO detalle=new DetEstadoProcesoOSSDTO();
				detalle.setNumAbonado(abonadosSecuencias[i].getNumAbonado());
				detalle.setNumOOSS(abonadosSecuencias[i].getNumOOSS());
				detalle.setCodCliente( paramOservicio.getRegistroPlan().getCliente().getCodCliente() );
				logger.debug("detalle.getNumAbonado()[" + detalle.getNumAbonado() + "]");
				logger.debug("detalle.getNumOOSS()[" + detalle.getNumOOSS() + "]");
				logger.debug("detalle.getCodCliente()[" + detalle.getCodCliente() + "]");
				listaDetalles[i]=detalle;
				// INICIO RRG 18-02-2008 77303 -DATO PARA RESPALDO DE MENSAJE ANTES DE ENCOLAR
					logger.debug("INICIO RESPALDO ORDEN DE SERVICIO");
					RegistroColaDTO param = new RegistroColaDTO();
					param.setCodModulo("PV");
					param.setNumOOSS(   Long.toString( detalle.getNumOOSS())  );// debe ser numero
					param.setCodTipModi(registroPlan.getParamRegistroPlan().getCodTipModi());
					param.setCodOS(   Long.toString(registroPlan.getParamRegistroPlan().getCodOOSS()) );		
					param.setCodCliente(  Long.toString(paramOservicio.getRegistroPlan().getCliente().getCodCliente()) );
					param.setCodClienteDestino(  Long.toString(registroPlan.getParamRegistroPlan().getCodClienteDestino()) );

					param.setNumAbonado(   Long.toString(detalle.getNumAbonado()) ); // RRG
					//param.setCodCuenta("CUENTA");
					param.setCodCuentaDestino( Long.toString(registroPlan.getParamRegistroPlan().getCodCuentaDestino())); 
					//param.setCodCiclo("CodCiclo");
					param.setCodPlanTarif( registroPlan.getParamRegistroPlan().getCodPlanTarifario() ); 

					param.setCodPlanTarifDestino(registroPlan.getParamRegistroPlan().getCodPlanTarifDestino());

					//param.setCodUso( paramOservicio.getRegistroPlan().getParamRegistroPlan().getAbonadosSel()[i].getCodUso() );
					//param.setCodUsoDestino(paramOservicio.getRegistroPlan().getParamRegistroPlan().getAbonadosSel()[i].getCodUsoDestino() );

					param.setCodActabo(registroPlan.getParamRegistroPlan().getCodActAbo()); 
					//param.setCodVendedor("CodVendedor");
					param.setAplicaTraspaso(registroPlan.getParamRegistroPlan().getAplicaTraspaso());
					//param.setFecDesdeLlam("FecDesdeLlam");				


					//param.setFechaProgramacion(estado.getFechaActualizacion().toString() );  //  SIRVE CALETA!!!

					if (registroPlan.getParamRegistroPlan().getFechaProgramacion()!=null)
					{
							param.setFechaProgramacion(registroPlan.getParamRegistroPlan().getFechaProgramacion().toString()); // RRG 77303 09-03-2009 col
					} else {
							param.setFechaProgramacion(estado.getFechaActualizacion().toString() );  //  SIRVE CALETA!!!
					}

					

					param.setCodUsuario(registroPlan.getParamRegistroPlan().getNomUsuaOra());

					param.setComentario(registroPlan.getParamRegistroPlan().getComentario());

					param.setValorAuxiliar(registroPlan.getParamRegistroPlan().getAplicaTraspaso());

					delegate.insertaTablaCola(param);
					logger.debug("FIN RESPALDO ORDEN DE SERVICIO");

		// FIN RRG 18-02-2008 77303 
			}
			
			paramOservicio.getRegistroPlan().getParamRegistroPlan().setAbonadosSel(null);
			paramOservicio.getRegistroPlan().getParamRegistroPlan().setNumAbonados(null);


		}
		else{
			
			listaDetalles = new DetEstadoProcesoOSSDTO[paramOservicio.getRegistroPlan().getParamRegistroPlan().getAbonadosSel().length];
			for(int i=0; i<paramOservicio.getRegistroPlan().getParamRegistroPlan().getAbonadosSel().length; i++){
				DetEstadoProcesoOSSDTO detalle=new DetEstadoProcesoOSSDTO();
				detalle.setNumAbonado(paramOservicio.getRegistroPlan().getParamRegistroPlan().getAbonadosSel()[i].getNumAbonado());
				detalle.setNumOOSS(paramOservicio.getRegistroPlan().getParamRegistroPlan().getAbonadosSel()[i].getNumeroOS());
				detalle.setCodCliente(paramOservicio.getRegistroPlan().getCliente().getCodCliente());
				logger.debug("detalle.getNumAbonado()[" + detalle.getNumAbonado() + "]");
				logger.debug("detalle.getNumOOSS()[" + detalle.getNumOOSS() + "]");
				logger.debug("detalle.getCodCliente()[" + detalle.getCodCliente() + "]");
				listaDetalles[i]=detalle;
				// INICIO RRG 18-02-2008 77303 -DATO PARA RESPALDO DE MENSAJE ANTES DE ENCOLAR
					logger.debug("INICIO RESPALDO ORDEN DE SERVICIO");
					RegistroColaDTO param = new RegistroColaDTO();
					param.setCodModulo("PV");
					param.setNumOOSS(   Long.toString(detalle.getNumOOSS() ) );// debe ser numero
					param.setCodTipModi(registroPlan.getParamRegistroPlan().getCodTipModi());
					param.setCodOS(   Long.toString(registroPlan.getParamRegistroPlan().getCodOOSS()) );		
					param.setCodCliente(  Long.toString(paramOservicio.getRegistroPlan().getCliente().getCodCliente()) );
					param.setCodClienteDestino(  Long.toString(registroPlan.getParamRegistroPlan().getCodClienteDestino()) );
					param.setNumAbonado(  Long.toString(paramOservicio.getRegistroPlan().getParamRegistroPlan().getAbonadosSel()[i].getNumAbonado()) );
					//param.setCodCuenta("CUENTA");
					param.setCodCuentaDestino( Long.toString(registroPlan.getParamRegistroPlan().getCodCuentaDestino())); 
					//param.setCodCiclo("CodCiclo");
					param.setCodPlanTarif( registroPlan.getParamRegistroPlan().getCodPlanTarifario() ); 

					param.setCodPlanTarifDestino(registroPlan.getParamRegistroPlan().getCodPlanTarifDestino());
					param.setCodUso( paramOservicio.getRegistroPlan().getParamRegistroPlan().getAbonadosSel()[i].getCodUso() );
					param.setCodUsoDestino(paramOservicio.getRegistroPlan().getParamRegistroPlan().getAbonadosSel()[i].getCodUsoDestino() );
					param.setCodActabo(registroPlan.getParamRegistroPlan().getCodActAbo()); 
					//param.setCodVendedor("CodVendedor");
					param.setAplicaTraspaso(registroPlan.getParamRegistroPlan().getAplicaTraspaso());
					//param.setFecDesdeLlam("FecDesdeLlam");				
					//param.setFechaProgramacion(estado.getFechaActualizacion().toString() );  //  SIRVE CALETA!!!
					//140809 pv
					logger.debug("combinatoria    [" + combinatoria + "]");
					logger.debug("esPrepagoPrepago[" + esPrepagoPrepago + "]");
					if(!esPrepagoPrepago)//prepagoprepago40006 no setear
					{
						logger.debug("Se debe setear param.setFechaProgramacion");
						if(registroPlan.getParamRegistroPlan().getFechaProgramacion() != null)
						{
							param.setFechaProgramacion(registroPlan.getParamRegistroPlan().getFechaProgramacion().toString()); // RRG
							logger.debug("param.getFechaProgramacion()[" + param.getFechaProgramacion() + "]");
						}else
						{
							logger.debug("registroPlan.getParamRegistroPlan().getFechaProgramacion()[null]");
						}
					}
					else
					{
						logger.debug("no se setea param.setFechaProgramacion para prepagoyyprepago");
					}

					param.setCodUsuario(registroPlan.getParamRegistroPlan().getNomUsuaOra());
					param.setComentario(registroPlan.getParamRegistroPlan().getComentario());
					param.setValorAuxiliar(registroPlan.getParamRegistroPlan().getAplicaTraspaso());

					delegate.insertaTablaCola(param);
					logger.debug("FIN RESPALDO ORDEN DE SERVICIO");

		// FIN RRG 18-02-2008 77303 
			}
		}
		
		
		
		try{
			estado.setDetEstadoProcesoOSSDTO(listaDetalles);
			logger.debug("notificar():inicio");
			estado=delegate.notificar(estado);
			logger.debug("notificar():fin");
			logger.debug("NumProceso[" + estado.getNumProceso() + "]");
			paramOservicio.setEstadoProcesoOOSS(estado);
			
		}catch (ManReqException e) {
			logger.debug("Ocurrio un error al notificar la orden de servicio");
			logger.debug("e.getCodigo() " + e.getCodigo());
			logger.debug("e.getCodigoEvento() " + e.getCodigoEvento());
			logger.debug("e.getDescripcionEvento() " + e.getDescripcionEvento());
			PAGINA = "ErrorEnActionDeCarga";
			String osInvalida = e.getDescripcionEvento();
			logger.debug("osInvalida[" + osInvalida + "]");
			session.setAttribute("error", osInvalida);
		}
		
		
		//Setea los datos del vendedor comisionable
		VendedorComisionable vendedorComisionable = new VendedorComisionable();
		logger.debug("handlerVendedorComisionable:antes");
		UsuarioVendedorDTO usuariovendedor = vendedorComisionable.handlerVendedorComisionable(registroPlan, listaDetalles, session);
		
		logger.debug("handlerVendedorComisionable:despues");

		// Desbloqueo de solicitud de evualuacion de riesgo antes
		// de enviar a encolar el objeto de orden de servicio
		LstPTaPlanTarifarioListOutDTO dataPlanesEval = (LstPTaPlanTarifarioListOutDTO) session.getAttribute("dataPlanesEval");
		if (dataPlanesEval!=null && dataPlanesEval.getNumSol()!=null && !dataPlanesEval.getNumSol().trim().equals("0") ){
			SalidaOutDTO resultado = delegate.desBloqueaSolicitudEvRiesgo(Long.parseLong(dataPlanesEval.getNumSol()));
			logger.debug("resultado desBloqueaSolicitudEvRiesgo:inicio");
			logger.debug("resultado.getCodError():"+resultado.getCodError());
			logger.debug("resultado.getCodEvento():"+resultado.getCodEvento());
			logger.debug("resultado.getMsgError():"+resultado.getMsgError());
			logger.debug("resultado desBloqueaSolicitudEvRiesgo:fin");
		}

		try {
			logger.debug("ejecutarOrdenServicioJms:antes");
			delegate.ejecutarOrdenServicioJms(paramOservicio);
			logger.debug("ejecutarOrdenServicioJms:despues");
		} catch (Exception e) {
			logger.debug("Ocurrio un error enviando la orden de servicio a la cola");
			throw e;
		}
		finally {
			
			try {
				VendedorDTO vendedor = (VendedorDTO)session.getAttribute("Vendedor");
			  // INI 71897; AVC; 28-10-2008
				logger.debug("VERIFICANDO SI USUARIO ES CALL CENTER...");
				logger.debug( "[UsuarioVendedorComisionable] esCallCenter:" + session.getAttribute("esCallCenter") ); // RRG
				String esCallCenter = "N";	
				if (usuariovendedor!=null){
					// esCallCenter = usuariovendedor.getUsuario().getCall_center(); INICIO RRG 04-12-2008 COL CPU
					try
					{
						logger.debug("getCall_center:"+usuariovendedor.getUsuario().getCall_center()); // RRG
						if (usuariovendedor.getUsuario().getCall_center()!=null)  //RRG
						{	
							esCallCenter = usuariovendedor.getUsuario().getCall_center();
						} else {
							logger.debug("usuariovendedor.getUsuario().getCall_center() Venia Nulo");
							esCallCenter = session.getAttribute("esCallCenter").toString(); // RRG
//							esCallCenter = "N";
						}
					} 
					catch (Exception e)
					{
						logger.debug("Se fue por el Catch, getCall_center es nulo");
						esCallCenter = session.getAttribute("esCallCenter").toString(); // RRG
//						esCallCenter = "N";
					}
					//FIN RRG 04-12-2008 COL CPU
					logger.debug("Usuario ES Call Center? : " + esCallCenter);
				}
				if (esCallCenter.equals("N")){
					logger.debug("Usuario NO es Call Center: "+ esCallCenter);
					logger.debug("No se realiza Insert");
		        }else{
		        	logger.debug("insertarVendedorComisionable:Antes ()");
					vendedorComisionable.insertarVendedorComisionable(usuariovendedor,vendedor);
		            logger.debug("insertarVendedorComisionable:despues");
		        }
			  //FIN 71897; AVC; 28-10-2008
			}catch (IssCusOrdException e){
				logger.debug("Ocurrio un error al insertar vendedor comisionable");
				logger.debug("e.getCodigo() " + e.getCodigo());
				logger.debug("e.getCodigoEvento() " + e.getCodigoEvento());
				logger.debug("e.getDescripcionEvento() " + e.getDescripcionEvento());
				PAGINA = "ErrorEnActionDeCarga";
				String osInvalida = global.getValor("error.vendedor.comisionable") + e.getDescripcionEvento();
				logger.debug("Mensaje error RegistrarAction:"+osInvalida);
				session.setAttribute("error", osInvalida);
			}
		}
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
				delegate.aceptarPresupuesto(presup);
				logger.debug("aceptarPresupuesto:despues");
				session.removeAttribute("PresupuestoForm");
				//return mapping.findForward(SIGUIENTE);	EV 13/11/09
			}
		}//fin rbCiclo = NO
		/*------------------Fin Aceptar presupuesto-----------------*/
		logger.debug("execute():end");
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
