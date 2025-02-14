package com.tmmas.scl.operations.crm.f.s.manpro.web.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.CargoImpuestoDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.CargoOcasionalDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.CargoOcasionalListDTO;
import com.tmmas.scl.framework.marketSalesDomain.contactLeadProspectABE.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.DatosVentaOutDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.CargoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoListDTO;
import com.tmmas.scl.operations.crm.f.s.manpro.web.delegate.ManageProspectBussinessDelegate;
import com.tmmas.scl.operations.crm.f.s.manpro.web.form.CargosForm;
import com.tmmas.scl.operations.crm.f.s.manpro.web.helper.VentaUtils;
import com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.OfertaComercialDTO;
import com.tmmas.scl.operations.crm.f.sel.negsal.helper.NegSalUtils;

public class AplicarCargosAction extends Action 
{
	private final Logger logger = Logger.getLogger(AplicarCargosAction.class);	
	
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception 
	{
		logger.debug("execute ini");
		String forward="GenerarOfertaComercialFW";	
		ManageProspectBussinessDelegate delegate=ManageProspectBussinessDelegate.getInstance();	
		try
		{
			NegSalUtils utils=NegSalUtils.getInstance();		
			CargosForm cargosForm=(CargosForm)form;				
			VentaDTO venta=(VentaDTO)request.getSession().getAttribute("VentaDTO");
			//ArrayList arrayCargosWeb=(ArrayList)request.getSession().getAttribute("ListaCargosMostrados");
			CargoImpuestoDTO cargoImpuestoDTO=(CargoImpuestoDTO)request.getSession().getAttribute("cargoImpuestoDTO");
			
			DatosVentaOutDTO datosVentaOutDTO = new DatosVentaOutDTO();
		 	datosVentaOutDTO.setIdVenta(venta.getIdVenta());
		 	datosVentaOutDTO=delegate.getCodOficinaXVendedor(datosVentaOutDTO);
		 	
			/**
			 * @author rlozano
			 * @description Se vuelve al valor original el importe del cargo ocasional. Se mantiene el descuento
			 * @date 19-08-2009
			 */
			
			String isAplicaImpuesto=(String)request.getSession().getAttribute("isAplicaImpuesto");
			if ("true".equals(isAplicaImpuesto)){
				this.getValorSinImporte(venta.getCliente().getAbonados(),cargoImpuestoDTO);
			}
			logger.debug("venta="+venta);
			OfertaComercialDTO ofertaComercial=delegate.generarOfertaComercial(venta);				
			CargoOcasionalListDTO cargosOcasionales=ofertaComercial.getCargoOcasionalList();
			
			if(ofertaComercial!=null && cargosOcasionales!=null && cargosForm!=null)
			{
				String[] listaConceptosCargos=cargosForm.getCodConceptos();
				String[] listaTotalDescuentoCargos=cargosForm.getTotalDescuentos();
				String[] cantidades=cargosForm.getCantidades();
				double[] listaTotalesCargosXConcepto = obtenerTotalesCargosXConcepto(listaConceptosCargos,cargosOcasionales);
	  		  /**
			    * Aplicacion de descuentos sobre los cargos ocasionales
			    */			
				for(int i=0;i<listaConceptosCargos.length;i++)
				{			   
				   double desc=Double.parseDouble(listaTotalDescuentoCargos[i]);
				   logger.debug("desc="+desc);
				   int cant=Integer.parseInt(cantidades[i]);
				   logger.debug("cant="+cant);
				   //desc=cant<=0?desc:desc/cant;				  
				   double totalCargosXConcepto = listaTotalesCargosXConcepto[i];
				   logger.debug("totalCargosXConcepto="+totalCargosXConcepto);
				   
				   for(int indexCargos=0;indexCargos<cargosOcasionales.getCargoOcasional().length;indexCargos++)
				   {				  
					   String cargoOc = cargosOcasionales.getCargoOcasional()[indexCargos].getImpCargo();
					   logger.debug("cargoOc="+cargoOc);
					   if(cargosOcasionales.getCargoOcasional()[indexCargos].getCodConcepto().equals(listaConceptosCargos[i]))
					   {				  
						   /** 070109 pv : los desc se dividian por la cantidad de cargos, ahora es por % propnl al cargo individual
						    * Formula:
						    * Descuento[i] = (cargo[i]/sumaTotalCargos)*totalDescuento == (cargo[i]*totalDescuento)/sumaTotalCargos;
						    * */
						   String descuento = ""+(Double.parseDouble(cargoOc)/totalCargosXConcepto)*desc;
						   logger.debug("descuento="+descuento);
						   cargosOcasionales.getCargoOcasional()[indexCargos].setTipDescuento("M");
						   cargosOcasionales.getCargoOcasional()[indexCargos].setValDescuento(String.valueOf(descuento));
						   
						   //(+)EV 26/10/09
						   if (isAplicaImpuesto.equals("true")){
							   double descuentoDouble =Double.parseDouble(descuento);
							   
							   if (descuentoDouble>0){
								   cargoImpuestoDTO.setCodCliente(String.valueOf(venta.getCliente().getCodCliente()));
								   cargoImpuestoDTO.setCodOficina(datosVentaOutDTO.getCodOficina());
								   cargoImpuestoDTO.setImporte(descuento);
								   cargoImpuestoDTO.setIdCargo(cargosOcasionales.getCargoOcasional()[indexCargos].getIdCargo());
								   cargoImpuestoDTO=delegate.getImpuestoImporte(cargoImpuestoDTO);
								   logger.debug("cargoImpuestoDTO.getImpuesto()="+cargoImpuestoDTO.getImpuesto());
								   logger.debug("cargoImpuestoDTO.getTotal()="+cargoImpuestoDTO.getTotal());
								   
								   double porcNuevoConImpuesto = (Double.parseDouble(cargoImpuestoDTO.getTotal())*100)/Double.parseDouble(descuento);
								   logger.debug("porcNuevoConImpuesto="+porcNuevoConImpuesto);								   
								   double porcImpuesto = porcNuevoConImpuesto - 100;
								   logger.debug("porcImpuesto="+porcImpuesto);
								   
								   double valorImpuestoDelDescuento = (Double.parseDouble(descuento)*porcImpuesto)/(100+porcImpuesto);
								   logger.debug("valorImpuestoDelDescuento="+valorImpuestoDelDescuento);
								   
								   double valorFinalDescuento = Double.parseDouble(descuento) - valorImpuestoDelDescuento;
								   logger.debug("valorFinalDescuento="+valorFinalDescuento);
								   if (valorFinalDescuento>0){
									   cargosOcasionales.getCargoOcasional()[indexCargos].setValDescuento(String.valueOf(valorFinalDescuento));
								   }
							   }
						   }
						   //(-)


							
					   }								  
				   } 	
				}				   
			}
			/**
			 * Agrupacion de cargos ocacionales por cliente - abonado - concepto
			 */
			cargosOcasionales=utils.agruparCargosOcasionales(cargosOcasionales);					
			/* formateo de float*/
			CargoOcasionalDTO cargoOC = null;
			String impCargo = null;
			for(int i=0;i<cargosOcasionales.getCargoOcasional().length;i++)
			{
				cargoOC = cargosOcasionales.getCargoOcasional()[i];
				impCargo = cargoOC.getImpCargo();
				logger.debug("impCargo  ["+impCargo+"]");
				impCargo = VentaUtils.formatoEstandar(impCargo);
				logger.debug("impCargo  ["+impCargo+"]");
				cargoOC.setImpCargo(impCargo);
			}
			/**/
			ofertaComercial.setCargoOcasionalList(cargosOcasionales);	
			request.getSession().setAttribute("OfertaComercial", ofertaComercial);
		}
		catch(Exception e)
		{
			forward="mensajeError";
			request.setAttribute("exception", e.getMessage());
		}
		logger.debug("execute fin");
		return mapping.findForward(forward);
	}
	
