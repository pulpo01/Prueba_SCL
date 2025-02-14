package com.tmmas.cl.scl.altacliente.presentacion.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.tmmas.cl.scl.altacliente.presentacion.delegate.AltaClienteDelegate;
import com.tmmas.cl.scl.altacliente.presentacion.form.AltaClienteInicioForm;
import com.tmmas.cl.scl.altacliente.presentacion.form.DatosTributariosForm;
import com.tmmas.cl.scl.altacliente.presentacion.helper.Global;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ClienteComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.DatosClienteBuroDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.DatosGeneralesComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.IdentificadorCivilComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.OficinaComDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.FormularioDireccionDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.CategoriaCambioDTO;

public class DatosTributariosAction extends DispatchAction {
	private final Logger logger = Logger.getLogger(DatosTributariosAction.class);
	private Global global = Global.getInstance();
	
	AltaClienteDelegate delegate = AltaClienteDelegate.getInstance();
	
	public ActionForward inicio(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.info("DatosTributariosAction, inicio");
		DatosTributariosForm datosTributariosForm = (DatosTributariosForm)form;
		datosTributariosForm.setRestriccionIdentTrib(false);
		
		//P-CSR-11002 JLGN 10-05-2011
		HttpSession sesion = request.getSession(false);
		
		//(+)-- Carga de listas --
		//Oficina
		if (datosTributariosForm.getArrayOficina()==null){
			String codigoOficina = ""; //Este dato puede venir como parametro de entrada????
			OficinaComDTO oficina = new OficinaComDTO();
		    oficina.setCodigoOficina(codigoOficina);
		    //P-CSR-11002 JLGN 10-10-2011
		    String usuario = (String)sesion.getAttribute("nombreUsuarioSCL");
		    logger.debug("Nombre de Usuario SCL: "+usuario);
		    oficina.setNombreUsuario(usuario);
		    OficinaComDTO[] arrayOficinas = delegate.getOficinas(oficina);
		    datosTributariosForm.setArrayOficina(arrayOficinas);
		}
		//arrayIdentificadorCliente
		if (datosTributariosForm.getArrayIdentificadorCliente()==null){
			IdentificadorCivilComDTO[] arrayIdentificadores = delegate.getTipoIdentificadoresCiviles();
			datosTributariosForm.setArrayIdentificadorCliente(arrayIdentificadores);
		}
		
		//arrayCategImpos
		if (datosTributariosForm.getArrayCategImpos()==null){
			ClienteComDTO[] arrayCategImpos =  delegate.getCategoriasImpositivas();
			datosTributariosForm.setArrayCategImpos(arrayCategImpos);
			logger.debug("primer dato de categoria impositiva: "+arrayCategImpos[0].getCodigoCategImpos());
			datosTributariosForm.setCategoriaImpositiva(arrayCategImpos[0].getCodigoCategImpos());
		}
		
		//Subcategoria -- Se carga en DWR
		
		//arrayCategTrib
		if (datosTributariosForm.getArrayCategTrib()==null){
			DatosGeneralesComDTO[] arrayCategTrib = delegate.getCategoriasTributarias();
			datosTributariosForm.setArrayCategTrib(arrayCategTrib);
		}
		
		//ArrayCategoriaCambio
		if (datosTributariosForm.getArrayCategoriaCambio()==null){
			CategoriaCambioDTO[] arrayCategoriaCambio = delegate.getCategoriasCambio();
			datosTributariosForm.setArrayCategoriaCambio(arrayCategoriaCambio);
		}
		
		if (datosTributariosForm.getDireccionPersonalForm()!=null){
			datosTributariosForm.setDirecionPersonal(obtenerDireccionAMostrar(datosTributariosForm.getDireccionPersonalForm()));
		}
		
		if (datosTributariosForm.getDireccionFacturacionForm()!=null){
			datosTributariosForm.setDireccionFacturacion(obtenerDireccionAMostrar(datosTributariosForm.getDireccionFacturacionForm()));			
		}

		if (datosTributariosForm.getDireccionCorrespondenciaForm()!=null){
			datosTributariosForm.setDireccionCorrespondencia(obtenerDireccionAMostrar(datosTributariosForm.getDireccionCorrespondenciaForm()));						
		}

		if (datosTributariosForm.getNumeroIdentificacionTrib()==null){
			//HttpSession sesion = request.getSession(false);
			AltaClienteInicioForm altaClienteInicioForm = (AltaClienteInicioForm)sesion.getAttribute("AltaClienteInicioForm");
			if (altaClienteInicioForm!=null){
				datosTributariosForm.setTipoIdentificacionTrib(altaClienteInicioForm.getTipoIdentificacion1());
				datosTributariosForm.setNumeroIdentificacionTrib(altaClienteInicioForm.getNumeroIdentificacion1());
			}
		}
		
		AltaClienteInicioForm altaClienteInicioForm = (AltaClienteInicioForm)request.getSession(false).getAttribute("AltaClienteInicioForm");
		if (altaClienteInicioForm!=null) {
			logger.debug("DatosTributarios Envio Factura Fisica: "+altaClienteInicioForm.getEnvioFacturaFisica());
			logger.debug("DatosTributarios Cuenta Facebook: "+altaClienteInicioForm.getCuentaFacebook());
			logger.debug("DatosTributarios Cuenta Twitter: "+altaClienteInicioForm.getCuentaTwitter());
			String tipoClientePrepago  = global.getValor("tipo.cliente.prepago");
			String tipoClienteSeleccionado = altaClienteInicioForm.getTipoCliente();
			datosTributariosForm.setFlagClientePrepago(tipoClientePrepago.equals(tipoClienteSeleccionado)?"1":"0");
		}
		
		aplicarFacturaTercero(datosTributariosForm);
		aplicarCategoriaCambio(datosTributariosForm);
		
		//P-CSR-11002 10-05-2011
		//Inicio P-CSR-11002 JLGN 09-05-2011
		logger.debug("Obtengo datos Buro de Sesion");
		DatosClienteBuroDTO buroDTO = (DatosClienteBuroDTO)sesion.getAttribute("datosClienteBuro");
		//Inicio Inc.179734 01-01-2012 JLGN
		DatosClienteBuroDTO buroDAA = (DatosClienteBuroDTO)sesion.getAttribute("datosClienteBuroDDA");
		logger.debug("Se valida flag de DAA");
		
		if(buroDAA.getFlagDDA().equals("true")){
			logger.debug("Alta de cliente es con DAA");
			logger.debug("Mensaje de error Se debe Actualizar Dirección");
			request.setAttribute("mensajeError", "Se debe Actualizar Dirección");
			
			FormularioDireccionDTO direccionAux =  new FormularioDireccionDTO();				
			if (sesion.getAttribute("direccionPospago") != null){
				String codDireccion = (String)sesion.getAttribute("direccionPospago");			
				direccionAux = delegate.getDireccionPrepago(codDireccion);	
				//P-CSR-11002 JLGN 08-06-2011
				//direccionAux.setDES_DIREC1(buroDTO.getDesDireccion());
				logger.debug("obtuvo direccion OK");				
				datosTributariosForm.setDireccionFacturacion(obtenerDireccionAMostrar(direccionAux));
				datosTributariosForm.setDireccionPersonalForm(direccionAux);
				datosTributariosForm.setDireccionFacturacionForm(direccionAux);
				datosTributariosForm.setDireccionCorrespondenciaForm(direccionAux);
				logger.debug("termino de pasar las direcciones");
			}	
			
		}
		//Fin Inc.179734 01-01-2012 JLGN
		else{
			logger.debug("Se valida que los datos de direccion no sean vacios");
			if (buroDTO != null){// Si no es null se obtuvo datos de Buro y por ende Cliente no es prepago	
				logger.debug("buroDTO es Distinto de NULL");
				if(!buroDTO.getCodCanton().equals("") && !buroDTO.getCodDistrito().equals("") && !buroDTO.getCodProvincia().equals("")){
					//Inicio P-CSR-11002 JLGN 21-06-2011
					logger.debug("buroDTO.getCodCanton(): "+ buroDTO.getCodCanton());
					logger.debug("buroDTO.getCodDistrito(): "+ buroDTO.getCodDistrito());
					logger.debug("buroDTO.getCodProvincia(): "+ buroDTO.getCodProvincia());
					
					if(buroDTO.getCodCanton().trim().equals("0") && buroDTO.getCodDistrito().trim().equals("0") && buroDTO.getCodProvincia().trim().equals("0")){
						logger.debug("Mensaje de error Se debe Actualizar Dirección");
						request.setAttribute("mensajeError", "Se debe Actualizar Dirección");
					}
					//Fin P-CSR-11002 JLGN 21-06-2011
					logger.debug("Datos son distintos de vacios");
					FormularioDireccionDTO direccionDTO = new FormularioDireccionDTO();				
					direccionDTO.setCOD_TIPOCALLE("");
					direccionDTO.setDES_DIREC2("");
					//P-CSR-11002 JLGN 15-06-2011
					logger.debug("buroDTO.getCodComuna(): "+ buroDTO.getCodComuna());
					direccionDTO.setCOD_COMUNA(buroDTO.getCodComuna() != null ? buroDTO.getCodComuna() : "");
					direccionDTO.setDescripcionCOD_COMUNA("");
					direccionDTO.setDescripcionCOD_TIPOCALLE("");
					direccionDTO.setDescripcionZIP("");
					direccionDTO.setNOM_CALLE("");
					direccionDTO.setNUM_CALLE("");
					direccionDTO.setOBS_DIRECCION("");
					direccionDTO.setTipoDireccion("");
					direccionDTO.setZIP("");
					//direccionDTO.setCOD_CIUDAD(buroDTO.getCodCanton());
					//direccionDTO.setDescripcionCOD_CIUDAD(buroDTO.getDesCanton());
					direccionDTO.setCOD_CIUDAD(buroDTO.getCodDistrito());
					direccionDTO.setDescripcionCOD_CIUDAD(buroDTO.getDesDistrito());
					direccionDTO.setCOD_REGION(buroDTO.getCodProvincia());
					direccionDTO.setDescripcionCOD_REGION(buroDTO.getDesProvincia());
					//direccionDTO.setCOD_PROVINCIA(buroDTO.getCodDistrito());
					//direccionDTO.setDescripcionCOD_PROVINCIA(buroDTO.getDesDistrito());
					direccionDTO.setCOD_PROVINCIA(buroDTO.getCodCanton());
					direccionDTO.setDescripcionCOD_PROVINCIA(buroDTO.getDesCanton());
					direccionDTO.setDES_DIREC1(buroDTO.getDesDireccion());		
					datosTributariosForm.setDireccionFacturacion(obtenerDireccionAMostrar(direccionDTO));	
					datosTributariosForm.setDireccionFacturacionForm(direccionDTO);
					datosTributariosForm.setDireccionPersonalForm(direccionDTO);
					datosTributariosForm.setDireccionCorrespondenciaForm(direccionDTO);
					logger.debug("Se termino de setar datos de direccion");
				}else{
					//uno de los datos de direccion es vacio
					logger.debug("Mensaje de error Se debe Actualizar Dirección");
					request.setAttribute("mensajeError", "Se debe Actualizar Dirección");
					
					FormularioDireccionDTO direccionAux =  new FormularioDireccionDTO();				
					if (sesion.getAttribute("direccionPospago") != null){
						String codDireccion = (String)sesion.getAttribute("direccionPospago");			
						direccionAux = delegate.getDireccionPrepago(codDireccion);	
						//P-CSR-11002 JLGN 08-06-2011
						//direccionAux.setDES_DIREC1(buroDTO.getDesDireccion());
						logger.debug("obtuvo direccion OK");				
						datosTributariosForm.setDireccionFacturacion(obtenerDireccionAMostrar(direccionAux));
						datosTributariosForm.setDireccionPersonalForm(direccionAux);
						datosTributariosForm.setDireccionFacturacionForm(direccionAux);
						datosTributariosForm.setDireccionCorrespondenciaForm(direccionAux);
						logger.debug("termino de pasar las direcciones");
					}			
				}		
			}else{
				//P-CSR-11002 JLGN 06-06-2011
				//Datos de Buro es Nulo, Se valida si cliente es Distinto de Prepago
				if (datosTributariosForm.getFlagClientePrepago().equals("0")){
					//Cliente es Distinto de prepago
					FormularioDireccionDTO direccionAux =  new FormularioDireccionDTO();				
					if (sesion.getAttribute("direccionPospago") != null){
						String codDireccion = (String)sesion.getAttribute("direccionPospago");			
						direccionAux = delegate.getDireccionPrepago(codDireccion);	
						logger.debug("obtuvo direccion OK");				
						datosTributariosForm.setDireccionFacturacion(obtenerDireccionAMostrar(direccionAux));
						datosTributariosForm.setDireccionPersonalForm(direccionAux);
						datosTributariosForm.setDireccionFacturacionForm(direccionAux);
						datosTributariosForm.setDireccionCorrespondenciaForm(direccionAux);
						logger.debug("termino de pasar las direcciones");
					}						
				}			
			}
		}	
		//P-CSR-11002 28/04/2011
		datosTributariosForm.setCategoriaCambio("1");
		datosTributariosForm.setCategoriaTributaria("F");
		//P-CSR-11002 30-06-2011
		datosTributariosForm.setCategoriaImpositiva("1");
				
		//P-CSR-11002 12/04/2011 JLGN
		logger.debug("RA-11002");
		String cedulaIdentidad = global.getValorExterno("modulo.web.cedula.identidad");
		logger.debug("cedulaIdentidad: "+ cedulaIdentidad);
		request.getSession().setAttribute("cedulaIdentidad", cedulaIdentidad);
		
		String cedulaJuridica = global.getValorExterno("modulo.web.cedula.juridica");
		logger.debug("cedulaJuridica: "+ cedulaJuridica);
		request.getSession().setAttribute("cedulaJuridica", cedulaJuridica);
		
		String cedulaOtras = global.getValorExterno("modulo.web.cedula.otras");
		logger.debug("cedulaOtras: "+ cedulaOtras);
		request.getSession().setAttribute("cedulaOtras", cedulaOtras);
		
		logger.info("DatosTributariosAction, fin");
		return mapping.findForward("inicio");
	}

