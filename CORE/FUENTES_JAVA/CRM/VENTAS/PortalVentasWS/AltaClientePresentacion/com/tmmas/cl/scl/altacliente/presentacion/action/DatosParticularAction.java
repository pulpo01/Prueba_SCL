package com.tmmas.cl.scl.altacliente.presentacion.action;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.tmmas.cl.scl.altacliente.presentacion.delegate.AltaClienteDelegate;
import com.tmmas.cl.scl.altacliente.presentacion.form.BuscaCuentaForm;
import com.tmmas.cl.scl.altacliente.presentacion.form.DatosParticularForm;
import com.tmmas.cl.scl.altacliente.presentacion.helper.Global;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.CargoLaboralDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.DatosClienteBuroDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.DatosGeneralesComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ProfesionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosGeneralesDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.DatosGeneralesDTO;

public class DatosParticularAction extends DispatchAction {
	private final Logger logger = Logger.getLogger(DatosParticularAction.class);

	private Global global = Global.getInstance();

	final private static String CLAVE_NOM_JEFE_MANDATORIO = "modulo.web.alta.cliente.nom_jefe.mandatorio";

	final private static String CLAVE_ESTADO_CIVIL_CASADO = "codigo.estado.civil.casado";

	final private static String CLAVE_NOM_EMPRESA_MANDATORIO = "modulo.web.alta.cliente.nom_empresa.mandatorio";

	final private static String CLAVE_NOM_CONYUGE_CASADO_MANDATORIO = "modulo.web.alta.cliente.nom_conyuge.casado.mandatorio";

	final private static String CLAVE_SEGUNDO_APELLIDO_MANDATORIO = "modulo.web.alta.cliente.segundo_apellido.mandatorio";

	AltaClienteDelegate delegate = AltaClienteDelegate.getInstance();

