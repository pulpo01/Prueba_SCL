package com.tmmas.scl.operations.crm.fab.cim.manreq.web.action;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.BaseAction;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ConversionDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ConversionListDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroListDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.ParamMantencionAfinesDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ParamObtCargOOSSDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ProdContratadoOfertadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate.ManageRequestBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.ListaProdContratadosForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.Global;

public class FlujoProdContratadosAction extends BaseAction {
	
	private final Logger logger = Logger.getLogger(FlujoProdContratadosAction.class);
	private Global global = Global.getInstance();
	
	private ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();
		
	public ActionForward executeAction(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);
		
		logger.debug("execute():start");
		ListaProdContratadosForm form1 = (ListaProdContratadosForm) form;
		
	    ClienteOSSesionDTO sessionData = new ClienteOSSesionDTO();
	    HttpSession session = request.getSession(false);
	    sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");
	    
	    List productosContratados = (List)session.getAttribute("productosContratados"); // lista que se creo para cargar todos los productos y sus listas de numeros
	    List productosContratadosOriginal = (List)session.getAttribute("productosContratadosListOriginal");
	    
	    SecuenciaDTO secuencia=new SecuenciaDTO();
	    if(sessionData.getNumOrdenServicio()== 0){
			logger.debug("obtenerSecuencia:antes");
			secuencia.setNomSecuencia("CI_SEQ_NUMOS");
			logger.debug("nomSecuencia :"+secuencia.getNomSecuencia());
			secuencia = delegate.obtenerSecuencia(secuencia);
		    sessionData.setNumOrdenServicio(secuencia.getNumSecuencia());
		    logger.debug("obtenerSecuencia:despues");
		}
	    
	    //Felipe Diaz
	    ProductoContratadoListDTO prodContratados = (ProductoContratadoListDTO)session.getAttribute("prodContratado");
	    //Felipe Diaz
	    
	    //ArrayList listaClientesAgregados = session.getAttribute("listaClientesAgregados")==null?null:(ArrayList)session.getAttribute("listaClientesAgregados");
	    //ArrayList listaClientesEliminados = session.getAttribute("listaClientesEliminados")==null?null:(ArrayList)session.getAttribute("listaClientesEliminados");
	    ArrayList listaClientesAgregados = new ArrayList();
	    ArrayList listaClientesEliminados = new ArrayList();
	    
	    for(int i=0; i<productosContratadosOriginal.size(); i++){
	    	ProdContratadoOfertadoDTO prodOrig = new ProdContratadoOfertadoDTO();
	    	ProdContratadoOfertadoDTO prodAct = new ProdContratadoOfertadoDTO();
	    	prodOrig = (ProdContratadoOfertadoDTO) productosContratadosOriginal.get(i);
	    	prodAct = (ProdContratadoOfertadoDTO)productosContratados.get(i);
	    	
	    	NumeroListDTO listNumOriginal = prodOrig.getListaNumeros();
	    	NumeroListDTO listNumActual = prodAct.getListaNumeros();
	    	NumeroDTO[] numOriginal = listNumOriginal.getNumerosDTO();
	    	NumeroDTO[] numActual = listNumActual.getNumerosDTO();
	    	
	    	
	    	 
	    	if(numOriginal != null && numActual !=null){
	    		
	    		// Busca cuales fueron los numeros AGREGADOS para el producto y los coloca en una lista de numeros
	    		for(int x=0; x< numActual.length; x++){
	    			String numeroABuscar = numActual[x].getNro();
	    			boolean encontrado = false;
	    			for(int y=0; y<numOriginal.length; y++){
	    				if(numeroABuscar.equals(numOriginal[y].getNro())){
	    					encontrado = true;
	    					break;
	    				}
	    				
	    			}
	    			// si el numero a buscar no ha sido encontrado dentro de la lista original, colocar en lista de AGREGADOS
	    			if(!encontrado){
	    				NumeroDTO numeroAgregar = new NumeroDTO();
	    				numeroAgregar.setNro(numeroABuscar);
	    				numeroAgregar.setIdProductoContratado(String.valueOf(prodOrig.getIdProdContratado()));
	    				numeroAgregar.setNumProceso(String.valueOf(sessionData.getNumOrdenServicio()));
	    				numeroAgregar.setOrigenProceso("PV");
		    		    //Inicio Inc. 171447 FDL
	    				
	    				for(int j=0; j<prodContratados.getProductosContratadosDTO().length;j++){
	    					logger.debug("prodContratados.getProductosContratadosDTO() [j].getFechaInicioVigencia() :" +prodContratados.getProductosContratadosDTO() [j].getFechaInicioVigencia());
	    					Date fechaInicVig = prodContratados.getProductosContratadosDTO() [j].getFechaInicioVigencia();
	    					logger.debug("fechaInicVig :"+fechaInicVig);
		    				//Date fechaInicProc = new Date(prodContratados.getProductosContratadosDTO() [j].getOrigenProceso());
		    				Timestamp inicioVigencia = new Timestamp(fechaInicVig.getTime());
		    				//Timestamp inicioProceso = new Timestamp(fechaInicProc.getDate());
		    				
		    				numeroAgregar.setFecInicioVigencia(inicioVigencia);
			    			numeroAgregar.setFecProceso(fechaInicVig);
	    				}
	    				
		    	
		    			//Fin Inc. 171447 FDL
		    			Calendar calendario = Calendar.getInstance();
		    			calendario.set(3000, 11, 30);
		    			Date fechaFinal = new Date(calendario.getTimeInMillis());
		    			numeroAgregar.setFecTerminoVigencia(fechaFinal);
		    			numeroAgregar.setCodCategoriaDest(null);
		    			listaClientesAgregados.add(numeroAgregar);
	    				
	    			}
	    		}
	    		
	    		// Busca cuales fueron los numeros ELIMINADOS para el producto y los coloca en una lista de numeros
	    		for(int x=0; x<numOriginal.length; x++){
	    			String numeroABuscar = numOriginal[x].getNro();
	    			boolean encontrado = false;
	    			for(int y=0; y<numActual.length; y++){
	    				if(numeroABuscar.equals(numActual[y].getNro())){
	    					encontrado = true;
	    					break;
	    				}
	    				
	    			}
	    			
	    			// si el numero a buscar no ha sido encontrado dentro de la lista actual, colocar en lista de ELIMINADOS
	    			if(!encontrado){
	    				NumeroDTO numeroEliminar = new NumeroDTO();
		    			numeroEliminar.setNro(numeroABuscar);
		    			numeroEliminar.setIdProductoContratado(String.valueOf(prodOrig.getIdProdContratado()));
		    			numeroEliminar.setNumProcesoDescontrata(String.valueOf(sessionData.getNumOrdenServicio()));
		    			numeroEliminar.setOrigenProcDescontrata("PV");
		    			numeroEliminar.setFecTerminoVigencia(new Date());
		    			listaClientesEliminados.add(numeroEliminar);
	    				
	    			}
	    		}
	    		
	    	} //del if
	    	
	    } // del for
	    
	    
	    