	/**
	 * Carga la direccion dejada en sesion por la página de direcciones
	 */
	public ActionForward cargarDireccion(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.info("cargarDireccion, inicio");
		DatosTributariosForm datosTributariosForm = (DatosTributariosForm)form;
		
		HttpSession sesion = request.getSession(false);
		if (sesion.getAttribute("FormularioDireccionDTO")!=null){
			FormularioDireccionDTO direccionAux = (FormularioDireccionDTO)((FormularioDireccionDTO)sesion.getAttribute("FormularioDireccionDTO")).clone();

			String tipoDireccion = direccionAux.getTipoDireccion();
			if (tipoDireccion.equals("PERS")){
				datosTributariosForm.setDireccionPersonalForm(direccionAux);
				datosTributariosForm.setDirecionPersonal(obtenerDireccionAMostrar(datosTributariosForm.getDireccionPersonalForm()));
			}
			else if (tipoDireccion.equals("FACT")){
				datosTributariosForm.setDireccionFacturacionForm(direccionAux);
				datosTributariosForm.setDireccionFacturacion(obtenerDireccionAMostrar(datosTributariosForm.getDireccionFacturacionForm()));				
			}
			else if (tipoDireccion.equals("CORR")){
				datosTributariosForm.setDireccionCorrespondenciaForm(direccionAux);
				datosTributariosForm.setDireccionCorrespondencia(obtenerDireccionAMostrar(datosTributariosForm.getDireccionCorrespondenciaForm()));				
			}
		}
		
		//P-CSR-11002 12/04/2011 JLGN
		logger.debug("RA-11002");
		String cedulaIdentidad = global.getValorExterno("modulo.web.cedula.identidad");
		logger.debug("cedulaIdentidad: "+ cedulaIdentidad);
		request.getSession().setAttribute("cedulaIdentidad", cedulaIdentidad);
		
		String cedulaJuridica = global.getValorExterno("modulo.web.cedula.juridica");
		logger.debug("cedulaJuridica: "+ cedulaJuridica);
		request.getSession().setAttribute("cedulaJuridica", cedulaJuridica);
		
		String cedulaOtras = global.getValorExterno("modulo.web.cedula.otras");
		logger.debug("cedulaOtras: "+ cedulaOtras);
		request.getSession().setAttribute("cedulaOtras", cedulaOtras);		
		
		logger.info("cargarDireccion, fin");
		return mapping.findForward("inicio");
	}
	
