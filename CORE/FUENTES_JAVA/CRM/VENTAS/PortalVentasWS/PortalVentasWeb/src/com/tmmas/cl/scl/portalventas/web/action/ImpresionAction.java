package com.tmmas.cl.scl.portalventas.web.action;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import weblogic.net.http.SOAPHttpsURLConnection;
import weblogic.security.SSL.SSLSocketFactory;

import com.tmmas.cl.scl.commonbusinessentities.dto.ParametrosGlobalesDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosGeneralesDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.DatosContrato;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.DetalleFichaSalidaBodegaDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.FichaClienteDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.FichaContratoPrestacionDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.FichaSalidaBodegaDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.PagareDTO;
import com.tmmas.cl.scl.portalventas.web.delegate.PortalVentasDelegate;
import com.tmmas.cl.scl.portalventas.web.dto.VentaAjaxDTO;
import com.tmmas.cl.scl.portalventas.web.helper.Global;

public class ImpresionAction extends DispatchAction {
	private static final String CLAVE_LUGAR_PAGARE = "impresion.documentos.lugar.pagare";

	private static final String CLAVE_LUGAR_CONTRATO = "impresion.documentos.lugar.contrato.prestacion.servicios";

	private final Logger logger = Logger.getLogger(ImpresionAction.class);

	private Global global = Global.getInstance();

	PortalVentasDelegate delegate = PortalVentasDelegate.getInstance();

	public ActionForward imprimirSolTerminales(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("imprimirSolTerminales, inicio");
		Map parametros = new HashMap();
		HttpSession sesion = request.getSession(false);
		//TODO: MODIFICADO POR SANTIAGO
		String numVentaSel = (request.getParameter("numVentaSel") == null ? null : (String) request
				.getParameter("numVentaSel"));
		VentaAjaxDTO ventaSel = (VentaAjaxDTO) sesion.getAttribute("ventaSel");
		FichaSalidaBodegaDTO fichaSalidaBodegaDTO = new FichaSalidaBodegaDTO();
		try {
			if (ventaSel != null && ventaSel.getNroVenta() != null) {
				fichaSalidaBodegaDTO = delegate.obtenerDatosSalidaBodega(new Long(ventaSel.getNroVenta()));
			}
			else if (numVentaSel != null) {
				fichaSalidaBodegaDTO = delegate.obtenerDatosSalidaBodega(new Long(numVentaSel));
			}
			//fichaSalidaBodegaDTO = delegate.obtenerDatosSalidaBodega(new Long(ventaSel.getNroVenta()));
		}
		catch (Exception e) {
			String mensaje = e.getMessage() == null ? "Ocurrio un error al obtener datos solicitud de terminales " : e
					.getMessage();
			logger.debug("Exception," + mensaje);
		}

		//TODO: MODIFICADO POR SANTIAGO
		String user = null;
		if (sesion.getAttribute("paramGlobal") != null) {
			user = ((ParametrosGlobalesDTO) sesion.getAttribute("paramGlobal")).getCodUsuario();
		}
		if (user == null && request.getParameter("usuarioSCL") != null) {
			user = (String) request.getParameter("usuarioSCL");
		}

		parametros.put("solicitante", user);
		parametros.put("nombreVendedor", fichaSalidaBodegaDTO.getNomVendedor());
		parametros.put("nombreCliente", fichaSalidaBodegaDTO.getNomCliente());
		parametros.put("estadoSolicitud", ventaSel.getEstado());
		
		List informe = new ArrayList();
		for (int i = 0; i < fichaSalidaBodegaDTO.getDetalle().length; i++) {
			final DetalleFichaSalidaBodegaDTO item = fichaSalidaBodegaDTO.getDetalle()[i];
			logger.debug("item.toString() [" + item.toString() + "]");
			informe.add(item);
		}
		logger.debug("informe.size()=" + informe.size());
		if (informe.size() == 0)
			informe.add(new DetalleFichaSalidaBodegaDTO());

		InputStream logo = getServlet().getServletConfig().getServletContext().getResourceAsStream(
				"/img/logoTelefonica.jpg");
		parametros.put("logo", logo);//

		String sRutaReporte = System.getProperty("user.dir") + global.getValorExterno("solTerminales.reporte");
		File reportFile = new File(sRutaReporte);
		logger.debug("Estado reporte :Existe=" + reportFile.exists() + ", Largo=" + reportFile.length());

		try {
			JRBeanCollectionDataSource ds = new JRBeanCollectionDataSource(informe);

			byte[] bytes = JasperRunManager.runReportToPdf(reportFile.getPath(), parametros, ds);
			response.setContentType("application/pdf");
			response.setContentLength(bytes.length);
			response.setHeader("Content-disposition", "inline; filename=" + "SolTerminales.pdf");
			ServletOutputStream ouputStream = response.getOutputStream();
			ouputStream.write(bytes, 0, bytes.length);
			ouputStream.flush();
			ouputStream.close();
		}
		catch (JRException e) {
			String mensaje = e.getMessage() == null ? "Ocurrio un error al generar reporte " : e.getMessage();
			logger.debug("JRException," + mensaje);
		}

		logger.info("imprimirSolTerminales, fin");
		return null;
	}

