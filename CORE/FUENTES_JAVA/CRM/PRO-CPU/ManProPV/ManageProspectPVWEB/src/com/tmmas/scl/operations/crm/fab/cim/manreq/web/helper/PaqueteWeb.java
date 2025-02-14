
package com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper;

import java.rmi.RemoteException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.StringTokenizer;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.OrdenServicioDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.DatosEnvioCorreoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.CatalogoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.EspecProductoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PaqueteDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PaqueteListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoListDTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.LimiteConsumoPlanAdicionalDTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.LimiteConsumoProductoDTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.LimiteConsumoProductoListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroListDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ProductoContratadoFrecDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.SeccionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ValoresDefectoPaginaDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.exception.ManReqException;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate.ManageRequestBussinessDelegate;

public class PaqueteWeb  {

	private final Logger logger = Logger.getLogger(PaqueteWeb.class);
	private Global global = Global.getInstance();
	
	private ArrayList productoDisponibles;
	private ArrayList productoPorDefecto;
	private ArrayList limiteConsumoProductos = new ArrayList();
	private ArrayList listaProducNoNumFreq = new ArrayList();
	private ArrayList listaProducNumFreq  = new ArrayList();
	private HashMap productosClienteAfines = new HashMap();
	private HashMap parametrosCorreo = new HashMap();
	private ProductoContratadoFrecDTO[] productoContratadoFrecDTO = null;
	private AbonadoDTO abonadoDTO;
	//CTH
	private ProductoOfertadoListDTO productosOfertadosAbonado;
	private PaqueteListDTO  paquetesOfertadosAbonado;
	private CatalogoDTO catalogo;
	
	private ProductoContratadoListDTO productosCont;
	private ProductoOfertadoListDTO   productosOfer;
	private int hayAutoAfinCont = 0;
	private ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();
	private ClienteOSSesionDTO clienteSesion;
	/**
		 *   PaqueteWEB 
		 *   
		 *   Esta clase guarda todos los cambios por abonado; es decir, todos los 
		 *   productos y paquetes relacionados al id del abonado o cliente..
		 *   
		 *   Tambien genera los metodos necesarios para las validaciones que necesite
		 *   cada producto y que pueda necesitar por ende la clase NavegacionWeb.java
	 * @throws Exception 
		 * 
		 * */
		
	public PaqueteWeb(AbonadoDTO abonadoPar,ClienteDTO cliente,OrdenServicioDTO ordenServicio, long numAbonado, ClienteOSSesionDTO clienteSesion) throws Exception 
	{
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);
		
		logger.debug("PaqueteWeb():start");
		
		ArrayList productosOfertados=new ArrayList();
		ArrayList productosContratatosLc=new ArrayList();
		
		this.clienteSesion = clienteSesion;
		this.abonadoDTO = abonadoPar;
//		solo se llama al creador de esta clase, cuando es la primera vez que se visitan los productos de un abonado o cliente
		ProductoContratadoListDTO productosContratados;			
		ProductoOfertadoListDTO productosOfertables;
		ProductoOfertadoListDTO productosOfertadosAux;	
		ProductoOfertadoDTO productoOfertado;

		ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();



		productosContratados = delegate.obtenerProductoContratado(ordenServicio);
		productosCont = productosContratados;
		
		logger.debug("RAV obtenerProductosOfertables NumAbonado: "+ abonadoDTO.getNumAbonado());
		
		
		catalogo = (CatalogoDTO)abonadoDTO.getCatalogo();
		catalogo.setNumAbonado(String.valueOf(abonadoDTO.getNumAbonado()));
		catalogo.setCodCliente(String.valueOf(abonadoDTO.getCodCliente()));
		//catalogo.setCodVendedor(clienteSesion.getCodVendedor());
		//catalogo.setCodVendedor(clienteSesion.getCodVendedor());
		catalogo.setCodVendedor(String.valueOf(abonadoDTO.getCodVendedor()));

		
		
		abonadoDTO.setCatalogo(catalogo);
		
		productosOfertables = delegate.obtenerProductosOfertables(abonadoDTO);//(abonadoLista.getAbonados()[0]);
		long codCliente = cliente.getCodCliente();

		for(int i=0;i<productosOfertables.getProductoList().length;i++)
		{
			productosOfertables.getProductoList()[i].setCodCliente(codCliente);
			//imprimeIdServBase(productosOfertables.getProductoList()[i]);
		}
		//Limites de consumo para productos Ofertables
		/* test guatemala ini*/
		//productosOfertables = TestLimCom.obtenerLCplanAdicional(productosOfertables);
		/* test guatemala fin*/
		productosOfertables = delegate.obtenerLCplanAdicional(productosOfertables);
		
		/**filtro de tipo comportamiento ini**/
		productosOfertables = filtrarPorTipoComportamiento(productosOfertables);
		/**filtro de tipo comportamiento fin**/
		
		/**filtro de correo ini**/
		HashMap parametrosCorreo = VentaUtils.obtenerParametrosCorreo();//obtenerParametrosCorreo();
		this.parametrosCorreo = parametrosCorreo;

		String codPlanTarif = cliente.getCodPlanTarif();
		if(codPlanTarif == null || "".equals(codPlanTarif))
		{
			codPlanTarif = abonadoDTO.getCodPlanTarif();
		}
		
		String indNivelAplica = abonadoDTO.getCatalogo().getIndNivelAplica();
		
		logger.debug("Plan Tarifario = " + codPlanTarif);
		productosOfertables = filtrarCorreo(productosOfertables,codPlanTarif,codCliente,indNivelAplica);
		
