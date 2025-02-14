package com.tmmas.cl.scl.portalventas.web.helper;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import uk.ltd.getahead.dwr.WebContext;
import uk.ltd.getahead.dwr.WebContextFactory;

import com.tmmas.cl.scl.altacliente.presentacion.dto.RetornoListaAjaxDTO;
import com.tmmas.cl.scl.altacliente.presentacion.dto.RetornoValidacionAjaxDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ParametrosGlobalesDTO;
import com.tmmas.cl.scl.portalventas.web.delegate.PortalVentasDelegate;
import com.tmmas.cl.scl.portalventas.web.dto.NumeroAjaxDTO;
import com.tmmas.cl.scl.portalventas.web.dto.NumeroRangoAjaxDTO;
import com.tmmas.cl.scl.portalventas.web.dto.RetornoBusquedaNumeracionAjaxDTO;
import com.tmmas.cl.scl.portalventas.web.dto.RetornoValorAjaxDTO;
import com.tmmas.cl.scl.portalventas.web.form.BuscaNumeroForm;
import com.tmmas.cl.scl.portalventas.web.form.DatosLineaForm;
import com.tmmas.cl.scl.portalventas.web.form.DatosVentaForm;
import com.tmmas.cl.scl.productdomain.businessobject.dto.DatosNumeracionDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.NumeracionCelularDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.SeleccionNumeroCelularDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.SeleccionNumeroCelularRangoDTO;

public class BuscaNumeroAJAX {
	private final Logger logger = Logger.getLogger(BuscaNumeroAJAX.class);
	private Global global = Global.getInstance();
	
	PortalVentasDelegate delegate = PortalVentasDelegate.getInstance();
	
	/*
	 * Carga lista de numeracion reservada
	 */
	public RetornoListaAjaxDTO obtenerNumeracionReservada()
	{
		logger.debug("obtenerNumeracionReservada:inicio()");
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);
		
		RetornoListaAjaxDTO retorno = new RetornoListaAjaxDTO();
		
		if (!validarSesion(sesion)){
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;	
		}
		
		NumeroAjaxDTO[] listaRetorno = null;
		SeleccionNumeroCelularDTO[] listaNumeros= null;
		
