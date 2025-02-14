package com.tmmas.scl.serviciospostventasiga.service.servicios;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Iterator;

import com.tmmas.cl.framework.exception.GeneralException;

import com.tmmas.scl.serviciospostventasiga.businessobject.bo.BajaAbonadoPrepagoBO;
import com.tmmas.scl.serviciospostventasiga.businessobject.bo.MigracionPrepagoAPostpagoBO;
import com.tmmas.scl.serviciospostventasiga.businessobject.bo.ValidacionClientePostpagoBO;
import com.tmmas.scl.serviciospostventasiga.common.helper.Global;
import com.tmmas.scl.serviciospostventasiga.common.helper.ServiciosPostVentaSigaLoggerHelper;
import com.tmmas.scl.serviciospostventasiga.transport.AbonadoDTO;
import com.tmmas.scl.serviciospostventasiga.transport.AbonadoVtaDTO;
import com.tmmas.scl.serviciospostventasiga.transport.ClienteSIGADTO;
import com.tmmas.scl.serviciospostventasiga.transport.DatosGeneralesDTO;
import com.tmmas.scl.serviciospostventasiga.transport.DireccionDTO;
import com.tmmas.scl.serviciospostventasiga.transport.EquipoDTO;
import com.tmmas.scl.serviciospostventasiga.transport.EquipoVtaDTO;
import com.tmmas.scl.serviciospostventasiga.transport.MigracionDTO;
import com.tmmas.scl.serviciospostventasiga.transport.MigracionPrepagoPostpagoDTO;
import com.tmmas.scl.serviciospostventasiga.transport.MovimientoDTO;
import com.tmmas.scl.serviciospostventasiga.transport.OOSSDTO;
import com.tmmas.scl.serviciospostventasiga.transport.ParametrosPropertiesDTO;
import com.tmmas.scl.serviciospostventasiga.transport.ParametrosSIGADTO;
import com.tmmas.scl.serviciospostventasiga.transport.PlanesIndemnizacionDTO;
import com.tmmas.scl.serviciospostventasiga.transport.PlanesServiciosDTO;
import com.tmmas.scl.serviciospostventasiga.transport.ResultadoValidacionDatosMigracionDTO;
import com.tmmas.scl.serviciospostventasiga.transport.ServiciosSuplementariosDTO;
import com.tmmas.scl.serviciospostventasiga.transport.ServiciosSuplementariosVtaDTO;
import com.tmmas.scl.serviciospostventasiga.transport.TipoContratoSIGADTO;
import com.tmmas.scl.serviciospostventasiga.transport.UsuarioSIGADTO;
import com.tmmas.scl.serviciospostventasiga.transport.ValorPlanDTO;
import com.tmmas.scl.serviciospostventasiga.transport.VentaDTO;

public class MigracionPrepagoAPostpagoSrv {
	
	private Global global = Global.getInstance();
	private ServiciosPostVentaSigaLoggerHelper logger =  ServiciosPostVentaSigaLoggerHelper.getInstance();
	private String nombreClase = this.getClass().getName();
	private MigracionPrepagoAPostpagoBO migracionBO = new MigracionPrepagoAPostpagoBO();
	private AbonadoVtaDTO abonado = new AbonadoVtaDTO();
	String antiguoAbonado = null;
	ClienteSIGADTO clienteSigaDTO;
	OOSSDTO ooss = null;
	MigracionPrepagoPostpagoDTO ejecucion = new MigracionPrepagoPostpagoDTO();
	String perfilAbonado = "";
	String codServicio = "";
	String codPlanComverse = "";
	
	private VentaDTO venta = new VentaDTO();
	private ServiciosSuplementariosVtaDTO servSVta = new ServiciosSuplementariosVtaDTO();
	//reutilizacion siga
	
	private ValidacionClientePostpagoBO validacionBO = new ValidacionClientePostpagoBO();
	
	//variables globales
	EquipoVtaDTO equipoVta = new EquipoVtaDTO();
	EquipoDTO equipo = new EquipoDTO();
	ParametrosSIGADTO parametros = new ParametrosSIGADTO();
	ParametrosPropertiesDTO parametrosProperties = new ParametrosPropertiesDTO();
	DireccionDTO direc = new DireccionDTO();
	MigracionPrepagoPostpagoDTO resultadoEquipo = new MigracionPrepagoPostpagoDTO();
	MovimientoDTO movimiento = new MovimientoDTO();
	AbonadoDTO abo = new AbonadoDTO();
	MigracionDTO migra = new MigracionDTO();
	PlanesServiciosDTO planesServ = new PlanesServiciosDTO();
	TipoContratoSIGADTO tipoContratoSIGADTO = new TipoContratoSIGADTO();
	DatosGeneralesDTO datosGeneralesDTO = new DatosGeneralesDTO();
	UsuarioSIGADTO usuarioSIGADTO = new UsuarioSIGADTO();
	MigracionDTO entradaGlobal = new MigracionDTO();
	
	private void registraOOSS() throws GeneralException{
		ooss = new OOSSDTO();
		
		ooss.setTipInter(parametrosProperties.getTipInter());
		ooss.setCodOOSS(parametrosProperties.getCodOOSS());
		ooss.setCodModulo(parametrosProperties.getCodModulo());
		ooss.setProducto(parametrosProperties.getCodProducto());
		ooss.setComentario(parametrosProperties.getComentario());
		
		ooss.setNomUsuario(entradaGlobal.getNomUsuarioVendedor());
		ooss.setCodInter(antiguoAbonado);
		
		migracionBO.inscribeOOSS(ooss);
		
	}
	
	//Inicio: getParametrosBD
	public ParametrosSIGADTO getParametrosBD() throws GeneralException{


			getParametrosProperties();
			datosGeneralesDTO.setNomParametro(parametrosProperties.getIndFactur());
			datosGeneralesDTO.setCodModulo(parametrosProperties.getCodModulo());
			datosGeneralesDTO.setCodProducto(parametrosProperties.getCodProducto());
			datosGeneralesDTO.setValorParametro(null);
			migracionBO.obtieneParametro(datosGeneralesDTO);
			if(" ".equals(datosGeneralesDTO.getValorParametro()) || datosGeneralesDTO.getValorParametro() == null){
				throw new GeneralException("ERR.01111",1111,global.getValor("ERR.01111"));
			}
			try{
				parametros.setIndFacturNum(Integer.parseInt(datosGeneralesDTO.getValorParametro()));
			}catch(NumberFormatException e){
				throw new GeneralException("ERR.01164",1164,global.getValor("ERR.01164") + ": " +  datosGeneralesDTO.getNomParametro());
			}
			
			datosGeneralesDTO.setNomParametro(parametrosProperties.getCodBodega());
			datosGeneralesDTO.setValorParametro(null);
			migracionBO.obtieneParametro(datosGeneralesDTO);
			if(datosGeneralesDTO.getValorParametro() == null || " ".equals(datosGeneralesDTO.getValorParametro())){
				throw new GeneralException("ERR.01115",1115,global.getValor("ERR.01115"));
			}
			try{
				Integer.parseInt(datosGeneralesDTO.getValorParametro());
				parametros.setBodegaDef(datosGeneralesDTO.getValorParametro());
			}catch(NumberFormatException e){
				throw new GeneralException("ERR.01164",1164,global.getValor("ERR.01164") + ": " +  datosGeneralesDTO.getNomParametro());
			}
			
			datosGeneralesDTO.setNomParametro(parametrosProperties.getCodModVenta());
			datosGeneralesDTO.setValorParametro(null);
			migracionBO.obtieneParametro(datosGeneralesDTO);			
			if(datosGeneralesDTO.getValorParametro() == null || " ".equals(datosGeneralesDTO.getValorParametro())){
				throw new GeneralException("ERR.01113",1113,global.getValor("ERR.01113"));
			}
			try{
				Integer.parseInt(datosGeneralesDTO.getValorParametro());
				parametros.setCodModVenta(datosGeneralesDTO.getValorParametro());
			}catch(NumberFormatException e){
				throw new GeneralException("ERR.01164",1164,global.getValor("ERR.01164") + ": " +  datosGeneralesDTO.getNomParametro());
			}
			
	
			datosGeneralesDTO.setNomParametro(parametrosProperties.getCodArtSim());
			datosGeneralesDTO.setValorParametro(null);
			migracionBO.obtieneParametro(datosGeneralesDTO);
			if(datosGeneralesDTO.getValorParametro() == null || " ".equals(datosGeneralesDTO.getValorParametro())){
				throw new GeneralException("ERR.01123",1123,global.getValor("ERR.01123"));
			}
			try{
				Integer.parseInt(datosGeneralesDTO.getValorParametro());
				parametros.setCodArtSim(datosGeneralesDTO.getValorParametro());
			}catch(NumberFormatException e){
				throw new GeneralException("ERR.01164",1164,global.getValor("ERR.01164") + ": " +  datosGeneralesDTO.getNomParametro());
			}
			
			
			//incidencia agregado codTipContrato
			datosGeneralesDTO.setNomParametro(parametrosProperties.getCodTipContrato());
			datosGeneralesDTO.setValorParametro(null);
			migracionBO.obtieneParametro(datosGeneralesDTO);
			if(datosGeneralesDTO.getValorParametro() == null || " ".equals(datosGeneralesDTO.getValorParametro())){
				throw new GeneralException("ERR.01172",1172,global.getValor("ERR.01172"));
			}
			try{
				Integer.parseInt(datosGeneralesDTO.getValorParametro());
				parametros.setCodTipContrato(datosGeneralesDTO.getValorParametro());
			}catch(NumberFormatException e){
				throw new GeneralException("ERR.01164",1164,global.getValor("ERR.01164") + ": " +  datosGeneralesDTO.getNomParametro());
			}
			
			//incidencia agregado codIndemnizacion
			datosGeneralesDTO.setNomParametro(parametrosProperties.getCodIndemnizacion());
			datosGeneralesDTO.setValorParametro(null);
			migracionBO.obtieneParametro(datosGeneralesDTO);
			if(datosGeneralesDTO.getValorParametro() == null || " ".equals(datosGeneralesDTO.getValorParametro())){
				throw new GeneralException("ERR.01173",1173,global.getValor("ERR.01173"));
			}
			try{
				parametros.setCodIndemnizacion(Integer.parseInt(datosGeneralesDTO.getValorParametro()));
			}catch(NumberFormatException e){
				throw new GeneralException("ERR.01164",1164,global.getValor("ERR.01164") + ": " +  datosGeneralesDTO.getNomParametro());
			}
			
			
			datosGeneralesDTO.setNomParametro(parametrosProperties.getCarga());
			datosGeneralesDTO.setValorParametro(null);
			migracionBO.obtieneParametro(datosGeneralesDTO);
			if(datosGeneralesDTO.getValorParametro() == null){
				throw new GeneralException("ERR.01175",1175,global.getValor("ERR.01175"));
			}
			try{
				System.out.println("CARGA: "+ datosGeneralesDTO.getValorParametro());
				if(" ".equals(datosGeneralesDTO.getValorParametro())){
					parametros.setCarga(null);
				}else{
					Integer.parseInt(datosGeneralesDTO.getValorParametro());
					parametros.setCarga(datosGeneralesDTO.getValorParametro());
				}
				System.out.println("parametros.setCarga ---"+parametros.getCarga());
			}catch(NumberFormatException e){
				throw new GeneralException("ERR.01164",1164,global.getValor("ERR.01164") + ": " +  datosGeneralesDTO.getNomParametro());
			}
			
			datosGeneralesDTO.setNomParametro(parametrosProperties.getDesArtSim());
			datosGeneralesDTO.setValorParametro(null);
			migracionBO.obtieneParametro(datosGeneralesDTO);
			if(datosGeneralesDTO.getValorParametro() == null || " ".equals(datosGeneralesDTO.getValorParametro())){
				throw new GeneralException("ERR.01124",1124,global.getValor("ERR.01124"));
			}
			parametros.setDesArtSim(datosGeneralesDTO.getValorParametro());

			datosGeneralesDTO.setNomParametro(parametrosProperties.getParametroBaja());
			datosGeneralesDTO.setValorParametro(null);
			migracionBO.obtieneParametro(datosGeneralesDTO);
			if(datosGeneralesDTO.getValorParametro() == null || " ".equals(datosGeneralesDTO.getValorParametro()))
			{
				throw new GeneralException("ERR.01166",1166,global.getValor("ERR.01166"));
			}
			try
			{
				Integer.parseInt(datosGeneralesDTO.getValorParametro());
			}
			catch(NumberFormatException e){
				throw new GeneralException("ERR.01164",1164,global.getValor("ERR.01164") + ": " +  datosGeneralesDTO.getNomParametro());
			}
			parametros.setCausaBaja(datosGeneralesDTO.getValorParametro());

			return parametros;
	}//Fin: getParametrosBD
	
