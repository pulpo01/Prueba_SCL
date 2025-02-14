package com.tmmas.scl.operations.crm.f.s.manpro.web.action;

import java.util.ArrayList;
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

import com.tmmas.scl.operations.crm.f.s.manpro.frmk.dataTransferObject.AbonadoFrmkDTO;
import com.tmmas.scl.operations.crm.f.s.manpro.frmk.dataTransferObject.NumeroFrecuenteDTO;
import com.tmmas.scl.operations.crm.f.s.manpro.frmk.dataTransferObject.ProductoContratadoFrecDTO;
import com.tmmas.scl.operations.crm.f.s.manpro.web.form.NumerosFrecuentesForm;
import com.tmmas.scl.operations.crm.f.s.manpro.web.helper.Global;
import com.tmmas.scl.operations.crm.f.s.manpro.web.helper.NavegacionWeb;
import com.tmmas.scl.operations.crm.f.s.manpro.web.helper.ProductosContradosFrecUtil;

public class NumerosFrecuentesAction extends Action 
{
	
	private final Logger logger = Logger.getLogger(NumerosFrecuentesAction.class);
	private Global global = Global.getInstance();
	String  CLASS_NAME = "NumerosFrecuentesAction ";

	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception 
	{		
		String forward="";
		NavegacionWeb navegacion=null;
		AbonadoFrmkDTO abonado = null;
		
		try
		{
				String METHOD_NAME = "execute";
				log2(CLASS_NAME+"----INI---------------------------->");
				String log = global.getValor("web.log");
				log=global.getPathInstancia()+ log;
				PropertyConfigurator.configure(log);
				
				logger.debug(CLASS_NAME+" "+METHOD_NAME+"----------------------------ini------------------------------------>");
				logger.debug("execute():start");
				
				
				if(request.getParameter("cancelaNumFrec") != null && request.getParameter("cancelaNumFrec").equals("1"))
				{
					log2(CLASS_NAME+"----FIN-----numfrec cancelado-voy a --producto------------->");
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
				
				abonado = (AbonadoFrmkDTO) session.getAttribute("Abonado");
				navegacion = (NavegacionWeb) session.getAttribute("navegacion");
				codPadrePaq = (String)session.getAttribute("codPadrePaq");
				log2(CLASS_NAME+" en la session codPadrePaq "+codPadrePaq);
				productosContratadosFrecSess = (ProductoContratadoFrecDTO []) navegacion.getProductoNumFrecByAbonado(String.valueOf(abonado.getIdAbonado()));
				//productosContratadosFrecSess = (ProductoContratadoFrecDTO [])session.getAttribute("ProductoContratadoFrecList");
					
				ArrayList listaProducNumFreq = navegacion.getListaProducNumFreq(String.valueOf(abonado.getIdAbonado()));
				ArrayList listaProducNoNumFreq = navegacion.getListaProducNoNumFreq(String.valueOf(abonado.getIdAbonado()));
				if(productosContratadosFrecSess == null)
				{			
					log2(CLASS_NAME+"productosContratadosFrecSess == null ---->generaProductoContratadoList(l,l,cli,abo)");
					productosContratadosFrecSess = pfu.generaProductoContratadoList(listaProducNumFreq, listaProducNoNumFreq,
								                       abonado.getCodCliente(),abonado.getIdAbonado());
				}
				if(request.getParameter("actualizaNumFrec") != null && request.getParameter("actualizaNumFrec").equals("1"))
				{
					//vengo de la lista de numeros de un producto			
						NumerosFrecuentesForm form1 = (NumerosFrecuentesForm)form;
						correlativo = form1.getCorrelativo();
						codPadrePaq = form1.getCodPadrePaq();
						identificadorProducto = form1.getIdentificadorProducto();
						log2(CLASS_NAME+" vengo de la lista de numeros identificadorProducto "+identificadorProducto);
						log2(CLASS_NAME+" vengo de la lista de numeros actualizaNumFrec correlativo "+correlativo);
						log2(CLASS_NAME+" vengo de la lista de numeros "+codPadrePaq);
						
						//log2(CLASS_NAME+"request.getParameter(\"actualizaNumFrec\") "+request.getParameter("actualizaNumFrec"));
						numFrecArr = form1.getNumFrecArr();
						tiposNumArr = form1.getTiposNumArr();
						codTiposNumArr = form1.getCodTiposNumArr();
						listaNumeros = new ArrayList();
						StringTokenizer stNum = new StringTokenizer(numFrecArr,",");
						StringTokenizer stTipNum = new StringTokenizer(tiposNumArr,",");
						StringTokenizer stCodTipNum = new StringTokenizer(codTiposNumArr,",");
						log2(CLASS_NAME+" del request tiposNumArr    "+tiposNumArr);
						log2(CLASS_NAME+" del request codTiposNumArr "+codTiposNumArr);
						NumeroFrecuenteDTO numeroFrecuenteDTO = null;
						log2(CLASS_NAME+"st.countTokens() "+stNum.countTokens());
						int ind = 0;
						while(stNum.hasMoreTokens())
						{
							numeroFrecuenteDTO = new NumeroFrecuenteDTO();
							numeroFrecuenteDTO.setIdProductoContratadoFrec(Long.parseLong(correlativo));
							numeroFrecuenteDTO.setNumero(Long.parseLong(stNum.nextToken()));
							numeroFrecuenteDTO.setTipo(stTipNum.nextToken());//"ON-NET";
							numeroFrecuenteDTO.setCodTipo(stCodTipNum.nextToken());//"ONN";
							log2(CLASS_NAME+"ind "+ind+" numeroFrecuenteDTO.getNumero() "+numeroFrecuenteDTO.getNumero()+" "+numeroFrecuenteDTO.getTipo());
							listaNumeros.add(numeroFrecuenteDTO);
							ind++;
						}
						log2(CLASS_NAME+"ind "+ind+" listaNumeros.size() "+listaNumeros.size());
						volverAProductos = true;
						indiceProdConFrec = ProductosContradosFrecUtil.getIndexProductoContratadoFrec(productosContratadosFrecSess, identificadorProducto);
						//indiceProdConFrec = ProductosContradosFrecUtil.getIndexProductoContratadoFrec(productosContratadosFrecSess, Long.parseLong(correlativo));
						productoContratadoFrecSess = productosContratadosFrecSess[indiceProdConFrec];		
						numerosFrecuentesTipoListDTO  = productoContratadoFrecSess.getNumerosFrecuentesTipoListDTO();//getNumeroFrecuenteTipDTOArrList();//ProductosContradosFrecUtil.getNumeroFrecuenteFiltradoArr(productoContratadoFrecSess);
						ProductosContradosFrecUtil.actualizaNumeros(numerosFrecuentesTipoListDTO, listaNumeros);
						
						productoContratadoFrecSess.setNumerosFrecuentesTipoListDTO(numerosFrecuentesTipoListDTO);
						productosContratadosFrecSess[indiceProdConFrec] = productoContratadoFrecSess;			
		
					logger.debug("numFrecArr "+numFrecArr);
					log2(CLASS_NAME+"numFrecArr "+numFrecArr);
				}
				else
				{
					//vengo de la lista de productos
					//correlativo = request.getParameter("codNumFre");
					correlativo =  (String)session.getAttribute("codNumFre");//aca tiene que ir el idproducto..
		
					identificadorProducto = (String)session.getAttribute("identificadorProducto");
					log2(CLASS_NAME+" en la session identificadorProducto "+identificadorProducto);
					//StringTokenizer stCoNum = new StringTokenizer(identificadorProducto,".");
					//correlativo = stCoNum.nextToken();
					//if(stCoNum.hasMoreTokens())
					//{
						//correlativo =  stCoNum.nextToken();
					//}
					
					codPadrePaq = (String)session.getAttribute("codPadrePaq");
					log2(CLASS_NAME+"desde lista de productos correlativo "+correlativo);
					log2(CLASS_NAME+" en la session codPadrePaq "+codPadrePaq);
					indiceProdConFrec = ProductosContradosFrecUtil.getIndexProductoContratadoFrec(productosContratadosFrecSess, identificadorProducto);
					//indiceProdConFrec = ProductosContradosFrecUtil.getIndexProductoContratadoFrec(productosContratadosFrecSess, Long.parseLong(correlativo),codPadrePaq);
					productoContratadoFrecSess = productosContratadosFrecSess[indiceProdConFrec];	
					if(productoContratadoFrecSess.getNumerosFrecuentesTipoListDTO() != null)
					{
						numerosFrecuentesTipoListDTO = productoContratadoFrecSess.getNumerosFrecuentesTipoListDTO();
						productoContratadoFrecSess.setTiposNumPermitidos(ProductosContradosFrecUtil.getTiposNumPermitidosProducto(numerosFrecuentesTipoListDTO));
					}
					else
					{
						log2(CLASS_NAME+"productoContratadoFrecSess.getNumerosFrecuentesTipoListDTO() == null");
					}
				}
				numFrecDeOtrosProductos = ProductosContradosFrecUtil.getNumerosFrecuentesDeOtrosProductos(productosContratadosFrecSess, identificadorProducto,indiceProdConFrec);
				//numFrecDeOtrosProductos = ProductosContradosFrecUtil.getNumerosFrecuentesDeOtrosProductos(productosContratadosFrecSess, Long.parseLong(correlativo));
				arrTipos = productoContratadoFrecSess.getTiposNumPermitidos();
				if(indiceProdConFrec >-1)
				{
					log2(CLASS_NAME+"indiceProdConFrec "+indiceProdConFrec);
				}
				//session.removeAttribute("ProductoContratadoFrecList");
				//session.removeAttribute("numFrecDeOtrosProductos");
		//		session.setAttribute("ProductoContratadoFrecList", productosContratadosFrecSess);
				
				navegacion.setProductoNumFrecByAbonado(String.valueOf(abonado.getIdAbonado()), productosContratadosFrecSess);
				
				session.setAttribute("navegacion",navegacion );
				session.setAttribute("productoContratadoFrecSess", productoContratadoFrecSess);
				session.setAttribute("numFrecDeOtrosProductos", numFrecDeOtrosProductos);
				session.setAttribute("numerosFrecuentesTipoListDTO", numerosFrecuentesTipoListDTO);
			    session.setAttribute("arrTipos", arrTipos);
			    session.setAttribute("prodConFrecConf", correlativo);
			    session.setAttribute("codPadrePaq", codPadrePaq);
			    session.setAttribute("maxNumProducto", ""+productoContratadoFrecSess.getNumFrecuentesPermitidos());
			    session.setAttribute("identificadorProducto", identificadorProducto);
			    session.setAttribute("numCelAbonado",""+abonado.getNumCelular() );
			    //log2(CLASS_NAME+"productosContratadosFrecSess "+productosContratadosFrecSess.length);
			    //log2(CLASS_NAME+"numFrecDeOtrosProductos "+numFrecDeOtrosProductos.size());
			    //log2(CLASS_NAME+"maxNumProducto "+productoContratadoFrecSess.getNumFrecuentesPermitidos());
			    //log2(CLASS_NAME+"arrTipos.size() "+arrTipos.size());
			    //log2(CLASS_NAME+"correlativo "+correlativo);
			    //log2(CLASS_NAME+"codPadrePaq "+codPadrePaq);
			    for(int i=0;i<arrTipos.size();i++)
			    {
			    	//log2(CLASS_NAME+"arrTipos.get(i) "+arrTipos.get(i));
			    }
			    logger.debug(CLASS_NAME+" "+METHOD_NAME+"----------------------------fin------------------------------------>");
				
			    forward ="NumerosFrecuentes";
			    if(volverAProductos)
			    {	    	
			    	forward = "producto";
			    }
				log2(CLASS_NAME+"forward "+forward);
				log2(CLASS_NAME+"----FIN---------------------------->");
				
				}
		catch(Exception e)
		{
			forward="mensajeError";
			request.setAttribute("exception", e.getMessage());
		}		
	    return mapping.findForward(forward);
	}
	
	public void log2(Object o)
	{
		
	}
}
