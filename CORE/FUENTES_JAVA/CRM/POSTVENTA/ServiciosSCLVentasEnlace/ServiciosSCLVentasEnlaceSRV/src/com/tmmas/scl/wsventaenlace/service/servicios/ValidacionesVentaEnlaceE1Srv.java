package com.tmmas.scl.wsventaenlace.service.servicios;

import com.tmmas.scl.wsventaenlace.businessobject.bo.ValidacionesVentaEnlaceE1BO;
import com.tmmas.scl.wsventaenlace.common.exception.ServicioVentasEnlaceException;
import com.tmmas.scl.wsventaenlace.common.helper.GlobalProperties;
import com.tmmas.scl.wsventaenlace.common.helper.LoggerHelper;
import com.tmmas.scl.wsventaenlace.transport.dto.OOSSDTO;
import com.tmmas.scl.wsventaenlace.transport.dto.ventaenlace.ValidacionesVentaEnlaceE1DTO;
import com.tmmas.scl.wsventaenlace.transport.dto.ventaenlace.VentaEnlaceE1DTO;
import com.tmmas.scl.wsventaenlace.transport.vo.AbonadoVO;
import com.tmmas.scl.wsventaenlace.transport.vo.DatosGeneralesVO;
import com.tmmas.scl.wsventaenlace.transport.vo.ventaenlace.VentaEnlaceE1VO;

public class ValidacionesVentaEnlaceE1Srv implements OOSSSrvIT {
	private final LoggerHelper logger = LoggerHelper.getInstance();
	private static final String nombreClase = ValidacionesVentaEnlaceE1Srv.class.getName();
	private GlobalProperties global = GlobalProperties.getInstance();