	    if(listaClientesAgregados != null){
	    	logger.debug("Numeros Agregados.............");
	    	for(int i=0; i<listaClientesAgregados.size();i++){
	    		NumeroDTO numero = new NumeroDTO();
	    		numero = (NumeroDTO)listaClientesAgregados.get(i);
	    		logger.debug("numero.getNro()                   :"+numero.getNro());
	    		logger.debug("numero.getIdProductoContratado()  :"+numero.getIdProductoContratado());
	    		logger.debug("numero.getFecInicioVigencia()     :"+numero.getFecInicioVigencia());
	    		logger.debug("numero.getFecTerminoVigencia()    :"+numero.getFecTerminoVigencia());
	    		logger.debug("numero.getCodCategoriaDest()      :"+numero.getCodCategoriaDest());
	    		logger.debug("numero.getNumProceso()            :"+numero.getNumProceso());
	    		logger.debug("numero.getOrigenProceso()         :"+numero.getOrigenProceso());
	    		logger.debug("numero.getFecProceso()            :"+numero.getFecProceso());
	    		logger.debug("---------------------------------------");
	    	}
	    }
	    
	    if(listaClientesEliminados != null){
	    	logger.debug("Numeros Eliminados.............");
	    	for(int i=0; i<listaClientesEliminados.size();i++){
	    		NumeroDTO numero = new NumeroDTO();
	    		numero = (NumeroDTO)listaClientesEliminados.get(i);
	    		logger.debug("numero.getNro()                   :"+numero.getNro());
	    		logger.debug("numero.getIdProductoContratado()  :"+numero.getIdProductoContratado());
	    		logger.debug("numero.getNumProcesoDescontrata() :"+numero.getNumProcesoDescontrata());
	    		logger.debug("numero.getOrigenProcDescontrata() :"+numero.getOrigenProcDescontrata());
	    		logger.debug("---------------------------------------");
	    	}
	    }
	    
	    NumeroListDTO numeroListAdd = new NumeroListDTO();
	    NumeroListDTO numeroListDel = new NumeroListDTO();
	    NumeroDTO[]   numeroArrAdd =  null;
	    NumeroDTO[]   numeroArrDel =  null;
	    
	    numeroArrAdd = listaClientesAgregados==null?null:(NumeroDTO[])ArrayUtl.copiaArregloTipoEspecifico(listaClientesAgregados.toArray(), NumeroDTO.class);
	    numeroArrDel = listaClientesEliminados==null?null:(NumeroDTO[])ArrayUtl.copiaArregloTipoEspecifico(listaClientesEliminados.toArray(), NumeroDTO.class);
	    
	    numeroListAdd.setNumerosDTO(numeroArrAdd);
	    numeroListAdd.setCodCliente(String.valueOf(sessionData.getCodCliente()));
	    numeroListAdd.setNumAbonado(String.valueOf(sessionData.getNumAbonado()));
	    numeroListAdd.setTipoComportamiento("PAFN");
	    numeroListDel.setNumerosDTO(numeroArrDel);
	    
