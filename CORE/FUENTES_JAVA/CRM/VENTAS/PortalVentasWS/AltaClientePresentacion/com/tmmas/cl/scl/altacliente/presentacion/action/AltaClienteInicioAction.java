package com.tmmas.cl.scl.altacliente.presentacion.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.scl.altacliente.presentacion.delegate.AltaClienteDelegate;
import com.tmmas.cl.scl.altacliente.presentacion.form.AltaClienteInicioForm;
import com.tmmas.cl.scl.altacliente.presentacion.form.DatosEmpresaForm;
import com.tmmas.cl.scl.altacliente.presentacion.form.DatosParticularForm;
import com.tmmas.cl.scl.altacliente.presentacion.helper.Global;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ClasificacionDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.DatosClienteBuroDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.IdentificadorCivilComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.MensajePromocionalDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.OperadoraDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ValorClasificacionDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.exception.AltaClienteException;
import com.tmmas.cl.scl.commonbusinessentities.dto.ParametrosGlobalesDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosGeneralesDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.DatosGeneralesDTO;


public class AltaClienteInicioAction extends DispatchAction {
	private final Logger logger = Logger.getLogger(AltaClienteInicioAction.class);
	private Global global = Global.getInstance();
	
	AltaClienteDelegate delegate = AltaClienteDelegate.getInstance();	
	
	public AltaClienteInicioAction(){		
		logger.debug("AltaClienteInicioAction():Begin");
		UtilLog.setLog(global.getValorExterno("PortalVentasWeb.log"));
		logger.debug("AltaClienteInicioAction():End");
	}
	
	/* ---(+) Metodo llamado desde el link Alta Cliente en la Solicitud de Venta --- */
	public ActionForward inicioSolVenta(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("inicioSolVenta,inicio");
		AltaClienteInicioForm altaClienteActionForm = (AltaClienteInicioForm) form;
		altaClienteActionForm.setModuloOrigen(global.getValor("modulo.web.solicitudventa"));
		logger.trace("global.getValor(\"modulo.web.solicitudventa\"): " + global.getValor("modulo.web.solicitudventa"));
		logger.info("inicioSolVenta,fin");
		//P-CSR-11002 JLGN 27-10-2011
		request.getSession().removeAttribute("mensajeError");
		return inicio(mapping, form, request, response);
	}
	/* ---(-) Metodo llamado desde el link Alta Cliente en la Solicitud de Venta --- */

	public ActionForward inicioAlta(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("inicioAlta,inicio");
		AltaClienteInicioForm altaClienteActionForm = (AltaClienteInicioForm) form;
		altaClienteActionForm.setModuloOrigen(global.getValor("modulo.web.altacliente"));
		logger.trace("global.getValor(\"modulo.web.altacliente\"): " + global.getValor("modulo.web.altacliente"));
		logger.info("inicioAlta,fin");
		//P-CSR-11002 JLGN 27-10-2011
		request.getSession().removeAttribute("mensajeError");		
		return inicio(mapping, form, request, response);
	}