	//inicio getParametrosProperties
	private void getParametrosProperties() 
	{
		parametrosProperties.setTipPlantarif(global.getValor("OOSS.Migracion.prepago.postpago.tipplantarif"));//ok
		parametrosProperties.setTipTerminal(global.getValor("OOSS.Migracion.prepago.postpago.tipTerminal"));
		parametrosProperties.setCodSituacion(global.getValor("OOSS.Migracion.prepago.postpago.codSituacion"));//ATP
		parametrosProperties.setNumSerieHex(global.getValor("OOSS.Migracion.prepago.postpago.NumSerieHex"));//ok//properties
		parametrosProperties.setCodEstadoSimcard(global.getValor("OOSS.Migracion.prepago.postpago.CodEstadoSimcard"));
		parametrosProperties.setCodigoEstado(global.getValor("OOSS.Migracion.prepago.postpago.codEstado"));
		parametrosProperties.setIndSuperTel(new Integer(global.getValor("OOSS.Migracion.prepago.postpago.IndSuperTel")));//ok//properties
		parametrosProperties.setIndPrepago(new Integer(global.getValor("OOSS.Migracion.prepago.postpago.IndPrepago")));//ok//properties
		parametrosProperties.setIndPlexSys(new Integer(global.getValor("OOSS.Migracion.prepago.postpago.IndPlexSys")));//ok//properties
		parametrosProperties.setNumPerContrato(new Integer(global.getValor("OOSS.Migracion.prepago.postpago.NumPerContrato")));
		parametrosProperties.setIndProcEqSimcard(global.getValor("OOSS.Migracion.prepago.postpago.IndProcEqSimcard"));//ok
		parametrosProperties.setEquipoSimcard(global.getValor("OOSS.Migracion.prepago.postpago.equipo.simcard"));
		parametrosProperties.setEquipoTerminal(global.getValor("OOSS.Migracion.prepago.postpago.equipo.terminal"));
		parametrosProperties.setCodTipContrato(global.getValor("OOSS.Migracion.prepago.postpago.tipcontrato"));
		parametrosProperties.setIndSuspen(new Integer(global.getValor("OOSS.Migracion.prepago.postpago.IndSuspen")));//ok
		parametrosProperties.setIndReHabi(new Integer(global.getValor("OOSS.Migracion.prepago.postpago.IndReHabi")));//ok
		parametrosProperties.setInsGuias(new Integer(global.getValor("OOSS.Migracion.prepago.postpago.InsGuias")));
		parametrosProperties.setIndEqPrestadoTerminal(global.getValor("OOSS.Migracion.prepago.postpago.IndEqPrestadoTerminal"));//ok
		parametrosProperties.setIndEqPrestadoSimcard(global.getValor("OOSS.Migracion.prepago.postpago.IndEqPrestadoSimcard"));//ok
		parametrosProperties.setCodCuota(new Integer(global.getValor("OOSS.Migracion.prepago.postpago.CodCuota")));//ok
		parametrosProperties.setCodTecnologia(global.getValor("OOSS.Migracion.prepago.postpago.CodTecnologia"));//ok//properties
		parametrosProperties.setCodEstadoTerminal(global.getValor("OOSS.Migracion.prepago.postpago.CodEstadoTerminal"));
		parametrosProperties.setIndPropiedad(global.getValor("OOSS.Migracion.prepago.postpago.IndPropiedad"));
		parametrosProperties.setTipStock(global.getValor("OOSS.Migracion.prepago.postpago.TipStock"));
		parametrosProperties.setIndEquiacc(global.getValor("OOSS.Migracion.prepago.postpago.IndEquiacc"));
		parametrosProperties.setIndEstVenta(global.getValor("OOSS.Migracion.prepago.postpago.IndEstVenta"));
		parametrosProperties.setCodMoneda(global.getValor("OOSS.Migracion.prepago.postpago.CodMoneda"));
		parametrosProperties.setTipFoliacion(global.getValor("OOSS.Migracion.prepago.postpago.TipFoliacion"));
		parametrosProperties.setCodOperadora(usuarioSIGADTO.getCodOperadora());
		parametrosProperties.setCodTipDocum(global.getValor("OOSS.Migracion.prepago.postpago.codTipDocum"));
		
		parametrosProperties.setCodModVenta(global.getValor("MPP.Nombre.Parametro.codModVenta"));
		parametrosProperties.setIndFactur(global.getValor("MPP.Nombre.Parametro.indFactur"));
		parametrosProperties.setCodBodega(global.getValor("MPP.Nombre.Parametro.codBodega"));
		parametrosProperties.setCodArtSim(global.getValor("MPP.Nombre.Parametro.codArtTerm"));
		parametrosProperties.setCodCatTribut(global.getValor("MPP.Nombre.Parametro.codCategoriaTributaria"));
		
		parametrosProperties.setDesArtSim(global.getValor("MPP.Nombre.Parametro.desArtTerm"));
		parametrosProperties.setParametroBaja(global.getValor("MPP.Nombre.Parametro.baja"));  //MPP.Nombre.Parametro.baja
		parametrosProperties.setCodIndemnizacion(global.getValor("MPP.Nombre.Parametro.codIndemnizacion"));
		parametrosProperties.setCarga(global.getValor("MPP.Nombre.Parametro.carga"));
		parametrosProperties.setCodModulo(global.getValor("OOSS.Migracion.prepago.postpago.codModulo"));
		parametrosProperties.setCodProducto(global.getValor("OOSS.Migracion.prepago.postpago.codProducto"));
		parametrosProperties.setCodPlanServ(planesServ.getCodPlanServ());
//		parametrosProperties.setCodPlanServ(global.getValor("MPP.Nombre.Parametro.codPlanServ"));
		parametrosProperties.setTipVenta(global.getValor("OOSS.Migracion.prepago.postpago.tipVenta"));
		parametrosProperties.setCodGrpServ(global.getValor("OOSS.Migracion.prepago.postpago.codGrpServ"));
		parametrosProperties.setChkDicom(global.getValor("OOSS.Migracion.prepago.postpago.chkDicom"));
		
		parametrosProperties.setActaboBajaPrepago(global.getValor("OOSS.Migracion.prepago.postpago.actabo.baja.prepago"));//OOSS.Migracion.prepago.postpago.actabo.baja.prepago
		parametrosProperties.setActaboAltaHibrido(global.getValor("OOSS.Migracion.prepago.postpago.actabo.alta.hibrido"));//OOSS.Migracion.prepago.postpago.actabo.alta.hibrido
		parametrosProperties.setActaboAltaPospago(global.getValor("OOSS.Migracion.prepago.postpago.actabo.alta.postpago"));//OOSS.Migracion.prepago.postpago.actabo.alta.postpago
		parametrosProperties.setCodOOSS(global.getValor("OOSS.Migracion.prepago.postpago.codOOSS"));
		parametrosProperties.setTipInter(global.getValor("OOSS.Migracion.prepago.postpago.tipInter"));
		parametrosProperties.setComentario(global.getValor("OOSS.Migracion.prepago.postpago.comentario"));

	}
	
