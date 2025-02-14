package com.tmmas.scl.operations.crm.fab.cim.manreq.web.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.DatosEnvioCorreoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoListDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.AbonadoFrmkDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.exception.ManReqException;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate.ManageRequestBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.BitaForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.CargosForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.ProductoForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.NavegacionWeb;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.PaqueteWeb;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.ProductoWeb;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.ProductosContradosFrecUtil;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.VentaUtils;


public class ProductoAction extends Action
{
	
  private final Logger logger = Logger.getLogger(ProductoAction.class);
	
  private ProductoForm productoForm;
  
  private ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();
  public ActionForward execute(
	ActionMapping mapping,
	ActionForm form,
	HttpServletRequest request,
	HttpServletResponse response) throws Exception
  {

	  	productoForm = (ProductoForm) form;
		ProductoContratadoListDTO productoContratadoListDesc     = null;//TODO revisar si se pasa nulo o new en caso de traer datos
		ProductoContratadoDTO[]   productoContratadoArrNoDesc    = null;//arreglo tiene el orden de los pdtscnt con lc modifi
		ProductoOfertadoListDTO   productoOfertadoListCont       = null;
		ProductoContratadoListDTO productoContratadoMantenidosLC = null;
		
		HttpSession session = request.getSession(false);

		AbonadoFrmkDTO abonado = (AbonadoFrmkDTO) session.getAttribute("Abonado");
		NavegacionWeb navegacion = (NavegacionWeb) session.getAttribute("navegacion");
		
	    ClienteOSSesionDTO sessionData = new ClienteOSSesionDTO();
	    sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");

	    sessionData.setCargosObtenidos(null);//AGREGAR 191208
	    CargosForm cargosForm = new CargosForm();
	    session.setAttribute("CargosForm",null);
		String retornoFW="flujoContDesc";
		//System.out.println("ProductoAction getIdProducto "+productoForm.getIdProducto());
		
		//antes de ir a una opcion de producto guardo los productos que fueron chequeados
		navegacion.setPagina("productos"); //<-- para que guarde los productos
		navegacion.setAccion(BitaForm.ACEPTAR);	
		navegacion.setIdPagina(String.valueOf(abonado.getIdAbonado()));
		
		//String bitac = (String) request.getParameter("bitac");
		//String bita = (String) request.getParameter("bita");
		
		String bitacorad = productoForm.getBitacorad();//(String) request.getParameter("bitacora");
		String bitacorac = productoForm.getBitacorac();//(String) request.getParameter("bitacorac");
		String bitacoradindexcant = productoForm.getBitacoradindexcant();//es el orden en que se checkearon los pdts
		
		logger.debug("ProductoAction bitacorad         ["+bitacorad+"]");
		logger.debug("ProductoAction bitacorac         ["+bitacorac+"]");
		logger.debug("ProductoAction bitacoradindexcant["+bitacoradindexcant+"]");
		
		String bitacoraAux = (String) request.getParameter("bitacoraLcDef");
		String bitacoraContIndexLcDef = (String) request.getParameter("bitacoraContIndexLcDef");
		String bitacoraOferIndexLcDef = (String) request.getParameter("bitacoraOferIndexLcDef");

		//request.getParameterValues("bitacoraLcDef")[0];
		if(bitacoraAux!=null)
		{
			navegacion.setBitacoraDef(bitacoraAux);
			navegacion.setBitacoraContIndexLcDef(bitacoraContIndexLcDef);
		}
		
		
		String[] limConsumoCodigosCont = request.getParameterValues("combo_lc_C");
		String[] indexConsCodigosCont  = request.getParameterValues("indexCombo_lc_C");
		String[] montoslc_c            = request.getParameterValues("montoslc_c");
		
		//bitacorad = bita;
		//bitacorac = bitac;
		String idControlCh = (String) request.getParameter("idControlCh");
		//logger.debug("ProductoAction bitac "+bitac);
		//logger.debug("ProductoAction bita "+bita);
		logger.debug("ProductoAction idControlCh id|esvisible|disabled|checkeado:"+idControlCh);//controlesId[0]+"|"+esvisible+"|"+disabled+"|"+checkeado;
		String[] cantidadesOrdBD=null;
		String[] cantidadesOrdSel=null;
		String[] cantidades=null;

		String[] montoslc  =null;
		String[] lcCodsOfer=null;
		String[] montoslcOrdBD=null;
		String[] lcCodsOferOrdBD =null;
		String cantidadesP=null;//[]
		AbonadoFrmkDTO abonadoFrmk = (AbonadoFrmkDTO)session.getAttribute("Abonado");
		PaqueteWeb productos = navegacion.getPaqueteWeb(""+abonadoFrmk.getIdAbonado());
		if ((bitacorad!=null && bitacorad.trim().length()>0) || (bitacorac!=null && bitacorac.trim().length()>0)){
			
			//recupero los productos contratados a descontratar y los ofertables a contratar o modificar
			/* codigos y montos LC */
			//String cantidadPdt       = (String) request.getParameter("cantidadPdt");
			//String bitacoraOferCodLC = (String) request.getParameter("bitacoraOferCodLC");
			//String bitacoraOferMtoLC = (String) request.getParameter("bitacoraOferMtoLC");
			
			/**/
			ArrayList prodContratados = obtieneArrProdContratados(bitacorac);
			ArrayList prodDisponibles = obtieneArrProdDisponibles(bitacorad,cantidadesOrdSel);
			//si existen productos ofertables chequeados
			navegacion.setBitacora(bitacorad);
			navegacion.setBitacorac(bitacorac);

			logger.debug("RECUPERANDO PRODUCTOS CONTRATADOS Y OFERTADOS SELECCIONADOS");
			productoContratadoListDesc = obtenerProdContADescontratar(productos,prodContratados,""+sessionData.getNumOrdenServicio());
			productoContratadoListDesc.setNumEvento(obtieneNumEvento(sessionData));

			if(bitacorad!=null && bitacorad.trim().length()>0)
			{
				logger.debug("---------ordenar checkeados ofertados--------ini");
				cantidadesOrdBD = request.getParameterValues("cantidades");
				montoslcOrdBD  =  request.getParameterValues("montoslc");
				lcCodsOferOrdBD = request.getParameterValues("combo_lc");
				VentaUtils.imprimirDatosRecuperados(cantidadesOrdBD,montoslcOrdBD,lcCodsOferOrdBD);
				logger.debug("bitacindexcant["+bitacoradindexcant+"]");
				if(cantidadesOrdBD == null){
					cantidadesP = request.getParameter("cantidadesP");
					cantidadesOrdBD = cantidadesP.split("|");
					logger.debug("cantidadesP "+cantidadesP);
				}
				String[] bit     = bitacoradindexcant.split(",");
				int[] indicesOrd = VentaUtils.obtenerIndicesCant(bit);
				cantidadesOrdSel = VentaUtils.ordenarCantidadesOrd(cantidadesOrdBD,indicesOrd);
				/*cantidadesOrdSel = VentaUtils.obtenerArreglo(cantidadPdt, "|");
				montoslc   = VentaUtils.obtenerArreglo(bitacoraOferMtoLC, "|");//request.getParameterValues("montoslc");
				lcCodsOfer = VentaUtils.obtenerArreglo(bitacoraOferCodLC, "|");//)request.getParameterValues("combo_lc");
				cantidades = VentaUtils.ordenarCantidadesOrd(cantidadesOrdBD,indicesOrd);
				montoslc   = VentaUtils.ordenarCantidadesOrd(montoslcOrdBD,indicesOrd);//si hay pdt sin LC queda incmpt
				lcCodsOfer = VentaUtils.ordenarCantidadesOrd(lcCodsOferOrdBD,indicesOrd);//
				
				logger.debug("----------listas-ordenadas------------------");
				//VentaUtils.imprimirDatosRecuperados(cantidadesOrdSel,montoslc,lcCodsOfer);
				logger.debug("---------ordenar checkeados ofertados--------fin");*/
				productoOfertadoListCont = obtenerProductosPorId(productos.getProductosDisponible(), bitacorad,cantidadesOrdSel);
			}
			navegacion.setBitacoraOferIndexLcDef(bitacoraOferIndexLcDef);
			//grabo los que fueron chequeados
			navegacion.Grabar();
			// y luego le asigno sus cantidades recuperadas por struts, es decir en el orden de despliegue que es el mismo que el de BD
			navegacion.setCantidadesPorProductoOfertado(String.valueOf(abonado.getIdAbonado()),cantidadesOrdBD);//,productoOfertadoListCont);
			navegacion.setLCPorProductoOfertado(String.valueOf(abonado.getIdAbonado()),lcCodsOferOrdBD,montoslcOrdBD);//lcCodsOfer,montoslc);
			//if(productoContratadoListDesc.getProductosContratadosDTO().length > 0){
			navegacion.setLCPorProductoContratado(String.valueOf(abonado.getIdAbonado()),montoslc_c);//}
		}else
		{
			//esto ocurre cuando no existe ningun producto ofertable checkeado 
			//pero igual se debe "grabar", que nada fue seleccionado
			navegacion.Grabar();
			
			if(bitacoraAux!=null && bitacoraAux.trim().length()>0)
			navegacion.setLCPorProductoContratado(String.valueOf(abonado.getIdAbonado()),montoslc_c);
		}
		/* mantención LC en productos contratados ini*/
		if(limConsumoCodigosCont!=null && limConsumoCodigosCont.length > 0)
		{
			//Si no descheckeó productos para descontratar se retornan todos los pdt contratados (podría haber modificado su LC)
			ProductoContratadoDTO[] prodContrsSel = null;
			if(productoContratadoListDesc !=null && productoContratadoListDesc.getProductosContratadosDTO() !=null &&
					productoContratadoListDesc.getProductosContratadosDTO().length>0)
			{
				prodContrsSel = productoContratadoListDesc.getProductosContratadosDTO();
			}
			productoContratadoArrNoDesc = obtenerProdContNoSeleccionados(productos,prodContrsSel);
			VentaUtils.imprimirProd(productoContratadoListDesc,productoContratadoArrNoDesc);
			logger.debug("bitacorac     ["+bitacorac+"]");
			logger.debug("montoslc_c    ["+VentaUtils.imprimirArray(montoslc_c)+"]");
			logger.debug("limConsCodCont["+VentaUtils.imprimirArray(limConsumoCodigosCont)+"]");
			Date fechaHoraBaseDatos = delegate.obtenerFechaBaseDeDatos();
			logger.debug("fecHoraBDatos ["+fechaHoraBaseDatos+"]");
			productoContratadoMantenidosLC = obtenerProductosContManLC(productoContratadoArrNoDesc,
					                         limConsumoCodigosCont,montoslc_c,fechaHoraBaseDatos,sessionData);
			VentaUtils.imprimirProdModLC(productoContratadoMantenidosLC);
		}
		/* mantención LC en productos contratados ini*/
		if(productoContratadoListDesc == null)
		{
			productoContratadoListDesc = new ProductoContratadoListDTO();
		}
		
		if(productoOfertadoListCont == null)
		{
			productoOfertadoListCont = new ProductoOfertadoListDTO();
			productoOfertadoListCont.setProductoList(new ProductoOfertadoDTO[0]);
		}
		session.setAttribute("productoContratadoListDesc", productoContratadoListDesc);
		session.setAttribute("productoOfertadoListCont", productoOfertadoListCont);
		session.setAttribute("productoContratadoMantenidosLC", productoContratadoMantenidosLC);
		
		//(+) si es PA de tipo "correo seven", se invoca a pagina de datos adicionales
		
		logger.debug("productoForm.getIdEspecProvision()="+productoForm.getIdEspecProvision());
		PaqueteWeb paqueteWeb = navegacion.getPaqueteWeb(String.valueOf(abonado.getIdAbonado()));
		boolean esCorreoSeven = VentaUtils.esCorreoSeven(paqueteWeb.getParametrosCorreo(), productoForm.getIdEspecProvision())  ;
		logger.debug("flujo esCorreoSeven="+esCorreoSeven);
		if (esCorreoSeven){
			//(+)obtiene producto seleccionado
			ArrayList listaProductosDisponibles = paqueteWeb.getProductosDisponible();
			ProductoWeb productoWeb = new ProductoWeb();
			for(int i=0; i<listaProductosDisponibles.size();i++){
				productoWeb = (ProductoWeb)listaProductosDisponibles.get(i);
				
				if (productoWeb.getIdEspecProvision()!=null
						&& productoWeb.getIdEspecProvision().equals(productoForm.getIdEspecProvision())){
					break;
				}
			}
			//(-)
			
			session.setAttribute("navegacion",navegacion );
			session.setAttribute("paqueteWeb",paqueteWeb );
			session.setAttribute("productoSeleccionado",productoWeb );
			productoForm.setIdEspecProvision(null);
			retornoFW = "datosAdicCorreoSeven";
		}
		//(-) si es PA de tipo "correo seven", se invoca a pagina de datos adicionales
		/** Verifica si es correo seven, si es así el flujo va a los datos del correo ini */
		/*String identificadorProducto = productoForm.getIdProducto();
		boolean esCorreoSeven = false;
		if(identificadorProducto != null || !"".equals(identificadorProducto))
		{
			int indiceProducto = VentaUtils.obtenerIndiceProductoPorId(productos.getProductosDisponible(), identificadorProducto);
			ProductoWeb productoWeb = (ProductoWeb)productos.getProductosDisponible().get(indiceProducto);
			esCorreoSeven = productoWeb.esCorreoSeven();
		}

		if(esCorreoSeven)
		{
			session.setAttribute("Abonado",abonado );
			session.setAttribute("navegacion",navegacion );
			session.setAttribute("identificadorProducto",  identificadorProducto);
			session.setAttribute("codPadrePaq",  productoForm.getCodPadrePaq());
			session.setAttribute("codNumFre",  productoForm.getCodigo());
			session.setAttribute("desde",  "pdt");
			retornoFW="datosCliente";
		}*/
		/** correo seven fin */
		if("flujoContDesc".equals(retornoFW))
		{
			logger.debug("revision de envio de correo ini....");
			if(productoOfertadoListCont.getProductoList().length > 0)
			{
				logger.debug("ProductoAction IMPRIMIENDO PROD OFERTADO A CONTRATAR ini");
				for(int i=0;i<productoOfertadoListCont.getProductoList().length;i++)
				{
					ProductosContradosFrecUtil.imprimeProdOfer(productoOfertadoListCont.getProductoList()[i], "revisarPadre");
					logger.debug("isEnviaCorreo["+productoOfertadoListCont.getProductoList()[i].isEnviaCorreo()+"]");
					if(productoOfertadoListCont.getProductoList()[i].isEnviaCorreo())
					{
						logger.debug("idProductoOfertado["+productoOfertadoListCont.getProductoList()[i].getIdProductoOfertado()+"]");
						logger.debug("identificadorProductoOfertado["+productoOfertadoListCont.getProductoList()[i].getIdentificadorProductoOfertado()+"]");
					}
				}
				logger.debug("ProductoAction IMPRIMIENDO PROD OFERTADO A CONTRATAR fin");
			}
			logger.debug("revision de envio de correo fin....");
		}
		return mapping.findForward(retornoFW);
	}