	public ActionForward inicio(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		logger.info("AltaClienteInicio,inicio");
				
		AltaClienteInicioForm altaClienteActionForm = (AltaClienteInicioForm) form;
		
		limpiarSesion(request,altaClienteActionForm);
		
		HttpSession sesion = request.getSession(false);
		
		String codOperadora = ((ParametrosGlobalesDTO)sesion.getAttribute("paramGlobal")).getCodOperadora();
		altaClienteActionForm.setCodOperadora(codOperadora);
		altaClienteActionForm.setCodOperadoraSalvador(global.getValor("codigo.operadora.salvador"));
		
		DatosGeneralesDTO datosGenerales = null;
		
		//(+)-- Carga de listas --
		//Tipo de Clientes
		datosGenerales = new DatosGeneralesDTO();
		datosGenerales.setCodigoModulo(global.getValor("codigo.modulo.GE"));
		datosGenerales.setTabla(global.getValor("tabla.clientes"));
		datosGenerales.setColumna(global.getValor("columna.tipo.cliente"));
		DatosGeneralesDTO[] arrayTipoCliente = delegate.getListCodigo(datosGenerales);
		altaClienteActionForm.setArrayTipoCliente(arrayTipoCliente);
		
		//Segmentos-- se obtienen en DWR
		
		//Color
		ValorClasificacionDTO[] arrayColor = delegate.getColores();
		altaClienteActionForm.setArrayColor(arrayColor);
		
		//Crediticia
		ValorClasificacionDTO[] arrayCrediticia = delegate.getCrediticia();
		altaClienteActionForm.setArrayCrediticia(arrayCrediticia);
		
		//Categorias
		ValorClasificacionDTO[] arrayCategoria = delegate.getCategorias();
		altaClienteActionForm.setArrayCategoriaCliente(arrayCategoria);
		
		//Calificacion. Se soliita que sea un valor por defecto en caso de estar configurado en properties externo  
		//de lo contrario traer todas las calificaciones
		String codCalificacionDefecto = global.getValorExterno("modulo.web.alta.cliente.cod.calificacion.defecto");
		ValorClasificacionDTO[] arrayCalificacion = null;
		if(codCalificacionDefecto != null && !codCalificacionDefecto.trim().equals(""))
		{
			logger.debug("Valor por defecto Calificacion");
			ArrayList arrayCalificacionList = new ArrayList();
			ValorClasificacionDTO valorClasificacion = new ValorClasificacionDTO();
			valorClasificacion.setCodClasificacion(global.getValorExterno("modulo.web.alta.cliente.cod.calificacion.defecto"));
			valorClasificacion.setDesClasificacion(global.getValorExterno("modulo.web.alta.cliente.des.calificacion.defecto"));
			//Inicio P-CSR-11002 JLGN 26-04-2011 
			valorClasificacion.setIndDefecto(1);
			//Fin P-CSR-11002 JLGN 26-04-2011
			arrayCalificacionList.add(valorClasificacion);
			
			arrayCalificacion = (ValorClasificacionDTO[]) 
				ArrayUtl.copiaArregloTipoEspecifico(arrayCalificacionList.toArray(), ValorClasificacionDTO.class);		
		}else {
			logger.debug("Valor por BD Calificacion");
			arrayCalificacion= delegate.getCalificaciones();
		}
		
		altaClienteActionForm.setArrayCalificacion(arrayCalificacion);
		
		String codigoNIT = global.getValor("codigo.identificador.NIT");
		
		//Tipo identificacion
		IdentificadorCivilComDTO[] arrayIdentificadores = delegate.getTipoIdentificadoresCiviles();
		altaClienteActionForm.setArrayIdentificadorCliente(arrayIdentificadores);
		
		//Inicio P-CSR-11003 JLGN 05-08-2011
		//Mensaje Promocional
		MensajePromocionalDTO[] arrayMensajes = delegate.getMensajePromocional();
		altaClienteActionForm.setArrayMensajesPromocionales(arrayMensajes);
		
		//Fin P-CSR-11003 JLGN 05-08-2011
		if (altaClienteActionForm.getCodOperadora().equalsIgnoreCase(global.getValor("codigo.operadora.salvador"))) {
			// Solo se deben mostrar 4 tipos de identificador: PASAPORTE, DUI, NIT, RESIDENTE
			String codigoDUI = global.getValor("codigo.identificador.sv.DUI");
			String codigoPasaporte = global.getValor("codigo.identificador.sv.PASAPORTE");
			String codigoResidente = global.getValor("codigo.identificador.sv.RESIDENTE");
			ArrayList arrayAuxIdenticadores1Salvador = new ArrayList();
			ArrayList arrayAuxIdenticadores2Salvador = new ArrayList();

			for (int i = 0; i < arrayIdentificadores.length; i++) {
				IdentificadorCivilComDTO identAux = (IdentificadorCivilComDTO) arrayIdentificadores[i];
				if (identAux.getCodigoTipIdentif().equals(codigoNIT)
						|| identAux.getCodigoTipIdentif().equals(codigoPasaporte)
						|| identAux.getCodigoTipIdentif().equals(codigoResidente)
						|| identAux.getCodigoTipIdentif().equals(codigoDUI)) {
					arrayAuxIdenticadores1Salvador.add(identAux);
				}
				else {
					arrayAuxIdenticadores2Salvador.add(identAux);
				}
			}
			IdentificadorCivilComDTO[] arrayIdenticadores1Salvador = (IdentificadorCivilComDTO[]) ArrayUtl
					.copiaArregloTipoEspecifico(arrayAuxIdenticadores1Salvador.toArray(),
							IdentificadorCivilComDTO.class);
			IdentificadorCivilComDTO[] arrayIdenticadores2Salvador = (IdentificadorCivilComDTO[]) ArrayUtl
					.copiaArregloTipoEspecifico(arrayAuxIdenticadores2Salvador.toArray(),
							IdentificadorCivilComDTO.class);

			altaClienteActionForm.setArrayIdentificador1(arrayIdenticadores1Salvador);
			altaClienteActionForm.setArrayIdentificador2(arrayIdenticadores2Salvador);
		}
		else if (altaClienteActionForm.getCodOperadora().equalsIgnoreCase(global.getValor("codigo.operadora.guatemala"))){
			// con NIT y sin NIT
			ArrayList arrayIdentificadoresPrincipal = new ArrayList();
			ArrayList arrayIdentificadoresSecundario = new ArrayList();

			/*
			 * JIB - Incidencia 130994. Solicita por parte de operadora guatemala que en el primer combo
			 * de tipos de identificación aparezca no solo el NIT, sino todos.
			 */
			for (int i = 0; i < arrayIdentificadores.length; i++) {
				IdentificadorCivilComDTO dto = (IdentificadorCivilComDTO) arrayIdentificadores[i];
				arrayIdentificadoresPrincipal.add(dto);
				if (!dto.getCodigoTipIdentif().equals(codigoNIT)) {
					arrayIdentificadoresSecundario.add(dto);
				}
			}
			
			IdentificadorCivilComDTO[] arrayIdenticadoresNIT = (IdentificadorCivilComDTO[]) ArrayUtl
					.copiaArregloTipoEspecifico(arrayIdentificadoresPrincipal.toArray(), IdentificadorCivilComDTO.class);
			IdentificadorCivilComDTO[] arrayIdenticadoresSNIT = (IdentificadorCivilComDTO[]) ArrayUtl
					.copiaArregloTipoEspecifico(arrayIdentificadoresSecundario.toArray(), IdentificadorCivilComDTO.class);
			altaClienteActionForm.setArrayIdentificador1(arrayIdenticadoresNIT);
			altaClienteActionForm.setArrayIdentificador2(arrayIdenticadoresSNIT);
		}
		
		//ciclo de facturacion -- se obtienen en DWR
		//operadora
		OperadoraDTO[] arrayOperadora = delegate.getOperadoras();
		altaClienteActionForm.setArrayOperadora(arrayOperadora);
		//(-)-- Carga de listas --
		
		//datos iniciales
		//altaClienteActionForm.setTipoIdentificacionNIT(global.getValor("codigo.identificador.NIT")); QUITAR
		altaClienteActionForm.setCodCrediticiaExcepcionado(global.getValor("clasif.crediticia.excepcionado"));
		
		ParametrosGeneralesDTO parametrosIndFacElectronica = new ParametrosGeneralesDTO();
		parametrosIndFacElectronica.setCodigoproducto(global.getValor("codigo.producto"));
		parametrosIndFacElectronica.setCodigomodulo(global.getValor("codigo.modulo.GA"));
		parametrosIndFacElectronica.setNombreparametro(global.getValor("parametro.ind_fact_electronica"));
		try{
			parametrosIndFacElectronica = delegate.getParametroGeneral(parametrosIndFacElectronica);
			altaClienteActionForm.setParamIndFacturaElectronica(parametrosIndFacElectronica.getValorparametro());
		}catch(Exception e){
			altaClienteActionForm.setParamIndFacturaElectronica("");
		}
		
		ParametrosGeneralesDTO parametrosLargoCelular = new ParametrosGeneralesDTO();
		parametrosLargoCelular.setCodigoproducto(global.getValor("codigo.producto"));
		parametrosLargoCelular.setCodigomodulo(global.getValor("codigo.modulo.GE"));
		parametrosLargoCelular.setNombreparametro(global.getValor("parametro.largo_n_celular"));
		parametrosLargoCelular =delegate.getParametroGeneral(parametrosLargoCelular);
		altaClienteActionForm.setLargoNumCelular(parametrosLargoCelular.getValorparametro());
		
		altaClienteActionForm.setCodModuloSolicitudVenta(global.getValor("modulo.web.solicitudventa"));
		logger.trace("global.getValor(\"modulo.web.solicitudventa\"): " +  global.getValor("modulo.web.solicitudventa"));
		
		//control de visualizacion de clasificaciones
		//Clasificaciones
		logger.debug("Obtiene Clasificaciones");
		ClasificacionDTO[] arrayClasificacion = delegate.getClasificaciones();
		altaClienteActionForm.setArrayClasificacion(arrayClasificacion);		
		logger.debug("Obtuvo Clasificaciones");
		
		if (arrayClasificacion!=null){
			logger.debug("Arreglo de Clasificaciones es NOT NULL");	
			for (int i=0;i<arrayClasificacion.length;i++){
				logger.debug("ingreso al For");
				ClasificacionDTO clasificacion= (ClasificacionDTO)arrayClasificacion[i];
				ValorClasificacionDTO[] arrayValorDefecto = new ValorClasificacionDTO[1];
				
				if (clasificacion.getCodElemento().equalsIgnoreCase(global.getValor("codigo.clasificacion.color"))){					
					logger.debug("codigo.clasificacion.color");
					logger.debug("COLOR clasificacion.getIndVisible(): "+ clasificacion.getIndVisible());
					altaClienteActionForm.setFlagCtrlClasifColor((clasificacion.getIndVisible()==1)?"1":"0");
					
					//busca valor por defecto
					for(int j=0; j<altaClienteActionForm.getArrayColor().length;j++){
						if (altaClienteActionForm.getArrayColor()[j].getIndDefecto()==1){
							arrayValorDefecto[0] =  altaClienteActionForm.getArrayColor()[j];
							altaClienteActionForm.setCodColor(arrayValorDefecto[0].getCodClasificacion());break;							
						}
					}
					logger.debug("COLOR clasificacion.getIndActivo(): "+ clasificacion.getIndActivo());
					if(clasificacion.getIndActivo()==0)	altaClienteActionForm.setArrayColor(arrayValorDefecto);
					logger.debug("FIN COLOR");
				}//fin color
				else if (clasificacion.getCodElemento().equalsIgnoreCase(global.getValor("codigo.clasificacion.crediticia"))){
					logger.debug("codigo.clasificacion.crediticia");
					logger.debug("CREDITICIA clasificacion.getIndVisible(): "+ clasificacion.getIndVisible());
					altaClienteActionForm.setFlagCtrlClasifCrediticia((clasificacion.getIndVisible()==1)?"1":"0");
					
					//busca valor por defecto
					for(int j=0; j<altaClienteActionForm.getArrayCrediticia().length;j++){
						if (altaClienteActionForm.getArrayCrediticia()[j].getIndDefecto()==1){
							arrayValorDefecto[0] = altaClienteActionForm.getArrayCrediticia()[j];
							altaClienteActionForm.setCodCrediticia(arrayValorDefecto[0].getCodClasificacion());break;
						}
					}
					logger.debug("CREDITICIA clasificacion.getIndActivo(): "+ clasificacion.getIndActivo());
					if(clasificacion.getIndActivo()==0)	altaClienteActionForm.setArrayCrediticia(arrayValorDefecto);
					logger.debug("FIN CREDITICIA");
				}//fin crediticia
				else if (clasificacion.getCodElemento().equalsIgnoreCase(global.getValor("codigo.clasificacion.segmento"))){
					logger.debug("codigo.clasificacion.segmento");
					logger.debug("SEGMENTO clasificacion.getIndVisible(): "+ clasificacion.getIndVisible());
					altaClienteActionForm.setFlagCtrlClasifSegmento((clasificacion.getIndVisible()==1)?"1":"0");
					logger.debug("SEGMENTO clasificacion.getIndActivo(): "+ clasificacion.getIndActivo());
					altaClienteActionForm.setFlagCtrlClasifSegmentoActivo((clasificacion.getIndActivo()==1)?"1":"0");
					logger.debug("FIN SEGMENTO"); 
				}//fin segmento
				else if (clasificacion.getCodElemento().equalsIgnoreCase(global.getValor("codigo.clasificacion.categoria"))){
					logger.debug("codigo.clasificacion.categoria");
					logger.debug("CATEGORIA clasificacion.getIndVisible(): "+ clasificacion.getIndVisible());
					
					altaClienteActionForm.setFlagCtrlClasifCategoria((clasificacion.getIndVisible()==1)?"1":"0");
					
					//busca valor por defecto
					for(int j=0; j<altaClienteActionForm.getArrayCategoriaCliente().length;j++){
						if (altaClienteActionForm.getArrayCategoriaCliente()[j].getIndDefecto()==1){
							arrayValorDefecto[0] = altaClienteActionForm.getArrayCategoriaCliente()[j];
							altaClienteActionForm.setCategoriaCliente(arrayValorDefecto[0].getCodClasificacion());break;
						}
					}
					logger.debug("CATEGORIA clasificacion.getIndActivo(): "+ clasificacion.getIndActivo());
					if(clasificacion.getIndActivo()==0)	altaClienteActionForm.setArrayCategoriaCliente(arrayValorDefecto);
					logger.debug("FIN CATEGORIA");
				}//fin categoria
				else if (clasificacion.getCodElemento().equalsIgnoreCase(global.getValor("codigo.clasificacion.calificacion"))){
					logger.debug("codigo.clasificacion.calificacion");
					logger.debug("CALIFICACION clasificacion.getIndVisible(): "+ clasificacion.getIndVisible());
					
					altaClienteActionForm.setFlagCtrlClasifCalificacion((clasificacion.getIndVisible()==1)?"1":"0");
					logger.debug("Entra al For con largo: "+altaClienteActionForm.getArrayCalificacion().length);
					//busca valor por defecto
					for(int j=0; j<altaClienteActionForm.getArrayCalificacion().length;j++){
						logger.debug("Busca Dato por Defecto");
						if (altaClienteActionForm.getArrayCalificacion()[j].getIndDefecto()==1){
							logger.debug("Setea Dato por defecto a array: "+ altaClienteActionForm.getArrayCalificacion()[j]);
							arrayValorDefecto[0] = altaClienteActionForm.getArrayCalificacion()[j];
							altaClienteActionForm.setCodCalificacion(arrayValorDefecto[0].getCodClasificacion());break;
						}
					}
					logger.debug("CALIFICACION clasificacion.getIndActivo(): "+ clasificacion.getIndActivo());
					if(clasificacion.getIndActivo()==0)	altaClienteActionForm.setArrayCalificacion(arrayValorDefecto);
					logger.debug("FIN CALIFICACION");
				}//fin calificacion
				
			}//fin for
		}//fin if arrayClasificacion
		
		//P-CSR-11002 JLGN 05-06-2011
		request.getSession().setAttribute("flagPass", "false");
		//P-CSR-11002 JLGN 04-08-2011
		request.getSession().setAttribute("mensajeErrorBuro", " ");
		//P-CSR-11002 JLGN 25-08-2011
		request.getSession().removeAttribute("mensajeError");
		//P-CSR-11002 JLGN 06-06-2011
		altaClienteActionForm.setMensajesPromocionales("A");
		//P-CSR-11002 JLGN 08-06-2011
		DatosClienteBuroDTO buroDTO = null;
		//Inicio P-CSR-11002 JLGN 14-11-2011		
		DatosClienteBuroDTO buroDTO3 = new DatosClienteBuroDTO();
		buroDTO3.setLimiteDeCredito("0");
		buroDTO3.setLimiteDeCreditoConCargo("0");
		buroDTO3.setResulCalificacion(" ");
		//Inicio Inc. 179734 JLGN 01-01-2012
		buroDTO3.setFlagDDA("false");
		//Fin Inc. 179734 JLGN 01-01-2012
		request.getSession().setAttribute("datosClienteBuro3", buroDTO3);
		//Fin P-CSR-11002 JLGN 14-11-2011
		request.getSession().setAttribute("datosClienteBuro", buroDTO);
		//Inicio Inc.179734 09-01-2012 JLGN
		request.getSession().setAttribute("datosClienteBuroDDA", buroDTO3);		
		//Fin Inc.179734 09-01-2012 JLGN
		
		//Inicio P-CSR-11002 JLGN  15-06-2011
		//Se obtiene ciclo de facturacion por defecto para empresa de la ged_parametros
		DatosGeneralesDTO entrada = new DatosGeneralesDTO();			
		entrada.setCodigoModulo(global.getValor("codigo.modulo.GA"));
		entrada.setCodigoProducto(global.getValor("codigo.producto"));
		entrada.setCodigoParametro(global.getValor("ciclo.facturacion.empresa"));			
		entrada = delegate.getValorParametro(entrada);	
		String cicloEmpresa = entrada.getValorParametro();
		logger.debug("cicloFacturEmpre: "+cicloEmpresa);
		request.getSession().setAttribute("cicloFacturEmpre", cicloEmpresa);
		logger.debug("cicloFacturEmpre: "+cicloEmpresa);
		
		//Se obtiene ciclo de facturacion por defecto para empresa de la ged_parametros
		entrada.setCodigoModulo(global.getValor("codigo.modulo.GA"));
		entrada.setCodigoProducto(global.getValor("codigo.producto"));
		entrada.setCodigoParametro(global.getValor("ciclo.facturacion.particular"));			
		entrada = delegate.getValorParametro(entrada);
		String cicloParticular = entrada.getValorParametro();
		logger.debug("cicloFacturParti: "+cicloParticular);
		request.getSession().setAttribute("cicloFacturParti", cicloParticular);
		logger.debug("cicloFacturParti: "+cicloParticular);
		//Fin P-CSR-11002 JLGN  15-06-2011
		
		logger.info("AltaClienteInicio,fin");
		return mapping.findForward("inicio");
	}
	
