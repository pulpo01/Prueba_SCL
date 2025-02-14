package com.tmmas.scl.operations.crm.f.s.manpro.web.helper;

import java.util.ArrayList;
import java.util.StringTokenizer;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroListDTO;
import com.tmmas.scl.operations.crm.f.s.manpro.frmk.dataTransferObject.NumeroFrecuenteDTO;
import com.tmmas.scl.operations.crm.f.s.manpro.frmk.dataTransferObject.NumeroFrecuenteTipoListDTO;
import com.tmmas.scl.operations.crm.f.s.manpro.frmk.dataTransferObject.ProductoContratadoFrecDTO;
import com.tmmas.scl.operations.crm.f.s.manpro.frmk.exception.ManProException;

public class ProductosContradosFrecUtil {
	
	static String  CLASS_NAME = "ProductosContradosUtil";
	private final static Logger logger = Logger.getLogger(ProductosContradosFrecUtil.class);

	public ProductoContratadoFrecDTO[] generaProductoContratadoList(ArrayList listaProducNumFreq,ArrayList listaProducNoNumFreq,long codCliente,long  numAbonado) throws Exception {
		
		String METHOD_NAME = "generaProductoContratadoList";
		logger.debug(CLASS_NAME+" "+METHOD_NAME+"||||||||||||ini||||||||||||||||||||||||||||||>");
		try
		{
			int numProd = listaProducNumFreq.size();
			ProductoContratadoFrecDTO [] listaProdNumFrecuentes = new ProductoContratadoFrecDTO [numProd];
			
			for(int i=0;i<numProd;i++)
			{
				listaProdNumFrecuentes[i] = generaProductoContratadoFrec((ProductoWeb) listaProducNumFreq.get(i),i,codCliente,numAbonado);
			}
			this.imprimePCF(listaProdNumFrecuentes);

			return listaProdNumFrecuentes;
		}
		catch (Exception e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug(CLASS_NAME+" "+METHOD_NAME+"[" + loge + "]");
			throw e;
		}
	}

	private ProductoContratadoFrecDTO generaProductoContratadoFrec(ProductoWeb productoWeb,int correlativoProd,long codCliente,long  numAbonado) throws Exception
	{	
		String METHOD_NAME = "generaProductoContratadoFrec";
		logger.debug(CLASS_NAME+" "+METHOD_NAME);
		try
		{
			//ProductoWeb
			String codigoPadre = productoWeb.getCodPadre();
			ProductoOfertadoDTO productoNumFreq = productoWeb.getProductoDTO();

			ProductoContratadoFrecDTO productoContradoFrec = new ProductoContratadoFrecDTO();
			productoContradoFrec.setCorrelativo(Long.parseLong(""+correlativoProd));
			productoContradoFrec.setIdProductoOfertado(productoNumFreq.getIdProductoOfertado());
			productoContradoFrec.setCodigo(productoNumFreq.getIdentificadorProductoOfertado());//codigo FREC001
			productoContradoFrec.setCodigoPadre(Long.parseLong(codigoPadre));
			productoContradoFrec.setDescripcion(productoNumFreq.getDesProdOfertado());
			//productoContradoFrec.setDescripcion(productoNumFreq.getEspecificacionProducto().getDescripcion());
			productoContradoFrec.setTipo(productoNumFreq.getEspecificacionProducto().getNombre());
			productoContradoFrec.setModoContratacion(productoNumFreq.getPeriodoContratacion());
			productoContradoFrec.setNumFrecuentesPermitidos(Long.parseLong(productoNumFreq.getEspecificacionProducto().getEspecServicioClienteList().getEspecSerLisList().getEspecServicioListaList()[0].getNumMaximoLista()));
			productoContradoFrec.setNumFrecuentesIngresados(0);
			productoContradoFrec.setNumerosFrecuentesTipoListDTO(generaNumeroFrecuenteList(productoNumFreq));		
			productoContradoFrec.setCodCliente(codCliente);
			productoContradoFrec.setNumAbonado(numAbonado);
			productoContradoFrec.setIndCondicionContr(productoNumFreq.getIndCondicionContratacion());
			return productoContradoFrec;
		}
		catch (Exception e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug(CLASS_NAME+" "+METHOD_NAME+"[" + loge + "]");
			throw e;
		}
	}