	public ActionForward ingresarDatosTercero(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.info("DatosTributariosAction, ingresarDatosTercero");
		return mapping.findForward("ingresarClienteFactura");
	}
	
	public ActionForward aceptarDatosTercero(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.info("aceptarDatosTercero, inicio");
		
		DatosTributariosForm datosTributariosForm = (DatosTributariosForm)form;
		datosTributariosForm.setFlagFacturacionTercero("1");
		
		//P-CSR-11002 12/04/2011 JLGN
		logger.debug("RA-11002");
		String cedulaIdentidad = global.getValorExterno("modulo.web.cedula.identidad");
		logger.debug("cedulaIdentidad: "+ cedulaIdentidad);
		request.getSession().setAttribute("cedulaIdentidad", cedulaIdentidad);
		
		String cedulaJuridica = global.getValorExterno("modulo.web.cedula.juridica");
		logger.debug("cedulaJuridica: "+ cedulaJuridica);
		request.getSession().setAttribute("cedulaJuridica", cedulaJuridica);
		
		String cedulaOtras = global.getValorExterno("modulo.web.cedula.otras");
		logger.debug("cedulaOtras: "+ cedulaOtras);
		request.getSession().setAttribute("cedulaOtras", cedulaOtras);
		
		logger.info("aceptarDatosTercero, fin");		
		return mapping.findForward("inicio");
	}
	
	
	public ActionForward ingresarDatosPago(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.info("DatosTributariosAction, ingresarDatosPago");
		
		//Inicio P-CSR-11002 JLGN 28-04-2011
		DatosTributariosForm datosTributariosForm = (DatosTributariosForm)form;
		
		if (datosTributariosForm.getFlagClientePrepago().equals("1")){
			logger.debug("Cliente Es prepago Se obtiene datos de direccion por defecto");
			FormularioDireccionDTO direccionAux =  new FormularioDireccionDTO();
			HttpSession sesion = request.getSession(false);
			if (sesion.getAttribute("direccionPrepago") != null){
				String codDireccion = (String)sesion.getAttribute("direccionPrepago");			
				direccionAux = delegate.getDireccionPrepago(codDireccion);	
				logger.debug("obtuvo direccion OK");
				datosTributariosForm.setDireccionPersonalForm(direccionAux);
				datosTributariosForm.setDireccionFacturacionForm(direccionAux);
				datosTributariosForm.setDireccionCorrespondenciaForm(direccionAux);
				logger.debug("termino de pasar las direcciones");
			}
		}
		//Fin P-CSR-11002 JLGN 28-04-2011
		return mapping.findForward("ingresarDatosPago");
	}
	
