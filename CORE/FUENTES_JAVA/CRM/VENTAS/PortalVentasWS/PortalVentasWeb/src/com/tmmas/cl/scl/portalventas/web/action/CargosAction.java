package com.tmmas.cl.scl.portalventas.web.action;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;
import java.rmi.RemoteException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto.CabeceraArchivoDTO;
import com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto.DetallePresupuestoDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.CargoXMLDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ParametrosGlobalesDTO;
import com.tmmas.cl.scl.commonbusinessentities.interfaz.TipoDescuentos;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CargoSolicitudDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.DetalleInformePresupuestoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ImpuestosDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.InformePresupuestoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ListadoCargoSolicitudDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosGeneralesDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.VentasException;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.AbonadoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.DatosAnexoTerminalesDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.DatosContrato;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.DatosGeneralesDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.GaVentasDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.VendedorDTO;
import com.tmmas.cl.scl.portalventas.web.delegate.PortalVentasDelegate;
import com.tmmas.cl.scl.portalventas.web.dto.ResultadoVentaDTO;
import com.tmmas.cl.scl.portalventas.web.dto.VentaAjaxDTO;
import com.tmmas.cl.scl.portalventas.web.form.CargosForm;
import com.tmmas.cl.scl.portalventas.web.helper.Global;
import com.tmmas.cl.scl.portalventas.web.helper.TraspasoXMLDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.PlanTarifarioDTO;

public class CargosAction extends DispatchAction {
	private final Logger logger = Logger.getLogger(CargosAction.class);

	private Global global = Global.getInstance();

	PortalVentasDelegate delegate = PortalVentasDelegate.getInstance();

	final static String CLAVE_PREACT_LIN_XDEFECTO = "preact.lineas.ppto.cliente.prepago.pordefecto";

	final static String CLAVE_POSACT_LIN_XDEFECTO = "preact.lineas.ppto.cliente.pospago.pordefecto";

