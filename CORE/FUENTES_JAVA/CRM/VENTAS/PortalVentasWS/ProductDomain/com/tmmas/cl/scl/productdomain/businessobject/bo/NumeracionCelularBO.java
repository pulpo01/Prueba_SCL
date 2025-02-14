/**
 * Copyright © 2008 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 14/07/2008 09:31     Nicol&aacute;s Contreras    		Versión Inicial 
 * 
 *
 * 
 * @author Nicolas Contreras
 * @version 1.0
 **/
package com.tmmas.cl.scl.productdomain.businessobject.bo;

import org.apache.log4j.Logger;


import com.tmmas.cl.scl.commonbusinessentities.dto.NumeroFrecuenteDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.ProductDomainException;
import com.tmmas.cl.scl.productdomain.businessobject.dao.NumeracionCelularDAO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.DatosNumeracionDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.NumeracionCelularDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.NumeroInternetDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.SeleccionNumeroCelularDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.SeleccionNumeroCelularRangoDTO;


public class NumeracionCelularBO {
	
	private final Logger logger = Logger.getLogger(NumeracionCelularBO.class);
	private NumeracionCelularDAO numeracionCelularDAO = new NumeracionCelularDAO();

	public void consultaNumeroCelularReutilizable(NumeracionCelularDTO numeracionCelularVO) 
		throws ProductDomainException 
	{
		logger.debug("consultaNumeroCelularReutilizable:start");
		numeracionCelularDAO.consultaNumeroCelularReutilizable(numeracionCelularVO);
		logger.debug("consultaNumeroCelularReutilizable:end");
	}

	public void consultaNumeroCelularReservado(NumeracionCelularDTO numeracionCelularVO) 
		throws ProductDomainException 
	{
		logger.debug("consultaNumeroCelularReservado:start");
		numeracionCelularDAO.consultaNumeroCelularReservado(numeracionCelularVO);
		logger.debug("consultaNumeroCelularReservado:end");
	}

	public void reservaNumeroCelular(NumeracionCelularDTO numeracionCelularVO) 
		throws ProductDomainException 
	{
		logger.debug("reservaNumeroCelular:start");
		numeracionCelularDAO.reservaNumeroCelular(numeracionCelularVO);
		logger.debug("reservaNumeroCelular:end");
	}

	public void insertarNumeroCelularReservado(NumeracionCelularDTO numeracionCelularVO) 
		throws ProductDomainException 
	{
		logger.debug("isertarNumeroCelularReservado:start");
		numeracionCelularDAO.insertarNumeroCelularReservado(numeracionCelularVO);
		logger.debug("insertarNumeroCelularReservado:end");
	}

	public void consultaNumeroCelularHReservado(NumeracionCelularDTO numeracionCelularVO) 
		throws ProductDomainException 
	{
		logger.debug("consultaNumeroCelularHReservado:start");
		numeracionCelularDAO.consultaNumeroCelularHReservado(numeracionCelularVO);
		logger.debug("consultaNumeroCelularHReservado:end");
	}

	public void reponerNumeracion(NumeracionCelularDTO numeracionCelularVO) 
		throws ProductDomainException
	{
		logger.debug("reponerNumeracion:start");
		numeracionCelularDAO.reponerNumeracion(numeracionCelularVO);
		logger.debug("reponerNumeracion:end");
	}
	
	public DatosNumeracionDTO obtieneNumeracionAutomatica(DatosNumeracionDTO datosNumeracionVO) 
		throws ProductDomainException
	{
		logger.info("obtieneNumeracionAutomatica():start");
		DatosNumeracionDTO resultado = numeracionCelularDAO.obtieneNumeracionAutomatica(datosNumeracionVO);   
		logger.info("obtieneNumeracionAutomatica():end");
		return resultado;
	}
	
	
	public SeleccionNumeroCelularDTO[] obtieneNumeracionReutilizable(DatosNumeracionDTO datosNumeracionVO)
		throws ProductDomainException
	{
		logger.info("obtieneNumeracionReutilizable():start");
		SeleccionNumeroCelularDTO[] arrayNumerosReutilizables=null;
		arrayNumerosReutilizables=numeracionCelularDAO.obtieneNumeracionReutilizable(datosNumeracionVO);
		logger.info("obtieneNumeracionReutilizable():start");
		return arrayNumerosReutilizables;
	}
	
