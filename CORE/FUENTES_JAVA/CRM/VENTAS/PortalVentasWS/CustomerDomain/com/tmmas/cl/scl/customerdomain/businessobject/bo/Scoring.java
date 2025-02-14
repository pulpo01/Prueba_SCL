package com.tmmas.cl.scl.customerdomain.businessobject.bo;

import org.apache.log4j.Logger;

import com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto.AltaLineaWebDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.ListadoSSOutDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.BusquedaSolScoringDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.DatosGeneralesScoringDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.EstadoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.EstadoScoringDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.LineaSolicitudScoringDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.ProductoOfertadoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.ReporteScoringDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.ResultadoScoreClienteDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.ScoreClienteDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.SolScoringVentaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.TipoComportamientoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dao.ScoringDAO;

public class Scoring {

	private ScoringDAO scoringDAO = new ScoringDAO();

	private final Logger logger = Logger.getLogger(Scoring.class);

	/**
	 * @author JIB
	 * @param dto
	 * @throws CustomerDomainException
	 */
	public long insertarSolicitudScoring(ScoreClienteDTO dto) throws CustomerDomainException {
		logger.info("grabaScoringPendienteEnviar, inicio");
		long numSolicitudScoring = scoringDAO.insertarSolicitudScoring(dto);
		logger.info("grabaScoringPendienteEnviar, fin");
		return numSolicitudScoring;
	}
	
	/**
	 * @author JIB
	 * @param dto
	 * @throws CustomerDomainException
	 */
	public void grabarDatosGeneralesScoring(DatosGeneralesScoringDTO dto) throws CustomerDomainException {
		logger.info("grabaDatosGeneralesScoring, inicio");
		scoringDAO.grabarDatosGeneralesScoring(dto);
		logger.info("grabaDatosGeneralesScoring, fin");
	}
	
	public ScoreClienteDTO[] getSolicitudesScoring(BusquedaSolScoringDTO entrada) 
		throws CustomerDomainException 
	{
		logger.info("getSolicitudesScoring, inicio");
		ScoreClienteDTO[] resultado = scoringDAO.getSolicitudesScoring(entrada);
		logger.info("getSolicitudesScoring, fin");
		return resultado;
	}
	
	/**
	 * @author JIB
	 * @param dto
	 * @throws CustomerDomainException
	 */
	public ScoreClienteDTO getSolicitudScoring(Long numSolicitud) throws CustomerDomainException {
		logger.info("getSolicitudScoring, inicio");
		ScoreClienteDTO r = scoringDAO.getSolicitudScoring(numSolicitud);
		logger.info("getSolicitudScoring, fin");
		return r;
	}
	
	/**
	 * @author pv
	 * @param dto
	 * @throws CustomerDomainException
	 */
	public ReporteScoringDTO getReporteSolicitudScoring(Long numSolicitud) throws CustomerDomainException {
		logger.info("getReporteSolicitudScoring, inicio");
		ReporteScoringDTO r = scoringDAO.getReporteSolicitudScoring(numSolicitud);
		logger.info("getReporteSolicitudScoring, fin");
		return r;
	}
	
	/**
	 * @author pv
	 * @param dto
	 * @throws CustomerDomainException
	 */
	public EstadoScoringDTO[] getEstadosSolicitudScoring(Long numSolicitud) throws CustomerDomainException {
		logger.info("getEstadosSolicitudScoring, inicio");
		EstadoScoringDTO[] r = scoringDAO.getEstadosSolicitudScoring(numSolicitud);
		logger.info("getEstadosSolicitudScoring, fin");
		return r;
	}
	
	public void insertaEstadoScoring(EstadoScoringDTO entrada)  
		throws CustomerDomainException 
	{
		logger.info("insertaEstadoScoring, inicio");
		scoringDAO.insertaEstadoScoring(entrada);
		logger.info("insertaEstadoScoring, fin");		
	}

	/**
	 * @author JIB
	 * @param dto
	 * @throws CustomerDomainException
	 */
	public void actualizaScoreCliente(ScoreClienteDTO dto) throws CustomerDomainException {
		logger.info("actualizaScoreCliente, inicio");
		scoringDAO.actualizaScoreCliente(dto);
		logger.info("actualizaScoreCliente, fin");
	}
	