	public ActionForward inicio(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.info("inicio, inicio");
		CargosForm cargosForm = (CargosForm) form;
		HttpSession sesion = request.getSession(false);

		// obtener info de la venta
		VentaAjaxDTO ventaSel = (VentaAjaxDTO) sesion.getAttribute("ventaSel");

		// obtener info del vendedor
		VendedorDTO vendedor = new VendedorDTO();
		vendedor.setCodigoVendedor(ventaSel.getCodVendedor());
		String user = ((ParametrosGlobalesDTO) sesion
				.getAttribute("paramGlobal")).getCodUsuario();
		vendedor.setNombreVendedor(user);
		vendedor = delegate.getRangoDescuento(vendedor);

		// informacion para descuentos
		cargosForm.setTxtMaximoDcto(vendedor.getPuntoDesctoSuperior());
		cargosForm.setTxtMinimoDcto(vendedor.getPuntoDesctoInferior());
		cargosForm.setTxtPorcMaximoDcto(vendedor.getPorcentajeDesctoSuperior());
		cargosForm.setTxtPorcMinimoDcto(vendedor.getPorcentajeDesctoInferior());
		cargosForm.setTxtParamDecForm(Integer.parseInt(global
				.getValor("decimales.form")));
		cargosForm.setTxtParamDecBD(Integer.parseInt(global
				.getValor("decimales.bd")));

		// obtener cargos
		CargoSolicitudDTO cargoSolicitudDTO = new CargoSolicitudDTO();
		cargoSolicitudDTO.setNumVenta(Long.parseLong(ventaSel.getNroVenta()));
		cargoSolicitudDTO.setCodOficina(ventaSel.getCodOficina());
		cargoSolicitudDTO.setCodTipoContrato(ventaSel.getCodTipoContrato());
		cargoSolicitudDTO.setCodVendedor(Long.parseLong(ventaSel
				.getCodVendedor()));
		cargoSolicitudDTO.setCodCuota(ventaSel.getCodCuota());
		cargoSolicitudDTO.setCodCliente(Long.valueOf(ventaSel.getCodCliente())
				.longValue());
		cargoSolicitudDTO.setNumTransaccionVenta(ventaSel
				.getNumTransaccionVenta());
		final String codTipoCliente = ventaSel.getCodTipoCliente().trim();
		cargoSolicitudDTO.setCodTipoCliente(codTipoCliente);
		cargoSolicitudDTO.setNombreUsuario(((ParametrosGlobalesDTO) sesion
				.getAttribute("paramGlobal")).getCodUsuario());
		cargoSolicitudDTO.setIndOfiter(ventaSel.getIndOfiter());
		cargoSolicitudDTO.setCodModalidadVenta(Integer.parseInt(ventaSel
				.getCodModVenta()));

		CargoSolicitudDTO[] listadoCargosSol = null;

		try {
			listadoCargosSol = delegate.getCargosVta(cargoSolicitudDTO);
		} catch (VentasException e) {
			String mensaje = e.getDescripcionEvento() == null ? "Ocurrio un error al grabar cargos "
					: e.getDescripcionEvento();
			request.setAttribute("mensajeError", mensaje);
			logger.debug("VentasException=" + mensaje);
		} catch (Exception e) {
			String mensaje = e.getMessage() == null ? "Ocurrio un error al grabar cargos "
					: e.getMessage();
			request.setAttribute("mensajeError", mensaje);
			logger.debug("Exception=" + mensaje);
		}

		/* cargar cargos y calcular total */
		if (listadoCargosSol == null)
			listadoCargosSol = new CargoSolicitudDTO[0];
		CargoXMLDTO[] listadoCargos = new CargoXMLDTO[listadoCargosSol.length];

		for (int i = 0; i < listadoCargosSol.length; i++) {
			CargoXMLDTO cargoDTO = new CargoXMLDTO();
			cargoDTO.setNumCargo(listadoCargosSol[i].getNumCargo());
			cargoDTO.setDescripcionConceptoPrecio(listadoCargosSol[i]
					.getDesConcepto());
			cargoDTO.setCodigoConceptoPrecio(String.valueOf(listadoCargosSol[i]
					.getCodConcepto()));
			cargoDTO.setCodigoDescuento(String.valueOf(listadoCargosSol[i]
					.getCodConceptoDcto()));
			cargoDTO.setMontoConceptoPrecio(listadoCargosSol[i].getImpCargo());
			cargoDTO.setCantidad(Integer.parseInt(String
					.valueOf(listadoCargosSol[i].getNumUnidades())));
			cargoDTO.setTipoDescuento(String.valueOf(listadoCargosSol[i]
					.getTipDcto()));
			cargoDTO.setMontoDescuento(listadoCargosSol[i].getValDcto());
			cargoDTO.setCodigoMoneda(listadoCargosSol[i].getCodMoneda());
			cargoDTO.setDescripcionMoneda(listadoCargosSol[i].getDesMoneda());
			cargoDTO.setMontoDescuentoSinImpuesto(listadoCargosSol[i]
					.getValDctoSinImpuesto());
			listadoCargos[i] = cargoDTO;
		}

		double totalPagar = 0;

		// DetalleLineaSolicitudDTO[] listaLineasOverride =
		// (DetalleLineaSolicitudDTO[]) request.getSession()
		// .getAttribute("arrayLineasSol");
		// if (listaLineasOverride != null && listaLineasOverride.length > 0) {
		// for (int i = 0; i < listaLineasOverride.length; i++) {
		// DetalleLineaSolicitudDTO solicitudDTO = listaLineasOverride[i];
		// for (int j = 0; j < solicitudDTO.getCargosRecurrentes().length; j++)
		// {
		// DetalleCargosSolicitudDTO detalleCargosSolicitudDTO =
		// solicitudDTO.getCargosRecurrentes()[j];
		// logger.debug(detalleCargosSolicitudDTO.toString());
		// }
		// }
		// }

		for (int i = 0; i < listadoCargos.length; i++) {
			CargoXMLDTO cargo = listadoCargos[i];
			if (cargo.getTipoDescuento() != null
					&& cargo.getTipoDescuento().equals(
							String.valueOf(TipoDescuentos.Porcentaje)))
				cargo.setMontoDescuento(cargo.getMontoDescuento());
			else
				cargo.setMontoDescuento(cargo.getMontoDescuento()
						* cargo.getCantidad());
			cargo.setMontoDescuentoManual(cargo.getMontoDescuentoManual()
					* cargo.getCantidad());
			cargo.setMontoConceptoTotal(cargo.getMontoConceptoPrecio()
					* cargo.getCantidad());

			if (cargo.getTipoDescuento() != null
					&& cargo.getTipoDescuento().equals(
							String.valueOf(TipoDescuentos.Porcentaje)))
				cargo.setSaldoTotal(cargo.getMontoConceptoTotal()
						- (((cargo.getMontoConceptoPrecio() * (cargo
								.getMontoDescuento() / 100)) * cargo
								.getCantidad()) + cargo
								.getMontoDescuentoManual()));
			else
				cargo.setSaldoTotal(cargo.getMontoConceptoTotal()
						- (cargo.getMontoDescuento() + cargo
								.getMontoDescuentoManual()));

			// Habilita descuento en caso que el vendedor tenga permiso para
			// descuento
			if (vendedor.isAplicaDescuento() && cargo.getSaldoTotal() > 0) {
				cargo.setHabilitaDescuento(true);
			} else {
				cargo.setHabilitaDescuento(false);
			}
			totalPagar = totalPagar + cargo.getSaldoTotal();
		}
		/*----------------------------------------*/

		cargosForm.setCargoSeleccionado("0");// ??
		cargosForm.setNumeroCargos(listadoCargos.length);
		cargosForm.setTotal(String.valueOf(totalPagar));
		sesion.setAttribute("Cargos", listadoCargos);
		logger.debug("numeroCargos" + cargosForm.getNumeroCargos());
		logger.debug("Aplica Descuento Vendedor: "
				+ vendedor.isAplicaDescuento());
		cargosForm.setCodOperadora(delegate.getCodigoOperadora());
		cargosForm.setCodOperadoraSalvador(global
				.getValor("codigo.operadora.salvador"));
		
		//parametro prepago
		final String codTipoClientePrepago = global.getValor(
				"tipo.cliente.prepago").trim();
		cargosForm.setCodTipoClientePrepago(codTipoClientePrepago);
		cargosForm.setCodTipoCliente(codTipoCliente);
		
		//Inicio Inc. 185714 JLGN 25-06-2012
		if(codTipoClientePrepago.equals(codTipoCliente)) {
			DatosGeneralesDTO datosGenerales = new DatosGeneralesDTO();
			datosGenerales.setCodigoModulo(global.getValor("codigo.modulo.VE"));
			datosGenerales.setTabla(global.getValor("tabla.activacion.prepago"));
			datosGenerales.setColumna(global.getValor("columna.activacion.prepago"));
			DatosGeneralesDTO[] arrayActivacionLinea = delegate.getListCodigo(datosGenerales);
			cargosForm.setActivacionLineaDTO(arrayActivacionLinea);
		}else{
		//Arreglo Activacion linea 
			DatosGeneralesDTO datosGenerales = new DatosGeneralesDTO();
			datosGenerales.setCodigoModulo(global.getValor("codigo.modulo.VE"));
			datosGenerales.setTabla(global.getValor("tabla.activacion"));
			datosGenerales.setColumna(global.getValor("columna.activacion"));
			DatosGeneralesDTO[] arrayActivacionLinea = delegate.getListCodigo(datosGenerales);
			cargosForm.setActivacionLineaDTO(arrayActivacionLinea);
		}	
		//Fin Inc. 185714 JLGN 25-06-2012

		// Incidencia 134089. Combobox de preactivacion debe quedar solo lectura
		// y con valor SI
		// en venta prepago, cuando existe el parámetro. Aplica a TMS y TMG.
		logger.trace("codTipoClientePrepago [" + codTipoClientePrepago + "]");
		logger.trace("codTipoCliente [" + codTipoCliente + "]");
		if (codTipoClientePrepago.equals(codTipoCliente)) {
			final String valorPreactLineasPorDefecto = global
					.getValorExterno(CLAVE_PREACT_LIN_XDEFECTO);
			logger
					.trace("preact.lineas.ppto.cliente.prepago.pordefecto (properties externo) ["
							+ valorPreactLineasPorDefecto + "]");
			if (valorPreactLineasPorDefecto != null
					&& valorPreactLineasPorDefecto.equals("SI")) {
				cargosForm.setPreactivacion("S");
				cargosForm.setPreactivacionSoloLectura("SI");
			} else {
				cargosForm.setPreactivacion("N");
				cargosForm.setPreactivacionSoloLectura("NO");
			}
		}// Inicio P-CSR-11002 JLGN 15-06-2011
		else {
			final String valorPreactLineasPorDefecto = global
					.getValorExterno(CLAVE_POSACT_LIN_XDEFECTO);
			logger
					.trace("preact.lineas.ppto.cliente.pospago.pordefecto (properties externo) ["
							+ valorPreactLineasPorDefecto + "]");
			if (valorPreactLineasPorDefecto != null
					&& valorPreactLineasPorDefecto.equals("SI")) {
				cargosForm.setPreactivacion("S");
				cargosForm.setPreactivacionSoloLectura("SI");
			}
		}// Fin P-CSR-11002 JLGN 15-06-2011

		logger.info("inicio, fin");
		return mapping.findForward("inicio");
	}