	private static double[] obtenerTotalesCargosXConcepto(String[] listaConceptosCargos, CargoOcasionalListDTO cargosOcasionales) {
		double[] listaTotalesCargosXConcepto = new double[listaConceptosCargos.length];
		String codConcepto = "";
		for(int i=0;i<listaConceptosCargos.length;i++)
		{			   			  
		   double sumaTotalCargos =  0;
		   codConcepto = listaConceptosCargos[i];
		   for(int indexCargos=0;indexCargos<cargosOcasionales.getCargoOcasional().length;indexCargos++)
		   {				  
			   String cargoOc = "";
			   if(cargosOcasionales.getCargoOcasional()[indexCargos].getCodConcepto().equals(codConcepto))
			   {				  
				   cargoOc = cargosOcasionales.getCargoOcasional()[indexCargos].getImpCargo();
				   sumaTotalCargos+=Double.parseDouble(cargoOc);
			   }								  
		   }
		   listaTotalesCargosXConcepto[i] = sumaTotalCargos;
		}
		return listaTotalesCargosXConcepto;
	}
	
	
	
	private AbonadoListDTO getValorSinImporte(AbonadoListDTO abonados,CargoImpuestoDTO cargoImpuestoDTO)throws GeneralException
	{
		logger.debug("getValorSinImporte ini");
		try{
			ManageProspectBussinessDelegate delegate=ManageProspectBussinessDelegate.getInstance();
			for(int indexAbon=0;indexAbon<abonados.getAbonados().length;indexAbon++)
			{	 	
		 	
			 	ProductoOfertadoListDTO prodOferList;
			 	AbonadoDTO abonado=abonados.getAbonados()[indexAbon];
				prodOferList=new ProductoOfertadoListDTO();
				prodOferList.setProductoList(abonado.getProdOfertList().getProductoList());	
				
	 		// FILTRO CARGOS OCASIONALES
				CargoDTO cargo=null;
										
				for(int i=0;i<prodOferList.getProductoList().length;i++)				
				{				
					if(prodOferList.getProductoList()[i].getCargoList()!=null && prodOferList.getProductoList()[i].getCargoList().getCargoList().length>0)
					{
						for(int j=0;j<prodOferList.getProductoList()[i].getCargoList().getCargoList().length;j++)
						{						
							//retorno.getProductoList()[i].setIndCondicionContratacion("O"); // TEMPORAL PARCHE
							cargo=prodOferList.getProductoList()[i].getCargoList().getCargoList()[j];
							String tipoCargo=cargo.getTipoCargo();
							tipoCargo=tipoCargo==null?"":tipoCargo;
							String impuesto=prodOferList.getProductoList()[i].getCargoList().getCargoList()[j].getImpuesto();
							impuesto=impuesto!=null&&"".equals(impuesto)?"0.0":impuesto;
				//formatoEstandar se deberia aplicar a cada operando antes de realizar la operacion matematica 170210 pv
							if ("O".equals(tipoCargo)&&!"0.0".equals(impuesto)){
								String nuevoImporte=String.valueOf(Float.parseFloat(prodOferList.getProductoList()[i].getCargoList().getCargoList()[j].getImporte())-Float.parseFloat(impuesto));
								logger.debug("nuevoImporte  ["+nuevoImporte+"]");
								nuevoImporte = VentaUtils.formatoEstandar(nuevoImporte);
								logger.debug("nuevoImporteSt["+nuevoImporte+"]");
								prodOferList.getProductoList()[i].getCargoList().getCargoList()[j].setImporte(nuevoImporte);
								
								/**
								 * @author rlozano
								 * @description Se resta el impuesto asociado al descuento
								 */
								for (int desc=0;desc<prodOferList.getProductoList()[i].getCargoList().getCargoList()[j].getDescuentos().getDescuentoList().length;desc++){
									cargoImpuestoDTO.setImporte(prodOferList.getProductoList()[i].getCargoList().getCargoList()[j].getDescuentos().getDescuentoList()[desc].getValDescuento());
									cargoImpuestoDTO=delegate.getImpuestoImporte(cargoImpuestoDTO);
									String nuevoValorDesc=String.valueOf(Float.parseFloat(cargoImpuestoDTO.getTotal())-Float.parseFloat(cargoImpuestoDTO.getImpuesto())*2);
									logger.debug("nuevoValorDesc  ["+nuevoValorDesc+"]");
									nuevoValorDesc = VentaUtils.formatoEstandar(nuevoValorDesc);
									logger.debug("nuevoValorDescSt["+nuevoValorDesc+"]");
									prodOferList.getProductoList()[i].getCargoList().getCargoList()[j].getDescuentos().getDescuentoList()[desc].setValDescuento(nuevoValorDesc);
								}
							}
						}
					}
				}
			}
		}
		catch(GeneralException e){
			throw e;
		}
		logger.debug("getValorSinImporte fin");
		return abonados;
	}

}