	public LineaSolicitudScoringDTO[] getlineasSolScoring(Long entrada) 
		throws CustomerDomainException 
	{
		logger.info("getlineasSolScoring, inicio");
		LineaSolicitudScoringDTO[] resultado = scoringDAO.getlineasSolScoring(entrada);
		logger.info("getlineasSolScoring, fin");
		return resultado;
	}
	
	/**
	 * @author JIB
	 * @param dto
	 * @return
	 * @throws CustomerDomainException
	 */
	public long insertarLineaScoring(LineaSolicitudScoringDTO dto) throws CustomerDomainException {
		logger.info("insertarLineaScoring, inicio");
		long r = scoringDAO.insertarLineaScoring(dto);
		logger.info("insertarLineaScoring, fin");
		return r;
	}
	
	/**
	 * @author JIB
	 * @param dto
	 * @throws CustomerDomainException
	 */
	public void insertarResultadoScoreCliente(ResultadoScoreClienteDTO dto) throws CustomerDomainException {
		logger.info("insertarResultadoScoreCliente, inicio");
		scoringDAO.insertarResultadoScoreCliente(dto);
		logger.info("insertarResultadoScoreCliente, fin");
	}
	
	public LineaSolicitudScoringDTO getDetalleLineaScoring(Long numLineaScoring) 
		throws CustomerDomainException 
	{
		logger.info("getDetalleLineaScoring, inicio");
		LineaSolicitudScoringDTO resultado = scoringDAO.getDetalleLineaScoring(numLineaScoring);
		logger.info("getDetalleLineaScoring, fin");
		return resultado;
	}
	
	public void updLineaScoringReplicada(Long numLineaScoring, Long numAbonado) 
		throws CustomerDomainException 
	{
		logger.info("updLineaScoringReplicada, inicio");
		scoringDAO.updLineaScoringReplicada(numLineaScoring, numAbonado);
		logger.info("updLineaScoringReplicada, fin");		
	}
	
	public void insertaSolScoringVenta(SolScoringVentaDTO entrada) 
		throws CustomerDomainException 
	{
		logger.info("insertaSolScoringVenta, inicio");
		scoringDAO.insertaSolScoringVenta(entrada);
		logger.info("insertaSolScoringVenta, fin");		
	}
	
	public Double calcularCapacidadPago(Long numSolScoring) 
		throws CustomerDomainException 
	{
		logger.info("calcularCapacidadPago, inicio");
		Double resultado = scoringDAO.calcularCapacidadPago(numSolScoring);
		logger.info("calcularCapacidadPago, fin");		
		return resultado;
	}
	
	
	public EstadoDTO[] obtenerEstadosDestino(String codPrograma, String codEstadoOrigen, String nomTabla)
	throws CustomerDomainException 
	{
		logger.info("obtenerEstadosDestino, inicio");
		EstadoDTO[] r = scoringDAO.obtenerEstadosDestino(codPrograma, codEstadoOrigen, nomTabla);
		logger.info("obtenerEstadosDestino, fin");
		return r;
	}
	
	public void insertarServSupScoring(ListadoSSOutDTO dto, long numSolScoring, long numLineaScoring)
		throws CustomerDomainException 
	{
		logger.info("insertarServSupScoring, inicio");
		scoringDAO.insertarServSupScoring(dto, numSolScoring, numLineaScoring);
		logger.info("insertarServSupScoring, fin");
	}
	
	public Long obtenerNroventaSolScoring(Long numSolScoring)
		throws CustomerDomainException 
	{
		logger.info("obtenerNroventaSolScoring, inicio");
		Long resultado = scoringDAO.obtenerNroventaSolScoring(numSolScoring);
		logger.info("obtenerNroventaSolScoring, fin");
		return resultado;
	}
	
	public Long obtenerNroSolScoring(Long numVenta)
		throws CustomerDomainException 
	{
		logger.info("obtenerNroSolScoring, inicio");
		Long resultado = scoringDAO.obtenerNroSolScoring(numVenta);
		logger.info("obtenerNroSolScoring, fin");
		return resultado;
	}
	
