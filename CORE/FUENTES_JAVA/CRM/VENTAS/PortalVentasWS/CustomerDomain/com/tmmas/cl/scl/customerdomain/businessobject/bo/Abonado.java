package com.tmmas.cl.scl.customerdomain.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosValidacionVentasDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ResultadoValidacionVentaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dao.AbonadoDAO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.AbonadoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.NivelAbonadoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.RegistroVentaDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.RenovacionAbonadoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.VendedorDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.helper.Global;

public class Abonado extends CustomerAccountProductInvolvement {
	private AbonadoDAO abonadoDAO = new AbonadoDAO();

	private static Category cat = Category.getInstance(Abonado.class);

	Global global = Global.getInstance();

	/**
	 * Valida si la simcard esta asociado a un Abonado
	 * @param entradaValidacionVentas
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public ResultadoValidacionVentaDTO existeSerieSimcardEnAbonado(ParametrosValidacionVentasDTO entradaValidacionVentas)
			throws CustomerDomainException {
		ResultadoValidacionVentaDTO resultado = null;
		cat.debug("Inicio:existeSerieSimcardEnAbonado()");
		resultado = abonadoDAO.getExisteSerieSimcardEnAbonado(entradaValidacionVentas);
		if (resultado.getResultadoBase() == 1) {
			resultado.setResultado(true);
		}
		else if (resultado.getResultadoBase() == 0) {
			resultado.setResultado(false);
		}
		cat.debug("Fin:existeSerieSimcardEnAbonado()");
		return resultado;
	}//fin existeSerieSimcardEnAbonado	

	/**
	 * Valida si el Terminal esta asociado a un Abonado
	 * @param entradaValidacionVentas
	 * @return resultado
	 * @throws CustomerDomainException
	 */

	public ResultadoValidacionVentaDTO existeSerieTerminalEnAbonado(
			ParametrosValidacionVentasDTO entradaValidacionVentas) throws CustomerDomainException {
		ResultadoValidacionVentaDTO resultado = null;
		cat.debug("Inicio:existeSerieTerminalEnAbonado()");
		resultado = abonadoDAO.existeSerieTerminalEnAbonado(entradaValidacionVentas);
		if (resultado.getResultadoBase() == 1) {
			resultado.setResultado(true);
		}
		else if (resultado.getResultadoBase() == 0) {
			resultado.setResultado(false);
		}
		cat.debug("Fin:existeSerieTerminalEnAbonado()");
		return resultado;
	}//fin existeSerieTerminalEnAbonado	

	public ResultadoValidacionVentaDTO validaSerieTermialEnListaNegra(
			ParametrosValidacionVentasDTO entradaValidacionVentas) throws CustomerDomainException {
		ResultadoValidacionVentaDTO resultado = null;
		cat.debug("Inicio:validaSerieTermialEnListaNegra()");
		resultado = abonadoDAO.getValidaSerieTerminalListaNegra(entradaValidacionVentas);
		if (resultado.getResultadoBase() == 1) {
			resultado.setResultado(true);
		}
		else if (resultado.getResultadoBase() == 0) {
			resultado.setResultado(false);
		}
		cat.debug("Fin:validaSerieTermialEnListaNegra()");
		return resultado;
	}//fin validaSerieTermialEnListaNegra

	/**
	 * Obtiene Oficina principal del Abonado en base a datos del vendedor
	 * @param vendedor
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public AbonadoDTO getOficinaPrincipal(VendedorDTO vendedor) throws CustomerDomainException {
		AbonadoDTO resultado = new AbonadoDTO();
		cat.debug("Inicio:getOficinaPrincipal()");
		resultado = abonadoDAO.getOficinaPrincipal(vendedor);
		cat.debug("Fin:getOficinaPrincipal()");
		return resultado;
	}//fin getOficinaPrincipal	

	/**
	 * Obtiene Numero de Secuencia para asignarlo a un Nuevo Abonado
	 * @param abonado
	 * @return abonado
	 * @throws CustomerDomainException
	 */

	public AbonadoDTO getSecuenciaAbonado(AbonadoDTO abonado) throws CustomerDomainException {
		cat.debug("Inicio:getSecuenciaAbonado()");
		abonado = abonadoDAO.getSecuenciaAbonado(abonado);
		cat.debug("Fin:getSecuenciaAbonado()");
		return abonado;
	}

	/**
	 * Crea Abonado
	 * @param entrada
	 * @return
	 * @throws CustomerDomainException
	 */
	public void creaAbonado(AbonadoDTO entrada) throws CustomerDomainException {
		cat.debug("Inicio:creaAbonado()");
		abonadoDAO.creaAbonado(entrada);
		cat.debug("Fin:creaAbonado()");
	}

