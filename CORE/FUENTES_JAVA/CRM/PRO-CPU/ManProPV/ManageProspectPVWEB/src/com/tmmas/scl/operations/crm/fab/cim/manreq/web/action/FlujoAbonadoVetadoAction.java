package com.tmmas.scl.operations.crm.fab.cim.manreq.web.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework.util.BaseAction;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ConversionDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ConversionListDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoListDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.exception.ManReqException;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate.ManageRequestBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.ManAboVetaForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.Global;

public class FlujoAbonadoVetadoAction extends BaseAction {

	private final Logger logger = Logger.getLogger(FlujoAbonadoVetadoAction.class);

	private Global global = Global.getInstance();

	private ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();

	public ActionForward executeAction(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		String log = global.getValor("web.log");
		String nombreFordward = "inicioOrdenServicio";
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);
		logger.debug("execute():start");
		RetornoDTO retornoDTO = new RetornoDTO();
		retornoDTO.setCodigo("0");
		ManAboVetaForm form1 = (ManAboVetaForm) form;
		AbonadoListDTO listaAbonados = null;
		AbonadoDTO retornoAbonado = null;
		AbonadoDTO[] abonadoDTO = new AbonadoDTO[1];
		ClienteOSSesionDTO sessionData = new ClienteOSSesionDTO();
		HttpSession session = request.getSession(false);
		sessionData = (ClienteOSSesionDTO) session.getAttribute("ClienteOOSS");
		String[] codAbonado = new String[1];
		try {
			if (sessionData.getCodCliente() != 0) {
				logger.debug("obtenerListaAbonados:antes");
				listaAbonados = delegate.obtenerListaAbonados(sessionData.getCliente());
				logger.debug("obtenerListaAbonados:despues");
				sessionData.setAbonados(listaAbonados.getAbonados());
			} else if (sessionData.getNumAbonado() == 0) {
				logger.debug("obtenerDatosAbonado:antes");
				AbonadoDTO buscaAbonado = new AbonadoDTO();
				buscaAbonado.setNumAbonado(sessionData.getNumAbonado());
				retornoAbonado = delegate.obtenerDatosAbonado(buscaAbonado);
				logger.debug("obtenerDatosAbonado:despues");
				AbonadoDTO[] abonados = new AbonadoDTO[1];
				abonados[0] = retornoAbonado;
				listaAbonados = new AbonadoListDTO();
				listaAbonados.setAbonados(abonados);
				sessionData.setAbonados(listaAbonados.getAbonados());

			}

			if (sessionData.getNumAbonado() == 0) {
				if (listaAbonados != null && listaAbonados.getAbonados() != null) {
					sessionData.setNumAbonado(listaAbonados.getAbonados()[0].getNumAbonado());
					// form1.getAbonadosVetadosDTO()[0].setNumAbonado(sessionData.getNumAbonado());
				}
			}

			codAbonado[0] = String.valueOf(sessionData.getNumAbonado());

			abonadoDTO[0] = delegate.obtenerDatosAbonado(form1.getAbonadosVetadosDTO()[0]);

			sessionData.setAbonados(abonadoDTO);
			ConversionListDTO conversionList = null;
			ConversionDTO param = new ConversionDTO();
			param.setCodOOSS(sessionData.getCodOrdenServicio());
			param.setCodTipModi("-");
			logger.debug("param.getCodOOSS()    :[" + param.getCodOOSS() + "]");
			logger.debug("param.getCodTipModi() :[" + param.getCodTipModi() + "]");
			logger.debug("obtenerConversionOOSS():inicio");
			conversionList = delegate.obtenerConversionOOSS(param);
			logger.debug("obtenerConversionOOSS():fin");

			SecuenciaDTO secuencia = new SecuenciaDTO();
			if (sessionData.getNumOrdenServicio() == 0) {
				logger.debug("obtenerSecuencia:antes");
				secuencia.setNomSecuencia("CI_SEQ_NUMOS");
				logger.debug("nomSecuencia :" + secuencia.getNomSecuencia());
				secuencia = delegate.obtenerSecuencia(secuencia);
				sessionData.setNumOrdenServicio(secuencia.getNumSecuencia());
				logger.debug("obtenerSecuencia:despues");
			}

			sessionData.setCodAbonado(codAbonado);
			sessionData.setSinCondicionesComerciales(form1.getCondicH());
			sessionData.setCodActAbo(conversionList.getRegistros()[0].getCodActuacion());
			sessionData.setCodActAboCargosUso(conversionList.getRegistros()[0].getCodActuacion());
			sessionData.setTipoPantallaPrevia(String.valueOf(2)); // Se setea valor 2 para que en la query dinamica de obtencion de cargos por uso, no se considerado el codigo de concepto
			session.setAttribute("ClienteOOSS", sessionData);

			String next = form1.getBtnSiguiente();
			next = next == null ? "" : next.trim().toUpperCase();
			if (next.equals("SIGUIENTE")) {
				nombreFordward = "controlNavegacion";
			}
			form1.setBtnSiguiente(null);
			logger.debug("execute():end");
		} catch (Exception e) {

			retornoDTO.setCodigo("No hay código para esta excepción");
			retornoDTO.setDescripcion(e.getMessage());
			retornoDTO.setResultado(true);

			if (e instanceof ManReqException) {
				ManReqException me = (ManReqException) e;
				if (me.getCodigo() != null && !(me.getCodigo().equals(""))) {
					retornoDTO.setCodigo(me.getCodigo());
					retornoDTO.setDescripcion(me.getDescripcionEvento());
					retornoDTO.setResultado(true);
				}
			}
			String mensajeError = retornoDTO.getDescripcion();
			session.setAttribute("error", mensajeError);
			nombreFordward = "ValidacionAbonado";
			logger.error(e.getMessage(), e);
		}
		return mapping.findForward(nombreFordward);

	}

}
