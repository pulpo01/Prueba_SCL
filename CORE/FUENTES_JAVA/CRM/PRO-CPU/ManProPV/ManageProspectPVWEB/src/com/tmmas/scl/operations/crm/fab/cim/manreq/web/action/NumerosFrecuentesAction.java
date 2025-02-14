package com.tmmas.scl.operations.crm.fab.cim.manreq.web.action;

import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;


import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroListDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.AbonadoFrmkDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.NumeroFrecuenteDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ProdContratadoOfertadoDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ProductoContratadoFrecDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.ListaProdContratadosForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.NumerosFrecuentesForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.Global;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.NavegacionWeb;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.ProductosContradosFrecUtil;

public class NumerosFrecuentesAction extends Action {
	
	private final Logger logger = Logger.getLogger(NumerosFrecuentesAction.class);
	private Global global = Global.getInstance();
	String  CLASS_NAME = "NumerosFrecuentesAction ";
	private NavegacionWeb navegacion=null;
	private AbonadoFrmkDTO abonado = null;
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		String METHOD_NAME = "execute";
		logger.debug(CLASS_NAME+"----INI---------------------------->");
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);
		
		logger.debug(CLASS_NAME+" "+METHOD_NAME+"----------------------------ini------------------------------------>");
		logger.debug("execute():start");
		
		
		if(request.getParameter("cancelaNumFrec") != null && request.getParameter("cancelaNumFrec").equals("1"))
		{
			logger.debug(CLASS_NAME+"----FIN-----numfrec cancelado-voy a --producto------------->");
			return mapping.findForward("producto");
		}
		ProductosContradosFrecUtil pfu = new ProductosContradosFrecUtil();
		HttpSession session = request.getSession(true);//false , ver si hay que remover algun atributo de la session
	    String correlativo = null;
		String numFrecArr = null;
		String tiposNumArr = null;
		String codTiposNumArr = null;
		boolean volverAProductos = false;
		ArrayList listaNumeros = null;
		
		ProductoContratadoFrecDTO [] productosContratadosFrecSess = null;
		ProductoContratadoFrecDTO productoContratadoFrecSess = null;
		ArrayList numerosFrecuentesTipoListDTO = null;
		ArrayList numFrecDeOtrosProductos = null;
		ArrayList arrTipos = null;
		int indiceProdConFrec =-1;
		String codPadrePaq = "";
		String identificadorProducto  = "";
		try
		{
			abonado = (AbonadoFrmkDTO) session.getAttribute("Abonado");
			//navegacion = (NavegacionWeb) session.getAttribute("navegacion");
		    ClienteOSSesionDTO sessionData = new ClienteOSSesionDTO();
		   // HttpSession session = request.getSession(false);
		    //session.removeAttribute("productosContratados");
		    sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");
		    //ClienteDTO cliente = sessionData.getCliente();
		    //AbonadoDTO abonado = cliente.getAbonados().getAbonados()[0];

			codPadrePaq = (String)session.getAttribute("codPadrePaq");
			logger.debug(CLASS_NAME+" en la session codPadrePaq "+codPadrePaq);
			productosContratadosFrecSess = (ProductoContratadoFrecDTO []) session.getAttribute("productosContratadosFrecSess");
			if(productosContratadosFrecSess == null)
			{			
				logger.debug(CLASS_NAME+"productosContratadosFrecSess == null ---->generaProductoContratadoList(l,l,cli,abo)");
				//productosContratadosFrecSess = pfu.generaProductoContratadoList(productosContratados, null,
						                       //abonado.getCodCliente(),abonado.getNumAbonado());
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		if(request.getParameter("actualizaNumFrec") != null && request.getParameter("actualizaNumFrec").equals("1"))
		{
			//vengo de la lista de numeros de un producto
			try
			{
	
				NumerosFrecuentesForm form1 = (NumerosFrecuentesForm)form;
				correlativo = form1.getCorrelativo();
				codPadrePaq = form1.getCodPadrePaq();
				identificadorProducto = form1.getIdentificadorProducto();
				logger.debug(CLASS_NAME+" vengo de la lista de numeros identificadorProducto "+identificadorProducto);
				logger.debug(CLASS_NAME+" vengo de la lista de numeros actualizaNumFrec correlativo "+correlativo);
				logger.debug(CLASS_NAME+" vengo de la lista de numeros "+codPadrePaq);
				
				//log2(CLASS_NAME+"request.getParameter(\"actualizaNumFrec\") "+request.getParameter("actualizaNumFrec"));
				numFrecArr = form1.getNumFrecArr();
				tiposNumArr = form1.getTiposNumArr();
				codTiposNumArr = form1.getCodTiposNumArr();
				listaNumeros = new ArrayList();
				StringTokenizer stNum = new StringTokenizer(numFrecArr,",");
				StringTokenizer stTipNum = new StringTokenizer(tiposNumArr,",");
				StringTokenizer stCodTipNum = new StringTokenizer(codTiposNumArr,",");
				logger.debug(CLASS_NAME+" del request tiposNumArr    "+tiposNumArr);
				logger.debug(CLASS_NAME+" del request codTiposNumArr "+codTiposNumArr);
				NumeroFrecuenteDTO numeroFrecuenteDTO = null;
				logger.debug(CLASS_NAME+"st.countTokens() "+stNum.countTokens());
				int ind = 0;
				while(stNum.hasMoreTokens())
				{
					numeroFrecuenteDTO = new NumeroFrecuenteDTO();
					numeroFrecuenteDTO.setIdProductoContratadoFrec(Long.parseLong(correlativo));
					//INC 171563
					//numeroFrecuenteDTO.setNumero(Long.parseLong(stNum.nextToken()));
					numeroFrecuenteDTO.setNumero(stNum.nextToken());
					//FIN INC 171563
					numeroFrecuenteDTO.setTipo(stTipNum.nextToken());//"ON-NET";
					numeroFrecuenteDTO.setCodTipo(stCodTipNum.nextToken());//"ONN";
					logger.debug(CLASS_NAME+"ind "+ind+" numeroFrecuenteDTO.getNumero() "+numeroFrecuenteDTO.getNumero()+" "+numeroFrecuenteDTO.getTipo());
					listaNumeros.add(numeroFrecuenteDTO);
					ind++;
				}
				logger.debug(CLASS_NAME+"ind "+ind+" listaNumeros.size() "+listaNumeros.size());
				volverAProductos = true;
				indiceProdConFrec = ProductosContradosFrecUtil.getIndexProductoContratadoFrec(productosContratadosFrecSess, identificadorProducto);
				//indiceProdConFrec = ProductosContradosFrecUtil.getIndexProductoContratadoFrec(productosContratadosFrecSess, Long.parseLong(correlativo));
				productoContratadoFrecSess = productosContratadosFrecSess[indiceProdConFrec];		
				numerosFrecuentesTipoListDTO  = productoContratadoFrecSess.getNumerosFrecuentesTipoListDTO();//getNumeroFrecuenteTipDTOArrList();//ProductosContradosFrecUtil.getNumeroFrecuenteFiltradoArr(productoContratadoFrecSess);
				ProductosContradosFrecUtil.actualizaNumeros(numerosFrecuentesTipoListDTO, listaNumeros);
				
				productoContratadoFrecSess.setNumerosFrecuentesTipoListDTO(numerosFrecuentesTipoListDTO);
				productosContratadosFrecSess[indiceProdConFrec] = productoContratadoFrecSess;
			}
			catch(Exception e)
			{
				e.printStackTrace();
				logger.debug("e.getMessage() "+e.getMessage());
			}

			logger.debug("numFrecArr "+numFrecArr);
			logger.debug(CLASS_NAME+"numFrecArr "+numFrecArr);
		}
		else
		{
			//vengo de la lista de productos
			//correlativo = request.getParameter("codNumFre");
			logger.debug("form.getClass()   :"+form.getClass());
			String idProductoContratado = null;
			try
			{
		    	ListaProdContratadosForm form2 = (ListaProdContratadosForm) form;
				logger.debug("form2.getIdProductoContratado()   :"+form2.getIdProductoContratado());
			    logger.debug("form2.getCodigoProducto()         :"+form2.getCodigoProducto());
			    logger.debug("form2.getNombreProducto()         :"+form2.getNombreProducto());
			    idProductoContratado = form2.getIdProductoContratado();
		    }
			catch(Exception e)
			{
				idProductoContratado = request.getParameter("idProductoContratado");
				logger.debug("del request.getParameter idProductoContratado "+idProductoContratado);
				logger.debug("e.getMessage() ----------------->"+e.getMessage());//e.printStackTrace();
			}
			
			correlativo =  idProductoContratado;//(String)session.getAttribute("codNumFre");//aca tiene que ir el idproducto..

			identificadorProducto = idProductoContratado;//(String)session.getAttribute("identificadorProducto");
			logger.debug(CLASS_NAME+" en la session identificadorProducto "+identificadorProducto);
			
			//codPadrePaq = (String)session.getAttribute("codPadrePaq");
			logger.debug(CLASS_NAME+"desde lista de productos idProductoContratado "+idProductoContratado);
			//log2(CLASS_NAME+" en la session codPadrePaq "+codPadrePaq);
			
			//(+) ev
			if(productosContratadosFrecSess == null){
				productosContratadosFrecSess = (ProductoContratadoFrecDTO []) session.getAttribute("productosContratadosFrecSess");
			}
			//(-)
			indiceProdConFrec = ProductosContradosFrecUtil.getIndexProductoContratadoFrec(productosContratadosFrecSess, idProductoContratado);
			//indiceProdConFrec = ProductosContradosFrecUtil.getIndexProductoContratadoFrec(productosContratadosFrecSess, Long.parseLong(correlativo),codPadrePaq);
			productoContratadoFrecSess = productosContratadosFrecSess[indiceProdConFrec];	
			if(productoContratadoFrecSess.getNumerosFrecuentesTipoListDTO() != null)
			{
				numerosFrecuentesTipoListDTO = productoContratadoFrecSess.getNumerosFrecuentesTipoListDTO();
				productoContratadoFrecSess.setTiposNumPermitidos(ProductosContradosFrecUtil.getTiposNumPermitidosProducto(numerosFrecuentesTipoListDTO));
			}
			else
			{
				logger.debug(CLASS_NAME+"productoContratadoFrecSess.getNumerosFrecuentesTipoListDTO() == null");
			}
		}
		numFrecDeOtrosProductos = ProductosContradosFrecUtil.getNumerosFrecuentesDeOtrosProductos(productosContratadosFrecSess, identificadorProducto,indiceProdConFrec);
		//numFrecDeOtrosProductos = ProductosContradosFrecUtil.getNumerosFrecuentesDeOtrosProductos(productosContratadosFrecSess, Long.parseLong(correlativo));
		arrTipos = productoContratadoFrecSess.getTiposNumPermitidos();
		logger.debug("arrTipos.size() "+arrTipos.size());
		if(indiceProdConFrec >-1)
		{
			logger.debug(CLASS_NAME+"indiceProdConFrec "+indiceProdConFrec);
		}
		
		//navegacion.setProductoNumFrecByAbonado(String.valueOf(abonado.getIdAbonado()), productosContratadosFrecSess);
		
		session.setAttribute("navegacion",navegacion );
		session.setAttribute("productoContratadoFrecSess", productoContratadoFrecSess);
		session.setAttribute("productosContratadosFrecSess", productosContratadosFrecSess);
		session.setAttribute("numFrecDeOtrosProductos", numFrecDeOtrosProductos);
		session.setAttribute("numerosFrecuentesTipoListDTO", numerosFrecuentesTipoListDTO);
	    session.setAttribute("arrTipos", arrTipos);
	    session.setAttribute("prodConFrecConf", correlativo);
	    session.setAttribute("codPadrePaq", codPadrePaq);
	    session.setAttribute("maxNumProducto", ""+productoContratadoFrecSess.getNumFrecuentesPermitidos());
	    session.setAttribute("identificadorProducto", identificadorProducto);
	    session.setAttribute("numCelAbonado",""+abonado.getNumCelular() );
	    //(+) EV 04/02/09
	    //busca el producto seleccionado
	    List productosContratadosFrecOrig = (List)session.getAttribute("productosContratadosFrecOrig");
	    for(int i=0; i<productosContratadosFrecOrig.size();i++){
	    	ProdContratadoOfertadoDTO prodTMP = (ProdContratadoOfertadoDTO)productosContratadosFrecOrig.get(i);
	    	if (prodTMP.getIdProdContratado().longValue()==Long.parseLong(identificadorProducto)){
	    		session.setAttribute("productoFrecSelec", prodTMP.clone());
	    	}
	    }
	    //(-) EV
	    
	    for(int i=0;i<arrTipos.size();i++)
	    {
	    	logger.debug(CLASS_NAME+"arrTipos.get(i) "+arrTipos.get(i));
	    }
	    logger.debug(CLASS_NAME+" "+METHOD_NAME+"----------------------------fin------------------------------------>");
		
	    String forward ="NumerosFrecuentes";
	    if(volverAProductos)
	    {	    	
	    	forward = "listaProdContratados";//"producto";
	    }
	    logger.debug(CLASS_NAME+"forward "+forward);
	    logger.debug(CLASS_NAME+"----FIN---------------------------->");
	    return mapping.findForward(forward);
	}
	

}
