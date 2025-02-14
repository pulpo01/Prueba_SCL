/**
 * Copyright © 2007 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 04/04/2007     Héctor Hermosilla      					Versión Inicial
 */

package com.tmmas.cl.scl.frameworkcargos.motorv1;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.ListIterator;
import java.util.Map;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.Formatting;
import com.tmmas.cl.scl.commonbusinessentities.interfaz.IdentificadorProceso;
import com.tmmas.cl.scl.commonbusinessentities.interfaz.TipoDescuentos;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.AtributosCargoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.AtributosMigracionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.BitacoraDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CargosDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ConversionMonetariaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.DescuentoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ImpuestosDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosEjecucionFacturacionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosMotorCargosDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.PrebillingDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.PrecioDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ProcesoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.ProductDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.Cliente;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.DatosGenerales;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.Factura;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.RegistroCargos;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.RegistroFacturacion;
import com.tmmas.cl.scl.customerdomain.businessobject.bo.RegistroVenta;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.AlPetiGuiasAboDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.ClienteDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.CobroAdelantadoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.DatosGeneralesDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.ProrrateoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.RegistroCargosDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.RegistroFacturacionDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.RegistroVentaDTO;
import com.tmmas.cl.scl.frameworkcargos.base.ReglaListaPrecio;
import com.tmmas.cl.scl.frameworkcargos.base.TareasRegistroCargos;
import com.tmmas.cl.scl.frameworkcargos.exception.FrameworkCargosException;
import com.tmmas.cl.scl.frameworkcargos.interfaces.ProcesadorCargosInterfaz;

public class ProcesadorCargos implements ProcesadorCargosInterfaz{
	private static Category cat = Category.getInstance(ProcesadorCargos.class);
	
	private PrecioDTO[] precioRegla;
	private DescuentoDTO[] descuentoRegla;
	private CargosDTO[] cargosDTO=null;
	private Map cargos;
	
	private List cargosLista = new ArrayList();
	private AtributosCargoDTO atributosRegla;
	private ParametrosMotorCargosDTO configuracion;
	private ImpuestosDTO impuestos;
	private boolean preBillingRunning;
	private BitacoraDTO bitacora;
	
	public ProcesadorCargos (){			
	}
	
	public ProcesadorCargos (ParametrosMotorCargosDTO configuracion,
			CargosDTO[] cargos){
		this.preBillingRunning = false;
		this.configuracion = configuracion; 
		cargosDTO = cargos;
		bitacora=null;
	}
	/**
	 *Calcula los cargos.
	 * @param 
	 * @return 
	 * @throws FrameworkCargosException
	 */
	
	public void calcularCargos(ReglaListaPrecio[] reglasNegocio) 
		throws FrameworkCargosException,ProductDomainException 
	{
		cat.debug("Inicio:calcularCargos()");		
		int iIndice;
		for(iIndice=0;iIndice<reglasNegocio.length;iIndice++){
			if (reglasNegocio[iIndice].validacion())
			{
				precioRegla = null;
				precioRegla = reglasNegocio[iIndice].seleccionPrecios();
				if (precioRegla!=null){
					if (precioRegla.length > 0){
						cat.debug("precioRegla.length: " + precioRegla.length);
						descuentoRegla = reglasNegocio[iIndice].seleccionDescuentos();
						if (descuentoRegla != null){
							//if (descuentoRegla.length > 0)
								//listaDescuentosRegla.addAll(Arrays.asList(descuentoRegla));
						}
						
						atributosRegla = new AtributosMigracionDTO();
						atributosRegla = reglasNegocio[iIndice].getAtributos().getAtributos();
						
						//agruparCargos();
					}
					//Se agrega cargo a lista de cargos
					for(int i=0;i<precioRegla.length;i++){
						CargosDTO cargo = new CargosDTO();
						cargo.setAtributo(atributosRegla);
						cargo.setPrecio(precioRegla[i]);
						cargo.setCantidad(1);						
						if (descuentoRegla != null)
							cargo.setDescuento(descuentoRegla);
						cargosLista.add(cargo);
					}
				}
			}
		}
		cat.debug("Fin:calcularCargos()");
	}
	
	/**
	 *Obtiene los cargos.
	 * @param 
	 * @return 
	 * @throws FrameworkCargosException
	 */

	public CargosDTO[] obtenerCargos() throws FrameworkCargosException{
		cat.debug("Inicio:obtenerCargos()");
		CargosDTO[] arregloCargos=null;
		if (cargos != null){
			List listaCargos = new ArrayList(cargos.values());
			arregloCargos =(CargosDTO[])ArrayUtl.copiaArregloTipoEspecifico(listaCargos.toArray(), 
				CargosDTO.class);
		}else{
			arregloCargos =(CargosDTO[])ArrayUtl.copiaArregloTipoEspecifico(cargosLista.toArray(), 
					CargosDTO.class);
		}
		cat.debug("Fin:obtenerCargos()");
		return arregloCargos;
		
	}
	
