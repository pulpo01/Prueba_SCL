package com.tmmas.scl.operations.crm.f.s.manpro.web.helper;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.StringTokenizer;

import org.apache.log4j.Logger;

import net.sf.dozer.util.mapping.DozerBeanMapper;
import net.sf.dozer.util.mapping.MapperIF;
import net.sf.dozer.util.mapping.util.MapperConstants;

import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.marketSalesDomain.contactLeadProspectABE.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.CargoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.CargoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PaqueteDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PaqueteListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroListDTO;
import com.tmmas.scl.operations.crm.f.s.manpro.frmk.dataTransferObject.ProductoContratadoFrecDTO;
import com.tmmas.scl.operations.crm.f.s.manpro.web.action.DespliegaCargosAction;

public class VentaUtils 
{
	private final Logger logger = Logger.getLogger(VentaUtils.class);	
	private static VentaUtils instance;
	MapperIF mapperIF= new DozerBeanMapper();
	
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
		//venta.setNumEvento(navegacion.getNumEvento());
		venta.setNumTransaccion(navegacion.getNumTransaccion());
		venta.setCodVendedor(navegacion.getCodVendedor());
		venta.setFlagCiclo(navegacion.getFlagCiclo());
		
		ClienteDTO cliente=venta.getCliente();
		AbonadoListDTO listaAbonados=cliente.getAbonados();		
		
		for(int indexAbon=0;indexAbon<listaAbonados.getAbonados().length;indexAbon++)
		{
			logger.debug("Ingreso generarVentaDTO");
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
			
			logger.debug("Listado por defectos "+listProdPorDefectos.size());
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
						prodOfAux.setMtoConsumoConfigurado(prodWeb.getMtoConsumoConfigurado());
					}					
				}				
			}
			
			
			/**
			 * Sacando productos y paquetes ofertables opcionales seleccionados 
			 */			
			ArrayList listaProdOpcionales=paqueteWeb.getProductosDisponible();				
			
			logger.debug("Cantidad Productos ofertables "+listaProdOpcionales.size());
			for(Iterator itLista=listaProdOpcionales.iterator();itLista.hasNext();)
			{
				boolean matchProducto=false; 
				
				ProductoWeb prodWeb=(ProductoWeb)itLista.next();
				//logger.debug("Cantidad Productos ofertables chekeados "+prodWeb.getChequeado());
				if(prodWeb.getChequeado() || prodWeb.getTipoPlanAdic().equals("2")) //INC TMM 155400
				{
					
					/* INICIO INC 155400 VMB 19112010
					 * Se modifica para diferenciar los planes adicionales, D (Default) // O (Opcionales)
					 * y al momento de guardar la información, esta se almacene con la informacion correspondiente 
					 * */
					
					
					String codigoListaAfines="";					
					venta.setHayPDTporDefecto(true); //Para agregarsela a los obligatorios
					//logger.debug("Valor de los chequeados "+prodWeb.getTipoPlanAdic());
					if ("2".equals(prodWeb.getTipoPlanAdic())) 
						codigoListaAfines="B."+prodWeb.getCodPadre()+"."+prodWeb.getCodigo();
					else
						codigoListaAfines="O."+prodWeb.getCodPadre()+"."+prodWeb.getCodigo();
					// TERMINO INC 155400 13-06-2010 
					
					
					ArrayList listaAfines=paqueteWeb.getListaClienteAfines(codigoListaAfines);
					
					//logger.debug("Valor de las lista afines "+codigoListaAfines);
					
					
					if(listaAfines==null) {
						listaAfines=new ArrayList();
						logger.debug("lista afines nulo");
					}	
					
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
							
							
							
							ArrayList newCargosListDTO=new ArrayList();
							for(int k=0;k<prodOfAux.getCargoList().getCargoList().length;k++){
								String tipoCargo=prodOfAux.getCargoList().getCargoList()[k].getTipoCargo();
								String tipoCobro =prodOfAux.getCargoList().getCargoList()[k].getTipoCobro();
								newCargosListDTO.add(prodOfAux.getCargoList().getCargoList()[k]);
								if ("R".equals(tipoCargo)&&"A".equals(tipoCobro)){
									CargoDTO cargo=new CargoDTO();
									mapperIF.map(prodOfAux.getCargoList().getCargoList()[k],cargo);
									cargo.setTipoCargo("O");
									newCargosListDTO.add(cargo);
								}
							}
							
							CargoDTO[] cargos=(CargoDTO[])ArrayUtl.copiaArregloTipoEspecifico(newCargosListDTO.toArray(),CargoDTO.class);
							prodOfAux.getCargoList().setCargoList(cargos);
							
							
							
							int cantidadContratar=prodWeb.getCantidadContratado();
							prodOfAux.setLimiteConsumoSeleccionado(prodWeb.getCodLimConsuSeleccionado());
							prodOfAux.setMtoConsumoConfigurado(prodWeb.getMtoConsumoConfigurado());
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
						if(prodWeb.getChequeado() || prodWeb.getTipoPlanAdic().equals("2"))
						{
							/* INICIO INC 155400 VMB 19112010
							 * Se modifica para diferenciar los planes adicionales, b (Default) // O (Opcionales)
							 * y al momento de guardar la información, esta se almacene con la informacion correspondiente 
							 * */
							String codigoListaAfines="";
							if ("2".equals(prodWeb.getTipoPlanAdic())) 							
								codigoListaAfines="B."+prodWeb.getCodPadre()+"."+prodWeb.getCodigo();
							else 
								codigoListaAfines="O."+prodWeb.getCodPadre()+"."+prodWeb.getCodigo();
							// INICIO INC 155400 VMB 19112010
							
							
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
	
	public boolean hayProductosCheckeados(NavegacionWeb navegacion, VentaDTO venta) {
		
		ClienteDTO cliente=venta.getCliente();
		AbonadoListDTO listaAbonados=cliente.getAbonados();	
		
		for(int indexAbon=0;indexAbon<listaAbonados.getAbonados().length;indexAbon++)
		{
			AbonadoDTO abon=listaAbonados.getAbonados()[indexAbon];			
			PaqueteWeb paqueteWeb=navegacion.getPaqueteWeb(String.valueOf(abon.getNumAbonado()));	
			ArrayList listaProdOpcionales=paqueteWeb.getProductosDisponible();
			for(Iterator itLista=listaProdOpcionales.iterator();itLista.hasNext();)
			{
				ProductoWeb prodWeb=(ProductoWeb)itLista.next();
				if(prodWeb.getChequeado())
				{
					return true;
				}
			}
		}
		return false;
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
	
	public static boolean esCorreo(HashMap hm, String idEspecProvision) {
		boolean retorno = false;
		String valor = null;
		for(int i=1;i<11;i++){
			valor = (String) hm.get("X"+i);
			if(valor.equals(idEspecProvision)){
				retorno = true;
				//logger.debug("PA X"+i+"[cod_prov_serv = "+valor+"]");
				break;
			}
		}

		return retorno;
	}
	
	public static boolean esCorreoSeven(HashMap hm, String idEspecProvision) {
		boolean retorno = false;
		String valor = null;
		for(int i=1;i<8;i++){
			valor = (String) hm.get("X"+i);
			if(valor.equals(idEspecProvision)){
				retorno = true;
				break;
			}
		}

		return retorno;
	}	
}
