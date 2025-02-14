/**
 * Copyright © 2007 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 19/01/2007     Héctor Hermosilla      					Versión Inicial
 */

package com.tmmas.cl.scl.customerdomain.businessobject.bo;

import java.io.IOException;

import org.apache.log4j.Category;

import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.CargoLaboralDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ClasificacionDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ClienteAltaDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.DatosClienteBuroDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.MensajePromocionalDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.OperadoraDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ProfesionDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ReferenciaClienteDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ValorClasificacionDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.exception.AltaClienteException;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosValidacionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ResultadoValidacionVentaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.VentasException;
import com.tmmas.cl.scl.customerdomain.businessobject.dao.ClienteDAO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.AbonadoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.BusquedaClienteDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.CategoriaCambioClienteDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.CategoriaCambioDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.ClienteDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.ContratoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.DatosAnexoTerminalesDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.DatosContrato;
import com.tmmas.cl.scl.customerdomain.businessobject.helper.Global;
import com.tmmas.cl.scl.direccioncommon.commonapp.dto.DirecClienteDTO;
import com.tmmas.cl.scl.direccioncommon.commonapp.dto.DirecClienteListDTO;

public class Cliente extends CustomerAccount
{
	private ClienteDAO clienteDAO = new ClienteDAO();

	private static Category cat = Category.getInstance(Cliente.class);

	Global global = Global.getInstance();

	/**
	 * Obtiene Datos del Cliente
	 * 
	 * @param cliente
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public ClienteDTO getCliente(ClienteDTO cliente)
		throws CustomerDomainException
	{
		ClienteDTO resultado = null;
		cat.debug("getCliente():start");
		resultado = clienteDAO.getCliente(cliente);
		cat.debug("getCliente():end");
		return resultado;
	}

	/**
	 * Valida si existe el Cliente
	 * 
	 * @param entrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public ResultadoValidacionVentaDTO existeCliente(ParametrosValidacionDTO entrada) 
		throws CustomerDomainException
	{
		ResultadoValidacionVentaDTO resultado = new ResultadoValidacionVentaDTO();
		cat.debug("existeCliente():start");
		resultado = clienteDAO.getExisteCliente(entrada);
		if (resultado.getResultadoBase() == 1)
		{
			resultado.setResultado(true);
		}
		else if (resultado.getResultadoBase() == 0)
		{
			resultado.setResultado(false);
		}
		cat.debug("existeCliente():end");
		return resultado;
	}

	/**
	 * Busca listado de contratos realizado al cliente
	 * 
	 * @param cliente
	 * @return contrato
	 * @throws CustomerDomainException
	 */
	public ContratoDTO listadoContratosCliente(ContratoDTO contrato) 
		throws CustomerDomainException
	{
		ContratoDTO resultado = new ContratoDTO();
		cat.debug("listadoContratosCliente():start");
		resultado = clienteDAO.getContratoCliente(contrato);
		cat.debug("listadoContratosCliente():end");
		return resultado;
	}

	/**
	 * Verifica si el cliente es agente comercial
	 * 
	 * @param parametrosValidacionVentas
	 * @return contrato
	 * @throws CustomerDomainException
	 */

	public ResultadoValidacionVentaDTO clienteAgenteComercial(ParametrosValidacionDTO parametrosValidacionVentas)
			throws CustomerDomainException
	{
		ResultadoValidacionVentaDTO resultado = null;
		cat.debug("Inicio:clienteAgenteComercial");
		resultado = clienteDAO.getValidaClienteAgenteComercial(parametrosValidacionVentas);
		if (resultado.getResultadoBase() == 1)
		{
			resultado.setResultado(true);
		}
		else if (resultado.getResultadoBase() == 0)
		{
			resultado.setResultado(false);
		}
		cat.debug("Fin:clienteAgenteComercial");
		return resultado;
	}

	/**
	 * Busca plan Comercial asociado al Cliente
	 * 
	 * @param cliente
	 * @return resultado
	 * @throws CustomerDomainException
	 */

	public ClienteDTO getPlanComercial(ClienteDTO cliente) 
		throws CustomerDomainException
	{
		ClienteDTO resultado = new ClienteDTO();
		cat.debug("Inicio:getPlanComercial");
		resultado = clienteDAO.getPlanComercial(cliente);
		cat.debug("Fin:getPlanComercial");
		return resultado;
	}

