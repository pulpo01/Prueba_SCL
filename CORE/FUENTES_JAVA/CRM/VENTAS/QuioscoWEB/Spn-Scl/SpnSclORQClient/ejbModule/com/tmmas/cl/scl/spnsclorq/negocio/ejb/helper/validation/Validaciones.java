package com.tmmas.cl.scl.spnsclorq.negocio.ejb.helper.validation;

import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.commonapp.dto.WsAltaCuentaSubCuentaInDTO;
import com.tmmas.cl.scl.commonapp.dto.WsCunetaAltaDeLineaDTO;
import com.tmmas.cl.scl.commonapp.dto.WsDireccionInDTO;
import com.tmmas.cl.scl.commonapp.dto.WsFacturacionVentaInDTO;
import com.tmmas.cl.scl.commonapp.dto.WsFacturacionVentaOutDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ReservaDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.SSuplementariosDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.WSSolicitudBajaAbonadoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.WsAgregaEliminaSSInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoLineaDTO;
import com.tmmas.cl.scl.spnsclwscommon.commonapp.dto.in.WsAceptacionVentaInDTO;
import com.tmmas.cl.scl.spnsclwscommon.commonapp.dto.in.WsCierreVentaInDTO;
import com.tmmas.cl.scl.spnsclwscommon.commonapp.dto.in.WsRechazoVentaInDTO;
import com.tmmas.cl.scl.commonapp.dto.WsCuentaInNDTO;
import com.tmmas.scl.serviciospostventasiga.transport.MigracionDTO;

public class Validaciones {

	
	private final static Logger logger = Logger.getLogger(Validaciones.class);
	private static CompositeConfiguration config; 
	
	
	/**
	 * 
	 */
	public Validaciones() {
		config = UtilProperty.getConfiguration("SpnSclORQ.properties","com/tmmas/cl/scl/spnsclorq/negocio/ejb/properties/SpnSclORQBean.properties");
		System.out.println("Validaciones(): Start");
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
		logger.debug("Validaciones():End");
	}		
	
		
	public static boolean validarFormato(String nombreCampo, String data)
	{		
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
		
		logger.debug("validarFormato(): Inicio");
		
		StringBuffer buffer = new StringBuffer("ws.");
		buffer.append(nombreCampo);
		buffer.append(".formato");
		
		logger.debug("Nombre Campo: "+ nombreCampo);
		logger.debug("Tipo Formato: "+ config.getString(buffer.toString()));
		logger.debug("Dato: "+ data);
		logger.debug("validarLongitud(): Fin");
		
		try
		{
			Pattern p = Pattern.compile(config.getString(buffer.toString()));
			Matcher m = p.matcher(data);
						
			return m.matches();
		}
		catch(Throwable t)
		{
			return false;
		}
	}
	
	
	public static boolean validarFormatoNumerico(String data)
	{		
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
		
		logger.debug("validarFormato(): Inicio");
				
		
		logger.debug("Tipo Formato: "+ "\\d+(([,][0-9]{2})?|([,][0-9]{1})?)");
		logger.debug("Dato: "+ data);
		logger.debug("validarLongitud(): Fin");
		
		try
		{
			Pattern p = Pattern.compile("\\d+(([,][0-9]{2})?|([,][0-9]{1})?)");
			Matcher m = p.matcher(data);
						
			return m.matches();
		}
		catch(Throwable t)
		{
			return false;
		}
	}	

	public static boolean validaRangoParametros(String longitudMax, String longitudMin, String valorEvaluado) {
		boolean retorno = false;
		long minima = new Long(longitudMin).longValue();
		long longmaxima = new Long(longitudMax).longValue();
		if(new Double(valorEvaluado).doubleValue() >= minima && new Double(valorEvaluado).doubleValue() <= longmaxima)
			retorno = true;
		else
			retorno = false;
		return retorno;
	}
	
	public static boolean validarLongitud(String nombreCampo, String data)
	{		
		UtilLog.setLog(config.getString("SpnSclOrqBean.log"));	
		
		logger.debug("validarLongitud(): Inicio");
		
		StringBuffer buffer = null;

		buffer = new StringBuffer("ws.");
		buffer.append(nombreCampo);
		buffer.append(".longitud.min");
		
		String longitudMin = config.getString(buffer.toString());

		buffer = new StringBuffer("ws.");
		buffer.append(nombreCampo);
		buffer.append(".longitud.max");
		
		String longitudMax = config.getString(buffer.toString());
		
		logger.debug("Nombre Campo: "+ nombreCampo);
		logger.debug("largo Min: "+ longitudMin);
		logger.debug("largo Max: "+ longitudMax);
		
		int largo;
		
		if (data == null)
			largo = 0;
		else
			largo = data.length();
		
		logger.debug("largo dato: "+largo);
		logger.debug("validarLongitud(): Fin");
		
		if (largo < Integer.parseInt(longitudMin))
			return false;
		
		if (largo > Integer.parseInt(longitudMax))
			return false;
		
		return true;
	}
	
	public static boolean isNumber(String cadena){
		boolean retValue=true;
		cadena=cadena==null?"":cadena;
		Character dig;
		if (!"".equals(cadena)){
			for (int j=0;j<cadena.length();j++){
				dig=new Character(cadena.charAt(j));
				if (!dig.isDigit(dig.charValue())){
					retValue=false;
					break;
				}
			}
		}
		else{
			retValue=false;
		}
		return retValue;
	}
	
	public static ArrayList getListaErroresException(GeneralException e){
		ArrayList list=new ArrayList();
			list.add(e.getCodigo());
		return list;
	}
	
//	-------------------------------- NUEVO ------------------------------------------------	
	
	public static ArrayList ValidarAltaCuentaSubCuentaInDTO(WsAltaCuentaSubCuentaInDTO cuentaIn){

		ArrayList listaRespuestaValidacion = new ArrayList(); 

		if(!validarLongitud("cuenta.desCuenta", cuentaIn.getDescripcionCuenta())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12020");
			respuesta.setMensajseError("Largo Descripción de cuenta inválido = " + cuentaIn.getDescripcionCuenta());
			System.out.println("Entro");
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("cuenta.tipCuenta", cuentaIn.getTipoDeCuenta())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12021");
			respuesta.setMensajseError("Largo del tipo de cuenta inválido = " + cuentaIn.getTipoDeCuenta());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("cuenta.nomResponsable", cuentaIn.getNombreResponsable())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12022");
			respuesta.setMensajseError("Largo del nombre del responsable inválido = " + cuentaIn.getNombreResponsable());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("cuenta.tipoDeIdentificacion", cuentaIn.getTipoDeIdentificacion())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12023");
			respuesta.setMensajseError("Largo del tipo de identificación inválido = " + cuentaIn.getTipoDeIdentificacion());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("cuenta.numIdentificacion", cuentaIn.getNumeroIdentificacion())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12024");
			respuesta.setMensajseError("Largo del numero de identificación inválido = " + cuentaIn.getNumeroIdentificacion());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("cuenta.codigoDireccion", cuentaIn.getCodigoDireccion())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12025");
			respuesta.setMensajseError("Largo del codigo de dirección inválido = " + cuentaIn.getCodigoDireccion());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("cuenta.telefonoContacto", cuentaIn.getTelefonoContacto())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12026");
			respuesta.setMensajseError("Largo del numero de telefono inválido= " + cuentaIn.getTelefonoContacto());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("cuenta.categoriaTributaria", cuentaIn.getCategoriaTributaria())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12027");
			respuesta.setMensajseError("Largo de categoria tributaria inválido = " + cuentaIn.getCategoriaTributaria());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("cuenta.codClasCuenta", cuentaIn.getCodigoClasificacion())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12028");
			respuesta.setMensajseError("Largo de codigo clase de cuenta inválido = " + cuentaIn.getCodigoClasificacion());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("cuenta.codTipoComisionista", cuentaIn.getCodigoComisionista1raVenta())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12029");
			respuesta.setMensajseError("Largo del codigo de tipo de comisionista inválido = " + cuentaIn.getCodigoComisionista1raVenta());
			listaRespuestaValidacion.add(respuesta);
		}
		
		
		
/******************** INICIO  FORMATO ***************/
		
		
		if(!validarFormato("cuenta.desCuenta", cuentaIn.getDescripcionCuenta())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12031");
			respuesta.setMensajseError("Formato descripción de cuenta inválido = " + cuentaIn.getDescripcionCuenta());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("cuenta.tipCuenta", cuentaIn.getTipoDeCuenta())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12032");
			respuesta.setMensajseError("Formato tipo de cuenta inválido = " + cuentaIn.getTipoDeCuenta());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("cuenta.nomResponsable", cuentaIn.getNombreResponsable())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12033");
			respuesta.setMensajseError("Formato nombre del responsable inválido = " + cuentaIn.getNombreResponsable());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("cuenta.tipoDeIdentificacion", cuentaIn.getTipoDeIdentificacion())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12034");
			respuesta.setMensajseError("Formato tipo de identificación inválido = " + cuentaIn.getTipoDeIdentificacion());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("cuenta.numIdentificacion", cuentaIn.getNumeroIdentificacion())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12035");
			respuesta.setMensajseError("Formato numero de identificación inválido = " + cuentaIn.getNumeroIdentificacion());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("cuenta.codigoDireccion", cuentaIn.getCodigoDireccion())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12036");
			respuesta.setMensajseError("Formato codigo de dirección inválido = " + cuentaIn.getCodigoDireccion());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("cuenta.telefonoContacto", cuentaIn.getTelefonoContacto())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12037");
			logger.debug("12037 - Formato numero de telefono inválido = [" + cuentaIn.getTelefonoContacto()+"]" );
			respuesta.setMensajseError("Formato numero de telefono inválido = " + cuentaIn.getTelefonoContacto());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("cuenta.categoriaTributaria", cuentaIn.getCategoriaTributaria())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12038");
			respuesta.setMensajseError("Formato categoria tributaria inválido = " + cuentaIn.getCategoriaTributaria());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("cuenta.codClasCuenta", cuentaIn.getCodigoClasificacion())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12039");
			respuesta.setMensajseError("Formato codigo clase de cuenta inválido = " + cuentaIn.getCodigoClasificacion());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("cuenta.codTipoComisionista", cuentaIn.getCodigoComisionista1raVenta())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12040");
			respuesta.setMensajseError("Formato codigo de tipo de comisionista inválido = " + cuentaIn.getCodigoComisionista1raVenta());
			listaRespuestaValidacion.add(respuesta);
		}
		
/******************** FIN FORMATO ***************/
		
		return listaRespuestaValidacion;		
	}
	
	
	
