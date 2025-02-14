package com.tmmas.scl.operations.crm.f.s.manpro.web.helper;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.ReglasListaNumerosDTO;
import com.tmmas.scl.operations.crm.f.s.manpro.frmk.dataTransferObject.NumeroFrecuenteDTO;
import com.tmmas.scl.operations.crm.f.s.manpro.frmk.dataTransferObject.NumeroFrecuenteTipoListDTO;
import com.tmmas.scl.operations.crm.f.s.manpro.frmk.dataTransferObject.ProductoContratadoFrecDTO;

public class NumeroFrecuenteUtil {
	
	static String   CLASS_NAME = "NumeroFrecuenteUtil";
	//private static ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();
	private final static Logger logger = Logger.getLogger(NumeroFrecuenteUtil.class);
	static String onnet   ="ON-NET";
	static String redfija ="RED-FIJA";
	static String offnet  ="OFF-NET";
	static String redInalam ="RED-INALAMBRICA";
	static String satelital ="SATELITAL";
	static String inter ="INTERNACIONAL";
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
	

	public ArrayList filtrarNumeroFrecPorTipoArr(ProductoOfertadoDTO productoNumFreq,NumeroFrecuenteDTO [] listaNumFrecuentes) throws Exception//, String[] arrTipos)
	{
		ArrayList retorno = null;//new NumeroFrecuenteDTO [][]();
		retorno = new ArrayList();
		String METHOD_NAME = "filtrarNumeroFrecPorTipoArr";
		//logger.debug(CLASS_NAME+" "+METHOD_NAME);
		try
		{
			HashMap hmTipos = new HashMap();
			hmTipos.put("INT", "INTERNACIONAL");
			hmTipos.put("OFN", "OFF-NET");
			hmTipos.put("ONN", "ON-NET");
			hmTipos.put("RDF", "RED-FIJA");
			
			int cantCatg = productoNumFreq.getListaReglasNumeros().getReglaLisNumList().length;
			for(int cap=0;cap<cantCatg;cap++){
				ReglasListaNumerosDTO cate = productoNumFreq.getListaReglasNumeros().getReglaLisNumList()[cap];
				//productoNumFreq.getListaReglasNumeros().get
				NumeroFrecuenteTipoListDTO numeroFrecuenteTipoListDTO = new NumeroFrecuenteTipoListDTO();
				//log3("IdProdOfertado "+productoNumFreq.getIdProductoOfertado()+"   CantidadMaxTipo "+Integer.parseInt(cate.getCantidadMaxima())+"   Tipo "+hmTipos.get(cate.getCodCategoriaDestino())+"     i  "+cap);
				numeroFrecuenteTipoListDTO.setCantidadMaxTipo(Integer.parseInt(cate.getCantidadMaxima()));
				numeroFrecuenteTipoListDTO.setTipo((String)hmTipos.get(cate.getCodCategoriaDestino()));
				numeroFrecuenteTipoListDTO.setNumFrecuentesIngresadosList(listaNumFrecuentes);
				retorno.add(numeroFrecuenteTipoListDTO);
			}
			//log3("IdProductoOfertado "+productoNumFreq.getIdProductoOfertado()+" arrNumFrecPorTipot.size "+retorno.size());
			return retorno;
		}
		catch (Exception e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug(CLASS_NAME+" "+METHOD_NAME+"[" + loge + "]");
			throw e;
		}
	}