	public ActionForward ingresarDireccionPersonal(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.info("ingresarDireccionPersonal, inicio");
		DatosTributariosForm datosTributariosForm = (DatosTributariosForm)form;
		
		request.getSession(false).setAttribute("FormularioDireccionDTOSeleccionado", datosTributariosForm.getDireccionPersonalForm());
		
		logger.info("ingresarDireccionPersonal, fin");
		return mapping.findForward("ingresarDireccionPersonal");
	}
	
	public ActionForward ingresarDireccionFacturacion(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.info("ingresarDireccionFacturacion, inicio");
		DatosTributariosForm datosTributariosForm = (DatosTributariosForm)form;
		
		request.getSession(false).setAttribute("FormularioDireccionDTOSeleccionado", datosTributariosForm.getDireccionFacturacionForm());
		
		logger.info("ingresarDireccionFacturacion, fin");
		return mapping.findForward("ingresarDireccionFacturacion");
	}
	
	public ActionForward ingresarDireccionCorrespondencia(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.info("ingresarDireccionCorrespondencia, inicio");
		DatosTributariosForm datosTributariosForm = (DatosTributariosForm)form;
		
		request.getSession(false).setAttribute("FormularioDireccionDTOSeleccionado", datosTributariosForm.getDireccionCorrespondenciaForm());
		
		logger.info("ingresarDireccionCorrespondencia, fin");
		return mapping.findForward("ingresarDireccionCorrespondencia");
	}
	
