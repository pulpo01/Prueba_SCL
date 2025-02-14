package com.tmmas.cl.scl.portalventas.web.action;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;
import org.apache.struts.util.LabelValueBean;

import com.tmmas.cl.scl.commonbusinessentities.dto.ParametrosGlobalesDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosGeneralesDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.RangoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.ProductDomainException;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.VentasException;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.RegistroVentaDTO;
import com.tmmas.cl.scl.portalventas.web.delegate.PortalVentasDelegate;
import com.tmmas.cl.scl.portalventas.web.dto.ClienteAjaxDTO;
import com.tmmas.cl.scl.portalventas.web.dto.NumeroAjaxDTO;
import com.tmmas.cl.scl.portalventas.web.dto.NumeroRangoAjaxDTO;
import com.tmmas.cl.scl.portalventas.web.form.BuscaNumeroForm;
import com.tmmas.cl.scl.portalventas.web.form.DatosLineaForm;
import com.tmmas.cl.scl.portalventas.web.form.DatosVentaForm;
import com.tmmas.cl.scl.portalventas.web.helper.Global;
import com.tmmas.cl.scl.productdomain.businessobject.dto.NumeracionCelularDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.NumeroPilotoDTO;

public class BuscaNumeroAction extends DispatchAction {
	private final Logger logger = Logger.getLogger(BuscaNumeroAction.class);
	private Global global = Global.getInstance();
	
	PortalVentasDelegate delegate = PortalVentasDelegate.getInstance();	
	
	public ActionForward inicio(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		logger.info("inicio, inicio");
		BuscaNumeroForm  buscaNumeroForm= (BuscaNumeroForm)form;
		buscaNumeroForm.setModuloOrigen("");	
		
		//carga parametros
		ParametrosGeneralesDTO parametrosTamPrefijo = new ParametrosGeneralesDTO();
		ParametrosGeneralesDTO parametrosLargoCelular = new ParametrosGeneralesDTO();
		
		parametrosTamPrefijo.setCodigoproducto(global.getValor("codigo.producto"));
		parametrosTamPrefijo.setCodigomodulo(global.getValor("codigo.modulo.GA"));
		parametrosTamPrefijo.setNombreparametro(global.getValor("parametro.tam_prefijo"));
		parametrosTamPrefijo = delegate.getParametroGeneral(parametrosTamPrefijo);
		
		parametrosLargoCelular.setCodigoproducto(global.getValor("codigo.producto"));
		parametrosLargoCelular.setCodigomodulo(global.getValor("codigo.modulo.GE"));
		parametrosLargoCelular.setNombreparametro(global.getValor("parametro.largo_n_celular"));
		parametrosLargoCelular =delegate.getParametroGeneral(parametrosLargoCelular);
		
		buscaNumeroForm.setLargoPrefijo(parametrosTamPrefijo.getValorparametro());
		buscaNumeroForm.setLargoNumCelular(parametrosLargoCelular.getValorparametro());

		if (buscaNumeroForm.getNumeroAnteriorRes()== null) buscaNumeroForm.setNumeroAnteriorRes("");
		
		HttpSession sesion= request.getSession(false);
		
		//(+)Actualiza numero ya ingresado
		if (sesion.getAttribute("numeroSel")!=null){
			NumeroAjaxDTO numeroSel = (NumeroAjaxDTO)sesion.getAttribute("numeroSel");
			buscaNumeroForm.setNumeroSel(numeroSel.getNumCelular());
		}else{
			buscaNumeroForm.setNumeroSel("");
			buscaNumeroForm.setNumeroAnteriorRes("");
		}
		//(-)
		
		buscaNumeroForm.setTablaNumeracionAut("");
		buscaNumeroForm.setCategoria("");
		
		//indice si es numero piloto
		if (sesion.getAttribute("DatosLineaForm")!=null){
			DatosLineaForm datosLineaForm = (DatosLineaForm)sesion.getAttribute("DatosLineaForm");
			buscaNumeroForm.setIndNumeroPiloto(datosLineaForm.getIndNumeroPiloto());			
			
			if(datosLineaForm.getCodGrpPrestacion().trim().equals("SMS"))
			{ 
				buscaNumeroForm.setIndNumeroCortoSMS("1");
			}
			
			//Verifica si viene de SCORING
			if(datosLineaForm.getCodModuloOrigen().trim().equals(global.getValor("modulo.web.scoring"))){
				buscaNumeroForm.setModuloOrigen(global.getValor("modulo.web.scoring"));
			}
			
		}
		
		if (sesion.getAttribute("clienteSel")!=null){
			ClienteAjaxDTO clienteSel = (ClienteAjaxDTO)sesion.getAttribute("clienteSel");
			String nombreCliente = (clienteSel.getNombreCliente()!=null?clienteSel.getNombreCliente():"") + " " ;
			nombreCliente = nombreCliente + (clienteSel.getNombreApellido1()!=null?clienteSel.getNombreApellido1():"") + " ";
			nombreCliente = nombreCliente + (clienteSel.getNombreApellido2()!=null?clienteSel.getNombreApellido2():"") + " ";
			buscaNumeroForm.setNombreCliente(nombreCliente);
		}
		
		logger.info("inicio, fin");
		
		return mapping.findForward("inicio");
	}
	