	/**
	 *Agrupa los cargos
	 * @param 
	 * @return 
	 * @throws FrameworkCargosException
	 */
	public void agruparCargos() throws FrameworkCargosException{
		cat.debug("Inicio:agruparCargos()");
		ListIterator iter = cargosLista.listIterator();
		cargos = new HashMap();
		while (iter.hasNext()){
			CargosDTO cargo = new CargosDTO();
			CargosDTO cargosDTO = new CargosDTO();
			cargosDTO =(CargosDTO) iter.next();
			String codigoConcepto = String.valueOf(cargosDTO.getPrecio().getCodigoConcepto());
			if (cargos.get(codigoConcepto)!=null){
				cargo=(CargosDTO)cargos.get(codigoConcepto);
				if (cargo.getAtributo().getCodigoArticuloServicio()!=null){
					if (cargo.getAtributo().getCodigoArticuloServicio().equals(cargosDTO.getAtributo().getCodigoArticuloServicio())){
						cargo.setCantidad(cargo.getCantidad()+1);
						cargos.remove(codigoConcepto);
					}
				}
				else{
					if (atributosRegla.getCodigoArticuloServicio()==null){
						cargo.setCantidad(cargo.getCantidad()+1);
						cargos.remove(codigoConcepto);
					}
				}
			}
			else{
				cargo.setCantidad(1);
			}
			cargo.setPrecio(cargosDTO.getPrecio());
			cargo.setAtributo(cargosDTO.getAtributo());
			cargo.setDescuento(cargosDTO.getDescuento());
			cargo.setNum_abonado(cargosDTO.getNum_abonado());
			cargos.put(String.valueOf(cargo.getPrecio().getCodigoConcepto()),cargo);
		}
		cat.debug("Fin:agruparCargos()");
	
	}
	
