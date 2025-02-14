package com.tmmas.scl.operations.crm.fab.cusintman.srv.anusin.interfaces;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.framework.ProductDomain.dto.BodegaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CausaCamSerieDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CentralDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CuotaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.MesesProrrogasDTO;
import com.tmmas.scl.framework.ProductDomain.dto.ModalidadPagoDTO;
import com.tmmas.scl.framework.ProductDomain.dto.ParametrosGeneralesDTO;
import com.tmmas.scl.framework.ProductDomain.dto.RestriccionesDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SerieDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SiniestrosDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TecnologiaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TipoDeContratoDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TipoSiniestroDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TipoTerminalDTO;
import com.tmmas.scl.framework.ProductDomain.exception.ProductException;
import com.tmmas.scl.framework.aplicationDomain.dto.MensajeRetornoDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.SesionDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.UsuarioSistemaDTO;
import com.tmmas.scl.framework.aplicationDomain.exception.AplicationException;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerException;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.operations.crm.fab.customerinterfacemanagement.common.exception.CusIntManException;

public interface AnulacionSiniestroSrvIF {	
	
	public AbonadoDTO obtenerDatosAbonado(AbonadoDTO abonado) throws CusIntManException;	
	public UsuarioAbonadoDTO obtenerDatosUsuarioAbonado(UsuarioAbonadoDTO UsuarioAbonado) throws CusIntManException;
	public ClienteDTO obtenerDatosCliente(ClienteDTO cliente) throws CusIntManException;
	public BodegaDTO[] obtenerBodegas(SesionDTO sesion) throws ProductException;	
	public CausaCamSerieDTO[] obtenerCausaCambioSerie () throws ProductException;
	public TipoDeContratoDTO[] obtenerTiposDeContrato(SesionDTO sessionDTO) throws ProductException;
	public MesesProrrogasDTO[] obtenerMesesProrroga () throws ProductException;
	public ModalidadPagoDTO[] obtenerModalidadPago (SesionDTO Sesion, CausaCamSerieDTO CausaCamSerie) throws ProductException;
	public TipoTerminalDTO[] obtenerTipoTerminal (TecnologiaDTO tecnologia) throws ProductException;
	public CuotaDTO[] obtenerCuotas (SesionDTO sesion, ModalidadPagoDTO modalidadPago) throws ProductException;
	public CentralDTO[] obtenerCentralTecnologiaHlr (SerieDTO serie, TecnologiaDTO tecnologia) throws ProductException;
	public ModalidadPagoDTO[] obtenerModalidadPagoSimcard (SesionDTO Sesion, CausaCamSerieDTO CausaCamSerie) throws ProductException;
	public void validaCausaCamSerie (SesionDTO sesion, CausaCamSerieDTO causaCamSerie) throws ProductException;
	public MensajeRetornoDTO ejecutaRestrccion(RestriccionesDTO Restricciones) throws ProductException;
	public UsuarioSistemaDTO obtenerInformacionUsuario(UsuarioSistemaDTO usuarioSistema) throws AplicationException;
	public void reservaSimcard (String accionProceso, SerieDTO serie, UsuarioSistemaDTO usuarioSistema, UsuarioAbonadoDTO usuarioAbonado, String parametros, CausaCamSerieDTO causa, TipoTerminalDTO terminal, ModalidadPagoDTO modalidadPago) throws ProductException,CustomerException ;
	public TipoSiniestroDTO[] obtenerTiposDeSiniestros(UsuarioAbonadoDTO usuarioAbonado) throws ProductException;
	public SiniestrosDTO[] recDatosSiniestroAboando (UsuarioAbonadoDTO usuarioAbonado) throws ProductException;
	public void anulaSinistroAbonado(SiniestrosDTO Siniestros, UsuarioAbonadoDTO usuarioAbonado, SesionDTO sesion) throws ProductException;

	//Incluido santiago ventura 23-03-2010	
	public void anulaNumeroConstanciaPolicial(SiniestrosDTO siniestros) throws ProductException;
	public ParametrosGeneralesDTO getParametroGeneral(ParametrosGeneralesDTO parametrosGeneralesDTO) throws GeneralException;
}  // AnulacionSiniestroSrvIF
