package com.tmmas.scl.operations.crm.f.s.manpro.web.action;

import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.CargoImpuestoDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ProrrateoDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.CargoRecurrenteDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.DescuentoVendedorDTO;
import com.tmmas.scl.framework.marketSalesDomain.contactLeadProspectABE.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.DatosVentaOutDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.CargoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.DescuentoProductoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoListDTO;
import com.tmmas.scl.operations.crm.f.s.manpro.frmk.dataTransferObject.CargoWebDTO;
import com.tmmas.scl.operations.crm.f.s.manpro.web.delegate.ManageProspectBussinessDelegate;
import com.tmmas.scl.operations.crm.f.s.manpro.web.helper.VentaUtils;

public class DespliegaCargosAction extends Action{

	private final Logger logger = Logger.getLogger(DespliegaCargosAction.class);	 

	
	 public ActionForward execute
	 (			ActionMapping mapping,
				ActionForm form,
				HttpServletRequest request,
				HttpServletResponse response) throws Exception
	 {
		  
		 	String forward="CargosTemp";
		 	HttpSession session = request.getSession(false);
		 	String tipoCobro_A="A";
		 	CargoImpuestoDTO cargoImpuestoDTO= new CargoImpuestoDTO();
		 	try
		 	{
				 	ManageProspectBussinessDelegate delegate=ManageProspectBussinessDelegate.getInstance();
				 	
				 	boolean noHayCargos=true;		 	
				 	ArrayList listaCargosAMostrar=new ArrayList();	
				 	ArrayList listaCargosRecurrentes = new ArrayList();//EV
				 	VentaDTO ventaSesion=(VentaDTO)request.getSession().getAttribute("VentaDTO");
				 	DatosVentaOutDTO datosVentaOutDTO = new DatosVentaOutDTO();
				 	datosVentaOutDTO.setIdVenta(ventaSesion.getIdVenta());
				 	datosVentaOutDTO=delegate.getCodOficinaXVendedor(datosVentaOutDTO);
				 	
				 	String codOperadora = delegate.getCodigoOperadora();
				 	boolean isAplicaImpuesto=codOperadora.equals("TMG")?true:false;
				 	logger.debug("isAplicaImpuesto="+isAplicaImpuesto);
				 	request.getSession().setAttribute("isAplicaImpuesto",isAplicaImpuesto?"true":"false");
				 	
				 	if(ventaSesion!=null)
				 	{
				 		ClienteDTO clienteSession=ventaSesion.getCliente();		 		
				 		request.getSession().setAttribute("ClienteSession", clienteSession);		 		
				 	}
				 	
				 	ClienteDTO cliente=ventaSesion.getCliente();		
					AbonadoListDTO abonados=cliente.getAbonados();
					
					for(int indexAbon=0;indexAbon<abonados.getAbonados().length;indexAbon++)
					{	 	
				 	
					 	ProductoOfertadoListDTO prodOferList;
					 	AbonadoDTO abonado=abonados.getAbonados()[indexAbon];
						abonado.setCodCliente(cliente.getCodCliente());
						ArrayList totalProductosAbonadosArr=new ArrayList();
						
						for(int i=0;i<abonado.getProdOfertList().getProductoList().length;i++)
							totalProductosAbonadosArr.add(abonado.getProdOfertList().getProductoList()[i]);
						for(int i=0;i<abonado.getPaqueteList().getPaqueteList().length;i++)
							totalProductosAbonadosArr.add(abonado.getPaqueteList().getPaqueteList()[i]);
						
						ProductoOfertadoDTO[] productos=(ProductoOfertadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(totalProductosAbonadosArr.toArray(), ProductoOfertadoDTO.class);
						prodOferList=new ProductoOfertadoListDTO();
						
						// INI INC 155400 18112010	
						for (int x= 0; x< productos.length; x++){
							if ("2".equals(productos[x].getTipoPlanAdic())){
								productos[x].setIndCondicionContratacion("B");
							} 
						}
						// FIN INC 155400 18112010	
						prodOferList.setProductoList(productos);
						
						//(+)se guarda para obtener tipocargo original O o R
						request.getSession().setAttribute("cargoImpuestoDTO", cargoImpuestoDTO);
						//(-)
						
			 		// FILTRO CARGOS OCASIONALES
						CargoDTO cargo=null;
						ArrayList listaCargosFiltradosPorTipo=new ArrayList();
						CargoDTO[] arrayCargosFiltrados=null;
						
						CargoWebDTO cargoWeb=null;
						
						logger.debug("**********abonado.getNumAbonado()="+abonado.getNumAbonado()+"**********");
												
						for(int i=0;i<prodOferList.getProductoList().length;i++)				
						{				
							logger.debug("i             ="+i);
							if(prodOferList.getProductoList()[i].getCargoList()!=null && prodOferList.getProductoList()[i].getCargoList().getCargoList().length>0)
							{
								logger.debug("i="+i+"desProdOfertado["+prodOferList.getProductoList()[i].getDesProdOfertado()+"]");
								for(int j=0;j<prodOferList.getProductoList()[i].getCargoList().getCargoList().length;j++)
								{						
									//retorno.getProductoList()[i].setIndCondicionContratacion("O"); // TEMPORAL PARCHE
									cargo=prodOferList.getProductoList()[i].getCargoList().getCargoList()[j];
									String tipoCargo=cargo.getTipoCargo();
									tipoCargo=tipoCargo==null?"":tipoCargo;
									String tipoCobro=prodOferList.getProductoList()[i].getCargoList().getCargoList()[j].getTipoCobro();
									tipoCobro=tipoCobro==null?"":tipoCobro;
									/**
									 * @author rlozano
									 * @description Se agregan todos los cargos Ocasionales + los cargos Recurrentes cuyo tipo de cobro sea Adelantado.
									 * @date 12-08-2009
									 */
									logger.debug("----------------------(+)----------------------j"+j);
									logger.debug("tipoCargo             ="+tipoCargo);
									logger.debug("tipoCobro             ="+tipoCobro);	
									logger.debug("cargo.getIdCargo()    ="+cargo.getIdCargo());
									logger.debug("cargo.getCodConcepto()="+cargo.getCodConcepto());
									logger.debug("cargo.getDescripcion()="+cargo.getDescripcion());
									logger.debug("cargo.getImporte()    ="+cargo.getImporte());									
									logger.debug("----------------------(-)----------------------");
									if ("O".equals(tipoCargo)){
											noHayCargos=false;
											prodOferList.getProductoList()[i].getCargoList().getCargoList()[j].setCodPlanCom("1");
											if ("A".equals(tipoCobro)){
												ProrrateoDTO prorrateoDTO = new ProrrateoDTO();
												CargoRecurrenteDTO cargoRecurrenteDTO= new CargoRecurrenteDTO(); 
												cargoRecurrenteDTO.setNumAbonadoPago(String.valueOf((abonado.getNumAbonado())));
												cargoRecurrenteDTO.setCodCargoContratado(prodOferList.getProductoList()[i].getCargoList().getCargoList()[j].getIdCargo());
												prorrateoDTO=delegate.getCargoRecurrenteProrrateo(cargoRecurrenteDTO);
												prodOferList.getProductoList()[i].getCargoList().getCargoList()[j].setImporte(prorrateoDTO.getImporte());
												
											}
											
											/**
											 * @description Se obtiene el impuesto a sumar a los cargos
											 * 
											 */
											if (isAplicaImpuesto){
												cargoImpuestoDTO.setCodCliente(String.valueOf(abonado.getCodCliente()));
												cargoImpuestoDTO.setCodOficina(datosVentaOutDTO.getCodOficina());
												/**
												 * @author rlozano
												 * @date 19-08-2009
												 * @description se procede a setear el concepto de cargo facturable.
												 */
												cargoImpuestoDTO.setIdCargo(prodOferList.getProductoList()[i].getCargoList().getCargoList()[j].getCodConcepto());
												cargoImpuestoDTO.setImporte(prodOferList.getProductoList()[i].getCargoList().getCargoList()[j].getImporte());
												cargoImpuestoDTO=delegate.getImpuestoImporte(cargoImpuestoDTO);
												logger.debug("cargoImpuestoDTO.getImpuesto()["+cargoImpuestoDTO.getImpuesto()+"]");	
												prodOferList.getProductoList()[i].getCargoList().getCargoList()[j].setImpuesto(cargoImpuestoDTO.getImpuesto());
												prodOferList.getProductoList()[i].getCargoList().getCargoList()[j].setImporte(cargoImpuestoDTO.getTotal());
											}
											cargo.setTipoCobro(prodOferList.getProductoList()[i].getCargoList().getCargoList()[j].getTipoCobro());
											listaCargosFiltradosPorTipo.add(cargo);
									}
									//(+) EV 21/10/2009
									else{ //TipoCargo =R , Recurrente
										CargoWebDTO cargoWebRec = new CargoWebDTO();
										cargoWebRec.setIdCargo(cargo.getIdCargo());
										cargoWebRec.setCodCliente(String.valueOf(cliente.getCodCliente()));
										cargoWebRec.setNumAbonado(String.valueOf(abonado.getNumAbonado()));
										cargoWebRec.setCodConcepto(cargo.getCodConcepto());
										cargoWebRec.setTipoCobro(cargo.getTipoCobro());
										cargoWebRec.setTipoCargo(cargo.getTipoCargo());
										listaCargosRecurrentes.add(cargoWebRec);
									}
									//(-) EV 21/10/2009									
								}
							}
						}
						
						if(!noHayCargos)
						{
							logger.debug("------------------------ 1----------------------------------");
							arrayCargosFiltrados=(CargoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(listaCargosFiltradosPorTipo.toArray(), CargoDTO.class);					
							for(int i=0;i<arrayCargosFiltrados.length;i++)
							{
								boolean match=false;
								if(!listaCargosAMostrar.isEmpty())
								{
									Iterator it=listaCargosAMostrar.iterator();
									while(it.hasNext())
									{
										cargoWeb=new CargoWebDTO();
										cargoWeb=(CargoWebDTO)it.next();						
										if(cargoWeb.getCodConcepto().equals(arrayCargosFiltrados[i].getCodConcepto()))
										{
											logger.debug("----------------------------------------");
											int index=listaCargosAMostrar.indexOf(cargoWeb);
											match=true;
											int cantidad=Integer.parseInt(cargoWeb.getCantidad());
											logger.debug("          i          ["+i+"]");
											logger.debug("cargoWeb.getImporte()["+cargoWeb.getImporte()+"]");
											float importe=Float.parseFloat(cargoWeb.getImporte());
											logger.debug("importe(parseFloat)  ["+importe+"]");
											logger.debug("arrCrgsFi[i]Importe  ["+arrayCargosFiltrados[i].getImporte()+"]");
											importe=importe+Float.parseFloat(arrayCargosFiltrados[i].getImporte());
											logger.debug("importe(prFlt+arrImp)["+importe+"]");
											cantidad++;
											cargoWeb.setCantidad(String.valueOf(cantidad));
											cargoWeb.setImporte(String.valueOf(importe));
											logger.debug("cargoWeb.getImporte()["+cargoWeb.getImporte()+"]");
											cargoWeb.setSaldoTotal(String.valueOf(importe));
											listaCargosAMostrar.set(index, cargoWeb);
											logger.debug("----------------------------------------");
										}						
									}					
								}
								if(!match)
								{
									logger.debug("------------------------ 2----------------------------------");
									cargoWeb=new CargoWebDTO();					
									cargoWeb.setSaldoTotal(arrayCargosFiltrados[i].getImporte());					
									cargoWeb.setCargoDTO(arrayCargosFiltrados[i]);
									listaCargosAMostrar.add(cargoWeb);
								}
							}
							
							/*//CALCULO DE DESCUENTOS 
							Iterator it=listaCargosAMostrar.iterator();
							cargoWeb=null;
								while(it.hasNext())
								{
									cargoWeb=new CargoWebDTO();
									cargoWeb=(CargoWebDTO)it.next();
									double totalDescAuto=0;
									double saltoTotalActual=Double.parseDouble(cargoWeb.getSaldoTotal());
									int index=listaCargosAMostrar.indexOf(cargoWeb);
									
									for(int i=0;i<cargoWeb.getDescuentos().getDescuentoList().length;i++)
									{
										DescuentoProductoDTO desc=null;
										double descAux=0;
										desc=cargoWeb.getDescuentos().getDescuentoList()[i];
										descAux=Integer.parseInt(desc.getValDescuento());
										
										if("M".equalsIgnoreCase(desc.getTipDescuento()))
										{
											descAux=descAux*Double.parseDouble(cargoWeb.getCantidad());
											totalDescAuto=totalDescAuto+descAux;
											cargoWeb.getDescuentos().getDescuentoList()[i].setValDescuento(String.valueOf(Math.round(descAux)));
										}
										else if("P".equalsIgnoreCase(desc.getTipDescuento()))
										{
											//El importe ya esta sumado, por lo que no es necesario volver a sumarlo
											descAux=(descAux/100)*Double.parseDouble(cargoWeb.getImporte());					
											totalDescAuto=totalDescAuto+descAux;
										}
									}	
									
									saltoTotalActual=saltoTotalActual-totalDescAuto;
									cargoWeb.setSaldoTotal(String.valueOf(Math.round(saltoTotalActual)));
									cargoWeb.setTotalDescuentosAutomaticos(String.valueOf(Math.round(totalDescAuto)));
									listaCargosAMostrar.set(index, cargoWeb);				
								}	*/			
						
					      }
				    }
					
		//			CALCULO DE DESCUENTOS 
					if(!noHayCargos)
					{
						logger.debug("------------------------ 3----------------------------------");
						Iterator it=listaCargosAMostrar.iterator();
						//cargoWeb=null;
						int indit = 0;
						while(it.hasNext())
						{
							logger.debug("------------ini--indit ["+indit+"]-------------------");
							CargoWebDTO cargoWeb=new CargoWebDTO();
							cargoWeb=(CargoWebDTO)it.next();
							double totalDescAuto=0;
							logger.debug("cargoWeb.getSaldoTotal()["+cargoWeb.getSaldoTotal()+"]");
							double saltoTotalActual=Double.parseDouble(cargoWeb.getSaldoTotal());
							logger.debug("saltoTotalActual(parseD)["+saltoTotalActual+"]");
							int index=listaCargosAMostrar.indexOf(cargoWeb);
							logger.debug("cargoWeb.getTipoCobro()["+cargoWeb.getTipoCobro()+"]");
							//cargoWeb.setTipoCobro(cargoWeb.getDescuentos().getDescuentoList().length>0?"V":"A");
							//logger.debug("despues,cargoWeb.getTipoCobro()="+cargoWeb.getTipoCobro());
							if(cargoWeb.getDescuentos()!=null && 
							   cargoWeb.getDescuentos().getDescuentoList()!=null)
							{
								logger.debug("cargoWeb.getDescuentos().getDescuentoList().length["+cargoWeb.getDescuentos().getDescuentoList().length+"]");
								for(int i=0;i<cargoWeb.getDescuentos().getDescuentoList().length;i++)
								{
									DescuentoProductoDTO desc=null;
									double descAux=0;
									desc=cargoWeb.getDescuentos().getDescuentoList()[i];
									descAux=Integer.parseInt(desc.getValDescuento());
									logger.debug("desc.getTipDescuento["+desc.getTipDescuento()+"]");
									logger.debug("descAux             ["+descAux+"]");
									if("M".equalsIgnoreCase(desc.getTipDescuento()))
									{
										
										descAux=descAux*Double.parseDouble(cargoWeb.getCantidad());
										logger.debug("MdescAux*Dbl"+cargoWeb.getCantidad()+"["+descAux+"]");
										logger.debug("1totalDescAuto ["+totalDescAuto+"]");
										totalDescAuto=totalDescAuto+descAux;
										logger.debug("2totalDescAuto ["+totalDescAuto+"]");
										cargoWeb.getDescuentos().getDescuentoList()[i].setValDescuento(String.valueOf(Math.round(descAux)));
									}
									else if("P".equalsIgnoreCase(desc.getTipDescuento()))
									{
										//El importe ya esta sumado, por lo que no es necesario volver a sumarlo
										descAux=(descAux/100)*Double.parseDouble(cargoWeb.getImporte());					
										logger.debug("P(descAux/100)*Dbl"+cargoWeb.getImporte()+"["+descAux+"]");
										logger.debug("1totalDescAuto ["+totalDescAuto+"]");
										totalDescAuto=totalDescAuto+descAux;
										logger.debug("2totalDescAuto ["+totalDescAuto+"]");
									}
								}
							}

							
							saltoTotalActual=saltoTotalActual-totalDescAuto;
							logger.debug("saltoTotalActual(-tDAt)["+saltoTotalActual+"]");
							/*cargoWeb.setSaldoTotal(String.valueOf(Math.round(saltoTotalActual)));
							cargoWeb.setTotalDescuentosAutomaticos(String.valueOf(Math.round(totalDescAuto)));*/
							cargoWeb.setSaldoTotal(String.valueOf(saltoTotalActual));
							logger.debug("cargoWeb.getSaldoTotal()(Svof)["+cargoWeb.getSaldoTotal()+"]");
							cargoWeb.setTotalDescuentosAutomaticos(String.valueOf(totalDescAuto));
							
							boolean tipoCobro=cargoWeb.getTipoCobro()!=null&&"A".equals(cargoWeb.getTipoCobro())?true:false;
							cargoWeb.setAplicaDesc(tipoCobro);
							listaCargosAMostrar.set(index, cargoWeb);
							
							indit++;
						}
						logger.debug("------------fin--while ["+indit+"]-------------------");
					}
					
					request.getSession().setAttribute("tipoCobro_A", tipoCobro_A);
					request.getSession().setAttribute("VentaDTO", ventaSesion);
					CargoWebDTO cargoAMostrar = null;
					String saldoTotal = null;
					for(int i=0;i<listaCargosAMostrar.size();i++)
					{
						cargoAMostrar = (CargoWebDTO) listaCargosAMostrar.get(i);
						saldoTotal = cargoAMostrar.getSaldoTotal();
						logger.debug("saldoTotal  ["+saldoTotal+"]");
						saldoTotal = VentaUtils.formatoEstandar(saldoTotal);
						logger.debug("saldoTotal  ["+saldoTotal+"]");
						cargoAMostrar.setSaldoTotal(saldoTotal);
						listaCargosAMostrar.set(i, cargoAMostrar);
					}
					request.getSession().setAttribute("ListaCargosMostrados", listaCargosAMostrar);	
					request.getSession().setAttribute("cargoImpuestoDTO", cargoImpuestoDTO);
					request.getSession().setAttribute("listaCargosRecurrentes", listaCargosRecurrentes);//EV
					
					if(noHayCargos)
					{
						forward="GenerarOfertaComercialFW";
					}
					else{
						
						/***
						 * @author rlozano
						 * @description se obtiene los limites superior e inferior de descuentos por vendedor
						 * 
						 */
						logger.debug("------------------------ 4----------------------------------");
						logger.debug("Inicio::Descuentos del Vendedor");
						DescuentoVendedorDTO descVend = new DescuentoVendedorDTO();
						descVend.setCodVendedor(Integer.parseInt(ventaSesion.getCodVendedor()));
						descVend = delegate.obtenerDescuentoVendedor(descVend);
						
						request.setAttribute("indCreaDesc",String.valueOf(descVend.getIndCreaDescuento()));
						request.setAttribute("rangoInf",""+String.valueOf(descVend.getRangoInfPorcDescuento()));
						request.setAttribute("rangoSup", ""+String.valueOf(descVend.getRangoSupPorcDescuento()));   //DESCOMENTAR
						logger.debug("indCreaDesc::"+String.valueOf(descVend.getIndCreaDescuento()));
						logger.debug("Descuento Inferior::"+String.valueOf(descVend.getIndCreaDescuento()));
						logger.debug("Descuento Superior::"+String.valueOf(descVend.getRangoSupPorcDescuento()));
						
						
						logger.debug("Fin::Descuentos del Vendedor");
						
						
					}
		 	}
		 	catch(Exception e)
		 	{
		 		forward="mensajeError";
		 		String msjerror=e.getMessage()+" Error al generar estructura de cargos";
				String loge = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + loge + "]");
				request.setAttribute("exception",msjerror );
				
		 	}
			return mapping.findForward(forward);
	 }
}