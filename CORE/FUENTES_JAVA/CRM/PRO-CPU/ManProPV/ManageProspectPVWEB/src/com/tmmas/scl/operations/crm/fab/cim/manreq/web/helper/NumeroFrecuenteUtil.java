package com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.log4j.Logger;

import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.ReglasListaNumerosDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.NumeroFrecuenteDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.NumeroFrecuenteTipoListDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ProductoContratadoFrecDTO;

public class NumeroFrecuenteUtil {
	
	String  CLASS_NAME = "NumeroFrecuenteUtil";
	//private static ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();
	private final static Logger logger = Logger.getLogger(NumeroFrecuenteUtil.class);
	static String onnet   ="ON-NET";
	static String redfija ="RED-FIJA";
	static String offnet  ="OFF-NET";
	static String redInalam ="RED-INALAMBRICA";
	static String satelital ="SATELITAL";
	static String inter ="INTERNACIONAL";
	static HashMap hmTipos = new HashMap();
	//static //agregar tipos
	//Este arreglo debe venir como dato y a partir de este se realizará el filtro por tipos de Numeros Frecuentes
	private String[] arrTipos = {onnet,redfija,offnet,redInalam,satelital};
	public static String generaTipo()
	{
		String tipo   = onnet;
		Double d = new Double(Math.random()*10);
		int numero = d.intValue();
		if(numero>5)
		{
			numero = numero-3;
		}
		if(numero>5)
		{
			numero = numero-1;
		}
//		switch (numero)case 1: tipo = offnet;break;case 2: tipo = redfija;break;case 3: tipo = onnet;}
		if(numero == 1)
		{
			tipo = offnet;
		}
		else if(numero == 2)
		{
			 tipo = redfija;
		}
		else if(numero == 3)
		{
			tipo = onnet;
		}
		if(numero == 4)
		{
			tipo = redInalam;
		}
		if(numero == 5)
		{
			tipo = satelital;
		}
		
		return tipo;
	}
	

	public ArrayList filtrarNumeroFrecPorTipoArrSiNum(ProductoOfertadoDTO productoNumFreq,NumeroFrecuenteDTO [] listaNumFrecuentes)//, String[] arrTipos)
	{
		ArrayList retorno = null;//new NumeroFrecuenteDTO [][]();
		retorno = new ArrayList();
		

		
		int cantCatg = productoNumFreq.getListaReglasNumeros().getReglaLisNumList().length;
		for(int cap=0;cap<cantCatg;cap++){
			ReglasListaNumerosDTO cate = productoNumFreq.getListaReglasNumeros().getReglaLisNumList()[cap];
			//productoNumFreq.getListaReglasNumeros().get
			NumeroFrecuenteTipoListDTO numeroFrecuenteTipoListDTO = new NumeroFrecuenteTipoListDTO();
			//log3("IdProdOfertado "+productoNumFreq.getIdProductoOfertado()+"   CantidadMaxTipo "+Integer.parseInt(cate.getCantidadMaxima())+"   Tipo "+hmTipos.get(cate.getCodCategoriaDestino())+"     i  "+cap);
			numeroFrecuenteTipoListDTO.setCantidadMaxTipo(Integer.parseInt(cate.getCantidadMaxima()));
			numeroFrecuenteTipoListDTO.setTipo((String)getHmTipos().get(cate.getCodCategoriaDestino()));
			numeroFrecuenteTipoListDTO.setNumFrecuentesIngresadosList(listaNumFrecuentes);
			retorno.add(numeroFrecuenteTipoListDTO);
		}
		//log3("IdProductoOfertado "+productoNumFreq.getIdProductoOfertado()+" arrNumFrecPorTipot.size "+retorno.size());
		return retorno;
	}