	public SeleccionNumeroCelularDTO[] obtieneNumeracionReservada(DatosNumeracionDTO datosNumeracionVO) 
		throws ProductDomainException
	{
		logger.info("obtieneNumeracionReservada():start");
		SeleccionNumeroCelularDTO[] arrayNumerosReservados=null;
		arrayNumerosReservados = numeracionCelularDAO.obtieneNumeracionReservada(datosNumeracionVO);
		logger.info("obtieneNumeracionReservada():start");
	    return arrayNumerosReservados;
	}
	
	public SeleccionNumeroCelularRangoDTO[] obtieneNumeracionRango(DatosNumeracionDTO datosNumeracionVO) 
		throws ProductDomainException
	{
		logger.info("obtieneNumeracionRango():start");
		SeleccionNumeroCelularRangoDTO[] arrayNumcelularRango= null;
		arrayNumcelularRango=numeracionCelularDAO.obtieneNumeracionRango(datosNumeracionVO);
		logger.info("obtieneNumeracionRango():start");
		return arrayNumcelularRango;
	}
	public void obtieneSubalm(DatosNumeracionDTO datosNumeracionVO)
		throws ProductDomainException
	{
		logger.info("obtieneSubalm():start");
		numeracionCelularDAO.obtieneSubalm(datosNumeracionVO);
		logger.info("obtieneSubalm():end");
		
	}
	public String[] obtieneCategoria(DatosNumeracionDTO datosNumeracionVO)
		throws ProductDomainException
	{
		logger.info("obtieneCategoria():start");	
		String[] arregloCategorias =numeracionCelularDAO.obtieneCategoria(datosNumeracionVO);
		logger.info("obtieneCategoria():end");
		return arregloCategorias;
	}


	public void desReservaNumeroCelular(NumeracionCelularDTO numeracionCelularVO)
		throws ProductDomainException 
	{
		logger.debug("desReservaNumeroCelular:start");
		numeracionCelularDAO.desReservaNumeroCelular(numeracionCelularVO);
		logger.debug("desReservaNumeroCelular:end");
	}
	
	public void verificaCentral(DatosNumeracionDTO datosNumeracionVO) 
		throws ProductDomainException
	{
		logger.debug("verificaCentral:start");
		numeracionCelularDAO.verificaCentral(datosNumeracionVO);
		logger.debug("verificaCentral:end");
	}

	public void consultaUsoNumeroCelular(NumeracionCelularDTO numeracionCelularVO) 
		throws ProductDomainException 
	{
		logger.debug("consultaUsoNumeroCelular:start");
		numeracionCelularDAO.consultaUsoNumeroCelular(numeracionCelularVO);
		logger.debug("consultaUsoNumeroCelular:end");
	}

	public void consultaNumeroCelularGAReservado(NumeracionCelularDTO numeracionCelularVO)
		throws ProductDomainException 
	{
		logger.debug("consultaNumeroCelularGAReservado:start");
		numeracionCelularDAO.consultaNumeroCelularGAReservado(numeracionCelularVO);
		logger.debug("consultaNumeroCelularGAReservado:end");
	}
	
	public void validaNumeroInternet(NumeroInternetDTO entrada)
		throws ProductDomainException 
	{
		logger.debug("validaNumeroInternet:start");
		numeracionCelularDAO.validaNumeroInternet(entrada);
		logger.debug("validaNumeroInternet:end");
	}
	
	//Inicio P-CSR-11002 JLGN 14-11-2011
	public void validaDisponibilidadNumero(String numCelular)throws ProductDomainException 
	{
		logger.debug("validaDisponibilidadNumero:start");
		numeracionCelularDAO.validaDisponibilidadNumero(numCelular);
		logger.debug("validaDisponibilidadNumero:end");
	}	
	//Fin P-CSR-11002 JLGN 14-11-2011

}