	public ActionForward grabarCargos(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.info("grabarCargos, inicio");
		CargosForm cargosForm = (CargosForm) form;
		HttpSession sesion = request.getSession(false);
		TraspasoXMLDTO manejoXML = new TraspasoXMLDTO();
		CargoXMLDTO[] cargos = null;
		try {
			cargos = manejoXML.retornaCamposDetalleFormatoSalidaXML(cargosForm
					.getTextoXML());
		} catch (Exception e) {
			logger.debug("No existen cargos");
		}
		// obtener info de la venta
		VentaAjaxDTO ventaSel = (VentaAjaxDTO) sesion.getAttribute("ventaSel");
		long numVenta = Long.parseLong(ventaSel.getNroVenta());
		long codCliente = Long.parseLong(ventaSel.getCodCliente());
		long numTransaccionVenta = ventaSel.getNumTransaccionVenta();
		try {
			ListadoCargoSolicitudDTO listaCargos = new ListadoCargoSolicitudDTO();
			int totalListaCargos = 0;
			if (cargos != null) {
				totalListaCargos = cargos.length;
			}
			CargoSolicitudDTO[] cargosSol = new CargoSolicitudDTO[totalListaCargos];
			for (int i = 0; i < totalListaCargos; i++) {
				CargoSolicitudDTO cargoSolicitudDTO = new CargoSolicitudDTO();
				cargoSolicitudDTO.setNumCargo(cargos[i].getNumCargo());
				cargoSolicitudDTO.setCantidad(cargos[i].getCantidad());
				cargoSolicitudDTO.setCantidadManual(cargos[i].getCantidad());
				cargoSolicitudDTO.setTipDcto(Integer.parseInt(cargos[i]
						.getTipoDescuento())); // Automatico
				cargoSolicitudDTO.setValDcto(cargos[i].getMontoDescuento()); // Automatico
				cargoSolicitudDTO.setValDctoSinImpuesto(cargos[i]
						.getMontoDescuentoSinImpuesto()); // Automatico
				cargoSolicitudDTO.setTipDctoManual(Integer.parseInt(cargos[i]
						.getTipoDescuentoManual()));// Manual
				cargoSolicitudDTO.setValDctoManual(cargos[i]
						.getMontoDescuentoManual());// Manual
				cargoSolicitudDTO.setNumTransaccionVenta(numTransaccionVenta);
				cargoSolicitudDTO.setCodOficina(ventaSel.getCodOficina());
				cargoSolicitudDTO.setCodTipoDocumento(ventaSel
						.getCodTipoDocumento());
				cargoSolicitudDTO.setCodModalidadVenta(Integer
						.parseInt(ventaSel.getCodModVenta()));
				cargoSolicitudDTO.setCodConcepto(Long.parseLong(cargos[i]
						.getCodigoConceptoPrecio()));
				cargoSolicitudDTO.setImpCargo(cargos[i]
						.getMontoConceptoPrecio());
				cargosSol[i] = cargoSolicitudDTO;
			}
			listaCargos.setNumVenta(numVenta);
			listaCargos.setCodCliente(codCliente);
			listaCargos.setCargos(cargosSol);
			listaCargos.setNumTransaccionVta(numTransaccionVenta);
			listaCargos.setCodOficina(ventaSel.getCodOficina());
			listaCargos.setCodModVenta(ventaSel.getCodModVenta());
			listaCargos.setCodTipoDocumento(new Integer(ventaSel
					.getCodTipoDocumento()).toString());
			ImpuestosDTO datosPresupuesto = delegate
					.actualizarDsctosManuales(listaCargos);
			CabeceraArchivoDTO cabecera = new CabeceraArchivoDTO();
			cabecera.setTotalDescuentosVenta(datosPresupuesto
					.getTotalDescuentos());
			logger.debug("datosPresupuesto.getTotalCargos():"
					+ datosPresupuesto.getTotalCargos());
			logger.debug("datosPresupuesto.getTotalImpuestos():"
					+ datosPresupuesto.getTotalImpuestos());
			logger.debug("datosPresupuesto.getTotalDescuentos():"
					+ datosPresupuesto.getTotalDescuentos());

			double totalCargos = 0;
			double totalImpuestos = 0;
			double total = 0;
			if (cargosForm.getCodOperadora().equals(
					cargosForm.getCodOperadoraSalvador())) {
				totalCargos = datosPresupuesto.getTotalCargos();
				totalImpuestos = datosPresupuesto.getTotalImpuestos();
				total = totalCargos + totalImpuestos
						+ datosPresupuesto.getTotalDescuentos();
			} else {
				totalCargos = datosPresupuesto.getTotalCargos();
				totalImpuestos = 0;
				total = totalCargos + totalImpuestos
						+ datosPresupuesto.getTotalDescuentos();
			}
			cabecera.setTotalCargosVenta(totalCargos);
			cabecera.setTotalImpuestoVenta(totalImpuestos);
			cabecera.setTotalPresupuestoVenta(total);
			cabecera.setNumeroProcesoFacturacion(datosPresupuesto
					.getNumeroProceso());
			cabecera.setCategoriaTributaria(datosPresupuesto
					.getCategoriaTributaria());
			cabecera.setEsVentaRegalo(datosPresupuesto.getEsVentaRegalo());

			double totalImporteDetalle = 0;
			double totalImpuestosDetalle = 0;
			double totalDescuentosDetalle = 0;
			double totalDetalle = 0;
			if (totalListaCargos > 0) {
				final DetalleInformePresupuestoDTO[] detalles = delegate
						.obtenerDetallePresupuesto(new Long(numVenta));
				for (int i = 0; i < detalles.length; i++) {
					DetalleInformePresupuestoDTO detalle = detalles[i];
					totalImporteDetalle += detalle.getCargos();
					totalImpuestosDetalle += detalle.getImpuestos();
					totalDescuentosDetalle += detalle.getDescuentos();
					totalDetalle += detalle.getTotal();

				}
			}

			cabecera.setTotalCargosVenta(totalImporteDetalle);
			cabecera.setTotalDescuentosVenta(totalDescuentosDetalle);
			cabecera.setTotalImpuestoVenta(totalImpuestosDetalle);
			cabecera.setTotalPresupuestoVenta(totalDetalle);
			logger.debug("cabecera.getTotalCargosVenta() ["
					+ cabecera.getTotalCargosVenta() + "]");
			logger.debug("cabecera.getTotalDescuentosVenta() ["
					+ cabecera.getTotalDescuentosVenta() + "]");
			logger.debug("cabecera.getTotalImpuestoVenta() ["
					+ cabecera.getTotalImpuestoVenta() + "]");
			logger.debug("cabecera.getTotalPresupuestoVenta() ["
					+ cabecera.getTotalPresupuestoVenta() + "]");

			sesion.removeAttribute("cabeceraDTO");
			sesion.setAttribute("cabeceraDTO", cabecera);
			/** **********Distribucion de bolsa inicio********* */
			String puedeDistribuir = existenPlanesTarifarios(ventaSel
					.getNroVenta());
			sesion.removeAttribute("planes");
			request.setAttribute("puedeDistribuir", puedeDistribuir);
			/** **********Distribucion de bolsa fin*********** */
		} catch (VentasException e) {
			String mensaje = e.getDescripcionEvento() == null ? "Ocurrio un error al grabar cargos "
					: e.getDescripcionEvento();
			request.setAttribute("mensajeError", mensaje);
			logger.debug("VentasException=" + mensaje);
			return mapping.findForward("inicio");
		} catch (Exception e) {
			String mensaje = e.getMessage() == null ? "Ocurrio un error al grabar cargos "
					: e.getMessage();
			request.setAttribute("mensajeError", mensaje);
			logger.debug("Exception=" + mensaje);
			return mapping.findForward("inicio");
		}
		logger.info("grabarCargos, fin");
		return mapping.findForward("mostrarPresupuesto");
	}