	/**
	 *Registra los cargos asociados a la venta
	 * @param TareasRegistroCargos[] tareas
	 * @return 
	 * @throws GeneralException 
	 */
	public void registrarCargos(TareasRegistroCargos[] tareas) throws GeneralException{
		cat.debug("Inicio:registrarCargos()");
		try{
			cat.debug("Ingreso a registrar Cargos");
			RegistroCargos registroCargosBO = new RegistroCargos();
			Factura facturaBO = new Factura();
			boolean bExistDctoAut = false;
			float ifValorDescuento = 0;
			RegistroVenta registroVentaBO = new RegistroVenta();
			RegistroFacturacion registroFacturacionBO  = new RegistroFacturacion();
			
			Cliente clienteBO = new Cliente();
			RegistroFacturacionDTO registrofact = new RegistroFacturacionDTO();
			ClienteDTO cliente = new ClienteDTO();
			cliente.setCodigoCliente(configuracion.getCodigoCliente());
			cliente = clienteBO.getCliente(cliente); 
			registrofact = registroFacturacionBO.getCodigoCicloFacturacion(cliente);
			int contPetiguias = 1;
			
			Date fecha = new Date();			
			String fechaActual;
			fechaActual = Formatting.dateTime(fecha,"yyyyMMdd HHmmss");
			
						
			for (int i=0;i<cargosDTO.length;i++)
			{
				RegistroCargosDTO registroCargos = new RegistroCargosDTO();
				//Obtiene Secuencia del Cargo
				registroCargos.setCodigoSecuencia(configuracion.getCodigoSecuenciaCargo());
				registroCargos = registroCargosBO.getSecuenciaCargo(registroCargos);			
				registroCargos.setCodigoCliente(configuracion.getCodigoCliente());
				//Si factura a ciclo se asigna valor 0 al numero de venta en caso contrario se pasa el numero de
				//la venta.
				if (configuracion.isFacturacionaCiclo())
					registroCargos.setNumeroVenta(0);
				else
					registroCargos.setNumeroVenta(Long.parseLong(configuracion.getNumeroProceso()));
				
				registroCargos.setCodigoProducto(Integer.parseInt(configuracion.getCodigoProducto()));
				registroCargos.setCodigoConceptoPrecio(cargosDTO[i].getPrecio().getCodigoConcepto());
				registroCargos.setImporteCargo(new Double(cargosDTO[i].getPrecio().getMonto()).floatValue());
				registroCargos.setCodigoMoneda(cargosDTO[i].getPrecio().getUnidad().getCodigo());
				registroCargos.setCodigoPlanComercial(configuracion.getCodigoPlanComercialCliente());
				registroCargos.setNumeroUnidades(cargosDTO[i].getCantidad());
				registroCargos.setCodigoCicloFacturacion(registrofact.getCodigoCicloFacturacion());
				registroCargos.setNumeroTransaccion(Long.parseLong(configuracion.getNumeroTransaccion()));
				registroCargos.setTipoFoliacion(configuracion.getTipoFoliacionDocumento());
				registroCargos.setCodigoDocumento(configuracion.getCodigoTipoDocumento());				
				//El descuento se guarda como tipo importe y el código concepto facturable
				//es del descuento automatico, si no existe descuento automatico se toma el código del descuento
				//manual.
				registroCargos.setTipoDescuento(String.valueOf(TipoDescuentos.Importe));
				float ifValorDescPorManual = 0;
				if (cargosDTO[i].getDescuento()!=null)
					if (cargosDTO[i].getDescuento().length>0){
						for (int k=0; k<cargosDTO[i].getDescuento().length;k++)
						{	
							//Se debe aplicar conversion monetaria en caso que la moneda no sea la local (definida en un parametro)
							if(cargosDTO[i].getDescuento()[k].getCodMoneda() != null && !cargosDTO[i].getDescuento()[k].getCodMoneda().trim().equals("")
									&& !configuracion.getCodMonedaLocal().trim().equals(cargosDTO[i].getDescuento()[k].getCodMoneda().trim()))
							{								
								ConversionMonetariaDTO conversion = new ConversionMonetariaDTO();
								conversion.setCodCliente(Long.valueOf(configuracion.getCodigoCliente()).longValue());
								conversion.setTotalCargosOrigen(cargosDTO[i].getDescuento()[k].getMonto());					
								conversion.setFechaOrigen(fechaActual);
								
								Float montoConvertido = registroCargosBO.convertirMontoMonedaLocal(conversion);
								cargosDTO[i].getDescuento()[k].setCodMoneda(configuracion.getCodMonedaLocal().trim());
								cargosDTO[i].getDescuento()[k].setMonto(montoConvertido.floatValue());
							}
							
							if (cargosDTO[i].getDescuento()[k].getTipo().equals(String.valueOf(TipoDescuentos.Automatico)) 
								&& cargosDTO[i].getDescuento()[k].getMonto() > 0){
								registroCargos.setCodigoConceptoDescuento(cargosDTO[i].getDescuento()[k].getCodigoConcepto());
								bExistDctoAut = true;								
							}else if(cargosDTO[i].getDescuento()[k].getTipo().equals(String.valueOf(TipoDescuentos.Manual)) 
									&& !bExistDctoAut){
								registroCargos.setCodigoConceptoDescuento(cargosDTO[i].getDescuento()[k].getCodigoConcepto());
							}
							
							cat.debug("Ingreso a registrar Cargos 5 cargosDTO[i].getDescuento()[k] : " +cargosDTO[i].getDescuento()[k]);
							cat.debug("Ingreso a registrar Cargos 5 cargosDTO[i].getDescuento()[k].getTipoAplicacion() : " + cargosDTO[i].getDescuento()[k].getTipoAplicacion());
							cat.debug("Ingreso a registrar Cargos 5 cargosDTO[i].getDescuento()[k].getMonto() : " + cargosDTO[i].getDescuento()[k].getMonto());
							cat.debug("Ingreso a registrar Cargos 5 cargosDTO[i].getDescuento()[k].getTipo() : " + cargosDTO[i].getDescuento()[k].getTipo());				
							
							if(cargosDTO[i].getDescuento()[k] != null && cargosDTO[i].getDescuento()[k].getTipoAplicacion() != null 
								&& cargosDTO[i].getDescuento()[k].getTipoAplicacion().equals(String.valueOf(TipoDescuentos.Porcentaje)) 
								&& cargosDTO[i].getDescuento()[k].getMonto() > 0
								&& cargosDTO[i].getDescuento()[k].getTipo().equals(String.valueOf(TipoDescuentos.Automatico)))
							{
								cat.debug("Ingreso a registrar Cargos 5.1");
								if(cargosDTO[i].getDescuento()[k].getMonto() <= 100 && cargosDTO[i].getDescuento()[k].getMonto() > 0)
								{								
									registroCargos.setValorDescuento(cargosDTO[i].getDescuento()[k].getMonto());
									ifValorDescuento =((cargosDTO[i].getDescuento()[k].getMonto()*registroCargos.getImporteCargo()) / 100) ;
									Double  dValorDescAux = new Double((ifValorDescuento*Math.pow(10,configuracion.getNumeroDecimalesPorDesc()))/Math.pow(10,configuracion.getNumeroDecimalesPorDesc()));
									ifValorDescuento =  dValorDescAux.floatValue();									
									registroCargos.setValorDescuento(ifValorDescuento);
									registroCargos.setTipoDescuento(String.valueOf(TipoDescuentos.Importe));
									//registroCargos.setTipoDescuento(cargosDTO[i].getDescuento()[k].getTipoAplicacion());
								}
							}else if(cargosDTO[i].getDescuento()[k] != null &&  cargosDTO[i].getDescuento()[k].getTipoAplicacion() != null 
									&& cargosDTO[i].getDescuento()[k].getTipoAplicacion().equals(String.valueOf(TipoDescuentos.Porcentaje)) 
									&& cargosDTO[i].getDescuento()[k].getMonto() > 0
									&& cargosDTO[i].getDescuento()[k].getTipo().equals(String.valueOf(TipoDescuentos.Manual)))
							{
								cat.debug("Ingreso a registrar Cargos 5.2");
								ifValorDescPorManual = cargosDTO[i].getDescuento()[k].getMonto();
								registroCargos.setTipoDescuento(cargosDTO[i].getDescuento()[k].getTipoAplicacion());
							}else  if (cargosDTO[i].getDescuento()[k] != null && cargosDTO[i].getDescuento()[k].getTipoAplicacion() != null
									&& !cargosDTO[i].getDescuento()[k].getTipoAplicacion().equals(String.valueOf(TipoDescuentos.Porcentaje))
									&& cargosDTO[i].getDescuento()[k].getMonto() > 0)
							{
								cat.debug("Ingreso a registrar Cargos 5.3 cargosDTO[i].getDescuento()[k].getCodigoConcepto() : " + cargosDTO[i].getDescuento()[k].getCodigoConcepto());
								if(registroCargos.getImporteCargo() >= (registroCargos.getValorDescuento() + cargosDTO[i].getDescuento()[k].getMonto()))
								{	
									//Para guatemala - El Salvador se dejan los descuentos en monto para el calculo del impuesto
									registroCargos.setValorDescuento(cargosDTO[i].getDescuento()[k].getMonto());									
									registroCargos.setTipoDescuento(String.valueOf(TipoDescuentos.Importe));									
									registroCargos.setCodigoConceptoDescuento(cargosDTO[i].getDescuento()[k].getCodigoConcepto());									
								}
							}		
						}
					}
				if (ifValorDescPorManual >0)
				{					
					ifValorDescuento =(((registroCargos.getImporteCargo() * registroCargos.getNumeroUnidades()) - registroCargos.getValorDescuento()) * ifValorDescPorManual) /100;
					Double  dValorDescAux = new Double((ifValorDescuento*Math.pow(10,configuracion.getNumeroDecimalesPorDesc()))/Math.pow(10,configuracion.getNumeroDecimalesPorDesc()));
					ifValorDescuento =  dValorDescAux.floatValue();
					registroCargos.setValorDescuento(registroCargos.getValorDescuento() + ifValorDescuento);
				}
				
				if(registroCargos.getValorDescuento() == 0)
				{
					registroCargos.setCodigoConceptoDescuento(null);					
				}
					
				registroCargos.setNum_serie(cargosDTO[i].getPrecio().getNroSerie());
				registroCargos.setCodBodega(cargosDTO[i].getPrecio().getCodBodega());

				AtributosMigracionDTO atributo = (AtributosMigracionDTO)cargosDTO[i].getAtributo();
				if (Integer.parseInt(atributo.getInd_paquete()) != 0 || Integer.parseInt(atributo.getInd_equipo()) != 0)
					registroCargos.setIndiceCuota(atributo.getInd_cuota());
				
				if (Integer.parseInt(atributo.getInd_paquete()) != 2)
					registroCargos.setIndiceFacturacion(1);
				else
					registroCargos.setIndiceFacturacion(0);
				
				
				if (Integer.parseInt(atributo.getInd_paquete()) == 1 || Integer.parseInt(atributo.getInd_paquete()) == 2){
					RegistroVentaDTO registroVenta = new RegistroVentaDTO();
					registroVenta.setCodigoSecuencia(configuracion.getCodigoSecuenciaPaquete());
					registroVenta = registroVentaBO.getSecuenciaPaquete(registroVenta);
					registroCargos.setNumeroPaquete(registroVenta.getNumeroPaquete());
				}
				
				registroCargos.setIndiceCuota(atributo.getInd_cuota());
				registroCargos.setIndiceSuperTelefono(0);
				registroCargos.setNombreUsuario(configuracion.getUsuario());
				registroCargos.setCodigoTecnologia(atributo.getCod_tecnologia());
				
				registroCargos.setNum_abonado(cargosDTO[i].getNum_abonado());
				registroCargos.setNum_terminal(cargosDTO[i].getNum_terminal());
				
				
				//Antes de registrar el cargo se calcula el prorrateo en caso que corresponda a un cobro adelantado
				if(cargosDTO[i].getAtributo().getEsCobroAdelantado()==0)
				{
					cat.debug("No es cobro adelantado");				
				}else{
					cat.debug("Si es cobro adelantado");
					//Prorrateo					
					ProrrateoDTO prorrateo = new ProrrateoDTO();
					prorrateo.setNumAbonado(registroCargos.getNum_abonado().longValue());
					prorrateo.setImporte(registroCargos.getImporteCargo());
					prorrateo = facturaBO.getProrrateo(prorrateo);
					registroCargos.setImporteCargo(new Float(prorrateo.getImporte()).floatValue());
					
					//Inserta cobro adelantado
					CobroAdelantadoDTO cobroAdelantado = new CobroAdelantadoDTO();
					cobroAdelantado.setNumAbonado(registroCargos.getNum_abonado().longValue());					
					cobroAdelantado.setCodCliente(Long.valueOf(registroCargos.getCodigoCliente()).longValue());
					cobroAdelantado.setCodCicloFacturacion(registroCargos.getCodigoCicloFacturacion());
					cobroAdelantado.setCodConcepto(Long.valueOf(registroCargos.getCodigoConceptoPrecio()).longValue());					
					cobroAdelantado.setNumVenta(registroCargos.getNumeroVenta());
					cobroAdelantado.setUsuario(configuracion.getUsuario());
					cobroAdelantado.setTipoServicioCobroAdelantado(atributo.getTipoServicioCobroAdelantado());
					cat.debug("configuracion.getUsuario()="+configuracion.getUsuario());
					facturaBO.insertaCobroAdelantado(cobroAdelantado);		
					
					
					//Se deja en 8 ya que si es necesario hacer una reversa porder deterninar cuales son los cargos a reversar
					registroCargos.setIndiceFacturacion(8);
				}
				
				//Se debe aplicar conversion monetaria en caso que la moneda no sea la local (definida en un parametro)
				if(!configuracion.getCodMonedaLocal().trim().equals(registroCargos.getCodigoMoneda().trim()))
				{
					
					ConversionMonetariaDTO conversion = new ConversionMonetariaDTO();
					conversion.setCodCliente(Long.valueOf(configuracion.getCodigoCliente()).longValue());
					conversion.setTotalCargosOrigen(registroCargos.getImporteCargo());					
					conversion.setFechaOrigen(fechaActual);
					
					Float montoConvertido = registroCargosBO.convertirMontoMonedaLocal(conversion);
					registroCargos.setCodigoMoneda(configuracion.getCodMonedaLocal().trim());
					registroCargos.setImporteCargo(montoConvertido.floatValue());
				}
				
				registroCargosBO.registraCargo(registroCargos);
				
				
				//Parametros para Inserción en la Al_PetiGuias_Abo
				AlPetiGuiasAboDTO alPetiGuiasAboDTO=new AlPetiGuiasAboDTO();
				String codArticulo=cargosDTO[i].getAtributo().getCodigoArticuloServicio();
				codArticulo=codArticulo==null?"0":codArticulo.trim();
				String codBodega=cargosDTO[i].getPrecio().getCodBodega();		
				codBodega=codBodega==null?"0":codBodega.trim();
				
				if( registroCargos.getNum_serie() != null && !registroCargos.getNum_serie().trim().equals("")) 
				{
					alPetiGuiasAboDTO.setCod_articulo(new Long (codArticulo));
					alPetiGuiasAboDTO.setCod_cliente(new Long(registroCargos.getCodigoCliente()));
					alPetiGuiasAboDTO.setCod_oficina(configuracion.getCodigoOficina());
					alPetiGuiasAboDTO.setNum_abonado(cargosDTO[i].getNum_abonado());
					alPetiGuiasAboDTO.setNum_serie(cargosDTO[i].getPrecio().getNroSerie());
					alPetiGuiasAboDTO.setNum_venta(new Long (registroCargos.getNumeroVenta()));
					alPetiGuiasAboDTO.setCod_bodega(new Long (codBodega));
					alPetiGuiasAboDTO.setCod_concepto(new Long(registroCargos.getCodigoConceptoPrecio()));
					alPetiGuiasAboDTO.setCod_moneda(registroCargos.getCodigoMoneda());
					alPetiGuiasAboDTO.setNum_cantidad(new Long(cargosDTO[i].getCantidad()));
					alPetiGuiasAboDTO.setNum_cargo(new Long(registroCargos.getNumeroCargo()));				
					alPetiGuiasAboDTO.setNum_orden(new Long(contPetiguias));
					alPetiGuiasAboDTO.setNum_peticion(configuracion.getNumeroPeticion());
					alPetiGuiasAboDTO.setNum_telefono(registroCargos.getNum_terminal());
					alPetiGuiasAboDTO.setVal_linea(new Double(registroCargos.getImporteCargo()));					
					alPetiGuiasAboDTO=registroVentaBO.insetAlPetiGuiasAbo(alPetiGuiasAboDTO);
					contPetiguias++;
				}				
			}
			
			//Ejecuta las tareas
						
			if(cargosDTO!=null && cargosDTO.length>0)
			{
				if (tareas!=null){
					int iNumeroTareas = tareas.length;
					for (int i =0;i<iNumeroTareas;i++){
						if(tareas[i].validaciones()){
						 if (tareas[i].esPrebilling()){
							 //En Guatemala - El Salvador el prebilling no se ejecuta inmediatamente
							 //ejecutaPrebilling(tareas[i]); 
						 }
							 
						// else
							// tareas[i].tarea();
						}
					}
				}
			}
			
			
		}catch(CustomerDomainException ex){
			throw new FrameworkCargosException(ex.getCodigo(), ex.getCodigoEvento(), ex.getDescripcionEvento());			
		}catch (GeneralException e) {
			cat.debug("GeneralException");
			cat.debug("e.getCodigo() ["+e.getCodigo()+"]");
			cat.debug("e.getDescripcionEvento() ["+e.getDescripcionEvento()+"]");
			cat.debug("e.getCodigoEvento() ["+e.getCodigoEvento()+"]");
			throw e;			
		}
		cat.debug("Fin:registrarCargos()");
	}
	
