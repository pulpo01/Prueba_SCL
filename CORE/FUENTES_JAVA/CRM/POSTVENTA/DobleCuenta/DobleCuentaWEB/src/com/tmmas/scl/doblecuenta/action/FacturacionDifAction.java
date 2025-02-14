package com.tmmas.scl.doblecuenta.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.scl.doblecuenta.commonapp.dto.AbonadoDTO;
import com.tmmas.scl.doblecuenta.commonapp.dto.ClienteDTO;
import com.tmmas.scl.doblecuenta.commonapp.dto.ConceptoDTO;
import com.tmmas.scl.doblecuenta.commonapp.dto.FacturaDTO;
import com.tmmas.scl.doblecuenta.commonapp.dto.RetornoDTO;
import com.tmmas.scl.doblecuenta.commonapp.exception.ProyectoException;
import com.tmmas.scl.doblecuenta.delegate.ManageRequestBussinessDelegate;
import com.tmmas.scl.doblecuenta.form.FacturacionDTO;
import com.tmmas.scl.doblecuenta.form.FacturacionDifForm;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.SecuenciaDTO;

public class FacturacionDifAction extends Action {

	//private Global global = Global.getInstance();

	private static Logger logger = Logger.getLogger(FacturacionDifAction.class);
	private ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();
	
	private CompositeConfiguration config;

	private void setPropertieFile() {
//	  inicio MA
	     String strRuta = "/com/tmmas/cl/DobleCuentaWeb/web/properties/";
	     String srtRutaDeploy = System.getProperty("user.dir");
	     String strArchivoProperties= "DobleCuentaWeb.properties";
	     String strArchivoLog="DobleCuentaWeb.log";
	     String strRutaArchivoExterno = srtRutaDeploy + "/" + strRuta + strArchivoProperties;
	     config = UtilProperty.getConfiguration(strRutaArchivoExterno, strRutaArchivoExterno);
	     UtilLog.setLog(strRuta + config.getString(strArchivoLog) );
	     // fin MA           
	}
	

	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		setPropertieFile(); // MA

		//String log = global.getValor("web.log");
		//log = System.getProperty("user.dir") + log; 
		//PropertyConfigurator.configure(log);

		logger.debug("executeFacturacionDifAction():start");

		ConceptoDTO[] conceptosDTO = null;
		HttpSession session = request.getSession();
		System.out.println("************estoy en el FacturacionDifAction***************************");
		FacturacionDifForm factDifForm = (FacturacionDifForm) form;
		ArrayList listaOperacion = new ArrayList();
		ArrayList listaModalidad = new ArrayList();
		ArrayList listaTipoValor = new ArrayList();
		ArrayList listaConcepto = new ArrayList();