	private String[] obtieneCantidades(String cantidadesP) {
		String[] cantidades = null;
		try
		{
			StringTokenizer stc = new StringTokenizer(cantidadesP,"|");
			int numCant = stc.countTokens();
			int numCantT = 0;
			cantidades = new String [numCant];
			int j = 0;
			for(int i=0;i<numCant;i++)
			{
				numCantT = stc.countTokens();
				//System.out.println("WHL cantidadesP["+j++ +"]="+stc.nextToken());
				cantidades[i] = stc.nextToken();
			}
			//for(int i=0;i<cantidades.length;i++){System.out.println("cantidades["+i+"]="+cantidades[i]);}
		}
		catch(Exception e){
			logger.debug("cantidades = null "+e.getMessage());
		}
		return cantidades;
	}
  

	private String obtieneNumEvento(ClienteOSSesionDTO sessionData) throws ManReqException 
	{
		SecuenciaDTO secuencia = new SecuenciaDTO();
		if(sessionData.getNumOrdenServicio()== 0)
		{
            logger.debug("obtenerSecuencia:antes");
            secuencia.setNomSecuencia("CI_SEQ_NUMOS");
            logger.debug("nomSecuencia :"+secuencia.getNomSecuencia());
            secuencia = delegate.obtenerSecuencia(secuencia);
            sessionData.setNumOrdenServicio(secuencia.getNumSecuencia());
            logger.debug("obtenerSecuencia:despues");
		}
		return ""+sessionData.getNumOrdenServicio();
	}

