package com.tmmas.scl.operations.crm.fab.cusintman.web.helper;

import java.rmi.RemoteException;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.ProductDomain.dto.BodegaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CausaCamSerieDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CentralDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CuotaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.MesesProrrogasDTO;
import com.tmmas.scl.framework.ProductDomain.dto.ModalidadPagoDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SerieDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TecnologiaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TipoDeContratoDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TipoTerminalDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.MensajeRetornoDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.SesionDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.UsuarioSistemaDTO;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ArticuloDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ParametrosCambioSerieDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.SimcardDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.TerminalDTO;
import com.tmmas.scl.operations.crm.fab.cusintman.web.delegate.CambioSerieBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cusintman.web.form.CambioDeSerieForm;
import com.tmmas.scl.operations.crm.fab.customerinterfacemanagement.common.exception.CusIntManException;
import uk.ltd.getahead.dwr.WebContextFactory;

public class CusIntManDWRController {

	private CambioSerieBussinessDelegate delegate = CambioSerieBussinessDelegate.getInstance();
	private Global global = Global.getInstance();
	private Logger logger=Logger.getLogger(CusIntManDWRController.class);
	
	String codigoPrograma = global.getValor("codigoPrograma");
    String versionPrograma = global.getValor("versionPrograma");
	
//	 ------------------------------------------------------------------------------------
	
	public BodegaDTO[] obtenerBodegas(SesionDTO session) throws CusIntManException {
		BodegaDTO[] resultado = null;

		try	{
			delegate.obtenerBodegas(session);
		}
		catch (CusIntManException e)	{
			throw new CusIntManException(e);
		}
		
		return resultado;
		
	}	// obtenerBodegas
	
//	 ------------------------------------------------------------------------------------
	
	public MesesProrrogasDTO[] obtenerMesesProrroga () throws CusIntManException {
		MesesProrrogasDTO[] resultado = null;
		
		try {
			resultado = delegate.obtenerMesesProrroga();
		}catch (CusIntManException e)	{
			throw new CusIntManException(e);
		}
		
		return resultado;
		
	}	// obtenerMesesProrroga	

//	 ------------------------------------------------------------------------------------
	
	public TipoDeContratoDTO[] obtenerTiposDeContrato(String tipoContrato, TipoDeContratoDTO tipoContratoDTO, SesionDTO sessionDTO) throws CusIntManException {	

		TipoDeContratoDTO[] resultado = null;
		try {
			// Si la procedencia del equipo es Interna
			if (tipoContrato.equalsIgnoreCase("E"))	{
				// Si la procedencia del equipo es Externa entonces tomo
				// la descripcion y codigo del contrato actual de abonado para el combo
				resultado = new TipoDeContratoDTO[2];

				resultado[0] = new TipoDeContratoDTO();
				resultado[0].setCod_tipcontrato(" ");
				resultado[0].setDes_tipcontrato(" ");

				resultado[1] = new TipoDeContratoDTO();
				resultado[1].setCod_tipcontrato(tipoContratoDTO.getCod_tipcontrato());
				resultado[1].setDes_tipcontrato(tipoContratoDTO.getDes_tipcontrato());
				
				
				return resultado;				
			}
			else	{
			    Long versionProgramaLong = new Long (versionPrograma);

				logger.debug("Origen Serie:"+tipoContrato); // RRG
			    sessionDTO.setCod_programa(codigoPrograma);
			    sessionDTO.setNum_version(versionProgramaLong.longValue());

				sessionDTO.setCod_programa("T"); // RRG 08-03-2009 COL 78629
				sessionDTO.setOrigenSerie("I"); // RRG COL 07-03-2009 78629

				
				resultado = delegate.obtenerTiposDeContrato(sessionDTO);
				
				// Creo un array mas grande para agregar la opcion de la linea en blanco del combo
				TipoDeContratoDTO[] resultado2 =  new TipoDeContratoDTO[resultado.length+1];

				logger.debug("resultado2");
				resultado2[0] = new TipoDeContratoDTO();
				resultado2[0].setCod_tipcontrato(" ");
				resultado2[0].setDes_tipcontrato(" ");

				

				logger.debug("Copiando Array");
				System.arraycopy(resultado, 0, resultado2, 1, resultado.length);

				
				
				return resultado2;
			}
		}
		catch (CusIntManException e)	{
			throw new CusIntManException("Error");
		}
		
	}	// obtenerTiposDeContrato
	
//	 ------------------------------------------------------------------------------------
	