	/**
	 * Asocia simcard con abonado en tabla ga_equipaboser
	 * @param entrada
	 * @return
	 * @throws CustomerDomainException
	 */
	public void creaSimcardAboser(AbonadoDTO entrada) throws CustomerDomainException {
		cat.debug("Inicio:creaSimcardAboser()");
		abonadoDAO.creaSimcardAboser(entrada);
		cat.debug("Fin:creaSimcardAboser()");
	}

	/**
	 * Asocia terminal con abonado en tabla ga_equipaboser
	 * @param entrada
	 * @return
	 * @throws CustomerDomainException
	 */
	public void creaTerminalAboser(AbonadoDTO entrada) throws CustomerDomainException {
		cat.debug("Inicio:creaTerminalAboser()");
		abonadoDAO.creaTerminalAboser(entrada);
		cat.debug("Fin:creaTerminalAboser()");
	}

	/**
	 * Obtiene Listado de abonados asociados a un numero de venta
	 * @param entrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public AbonadoDTO[] getListaAbonadosVenta(RegistroVentaDTO entrada) throws CustomerDomainException {
		AbonadoDTO[] resultado;
		cat.debug("Inicio:creaTerminalAboser()");
		resultado = abonadoDAO.getListaAbonadosVenta(entrada);
		cat.debug("Fin:creaTerminalAboser()");
		return resultado;
	}//fin getListaAbonadosVenta

	/**
	 * inserta monto garantia asociada al abonado
	 * @param entrada
	 * @return 
	 * @throws CustomerDomainException
	 */
	public void insertaGarantiaAbonado(AbonadoDTO entrada) throws CustomerDomainException {
		cat.debug("Inicio:insertaGarantiaAbonado()");
		abonadoDAO.insertaGarantiaAbonado(entrada);
		cat.debug("Fin:insertaGarantiaAbonado()");
	} //insertaGarantiaAbonado

	/**
	 * Obtiene Listado de equipos seriados
	 * @param abonado
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public AbonadoDTO[] getEquiposSeriados(AbonadoDTO abonado) throws CustomerDomainException {
		AbonadoDTO[] resultado;
		cat.debug("Inicio:getEquiposSeriados()");
		resultado = abonadoDAO.getEquiposSeriados(abonado);
		cat.debug("Fin:getEquiposSeriados()");
		return resultado;
	}//fin getEquiposSeriados

	/**
	 * Actualiza tabla ga_equipaboser
	 * @param entrada
	 * @return void
	 * @throws CustomerDomainException
	 */
	public void actualizaEquipAboSer(AbonadoDTO entrada) throws CustomerDomainException {
		cat.debug("Inicio:actualizaEquipAboSer()");
		abonadoDAO.actualizaEquipAboSer(entrada);
		cat.debug("Fin:actualizaEquipAboSer()");
	}//fin actualizaEquipAboSer

	/**
	 * Actualiza código situación del abonado
	 * @param abonado
	 * @return 
	 * @throws CustomerDomainException
	 */
	public void updCodigoSituacion(AbonadoDTO abonadoDTO) throws CustomerDomainException {
		cat.debug("Inicio:updCodigoSituacion()");
		abonadoDAO.updCodigoSituacion(abonadoDTO);
		cat.debug("Fin:updCodigoSituacion()");
	}//fin updCodigoSituacion

	/**
	 * Actualiza código situación del abonado por num abonado
	 * @param abonado
	 * @return 
	 * @throws CustomerDomainException
	 */
	public void updCodigoSituacionAbo(AbonadoDTO abonadoDTO) throws CustomerDomainException {
		cat.debug("Inicio:updCodigoSituacionAbo()");
		abonadoDAO.updCodigoSituacionAbo(abonadoDTO);
		cat.debug("Fin:updCodigoSituacionAbo()");
	}//fin updCodigoSituacionAbo

	/**
	 * Actualiza clase servicio para el abonado
	 * @param abonado
	 * @return abonado
	 * @throws CustomerDomainException
	 */
	public void updAbonadoClaseServ(AbonadoDTO abonado) throws CustomerDomainException {
		cat.debug("Inicio:updAbonadoClaseServ()");
		abonadoDAO.updAbonadoClaseServ(abonado);
		cat.debug("Fin:updAbonadoClaseServ()");
	}//fin updAbonadoClaseServ

	public void validarPlanCompartido(Long codCliente, String codPlanTarif) throws CustomerDomainException {
		cat.debug("Inicio:validarPlanCompartido()");
		abonadoDAO.validarPlanCompartido(codCliente, codPlanTarif);
		cat.debug("Fin:validarPlanCompartido()");
	}//fin validarPlanCompartido

