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
import com.tmmas.cl.scl.altacliente.presentacion.delegate.AltaClienteDelegate;
import com.tmmas.cl.scl.altacliente.presentacion.dto.RetornoAltaDTO;
import com.tmmas.cl.scl.altacliente.presentacion.form.AltaClienteFinalForm;
import com.tmmas.cl.scl.altacliente.presentacion.form.AltaClienteInicioForm;
import com.tmmas.cl.scl.altacliente.presentacion.form.BuscaCuentaForm;
import com.tmmas.cl.scl.altacliente.presentacion.form.ClienteFacturaForm;
import com.tmmas.cl.scl.altacliente.presentacion.form.DatosEmpresaForm;
import com.tmmas.cl.scl.altacliente.presentacion.form.DatosParticularForm;
import com.tmmas.cl.scl.altacliente.presentacion.form.DatosTributariosForm;
import com.tmmas.cl.scl.altacliente.presentacion.helper.Global;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ClienteAltaDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ConceptosRecaudacionComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.DatosClienteBuroDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ModalidadCancelacionComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.RepresentanteLegalComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.TipoCuentaBancariaComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.TipoNombramientoDTO;
import com.tmmas.cl.scl.commonbusinessentities.commonapp.DireccionNegocioWebDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ParametrosGlobalesDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.DatosGeneralesDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.ParametroDTO;


public class AltaClienteFinalAction extends DispatchAction {
	private final Logger logger = Logger.getLogger(AltaClienteFinalAction.class);
	private Global global = Global.getInstance();
	
	AltaClienteDelegate delegate = AltaClienteDelegate.getInstance();
	
