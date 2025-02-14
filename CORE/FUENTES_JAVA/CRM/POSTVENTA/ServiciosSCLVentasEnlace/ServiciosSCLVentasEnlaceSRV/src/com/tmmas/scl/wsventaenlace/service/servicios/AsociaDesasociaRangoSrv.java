package com.tmmas.scl.wsventaenlace.service.servicios;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.tmmas.scl.wsventaenlace.businessobject.bo.AsociaDesasociaRangoBO;
import com.tmmas.scl.wsventaenlace.businessobject.bo.ValidacionesVentaEnlaceE1BO;
import com.tmmas.scl.wsventaenlace.common.exception.ServicioVentasEnlaceException;
import com.tmmas.scl.wsventaenlace.common.helper.GlobalProperties;
import com.tmmas.scl.wsventaenlace.common.helper.LoggerHelper;
import com.tmmas.scl.wsventaenlace.transport.dto.OOSSDTO;
import com.tmmas.scl.wsventaenlace.transport.dto.asociarango.AsociaRangoDTO;
import com.tmmas.scl.wsventaenlace.transport.dto.asociarango.CargaAsociaRangoDTO;
import com.tmmas.scl.wsventaenlace.transport.dto.asociarango.EjecucionAsociaRangoDTO;
import com.tmmas.scl.wsventaenlace.transport.dto.asociarango.RangoDTO;
import com.tmmas.scl.wsventaenlace.transport.factory.AsociaRangoFactoryDTO;
import com.tmmas.scl.wsventaenlace.transport.factory.AsociaRangoFactoryVO;
import com.tmmas.scl.wsventaenlace.transport.vo.AbonadoVO;
import com.tmmas.scl.wsventaenlace.transport.vo.CentralesVO;
import com.tmmas.scl.wsventaenlace.transport.vo.DatosGeneralesVO;
import com.tmmas.scl.wsventaenlace.transport.vo.OOSSDatosBasicosClienteVO;
import com.tmmas.scl.wsventaenlace.transport.vo.OOSSRecargaPrepagoVO;
import com.tmmas.scl.wsventaenlace.transport.vo.OOSSVO;
import com.tmmas.scl.wsventaenlace.transport.vo.ParametroGeneralListVO;
import com.tmmas.scl.wsventaenlace.transport.vo.ParametroGeneralVO;
import com.tmmas.scl.wsventaenlace.transport.vo.VendedorVO;
import com.tmmas.scl.wsventaenlace.transport.vo.asociarango.NumeroPilotoHVO;
import com.tmmas.scl.wsventaenlace.transport.vo.asociarango.NumeroPilotoVO;
import com.tmmas.scl.wsventaenlace.transport.vo.asociarango.OOSSAsociaRangoVO;
import com.tmmas.scl.wsventaenlace.transport.vo.asociarango.RangoVO;


public class AsociaDesasociaRangoSrv implements OOSSSrvIT {
	private static final long serialVersionUID = 1L;
	private static final LoggerHelper logger = LoggerHelper.getInstance();
	private static final String nombreClase = AsociaDesasociaRangoSrv.class.getName();
	private GlobalProperties global = GlobalProperties.getInstance();
	AsociaDesasociaRangoBO asociaDesasociaRangoBO = new AsociaDesasociaRangoBO();

	public AsociaDesasociaRangoSrv() {
	}

