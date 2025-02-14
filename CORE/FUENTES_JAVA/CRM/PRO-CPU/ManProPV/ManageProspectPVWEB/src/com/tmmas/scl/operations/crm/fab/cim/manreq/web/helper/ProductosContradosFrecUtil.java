package com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.CargoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroListDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.NumeroFrecuenteDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.NumeroFrecuenteTipoListDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ProdContratadoOfertadoDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ProductoContratadoFrecDTO;

public class ProductosContradosFrecUtil {
	
	static String  CLASS_NAME = "ProductosContradosUtil";
	private final static Logger logger = Logger.getLogger(ProductosContradosFrecUtil.class);

	public void traspasaNumerosAProductos(ArrayList productoOfertadoDTOarrList,ProductoContratadoFrecDTO [] productoContratadoFrecDTOarr)
	{
		int numProdFrec = productoContratadoFrecDTOarr.length;
		ProductoWeb productoWeb  = null;
		ArrayList prodOfertadoDTOarrList = new ArrayList();
		for(int i=0;i<numProdFrec;i++)
		{
			productoWeb = obtenerProdWeb(productoOfertadoDTOarrList,productoContratadoFrecDTOarr[i]);
			traspasaNumeros(productoWeb,productoContratadoFrecDTOarr[i]);
			prodOfertadoDTOarrList.add(productoWeb);
		}
		productoOfertadoDTOarrList = prodOfertadoDTOarrList;
		//buscar getIdProductoOfertado getCodigoPadre
	}

	private ProductoWeb obtenerProdWeb(ArrayList productoOfertadoDTOarrList, ProductoContratadoFrecDTO frecDTO) {
		ProductoWeb productoWeb = null;
		ProductoOfertadoDTO productoOfertadoDTO = null;
		for(int i=0;i<productoOfertadoDTOarrList.size();i++)
		{
			productoWeb = (ProductoWeb)productoOfertadoDTOarrList.get(i);
			if(productoWeb.getCodPadre().equals(""+frecDTO.getCodigoPadre()))
			{
				productoOfertadoDTO = productoWeb.getProductoDTO();
				if(productoOfertadoDTO.getIdProductoOfertado().equals(frecDTO.getIdProductoOfertado()))
				{//revisar si comparo con getIdProductoOfertado o getCodigo o getIdentificadorProductoOfertado, esta confuso
					break;
				}
			}
		}
		return productoWeb;
	}
	
	private void traspasaNumeros(ProductoWeb productoWeb, ProductoContratadoFrecDTO frecDTO) {
		
		ProductoOfertadoDTO productoOfertadoDTO = productoWeb.getProductoDTO();
		productoOfertadoDTO.setListaNumeros(obtieneListaNumeros(frecDTO,productoOfertadoDTO));
		productoWeb.setProductoDTO(productoOfertadoDTO);
	}
	
