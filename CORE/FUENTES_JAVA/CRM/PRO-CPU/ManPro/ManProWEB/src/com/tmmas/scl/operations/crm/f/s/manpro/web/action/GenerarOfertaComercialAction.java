package com.tmmas.scl.operations.crm.f.s.manpro.web.action;

import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.SerializationUtils;
import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.CobroAdelantadoDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.CargoRecurrenteDTO;
import com.tmmas.scl.framework.marketSalesDomain.contactLeadProspectABE.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ParametroSerializableDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.CargoDTO;
import com.tmmas.scl.operations.crm.f.s.manpro.frmk.dataTransferObject.CargoWebDTO;
import com.tmmas.scl.operations.crm.f.s.manpro.web.delegate.ManageProspectBussinessDelegate;
import com.tmmas.scl.operations.crm.f.s.manpro.web.helper.Global;
import com.tmmas.scl.operations.crm.f.s.manpro.web.helper.NavegacionWeb;
import com.tmmas.scl.operations.crm.f.s.manpro.web.helper.VentaUtils;
import com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.OfertaComercialDTO;
import com.tmmas.scl.operations.crm.f.sel.negsal.exception.NegSalException;
import com.tmmas.scl.operations.crm.o.csr.supordhan.common.exception.SupOrdHanException;