	public void ejecutarFacturacion(ParametrosEjecucionFacturacionDTO parametrosEjecucion) throws FrameworkCargosException{
		// TODO Auto-generated method stub
		try{
			cat.debug("ejecutarFacturacion ProcesadorCargos");
			RegistroFacturacion registroFacturacionBO  = new RegistroFacturacion();
			RegistroFacturacionDTO regFac = new RegistroFacturacionDTO();
			regFac.setNumeroProcesoFacturacion(parametrosEjecucion.getNumeroProcesoFacturacion());
			regFac.setNumeroVenta(parametrosEjecucion.getNumeroVenta());
			regFac.setEstadoDocumento(parametrosEjecucion.getEstadoDocumento());
			regFac.setEstadoProceso(parametrosEjecucion.getEstadoProceso());
			regFac.setTipoFoliacion(parametrosEjecucion.getTipoFoliacion());
			
			Date fecha = new Date();
			Calendar cal = new GregorianCalendar();
			cal.setTimeInMillis(fecha.getTime());
			cal.add(Calendar.DATE, parametrosEjecucion.getNroDiasVencimiento().intValue());
			Date fechaVencimiento = new Date(cal.getTimeInMillis());
			String fechaVencimientoFormateada = Formatting.dateTime(fechaVencimiento, "dd/MM/yyyy HH:mm:ss");
			
		    regFac.setFechaVencimiento(fechaVencimientoFormateada);
			cat.debug("ejecutarFacturacion ProcesadorCargos parametrosEjecucion.getNumeroProcesoFacturacion() : " +
					parametrosEjecucion.getNumeroProcesoFacturacion());
			cat.debug("ejecutarFacturacion ProcesadorCargos parametrosEjecucion.getNumeroVenta() : " +
					parametrosEjecucion.getNumeroVenta());
			cat.debug("ejecutarFacturacion ProcesadorCargos parametrosEjecucion.getEstadoDocumento(): " + 
					parametrosEjecucion.getEstadoDocumento());
			cat.debug("ejecutarFacturacion ProcesadorCargos parametrosEjecucion.getEstadoProceso(): " + 
					parametrosEjecucion.getEstadoProceso());
			cat.debug("ejecutarFacturacion ProcesadorCargos parametrosEjecucion.getTipoFoliacion(): " + 
					parametrosEjecucion.getTipoFoliacion());
			
			ProcesoDTO proceso = registroFacturacionBO.actualizaFacturacion(regFac);
			if (proceso !=null)
				componerBitacora(proceso);
			
				
		}catch(CustomerDomainException ex){
				throw new FrameworkCargosException(ex);
		}
		
	}