		//(-)-- Correo Movistar
		/**filtro de correo fin**/
		
		
		//Limite de consumo para productos Contratados
		logger.debug("imprimeIdServBase productosContratados ini");
		for(int i=0;i<productosContratados.getProductosContratadosDTO().length;i++)
		{
			productosContratatosLc=new ArrayList();
			productosOfertadosAux = new ProductoOfertadoListDTO();
			
			productoOfertado = productosContratados.getProductosContratadosDTO()[i].getProdOfertado();
			productosContratatosLc.add(productoOfertado);
			ProductoOfertadoDTO[] productos=(ProductoOfertadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(productosContratatosLc.toArray(), ProductoOfertadoDTO.class);
			for(int j=0;j<productos.length;j++){
				productos[j].setCodCliente(codCliente);
			}
			productosOfertadosAux.setProductoList(productos);
			imprimeIdServBase(productosOfertadosAux.getProductoList()[0]);
			productosOfertadosAux = delegate.obtenerLCplanAdicional(productosOfertadosAux);
			productosContratados.getProductosContratadosDTO()[i].setProdOfertado(productosOfertadosAux.getProductoList()[0]);				
		}
		logger.debug("imprimeIdServBase productosContratados fin");
		//(+) EV 16/02/09
		if ( numAbonado >0 && productosOfertables.getProductoList()!=null){//no debe permitir contratar afines
			logger.debug("total productosOfertables antes ="+productosOfertables.getProductoList().length);
			ArrayList productosOfertablesArrayTMP = new ArrayList(); 
			for (int i=0;i<productosOfertables.getProductoList().length;i++){
				ProductoOfertadoDTO productoTMP = productosOfertables.getProductoList()[i];
				EspecProductoDTO especProd  = productoTMP.getEspecificacionProducto();
				
				logger.debug("Productos Ofertados sin Filto");
				logger.debug("especProd.getIdEspecProducto() -> "+especProd.getIdEspecProducto());
				logger.debug("especProd.getIndProdPadre() -> "+especProd.getIndProdPadre());
				logger.debug("especProd.getNombre() -> "+especProd.getNombre());
				logger.debug("especProd.getDescripcion() -> "+especProd.getDescripcion());
				logger.debug("especProd.getFecIniVig() -> "+especProd.getFecIniVig());
				logger.debug("especProd.getFecTerVig() -> "+especProd.getFecTerVig());
				logger.debug("especProd.getIdEspecProdPadre() -> "+especProd.getIdEspecProdPadre());
				logger.debug("especProd.getIndTipoPlataforma() -> "+especProd.getIndTipoPlataforma());
				logger.debug("especProd.getTipoComportamiento() -> "+especProd.getTipoComportamiento());
				
				//if( !(especProd != null && especProd.getTipoComportamiento()!=null && (especProd.getTipoComportamiento().trim()).equals("PAFN"))){
				if( (especProd != null && especProd.getTipoComportamiento()!=null)){
					/*String idEspecProvision = especProd.getEspecServicioClienteList().getEspServCliList()[0].getIdEspecProvision();
					logger.debug("idProductoOfertado "+productoTMP.getIdProductoOfertado());
					logger.debug("idEspecProvision   "+idEspecProvision);
					logger.debug("-------------------------------------");*/
					productosOfertablesArrayTMP.add(productoTMP);
				}/*else
				{
					logger.debug("idProductoOfertado "+productoTMP.getIdProductoOfertado());
					logger.debug("especProd  o tipoComportamiento = null");
					logger.debug("-------------------------------------");
				}*/
			
			}//fin for
			
			ProductoOfertadoDTO[] productosTMP = (ProductoOfertadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico( productosOfertablesArrayTMP.toArray(), ProductoOfertadoDTO.class);
			productosOfertables.setProductoList(productosTMP);
			logger.debug("total productosOfertables despues ="+productosOfertables.getProductoList().length);
		}
		//(-) EV 16/02/09
		
		productosOfer = productosOfertables;
		productoPorDefecto = new ArrayList();//estas listas guardan ProductoWeb
		productoDisponibles = new ArrayList();

		logger.debug("PaqueteWeb productoPorDefecto.size() "+productoPorDefecto.size());
        //paquete.setCodProdPadre(abonado.getPlanTarifario().getPaqueteDefault().getCodProdPadre());
		//ProductoOfertadoListDTO productosOfertables = delegate.obtenerProductosOfertables(abonado);	// producto por OFERTABLES
		//for (int p = 0;p<35;p++){//CTH guardar producto ofertado	
		Date fechaActual = new Date();
		String esAutoAfin = "0";
		for (int p = 0;p<productosContratados.getProductosContratadosDTO().length;p++){//CTH guardar producto ofertado	
			ProductoContratadoDTO productoCX = productosContratados.getProductosContratadosDTO()[p];//getProductoList
			productoCX.setFechaTerminoVigencia(fechaActual);
			Date date = productoCX.getFechaTerminoVigencia();
			Calendar calendar =Calendar.getInstance(); //obtiene la fecha de hoy 
			calendar.add(Calendar.DATE, -1); //el -3 indica que se le restaran 3 dias 
			ProductosContradosFrecUtil.imprimeProdCont(productoCX);
			ProductoOfertadoDTO productoX = productoCX.getProdOfertado();
			//esAutoAfin
			esAutoAfin = "0";
			if(esAutoAfinProdOf(productoX))/*hayAutoAfinCont == 0 && */
			{
				//System.out.println("EXISTE AutoAfin CONTRATADO ------------>");
				esAutoAfin = "1";
				hayAutoAfinCont = 1;
			}
			productosOfertados.add(productoX);
			agruparProducto(productoX,productoPorDefecto,"D.",productoCX.getIdProdContratado().toString(),
					productoCX.getIndCondicionContratacion(),esAutoAfin,productoCX.getlimiteConsumoContratado(),productoCX);	
		}
		logger.debug("-----------------------OFERTADOS------------------------------------ini---->");
		esAutoAfin = "0";
		StringBuffer sb= new StringBuffer("\n");
		for (int p = 0;p<productosOfertables.getProductoList().length;p++){			//CTH guardar producto ofertado			
			ProductoOfertadoDTO productoX = productosOfertables.getProductoList()[p];
			esAutoAfin = verificaAfinidad(productoX,cliente,fechaActual);
			sb.append("Pofer "+productoX.getIdProductoOfertado()+" esAutoAfin ["+esAutoAfin+"]\n");
			//System.out.println("esAutoAfin  "+esAutoAfin);
			productosOfertados.add(productoX);
			agruparProducto(productoX,productoDisponibles,"O.",null,productoX.getIndCondicionContratacion(),
					esAutoAfin,null,null);	
		}
		logger.debug("-----------------------OFERTADOS------------------------------------fin---->");
		//System.err.println("ES AUTO AFIN ------------------------------------>"+sb.toString());
		//guardar a nivel de abonado clases utiles para numfrec
		//ProductosContradosFrecUtil pfu = new ProductosContradosFrecUtil();
		//productoContratadoFrecDTO = pfu.generaProductoContratadoList(listaProducNumFreq, listaProducNoNumFreq,abonado.getCodCliente(),abonado.getNumAbonado());
		
		/**
		 * CTH Separando y guardando los productos ofertados
		 */	
		productosOfertadosAbonado=new ProductoOfertadoListDTO();
		ProductoOfertadoDTO[] productos=(ProductoOfertadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(productosOfertados.toArray(), ProductoOfertadoDTO.class);
		productosOfertadosAbonado.setProductoList(productos);
		
		abonadoDTO.setProdOfertList(productosOfertadosAbonado);		
		//NegSalUtils negSalUtils=NegSalUtils.getInstance();
		//abonado=negSalUtils.splitProductosPaquetes(abonado);		

//		for(int i=0;i<abonado.getPaqueteList().getPaqueteList().length;i++)
//		{
//			ProductoOfertadoListDTO productosDePaquete=delegate.obtenerProductosOfertablesPorPaquete(abonado.getPaqueteList().getPaqueteList()[i]);
//			abonado.getPaqueteList().getPaqueteList()[i].setProductoList(productosDePaquete);			
//		}
		
		//this.abonado=abonado;
		productosOfertadosAbonado=abonadoDTO.getProdOfertList();
		paquetesOfertadosAbonado=abonadoDTO.getPaqueteList();
		/* test guatemala ini*/
		//productoPorDefecto.add(productoDisponibles.get(0));
		/* test guatemala fin*/
		logger.debug("PaqueteWeb():end");
		
	}

	//(+) 31/03/2010 EV - PV Correo Movistar---------------------------------------------------------------------------
	
	private ProductoOfertadoListDTO filtrarCorreo(ProductoOfertadoListDTO productosOfertables, String codPlanTarif, long codCliente, String indNivelAplica) throws Exception {
		logger.debug("-----------------------------------------------");
		logger.debug("filtrarCorreo():ini");
		ArrayList productosOfert  = new ArrayList();
		ArrayList productosOfert1 = new ArrayList();
		ArrayList productosOfert2correoSeven = new ArrayList();
		ArrayList productosOfert3serviciosCISeven = new ArrayList();
		ArrayList productosOfert4serviciosILSeven = new ArrayList();
		ArrayList productosOfert5serviciosISSeven = new ArrayList();		
		ArrayList productosOfert6correoBB = new ArrayList();
		ArrayList productosOfert7serviciosCIBB = new ArrayList();
		ArrayList productosOfert8serviciosISBB = new ArrayList();
		
		ProductoOfertadoDTO[] productos=null;
		ProductoOfertadoDTO dto=null;
		String idEspecProvision = null;
		boolean esPlanCorreo     = false;
		boolean esPlanCompartido = false;//tipo de plan tarifario: I:individual, C:compartido
		boolean esClienteEmpresa = false;//tipo de cliente: 1:empresa, 2:individual cod_tipo de ge_cliente
		String codTipo = null;
		
		try{
			ClienteDTO clienteTip =  new ClienteDTO();
			clienteTip.setCodCliente(codCliente);
			clienteTip = delegate.getCliente(clienteTip);
			codTipo = clienteTip.getTipoCliente();
			if("1".equals(codTipo)) esClienteEmpresa = true;
			
		}catch(Exception e){}
		
		try{
			PlanTarifarioDTO planTarif= delegate.obtenerDatosPlanTarifario(codPlanTarif);
			esPlanCompartido = (planTarif.getIndCompartido()==1)?true:false;
		}catch(Exception e){}
		
		logger.debug("-----------------------------------------------");
		logger.debug("esPlanCompartido["+esPlanCompartido+"]");
		logger.debug("esClienteEmpresa["+esClienteEmpresa+"]");
		/*seven ini*/
		String x1 		= (String) parametrosCorreo.get("X1");//seven customer edition
		String x2 		= (String) parametrosCorreo.get("X2");//seven owa
		String x3 		= (String) parametrosCorreo.get("X3");//seven owa + ce
		String x4 		= (String) parametrosCorreo.get("X4");//seven workgroup
		String x5 		= (String) parametrosCorreo.get("X5");//seven workgroup + ce
		String x6 		= (String) parametrosCorreo.get("X6");//seven enterprise edition
		String x7 		= (String) parametrosCorreo.get("X7");//seven enterprise edition + ce
		/*seven fin, bb ini*/
		String x8 		= (String) parametrosCorreo.get("X8");//blackberry individual
		String x9 		= (String) parametrosCorreo.get("X9");//blackberry profesional
		String x10 		= (String) parametrosCorreo.get("X10");//blackberry corporativo
		/*bb fin*/
		
		String srvSevCI = (String) parametrosCorreo.get("sev.ci");//cuota instalacion
		String srvSevIL = (String) parametrosCorreo.get("sev.il");//instalacion licencia
		String srvSevIS = (String) parametrosCorreo.get("sev.is");//instalacion servidores
		String srvBBCI  = (String) parametrosCorreo.get("bb.ci");//cuota instalacion
		String srvBBIS  = (String) parametrosCorreo.get("bb.is");//instalacion servidores
		/*test, sacar esta linea*/
		/*esClienteEmpresa= true;
		logger.debug("esClienteEmpresa["+esClienteEmpresa+"(test en true)]");*/
		logger.debug("-----------------------------------------------");
		/**/
		for(int i=0;i<productosOfertables.getProductoList().length;i++)
		{
			dto = productosOfertables.getProductoList()[i];
			if(!tieneEspServCliList(dto))
			{
				logger.debug("Producto sin EspServCliList ["+dto.getIdentificadorProductoOfertado()+"]");
				logger.debug("-----------------------------------------------");
				productosOfert.add(dto);
				continue;
			}
			idEspecProvision = dto.getEspecificacionProducto().getEspecServicioClienteList().getEspServCliList()[0].getIdEspecProvision();
			
			esPlanCorreo = esCorreo(parametrosCorreo, idEspecProvision);
			
			dto = agregaInformacionEnvioCorreo(dto,idEspecProvision);
			
			if(!esPlanCorreo)// si no es pa correo movistar, se agrega
			{
				if (srvSevCI.equals(idEspecProvision)){//cuota instalacion
					productosOfert3serviciosCISeven.add(dto);
					
				}else if (srvSevIL.equals(idEspecProvision) && esPlanCompartido){ //inst licencia
					productosOfert4serviciosILSeven.add(dto);
					
				}else if (srvSevIS.equals(idEspecProvision) && esPlanCompartido){ //inst servidores
					productosOfert5serviciosISSeven.add(dto);
					
				}else if(srvBBCI.equals(idEspecProvision)){//cuota instalacion
					productosOfert7serviciosCIBB.add(dto);
					
				}else if(srvBBIS.equals(idEspecProvision) && esPlanCompartido){//inst servidores
					productosOfert8serviciosISBB.add(dto);
					
				}else{
					productosOfert1.add(dto);//otros PA
				}

			}else if(indNivelAplica.equals("A"))
			{   //si es plan tarifario individual y idEspecProv in (x1,x8,x9), se agrega
				logger.debug("Es plan Correo Movistar, idEspecProvision="+idEspecProvision);
				if(!esPlanCompartido && (x1.equals(idEspecProvision) || x8.equals(idEspecProvision) || x9.equals(idEspecProvision)))//si es plan tarifario individual				
				{
					//productosOfert.add(dto);
					if  (x1.equals(idEspecProvision) ){
						productosOfert2correoSeven.add(dto); //correo seven
						logger.debug("Se agrega plan Correo Movistar PT indv(x1), idEspecProvision="+idEspecProvision);
					}else if (x8.equals(idEspecProvision) || x9.equals(idEspecProvision)){
						productosOfert6correoBB.add(dto); //correo blackberry
						logger.debug("Se agrega plan Correo Movistar PT indv(x8,x9), idEspecProvision="+idEspecProvision);
					}	
				}else if(esClienteEmpresa && esPlanCompartido)//x2 a x7 y x10 (complemento del de arriba)
				{
					//productosOfert.add(dto);
					if  (x2.equals(idEspecProvision) || x3.equals(idEspecProvision) || x4.equals(idEspecProvision) ||
						 x5.equals(idEspecProvision) || x6.equals(idEspecProvision) || x7.equals(idEspecProvision)){
						productosOfert2correoSeven.add(dto); //correo comp
						logger.debug("Se agrega plan Correo Movistar PT comp(x2ax7) y CteEmp, idEspecProvision="+idEspecProvision);
					}else if (x10.equals(idEspecProvision)){
						productosOfert6correoBB.add(dto); //correo blackberry
						logger.debug("Se agrega plan Correo Movistar PT comp(x10) y CteEmp, idEspecProvision="+idEspecProvision);
					}
				}else
				{
					logger.debug("No se agrega plan Correo Movistar, idEspecProvision="+idEspecProvision);
				}
				logger.debug("-----------------------------------------------");
			}
		}//fin for
		
		//ordena listas
		productosOfert.addAll(productosOfert1);//pa comun
		productosOfert.addAll(productosOfert2correoSeven);//x1
		productosOfert.addAll(productosOfert3serviciosCISeven);
		productosOfert.addAll(productosOfert4serviciosILSeven);
		productosOfert.addAll(productosOfert5serviciosISSeven);
		productosOfert.addAll(productosOfert6correoBB);//x8,x9
		productosOfert.addAll(productosOfert7serviciosCIBB);
		productosOfert.addAll(productosOfert8serviciosISBB);
				
		productos=(ProductoOfertadoDTO[])ArrayUtl.copiaArregloTipoEspecifico(productosOfert.toArray(), ProductoOfertadoDTO.class);
		productosOfertables.setProductoList(productos);
		logger.debug("filtrarCorreo():fin");
		return productosOfertables;
	}

	private boolean esCorreo(HashMap hm, String idEspecProvision) {
		boolean retorno = false;
		String valor = null;
		for(int i=1;i<11;i++){
			valor = (String) hm.get("X"+i);
			if(valor.equals(idEspecProvision)){
				retorno = true;
				logger.debug("PA X"+i+"[cod_prov_serv = "+valor+"]");
				break;
			}
		}

		return retorno;
	}

	//(+) completa informacion de envio de correos
	private ProductoOfertadoDTO agregaInformacionEnvioCorreo(ProductoOfertadoDTO prodOfer, String idEspecProvision){
		
	    ParseoXML objetoXML=new ParseoXML();
	    ValoresDefectoPaginaDTO objetoXMLSession = this.clienteSesion.getValoresDefecto();
	    SeccionDTO seccion=new SeccionDTO();
	    
		String idEspecProvCSevenInstLicencias  = (String) parametrosCorreo.get("sev.il");
		String idEspecProvCSevenInstServidores = (String) parametrosCorreo.get("sev.is");
		String idEspecProvCBBInstServidores    = (String) parametrosCorreo.get("bb.is");
		String idEspecProvCBBIndividual        = (String) parametrosCorreo.get("X8");
		String idEspecProvCBBProfesional       = (String) parametrosCorreo.get("X9");
		String idEspecProvCBBCorporativo       = (String) parametrosCorreo.get("X10");
		
		String codigoLSE = global.getValor("codigo.correo.mov.sev.il");
		String codigoSSE = global.getValor("codigo.correo.mov.sev.is");
		String codigoSBB = global.getValor("codigo.correo.mov.bb.is");
		String codigoCBB = global.getValor("codigo.correo.blackberry");
		
		String tipoBBindividual = global.getValor("correo.blackberry.individual");
		String tipoBBprofesional = global.getValor("correo.blackberry.profesional");
		String tipoBBcorporativo = global.getValor("correo.blackberry.corporativo");		
		
		DatosEnvioCorreoDTO datosEnvioCorreoDTO = null;
	    
		if (idEspecProvCSevenInstLicencias.equals(idEspecProvision)){//SEVEN instalacion licencias
			datosEnvioCorreoDTO = new DatosEnvioCorreoDTO();
			datosEnvioCorreoDTO.setCodCorreo(codigoLSE);
		    seccion = objetoXML.obtenerSeccion(objetoXMLSession, "registroOS", "correoSevenInstLicencias");
		    if (seccion !=null) {
		    	if (seccion.obtControl("asunto")!=null && seccion.obtControl("asunto").getValorDefecto()!=null)
		    		datosEnvioCorreoDTO.setSubject(seccion.obtControl("asunto").getValorDefecto());
		    	
		    	if (seccion.obtControl("mensaje")!=null && seccion.obtControl("mensaje").getValorDefecto()!=null)
		    		datosEnvioCorreoDTO.setBody(seccion.obtControl("mensaje").getValorDefecto());
		    }
		}
		else 
		if (idEspecProvCSevenInstServidores.equals(idEspecProvision)){//SEVEN instalacion servidores
			datosEnvioCorreoDTO = new DatosEnvioCorreoDTO();
			datosEnvioCorreoDTO.setCodCorreo(codigoSSE);
		    seccion = objetoXML.obtenerSeccion(objetoXMLSession, "registroOS", "correoSevenInstServidores");
		    if (seccion !=null) {
		    	if (seccion.obtControl("asunto")!=null && seccion.obtControl("asunto").getValorDefecto()!=null)
		    		datosEnvioCorreoDTO.setSubject(seccion.obtControl("asunto").getValorDefecto());
		    	
		    	if (seccion.obtControl("mensaje")!=null && seccion.obtControl("mensaje").getValorDefecto()!=null)
		    		datosEnvioCorreoDTO.setBody(seccion.obtControl("mensaje").getValorDefecto());
		    }
		}			
		else 
		if (idEspecProvCBBInstServidores.equals(idEspecProvision)){//BlackBerry instalacion servidores
			datosEnvioCorreoDTO = new DatosEnvioCorreoDTO();
			datosEnvioCorreoDTO.setCodCorreo(codigoSBB);
		    seccion = objetoXML.obtenerSeccion(objetoXMLSession, "registroOS", "correoBlackBerryInstServidores");
		    if (seccion !=null) {
		    	if (seccion.obtControl("asunto")!=null && seccion.obtControl("asunto").getValorDefecto()!=null)
		    		datosEnvioCorreoDTO.setSubject(seccion.obtControl("asunto").getValorDefecto());
		    	
		    	if (seccion.obtControl("mensaje")!=null && seccion.obtControl("mensaje").getValorDefecto()!=null)
		    		datosEnvioCorreoDTO.setBody(seccion.obtControl("mensaje").getValorDefecto());
		    }
		}			
		else 
		if (idEspecProvCBBIndividual.equals(idEspecProvision)){//BlackBerry Individual
			datosEnvioCorreoDTO = new DatosEnvioCorreoDTO();
			datosEnvioCorreoDTO.setCodCorreo(codigoCBB);
			datosEnvioCorreoDTO.setTipoBlackBerry(tipoBBindividual);
		    seccion = objetoXML.obtenerSeccion(objetoXMLSession, "registroOS", "correoBlackBerryContrIndividual");
		    if (seccion !=null) {
		    	if (seccion.obtControl("asunto")!=null && seccion.obtControl("asunto").getValorDefecto()!=null)
		    		datosEnvioCorreoDTO.setSubject(seccion.obtControl("asunto").getValorDefecto());
		    	
		    	if (seccion.obtControl("mensaje")!=null && seccion.obtControl("mensaje").getValorDefecto()!=null)
		    		datosEnvioCorreoDTO.setBody(seccion.obtControl("mensaje").getValorDefecto());
		    }
		}		    	    
		else 
		if (idEspecProvCBBProfesional.equals(idEspecProvision)){//BlackBerry Profesional
			datosEnvioCorreoDTO = new DatosEnvioCorreoDTO();
			datosEnvioCorreoDTO.setCodCorreo(codigoCBB);
			datosEnvioCorreoDTO.setTipoBlackBerry(tipoBBprofesional);
		    seccion = objetoXML.obtenerSeccion(objetoXMLSession, "registroOS", "correoBlackBerryContrProfesional");
		    if (seccion !=null) {
		    	if (seccion.obtControl("asunto")!=null && seccion.obtControl("asunto").getValorDefecto()!=null)
		    		datosEnvioCorreoDTO.setSubject(seccion.obtControl("asunto").getValorDefecto());
		    	
		    	if (seccion.obtControl("mensaje")!=null && seccion.obtControl("mensaje").getValorDefecto()!=null)
		    		datosEnvioCorreoDTO.setBody(seccion.obtControl("mensaje").getValorDefecto());
		    }
		}else
		if (idEspecProvCBBCorporativo.equals(idEspecProvision)){//BlackBerry Corporativo
			datosEnvioCorreoDTO = new DatosEnvioCorreoDTO();
			datosEnvioCorreoDTO.setCodCorreo(codigoCBB);
			datosEnvioCorreoDTO.setTipoBlackBerry(tipoBBcorporativo);
		    seccion = objetoXML.obtenerSeccion(objetoXMLSession, "registroOS", "correoBlackBerryContrCorporativo");
		    if (seccion !=null) {
		    	if (seccion.obtControl("asunto")!=null && seccion.obtControl("asunto").getValorDefecto()!=null)
		    		datosEnvioCorreoDTO.setSubject(seccion.obtControl("asunto").getValorDefecto());
		    	
		    	if (seccion.obtControl("mensaje")!=null && seccion.obtControl("mensaje").getValorDefecto()!=null)
		    		datosEnvioCorreoDTO.setBody(seccion.obtControl("mensaje").getValorDefecto());
		    }
		}

		if (datosEnvioCorreoDTO!=null){
			long numVenta = -1;
			try {
				if(clienteSesion.getCliente().getAbonados() == null ||
				   clienteSesion.getCliente().getAbonados().getAbonados() == null)
				{
					logger.debug("error al obtener NumVenta clienteSesion.getCliente().getAbonados().getAbonados() ==> null");
				}else
				{
					numVenta = clienteSesion.getCliente().getAbonados().getAbonados()[0].getNumVenta();
				}
			} catch (Exception e) {
				logger.debug("error al obtener NumVenta:clienteSesion.getCliente().getAbonados().getAbonados()[0].getNumVenta()---");	
				String loge = StackTraceUtl.getStackTrace(e);
				logger.debug("Exception[" + loge + "]");
				logger.debug("---");
			}
			
			datosEnvioCorreoDTO.setNumVenta(numVenta);//clienteSesion.getNumAbonado());
			datosEnvioCorreoDTO.setBody(prodOfer.getDesProdOfertado()+"\n"+datosEnvioCorreoDTO.getBody());
			
			prodOfer.setDatosEnvioCorreo(datosEnvioCorreoDTO);
			prodOfer.setEnviaCorreo(true);

			logger.debug("---- PA con envio de correo ----------ini");
			logger.debug("identificadProdOfer ["+prodOfer.getIdentificadorProductoOfertado()+"]");
			logger.debug("idProductoOfertado  ["+prodOfer.getIdProductoOfertado()+"]");
			logger.debug("DesProdOfertado     ["+prodOfer.getDesProdOfertado()+"]");		
			logger.debug("idEspecProvision="+idEspecProvision);			
			logger.debug("datosEnvioCorreoDTO.getNumVenta()="+datosEnvioCorreoDTO.getNumVenta());
			logger.debug("datosEnvioCorreoDTO.getCodCorreo()="+datosEnvioCorreoDTO.getCodCorreo());
			logger.debug("datosEnvioCorreoDTO.getTipoBlackBerry()="+datosEnvioCorreoDTO.getTipoBlackBerry());
			logger.debug("datosEnvioCorreoDTO.getSubject()="+datosEnvioCorreoDTO.getSubject());
			logger.debug("datosEnvioCorreoDTO.getBody()="+datosEnvioCorreoDTO.getBody());	
			logger.debug("---- PA con envio de correo ----------fin");
		}
		return prodOfer;
	}
	
	//(-) 31/03/2010 EV - PV Correo Movistar---------------------------------------------------------------------------

	//(+) 22/04/2010 EV - PV Tipo Comportamiento-----------------------------------------------------------------------
	
	private ProductoOfertadoListDTO filtrarPorTipoComportamiento(ProductoOfertadoListDTO productosOfertables) throws Exception {
		logger.debug("-----------------------------------------------");
		logger.debug("filtrarPorTipoComportamiento():ini");
		String[] listaTiposCom = this.clienteSesion.getListaTiposCom();
		ProductoOfertadoDTO dto=null;
		ProductoOfertadoDTO[] productos=null;
		ArrayList productosOfertSinEspcPdt  = new ArrayList();
		Map hmTiposComportamiento = new HashMap();
		for(int i=0;i<listaTiposCom.length;i++)
		{
			hmTiposComportamiento.put(listaTiposCom[i], new ArrayList());
		}
		String tipoComPdt = null;
		ArrayList tipoComSelArrList = null;
		for(int i=0;i<productosOfertables.getProductoList().length;i++)
		{
				
			dto = productosOfertables.getProductoList()[i];
			
			logger.debug("dto.getTipoPlanAdic()    ["+ dto.getTipoPlanAdic() + "]");
			
			if(dto.getEspecificacionProducto() != null && dto.getEspecificacionProducto().getTipoComportamiento() != null)
			{
				tipoComPdt = dto.getEspecificacionProducto().getTipoComportamiento();
				tipoComSelArrList = (ArrayList)hmTiposComportamiento.get(tipoComPdt);
				if(tipoComSelArrList != null)
				{
					tipoComSelArrList.add(dto);
					hmTiposComportamiento.put(tipoComPdt,tipoComSelArrList);
				}
			}else
			{//aca se podrian filtrar los pack::  if (!dto.getIndPaquete().equals("0")) es paquete (0 es pdt, 1 es pack)
				productosOfertSinEspcPdt.add(dto);
				logger.debug("index["+i+"] PDT SIN ESPECIFICACION DE PRODUCTO IDENPDT["+dto.getIdentificadorProductoOfertado()+"] IDPDT["+dto.getIdProductoOfertado()+"]");
			}
		}
		ArrayList productosOfert  = new ArrayList();
		//ordena listas
		for(int i=0;i<listaTiposCom.length;i++)
		{
			tipoComSelArrList = (ArrayList)hmTiposComportamiento.get(listaTiposCom[i]);
			productosOfert.addAll(tipoComSelArrList);//pa comun
		}
		productosOfert.addAll(productosOfertSinEspcPdt);
		productos=(ProductoOfertadoDTO[])ArrayUtl.copiaArregloTipoEspecifico(productosOfert.toArray(), ProductoOfertadoDTO.class);
		
		productosOfertables.setProductoList(productos);
		logger.debug("filtrarPorTipoComportamiento():fin");
		return productosOfertables;
	}
	
	public void obtenerLimiteConsumoProducto(long numAbonado,long codCliente)
	{
		
		LimiteConsumoProductoDTO limiteConsumoProducto = new LimiteConsumoProductoDTO();
		LimiteConsumoProductoListDTO listaLimiteConsumoProducto = new LimiteConsumoProductoListDTO();
		ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();
		limiteConsumoProducto.setCodCliente(Long.valueOf((String.valueOf(codCliente))));
		limiteConsumoProducto.setNumAbonado(Long.valueOf((String.valueOf(numAbonado))));
		
		try {
			listaLimiteConsumoProducto = delegate.consultaAbonoLcProducto(limiteConsumoProducto);
		} catch (GeneralException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(listaLimiteConsumoProducto.getListaLimiteConsumoProducto().length > 0)
			agruparLimiteConsumoProducto(listaLimiteConsumoProducto);
	
	}
	
	
	
	private void agruparLimiteConsumoProducto(LimiteConsumoProductoListDTO listaLimiteConsumoProducto)
	{
		
		ProductoWeb productoWeb = new  ProductoWeb(listaLimiteConsumoProducto.getListaLimiteConsumoProducto()[0]);
		String codServicioBaseAnterior = listaLimiteConsumoProducto.getListaLimiteConsumoProducto()[0].getCodServicioBase();
		
		//en caso que el productoweb no sea de ningun paquete, su codpadre es el abonado
		
		for(int i = 1;i<listaLimiteConsumoProducto.getListaLimiteConsumoProducto().length;i++)
		{
			
			if(codServicioBaseAnterior.equals(listaLimiteConsumoProducto.getListaLimiteConsumoProducto()[i].getCodServicioBase()))
			{
				
				productoWeb.agregarDescripListaProductosLC(listaLimiteConsumoProducto.getListaLimiteConsumoProducto()[i].getDesProductoOfertado());
				
			}
			else
			{
				limiteConsumoProductos.add(productoWeb);
				productoWeb = new  ProductoWeb(listaLimiteConsumoProducto.getListaLimiteConsumoProducto()[i]);
				codServicioBaseAnterior = listaLimiteConsumoProducto.getListaLimiteConsumoProducto()[i].getCodServicioBase();
						
			}
		
		}
		limiteConsumoProductos.add(productoWeb);
	
	}

	private void verificaAfinidadOri(ProductoOfertadoDTO productoX, ClienteDTO cliente, Date fechaActual)
	{
		String indAutoAfinidad = null;
		
		if (productoX.getIndPaquete().equals("0"))
		{
			EspecProductoDTO especProd = productoX.getEspecificacionProducto();
			if(especProd != null)
			{
				if( especProd.getTipoComportamiento()!=null && especProd.getTipoComportamiento().equals("PAFN"))
				{		
					try
					{
						indAutoAfinidad = especProd.getEspecServicioClienteList()
			            .getEspecSerLisList().getEspecServicioListaList()[0].getIndAutoAfinidad();
					}
					catch(Exception e)
					{
						logger.debug("producto ofertado PAFN "+productoX.getIdentificadorProductoOfertado()+" sin espSerListaList \n"+e.getMessage());
					}
					if(indAutoAfinidad!=null && "S".equals(indAutoAfinidad))
					{
						NumeroDTO     ndto = new NumeroDTO();
						ndto.setIdCliente(""+cliente.getCodCliente());
						//(+) EV 12/02/09
						//ndto.setFecInicioVigencia(productoX.getFecInicioVigencia());
						ndto.setFecInicioVigencia(new Timestamp(productoX.getFecInicioVigencia().getTime()));
						//(-)
						ndto.setFecProceso(fechaActual);
						ndto.setIdAbonado(""+cliente.getAbonados().getAbonados()[0].getNumAbonado());
						ndto.setNro(""+cliente.getCodCliente());
						NumeroDTO[]   numeroArrAdd = {ndto};
						
						NumeroListDTO numeroListAf = new NumeroListDTO();
						numeroListAf.setCodCliente(""+cliente.getCodCliente());
						numeroListAf.setNumerosDTO(numeroArrAdd);
						productoX.setListaNumeros(numeroListAf);
					}
				}
				else
				{
					if( especProd.getTipoComportamiento()==null)
					{
						logger.debug("especProd.getTipoComportamiento() = null "+productoX.getIdentificadorProductoOfertado());
					}
				}
			}
			else
			{
				logger.debug("EspecProductoDTO = null "+productoX.getIdentificadorProductoOfertado());
			}
		}
	}

	private String verificaAfinidad(ProductoOfertadoDTO productoX, ClienteDTO cliente, Date fechaActual)
	{
		String esAutoAfin = "0";
		if(esAutoAfinProdOf(productoX))
		{
			NumeroDTO     ndto = new NumeroDTO();
			ndto.setIdCliente(""+cliente.getCodCliente());
			//(+) EV 12/02/09
			//ndto.setFecInicioVigencia(productoX.getFecInicioVigencia());
			ndto.setFecInicioVigencia(new Timestamp(productoX.getFecInicioVigencia().getTime()));
			//(-)
			ndto.setFecProceso(fechaActual);
			ndto.setIdAbonado(""+cliente.getAbonados().getAbonados()[0].getNumAbonado());
			ndto.setNro(""+cliente.getCodCliente());
			NumeroDTO[]   numeroArrAdd = {ndto};
			
			NumeroListDTO numeroListAf = new NumeroListDTO();
			numeroListAf.setCodCliente(""+cliente.getCodCliente());
			numeroListAf.setNumerosDTO(numeroArrAdd);
			productoX.setListaNumeros(numeroListAf);
			esAutoAfin = "1";
		}
		return esAutoAfin;
	}
	
	private boolean esAutoAfinProdOf(ProductoOfertadoDTO productoX)
	{
		String indAutoAfinidad = null;
		
		if (productoX.getIndPaquete().equals("0"))
		{
			EspecProductoDTO especProd = productoX.getEspecificacionProducto();
			if(especProd != null)
			{
				if( especProd.getTipoComportamiento()!=null && especProd.getTipoComportamiento().equals("PAFN"))
				{		
					try
					{
						indAutoAfinidad = especProd.getEspecServicioClienteList()
			            .getEspecSerLisList().getEspecServicioListaList()[0].getIndAutoAfinidad();
					}
					catch(Exception e)
					{
						logger.debug("En PaqueteWeb.java esAutoAfin producto ofertado PAFN "+productoX.getIdentificadorProductoOfertado()+" sin espSerListaList \n"+e.getMessage());
					}
					if(indAutoAfinidad!=null && "S".equals(indAutoAfinidad))
					{
						return true;
					}
				}
				else
				{
					if( especProd.getTipoComportamiento()==null)
					{
						logger.debug("especProd.getTipoComportamiento() = null "+productoX.getIdentificadorProductoOfertado());
					}
				}
			}
			else
			{
				logger.debug("EspecProductoDTO = null "+productoX.getIdentificadorProductoOfertado());
			}
		}
		return false;
	}
	
	private CatalogoDTO obtenerCatalogo() {
		CatalogoDTO catalogo=new CatalogoDTO();
		Calendar cal= Calendar.getInstance();                
        cal.set(3000,11,31);               
        catalogo.setCodCanal("VT");
        catalogo.setFecInicioVigencia(new Date());
        catalogo.setFecTerminoVigencia(new Date(cal.getTimeInMillis()));
        catalogo.setIndNivelAplica(abonadoDTO.getNumAbonado()!=0?"A":"C");
		return catalogo;
	}

	private void agruparProducto(ProductoOfertadoDTO productoX,ArrayList listaProdTipo,String prefOfertContr, 
			String idProdContratado, String indCondicionContratacion, String esAutoAfin, String lcElementoContratado,
			ProductoContratadoDTO productoCX) throws RemoteException, GeneralException 
	{
		//productoX.setFecTerminoVigencia(new Date());
		//Date date = productoX.getFecTerminoVigencia();
		//Calendar calendar =Calendar.getInstance(); //obtiene la fecha de hoy 
		//calendar.add(Calendar.DATE, -1); //el -3 indica que se le restaran 3 dias 
		
		ProductosContradosFrecUtil.imprimeProdOfer(productoX, null);
		if (productoX.getIndPaquete().equals("1"))
		{
//			TODO: ver si esta rutina conviene meterla dentro del ProductoWeb o no;
			if (true)
			{
				//se eliminan los paquetes 240510
				logger.debug("No se agrega PAQ["+productoX.getIdentificadorProductoOfertado()+"]");
				return;
			}
			PaqueteDTO paqueteDeProducto=new PaqueteDTO();	
			paqueteDeProducto.setCodProdPadre(productoX.getIdProductoOfertado());
			ProductoOfertadoListDTO detallePaq = delegate.obtenerProductosOfertablesPorPaquete(paqueteDeProducto);
			detallePaq = delegate.obtenerLCplanAdicional(detallePaq);
			if(detallePaq!=null)
			{
				agregarProductoPaq(productoX,String.valueOf(abonadoDTO.getNumAbonado()),listaProdTipo,prefOfertContr,detallePaq.getProductoList().length,idProdContratado,indCondicionContratacion);			
				for (int ppaq = 0;ppaq<detallePaq.getProductoList().length;ppaq++){
					
					ProductosContradosFrecUtil.imprimeProdOfer(detallePaq.getProductoList()[ppaq],productoX.getIdProductoOfertado());
					agregarProducto(detallePaq.getProductoList()[ppaq],productoX.getIdProductoOfertado(),listaProdTipo,
							prefOfertContr,idProdContratado,indCondicionContratacion,"1",esAutoAfin,lcElementoContratado,productoCX);
				}//String tipoComp = "";tipoComp = productoX.getEspecificacionProducto().getTipoComportamiento();
			}
			else
			{
				logger.debug("PaqueteWeb ProductoOfertadoListDTO-->delegate.obtenerProductosOfertablesPorPaquete(paqueteDeProducto);--->NULO");
			}
		}
		else
		{
			agregarProducto(productoX,String.valueOf(abonadoDTO.getNumAbonado()),listaProdTipo,prefOfertContr,idProdContratado,
					indCondicionContratacion,"0",esAutoAfin,lcElementoContratado,productoCX);
		}
	}
	private void agregarAutoAfin(String codigoAfin) {
		ArrayList arrayAutoAfin = new ArrayList();
		arrayAutoAfin.add(abonadoDTO);
		productosClienteAfines.put(codigoAfin, arrayAutoAfin);	
	}
	private void agregarProducto(ProductoOfertadoDTO productoX,String codPadre,ArrayList listaProdTipo,String prefOfertContr, 
			                     String idProdContratado, String indCondicionContratacion, String esHijo, String esAutoAfin, 
			                     String lcElementoContratado, ProductoContratadoDTO productoCX)
	{
		ProductoWeb productoWeb = new  ProductoWeb(productoX);
		//en caso que el productoweb no sea de ningun paquete, su codpadre es el abonado
		productoWeb.setEsHijo(esHijo);
		productoWeb.setIndCondicionContratacion(indCondicionContratacion);
		productoWeb.setChequeado(chequearDef(prefOfertContr));
		productoWeb.setIdProdContratado(idProdContratado);
		productoWeb.setCodPadre(codPadre);
		
		//Producto Contratado - Se rescata LC
		if(lcElementoContratado!=null)
		{ /////if(lcElementoContratado.equals("129")) lcElementoContratado = "123";///test ok
			productoWeb.setCodLimConsuSeleccionado(lcElementoContratado);
			productoWeb.setCodLimConsuInicial(lcElementoContratado);
			logger.debug("IdentidorProdOfert     ["+productoWeb.getProductoDTO().getIdentificadorProductoOfertado()+"]");
			logger.debug("IdProductoOfertado     ["+productoWeb.getProductoDTO().getIdProductoOfertado()+"]");
			logger.debug("lcElementoContratado   ["+lcElementoContratado+"]");
			logger.debug("--------------------------------------");

		}
		productoWeb.setMtoConsumido("0");
		/*esto ya no iria*/
		if(productoX !=null && productoX.getListaLimCons()!=null && productoX.getListaLimCons().getLimitesDeConsumo()!=null &&
		   productoX.getListaLimCons().getLimitesDeConsumo().length > 0 && productoX.getListaLimCons().getLimitesDeConsumo()[0]!=null)
		{
			productoWeb.setMtoConsumido(productoX.getListaLimCons().getLimitesDeConsumo()[0].getMtoConsumido().toString());
		}
		/*120210 esto deberia ser ya que aca están ordenados por IndDefault().equals("S")*/
		LimiteConsumoPlanAdicionalDTO limConsPlanDTO = null;
		if(productoWeb.getListaLimiteConsumoValMto()!=null && 
		   productoWeb.getListaLimiteConsumoValMto().size() > 0 &&
		   productoWeb.getListaLimiteConsumoValMto().get(0)!=null)
		{
			limConsPlanDTO = (LimiteConsumoPlanAdicionalDTO)productoWeb.getListaLimiteConsumoValMto().get(0);
			if(limConsPlanDTO.getMtoConsumido() != null)
			{
				productoWeb.setMtoConsumido(limConsPlanDTO.getMtoConsumido().toString());
				logger.debug("codLimCons(InDf S)     ["+limConsPlanDTO.getCodLimCons()+"]");
			}else
			{
				logger.debug("limConsPlanDTO.getMtoConsumido() -->mto NULL  CodLimCons["+limConsPlanDTO.getCodLimCons()+"]");
			}
			logger.debug("IdentidorProdOfert     ["+productoWeb.getProductoDTO().getIdentificadorProductoOfertado()+"]");
			logger.debug("IdProductoOfertado     ["+productoWeb.getProductoDTO().getIdProductoOfertado()+"]");
		}
		/**/
		/*se busca el limite seteado fin */
		if(productoCX != null && productoCX.getMtoConsumoConfigurado()!= null){
			productoWeb.setMtoConsumido(productoCX.getMtoConsumoConfigurado().toString());
			if(productoWeb.getListaLimiteConsumoValMto()!=null && 
					   productoWeb.getListaLimiteConsumoValMto().size() > 0 &&
					   productoWeb.getListaLimiteConsumoValMto().get(0)!=null)
			{
				
				ArrayList listaLimiteConsumoValMto = productoWeb.getListaLimiteConsumoValMto();
				ArrayList listaLimiteConsumoValMtoSel = new ArrayList();
				LimiteConsumoPlanAdicionalDTO lc  = new LimiteConsumoPlanAdicionalDTO();
				LimiteConsumoPlanAdicionalDTO lct = new LimiteConsumoPlanAdicionalDTO();
				lc.setCodLimCons("-0");
				lc.setDescripcion("- Seleccione -");
				lc.setIndDefault("N");
				lc.setMtoConsumido(new Float(productoWeb.getMtoConsumido()));
				lc.setMtoMinimo(new Float(0));
				lc.setMtoMaximo(new Float(0));
				//lcSelect = listaLimiteConsumoValMto.get(arg0);
				listaLimiteConsumoValMtoSel.add(lc);
				for(int i=0;i<listaLimiteConsumoValMto.size();i++)
				{
					lc = (LimiteConsumoPlanAdicionalDTO)listaLimiteConsumoValMto.get(i);
					logger.debug("productoWeb.MtoConsumido["+productoWeb.getMtoConsumido()+"]");
					if(lcElementoContratado.equals(lc.getCodLimCons()))
					{
						logger.debug("getCodLimCons           ["+lc.getCodLimCons()+"]");
						logger.debug("getIndDefault           ["+lc.getIndDefault()+"]");
						logger.debug("lcElementoContratado    ["+lcElementoContratado+"]");
						logger.debug("getMtoConsumoConfigurado["+lc.getMtoConsumoConfigurado()+"]");
					}
					logger.debug("---------------");
					if("SIN LIMITE".equals(lc.getDescripcion()))
					{
						listaLimiteConsumoValMtoSel=listaLimiteConsumoValMto;
						break;
					}else
					{
						listaLimiteConsumoValMtoSel.add(lc);
					}
				}
				productoWeb.setListaLimiteConsumoValMto(listaLimiteConsumoValMtoSel);
			}
			
		}
		/*se busca el limite seteado fin */
		//productoWeb.setMtoConsumido(productoX.getListaLimCons()!=null?productoX.getListaLimCons().getLimitesDeConsumo()[0].getMtoConsumido().toString():"");//gtm 031209
		//productoWeb.setMtoMinimo(mtoMinimo);//gtm 031209
		//productoWeb.setMtoMaximo(mtoMaximo)//gtm 031209
		//separa productos de numeros frecuentes para producto
		productoWeb.setMaximo(Integer.parseInt(productoX.getMaxContrataciones()));
		productoWeb.setEsAutoAfin(esAutoAfin);
		discriminaNumFrec(productoWeb);
		//la agrego para identificar un idproducto con un listado de num
		agregarAutoAfin(productoX,productoWeb,prefOfertContr);
		
		//(+) EV 05-04-2010 Datos correo movistar
		String idEspecProvision = "";
		try{
			idEspecProvision = productoX.getEspecificacionProducto().getEspecServicioClienteList().getEspServCliList()[0].getIdEspecProvision();
			logger.debug("idEspecProvision="+idEspecProvision);
			productoWeb.setIdEspecProvision(idEspecProvision);
			if (VentaUtils.esCorreoSeven(this.parametrosCorreo, idEspecProvision)){
				logger.debug("es correo seven");
				productoWeb.setModificable(1);
			}
		}catch(Exception e){};
		//(-) EV 05-04-2010 Datos correo movistar
		
		/*test correo seven ini*/
		/*boolean esPlanCorreoSeven = verificarEsCorreoSeven(productoX);
		if(esPlanCorreoSeven)
		{
			productoWeb.setModificable(1);
			productoWeb.setEsCorreoSeven(true);
		}*/
		/*test correo seven fin*/
		listaProdTipo.add(productoWeb);
	}
	
	private boolean verificarEsCorreoSeven(ProductoOfertadoDTO productoX) {
		boolean esPlanCorreo = false;
		if(tieneEspServCliList(productoX))
		{
			String idEspecProvision = productoX.getEspecificacionProducto().getEspecServicioClienteList().getEspServCliList()[0].getIdEspecProvision();
			esPlanCorreo = VentaUtils.esCorreoSeven(parametrosCorreo, idEspecProvision);
		}
		return esPlanCorreo;
	}
	
	private boolean tieneEspServCliList(ProductoOfertadoDTO productoX) {
		if(productoX == null ||
		   productoX.getEspecificacionProducto() == null || 
		   productoX.getEspecificacionProducto().getEspecServicioClienteList()                        == null ||
		   productoX.getEspecificacionProducto().getEspecServicioClienteList().getEspServCliList()	  == null ||
		   productoX.getEspecificacionProducto().getEspecServicioClienteList().getEspServCliList()[0] == null)
		{
			return false;
		}
		return true;
	}
	
	private void agregarProductoPaq(ProductoOfertadoDTO productoX,String codPadre,ArrayList listaProdTipo, String prefOfertContr, int sizePaq, String idProdContratado, String indCondicionContratacion)
	{	//creo el producto paquete
		ProductoWeb productoWeb = new  ProductoWeb(productoX);
		productoWeb.setEsHijo("0");
		productoWeb.setIndCondicionContratacion(indCondicionContratacion);
		productoWeb.setChequeado(chequearDef(prefOfertContr));
		productoWeb.setIdProdContratado(idProdContratado);
		productoWeb.setSizePaq(sizePaq);
		productoWeb.setCodPadre(codPadre);
		productoWeb.setMaximo(Integer.parseInt(productoX.getMaxContrataciones()));
		listaProdTipo.add(productoWeb);
	}

	private void agregarAutoAfin(ProductoOfertadoDTO productoOfer,ProductoWeb ppaqWeb,String prefOfertContr) {
		ArrayList arrayAutoAfin = new ArrayList();
		arrayAutoAfin.add(abonadoDTO);
		try{
			if (productoOfer.getEspecificacionProducto()
			.getEspecServicioClienteList().getEspecSerLisList()
			.getEspecServicioListaList()[0].getIndAutoAfinidad()
			.equals("S")){
				//agregarAutoAfin();
				productosClienteAfines.put(prefOfertContr + String.valueOf(abonadoDTO.getNumAbonado())+ "." + ppaqWeb.getCorrelativo(), arrayAutoAfin);
			}
		}catch(Exception e)
		{
			//System.err.println("agregarAutoAfin "+e.getMessage());
		}
	}
	
	
	private ArrayList obtieneArrProdDisponibles(String bitacora,String[] cantidades)
	{
		ArrayList productos = new ArrayList();
		StringTokenizer st = new StringTokenizer(bitacora,"|");
		while(st.hasMoreTokens())
		{
			StringTokenizer stp = new StringTokenizer(st.nextToken(),".");
			stp.nextToken();//tipo
			stp.nextToken();//padre
			productos.add(stp.nextToken());//idproddisponible
		}
		return productos;
	}
	
	private void imprimeIdServBase(ProductoOfertadoDTO ofertadoDTO) {
		try{
			String idServicioBase = ofertadoDTO.getEspecificacionProducto().getEspecServicioClienteList().getEspServCliList()[0].getIdServicioBase();
			logger.debug("indPaquete         ["+ofertadoDTO.getIndPaquete()+"]");
			logger.debug("idProductoOfertado ["+ofertadoDTO.getIdProductoOfertado()+"]");
			logger.debug("idServicioBase     ["+idServicioBase+"]");
		}
		catch(Exception e){
			logger.debug("indPaquete         ["+ofertadoDTO.getIndPaquete()+"]");
			logger.debug("idProductoOfertado ["+ofertadoDTO.getIdProductoOfertado()+"]");
			logger.debug("idServicioBase     ["+e.getMessage()+"]");
		}
		logger.debug("------------------------------------------------------------");
	}
	
	private boolean chequearDef(String prefOfertContr) {
		//if("D".equals(indCondicionContratacion))
		if("D.".equals(prefOfertContr))
		{
			return true;
		}
		return false;
		//if("O".equals(indCondicionContratacion)){modoCont = "Opcional";}return modoCont;
	}
	
	private void discriminaNumFrec(ProductoWeb ppaqWeb){		
		
		try
		{
			ProductoOfertadoDTO prod = (ProductoOfertadoDTO)ppaqWeb.getProductoDTO();
			if (("PFRC").equals(prod.getEspecificacionProducto().getTipoComportamiento())){
					listaProducNumFreq.add(ppaqWeb);
			}
			else
			{
				listaProducNoNumFreq.add(ppaqWeb);
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}

	public ArrayList getLimiteConsumoProductos() {
		return limiteConsumoProductos;
	}
	public void setLimiteConsumoProductos(ArrayList limiteConsumoProductos) {
		this.limiteConsumoProductos = limiteConsumoProductos;
	}
	public ArrayList getProductosContratados() {
		return productoPorDefecto;
	}
	
	public ArrayList getProductosDisponible() {
		return productoDisponibles;
	}

	public void setProductosDisponible(ArrayList productoDisponibles) {
		this.productoDisponibles=productoDisponibles;
	}

	public void setProductoPorDefecto(ArrayList productoPorDefecto) {
		this.productoPorDefecto = productoPorDefecto;
	}

	public ArrayList getListaProducNoNumFreq() {
		return listaProducNoNumFreq;
	}

	public void setListaProducNoNumFreq(ArrayList listaProducNoNumFreq) {
		this.listaProducNoNumFreq = listaProducNoNumFreq;
	}

	public ArrayList getListaProducNumFreq() {
		return listaProducNumFreq;
	}

	public void setListaProducNumFreq(ArrayList listaProducNumFreq) {
		this.listaProducNumFreq = listaProducNumFreq;
	}	

	public ArrayList getProductoPorDefecto() {
		return productoPorDefecto;
	}

	public ProductoContratadoFrecDTO[] getNumFreqProductos() {
		return productoContratadoFrecDTO;
	}
	
	public void setNumFreqProductos(ProductoContratadoFrecDTO[] productoFrec) {
		// TODO Auto-generated method stub
		this.productoContratadoFrecDTO=productoFrec;
	}

	public ArrayList getListaClienteAfines(String idListaAfines) {
		// TODO Auto-generated method stub
		return (ArrayList) productosClienteAfines.get(idListaAfines);
	}	

	public HashMap getTodosClienteAfines() {
		// TODO Auto-generated method stub
		return productosClienteAfines;
	}	
	
	public void setListaClienteAfines(String idListaAfines , ArrayList listaClienteAfines) {
		// TODO Auto-generated method stub
		productosClienteAfines.put(idListaAfines,listaClienteAfines);
	}

	public PaqueteListDTO getPaquetesOfertadosAbonado() {
		return paquetesOfertadosAbonado;
	}

	public ProductoOfertadoListDTO getProductosOfertadosAbonado() {
		return productosOfertadosAbonado;
	}

	public AbonadoDTO getAbonado() {
		return abonadoDTO;
	}

	public ProductoContratadoListDTO getProductosCont() {
		return productosCont;
	}

	public void setProductosCont(ProductoContratadoListDTO productosCont) {
		this.productosCont = productosCont;
	}

	public ProductoOfertadoListDTO getProductosOfer() {
		return productosOfer;
	}

	public void setProductosOfer(ProductoOfertadoListDTO productosOfer) {
		this.productosOfer = productosOfer;
	}

	public int getHayAutoAfinCont() {
		return hayAutoAfinCont;
	}

	public void setHayAutoAfinCont(int hayAutoAfinCont) {
		this.hayAutoAfinCont = hayAutoAfinCont;
	}
	
	public HashMap getParametrosCorreo() {
		return parametrosCorreo;
	}
	
}

/**
 *   PaqueteWEB 
 *   
 *   Esta clase guarda todos los cambios por abonado; es decir, todos los 
 *   productos y paquetes relacionados al id del abonado o cliente..
 *   
 *   Tambien genera los metodos necesarios para las validaciones que necesite
 *   cada producto y que pueda necesitar por ende la clase NavegacionWeb.java
 * 
 * */

