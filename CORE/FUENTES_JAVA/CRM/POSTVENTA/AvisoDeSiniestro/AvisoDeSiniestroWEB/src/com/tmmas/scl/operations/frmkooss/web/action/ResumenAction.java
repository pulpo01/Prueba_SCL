package com.tmmas.scl.operations.frmkooss.web.action;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JasperRunManager;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.framework.aplicationDomain.dto.UsuarioSistemaDTO;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ControlDTO;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ValoresJSPPorDefectoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.CargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ObtencionCargosDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.Carta10060DTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CartaGeneralDTO;
import com.tmmas.scl.operations.crm.fab.cusintman.web.delegate.AvisoSiniestroBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cusintman.web.form.AvisoSiniestroForm;
import com.tmmas.scl.operations.frmkooss.web.businessObject.bo.XMLDefault;
import com.tmmas.scl.operations.frmkooss.web.delegate.FrmkOOSSBussinessDelegate;
import com.tmmas.scl.operations.frmkooss.web.dto.TablaCargosDTO;
import com.tmmas.scl.operations.frmkooss.web.form.CargosForm;
import com.tmmas.scl.operations.frmkooss.web.form.PresupuestoForm;
import com.tmmas.scl.operations.frmkooss.web.form.ResumenForm;
import com.tmmas.scl.operations.frmkooss.web.helper.Global;

public class ResumenAction extends Action {

	private final Logger logger = Logger.getLogger(ResumenAction.class);
	private Global global = Global.getInstance();
	private FrmkOOSSBussinessDelegate delegate = FrmkOOSSBussinessDelegate.getInstance();
	private AvisoSiniestroBussinessDelegate delegateAvisoSiniestro = AvisoSiniestroBussinessDelegate.getInstance();  
	private final String SIGUIENTE="resumen";
	private final String FACTURA="factura";
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	throws Exception {
		
		HttpSession session = request.getSession(false);
		ClienteOSSesionDTO sessionData = new ClienteOSSesionDTO();
		sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");
		CargosForm cargosForm = (CargosForm)session.getAttribute("CargosForm");
		
		float[] presupuesto=(float[])session.getAttribute("totalesPresupuesto");
		
		if (cargosForm.getRbCiclo().equals("SI")){
			presupuesto=null;
		}
		
		String vaACargos = "XXX";
		/*
		if(session.getAttribute("paramCargosUsoOOSS")!=null){
			vaACargos =((ParamObtCargOOSSDTO) session.getAttribute("paramCargosUsoOOSS")).getSinCondicionesComerciales();
			
		}*/
		
		vaACargos = sessionData.getSinCondicionesComerciales();     //GS
		
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);
		logger.debug("execute():start");
		XMLDefault objetoXML    = new XMLDefault();
		ValoresJSPPorDefectoDTO objetoXMLSession = new ValoresJSPPorDefectoDTO();
		session.setAttribute("ultimaPagina", "Resumen");
		
		ResumenForm resumenForm = (ResumenForm)form;
		String textoCarta = null;
		
		
		
//		Se procede a realizar el cierre de la venta
		
		


		/* if(true){//Condiciones de codigo de orden de servicio. */

		Carta10060DTO carta= new Carta10060DTO();
    	carta.setCodOOSS("10060");
    	carta.setNum_abonado(Long.getLong(String.valueOf(sessionData.getNumAbonado())));
    	carta.setTexCarta("");
    	
    	Long celu = new Long(String.valueOf(sessionData.getAbonados()[0].getNumCelular()));
    	carta.setNum_celular(celu);
    	textoCarta = obtenerCarta(carta);

	   /* }*/
		System.out.println(textoCarta);

		//Flujo	
		String botonSeleccionado = null;
		String paginaOrigen = " ";
		if (session.getAttribute("desde")!=null){
			paginaOrigen=(String)session.getAttribute("desde");
		}
		if(form instanceof ResumenForm){
			session.setAttribute("desde","resumen");
			botonSeleccionado = ((ResumenForm)form).getBtnSeleccionado();
			ResumenForm b= (ResumenForm)form;
			b.setBtnSeleccionado(null);
			session.setAttribute("ResumenForm", b);
		}
		