	public ArrayList filtrarNumeroFrecPorTipoArr(ProductoOfertadoDTO productoNumFreq,NumeroFrecuenteDTO [] numeroFrecuenteDTO)//, String[] arrTipos)
	{
		//El largo del HM tiene el mismo largo que el arrTipos
		ArrayList retorno = null;//new NumeroFrecuenteDTO [][]();
		//log2("filtrarNumeroFrecPorTipoArr numeroFrecuenteDTO.length "+numeroFrecuenteDTO.length);
		try
		{
			if(numeroFrecuenteDTO.length<1)
			{
				retorno = filtrarNumeroFrecPorTipoArrSiNum(productoNumFreq,numeroFrecuenteDTO);
			}
			else
			{
				ReglasListaNumerosDTO[] reglaNumeroArr = productoNumFreq.getListaReglasNumeros().getReglaLisNumList();
				HashMap hmFiltradoNumFrecPorTipo = filtrarNumeroFrecPorTipo(numeroFrecuenteDTO,reglaNumeroArr);
				
				//log2("filtrarNumeroFrecPorTipoArr numeroFrecuenteDTO.length "+numeroFrecuenteDTO.length);
				//log2("filtrarNumeroFrecPorTipoArr reglaNumeroArr.length "+reglaNumeroArr.length);
				//log2("filtrarNumeroFrecPorTipoArr Numero de tipos hmFiltradoNumFrecPorTipo.size() "+hmFiltradoNumFrecPorTipo.size());
				hmFiltradoNumFrecPorTipo.size();
				retorno = new ArrayList();
				
				int cantCatg = reglaNumeroArr.length;
				for(int i=0;i<cantCatg;i++)
				{
					ReglasListaNumerosDTO reglaNumero = reglaNumeroArr[i];
					String tipo = reglaNumero.getCodCategoriaDestino();//.getTipoLista();//reglaNumeroArr[i].getTipoLista();//arrTipos[i];
					tipo = (String)getHmTipos().get(tipo);//(String)hmTipos.get(tipo);
					NumeroFrecuenteTipoListDTO numeroFrecuenteTipoListDTO = new NumeroFrecuenteTipoListDTO();
					numeroFrecuenteTipoListDTO.setCantidadMaxTipo(Integer.parseInt(reglaNumero.getCantidadMaxima()));
					numeroFrecuenteTipoListDTO.setTipo(tipo);
					if(hmFiltradoNumFrecPorTipo.get(tipo) != null )
					{
						NumeroFrecuenteDTO [] numFrecuenteDTOarr = (NumeroFrecuenteDTO [])hmFiltradoNumFrecPorTipo.get(tipo);
						numeroFrecuenteTipoListDTO.setNumFrecuentesIngresadosList(numFrecuenteDTOarr);
					}
					else
					{
						numeroFrecuenteTipoListDTO.setNumFrecuentesIngresadosList(new NumeroFrecuenteDTO [0]);
						logger.debug("No encontre numeros de tipo reglaNumero["+i+"] "+tipo+" --------------------------->");
					}
					retorno.add(numeroFrecuenteTipoListDTO);
				}
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}



		//logger.debug("arrNumFrecPorTipot.size "+retorno.size()+" --------------------------->");
		return retorno;
	}
	
	/** El metodo filtrarNumeroFrecPorTipo(NumeroFrecuenteDTO [] numeroFrecuenteDTO) recibe un arreglo simple de numerosfrecuentes con
	 *  diferentes tipos (on-net, red-fija, etc) y los agrupa en NumeroFrecuenteDTO [] para tipos especificos agregando estos nuevos
	 *  arreglos a un HashMap en el que el key es un String que representa el tipo de numero.
	 * @param reglaNumeroArr 
	 * 
	 * */
	public HashMap filtrarNumeroFrecPorTipo(NumeroFrecuenteDTO [] numeroFrecuenteDTO, ReglasListaNumerosDTO[] reglaNumeroArr)
	{
		//logger.debug("filtrarNumeroFrecPorTipo numeroFrecuenteDTO.length "+numeroFrecuenteDTO.length);
		HashMap hmFiltradoNumFrecPorTipo = new HashMap();
		String tipoNumFrec = null;
		String tipo = null;
		for(int i=0;i<numeroFrecuenteDTO.length;i++)
		{
			NumeroFrecuenteDTO numeroFrecuente = numeroFrecuenteDTO[i];
			tipoNumFrec = numeroFrecuente.getTipo();
			for(int j=0;j<reglaNumeroArr.length;j++)
			{
				tipo = (String)getHmTipos().get(reglaNumeroArr[j].getCodCategoriaDestino());//.getTipoLista()//(String)hmTipos.get(tipo);
				//logger.debug("filtrarNumeroFrecPorTipo tipoR "+tipo+"    tipoNumFrec "+tipoNumFrec);
				if(tipoNumFrec == tipo)
				{
					//logger.debug("i "+i+" tipoNumFrec == arrTipos["+j+"] "+tipoNumFrec +" "+arrTipos[j]);
				}
				if(tipoNumFrec.equalsIgnoreCase(tipo))
				{
					//logger.debug("tipoNumFrec.equalsIgnoreCase(arrTipos["+j+"]) "+tipoNumFrec +" "+arrTipos[j]);
					logger.debug("AGREGA NUMERO "+numeroFrecuente.getNumero());
					agregaNumFrecPorTipo(hmFiltradoNumFrecPorTipo, numeroFrecuente, tipoNumFrec);
					break;
				}
			}
		}
		return hmFiltradoNumFrecPorTipo;
	}
	
	//retorna arreglo de NumeroFrecuenteDTO
	public void agregaNumFrecPorTipo(HashMap hmFiltradoNumFrecPorTipo, NumeroFrecuenteDTO numeroFrecuente, String tipoNumFrec)
	{
		//log("agregaNumFrecPorTipo");
		NumeroFrecuenteDTO [] numerosFrecuentes = null;
		NumeroFrecuenteDTO [] numerosFrecuentesTmp = null;
		try
		{
			if(hmFiltradoNumFrecPorTipo.get(tipoNumFrec) == null)
			{
				//logger.debug("\tNo hay elementos en hm de tipoNumFrec "+tipoNumFrec);
				numerosFrecuentesTmp = new NumeroFrecuenteDTO [1];
				numerosFrecuentesTmp[0] = numeroFrecuente;
				hmFiltradoNumFrecPorTipo.put(tipoNumFrec, numerosFrecuentesTmp);
			}
			else
			{
				numerosFrecuentesTmp = (NumeroFrecuenteDTO [])hmFiltradoNumFrecPorTipo.get(tipoNumFrec);
				numerosFrecuentes = new NumeroFrecuenteDTO [numerosFrecuentesTmp.length+1];
				for(int i=0;i<numerosFrecuentesTmp.length;i++)
				{
					numerosFrecuentes[i] = numerosFrecuentesTmp[i];
				}
				numerosFrecuentes[numerosFrecuentesTmp.length] = numeroFrecuente;
				//hmFiltradoNumFrecPorTipo.remove(tipoNumFrec);
				hmFiltradoNumFrecPorTipo.put(tipoNumFrec, numerosFrecuentes);//reemplazo el arreglo anterior	
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	
	public ArrayList getNumerosFrecuentesDeOtrosProductos(ProductoContratadoFrecDTO [] productoContratadoFrecSess,  String identificadorProducto, int indiceProdConFrec)//, String[] arrTipos)
	{
		String numFrecOtrosProd = "";
		ArrayList retorno = new ArrayList();
		ArrayList numProdArrList = null;
		NumeroFrecuenteDTO numeroFrecDTO = null;
		NumeroFrecuenteDTO[] numeroFrecArrDTO = null;
		NumeroFrecuenteTipoListDTO numFrecTipoListDTO = null;
		logger.debug("NumeroFrecuenteUtil getNumerosFrecuentesDeOtrosProductos --------------ini-----------------------------------------------------");
		logger.debug("identificadorProducto "+identificadorProducto);
		logger.debug("indiceProdConFrec     "+indiceProdConFrec);
		boolean addSl = false;
		int cantNum = 0;
		for(int i=0;i<productoContratadoFrecSess.length;i++)
		{
			ProductoContratadoFrecDTO productoContratadoFrecDTO = productoContratadoFrecSess[i];

			//envio los numeros de los otros productos
			if(i != indiceProdConFrec)
			{
				//debo buscar en los arraylist de arrdto porque aca están los nuevos números
				if(productoContratadoFrecDTO.getNumerosFrecuentesTipoListDTO() != null)
				{
					numProdArrList = productoContratadoFrecDTO.getNumerosFrecuentesTipoListDTO();
					for(int j=0;j < numProdArrList.size();j++)
					{
						numFrecTipoListDTO = (NumeroFrecuenteTipoListDTO)numProdArrList.get(j);
						numeroFrecArrDTO = numFrecTipoListDTO.getNumFrecuentesIngresadosList();
						addSl = false;
						for(int k=0;k<numeroFrecArrDTO.length;k++)
						{
							addSl = true;
							cantNum++;
							numeroFrecDTO = numeroFrecArrDTO[k];
							retorno.add(""+numeroFrecDTO.getNumero());
							numFrecOtrosProd+=numeroFrecDTO.getNumero()+"|";
						}
					}
					if(addSl)numFrecOtrosProd+="\n";
				}
				else
				{
					logger.debug("NFUtil getNumerosFrecuentesDeOtrosProductos productoContratadoFrecDTO.getNumerosFrecuentesTipoListDTO() != null ");
				}
			}		
		}
		
		logger.debug("NumeroFrecuenteUtil NumerosFrecuentesDeOtrosProductos cantNum "+cantNum+" \n\n"+numFrecOtrosProd);
		return retorno;
	}
	
	public ArrayList getTiposNumPermitidosProducto(ArrayList numeroFrecuenteTipoListDTO)
	{
		//log3("NumeroFrecuenteUtil getTiposNumPermitidosProducto");
		ArrayList retorno = new ArrayList();
		NumeroFrecuenteTipoListDTO numFrecTipoListDTO = null;
		try
		{
			for(int i=0;i<numeroFrecuenteTipoListDTO.size();i++)
			{
				numFrecTipoListDTO = (NumeroFrecuenteTipoListDTO)numeroFrecuenteTipoListDTO.get(i);
				//log3("NumeroFrecuenteUtil numFrecTipoListDTO.getTipo() "+numFrecTipoListDTO.getTipo());
				logger.debug("getTiposNumPermitidosProducto numFrecTipoListDTO.getTipo() "+numFrecTipoListDTO.getTipo());
				retorno.add(numFrecTipoListDTO.getTipo());
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}

		return retorno;
	}

	public void actualizaNumeros(ArrayList numerosFrecuentesTipoListDTO, ArrayList numerosFrecuentesDTO)
	{
		logger.debug("actualizaNumeros-------------------------ini-----------------------------------------");
		//imprimeNumTip(numeroFrecuenteDTOArrList);
		//imprimeNumNuevos(numerosFrecuentesDTO);
		NumeroFrecuenteDTO [] numeroFrecuenteTipDTOArr = null;
		NumeroFrecuenteDTO [] numFrecArrDto = null;
		try
		{
			logger.debug("Numeros nuevos y antiguos numerosFrecuentesDTO.size() "+numerosFrecuentesDTO.size());
			eliminaNumeros(numerosFrecuentesTipoListDTO, numerosFrecuentesDTO);
			
			for(int i=0;i<numerosFrecuentesDTO.size();i++)
			{
				//logger.debug("INI---------------------------------------NUEVOS---------------------->  i "+i);
				//TODO si el tipo no existe, lo creo, pero debería estar creado con largo 0. Tambien se podria ordenar la nueva lista numerosFrecuentesDTO
				NumeroFrecuenteDTO numeroFrecuenteDTO = (NumeroFrecuenteDTO)numerosFrecuentesDTO.get(i);
				if(numerosFrecuentesTipoListDTO == null)
				{
					logger.debug("numeroFrecuenteDTOArrList == null");
				}
				if(!existeNumero(numerosFrecuentesTipoListDTO, numeroFrecuenteDTO))//hay que sacar esto porque 1ro eliminaNumeros
				{
					numeroFrecuenteTipDTOArr = getNumeroFrecuenteTipDTOArr(numerosFrecuentesTipoListDTO,numeroFrecuenteDTO.getTipo());
					
					if(numeroFrecuenteTipDTOArr != null)
					{
						//numeroFrecuenteTipDTOArr = (NumeroFrecuenteDTO [])numeroFrecuenteDTOArrList.get(index);
						numFrecArrDto = agregaNumFrecPorTipo(numeroFrecuenteTipDTOArr,numeroFrecuenteDTO);
						int index = getIndexNumeroFrecuenteTipDTOArr(numerosFrecuentesTipoListDTO,numeroFrecuenteDTO.getTipo());
						logger.debug("DESPUES DE AGREGAR index "+index);
						
						NumeroFrecuenteTipoListDTO numFrecTipoListDTO = (NumeroFrecuenteTipoListDTO)numerosFrecuentesTipoListDTO.get(index);
						
						//imprimir
						NumeroFrecuenteDTO [] nfant = numFrecTipoListDTO.getNumFrecuentesIngresadosList();
						int lant =  nfant.length;
						
						numFrecTipoListDTO.setNumFrecuentesIngresadosList(numFrecArrDto);
						numerosFrecuentesTipoListDTO.set(index, numFrecTipoListDTO);
						
						//imprimir
						numFrecTipoListDTO = (NumeroFrecuenteTipoListDTO)numerosFrecuentesTipoListDTO.get(index);
						NumeroFrecuenteDTO [] nfdes =  numFrecTipoListDTO.getNumFrecuentesIngresadosList();
						int ldes =  nfdes.length;
						if(ldes>lant)
						{
							logger.debug("-----------------------------------------> lant "+lant+" ldes "+ldes);	
						}
					}
					else
					{
						numeroFrecuenteTipDTOArr = new NumeroFrecuenteDTO [1];
						numeroFrecuenteTipDTOArr[0] = numeroFrecuenteDTO;
						//numeroFrecuenteDTOArrList.add(numeroFrecuenteTipDTOArr);
						agregaNuevoArrNumFrecPorTipo(numerosFrecuentesTipoListDTO, numeroFrecuenteTipDTOArr);
					}	
				}
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		//logger.debug("despues de agregar DTO numeroFrecuenteTipDTOArr.length "+numeroFrecuenteTipDTOArr.length);
		logger.debug("actualizaNumeros-------------------------fin-----------------------------------------");
	}
	
	public void eliminaNumeros(ArrayList numerosFrecuentesTipoListDTO, ArrayList numerosFrecuentesDTO)
	{
		//logger.debug("eliminaNumeros    -------------->");
		//logger.debug("numeroFrecuenteDTOArrList.size() "+numerosFrecuentesTipoListDTO.size());
		//logger.debug("numerosFrecuentesDTO.size()      "+numerosFrecuentesDTO.size());
		//ArrayList retorno = new ArrayList();
		NumeroFrecuenteDTO [] numeroFrecuenteTipDTOArr = null;
		NumeroFrecuenteTipoListDTO numFrecTipoListDTO = null;
		ArrayList numFrecExistentes = null;
		try
		{
			for(int i=0;i<numerosFrecuentesTipoListDTO.size();i++)
			{
				numFrecTipoListDTO = (NumeroFrecuenteTipoListDTO)numerosFrecuentesTipoListDTO.get(i);
				numeroFrecuenteTipDTOArr = numFrecTipoListDTO.getNumFrecuentesIngresadosList();
				numFrecExistentes = new ArrayList();
				for(int j=0;j<numeroFrecuenteTipDTOArr.length;j++)
				{
					NumeroFrecuenteDTO numeroFrecuente = numeroFrecuenteTipDTOArr [j];
					logger.debug("BUSCANDO "+numeroFrecuente.getNumero()+" " +numeroFrecuente.getTipo()+"----------------------------->");
					if(existeNumeroArrSimple(numerosFrecuentesDTO,numeroFrecuente))
					{// o si existia lo voy agregando a retorno
						numFrecExistentes.add(numeroFrecuente);
						//eliminaNumero(numeroFrecuenteTipDTOArr, j);
					}
					else
					{
						logger.debug("NO ENCONTRE "+numeroFrecuente.getNumero()+" "+numeroFrecuente.getTipo());
						logger.debug("eliminaNumeros    -----------> "+numeroFrecuente.getNumero()); 
					}
				}
				numeroFrecuenteTipDTOArr = obtenerArrSimple(numFrecExistentes);
				numFrecTipoListDTO.setNumFrecuentesIngresadosList(numeroFrecuenteTipDTOArr);
				numerosFrecuentesTipoListDTO.set(i, numFrecTipoListDTO);
				//retorno.add(numFrecTipoListDTO);
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		logger.debug("eliminaNumeros fin -------------------------------------------------------------------------------->");
	}
	
	public NumeroFrecuenteDTO[] obtenerArrSimpleObj(ArrayList numFrecExistentes)
	{
		Object[] numFrecObjs = numFrecExistentes.toArray();//copia tipo especificico framework
		int largoNumFrec = numFrecObjs.length;
		NumeroFrecuenteDTO [] numerosFrecuentes = new NumeroFrecuenteDTO [largoNumFrec];
		for(int i=0;i<largoNumFrec;i++)
		{
			numerosFrecuentes[i] = (NumeroFrecuenteDTO)numFrecObjs[i];
		}
		return numerosFrecuentes;
	}
	
	public NumeroFrecuenteDTO[] obtenerArrSimple(ArrayList numFrecExistentes)
	{
		NumeroFrecuenteDTO [] numerosFrecuentes = new NumeroFrecuenteDTO [numFrecExistentes.size()];
		try
		{
			for(int k=0;k<numFrecExistentes.size();k++)
			{
				numerosFrecuentes[k] = (NumeroFrecuenteDTO)numFrecExistentes.get(k);
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return numerosFrecuentes;
	}
	
	public void eliminaNumeros2(ArrayList numerosFrecuentesTipoListDTO, ArrayList numerosFrecuentesDTO)
	{
		boolean eliminar = true;
		logger.debug("eliminaNumeros    ----------->");
		logger.debug("numeroFrecuenteDTOArrList.size() "+numerosFrecuentesTipoListDTO.size());
		logger.debug("numerosFrecuentesDTO.size() "+numerosFrecuentesDTO.size());
		NumeroFrecuenteDTO [] numeroFrecuenteTipDTOArr = null;
		NumeroFrecuenteTipoListDTO numFrecTipoListDTO = null;
		try
		{
			for(int i=0;i<numerosFrecuentesTipoListDTO.size();i++)
			{
				numFrecTipoListDTO = (NumeroFrecuenteTipoListDTO)numerosFrecuentesTipoListDTO.get(i);
				numeroFrecuenteTipDTOArr = numFrecTipoListDTO.getNumFrecuentesIngresadosList();
				for(int j=0;j<numeroFrecuenteTipDTOArr.length;j++)
				{
					NumeroFrecuenteDTO numeroFrecuente = numeroFrecuenteTipDTOArr [j];
					logger.debug("BUSCANDO "+numeroFrecuente.getNumero()+" " +numeroFrecuente.getTipo()+"----------------------------->");
					eliminar = true;
					for(int k=0;k<numerosFrecuentesDTO.size();k++)
					{
						NumeroFrecuenteDTO numeroFrecuenteReq = (NumeroFrecuenteDTO)numerosFrecuentesDTO.get(k);
						if(numeroFrecuente.getNumero() == numeroFrecuenteReq.getNumero())
						{
							logger.debug("EncontrE "+numeroFrecuenteReq.getNumero());
							eliminar = false;//segundo for:							
							break;
						}
					}
					if(eliminar)
					{
						logger.debug("NO EncontrE "+numeroFrecuente.getNumero()+" "+numeroFrecuente.getTipo());
						numFrecTipoListDTO.setNumFrecuentesIngresadosList(eliminaNumero(numeroFrecuenteTipDTOArr, j));
						numerosFrecuentesTipoListDTO.set(i, numFrecTipoListDTO);
						logger.debug("eliminaNumeros    -----------> "+numeroFrecuente.getNumero());
						//break;//no va a estar mas de una vez en el tipo
					}	
				}
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		logger.debug("eliminaNumeros fin -------------------------------------------------------------------------------->");
	}
	public NumeroFrecuenteDTO[] eliminaNumero(NumeroFrecuenteDTO[] numeroFrecuenteDTOarr, int indice)
	{
		NumeroFrecuenteDTO [] numerosFrecuentesTmp = null;
		try
		{
			int largoNum =  numeroFrecuenteDTOarr.length;  
			if(largoNum > 0)
			{
				numerosFrecuentesTmp = new NumeroFrecuenteDTO [largoNum-1];
				for(int i=0;i<indice;i++)
				{
					numerosFrecuentesTmp[i] = numeroFrecuenteDTOarr[i];
				}
				for(int i=indice+1;i<largoNum;i++)
				{
					numerosFrecuentesTmp[i-1] = numeroFrecuenteDTOarr[i];
				}
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		//numeroFrecuenteDTOarr = numerosFrecuentesTmp;
		return numerosFrecuentesTmp;
	}

	public boolean existeNumero(ArrayList numerosFrecuentesTipoListDTO, NumeroFrecuenteDTO numeroFrecuenteDTO)
	{
		NumeroFrecuenteDTO [] numeroFrecuenteTipDTOArr = null;
		NumeroFrecuenteTipoListDTO numFrecTipoListDTO = null;
		try
		{
			for(int i=0;i<numerosFrecuentesTipoListDTO.size();i++)
			{
				numFrecTipoListDTO = (NumeroFrecuenteTipoListDTO)numerosFrecuentesTipoListDTO.get(i);
				numeroFrecuenteTipDTOArr = numFrecTipoListDTO.getNumFrecuentesIngresadosList();
				if(existeNumero(numeroFrecuenteTipDTOArr,numeroFrecuenteDTO))
				{
					return true;
				}
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		logger.debug("NO EXISTE EN LA LISTA numeroFrecuente.getNumero() "+numeroFrecuenteDTO.getNumero());
		return false;
	}
	
	//arreglo simple de dtos, sin orden por tipos
	public boolean existeNumeroArrSimple(ArrayList numerosFrecuentesDTO, NumeroFrecuenteDTO numeroFrecuenteDTO)
	{
		NumeroFrecuenteDTO numeroFrecuenteReq = null;
		try
		{
			for(int k=0;k<numerosFrecuentesDTO.size();k++)
			{
				numeroFrecuenteReq = (NumeroFrecuenteDTO)numerosFrecuentesDTO.get(k);
				if(numeroFrecuenteReq.getNumero() == numeroFrecuenteDTO.getNumero())
				{
					return true;
				}
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		logger.debug("NO EXISTE EN LA LISTA simple numeroFrecuente.getNumero() "+numeroFrecuenteDTO.getNumero());
		return false;
	}

	public boolean existeNumero(NumeroFrecuenteDTO [] numeroFrecuenteTipDTOArr, NumeroFrecuenteDTO numeroFrecuente)
	{
		try
		{
			for(int i=0;i<numeroFrecuenteTipDTOArr.length;i++)
			{
				NumeroFrecuenteDTO numeroFrecuenteDTO = numeroFrecuenteTipDTOArr[i];
				if(numeroFrecuenteDTO.getNumero() == numeroFrecuente.getNumero())
				{
					return true;
				}
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return false;
	}

	public NumeroFrecuenteDTO [] getNumeroFrecuenteTipDTOArr(ArrayList numerosFrecuentesTipoListDTO, String tipo)
	{
		String tipoEval = ""; 
		NumeroFrecuenteDTO [] numeroFrecuenteTipDTOArr = null;
		NumeroFrecuenteTipoListDTO numFrecTipoListDTO = null;
		try
		{
			for(int i=0;i<numerosFrecuentesTipoListDTO.size();i++)
			{
				numFrecTipoListDTO = (NumeroFrecuenteTipoListDTO)numerosFrecuentesTipoListDTO.get(i);
				tipoEval = numFrecTipoListDTO.getTipo();//NumeroFrecuenteDTO numFrec = numeroFrecuenteTipDTOArr[0];
				if(tipoEval.equals(tipo))
				{
					logger.debug("tipo ------------------>"+tipo+"     tipoEval ------------------> "+tipoEval);
					break;
				}
			}
			numeroFrecuenteTipDTOArr = numFrecTipoListDTO.getNumFrecuentesIngresadosList();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}

		//logger.debug("\tnumeroFrecuenteTipDTOArr.length "+numeroFrecuenteTipDTOArr.length);
		return numeroFrecuenteTipDTOArr;
	}
	
	//retorna arreglo de NumeroFrecuenteDTO
	public NumeroFrecuenteDTO [] agregaNumFrecPorTipo(NumeroFrecuenteDTO [] numeroFrecuenteTipDTOArr, NumeroFrecuenteDTO numeroFrecuente)
	{
		//log("agregaNumFrecPorTipo");
		//NumeroFrecuenteDTO [] numerosFrecuentes = null;
		NumeroFrecuenteDTO [] numerosFrecuentesTmp = null;
		try
		{
			int largoArrNumFrec =  numeroFrecuenteTipDTOArr.length;  
			numerosFrecuentesTmp = new NumeroFrecuenteDTO [largoArrNumFrec+1];
			//logger.debug("\t\tagregaNumFrecPorTipo largoArrNumFrec "+largoArrNumFrec);
			for(int i=0;i<largoArrNumFrec;i++)
			{
				numerosFrecuentesTmp[i] = numeroFrecuenteTipDTOArr[i];
			}
			//logger.debug("\t\t\tnumeroFrecuenteTipDTOArr.length "+numeroFrecuenteTipDTOArr.length);
			//logger.debug("\t\t\tNumero Agregado "+numeroFrecuente.getNumero() + " tipo "+numeroFrecuente.getTipo());
			numerosFrecuentesTmp[largoArrNumFrec] = numeroFrecuente;
			//numeroFrecuenteTipDTOArr = numerosFrecuentesTmp;
			//logger.debug("\t\t\tagregué numerosFrecuentesTmp.length "+numerosFrecuentesTmp.length);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		//numeroFrecuenteTipDTOArr = numerosFrecuentesTmp;
		return numerosFrecuentesTmp;
	}
	
	public void recorreNum(ArrayList numerosFrecuentesTipoListDTO, ArrayList numerosFrecuentesDTO)
	{//solo para ver como recorrer el arraylist con los arreglos de dtos
		NumeroFrecuenteDTO [] numeroFrecuenteTipDTOArr = null;
		NumeroFrecuenteTipoListDTO numFrecTipoListDTO = null;
		NumeroFrecuenteDTO numeroFrecuente = null;
		try
		{
			for(int i=0;i<numerosFrecuentesTipoListDTO.size();i++)
			{
				numFrecTipoListDTO = (NumeroFrecuenteTipoListDTO)numerosFrecuentesTipoListDTO.get(i);
				numeroFrecuenteTipDTOArr = numFrecTipoListDTO.getNumFrecuentesIngresadosList();
				for(int j=0;j<numeroFrecuenteTipDTOArr.length;j++)
				{
					numeroFrecuente = numeroFrecuenteTipDTOArr [j];
					logger.debug(numeroFrecuente);
				}
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	
	public int getIndexNumeroFrecuenteTipDTOArr(ArrayList numerosFrecuentesTipoListDTO, String tipo)
	{
		NumeroFrecuenteTipoListDTO numFrecTipoListDTO = null;
		int index = -1;
		try
		{
			for(int i=0;i<numerosFrecuentesTipoListDTO.size();i++)
			{
				numFrecTipoListDTO = (NumeroFrecuenteTipoListDTO)numerosFrecuentesTipoListDTO.get(i);
				if((numFrecTipoListDTO.getTipo()).equals(tipo))
				{
					index = i;
					break;
				}
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return index;
	}
	
	public void agregaNuevoArrNumFrecPorTipo(ArrayList numeroFrecuenteDTOArrList,  NumeroFrecuenteDTO [] numerosFrecuentesDTO)
	{
		//numeroFrecuenteDTOArrList.add(numerosFrecuentesDTO);
		NumeroFrecuenteTipoListDTO numFrecTipoListDTO = new NumeroFrecuenteTipoListDTO();
		numFrecTipoListDTO.setCantidadMaxTipo(5);
		numFrecTipoListDTO.setNumFrecuentesIngresadosList(numerosFrecuentesDTO);
		numeroFrecuenteDTOArrList.add(numFrecTipoListDTO);
	}
	/********************************************************************************************************************************************/	


	public static void imprimeNumNuevos(ArrayList numerosFrecuentesDTO)
	{
		logger.debug("imprimeNumNuevos IdProd ");
		NumeroFrecuenteDTO numeroFrec = null;
		try
		{
			for(int i=0;i<numerosFrecuentesDTO.size();i++)
			{
				numeroFrec= (NumeroFrecuenteDTO)numerosFrecuentesDTO.get(i);
				imprimeDTO(numeroFrec);
			}
		}
		catch(Exception e)
		{
			logger.debug("Exception al imprimir");
			e.printStackTrace();
		}
	}
	
	public static void imprimeDTO(NumeroFrecuenteDTO numeroFrecuenteDTO)
	{
		try
		{
			//logger.debug("numeroFrecuenteDTO IdProd "+numeroFrecuenteDTO.getIdProductoContratadoFrec());
			logger.debug("numeroFrecuenteDTO numero "+numeroFrecuenteDTO.getNumero()+" "+numeroFrecuenteDTO.getTipo());
			//logger.debug("numeroFrecuenteDTO tipo   "+numeroFrecuenteDTO.getTipo());
			logger.debug("----------------------------------------------------------------------------------------------");	
		}
		catch(Exception e)
		{
			logger.debug("Exception al imprimir");
			e.printStackTrace();
		}

	}
	
	public static void imprimeNumTip(ArrayList numeroFrecuenteTipoListDTO)
	{
		logger.debug("en session imprimeNumTip");
		NumeroFrecuenteDTO [] numeroFrecuenteTipDTOArr = null;
		NumeroFrecuenteTipoListDTO numFrecTipoListDTO = null;
		try
		{
			for(int i=0;i<numeroFrecuenteTipoListDTO.size();i++)
			{
				numFrecTipoListDTO = (NumeroFrecuenteTipoListDTO)numeroFrecuenteTipoListDTO.get(i);
				numeroFrecuenteTipDTOArr = numFrecTipoListDTO.getNumFrecuentesIngresadosList();
				for(int j=0;j<numeroFrecuenteTipDTOArr.length;j++)
				{
					NumeroFrecuenteDTO numeroFrec = numeroFrecuenteTipDTOArr [j];
					imprimeDTO(numeroFrec);
				}
			}
		}
		catch(Exception e)
		{
			logger.debug("Exception al imprimir");
			e.printStackTrace();
		}
	}
	
	public ArrayList getNumerosFrecuentesDeOtrosProductos(ProductoContratadoFrecDTO [] productoContratadoFrecSess, long productoContratadoFrec)//, String[] arrTipos)
	{
		String numFrecOtrosProd = "";
		ArrayList retorno = new ArrayList();
		ArrayList numProdArrList = null;
		NumeroFrecuenteDTO numeroFrecDTO = null;
		NumeroFrecuenteDTO[] numeroFrecArrDTO = null;
		NumeroFrecuenteTipoListDTO numFrecTipoListDTO = null;
		for(int i=0;i<productoContratadoFrecSess.length;i++)
		{
			ProductoContratadoFrecDTO productoContratadoFrecDTO = productoContratadoFrecSess[i];

			//envio los numeros de los otros productos
			if(productoContratadoFrecDTO.getCorrelativo() != productoContratadoFrec)
			{
				//debo buscar en los arraylist de arrdto porque aca están los nuevos números
				if(productoContratadoFrecDTO.getNumerosFrecuentesTipoListDTO() != null)
				{
					numProdArrList = productoContratadoFrecDTO.getNumerosFrecuentesTipoListDTO();
					for(int j=0;j < numProdArrList.size();j++)
					{
						numFrecTipoListDTO = (NumeroFrecuenteTipoListDTO)numProdArrList.get(j);
						numeroFrecArrDTO = numFrecTipoListDTO.getNumFrecuentesIngresadosList();
						for(int k=0;k<numeroFrecArrDTO.length;k++)
						{
							numeroFrecDTO = numeroFrecArrDTO[k];
							retorno.add(""+numeroFrecDTO.getNumero());
							numFrecOtrosProd+=numeroFrecDTO.getNumero()+"|";
						}
					}
				}
				else
				{
					logger.debug("NFUtil getNumerosFrecuentesDeOtrosProductos productoContratadoFrecDTO.getNumerosFrecuentesTipoListDTO() != null ");
				}
			}
			numFrecOtrosProd+="\n";
		}
		logger.debug("CORRELATIVO productoContratadoFrec "+productoContratadoFrec);
		logger.debug("getNumerosFrecuentesDeOtrosProductos numFrecOtrosProd ---------------------------------------------------------------\n\n"+numFrecOtrosProd);
		return retorno;
	}


	public static HashMap getHmTipos() {
		hmTipos.put("INT", "INTERNACIONAL");
		hmTipos.put("OFN", "OFF-NET");
		hmTipos.put("ONN", "ON-NET");
		hmTipos.put("RDF", "RED-FIJA");
		return hmTipos;
	}
}