	private ArrayList generaNumeroFrecuenteList(ProductoOfertadoDTO productoNumFreq) throws Exception
	{	
		String METHOD_NAME = "generaNumeroFrecuenteList";
		logger.debug(CLASS_NAME+" "+METHOD_NAME);
		int numNumFrec = 0;//productoNumFreq.getListaNumeros();
		ArrayList retorno = null;
		try
		{
			NumeroFrecuenteDTO [] listaNumFrecuentes = new NumeroFrecuenteDTO [numNumFrec];
			for(int i=0;i<numNumFrec;i++)
			{//OFF-NET RED-FIJA ON-NET
				listaNumFrecuentes[i] = (generaNumeroFrecuente(Long.parseLong(productoNumFreq.getIdentificadorProductoOfertado()),
						generaNumero(),"Descrip"+i,generaTipo()));
			}
			//crear arraylist filtrado por tipo
			//retorno = getNumeroFrecuenteFiltradoArr(listaNumFrecuentes);
			retorno = getNumeroFrecuenteFiltradoArr(productoNumFreq, listaNumFrecuentes);
			return retorno;
		}
		catch (Exception e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug(CLASS_NAME+" "+METHOD_NAME+"[" + loge + "]");
			throw e;
		}
	}

	private NumeroFrecuenteDTO generaNumeroFrecuente(long idProductoContratadoFrec, long numero,String descripcion,String tipo) throws Exception
	{
		String METHOD_NAME = "generaNumeroFrecuente";
		logger.debug(CLASS_NAME+" "+METHOD_NAME);
		try
		{
			NumeroFrecuenteDTO numeroFrecuente = new NumeroFrecuenteDTO();
			numeroFrecuente.setIdProductoContratadoFrec(idProductoContratadoFrec);
			numeroFrecuente.setNumero(numero);
			numeroFrecuente.setDescripcion(descripcion);
			numeroFrecuente.setTipo(tipo);
			return numeroFrecuente;
		}
		catch (Exception e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug(CLASS_NAME+" "+METHOD_NAME+"[" + loge + "]");
			throw e;
		}
	}
	

	public static int getIndexProductoContratadoFrec(ProductoContratadoFrecDTO [] productosContratadosFrecSess, String identificadorProducto) throws Exception
	{
		ProductoContratadoFrecDTO productoContratadoFrecDTO = null;
		int index = -1;
		String codPadrePaq = "";
		String idProdOftado = "";
		String indCondicionContr= "";
		
		String codPadrePaqEval = "";
		String idProdOftadoEval = "";
		String indCondicionContrEval = "";

		String METHOD_NAME = "getIndexProductoContratadoFrec";
		//logger.debug(CLASS_NAME+" "+METHOD_NAME);
		try
		{
			log2("BUSCANDO IDPRODUCTOOFERTADO identificadorProducto "+identificadorProducto);
			StringTokenizer stCoNum = new StringTokenizer(identificadorProducto,".");//D.3885229.1
			indCondicionContrEval = stCoNum.nextToken();// no cambiar orden
			codPadrePaqEval  =  stCoNum.nextToken();
			idProdOftadoEval =  stCoNum.nextToken();
			for(int i=0;i<productosContratadosFrecSess.length;i++)
			{
				productoContratadoFrecDTO = productosContratadosFrecSess[i];
				codPadrePaq = ""+productoContratadoFrecDTO.getCodigoPadre();
				idProdOftado = ""+productoContratadoFrecDTO.getIdProductoOfertado();
				indCondicionContr = productoContratadoFrecDTO.getIndCondicionContr();
				
				//log2("COMPARANDO indCondicionContr "+indCondicionContr+" codPadrePaq "+codPadrePaq+" idProdOftado "+idProdOftado+" -----> "+indCondicionContr+"."+codPadrePaq+"."+idProdOftado);
				if(indCondicionContr.equals(indCondicionContrEval) &&  codPadrePaq.equals(codPadrePaqEval) && idProdOftado.equals(idProdOftadoEval) )
				{
					log2("ENCONTRE IDPRODUCTOOFERTADO "+idProdOftado+" codPadrePaq "+codPadrePaq);
					index = i;
					break;
				}
			}
			return index;
		}
		catch (Exception e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug(CLASS_NAME+" "+METHOD_NAME+"[" + loge + "]");
			throw e;
		}
	}

