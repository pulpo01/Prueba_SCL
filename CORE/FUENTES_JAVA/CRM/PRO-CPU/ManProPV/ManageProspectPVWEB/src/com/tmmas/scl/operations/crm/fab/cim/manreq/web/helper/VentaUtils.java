package com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper;

import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.StringTokenizer;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.OrdenServicioDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.marketSalesDomain.contactLeadProspectABE.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.CatalogoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PaqueteDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PaqueteListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroListDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.ParamRegistroPlanDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.RegistroPlanDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.businessObject.bo.XMLDefault;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ControlDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.DefaultPaginaCPUDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ProductoContratadoFrecDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.SeccionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ValoresDefectoPaginaDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.exception.ManReqException;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.action.ProductoAction;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate.ManageRequestBussinessDelegate;

public class VentaUtils 
{
	private static final Logger logger = Logger.getLogger(ProductoAction.class);
	private static VentaUtils instance;
	private static Global global = Global.getInstance();
	private static ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();
	public static HashMap  parametrosCorreo = null;
	public static VentaUtils getInstance()
	{
		if(instance==null)
		{
			instance=new VentaUtils();
		}
		
		return instance;
	}
	
	private VentaUtils()
	{
		
	}	
//	---------------------------------------------------------------------------------------------------------------------	
	public AbonadoDTO getAbonado(String idAbonado,VentaDTO venta)
	{
		AbonadoDTO abonRetorno=null;
		
		if(venta!=null && venta.getCliente()!=null && venta.getCliente().getAbonados()!=null && idAbonado!=null)
		{
			for(int i=0;i<venta.getCliente().getAbonados().getAbonados().length;i++)
			{
				AbonadoDTO auxAbon=venta.getCliente().getAbonados().getAbonados()[i];
				if(idAbonado.equalsIgnoreCase(String.valueOf(auxAbon.getNumAbonado())))
				{					
					abonRetorno=auxAbon;
					abonRetorno.setCodCliente(venta.getCliente().getCodCliente());
				}
			}
		}		
		return abonRetorno;
	}
//	---------------------------------------------------------------------------------------------------------------------	
	public ProductoOfertadoDTO getProductoOfertado(String idAbonado,String idProdOfertado,VentaDTO venta)
	{
		ProductoOfertadoDTO prodOfertadoReturn=null;		
		if(venta!=null && venta.getCliente()!=null && venta.getCliente().getAbonados()!=null && idAbonado!=null && idProdOfertado!=null)
		{
			for(int indexAbon=0;indexAbon<venta.getCliente().getAbonados().getAbonados().length;indexAbon++)
			{
				AbonadoDTO abonAux=venta.getCliente().getAbonados().getAbonados()[indexAbon];				
				if(idAbonado.equalsIgnoreCase(String.valueOf(abonAux.getNumAbonado())));
				{	
					if(abonAux.getProdOfertList()!=null)
					{
						ProductoOfertadoListDTO listaProductos=venta.getCliente().getAbonados().getAbonados()[indexAbon].getProdOfertList();						
						for(int indexProd=0;indexProd<listaProductos.getProductoList().length;indexProd++)
						{
							if(listaProductos.getProductoList()[indexProd].getIdProductoOfertado().equalsIgnoreCase(idProdOfertado))
							{
								prodOfertadoReturn=listaProductos.getProductoList()[indexProd];
							}
						}
					}
				}
			}
		}		
		return prodOfertadoReturn;
	}
//---------------------------------------------------------------------------------------------------------------------
	public VentaDTO generarVentaDTO(NavegacionWeb navegacion,VentaDTO venta)
	{
		venta.setNumEvento(navegacion.getNumEvento());
		venta.setNumTransaccion(navegacion.getNumTransaccion());
		venta.setCodVendedor(navegacion.getCodVendedor());
		venta.setFlagCiclo(navegacion.getFlagCiclo());
		
		ClienteDTO cliente=venta.getCliente();
		AbonadoListDTO listaAbonados=cliente.getAbonados();		
		
		for(int indexAbon=0;indexAbon<listaAbonados.getAbonados().length;indexAbon++)
		{
			AbonadoDTO abon=listaAbonados.getAbonados()[indexAbon];			
			PaqueteWeb paqueteWeb=navegacion.getPaqueteWeb(String.valueOf(abon.getNumAbonado()));			
			//abon=paqueteWeb.getAbonado();		
			
			ArrayList listaProductosOfertadosAContratar=new ArrayList();
			ArrayList listaPaquetesOfertadosAContratar=new ArrayList();
			
			/**
			 * Sacando productos por defecto
			 */			
			ArrayList listProdPorDefectos=paqueteWeb.getProductoPorDefecto();
			ProductoContratadoFrecDTO[] listaProdFrecuentes=paqueteWeb.getNumFreqProductos();
						
			for(Iterator it=listProdPorDefectos.iterator();it.hasNext();)
			{
				boolean matchProducto=false; 
				
				ProductoWeb prodWeb=(ProductoWeb)it.next();				
				if(prodWeb.getChequeado())
				{
					String codigoListaAfines="D."+prodWeb.getCodPadre()+"."+prodWeb.getCodigo();					
					ArrayList listaAfines=paqueteWeb.getListaClienteAfines(codigoListaAfines);					
					if(listaAfines==null)
						listaAfines=new ArrayList();
					if(listaProdFrecuentes==null)
						listaProdFrecuentes=new ProductoContratadoFrecDTO[0];
					
					NumeroListDTO listaNumeros=this.obtenerListaNumerosPorCliente(listaAfines,listaProdFrecuentes,prodWeb.getCodigo(),"D");
					
					for(int indexProdOfer=0;indexProdOfer<abon.getProdOfertList().getProductoList().length && !matchProducto;indexProdOfer++)						
					{
						ProductoOfertadoDTO prodOfAux=abon.getProdOfertList().getProductoList()[indexProdOfer];						
						if("D".equals(prodOfAux.getIndCondicionContratacion()) && prodWeb.getCodigo().equals(prodOfAux.getIdProductoOfertado()) && !"1".equals(prodOfAux.getIndPaquete()))
						{
							if(prodOfAux.getEspecificacionProducto()!=null)
							{
								listaNumeros.setTipoComportamiento(prodOfAux.getEspecificacionProducto().getTipoComportamiento());
								prodOfAux.setListaNumeros(listaNumeros);
							}
							int cantidadContratar=prodWeb.getCantidadContratado();
							while(cantidadContratar>0)
							{
								listaProductosOfertadosAContratar.add(prodOfAux);
								cantidadContratar--;
							}							
							matchProducto=true;
						}					
						prodOfAux.setLimiteConsumoSeleccionado(prodWeb.getCodLimConsuSeleccionado());
						prodOfAux.setListaLimCons(prodWeb.getProductoDTO().getListaLimCons());
					}					
				}				
			}
			
			
			/**
			 * Sacando productos y paquetes ofertables opcionales seleccionados 
			 */			
			ArrayList listaProdOpcionales=paqueteWeb.getProductosDisponible();				
			
			for(Iterator itLista=listaProdOpcionales.iterator();itLista.hasNext();)
			{
				boolean matchProducto=false; 
				
				ProductoWeb prodWeb=(ProductoWeb)itLista.next();
				if(prodWeb.getChequeado())
				{
					String codigoListaAfines="O."+prodWeb.getCodPadre()+"."+prodWeb.getCodigo();
					ArrayList listaAfines=paqueteWeb.getListaClienteAfines(codigoListaAfines);
					
					if(listaAfines==null)
						listaAfines=new ArrayList();
					if(listaProdFrecuentes==null)
						listaProdFrecuentes=new ProductoContratadoFrecDTO[0];					
					NumeroListDTO listaNumeros=this.obtenerListaNumerosPorCliente(listaAfines,listaProdFrecuentes,prodWeb.getCodigo(),"O");
					
					/**
					 * LLenando Productos NO PRODUCTOS DE PAQUETE
					 */
					
					for(int indexProdOfer=0;indexProdOfer<abon.getProdOfertList().getProductoList().length && !matchProducto;indexProdOfer++)						
					{
						ProductoOfertadoDTO prodOfAux=abon.getProdOfertList().getProductoList()[indexProdOfer];						
						if( "O".equals(prodOfAux.getIndCondicionContratacion()) && 
							prodWeb.getCodigo().equals(prodOfAux.getIdProductoOfertado()) && 
							!"1".equals(prodOfAux.getIndPaquete()) &&
							prodWeb.getCodPadre().equals(String.valueOf(abon.getNumAbonado()))) // Esta ultima condicion es para filtrar de que el producto no este dentro de un paquete
						{
							if(prodOfAux.getEspecificacionProducto()!=null)
							{
								listaNumeros.setTipoComportamiento(prodOfAux.getEspecificacionProducto().getTipoComportamiento());
								prodOfAux.setListaNumeros(listaNumeros);
							}														
							int cantidadContratar=prodWeb.getCantidadContratado();
							prodOfAux.setLimiteConsumoSeleccionado(prodWeb.getCodLimConsuSeleccionado());
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
			
			/**
			 * Llenando paquetes y sus productos					 * 
			 */
			
			PaqueteListDTO paquetesAbonado=abon.getPaqueteList();			
			
			for(int indexPaq=0;indexPaq<paquetesAbonado.getPaqueteList().length;indexPaq++)
			{
				PaqueteDTO paqueteAux=paquetesAbonado.getPaqueteList()[indexPaq];				
				ArrayList productosPaquete=new ArrayList();
			
					for(Iterator itLista=listaProdOpcionales.iterator();itLista.hasNext();)
					{
						boolean matchProducto=false; 
						
						ProductoWeb prodWeb=(ProductoWeb)itLista.next();
						if(prodWeb.getChequeado())
						{
							String codigoListaAfines="O."+prodWeb.getCodPadre()+"."+prodWeb.getCodigo();
							ArrayList listaAfines=paqueteWeb.getListaClienteAfines(codigoListaAfines);
							if(listaAfines==null)
								listaAfines=new ArrayList();
							if(listaProdFrecuentes==null)
								listaProdFrecuentes=new ProductoContratadoFrecDTO[0];
							NumeroListDTO listaNumeros=this.obtenerListaNumerosPorCliente(listaAfines,listaProdFrecuentes,prodWeb.getCodigo(),"O");							
							
							/**
							 * LLenando PRODUCTOS DE PAQUETE
							 */
							
							for(int indexProdOfer=0;indexProdOfer<paqueteAux.getProductoList().getProductoList().length && !matchProducto;indexProdOfer++)						
							{
								ProductoOfertadoDTO prodOfAux=paqueteAux.getProductoList().getProductoList()[indexProdOfer];						
								if( "O".equals(prodOfAux.getIndCondicionContratacion()) && 
									prodWeb.getCodigo().equals(prodOfAux.getIdProductoOfertado()) &&	
									!"1".equals(prodOfAux.getIndPaquete()) &&
									prodWeb.getCodPadre().equals(paqueteAux.getIdPaquete()))
								{
									if(prodOfAux.getEspecificacionProducto()!=null)
									{
										listaNumeros.setTipoComportamiento(prodOfAux.getEspecificacionProducto().getTipoComportamiento());
										prodOfAux.setListaNumeros(listaNumeros);
									}									
									int cantidadContratar=prodWeb.getCantidadContratado();
									prodOfAux.setLimiteConsumoSeleccionado(prodWeb.getCodLimConsuSeleccionado());
									prodOfAux.setListaLimCons(prodWeb.getProductoDTO().getListaLimCons());
									while(cantidadContratar>0)
									{
										productosPaquete.add(prodOfAux);
										cantidadContratar--;
									}							
									matchProducto=true;
								}
							}					
						}
					}
					
				ProductoOfertadoDTO[] productosDePaquete=(ProductoOfertadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(productosPaquete.toArray(), ProductoOfertadoDTO.class);
				ProductoOfertadoListDTO prodOferListPaquete=new ProductoOfertadoListDTO();
				prodOferListPaquete.setProductoList(productosDePaquete);
				paqueteAux.setProductoList(null);
				paqueteAux.setProductoList(prodOferListPaquete);
				
				// Se busca el identificador del paquete para saber cuantas veces se debe contratar
				if(productosPaquete.size()>0)
				{
					ProductoWeb prodWeb=null;
					for(Iterator itLista=listaProdOpcionales.iterator();itLista.hasNext();)
					{						
						prodWeb=(ProductoWeb)itLista.next();
						if("1".equalsIgnoreCase(prodWeb.getPaquete()) && prodWeb.getCodigo().equals(paqueteAux.getIdPaquete()))
							break;
					}
					if(prodWeb!=null)
					{
						int cantidadContratar=prodWeb.getCantidadContratado();
						while(cantidadContratar>0)
						{							
							listaPaquetesOfertadosAContratar.add(paqueteAux);
							cantidadContratar--;
						}
					}
				}					
			}
		
			ProductoOfertadoDTO[] productosTotalesAContratarArray=(ProductoOfertadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(listaProductosOfertadosAContratar.toArray(), ProductoOfertadoDTO.class);
			PaqueteDTO[] 		  paquetesTotalesAContratarArray=(PaqueteDTO[]) ArrayUtl.copiaArregloTipoEspecifico(listaPaquetesOfertadosAContratar.toArray(), PaqueteDTO.class);
			
			ProductoOfertadoListDTO contratacionProductoList=new ProductoOfertadoListDTO();
			contratacionProductoList.setProductoList(productosTotalesAContratarArray);
			
			PaqueteListDTO contratacionPaqueteList=new PaqueteListDTO();
			contratacionPaqueteList.setPaqueteList(paquetesTotalesAContratarArray);		
			
			abon.setProdOfertList(contratacionProductoList);
			abon.setPaqueteList(contratacionPaqueteList);
			
			listaAbonados.getAbonados()[indexAbon]=abon;			
		}	
		
		cliente.setAbonados(listaAbonados);
		venta.setCliente(cliente);		
		return venta;		
	}
	
	public NumeroListDTO obtenerListaNumerosPorCliente(ArrayList listaClientes,ProductoContratadoFrecDTO[] listaProdFrecuentes,String idProducto,String tipoProducto)
	{
		NumeroListDTO numeroList=new NumeroListDTO();
		ArrayList listaNumeros=new ArrayList();
		ProductosContradosFrecUtil prodFrecUtils=new ProductosContradosFrecUtil();
		
		NumeroDTO[] numeros=null;		
		
		if(listaClientes!=null)
		{
			for(Iterator it=listaClientes.iterator();it.hasNext();)
			{
				ClienteDTO cliente=(ClienteDTO)it.next();
				NumeroDTO numero=new NumeroDTO();			
				numero.setCodCategoriaDest(null);
				numero.setNro(String.valueOf(cliente.getCodCliente()));			
				listaNumeros.add(numero);
			}
		}
		
		if(listaProdFrecuentes!=null)
		{
			for(int i=0;i<listaProdFrecuentes.length;i++)
			{
				ProductoContratadoFrecDTO prodContFrec=listaProdFrecuentes[i];
				
				if(tipoProducto.equalsIgnoreCase(prodContFrec.getIndCondicionContr()) && idProducto.equalsIgnoreCase(prodContFrec.getIdProductoOfertado()))
				{				
					NumeroListDTO numerosListAux=prodFrecUtils.obtieneListaNumeros(prodContFrec);
								
					for(int j=0;j<numerosListAux.getNumerosDTO().length;j++)
					{
						listaNumeros.add(numerosListAux.getNumerosDTO()[j]);
					}				
				}			
			}
		}
		numeros=(NumeroDTO[]) ArrayUtl.copiaArregloTipoEspecifico(listaNumeros.toArray(), NumeroDTO.class);		
		numeroList.setNumerosDTO(numeros);
		
		return numeroList;
	}
	
	public static String formatoEstandar(String fvalor)
	{
		float ftstdmax = 9999999;
		float ft2 = Float.parseFloat(fvalor);//toString ==> 4.5456456E7
		
		if(ftstdmax >= ft2)
		{
			return fvalor;
		}
		DecimalFormat df = new DecimalFormat(".0000");
		Float flt = new Float(fvalor);
		String retorno = df.format(flt.floatValue());// ==> 45456456,0000
		StringTokenizer st = new StringTokenizer(retorno,",");
		retorno = st.nextToken()+"."+st.nextToken();//  ==> 45456456.0000  (punto decimal)
		return retorno;
	}
	
	public static String[] obtenerListaProdLC(ProductoOfertadoListDTO productoOfertadoListCont)
	{
	
		ProductoOfertadoDTO[] productosOfertSel = productoOfertadoListCont.getProductoList();
		ProductoOfertadoDTO productoOferSel = null;
		String[] prodSelLCArr = new String[productosOfertSel.length];
		for(int i=0;i<productosOfertSel.length;i++)
		{
			productoOferSel = productosOfertSel[i];
			if(productoOferSel.getListaLimCons()!= null && 
					productoOferSel.getListaLimCons().getLimitesDeConsumo().length > 0)
			{
				prodSelLCArr[i] = productoOferSel.getIdProductoOfertado();
			}else
			{
				prodSelLCArr[i] = null;
			}
		}
		return prodSelLCArr;
	}
	
	public static String[] completarArreglo(String[] prodSelLCArr, String[] arrIncomp, String valor) {
		
		String[] arrComp = new String[prodSelLCArr.length];
		int indexLC = 0;
		for(int i=0;i<prodSelLCArr.length;i++)
		{
			if(prodSelLCArr[i]!= null)
			{
				arrComp[i] = arrIncomp[indexLC++];
			}else
			{
				arrComp[i] = valor;
			}
		}
		return arrComp;
	}
	
	public static String[] ordenarCantidadesOrd(String[] cantidades, int[] indicesOrd) {
		String[] cantidadesOrd = new String[cantidades.length];
		for(int i=0;i<cantidades.length;i++)
		{
			cantidadesOrd[i]=cantidades[indicesOrd[i]];//malo:cantidadesOrd[indicesOrd[i]]=cantidades[i];
		}
		return cantidadesOrd;
	}
	
	public static String [] obtenerArreglo(String cadena, String separador)
	{
		StringTokenizer st = new StringTokenizer(cadena,separador);
		int numElementos = st.countTokens();
		String [] retorno = new String [numElementos];
		for(int i=0;i<numElementos;i++)
		{
			retorno[i] = st.nextToken();
		}
		return retorno;
	}
	
	public static int[] obtenerIndicesCant(String[] bit)
	{
		logger.debug("bit           ["+imprimirArray(bit)+"]");
		int [] indices = new int[bit.length];
		int [] indicesOrdRet = new int[bit.length];
		for(int i=0;i<bit.length;i++)
		{
			indices[i]=Integer.parseInt(bit[i]);
			indicesOrdRet[i]=Integer.parseInt(bit[i]); 
		}
		ordenar(indices);
		logger.debug("indices       ["+imprimirArray(indices)+"]");
		for(int i=0;i<indices.length;i++)
		{
			for(int j=0;j<indices.length;j++)
			{
				if(indices[i] == indicesOrdRet[j])
				{
					indicesOrdRet[j] = i;
					continue;
				}
			}
		}
		logger.debug("indicesOrdRet ["+imprimirArray(indicesOrdRet)+"]");
		return indicesOrdRet;
	}
	
	private static void ordenar( int [] arreglo) {
		for (int i = 0; i < arreglo.length; i++) {
			for (int j = 0; j < arreglo.length - 1; j++) {
				if (arreglo[j] > arreglo[j + 1]) {
					intercambiar(arreglo, j, j+1);
				}
			}
		}
	}
	
	private static void intercambiar(int [] arreglo, int a, int b) {
		int tmp = arreglo[a];
		arreglo[a] = arreglo[b];
		arreglo[b] = tmp;
	}
	
	
	public static void imprimirDatosRecuperados(String[] cantidades, String[] montoslc, String[] limConsumoCodigosOfer) {
		logger.debug("cantidades    ["+imprimirArray(cantidades)+"]");
		logger.debug("montoslc      ["+imprimirArray(montoslc)+"]");
		logger.debug("limConsCodOfer["+imprimirArray(limConsumoCodigosOfer)+"]");
	}
	
	
	public static String imprimirArray(String[] array)
	{
		String retorno = "";
		if(array == null) return "null";
		
		if(array.length>1)
		{
			for(int i=0;i<array.length-1;i++)
			{
				retorno+=array[i]+",";
			}
		}
		retorno+=array[array.length-1];
		return retorno;
	}
	
	public static String imprimirArray(int[] array)
	{
		String retorno = "";
		if(array == null) return "null";
		
		if(array.length>1)
		{
			for(int i=0;i<array.length-1;i++)
			{
				retorno+=array[i]+",";
			}
		}
		retorno+=array[array.length-1];
		return retorno;
	}

	public static void imprimirProd(ProductoContratadoListDTO productoContratadoListDesc, ProductoContratadoDTO[] productoContratadoArrNoDesc) {
		try
		{
			ProductoContratadoDTO[] pdts = productoContratadoListDesc.getProductosContratadosDTO();
			logger.debug("PRODUCTOS A DESCONTRATAR");
			for(int i=0;i<pdts.length;i++)
			{
				logger.debug("idProdContrata["+pdts[i].getIdProdContratado()+"]");
				logger.debug("desProdOfertdo["+pdts[i].getProdOfertado().getDesProdOfertado()+"]");
				logger.debug("--------------------------------");
			}
			logger.debug("PRODUCTOS NO DESCHECKEADOS (posible cambio lc)");
			for(int i=0;i<productoContratadoArrNoDesc.length;i++)
			{
				logger.debug("idProdContrata["+productoContratadoArrNoDesc[i].getIdProdContratado()+"]");
				logger.debug("desProdOfertdo["+productoContratadoArrNoDesc[i].getProdOfertado().getDesProdOfertado()+"]");
				logger.debug("--------------------------------");
			}
		}
		catch(Exception e)
		{
			logger.debug("Exception en imprimirProd ["+e.getMessage()+"]");
		}
	}
	
	public static void imprimirProdModLC(ProductoContratadoListDTO productoContratadoMantenidosLC) {
		try
		{
			logger.debug("PRODUCTOS CONTRATADOS QUE MODIFICAN LIMITE DE CONSUMO");
			if(productoContratadoMantenidosLC !=null && productoContratadoMantenidosLC.getProductosContratadosDTO() !=null )
			{
				ProductoContratadoDTO[] pdt = productoContratadoMantenidosLC.getProductosContratadosDTO();
				for(int i=0;i<pdt.length;i++)
				{
					logger.debug("idProdContrata["+pdt[i].getIdProdContratado()+"]");
					logger.debug("desProdOfertdo["+pdt[i].getProdOfertado().getDesProdOfertado()+"]");
					logger.debug("limConsuCrtado["+pdt[i].getlimiteConsumoContratado()+"]");
					logger.debug("mtoConsuConfig["+pdt[i].getMtoConsumoConfigurado()+"]");
					logger.debug("nombreUsuario ["+pdt[i].getNombreUsuario()+"]");
					logger.debug("fecProcDescont["+pdt[i].getFechaProcesoDescontrata()+"]");
					logger.debug("--------------------------------");
				}
			}else
			{
				logger.debug("productoContratadoMantenidosLC =null o no hay productos que modifiquen LC");
			}
		}
		catch(Exception e)
		{
			logger.debug("Exception en imprimirProdModLC ["+e.getMessage()+"]");
		}
	}

	public static Date agregarUnSegundo(Date fechaHoraBaseDatos) {
		Date fecha = (Date)fechaHoraBaseDatos.clone();
		fecha.setSeconds(fecha.getSeconds()+1);
		return fecha;
	}
	
	public static boolean esCorreo(HashMap hm, String idEspecProvision) {
		boolean retorno = false;
		String valor = null;
		for(int i=1;i<11;i++)
		{
			valor = (String) hm.get("X"+i);
			if(valor.equals(idEspecProvision)){
				retorno = true;
				logger.debug("esCorreo X"+i+"["+valor+"]");
				break;
			}
			
		}
		//revisar si se debe filtrar:
		/*String [] parametros = {"sev.ci", "sev.il", "sec.is", "bb.ci", "bb.is"};
		for(int i=0;i<parametros.length;i++)
		{
			valor = (String) hm.get(parametros[i]);
			logger.debug(parametros[i]+"["+valor+"]");
		}*/
		logger.debug("esCorreo ["+retorno+"]");
		return retorno;
	}
	
	public static boolean esCorreoSeven(HashMap hm, String idEspecProvision) {
		boolean retorno = false;
		String valor = null;
		for(int i=1;i<8;i++)
		{
			valor = (String) hm.get("X"+i);
			if(valor.equals(idEspecProvision)){
				retorno = true;
				logger.debug("esCorreoSeven X"+i+"["+valor+"]");
				break;
			}
			
		}
		//logger.debug("esCorreo ["+retorno+"]");
		return retorno;
	}
	
	public static int obtenerIndiceProductoPorId(ArrayList listaProdTipo, String identificadorProducto)
	{
		ProductoWeb productoWeb;
		String tipo;
		String codPadre;//en caso que el productoweb no sea de ningun paquete, su codpadre es el abonado
		String idProd;
		String idProdSel;
		int retorno = -1;
		StringTokenizer stp = new StringTokenizer(identificadorProducto,".");
		tipo = stp.nextToken();//tipo
		codPadre = stp.nextToken();//padre
		idProd = stp.nextToken();
		for(int i=0;i<listaProdTipo.size();i++)
		{
			productoWeb = (ProductoWeb)listaProdTipo.get(i);
			//productoWeb.getEsHijo() revisar
			if(productoWeb.getIdProdContratado() == null)// es ofertable
			{
				idProdSel = productoWeb.getProductoDTO().getIdProductoOfertado();
			}
			else
			{
				idProdSel = productoWeb.getIdProdContratado();
			}
			if(codPadre.equals(productoWeb.getCodPadre()) && idProd.equals(idProdSel))/*tipo.equals(productoWeb.getTipo()) && */
			{
				logger.debug("obtenerIndiceProductoPorId idProd "+idProdSel+"   ----------------------->");
				retorno = i;
				break;
			}
		}
		logger.debug("obtenerIndiceProductoPorId indice "+retorno+"   ----------------------->");

		return retorno;
	}

	public static ValoresDefectoPaginaDTO obtenerValoresCorreoDefecto(){
	    //(+)05/04/10 Lectura de archivo XML de configuracion, parseo y carga en objeto de sesion
		ValoresDefectoPaginaDTO definicionPagina= new ValoresDefectoPaginaDTO();
	 	String dirXML = global.getValor("configCorreo.xml");//"config.xml");
	 	String dir = System.getProperty("user.dir") +dirXML;
	 	logger.debug("dir="+dir);
	 	ParseoXML parseo=new ParseoXML();
		logger.debug("leyendo y parseando XML configuración:antes");
		definicionPagina=parseo.cargaXML(dir);
		logger.debug("leyendo y parseando XML configuración:despues");
	    //(-)05/04/10 Lectura de archivo XML de configuracion, parseo y carga en objeto de sesion
		return definicionPagina;
	}
	
	public static HashMap obtenerParametrosCorreo() throws ManReqException {
		logger.debug("obtenerParametrosCorreo ini");
		if(parametrosCorreo!=null) return parametrosCorreo;
		String parametro;
		ParametroDTO paramGral = null;
		ParametroDTO param = new ParametroDTO();
		HashMap hm = new HashMap();
		param.setCodModulo(global.getValor("codigo.modulo.GA").trim());
		param.setCodProducto(Integer.parseInt(global.getValor("codigo.producto").trim())); 
		
		for(int i=1;i<11;i++)
		{
			parametro = global.getValor("correo.mov.x"+i);
			logger.debug("Buscando parametro["+parametro+"]");
			param.setNomParametro(parametro.trim());
			paramGral = delegate.obtenerParametroGeneral(param);
			logger.debug("X"+i+"["+paramGral.getValor()+"]");
			hm.put("X"+i, paramGral.getValor());
		}
		String paramCorreo = "correo.mov.";
		String [] parametros = {"sev.ci", "sev.il", "sev.is", "bb.ci", "bb.is"};
		for(int i=0;i<parametros.length;i++)
		{
			parametro = global.getValor(paramCorreo+(parametros[i]));
			logger.debug("Buscando parametro["+parametro+"]");
			param.setNomParametro(parametro.trim());
			paramGral = delegate.obtenerParametroGeneral(param);
			logger.debug(parametros[i]+"["+paramGral.getValor()+"]");
			hm.put(parametros[i], paramGral.getValor());
		}
		imprimeHMCorreo(hm);
		logger.debug("obtenerParametrosCorreo fin");
		parametrosCorreo = hm;
		return hm;
	}
	
	private static void imprimeHMCorreo(HashMap hm) {
		logger.debug("Parametros Correo ini");
		String valor = null;
		for(int i=1;i<11;i++)
		{
			valor = (String) hm.get("X"+i);
			logger.debug("X"+i+"["+valor+"]");
		}
		String [] parametros = {"sev.ci", "sev.il", "sev.is", "bb.ci", "bb.is"};
		for(int i=0;i<parametros.length;i++)
		{
			valor = (String) hm.get(parametros[i]);
			logger.debug(parametros[i]+"["+valor+"]");
		}
		logger.debug("Parametros Correo fin");
	}
	
	public static AbonadoDTO obtieneAbonado(AbonadoDTO abonado,String canal, String  nivelApl,String codVendedor) throws ManReqException {

		abonado.setCatalogo(obtenerCatalogo(canal,nivelApl,codVendedor));
		abonado.setPlanTarifario(new PlanTarifarioDTO());
		abonado.getPlanTarifario().setPaqueteDefault(new PaqueteDTO());
		abonado.getPlanTarifario().getPaqueteDefault().setCodProdPadre("13");//TODO REVISAR QUE NO AFECTE LA W
		return abonado;
	}

	private static CatalogoDTO obtenerCatalogo(String canal, String nivelApl,String codVendedor) {
		CatalogoDTO catalogo = new CatalogoDTO();
		Calendar cal= Calendar.getInstance();			
		cal.set(3000,11,31);			
		catalogo.setCodCanal(canal);//"PV"
		catalogo.setFecInicioVigencia(new Date());
		catalogo.setFecTerminoVigencia(new Date(cal.getTimeInMillis()));
		catalogo.setIndNivelAplica(nivelApl);//C
		catalogo.setCodVendedor(codVendedor);
		return catalogo;
	}

	public static OrdenServicioDTO obtieneOrdenServ(ClienteDTO cliente) throws ManReqException {
		OrdenServicioDTO ordenServicio = new OrdenServicioDTO();
		ordenServicio.setIdOrdenServicio(1);
		ordenServicio.setNumOrdenServicio("13");
		ordenServicio.setCliente(cliente);
		ordenServicio.setTipoComportamiento(null);
		return ordenServicio;
	}

	public static ArrayList obtenerControlesList(ClienteOSSesionDTO sessionData) {
		XMLDefault objetoXML	= new XMLDefault();
	    DefaultPaginaCPUDTO objetoXMLSession = new DefaultPaginaCPUDTO();
	    SeccionDTO seccion=new SeccionDTO();
	    ArrayList controlesList = new ArrayList();
	    objetoXMLSession = sessionData.getDefaultPagina();
	    seccion = objetoXML.obtenerSeccion(objetoXMLSession, "piePaginaCargosPAG", "CargosCondicionesRegistroSS");    
	    controlesList.add(seccion.obtControl("condicionesCK"));
	    ControlDTO control = seccion.obtControl("condicionesCK");
	    
	   
	    return controlesList;
	}
	
	public static RegistroPlanDTO obtenerRegistroPlan()
	{
		RegistroPlanDTO registroPlan=new RegistroPlanDTO();
		ParamRegistroPlanDTO param = new ParamRegistroPlanDTO();	
		
		param.setCombinatoria("");
		param.setNomUsuaOra("");
		param.setFecDesdeLlam("");
		param.setFecDesdeLlamTS(new Timestamp((new Date()).getTime()));
		param.setCodPlanTarifDestino("");
		param.setTipOOSS("");
		
		registroPlan.setParamRegistroPlan(param);
		return registroPlan;
	}
}