	/**
	 * Busca categoria tributaria asociada al Cliente
	 * 
	 * @param cliente
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public ClienteDTO getCategoriaTributariaCliente(ClienteDTO cliente) 
		throws CustomerDomainException
	{
		ClienteDTO resultado = new ClienteDTO();
		cat.debug("Inicio:getCategoriaTributariaCliente");
		resultado = clienteDAO.getCategoriaTributariaCliente(cliente);
		cat.debug("Fin:getCategoriaTributariaCliente");
		return resultado;
	}

	/**
	 * Obtiene listado subcategorias impositivas
	 * 
	 * @param cliente
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public ClienteDTO[] getListSubCategImpos(ClienteDTO cliente)
		throws CustomerDomainException
	{
		cat.debug("Inicio:getListSubCategImpos");
		ClienteDTO[] resultado = clienteDAO.getListSubCategImpos(cliente);
		cat.debug("Fin:getListSubCategImpos");
		return resultado;
	}// fin getListSubCategImpos

	/**
	 * Obtiene categorias del cliente
	 * 
	 * @param N/A
	 * @return clienteDTO[]
	 * @throws CustomerDomainException
	 */
	public ClienteDTO[] getListCategImpositivas() 
		throws CustomerDomainException
	{
		cat.debug("Inicio:getListCategImpositivas()");
		ClienteDTO[] resultado = clienteDAO.getListCategImpositivas();
		cat.debug("Fin:getListCategImpositivas()");
		return resultado;
	}// fin getListCategImpositivas


	/**
	 * Obtiene relacion cliente vendedor
	 * 
	 * @param cliente
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public ClienteDTO getClienteVendedor(ClienteDTO cliente) 
		throws CustomerDomainException
	{
		cat.debug("Inicio:getClienteVendedor()");
		ClienteDTO resultado = clienteDAO.getClienteVendedor(cliente);
		cat.debug("Fin:getClienteVendedor()");
		return resultado;
	}// fin getClienteVendedor

	/**
	 * Obtiene codigo de la nueva empresa
	 * 
	 * @param entrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public ClienteDTO getCodigoNuevaEmpresa(ClienteDTO entrada) 
		throws CustomerDomainException
	{
		cat.debug("Inicio:getCodigoNuevaEmpresa()");
		ClienteDTO resultado = clienteDAO.getCodigoNuevaEmpresa();
		cat.debug("Fin:getCodigoNuevaEmpresa()");
		return resultado;
	}// fin getCodigoNuevaEmpresa

	/**
	 * Obtiene nuevo codigo de cliente
	 * 
	 * @param N/A
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public ClienteDTO getNuevoCliente() 
		throws CustomerDomainException
	{
		cat.debug("Inicio:getNuevoCliente()");
		ClienteDTO resultado = clienteDAO.getNuevoCliente();
		cat.debug("Fin:getNuevoCliente()");
		return resultado;
	}// fin getNuevoCliente

	/**
	 * Inserta cliente
	 * 
	 * @param cliente
	 * @return N/A
	 * @throws CustomerDomainException
	 */
	/*
	 * public void insCliente(ClienteDTO cliente) throws CustomerDomainException {
	 * cat.debug("Inicio:insCliente()");
	 *  // Inserta cliente nuevo clienteDAO.insCliente(cliente);
	 *  // Ini. MA 72269 3-11-2008 if (cliente.getTipoPlanDestino()!=null ){
	 * cat.debug("Inicio:getTipoPlanDestino()");
	 * clienteDAO.insSegmentacion(cliente); } // Fin MA 72269 3-11-2008
	 *  // Crea registro de modificacion de cliente
	 * cat.debug("Inicio:setModificacionCliente()");
	 * clienteDAO.setModificacionCliente(cliente);
	 *  // Crea registro con categoria tributaria del cliente
	 * cat.debug("Inicio:insCategTributCliente()");
	 * clienteDAO.insCategTributCliente(cliente);
	 *  // Crea registro con categoria impositiva del cliente
	 * cat.debug("Inicio:insCategImposCliente()");
	 * clienteDAO.insCategImposCliente(cliente);
	 *  // Crea registro con plan comercial del cliente
	 * cat.debug("Inicio:setClientePlanComercial()");
	 * clienteDAO.setClientePlanComercial(cliente);
	 *  // Crea registro con responsables del cliente if
	 * (cliente.getRepresentanteLegalDTO()!=null ){ for (int i=0;i<cliente.getRepresentanteLegalDTO().length;i++) {
	 * if (cliente.getRepresentanteLegalDTO()[i]!=null){
	 * cat.debug("Inicio:setClientePlanComercial()");
	 * cliente.setNumeroOrdenRepresentanteLegal(i+1);//Cambio
	 * clienteDAO.setResponsablesDelCliente(cliente); } } }
	 *  // Crea registro con secuencia de despacho
	 * cat.debug("Inicio:insSecDespachoCliente()");
	 * clienteDAO.insSecDespachoCliente(cliente);
	 *  // Crea registros con direcciones del cliente
	 * cat.debug("Inicio:insDireccionCliente()");
	 * clienteDAO.insDireccionCliente(cliente);
	 *  // Actualiza fecha de consulta de direccion del cliente a Computec
	 * //Este codigo no se utiliza en GUATEMALA - EL SALVADOR /*if (
	 * cliente.getDirecciones()!=null ){ for (int i=0; i<cliente.getDirecciones().length;
	 * i++){ if (cliente.getDirecciones()[i]!=null &&
	 * cliente.getDirecciones()[i].isLlamadaServicioComputec() ){ int
	 * tipoDireccion = cliente.getDirecciones()[i].getTipo();
	 * clienteDAO.actualizaFechaConsultaComputec(cliente,tipoDireccion);
	 * cat.debug("Inicio:actualizaFechaConsultaComputec()"); break; } } }
	 */