	public static ArrayList getNumeroFrecuenteFiltradoArr(ProductoOfertadoDTO productoNumFreq,NumeroFrecuenteDTO [] listaNumFrecuentes) throws Exception
	{
		NumeroFrecuenteUtil numFrecUtil = new NumeroFrecuenteUtil();
		return numFrecUtil.filtrarNumeroFrecPorTipoArr(productoNumFreq,listaNumFrecuentes);
	}

	public static ArrayList getNumerosFrecuentesDeOtrosProductos(ProductoContratadoFrecDTO [] productosContratadosFrecSess, String identificadorProducto,int indiceProdConFrec) throws Exception
	{
		NumeroFrecuenteUtil numFrecUtil = new NumeroFrecuenteUtil();
		return numFrecUtil.getNumerosFrecuentesDeOtrosProductos(productosContratadosFrecSess, identificadorProducto,indiceProdConFrec);
	}

	public static ArrayList getTiposNumPermitidosProducto(ArrayList numeroFrecuenteDTOArrList)
	{
		NumeroFrecuenteUtil numFrecUtil = new NumeroFrecuenteUtil();
		return numFrecUtil.getTiposNumPermitidosProducto(numeroFrecuenteDTOArrList);
	}
	
	public static void actualizaNumeros(ArrayList numerosFrecuentesTipoListDTO, ArrayList listaNumeros)
	{
		NumeroFrecuenteUtil numFrecUtil = new NumeroFrecuenteUtil();
		numFrecUtil.actualizaNumeros(numerosFrecuentesTipoListDTO, listaNumeros);
	}

	public void imprimePCF(ProductoContratadoFrecDTO [] pcfarr)
	{
		String METHOD_NAME = "imprimePCF";
		try
		{
			for(int i=0;i<pcfarr.length;i++)//pcfarr.length
			{
				ProductoContratadoFrecDTO pcf = pcfarr[i];				
				
				ArrayList nfarr = pcf.getNumerosFrecuentesTipoListDTO();
				//NumeroFrecuenteDTO [] nfarr = pcf.getNumFrecuentesIngresadosList();
				for(int j=0;j<nfarr.size();j++)
				{	
					NumeroFrecuenteTipoListDTO nfarrtipo = (NumeroFrecuenteTipoListDTO)nfarr.get(j);
					NumeroFrecuenteDTO [] arrtiponf = nfarrtipo.getNumFrecuentesIngresadosList();
					log2("\t"+nfarrtipo.getTipo() +" ---------------numMAX "+nfarrtipo.getCantidadMaxTipo());
					for(int k=0;k<arrtiponf.length;k++)
					{	
						NumeroFrecuenteDTO nf= arrtiponf[k];
					}
				}
			}
		}
		catch(Exception e)
		{
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug(CLASS_NAME+" "+METHOD_NAME+"[" + loge + "]");
		}

	}
	