	public ActionForward recargar(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.info("AltaClienteInicio,recargar");
		//P-CSR-11002 JLGN 27-10-2011
		request.getSession().removeAttribute("mensajeError");
		return mapping.findForward("inicio");
	}
		
	public ActionForward ingresarDatosParticular(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.info("AltaClienteInicio,ingresarDatosParticular");		
		//Inicio P-CSR-11002 JLGN 10-05-2011
		HttpSession sesion = request.getSession(false);		
		String flagDataBuro = (String)sesion.getAttribute("flagDataBuro");
		
		if(flagDataBuro.equals("true")){		
			DatosClienteBuroDTO buroDTO = ((DatosClienteBuroDTO)sesion.getAttribute("datosClienteBuro"));
			AltaClienteInicioForm altaClienteActionForm = (AltaClienteInicioForm) form;
			logger.debug("FlagTipoCliente: "+ altaClienteActionForm.getFlagTipCliente());
			buroDTO.setFlagTipCliente(altaClienteActionForm.getFlagTipCliente());
			sesion.removeAttribute("datosClienteBuro");
			request.getSession().setAttribute("datosClienteBuro", buroDTO);
		}
		//Fin P-CSR-11002 JLGN 10-05-2011
		//P-CSR-11002 JLGN 27-10-2011
		request.getSession().removeAttribute("mensajeError");
		return mapping.findForward("ingresarDatosParticular");
	}
	
