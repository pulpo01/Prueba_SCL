package com.tmmas.gte.integraciongte.ejb.helper;

import com.tmmas.gte.integraciongtecommon.dto.ActDesServSupleDto;
import com.tmmas.gte.integraciongtecommon.dto.AuditoriaDTO;
import com.tmmas.gte.integraciongtecommon.dto.BancoDispInDTO;
import com.tmmas.gte.integraciongtecommon.dto.CodClienteDTO;
import com.tmmas.gte.integraciongtecommon.dto.ConsDistribuidorInDTO;
import com.tmmas.gte.integraciongtecommon.dto.ConsLinkFacturaDTO;
import com.tmmas.gte.integraciongtecommon.dto.ConsLlamadaInDTO;
import com.tmmas.gte.integraciongtecommon.dto.DatosLstCliCliDTO;
import com.tmmas.gte.integraciongtecommon.dto.DatosLstCliCueDTO;
import com.tmmas.gte.integraciongtecommon.dto.DatosLstCliNitDTO;
import com.tmmas.gte.integraciongtecommon.dto.DistribPedidoInDTO;
import com.tmmas.gte.integraciongtecommon.dto.DistribuidorInDTO;
import com.tmmas.gte.integraciongtecommon.dto.EsClieTelefDTO;
import com.tmmas.gte.integraciongtecommon.dto.EsTelefIgualClieDTO;
import com.tmmas.gte.integraciongtecommon.dto.GrpCodPrestacionListDTO;
import com.tmmas.gte.integraciongtecommon.dto.GrupoPrestacionListDTO;
import com.tmmas.gte.integraciongtecommon.dto.IdTipoPrestacionInDTO;
import com.tmmas.gte.integraciongtecommon.dto.LlamadaClienteDTO;
import com.tmmas.gte.integraciongtecommon.dto.LlamadasFacturadasResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.MinutosLdiInDTO;
import com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO;
import com.tmmas.gte.integraciongtecommon.dto.TarjetaDeCreditoInDTO;

public class ValidaParametros {
	
	
	/*
	 * Autor: Juan Daniel Mu�oz Queupul
	 * */
	
