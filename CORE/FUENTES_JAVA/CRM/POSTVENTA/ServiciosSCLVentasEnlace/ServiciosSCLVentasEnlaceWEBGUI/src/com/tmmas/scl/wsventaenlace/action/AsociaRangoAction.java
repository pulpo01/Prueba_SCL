/**
 * 
 */
package com.tmmas.scl.wsventaenlace.action;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;
import org.apache.struts.util.LabelValueBean;

import com.tmmas.scl.wsventaenlace.common.exception.ServicioVentasEnlaceException;
import com.tmmas.scl.wsventaenlace.common.helper.GlobalProperties;
import com.tmmas.scl.wsventaenlace.common.helper.LoggerHelper;
import com.tmmas.scl.wsventaenlace.delegate.BusinessDelegate;
import com.tmmas.scl.wsventaenlace.form.AsociaRangoForm;
import com.tmmas.scl.wsventaenlace.helper.UtilesWeb;
import com.tmmas.scl.wsventaenlace.transport.dto.OOSSDTO;
import com.tmmas.scl.wsventaenlace.transport.dto.asociarango.CargaAsociaRangoDTO;
import com.tmmas.scl.wsventaenlace.transport.dto.asociarango.EjecucionAsociaRangoDTO;
import com.tmmas.scl.wsventaenlace.transport.dto.asociarango.RangoDTO;

/**
 * @author mwn40032
 * 
 */
public class AsociaRangoAction extends DispatchAction {
	private final LoggerHelper logger = LoggerHelper.getInstance();
	private static String nombreClase = AsociaRangoAction.class.getName();
	private GlobalProperties global = GlobalProperties.getInstance();

	public ActionForward execute(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest servletRequest, HttpServletResponse servletResponse) throws Exception {
		logger.debug(actionForm.toString(), nombreClase);

		return super.execute(actionMapping, actionForm, servletRequest, servletResponse);
	}

	public ActionForward carga(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest servletRequest, HttpServletResponse servletResponse) {
		logger.info("carga: iniciando...", nombreClase);
		ActionForward forward = null;
		AsociaRangoForm formulario = (AsociaRangoForm) actionForm;
		ServletContext context = servletRequest.getSession().getServletContext();

		try {
			formulario.myReset();
			servletRequest.setAttribute("fecha", UtilesWeb.getFecha());

			if (formulario.getNomUsuarioSCL() == null)
				formulario.setNomUsuarioSCL(formulario.getUserName());

			if (formulario.getNumAbonado() == null || formulario.getNumAbonado().trim().length() < 1)
				throw new ServicioVentasEnlaceException("ERR.0005", 1, global.getValor("ERR.0005"));

			/*
			 * TODO: 06JUL2009 PF-VT-009 RQ Se cambia de lugar validación y se modifica obtención del flag para omitir validaciones
			 */
			String flagInNumAbonado = "";
			// Capturando apendice desde ventas
			int largo = formulario.getNumAbonado().length();
			int i = largo - 1;
			while (i >= 0 && !Character.isDigit(formulario.getNumAbonado().charAt(i))) {
				flagInNumAbonado = formulario.getNumAbonado().charAt(i) + flagInNumAbonado;
				i--;
			}
			formulario.setNumAbonado(formulario.getNumAbonado().substring(0, i + 1));

			// VentaEnlaceE1DTO ventaEnlaceE1DTO = new VentaEnlaceE1DTO();
			// ventaEnlaceE1DTO.setNumAbonado(new Long(formulario.getNumAbonado()).longValue());
			// ventaEnlaceE1DTO = BusinessDelegate.validaAbonadoVPN(ventaEnlaceE1DTO);
			// logger.info("Action ventaEnlaceE1DTO.getCodError():" + ventaEnlaceE1DTO.getCodError(),nombreClase);
			// logger.info("Action ventaEnlaceE1DTO.getDesError():" + ventaEnlaceE1DTO.getDesError(),nombreClase);
			//			
			// if (ventaEnlaceE1DTO.getCodError()!=null) {
			// formulario.setCodError(ventaEnlaceE1DTO.getCodError());
			// formulario.setDesError(ventaEnlaceE1DTO.getDesError());
			// servletRequest.setAttribute("Form", actionForm);
			// return forward = actionMapping.findForward("error");

			if ((formulario.getNomUsuarioSCL() == null || formulario.getNomUsuarioSCL().trim().length() < 1) && (formulario.getUserName() == null || formulario.getUserName().trim().length() < 1))
				throw new ServicioVentasEnlaceException("ERR.0006", 1, global.getValor("ERR.0006"));

			CargaAsociaRangoDTO cargaAsociaRangoDTO = new CargaAsociaRangoDTO();

			if (flagInNumAbonado != null && flagInNumAbonado.equals(global.getValor("GE.AR.flags.venta.corto.WEB"))) {
				logger.info("carga: desde módulo de ventas.", nombreClase);

				cargaAsociaRangoDTO.setNomCliente(global.getValor("GE.AR.flags.venta.largo.WEB"));
			} else
				cargaAsociaRangoDTO.setNomCliente(null);

			HttpSession session = (HttpSession) servletRequest.getSession();
			session.removeAttribute("cargaAsociaRangoDTO");

			cargaAsociaRangoDTO.setNumAbonado(new Long(formulario.getNumAbonado()));

			if (formulario.getUserName() == null)
				cargaAsociaRangoDTO.setNomUsuarioSCL(formulario.getNomUsuarioSCL());
			else
				cargaAsociaRangoDTO.setNomUsuarioSCL(formulario.getUserName());

			cargaAsociaRangoDTO = BusinessDelegate.cargarAsociaRangoDTO(cargaAsociaRangoDTO,context);

			if (cargaAsociaRangoDTO.getCodError() != null) {
				formulario.setCodError(cargaAsociaRangoDTO.getCodError());
				formulario.setDesError(cargaAsociaRangoDTO.getDesError());
				servletRequest.setAttribute("Form", actionForm);

				return forward = actionMapping.findForward("error");
			}

			formulario.setNumTransaccion(cargaAsociaRangoDTO.getNumTransaccion());
			session.setAttribute("cargaAsociaRangoDTO", cargaAsociaRangoDTO);

			formulario.setCargaAsociaRangoDTO(cargaAsociaRangoDTO);
			formulario.setRangosAsociados(listaRangos(cargaAsociaRangoDTO.getRangosAsociados()));
			formulario.setRangosDisponibles(listaRangos(cargaAsociaRangoDTO.getRangosDisponibles()));

			logger.debug("carga: carga terminada.", nombreClase);
			return forward = actionMapping.findForward("carga");

		} catch (ServicioVentasEnlaceException e) {
			formulario.setCodError(e.getCodigo());
			formulario.setDesError(e.getDescripcionEvento());
			servletRequest.setAttribute("Form", actionForm);

			return forward = actionMapping.findForward("error");
		} catch (Throwable t) {
			logger.error(t, nombreClase);
			formulario.setCodError(null);
			formulario.setDesError("Error al conectarse al servicio");
			servletRequest.setAttribute("Form", actionForm);

			return forward = actionMapping.findForward("error");
		} finally {
			logger.info("carga: forward = [" + forward + "]", nombreClase);
		}
	}

