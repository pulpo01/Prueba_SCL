package com.tmmas.scl.wsventaenlace.businessobject.bo;

import com.tmmas.scl.wsventaenlace.businessobject.dao.AsociaDesasociaRangoDAO;
import com.tmmas.scl.wsventaenlace.common.exception.ServicioVentasEnlaceException;
import com.tmmas.scl.wsventaenlace.common.helper.GlobalProperties;
import com.tmmas.scl.wsventaenlace.common.helper.LoggerHelper;
import com.tmmas.scl.wsventaenlace.transport.vo.AbonadoVO;
import com.tmmas.scl.wsventaenlace.transport.vo.CentralesVO;
import com.tmmas.scl.wsventaenlace.transport.vo.ClienteVO;
import com.tmmas.scl.wsventaenlace.transport.vo.DatosGeneralesVO;
import com.tmmas.scl.wsventaenlace.transport.vo.OOSSDatosBasicosClienteVO;
import com.tmmas.scl.wsventaenlace.transport.vo.OOSSRecargaPrepagoVO;
import com.tmmas.scl.wsventaenlace.transport.vo.OOSSVO;
import com.tmmas.scl.wsventaenlace.transport.vo.ParametroGeneralListVO;
import com.tmmas.scl.wsventaenlace.transport.vo.PlanTarifarioVO;
import com.tmmas.scl.wsventaenlace.transport.vo.VendedorVO;
import com.tmmas.scl.wsventaenlace.transport.vo.asociarango.OOSSAsociaRangoVO;

public class AsociaDesasociaRangoBO {
	
	private static final LoggerHelper logger = LoggerHelper.getInstance();
	private static final String nombreClase = AsociaDesasociaRangoBO.class.getName();
	private GlobalProperties global = GlobalProperties.getInstance();
	private AsociaDesasociaRangoDAO asociaDesasociaRangoDAO = new AsociaDesasociaRangoDAO();

	public void insertaMovimientoCentrales(CentralesVO centralesVO) throws ServicioVentasEnlaceException {
		logger.info("insertaMovimientoCentrales:start", nombreClase);
		asociaDesasociaRangoDAO.insertaMovimientoCentrales(centralesVO);
		logger.info("insertaMovimientoCentrales:end", nombreClase);
	}

	public void insertarOOSS(OOSSVO oOSSVO) throws ServicioVentasEnlaceException {
		logger.info("insertarOOSS:start", nombreClase);
		asociaDesasociaRangoDAO.insertarOOSS(oOSSVO);
		logger.info("insertarOOSS:end", nombreClase);
	}

	public void consultarDatosOOSS(OOSSVO oOSSVO) throws ServicioVentasEnlaceException {
		logger.info("consultarDatosOOSS:start", nombreClase);
		asociaDesasociaRangoDAO.consultarDatosOOSS(oOSSVO);
		logger.info("consultarDatosOOSS:end", nombreClase);
	}

	public void consultarNumeroSecuencia(DatosGeneralesVO datosGeneralesVO) throws ServicioVentasEnlaceException {
		logger.info("consultarNumeroSecuencia:start", nombreClase);
		asociaDesasociaRangoDAO.consultarNumeroSecuencia(datosGeneralesVO);
		logger.info("consultarNumeroSecuencia:end", nombreClase);

	}

	public void consultaDatosBasicosCliente(OOSSDatosBasicosClienteVO datosBasicosClienteVO) throws ServicioVentasEnlaceException {
		logger.info("consultaDatosBasicosCliente:start", nombreClase);
		asociaDesasociaRangoDAO.consultaDatosBasicosCliente(datosBasicosClienteVO);
		logger.info("consultaDatosBasicosCliente:end", nombreClase);		
	}

	public void consultaParametros(DatosGeneralesVO datosVO) throws ServicioVentasEnlaceException {
		logger.info("consultaParametros:start", nombreClase);
		asociaDesasociaRangoDAO.consultaParametros(datosVO);
		logger.info("consultaParametros:end", nombreClase);
	}

	public ParametroGeneralListVO consultaParametrosLK(DatosGeneralesVO datosVO) throws ServicioVentasEnlaceException {
		logger.info("consultaParametrosLK:start", nombreClase);
		ParametroGeneralListVO parametros = asociaDesasociaRangoDAO.consultaParametrosLK(datosVO);
		logger.info("consultaParametrosLK:end", nombreClase);
		return parametros;
	}
	
	public void consultaGrupoTecnologico(AbonadoVO abonadoVO) throws ServicioVentasEnlaceException {
		logger.info("consultaGrupoTecnologico:start", nombreClase);
		asociaDesasociaRangoDAO.consultaGrupoTecnologico(abonadoVO);
		logger.info("consultaGrupoTecnologico:end", nombreClase);
	}

