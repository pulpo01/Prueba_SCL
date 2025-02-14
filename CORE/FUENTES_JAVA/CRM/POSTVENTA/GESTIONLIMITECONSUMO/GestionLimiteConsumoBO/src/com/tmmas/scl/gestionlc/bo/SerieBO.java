package com.tmmas.scl.gestionlc.bo;

import com.tmmas.scl.gestionlc.bo.common.GestionLimiteConsumoAbstractBO;
import com.tmmas.scl.gestionlc.common.dto.ConsultaSeriesDTO;
import com.tmmas.scl.gestionlc.common.dto.ProductoDTO;
import com.tmmas.scl.gestionlc.common.dto.SerieDTO;
import com.tmmas.scl.gestionlc.common.dto.UsuarioDTO;
import com.tmmas.scl.gestionlc.common.exception.GestionLimiteConsumoException;
import com.tmmas.scl.gestionlc.dao.SerieDAO;

public class SerieBO extends GestionLimiteConsumoAbstractBO {

    private SerieDAO serieDAO = new SerieDAO();

    /**
     * obtiene informacion de un producto(serie) del abonado
     *
     * @param
     * @return ProductoDTO
     * @throws GestionLimiteConsumoException
     */
    public ProductoDTO obtieneInfoProductoAbonado(Long lonNumAbonado, String strTipTerminal) throws GestionLimiteConsumoException {
        loggerInfo("Inicio(BO):obtieneInfoProductoAbonado");

        ProductoDTO productoDTO = serieDAO.obtieneInfoProductoAbonado(lonNumAbonado, strTipTerminal);

        loggerInfo("Fin(BO):obtieneInfoProductoAbonado");

        return productoDTO;
    }

    /**
     * obtiene un listado de series
     *
     * @param
     * @return SerieDTO[]
     * @throws GestionLimiteConsumoException
     */
    public SerieDTO[] obtieneListadoSeries(ConsultaSeriesDTO consultaSeriesDTO) throws GestionLimiteConsumoException {
        loggerInfo("Inicio(BO):obtieneListadoSeries");

        SerieDTO[] serieDTOs = serieDAO.obtieneListadoSeries(consultaSeriesDTO);

        loggerInfo("Fin(BO):obtieneListadoSeries");

        return serieDTOs;
    }

    /**
     * reserva un articulo
     *
     * @param
     * @return Long
     * @throws GestionLimiteConsumoException
     */
    public Long reservaArticulo(SerieDTO serieDTO, UsuarioDTO usuarioDTO) throws GestionLimiteConsumoException {
        loggerDebug("Inicio(BO):reservaArticulo");

        Long lonNumTransaccion = serieDAO.reservaArticulo(serieDTO, usuarioDTO);

        loggerDebug("Fin(BO):reservaArticulo");

        return lonNumTransaccion;
    }

    /**
     * desreserva un articulo
     *
     * @param
     * @return void
     * @throws GestionLimiteConsumoException
     */
    public void desReservaArticulo(Long lonNumTransaccion) throws GestionLimiteConsumoException {
        loggerDebug("Inicio(BO):desReservaArticulo");

        serieDAO.desReservaArticulo(lonNumTransaccion);

        loggerDebug("Fin(BO):desReservaArticulo");
    }

    /**
     * actualiza stock de las serie
     *
     * @param
     * @return void
     * @throws GestionLimiteConsumoException
     */
    public void actualizaStock(SerieDTO serieDTO, Long lonNumVenta, String strTipoMovimiento, String strNumTransaccion) throws GestionLimiteConsumoException {
        loggerDebug("Inicio(BO):actualizaStock");

        serieDAO.actualizaStock(serieDTO, lonNumVenta, strTipoMovimiento, strNumTransaccion);

        loggerDebug("Fin(BO):actualizaStock");
    }

    /**
     * obtiene informacion de la series
     *
     * @param
     * @return serieDTO
     * @throws GestionLimiteConsumoException
     */
    public SerieDTO obtieneDatosSerie(SerieDTO pSerieDTO) throws GestionLimiteConsumoException {
        loggerDebug("Inicio(BO):obtieneDatosSerie");

        SerieDTO serieDTO = serieDAO.obtieneDatosSerie(pSerieDTO);

        loggerDebug("Fin(BO):obtieneDatosSerie");
        return serieDTO;

    }

    /**
     * rollback reserva de serie
     *
     * @param
     * @return
     * @throws GestionLimiteConsumoException
     */
    public void rollbackReservaSerie(Long lonNumTransaccion) throws GestionLimiteConsumoException {
        loggerDebug("Inicio(BO):rollbackReservaSerie");

        serieDAO.rollbackReservaSerie(lonNumTransaccion);

        loggerDebug("Fin(BO):rollbackReservaSerie");
    }
}
