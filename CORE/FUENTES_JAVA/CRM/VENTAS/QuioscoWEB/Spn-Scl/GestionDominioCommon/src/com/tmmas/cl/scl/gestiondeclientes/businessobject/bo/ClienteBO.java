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

package com.tmmas.cl.scl.gestiondeclientes.businessobject.bo;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.AbonadoActivoDTO;
import com.tmmas.cl.scl.gestiondeclientes.businessobject.dao.ClienteDAO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CategoriaCambioClienteDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CategoriaCambioDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ClasificacionCuentaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ClasificacionDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ClienteComDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ClienteDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ClienteImpDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CuentaComDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.FaMensProcesoDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.FaMensajesDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.GeModVentaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.PagosUltimosMesesDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ParametrosAnulacionVentaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ParametrosValidacionDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ResultadoValidacionVentaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.SucursalBancoDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ValorClasificacionDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WSValidarTarjetaOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsBancoInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsClienteIdentInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsContratoOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsInfoComercialClienteDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsLinkDocumentoInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsLinkDocumentoOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListBancoOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListClienteIdentOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListCuotaOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListModalidadPagoOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListPlanTarifarioOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListTarjetaOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListTipoPagoOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsValTarjetaInDTO;
import com.tmmas.cl.scl.gestiondeclietnes.businessobject.helper.Global;
import com.tmmas.scl.framework.productDomain.dataTransferObject.SuspensionAbonadoDTO;





public class ClienteBO {
	private ClienteDAO clienteDAO  = new ClienteDAO();
	private final Logger logger = Logger
	.getLogger(ClienteBO.class);
	
	Global global = Global.getInstance();	
	
	/**
	 *Obtiene Datos del Cliente
	 * 
	 * @param cliente
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public ClienteDTO getCliente(ClienteDTO cliente) throws GeneralException {
		ClienteDTO resultado = null;
		logger.debug("getCliente():start");
		resultado = clienteDAO.getCliente(cliente);
		logger.debug("getCliente():end");
		return resultado;
	}
	
	public CuentaComDTO getCliente(CuentaComDTO cuenta) throws GeneralException {
		CuentaComDTO resultado = null;
		logger.debug("getCliente():start");
		resultado = clienteDAO.getCliente(cuenta);
		logger.debug("resultado.getClienteComDTO().getCodigoPlanTarifario() ["+resultado.getClienteComDTO().getPlanTarifario());
		logger.debug("getCliente():end");
		return resultado;
	}

	/**
	 *Valida si existe el Cliente
	 * 
	 * @param entrada
	 * @return resultado
	 * @throws GeneralException
	 */
	public ResultadoValidacionVentaDTO existeCliente(ParametrosValidacionDTO entrada) throws GeneralException {
		ResultadoValidacionVentaDTO resultado = new ResultadoValidacionVentaDTO();
		logger.debug("existeCliente():start");
		resultado = clienteDAO.getExisteCliente(entrada);
		if (resultado.getResultadoBase() ==1){
			resultado.setResultado(true);
		}
		else if (resultado.getResultadoBase() ==0){
			resultado.setResultado(false);
		}
		logger.debug("existeCliente():end");
		return resultado;
	}
	/**
	 *Busca listado de contratos realizado al cliente
	 * 
	 * @param cliente
	 * @return contrato
	 * @throws GeneralException
	 */
	public WsContratoOutDTO listadoContratosCliente(WsContratoOutDTO contrato) throws GeneralException {
		WsContratoOutDTO resultado = new WsContratoOutDTO();
		logger.debug("listadoContratosCliente():start");
		resultado = clienteDAO.getContratoCliente(contrato);
		logger.debug("listadoContratosCliente():end");
		return resultado;
	}
	/**
	 *Verifica si el cliente es agente comercial
	 * 
	 * @param parametrosValidacionVentas
	 * @return contrato
	 * @throws GeneralException
	 */