	public static ArrayList ValidarAltaCliente(WsCuentaInNDTO clienteIn){

		ArrayList listaRespuestaValidacion = new ArrayList();
		
		if(!validarLongitud("cuenta.codcuenta", clienteIn.getCodigoCuenta() )){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12042");
			respuesta.setMensajseError("Largo de codigo de cuenta inválido = " + clienteIn.getClienteDTO().getTelefonoContac1());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("cliente.numeroTelefono1", clienteIn.getClienteDTO().getTelefonoContac1())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12042");
			respuesta.setMensajseError("Largo de numero de telefono 1 inválido = " + clienteIn.getClienteDTO().getTelefonoContac1());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("cliente.numeroTelefono2", clienteIn.getClienteDTO().getTelefonoContac2())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12043");
			respuesta.setMensajseError("Largo de numero de telefono 2 inválido = " + clienteIn.getClienteDTO().getTelefonoContac2());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("cliente.codigoTipoIdentificacionApoderado", clienteIn.getClienteDTO().getApoderado().getCodigoTipident())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12044");
			respuesta.setMensajseError("Largo codigo identificacion apoderado inválido = " + clienteIn.getClienteDTO().getApoderado().getCodigoTipident());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("cliente.numeroIdentificacionApoderado", clienteIn.getClienteDTO().getApoderado().getNumeroIdent())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12045");
			respuesta.setMensajseError("Largo numero identificacion apoderado inválido = " + clienteIn.getClienteDTO().getApoderado().getNumeroIdent());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("cliente.nombreApoderado", clienteIn.getClienteDTO().getApoderado().getNomApoderado())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12046");
			respuesta.setMensajseError("Largo nombre apoderado inválido = " + clienteIn.getClienteDTO().getApoderado().getNomApoderado());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("cliente.codigoTipoIdentificacionResponsable", clienteIn.getClienteDTO().getResponsable().getCodigoTipident())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12047");
			respuesta.setMensajseError("Largo codigo identificacion responsable inválido = " + clienteIn.getClienteDTO().getResponsable().getCodigoTipident());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("cliente.nombreResponsable", clienteIn.getClienteDTO().getResponsable().getNombreResponsable())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12048");
			respuesta.setMensajseError("Largo nombre responsable inválido = " + clienteIn.getClienteDTO().getResponsable().getNombreResponsable());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("cliente.numeroIdentificacionResponsable", clienteIn.getClienteDTO().getResponsable().getNumeroIdent())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12049");
			respuesta.setMensajseError("Largo numero identificacion responsable inválido = " + clienteIn.getClienteDTO().getResponsable().getNumeroIdent());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("cliente.nombreCliente", clienteIn.getClienteDTO().getNombreCliente())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12050");
			respuesta.setMensajseError("Largo nombre cliente inválido = " + clienteIn.getClienteDTO().getNombreCliente());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("cliente.nombreApellido1", clienteIn.getClienteDTO().getNombreApeclien1())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12051");
			respuesta.setMensajseError("Largo nombre apellido 1 inválido = " + clienteIn.getClienteDTO().getNombreApeclien1());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("cliente.nombreApellido2", clienteIn.getClienteDTO().getNombreApeclien2())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12052");
			respuesta.setMensajseError("Largo nombre apellido 2 inválido = " + clienteIn.getClienteDTO().getNombreApeclien2());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("cliente.codigoCicloFacturacion", String.valueOf(clienteIn.getClienteDTO().getCodigoCiclo()))){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12053");
			respuesta.setMensajseError("Largo codigo Ciclo Facturacion inválido = " + clienteIn.getClienteDTO().getCodigoCiclo());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("cliente.direccionEmail", clienteIn.getClienteDTO().getNombreEmail())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12053");
			respuesta.setMensajseError("Largo nombre email inválido = " + clienteIn.getClienteDTO().getNombreEmail());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("cliente.codigoOficina", clienteIn.getClienteDTO().getCodigoOficina())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12055");
			respuesta.setMensajseError("Largo codigo Oficina inválido = " + clienteIn.getClienteDTO().getCodigoOficina());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("cliente.indicadorDebito", clienteIn.getClienteDTO().getPagoAtumaticoManual())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12056");
			respuesta.setMensajseError("Largo pago automatico manual inválido = " + clienteIn.getClienteDTO().getPagoAtumaticoManual());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("cliente.codigoSistemaPago", clienteIn.getClienteDTO().getCodSistemaPago())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12057");
			respuesta.setMensajseError("Largo codigo sistema pago inválido = " + clienteIn.getClienteDTO().getCodSistemaPago());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("cliente.codigoUso", clienteIn.getClienteDTO().getCodigoUso())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12058");
			respuesta.setMensajseError("Largo codigo uso inválido = " + clienteIn.getClienteDTO().getCodigoUso());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("cliente.codigoBanco", clienteIn.getClienteDTO().getBanco().getCodBanco())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12059");
			respuesta.setMensajseError("Largo codigo Banco inválido = " + clienteIn.getClienteDTO().getBanco().getCodBanco());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("cliente.codigoSucursal", clienteIn.getClienteDTO().getBanco().getSucursal().getCodigoSucursal())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12060");
			respuesta.setMensajseError("Largo codigo Sucursal inválido = " + clienteIn.getClienteDTO().getBanco().getSucursal().getCodigoSucursal());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("cliente.indicadorTipoCuenta", clienteIn.getClienteDTO().getBanco().getIndicadorTipcuenta())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12061");
			respuesta.setMensajseError("Largo indicado tipo de cuenta inválido = " + clienteIn.getClienteDTO().getBanco().getIndicadorTipcuenta());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("cliente.numeroCuentaCorriente", clienteIn.getClienteDTO().getBanco().getNumeroCtacorr())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12062");
			respuesta.setMensajseError("Largo numero cuenta corriente inválido = " + clienteIn.getClienteDTO().getBanco().getNumeroCtacorr());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("cliente.tipoTarjeta", clienteIn.getClienteDTO().getBanco().getTarjeta().getTipoTarjeta())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12063");
			respuesta.setMensajseError("Largo tipo de tarjeta inválido = " + clienteIn.getClienteDTO().getBanco().getTarjeta().getTipoTarjeta());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("cliente.numeroTarjeta", clienteIn.getClienteDTO().getBanco().getTarjeta().getNumeroTarjeta())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12064");
			respuesta.setMensajseError("Largo numero de tarjeta inválido = " + clienteIn.getClienteDTO().getBanco().getTarjeta().getNumeroTarjeta());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("cliente.nombreUsuarioOra", clienteIn.getNomUsuarioOra() )){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12065");
			respuesta.setMensajseError("Largo nombre usuario inválido = " + clienteIn.getNomUsuarioOra());
			listaRespuestaValidacion.add(respuesta);
		}	
		
		if(!validarLongitud("cliente.codigoTipoIdentificacionCliente", clienteIn.getClienteDTO().getCodigoTipoIdent())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12066");
			respuesta.setMensajseError("Largo codigo tipo identificacion cliente inválido = " + clienteIn.getClienteDTO().getCodigoTipoIdent());
			listaRespuestaValidacion.add(respuesta);
		}

		if(!validarLongitud("cliente.numeroIdentificacionCliente", clienteIn.getClienteDTO().getNumeroIdent())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12067");
			respuesta.setMensajseError("Largo numero identificacion cliente inválido = " + clienteIn.getClienteDTO().getNumeroIdent());
			listaRespuestaValidacion.add(respuesta);
		}

		if(!validarLongitud("cliente.indicadorEstadoCivil", clienteIn.getClienteDTO().getIndicadorEstadoCivil())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12068");
			respuesta.setMensajseError("Largo indicador estado civil inválido = " + clienteIn.getClienteDTO().getIndicadorEstadoCivil());
			listaRespuestaValidacion.add(respuesta);
		}

		if(!validarLongitud("cliente.indicadorSexo", clienteIn.getClienteDTO().getIndicadorSexo())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12069");
			respuesta.setMensajseError("Largo indicador sexo inválido = " + clienteIn.getClienteDTO().getIndicadorSexo());
			listaRespuestaValidacion.add(respuesta);
		}

		if(!validarLongitud("cliente.codDireccionFacturacion", clienteIn.getClienteDTO().getCodDireccionFacturacion())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12070");
			respuesta.setMensajseError("Largo direccion facturacion inválido = " + clienteIn.getClienteDTO().getCodDireccionFacturacion());
			listaRespuestaValidacion.add(respuesta);
		}

		if(!validarLongitud("cliente.codDireccionPersonal", clienteIn.getClienteDTO().getCodDireccionPersonal())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12071");
			respuesta.setMensajseError("Largo direccion Personal inválido = " + clienteIn.getClienteDTO().getCodDireccionPersonal());
			listaRespuestaValidacion.add(respuesta);
		}

		if(!validarLongitud("cliente.codDireccionCorrespondencia", clienteIn.getClienteDTO().getCodDireccionCorrespondencia())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12072");
			respuesta.setMensajseError("Largo direccion Correspondencia inválido = " + clienteIn.getClienteDTO().getCodDireccionCorrespondencia());
			listaRespuestaValidacion.add(respuesta);
		}

		if(!validarLongitud("cliente.codigoPlanTarifario", clienteIn.getClienteDTO().getCodigoPlanTarifario())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12073");
			respuesta.setMensajseError("Largo codigo plan tarifario inválido = " + clienteIn.getClienteDTO().getCodigoPlanTarifario());
			listaRespuestaValidacion.add(respuesta);
		}

		if(!validarLongitud("cliente.codigoPais", clienteIn.getClienteDTO().getCodigoPais())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12074");
			respuesta.setMensajseError("Largo codigo pais inválido = " + clienteIn.getClienteDTO().getCodigoPais());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("cliente.categoria", clienteIn.getClienteDTO().getCodigoCategoria() )){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12074");
			respuesta.setMensajseError("Largo de categoria de cliente inválido = " + clienteIn.getClienteDTO().getCodigoCategoria());
			listaRespuestaValidacion.add(respuesta);
		}
		
		
		
		
/**************************INICIO FORMATO******************************/
		
		
		if(!validarFormato("cliente.categoria", clienteIn.getClienteDTO().getCodigoCategoria())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("120752");
			respuesta.setMensajseError("Formato de categoria inválido = " + clienteIn.getClienteDTO().getCodigoCategoria());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("cuenta.codcuenta", clienteIn.getCodigoCuenta() )){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12042");
			respuesta.setMensajseError("Formato de codigo de cuenta inválido = " + clienteIn.getCodigoCuenta());
			listaRespuestaValidacion.add(respuesta);
		}		
		
		if(!validarFormato("cliente.numeroTelefono1", clienteIn.getClienteDTO().getTelefonoContac1())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12075");
			respuesta.setMensajseError("Formato de numero de telefono 1 inválido = " + clienteIn.getClienteDTO().getTelefonoContac1());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("cliente.numeroTelefono2", clienteIn.getClienteDTO().getTelefonoContac2())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12076");
			respuesta.setMensajseError("Formato de numero de telefono 2 inválido = " + clienteIn.getClienteDTO().getTelefonoContac2());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("cliente.codigoTipoIdentificacionApoderado", clienteIn.getClienteDTO().getApoderado().getCodigoTipident())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12077");
			respuesta.setMensajseError("Formato codigo identificacion apoderado inválido = " + clienteIn.getClienteDTO().getApoderado().getCodigoTipident());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("cliente.numeroIdentificacionApoderado", clienteIn.getClienteDTO().getApoderado().getNumeroIdent())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12078");
			respuesta.setMensajseError("Formato numero identificacion apoderado inválido = " + clienteIn.getClienteDTO().getApoderado().getNumeroIdent());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("cliente.nombreApoderado", clienteIn.getClienteDTO().getApoderado().getNomApoderado())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12079");
			respuesta.setMensajseError("Formato nombre apoderado inválido = " + clienteIn.getClienteDTO().getApoderado().getNomApoderado());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("cliente.codigoTipoIdentificacionResponsable", clienteIn.getClienteDTO().getResponsable().getCodigoTipident())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12080");
			respuesta.setMensajseError("Formato codigo identificacion responsable inválido = " + clienteIn.getClienteDTO().getResponsable().getCodigoTipident());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("cliente.nombreResponsable", clienteIn.getClienteDTO().getResponsable().getNombreResponsable())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12081");
			respuesta.setMensajseError("Formato nombre responsable inválido = " + clienteIn.getClienteDTO().getResponsable().getNombreResponsable());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("cliente.numeroIdentificacionResponsable", clienteIn.getClienteDTO().getResponsable().getNumeroIdent())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12082");
			respuesta.setMensajseError("Formato numero identificacion responsable inválido = " + clienteIn.getClienteDTO().getResponsable().getNumeroIdent());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("cliente.nombreCliente", clienteIn.getClienteDTO().getNombreCliente())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12083");
			respuesta.setMensajseError("Formato nombre cliente inválido = " + clienteIn.getClienteDTO().getNombreCliente());
			listaRespuestaValidacion.add(respuesta);
		}
		
		/*if(!validarFormato("cliente.nombreApellido1", clienteIn.getClienteDTO().getNombreApeclien1())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12084");
			respuesta.setMensajseError("Formato nombre apellido 1 inválido = " + clienteIn.getClienteDTO().getNombreApeclien1());
			listaRespuestaValidacion.add(respuesta);
		}*/
		
		/*if(!validarFormato("cliente.nombreApellido2", clienteIn.getClienteDTO().getNombreApeclien2())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12085");
			respuesta.setMensajseError("Formato nombre apellido 2 inválido = " + clienteIn.getClienteDTO().getNombreApeclien2());
			listaRespuestaValidacion.add(respuesta);
		}*/
		
		if(!validarFormato("cliente.codigoCicloFacturacion", String.valueOf(clienteIn.getClienteDTO().getCodigoCiclo()))){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12086");
			respuesta.setMensajseError("Formato codigo Ciclo Facturacion inválido = " + clienteIn.getClienteDTO().getCodigoCiclo());
			listaRespuestaValidacion.add(respuesta);
		}
		
		/*if(!validarFormato("cliente.direccionEmail", clienteIn.getClienteDTO().getNombreEmail())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12087");
			respuesta.setMensajseError("Formato nombre email inválido = " + clienteIn.getClienteDTO().getNombreEmail());
			listaRespuestaValidacion.add(respuesta);
		}*/
		
		if(!validarFormato("cliente.codigoOficina", clienteIn.getClienteDTO().getCodigoOficina())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12088");
			respuesta.setMensajseError("Formato codigo Oficina inválido = " + clienteIn.getClienteDTO().getCodigoOficina());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("cliente.indicadorDebito", clienteIn.getClienteDTO().getPagoAtumaticoManual())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12089");
			respuesta.setMensajseError("Formato pago automatico manual inválido = " + clienteIn.getClienteDTO().getPagoAtumaticoManual());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("cliente.codigoSistemaPago", clienteIn.getClienteDTO().getCodSistemaPago())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12090");
			respuesta.setMensajseError("Formato codigo sistema pago inválido = " + clienteIn.getClienteDTO().getCodSistemaPago());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("cliente.codigoUso", clienteIn.getClienteDTO().getCodigoUso())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12091");
			respuesta.setMensajseError("Formato codigo uso inválido = " + clienteIn.getClienteDTO().getCodigoUso());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("cliente.codigoBanco", clienteIn.getClienteDTO().getBanco().getCodBanco())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12092");
			respuesta.setMensajseError("Formato codigo Banco inválido = " + clienteIn.getClienteDTO().getBanco().getCodBanco());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("cliente.codigoSucursal", clienteIn.getClienteDTO().getBanco().getSucursal().getCodigoSucursal())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12093");
			respuesta.setMensajseError("Formato codigo Sucursal inválido = " + clienteIn.getClienteDTO().getBanco().getSucursal().getCodigoSucursal());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("cliente.indicadorTipoCuenta", clienteIn.getClienteDTO().getBanco().getIndicadorTipcuenta())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12094");
			respuesta.setMensajseError("Formato indicado tipo de cuenta inválido = " + clienteIn.getClienteDTO().getBanco().getIndicadorTipcuenta());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("cliente.numeroCuentaCorriente", clienteIn.getClienteDTO().getBanco().getNumeroCtacorr())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12095");
			respuesta.setMensajseError("Formato numero cuenta corriente inválido = " + clienteIn.getClienteDTO().getBanco().getNumeroCtacorr());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("cliente.tipoTarjeta", clienteIn.getClienteDTO().getBanco().getTarjeta().getTipoTarjeta())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12096");
			respuesta.setMensajseError("Formato tipo de tarjeta inválido = " + clienteIn.getClienteDTO().getBanco().getTarjeta().getTipoTarjeta());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("cliente.numeroTarjeta", clienteIn.getClienteDTO().getBanco().getTarjeta().getNumeroTarjeta())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12097");
			respuesta.setMensajseError("Formato numero de tarjeta inválido = " + clienteIn.getClienteDTO().getBanco().getTarjeta().getNumeroTarjeta());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("cliente.nombreUsuarioOra", clienteIn.getNomUsuarioOra() )){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12098");
			respuesta.setMensajseError("Formato nombre usuario inválido = " + clienteIn.getNomUsuarioOra());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("cliente.codigoTipoIdentificacionCliente", clienteIn.getClienteDTO().getCodigoTipoIdent())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12099");
			respuesta.setMensajseError("Formato codigo tipo identificacion cliente inválido = " + clienteIn.getClienteDTO().getCodigoTipoIdent());
			listaRespuestaValidacion.add(respuesta);
		}

		if(!validarFormato("cliente.numeroIdentificacionCliente", clienteIn.getClienteDTO().getNumeroIdent())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12100");
			respuesta.setMensajseError("Formato numero identificacion cliente inválido = " + clienteIn.getClienteDTO().getNumeroIdent());
			listaRespuestaValidacion.add(respuesta);
		}

		if(!validarFormato("cliente.indicadorEstadoCivil", clienteIn.getClienteDTO().getIndicadorEstadoCivil())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12101");
			respuesta.setMensajseError("Formato indicador estado civil inválido = " + clienteIn.getClienteDTO().getIndicadorEstadoCivil());
			listaRespuestaValidacion.add(respuesta);
		}

		if(!validarFormato("cliente.indicadorSexo", clienteIn.getClienteDTO().getIndicadorSexo())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12102");
			respuesta.setMensajseError("Formato indicador sexo inválido = " + clienteIn.getClienteDTO().getIndicadorSexo());
			listaRespuestaValidacion.add(respuesta);
		}

		if(!validarFormato("cliente.codDireccionFacturacion", clienteIn.getClienteDTO().getCodDireccionFacturacion())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12103");
			respuesta.setMensajseError("Formato direccion facturacion inválido = " + clienteIn.getClienteDTO().getCodDireccionFacturacion());
			listaRespuestaValidacion.add(respuesta);
		}

		if(!validarFormato("cliente.codDireccionPersonal", clienteIn.getClienteDTO().getCodDireccionPersonal())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12104");
			respuesta.setMensajseError("Formato direccion Personal inválido = " + clienteIn.getClienteDTO().getCodDireccionPersonal());
			listaRespuestaValidacion.add(respuesta);
		}

		if(!validarFormato("cliente.codDireccionCorrespondencia", clienteIn.getClienteDTO().getCodDireccionCorrespondencia())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12105");
			respuesta.setMensajseError("Formato direccion Correspondencia inválido = " + clienteIn.getClienteDTO().getCodDireccionCorrespondencia());
			listaRespuestaValidacion.add(respuesta);
		}

		if(!validarFormato("cliente.codigoPlanTarifario", clienteIn.getClienteDTO().getCodigoPlanTarifario())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12106");
			respuesta.setMensajseError("Formato codigo plan tarifario inválido = " + clienteIn.getClienteDTO().getCodigoPlanTarifario());
			listaRespuestaValidacion.add(respuesta);
		}

		if(!validarFormato("cliente.codigoPais", clienteIn.getClienteDTO().getCodigoPais())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12107");
			respuesta.setMensajseError("Formato codigo pais inválido = " + clienteIn.getClienteDTO().getCodigoPais());
			listaRespuestaValidacion.add(respuesta);
		}
		
/**************************FIN FORMATO******************************/		

		return listaRespuestaValidacion;		
	}	
	
