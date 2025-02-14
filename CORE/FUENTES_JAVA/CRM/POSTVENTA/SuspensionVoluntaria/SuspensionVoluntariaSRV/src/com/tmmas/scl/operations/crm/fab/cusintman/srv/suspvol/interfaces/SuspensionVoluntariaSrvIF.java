package com.tmmas.scl.operations.crm.fab.cusintman.srv.suspvol.interfaces;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.framework.ProductDomain.dto.RestriccionesDTO;
import com.tmmas.scl.framework.ProductDomain.exception.ProductException;
import com.tmmas.scl.framework.aplicationDomain.dto.MensajeRetornoDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.OperadoraLocalDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.UsuarioSistemaDTO;
import com.tmmas.scl.framework.aplicationDomain.exception.AplicationException;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CausasSuspensionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.DatosGeneralesSuspensionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.FechasSuspensionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.PeriodoSuspencionAbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.SuspensionAbonadoDTO;
import com.tmmas.scl.operations.crm.fab.customerinterfacemanagement.common.exception.CusIntManException;
import java.sql.Date;
public interface SuspensionVoluntariaSrvIF {	
	
	public MensajeRetornoDTO ejecutaRestrccion(RestriccionesDTO restricciones) throws ProductException;
	public UsuarioSistemaDTO obtenerInformacionUsuario(UsuarioSistemaDTO usuarioSistema) throws AplicationException;
	public ClienteDTO obtenerDatosCliente(ClienteDTO cliente) throws CusIntManException;
	public AbonadoDTO obtenerDatosAbonado(AbonadoDTO abonado) throws CusIntManException;
	public UsuarioAbonadoDTO obtenerDatosUsuarioAbonado(UsuarioAbonadoDTO UsuarioAbonado) throws CusIntManException;
	
	public CausasSuspensionDTO[]  obtenerCausasSuspension() throws ProductException;
	public SuspensionAbonadoDTO[] obtenerSuspensionesAbonado(UsuarioAbonadoDTO usuarioAbonado) throws ProductException;
	public SuspensionAbonadoDTO[] obtenerSuspensionesHistoricasAbonado(long NumAbonado, Date fecIni, Date fecFin ) throws ProductException;
	public FechasSuspensionDTO[] recuperarFechasSuspension(ClienteOSSesionDTO sessionData) throws ProductException;

	public void programarSuspension(SuspensionAbonadoDTO suspensionAbonado, ClienteOSSesionDTO sessionData) throws ProductException;
	public void modificarSuspension(SuspensionAbonadoDTO suspensionAbonado) throws ProductException;
	public void anularSuspension(SuspensionAbonadoDTO suspensionAbonado) throws ProductException;

	public DatosGeneralesSuspensionDTO obtenerDatosGeneralesSuspension() throws ProductException;
	public PeriodoSuspencionAbonadoDTO[] obtenerPeriodosSuspensioAbonado(UsuarioAbonadoDTO usuarioAbonado) throws ProductException;
	public void agregaPeriodoSuspension(PeriodoSuspencionAbonadoDTO periodoSuspensionAbonado) throws ProductException;

	public OperadoraLocalDTO obtenerOperadoraLocal() throws GeneralException;
}  // SuspensionVoluntariaSrvIF