	/**
	 * @author JIB
	 * @param dto
	 * @throws CustomerDomainException
	 */
	public EstadoScoringDTO[] obtenerEstadosSolicitudScoringXNumTarjeta(String codTipTarjetaSCL, String numTarjeta) throws CustomerDomainException {
		logger.info("obtenerEstadoSolicitudScoringXNumTarjeta, inicio");
		EstadoScoringDTO[] r = scoringDAO.obtenerEstadosSolicitudScoringXNumTarjeta(codTipTarjetaSCL, numTarjeta);
		logger.info("obtenerEstadoSolicitudScoringXNumTarjeta, fin");
		return r;
	}
	
	/**
	 * @author JIB
	 * @param dto
	 * @throws CustomerDomainException
	 */
	public ResultadoScoreClienteDTO getResultadoScoring(Long numSolScoring) throws CustomerDomainException {
		logger.info("getResultadoScoring, inicio");
		ResultadoScoreClienteDTO r = scoringDAO.getResultadoScoring(numSolScoring);
		logger.info("getResultadoScoring, fin");
		return r;
	}
	
	public TipoComportamientoDTO[] obtenerTiposComportamiento() 
		throws CustomerDomainException
	{ 
		logger.info("obtenerTiposComportamiento, inicio");
		TipoComportamientoDTO[] resultado = scoringDAO.obtenerTiposComportamiento();
		logger.info("obtenerTiposComportamiento, fin");
		return resultado;
	}
	
	public void insertarPAScoring(ProductoOfertadoDTO dto, long numSolScoring, long numLinea) 
		throws CustomerDomainException
	{ 
		logger.info("insertarPAScoring, inicio");
		scoringDAO.insertarPAScoring(dto, numSolScoring, numLinea);
		logger.info("insertarPAScoring, fin");		
	}
	
	/**
	 * @author JIB
	 * @param codPlanTarif
	 * @param codCanal
	 * @param nivel
	 * @param codPrestacion
	 * @param codigosTipoComportamiento
	 * @return
	 * @throws CustomerDomainException
	 */
	public ProductoOfertadoDTO[] obtenerProductosOfertadosXFiltros(final String codPlanTarif, final String codCanal,
			final String nivel, final String codPrestacion, final String[] codigosTipoComportamiento)
			throws CustomerDomainException {
		logger.info("obtenerProductosOfertadosXFiltros, inicio");
		final ProductoOfertadoDTO[] r = scoringDAO.obtenerProductosOfertadosXFiltros(codPlanTarif, codCanal, nivel, codPrestacion, codigosTipoComportamiento);
		logger.info("obtenerProductosOfertadosXFiltros, fin");
		return r;
	}
	
	/**
	 * @author Jacqueline Mendez Ortega 16-11-2010 INC-155400
	 * @param codPlanTarif
	 * @param codCanal
	 * @param nivel
	 * @param codPrestacion
	 * @return ProductoOfertadoDTO[]
	 * @throws CustomerDomainException
	 * 
	 * Obtiene los planes opcionales obligatorios configurados para el Plan Tarifario
	 */
	public ProductoOfertadoDTO[] obtenerProductosObligatoriosPT (final String codPlanTarif, 
															     final String codCanal, 
															     final String nivel, 
															     final String codPrestacion)
		   throws CustomerDomainException {
		
		logger.info("obtenerProductosObligatoriosPT, inicio");
		final ProductoOfertadoDTO[] r = scoringDAO.obtenerProductosObligatoriosPT(codPlanTarif, codCanal, nivel, codPrestacion);
		logger.info("obtenerProductosObligatoriosPT, fin");
		return r;
	}

	public String consultaExistenPlanes(Long numSolScoring)	throws CustomerDomainException{
		logger.info("consultaExistenPlanes, inicio");
		String resultado = scoringDAO.consultaExistenPlanes(numSolScoring);
		logger.info("consultaExistenPlanes, fin");
		return resultado;	
	}
	
	//Inicio P-CSR-11002 JLGN 21-04-2011
	public boolean insertaPANormal(AltaLineaWebDTO alta, Long numAbonado, long numMovimiento) throws CustomerDomainException{
		logger.info("insertaPANormal, inicio");
		boolean resultado = scoringDAO.insertaPANormal(alta,numAbonado,numMovimiento);
		logger.info("insertaPANormal, fin");
		return resultado;	
	}
	//Fin P-CSR-11002 JLGN 21-04-2011

}