	public static ArrayList ValidarAltaDeLinea(WsCunetaAltaDeLineaDTO altaLinea){
	
		ArrayList listaRespuestaValidacion = new ArrayList();
		if(!validarLongitud("altaLinea.codigoDeCliente", altaLinea.getCodigoDeCliente())){
			RetornoLineaDTO respuesta = new RetornoLineaDTO();
			respuesta.setCodError("12108");
			respuesta.setMensajseError("Largo codigo de cliente inválido = " + altaLinea.getCodigoDeCliente());
			listaRespuestaValidacion.add(respuesta);
		}

		if(!validarLongitud("altaLinea.codigoDeCuenta", altaLinea.getCodigoDeCuenta())){
			RetornoLineaDTO respuesta = new RetornoLineaDTO();
			respuesta.setCodError("12109");
			respuesta.setMensajseError("Largo codigo de cuenta inválido = " + altaLinea.getCodigoDeCuenta());
			listaRespuestaValidacion.add(respuesta);
		}

		if(!validarLongitud("altaLinea.codigoDealer", altaLinea.getLinea().getAntecedentesVenta().getCodigoDealer())){
			RetornoLineaDTO respuesta = new RetornoLineaDTO();
			if (altaLinea.getLinea().getAntecedentesVenta().getCodigoDealer().equals("")){
				respuesta.setCodError("12487");
				respuesta.setMensajseError("Codigo Dealer Debe ser minimo 0");
				listaRespuestaValidacion.add(respuesta);
			}else{			
				respuesta.setCodError("12110");
				respuesta.setMensajseError("Largo codigo Dealer inválido = " + altaLinea.getLinea().getAntecedentesVenta().getCodigoDealer());
				listaRespuestaValidacion.add(respuesta);
			}
		}

		if(!validarLongitud("altaLinea.codigoModalidadVenta", altaLinea.getLinea().getAntecedentesVenta().getCodigoModalidadVenta())){
			RetornoLineaDTO respuesta = new RetornoLineaDTO();
			respuesta.setCodError("12111");
			respuesta.setMensajseError("Largo codigo modalidad de venta inválido = " + altaLinea.getLinea().getAntecedentesVenta().getCodigoModalidadVenta());
			listaRespuestaValidacion.add(respuesta);
		}

		if(!validarLongitud("altaLinea.codigoTipoContrato", altaLinea.getLinea().getAntecedentesVenta().getCodigoTipoContrato())){
			RetornoLineaDTO respuesta = new RetornoLineaDTO();
			respuesta.setCodError("12112");
			respuesta.setMensajseError("Largo codigo tipo de contrato inválido = " + altaLinea.getLinea().getAntecedentesVenta().getCodigoTipoContrato());
			listaRespuestaValidacion.add(respuesta);
		}

		if(!validarLongitud("altaLinea.codigoVendedor", altaLinea.getLinea().getAntecedentesVenta().getCodigoVendedor())){
			RetornoLineaDTO respuesta = new RetornoLineaDTO();
			respuesta.setCodError("12113");
			respuesta.setMensajseError("Largo codigo vendedor inválido = " + altaLinea.getLinea().getAntecedentesVenta().getCodigoVendedor());
			listaRespuestaValidacion.add(respuesta);
		}

		if(!validarLongitud("altaLinea.cuotas", altaLinea.getLinea().getAntecedentesVenta().getCuotas())){
			RetornoLineaDTO respuesta = new RetornoLineaDTO();
			respuesta.setCodError("12114");
			respuesta.setMensajseError("Largo cuotas inválido = " + altaLinea.getLinea().getAntecedentesVenta().getCuotas());
			listaRespuestaValidacion.add(respuesta);
		}

		if(!validarLongitud("altaLinea.nomUsuarioOra", altaLinea.getNomUsuarioOra())){
			RetornoLineaDTO respuesta = new RetornoLineaDTO();
			respuesta.setCodError("12115");
			respuesta.setMensajseError("Largo usuario inválido = " + altaLinea.getNomUsuarioOra());
			listaRespuestaValidacion.add(respuesta);
		}

		if(!validarLongitud("altaLinea.identificadorTransaccion", altaLinea.getIdentificadorTransaccion())){
			RetornoLineaDTO respuesta = new RetornoLineaDTO();
			respuesta.setCodError("12310");
			respuesta.setMensajseError("Largo identificador Transaccion inválido = " + altaLinea.getIdentificadorTransaccion());
			listaRespuestaValidacion.add(respuesta);
		}
		
		for(int i=0;i<altaLinea.getLinea().getLineas().length;i++){


			if(!validarLongitud("altaLinea.codigoOperador", altaLinea.getLinea().getLineas()[i].getCodigoOperador())){
				RetornoLineaDTO respuesta = new RetornoLineaDTO();
				respuesta.setCodError("12116");
				respuesta.setMensajseError("Largo codigo operador inválido = " + altaLinea.getLinea().getLineas()[i].getCodigoOperador());
				respuesta.setNumLinea((String.valueOf(i+1)));
				listaRespuestaValidacion.add(respuesta);
			}

			if(!validarLongitud("altaLinea.planTarifario", altaLinea.getLinea().getLineas()[i].getDatosPlanTerifario().getPlanTarifario())){
				RetornoLineaDTO respuesta = new RetornoLineaDTO();
				respuesta.setCodError("12117");
				respuesta.setMensajseError("Largo plan tarifario inválido = " + altaLinea.getLinea().getLineas()[i].getDatosPlanTerifario().getPlanTarifario());
				respuesta.setNumLinea((String.valueOf(i+1)));
				listaRespuestaValidacion.add(respuesta);
			}

			if(!validarLongitud("altaLinea.ingresosBrutosAnuales", altaLinea.getLinea().getLineas()[i].getUsuarioLinea().getIngresosBrutosAnuales())){
				RetornoLineaDTO respuesta = new RetornoLineaDTO();
				respuesta.setCodError("12118");
				respuesta.setMensajseError("Largo ingresos brutos anuales inválido = " + altaLinea.getLinea().getLineas()[i].getUsuarioLinea().getIngresosBrutosAnuales());
				respuesta.setNumLinea((String.valueOf(i+1)));
				listaRespuestaValidacion.add(respuesta);
			}

			if(!validarLongitud("altaLinea.nombreEmpresa", altaLinea.getLinea().getLineas()[i].getUsuarioLinea().getNomEmpresa())){
				RetornoLineaDTO respuesta = new RetornoLineaDTO();
				respuesta.setCodError("12119");
				respuesta.setMensajseError("Largo nombre empresa inválido = " + altaLinea.getLinea().getLineas()[i].getUsuarioLinea().getNomEmpresa());
				respuesta.setNumLinea((String.valueOf(i+1)));
				listaRespuestaValidacion.add(respuesta);
			}

			if(!validarLongitud("altaLinea.ocupacion", altaLinea.getLinea().getLineas()[i].getUsuarioLinea().getOcupacion())){
				RetornoLineaDTO respuesta = new RetornoLineaDTO();
				respuesta.setCodError("12120");
				respuesta.setMensajseError("Largo ocupacion inválido = " + altaLinea.getLinea().getLineas()[i].getUsuarioLinea().getOcupacion());
				respuesta.setNumLinea((String.valueOf(i+1)));
				listaRespuestaValidacion.add(respuesta);
			}
			
			
			
			if(!validarLongitud("altaLinea.usu.apellido1", altaLinea.getLinea().getLineas()[i].getUsuarioLinea().getPrimerApellido())){
				RetornoLineaDTO respuesta = new RetornoLineaDTO();
				respuesta.setCodError("22120");
				respuesta.setMensajseError("Largo PrimerApellido inválido = " + altaLinea.getLinea().getLineas()[i].getUsuarioLinea().getPrimerApellido());
				respuesta.setNumLinea((String.valueOf(i+1)));
				listaRespuestaValidacion.add(respuesta);
			}
			
			if(!validarLongitud("altaLinea.usu.nombre", altaLinea.getLinea().getLineas()[i].getUsuarioLinea().getNombre() )){
				RetornoLineaDTO respuesta = new RetornoLineaDTO();
				respuesta.setCodError("21120");
				respuesta.setMensajseError("Largo Nombre usuario inválido = " + altaLinea.getLinea().getLineas()[i].getUsuarioLinea().getNombre());
				respuesta.setNumLinea((String.valueOf(i+1)));
				listaRespuestaValidacion.add(respuesta);
			}
			
			

			if(!validarLongitud("altaLinea.celda", altaLinea.getLinea().getLineas()[i].getHomeLinea().getCelda())){
				RetornoLineaDTO respuesta = new RetornoLineaDTO();
				respuesta.setCodError("12121");
				respuesta.setMensajseError("Largo celda inválido = " + altaLinea.getLinea().getLineas()[i].getHomeLinea().getCelda());
				respuesta.setNumLinea((String.valueOf(i+1)));
				listaRespuestaValidacion.add(respuesta);
			}

			if(!validarLongitud("altaLinea.codigCentral", altaLinea.getLinea().getLineas()[i].getHomeLinea().getCodigCentral())){
				RetornoLineaDTO respuesta = new RetornoLineaDTO();
				respuesta.setCodError("12122");
				respuesta.setMensajseError("Largo codigo central inválido = " + altaLinea.getLinea().getLineas()[i].getHomeLinea().getCodigCentral());
				respuesta.setNumLinea((String.valueOf(i+1)));
				listaRespuestaValidacion.add(respuesta);
			}

			if(!validarLongitud("altaLinea.simcard.codigoReserva", altaLinea.getLinea().getAntecedentesVenta().getCodigoReserva())){
				RetornoLineaDTO respuesta = new RetornoLineaDTO();
				respuesta.setCodError("12123");
				respuesta.setMensajseError("Largo codigo reserva inválido = " + altaLinea.getLinea().getAntecedentesVenta().getCodigoReserva());
				respuesta.setNumLinea((String.valueOf(i+1)));
				listaRespuestaValidacion.add(respuesta);
			}

			if(!validarLongitud("altaLinea.numeroSerie", altaLinea.getLinea().getLineas()[i].getSimcard().getNumeroSerie())){
				RetornoLineaDTO respuesta = new RetornoLineaDTO();
				respuesta.setCodError("12124");
				respuesta.setMensajseError("Largo numero de serie inválido = " + altaLinea.getLinea().getLineas()[i].getSimcard().getNumeroSerie());
				respuesta.setNumLinea((String.valueOf(i+1)));
				listaRespuestaValidacion.add(respuesta);
			}

			

			if(!validarLongitud("altaLinea.terminal.min", altaLinea.getLinea().getLineas()[i].getTerminal().getMin())){
				RetornoLineaDTO respuesta = new RetornoLineaDTO();
				respuesta.setCodError("12126");
				respuesta.setMensajseError("Largo Min inválido = " + altaLinea.getLinea().getLineas()[i].getTerminal().getMin());
				respuesta.setNumLinea((String.valueOf(i+1)));
				listaRespuestaValidacion.add(respuesta);
			}

			if(!validarLongitud("altaLinea.terminal.numImei", altaLinea.getLinea().getLineas()[i].getTerminal().getNumImei())){
				RetornoLineaDTO respuesta = new RetornoLineaDTO();
				respuesta.setCodError("12127");
				respuesta.setMensajseError("Largo numero IMEI inválido = " + altaLinea.getLinea().getLineas()[i].getTerminal().getNumImei());
				respuesta.setNumLinea((String.valueOf(i+1)));
				listaRespuestaValidacion.add(respuesta);
			}
		}

		
/**************************INICIO FORMATO******************************/		
		if(!validarFormato("altaLinea.codigoDeCliente", altaLinea.getCodigoDeCliente())){
			RetornoLineaDTO respuesta = new RetornoLineaDTO();
			respuesta.setCodError("12128");
			respuesta.setMensajseError("Formato codigo de cliente inválido = " + altaLinea.getCodigoDeCliente());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("altaLinea.codigoDeCuenta", altaLinea.getCodigoDeCuenta())){
			RetornoLineaDTO respuesta = new RetornoLineaDTO();
			respuesta.setCodError("12129");
			respuesta.setMensajseError("Formato codigo de cuenta inválido = " + altaLinea.getCodigoDeCuenta());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("altaLinea.codigoDealer", altaLinea.getLinea().getAntecedentesVenta().getCodigoDealer())){
			if (altaLinea.getLinea().getAntecedentesVenta().getCodigoDealer()!="-1"){
				RetornoLineaDTO respuesta = new RetornoLineaDTO();
				respuesta.setCodError("12130");
				respuesta.setMensajseError("Formato codigo Dealer inválido = " + altaLinea.getLinea().getAntecedentesVenta().getCodigoDealer());
				listaRespuestaValidacion.add(respuesta);
			}
		}

		if(!validarFormato("altaLinea.codigoModalidadVenta", altaLinea.getLinea().getAntecedentesVenta().getCodigoModalidadVenta())){
			RetornoLineaDTO respuesta = new RetornoLineaDTO();
			respuesta.setCodError("12131");
			respuesta.setMensajseError("Formato codigo modalidad de venta inválido = " + altaLinea.getLinea().getAntecedentesVenta().getCodigoModalidadVenta());
			listaRespuestaValidacion.add(respuesta);
		}

		if(!validarFormato("altaLinea.codigoTipoContrato", altaLinea.getLinea().getAntecedentesVenta().getCodigoTipoContrato())){
			RetornoLineaDTO respuesta = new RetornoLineaDTO();
			respuesta.setCodError("12132");
			respuesta.setMensajseError("Formato codigo tipo de contrato inválido = " + altaLinea.getLinea().getAntecedentesVenta().getCodigoTipoContrato());
			listaRespuestaValidacion.add(respuesta);
		}

		if(!validarFormato("altaLinea.codigoVendedor", altaLinea.getLinea().getAntecedentesVenta().getCodigoVendedor())){
			RetornoLineaDTO respuesta = new RetornoLineaDTO();
			respuesta.setCodError("12133");
			respuesta.setMensajseError("Formato codigo vendedor inválido = " + altaLinea.getLinea().getAntecedentesVenta().getCodigoVendedor());
			listaRespuestaValidacion.add(respuesta);
		}

		if(!validarFormato("altaLinea.cuotas", altaLinea.getLinea().getAntecedentesVenta().getCuotas())){
			RetornoLineaDTO respuesta = new RetornoLineaDTO();
			respuesta.setCodError("12134");
			respuesta.setMensajseError("Formato cuotas inválido = " + altaLinea.getLinea().getAntecedentesVenta().getCuotas());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("altaLinea.nombreUsuarioOra", altaLinea.getNomUsuarioOra())){
			RetornoLineaDTO respuesta = new RetornoLineaDTO();
			respuesta.setCodError("12135");
			respuesta.setMensajseError("Formato nombre usuario inválido = " + altaLinea.getNomUsuarioOra());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("altaLinea.identificadorTransaccion", altaLinea.getIdentificadorTransaccion())){
			RetornoLineaDTO respuesta = new RetornoLineaDTO();
			respuesta.setCodError("12311");
			respuesta.setMensajseError("Formato identificador Transaccion inválido = " + altaLinea.getIdentificadorTransaccion());
			listaRespuestaValidacion.add(respuesta);
		}
		
		for(int i=0;i<altaLinea.getLinea().getLineas().length;i++){


			if(!validarFormato("altaLinea.codigoOperador", altaLinea.getLinea().getLineas()[i].getCodigoOperador())){
				RetornoLineaDTO respuesta = new RetornoLineaDTO();
				respuesta.setCodError("12136");
				respuesta.setMensajseError("Formato codigo operador inválido = " + altaLinea.getLinea().getLineas()[i].getCodigoOperador());
				respuesta.setNumLinea((String.valueOf(i+1)));
				listaRespuestaValidacion.add(respuesta);
			}

			if(!validarFormato("altaLinea.planTarifario", altaLinea.getLinea().getLineas()[i].getDatosPlanTerifario().getPlanTarifario())){
				RetornoLineaDTO respuesta = new RetornoLineaDTO();
				respuesta.setCodError("12137");
				respuesta.setMensajseError("Formato plan tarifario inválido = " + altaLinea.getLinea().getLineas()[i].getDatosPlanTerifario().getPlanTarifario());
				respuesta.setNumLinea((String.valueOf(i+1)));
				listaRespuestaValidacion.add(respuesta);
			}

			if(!validarFormatoNumerico(altaLinea.getLinea().getLineas()[i].getUsuarioLinea().getIngresosBrutosAnuales())){
				RetornoLineaDTO respuesta = new RetornoLineaDTO();
				respuesta.setCodError("12138");
				respuesta.setMensajseError("Formato ingresos brutos anuales inválido = " + altaLinea.getLinea().getLineas()[i].getUsuarioLinea().getIngresosBrutosAnuales());
				respuesta.setNumLinea((String.valueOf(i+1)));
				listaRespuestaValidacion.add(respuesta);
			}

			if(!validarFormato("altaLinea.nombreEmpresa", altaLinea.getLinea().getLineas()[i].getUsuarioLinea().getNomEmpresa())){
				RetornoLineaDTO respuesta = new RetornoLineaDTO();
				respuesta.setCodError("12139");
				respuesta.setMensajseError("Formato nombre empresa inválido = " + altaLinea.getLinea().getLineas()[i].getUsuarioLinea().getNomEmpresa());
				respuesta.setNumLinea((String.valueOf(i+1)));
				listaRespuestaValidacion.add(respuesta);
			}

			if(!validarFormato("altaLinea.ocupacion", altaLinea.getLinea().getLineas()[i].getUsuarioLinea().getOcupacion())){
				RetornoLineaDTO respuesta = new RetornoLineaDTO();
				respuesta.setCodError("12140");
				respuesta.setMensajseError("Formato ocupacion inválido = " + altaLinea.getLinea().getLineas()[i].getUsuarioLinea().getOcupacion());
				respuesta.setNumLinea((String.valueOf(i+1)));
				listaRespuestaValidacion.add(respuesta);
			}

			if(!validarFormato("altaLinea.celda", altaLinea.getLinea().getLineas()[i].getHomeLinea().getCelda())){
				RetornoLineaDTO respuesta = new RetornoLineaDTO();
				respuesta.setCodError("12141");
				respuesta.setMensajseError("Formato celda inválido = " + altaLinea.getLinea().getLineas()[i].getHomeLinea().getCelda());
				respuesta.setNumLinea((String.valueOf(i+1)));
				listaRespuestaValidacion.add(respuesta);
			}

			if(!validarFormato("altaLinea.codigCentral", altaLinea.getLinea().getLineas()[i].getHomeLinea().getCodigCentral())){
				RetornoLineaDTO respuesta = new RetornoLineaDTO();
				respuesta.setCodError("12142");
				respuesta.setMensajseError("Formato codigo central inválido = " + altaLinea.getLinea().getLineas()[i].getHomeLinea().getCodigCentral());
				respuesta.setNumLinea((String.valueOf(i+1)));
				listaRespuestaValidacion.add(respuesta);
			}

			if(!validarFormato("altaLinea.simcard.codigoReserva", altaLinea.getLinea().getAntecedentesVenta().getCodigoReserva())){
				RetornoLineaDTO respuesta = new RetornoLineaDTO();
				respuesta.setCodError("12143");
				respuesta.setMensajseError("Formato codigo reserva inválido = " + altaLinea.getLinea().getAntecedentesVenta().getCodigoReserva());
				respuesta.setNumLinea((String.valueOf(i+1)));
				listaRespuestaValidacion.add(respuesta);
			}

			if(!validarFormato("altaLinea.numeroSerie", altaLinea.getLinea().getLineas()[i].getSimcard().getNumeroSerie())){
				RetornoLineaDTO respuesta = new RetornoLineaDTO();
				respuesta.setCodError("12144");
				respuesta.setMensajseError("Formato numero de serie inválido = " + altaLinea.getLinea().getLineas()[i].getSimcard().getNumeroSerie());
				respuesta.setNumLinea((String.valueOf(i+1)));
				listaRespuestaValidacion.add(respuesta);
			}


			if(!validarFormato("altaLinea.terminal.min", altaLinea.getLinea().getLineas()[i].getTerminal().getMin())){
				RetornoLineaDTO respuesta = new RetornoLineaDTO();
				respuesta.setCodError("12146");
				respuesta.setMensajseError("Formato Min inválido = " + altaLinea.getLinea().getLineas()[i].getTerminal().getMin());
				respuesta.setNumLinea((String.valueOf(i+1)));
				listaRespuestaValidacion.add(respuesta);
			}

			if(!validarFormato("altaLinea.terminal.numImei", altaLinea.getLinea().getLineas()[i].getTerminal().getNumImei())){
				RetornoLineaDTO respuesta = new RetornoLineaDTO();
				respuesta.setCodError("12147");
				respuesta.setMensajseError("Formato numero IMEI inválido = " + altaLinea.getLinea().getLineas()[i].getTerminal().getNumImei());
				respuesta.setNumLinea((String.valueOf(i+1)));
				listaRespuestaValidacion.add(respuesta);
			}
		}
/**************************FIN FORMATO******************************/
		
		return listaRespuestaValidacion;
	}
	
	
	
	
	public static ArrayList ValidarAgregarDirecciones(WsDireccionInDTO[] direccionesIn){

		ArrayList listaRespuestaValidacion = new ArrayList(); 
		
		for(int i=0;i<direccionesIn.length;i++){
			
			if(!validarLongitud("direccion.codigoProvincia", direccionesIn[i].getCodigoProvincia())){
				RetornoDTO respuesta = new RetornoDTO();
				respuesta.setCodError("12148");
				respuesta.setMensajseError("Largo codigo provincia inválido = " + direccionesIn[i].getCodigoProvincia());
				listaRespuestaValidacion.add(respuesta);
			}
			
			if(!validarLongitud("direccion.codigoRegion", direccionesIn[i].getCodigoRegion())){
				RetornoDTO respuesta = new RetornoDTO();
				respuesta.setCodError("12149");
				respuesta.setMensajseError("Largo codigo region inválido = " + direccionesIn[i].getCodigoRegion());
				listaRespuestaValidacion.add(respuesta);
			}
			
			if(!validarLongitud("direccion.codigoCanton", direccionesIn[i].getCodigoCiudad())){
				RetornoDTO respuesta = new RetornoDTO();
				respuesta.setCodError("12150");
				respuesta.setMensajseError("Largo codigo canton inválido = " + direccionesIn[i].getCodigoCiudad());
				listaRespuestaValidacion.add(respuesta);
			}
			
			if(!validarLongitud("direccion.codigoComuna", direccionesIn[i].getCodigoComuna())){
				RetornoDTO respuesta = new RetornoDTO();
				respuesta.setCodError("12151");
				respuesta.setMensajseError("Largo codigo comuna inválido = " + direccionesIn[i].getCodigoComuna());
				listaRespuestaValidacion.add(respuesta);
			}
			
			if(!validarLongitud("direccion.nombreCalle", direccionesIn[i].getNombreCalle())){
				RetornoDTO respuesta = new RetornoDTO();
				respuesta.setCodError("12152");
				respuesta.setMensajseError("Largo nombre calle inválido = " + direccionesIn[i].getNombreCalle());
				listaRespuestaValidacion.add(respuesta);
			}
			
			if(!validarLongitud("direccion.numeroCalle", direccionesIn[i].getNumeroCalle())){
				RetornoDTO respuesta = new RetornoDTO();
				respuesta.setCodError("12153");
				respuesta.setMensajseError("Largo numero de calle inválido = " + direccionesIn[i].getNumeroCalle());
				listaRespuestaValidacion.add(respuesta);
			}
			
			if(!validarLongitud("direccion.numeroPiso", direccionesIn[i].getNumeroPiso())){
				RetornoDTO respuesta = new RetornoDTO();
				respuesta.setCodError("12154");
				respuesta.setMensajseError("Largo numero de piso inválido = " + direccionesIn[i].getNumeroPiso());
				listaRespuestaValidacion.add(respuesta);
			}
			
			if(!validarLongitud("direccion.numeroCasilla", direccionesIn[i].getNumeroCasilla())){
				RetornoDTO respuesta = new RetornoDTO();
				respuesta.setCodError("12155");
				respuesta.setMensajseError("Largo numero de casilla inválido = " + direccionesIn[i].getNumeroCasilla());
				listaRespuestaValidacion.add(respuesta);
			}
			
			if(!validarLongitud("direccion.codigoPueblo", direccionesIn[i].getCodigoPueblo())){
				RetornoDTO respuesta = new RetornoDTO();
				respuesta.setCodError("12156");
				respuesta.setMensajseError("Largo codigo pueblo inválido = " + direccionesIn[i].getCodigoPueblo());
				listaRespuestaValidacion.add(respuesta);
			}
			
			if(!validarLongitud("direccion.observacionDireccion", direccionesIn[i].getObservacionDireccion())){
				RetornoDTO respuesta = new RetornoDTO();
				respuesta.setCodError("12157");
				respuesta.setMensajseError("Largo observacion direccion inválido = " + direccionesIn[i].getObservacionDireccion());
				listaRespuestaValidacion.add(respuesta);
			}
			
			if(!validarLongitud("direccion.descripcionDireccion1", direccionesIn[i].getDescripcionDireccion1())){
				RetornoDTO respuesta = new RetornoDTO();
				respuesta.setCodError("12158");
				respuesta.setMensajseError("Largo descripcion direccion 1 inválido = " + direccionesIn[i].getDescripcionDireccion1());
				listaRespuestaValidacion.add(respuesta);
			}
			
			if(!validarLongitud("direccion.descripcionDireccion2", direccionesIn[i].getDescripcionDireccion2())){
				RetornoDTO respuesta = new RetornoDTO();
				respuesta.setCodError("12159");
				respuesta.setMensajseError("Largo descripcion direccion 2 inválido = " + direccionesIn[i].getDescripcionDireccion2());
				listaRespuestaValidacion.add(respuesta);
			}
			
			if(!validarLongitud("direccion.ZIP", direccionesIn[i].getZIP())){
				RetornoDTO respuesta = new RetornoDTO();
				respuesta.setCodError("12160");
				respuesta.setMensajseError("Largo ZIP inválido = " + direccionesIn[i].getZIP());
				listaRespuestaValidacion.add(respuesta);
			}
			
			if(!validarLongitud("direccion.codigoEstado", direccionesIn[i].getCodigoEstado())){
				RetornoDTO respuesta = new RetornoDTO();
				respuesta.setCodError("12161");
				respuesta.setMensajseError("Largo codigo estado inválido = " + direccionesIn[i].getCodigoEstado());
				listaRespuestaValidacion.add(respuesta);
			}
			//INICIO CSR-11002
			if(!validarLongitud("direccion.tipoCalle", direccionesIn[i].getTipoCalle())){
				RetornoDTO respuesta = new RetornoDTO();
				respuesta.setCodError("12162");
				respuesta.setMensajseError("Largo codigo estado inválido = " + direccionesIn[i].getTipoCalle());
				listaRespuestaValidacion.add(respuesta);
			}
			//FIN CSR-11002
			/*if(!validarLongitud("direccion.tipoDireccion", String.valueOf(direccionesIn[i].getTipoDireccion()))){
				RetornoDTO respuesta = new RetornoDTO();
				respuesta.setCodError("12162");
				respuesta.setMensajseError("Largo tipo de direccion inválido = " + direccionesIn[i].getTipoDireccion());
				listaRespuestaValidacion.add(respuesta);
			}*/
			
/************************INICIO FORMATO*****************/
			
			if(!validarFormato("direccion.codigoProvincia", direccionesIn[i].getCodigoProvincia())){
				RetornoDTO respuesta = new RetornoDTO();
				respuesta.setCodError("12163");
				respuesta.setMensajseError("Formato codigo provincia inválido = " + direccionesIn[i].getCodigoProvincia());
				listaRespuestaValidacion.add(respuesta);
			}
			
			if(!validarFormato("direccion.codigoRegion", direccionesIn[i].getCodigoRegion())){
				RetornoDTO respuesta = new RetornoDTO();
				respuesta.setCodError("12164");
				respuesta.setMensajseError("Formato codigo region inválido = " + direccionesIn[i].getCodigoRegion());
				listaRespuestaValidacion.add(respuesta);
			}
			
			if(!validarFormato("direccion.codigoCanton", direccionesIn[i].getCodigoCiudad())){
				RetornoDTO respuesta = new RetornoDTO();
				respuesta.setCodError("12165");
				respuesta.setMensajseError("Formato codigo canton inválido = " + direccionesIn[i].getCodigoCiudad());
				listaRespuestaValidacion.add(respuesta);
			}
			
			if(!validarFormato("direccion.codigoComuna", direccionesIn[i].getCodigoComuna())){
				RetornoDTO respuesta = new RetornoDTO();
				respuesta.setCodError("12166");
				respuesta.setMensajseError("Formato codigo comuna inválido = " + direccionesIn[i].getCodigoComuna());
				listaRespuestaValidacion.add(respuesta);
			}
			
			if(!validarFormato("direccion.nombreCalle", direccionesIn[i].getNombreCalle())){
				RetornoDTO respuesta = new RetornoDTO();
				respuesta.setCodError("12167");
				respuesta.setMensajseError("Formato nombre calle inválido = " + direccionesIn[i].getNombreCalle());
				listaRespuestaValidacion.add(respuesta);
			}
			
			if(!validarFormato("direccion.numeroCalle", direccionesIn[i].getNumeroCalle())){
				RetornoDTO respuesta = new RetornoDTO();
				respuesta.setCodError("12168");
				respuesta.setMensajseError("Formato numero de calle inválido = " + direccionesIn[i].getNumeroCalle());
				listaRespuestaValidacion.add(respuesta);
			}
			
			if(!validarFormato("direccion.numeroPiso", direccionesIn[i].getNumeroPiso())){
				RetornoDTO respuesta = new RetornoDTO();
				respuesta.setCodError("12169");
				respuesta.setMensajseError("Formato numero de piso inválido = " + direccionesIn[i].getNumeroPiso());
				listaRespuestaValidacion.add(respuesta);
			}
			
			if(!validarFormato("direccion.numeroCasilla", direccionesIn[i].getNumeroCasilla())){
				RetornoDTO respuesta = new RetornoDTO();
				respuesta.setCodError("12170");
				respuesta.setMensajseError("Formato numero de casilla inválido = " + direccionesIn[i].getNumeroCasilla());
				listaRespuestaValidacion.add(respuesta);
			}
			
			if(!validarFormato("direccion.codigoPueblo", direccionesIn[i].getCodigoPueblo())){
				RetornoDTO respuesta = new RetornoDTO();
				respuesta.setCodError("12171");
				respuesta.setMensajseError("Formato codigo pueblo inválido = " + direccionesIn[i].getCodigoPueblo());
				listaRespuestaValidacion.add(respuesta);
			}
			
			if(!validarFormato("direccion.observacionDireccion", direccionesIn[i].getObservacionDireccion())){
				RetornoDTO respuesta = new RetornoDTO();
				respuesta.setCodError("12172");
				respuesta.setMensajseError("Formato observacion direccion inválido = " + direccionesIn[i].getObservacionDireccion());
				listaRespuestaValidacion.add(respuesta);
			}
			
			if(!validarFormato("direccion.descripcionDireccion1", direccionesIn[i].getDescripcionDireccion1())){
				RetornoDTO respuesta = new RetornoDTO();
				respuesta.setCodError("12173");
				respuesta.setMensajseError("Formato descripcion direccion 1 inválido = " + direccionesIn[i].getDescripcionDireccion1());
				listaRespuestaValidacion.add(respuesta);
			}
			
			if(!validarFormato("direccion.descripcionDireccion2", direccionesIn[i].getDescripcionDireccion2())){
				RetornoDTO respuesta = new RetornoDTO();
				respuesta.setCodError("12174");
				respuesta.setMensajseError("Formato descripcion direccion 2 inválido = " + direccionesIn[i].getDescripcionDireccion2());
				listaRespuestaValidacion.add(respuesta);
			}
			
			
			if(!validarFormato("direccion.codigoEstado", direccionesIn[i].getCodigoEstado())){
				RetornoDTO respuesta = new RetornoDTO();
				respuesta.setCodError("12176");
				respuesta.setMensajseError("Formato codigo estado inválido = " + direccionesIn[i].getCodigoEstado());
				listaRespuestaValidacion.add(respuesta);
			}
			
			//INICIO CSR-11002
			if(!validarFormato("direccion.tipoCalle", direccionesIn[i].getTipoCalle())){
				RetornoDTO respuesta = new RetornoDTO();
				respuesta.setCodError("12177");
				respuesta.setMensajseError("Formato codigo estado inválido = " + direccionesIn[i].getTipoCalle());
				listaRespuestaValidacion.add(respuesta);
			}			
			//FIN CSR-11002
/*********************FIN FORMATO***********************/
		}
				
		return listaRespuestaValidacion;		
	}
	
