package com.tmmas.scl.operations.crm.f.sel.negsal.helper;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.sql.Timestamp;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.Formatting;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.CargoOcasionalDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.CargoOcasionalListDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.CargoRecurrenteDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.CargoRecurrenteListDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.CicloDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.framework.marketSalesDomain.contactLeadProspectABE.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.DatosGeneralesBOFactory;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.interfaces.DatosGeneralesBOFactoryIT;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.interfaces.DatosGeneralesBOIT;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.helper.Secuenciador;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoBeneficiarioDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoBeneficiarioListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.PaqueteContratadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.PaqueteContratadoListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.framework.productDomain.productABE.exception.ProductException;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.CargoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.CatalogoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.EspecProductoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PaqueteDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PaqueteListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoListDTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.LimiteConsumoPlanAdicionalDTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.LimiteConsumoPlanAdicionalListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.PerfilProvisionamientoDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.PerfilProvisionamientoListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.ProductoTasacionContratadoDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.ProductoTasacionContratadoListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.EspecServicioAltamiraDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.EspecServicioClienteDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.EspecServicioClienteListDTO;
import com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.ContenedorPlanesAdicionalesDTO;
import com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.OfertaComercialDTO;
import com.tmmas.scl.operations.crm.f.sel.negsal.exception.NegSalException;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.dao.DatosGeneralesDAO;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.dao.interfaces.DatosGeneralesDAOIT;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroListDTO;

public class NegSalUtils 
{
	private static NegSalUtils instance=null;
	private static Logger logger = Logger.getLogger(NegSalUtils.class);
	private static String CLASS_NAME = "NegSalUtils ";
	private String nomUsuaOra="NegSalUt";
	private NegotiateSalesDelegate delegate = NegotiateSalesDelegate.getInstance();
	
	private DatosGeneralesBOFactoryIT factoryBO = new DatosGeneralesBOFactory();
	private DatosGeneralesBOIT datosGeneralesBO = factoryBO.getBusinessObject1();
	private DatosGeneralesDAOIT datosGeneralesDAO = new DatosGeneralesDAO();
	
	private NegSalUtils()
	{
		
	}
	
	public static NegSalUtils getInstance()
	{
		if(instance==null)
			instance=new NegSalUtils();
		
		return instance;
	}
	