	private ArrayList obtieneArrProdContratados(String bitacora)
	{
		ArrayList productos = new ArrayList();
		StringTokenizer st = new StringTokenizer(bitacora,"|");
		while(st.hasMoreTokens())
		{
			StringTokenizer stp = new StringTokenizer(st.nextToken(),".");
			stp.nextToken();//tipo
			productos.add(stp.nextToken());//idprodcontratado
			stp.nextToken();//padre
		}
		return productos;
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
	
	private ProductoContratadoListDTO obtenerProdContADescontratar(PaqueteWeb productos,ArrayList prodContratados,String codOrdenSer)
	{
		ProductoContratadoListDTO retorno = new ProductoContratadoListDTO();
		ProductoContratadoListDTO productoContratadoList =productos.getProductosCont();
		ProductoContratadoDTO[] productoContratadoArr=productoContratadoList.getProductosContratadosDTO();//abonadoFrmk.getProductoContratados();
		ProductoContratadoDTO[] productoContratadoDescArr = obtenerProdContSeleccionados(productoContratadoArr,prodContratados,codOrdenSer);
		retorno.setProductosContratadosDTO(productoContratadoDescArr);
		logger.debug("ProductoAction IMPRIMIENDO PROD CONTRATADO A DESCONTRATAR");
		for(int i=0;i<productoContratadoDescArr.length;i++)
		{
			ProductosContradosFrecUtil.imprimeProdCont(productoContratadoDescArr[i]);
		}
		return retorno;
	}
	
	private ProductoContratadoDTO [] obtenerProdContSeleccionados(ProductoContratadoDTO[] productoContratados,ArrayList prodContratadosSel,String codOrdenSer)
	{
		ArrayList productos = new ArrayList();
		String idProd = null;
		ProductoContratadoDTO prodCont = null;
		ProductoContratadoDTO [] retorno;
		for(int i=0;i<prodContratadosSel.size();i++)
		{
			idProd = (String)prodContratadosSel.get(i);
			for(int j=0;j<productoContratados.length;j++)
			{
				//prodWeb = productoContratados[j];
				prodCont = productoContratados[j];//prodWeb.get//(ProductoContratadoDTO)productosContratados.get(j);
				if(idProd.equals(""+prodCont.getIdProdContratado()))
				{
					prodCont.setNumProcesoDescontrata(codOrdenSer);
					prodCont.setOrigenProcesoDescontrata(codOrdenSer);
					productos.add(prodCont);
					break;
				}
			}
		}

		retorno = new ProductoContratadoDTO [productos.size()];
		for(int i=0;i<productos.size();i++)
		{
			retorno[i] = (ProductoContratadoDTO) productos.get(i);
		}
		return retorno;
	}
	
	private ProductoContratadoDTO [] obtenerProdContNoSeleccionados(PaqueteWeb productosweb,ProductoContratadoDTO[] prodContratadosSel)
	{
		ArrayList productos = new ArrayList();
		String idProd = null;
		ProductoContratadoDTO prodContSel = null;
		ProductoContratadoDTO [] retorno;
		boolean esSeleccionado = false;
		ProductoContratadoListDTO productoContratadoList =productosweb.getProductosCont();
		ProductoContratadoDTO[] productoContratadoArr=productoContratadoList.getProductosContratadosDTO();
		ProductoContratadoDTO[] prodContrsSel = new ProductoContratadoDTO[0];
		//Si no descheckeó productos para descontratar se retornan todos los pdt contratados (podría haber modificado su LC)
		if(prodContratadosSel !=null && prodContratadosSel.length>0)
		{
			prodContrsSel = prodContratadosSel;
		}
		for(int i=0;i<productoContratadoArr.length;i++)
		{
			idProd =  ""+productoContratadoArr[i].getIdProdContratado();
			esSeleccionado = false;
			for(int j=0;j<prodContrsSel.length;j++)
			{
				prodContSel = prodContrsSel[j];//prodWeb.get//(ProductoContratadoDTO)productosContratados.get(j);
				if(idProd.equals(""+prodContSel.getIdProdContratado()))
				{
					esSeleccionado = true;
					break;
				}
			}
			if(!esSeleccionado)
			{
				productos.add(productoContratadoArr[i]);
			}
		}

		retorno = new ProductoContratadoDTO [productos.size()];
		for(int i=0;i<productos.size();i++)
		{
			retorno[i] = (ProductoContratadoDTO) productos.get(i);
		}
		return retorno;
	}
	
	private ProductoContratadoListDTO obtenerProductosContManLC(ProductoContratadoDTO[] productoContratadoArrNoDesc, 
		     String[] limConsumoCodigos, String[] montoslc_c, Date fechaHoraBaseDatos, ClienteOSSesionDTO sessionData) {
		ProductoContratadoDTO pdtcnt   = null;
		ProductoContratadoDTO pdtcntML = null;
		ArrayList productoContratadoArrListManLc = new ArrayList();
		ProductoContratadoListDTO productoContratadoListManLc = new ProductoContratadoListDTO();
		Date fechaHoraBaseDatosPdt = fechaHoraBaseDatos;
		int numLC = 0;
		if(limConsumoCodigos != null){
			numLC = limConsumoCodigos.length;
		}
		for(int i=0;i<numLC;i++){
			if(!"-0".equals(limConsumoCodigos[i])){
				//if(!"1".equals(prodOfAux.getIndPaquete()) && 
				//!prodWeb.getCodLimConsuInicial().equals(prodWeb.getCodLimConsuSeleccionado())  ) 
				// Esta ultima condicion es para filtrar productos que solo se han modificado
				pdtcnt = productoContratadoArrNoDesc[i];
				fechaHoraBaseDatosPdt = VentaUtils.agregarUnSegundo(fechaHoraBaseDatosPdt);
				logger.debug("fechaHoraBaseDatosPdt["+i+"]["+fechaHoraBaseDatosPdt.toString()+"]");
				pdtcnt.setFechaProcesoDescontrata(fechaHoraBaseDatosPdt);//pdtcntML.setIdProdContratado(pdtcnt.getIdProdContratado());
				pdtcnt.setNombreUsuario(sessionData.getUsuario());
				pdtcnt.setlimiteConsumoContratado(limConsumoCodigos[i]);
				pdtcnt.setMtoConsumoConfigurado(new Float(montoslc_c[i]));
				productoContratadoArrListManLc.add(pdtcnt);
				
				
			}
		}
		ProductoContratadoDTO[] productoContratadoArrManLc = (ProductoContratadoDTO[])ArrayUtl.copiaArregloTipoEspecifico(
				                                      productoContratadoArrListManLc.toArray(), ProductoContratadoDTO.class);
		productoContratadoListManLc.setProductosContratadosDTO(productoContratadoArrManLc);
		return productoContratadoListManLc;
	}
	
	private ProductoOfertadoListDTO obtenerProdOferAContratar(PaqueteWeb productos,ArrayList prodOfertados, String[] cantidades)
	{
		ProductoOfertadoListDTO retorno = new ProductoOfertadoListDTO();
		ProductoOfertadoListDTO productoOfertadoList =productos.getProductosOfer();
		ProductoOfertadoDTO[] productoOfertadoArr=productoOfertadoList.getProductoList();//abonadoFrmk.getProductoContratados();
		ProductoOfertadoDTO[] productoOfertadoDescArr = obtenerProdOferSeleccionados(productoOfertadoArr,prodOfertados);
		retorno.setProductoList(productoOfertadoDescArr);
		logger.debug("ProductoAction IMPRIMIENDO PROD OFERTADO A CONTRATAR");
		for(int i=0;i<productoOfertadoDescArr.length;i++)
		{
			ProductosContradosFrecUtil.imprimeProdOfer(productoOfertadoDescArr[i], "revisarPadre");
			logger.debug("cantidades["+i+"] "+cantidades[i]);
		}
		return retorno;
	}

	private ProductoOfertadoDTO [] obtenerProdOferSeleccionados(ProductoOfertadoDTO[] productoOfertados,ArrayList prodOfertadosSel)
	{
		ArrayList productos = new ArrayList();
		String idProd = null;
		ProductoOfertadoDTO prodOfer = null;
		ProductoOfertadoDTO [] retorno;
		for(int i=0;i<prodOfertadosSel.size();i++)
		{
			idProd = (String)prodOfertadosSel.get(i);
			for(int j=0;j<productoOfertados.length;j++)
			{
				//prodWeb = productoContratados[j];
				prodOfer = productoOfertados[j];//prodWeb.get//(ProductoContratadoDTO)productosContratados.get(j);
				if(idProd.equals(""+prodOfer.getIdProductoOfertado()))
				{
					productos.add(prodOfer);
				}
			}
		}
		retorno = new ProductoOfertadoDTO [productos.size()];
		for(int i=0;i<productos.size();i++)
		{
			retorno[i] = (ProductoOfertadoDTO) productos.get(i);
		}
		return retorno;
	}
	
	private ProductoOfertadoListDTO obtenerProductosPorId(ArrayList listaProdTipo, String bitacora, String[] cantidades)
	{
		ProductoWeb productoWeb;
		ArrayList productosSel = new ArrayList();
		StringTokenizer st = new StringTokenizer(bitacora,"|");
		String tipo;
		String codPadre;
		String idProd;
		String idProdSel;
		ProductoOfertadoDTO prodOfer;
		ProductoOfertadoListDTO retorno = new ProductoOfertadoListDTO();
		//en caso que el productoweb no sea de ningun paquete, su codpadre es el abonado
		
		//String[] cantidades = cantidades;//obtieneCantidades(cantidadesP);
		//cantidades = cantidadesP.split("|");
		int cantidad = 0;
		int indice = 0;
		while(st.hasMoreTokens())
		{
			StringTokenizer stp = new StringTokenizer(st.nextToken(),".");
			tipo = stp.nextToken();//tipo
			codPadre = stp.nextToken();//padre
			idProd = stp.nextToken();
			//productos.add(idProd);//idproddisponible
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
					productoWeb.getProductoDTO().setIndCondicionContratacion("O");
					cantidad = Integer.parseInt(cantidades[indice++]);
					for(int j=0;j<cantidad;j++)
					{
						productosSel.add(productoWeb);
					}
				}
			}
		}
		logger.debug("obtenerProductosPorId productosSel.size() "+productosSel.size()+"   ----------------------->");
		
		ArrayList prodOferArrList = new ArrayList();
		for(int i=0;i<productosSel.size();i++)
		{
			productoWeb = (ProductoWeb)productosSel.get(i);
			prodOfer = productoWeb.getProductoDTO();//pasar a arraylist y luego convertir a tipoespecifico
			prodOferArrList.add(prodOfer);
			//productoOfertadoDescArr[i] = prodOfer;//revisar hijos
			ProductosContradosFrecUtil.imprimeProdOfer(prodOfer, productoWeb.getCodPadre());
		}
		ProductoOfertadoDTO[] productoOfertadoDescArr =(ProductoOfertadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(prodOferArrList.toArray(), ProductoOfertadoDTO.class);
		retorno.setProductoList(productoOfertadoDescArr);
		return retorno;
	}
 }