	/**
	 * Crea usuario
	 * @author Jano Diaz
	 * @param clienteSIGADTO
	 * @throws GeneralException
	 */
	public void creacionUsuario(ClienteSIGADTO clienteSIGADTO)throws GeneralException 
	{
		logger.info("creacionUsuario() : inicio",nombreClase);
		usuarioSIGADTO = new UsuarioSIGADTO();
		
		System.out.println("abonado=[" + abonado + "]");
		System.out.println("abonado.getNumAbonado()=[" + abonado.getNumAbonado() + "]");
		
		//usuarioSIGADTO.setNumAbonado(abonado.getNumAbonado().toString());
		AbonadoVtaDTO abonadoAntiguo = new AbonadoVtaDTO();
		
		abonadoAntiguo.setNumCelular(entradaGlobal.getNumCelular().longValue());
		migracionBO.getDatosAbonado(abonadoAntiguo);
		
		usuarioSIGADTO.setNumAbonado(abonadoAntiguo.getNumAbonado().toString());
		/*ClienteSIGADTO clienteSIGADTO2 = new ClienteSIGADTO();
		clienteSIGADTO2.setCodigoCliente(entradaGlobal.getCodCliente().toString());*/
		usuarioSIGADTO.setClienteSIGADTO(clienteSIGADTO);
// DESCOMENTAR!!!!!!!!!!!!!!!!			
		try{
			migracionBO.getUsuarioPrepago(usuarioSIGADTO);
			System.out.println("Existe Usuario");
		}catch(GeneralException ie){
			ie.printStackTrace();
			System.out.println("No Existe Usuario");
			migracionBO.obtencionDatosCliente(clienteSIGADTO);
		}
		
		migracionBO.obtencionCodUsuario(usuarioSIGADTO);
		//usuarioSIGADTO.setClienteSIGADTO(clienteSIGADTO);
		
		migracionBO.obtencionEstadoIncompletoUsuario(usuarioSIGADTO);
		
		abonado.setCodCliente(entradaGlobal.getCodCliente().longValue());
		migracionBO.getCodCuenta(abonado);
		if(abonado.getCodCuenta() == null){
			throw new GeneralException("ERR.01133",1133,global.getValor("ERR.01133"));
		}
		
		
		usuarioSIGADTO.getClienteSIGADTO().setCodigoCuenta(abonado.getCodCuenta().toString());
		
		migracionBO.creaUsuario(usuarioSIGADTO);
		logger.info("creacionUsuario() : fin",nombreClase);
	}//Fin: crea usuario
	