	public ActionForward imprimirPresupuesto(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		logger.info("imprimirPresupuesto, inicio");
		HttpSession sesion = request.getSession(false);

		Map parametros = new HashMap();
		InformePresupuestoDTO informePresupuesto = new InformePresupuestoDTO();
		CabeceraArchivoDTO resumenPresupuesto = (CabeceraArchivoDTO) sesion
				.getAttribute("cabeceraDTO");

		VentaAjaxDTO datosVenta = (VentaAjaxDTO) sesion
				.getAttribute("ventaSel");

		informePresupuesto.setNumeroVenta((new Long(datosVenta.getNroVenta()))
				.longValue());
		informePresupuesto.setNumeroProcesoFacturacion(resumenPresupuesto
				.getNumeroProcesoFacturacion());
		informePresupuesto.setCodigoCliente(datosVenta.getCodCliente());
		informePresupuesto.setCodigoTipoContrato(datosVenta
				.getCodTipoContrato());
		informePresupuesto.setCodigoModalidadVenta(datosVenta.getCodModVenta());
		informePresupuesto = delegate
				.obtenerInformePresupuesto(informePresupuesto);

		parametros.put("codigoCliente", datosVenta.getCodCliente());
		parametros.put("nombreVendedor", datosVenta.getNombreVendedor());
		parametros.put("nombreDealer", datosVenta.getNombreDealer());
		parametros.put("nombreCliente", datosVenta.getNombreCliente());
		parametros.put("codigoCliente", datosVenta.getCodCliente());
		parametros.put("importeBase", new Double(resumenPresupuesto
				.getTotalCargosVenta()));
		parametros.put("impuestos", new Double(resumenPresupuesto
				.getTotalImpuestoVenta()));
		parametros.put("descuentos", new Double(resumenPresupuesto
				.getTotalDescuentosVenta()
				* -1));
		parametros.put("tipoContrato", informePresupuesto
				.getDescripcionTipoContrato());
		parametros.put("descripcionModalidadVenta", informePresupuesto
				.getDescripcionModalidadVenta());
		parametros.put("descripcionTipoDocumento", informePresupuesto
				.getDescripcionTipoDocumento() != null ? informePresupuesto
				.getDescripcionTipoDocumento().toUpperCase() : "");

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
		InputStream logo = getServlet().getServletConfig().getServletContext()
				.getResourceAsStream("/img/logoTelefonica.jpg");
		parametros.put("logo", logo);//

		List presupuesto = new ArrayList();
		for (int i = 0; i < informePresupuesto.getDetalle().length; i++) {
			presupuesto.add(informePresupuesto.getDetalle()[i]);
		}
		logger.debug("presupuesto.size()=" + presupuesto.size());
		if (presupuesto.size() == 0)
			presupuesto.add(new DetallePresupuestoDTO());

		String sRutaReporte = System.getProperty("user.dir")
				+ global.getValorExterno("presupuesto.reporte");
		File reportFile = new File(sRutaReporte);
		logger.debug("Estado reporte :Existe=" + reportFile.exists()
				+ ", Largo=" + reportFile.length());

		try {
			JRBeanCollectionDataSource ds = new JRBeanCollectionDataSource(
					presupuesto);

			byte[] bytes = JasperRunManager.runReportToPdf(
					reportFile.getPath(), parametros, ds);
			response.setContentType("application/pdf");
			response.setContentLength(bytes.length);
			response.setHeader("Content-disposition", "attachment; filename="
					+ "Presupuesto.pdf");
			ServletOutputStream ouputStream = response.getOutputStream();
			ouputStream.write(bytes, 0, bytes.length);
			ouputStream.flush();
			ouputStream.close();
		} catch (JRException e) {
			String mensaje = e.getMessage() == null ? "Ocurrio un error al generar reporte "
					: e.getMessage();
			logger.debug("JRException," + mensaje);
			request.setAttribute("mensajeError", mensaje);
			return mapping.findForward("mostrarPresupuesto");
		}

		logger.info("imprimirPresupuesto, fin");
		return null;

	}

