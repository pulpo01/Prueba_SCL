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
 * 19/06/2007     Héctor Hermosilla      					Versión Inicial
 */
package com.tmmas.cl.scl.customerdomain.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.scl.commonbusinessentities.commonapp.DireccionNegocioDTO;
import com.tmmas.cl.scl.commonbusinessentities.commonapp.DireccionNegocioWebDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.DatosConexionServidorDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.DatosDireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.DireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.FormularioDireccionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dao.DireccionDAO;
import com.tmmas.cl.scl.direccioncommon.commonapp.dto.DirecClienteDTO;
import com.tmmas.cl.scl.direccioncommon.commonapp.dto.DireccionesListOutDTO;

public class Direccion  {
	
	private DireccionDAO direccionDAO  = new DireccionDAO();
	private static Category cat = Category.getInstance(Direccion.class);
	
	/**
	 * Obtiene configuración de las direcciones en la operadora
	 * 
	 * @author Héctor Hermosilla 
	 * @param direccionDTO
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public DireccionDTO getConfiguracionDireccion(DireccionDTO direccionDTO) 
	throws CustomerDomainException{
		cat.debug("Inicio:getConfiguracionDireccion()");
		DireccionDTO resultado =direccionDAO.getConfiguracionDireccion(direccionDTO);
		cat.debug("Fin:getConfiguracionDireccion()");
		return resultado;
	}//fin getConfiguracionDireccion

	/**
	 * Obtiene direccion
	 * @param entrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public DireccionNegocioDTO getDireccion(DireccionNegocioDTO entrada) 
	throws CustomerDomainException{
		cat.debug("Inicio:updDireccion()");
		DireccionNegocioDTO resultado = direccionDAO.getDireccion(entrada);
		cat.debug("Fin:updDireccion()");
		return resultado;
	}//fin updDireccion
	
	/**
	 * Actualiza direccion
	 * @param entrada
	 * @return N/A
	 * @throws CustomerDomainException
	 */
	public void updDireccion(DireccionNegocioDTO entrada) 
	throws CustomerDomainException{
		cat.debug("Inicio:updDireccion()");
		direccionDAO.updDireccion(entrada);
		cat.debug("Fin:updDireccion()");
	}//fin updDireccion

	public DireccionNegocioDTO getDireccionCodigo(DireccionNegocioDTO entrada) 
	throws CustomerDomainException{
		cat.debug("Inicio:getDireccionCodigo()");
		DireccionNegocioDTO resultado = direccionDAO.getDireccionCodigo(entrada);
		cat.debug("Fin:getDireccionCodigo()");		
		return resultado;
	}//fin getDireccionCodigo
	
	/**
	 * Inserta direccion
	 * 
	 * @author Héctor Hermosilla
	 * @param entrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public void setDireccion(DireccionNegocioWebDTO entrada) 
	throws CustomerDomainException{
		cat.debug("Inicio:setDireccion()");
		direccionDAO.setDireccion(entrada);
		cat.debug("Fin:setDireccion()");
	}
	
	
	
	public DireccionesListOutDTO lstDirecCliente(DirecClienteDTO direccion) 
		throws CustomerDomainException
	{
		cat.debug("consultarDireccion():start");
		DireccionesListOutDTO direccionDTO = direccionDAO.lstDirecCliente(direccion);
		cat.debug("consultarDireccion():end");
		return direccionDTO;
    }

	public DatosDireccionDTO getCadenaLLamadaComputec() 
	throws CustomerDomainException{
		cat.debug("Inicio:getCadenaLLamadaComputec()");
		DatosDireccionDTO resultado = direccionDAO.getCadenaLLamadaComputec();
		cat.debug("Fin:getCadenaLLamadaComputec()");		
		return resultado;
	}//fin getCadenaLLamadaComputec
	
	public DatosConexionServidorDTO getDatosConexionComputec() 
	throws CustomerDomainException{
		cat.debug("Inicio:getDatosConexionComputec()");
		DatosConexionServidorDTO resultado = direccionDAO.getDatosConexionComputec();
		cat.debug("Fin:getDatosConexionComputec()");		
		return resultado;
	}//fin getDatosConexionComputec
	

	/**
	 * Valida direccion contra SCL
	 * 
	 * @author Mario Tigua
	 * @param entrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public void validaDireccion(DireccionNegocioDTO entrada) 
	throws CustomerDomainException{
		cat.debug("Inicio:validaDireccion()");
		direccionDAO.validaDireccion(entrada);
		cat.debug("Fin:validaDireccion()");
	}
	
	//Inicio P-CSR-11002 JLGN 28-04-2011
	public FormularioDireccionDTO getDireccionPrepago(String codDireccion) throws CustomerDomainException{
		cat.debug("Inicio:getDireccionPrepago()");
		FormularioDireccionDTO resultado = direccionDAO.getDireccionPrepago(codDireccion);
		cat.debug("Fin:getDireccionPrepago()");		
		return resultado;
	}//fin getCadenaLLamadaComputec
	//Fin P-CSR-11002 JLGN 28-04-2011
	
	//Inicio P-CSR-11002 JLGN 14-06-2011
	public String obtenerDirecPerCli(String codCliente) throws CustomerDomainException{
		cat.debug("Inicio:obtenerDirecPerCli()");
		String resultado = direccionDAO.obtenerDirecPerCli(codCliente);
		cat.debug("Fin:obtenerDirecPerCli()");		
		return resultado;
	}//fin getCadenaLLamadaComputec
	//Fin P-CSR-11002 JLGN 14-06-2011
	
}//fin class Direccion