	public ActionForward imprimirContratoPrestServicios(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {

		logger.info("imprimirContratoPrestServicios, inicio");
		Map parametros = new HashMap();
		HttpSession sesion = request.getSession(false);
		//TODO: MODIFICADO POR SANTIAGO
		String numVentaSel = (request.getParameter("numVentaSel") == null ? null : (String) request
				.getParameter("numVentaSel"));
		VentaAjaxDTO ventaSel = (VentaAjaxDTO) sesion.getAttribute("ventaSel");
		FichaContratoPrestacionDTO fichaContratoPrestacionDTO = new FichaContratoPrestacionDTO();
		try {
			//TODO: MODIFICADO POR SANTIAGO
			if (ventaSel != null && ventaSel.getNroVenta() != null) {
				fichaContratoPrestacionDTO = delegate.obtenerDatosContratoPrestacion(new Long(ventaSel.getNroVenta()));
			}
			else if (numVentaSel != null) {
				fichaContratoPrestacionDTO = delegate.obtenerDatosContratoPrestacion(new Long(numVentaSel));
			}
			//fichaContratoPrestacionDTO = delegate.obtenerDatosContratoPrestacion(new Long(ventaSel.getNroVenta()));
		}
		catch (Exception e) {
			String mensaje = e.getMessage() == null ? "Ocurrio un error al obtener datos contrato prestacion de servicios "
					: e.getMessage();
			logger.debug("Exception," + mensaje);
		}
		parametros.put("nombreCliente", fichaContratoPrestacionDTO.getNomCliente());
		parametros.put("telefono", fichaContratoPrestacionDTO.getTelefono() == null ? "" : fichaContratoPrestacionDTO
				.getTelefono());
		parametros.put("profesion", fichaContratoPrestacionDTO.getProfesion() == null ? "" : fichaContratoPrestacionDTO
				.getProfesion());
		parametros.put("numIdent2", fichaContratoPrestacionDTO.getNumIdent2() == null ? "" : fichaContratoPrestacionDTO
				.getNumIdent2());
		parametros.put("iva", new Long(fichaContratoPrestacionDTO.getNumFolio()));
		parametros.put("direccion", fichaContratoPrestacionDTO.getGlosaDir() == null ? "" : fichaContratoPrestacionDTO
				.getGlosaDir());
		parametros.put("numIdent", fichaContratoPrestacionDTO.getNumIdent() == null ? "" : fichaContratoPrestacionDTO
				.getNumIdent());
		final String lugar = global.getValorExterno(CLAVE_LUGAR_CONTRATO);
		logger.trace("lugar: " + lugar);
		parametros.put("lugar", lugar);
		parametros.put("modalidadVenta", fichaContratoPrestacionDTO.getDesModVenta());
		parametros.put("mesesCompromiso", String.valueOf(fichaContratoPrestacionDTO.getNumMeses()));

		List informe = new ArrayList();
		if (fichaContratoPrestacionDTO != null && fichaContratoPrestacionDTO.getDetalle() != null) {
			for (int i = 0; i < fichaContratoPrestacionDTO.getDetalle().length; i++) {
				informe.add(fichaContratoPrestacionDTO.getDetalle()[i]);
			}
		}
		logger.debug("informe.size()=" + informe.size());
		if (informe.size() == 0)
			informe.add(new FichaContratoPrestacionDTO());

		DecimalFormat df = new DecimalFormat();
		StringBuffer mascaraNumero = new StringBuffer();

		mascaraNumero.append(global.getValor("formato.numero.reporte"));
		int decimalesForm = Integer.parseInt(global.getValor("decimales.form"));
		if (decimalesForm > 0) {
			mascaraNumero.append(global.getValor("simbolo.decimal"));
			for (int i = 0; i < decimalesForm; i++) {
				mascaraNumero.append("0");
			}

		}
		logger.debug("formatnumero: " + mascaraNumero);
		df.applyPattern(mascaraNumero.toString());
		parametros.put("mascaraNumeros", df);

		String sRutaReporte = System.getProperty("user.dir") + global.getValorExterno("contratoPrestServicios.reporte");
		File reportFile = new File(sRutaReporte);
		logger.debug("Estado reporte :Existe=" + reportFile.exists() + ", Largo=" + reportFile.length());

		try {
			JRBeanCollectionDataSource ds = new JRBeanCollectionDataSource(informe);

			byte[] bytes = JasperRunManager.runReportToPdf(reportFile.getPath(), parametros, ds);
			response.setContentType("application/pdf");
			response.setContentLength(bytes.length);
			response.setHeader("Content-disposition", "inline; filename=" + "contratoPrestServicios.pdf");
			ServletOutputStream ouputStream = response.getOutputStream();
			ouputStream.write(bytes, 0, bytes.length);
			ouputStream.flush();
			ouputStream.close();
		}
		catch (JRException e) {
			String mensaje = e.getMessage() == null ? "Ocurrio un error al generar reporte " : e.getMessage();
			logger.debug("JRException," + mensaje);
		}

		logger.info("imprimirContratoPrestServicios, fin");
		return null;
	}

	public ActionForward imprimirFichaUsuario(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		logger.info("imprimirFichaUsuario, inicio");
		Map parametros = new HashMap();
		HttpSession sesion = request.getSession(false);
		//TODO: MODIFICADO POR SANTIAGO
		String numAbonado = (request.getParameter("numAbonado") != null ? (String) request.getParameter("numAbonado")
				: null);
		String numAbonadoSel = (sesion.getAttribute("numAbonadoSel") != null ? (String) sesion
				.getAttribute("numAbonadoSel") : null);
		numAbonadoSel = (numAbonadoSel != null) ? numAbonadoSel : "0";
		if (numAbonadoSel.equals("0")) {
			numAbonadoSel = (numAbonado != null) ? numAbonado : "0";
		}

		FichaClienteDTO fichaClienteDTO = new FichaClienteDTO();
		try {
			fichaClienteDTO = delegate.obtenerDatosFichaCliente(new Long(numAbonadoSel));
		}
		catch (Exception e) {
			String mensaje = e.getMessage() == null ? "Ocurrio un error al obtener datos de ficha de cliente " : e
					.getMessage();
			logger.debug("Exception," + mensaje);
		}
		//TODO: MODIFICADO POR SANTIAGO
		String user = null;
		if (sesion.getAttribute("paramGlobal") != null) {
			user = ((ParametrosGlobalesDTO) sesion.getAttribute("paramGlobal")).getCodUsuario();
		}
		if (user == null && request.getParameter("usuarioSCL") != null) {
			user = (String) request.getParameter("usuarioSCL");
		}

		parametros.put("telefonoAsignado", String.valueOf(fichaClienteDTO.getNumCelular()));
		parametros.put("nombreCliente", fichaClienteDTO.getNomCliente());
		parametros.put("fechaNacimiento", fichaClienteDTO.getFecNacimiento());
		parametros.put("profesion", fichaClienteDTO.getProfesion() == null ? "" : fichaClienteDTO.getProfesion());
		parametros.put("telefono", fichaClienteDTO.getTelefono() == null ? "" : fichaClienteDTO.getTelefono());
		parametros.put("direccion", fichaClienteDTO.getGlosaDir());
		parametros.put("identificacion", fichaClienteDTO.getGlosaIdent());
		parametros.put("codigoVendedor", String.valueOf(fichaClienteDTO.getCodVendealer()));
		parametros.put("nombreVendedor", fichaClienteDTO.getNomVendealer());
		parametros.put("puntoVenta", fichaClienteDTO.getDesOficina() == null ? "" : fichaClienteDTO.getDesOficina());
		parametros.put("nombreDistribuidor", fichaClienteDTO.getNomVendedor());
		parametros.put("terminal", fichaClienteDTO.getDescTerminal());
		parametros.put("icc", fichaClienteDTO.getIcc());
		parametros.put("imei", fichaClienteDTO.getImei());
		parametros.put("usuario", user);

		String sRutaReporte = System.getProperty("user.dir") + global.getValorExterno("fichaUsuario.reporte");
		File reportFile = new File(sRutaReporte);
		logger.debug("Estado reporte :Existe=" + reportFile.exists() + ", Largo=" + reportFile.length());

		try {

			byte[] bytes = JasperRunManager.runReportToPdf(reportFile.getPath(), parametros, new JREmptyDataSource());
			response.setContentType("application/pdf");
			response.setContentLength(bytes.length);
			response.setHeader("Content-disposition", "inline; filename=" + "FichaUsuario.pdf");
			ServletOutputStream ouputStream = response.getOutputStream();
			ouputStream.write(bytes, 0, bytes.length);
			ouputStream.flush();
			ouputStream.close();
		}
		catch (JRException e) {
			String mensaje = e.getMessage() == null ? "Ocurrio un error al generar reporte " : e.getMessage();
			logger.debug("JRException," + mensaje);
		}
		logger.info("imprimirFichaUsuario, fin");
		return null;
	}

	public ActionForward imprimirPagare(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		logger.info("imprimirPagare, inicio");
		Map parametros = new HashMap();
		HttpSession sesion = request.getSession(false);
		//TODO: MODIFICADO POR SANTIAGO
		String numVentaSel = (request.getParameter("numVentaSel") == null ? null : (String) request
				.getParameter("numVentaSel"));
		VentaAjaxDTO ventaSel = (sesion.getAttribute("ventaSel") == null ? null : (VentaAjaxDTO) sesion
				.getAttribute("ventaSel"));
		PagareDTO pagareDTO = new PagareDTO();
		try {
			//TODO: MODIFICADO POR SANTIAGO
			if (ventaSel != null && ventaSel.getNroVenta() != null) {
				pagareDTO = delegate.obtenerDatosPagare(new Long(ventaSel.getNroVenta()));
			}
			else if (numVentaSel != null) {
				pagareDTO = delegate.obtenerDatosPagare(new Long(numVentaSel));
			}

		}
		catch (Exception e) {
			String mensaje = e.getMessage() == null ? "Ocurrio un error al obtener datos pagare " : e.getMessage();
			logger.debug("Exception," + mensaje);
		}
		final String lugar = global.getValorExterno(CLAVE_LUGAR_PAGARE);
		logger.trace("lugar: " + lugar);
		parametros.put("lugar", lugar);
		parametros.put("domicilio", pagareDTO.getGlosaDireccion());
		parametros.put("suscriptor", pagareDTO.getNombreCliente());
		parametros.put("cantidadMoneda", pagareDTO.getDineroLetrasEq() + " con " + pagareDTO.getDecimalLetrasEq());
		parametros.put("cantidadMoneda2", pagareDTO.getDineroLetrasLimSinIva() + " con "
				+ pagareDTO.getDecimalLetrasLimSinIva());
		parametros.put("monto", new Double(pagareDTO.getImp_equipo()));
		parametros.put("monto2", new Double(pagareDTO.getImp_lim()));

		DecimalFormat df = new DecimalFormat();
		StringBuffer mascaraNumero = new StringBuffer();

		mascaraNumero.append(global.getValor("formato.numero.reporte"));
		int decimalesForm = Integer.parseInt(global.getValor("decimales.form"));
		if (decimalesForm > 0) {
			mascaraNumero.append(global.getValor("simbolo.decimal"));
			for (int i = 0; i < decimalesForm; i++) {
				mascaraNumero.append("0");
			}

		}
		logger.debug("formatnumero: " + mascaraNumero);
		df.applyPattern(mascaraNumero.toString());
		parametros.put("mascaraNumeros", df);

		String sRutaReporte = System.getProperty("user.dir") + global.getValorExterno("pagare.reporte");
		File reportFile = new File(sRutaReporte);
		logger.debug("Estado reporte :Existe=" + reportFile.exists() + ", Largo=" + reportFile.length());

		try {
			//JRBeanCollectionDataSource ds = new JRBeanCollectionDataSource(presupuesto);

			byte[] bytes = JasperRunManager.runReportToPdf(reportFile.getPath(), parametros, new JREmptyDataSource());
			response.setContentType("application/pdf");
			response.setContentLength(bytes.length);
			response.setHeader("Content-disposition", "inline; filename=" + "Pagare.pdf");
			ServletOutputStream ouputStream = response.getOutputStream();
			ouputStream.write(bytes, 0, bytes.length);
			ouputStream.flush();
			ouputStream.close();
		}
		catch (JRException e) {
			String mensaje = e.getMessage() == null ? "Ocurrio un error al generar reporte " : e.getMessage();
			logger.debug("JRException," + mensaje);
		}
		logger.info("imprimirPagare, fin");
		return null;
	}
	
	//Inicio P-CSR-11002 JLGN 29-10-2011
	public ActionForward imprimirFactura(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		try{
			logger.info("imprimirFactura, inicio");
			//String numVentaSel = (request.getParameter("numVentaSel") == null ? null : (String) request.getParameter("numVentaSel"));
			HttpSession sesion = request.getSession(false);
			
			VentaAjaxDTO ventaSel = (VentaAjaxDTO) sesion.getAttribute("ventaSel");
			
			String nomFactura = delegate.obtenerNombreFactura(Long.parseLong(ventaSel.getNroVenta()));
			 //Busca largo serie simcard
		    ParametrosGeneralesDTO parametrosGeneralesDTO = new ParametrosGeneralesDTO();
		    parametrosGeneralesDTO.setCodigoproducto("1");
		    parametrosGeneralesDTO.setCodigomodulo("FA");
		    parametrosGeneralesDTO.setNombreparametro(global.getValor("ftp.factura"));
		    parametrosGeneralesDTO = delegate.getParametroGeneral(parametrosGeneralesDTO);
		    String dominioFact = parametrosGeneralesDTO.getValorparametro();		
			
			logger.debug("Setea Valores");
			String sRutaReporte = "ftp://"+dominioFact+"/"+nomFactura;
			logger.debug("Ruta PDF: "+ sRutaReporte);
	
			logger.debug("declaro URL");
			URL url = new URL(sRutaReporte);		
			logger.debug("abro conexion");
			URLConnection connection = url.openConnection();	
			InputStream in = connection.getInputStream(); 
			
			int contentLength = connection.getContentLength();
			ByteArrayOutputStream tmpOut;     
			if (contentLength != -1) {        
				tmpOut = new ByteArrayOutputStream(contentLength);     
			}else {         
				tmpOut = new ByteArrayOutputStream(16384); 
			}		
			byte[] buf = new byte[512];     
			while (true) {         
				int len = in.read(buf);         
				if (len == -1) {             
					break;         
				}         
				tmpOut.write(buf, 0, len);     
			}
			in.close();     
			tmpOut.close();
			byte[] array = tmpOut.toByteArray();	
			response.setContentType("application/pdf");
			response.setContentLength(array.length);
			response.setHeader("Content-disposition", "inline; filename=" + nomFactura);
			ServletOutputStream ouputStream = response.getOutputStream();
			ouputStream.write(array, 0, array.length);
			ouputStream.flush();
			ouputStream.close();
			
		}catch(Exception e){
			String mensaje = e.getMessage() == null ? "Ocurrio un error al generar reporte " : e.getMessage();
			logger.debug("Exception," + mensaje);			
		}
		logger.info("imprimirFactura, fin");
		return null;
	}	
	//Fin P-CSR-11002 JLGN 29-10-2011
	
	//Inicio P-CSR-11002 JLGN 11-11-2011
	public ActionForward imprimirContrato(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		try{
			logger.info("imprimirContrato, inicio");
			HttpSession sesion = request.getSession(false);			
			VentaAjaxDTO ventaSel = (VentaAjaxDTO) sesion.getAttribute("ventaSel");
			byte[] data = null;
			try{
				String rutaContrato = delegate.obtenerRutaContrato(Long.parseLong(ventaSel.getNroVenta()));
			
				String rutaContratoPDF = null;
				rutaContratoPDF = System.getProperty("user.dir")  + rutaContrato;
				logger.debug("rutaContratoPDF: "+ rutaContratoPDF);
				
				InputStream in = new FileInputStream(rutaContratoPDF);
				data = new byte[in.available()];
				in.read(data);
			}catch (Exception e){
				DatosContrato datosContrato = null;
				HashMap params = null; //Parametros para el contrato
				logger.debug("Nº de venta: "+ ventaSel.getNroVenta());
				logger.debug("Se obtiene datos del contrato");
				datosContrato = delegate.obtenerDatosContrato(ventaSel.getNroVenta());
				logger.debug("Se setan los datos de la cabecera del contrato");
				params = delegate.cabeceraContrato(datosContrato);
				logger.debug("Se consulta cuantas lineas tiene el cliente");
				//Se consulta cuantas lineas tiene el cliente
			    if(datosContrato.getLineascontrato().length <= 4){
			    	//Son 4 lineas
			    	logger.debug("Son 4 lineas");
			    	data = delegate.rellenaFormatoContrato(params, datosContrato,0);
			    }else{
					//Son mas de 4 lineas
			    	logger.debug("Son mas de 4 lineas");
			    	data = delegate.formatoContratoAnexo(params, datosContrato,0);
			    }				
			}	
			
			response.setContentType("application/pdf");
			response.setContentLength(data.length);
			response.setHeader("Content-disposition", "inline; filename=" + String.valueOf(ventaSel.getNroVenta()));
			ServletOutputStream ouputStream = response.getOutputStream();
			ouputStream.write(data, 0, data.length);
			ouputStream.flush();
			ouputStream.close();
			
		}catch(Exception e){
			String mensaje = e.getMessage() == null ? "Ocurrio un error al generar contrato " : e.getMessage();
			logger.debug("Exception," + mensaje);			
		}
		logger.info("imprimirContrato, fin");
		return null;
	}	
	//Fin P-CSR-11002 JLGN 11-11-2011
}