		logger.debug("entramos a obtener conceptos action");
		// ----------lista cargada por
		// conceptos---------------------------------------------------------------------------
		session.removeAttribute("listaTipoValor");
		session.removeAttribute("tipValor");
	try{	
		conceptosDTO = delegate.obtenerConceptosFact();
		logger.debug("la lista de conceptos es " + conceptosDTO.toString());

		if (conceptosDTO != null) {

			ConceptoDTO[] nuevoConceptoDTO = agregarVacio(conceptosDTO);

			for (int i = 0; i < nuevoConceptoDTO.length; i++) {
				ConceptoDTO concepto = new ConceptoDTO();
				concepto.setCodConceptoOrig(nuevoConceptoDTO[i].getCodConceptoOrig());
				concepto.setDescripcion(nuevoConceptoDTO[i].getDescripcion());
				concepto.setMontoConcepto(nuevoConceptoDTO[i].getMontoConcepto());
				listaConcepto.add(concepto);
			}

		}

		// ----------------listas que cargan los combos por
		// defecto------------------------------------------------------------

		FacturacionDTO listaOperacionDTO = new FacturacionDTO();
		FacturacionDTO listaModalidadDTO = new FacturacionDTO();
		FacturacionDTO listaTipoValorDTO = new FacturacionDTO();
		FacturacionDTO listaTipoPorcentaje =  new FacturacionDTO();

//Inicio INC|62580|03-04-2008|MMC	
		FacturacionDTO listaModalidadTotDTO = new FacturacionDTO();
//Fin INC|62580|03-04-2008|MMC			
		
		FacturacionDTO[] listOperacionArrDTO = new FacturacionDTO[1];
		listaOperacionDTO.setCodigoOperacion("DC");
		listaOperacionDTO.setDescripOperacion("Doble Cuenta");
		listOperacionArrDTO[0] = listaOperacionDTO;

		if (listOperacionArrDTO != null) {

			FacturacionDTO[] nuevaOperacionDTO = agregarVacioOpe(listOperacionArrDTO);

			for (int i = 0; i < nuevaOperacionDTO.length; i++) {
				FacturacionDTO operaciones = new FacturacionDTO();
				operaciones.setCodigoOperacion(nuevaOperacionDTO[i].getCodigoOperacion());
				operaciones.setDescripOperacion(nuevaOperacionDTO[i].getDescripOperacion());

				listaOperacion.add(operaciones);
			}

		}

		FacturacionDTO[] listModalidadArrDTO = new FacturacionDTO[2];
		listaModalidadDTO.setCodigoModalidad("CF");
		listaModalidadDTO.setDescModalidad("Concepto Facturable");
		listModalidadArrDTO[0] = listaModalidadDTO;
//Inicio INC|62580|03-04-2008|MMC			
		listaModalidadTotDTO.setCodigoModalidad("TF");
		listaModalidadTotDTO.setDescModalidad("Total Facturable");
		listModalidadArrDTO[1] = listaModalidadTotDTO;
//Fin INC|62580|03-04-2008|MMC			
		
		if (listModalidadArrDTO != null) {
			FacturacionDTO[] nuevaModalidadDTO = agregarVacioMod(listModalidadArrDTO);

			for (int i = 0; i < nuevaModalidadDTO.length; i++) {
				FacturacionDTO modalidades = new FacturacionDTO();
				modalidades.setCodigoModalidad(nuevaModalidadDTO[i].getCodigoModalidad());
				modalidades.setDescModalidad(nuevaModalidadDTO[i].getDescModalidad());

				listaModalidad.add(modalidades);
			}

		}

		String tipoValorCombo = null;
		String tipoValorWeb = null;
		String secuencia = null;
		//long secFactura = 0;
		int countTipoValor = 0;
		
		tipoValorCombo = (String) session.getAttribute("idTipoValor");		
		tipoValorWeb = (String) session.getAttribute("tipoValorWeb");
		String countTV = (String) session.getAttribute("countTipoV");
		
		logger.debug("idTipoValor:"+tipoValorCombo); // MA
		logger.debug("tipoValorWeb:"+tipoValorWeb);  // MA
		logger.debug("countTipoV:"+countTV);  	// MA
		
		
		if(countTV == null){
			countTipoValor = 0;
		}else{
			countTipoValor = Integer.parseInt(countTV);
		}
			
		secuencia = (String) session.getAttribute("secuencia");
		
		logger.debug("secFactura:"+secuencia); // MA
		System.out.println("Secuencia cliente contratante: " + secuencia);
		
		long secFactura = Long.parseLong(secuencia);
		
	
		listaTipoValorDTO.setCodigoTipoValor("0");
		listaTipoValorDTO.setDescTipoValor("Monto");
		
		listaTipoPorcentaje.setCodigoTipoValor("1");
		listaTipoPorcentaje.setDescTipoValor("Porcentaje");
		
		if(secFactura > 0){
			if("0".equals(tipoValorWeb)){
				listModalidadArrDTO[0] = listaTipoValorDTO;
				session.setAttribute("tipValor", listaTipoValorDTO.getCodigoTipoValor());
			}else{
				listModalidadArrDTO[0] = listaTipoPorcentaje;
				session.setAttribute("tipValor", listaTipoPorcentaje.getCodigoTipoValor());
			}
		}else{
			  if(countTipoValor == 0){	
				listModalidadArrDTO = new FacturacionDTO[2];
				listModalidadArrDTO[0] = listaTipoValorDTO;
				listModalidadArrDTO[1] = listaTipoPorcentaje;
			  }else{
				  if("0".equals(tipoValorCombo)){
						listModalidadArrDTO[0] = listaTipoValorDTO;
						session.setAttribute("tipValor", listaTipoValorDTO.getCodigoTipoValor());
					}else{
						listModalidadArrDTO[0] = listaTipoPorcentaje;
						session.setAttribute("tipValor", listaTipoPorcentaje.getCodigoTipoValor());
					}
			  }
		}
		
		if (listModalidadArrDTO != null) {
			FacturacionDTO[] nuevoTipValorDTO = agregarVacioTipVal(listModalidadArrDTO);
			for (int j = 0; j < nuevoTipValorDTO.length; j++) {
				FacturacionDTO tipovalores = new FacturacionDTO();
				tipovalores.setCodigoTipoValor(nuevoTipValorDTO[j].getCodigoTipoValor());
				tipovalores.setDescTipoValor(nuevoTipValorDTO[j].getDescTipoValor());
				listaTipoValor.add(tipovalores);
			}
		}

		session.setAttribute("listaOperacion", listaOperacion);
		session.setAttribute("listaModalidad", listaModalidad);
		session.setAttribute("listaTipoValor", listaTipoValor);
		session.setAttribute("listaConcepto", listaConcepto);
		//----------------------------------------------------------insercion de datos asociados-------
	
		
		String codigCiclo="";
		codigCiclo =(String) session.getAttribute("codigoCiclo");
		
		String accion = "";
		accion = factDifForm != null ? factDifForm.getGuardarDatGrilla() : "";
		
		String secuenciaInsert = (String) session.getAttribute("secuenciaInsert");
		long secuenciaInsertar = Long.parseLong(secuenciaInsert);
		System.out.println("Secuencia cliente contratante: " + secFactura);
		String usuario = "";
		if ("grilla".equals(accion)) {
			
			ArrayList listGri = session.getAttribute("listaGrilla")!=null?(ArrayList)session.getAttribute("listaGrilla"):new ArrayList();
			String clienteCon="";
			clienteCon = (String) session.getAttribute("clienteContratante");
			
			ClienteDTO cliente = new ClienteDTO();
			cliente.setCodClienteContra(Long.parseLong(clienteCon));
			cliente.setCodCiclo(Long.parseLong(codigCiclo));
			
			
		//	String valorRecuperado = "";
		//	valorRecuperado = (String) session.getAttribute("valor");
			//FacturacionDTO factDTO = new FacturacionDTO();
			RetornoDTO retorno = new RetornoDTO();
			String [] datosAsociadosChequeados=null;
			ArrayList listaGrillaActualizada = new ArrayList();
			ArrayList Aux = new ArrayList();
			usuario = factDifForm != null ? factDifForm.getNombreUsuario() : "";
			datosAsociadosChequeados = factDifForm != null ? factDifForm.getListaCheckGrilla() : null;
			System.out.println("*******me llega la lista datosAsociadosChequeados*" + datosAsociadosChequeados.length);
//Inicio INC|62580|03-04-2008|MMC		
			String sIdModalidad ="";
			sIdModalidad = (String) session.getAttribute("idModalidad");
//Fin INC|62580|03-04-2008|MMC	
			
			FacturaDTO factura = new FacturaDTO();
			factura.setTipValor(Long.parseLong(tipoValorCombo));
			factura.setUser(usuario);
//			Inicio INC|62580|03-04-2008|MMC	 	
			if (("TF").equals(sIdModalidad)){
				factura.setTipModalidad(1);					
			}
			else{
				factura.setTipModalidad(0);					
			}
//Fin INC|62580|03-04-2008|MMC
			factura.setTipOperación(1);


			// Obtenemos secuencia
			SecuenciaDTO parametro = null;
			SecuenciaDTO sec = null;
			
		    parametro = new SecuenciaDTO();
			parametro.setNomSecuencia("CI_SEQ_NUMOS");
			logger.debug("obtenerSecuencia():inicio");
				sec = delegate.obtenerSecuencia(parametro);
			logger.debug("obtenerSecuencia():fin");
			
			long [][]listaR = delegate.ejecutaOS(datosAsociadosChequeados, cliente, factura, secuenciaInsertar, listGri, retorno, sec);
			session.setAttribute("numOOSS", String.valueOf(sec.getNumSecuencia()));
			return mapping.findForward("fin");
			
		}
	} catch (ProyectoException e) {
			String abonadoRep="";
			request.setAttribute("abonadoRep",abonadoRep);
			session.setAttribute("error", e.getMessage());
			
	}	
		