	//inicio ingreso de abonado
	private void insertaAbonado(MigracionDTO entrada)throws GeneralException
	{
		logger.info("insertaAbonado() : inicio",nombreClase);
		//llamada a la validacion de parametros
		
		//inicio parametros de entrada
		abonado.setNumCelular(entrada.getNumCelular().longValue());
		abonado.setCodCliente(entrada.getCodCliente().longValue());
		abonado.setCodPlanTarif(entrada.getCodPlanTarif());
		abonado.setNomUsuarOra(entrada.getNomUsuarioVendedor());
		abonado.setCodOficina(entrada.getCodOficina());
		abonado.setIndProcEqTerminal(entrada.getIndProcEqTerminal());
		abonado.setNumMinMdn(String.valueOf(entrada.getNumCelular()));
		System.out.println("IMEI ENTRADA: "+entrada.getImei());
		if("E".equals(entrada.getIndProcEqTerminal()))//agregado
			abonado.setNumSerieTerminal(entrada.getImei());
		//fin parametros de entrada
		
		//inicio parametros validados(getParametrosBD())
		abonado.setCodFactur(parametros.getIndFacturNum());
		//abonado.setCodBodegaSimcard(parametros.getBodegaDef());
		abonado.setCodModVenta(Long.parseLong(parametros.getCodModVenta()));
		abonado.setCodigoArticuloSimcard(new Integer(parametros.getCodArtSim()));
		abonado.setDesArticuloSimcard(parametros.getDesArtSim());
		abonado.setCodProducto(new Integer(parametrosProperties.getCodProducto()).intValue());
		//fin parametros validados
		
		//inicio parametros properties
		abonado.setTipPlantarif(parametrosProperties.getTipPlantarif());
		abonado.setTipTerminal(parametrosProperties.getTipTerminal());
		abonado.setCodSituacion(parametrosProperties.getCodSituacion());
		abonado.setNumSerieHex(parametrosProperties.getNumSerieHex());
		abonado.setCodigoEstado(parametrosProperties.getCodigoEstado());
		abonado.setIndSuperTel(parametrosProperties.getIndSuperTel().intValue());
		abonado.setIndPrepago(parametrosProperties.getIndPrepago().intValue());
		abonado.setIndPlexSys(parametrosProperties.getIndPlexSys().intValue());
		abonado.setNumPerContrato(parametrosProperties.getNumPerContrato().intValue());
		abonado.setIndProcEqSimcard(parametrosProperties.getIndProcEqSimcard());
		abonado.setCodTipContrato(parametros.getCodTipContrato());
		abonado.setIndSuspen(parametrosProperties.getIndSuspen().intValue());
		abonado.setIndReHabi(parametrosProperties.getIndReHabi().intValue());
		abonado.setInsGuias(parametrosProperties.getInsGuias().intValue());
		abonado.setIndEqPrestadoTerminal(parametrosProperties.getIndEqPrestadoTerminal());
		abonado.setCodCuota(parametrosProperties.getCodCuota().intValue());
		abonado.setCodTecnologia(parametrosProperties.getCodTecnologia());
		
		//TODO se asigna el codigo que viene de la BD
		//inicio obtencion codigo plan servicio

		planesServ = migracionBO.getPlanesServ(abonado);
		//fin obtencion codigo plan servicio
		
		abonado.setCodPlanServ(planesServ.getCodPlanServ());
//		lo obtiene del properties que consulta ged_parametro
//		abonado.setCodPlanServ(parametros.getCodPlanServ());
		abonado.setCodigoEstado(parametrosProperties.getCodigoEstado());
		abonado.setIndProcAlta(parametrosProperties.getTipVenta());
		abonado.setCodGrpSrv(parametrosProperties.getCodGrpServ());
		//fin parametros properties

		//inicio parametros dependientes
		
		migracionBO.getCodCuenta(abonado);
		if(abonado.getCodCuenta() == null){
			throw new GeneralException("ERR.01133",1133,global.getValor("ERR.01133"));
		}
		
		abonado.setCodCuenta(abonado.getCodCuenta());
		abonado.setCodSubCuenta(usuarioSIGADTO.getClienteSIGADTO().getCodigoSubCuenta());//la subcuenta se obtiene del cliente
		abonado.setCodUsuario(this.usuarioSIGADTO.getCodigoUsuario());// se obtiene del servicio de creacion del usuario
		
		//obtencion de codigos de direccion en el DTO de direccion
		migracionBO.getDireccion(abonado);
		if (abonado.getDireccionDTO() != null){
			if(abonado.getDireccionDTO().getCodRegion() == null){
				throw new GeneralException("ERR.01162",1162,global.getValor("ERR.01162"));
			}
			if(abonado.getDireccionDTO().getCodProvincia() == null){
				throw new GeneralException("ERR.01163",1163,global.getValor("ERR.01163"));
			}
			if(abonado.getDireccionDTO().getCodCiudad() == null){
				throw new GeneralException("ERR.01164",1164,global.getValor("ERR.01164")); 
			}
		}else{
			//TODO falta excepcion
		}
		
		
		//obtencion de codCelda
		migracionBO.getSubalm(abonado);
		
		//inicio obtencion de datos abonado y codCentral
		migracionBO.getDatosAbonado(abonado);
		
		antiguoAbonado = String.valueOf(abonado.getNumAbonado());
		
		if(abonado.getCodCentral() == null){
			throw new GeneralException("ERR.01160",1160,global.getValor("ERR.01160"));
		}		

		//inicio obtencion del codigo de uso
		migra = new MigracionDTO();
		migra.setCodPlanTarif(entrada.getCodPlanTarif());
		
		ResultadoValidacionDatosMigracionDTO planVigente = validacionBO.obtenerEstadoPlanVigente(migra);
		codPlanComverse = planVigente.getCodPlanComverse();

		try{
			Long est = new Long(planVigente.getEstadoPlanVigente());
			if(est.longValue() == 3L){
				abonado.setUsoLinea("AHORRO");
				abonado.setCodUso("10");
			}else if(est.longValue() == 2L){
				abonado.setUsoLinea("POSTPAGO");
				abonado.setCodUso("2");
			}
		}catch(NumberFormatException e){
			e.printStackTrace(); //TODO ingresar codigo de error
		}
		
		migracionBO.getUsosLinea(abonado);
		//TODO ver excepcion
		
		migracionBO.getCodVendedor(abonado); //codigo vendedor y vendedor agente
		//TODO ver excepcion
		
		//inicio obtencion del cargo basico
		
		//Incidencia 115365
		//Se lee el codPlanTarif de los datos de entrada para consultar codCargoBasico
		abonado.setCodPlanTarif(entrada.getCodPlanTarif());
		migracionBO.getCargoBasico(abonado);
		if(abonado.getCodCargoBasico() == null)
		{
			throw new GeneralException("ERR.01128",1128,global.getValor("ERR.01128"));
		}
		//fin obtencion del cargo basico
		
	
		
		//inicio obtencion cod limite de consumo
		
		abonado.setCodPlanTarif(entrada.getCodPlanTarif());
		
		
		if("10".equalsIgnoreCase(abonado.getCodUso())){ //ahorro
			abonado.setCodLimConsumo("-1");
		}else{   //pospago
			migracionBO.getCodLimCons(abonado);
			if(abonado.getCodLimConsumo() == null)
			{
				throw new GeneralException("ERR.01134",1134,global.getValor("ERR.01134"));
			}
		}
		
		//fin obtencion cod limite de consumo
		
		//inicio obtencion numero de serie
		migracionBO.obtieneSerie(abonado);
		if(abonado.getNumSerieSimcard() == null)
		{
			throw new GeneralException("ERR.01159",1159,global.getValor("ERR.01159"));
		}
		//fin obtencion numero de serie
		
		//inicio obtencion Imei
		if("I".equals(entrada.getIndProcEqTerminal())){//if agregado
			migracionBO.obtieneImei(abonado);//descomentado
			if(abonado.getNumSerieTerminal() == null)
			{
				System.out.println("paso num serie terminal null");
				throw new GeneralException("ERR.01157",1157,global.getValor("ERR.01157"));
			}
		}
		//abonado.setNumSerieTerminal(abonado.getNumSerieTerminal());//TODO pendiente
		System.out.println("Num serie terminal: "+abonado.getNumSerieTerminal());
		abonado.setNumImei(abonado.getNumSerieTerminal());//TODO pendiente
		//fin obtencion Imei
		
		//inicio obtencion fecha de alta
		Calendar fecha = Calendar.getInstance();
		String fechaAlta = null;
		int mes = fecha.get(Calendar.MONTH)+1; 
		fechaAlta = fecha.get(java.util.Calendar.DATE) + "-" + mes + "-" + fecha.get(java.util.Calendar.YEAR)+" "+
		fecha.get(Calendar.HOUR_OF_DAY)+":"+fecha.get(Calendar.MINUTE)+":"+fecha.get(Calendar.SECOND);
		abonado.setFecAlta(fechaAlta);
		//fin obtencio fecha de alta
		
		//inicio obtencion password
		String pass = String.valueOf(abonado.getNumSerieSimcard());
		pass = pass.substring(pass.length() -4,pass.length());
		abonado.setCodPassword(pass);
		//fin obtencion password
			
		System.out.println("abonado.getIndProcEqTerminal()=[" + abonado.getIndProcEqTerminal() + "]");
		if ("E".equals(abonado.getIndProcEqTerminal())){ //equipo externo
			System.out.println("equipo externo");
			abonado.setDesArticuloTerminal(parametros.getDesArtSim());
			abonado.setCodigoArticuloTerminal(new Integer(parametros.getCodArtSim()));
		}else{                                           //equipo interno
			
			//inicio obtiene cod articulo
     		migracionBO.obtieneImei(abonado);
			
			//AbonadoVtaDTO abonado1 = new AbonadoVtaDTO();
			abonado.setNumImei(abonado.getNumSerieTerminal());
			migracionBO.getCodArticulo(abonado);
			//abonado.setCodigoArticuloTerminal(abonado.getCodigoArticuloTerminal());
			if(abonado.getCodigoArticuloTerminal() == null)
			{
				throw new GeneralException("ERR.01129",1129,global.getValor("ERR.01129"));
			}
			//fin obtiene cod articulo
			
			System.out.println("equipo interno");
			EquipoDTO equipoDTO = new EquipoDTO();
			equipoDTO.setCodArticulo(abonado.getCodigoArticuloTerminal());
			equipoDTO.setNumCelular(new Long(abonado.getNumCelular()));
			equipoDTO.setEquipo("TERMINAL");
			migracionBO.getDatosEquipo(equipoDTO);
			abonado.setDesArticuloTerminal(equipoDTO.getFabricante() + " " + equipoDTO.getModelo());
		}
		
		this.numeroContrato(); //obtiene el numero de contrato y lo ingresa al abonado
		
		//inicio obtiene codigo de ciclo
		migracionBO.getCodCiclo(abonado);
		if(abonado.getCodCiclo() == null)
		{
			throw new GeneralException("ERR.01132",1132,global.getValor("ERR.01132"));
		}
		//fin obtiene codigo de ciclo
		
		//inicio obtencion fecha fin contrato
		tipoContratoSIGADTO = new TipoContratoSIGADTO();
		tipoContratoSIGADTO.setCodTipContrato(parametros.getCodTipContrato());
		migracionBO.getNumMeses(tipoContratoSIGADTO);
		migracionBO.getFechaFinContrato(tipoContratoSIGADTO);
		if(tipoContratoSIGADTO.getFecFinContrato() == null)
		{
			throw new GeneralException("ERR.01143",1143,global.getValor("ERR.01143"));
		}
		abonado.setFecFinContra(tipoContratoSIGADTO.getFecFinContrato());
		//fin obtencion fecha fin contrato
		
		//inicio planesIndemnizados
		PlanesIndemnizacionDTO planesIndemnizados = migracionBO.getPlanesIndem();
		if(planesIndemnizados.getCodPlanIndemnizacion() == null)
		{
			throw new GeneralException("ERR.01150",1150,global.getValor("ERR.01150"));
		}
		
		//		abonado.setCodIndemnizacion(planesIndemnizados.getCodPlanIndemnizacion().intValue());
		abonado.setCodIndemnizacion(parametros.getCodIndemnizacion());
		//fin planesIndemnizados
		
		//inicio 
		migracionBO.getOficinaPrincipal(abonado);
		if(abonado.getCodOficina() == null)
		{
			throw new GeneralException("ERR.01161",1161,global.getValor("ERR.01161"));
		}
		abonado.setCodOficinaPrincipal(abonado.getCodOficina());
		//fin
		
		String anexo = abonado.getNumContrato().substring(0, 20);//seobtiene del numcontrato
		abonado.setNumAnexo(anexo + "1");
		
		VentaDTO venta = new VentaDTO();
		migracionBO.getNumVenta(venta);
		abonado.setNumVenta(venta.getNumVenta().longValue());
		
		migracionBO.getFechaCumplimiento(abonado);
		//fin parametros dependientes
		
		//inicio valores nulos
		abonado.setCodEmpresa(null);//No aplica para clientes empresa
		abonado.setFecCumPlan(null);
		
		abonado.setCodCalClien(clienteSigaDTO.getCodigoCalidadCliente());
		abonado.setCodCredMor(null); //se revisa VB y se asigna nulo
		abonado.setCodCredCon(null); //se revisa VB y se asigna nulo
		//fin valores nulos
		
		//inicio obtencion del nuevo numero de abonado
		migracionBO.getNumAbonado(abonado);//al ultimo
		System.out.println("numAbonado generado: " + abonado.getNumAbonado());
		if(abonado.getNumAbonado() == null)
		{
			throw new GeneralException("ERR.01145",1145,global.getValor("ERR.01145"));
		}
		//fin obtencion del nuevo numero de abonado
				
		//Aseguramos que se registre el código de oficina de entrada
		abonado.setCodOficinaPrincipal(entrada.getCodOficina());
		
		abonado.setCodSituacion("AOP");
		migracionBO.insertaAbonado(abonado);

		logger.info("insertaAbonado() : fin",nombreClase);
	}
	//fin insercion abonado
	