	    //Objetos de session que contiene los numeros que deberan ser recuperadas en el action de registro de afines 
	    //y setearlas como atributos del objeto que se registrara
	    session.setAttribute("numeroListAdd", numeroListAdd);  
	    session.setAttribute("numeroListDel", numeroListDel);
	    
	    
	    
	    
	    
	    String[] codAbonado = new String[1];
	    codAbonado[0] = String.valueOf(sessionData.getAbonados()[0].getNumAbonado());
	    
	    ConversionListDTO conversionList=null;
	    ConversionDTO param = new ConversionDTO();
		param.setCodOOSS(sessionData.getCodOrdenServicio());
		param.setCodTipModi("-");
		logger.debug("param.getCodOOSS()    :["+param.getCodOOSS()+"]");
		logger.debug("param.getCodTipModi() :["+param.getCodTipModi()+"]");
		logger.debug("obtenerConversionOOSS():inicio");
		conversionList = delegate.obtenerConversionOOSS(param);
		logger.debug("obtenerConversionOOSS():fin");
		
		sessionData.setCodAbonado(codAbonado);
		sessionData.setSinCondicionesComerciales(form1.getCondicH());
		sessionData.setCodActAbo(conversionList.getRegistros()[0].getCodActuacion());
		sessionData.setTipoPantallaPrevia(String.valueOf(2));  // Se setea valor 2 para que en la query dinamica de obtencion de cargos por uso, no se considerado el codigo de concepto
		sessionData.setObtenerCargos("SI");
		sessionData.setCodActAboCargosUso(conversionList.getRegistros()[0].getCodActuacion());
		logger.debug("sessionData.getCodAbonado()                         :"+sessionData.getCodAbonado());
		logger.debug("sessionData.getSinCondicionesComerciales()          :"+sessionData.getSinCondicionesComerciales());
		logger.debug("sessionData.getCodActAbo()                          :"+sessionData.getCodActAbo());
		logger.debug("sessionData.getTipoPantallaPrevia()                 :"+sessionData.getTipoPantallaPrevia());
		logger.debug("sessionData.getCodActAboCargosUso()                 :"+sessionData.getCodActAboCargosUso());
		
		session.setAttribute("ClienteOOSS", sessionData);
	    
	    
		
		logger.debug("execute():end");
		return mapping.findForward("cargosAfines");
		
	}
	
	
	
	
	
	/**
	 * Recibe un arreglo de numeros ORIGINAL y un arreglo de numeros ACTUAL, los compara y coloca sus diferencias en una lista 
	 * de numeros para agregar y una lista de numeros para eliminar
	 * al pasar los parametros se debe tener en cuenta que varia el orden en que se envia el arreglo numOrigen y numDestino 
	 * dependiendo de si va AGREGAR o ELIMINAR numeros
	 * 
	 */	
	public ArrayList agregarEnLista(ArrayList lista, NumeroDTO[] numOrigen, NumeroDTO[] numDestino, String accion, long numOS, Long idProdContr){
		if (numOrigen!= null && numDestino != null){
			for(int x=0; x< numDestino.length; x++){
				String numeroABuscar = numDestino[x].getNro();
				boolean encontrado = false;
				for(int y=0; y<numOrigen.length; y++){
					if(numeroABuscar.equals(numOrigen[y].getNro())){
						encontrado = true;
						break;
					}
					
				}
				// si el numero a buscar no ha sido encontrado dentro de la lista original, colocar en lista de AGREGADOS
				if(accion.equals("A")){
					if(!encontrado){
						NumeroDTO numeroAgregar = new NumeroDTO();
						numeroAgregar.setNro(numeroABuscar);
						numeroAgregar.setIdProductoContratado(String.valueOf(idProdContr));
						numeroAgregar.setNumProceso(String.valueOf(numOS));
						numeroAgregar.setOrigenProceso("PV");
						Date fecha = new Date();
		    		    Timestamp fechaActual = new Timestamp(fecha.getTime());
		    			numeroAgregar.setFecInicioVigencia(fechaActual);
		    			numeroAgregar.setFecProceso(fechaActual);
		    			Calendar calendario = Calendar.getInstance();
		    			calendario.set(3000, 11, 30);
		    			Date fechaFinal = new Date(calendario.getTimeInMillis());
		    			numeroAgregar.setFecTerminoVigencia(fechaFinal);
		    			numeroAgregar.setCodCategoriaDest(null);
		    			lista.add(numeroAgregar);
						
					}
				}else{
					if(!encontrado){
	    				NumeroDTO numeroEliminar = new NumeroDTO();
		    			numeroEliminar.setNro(numeroABuscar);
		    			numeroEliminar.setIdProductoContratado(String.valueOf(idProdContr));
		    			numeroEliminar.setNumProcesoDescontrata(String.valueOf(numOS));
		    			numeroEliminar.setOrigenProcDescontrata("PV");
		    			numeroEliminar.setFecTerminoVigencia(new Date());
		    			lista.add(numeroEliminar);
	    				
	    			}
					
				} // del else
					
			} // del for
			
		} // del if
			
		
		return lista;
		
	}
	
	

}