	public ModalidadPagoDTO[] obtenerModalidadPago (SesionDTO sesion, CausaCamSerieDTO causaCamSerie, String pagina, String indProcEqu)  {
		
		ModalidadPagoDTO[] resultado = null;
		
		try {
		    Long versionProgramaLong = new Long (versionPrograma);

		    sesion.setCod_programa(codigoPrograma);
		    sesion.setNum_version(versionProgramaLong.longValue());
			
		    // Verificamos primero que tenga permisos para esta causa antes||
		    // de ir a buscar las modalidades
		   // delegate.validaCausaCamSerie(sesion, causaCamSerie);
		    ParametrosCambioSerieDTO param=new ParametrosCambioSerieDTO();
		    param.setCodCausa(causaCamSerie.getCod_caucaser());
		    param.setIndProcEquipo(indProcEqu);
		    RetornoDTO retValue=this.validaSeleccionCausa(param);
		    
		    if (retValue.isResultado()){
				throw new CusIntManException(retValue.getDescripcion());
			}
		
		    if (pagina.equals("cambioSerie"))
		    	resultado = delegate.obtenerModalidadPago(sesion, causaCamSerie);
		    else
		    	resultado = delegate.obtenerModalidadPagoSimcard(sesion, causaCamSerie);
		    
			// Creo un array mas grande para agregar la opcion de la linea en blanco del combo
			ModalidadPagoDTO[] resultado2 =  new ModalidadPagoDTO[resultado.length+1];

			// Resultado sin errores 
			MensajeRetornoDTO mensajeRetorno = new MensajeRetornoDTO();
			mensajeRetorno.setCodigo(0);	// Sin error

			resultado2[0] = new ModalidadPagoDTO();
			resultado2[0].setCod_modventa(0);
			resultado2[0].setDes_modventa(" ");
			resultado2[0].setMensajeRetorno(mensajeRetorno);
			
			System.arraycopy(resultado, 0, resultado2, 1, resultado.length);

			return resultado2;
		}
		catch (CusIntManException e)	{
			
			// Armo la respuesta para que la pueda tomar el DWR, codigo de error y mensaje
			// ademas de la opcion en blanco para el listbox
			
			resultado = new ModalidadPagoDTO[1];
			
			String mensaje = new String();
			String stack = new String();
			
			MensajeRetornoDTO mensajeRetorno = new MensajeRetornoDTO();			

			if (e.getDescripcionEvento() != null) {
				mensaje = e.getDescripcionEvento();
				mensajeRetorno.setCodigo(1);	// Error de negocio
				mensajeRetorno.setMensaje(mensaje);
			}
			else if (e.getMessage()!=null){
				mensaje = e.getMessage();
				mensajeRetorno.setCodigo(1);	// Error de negocio
				mensajeRetorno.setMensaje(e.getMessage());
			}
			else	{
				// Ocurrio otro evento no de negocio, asi que recupero el stackTrace
				stack = StackTraceUtl.getStackTrace(e);
				mensaje = e.getCause().getLocalizedMessage();
				
				mensajeRetorno.setCodigo(2);	// Error de soft
				mensajeRetorno.setMensaje(mensaje + "&&&" + stack);				
			}
			 
			resultado[0] = new ModalidadPagoDTO();
			resultado[0].setMensajeRetorno(mensajeRetorno);
			resultado[0].setCod_modventa(0);
			resultado[0].setDes_modventa(" ");
			
			return resultado;
			
		} // catch
	
	}	// obtenerModalidadPago

//	 ------------------------------------------------------------------------------------
	
	public TipoTerminalDTO[] cargaComboTipoTerminal (TecnologiaDTO tecnologia) throws CusIntManException {
		
		TipoTerminalDTO[] resultado = null;
		
		try {
			resultado = delegate.obtenerTipoTerminal(tecnologia);
			
			// Creo un array mas grande para agregar la opcion de la linea en blanco del combo
			TipoTerminalDTO[] resultado2 =  new TipoTerminalDTO[resultado.length+1];

			resultado2[0] = new TipoTerminalDTO();
			resultado2[0].setDes_terminal(" ");
			resultado2[0].setTip_terminal(" ");
			
			System.arraycopy(resultado, 0, resultado2, 1, resultado.length);
			
			return resultado2;
		}catch (CusIntManException e)	{
			throw new CusIntManException(e);
		}
	
	}	// obtenerTipoTerminal

//	 ------------------------------------------------------------------------------------
	
