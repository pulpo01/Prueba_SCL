/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 30/05/2007	     	Elizabeth Vera        				Versión Inicial
 */
package com.tmmas.scl.framework.customerDomain.businessObject.bo;

import org.apache.log4j.Logger;

import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.ClienteIT;
import com.tmmas.scl.framework.customerDomain.businessObject.dao.ClienteDAO;
import com.tmmas.scl.framework.customerDomain.businessObject.dao.interfaces.ClienteDAOIT;
import com.tmmas.scl.framework.customerDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.CargoClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteCobroAdentadoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteListDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.LimiteLineasDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.LineasClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.MorosidadClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ObtencionLineasClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerException;
import com.tmmas.scl.framework.marketSalesDomain.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.productDomain.businessObject.bo.AbonadoBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.RegistroFacturacionBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.AbonadoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.AbonadoIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.RegistroFacturacionBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.RegistroFacturacionIT;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoListDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegistroFacturacionDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.NumeroDTO;


public class Cliente implements ClienteIT
{

	private ClienteDAOIT clienteDAO = new ClienteDAO();
	
	private AbonadoBOFactoryIT abonadoFactory=new AbonadoBOFactory();
	private AbonadoIT abonadoBO=abonadoFactory.getBusinessObject1();
	
	private RegistroFacturacionBOFactoryIT regFactFactory=new RegistroFacturacionBOFactory();
	private RegistroFacturacionIT regFactBO=regFactFactory.getBusinessObject1();
	
	private final Logger logger = Logger.getLogger(Cliente.class);
	private Global global = Global.getInstance();	
	