	public ActionForward aceptarDatosParticular(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.info("aceptarDatosParticular,inicio");
		AltaClienteInicioForm altaClienteActionForm = (AltaClienteInicioForm) form;
		altaClienteActionForm.setFlagDatosParticular("1");
		
		logger.info("aceptarDatosParticular,fin");	
		//P-CSR-11002 JLGN 27-10-2011
		request.getSession().removeAttribute("mensajeError");
		return mapping.findForward("inicio");
	}
	
	public ActionForward ingresarDatosEmpresa(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
	
		logger.info("AltaClienteInicio,ingresarDatosEmpresa");
		//Inicio P-CSR-11002 JLGN 10-05-2011
		HttpSession sesion = request.getSession(false);		
		String flagDataBuro = (String)sesion.getAttribute("flagDataBuro");
		if(flagDataBuro.equals("true")){
			DatosClienteBuroDTO buroDTO = ((DatosClienteBuroDTO)sesion.getAttribute("datosClienteBuro"));
			AltaClienteInicioForm altaClienteActionForm = (AltaClienteInicioForm) form;
			logger.debug("FlagTipoCliente: "+ altaClienteActionForm.getFlagTipCliente());
			buroDTO.setFlagTipCliente(altaClienteActionForm.getFlagTipCliente());
			sesion.removeAttribute("datosClienteBuro");
			request.getSession().setAttribute("datosClienteBuro", buroDTO);	
		}
		//Fin P-CSR-11002 JLGN 10-05-2011	
		//P-CSR-11002 JLGN 27-10-2011
		request.getSession().removeAttribute("mensajeError");
		return mapping.findForward("ingresarDatosEmpresa");
	}
	
	public ActionForward aceptarDatosEmpresa(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.info("aceptarDatosEmpresa,inicio");
		AltaClienteInicioForm altaClienteActionForm = (AltaClienteInicioForm) form;
		altaClienteActionForm.setFlagDatosEmpresa("1");
		logger.info("aceptarDatosEmpresa,fin");	
		//P-CSR-11002 JLGN 27-10-2011
		request.getSession().removeAttribute("mensajeError");
		return mapping.findForward("inicio");
	}

	public ActionForward ingresarReferencias(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.info("ingresarReferencias, inicio");
		logger.info("ingresarReferencias, fin");
		return mapping.findForward("ingresarReferencias");
	}
	
