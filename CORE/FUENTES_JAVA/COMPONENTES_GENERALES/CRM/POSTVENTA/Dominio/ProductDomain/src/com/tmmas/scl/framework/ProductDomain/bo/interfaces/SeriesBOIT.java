package com.tmmas.scl.framework.ProductDomain.bo.interfaces;

import com.tmmas.scl.framework.ProductDomain.dto.ArticuloInDTO;
import com.tmmas.scl.framework.ProductDomain.dto.BodegaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CausaCamSerieDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CuotaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.ModalidadPagoDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SerieDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TipoTerminalDTO;
import com.tmmas.scl.framework.ProductDomain.dto.UsoArticuloDTO;
import com.tmmas.scl.framework.ProductDomain.exception.ProductException;
import com.tmmas.scl.framework.aplicationDomain.dto.SesionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ParametrosCambioSerieDTO;
import com.tmmas.cl.scl.socketps.common.dto.SaldoDTO;

public interface SeriesBOIT {

	public RetornoDTO reservaSimcard (SerieDTO serie) throws ProductException;;
	public RetornoDTO desReservaSimcard (SerieDTO serie) throws ProductException;
	public void validaBodegaSerie (UsoArticuloDTO  usoArticulos, TipoTerminalDTO tipoTerminal, UsuarioAbonadoDTO usuarioAbonado, SesionDTO sesion, SerieDTO serie) throws ProductException;
	public SerieDTO recInfoSerie (SerieDTO serie) throws ProductException;
	public void registraCambioSimcard(UsuarioAbonadoDTO usuarioAbonado, SerieDTO serie, UsoArticuloDTO usoArticulo, CuotaDTO cuota, SesionDTO sesion, ModalidadPagoDTO modalidadPago, BodegaDTO bodega, String actabo, String codModulo, CausaCamSerieDTO causaCamSerie) throws ProductException;
	public String registraCambioDeSerie(ParametrosCambioSerieDTO parametros,SaldoDTO saldo)  throws ProductException ;
	
	public RetornoDTO validaSerieExterna (SerieDTO serie) throws ProductException; // RRG 70904 29-01-2009 COL
	
	public SerieDTO[] obtieneSerie(SerieDTO serieDTO) throws ProductException;	
	public SerieDTO[] obtieneSeries(SerieDTO serieDTO) throws ProductException;	
	public ArticuloInDTO[] obtieneArticulos(ArticuloInDTO articuloDTO) throws ProductException;
	public BodegaDTO[] obtieneBodega(BodegaDTO bodegaDTO) throws ProductException;
	
	public RetornoDTO validaSerieExternaEquipo (SerieDTO serie) throws ProductException; //Santiago Ventura 02/06/2010
	
	public SerieDTO[] obtieneSeriesSinUso(SerieDTO serieDTO) throws ProductException;//177697 PAH
}