	public ActionForward aceptarPresupuesto(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		logger.info("aceptarPresupuesto, inicio");
		HttpSession sesion = request.getSession(false);
		VentaAjaxDTO datosVenta = (VentaAjaxDTO) sesion
				.getAttribute("ventaSel");
		CabeceraArchivoDTO datosPresupuesto = (CabeceraArchivoDTO) sesion
				.getAttribute("cabeceraDTO");
		CargosForm cargoForm = (CargosForm) sesion.getAttribute("CargosForm");

		GaVentasDTO gaVentasDTO = new GaVentasDTO();
		gaVentasDTO.setNumVenta(new Long(datosVenta.getNroVenta()));
		gaVentasDTO.setIndOfiter(datosVenta.getIndOfiter());
		gaVentasDTO.setImpVenta(new Float(datosPresupuesto
				.getTotalPresupuestoVenta()));
		gaVentasDTO.setNomUsuarVta(((ParametrosGlobalesDTO) sesion
				.getAttribute("paramGlobal")).getCodUsuario());
		gaVentasDTO.setPreactivacion(cargoForm.getPreactivacion());
		gaVentasDTO.setTipoCliente(datosVenta.getCodTipoCliente());
		delegate.aceptarPresupuesto(gaVentasDTO);

		// resultado de solicitud
		AbonadoDTO[] listaLineas = (AbonadoDTO[]) sesion
				.getAttribute("listaLineas");
		ResultadoVentaDTO resultadoVenta = new ResultadoVentaDTO();
		resultadoVenta.setNroVenta(datosVenta.getNroVenta());
		resultadoVenta.setCodCliente(datosVenta.getCodCliente());
		resultadoVenta.setNombreCliente(datosVenta.getNombreCliente().trim());
		resultadoVenta.setCodVendedor(datosVenta.getCodVendedor());
		resultadoVenta.setNombreVendedor(datosVenta.getNombreVendedor().trim());
		resultadoVenta.setDescripcionTipoDocumento(datosPresupuesto
				.getCategoriaTributaria());
		resultadoVenta.setCantidadLineas(String
				.valueOf((listaLineas != null ? listaLineas.length : 0)));

		// request.setAttribute("resultadoVenta",resultadoVenta);//dejar en
		// session y despues eliminar
		
	

		logger.info("aceptarPresupuesto, fin");
		String forward = "aceptarPresupuesto";
		/** **********Distribucion de bolsa inicio********* */
		CargosForm cargosForm = (CargosForm) form;
		/*
		 * if("SI".equals(cargosForm.getDistribuir())){ forward =
		 * "distribuirBolsa";
		 * sesion.setAttribute("resultadoVenta",resultadoVenta); }else{
		 * request.setAttribute("resultadoVenta",resultadoVenta); }
		 */
		sesion.setAttribute("resultadoVenta", resultadoVenta);
		// Inicio P-CSR-11002 JLGN 08-08-2011
		String codTipcliente = datosVenta.getCodTipoCliente();
		if (codTipcliente.equals("3")) {// Si cliente es Prepago no se muestra
										// Boton de Imprimir Contrato
			sesion.setAttribute("flagBtnContrato", "false");
		} else {
			sesion.setAttribute("flagBtnContrato", "true");
		}
		// Fin P-CSR-11002 JLGN 08-08-2011
		forward = "distribuirBolsa";
		/** **********Distribucion de bolsa fin*********** */
		return mapping.findForward(forward);

	}

	private String existenPlanesTarifarios(String nroVenta)
			throws NumberFormatException, RemoteException, GeneralException {
		logger.debug("existenPlanesTarifarios() :antes");
		logger.debug("nroVenta[" + nroVenta + "]");
		String puedeDistribuir = "NO";
		PlanTarifarioDTO[] planesDistribuidos = delegate
				.obtenerPlanesDistribuidos(new Long(nroVenta));
		if (planesDistribuidos == null)
			logger.debug("planesDistribuidos=null");
		if (planesDistribuidos != null && planesDistribuidos.length > 0) {
			puedeDistribuir = "SI";
		}
		logger.debug("puedeDistribuir[" + puedeDistribuir + "]");
		logger.debug("existenPlanesTarifarios() :despues");
		return puedeDistribuir;
	}

	public ActionForward reversarCargos(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		logger.info("reversarCargos, inicio");
		HttpSession sesion = request.getSession(false);
		VentaAjaxDTO datosVenta = (VentaAjaxDTO) sesion
				.getAttribute("ventaSel");

		try {
			delegate.reversaCargosFormalizacion(new Long(datosVenta
					.getNroVenta()));
		} catch (VentasException e) {
			String mensaje = e.getDescripcionEvento() == null ? " Ocurrio un error al reversar cargos"
					: e.getDescripcionEvento();
			request.setAttribute("mensajeError", mensaje);
			logger.debug("[VentasException]" + mensaje);
			return mapping.findForward("inicio");
		} catch (Exception e) {
			String mensaje = e.getMessage() == null ? " Ocurrio un error al reversar cargos"
					: e.getMessage();
			request.setAttribute("mensajeError", mensaje);
			logger.debug("[Exception]" + mensaje);
			return mapping.findForward("inicio");
		}

		sesion.removeAttribute("cabeceraDTO");
		sesion.removeAttribute("Cargos");

		logger.info("reversarCargos, fin");
		return mapping.findForward("anterior");

	}

