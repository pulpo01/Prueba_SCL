package com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import uk.ltd.getahead.dwr.WebContext;
import uk.ltd.getahead.dwr.WebContextFactory;

import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroListDTO;

import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.NumeroFrecuenteValDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ProdContratadoOfertadoDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.RespuestaValidacionNumeroDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.exception.ManReqException;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate.ManageRequestBussinessDelegate;

public class NumerosFrecuentes {
	
	private final Logger logger = Logger.getLogger(NumerosFrecuentes.class);
	private Global global = Global.getInstance();
	private ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();
	
	public RespuestaValidacionNumeroDTO obtenerTipoNumero(NumeroFrecuenteValDTO parametros) {
		
		logger.debug("obtenerTipoNumero getNumero "+parametros.getNumero()+"---------------------------------->");
		
		RespuestaValidacionNumeroDTO respuesta=null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);
		logger.debug("parametros.getNumero()           :"+parametros.getNumero());

		NumeroDTO param = new NumeroDTO();
		param.setNro(parametros.getNumero());
		NumeroDTO resultado=null;
		//ConversionDTO[] registrosConversion=null;
		respuesta = new RespuestaValidacionNumeroDTO();
		//NumeroDTO param=null;		
		try {
			logger.debug("obtenerConversionOOSS():inicio");
			param = new NumeroDTO();
			param.setNro(parametros.getNumero());
			
			resultado = delegate.obtenerTipoNumero(param);

			logger.debug("resultadoConversion.getDesCategoria     : "+resultado.getDesCategoria());
			logger.debug("resultadoConversion.getCodCategoriaDest : "+resultado.getCodCategoriaDest());
			respuesta.setNumero(Long.parseLong(resultado.getNro()));
			if(resultado.getDesCategoria() == null)
			{
				respuesta.setMensaje("El número "+parametros.getNumero()+" no es válido");
			}
			else
			{
				respuesta.setTipo(resultado.getDesCategoria());
				respuesta.setCodTipo(resultado.getCodCategoriaDest());
				logger.debug("TIPO "+resultado.getDesCategoria()+"       CODIGOTIPO "+resultado.getCodCategoriaDest());
			}
			
	     // catch (ManReqException e) {
//			e.printStackTrace();
//			logger.debug("ERROR (ManReqException) :"+e.getDescripcionEvento());
//			respuesta.setMensaje(e.getDescripcionEvento());
//			parametros=null;
		
		} 
		catch (NumberFormatException e) {
			logger.debug("ERROR (Exception) :"+e.getMessage());
			respuesta.setMensaje("El número "+parametros.getNumero()+" no es válido");
			parametros=null;
			logger.debug("NumberFormatException Long.parseLong "+e.getMessage()+" En NumerosFrecuentes");
			//e.printStackTrace();
		}
		catch (Exception e) {
			logger.debug("ERROR (Exception) :"+e.getMessage());
			respuesta.setMensaje(e.getMessage());
			parametros=null;
			e.printStackTrace();
		}
		logger.debug("obtenerTipoNumero():fin");
		return respuesta;
		
	}
	
	//(+) Evera 04/02/2009
	/*
	 * Por cada ingreso o modificación en la lista de numeros, se debe validar que no supere el maximo de modificaciones permitidas
	 */
	public RespuestaValidacionNumeroDTO validaModificaciones(long idProductoContratado, int maxModif, int cantModifEnBD, String accion, String numero, String tipo, String codTipo)
	{
		logger.debug("ini validaModificaciones");
		logger.debug("idProductoContratado,maxModif,cantModifEnBD,accion,numero="+idProductoContratado+","+ maxModif+","+ cantModifEnBD+","+accion+","+numero);
		RespuestaValidacionNumeroDTO respuesta=new RespuestaValidacionNumeroDTO();
		String retorno="superaMaximo";
		int totalModificaciones=cantModifEnBD;
		
		WebContext ctx = WebContextFactory.get();
		HttpSession session = ctx.getHttpServletRequest().getSession(false);
	    List productosContratados = new ArrayList();
	    List productosContratadosSesion = new ArrayList();//contiene todas las modificaciones realizadas en session para este producto
	    
	    productosContratados = (List)session.getAttribute("productosContratadosFrecOrig");
	    productosContratadosSesion = (List)session.getAttribute("productosContratadosFrecSesion");

	    NumeroListDTO numeroListOriginal = null; 
	    NumeroListDTO numeroListSesion = null;
	    int totalListOriginal = 0;
	    int totalListSesion=0;
	    
	    //Obtiene listas de numeros original y en sesion
	    for(int i=0; i<productosContratados.size();i++){
	    	ProdContratadoOfertadoDTO productoContratado = new ProdContratadoOfertadoDTO();
	    	productoContratado = (ProdContratadoOfertadoDTO) productosContratados.get(i);
	    	
	    	if (productoContratado.getIdProdContratado().longValue()== idProductoContratado){
	    		numeroListOriginal = productoContratado.getListaNumeros(); //lista original
	    			
		    	for(int j=0; j<productosContratadosSesion.size();j++){
					ProdContratadoOfertadoDTO productoContratadoSession = new ProdContratadoOfertadoDTO();
					productoContratadoSession = (ProdContratadoOfertadoDTO) productosContratadosSesion.get(i);
					if (productoContratadoSession.getIdProdContratado().longValue()==idProductoContratado){
						numeroListSesion = productoContratadoSession.getListaNumeros();//lista en sesion
						break;
					}
		    	}//fin for j
		    	break;
	    	}//fin if
	    	
	    }//fin for i

	    if (numeroListOriginal!=null && numeroListOriginal.getNumerosDTO()!=null) totalListOriginal = numeroListOriginal.getNumerosDTO().length;
	    if (numeroListSesion!=null && numeroListSesion.getNumerosDTO()!=null) totalListSesion = numeroListSesion.getNumerosDTO().length;


	    boolean numeroExisteEnBd = false;
	    	
	    //cuenta las modificaciones de los numeros ya ingresados en base de datos
	    if (totalListOriginal>0){
	    	NumeroDTO[] numerosOrig = numeroListOriginal.getNumerosDTO();
	    
		    //busca numero ingresado, en lista original	    	
		    for (int i=0; i<totalListOriginal;i++){
		    	if (numerosOrig[i].getNro().equals(numero)){
		    		numeroExisteEnBd = true;
		    		break;
		    	}
		    }
		    
	    	if (totalListSesion == 0){//se eliminaron todos los numeros
	    		totalModificaciones = totalModificaciones + totalListOriginal;
	    	}
	    	else{
		    	for(int i=0;i<totalListOriginal;i++){
		    		String numeroOriginal = numerosOrig[i].getNro();
		    		boolean encontrado=false;
		    		//busca si el numero original aun existe en la lista de sesion
	    			NumeroDTO[] numerosSesion = numeroListSesion.getNumerosDTO();
		    		for(int j=0;j<totalListSesion;j++){
		    			String numeroSesion = numerosSesion[j].getNro();
		    			if(numeroOriginal.equals(numeroSesion)){
		    				encontrado = true;
		    				break;
		    			}
		    		}//fin for j
		    		
		    		if (!encontrado) totalModificaciones++; //si no lo encuentra en sesion, fue eliminado
		    	}//fin for i
	    	}//fin if (totalListSesion == 0)
	    }//fin if (totalListOriginal>0){
	    		
	    ///cuenta los nuevos numeros ingresados
	    if (totalListSesion>0){
	    	NumeroDTO[] numerosSesion = numeroListSesion.getNumerosDTO();
	    	
	    	if (totalListOriginal ==0){ //No hay numeros configurados
	    		totalModificaciones = totalModificaciones + totalListSesion;
	    	}
	    	else{
	    		for(int j=0;j<totalListSesion;j++){
	    			String numeroSesion = numerosSesion[j].getNro();
	    			boolean encontrado=false;
	    			//busca si el numero se sesion ya existia en base de datos
	    			NumeroDTO[] numerosOrig = numeroListOriginal.getNumerosDTO();
	    			for(int i=0;i<totalListOriginal;i++){
	    				String numeroOriginal = numerosOrig[i].getNro();
	    				if (numeroSesion.equals(numeroOriginal)){
	    					encontrado=true;
	    					break;
	    				}
	    			}
	    			
	    			if (!encontrado) totalModificaciones++;//si no lo encuentra es sesion, es nuevo
	    		}//fin for j
	    	}//fin if (totalListOriginal ==0)
	    }//fin if (totalListSesion>0)
	    
	    if (accion.equals("I")){//numero nuevo
	    	if (numeroExisteEnBd){
	    		totalModificaciones = totalModificaciones - 1; //queda igual, se anula modificacion
	    	}else{
	    		totalModificaciones = totalModificaciones + 1;
	    	}
	    }else if(accion.equals("E")){//eliminacion
	    	if (numeroExisteEnBd){
	    		totalModificaciones = totalModificaciones + 1;  
	    	}else{
	    		totalModificaciones = totalModificaciones - 1; //esta eliminando el que agrego durante la sesion
	    	}
	    }
	    
	    if (maxModif==0||totalModificaciones <= maxModif){
	    	retorno="OK";
	    }
	    logger.debug("totalModificaciones="+totalModificaciones);
	    
		respuesta.setTipo(tipo);
		respuesta.setCodTipo(codTipo);
		respuesta.setMensaje(retorno);
	    logger.debug("fin validaModificaciones");
	    return respuesta;
	    
	}
	
	public void agregaNumeroAListaSesion(long idProdSesion, String numero){
		logger.debug("ini agregaNumeroAListaSesion");
		List productosContratadosSesion = new ArrayList();
		
		WebContext ctx = WebContextFactory.get();
		HttpSession session = ctx.getHttpServletRequest().getSession(false);
	    
		productosContratadosSesion = (List)session.getAttribute("productosContratadosFrecSesion");
		
		logger.debug("idProdSesion="+idProdSesion);
		for(int i=0;i<productosContratadosSesion.size();i++){
			ProdContratadoOfertadoDTO productoTMP = (ProdContratadoOfertadoDTO) productosContratadosSesion.get(i);
	    	if (productoTMP.getIdProdContratado().longValue()== idProdSesion){//actualiza la lista de numeros
	    		NumeroListDTO numerosTMP = productoTMP.getListaNumeros();
	    		int totalNumeros = 0;
	    		if (numerosTMP!=null && numerosTMP.getNumerosDTO()!=null){
	    			totalNumeros = numerosTMP.getNumerosDTO().length;
	    		}
	    		logger.debug("totalNumeros existentes="+totalNumeros);
	    		NumeroDTO[] nuevaListaNumeros = new NumeroDTO[totalNumeros+1];
    			NumeroDTO numeroTMP= new NumeroDTO();
    			numeroTMP.setNro(numero);

    			for(int j=0;j<totalNumeros;j++){//traspasar los que ya existen en sesion
    				nuevaListaNumeros[j]=numerosTMP.getNumerosDTO()[j];
    			}
	    		nuevaListaNumeros[totalNumeros] = numeroTMP; //agrega el nuevo
	    		
	    		NumeroListDTO numerosActualizado = new NumeroListDTO();
	    		numerosActualizado.setNumerosDTO(nuevaListaNumeros);
	    		productoTMP.setListaNumeros(numerosActualizado);
	    	}
		}
		logger.debug("fin agregaNumeroAListaSesion");
	}
	
	public void eliminaNumeroAListaSesion(long idProdSesion, String[] numeros){
		logger.debug("ini eliminaNumeroAListaSesion");
		List productosContratadosSesion = new ArrayList();
		
		WebContext ctx = WebContextFactory.get();
		HttpSession session = ctx.getHttpServletRequest().getSession(false);
	    
		logger.debug("total numeros="+numeros.length);
		productosContratadosSesion = (List)session.getAttribute("productosContratadosFrecSesion");
		for(int k=0;k<productosContratadosSesion.size();k++){
    			ProdContratadoOfertadoDTO productoTMP = (ProdContratadoOfertadoDTO) productosContratadosSesion.get(k);
    	    	if (productoTMP.getIdProdContratado().longValue()== idProdSesion){//actualiza la lista de numeros
    	    		NumeroListDTO numerosTMP = productoTMP.getListaNumeros();
    	    		int totalNumeros = 0;
    	    		if (numerosTMP!=null && numerosTMP.getNumerosDTO()!=null){
    	    			totalNumeros = numerosTMP.getNumerosDTO().length;
    	    		}
    	    		logger.debug("totalNumeros existentes="+totalNumeros);		
    	    		ArrayList nuevaListaNumeros = new ArrayList();
	    			for(int j=0;j<totalNumeros;j++){//traspasar los que ya existen en sesion, solo si no estan en lista para eliminar
	    				NumeroDTO numOrig = numerosTMP.getNumerosDTO()[j];
	    				boolean encontrado = false;
	    				
	    				for(int l=0;l<numeros.length;l++){
	    					if (numOrig.getNro().equals(numeros[l])){
	    						logger.debug("encontro numero "+numOrig.getNro());
	    						encontrado =true;
	    						break;
	    					}
	    				}
	    				
	    				if (!encontrado){
	    					nuevaListaNumeros.add(numOrig);
	    				}
	    				
	    			}//fin for j
    	    		
	    			NumeroDTO[] numerosFinal = (NumeroDTO[]) ArrayUtl.copiaArregloTipoEspecifico( nuevaListaNumeros.toArray(), NumeroDTO.class);
	    			
	    			logger.debug("numerosFinal total="+numerosFinal.length);
    	    		NumeroListDTO numerosActualizado = new NumeroListDTO();
    	    		numerosActualizado.setNumerosDTO(numerosFinal);
    	    		productoTMP.setListaNumeros(numerosActualizado);
    	    		break;
    	    	}//fin if
    	}//fin for k

		logger.debug("fin eliminaNumeroAListaSesion");
	}
	
	public String validaModificacionesElim(String idProductoContratado, int maxModif, int cantModifEnBD, String[] numeros ){
		logger.debug("ini validaModificaciones");
		String retorno="superaMaximo";

		WebContext ctx = WebContextFactory.get();
		HttpSession session = ctx.getHttpServletRequest().getSession(false);
		
		logger.debug("total numeros="+numeros.length);
		
		long idProdContratado= Long.parseLong(idProductoContratado);
		
		int totalModificaciones=cantModifEnBD;
		
	    List productosContratados = new ArrayList();
	    List productosContratadosSesion = new ArrayList();//contiene todas las modificaciones realizadas en session para este producto
	    
	    productosContratados = (List)session.getAttribute("productosContratadosFrecOrig");
	    productosContratadosSesion = (List)session.getAttribute("productosContratadosFrecSesion");

	    NumeroListDTO numeroListOriginal = null; 
	    NumeroListDTO numeroListSesion = null;
	    int totalListOriginal = 0;
	    int totalListSesion=0;
	    
	    //Obtiene listas de numeros original y en sesion
	    for(int i=0; i<productosContratados.size();i++){
	    	ProdContratadoOfertadoDTO productoContratado = new ProdContratadoOfertadoDTO();
	    	productoContratado = (ProdContratadoOfertadoDTO) productosContratados.get(i);
	    	
	    	if (productoContratado.getIdProdContratado().longValue()== idProdContratado){
	    		numeroListOriginal = productoContratado.getListaNumeros(); //lista original
	    			
		    	for(int j=0; j<productosContratadosSesion.size();j++){
					ProdContratadoOfertadoDTO productoContratadoSession = new ProdContratadoOfertadoDTO();
					productoContratadoSession = (ProdContratadoOfertadoDTO) productosContratadosSesion.get(i);
					if (productoContratadoSession.getIdProdContratado().longValue()==idProdContratado){
						numeroListSesion = productoContratadoSession.getListaNumeros();//lista en sesion
						break;
					}
		    	}//fin for j
		    	break;
	    	}//fin if
	    	
	    }//fin for i

	    if (numeroListOriginal!=null && numeroListOriginal.getNumerosDTO()!=null) totalListOriginal = numeroListOriginal.getNumerosDTO().length;
	    if (numeroListSesion!=null && numeroListSesion.getNumerosDTO()!=null) totalListSesion = numeroListSesion.getNumerosDTO().length;

	    logger.debug("totalListOriginal= "+totalListOriginal);
	    logger.debug("totalListSesion= "+totalListSesion);
	    
	    //para cada numero a eliminar hacer esta validacion
	    for (int l=0; l<numeros.length;l++){
	    	totalModificaciones=cantModifEnBD;
	    	String numerol = numeros[l];
	    	logger.debug("validando numero "+numerol);
	    	
	    	boolean numeroExisteEnBd = false;
		    	
		    //cuenta las modificaciones de los numeros ya ingresados en base de datos
		    if (totalListOriginal>0){
		    	NumeroDTO[] numerosOrig = numeroListOriginal.getNumerosDTO();
		    
			    //busca numero ingresado, en lista original	    	
			    for (int i=0; i<totalListOriginal;i++){
			    	if (numerosOrig[i].getNro().equals(numerol)){
			    		numeroExisteEnBd = true;
			    		break;
			    	}
			    }
			    
		    	if (totalListSesion == 0){//se eliminaron todos los numeros
		    		totalModificaciones = totalModificaciones + totalListOriginal;
		    	}
		    	else{
			    	for(int i=0;i<totalListOriginal;i++){
			    		String numeroOriginal = numerosOrig[i].getNro();
			    		boolean encontrado=false;
			    		//busca si el numero original aun existe en la lista de sesion
		    			NumeroDTO[] numerosSesion = numeroListSesion.getNumerosDTO();
			    		for(int j=0;j<totalListSesion;j++){
			    			String numeroSesion = numerosSesion[j].getNro();
			    			if(numeroOriginal.equals(numeroSesion)){
			    				encontrado = true;
			    				break;
			    			}
			    		}//fin for j
			    		
			    		if (!encontrado) totalModificaciones++; //si no lo encuentra en sesion, fue eliminado
			    	}//fin for i
		    	}//fin if (totalListSesion == 0)
		    }//fin if (totalListOriginal>0){
		    		
		    ///cuenta los nuevos numeros ingresados
		    if (totalListSesion>0){
		    	NumeroDTO[] numerosSesion = numeroListSesion.getNumerosDTO();
		    	
		    	if (totalListOriginal ==0){ //No hay numeros configurados
		    		totalModificaciones = totalModificaciones + totalListSesion;
		    	}
		    	else{
		    		for(int j=0;j<totalListSesion;j++){
		    			String numeroSesion = numerosSesion[j].getNro();
		    			boolean encontrado=false;
		    			//busca si el numero se sesion ya existia en base de datos
		    			NumeroDTO[] numerosOrig = numeroListOriginal.getNumerosDTO();
		    			for(int i=0;i<totalListOriginal;i++){
		    				String numeroOriginal = numerosOrig[i].getNro();
		    				if (numeroSesion.equals(numeroOriginal)){
		    					encontrado=true;
		    					break;
		    				}
		    			}
		    			
		    			if (!encontrado) totalModificaciones++;//si no lo encuentra es sesion, es nuevo
		    		}//fin for j
		    	}//fin if (totalListOriginal ==0)
		    }//fin if (totalListSesion>0)
		    
	    	if (numeroExisteEnBd){
	    		totalModificaciones = totalModificaciones + 1;  
	    	}else{
	    		totalModificaciones = totalModificaciones - 1; //esta eliminando el que agrego durante la sesion
	    	}
	    	
		    if (maxModif==0||totalModificaciones <= maxModif){
		    	retorno="OK";
			    //actualizar lista de sesion temporalmente para validar el siguiente numero
		    	ArrayList numerosSesionTMP = new ArrayList();
		    	for(int i=0;i<totalListSesion;i++){
		    		String numeroTMP = numeroListSesion.getNumerosDTO()[i].getNro();
		    		if (!numeroTMP.equals(numerol)){
		    			NumeroDTO numeroDTOTMP = new NumeroDTO();
		    			numeroDTOTMP.setNro(numeroTMP);
		    			numerosSesionTMP.add(numeroDTOTMP);
		    		}
		    	}
		    	NumeroDTO[] numerosFinal = (NumeroDTO[]) ArrayUtl.copiaArregloTipoEspecifico( numerosSesionTMP.toArray(), NumeroDTO.class);
		    	numeroListSesion = new NumeroListDTO();
		    	numeroListSesion.setNumerosDTO(numerosFinal);
		    	totalListSesion = numeroListSesion.getNumerosDTO().length;
		    }else{
		    	 retorno="superaMaximo";
		    	break;
		    }
		    logger.debug("totalModificaciones="+totalModificaciones);

	    }//fin  for l
		
		logger.debug("fin validaModificaciones");		
		
		return retorno;
	}

	
	//(-) Evera 04/02/2009

}
