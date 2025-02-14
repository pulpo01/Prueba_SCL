package com.tmmas.scl.operations.crm.fab.cim.manreq.web.action;

import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.BaseAction;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ConversionDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ConversionListDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.framework.marketSalesDomain.contactLeadProspectABE.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ParametroSerializableDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.CargoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.CargoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.DescuentoProductoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoListDTO;
import com.tmmas.scl.operations.crm.f.sel.negsal.helper.NegSalUtils;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.CargoWebDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate.ManageRequestBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.ProductoForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.Global;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.NavegacionWeb;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.PaqueteWeb;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.ProductoWeb;

public class FlujoContDescPlanesAAction extends BaseAction {
	
	private final Logger logger = Logger.getLogger(FlujoContDescPlanesAAction.class);
	private Global global = Global.getInstance();
	
	private ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();
	private String CLASS_NAME = "FlujoContDescPlanesAAction ";
	public ActionForward executeAction(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);
	
		logger.debug("execute():start");
		//ListaProdContratadosForm form1 = (ListaProdContratadosForm) form;
		//System.out.println("form.getClass() "+form.getClass());
		ProductoForm form1 = (ProductoForm) form;
	    ClienteOSSesionDTO sessionData = new ClienteOSSesionDTO();
	    HttpSession session = request.getSession(false);
	    sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");
		session.removeAttribute("listaCargosAMostrar");
		session.removeAttribute("listaCargosRecurrentes");
		ArrayList listaCargosAMostrar=new ArrayList();
		ArrayList listaCargosRecurrentes=new ArrayList();
	    //Objetos de session que contiene los numeros que deberan ser recuperadas en el action de registro de afines 
	    //y setearlas como atributos del objeto que se registrara
		//session.setAttribute("productoContratadoListDesc", productoContratadoListDesc);
		//session.setAttribute("productoOfertadoListCont", productoOfertadoListCont);
	    
	    SecuenciaDTO secuencia=new SecuenciaDTO();
	    if(sessionData.getNumOrdenServicio()== 0){
			logger.debug("obtenerSecuencia:antes");
			secuencia.setNomSecuencia("CI_SEQ_NUMOS");
			logger.debug("nomSecuencia :"+secuencia.getNomSecuencia());
			secuencia = delegate.obtenerSecuencia(secuencia);
		    sessionData.setNumOrdenServicio(secuencia.getNumSecuencia());
		    logger.debug("obtenerSecuencia:despues");
		}
	    
	    
	    
	    String[] codAbonado = new String[1];
	    codAbonado[0] = String.valueOf(sessionData.getAbonados()[0].getNumAbonado());
	    
	    ConversionListDTO conversionList=null;
	    ConversionDTO param = new ConversionDTO();
		param.setCodOOSS(sessionData.getCodOrdenServicio());
		param.setCodTipModi("-");
		logger.debug("param.getCodOOSS()    :["+param.getCodOOSS()+"]");
		logger.debug("param.getCodTipModi() :["+param.getCodTipModi()+"]");
		logger.debug("obtenerConversionOOSS():inicio");
		conversionList = delegate.obtenerConversionOOSS(param);
		logger.debug("obtenerConversionOOSS():fin");
		
		sessionData.setCodAbonado(codAbonado);
		sessionData.setSinCondicionesComerciales(form1.getCondicH());
		sessionData.setCodActAbo(conversionList.getRegistros()[0].getCodActuacion());
		sessionData.setTipoPantallaPrevia(String.valueOf(2));  // Se setea valor 2 para que en la query dinamica de obtencion de cargos por uso, no se considerado el codigo de concepto
		sessionData.setObtenerCargos("SI");
		sessionData.setCodActAboCargosUso(conversionList.getRegistros()[0].getCodActuacion());
		ProductoOfertadoListDTO productoOfertadoListCont     = (ProductoOfertadoListDTO) session.getAttribute("productoOfertadoListCont");
		//sessionData.getAbonados()[0].setProdOfertList(productoOfertadoListCont);//AbonadoDTO abonado = 
		//abonado.setProdOfertList(productoOfertadoListCont);

