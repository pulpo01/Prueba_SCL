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

import com.tmmas.scl.framework.aplicationDomain.dto.UsuarioSistemaDTO;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ControlDTO;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ValoresJSPPorDefectoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.CargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ObtencionCargosDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.Carta10120DTO;
import com.tmmas.scl.operations.crm.fab.cusintman.web.delegate.CambioSerieBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cusintman.web.form.CambioDeSerieForm;
import com.tmmas.scl.operations.crm.fab.customerinterfacemanagement.common.helper.Util;
import com.tmmas.scl.operations.frmkooss.web.businessObject.bo.XMLDefault;
import com.tmmas.scl.operations.frmkooss.web.dto.TablaCargosDTO;
import com.tmmas.scl.operations.frmkooss.web.form.CargosForm;
import com.tmmas.scl.operations.frmkooss.web.form.ResumenForm;
import com.tmmas.scl.operations.frmkooss.web.helper.Global;

public class ResumenAction extends Action {

	private static final String COD_OS_CAMBIO_SERIE = "10270";

	private final Logger logger = Logger.getLogger(ResumenAction.class);

	private Global global = Global.getInstance();

	private CambioSerieBussinessDelegate delegate = CambioSerieBussinessDelegate.getInstance();

	private final String SIGUIENTE = "resumen";

	private final String FACTURA = "factura";

	private static final String REEMPLAZO_CELULAR = "_REEMPLAZO_CELULAR_";

	private static final String REEMPLAZO_SERIE = "_REEMPLAZO_SERIE_";
	
	private static final String CARTA_EN_SESION = "_CARTA_EN_SESION_";

	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession(false);
		ClienteOSSesionDTO sessionData = new ClienteOSSesionDTO();
		sessionData = (ClienteOSSesionDTO) session.getAttribute("ClienteOOSS");
		CargosForm cargosForm = (CargosForm) session.getAttribute("CargosForm");
		CambioDeSerieForm cambioDeSerieForm = (CambioDeSerieForm) session.getAttribute("CambioDeSerieForm");

		String[] presupuesto = (String[]) session.getAttribute("totalesPresupuesto");

		String vaACargos = "XXX";
		/*
		 * if(session.getAttribute("paramCargosUsoOOSS")!=null){ vaACargos
		 * =((ParamObtCargOOSSDTO)
		 * session.getAttribute("paramCargosUsoOOSS")).getSinCondicionesComerciales(); }
		 */

		vaACargos = sessionData.getSinCondicionesComerciales(); // GS

		String log = global.getValor("web.log");
		log = System.getProperty("user.dir") + log;
		PropertyConfigurator.configure(log);
		logger.debug("execute():start");
		XMLDefault objetoXML = new XMLDefault();
		ValoresJSPPorDefectoDTO objetoXMLSession = new ValoresJSPPorDefectoDTO();
		session.setAttribute("ultimaPagina", "Resumen");

		// ResumenForm resumenForm = (ResumenForm)form;
		String textoCarta = null;

		// Se procede a realizar el cierre de la venta

		Carta10120DTO carta = new Carta10120DTO();
		carta.setCodOOSS(COD_OS_CAMBIO_SERIE);
		Long numAbo = new Long(String.valueOf(sessionData.getNumAbonado()));
		carta.setNum_abonado(numAbo);
		carta.setTexCarta("");
		textoCarta = delegate.obtenerTextoCarta(carta).getTexCarta();
		logger.debug("textoCarta [" + textoCarta + "]");

		/**
		 * @author JIB
		 * 
		 * Incidencia 155633: En la parte del texto donde pone el número de
		 * celular pone otro número.
		 * 
		 * Se corrige lógica de reemplazo de strings en texto carta.
		 * 
		 */

		/*
		 * textoCarta = textoCarta.replaceAll("1",
		 * String.valueOf(sessionData.getAbonados()[0].getNumCelular()));
		 * textoCarta = textoCarta.replaceAll("2",
		 * cambioDeSerieForm.getNroSerieSim().equals("") ? cambioDeSerieForm
		 * .getNroSerieEquip() : cambioDeSerieForm.getNroSerieSim());
		 */

		final String numCelular = String.valueOf(sessionData.getAbonados()[0].getNumCelular());
		logger.debug("numCelular [" + numCelular + "]");
		final String numSerie = cambioDeSerieForm.getNroSerieSim().equals("") ? cambioDeSerieForm.getNroSerieEquip()
				: cambioDeSerieForm.getNroSerieSim();
		logger.debug("numSerie [" + numSerie + "]");