public class GenerarOfertaComercialAction extends Action 
{
	private static Logger logger = Logger.getLogger(GenerarOfertaComercialAction.class);
	private Global global = Global.getInstance();
	
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			
	{
		
		HttpSession session = request.getSession();
		VentaDTO venta=(VentaDTO)request.getSession().getAttribute("VentaDTO");
		NavegacionWeb navegacion = (NavegacionWeb) session.getAttribute("navegacion");
		OfertaComercialDTO ofertaComercial=(OfertaComercialDTO)request.getSession().getAttribute("OfertaComercial");
		VentaUtils ventaUtils=VentaUtils.getInstance();
		
		ManageProspectBussinessDelegate delegate=ManageProspectBussinessDelegate.getInstance();		
		String mensajeSalida="";			
		String mensajeSalidaSinPDT = "No existen planes adicionales a contratar";
		String bandContDefecto=request.getParameter("contratarPorDefecto")!=null?request.getParameter("contratarPorDefecto"):"0";
		
		//(+) EV, completa lista de cargos con cobro adelantado :CargoRecurrenteDTO[]
		ArrayList listaCargosRecurrentes = (ArrayList)session.getAttribute("listaCargosRecurrentes");

		ArrayList listaCargosRecurrentesAdelantados = new ArrayList();
		CargoRecurrenteDTO[] cargosCobroAdelantado= new CargoRecurrenteDTO[0];
		
		if (listaCargosRecurrentes!=null){
			Iterator it=listaCargosRecurrentes.iterator();
			while(it.hasNext())
			{
					CargoWebDTO cargoWeb =(CargoWebDTO)it.next();
					logger.debug("----------(+)cargos recurrentes -----------");
					logger.debug("cargoWeb.getIdCargo()="+cargoWeb.getIdCargo());					
					logger.debug("cargoWeb.getCodConcepto()="+cargoWeb.getCodConcepto());
					logger.debug("cargoWeb.getTipoCobro()="+cargoWeb.getTipoCobro());
					
					if (cargoWeb.getTipoCobro().equals("A")){
						logger.debug("ADELANTADO");
						CargoRecurrenteDTO cargoRecAd = new CargoRecurrenteDTO();
						cargoRecAd.setNumVenta(venta.getIdVenta());
						cargoRecAd.setCodUltCiclFact(String.valueOf(venta.getCliente().getCodCicloFacturacion()));
						cargoRecAd.setCodClientePago(cargoWeb.getCodCliente());
						cargoRecAd.setNumAbonadoPago(cargoWeb.getNumAbonado());
						cargoRecAd.setCodConcepto(cargoWeb.getCodConcepto());
						cargoRecAd.setNomUsuario(venta.getNomUsuaOra());
						
						logger.debug("cargoRecAd.getNumVenta()="+cargoRecAd.getNumVenta());
						logger.debug("cargoRecAd.getCodUltCiclFact()="+cargoRecAd.getCodUltCiclFact());
						logger.debug("cargoRecAd.getCodClientePago()="+cargoRecAd.getCodClientePago());
						logger.debug("cargoRecAd.getNumAbonadoPago()="+cargoRecAd.getNumAbonadoPago());
						logger.debug("cargoRecAd.getNomUsuario()="+cargoRecAd.getNomUsuario());
						
						listaCargosRecurrentesAdelantados.add(cargoRecAd);
					}
					logger.debug("----------(-)cargos recurrentes -----------");					
			}
			
			cargosCobroAdelantado = (CargoRecurrenteDTO[]) ArrayUtl.copiaArregloTipoEspecifico(listaCargosRecurrentesAdelantados.toArray(), CargoRecurrenteDTO.class);
		}
		//(-) EV, completa lista con cargos con cobro adelantado
		
		try 
		{
			if(ofertaComercial!=null)
			{									 
				if(!navegacion.hayPDTporDefecto() && !ventaUtils.hayProductosCheckeados(navegacion, venta)){
					mensajeSalida=mensajeSalidaSinPDT;
				//(+) EV 06/02/09
					ParametroSerializableDTO param=new ParametroSerializableDTO();
					param.setEstadoProceso("PROCESADO");
					param.setNumProceso(ofertaComercial.getNumProceso());
					param.setIdProceso(ofertaComercial.getNumEvento());
					param.setOrigenProceso("VT");
					param.setObjetoSerializado((byte[])SerializationUtils.serialize(ofertaComercial));	
					logger.debug("No existen planes adicionales a contratar, no ejecuta activarOfertaComercialJms");
					delegate.inscribeProceso(param);
					
				}
				else{
					logger.debug("--------llama a activarOfertaComercialJms--------------------");
					delegate.activarOfertaComercialJms(ofertaComercial,cargosCobroAdelantado);
					delegate.inscribeProceso(ofertaComercial);
					mensajeSalida="Oferta comercial enviada correctamente";					
					
					if ("1".equals(request.getSession().getAttribute("contratarPorDefecto"))) // INC 155400 18112010 VMB
						mensajeSalida="Enviado a contratar productos por defecto"; // INC 155400 18112010 VMB
						
				}
				//(-) EV 06/02/09				
			}		
			//INC 155400 VMB 24112010 Se agrego esta linea cuando se presiona Boton Salir
			//y que no haga nada			
			else if ("1".equalsIgnoreCase(bandContDefecto)) {							
				mensajeSalida="Salida de Oferta Comercial";
			}
			//FIN INC
			else if(!"0".equalsIgnoreCase(bandContDefecto))
			{				
				mensajeSalida="Enviado a contratar productos por defecto";
				if(!navegacion.hayPDTporDefecto())
				{
					mensajeSalida=mensajeSalidaSinPDT;
				}
				
				delegate.contrataProductosPorDefecto(venta);
			}
			else
			{
				//NegSalUtils utils=NegSalUtils.getInstance();							
				try
				{		
					//ofertaComercial=utils.generarOfertaComercial(venta);
					ofertaComercial=delegate.generarOfertaComercial(venta);
					if(!navegacion.hayPDTporDefecto() && !ventaUtils.hayProductosCheckeados(navegacion, venta)){
						mensajeSalida=mensajeSalidaSinPDT;
						//(+) EV 09/02/09
						ParametroSerializableDTO param=new ParametroSerializableDTO();
						param.setEstadoProceso("PROCESADO");
						param.setNumProceso(ofertaComercial.getNumProceso());
						param.setIdProceso(ofertaComercial.getNumEvento());
						param.setOrigenProceso("VT");
						param.setObjetoSerializado((byte[])SerializationUtils.serialize(ofertaComercial));	
						logger.debug("No existen planes adicionales a contratar, no ejecuta activarOfertaComercialJms");
						delegate.inscribeProceso(param);
					
					}
					else{
						logger.debug("--------llama a activarOfertaComercialJms--------------------");
						delegate.activarOfertaComercialJms(ofertaComercial,cargosCobroAdelantado);
						delegate.inscribeProceso(ofertaComercial);
						mensajeSalida="Oferta comercial enviada correctamente";

						if ("1".equals(request.getSession().getAttribute("contratarPorDefecto"))) // VMB 18-11-2010 INC 155400
							mensajeSalida="Salida de Oferta ComercialEnviado a contratar productos por defecto";            // VMB 18-11-2010 INC 155400
						    

						
					}
					//(-) EV 09/02/09	
					
				}
				catch(Exception e)
				{
					mensajeSalida="Ocurrio un error al publicar la oferta comercial";
				}
			}			
	    }
		catch (SupOrdHanException e) 
		{			
			String mensajeOut=e.getMessage();
			request.setAttribute("mensajeSalida", mensajeOut);
			return mapping.findForward("mensaje");
		}
		catch (NegSalException e) 
		{
			String mensajeOut=e.getMessage();
			request.setAttribute("mensajeSalida", mensajeOut);
			return mapping.findForward("mensaje");
		}
		catch (GeneralException e) 
		{
			String mensajeOut=e.getMessage();
			request.setAttribute("mensajeSalida", mensajeOut);
			return mapping.findForward("mensaje");
		}
		catch(Exception e)
		{
			String mensajeOut=e.getMessage();
			request.setAttribute("mensajeSalida", mensajeOut);
			return mapping.findForward("mensaje");
		}
		
		request.setAttribute("mensajeSalida", mensajeSalida);		
		return mapping.findForward("mensaje");
				
	}
}