	public ActionForward reversarVenta(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		logger.info("reversarVenta, inicio");
		HttpSession sesion = request.getSession(false);
		VentaAjaxDTO datosVenta = (VentaAjaxDTO) sesion
				.getAttribute("ventaSel");
		CabeceraArchivoDTO resumenPresupuesto = (CabeceraArchivoDTO) sesion
				.getAttribute("cabeceraDTO");

		try {
			String user = ((ParametrosGlobalesDTO) sesion
					.getAttribute("paramGlobal")).getCodUsuario();

			GaVentasDTO gaVentasDTO = new GaVentasDTO();
			gaVentasDTO.setNumVenta(new Long(datosVenta.getNroVenta()));
			gaVentasDTO.setCodVendedor(new Long(datosVenta.getCodVendedor()));
			gaVentasDTO.setNomUsuarVta(user);
			if (resumenPresupuesto.getNumeroProcesoFacturacion() == null
					|| resumenPresupuesto.getNumeroProcesoFacturacion().equals(
							"")) {
				// Sin no hay número de proceso se envia un valor cero.
				gaVentasDTO.setNumProceso(new Long(0));
			} else {
				gaVentasDTO.setNumProceso(new Long(resumenPresupuesto
						.getNumeroProcesoFacturacion()));
			}

			delegate.reversaVenta(gaVentasDTO);
		} catch (VentasException e) {
			String mensaje = e.getDescripcionEvento() == null ? " Ocurrio un error al reversar venta"
					: e.getDescripcionEvento();
			request.setAttribute("mensajeError", mensaje);
			logger.debug("[VentasException]" + mensaje);
			return mapping.findForward("mostrarPresupuesto");
		} catch (Exception e) {
			String mensaje = e.getMessage() == null ? " Ocurrio un error al reversar venta"
					: e.getMessage();
			request.setAttribute("mensajeError", mensaje);
			logger.debug("[Exception]" + mensaje);
			return mapping.findForward("mostrarPresupuesto");
		}

		limpiarSesion(request);

		logger.info("reversarVenta, fin");
		return mapping.findForward("irAMenu");

	}

	public ActionForward irAMenu(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		logger.info("irAMenu, inicio");
		limpiarSesion(request);

		logger.info("irAMenu, fin");
		return mapping.findForward("irAMenu");

	}

	private void limpiarSesion(HttpServletRequest request) {
		HttpSession sesion = request.getSession(false);
		sesion.removeAttribute("listaPreVenta");
		sesion.removeAttribute("BuscaClienteForm");
		sesion.removeAttribute("clienteSel");
		sesion.removeAttribute("ventaSel");
		sesion.removeAttribute("cabeceraDTO");
		sesion.removeAttribute("Cargos");
		sesion.removeAttribute("listaLineas");
		// P-CSR-11002 JLGN 10-08-2011
		sesion.removeAttribute("flagBtnContrato");
	}