	public static void log2(Object o)
	{

	}
	public static void imprimeProdOfer(ProductoOfertadoDTO prodOfer, String idPadre)
	{
		String tab = "\t";
		String maxLista = null;
		String indAutAfin = null;
		if(idPadre == null){tab = "";}
		log2(tab+"idPadre "+idPadre);
		log2(tab+"IdentificadorProduOfer "+prodOfer.getIdentificadorProductoOfertado());
		log2(tab+"IdProductoOfertado     "+prodOfer.getIdProductoOfertado());
		log2(tab+"CantidadContratado     "+prodOfer.getCantidadContratado());
		log2(tab+"CantidadDesplegado     "+prodOfer.getCantidadDesplegado());
		try
		{
			log2(tab+"TipoComportamiento     "+prodOfer.getEspecificacionProducto().getTipoComportamiento());
		}
		catch(Exception e)
		{
			log2(tab+"TipoComportamiento     "+e.getMessage());
		}
		//log2(tab+"CodCategoria           "+prodOfer.getCodCategoria());
		log2(tab+"CodCategoriaPlanBasico "+prodOfer.getCodCategoriaPlanBasico());
		log2(tab+"CodEspecProd           "+prodOfer.getCodEspecProd());
		log2(tab+"DesProdOfertado        "+prodOfer.getDesProdOfertado());
		log2(tab+"IndCondicionContratacion "+prodOfer.getIndCondicionContratacion());
		//log2(tab+"MaxContrataciones      "+prodOfer.getMaxContrataciones());
		log2(tab+"FecInicioVigencia      "+prodOfer.getFecInicioVigencia());
		log2(tab+"FecTerminoVigencia     "+prodOfer.getFecTerminoVigencia());
		try
		{ 
			maxLista =prodOfer.getEspecificacionProducto().getEspecServicioClienteList().getEspecSerLisList().getEspecServicioListaList()[0].getNumMaximoLista();
			indAutAfin =prodOfer.getEspecificacionProducto().getEspecServicioClienteList().getEspecSerLisList().getEspecServicioListaList()[0].getIndAutoAfinidad();
		}catch(Exception e){//e.printStackTrace();
		}
		log2(tab+"maxLista               "+maxLista);
		log2(tab+"indAutAfin             "+indAutAfin);
		log2("--------------------------------------------------------------------");
		
	}

	public NumeroListDTO obtieneListaNumeros(ProductoContratadoFrecDTO frecDTO)
	{
		//HashMap hmTipos = new HashMap();
		//hmTipos.put("INTERNACIONAL","INT");hmTipos.put("OFF-NET","OFN");hmTipos.put("ON-NET","ONN");hmTipos.put("RED-FIJA","RDF");

		String METHOD_NAME = "obtieneListaNumeros";
		logger.debug(CLASS_NAME+" "+METHOD_NAME);
		NumeroListDTO retorno = new NumeroListDTO();
		try
		{
			ArrayList numerosFrecuentesTipoListDTO = new ArrayList();
			ArrayList numeroDTOArrList = new ArrayList();
			numerosFrecuentesTipoListDTO = frecDTO.getNumerosFrecuentesTipoListDTO();
			
			NumeroFrecuenteDTO[] numeroFrecuenteDTOarr = null;
			NumeroDTO[] arrayNumerosDTO = null;
			
			NumeroFrecuenteDTO numeroFrecuenteDTO = null;
			NumeroDTO numeroDTO = null;
			for(int i=0;i<numerosFrecuentesTipoListDTO.size();i++)
			{
				NumeroFrecuenteTipoListDTO aux=(NumeroFrecuenteTipoListDTO)numerosFrecuentesTipoListDTO.get(i);
				numeroFrecuenteDTOarr = aux.getNumFrecuentesIngresadosList();
				
				for(int j=0;j<numeroFrecuenteDTOarr.length;j++)
				{//aca traspasar los datos del dto numer
					numeroFrecuenteDTO = numeroFrecuenteDTOarr[j];
					numeroDTO = new NumeroDTO();
					numeroDTO.setNro(""+numeroFrecuenteDTO.getNumero());
					numeroDTO.setIdProductoContratado(""+numeroFrecuenteDTO.getIdProductoContratadoFrec());
					numeroDTO.setIdCliente(String.valueOf(frecDTO.getCodCliente()));
					numeroDTO.setIdAbonado(String.valueOf(frecDTO.getNumAbonado()));
					numeroDTO.setCodCategoriaDest(numeroFrecuenteDTO.getCodTipo());//(String)hmTipos.get(numeroFrecuenteDTO.getTipo()));//ONN
					numeroDTO.setDesCategoria(numeroFrecuenteDTO.getTipo());			
					//numeroDTO.setIdPerfilLista("");//ProductoContratadoDTO codPerfilLista; 
					//numeroDTO.setNumProceso(""); ProductoContratadoDTO numProceso;
					//numeroDTO.setOrigenProceso("");ProductoContratadoDTO origenProceso;
					//numeroDTO.setFecProceso(new Date());ProductoContratadoDTO fechaProceso;

					numeroDTOArrList.add(numeroDTO);
				}
			}
			arrayNumerosDTO = (NumeroDTO[])ArrayUtl.copiaArregloTipoEspecifico(numeroDTOArrList.toArray(), NumeroDTO.class); 
			retorno.setNumerosDTO(arrayNumerosDTO);
			
		}
		catch (Exception e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug(CLASS_NAME+" "+METHOD_NAME+"[" + loge + "]");
		}
		return retorno;
	}
	