	public ActionForward anterior(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.info("DatosTributariosAction, anterior");
		return mapping.findForward("anterior");
	}

	private String obtenerDireccionAMostrar(FormularioDireccionDTO direccionForm) {
		String dirAMostrar = "";
		if (!direccionForm.getNOM_CALLE().equals("")){
			dirAMostrar = dirAMostrar + direccionForm.getNOM_CALLE()+" ";
		}
		if (!direccionForm.getNUM_CALLE().equals("")){
			dirAMostrar = dirAMostrar + direccionForm.getNUM_CALLE()+" ";
		}
		if (!direccionForm.getCOD_CIUDAD().equals("")){
			dirAMostrar = dirAMostrar + direccionForm.getDescripcionCOD_CIUDAD()+" ";
		}
		if (!direccionForm.getDES_DIREC1().equals("")){
			dirAMostrar = dirAMostrar + direccionForm.getDES_DIREC1()+" ";
		}
		if (!direccionForm.getCOD_COMUNA().equals("")){
			dirAMostrar = dirAMostrar + direccionForm.getDescripcionCOD_COMUNA()+" ";
		}
		if (!direccionForm.getZIP().equals("")){
			dirAMostrar = dirAMostrar + ". Código Postal "+direccionForm.getDescripcionZIP()+" ";
		}
		if (!direccionForm.getCOD_REGION().equals("")){
			dirAMostrar = dirAMostrar + ". Departamento "+direccionForm.getDescripcionCOD_REGION()+" ";
		}
		if (!direccionForm.getCOD_PROVINCIA().equals("")){
			dirAMostrar = dirAMostrar + ". Municipio "+direccionForm.getDescripcionCOD_PROVINCIA()+" ";
		}
		if (!direccionForm.getDES_DIREC2().equals("")){
			dirAMostrar = dirAMostrar + direccionForm.getDES_DIREC2()+" ";
		}
		return dirAMostrar;
	}
	