		if (!paginaOrigen.equals("registrar")){
			
			if(botonSeleccionado!=null&&botonSeleccionado.equalsIgnoreCase("registrarOS")){
					return mapping.findForward("registrarOS");
			}
		}else if (paginaOrigen.equals("registrar")){
			/*------------------Aceptar presupuesto-----------------*/
			
			if(cargosForm!=null && cargosForm.getRbCiclo().equalsIgnoreCase("NO")){
				PresupuestoForm presupuestoForm = new PresupuestoForm();
				if(session.getAttribute("PresupuestoForm")!=null){
					return mapping.findForward(FACTURA);	
				}
			}
			
			
			
			//fin rbCiclo = NO
			/*------------------Fin Aceptar presupuesto-----------------*/
		}

		if(botonSeleccionado!=null&&botonSeleccionado.equalsIgnoreCase("anterior")){
			/***
			 * @author rlozano
			 * @description Por si "retrocedio ejecuto cargos NO a ciclo y luego retrocedio ejecuto cargos SI a ciclo""
			 */
			presupuesto=null;
			
			/****FIN***/
			if((!"".equals(vaACargos)&&vaACargos!=null&&vaACargos.equalsIgnoreCase("SI"))||(sessionData.getObtenerCargos()!=null&& sessionData.getObtenerCargos().equalsIgnoreCase("NO"))){
				System.out.println("SIN CARGOS DIRECTO A INICIO");
				session.setAttribute("ultimaPagina","");
				return mapping.findForward("inicio");
			}else{
				cargosForm.setBotonSeleccionado(botonSeleccionado);
				System.out.println("CON CARGOS A CARGOS");
				return mapping.findForward("cargosAction");
			}		
		}
		
		String nivel = new String();		
		nivel = "Abonado";
		

		String nombreCliente;
		if(sessionData.getCliente().getNombreCompleto()!=null){
			nombreCliente = sessionData.getCliente().getNombreCompleto();
		}else{
			nombreCliente = sessionData.getCliente().getNombres();
		}

		if(botonSeleccionado!=null&&botonSeleccionado.equals("visualizar")){
			Map parametros = new HashMap();
			if (String.valueOf(sessionData.getNumOrdenServicio()) != null)
				parametros.put("Folio", String.valueOf(sessionData.getNumOrdenServicio()));
			else
				parametros.put("Folio", "111");
			UsuarioSistemaDTO usuarioSistema = new UsuarioSistemaDTO();
			usuarioSistema = (UsuarioSistemaDTO)session.getAttribute("usuarioSistema");

			parametros.put("Nivel", nivel);
			parametros.put("Codigo", "" + String.valueOf(sessionData.getNumAbonado()));
			parametros.put("Referencia", carta.getReferencia());
			parametros.put("NomCliente", nombreCliente);
			parametros.put("TextCarta", textoCarta);
			parametros.put("NomVendedor", usuarioSistema.getNom_operador()); 		
			parametros.put("DesComuna", usuarioSistema.getDes_comuna());
			parametros.put("DesOficina", usuarioSistema.getDes_ofician());

			try	{
				String rutaReporte = System.getProperty("user.dir") + global.getValor("ruta.reportes")+global.getValor("reporte.carta");
			File reportFile = new File(rutaReporte);
			logger.debug("Estado reporte :Existe="+reportFile.exists()+", Largo="+reportFile.length());
			byte[] bytes =  JasperRunManager.runReportToPdf(reportFile.getPath(), parametros, new JREmptyDataSource());
			logger.debug("bytes="+bytes);
			response.setContentType("application/pdf");
			response.setContentLength(bytes.length);
			response.setHeader("Content-disposition", "attachment; filename=" + "Factura.pdf");
			ServletOutputStream ouputStream = response.getOutputStream();
			ouputStream.write(bytes,0,bytes.length);
			ouputStream.flush();
			ouputStream.close();
			}
			catch (Exception ex)	{
				delegateAvisoSiniestro.guardaMensajesError(request, "Ha ocurrido un problema al intentar imprimir el reporte.", "Consulte por favor el log del sistema para averiguar la razón del inconveniente.");
				return mapping.findForward("error");
				
			}	// catch impresion reporte
			
		} // if

