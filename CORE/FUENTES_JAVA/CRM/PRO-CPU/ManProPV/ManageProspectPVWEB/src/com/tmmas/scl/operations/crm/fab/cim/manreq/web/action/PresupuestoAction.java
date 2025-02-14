package com.tmmas.scl.operations.crm.fab.cim.manreq.web.action;

import java.io.File;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.UsuarioDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.DocumentoDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.ImpuestosDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.ObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ContratoDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ModalidadPagoDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.RegistroFacturacionDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.VendedorDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.CabeceraArchivoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RegCargosDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.PresupuestoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.ResultadoRegCargosDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.TablaCargosDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate.ManageRequestBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.CargosForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.PresupuestoForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.Global;

public class PresupuestoAction extends Action{

	private final Logger logger = Logger.getLogger(PresupuestoAction.class);
	private Global global = Global.getInstance();
	private static final String SIGUIENTE = "controlNavegacion";
	private static final String ANTERIOR = "controlNavegacion";
	private static final String PAGINA = "presupuesto";
	
	private ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();
	
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);
		logger.debug("execute():start");
		
	    ClienteOSSesionDTO sessionData = new ClienteOSSesionDTO();
	    HttpSession session = request.getSession(false);
	    sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");
	    
		PresupuestoForm formPresupuesto = (PresupuestoForm) form;
		
		CargosForm cargosForm = new CargosForm();
		if(session.getAttribute("CargosForm")!=null)
			cargosForm = (CargosForm)session.getAttribute("CargosForm");

		if(formPresupuesto.getAccion()!=null&&!((String)session.getAttribute("accionAutDesc")).equalsIgnoreCase("")){
			session.setAttribute("ultimaPagina", "Presupuesto");
			if(formPresupuesto.getAccion().equalsIgnoreCase("Siguiente")){
				formPresupuesto.setAccion("");
				session.setAttribute("accionAutDesc","Siguiente");
				return mapping.findForward(SIGUIENTE);
				
			}else if(formPresupuesto.getAccion().equalsIgnoreCase("Anterior")){
				formPresupuesto.setAccion("");
				session.setAttribute("accionAutDesc","Anterior");
				RegistroFacturacionDTO registro = new RegistroFacturacionDTO();
				registro.setNumeroProcesoFacturacion(String.valueOf(formPresupuesto.getNumProceso()));
				delegate.eliminarPresupuesto(registro);
				return mapping.findForward(ANTERIOR);
			}else if(formPresupuesto.getAccion().equalsIgnoreCase("Imprimir")){
		        String rutaReporte = global.getPathInstancia() + global.getValor("ruta.reportes")+global.getValor("reporte.presupuesto");
		        
		        Map parametros = new HashMap();
		        //numero venta
		        parametros.put("numeroVenta",String.valueOf(cargosForm.getNumVenta()));
		        //producto
		        parametros.put("descripcionProducto","CELULAR");
		        //tipo contrato
		        ContratoDTO contrato = new ContratoDTO();
		        contrato.setCodProducto(Integer.parseInt(global.getValor("codigo.producto")));
		        contrato.setCodigoTipoContrato(sessionData.getAbonados()[0].getCodTipContrato());
		        contrato = delegate.obtenerTipoContrato(contrato);
		        parametros.put("tipoContrato",contrato.getDescripcionTipoContrato());
		        //modalidad venta
		        ModalidadPagoDTO modalidad = new ModalidadPagoDTO();
		        modalidad.setCodigoModalidadPago(cargosForm.getCbModPago());
		        modalidad = delegate.obtenerModalidadPago(modalidad);
		        parametros.put("descripcionModalidadVenta",modalidad.getDescripcionModalidadPago());
		        //vendedor
				UsuarioDTO usuario = new UsuarioDTO();
		        usuario.setNombre(sessionData.getUsuario());
		        usuario = delegate.obtenerVendedor(usuario);
		        VendedorDTO vendedor = new VendedorDTO();
		        vendedor.setCodigoVendedor(String.valueOf(usuario.getCodigo()));
		        vendedor = delegate.obtenerVendedor(vendedor);
		        parametros.put("nombreVendedor",vendedor.getNombreVendedor());
		        //obtener cuenta
		        parametros.put("cuenta",sessionData.getCliente().getDesCuenta());
		        //obtener cliente
		        parametros.put("nombreCliente",sessionData.getCliente().getNombres());
		        //tipo documento
		        parametros.put("descripcionTipoDocumento",(String)session.getAttribute("glsTipoDocumento"));
		        //detalle cargos
		        PresupuestoDTO presup = new PresupuestoDTO();
		        presup.setNumProceso(formPresupuesto.getNumProceso());
		        presup = delegate.obtenerDetallePresupuesto(presup);
		        
		        List presupuesto = new ArrayList();
				for (int i=0;i<presup.getDetalle().length;i++){
					presupuesto.add(presup.getDetalle()[i]);
			    	
			    }
				//DataSource
				JRBeanCollectionDataSource ds = new JRBeanCollectionDataSource(presupuesto);
				ServletOutputStream servletOutputStream = response.getOutputStream();
				
				DecimalFormat df = new DecimalFormat();
				StringBuffer mascaraNumero = new StringBuffer();
				mascaraNumero.append(global.getValor("formato.numero.reporte"));
				df.applyPattern(mascaraNumero.toString());
				parametros.put("mascaraNumeros",df);
				
		        File reportFile = new File(rutaReporte);
		        logger.debug("Estado reporte :Existe="+reportFile.exists()+", Largo="+reportFile.length());

		        byte[] bytes =  JasperRunManager.runReportToPdf(reportFile.getPath(), parametros, ds);

		        response.setContentType("application/pdf");
		        response.setContentLength(bytes.length);
		        response.setHeader("Content-disposition", "attachment; filename=" + "Factura.pdf");
		        ServletOutputStream ouputStream = response.getOutputStream();
		        ouputStream.write(bytes,0,bytes.length);
		        ouputStream.flush();
		        ouputStream.close();

			}
			
			
		}else{
			session.setAttribute("accionAutDesc","primeraCarga");
		//if (!formPresupuesto.isFlgIniciado()){
			//formPresupuesto.setFlgIniciado(true);

			//ejecutar cargos
			//parametros entrada:
				//Arreglo de Cargos a Registrar CargosDTO
				//Plan Comercial Cliente
				//Codigo del Cliente
				//FacturaCiclo: parámetro booleano false: true;
				//NumeroVenta
		
		    ObtencionCargosDTO obtencionCargos =  cargosForm.getCargosSeleccionados(); //Arreglo de Cargos a Registrar CargosDTO
			//rlozano
			//ObtencionCargosDTO obtencionCargos =  cargosForm.getCargosMerge(); 
	
			long codCliente = sessionData.getCliente().getCodCliente(); //Codigo del Cliente
			
		    int codPlanCom;
		    //	sessionData.getCliente().getCodPlanCom(); //Plan Comercial Cliente
		    ClienteDTO clienteTMP = new ClienteDTO();
		    clienteTMP.setCodCliente(codCliente);
		    clienteTMP = delegate.obtenerPlanComercial(clienteTMP);
		    codPlanCom = clienteTMP.getCodPlanCom();
		    
			boolean aCiclo = false; //sessionData.getCargosObtenidos().isACiclo(); //facturaCiclo
			long numVenta = cargosForm.getNumVenta(); //numVenta
			String codTipoDocumento = cargosForm.getCbTipoDocumento();
			logger.debug("codTipoDocumento["+codTipoDocumento+"]");
			String glsTipoDocumento = " ";
			String tipoFoliacion = " ";
			
			//buscar glosa de documento y tipo foliacion:
			List listaTiposDoc = cargosForm.getDocumentosList();
			if (listaTiposDoc!= null){
				Iterator ite = listaTiposDoc.iterator();
			    while (ite.hasNext()) {
			    	DocumentoDTO doc = (DocumentoDTO)ite.next();
		        	if (doc.getCodigo().equals(codTipoDocumento)){
		        		glsTipoDocumento = doc.getDescripcion(); //glosa tipo documento (Boleta/Factura)
		        		tipoFoliacion = doc.getTipoFoliacion();
		        		break;
		        	}
			    }
			}
		    
			//llamar a ejecutar cargos
			ResultadoRegCargosDTO resultadoRegistroCargos = new ResultadoRegCargosDTO();
			RegCargosDTO retValConst=new RegCargosDTO();
			retValConst=delegate.construirRegistroCargos(obtencionCargos);
			
			CabeceraArchivoDTO objetoSesion=new CabeceraArchivoDTO();
			objetoSesion.setPlanComercialCliente(String.valueOf(codPlanCom));
			objetoSesion.setCodigoCliente(String.valueOf(codCliente));
			objetoSesion.setFacturaCiclo(aCiclo);
			objetoSesion.setNumeroVenta(numVenta);
			
			SecuenciaDTO secuencia = new SecuenciaDTO();
			secuencia.setNomSecuencia("GA_SEQ_TRANSACABO");
			long numSecuencia = delegate.obtenerSecuencia(secuencia).getNumSecuencia();
			objetoSesion.setNumeroTransaccionVenta(numSecuencia);

			objetoSesion.setCodigoDocumento(codTipoDocumento);
			objetoSesion.setCodModalidadVenta(cargosForm.getCbModPago());
			
			//TODO : Obtener vendedor
			UsuarioDTO usuario = new UsuarioDTO();
	        usuario.setNombre(sessionData.getUsuario());
	        usuario = delegate.obtenerVendedor(usuario);
			objetoSesion.setCodigoVendedor(String.valueOf(usuario.getCodigo()));
			
			
			retValConst.setObjetoSesion(objetoSesion);
			
			//registra cargos y devuelve presupuesto
			resultadoRegistroCargos = delegate.parametrosRegistrarCargos(retValConst);
			
			//obtener numero de proceso
			formPresupuesto.setNumProceso(Long.parseLong(resultadoRegistroCargos.getNumeroProceso()));
			logger.debug("formPresupuesto.getNumProceso()["+formPresupuesto.getNumProceso()+"]");
			//obtener presupuesto
			ImpuestosDTO impuesto =  new ImpuestosDTO();
						
			//(+) GS
			TablaCargosDTO[] tablaCargosDTO = null;
			List cargos = new ArrayList();
			float[] totalesPresupuesto = new float[4];
			
			if(cargosForm!=null){
				tablaCargosDTO = cargosForm.getTablaCargos();
				impuesto.setTotalImpuestos(resultadoRegistroCargos.getTotalImpuestos());
				
				if(tablaCargosDTO!=null){
					for(int i = 0;i<tablaCargosDTO.length;i++){
						if(aplicaCargo(tablaCargosDTO[i].getCodConcepto(),cargosForm)){
							cargos.add(tablaCargosDTO[i]);
						}
					}
					TablaCargosDTO [] cargosAprobados= new TablaCargosDTO[cargos.size()];
					for(int a = 0 ; a<cargos.size();a++){
						cargosAprobados[a] = (TablaCargosDTO)cargos.get(a);
					}
					tablaCargosDTO = cargosAprobados;
					float saldo = 0;
					float importeTotal =0;
					float totalDscto = 0;
					for(int j=0; j<tablaCargosDTO.length; j++){
						saldo = saldo + Float.parseFloat(tablaCargosDTO[j].getSaldo());
						importeTotal = importeTotal + Float.parseFloat(tablaCargosDTO[j].getImporteTotal());
					}
					totalDscto = importeTotal - saldo;
					totalesPresupuesto[0] = importeTotal;
					totalesPresupuesto[1] = impuesto.getTotalImpuestos();
					totalesPresupuesto[2] = totalDscto - (totalDscto*2); // para que el descuento aparezca en negativo
					totalesPresupuesto[3] = importeTotal + impuesto.getTotalImpuestos() + totalesPresupuesto[2] ;
					logger.debug("Total Conceptos          :"+totalesPresupuesto[0]);
					logger.debug("Total Impuesto           :"+totalesPresupuesto[1]);
					logger.debug("Total Descuentos         :"+totalesPresupuesto[2]);
					logger.debug("Total Presupuesto        :"+totalesPresupuesto[3]);
					
				}else{
					totalesPresupuesto[0] = 0;
					totalesPresupuesto[1] = 0;
					totalesPresupuesto[2] = 0;
					totalesPresupuesto[3] = 0;
					
				}
			
			}
			//(-)GS
			
			
			/*
			String tipDesc[] = cargosForm.getTipoDescuentoManual();
			impuesto.setTotalCargos(resultadoRegistroCargos.getTotalCargos());
			impuesto.setTotalImpuestos(resultadoRegistroCargos.getTotalImpuestos());
			impuesto.setTotalDescuentos(resultadoRegistroCargos.getTotalDescuentos());
			
			float impTotal = 0;
			float[] totalesPresupuesto = new float[4];
			if ("0".equals(tipDesc[0])){
				impTotal = impuesto.getTotalCargos()+impuesto.getTotalImpuestos()+impuesto.getTotalDescuentos();
				totalesPresupuesto[2] = impuesto.getTotalDescuentos();
				
			}else{
				float desc = (impuesto.getTotalCargos()*impuesto.getTotalDescuentos())/100 ;
				impTotal = impuesto.getTotalCargos()+impuesto.getTotalImpuestos()+desc;
				totalesPresupuesto[2] = desc;
			}
			
			
			totalesPresupuesto[0] = impuesto.getTotalCargos();
			totalesPresupuesto[1] = impuesto.getTotalImpuestos();
			totalesPresupuesto[3] = impTotal;
			*/
			
			//dejar en request valores
			
			
			
			session.setAttribute("totalesPresupuesto",totalesPresupuesto);
		    session.setAttribute("glsTipoDocumento", glsTipoDocumento);
		}//fin if 
		
		logger.debug("execute():end");
		return mapping.findForward(PAGINA);
		
	}
	
	
	// revisar
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