	/**
	 * Este método es responsable de generar a partir de un objeto VentaDTO una oferta comercial.
	 * @param venta objeto VentaDTO que contiene la información del Cliente (ClienteDTO), el código del vendedor y el resto de los
	 * 		  atributos que identifican la Venta.
	 * @return OfertaComercialDTO que contiene:
	 * <ul>
	 * <li>Lista de paquetes contratados (PaqueteContratadoListDTO )</li>
	 * <li>Lista de Productos Contratados (ProductoContratadoListDTO)</li>
     * <li>Lista de cargos recurrentes (CargoRecurrenteListDTO)</li>
     * <li>Lista de cargos ocasionales (CargoOcasionalListDTO)</li>
     * <li>Lista de productos tasación contratados (ProductoTasacionContratadoListDTO)</li>
     * </ul>
     */	
	public OfertaComercialDTO generarOfertaComercial(VentaDTO venta) throws NegSalException
	{
		//Se instancia el objeto oferta comercial a ser retornado
		logger.debug(CLASS_NAME+"generarOfertaComercial ini");		
		OfertaComercialDTO retorno=new OfertaComercialDTO();		
		//Se instancia la listas de objetos con los que se construira la oferta comercial
		ArrayList arrPaqueteContratados=new ArrayList();
		ArrayList arrProductosContratados=new ArrayList();
		ArrayList arrCargoRecurrentes=new ArrayList();
		ArrayList arrCargoOcasionales=new ArrayList();
		ArrayList arrProductoTasacionContratados=new ArrayList();
		ArrayList arrPerfilProvisionamientos=new ArrayList();
		ArrayList arrLimitesDeConsumo=new ArrayList();
		
		//Se declaran los diversos objetos que contendran cada una de las listas definidas previamente
		PaqueteContratadoDTO  			paqueteContratado			=null;
		ProductoContratadoDTO 			producContratado			=null;
		CargoRecurrenteDTO 	  			cargoRecurrente				=null;
		CargoOcasionalDTO  	  			cargoOcasional				=null;
		ProductoTasacionContratadoDTO 	productoTasacionContratado	=null;
		PerfilProvisionamientoDTO 		perfilProvisionamiento		=null;
		
		Secuenciador secuenciador=Secuenciador.getInstance();
		SecuenciaDTO secuence=new SecuenciaDTO();
		secuence.setNomSecuencia("PF_PRODUCTOS_CONTRATADOS_SQ");
		
		Calendar cal=Calendar.getInstance();	
		ProductoOfertadoDTO prodOfert=null;		
		AbonadoDTO abon=null;		
		String codCanal="";
		//Se obtiene la lista de Abonados a partir del ClienteDTO contenido en el objeto VentaDTO
		ClienteDTO cliente=venta.getCliente(); 
		AbonadoListDTO abonados=cliente.getAbonados();
		LimiteConsumoPlanAdicionalDTO limiteConsumoProducto = new LimiteConsumoPlanAdicionalDTO(); 
		nomUsuaOra=venta.getNomUsuaOra();
		
		try
		{		
			//Se itera por cada abonado para obtener los datos necesarios para cada unos de los objetos
			//paqueteContratado, producContratado, cargoRecurrente, cargoOcasional, productoTasacionContratado, perfilProvisionamiento
			Date fechaHoraBaseDatos = venta.getFecVenta();//obtenerFechaInicioVigencia(); Mod cuando este PR_CONSULTAS_PG.GE_FECHA_HORA_PR
			for(int indexAbon=0;indexAbon<abonados.getAbonados().length;indexAbon++)
			{
				abon=null;
				abon=abonados.getAbonados()[indexAbon];
				CatalogoDTO catalogo=abon.getCatalogo();
				codCanal=catalogo.getCodCanal();
				//PRODUCTOS CONTRATADOS
				for(int indexProdOf=0;indexProdOf<abon.getProdOfertList().getProductoList().length;indexProdOf++)
				{
					prodOfert=null;
					prodOfert=abon.getProdOfertList().getProductoList()[indexProdOf];
					EspecProductoDTO especProducto=prodOfert.getEspecificacionProducto();
					EspecServicioClienteListDTO especServicioCliente=especProducto.getEspecServicioClienteList();				
					//especServicioCliente.getEspServCliList()[0].				
					producContratado=new ProductoContratadoDTO();
					cargoRecurrente=new CargoRecurrenteDTO();
					cargoOcasional=new CargoOcasionalDTO();
					productoTasacionContratado=new ProductoTasacionContratadoDTO();
					perfilProvisionamiento=new PerfilProvisionamientoDTO();
					EspecServicioClienteDTO especServCliente=especServicioCliente.getEspServCliList()[0];					
					
					/*for(int indexEspecServCli=0;indexEspecServCli<especServicioCliente.getEspServCliList().length;indexEspecServCli++)
					{	EspecServicioClienteDTO especServClie=especServicioCliente.getEspServCliList()[0];					
						if(especServClie.getCodPerfilLista()!=null && !"".equals(especServClie.getCodPerfilLista()))					
						{ producContratado.setCodPerfilLista(especServClie.getCodPerfilLista());
						}					
					}*/
					
	//				LLenando Producto Contratado	
					secuence=secuenciador.obtenerSecuencia(secuence);
					producContratado.setIdProdContratado(new Long(secuence.getNumSecuencia()));
					producContratado.setCodPerfilLista(especServCliente.getCodPerfilLista());
					producContratado.setFechaInicioVigencia(fechaHoraBaseDatos);//venta.getFecVenta()); 070409 pv
					producContratado.setFechaProceso(venta.getFecVenta());
					cal.set(3000, 11, 31);
					producContratado.setFechaTerminoVigencia(obtenerFechaTerminoVigencia(cal, 
							                                 especProducto.getTipoComportamiento(), cliente.getCodCiclo()));
					producContratado.setIdAbonadoBeneficiario(new Long(abon.getNumAbonado()));
					producContratado.setIdCanal(catalogo.getCodCanal());
					producContratado.setIdClienteBeneficiario(new Long(cliente.getCodCliente()));
					producContratado.setIdClienteContratante(new Long(cliente.getCodCliente()));
					producContratado.setIdEstado("OK");
					producContratado.setIdProductoOfertado(new Long(prodOfert.getIdProductoOfertado()));
					producContratado.setIndCondicionContratacion(prodOfert.getIndCondicionContratacion());
					producContratado.setIndPrioridad(new Long(1));
					producContratado.setListaNumero(prodOfert.getListaNumeros());
					producContratado.setNumAbonadoContratante(new Long(abon.getNumAbonado()));
					producContratado.setNumProceso(venta.getIdVenta());
					producContratado.setOrigenProceso(catalogo.getCodCanal());
					producContratado.setTipoComportamiento(especProducto.getTipoComportamiento());
					producContratado.setlimiteConsumoContratado(prodOfert.getLimiteConsumoSeleccionado());
					producContratado.setMtoConsumoConfigurado(prodOfert.getMtoConsumoConfigurado());//mix9003 101209 pv
					
					// Se setea el codigo del producto contratado conrrespondiente.
					if(producContratado.getListaNumero()!=null && producContratado.getListaNumero().getNumerosDTO().length>0)
					{
						producContratado.getListaNumero().setCodCliente(String.valueOf(producContratado.getIdClienteContratante().longValue()));
						producContratado.getListaNumero().setNumAbonado(String.valueOf(producContratado.getNumAbonadoContratante().longValue()));
						producContratado.getListaNumero().setIdProducto(String.valueOf(producContratado.getIdProdContratado().longValue()));
						producContratado.getListaNumero().setTipoComportamiento(producContratado.getTipoComportamiento());
						
						for(int i=0;i<producContratado.getListaNumero().getNumerosDTO().length;i++)
						{						
							producContratado.getListaNumero().getNumerosDTO()[i].setNumProceso(producContratado.getNumProceso());
							producContratado.getListaNumero().getNumerosDTO()[i].setOrigenProceso(producContratado.getOrigenProceso());							
							producContratado.getListaNumero().getNumerosDTO()[i].setIdAbonado(String.valueOf(producContratado.getNumAbonadoContratante().longValue()));
							producContratado.getListaNumero().getNumerosDTO()[i].setIdCliente(String.valueOf(producContratado.getIdClienteContratante().longValue()));
							producContratado.getListaNumero().getNumerosDTO()[i].setIdProductoContratado(String.valueOf(producContratado.getIdProdContratado().longValue()));							
						}
					}
					/** Se traspasan los datos de correo movistar rescatados en el producto ofertado 070410 pv ini*/
					logger.debug("Traspaso de datos de correo ini");
					if(prodOfert.getDatosCorreoMovistar() !=null )
					{
						prodOfert.getDatosCorreoMovistar().setCodCliente(producContratado.getIdClienteContratante().longValue());
						prodOfert.getDatosCorreoMovistar().setNumAbonado(producContratado.getNumAbonadoContratante().longValue());
						prodOfert.getDatosCorreoMovistar().setCodProdContratado(producContratado.getIdProdContratado().longValue());
						producContratado.setDatosCorreoMovistar(prodOfert.getDatosCorreoMovistar());
						producContratado.setDireccion(prodOfert.getDireccion());
					}
					logger.debug("prodOfert.isEnviaCorreo()["+prodOfert.isEnviaCorreo()+"]");		
					if(prodOfert.isEnviaCorreo() &&  prodOfert.getDatosEnvioCorreo() !=null )
					{
						producContratado.setEnviaCorreo(prodOfert.isEnviaCorreo());
						producContratado.setDatosEnvioCorreo(prodOfert.getDatosEnvioCorreo());
						logger.debug("idProdContratado["+producContratado.getIdProdContratado()+"]");
					}
					logger.debug("Traspaso de datos de correo fin");
					/** Se traspasan los datos de correo movistar rescatados en el producto ofertado 070410 pv fin*/
					
					
					
					// INI FPP 01-07-2011 171447 
					logger.debug(" INC 171447 -> seteando lista de numeros autoafinidad - bloque producto");
					logger.debug(" prodOfert.getEspecificacionProducto().getTipoComportamiento() [" + prodOfert.getEspecificacionProducto().getTipoComportamiento() +"]");
					//logger.debug(" especServicioCliente.getEspecSerLisList().getEspecServicioListaList()[0].getIndAutoAfinidad() [" + especServicioCliente.getEspecSerLisList().getEspecServicioListaList()[0].getIndAutoAfinidad() +"]");	
						if("PAFN".equalsIgnoreCase(prodOfert.getEspecificacionProducto().getTipoComportamiento()))
						{//tipo de comportamiento plan autoafin	
							logger.debug("tipo de comportamiento plan autoafin");
							//148172 SE CAMBIA especServCliente POR especServicioCliente 
							if("S".equalsIgnoreCase(especServicioCliente.getEspecSerLisList().getEspecServicioListaList()[0].getIndAutoAfinidad()))
							{//indicador de autoafinidad ON
								logger.debug("indicador de autoafinidad ON");
							if(abon.getNumAbonado() == 0){//solo a nivel de cliente
								producContratado.getListaNumero().setCodCliente(String.valueOf(producContratado.getIdClienteContratante().longValue()));
								producContratado.getListaNumero().setNumAbonado(String.valueOf(producContratado.getNumAbonadoContratante().longValue()));
								producContratado.getListaNumero().setIdProducto(String.valueOf(producContratado.getIdProdContratado().longValue()));
								producContratado.getListaNumero().setTipoComportamiento(producContratado.getTipoComportamiento());
								logger.debug("codigo cliente      " + producContratado.getListaNumero().getCodCliente());
								logger.debug("numero abonado      " + producContratado.getListaNumero().getNumAbonado());
								logger.debug("Id producto         " + producContratado.getListaNumero().getIdProducto());
								logger.debug("tipo comportemiento " + producContratado.getListaNumero().getTipoComportamiento());
								logger.debug("seteo lista de numeros");
								producContratado.getListaNumero().getNumerosDTO()[0].setNumProceso(producContratado.getNumProceso());
								producContratado.getListaNumero().getNumerosDTO()[0].setOrigenProceso(producContratado.getOrigenProceso());							
								producContratado.getListaNumero().getNumerosDTO()[0].setIdAbonado(String.valueOf(producContratado.getNumAbonadoContratante().longValue()));
								producContratado.getListaNumero().getNumerosDTO()[0].setIdCliente(String.valueOf(producContratado.getIdClienteContratante().longValue()));
								producContratado.getListaNumero().getNumerosDTO()[0].setIdProductoContratado(String.valueOf(producContratado.getIdProdContratado().longValue()));							
								logger.debug("NumProceso           " + producContratado.getListaNumero().getNumerosDTO()[0].getNumProceso());
								logger.debug("OrigenProceso        " + producContratado.getListaNumero().getNumerosDTO()[0].getOrigenProceso());
								logger.debug("IdAbonado            " + producContratado.getListaNumero().getNumerosDTO()[0].getIdAbonado());
								logger.debug("IdCliente            " + producContratado.getListaNumero().getNumerosDTO()[0].getIdCliente());
								logger.debug("IdProductoContratado " + producContratado.getListaNumero().getNumerosDTO()[0].getIdProductoContratado());
									
							}
						}
					}
					// FIN FPP 01-07-2011 171447 
					logger.debug(" FIN INC 171447 ");
					arrProductosContratados.add(producContratado);
					
	//--------------------------	----------------------------------------------------------------------------------------				
					// LLENAR CARGOS
					
					if(prodOfert.getCargoList()!=null && prodOfert.getCargoList().getCargoList()!=null)
					{
						for(int indexCargos=0;indexCargos<prodOfert.getCargoList().getCargoList().length;indexCargos++)
						{
							CargoDTO cargo=prodOfert.getCargoList().getCargoList()[indexCargos];	
							
							if(cargo.getTipoCargo()!=null && "R".equalsIgnoreCase(cargo.getTipoCargo()))
							{
								cargoRecurrente=new CargoRecurrenteDTO();							
								
								cargoRecurrente.setCodCargoContratado(cargo.getIdCargo());
								cargoRecurrente.setCodClientePago(String.valueOf(producContratado.getIdClienteContratante().longValue()));
								cargoRecurrente.setCodConcepto(cargo.getCodConcepto());
								cargoRecurrente.setCodPlanServ(cargo.getCodPlanServ());
								cargoRecurrente.setCodProdContratado(String.valueOf(producContratado.getIdProdContratado().longValue())); // TAMBIEN (**)						
								cargoRecurrente.setIndCargoPro("S".equalsIgnoreCase(cargo.getIndProrrateable())?"1":"0");
								cargoRecurrente.setFecDesdeCobr(producContratado.getFechaInicioVigencia());//*AROG*
								cargoRecurrente.setFecHastaCobr(producContratado.getFechaTerminoVigencia());//*AROG*
								cargoRecurrente.setFecAlta(producContratado.getFechaInicioVigencia());
								cargoRecurrente.setFecBaja(producContratado.getFechaTerminoVigencia());
								cargoRecurrente.setIdClienteServ(String.valueOf(producContratado.getIdClienteContratante().longValue()));
								cargoRecurrente.setNumAbonadoPago(null);
								cargoRecurrente.setIdAbonadoServ(String.valueOf(producContratado.getNumAbonadoContratante().longValue()));
								cargoRecurrente.setFecUltMod(null);
								cargoRecurrente.setTipoCobro(cargo.getTipoCobro()); 
								cargoRecurrente.setNomUsuario(nomUsuaOra);
								cargoRecurrente.setNumVenta(String.valueOf(abon.getNumVenta()));
								
								
								arrCargoRecurrentes.add(cargoRecurrente);
								
							}
							else if(cargo.getTipoCargo()!=null && "O".equalsIgnoreCase(cargo.getTipoCargo()))
							{						
								cargoOcasional=new CargoOcasionalDTO();						
								cargoOcasional.setSeqCargo(null);
								cargoOcasional.setCodCliente(String.valueOf(producContratado.getIdClienteContratante().longValue()));
								cargoOcasional.setNumAbonado(String.valueOf(producContratado.getNumAbonadoContratante().longValue()));
								cargoOcasional.setIdCargo(cargo.getIdCargo());
								cargoOcasional.setCodConcepto(cargo.getCodConcepto());
								cargoOcasional.setColumna(null);
								cargoOcasional.setCodProdContratado(String.valueOf(producContratado.getIdProdContratado().longValue())); // TAMBIEN (**)
								cargoOcasional.setCodPlanCom(cargo.getCodPlanCom()); 
								cargoOcasional.setImpCargo(cargo.getImporte());
								cargoOcasional.setCodMoneda(cargo.getMoneda());
								cargoOcasional.setNumUnidades("1");
								cargoOcasional.setIndFactur("9");								
								cargoOcasional.setFecAlta(producContratado.getFechaInicioVigencia());
								cargoOcasional.setNumSerie(null);
								cargoOcasional.setNumSerieMec(null);
								cargoOcasional.setValDescuento(null);
								cargoOcasional.setTipDescuento(null);
								cargoOcasional.setCodTecnologia(cargo.getCodTecnologia());					
								cargoOcasional.setCodConceptoDescuento(null);						
								cargoOcasional.setFecUltMod(null);
								cargoOcasional.setNomUsuario(nomUsuaOra);
								cargoOcasional.setCodCiclFact(null);
								cargoOcasional.setNumTransaccion(null);
								cargoOcasional.setNumVenta(null);
								
								cargoOcasional.setNumTerminal(String.valueOf(abon.getNumCelular()));//*AROG*
								cargoOcasional.setIndCuota("0");//*AROG*
								cargoOcasional.setIndSupertel("0");//*AROG*
								cargoOcasional.setMesGarantia("0");//*AROG*
								if("0".equals(venta.getFlagCiclo())) 
								{
									cargoOcasional.setNumTransaccion(venta.getNumTransaccion());
									cargoOcasional.setNumVenta(venta.getIdVenta());
								}
								else
								{
									cargoOcasional.setCodCiclFact(String.valueOf(cliente.getCodCicloFacturacion()));
								}							
								if(cargo.getDescuentos()!=null && cargo.getDescuentos().getDescuentoList().length>0)
								{
									cargoOcasional.setCodConceptoDescuento(cargo.getDescuentos().getDescuentoList()[0].getCodConceptoDescuento());
									cargoOcasional.setTipDescuento(cargo.getDescuentos().getDescuentoList()[0].getTipDescuento());
									cargoOcasional.setValDescuento(cargo.getDescuentos().getDescuentoList()[0].getValDescuento());
								}
								
								arrCargoOcasionales.add(cargoOcasional);
							}
						}
					}
					//	Límite de Consumo
					limiteConsumoProducto = new LimiteConsumoPlanAdicionalDTO(); 
					limiteConsumoProducto = ObtenerLimiteConsumoSeleccionado(prodOfert);
					limiteConsumoProducto.setCodCliente(Integer.valueOf(String.valueOf(producContratado.getIdClienteContratante().longValue())));
					limiteConsumoProducto.setNumAbonado(Integer.valueOf(String.valueOf(producContratado.getNumAbonadoContratante().longValue())));
					limiteConsumoProducto.setFecDesde(fechaHoraBaseDatos);
					limiteConsumoProducto.setFecHasta(null);
					limiteConsumoProducto.setNomUsuarOra(nomUsuaOra);
					limiteConsumoProducto.setFecAsignacion(fechaHoraBaseDatos);
					limiteConsumoProducto.setCodPlanTarif(especServCliente.getIdServicioBase());
											
					arrLimitesDeConsumo.add(limiteConsumoProducto);
					
	// LLENAR PRODUCTO TASACION	
					for(int indexEspecServCli=0;indexEspecServCli<especServicioCliente.getEspServCliList().length;indexEspecServCli++)
					{	
						EspecServicioClienteDTO especServClie=especServicioCliente.getEspServCliList()[indexEspecServCli];					
						
						if(especServClie.getIdEspecProvision() != null  && !"".equals(especServClie.getIdEspecProvision())
								&& !"0".equals(especServClie.getIdEspecProvision()))
						{
							llenarPerfilProvisionamiento(arrPerfilProvisionamientos, producContratado, abon, cliente,
									especServClie,especServicioCliente,indexEspecServCli);
						}
						if("TOL".equalsIgnoreCase(especServClie.getTipoServicio()))
						{
		//					 LLENAR PRODUCTO TASACIO CONTRATADO
							if(especServClie.getCodPerfilLista()!=null && !"".equals(especServClie.getCodPerfilLista()) 
									&& !"0".equals(especServClie.getCodPerfilLista()))					
							{ 
								producContratado.setCodPerfilLista(especServClie.getCodPerfilLista());
							}
							productoTasacionContratado=new ProductoTasacionContratadoDTO();
												
							productoTasacionContratado.setCanalDistro(catalogo.getCodCanal());
							productoTasacionContratado.setCodProdBase(especServClie.getIdServicioBase());
							productoTasacionContratado.setFecInicioVigencia(producContratado.getFechaInicioVigencia());
							productoTasacionContratado.setFecTerminoVigencia(producContratado.getFechaTerminoVigencia()); //EV
							productoTasacionContratado.setIdAbonado(String.valueOf(abon.getNumAbonado()));
							productoTasacionContratado.setIdCliente(String.valueOf(cliente.getCodCliente()));
							productoTasacionContratado.setIndPrioridad(String.valueOf(producContratado.getIndPrioridad()));
							
							//Inicio Inc. 171447 - 11/08/2011 - FDL
							//Timestamp fecBD = datosGeneralesDAO.obtenerFechaHoraBaseDatos();

							NumeroListDTO numeroList = new NumeroListDTO();
							numeroList = producContratado.getListaNumero();
							logger.debug("Inicio cambios FDL Seteo FecInicioVigencia en Lista Numeros 13/08/2011");
							
							if (numeroList != null && numeroList.getNumerosDTO().length > 0){//if (numeroList.getNumerosDTO().length > 0){
								
								logger.debug("Entra al IF");
								for(int x=0; x<numeroList.getNumerosDTO().length;x++){
					
									Timestamp fechaTemporal = new Timestamp(fechaHoraBaseDatos.getTime());
									numeroList.getNumerosDTO()[x].setFecInicioVigencia(fechaTemporal);
								}
								
								productoTasacionContratado.setListaNumeros(numeroList);
							}
							
							else{
								logger.debug("Entra al Else");
								productoTasacionContratado.setListaNumeros(producContratado.getListaNumero());
							}
							logger.debug("Fin cambios FDL Seteo FecInicioVigencia en Lista Numeros");
							//Fin Inc. 171447 - 11/08/2011 - FDL
							
							productoTasacionContratado.setCodProductoContratado(String.valueOf(producContratado.getIdProdContratado().longValue()));
							productoTasacionContratado.setTipoComp(producContratado.getTipoComportamiento());
							//productoTasacionContratado.set
							
							
							arrProductoTasacionContratados.add(productoTasacionContratado);
						}
						else if("AA".equalsIgnoreCase(especServClie.getTipoServicio()))
						{
							llenarPerfilProvisionamiento(arrPerfilProvisionamientos, producContratado, abon, cliente,
									especServClie,especServicioCliente,0);
						}	
					}	
				}
				
	//	------------------------------------------------------------------------------------------------------------------
	//	-----------------------------------------	LLENAR PAQUETE CONTRATADO  -------------------------------------------
	//	------------------------------------------------------------------------------------------------------------------
				ArrayList productosPorPaquete=null;
				
				
				
				for(int indexPaqOf=0;indexPaqOf<abon.getPaqueteList().getPaqueteList().length;indexPaqOf++)
				{		
					productosPorPaquete=new ArrayList();
					PaqueteDTO paqueteOfertado=abon.getPaqueteList().getPaqueteList()[indexPaqOf];				
					paqueteContratado=new PaqueteContratadoDTO();
					 
					EspecProductoDTO especProducto=null;
					EspecServicioClienteListDTO especServicioCliente=null;				
					//especServicioCliente.getEspServCliList()[0].				
					
					cargoRecurrente=new CargoRecurrenteDTO();
					cargoOcasional=new CargoOcasionalDTO();
					productoTasacionContratado=new ProductoTasacionContratadoDTO();
					perfilProvisionamiento=new PerfilProvisionamientoDTO();
					EspecServicioClienteDTO especServCliente=null;				
				
	//				LLenando Producto Contratado	
					//paqueteContratado.setCodPerfilLista(especServClie.getCodPerfilLista());
					
					secuence=secuenciador.obtenerSecuencia(secuence);
					paqueteContratado.setIdProdContratado(new Long(secuence.getNumSecuencia()));
					paqueteContratado.setIdProdContraPadre(new Long(0));
					paqueteContratado.setIdPaquete(String.valueOf(secuence.getNumSecuencia()));
					
					paqueteContratado.setFechaInicioVigencia(fechaHoraBaseDatos);//venta.getFecVenta()); 070409 pv
					paqueteContratado.setFechaProceso(venta.getFecVenta());
					cal.set(3000, 11, 31);
					paqueteContratado.setFechaTerminoVigencia(new Date(cal.getTimeInMillis()));
					paqueteContratado.setIdAbonadoBeneficiario(new Long(abon.getNumAbonado()));
					paqueteContratado.setIdCanal(catalogo.getCodCanal());
					paqueteContratado.setIdClienteBeneficiario(new Long(cliente.getCodCliente()));
					paqueteContratado.setIdClienteContratante(new Long(cliente.getCodCliente()));
					paqueteContratado.setIdEstado("OK");
					paqueteContratado.setIdProductoOfertado(new Long(paqueteOfertado.getIdProductoOfertado()));
					paqueteContratado.setIndCondicionContratacion(paqueteOfertado.getIndCondicionContratacion());
					paqueteContratado.setIndPrioridad(new Long(1));
					paqueteContratado.setListaNumero(paqueteOfertado.getListaNumeros());
					paqueteContratado.setNumAbonadoContratante(new Long(abon.getNumAbonado()));
					paqueteContratado.setNumProceso(venta.getIdVenta());
					paqueteContratado.setOrigenProceso(catalogo.getCodCanal());
					//paqueteContratado.setTipoComportamiento(especProducto.getTipoComportamiento());
					paqueteContratado.setIdPaquete(paqueteOfertado.getIdPaquete());
					paqueteContratado.setIndPaquete(paqueteOfertado.getIndPaquete());
					
					
					
					
					for(int indexProdOfert=0;indexProdOfert<paqueteOfertado.getProductoList().getProductoList().length;indexProdOfert++)
					{
						prodOfert=null;
						prodOfert=paqueteOfertado.getProductoList().getProductoList()[indexProdOfert];
						
						especProducto=prodOfert.getEspecificacionProducto();
						especServicioCliente=especProducto.getEspecServicioClienteList();				
						//especServicioCliente.getEspServCliList()[0].				
						producContratado=new ProductoContratadoDTO();
						cargoRecurrente=new CargoRecurrenteDTO();
						cargoOcasional=new CargoOcasionalDTO();
						productoTasacionContratado=new ProductoTasacionContratadoDTO();
						perfilProvisionamiento=new PerfilProvisionamientoDTO();
						especServCliente=especServicioCliente.getEspServCliList()[0];					
						
						/*for(int indexEspecServCli=0;indexEspecServCli<especServicioCliente.getEspServCliList().length;indexEspecServCli++)
						{	EspecServicioClienteDTO especServClie=especServicioCliente.getEspServCliList()[0];					
							if(especServClie.getCodPerfilLista()!=null && !"".equals(especServClie.getCodPerfilLista()))					
							{ producContratado.setCodPerfilLista(especServClie.getCodPerfilLista());
							}					
						}*/
						
	//				LLenando Producto Contratado	
						secuence=secuenciador.obtenerSecuencia(secuence);
						producContratado.setIdProdContratado(new Long(secuence.getNumSecuencia())); // Obtiene numero de producto contratado
						producContratado.setIdProdContraPadre(paqueteContratado.getIdProdContratado());
						
						
						producContratado.setCodPerfilLista(especServCliente.getCodPerfilLista());
						producContratado.setFechaInicioVigencia(fechaHoraBaseDatos);//venta.getFecVenta()); 070409 pv
						producContratado.setFechaProceso(venta.getFecVenta());
						cal.set(3000, 11, 31);
						producContratado.setFechaTerminoVigencia(obtenerFechaTerminoVigencia(cal, 
                                                                 especProducto.getTipoComportamiento(), cliente.getCodCiclo()));
						producContratado.setIdAbonadoBeneficiario(new Long(abon.getNumAbonado()));
						producContratado.setIdCanal(catalogo.getCodCanal());
						producContratado.setIdClienteBeneficiario(new Long(cliente.getCodCliente()));
						producContratado.setIdClienteContratante(new Long(cliente.getCodCliente()));
						producContratado.setIdEstado("OK");
						producContratado.setIdProductoOfertado(new Long(prodOfert.getIdProductoOfertado()));
						producContratado.setIndCondicionContratacion(prodOfert.getIndCondicionContratacion());
						producContratado.setIndPrioridad(new Long(1));
						producContratado.setListaNumero(prodOfert.getListaNumeros());
						producContratado.setNumAbonadoContratante(new Long(abon.getNumAbonado()));
						producContratado.setNumProceso(venta.getIdVenta());
						producContratado.setOrigenProceso(catalogo.getCodCanal());
						producContratado.setTipoComportamiento(especProducto.getTipoComportamiento());
						
						// Se setea el codigo del producto contratado conrrespondiente.
						if(producContratado.getListaNumero()!=null && producContratado.getListaNumero().getNumerosDTO().length>0)
						{
							producContratado.getListaNumero().setCodCliente(String.valueOf(producContratado.getIdClienteContratante().longValue()));
							producContratado.getListaNumero().setNumAbonado(String.valueOf(producContratado.getNumAbonadoContratante().longValue()));
							producContratado.getListaNumero().setIdProducto(String.valueOf(producContratado.getIdProdContratado().longValue()));
							producContratado.getListaNumero().setTipoComportamiento(producContratado.getTipoComportamiento());
							
							for(int i=0;i<producContratado.getListaNumero().getNumerosDTO().length;i++)
							{						
								producContratado.getListaNumero().getNumerosDTO()[i].setNumProceso(producContratado.getNumProceso());
								producContratado.getListaNumero().getNumerosDTO()[i].setOrigenProceso(producContratado.getOrigenProceso());
								producContratado.getListaNumero().getNumerosDTO()[i].setOrigenProceso(producContratado.getOrigenProceso());
								producContratado.getListaNumero().getNumerosDTO()[i].setIdAbonado(String.valueOf(producContratado.getNumAbonadoContratante().longValue()));
								producContratado.getListaNumero().getNumerosDTO()[i].setIdCliente(String.valueOf(producContratado.getIdClienteContratante().longValue()));
								producContratado.getListaNumero().getNumerosDTO()[i].setIdProductoContratado(String.valueOf(producContratado.getIdProdContratado().longValue()));
								
							}
						}
						
						
						// INI FPP 01-07-2011 171447 
						logger.debug(" INC 171447 -> seteando lista de numeros autoafinidad - bloque producto");
					  logger.debug(" prodOfert.getEspecificacionProducto().getTipoComportamiento()                                 [" + prodOfert.getEspecificacionProducto().getTipoComportamiento() +"]");	
					  //logger.debug(" especServicioCliente.getEspecSerLisList().getEspecServicioListaList()[0].getIndAutoAfinidad() [" + especServicioCliente.getEspecSerLisList().getEspecServicioListaList()[0].getIndAutoAfinidad() +"]");	
						if("PAFN".equalsIgnoreCase(prodOfert.getEspecificacionProducto().getTipoComportamiento()))
						{//tipo de comportamiento plan autoafin	
							logger.debug("tipo de comportamiento plan autoafin");
							//148172 SE CAMBIA especServCliente POR especServicioCliente 
							if("S".equalsIgnoreCase(especServicioCliente.getEspecSerLisList().getEspecServicioListaList()[0].getIndAutoAfinidad()))
							{//indicador de autoafinidad ON
								logger.debug("indicador de autoafinidad ON");
								if(abon.getNumAbonado() == 0){//solo a nivel de cliente
									producContratado.getListaNumero().setCodCliente(String.valueOf(producContratado.getIdClienteContratante().longValue()));
									producContratado.getListaNumero().setNumAbonado(String.valueOf(producContratado.getNumAbonadoContratante().longValue()));
									producContratado.getListaNumero().setIdProducto(String.valueOf(producContratado.getIdProdContratado().longValue()));
									producContratado.getListaNumero().setTipoComportamiento(producContratado.getTipoComportamiento());
									logger.debug("codigo cliente      " + producContratado.getListaNumero().getCodCliente());
									logger.debug("numero abonado      " + producContratado.getListaNumero().getNumAbonado());
									logger.debug("Id producto         " + producContratado.getListaNumero().getIdProducto());
									logger.debug("tipo comportemiento " + producContratado.getListaNumero().getTipoComportamiento());
									logger.debug("seteo lista de numeros");
									producContratado.getListaNumero().getNumerosDTO()[0].setNumProceso(producContratado.getNumProceso());
									producContratado.getListaNumero().getNumerosDTO()[0].setOrigenProceso(producContratado.getOrigenProceso());							
									producContratado.getListaNumero().getNumerosDTO()[0].setIdAbonado(String.valueOf(producContratado.getNumAbonadoContratante().longValue()));
									producContratado.getListaNumero().getNumerosDTO()[0].setIdCliente(String.valueOf(producContratado.getIdClienteContratante().longValue()));
									producContratado.getListaNumero().getNumerosDTO()[0].setIdProductoContratado(String.valueOf(producContratado.getIdProdContratado().longValue()));							
									logger.debug("NumProceso           " + producContratado.getListaNumero().getNumerosDTO()[0].getNumProceso());
									logger.debug("OrigenProceso        " + producContratado.getListaNumero().getNumerosDTO()[0].getOrigenProceso());
									logger.debug("IdAbonado            " + producContratado.getListaNumero().getNumerosDTO()[0].getIdAbonado());
									logger.debug("IdCliente            " + producContratado.getListaNumero().getNumerosDTO()[0].getIdCliente());
									logger.debug("IdProductoContratado " + producContratado.getListaNumero().getNumerosDTO()[0].getIdProductoContratado());
										
								}
							}
						}						

					// FIN FPP 01-07-2011 171447 
					logger.debug("FIN INC 171447 ");
						
						
						productosPorPaquete.add(producContratado);
						for(int indexEspecServCli=0;indexEspecServCli<especServicioCliente.getEspServCliList().length;indexEspecServCli++)
						{	
							EspecServicioClienteDTO especServClie=especServicioCliente.getEspServCliList()[indexEspecServCli];					
							
							if(especServClie.getIdEspecProvision() != null  && !"".equals(especServClie.getIdEspecProvision())
									&& !"0".equals(especServClie.getIdEspecProvision()))
							{
								llenarPerfilProvisionamiento(arrPerfilProvisionamientos, producContratado, abon, cliente,
										especServClie,especServicioCliente,0);
							}
							if("TOL".equalsIgnoreCase(especServClie.getTipoServicio()))
							{
		//						 LLENAR PRODUCTO TASACIO CONTRATADO
								if(especServClie.getCodPerfilLista()!=null && !"".equals(especServClie.getCodPerfilLista()) 
										&& !"0".equals(especServClie.getCodPerfilLista()))					
								{ 
									producContratado.setCodPerfilLista(especServClie.getCodPerfilLista());
								}
								productoTasacionContratado=new ProductoTasacionContratadoDTO();
								
								productoTasacionContratado.setCodProductoContratado(String.valueOf(producContratado.getIdProdContratado().longValue()));
								
								productoTasacionContratado.setCanalDistro(catalogo.getCodCanal());
								productoTasacionContratado.setCodProdBase(especServClie.getIdServicioBase());
								productoTasacionContratado.setFecInicioVigencia(producContratado.getFechaInicioVigencia());
								productoTasacionContratado.setFecTerminoVigencia(producContratado.getFechaTerminoVigencia()); //EV
								productoTasacionContratado.setIdAbonado(String.valueOf(abon.getNumAbonado()));
								productoTasacionContratado.setIdCliente(String.valueOf(cliente.getCodCliente()));
								productoTasacionContratado.setIndPrioridad(String.valueOf(producContratado.getIndPrioridad()));
								productoTasacionContratado.setListaNumeros(producContratado.getListaNumero());
								productoTasacionContratado.setTipoComp(producContratado.getTipoComportamiento());
								//productoTasacionContratado.setCodProductoContratado() (**) ESTE VALOR SE DEBERIA VOLVER A SETEAR EN EL NEGOCIO AL ACTIVAR LOS PRODUCTOS CONTRATADOS
								
								arrProductoTasacionContratados.add(productoTasacionContratado);
							}
							else if("AA".equalsIgnoreCase(especServClie.getTipoServicio()))
							{
								// LLENAR PERFIL PROVISIONAMIENTO
								llenarPerfilProvisionamiento(arrPerfilProvisionamientos, producContratado, abon, cliente,
										especServClie,especServicioCliente,0);
							}
							
						}
						
						limiteConsumoProducto = new LimiteConsumoPlanAdicionalDTO(); 
						limiteConsumoProducto = ObtenerLimiteConsumoSeleccionado(prodOfert);
						limiteConsumoProducto.setCodCliente(Integer.valueOf(String.valueOf(producContratado.getIdClienteContratante().longValue())));
						limiteConsumoProducto.setNumAbonado(Integer.valueOf(String.valueOf(producContratado.getNumAbonadoContratante().longValue())));
						limiteConsumoProducto.setFecDesde(fechaHoraBaseDatos);
						limiteConsumoProducto.setFecHasta(null);
						limiteConsumoProducto.setNomUsuarOra(nomUsuaOra);
						limiteConsumoProducto.setFecAsignacion(fechaHoraBaseDatos);
						limiteConsumoProducto.setCodPlanTarif(especServCliente.getIdServicioBase());
												
						arrLimitesDeConsumo.add(limiteConsumoProducto);
										
					}				
					
		//------------------- CARGOS DEL PAQUETE 
					 if(paqueteOfertado.getCargoList()!=null)
					 {
						for(int indexCargos=0;indexCargos<paqueteOfertado.getCargoList().getCargoList().length;indexCargos++)
						{					
							CargoDTO cargo=paqueteOfertado.getCargoList().getCargoList()[indexCargos];	
							
							if(cargo.getTipoCargo()!=null && "R".equalsIgnoreCase(cargo.getTipoCargo()))
							{
								cargoRecurrente=new CargoRecurrenteDTO();
								cargoRecurrente.setCodCargoContratado(cargo.getIdCargo());
								cargoRecurrente.setCodClientePago(String.valueOf(paqueteContratado.getIdClienteContratante().longValue()));
								cargoRecurrente.setCodConcepto(cargo.getCodConcepto());
								cargoRecurrente.setCodPlanServ(cargo.getCodPlanServ());
								cargoRecurrente.setCodProdContratado(String.valueOf(paqueteContratado.getIdProdContratado().longValue())); // TAMBIEN (**)						
								cargoRecurrente.setIndCargoPro("S".equalsIgnoreCase(cargo.getIndProrrateable())?"1":"0");
								cargoRecurrente.setFecDesdeCobr(paqueteContratado.getFechaInicioVigencia());//*AROG*
								cargoRecurrente.setFecHastaCobr(paqueteContratado.getFechaTerminoVigencia());//*AROG*
								cargoRecurrente.setFecAlta(paqueteContratado.getFechaInicioVigencia());
								cargoRecurrente.setFecBaja(paqueteContratado.getFechaTerminoVigencia());
								cargoRecurrente.setIdClienteServ(String.valueOf(paqueteContratado.getIdClienteContratante().longValue()));
								cargoRecurrente.setNumAbonadoPago(null);
								cargoRecurrente.setIdAbonadoServ(String.valueOf(paqueteContratado.getNumAbonadoContratante().longValue()));
								cargoRecurrente.setFecUltMod(null);
								cargoRecurrente.setNomUsuario(nomUsuaOra);				
								cargoRecurrente.setTipoCobro(cargo.getTipoCobro());
								arrCargoRecurrentes.add(cargoRecurrente);
								
							}
							else if(cargo.getTipoCargo()!=null && "O".equalsIgnoreCase(cargo.getTipoCargo()))
							{						
								cargoOcasional=new CargoOcasionalDTO();						
								cargoOcasional.setSeqCargo(null);
								cargoOcasional.setCodCliente(String.valueOf(paqueteContratado.getIdClienteContratante().longValue()));
								cargoOcasional.setNumAbonado(String.valueOf(paqueteContratado.getNumAbonadoContratante().longValue()));
								cargoOcasional.setIdCargo(cargo.getIdCargo());
								cargoOcasional.setCodConcepto(cargo.getCodConcepto());
								cargoOcasional.setColumna(null);
								cargoOcasional.setCodProdContratado(String.valueOf(paqueteContratado.getIdProdContratado().longValue())); // TAMBIEN (**)						
								cargoOcasional.setImpCargo(cargo.getImporte());
								cargoOcasional.setCodMoneda(cargo.getMoneda());
								cargoOcasional.setNumUnidades("1");
								cargoOcasional.setIndFactur("9");
								cargoOcasional.setCodPlanCom(cargo.getCodPlanCom());							
								cargoOcasional.setFecAlta(paqueteContratado.getFechaInicioVigencia());
								cargoOcasional.setNumSerie(null);
								cargoOcasional.setNumSerieMec(null);
								cargoOcasional.setValDescuento(null);
								cargoOcasional.setTipDescuento(null);
								cargoOcasional.setCodTecnologia(cargo.getCodTecnologia());					
								cargoOcasional.setCodConceptoDescuento(null);						
								cargoOcasional.setFecUltMod(null);
								cargoOcasional.setNomUsuario(nomUsuaOra);
								
								cargoOcasional.setNumTerminal(String.valueOf(abon.getNumCelular()));//*AROG*
								cargoOcasional.setIndCuota("0");//*AROG*
								cargoOcasional.setIndSupertel("0");//*AROG*
								cargoOcasional.setMesGarantia("0");//*AROG*
								cargoOcasional.setNumTransaccion(null);
								cargoOcasional.setNumVenta(null);
								cargoOcasional.setCodCiclFact(null);
								
								if("0".equals(venta.getFlagCiclo()))
								{
									cargoOcasional.setNumTransaccion(venta.getNumTransaccion());
									cargoOcasional.setNumVenta(venta.getIdVenta());
								}
								else
								{
									cargoOcasional.setCodCiclFact(String.valueOf(cliente.getCodCicloFacturacion()));
								}												
								if(cargo.getDescuentos()!=null && cargo.getDescuentos().getDescuentoList()!=null && cargo.getDescuentos().getDescuentoList().length>0)
								{
									cargoOcasional.setCodConceptoDescuento(cargo.getDescuentos().getDescuentoList()[0].getCodConceptoDescuento());
									cargoOcasional.setTipDescuento(cargo.getDescuentos().getDescuentoList()[0].getTipDescuento());
									cargoOcasional.setValDescuento(cargo.getDescuentos().getDescuentoList()[0].getValDescuento());
								}
								
								arrCargoOcasionales.add(cargoOcasional);
							}					
						}
					}
					
					ProductoContratadoDTO[] prodPaquetes=(ProductoContratadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(productosPorPaquete.toArray(), ProductoContratadoDTO.class);
					ProductoContratadoListDTO prodpaquetesList=new ProductoContratadoListDTO();
					prodpaquetesList.setProductosContratadosDTO(prodPaquetes);
					paqueteContratado.setListaProductosContratados(prodpaquetesList);
					
					arrPaqueteContratados.add(paqueteContratado);
				} // FIN FOR PAQUETE				
			} // FIN FOR ABONADOS
		}
		catch (GeneralException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug(CLASS_NAME+"generarOfertaComercial GENegSalException\n"+loge);
			throw new NegSalException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch(Exception e)
		{
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug(CLASS_NAME+"generarOfertaComercial NegSalException\n"+loge);
			throw new NegSalException(e);
		}
		
			
		PaqueteContratadoDTO[] paquetesContratados=(PaqueteContratadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(arrPaqueteContratados.toArray(), PaqueteContratadoDTO.class);
		ProductoContratadoDTO[] prodContratados=(ProductoContratadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(arrProductosContratados.toArray(), ProductoContratadoDTO.class);		
		CargoRecurrenteDTO[] cargosRecurrentes=(CargoRecurrenteDTO[]) ArrayUtl.copiaArregloTipoEspecifico(arrCargoRecurrentes.toArray(), CargoRecurrenteDTO.class);
		CargoOcasionalDTO[] cargosOcasionales=(CargoOcasionalDTO[]) ArrayUtl.copiaArregloTipoEspecifico(arrCargoOcasionales.toArray(), CargoOcasionalDTO.class);
		ProductoTasacionContratadoDTO[] productoTasacionContratados=(ProductoTasacionContratadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(arrProductoTasacionContratados.toArray(), ProductoTasacionContratadoDTO.class);
		PerfilProvisionamientoDTO[] perfilesProvisionamiento=(PerfilProvisionamientoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(arrPerfilProvisionamientos.toArray(), PerfilProvisionamientoDTO.class);
		LimiteConsumoPlanAdicionalDTO[] limitesDeConsumo = (LimiteConsumoPlanAdicionalDTO[]) ArrayUtl.copiaArregloTipoEspecifico(arrLimitesDeConsumo.toArray(), LimiteConsumoPlanAdicionalDTO.class);
		
		 
		 PaqueteContratadoListDTO paqueteList=new PaqueteContratadoListDTO();
		 ProductoContratadoListDTO productoList=new ProductoContratadoListDTO();
		 CargoRecurrenteListDTO cargoRecurrenteList=new CargoRecurrenteListDTO();
		 CargoOcasionalListDTO cargoOcasionalList=new CargoOcasionalListDTO();
		 ProductoTasacionContratadoListDTO listaProductoTasCon=new ProductoTasacionContratadoListDTO();
		 PerfilProvisionamientoListDTO listaPerfilProv=new PerfilProvisionamientoListDTO();
		 LimiteConsumoPlanAdicionalListDTO listaLimitesDeConsumo=new LimiteConsumoPlanAdicionalListDTO();
		
		 paqueteList.setPaqueteContratadoList(paquetesContratados);
		 productoList.setProductosContratadosDTO(prodContratados);
		 cargoRecurrenteList.setCargoRecurrente(cargosRecurrentes);
		 cargoOcasionalList.setCargoOcasional(cargosOcasionales);
		 listaLimitesDeConsumo.setLimitesDeConsumo(limitesDeConsumo);
		 
		 
		 /**
		  * Se agregan parametros extras necesarios para TOL
		  */
		 listaProductoTasCon.setProductosTasacionContratados(productoTasacionContratados);
		 listaProductoTasCon.setCodCliente(String.valueOf(cliente.getCodCliente()));
		 listaProductoTasCon.setCodCanal(codCanal);
		 listaProductoTasCon.setCodCicloFacturacion(String.valueOf(cliente.getCodCiclo()));
		 listaPerfilProv.setPerfilesProvisionamientos(perfilesProvisionamiento);
		 
		 //Se llena el objeto oferta comercial con cada una de las listas obtenidas
		 retorno.setOrigenProceso(codCanal);
		 retorno.setNumProceso(venta.getIdVenta());
		 retorno.setNumEvento(venta.getNumEvento());
		 retorno.setOrigenProceso(venta.getOrigenProceso());
		 retorno.setPaqueteList(paqueteList);
		 retorno.setProductoList(productoList);
		 retorno.setCargoOcasionalList(cargoOcasionalList);
		 retorno.setCargoRecurrenteList(cargoRecurrenteList);
		 retorno.setListaPerfilProv(listaPerfilProv);
		 retorno.setListaProductoTasCon(listaProductoTasCon);
		 retorno.setListaLimitesDeConsumo(listaLimitesDeConsumo);
		 
		 logger.debug(CLASS_NAME+"generarOfertaComercial fin");
		return retorno; 		 //Se retorna el objeto comercial
	}
	
	//070409 pv
	private Date obtenerFechaInicioVigencia() throws NegSalException {
		//especProducto.getTipoComportamiento()
		logger.debug("obtenerFechaInicioVigencia():inicio");
		Date fechaHoraBaseDatos = null;
		try{
			fechaHoraBaseDatos = new java.util.Date((datosGeneralesBO.obtenerFechaHoraBaseDatos()).getTime());
			/*DD-MM-YYYY HH24:MI:SS formato inicial que no se puede recibir en un Timestamp por lo que se cambió al siguiente:
			YYYY-MM-DD HH24:MI:SS*/ //yyyy-mm-dd hh:mm:ss.fffffffff <-- public static Timestamp valueOf(String s)
			//Date fechaInicioVigencia = Formatting.getFecha(fechaHoraBaseDatos.toString(),"dd-MM-yyyy");//yyyy.MM.dd
		}
		catch(ProductException e){
			throw new NegSalException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}

		logger.debug("obtenerFechaInicioVigencia fechaHoraBaseDatos --->["+fechaHoraBaseDatos+"]");
		return fechaHoraBaseDatos;
	}
	
	//070109 pv
	private Date obtenerFechaTerminoVigencia(Calendar cal, String tipoComportamiento,int codCiclo) throws NegSalException {
		//especProducto.getTipoComportamiento()
		Date fechaTerminoVigencia = new Date(cal.getTimeInMillis());
		if("PMOD".equals(tipoComportamiento))
		{
			CicloDTO ciclo = new CicloDTO();
			ciclo.setCodCiclo(codCiclo);//cliente.getCodCiclo()
			logger.debug("obtenerFechaCiclo():inicio");
			ciclo = delegate.obtenerFechaCiclo(ciclo);
			logger.debug("obtenerFechaCiclo():fin");
			
			String fecDesdeLlam = ciclo.getFecDesdeLlam();//int periodoFact = ciclo.getPeriodoCodCiclFact();
			fechaTerminoVigencia = Formatting.getFecha(fecDesdeLlam,"dd-MM-yyyy");//yyyy.MM.dd
			//fecCicloDesdeLlam[02-02-2009]
			//Formatting.dateTime(fechaActual,"DD-MM-YYYY");
			//fechaTerminoVigencia = new Date(fecDesdeLlam); deprecated
		}
		logger.debug("fechaTerminoVigencia --->["+fechaTerminoVigencia+"]");
		return fechaTerminoVigencia;
	}
	
	private void llenarPerfilProvisionamiento(ArrayList arrPerfilProvisionamientos, ProductoContratadoDTO producContratado, 
			AbonadoDTO abon, ClienteDTO cliente , EspecServicioClienteDTO especServClie, 
			EspecServicioClienteListDTO especServicioCliente, int indexEspecServCli) 
	{
		//LLENAR PERFIL PROVISIONAMIENTO	
		
		PerfilProvisionamientoDTO perfilProvisionamiento = new PerfilProvisionamientoDTO();
					
		producContratado.setIdEstado("OK");//"PENDIENTE");181108 pv
		perfilProvisionamiento.setCodProdContratado(String.valueOf(producContratado.getIdProdContratado().longValue()));
		perfilProvisionamiento.setTipoServicio(especServClie.getTipoServicio());
		perfilProvisionamiento.setIdEspecificacionProvisionamiento(especServClie.getIdEspecProvision());
		perfilProvisionamiento.setCodCausa("00"); // VALIDAR CON CENTRALES
		perfilProvisionamiento.setCodCentral(String.valueOf(abon.getCodCentral()));
		perfilProvisionamiento.setFechaEjecucion(producContratado.getFechaInicioVigencia());
		perfilProvisionamiento.setCodMoneda("0");
		perfilProvisionamiento.setCodPeriodificacion(null); //PENDIENTE
		perfilProvisionamiento.setCodProvServ(especServClie.getIdEspecProvision());
		perfilProvisionamiento.setCodTecnologia(abon.getCodTecnologia());
		perfilProvisionamiento.setIdAbonado(String.valueOf(abon.getNumAbonado()));
		perfilProvisionamiento.setIdCliente(String.valueOf(cliente.getCodCliente()));
		perfilProvisionamiento.setIdPlan(especServClie.getIdServicioBase());
		perfilProvisionamiento.setImporte("0"); // POR AHORA
		perfilProvisionamiento.setNumMovimientoAnterior(abon.getNumMovimientoAlta());
		
		if("AA".equalsIgnoreCase(especServClie.getTipoServicio()))
		{
			//indexEspecServCli = 0;?
			EspecServicioAltamiraDTO espServAlt = null;
			String cantidadBon = null;
			String tipoUnidadBonificacion = null;
			if(especServicioCliente != null && especServicioCliente.getEspecSerAltList() != null &&
			   especServicioCliente.getEspecSerAltList().getEspServAltList()[indexEspecServCli] != null	)
			{
				espServAlt = especServicioCliente.getEspecSerAltList().getEspServAltList()[indexEspecServCli];
			}
			
			if(espServAlt != null)
			{
				if(espServAlt.getCantidadBonificada() != null)
				{
					cantidadBon = espServAlt.getCantidadBonificada();
				}
				if(espServAlt.getTipoUnidadBonificacion() != null)
				{
					tipoUnidadBonificacion = espServAlt.getTipoUnidadBonificacion();
				}
				perfilProvisionamiento.setMontoBonificacion(cantidadBon);
				perfilProvisionamiento.setTipoBono(tipoUnidadBonificacion);
			}
			else
			{
				if(especServClie.getEspecSerAltList()!=null && especServClie.getEspecSerAltList().getEspServAltList()!=null)
					perfilProvisionamiento.setMontoBonificacion(especServClie.getEspecSerAltList().getEspServAltList()[0].getCantidadBonificada());
				
				if(especServClie.getEspecSerAltList()!=null && especServClie.getEspecSerAltList().getEspServAltList()!=null)
					perfilProvisionamiento.setTipoBono(especServClie.getEspecSerAltList().getEspServAltList()[0].getTipoUnidadBonificacion());
			}

			if (perfilProvisionamiento.getTipoBono().equalsIgnoreCase("MNT"))perfilProvisionamiento.setImporte(perfilProvisionamiento.getMontoBonificacion());
		}
		
		perfilProvisionamiento.setNroCelular(String.valueOf(abon.getNumCelular()));
		perfilProvisionamiento.setNumSerie(abon.getNumSerie());
		perfilProvisionamiento.setTipAccion("1"); // VALIDAR CON CENTRALES
		
		
		
		perfilProvisionamiento.setTipTerminal(abon.getCodTipoTerminal());
		perfilProvisionamiento.setUsuario("SCL"); // VALIDAR CON CENTRALES
		perfilProvisionamiento.setNomUsuario_Ora(nomUsuaOra);
		
		
		arrPerfilProvisionamientos.add(perfilProvisionamiento);
	}
	
	
//----------------------------------------------------------------------------------------------------------------------
	
//----------------------------------------------------------------------------------------------------------------------
	
	public AbonadoDTO splitProductosPaquetes(AbonadoDTO abonado)
	{		
		
		ArrayList productosOfertados=new ArrayList();
		ArrayList paquetesOfertados=new ArrayList();			
		
		ProductoOfertadoListDTO prodOfertados=abonado.getProdOfertList();
		
		for(int i=0;i<prodOfertados.getProductoList().length;i++)
		{
			ProductoOfertadoDTO dto=prodOfertados.getProductoList()[i];
			
			if("1".equalsIgnoreCase(dto.getIndPaquete()))
			{
				PaqueteDTO paqu=new PaqueteDTO(dto);								
				paquetesOfertados.add(paqu);				
			}
			else
			{
				productosOfertados.add(dto);
			}
		}
		
		PaqueteDTO[] paquetesContratados=(PaqueteDTO[]) ArrayUtl.copiaArregloTipoEspecifico(paquetesOfertados.toArray(), PaqueteDTO.class);
		ProductoOfertadoDTO[] productosOfertadosList=(ProductoOfertadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(productosOfertados.toArray(), ProductoOfertadoDTO.class);
		
		PaqueteListDTO paquList=new PaqueteListDTO();
		ProductoOfertadoListDTO prodOfList=new ProductoOfertadoListDTO();
		
		paquList.setPaqueteList(paquetesContratados);
		prodOfList.setProductoList(productosOfertadosList);
		
		abonado.setPaqueteList(paquList);
		abonado.setProdOfertList(prodOfList);	
		
		return abonado;
	}
	
//-----------------------------------------------------------------------
	/**
	 * Este método es responsable de agrupar por conceptos facturables una lista de cargos ocasionales.
	 * La agrupación de los cargos adicionales por concepto facturable es necesario para la presentación
	 * en facturas y pantalla.
	 * @param cargosOcasionales Lista de cargos ocasionales (CargoOcasionalDTO).
	 * @return CargoOcasionalListDTO con los cargos ocasionales agrupados por concepto facturable.
     */	
	public CargoOcasionalListDTO agruparCargosOcasionales(CargoOcasionalListDTO cargosOcasionales)
	{
		ArrayList arrayCargosOcasionalesToSend=new ArrayList();
		
		for(int i=0;i<cargosOcasionales.getCargoOcasional().length;i++)
		{
			CargoOcasionalDTO cargo=cargosOcasionales.getCargoOcasional()[i];
			int indiceExiste=-1;	
			indiceExiste=this.existeCargoAbonado(cargo.getNumAbonado(),cargo.getCodConcepto(),arrayCargosOcasionalesToSend);
			
			if(indiceExiste!=-1)
			{
				CargoOcasionalDTO cargoAux=(CargoOcasionalDTO)arrayCargosOcasionalesToSend.get(indiceExiste);
				float importeActual=cargoAux.getImpCargo()!=null?Float.parseFloat(cargoAux.getImpCargo()):0;
				float descuentoActual=cargoAux.getValDescuento()!=null?Float.parseFloat(cargoAux.getValDescuento()):0;		
				
				float importeAux=cargo.getImpCargo()!=null?Float.parseFloat(cargo.getImpCargo()):0;
				float descuentoAux=cargo.getValDescuento()!=null?Float.parseFloat(cargo.getValDescuento()):0;
				
				cargoAux.setImpCargo(String.valueOf(importeActual+importeAux));
				cargoAux.setValDescuento(String.valueOf(descuentoActual+descuentoAux));
				
				arrayCargosOcasionalesToSend.set(indiceExiste, cargoAux);					
			}
			else
			{
				arrayCargosOcasionalesToSend.add(cargo);
			}				
		}		
		CargoOcasionalDTO[] dtoArray=(CargoOcasionalDTO[]) ArrayUtl.copiaArregloTipoEspecifico(arrayCargosOcasionalesToSend.toArray(), CargoOcasionalDTO.class);
		cargosOcasionales.setCargoOcasional(dtoArray);		
		return cargosOcasionales;
	}
	
//---------------------------------------------------------------------------------------------------------------------
	
	private int existeCargoAbonado(String numAbonado,String codConcepto,ArrayList listaCargos)
	{
		int retorno=-1;		
		for(Iterator it=listaCargos.iterator();it.hasNext();)
		{
			CargoOcasionalDTO cargoOcasional=(CargoOcasionalDTO)it.next();
			if(numAbonado.equals(cargoOcasional.getNumAbonado()) && codConcepto.equals(cargoOcasional.getCodConcepto()))
			{
				retorno=listaCargos.indexOf(cargoOcasional);
				break;
			}
		}
		return retorno;
	}
	
//--------------------------------------------------------------------------------------------------------------------
	
	public OfertaComercialDTO mergeOfertasComerciales(OfertaComercialDTO ofertaCom1,OfertaComercialDTO ofertaCom2)	
	{
		logger.debug(CLASS_NAME+"mergeOfertasComerciales ini");
		OfertaComercialDTO ofertaComercialFinal=new OfertaComercialDTO();		
		
		if(ofertaCom1!=null || ofertaCom2!=null)
		{
			String numProceso=ofertaCom1!=null?ofertaCom1.getNumProceso():ofertaCom2.getNumProceso();
			String origenProceso=ofertaCom1!=null?ofertaCom1.getOrigenProceso():ofertaCom2.getOrigenProceso();
			String numEvento=ofertaCom1!=null?ofertaCom1.getNumEvento():ofertaCom2.getNumEvento();
			
			ArrayList paqueteListArray=new ArrayList();
			ArrayList productoListArray=new ArrayList();
			ArrayList cargoRecurrenteListArray=new ArrayList();
			ArrayList cargoOcasionalListArray=new ArrayList();
			ArrayList listaProductoTasConArray=new ArrayList();
			ArrayList listaPerfilProvArray=new ArrayList();
			
			logger.debug("paqueteList antes");
			PaqueteContratadoListDTO paqueteList=(ofertaCom1!=null && ofertaCom1.getPaqueteList()!=null)?
												  ofertaCom1.getPaqueteList():												  
												 (ofertaCom2!=null && ofertaCom2.getPaqueteList()!=null)?
												  ofertaCom2.getPaqueteList():new PaqueteContratadoListDTO();
			logger.debug("paqueteList despues");
			logger.debug("productoList antes");
			ProductoContratadoListDTO productoList=(ofertaCom1!=null && ofertaCom1.getProductoList()!=null)?
													ofertaCom1.getProductoList():												  
												   (ofertaCom2!=null && ofertaCom2.getProductoList()!=null)?
													ofertaCom2.getProductoList():new ProductoContratadoListDTO();
			logger.debug("productoList despues");		
			logger.debug("cargoRecurrenteList antes");
			CargoRecurrenteListDTO cargoRecurrenteList=(ofertaCom1!=null && ofertaCom1.getCargoRecurrenteList()!=null)?
														ofertaCom1.getCargoRecurrenteList():												  
													   (ofertaCom2!=null && ofertaCom2.getCargoRecurrenteList()!=null)?
														ofertaCom2.getCargoRecurrenteList():new CargoRecurrenteListDTO();	
			logger.debug("productoList despues");
			logger.debug("cargoOcasionalList antes");
			CargoOcasionalListDTO cargoOcasionalList=(ofertaCom1!=null && ofertaCom1.getCargoOcasionalList()!=null)?
													  ofertaCom1.getCargoOcasionalList():												  
													 (ofertaCom2!=null && ofertaCom2.getCargoOcasionalList()!=null)?
													  ofertaCom2.getCargoOcasionalList():new CargoOcasionalListDTO();
			logger.debug("productoList despues");
			logger.debug("listaProductoTasCon despues");
			ProductoTasacionContratadoListDTO listaProductoTasCon=(ofertaCom1!=null && ofertaCom1.getListaProductoTasCon()!=null)?
  														  		   ofertaCom1.getListaProductoTasCon():												  
																  (ofertaCom2!=null && ofertaCom2.getListaProductoTasCon()!=null)?
																   ofertaCom2.getListaProductoTasCon():new ProductoTasacionContratadoListDTO();
			logger.debug("productoList despues");
			logger.debug("listaPerfilProv antes");			
			PerfilProvisionamientoListDTO listaPerfilProv=(ofertaCom1!=null && ofertaCom1.getListaPerfilProv()!=null)?
										  		   		   ofertaCom1.getListaPerfilProv():												  
														  (ofertaCom2!=null && ofertaCom2.getListaPerfilProv()!=null)?
														   ofertaCom2.getListaPerfilProv():new PerfilProvisionamientoListDTO();
			logger.debug("productoList despues");						
			if(ofertaCom1!=null)
			{				
				logger.debug("ofertaCom1!=null");
				for(int i=0;i<ofertaCom1.getPaqueteList().getPaqueteContratadoList().length;i++)			
					paqueteListArray.add(ofertaCom1.getPaqueteList().getPaqueteContratadoList()[i]);			
				for(int i=0;i<ofertaCom1.getProductoList().getProductosContratadosDTO().length;i++)			
					productoListArray.add(ofertaCom1.getProductoList().getProductosContratadosDTO()[i]);
				for(int i=0;i<ofertaCom1.getCargoRecurrenteList().getCargoRecurrente().length;i++)
					cargoRecurrenteListArray.add(ofertaCom1.getCargoRecurrenteList().getCargoRecurrente()[i]);
				for(int i=0;i<ofertaCom1.getCargoOcasionalList().getCargoOcasional().length;i++)
					cargoOcasionalListArray.add(ofertaCom1.getCargoOcasionalList().getCargoOcasional()[i]);
				for(int i=0;i<ofertaCom1.getListaProductoTasCon().getProductosTasacionContratados().length;i++)
					listaProductoTasConArray.add(ofertaCom1.getListaProductoTasCon().getProductosTasacionContratados()[i]);
				for(int i=0;i<ofertaCom1.getListaPerfilProv().getPerfilesProvisionamientos().length;i++)
					listaPerfilProvArray.add(ofertaCom1.getListaPerfilProv().getPerfilesProvisionamientos()[i]);
			}
			if(ofertaCom2!=null)
			{
				logger.debug("ofertaCom2!=null");
				for(int i=0;i<ofertaCom2.getPaqueteList().getPaqueteContratadoList().length;i++)			
					paqueteListArray.add(ofertaCom2.getPaqueteList().getPaqueteContratadoList()[i]);			
				for(int i=0;i<ofertaCom2.getProductoList().getProductosContratadosDTO().length;i++)			
					productoListArray.add(ofertaCom2.getProductoList().getProductosContratadosDTO()[i]);
				for(int i=0;i<ofertaCom2.getCargoRecurrenteList().getCargoRecurrente().length;i++)
					cargoRecurrenteListArray.add(ofertaCom2.getCargoRecurrenteList().getCargoRecurrente()[i]);
				for(int i=0;i<ofertaCom2.getCargoOcasionalList().getCargoOcasional().length;i++)
					cargoOcasionalListArray.add(ofertaCom2.getCargoOcasionalList().getCargoOcasional()[i]);
				for(int i=0;i<ofertaCom2.getListaProductoTasCon().getProductosTasacionContratados().length;i++)
					listaProductoTasConArray.add(ofertaCom2.getListaProductoTasCon().getProductosTasacionContratados()[i]);
				for(int i=0;i<ofertaCom2.getListaPerfilProv().getPerfilesProvisionamientos().length;i++)
					listaPerfilProvArray.add(ofertaCom2.getListaPerfilProv().getPerfilesProvisionamientos()[i]);
			}	
			logger.debug("seteo listas");
			PaqueteContratadoDTO[] paquetesContratados=(PaqueteContratadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(paqueteListArray.toArray(), PaqueteContratadoDTO.class);
			ProductoContratadoDTO[] prodContratados=(ProductoContratadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(productoListArray.toArray(), ProductoContratadoDTO.class);		
			CargoRecurrenteDTO[] cargosRecurrentes=(CargoRecurrenteDTO[]) ArrayUtl.copiaArregloTipoEspecifico(cargoRecurrenteListArray.toArray(), CargoRecurrenteDTO.class);
			CargoOcasionalDTO[] cargosOcasionales=(CargoOcasionalDTO[]) ArrayUtl.copiaArregloTipoEspecifico(cargoOcasionalListArray.toArray(), CargoOcasionalDTO.class);
			ProductoTasacionContratadoDTO[] productoTasacionContratados=(ProductoTasacionContratadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(listaProductoTasConArray.toArray(), ProductoTasacionContratadoDTO.class);
			PerfilProvisionamientoDTO[] perfilesProvisionamiento=(PerfilProvisionamientoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(listaPerfilProvArray.toArray(), PerfilProvisionamientoDTO.class);
						
			paqueteList.setPaqueteContratadoList(paquetesContratados);
			productoList.setProductosContratadosDTO(prodContratados);
			cargoRecurrenteList.setCargoRecurrente(cargosRecurrentes);
			cargoOcasionalList.setCargoOcasional(cargosOcasionales);
			listaProductoTasCon.setProductosTasacionContratados(productoTasacionContratados);
			listaPerfilProv.setPerfilesProvisionamientos(perfilesProvisionamiento);
			
			ofertaComercialFinal.setNumEvento(numEvento);
			ofertaComercialFinal.setNumProceso(numProceso);
			ofertaComercialFinal.setOrigenProceso(origenProceso);
			ofertaComercialFinal.setPaqueteList(paqueteList);
			ofertaComercialFinal.setProductoList(productoList);
			ofertaComercialFinal.setCargoRecurrenteList(cargoRecurrenteList);
			ofertaComercialFinal.setCargoOcasionalList(cargoOcasionalList);
			ofertaComercialFinal.setListaProductoTasCon(listaProductoTasCon);
			ofertaComercialFinal.setListaPerfilProv(listaPerfilProv);		
		}
		logger.debug(CLASS_NAME+"mergeOfertasComerciales fin");
		return ofertaComercialFinal;
	}

//	--------------------------------------------------------------------------------------------------------------------
	
	public ProductoContratadoListDTO mergeProductoContratadoList(ProductoContratadoListDTO listaProd1,ProductoContratadoListDTO listaProd2)
	{
		logger.debug(CLASS_NAME+"mergeProductoContratadoList begin");
		ProductoContratadoListDTO productosContratadosFinal=new ProductoContratadoListDTO();
		if(listaProd1!=null || listaProd2!=null)
		{
			logger.debug(CLASS_NAME+"listas != null");
			productosContratadosFinal.setNumEvento(listaProd1!=null?listaProd1.getNumEvento():listaProd2.getNumEvento());
			ArrayList productosFinalArray=new ArrayList();		
			if(listaProd1!=null && listaProd1.getProductosContratadosDTO()!=null && listaProd1.getProductosContratadosDTO().length>0)
			{
				for(int i=0;i<listaProd1.getProductosContratadosDTO().length;i++)
					productosFinalArray.add(listaProd1.getProductosContratadosDTO()[i]);
			}
			if(listaProd2!=null && listaProd2.getProductosContratadosDTO()!=null && listaProd2.getProductosContratadosDTO().length>0)
			{
				for(int i=0;i<listaProd2.getProductosContratadosDTO().length;i++)
					productosFinalArray.add(listaProd2.getProductosContratadosDTO()[i]);
			}
			ProductoContratadoDTO[] prodContratados=(ProductoContratadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(productosFinalArray.toArray(), ProductoContratadoDTO.class);
			productosContratadosFinal.setProductosContratadosDTO(prodContratados);	
		}
		else
		{
			logger.debug(CLASS_NAME+"mergeProductoContratadoList listaProd1=null y listaProd2=null");
		}
		logger.debug(CLASS_NAME+"mergeProductoContratadoList end");
		return productosContratadosFinal;
	}
	
// -----------------------------------------------------------------------------------------------------------------------------------------
	
	public AbonadoBeneficiarioListDTO mergeAbonadoBeneficiarioListDTO(AbonadoBeneficiarioListDTO lista1,AbonadoBeneficiarioListDTO lista2)
	{
		logger.debug(CLASS_NAME+"mergeAbonadoBeneficiarioListDTO begin");
		AbonadoBeneficiarioListDTO abonadosBeneficiariosFinal=new AbonadoBeneficiarioListDTO();
		if(lista1!=null || lista2!=null)
		{			
			logger.debug(CLASS_NAME+"listas != null");
			ArrayList productosFinalArray=new ArrayList();		
			if(lista1!=null && lista1.getAbonadoBeneficiarioList()!=null && lista1.getAbonadoBeneficiarioList().length>0)
			{
				for(int i=0;i<lista1.getAbonadoBeneficiarioList().length;i++)
					productosFinalArray.add(lista1.getAbonadoBeneficiarioList()[i]);
			}
			if(lista2!=null && lista2.getAbonadoBeneficiarioList()!=null && lista2.getAbonadoBeneficiarioList().length>0)
			{
				for(int i=0;i<lista2.getAbonadoBeneficiarioList().length;i++)
					productosFinalArray.add(lista2.getAbonadoBeneficiarioList()[i]);
			}
			AbonadoBeneficiarioDTO[] abonBefici=(AbonadoBeneficiarioDTO[]) ArrayUtl.copiaArregloTipoEspecifico(productosFinalArray.toArray(), AbonadoBeneficiarioDTO.class);
			abonadosBeneficiariosFinal.setAbonadoBeneficiarioList(abonBefici);	
		}
		else
		{
			logger.debug(CLASS_NAME+"mergeAbonadoBeneficiarioListDTO lista1=null y lista2=null");
		}
		logger.debug(CLASS_NAME+"mergeAbonadoBeneficiarioListDTO end");
		return abonadosBeneficiariosFinal;
	}
//-------------------------------------------------------------------------------------------------------------------------------------------
	
	public ContenedorPlanesAdicionalesDTO mergeContenedorPlanesAdicionales(ContenedorPlanesAdicionalesDTO cont1,ContenedorPlanesAdicionalesDTO cont2)
	{
		logger.debug(CLASS_NAME+"mergeContenedorPlanesAdicionales ini");
		ContenedorPlanesAdicionalesDTO contenedorFinal=new ContenedorPlanesAdicionalesDTO();
		
		logger.debug(CLASS_NAME+"mergeOfertasComerciales antes");
		OfertaComercialDTO ofertaFinal=this.mergeOfertasComerciales(cont1.getOfComercialContratar(), cont2.getOfComercialContratar());
		logger.debug(CLASS_NAME+"mergeOfertasComerciales despues");
		logger.debug(CLASS_NAME+"mergeProductoContratadoList antes");
		ProductoContratadoListDTO productosContFinal=this.mergeProductoContratadoList(cont1.getListaProductosDescontratar(), cont2.getListaProductosDescontratar());
		logger.debug(CLASS_NAME+"mergeProductoContratadoList despues");
		logger.debug(CLASS_NAME+"mergeAbonadoBeneficiarioListDTO antes");
		AbonadoBeneficiarioListDTO abonBenefiFinal=this.mergeAbonadoBeneficiarioListDTO(cont1.getAbonadosADesbenificiar(), cont2.getAbonadosADesbenificiar());
		logger.debug(CLASS_NAME+"mergeAbonadoBeneficiarioListDTO despues");
		
		contenedorFinal.setAbonadosADesbenificiar(abonBenefiFinal);
		contenedorFinal.setListaProductosDescontratar(productosContFinal);
		contenedorFinal.setOfComercialContratar(ofertaFinal);		
		logger.debug(CLASS_NAME+"mergeContenedorPlanesAdicionales fin");
		return contenedorFinal;
	}
//------------------------------------------------------------------------------------------------------------------------------------------------
	
	/**
	 * Este método es responsable de capturar el LimiteConsumoDTO seleccionado.
	 * @param ProductoOfertadoDTO
	 * 		  
	 * @return LimiteConsumoDTO
	 * 
	 *
	 * */	
	private LimiteConsumoPlanAdicionalDTO ObtenerLimiteConsumoSeleccionado(ProductoOfertadoDTO producto)
	{
		LimiteConsumoPlanAdicionalDTO temporal = new LimiteConsumoPlanAdicionalDTO();
		String codLimSeleccionado = producto.getLimiteConsumoSeleccionado();
		logger.debug("codLimSeleccionado 18:48["+codLimSeleccionado+"]");
		if (codLimSeleccionado != null && !"".equals(codLimSeleccionado))
		{

			for(int i = 0 ; i < producto.getListaLimCons().getLimitesDeConsumo().length ; i++)
			{
				if(producto.getListaLimCons().getLimitesDeConsumo()[i].getCodLimCons().equals(codLimSeleccionado))
				{
					temporal = producto.getListaLimCons().getLimitesDeConsumo()[i];
					temporal.setMtoConsumoConfigurado(producto.getMtoConsumoConfigurado());//mix9003 101209 pv
					break;
				}
			}
		}	
		return temporal;
	}

}