	/**
	 * Crea Abonado
	 * @param entrada
	 * @return
	 * @throws CustomerDomainException
	 */
	public void creaAbonadoPrepago(AbonadoDTO entrada) throws CustomerDomainException {
		cat.debug("Inicio:creaAbonadoPrepago()");
		abonadoDAO.creaAbonadoPrepago(entrada);
		cat.debug("Fin:creaAbonadoPrepago()");
	}

	public AbonadoDTO[] getListadoAbonadosVenta(AbonadoDTO entrada) throws CustomerDomainException {
		AbonadoDTO[] resultado;
		cat.debug("Inicio:getListadoAbonadosVenta()");
		resultado = abonadoDAO.getListadoAbonadosVenta(entrada);
		cat.debug("Fin:getListadoAbonadosVenta()");
		return resultado;
	}

	public void eliminaAbonado(AbonadoDTO entrada) throws CustomerDomainException {
		cat.debug("Inicio:eliminaAbonado()");
		abonadoDAO.eliminaAbonado(entrada);
		cat.debug("Fin:eliminaAbonado()");
	}

	/**
	 * Obtiene Listado de abonados carrier asociados a un numero de venta
	 * @param entrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public AbonadoDTO[] getListaAbonadosCarrier(Long entrada) throws CustomerDomainException {
		AbonadoDTO[] resultado;
		cat.debug("Inicio:getListaAbonadosCarrier()");
		resultado = abonadoDAO.getListaAbonadosCarrier(entrada);
		cat.debug("Fin:getListaAbonadosCarrier()");
		return resultado;
	}//fin getListaAbonadosCarrier

	public AbonadoDTO[] obtenerAbonadosDistribuidos(AbonadoDTO entrada) throws CustomerDomainException {
		cat.info("obtenerAbonadosDistribuidos:star");
		AbonadoDTO[] resultado = abonadoDAO.obtenerAbonadosDistribuidos(entrada);
		cat.info("obtenerAbonadosDistribuidos:star");
		return resultado;
	} //obtenerAbonadosDistribuidos

	public String getDatosInstalacion(Long numAbonado) throws CustomerDomainException {
		cat.info("getDatosInstalacion:star");
		String resultado = abonadoDAO.getDatosInstalacion(numAbonado);
		cat.info("getDatosInstalacion:star");
		return resultado;
	}

	public void insertaNivelesAbonado(NivelAbonadoDTO entrada) throws CustomerDomainException {
		cat.debug("Inicio:insertaNivelesAbonado()");
		abonadoDAO.insertaNivelesAbonado(entrada);
		cat.debug("Inicio:insertaNivelesAbonado()");
	}

	public void insertaDatosAdicAbonado(RenovacionAbonadoDTO entrada) throws CustomerDomainException {
		cat.debug("Inicio:insertaDatosAdicAbonado()");
		abonadoDAO.insertaDatosAdicAbonado(entrada);
		cat.debug("Inicio:insertaDatosAdicAbonado()");
	}

	public void updWimaxMacAddress(AbonadoDTO entrada) throws CustomerDomainException {
		cat.debug("Inicio:updWimaxMacAddress()");
		abonadoDAO.updWimaxMacAddress(entrada);
		cat.debug("Inicio:updWimaxMacAddress()");
	}

	public void updEstadoMovProductoSolicitud(Long numVenta) throws CustomerDomainException {
		cat.debug("Inicio:updEstadoMovProductoSolicitud()");
		abonadoDAO.updEstadoMovProductoSolicitud(numVenta);
		cat.debug("Inicio:updEstadoMovProductoSolicitud()");
	}

	/**
	 * @author JIB
	 * @param numSerie
	 * @param codSituacion
	 * @return
	 * @throws CustomerDomainException
	 */
	public boolean existeAbonadoXSimcard(Long numSerie)
			throws CustomerDomainException {
		final String nombreMetodo = "existeAbonadoXSimcard";
		cat.info(nombreMetodo + ", inicio");
		boolean r = abonadoDAO.existeAbonadoXSimcard(numSerie);
		cat.debug("resultado [" + r + "]");
		cat.info(nombreMetodo + ", fin");
		return r;
	}

	/**
	 * @author JIB
	 * @param numImei
	 * @return
	 * @throws CustomerDomainException
	 */
	public boolean existeAbonadoXImei(Long numImei)
			throws CustomerDomainException {
		final String nombreMetodo = "existeAbonadoXImei";
		cat.info(nombreMetodo + ", inicio");
		boolean	r = abonadoDAO.existeAbonadoXImei(numImei);
		cat.debug("resultado [" + r + "]");
		cat.info(nombreMetodo + ", fin");
		return r;
	}

}//fin class Abonado
