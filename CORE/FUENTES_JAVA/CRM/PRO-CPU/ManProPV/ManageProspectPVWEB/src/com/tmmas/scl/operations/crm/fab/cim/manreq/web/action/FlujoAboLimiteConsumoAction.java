package com.tmmas.scl.operations.crm.fab.cim.manreq.web.action;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
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
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.CargoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.DescuentoProductoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoListDTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.AbonoLimiteConsumoDTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.AbonoLimiteConsumoListDTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.LimiteConsumoPlanAdicionalDTO;
import com.tmmas.scl.operations.crm.f.sel.negsal.helper.NegSalUtils;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.CargoWebDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate.ManageRequestBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.ProductoForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.Global;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.NavegacionWeb;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.PaqueteWeb;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.ProductoWeb;

public class FlujoAboLimiteConsumoAction extends BaseAction{
	
	private final Logger logger = Logger.getLogger(FlujoAboLimiteConsumoAction.class);
	private Global global = Global.getInstance();
	
	private ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();
	private String CLASS_NAME = "FlujoManLcPlanesAction";
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
		//sessionData.getCliente().getAbonados().getAbonados()[0]= obtienePaquetes(sessionData.getCliente().getAbonados().getAbonados()[0]);
		generarCargosWeb(sessionData.getCliente(),listaCargosAMostrar,listaCargosRecurrentes);
		
		String numProceso = ""+sessionData.getNumOrdenServicio();
		logger.debug("crearProceso con numProceso ["+numProceso+"]");
				
		AbonoLimiteConsumoListDTO listaAbonosLcProductos =  obtieneListaAbonosProductosLc(sessionData,session);
		session.setAttribute("listaAbonosLcProductos", listaAbonosLcProductos);
		
		session.setAttribute("listaCargosAMostrar", listaCargosAMostrar);
		session.setAttribute("listaCargosRecurrentes", listaCargosRecurrentes);
		//imprimeCargosFlujo(listaCargosAMostrar,listaCargosRecurrentes);
		session.setAttribute("ClienteOOSS", sessionData);
		//session.setAttribute("listaLC", listaLimitesDeConsumo);
		logger.debug("execute():end");
		return mapping.findForward("cargosAboLimiteConsumo");
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

	private AbonoLimiteConsumoListDTO obtieneListaAbonosProductosLc(ClienteOSSesionDTO sessionData,HttpSession session) throws GeneralException 
	{
		AbonadoDTO abonado = sessionData.getCliente().getAbonados().getAbonados()[0];
		String[] listaAbonos,listaAbonosHabilitados;
		int contadorAbonos = 0,contadorAbonosHabilitados = 0;
		float abonoLc;
		//ProductoContratadoListDTO prodList
		NavegacionWeb navegacion=(NavegacionWeb)session.getAttribute("navegacion");
		listaAbonos = navegacion.getListaAbonosBita();
		listaAbonosHabilitados = navegacion.getListaAbonosHabilitados();
		
		PaqueteWeb paqueteWeb=navegacion.getPaqueteWeb(String.valueOf(abonado.getNumAbonado()));
		ArrayList listaProdAboLimiteConsumo=paqueteWeb.getLimiteConsumoProductos();
		ArrayList listaAbonosLcProductos = new ArrayList();	
		
		Date fechaHoraBaseDatos = delegate.obtenerFechaBaseDeDatos();
		
		Calendar cal=Calendar.getInstance();
		cal.set(3000, 11, 31);
		
		AbonoLimiteConsumoListDTO listaAboLc = new AbonoLimiteConsumoListDTO();
		AbonoLimiteConsumoDTO AboLc = new AbonoLimiteConsumoDTO();
				
		
		for(Iterator itLista=listaProdAboLimiteConsumo.iterator();itLista.hasNext();)
		{
			AboLc = new AbonoLimiteConsumoDTO();
			ProductoWeb prodWeb=(ProductoWeb)itLista.next();
			
			if(listaAbonosHabilitados[contadorAbonosHabilitados].equals("1"))
			{
			
				if(listaAbonos[contadorAbonos].trim().length() > 0)
				{
					
					abonoLc = Float.valueOf(listaAbonos[contadorAbonos].trim()).floatValue();
					
					AboLc.setAbono(abonoLc);
					AboLc.setAciclo(0);
					AboLc.setCodCliente(Long.valueOf(String.valueOf(sessionData.getCodCliente())));
					AboLc.setCodLimCons(prodWeb.getCodLimConsumoProductos());
					AboLc.setCodPlanTarif(prodWeb.getCodServicioBase());
					AboLc.setFec_asignacion(fechaHoraBaseDatos);
					AboLc.setFec_desde(fechaHoraBaseDatos);
					AboLc.setFec_hasta(new Date(cal.getTimeInMillis()));
					AboLc.setNumAbonado(Long.valueOf(String.valueOf(sessionData.getNumAbonado())));
					AboLc.setUsuarora(sessionData.getUsuario());
							
					listaAbonosLcProductos.add(AboLc);
					contadorAbonos++;
					
				}
				
				
			}
			contadorAbonosHabilitados++;
		}
		
		AbonoLimiteConsumoDTO[] abonosProductos = (AbonoLimiteConsumoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(listaAbonosLcProductos.toArray(), AbonoLimiteConsumoDTO.class);
		AbonoLimiteConsumoListDTO listaAbonosProductos =new AbonoLimiteConsumoListDTO();
		
		listaAbonosProductos.setAbonoDto(abonosProductos);
		
		return listaAbonosProductos;
		
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
	
	private LimiteConsumoPlanAdicionalDTO ObtenerLimiteConsumoSeleccionado(ProductoOfertadoDTO producto,String seleccionado)
	{
		
		LimiteConsumoPlanAdicionalDTO temporal = new LimiteConsumoPlanAdicionalDTO();
				
		
		for(int i = 0 ; i < producto.getListaLimCons().getLimitesDeConsumo().length ; i++)
		{
				
			if(producto.getListaLimCons().getLimitesDeConsumo()[i].getCodLimCons().equals(seleccionado))
			{
				
				temporal = producto.getListaLimCons().getLimitesDeConsumo()[i];
				break;
				
			}
			
			
		}
		return temporal;
		
	}

}