	private void ingresaEquipo() throws GeneralException
	{
		equipoVta.setNumAbonado(abonado.getNumAbonado());

		String equipos[] = new String[2];
		equipos[0] = parametrosProperties.getEquipoSimcard();  //OOSS.Migracion.prepago.postpago.equipo.simcard
		equipos[1] = parametrosProperties.getEquipoTerminal(); //OOSS.Migracion.prepago.postpago.equipo.terminal
		for(int i = 0; i < equipos.length; i++){
			System.out.println("venta() : inicio de iteracion para [" + equipos[i] + "]");
			//parametros properties
			equipoVta.setCodProducto(new Long(parametrosProperties.getCodProducto()));//ingresar dato//new Long(global.getValor("OOSS.Migracion.prepago.postpago.cod.producto"))
			equipoVta.setIndPropiedad(parametrosProperties.getIndPropiedad());//ingresar dato//global.getValor("OOSS.Migracion.prepago.postpago.IndPropiedad")
//			equipoVta.setTipStock(parametrosProperties.getTipStock());//ingresar dato//global.getValor("OOSS.Migracion.prepago.postpago.TipStock")
			equipoVta.setIndEquiacc(parametrosProperties.getIndEquiacc());//ingresar dato//global.getValor("OOSS.Migracion.prepago.postpago.IndEquiacc")
			equipoVta.setCodTecnologia(parametrosProperties.getCodTecnologia());//ingresar dato//global.getValor("OOSS.Migracion.prepago.postpago.CodTecnologia")
			
			//parametros del abonado
			equipoVta.setFechaAlta(abonado.getFecAlta());//ingresar dato//abonado.getFecAlta()
			equipoVta.setCodModVenta(String.valueOf(abonado.getCodModVenta()));//ingresar dato//String.valueOf(abonado.getCodModVenta())
			//ingresar dato//abonado.getTipTerminal()
			equipo.setNumCelular(new Long(abonado.getNumCelular()));

			//pametros nulos
			equipoVta.setCodCuota(null);
			equipoVta.setCapCode(null); 
			equipoVta.setCodProtocolo(null);
			equipoVta.setNumVelocidad(null); 
			equipoVta.setCodFrecuencia(null);
			equipoVta.setCodVersion(null);
			equipoVta.setNumSerieMec(null);
			equipoVta.setCodPaquete(null);
			equipoVta.setCodCausa(null);
			equipoVta.setIndEqPrestado(null);
			equipoVta.setNumImei(null);
			equipoVta.setNumMovimiento(null);
			
//			
			
			if(equipos[i].equals(parametrosProperties.getEquipoSimcard())){ //SIMCARD
				
//				inicio obtencion numero de serie
				migracionBO.obtieneSerie(abonado);
				if(abonado.getNumSerieSimcard() == null)
				{
					throw new GeneralException("ERR.01159",1159,global.getValor("ERR.01159"));
				}
				
				equipoVta.setNumSerie(abonado.getNumSerieSimcard());
				//fin obtencion numero de serie
				
				try{
					AbonadoVtaDTO abonadoVtaDTO1 = new AbonadoVtaDTO();
					abonadoVtaDTO1.setNumImei(abonado.getNumSerieSimcard());
					migracionBO.getCodArticulo(abonadoVtaDTO1);
					equipoVta.setCodArticulo(new Long(abonadoVtaDTO1.getCodigoArticuloTerminal().intValue()));
				}catch(NumberFormatException e){
					e.printStackTrace();
					throw new GeneralException("ERR.01130",1130,global.getValor("ERR.01130"));
				}
				
				
				//Rescatar bodega de la BD
				String imei = abonado.getNumImei();
				abonado.setNumImei(abonado.getNumSerieSimcard());
				
				abonado.setCodBodegaTerminal(parametros.getBodegaDef());
				migracionBO.getCodBodega(abonado);
				equipoVta.setCodBodega(new Long(abonado.getCodigoBodega()));
				abonado.setNumImei(imei);
				
				//ingresar datos//global.getValor("OOSS.Migracion.prepago.postpago.IndProcEqSimcard")
				equipoVta.setCodEstado(parametrosProperties.getCodEstadoSimcard());//ingresar dato//global.getValor("OOSS.Migracion.prepago.postpago.CodEstadoSimcard")
				equipo.setEquipo(parametrosProperties.getEquipoSimcard());//ingresar dato//global.getValor("OOSS.Migracion.prepago.postpago.equipo.simcard")
				
				System.out.println("simcard");
				EquipoDTO equipoDTO = new EquipoDTO();
				equipoDTO.setCodArticulo(abonado.getCodigoArticuloTerminal());
				equipoDTO.setNumCelular(new Long(abonado.getNumCelular()));
				equipoDTO.setEquipo("SIMCARD");
				migracionBO.getDatosEquipo(equipoDTO);
				equipoVta.setTipStock(String.valueOf(equipoDTO.getCodTipStock()));
				abonado.setDesArticuloSimcard(equipoDTO.getFabricante() + " " + equipoDTO.getModelo());
				equipoVta.setDesEquipo(abonado.getDesArticuloSimcard());//ingresar dato//abonado.getDesArticuloSimcard()
				equipoVta.setTipTerminal("G");
				equipoVta.setNumImei(abonado.getNumSerieTerminal());
				equipoVta.setIndProcequi(parametrosProperties.getIndProcEqSimcard());
				
			}else{  //EQUIPO
				System.out.println("terminal");
				EquipoDTO equipoDTO = new EquipoDTO();
				equipoDTO.setCodArticulo(abonado.getCodigoArticuloTerminal());
				equipoDTO.setNumCelular(new Long(abonado.getNumCelular()));
				equipoDTO.setEquipo("TERMINAL");
				migracionBO.getDatosEquipo(equipoDTO);
				equipoVta.setTipStock(String.valueOf(equipoDTO.getCodTipStock()));
				abonado.setDesArticuloTerminal(equipoDTO.getFabricante() + " " + equipoDTO.getModelo());
				equipoVta.setTipTerminal("T");
				equipoVta.setDesEquipo(abonado.getDesArticuloTerminal());//ingresar dato//abonado.getDesArticuloSimcard()
				
				equipoVta.setNumImei(null);
				if(abonado.getIndProcEqTerminal().equals("I")){
					//if mantuvo
					migracionBO.obtieneImei(abonado);
					abonado.setNumImei(abonado.getNumSerieTerminal());
					migracionBO.getCodBodega(abonado);
					//else

					try{
						equipoVta.setCodBodega(new Long(abonado.getCodigoBodega()));//ingresar dato//migracionBO.getCodBodega(new Long(abonado.getNumCelular()), abonado.getNumImei())
					}catch(NumberFormatException e){
						throw new GeneralException("ERR.01161",1161,global.getValor("ERR.01161"));
					}
				}else{
					System.out.println("TERMINAL EXTERNO!!!");
					equipoVta.setCodBodega(new Long(parametros.getBodegaDef()));
					System.out.println("parametros.getBodegaDef(): "+parametros.getBodegaDef());
					equipoVta.setDesEquipo(parametros.getDesArtSim());//ingresar dato//abonado.getDesArticuloSimcard()
					System.out.println("parametros.getDesArtSim(): "+parametros.getDesArtSim());
					equipoVta.setCodArticulo(new Long(parametros.getCodArtSim()));
					System.out.println("parametros.getCodArtSim(): "+parametros.getCodArtSim());
					equipoVta.setTipStock(parametrosProperties.getTipStock());
				}
				equipoVta.setNumSerie(abonado.getNumImei());//ingresar dato//new Long(abonado.getNumImei())
				equipoVta.setIndProcequi(abonado.getIndProcEqTerminal());//ingresar dato//abonado.getIndProcEqTerminal()
				equipoVta.setCodEstado(parametrosProperties.getCodEstadoTerminal());//ingresar dato//global.getValor("OOSS.Migracion.prepago.postpago.CodEstadoTerminal")
				equipo.setEquipo(parametrosProperties.getEquipoTerminal());//ingresar dato//global.getValor("OOSS.Migracion.prepago.postpago.equipo.terminal")
				equipoVta.setCodArticulo(new Long(abonado.getCodigoArticuloTerminal().intValue()));//ingresar dato//new Long(abonado.getCodigoArticuloTerminal())
				logger.debug("venta(): Leo los datos de equipo", nombreClase);
				
				//migracionBO.getDatosEquipo(equipo);
				
				if(equipo.getModelo() == null || equipo.getFabricante() == null)
					equipoVta.setIndProcequi(abonado.getIndProcEqTerminal());//ingresar dato//abonado.getIndProcEqTerminal()
				
				equipoVta.setCodEstado(parametrosProperties.getCodEstadoTerminal());//ingresar dato//global.getValor("OOSS.Migracion.prepago.postpago.CodEstadoTerminal")
				equipo.setEquipo(parametrosProperties.getEquipoTerminal());//ingresar dato//global.getValor("OOSS.Migracion.prepago.postpago.equipo.terminal")
				//equipoVta.setCodArticulo(new Long(abonado.getCodigoArticuloTerminal().intValue()));//ingresar dato//new Long(abonado.getCodigoArticuloTerminal())
				logger.debug("venta(): Leo los datos de equipo", nombreClase);
				
				if ("I".equalsIgnoreCase(abonado.getIndProcEqTerminal())){
					//migracionBO.getDatosEquipo(equipo);
					if(equipoDTO.getModelo() == null && equipoDTO.getFabricante() == null){
						throw new GeneralException("ERR.01164",1164,global.getValor("ERR.01164"));
					}
				}
				//equipoVta.setDesEquipo(equipo.getModelo() + " " + equipo.getFabricante());
			}
				
			if(equipo.getModelo() == null || equipo.getFabricante() == null)
			equipoVta.setIndProcequi(abonado.getIndProcEqTerminal());//ingresar dato//abonado.getIndProcEqTerminal()
			
			equipoVta.setCodEstado(parametrosProperties.getCodEstadoTerminal());//ingresar dato//global.getValor("OOSS.Migracion.prepago.postpago.CodEstadoTerminal")
			equipo.setEquipo(parametrosProperties.getEquipoTerminal());//ingresar dato//global.getValor("OOSS.Migracion.prepago.postpago.equipo.terminal")
			//equipoVta.setCodArticulo(new Long(abonado.getCodigoArticuloTerminal().intValue()));//ingresar dato//new Long(abonado.getCodigoArticuloTerminal())
			logger.debug("venta(): Leo los datos de equipo", nombreClase);
			
			equipoVta.setCodUso(new Long(abonado.getCodUso()));
			
			if(equipos[i].equals(parametrosProperties.getEquipoSimcard())){ //SIMCARD
				equipoVta.setIndProcequi(parametrosProperties.getIndProcEqSimcard());
			}
			migracionBO.insertaEquipo(equipoVta);
		}
	}
	