	public ActionForward ejecucion(ActionMapping actionMapping, ActionForm actionForm, HttpServletRequest servletRequest, HttpServletResponse servletResponse) {
		logger.info("iniciando...", nombreClase);
		AsociaRangoForm formulario = (AsociaRangoForm) actionForm;
		ActionForward forward = actionMapping.findForward("error");
		ServletContext context = servletRequest.getSession().getServletContext();

		try {
			if (formulario.getRangosAsociadosSeleccionados() == null && formulario.getRangosDisponiblesSeleccionados() == null)
				throw new ServicioVentasEnlaceException("ERR.0601", 1, global.getValor("ERR.0601"));

			servletRequest.setAttribute("fecha", UtilesWeb.getFecha());

			HttpSession session = (HttpSession) servletRequest.getSession();
			CargaAsociaRangoDTO cargaAsociaRangoDTO = (CargaAsociaRangoDTO) session.getAttribute("cargaAsociaRangoDTO");

			logger.debug(cargaAsociaRangoDTO.toString(), nombreClase);

			EjecucionAsociaRangoDTO ejecucionAsociaRangoDTO = new EjecucionAsociaRangoDTO();
			ejecucionAsociaRangoDTO.setRangosEliminados(buscarEliminados(cargaAsociaRangoDTO.getRangosAsociados(), formulario.getRangosAsociadosSeleccionados()));
			ejecucionAsociaRangoDTO.setRangosAdicionados(buscarEliminados(cargaAsociaRangoDTO.getRangosDisponibles(), formulario.getRangosDisponiblesSeleccionados()));
			ejecucionAsociaRangoDTO.setNumTransaccion(cargaAsociaRangoDTO.getNumTransaccion());
			ejecucionAsociaRangoDTO.setComentario(formulario.getComentario());

			if (ejecucionAsociaRangoDTO.getRangosEliminados() == null && ejecucionAsociaRangoDTO.getRangosAdicionados() == null)
				throw new ServicioVentasEnlaceException("ERR.0601", 1, global.getValor("ERR.0601"));

			// Ejecutar
			ejecucionAsociaRangoDTO = BusinessDelegate.ejecutarAsociaRangoDTO(ejecucionAsociaRangoDTO,context);

			if (ejecucionAsociaRangoDTO.getCodError() != null) {
				formulario.setCodError(ejecucionAsociaRangoDTO.getCodError());
				formulario.setDesError(ejecucionAsociaRangoDTO.getDesError());
				servletRequest.setAttribute("Form", formulario);
				return forward = actionMapping.findForward("error");
			}

			OOSSDTO oossdto = new OOSSDTO();
			long tiempoConsultaOS = Calendar.getInstance().getTimeInMillis();
			long tiempoActual = Calendar.getInstance().getTimeInMillis();
			long tiempoMaximoEspera = Long.parseLong(global.getValorExterno("GE.maxencontexto"));
			long tiempoDeEspera = tiempoConsultaOS - tiempoActual;

			while (oossdto.getNroOOSS() == 0 && tiempoDeEspera < tiempoMaximoEspera && (oossdto.getCodError() == null || oossdto.getCodError().equals("ERR.0465"))) {
				oossdto.setNumTransaccion(formulario.getNumTransaccion());
				BusinessDelegate.consultaOS(oossdto);
				formulario.setCodError(oossdto.getCodError());
				formulario.setDesError(oossdto.getDesError());

				logger.debug("NumOOSS = " + oossdto.getNroOOSS(), nombreClase);

				formulario.setOrdenServicio(oossdto.getNroOOSS() != 0 ? String.valueOf(oossdto.getNroOOSS()) : null);
				tiempoActual = Calendar.getInstance().getTimeInMillis();
				tiempoDeEspera = tiempoActual - tiempoConsultaOS;
			}

			if (oossdto.getCodError() != null) {
				formulario.setCodError(oossdto.getCodError());
				formulario.setDesError(oossdto.getDesError());
				servletRequest.setAttribute("Form", actionForm);
				return forward = actionMapping.findForward("error");
			} else {
				logger.debug(ejecucionAsociaRangoDTO.toString(), nombreClase);
				//System.out.println(ejecucionAsociaRangoDTO);
				formulario.setOrdenServicio("" + ejecucionAsociaRangoDTO.getNroOOSS());
				session.removeAttribute("cargaAsociaRangoDTO");
				formulario.setNroOOSS(oossdto.getNroOOSS());
				formulario.setCodError(null);
				formulario.setDesError(null);
				formulario.setMostrarNroOOSS("mostrarNroOOSS");
				servletRequest.setAttribute("Form", formulario);	
			}


			return forward;
		} catch (ServicioVentasEnlaceException e) {
			logger.error(e, nombreClase);

			formulario.setCodError(e.getCodigo());
			formulario.setDesError(e.getDescripcionEvento());

			servletRequest.setAttribute("Form", actionForm);

			return forward = actionMapping.findForward("error");
		} catch (Throwable t) {
			t.printStackTrace();
			logger.error(t, nombreClase);
			formulario.setCodError(null);
			formulario.setDesError("Error al conectarse al servicio");
			servletRequest.setAttribute("Form", actionForm);
			return forward = actionMapping.findForward("error");
		} finally {
			logger.info("forward = [" + forward + "]", nombreClase);
		}
	}

