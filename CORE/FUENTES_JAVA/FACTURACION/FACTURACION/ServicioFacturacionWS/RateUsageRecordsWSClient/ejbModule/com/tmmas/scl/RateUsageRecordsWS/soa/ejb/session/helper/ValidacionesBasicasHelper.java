/**
 * Copyright © 2008 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 09/09/2008         Hernán Segura Muñoz                  Versión Inicial 
 * 
 *
 * 
 * ValidacionesBasicasHelper
 * @author Hernán Segura Muñoz 
 * @version 1.0
 **/
package com.tmmas.scl.RateUsageRecordsWS.soa.ejb.session.helper;

import org.apache.commons.configuration.CompositeConfiguration;

import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.scl.framework.CustomerDomain.CustomerBillABE.dto.CabeceraDocumentoDTO;
import com.tmmas.scl.framework.CustomerDomain.CustomerBillABE.dto.CargoDTO;
import com.tmmas.scl.framework.CustomerDomain.CustomerBillABE.dto.DescuentoDTO;
import com.tmmas.scl.framework.CustomerDomain.CustomerBillABE.dto.DetalleDocumentoDTO;
import com.tmmas.scl.framework.CustomerDomain.CustomerBillABE.dto.FacturaMiscelaneaEntradaDTO;
import com.tmmas.scl.framework.CustomerDomain.CustomerBillABE.dto.FacturaMiscelaneaSalidaDTO;
import com.tmmas.scl.framework.CustomerDomain.exception.RateUsageRecordsException;

public class ValidacionesBasicasHelper {

	/*
	 * private static Logger logger = Logger
	 * .getLogger(ValidacionesBasicasHelper.class);
	 */
	private CompositeConfiguration config;

	/**
	 * Este constructor llama a los archivos de propiedades (el geral que esta
	 * en un directorio gral del servidor y el archivo de propiedades interno).
	 * 
	 */
	public ValidacionesBasicasHelper() {
		super();
		config = UtilProperty
				.getConfiguration("ServicioFacturacionWS.properties",
						"com/tmmas/scl/framework/properties/archivorecursos.properties");
	}

