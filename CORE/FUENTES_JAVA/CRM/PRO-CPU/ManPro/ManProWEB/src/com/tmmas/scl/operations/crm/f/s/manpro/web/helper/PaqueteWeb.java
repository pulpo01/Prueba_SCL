package com.tmmas.scl.operations.crm.f.s.manpro.web.helper;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.DatosEnvioCorreoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.CatalogoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PaqueteDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PaqueteListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoListDTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.LimiteConsumoPlanAdicionalDTO;
import com.tmmas.scl.operations.crm.f.s.manpro.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.f.s.manpro.frmk.dataTransferObject.ProductoContratadoFrecDTO;
import com.tmmas.scl.operations.crm.f.s.manpro.frmk.dataTransferObject.SeccionDTO;
import com.tmmas.scl.operations.crm.f.s.manpro.frmk.dataTransferObject.ValoresDefectoPaginaDTO;
import com.tmmas.scl.operations.crm.f.s.manpro.frmk.exception.ManProException;
import com.tmmas.scl.operations.crm.f.s.manpro.web.delegate.ManageProspectBussinessDelegate;
import com.tmmas.scl.operations.crm.f.sel.negsal.helper.NegSalUtils;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.exception.ManReqException;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ParametroDTO;

public class PaqueteWeb  {

	private final Logger logger = Logger.getLogger(PaqueteWeb.class);
	private Global global = Global.getInstance();
	private ArrayList productoDisponibles;
	private ArrayList productoPorDefecto;
	private boolean tienePDTporDefecto = false;
	private ProductoWeb pro;
	private AbonadoDTO abonado;	
	private ArrayList listaProducNoNumFreq = new ArrayList();
	private ArrayList listaProducNumFreq  = new ArrayList();
	private HashMap productosClienteAfines = new HashMap();
	private HashMap parametrosCorreo = new HashMap();
	private ProductoContratadoFrecDTO[] productoContratadoFrecDTO = null;
	private AbonadoDTO abonadoDTO;
	//CTH
	private ProductoOfertadoListDTO productosOfertadosAbonado;
	private PaqueteListDTO  paquetesOfertadosAbonado;
	private boolean b;
	private ManageProspectBussinessDelegate delegate;
	private ClienteOSSesionDTO clienteSesion;
	
	/**
	 *   PaqueteWEB 
	 *   
	 *   Esta clase guarda todos los cambios por abonado; es decir, todos los 
	 *   productos y paquetes relacionados al id del abonado o cliente..
	 *   
	 *   Tambien genera los metodos necesarios para las validaciones que necesite
	 *   cada producto y que pueda necesitar por ende la clase NavegacionWeb.java
	 * @param codVendedor 
	 * @throws Exception 
	 * 
	 * */
	