	private void serviciosSuplementarios() throws GeneralException
	{
		
		//migracionBO.getServSuplementarios(abonado);//ingresar dato//abonado.getCodPlanTarif(), Integer.parseInt(abonado.getCodigoArticuloTerminal())
		
		ArrayList ssUso = new ArrayList();
		String strCodServSuplabo; //primeros 2
		String strNivelServicio; //4
		Integer intCodServSuplabo = new Integer(0);
		Integer intNivelServicio = new Integer(0);
		
		String codActabo = null;
		
		if("AHORRO".equals(abonado.getUsoLinea())){
			codActabo=parametrosProperties.getActaboAltaHibrido();
		}
		else{
			codActabo=parametrosProperties.getActaboAltaPospago();
		}
		
		String cadena = null;
		try{
			cadena = migracionBO.obtencionSSPorDefecto(codActabo); //TODO
		}catch(GeneralException ie){
			logger.error("No existe ss para el codActabo", nombreClase);
		}
		
		if(cadena==null||cadena.length()<6||cadena.length()%6!=0)
		{
			System.out.println("Problemas con la cadena de SS");
		}else{
					
			for(int i=0; i < cadena.length(); i = i + 6){
				try{
					strCodServSuplabo = cadena.substring(i, i + 2);
					strNivelServicio = cadena.substring(i + 2, i + 6);
					
				}catch(IndexOutOfBoundsException ob){
					ob.printStackTrace();
					throw new GeneralException("ERR.01179",1,global.getValor("ERR.01179"));
				}
				
				try{
					intCodServSuplabo = new Integer(strCodServSuplabo);
					intNivelServicio = new Integer (strNivelServicio);
				}catch(NumberFormatException ne){
					ne.printStackTrace();
					throw new GeneralException("ERR.01179",1,global.getValor("ERR.01179"));
				}
				
				if(intNivelServicio.intValue() != 0){
					servSVta = new ServiciosSuplementariosVtaDTO();
					servSVta.setNumAbonado(abonado.getNumAbonado());
					servSVta.setUsuario(abonado.getNomUsuarOra());
					servSVta.setNumTerminal(String.valueOf(abonado.getNumCelular()));//String.valueOf(abonado.getNumCelular())
					servSVta.setCodServSuplabo(new Long(intCodServSuplabo.intValue()));
					servSVta.setCodNivel(new Long(intNivelServicio.intValue()));
					servSVta.setCodActabo(codActabo);
					
					try{
						migracionBO.getDatosSerSupl(servSVta);
						migracionBO.insertaServSupl(servSVta);
						ssUso.add(servSVta);
						perfilAbonado = perfilAbonado + completaCeros(intCodServSuplabo,2) + completaCeros(intNivelServicio,4);
						System.out.println("perfilAbonado=[" + perfilAbonado + "]\n");
					}catch(GeneralException ie){
						ie.printStackTrace();
						logger.error("No se encontro ss", nombreClase);
					}
					
				}
			}
		}
		
		boolean insertarSS = true;
		ServiciosSuplementariosDTO[] servsuplDTO = migracionBO.getServSuplementarios(abonado);
		for(int i = 0; i < servsuplDTO.length ; i++){
			insertarSS = true;
			ServiciosSuplementariosDTO ss = servsuplDTO[i];
			servSVta = new ServiciosSuplementariosVtaDTO();
			servSVta.setNumAbonado(abonado.getNumAbonado());
			servSVta.setCodServicio(ss.getCodServicio());
			servSVta.setCodServSuplabo(new Long(Integer.parseInt(ss.getCodServSupl())));
			servSVta.setCodNivel(new Long(ss.getCodNivel()));
			servSVta.setUsuario(abonado.getNomUsuarOra());
			servSVta.setCodConcepto(new Long(ss.getCodConcepto1().intValue()));
			System.out.println("ss.getCodConcepto1().intValue(): "+ ss.getCodConcepto1().intValue());
			servSVta.setNumTerminal(String.valueOf(abonado.getNumCelular()));
			
			Iterator usoIter = ssUso.iterator();
			while(usoIter.hasNext()){
				ServiciosSuplementariosVtaDTO uso = (ServiciosSuplementariosVtaDTO)usoIter.next();
				
				intCodServSuplabo = new Integer(0);
				intNivelServicio = new Integer(1);
				
				try{
					intCodServSuplabo = Integer.valueOf(String.valueOf(uso.getCodServSuplabo()));
					intNivelServicio = Integer.valueOf(String.valueOf(servSVta.getCodServSuplabo()));
				}catch(NumberFormatException nfe){
					nfe.printStackTrace();
				}
				
				System.out.println("se va a comparar los SS [" + intCodServSuplabo.intValue() + "]=[" + intNivelServicio.intValue() + "]");
				if(intCodServSuplabo.intValue() == intNivelServicio.intValue()){
					insertarSS = false;
					System.out.println("Se omite el SS: [" + servSVta.getCodServSuplabo() + "]");
				}
			}
			
			if(insertarSS){
				migracionBO.insertaServSupl(servSVta);
				
				try{
					intCodServSuplabo = Integer.valueOf(String.valueOf(servSVta.getCodServSuplabo()));
					intNivelServicio = Integer.valueOf(String.valueOf(servSVta.getCodNivel()));
				}catch(NumberFormatException nfe){
					nfe.printStackTrace();
				}
				codServicio = codServicio + completaCeros(intCodServSuplabo,2) + completaCeros(intNivelServicio, 4);
				System.out.println("codServicio=[" + codServicio + "]");
			}
		}
	}

	
	//incio insercion venta
	private void venta()throws GeneralException
	{
		logger.info("venta() : inicio",nombreClase);
		//inicio insercion venta
		//venta.setImpVenta(null);//insertar dato//migracionBO.obtieneImpuesto()
		migracionBO.obtieneImpuesto(venta);
		direc = new DireccionDTO();
		migracionBO.getDireccion(abonado);
		migracionBO.getCodPlaza(abonado);
//		direc = abonado.getDireccionDTO();
//		venta.setCodPlaza(direc.getCodCiudad());
		venta.setCodPlaza(abonado.getDireccionDTO().getCodPlaza());
		System.out.println("venta.getCodPlaza: "+ venta.getCodPlaza());
//		venta.setCodPlaza(null);
		
		venta.setIndEstVenta(parametrosProperties.getIndEstVenta());
		venta.setCodMoneda(parametrosProperties.getCodMoneda());
		venta.setTipFoliacion(parametrosProperties.getTipFoliacion());
		venta.setCodTipDoc(parametrosProperties.getCodTipDocum());
		venta.setCodOperadora(usuarioSIGADTO.getCodOperadora());
		System.out.println("codOperadora: "+usuarioSIGADTO.getCodOperadora());
		venta.setChkDicom(parametrosProperties.getChkDicom());
		venta.setIndOfiter(parametrosProperties.getIndProcAlta());
		
		venta.setNumVenta(new Long(abonado.getNumVenta()));//ingreasr dato//this.numVenta
		venta.setCodOficina(entradaGlobal.getCodOficina());//insertar dato//entrada.getCodOficina()
		venta.setCodVendedor(new Long(abonado.getCodVendedor()));//insertar dato//new Long(abonado.getCodVendedor())
		venta.setCodVendedorAgente(new Long(abonado.getCodVendedorAgente()));//insertar dato//new Long(abonado.getCodVendedorAgente())
		venta.setCodRegion(abonado.getDireccionDTO().getCodRegion());//insertar dato//abonado.getCodRegion()
		venta.setCodProvincia(abonado.getDireccionDTO().getCodProvincia());//insertar dato//abonado.getCodProvincia()
		venta.setCodCiudad(abonado.getDireccionDTO().getCodCiudad());//insertar dato//abonado.getCodCiudad()			
		venta.setTipContrato(abonado.getCodTipContrato());//insertar dato//abonado.getCodTipContrato()
		venta.setCodCliente(new Long(abonado.getCodCliente()));//insertar dato//new Long(abonado.getCodCliente())
		venta.setModVenta(String.valueOf(abonado.getCodModVenta()));//inserrtar dato//String.valueOf(abonado.getCodModVenta())
		venta.setNumContrato(abonado.getNumContrato());//ingresar dato//abonado.getNumContrato()
		venta.setNomUsuarVta(abonado.getNomUsuarOra());//ingresar dato//entrada.getNomUsuarioVendedor()
		venta.setCodVenDealer(String.valueOf(abonado.getCodVendealer()));
		
		venta.setImpVenta(new Long(0));
		
		migracionBO.insertaVenta(venta);
		logger.info("venta() : fin",nombreClase);
	}
	