		textoCarta = textoCarta.replaceAll("1", REEMPLAZO_CELULAR);
		logger.debug("textoCarta [" + textoCarta + "]");
		textoCarta = textoCarta.replaceAll("2", REEMPLAZO_SERIE);
		logger.debug("textoCarta [" + textoCarta + "]");
		textoCarta = textoCarta.replaceAll(REEMPLAZO_CELULAR, numCelular);
		logger.debug("textoCarta [" + textoCarta + "]");
		textoCarta = textoCarta.replaceAll(REEMPLAZO_SERIE, numSerie);
		logger.debug("textoCarta [" + textoCarta + "]");

		// textoCarta = textoCarta.replace("1",""+);

		/*
		 * textoCarta = textoCarta.concat("\n\n> ACTIVACION"); if
		 * (session.getAttribute("textoContratados").toString().trim().length() >
		 * 0) textoCarta =
		 * textoCarta.concat(session.getAttribute("textoContratados").toString());
		 * else textoCarta = textoCarta.concat("\nNo han sido solicitados.");
		 * 
		 * textoCarta = textoCarta.concat("\n\n> DESACTIVACION"); if
		 * (session.getAttribute("textoNoContratados").toString().trim().length() >
		 * 0) textoCarta =
		 * textoCarta.concat(session.getAttribute("textoNoContratados").toString());
		 * else textoCarta = textoCarta.concat("\nNo han sido solicitados.");
		 */

		carta.setTexCarta(textoCarta);
		logger.debug(textoCarta);
		
		logger.debug("Almacena carta en sesión, inicio");
		carta.setCodOOSS(COD_OS_CAMBIO_SERIE);
		session.setAttribute(CARTA_EN_SESION, carta);
		logger.debug("Almacena carta en sesión, fin");

		// Flujo
		String botonSeleccionado = null;
		String paginaOrigen = " ";
		if (session.getAttribute("desde") != null) {
			paginaOrigen = (String) session.getAttribute("desde");
		}
		if (form instanceof ResumenForm) {
			session.setAttribute("desde", "resumen");
			botonSeleccionado = ((ResumenForm) form).getBtnSeleccionado();
			ResumenForm b = (ResumenForm) form;
			b.setBtnSeleccionado(null);
			session.setAttribute("ResumenForm", b);
		}

		if (!paginaOrigen.equals("registrar")) {

			if (botonSeleccionado != null && botonSeleccionado.equalsIgnoreCase("registrarOS")) {
				return mapping.findForward("registrarOS");
			}
		}
		else if (paginaOrigen.equals("registrar")) {
			/*------------------Aceptar presupuesto-----------------*/

			if (cargosForm != null && cargosForm.getRbCiclo().equalsIgnoreCase("NO")) {
				// PresupuestoForm presupuestoForm = new PresupuestoForm();
				if (session.getAttribute("PresupuestoForm") != null) {
					/*
					 * presupuestoForm =
					 * (PresupuestoForm)session.getAttribute("PresupuestoForm");
					 * 
					 * String codTipoDocumento =
					 * cargosForm.getCbTipoDocumento(); String tipoFoliacion = " ";
					 * 
					 * //busca tipo foliacion: List listaTiposDoc =
					 * cargosForm.getDocumentosList(); if (listaTiposDoc!=
					 * null){ Iterator ite = listaTiposDoc.iterator(); while
					 * (ite.hasNext()) { DocumentoDTO doc =
					 * (DocumentoDTO)ite.next(); if
					 * (doc.getCodigo().equals(codTipoDocumento)){ tipoFoliacion =
					 * doc.getTipoFoliacion(); break; } } }
					 * 
					 * PresupuestoDTO presup = new PresupuestoDTO();
					 * presup.setNumVenta(cargosForm.getNumVenta());
					 * presup.setNumProceso(presupuestoForm.getNumProceso());
					 * presup.setTipoFoliacion(tipoFoliacion);
					 * logger.debug("aceptarPresupuesto:antes");
					 * delegate.aceptarPresupuesto(presup);
					 * 
					 * logger.debug("aceptarPresupuesto:despues");
					 * session.removeAttribute("PresupuestoForm");
					 */

					return mapping.findForward(FACTURA);
				}
			}
			else {
				presupuesto = null;
			}

			// fin rbCiclo = NO
			/*------------------Fin Aceptar presupuesto-----------------*/
		}