	public void cancelarFacturacion() throws FrameworkCargosException{
		// TODO Auto-generated method stub
		
	}
	public void ejecutaPrebilling(TareasRegistroCargos tarea) throws GeneralException{		
		cat.debug("Inicio:ejecutaPrebilling()");
		String sValorDocumentoGuia;
		String sValorFacturaGlobal;
		String sValorFlagCentroFact;
		RegistroFacturacion registroFacturacionBO  = new RegistroFacturacion();
	
		
		PrebillingDTO prebillingDTO = new PrebillingDTO();
		RegistroFacturacionDTO registroFacturacion = new RegistroFacturacionDTO();
		DatosGenerales datosGeneralesBO = new DatosGenerales();		
		
        //Obtiene Secuencia Proceso Facturación
		registroFacturacion.setCodigoSecuencia(configuracion.getNombreSecuenciaProcesoFacturacion());
		registroFacturacion = registroFacturacionBO.getSecuenciaProcesoFacturacion(registroFacturacion);
		impuestos =new ImpuestosDTO();
		impuestos.setNumeroProceso(registroFacturacion.getNumeroProcesoFacturacion());
		
		//Obtiene Parametros Factura Global
		DatosGeneralesDTO datosGral = new DatosGeneralesDTO();
		datosGral.setCodigoParametro(configuracion.getNombreParametroFacturaGlobal());
		datosGral.setCodigoProducto(configuracion.getCodigoProducto());
		datosGral.setCodigoModulo(configuracion.getModuloParametroFacturaGlobal());
		datosGral = datosGeneralesBO.getValorParametro(datosGral);
		
		sValorFacturaGlobal = datosGral.getValorParametro();
		
		//Obtiene Parametros Documento Guia
		datosGral = new DatosGeneralesDTO();
		datosGral.setCodigoParametro(configuracion.getNombreParametroDocumentoGuia());
		datosGral.setCodigoProducto(configuracion.getCodigoProducto());
		datosGral.setCodigoModulo(configuracion.getModuloParametroDocumentoGuia());
		datosGral = datosGeneralesBO.getValorParametro(datosGral);		
		
		sValorDocumentoGuia = datosGral.getValorParametro();
		
		//Obtiene Parametros Flag Centro Facturación
		datosGral = new DatosGeneralesDTO();
		datosGral.setCodigoParametro(configuracion.getParametroFlagCentroFac());
		datosGral.setCodigoProducto(configuracion.getCodigoProducto());
		datosGral.setCodigoModulo(configuracion.getModuloParametroFlagCentroFac());
		datosGral = datosGeneralesBO.getValorParametro(datosGral);
		
		
		sValorFlagCentroFact = datosGral.getValorParametro(); 
		
		
		registroFacturacion.setCodigoOficina(configuracion.getCodigoOficina());
		registroFacturacion.setCodigoTipoDocumento(configuracion.getCodigoTipoDocumento());
		registroFacturacion.setValorParametroFacturaGlobal(sValorFacturaGlobal);
		registroFacturacion.setValorParametroDocumentoGuia(sValorDocumentoGuia);
		registroFacturacion.setCodigoTipoFoliacion(configuracion.getTipoFoliacionDocumento());
		registroFacturacion.setCodigoTipoMovimiento(configuracion.getCodigoTipoMovimiento());
		registroFacturacion.setCategoriaTributaria(configuracion.getCategoriaTributaria());
		registroFacturacion.setValorParametroFlagCentroFact(sValorFlagCentroFact);
		registroFacturacion.setModalidadVenta(configuracion.getModalidadVenta());		
		registroFacturacion = registroFacturacionBO.getModoGeneracion(registroFacturacion);
		
		
		tarea.tarea(prebillingDTO);
		registroFacturacion.setSecuenciaTransacabo(prebillingDTO.getSecuenciaTransacabo());
		registroFacturacion.setActuacionPrebilling(prebillingDTO.getActuacionPrebilling());
		registroFacturacion.setProductoGeneral(prebillingDTO.getProductoGeneral());
		registroFacturacion.setCodigoCliente(prebillingDTO.getCodigoCliente());
		registroFacturacion.setNumeroVenta(prebillingDTO.getNumeroVenta());
		registroFacturacion.setNumeroTransaccionVenta(prebillingDTO.getNumeroTransaccionVenta());
		
		registroFacturacionBO.ejecutaPrebilling(registroFacturacion);
		
		datosGral = new DatosGeneralesDTO();
		datosGral.setNumTransaccion(prebillingDTO.getSecuenciaTransacabo());
		datosGral = datosGeneralesBO.getResultadoTransaccion(datosGral);		
		try{
		if (datosGral.getCodError()!=0){
			cat.debug("No se ejecuto correctamente el Prebilling");
			ProcesoDTO proceso = new ProcesoDTO();
			proceso.setIdentificadorProceso(IdentificadorProceso.EjecutaPrebilling);
			proceso.setEstadoEjecucion(false);
			proceso.setCodigoError(datosGral.getCodError());
			componerBitacora(proceso);
			int numevento = 1;
			throw new GeneralException(String.valueOf(521),
					numevento, "No se ejecuto correctamente el Prebilling");
						
		}				
		this.preBillingRunning = true;
		}catch (GeneralException e) {
			cat.debug("GeneralException");
			cat.debug("Error: al ejecutar Prebilling");
			cat.debug("datosGral.getCodError() ["+datosGral.getCodError()+"]");
			cat.debug("datosGral.getCodError() ["+datosGral.getMnsError()+"]");
			cat.debug("e.getCodigo() ["+e.getCodigo()+"]");
			cat.debug("e.getDescripcionEvento() ["+e.getDescripcionEvento()+"]");
			cat.debug("e.getCodigoEvento() ["+e.getCodigoEvento()+"]");
			throw e;			
		}
		
		
		
		cat.debug("Fin:ejecutaPrebilling()");
		
	}

