package com.tmmas.scl.operations.crm.fab.cusintman.web.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework.util.BaseAction;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosObtencionCargosDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CargosObtenidosDTO;
import com.tmmas.scl.operations.crm.fab.cusintman.web.delegate.SuspensionVoluntariaBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cusintman.web.form.SuspensionVoluntariaForm;
import com.tmmas.scl.operations.crm.fab.cusintman.web.helper.Global;
import com.tmmas.scl.operations.frmkooss.web.delegate.FrmkOOSSBussinessDelegate;

public class RecalcularSuspVolAction extends BaseAction{
	private Global global = Global.getInstance();
	private final Logger logger = Logger.getLogger(RecalcularSuspVolAction.class);
	private FrmkOOSSBussinessDelegate delegate = FrmkOOSSBussinessDelegate.getInstance();
	private String textoMensajeRestricciones;
	private SuspensionVoluntariaBussinessDelegate delegateSuspensionVoluntaria = SuspensionVoluntariaBussinessDelegate.getInstance();
	protected ActionForward executeAction(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {	
		HttpSession session = request.getSession(false);
		try{
		ClienteOSSesionDTO sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");
		sessionData.setCodActAboCargosUso(global.getValor("ACT_SUSPENSIONVOLUNTARIA"));
		sessionData.setTipoPantallaPrevia("2");
		sessionData.setCargosObtenidos(null);//Limpieza de Cargos
			ParametrosObtencionCargosDTO paramObtCargos = new ParametrosObtencionCargosDTO();
			
			//CambioDeSimCardForm cambioDeSimCardForm = (CambioDeSimCardForm)session.getAttribute("CambioDeSimCardForm");
			SuspensionVoluntariaForm formBean = (SuspensionVoluntariaForm)form;
			 
			 String contratTabla=session.getAttribute("contratadosTabla")!=null?session.getAttribute("contratadosTabla").toString():"";
			
		
			long codCliente= sessionData.getCliente().getCodCliente();
			paramObtCargos.setCodigoClienteOrigen(String.valueOf(codCliente));
			paramObtCargos.setCodigoClienteDestino(String.valueOf(codCliente));
			paramObtCargos.setCodigoModalidadVenta(sessionData.getModalidad());
			paramObtCargos.setTipoContrato(sessionData.getTipoContrato());
			// Recupero el plan tarifario desde el abonado
			paramObtCargos.setCodigoPlanTarifOrigen(sessionData.getAbonados()[0].getCodPlanTarif());
			paramObtCargos.setCodigoPlanTarifDestino(sessionData.getAbonados()[0].getCodPlanTarif());
				
			// Creo la coleccion de abonados
			String[] codAbonado =new String [1];
			codAbonado[0]=String.valueOf(sessionData.getNumAbonado());
			paramObtCargos.setAbonados(codAbonado);
			
			paramObtCargos.setCodigoServicio(contratTabla);
			//paramObtCargos.setCodigoPlanServicio(sessionData.getAbonados()[0].getCodPlanServ());
			paramObtCargos.setCodActabo(global.getValor("ACT_SUSPENSIONVOLUNTARIA"));
			ObtencionCargosDTO obtencionCargos = new ObtencionCargosDTO();
			paramObtCargos.setTipoPantalla("7");
			
			obtencionCargos=delegate.obtencionCargos(paramObtCargos);
			
			CargosObtenidosDTO cargosObtenidosDTO=new CargosObtenidosDTO(); 
	
			// esto hay que levantarlo en el action de cargos
			if (obtencionCargos!=null&&obtencionCargos.getCargos()!=null&&obtencionCargos.getCargos().length>0){
				cargosObtenidosDTO.setOcacionales(obtencionCargos);
				sessionData.setCargosObtenidos(cargosObtenidosDTO);
			}
		}catch(Exception e){
			
			logger.debug("Exception en RecalcularSuspVolAction");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			
			textoMensajeRestricciones="No existen tarifas para el equipo seleccionado. " +
			"No es posible llevar a cabo la transacción con el módulo de cargos, " +
			"favor verificar que exista la siguiente información: \n" +
			"- Código de Artículo \n" +
			"- Número de Serie \n" +
					"- Código de Uso \n "+ 
			"- Tipo Stock \n" +
			"- Código de Categoría  \n" +
			"- Modalidad de Venta \n" +
			"- Meses de Prorroga \n" +
			"- Código de Promedio Facturado.\n" +
			"Si el problema persiste, favor comunicarse con el administrador de sistema.";
		//e.setMessage(textoMensajeRestricciones);
			session.setAttribute("descripcionError", textoMensajeRestricciones);
			delegateSuspensionVoluntaria.guardaMensajesError(request, "Error en el Módulo de Cargos", textoMensajeRestricciones);
			logger.debug("mapping.findForward(error)");
			return mapping.findForward("error");
		}
		 return mapping.findForward("finalizar");
	}
}
