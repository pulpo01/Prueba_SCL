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
 * 14/05/2007     Héctor Hermosilla      					Versión Inicial
 */
package com.tmmas.cl.scl.productdomain.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.scl.commonbusinessentities.dto.FormularioNumerosSMSDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.MonedaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.ProductDomainException;
import com.tmmas.cl.scl.productdomain.businessobject.dao.PrestacionDAO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.DatosGenerDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.EstadoSolicitudDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.GrupoPrestacionDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.IpDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.NivelPrestacionDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.SeguroDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.SolicitudVentaDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.TipoPrestacionDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.TipoTerminalDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.UsoDTO;
import com.tmmas.cl.scl.productdomain.businessobject.helper.Global;

public class Prestacion extends ProductComponent{
	
	private PrestacionDAO prestacionDAO  = new PrestacionDAO();
	private static Category cat = Category.getInstance(Prestacion.class);
	Global global = Global.getInstance();
	
	public GrupoPrestacionDTO[] getGruposPrestacion()	
		throws ProductDomainException
	{
		GrupoPrestacionDTO[] resultado ;
		cat.debug("Inicio:getGruposPrestacion()");
		resultado = prestacionDAO.getGruposPrestacion(); 
		cat.debug("Fin:getGruposPrestacion()");
		return resultado;    	
    }//fin getGruposPrestacion
	
	public TipoPrestacionDTO[] getTipoPrestacion(String codGrupoPrestacion, String tipoCliente)	
		throws ProductDomainException
	{
		TipoPrestacionDTO[] resultado ;
		cat.debug("Inicio:getTipoPrestacion()");
		resultado = prestacionDAO.getTiposPrestacion(codGrupoPrestacion, tipoCliente); 
		cat.debug("Fin:getTipoPrestacion()");
		return resultado;    	
	}//fin getGruposPrestacion
	
	public UsoDTO[] getUsos(UsoDTO entrada)	
		throws ProductDomainException
	{
		UsoDTO[] resultado ;
		cat.debug("Inicio:getUsos()");
		resultado = prestacionDAO.getUsos(entrada); 
		cat.debug("Fin:getUsos()");
		return resultado;    	
	}//fin getGruposPrestacion
	
	
	public SeguroDTO[] getSeguros()	
		throws ProductDomainException
	{
		SeguroDTO[] resultado ;
		cat.debug("Inicio:getSeguros()");
		resultado = prestacionDAO.getSeguros(); 
		cat.debug("Fin:getSeguros()");
		return resultado;    	
	}//fin getSeguros
	
	public Long getIndSeguro(Long entrada)	
		throws ProductDomainException
	{
		cat.debug("Inicio:getIndSeguro()");
		Long resultado = prestacionDAO.getIndSeguro(entrada); 
		cat.debug("Fin:getIndSeguro()");
		return resultado;    	
	}//fin getIndSeguro
	
	public void generarDatosIP(IpDTO entrada)
		throws ProductDomainException
	{
		cat.debug("Inicio:generarDatosIP()");
		prestacionDAO.generarDatosIP(entrada); 
		cat.debug("Fin:generarDatosIP()");		
	}//fin getIndSeguro
	
	public void insertaSeguroAbonado(SeguroDTO entrada)
		throws ProductDomainException
	{
		cat.debug("Inicio:insertaSeguroAbonado()");
		prestacionDAO.insertaSeguroAbonado(entrada); 
		cat.debug("Fin:insertaSeguroAbonado()");		
	}//fin insertaSeguroAbonado
	
	public SeguroDTO obtieneDatosSeguro(SeguroDTO entrada)
		throws ProductDomainException
	{
		cat.debug("Inicio:obtieneDatosSeguro()");
		SeguroDTO resultado = prestacionDAO.obtieneDatosSeguro(entrada); 
		cat.debug("Fin:obtieneDatosSeguro()");		
		return resultado;
	}//fin obtieneDatosSeguro
	
	public TipoTerminalDTO[] listarTiposTerminal(String codTecnologia)
		throws ProductDomainException
	{
		cat.debug("Inicio:listarTiposTerminal()");
		TipoTerminalDTO[] resultado = prestacionDAO.listarTiposTerminal(codTecnologia); 
		cat.debug("Fin:listarTiposTerminal()");		
		return resultado;
	}//fin listarTiposTerminal
	