	public ResultadoValidacionVentaDTO clienteAgenteComercial(ParametrosValidacionDTO parametrosValidacionVentas) throws GeneralException {
		ResultadoValidacionVentaDTO resultado = null;
		logger.debug("Inicio:clienteAgenteComercial");
		resultado = clienteDAO.getValidaClienteAgenteComercial(parametrosValidacionVentas);
		if (resultado.getResultadoBase() ==1){
			resultado.setResultado(true);
		}
		else if (resultado.getResultadoBase() ==0){
			resultado.setResultado(false);
		}
		logger.debug("Fin:clienteAgenteComercial");
		return resultado;
	}
	
	/**
	 *Busca plan Comercial asociado al Cliente
	 * 
	 * @param cliente
	 * @return resultado
	 * @throws GeneralException
	 */

	public ClienteDTO getPlanComercial(ClienteDTO cliente) throws GeneralException {

		ClienteDTO resultado = new ClienteDTO(); 
		logger.debug("Inicio:getPlanComercial");
		resultado = clienteDAO.getPlanComercial(cliente);
		logger.debug("Fin:getPlanComercial");
		return resultado;
	}
	
	/**
	 *Busca categoria tributaria asociada al Cliente
	 * 
	 * @param cliente
	 * @return resultado
	 * @throws GeneralException
	 */
	public ClienteDTO getCategoriaTributariaCliente(ClienteDTO cliente) throws GeneralException {
		ClienteDTO resultado = new ClienteDTO(); 
		logger.debug("Inicio:getCategoriaTributariaCliente");
		resultado = clienteDAO.getCategoriaTributariaCliente(cliente);
		logger.debug("Fin:getCategoriaTributariaCliente");
		return resultado;
	}

	/**
	 * Obtiene listado subcategorias impositivas
	 * @param cliente
	 * @return resultado
	 * @throws GeneralException
	 */
	public ClienteDTO[] getListSubCategImpos(ClienteDTO cliente) 
	throws GeneralException {
		logger.debug("Inicio:getListSubCategImpos");
		ClienteDTO[] resultado = clienteDAO.getListSubCategImpos(cliente);
		logger.debug("Fin:getListSubCategImpos");
		return resultado;
	}//fin getListSubCategImpos

	/**
	 * Obtiene categorias del cliente
	 * @param N/A
	 * @return clienteDTO[]
	 * @throws GeneralException
	 */
	public ClienteDTO[] getListCategImpositivas() throws GeneralException{
		logger.debug("Inicio:getListCategImpositivas()");
		ClienteDTO[] resultado = clienteDAO.getListCategImpositivas();
		logger.debug("Fin:getListCategImpositivas()");
		return resultado;
	}//fin getListCategImpositivas
	
	/**
	 * Obtiene categorias del cliente
	 * @param N/A
	 * @return clienteDTO[]
	 * @throws GeneralException
	 */
	public ClienteDTO[] getListCategorias() throws GeneralException{
		logger.debug("Inicio:getListCategorias()");
		ClienteDTO[] resultado = clienteDAO.getListCategorias();
		logger.debug("Fin:getListCategorias()");
		return resultado;
	}//fin getListCategorias	

	/**
	 * Obtiene relacion cliente vendedor
	 * @param cliente
	 * @return resultado
	 * @throws GeneralException
	 */
	public ClienteDTO getClienteVendedor(ClienteDTO cliente) 
	throws GeneralException{
		logger.debug("Inicio:getClienteVendedor()");
		ClienteDTO resultado = clienteDAO.getClienteVendedor(cliente);
		logger.debug("Fin:getClienteVendedor()");
		return resultado;		
	}//fin getClienteVendedor

