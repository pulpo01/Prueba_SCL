package com.tmmas.cl.scl.customerdomain.businessobject.bo;

import org.apache.log4j.Logger;

import com.tmmas.cl.scl.crmcommon.commonapp.dto.DocDigitalizadoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.TipoDocDigitalizadoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.DocDigitalizadoScoringDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dao.DocDigitalizadoDAO;
import com.tmmas.cl.scl.customerdomain.businessobject.dao.DocDigitalizadoScoringDAO;
import com.tmmas.cl.scl.customerdomain.businessobject.helper.Global;

public class DocDigitalizado {

	Global global = Global.getInstance();

	DocDigitalizadoDAO docDigitalizadoDAO = new DocDigitalizadoDAO();

	DocDigitalizadoScoringDAO docDigitalizadoScoringDAO = new DocDigitalizadoScoringDAO();

	private static Logger logger = Logger.getLogger(DocDigitalizado.class);

	public Long insertarDocDigitalizado(DocDigitalizadoDTO docDigitalizadoDTO) throws CustomerDomainException {
		logger.debug("Inicio");
		Long r = docDigitalizadoDAO.insertarDocDigitalizado(docDigitalizadoDTO);
		logger.debug("Fin");
		return r;
	}

	public void eliminarDocDigitalizado(long numCorrelativo) throws CustomerDomainException {
		logger.debug("Inicio");
		docDigitalizadoDAO.eliminarDocDigitalizado(numCorrelativo);
		logger.debug("Fin");
	}

	public DocDigitalizadoDTO obtenerDocDigitalizado(long numCorrelativo) throws CustomerDomainException {
		logger.debug("Inicio");
		DocDigitalizadoDTO r = docDigitalizadoDAO.obtenerDocDigitalizado(numCorrelativo);
		logger.debug("Fin");
		return r;
	}

	/**
	 * @author JIB
	 * @return
	 * @throws CustomerDomainException
	 */
	public DocDigitalizadoDTO[] obtenerDocDigitalizados(long numVenta) throws CustomerDomainException {
		logger.debug("Inicio");
		DocDigitalizadoDTO[] r = docDigitalizadoDAO.obtenerDocDigitalizados(numVenta);
		logger.debug("Fin");
		return r;
	}

	/**
	 * @author JIB
	 * @return
	 * @throws CustomerDomainException
	 */
	public TipoDocDigitalizadoDTO[] obtenerTiposDocDigitalizado() throws CustomerDomainException {
		logger.debug("Inicio");
		TipoDocDigitalizadoDTO[] r = docDigitalizadoDAO.obtenerTiposDocDigitalizado();
		logger.debug("Fin");
		return r;
	}

	/**
	 * @author JIB
	 * @param docDigitalizadoScoringDTO
	 * @return
	 * @throws CustomerDomainException
	 */
	public Long insertarDocDigitalizadoScoring(DocDigitalizadoScoringDTO docDigitalizadoScoringDTO)
			throws CustomerDomainException {
		logger.info("insertarDocDigitalizadoScoring, Inicio");
		Long r = docDigitalizadoScoringDAO.insertarDocDigitalizadoScoring(docDigitalizadoScoringDTO);
		logger.info("insertarDocDigitalizadoScoring, Fin");
		return r;
	}

	/**
	 * @author JIB
	 * @param numSolScoring
	 * @return
	 * @throws CustomerDomainException
	 */
	public DocDigitalizadoScoringDTO obtenerDocDigitalizadoScoring(Long numCorrelativo, Long numSolScoring)
			throws CustomerDomainException {
		logger.info("obtenerDocDigitalizadosScoring, Inicio");
		DocDigitalizadoScoringDTO r = docDigitalizadoScoringDAO.obtenerDocDigitalizadosScoring(numCorrelativo,
				numSolScoring)[0];
		logger.info("obtenerDocDigitalizadosScoring, Fin");
		return r;
	}

	/**
	 * @author JIB
	 * @param numSolScoring
	 * @return
	 * @throws CustomerDomainException
	 */
	public DocDigitalizadoScoringDTO[] obtenerDocDigitalizadosScoring(Long numSolScoring)
			throws CustomerDomainException {
		logger.info("obtenerDocDigitalizadosScoring, Inicio");
		DocDigitalizadoScoringDTO[] r = docDigitalizadoScoringDAO.obtenerDocDigitalizadosScoring(null, numSolScoring);
		logger.info("obtenerDocDigitalizadosScoring, Fin");
		return r;
	}

	/**
	 * @author JIB
	 * @param dto
	 * @return
	 * @throws CustomerDomainException
	 */
	public void actualizarDocDigitalizadoScoring(DocDigitalizadoScoringDTO dto) throws CustomerDomainException {
		logger.info("actualizarDocDigitalizadoScoring, Inicio");
		docDigitalizadoDAO.actualizarDocDigitalizado(dto);
		logger.info("actualizarDocDigitalizadoScoring, Fin");
	}
}