	public ActionForward inicio(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("DatosParticularAction,inicio");

		DatosParticularForm f = (DatosParticularForm) form;
		DatosParticularForm datosParticularFormInicio = new DatosParticularForm();
		HttpSession sesion = request.getSession(false);
		//Inicio P-CSR-11002 JLGN 09-05-2011
		DatosClienteBuroDTO buroDTO = (DatosClienteBuroDTO)sesion.getAttribute("datosClienteBuro");
		//Fin P-CSR-11002 JLGN 09-05-2011

		// (+)-- Carga de listas --
		// Nacionalidad
		if (f.getArrayNacionalidad() == null) {
			DatosGeneralesComDTO[] arrayNacionalidad = delegate.getPaises();
			f.setArrayNacionalidad(arrayNacionalidad);
		}

		DatosGeneralesDTO entrada = new DatosGeneralesDTO();

		logger.debug("Recupera estados civiles...");

		String nombreTabla = global.getValor("tabla.clientes");
		entrada.setTabla(nombreTabla);
		logger.debug("nombre tabla: " + nombreTabla);

		String nombreColumna = global.getValor("columna.estado.civil.clientes");
		logger.debug("nombre columna: " + nombreColumna);
		entrada.setColumna(nombreColumna);

		String nombreModulo = global.getValor("codigo.modulo.GE");
		entrada.setCodigoModulo(nombreModulo);
		logger.debug("nombre modulo: " + nombreModulo);

		// JIB: Estado Civil llenado desde la base de datos
		DatosGeneralesComDTO[] r = null;
		if (f.getArrayEstadoCivil() == null) {

			DatosGeneralesDTO[] listCodigos = delegate.getListCodigo(entrada);
			int l = listCodigos.length;
			logger.debug("... estados civiles en tabla ged_codigos OK. Encontrados: " + l);
			logger.debug("listCodigos.length: " + l);
			r = new DatosGeneralesComDTO[l];
			for (int i = 0; i < l; i++) {
				DatosGeneralesDTO item = listCodigos[i];
				r[i] = new DatosGeneralesComDTO();
				r[i].setCodigoValor(item.getCodigoValor());
				r[i].setDescripcionValor(item.getDescripcionValor());
			}
			f.setArrayEstadoCivil(r);
		}

		/*
		 * //Estado civil if (datosParticularForm.getArrayEstadoCivil()==null){ DatosGeneralesComDTO[]
		 * arrayEstadosCiviles = delegate.getEstadosCiviles();
		 * datosParticularForm.setArrayEstadoCivil(arrayEstadosCiviles); }
		 */

		// Profesion
		if (f.getArrayProfesion() == null) {
			ProfesionDTO[] arrayProfesion = delegate.getProfesiones();
			f.setArrayProfesion(arrayProfesion);
		}
		
		//Inicio P-CSR-11002 JLGN 29-06-2011		
		if(f.getHoyMenosVeinte()== null){		
			logger.debug("f.getHoyMenosVeinte()== null");
			GregorianCalendar hoy = new GregorianCalendar();
			hoy.add(Calendar.YEAR, -20);
			SimpleDateFormat format = new SimpleDateFormat("dd-MM-yyyy");
			String hoyMenosVeinte = format.format(hoy.getTime());
			f.setHoyMenosVeinte(hoyMenosVeinte);
			datosParticularFormInicio.setHoyMenosVeinte(f.getHoyMenosVeinte());
			datosParticularFormInicio.setFechaNacimiento(f.getHoyMenosVeinte());
		}else{
			logger.debug("f.getHoyMenosVeinte()!= null");
			//datosParticularFormInicio.setHoyMenosVeinte(f.getHoyMenosVeinte());
			datosParticularFormInicio.setFechaNacimiento(f.getFechaNacimiento());
			logger.debug("fec_nacimiento: "+ f.getFechaNacimiento());
		}//Fin P-CSR-11002 JLGN 29-06-2011

		// Cargos laborales
		if (f.getArrayCargo() == null) {
			CargoLaboralDTO[] arrayCargo = delegate.getCargosLaborales();
			f.setArrayCargo(arrayCargo);
		}
		// (-)-- Carga de listas --

		ParametrosGeneralesDTO parametrosLargoCelular = new ParametrosGeneralesDTO();
		parametrosLargoCelular.setCodigoproducto(global.getValor("codigo.producto"));
		parametrosLargoCelular.setCodigomodulo(nombreModulo);
		parametrosLargoCelular.setNombreparametro(global.getValor("parametro.largo_n_celular"));
		parametrosLargoCelular = delegate.getParametroGeneral(parametrosLargoCelular);
		f.setLargoNumCelular(parametrosLargoCelular.getValorparametro());

		// guarda formulario inicial
		//DatosParticularForm datosParticularFormInicio = new DatosParticularForm();
		datosParticularFormInicio.setAnosLaborando(f.getAnosLaborando());
		datosParticularFormInicio.setCodCargo(f.getCodCargo());
		datosParticularFormInicio.setCodNacionalidad(f.getCodNacionalidad());
		datosParticularFormInicio.setCodProfesion(f.getCodProfesion());
		datosParticularFormInicio.setEmpresaTrabaja(f.getEmpresaTrabaja());
		datosParticularFormInicio.setEstadoCivil(f.getEstadoCivil());				
		datosParticularFormInicio.setIngresosMensuales(f.getIngresosMensuales());
		datosParticularFormInicio.setJefeInmediato(f.getJefeInmediato());
		
		//Inicio P-CSR-11002 JLGN 09-05-2011
		/*datosParticularFormInicio.setNombreCliente(f.getNombreCliente());
		datosParticularFormInicio.setNombreConyuge(f.getNombreConyuge());
		datosParticularFormInicio.setPrimerApellido(f.getPrimerApellido());
		datosParticularFormInicio.setSegundoApellido(f.getSegundoApellido());
		datosParticularFormInicio.setSexo(f.getSexo());
		datosParticularFormInicio.setFechaNacimiento(f.getFechaNacimiento());*/
		datosParticularFormInicio.setFlagTipCliente("false");
		f.setFlagTipCliente("false");
		
		if (f.getNombreCliente()== null || f.getNombreCliente().trim()== ""){
			if (buroDTO != null ){
				if (buroDTO.getFlagTipCliente().equals("true")){ //Solo se muestran los datos cuando el tipo de Cliente es distinto de Prepago
					//Cliente no es Prepago
					String codEstadoCivil = "";
					logger.debug("Cliente no es Prepago");
					datosParticularFormInicio.setNombreCliente(buroDTO.getNombre());
					logger.debug("Nombre Cliente: "+ buroDTO.getNombre());
					datosParticularFormInicio.setNombreConyuge(buroDTO.getNombreConyuge()+" "+buroDTO.getApellido1Conyuge()+" "+buroDTO.getApellido2Conyuge());
					logger.debug("Nombre Conyuge: "+ buroDTO.getNombreConyuge()+" "+buroDTO.getApellido1Conyuge()+" "+buroDTO.getApellido2Conyuge());
					datosParticularFormInicio.setPrimerApellido(buroDTO.getApellido1());
					logger.debug("Apellido1 Cliente: "+buroDTO.getApellido1());
					datosParticularFormInicio.setSegundoApellido(buroDTO.getApellido2());
					logger.debug("Apellido2 Cliente: "+buroDTO.getApellido2());
					datosParticularFormInicio.setSexo(buroDTO.getSexo());
					logger.debug("Sexo Cliente: "+buroDTO.getSexo());
					//P-CSR-11002 JLGN 15-07-2011
					if(!(buroDTO.getFechaNacimiento()==null)){
						datosParticularFormInicio.setFechaNacimiento(buroDTO.getFechaNacimiento().replace('/', '-'));
						logger.debug("Fecha Nacimiento Cliente: "+buroDTO.getFechaNacimiento().replace('/', '-'));
						datosParticularFormInicio.setHoyMenosVeinte(buroDTO.getFechaNacimiento().replace('/', '-'));
						logger.debug("HoyMenosVeinte Cliente: "+buroDTO.getFechaNacimiento().replace('/', '-'));
					}else{
						datosParticularFormInicio.setFechaNacimiento(f.getHoyMenosVeinte());
					}	
					datosParticularFormInicio.setFlagTipCliente("true");
									
					f.setNombreCliente(buroDTO.getNombre());
					logger.debug("Nombre Cliente: "+ buroDTO.getNombre());
					f.setNombreConyuge(buroDTO.getNombreConyuge()+" "+buroDTO.getApellido1Conyuge()+" "+buroDTO.getApellido2Conyuge());
					logger.debug("Nombre Conyuge: "+ buroDTO.getNombreConyuge()+" "+buroDTO.getApellido1Conyuge()+" "+buroDTO.getApellido2Conyuge());
					f.setPrimerApellido(buroDTO.getApellido1());
					logger.debug("Apellido1 Cliente: "+buroDTO.getApellido1());
					f.setSegundoApellido(buroDTO.getApellido2());
					logger.debug("Apellido2 Cliente: "+buroDTO.getApellido2());
					f.setSexo(buroDTO.getSexo());
					logger.debug("Sexo Cliente: "+buroDTO.getSexo());
					//P-CSR-11002 JLGN 15-07-2011
					if(!(buroDTO.getFechaNacimiento()==null)){
						datosParticularFormInicio.setFechaNacimiento(buroDTO.getFechaNacimiento().replace('/', '-'));
						logger.debug("Fecha Nacimiento Cliente: "+buroDTO.getFechaNacimiento().replace('/', '-'));
						f.setHoyMenosVeinte(buroDTO.getFechaNacimiento().replace('/', '-'));
						logger.debug("HoyMenosVeinte Cliente: "+buroDTO.getFechaNacimiento().replace('/', '-'));
					}else{
						f.setFechaNacimiento(f.getHoyMenosVeinte());
					}	
					f.setFlagTipCliente("true");
					
					// Se valida el Estado Civil				
					//P-CSR-11002 JLGN 15-07-2011
					if(!(buroDTO.getCodEstadoCivil()==null)){
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
					}else{
						codEstadoCivil="";
					}	
					logger.debug("Estado Civil "+codEstadoCivil);
					datosParticularFormInicio.setEstadoCivil(codEstadoCivil);
					f.setEstadoCivil(codEstadoCivil);
					
					//Nacionalidad Por Defecto
					//String nacionalidad = global.getValorExterno("modulo.web.cod.nacionalidad");
					//logger.debug("CodNacionalidad "+nacionalidad);
					datosParticularFormInicio.setCodNacionalidad(buroDTO.getCodPaisNacimiento());
					f.setCodNacionalidad(buroDTO.getCodPaisNacimiento());
					logger.debug("Nacionalidad "+buroDTO.getCodPaisNacimiento());
				}else{
					//Cliente es Prepago
					logger.debug("Cliente es Prepago");
					datosParticularFormInicio.setNombreCliente("");
					datosParticularFormInicio.setNombreConyuge("");
					datosParticularFormInicio.setPrimerApellido("");
					datosParticularFormInicio.setSegundoApellido("");
					datosParticularFormInicio.setSexo("");
					//datosParticularFormInicio.setFechaNacimiento("");
					datosParticularFormInicio.setEstadoCivil("");
					datosParticularFormInicio.setCodNacionalidad("");
									
					f.setNombreCliente("");
					f.setNombreConyuge("");
					f.setPrimerApellido("");
					f.setSegundoApellido("");
					f.setSexo("");
					//f.setFechaNacimiento("");
					f.setEstadoCivil("");
					f.setCodNacionalidad("");
					//Asi no se bloquea datos usuario autorizado o usuario legal
					request.getSession().setAttribute("flagDataBuro", "false");
				}
			}else{
				//Buro es nulo
				logger.debug("Buro es nulo");
				datosParticularFormInicio.setNombreCliente("");
				datosParticularFormInicio.setNombreConyuge("");
				datosParticularFormInicio.setPrimerApellido("");
				datosParticularFormInicio.setSegundoApellido("");
				datosParticularFormInicio.setSexo("");
				//datosParticularFormInicio.setFechaNacimiento("");
				datosParticularFormInicio.setEstadoCivil("");
				datosParticularFormInicio.setCodNacionalidad("");
								
				f.setNombreCliente("");
				f.setNombreConyuge("");
				f.setPrimerApellido("");
				f.setSegundoApellido("");
				f.setSexo("");
				//f.setFechaNacimiento("");
				f.setEstadoCivil("");
				f.setCodNacionalidad("");
				//Asi no se bloquea datos usuario autorizado o usuario legal
				request.getSession().setAttribute("flagDataBuro", "false");
			}
		}	
		//Fin P-CSR-11002 JLGN 09-05-2011
		datosParticularFormInicio.setTelefonoOficina(f.getTelefonoOficina());

		// Incidencia 133761. Datos Cliente Particular mandatorios. Quedan configurables por la operadora.
		final String nomConyugeCasadoMandatorio = global.getValorExterno(CLAVE_NOM_CONYUGE_CASADO_MANDATORIO);
		logger.debug("nomConyugeCasadoMandatorio [" + nomConyugeCasadoMandatorio + "]");
		f.setNomConyugeCasadoMandatorio(nomConyugeCasadoMandatorio != null ? nomConyugeCasadoMandatorio.trim() : "NO");
		datosParticularFormInicio.setNomConyugeCasadoMandatorio(f.getNomConyugeCasadoMandatorio());

		final String estadoCivilCasado = global.getValor(CLAVE_ESTADO_CIVIL_CASADO);
		logger.debug("estadoCivilCasado [" + estadoCivilCasado + "]");
		f.setEstadoCivilCasado(estadoCivilCasado.trim());
		datosParticularFormInicio.setEstadoCivilCasado(estadoCivilCasado.trim());

		final String nomEmpresaMandatorio = global.getValorExterno(CLAVE_NOM_EMPRESA_MANDATORIO);
		logger.debug("nomEmpresaMandatorio [" + nomEmpresaMandatorio + "]");
		f.setNomEmpresaMandatorio(nomEmpresaMandatorio != null ? nomEmpresaMandatorio.trim() : "NO");
		datosParticularFormInicio.setNomEmpresaMandatorio(f.getNomEmpresaMandatorio());

		final String nomJefeMandatorio = global.getValorExterno(CLAVE_NOM_JEFE_MANDATORIO);
		logger.debug("nomJefeMandatorio  [" + nomJefeMandatorio + "]");
		f.setNomJefeMandatorio(nomJefeMandatorio != null ? nomJefeMandatorio.trim() : "NO");
		datosParticularFormInicio.setNomJefeMandatorio(f.getNomJefeMandatorio());

		final String segundoApellidoMandatorio = global.getValorExterno(CLAVE_SEGUNDO_APELLIDO_MANDATORIO);
		logger.debug("segundoApellidoMandatorio [" + segundoApellidoMandatorio + "]");
		f.setSegundoApellidoMandatorio(segundoApellidoMandatorio != null ? segundoApellidoMandatorio.trim() : "NO");
		datosParticularFormInicio.setSegundoApellidoMandatorio(f.getSegundoApellidoMandatorio());

		sesion.setAttribute("datosParticularFormInicio", datosParticularFormInicio);
		//P-CSR-11002 JLGN 29-06-2011
		f.setHoyMenosVeinte(datosParticularFormInicio.getFechaNacimiento());
		f.setFechaNacimiento(datosParticularFormInicio.getFechaNacimiento());
		
		logger.info("DatosParticularAction,fin");
		return mapping.findForward("inicio");
	}