	// cat.debug("Fin:insCliente()");
	// }//fin insCliente*/

	/**
	 * Inserta cliente para web service
	 * 
	 * @param cliente
	 * @return N/A
	 * @throws CustomerDomainException
	 */
	public void insClienteSrv(ClienteAltaDTO cliente) 
		throws CustomerDomainException
	{

		cat.debug("Inicio:insCliente()");

		// Inserta cliente nuevo
		clienteDAO.insCliente(cliente);

		// Crea registro de modificacion de cliente
		cat.debug("Inicio:setModificacionCliente()");
		clienteDAO.setModificacionCliente(cliente);

		// Crea registro con categoria tributaria del cliente
		cat.debug("Inicio:insCategTributCliente()");
		clienteDAO.insCategTributCliente(cliente);

		// Crea registro con categoria impositiva del cliente
		cat.debug("Inicio:insCategImposCliente()");
		clienteDAO.insCategImposCliente(cliente);

		// Crea registro con plan comercial del cliente
		cat.debug("Inicio:setClientePlanComercial()");
		clienteDAO.setClientePlanComercial(cliente);

		// Crea registro con responsables del cliente
		if (cliente.getRepresentanteLegalComDTO() != null)
		{
			for (int i = 0; i < cliente.getRepresentanteLegalComDTO().length; i++)
			{
				if (cliente.getRepresentanteLegalComDTO()[i] != null)
				{
					cliente.setNumeroOrdenRepresentanteLegal(i + 1);
					clienteDAO.setResponsablesDelCliente(cliente);
				}
			}
		}
		// Crea registro con secuencia de despacho
		cat.debug("Inicio:insSecDespachoCliente()");
		clienteDAO.insSecDespachoCliente(cliente);
		// Crea registros con direcciones del cliente
		cat.debug("Inicio:insDireccionCliente()");
		clienteDAO.insDireccionCliente(cliente);

		// Cliente empresa
		if (cliente.getCodigoTipoCliente().trim().equals(global.getValor("indicador.tipo.cliente.empresa"))||
				cliente.getCodigoTipoCliente().trim().equals(global.getValor("indicador.tipo.cliente.pyme")))
		{
			cat.debug("Inicio:insEmpresa()");
			clienteDAO.insEmpresa(cliente);
		}
		//Inicio P-CSR-11002 JLGN 26-04-2011 RMS-003 Despliegue de parámetros en la Creación del Cliente
		cat.debug("Inicio:insDatosRedSocial()");
		clienteDAO.insDatosRedSocial(cliente);
		
		cat.debug("INC-184210 25-05-2012");
		//if (cliente.getEnvioFacturaFisica().equals("1")){
			cat.debug("Inicio:insEnvioFacturaFisica()");
			cat.debug("cliente.getEnvioFacturaFisica()"+cliente.getEnvioFacturaFisica());
			
			clienteDAO.insEnvioFacturaFisica(cliente);
			//cat.debug("INC-184210");
		
		//}
		cat.debug("INC-184210 25-07-2012");
		//Fin P-CSR-11002 JLGN 26-04-2011		
		
		cat.debug("Fin:insCliente()");
	}// fin insCliente

	/**
	 * Actualiza categoria del cliente
	 * 
	 * @param cliente
	 * @return N/A
	 * @throws CustomerDomainException
	 */
	public void updCategCliente(ClienteDTO cliente) 
		throws CustomerDomainException
	{
		cat.debug("Inicio:updCategCliente()");
		clienteDAO.updCategCliente(cliente);
		cat.debug("Fin:updCategCliente()");
	}// fin updCategCliente

