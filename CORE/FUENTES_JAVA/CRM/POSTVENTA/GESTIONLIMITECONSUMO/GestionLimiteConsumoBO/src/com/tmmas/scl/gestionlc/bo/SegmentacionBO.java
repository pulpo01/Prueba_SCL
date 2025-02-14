package com.tmmas.scl.gestionlc.bo;

import com.tmmas.scl.gestionlc.bo.common.GestionLimiteConsumoAbstractBO;
import com.tmmas.scl.gestionlc.common.dto.SegmentacionInDTO;
import com.tmmas.scl.gestionlc.common.dto.SegmentacionOutDTO;
import com.tmmas.scl.gestionlc.common.exception.GestionLimiteConsumoException;
import com.tmmas.scl.gestionlc.dao.SegmentacionDAO;

public class SegmentacionBO extends GestionLimiteConsumoAbstractBO {

    private SegmentacionDAO segmentacionDAO = new SegmentacionDAO();

    /**
     * permite obtener la segmentacion
     *
     * @param pIn
     * @return
     * @throws GestionLimiteConsumoException
     */
    public SegmentacionOutDTO obtieneSegmentacion(SegmentacionInDTO pIn) throws GestionLimiteConsumoException {

        SegmentacionOutDTO result = segmentacionDAO.obtieneSegmentacion(pIn);

        return result;

    }

}