	public LimiteLineasDTO obtenerLimiteLineas(ObtencionLineasClienteDTO cliente) throws CustomerException{
		LimiteLineasDTO retorno = null;
		try{
			logger.debug("obtenerLimiteLineas():start");
			retorno = clienteDAO.obtenerLimiteLineas(cliente);
			logger.debug("obtenerLimiteLineas():end");
		} catch (CustomerException e) {
			logger.debug("CustomerException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerException(e);
		}	
		return retorno;
	}
	public ClienteDTO obtenerDatosCliente(ClienteDTO cliente) throws CustomerException{
		ClienteDTO respuesta = null;
		try {
			logger.debug("obtenerDatosCliente():start");
			respuesta = clienteDAO.obtenerDatosCliente(cliente);
			logger.debug("obtenerDatosCliente():end");
		} catch (CustomerException e) {
			logger.debug("CustomerException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerException(e);
		}		
		return respuesta;	
	}
	
	public RetornoDTO actualizaCantAboCliente(ClienteDTO cliente) throws CustomerException{
		RetornoDTO retorno = null;
		try {
			logger.debug("actualizaCantAboCliente():start");
			retorno = clienteDAO.actualizaCantAboCliente(cliente);
			logger.debug("actualizaCantAboCliente():end");
		} catch (CustomerException e) {
			logger.debug("CustomerException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerException(e);
		}		
		return retorno;	
	}
	
	public CargoClienteDTO obtenerCargoBasicoActual(CargoClienteDTO cliente) throws CustomerException{
		CargoClienteDTO cargo = null;
		try {
			logger.debug("obtenerCargoBasicoActual():start");
			cargo = clienteDAO.obtenerCargoBasicoActual(cliente);
			logger.debug("obtenerCargoBasicoActual():end");
		} catch (CustomerException e) {
			logger.debug("CustomerException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerException(e);
		}		
		return cargo;			
	}
	
	public RetornoDTO validarTipoPlanCliente(ClienteDTO cliente) throws CustomerException{
		RetornoDTO retorno = null;
		try {
			logger.debug("validarTipoPlanCliente():start");
			retorno = clienteDAO.validarTipoPlanCliente(cliente);
			logger.debug("validarTipoPlanCliente():end");
		} catch (CustomerException e) {
			logger.debug("CustomerException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerException(e);
		}		
		return retorno;			
	}

	public ClienteListDTO buscarCliente(NumeroDTO numero) throws CustomerException {
		ClienteListDTO retorno = null;
		try {
			logger.debug("buscarCliente():start");
			retorno = clienteDAO.buscarCliente(numero);
			logger.debug("buscarCliente():end");
		} catch (CustomerException e) {
			logger.debug("CustomerException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerException(e);
		}		
		return retorno;			
	}
	
	public ClienteListDTO buscarCliente(ClienteDTO cliente) throws CustomerException{
		ClienteListDTO retorno = null;
		try {
			logger.debug("buscarCliente():start");
			retorno = clienteDAO.buscarCliente(cliente);			
			logger.debug("buscarCliente():end");
		} catch (CustomerException e) {
			logger.debug("CustomerException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerException(e);
		}		
		return retorno;			
	}

	public ClienteDTO obtenerDatosPorVenta(VentaDTO venta) throws CustomerException {
		ClienteDTO retorno = null;
		AbonadoListDTO listaAbonados=null;
		
		try {
			logger.debug("obtenerDatosPorVenta():start");
			retorno = clienteDAO.obtenerDatosPorVenta(venta);		
			retorno.setCodigoCiclo(String.valueOf(retorno.getCodCiclo()));
			// LLAMADA A DTO DE ABONADO			
			RegistroFacturacionDTO regFac=regFactBO.getCodigoCicloFacturacion(retorno);		
			
			listaAbonados=abonadoBO.obtenerAbonadosPorVenta(venta);
			listaAbonados=listaAbonados!=null?listaAbonados:new AbonadoListDTO();			
			retorno.setAbonados(listaAbonados);			
			
			if(regFac.getCodigoCicloFacturacion()!=0)
			{
				retorno.setCodCicloFacturacion(regFac.getCodigoCicloFacturacion());				
			}
			else
			{
				CustomerException e=new CustomerException("El cliente no tiene ciclo de facturacion abierto");
				logger.debug("CustomerException[", e);
				throw e;
			}
			
			logger.debug("obtenerDatosPorVenta():end");
		} catch (CustomerException e) {
			logger.debug("CustomerException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerException(e);
		}		
		return retorno;			
	}

	public ClienteDTO validarCliente(ClienteDTO cliente) throws CustomerException {
		ClienteDTO retorno = null;
		try {
			logger.debug("validarCliente():start");
			retorno = clienteDAO.validarCliente(cliente);
			logger.debug("validarCliente():end");
		} catch (CustomerException e) {
			logger.debug("CustomerException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerException(e);
		}		
		return retorno;			
	}
	
	public ClienteDTO obtenerCategoriaTributaria(ClienteDTO cliente) throws CustomerException{
		ClienteDTO retorno = null;
		try {
			logger.debug("obtenerCategoriaTributaria():start");
			retorno = clienteDAO.obtenerCategoriaTributaria(cliente);
			logger.debug("obtenerCategoriaTributaria():end");
		} catch (CustomerException e) {
			logger.debug("CustomerException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerException(e);
		}		
		return retorno;		
	}
	/**
	 *Obtiene Datos del Cliente
	 * 
	 * @param cliente
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public ClienteDTO getCliente(ClienteDTO cliente) throws CustomerException {
		ClienteDTO resultado = new ClienteDTO();
		logger.debug("getCliente():start");
		resultado = clienteDAO.getCliente(cliente);
		logger.debug("getCliente():end");
		return resultado;
	}
	
	public String getCodigoValor(String codCliente)throws CustomerException{
		String retValue=null;
		logger.debug("getCodigoValor():start");
		retValue = clienteDAO.getcodValorCliente(codCliente);
		logger.debug("getCodigoValor():end");
		return retValue;
	}
	
	public ClienteDTO obtenerValorCalculado(ClienteDTO cliente) throws CustomerException{
		ClienteDTO retorno = null;
		try {
			logger.debug("obtenerValorCalculado():start");
			retorno = clienteDAO.obtenerValorCalculado(cliente);
			logger.debug("obtenerValorCalculado():end");
		} catch (CustomerException e) {
			logger.debug("CustomerException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerException(e);
		}		
		return retorno;				
	}
	
	public LineasClienteDTO obtenerCantidadLineasCliente(LineasClienteDTO cliente) throws CustomerException{
		LineasClienteDTO retorno = null;
		try {
			logger.debug("obtenerCantidadLineasCliente():start");
			retorno = clienteDAO.obtenerCantidadLineasCliente(cliente);
			logger.debug("obtenerCantidadLineasCliente():end");
		} catch (CustomerException e) {
			logger.debug("CustomerException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerException(e);
		}		
		return retorno;		
	}
	
	public MorosidadClienteDTO obtenerMorosidadCliente(MorosidadClienteDTO cliente) throws CustomerException{
		MorosidadClienteDTO retorno = null;
		try {
			logger.debug("obtenerMorosidadCliente():start");
			retorno = clienteDAO.obtenerMorosidadCliente(cliente);
			logger.debug("obtenerMorosidadCliente():end");
		} catch (CustomerException e) {
			logger.debug("CustomerException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerException(e);
		}		
		return retorno;			
	}
	
	public RetornoDTO insertarCobroAdelantado(ClienteCobroAdentadoDTO clienteCobroAdelantadoDTO) throws CustomerException {
		RetornoDTO retorno= null;
		try {
			logger.debug("insertarCobroAdelantado():start");
			retorno = clienteDAO.insertarCobroAdelantado(clienteCobroAdelantadoDTO);
			logger.debug("insertarCobroAdelantado():end");
		} catch (CustomerException e) {
			logger.debug("CustomerException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerException(e);
		}		
		return retorno;	
	}
}