	/**
	 * Actualiza categoria de los clientes asociados a una cuenta
	 * 
	 * @param cliente
	 * @return N/A
	 * @throws CustomerDomainException
	 */
	public void actualizaCategoriasClientes(ClienteDTO cliente) 
		throws CustomerDomainException
	{
		cat.debug("Inicio:actualizaCategoriasClientes()");
		clienteDAO.actualizaCategoriasClientes(cliente);
		cat.debug("Fin:actualizaCategoriasClientes()");
	}// fin actualizaCategoriasClientes

	/**
	 * Actualiza codigo uso de los clientes asociados a una cuenta
	 * 
	 * @param cliente
	 * @return N/A
	 * @throws CustomerDomainException
	 */
	public void actualizaCodigoUsoClientes(ClienteDTO cliente)
		throws CustomerDomainException
	{
		cat.debug("Inicio:actualizaCategoriasClientes()");
		clienteDAO.actualizaCodigoUsoClientes(cliente);
		cat.debug("Fin:actualizaCategoriasClientes()");
	}// fin actualizaCodigoUsoClientes

	/**
	 * Actualiza subcategoria impositiva del cliente por la subcategoria de la
	 * cuenta} en base al resultado del analisis de categoria de la cuenta
	 * realizado en la alta del cliente.
	 * 
	 * @param cliente
	 * @return N/A
	 * @throws CustomerDomainException
	 */

	public void actualizaSubCategoriaImpositiva(ClienteDTO clienteDTO) 
		throws CustomerDomainException
	{
		cat.debug("Inicio:actualizaSubCategoriaImpositiva()");
		clienteDAO.actualizaSubCategoriaImpositiva(clienteDTO);
		cat.debug("Fin:actualizaSubCategoriaImpositiva()");
	}// fin actualizaSubCategoriaImpositiva

	/**
	 * Obtiene Datos del Cliente tipo empresa
	 * 
	 * @param cliente
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public ClienteDTO getDatosEmpresa(ClienteDTO clienteDTO) 
		throws CustomerDomainException
	{
		ClienteDTO resultado = null;
		cat.debug("getDatosEmpresa():start");
		resultado = clienteDAO.getDatosEmpresa(clienteDTO);
		cat.debug("getDatosEmpresa():end");
		return resultado;
	}

	/**
	 * Obtine plaza del cliente
	 * 
	 * @param clienteDTO
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public ClienteDTO ObtienePlazaCliente(ClienteDTO cliente) 
		throws CustomerDomainException
	{
		ClienteDTO resultado = null;
		cat.debug("ObtienePlazaCliente():start");
		resultado = clienteDAO.ObtienePlazaCliente(cliente);
		cat.debug("ObtienePlazaCliente():end");
		return resultado;
	}// fin ObtienePlazaCliente

	public DirecClienteListDTO obtenerDireccionCliente(DirecClienteDTO direcClienteDTO) 
		throws CustomerDomainException
	{
		cat.debug("obtenerDireccionCliente():start");
		DirecClienteListDTO direccionesListDTO = clienteDAO.obtenerDireccionCliente(direcClienteDTO);
		cat.debug("obtenerDireccionCliente():end");
		return direccionesListDTO;
	}

	/**
	 * Servicios Activaciones WEB - Colombia Obtine datos del cliente
	 * 
	 * @param clienteDTO
	 *            (entrada)
	 * @return clienteDTO (resultado)
	 * @throws CustomerDomainException
	 *             wjrc - Agosto 2007
	 */
	public ClienteDTO[] getDatosCliente(BusquedaClienteDTO entrada) 
		throws CustomerDomainException
	{
		ClienteDTO[] resultado = null;
		cat.debug("getDatosCliente():start");
		resultado = clienteDAO.getDatosCliente(entrada);
		cat.debug("getDatosCliente():end");
		return resultado;
	}// fin getDatosCliente

