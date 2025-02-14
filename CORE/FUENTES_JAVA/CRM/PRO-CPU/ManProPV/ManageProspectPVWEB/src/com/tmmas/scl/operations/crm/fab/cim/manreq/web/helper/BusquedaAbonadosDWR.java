package com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import uk.ltd.getahead.dwr.WebContext;
import uk.ltd.getahead.dwr.WebContextFactory;

import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.FiltroAbonadosDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.exception.ManReqException;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate.ManageRequestBussinessDelegate;

public class BusquedaAbonadosDWR {
	private final Logger logger = Logger.getLogger(BusquedaAbonadosDWR.class);
	private Global global = Global.getInstance();
	private ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();
	private AbonadoDTO[] abonadosSel; 
	private AbonadoDTO[] abonadosFiltrados;
	
	public String obtenerAbonados(long codCliente, String numAbonado, String numCelular, String rutAbonado, String tipoPlanTarif){
		logger.debug("obtenerAbonados:antes");
		
		String retorno = null;
		
		WebContext ctx = WebContextFactory.get();
		HttpSession session = ctx.getHttpServletRequest().getSession(false);

		session.removeAttribute("AbonadosFiltrados");
	    try{
	    	long numeroAbonado = 0;
	    	long numeroCelular = 0;
	    	
	    	if (numAbonado !=null && numAbonado.trim()!="") numeroAbonado=Long.parseLong(numAbonado);
	    	if (numCelular !=null && numCelular.trim()!="") numeroCelular=Long.parseLong(numCelular);
	    	if (rutAbonado.trim().equals("")) rutAbonado=null;
	    	
	    	FiltroAbonadosDTO filtro = new FiltroAbonadosDTO();
	    	filtro.setCodCliente(codCliente);
	    	filtro.setNumAbonado(numeroAbonado);
	    	filtro.setNumCelular(numeroCelular);
	    	filtro.setRutAbonado(rutAbonado);
	    	filtro.setTipoPlanTarif(tipoPlanTarif);
	    	
	    	
	    	logger.debug("codCliente:"+codCliente);
	    	logger.debug("numeroAbonado:"+numeroAbonado);
	    	logger.debug("numeroCelular:"+numeroCelular);
	    	logger.debug("rutAbonado:"+rutAbonado);
	    	logger.debug("tipoPlanTarif:"+tipoPlanTarif);
	    	
		    logger.debug("obtenerListaAbonadosFiltrados:antes");
			AbonadoListDTO abonadoLista = delegate.obtenerListaAbonadosFiltrados(filtro);
			logger.debug("obtenerListaAbonadosFiltrados:despues");
			if (abonadoLista!=null && abonadoLista.getAbonados()!=null) {
				int n = abonadoLista.getAbonados().length;
				if (n>0){
					logger.debug("total filtrados:"+n);
	
					ArrayList abonadosAcumLis = new ArrayList();
					//abonados seleccionados acumulados
					int numSelecionados = 0;
					if (this.abonadosSel != null) numSelecionados = this.abonadosSel.length; 
					
					AbonadoDTO[] abonadosAux = abonadoLista.getAbonados();
					for(int j=0; j<n; j++){
						//verifica que no este en la lista de seleccionados
						boolean encontrado = false;
						for(int k=0;k<numSelecionados;k++){
							if (abonadosAux[j].getNumAbonado() == this.abonadosSel[k].getNumAbonado()){
								encontrado = true;
								break;
							}	
						}
						
						if (!encontrado)
							abonadosAcumLis.add(abonadosAux[j]);//carga abonado a la lista
					}
					AbonadoDTO[] abonadosSelFiltro=(AbonadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(abonadosAcumLis.toArray(), AbonadoDTO.class);

					session.setAttribute("AbonadosFiltrados", abonadosSelFiltro);
					this.abonadosFiltrados =  abonadoLista.getAbonados();
				}
			}
			/*********/
			
	    } catch (ManReqException e) {
			
			if(e.getCodigo()==null || e.getCodigo().equals("0")){
				logger.debug("ERROR (ManReqException) :"+e.getMessage());
				retorno = e.getMessage();
			}else{
				logger.debug("ERROR (ManReqException) :"+e.getDescripcionEvento());
				retorno =e.getDescripcionEvento();
			}
		
		} catch (Exception e) {
			logger.debug("ERROR (Exception) :"+e.getMessage());
			retorno = e.getMessage();;
		}
		
		logger.debug("obtenerAbonados:despues");
		return(retorno);
	}
	
	public String cargaAbonadosSel(long numAbonado){
		logger.debug("cargaAbonadosSel:antes");
		
		String retorno = null;
		try{
			WebContext ctx = WebContextFactory.get();
			HttpSession session = ctx.getHttpServletRequest().getSession(false);
			
			AbonadoDTO abonado = new AbonadoDTO();
		
			//buscar abonado
			int numAboFiltrados = this.abonadosFiltrados.length;
			
			for(int i=0;i<numAboFiltrados; i++){
				abonado = this.abonadosFiltrados[i];
				if (abonado.getNumAbonado() == numAbonado){
					break;
				}
			}
			
			if (abonadosSel ==null || abonadosSel.length==0){
				abonadosSel = new AbonadoDTO[1];
				abonadosSel[0] = abonado; 
			}
			else{
				int numSelecionados = abonadosSel.length;
				
				AbonadoDTO[] abonadosSelAux = new AbonadoDTO[numSelecionados+1];
				
				for(int i=0;i<numSelecionados;i++){
					//verificar si ya fue ingresado
					if (numAbonado == abonadosSel[i].getNumAbonado()){
						retorno ="Abonado :"+numAbonado+" ya fue seleccionado.";
						return retorno;
					}
					abonadosSelAux[i] = abonadosSel[i];
				}
				
				//valida tecnologia
				AbonadoDTO aboAux = new AbonadoDTO();
				
				//nuevo seleccionado
				for(int i=0; i< abonadosFiltrados.length;i++){
					if (numAbonado == abonadosFiltrados[i].getNumAbonado()){
						aboAux = abonadosFiltrados[i];
						break;
					}
				}
				
				if (numSelecionados>0){
					if (!aboAux.getCodTecnologia().equals(abonadosSel[0].getCodTecnologia())){
						retorno ="Agregar abonados de la misma tecnología.";
						return retorno;
					}
				}
				
				abonadosSelAux[numSelecionados] = abonado;
				abonadosSel = abonadosSelAux;
			}
			session.removeAttribute("AbonadosSeleccionados");
			session.setAttribute("AbonadosSeleccionados", abonadosSel);
			
			//actualiza lista de filtrados
			AbonadoDTO[] abonadosFiltradosAux = new AbonadoDTO[abonadosFiltrados.length - 1];
			int k = 0;
			for(int i=0; i< abonadosFiltrados.length;i++){
				AbonadoDTO abonadoAux = abonadosFiltrados[i];
				if (numAbonado != abonadoAux.getNumAbonado()){
					abonadosFiltradosAux[k] = abonadoAux;
					k++;
				}
			}
			abonadosFiltrados = abonadosFiltradosAux;
			session.removeAttribute("AbonadosFiltrados");
			session.setAttribute("AbonadosFiltrados", abonadosFiltrados);		
		} catch (Exception e) {
			logger.debug("ERROR (Exception) :"+e.getMessage());
			retorno = e.getMessage();;
		}
		
		logger.debug("cargaAbonadosSel:despues");
		return retorno;
	}
	
	public String eliminaAbonadosSel(long numAbonado){
		logger.debug("eliminaAbonadosSel:antes");
		String retorno=null;
		try{
			WebContext ctx = WebContextFactory.get();
			HttpSession session = ctx.getHttpServletRequest().getSession(false);
			
			if (this.abonadosSel ==null || this.abonadosSel.length==0){
				return "No ha seleccionado abonado";
			}
			else{
				int numSelecionados = abonadosSel.length;
				
				AbonadoDTO[] abonadosSelAux = new AbonadoDTO[numSelecionados-1];
				int k=0;
				for(int i=0;i<numSelecionados;i++){
					//carga nueva lista con todos menos el seleccionado
					if (numAbonado != abonadosSel[i].getNumAbonado()){
						abonadosSelAux[k] = abonadosSel[i];
						k++;
					}
				}
				abonadosSel = abonadosSelAux;
			}
			session.removeAttribute("AbonadosSeleccionados");
			session.setAttribute("AbonadosSeleccionados", abonadosSel);
			
		} catch (Exception e) {
			logger.debug("ERROR (Exception) :"+e.getMessage());
			retorno = e.getMessage();;
		}
		
		
		
		logger.debug("eliminaAbonadosSel:antes");
		return retorno;
	}
	
	public void limpia(){
		logger.debug("limpia:antes");
		
		WebContext ctx = WebContextFactory.get();
		HttpSession session = ctx.getHttpServletRequest().getSession(false);

		session.removeAttribute("AbonadosFiltrados");
		session.removeAttribute("AbonadosSeleccionados");
		this.abonadosSel = null;
		this.abonadosFiltrados = null;
		
		logger.debug("limpia:despues");
	}
	
	public long obtieneCantidadAbonadosSel(){
		long cantidad =0;
		
		if (this.abonadosSel ==null){
			cantidad=0;
		}else{
			cantidad = this.abonadosSel.length;
		}
			
		return cantidad;	
	}
	
	public long obtieneCantidadAbonadosFiltrados(){
		long cantidad =0;
		
		if (this.abonadosFiltrados ==null){
			cantidad=0;
		}else{
			cantidad = this.abonadosFiltrados.length;
		}
			
		return cantidad;		
	}
}