	public static ArrayList ValidarAgregarDireccion(WsDireccionInDTO direccionIn){

		ArrayList listaRespuestaValidacion = new ArrayList(); 

		if(!validarLongitud("direccion.codigoProvincia", direccionIn.getCodigoProvincia())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12178");
			respuesta.setMensajseError("Largo codigo provincia inválido = " + direccionIn.getCodigoProvincia());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("direccion.codigoRegion", direccionIn.getCodigoRegion())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12179");
			respuesta.setMensajseError("Largo codigo region inválido = " + direccionIn.getCodigoRegion());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("direccion.codigoCanton", direccionIn.getCodigoCiudad())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12180");
			respuesta.setMensajseError("Largo codigo canton inválido = " + direccionIn.getCodigoCiudad());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("direccion.codigoComuna", direccionIn.getCodigoComuna())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12181");
			respuesta.setMensajseError("Largo codigo comuna inválido = " + direccionIn.getCodigoComuna());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("direccion.nombreCalle", direccionIn.getNombreCalle())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12182");
			respuesta.setMensajseError("Largo nombre calle inválido = " + direccionIn.getNombreCalle());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("direccion.numeroCalle", direccionIn.getNumeroCalle())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12183");
			respuesta.setMensajseError("Largo numero de calle inválido = " + direccionIn.getNumeroCalle());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("direccion.numeroPiso", direccionIn.getNumeroPiso())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12184");
			respuesta.setMensajseError("Largo numero de piso inválido = " + direccionIn.getNumeroPiso());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("direccion.numeroCasilla", direccionIn.getNumeroCasilla())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12185");
			respuesta.setMensajseError("Largo numero de casilla inválido = " + direccionIn.getNumeroCasilla());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("direccion.codigoPueblo", direccionIn.getCodigoPueblo())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12186");
			respuesta.setMensajseError("Largo codigo pueblo inválido = " + direccionIn.getCodigoPueblo());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("direccion.observacionDireccion", direccionIn.getObservacionDireccion())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12187");
			respuesta.setMensajseError("Largo observacion direccion inválido = " + direccionIn.getObservacionDireccion());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("direccion.descripcionDireccion1", direccionIn.getDescripcionDireccion1())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12188");
			respuesta.setMensajseError("Largo descripcion direccion 1 inválido = " + direccionIn.getDescripcionDireccion1());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("direccion.descripcionDireccion2", direccionIn.getDescripcionDireccion2())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12189");
			respuesta.setMensajseError("Largo descripcion direccion 2 inválido = " + direccionIn.getDescripcionDireccion2());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("direccion.ZIP", direccionIn.getZIP())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12190");
			respuesta.setMensajseError("Largo ZIP inválido = " + direccionIn.getZIP());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("direccion.codigoEstado", direccionIn.getCodigoEstado())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12191");
			respuesta.setMensajseError("Largo codigo estado inválido = " + direccionIn.getCodigoEstado());
			listaRespuestaValidacion.add(respuesta);
		}
		
/*		if(!validarLongitud("direccion.tipoDireccion", String.valueOf(direccionIn.getTipoDireccion()))){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12192");
			respuesta.setMensajseError("Largo tipo de direccion inválido = " + direccionIn.getTipoDireccion());
			listaRespuestaValidacion.add(respuesta);
		}*/
		
/*********************INICIO FORMATO***********************/
		if(!validarFormato("direccion.codigoProvincia", direccionIn.getCodigoProvincia())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12193");
			respuesta.setMensajseError("Formato codigo provincia inválido = " + direccionIn.getCodigoProvincia());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("direccion.codigoRegion", direccionIn.getCodigoRegion())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12194");
			respuesta.setMensajseError("Formato codigo region inválido = " + direccionIn.getCodigoRegion());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("direccion.codigoCanton", direccionIn.getCodigoCiudad())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12195");
			respuesta.setMensajseError("Formato codigo canton inválido = " + direccionIn.getCodigoCiudad());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("direccion.codigoComuna", direccionIn.getCodigoComuna())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12196");
			respuesta.setMensajseError("Formato codigo comuna inválido = " + direccionIn.getCodigoComuna());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("direccion.nombreCalle", direccionIn.getNombreCalle())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12197");
			respuesta.setMensajseError("Formato nombre calle inválido = " + direccionIn.getNombreCalle());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("direccion.numeroCalle", direccionIn.getNumeroCalle())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12198");
			respuesta.setMensajseError("Formato numero de calle inválido = " + direccionIn.getNumeroCalle());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("direccion.numeroPiso", direccionIn.getNumeroPiso())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12199");
			respuesta.setMensajseError("Formato numero de piso inválido = " + direccionIn.getNumeroPiso());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("direccion.numeroCasilla", direccionIn.getNumeroCasilla())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12200");
			respuesta.setMensajseError("Formato numero de casilla inválido = " + direccionIn.getNumeroCasilla());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("direccion.codigoPueblo", direccionIn.getCodigoPueblo())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12201");
			respuesta.setMensajseError("Formato codigo pueblo inválido = " + direccionIn.getCodigoPueblo());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("direccion.observacionDireccion", direccionIn.getObservacionDireccion())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12202");
			respuesta.setMensajseError("Formato observacion direccion inválido = " + direccionIn.getObservacionDireccion());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("direccion.descripcionDireccion1", direccionIn.getDescripcionDireccion1())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12203");
			respuesta.setMensajseError("Formato descripcion direccion 1 inválido = " + direccionIn.getDescripcionDireccion1());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("direccion.descripcionDireccion2", direccionIn.getDescripcionDireccion2())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12204");
			respuesta.setMensajseError("Formato descripcion direccion 2 inválido = " + direccionIn.getDescripcionDireccion2());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("direccion.codigoEstado", direccionIn.getCodigoEstado())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12206");
			respuesta.setMensajseError("Formato codigo estado inválido = " + direccionIn.getCodigoEstado());
			listaRespuestaValidacion.add(respuesta);
		}
		
		/*if(!validarFormato("direccion.tipoDireccion", String.valueOf(direccionIn.getTipoDireccion()))){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12207");
			respuesta.setMensajseError("Formato tipo de direccion inválido = " + direccionIn.getTipoDireccion());
			listaRespuestaValidacion.add(respuesta);
		}*/
		
		
		/*********************FIN FORMATO***********************/		
		return listaRespuestaValidacion;		
	}
	
	
	public static ArrayList ValidarAgregaEliminaSS(WsAgregaEliminaSSInDTO[] sSuplemen, Long NumeroCelular, String NomUsuario){

		ArrayList listaRespuestaValidacion = new ArrayList(); 
		if (sSuplemen != null){
			for(int i=0;i<sSuplemen.length;i++){

				if(!validarLongitud("agregaEliminaSS.codigoConcepto", sSuplemen[i].getCodigoConcepto())){
					RetornoDTO respuesta = new RetornoDTO();
					respuesta.setCodError("12208");
					respuesta.setMensajseError("Largo codigo concepto inválido = " + sSuplemen[i].getCodigoConcepto());
					listaRespuestaValidacion.add(respuesta);
				}

				if(!validarLongitud("agregaEliminaSS.codigoNivel", sSuplemen[i].getCodigoNivel())){
					RetornoDTO respuesta = new RetornoDTO();
					respuesta.setCodError("12209");
					respuesta.setMensajseError("Largo codigo nivel inválido = " + sSuplemen[i].getCodigoNivel());
					listaRespuestaValidacion.add(respuesta);
				}

				if(!validarLongitud("agregaEliminaSS.codigoServicio", sSuplemen[i].getCodigoServicio())){
					RetornoDTO respuesta = new RetornoDTO();
					respuesta.setCodError("12210");
					respuesta.setMensajseError("Largo codigo servicio inválido = " + sSuplemen[i].getCodigoServicio());
					listaRespuestaValidacion.add(respuesta);
				}

				if(!validarLongitud("agregaEliminaSS.codigoServSupl", sSuplemen[i].getCodigoServSupl())){
					RetornoDTO respuesta = new RetornoDTO();
					respuesta.setCodError("12211");
					respuesta.setMensajseError("Largo codigo servicio suplementario inválido = " + sSuplemen[i].getCodigoServSupl());
					listaRespuestaValidacion.add(respuesta);
				}

				if(!validarLongitud("agregaEliminaSS.descripcionServicioS", sSuplemen[i].getDescripcionServicioS())){
					RetornoDTO respuesta = new RetornoDTO();
					respuesta.setCodError("12212");
					respuesta.setMensajseError("Largo descripcion servicio inválido = " + sSuplemen[i].getDescripcionServicioS());
					listaRespuestaValidacion.add(respuesta);
				}

				if(!validarLongitud("agregaEliminaSS.duracion", sSuplemen[i].getDuracion())){
					RetornoDTO respuesta = new RetornoDTO();
					respuesta.setCodError("12213");
					respuesta.setMensajseError("Largo duracion inválido = " + sSuplemen[i].getDuracion());
					listaRespuestaValidacion.add(respuesta);
				}		
			}


			if(!validarLongitud("agregaEliminaSS.numeroCelular", String.valueOf(NumeroCelular))){
				RetornoDTO respuesta = new RetornoDTO();
				respuesta.setCodError("12214");
				respuesta.setMensajseError("Largo numero de celular inválido = " + NumeroCelular);
				listaRespuestaValidacion.add(respuesta);
			}	

			if(!validarLongitud("agregaEliminaSS.nomUsuario", NomUsuario)){
				RetornoDTO respuesta = new RetornoDTO();
				respuesta.setCodError("12215");
				respuesta.setMensajseError("Largo nombre usuario inválido = " + NomUsuario);
				listaRespuestaValidacion.add(respuesta);
			}
		}
		
		/*******************INICIO FORMATO*****************/
		if (sSuplemen != null){
			for(int i=0;i<sSuplemen.length;i++){

				if(!validarFormato("agregaEliminaSS.codigoConcepto", sSuplemen[i].getCodigoConcepto())){
					RetornoDTO respuesta = new RetornoDTO();
					respuesta.setCodError("12216");
					respuesta.setMensajseError("Formato codigo concepto inválido = " + sSuplemen[i].getCodigoConcepto());
					listaRespuestaValidacion.add(respuesta);
				}

				if(!validarFormato("agregaEliminaSS.codigoNivel", sSuplemen[i].getCodigoNivel())){
					RetornoDTO respuesta = new RetornoDTO();
					respuesta.setCodError("12217");
					respuesta.setMensajseError("Formato codigo nivel inválido = " + sSuplemen[i].getCodigoNivel());
					listaRespuestaValidacion.add(respuesta);
				}

				if(!validarFormato("agregaEliminaSS.codigoServicio", sSuplemen[i].getCodigoServicio())){
					RetornoDTO respuesta = new RetornoDTO();
					respuesta.setCodError("12218");
					respuesta.setMensajseError("Formato codigo servicio inválido = " + sSuplemen[i].getCodigoServicio());
					listaRespuestaValidacion.add(respuesta);
				}

				if(!validarFormato("agregaEliminaSS.codigoServSupl", sSuplemen[i].getCodigoServSupl())){
					RetornoDTO respuesta = new RetornoDTO();
					respuesta.setCodError("12219");
					respuesta.setMensajseError("Formato codigo servicio suplementario inválido = " + sSuplemen[i].getCodigoServSupl());
					listaRespuestaValidacion.add(respuesta);
				}

				if(!validarFormato("agregaEliminaSS.descripcionServicioS", sSuplemen[i].getDescripcionServicioS())){
					RetornoDTO respuesta = new RetornoDTO();
					respuesta.setCodError("12220");
					respuesta.setMensajseError("Formato descripcion servicio inválido = " + sSuplemen[i].getDescripcionServicioS());
					listaRespuestaValidacion.add(respuesta);
				}

				if(!validarFormato("agregaEliminaSS.duracion", sSuplemen[i].getDuracion())){
					RetornoDTO respuesta = new RetornoDTO();
					respuesta.setCodError("12221");
					respuesta.setMensajseError("Formato duracion inválido = " + sSuplemen[i].getDuracion());
					listaRespuestaValidacion.add(respuesta);
				}		
			}


			if(!validarFormato("agregaEliminaSS.numeroCelular", String.valueOf(NumeroCelular))){
				RetornoDTO respuesta = new RetornoDTO();
				respuesta.setCodError("12222");
				respuesta.setMensajseError("Formato numero de celular inválido = " + NumeroCelular);
				listaRespuestaValidacion.add(respuesta);
			}	

			if(!validarFormato("agregaEliminaSS.nomUsuario", NomUsuario)){
				RetornoDTO respuesta = new RetornoDTO();
				respuesta.setCodError("12223");
				respuesta.setMensajseError("Formato nombre usuario inválido = " + NomUsuario);
				listaRespuestaValidacion.add(respuesta);
			}
		}
		/*******************FIN FORMATO*****************/
		
		return listaRespuestaValidacion;
	}	
	
	
	public ArrayList ValidarProcesoDeFacturacion(WsFacturacionVentaInDTO WsFacturacionVentaIn){
		
		ArrayList listaRespuestaValidacion = new ArrayList(); 
		
		if(!validarLongitud("procesoDeFacturacion.nomUsuario", WsFacturacionVentaIn.getNomUsuario())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12224");
			respuesta.setMensajseError("Largo Nombre Usuario inválido = " + WsFacturacionVentaIn.getNomUsuario());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("procesoDeFacturacion.numVenta", WsFacturacionVentaIn.getNumVenta())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12225");
			respuesta.setMensajseError("Largo Numero de Venta inválido = " + WsFacturacionVentaIn.getNumVenta());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("procesoDeFacturacion.obsFactVenta", WsFacturacionVentaIn.getObsFactVenta())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12226");
			respuesta.setMensajseError("Largo Observacion Factura inválido = " + WsFacturacionVentaIn.getObsFactVenta());
			listaRespuestaValidacion.add(respuesta);
		}
		
		for(int i=0;i<WsFacturacionVentaIn.getFacturacionLinea().length;i++){
			
			if(!validarLongitud("procesoDeFacturacion.mntoDscSimcard", String.valueOf(WsFacturacionVentaIn.getFacturacionLinea()[i].getMntoDscSimcard()))){
				RetornoDTO respuesta = new RetornoDTO();
				respuesta.setCodError("12229");
				respuesta.setMensajseError("Largo monto Descuento Simcard inválido = " + WsFacturacionVentaIn.getFacturacionLinea()[i].getMntoDscSimcard());
				listaRespuestaValidacion.add(respuesta);
			}
			
			if(!validarLongitud("procesoDeFacturacion.mntoDscTerminal", String.valueOf(WsFacturacionVentaIn.getFacturacionLinea()[i].getMntoDscTerminal()))){
				RetornoDTO respuesta = new RetornoDTO();
				respuesta.setCodError("12230");
				respuesta.setMensajseError("Largo monto Descuento Terminal inválido = " + WsFacturacionVentaIn.getFacturacionLinea()[i].getMntoDscTerminal());
				listaRespuestaValidacion.add(respuesta);
			}
			
			if(!validarLongitud("procesoDeFacturacion.numCelular", String.valueOf(WsFacturacionVentaIn.getFacturacionLinea()[i].getNumCelular()))){
				RetornoDTO respuesta = new RetornoDTO();
				respuesta.setCodError("12231");
				respuesta.setMensajseError("Largo numero de celular inválido = " + WsFacturacionVentaIn.getFacturacionLinea()[i].getNumCelular());
				listaRespuestaValidacion.add(respuesta);
			}			
		}
		
		/*******************INICIO FORMATO*****************/
		if(!validarFormato("procesoDeFacturacion.nomUsuario", WsFacturacionVentaIn.getNomUsuario())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12232");
			respuesta.setMensajseError("Formato Nombre Usuario inválido = " + WsFacturacionVentaIn.getNomUsuario());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("procesoDeFacturacion.numVenta", WsFacturacionVentaIn.getNumVenta())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12233");
			respuesta.setMensajseError("Formato Numero de Venta inválido = " + WsFacturacionVentaIn.getNumVenta());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("procesoDeFacturacion.obsFactVenta", WsFacturacionVentaIn.getObsFactVenta())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12234");
			respuesta.setMensajseError("Formato Observacion Factura inválido = " + WsFacturacionVentaIn.getObsFactVenta());
			listaRespuestaValidacion.add(respuesta);
		}
		
		for(int i=0;i<WsFacturacionVentaIn.getFacturacionLinea().length;i++){
			
			if(!validarFormato("procesoDeFacturacion.mntoDscSimcard", String.valueOf(WsFacturacionVentaIn.getFacturacionLinea()[i].getMntoDscSimcard()))){
				RetornoDTO respuesta = new RetornoDTO();
				respuesta.setCodError("12237");
				respuesta.setMensajseError("Formato monto Descuento Simcard inválido = " + WsFacturacionVentaIn.getFacturacionLinea()[i].getMntoDscSimcard());
				listaRespuestaValidacion.add(respuesta);
			}
			
			if(!validarFormato("procesoDeFacturacion.mntoDscTerminal", String.valueOf(WsFacturacionVentaIn.getFacturacionLinea()[i].getMntoDscTerminal()))){
				RetornoDTO respuesta = new RetornoDTO();
				respuesta.setCodError("12238");
				respuesta.setMensajseError("Formato monto Descuento Terminal inválido = " + WsFacturacionVentaIn.getFacturacionLinea()[i].getMntoDscTerminal());
				listaRespuestaValidacion.add(respuesta);
			}
			
			if(!validarFormato("procesoDeFacturacion.numCelular", String.valueOf(WsFacturacionVentaIn.getFacturacionLinea()[i].getNumCelular()))){
				RetornoDTO respuesta = new RetornoDTO();
				respuesta.setCodError("12239");
				respuesta.setMensajseError("Formato numero de celular inválido = " + WsFacturacionVentaIn.getFacturacionLinea()[i].getNumCelular());
				listaRespuestaValidacion.add(respuesta);
			}			
		}
		
		/*******************FIN FORMATO*****************/	
			
		return listaRespuestaValidacion;		
	}
	
	
	public static ArrayList ValidarCierreVenta(WsCierreVentaInDTO cierreVenta){

		ArrayList listaRespuestaValidacion = new ArrayList(); 

		if(!validarLongitud("cierreVenta.identificadorTransaccion", cierreVenta.getIdentificadorTransaccion())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12252");
			respuesta.setMensajseError("Largo identificador Transaccion inválido = " + cierreVenta.getIdentificadorTransaccion());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("cierreVenta.usuario", cierreVenta.getUsuario())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12253");
			respuesta.setMensajseError("Largo Usuario inválido = " + cierreVenta.getUsuario());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("cierreVenta.numVenta", cierreVenta.getVenta())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12254");
			respuesta.setMensajseError("Largo Número de Venta inválido = " + cierreVenta.getVenta());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("cierreVenta.mtoGarantia", String.valueOf(cierreVenta.getMtoGarantia()))){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12315");
			respuesta.setMensajseError("Largo Monto Garantía inválido = " + String.valueOf(cierreVenta.getMtoGarantia()));
			listaRespuestaValidacion.add(respuesta);
		}		
/*********************INICIO FORMATO***********************/
		if(!validarFormato("cierreVenta.identificadorTransaccion", cierreVenta.getIdentificadorTransaccion())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12255");
			respuesta.setMensajseError("Formato identificador Transaccion inválido = " + cierreVenta.getIdentificadorTransaccion());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("cierreVenta.usuario", cierreVenta.getUsuario())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12256");
			respuesta.setMensajseError("Formato Usuario inválido = " + cierreVenta.getUsuario());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("cierreVenta.numVenta", cierreVenta.getVenta())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12257");
			respuesta.setMensajseError("Formato Número de Venta inválido = " + cierreVenta.getVenta());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("cierreVenta.mtoGarantia", String.valueOf(cierreVenta.getMtoGarantia()))){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12316");
			respuesta.setMensajseError("Formato Monto Garantía inválido = " + String.valueOf(cierreVenta.getMtoGarantia()));
			listaRespuestaValidacion.add(respuesta);
		}
		/*********************FIN FORMATO***********************/		
		return listaRespuestaValidacion;		
	}
	
	
	public static ArrayList ValidarAceptacionVenta(WsAceptacionVentaInDTO aceptacionVenta){

		ArrayList listaRespuestaValidacion = new ArrayList(); 

		if(!validarLongitud("aceptacionVenta.identificadorTransaccion", aceptacionVenta.getIdentificadorTransaccion())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12258");
			respuesta.setMensajseError("Largo identificador Transaccion inválido = " + aceptacionVenta.getIdentificadorTransaccion());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("aceptacionVenta.usuario", aceptacionVenta.getUsuario())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12259");
			respuesta.setMensajseError("Largo Usuario inválido = " + aceptacionVenta.getUsuario());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("aceptacionVenta.numVenta", aceptacionVenta.getVenta())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12260");
			respuesta.setMensajseError("Largo Número de Venta inválido = " + aceptacionVenta.getVenta());
			listaRespuestaValidacion.add(respuesta);
		}
		
				
/*********************INICIO FORMATO***********************/
		if(!validarFormato("aceptacionVenta.identificadorTransaccion", aceptacionVenta.getIdentificadorTransaccion())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12261");
			respuesta.setMensajseError("Formato identificador Transaccion inválido = " + aceptacionVenta.getIdentificadorTransaccion());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("aceptacionVenta.usuario", aceptacionVenta.getUsuario())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12262");
			respuesta.setMensajseError("Formato Usuario inválido = " + aceptacionVenta.getUsuario());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("aceptacionVenta.numVenta", aceptacionVenta.getVenta())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12263");
			respuesta.setMensajseError("Formato Número de Venta inválido = " + aceptacionVenta.getVenta());
			listaRespuestaValidacion.add(respuesta);
		}
		
		
		/*********************FIN FORMATO***********************/		
		return listaRespuestaValidacion;		
	}
	
	
	public static ArrayList ValidarSolicitaBajaAbonado(WSSolicitudBajaAbonadoDTO solicitaBajaAbonado){

		ArrayList listaRespuestaValidacion = new ArrayList(); 

		if(!validarLongitud("solicitaBajaAbonado.codigoCausaBaja", solicitaBajaAbonado.getCodCausaBaja())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12292");
			respuesta.setMensajseError("Largo Codigo Causa Baja inválido = " + solicitaBajaAbonado.getCodCausaBaja());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("solicitaBajaAbonado.codigoModulo", solicitaBajaAbonado.getCodMod())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12293");
			respuesta.setMensajseError("Largo Codigo Modulo inválido = " + solicitaBajaAbonado.getCodMod());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("solicitaBajaAbonado.codigoOficina", solicitaBajaAbonado.getCodOficina())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12294");
			respuesta.setMensajseError("Largo Código Oficina inválido = " + solicitaBajaAbonado.getCodOficina());
			listaRespuestaValidacion.add(respuesta);
		}		
		
		if(!validarLongitud("solicitaBajaAbonado.codigoTipoComisionista", solicitaBajaAbonado.getCodTipComis())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12296");
			respuesta.setMensajseError("Largo Código Tipo Comisionista inválido = " + solicitaBajaAbonado.getCodTipComis());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("solicitaBajaAbonado.codigoVendedor", solicitaBajaAbonado.getCodVendedor())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12297");
			respuesta.setMensajseError("Largo Código Vendedor inválido = " + solicitaBajaAbonado.getCodVendedor());
			listaRespuestaValidacion.add(respuesta);
		}
				
		if(!validarLongitud("solicitaBajaAbonado.IdUsuario", solicitaBajaAbonado.getIdUsuario())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12298");
			respuesta.setMensajseError("Largo Id Usuario inválido = " + solicitaBajaAbonado.getIdUsuario());
			listaRespuestaValidacion.add(respuesta);
		}
		
		
		
		if(!validarLongitud("solicitaBajaAbonado.tieneGarantia", solicitaBajaAbonado.getTieneGarantia())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12300");
			respuesta.setMensajseError("Largo Tiene Garantía inválido = " + solicitaBajaAbonado.getTieneGarantia());
			listaRespuestaValidacion.add(respuesta);
		}
				
/*********************INICIO FORMATO***********************/
		if(!validarFormato("solicitaBajaAbonado.codigoCausaBaja", solicitaBajaAbonado.getCodCausaBaja())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12301");
			respuesta.setMensajseError("Formato Codigo Causa Baja inválido = " + solicitaBajaAbonado.getCodCausaBaja());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("solicitaBajaAbonado.codigoModulo", solicitaBajaAbonado.getCodMod())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12302");
			respuesta.setMensajseError("Formato Codigo Modulo inválido = " + solicitaBajaAbonado.getCodMod());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("solicitaBajaAbonado.codigoOficina", solicitaBajaAbonado.getCodOficina())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12303");
			respuesta.setMensajseError("Formato Código Oficina inválido = " + solicitaBajaAbonado.getCodOficina());
			listaRespuestaValidacion.add(respuesta);
		}			
		
		if(!validarFormato("solicitaBajaAbonado.codigoTipoComisionista", solicitaBajaAbonado.getCodTipComis())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12305");
			respuesta.setMensajseError("Formato Código Tipo Comisionista inválido = " + solicitaBajaAbonado.getCodTipComis());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("solicitaBajaAbonado.codigoVendedor", solicitaBajaAbonado.getCodVendedor())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12306");
			respuesta.setMensajseError("Formato Código Vendedor inválido = " + solicitaBajaAbonado.getCodVendedor());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("solicitaBajaAbonado.IdUsuario", solicitaBajaAbonado.getIdUsuario())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12307");
			respuesta.setMensajseError("Formato Id Usuario inválido = " + solicitaBajaAbonado.getIdUsuario());
			listaRespuestaValidacion.add(respuesta);
		}
			
		if(!validarFormato("solicitaBajaAbonado.tieneGarantia", solicitaBajaAbonado.getTieneGarantia())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12309");
			respuesta.setMensajseError("Formato Tiene Garantía inválido = " + solicitaBajaAbonado.getTieneGarantia());
			listaRespuestaValidacion.add(respuesta);
		}
		
		/*********************FIN FORMATO***********************/
		
		return listaRespuestaValidacion;		
	}
	
	
	public static ArrayList ValidarSolicitaReserva(ReservaDTO solicitaReservaDTO){

		ArrayList listaRespuestaValidacion = new ArrayList(); 

		if(!validarLongitud("solicitaReserva.estadoReserva", solicitaReservaDTO.getEstadoReserva())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12388");
			respuesta.setMensajseError("Largo estado reserva inválido = " + solicitaReservaDTO.getEstadoReserva());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("solicitaReserva.nomUsuario", solicitaReservaDTO.getNomUsuario())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12389");
			respuesta.setMensajseError("Largo nombre Usuario inválido = " + solicitaReservaDTO.getNomUsuario());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("solicitaReserva.numeroSerie", solicitaReservaDTO.getNumeroSerie())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12390");
			respuesta.setMensajseError("Largo numero de serie inválido = " + solicitaReservaDTO.getNumeroSerie());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("solicitaReserva.codArticulo", String.valueOf(solicitaReservaDTO.getCodArticulo()))){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12391");
			respuesta.setMensajseError("Largo codigo articulo inválido = " + solicitaReservaDTO.getCodArticulo());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("solicitaReserva.codUso", String.valueOf(solicitaReservaDTO.getCodUso()))){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12392");
			respuesta.setMensajseError("Largo codigo de uso inválido = " + solicitaReservaDTO.getCodUso());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("solicitaReserva.codVendedor", String.valueOf(solicitaReservaDTO.getCodVendedor()))){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12393");
			respuesta.setMensajseError("Largo codigo vendedor inválido = " + solicitaReservaDTO.getCodVendedor());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("solicitaReserva.numeroSolicitud", String.valueOf(solicitaReservaDTO.getNumeroSolicitud()))){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12394");
			respuesta.setMensajseError("Largo numero de solicitud inválido = " + solicitaReservaDTO.getNumeroSolicitud());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("solicitaReserva.estadoReserva", solicitaReservaDTO.getEstadoReserva())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12395");
			respuesta.setMensajseError("Formato estado reserva inválido = " + solicitaReservaDTO.getEstadoReserva());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("solicitaReserva.nomUsuario", solicitaReservaDTO.getNomUsuario())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12396");
			respuesta.setMensajseError("Formato nombre usuario inválido = " + solicitaReservaDTO.getNomUsuario());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("solicitaReserva.numeroSerie", solicitaReservaDTO.getNumeroSerie())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12397");
			respuesta.setMensajseError("Formato numero de serie inválido = " + solicitaReservaDTO.getNumeroSerie());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("solicitaReserva.codArticulo", String.valueOf(solicitaReservaDTO.getCodArticulo()))){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12398");
			respuesta.setMensajseError("Formato codigo articulo inválido = " + solicitaReservaDTO.getCodArticulo());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("solicitaReserva.codUso", String.valueOf(solicitaReservaDTO.getCodUso()))){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12399");
			respuesta.setMensajseError("Formato codigo uso inválido = " + solicitaReservaDTO.getCodUso());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("solicitaReserva.codVendedor", String.valueOf(solicitaReservaDTO.getCodVendedor()))){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12400");
			respuesta.setMensajseError("Formato codigo vendedor inválido = " + solicitaReservaDTO.getCodVendedor());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("solicitaReserva.numeroSolicitud", String.valueOf(solicitaReservaDTO.getNumeroSolicitud()))){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12401");
			respuesta.setMensajseError("Formato numero de solicitud inválido = " + solicitaReservaDTO.getNumeroSolicitud());
			listaRespuestaValidacion.add(respuesta);
		}		
		
		return listaRespuestaValidacion;
	}
	