	/**
	 * Obtiene codigo de la nueva empresa
	 * 
	 * @param entrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public String getCodigoOperadoraCliente() 
		throws CustomerDomainException
	{
		cat.debug("Inicio:getCodigoOperadoraCliente()");
		String resultado = clienteDAO.getCodigoOperadoraCliente();
		cat.debug("Fin:getCodigoOperadoraCliente()");
		return resultado;
	}// fin getCodigoNuevaEmpresa

	// Ini. Inc. 71895 10-11-2008
	/**
	 * Valida Numero de Identificacion
	 * 
	 * @param entrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public boolean validarNumeroIdentificacion(ClienteDTO cliente) 
		throws CustomerDomainException
	{
		boolean resultado = false;
		cat.debug("validarNumeroIdentificacion():start");
		resultado = clienteDAO.validarNumeroIdentificacion(cliente);
		cat.debug("validarNumeroIdentificacion():end");
		return resultado;
		// Fin Inc. 71895 10-11-2008
	}

	// Ini. Inc. 72637 17-11-2008
	/**
	 * Obtiene ciclo de facturacion por defecto
	 * 
	 * @param
	 * @return String
	 * @throws CustomerDomainException
	 */
	public String obtenerCicloDefault() 
		throws CustomerDomainException
	{
		String resultado = "";
		cat.debug("obtenerCicloDefault():start");
		resultado = clienteDAO.obtenerCicloDefault();
		cat.debug("obtenerCicloDefault():end");
		return resultado;
	}

	// Fin Inc. 72637 17-11-2008

	public void crearClienteFacturaImprimible(ClienteAltaDTO entrada) 
		throws CustomerDomainException
	{
		cat.debug("crearClienteFacturaImprimible():start");
		clienteDAO.crearClienteFacturaImprimible(entrada);
		cat.debug("crearClienteFacturaImprimible():end");
	}

	public void insMontoPreautorizado(ClienteAltaDTO entrada) 
		throws CustomerDomainException
	{
		cat.debug("insMontoPreautorizado():start");
		clienteDAO.insMontoPreautorizado(entrada);
		cat.debug("insMontoPreautorizado():end");
	}

	public OperadoraDTO[] getOperadoras() 
		throws CustomerDomainException
	{
		cat.debug("getOperadoras():start");
		OperadoraDTO[] resultado = clienteDAO.getOperadoras();
		cat.debug("getOperadoras():end");
		return resultado;
	}

	public ProfesionDTO[] getProfesiones() 
		throws CustomerDomainException
	{
		cat.debug("getProfesiones():start");
		ProfesionDTO[] resultado = clienteDAO.getProfesiones();
		cat.debug("getProfesiones():end");
		return resultado;
	}

	public CargoLaboralDTO[] getCargosLaborales() 
		throws CustomerDomainException
	{
		cat.debug("getCargosLaborales():start");
		CargoLaboralDTO[] resultado = clienteDAO.getCargosLaborales();
		cat.debug("getCargosLaborales():end");
		return resultado;
	}

	public void insEmpresa(ClienteAltaDTO cliente) 
		throws CustomerDomainException
	{
		cat.debug("insEmpresa():start");
		clienteDAO.insEmpresa(cliente);
		cat.debug("insEmpresa():end");
	}

	public void insDescCliBolsaDinamica(ClienteDTO cliente) 
		throws CustomerDomainException
	{
		cat.debug("insDescCliBolsaDinamica():start");
		clienteDAO.insDescCliBolsaDinamica(cliente);
		cat.debug("insDescCliBolsaDinamica():end");
	}

	public void insReferenciaCliente(ReferenciaClienteDTO entrada) 
		throws CustomerDomainException
	{
		cat.debug("insReferenciaCliente():start");
		clienteDAO.insReferenciaCliente(entrada);
		cat.debug("insReferenciaCliente():end");
	}

	public boolean validarTelefonoReferencia(String telefono, String tipo) 
		throws CustomerDomainException
	{
		boolean r = false;
		cat.debug("Inicio");
		r = clienteDAO.validarTelefonoReferencia(telefono, tipo);
		cat.debug("Fin");
		return r;
	}

	public Integer consultaVentasCliente(Long codCliente) 
		throws CustomerDomainException
	{
		cat.debug("consultaVentasCliente():start");
		Integer resultado = clienteDAO.consultaVentasCliente(codCliente);
		cat.debug("consultaVentasCliente():end");
		return resultado;
	}
	
	public ClasificacionDTO[] getClasificaciones() 
		throws CustomerDomainException
	{
		cat.debug("getClasificaciones():start");
		ClasificacionDTO[] resultado = clienteDAO.getClasificaciones();
		cat.debug("getClasificaciones():end");
		return resultado;		
	}
	
	public ValorClasificacionDTO[] getCalificaciones() 
		throws CustomerDomainException
	{
		cat.debug("getCalificaciones():start");
		ValorClasificacionDTO[] resultado = clienteDAO.getCalificaciones();
		cat.debug("getCalificaciones():end");
		return resultado;	
	}
	