	public PaqueteWeb(AbonadoDTO abonado, String codVendedor, ClienteOSSesionDTO clienteSesion) throws Exception 
	{
		ArrayList productosOfertados=new ArrayList();
		
		this.clienteSesion = clienteSesion;
		this.abonadoDTO = abonado;
//		solo se llama al creador de esta clase, cuando es la primera vez que se visitan los productos de un abonado o cliente
		ProductoOfertadoListDTO retorno=new ProductoOfertadoListDTO();			
		//ProductoOfertadoListDTO dtoEntrada=new ProductoOfertadoListDTO();
		delegate=ManageProspectBussinessDelegate.getInstance();
		//abonado=new AbonadoDTO();
		//abonado.setNumAbonado(idAbonado);	
		//abonado=delegate.obtenerDatosAbonado(abonado);
		
		//PlanTarifarioDTO planTarifario= new PlanTarifarioDTO();
		CatalogoDTO catalogo=new CatalogoDTO();
		Calendar cal= Calendar.getInstance();                
        cal.set(3000,11,31);               
        catalogo.setCodCanal("VT");
        catalogo.setFecInicioVigencia(new Date());
        catalogo.setFecTerminoVigencia(new Date(cal.getTimeInMillis()));
       // catalogo.setFecTerminoVigencia(new SimpleDateFormat("dd-MM-yyyy").parse("30-12-3000"));
        logger.debug("["+catalogo.getFecTerminoVigencia()+"]");
        catalogo.setIndNivelAplica(abonado.getNumAbonado()!=0?"A":"C");
        catalogo.setCodVendedor(codVendedor);      
        /*VMB INC 155400 18112010*/
        catalogo.setNumAbonado(abonado.getNumAbonado()+"");
        catalogo.setCodCliente(abonado.getCodCliente()+"");
        logger.debug("catalogo.getNumAbonado "+catalogo.getNumAbonado());
        logger.debug("catalogo.getCodCliente "+catalogo.getCodCliente());
        //FIN
        abonado.setCatalogo(catalogo);
		
		retorno=delegate.obtenerProductosPorDefecto(abonado); 		// producto por OFERTABLES
		for(int i=0;i<retorno.getProductoList().length;i++)
		{
			retorno.getProductoList()[i].setCodCliente(abonado.getCodCliente());
		}

		//Limites de consumo para productos porDefecto		
		retorno = delegate.obtenerLCplanAdicional(retorno);

		if(retorno.getProductoList().length > 0) tienePDTporDefecto = true;
		productoPorDefecto = new ArrayList();
		productoDisponibles = new ArrayList();
		
		//logger.debug(" retorno.getProductoList().length "+retorno.getProductoList().length);
		
		
		
		
		for (int p = 0;p<retorno.getProductoList().length;p++)
		{
			ProductoOfertadoDTO productoX = retorno.getProductoList()[p];
			pro = new  ProductoWeb(productoX);
			pro.aplicarElementoSeleccionado(); //inicializa producto Seleccionado
			discriminaNumFrec(pro);
			pro.setChequeado(true);
			pro.setCodPadre(String.valueOf(abonado.getNumAbonado()));
			/***
			 * @author rlozano
			 * @description se agrega filtro para mostrar los correspondientes paquetes por defecto. Si ingresa por Abonado sólo paquetes 
			 * por defecto por abonado y de la misma forma para cliente
			 * @date 16-01-2007 
			 */ 
			if (productoX.getIndAplica().equals(catalogo.getIndNivelAplica()))
			{
				productoPorDefecto.add(pro);
				configurarLC(pro,null,null);//productoCX.getlimiteConsumoContratado()
			}
			
			try{
				if (productoX.getEspecificacionProducto()
				.getEspecServicioClienteList().getEspecSerLisList()
				.getEspecServicioListaList()[0].getIndAutoAfinidad()
				.equals("S")){
					agregarAutoAfin("D." + String.valueOf(abonado.getNumAbonado())+ "." + pro.getCorrelativo());
				}
			}catch(Exception e)
			{
				
			}
			
			productosOfertados.add(productoX);
		}
			
        //paquete.setCodProdPadre(abonado.getPlanTarifario().getPaqueteDefault().getCodProdPadre());
		//boolean isExistCodTipPlan=abonado.getCodTipPlan()==null||"".equals(abonado.getCodTipPlan())?false:true;
		/***
		 * @author rlozano
		 * @description Se verifica si el abonado pertenece a un cliente individual o empresa si es individual no debe ir a buscar
		 * los productos ofertables por defecto.
		 */
		ProductoOfertadoListDTO productosOfertables=null;
		//if (isExistCodTipPlan)
		productosOfertables = delegate.obtenerProductosOfertables(abonado);	// producto por OFERTABLES
		
		logger.debug("abonado.getCatalogo().getCodCanal()"+abonado.getCatalogo().getCodCanal());
		logger.debug("abonado.getCatalogo().getFecInicioVigencia()"+abonado.getCatalogo().getFecInicioVigencia());
		logger.debug("abonado.getCatalogo().getFecTerminoVigencia()"+abonado.getCatalogo().getFecTerminoVigencia());
		logger.debug("abonado.getCatalogo().getIndNivelAplica()"+abonado.getCatalogo().getIndNivelAplica());
		logger.debug("abonado.getCatalogo().getCodVendedor()"+abonado.getCatalogo().getCodVendedor());
		logger.debug("abonado.getNumAbonado()"+abonado.getNumAbonado());
		logger.debug("productosOfertables.getProductoList().length="+productosOfertables.getProductoList().length);
        
		//(+)Limites de consumo para productos ofertados
		for(int i=0;i<productosOfertables.getProductoList().length;i++)
		{
			productosOfertables.getProductoList()[i].setCodCliente(abonado.getCodCliente());
		}
		productosOfertables = delegate.obtenerLCplanAdicional(productosOfertables);
		//(-)Limites de consumo para productos ofertados
		
		//(+)-- Correo Movistar
		HashMap parametrosCorreo = obtenerParametrosCorreo();
		this.parametrosCorreo = parametrosCorreo;
		
		productosOfertables = filtrarCorreo(productosOfertables, abonado.getCodPlanTarif());
		//(-)-- Correo Movistar

		String tipoComp = "";
		for (int p = 0;(productosOfertables!=null)&&p<productosOfertables.getProductoList().length;p++){
			ProductoOfertadoDTO productoX = productosOfertables.getProductoList()[p];
			
			//CTH guardar producto ofertado			
			productosOfertados.add(productoX);
			
			ProductosContradosFrecUtil.imprimeProdOfer(productoX, null);
			if (productoX.getIndPaquete().equals("1"))
			{
//				TODO: ver si esta rutina conviene meterla dentro del ProductoWeb o no;
				
				if (true)
				{
					//se eliminan los paquetes 240510
					logger.debug("No se agrega PAQ["+productoX.getIdentificadorProductoOfertado()+"]");
					continue;
				}
				
				PaqueteDTO paqueteDeProducto=new PaqueteDTO();	
				paqueteDeProducto.setCodProdPadre(productoX.getIdProductoOfertado());
				ProductoOfertadoListDTO detallePaq = delegate.obtenerProductosOfertablesPorPaquete(paqueteDeProducto);
				pro = new  ProductoWeb(productoX);
				
				//creo el producto paquete
				pro.setSizePaq(detallePaq.getProductoList().length);
				pro.setCodPadre(String.valueOf(abonado.getNumAbonado()));
				productoDisponibles.add(pro);			
				logger.debug(" * * * * * *ENTRO A LOS PAQUETES ");
				for (int ppaq = 0;ppaq<detallePaq.getProductoList().length;ppaq++){
					ProductoOfertadoDTO productoPPAQ = detallePaq.getProductoList()[ppaq];
					ProductoWeb ppaqWeb = new ProductoWeb(productoPPAQ);
					//asocio los productos hijos con el producto padre
					ppaqWeb.setCodPadre(productoX.getIdProductoOfertado());
					ProductosContradosFrecUtil.imprimeProdOfer(productoPPAQ,productoX.getIdProductoOfertado());
					//separa productos de numeros frecuentes para hijos de un producto paquete
					discriminaNumFrec(ppaqWeb);
					//discriminaNumFrec(productoPPAQ);

					try{
						if (productoPPAQ.getEspecificacionProducto()
						.getEspecServicioClienteList().getEspecSerLisList()
						.getEspecServicioListaList()[0].getIndAutoAfinidad()
						.equals("S")){
							//agregarAutoAfin("O." + String.valueOf(abonado.getNumAbonado())+ "." + ppaqWeb.getCorrelativo());
							
							/* INICIO MIX-09003 VMB 16102010
							 * Se modifica para diferenciar los planes adicionales, D (Default) // O (Opcionales)
							 * y al momento de guardar la información, esta se almacene con la informacion correspondiente 
							 * */
							logger.debug(" * * * * * *SI ES PAQUETE* * * * * * * * * * * "  );
							logger.debug("pro.getTipoPlanAdic() = " + pro.getTipoPlanAdic() );
							logger.debug("pro.getNombre()       = " + pro.getNombre() );
							
							if ("2".equals(pro.getTipoPlanAdic())){ //MIX-09003 VMB 16102010
								agregarAutoAfin("B." + String.valueOf(abonado.getNumAbonado())+ "." + pro.getCorrelativo()); //MIX-09003 VMB 16102010
							}else{
								agregarAutoAfin("O." + String.valueOf(abonado.getNumAbonado())+ "." + pro.getCorrelativo());
							}
							
						}
					}catch(Exception e)
					{
						
					}					
					configurarLC(ppaqWeb,null,null);
					productoDisponibles.add(ppaqWeb);			
				}
			}
			else
			{
				tipoComp = productoX.getEspecificacionProducto().getTipoComportamiento();
				pro = new  ProductoWeb(productoX);
				//en caso que el productoweb no sea de ningun paquete, su codpadre es el abonado
				pro.setCodPadre(String.valueOf(abonado.getNumAbonado()));
				

				
				//separa productos de numeros frecuentes para producto
				discriminaNumFrec(pro);
				//discriminaNumFrec(productoX);
				
				//la agrego para identificar un idproducto con un listado de num
				try{
					
					logger.debug("productoX.getEspecificacionProducto()......... -->"+
							productoX.getEspecificacionProducto().getEspecServicioClienteList().getEspecSerLisList()
					.getEspecServicioListaList()[0].getIndAutoAfinidad());
					
					if (productoX.getEspecificacionProducto()
					.getEspecServicioClienteList().getEspecSerLisList()
					.getEspecServicioListaList()[0].getIndAutoAfinidad()
					.equals("S")){
						
						
						/* INICIO MIX-09003 VMB 16102010
						 * Se modifica para diferenciar los planes adicionales, D (Default) // O (Opcionales)
						 * y al momento de guardar la información, esta se almacene con la informacion correspondiente 
						 * */
						logger.debug(" * * * * * *NO ES PAQUETE* * * * * * * * * * * "  );
						logger.debug("pro.getTipoPlanAdic() = " + pro.getTipoPlanAdic() );
						logger.debug("pro.getNombre()       = " + pro.getNombre() );
						
						if ("2".equals(pro.getTipoPlanAdic())){ //MIX-09003 VMB 16102010
							agregarAutoAfin("B." + String.valueOf(abonado.getNumAbonado())+ "." + pro.getCorrelativo()); //MIX-09003 VMB 16102010
						}else{
							agregarAutoAfin("O." + String.valueOf(abonado.getNumAbonado())+ "." + pro.getCorrelativo());
						}
					}
				}catch(Exception e)
				{
					
				}
				configurarLC(pro,null,null);
				
				//(+) EV 05-04-2010 Datos correo movistar
				String idEspecProvision = "";
				try{
					idEspecProvision = productoX.getEspecificacionProducto().getEspecServicioClienteList().getEspServCliList()[0].getIdEspecProvision();
					if (VentaUtils.esCorreoSeven(this.parametrosCorreo, idEspecProvision)){
						logger.debug("idEspecProvision="+idEspecProvision+"es correo seven");
						pro.setIdEspecProvision(idEspecProvision);
						pro.setModificable(1);
					}
				}catch(Exception e){};
				//(-) EV 05-04-2010 Datos correo movistar
				
				productoDisponibles.add(pro);
			}	
		}
		//guardar a nivel de abonado clases utiles para numfrec
		ProductosContradosFrecUtil pfu = new ProductosContradosFrecUtil();
		productoContratadoFrecDTO = pfu.generaProductoContratadoList(listaProducNumFreq, listaProducNoNumFreq,abonado.getCodCliente(),abonado.getNumAbonado());
		
		/**
		 * CTH Separando y guardando los productos ofertados
		 */	
		productosOfertadosAbonado=new ProductoOfertadoListDTO();
		ProductoOfertadoDTO[] productos=(ProductoOfertadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(productosOfertados.toArray(), ProductoOfertadoDTO.class);
		productosOfertadosAbonado.setProductoList(productos);
		
		abonado.setProdOfertList(productosOfertadosAbonado);		
		NegSalUtils negSalUtils=NegSalUtils.getInstance();
		abonado=negSalUtils.splitProductosPaquetes(abonado);		

		for(int i=0;i<abonado.getPaqueteList().getPaqueteList().length;i++)
		{
			ProductoOfertadoListDTO productosDePaquete=delegate.obtenerProductosOfertablesPorPaquete(abonado.getPaqueteList().getPaqueteList()[i]);
			abonado.getPaqueteList().getPaqueteList()[i].setProductoList(productosDePaquete);			
		}
		
		this.abonado=abonado;
		productosOfertadosAbonado=abonado.getProdOfertList();
		paquetesOfertadosAbonado=abonado.getPaqueteList();
		
	}

	//(+) 31/03/2010 EV - PV Correo Movistar---------------------------------------------------------------------------
	
	private ProductoOfertadoListDTO filtrarCorreo(ProductoOfertadoListDTO productosOfertables, String codPlanTarif) throws Exception {
		ArrayList productosOfert  = new ArrayList();
		ArrayList productosOfert1 = new ArrayList();
		ArrayList productosOfert2correoSeven = new ArrayList();
		ArrayList productosOfert3serviciosCISeven = new ArrayList();
		ArrayList productosOfert4serviciosILSeven = new ArrayList();
		ArrayList productosOfert5serviciosISSeven = new ArrayList();		
		ArrayList productosOfert6correoBB = new ArrayList();
		ArrayList productosOfert7serviciosCIBB = new ArrayList();
		ArrayList productosOfert8serviciosISBB = new ArrayList();
		
		ProductoOfertadoDTO[] productos=null;
		ProductoOfertadoDTO dto=null;
		String idEspecProvision = null;
		boolean esPlanCorreo     = false;
		boolean esPlanCompartido = false;
		
		if (codPlanTarif!=null && !codPlanTarif.equals("")){
			PlanTarifarioDTO planTarif= delegate.obtenerDatosPlanTarifario(codPlanTarif);
			esPlanCompartido = (planTarif.getIndCompartido()==1)?true:false;
		}
	
		logger.debug("Plan Tarifario = " + codPlanTarif);
		logger.debug("esPlanCompartido = " + esPlanCompartido);
		
		String x1 		= (String) parametrosCorreo.get("X1");//seven customer edition
		String x8 		= (String) parametrosCorreo.get("X8");//blackberry individual
		String x9 		= (String) parametrosCorreo.get("X9");//blackberry profesional
		String srvSevCI = (String) parametrosCorreo.get("sev.ci");//cuota instalacion
		String srvSevIL = (String) parametrosCorreo.get("sev.il");//instalacion licencia
		String srvSevIS = (String) parametrosCorreo.get("sev.is");//instalacion servidores
		String srvBBCI  = (String) parametrosCorreo.get("bb.ci");//cuota instalacion
		String srvBBIS  = (String) parametrosCorreo.get("bb.is");//instalacion servidores
		
		for(int i=0;i<productosOfertables.getProductoList().length;i++)
		{
			dto = productosOfertables.getProductoList()[i];
			
			if(dto.getEspecificacionProducto() == null || 
			   dto.getEspecificacionProducto().getEspecServicioClienteList()                        == null ||
			   dto.getEspecificacionProducto().getEspecServicioClienteList().getEspServCliList()	== null ||
			   dto.getEspecificacionProducto().getEspecServicioClienteList().getEspServCliList()[0] == null){
				logger.debug("Producto sin EspecProd ["+dto.getIdentificadorProductoOfertado()+"]");
				productosOfert.add(dto);
				continue;
			}
			idEspecProvision = dto.getEspecificacionProducto().getEspecServicioClienteList().getEspServCliList()[0].getIdEspecProvision();
			
			esPlanCorreo = esCorreo(parametrosCorreo, idEspecProvision);
			
			dto = agregaInformacionEnvioCorreo(dto,idEspecProvision);
			
			if(!esPlanCorreo)// si no es pa correo movistar, se agrega
			{
				if (srvSevCI.equals(idEspecProvision) && !esPlanCompartido){//cuota instalacion
					productosOfert3serviciosCISeven.add(dto);
					
				}else if (srvSevIL.equals(idEspecProvision) && esPlanCompartido){ //inst licencia
					productosOfert4serviciosILSeven.add(dto);
					
				}else if (srvSevIS.equals(idEspecProvision) && esPlanCompartido){ //inst servidores
					productosOfert5serviciosISSeven.add(dto);
					
				}else if(srvBBCI.equals(idEspecProvision) && !esPlanCompartido){//cuota instalacion
					productosOfert7serviciosCIBB.add(dto);
					
				}else if(srvBBIS.equals(idEspecProvision) && esPlanCompartido){//inst servidores
					productosOfert8serviciosISBB.add(dto);
					
				}else{
					productosOfert1.add(dto);//otros PA
				}

			}else 
			{   //si es plan tarifario individual y idEspecProv in (x1,x8,x9), se agrega
				logger.debug("Es plan Correo Movistar, idEspecProvision="+idEspecProvision);
				if(!esPlanCompartido)				
				{
					if  (x1.equals(idEspecProvision) ){
						productosOfert2correoSeven.add(dto); //correo seven
					}else if (x8.equals(idEspecProvision) || x9.equals(idEspecProvision)){
						productosOfert6correoBB.add(dto); //correo blackberry
					}	
				}
			}
		}//fin for
			
		//ordena listas
		productosOfert.addAll(productosOfert1);//pa comun
		productosOfert.addAll(productosOfert2correoSeven);//x1
		productosOfert.addAll(productosOfert3serviciosCISeven);
		productosOfert.addAll(productosOfert4serviciosILSeven);
		productosOfert.addAll(productosOfert5serviciosISSeven);
		productosOfert.addAll(productosOfert6correoBB);//x8,x9
		productosOfert.addAll(productosOfert7serviciosCIBB);
		productosOfert.addAll(productosOfert8serviciosISBB);
		
		productos=(ProductoOfertadoDTO[])ArrayUtl.copiaArregloTipoEspecifico(productosOfert.toArray(), ProductoOfertadoDTO.class);
		productosOfertables.setProductoList(productos);
		return productosOfertables;
	}
	
	private HashMap obtenerParametrosCorreo() throws Exception {
		
		String parametro;
		ParametroDTO paramGral = null;
		ParametroDTO param = new ParametroDTO();
		HashMap hm = new HashMap();
		param.setCodModulo(global.getValor("codigo.modulo.GA").trim());
		param.setCodProducto(Integer.parseInt(global.getValor("codigo.producto").trim())); 
		
		for(int i=1;i<11;i++)
		{
			parametro = global.getValor("correo.mov.x"+i);
			param.setNomParametro(parametro.trim());
			paramGral = delegate.obtenerParametroGeneral(param);
			hm.put("X"+i, paramGral.getValor());
		}
		String paramCorreo = "correo.mov.";
		String [] parametros = {"sev.ci", "sev.il", "sev.is", "bb.ci", "bb.is"};
		for(int i=0;i<parametros.length;i++)
		{
			parametro = global.getValor(paramCorreo+(parametros[i]));
			param.setNomParametro(parametro.trim());
			paramGral = delegate.obtenerParametroGeneral(param);
			hm.put(parametros[i], paramGral.getValor());
		}
		imprimeHMCorreo(hm);
		return hm;
	}
	
	private void imprimeHMCorreo(HashMap hm) {
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
	
	private boolean esCorreo(HashMap hm, String idEspecProvision) {
		boolean retorno = false;
		String valor = null;
		for(int i=1;i<11;i++){
			valor = (String) hm.get("X"+i);
			if(valor.equals(idEspecProvision)){
				retorno = true;
				logger.debug("PA X"+i+"[cod_prov_serv = "+valor+"]");
				break;
			}
		}

		return retorno;
	}

	//(+) completa informacion de envio de correos
	private ProductoOfertadoDTO agregaInformacionEnvioCorreo(ProductoOfertadoDTO prodOfer, String idEspecProvision){
		
	    ParseoXML objetoXML=new ParseoXML();
	    ValoresDefectoPaginaDTO objetoXMLSession = this.clienteSesion.getValoresDefecto();
	    SeccionDTO seccion=new SeccionDTO();
	    
		String idEspecProvCSevenInstLicencias  = (String) parametrosCorreo.get("sev.il");
		String idEspecProvCSevenInstServidores = (String) parametrosCorreo.get("sev.is");
		String idEspecProvCBBInstServidores    = (String) parametrosCorreo.get("bb.is");
		String idEspecProvCBBIndividual        = (String) parametrosCorreo.get("X8");
		String idEspecProvCBBProfesional       = (String) parametrosCorreo.get("X9");
		String idEspecProvCBBCorporativo       = (String) parametrosCorreo.get("X10");
		
		String codigoLSE = global.getValor("codigo.correo.mov.sev.il");
		String codigoSSE = global.getValor("codigo.correo.mov.sev.is");
		String codigoSBB = global.getValor("codigo.correo.mov.bb.is");
		String codigoCBB = global.getValor("codigo.correo.blackberry");
		
		String tipoBBindividual = global.getValor("correo.blackberry.individual");
		String tipoBBprofesional = global.getValor("correo.blackberry.profesional");
		String tipoBBcorporativo = global.getValor("correo.blackberry.corporativo");		
		
		DatosEnvioCorreoDTO datosEnvioCorreoDTO = null;
	    
		if (idEspecProvCSevenInstLicencias.equals(idEspecProvision)){//SEVEN instalacion licencias
			datosEnvioCorreoDTO = new DatosEnvioCorreoDTO();
			datosEnvioCorreoDTO.setCodCorreo(codigoLSE);
		    seccion = objetoXML.obtenerSeccion(objetoXMLSession, "registroOS", "correoSevenInstLicencias");
		    if (seccion !=null) {
		    	if (seccion.obtControl("asunto")!=null && seccion.obtControl("asunto").getValorDefecto()!=null)
		    		datosEnvioCorreoDTO.setSubject(seccion.obtControl("asunto").getValorDefecto());
		    	
		    	if (seccion.obtControl("mensaje")!=null && seccion.obtControl("mensaje").getValorDefecto()!=null)
		    		datosEnvioCorreoDTO.setBody(seccion.obtControl("mensaje").getValorDefecto());
		    }
		}
		else 
		if (idEspecProvCSevenInstServidores.equals(idEspecProvision)){//SEVEN instalacion servidores
			datosEnvioCorreoDTO = new DatosEnvioCorreoDTO();
			datosEnvioCorreoDTO.setCodCorreo(codigoSSE);
		    seccion = objetoXML.obtenerSeccion(objetoXMLSession, "registroOS", "correoSevenInstServidores");
		    if (seccion !=null) {
		    	if (seccion.obtControl("asunto")!=null && seccion.obtControl("asunto").getValorDefecto()!=null)
		    		datosEnvioCorreoDTO.setSubject(seccion.obtControl("asunto").getValorDefecto());
		    	
		    	if (seccion.obtControl("mensaje")!=null && seccion.obtControl("mensaje").getValorDefecto()!=null)
		    		datosEnvioCorreoDTO.setBody(seccion.obtControl("mensaje").getValorDefecto());
		    }
		}			
		else 
		if (idEspecProvCBBInstServidores.equals(idEspecProvision)){//BlackBerry instalacion servidores
			datosEnvioCorreoDTO = new DatosEnvioCorreoDTO();
			datosEnvioCorreoDTO.setCodCorreo(codigoSBB);
		    seccion = objetoXML.obtenerSeccion(objetoXMLSession, "registroOS", "correoBlackBerryInstServidores");
		    if (seccion !=null) {
		    	if (seccion.obtControl("asunto")!=null && seccion.obtControl("asunto").getValorDefecto()!=null)
		    		datosEnvioCorreoDTO.setSubject(seccion.obtControl("asunto").getValorDefecto());
		    	
		    	if (seccion.obtControl("mensaje")!=null && seccion.obtControl("mensaje").getValorDefecto()!=null)
		    		datosEnvioCorreoDTO.setBody(seccion.obtControl("mensaje").getValorDefecto());
		    }
		}			
		else 
		if (idEspecProvCBBIndividual.equals(idEspecProvision)){//BlackBerry Individual
			datosEnvioCorreoDTO = new DatosEnvioCorreoDTO();
			datosEnvioCorreoDTO.setCodCorreo(codigoCBB);
			datosEnvioCorreoDTO.setTipoBlackBerry(tipoBBindividual);
		    seccion = objetoXML.obtenerSeccion(objetoXMLSession, "registroOS", "correoBlackBerryContrIndividual");
		    if (seccion !=null) {
		    	if (seccion.obtControl("asunto")!=null && seccion.obtControl("asunto").getValorDefecto()!=null)
		    		datosEnvioCorreoDTO.setSubject(seccion.obtControl("asunto").getValorDefecto());
		    	
		    	if (seccion.obtControl("mensaje")!=null && seccion.obtControl("mensaje").getValorDefecto()!=null)
		    		datosEnvioCorreoDTO.setBody(seccion.obtControl("mensaje").getValorDefecto());
		    }
		}		    	    
		else 
		if (idEspecProvCBBProfesional.equals(idEspecProvision)){//BlackBerry Profesional
			datosEnvioCorreoDTO = new DatosEnvioCorreoDTO();
			datosEnvioCorreoDTO.setCodCorreo(codigoCBB);
			datosEnvioCorreoDTO.setTipoBlackBerry(tipoBBprofesional);
		    seccion = objetoXML.obtenerSeccion(objetoXMLSession, "registroOS", "correoBlackBerryContrProfesional");
		    if (seccion !=null) {
		    	if (seccion.obtControl("asunto")!=null && seccion.obtControl("asunto").getValorDefecto()!=null)
		    		datosEnvioCorreoDTO.setSubject(seccion.obtControl("asunto").getValorDefecto());
		    	
		    	if (seccion.obtControl("mensaje")!=null && seccion.obtControl("mensaje").getValorDefecto()!=null)
		    		datosEnvioCorreoDTO.setBody(seccion.obtControl("mensaje").getValorDefecto());
		    }
		}

		if (datosEnvioCorreoDTO!=null){
			datosEnvioCorreoDTO.setNumVenta(this.clienteSesion.getNumVenta());
			datosEnvioCorreoDTO.setBody(prodOfer.getDesProdOfertado()+"\n"+datosEnvioCorreoDTO.getBody());
			
			prodOfer.setDatosEnvioCorreo(datosEnvioCorreoDTO);
			prodOfer.setEnviaCorreo(true);
			logger.debug("---- PA con envio de correo ----------");	
			logger.debug("idEspecProvision="+idEspecProvision);			
			logger.debug("datosEnvioCorreoDTO.getNumVenta()="+datosEnvioCorreoDTO.getNumVenta());
			logger.debug("datosEnvioCorreoDTO.getCodCorreo()="+datosEnvioCorreoDTO.getCodCorreo());
			logger.debug("datosEnvioCorreoDTO.getTipoBlackBerry()="+datosEnvioCorreoDTO.getTipoBlackBerry());
			logger.debug("datosEnvioCorreoDTO.getSubject()="+datosEnvioCorreoDTO.getSubject());
			logger.debug("datosEnvioCorreoDTO.getBody()="+datosEnvioCorreoDTO.getBody());
			logger.debug("---- PA con envio de correo ----------");			
			
		}
		return prodOfer;
	}
	
	//(-) 31/03/2010 EV - PV Correo Movistar---------------------------------------------------------------------------
	
	private void configurarLC(ProductoWeb productoWeb, ProductoContratadoDTO productoCX, String lcElementoContratado) {
		ProductoOfertadoDTO productoX = productoWeb.getProductoDTO();
		//ProductoContratadoDTO productoCX = productoWeb.get
		//Producto Contratado - Se rescata LC
		if(lcElementoContratado!=null)
		{ /////if(lcElementoContratado.equals("129")) lcElementoContratado = "123";///test ok
			productoWeb.setCodLimConsuSeleccionado(lcElementoContratado);
			productoWeb.setCodLimConsuInicial(lcElementoContratado);
		}
		productoWeb.setMtoConsumido("0");
		/*esto ya no iria*/
		if(productoX !=null && productoX.getListaLimCons()!=null && productoX.getListaLimCons().getLimitesDeConsumo()!=null &&
		   productoX.getListaLimCons().getLimitesDeConsumo().length > 0 && productoX.getListaLimCons().getLimitesDeConsumo()[0]!=null)
		{
			productoWeb.setMtoConsumido(productoX.getListaLimCons().getLimitesDeConsumo()[0].getMtoConsumido().toString());
		}
		/*120210 esto deberia ser ya que aca están ordenados por IndDefault().equals("S")*/
		LimiteConsumoPlanAdicionalDTO limConsPlanDTO = null;
		if(productoWeb.getListaLimiteConsumoValMto()!=null && 
		   productoWeb.getListaLimiteConsumoValMto().size() > 0 &&
		   productoWeb.getListaLimiteConsumoValMto().get(0)!=null)
		{
			limConsPlanDTO = (LimiteConsumoPlanAdicionalDTO)productoWeb.getListaLimiteConsumoValMto().get(0);
			if(limConsPlanDTO.getMtoConsumido() != null)
			{
				productoWeb.setMtoConsumido(limConsPlanDTO.getMtoConsumido().toString());
			}else
			{
				logger.debug("limConsPlanDTO.getMtoConsumido() -->mto NULL  CodLimCons["+limConsPlanDTO.getCodLimCons()+"]");
				logger.debug("IdentidorProdOfert["+productoWeb.getProductoDTO().getIdentificadorProductoOfertado()+"]");
				logger.debug("IdProductoOfertado["+productoWeb.getProductoDTO().getIdProductoOfertado()+"]");
			}
		}
		/**/
	}

	private void agregarAutoAfin(String codigoAfin) {
		ArrayList arrayAutoAfin = new ArrayList();		
		ClienteDTO clienteDTO= new ClienteDTO();
		clienteDTO.setCodCliente(abonadoDTO.getCodCliente());
		try {
			clienteDTO = delegate.obtenerDatosCliente(clienteDTO);
		} catch (ManProException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		arrayAutoAfin.add(clienteDTO);
		productosClienteAfines.put(codigoAfin, arrayAutoAfin);		
	}


	
	private void discriminaNumFrec(ProductoWeb ppaqWeb){		
		
		try
		{
			ProductoOfertadoDTO prod = (ProductoOfertadoDTO)ppaqWeb.getProductoDTO();
			if (("PFRC").equals(prod.getEspecificacionProducto().getTipoComportamiento())){
					listaProducNumFreq.add(ppaqWeb);
			}
			else
			{
				listaProducNoNumFreq.add(ppaqWeb);
			}
		}
		catch(Exception e)
		{
			logger.error("error PaqueteWeb "+e.getMessage());
			e.printStackTrace();
		}
		
	}

	private boolean existeProducto(ProductoOfertadoDTO productoX)
	{
		ProductoOfertadoDTO productoEnLista = null;
		for(int i=0;i<listaProducNumFreq.size();i++)
		{
			productoEnLista = (ProductoOfertadoDTO)listaProducNumFreq.get(i);
			if(productoEnLista.getIdProductoOfertado().equals(productoX.getIdProductoOfertado()))
			{
				return true;
			}
		}
		return false;
	}

	public ArrayList getProductosContratados() {
		return productoPorDefecto;
	}
	
	public ArrayList getProductosDisponible() {
		return productoDisponibles;
	}

	public void setProductosDisponible(ArrayList productoDisponibles) {
		this.productoDisponibles=productoDisponibles;
	}

	public void setProductoPorDefecto(ArrayList productoPorDefecto) {
		this.productoPorDefecto = productoPorDefecto;
	}

	public ArrayList getListaProducNoNumFreq() {
		return listaProducNoNumFreq;
	}

	public void setListaProducNoNumFreq(ArrayList listaProducNoNumFreq) {
		this.listaProducNoNumFreq = listaProducNoNumFreq;
	}

	public ArrayList getListaProducNumFreq() {
		return listaProducNumFreq;
	}

	public void setListaProducNumFreq(ArrayList listaProducNumFreq) {
		this.listaProducNumFreq = listaProducNumFreq;
	}	

	public ArrayList getProductoPorDefecto() {
		return productoPorDefecto;
	}

	public ProductoContratadoFrecDTO[] getNumFreqProductos() {
		return productoContratadoFrecDTO;
	}
	
	public void setNumFreqProductos(ProductoContratadoFrecDTO[] productoFrec) {
		// TODO Auto-generated method stub
		this.productoContratadoFrecDTO=productoFrec;
	}

	public ArrayList getListaClienteAfines(String idListaAfines) {
		// TODO Auto-generated method stub
		return (ArrayList) productosClienteAfines.get(idListaAfines);
	}	

	public HashMap getTodosClienteAfines() {
		// TODO Auto-generated method stub
		return productosClienteAfines;
	}	
	
	public void setListaClienteAfines(String idListaAfines , ArrayList listaClienteAfines) {
		// TODO Auto-generated method stub
		productosClienteAfines.put(idListaAfines,listaClienteAfines);
	}

	public PaqueteListDTO getPaquetesOfertadosAbonado() {
		return paquetesOfertadosAbonado;
	}

	public ProductoOfertadoListDTO getProductosOfertadosAbonado() {
		return productosOfertadosAbonado;
	}

	public AbonadoDTO getAbonado() {
		return abonado;
	}

	public boolean tienePDTporDefecto() {
		return tienePDTporDefecto;
	}

	public HashMap getParametrosCorreo() {
		return parametrosCorreo;
	}
	
}

/**
 *   PaqueteWEB 
 *   
 *   Esta clase guarda todos los cambios por abonado; es decir, todos los 
 *   productos y paquetes relacionados al id del abonado o cliente..
 *   
 *   Tambien genera los metodos necesarios para las validaciones que necesite
 *   cada producto y que pueda necesitar por ende la clase NavegacionWeb.java
 * 
 * */

