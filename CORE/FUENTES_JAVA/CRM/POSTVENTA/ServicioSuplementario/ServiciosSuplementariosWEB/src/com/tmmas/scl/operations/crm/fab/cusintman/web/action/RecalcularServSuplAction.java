package com.tmmas.scl.operations.crm.fab.cusintman.web.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework.util.BaseAction;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosObtencionCargosDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CargosObtenidosDTO;
import com.tmmas.scl.operations.crm.fab.cusintman.web.delegate.ServiciosSuplementariosBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cusintman.web.form.ServiciosSuplementariosForm;
import com.tmmas.scl.operations.crm.fab.cusintman.web.helper.Global;
import com.tmmas.scl.operations.frmkooss.web.delegate.FrmkOOSSBussinessDelegate;

public class RecalcularServSuplAction extends BaseAction{
	private Global global = Global.getInstance();
	private final Logger logger = Logger.getLogger(RecalcularServSuplAction.class);
	private FrmkOOSSBussinessDelegate delegate = FrmkOOSSBussinessDelegate.getInstance();
	private String textoMensajeRestricciones;
	private ServiciosSuplementariosBussinessDelegate delegateServiciosSuplementarios = ServiciosSuplementariosBussinessDelegate.getInstance();
	protected ActionForward executeAction(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {	
		HttpSession session = request.getSession(false);
		ClienteOSSesionDTO sessionData =null;
		try{
		sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");
		sessionData.setCodActAboCargosUso(global.getValor("ACT_SERVICIOSSUPLEMENTARIOS"));
		sessionData.setTipoPantallaPrevia("2");
		sessionData.setCargosObtenidos(null);//Limpieza de Cargos
			ParametrosObtencionCargosDTO paramObtCargos = new ParametrosObtencionCargosDTO();
			
			//CambioDeSimCardForm cambioDeSimCardForm = (CambioDeSimCardForm)session.getAttribute("CambioDeSimCardForm");
			 ServiciosSuplementariosForm formBean = (ServiciosSuplementariosForm)form;
			 
			String contratTabla=session.getAttribute("contratadosTabla")!=null?session.getAttribute("contratadosTabla").toString():"";
			String adelantadosTabla=session.getAttribute("adelantadosTabla")!=null?session.getAttribute("adelantadosTabla").toString():"";
			
		
			long codCliente= sessionData.getCliente().getCodCliente();
			paramObtCargos.setCodigoClienteOrigen(String.valueOf(codCliente));
			paramObtCargos.setCodigoClienteDestino(String.valueOf(codCliente));
			paramObtCargos.setCodigoModalidadVenta(sessionData.getModalidad());
			paramObtCargos.setTipoContrato(sessionData.getTipoContrato());
			// Recupero el plan tarifario desde el abonado
			paramObtCargos.setCodigoPlanTarifOrigen(sessionData.getAbonados()[0].getCodPlanTarif());
			paramObtCargos.setCodigoPlanTarifDestino(sessionData.getAbonados()[0].getCodPlanTarif());
			
			// HGG 18-05-2010
			// Se reutiliza este atributo para enviar los grupos/niveles de los SS para verificar cuales son adelantados
			// y traer en ese caso el cargo ocasional
			paramObtCargos.setCodCausaCambioPlan(adelantadosTabla);
				
			// Creo la coleccion de abonados
			String[] codAbonado =new String [1];
			codAbonado[0]=String.valueOf(sessionData.getNumAbonado());
			paramObtCargos.setAbonados(codAbonado);
			
			paramObtCargos.setCodigoServicio(contratTabla);
			//paramObtCargos.setCodigoPlanServicio(sessionData.getAbonados()[0].getCodPlanServ());
			paramObtCargos.setCodActabo(global.getValor("ACT_SERVICIOSSUPLEMENTARIOS"));
			ObtencionCargosDTO obtencionCargos = new ObtencionCargosDTO();
			paramObtCargos.setTipoPantalla("7");
			paramObtCargos.setOrdenServicio("10120");
			paramObtCargos.setCodigoTecnologia("GSM");
			paramObtCargos.setCodPlanServ(sessionData.getAbonados()[0].getCodPlanServ());
			
			logger.debug("Cadena :"+paramObtCargos.getCodCausaCambioPlan());
			
			obtencionCargos=delegate.obtencionCargos(paramObtCargos);
			
			CargosObtenidosDTO cargosObtenidosDTO=new CargosObtenidosDTO(); 
	
			// esto hay que levantarlo en el action de cargos
			if (obtencionCargos!=null&&obtencionCargos.getCargos()!=null&&obtencionCargos.getCargos().length>0){
				cargosObtenidosDTO.setOcacionales(obtencionCargos);
				sessionData.setCargosObtenidos(cargosObtenidosDTO);
			}
		}catch(Exception e){
			

			StringBuffer layout = new StringBuffer();
			
			textoMensajeRestricciones="No existen tarifas para el equipo seleccionado. " +
			"No es posible llevar a cabo la transacción con el módulo de cargos, " +
			"favor verificar que exista la siguiente información:" ;
			
			layout.append("<table width='100%'>");
			layout.append("<tr>");
			layout.append("<td align='center'>" + textoMensajeRestricciones + "</td>");
			layout.append("</tr>");
			layout.append("<tr>");
			layout.append("<td align='center'>");
			layout.append("<table style='font-style:verdana; font-size: 8pt;width:400px'>");
			layout.append("<tr>");
			layout.append("<td class='textoColumnaTabla'>Producto</td>");
			layout.append("<td class='textoFilasTabla'>1</td>");
			layout.append("</tr>");
			layout.append("<tr>");
			layout.append("	<td class='textoColumnaTabla'>Código de Artículo</td>");
			layout.append("<td class='textoFilasTabla'></td>");
			layout.append("</tr>");
			layout.append("<tr>");
			layout.append("<td class='textoColumnaTabla'>Número de Serie</td>");
			layout.append("<td class='textoFilasTabla'>" + sessionData.getAbonados()[0].getNumSerie() + "</td>");
			layout.append("</tr>");
			layout.append("<tr>");
			layout.append("<td class='textoColumnaTabla'>Tipo Stock</td>");
			/**
			 * Pra el tipo de stock modificar pl y dao recinfserie
			 */
			layout.append("<td class='textoFilasTabla'></td>");
			layout.append("</tr>");
			layout.append("<tr>");
			layout.append("<td class='textoColumnaTabla'>Código de Categoría</td>");
			layout.append("<td class='textoFilasTabla'></td>");
			layout.append("</tr>");
			layout.append("<tr>");
			layout.append("<td class='textoColumnaTabla'>Modalidad de Venta</td>");
			layout.append("<td class='textoFilasTabla'>" + sessionData.getModalidad() + "</td>");
			layout.append("</tr>");layout.append("<tr>");
			layout.append("<td class='textoColumnaTabla'>Meses de Prorroga</td>");
			layout.append("<td class='textoFilasTabla'></td>");
			layout.append("</tr>");layout.append("<tr>");
			layout.append("<td class='textoColumnaTabla'>Código de Promedio Facturado</td>");
			layout.append("<td class='textoFilasTabla'></td>");
			layout.append("</tr>");
			layout.append("</table>");
			layout.append("</td>");
			layout.append("</tr>");
			layout.append("<tr>");
			layout.append("<p><td align='center'>Si el problema persiste, favor comunicarse con el administrador de sistema.</td>");
			layout.append("</tr>");
			layout.append("</table>");
			
		/*
			"- Producto				:	1 \n" +
			"- Código de Artículo	:	"+formBeanCambioSerie.getCod_articulo()+"\n" +
			"- Número de Serie 		:	"+formBeanCambioSerie.getNroSerieEquip() +"\n" +
			"- Tipo Stock 			:	"+formBeanCambioSerie.getTip_stock()+"\n" +
			"- Código de Categoría  :	\n" +
			"- Modalidad de Venta 	:	"+formBeanCambioSerie.getModalidadPago()+"\n" +
			"- Meses de Prorroga 	:	"+formBeanCambioSerie.getMesesProrroga()+"\n" +
			"- Código de Promedio Facturado.\n" +
			"";
	*/
			delegateServiciosSuplementarios.guardaMensajesError(request, "Error en el Módulo de Cargos", layout.toString());
			return mapping.findForward("error");
		}
		 return mapping.findForward("finalizar");
	}
}