		try{
			String codCliente = "0"; 
			String codVendedor = "0";
			String codUso ="";
			String codCateg = "";
			String cantMaxCel = global.getValor("cantidad.maxima.celulares");
			String codVendedorDealer = "0";
			String indVentaExterna = "";
			String codTipoCliente="";
			String codCentral="";
			//(+) busca cliente, vendedor, vendedordealer
			if (sesion.getAttribute("DatosVentaForm")!=null){
				DatosVentaForm datosVentaForm = (DatosVentaForm)sesion.getAttribute("DatosVentaForm");
				codCliente = datosVentaForm.getCodCliente();
				codVendedor = datosVentaForm.getCodDistribuidor();
				indVentaExterna = datosVentaForm.getIndVtaExterna();
				codTipoCliente=datosVentaForm.getCodTipoCliente();
				if (indVentaExterna.equals("1")) codVendedorDealer = datosVentaForm.getCodVendedor();
			}
			//(-)
			
			//(+) busca uso
			if (sesion.getAttribute("DatosLineaForm")!=null){
				DatosLineaForm datosLineaForm = (DatosLineaForm)sesion.getAttribute("DatosLineaForm");				
				codCentral=datosLineaForm.getCodCentral();
				
				BuscaNumeroForm buscaNumeroForm = (BuscaNumeroForm)sesion.getAttribute("BuscaNumeroForm");
				if(buscaNumeroForm.getModuloOrigen() != null && 
						buscaNumeroForm.getModuloOrigen().trim().equals(global.getValor("parametro.fax")))
				{
					codUso = global.getValor("parametro.uso.fax");
				}else {
					codUso = datosLineaForm.getCodUsoLinea();
				}
			}
			//(-)
			
			//Busca categoria
			DatosNumeracionDTO datosNumeracionDTO = new DatosNumeracionDTO();
			datosNumeracionDTO.setCodActabo(obtenerActuacion(indVentaExterna, codTipoCliente, codUso));
			codCateg = delegate.obtieneCategoria(datosNumeracionDTO);
			//(-)
			
			datosNumeracionDTO = new DatosNumeracionDTO();
			datosNumeracionDTO.setCodCliente(new Long(codCliente));
			datosNumeracionDTO.setCodVendedor(new Long(codVendedor));
			datosNumeracionDTO.setCodCodUsoNue(codUso);
			datosNumeracionDTO.setCodCatNue(codCateg);
			datosNumeracionDTO.setCantidadMaximaNrosCelulares(Integer.parseInt(cantMaxCel));
			datosNumeracionDTO.setCodVendealer(new Long(codVendedorDealer));
			datosNumeracionDTO.setCodCentNue(codCentral);
			listaNumeros = delegate.obtieneNumeracionReservada(datosNumeracionDTO);
			
			listaRetorno =  new NumeroAjaxDTO[listaNumeros.length];
			for(int i=0; i<listaNumeros.length;i++){
				NumeroAjaxDTO numero = new NumeroAjaxDTO();
				numero.setNumCelular(String.valueOf(listaNumeros[i].getNumCelular()));
				numero.setCategoria(listaNumeros[i].getCodCategoria());
				listaRetorno[i] = numero;
			}
			
			sesion.setAttribute("listaNumeros", listaRetorno);
			sesion.removeAttribute("listaNumerosRango");
			
		}catch(Exception e){
        	String mensaje = e.getMessage()==null?"Ocurrió un error al obtener numeración reservada ":e.getMessage();
        	retorno.setCodError("1");
			retorno.setMsgError(mensaje);
		}

