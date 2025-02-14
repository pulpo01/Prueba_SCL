package com.tmmas.scl.operations.crm.f.oh.isscusord.cmd.helper;

import java.io.Serializable;
import java.rmi.RemoteException;

import net.sf.dozer.util.mapping.DozerBeanMapper;
import net.sf.dozer.util.mapping.MapperIF;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.UsuarioDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.CabeceraArchivoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RegCargosDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.ResultadoRegCargosDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.cmd.orc.helper.Global;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.ParamRegistroOrdenServicioDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.RegistroPlanDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.exception.IssCusOrdException;

public class RegistrodeCargos implements Serializable {
	private static final long serialVersionUID = 1L;

	transient static Logger cat = Logger.getLogger(RegistrodeCargos.class);

	/**
	 * Ejecuta el proceso de cargos
	 * 
	 * @param param
	 */
	public void ejecutarProcesoCargos(ParamRegistroOrdenServicioDTO param)
			throws GeneralException {
		cat.debug("ejecutarProcesoCargos():start");
		
		cat.debug("validacionParametroOrdenServicio...");
		// Valido los parametros de entrada principales
		validacionParametroOrdenServicio(param);

		cat.debug("registrarCargos...");
		//Registrando los cargos
		registrarCargos(param);
		cat.debug("ejecutarProcesoCargos():end");
	}

	/**
	 * Registra los cargos
	 * 
	 * @param param
	 * @throws GeneralException
	 */
	private void registrarCargos(ParamRegistroOrdenServicioDTO param)
			throws GeneralException {
		cat.debug("registrarCargos():start");

		RegistroPlanDTO registro = param.getRegistroPlan();

		// combinatoria
		String combinatoria = registro.getParamRegistroPlan().getCombinatoria();
		cat.debug("combinatoria[" + combinatoria + "]");

		// orden de servicio
		String tipoOOSS = registro.getParamRegistroPlan().getTipOOSS();
		cat.debug("tipoOOSS[" + tipoOOSS + "]");

		// Armo la combinatoria
		String combinacion = combinatoria + tipoOOSS;
		cat.debug("combinacion[" + combinacion + "]");

		// Averigua si es valido o no ejecutar los cargos
		boolean resultado = esValidoEjecutarCargos(param, combinacion);
		cat.debug("registrar Cargos[" + resultado + "]");

		if (resultado) {
			
			cat.debug("Preparando para registrar cargos...");
			RegCargosDTO retValConst = new RegCargosDTO();
			com.tmmas.scl.framework.productDomain.dataTransferObject.RegCargosDTO retValConstFrmk = new com.tmmas.scl.framework.productDomain.dataTransferObject.RegCargosDTO();

			FacadeHelper facade = new FacadeHelper();

			// Construye los cargos
			try {
				cat.debug("construirRegistroCargos:antes");
				
				com.tmmas.scl.framework.customerDomain.dataTransferObject.ObtencionCargosDTO obtCargosFrmk = new com.tmmas.scl.framework.customerDomain.dataTransferObject.ObtencionCargosDTO();
				MapperIF mapper = new DozerBeanMapper();
				mapper.map(param.getRegistroCargos().getOcacionales(), obtCargosFrmk);
				
				
				
				retValConstFrmk = facade.getFrmkCargosFacade().construirRegistroCargos(obtCargosFrmk);
				cat.debug("construirRegistroCargos:despues");
			} catch (RemoteException e) {
				cat.debug("RemoteException", e);
				throw new GeneralException(e);
			} catch (Exception e) {
				cat.debug("Exception", e);
				throw new GeneralException(e);
			}


			cat.debug("Seteando datos a cabecera...");
			CabeceraArchivoDTO objetoSesion = new CabeceraArchivoDTO();
			objetoSesion.setPlanComercialCliente(String.valueOf(registro
					.getCliente().getCodPlanCom()));
			objetoSesion.setCodigoCliente(String.valueOf(registro.getCliente()
					.getCodCliente()));
			objetoSesion.setFacturaCiclo(true);
			objetoSesion.setNumeroVenta(0);
			objetoSesion.setNumeroTransaccionVenta(0);
			objetoSesion.setCodigoDocumento(registro.getParamRegistroPlan()
					.getCodTipoDocumento());
			objetoSesion.setCodModalidadVenta(registro.getParamRegistroPlan()
					.getModPago());

			cat.debug("Seteando datos a cabecera fin...");
			
			// Setea el vendedor
			UsuarioDTO usuario = new UsuarioDTO();
			usuario.setNombre(registro.getParamRegistroPlan().getNomUsuaOra());
			try {
				cat.debug("obtenerVendedor:antes");
				usuario = facade.getSupOrdHanFacade().obtenerVendedor(usuario);
				cat.debug("obtenerVendedor:despues");

			} catch (RemoteException e) {
				cat.debug("RemoteException", e);
				throw new GeneralException(e);
			} catch (Exception e) {
				cat.debug("Exception", e);
				throw new GeneralException(e);
			}
			objetoSesion.setCodigoVendedor(String.valueOf(usuario.getCodigo()));

			// Registra los cargos
			retValConst.setObjetoSesion(objetoSesion);

			ResultadoRegCargosDTO respuesta = null;
			try {
				cat.debug("parametrosRegistrarCargos:antes");
				//respuesta = 
				facade.getFrmkCargosFacade().parametrosRegistrarCargos(retValConstFrmk);
				cat.debug("parametrosRegistrarCargos:despues");

			} catch (RemoteException e) {
				cat.debug("RemoteException", e);
				throw new GeneralException(e);
			} catch (Exception e) {
				cat.debug("Exception", e);
				throw new GeneralException(e);
			}
		}

		cat.debug("registrarCargos():end");

	}