		return mapping.findForward("sucess");
	}

	public ConceptoDTO[] agregarVacio(ConceptoDTO[] listConcep) {

		ConceptoDTO[] arregloTemporal = null;
		ConceptoDTO conceptoVacio = new ConceptoDTO();

		conceptoVacio.setCodConceptoOrig(00);
		conceptoVacio.setDescripcion("Seleccionar...");

		arregloTemporal = new ConceptoDTO[listConcep.length + 1];

		arregloTemporal[0] = conceptoVacio;

		for (int j = 0; j < listConcep.length; j++) {
			arregloTemporal[j + 1] = listConcep[j];
		}
		return arregloTemporal;
	}

	public FacturacionDTO[] agregarVacioOpe(FacturacionDTO[] listaOperacionDTO) {

		FacturacionDTO[] arregloTemporal = null;
		FacturacionDTO operacionVacia = new FacturacionDTO();

		operacionVacia.setCodigoOperacion("operacion");
		operacionVacia.setDescripOperacion("Seleccionar...");
		arregloTemporal = new FacturacionDTO[listaOperacionDTO.length + 1];
		arregloTemporal[0] = operacionVacia;
		for (int j = 0; j < listaOperacionDTO.length; j++) {
			arregloTemporal[j + 1] = listaOperacionDTO[j];
		}
		return arregloTemporal;

	}

	public FacturacionDTO[] agregarVacioMod(FacturacionDTO[] listaModalidadDTO) {

		FacturacionDTO[] arregloTemporal = null;
		FacturacionDTO modalidadVacia = new FacturacionDTO();
		modalidadVacia.setCodigoModalidad("modalidad");
		modalidadVacia.setDescModalidad("Seleccionar...");
		arregloTemporal = new FacturacionDTO[listaModalidadDTO.length + 1];
		arregloTemporal[0] = modalidadVacia;
		for (int j = 0; j < listaModalidadDTO.length; j++) {
			arregloTemporal[j + 1] = listaModalidadDTO[j];
		}

		return arregloTemporal;

	}

	public FacturacionDTO[] agregarVacioTipVal(FacturacionDTO[] listaTipoValorDTO) {

		FacturacionDTO[] arregloTemporal = null;
		FacturacionDTO tipoValorVacio = new FacturacionDTO();

		tipoValorVacio.setCodigoTipoValor("tipoValor");
		tipoValorVacio.setDescTipoValor("Seleccionar...");

		arregloTemporal = new FacturacionDTO[listaTipoValorDTO.length + 1];

		arregloTemporal[0] = tipoValorVacio;

		for (int j = 0; j < listaTipoValorDTO.length; j++) {

			arregloTemporal[j + 1] = listaTipoValorDTO[j];

		}

		return arregloTemporal;

	}

}