	public ActionForward cancelarAltaCliente(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.info("cancelarAltaCliente, inicio");
		logger.info("cancelarAltaCliente, fin");
		//P-CSR-11002 JLGN 27-10-2011
		request.getSession().removeAttribute("mensajeError");
		return mapping.findForward("cancelarAltaCliente");
	}
	
	
	public ActionForward ingresarDatosTributarios(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.info("ingresarDatosTributarios,inicio");
		
		AltaClienteInicioForm altaClienteActionForm = (AltaClienteInicioForm) form;
		
		logger.debug("Ingreso Envio Factura Fisica: "+ altaClienteActionForm.getEnvioFacturaFisica());
		logger.debug("Ingreso Registro Facturacion: "+altaClienteActionForm.getRegistroFacturacion());
		logger.debug("Ingreso cuenta Facebook: "+ altaClienteActionForm.getCuentaFacebook());
		logger.debug("Ingreso cuenta Twitter: "+ altaClienteActionForm.getCuentaTwitter());
		
		//control de visualizacion de clasificaciones
		//seteo de valores por defecto si es que los controles de no estan visibles
		ClasificacionDTO[] arrayClasificacion = altaClienteActionForm.getArrayClasificacion();
		if (arrayClasificacion!=null){
			for (int i=0;i<arrayClasificacion.length;i++){
				ClasificacionDTO clasificacion= (ClasificacionDTO)arrayClasificacion[i];
				if (clasificacion.getIndVisible()==0){
					if (clasificacion.getCodElemento().equalsIgnoreCase(global.getValor("codigo.clasificacion.color"))){
						for(int j=0; j<altaClienteActionForm.getArrayColor().length;j++)
							if (altaClienteActionForm.getArrayColor()[j].getIndDefecto()==1){
								altaClienteActionForm.setCodColor(altaClienteActionForm.getArrayColor()[j].getCodClasificacion());break;							
							}
					}//fin color
					else if (clasificacion.getCodElemento().equalsIgnoreCase(global.getValor("codigo.clasificacion.crediticia"))){
						if (altaClienteActionForm.getTipoCliente().equals(global.getValor("tipo.cliente.prepago"))){
							altaClienteActionForm.setCodCrediticia(global.getValor("clasif.crediticia.excepcionado"));
						}
						else{
							for(int j=0; j<altaClienteActionForm.getArrayCrediticia().length;j++)
								if (altaClienteActionForm.getArrayCrediticia()[j].getIndDefecto()==1){
									altaClienteActionForm.setCodCrediticia(altaClienteActionForm.getArrayCrediticia()[j].getCodClasificacion());break;
								}
						}
					}//fin crediticia
					else if (clasificacion.getCodElemento().equalsIgnoreCase(global.getValor("codigo.clasificacion.segmento"))){
						ValorClasificacionDTO[] listaSegmentos = null;
						listaSegmentos = delegate.getSegmentos(altaClienteActionForm.getTipoCliente());							
						for(int j=0; j<listaSegmentos.length;j++)
							if (listaSegmentos[j].getIndDefecto()==1){
								altaClienteActionForm.setCodSegmento(listaSegmentos[j].getCodClasificacion());break;
							}
					}//fin segmento
					else if (clasificacion.getCodElemento().equalsIgnoreCase(global.getValor("codigo.clasificacion.categoria"))){
						for(int j=0; j<altaClienteActionForm.getArrayCategoriaCliente().length;j++)
							if (altaClienteActionForm.getArrayCategoriaCliente()[j].getIndDefecto()==1){
								altaClienteActionForm.setCategoriaCliente(altaClienteActionForm.getArrayCategoriaCliente()[j].getCodClasificacion());break;
							}
					}//fin categoria
					else if (clasificacion.getCodElemento().equalsIgnoreCase(global.getValor("codigo.clasificacion.calificacion"))){
						logger.debug("ArrayCalificacion: "+altaClienteActionForm.getArrayCalificacion().length);
						logger.debug("ArrayCalificacion[0]: "+ altaClienteActionForm.getArrayCalificacion()[0].getIndDefecto());
						for(int j=0; j<altaClienteActionForm.getArrayCalificacion().length;j++)
							if (altaClienteActionForm.getArrayCalificacion()[j].getIndDefecto()==1){
								altaClienteActionForm.setCodCalificacion(altaClienteActionForm.getArrayCalificacion()[j].getCodClasificacion());break;
							}
					}//fin calificacion
				}//fin if (clasificacion.getIndVisible()==0)
			}//fin for
		}
		
		//Inicio P-CSR-11002 JLGN 28/04/2011
		//Si cliente es prepago Recupera direccion por defecto de la ged_parametros y lo guarda en sesion
		logger.debug("Valida si tipo de cliente es Prepago");
		if (altaClienteActionForm.getTipoCliente().equals(global.getValor("tipo.cliente.prepago"))){
			logger.debug("Cliente es Prepago");
			DatosGeneralesDTO entrada = new DatosGeneralesDTO();			
			entrada.setCodigoModulo(global.getValor("codigo.modulo.GE"));
			entrada.setCodigoProducto(global.getValor("codigo.producto"));
			entrada.setCodigoParametro(global.getValor("parametro.direccion.prepago"));			
			logger.debug("Obtiene Direccion por Default");
			entrada = delegate.getValorParametro(entrada);	
			logger.debug("Valor de Direccion: "+entrada.getValorParametro());
			request.getSession().setAttribute("direccionPrepago", entrada.getValorParametro());
		}else{
			//Se obtiene direccion por defecto para cliente pospago y ser utilizada en caso de que no se obtenga la direccion desde el xml
			logger.debug("Cliente es Pospago o Hibrido");
			DatosGeneralesDTO entrada = new DatosGeneralesDTO();			
			entrada.setCodigoModulo(global.getValor("codigo.modulo.GE"));
			entrada.setCodigoProducto(global.getValor("codigo.producto"));
			entrada.setCodigoParametro(global.getValor("parametro.direccion.pospago"));			
			logger.debug("Obtiene Direccion por Default");
			entrada = delegate.getValorParametro(entrada);	
			logger.debug("Valor de Direccion: "+entrada.getValorParametro());
			request.getSession().setAttribute("direccionPospago", entrada.getValorParametro());
		}
		//Fin P-CSR-11002 JLGN 28/04/2011
		//P-CSR-11002 JLGN 27-10-2011
		request.getSession().removeAttribute("mensajeError");
		logger.info("ingresarDatosTributarios,fin");
		return mapping.findForward("ingresarDatosTributarios");
	}	
	