	public String planTarifario(NumeroTelefonoDTO planTarifario){
		String mensaje = null;
		Util vp = new Util();
		try{
			if(planTarifario == null){
				mensaje = "Problema con el ingreso de datos";
				return mensaje;
			}
			if(!vp.esLong(planTarifario.getNumeroTelefono()+"")){
				mensaje = "Debe ingresar un N�mero de Tel�fono v�lido";
				return mensaje;
			}
			if(planTarifario.getNumeroTelefono() == 0){
				mensaje = "El N�mero de Tel�fono ingresado debe ser distinto de cero";
				return mensaje;
			}
			
		} catch (Exception e) {
			mensaje = "Error en la validaci�n de los datos";
			return mensaje;
			
		}
		
		
		
		return mensaje;
	}
	public String altaPrepago(NumeroTelefonoDTO alta){
		String mensaje = null;
		Util vp = new Util();
		try{
			if(alta == null){
				mensaje = "Problema con el ingreso de datos";
				return mensaje;
			}
			if(!vp.esLong(alta.getNumeroTelefono()+"")){
				mensaje = "Debe ingresar un N�mero de Tel�fono v�lido";
				return mensaje;
			}
			if(alta.getNumeroTelefono() == 0){
				mensaje = "El N�mero de Tel�fono ingresado debe ser distinto de cero";
				return mensaje;
			}
			
		} catch (Exception e) {
			mensaje = "Error en la validaci�n de los datos";
			return mensaje;
			
		}
		
		
		
		return mensaje;
	}
	public String serviciosSuplementarios(NumeroTelefonoDTO serviSuple){
		String mensaje = null;
		Util vp = new Util();
		try{
			if(serviSuple == null){
				mensaje = "Problema con el ingreso de datos";
				return mensaje;
			}
			if(!vp.esLong(serviSuple.getNumeroTelefono()+"")){
				mensaje = "Debe ingresar un N�mero de Tel�fono v�lido";
				return mensaje;
			}
			if(serviSuple.getNumeroTelefono() == 0){
				mensaje = "El N�mero de Tel�fono ingresado debe ser distinto de cero";
				return mensaje;
			}
			
		} catch (Exception e) {
			mensaje = "Error en la validaci�n de los datos";
			return mensaje;
			
		}
		
		
		
		return mensaje;
	}	
	public String linkFactura(ConsLinkFacturaDTO LinkFacturaIn){
		String mensaje = null;
		Util vp = new Util();
		try{
			if(LinkFacturaIn == null){
				mensaje = "Problema con el ingreso de datos";
				return mensaje;
			}
			if(!vp.esLong(LinkFacturaIn.getNumProceso()+"")){
				mensaje = "Debe ingresar un N�mero de Proceso v�lido";
				return mensaje;
			}
			if(LinkFacturaIn.getNumProceso() == 0){
				mensaje = "El N�mero de Proceso ingresado debe ser distinto de cero";
				return mensaje;
			}
			if(!vp.esLong(LinkFacturaIn.getCodCliente()+"")){
				mensaje = "Debe ingresar un C�digo de Cliente de Proceso v�lido";
				return mensaje;
			}
			if(LinkFacturaIn.getCodCliente() == 0){
				mensaje = "El C�digo de Cliente ingresado debe ser distinto de cero";
				return mensaje;
			}
			
		} catch (Exception e) {
			mensaje = "Error en la validaci�n de los datos";
			return mensaje;
		}
		return mensaje;
	}	
	public String detalleDireccion(NumeroTelefonoDTO numero){
		String mensaje = null;
		Util vp = new Util();
		try{
			if(numero == null){
				mensaje = "Problema con el ingreso de datos";
				return mensaje;
			}
			if(!vp.esLong(numero.getNumeroTelefono()+"")){
				mensaje = "Debe ingresar un N�mero de Tel�fono v�lido";
				return mensaje;
			}
			if(numero.getNumeroTelefono() == 0){
				mensaje = "El N�mero de Tel�fono ingresado debe ser distinto de cero";
				return mensaje;
			}
			
		} catch (Exception e) {
			mensaje = "Error en la validaci�n de los datos";
			return mensaje;
		}
		return mensaje;
	}	
	public String consCodPrestacion(IdTipoPrestacionInDTO inParam0){
		String mensaje = null;
		try{
			if(inParam0 == null){
				mensaje = "Problema con el ingreso de datos";
				return mensaje;
			}
			if(inParam0!=null && inParam0.getIdTipoPrestacion()!=null && !(inParam0.getIdTipoPrestacion().trim()).equals("")) {
				if (!(inParam0.getIdTipoPrestacion().equals("1")) && !(inParam0.getIdTipoPrestacion().equals("3"))){
				mensaje = "El ID Tipo de Prestaci�n ingresado no es v�lido (INGRESAR, 1: Pospago o H�brido, 3: Prepago)";
				return mensaje;
				}
			}
			if(inParam0!=null && inParam0.getIdTipoPrestacion()!=null && inParam0.getIdTipoPrestacion().trim().equals("")){
				mensaje = "Debe ingresar un ID Tipo de Prestaci�n (1: Pospago o H�brido, 3: Prepago)";
				return mensaje;
			}
			if(inParam0.getGrpPrestacionList()==null){
				mensaje = "Debe ingresar al menos un Grupo de Prestaci�n";
				return mensaje;
			}
			if(inParam0.getGrpPrestacionList()!=null && inParam0.getGrpPrestacionList().length==0){
				mensaje = "Debe ingresar al menos un Grupo de Prestaci�n";
				return mensaje;
			}
		} catch (Exception e) {
			mensaje = "Error en la validaci�n de los datos";
			return mensaje;
		}
		return mensaje;
	}		
	public String esClienteTelefono(EsClieTelefDTO esClieTelef){
		String mensaje = null;
		Util vp = new Util();
		try{
			if(esClieTelef == null){
				mensaje = "Problema con el ingreso de datos";
				return mensaje;
			}
			if(!vp.esLong(esClieTelef.getNumeroTelefono()+"")){
				mensaje = "Debe ingresar un N�mero de Tel�fono v�lido";
				return mensaje;
			}
			if(esClieTelef.getNumeroTelefono() == 0){
				mensaje = "El N�mero de Tel�fono ingresado debe ser distinto de cero";
				return mensaje;
			}
			
			if(!vp.esLong(esClieTelef.getCodCliente()+"")){
				mensaje = "Debe ingresar un C�digo de Cliente v�lido";
				return mensaje;
			}
			if(esClieTelef.getCodCliente() == 0){
				mensaje = "El C�digo de Cliente ingresado debe ser distinto de cero";
				return mensaje;
			}
			
		} catch (Exception e) {
			mensaje = "Error en la validaci�n de los datos";
			return mensaje;
			
		}
		return mensaje;
	}
	public String esTelefIgualClie(EsTelefIgualClieDTO telIgualClie){
		String mensaje = null;
		Util vp = new Util();
		try{
			if(telIgualClie == null){
				mensaje = "Problema con el ingreso de datos";
				return mensaje;
			}
			if(!vp.esLong(telIgualClie.getNum_telefono1()+"")){
				mensaje = "Debe ingresar un N�mero de Tel�fono v�lido";
				return mensaje;
			}
			if(telIgualClie.getNum_telefono1() == 0){
				mensaje = "El N�mero de Tel�fono ingresado debe ser distinto de cero";
				return mensaje;
			}
			if(!vp.esLong(telIgualClie.getNum_telefono2()+"")){
				mensaje = "Debe ingresar un N�mero de Tel�fono v�lido";
				return mensaje;
			}
			if(telIgualClie.getNum_telefono2() == 0){
				mensaje = "El N�mero de Tel�fono ingresado debe ser distinto de cero";
				return mensaje;
			}
			
		} catch (Exception e) {
			mensaje = "Error en la validaci�n de los datos";
			return mensaje;
			
		}
		return mensaje;
	}
	public String validarAuditoria(AuditoriaDTO auditoria){
		String mensaje = null;
		Util vp = new Util();
		try{
			if(auditoria == null){
				mensaje = "Problema con el ingreso de datos";
				return mensaje;
			}
			if((auditoria.getNombreUsuario().equals(""))||(auditoria.getNombreUsuario() == null)){
				mensaje = "Debe ingresar un nombre de usuario v�lido";
				return mensaje;
			}
			if((auditoria.getCodPuntoAcceso().equals(""))||(auditoria.getCodPuntoAcceso() == null)){
				mensaje = "Debe ingresar un punto de acceso v�lido";
				return mensaje;
			}
			if((auditoria.getCodServicio().equals(""))||(auditoria.getCodServicio()== null)){
				mensaje = "Debe ingresar un c�digo de servicio v�lido";
				return mensaje;
			}
			
		} catch (Exception e) {
			mensaje = "Error en la validaci�n de los datos";
			return mensaje;
			
		}
		return mensaje;
	}	
	public String actDesServSuple(ActDesServSupleDto serviSuple){
		String mensaje = null;
		Util vp = new Util();
		try{
			if(serviSuple == null){
				mensaje = "Problema con el ingreso de datos";
				return mensaje;
			}
			if(!vp.esLong(serviSuple.getNumTelefono()+"")){
				mensaje = "Debe ingresar un N�mero de Tel�fono v�lido";
				return mensaje;
			}
			if(serviSuple.getNumTelefono() == 0){
				mensaje = "El N�mero de Tel�fono ingresado debe ser distinto de cero";
				return mensaje;
			}
			
		} catch (Exception e) {
			mensaje = "Error en la validaci�n de los datos";
			return mensaje;
			
		}
		return mensaje;
	}	
	public String consultarAvisoSiniestro(NumeroTelefonoDTO avisoSiniestro){
		String mensaje = null;
		Util vp = new Util();
		try{
			if(avisoSiniestro == null){
				mensaje = "Problema con el ingreso de datos";
				return mensaje;
			}
			if(!vp.esLong(avisoSiniestro.getNumeroTelefono()+"")){
				mensaje = "Debe ingresar un N�mero de Tel�fono v�lido";
				return mensaje;
			}
			if(avisoSiniestro.getNumeroTelefono() == 0){
				mensaje = "El N�mero de Tel�fono ingresado debe ser distinto de cero";
				return mensaje;
			}
			
		} catch (Exception e) {
			mensaje = "Error en la validaci�n de los datos";
			return mensaje;
			
		}
		
		
		
		return mensaje;
	}
	public String consultaNumeracion(NumeroTelefonoDTO parametro) {
		String mensaje = null;
		Util vp = new Util();
		try{
			if(parametro == null){
				mensaje = "Problema con el ingreso de datos";
				return mensaje;
			}
			if(!vp.esLong(parametro.getNumeroTelefono()+"")){
				mensaje = "Debe ingresar un N�mero de Tel�fono v�lido";
				return mensaje;
			}
			if(parametro.getNumeroTelefono() == 0){
				mensaje = "El N�mero de Tel�fono ingresado debe ser distinto de cero";
				return mensaje;
			}
			
		} catch (Exception e) {
			mensaje = "Error en la validaci�n de los datos";
			return mensaje;
			
		}
		return mensaje;
	}
	public String consultarPuk(NumeroTelefonoDTO parametro) {
		String mensaje = null;
		Util vp = new Util();
		try{
			if(parametro == null){
				mensaje = "Problema con el ingreso de datos";
				return mensaje;
			}
			if(!vp.esLong(parametro.getNumeroTelefono()+"")){
				mensaje = "Debe ingresar un N�mero de Tel�fono v�lido";
				return mensaje;
			}
			if(parametro.getNumeroTelefono() == 0){
				mensaje = "El N�mero de Tel�fono ingresado debe ser distinto de cero";
				return mensaje;
			}
			
		} catch (Exception e) {
			mensaje = "Error en la validaci�n de los datos";
			return mensaje;
			
		}
		return mensaje;
	}
	public String listarClientesNit(DatosLstCliNitDTO serviClientes){
		String mensaje = null;
		Util vp = new Util();
		try{
			if(serviClientes == null){
				mensaje = "Problema con el ingreso de datos";
				return mensaje;
			}
		    	if(serviClientes.getCodTipIdent().equals("")){
					mensaje = "Debe ingresar un c�digo de tipo de identificaci�n v�lido";
					return mensaje;
				}
		    	if(serviClientes.getCodTipIdent()== null){
					mensaje = "Debe ingresar un c�digo de tipo de identificaci�n v�lido";
					return mensaje;
				}
				if(serviClientes.getNumIdem().equals("")){
					mensaje = "Debe ingresar un n�mero de identificaci�n v�lido";
					return mensaje;
				}
				if(serviClientes.getNumIdem()==null){
					mensaje = "Debe ingresar un n�mero de identificaci�n v�lido";
					return mensaje;
				}
				
		} catch (Exception e) {
			mensaje = "Error en la validaci�n de los datos";
			return mensaje;
			
		}
		return mensaje;
	}	
	public String validarClienteCuenta(DatosLstCliCueDTO datosLstCliCue){
			String mensaje = null;
			Util vp = new Util();
			try{
				if(datosLstCliCue == null){
					mensaje = "Problema con el ingreso de datos";
					return mensaje;
				}
				if(!vp.esLong(datosLstCliCue.getCodCuenta()+"")){
					mensaje = "Debe ingresar un C�digo de Cuenta v�lido";
					return mensaje;
				}
				if(datosLstCliCue.getCodCuenta() == 0){
					mensaje = "El C�digo de Cuenta ingresado debe ser distinto de cero";
					return mensaje;
				}
				
			} catch (Exception e) {
				mensaje = "Error en la validaci�n de los datos";
				return mensaje;
				
			}
			
			
			
			return mensaje;
		}
	public String listarClientesCli(DatosLstCliCliDTO datosLstCliCli){
			String mensaje = null;
			Util vp = new Util();
			try{
				if(datosLstCliCli == null){
					mensaje = "Problema con el ingreso de datos";
					return mensaje;
				}
				if(!vp.esLong(datosLstCliCli.getCodCliente()+"")){
					mensaje = "Debe ingresar un C�digo de Cliente v�lido";
					return mensaje;
				}
				if(datosLstCliCli.getCodCliente() == 0){
					mensaje = "El C�digo de Cliente ingresado debe ser distinto de cero";
					return mensaje;
				}
				
			} catch (Exception e) {
				mensaje = "Error en la validaci�n de los datos";
				return mensaje;
				
			}
			return mensaje;
		}
	public String consultarConceptosFactura(CodClienteDTO codCliente){
			String mensaje = null;
			Util vp = new Util();
			try{
				if(codCliente == null){
					mensaje = "Problema con el ingreso de datos";
					return mensaje;
				}
				if(!vp.esLong(codCliente.getCodCliente()+"")){
					mensaje = "Debe ingresar un C�digo de Cliente v�lido";
					return mensaje;
				}
				if(codCliente.getCodCliente() == 0){
					mensaje = "El C�digo de Cliente ingresado debe ser distinto de cero";
					return mensaje;
				}
				
			} catch (Exception e) {
				mensaje = "Error en la validaci�n de los datos";
				return mensaje;
				
			}
			return mensaje;
		}
	public String consultarSaldoCliente(NumeroTelefonoDTO numeroTelefonoIn){
		String mensaje = null;
		Util vp = new Util();
		try{
			if(numeroTelefonoIn == null){
				mensaje = "Problema con el ingreso de datos";
				return mensaje;
			}
			if(!vp.esLong(numeroTelefonoIn.getNumeroTelefono()+"")){
				mensaje = "Debe ingresar un N�mero de Tel�fono v�lido";
				return mensaje;
			}
			if(numeroTelefonoIn.getNumeroTelefono() == 0){
				mensaje = "El n�mero de Tel�fono ingresado debe ser distinto de cero";
				return mensaje;
			}
			
		} catch (Exception e) {
			mensaje = "Error en la validaci�n de los datos";
			return mensaje;
			
		}
		return mensaje;
	}
	public String consultasFacturasDeunCliente(NumeroTelefonoDTO numeroTelefonoIn){
		String mensaje = null;
		Util vp = new Util();
		try{
			if(numeroTelefonoIn == null){
				mensaje = "Problema con el ingreso de datos";
				return mensaje;
			}
			if(!vp.esLong(numeroTelefonoIn.getNumeroTelefono()+"")){
				mensaje = "Debe ingresar un N�mero de Tel�fono v�lido";
				return mensaje;
			}
			if(numeroTelefonoIn.getNumeroTelefono() == 0){
				mensaje = "El n�mero ingresado es 0";
				return mensaje;
			}
			
		} catch (Exception e) {
			mensaje = "Error en la validaci�n de los datos";
			return mensaje;
			
		}
		return mensaje;
	}
	public String consultarPlanesDisponibles(GrpCodPrestacionListDTO inParam0){
		String mensaje = null;
		try{
			if(inParam0 == null){
				mensaje = "Problema con el ingreso de datos";
				return mensaje;
			}
			
			if(inParam0 != null && inParam0.getCodPrestacionList() == null){
				mensaje = "Debe ingresar al menos un Grupo de Prestaci�n";
				return mensaje;
			}
			if(inParam0 != null && inParam0.getGrpPrestacionList() == null){
				mensaje = "Debe ingresar al menos un C�digo de Prestaci�n";
				return mensaje;
			}
			if(inParam0 != null && inParam0.getCodPrestacionList() != null && inParam0.getCodPrestacionList().length == 0){
				mensaje = "Debe ingresar al menos un C�digo de Prestaci�n";
				return mensaje;
			}
			if(inParam0 != null && inParam0.getGrpPrestacionList() != null && inParam0.getGrpPrestacionList().length == 0){
				mensaje = "Debe ingresar al menos un Grupo de Prestaci�n";
				return mensaje;
			}
			if(inParam0 != null && inParam0.getCodPrestacionList() == null && inParam0.getGrpPrestacionList() == null){
				mensaje = "Debe ingresar al menos un Grupo de Prestaci�n y al menos un C�digo de Prestaci�n";
				return mensaje;
			}
		} catch (Exception e) {
			mensaje = "Error en la validaci�n de los datos";
			return mensaje;
			
		}
		return mensaje;
	}
	public String consultarPlanesDisponibles(GrupoPrestacionListDTO inParam0){
		String mensaje = null;
		try{
			if(inParam0 == null){
				mensaje = "Problema con el ingreso de datos";
				return mensaje;
			}
			if(inParam0 != null && inParam0.getGrpPrestacionList() == null){
				mensaje = "Debe ingresar al menos un C�digo de Prestaci�n";
				return mensaje;
			}
			if(inParam0 != null && inParam0.getGrpPrestacionList() != null && inParam0.getGrpPrestacionList().length == 0){
				mensaje = "Debe ingresar al menos un Grupo de Prestaci�n";
				return mensaje;
			}
		} catch (Exception e) {
			mensaje = "Error en la validaci�n de los datos";
			return mensaje;
			
		}
		return mensaje;
	}
	public String consultarDeBloqueo(NumeroTelefonoDTO parametro){
		String mensaje = null;
		Util vp = new Util();
		try{
			if(parametro == null){
				mensaje = "Problema con el ingreso de datos";
				return mensaje;
			}
			if(!vp.esLong(parametro.getNumeroTelefono()+"")){
				mensaje = "Debe ingresar un N�mero de Tel�fono v�lido";
				return mensaje;
			}
			if(parametro.getNumeroTelefono()== 0){
				mensaje = "El N�mero de Tel�fono ingresado debe ser distinto de cero";
				return mensaje;
			}
			
		} catch (Exception e) {
			mensaje = "Error en la validaci�n de los datos";
			return mensaje;
			
		}
		return mensaje;
	}
	public String consultasFechaFacturaReporteConsumo(NumeroTelefonoDTO numeroTelefonoIn){
		String mensaje = null;
		Util vp = new Util();
		try{
			if(numeroTelefonoIn == null){
				mensaje = "Problema con el ingreso de datos";
				return mensaje;
			}
			if(!vp.esLong(numeroTelefonoIn.getNumeroTelefono()+"")){
				mensaje = "Debe ingresar un N�mero de Tel�fono v�lido";
				return mensaje;
			}
			if(numeroTelefonoIn.getNumeroTelefono() == 0){
				mensaje = "El n�mero ingresado es 0";
				return mensaje;
			}
			
		} catch (Exception e) {
			mensaje = "Error en la validaci�n de los datos";
			return mensaje;
			
		}
		return mensaje;
	}	
	public String consultarLLamadasNoFacturadas(ConsLlamadaInDTO parametro){
		Fecha validaFecha = new Fecha();
		String mensaje = null;
		Util vp = new Util();
		/*
		 * Validaci�n del n�mero telefonico ingresado 
		 * */
		try{
			if(parametro == null){
				mensaje = "Problema con el ingreso de datos";
				return mensaje;
			}
			if(!vp.esLong(parametro.getNumeroTelefonico()+"")){
				mensaje = "Debe ingresar un N�mero de Tel�fono v�lido";
				return mensaje;
			}
			if(parametro.getNumeroTelefonico()== 0){
				mensaje = "El N�mero de Tel�fono ingresado debe ser distinto de cero";
				return mensaje;
			}
		} catch (Exception e) {
			mensaje = "Error en la validaci�n del dato n�mero de tel�fono";
			return mensaje;
		}
		/*
		 * Validaci�n de la fecha desde  
		 * */
		try{
			if(parametro.getFecDesde() != null && (parametro.getFecDesde().trim()).equals("")){
				mensaje = "En la fecha desde no ha ingrasado ning�n valor.";
				return mensaje;				
			}
			if(!validaFecha.esFecha(parametro.getFecDesde())){
				mensaje = "En la fecha desde no ha ingrasado ning�n valor o el formato de la fecha esta malo Ej:(DD-MM-AAAA).";
				return mensaje;				
			}
		}catch (Exception e) {
			mensaje = "Error en la validaci�n del dato fecha desde";
			return mensaje;
		}
		/*
		 * Validaci�n de la fecha hasta  
		 * */
		
		try{
			if(parametro.getFecHasta() != null && (parametro.getFecHasta().trim()).equals("")){
				mensaje = "En la fecha hasta no ha ingrasado ning�n valor.";
				return mensaje;				
			}

			if(!validaFecha.esFecha(parametro.getFecHasta())){
				mensaje = "En la fecha hasta no ha ingrasado ning�n valor o el formato de la fecha esta malo Ej:(DD-MM-AAAA).";
				return mensaje;				
			}
			
		}catch (Exception e) {
			mensaje = "Error en la validaci�n del dato fecha hasta";
			return mensaje;
		}
		return mensaje;
	}
	public String consultarDistribuidor(ConsDistribuidorInDTO parametro){
		String mensaje = null;
		Util vp = new Util();
		try{
			if(parametro == null){
				mensaje = "Problema con el ingreso de datos";
				return mensaje;
			}
			if(!vp.esLong(parametro.getCodDistribuidor()+"")){
				mensaje = "Debe ingresar un C�digo de Distribuidor v�lido";
				return mensaje;
			}
			if(parametro.getCodDistribuidor()== 0){
				mensaje = "El C�digo de Distribuidor ingresado debe ser distinto de cero";
				return mensaje;
			}
			
		} catch (Exception e) {
			mensaje = "Error en la validaci�n de los datos";
			return mensaje;
			
		}
		return mensaje;
	}	
	public String consultarDistribuidor(DistribPedidoInDTO parametro){
		String mensaje = null;
		Util vp = new Util();
		try{
			if(parametro == null){
				mensaje = "Problema con el ingreso de datos";
				return mensaje;
			}
			if(!vp.esLong(parametro.getCodDistribuidor()+"")){
				mensaje = "Debe ingresar un C�digo de Distribuidor v�lido";
				return mensaje;
			}
			if(!vp.esLong(parametro.getCodPedido()+"")){
				mensaje = "Debe ingresar un C�digo de Pedido v�lido";
				return mensaje;
			}
			if(parametro.getCodDistribuidor()== 0){
				mensaje = "El C�digo de Distribuidor ingresado debe ser distinto de cero";
				return mensaje;
			}
			if(parametro.getCodPedido()== 0){
				mensaje = "El C�digo de Pedido ingresado debe ser distinto de cero";
				return mensaje;
			}
		} catch (Exception e) {
			mensaje = "Error en la validaci�n de los datos";
			return mensaje;
			
		}
		return mensaje;
	}
	public String consultarFacturasNoCicloCliente(DistribuidorInDTO parametro){
		Fecha validaFecha = new Fecha();
		String mensaje = null;
		Util vp = new Util();
		/*
		 * Validaci�n del codigo del vendedor 
		 * */
		try{
			if(parametro == null){
				mensaje = "Problema con el ingreso de datos";
				return mensaje;
			}
			if(!vp.esLong(parametro.getCodVendedor()+"")){
				mensaje = "Debe ingresar un n�mero de vendedor  v�lido";
				return mensaje;
			}
			if(parametro.getCodVendedor()== 0){
				mensaje = "El c�digo del vendedor debe ser distinto de cero";
				return mensaje;
			}
		} catch (Exception e) {
			mensaje = "Error en la validaci�n del dato c�digo del vendedor";
			return mensaje;
		}
		/*
		 * Validaci�n de la fecha desde  
		 * */
		try{
			if(parametro.getFechaDesde() != null && (parametro.getFechaDesde().trim()).equals("")){
				mensaje = "En la fecha desde no ha ingrasado ning�n valor.";
				return mensaje;				
			}
			if(!validaFecha.esFecha(parametro.getFechaDesde())){
				mensaje = "En la fecha desde no ha ingrasado ning�n valor o el formato de la fecha esta malo Ej:(DD-MM-AAAA).";
				return mensaje;				
			}
		}catch (Exception e) {
			mensaje = "Error en la validaci�n del dato fecha desde";
			return mensaje;
		}
		/*
		 * Validaci�n de la fecha hasta  
		 * */
		try{
			if(parametro.getFechaHasta() != null && (parametro.getFechaHasta().trim()).equals("")){
				mensaje = "En la fecha hasta no ha ingrasado ning�n valor.";
				return mensaje;				
			}

			if(!validaFecha.esFecha(parametro.getFechaHasta())){
				mensaje = "En la fecha hasta no ha ingrasado ning�n valor o el formato de la fecha esta malo Ej:(DD-MM-AAAA).";
				return mensaje;				
			}
			
		}catch (Exception e) {
			mensaje = "Error en la validaci�n del dato fecha hasta";
			return mensaje;
		}

		return mensaje;
	}
	public String consultarConsumoMensajesCortos(NumeroTelefonoDTO parametro){
		String mensaje = null;
		Util vp = new Util();
		try{
			if(parametro == null){
				mensaje = "Problema con el ingreso de datos";
				return mensaje;
			}
			if(!vp.esLong(parametro.getNumeroTelefono()+"")){
				mensaje = "Debe ingresar un N�mero de Tel�fono v�lido";
				return mensaje;
			}
			if(parametro.getNumeroTelefono()== 0){
				mensaje = "El N�mero de Tel�fono ingresado debe ser distinto de cero";
				return mensaje;
			}
			
		} catch (Exception e) {
			mensaje = "Error en la validaci�n de los datos";
			return mensaje;
			
		}
		return mensaje;
	}		
	public String validarNumeroTelefono(NumeroTelefonoDTO parametro){
		String mensaje = null;
		Util vp = new Util();
		try{
			if(parametro == null){
				mensaje = "Problema con el ingreso de datos";
				return mensaje;
			}
			if(!vp.esLong(parametro.getNumeroTelefono()+"")){
				mensaje = "Debe ingresar un N�mero de Tel�fono v�lido";
				return mensaje;
			}
			if(parametro.getNumeroTelefono()== 0){
				mensaje = "El N�mero de Tel�fono ingresado debe ser distinto de cero";
				return mensaje;
			}
			
		} catch (Exception e) {
			mensaje = "Error en la validaci�n de los datos";
			return mensaje;
			
		}
		return mensaje;
	}	
	public String consultarDatosGenCliente(NumeroTelefonoDTO parametro) {
		String mensaje = null;
		Util vp = new Util();
		try{
			if(parametro == null){
				mensaje = "Problema con el ingreso de datos";
				return mensaje;
			}
			if(!vp.esLong(parametro.getNumeroTelefono()+"")){
				mensaje = "Debe ingresar un N�mero de Tel�fono v�lido";
				return mensaje;
			}
			if(parametro.getNumeroTelefono() == 0){
				mensaje = "El N�mero de Tel�fono ingresado debe ser distinto de cero";
				return mensaje;
			}
			
		} catch (Exception e) {
			mensaje = "Error en la validaci�n de los datos";
			return mensaje;
			
		}
		return mensaje;
	}
	public String consultarDatosGenCliente(CodClienteDTO parametro) {
		String mensaje = null;
		Util vp = new Util();
		try{
			if(parametro == null){
				mensaje = "Problema con el ingreso de datos";
				return mensaje;
			}
			if(!vp.esLong(parametro.getCodCliente()+"")){
				mensaje = "Debe ingresar un N�mero de Tel�fono v�lido";
				return mensaje;
			}
			if(parametro.getCodCliente() == 0){
				mensaje = "El c�digo de cliente ingresado debe ser distinto de cero";
				return mensaje;
			}
			
		} catch (Exception e) {
			mensaje = "Error en la validaci�n de los datos";
			return mensaje;
			
		}
		return mensaje;
	}
	public String consultarFacturasImpagasPorCliente(NumeroTelefonoDTO parametro) {
		String mensaje = null;
		Util vp = new Util();
		try{
			if(parametro == null){
				mensaje = "Problema con el ingreso de datos";
				return mensaje;
			}
			if(!vp.esLong(parametro.getNumeroTelefono()+"")){
				mensaje = "El dato ingresado no es n�mero";
				return mensaje;
			}
			if(parametro.getNumeroTelefono() == 0){
				mensaje = "El N�mero de Tel�fono ingresado debe ser distinto de cero";
				return mensaje;
			}
			
		} catch (Exception e) {
			mensaje = "Error en la validaci�n de los datos";
			return mensaje;
			
		}
		return mensaje;
	}
	public String consultarTipoCliente(NumeroTelefonoDTO parametro) {
		String mensaje = null;
		Util vp = new Util();
		try{
			if(parametro == null){
				mensaje = "Problema con el ingreso de datos";
				return mensaje;
			} 
			if(!vp.esLong(parametro.getNumeroTelefono()+"")){
				mensaje = "El dato ingresado no es n�mero";
				return mensaje;
			}
			if(parametro.getNumeroTelefono() == 0){
				mensaje = "El N�mero de Tel�fono ingresado debe ser distinto de cero";
				return mensaje;
			}
			
		} catch (Exception e) {
			mensaje = "Error en la validaci�n de los datos";
			return mensaje;
			
		}
		return mensaje;
	}
	public String consultarTipoServicio(NumeroTelefonoDTO parametro){
		String mensaje = null;
		Util vp = new Util();
		try{
			if(parametro == null){
				mensaje = "Problema con el ingreso de datos";
				return mensaje;
			}
			if(!vp.esLong(parametro.getNumeroTelefono()+"")){
				mensaje = "Debe ingresar un N�mero de Tel�fono v�lido";
				return mensaje;
			}
			if(parametro.getNumeroTelefono()== 0){
				mensaje = "El N�mero de Tel�fono ingresado debe ser distinto de cero";
				return mensaje;
			}
			
		} catch (Exception e) {
			mensaje = "Error en la validaci�n de los datos";
			return mensaje;
			
		}
		return mensaje;
	}
	public String consultarTerminal(NumeroTelefonoDTO parametro){
		String mensaje = null;
		Util vp = new Util();
		try{
			if(parametro == null){
				mensaje = "Problema con el ingreso de datos";
				return mensaje;
			}
			if(!vp.esLong(parametro.getNumeroTelefono()+"")){
				mensaje = "Debe ingresar un N�mero de Tel�fono v�lido";
				return mensaje;
			}
			if(parametro.getNumeroTelefono()== 0){
				mensaje = "El N�mero de Tel�fono ingresado debe ser distinto de cero";
				return mensaje;
			}
			
		} catch (Exception e) {
			mensaje = "Error en la validaci�n de los datos";
			return mensaje;
			
		}
		return mensaje;
	}	
	public String consultarTipoAbonado(NumeroTelefonoDTO parametro){
		String mensaje = null;
		Util vp = new Util();
		try{
			if(parametro == null){
				mensaje = "Problema con el ingreso de datos";
				return mensaje;
			}
			if(!vp.esLong(parametro.getNumeroTelefono()+"")){
				mensaje = "Debe ingresar un N�mero de Tel�fono v�lido";
				return mensaje;
			}
			if(parametro.getNumeroTelefono()== 0){
				mensaje = "El N�mero de Tel�fono ingresado debe ser distinto de cero";
				return mensaje;
			}
			
		} catch (Exception e) {
			mensaje = "Error en la validaci�n de los datos";
			return mensaje;
			
		}
		return mensaje;
	}
	public String consultarLlamadasFacturadas(LlamadaClienteDTO parametro){
		String mensaje = null;
		Util vp = new Util();
		try{
			if(parametro == null){
				mensaje = "Problema con el ingreso de datos";
				return mensaje;
			}
			if(!vp.esLong(parametro.getNumTelefono()+"")){
				mensaje = "Debe ingresar un N�mero de Tel�fono v�lido";
				return mensaje;
			}
			if(parametro.getNumTelefono()== 0){
				mensaje = "El N�mero de Tel�fono ingresado debe ser distinto de cero";
				return mensaje;
			}
			if(!vp.esLong(parametro.getNumFolio()+"")){
				mensaje = "Debe ingresar un N�mero de Folio v�lido";
				return mensaje;
			}
			if(parametro.getNumFolio()== 0){
				mensaje = "El N�mero de folio ingresado debe ser distinto de cero";
				return mensaje;
			}
			
			if(parametro !=null && parametro.getCampoOrden()!=null && !(parametro.getCampoOrden().trim()).equals("")) {
				if (!(parametro.getCampoOrden().equals("FEC_LLAMADA")) && !(parametro.getCampoOrden().equals("MTO_LLAM_CON_IMP"))){
				mensaje = "El campo de ordenamiento no es correspondiente.";
				return mensaje;
				}
			}
			
			if(parametro !=null && parametro.getTipoOrden()!=null && !(parametro.getTipoOrden().trim()).equals("")) {
				if (!(parametro.getTipoOrden().equals("ASC")) && !(parametro.getTipoOrden().equals("DESC"))){
				mensaje = "El tipo de orden no es v�lido, El ingreso es el siguiente (1.-Ascendente: ASC  o  2.-Descendente: DESC )";
				return mensaje;
				}
			}
			
		} catch (Exception e) {
			mensaje = "Error en la validaci�n de los datos";
			return mensaje;
			
		}
		return mensaje;
	}
	public String consultarSeguroPorTelefono(NumeroTelefonoDTO numeroTelefonoIn){
		String mensaje = null;
		Util vp = new Util();
		try{
			if(numeroTelefonoIn == null){
				mensaje = "Problema con el ingreso de datos";
				return mensaje;
			}
			if(!vp.esLong(numeroTelefonoIn.getNumeroTelefono()+"")){
				mensaje = "Debe ingresar un N�mero de Tel�fono v�lido";
				return mensaje;
			}
			if(numeroTelefonoIn.getNumeroTelefono() == 0){
				mensaje = "El n�mero ingresado es 0";
				return mensaje;
			}
			
		} catch (Exception e) {
			mensaje = "Error en la validaci�n de los datos";
			return mensaje;
			
		}
		return mensaje;
	}
	public String consultarBancosDisponibles(BancoDispInDTO banco){
		String mensaje = null;
		Util vp = new Util();
		try{
			if(banco.getAuditoria() == null){
				mensaje = "Problema con el ingreso de datos";
				return mensaje;
			}
			if((banco.getAuditoria().getNombreUsuario().equals(""))||(banco.getAuditoria().getNombreUsuario() == null)){
				mensaje = "Debe ingresar un nombre de usuario v�lido";
				return mensaje;
			}
			if((banco.getAuditoria().getCodPuntoAcceso().equals(""))||(banco.getAuditoria().getCodPuntoAcceso() == null)){
				mensaje = "Debe ingresar un punto de acceso v�lido";
				return mensaje;
			}
			if((banco.getAuditoria().getCodServicio().equals(""))||(banco.getAuditoria().getCodServicio()== null)){
				mensaje = "Debe ingresar un c�digo de servicio v�lido";
				return mensaje;
			}
			
		} catch (Exception e) {
			mensaje = "Error en la validaci�n de los datos";
			return mensaje;
			
		}
		return mensaje;
	}	
	public String validarDatosTarjCredito (TarjetaDeCreditoInDTO parametro){
		String mensaje = null;
		Util vp = new Util();
		Fecha validaFecha = new Fecha();
		
		try{
			if(parametro == null){
				mensaje = "Problema con el ingreso de datos";
				return mensaje;
			}
			if(!vp.esLong(parametro.getNumTelefono()+"")){
				mensaje = "Debe ingresar un N�mero de Tel�fono v�lido";
				return mensaje;
			}
			if(parametro.getNumTelefono()== 0){
				mensaje = "El N�mero de Tel�fono ingresado debe ser distinto de cero";
				return mensaje;
			}
			if(parametro.getCodTipTarjeta().equals("")){
				mensaje = "Debe ingresar un C�digo de Tipo de Tarjeta de Cr�dito";
				return mensaje;
			}
			if (parametro.getNumeroTarjeta().equals("")){
				mensaje = "Debe ingresar un N�mero de Tarjeta de Cr�dito";
				return mensaje;
			}
			if (parametro.getCodBancoTarjeta().equals("")){
				mensaje = "Debe ingresar el C�digo de Banco asociado a la Tarjeta de Cr�dito";
				return mensaje;
			}
			if (parametro.getNombreTitular().equals("")){
				mensaje = "Debe ingresar el Nombre del Titular asociado a la Tarjeta de Cr�dito";
				return mensaje;
			}
			
		} catch (Exception e) {
			mensaje = "Error en la validaci�n de los datos";
			return mensaje;
		}

			try{
				if(parametro.getFechaVencTarjeta() != null && (parametro.getFechaVencTarjeta().trim()).equals("")){
					mensaje = "Debe ingresar Fecha Vencimiento de la Tarjeta";
					return mensaje;				
				}
				if(!validaFecha.esFecha(parametro.getFechaVencTarjeta())){
					mensaje = "En la fecha desde no ha ingrasado ning�n valor o el formato no es correcto. Ej:(DD-MM-AAAA).";
					return mensaje;				
				}
			}catch (Exception e) {
				mensaje = "Error en la validaci�n de Fecha Vencimiento de la Tarjeta";
				return mensaje;
			}
			
		return mensaje;
	}
	public String validarDatosLargaDistancia (MinutosLdiInDTO parametro){
		String mensaje = null;
		Util vp = new Util();
		Fecha validaFecha = new Fecha();
		
		try{
			if(parametro == null){
				mensaje = "Problema con el ingreso de datos";
				return mensaje;
			}
			if(!vp.esLong(parametro.getNumeroTelefono()+"")){
				mensaje = "Debe ingresar un N�mero de Tel�fono v�lido";
				return mensaje;
			}
			if(parametro.getNumeroTelefono()== 0){
				mensaje = "El N�mero de Tel�fono ingresado debe ser distinto de cero";
				return mensaje;
			}
			
		} catch (Exception e) {
			mensaje = "Error en la validaci�n de los datos";
			return mensaje;
		}

			try{
				if(parametro.getFecDesde() != null && (parametro.getFecDesde().trim()).equals("")){
					mensaje = "Debe ingresar el campo FECHA_DESDE.";
					return mensaje;				
				}
				if(!validaFecha.esFecha(parametro.getFecDesde())){
					mensaje = "En el campo FECHA_DESDE no ha ingrasado ning�n valor o el formato no es correcto. Ej:(DD-MM-AAAA).";
					return mensaje;				
				}
				if(parametro.getFecHasta() != null && (parametro.getFecHasta().trim()).equals("")){
					mensaje = "Debe ingresar el campo FECHA_HASTA.";
					return mensaje;				
				}
				if(!validaFecha.esFecha(parametro.getFecHasta())){
					mensaje = "En el campo FECHA_HASTA no ha ingrasado ning�n valor o el formato no es correcto. Ej:(DD-MM-AAAA).";
					return mensaje;				
				}
			}catch (Exception e) {
				mensaje = "Error en la validaci�n de Fecha Vencimiento de la Tarjeta";
				return mensaje;
			}
			
		return mensaje;
	}
	public String consultarDatosRenovacion(NumeroTelefonoDTO parametro){
		String mensaje = null;
		Util vp = new Util();
		try{
			if(parametro == null){
				mensaje = "Debe ingresar un dato distinto de null";
				return mensaje;
			}
			if(!vp.esLong(parametro.getNumeroTelefono()+"")){
				mensaje = "Debe ingresar un N�mero de Tel�fono v�lido (num�rico)";
				return mensaje;
			}
			if(parametro.getNumeroTelefono()== 0){
				mensaje = "El N�mero de Tel�fono ingresado debe ser distinto de cero";
				return mensaje;
			}
			
		} catch (Exception e) {
			mensaje = "Error en la validaci�n de los datos";
			return mensaje;
			
		}
		return mensaje;
	}	
}