	public ArrayList filtrarNumeroFrecPorTipoArr(NumeroFrecuenteDTO [] numeroFrecuenteDTO) throws Exception//, String[] arrTipos)
	{
		//El largo del HM tiene el mismo largo que el arrTipos
		ArrayList retorno = null;//new NumeroFrecuenteDTO [][]();

		String METHOD_NAME = "filtrarNumeroFrecPorTipoArr";
		logger.debug(CLASS_NAME+" "+METHOD_NAME);
		try
		{
			HashMap hmFiltradoNumFrecPorTipo = filtrarNumeroFrecPorTipo(numeroFrecuenteDTO);
			logger.debug("filtrarNumeroFrecPorTipoArr "+numeroFrecuenteDTO.length);
			logger.debug("Numero de tipos hmFiltradoNumFrecPorTipo.size() "+hmFiltradoNumFrecPorTipo.size());
			hmFiltradoNumFrecPorTipo.size();
			retorno = new ArrayList();
			for(int i=0;i<arrTipos.length;i++)
			{
				String tipo = arrTipos[i];
				NumeroFrecuenteTipoListDTO numeroFrecuenteTipoListDTO = new NumeroFrecuenteTipoListDTO();
				numeroFrecuenteTipoListDTO.setCantidadMaxTipo(3);
				numeroFrecuenteTipoListDTO.setTipo(tipo);
				if(hmFiltradoNumFrecPorTipo.get(tipo) != null )
				{
					NumeroFrecuenteDTO [] numFrecuenteDTOarr = (NumeroFrecuenteDTO [])hmFiltradoNumFrecPorTipo.get(tipo);
					numeroFrecuenteTipoListDTO.setNumFrecuentesIngresadosList(numFrecuenteDTOarr);
				}
				else
				{
					numeroFrecuenteTipoListDTO.setNumFrecuentesIngresadosList(new NumeroFrecuenteDTO [0]);
					log2("No encontre numeros de tipo arrTipos["+i+"] "+arrTipos[i]+" --------------------------->");
				}
				retorno.add(numeroFrecuenteTipoListDTO);
			}

			log2("arrNumFrecPorTipot.size "+retorno.size()+" --------------------------->");
			return retorno;
		}
		catch (Exception e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug(CLASS_NAME+" "+METHOD_NAME+"[" + loge + "]");
			throw e;
		}		
	}
	
	/** El metodo filtrarNumeroFrecPorTipo(NumeroFrecuenteDTO [] numeroFrecuenteDTO) recibe un arreglo simple de numerosfrecuentes con
	 *  diferentes tipos (on-net, red-fija, etc) y los agrupa en NumeroFrecuenteDTO [] para tipos especificos agregando estos nuevos
	 *  arreglos a un HashMap en el que el key es un String que representa el tipo de numero.
	 * @throws Exception 
	 * 
	 * */
	public HashMap filtrarNumeroFrecPorTipo(NumeroFrecuenteDTO [] numeroFrecuenteDTO) throws Exception
	{
		String METHOD_NAME = "filtrarNumeroFrecPorTipo";
		logger.debug(CLASS_NAME+" "+METHOD_NAME);
		try
		{
			HashMap hmFiltradoNumFrecPorTipo = new HashMap();
			String tipoNumFrec = null;
			for(int i=0;i<numeroFrecuenteDTO.length;i++)
			{
				NumeroFrecuenteDTO numeroFrecuente = numeroFrecuenteDTO[i];
				tipoNumFrec = numeroFrecuente.getTipo();
				for(int j=0;j<arrTipos.length;j++)
				{
					if(tipoNumFrec == arrTipos[j])
					{
						//log2("i "+i+" tipoNumFrec == arrTipos["+j+"] "+tipoNumFrec +" "+arrTipos[j]);
					}
					if(tipoNumFrec.equalsIgnoreCase(arrTipos[j]))
					{
						//log2("tipoNumFrec.equalsIgnoreCase(arrTipos["+j+"]) "+tipoNumFrec +" "+arrTipos[j]);
						agregaNumFrecPorTipo(hmFiltradoNumFrecPorTipo, numeroFrecuente, tipoNumFrec);
					}
				}
			}
			return hmFiltradoNumFrecPorTipo;
		}
		catch (Exception e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug(CLASS_NAME+" "+METHOD_NAME+"[" + loge + "]");
			throw e;
		}	
	}
	