	public CuotaDTO[] cargaComboCuotas (SesionDTO sesion, ModalidadPagoDTO modalidadPago) throws CusIntManException {
		
		CuotaDTO[] resultado = null;
		
		try {
			resultado = delegate.obtenerCuotas(sesion, modalidadPago);
			
			// Creo un array mas grande para agregar la opcion de la linea en blanco del combo
			CuotaDTO[] resultado2 =  new CuotaDTO[resultado.length+1];

			resultado2[0] = new CuotaDTO();
			resultado2[0].setDes_cuota(" ");
			resultado2[0].setCod_cuota(" ");
			
			System.arraycopy(resultado, 0, resultado2, 1, resultado.length);
			
			return resultado2;
		}catch (CusIntManException e)	{
			throw new CusIntManException(e);
		}
	
	}	// obtenerTipoTerminal

//	 ------------------------------------------------------------------------------------
	
	public CentralDTO[] cargaComboCentralHlr (SerieDTO serie, TecnologiaDTO tecnologia) throws CusIntManException {
		
		CentralDTO[] resultado = null;
		
		try {
			resultado = delegate.obtenerCentralTecnologiaHlr(serie, tecnologia);
			
			// Creo un array mas grande para agregar la opcion de la linea en blanco del combo
			CentralDTO[] resultado2 =  new CentralDTO[resultado.length+1];

			resultado2[0] = new CentralDTO();
			resultado2[0].setCod_central(0);
			resultado2[0].setNom_central(" ");
			
			System.arraycopy(resultado, 0, resultado2, 1, resultado.length);
			
			return resultado2;
		}catch (CusIntManException e)	{
			throw new CusIntManException(e);
		}
	
	}	// cargaComboCentralHlr

//	 ------------------------------------------------------------------------------------
	