	private static RangoDTO[] buscarEliminados(RangoDTO rangos[], String numDesdes[]) {
		Set set = new HashSet();

		if (rangos == null)
			return null;

		for (int i = 0; i < rangos.length; i++)
			if (existe(numDesdes, rangos[i]))
				continue;
			else
				set.add(rangos[i]);

		// Rangos que ya no estan
		if (set.size() > 0) {
			RangoDTO r[] = new RangoDTO[set.size()];
			int j = 0;

			for (Iterator i = set.iterator(); i.hasNext();)
				r[j++] = (RangoDTO) i.next();

			return r;
		}

		return null;
	}

	private static boolean existe(String numDesdes[], RangoDTO rango) {
		if (numDesdes == null || rango == null)
			return false;

		for (int i = 0; i < numDesdes.length; i++) {
			// logger.debug("numDesdes[" + i + "] = " + numDesdes[i] + " =?= rango.getNumDesde() = " + rango.getNumDesde());

			if (Long.parseLong(numDesdes[i]) == rango.getNumDesde())
				return true;
		}

		return false;
	}

	private List listaRangos(RangoDTO[] rangos) {
		List list = new ArrayList();

		if (rangos == null || rangos.length < 1)
			return list;

		for (int i = 0; i < rangos.length; i++) {
			StringBuffer buffer = new StringBuffer();
			buffer.append(rangos[i].getNumDesde()).append(" - ").append(rangos[i].getNumHasta());

			list.add(new LabelValueBean(buffer.toString(), "" + rangos[i].getNumDesde()));
		}

		return list;
	}
}