	public MigracionPrepagoPostpagoDTO migraPrepagoAPostpago(MigracionDTO entrada){
		System.out.println("MigracionPrepagoPostpagoDTO INICIO migraPrepagoAPostpago");
		
		
		this.entradaGlobal = entrada;
		ejecucion.setCodError("0");
		ejecucion.setDesError("Abonado traspasado exitosamente");
		
		try{
			this.getParametrosBD();
			System.out.println("MigracionPrepagoPostpagoDTO lectura de parametros BD");
		}catch(GeneralException e1){
			ejecucion = new MigracionPrepagoPostpagoDTO();
			ejecucion.setCodError(e1.getCodigo());
			ejecucion.setDesError(e1.getDescripcionEvento());
			ejecucion.setNumEvento(new Integer(String.valueOf(e1.getCodigoEvento())));
			ejecucion.setNumAbonado(null);
			ejecucion.setNumOOSS(null);
			ejecucion.setNumVenta(null);
			e1.printStackTrace();
			return ejecucion;
		}
		
		try{
			clienteSigaDTO = new ClienteSIGADTO();
			clienteSigaDTO.setCodigoCliente(String.valueOf(entrada.getCodCliente()));
			this.creacionUsuario(clienteSigaDTO);
			System.out.println("MigracionPrepagoPostpagoDTO Creacion de usuario");
		}catch(GeneralException e2){
			ejecucion = new MigracionPrepagoPostpagoDTO();
			ejecucion.setCodError(e2.getCodigo());
			ejecucion.setDesError(e2.getDescripcionEvento());
			ejecucion.setNumEvento(new Integer(String.valueOf(e2.getCodigoEvento())));
			ejecucion.setNumAbonado(null);
			ejecucion.setNumOOSS(null);
			ejecucion.setNumVenta(null);
			e2.printStackTrace();
			return ejecucion;
		}
		
		try{
			this.insertaAbonado(entrada);
			ejecucion.setNumAbonado(abonado.getNumAbonado());
			System.out.println("MigracionPrepagoPostpagoDTO Creacion de abonado");
		}catch(GeneralException e3){
			ejecucion = new MigracionPrepagoPostpagoDTO();
			ejecucion.setCodError(e3.getCodigo());
			ejecucion.setDesError(e3.getDescripcionEvento());
			ejecucion.setNumEvento(new Integer(String.valueOf(e3.getCodigoEvento())));
			ejecucion.setNumAbonado(null);
			ejecucion.setNumOOSS(null);
			ejecucion.setNumVenta(null);
			e3.printStackTrace();
			return ejecucion;
		}

		try{
			this.ingresaEquipo();
			System.out.println("MigracionPrepagoPostpagoDTO Equipo");
		}catch(GeneralException e4){
			ejecucion = new MigracionPrepagoPostpagoDTO();
			ejecucion.setCodError(e4.getCodigo());
			ejecucion.setDesError(e4.getDescripcionEvento());
			ejecucion.setNumEvento(new Integer(String.valueOf(e4.getCodigoEvento())));
			ejecucion.setNumAbonado(null);
			ejecucion.setNumOOSS(null);
			ejecucion.setNumVenta(null);
			e4.printStackTrace();
			return ejecucion;
		}	
		
		try{
			this.serviciosSuplementarios();
			System.out.println("MigracionPrepagoPostpagoDTO servicios suplementarios");
		}catch(GeneralException e6){
			ejecucion = new MigracionPrepagoPostpagoDTO();
			ejecucion.setCodError(e6.getCodigo());
			ejecucion.setDesError(e6.getDescripcionEvento());
			ejecucion.setNumAbonado(null);
			ejecucion.setNumOOSS(null);
			ejecucion.setNumVenta(null);
			e6.printStackTrace();
			return ejecucion;
		}
		
		try{
			this.venta();
			ejecucion.setNumVenta(new Long(venta.getNumVenta().intValue()));
			System.out.println("MigracionPrepagoPostpagoDTO venta");
		}catch(GeneralException e7){
			ejecucion = new MigracionPrepagoPostpagoDTO();
			ejecucion.setCodError(e7.getCodigo());
			ejecucion.setDesError(e7.getDescripcionEvento());
			ejecucion.setNumEvento(new Integer(String.valueOf(e7.getCodigoEvento())));
			ejecucion.setNumAbonado(null);
			ejecucion.setNumOOSS(null);
			ejecucion.setNumVenta(null);
			e7.printStackTrace();
			return ejecucion;
		}

		//agregado
//		DESCOMENTAR!!!!!!!!!!!!!!!!
		try{
			this.InscripcionDirecciones(abonado);
			System.out.println("MigracionPrepagoPostpagoDTO Inscripcion Direcciones");
		}catch(GeneralException e11){
			ejecucion = new MigracionPrepagoPostpagoDTO();
			ejecucion.setCodError(e11.getCodigo());
			ejecucion.setDesError(e11.getDescripcionEvento());
			ejecucion.setNumEvento(new Integer(String.valueOf(e11.getCodigoEvento())));
			ejecucion.setNumAbonado(null);
			ejecucion.setNumOOSS(null);
			ejecucion.setNumVenta(null);
			e11.printStackTrace();
			return ejecucion;
		} //DESCOMENTAR DESPUES DE SOLUCIONAR PROBLEMA
		
		try{
			this.movimientos();
			System.out.println("MigracionPrepagoPostpagoDTO movimiento");
		}catch(GeneralException e8){
			ejecucion = new MigracionPrepagoPostpagoDTO();
			ejecucion.setCodError(e8.getCodigo());
			ejecucion.setDesError(e8.getDescripcionEvento());
			ejecucion.setNumEvento(new Integer(String.valueOf(e8.getCodigoEvento())));
			ejecucion.setNumAbonado(null);
			ejecucion.setNumOOSS(null);
			ejecucion.setNumVenta(null);
			e8.printStackTrace();
			return ejecucion;
		}
		
		try{
			this.bajaAbonadoPrepago();
			System.out.println("MigracionPrepagoPostpagoDTO bajaAbonadoPrepago");
		}catch(GeneralException e9){
			ejecucion = new MigracionPrepagoPostpagoDTO();
			ejecucion.setCodError(e9.getCodigo());
			ejecucion.setDesError(e9.getDescripcionEvento());
			ejecucion.setNumEvento(new Integer(String.valueOf(e9.getCodigoEvento())));
			ejecucion.setNumAbonado(null);
			ejecucion.setNumOOSS(null);
			ejecucion.setNumVenta(null);
			e9.printStackTrace();
			return ejecucion;
		}
		
		try{
			this.registraOOSS();
			ejecucion.setNumOOSS(ooss.getNroOOSS());
			System.out.println("MigracionPrepagoPostpagoDTO registro de OOSS");
		}catch(GeneralException e10){
			ejecucion = new MigracionPrepagoPostpagoDTO();
			ejecucion.setCodError(e10.getCodigo());
			ejecucion.setDesError(e10.getDescripcionEvento());
			ejecucion.setNumEvento(new Integer(String.valueOf(e10.getCodigoEvento())));
			ejecucion.setNumAbonado(null);
			ejecucion.setNumOOSS(null);
			ejecucion.setNumVenta(null);
			e10.printStackTrace();
			return ejecucion;
		}
		
		return ejecucion;
	}
	
	//inicio
	public void bajaAbonadoPrepago()throws GeneralException{
		BajaAbonadoPrepagoBO bajaBO = new BajaAbonadoPrepagoBO();
//			if(!bajaBO.getAbonadoMigrado(abonado).booleanValue()){
//				throw new GeneralException("ERR.01166",1166,global.getValor("ERR.01166"));//integrar en properties
//			}
		//bajaBO.getNumAbonadoAboamist(abonado);
		migracionBO.getDatosAbonado(abonado);//obtiene numAbonado de ga_aboamist
		abonado.setCodCausaBaja(parametros.getCausaBaja());
		if ("AHORRO".equalsIgnoreCase(abonado.getUsoLinea()))//HIBRIDO
			abonado.setCodSituacion(global.getValor("OOSS.Migracion.prepago.hibrido.codSituacion"));
		else
			abonado.setCodSituacion(global.getValor("OOSS.Migracion.prepago.postpago.codSituacion"));
		
		bajaBO.updAbonadoPrepago(abonado);//debe recivir el numero abonado de ga_aboamist
		bajaBO.bajaServSuplabo(abonado);//numero abonado en ga_aboamist
	
	}

	/**
	 * Genera el numero de contrato para 
	 * @author mwn50746
	 * @param equipoDTO
	 * @throws GeneralException
	 */
	public void numeroContrato()throws GeneralException
	{
		migracionBO.getNumContrato(abonado);
		String centro = abonado.getNumContrato();
		StringBuffer cero = new StringBuffer();
		String numero = null;
		Long largo = new Long(centro.length());
		Long ceros = new Long(9L -largo.longValue());
		Calendar fecha = Calendar.getInstance();
		String ano = String.valueOf(fecha.get(java.util.Calendar.YEAR));
		ano = ano.substring(2);
		if(ceros.longValue() <= 0){
			numero = "CL-"+centro+"-"+ano+"-00000";
		}else{
			for(int i = 0; i < ceros.longValue() ; i++){
				numero = cero.append("0") + centro;
			}
			numero = "CL-" + numero + "-" + ano + "-00000";
		}
		abonado.setNumContrato(numero);
	}//Fin: forma el numero de contrato
	
	public String completaCeros(Integer entero, int ceros){
		String retorno = String.valueOf(entero);
		
		if(ceros > 0){
			for(int i = retorno.length(); i < ceros; i++){
				retorno = "0" + retorno;
			}
		}
		return retorno;
	}
	