	public ActionForward imprimirContrato(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		try {
			logger.debug("imprimirContrato, inicio");
			logger.debug("Se declaran variables");
			HttpSession sesion = request.getSession(false);
			byte[] pdfAsBytes = null;
			HashMap params = null; // Parametros para el contrato
			DatosContrato datosContrato = null;
			logger.debug("Se obtiene numero de venta");
			VentaAjaxDTO datosVenta = (VentaAjaxDTO) sesion
					.getAttribute("ventaSel");
			logger.debug("Nº de venta: " + datosVenta.getNroVenta());
			logger.debug("Se obtiene datos del contrato");
			datosContrato = delegate.obtenerDatosContrato(datosVenta
					.getNroVenta());
			logger.debug("Se setan los datos de la cabecera del contrato");
			params = delegate.cabeceraContrato(datosContrato);
			logger.debug("Se consulta cuantas lineas tiene el cliente");
			// Se consulta cuantas lineas tiene el cliente
			if (datosContrato.getLineascontrato().length <= 4) {
				// Son 4 lineas
				logger.debug("Son 4 lineas");
				pdfAsBytes = delegate.rellenaFormatoContrato(params,
						datosContrato, 1);
			} else {
				// Son mas de 4 lineas
				logger.debug("Son mas de 4 lineas");
				pdfAsBytes = delegate.formatoContratoAnexo(params,
						datosContrato, 1);
			}
			
			logger.debug("Genera Responce");
			response.setContentType("application/pdf");
			response.setContentLength(pdfAsBytes.length);
			response.setHeader("Content-disposition", "iniline; filename="
					+ "Contrato.pdf");
			logger.debug("Genera ouputStream");
			ServletOutputStream ouputStream = response.getOutputStream();
			ouputStream.write(pdfAsBytes, 0, pdfAsBytes.length);
			ouputStream.flush();
			ouputStream.close();
			request.getSession().setAttribute("terminoContrato", "SI");

		} catch (VentasException e) {
			logger.debug("VentasException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			String mensaje = e.getMessage() == null ? "Ocurrio un error al generar reporte "
					: e.getMessage();
			logger.debug("VentasException," + mensaje);
			request.setAttribute("mensajeError", mensaje);
			request.getSession().setAttribute("terminoContrato", "SI");
			return mapping.findForward("errorImpContrato");

		} catch (JRException e) {
			logger.debug("JRException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			String mensaje = e.getMessage() == null ? "Ocurrio un error al generar reporte "
					: e.getMessage();
			logger.debug("JRException," + mensaje);
			request.setAttribute("mensajeError", mensaje);
			request.getSession().setAttribute("terminoContrato", "SI");
			return mapping.findForward("errorImpContrato");

		} catch (Exception e) {
			String mensaje = e.getMessage() == null ? " Ocurrio un error al generar reporte"
					: e.getMessage();
			request.setAttribute("mensajeError", mensaje);
			logger.debug("[Exception]" + mensaje);
			request.getSession().setAttribute("terminoContrato", "SI");
			return mapping.findForward("errorImpContrato");
		}

		logger.info("imprimirContrato, fin");
		return null;

	}

	// Inicio P-CSR-11002 JLGN 11-11-2011
	public ActionForward irConsultaDocumento(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		logger.debug("irConsultaDocumento, inicio");
		HttpSession sesion = request.getSession(false);
		VentaAjaxDTO datosVenta = (VentaAjaxDTO) sesion
				.getAttribute("ventaSel");
		logger.debug("Nº de venta: " + datosVenta.getNroVenta());
		sesion.setAttribute("numVentaDocumento", datosVenta.getNroVenta());
		logger.info("inicioVenta, fin");
		return mapping.findForward("consultaDocumentos");

	}

	// Inicio MA-180654 HOM

	public ActionForward imprimirFactura(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		logger.info("imprime factura");
		try {
			logger.info("imprimirFactura, inicio");
			// String numVentaSel = (request.getParameter("numVentaSel") == null
			// ? null : (String) request.getParameter("numVentaSel"));
			HttpSession sesion = request.getSession(false);

			VentaAjaxDTO ventaSel = (VentaAjaxDTO) sesion
					.getAttribute("ventaSel");

			// Inicio MA-180654 HOM
			boolean existe = false;
			int contador = 0;
			String nomFactura = null;

			ParametrosGeneralesDTO parametrosGeneralesDTO = null;
			logger
					.debug("Voy a buscar a la ged_parametros los milisegundos a esperar por reintento");
			parametrosGeneralesDTO = new ParametrosGeneralesDTO();
			parametrosGeneralesDTO.setCodigoproducto("1");
			parametrosGeneralesDTO.setCodigomodulo("FA");
			parametrosGeneralesDTO.setNombreparametro(global
					.getValor("miliseg.espera.fac"));
			parametrosGeneralesDTO = delegate
					.getParametroGeneral(parametrosGeneralesDTO);
			long milisegundos = Long.parseLong(parametrosGeneralesDTO
					.getValorparametro());

			logger
					.debug("Voy a buscar a la ged_parametros la cantidad de reintentos");
			parametrosGeneralesDTO = new ParametrosGeneralesDTO();
			parametrosGeneralesDTO.setCodigoproducto("1");
			parametrosGeneralesDTO.setCodigomodulo("FA");
			parametrosGeneralesDTO.setNombreparametro(global
					.getValor("cant.reintentos.fac"));
			parametrosGeneralesDTO = delegate
					.getParametroGeneral(parametrosGeneralesDTO);
			int cantidadReintentos = Integer.parseInt(parametrosGeneralesDTO
					.getValorparametro());

			while (!existe) {
				logger.debug("Buscar Factura; Intento: " + contador
						+ " - milisegundos: " + milisegundos);
				contador++;
				try {
					nomFactura = delegate.obtenerNombreFactura(Long
							.parseLong(ventaSel.getNroVenta()));
					existe = true;
					logger.debug("Factura Existe");
				} catch (Exception e) {
					logger.debug("Factura NO Existe");
					if (contador <= cantidadReintentos) {
						logger.debug("Espero " + milisegundos
								+ " milisegundos para reintentar");
						// No esta el archivo disponible aun, asi que espero 3
						// segundos y vuelvo a preguntar
						Thread.sleep(milisegundos);// Espero 3 sgundos
					} else {
						logger
								.debug("Se acabaron los reintentos así que envio mensaje");
						String mensaje = "Factura de venta en Proceso, Intentar por opción Reimpresión de Documentos";
						request.setAttribute("mensajeError", mensaje);
						logger.debug("[Exception]" + mensaje);
						return mapping.findForward("errorImpFactura");
					}
				}

			}
			// Fin MA-180654 HOM

			// String nomFactura =
			// delegate.obtenerNombreFactura(Long.parseLong(ventaSel.getNroVenta()));
			// MA-180654 HOM

			parametrosGeneralesDTO = new ParametrosGeneralesDTO();
			parametrosGeneralesDTO.setCodigoproducto("1");
			parametrosGeneralesDTO.setCodigomodulo("FA");
			parametrosGeneralesDTO.setNombreparametro(global
					.getValor("ftp.factura"));
			parametrosGeneralesDTO = delegate
					.getParametroGeneral(parametrosGeneralesDTO);
			String dominioFact = parametrosGeneralesDTO.getValorparametro();

			logger.debug("Setea Valores");
			String sRutaReporte = "ftp://" + dominioFact + "/" + nomFactura;
			logger.debug("Ruta PDF: " + sRutaReporte);

			logger.debug("declaro URL");
			URL url = new URL(sRutaReporte);
			logger.debug("abro conexion");
			URLConnection connection = url.openConnection();
			InputStream in = connection.getInputStream();

			int contentLength = connection.getContentLength();
			ByteArrayOutputStream tmpOut;
			if (contentLength != -1) {
				tmpOut = new ByteArrayOutputStream(contentLength);
			} else {
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

			byte[] pdfAsBytes = tmpOut.toByteArray();
			
			
			logger.debug("Genera Responce");
			String terminoContrato = (String) request.getSession().getAttribute("terminoContrato");
			
			while(null==terminoContrato||"".equals(terminoContrato)){
				logger.debug("Espero a que termine de imprimir el contrato para continuar");
				terminoContrato = (String) request.getSession().getAttribute("terminoContrato");
			}
			response.reset();
			response.setContentType("application/pdf");
			response.setContentLength(pdfAsBytes.length);
			response.setHeader("Content-disposition", "iniline; filename="
					+ nomFactura);
			logger.debug("Genera ouputStream");
			ServletOutputStream ouputStream = response.getOutputStream();
			ouputStream.write(pdfAsBytes, 0, pdfAsBytes.length);
			ouputStream.flush();
			ouputStream.close();

		} catch (Exception e) {
			logger.error("Exception: " + e);
			String mensaje = "Factura de venta en Proceso, Imprimir por opción Reimpresión de Documentos";
			request.setAttribute("mensajeError", mensaje);
			logger.debug("[Exception]" + mensaje);
			return mapping.findForward("errorImpFactura");
		}

		logger.info("imprimirFactura, fin");
		
		return null;
	}
						 	
	public ActionForward imprimirAnexoTerminales(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		try {
			logger.debug("imprimirAnexoTerminales, inicio");
			logger.debug("Se declaran variables");
			HttpSession sesion = request.getSession(false);
			byte[] pdfAsBytes = null;
			HashMap params = null; // Parametros para el contrato
			logger.debug("Se obtiene numero de venta");
			VentaAjaxDTO datosVenta = (VentaAjaxDTO) sesion
					.getAttribute("ventaSel");
			logger.debug("Nº de venta: " + datosVenta.getNroVenta());
			
			DatosAnexoTerminalesDTO anexoTerminalesDTO = delegate.getDatosAnexoTerminales(new Long(datosVenta.getNroVenta()));
			
			JasperPrint jasperPrint =null;	
			String sRutaAnexo=null;
			
			if(anexoTerminalesDTO.getAnexoTerminalDTOs().length==0){
				logger.debug("No existen terminales internos");
				String mensaje = "Venta sin terminales Internos para generar anexos";
				request.setAttribute("mensajeError", mensaje);
				return mapping.findForward("errorImpContrato");
			}
			
			//Rescato la fecha y la hora
			
			SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy"); 
			Date hoy = new Date(); 
			String fecha =  dateFormat.format(hoy);
			 dateFormat = new SimpleDateFormat("hh:mm:ss"); 
			String hora = dateFormat.format(hoy);

			
			for(int i=0; i<=anexoTerminalesDTO.getAnexoTerminalDTOs().length-1;i++){
				sRutaAnexo = System.getProperty("user.dir")  + global.getValorExterno("anexoTerminales1.reporte");
				params = new HashMap();
				params.put("nomCliente", anexoTerminalesDTO.getNomCliente());
				params.put("tipoIdent", anexoTerminalesDTO.getTipIdent());
				params.put("numIdent", anexoTerminalesDTO.getNumIdent());
				if(i==0){
					jasperPrint = JasperFillManager.fillReport(sRutaAnexo, params);
				}else{
					JasperPrint jasperPrint2 = JasperFillManager.fillReport(sRutaAnexo, params);
					jasperPrint.addPage(jasperPrint2.removePage(0));
				}
				
				params = new HashMap();
				params.put("marca", anexoTerminalesDTO.getAnexoTerminalDTOs()[i].getMarca());
				params.put("imei", anexoTerminalesDTO.getAnexoTerminalDTOs()[i].getNumSerie());
				params.put("modelo", anexoTerminalesDTO.getAnexoTerminalDTOs()[i].getModelo());
				params.put("plazoGarantia", "1 Año");
				params.put("plan", anexoTerminalesDTO.getAnexoTerminalDTOs()[i].getDesPlan());
				params.put("prcTerminalCont", "¢"+anexoTerminalesDTO.getAnexoTerminalDTOs()[i].getPrecioPrepago());
				params.put("prcFinal", "¢"+anexoTerminalesDTO.getAnexoTerminalDTOs()[i].getPrcVenta());
				params.put("formaPago", anexoTerminalesDTO.getAnexoTerminalDTOs()[i].getFormaPago());
				
				//JLGN
				double penalidad = 0;
				logger.debug("penalidad: "+anexoTerminalesDTO.getAnexoTerminalDTOs()[i].getPenalidad());
				penalidad = Double.valueOf(anexoTerminalesDTO.getAnexoTerminalDTOs()[i].getPenalidad()).doubleValue();
				logger.debug("penalidad1: "+String.valueOf(penalidad));
				if (penalidad > 0){
					params.put("penalidad", "¢"+String.valueOf(penalidad));
				}else{
					params.put("penalidad", "¢0");
				}				
				params.put("permanencia", anexoTerminalesDTO.getAnexoTerminalDTOs()[i].getPeriodoContrato());
				params.put("hora", hora);
				params.put("fecha", fecha);
				params.put("lugar", anexoTerminalesDTO.getAnexoTerminalDTOs()[i].getOficina());
				params.put("rutaFirma", System.getProperty("user.dir")  + global.getValorExterno("firma.reporte"));
				sRutaAnexo = System.getProperty("user.dir")  + global.getValorExterno("anexoTerminales2.reporte");
				JasperPrint jasperPrint2 = JasperFillManager.fillReport(sRutaAnexo, params);
				jasperPrint.addPage(jasperPrint2.removePage(0));
			}
			
			
				pdfAsBytes = JasperExportManager.exportReportToPdf(jasperPrint);

			logger.debug("Genera Responce");
			response.setContentType("application/pdf");
			response.setContentLength(pdfAsBytes.length);
			response.setHeader("Content-disposition", "iniline; filename="
					+ "AnexosTerminales.pdf");
			logger.debug("Genera ouputStream");
			ServletOutputStream ouputStream = response.getOutputStream();
			ouputStream.write(pdfAsBytes, 0, pdfAsBytes.length);
			ouputStream.flush();
			ouputStream.close();

		} catch (JRException e) {
			logger.debug("JRException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			String mensaje = e.getMessage() == null ? "Ocurrio un error al generar reporte "
					: e.getMessage();
			logger.debug("JRException," + mensaje);
			request.setAttribute("mensajeError", mensaje);
			return mapping.findForward("errorImpContrato");

		} catch (Exception e) {
			String mensaje = e.getMessage() == null ? " Ocurrio un error al generar reporte"
					: e.getMessage();
			request.setAttribute("mensajeError", mensaje);
			logger.debug("[Exception]" + mensaje);
			e.printStackTrace();
			return mapping.findForward("errorImpContrato");
		}

		logger.info("imprimirAnexoTerminales, fin");
		return null;

	}

	
	
	//Fin MA-180654 HOM	
	public ActionForward prueba(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		logger.info("aceptarPresupuesto, inicio");
		VentaAjaxDTO datosVenta = new VentaAjaxDTO();
		datosVenta.setNroVenta("1255");
		request.getSession().setAttribute("ventaSel",datosVenta);
		
		ResultadoVentaDTO resultadoVenta = new ResultadoVentaDTO();
		resultadoVenta.setNroVenta("1255");
		resultadoVenta.setCodCliente("606");
		resultadoVenta.setNombreCliente("Yolanda Matamorros");
		resultadoVenta.setCodVendedor("587");
		resultadoVenta.setNombreVendedor("Randall Sanchez");
		resultadoVenta.setDescripcionTipoDocumento("Prueba");
		resultadoVenta.setCantidadLineas("1");
		request.setAttribute("resultadoVenta", resultadoVenta);
		request.setAttribute("flagBtnContrato", "true");

		return mapping.findForward("aceptarPresupuesto");

	}
	

}