	public static ArrayList ValidarSolicitaDesreserva(ReservaDTO solicitaDesreservaDTO){

		ArrayList listaRespuestaValidacion = new ArrayList(); 
				
		if(!validarLongitud("solicitaDesreserva.nomUsuario", solicitaDesreservaDTO.getNomUsuario())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12402");
			respuesta.setMensajseError("Largo nombre Usuario inválido = " + solicitaDesreservaDTO.getNomUsuario());
			listaRespuestaValidacion.add(respuesta);
		}
				
		if(!validarLongitud("solicitaDesreserva.codVendedor", String.valueOf(solicitaDesreservaDTO.getCodVendedor()))){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12403");
			respuesta.setMensajseError("Largo codigo vendedor inválido = " + solicitaDesreservaDTO.getCodVendedor());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("solicitaDesreserva.numeroSolicitud", String.valueOf(solicitaDesreservaDTO.getNumeroSolicitud()))){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12404");
			respuesta.setMensajseError("Largo numero de solicitud inválido = " + solicitaDesreservaDTO.getNumeroSolicitud());
			listaRespuestaValidacion.add(respuesta);
		}
				
		if(!validarFormato("solicitaDesreserva.nomUsuario", solicitaDesreservaDTO.getNomUsuario())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12405");
			respuesta.setMensajseError("Formato nombre usuario inválido = " + solicitaDesreservaDTO.getNomUsuario());
			listaRespuestaValidacion.add(respuesta);
		}
				
		if(!validarFormato("solicitaDesreserva.codVendedor", String.valueOf(solicitaDesreservaDTO.getCodVendedor()))){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12406");
			respuesta.setMensajseError("Formato codigo vendedor inválido = " + solicitaDesreservaDTO.getCodVendedor());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("solicitaDesreserva.numeroSolicitud", String.valueOf(solicitaDesreservaDTO.getNumeroSolicitud()))){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12407");
			respuesta.setMensajseError("Formato numero de solicitud inválido = " + solicitaDesreservaDTO.getNumeroSolicitud());
			listaRespuestaValidacion.add(respuesta);
		}		
		
		return listaRespuestaValidacion;
	}
	
