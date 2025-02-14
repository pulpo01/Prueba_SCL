package com.tmmas.scl.operations.frmkooss.web.action;

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

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.framework.ProductDomain.dto.ModalidadPagoDTO;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.CargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ContratoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DocumentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.GaVentasDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ImpuestosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.UsuarioDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CabeceraArchivoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegCargosDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegistroFacturacionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.VendedorDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PresupuestoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ResultadoRegCargosDTO;
import com.tmmas.scl.operations.crm.fab.cusintman.web.delegate.SuspensionVoluntariaBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cusintman.web.helper.Utilidades;
import com.tmmas.scl.operations.frmkooss.web.delegate.FrmkOOSSBussinessDelegate;
import com.tmmas.scl.operations.frmkooss.web.dto.TablaCargosDTO;
import com.tmmas.scl.operations.frmkooss.web.form.CargosForm;
import com.tmmas.scl.operations.frmkooss.web.form.PresupuestoForm;
import com.tmmas.scl.operations.frmkooss.web.helper.Global;

public class PresupuestoAction extends Action{

	private final Logger logger = Logger.getLogger(PresupuestoAction.class);
	private Global global = Global.getInstance();
	private static final String SIGUIENTE = "controlNavegacion";
	private static final String ANTERIOR = "controlNavegacion";
	private static final String PAGINA = "presupuesto";
	private String textoMensajeRestricciones;
	
	private FrmkOOSSBussinessDelegate delegate = FrmkOOSSBussinessDelegate.getInstance();
	private SuspensionVoluntariaBussinessDelegate delegateServiciosSuplementarios = SuspensionVoluntariaBussinessDelegate.getInstance();
	
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		try{
			String log = global.getValor("web.log");
			log=System.getProperty("user.dir")+ log;
			PropertyConfigurator.configure(log);
			logger.debug("execute():start");
			
		    ClienteOSSesionDTO sessionData = new ClienteOSSesionDTO();
		    HttpSession session = request.getSession(false);
		    sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");
		    
			PresupuestoForm formPresupuesto = (PresupuestoForm) form;
			session.removeAttribute("numeroVenta");
			CargosForm cargosForm = new CargosForm();
			PresupuestoDTO presup = new PresupuestoDTO();
			if(session.getAttribute("CargosForm")!=null)
				cargosForm = (CargosForm)session.getAttribute("CargosForm");
	
			if(formPresupuesto.getAccion()!=null&&!((String)session.getAttribute("accionAutDesc")).equalsIgnoreCase("")){
				session.setAttribute("ultimaPagina", "Presupuesto");
				if(formPresupuesto.getAccion().equalsIgnoreCase("Siguiente")){
					formPresupuesto.setAccion("");
					session.setAttribute("accionAutDesc","Siguiente");
					
					// cierro la ventana
					presup.setNumVenta(cargosForm.getNumVenta());
					String impTotal=Utilidades.eliminaCaracterdeCadena(',',cargosForm.getTotal());
					
					cierreVenta(presup,sessionData.getCliente().getCodCliente(),Float.parseFloat(impTotal), formPresupuesto.getMontoAbono());
	
					return mapping.findForward(SIGUIENTE);
					
				}else if(formPresupuesto.getAccion().equalsIgnoreCase("Anterior")){
					presup = null;
					if(cargosForm.getCargosMerge().getCargos()!=null){
						//cargosForm.getCargosMerge().setCargos(null);//Limpieza de Cargos
					}
					formPresupuesto.setAccion("");
					session.setAttribute("accionAutDesc","Anterior");
					RegistroFacturacionDTO registro = new RegistroFacturacionDTO();
					registro.setNumeroProcesoFacturacion(String.valueOf(formPresupuesto.getNumProceso()));
					/**
					 * @author rlozano
					 * @description se retorna a Cero el total de los cargos seleccionados;
					 */
					//cargosForm.setNumVenta(0);
					cargosForm.setTotal("0");
					cargosForm.setRbCiclo("NO");
					delegate.eliminarPresupuesto(registro);
					
					return mapping.findForward(ANTERIOR);
				}else if(formPresupuesto.getAccion().equalsIgnoreCase("Imprimir")){
			        String rutaReporte = System.getProperty("user.dir") + global.getValor("ruta.reportes")+global.getValor("reporte.presupuesto");
			        
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
				    //ObtencionCargosDTO obtencionCargos =  cargosForm.getCargosMerge(); //Arreglo de Cargos a Registrar CargosDTO
			    ObtencionCargosDTO obtencionCargos =  cargosForm.getCargosSeleccionados(); //Arreglo de Cargos a Registrar CargosDTO
		
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
			    try{
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
				
				// lo cargo para validar si hay que cargar el popup o no
				formPresupuesto.setRbCiclo("NO");
				
				//obtener presupuesto
				ImpuestosDTO impuesto =  new ImpuestosDTO();
				//*************para probar***********
				//formPresupuesto.setNumProceso(2417725);
				TablaCargosDTO[] tablaCargosDTO = null;
				List cargos = new ArrayList();
				float[] totalesPresupuesto = new float[4];
				float importeTotal =0;
				if(cargosForm!=null){
					tablaCargosDTO = cargosForm.getTablaCargos();
					impuesto.setTotalImpuestos(resultadoRegistroCargos.getTotalImpuestos());
					
			        presup.setNumProceso(formPresupuesto.getNumProceso());
			        presup = delegate.obtenerDetallePresupuesto(presup);
			        float ImporteTotal=0;
			        float Impuestos=0;
			        float ImporteDescuentos=0;
			        float ImporteBase=0;
			        for(int k=0;k<presup.getDetalle().length;k++){
			        	ImporteTotal=ImporteTotal+presup.getDetalle()[k].getImpTotal();
			        	Impuestos=Impuestos+presup.getDetalle()[k].getImpImpuesto();
			        	ImporteDescuentos=ImporteDescuentos+presup.getDetalle()[k].getImpDcto();
			        	ImporteBase=ImporteBase+presup.getDetalle()[k].getImpBase();
			        }
					
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
						importeTotal =0;
						float totalDscto = 0;
						for(int j=0; j<tablaCargosDTO.length; j++){
							saldo = saldo + Float.parseFloat(tablaCargosDTO[j].getSaldo());
							importeTotal = importeTotal + Float.parseFloat(tablaCargosDTO[j].getImporteTotal());
							String tipdesAut=tablaCargosDTO[j].getTipoDescuentoAut();
							tipdesAut=tipdesAut==null?"":tipdesAut;
							tipdesAut="0".equals(tipdesAut)?"Monto":("1".equals(tipdesAut)?"Porcentaje":"N/A");
							tablaCargosDTO[j].setTipoDescuentoAut(tipdesAut);
						
							
						}
						//totalDscto = importeTotal - saldo;
						/*totalesPresupuesto[0] = importeTotal;
						totalesPresupuesto[1] = impuesto.getTotalImpuestos();
						totalesPresupuesto[2] = totalDscto - (totalDscto*2); // para que el descuento aparezca en negativo
						totalesPresupuesto[3] = importeTotal + impuesto.getTotalImpuestos() + totalesPresupuesto[2] ;*/
						totalesPresupuesto[0] = ImporteBase;
						totalesPresupuesto[1] = Impuestos;
						totalesPresupuesto[2] = -ImporteDescuentos; 
						totalesPresupuesto[3] = ImporteTotal;
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
					
					session.setAttribute("totalesPresupuesto",totalesPresupuesto);
	//				 //cierre venta
					//PresupuestoDTO presup=new PresupuestoDTO();
					presup.setNumVenta(numVenta);
					presup.setNumProceso(numSecuencia);
					cierreVenta(presup,sessionData.getCliente().getCodCliente(),Float.parseFloat(String.valueOf(totalesPresupuesto[3])), formPresupuesto.getMontoAbono());
					
				}
			    }catch(Exception e){
			    	textoMensajeRestricciones="Error al Registrar Cargos o Prebilling";
			    	delegateServiciosSuplementarios.guardaMensajesError(request, "Error en el Módulo de Cargos o Prebilling", textoMensajeRestricciones);
					return mapping.findForward("error");
			    }
	
				//dejar en request valores
				 session.setAttribute("numeroVenta", String.valueOf(cargosForm.getNumVenta()));
				
			    session.setAttribute("glsTipoDocumento", glsTipoDocumento);
			}//fin if 
		}catch(GeneralException e){
			//delegateCambioSimcard.guardaMensajesError(request, e.getDescripcionEvento(), textoMensajeRestricciones);
			return mapping.findForward("error");
		}
		
		logger.debug("execute():end");
		return mapping.findForward(PAGINA);
		
	}
	
