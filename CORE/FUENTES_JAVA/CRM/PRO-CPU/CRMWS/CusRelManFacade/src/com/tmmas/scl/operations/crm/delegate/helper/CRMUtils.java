package com.tmmas.scl.operations.crm.delegate.helper;

import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Hashtable;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.Formatting;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.marketSalesDomain.contactLeadProspectABE.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ParametroSerializableDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.CargoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.CargoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.CatalogoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoListDTO;
import com.tmmas.scl.operations.crm.delegate.ManConFacadeDelegate;
import com.tmmas.scl.operations.crm.delegate.ManCusInvDelegate;
import com.tmmas.scl.operations.crm.delegate.ManProOffInvFacadeDelegate;
import com.tmmas.scl.operations.crm.delegate.SupOrdHanDelegate;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.exception.IssCusOrdException;
import com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.ContenedorPlanesAdicionalesDTO;
import com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.DatosVentaDTO;
import com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.OfertaComercialDTO;
import com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.PlanesAdicionalesDTO;
import com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.ProductoModuloDTO;
import com.tmmas.scl.operations.crm.f.sel.negsal.exception.NegSalException;
import com.tmmas.scl.operations.crm.f.sel.negsal.helper.NegSalUtils;
import com.tmmas.scl.operations.crm.fab.cim.mancon.common.exception.ManConException;
import com.tmmas.scl.operations.crm.o.csr.manprooffinv.common.exception.ManProOffInvException;
import com.tmmas.scl.operations.crm.o.csr.supordhan.common.exception.SupOrdHanException;
import com.tmmas.scl.operations.crm.osr.mancusinv.common.exception.ManCusInvException;
import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.helper.*;


public class CRMUtils {
	
	private final Logger logger = Logger.getLogger(FacadeMaker.class);

	private static Global global = Global.getInstance();

	private static CRMUtils instance;

	private ManProOffInvFacadeDelegate manProOffInvFacadeDelegate = new ManProOffInvFacadeDelegate();

	private ManConFacadeDelegate manConFacadeDelegate = new ManConFacadeDelegate();

	private SupOrdHanDelegate supOrdHanDelegate = new SupOrdHanDelegate();

	private ManCusInvDelegate manCusInvDelegate = new ManCusInvDelegate();

