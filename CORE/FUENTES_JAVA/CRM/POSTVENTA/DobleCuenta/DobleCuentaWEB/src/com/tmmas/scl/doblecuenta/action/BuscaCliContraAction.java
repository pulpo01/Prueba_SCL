package com.tmmas.scl.doblecuenta.action;

import java.util.ArrayList;
import java.util.Date;

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
import com.tmmas.scl.doblecuenta.commonapp.dto.ClienteDTO;
import com.tmmas.scl.doblecuenta.commonapp.dto.ClientesAsociadosDTO;
import com.tmmas.scl.doblecuenta.commonapp.exception.ProyectoException;
import com.tmmas.scl.doblecuenta.delegate.ManageRequestBussinessDelegate;
import com.tmmas.scl.doblecuenta.form.FacturacionDTO;
import com.tmmas.scl.doblecuenta.form.FacturacionDifForm;
import com.tmmas.scl.doblecuenta.helper.Global;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.RestriccionesDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.SecuenciaDTO;

public class BuscaCliContraAction extends Action {
	
private static Logger logger = Logger.getLogger(BuscaCliContraAction.class);
	
	private CompositeConfiguration config; // MA
	
	private void setPropertieFile() {
//		  inicio MA
		     String strRuta = "/com/tmmas/cl/DobleCuentaWeb/web/properties/";
		     String srtRutaDeploy = System.getProperty("user.dir");
		     String strArchivoProperties= "DobleCuentaWeb.properties";
		     String strArchivoLog="DobleCuentaWeb.log";
		     //String strRutaArchivoExterno = srtRutaDeploy + "/" + strRuta + strArchivoProperties;
		     String strRutaArchivoExterno = srtRutaDeploy + strRuta + strArchivoProperties;
		     config = UtilProperty.getConfiguration(strRutaArchivoExterno, strRutaArchivoExterno);
		     UtilLog.setLog(strRuta + config.getString(strArchivoLog) );
		     // fin MA           
	}
	
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
	
		setPropertieFile();
		logger.debug("BuscaCliContraAction execute"); // MA
		
		ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();
		HttpSession session = request.getSession();
		FacturacionDifForm factDifForm = (FacturacionDifForm) form;
		
		
		session.removeAttribute("listaGrilla");
		String clienteContratante = "";
		String codigoCiclo = "";


		long codCiclo = 0;
		//long clienteContrat = 0;
		long secuencia = 0;
		

		String codigo = (String) request.getParameter("codCliente"); // CODIGO CLIENTE CONTRATANTE
		String ingresoCodigo = (String) request.getParameter("ordenServicio");	// CODIGO OOSS
		String usuario = (String) request.getParameter("userName");  // USUARIO APLICACION
		
		logger.debug("codigo:"+codigo);//MA
		logger.debug("codOOSS:"+ingresoCodigo);//MA
		logger.debug("usuario:"+usuario);//MA
		
		factDifForm.setCodigo(codigo);
		factDifForm.setIngresoCod(ingresoCodigo);
		factDifForm.setNombreUsuario(usuario);	
		
		session.setAttribute("factDifForm", factDifForm);
		
		
		System.out.println("codCliente-->" + codigo);
		System.out.println("codOOSS   -->" + ingresoCodigo);
		System.out.println("userName  -->" + usuario);

		/*
		usuario = factDifForm != null ? factDifForm.getNombreUsuario() : ""; // usuario oracle
		ingresoCodigo = factDifForm != null ? factDifForm.getIngresoCod() : ""; //codOOSS
		codigo = factDifForm != null ? factDifForm.getCodigo() : ""; //cliente contratante
		*/

		ClientesAsociadosDTO[] clientesAsociadosDTO = null;
		ClienteDTO clienteDT = new ClienteDTO();
		//String nombreClienteContrata = "";
		String numeroSecuencialCliente = "";
		String tipoValorWeb = "";
		
