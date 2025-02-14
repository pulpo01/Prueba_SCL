package com.tmmas.cl.scl.gestiondeclientes.businessobject.bo;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.scl.gestiondeclientes.businessobject.dao.CuentaDAO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ClienteDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CuentaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CuentaComDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsCuentaIdentInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsCuentaIdentOutDTO;

public class CuentaBO {
	
	private CuentaDAO cuentaDAO  = new CuentaDAO();
	private final Logger logger = Logger
	.getLogger(CuentaBO.class);

	public CuentaDTO getCuenta(CuentaDTO cuentaDTO) throws GeneralException {
		logger.debug("Inicio:getCuenta()");
		CuentaDTO resultado = cuentaDAO.getCuenta(cuentaDTO);
		logger.debug("Fin:getCuenta()");
		return resultado;
	}//fin datosCuenta
	
	/**
	 * Retorna todos los datos de la cuenta por numero de identificacion
	 * @param cuenta
	 * @return resultado
	 * @throws GeneralException
	 */
	public CuentaComDTO getCuentaNumIdent(CuentaComDTO cuenta) 
	throws GeneralException{
		logger.debug("Inicio:getCuentaNumIdent()");
		cuenta = cuentaDAO.getCuentaNumIdent(cuenta);
		logger.debug("Fin:getCuentaNumIdent()");
		return cuenta;		
	}//fin getCuentaNumIdent
	
	public CuentaDTO getSubCuenta(CuentaDTO entrada) throws GeneralException {
		CuentaDTO resultado = new CuentaDTO();
		logger.debug("Inicio:getSubCuenta()");
		resultado = cuentaDAO.getSubCuenta(entrada);
		logger.debug("Fin:getSubCuenta()");
		return resultado;
	}
	
	public boolean getValSubCuenta(CuentaComDTO entrada) throws GeneralException {
		CuentaDTO resultado = new CuentaDTO();		
		logger.debug("Inicio:getSubCuenta()");
		try{
			resultado.setCodigoCuenta(entrada.getCodigoCuenta());
			resultado = cuentaDAO.getSubCuenta(resultado);
		}catch (GeneralException e) {
			if (!e.getCodigo().equals("12240")){
				throw e;
			}else{
				return false;
			}
		}
		logger.debug("Fin:getSubCuenta()");
		return true;
	}

	/**
	 * Obtiene listado de clasificacion cuenta
	 * @param N/A
	 * @return CuentaDTO[]
	 * @throws GeneralException
	 */
	public CuentaDTO[] getListClasificacionCuenta() 
	throws GeneralException{
		logger.debug("Inicio:getListClasificacionCuenta()");
		CuentaDTO[] resultado = cuentaDAO.getListClasificacionCuenta();
		logger.debug("Fin:getListClasificacionCuenta()");
		return resultado;		
	}//fin getListClasificacionCuenta

	/**
	 * Obtiene listado de cuenta de acuerdo a criterios de búsqueda
	 * @param  CuentaDTO
	 * @return CuentaDTO[]
	 * @throws GeneralException
	 */
	public CuentaDTO[] getListadoCuenta(CuentaDTO criterioBusquedaCuenta) 
	throws GeneralException{
		logger.debug("Inicio:getListadoCuenta()");
		CuentaDTO[] resultado = cuentaDAO.getListadoCuenta(criterioBusquedaCuenta);
		logger.debug("Fin:getListadoCuenta()");
		return resultado;		
	}//fin getListadoCuenta
	
	/**
	 * Inserta cuenta
	 * @param cuenta
	 * @return N/A
	 * @throws GeneralException
	 */                   
	public void insCuenta(CuentaComDTO cuenta) 
	throws GeneralException{
		logger.debug("Inicio:insCuenta()");
		cuentaDAO.insCuenta(cuenta);
		logger.debug("Fin:insCuenta()");
	}//fin insCuenta