	/**
	 * Chequea que los parametros de un DTO "FacturaMiscelaneaEntradaDTOValido"
	 * cumplan con las validacioens básicas, si no, retorna el error
	 * corrospondiente en el DTO de salida
	 * 
	 * @param facturaMiscelaneaEntradaDTO
	 * @return
	 * @throws Exception
	 */
	public FacturaMiscelaneaSalidaDTO getFacturaMiscelaneaEntradaDTOValido(
			FacturaMiscelaneaEntradaDTO facturaMiscelaneaEntradaDTO)
			throws RateUsageRecordsException {

		FacturaMiscelaneaSalidaDTO facturaMiscelaneaSalidaDTO = new FacturaMiscelaneaSalidaDTO();
		CabeceraDocumentoDTO cabeceraDocumentoDTO = facturaMiscelaneaEntradaDTO
				.getCabeceraDocumento();
		DetalleDocumentoDTO detalleDocumentoDTO = facturaMiscelaneaEntradaDTO
				.getDetalleDocumento();

		if (!validaCodCliete(cabeceraDocumentoDTO.getCodigoCliente())) {
			return putErrors(config.getString("cod_error_codCliente"), config
					.getString("msg_error_codCliente"));
		}

		if (!validaFechaVencimiento(cabeceraDocumentoDTO.getFechaVencimiento())) {
			return putErrors(config.getString("cod_error_fechaVencimiento"),
					config.getString("msg_error_fechaVencimiento"));
		}

		if (!validaModalidadCobro(facturaMiscelaneaEntradaDTO
				.getModalidadCobro())) {
			return putErrors(config.getString("cod_error_modalidadCobro"),
					config.getString("msg_error_modalidadCobro"));
		}

		if (!validaNumeroCuotas(facturaMiscelaneaEntradaDTO.getNumeroCuotas(),
				Integer.parseInt(facturaMiscelaneaEntradaDTO
						.getModalidadCobro().trim()))) {
			return putErrors(config.getString("cod_error_numeroCuotas"), config
					.getString("msg_error_numeroCuotas"));
		}

		if (!validaTipoDocumento(facturaMiscelaneaEntradaDTO.getTipoDocumento())) {
			return putErrors(config.getString("cod_error_tipoDocumento"),
					config.getString("msg_error_tipoDocumento"));
		}

		if (!validaMoneda(facturaMiscelaneaEntradaDTO.getMoneda())) {
			return putErrors(config
					.getString("cod_error_monedaConceptosDocumentos"), config
					.getString("msg_error_monedaConceptosDocumentos"));
		}

		if (!validaTipoObservacionMensaje(facturaMiscelaneaEntradaDTO
				.getTipoGlosa())) {
			return putErrors(config
					.getString("cod_error_tipoObservacionMensaje"), config
					.getString("msg_error_tipoObservacionMensaje"));
		}

		if (!validaGlosa(cabeceraDocumentoDTO.getGlosa())) {
			return putErrors(config.getString("cod_error_glosa"), config
					.getString("msg_error_glosa"));
		}

		if (!validaUsuarioEjecutor(facturaMiscelaneaEntradaDTO
				.getUsuarioSistema())) {
			return putErrors(config.getString("cod_error_usuarioEjecutor"),
					config.getString("msg_error_usuarioEjecutor"));
		}
		if (!validaUsuarioEjecutor(facturaMiscelaneaEntradaDTO
				.getUsuarioSistema())) {
			return putErrors(config.getString("cod_error_usuarioEjecutor"),
					config.getString("msg_error_usuarioEjecutor"));
		}

		// valida los cargos...
		CargoDTO[] listConceptosDTO = null;
		CargoDTO cargoDTO = null;
		if (detalleDocumentoDTO != null)
			listConceptosDTO = detalleDocumentoDTO.getListCargoDTO();

		if (listConceptosDTO != null
				&& listConceptosDTO.length > 0
				&& listConceptosDTO.length <= Integer.parseInt(config
						.getString("cantidadconceptos"))) {

			for (int i = 0; i < listConceptosDTO.length; i++) {

				cargoDTO = (CargoDTO) listConceptosDTO[i];

				if (cargoDTO == null || !validaCantidad(cargoDTO.getCantidad())) {
					return putErrors(config.getString("cod_error_cantidad"),
							config.getString("msg_error_cantidad"));
				}

				if (!validaCodigoConcepto(cargoDTO.getCodigoConceptoCargo())) {
					return putErrors(config
							.getString("cod_error_codigoconceptocargo"), config
							.getString("msg_error_codigoconceptocargo"));
				}
				DescuentoDTO[] descuetnoDTO = cargoDTO.getDescuentoDTO();
				// valida conceptos repetidos
				if (!cargosRepetidos(listConceptosDTO)) {
					return putErrors(config
							.getString("cod_error_cargorepetidos"), config
							.getString("msg_error_cargorepetidos")
							+ " repetidos");
				}
				if (descuetnoDTO != null && descuetnoDTO.length > 0) {

					if (!validaCodigoConcepto(descuetnoDTO[0]
							.getCodigoConceptoDescuento())) {
						return putErrors(
								config
										.getString("cod_error_codigoconceptodcto"),
								config
										.getString("msg_error_codigoconceptodcto"));
					}
					if (!validaTipoMontoPorcentaje(descuetnoDTO[0]
							.getTipoMonto())) {
						return putErrors(
								config
										.getString("cod_error_tipomontoporcentaje"),
								config
										.getString("msg_error_tipomontoporcentaje"));
					}

				}
				/*
				 * if (cargoDTO == null || !validaValorUnitarioConcepto(cargoDTO
				 * .getImporteUnitario())) { return putErrors(config
				 * .getString("cod_error_valorUnitarioConcepto"),
				 * config.getString("msg_error_valorUnitarioConcepto")); }
				 */

			}
		} else {
			return putErrors(config.getString("cod_error_cantidad"), config
					.getString("msg_error_cantidad"));
		}

		return facturaMiscelaneaSalidaDTO;
	}

	/**
	 * cod_error_codCliente= 10 msg_error_codCliente= Codigo cliente
	 * 
	 * @param codCliente
	 * @return
	 */
	private boolean validaCodCliete(String codCliente) {
		if (codCliente != null && !codCliente.trim().equals("")) {
			return true;
		}
		return false;

	}

	/**
	 * cod_error_fechaVencimiento= 30 msg_error_fechaVencimiento= Fecha
	 * vencimiento
	 * 
	 * @param fechaVencimiento
	 * @return
	 */
	private boolean validaFechaVencimiento(String fechaVencimiento) {
		if (fechaVencimiento != null && !fechaVencimiento.trim().equals("")) {
			return true;
		}
		return false;

	}