	public MensajeRetornoDTO bloquearSerie ( long num_abonado, 
								 			 long cod_cliente, 
								 			 long cod_ooss, 
											 long cod_vendedor, 
											 String nom_usuario, 
											 String cod_tipcomis, 
											 String num_serie,
											 long   cod_uso,
											 String ind_causa,
											 String tip_terminal,
											 long mod_pago,
											 String cod_tecnologia,
											 String accionProceso,
											 String codTipContrato,
											 String tipoAccion
											 , String prmInterna
											 )	{
		
		// accionProceso = bloquear o desbloquear
		
		UsuarioSistemaDTO usuarioSistema = new UsuarioSistemaDTO(); 
		UsuarioAbonadoDTO usuarioAbonado = new UsuarioAbonadoDTO();
		ClienteOSSesionDTO sessionData = new ClienteOSSesionDTO();

		usuarioSistema.setNom_usuario(nom_usuario);
		usuarioSistema.setCod_tipcomis(cod_tipcomis);
		usuarioSistema.setCod_vendedor(cod_vendedor);
		
		usuarioAbonado.setNum_abonado(num_abonado);
		usuarioAbonado.setCod_cliente(cod_cliente);
		usuarioAbonado.setCod_tecnologia(cod_tecnologia);
		usuarioAbonado.setCodTipContrato(codTipContrato);
		
		sessionData.setCodOrdenServicio(cod_ooss);

		SerieDTO serie = new SerieDTO();
		serie.setNum_serie(num_serie);
		serie.setCod_uso(cod_uso);
	    
		CausaCamSerieDTO causa = new CausaCamSerieDTO();
		causa.setCod_caucaser(ind_causa);
		
		TipoTerminalDTO terminal = new TipoTerminalDTO(); 
		terminal.setTip_terminal(tip_terminal);
		
		ModalidadPagoDTO modalidadPago = new ModalidadPagoDTO();
		modalidadPago.setCod_modventa(mod_pago);
		
		MensajeRetornoDTO mensaje = new MensajeRetornoDTO();

		// -------------------------------------------------------------------------------------------------------------------
		mensaje.setCodigo(0);
		SerieDTO infoserie=null;
		
		
	    try		{
	    	//infoserie = delegate.reservaSimcard(accionProceso, serie, usuarioSistema, usuarioAbonado, sessionData, causa, terminal, modalidadPago,tipoAccion );
	    	
	    	infoserie = delegate.reservaSimcard(accionProceso, serie, usuarioSistema, usuarioAbonado, sessionData, causa, terminal, modalidadPago,tipoAccion,prmInterna ); // RRG
			mensaje.setCodigo(0);
	    	if (infoserie !=null)	{
	    		
	    		HttpSession session=WebContextFactory.get().getSession();
	    		
	    		session.removeAttribute("codEstAntT");
	    		session.removeAttribute("codEstAntS");
	    		mensaje.setCod_bodega(infoserie.getCod_bodega());
	    		mensaje.setCod_articulo(infoserie.getCod_articulo());
	    		mensaje.setTip_stock(infoserie.getTip_stock());
	    		mensaje.setNumMovimientoBloqDesb(infoserie.getMensajeRetorno().getNumMovimientoBloqDesb());
	    		
	    		String codEstAntT="equipo".equals(tipoAccion)?String.valueOf(infoserie.getCod_estado()):"0";
	    		String codEstAntS=!"equipo".equals(tipoAccion)?String.valueOf(infoserie.getCod_estado()):"0";
	    		if (!"0".equals(codEstAntT)){
	    			session.setAttribute("codEstAntT", codEstAntT);
	    		}
	    		
	    		if (!"0".equals(codEstAntS)){
	    			session.setAttribute("codEstAntS", codEstAntS);
	    		}
				
				session.setAttribute("serie_reservada", serie.getNum_serie()); // RRG 94740
			    logger.debug("Serie Reservada:"+serie.getNum_serie()); // RRG 94740


	    	}
	    	if (accionProceso.equals("bloquear")) {
    			mensaje.setMensaje("La serie ["+serie.getNum_serie()+"] solicitada ha sido reservada.");
    		} else
    			mensaje.setMensaje("La reserva de la serie ["+serie.getNum_serie()+"] ha sido cancelada.");
	    }
	    catch (CusIntManException ex)	{
	    	mensaje.setCodigo(1);
	    	if (ex.getDescripcionEvento()!=null)
	    		mensaje.setMensaje(ex.getDescripcionEvento());
	    	else
	    		mensaje.setMensaje(ex.getMessage());
	    } // catch
	    
		return mensaje;
		
	}  // bloquearSerie
	
//	 ------------------------------------------------------------------------------------
	
	public ArticuloDTO[] obtenerListaArticulo (ArticuloDTO articuloDTO) throws CusIntManException {
		
		ArticuloDTO[] retValue = null;
		
		try {
			retValue = delegate.obtenerListaArticulos(articuloDTO);
			
			// Creo un array mas grande para agregar la opcion de la linea en blanco del combo
			ArticuloDTO[] resultado2 =  new ArticuloDTO[retValue.length+1];
			

			resultado2[0] = new ArticuloDTO();
			resultado2[0].setDes_articulo(" ");
			resultado2[0].setTip_terminal(" ");
			
			System.arraycopy(retValue, 0, resultado2, 1, retValue.length);
			
			return resultado2;
		}catch (CusIntManException e)	{
			throw new CusIntManException(e);
		}
	
	}	// obtenerTipoTerminal
	
	
	public RetornoDTO validaSeleccionCausa(ParametrosCambioSerieDTO parametrosCambioSerieDTO)throws CusIntManException{
		RetornoDTO retValue = null;
		try {
			HttpSession session = WebContextFactory.get().getHttpServletRequest().getSession();
			UsuarioAbonadoDTO usuAbonado=(UsuarioAbonadoDTO)session.getAttribute("usuarioAbonado");
			UsuarioSistemaDTO usuarioSistema=(UsuarioSistemaDTO)session.getAttribute("usuarioSistema");
			String nomTabla=Integer.parseInt(usuAbonado.getCod_tiplan())==2?"GA_ABOCEL":"GA_ABOAMIST";
			//parametrosCambioSerieDTO.setIndProcEquipo(cambioDeSerieForm.getProcedNuevoEquipo());
			
			/**
			 * @author rlozano
			 * @description seteamos la serie del equipo : si es GSM tomamos el imei sino el num_serie
			 */
			String codTecnologia=usuAbonado.getCod_tecnologia();
			codTecnologia=codTecnologia==null?"":codTecnologia;
			
			ParametroDTO parametro=new ParametroDTO();
			parametro.setCodModulo(global.getValor("MODULO"));
			parametro.setCodProducto(Integer.parseInt(global.getValor("parametro.producto.uno")));
			parametro.setNomParametro(global.getValor("parametro.grupo.tecnologico.gsm"));
			parametro=delegate.obtenerParametroGeneral(parametro);
			parametrosCambioSerieDTO.setNumSerieEquipo(usuAbonado.getNum_imei());
			if (!codTecnologia.equals(parametro.getValor())){
				parametrosCambioSerieDTO.setNumSerieEquipo(usuAbonado.getNum_serie());
			}
			
			parametrosCambioSerieDTO.setNumAbonado(usuAbonado.getNum_abonado());
			parametrosCambioSerieDTO.setNomTabla(nomTabla);
			parametrosCambioSerieDTO.setNomUsuario(usuarioSistema.getNom_usuario());
			
			retValue = delegate.validaSeleccionCausa(parametrosCambioSerieDTO);
			    
			
		}catch (GeneralException e)	{
			throw new CusIntManException(e);
		}
		
		finally{
			retValue=retValue==null?new RetornoDTO():retValue;
		}
		return retValue;
	}
	