		sessionData.getCliente().getAbonados().getAbonados()[0].setProdOfertList(productoOfertadoListCont);
		sessionData.getCliente().getAbonados().getAbonados()[0]= obtienePaquetes(sessionData.getCliente().getAbonados().getAbonados()[0]);
		generarCargosWeb(sessionData.getCliente(),listaCargosAMostrar,listaCargosRecurrentes);
		
		String numProceso = ""+sessionData.getNumOrdenServicio();
		logger.debug("crearProceso con numProceso ["+numProceso+"]");
		ParametroSerializableDTO proceso=delegate.crearProceso(numProceso);
		
		VentaDTO venta = obtieneVentaDto(sessionData,session);
		venta.setNumEvento(proceso.getIdProceso());

		session.setAttribute("listaCargosAMostrar", listaCargosAMostrar);
		session.setAttribute("listaCargosRecurrentes", listaCargosRecurrentes);
		//imprimeCargosFlujo(listaCargosAMostrar,listaCargosRecurrentes);
		session.setAttribute("ClienteOOSS", sessionData);
		session.setAttribute("venta", venta);
		logger.debug("execute():end");
		return mapping.findForward("cargosContDescPlan");
	}

	private void imprimeCargosFlujo(ArrayList listaCargosAMostrar, ArrayList listaCargosRecurrentes) {
		CargoWebDTO cargoWebDTO = null;
		logger.debug(CLASS_NAME+"listaCargosAMostrar ini");
		for(int i=0;i<listaCargosAMostrar.size();i++)
		{
			cargoWebDTO = (CargoWebDTO)listaCargosAMostrar.get(i);
			logger.debug(CLASS_NAME+"cantidad       "+cargoWebDTO.getCantidad());
			logger.debug(CLASS_NAME+"importe        "+cargoWebDTO.getImporte());
			logger.debug(CLASS_NAME+"desMoneda      "+cargoWebDTO.getDesMoneda());
			logger.debug(CLASS_NAME+"saldoTotal     "+cargoWebDTO.getSaldoTotal());
			logger.debug(CLASS_NAME+"totalDesAuto() "+cargoWebDTO.getTotalDescuentosAutomaticos());
			logger.debug(CLASS_NAME+"codConcepto()  "+cargoWebDTO.getCodConcepto());
			logger.debug("----------------------------------------------------------");
		}
		logger.debug(CLASS_NAME+"listaCargosAMostrar fin");
		logger.debug(CLASS_NAME+"listaCargosRecurrentes ini");
		for(int i=0;i<listaCargosRecurrentes.size();i++)
		{
			cargoWebDTO = (CargoWebDTO)listaCargosRecurrentes.get(i);
			logger.debug(CLASS_NAME+"cantidad       "+cargoWebDTO.getCantidad());
			logger.debug(CLASS_NAME+"importe        "+cargoWebDTO.getImporte());
			logger.debug(CLASS_NAME+"desMoneda      "+cargoWebDTO.getDesMoneda());
			logger.debug(CLASS_NAME+"saldoTotal     "+cargoWebDTO.getSaldoTotal());
			logger.debug(CLASS_NAME+"totalDesAuto() "+cargoWebDTO.getTotalDescuentosAutomaticos());
			logger.debug(CLASS_NAME+"codConcepto()  "+cargoWebDTO.getCodConcepto());
			logger.debug("----------------------------------------------------------");
		}
		logger.debug(CLASS_NAME+"listaCargosRecurrentes fin");
		
	}

	private void generarCargosWeb(ClienteDTO cliente, ArrayList listaCargosAMostrar, ArrayList listaCargosRecurrentes) {

		boolean noHayCargos=true;
	 	//if(venta!=null)
	 	//{
	 		//ClienteDTO clienteSession=venta.getCliente();		 		
	 		//request.getSession().setAttribute("ClienteSession", clienteSession);		 		
	 	//}
	 	
	 	//ClienteDTO cliente=venta.getCliente();		
		AbonadoListDTO abonados=cliente.getAbonados();
		for(int indexAbon=0;indexAbon<abonados.getAbonados().length;indexAbon++)
		{	 	
	 	
		 	ProductoOfertadoListDTO prodOferList;
		 	AbonadoDTO abonado=abonados.getAbonados()[indexAbon];
			abonado.setCodCliente(cliente.getCodCliente());
			ArrayList totalProductosAbonadosArr=new ArrayList();
			boolean isNullListProd=abonado.getProdOfertList()==null||abonado.getProdOfertList().getProductoList()==null?true:false;
			boolean isNullListPaq=abonado.getPaqueteList()==null||abonado.getPaqueteList().getPaqueteList()==null?true:false;
			
			for(int i=0;!isNullListProd&&i<abonado.getProdOfertList().getProductoList().length;i++)
				totalProductosAbonadosArr.add(abonado.getProdOfertList().getProductoList()[i]);
			for(int i=0;!isNullListPaq&&i<abonado.getPaqueteList().getPaqueteList().length;i++)
				totalProductosAbonadosArr.add(abonado.getPaqueteList().getPaqueteList()[i]);
			
			ProductoOfertadoDTO[] productos=(ProductoOfertadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(totalProductosAbonadosArr.toArray(), ProductoOfertadoDTO.class);
			prodOferList=new ProductoOfertadoListDTO();
			prodOferList.setProductoList(productos);	
			
		
 		// FILTRO CARGOS OCASIONALES
			CargoDTO cargo=null;
			ArrayList listaCargosFiltradosPorTipo=new ArrayList();
			
			CargoDTO[] arrayCargosFiltrados=null;
			
			CargoWebDTO cargoWeb=null;
			CargoWebDTO cargoWebRec=null;	
			
			for(int i=0;i<prodOferList.getProductoList().length;i++)				
			{				
				if(prodOferList.getProductoList()[i].getCargoList()!=null && prodOferList.getProductoList()[i].getCargoList().getCargoList().length>0)
				{
					noHayCargos=false;
					for(int j=0;j<prodOferList.getProductoList()[i].getCargoList().getCargoList().length;j++)
					{						
						//retorno.getProductoList()[i].setIndCondicionContratacion("O"); // TEMPORAL PARCHE
						
						cargo=prodOferList.getProductoList()[i].getCargoList().getCargoList()[j];
						if(cargo.getTipoCargo()!=null && !"".equals(cargo.getTipoCargo()) && "O".equals(cargo.getTipoCargo()))
						{		
							prodOferList.getProductoList()[i].getCargoList().getCargoList()[j].setCodPlanCom("1");
							listaCargosFiltradosPorTipo.add(cargo);
						}
						
						if(cargo.getTipoCargo()!=null && !"".equals(cargo.getTipoCargo()) && "R".equals(cargo.getTipoCargo()))
						{		
							prodOferList.getProductoList()[i].getCargoList().getCargoList()[j].setCodPlanCom("1");
							cargoWebRec = obtieneCargoWebDto(cargo);
							listaCargosRecurrentes.add(cargoWebRec);
						}
					}
				}
			}
			
			if(!noHayCargos)
			{
				arrayCargosFiltrados=(CargoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(listaCargosFiltradosPorTipo.toArray(), CargoDTO.class);
				
				for(int i=0;i<arrayCargosFiltrados.length;i++)
				{
					boolean match=false;
					if(!listaCargosAMostrar.isEmpty())
					{
						Iterator it=listaCargosAMostrar.iterator();
						while(it.hasNext())
						{
							//cargoWeb=new CargoWebDTO();
							cargoWeb=(CargoWebDTO)it.next();						
							if(cargoWeb.getCodConcepto().equals(arrayCargosFiltrados[i].getCodConcepto()))
							{
								int index=listaCargosAMostrar.indexOf(cargoWeb);
								match=true;
								int cantidad=Integer.parseInt(cargoWeb.getCantidad());
								int importe=Integer.parseInt(cargoWeb.getImporte());
								//importe=importe+Integer.parseInt(arrayCargosFiltrados[i].getImporte()); EV
								cantidad++;
								cargoWeb.setCantidad(String.valueOf(cantidad));
								cargoWeb.setImporte(String.valueOf(importe));
								cargoWeb.setSaldoTotal(String.valueOf(importe));
								listaCargosAMostrar.set(index, cargoWeb);							
							}						
						}					
					}
					if(!match)
					{
						cargoWeb=new CargoWebDTO();					
						cargoWeb.setSaldoTotal(arrayCargosFiltrados[i].getImporte());					
						cargoWeb.setCargoDTO(arrayCargosFiltrados[i]);
						listaCargosAMostrar.add(cargoWeb);
					}
				}
				
				
			
		      }
	    }
		
//		CALCULO DE DESCUENTOS 
		if(!noHayCargos)
		{
			Iterator it=listaCargosAMostrar.iterator();
			//cargoWeb=null;
			while(it.hasNext())
			{
					CargoWebDTO cargoWeb=new CargoWebDTO();
					cargoWeb=(CargoWebDTO)it.next();
					double totalDescAuto=0;
					double saltoTotalActual=Double.parseDouble(cargoWeb.getSaldoTotal());
					int index=listaCargosAMostrar.indexOf(cargoWeb);
					boolean aplicaDesc=cargoWeb.getDescuentos()==null||cargoWeb.getDescuentos().getDescuentoList()==null||cargoWeb.getDescuentos().getDescuentoList().length==0?false:true;
					if (aplicaDesc){
						for(int i=0;i<cargoWeb.getDescuentos().getDescuentoList().length;i++)
						{
							DescuentoProductoDTO desc=null;
							double descAux=0;
							desc=cargoWeb.getDescuentos().getDescuentoList()[i];
							descAux=Double.parseDouble(desc.getValDescuento());//Integer.parseInt(desc.getValDescuento());
							
							if("M".equalsIgnoreCase(desc.getTipDescuento()))
							{
								//descAux=descAux*Double.parseDouble(cargoWeb.getCantidad()); EV 05/01/09
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
					}
					saltoTotalActual=saltoTotalActual-totalDescAuto;
					cargoWeb.setSaldoTotal(String.valueOf(Math.round(saltoTotalActual)));
					cargoWeb.setTotalDescuentosAutomaticos(String.valueOf(Math.round(totalDescAuto)));
					listaCargosAMostrar.set(index, cargoWeb);				
			}	
		}
	}
	
	private CargoWebDTO obtieneCargoWebDto(CargoDTO cargo) {
		CargoWebDTO retorno = new CargoWebDTO();
		retorno.setImporte(cargo.getImporte());
		retorno.setCodConcepto(cargo.getCodConcepto());
		retorno.setDescripcion(cargo.getDescripcion());
		retorno.setMoneda(cargo.getMoneda());
		retorno.setDesMoneda(cargo.getDesMoneda());
		retorno.setDesMoneda(cargo.getDesMoneda());
		retorno.setCantidad("1");
		return retorno;
	}

	private VentaDTO obtieneVentaDto(ClienteOSSesionDTO sessionData,HttpSession session) throws GeneralException 
	{
		VentaDTO venta = new VentaDTO();
		AbonadoDTO abonado = sessionData.getCliente().getAbonados().getAbonados()[0];
		//ProductoOfertadoListDTO productosOfertadosAbonado = abonado.getProdOfertList();
		NavegacionWeb navegacion=(NavegacionWeb)session.getAttribute("navegacion");
		PaqueteWeb paqueteWeb=navegacion.getPaqueteWeb(String.valueOf(abonado.getNumAbonado()));
		ArrayList listaProductosOfertadosAContratar=new ArrayList();
		//venta
		ArrayList listaProdOpcionales=paqueteWeb.getProductosDisponible();				
		
		for(Iterator itLista=listaProdOpcionales.iterator();itLista.hasNext();)
		{
			boolean matchProducto=false; 
			ProductoWeb prodWeb=(ProductoWeb)itLista.next();
			if(prodWeb.getChequeado())
			{/**LLenando Productos NO PRODUCTOS DE PAQUETE*/
				for(int indexProdOfer=0;indexProdOfer<abonado.getProdOfertList().getProductoList().length && !matchProducto;indexProdOfer++)						
				{
					ProductoOfertadoDTO prodOfAux=abonado.getProdOfertList().getProductoList()[indexProdOfer];						
					if( "O".equals(prodOfAux.getIndCondicionContratacion()) && 
						prodWeb.getCodigo().equals(prodOfAux.getIdProductoOfertado()) && 
						!"1".equals(prodOfAux.getIndPaquete()) &&
						prodWeb.getCodPadre().equals(String.valueOf(abonado.getNumAbonado()))) // Esta ultima condicion es para filtrar de que el producto no este dentro de un paquete
					{
						int cantidadContratar=prodWeb.getCantidadContratado();
						prodOfAux.setLimiteConsumoSeleccionado(prodWeb.getCodLimConsuSeleccionado());
						prodOfAux.setMtoConsumoConfigurado(prodWeb.getMtoConsumoConfigurado());//mix9003 101209 pv
						while(cantidadContratar>0)
						{
							listaProductosOfertadosAContratar.add(prodOfAux);
							cantidadContratar--;
						}							
						matchProducto=true;
					}
				}					
			}
		}
		
		ProductoOfertadoDTO[] productosTotalesAContratarArray=(ProductoOfertadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(listaProductosOfertadosAContratar.toArray(), ProductoOfertadoDTO.class);
		ProductoOfertadoListDTO contratacionProductoList=new ProductoOfertadoListDTO();
		contratacionProductoList.setProductoList(productosTotalesAContratarArray);
		abonado.setProdOfertList(contratacionProductoList);
		//#ref1---->ini //#ref1---->fin
		venta.setIdVenta(""+sessionData.getNumOrdenServicio());	
		//sessionData.getAbonados()[0] = abonado;
		sessionData.getCliente().getAbonados().getAbonados()[0] = abonado;
		venta.setCliente(sessionData.getCliente());
		venta.setCodCanal("PV");
		venta.setOrigenProceso("PV");
		//#ref2---->ini //#ref2---->fin
		return venta;
	}

	private VentaDTO obtieneVentaDtoOld101209(ClienteOSSesionDTO sessionData) throws GeneralException 
	{
		VentaDTO venta = new VentaDTO();
		AbonadoDTO abonado = sessionData.getCliente().getAbonados().getAbonados()[0];
		ProductoOfertadoListDTO productosOfertadosAbonado = abonado.getProdOfertList();
		//#ref1<----ini
		for(int i=0;i<productosOfertadosAbonado.getProductoList().length;i++)
		{
			CargoListDTO cargoListDTO=new CargoListDTO(); 
			cargoListDTO=productosOfertadosAbonado.getProductoList()[i].getCargoList();
			if (cargoListDTO !=null && cargoListDTO.getCargoList()!=null && cargoListDTO.getCargoList().length>0){
				for (int j=0;j<cargoListDTO.getCargoList().length;j++){
					if (!"R".equalsIgnoreCase(cargoListDTO.getCargoList()[j].getTipoCargo())){
						//productosOfertadosAbonado.getProductoList()[i].setCargoList(null);
						break;
					}
				}
			}
			
			//productosOfertadosAbonado.getProductoList()[i].s
		}
		//getAbonados()[0],productoOfertadoListCont,session,sessionData
		//abonado.setProdOfertList(productosOfertadosAbonado);
		//venta=new VentaDTO();	
		//venta.setIdVenta(""+sessionData.getCodOrdenServicio());
		//#ref1<----fin
		venta.setIdVenta(""+sessionData.getNumOrdenServicio());	
		//sessionData.getAbonados()[0] = abonado;
		sessionData.getCliente().getAbonados().getAbonados()[0] = abonado;
		venta.setCliente(sessionData.getCliente());
		venta.setCodCanal("PV");
		venta.setOrigenProceso("PV");
		//#ref2<----ini
	 	/* probar sin esto:
		NavegacionWeb navegacion=(NavegacionWeb)session.getAttribute("navegacion");
	 	VentaUtils utils=VentaUtils.getInstance();	 	
	 	venta=utils.generarVentaDTO(navegacion, venta);
	 	 */
	 	//ParametroSerializableDTO proceso=delegate.crearProceso(venta);
	 	//venta.setOrigenProceso("PV");
	 	//venta.setNumEvento(proceso.getIdProceso()); 			 	
	 	//session.getSession().setAttribute("VentaDTO", venta);	
		//#ref2<----fin
		return venta;
	}
	
	private AbonadoDTO obtienePaquetes(AbonadoDTO abonado) throws GeneralException {
		NegSalUtils negSalUtils=NegSalUtils.getInstance();
		abonado=negSalUtils.splitProductosPaquetes(abonado);		
	
		for(int i=0;i<abonado.getPaqueteList().getPaqueteList().length;i++)
		{
			ProductoOfertadoListDTO productosDePaquete=delegate.obtenerProductosOfertablesPorPaquete(abonado.getPaqueteList().getPaqueteList()[i]);
			abonado.getPaqueteList().getPaqueteList()[i].setProductoList(productosDePaquete);			
		}
		return abonado;
	}

}