	public ActionForward inicio(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.info("AltaClienteFinalAction,inicio");
		AltaClienteFinalForm altaClienteFinalForm = (AltaClienteFinalForm)form;
		
		//Inicio Inc. 179734 01-01-2012 JLGN
		DatosClienteBuroDTO buroDTO = new DatosClienteBuroDTO();
		buroDTO = (DatosClienteBuroDTO)request.getSession().getAttribute("datosClienteBuroDDA");
		//Fin Inc. 179734 RM 01-01-2012 JLGN
		
		//Sistema de pago --DWR
		
		//arrayBanco
		ConceptosRecaudacionComDTO[] arrayBancos =  delegate.getBancos();
		altaClienteFinalForm.setArrayBanco(arrayBancos);
		
		//Inicio P-CSR-11002 JLGN 11-05-2011
		DatosGeneralesDTO entrada = new DatosGeneralesDTO();			
		entrada.setCodigoModulo(global.getValor("codigo.modulo.GE"));
		entrada.setCodigoProducto(global.getValor("codigo.producto"));
		entrada.setCodigoParametro(global.getValor("parametro.banco.predefinido"));			
		logger.debug("Obtiene Codigo Banco Predefinido");
		entrada = delegate.getValorParametro(entrada);	
		logger.debug("Valor de Banco Predefinido: "+entrada.getValorParametro());
		altaClienteFinalForm.setBanco(entrada.getValorParametro());
		
		entrada.setCodigoModulo(global.getValor("codigo.modulo.GE"));
		entrada.setCodigoProducto(global.getValor("codigo.producto"));
		entrada.setCodigoParametro(global.getValor("parametro.sucursal.predefinido"));			
		logger.debug("Obtiene Codigo Sucursal Predefinido");
		entrada = delegate.getValorParametro(entrada);	
		logger.debug("Valor de Sucursal Predefinido: "+entrada.getValorParametro());
		altaClienteFinalForm.setSucursal(entrada.getValorParametro());
		altaClienteFinalForm.setCodSucursalSeleccionada(entrada.getValorParametro());
		
		entrada.setCodigoModulo(global.getValor("codigo.modulo.GE"));
		entrada.setCodigoProducto(global.getValor("codigo.producto"));
		entrada.setCodigoParametro(global.getValor("parametro.tarjeta.predefinida"));			
		logger.debug("Obtiene Codigo Tarjeta Predefinido");
		entrada = delegate.getValorParametro(entrada);	
		logger.debug("Valor de Tarjeta Predefinido: "+entrada.getValorParametro());
		altaClienteFinalForm.setTipoTarjeta(entrada.getValorParametro());
		//Fin P-CSR-11002 JLGN 11-05-2011
		
		//Sucursal -DWR
		
		//arrayTiposTarjeta
		ConceptosRecaudacionComDTO[] arrayTiposTarjeta = delegate.getTiposTarjetas();
		altaClienteFinalForm.setArrayTiposTarjeta(arrayTiposTarjeta);
		
		//arrayTipoCuentaBanc
		TipoCuentaBancariaComDTO[] arrayTiposCuentasBanc = delegate.getTiposCuentasBancarias();
		altaClienteFinalForm.setArrayTipoCuentaBanc(arrayTiposCuentasBanc);
		
		AltaClienteInicioForm altaClienteInicioForm = (AltaClienteInicioForm)request.getSession(false).getAttribute("AltaClienteInicioForm");
		if (altaClienteInicioForm!=null){
			
			String tipoClientePrepago  = global.getValor("tipo.cliente.prepago");
			String tipoClienteSeleccionado = altaClienteInicioForm.getTipoCliente();
			
			altaClienteFinalForm.setFlagClientePrepago(tipoClientePrepago.equals(tipoClienteSeleccionado)?"1":"0");
		}
		
		//arrayModalidadCancel
		ModalidadCancelacionComDTO[] arrayModalCancel = delegate.getModalidadesCancelacion();
		
		if (arrayModalCancel!=null){
			if (altaClienteFinalForm.getFlagClientePrepago().equals("1")){//solo debe mostrar modalidad manual
	
				ModalidadCancelacionComDTO[] arrayModalCancelManual = new ModalidadCancelacionComDTO[1];
				for(int i=0; i<arrayModalCancel.length;i++){
					if (arrayModalCancel[i].getCodigo().equals(global.getValor("modalidad.manual"))){
						ModalidadCancelacionComDTO  modalidadCancelacionComDTO = new ModalidadCancelacionComDTO();
						modalidadCancelacionComDTO.setCodigo(arrayModalCancel[i].getCodigo());
						modalidadCancelacionComDTO.setDescripcion(arrayModalCancel[i].getDescripcion());
						arrayModalCancelManual[0] = modalidadCancelacionComDTO;
						break;
					}
				}
				altaClienteFinalForm.setArrayModalidadCancel(arrayModalCancelManual);
				
			}else{
				
				ModalidadCancelacionComDTO[] arrayModalCancelTodas = new ModalidadCancelacionComDTO[arrayModalCancel.length+1];
				ModalidadCancelacionComDTO  modalidadCancelacionComDTO = new ModalidadCancelacionComDTO();
				modalidadCancelacionComDTO.setCodigo("");
				modalidadCancelacionComDTO.setDescripcion("- Seleccione -");
				
				arrayModalCancelTodas[0] = modalidadCancelacionComDTO;
				for(int i=0; i<arrayModalCancel.length;i++){
					arrayModalCancelTodas[i+1] = arrayModalCancel[i];
				}
				
				altaClienteFinalForm.setArrayModalidadCancel(arrayModalCancelTodas);
				
				//Inicio Inc. 179734 01-01-2012 JLGN 
				if(buroDTO.getFlagDDA().equals("true")){ 
					altaClienteFinalForm.setModalidadCancel("A");
				}else{
					//P-CSR-11002 JLGN 11-02-2011
					altaClienteFinalForm.setModalidadCancel("M");
				}	
				//Fin Inc. 179734 01-01-2012 JLGN
			}
		}
		
		//cargar listas de meses y años
		int rangoAgnos = Integer.parseInt(global.getValor("rango.agnos.tarjeta")); 
		ParametroDTO[] arrayMeses = new ParametroDTO[12]; 
		ParametroDTO[] arrayAgnos = new ParametroDTO[rangoAgnos];
		ParametroDTO parametro = null;
		
		for(int i=0; i<12; i++){
			String mes = String.valueOf(i+1);
			if (mes.length()==1) mes = "0"+mes;
			
			parametro = new ParametroDTO();
			parametro.setCodigoParametro(mes);
			parametro.setValorParametro(mes);
			arrayMeses[i] = parametro;
		}
		
		java.util.Calendar cal = java.util.Calendar.getInstance();
		int agnoInicio = cal.get(java.util.Calendar.YEAR);
		for(int i=0; i<rangoAgnos; i++){
			String agno =  String.valueOf(agnoInicio);
			parametro = new ParametroDTO();
			parametro.setCodigoParametro(agno);
			parametro.setValorParametro(agno);
			arrayAgnos[i] = parametro;
			agnoInicio++;
		}
		
		altaClienteFinalForm.setArrayMeses(arrayMeses);
		altaClienteFinalForm.setArrayAgnos(arrayAgnos);
		
		//Limpia variables de sesion
		request.getSession(false).removeAttribute("retornoAltaDTO");
		
		logger.info("AltaClienteFinalAction,fin");
		return mapping.findForward("inicio");
	}
	
	public ActionForward anterior(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.info("AltaClienteFinalAction,anterior");
		return mapping.findForward("anterior");
	}
	