	//retorna arreglo de NumeroFrecuenteDTO
	public void agregaNumFrecPorTipo(HashMap hmFiltradoNumFrecPorTipo, NumeroFrecuenteDTO numeroFrecuente, String tipoNumFrec) throws Exception
	{
		String METHOD_NAME = "agregaNumFrecPorTipo";
		//logger.debug(CLASS_NAME+" "+METHOD_NAME);
		NumeroFrecuenteDTO [] numerosFrecuentes = null;
		NumeroFrecuenteDTO [] numerosFrecuentesTmp = null;
		try
		{
			if(hmFiltradoNumFrecPorTipo.get(tipoNumFrec) == null)
			{
				//log2("\tNo hay elementos en hm de tipoNumFrec "+tipoNumFrec);
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
		catch (Exception e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug(CLASS_NAME+" "+METHOD_NAME+"[" + loge + "]");
			throw e;
		}	
	}
	
	public ArrayList getNumerosFrecuentesDeOtrosProductos(ProductoContratadoFrecDTO [] productoContratadoFrecSess,  String identificadorProducto, int indiceProdConFrec) throws Exception//, String[] arrTipos)
	{
		String numFrecOtrosProd = "";
		ArrayList retorno = new ArrayList();
		ArrayList numProdArrList = null;
		NumeroFrecuenteDTO numeroFrecDTO = null;
		NumeroFrecuenteDTO[] numeroFrecArrDTO = null;
		NumeroFrecuenteTipoListDTO numFrecTipoListDTO = null;

		String METHOD_NAME = "getNumerosFrecuentesDeOtrosProductos";
		logger.debug(CLASS_NAME+" "+METHOD_NAME);
		try
		{
			logger.debug("NumeroFrecuenteUtil getNumerosFrecuentesDeOtrosProductos --------------ini-----------------------------------------------------");
			logger.debug("identificadorProducto "+identificadorProducto);
			logger.debug("indiceProdConFrec     "+indiceProdConFrec);
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
			
			logger.debug("NumeroFrecuenteUtil getNumerosFrecuentesDeOtrosProductos numFrecOtrosProd ---------------------------------------------------------------\n\n"+numFrecOtrosProd);
			return retorno;
		}
		catch (Exception e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug(CLASS_NAME+" "+METHOD_NAME+"[" + loge + "]");
			throw e;
		}
	}
	
	public ArrayList getTiposNumPermitidosProducto(ArrayList numeroFrecuenteTipoListDTO)
	{
		//log3("NumeroFrecuenteUtil getTiposNumPermitidosProducto");
		ArrayList retorno = new ArrayList();
		NumeroFrecuenteTipoListDTO numFrecTipoListDTO = null;
		String METHOD_NAME = "getTiposNumPermitidosProducto";
		try
		{
			for(int i=0;i<numeroFrecuenteTipoListDTO.size();i++)
			{
				numFrecTipoListDTO = (NumeroFrecuenteTipoListDTO)numeroFrecuenteTipoListDTO.get(i);
				//log3("NumeroFrecuenteUtil numFrecTipoListDTO.getTipo() "+numFrecTipoListDTO.getTipo());
				retorno.add(numFrecTipoListDTO.getTipo());
			}
		}
		catch(Exception e)
		{
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug(CLASS_NAME+" "+METHOD_NAME+"[" + loge + "]");
		}

		return retorno;
	}

	public void actualizaNumeros(ArrayList numerosFrecuentesTipoListDTO, ArrayList numerosFrecuentesDTO)
	{
		log2("actualizaNumeros-------------------------ini-----------------------------------------");
		//imprimeNumTip(numeroFrecuenteDTOArrList);
		//imprimeNumNuevos(numerosFrecuentesDTO);
		NumeroFrecuenteDTO [] numeroFrecuenteTipDTOArr = null;
		NumeroFrecuenteDTO [] numFrecArrDto = null;
		String METHOD_NAME = "actualizaNumeros";
		try
		{
			log2("Numeros nuevos y antiguos numerosFrecuentesDTO.size() "+numerosFrecuentesDTO.size());
			eliminaNumeros(numerosFrecuentesTipoListDTO, numerosFrecuentesDTO);
			
			for(int i=0;i<numerosFrecuentesDTO.size();i++)
			{
				//log2("INI---------------------------------------NUEVOS---------------------->  i "+i);
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
						log2("DESPUES DE AGREGAR index "+index);
						
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
							log2("-----------------------------------------> lant "+lant+" ldes "+ldes);	
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
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug(CLASS_NAME+" "+METHOD_NAME+"[" + loge + "]");
		}
		//log2("despues de agregar DTO numeroFrecuenteTipDTOArr.length "+numeroFrecuenteTipDTOArr.length);
		log2("actualizaNumeros-------------------------fin-----------------------------------------");
	}
	
	public void eliminaNumeros(ArrayList numerosFrecuentesTipoListDTO, ArrayList numerosFrecuentesDTO)
	{
		String METHOD_NAME = "eliminaNumeros";
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
					log2("BUSCANDO "+numeroFrecuente.getNumero()+" " +numeroFrecuente.getTipo()+"----------------------------->");
					if(existeNumeroArrSimple(numerosFrecuentesDTO,numeroFrecuente))
					{// o si existia lo voy agregando a retorno
						numFrecExistentes.add(numeroFrecuente);
						//eliminaNumero(numeroFrecuenteTipDTOArr, j);
					}
					else
					{
						log2("NO ENCONTRE "+numeroFrecuente.getNumero()+" "+numeroFrecuente.getTipo());
						log2("eliminaNumeros    -----------> "+numeroFrecuente.getNumero()); 
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
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug(CLASS_NAME+" "+METHOD_NAME+"[" + loge + "]");
		}
		log2("eliminaNumeros fin -------------------------------------------------------------------------------->");
	}
	
	public NumeroFrecuenteDTO[] obtenerArrSimpleObj(ArrayList numFrecExistentes)
	{
		String METHOD_NAME = "obtenerArrSimpleObj";
		Object[] numFrecObjs = numFrecExistentes.toArray();//copia tipo especificico framework
		int largoNumFrec = numFrecObjs.length;
		NumeroFrecuenteDTO [] numerosFrecuentes = new NumeroFrecuenteDTO [largoNumFrec];
		try
		{
			
			for(int i=0;i<largoNumFrec;i++)
			{
				numerosFrecuentes[i] = (NumeroFrecuenteDTO)numFrecObjs[i];
			}
		}
		catch(Exception e)
		{
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug(CLASS_NAME+" "+METHOD_NAME+"[" + loge + "]");
		}
		return numerosFrecuentes;
	}
	
	public NumeroFrecuenteDTO[] obtenerArrSimple(ArrayList numFrecExistentes)
	{
		String METHOD_NAME = "obtenerArrSimple";
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
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug(CLASS_NAME+" "+METHOD_NAME+"[" + loge + "]");
		}
		return numerosFrecuentes;
	}

	public boolean existeNumero(ArrayList numerosFrecuentesTipoListDTO, NumeroFrecuenteDTO numeroFrecuenteDTO)
	{
		String METHOD_NAME = "existeNumero";
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
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug(CLASS_NAME+" "+METHOD_NAME+"[" + loge + "]");
		}
		logger.debug("NO EXISTE EN LA LISTA numeroFrecuente.getNumero() "+numeroFrecuenteDTO.getNumero());
		return false;
	}
	
	//arreglo simple de dtos, sin orden por tipos
	public boolean existeNumeroArrSimple(ArrayList numerosFrecuentesDTO, NumeroFrecuenteDTO numeroFrecuenteDTO)
	{
		String METHOD_NAME = "existeNumeroArrSimple";
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
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug(CLASS_NAME+" "+METHOD_NAME+"[" + loge + "]");
		}
		log2("NO EXISTE EN LA LISTA simple numeroFrecuente.getNumero() "+numeroFrecuenteDTO.getNumero());
		return false;
	}