	/**
	 * @param oOSSDTO
	 * @return
	 * @throws ProyectoException
	 * @see com.tmmas.scl.wsfranquicias.service.servicios.interfaces.OOSSSrvIT#cargaGenericaDatos(com.tmmas.scl.wsfranquicias.common.dto.OOSSDTO)
	 */
	public OOSSDTO validaAbonadoVPN(OOSSDTO oOSSDTO) throws ServicioVentasEnlaceException {

		DatosGeneralesVO datosGeneralesVO = new DatosGeneralesVO();
		ValidacionesVentaEnlaceE1BO ventaEnlaceE1BO = new ValidacionesVentaEnlaceE1BO();
		String codigoError = null;
		String desError = null;
		AbonadoVO abonadoVO = new AbonadoVO();
		VentaEnlaceE1VO ventaEnlaceE1VO = new VentaEnlaceE1VO();

		logger.info("validaAbonadoVPN():start", nombreClase);
		ValidacionesVentaEnlaceE1DTO validacionesVentaEnlaceE1DTO = null;
		VentaEnlaceE1DTO ventaEnlaceE1DTO = null;
		datosGeneralesVO.setCodModulo(global.getValor("VVE.COD_MODULO.SRV"));// COD_MODULO
		datosGeneralesVO.setCodProducto(new Long(global.getValor("VVE.COD_PRODUCTO.SRV")).longValue());// COD_PRODUCTO

		try {
			validacionesVentaEnlaceE1DTO = (ValidacionesVentaEnlaceE1DTO) oOSSDTO;
			ventaEnlaceE1DTO = validacionesVentaEnlaceE1DTO.getVentaEnlaceE1DTO();

			datosGeneralesVO.setNomParametro(global.getValor("VVE.param.EnlaceFija.SRV")); // NOM_PARAMETRO

			ventaEnlaceE1BO.consultaParametros(datosGeneralesVO);
			ventaEnlaceE1VO.setEnlaceFija(datosGeneralesVO.getValParametro());
			logger.info("validaAbonadoVPN():consultaParametros CU-001 RSIS009 MIX09002 ", nombreClase);

			if (ventaEnlaceE1VO.getEnlaceFija().equalsIgnoreCase("TRUE")) {
				datosGeneralesVO.setCodModulo(global.getValor("GE.cod.modulo.almacenamiento.SRV"));
				datosGeneralesVO.setNomParametro(global.getValor("VVE.param.CenFija.SRV")); // NOM_PARAMETRO
				ventaEnlaceE1BO.consultaParametros(datosGeneralesVO);
				ventaEnlaceE1VO.setCenFija(datosGeneralesVO.getValParametro());
				logger.info("validaAbonadoVPN():consultaParametros CU-001 RSIS009 MIX09002 ", nombreClase);

				datosGeneralesVO.setNomParametro(global.getValor("VVE.param.PrefijoNumFija.SRV")); // NOM_PARAMETRO
				datosGeneralesVO.setCodModulo(global.getValor("VVE.COD_MODULO.SRV"));
				ventaEnlaceE1BO.consultaParametros(datosGeneralesVO);
				ventaEnlaceE1VO.setPrefijoNumFija(datosGeneralesVO.getValParametro());
				logger.info("validaAbonadoVPN():consultaParametros CU-001 RSIS009 MIX09002 ", nombreClase);
			}

			// Se cargan los datos del abonado CU-001(4 y 11)
			abonadoVO.setNumAbonado(ventaEnlaceE1DTO.getNumAbonado());
			
			ventaEnlaceE1BO.consultarAbonadoPostPago(abonadoVO);
			ventaEnlaceE1VO.setAbonadoVO(abonadoVO);
			
			if (ventaEnlaceE1DTO.getCodOs() != null && ventaEnlaceE1DTO.getCodOs().equals(global.getValor("RSC.codOOSS"))) {
				if (!ventaEnlaceE1BO.validaIndRehabilitacionAbonado(abonadoVO.getIndRehabi())) {
					throw new ServicioVentasEnlaceException("ERR.0018", 18, global.getValor("ERR.0018"));
				}
			}

			// La capa de negocio valida que el parámetro ENLACE_FIJA es TRUE CU-001 RSIS009 MIX09002
			if (ventaEnlaceE1VO.getEnlaceFija() != null && ventaEnlaceE1VO.getEnlaceFija().equalsIgnoreCase("TRUE") && ventaEnlaceE1VO.getCenFija() != null && ventaEnlaceE1VO.getPrefijoNumFija() != null) {
				System.out.println("Paso por validacion de enlace_fija");
				// La capa de negocio valida que la central del abonado es fija CU-001 RSIS009 MIX09002

				String[] arrayCentralesFijas = ventaEnlaceE1VO.getCenFija().split(",");
				boolean esFija = false;

				for (int i = 0; i < arrayCentralesFijas.length; i++) {
					if (arrayCentralesFijas[i].equals(String.valueOf(abonadoVO.getCodCentral().intValue()))) {
						System.out.println("Despliega central fija: " + arrayCentralesFijas[i]);
						esFija = true;
						break;
					}
				}

				if (esFija) {
					System.out.println("Central la valida como fija");
					// La capa de negocio valida que su número celular divisible por 100
					// y el prefijo inicial del número celular es igual al parámetro PREFIJO_NUM_FIJA ,
					// para definir un número PILOTO
					String prefijo = String.valueOf(abonadoVO.getNumCelular().longValue()).substring(0, 1);

					if (!((abonadoVO.getNumCelular().longValue() % 100) == 0) || !(prefijo.equals(ventaEnlaceE1VO.getPrefijoNumFija()))) {
						throw new ServicioVentasEnlaceException("ERR.0700", 700, global.getValor("ERR.0700"));
					}
					// if (((abonadoVO.getNumCelular().longValue() % 100) == 0) && (prefijo.equals(ventaEnlaceE1VO.getPrefijoNumFija())) ){
					// //La capa de negocio valida que el número piloto esta activo de SCL
					// //SE HACE LA LLAMADA AL DAO CORRESPONDIENTE
					// ventaEnlaceE1BO.validaNumeroPilotoActivo(ventaEnlaceE1VO);
					//						
					// //La capa de negocio asigna la actuación 'SR' (suspensión total fija)
					// //y el código servicio de suspensión 188 (SUSP/REHA FIJO – CDMA)
					// if (!ventaEnlaceE1VO.isPilotoActivo()) {
					// throw new ProyectoException("ERR.0701",701,global.getValor("ERR.0701"));
					// }
					// } else {
					// //Lanza error
					// throw new ProyectoException("ERR.0700",700,global.getValor("ERR.0700"));
					// }
				} else {
					throw new ServicioVentasEnlaceException("ERR.0702", 702, global.getValor("ERR.0702"));
				}
			} else {
				throw new ServicioVentasEnlaceException("ERR.0703", 703, global.getValor("ERR.0703"));
			}

			validacionesVentaEnlaceE1DTO.setVentaEnlaceE1VO(ventaEnlaceE1VO);
			validacionesVentaEnlaceE1DTO.setVentaEnlaceE1DTO(ventaEnlaceE1DTO);
		} catch (Exception e) {
			e.printStackTrace();

			if (e instanceof ServicioVentasEnlaceException) {
				ServicioVentasEnlaceException e1 = (ServicioVentasEnlaceException) e;
				codigoError = e1.getCodigo();
				desError = e1.getDescripcionEvento();
			} 

			if (validacionesVentaEnlaceE1DTO == null)
				validacionesVentaEnlaceE1DTO = new ValidacionesVentaEnlaceE1DTO();

			if (ventaEnlaceE1DTO == null)
				ventaEnlaceE1DTO = new VentaEnlaceE1DTO();

			if (desError != null && codigoError != null) {
				ventaEnlaceE1DTO.setCodError(codigoError);
				ventaEnlaceE1DTO.setDesError(desError);
			} else {
				ventaEnlaceE1DTO.setCodError("ERR_0200");
				ventaEnlaceE1DTO.setDesError(global.getValor("ERR.0200"));
			}
			validacionesVentaEnlaceE1DTO.setVentaEnlaceE1DTO(ventaEnlaceE1DTO);
		} finally {
			logger.info("validaAbonadoVPN: ", nombreClase);

			logger.info("validaAbonadoVPN: end", nombreClase);
		}
		logger.info("validaAbonadoVPN():end", nombreClase);

		return validacionesVentaEnlaceE1DTO;
	}

	public OOSSDTO ejecutarOS(OOSSDTO oOSSDTO) throws ServicioVentasEnlaceException {
		// TODO Auto-generated method stub
		return null;
	}

	public OOSSDTO cargaGenericaDatos(OOSSDTO oOSSDTO) throws ServicioVentasEnlaceException {
		// TODO Auto-generated method stub
		return null;
	}
}