	/**
	 * Procedimiento que averigua si es valido ejecutar los cargos o no
	 * 
	 * @param param
	 * @param combinacion
	 * @throws GeneralException
	 */
	private boolean esValidoEjecutarCargos(ParamRegistroOrdenServicioDTO param,
			String combinacion) throws GeneralException {
		cat.debug("esValidoEjecutarCargos():start");
		Global global = Global.getInstance();

		boolean ejecutarRegistroCargos = true;

		boolean posPos7 = false;
		boolean posPos6 = false;
		boolean posPre8 = false;
		boolean hibpre8 = false;

		// Combinatorias a las que no se les puede ejecutar el cargo
		String strposPos7 = global.getValor("posPos7");
		cat.debug("strposPos7[" + strposPos7 + "]");

		String strposPos6 = global.getValor("posPos6");
		cat.debug("strposPos6[" + strposPos6 + "]");

		String strstrposPre8 = global.getValor("posPre8");
		cat.debug("strstrposPre8[" + strstrposPre8 + "]");

		String strhibpre8 = global.getValor("hibpre8");
		cat.debug("strhibpre8[" + strhibpre8 + "]");

		// Compara las combinatorias
		posPos7 = strposPos7.equalsIgnoreCase(combinacion);
		cat.debug("posPos7[" + posPos7 + "]");

		posPos6 = strposPos6.equalsIgnoreCase(combinacion);
		cat.debug("posPos6[" + posPos7 + "]");

		posPre8 = strstrposPre8.equalsIgnoreCase(combinacion);
		cat.debug("posPre8[" + posPos7 + "]");

		hibpre8 = strhibpre8.equalsIgnoreCase(combinacion);
		cat.debug("hibpre8[" + posPos7 + "]");

		// Si corresponde a una de las combinatorias de arriba no se debe
		// ejecutar el
		// método parametrosRegistrarCargos
		if (posPos7 || posPos6 || posPre8 || hibpre8) {
			cat
					.debug("Existe una combinatoria definida a la que no se aplicara cargos");
			ejecutarRegistroCargos = false;
			return ejecutarRegistroCargos;
		}

		// Averigua si se setearon o no los cargos
		if (param.getRegistroCargos() == null
				|| param.getRegistroCargos().getOcacionales() == null) {
			cat.debug("No se setearon los cargos");
			ejecutarRegistroCargos = false;
			return ejecutarRegistroCargos;
		}

		cat.debug("cargos seteados...");
		cat.debug("esValidoEjecutarCargos():end");
		return ejecutarRegistroCargos;

	}

	/**
	 * Valida los parametros principales de la orden de servicio
	 * 
	 * @param param
	 * @throws GeneralException
	 */
	private void validacionParametroOrdenServicio(
			ParamRegistroOrdenServicioDTO param) throws GeneralException {
		cat.debug("validacionParametroOrdenServicio():start");

		// Valida el parametro de la cola
		if (param != null) {
			cat.debug("Parametro de la cola distinto de nulo");
		} else {
			cat.debug("Parametro de la cola nulo");
			throw new IssCusOrdException("El objeto que se encolo es nulo");
		}

		// Valida el registro de plan
		RegistroPlanDTO registroPlan = param.getRegistroPlan();

		if (registroPlan == null) {
			cat.debug("Registro de plan nulo");
			throw new IssCusOrdException("Registro de plan nulo");
		}

		// Valida la combinatoria
		String combinatoria = registroPlan.getParamRegistroPlan()
				.getCombinatoria();
		cat.debug("combinatoria[" + combinatoria + "]");

		// Valida la orden de servicio
		String tipoOOSS = registroPlan.getParamRegistroPlan().getTipOOSS();
		cat.debug("tipoOOSS[" + tipoOOSS + "]");

		if (combinatoria == null) {
			cat.debug("Combinatoria nula");
			throw new IssCusOrdException("Combinatoria nula");
		}

		if (tipoOOSS == null) {
			cat.debug("tipoOOSS nula");
			throw new IssCusOrdException("tipoOOSS nula");
		}
		cat.debug("validacionParametroOrdenServicio():end");
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub7

	}

}