	private void limpiarSesion(HttpServletRequest request,AltaClienteInicioForm form){
		HttpSession sesion = request.getSession(false);
		sesion.removeAttribute("DatosParticularForm");
		sesion.removeAttribute("DatosEmpresaForm");
		sesion.removeAttribute("ReferenciasClienteForm");		
		sesion.removeAttribute("DatosTributariosForm");
		sesion.removeAttribute("DireccionForm");
		sesion.removeAttribute("ClienteFacturaForm");
		sesion.removeAttribute("AltaClienteFinalForm");
		sesion.removeAttribute("retornoAltaDTO");
		sesion.removeAttribute("clienteAlta");
		
		form.setTipoCliente(null);
		form.setArrayTipoCliente(null);
		form.setCodColor(null);
		form.setArrayColor(null);
		form.setCodSegmento(null);
		form.setCodSegmentoSeleccionado(null);

		form.setCodCrediticia(null);
		form.setArrayCrediticia(null);
		form.setCategoriaCliente(null);
		form.setArrayCategoriaCliente(null);
		form.setCodCalificacion(null);
		form.setArrayCalificacion(null);
		
		//datos generales
		form.setTipoIdentificacion1(null);
		form.setArrayIdentificador1(null);
		form.setNumeroIdentificacion1(null);
		form.setTipoIdentificacion2(null);
		form.setArrayIdentificador2(null);
		form.setNumeroIdentificacion2(null);
		form.setCicloFact(null);
		form.setCodCicloSeleccionado(null);

		form.setRegistroFacturacion(null);
		form.setArrayRegFact(null);
		form.setCorreo(null);
		form.setMensajesPromocionales(null);
		form.setOperadoraAnterior(null);
		form.setArrayOperadora(null);
		form.setTelefono(null);
		
		//referencia del cliente
		form.setArrayRefClienteAlta(null);
		
		//usuario legal
		form.setTipoIdentificacionUsuarioLegal(null);
		form.setArrayIdentificadorCliente(null);
		form.setNumeroIdentificacionUsuarioLegal(null);
		form.setNombresUsuarioLegal(null);
		form.setApellido1UsuarioLegal(null);
		form.setApellido2UsuarioLegal(null);
		
		//usuario autorizado
		form.setTipoIdentificacionUsuarioAut(null);
		form.setNumeroIdentificacionUsuarioAut(null);
		form.setNombresUsuarioAut(null);
		form.setApellido1UsuarioAut(null);
		form.setApellido2UsuarioAut(null);
		
		//P-CSR-11002 JLGN 06-06-2011
		form.setCuentaFacebook(null);
		form.setCuentaTwitter(null);
	}
	
