package com.tmmas.scl.operations.crm.fab.cim.manreq.web.action;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.BaseAction;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoBeneficiarioDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoBeneficiarioListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.exception.ManReqException;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate.ManageRequestBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.ManAboBeneForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.Global;

public class ManAbosBenefRecargaAction extends BaseAction {
	private final Logger logger = Logger.getLogger(ManAbosBenefRecargaAction.class);

	private Global global = Global.getInstance();

	private ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();
	protected ActionForward executeAction(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

		String log = global.getValor("web.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);
		logger.debug("execute():start");
		//ManAboBeneForm manAboBeneForm = (ManAboBeneForm)form;//(ManAboBeneForm) form;
		
		ClienteOSSesionDTO sessionData = new ClienteOSSesionDTO();

		String nombreAction = null;
		RetornoDTO retornoDTO = new RetornoDTO();	
		retornoDTO.setCodigo("0");
		nombreAction = "ManAboBeneForm";//manAboBeneForm
		HttpSession session = request.getSession(false);
		//form = (ManAboBeneForm)session.getAttribute("manAboBeneForm");
		sessionData = (ClienteOSSesionDTO) session.getAttribute("ClienteOOSS");

		logger.debug("execute():end");
		session.setAttribute("recalculado", "NO");
		session.setAttribute("ultimaPagina","inicio");

		return mapping.findForward(nombreAction);
	}
}
