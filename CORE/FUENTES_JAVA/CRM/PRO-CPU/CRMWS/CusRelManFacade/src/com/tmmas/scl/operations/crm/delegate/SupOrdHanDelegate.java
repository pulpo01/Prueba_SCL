package com.tmmas.scl.operations.crm.delegate;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.UsuarioDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.CITIPORSERVDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AuditoriaDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AuditoriaResponseDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.GedCodigosDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.GedCodigosListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ParametroSerializableDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProcesoProductoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.RespuestaDTO;
import com.tmmas.scl.operations.crm.delegate.helper.FacadeMaker;
import com.tmmas.scl.operations.crm.delegate.helper.Global;
import com.tmmas.scl.operations.crm.o.csr.supordhan.common.exception.SupOrdHanException;

public class SupOrdHanDelegate 
{
	private final Logger logger = Logger.getLogger(SupOrdHanDelegate.class);	
	private Global global=Global.getInstance(); 
	private FacadeMaker facadeMaker=FacadeMaker.getInstance();
	private ParametroSerializableDTO process;
//	---------------------------------------------------------------------------------------------------------------	
	public SupOrdHanDelegate()
	{
		String log = global.getValor("delegate.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);		
	}
//	---------------------------------------------------------------------------------------------------------------	
	public void crearProceso(ParametroSerializableDTO proceso) throws SupOrdHanException
	{
		try 
		{
			proceso.setEstadoProceso("INSCRITO");
			this.process=facadeMaker.getSupOrdHanFacade().nuevoProceso(proceso);			
		}
		catch(Exception e) 
		{
			throw new SupOrdHanException(e);		
		}
	}
//---------------------------------------------------------------------------------------------------------------	
	public void inscribeProceso(String nuevoEstado,byte[] objetoSerializado) throws SupOrdHanException
	{
		this.process.setEstadoProceso(nuevoEstado);
		this.process.setObjetoSerializado(objetoSerializado);
		try 
		{			
			facadeMaker.getSupOrdHanFacade().inscribeProceso(this.process);			
		}catch(SupOrdHanException e){
			throw e;
		}
		catch(Exception e) 
		{
			throw new SupOrdHanException(e);		
		}
	}
//	---------------------------------------------------------------------------------------------------------------
	public void inscribeProceso(String nuevoEstado) throws SupOrdHanException
	{
		this.process.setEstadoProceso(nuevoEstado);		
		try 
		{			
			facadeMaker.getSupOrdHanFacade().inscribeProceso(this.process);			
		}catch(SupOrdHanException e){
			throw e;
		}
		catch(Exception e) 
		{
			throw new SupOrdHanException(e);		
		}
	}
	
//	---------------------------------------------------------------------------------------------------------------

	public ParametroSerializableDTO getProcess() {
		return process;
	}
	
//	---------------------------------------------------------------------------------------------------------------		
	public SecuenciaDTO obtenerSecuencia(SecuenciaDTO secuencia) throws SupOrdHanException
	{
		logger.debug("obtenerSecuencia():start");
		SecuenciaDTO retorno = secuencia;
		try 
		{	
			logger.debug("obtenerSecuencia():antes");
			retorno = facadeMaker.getSupOrdHanFacade().obtenerSecuencia(secuencia);
			logger.debug("obtenerSecuencia():despues");
		}catch(SupOrdHanException e){
			throw e;
		}
		catch(Exception e) 
		{
			logger.debug("Exception", e);
			throw new SupOrdHanException(e);		
		}
		logger.debug("obtenerSecuencia():start");
		return retorno;
	}
	 
//	---------------------------------------------------------------------------------------------------------------		
	public CITIPORSERVDTO obtenerTiporserv(CITIPORSERVDTO secuencia) throws SupOrdHanException
	{
		CITIPORSERVDTO retorno = null;
		try 
		{			
			retorno= facadeMaker.getSupOrdHanFacade().obtenerTiporserv(secuencia);			
		}catch(SupOrdHanException e){
			throw e;
		}
		catch(Exception e) 
		{
			throw new SupOrdHanException(e);		
		}
		return retorno;
	}
	
	public ParametroDTO obtenerParametroGeneral(ParametroDTO param)throws SupOrdHanException
	{
		ParametroDTO retorno = null;
		try 
		{			
			retorno =facadeMaker.getSupOrdHanFacade().obtenerParametroGeneral(param);			
		}catch(SupOrdHanException e){
			throw e;
		}
		catch(Exception e) 
		{
			throw new SupOrdHanException(e);		
		}
		return retorno;
	}
	
	public UsuarioDTO obtenerVendedor(UsuarioDTO usuario)throws SupOrdHanException
	{
		UsuarioDTO retorno = null;
		try 
		{			
			retorno = facadeMaker.getSupOrdHanFacade().obtenerVendedor(usuario);			
		}catch(SupOrdHanException e){
			throw e;
		}
		catch(Exception e) 
		{
			throw new SupOrdHanException(e);		
		}
		return retorno;
	}
	
	public ParametroSerializableDTO nuevoProceso(ParametroSerializableDTO parametroSerializableDTO)throws SupOrdHanException
	{
		ParametroSerializableDTO retorno = null;
		try 
		{			
			retorno = facadeMaker.getSupOrdHanFacade().nuevoProceso(parametroSerializableDTO);			
		}catch(SupOrdHanException e){
			throw e;
		}
		catch(Exception e) 
		{
			throw new SupOrdHanException(e);		
		}
		return retorno;
	}
	
	
	public RetornoDTO actualizaProceso(ProcesoProductoDTO parametro) throws SupOrdHanException
	{
		RetornoDTO retorno = null;
		try 
		{			
			retorno = facadeMaker.getSupOrdHanFacade().actualizaProceso(parametro);			
		}catch(SupOrdHanException e){
			throw e;
		}
		catch(Exception e) 
		{
			throw new SupOrdHanException(e);		
		}
		return retorno;
	}
	
	public RespuestaDTO validacionesFuncionalesAuditoria(AuditoriaDTO auditoriaDTO)throws SupOrdHanException{
	
		RespuestaDTO respuestaDTO = null;
		try 
		{			
			respuestaDTO = facadeMaker.getSupOrdHanFacade().validacionesFuncionalesAuditoria(auditoriaDTO);			
		}
		catch(SupOrdHanException e){
			throw e;
		}
		catch(Exception e) 
		{
			throw new SupOrdHanException(e);		
		}
		return respuestaDTO;
	}
	
	public AuditoriaResponseDTO insertAuditoria(AuditoriaDTO auditoriaDTO)throws SupOrdHanException{
		AuditoriaResponseDTO auditoriaResponseDTO = null;
		try 
		{			
			auditoriaResponseDTO = facadeMaker.getSupOrdHanFacade().insertAuditoria(auditoriaDTO);			
		}catch(SupOrdHanException e){
			throw e;
		}
		catch(Exception e) 
		{
			throw new SupOrdHanException(e);		
		}
		return auditoriaResponseDTO;
	}
	
	public GedCodigosListDTO obtenerListaGedCodigos(GedCodigosDTO gedCodigosDTO) throws SupOrdHanException
	{
		GedCodigosListDTO retorno = null;
		try 
		{			
			retorno =facadeMaker.getSupOrdHanFacade().obtenerListaGedCodigos(gedCodigosDTO);			
		}catch(SupOrdHanException e){
			throw e;
		}
		catch(Exception e) 
		{
			throw new SupOrdHanException(e);		
		}
		return retorno;
	}

	
}