	try{
		
		//Esquema de restricciones
		Global global = Global.getInstance();
		
		// campos comunes para validacion
		RestriccionesDTO restricciones = new RestriccionesDTO();
		restricciones.setCodCliente(Long.parseLong(codigo));
	    restricciones.setPrograma(global.getValor("esquema.programa"));
	    restricciones.setCodActuacion(global.getValor("esquema.codActuacion"));
		restricciones.setProceso("0");
		restricciones.setCodModGener(global.getValor("esquema.codModGener"));
		restricciones.setCodOOSS(global.getValor("codigo.ooss"));
		restricciones.setDesactivacionSS(0);
		restricciones.setPlanDestino("");
		restricciones.setTipoPlanDestino("");
		restricciones.setFechaSistema(new Date());
		restricciones.setCodTarea(0);
		restricciones.setCodEvento(global.getValor("codigo.evento.cargar"));
		
		//obtener secuenciak
		SecuenciaDTO parametro = null;
		SecuenciaDTO retornoSecuencia = null;
		
	    parametro = new SecuenciaDTO();
		parametro.setNomSecuencia("GA_SEQ_TRANSACABO");
		logger.debug("obtenerSecuencia():inicio");
			retornoSecuencia = delegate.obtenerSecuencia(parametro);
		logger.debug("obtenerSecuencia():fin");
	    restricciones.setIdSecuencia(retornoSecuencia.getNumSecuencia());
	    
		//TODO quitar comentario para activar validacion al esquema de restricciones
		RetornoDTO retorno = delegate.validaRestricciones(restricciones);
		if(retorno==null || !retorno.getCodigo().equals("0"))
			throw new ProyectoException(retorno.getCodigo(), 0, retorno.getDescripcion());
		

		//if (ingresoCodigo != null && codigo != null) {
		if (codigo != null) {
			clienteDT.setCodClienteContra(Long.parseLong(codigo));
			//ArrayList listaGrilla = session.getAttribute("listaGrilla") != null ? (ArrayList) session.getAttribute("listaGrilla")	: new ArrayList();
			clienteDT = delegate.obtenerInformacionCliente(clienteDT);
			codCiclo = clienteDT.getCodCiclo();
			codigoCiclo = String.valueOf(codCiclo);
			clienteContratante = String.valueOf(codigo);
			secuencia = clienteDT.getNumSecuencialCliente();
			clienteDT.getNomCliente();
			
			tipoValorWeb = clienteDT.getTipoValor();

			//nombreClienteContrata = clienteDT.getNomCliente();
			numeroSecuencialCliente = String.valueOf(clienteDT.getNumSecuencialCliente());
			System.out.println("EL NUMERO SECUENCIAL DEL CLIENTE ES------>" + numeroSecuencialCliente);
			session.setAttribute("clienteDT.getNomCliente()", clienteDT.getNomCliente());
			session.setAttribute("codigoCiclo", codigoCiclo);
			session.setAttribute("clienteContratante", clienteContratante);
			session.setAttribute("secuencia", String.valueOf(secuencia));
			System.out.println("SECUENCIA"+secuencia);
			session.setAttribute("secuenciaInsert", String.valueOf(secuencia));
			session.setAttribute("numSecuencialCliente", numeroSecuencialCliente);
			session.setAttribute("tipoValorWeb", tipoValorWeb);
			
			logger.debug("numeroSecuencialCliente:"+numeroSecuencialCliente); // MA
			logger.debug("getNomCliente:"+clienteDT.getNomCliente()); // MA
			logger.debug("codigoCiclo:"+codigoCiclo); // MA
			logger.debug("clienteContratante:"+clienteContratante); // MA
			logger.debug("secuencia:"+String.valueOf(secuencia)); // MA
			logger.debug("secuenciaInsert:"+String.valueOf(secuencia)); // MA
			logger.debug("tipoValorWeb:"+tipoValorWeb); // MA
			
						
			// /-------------llamada al servicio de busqueda de clientes
			// asociados
			ArrayList listaClientesRelacionados = new ArrayList();
			clienteDT.setCodClienteContra(Long.parseLong(codigo));
			clientesAsociadosDTO = delegate.buscarClientesAsociados(clienteDT);

			for (int i = 0; i < clientesAsociadosDTO.length; i++) {
				FacturacionDTO facturaDTO = new FacturacionDTO();
				facturaDTO.setCodigoAbonado(clientesAsociadosDTO[i].getAbonado().getNumAbonado());
				facturaDTO.setNumeroCelular(clientesAsociadosDTO[i].getAbonado().getNumCelular());
				facturaDTO.setDescAbonado(clientesAsociadosDTO[i].getFactura().getUser());
				facturaDTO.setCodClienAsociado(String.valueOf(clientesAsociadosDTO[i].getCliente().getCodClienteAsoc()));
				facturaDTO.setDescClienAsociado(clientesAsociadosDTO[i].getCliente().getNomCliente());
				facturaDTO.setCodigoConcepto(String.valueOf(clientesAsociadosDTO[i].getConcepto().getCodConceptoOrig()));
				facturaDTO.setDescConcepto(clientesAsociadosDTO[i].getConcepto().getDescripcion());
				facturaDTO.setValor(String.valueOf(clientesAsociadosDTO[i].getConcepto().getMontoConcepto()));
				facturaDTO.setNumSecuenciaDetalle(String.valueOf(clientesAsociadosDTO[i].getFactura().getNumSecDetalleFd()));
				System.out.println("el numero de secuencia de los registros son----->" + clientesAsociadosDTO[i].getFactura().getNumSecDetalleFd());
				facturaDTO.setEstadoListaFact("listaAntigua");
				listaClientesRelacionados.add(facturaDTO);
			}

			session.setAttribute("listaGrilla", listaClientesRelacionados);
			
		}
		codigoCiclo = String.valueOf(codCiclo);
		session.setAttribute("codigoCiclo", codigoCiclo);
		session.setAttribute("usuario", usuario);
		
	return mapping.findForward("sucessBusCliContra");
		
	} catch (ProyectoException e) {
			logger.error(e.getDescripcionEvento());//MA
			request.setAttribute("error", e.getDescripcionEvento());
			return mapping.findForward("error");
	} catch (Exception e) {
		logger.error(e.getMessage());//MA
		request.setAttribute("error", "Ocurrió un error inesperado");
		return mapping.findForward("error");
	}
  }	
}