	/**
	 * Obtiene codigo de la nueva empresa
	 * @param entrada
	 * @return resultado
	 * @throws GeneralException
	 */
	public ClienteDTO getCodigoNuevaEmpresa(ClienteDTO entrada) 
	throws GeneralException{
		logger.debug("Inicio:getCodigoNuevaEmpresa()");
		ClienteDTO resultado = clienteDAO.getCodigoNuevaEmpresa();
		logger.debug("Fin:getCodigoNuevaEmpresa()");
		return resultado;		
	}//fin getCodigoNuevaEmpresa

	/**
	 * Obtiene nuevo codigo de cliente
	 * @param N/A
	 * @return resultado
	 * @throws GeneralException
	 */
	public ClienteDTO getNuevoCliente() 
	throws GeneralException{
		logger.debug("Inicio:getNuevoCliente()");
		ClienteDTO resultado = clienteDAO.getNuevoCliente();
		logger.debug("Fin:getNuevoCliente()");
		return resultado;		
	}//fin getNuevoCliente

	/**
	 * Inserta cliente
	 * @param cliente
	 * @return N/A
	 * @throws GeneralException
	 */
	public void insCliente(CuentaComDTO cuenta) 
	throws GeneralException{
		
		logger.debug("Inicio:insCliente()");

		// Inserta cliente nuevo
		clienteDAO.insCliente(cuenta);

		// Crea registro de modificacion de cliente
		logger.debug("Inicio:setModificacionCliente()");
		clienteDAO.setModificacionCliente(cuenta.getClienteComDTO());

		// Crea registro con categoria tributaria del cliente
		logger.debug("Inicio:insCategTributCliente()");
		clienteDAO.insCategTributCliente(cuenta.getClienteComDTO());

		// Crea registro con categoria impositiva del cliente
		logger.debug("Inicio:insCategImposCliente()");
		clienteDAO.insCategImposCliente(cuenta.getClienteComDTO());

		// Crea registro con plan comercial del cliente
		logger.debug("Inicio:setClientePlanComercial()");
		clienteDAO.setClientePlanComercial(cuenta.getClienteComDTO());

		// Crea registro con responsables del cliente

		if (cuenta.getClienteComDTO().getRepresentanteLegalComDTO()!=null ){
			logger.debug("Inicio:setClientePlanComercial()");
			clienteDAO.setResponsablesDelCliente(cuenta.getClienteComDTO());
		}

		// Crea registro con secuencia de despacho 
		logger.debug("Inicio:insSecDespachoCliente()");
		clienteDAO.insSecDespachoCliente(cuenta.getClienteComDTO());
		
		// Crea registros con direcciones del cliente
		logger.debug("Inicio:insDireccionCliente()");
		clienteDAO.insDireccionCliente(cuenta.getClienteComDTO());

/*
		ClienteDTO clienteVendedorDTO = null;
		if (Boolean.getBoolean(global.getValor("migracion.supervisor.cliente"))){
			clienteVendedorDTO = ajustarValoresCliente(clienteBO,clienteDTO);
		}
		
		//Sistema registra cliente en tabla VE_VENDCLIE en el caso de que el cliente sea vendedor
		if (clienteVendedorDTO!=null){
			if (clienteVendedorDTO.getCodigoVendedor()>0){
				clienteDTO.setCodigoVendedor(clienteVendedorDTO.getCodigoVendedor());
				clienteBO.insVendCliente(clienteDTO);
			}
		}		

		// Crea registro con relacion cliente vendedor
		logger.debug("Inicio:insVendCliente()");
		clienteDAO.insVendCliente(cliente);

*/		
/*		if (cliente.getCodigoTipoCliente().equals(global.getValor("codigo.cliente.empresa"))){
			logger.debug("Inicio:insEmpresa()");
			clienteDAO.insEmpresa(cliente);
		}
*/
		if (cuenta.getClienteComDTO().getTipoPlanTarifario()!=null &&  
			!cuenta.getClienteComDTO().getTipoPlanTarifario().trim().equals("") &&
			(cuenta.getClienteComDTO().getTipoPlanTarifario().equals(global.getValor("codigo.tipoplan.empresa").trim()) ||
			 cuenta.getClienteComDTO().getTipoPlanTarifario().equals(global.getValor("codigo.tipoplan.familiar").trim()) && cuenta.getClienteComDTO().getTipoCliente().equals("E") ) 
		){
			logger.debug("Inicio:insEmpresa()");
			clienteDAO.insEmpresa(cuenta.getClienteComDTO());
		}
		
		logger.debug("Fin:insCliente()");		
	}//fin insCliente
	