	public ImpuestosDTO obtenerImpuestos() throws FrameworkCargosException {
		cat.debug("Inicio:obtenerImpuestos()");
		cat.debug("INICIO obtenerImpuestos ProcesadorCargos");
		if (preBillingRunning == true){
			try{
				cat.debug("INICIO obtenerImpuestos ProcesadorCargos 1 ");
				RegistroFacturacion registroFacturacionBO  = new RegistroFacturacion();
				cat.debug("INICIO obtenerImpuestos ProcesadorCargos 2 Antes getDatosPresupuesto ");
				impuestos = registroFacturacionBO.getDatosPresupuesto(impuestos);
				cat.debug("INICIO obtenerImpuestos ProcesadorCargos 3 Despues getDatosPresupuesto");
			}
			catch(CustomerDomainException ex){
				throw new FrameworkCargosException(ex);
			}
		}
		cat.debug("Fin:obtenerImpuestos()");
		return impuestos;
		
	}

	public void reconfigurarProcesosFacturacion() throws FrameworkCargosException {
		// TODO Auto-generated method stub
		cat.debug("Inicio:reconfigurarProcesosFacturacion()");
		try {
			cat.debug("INGRESO  A reconfigurarProcesosFacturacion ***** ");
			Date fecha = new Date();	
            //Obtiene Parametros Dias Vencimiento Factura
			DatosGenerales datosGeneralesBO = new DatosGenerales();
			DatosGeneralesDTO datosGral = new DatosGeneralesDTO();
			datosGral.setCodigoParametro(configuracion.getModuloParametroDiaVctoFact());
			datosGral.setCodigoProducto(configuracion.getCodigoProducto());
			datosGral.setCodigoModulo(configuracion.getParametroDiaVctoFact());
			datosGral = datosGeneralesBO.getValorParametro(datosGral);
			
			
			
			RegistroFacturacion registroFacturacionBO  = new RegistroFacturacion();
			RegistroFacturacionDTO regFac = new RegistroFacturacionDTO();
			regFac.setNumeroVenta(configuracion.getNumeroProceso());
			
			
			
			
			Calendar cal = new GregorianCalendar(); 
		    cal.setTimeInMillis(fecha.getTime()); 
		    cal.add(Calendar.DATE,Integer.parseInt(datosGral.getValorParametro())); 
		    Date fechaVencimiento = new Date(cal.getTimeInMillis()); 
		    
			
			regFac.setFechaVencimiento(Formatting.dateTime(fechaVencimiento,"dd/MM/yyyy HH:mm:ss"));
			regFac.setCategoriaTributaria(configuracion.getCategoriaTributaria());
			ProcesoDTO proceso = registroFacturacionBO.actualizaFacturacion(regFac);
			if (proceso !=null){
				proceso.setIdentificadorProceso(IdentificadorProceso.ReconfigurarProcesosFacturacion);
				componerBitacora(proceso);
			}
				
		}catch(CustomerDomainException e){
			throw new FrameworkCargosException(e);
		}
		cat.debug("Fin:reconfigurarProcesosFacturacion()");
		
	}

	public BitacoraDTO obtenerBitacora() throws CustomerDomainException {
		// TODO Auto-generated method stub
		return bitacora;
	}
	private void componerBitacora(ProcesoDTO proceso) throws FrameworkCargosException{
		cat.debug("Inicio:componerBitacora()");
		List listadoProcesos = new ArrayList();
		listadoProcesos.add(proceso);
		if (bitacora!=null){
			if (bitacora.getProcesos()!=null)
				if(bitacora.getProcesos().length >0)
					listadoProcesos.addAll(Arrays.asList(bitacora.getProcesos()));
				
		}
		else
			bitacora = new BitacoraDTO();
		ProcesoDTO[] arregloProcesos =(ProcesoDTO[])ArrayUtl.copiaArregloTipoEspecifico(listadoProcesos.toArray(), 
				ProcesoDTO.class);
		bitacora.setProcesos(arregloProcesos);
		cat.debug("Fin:componerBitacora()");
	}

//FIN MERGE	
}
