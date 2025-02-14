package com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper;

import java.rmi.RemoteException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.StringTokenizer;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.OrdenServicioDTO;
import com.tmmas.scl.framework.marketSalesDomain.contactLeadProspectABE.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.CatalogoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.EspecProductoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PaqueteDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PaqueteListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroListDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ProductoContratadoFrecDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate.ManageRequestBussinessDelegate;

public class PaqueteWeb  {

	private ArrayList productoDisponibles;
	private ArrayList productoPorDefecto;
	private ArrayList listaProducNoNumFreq = new ArrayList();
	private ArrayList listaProducNumFreq  = new ArrayList();
	private HashMap productosClienteAfines = new HashMap();
	private ProductoContratadoFrecDTO[] productoContratadoFrecDTO = null;
	private AbonadoDTO abonadoDTO;
	//CTH
	private ProductoOfertadoListDTO productosOfertadosAbonado;
	private PaqueteListDTO  paquetesOfertadosAbonado;
	
	private ProductoContratadoListDTO productosCont;
	private ProductoOfertadoListDTO   productosOfer;
	private int hayAutoAfinCont = 0;
	private ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();
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
		
		public PaqueteWeb(AbonadoDTO abonadoPar,ClienteDTO cliente,OrdenServicioDTO ordenServicio) throws RemoteException, GeneralException 
		{
			ArrayList productosOfertados=new ArrayList();
			this.abonadoDTO = abonadoPar;
	//		solo se llama al creador de esta clase, cuando es la primera vez que se visitan los productos de un abonado o cliente
			ProductoContratadoListDTO productosContratados;			
			ProductoOfertadoListDTO productosOfertables;
			//ProductoOfertadoListDTO retorno=new ProductoOfertadoListDTO();
			//ProductoOfertadoListDTO dtoEntrada=new ProductoOfertadoListDTO();
			ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();
			
			//PlanTarifarioDTO planTarifario= new PlanTarifarioDTO();
			//abonadoDTO.setCatalogo(obtenerCatalogo());
	        VentaDTO venta = new VentaDTO();
			venta.setIdVenta("2741025");
			productosContratados = delegate.obtenerProductoContratado(ordenServicio);
			productosCont = productosContratados;
			productosOfertables = delegate.obtenerProductosOfertables(abonadoDTO);//(abonadoLista.getAbonados()[0]);
			productosOfer = productosOfertables;
			productoPorDefecto = new ArrayList();//estas listas guardan ProductoWeb
			productoDisponibles = new ArrayList();
	
			System.out.println("PaqueteWeb productoPorDefecto.size() "+productoPorDefecto.size());
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
				agruparProducto(productoX,productoPorDefecto,"D.",productoCX.getIdProdContratado().toString(),productoCX.getIndCondicionContratacion(),esAutoAfin);	
			}
			System.out.println("-----------------------OFERTADOS------------------------------------------------->");
			esAutoAfin = "0";
			StringBuffer sb= new StringBuffer("\n");
			for (int p = 0;p<productosOfertables.getProductoList().length;p++){			//CTH guardar producto ofertado			
				ProductoOfertadoDTO productoX = productosOfertables.getProductoList()[p];
				esAutoAfin = verificaAfinidad(productoX,cliente,fechaActual);
				sb.append("Pofer "+productoX.getIdProductoOfertado()+" esAutoAfin ["+esAutoAfin+"]\n");
				//System.out.println("esAutoAfin  "+esAutoAfin);
				productosOfertados.add(productoX);
				agruparProducto(productoX,productoDisponibles,"O.",null,productoX.getIndCondicionContratacion(),esAutoAfin);	
			}
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
						System.out.println("producto ofertado PAFN "+productoX.getIdentificadorProductoOfertado()+" sin espSerListaList \n"+e.getMessage());
					}
					if(indAutoAfinidad!=null && "S".equals(indAutoAfinidad))
					{
						NumeroDTO     ndto = new NumeroDTO();
						ndto.setIdCliente(""+cliente.getCodCliente());
						ndto.setFecInicioVigencia(new Timestamp((productoX.getFecInicioVigencia()).getTime()));
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
						System.out.println("especProd.getTipoComportamiento() = null "+productoX.getIdentificadorProductoOfertado());
					}
				}
			}
			else
			{
				System.out.println("EspecProductoDTO = null "+productoX.getIdentificadorProductoOfertado());
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
			ndto.setFecInicioVigencia(new Timestamp(productoX.getFecInicioVigencia().getTime()));
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
						System.out.println("En PaqueteWeb.java esAutoAfin producto ofertado PAFN "+productoX.getIdentificadorProductoOfertado()+" sin espSerListaList \n"+e.getMessage());
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
						System.out.println("especProd.getTipoComportamiento() = null "+productoX.getIdentificadorProductoOfertado());
					}
				}
			}
			else
			{
				System.out.println("EspecProductoDTO = null "+productoX.getIdentificadorProductoOfertado());
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

	private void agruparProducto(ProductoOfertadoDTO productoX,ArrayList listaProdTipo,String prefOfertContr, String idProdContratado, String indCondicionContratacion, String esAutoAfin) throws RemoteException, GeneralException 
	{
		//productoX.setFecTerminoVigencia(new Date());
		//Date date = productoX.getFecTerminoVigencia();
		//Calendar calendar =Calendar.getInstance(); //obtiene la fecha de hoy 
		//calendar.add(Calendar.DATE, -1); //el -3 indica que se le restaran 3 dias 
		
		ProductosContradosFrecUtil.imprimeProdOfer(productoX, null);
		if (productoX.getIndPaquete().equals("1"))
		{
//			TODO: ver si esta rutina conviene meterla dentro del ProductoWeb o no;
			PaqueteDTO paqueteDeProducto=new PaqueteDTO();	
			paqueteDeProducto.setCodProdPadre(productoX.getIdProductoOfertado());
			ProductoOfertadoListDTO detallePaq = delegate.obtenerProductosOfertablesPorPaquete(paqueteDeProducto);
			if(detallePaq!=null)
			{
				agregarProductoPaq(productoX,String.valueOf(abonadoDTO.getNumAbonado()),listaProdTipo,prefOfertContr,detallePaq.getProductoList().length,idProdContratado,indCondicionContratacion);			
				for (int ppaq = 0;ppaq<detallePaq.getProductoList().length;ppaq++){
					
					ProductosContradosFrecUtil.imprimeProdOfer(detallePaq.getProductoList()[ppaq],productoX.getIdProductoOfertado());
					agregarProducto(detallePaq.getProductoList()[ppaq],productoX.getIdProductoOfertado(),listaProdTipo,prefOfertContr,idProdContratado,indCondicionContratacion,"1",esAutoAfin);		
				}//String tipoComp = "";tipoComp = productoX.getEspecificacionProducto().getTipoComportamiento();
			}
			else
			{
				System.out.println("PaqueteWeb ProductoOfertadoListDTO-->delegate.obtenerProductosOfertablesPorPaquete(paqueteDeProducto);--->NULO");
			}
		}
		else
		{
			agregarProducto(productoX,String.valueOf(abonadoDTO.getNumAbonado()),listaProdTipo,prefOfertContr,idProdContratado,indCondicionContratacion,"0",esAutoAfin);
		}
	}
	private void agregarAutoAfin(String codigoAfin) {
		ArrayList arrayAutoAfin = new ArrayList();
		arrayAutoAfin.add(abonadoDTO);
		productosClienteAfines.put(codigoAfin, arrayAutoAfin);	
	}
	private void agregarProducto(ProductoOfertadoDTO productoX,String codPadre,ArrayList listaProdTipo,String prefOfertContr, 
			                     String idProdContratado, String indCondicionContratacion, String esHijo, String esAutoAfin)
	{
		ProductoWeb productoWeb = new  ProductoWeb(productoX);
		//en caso que el productoweb no sea de ningun paquete, su codpadre es el abonado
		productoWeb.setEsHijo(esHijo);
		productoWeb.setIndCondicionContratacion(indCondicionContratacion);
		productoWeb.setChequeado(chequearDef(prefOfertContr));
		productoWeb.setIdProdContratado(idProdContratado);
		productoWeb.setCodPadre(codPadre);
		//separa productos de numeros frecuentes para producto
		productoWeb.setMaximo(Integer.parseInt(productoX.getMaxContrataciones()));
		productoWeb.setEsAutoAfin(esAutoAfin);
		discriminaNumFrec(productoWeb);
		//la agrego para identificar un idproducto con un listado de num
		agregarAutoAfin(productoX,productoWeb,prefOfertContr);	
		listaProdTipo.add(productoWeb);
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