	public void traspasaNumerosAProductos(ProductoOfertadoDTO[] productoOfertadoDTOarr,ProductoContratadoFrecDTO [] productoContratadoFrecDTOarr)
	{
		int numProdFrec = productoContratadoFrecDTOarr.length;
		
		for(int i=0;i<numProdFrec;i++)
		{
			traspasaNumeros(productoOfertadoDTOarr[i],productoContratadoFrecDTOarr[i]);
		}
		//buscar getIdProductoOfertado getCodigoPadre
	}
	private void traspasaNumeros(ProductoOfertadoDTO ofertadoDTO, ProductoContratadoFrecDTO frecDTO) {
		
		//ofertadoDTO.get
		ofertadoDTO.setListaNumeros(obtieneListaNumeros(frecDTO,ofertadoDTO));
	}
	private NumeroListDTO obtieneListaNumeros(ProductoContratadoFrecDTO frecDTO, ProductoOfertadoDTO productoOfertadoDTO) {
		//HashMap hmTipos = new HashMap();
		//hmTipos.put("INTERNACIONAL","INT");hmTipos.put("OFF-NET","OFN");hmTipos.put("ON-NET","ONN");hmTipos.put("RED-FIJA","RDF");
		ArrayList numerosFrecuentesTipoListDTO = new ArrayList();
		ArrayList numeroDTOArrList = new ArrayList();
		numerosFrecuentesTipoListDTO = frecDTO.getNumerosFrecuentesTipoListDTO();
		NumeroListDTO retorno = null;
		
		NumeroFrecuenteDTO[] numeroFrecuenteDTOarr = null;
		NumeroDTO[] arrayNumerosDTO = null;
		
		NumeroFrecuenteDTO numeroFrecuenteDTO = null;
		NumeroDTO numeroDTO = null;
		for(int i=0;i<numerosFrecuentesTipoListDTO.size();i++)
		{
			numeroFrecuenteDTOarr = (NumeroFrecuenteDTO[])numerosFrecuentesTipoListDTO.get(i);
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
				//(+) EV 12/02/09
				//numeroDTO.setFecInicioVigencia(productoOfertadoDTO.getFecInicioVigencia());
				numeroDTO.setFecInicioVigencia(new Timestamp(productoOfertadoDTO.getFecInicioVigencia().getTime()));
				//(-)
				numeroDTO.setFecTerminoVigencia(productoOfertadoDTO.getFecTerminoVigencia());
				//numeroDTO.setIdPerfilLista("");//ProductoContratadoDTO codPerfilLista; 
				//numeroDTO.setNumProceso(""); ProductoContratadoDTO numProceso;
				//numeroDTO.setOrigenProceso("");ProductoContratadoDTO origenProceso;
				//numeroDTO.setFecProceso(new Date());ProductoContratadoDTO fechaProceso;

				numeroDTOArrList.add(numeroDTO);
			}
		}
		arrayNumerosDTO = (NumeroDTO[])ArrayUtl.copiaArregloTipoEspecifico(numeroDTOArrList.toArray(), NumeroDTO.class); 
		retorno.setNumerosDTO(arrayNumerosDTO);
		return retorno;
	}
	public ProductoContratadoFrecDTO[] generaProductoContratadoList(ProductoContratadoListDTO prodContratadoListDto,ArrayList listaProducNoNumFreq,long codCliente,long  numAbonado) throws Exception {
		
		String METHOD_NAME = "generaProductoContratadoList";
		logger.debug(CLASS_NAME+" "+METHOD_NAME+"||||||||||||ini||||||||||||||||||||||||||||||>");
		try
		{
			int numProd = prodContratadoListDto.getProductosContratadosDTO().length;
			ProductoContratadoDTO[] productosContratadosDTO = prodContratadoListDto.getProductosContratadosDTO();
			ProductoContratadoFrecDTO [] listaProdNumFrecuentes = new ProductoContratadoFrecDTO [numProd];
			
			for(int i=0;i<numProd;i++)
			{
				listaProdNumFrecuentes[i] = generaProductoContratadoFrec(productosContratadosDTO[i],i,codCliente,numAbonado);
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

	private ProductoContratadoFrecDTO generaProductoContratadoFrec(ProductoContratadoDTO contratadoDTO,int correlativoProd,long codCliente,long  numAbonado) throws Exception
	{	
		String METHOD_NAME = "generaProductoContratadoFrec";
		//logger.debug(CLASS_NAME+" "+METHOD_NAME);
		try
		{
			String codigoPadre = ""+contratadoDTO.getIdProdContraPadre();//.getCodPadre();
			ProductoOfertadoDTO productoNumFreq = contratadoDTO.getProdOfertado();
	
			ProductoContratadoFrecDTO productoContradoFrec = new ProductoContratadoFrecDTO();
			productoContradoFrec.setCorrelativo(Long.parseLong(""+correlativoProd));
			productoContradoFrec.setIdProductoOfertado(productoNumFreq.getIdProductoOfertado());
			productoContradoFrec.setIdProductoContratado(contratadoDTO.getIdProdContratado().toString());
			productoContradoFrec.setCodigo(productoNumFreq.getIdentificadorProductoOfertado());//codigo FREC001
			productoContradoFrec.setCodigoPadre(Long.parseLong(codigoPadre));
			productoContradoFrec.setDescripcion(productoNumFreq.getDesProdOfertado());
			//productoContradoFrec.setDescripcion(productoNumFreq.getEspecificacionProducto().getDescripcion());
			productoContradoFrec.setTipo(productoNumFreq.getEspecificacionProducto().getNombre());
			productoContradoFrec.setModoContratacion(productoNumFreq.getPeriodoContratacion());
			productoContradoFrec.setNumFrecuentesPermitidos(Long.parseLong(productoNumFreq.getEspecificacionProducto().getEspecServicioClienteList().getEspecSerLisList().getEspecServicioListaList()[0].getNumMaximoLista()));
			productoContradoFrec.setNumFrecuentesIngresados(0);
			productoContradoFrec.setNumerosFrecuentesTipoListDTO(generaNumeroFrecuenteList(contratadoDTO));		
			productoContradoFrec.setCodCliente(codCliente);
			productoContradoFrec.setNumAbonado(numAbonado);
			productoContradoFrec.setIndCondicionContr(contratadoDTO.getIndCondicionContratacion());
			//System.out.println("ProductoOfertadoDTO generaProductoContratadoFrec contratadoDTO.getIndCondicionContratacion()---->"+contratadoDTO.getIndCondicionContratacion());//productoNumFreq.getIndCondicionContratacion());
			return productoContradoFrec;
		}
		catch (Exception e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug(CLASS_NAME+" "+METHOD_NAME+"[" + loge + "]");
			throw e;
		}		
	}

	private ArrayList generaNumeroFrecuenteList(ProductoContratadoDTO contratadoDTO) throws Exception//	private ArrayList generaNumeroFrecuenteList(ProductoOfertadoDTO productoNumFreq)
	{	
		String METHOD_NAME = "generaNumeroFrecuenteList";
		//logger.debug(CLASS_NAME+" "+METHOD_NAME);
		try
		{
			NumeroListDTO listDTO = contratadoDTO.getListaNumero();
			NumeroDTO numeroDto = null;
			NumeroDTO[] numeroDtoArr = listDTO.getNumerosDTO();
			//System.out.println("ProductosContradosFrecUtil idProdContratado "+ contratadoDTO.getIdProdContratado()+" numeroDtoArr.length "+numeroDtoArr.length);
			int numNumFrec = numeroDtoArr.length;
			ArrayList retorno = null;
			NumeroFrecuenteDTO [] listaNumFrecuentes = new NumeroFrecuenteDTO [numNumFrec];
			String codTipo = null;
			String tipoDesc = null;
			for(int i=0;i<numNumFrec;i++)
			{//OFF-NET RED-FIJA ON-NET //listDTO.getIdentificadorProductoOfertado()) ´ó Long.parseLong(contratadoDTO.getProdOfertado().getIdentificadorProductoOfertado())
				codTipo = numeroDtoArr[i].getCodCategoriaDest();
				tipoDesc = (String)NumeroFrecuenteUtil.getHmTipos().get(codTipo);
				numeroDto = numeroDtoArr[i];
				listaNumFrecuentes[i] = generaNumeroFrecuente(contratadoDTO.getIdProdContratado().longValue(),		                
						                //Long.parseLong(numeroDto.getNro()), INC 171563
						                numeroDto.getNro(), 
						                contratadoDTO.getProdOfertado().getDesProdOfertado()+" "+i,codTipo
						                );//numeroDtoArr[i].getCodCategoriaDest()
				//System.out.println("ProductosContradosFrecUtil generaNumeroFrecuenteList numeroDtoArr["+i+"] des "+numeroDtoArr[i].getDesCategoria());
				logger.debug("ProdContFrecUtil numDtoAr["+i+"] cod "+numeroDto.getCodCategoriaDest()+" "+tipoDesc+" "+numeroDto.getNro()+" lisNumF "+listaNumFrecuentes.length);
			}
			retorno = getNumeroFrecuenteFiltradoArr(contratadoDTO.getProdOfertado(), listaNumFrecuentes);	
			return retorno;
		}
		catch (Exception e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug(CLASS_NAME+" "+METHOD_NAME+"[" + loge + "]");
			throw e;
		}
	}
	
	//private NumeroFrecuenteDTO generaNumeroFrecuente(long idProductoContratadoFrec, long numero,String descripcion,String codTipo) throws Exception //INC 171563
	private NumeroFrecuenteDTO generaNumeroFrecuente(long idProductoContratadoFrec, String numero,String descripcion,String codTipo) throws Exception
	{
		String METHOD_NAME = "generaNumeroFrecuente";
		logger.debug(CLASS_NAME+" "+METHOD_NAME);
		try
		{
			NumeroFrecuenteDTO numeroFrecuente = new NumeroFrecuenteDTO();
			String tipoDesc = (String)NumeroFrecuenteUtil.getHmTipos().get(codTipo);
			numeroFrecuente.setIdProductoContratadoFrec(idProductoContratadoFrec);
			numeroFrecuente.setNumero(numero);
			numeroFrecuente.setDescripcion(descripcion);
			numeroFrecuente.setTipo(tipoDesc);
			numeroFrecuente.setCodTipo(codTipo);
			return numeroFrecuente;
		}
		catch (Exception e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug(CLASS_NAME+" "+METHOD_NAME+"[" + loge + "]");
			throw e;
		}
	}

	public static ArrayList getNumeroFrecuenteFiltradoArrSiNum(ProductoOfertadoDTO productoNumFreq,NumeroFrecuenteDTO [] listaNumFrecuentes)
	{
		NumeroFrecuenteUtil numFrecUtil = new NumeroFrecuenteUtil();
		return numFrecUtil.filtrarNumeroFrecPorTipoArrSiNum(productoNumFreq,listaNumFrecuentes);
	}
	public static ArrayList getNumeroFrecuenteFiltradoArr(ProductoOfertadoDTO productoNumFreq, NumeroFrecuenteDTO [] listaNumFrecuentes)
	{
		NumeroFrecuenteUtil numFrecUtil = new NumeroFrecuenteUtil();
		return numFrecUtil.filtrarNumeroFrecPorTipoArr(productoNumFreq,listaNumFrecuentes);
	}
	public static int getIndexProductoContratadoFrec(ProductoContratadoFrecDTO [] productosContratadosFrecSess, String identificadorProducto) throws Exception
	{
		ProductoContratadoFrecDTO productoContratadoFrecDTO = null;
		int index = -1;
		String codPadrePaq = "";
		String idProdOftado = "";
		String idProdContrEval = "";
		//log2("BUSCANDO IDPRODUCTOOFERTADO identificadorProducto "+identificadorProducto);
		String METHOD_NAME = "getIndexProductoContratadoFrec";
		//logger.debug(CLASS_NAME+" "+METHOD_NAME);
		try
		{

				for(int i=0;i<productosContratadosFrecSess.length;i++)
				{
					productoContratadoFrecDTO = productosContratadosFrecSess[i];
					idProdContrEval = productoContratadoFrecDTO.getIdProductoContratado();
		
					if(idProdContrEval.equals(identificadorProducto))
					{
						//log2("ENCONTRE IDPRODUCTOOFERTADO "+idProdOftado+" codPadrePaq "+codPadrePaq);
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

	public static ArrayList getNumerosFrecuentesDeOtrosProductos(ProductoContratadoFrecDTO [] productosContratadosFrecSess, String identificadorProducto,int indiceProdConFrec)
	{
		NumeroFrecuenteUtil numFrecUtil = new NumeroFrecuenteUtil();
		return numFrecUtil.getNumerosFrecuentesDeOtrosProductos(productosContratadosFrecSess, identificadorProducto,indiceProdConFrec);
	}
	
	public static ArrayList getNumerosFrecuentesDeOtrosProductos(ProductoContratadoFrecDTO [] productoContratadoFrecSess, long productoContratadoFrec)
	{
		NumeroFrecuenteUtil numFrecUtil = new NumeroFrecuenteUtil();
		return numFrecUtil.getNumerosFrecuentesDeOtrosProductos(productoContratadoFrecSess, productoContratadoFrec);
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
	

	
	private String generaTipo()
	{
		return NumeroFrecuenteUtil.generaTipo();
	}
	
	private long generaNumero()
	{
		Double d = new Double(Math.random()*10000000);
		return d.longValue();
	}
	
	public void imprimePCF(ProductoContratadoFrecDTO [] pcfarr)
	{
		String METHOD_NAME = "imprimePCF";
		try
		{
			StringBuffer sb = new StringBuffer();
			StringBuffer sb2 = new StringBuffer();
			logger.debug("IMPRIME PRODUCTOS pcfarr.length ----------con números-------------------------------->"+pcfarr.length);
			logger.debug("corrtvo|idPofer|cod|codPadre|desc|tipo|modocon|indcondcon|numfrecperm");
			for(int i=0;i<pcfarr.length;i++)//pcfarr.length
			{// 21|2|FREC002|2855|Producto Ofertado 2|ESP-001|C|null|5
				ProductoContratadoFrecDTO pcf = pcfarr[i];
				sb = new StringBuffer();
				sb.append(pcf.getCorrelativo()+"|");//0|1|FREC001|38899999	
				sb.append(pcf.getIdProductoOfertado()+"|");
				sb.append(pcf.getCodigo()+"|");
				sb.append(pcf.getCodigoPadre()+"|");
				sb.append(pcf.getDescripcion()+"|");
				//sb.append(pcf.getIdProductoContratado()+"|");
				sb.append(pcf.getTipo()+"|");
				sb.append(pcf.getModoContratacion()+"|");
				sb.append(pcf.getIndCondicionContr()+"|");
				sb.append(pcf.getNumFrecuentesPermitidos());
				logger.debug(sb.toString());
				ArrayList nfarr = pcf.getNumerosFrecuentesTipoListDTO();
				//NumeroFrecuenteDTO [] nfarr = pcf.getNumFrecuentesIngresadosList();
				//log2(sb.toString());
				boolean imp = false;
				for(int j=0;j<nfarr.size();j++)
				{	
					NumeroFrecuenteTipoListDTO nfarrtipo = (NumeroFrecuenteTipoListDTO)nfarr.get(j);
					NumeroFrecuenteDTO [] arrtiponf = nfarrtipo.getNumFrecuentesIngresadosList();
					logger.debug("  "+nfarrtipo.getTipo() +" ---------------numMAX "+nfarrtipo.getCantidadMaxTipo());
					sb = new StringBuffer();
					for(int k=0;k<arrtiponf.length;k++)
					{	
						NumeroFrecuenteDTO nf= arrtiponf[k];
						//System.out.print(nf.getIdProductoContratadoFrec()+"|");
						imp = true;
						sb.append("    "+nf.getNumero()+"|");
						sb.append(nf.getDescripcion()+"|");
						sb.append(nf.getTipo()+"|");
						logger.debug(sb.toString());
					}
				}
				//if(imp){sb2.append(sb.toString());}
			}
			//logger.debug(sb2.toString());
		}
		catch(Exception e)
		{
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug(CLASS_NAME+" "+METHOD_NAME+"[" + loge + "]");
		}

	}
	
	public static void imprimeProdOfer(ProductoOfertadoDTO prodOfer, String idPadre)
	{
		String tab = "  ";
		String maxLista = null;
		String indAutAfin = null;
		String idEspecProv = null;
		try
		{
			if(idPadre == null){tab = "";}
			logger.debug("-------------IMPRIMIENDO PRODUCTO OFERTADO--------------------");
			logger.debug(tab+"idPadre "+idPadre);
			logger.debug(tab+"IdentificadorProduOfer ["+prodOfer.getIdentificadorProductoOfertado()+"]");
			logger.debug(tab+"IdProductoOfertado     ["+prodOfer.getIdProductoOfertado()+"]");
			logger.debug(tab+"CantidadContratado     ["+prodOfer.getCantidadContratado()+"]");
			logger.debug(tab+"CantidadDesplegado     ["+prodOfer.getCantidadDesplegado()+"]");
			try
			{
				logger.debug(tab+"TipoComportamiento     ["+prodOfer.getEspecificacionProducto().getTipoComportamiento()+"]");
			}
			catch(Exception e)
			{
				logger.debug(tab+"TipoComportamiento     ["+e.getMessage()+"]");
			}
			//logger.debug(tab+"CodCategoria           ["+prodOfer.getCodCategoria()+"]");
			logger.debug(tab+"CodCategoriaPlanBasico ["+prodOfer.getCodCategoriaPlanBasico()+"]");
			logger.debug(tab+"CodEspecProd           ["+prodOfer.getCodEspecProd()+"]");
			logger.debug(tab+"DesProdOfertado        ["+prodOfer.getDesProdOfertado()+"]");
			logger.debug(tab+"IndCondiciContratacion ["+prodOfer.getIndCondicionContratacion()+"]");
			logger.debug(tab+"MaxContrataciones      ["+prodOfer.getMaxContrataciones()+"]");
			logger.debug(tab+"FecInicioVigencia      ["+prodOfer.getFecInicioVigencia()+"]");
			logger.debug(tab+"FecTerminoVigencia     ["+prodOfer.getFecTerminoVigencia()+"]");
			logger.debug(tab+"tipoPlanAdic           ["+prodOfer.getTipoPlanAdic()+"]");
			try
			{ 
				logger.debug(tab+"IndTipoPlataforma      ["+prodOfer.getIndTipoPlataforma()+"]");
				logger.debug(tab+"TipoComportami(EspePr) ["+prodOfer.getEspecificacionProducto().getTipoComportamiento()+"]");	
				maxLista    =prodOfer.getEspecificacionProducto().getEspecServicioClienteList().getEspecSerLisList().getEspecServicioListaList()[0].getNumMaximoLista();
				indAutAfin  =prodOfer.getEspecificacionProducto().getEspecServicioClienteList().getEspecSerLisList().getEspecServicioListaList()[0].getIndAutoAfinidad();
			}
			catch(Exception e){//e.printStackTrace(+"]");
			}
			
			try
			{ 
				idEspecProv =prodOfer.getEspecificacionProducto().getEspecServicioClienteList().getEspServCliList()[0].getIdEspecProvision();
			}
			catch(Exception e){//e.printStackTrace(+"]");
			}
			logger.debug(tab+"maxLista               ["+maxLista+"]");
			logger.debug(tab+"indAutAfin             ["+indAutAfin+"]");
			logger.debug(tab+"idEspecProv            ["+idEspecProv+"]");
		}
		catch(Exception e)
		{
			System.out.println("Error imprimeProdOfer IMPRIMIENDO PRODUCTO OFERTADO"+"]");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug(CLASS_NAME+" imprimeProdOfer [" + loge + "]");
		}
		logger.debug("--------------------------------------------------------------------");
		
	}
	/******************************************************************************************************************************************/



	public ProductoContratadoFrecDTO[] generaProductoContratadoList(ProductoOfertadoDTO productoX) {
		// TODO Auto-generated method stub
		return null;
	}
	public ProductoContratadoFrecDTO[] generaProductoContratadoList(ProductoOfertadoListDTO productosOfertables) {
		// TODO Auto-generated method stub
		return null;
	}
	
	public NumeroListDTO obtieneListaNumeros(ProductoContratadoFrecDTO frecDTO) 
	{
		//HashMap hmTipos = new HashMap();
		//hmTipos.put("INTERNACIONAL","INT");hmTipos.put("OFF-NET","OFN");hmTipos.put("ON-NET","ONN");hmTipos.put("RED-FIJA","RDF");
		String METHOD_NAME = "obtieneListaNumeros";
		logger.debug(CLASS_NAME+" "+METHOD_NAME);
		ArrayList numerosFrecuentesTipoListDTO = new ArrayList();
		ArrayList numeroDTOArrList = new ArrayList();
		
		NumeroListDTO retorno = new NumeroListDTO();
		NumeroFrecuenteDTO[] numeroFrecuenteDTOarr = null;
		NumeroDTO[] arrayNumerosDTO = null;
		
		NumeroFrecuenteDTO numeroFrecuenteDTO = null;
		NumeroDTO numeroDTO = null;
		try
		{
			numerosFrecuentesTipoListDTO = frecDTO.getNumerosFrecuentesTipoListDTO();
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

	public static NumeroListDTO obtieneListaNumerosSimple(ProductoContratadoFrecDTO frecDTO) 
	{
		//HashMap hmTipos = new HashMap();
		//hmTipos.put("INTERNACIONAL","INT");hmTipos.put("OFF-NET","OFN");hmTipos.put("ON-NET","ONN");hmTipos.put("RED-FIJA","RDF");
		String METHOD_NAME = "obtieneListaNumerosSimple";
		//logger.debug(CLASS_NAME+" "+METHOD_NAME);
		ArrayList numerosFrecuentesTipoListDTO = new ArrayList();
		ArrayList numeroDTOArrList = new ArrayList();
		
		NumeroListDTO retorno = new NumeroListDTO();
		
		NumeroFrecuenteDTO[] numeroFrecuenteDTOarr = null;
		NumeroDTO[] arrayNumerosDTO = null;
		
		NumeroFrecuenteDTO numeroFrecuenteDTO = null;
		NumeroDTO numeroDTO = null;
		try
		{
			numerosFrecuentesTipoListDTO = frecDTO.getNumerosFrecuentesTipoListDTO();
			for(int i=0;i<numerosFrecuentesTipoListDTO.size();i++)
			{
				NumeroFrecuenteTipoListDTO aux=(NumeroFrecuenteTipoListDTO)numerosFrecuentesTipoListDTO.get(i);
				numeroFrecuenteDTOarr = aux.getNumFrecuentesIngresadosList();
				
				for(int j=0;j<numeroFrecuenteDTOarr.length;j++)
				{
					numeroFrecuenteDTO = numeroFrecuenteDTOarr[j];
					numeroDTO = new NumeroDTO();
					numeroDTO.setNro(""+numeroFrecuenteDTO.getNumero());
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
	
	public static void imprimeProdCont(ProductoContratadoDTO productoCX) 
	{
		try
		{
			logger.debug("*****************************IMPRIMIENDO PRODUCTO CONTRATADO*****************************");
			if(productoCX == null)
			{
				System.out.println("ProductoContratadoDTO productoCX NULO");
			}
			else
			{
				logger.debug("IdProdContratado          ["+productoCX.getIdProdContratado()+"]");
				logger.debug("IdClienteBeneficiario     ["+productoCX.getIdClienteBeneficiario()+"]");
				logger.debug("IdAbonadoBeneficiario     ["+productoCX.getIdAbonadoBeneficiario()+"]");
				logger.debug("FechaInicioVigencia       ["+productoCX.getFechaInicioVigencia()+"]");
				logger.debug("IdCanal                   ["+productoCX.getIdCanal()+"]");
				logger.debug("NumProceso                ["+productoCX.getNumProceso()+"]");
				logger.debug("OrigenProceso             ["+productoCX.getOrigenProceso()+"]");
				logger.debug("FechaProceso              ["+productoCX.getFechaProceso()+"]");
				logger.debug("IdEstado                  ["+productoCX.getIdEstado()+"]");
				logger.debug("IndCondicionContratacion  ["+productoCX.getIndCondicionContratacion()+"]");
				logger.debug("IdClienteContratante      ["+productoCX.getIdClienteContratante()+"]");
				logger.debug("NumAbonadoContratante     ["+productoCX.getNumAbonadoContratante()+"]");
				logger.debug("FechaTerminoVigencia      ["+productoCX.getFechaTerminoVigencia()+"]");
				Date date = productoCX.getFechaTerminoVigencia();
				Calendar calendar = Calendar.getInstance(); //obtiene la fecha de hoy 
				System.out.println("FecTerminoVigencia(   )   ["+calendar.getTime()+"]");
				calendar.add(Calendar.DATE, -1); //el -3 indica que se le restaran 3 dias 
				logger.debug("FecTerminoVigencia(-1dia)["+calendar.getTime()+"]");
				logger.debug("IndPrioridad              ["+productoCX.getIndPrioridad()+"]");
				logger.debug("IdProdContraPadre         ["+productoCX.getIdProdContraPadre()+"]");
				logger.debug("CodPerfilLista            ["+productoCX.getCodPerfilLista()+"]");
				logger.debug("TipoComportamiento        ["+productoCX.getTipoComportamiento()+"]");
				logger.debug("IndPaquete                ["+productoCX.getIndPaquete()+"]");
				//System.out.println("  ["+productoCX.getIdProductoOfertado()+"]");
				logger.debug("IdProductoOfertado        ["+productoCX.getIdProductoOfertado()+"]");
			}
		}
		catch (Exception e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug(CLASS_NAME+" imprimeProdCont [" + loge + "]");
		}
		
		
		//private ProductoOfertadoDTO prodOfertado());
		//private NumeroListDTO listaNumero());
		
	}
	
	public static NumeroListDTO obtieneProductosAgregados(ProductoContratadoFrecDTO [] productosContratadosFrecSess,
																List productosContratadosList, long numOrdenServicio) throws Exception
	{
		String METHOD_NAME = "obtieneProductosAgregados";
		logger.debug(CLASS_NAME+" "+METHOD_NAME);
		NumeroListDTO numeroListAdd = new NumeroListDTO();
		NumeroDTO[]   numeroArrAdd =  null;
		NumeroDTO     ndto = null;
		ArrayList     numeroArrListAdd =  new ArrayList();
		ProductoContratadoFrecDTO prodContratadoFrecDTO = null;
		ArrayList numsFrecTipoListDTO = null;
		NumeroFrecuenteTipoListDTO numFrecTipoListDTO = null;
		NumeroFrecuenteDTO[] numeroFrecDTOArr =  null;
		NumeroFrecuenteDTO   numeroFrecDTO=  null;
		String numeroSess = null;
		try
		{
			for(int i=0;i<productosContratadosFrecSess.length;i++)
			{
				prodContratadoFrecDTO = productosContratadosFrecSess[i];
				numsFrecTipoListDTO = prodContratadoFrecDTO.getNumerosFrecuentesTipoListDTO();
				if(numsFrecTipoListDTO != null)
				{
					for(int j=0;j<numsFrecTipoListDTO.size();j++)
					{
						numFrecTipoListDTO = (NumeroFrecuenteTipoListDTO) numsFrecTipoListDTO.get(j);
						numeroFrecDTOArr = numFrecTipoListDTO.getNumFrecuentesIngresadosList();
						for(int k=0;k<numeroFrecDTOArr.length;k++)
						{
							numeroFrecDTO = numeroFrecDTOArr[k];
							numeroSess = ""+numeroFrecDTO.getNumero();
							if(!estaEnListaOri(numeroFrecDTO,productosContratadosList))
							{
								ndto = new NumeroDTO();
								ndto.setNro(""+numeroFrecDTO.getNumero());
								ndto.setIdProductoContratado(""+numeroFrecDTO.getIdProductoContratadoFrec());
								ndto.setCodCategoriaDest(numeroFrecDTO.getCodTipo());
								ndto.setDesCategoria(numeroFrecDTO.getTipo());
								ndto.setNumProceso(""+numOrdenServicio);
								ndto.setOrigenProceso("PV");
								
								//(+) EV 13/02/09
								/*NumeroListDTO numeroListOri = null;
								NumeroDTO[]   numeroArr =  null;
								ProdContratadoOfertadoDTO producto = null;
								
								
								logger.debug("IdProductoContratadoFrec="+ndto.getIdProductoContratado());
								
								String IdProductoContratado = prodContratadoFrecDTO.getIdProductoContratado();
								logger.debug("IdProductoContratado="+IdProductoContratado);
								ndto.setIdProductoContratado(IdProductoContratado);
								
								for(int l=0;l<productosContratadosList.size();l++)
								{
									producto = (ProdContratadoOfertadoDTO) productosContratadosList.get(l);
									numeroListOri = producto.getListaNumeros();
									numeroArr = numeroListOri.getNumerosDTO();
									if(producto.getIdProdContratado().longValue()==Long.parseLong(IdProductoContratado));{
										for(int m=0;m<numeroArr.length;m++)
										{
											if(numeroSess.equals(numeroArr[m].getNro()))
											{
												ndto.setFecInicioVigencia(numeroArr[m].getFecInicioVigencia());
											}
										}
									}
								}*/
								//(-)								
								
								/*
								 * String numeroSess = ""+numeroFrecDTO.getNumero();
								 * 
				for(int i=0;i<productosContratadosList.size();i++)
			{
				producto = (ProdContratadoOfertadoDTO) productosContratadosList.get(i);
				numeroListOri = producto.getListaNumeros();
				numeroArr = numeroListOri.getNumerosDTO();
				
				for(int j=0;j<numeroArr.length;j++)
				{
					if(numeroSess.equals(numeroArr[j].getNro()) && (""+numeroFrecDTO.getIdProductoContratadoFrec()).equals(numeroArr[j].getIdProductoContratado()))
					{
						return true;
					}
				}
			}
								 * */
								numeroArrListAdd.add(ndto);
							}
						}
					}
				}
				else
				{
					logger.debug("numFrecTipDTOArrList == null i "+i);
				}
	
			}
			numeroArrAdd = (NumeroDTO[])ArrayUtl.copiaArregloTipoEspecifico(numeroArrListAdd.toArray(), NumeroDTO.class);
			numeroListAdd.setNumerosDTO(numeroArrAdd);
			imprimeMantencionProductos(numeroListAdd.getNumerosDTO(),"AGREGAR");
			
		}
		catch (Exception e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug(CLASS_NAME+" "+METHOD_NAME+"[" + loge + "]");
			throw e;
		}
		return numeroListAdd;
	}

	public static NumeroListDTO obtieneProductosEliminados(ProductoContratadoFrecDTO [] productosContratadosFrecSess,
															List productosContratadosList, long numOrdenServicio) throws Exception
	{
		String METHOD_NAME = "obtieneProductosEliminados";
		//logger.debug(CLASS_NAME+" "+METHOD_NAME);
		NumeroListDTO numeroListDel = new NumeroListDTO();
		NumeroListDTO numeroListOri = null;
		NumeroDTO[]   numeroArr =  null;
		NumeroDTO[]   numeroArrDel =  null;

		ArrayList     numeroArrListDel =  new ArrayList();
		ProdContratadoOfertadoDTO producto = null;
		try
		{
			for(int i=0;i<productosContratadosList.size();i++)
			{
				producto = (ProdContratadoOfertadoDTO) productosContratadosList.get(i);
				numeroListOri = producto.getListaNumeros();
				numeroArr = numeroListOri.getNumerosDTO();
				for(int j=0;j<numeroArr.length;j++)
				{
					if(!estaEnListaSess(numeroArr[j],productosContratadosFrecSess))
					{//para descontratar, se mantiene el resto de los datos, solo se setean estos 2:
						numeroArr[j].setOrigenProcDescontrata("PV");
						numeroArr[j].setNumProcesoDescontrata(""+numOrdenServicio);
						numeroArr[j].setFecTerminoVigencia(new Date());
						numeroArrListDel.add(numeroArr[j]);
					}
				}
			}
			numeroArrDel = (NumeroDTO[])ArrayUtl.copiaArregloTipoEspecifico(numeroArrListDel.toArray(), NumeroDTO.class);
			numeroListDel.setNumerosDTO(numeroArrDel);
			imprimeMantencionProductos(numeroListDel.getNumerosDTO(),"ELIMINAR");
		}
		catch (Exception e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug(CLASS_NAME+" "+METHOD_NAME+"[" + loge + "]");
			throw e;
		}
		return numeroListDel;
	}

	public static void imprimeMantencionProductos(NumeroDTO[] numeroArr, String accion)
	{
		logger.debug("IMPRIMIENDO NUMEROS A "+accion+" --------------------------------------------->"+numeroArr.length);
		for(int i=0;i<numeroArr.length;i++)
		{
			imprimeNumeroDto(numeroArr[i]);
		}
	}
	
	private static void imprimeNumeroDto(NumeroDTO ndto) {
		logger.debug("IDPRODCONTRA      "+ndto.getIdProductoContratado());
		logger.debug("NUMERO            "+ndto.getNro());
		//logger.debug("IDPERFILLISTA     "+ndto.getIdPerfilLista());
		//logger.debug("IDCLIENTE         "+ndto.getIdCliente());
		//logger.debug("ABONADO           "+ndto.getIdAbonado());
		logger.debug("CODCATEGORIA      "+ndto.getCodCategoriaDest());
		logger.debug("DESCATEGORIA      "+ndto.getDesCategoria());
		logger.debug("FECHAINICIOVIG    "+ndto.getFecInicioVigencia());
		logger.debug("FECHATERMIVIG     "+ndto.getFecTerminoVigencia());
		logger.debug("NUMEROPROCESO     "+ndto.getNumProceso());
		logger.debug("ORIGENPROCESO     "+ndto.getOrigenProceso());
		logger.debug("FECHAPROCESO      "+ndto.getFecProceso());
		logger.debug("ORIGENPROCDESC    "+ndto.getOrigenProcDescontrata());
		logger.debug("NUMEROPROCESODESC "+ndto.getNumProcesoDescontrata());
		//VALOR_ELEMENTO,  -- este es el número
		//COD_PROD_CONTRATADO,  
		//COD_CATEGORIA_DESTINO, -- ONN, OFN... etc
		//FEC_INICIO_VIGENCIA, -- debería setearse en sysdate
		//FEC_TERMINO_VIGENCIA, -- debería setearse en 31-12-3000
		
		//NUM_PROCESO,  -- Número de OS
		//ORIGEN_PROCESO, -- ‘PV’
		//FEC_PROCESO – debería setearse en sysdate
		logger.debug("--------------------------------------------------------------------------------------------");
	}

	private static boolean estaEnListaSess(NumeroDTO numeroDTO, ProductoContratadoFrecDTO[] productosContratadosFrecSess) throws Exception {
		String METHOD_NAME = "estaEnListaSess";
		ProdContratadoOfertadoDTO producto = null;
		ProductoContratadoFrecDTO prodContratadoFrecDTO = null;
		NumeroListDTO numeroListOri = null;
		ArrayList numsFrecTipoListDTO = null;
		NumeroFrecuenteTipoListDTO numFrecTipoListDTO = null;
		NumeroFrecuenteDTO[] numeroFrecDTOArr =  null;
		NumeroFrecuenteDTO   numeroFrecDTO=  null;
		String numeroSess = null;
		try
		{
			for(int i=0;i<productosContratadosFrecSess.length;i++)
			{
				prodContratadoFrecDTO = productosContratadosFrecSess[i];
				numsFrecTipoListDTO = prodContratadoFrecDTO.getNumerosFrecuentesTipoListDTO();
				if(numsFrecTipoListDTO != null)
				{
					for(int j=0;j<numsFrecTipoListDTO.size();j++)
					{
						numFrecTipoListDTO = (NumeroFrecuenteTipoListDTO) numsFrecTipoListDTO.get(j);
						numeroFrecDTOArr = numFrecTipoListDTO.getNumFrecuentesIngresadosList();
						for(int k=0;k<numeroFrecDTOArr.length;k++)
						{
							numeroFrecDTO = numeroFrecDTOArr[k];
							numeroSess = ""+numeroFrecDTO.getNumero();
							//if(numeroDTO.getNro().equals(numeroSess) && numeroDTO.getIdProductoContratado().equals(""+numeroFrecDTO.getIdProductoContratadoFrec()))
							if(numeroDTO.getNro().equals(numeroSess) && numeroDTO.getIdProductoContratado()!=null && numeroDTO.getIdProductoContratado().equals(""+numeroFrecDTO.getIdProductoContratadoFrec()))
							{
								return true;
							}
						}
					}
				}
	
			}
		}
		catch (Exception e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug(CLASS_NAME+" "+METHOD_NAME+"[" + loge + "]");
			throw e;
		}
		return false;
	}
	
	private static boolean estaEnListaOri(NumeroFrecuenteDTO numeroFrecDTO, List productosContratadosList) throws Exception 
	{
		String METHOD_NAME = "estaEnListaOri";
		NumeroListDTO numeroListOri = null;
		NumeroDTO[]   numeroArr =  null;
		ProdContratadoOfertadoDTO producto = null;
		String numeroSess = ""+numeroFrecDTO.getNumero();
		try
		{
			for(int i=0;i<productosContratadosList.size();i++)
			{
				producto = (ProdContratadoOfertadoDTO) productosContratadosList.get(i);
				numeroListOri = producto.getListaNumeros();
				numeroArr = numeroListOri.getNumerosDTO();
				
				for(int j=0;j<numeroArr.length;j++)
				{
					if(numeroSess.equals(numeroArr[j].getNro()) && (""+numeroFrecDTO.getIdProductoContratadoFrec()).equals(numeroArr[j].getIdProductoContratado()))
					{
						return true;
					}
				}
			}
		}
		catch (Exception e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug(CLASS_NAME+" "+METHOD_NAME+"[" + loge + "]");
			throw e;
		}
		return false;
	}
	
}