	public ValorClasificacionDTO[] getCrediticia() 
		throws CustomerDomainException
	{
		cat.debug("getCrediticia():start");
		ValorClasificacionDTO[] resultado = clienteDAO.getCrediticia();
		cat.debug("getCrediticia():end");
		return resultado;	
	}
	
	public ValorClasificacionDTO[] getColores() 
		throws CustomerDomainException
	{
		cat.debug("getColores():start");
		ValorClasificacionDTO[] resultado = clienteDAO.getColores();
		cat.debug("getColores():end");
		return resultado;	
	}	
	
	public ValorClasificacionDTO[] getSegmentos(String codTipoCliente)	
		throws CustomerDomainException
	{
		cat.debug("getSegmentos():start");
		ValorClasificacionDTO[] resultado = clienteDAO.getSegmentos(codTipoCliente);
		cat.debug("getSegmentos():end");
		return resultado;	
	}	
	
	public ValorClasificacionDTO[] getCategorias() 
		throws CustomerDomainException
	{
		cat.debug("getCategorias():start");
		ValorClasificacionDTO[] resultado = clienteDAO.getCategorias();
		cat.debug("getCategorias():end");
		return resultado;	
	}	
	
	public CategoriaCambioDTO[] getCategoriasCambio() 
		throws CustomerDomainException
	{
		cat.debug("getCategoriasCambio():start");
		CategoriaCambioDTO[] resultado = clienteDAO.getCategoriasCambio();
		cat.debug("getCategoriasCambio():end");
		return resultado;		
	}
	
	public void insCategoriaCambioCliente(CategoriaCambioClienteDTO categCambioCliente) 
		throws CustomerDomainException
	{
		cat.debug("getCategoriasCambio():start");
		clienteDAO.insCategoriaCambioCliente(categCambioCliente);
		cat.debug("getCategoriasCambio():end");
	}

	/**
	 * @author JIB
	 * @param numIdent
	 * @param codTipIdent
	 * @return
	 * @throws CustomerDomainException
	 */
	public Boolean validaClienteLN(String numIdent, String codTipIdent) throws CustomerDomainException {
		cat.debug("Inicio");
		Boolean r = clienteDAO.validaClienteLN(null, numIdent, codTipIdent);
		cat.debug("Fin");
		return r;
	}
	
	/**
	 * @author JIB
	 * @param codCliente
	 * @return
	 * @throws CustomerDomainException
	 */
	public Boolean validaClienteLN(String codCliente) throws CustomerDomainException {
		cat.debug("Inicio");
		Boolean r = clienteDAO.validaClienteLN(codCliente, null, null);
		cat.debug("Fin");
		return r;
	}
	
	public boolean validarTelefonoLDI(String telefono) throws CustomerDomainException {
		boolean r = false;
		cat.debug("validarTelefonoLDI, Inicio");
		r = clienteDAO.validarTelefonoLDI(telefono);
		cat.debug("validarTelefonoLDI, Fin");
		return r;
	}
	
	public boolean verificaPrestacionCliente(Long codCliente, String codPrestacion) throws CustomerDomainException {
		boolean r = false;
		cat.debug("verificaPrestacionCliente, Inicio");
		r = clienteDAO.verificaPrestacionCliente(codCliente, codPrestacion);
		cat.debug("verificaPrestacionCliente, Fin");
		return r;
	}
	
	public void updIngresosMensualesCliente(ClienteDTO cliente) 
		throws CustomerDomainException
	{
		cat.debug("updIngresosMensualesCliente():start");
		clienteDAO.updIngresosMensualesCliente(cliente);
		cat.debug("updIngresosMensualesCliente():end");
	}
	