	public ActionForward buscarNumero(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.info("buscarNumero, inicio");
		
		logger.info("buscarNumero, fin");
		return mapping.findForward("inicio");
	}
	
	public ActionForward asociarRangosPiloto(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	throws Exception {
		logger.info("asociarRangosPiloto, inicio");
		HttpSession sesion = request.getSession(false);
		DatosLineaForm datosLineaForm = (DatosLineaForm)sesion.getAttribute("DatosLineaForm");
		BuscaNumeroForm  buscaNumeroForm = (BuscaNumeroForm)form;
		
		RangoDTO[] rangosDisponibles = delegate.obtieneRangosDisponibles(new Integer(datosLineaForm.getCodCentral()));		
		RangoDTO[] rangosAsociados = new RangoDTO[0];
		
		if (buscaNumeroForm.getRangosDisponiblesInicio()==null){//carga inicial
			buscaNumeroForm.setRangosDisponiblesInicio(listaRangos(rangosDisponibles));
			buscaNumeroForm.setRangosDisponibles(listaRangos(rangosDisponibles));
			buscaNumeroForm.setRangosAsociados(listaRangos(rangosAsociados));
		}
		
		//guarda listas originales, para usarlas en accion Cancelar
		List listaRangosDisponiblesOrig = buscaNumeroForm.getRangosDisponibles();
		List listaRangosAsociadosOrig = buscaNumeroForm.getRangosAsociados();		
		
		if (listaRangosDisponiblesOrig == null) listaRangosDisponiblesOrig = new ArrayList();
		if (listaRangosAsociadosOrig == null) listaRangosAsociadosOrig = new ArrayList();
		
		sesion.setAttribute("listaRangosDisponiblesOrig", listaRangosDisponiblesOrig);
		sesion.setAttribute("listaRangosAsociadosOrig", listaRangosAsociadosOrig);
				
		logger.info("asociarRangosPiloto, fin");
		return mapping.findForward("asociarRangosPiloto");
	}
	
	public ActionForward aceptarRangosPiloto(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.info("aceptarRangosPiloto, inicio");
		
		HttpSession sesion = request.getSession(false);
		BuscaNumeroForm  buscaNumeroForm = (BuscaNumeroForm)form;	
		
		
		if (buscaNumeroForm.getRangosAsociadosSeleccionados()!=null){
			//actualizar listas de disponibles y asociados
			String[] rangosAsociadosSeleccionados = buscaNumeroForm.getRangosAsociadosSeleccionados();			
			ArrayList rangosDisponiblesInicio = (ArrayList)buscaNumeroForm.getRangosDisponiblesInicio();
			
			ArrayList rangosAsociadosNuevo = new ArrayList();
			ArrayList rangosDisponiblesNuevo = new ArrayList();
			
			for(int i=0;i<rangosDisponiblesInicio.size();i++){
				LabelValueBean rangoInicio =(LabelValueBean)rangosDisponiblesInicio.get(i);
				//Asociados
				boolean existeAsociado = false;
				for(int j=0; j<rangosAsociadosSeleccionados.length;j++){
					if (rangoInicio.getValue().equals(rangosAsociadosSeleccionados[j])){
						rangosAsociadosNuevo.add(rangoInicio);
						existeAsociado = true;
					}
				}
				//Disponibles				
				if (!existeAsociado){
					rangosDisponiblesNuevo.add(rangoInicio);
				}
			}//fin for
			
			buscaNumeroForm.setRangosDisponibles(rangosDisponiblesNuevo);
			buscaNumeroForm.setRangosAsociados(rangosAsociadosNuevo);
			
				
		}
		
		logger.info("aceptarRangosPiloto, fin");		
		return aceptar(mapping, form, request, response);

	}
	
	public ActionForward aceptar(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.info("aceptar, inicio");
		HttpSession sesion = request.getSession(false);
		BuscaNumeroForm buscaNumeroForm = (BuscaNumeroForm) form;
		String user = "";
		
		
		//actualiza reserva solo si selecciona un numero distinto al anterior guardado
		if (!buscaNumeroForm.getNumeroAnteriorRes().equals(buscaNumeroForm.getNumeroSel())){
			//(+) busqueda de datos
			String codUso = "";
			String codCentral ="";
			String codSubAlm = "";
			String indVentaExterna = "";
			String codTipoCliente="";			
			
			if (sesion.getAttribute("DatosVentaForm")!=null){
				DatosVentaForm datosVentaForm = (DatosVentaForm)sesion.getAttribute("DatosVentaForm");
				indVentaExterna = datosVentaForm.getIndVtaExterna();
				codTipoCliente=datosVentaForm.getCodTipoCliente();
			}
			if (sesion.getAttribute("DatosLineaForm")!=null){
				DatosLineaForm datosLineaForm = (DatosLineaForm)sesion.getAttribute("DatosLineaForm");
				codUso = datosLineaForm.getCodUsoLinea();
				codCentral = datosLineaForm.getCodCentral();
				codSubAlm = datosLineaForm.getCodSubAlm();
			}
			
			//Busca categoria
			/*DatosNumeracionDTO datosNumeracionDTO = new DatosNumeracionDTO();
			datosNumeracionDTO.setCodActabo(obtenerActuacion(indVentaExterna, codTipoCliente));
			codCateg = delegate.obtieneCategoria(datosNumeracionDTO);*/
			
			//Numero transaccion
			RegistroVentaDTO secuenciaTransaccion = delegate.getSecuenciaTransacabo();
			
			//(-)
			
			//(+)---- Anular ------------------ ->NumeroAnteriorRes
			if (!buscaNumeroForm.getNumeroAnteriorRes().equals("")){
				//Tabla anterior
				String tablaNumeroAnteriorRes  = "";
				String categoriaAnt = "";
				if (sesion.getAttribute("numeroSel")!=null){
					tablaNumeroAnteriorRes = ((NumeroAjaxDTO)sesion.getAttribute("numeroSel")).getTablaNumeracion();
					categoriaAnt = ((NumeroAjaxDTO)sesion.getAttribute("numeroSel")).getCategoria();
				}
				
				NumeracionCelularDTO numeracionCelularDTO = new NumeracionCelularDTO();
				numeracionCelularDTO.setNombreTabla(tablaNumeroAnteriorRes);
				numeracionCelularDTO.setCodSubALM(codSubAlm);
				numeracionCelularDTO.setCodCentral(codCentral);
				numeracionCelularDTO.setCodCat(categoriaAnt);
				numeracionCelularDTO.setCodUso(codUso);
				numeracionCelularDTO.setNumCelular(new Long(buscaNumeroForm.getNumeroAnteriorRes()));
				logger.info("(DesReserva) Reponer Número Celular P_REPONER_NUMERACION");
				delegate.reponerNumeracion(numeracionCelularDTO);
				logger.info("(DesReserva) Borrar registro en la GA_RESNUMCEL");
				delegate.desReservaNumeroCelular(numeracionCelularDTO);
				
				//limpia variable
				buscaNumeroForm.setNumeroAnteriorRes("");
			}
			//(-)------------------------------------------
			
			//(+)------ Reservar ------------------------------------
			String tabla = "";
			String categoria = "";
			String fechaBaja = null;
			if (buscaNumeroForm.getTipoBusqueda().equals("M")){ //busqueda manual 
				String tipoLista = "N"; //numero
				if (buscaNumeroForm.getCodCriterioBusqueda().equals(global.getValor("codigo.busq.numeracion.reservados"))){
					tabla  = global.getValor("consulta.numeracion.ga_reserva");
				}else if  (buscaNumeroForm.getCodCriterioBusqueda().equals(global.getValor("codigo.busq.numeracion.reutilizables"))){
					tabla  = global.getValor("consulta.numeracion.ga_celnum_reutil");
				}else if  (buscaNumeroForm.getCodCriterioBusqueda().equals(global.getValor("codigo.busq.numeracion.rango"))){
					tabla  = global.getValor("consulta.numeracion.ga_celnum_uso");
					tipoLista = "R";
				}
				//buscar categoria y fecha de baja
				if (tipoLista.equals("N")){
					NumeroAjaxDTO[] listaNumeros = (NumeroAjaxDTO[])sesion.getAttribute("listaNumeros");
					if (listaNumeros!=null){
						for(int i=0; i<listaNumeros.length;i++){
							if (listaNumeros[i].getNumCelular().equals(buscaNumeroForm.getNumeroSel())){
								categoria = listaNumeros[i].getCategoria();
								
								if (buscaNumeroForm.getCodCriterioBusqueda().equals(global.getValor("codigo.busq.numeracion.reutilizables"))){
									fechaBaja = listaNumeros[i].getFechaBaja();
								}
								
								break;
							}
						}
					}
				}else{
					NumeroRangoAjaxDTO[] listaNumeros = (NumeroRangoAjaxDTO[])sesion.getAttribute("listaNumerosRango");
					if (listaNumeros!=null){					
						for(int i=0; i<listaNumeros.length;i++){
							if (listaNumeros[i].getNumDesde().equals(buscaNumeroForm.getRangoInfSel())){
								categoria = listaNumeros[i].getCategoria();
								break;
							}
						}
					}
				}
			}else if (buscaNumeroForm.getTipoBusqueda().equals("A")){ //busqueda automatica
				tabla  = buscaNumeroForm.getTablaNumeracionAut();
				categoria = buscaNumeroForm.getCategoria();
				fechaBaja = (buscaNumeroForm.getFechaBaja().equals("null")||buscaNumeroForm.getFechaBaja().equals(""))?null:buscaNumeroForm.getFechaBaja();
			}
			logger.debug("tabla="+tabla);
			logger.debug("categoria="+categoria);
			logger.debug("fechaBaja="+fechaBaja);

			NumeracionCelularDTO numeracionCelularDTO = new NumeracionCelularDTO();
			numeracionCelularDTO.setSecuencia(String.valueOf(secuenciaTransaccion.getNumeroTransaccionVenta()));
			numeracionCelularDTO.setNombreTabla(tabla);
			numeracionCelularDTO.setCodSubALM(codSubAlm);
			numeracionCelularDTO.setCodCentral(codCentral);
			numeracionCelularDTO.setCodCat(categoria);
			numeracionCelularDTO.setCodUso(codUso);
			numeracionCelularDTO.setNumCelular(new Long(buscaNumeroForm.getNumeroSel()));

			// Paso 1
			if (buscaNumeroForm.getTipoBusqueda().equals("M")) {
				logger.info("(Reserva) Ejecuta P_NUMERACION_MANUAL");
				buscaNumeroForm.setMensajeError(null);
				try {
					//Inicio P-CSR-11002 JLGN 14-11-2011
					//Se valida si el numero celular obtenido se encuentra asociado a un abonado
					//distindo de BAA y BAP
					delegate.validaDisponibilidadNumero(String.valueOf(numeracionCelularDTO.getNumCelular()));
					//Fin P-CSR-11002 JLGN 14-11-2011
					
					delegate.reservaNumeroCelular(numeracionCelularDTO); 
					//throw new VentasException("VentasException para pruebas");
				}//Inicio P-CSR-11002 JLGN 14-11-2011
				catch(ProductDomainException ep){
					logger.error(ep.getMessage());
					String mensajeErrorReserva = "No se pudo reservar el número. " + ep.getDescripcionEvento();
					logger.error(mensajeErrorReserva);
					buscaNumeroForm.setMensajeError(mensajeErrorReserva);
					sesion.removeAttribute("numeroSel");
					return mapping.findForward("inicio");
					
				}//Fin P-CSR-11002 JLGN 14-11-2011
				catch (VentasException ex) {
					logger.error(ex.getMessage());
					String mensajeErrorReserva = "No se pudo reservar el número. Por favor, intente nuevamente.";
					logger.error(mensajeErrorReserva);
					buscaNumeroForm.setMensajeError(mensajeErrorReserva);
					sesion.removeAttribute("numeroSel");
					return mapping.findForward("inicio");
				}
			}
			
			//Paso 2
			numeracionCelularDTO.setNumLinea(new Long("1"));
			numeracionCelularDTO.setNumOrden(new Long("1"));
			user = ((ParametrosGlobalesDTO)sesion.getAttribute("paramGlobal")).getCodUsuario();
			numeracionCelularDTO.setNomUsuarioSCL(user);
			numeracionCelularDTO.setIndProcNum(tabla);
			numeracionCelularDTO.setFecBaja(fechaBaja);
			logger.info("(Reserva) Inserta GA_RESNUMCEL");
			delegate.insertarNumeroCelularReservado(numeracionCelularDTO);
			
			//actualiza variable
			buscaNumeroForm.setNumeroAnteriorRes(buscaNumeroForm.getNumeroSel());
			
			//Dejar numero en sesion para cargarlo en Datos Linea
			NumeroAjaxDTO numeroSel = new NumeroAjaxDTO();
			numeroSel.setNumCelular(buscaNumeroForm.getNumeroSel());
			numeroSel.setTablaNumeracion(tabla);
			numeroSel.setCategoria(categoria);
			

			sesion.removeAttribute("listaNumeros");
			sesion.removeAttribute("listaNumerosRango");		
			sesion.setAttribute("numeroSel", numeroSel);
		}//fin 	if (!buscaNumeroForm.getNumeroAnteriorRes().equals(buscaNumeroForm.getNumeroSel()))
		
		logger.info("aceptar, fin");
		
		if (buscaNumeroForm.getIndNumeroPiloto().equals("1") && buscaNumeroForm.getRangosAsociadosSeleccionados()!=null)
		{
			//En caso de ingresar nuevamente a la pagina se debe eliminar los rangos si fueron insertados previamente
			if (sesion.getAttribute("numeroSel")!=null)
			{
				delegate.eliminarRangos(Long.valueOf(buscaNumeroForm.getNumeroSel()));
			}
			
			//Setea rangos de numeros
			for(int i=0;i<buscaNumeroForm.getRangosAsociadosSeleccionados().length; i++)
			{
				NumeroPilotoDTO  nroPiloto= new NumeroPilotoDTO();
				String[] numDesde = buscaNumeroForm.getRangosAsociadosSeleccionados()[i].trim().split("-");
				nroPiloto.setNumDesde(Long.valueOf(numDesde[0]).longValue());
				user = ((ParametrosGlobalesDTO)sesion.getAttribute("paramGlobal")).getCodUsuario();
				nroPiloto.setNomUsuarOra(user);
				nroPiloto.setNumeroPiloto(Long.valueOf(buscaNumeroForm.getNumeroSel()).longValue());
				delegate.insertaRangoAsociadoNroPiloto(nroPiloto);				
			}
		}
		if(buscaNumeroForm.getModuloOrigen()!= null && 
				buscaNumeroForm.getModuloOrigen().trim().equals(global.getValor("parametro.fax")))
		{
			return mapping.findForward("volverSS");
		}else if(buscaNumeroForm.getModuloOrigen()!= null && 
				buscaNumeroForm.getModuloOrigen().trim().equals(global.getValor("modulo.web.scoring"))){
			return mapping.findForward("aceptarScoring");
		}else{
			return mapping.findForward("aceptar");
		}
	}
	
	public ActionForward cancelarRangosPiloto(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception 
	{
		logger.debug("cancelar, inicio");
		BuscaNumeroForm  buscaNumeroForm= (BuscaNumeroForm)form;
		HttpSession sesion = request.getSession(false);
		
		//reestablece listas originales
		List listaRangosDisponiblesOrig = (ArrayList)sesion.getAttribute("listaRangosDisponiblesOrig");
		List listaRangosAsociadosOrig = (ArrayList)sesion.getAttribute("listaRangosAsociadosOrig");
		buscaNumeroForm.setRangosDisponibles(listaRangosDisponiblesOrig);
		buscaNumeroForm.setRangosAsociados(listaRangosAsociadosOrig);
		
		sesion.removeAttribute("listaRangosDisponiblesOrig");
		sesion.removeAttribute("listaRangosAsociadosOrig");		
		
		//(+) busqueda de datos
		String codUso = "";
		String codCentral ="";
		String codSubAlm = "";		
		
		if (sesion.getAttribute("DatosLineaForm")!=null){
			DatosLineaForm datosLineaForm = (DatosLineaForm)sesion.getAttribute("DatosLineaForm");
			codUso = datosLineaForm.getCodUsoLinea();
			codCentral = datosLineaForm.getCodCentral();
			codSubAlm = datosLineaForm.getCodSubAlm();
		}
		
		//Desreserva numero solo si no existen rangos asociados		
		if(listaRangosAsociadosOrig == null || listaRangosAsociadosOrig.size() == 0)
		{
			String tabla = "";
			String categoria = "";
			String fechaBaja = null;
			if (buscaNumeroForm.getTipoBusqueda().equals("M")){ //busqueda manual 
				String tipoLista = "N"; //numero
				if (buscaNumeroForm.getCodCriterioBusqueda().equals(global.getValor("codigo.busq.numeracion.reservados"))){
					tabla  = global.getValor("consulta.numeracion.ga_reserva");
				}else if  (buscaNumeroForm.getCodCriterioBusqueda().equals(global.getValor("codigo.busq.numeracion.reutilizables"))){
					tabla  = global.getValor("consulta.numeracion.ga_celnum_reutil");
				}else if  (buscaNumeroForm.getCodCriterioBusqueda().equals(global.getValor("codigo.busq.numeracion.rango"))){
					tabla  = global.getValor("consulta.numeracion.ga_celnum_uso");
					tipoLista = "R";
				}
				//buscar categoria y fecha de baja
				if (tipoLista.equals("N")){
					NumeroAjaxDTO[] listaNumeros = (NumeroAjaxDTO[])sesion.getAttribute("listaNumeros");
					if (listaNumeros!=null){
						for(int i=0; i<listaNumeros.length;i++){
							if (listaNumeros[i].getNumCelular().equals(buscaNumeroForm.getNumeroSel())){
								categoria = listaNumeros[i].getCategoria();
								
								if (buscaNumeroForm.getCodCriterioBusqueda().equals(global.getValor("codigo.busq.numeracion.reutilizables"))){
									fechaBaja = listaNumeros[i].getFechaBaja();
								}
								
								break;
							}
						}
					}
				}else{
					NumeroRangoAjaxDTO[] listaNumeros = (NumeroRangoAjaxDTO[])sesion.getAttribute("listaNumerosRango");
					if (listaNumeros!=null){					
						for(int i=0; i<listaNumeros.length;i++){
							if (listaNumeros[i].getNumDesde().equals(buscaNumeroForm.getRangoInfSel())){
								categoria = listaNumeros[i].getCategoria();
								break;
							}
						}
					}
				}
			}else if (buscaNumeroForm.getTipoBusqueda().equals("A")){ //busqueda automatica
				tabla  = buscaNumeroForm.getTablaNumeracionAut();
				categoria = buscaNumeroForm.getCategoria();
				fechaBaja = (buscaNumeroForm.getFechaBaja().equals("null")||buscaNumeroForm.getFechaBaja().equals(""))?null:buscaNumeroForm.getFechaBaja();
			}
			logger.debug("tabla="+tabla);
			logger.debug("categoria="+categoria);
			logger.debug("fechaBaja="+fechaBaja);
	
			NumeracionCelularDTO numeracionCelularDTO = new NumeracionCelularDTO();
			numeracionCelularDTO.setNombreTabla(tabla);
			numeracionCelularDTO.setCodSubALM(codSubAlm);
			numeracionCelularDTO.setCodCentral(codCentral);
			numeracionCelularDTO.setCodCat(categoria);
			numeracionCelularDTO.setCodUso(codUso);
			numeracionCelularDTO.setNumCelular(new Long(buscaNumeroForm.getNumeroSel()));
			logger.info("(DesReserva) Reponer Número Celular P_REPONER_NUMERACION");
			delegate.reponerNumeracion(numeracionCelularDTO);
			logger.info("(DesReserva) Borrar registro en la GA_RESNUMCEL");
			delegate.desReservaNumeroCelular(numeracionCelularDTO);
		}
	
		logger.debug("cancelar, fin");
		return cancelar(mapping, form, request, response);
	}
	
	
	public ActionForward cancelar(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.debug("cancelar, inicio");
		HttpSession sesion = request.getSession(false);
		BuscaNumeroForm  buscaNumeroForm= (BuscaNumeroForm)form;
		
		sesion.removeAttribute("numeroSel");
		sesion.removeAttribute("listaNumeros");
		sesion.removeAttribute("listaNumerosRango");
		
		logger.debug("cancelar, fin"); 
		
		if(buscaNumeroForm.getModuloOrigen()!= null && 
				buscaNumeroForm.getModuloOrigen().trim().equals(global.getValor("parametro.fax")))
		{
			return mapping.findForward("volverSS");
		}else if(buscaNumeroForm.getModuloOrigen()!= null && 
					buscaNumeroForm.getModuloOrigen().trim().equals(global.getValor("modulo.web.scoring")))
		{
				return mapping.findForward("cancelarScoring");
		} else {
		
			return mapping.findForward("cancelar");
		}	
	}
	
	public ActionForward irAMenu(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		logger.debug("irAMenu, inicio");
		logger.debug("irAMenu, fin");
		
		return mapping.findForward("irAMenu");
	}
	
	private String obtenerActuacion(String indVentaExterna, String codTipoCliente) throws Exception{
		String codActuacion = "";
		
		if (!(codTipoCliente.equals(global.getValor("tipo.cliente.prepago"))))
		{
		   	if (indVentaExterna.equals("1")){
			    codActuacion=global.getValor("codigo.actuacion.movil.externa");
		    }else{
			    codActuacion=global.getValor("codigo.actuacion.movil.interna");
		    }
		}else{
			codActuacion = global.getValor("codigo.actuacion.prepago");
		}    
		logger.debug("codActuacion="+codActuacion);
		return codActuacion;
	}
	
	public ActionForward volverSS(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.debug("cancelar, inicio");
		HttpSession sesion = request.getSession(false);
		
		sesion.removeAttribute("numeroSel");
		sesion.removeAttribute("listaNumeros");
		sesion.removeAttribute("listaNumerosRango");
		
		logger.debug("cancelar, fin");
		
		return mapping.findForward("volverSS");
	}
	
	private List listaRangos(RangoDTO[] rangos)
	{
		List list = new ArrayList();
		
		if (rangos == null || rangos.length < 1)
			return list;
		
		for(int i = 0; i < rangos.length; i++)
		{
			StringBuffer buffer = new StringBuffer();
			buffer.append(rangos[i].getNumDesde()).append(" - ").append(rangos[i].getNumHasta());
			
			list.add(new LabelValueBean(buffer.toString(), "" + rangos[i].getNumDesde()));
		}
		
		return list;		
	}
	
	public ActionForward inicioSSFax(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		logger.info("inicio, inicio");
		
		BuscaNumeroForm buscaNumeroForm = (BuscaNumeroForm)form;
		buscaNumeroForm.setModuloOrigen(global.getValor("parametro.fax"));		
		
		//carga parametros
		ParametrosGeneralesDTO parametrosTamPrefijo = new ParametrosGeneralesDTO();
		ParametrosGeneralesDTO parametrosLargoCelular = new ParametrosGeneralesDTO();
		
		parametrosTamPrefijo.setCodigoproducto(global.getValor("codigo.producto"));
		parametrosTamPrefijo.setCodigomodulo(global.getValor("codigo.modulo.GA"));
		parametrosTamPrefijo.setNombreparametro(global.getValor("parametro.tam_prefijo"));
		parametrosTamPrefijo = delegate.getParametroGeneral(parametrosTamPrefijo);
		
		parametrosLargoCelular.setCodigoproducto(global.getValor("codigo.producto"));
		parametrosLargoCelular.setCodigomodulo(global.getValor("codigo.modulo.GE"));
		parametrosLargoCelular.setNombreparametro(global.getValor("parametro.largo_n_celular"));
		parametrosLargoCelular =delegate.getParametroGeneral(parametrosLargoCelular);
		
		buscaNumeroForm.setLargoPrefijo(parametrosTamPrefijo.getValorparametro());
		buscaNumeroForm.setLargoNumCelular(parametrosLargoCelular.getValorparametro());

		if (buscaNumeroForm.getNumeroAnteriorRes()== null) buscaNumeroForm.setNumeroAnteriorRes("");
		
		HttpSession sesion= request.getSession(false);
		
		//(+)Actualiza numero ya ingresado
		if (sesion.getAttribute("numeroSel")!=null){
			NumeroAjaxDTO numeroSel = (NumeroAjaxDTO)sesion.getAttribute("numeroSel");
			buscaNumeroForm.setNumeroSel(numeroSel.getNumCelular());
		}else{
			buscaNumeroForm.setNumeroSel("");
			buscaNumeroForm.setNumeroAnteriorRes("");
		}
		//(-)
		
		buscaNumeroForm.setTablaNumeracionAut("");
		buscaNumeroForm.setCategoria("");
		
		if (sesion.getAttribute("clienteSel")!=null){
			ClienteAjaxDTO clienteSel = (ClienteAjaxDTO)sesion.getAttribute("clienteSel");
			String nombreCliente = (clienteSel.getNombreCliente()!=null?clienteSel.getNombreCliente():"") + " " ;
			nombreCliente = nombreCliente + (clienteSel.getNombreApellido1()!=null?clienteSel.getNombreApellido1():"") + " ";
			nombreCliente = nombreCliente + (clienteSel.getNombreApellido2()!=null?clienteSel.getNombreApellido2():"") + " ";
			buscaNumeroForm.setNombreCliente(nombreCliente);
		}
		
		logger.info("inicio, fin");
		
		return mapping.findForward("inicio");
	}
	
	public ActionForward asociarNumerosCortos(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	throws Exception {

		logger.info("asociarNumerosCortos, inicio");
		logger.info("asociarNumerosCortos, fin");
		return mapping.findForward("asociarNumerosCortos");
	}
	
	public ActionForward recargar(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.info("BuscaNumeroAction,recargar");
		return mapping.findForward("inicio");
	}
	
}
