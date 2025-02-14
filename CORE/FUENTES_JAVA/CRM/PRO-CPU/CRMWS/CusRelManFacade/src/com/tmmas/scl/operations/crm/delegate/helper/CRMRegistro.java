package com.tmmas.scl.operations.crm.delegate.helper;

import java.util.Date;

import net.sf.dozer.util.mapping.DozerBeanMapper;
import net.sf.dozer.util.mapping.MapperIF;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.scl.framework.commonDoman.exception.FrmkCargosException;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.UsuarioDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.CITIPORSERVDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.RegistrarOossEnLineaDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.RegistroNivelOOSSDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.AtributosCargoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.CargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.CabeceraArchivoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RegCargosDTO;
import com.tmmas.scl.operations.crm.common.dataTransferObject.DatosContrModulosDTO;
import com.tmmas.scl.operations.crm.delegate.CloCusOrdDelegate;
import com.tmmas.scl.operations.crm.delegate.FrmkCargosDelegate;
import com.tmmas.scl.operations.crm.delegate.SupOrdHanDelegate;
import com.tmmas.scl.operations.crm.f.oh.clocusord.common.exception.CloCusOrdException;
import com.tmmas.scl.operations.crm.o.csr.supordhan.common.exception.SupOrdHanException;


public class CRMRegistro {
	
	private final Logger logger = Logger.getLogger(FacadeMaker.class);

	private static Global global = Global.getInstance();

	private static CRMRegistro instance;
	private SupOrdHanDelegate supOrdHanDelegate = new SupOrdHanDelegate();
	private CloCusOrdDelegate cloCusOrdDelegate = new CloCusOrdDelegate();
	private FrmkCargosDelegate frmkCargosDelegate = new FrmkCargosDelegate();
	