	//Inicio P-CSR-11002 JLGN 04-05-2011 
	public DatosClienteBuroDTO consultaBuro(String url, String tipIdent) throws AltaClienteException, IOException, Exception {
		cat.debug("consultaBuro():start");
		DatosClienteBuroDTO resultado = clienteDAO.consultaBuro(url, tipIdent);
		cat.debug("consultaBuro():end");
		return resultado;	
	}
	//Fin P-CSR-11002 JLGN 04-05-2011
	//Inicio P-CSR-11002 JLGN 06-05-2011 
	public void insertaClienteBuro(DatosClienteBuroDTO clienteBuroDTO, String usuario) throws AltaClienteException, IOException, Exception {
		cat.debug("insertaClienteBuro():start");
		clienteDAO.insertaClienteBuro(clienteBuroDTO, usuario);
		cat.debug("insertaClienteBuro():end");
		
		if (clienteBuroDTO.getTipoNombramientoDTO() != null){
			cat.debug("Cantidad de Nombramiento Buro ["+clienteBuroDTO.getTipoNombramientoDTO().length+"]");		
			for(int i=0; i < clienteBuroDTO.getTipoNombramientoDTO().length;i++){
				cat.debug("Nombramiento Buro Nº["+(i+1)+"]");
				cat.debug("insertaNombramientoBuro():start");
				clienteDAO.insertaNombramientoBuro(clienteBuroDTO.getTipoNombramientoDTO()[i], clienteBuroDTO.getKeyRef());
				cat.debug("insertaNombramientoBuro():end");
			}
		}
		
		if (clienteBuroDTO.getDatosLaboralHist() != null){
			cat.debug("Cantidad de Datos Laboral Historico Buro ["+clienteBuroDTO.getDatosLaboralHist().length+"]");		
			for(int i=0; i < clienteBuroDTO.getDatosLaboralHist().length;i++){
				cat.debug("Historico Laboral Buro Nº["+(i+1)+"]");
				cat.debug("insertaHistLaboralBuro():start");
				clienteDAO.insertaHistLaboralBuro(clienteBuroDTO.getDatosLaboralHist()[i], clienteBuroDTO.getKeyRef());
				cat.debug("insertaHistLaboralBuro():end");
			}
		}
		
		if (clienteBuroDTO.getHijosCliente() != null){
			cat.debug("Cantidad de Hijos Cliente Buro ["+clienteBuroDTO.getHijosCliente().length+"]");		
			for(int i=0; i < clienteBuroDTO.getHijosCliente().length;i++){
				cat.debug("Hijo Cliente Buro Nº["+(i+1)+"]");
				cat.debug("insertaHijosClienteBuro():start");
				clienteDAO.insertaHijosClienteBuro(clienteBuroDTO.getHijosCliente()[i], clienteBuroDTO.getKeyRef());
				cat.debug("insertaHijosClienteBuro():end");
			}
		}
		//P-CSR-11002 JLGN 15-06-2011
		//Se Obtiene el codigo de la comuna
		//P-CSR-11002 JLGN 15-07-2011
		if(!(clienteBuroDTO.getCodProvincia() == null) && !(clienteBuroDTO.getCodCanton() == null) && !(clienteBuroDTO.getCodDistrito() == null) ){
			if(!clienteBuroDTO.getCodProvincia().equals("") && !clienteBuroDTO.getCodCanton().equals("") &&!clienteBuroDTO.getCodDistrito().equals("")){
				cat.debug("Los Datos no son vacios");
				cat.debug("Se obtiene el codigo de la comuna");
				clienteDAO.getComunaDireccionBuro(clienteBuroDTO);			
			}		
			
			//Se obtienen la Descripcion de la provincia, canton y distrito		
			if (!clienteBuroDTO.getCodProvincia().equals("") && !clienteBuroDTO.getCodCanton().equals("") &&!clienteBuroDTO.getCodDistrito().equals("")){
				cat.debug("Los Datos no son vacios");
				clienteDAO.getDatosDireccionBuro(clienteBuroDTO);			
			}
		}else{
			clienteBuroDTO.setCodProvincia("");
			clienteBuroDTO.setCodCanton("");
			clienteBuroDTO.setCodDistrito("");
		}	
	}
	//Fin P-CSR-11002 JLGN 06-05-2011

	//Inicio P-CSR-11002 JLGN 16-05-2011	
	/**
	 * Valida Password Calificacion
	 * 
	 * @param String
	 * @return boolean
	 * @throws CustomerDomainException
	 */
	public boolean validaPassClasificacion(String passCalificacion) throws CustomerDomainException{
		boolean resultado = true;
		cat.debug("validaPassClasificacion():start");
		resultado = clienteDAO.validaPassClasificacion(passCalificacion);
		cat.debug("validaPassClasificacion():end");
		return resultado;
	}
	//Fin P-CSR-11002 JLGN 16-05-2011
	
	//Inicio P-CSR-11002 JLGN 16-05-2011	
	/**
	 * Inserta Excepcion Calificacion
	 * 
	 * @param String
	 * @return N/A
	 * @throws CustomerDomainException
	 */
	public void insExcepcioCalificacion(String codCliente, String codPlanTarif, String nomUserOra, String codPass, String limiteCredito) throws CustomerDomainException{
		cat.debug("insExcepcioCalificacion():start");
		clienteDAO.insExcepcioCalificacion(codCliente, codPlanTarif, nomUserOra, codPass, limiteCredito);
		cat.debug("insExcepcioCalificacion():end");
	}
	//Fin P-CSR-11002 JLGN 16-05-2011
	