	public OOSSDTO cargaGenericaDatos(OOSSDTO oossdto) throws ServicioVentasEnlaceException {
		logger.info("cargaGenericaDatos: iniciando", nombreClase);

		AsociaRangoDTO asociaRangoDTO = null;
		CargaAsociaRangoDTO cargaAsociaRangoDTO = null;
		String codError = null, desError = null;

		try {
			// Se valida si la OOSS contiene datos
//			if (oossdto == null)
//				throw new ServicioVentasEnlaceException("ERR.0001", 1, global.getValor("ERR.0001"));

			//AsociaRangoBO asociaRangoBO = new AsociaRangoBO();
			OOSSAsociaRangoVO asociaRangoVO = new OOSSAsociaRangoVO();
			
			if (oossdto instanceof AsociaRangoDTO) {				
				try {
					asociaRangoDTO = (AsociaRangoDTO) oossdto;
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
			logger.info(asociaRangoDTO.toString(), nombreClase);

			cargaAsociaRangoDTO = asociaRangoDTO.getCargaAsociaRangoDTO();

			logger.info("cargaGenericaDatos: " + cargaAsociaRangoDTO.toString(), nombreClase);

			// CUS-001 Paso 2: valida el nombre de usuario SCL.
			logger.info("cargaGenericaDatos: por validar usuario SCL", nombreClase);

			VendedorVO vendedorVO = new VendedorVO();
			//VendedorBO vendedorBO = new VendedorBO();
			vendedorVO.setNomUsuarioSCL(cargaAsociaRangoDTO.getNomUsuarioSCL());
			logger.info("------------------------------------------", nombreClase);
			logger.info("--------Consulta Vendedor Usuario---------", nombreClase);
			logger.info("------------------------------------------", nombreClase);
			try {
				asociaDesasociaRangoBO.consultaVendedorUsuario(vendedorVO);
			} catch (ServicioVentasEnlaceException e) {
				throw new ServicioVentasEnlaceException(e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
			}

			AbonadoVO abonadoVO = new AbonadoVO();
			abonadoVO.setNumAbonado(cargaAsociaRangoDTO.getNumAbonado().longValue());

			// CUS-001 Paso 3: obtiene los datos del abonado.
			logger.info("cargaGenericaDatos: por obtener datos del abonado", nombreClase);

			//AbonadoBO abonadoBO = new AbonadoBO();
			logger.info("------------------------------------------", nombreClase);
			logger.info("--------Consulta Abonado Postpago---------", nombreClase);
			logger.info("------------------------------------------", nombreClase);
			try {
				asociaDesasociaRangoBO.consultarAbonadoPostPago(abonadoVO);
			} catch (ServicioVentasEnlaceException e) {
				throw new ServicioVentasEnlaceException(e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
			}

			asociaRangoVO.setAbonado(abonadoVO);

//			// CUS-001 Paso 5: valida que el cliente del abonado sea empresa.
//			logger.info("cargaGenericaDatos: validar cliente empresa", nombreClase);
//
//			//ClienteBO clienteBO = new ClienteBO();
//			ClienteVO clienteVO = new ClienteVO();
//			clienteVO.setCodCliente(abonadoVO.getCodCliente());
//			clienteVO.setCodProducto(new Integer(global.getValor("GE.producto.celular.GE")));
//
//			try {
//				asociaDesasociaRangoBO.consultarClienteEmpresa(clienteVO);
//
//				if (!"E".equals(clienteVO.getTipPlanTarif()))
//					throw new ServicioVentasEnlaceException("ERR.0607", 607, global.getValor("ERR.0607"));
//			} catch (ServicioVentasEnlaceException e) {
//				throw new ServicioVentasEnlaceException(e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
//			}

			// CUS-001 Paso 6: valida el plan tarifario de la empresa
			logger.info("cargaGenericaDatos: por validar plan tarifario", nombreClase);

//			PlanTarifarioVO planTarifarioVO = new PlanTarifarioVO();
//			planTarifarioVO.setCodPlanTarif(abonadoVO.getCodPlanTarif());
//			planTarifarioVO.setCodProducto(Long.valueOf(abonadoVO.getCodProducto()).longValue());
//
//			//PlanTarifarioBO planTarifarioBO = new PlanTarifarioBO();
//
//			try {
//				asociaDesasociaRangoBO.obtenerCategoriaPlanTarifario(planTarifarioVO);
//			} catch (ServicioVentasEnlaceException e) {
//				throw new ServicioVentasEnlaceException("ERR.0606", 606, global.getValor("ERR.0606"));
//			}
//
//			if (planTarifarioVO == null || planTarifarioVO.getCodCategoria() == null || planTarifarioVO.getCodCategoria().equals("") || planTarifarioVO.getCodCategoria().equalsIgnoreCase("null"))
//				throw new ServicioVentasEnlaceException("ERR.0606", 606, global.getValor("ERR.0606"));

			// CUS-001 Paso 7: valida que el cliente no se encuentre en estado de morosidad.
			logger.info("cargaGenericaDatos: por validar cliente no moroso", nombreClase);
			logger.info("------------------------------------------", nombreClase);
			logger.info("-------- Consulta Deuda Abonado  ---------", nombreClase);
			logger.info("------------------------------------------", nombreClase);
			try {
				asociaDesasociaRangoBO.consultarDeudaAbonado(abonadoVO);
			} catch (ServicioVentasEnlaceException e) {
				// TODO: 17JUL2009 PF-PV-25 RQ se lanza excepcion
				throw new ServicioVentasEnlaceException("ERR.0613", 613, global.getValor("ERR.0613"));
			}

			// CUS-001 Paso 8: valida si ciclo de facturacion esta abierto (solo si no viene desde VENTAS)
			//boolean vieneDeVentas = cargaAsociaRangoDTO.getNomCliente() != null && cargaAsociaRangoDTO.getNomCliente().equals(global.getValor("GE.AR.flags.venta.largo.WEB"));

			//if (!vieneDeVentas) {
				logger.info("cargaGenericaDatos: por validar ciclo de facturacion", nombreClase);

				//OOSSRecargaPrepagoBO recargaPrepagoBO = new OOSSRecargaPrepagoBO();
				OOSSRecargaPrepagoVO recargaPrepagoVO = new OOSSRecargaPrepagoVO();

				recargaPrepagoVO.setCodCliente(new Long(abonadoVO.getCodCliente()));
				recargaPrepagoVO.setNumAbonado(new Long(abonadoVO.getNumAbonado()));
				recargaPrepagoVO.setCodCicloFact(abonadoVO.getCodCiclo());
				logger.info("------------------------------------------", nombreClase);
				logger.info("------ Valida Ciclo de Facturacion -------", nombreClase);
				logger.info("------------------------------------------", nombreClase);
				try {
					asociaDesasociaRangoBO.validaCicloFactHibrido(recargaPrepagoVO);
				} catch (ServicioVentasEnlaceException e) {
					throw new ServicioVentasEnlaceException("ERR.0614", 614, global.getValor("ERR.0614"));
				}

				// CUS-001 Paso 9: valida que el número telefónico sea número piloto.
				logger.info("cargaGenericaDatos: por validar número piloto (" + abonadoVO.getNumCelular() + ")", nombreClase);

//				if (((double) abonadoVO.getNumCelular().longValue()) / 100 != (abonadoVO.getNumCelular().longValue() / 100))
//					throw new ServicioVentasEnlaceException("ERR.0602", 602, global.getValor("ERR.0602"));
			//}

			// CUS-001 Paso 10: valida si la situacion del abonado.
			//if (!vieneDeVentas) {
				logger.info("cargaGenericaDatos: por validar situación del abonado", nombreClase);

				if (!abonadoVO.getCodSituacion().equals(global.getValor("GE.AR.codSituacion.activo.SVR")))
					throw new ServicioVentasEnlaceException("ERR.0603", 603, global.getValor("ERR.0603"));
			//}

			// CUS-001 Paso 11: valida la tecnologia del abonado.
//			logger.info("cargaGenericaDatos: por validar tecnología del abonado", nombreClase);
//
//			try {
//				asociaDesasociaRangoBO.consultaGrupoTecnologico(abonadoVO);
//			} catch (ServicioVentasEnlaceException e) {
//				throw new ServicioVentasEnlaceException(e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
//			}

			DatosGeneralesVO datosGeneralesVO = new DatosGeneralesVO();
			//DatosGeneralesBO datosGeneralesBO = new DatosGeneralesBO();

//			datosGeneralesVO.setCodModulo(global.getValor("GE.cod.modulo.gestion.abonado.SRV"));
//			datosGeneralesVO.setCodProducto(new Long(global.getValor("GE.producto.celular.GE")).longValue());
//			datosGeneralesVO.setNomParametro(global.getValor("GE.AR.param.grupoTecnologico.SRV"));
//
//
//			asociaDesasociaRangoBO.consultaParametros(datosGeneralesVO);
//			if (datosGeneralesVO.getValParametro()==null){
//				//daoHelper.evaluaResultado("ERR_BD0124PAN", codError, global.getValor("ERR.0124"));
//				throw new ServicioVentasEnlaceException("ERR.0124", 124, global.getValor("ERR.0124"));
//			}
			

//			if (!abonadoVO.getCodGrupoTecnologia().equals(datosGeneralesVO.getValParametro()))
//				throw new ServicioVentasEnlaceException("ERR.0612", 612, global.getValor("ERR.0612"));

			// CUS-001 Paso 12: valida si el abonado corresponde a un cliente de telefonía fija (cod_central en parametro CEN_FIJAS)
			logger.info("cargaGenericaDatos: por validar telefonía fija", nombreClase);
//
//			datosGeneralesVO.setCodModulo(global.getValor("GE.AR.codCentral.codModulo.abonado.SRV"));
//			datosGeneralesVO.setCodProducto(new Long(global.getValor("GE.producto.celular.GE")).longValue());
//			datosGeneralesVO.setNomParametro(global.getValor("GE.AR.param.codCentral.SVR"));
//
//			try {
//				asociaDesasociaRangoBO.consultaParametros(datosGeneralesVO);
//			} catch (ServicioVentasEnlaceException e) {
//				throw new ServicioVentasEnlaceException(e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
//			}
//
//			String codigos[] = datosGeneralesVO.getValParametro().split(",");
//			boolean ok = false;

//			for (int i = 0; i < codigos.length; i++) {
//				System.out.println("abonadoVO.getCodCentral() = " + abonadoVO.getCodCentral() + " =?= " + Integer.valueOf(codigos[i]));
//
//				if (abonadoVO.getCodCentral().equals(Integer.valueOf(codigos[i]))) {
//					// Es un código de central fija
//					ok = true;
//					break;
//				}
//			}
//
//			if (!ok)
//				throw new ServicioVentasEnlaceException("ERR.0608", 608, global.getValor("ERR.0608"));

			// CUS-001 Paso 13: carga datos del abonado asociado al número piloto, los rangos asociados al número piloto y rangos disponibles en el sistema.
			logger.info("cargaGenericaDatos: por cargar rangos", nombreClase);
			logger.info("------------------------------------------", nombreClase);
			logger.info("-------- Obtiene Rangos Asociados --------", nombreClase);
			logger.info("------------------------------------------", nombreClase);
			// Consulta rangos asociados
			asociaDesasociaRangoBO.obtieneRangosAsociados(asociaRangoVO);
			//filtro para rangos repetidos ini
			List rangosAsoc = asociaRangoVO.getRangosAsociados();
			String idRangoAsc = null;
			String desdeHastaAsc = null;
			Map mapRangosAsc  = new HashMap();
			List rangosAsociadosList = new ArrayList();
			for(int j=0;j<rangosAsoc.size();j++)
			{
				RangoVO rangoVO = (RangoVO)rangosAsoc.get(j);
				idRangoAsc = rangoVO.getNumDesde()+""+rangoVO.getNumHasta();
				desdeHastaAsc = (String) mapRangosAsc.get(idRangoAsc);
				if(desdeHastaAsc == null)//para que no repita los rangos
				{
					mapRangosAsc.put(idRangoAsc, idRangoAsc);
					rangosAsociadosList.add(rangoVO);
				}
			}
			asociaRangoVO.setRangosAsociados(rangosAsociadosList);
			//filtro para rangos repetidos fin
			
			cargaAsociaRangoDTO.setNumAbonado(new Long(asociaRangoVO.getAbonado().getNumAbonado()));
			cargaAsociaRangoDTO.setNumCelular(asociaRangoVO.getAbonado().getNumCelular());
			logger.info("------------------------------------------", nombreClase);
			logger.info("--------Obtiene Rangos Disponibles--------", nombreClase);
			logger.info("------------------------------------------", nombreClase);
			// Obtiene rangos disponibles
			   //Obtiene parametros central
			ValidacionesVentaEnlaceE1BO ventaEnlaceE1BO = new ValidacionesVentaEnlaceE1BO();
			datosGeneralesVO.setCodProducto(new Long(global.getValor("VVE.COD_PRODUCTO.SRV")).longValue());// COD_PRODUCTO
			datosGeneralesVO.setCodModulo(global.getValor("GE.cod.modulo.almacenamiento.SRV"));
			datosGeneralesVO.setNomParametro(global.getValor("VVE.param.CenFija.SRV")); // NOM_PARAMETRO
			ParametroGeneralListVO parametros = ventaEnlaceE1BO.consultaParametrosLK(datosGeneralesVO);
			List rangosDisponiblesList = new ArrayList();
			List rangosDisp  = new ArrayList();
			Map mapCentral = new HashMap();
			Map mapRangos  = new HashMap();
			if(parametros.getParametrosGenerales() != null)
			{
				//Puede haber más de una central configurada para rangos disponibles según el parámetro
				//CEN_FIJAS'X' (CEN_FIJAS1, CEN_FIJAS2, CEN_FIJAS3 etc)
				//con cada parámetro se pueden obtener rangos disponibles
				ParametroGeneralVO parametro = null;
				String valorParam = null;
				String param = null;
				for(int i=0;i<parametros.getParametrosGenerales().length;i++)
				{
					parametro = parametros.getParametrosGenerales()[i];
					valorParam = parametro.getValParametro();
					param = (String) mapCentral.get(valorParam);
					if(param == null)// esto es por si estuviera repetido el parametro central, con lo que no vuelve
					{//a llamar a los mismos rangos de la central
						mapCentral.put(valorParam, valorParam);
						asociaRangoVO.setCodCentral(new Integer(valorParam));
						asociaDesasociaRangoBO.obtieneRangosDisponibles(asociaRangoVO);
						rangosDisp = asociaRangoVO.getRangosDisponibles();
						String idRango = null;
						String desdeHasta = null;
						for(int j=0;j<rangosDisp.size();j++)
						{
							RangoVO rangoVO = (RangoVO)rangosDisp.get(j);
							idRango = rangoVO.getNumDesde()+""+rangoVO.getNumHasta();
							desdeHasta = (String) mapRangos.get(idRango);
							if(desdeHasta == null)//para que no repita los rangos
							{
								mapRangos.put(idRango, idRango);
								rangosDisponiblesList.add(rangoVO);
							}
						}
						//rangosDisponiblesList.addAll(rangosDisp);	
					}
				}
			}
			asociaRangoVO.setRangosDisponibles(rangosDisponiblesList);
			/*asociaRangoVO.setCodCentral(abonadoVO.getCodCentral());
			asociaDesasociaRangoBO.obtieneRangosDisponibles(asociaRangoVO);*/

			// Consigue los datos del cliente
			logger.info("cargaGenericaDatos: " + asociaRangoVO.getAbonado().toString(), nombreClase);
			logger.info("cargaGenericaDatos: " + asociaRangoVO.toString(), nombreClase);

			//OOSSDatosBasicosClienteBO datosBasicosClienteBO = new OOSSDatosBasicosClienteBO();
			logger.info("------------------------------------------", nombreClase);
			logger.info("-----Consulta Datos Basicos Cliente-------", nombreClase);
			logger.info("------------------------------------------", nombreClase);			
			OOSSDatosBasicosClienteVO datosBasicosClienteVO = new OOSSDatosBasicosClienteVO();
			datosBasicosClienteVO.setCodCliente(new Long(asociaRangoVO.getAbonado().getCodCliente()));
			asociaDesasociaRangoBO.consultaDatosBasicosCliente(datosBasicosClienteVO);

			if (asociaRangoVO.getRangosAsociados() != null) {
				RangoDTO[] rangosAsociados = new RangoDTO[asociaRangoVO.getRangosAsociados().size()];
				int j = 0;

				for (Iterator i = asociaRangoVO.getRangosAsociados().iterator(); i.hasNext();) {
					rangosAsociados[j] = AsociaRangoFactoryDTO.createRangoDTO((RangoVO) i.next());
					j++;
				}

				cargaAsociaRangoDTO.setRangosAsociados(rangosAsociados);
			}

			if (asociaRangoVO.getRangosDisponibles() != null) {
				RangoDTO[] rangosDisponibles = new RangoDTO[asociaRangoVO.getRangosDisponibles().size()];
				int j = 0;

				for (Iterator i = asociaRangoVO.getRangosDisponibles().iterator(); i.hasNext();) {
					rangosDisponibles[j] = AsociaRangoFactoryDTO.createRangoDTO((RangoVO) i.next());
					j++;
				}

				cargaAsociaRangoDTO.setRangosDisponibles(rangosDisponibles);
			}

			cargaAsociaRangoDTO.setNomCliente(datosBasicosClienteVO.getNomCliente());

			asociaRangoDTO.setCargaAsociaRangoDTO(cargaAsociaRangoDTO);
			oossdto = (AsociaRangoDTO) asociaRangoDTO;

			logger.info("cargaGenericaDatos: " + asociaRangoDTO.toString(), nombreClase);
		} catch (Throwable t) {
			logger.error(t, nombreClase);
			if (t instanceof ServicioVentasEnlaceException) {
				ServicioVentasEnlaceException e1 = (ServicioVentasEnlaceException) t;
				codError = e1.getCodigo();
				desError = e1.getDescripcionEvento();
			} else if (t instanceof ServicioVentasEnlaceException) {
				ServicioVentasEnlaceException e1 = (ServicioVentasEnlaceException) t;
				codError = e1.getCodigo();
				desError = e1.getDescripcionEvento();
			}

			logger.error("cargaGenericaDatos: codError: " + codError, nombreClase);
			logger.error("cargaGenericaDatos: desError: " + desError, nombreClase);

			if (cargaAsociaRangoDTO == null)
				cargaAsociaRangoDTO = new CargaAsociaRangoDTO();

			if (asociaRangoDTO == null)
				asociaRangoDTO = new AsociaRangoDTO();

			if (desError != null && codError != null) {
				cargaAsociaRangoDTO.setCodError(codError);
				cargaAsociaRangoDTO.setDesError(desError);
			} else {
				cargaAsociaRangoDTO.setCodError("ERR.0201");
				cargaAsociaRangoDTO.setDesError(global.getValor("ERR.0201"));
			}

			asociaRangoDTO.setCodError(cargaAsociaRangoDTO.getCodError());
			asociaRangoDTO.setDesError(cargaAsociaRangoDTO.getDesError());
			asociaRangoDTO.setCargaAsociaRangoDTO(cargaAsociaRangoDTO);
		}

		logger.info("cargaGenericaDatos: carga generica terminada.", nombreClase);

		return asociaRangoDTO;
	}

	public OOSSDTO ejecutarOS(OOSSDTO oossdto) throws ServicioVentasEnlaceException {
		logger.debug("ejecutarOS: por ejecutar orden de servicio", nombreClase);

		String codError = null, desError = null;
		EjecucionAsociaRangoDTO ejecucionAsociaRangoDTO = null;
		CargaAsociaRangoDTO cargaAsociaRangoDTO = null;
		AsociaRangoDTO asociaRangoDTO = null;

		try {
			// Se valida si la OOSS contiene datos
			if (oossdto == null)
				throw new ServicioVentasEnlaceException("ERR.0001", 1, global.getValor("ERR.0001"));

			Calendar cal = Calendar.getInstance();
			//AsociaRangoBO asociaRangoBO = new AsociaRangoBO();
			OOSSAsociaRangoVO asociaRangoVO = new OOSSAsociaRangoVO();
			asociaRangoDTO = (AsociaRangoDTO) oossdto;
			cargaAsociaRangoDTO = asociaRangoDTO.getCargaAsociaRangoDTO();
			AbonadoVO abonadoVO = new AbonadoVO();

			ejecucionAsociaRangoDTO = asociaRangoDTO.getEjecucionAsociaRangoDTO();

			// Recupera al abonado
			abonadoVO.setNumAbonado(cargaAsociaRangoDTO.getNumAbonado().longValue());
			asociaRangoVO.setAbonado(abonadoVO);
			logger.info("------------------------------------------", nombreClase);
			logger.info("----- Consultar Abonado PostPago 2 -------", nombreClase);
			logger.info("------------------------------------------", nombreClase);			
			asociaDesasociaRangoBO.consultarAbonadoPostPago(asociaRangoVO.getAbonado());
			abonadoVO = asociaRangoVO.getAbonado();
			asociaRangoVO.setNumPiloto(abonadoVO.getNumCelular().longValue());

			logger.info(abonadoVO.toString(), nombreClase);
			logger.info(asociaRangoDTO.toString(), nombreClase);

			// La capa de negocio obtiene un número de transacción, a través de una consulta a una secuencia de BD SCL.
			DatosGeneralesVO datosGeneralesVO = new DatosGeneralesVO();
			//DatosGeneralesBO datosGeneralesBO = new DatosGeneralesBO();
			CentralesVO centralesVO = new CentralesVO();
			//CentralesBO centralesBO = new CentralesBO();

			centralesVO.setNomUsuarOra(cargaAsociaRangoDTO.getNomUsuarioSCL());

			String nuevoEstado = null;

			asociaRangoVO.setNomColumna("ESTADO");
			asociaRangoVO.setNomTabla("GA_RANGOS_FIJOS_TO");
			asociaRangoVO.setCodModulo(global.getValor("GE.AR.codigos.estado.codModulo.SRV"));
			asociaRangoVO.setDesValor(global.getValor("GE.AR.codigos.estado.reservado.desValor"));
			logger.info("------------------------------------------", nombreClase);
			logger.info("------------ Consultar Codigo ------------", nombreClase);
			logger.info("------------------------------------------", nombreClase);				
			asociaDesasociaRangoBO.consultaCodigo(asociaRangoVO);
			nuevoEstado = asociaRangoVO.getCodValor();

			logger.debug("ejecutarOS: nuevoEstado = [" + nuevoEstado + "]", nombreClase);

			if (ejecucionAsociaRangoDTO.getRangosAdicionados() != null && ejecucionAsociaRangoDTO.getRangosAdicionados().length > 0) {
				RangoDTO[] rangosAdicionados = ejecucionAsociaRangoDTO.getRangosAdicionados();
				RangoVO rangoVO = null;

				for (int i = 0; i < rangosAdicionados.length; i++) {
					rangoVO = AsociaRangoFactoryVO.createRangoVO(rangosAdicionados[i]);
					rangoVO.setNomUsuarOra(abonadoVO.getNomusuarora());

					asociaRangoVO.setRangoVO(rangoVO);
					asociaRangoVO.setNumeroPilotoVO(new NumeroPilotoVO(asociaRangoVO.getNumPiloto(), rangoVO.getNumDesde(), rangoVO.getNomUsuarOra()));
					logger.info("------------------------------------------", nombreClase);
					logger.info("-----------Inserta Numeros Pilotos--------", nombreClase);
					logger.info("------------------------------------------", nombreClase);		
					asociaDesasociaRangoBO.insertaNumeroPiloto(asociaRangoVO);

					logger.info("------------------------------------------", nombreClase);
					logger.info("-----------Actualiza Estado Rango --------", nombreClase);
					logger.info("------------------------------------------", nombreClase);					
					rangoVO.setEstado(nuevoEstado);
					asociaDesasociaRangoBO.actualizaEstadoRango(asociaRangoVO);

					centralesVO.setDesRespuesta("PENDIENTE");

					insertaIccMovimiento(datosGeneralesVO, abonadoVO, centralesVO);
				}
			}

			asociaRangoVO.setNomColumna("ESTADO");
			asociaRangoVO.setNomTabla("GA_RANGOS_FIJOS_TO");
			asociaRangoVO.setCodModulo(global.getValor("GE.AR.codigos.estado.codModulo.SRV"));
			asociaRangoVO.setDesValor(global.getValor("GE.AR.codigos.estado.activado.desValor"));
			logger.info("------------------------------------------", nombreClase);
			logger.info("-------------Consultar Codigo 2-----------", nombreClase);
			logger.info("------------------------------------------", nombreClase);							
			asociaDesasociaRangoBO.consultaCodigo(asociaRangoVO);
			nuevoEstado = asociaRangoVO.getCodValor();

			logger.debug("ejecutarOS: nuevoEstado = [" + nuevoEstado + "]", nombreClase);

			if (ejecucionAsociaRangoDTO.getRangosEliminados() != null && ejecucionAsociaRangoDTO.getRangosEliminados().length > 0) {
				RangoDTO[] rangosEliminados = ejecucionAsociaRangoDTO.getRangosEliminados();
				RangoVO rangoVO = null;
				NumeroPilotoHVO numeroPilotoHVO = null;

				for (int i = 0; i < rangosEliminados.length; i++) {
					rangoVO = AsociaRangoFactoryVO.createRangoVO(rangosEliminados[i]);
					rangoVO.setNomUsuarOra(abonadoVO.getNomusuarora());

					asociaRangoVO.setRangoVO(rangoVO);
					asociaRangoVO.setNumeroPilotoVO(new NumeroPilotoVO(asociaRangoVO.getNumPiloto(), rangoVO.getNumDesde(), rangoVO.getNomUsuarOra()));
					logger.info("------------------------------------------", nombreClase);
					logger.info("------------Elimina Numero Piloto---------", nombreClase);
					logger.info("------------------------------------------", nombreClase);					
					asociaDesasociaRangoBO.eliminaNumeroPiloto(asociaRangoVO); //Elimina rango

					logger.info("------------------------------------------", nombreClase);
					logger.info("-----------Actualiza Estado Rango---------", nombreClase);
					logger.info("------------------------------------------", nombreClase);					
					rangoVO.setEstado(nuevoEstado);
					asociaDesasociaRangoBO.actualizaEstadoRango(asociaRangoVO); //Actualiza Rango Eliminado

					centralesVO.setDesRespuesta("PENDIENTE");

					numeroPilotoHVO = new NumeroPilotoHVO(asociaRangoVO.getNumeroPilotoVO(), new Timestamp(cal.getTimeInMillis()));

					logger.info("ejecutarOS: " + numeroPilotoHVO.toString(), nombreClase);

					asociaRangoVO.setNumeroPilotoHVO(numeroPilotoHVO);
					logger.info("------------------------------------------", nombreClase);
					logger.info("------Inserta Numero Piloto Historico-----", nombreClase);
					logger.info("------------------------------------------", nombreClase);
					asociaDesasociaRangoBO.insertaNumeroPilotoHistorico(asociaRangoVO);

					insertaIccMovimiento(datosGeneralesVO, abonadoVO, centralesVO);
				}
			}

			datosGeneralesVO.setNombreSecuencia(global.getValor("GE.CI_SEQ_NUMOS.SRV"));
			logger.info("------------------------------------------", nombreClase);
			logger.info("--------Consultar Numero Secuencia--------", nombreClase);
			logger.info("------------------------------------------", nombreClase);
			try {
				asociaDesasociaRangoBO.consultarNumeroSecuencia(datosGeneralesVO);
			} catch (ServicioVentasEnlaceException e) {
				throw new ServicioVentasEnlaceException(e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
			}

			OOSSVO oossvo = new OOSSVO();
			oossvo.setCodOS(global.getValor("GE.AR.codOOSS.SVR"));
			logger.info("------------------------------------------", nombreClase);
			logger.info("------------Consultar Datos OOSS----------", nombreClase);
			logger.info("------------------------------------------", nombreClase);
			try {
				asociaDesasociaRangoBO.consultarDatosOOSS(oossvo);
			} catch (ServicioVentasEnlaceException e) {
				throw new ServicioVentasEnlaceException(e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
			}

			oossvo.setNumOS(datosGeneralesVO.getNroSecuencia());
			oossvo.setCodProducto(Integer.valueOf(global.getValor("GE.producto.celular.GE")));
			oossvo.setCodInter(new Long(abonadoVO.getNumAbonado()));
			oossvo.setNomUsuarioSCL(cargaAsociaRangoDTO.getNomUsuarioSCL());

			if (ejecucionAsociaRangoDTO.getComentario() == null || ejecucionAsociaRangoDTO.getComentario().equals(""))
				oossvo.setComentario("-");
			else
				oossvo.setComentario(ejecucionAsociaRangoDTO.getComentario());

			oossvo.setFechaOS(new Timestamp(cal.getTimeInMillis()));

			oossvo.setProducto(new Integer(Integer.parseInt(global.getValor("GE.producto.celular.GE"))));
			logger.info("------------------------------------------", nombreClase);
			logger.info("----------------Insertar OOSS-------------", nombreClase);
			logger.info("------------------------------------------", nombreClase);
			try {
				asociaDesasociaRangoBO.insertarOOSS(oossvo);
			} catch (ServicioVentasEnlaceException e) {
				throw new ServicioVentasEnlaceException(e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
			}

			asociaRangoDTO.setNroOOSS(oossvo.getNumOS().longValue());

			ejecucionAsociaRangoDTO.setRangosAdicionados(null);
			ejecucionAsociaRangoDTO.setRangosEliminados(null);
			ejecucionAsociaRangoDTO.setComentario(null);

			logger.info("ejecutarOS: " + ejecucionAsociaRangoDTO.toString(), nombreClase);
			logger.info("ejecutarOS: ejecucion terminada.", nombreClase);
		} catch (Throwable e) {
			if (e instanceof ServicioVentasEnlaceException) {
				ServicioVentasEnlaceException e1 = (ServicioVentasEnlaceException) e;
				codError = e1.getCodigo();
				desError = e1.getDescripcionEvento();
			} else if (e instanceof ServicioVentasEnlaceException) {
				ServicioVentasEnlaceException e1 = (ServicioVentasEnlaceException) e;
				codError = e1.getCodigo();
				desError = e1.getDescripcionEvento();
			}

			logger.error("ejecutarOS: codError: " + codError, nombreClase);
			logger.error("ejecutarOS: desError: " + desError, nombreClase);

			if (ejecucionAsociaRangoDTO == null)
				ejecucionAsociaRangoDTO = new EjecucionAsociaRangoDTO();

			if (asociaRangoDTO == null)
				asociaRangoDTO = new AsociaRangoDTO();

			if (desError != null && codError != null) {
				ejecucionAsociaRangoDTO.setCodError(codError);
				ejecucionAsociaRangoDTO.setDesError(desError);
			} else {
				ejecucionAsociaRangoDTO.setCodError("ERR.0201");
				ejecucionAsociaRangoDTO.setDesError(global.getValor("ERR.0201"));
			}

			asociaRangoDTO.setCodError(ejecucionAsociaRangoDTO.getCodError());
			asociaRangoDTO.setDesError(ejecucionAsociaRangoDTO.getDesError());
			asociaRangoDTO.setEjecucionAsociaRangoDTO(ejecucionAsociaRangoDTO);
		}

		return asociaRangoDTO;
	}

	private void insertaIccMovimiento(DatosGeneralesVO datosGeneralesVO, AbonadoVO abonadoVO, CentralesVO centralesVO) throws ServicioVentasEnlaceException {
		datosGeneralesVO.setNombreSecuencia(global.getValor("GE.secuencia.iccmovimiento.GE"));
		logger.info("------------------------------------------", nombreClase);
		logger.info("-------Consultar Numero Secuencia 2-------", nombreClase);
		logger.info("------------------------------------------", nombreClase);
		try {
			asociaDesasociaRangoBO.consultarNumeroSecuencia(datosGeneralesVO);
		} catch (ServicioVentasEnlaceException e) {
			throw new ServicioVentasEnlaceException(e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}

		// NUM_MOVIMIENTO,
		centralesVO.setNumMovimiento(datosGeneralesVO.getNroSecuencia());
		// NUM_ABONADO
		centralesVO.setNumAbonado(abonadoVO.getNumAbonado());
		// COD_ESTADO
		centralesVO.setCodEstado(Integer.valueOf(global.getValor("GE.AR.iccMovimiento.codEstado.SVR")).intValue());
		// COD_ACTABO
		centralesVO.setCodActabo(global.getValor("GE.AR.iccMovimiento.codActabo.SVR"));
		// COD_MODULO
		centralesVO.setCodModulo(global.getValor("GE.AR.iccMovimiento.codModulo.SVR"));
		// NUM_INTENTOS
		centralesVO.setNumIntentos(new Long(global.getValor("GE.AR.iccMovimiento.numIntentos.SVR")).longValue());

		centralesVO.setCodActuacion(Long.valueOf(global.getValor("GE.AR.iccMovimiento.codActuacion.SVR")).longValue());
		centralesVO.setFecIngreso(new Timestamp(new Date().getTime()));
		centralesVO.setTipTerminal(abonadoVO.getTipTerminal());
		centralesVO.setCodCentral(new Long(abonadoVO.getCodCentral().longValue()));
		centralesVO.setIndBloqueo(Integer.valueOf(global.getValor("GE.AR.iccMovimiento.indiceBloqueo.SVR")).intValue());
		centralesVO.setNumCelular(abonadoVO.getNumCelular());
		centralesVO.setNumSerie(abonadoVO.getNumSerie());
		centralesVO.setNumSerieNue("");
		centralesVO.setNumMin(abonadoVO.getNumMin());
		centralesVO.setTipTecnologia(abonadoVO.getCodTecnologia());
		logger.info("------------------------------------------", nombreClase);
		logger.info("-------Inserta Movimiento Centrales-------", nombreClase);
		logger.info("------------------------------------------", nombreClase);
		try {
			asociaDesasociaRangoBO.insertaMovimientoCentrales(centralesVO);
		} catch (ServicioVentasEnlaceException e) {
			throw new ServicioVentasEnlaceException(e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
	}
}