	public ActionForward finalizar(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.info("AltaClienteFinalAction,finalizar");
        HttpSession session = request.getSession(false);
 		
        try {
			ClienteAltaDTO clienteAlta = new ClienteAltaDTO();
			
			//Busqueda de cuenta
			BuscaCuentaForm buscaCuentaForm = (BuscaCuentaForm)session.getAttribute("BuscaCuentaForm");
			clienteAlta.setCodigoCuenta("0");
			if (buscaCuentaForm!=null)
			{
				clienteAlta.setCodigoCuenta(buscaCuentaForm.getCodCuentaSel());
			}
			
			//Alta cliente inicio
			logger.info("Alta Cliente Inicio");
			AltaClienteInicioForm altaClienteInicioForm = (AltaClienteInicioForm)session.getAttribute("AltaClienteInicioForm");
			if (altaClienteInicioForm!=null)
			{
				/* Clasificacion del cliente */
				logger.info("Clasificacion del cliente");
				clienteAlta.setCodigoTipoCliente(altaClienteInicioForm.getTipoCliente());
				clienteAlta.setCodColor(altaClienteInicioForm.getCodColor());
				clienteAlta.setCodCrediticia(altaClienteInicioForm.getCodCrediticia());
				clienteAlta.setCodSegmento(altaClienteInicioForm.getCodSegmento());
				clienteAlta.setCodCalificacion(altaClienteInicioForm.getCodCalificacion());
				clienteAlta.setCodigoCategoria(altaClienteInicioForm.getCategoriaCliente());
				
				/* Datos generales*/
				logger.info("Datos generales");
				clienteAlta.setCodigoTipoIdentificacion(altaClienteInicioForm.getTipoIdentificacion1());
				clienteAlta.setNumeroIdentificacion(altaClienteInicioForm.getNumeroIdentificacion1());
				clienteAlta.setCodigoTipIdent2(altaClienteInicioForm.getTipoIdentificacion2());
				clienteAlta.setNumIdent2(altaClienteInicioForm.getNumeroIdentificacion2());
				clienteAlta.setCodigoCicloFacturacion(altaClienteInicioForm.getCodCicloSeleccionado());
				clienteAlta.setFacturaElectronica(altaClienteInicioForm.getRegistroFacturacion());
				clienteAlta.setMensajePromocional(altaClienteInicioForm.getMensajesPromocionales());
				clienteAlta.setDireccionEMail(altaClienteInicioForm.getCorreo());
				clienteAlta.setCodOperadoraAnterior(altaClienteInicioForm.getOperadoraAnterior());
				clienteAlta.setNumeroTelefono1(altaClienteInicioForm.getTelefono());
				//Inicio P-CSR-11002 JLGN 26-06-2011 RMS-003 Despliegue de parámetros en la Creación del Cliente
				clienteAlta.setEnvioFacturaFisica(altaClienteInicioForm.getEnvioFacturaFisica());
				clienteAlta.setCuentaFacebook(altaClienteInicioForm.getCuentaFacebook());
				clienteAlta.setCuentaTwitter(altaClienteInicioForm.getCuentaTwitter());
				//Fin P-CSR-11002 JLGN 26-06-2011
				
				/*Referencia del cliente*/ 
				logger.info("Referencia del cliente");
				clienteAlta.setReferenciasCliente(altaClienteInicioForm.getArrayRefClienteAlta());
				
				ArrayList lista = new ArrayList();
				RepresentanteLegalComDTO[] listaRepresentantes = null;
				RepresentanteLegalComDTO representante = new RepresentanteLegalComDTO();
				/*Usuario Legal*/
				logger.info("Usuario Legal");
				if(altaClienteInicioForm.getTipoIdentificacionUsuarioLegal() != null 
						&& !altaClienteInicioForm.getTipoIdentificacionUsuarioLegal().trim().equals(""))
				{			
					representante.setApellido1(altaClienteInicioForm.getApellido1UsuarioLegal());
					representante.setApellido2(altaClienteInicioForm.getApellido2UsuarioLegal());
					representante.setCodigoTipoIdentificacion(altaClienteInicioForm.getTipoIdentificacionUsuarioLegal());			
					representante.setCodigoTipoRepresentante(global.getValor("codigo.usuario.legal"));
					representante.setNombre(altaClienteInicioForm.getNombresUsuarioLegal());
					representante.setNumeroTipoIdentificacion(altaClienteInicioForm.getNumeroIdentificacionUsuarioLegal());
					lista.add(representante);
					representante = new RepresentanteLegalComDTO();
				}
				/*Usuario Autorizado*/
				logger.info("Usuario Autorizado");
				if(altaClienteInicioForm.getTipoIdentificacionUsuarioAut() != null 
						&& !altaClienteInicioForm.getTipoIdentificacionUsuarioAut().trim().equals(""))
				{			
					representante.setApellido1(altaClienteInicioForm.getApellido1UsuarioAut());
					representante.setApellido2(altaClienteInicioForm.getApellido2UsuarioAut());
					representante.setCodigoTipoIdentificacion(altaClienteInicioForm.getTipoIdentificacionUsuarioAut());			
					representante.setCodigoTipoRepresentante(global.getValor("codigo.usuario.autorizado"));
					representante.setNombre(altaClienteInicioForm.getNombresUsuarioAut());
					representante.setNumeroTipoIdentificacion(altaClienteInicioForm.getNumeroIdentificacionUsuarioAut());
					lista.add(representante);
				}
							
				listaRepresentantes =(RepresentanteLegalComDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
						lista.toArray(), RepresentanteLegalComDTO.class);
				clienteAlta.setRepresentanteLegalComDTO(listaRepresentantes);
			}
			
			//Datos Particular
			logger.info("Datos Particular");
			DatosParticularForm datosParticularForm = (DatosParticularForm)session.getAttribute("DatosParticularForm");
			if (datosParticularForm!=null && !altaClienteInicioForm.getTipoCliente().trim().equals(global.getValor("tipo.cliente.empresa"))&&
					!altaClienteInicioForm.getTipoCliente().trim().equals(global.getValor("tipo.cliente.pyme")))
			{
				 /* Cliente Particular */
				logger.info("datosParticular no es null");
				logger.info("Cliente Particular ");
				clienteAlta.setNombreApellido1(datosParticularForm.getPrimerApellido().trim());
				clienteAlta.setNombreApellido2(datosParticularForm.getSegundoApellido().trim());
				clienteAlta.setCodigoPais(datosParticularForm.getCodNacionalidad());
				clienteAlta.setFechaNacimiento(datosParticularForm.getFechaNacimiento());
				clienteAlta.setIndicadorSexo(datosParticularForm.getSexo().trim());
				clienteAlta.setIndicadorEstadoCivil(datosParticularForm.getEstadoCivil().trim());	
				clienteAlta.setNomConyuge(datosParticularForm.getNombreConyuge().trim());
				/*Inicio P-CSR-11002 JLGN 26-04-2011 RMS-003 Despliegue de parámetros en la Creación del Cliente				
				clienteAlta.setNomEmpresaTrabaja(datosParticularForm.getEmpresaTrabaja().trim());
				clienteAlta.setCodigoActividad(datosParticularForm.getCodProfesion().trim()); //Profesion
				clienteAlta.setTelefonoOficina(datosParticularForm.getTelefonoOficina());
				clienteAlta.setCodCargo(datosParticularForm.getCodCargo().trim());
				clienteAlta.setIngresosMensuales(datosParticularForm.getIngresosMensuales());
				clienteAlta.setJefeInmediato(datosParticularForm.getJefeInmediato().trim());
				if(datosParticularForm.getAnosLaborando() != null && !datosParticularForm.getAnosLaborando().trim().equals(""))
				{
					clienteAlta.setCant_antLaborando(Long.valueOf(datosParticularForm.getAnosLaborando()));
				}Fin P-CSR-11002 JLGN 26-04-2011*/
				clienteAlta.setNombreCliente(datosParticularForm.getNombreCliente().trim());
			}else{//P-CSR-11002 JLGN 08-06-2011
				if (!altaClienteInicioForm.getTipoCliente().trim().equals(global.getValor("tipo.cliente.empresa"))
						&& !altaClienteInicioForm.getTipoCliente().trim().equals(global.getValor("tipo.cliente.pyme"))){ 
					/* Cliente Particular */
					logger.info("datosParticular es null");
					logger.info("Cliente Particular desde Buro ");
					String codEstadoCivil = "";
					
					logger.info("Antes de Obtener datos de buro");
					DatosClienteBuroDTO buroDTO = (DatosClienteBuroDTO)session.getAttribute("datosClienteBuro");
					logger.info("Despues de Obtener datos de buro");
					
					clienteAlta.setNombreApellido1(buroDTO.getApellido1().trim());
					logger.info("buroDTO.getApellido1().trim(): "+ buroDTO.getApellido1().trim());
					clienteAlta.setNombreApellido2(buroDTO.getApellido2().trim());
					logger.info("buroDTO.getApellido2().trim(): "+ buroDTO.getApellido2().trim());
					clienteAlta.setFechaNacimiento(buroDTO.getFechaNacimiento().replace('/', '-').trim());
					logger.info("buroDTO.getFechaNacimiento().replace('/', '-').trim(): "+ buroDTO.getFechaNacimiento().replace('/', '-').trim());
					clienteAlta.setIndicadorSexo(buroDTO.getSexo());
					logger.info("buroDTO.getSexo(): "+ buroDTO.getSexo());
					clienteAlta.setNomConyuge(buroDTO.getNombreConyuge().trim());
					logger.info("buroDTO.getNombreConyuge().trim(): "+ buroDTO.getNombreConyuge().trim());
					clienteAlta.setNombreCliente(buroDTO.getNombre().trim());
					logger.info("buroDTO.getNombre().trim(): "+ buroDTO.getNombre().trim());
					
					//Se valida el Estado Civil				
					if(buroDTO.getCodEstadoCivil().equals("Mat01")){//Soltero(a)
						codEstadoCivil= "S";
					}else if(buroDTO.getCodEstadoCivil().equals("Mat02")){//Casado(a)
						codEstadoCivil= "C";
					}else if(buroDTO.getCodEstadoCivil().equals("Mat04")){//Divorciado(a)
						codEstadoCivil= "D";
					}else if(buroDTO.getCodEstadoCivil().equals("Mat05")){//Viudo(a)
						codEstadoCivil= "V";
					}else {//Separacion Judicial, Reconciliacion Judicial, Anulacion de Matrimonio
						codEstadoCivil= "O";
					}					
					clienteAlta.setIndicadorEstadoCivil(codEstadoCivil.trim());
					logger.info("codEstadoCivil.trim(): "+ codEstadoCivil.trim());
					
					clienteAlta.setCodigoPais(buroDTO.getCodPaisNacimiento());
					logger.info("buroDTO.getCodPaisNacimiento(): "+ buroDTO.getCodPaisNacimiento());
					
					//Nacionalidad Por Defecto
					/*String nacionalidad = global.getValorExterno("modulo.web.cod.nacionalidad");
					logger.debug("CodNacionalidad "+nacionalidad);
					clienteAlta.setCodigoPais(nacionalidad);*/
				}	
			}
			
			
			//Datos Empresa
			logger.info("Datos Empresa");
			DatosEmpresaForm  datosEmpresaForm = (DatosEmpresaForm)session.getAttribute("DatosEmpresaForm");
			//if (datosEmpresaForm!=null && altaClienteInicioForm.getTipoCliente().trim().equals(global.getValor("tipo.cliente.empresa")))
			//MA-184592 JLGN			
			if (datosEmpresaForm!=null && (altaClienteInicioForm.getTipoCliente().trim().equals(global.getValor("tipo.cliente.empresa")) ||
					altaClienteInicioForm.getTipoCliente().trim().equals(global.getValor("tipo.cliente.pyme"))))
			{
				/* Cliente Empresa */    
				logger.info("Cliente Empresa o pyme");
				logger.info("altaClienteInicioForm.getTipoCliente(): "+ altaClienteInicioForm.getTipoCliente());				
				clienteAlta.setRazonSocial(datosEmpresaForm.getRazonSocial().trim());
				clienteAlta.setPatenteComercio(datosEmpresaForm.getPatenteComercio().trim());
				clienteAlta.setCodigoTipoIdentificacionApoderado(datosEmpresaForm.getTipoIdentificacionRepLegal());
				clienteAlta.setNumeroIdentificacionApoderado(datosEmpresaForm.getNumeroIdentificacionRepLegal());
				clienteAlta.setNombreApoderado(datosEmpresaForm.getNombreRepLegal().trim());
				clienteAlta.setNombreCliente(datosEmpresaForm.getNombreEmpresa().trim());
			}else{//Inicio P-CSR-11002 JLGN 16-06-2011
				//if(altaClienteInicioForm.getTipoCliente().trim().equals(global.getValor("tipo.cliente.empresa"))){
				//MA-184592 JLGN
				if(altaClienteInicioForm.getTipoCliente().trim().equals(global.getValor("tipo.cliente.empresa")) || 
						altaClienteInicioForm.getTipoCliente().trim().equals(global.getValor("tipo.cliente.pyme"))){
					
					logger.info("datosEmpresa es null");
					logger.info("Cliente Empresa desde Buro ");
					logger.info("altaClienteInicioForm.getTipoCliente(): "+ altaClienteInicioForm.getTipoCliente());
										
					DatosClienteBuroDTO buroDTO = (DatosClienteBuroDTO)session.getAttribute("datosClienteBuro");
					clienteAlta.setNombreCliente(buroDTO.getNombre());
					clienteAlta.setRazonSocial(buroDTO.getRazonSocial());				
					clienteAlta.setPatenteComercio("");
					//Inicio Inc. 179734 JLGN 10-02-2012
					clienteAlta.setNombreApellido1(buroDTO.getApellido1().trim());
					clienteAlta.setNombreApellido2(buroDTO.getApellido2().trim());
					//Fin Inc. 179734 JLGN 10-02-2012
					//Inicio P-CSR-11002 JLGN 08-12-2011
					//clienteAlta.setCodigoTipoIdentificacionApoderado("");
					//clienteAlta.setNumeroIdentificacionApoderado("");
					//clienteAlta.setNombreApoderado("");
					TipoNombramientoDTO tipoNombramientoDTO [] = null;
					tipoNombramientoDTO = buroDTO.getTipoNombramientoDTO();
					logger.debug("Numero de nombramientos: "+ tipoNombramientoDTO.length);
					for(int x = 0; x < tipoNombramientoDTO.length;x++){
						if(tipoNombramientoDTO[x].getTipNombramiento().toUpperCase().trim().equals("PRESIDENTE")){
							logger.debug("Es Presidente");
							String nombreRepLegal = tipoNombramientoDTO[x].getNombreNombramiento()+" "+tipoNombramientoDTO[x].getApellido1Nombramiento()+" "+tipoNombramientoDTO[x].getApellido2Nombramiento();
							logger.debug("Nombre Presidente: "+ nombreRepLegal);	
							clienteAlta.setNombreApoderado(nombreRepLegal);
							String numeroIdentificacionRepLegal = tipoNombramientoDTO[x].getNumidentNombramiento(); 
							logger.debug("Numero Identificacion Presidente: "+ nombreRepLegal);
							clienteAlta.setNumeroIdentificacionApoderado(numeroIdentificacionRepLegal);
							//Se dejara Por defecto Tipo de Identificacion Cedula
							clienteAlta.setCodigoTipoIdentificacionApoderado("01");
						}				
					}			
					//Fin P-CSR-11002 JLGN 08-12-2011
				}
			}//Fin P-CSR-11002 JLGN 16-06-2011
			
			//Datos Tributarios
			logger.info("Datos Tributarios");
			DatosTributariosForm datosTributariosForm = (DatosTributariosForm)session.getAttribute("DatosTributariosForm");
			if (datosTributariosForm!=null)
			{
				clienteAlta.setCodigoOficina(datosTributariosForm.getOficina());
				clienteAlta.setCodigoCategImpos(datosTributariosForm.getCategoriaImpositiva());			
				clienteAlta.setCategoriaTributaria(datosTributariosForm.getCategoriaTributaria());
				clienteAlta.setCodigoTipoIdentificacionTributaria(datosTributariosForm.getTipoIdentificacionTrib());			
				clienteAlta.setNumeroIdentificacionTributaria(datosTributariosForm.getNumeroIdentificacionTrib());
				clienteAlta.setFacturaNombreTercero(datosTributariosForm.getFacturaTercero());
				clienteAlta.setCodigoCategCambio(datosTributariosForm.getCategoriaCambio()); //EV 23/02/2010
				
				/* Direcciones */
				logger.info("Direcciones ");
				ArrayList listaDir = new ArrayList();
				DireccionNegocioWebDTO[] listaDirecciones = null;
				DireccionNegocioWebDTO direccion = new DireccionNegocioWebDTO();
				
				/*Direccion Personal*/
				logger.info("Direccion Personal");
				direccion = new DireccionNegocioWebDTO();						
				direccion.setCodDepartamento(datosTributariosForm.getDireccionPersonalForm().getCOD_REGION());			
				direccion.setCodigoPostalDireccion(datosTributariosForm.getDireccionPersonalForm().getZIP());
				direccion.setCodMunicipio(datosTributariosForm.getDireccionPersonalForm().getCOD_PROVINCIA());
				direccion.setCodSiglaDomicilio(datosTributariosForm.getDireccionPersonalForm().getCOD_TIPOCALLE());
				direccion.setCodZonaDistrito(datosTributariosForm.getDireccionPersonalForm().getCOD_CIUDAD());
				
				//Incidencia 134089: setear el valor de comuna (Loc/Barrio)
				direccion.setLocBarrio(datosTributariosForm.getDireccionPersonalForm().getCOD_COMUNA());
				logger.debug("direccion.getLocBarrio() [" + direccion.getLocBarrio() + "]");
				logger.trace("direccion.getLocBarrio() [" + direccion.getLocBarrio() + "]");
				direccion.setDesDirec1(datosTributariosForm.getDireccionPersonalForm().getDES_DIREC1()); //Colonia
				logger.debug("direccion.getDesDireccion1() [" + direccion.getDesDirec1() + "]");
				logger.trace("direccion.getDesDireccion1() [" + direccion.getDesDirec1() + "]");
				direccion.setDesDirec2(datosTributariosForm.getDireccionPersonalForm().getDES_DIREC2()); //Direccion 2
				logger.debug("direccion.getDesDireccion2() [" + direccion.getDesDirec2() + "]");
				logger.trace("direccion.getDesDireccion2() [" + direccion.getDesDirec2() + "]");
				
				direccion.setNombreCalle(datosTributariosForm.getDireccionPersonalForm().getNOM_CALLE());
				direccion.setNumeroCalle(datosTributariosForm.getDireccionPersonalForm().getNUM_CALLE());
				direccion.setObservacionDireccion(datosTributariosForm.getDireccionPersonalForm().getOBS_DIRECCION());
				direccion.setTipo(Integer.valueOf(global.getValor("codigo.tipo.dir.personal").trim()).intValue());
				direccion.setDesDirec2(datosTributariosForm.getDireccionPersonalForm().getDES_DIREC2());
				direccion.setReplicada(false);
				listaDir.add(direccion);
				direccion = new DireccionNegocioWebDTO();
				
				/*Direccion Facturacion*/	
				logger.info("Direccion Facturacion");
				direccion.setCodDepartamento(datosTributariosForm.getDireccionFacturacionForm().getCOD_REGION());			
				direccion.setCodigoPostalDireccion(datosTributariosForm.getDireccionFacturacionForm().getZIP());
				direccion.setCodMunicipio(datosTributariosForm.getDireccionFacturacionForm().getCOD_PROVINCIA());
				direccion.setCodSiglaDomicilio(datosTributariosForm.getDireccionFacturacionForm().getCOD_TIPOCALLE());
				direccion.setCodZonaDistrito(datosTributariosForm.getDireccionFacturacionForm().getCOD_CIUDAD());
				direccion.setLocBarrio(datosTributariosForm.getDireccionFacturacionForm().getCOD_COMUNA());
				direccion.setNombreCalle(datosTributariosForm.getDireccionFacturacionForm().getNOM_CALLE());
				direccion.setNumeroCalle(datosTributariosForm.getDireccionFacturacionForm().getNUM_CALLE());
				direccion.setObservacionDireccion(datosTributariosForm.getDireccionFacturacionForm().getOBS_DIRECCION());
				direccion.setTipo(Integer.valueOf(global.getValor("codigo.tipo.dir.facturacion").trim()).intValue());
				direccion.setDesDirec1(datosTributariosForm.getDireccionPersonalForm().getDES_DIREC1());
				direccion.setDesDirec2(datosTributariosForm.getDireccionPersonalForm().getDES_DIREC2());
				direccion.setReplicada(datosTributariosForm.getDireccionFacturacionForm().isDireccionReplicada());				
				listaDir.add(direccion);
				direccion = new DireccionNegocioWebDTO();
				
				/*Direccion Correspondencia */		
				logger.info("Direccion Correspondencia");
				direccion.setCodDepartamento(datosTributariosForm.getDireccionCorrespondenciaForm().getCOD_REGION());			
				direccion.setCodigoPostalDireccion(datosTributariosForm.getDireccionCorrespondenciaForm().getZIP());
				direccion.setCodMunicipio(datosTributariosForm.getDireccionCorrespondenciaForm().getCOD_PROVINCIA());
				direccion.setCodSiglaDomicilio(datosTributariosForm.getDireccionCorrespondenciaForm().getCOD_TIPOCALLE());
				direccion.setCodZonaDistrito(datosTributariosForm.getDireccionCorrespondenciaForm().getCOD_CIUDAD());
				direccion.setLocBarrio(datosTributariosForm.getDireccionCorrespondenciaForm().getCOD_COMUNA());
				direccion.setNombreCalle(datosTributariosForm.getDireccionCorrespondenciaForm().getNOM_CALLE());
				direccion.setNumeroCalle(datosTributariosForm.getDireccionCorrespondenciaForm().getNUM_CALLE());
				direccion.setObservacionDireccion(datosTributariosForm.getDireccionCorrespondenciaForm().getOBS_DIRECCION());
				direccion.setTipo(Integer.valueOf(global.getValor("codigo.tipo.dir.correspondencia").trim()).intValue());
				direccion.setDesDirec2(datosTributariosForm.getDireccionPersonalForm().getDES_DIREC2());
				direccion.setDesDirec1(datosTributariosForm.getDireccionPersonalForm().getDES_DIREC1());
				direccion.setReplicada(datosTributariosForm.getDireccionCorrespondenciaForm().isDireccionReplicada());
				listaDir.add(direccion);
							
				listaDirecciones =(DireccionNegocioWebDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
						listaDir.toArray(), DireccionNegocioWebDTO.class);
				clienteAlta.setDirecciones(listaDirecciones);			
			}
			
			//Datos Cliente Factura
			logger.info("Datos Cliente Factura");
			ClienteFacturaForm clienteFacturaForm = (ClienteFacturaForm)session.getAttribute("ClienteFacturaForm");
			if (clienteFacturaForm!=null)
			{
				clienteAlta.setNombreClienteFactura(clienteFacturaForm.getNombreClienteFactura()); 
				clienteAlta.setApellido1ClienteFactura(clienteFacturaForm.getApellido1ClienteFactura());
				clienteAlta.setApellido2ClienteFactura(clienteFacturaForm.getApellido2ClienteFactura());
				clienteAlta.setTipoIdentClienteFactura(clienteFacturaForm.getTipoIdentClienteFactura());			
				clienteAlta.setNumeroIdentClienteFactura(clienteFacturaForm.getNumeroIdentClienteFactura());		
			}
			
	        //Alta cliente final
			logger.info("Alta cliente final");
			AltaClienteFinalForm altaClienteFinalForm = (AltaClienteFinalForm)form;
			if (altaClienteFinalForm!=null)
			{				
				ModalidadCancelacionComDTO modalidad = new ModalidadCancelacionComDTO();
				modalidad.setCodigo(altaClienteFinalForm.getModalidadCancel());
				clienteAlta.setModalidadCancelacionComDTO(modalidad);
				clienteAlta.setCodigoSistemaPago(altaClienteFinalForm.getCodSistemaPagoSeleccionado());
				//Inicio P-CSR-11002 JLGN 11-07-2011
		  		//Si modalidad de cancelacion es M (manual)
		  		//no se deben insertar los datos del banco
				if(!altaClienteFinalForm.getModalidadCancel().trim().equals("M")){													
					clienteAlta.setCodigoSucursal(altaClienteFinalForm.getCodSucursalSeleccionada());
					clienteAlta.setIndicadorTipoCuenta(altaClienteFinalForm.getTipoCuentaBanc());
					clienteAlta.setNumeroCuentaCorriente(altaClienteFinalForm.getNumeroCuenta());
									    
				    if(altaClienteFinalForm.getCodSistemaPagoSeleccionado().trim().equals("4"))
				    {
				    	clienteAlta.setCodigoBancoTarjeta(altaClienteFinalForm.getBanco());
				    	clienteAlta.setCodigoTipoTarjeta(altaClienteFinalForm.getTipoTarjeta());
						clienteAlta.setNumeroTarjeta(altaClienteFinalForm.getNumeroTarjeta());
						clienteAlta.setFechaVencimientoTarjeta(altaClienteFinalForm.getFechaVencimientoTarjeta());
						clienteAlta.setNomTipTarjeta(altaClienteFinalForm.getNombreTitularTarjeta());		    
					    clienteAlta.setObsPac(altaClienteFinalForm.getObservacionesTarjeta());
				    }else {
				    	clienteAlta.setCodigoBanco(altaClienteFinalForm.getBanco());
				    	clienteAlta.setCodigoTipoTarjeta("");
				    	clienteAlta.setNumeroTarjeta("");
				    	clienteAlta.setFechaVencimientoTarjeta("");
				    	clienteAlta.setNomTipTarjeta("");		    
					    clienteAlta.setObsPac("");
				    }
				}//Fin P-CSR-11002 JLGN 11-07-2011
			}
			//TODO: cambiar por usuario de conexion
			String user = ((ParametrosGlobalesDTO)session.getAttribute("paramGlobal")).getCodUsuario();
			clienteAlta.setNombreUsuarOra(user);
			
			//GRABAR
			logger.info("GRABAR");
			ClienteAltaDTO resultado = delegate.crearCliente(clienteAlta);
			
			//if(clienteAlta.getCodigoTipoCliente().trim().equals(global.getValor("tipo.cliente.empresa")))
			//MA-184592 JLGN
			if(clienteAlta.getCodigoTipoCliente().trim().equals(global.getValor("tipo.cliente.empresa"))
					||clienteAlta.getCodigoTipoCliente().trim().equals(global.getValor("tipo.cliente.pyme")))	
			{
				resultado.setNombreCliente(clienteAlta.getNombreCliente());
			}else{
				String apellido1 = clienteAlta.getNombreApellido1()==null?"":clienteAlta.getNombreApellido1();
				String apellido2 = clienteAlta.getNombreApellido2()==null?"":clienteAlta.getNombreApellido2();
				resultado.setNombreCliente(clienteAlta.getNombreCliente() + " " + apellido1 + " " + apellido2);
			}
			
			RetornoAltaDTO retornoAltaDTO = new RetornoAltaDTO();
			if (resultado !=null){
				retornoAltaDTO.setCodigoCuenta(resultado.getCodigoCuenta());
				retornoAltaDTO.setCodigoCliente(resultado.getCodigoCliente());
				retornoAltaDTO.setNombreCliente(resultado.getNombreCliente());
				clienteAlta.setCodigoCliente(resultado.getCodigoCliente());
				clienteAlta.setCodigoCuenta(resultado.getCodigoCuenta());
			}
			session.setAttribute("retornoAltaDTO", retornoAltaDTO);
			session.setAttribute("clienteAlta", clienteAlta);
        }catch(Exception e){
        	String mensaje = e.getMessage()==null?" ":e.getMessage(); 
        	request.setAttribute("mensajeError", "Ocurrio un error al crear cliente "+mensaje );
        	logger.debug("Ocurrio un error al crear cliente "+mensaje);
            return mapping.findForward("inicio");        	
        }
        

        return mapping.findForward("finalizar");
		
	}
	