	//Inicio P-CSR-11002 JLGN 29-04-2011
	public ActionForward consultaBuro(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.info("consultaBuro,inicio");		
		AltaClienteInicioForm altaClienteActionForm = (AltaClienteInicioForm) form;
		DatosClienteBuroDTO buroDTO = null;
		try{			
			//Inicio 23-09-2011 JLGN
			request.getSession().setAttribute("flagLimCred", "false");
			request.getSession().removeAttribute("mensajeError");
			//request.setAttribute("mensajeError", men3);
			//Fin 23-09-2011 JLGN
			
			String tipCliente = altaClienteActionForm.getTipoCliente();
			logger.debug("Tipo de cliente: "+tipCliente);
			String numIdent = altaClienteActionForm.getNumeroIdentificacion1();
			String tipoIdent = altaClienteActionForm.getTipoIdentificacion1();
			String tipoEstudio = "DGG";
			String tipIdent = "";
			
			//Se limpian los datos
			logger.debug("Se limpian los datos");
			
			altaClienteActionForm.setApellido1UsuarioAut("");
			altaClienteActionForm.setApellido1UsuarioLegal("");
			altaClienteActionForm.setApellido2UsuarioAut("");
			altaClienteActionForm.setApellido2UsuarioLegal("");
			altaClienteActionForm.setNombresUsuarioAut("");
			altaClienteActionForm.setNombresUsuarioLegal("");
			altaClienteActionForm.setNumeroIdentificacion1("");
			altaClienteActionForm.setNumeroIdentificacionUsuarioAut("");
			altaClienteActionForm.setNumeroIdentificacionUsuarioLegal("");
			altaClienteActionForm.setTelefono("");
			altaClienteActionForm.setTipoIdentificacion1("");
			altaClienteActionForm.setTipoIdentificacionUsuarioAut("");
			altaClienteActionForm.setTipoIdentificacionUsuarioLegal("");
			altaClienteActionForm.setFlagTipCliente("");
			
			logger.debug("Tipo de Identificacion: "+tipoIdent);
			
			//Valida el tipo de identificacion que se le deba pasar a la URL
			if (tipoIdent.equals("01")){
				tipIdent = "CED";
			}else if (tipoIdent.equals("02")){
				tipIdent = "JUR";
			}else if (tipoIdent.equals("03")){
				tipIdent = "RES";
			}else if (tipoIdent.equals("04")){
				tipIdent = "PAS";
			}	
			//MA-184592 JLGN 15-05-2012
			String usuario = (String)request.getSession().getAttribute("nombreUsuarioSCL");
			
			buroDTO = delegate.consultaBuro(numIdent, tipIdent, tipoEstudio, usuario);	
			
			//Inicio P-CSR-11002 JLGN 14-11-2011			
			long limConCliScl = 0;
			long auxLimCon = 0;
			DatosClienteBuroDTO buroDTO3 = new DatosClienteBuroDTO();
			buroDTO3.setLimiteDeCredito(buroDTO.getLimiteDeCredito());
			buroDTO3.setResulCalificacion(buroDTO.getResulCalificacion());
			
			limConCliScl = delegate.obtineLimConsuCliente(numIdent, tipoIdent);
			logger.debug("buroDTO.getLimiteDeCredito(): "+ buroDTO3.getLimiteDeCredito());
			logger.debug("limConCliScl: "+ limConCliScl);
			auxLimCon = (Long.parseLong(buroDTO3.getLimiteDeCredito()) - limConCliScl);
			logger.debug("auxLimCon: "+ auxLimCon);
			buroDTO3.setLimiteDeCreditoConCargo(String.valueOf(auxLimCon));
			request.getSession().setAttribute("datosClienteBuro3", buroDTO3);
			//Fin P-CSR-11002 JLGN 14-11-2011
			
			if(tipIdent == "JUR"){
				logger.debug("Tipo de cliente es Empresa");
				altaClienteActionForm.setFlagDatosEmpresa("1");				
			}else{
				logger.debug("Tipo de cliente es Particular");
				altaClienteActionForm.setFlagDatosParticular("1");
			}
			
			altaClienteActionForm.setApellido1UsuarioAut(buroDTO.getApellido1());
			altaClienteActionForm.setApellido1UsuarioLegal(buroDTO.getApellido1());
			altaClienteActionForm.setApellido2UsuarioAut(buroDTO.getApellido2());
			altaClienteActionForm.setApellido2UsuarioLegal(buroDTO.getApellido2());
			altaClienteActionForm.setNombresUsuarioAut(buroDTO.getNombre());
			altaClienteActionForm.setNombresUsuarioLegal(buroDTO.getNombre());
			altaClienteActionForm.setNumeroIdentificacion1(buroDTO.getNumeroCedula());
			altaClienteActionForm.setNumeroIdentificacionUsuarioAut(buroDTO.getNumeroCedula());
			altaClienteActionForm.setNumeroIdentificacionUsuarioLegal(buroDTO.getNumeroCedula());
			altaClienteActionForm.setTelefono(buroDTO.getTelefono());
			altaClienteActionForm.setTipoIdentificacion1(tipoIdent);
			altaClienteActionForm.setTipoIdentificacionUsuarioAut(tipoIdent);
			altaClienteActionForm.setTipoIdentificacionUsuarioLegal(tipoIdent);
			altaClienteActionForm.setFlagTipCliente(buroDTO.getFlagTipCliente());
			
			//Inicio P-CSR-11002 JLGN 28-07-2011
			//Inicio Inc.179734 JLGN 17-01-2012
			if(buroDTO.getFlagDDA().equals("true")){
				request.getSession().setAttribute("flagLimCred", "false");
				request.getSession().setAttribute("flagOKBuro", "false");
				request.getSession().setAttribute("mensajeError","Cliente se encuentra con restricción del Buró, solo puede optar a realizar pago con Débito Automático. " + buroDTO.getMensError());				
			//Fin Inc.179734 JLGN 17-01-2012
			}else{
				if ((Long.parseLong(buroDTO.getLimiteDeCredito().trim())) == 0){
					request.getSession().setAttribute("flagLimCred", "true");
					request.getSession().setAttribute("flagOKBuro", "false");
				}else{
					request.getSession().setAttribute("flagLimCred", "false");
					request.getSession().setAttribute("flagOKBuro", "true");
				}
			}	
			//Fin P-CSR-11002 JLGN 28-07-2011
			
			//Inicio P-CSR-11002 09-05-2011 JLGN
			request.getSession().setAttribute("flagDataBuro", "true");
			request.getSession().setAttribute("datosClienteBuro", buroDTO);
			//request.getSession().setAttribute("flagOKBuro", "true");
			request.getSession().setAttribute("botonPass", "false");
			request.getSession().setAttribute("flagPass", "true");
			request.getSession().setAttribute("mensajeErrorBuro", " ");
			//Inicio Inc.179734 03-01-2012 JLGN
			request.getSession().setAttribute("datosClienteBuroDDA", buroDTO);
			//Fin Inc.179734 03-01-2012 JLGN
			//Fin P-CSR-11002 09-05-2011 JLGN
			
			logger.info("consultaBuro,fin");
		}catch(AltaClienteException e){
			String men3 = e.getDescripcionEvento();
			String codError = e.getCodigo();
			
			altaClienteActionForm.setApellido1UsuarioAut("");
			altaClienteActionForm.setApellido1UsuarioLegal("");
			altaClienteActionForm.setApellido2UsuarioAut("");
			altaClienteActionForm.setApellido2UsuarioLegal("");
			altaClienteActionForm.setNombresUsuarioAut("");
			altaClienteActionForm.setNombresUsuarioLegal("");
			altaClienteActionForm.setNumeroIdentificacion1("");
			altaClienteActionForm.setNumeroIdentificacionUsuarioAut("");
			altaClienteActionForm.setNumeroIdentificacionUsuarioLegal("");
			altaClienteActionForm.setTelefono("");
			altaClienteActionForm.setTipoIdentificacion1("");
			altaClienteActionForm.setTipoIdentificacionUsuarioAut("");
			altaClienteActionForm.setTipoIdentificacionUsuarioLegal("");
			altaClienteActionForm.setFlagTipCliente("");
			//Inicio P-CSR-11002 JLGN 14-11-2011
			DatosClienteBuroDTO buroDTO3 = new DatosClienteBuroDTO();
			buroDTO3.setLimiteDeCreditoConCargo("0");
			buroDTO3.setLimiteDeCredito("0");
			buroDTO3.setResulCalificacion(" ");
			request.getSession().setAttribute("datosClienteBuro3", buroDTO3);
			//Fin P-CSR-11002 JLGN 14-11-2011
			request.getSession().setAttribute("datosClienteBuro", buroDTO);
			//Inicio Inc.179734 03-01-2012 JLGN
			request.getSession().setAttribute("datosClienteBuroDDA", buroDTO);
			//Fin Inc.179734 03-01-2012 JLGN
			request.getSession().setAttribute("mensajeErrorBuro", " ");
			
			if(codError.equals("1001")){
				//Cliente Bloqueado o No existe en Buro se puede continuar con el alta
				request.getSession().setAttribute("mensajeError", men3+", el Alta de Cliente tendrá que realizar excepción o se debera cambiar a Prepago");
				request.getSession().setAttribute("flagDataBuro", "false");
				request.getSession().setAttribute("flagOKBuro", "false");
				//P-CSR-11002 JLGN 06-06-2011
				//Si el Cliente No Existe o esta Bloqueado se activa el ingreso de Password del Vendedor Para poder Continuar con el Alta
				request.getSession().setAttribute("botonPass", "true");
				//Inicio Inc.179734 16-01-2012 JLGN
				buroDTO = new DatosClienteBuroDTO();
				buroDTO.setFlagDDA("false");
				request.getSession().setAttribute("datosClienteBuroDDA", buroDTO);
				//Fin Inc.179734 16-01-2012 JLGN
	        	logger.debug(men3);
	            return mapping.findForward("consultaBuro");	
			}else if(codError.equals("1004")){//Inicio Inc.179734 03-01-2012 JLGN
				//Cliente Bloqueado o No existe en Buro se puede continuar con el alta
				request.getSession().setAttribute("mensajeError", men3);
				request.getSession().setAttribute("flagDataBuro", "false");
				request.getSession().setAttribute("flagOKBuro", "false");
				request.getSession().setAttribute("botonPass", "false"); 
				request.getSession().setAttribute("flagPass", "true");
				//Inicio Inc.179734 03-01-2012 JLGN
				buroDTO = new DatosClienteBuroDTO();
				buroDTO.setFlagDDA("true");
				request.getSession().setAttribute("datosClienteBuroDDA", buroDTO);
				//Fin Inc.179734 03-01-2012 JLGN
	        	logger.debug(men3);
	            return mapping.findForward("consultaBuro");
				//Fin Inc.179734 03-01-2012 JLGN
			}else if(codError.equals("1002")){
				//No existe Conexion con Buro
				//request.setAttribute("mensajeError", "Ocurrio un error al Consultar Cliente en Buro, "+men3+", el Alta de Cliente tendrá que posponerse o se debera cambiar a Prepago");
				request.setAttribute("mensajeError", men3+", el Alta de Cliente tendrá que posponerse o se debera cambiar a Prepago");
				request.getSession().setAttribute("flagDataBuro", "false");
				request.getSession().setAttribute("flagOKBuro", "false");
				request.getSession().setAttribute("botonPass", "false");
				//Inicio Inc.179734 26-01-2012 JLGN
				buroDTO = new DatosClienteBuroDTO();
				buroDTO.setFlagDDA("true");
				request.getSession().setAttribute("datosClienteBuroDDA", buroDTO);
				//Fin Inc.179734 26-01-2012 JLGN
	        	logger.debug(men3+", el Alta de Cliente tendrá que posponerse o se debera cambiar a Prepago");
	            return mapping.findForward("consultaBuro");				
			}else if(codError.equals("1003")){
				//Inicio P-CSR-11002 JLGN 04-08-2011
				//Inicio Inc.179734 16-01-2012
				buroDTO = new DatosClienteBuroDTO();
				buroDTO.setFlagDDA("false");
				request.getSession().setAttribute("datosClienteBuroDDA", buroDTO);
				//Fin Inc.179734 16-01-2012
				request.getSession().setAttribute("mensajeErrorBuro", men3);
				request.getSession().setAttribute("flagLimCred", "true");
				request.getSession().setAttribute("flagDataBuro", "false");
				request.getSession().setAttribute("flagOKBuro", "false");
				request.getSession().setAttribute("botonPass", "false");
				request.getSession().setAttribute("flagPass", "false");
	        	logger.debug(men3);
	            return mapping.findForward("consultaBuro");
			}else{
				//Cliente Fallecido no se Continua con el Alta	
	        	//request.setAttribute("mensajeError", "Ocurrio un error al Consultar Cliente en Buro, "+men3);
	        	request.setAttribute("mensajeError", men3);
				//Inicio Inc.179734 26-01-2012 JLGN
				buroDTO = new DatosClienteBuroDTO();
				buroDTO.setFlagDDA("false");
				request.getSession().setAttribute("datosClienteBuroDDA", buroDTO);
				//Fin Inc.179734 26-01-2012 JLGN
				request.getSession().setAttribute("flagDataBuro", "false");
				request.getSession().setAttribute("flagLimCred", "false");
				request.getSession().setAttribute("flagOKBuro", "false");
				request.getSession().setAttribute("botonPass", "false");
				request.getSession().setAttribute("flagPass", "false");
	        	logger.debug(men3);
	            return mapping.findForward("consultaBuro");
			}    
		}catch(Exception e){
			altaClienteActionForm.setApellido1UsuarioAut("");
			altaClienteActionForm.setApellido1UsuarioLegal("");
			altaClienteActionForm.setApellido2UsuarioAut("");
			altaClienteActionForm.setApellido2UsuarioLegal("");
			altaClienteActionForm.setNombresUsuarioAut("");
			altaClienteActionForm.setNombresUsuarioLegal("");
			altaClienteActionForm.setNumeroIdentificacion1("");
			altaClienteActionForm.setNumeroIdentificacionUsuarioAut("");
			altaClienteActionForm.setNumeroIdentificacionUsuarioLegal("");
			altaClienteActionForm.setTelefono("");
			altaClienteActionForm.setTipoIdentificacion1("");
			altaClienteActionForm.setTipoIdentificacionUsuarioAut("");
			altaClienteActionForm.setTipoIdentificacionUsuarioLegal("");
			altaClienteActionForm.setFlagTipCliente("");
			//Inicio P-CSR-11002 JLGN 14-11-2011 
			DatosClienteBuroDTO buroDTO3 = new DatosClienteBuroDTO();
			buroDTO3.setLimiteDeCreditoConCargo("0");
			buroDTO3.setLimiteDeCredito("0");
			buroDTO3.setResulCalificacion(" ");
			request.getSession().setAttribute("datosClienteBuro3", buroDTO3);
			//Fin P-CSR-11002 JLGN 14-11-2011
			request.getSession().setAttribute("datosClienteBuro", buroDTO);
			
        	request.setAttribute("mensajeError", "Ocurrio un error al Consultar Cliente en Buro, Favor avisar al Administrador");
			request.getSession().setAttribute("flagDataBuro", "false");
			request.getSession().setAttribute("flagOKBuro", "false");
			request.getSession().setAttribute("botonPass", "false");
			request.getSession().setAttribute("mensajeErrorBuro", " ");
        	logger.debug("Ocurrio un error al Consultar Cliente en Buro, Favor avisar al Administrador");
            return mapping.findForward("consultaBuro");        	
        }
		return mapping.findForward("consultaBuro");
	}	
	//Fin P-CSR-11002 JLGN 29-04-2011
	
	//Inicio P-CSR-11002 JLGN 05-06-2011
	public ActionForward validarPass(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		logger.info("validarPass, inicio");		
		AltaClienteInicioForm altaClienteInicioForm = (AltaClienteInicioForm)form;
		
		String passValidacion = altaClienteInicioForm.getPassValidacion();
		logger.debug("passValidacion: "+ passValidacion);
		if (delegate.validaPassClasificacion(passValidacion)){	
			request.getSession().removeAttribute("mensajeError");
			request.getSession().setAttribute("flagPass", "true");
		}else{
			request.setAttribute("mensajeError", "Password Ingresada Incorrecta");
			request.getSession().setAttribute("flagPass", "false");
		}
		logger.info("validarPass, fin");	
		//P-CSR-11002 JLGN 27-10-2011
		request.getSession().removeAttribute("mensajeError");
		return mapping.findForward("inicio");
	}
	
	//Fin P-CSR-11002 JLGN 16-05-2011
	
}