	public void movimientos() throws GeneralException
	{
		ServiciosSuplementariosDTO servicioSuplementarioDTO = new ServiciosSuplementariosDTO();

		if( "POSTPAGO".equals(abonado.getUsoLinea())){

		//	 inicio movimientos POSTPAGO
		//	 inicio movimiento de baja
			migracionBO.getDatosAbonado(abonado);
			
			//Se rescata servicios suplementarios del abonado antiguo.
			servicioSuplementarioDTO = migracionBO.getCadenaServSuplementarios(abonado, "antiguo");
			
			String cadenaBajaPrepago = "";
			
			try{
				for (int i = 0; i < servicioSuplementarioDTO.getCadenaSS().length(); i = i + 6){
					cadenaBajaPrepago = cadenaBajaPrepago + servicioSuplementarioDTO.getCadenaSS().substring(i, i +2) + "0000";
				}
			}catch(IndexOutOfBoundsException ioe){
				ioe.printStackTrace();
			}
			
			servicioSuplementarioDTO.setCadenaSS(cadenaBajaPrepago);
			
			System.out.println("servicioSuplementarioDTO.getCadenaSS()=[" + servicioSuplementarioDTO.getCadenaSS() + "]");
			
			movimiento.setCodServSupl(servicioSuplementarioDTO.getCadenaSS());
			
			movimiento.setNumAbonado(abonado.getNumAbonado());
			movimiento.setNomUsuario(abonado.getNomUsuarOra());
			movimiento.setCodCentral(new Long(abonado.getCodCentral().longValue()));
			movimiento.setNumCelular(new Long(abonado.getNumCelular()));
			movimiento.setNumSerie(new Long(abonado.getNumSerieSimcard()));
			movimiento.setCodActabo(parametrosProperties.getActaboBajaPrepago()); //OOSS.Migracion.prepago.postpago.actabo.baja.prepago
			movimiento.setNumImei(new Long(abonado.getNumImei()));
			movimiento.setCarga(null);
			migracionBO.insertaMovimiento(movimiento);
		//	fin movimiento de baja
		//	movimiento para alta postpago
			movimiento.setCodServSupl(null);
			movimiento.setNumAbonado(ejecucion.getNumAbonado());
			movimiento.setNomUsuario(abonado.getNomUsuarOra());
			movimiento.setCodCentral(new Long(abonado.getCodCentral().longValue()));
			movimiento.setNumCelular(new Long(abonado.getNumCelular()));
			movimiento.setNumSerie(new Long(abonado.getNumSerieSimcard()));
			movimiento.setCodActabo(parametrosProperties.getActaboAltaPospago()); //OOSS.Migracion.prepago.postpago.actabo.alta.postpago
			movimiento.setNumImei(new Long(abonado.getNumImei()));
			movimiento.setCarga(null);
			migracionBO.insertaMovimiento(movimiento);
			
//			movimiento SS
			movimiento.setCodActabo(global.getValor("OOSS.Migracion.prepago.postpago.actabo.alta.servicioSuplementario"));
			Long numAbonadoAnt = abonado.getNumAbonado();
			abonado.setNumAbonado(ejecucion.getNumAbonado());
			//servicioSuplementarioDTO = migracionBO.getCadenaServSuplementarios(abonado, "nuevo");
//			movimiento.setCodServSupl(servicioSuplementarioDTO.getCadenaSS());
			movimiento.setCodServSupl(this.codServicio);
			abonado.setNumAbonado(numAbonadoAnt);			
			movimiento.setCarga(null);
			movimiento.setCodServSupl(codServicio);
			
			if (codServicio.length() > 0){
				migracionBO.insertaMovimiento(movimiento);
			}
			
	//	fin movimientos alta POSTPAGO
		}else if("AHORRO".equals(abonado.getUsoLinea())){
		//	 inicio movimientos HIBRIDO
		//	movimiento para hibrido
			movimiento.setNumAbonado(ejecucion.getNumAbonado());
			movimiento.setNomUsuario(abonado.getNomUsuarOra());
			movimiento.setCodCentral(new Long(abonado.getCodCentral().longValue()));
			movimiento.setNumCelular(new Long(abonado.getNumCelular()));
			movimiento.setNumSerie(new Long(abonado.getNumSerieSimcard()));
			movimiento.setCodActabo(parametrosProperties.getActaboAltaHibrido()); //OOSS.Migracion.prepago.postpago.actabo.alta.hibrido
			movimiento.setNumImei(new Long(abonado.getNumImei()));
			movimiento.setPlan(this.codPlanComverse);
			
			//LLamar al bo que trae el valor del plan
			ValorPlanDTO valorPlanDTO = new ValorPlanDTO();
			valorPlanDTO.setCodPlanTarif(entradaGlobal.getCodPlanTarif());
			valorPlanDTO.setNumAbonado(abonado.getNumAbonado().toString());
			valorPlanDTO.setCodOficina(entradaGlobal.getCodOficina());
			valorPlanDTO.setCodCliente(entradaGlobal.getCodCliente().toString());
			valorPlanDTO.setCodCiclo(abonado.getCodCiclo().toString());
			
			datosGeneralesDTO.setNomParametro(parametrosProperties.getCodCatTribut());
			datosGeneralesDTO.setValorParametro(null);
			migracionBO.obtieneParametro(datosGeneralesDTO);
			valorPlanDTO.setCatImpClie(datosGeneralesDTO.getValorParametro());
			
			movimiento.setValorPlan(migracionBO.obtencionValorPlan(valorPlanDTO));
			
			movimiento.setCarga( parametros.getCarga() == null ? null : new Long(parametros.getCarga()));
			migracionBO.insertaMovimiento(movimiento);
			
			movimiento.setPlan(null);
			movimiento.setValorPlan(null);
			//movimiento SS
			Long numAbonadoAnt = abonado.getNumAbonado();
			abonado.setNumAbonado(ejecucion.getNumAbonado());
			//servicioSuplementarioDTO = migracionBO.getCadenaServSuplementarios(abonado, "nuevo");
			//movimiento.setCodServSupl(servicioSuplementarioDTO.getCadenaSS());
			
			abonado.setNumAbonado(numAbonadoAnt);
			movimiento.setCodActabo(global.getValor("OOSS.Migracion.prepago.postpago.actabo.alta.servicioSuplementario"));
			movimiento.setCodServSupl(this.codServicio);
			movimiento.setCarga(null);
			if (codServicio.length() > 0){
				migracionBO.insertaMovimiento(movimiento);
			}
		//fin moviminetos HIBRIDO
		}
	}
	
	public void InscripcionDirecciones(AbonadoVtaDTO abonado)throws GeneralException{
		migracionBO.inscripcionDirecciones(abonado);
	}
	
	
	
	public ResultadoValidacionDatosMigracionDTO validaDatos(MigracionDTO datosMigracionClienteDTO) throws GeneralException {
		logger.info("ValidacionClientePostpagoSrv.validaDatos:Inicio", nombreClase);
		String codError = null;
		String desError = null;
		String imei =datosMigracionClienteDTO.getImei();
		
		ResultadoValidacionDatosMigracionDTO resultadoValidacion = null;
		
		try{
						
			if(datosMigracionClienteDTO.getIndProcEqTerminal().equals("E")){
				datosMigracionClienteDTO.setImei("0");
			}
			
			resultadoValidacion = validacionBO.validacionEstadoDatosExistentes(datosMigracionClienteDTO);
			
			if(!resultadoValidacion.isResultadoVariablesExistentes()){
				String parametroErr = null;
				int error = Integer.parseInt(resultadoValidacion.getCodigoError());
				if(error == 1)
					parametroErr = " codCliente";
				
				if(error == 2)
					parametroErr = " codPlanTarif";
				
				if(error == 3)
					parametroErr = " numCelular";
				
				if(error == 4)	
					parametroErr = " imei";
				
				if(error == 5)	
					parametroErr = " nomUsuarioVendedor";
		
				if(error == 6)
					parametroErr = " codOficina";
				
				if(error == -1){
					resultadoValidacion.setCodigoError("ERR.0999");
					resultadoValidacion.setMensajeError(global.getValor("ERR.0999"));
					
					return resultadoValidacion;
				}

			
				resultadoValidacion.setCodigoError("ERR.0993");
				resultadoValidacion.setMensajeError(global.getValor("ERR.0993") + parametroErr );
				
				return resultadoValidacion;
			}	
		
			
			
			
			resultadoValidacion = validacionBO.validacionSituacionAbonadoAAA(datosMigracionClienteDTO);

			
			if (!resultadoValidacion.isResultadoNumeroCelular()){
				resultadoValidacion.setCodigoError("ERR.0988");
				resultadoValidacion.setMensajeError(global.getValor("ERR.0988"));
				return resultadoValidacion;
			}
			
			
			
			
			datosMigracionClienteDTO.setImei(imei);
			
			
			if("E".equals(datosMigracionClienteDTO.getIndProcEqTerminal())){
				resultadoValidacion = validacionBO.validacionEstadoIMEIVigente(datosMigracionClienteDTO);
			}
			
			if(datosMigracionClienteDTO.getIndProcEqTerminal().equals("E")){
				if (!resultadoValidacion.isResultadoIMEI()){
					resultadoValidacion.setCodigoError("ERR.0991");
					resultadoValidacion.setMensajeError(global.getValor("ERR.0991"));
					return resultadoValidacion;
				}			
			}else{
				resultadoValidacion.setResultadoIMEI(true);
			}
			
			
			
			resultadoValidacion = validacionBO.validacionEstadoClienteSinAbonados(datosMigracionClienteDTO);
			
			if (!resultadoValidacion.isResultadoCodCliente()){
				resultadoValidacion.setCodigoError("ERR.0989");
				resultadoValidacion.setMensajeError(global.getValor("ERR.0989"));
				return resultadoValidacion;
			}
			
			
			resultadoValidacion = validacionBO.validacionEstadoPlanVigente(datosMigracionClienteDTO);
			
			if (!resultadoValidacion.isResultadoPlanTarifario()){
				resultadoValidacion.setCodigoError("ERR.0990");
				resultadoValidacion.setMensajeError(global.getValor("ERR.0990"));
				return resultadoValidacion;
			}
			
			
			
			resultadoValidacion = validacionBO.validacionEstadoVendedorVigente(datosMigracionClienteDTO);
			
			if (!resultadoValidacion.isResultadoVendedor()){
				resultadoValidacion.setCodigoError("ERR.0992");
				resultadoValidacion.setMensajeError(global.getValor("ERR.0992"));
				return resultadoValidacion;
			}		
			
			
		}  catch (Exception e) {
			if (e instanceof GeneralException) {
				GeneralException ex = (GeneralException) e;
				codError = ex.getCodigo();
				desError = ex.getDescripcionEvento();
			}

			//if(datosMigracionClienteDTO==null){
				resultadoValidacion.setCodigoError(codError);
				resultadoValidacion.setMensajeError(desError);
			
		} 
		
		System.out.println("codError: "+resultadoValidacion.getCodigoError());
		System.out.println("mensaje error: "+resultadoValidacion.getMensajeError());
		logger.info("ValidacionClientePostpagoSrv.validaDatos:Fin", nombreClase);
		return resultadoValidacion;
	}
	
}

