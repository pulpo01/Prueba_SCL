package com.tmmas.scl.framework.ProductDomain.dao.interfaces;

import java.sql.Date;

import com.tmmas.scl.framework.ProductDomain.exception.ProductException;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CausasSuspensionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.DatosGeneralesSuspensionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.FechasSuspensionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.PeriodoSuspencionAbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.SuspensionAbonadoDTO;

public interface SuspensionVoluntariaDAOIT {

	
	public SuspensionAbonadoDTO[] obtenerSuspensionesAbonado(UsuarioAbonadoDTO usuarioAbonado) throws ProductException;	
	public CausasSuspensionDTO[] obtenerCausasSuspension() throws ProductException;
	public DatosGeneralesSuspensionDTO obtenerDatosGeneralesSuspension() throws ProductException;
	public SuspensionAbonadoDTO[] obtenerSuspensionesHistoricasAbonado(long numAbonado, java.sql.Date fecIni, java.sql.Date fecFin ) throws ProductException;	
	public PeriodoSuspencionAbonadoDTO[] obtenerPeriodosSuspensioAbonado(UsuarioAbonadoDTO usuarioAbonado ) throws ProductException;	
	public void programarSuspension(SuspensionAbonadoDTO suspensionAbonado, ClienteOSSesionDTO sessionData) throws ProductException;
	public void modificarSuspension(SuspensionAbonadoDTO suspensionAbonado ) throws ProductException;
	public FechasSuspensionDTO[] recuperarFechasSuspension(ClienteOSSesionDTO sessionData) throws ProductException;
	public void agregaPeriodoSuspension(PeriodoSuspencionAbonadoDTO periodoSuspencionAbonado) throws ProductException;
	public void anularSuspension(SuspensionAbonadoDTO suspensionAbonado) throws ProductException;
	public SuspensionAbonadoDTO recSuspencionAbonado(SuspensionAbonadoDTO suspensionAbonado) throws ProductException;
	public void obtenerPeriodosHistAbonado(long numAbonado, SuspensionAbonadoDTO[] SuspensionAbonado) throws ProductException;
	
}