	public MonedaDTO[] listarMonedas()
		throws ProductDomainException
	{
		cat.debug("Inicio:listarMonedas()");
		MonedaDTO[] resultado = prestacionDAO.listarMonedas(); 
		cat.debug("Fin:listarMonedas()");		
		return resultado;
	}//fin listarTiposTerminal
	
	public TipoPrestacionDTO getDatosPrestacion(String codPrestacion)
		throws ProductDomainException
	{
		cat.debug("Inicio:getDatosPrestacion()");
		TipoPrestacionDTO resultado = prestacionDAO.getDatosPrestacion(codPrestacion); 
		cat.debug("Fin:getDatosPrestacion()");
		return resultado;    	
	}//fin getDatosPrestacion
	
	public void insertaCargoRecurrenteSeguro(SeguroDTO seguro)
		throws ProductDomainException
	{
		cat.debug("Inicio:insertaCargoRecurrenteSeguro()");
		prestacionDAO.insertaCargoRecurrenteSeguro(seguro); 
		cat.debug("Fin:insertaCargoRecurrenteSeguro()");		    	
	}//fin insertaCargoRecurrenteSeguro
	
	public DatosGenerDTO getCantidadCarrier(Long numVenta) 
		throws ProductDomainException
	{
		cat.debug("Inicio:getCantidadCarrier()");
		DatosGenerDTO resultado = prestacionDAO.getCantidadCarrier(numVenta); 
		cat.debug("Fin:getCantidadCarrier()");
		return resultado;  
	}
	
	public void guardarSolicitudVenta(SolicitudVentaDTO solicitud)
		throws ProductDomainException
	{
		cat.debug("Inicio:guardarSolicitudVenta()");
		prestacionDAO.guardarSolicitudVenta(solicitud); 
		cat.debug("Fin:guardarSolicitudVenta()");		
	}//fin guardarSolicitudVenta
	
	public void actualizaSolVentaForm(Long numVenta)	
		throws ProductDomainException
	{
		cat.debug("Inicio:actualizaSolVenta()");
		prestacionDAO.actualizaSolVentaForm(numVenta); 
		cat.debug("Fin:actualizaSolVenta()");		
	}//fin actualizaSolVenta
	
	public void actualizaSolVentaEval(SolicitudVentaDTO entrada)
		throws ProductDomainException
	{
		cat.debug("Inicio:actualizaSolVentaEval()");
		prestacionDAO.actualizaSolVentaEval(entrada); 
		cat.debug("Fin:actualizaSolVentaEval()");		
	}//fin actualizaSolVentaEval
	
	public EstadoSolicitudDTO[] listarEstadosSolicitud(SolicitudVentaDTO entrada)
		throws ProductDomainException
	{
		cat.debug("Inicio:listarEstadosSolicitud()");
		EstadoSolicitudDTO[] resultado = prestacionDAO.listarEstadosSolicitud(entrada); 
		cat.debug("Fin:listarEstadosSolicitud()");		
		return resultado;
	}//fin actualizaSolVentaEval
	
	public NivelPrestacionDTO[] obtieneNivelesPrestacion(NivelPrestacionDTO entrada)	
		throws ProductDomainException
	{
		cat.debug("Inicio:obtieneNivelesPrestacion()");
		NivelPrestacionDTO[] resultado = prestacionDAO.obtieneNivelesPrestacion(entrada); 
		cat.debug("Fin:obtieneNivelesPrestacion()");		
		return resultado;		
	}
	
	public void insertaNumerosSMS(FormularioNumerosSMSDTO entrada)
		throws ProductDomainException
	{
		cat.debug("Inicio:insertaNumerosSMS()");
		prestacionDAO.insertaNumerosSMS(entrada); 
		cat.debug("Fin:insertaNumerosSMS()");		
	}//fin insertaNumerosSMS
	
	public void existeNumeroSMS(Long entrada)
		throws ProductDomainException
	{
		cat.debug("Inicio:existeNumeroSMS()");
		prestacionDAO.existeNumeroSMS(entrada); 
		cat.debug("Fin:existeNumeroSMS()");		
	}//fin existeNumeroSMS
	
	
}//fin class Prestacion