	public static CRMRegistro getInstance() {
		String log = global.getValor("delegate.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);
		if (instance == null) {
			instance = new CRMRegistro();
		}
		return instance;
	}

	public CRMRegistro() {

	}
	
	public long obtenerNumOs() throws SupOrdHanException {
		logger.debug("obtenerNumOs():start");
		SecuenciaDTO secuencia = new SecuenciaDTO();
		secuencia.setNomSecuencia("CI_SEQ_NUMOS");
		secuencia = supOrdHanDelegate.obtenerSecuencia(secuencia);
		long numOOSS =  secuencia.getNumSecuencia();
		logger.debug("obtenerNumOs():end");
		return numOOSS;
	}
	
	public String obtenerUsuarioOra() throws SupOrdHanException {
		String usuarioOra;
		//obtiene usuario
		ParametroDTO parametro = new ParametroDTO();
		parametro.setNomParametro("USUARIO_IVR");
		parametro.setCodModulo("GA");
		parametro.setCodProducto(Integer.parseInt(global.getValor("codigo.producto")));
		parametro = this.supOrdHanDelegate.obtenerParametroGeneral(parametro);
		usuarioOra =  parametro.getValor();
		return usuarioOra;
	}
	
	public int obtenerCodVendedor(String usuarioOra) throws SupOrdHanException {
		int codVendedor;
		UsuarioDTO usuario = new UsuarioDTO();
		usuario.setNombre(usuarioOra);
		usuario = this.supOrdHanDelegate.obtenerVendedor(usuario);
		codVendedor = usuario.getCodigo();
		return codVendedor;
	}
	
	public String obtenerCodActAbo(String codOOSS) throws SupOrdHanException {
		//10. obtener codigo actuacion
		CITIPORSERVDTO tiporserv = new CITIPORSERVDTO();
		tiporserv.setCodOoss(codOOSS);
		tiporserv = this.supOrdHanDelegate.obtenerTiporserv(tiporserv);
		String codActAbo=tiporserv.getCodTipModi();
		return codActAbo;
	}

	public RetornoDTO registrarOrdenServicio(DatosContrModulosDTO datosContratacion, AbonadoDTO abonadoContr, long numOOSS, String codOOSS, String codActAbo, String usuarioOra) throws CloCusOrdException {
		RetornoDTO retorno;
		//11. registra la orden de servicio
		//registrar nivel

		RegistroNivelOOSSDTO registroNivel = new RegistroNivelOOSSDTO();
		registroNivel.setNumAbonado(abonadoContr.getNumAbonado());
		registroNivel.setCodCliente(abonadoContr.getCodCliente());
		registroNivel.setCodTipMod(codActAbo);
		registroNivel.setTipSujeto(datosContratacion.getNivelAplicacion());
		registroNivel.setNomUsuaOra(usuarioOra);
		logger.debug("registraNivelOoss() :inicio");
		retorno = this.cloCusOrdDelegate.registraNivelOoss(registroNivel);
		logger.debug("registraNivelOoss() :fin");

		//registra ooss
		RegistrarOossEnLineaDTO registroLinea = new RegistrarOossEnLineaDTO();
		registroLinea.setCodOS(codOOSS);
		registroLinea.setNumOs(numOOSS);
		registroLinea.setCodProducto(Integer.parseInt(global.getValor("codigo.producto")));
		registroLinea.setTipInter(1);
		registroLinea.setCodInter(abonadoContr.getNumAbonado());
		registroLinea.setUsuario(usuarioOra);
		registroLinea.setFecha(new Date());
		registroLinea.setComentario("Contratación de modulos");
		
		logger.debug("registrarOOSSEnLinea() :inicio");
		retorno = this.cloCusOrdDelegate.registrarOOSSEnLinea(registroLinea);
		logger.debug("registrarOOSSEnLinea() :fin");
		return retorno;
	}

	public void registrarCargos(RetornoDTO retorno, ClienteDTO clienteContr, ObtencionCargosDTO obtencionCargos, int codVendedor) throws FrmkCargosException {
		RegCargosDTO regCargos = new RegCargosDTO();
		MapperIF mapper = new DozerBeanMapper();
		com.tmmas.scl.framework.productDomain.dataTransferObject.RegCargosDTO retVal = new com.tmmas.scl.framework.productDomain.dataTransferObject.RegCargosDTO();
		retVal = frmkCargosDelegate.construirRegistroCargos(obtencionCargos);
		mapper.map(retVal, regCargos);
		
		CabeceraArchivoDTO cabecera=new CabeceraArchivoDTO();
		cabecera.setPlanComercialCliente(String.valueOf(clienteContr.getCodPlanCom()));
		cabecera.setCodigoCliente(String.valueOf(clienteContr.getCodCliente()));
		cabecera.setFacturaCiclo(true);
		cabecera.setNumeroVenta(0);
		cabecera.setNumeroTransaccionVenta(0);
		cabecera.setCodigoDocumento("1");
		cabecera.setCodModalidadVenta("1");
		cabecera.setCodigoVendedor(String.valueOf(codVendedor));
		regCargos.setObjetoSesion(cabecera);
		
		mapper = new DozerBeanMapper();
		com.tmmas.scl.framework.productDomain.dataTransferObject.RegCargosDTO paramCargosFrmk = new com.tmmas.scl.framework.productDomain.dataTransferObject.RegCargosDTO();
		mapper.map(regCargos, paramCargosFrmk);

		mapper = new DozerBeanMapper();
		com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ResultadoRegCargosDTO resCargosFrmk = new com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ResultadoRegCargosDTO();
		resCargosFrmk = frmkCargosDelegate.parametrosRegistrarCargos(paramCargosFrmk); //Registra cargos
		mapper.map(resCargosFrmk, retorno);
	}

	public ParametrosObtencionCargosDTO obtenerParamObtCargos(AbonadoDTO abonadoContr, String codOOSS, String codActAbo) {
		
		String[] abonadosCargos = new String[1];
		abonadosCargos[0] = String.valueOf(abonadoContr.getNumAbonado());
		
		ParametrosObtencionCargosDTO paramObtCargos = new ParametrosObtencionCargosDTO();
		paramObtCargos.setTipoPantalla(global.getValor("tipo.pantalla"));
		paramObtCargos.setCodigoClienteOrigen(String.valueOf(abonadoContr.getCodCliente()));
		paramObtCargos.setCodigoClienteDestino(String.valueOf(abonadoContr.getCodCliente()));
		paramObtCargos.setCodigoPlanTarifOrigen(abonadoContr.getCodPlanTarif());
		paramObtCargos.setCodigoPlanTarifDestino(abonadoContr.getCodPlanTarif());
		paramObtCargos.setCodActabo(codActAbo);
		paramObtCargos.setTipoPantallaPrevio(global.getValor("tipo.pantalla.previo"));
		paramObtCargos.setOrdenServicio(codOOSS);
		paramObtCargos.setCodPlanServ(abonadoContr.getCodPlanServ());
		paramObtCargos.setCodigoTecnologia(abonadoContr.getCodTecnologia());
		java.sql.Date fechaVigencia = new java.sql.Date((new Date()).getTime());
		paramObtCargos.setFechaVigenciaAbonadoCero(fechaVigencia);
		paramObtCargos.setAbonados(abonadosCargos);
		return paramObtCargos;
	}

	public void imprimirParamObtCargos(ParametrosObtencionCargosDTO paramObtCargos) {
		try {
			logger.debug("Tipo pantalla			:"+paramObtCargos.getTipoPantalla());     
			logger.debug("Cliente origen		:"+paramObtCargos.getCodigoClienteOrigen()); 
			logger.debug("Cliente destino		:"+paramObtCargos.getCodigoClienteDestino()); 
			logger.debug("Plan tarif destino	:"+paramObtCargos.getCodigoPlanTarifDestino()); 
			logger.debug("Plan tarif origen		:"+paramObtCargos.getCodigoPlanTarifOrigen());
			logger.debug("Cod actuacion			:"+paramObtCargos.getCodActabo());
			logger.debug("Tipo pantalla previo	:"+paramObtCargos.getTipoPantallaPrevio());
			logger.debug("Orden de Servicio		:"+paramObtCargos.getOrdenServicio());
			logger.debug("Cod plan serv			:"+paramObtCargos.getCodPlanServ());
			logger.debug("Cod tecnologia		:"+paramObtCargos.getCodigoTecnologia()); 
			logger.debug("Fecha vigencia		:"+paramObtCargos.getFechaVigenciaAbonadoCero());
		} catch (Exception e) {
			logger.debug("Exception en imprimirParamObtCargos");
			e.printStackTrace();
		}
	}

	public void imprimirCargos(CargosDTO[] cargos) {
		try {
			if (cargos==null || cargos.length==0){
				logger.debug("-No se encontraron cargos-");
			}else{
				for(int i=0;i<cargos.length;i++){
					CargosDTO cargo = cargos[i];
					DescuentoDTO[] descuentos = cargo.getDescuento();
					PrecioDTO precio= cargo.getPrecio();
					AtributosCargoDTO atributo=cargo.getAtributo();
					logger.debug("-Cargo "+i+"-");
					logger.debug("idProducto="+cargo.getIdProducto());
					logger.debug("cantidad="+cargo.getCantidad());
					logger.debug("-Precio-");
					logger.debug("monto="+precio.getMonto());
					logger.debug("codigoConcepto="+precio.getCodigoConcepto());
					logger.debug("descripcionConcepto="+precio.getDescripcionConcepto());
					logger.debug("fechaAplicacion="+precio.getFechaAplicacion());
					logger.debug("valorMaximo="+precio.getValorMaximo());
					logger.debug("valorMinimo="+precio.getValorMinimo());
					logger.debug("indicadorAutMan="+precio.getIndicadorAutMan());
					
					if (descuentos==null||descuentos.length==0){
						logger.debug("-No tiene Descuentos-");
					}else{
						for(int j=0;j<descuentos.length;j++){
							DescuentoDTO descuento = descuentos[j];
							logger.debug("-Descuento "+j+"-");
							logger.debug(" monto				:"+descuento.getMonto());
							logger.debug(" tipo					:"+descuento.getTipo());
							logger.debug(" codigoConceptoCargo	:"+descuento.getCodigoConceptoCargo());
							logger.debug(" codigoConcepto		:"+descuento.getCodigoConcepto());
							logger.debug(" descripcionConcepto	:"+descuento.getDescripcionConcepto());
							logger.debug(" minDescuento			:"+descuento.getMinDescuento());
							logger.debug(" maxDescuento			:"+descuento.getMaxDescuento());
							logger.debug(" aprobacion			:"+descuento.isAprobacion());
							logger.debug(" tipoAplicacion		:"+descuento.getTipoAplicacion());
							logger.debug(" montoCalculado		:"+descuento.getMontoCalculado());
							logger.debug(" codigoMoneda			:"+descuento.getCodigoMoneda());
							logger.debug(" numTransaccion		:"+descuento.getNumTransaccion());
							
						}//fin for descuentos
					}
					logger.debug("-Atributos Cargo-");
					logger.debug("recurrente="+atributo.isRecurrente());
					logger.debug("obligatorio="+atributo.isObligatorio());
					logger.debug("cuotas="+atributo.getCuotas());
					logger.debug("fechaAplicacion="+atributo.getFechaAplicacion());
					logger.debug("ciclo="+atributo.isCiclo());
					logger.debug("tipoProducto="+atributo.getTipoProducto());
					logger.debug("claseProducto="+atributo.getClaseProducto());
					logger.debug("cicloFacturacion="+atributo.getCicloFacturacion());
					logger.debug("codigoArticuloServicio="+atributo.getCodigoArticuloServicio());
					logger.debug("numAbonado="+atributo.getNumAbonado());
					
				}//fin for cargos
			}
			logger.debug("-------------------------------------------");
		} catch (Exception e) {
			logger.debug("Exception en imprimirCargos");
			e.printStackTrace();
		}
	}	

}
