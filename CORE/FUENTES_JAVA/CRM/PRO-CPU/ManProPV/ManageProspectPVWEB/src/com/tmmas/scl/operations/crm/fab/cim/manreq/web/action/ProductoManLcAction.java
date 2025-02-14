package com.tmmas.scl.operations.crm.fab.cim.manreq.web.action;

import java.util.ArrayList;
import java.util.Iterator;
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

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ConversionDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ConversionListDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.framework.marketSalesDomain.contactLeadProspectABE.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ParametroSerializableDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.CargoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.DescuentoProductoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoListDTO;
import com.tmmas.scl.operations.crm.f.sel.negsal.helper.NegSalUtils;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.AbonadoFrmkDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.CargoWebDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.exception.ManReqException;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate.ManageRequestBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.BitaForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.CargosForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.ProductoForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.Global;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.NavegacionWeb;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.PaqueteWeb;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.ProductoWeb;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.ProductosContradosFrecUtil;

public class ProductoManLcAction extends Action {
	
	
	private final Logger logger = Logger.getLogger(ProductoManLcAction.class);
	
	  private ProductoForm productoForm;
	  
	  private ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();
	  public ActionForward execute(
		ActionMapping mapping,
		ActionForm form,
		HttpServletRequest request,
		HttpServletResponse response) throws Exception
	  {

		  	productoForm = (ProductoForm) form;
			ProductoContratadoListDTO productoContratadoListDesc = null;//TODO revisar si se pasa nulo o new en caso de traer datos
			ProductoOfertadoListDTO   productoOfertadoListCont = null;;

			
			HttpSession session = request.getSession(false);

			AbonadoFrmkDTO abonado = (AbonadoFrmkDTO) session.getAttribute("Abonado");
			NavegacionWeb navegacion = (NavegacionWeb) session.getAttribute("navegacion");
			
		    ClienteOSSesionDTO sessionData = new ClienteOSSesionDTO();
		    sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");

		    sessionData.setCargosObtenidos(null);//AGREGAR 191208
		    CargosForm cargosForm = new CargosForm();
		    session.setAttribute("CargosForm",null);
			String retornoFW="flujoManLc";
			//System.out.println("ProductoAction getIdProducto "+productoForm.getIdProducto());
			
			//antes de ir a una opcion de producto guardo los productos que fueron chequeados
			navegacion.setPagina("productos"); //<-- para que guarde los productos
			navegacion.setAccion(BitaForm.ACEPTAR);	
			navegacion.setIdPagina(String.valueOf(abonado.getIdAbonado()));
			
			String bitac = (String) request.getParameter("bitac");
			String bita = (String) request.getParameter("bita");
			
			String bitacorad = productoForm.getBitacorad();//(String) request.getParameter("bitacora");
			String bitacorac = productoForm.getBitacorac();//(String) request.getParameter("bitacorac");
			
			String bitacoraAux = request.getParameterValues("bitacoraLcDef")[0];
			
			if(bitacoraAux!=null)
			navegacion.setBitacoraDef(bitacoraAux);
			
			String[] limConsumoCodigos = request.getParameterValues("combo_lc");

			//bitacorad = bita;
			//bitacorac = bitac;
			String idControlCh = (String) request.getParameter("idControlCh");
			String[] cantidades=null;
			String cantidadesP=null;//[]
			if ((bitacorad!=null && bitacorad.trim().length()>0) || (bitacorac!=null && bitacorac.trim().length()>0)){
				
				//recupero los productos contratados a descontratar y los ofertables a contratar o modificar

				ArrayList prodContratados = obtieneArrProdContratados(bitacorac);
				ArrayList prodDisponibles = obtieneArrProdDisponibles(bitacorad,cantidades);
				//si existen productos ofertables chequeados
				navegacion.setBitacora(bitacorad);
				navegacion.setBitacorac(bitacorac);
				AbonadoFrmkDTO abonadoFrmk = (AbonadoFrmkDTO)session.getAttribute("Abonado");
				PaqueteWeb productos = navegacion.getPaqueteWeb(""+abonadoFrmk.getIdAbonado());
				productoContratadoListDesc = obtenerProdContADescontratar(productos,prodContratados,""+sessionData.getNumOrdenServicio());
				productoContratadoListDesc.setNumEvento(obtieneNumEvento(sessionData));
				if(bitacorad!=null && bitacorad.trim().length()>0)
				{
					cantidades = request.getParameterValues("cantidades");
					if(cantidades == null)
					{
						cantidadesP = request.getParameter("cantidadesP");
						cantidades = cantidadesP.split("|");
					}
					
					productoOfertadoListCont = obtenerProductosPorId(productos.getProductosDisponible(), bitacorad,cantidades);
					//productoOfertadoListCont.s
					//productoOfertadoListCont = obtenerProdOferAContratar(productos,prodDisponibles,cantidades);
				}
				//grabo los que fueron chequeados
				navegacion.Grabar();
				// y luego le asigno sus cantidades
				//navegacion.setCantidadesPorProductoOfertado(String.valueOf(abonado.getIdAbonado()),cantidades,productoOfertadoListCont);
				//navegacion.setLCPorProductoOfertado(String.valueOf(abonado.getIdAbonado()),limConsumoCodigos);//111209 revisar al retomar ooss
				//navegacion.setLCPorProductoContratado(String.valueOf(abonado.getIdAbonado()));
			}else
			{
				//esto ocurre cuando no existe ningun producto ofertable checkeado 
				//pero igual se debe "grabar", que nada fue seleccionado
				navegacion.Grabar();
				
				if(bitacoraAux!=null && bitacoraAux.trim().length()>0);
				//navegacion.setLCPorProductoContratado(String.valueOf(abonado.getIdAbonado()));
			}
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
			//System.out.println("ProductoAction IMPRIMIENDO PROD CONTRATADO A DESCONTRATAR");
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
		
		private ProductoOfertadoListDTO obtenerProdOferAContratar(PaqueteWeb productos,ArrayList prodOfertados, String[] cantidades)
		{
			ProductoOfertadoListDTO retorno = new ProductoOfertadoListDTO();
			ProductoOfertadoListDTO productoOfertadoList =productos.getProductosOfer();
			ProductoOfertadoDTO[] productoOfertadoArr=productoOfertadoList.getProductoList();//abonadoFrmk.getProductoContratados();
			ProductoOfertadoDTO[] productoOfertadoDescArr = obtenerProdOferSeleccionados(productoOfertadoArr,prodOfertados);
			retorno.setProductoList(productoOfertadoDescArr);
			System.out.println("ProductoAction IMPRIMIENDO PROD OFERTADO A CONTRATAR");
			for(int i=0;i<productoOfertadoDescArr.length;i++)
			{
				ProductosContradosFrecUtil.imprimeProdOfer(productoOfertadoDescArr[i], "revisarPadre");
				System.out.println("cantidades["+i+"] "+cantidades[i]);
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
			System.out.println("obtenerProductosPorId productosSel.size() "+productosSel.size()+"   ----------------------->");
			
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