		retorno.setLista(listaRetorno);
		logger.debug("obtenerNumeracionReservada:fin()");		
		return retorno;
	}

	/*
	 * Carga lista de numeracion reutilizable
	 */
	public RetornoListaAjaxDTO obtenerNumeracionReutilizable(String rangoInferior, String rangoSuperior)
	{
		logger.debug("obtenerNumeracionReutilizable:inicio()");
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);
		
		RetornoListaAjaxDTO retorno = new RetornoListaAjaxDTO();
		
		if (!validarSesion(sesion)){
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;	
		}
		
		NumeroAjaxDTO[] listaRetorno = null;
		SeleccionNumeroCelularDTO[] listaNumeros= null;
		
		try{
			String codCateg = "";
			String codUso = "";
			String codCentral ="";
			String codSubAlm = "";
			String cantMaxCel = global.getValor("cantidad.maxima.celulares");
			String indVentaExterna = "";
			String codTipoCliente="";
			
			//(+) indVentaExterna
			if (sesion.getAttribute("DatosVentaForm")!=null){
				DatosVentaForm datosVentaForm = (DatosVentaForm)sesion.getAttribute("DatosVentaForm");
				indVentaExterna = datosVentaForm.getIndVtaExterna();
				codTipoCliente=datosVentaForm.getCodTipoCliente();
				
			}
			//(-)
			
			//(+) busca  uso, central  codSubAlm
			if (sesion.getAttribute("DatosLineaForm")!=null){
				DatosLineaForm datosLineaForm = (DatosLineaForm)sesion.getAttribute("DatosLineaForm");				
				codCentral = datosLineaForm.getCodCentral();
				codSubAlm = datosLineaForm.getCodSubAlm();
				
				BuscaNumeroForm buscaNumeroForm = (BuscaNumeroForm)sesion.getAttribute("BuscaNumeroForm");
				if(buscaNumeroForm.getModuloOrigen() != null && 
						buscaNumeroForm.getModuloOrigen().trim().equals(global.getValor("parametro.fax")))
				{
					codUso = global.getValor("parametro.uso.fax");
				}else {
					codUso = datosLineaForm.getCodUsoLinea();
				}
			}
			//(-)
			
			//Busca categoria
			logger.debug("Tipo Cliente " + codTipoCliente);
			DatosNumeracionDTO datosNumeracionDTO = new DatosNumeracionDTO();
			datosNumeracionDTO.setCodActabo(obtenerActuacion(indVentaExterna, codTipoCliente, codUso));
			codCateg = delegate.obtieneCategoria(datosNumeracionDTO);
			//(-)
			
			datosNumeracionDTO = new DatosNumeracionDTO();
			datosNumeracionDTO.setCodCatNue(codCateg);
			datosNumeracionDTO.setCodCodUsoNue(codUso);
			datosNumeracionDTO.setCodCentNue(codCentral);
			datosNumeracionDTO.setCodSubalmNue(codSubAlm);
			datosNumeracionDTO.setLimiteInferior(new Long(rangoInferior));
			datosNumeracionDTO.setLimiteSuperior(new Long(rangoSuperior));
			datosNumeracionDTO.setCantidadMaximaNrosCelulares(Integer.parseInt(cantMaxCel));
			
			listaNumeros = delegate.obtieneNumeracionReutilizable(datosNumeracionDTO);
			
			listaRetorno =  new NumeroAjaxDTO[listaNumeros.length];
			for(int i=0; i<listaNumeros.length;i++){
				NumeroAjaxDTO numero = new NumeroAjaxDTO();
				numero.setNumCelular(String.valueOf(listaNumeros[i].getNumCelular()));
				numero.setCategoria(listaNumeros[i].getCodCategoria());
				numero.setFechaBaja(listaNumeros[i].getFechaBaja());
				listaRetorno[i] = numero;
			}
			
			sesion.setAttribute("listaNumeros", listaRetorno);
			sesion.removeAttribute("listaNumerosRango");
		}catch(Exception e){
        	String mensaje = e.getMessage()==null?"Ocurrió un error al obtener numeración reutilizable":e.getMessage();
        	retorno.setCodError("1");
			retorno.setMsgError(mensaje);
		}

		retorno.setLista(listaRetorno);
		logger.debug("obtenerNumeracionReutilizable:fin()");		
		return retorno;
	}

	/*
	 * Carga lista de numeracion por rango
	 */
	public RetornoListaAjaxDTO obtenerNumeracionRango(String rangoInferior, String rangoSuperior)
	{
		logger.debug("obtenerNumeracionRango:inicio()");
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);
		
		RetornoListaAjaxDTO retorno = new RetornoListaAjaxDTO();
		
		if (!validarSesion(sesion)){
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;	
		}
		
		NumeroRangoAjaxDTO[] listaRetorno = null;
		SeleccionNumeroCelularRangoDTO[] listaNumeros= null;
		
		try{
			String codCateg = "";
			String codUso = "";
			String codCentral ="";
			String codSubAlm = "";
			String cantMaxCel = global.getValor("cantidad.maxima.celulares");
			String indVentaExterna = "";
			String codTipoCliente="";
			//(+) indVentaExterna
			if (sesion.getAttribute("DatosVentaForm")!=null){
				DatosVentaForm datosVentaForm = (DatosVentaForm)sesion.getAttribute("DatosVentaForm");
				indVentaExterna = datosVentaForm.getIndVtaExterna();
				codTipoCliente=datosVentaForm.getCodTipoCliente();
			}
			//(-)
			
			//(+) busca  uso, central  codSubAlm
			if (sesion.getAttribute("DatosLineaForm")!=null){
				DatosLineaForm datosLineaForm = (DatosLineaForm)sesion.getAttribute("DatosLineaForm");				
				codCentral = datosLineaForm.getCodCentral();
				codSubAlm = datosLineaForm.getCodSubAlm();
				
				BuscaNumeroForm buscaNumeroForm = (BuscaNumeroForm)sesion.getAttribute("BuscaNumeroForm");
				if(buscaNumeroForm.getModuloOrigen() != null && 
						buscaNumeroForm.getModuloOrigen().trim().equals(global.getValor("parametro.fax")))
				{
					codUso = global.getValor("parametro.uso.fax");
				}else {
					codUso = datosLineaForm.getCodUsoLinea();
				}
			}
			//(-)
			
			//Busca categoria
			DatosNumeracionDTO datosNumeracionDTO = new DatosNumeracionDTO();
			datosNumeracionDTO.setCodActabo(obtenerActuacion(indVentaExterna, codTipoCliente,codUso));
			codCateg = delegate.obtieneCategoria(datosNumeracionDTO);
			//(-)
			
			datosNumeracionDTO = new DatosNumeracionDTO();
			datosNumeracionDTO.setCodCatNue(codCateg);
			datosNumeracionDTO.setCodCodUsoNue(codUso);
			datosNumeracionDTO.setCodCentNue(codCentral);
			datosNumeracionDTO.setCodSubalmNue(codSubAlm);
			datosNumeracionDTO.setLimiteInferior(new Long(rangoInferior));
			datosNumeracionDTO.setLimiteSuperior(new Long(rangoSuperior));
			datosNumeracionDTO.setCantidadMaximaNrosCelulares(Integer.parseInt(cantMaxCel));
			
			listaNumeros = delegate.obtieneNumeracionRango(datosNumeracionDTO);
			
			listaRetorno =  new NumeroRangoAjaxDTO[listaNumeros.length];
			for(int i=0; i<listaNumeros.length;i++){
				NumeroRangoAjaxDTO numero = new NumeroRangoAjaxDTO();
				numero.setNumDesde(String.valueOf(listaNumeros[i].getNumDesde()));
				numero.setNumHasta(String.valueOf(listaNumeros[i].getNumHasta()));
				numero.setCategoria(listaNumeros[i].getCodCategoria());
				listaRetorno[i] = numero;
			}
			
			sesion.setAttribute("listaNumerosRango", listaRetorno);
			sesion.removeAttribute("listaNumeros");
			
		}catch(Exception e){
        	String mensaje = e.getMessage()==null?"Ocurrió un error al obtener numeración rango":e.getMessage();
        	retorno.setCodError("1");
			retorno.setMsgError(mensaje);
		}

		retorno.setLista(listaRetorno);
		logger.debug("obtenerNumeracionRango:fin()");		
		return retorno;
	}

	/*
	 * Obtiene numeracion automatica, carga lista con un registro en sesion y retorna tabla origen de la numeracion
	 */
	public RetornoBusquedaNumeracionAjaxDTO obtenerNumeracionAutomatica()
	{
		logger.debug("obtenerNumeracionAutomatica:inicio()");
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);
		
		RetornoBusquedaNumeracionAjaxDTO retorno = new RetornoBusquedaNumeracionAjaxDTO();
		
		if (!validarSesion(sesion)){
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;	
		}
		
		NumeroAjaxDTO[] listaRetorno = new NumeroAjaxDTO[1];
		
		try{
			String codCelda = "";
			String codCentral ="";
			String codUso = "";			
			String indVentaExterna = "";
			String codTipoCliente="";
			
			//(+) indVentaExterna
			if (sesion.getAttribute("DatosVentaForm")!=null){
				DatosVentaForm datosVentaForm = (DatosVentaForm)sesion.getAttribute("DatosVentaForm");
				indVentaExterna = datosVentaForm.getIndVtaExterna();
				codTipoCliente=datosVentaForm.getCodTipoCliente();
			}
			//(-)
			
			//(+) busca  celda, central  uso
			if (sesion.getAttribute("DatosLineaForm")!=null){
				DatosLineaForm datosLineaForm = (DatosLineaForm)sesion.getAttribute("DatosLineaForm");
				codCelda = datosLineaForm.getCodCelda();
				codCentral = datosLineaForm.getCodCentral();
				BuscaNumeroForm buscaNumeroForm = (BuscaNumeroForm)sesion.getAttribute("BuscaNumeroForm");
				if(buscaNumeroForm.getModuloOrigen() != null && 
						buscaNumeroForm.getModuloOrigen().trim().equals(global.getValor("parametro.fax")))
				{
					codUso = global.getValor("parametro.uso.fax");
				}else {
					codUso = datosLineaForm.getCodUsoLinea();
				}
			}
			//(-)
			
			DatosNumeracionDTO datosNumeracionDTO = new DatosNumeracionDTO();
			datosNumeracionDTO.setCodCeldNue(codCelda);
			datosNumeracionDTO.setCodCentNue(codCentral);
			datosNumeracionDTO.setCodCodUsoNue(codUso);
			datosNumeracionDTO.setCodActabo(obtenerActuacion(indVentaExterna, codTipoCliente, codUso));
			logger.debug("Tipo Cliente " + codTipoCliente);
			datosNumeracionDTO = delegate.obtieneNumeracionAutomatica(datosNumeracionDTO);
			
			//Inicio P-CSR-11002 JLGN 14-11-2011
			//Se valida si el numero celular obtenido se encuentra asociado a un abonado
			//distindo de BAA y BAP
			delegate.validaDisponibilidadNumero(String.valueOf(datosNumeracionDTO.getNumCelular()));
			//Fin P-CSR-11002 JLGN 14-11-2011
			
			NumeroAjaxDTO numero = new NumeroAjaxDTO();
			numero.setNumCelular(String.valueOf(datosNumeracionDTO.getNumCelular()));
			numero.setFechaBaja(datosNumeracionDTO.getFecBaja());
			listaRetorno[0] = numero;
			
			sesion.setAttribute("listaNumeros", listaRetorno);
			sesion.removeAttribute("listaNumerosRango");
			
			retorno.setTablaNumeracion(datosNumeracionDTO.getNomtabla());
			retorno.setCategoria(datosNumeracionDTO.getCodCatNue());
			retorno.setNumero(String.valueOf(datosNumeracionDTO.getNumCelular()));
			retorno.setFechaBaja(datosNumeracionDTO.getFecBaja());
		}catch(Exception e){
        	String mensaje = e.getMessage()==null?"Ocurrió un error al obtener numeración automática":e.getMessage();
        	retorno.setCodError("1");
			retorno.setMsgError(mensaje);
		}

		logger.debug("obtenerNumeracionAutomatica:fin()");		
		return retorno;
	}

	/*
	 * Carga numero ya seleccionado
	 */
	public RetornoListaAjaxDTO cargaNumeroSel(String numeroSel)
	{
		logger.debug("cargaNumeroSel:inicio()");
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);
		
		RetornoListaAjaxDTO retorno = new RetornoListaAjaxDTO();
		
		if (!validarSesion(sesion)){
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;	
		}
		
		NumeroAjaxDTO[] listaRetorno = new NumeroAjaxDTO[1];
		NumeroAjaxDTO numero = new NumeroAjaxDTO();
		numero.setNumCelular(numeroSel);
		listaRetorno[0] = numero;
			
		sesion.setAttribute("listaNumeros", listaRetorno);
		sesion.removeAttribute("listaNumerosRango");
	
		retorno.setLista(listaRetorno);
		logger.debug("cargaNumeroSel:fin()");		
		return retorno;
	}

	/*
	 * Anula reserva automatica
	 */
	public RetornoValorAjaxDTO reponerNumeracionAutomatica(String numCelular, String tabla, String codCateg)
	{
		logger.debug("reponerNumeracionAutomatica:inicio()");
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);
		
		RetornoValorAjaxDTO retorno = new RetornoValorAjaxDTO();
		
		if (!validarSesion(sesion)){
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;	
		}
		
		try{
			String codCelda = "";
			String codCentral ="";
			String codUso = "";			
			String indVentaExterna = "";
			String codTipoCliente="";
			String codSubAlm = "";
			
			//(+) indVentaExterna
			if (sesion.getAttribute("DatosVentaForm")!=null){
				DatosVentaForm datosVentaForm = (DatosVentaForm)sesion.getAttribute("DatosVentaForm");
				indVentaExterna = datosVentaForm.getIndVtaExterna();
				codTipoCliente=datosVentaForm.getCodTipoCliente();
			}
			//(-)
			
			//(+) busca  celda, central  uso
			if (sesion.getAttribute("DatosLineaForm")!=null){
				DatosLineaForm datosLineaForm = (DatosLineaForm)sesion.getAttribute("DatosLineaForm");
				codCelda = datosLineaForm.getCodCelda();
				codCentral = datosLineaForm.getCodCentral();
				codUso = datosLineaForm.getCodUsoLinea();
				codSubAlm = datosLineaForm.getCodSubAlm();
			}
			//(-)
			
			NumeracionCelularDTO numeracionCelularDTO = new NumeracionCelularDTO();
			numeracionCelularDTO.setNombreTabla(tabla);
			numeracionCelularDTO.setCodSubALM(codSubAlm);
			numeracionCelularDTO.setCodCentral(codCentral);
			numeracionCelularDTO.setCodCat(codCateg);
			numeracionCelularDTO.setCodUso(codUso);
			numeracionCelularDTO.setNumCelular(new Long(numCelular));
			logger.info("(DesReserva) Reponer Número Celular P_REPONER_NUMERACION");
			delegate.reponerNumeracion(numeracionCelularDTO);

		}catch(Exception e){
        	String mensaje = e.getMessage()==null?"Ocurrió un error al reponer numeración automática":e.getMessage();
        	retorno.setCodError("1");
			retorno.setMsgError(mensaje);
		}

		logger.debug("reponerNumeracionAutomatica:fin()");		
		return retorno;

	}
	
	private String obtenerActuacion(String indVentaExterna, String codTipoCliente, String codUso) throws Exception{
		String codActuacion = "";
		
		if (!(codTipoCliente.equals(global.getValor("tipo.cliente.prepago"))))
		{
			if (codUso.equals(global.getValor("codigo.uso.hibrido"))){
			    codActuacion=global.getValor("codigo.actuacion.hibrido");
			}else{
			   	if (indVentaExterna.equals("1")){
				    codActuacion=global.getValor("codigo.actuacion.movil.externa");
			    }else{
				    codActuacion=global.getValor("codigo.actuacion.movil.interna");
			    }
		    }
		}else{
			codActuacion = global.getValor("codigo.actuacion.prepago");
		}    
		logger.debug("codActuacion="+codActuacion);
		return codActuacion;
	}
	
	public RetornoValidacionAjaxDTO existeNumeroSMS(Long numSMS)
	{
		logger.debug("existeNumeroSMS:inicio()");
		RetornoValidacionAjaxDTO retorno = new RetornoValidacionAjaxDTO();
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);
		
		if (!validarSesion(sesion)){
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;	
		}
		retorno.setValido(true);
		try{
			delegate.existeNumeroSMS(numSMS);			
		}catch(Exception e){
			retorno.setValido(false);
		}
		logger.debug("existeNumeroSMS:fin()");
		return retorno;	
	}
	
	private boolean validarSesion(HttpSession sesion){

		if (sesion == null)	return false;
			
		ParametrosGlobalesDTO sessionData = (ParametrosGlobalesDTO)sesion.getAttribute("paramGlobal"); 
		if (sessionData == null) return false;
		
		return true;
	}	
}
