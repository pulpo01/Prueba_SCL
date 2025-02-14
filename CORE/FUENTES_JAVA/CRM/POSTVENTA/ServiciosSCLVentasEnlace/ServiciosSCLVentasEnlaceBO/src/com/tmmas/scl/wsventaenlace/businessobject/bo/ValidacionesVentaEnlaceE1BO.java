package com.tmmas.scl.wsventaenlace.businessobject.bo;

import com.tmmas.scl.wsventaenlace.businessobject.dao.ValidacionesVentaEnlaceE1DAO;
import com.tmmas.scl.wsventaenlace.common.exception.ServicioVentasEnlaceException;
import com.tmmas.scl.wsventaenlace.common.helper.GlobalProperties;
import com.tmmas.scl.wsventaenlace.common.helper.LoggerHelper;
import com.tmmas.scl.wsventaenlace.transport.vo.AbonadoVO;
import com.tmmas.scl.wsventaenlace.transport.vo.DatosGeneralesVO;
import com.tmmas.scl.wsventaenlace.transport.vo.ParametroGeneralListVO;
import com.tmmas.scl.wsventaenlace.transport.vo.ventaenlace.VentaEnlaceE1VO;

public class ValidacionesVentaEnlaceE1BO {
	private static final LoggerHelper logger = LoggerHelper.getInstance();
	private static final String nombreClase = ValidacionesVentaEnlaceE1BO.class.getName();
	private ValidacionesVentaEnlaceE1DAO ventaEnlaceE1DAO = new ValidacionesVentaEnlaceE1DAO();
	AsociaDesasociaRangoBO asociaDesasociaRangoBO = new AsociaDesasociaRangoBO();
	
	public void validaNumeroPilotoActivo(VentaEnlaceE1VO ventaEnlaceE1VO) throws ServicioVentasEnlaceException {
		logger.info("validaNumeroPilotoActivo():start", nombreClase);
		ventaEnlaceE1DAO.validaNumeroPilotoActivo(ventaEnlaceE1VO);
		logger.info("validaNumeroPilotoActivo():end", nombreClase);
	}
	public boolean validaIndRehabilitacionAbonado(Integer indRehabilitacion){
		logger.info("validaIndRehabilitacionAbonado(): start", nombreClase);
		boolean resultado = false;
		if (indRehabilitacion !=null && indRehabilitacion.toString().equals(GlobalProperties.getInstance().getValor("RSC.indRehabilitacion.SRV")))
			resultado = true;
		logger.info("validaIndRehabilitacionAbonado(): end", nombreClase);
		return resultado;
	}
	public void consultarAbonadoPostPago(AbonadoVO abonadoVO)throws ServicioVentasEnlaceException {
		logger.info("consultarAbonadoPostPago:start", nombreClase);	
		asociaDesasociaRangoBO.consultarAbonadoPostPago(abonadoVO);
		logger.info("consultarAbonadoPostPago:end", nombreClase);
		
	}
	public void consultaParametros(DatosGeneralesVO datosGeneralesVO)throws ServicioVentasEnlaceException  {
		logger.info("consultaParametros:start", nombreClase);	
		asociaDesasociaRangoBO.consultaParametros(datosGeneralesVO);
		logger.info("consultaParametros:end", nombreClase);
		
	}
	public ParametroGeneralListVO consultaParametrosLK(DatosGeneralesVO datosGeneralesVO)throws ServicioVentasEnlaceException  {
		logger.info("consultaParametros:start", nombreClase);	
		ParametroGeneralListVO parametros = asociaDesasociaRangoBO.consultaParametrosLK(datosGeneralesVO);
		logger.info("consultaParametros:end", nombreClase);
		return parametros;
	}	
}