	public boolean aplicaCargo(String codConcepto, CargosForm cargosForm){
		TablaCargosDTO[] tablaCargos = cargosForm.getTablaCargos();
		ObtencionCargosDTO cargosSelecionados=cargosForm.getCargosSeleccionados();
		String codConceptoCargo=null;
		boolean retValue=false;
		if (cargosSelecionados!=null&&cargosSelecionados.getCargos()!=null){
			CargosDTO[] cargos=cargosSelecionados.getCargos();
			for (int i=0;i<cargos.length;i++){
				codConceptoCargo=cargos[i].getPrecio().getCodigoConcepto();
				if (codConcepto.equals(codConceptoCargo)){
					retValue= true;
				}
			}
		}
		return retValue;
		
		/*String checks[] = cargosForm.getSelectedValorCheck();
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
		return false;*/
	}
	
	public void cierreVenta(PresupuestoDTO presupuestoDTO,long codCliente, float impTotal, Float montoAbono){

		try{
			if (presupuestoDTO.getNumVenta()>0){
			 	GaVentasDTO gaVentasDTO=new GaVentasDTO(); 
				gaVentasDTO.setNumVenta(new Long(presupuestoDTO.getNumVenta()));
				gaVentasDTO.setNumTransaccion(new Long(presupuestoDTO.getNumProceso()));
				gaVentasDTO.setCodCliente(new Long(codCliente));
				gaVentasDTO.setImpVenta(new Float(impTotal));
				gaVentasDTO.setAciclo(false);
				gaVentasDTO.setCuotas(false);
				gaVentasDTO.setCheque(true);//parametro para la ejecucion del update caso C
				gaVentasDTO.setTrajCredito(false);//parametro para la ejecucion del update caso C

				// montoAbono es el tomado en el popup de ingreso de monto de abono
				montoAbono=montoAbono==null?new Float("0.0"):montoAbono;
				gaVentasDTO.setImpAbono(montoAbono);
				gaVentasDTO.setIndAbono(Long.valueOf(global.getValor("indicador_abono_venta")));
				
				delegate.cierreVenta(gaVentasDTO);
			}
		}
		catch(GeneralException e){
			e.printStackTrace();  
		}
	}

}