	/**
	 * Actualiza categoria del cliente
	 * @param cliente
	 * @return N/A
	 * @throws GeneralException
	 */
	public void updCategCliente(ClienteDTO cliente) 
	throws GeneralException{
		logger.debug("Inicio:updCategCliente()");
		clienteDAO.updCategCliente(cliente);
		logger.debug("Fin:updCategCliente()");		
	}//fin updCategCliente
	
	/**
	 * Actualiza categoria de los clientes asociados a una cuenta
	 * @param cliente
	 * @return N/A
	 * @throws GeneralException
	 */
	public void actualizaCategoriasClientes(CuentaComDTO cuenta) 
	throws GeneralException{
		logger.debug("Inicio:actualizaCategoriasClientes()");
		clienteDAO.actualizaCategoriasClientes(cuenta);
		logger.debug("Fin:actualizaCategoriasClientes()");		
	}//fin actualizaCategoriasClientes	
	
	/**
	 * Actualiza codigo uso de los clientes asociados a una cuenta
	 * @param cliente
	 * @return N/A
	 * @throws GeneralException
	 */
	public void actualizaCodigoUsoClientes(CuentaComDTO cuenta) 
	throws GeneralException{
		logger.debug("Inicio:actualizaCategoriasClientes()");
		clienteDAO.actualizaCodigoUsoClientes(cuenta);
		logger.debug("Fin:actualizaCategoriasClientes()");		
	}//fin actualizaCodigoUsoClientes
	
	/**
	 * Actualiza subcategoria impositiva del cliente por la subcategoria de la cuenta}
	 * en base al resultado del analisis de categoria de la cuenta realizado en la
	 * alta del cliente.
	 * @param cliente
	 * @return N/A
	 * @throws GeneralException
	 */
	
	public void actualizaSubCategoriaImpositiva(ClienteComDTO clienteDTO)
	throws GeneralException{
		logger.debug("Inicio:actualizaSubCategoriaImpositiva()");
		clienteDAO.actualizaSubCategoriaImpositiva(clienteDTO);
		logger.debug("Fin:actualizaSubCategoriaImpositiva()");		
	}//fin actualizaSubCategoriaImpositiva
	
	/**
	 *Obtiene Datos del Cliente tipo empresa
	 * 
	 * @param cliente
	 * @return resultado
	 * @throws GeneralException
	 */
	public ClienteDTO getDatosEmpresa(ClienteDTO clienteDTO) throws GeneralException {
		ClienteDTO resultado = null;
		logger.debug("getDatosEmpresa():start");
		resultado = clienteDAO.getDatosEmpresa(clienteDTO);
		logger.debug("getDatosEmpresa():end");
		return resultado;
	}

	/**
	 * Obtine plaza del cliente
	 * @param clienteDTO
	 * @return resultado
	 * @throws GeneralException
	 */	
	public ClienteDTO ObtienePlazaCliente(ClienteDTO cliente) 
	throws GeneralException{
		ClienteDTO resultado = null;
		logger.debug("ObtienePlazaCliente():start");
		resultado = clienteDAO.ObtienePlazaCliente(cliente);
		logger.debug("ObtienePlazaCliente():end");
		return resultado;
	}//fin ObtienePlazaCliente
	