	//Inicio P-CSR-11002 JLGN 26-05-2011	
	/**
	 * Inserta Excepcion Calificacion
	 * 
	 * @param String
	 * @return N/A
	 * @throws CustomerDomainException
	 */
	public DatosContrato datosCliente(DatosContrato datosContrato) throws CustomerDomainException{
		DatosContrato resultado = null;
		cat.debug("datosCliente():start");
		resultado = clienteDAO.datosCliente(datosContrato);
		cat.debug("datosCliente():end");
		return resultado;
	}
	//Fin P-CSR-11002 JLGN 26-05-2011
	
	//Inicio P-CSR-11002 JLGN 17-06-2011	
	/**
	 * Inserta Excepcion Calificacion
	 * 
	 * @param String
	 * @return N/A
	 * @throws CustomerDomainException
	 */
	public DatosContrato datosLinea(DatosContrato datosContrato) throws CustomerDomainException{
		DatosContrato resultado = null;
		cat.debug("datosLinea():start");
		resultado = clienteDAO.datosLinea(datosContrato);
		cat.debug("datosLinea():end");
		return resultado;
	}
	//Fin P-CSR-11002 JLGN 17-06-2011
	
	//Inicio P-CSR-11002 JLGN 01-07-2011	
	public long obtineLimConsuCliente(String numIdent, String tipIdent) throws VentasException, CustomerDomainException{
		long resultado = 0;
		cat.debug("obtineLimConsuCliente():start");
		resultado = clienteDAO.obtineLimConsuCliente(numIdent, tipIdent);
		cat.debug("obtineLimConsuCliente():end");
		return resultado;
	}
	//Fin P-CSR-11002 01-07-2011
	
	//Inicio P-CSR-11002 JLGN 05-08-2011	
	public MensajePromocionalDTO[] getMensajePromocional() throws CustomerDomainException
	{
		cat.debug("getMensajePromocional():start");
		MensajePromocionalDTO[] resultado = clienteDAO.getMensajePromocional();
		cat.debug("getMensajePromocional():end");
		return resultado;	
	}
	//Inicio P-CSR-11002 JLGN 05-08-2011
	//Inicio P-CSR-11002 JLGN 20-10-2011
	public DatosContrato limiteConsumoXLinea(DatosContrato datosContrato) throws CustomerDomainException{
		DatosContrato resultado = null;
		cat.debug("limiteConsumoXLinea():start");
		resultado = clienteDAO.limiteConsumoXLinea(datosContrato);
		cat.debug("limiteConsumoXLinea():end");
		return resultado;		
	}
	//Fin P-CSR-11002 JLGN 20-10-2011
	
	//Inicio Inc.179734 JLGN 04-01-2012
	public boolean validaClienteDDA(String codCliente) throws VentasException, CustomerDomainException{
		cat.debug("validaClienteDDA():start");
		boolean resultado = clienteDAO.validaClienteDDA(codCliente);
		cat.debug("validaClienteDDA():end");
		return resultado;		
	}
	//Fin Inc.179734 JLGN 04-01-2012
	
	//Inicio Inc.179734 JLGN 05-01-2012
	public boolean validaLineasClienteDDA(String tipIdent, String numIdent) throws VentasException, CustomerDomainException{
		cat.debug("validaLineasClienteDDA():start");
		boolean resultado = clienteDAO.validaLineasClienteDDA(tipIdent, numIdent);
		cat.debug("validaLineasClienteDDA():end");
		return resultado;		
	}
	//Fin Inc.179734 JLGN 05-01-2012
	
//	Inicio MA-180654 HOM
	public AbonadoDTO[] getAbonadosActvos(String tipIdent, String numIdent) throws VentasException, CustomerDomainException{
		cat.debug("getAbonadosActvos():start");
		AbonadoDTO[] resultado = clienteDAO.getAbonadosActvos(tipIdent, numIdent);
		cat.debug("getAbonadosActvos():end");
		return resultado;	
	}
	public DatosAnexoTerminalesDTO getDatosAnexoTerminales(Long numVenta) throws VentasException, CustomerDomainException{
		cat.debug("getDatosAnexoTerminales():start");
		DatosAnexoTerminalesDTO resultado = clienteDAO.getDatosAnexoTerminales(numVenta);
		cat.debug("getDatosAnexoTerminales():end");
		return resultado;	
	}
//	Fin MA-180654 HOM	
}// fin CLASS Cliente