	private void limpiarSesion(HttpServletRequest request){
		HttpSession sesion = request.getSession(false);
		
		sesion.removeAttribute("BuscaCuentaForm");
		sesion.removeAttribute("AltaClienteInicioForm");
		sesion.removeAttribute("DatosParticularForm");
		sesion.removeAttribute("DatosEmpresaForm");
		sesion.removeAttribute("DatosTributariosForm");
		sesion.removeAttribute("DireccionForm");
		sesion.removeAttribute("ClienteFacturaForm");
		sesion.removeAttribute("retornoAltaDTO");
		//P-CSR-11002 JLGN 06-06-2011
		sesion.removeAttribute("datosClienteBuro");
		
	}
	
	public ActionForward irAMenu(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.info("irAMenu,inicio");
		String forward = "irAMenu";
		HttpSession sesion = request.getSession(false);
		//AltaClienteInicioForm altaClienteInicioForm = (AltaClienteInicioForm)sesion.getAttribute("AltaClienteInicioForm");
		
		BuscaCuentaForm buscaCuentaForm = (BuscaCuentaForm) sesion.getAttribute("BuscaCuentaForm");
		
		logger.info("antes");
		
		/*
		if (altaClienteInicioForm!=null)
		{
			if (altaClienteInicioForm.getModuloOrigen().equals(global.getValor("modulo.web.solicitudventa"))){
				forward = "cargarClienteSolVenta";
				logger.info("va a solicitud de ventas");
			}
		}*/
		
		if (buscaCuentaForm != null) {
			String moduloWebSolicitudVenta = global.getValor("modulo.web.solicitudventa");
			logger.debug("moduloWebSolicitudVenta: " + moduloWebSolicitudVenta);
			String moduloOrigen = buscaCuentaForm.getModuloOrigen();
			logger.debug("moduloOrigen: " + moduloOrigen);
			if (moduloOrigen != null && moduloOrigen.equals(moduloWebSolicitudVenta)) {
				logger.info("va a solicitud de ventas");
				forward = "cargarClienteSolVenta";
			}
		}
		
        limpiarSesion(request);
        logger.info("irAMenu, fin");
		return mapping.findForward(forward);
	}
}