		TablaCargosDTO[] tablaCargosDTO = null;
		ControlDTO control=new ControlDTO();	    
		sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");              	    
		objetoXMLSession = sessionData.getDefaultPagina();
		control = objetoXML.obtenerControl(objetoXMLSession, "resumenPAG", "Comentarios", "comentariosTXA");
		sessionData.setComentarioOS(control.getValorDefecto());
		session.removeAttribute("ClienteOOSS");
		session.setAttribute("ClienteOOSS", sessionData);
		List cargos = new ArrayList();
		if(cargosForm!=null){
			if ("SI".equals(sessionData.getSinCondicionesComerciales())){
				cargosForm.setCargosSeleccionados(cargosForm.getCargosMerge());
				cargosForm.setTotal(formatearNumero(cargosForm.getTotal()));
			}
			tablaCargosDTO = cargosForm.getTablaCargos();

			if(tablaCargosDTO!=null){
				for(int i = 0;i<tablaCargosDTO.length;i++){
					if(aplicaCargo(tablaCargosDTO[i].getCodConcepto(),cargosForm)){
						String saldo=tablaCargosDTO[i].getSaldo();
						saldo=formatearNumero(saldo);
						tablaCargosDTO[i].setSaldo(saldo);
						cargos.add(tablaCargosDTO[i]);
					}
				}
				TablaCargosDTO tablaImpuesto = new TablaCargosDTO();
				tablaImpuesto.setDescripcion("IMPUESTOS");
				boolean isExistPresupuesto=presupuesto==null?false:true;
				String totalImpuesto=isExistPresupuesto?String.valueOf(presupuesto[1]):"0,0";
				totalImpuesto=formatearNumero(totalImpuesto);
				tablaImpuesto.setSaldo(totalImpuesto);
				
				cargos.add(tablaImpuesto);
				String totalCargos=isExistPresupuesto?String.valueOf(presupuesto[3]):cargosForm.getTotal();
				if (isExistPresupuesto){
					totalCargos=formatearNumero(totalCargos);
				}
				cargosForm.setTotal(totalCargos);
				TablaCargosDTO [] cargosAprobados= new TablaCargosDTO[cargos.size()];
				for(int a = 0 ; a<cargos.size();a++){
					cargosAprobados[a] = (TablaCargosDTO)cargos.get(a);
				}
				tablaCargosDTO = cargosAprobados;
			}
		 if(cargosForm!=null && cargosForm.getRbCiclo().equalsIgnoreCase("SI")){
			boolean existCargosSeleccionados=cargosForm.getCargosSeleccionados()!=null&&cargosForm.getCargosSeleccionados().getCargos()!=null&&cargosForm.getCargosSeleccionados().getCargos().length>0?true:false;
			if (existCargosSeleccionados){
				CargosDTO[] cargosList=cargosForm.getCargosSeleccionados().getCargos();
				float totalACiclo=0;
				float descuentos=0;
				for (int i=0;i<cargosList.length;i++){
					totalACiclo=totalACiclo+cargosList[i].getPrecio().getMonto();
					DescuentoDTO[] descuento=cargosList[i].getDescuento();
					if (descuento!=null&&descuento.length>0){
						for (int j=0;j<descuento.length;j++){
							descuentos=descuento[j].getMonto()+descuentos;
						}
					}
				}
				//totalACiclo=totalACiclo-descuentos;
				//cargosForm.setTotal(Float.toString(totalACiclo));
			}
			
		 }
		}
		
		session.setAttribute("listCarogos",tablaCargosDTO);
		logger.debug("execute():end");
		
		
		return mapping.findForward(SIGUIENTE);
	}

	public String obtenerCarta(CartaGeneralDTO cartaGeneral) throws GeneralException{
		CartaGeneralDTO retornoDTO;
		retornoDTO = delegate.obtenerTextoCarta(cartaGeneral);
		String retorno=null;
		retorno = retornoDTO.getTexCarta();
		return retorno;
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
		/*TablaCargosDTO[] tablaCargos = cargosForm.getTablaCargos();
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
		return false;*/
	}
	protected String formatearNumero(String numero){
		numero=numero==null?"":numero;
		String retValue=numero.replace(',','.');
		int contador=0;
		numero="";
		String numeroDecimal="";
		int k = retValue.indexOf(".");
		if (k==-1)
		{
			retValue = retValue.concat(".00");
			k = retValue.indexOf(".");
			 
		}
		
			numeroDecimal = retValue.substring(k+1, retValue.length());
			if (numeroDecimal.length()!=2)
			{
				retValue=retValue.concat("0");
			}
			k--;
			for (int i=k;i>=0;i--){
				contador++;
				if (contador==3&&i!=0)
				{
					numero=retValue.substring(0, i);
					numeroDecimal = retValue.substring(i, retValue.length());
					numero=numero.concat(",");
					retValue=numero + numeroDecimal;
					contador=0;
				}
			}
		
		return retValue;
	}
}