		if (botonSeleccionado != null && botonSeleccionado.equalsIgnoreCase("anterior")) {
			/*******************************************************************
			 * @author rlozano
			 * @description Por si "retrocedio ejecuto cargos NO a ciclo y luego
			 *              retrocedio ejecuto cargos SI a ciclo""
			 */
			presupuesto = null;
			if ((vaACargos != null && vaACargos.equalsIgnoreCase("SI"))
					|| (sessionData.getObtenerCargos() != null && sessionData.getObtenerCargos().equalsIgnoreCase("NO"))) {
				logger.debug("SIN CARGOS DIRECTO A INICIO");
				session.setAttribute("ultimaPagina", "");
				return mapping.findForward("inicio");
			}
			else {
				cargosForm.setBotonSeleccionado(botonSeleccionado);
				logger.debug("CON CARGOS A CARGOS");
				return mapping.findForward("cargosAction");
			}
		}
		String nivel;
		if (sessionData.getCodCliente() != 0) {
			nivel = "Cliente";
		}
		else {
			nivel = "Abonado";
		}

		String nombreCliente;
		if (sessionData.getCliente().getNombreCompleto() != null) {
			nombreCliente = sessionData.getCliente().getNombreCompleto();
		}
		else {
			nombreCliente = sessionData.getCliente().getNombres();
		}

		if (botonSeleccionado != null && botonSeleccionado.equals("visualizar")) {
			Map parametros = new HashMap();
			if (String.valueOf(sessionData.getNumOrdenServicio()) != null)
				parametros.put("Folio", String.valueOf(sessionData.getNumOrdenServicio()));
			else
				parametros.put("Folio", "111");

			UsuarioSistemaDTO usuarioSistema = new UsuarioSistemaDTO();
			usuarioSistema = (UsuarioSistemaDTO) session.getAttribute("usuarioSistema");
			String NomVendedor = usuarioSistema.getNom_operador();
			NomVendedor = (NomVendedor == null || "".equals(NomVendedor)) ? "Telefónica Móviles" : NomVendedor;
			String DesComuna = usuarioSistema.getDes_comuna();
			DesComuna = DesComuna == null || "".equals(DesComuna) ? "" : DesComuna;

			String DesOficina = usuarioSistema.getDes_ofician();
			DesOficina = DesOficina == null || "".equals(DesOficina) ? "Oficina" : DesOficina;

			parametros.put("Nivel", nivel);
			parametros.put("Codigo", "" + String.valueOf(sessionData.getNumAbonado()));
			parametros.put("Referencia", "CAMBIO DE SERIE");
			parametros.put("NomCliente", nombreCliente);
			parametros.put("TextCarta", textoCarta);
			parametros.put("NomVendedor", NomVendedor);
			parametros.put("DesComuna", DesComuna);
			parametros.put("DesOficina", DesOficina);
			
			String rutaReporte = System.getProperty("user.dir") + global.getValor("ruta.reportes")
					+ global.getValor("reporte.carta");
			File reportFile = new File(rutaReporte);
			logger.debug("Estado reporte :Existe=" + reportFile.exists() + ", Largo=" + reportFile.length());
			byte[] bytes = JasperRunManager.runReportToPdf(reportFile.getPath(), parametros, new JREmptyDataSource());
			logger.debug("bytes=" + bytes);
			response.setContentType("application/pdf");
			response.setContentLength(bytes.length);
			response.setHeader("Content-disposition", "attachment; filename=" + "Factura.pdf");
			ServletOutputStream ouputStream = response.getOutputStream();
			ouputStream.write(bytes, 0, bytes.length);
			ouputStream.flush();
			ouputStream.close();
			

		}