	/**
	 * Valida tipo de factura cod_error_modalidadCobro= 40
	 * msg_error_modalidadCobro= Modalidad de cobro
	 * 
	 * @param modalidadCobro
	 * @return
	 * @throws Exception
	 */
	private boolean validaModalidadCobro(String modalidadCobro)
			throws RateUsageRecordsException {
		try {
			if (modalidadCobro != null
					&& !modalidadCobro.trim().equals("")
					&& (0 < Integer.parseInt(modalidadCobro.trim()) &&  Integer
							.parseInt(modalidadCobro.trim())<=4 )) {
				return true;
			}
		} catch (Exception e) {
			throw new RateUsageRecordsException(config.getString("cod_error_modalidadCobro"), 0, config.getString("msg_error_modalidadCobro") + e.getMessage());				

		}

		return false;

	}

	/**
	 * cod_error_numeroCuotas= 50 msg_error_numeroCuotas= Numero de cuotas
	 * 
	 * @param numeroCuotas
	 * @return
	 * @throws Exception
	 */
	private boolean validaNumeroCuotas(String numeroCuotas, int modalidadCobro)
			throws RateUsageRecordsException {
		if (numeroCuotas != null && !"".equals(numeroCuotas.trim())) {
			try {
				if (modalidadCobro <= 2
						&& Long.parseLong(numeroCuotas.trim()) == 0) {
					return true;
				} else if (modalidadCobro > 2
						&& Long.parseLong(numeroCuotas.trim()) > 0) {
					return true;
				} else
					return false;

			} catch (Exception e) {
				throw new RateUsageRecordsException(config.getString("cod_error_numeroCuotas"), 0, config.getString("msg_error_numeroCuotas") + e.getMessage());				


			}
		}
		return false;
	}

	/**
	 * cod_error_tipoDocumento= 60 msg_error_tipoDocumento= Tipo documento
	 * 
	 * @param numeroCuotas
	 * @return
	 */
	private boolean validaTipoDocumento(String tipoDocumento) {

		if (tipoDocumento != null
				&& ("F".equalsIgnoreCase(tipoDocumento.trim()) || "B"
						.equalsIgnoreCase(tipoDocumento.trim()))) {
			return true;
		}
		return false;
	}

	/**
	 * cod_error_monedaConceptosDocumentos= 70
	 * msg_error_monedaConceptosDocumentos= Moneda de los conceptos del
	 * 
	 * @param tipoDocumento
	 * @return
	 */
	private boolean validaMoneda(String monedaConceptosDocumentos) {
		if (monedaConceptosDocumentos != null
				&& !"".equals(monedaConceptosDocumentos.trim())) {
			return true;
		}
		return false;

	}

	/**
	 * cod_error_tipoObservacionMensaje= 80 msg_error_tipoObservacionMensaje=
	 * Tipo de observación / mensaje
	 * 
	 * @param monedaConceptosDocumentos
	 * @return
	 * @throws Exception 
	 */
	private boolean validaTipoObservacionMensaje(String tipoObservacionMensaje) throws RateUsageRecordsException {
		try {
		if (tipoObservacionMensaje == null
				|| "".equals(tipoObservacionMensaje.trim())
				|| (Integer.parseInt(tipoObservacionMensaje.trim()) > 0 && Integer
						.parseInt(tipoObservacionMensaje.trim()) < 3)) {
			return true;
		}
		} catch (Exception e) {
			throw new RateUsageRecordsException(config.getString("cod_error_tipoObservacionMensaje"), 0, config.getString("msg_error_tipoObservacionMensaje") + e.getMessage());			
		}
		return false;

	}

	/**
	 * cod_error_glosa= 90 msg_error_glosa= Observación / glosa mensaje
	 * 
	 * @param usuarioEjecutor
	 * @return
	 */
	private boolean validaGlosa(String glosa) {

		return true;

	}

	/**
	 * cod_error_usuarioEjecutor= 100 msg_error_usuarioEjecutor= usuario
	 * ejecutor
	 * 
	 * @param tipoObservacionMensaje
	 * @return
	 */
	private boolean validaUsuarioEjecutor(String usuarioEjecutor) {
		if (usuarioEjecutor != null && !"".equals(usuarioEjecutor.trim())) {
			return true;
		}
		return false;

	}

	/**
	 * cod_error_cantidad= 120 msg_error_cantidad= Cantidad / unidades del
	 * concepto
	 * 
	 * @param codigoConceptoFacturable
	 * @return
	 * @throws Exception 
	 */
	private boolean validaCantidad(String cantidad) throws RateUsageRecordsException {
	
		try{
			if (cantidad != null && !"".equals(cantidad.trim())
				&& Long.parseLong(cantidad.trim()) >= 0) {
			return true;
		}
	} catch (Exception e) {
		throw new RateUsageRecordsException(config.getString("cod_error_cantidad"), 0, config.getString("msg_error_cantidad") + e.getMessage());		

	}
		return false;

	}