	/**
	 * @author JIB
	 * @param datosTributariosForm
	 *            Se configura en la operadora mostrar o no los campos de categoria de cambio. Se establece valor por
	 *            defecto de cat. de cambio, tabla: FA_TASA_CAMBIO_TD, columna: COD_CATEGORIA_CAMBIO Incidencia: 130601.
	 */
	private void aplicarCategoriaCambio(DatosTributariosForm datosTributariosForm) {
		String valorAplicaCategoriaCambio = "1";
		final String claveAplicaCategoriaCambio = "modulo.web.alta.cliente.aplica.categoria.cambio";
		try {
			valorAplicaCategoriaCambio = global.getValorExterno(claveAplicaCategoriaCambio).trim();
			logger.trace("valorAplicaCategoriaCambio: " + valorAplicaCategoriaCambio);
		}
		catch (NullPointerException e) {
			logger.error("Error al obtener valor de properties: " + claveAplicaCategoriaCambio);
			logger.error(e.getMessage());
		}
		datosTributariosForm.setAplicaCategoriaCambio(valorAplicaCategoriaCambio);
		String valorCategoriaCambioPorDefecto = "";
		if (valorAplicaCategoriaCambio.equals("0")) {
			final String claveCategoriaCambioPorDefecto = "alta.cliente.cod.categoria.cambio.pordefecto";
			try {
				valorCategoriaCambioPorDefecto = global.getValor(claveCategoriaCambioPorDefecto).trim();
				logger.trace("valorCategoriaCambioPorDefecto: " + valorCategoriaCambioPorDefecto);
			}
			catch (NullPointerException e) {
				logger.error("Error al obtener valor de properties: " + claveCategoriaCambioPorDefecto);
				logger.error(e.getMessage());
			}
		}
		datosTributariosForm.setCategoriaCambio(valorCategoriaCambioPorDefecto);
	}
	
	/**
	 * @author JIB
	 * @param datosTributariosForm
	 * Se configura en la operadora mostrar o no los campos de factura a nombre de tercero.
	 * Incidencia: 130601.
	 */
	private void aplicarFacturaTercero(DatosTributariosForm datosTributariosForm) {
		String valorAplicaFacturaTercero = "1";
		final String claveAplicaFacturaTercero = "modulo.web.alta.cliente.aplica.factura.tercero";
		try {
			valorAplicaFacturaTercero = global.getValorExterno(claveAplicaFacturaTercero).trim();
			logger.trace("valorAplicaFacturaTercero: " + valorAplicaFacturaTercero);
		}
		catch (NullPointerException e) {
			logger.error("Error al obtener valor de properties: " + claveAplicaFacturaTercero);
			logger.error(e.getMessage());
		}
		datosTributariosForm.setAplicaFacturaTercero(valorAplicaFacturaTercero);
	}
}