	public ActionForward aceptar(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("aceptar,inicio");
		HttpSession sesion = request.getSession(false);
		sesion.removeAttribute("datosParticularFormInicio");
		//P-CSR-11002 JLGN 04-08-2011
		request.getSession().setAttribute("mensajeErrorBuro", " ");
		logger.info("aceptar,fin");
		return mapping.findForward("aceptar");
	}

	public ActionForward cancelar(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("cancelar,inicio");
		DatosParticularForm datosParticularForm = (DatosParticularForm) form;
		HttpSession sesion = request.getSession(false);

		DatosParticularForm datosParticularFormTmp = (DatosParticularForm) sesion
				.getAttribute("datosParticularFormInicio");
		// vuelve a setear datos originales
		datosParticularForm.setAnosLaborando(datosParticularFormTmp.getAnosLaborando());
		datosParticularForm.setCodCargo(datosParticularFormTmp.getCodCargo());
		datosParticularForm.setCodNacionalidad(datosParticularFormTmp.getCodNacionalidad());
		datosParticularForm.setCodProfesion(datosParticularFormTmp.getCodProfesion());
		datosParticularForm.setEmpresaTrabaja(datosParticularFormTmp.getEmpresaTrabaja());
		datosParticularForm.setEstadoCivil(datosParticularFormTmp.getEstadoCivil());
		datosParticularForm.setFechaNacimiento(datosParticularFormTmp.getFechaNacimiento());
		datosParticularForm.setIngresosMensuales(datosParticularFormTmp.getIngresosMensuales());
		datosParticularForm.setJefeInmediato(datosParticularFormTmp.getJefeInmediato());
		datosParticularForm.setNombreCliente(datosParticularFormTmp.getNombreCliente());
		datosParticularForm.setNombreConyuge(datosParticularFormTmp.getNombreConyuge());
		datosParticularForm.setPrimerApellido(datosParticularFormTmp.getPrimerApellido());
		datosParticularForm.setSegundoApellido(datosParticularFormTmp.getSegundoApellido());
		datosParticularForm.setSexo(datosParticularFormTmp.getSexo());
		datosParticularForm.setTelefonoOficina(datosParticularFormTmp.getTelefonoOficina());

		sesion.removeAttribute("datosParticularFormInicio");

		logger.info("cancelar,fin");
		return mapping.findForward("cancelar");
	}
}