		TablaCargosDTO[] tablaCargosDTO = null;
		ControlDTO control = new ControlDTO();
		sessionData = (ClienteOSSesionDTO) session.getAttribute("ClienteOOSS");
		objetoXMLSession = sessionData.getDefaultPagina();
		control = objetoXML.obtenerControl(objetoXMLSession, "resumenPAG", "Comentarios", "comentariosTXA");
		sessionData.setComentarioOS(control.getValorDefecto());
		session.removeAttribute("ClienteOOSS");
		session.setAttribute("ClienteOOSS", sessionData);
		String numDecimales = (String) session.getAttribute("numDecimalesFormulario");
		List cargos = new ArrayList();
		if (cargosForm != null) {
			if ("SI".equals(sessionData.getSinCondicionesComerciales())) {
				cargosForm.setCargosSeleccionados(cargosForm.getCargosMerge());
				// cargosForm.setTotal(Util.formatearNumeroMoneda(cargosForm.getTotal(),numDecimales));
			}
			tablaCargosDTO = cargosForm.getTablaCargos();

			if (tablaCargosDTO != null) {
				for (int i = 0; i < tablaCargosDTO.length; i++) {
					if (aplicaCargo(tablaCargosDTO[i].getCodConcepto(), cargosForm)) {
						String saldo = tablaCargosDTO[i].getSaldo();
						saldo = Util.formatearNumeroMoneda(saldo, numDecimales);
						tablaCargosDTO[i].setSaldo(saldo);
						cargos.add(tablaCargosDTO[i]);
					}
				}
				TablaCargosDTO tablaImpuesto = new TablaCargosDTO();
				tablaImpuesto.setDescripcion("IMPUESTOS");
				boolean isExistPresupuesto = presupuesto == null ? false : true;
				String totalImpuesto = isExistPresupuesto ? presupuesto[1] : "0.0";
				// totalImpuesto=Util.formatearNumeroMoneda(totalImpuesto,numDecimales);
				tablaImpuesto.setSaldo(totalImpuesto);

				cargos.add(tablaImpuesto);
				String totalCargos = isExistPresupuesto ? presupuesto[3] : cargosForm.getTotal();
				if (isExistPresupuesto) {
					// totalCargos=Util.formatearNumeroMoneda(totalCargos,numDecimales);
				}
				cargosForm.setTotal(totalCargos);
				TablaCargosDTO[] cargosAprobados = new TablaCargosDTO[cargos.size()];
				for (int a = 0; a < cargos.size(); a++) {
					cargosAprobados[a] = (TablaCargosDTO) cargos.get(a);
				}
				tablaCargosDTO = cargosAprobados;
			}
			if (cargosForm != null && cargosForm.getRbCiclo().equalsIgnoreCase("SI")) {
				boolean existCargosSeleccionados = cargosForm.getCargosSeleccionados() != null
						&& cargosForm.getCargosSeleccionados().getCargos() != null
						&& cargosForm.getCargosSeleccionados().getCargos().length > 0 ? true : false;
				if (existCargosSeleccionados) {
					CargosDTO[] cargosList = cargosForm.getCargosSeleccionados().getCargos();
					float totalACiclo = 0;
					float descuentos = 0;
					for (int i = 0; i < cargosList.length; i++) {
						totalACiclo = totalACiclo + cargosList[i].getPrecio().getMonto();
						DescuentoDTO[] descuento = cargosList[i].getDescuento();
						if (descuento != null && descuento.length > 0) {
							for (int j = 0; j < descuento.length; j++) {
								descuentos = descuento[j].getMonto() + descuentos;
							}
						}
					}
					// totalACiclo=totalACiclo-descuentos;
					// cargosForm.setTotal(Float.toString(totalACiclo));
				}
			}
		}
		session.setAttribute("listCargos", tablaCargosDTO);
		logger.debug("execute():end");
		return mapping.findForward(SIGUIENTE);
	}

	private boolean aplicaCargo(String codConcepto, CargosForm cargosForm) {
		// TablaCargosDTO[] tablaCargos = cargosForm.getTablaCargos();
		ObtencionCargosDTO cargosSelecionados = cargosForm.getCargosSeleccionados();
		String codConceptoCargo = null;
		boolean retValue = false;
		if (cargosSelecionados != null && cargosSelecionados.getCargos() != null) {
			CargosDTO[] cargos = cargosSelecionados.getCargos();
			for (int i = 0; i < cargos.length; i++) {
				codConceptoCargo = cargos[i].getPrecio().getCodigoConcepto();
				if (codConcepto.equals(codConceptoCargo)) {
					retValue = true;
				}
			}
		}
		return retValue;
		/*
		 * TablaCargosDTO[] tablaCargos = cargosForm.getTablaCargos(); String
		 * checks[] = cargosForm.getSelectedValorCheck();
		 * if(tablaCargos!=null&&tablaCargos.length>0){
		 * if(checks!=null&&checks.length>0){ for(int x = 0;x<checks.length;x++){
		 * for(int i = 0 ; i<tablaCargos.length; i++){
		 * if(checks[i].equalsIgnoreCase(tablaCargos[x].getValorCheck())){
		 * return true; } } } }else{ return false; } }else{ return false; }
		 * return false;
		 */
	}

}