	public static ArrayList ValidarRechazoVenta(WsRechazoVentaInDTO rechazoVenta){

		ArrayList listaRespuestaValidacion = new ArrayList(); 

		if(!validarLongitud("rechazoVenta.identificadorTransaccion", rechazoVenta.getIdentificadorTransaccion())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12480");
			respuesta.setMensajseError("Largo identificador Transaccion inválido = " + rechazoVenta.getIdentificadorTransaccion());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("rechazoVenta.usuario", rechazoVenta.getUsuario())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12481");
			respuesta.setMensajseError("Largo Usuario inválido = " + rechazoVenta.getUsuario());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarLongitud("rechazoVenta.numVenta", rechazoVenta.getVenta())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12482");
			respuesta.setMensajseError("Largo Número de Venta inválido = " + rechazoVenta.getVenta());
			listaRespuestaValidacion.add(respuesta);
		}

		if(!validarFormato("rechazoVenta.identificadorTransaccion", rechazoVenta.getIdentificadorTransaccion())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12483");
			respuesta.setMensajseError("Formato identificador Transaccion inválido = " + rechazoVenta.getIdentificadorTransaccion());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("rechazoVenta.usuario", rechazoVenta.getUsuario())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12484");
			respuesta.setMensajseError("Formato Usuario inválido = " + rechazoVenta.getUsuario());
			listaRespuestaValidacion.add(respuesta);
		}
		
		if(!validarFormato("rechazoVenta.numVenta", rechazoVenta.getVenta())){
			RetornoDTO respuesta = new RetornoDTO();
			respuesta.setCodError("12485");
			respuesta.setMensajseError("Formato Número de Venta inválido = " + rechazoVenta.getVenta());
			listaRespuestaValidacion.add(respuesta);
		}
	
		return listaRespuestaValidacion;		
	}
}