	/**
	 * cod_error_valorUnitarioConcepto= 130 msg_error_valorUnitarioConcepto=
	 * Valor unitario concepto
	 * 
	 * @param codigoConceptoFacturable
	 * @return
	 * @throws Exception 
	 */
	private boolean validaValorUnitarioConcepto(String valorUnitarioConcepto) throws Exception {
	try{	if (valorUnitarioConcepto != null
				&& !"".equals(valorUnitarioConcepto.trim())
				&& Double.parseDouble(valorUnitarioConcepto.trim()) >= 0) {
			return true;
		}
	} catch (Exception e) {
		throw new Exception(e.getMessage());

	}
		return false;

	}

	/**
	 * cod_error_codFacturableDescuento= 140 msg_error_codFacturableDescuento=
	 * Codigo facturable documento
	 * 
	 * @param codigoConceptoFacturable
	 * @return
	 */
	private boolean validaCodFacturableDescuento(String codFacturableDescuento) {
		if (codFacturableDescuento != null
				&& !"".equals(codFacturableDescuento.trim())) {
			return true;
		}
		return false;

	}

	private boolean validaCodigoConcepto(String codCOncepto) {
		if (codCOncepto != null && !"".equals(codCOncepto.trim())) {
			return true;
		}
		return false;

	}

	/**
	 * cod_error_tipoMontoPorcentaje= 150 msg_error_tipoMontoPorcentaje= Tipo
	 * (monto / porcentaje)
	 * 
	 * @param codigoConceptoFacturable
	 * @return
	 */
	private boolean validaTipoMontoPorcentaje(String tipoMontoPorcentaje) {
		if (tipoMontoPorcentaje != null
				&& !"".equals(tipoMontoPorcentaje)
				&& (tipoMontoPorcentaje.trim().equalsIgnoreCase("P") || tipoMontoPorcentaje
						.trim().equalsIgnoreCase("M"))) {
			return true;

		}
		return false;

	}

	private boolean validaPorcentaje(String tipoMontoPorcentaje,
			String porcentaje) throws Exception {
	try{	if (tipoMontoPorcentaje != null
				&& !"".equals(tipoMontoPorcentaje)
				&& (tipoMontoPorcentaje.trim().equalsIgnoreCase("P")
						&& porcentaje != null && !porcentaje.trim().equals("")
						&& Integer.parseInt(porcentaje) >= 0 && Integer
						.parseInt(porcentaje) <= 1)) {
			return true;
		}
	} catch (Exception e) {
		throw new Exception(e.getMessage());

	}
		return false;

	}

	/**
	 * * cod_error_valorDescuento= 160 msg_error_valorDescuento= Valor Descuento
	 * 
	 * @param codigoConceptoFacturable
	 * @return
	 */
	private boolean validaValorDescuento(String valorDescuento) {
		if (valorDescuento != null && !"".equals(valorDescuento.trim())
				&& Long.parseLong(valorDescuento.trim()) >= 0) {
			return true;
		}
		return false;

	}

	/**
	 * setea el codigo de error y el mensaje de error a un DTO de salida
	 * 
	 * @param codError
	 * @param msnError
	 * @return
	 */
	private FacturaMiscelaneaSalidaDTO putErrors(String codError,
			String msnError) {
		FacturaMiscelaneaSalidaDTO facturaMiscelaneaSalidaDTO = new FacturaMiscelaneaSalidaDTO();
		facturaMiscelaneaSalidaDTO.setSnError(codError);
		facturaMiscelaneaSalidaDTO.setSvMensaje(msnError);
		return facturaMiscelaneaSalidaDTO;
	}

	private boolean cargosRepetidos(CargoDTO[] aCargoDTO) {
		CargoDTO cargoDTO = null, cargoDTO2 = null;
		for (int i = 0; i < aCargoDTO.length; i++) {
			cargoDTO = aCargoDTO[i];
			for (int j = 0; j < aCargoDTO.length; j++) {
				if (i == j)
					continue;
				cargoDTO2 = aCargoDTO[j];
				if (cargoDTO.getCodigoConceptoCargo() != null
						&& cargoDTO2.getCodigoConceptoCargo() != null
						&& cargoDTO.getCodigoConceptoCargo().equalsIgnoreCase(
								cargoDTO2.getCodigoConceptoCargo())) {
					return false;
				}

			}
		}
		return true;

	}

}
