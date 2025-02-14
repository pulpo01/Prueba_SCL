package com.tmmas.scl.framework.ProductDomain.bo.interfaces;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.framework.ProductDomain.dto.BodegaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CategoriaTributariaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CausaCamSerieDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CentralDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CuotaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.DatosCentralDTO;
import com.tmmas.scl.framework.ProductDomain.dto.DatosNumeracionDTO;
import com.tmmas.scl.framework.ProductDomain.dto.MesesProrrogasDTO;
import com.tmmas.scl.framework.ProductDomain.dto.ModalidadPagoDTO;
import com.tmmas.scl.framework.ProductDomain.dto.RestriccionesDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SerieDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TecnologiaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TipoDeContratoDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TipoTerminalDTO;
import com.tmmas.scl.framework.ProductDomain.dto.UsoArticuloDTO;
import com.tmmas.scl.framework.ProductDomain.dto.UsosVentaDTO;
import com.tmmas.scl.framework.ProductDomain.exception.ProductException;
import com.tmmas.scl.framework.aplicationDomain.dto.MensajeRetornoDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.OperadoraLocalDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.SesionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ArticuloDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosVerificaPlanComercialDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ParametrosCambioSerieDTO;
import com.tmmas.scl.operations.crm.fab.customerinterfacemanagement.common.exception.CusIntManException;
import com.tmmas.scl.framework.ProductDomain.dto.ParametrosGeneralesDTO;


public interface DatosGeneralesBOIT {

	public CausaCamSerieDTO[] obtenerCausaCambioSerie () throws ProductException;
	public TipoDeContratoDTO[] obtenerTiposDeContrato(SesionDTO sesion) throws ProductException;	
	public BodegaDTO[] obtenerBodegas (SesionDTO sesion) throws ProductException;
	public TecnologiaDTO[] obtenerTecnologia () throws ProductException;
	public UsoArticuloDTO[] obtenerUsos () throws ProductException;
	public MesesProrrogasDTO[] obtenerMesesProrroga () throws ProductException;
	public ModalidadPagoDTO[] obtenerModalidadPago (SesionDTO Sesion, CausaCamSerieDTO CausaCamSerie) throws ProductException;
	public TipoTerminalDTO[] obtenerTipoterminal (TecnologiaDTO Tecnologia) throws ProductException;
	public CuotaDTO[] obtenerCuotas (SesionDTO Sesion, ModalidadPagoDTO ModalidadPago) throws ProductException;
	public CategoriaTributariaDTO[] obtenerCatTributaria (SesionDTO Sesion) throws ProductException;
	public CentralDTO[] obtenerCentralTecnologiaHlr (SerieDTO serie, TecnologiaDTO tecnologia) throws ProductException;	
	public UsosVentaDTO[] obtenerUsosVenta () throws ProductException;	
	public ModalidadPagoDTO[] obtenerModalidadPagoSimcard (SesionDTO Sesion, CausaCamSerieDTO CausaCamSerie) throws ProductException;
	public void validaCausaCamSerie (SesionDTO Sesion, CausaCamSerieDTO CausaCamSerie) throws ProductException;
	public MensajeRetornoDTO ejecutaRestrccion(RestriccionesDTO Restricciones) throws ProductException;
	public void verificaPlancomercial(SesionDTO sesion, CausaCamSerieDTO causaCamSerie, ModalidadPagoDTO modalidadPago, UsoArticuloDTO usoArticulo, TipoTerminalDTO tipoTerminal, SerieDTO Serie) throws ProductException;
	public ArticuloDTO[] obtenerListaArticulos (ArticuloDTO articuloDTO) throws ProductException;
	public RetornoDTO verificaPlanComercialTerminal(ParametrosVerificaPlanComercialDTO parametros) throws ProductException;
	public RetornoDTO verificaConcFactGarantia(ParametroDTO parametrosDTO )throws GeneralException;
	public RetornoDTO validaSeleccionCausa(ParametrosCambioSerieDTO parametrosCambioSerieDTO )throws GeneralException;
	public OperadoraLocalDTO obtenerOperadoraLocal()throws GeneralException;
	public ParametrosGeneralesDTO getParametroGeneral(ParametrosGeneralesDTO entrada) throws GeneralException;
	public DatosCentralDTO obtenerDatosCentral(int codCentral) throws ProductException;
	public String consultarSeguroAbonado(Long numAbonado) throws ProductException;
	//Inicio Inc. 174755/CSR-11002/06-09-2011/FDL
	public String verificaNumeroDesviado(String numeroDesviado)throws GeneralException;
	//Inicio Inc. 174755/CSR-11002/06-09-2011/FDL
	//INICIO CSR-11002 PAH
	public void cambioUsoSeries(ParametrosVerificaPlanComercialDTO parametros) throws ProductException;
	//FIN CSR-11002 PAH
	
}
