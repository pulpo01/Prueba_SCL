package com.tmmas.scl.operations.crm.fab.cusintman.web.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework.util.BaseAction;
import com.tmmas.scl.framework.ProductDomain.dto.SerieDTO;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CargosObtenidosDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.PlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.SimcardDTO;
import com.tmmas.scl.operations.crm.fab.cusintman.web.delegate.CambioSimCardBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cusintman.web.form.CambioDeSimCardForm;
import com.tmmas.scl.operations.crm.fab.cusintman.web.helper.Global;
import com.tmmas.scl.vendedor.dto.VendedorDTO;

public class RecalcularCambSimcCardAction extends BaseAction{
	private Global global = Global.getInstance();
	//private FrmkOOSSBussinessDelegate delegate = FrmkOOSSBussinessDelegate.getInstance();
	private CambioSimCardBussinessDelegate delegate =CambioSimCardBussinessDelegate.getInstance();
	
	private String textoMensajeRestricciones;
	private final Logger logger = Logger.getLogger(RecalcularCambSimcCardAction.class);
	protected ActionForward executeAction(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession(false);
		UsuarioAbonadoDTO usuarioAbonado =null;
		CambioDeSimCardForm cambioDeSimCardForm = (CambioDeSimCardForm)session.getAttribute("CambioDeSimCardForm");
		ClienteOSSesionDTO sessionData = null;
		VendedorDTO vendedor = null;
		try{
			vendedor = (VendedorDTO)session.getAttribute("Vendedor");
			sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");
			sessionData.setCodActAboCargosUso(global.getValor("ACT_SIMCARD"));
			sessionData.setTipoPantallaPrevia("2");
			sessionData.setCargosObtenidos(null);//Limpieza de Cargos
			usuarioAbonado=(UsuarioAbonadoDTO)session.getAttribute("usuarioAbonado");
			
			ParametrosObtencionCargosDTO paramObtCargos = new ParametrosObtencionCargosDTO();
			
			if (vendedor.getCod_vendealer()!=null && !vendedor.getCod_vendealer().equals("")) {
				paramObtCargos.setIndicadorTipoVenta(0);
			} else {
				paramObtCargos.setIndicadorTipoVenta(1);
			}			
		
			long codCliente= sessionData.getCliente().getCodCliente();
			paramObtCargos.setCodigoClienteOrigen(String.valueOf(codCliente));
			paramObtCargos.setCodigoClienteDestino(String.valueOf(codCliente));
			paramObtCargos.setCodigoModalidadVenta(sessionData.getModalidad());
			paramObtCargos.setTipoContrato(sessionData.getTipoContrato());
			
			
			
			//	ini-Proyecto p-mix-09003 OCB; 	
			paramObtCargos.setNumOsRenova(sessionData.getParamRenova());
			paramObtCargos.setOrdenServicio(""+sessionData.getCodOrdenServicio());
			//	fin-Proyecto p-mix-09003 OCB; 
			
			// Recupero el plan tarifario desde el abonado
			paramObtCargos.setCodigoPlanTarifOrigen(sessionData.getAbonados()[0].getCodPlanTarif());
			paramObtCargos.setCodigoPlanTarifDestino(sessionData.getAbonados()[0].getCodPlanTarif());
			paramObtCargos.setEstadoSimcard("7");
			paramObtCargos.setCodUso(String.valueOf(cambioDeSimCardForm.getUsoVenta()));
			paramObtCargos.setCodArticulo(String.valueOf(cambioDeSimCardForm.getCod_articulo()));
			paramObtCargos.setTipoStock(String.valueOf(cambioDeSimCardForm.getTip_stock()));
			
			// traerlo de la base
			//paramObtCargos.setCodCategoria("0");
			
			paramObtCargos.setNumeroMesesContrato(Integer.parseInt(cambioDeSimCardForm.getTipoContrato()));
			paramObtCargos.setIndCiclo(cambioDeSimCardForm.getTipoContrato().equals("0")?"0":"1");
			
			
			// Creo la coleccion de abonados
			String[] codAbonado =new String [1];
			codAbonado[0]=String.valueOf(sessionData.getNumAbonado());
			paramObtCargos.setAbonados(codAbonado);
	
			ObtencionCargosDTO obtencionCargos = new ObtencionCargosDTO();
			paramObtCargos.setTipoPantalla("6");
			
			paramObtCargos.setCodCausaCambioPlan(cambioDeSimCardForm.getCausaCambio());
			//TODO : validacion se aplican cargos cuando el tipo stock es distinto de 4 es decir mercadería dealer
			SimcardDTO simcardDTO=new SimcardDTO();
			
			
			obtencionCargos=delegate.obtencionCargos(paramObtCargos);
			CargosObtenidosDTO cargosObtenidosDTO=new CargosObtenidosDTO(); 
	
			// esto hay que levantarlo en el action de cargos
			if (obtencionCargos!=null&&obtencionCargos.getCargos()!=null&&obtencionCargos.getCargos().length>0){
				cargosObtenidosDTO.setOcacionales(obtencionCargos);
				sessionData.setCargosObtenidos(cargosObtenidosDTO);
			}
			
			
			
		
		}catch(Exception e){
			
			StringBuffer layout = new StringBuffer();
			
			logger.debug("Exception Cargos Action se procede a cambiar estado de la serie solicitada a disponible para reserva");
			SerieDTO serie = new SerieDTO();
			 String serieSimcard=cambioDeSimCardForm.getNroSerie();
			 serieSimcard=serieSimcard==null?"":serieSimcard;
			 serie.setNum_serie(serieSimcard);
			 
			SimcardDTO simcardDTO=new SimcardDTO();
			delegate.desReservaSerie(serie);
			simcardDTO.setNumeroSerie(serieSimcard);
			simcardDTO=delegate.obtenerSimcard(simcardDTO);
			
			
			PlanTarifarioDTO planTarif=new PlanTarifarioDTO();
			String planT=usuarioAbonado.getCodPlantarif();
			planT=planT==null?"":planT.trim();
			planTarif.setCodPlanTarif(planT);
			planTarif=delegate.getCategoriaPlanTarifario(planTarif);
			String codArticulo=simcardDTO.getCodigoArticulo();
			codArticulo=codArticulo==null?"":codArticulo;
			String numSerie=simcardDTO.getNumeroSerie();
			numSerie=numSerie==null?"":numSerie;
			String codUso=simcardDTO.getCodigoUso();
			codUso=codUso==null?"":codUso;
			String tipoStock=simcardDTO.getTipoStock();
			tipoStock=tipoStock==null?"":tipoStock;
			String codCategoria=planTarif.getCodigoCategoria();
			codCategoria=codCategoria==null?"":codCategoria;
			
			
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
			layout.append("<td class='textoFilasTabla'>" + codArticulo+ "</td>");
			layout.append("</tr>");
			layout.append("<tr>");
			layout.append("<td class='textoColumnaTabla'>Número de Serie</td>");
			layout.append("<td class='textoFilasTabla'>" + numSerie + "</td>");
			layout.append("</tr>");
			layout.append("<tr>");
			layout.append("<td class='textoColumnaTabla'>Código Uso</td>");
			layout.append("<td class='textoFilasTabla'>" + codUso + "</td>");
			layout.append("</tr>");
			
			layout.append("<tr>");
			layout.append("<td class='textoColumnaTabla'>Tipo Stock</td>");
			/**
			 * Para el tipo de stock modificar pl y dao recinfserie
			 */
			layout.append("<td class='textoFilasTabla'>"+tipoStock+"</td>");
			layout.append("</tr>");
			layout.append("<tr>");
			layout.append("<td class='textoColumnaTabla'>Código de Categoría</td>");
			layout.append("<td class='textoFilasTabla'>"+codCategoria+"</td>");
			layout.append("</tr>");
			layout.append("<tr>");
			layout.append("<td class='textoColumnaTabla'>Modalidad de Venta</td>");
			layout.append("<td class='textoFilasTabla'>" + cambioDeSimCardForm.getModalidadPago() + "</td>");
			layout.append("</tr>");layout.append("<tr>");
			layout.append("<td class='textoColumnaTabla'>Tipo de Contrato</td>");
			layout.append("<td class='textoFilasTabla'>" + sessionData.getTipoContrato()+ "</td>");
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
			
			delegate.guardaMensajesError(request, "Error en el Módulo de Cargos", layout.toString());
			return mapping.findForward("error");
		}
		return mapping.findForward("finalizar");
	}
}