	/**
	 * Obtiene numero de abonados por cliente
	 * @param clienteDTO
	 * @return resultado
	 * @throws GeneralException
	 */	
	public ClienteDTO getNumeroAbonadosporCliente(ClienteDTO clienteDTO) 
	throws GeneralException{
		ClienteDTO resultado = null;
		logger.debug("getNumeroAbonadosporCliente():start");
		resultado = clienteDAO.getNumeroAbonadosporCliente(clienteDTO);
		logger.debug("getNumeroAbonadosporCliente():end");
		return resultado;
	}//fin getNumeroAbonadosporCliente
	
	
	/**
	 * Obtiene listado de Tarjetas.
	 * @return resultado
	 * @throws GeneralException
	 */	
	public WsListTarjetaOutDTO getListadoTarjetas() 
	throws GeneralException{
		WsListTarjetaOutDTO resultado = null;
		logger.debug("getListadoTarjetas():start");
		resultado = clienteDAO.getListadoTarjetas();
		logger.debug("getListadoTarjetas():end");
		return resultado;
	}//fin getListadoTarjetas
	
	/**
	 * Obtiene listado de modalidad de pago
	 * @param wsModalidadPagoInDTO
	 * @return resultado
	 * @throws GeneralException
	 */	
	public WsListModalidadPagoOutDTO getListadoModalidadPago()  
	throws GeneralException{
		WsListModalidadPagoOutDTO resultado = null;
		logger.debug("getListadoModalidadPago():start");
		resultado = clienteDAO.getListadoModalidadPago();
		logger.debug("getListadoModalidadPago():end");
		return resultado;
	}//fin getListadoModalidadPago
	
	/**
	 * Obtiene listado de Bancos PAC
	 * @param wsBancoInDTO
	 * @return resultado
	 * @throws GeneralException
	 */	
	public WsListBancoOutDTO getListadoBancosPAC(WsBancoInDTO wsBancoInDTO)
	throws GeneralException{
		WsListBancoOutDTO resultado = null;
		logger.debug("getListadoBancosPAC():start");
		logger.debug("wsBancoInDTO.getIndPAC ["+wsBancoInDTO.getIndPAC()+"]");
		resultado = clienteDAO.getListadoBancosPAC(wsBancoInDTO);
		logger.debug("getListadoBancosPAC():end");
		return resultado;
	}//fin getListadoBancosPAC

	/**
	 * Obtiene listado de Cuotas
	 * @return resultado
	 * @throws GeneralException
	 */	
	public WsListCuotaOutDTO getListadoCuotas()
	throws GeneralException{
		WsListCuotaOutDTO resultado = null;
		logger.debug("getListadoCuotas():start");
		resultado = clienteDAO.getListadoCuotas();
		logger.debug("getListadoCuotas():end");
		return resultado;
	}//fin getListadoCuotas	
	