	/**
	 * Inserta SubCuenta
	 * @param SubCuenta
	 * @return N/A
	 * @throws GeneralException
	 */
	public void insSubCuenta(CuentaComDTO cuenta) 
	throws GeneralException{
		logger.debug("Inicio:insSubCuenta()");
		cuentaDAO.insSubCuenta(cuenta);
		logger.debug("Fin:insSubCuenta()");		
	}//fin insSubCuenta

	/**
	 * Retorna todos los datos de la cuenta
	 * @param cuenta
	 * @return resultado
	 * @throws GeneralException
	 */
	public CuentaDTO getCuentaAll(CuentaDTO cuenta) 
	throws GeneralException{
		logger.debug("Inicio:getCuentaAll()");
		CuentaDTO resultado = cuentaDAO.getCuentaAll(cuenta);
		logger.debug("Fin:getCuentaAll()");
		return resultado;		
	}//fin getCuentaAll
	
	
	/**
	 * Obtiene la categoria de la cuenta
	 * @param cuenta
	 * @return resultado
	 * @throws GeneralException
	 */
	public CuentaComDTO getCategoriaCuenta(CuentaComDTO cuenta) 
	throws GeneralException{
		logger.debug("Inicio:getCategoriaCuenta()");
		cuenta = cuentaDAO.getCategoriaCuenta(cuenta);
		logger.debug("Fin:getCategoriaCuenta()");
		return cuenta;		
	}//fin getCategoriaCuenta
	
	/**
	 * Actualiza datos de la cuenta
	 * @param SubCuenta
	 * @return N/A
	 * @throws GeneralException
	 */
	public void actualizaCuenta(CuentaComDTO cuenta) 
	throws GeneralException{
		logger.debug("Inicio:actualizaCuenta()");
		cuentaDAO.actualizaCuenta(cuenta);
		logger.debug("Fin:actualizaCuenta()");		
	}//fin actualizaCuenta
	
	/**
	 * Elimina cuentas potenciales
	 * @param SubCuenta
	 * @return N/A
	 * @throws GeneralException
	 */
	public void eliminaCuentasPotenciales(CuentaComDTO cuenta) 
	throws GeneralException{
		logger.debug("Inicio:actualizaCuenta()");
		cuentaDAO.eliminaCuentasPotenciales(cuenta);
		logger.debug("Fin:actualizaCuenta()");		
	}//fin eliminaCuentasPotenciales
	
	
	public CuentaComDTO valExisCuentaIdent(CuentaComDTO cuenta) 
	throws GeneralException{
		logger.debug("Inicio:actualizaCuenta()");				
		cuenta = cuentaDAO.getCuentaNumIdent(cuenta);
		logger.debug("Fin:actualizaCuenta()");
		return cuenta;		
	}//fin eliminaCuentasPotenciales	
	
	
	
	public CuentaDTO[] getSubCuentaPorCodCliente(ClienteDTO clienteDTO) throws GeneralException{
		CuentaDTO[] retValue=null;
		try{
			logger.debug("Inicio:getSubCuentaPorCodCliente()");
			retValue=cuentaDAO.getSubCuentaPorCodCliente(clienteDTO);
		
		} catch (GeneralException e) {
			String c = StackTraceUtl.getStackTrace(e);
			logger.debug("GeneralException["+ c);
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			String c = StackTraceUtl.getStackTrace(e);
			logger.debug("Exception["+ c);
			throw new GeneralException(e);
		}
		logger.debug("Fin:getSubCuentaPorCodCliente()");
		return retValue;
	}	
	
	
	public WsCuentaIdentOutDTO validaCuentaNumeroIdentificacion(WsCuentaIdentInDTO cuenta) 
	throws GeneralException{
		WsCuentaIdentOutDTO retValue=null;
		try{
			retValue=cuentaDAO.validaCuentaNumeroIdentificacion(cuenta);
		
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
	}	
		
	
}//fin Cuenta