	public static CRMUtils getInstance() {
		String log = global.getValor("delegate.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);
		if (instance == null) {
			instance = new CRMUtils();
		}
		return instance;
	}

	private CRMUtils() {

	}

	public ContenedorPlanesAdicionalesDTO mantencionPlanesAdicionales(
			PlanesAdicionalesDTO[] planesAdicionales)
			throws IssCusOrdException, RemoteException, SupOrdHanException {
		logger.debug("mantencionPlanesAdicionales:start");
		RetornoDTO retorno = null;
		ArrayList productosContratar = new ArrayList();
		ArrayList productosMantener = new ArrayList();
		ArrayList productosDescontratar = new ArrayList();
		NegSalUtils negSalUtils = NegSalUtils.getInstance();

		OfertaComercialDTO ofComercialAContratar = null;
		ProductoContratadoListDTO producADescontratar = null;
		ContenedorPlanesAdicionalesDTO contPlanAdicionalesMantener = null;
		ContenedorPlanesAdicionalesDTO contPlanAdicionalesFinal = new ContenedorPlanesAdicionalesDTO();
		;

		try {
			logger.debug("planesAdicionales.size()" + planesAdicionales.length);
			if (planesAdicionales != null) {
				for (int i = 0; i < planesAdicionales.length; i++) {
					if ("contratar".equalsIgnoreCase(planesAdicionales[i]
							.getAccion())) {
						logger.debug("contratar:antes");
						productosContratar.add(planesAdicionales[i]);
						logger.debug("contratar:despues");
					} else if ("mantener".equalsIgnoreCase(planesAdicionales[i]
							.getAccion())) {
						logger.debug("mantener:antes");
						productosMantener.add(planesAdicionales[i]);
						logger.debug("mantener:despues");
					} else if ("descontratar"
							.equalsIgnoreCase(planesAdicionales[i].getAccion())) {
						logger.debug("descontratar:antes");
						productosDescontratar.add(planesAdicionales[i]);
						logger.debug("descontratar:despues");
					}
				}
			}

			logger.debug("productosContratar.size()"
					+ productosContratar.size());
			if (productosContratar.size() > 0) {
				logger.debug("productosContratar:antes");
				PlanesAdicionalesDTO[] planesContratar = (PlanesAdicionalesDTO[]) ArrayUtl
						.copiaArregloTipoEspecifico(productosContratar
								.toArray(), PlanesAdicionalesDTO.class);
				ofComercialAContratar = this
						.contratarPlanAdicional(planesContratar);
				logger.debug("productosContratar:despues");
			}

			logger.debug("productosMantener.size()" + productosMantener.size());
			if (productosMantener.size() > 0) {
				logger.debug("productosMantener:antes");
				PlanesAdicionalesDTO[] planesMantener = (PlanesAdicionalesDTO[]) ArrayUtl
						.copiaArregloTipoEspecifico(
								productosMantener.toArray(),
								PlanesAdicionalesDTO.class);
				contPlanAdicionalesMantener = this
						.mantenerPlanAdicional(planesMantener);
				logger.debug("productosMantener:despues");
			}

			logger.debug("productosDescontratar.size()"
					+ productosDescontratar.size());
			if (productosDescontratar.size() > 0) {
				logger.debug("productosDescontratar:antes");
				PlanesAdicionalesDTO[] planesDescontratar = (PlanesAdicionalesDTO[]) ArrayUtl
						.copiaArregloTipoEspecifico(productosDescontratar
								.toArray(), PlanesAdicionalesDTO.class);
				producADescontratar = this
						.descontratarPlanAdicional(planesDescontratar);
				logger.debug("productosDescontratar:despues");
			}

			if (contPlanAdicionalesMantener == null)
				contPlanAdicionalesMantener = new ContenedorPlanesAdicionalesDTO();

			logger.debug("negSalUtils.mergeOfertasComerciales:antes");
			OfertaComercialDTO ofertaComFinal = negSalUtils
					.mergeOfertasComerciales(ofComercialAContratar,
							contPlanAdicionalesMantener
									.getOfComercialContratar());
			logger.debug("negSalUtils.mergeOfertasComerciales:despues");

			if (ofComercialAContratar == null
					&& contPlanAdicionalesMantener.getOfComercialContratar() == null) {
				// Validacion la usa el IssCusOrd, para realizar una activacion
				logger.debug("Oferta comercial se setea a nula");
				ofertaComFinal = null;
			} else {
				logger
						.debug("Oferta comercial a unir una de ellas o ambas es no nula");
			}

			logger.debug("negSalUtils.mergeProductoContratadoList:antes");
			ProductoContratadoListDTO productosFinal = negSalUtils
					.mergeProductoContratadoList(producADescontratar,
							contPlanAdicionalesMantener
									.getListaProductosDescontratar());
			logger.debug("negSalUtils.mergeProductoContratadoList:despues");

			logger
					.debug("contPlanAdicionalesFinal.setOfComercialContratar:antes");
			contPlanAdicionalesFinal.setOfComercialContratar(ofertaComFinal);
			logger
					.debug("contPlanAdicionalesFinal.setOfComercialContratar:despues");

			logger
					.debug("contPlanAdicionalesFinal.setListaProductosDescontratar:antes");
			contPlanAdicionalesFinal
					.setListaProductosDescontratar(productosFinal);
			logger
					.debug("contPlanAdicionalesFinal.setListaProductosDescontratar:despues");

		} catch (SupOrdHanException spe) {
			logger.error("SupOrdHanException", spe);
			retorno = new RetornoDTO();
			retorno
					.setDescripcion("Error Desconocido al tratar de generar el Contenedor de Planes Adicionales");
			throw spe;
		} catch (Exception e) {
			logger.error("Exception", e);
			retorno = new RetornoDTO();
			retorno
					.setDescripcion("Error Desconocido al tratar de generar el Contenedor de Planes Adicionales");
			throw new SupOrdHanException();
		}
		logger.debug("mantencionPlanesAdicionales:end");
		return contPlanAdicionalesFinal;
	}

	public OfertaComercialDTO contratarPlanAdicional(
			PlanesAdicionalesDTO[] planesAdicionales) throws ManConException,
			ManProOffInvException, NegSalException, SupOrdHanException {

		logger.debug("contratarPlanAdicional()" + ":start");
		RetornoDTO retorno = null;
		ProductoOfertadoDTO[] productosOfertadosIN = new ProductoOfertadoDTO[planesAdicionales.length];
		NegSalUtils negSalUtils = NegSalUtils.getInstance();
		VentaDTO venta = new VentaDTO();
		ClienteDTO cliente = new ClienteDTO();
		AbonadoDTO abonado = new AbonadoDTO();

		String numAbonadoDest = planesAdicionales[0].getAbonadoDestino();
		String numClienteDest = planesAdicionales[0].getClienteDestino();
		String numClienteOrig = planesAdicionales[0].getClienteOrigen();
		String numProceso = planesAdicionales[0].getNumProceso();
		String origenProceso = planesAdicionales[0].getOrigenProceso();
		
		logger.debug("numAbonadoDest[" + numAbonadoDest + "]");
		logger.debug("numClienteOrig[" + numClienteOrig + "]");	
		logger.debug("numClienteDest[" + numClienteDest + "]");
		logger.debug("numProceso[" + numProceso + "]");	
		logger.debug("origenProceso[" + origenProceso + "]");
	

		/**
		 * Creando Proceso
		 */
		ParametroSerializableDTO process = new ParametroSerializableDTO();
		process.setNumProceso(numProceso);
		process.setOrigenProceso(origenProceso);

		logger.debug("supOrdHanDelegate.crearProceso:antes");
		supOrdHanDelegate.crearProceso(process);
		logger.debug("supOrdHanDelegate.crearProceso:despues");
		/**
		 * LLenando Informacion general
		 */
		venta.setIdVenta(numProceso);
		venta.setOrigenProceso(origenProceso);
		cliente.setCodCliente(Long.parseLong(numClienteDest));
		
		logger.debug("manConFacadeDelegate.obtenerDatosCliente:antes");
		cliente = manConFacadeDelegate.obtenerDatosCliente(cliente);
		logger.debug("manConFacadeDelegate.obtenerDatosCliente:despues");
		
		String formato = global.getValor("formatoFecWS");
		logger.debug("Formato fecha[" + formato + "]");
		
		String fechaDesde = planesAdicionales[0].getFechaDesde();
		String fechaHasta = planesAdicionales[0].getFechaHasta();
		
		logger.debug("fechaDesde[" + fechaDesde + "]");
		logger.debug("fechaHasta[" + fechaHasta + "]");		
		
		Date fechaDesdeDate = null;
		Date fechaHastaDate = null;
		
		Calendar cal = Calendar.getInstance();
		cal.set(3000, 11, 31);
		
		
		
		if ( fechaDesde != null && !fechaDesde.equalsIgnoreCase("")) {
			logger.debug("Fecha desde tiene valor");
			fechaDesdeDate = Formatting.getFecha(fechaDesde, formato);
			
		}
		else {
			logger.debug("Fecha desde nula o vacia");
			throw new SupOrdHanException("Fecha desde no puede ser nula o vacia");			
		}
		

		if ( fechaHasta != null && !fechaHasta.equalsIgnoreCase("")) {
			logger.debug("Fecha hasta tiene valor");
			fechaHastaDate = Formatting.getFecha(fechaHasta, formato);			
		}
		else {
			logger.debug("Fecha hasta nula o vacia");
			//Se setea por defecto a 31/12/3000
			fechaHastaDate = new Date(cal.getTimeInMillis());				
		}
		
		
		//Se genera un catalogo para buscar los cargos por canal de los
		//productos seleccionados
		logger.debug("Generando catalogo de oferta...");
		CatalogoDTO catalogo = new CatalogoDTO();
		catalogo.setCodCanal(origenProceso);
		catalogo.setFecInicioVigencia(fechaDesdeDate);
		catalogo.setFecTerminoVigencia(fechaHastaDate);
		
		String indicadorAbonado = global.getValor("abonado");
		logger.debug("indicadorAbonado[" + indicadorAbonado + "]");
		
		String indicadorCliente = global.getValor("cliente");
		logger.debug("indicadorCliente[" + indicadorCliente + "]");		
		
		catalogo
				.setIndNivelAplica((numAbonadoDest != null
						&& !"".equals(numAbonadoDest) && !"0"
						.equals(numAbonadoDest)) ? indicadorAbonado : indicadorCliente);
		
		//Se genera el  dto de abonadso para realizar la consulta

		abonado.setNumAbonado(Long.parseLong(numAbonadoDest));
		abonado.setCodCliente(Long.parseLong(numClienteDest));
		abonado.setCatalogo(catalogo);


		/**
		 * Obteniendo el detalle de los productos y clasificarlos como paquetes
		 * o productos
		 */
		for (int i = 0; i < planesAdicionales.length; i++) {
			productosOfertadosIN[i] = new ProductoOfertadoDTO();
			productosOfertadosIN[i].setIdProductoOfertado(planesAdicionales[i]
					.getNumProducto());
			productosOfertadosIN[i]
					.setIndCondicionContratacion(planesAdicionales[i]
							.getCondicionContratacion());
			productosOfertadosIN[i].setFecInicioVigencia(fechaDesdeDate);
			productosOfertadosIN[i].setFecTerminoVigencia(fechaHastaDate);
		}

		ProductoOfertadoListDTO productoOferList = new ProductoOfertadoListDTO();
		productoOferList.setProductoList(productosOfertadosIN);
		abonado.setProdOfertList(productoOferList);
		
		logger.debug("obtenerProductosOfertablesporCanal:antes");
		productoOferList = manProOffInvFacadeDelegate
				.obtenerProductosOfertablesporCanal(abonado);
		logger.debug("obtenerProductosOfertablesporCanal:despues");
		
		String condicionDefecto = global.getValor("condicion.defecto");
		logger.debug("condicionDefecto[" + condicionDefecto + "]");		
		
		boolean bcambioCliente = numClienteDest.equalsIgnoreCase(numClienteOrig);
		logger.debug("bcambioCliente[" + bcambioCliente + "]");	
		
		//Aplicar cargos solo a los productos adicionales opcionales y que tengan asociado un cambio de cliente
		//En ese caso aplicar el cargo recurrente y el cargo opcional debe estar nulo. En los demas casos setear a null
		//los cargos recurrentes y opcionales
		for (int i = 0; i < productoOferList.getProductoList().length; i++) {
			String condicionContratacion = productoOferList.getProductoList()[i].getIndCondicionContratacion();
			logger.debug("condicionContratacion[" + condicionContratacion + "]");	
			
			boolean bcondicionDefecto = condicionDefecto.equalsIgnoreCase(condicionContratacion);
			logger.debug("bcondicionDefecto[" + bcondicionDefecto + "]");
			
			
			//Verifico si es una contratacion opcional y si hay un cambio de cliente
			if (!bcondicionDefecto && !bcambioCliente ) {

				String sacarCargosOpcionalesContratacion = global.getValor("sacar.cargos.opcionales.contratacion");
				logger.debug("sacarCargosOpcionalesContratacion[" + sacarCargosOpcionalesContratacion + "]");
				
				if (!sacarCargosOpcionalesContratacion.equalsIgnoreCase("SI")) {
					break;
				}
				logger.debug("Es una contratacion opcional y es cambio de cliente");
				CargoListDTO cargos = productoOferList.getProductoList()[i].getCargoList();
				logger.debug("procesoCargos():antes");
				CargoListDTO resultado = sacarCargosOpcionales(cargos);
				logger.debug("procesoCargos():despues");
				productoOferList.getProductoList()[i].setCargoList(resultado);
			}
			else {
				logger.debug("No es una contratacion opcional, ni es cambio de cliente");
				//No se aplican ni cargos recurrenters ni opcionales
				productoOferList.getProductoList()[i].setCargoList(null);
				
			}
		}
		abonado.setProdOfertList(productoOferList);
		

		abonado = negSalUtils.splitProductosPaquetes(abonado);

		if (abonado.getPaqueteList() != null) {
			for (int i = 0; i < abonado.getPaqueteList().getPaqueteList().length; i++) {
				logger
						.debug("manProOffInvFacadeDelegate.obtenerProductosOfertablesPorPaquete:antes");
				ProductoOfertadoListDTO listaProdPaquetes = manProOffInvFacadeDelegate
						.obtenerProductosOfertablesPorPaquete(abonado
								.getPaqueteList().getPaqueteList()[i]);
				logger
						.debug("manProOffInvFacadeDelegate.obtenerProductosOfertablesPorPaquete:despues");
				
				for (int j = 0; j < listaProdPaquetes.getProductoList().length; j++) {
					listaProdPaquetes.getProductoList()[j]
							.setIndCondicionContratacion(abonado
									.getPaqueteList().getPaqueteList()[i]
									.getIndCondicionContratacion());
					listaProdPaquetes.getProductoList()[j]
							.setFecInicioVigencia(abonado.getPaqueteList()
									.getPaqueteList()[i].getFecInicioVigencia());
					listaProdPaquetes.getProductoList()[j]
							.setFecTerminoVigencia(abonado.getPaqueteList()
									.getPaqueteList()[i]
									.getFecTerminoVigencia());
					if ("D"
							.equalsIgnoreCase(listaProdPaquetes
									.getProductoList()[j]
									.getIndCondicionContratacion())) {
						listaProdPaquetes.getProductoList()[j]
								.setCargoList(null);
					}
				}
				abonado.getPaqueteList().getPaqueteList()[i]
						.setProductoList(listaProdPaquetes);
			}
		}

		AbonadoDTO[] abonadosCliente = { abonado };
		AbonadoListDTO abonadoListCliente = new AbonadoListDTO();
		abonadoListCliente.setAbonados(abonadosCliente);

		cliente.setAbonados(abonadoListCliente);
		venta.setCliente(cliente);

		logger.debug("negSalUtils.generarOfertaComercial:antes");
		OfertaComercialDTO ofertaComercial = negSalUtils
				.generarOfertaComercial(venta);
		logger.debug("negSalUtils.generarOfertaComercial:despues");
		ofertaComercial.setNumEvento(supOrdHanDelegate.getProcess()
				.getIdProceso());
		// retorno=messageSender.sendToQueueActivacionVenta(ofertaComercial);
		// supOrdHanDelegate.inscribeProceso("ENCOLADO",
		// (byte[])SerializationUtils.serialize(ofertaComercial));
		logger.debug("contratarPlanAdicional:end");
		return ofertaComercial;
	}

	/**
	 * Saca los cargos opcionales del listado de cargos de un producto
	 * @param cargos
	 * @return
	 */
	private CargoListDTO sacarCargosOpcionales(CargoListDTO cargos) {
		ArrayList resultado = new ArrayList();
		logger.debug("sacarCargosOpcionales():start()");

		String cargoRecurrente = global.getValor("condicion.defecto");
		logger.debug("cargoRecurrente[" + cargoRecurrente + "]");
		
		//Buscar y aplicar solo cargos recurrentes
		//Los cargos opcionales sacarlos 
		CargoDTO[] lista = cargos.getCargoList();
		int n = cargos.getCargoList() != null ? cargos.getCargoList().length:-1;
		logger.debug("n[" + n + "]");
		
		for (int i = 0; i < n ; i++ ) {
			CargoDTO dto = cargos.getCargoList()[i];
			String tipoCargo = dto.getTipoCargo();
			logger.debug("tipoCargo[" + tipoCargo + "]");
			
			if (tipoCargo.equalsIgnoreCase(cargoRecurrente)) {
				logger.debug("cargo recurrente");
				resultado.add(dto);
			}
			else {
				logger.debug("cargo no recurrente");
			}
		}
		
		lista = (CargoDTO[])ArrayUtl.copiaArregloTipoEspecifico(resultado.toArray(), CargoDTO.class);
		cargos.setCargoList(lista);
		logger.debug("sacarCargosOpcionales():end");
		return cargos;
	}

	// -------------
	/**
	 * @throws ManCusInvException
	 * @throws SupOrdHanException
	 * @throws ManProOffInvException
	 * @throws ManConException
	 * @throws NegSalException
	 */
	public ContenedorPlanesAdicionalesDTO mantenerPlanAdicional(
			PlanesAdicionalesDTO[] planesAdicionales)
			throws ManCusInvException, SupOrdHanException,
			ManProOffInvException, ManConException, NegSalException {
		RetornoDTO retorno = null;
		NegSalUtils negSalUtils = NegSalUtils.getInstance();

		VentaDTO venta = new VentaDTO();
		ClienteDTO cliente = new ClienteDTO();
		AbonadoDTO abonado = new AbonadoDTO();
		ArrayList listaProductos = new ArrayList();
		ArrayList productoADesContratar = new ArrayList();
		ArrayList allProdContr = new ArrayList();

		ProductoModuloDTO productModulo = new ProductoModuloDTO();
		String numAbonadoDest = planesAdicionales[0].getAbonadoDestino();
		String numClienteDest = planesAdicionales[0].getClienteDestino();
		String numProceso = planesAdicionales[0].getNumProceso();
		String origenProceso = planesAdicionales[0].getOrigenProceso();
		productModulo.setFechaInicioVigencia(planesAdicionales[0]
				.getFechaDesde());
		productModulo.setFechaTerminoVigencia(planesAdicionales[0]
				.getFechaHasta());
		productModulo.setIdAbonadoBeneficiario(planesAdicionales[0]
				.getAbonadoDestino());
		productModulo.setNumAbonadoContratante(planesAdicionales[0]
				.getAbonadoDestino());
		productModulo.setIdClienteContratante(planesAdicionales[0]
				.getClienteDestino());
		productModulo.setIdClienteBeneficiario(planesAdicionales[0]
				.getClienteDestino());

		/**
		 * Considerando formato DD-MM-YYYY
		 */
		Calendar cal = Calendar.getInstance();

		/**
		 * Creando Proceso
		 */
		ParametroSerializableDTO process = new ParametroSerializableDTO();
		process.setNumProceso(numProceso);
		process.setOrigenProceso(origenProceso);
		supOrdHanDelegate.crearProceso(process);

		for (int i = 0; i < planesAdicionales.length; i++) {
			ProductoContratadoDTO dto = new ProductoContratadoDTO();
			dto.setIdProdContratado(new Long(planesAdicionales[i]
					.getNumProducto()));
			dto.setOrigenProceso(planesAdicionales[i].getOrigenProceso());
			dto.setNumProceso(planesAdicionales[i].getNumProceso());
			dto.setIndCondicionContratacion(planesAdicionales[i]
					.getCondicionContratacion());
			dto.setFechaProceso(new Date());
			dto.setFechaProcesoDescontrata(new Date());
			listaProductos.add(dto);
		}
		ProductoContratadoDTO[] prodContratados = (ProductoContratadoDTO[]) ArrayUtl
				.copiaArregloTipoEspecifico(listaProductos.toArray(),
						ProductoContratadoDTO.class);
		ProductoContratadoListDTO paramProductosContraList = new ProductoContratadoListDTO();
		paramProductosContraList.setProductosContratadosDTO(prodContratados);
		paramProductosContraList = manCusInvDelegate
				.obtenerDetalleProductoContratado(paramProductosContraList);

		/**
		 * Obteniendo productos de paquete
		 */
		for (int i = 0; i < paramProductosContraList
				.getProductosContratadosDTO().length; i++) {
			ProductoContratadoDTO prodCont = paramProductosContraList
					.getProductosContratadosDTO()[i];

			allProdContr.add(prodCont);
			if ("1".equalsIgnoreCase(prodCont.getIndPaquete())) {
				ProductoContratadoListDTO listaProdContPaq = manCusInvDelegate
						.obtenerProductoContratadoPorPaquete(prodCont);

				listaProdContPaq = manCusInvDelegate
						.obtenerDetalleProductoContratado(listaProdContPaq);
				for (int j = 0; j < listaProdContPaq
						.getProductosContratadosDTO().length; j++) {
					listaProdContPaq.getProductosContratadosDTO()[j]
							.setIndCondicionContratacion(prodCont
									.getIndCondicionContratacion());
					productoADesContratar.add(listaProdContPaq
							.getProductosContratadosDTO()[j]);
					allProdContr.add(listaProdContPaq
							.getProductosContratadosDTO()[j]);
				}
			} else {
				productoADesContratar.add(prodCont);
			}
		}
		prodContratados = (ProductoContratadoDTO[]) ArrayUtl
				.copiaArregloTipoEspecifico(productoADesContratar.toArray(),
						ProductoContratadoDTO.class);
		paramProductosContraList = new ProductoContratadoListDTO();
		paramProductosContraList.setProductosContratadosDTO(prodContratados);

		DatosVentaDTO datosVenta = new DatosVentaDTO();
		datosVenta.setNum_venta(planesAdicionales[0].getNumProceso());
		datosVenta.setCod_proceso(planesAdicionales[0].getOrigenProceso());

		/**
		 * Termino etapa de descontratacion y comienzo de etapa de activacion
		 */

		/**
		 * Datos generales de la activacion
		 */
		venta.setIdVenta(numProceso);
		
		venta.setOrigenProceso(origenProceso);
		cliente.setCodCliente(Long.parseLong(numClienteDest));
		cliente = manConFacadeDelegate.obtenerDatosCliente(cliente);

		CatalogoDTO catalogo = new CatalogoDTO();
		// Calendar cal= Calendar.getInstance();
		cal.set(3000, 11, 31);
		catalogo.setCodCanal(origenProceso);
		catalogo.setFecInicioVigencia(new Date());
		catalogo.setFecTerminoVigencia(new Date(cal.getTimeInMillis()));
		catalogo
				.setIndNivelAplica((numAbonadoDest != null
						&& !"".equals(numAbonadoDest) && !"0"
						.equals(numAbonadoDest)) ? "A" : "C");

		abonado.setNumAbonado(Long.parseLong(numAbonadoDest));
		abonado.setCodCliente(Long.parseLong(numClienteDest));
		abonado.setCatalogo(catalogo);
		/**
		 * Extrayendo datos de producto ofertado, para activacion
		 */
		ProductoContratadoDTO[] allProdContratadorArr = (ProductoContratadoDTO[]) ArrayUtl
				.copiaArregloTipoEspecifico(allProdContr.toArray(),
						ProductoContratadoDTO.class);
		ArrayList listaProductosOfertados = new ArrayList();
		for (int i = 0; i < allProdContratadorArr.length; i++) {
			ProductoContratadoDTO prodContr = allProdContratadorArr[i];
			ProductoOfertadoDTO prodOferAux = allProdContratadorArr[i]
					.getProdOfertado();
			if (prodContr.getProdOfertado() != null) {
				prodOferAux.setListaNumeros(prodContr.getListaNumero());
				prodOferAux.setIndCondicionContratacion(prodContr
						.getIndCondicionContratacion());
				listaProductosOfertados.add(prodOferAux);
			}
		}
		ProductoOfertadoDTO[] dtoArr = (ProductoOfertadoDTO[]) ArrayUtl
				.copiaArregloTipoEspecifico(listaProductosOfertados.toArray(),
						ProductoOfertadoDTO.class);
		ProductoOfertadoListDTO prodOfertList = new ProductoOfertadoListDTO();
		prodOfertList.setProductoList(dtoArr);
		prodOfertList = manProOffInvFacadeDelegate
				.obtenerDetalleProductos(prodOfertList);

		for (int i = 0; i < prodOfertList.getProductoList().length; i++)
			prodOfertList.getProductoList()[i].setCargoList(null);

		abonado.setProdOfertList(prodOfertList);
		abonado = negSalUtils.splitProductosPaquetes(abonado);

		if (abonado.getPaqueteList() != null) {
			for (int i = 0; i < abonado.getPaqueteList().getPaqueteList().length; i++) {
				ProductoOfertadoListDTO listaProdPaquetes = manProOffInvFacadeDelegate
						.obtenerProductosOfertablesPorPaquete(abonado
								.getPaqueteList().getPaqueteList()[i]);
				for (int j = 0; j < listaProdPaquetes.getProductoList().length; j++) {
					listaProdPaquetes.getProductoList()[j]
							.setIndCondicionContratacion(abonado
									.getPaqueteList().getPaqueteList()[i]
									.getIndCondicionContratacion());
					listaProdPaquetes.getProductoList()[j]
							.setFecInicioVigencia(abonado.getPaqueteList()
									.getPaqueteList()[i].getFecInicioVigencia());
					listaProdPaquetes.getProductoList()[j]
							.setFecTerminoVigencia(abonado.getPaqueteList()
									.getPaqueteList()[i]
									.getFecTerminoVigencia());
					listaProdPaquetes.getProductoList()[j].setCargoList(null);
				}
				abonado.getPaqueteList().getPaqueteList()[i]
						.setProductoList(listaProdPaquetes);
			}
		}

		AbonadoDTO[] abonadosCliente = { abonado };
		AbonadoListDTO abonadoListCliente = new AbonadoListDTO();
		abonadoListCliente.setAbonados(abonadosCliente);

		cliente.setAbonados(abonadoListCliente);
		venta.setCliente(cliente);

		logger.debug("negSalUtils.generarOfertaComercial:antes");
		OfertaComercialDTO ofertaComercial = negSalUtils
				.generarOfertaComercial(venta);
		logger.debug("negSalUtils.generarOfertaComercial:despues");

		ofertaComercial.setNumEvento(supOrdHanDelegate.getProcess()
				.getIdProceso());

		// if(paramProductosContraList.getProductosContratadosDTO().length>0)
		// retorno = this.sendToQueueDescontratarVenta(datosVenta,
		// paramProductosContraList);
		// retorno = messageSender.sendToQueueActivacionVenta(ofertaComercial);
		// supOrdHanDelegate.inscribeProceso("ENCOLADO",
		// (byte[])SerializationUtils.serialize(ofertaComercial));

		ContenedorPlanesAdicionalesDTO retornoPlanesAdicionales = new ContenedorPlanesAdicionalesDTO();
		retornoPlanesAdicionales
				.setListaProductosDescontratar(paramProductosContraList);
		retornoPlanesAdicionales.setOfComercialContratar(ofertaComercial);

		return retornoPlanesAdicionales;
	}

	// ------------
	public ProductoContratadoListDTO descontratarPlanAdicional(
			PlanesAdicionalesDTO[] planesAdicionales)
			throws SupOrdHanException, ManCusInvException {
		logger.debug("descontratarPlanAdicional:start");
		RetornoDTO retorno = new RetornoDTO();
		ArrayList listaProductos = new ArrayList();
		ArrayList productoADesContratar = new ArrayList();

		/*
		 * String numClienteDest=planesAdicionales[0].getClienteDestino();
		 * 
		 * ClienteDTO cliente=new ClienteDTO();
		 * cliente.setCodCliente(Long.parseLong(numClienteDest));
		 * 
		 * 
		 * //Obtener datos del cliente //Se necesita el codigo de ciclob de
		 * facturacion try {
		 * logger.debug("manConFacadeDelegate.obtenerDatosCliente:antes");
		 * cliente=manConFacadeDelegate.obtenerDatosCliente(cliente);
		 * logger.debug("manConFacadeDelegate.obtenerDatosCliente:despues"); }
		 * catch (ManConException e) { logger.debug("ManConException", e); throw
		 * new SupOrdHanException(e); }
		 */

		for (int i = 0; i < planesAdicionales.length; i++) {
			ProductoContratadoDTO dto = new ProductoContratadoDTO();
			dto.setIdProdContratado(new Long(planesAdicionales[i]
					.getNumProducto()));
			dto.setOrigenProceso(planesAdicionales[i].getOrigenProceso());
			dto.setNumProceso(planesAdicionales[i].getNumProceso());

			// Estos id's los usa la descontratacion de productos
			dto.setNumProcesoDescontrata(planesAdicionales[i].getNumProceso());
			dto.setOrigenProcesoDescontrata(planesAdicionales[i]
					.getOrigenProceso());
			logger.debug("**********[producto N°" + i + "]***************");
			logger.debug(dto.getIdProdContratado());
			logger.debug(dto.getOrigenProceso());
			logger.debug(dto.getNumProceso());
			listaProductos.add(dto);
		}
		ProductoContratadoDTO[] prodContratados = (ProductoContratadoDTO[]) ArrayUtl
				.copiaArregloTipoEspecifico(listaProductos.toArray(),
						ProductoContratadoDTO.class);
		ProductoContratadoListDTO paramProductosContraList = new ProductoContratadoListDTO();
		paramProductosContraList.setProductosContratadosDTO(prodContratados);

		logger
				.debug("manCusInvDelegate.obtenerDetalleProductoContratado:antes");
		paramProductosContraList = manCusInvDelegate
				.obtenerDetalleProductoContratado(paramProductosContraList);
		logger
				.debug("manCusInvDelegate.obtenerDetalleProductoContratado:despues");
		for (int i = 0; i < paramProductosContraList
				.getProductosContratadosDTO().length; i++) {
			ProductoContratadoDTO prodCont = paramProductosContraList
					.getProductosContratadosDTO()[i];
			if ("1".equalsIgnoreCase(prodCont.getIndPaquete())) {
				logger
						.debug("manCusInvDelegate.obtenerProductoContratadoPorPaquete:antes");
				ProductoContratadoListDTO listaProdContPaq = manCusInvDelegate
						.obtenerProductoContratadoPorPaquete(prodCont);
				logger
						.debug("manCusInvDelegate.obtenerProductoContratadoPorPaquete:despues");
				listaProdContPaq = manCusInvDelegate
						.obtenerDetalleProductoContratado(listaProdContPaq);
				for (int j = 0; j < listaProdContPaq
						.getProductosContratadosDTO().length; j++) {
					productoADesContratar.add(listaProdContPaq
							.getProductosContratadosDTO()[j]);
				}
			} else {
				productoADesContratar.add(prodCont);
			}
		}
		prodContratados = (ProductoContratadoDTO[]) ArrayUtl
				.copiaArregloTipoEspecifico(productoADesContratar.toArray(),
						ProductoContratadoDTO.class);
		paramProductosContraList = new ProductoContratadoListDTO();
		paramProductosContraList.setProductosContratadosDTO(prodContratados);

		DatosVentaDTO datosVenta = new DatosVentaDTO();
		datosVenta.setNum_venta(planesAdicionales[0].getNumProceso());
		datosVenta.setCod_proceso(planesAdicionales[0].getOrigenProceso());

		// retorno=this.sendToQueueDescontratarVenta(datosVenta,
		// paramProductosContraList);
		logger.debug("descontratarPlanAdicional:end");
		return paramProductosContraList;
	}
	
	public boolean isNumber(String numero)throws NumberFormatException{
		boolean retValue=false;
		try{
			Float.parseFloat(numero); 
			retValue=true;
		}
		catch(NumberFormatException e){
			return false;
		}
		
		return retValue;
	}
	
	public CrearGeneralSoapException errorSoap(Exception e){
		
		String evento="";
		String codigo="";
		String descripcion="";
		CrearGeneralSoapException errorSoap = null;
		try {
			 if (e instanceof GeneralException) {
				 GeneralException generalException = (GeneralException) e;
				 evento=String.valueOf(generalException.getCodigoEvento());
				 codigo=generalException.getCodigo();
				 descripcion=generalException.getDescripcionEvento();
				 descripcion=descripcion==null?generalException.getMessage():descripcion;
			}
			
			errorSoap=new CrearGeneralSoapException(
	             	"",
	             	evento,
	                 " CRMWebServices (detalle errores) "+
	                 " ["+e.getMessage()+"] " +
	                 " evento : ["+evento+"]"+
	                 " codigo error : [" + codigo + "]"+
	                 " descripcion : ["+descripcion+"]",
	                 "", e);
		}
		catch(Exception e1){
			e1.printStackTrace();
		}	
		 return errorSoap;
	}
	
	public RetornoDTO errorRetornoDTO(Exception e){
		RetornoDTO retValue=new RetornoDTO();
		try{
			
			if (e instanceof GeneralException) {
				GeneralException generalException = (GeneralException) e;
				retValue.setCodigo(String.valueOf(generalException.getCodigoEvento()));
				String desc=generalException.getDescripcionEvento();
				while (desc==null){
						desc=generalException.getCause().toString();
						desc=desc==null?retornaCausaError((GeneralException)generalException.getCause()).getMessage():desc;
										
				}
				retValue.setDescripcion(desc);
			}
			
			if (retValue.getDescripcion()==null&&e instanceof Exception ) {
				
				retValue.setCodigo(String.valueOf(-200));
				retValue.setDescripcion(e.getMessage());
			}
			retValue.setResultado(false);//ocurrió error
			
		}
		catch(Exception e1){
			retValue.setDescripcion("Excepción no se pudo recuperar");
		}
		return retValue;
	}
	private GeneralException retornaCausaError(GeneralException ex){
		return (GeneralException)ex.getCause();
	}
}