	/**
	 * @throws Exception ****************************************************************************************************************************************/
	public ProductoContratadoFrecDTO [] generaProductoContratadoList() throws Exception//ref loginaction
	{	
		String METHOD_NAME = "generaProductoContratadoList";
		logger.debug(CLASS_NAME+" "+METHOD_NAME+"||||||||||||ini||||||||||||||||||||||||||||||>");
		int numProd = 6;
		ProductoContratadoFrecDTO [] listaNumFrecuentes = new ProductoContratadoFrecDTO [numProd];
		for(int i=0;i<numProd;i++)
		{
			listaNumFrecuentes[i] = (generaProductoContratadoFrec(i,"PAD-0"+i,"Plan Adicional "+i,"Frecuente","Opcional",9,i));
		}
		this.imprimePCF(listaNumFrecuentes);
		return listaNumFrecuentes;
	}
	
	//aca se debe usar dtos
	private ProductoContratadoFrecDTO generaProductoContratadoFrec(long correlativo, String codigo, String descripcion, String tipo, 
			                        String modoContratacion, long numFrecuentesPermitidos,long numFrecuentesIngresados) throws Exception
	{	
		String METHOD_NAME = "ProductoContratadoFrecDTO";
		ProductoContratadoFrecDTO productoContradoFrec = new ProductoContratadoFrecDTO();
		try
		{
			productoContradoFrec.setCorrelativo(correlativo);
			productoContradoFrec.setCodigo(codigo);
			productoContradoFrec.setDescripcion(descripcion);
			productoContradoFrec.setTipo(tipo);
			productoContradoFrec.setModoContratacion(modoContratacion);
			productoContradoFrec.setNumFrecuentesPermitidos(numFrecuentesPermitidos);
			productoContradoFrec.setNumFrecuentesIngresados(numFrecuentesIngresados);
			productoContradoFrec.setNumerosFrecuentesTipoListDTO(generaNumeroFrecuenteList(correlativo));
			//productoContradoFrec.setNumFrecuentesIngresadosList(generaNumeroFrecuenteList(correlativo));
			
		}
		catch(Exception e)
		{
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug(CLASS_NAME+" "+METHOD_NAME+"[" + loge + "]");
		}
		return productoContradoFrec;
	}
	
	private ArrayList generaNumeroFrecuenteList(long correlativo) throws Exception
	{	
		int numNumFrec = 8;
		ArrayList retorno = null;
		NumeroFrecuenteDTO [] listaNumFrecuentes = new NumeroFrecuenteDTO [numNumFrec];
		for(int i=0;i<numNumFrec;i++)
		{//OFF-NET RED-FIJA ON-NET
			listaNumFrecuentes[i] = (generaNumeroFrecuente(correlativo,generaNumero(),"Descrip"+i,generaTipo()));
		}
		//crear arraylist filtrado por tipo
		retorno = getNumeroFrecuenteFiltradoArr(listaNumFrecuentes);
		return retorno;
	}
	
	public static ArrayList getNumeroFrecuenteFiltradoArr(NumeroFrecuenteDTO [] listaNumFrecuentes) throws Exception
	{
		NumeroFrecuenteUtil numFrecUtil = new NumeroFrecuenteUtil();
		return numFrecUtil.filtrarNumeroFrecPorTipoArr(listaNumFrecuentes);
	}
	
	private String generaTipo()
	{
		return NumeroFrecuenteUtil.generaTipo();
	}
	
	private long generaNumero()
	{
		Double d = new Double(Math.random()*10000000);
		return d.longValue();
	}
}