	public void validaCicloFactHibrido(OOSSRecargaPrepagoVO ooSSRecargaPrepagoVO) throws ServicioVentasEnlaceException {
		logger.info("validaCicloFactHibrido:start", nombreClase);
		asociaDesasociaRangoDAO.validaCicloFactHibrido(ooSSRecargaPrepagoVO);
		logger.info("validaCicloFactHibrido:end", nombreClase);
	}

	public void consultarDeudaAbonado(AbonadoVO abonadoVO) throws ServicioVentasEnlaceException {
		logger.info("consultarDeudaAbonado:start", nombreClase);
		asociaDesasociaRangoDAO.consultarDeudaAbonado(abonadoVO);
		logger.info("consultarDeudaAbonado:end", nombreClase);
	}

	public void obtenerCategoriaPlanTarifario(PlanTarifarioVO planTarifarioVO) throws ServicioVentasEnlaceException {
		logger.info("obtenerCategoriaPlanTarifario:start", nombreClase);
		asociaDesasociaRangoDAO.obtenerCategoriaPlanTarifario(planTarifarioVO);
		logger.info("obtenerCategoriaPlanTarifario:end", nombreClase);
	}

	public void consultarClienteEmpresa(ClienteVO clienteVO) throws ServicioVentasEnlaceException {
		logger.info("consultarClienteEmpresa:start", nombreClase);
		asociaDesasociaRangoDAO.consultarClienteEmpresa(clienteVO);
		logger.info("consultarClienteEmpresa:end", nombreClase);
	}

	public void consultarAbonadoPostPago(AbonadoVO abonadoVO) throws ServicioVentasEnlaceException {
		logger.info("consultarAbonadoPostPago:start", nombreClase);
		asociaDesasociaRangoDAO.consultarAbonadoPostPago(abonadoVO);
		logger.info("consultarAbonadoPostPago:end", nombreClase);
	}

	public void consultaVendedorUsuario(VendedorVO vendedorVO) throws ServicioVentasEnlaceException {
		logger.info("consultaVendedorUsuario:start", nombreClase);
		asociaDesasociaRangoDAO.consultaVendedorUsuario(vendedorVO);
		logger.info("consultaVendedorUsuario:end", nombreClase);
	}

	public void obtieneRangosAsociados(OOSSAsociaRangoVO asociaRangoVO) throws ServicioVentasEnlaceException {
		logger.info("obtieneRangosAsociados:start", nombreClase);
		asociaDesasociaRangoDAO.obtieneRangosAsociados(asociaRangoVO);
		logger.info("obtieneRangosAsociados:end", nombreClase);	
	}

	public void obtieneRangosDisponibles(OOSSAsociaRangoVO asociaRangoVO) throws ServicioVentasEnlaceException {
		logger.info("obtieneRangosDisponibles:start", nombreClase);
		asociaDesasociaRangoDAO.obtieneRangosDisponibles(asociaRangoVO);
		logger.info("obtieneRangosDisponibles:end", nombreClase);
	}

	public void actualizaEstadoRango(OOSSAsociaRangoVO asociaRangoVO) throws ServicioVentasEnlaceException {
		logger.info("actualizaEstadoRango:start", nombreClase);
		asociaDesasociaRangoDAO.actualizaEstadoRango(asociaRangoVO);
		logger.info("actualizaEstadoRango:end", nombreClase);	
	}

	public void consultaCodigo(OOSSAsociaRangoVO asociaRangoVO) throws ServicioVentasEnlaceException {
		logger.info("consultaCodigo:start", nombreClase);
		asociaDesasociaRangoDAO.consultaCodigo(asociaRangoVO);
		logger.info("consultaCodigo:end", nombreClase);
	}

	public void insertaNumeroPilotoHistorico(OOSSAsociaRangoVO asociaRangoVO) throws ServicioVentasEnlaceException {
		logger.info("insertaNumeroPilotoHistorico:start", nombreClase);
		asociaDesasociaRangoDAO.insertaNumeroPilotoHistorico(asociaRangoVO);
		logger.info("insertaNumeroPilotoHistorico:end", nombreClase);
	}

	public void insertaNumeroPiloto(OOSSAsociaRangoVO asociaRangoVO) throws ServicioVentasEnlaceException {
		logger.info("insertaNumeroPiloto:start", nombreClase);
		asociaDesasociaRangoDAO.insertaNumeroPiloto(asociaRangoVO);
		logger.info("insertaNumeroPiloto:end", nombreClase);
	}

	public void eliminaNumeroPiloto(OOSSAsociaRangoVO asociaRangoVO) throws ServicioVentasEnlaceException {
		logger.info("eliminaNumeroPiloto:start", nombreClase);
		asociaDesasociaRangoDAO.eliminaNumeroPiloto(asociaRangoVO);
		logger.info("eliminaNumeroPiloto:end", nombreClase);		
	}
}
