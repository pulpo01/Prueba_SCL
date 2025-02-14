package com.tmmas.scl.operations.crm.fab.cusintman.web.helper;

import javax.servlet.http.HttpSession;

import uk.ltd.getahead.dwr.ExecutionContext;
import uk.ltd.getahead.dwr.WebContextBuilder;
import uk.ltd.getahead.dwr.WebContextFactory;

import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.ProductDomain.dto.BodegaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CausaCamSerieDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CentralDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CuotaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.GaAboMailTODTO;
import com.tmmas.scl.framework.ProductDomain.dto.GaServSuPlDTO;
import com.tmmas.scl.framework.ProductDomain.dto.GaServSupDefDTO;
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
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;
import com.tmmas.scl.operations.crm.fab.cusintman.web.delegate.ServiciosSuplementariosBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.customerinterfacemanagement.common.exception.CusIntManException;

public class CusIntManDWRController {

	private ServiciosSuplementariosBussinessDelegate delegate = ServiciosSuplementariosBussinessDelegate.getInstance();
	private Global global = Global.getInstance();
	
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

			    sessionDTO.setCod_programa(codigoPrograma);
			    sessionDTO.setNum_version(versionProgramaLong.longValue());
				
				resultado = delegate.obtenerTiposDeContrato(sessionDTO);
				
				// Creo un array mas grande para agregar la opcion de la linea en blanco del combo
				TipoDeContratoDTO[] resultado2 =  new TipoDeContratoDTO[resultado.length+1];

				resultado2[0] = new TipoDeContratoDTO();
				resultado2[0].setCod_tipcontrato(" ");
				resultado2[0].setDes_tipcontrato(" ");
				
				System.arraycopy(resultado, 0, resultado2, 1, resultado.length);
				
				return resultado2;
			}
		}
		catch (CusIntManException e)	{
			throw new CusIntManException("Error");
		}
		
	}	// obtenerTiposDeContrato
	
//	 ------------------------------------------------------------------------------------
	
	public ModalidadPagoDTO[] obtenerModalidadPago (SesionDTO sesion, CausaCamSerieDTO causaCamSerie, String pagina)  {
		
		ModalidadPagoDTO[] resultado = null;
		
		try {
		    Long versionProgramaLong = new Long (versionPrograma);

		    sesion.setCod_programa(codigoPrograma);
		    sesion.setNum_version(versionProgramaLong.longValue());
			
		    // Verificamos primero que tenga permisos para esta causa antes||
		    // de ir a buscar las modalidades
		    delegate.validaCausaCamSerie(sesion, causaCamSerie);
		
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
	
	public RetornoDTO getObtieneListCodServPorDef(String codServicio) throws CusIntManException{
		RetornoDTO retValue=new RetornoDTO();
		try{
			HttpSession session = WebContextFactory.get().getSession();
			GaServSupDefDTO gaServSupDefDTO = new GaServSupDefDTO();
			gaServSupDefDTO.setCodServicio(codServicio);
			gaServSupDefDTO.setTipRelacion(5);
			GaServSupDefDTO[] resultado = delegate.getObtieneListCodServPorDef(gaServSupDefDTO);
			String codServ=null;
			for (int i=0;i<resultado.length;i++){
				retValue.setResultado(true);
				codServ=codServ+"|"+resultado[i].getCodServicio();
			}
			session.setAttribute("listCodServDef", resultado);
			retValue.setDescripcion(codServ);
		}
		catch(CusIntManException e){
			retValue.setResultado(false);
			throw new CusIntManException(e);
		}
		return retValue;
	}
	
//	 ------------------------------------------------------------------------------------	
	public RetornoDTO getEstadoCorreoServSupl(String numAbonado,String codServ) throws CusIntManException{
		RetornoDTO retValue=new RetornoDTO();
		try{
			HttpSession session = WebContextFactory.get().getSession();
			GaServSuPlDTO gaServSuPlDTO = new GaServSuPlDTO();
			gaServSuPlDTO.setNumAbonado(Long.parseLong(numAbonado));
			gaServSuPlDTO.setEstado("C"); // Si el Servicio de correo se encuentra contratado se encuentra contratado
			GaServSuPlDTO resultado = delegate.getEstadoCorreoServSupl(gaServSuPlDTO);
			boolean isNullEstado=resultado==null||resultado.getEstado()==null?true:false;
			if (isNullEstado){
				retValue.setResultado(true);
				retValue.setDescripcion(null);
			}
			else{
				GaAboMailTODTO gaAboMailTODTO=new GaAboMailTODTO();
				gaAboMailTODTO.setNumAbonado(Long.parseLong(numAbonado));
				GaAboMailTODTO[] listCorreo=delegate.getAbomailTOxNumAbonado(gaAboMailTODTO);
				boolean isNulllistCorreo=listCorreo==null||listCorreo.length<1?true:false;
				if (!isNulllistCorreo){
					for (int i =0;i<listCorreo.length;i++){
						String codServDef=listCorreo[i].getCodServicio();
						long indEstado=listCorreo[i].getIndEstado();
						codServ=null;
						GaServSupDefDTO[] listCodServDef =(GaServSupDefDTO[])session.getAttribute("listCodServDef");
						
						/**
						 * Recorremos lista de servicios por ligados.
						 */
						for (int j=0;j<listCodServDef.length;j++){
							codServ=listCodServDef[j].getCodServicio();
							if (codServDef.equals(codServ)){
								/**
								 * Verificamos si el servicio de correo se encuentra activo
								 */
								if (indEstado==1){
									retValue.setDescripcion("El servicio de correo se encuentra activo para el abonado");
									break;
								}
							}
						}	
					}
				}
				
				
			}
			
		}
		catch(CusIntManException e){
			retValue.setResultado(false);
			throw new CusIntManException(e);
		}
		return retValue;
	}
	
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
											 String accionProceso)  {
		
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
	    try		{
    		delegate.reservaSimcard(accionProceso, serie, usuarioSistema, usuarioAbonado, sessionData, causa, terminal, modalidadPago );
    		mensaje.setCodigo(0);
    		if (accionProceso.equals("bloquear"))
    			mensaje.setMensaje("La serie solicitada ha sido bloqueada.");
    		else
    			mensaje.setMensaje("La serie solicitada ha sido desbloqueada.");
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
	
}	// CusIntManDWRController