	public boolean existeNumero(NumeroFrecuenteDTO [] numeroFrecuenteTipDTOArr, NumeroFrecuenteDTO numeroFrecuente)
	{
		String METHOD_NAME = "existeNumero";
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
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug(CLASS_NAME+" "+METHOD_NAME+"[" + loge + "]");
		}
		return false;
	}

	public NumeroFrecuenteDTO [] getNumeroFrecuenteTipDTOArr(ArrayList numerosFrecuentesTipoListDTO, String tipo)
	{
		String METHOD_NAME = "getNumeroFrecuenteTipDTOArr";
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
					log2("tipo ------------------>"+tipo+"     tipoEval ------------------> "+tipoEval);
					break;
				}
			}
			numeroFrecuenteTipDTOArr = numFrecTipoListDTO.getNumFrecuentesIngresadosList();
		}
		catch(Exception e)
		{
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug(CLASS_NAME+" "+METHOD_NAME+"[" + loge + "]");
		}

		//log2("\tnumeroFrecuenteTipDTOArr.length "+numeroFrecuenteTipDTOArr.length);
		return numeroFrecuenteTipDTOArr;
	}
	
	//retorna arreglo de NumeroFrecuenteDTO
	public NumeroFrecuenteDTO [] agregaNumFrecPorTipo(NumeroFrecuenteDTO [] numeroFrecuenteTipDTOArr, NumeroFrecuenteDTO numeroFrecuente)
	{
		String METHOD_NAME = "agregaNumFrecPorTipo";
		NumeroFrecuenteDTO [] numerosFrecuentesTmp = null;
		try
		{
			int largoArrNumFrec =  numeroFrecuenteTipDTOArr.length;  
			numerosFrecuentesTmp = new NumeroFrecuenteDTO [largoArrNumFrec+1];
			//log2("\t\tagregaNumFrecPorTipo largoArrNumFrec "+largoArrNumFrec);
			for(int i=0;i<largoArrNumFrec;i++)
			{
				numerosFrecuentesTmp[i] = numeroFrecuenteTipDTOArr[i];
			}
			//log2("\t\t\tnumeroFrecuenteTipDTOArr.length "+numeroFrecuenteTipDTOArr.length);
			//log2("\t\t\tNumero Agregado "+numeroFrecuente.getNumero() + " tipo "+numeroFrecuente.getTipo());
			numerosFrecuentesTmp[largoArrNumFrec] = numeroFrecuente;
			//numeroFrecuenteTipDTOArr = numerosFrecuentesTmp;
			//log2("\t\t\tagregué numerosFrecuentesTmp.length "+numerosFrecuentesTmp.length);
		}
		catch(Exception e)
		{
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug(CLASS_NAME+" "+METHOD_NAME+"[" + loge + "]");
		}
		//numeroFrecuenteTipDTOArr = numerosFrecuentesTmp;
		return numerosFrecuentesTmp;
	}
	
	public void recorreNum(ArrayList numerosFrecuentesTipoListDTO, ArrayList numerosFrecuentesDTO)
	{//solo para ver como recorrer el arraylist con los arreglos de dtos
		String METHOD_NAME = "recorreNum";
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
					log2(numeroFrecuente);
				}
			}
		}
		catch(Exception e)
		{
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug(CLASS_NAME+" "+METHOD_NAME+"[" + loge + "]");
		}
	}
	
	public int getIndexNumeroFrecuenteTipDTOArr(ArrayList numerosFrecuentesTipoListDTO, String tipo)
	{
		String METHOD_NAME = "getIndexNumeroFrecuenteTipDTOArr";
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
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug(CLASS_NAME+" "+METHOD_NAME+"[" + loge + "]");
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

	public static void log2(Object o)
	{	
		//logger.debug(o);
	}
	
	public static void log3(Object o)
	{
		//logger.debug(o);
	}
	public static void imprimeNumNuevos(ArrayList numerosFrecuentesDTO)
	{
		String METHOD_NAME = "imprimeNumNuevos";
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
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug(CLASS_NAME+" "+METHOD_NAME+"[" + loge + "]");
		}
	}
	
	public static void imprimeDTO(NumeroFrecuenteDTO numeroFrecuenteDTO)
	{
		String METHOD_NAME = "imprimeDTO";
		try
		{
			//log2("numeroFrecuenteDTO IdProd "+numeroFrecuenteDTO.getIdProductoContratadoFrec());
			log2("numeroFrecuenteDTO numero "+numeroFrecuenteDTO.getNumero()+" "+numeroFrecuenteDTO.getTipo());
			//log2("numeroFrecuenteDTO tipo   "+numeroFrecuenteDTO.getTipo());
			log2("----------------------------------------------------------------------------------------------");	
		}
		catch(Exception e)
		{
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug(CLASS_NAME+" "+METHOD_NAME+"[" + loge + "]");
		}

	}
	
	public static void imprimeNumTip(ArrayList numeroFrecuenteTipoListDTO)
	{
		String METHOD_NAME = "imprimeNumTip";
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
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug(CLASS_NAME+" "+METHOD_NAME+"[" + loge + "]");
		}
	}

}