	public RetornoDTO desReservaSerie()throws CusIntManException{
		RetornoDTO retValue=null;
		try{
			HttpSession session=WebContextFactory.get().getSession();
			logger.debug("Exception Cargos Action se procede a cambiar estado de la serie solicitada a disponible para reserva");
			SerieDTO serie = new SerieDTO();
			CambioDeSerieForm cambioDeSerieForm=(CambioDeSerieForm)session.getAttribute("CambioDeSerieForm");
			String serieEquipo=cambioDeSerieForm==null?"":cambioDeSerieForm.getNroSerieEquip();
			serieEquipo=serieEquipo==null?"":serieEquipo;
			logger.debug("Serie Equipo ::"+serieEquipo);
			serie.setNum_serie(serieEquipo);
			if (!"".equals(serieEquipo)){
				delegate.desReservaSerie(serie);
			}
			 String serieSimcard=cambioDeSerieForm==null?"":cambioDeSerieForm.getNroSerieSim();
			 serieSimcard=serieSimcard==null?"":serieSimcard;
			 serie.setNum_serie(serieSimcard);
			if (!"".equals(serieSimcard)){
				delegate.desReservaSerie(serie);
			}
		}
		catch (Exception e){
			
		}
		return retValue;
	}
		
	public RetornoDTO desReservaSerieP(String nroSerieEquip,String nroSerieSim)throws CusIntManException{
			RetornoDTO retValue=null;
			try{
				
				logger.debug("Exception Cargos Action se procede a cambiar estado de la serie solicitada a disponible para reserva");
				SerieDTO serie = new SerieDTO();
				String serieEquipo=nroSerieEquip;
				serieEquipo=serieEquipo==null?"":serieEquipo;
				logger.debug("Serie Equipo ::"+serieEquipo);
				serie.setNum_serie(serieEquipo);
				if (!"".equals(serieEquipo)){
					delegate.desReservaSerie(serie);
				}
				 String serieSimcard=nroSerieSim;
				 serieSimcard=serieSimcard==null?"":serieSimcard;
				 serie.setNum_serie(serieSimcard);
				if (!"".equals(serieSimcard)){
					delegate.desReservaSerie(serie);
				}
			}
			catch (Exception e){
				
			}
			return retValue;
	}
	
	public RetornoDTO validaSerieExternaEquipo (SerieDTO serie) throws GeneralException{
		logger.debug("validaSerieExternaEquipo():start");
		RetornoDTO retorno = new RetornoDTO();
		try {
			retorno = delegate.validaSerieExternaEquipo(serie); 
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CusIntManException[" + loge + "]");
			//throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
			retorno.setDescripcion(e.getDescripcionEvento());
		}
		logger.debug("validaSerieExternaEquipo():end");
		return retorno;
	}
}	// CusIntManDWRController