	/**
	 * @author rlozano
	 * 
	 * Obtiene datos de contratos
	 * @param 
	 * @return WsContratoOutDTO[]
	 * @throws GeneralException
	 */	
	public WsContratoOutDTO[] getListVigenciasContratos()throws GeneralException{
		WsContratoOutDTO[] resultado;
		try{
			logger.debug("Inicio:getListVigenciasContratos()");
			resultado = clienteDAO.getListVigenciasContratos();
			logger.debug("Fin:getListVigenciasContratos()");
		}catch(GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return resultado;
	}
	
	
	/**
	 * @author rlozano
	 * 
	 * Obtiene datos de Modalidad de Venta
	 * @param 
	 * @return GeModVentaDTO[]
	 * @throws GeneralException
	 */	
	public GeModVentaDTO[] getListModalidadVenta()throws GeneralException{
		GeModVentaDTO[] resultado;
		try{
			logger.debug("Inicio:getListModalidadVenta()");
			resultado = clienteDAO.getListModalidadVenta();
			logger.debug("Fin:getListModalidadVenta()");
		}catch(GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return resultado;
	}
	
	public WsListClienteIdentOutDTO getListadoClientesXIdentificacion(WsClienteIdentInDTO cliente) throws GeneralException{
		WsListClienteIdentOutDTO resultado;
		try{
			logger.debug("Inicio:getListadoClientesXIdentificacion()");
			resultado = clienteDAO.getListadoClientesXIdentificacion(cliente);
			logger.debug("Fin:getListadoClientesXIdentificacion()");
		}catch(GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return resultado;	
	}
	
	public AbonadoActivoDTO[]  getAbonadosActivosCliente(long codCliente) throws GeneralException{
		//RSIS -015
		AbonadoActivoDTO[]  retValue=null;
		try{
			logger.debug("listAbonadosActivosCliente:start");
			retValue= clienteDAO.getAbonadosActivosCliente(codCliente);
			logger.debug("listAbonadosActivosCliente:end");
		}catch(GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
	}
	
	public WsLinkDocumentoOutDTO getLinkFactura(WsLinkDocumentoInDTO wsLinkDocumentoInDTO) throws GeneralException{
		//RSIS 032
		WsLinkDocumentoOutDTO retValue=null;
		try{
			logger.debug("listAbonadosActivosCliente:start");
			retValue= clienteDAO.getLinkFactura(wsLinkDocumentoInDTO);
			logger.debug("listAbonadosActivosCliente:end");
		}catch(GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
	}
	
	public PagosUltimosMesesDTO[] getRecPagosClie(ClienteDTO clienteDTO)throws GeneralException{
		PagosUltimosMesesDTO[] retValue=null;
		try{
			logger.debug("getRecPagosClie:start");
			retValue= clienteDAO.getRecPagosClie(clienteDTO);
			logger.debug("getRecPagosClie:end");
		}catch(GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
	}
	
	public WsInfoComercialClienteDTO[] getDatosCredCliente(ClienteDTO clienteDTO)throws GeneralException{
		WsInfoComercialClienteDTO[] retValue=null;
		try{
			logger.debug("getDatosCredCliente:start");
			retValue= clienteDAO.getDatosCredCliente(clienteDTO);
			logger.debug("getDatosCredCliente:end");
		}catch(GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
	}
	
	public RetornoDTO setAnulacionVenta(ParametrosAnulacionVentaDTO parametrosAnulacionVentaDTO)throws GeneralException{
		RetornoDTO retValue=null;
		try{
			logger.debug("setAnulacionVenta:start");
			retValue= clienteDAO.setAnulacionVenta(parametrosAnulacionVentaDTO);
			logger.debug("setAnulacionVenta:end");
		}catch(GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
	}
	
	public boolean  isExisteCodCausaBaja(String codCausaBaja)throws GeneralException{
		//UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
		boolean retValue=false;
		try{
			logger.debug("isExisteCodCausaBaja:start");
			retValue= clienteDAO.isExisteCodCausaBaja(codCausaBaja);
			logger.debug("isExisteCodCausaBaja:end");
		}catch(GeneralException e){
			logger.debug(e.fillInStackTrace());
			logger.debug("Fin:isExisteCodCausaBaja()");
		}catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
	}
	
	//validar tarjeta
	/**
	 *Valida si existe Tarjeta
	 * 
	 * @param wsValTarjetaDTO
	 * @return resultado
	 * @throws GeneralException
	 */
	public WSValidarTarjetaOutDTO validarTarjeta(WsValTarjetaInDTO wsValTarjetaDTO) throws GeneralException {
		WSValidarTarjetaOutDTO resultado = new WSValidarTarjetaOutDTO();
		logger.debug("validarTarjeta():start");
		resultado = clienteDAO.validarTarjeta(wsValTarjetaDTO);
		logger.debug("validarTarjeta():end");
		return resultado;
	}
	
	public CuentaComDTO getEmpresa(CuentaComDTO cuenta) 
	throws GeneralException{
		logger.debug("Inicio:getNuevoCliente()");
		CuentaComDTO resultado = clienteDAO.getEmpresa(cuenta);
		logger.debug("Fin:getNuevoCliente()");
		return resultado;		
	}//fin getNuevoCliente
	
	public void udpEmpresa(CuentaComDTO cuenta) 
	throws GeneralException{
		logger.debug("Inicio:getNuevoCliente()");
		clienteDAO.udpEmpresa(cuenta);
		logger.debug("Fin:getNuevoCliente()");		
	}//fin getNuevoCliente
	
	public RetornoDTO setObservacionFactura(FaMensProcesoDTO faMensProcesoDTO)throws GeneralException{ 
		RetornoDTO retValue;
		try{
			logger.debug("setObservacionFactura:start");
			retValue=clienteDAO.InsertFaMensProceso(faMensProcesoDTO);
			FaMensajesDTO faMensajesDTO = new FaMensajesDTO();
			faMensajesDTO.setCantCaractLin(100);
			faMensajesDTO.setCantLineasMen(faMensProcesoDTO.getNumLineas());
			faMensajesDTO.setCodIdioma("1");
			faMensajesDTO.setCorrMensaje(faMensProcesoDTO.getCorrMensaje());
						
			if (faMensProcesoDTO.getDescMensaje().length() > 40  ){
				faMensajesDTO.setDescMensaje(faMensProcesoDTO.getDescMensaje().substring(1,40));
			}else{
				faMensajesDTO.setDescMensaje(faMensProcesoDTO.getDescMensaje());
			}
			
			if (faMensProcesoDTO.getDescMensaje().length() > 200  ){
				faMensajesDTO.setDescMesLin(faMensProcesoDTO.getDescMensaje().substring(1, 200));
			}else{
				faMensajesDTO.setDescMesLin(faMensProcesoDTO.getDescMensaje());
			}
			
			faMensajesDTO.setNomUsuario(faMensProcesoDTO.getNomUsuario());
			faMensajesDTO.setNumLinea(String.valueOf(faMensProcesoDTO.getNumLineas()));
			if ("OK".equals(retValue.getMensajseError())){
				retValue= clienteDAO.setObservacionFactura(faMensajesDTO);
			}
			logger.debug("setObservacionFactura:end");
		} catch (GeneralException e) {
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("setObservacionFactura:end");
		return retValue;
	}
	
	
	/**
	 * Metodos que retorna las sucursales de un banco según su código.
	 * @param sucursalBancoDTO
	 * @return
	 * @throws GeneralException
	 */
	public SucursalBancoDTO[] getSucursalesBanco(SucursalBancoDTO sucursalBancoDTO) 
	throws GeneralException{
		logger.debug("Inicio:getSucursalesBanco()");
		logger.debug("Fin:getSucursalesBanco()");
		return clienteDAO.getSucursalesBanco(sucursalBancoDTO);
	}
	
	
	/**
	 * Metodo que retorna la clasificacions de cuenta
	 * @return 
	 * @throws GeneralException
	 */
	public ClasificacionCuentaDTO[] getClasificacionCuenta() 
	throws GeneralException{
		ClasificacionCuentaDTO[] respuesta = null;
		logger.debug("Inicio:getClasificacionCuenta()");
		respuesta = clienteDAO.getClasificacionCuenta();
		logger.debug("codigo clase cuenta"+ respuesta[1].getCodClasCuenta());
		logger.debug("descripcion clase cuenta"+ respuesta[1].getDesClasCuenta());		
		logger.debug("Fin:getClasificacionCuenta()");
		return respuesta;
	}
	
	
	public String getLimConsClieEmpresa(String codigoCliente) 	
	throws GeneralException{	
		logger.debug("Inicio:getLimConsClieEmpresa()");
		String limConsClieEmp;
		limConsClieEmp = clienteDAO.getLimConsClieEmpresa(codigoCliente); 
		logger.debug("Fin:getLimConsClieEmpresa()");
		return limConsClieEmp;
	}		
	
	/**
	 * CSR-11002 - (AL) - 2011.07.27
	 * Metodo de categorias para cambio asociadas al cliente.
	 * @return resultado
	 * @throws GeneralException
	 */
	public CategoriaCambioDTO[] getCategoriasCambio() 
	throws GeneralException
	{
		logger.debug("getCategoriasCambio():start");
		CategoriaCambioDTO[] resultado = clienteDAO.getCategoriasCambio();
		logger.debug("getCategoriasCambio():end");
		return resultado;		
	}
	
	/**
	 * CSR-11002 - (AL) - 2011.07.27 - Inserta categoria de cambio del cliente
	 * @param categCambioCliente
	 * @return N/A
	 * @throws GeneralException
	 */
	public void insCategoriaCambioCliente(CategoriaCambioClienteDTO categCambioCliente) 
	throws GeneralException
	{
		logger.debug("insCategoriaCambioCliente():start");
		clienteDAO.insCategoriaCambioCliente(categCambioCliente);
		logger.debug("insCategoriaCambioCliente():end");
	}
	
	/**
	 * CSR-11002
	 * permite obtener las clasificaciones crediticia
	 * @return
	 * @throws GeneralException
	 */
	public ValorClasificacionDTO[] getCrediticia()
	throws GeneralException{
		
		logger.debug("Inicio:getCrediticia()");
		
		ValorClasificacionDTO[] respuesta = clienteDAO.getCrediticia();
		
		logger.debug("Fin:getCrediticia()");
		
		return respuesta;
	}
	
	/**
	 * CSR-11002
	 * permite obtener las clasificaciones
	 * @return
	 * @throws GeneralException
	 */
	public ClasificacionDTO[] getClasificaciones()
	throws GeneralException{

		logger.debug("Inicio:getClasificaciones()");
		
		ClasificacionDTO[] respuesta = clienteDAO.getClasificaciones();
		
		logger.debug("Fin:getClasificaciones()");
		
		return respuesta;
	}

	/**
	 * CSR-11002
	 * permite insertar el monto preautorizado
	 * @param clienteComDTO
	 * @throws GeneralException
	 */
	public void insMontoPreautorizado(ClienteComDTO entrada)
	throws GeneralException{

		logger.debug("Inicio:insMontoPreautorizado()");
		
		clienteDAO.insMontoPreautorizado(entrada);
		
		logger.debug("Fin:insMontoPreautorizado()");
		
	}
	
	/**
	 * Obtiene listado de tipos de pago.
	 * @return WsListModalidadPagoOutDTO
	 * @throws GeneralException
	 */
	public WsListTipoPagoOutDTO getListadoTipoPago() throws GeneralException {
		WsListTipoPagoOutDTO resultado = null;
		logger.debug("getListadoTipoPago():start");
		resultado = clienteDAO.getListadoTipoPago();
		logger.debug("getListadoTipoPago():end");
		return resultado;
	}
	
	//JLGN PT
	/**
	 * Obtiene listado de Planes Tarifarios Prepago.
	 * @return WsListPlanTarifarioOutDTO
	 * @throws GeneralException
	 */
	public WsListPlanTarifarioOutDTO getListadoPlanTarifario(String tipProducto, String tipPlan, String codTipPrestacion, int indRenova, String codCalificacion)
	throws GeneralException{
		WsListPlanTarifarioOutDTO resultado = null;
		logger.debug("getListadoPlanTarifario():start");
		resultado = clienteDAO.getListadoPlanTarifario(tipProducto, tipPlan, codTipPrestacion, indRenova, codCalificacion);
		logger.debug("getListadoPlanTarifario():end");
		return resultado;
	}
}//fin CLASS Cliente
