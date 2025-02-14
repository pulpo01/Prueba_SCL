package com.tmmas.scl.gestionlc.bo;

import com.tmmas.scl.gestionlc.bo.common.GestionLimiteConsumoAbstractBO;
import com.tmmas.scl.gestionlc.common.dto.AbonadoDTO;
import com.tmmas.scl.gestionlc.common.dto.ArticuloDTO;
import com.tmmas.scl.gestionlc.common.dto.BodegaDTO;
import com.tmmas.scl.gestionlc.common.dto.CatTributariaDTO;
import com.tmmas.scl.gestionlc.common.dto.CausaCambioDTO;
import com.tmmas.scl.gestionlc.common.dto.ContratoDTO;
import com.tmmas.scl.gestionlc.common.dto.CuotaDTO;
import com.tmmas.scl.gestionlc.common.dto.EstadoDTO;
import com.tmmas.scl.gestionlc.common.dto.ModalidadDTO;
import com.tmmas.scl.gestionlc.common.dto.ParametroDTO;
import com.tmmas.scl.gestionlc.common.dto.ProrrogaDTO;
import com.tmmas.scl.gestionlc.common.dto.RestriccionesDTO;
import com.tmmas.scl.gestionlc.common.dto.SerieDTO;
import com.tmmas.scl.gestionlc.common.dto.UsoDTO;
import com.tmmas.scl.gestionlc.common.dto.UsuarioDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.CargaModificacionLimiteConsumoOutDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.IndicadorAbonoInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.IndicadorAbonoOutDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.IndicadorVtaExternaVendedorInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.IndicadorVtaExternaVendedorOutDTO;
import com.tmmas.scl.gestionlc.common.exception.GestionLimiteConsumoException;
import com.tmmas.scl.gestionlc.dao.GeneralDAO;

public class GeneralBO extends GestionLimiteConsumoAbstractBO {

    private GeneralDAO generalDAO = new GeneralDAO();

    public ParametroDTO obtieneParametros(ParametroDTO pParametroDTO) throws GestionLimiteConsumoException {
        loggerInfo("Inicio(BO):obtieneParametros");

        ParametroDTO parametroDTO = generalDAO.obtieneParametros(pParametroDTO);

        loggerInfo("Fin(BO):obtieneParametros");

        return parametroDTO;
    }

    public CausaCambioDTO obtieneDatosCausaCambio(CausaCambioDTO pPausaCambioDTO) throws GestionLimiteConsumoException {
        loggerInfo("Inicio(BO):obtieneDatosCausaCambio");

        CausaCambioDTO causaCambioDTO = generalDAO.obtieneDatosCausaCambio(pPausaCambioDTO);

        loggerInfo("Fin(BO):obtieneDatosCausaCambio");

        return causaCambioDTO;
    }

    /**
     * permite retornar la descripcion del grupo tecnologico
     *
     * @param pCodTecnologia
     * @return
     * @throws GestionLimiteConsumoException
     */
    public String obtieneDescGrupoTecnologico(String pCodTecnologia) throws GestionLimiteConsumoException {

        loggerDebug("Inicio(BO):obtieneDescGrupoTecnologico");

        String result = generalDAO.obtieneDescGrupoTecnologico(pCodTecnologia);

        loggerDebug("Fin(BO):obtieneDescGrupoTecnologico");

        return result;

    }

    /**
     * obtiene la descripcion asociada al codigo de un codSituacion
     *
     * @param pCodSituacion
     * @return
     * @throws GestionLimiteConsumoException
     */
    public String obtieneDescSituacion(String pCodSituacion) throws GestionLimiteConsumoException {
        loggerDebug("Inicio(BO):obtieneDescSituacion");

        String result = generalDAO.obtieneDescSituacion(pCodSituacion);

        loggerDebug("Fin(BO):obtieneDescSituacion");

        return result;

    }

    /**
     * permite ejecutar el modelo de restricciones
     *
     * @param pIn
     * @throws GestionLimiteConsumoException
     */
    public void ejecutaModeloRestriccion(RestriccionesDTO pIn) throws GestionLimiteConsumoException {
        loggerDebug("Inicio(BO):ejecutaModeloRestriccion");

        generalDAO.ejecutaModeloRestriccion(pIn);

        loggerDebug("Fin(BO):ejecutaModeloRestriccion");
    }

    /**
     * permite obtener el proximo valor de una secuencia
     *
     * @param pNombreSecuencia
     * @return
     * @throws GestionLimiteConsumoException
     */
    public String obtieneNextValSecuencia(String pNombreSecuencia) throws GestionLimiteConsumoException {
        loggerDebug("Inicio(BO):obtieneNextValSecuencia");

        String result = generalDAO.obtieneNextValSecuencia(pNombreSecuencia);

        loggerDebug("Fin(BO):obtieneNextValSecuencia");

        return result;
    }

    /**
     * permite obtener fecha actual del sistema
     *
     * @param strFormatoFecha
     * @return
     * @throws GestionLimiteConsumoException
     */
    public String getSysdateAsString(String strFormatoFecha) throws GestionLimiteConsumoException {
        loggerDebug("Inicio(BO):getSysdateAsString");

        String strResult = generalDAO.getSysdateAsString(strFormatoFecha);

        loggerDebug("Fin(BO):getSysdateAsString");

        return strResult;
    }

    /**
     * permite obtener fecha actual del sistema
     *
     * @param strFormatoFecha
     * @return
     * @throws GestionLimiteConsumoException
     */
    public Integer getDiasPasados(String strFecha) throws GestionLimiteConsumoException {
        loggerDebug("Inicio(BO):getDiasPasados");

        Integer intResult = generalDAO.getDiasPasados(strFecha);

        loggerDebug("Fin(BO):getDiasPasados");

        return intResult;
    }

    /**
     * permite obtener una lista de tipos de contrato
     *
     * @param
     * @return ContratoDTO[]
     * @throws GestionLimiteConsumoException
     */
    public ContratoDTO[] obtieneListaContratos(String strNomUsuario, String strCodPrograma, String strIndEqPRestado) throws GestionLimiteConsumoException {
        loggerDebug("Inicio(BO):obtieneListaContratos");

        ContratoDTO[] contratoDTOs = generalDAO.obtieneListaContratos(strNomUsuario, strCodPrograma, strIndEqPRestado);

        loggerDebug("Fin(BO):obtieneListaContratos");

        return contratoDTOs;
    }

    /**
     * permite obtener un detalle del tipo de contrato
     *
     * @param
     * @return ContratoDTO
     * @throws GestionLimiteConsumoException
     */
    public ContratoDTO obtieneDetalleContrato(ContratoDTO pContratoDTO) throws GestionLimiteConsumoException {
        loggerDebug("Inicio(BO):obtieneDetalleContrato");

        ContratoDTO contratoDTO = generalDAO.obtieneDetalleContrato(pContratoDTO);

        loggerDebug("Fin(BO):obtieneDetalleContrato");

        return contratoDTO;
    }

    /**
     * permite obtener una lista de modalidades de pago
     *
     * @param
     * @return ModalidadDTO[]
     * @throws GestionLimiteConsumoException
     */
    public ModalidadDTO[] obtieneListaModalidad(UsuarioDTO usuarioDTO, String strCodPrograma, ContratoDTO contratoDTO, String strCodPlanTarif)

        throws GestionLimiteConsumoException {
        loggerDebug("Inicio(BO):obtieneListaModalidad");

        ModalidadDTO[] modalidadDTOs = generalDAO.obtieneListaModalidad(usuarioDTO, strCodPrograma, contratoDTO, strCodPlanTarif);

        loggerDebug("Fin(BO):obtieneListaModalidad");

        return modalidadDTOs;
    }

    /**
     * permite obtener una lista de cuotas para el pago
     *
     * @param
     * @return CuotaDTO[]
     * @throws GestionLimiteConsumoException
     */
    public CuotaDTO[] obtieneListaCuotas(String strNomUsuario, Short shoCodModVenta) throws GestionLimiteConsumoException {
        loggerDebug("Inicio(BO):obtieneListaCuotas");

        CuotaDTO[] cuotaDTOs = generalDAO.obtieneListaCuotas(strNomUsuario, shoCodModVenta);

        loggerDebug("Fin(BO):obtieneListaCuotas");

        return cuotaDTOs;
    }

    /**
     * permite obtener una lista de bodegas de series
     *
     * @param
     * @return BodegaDTO[]
     * @throws GestionLimiteConsumoException
     */
    public BodegaDTO[] obtieneListaBodegas(Integer intCodVendedor, String strCodOperadora) throws GestionLimiteConsumoException {
        loggerDebug("Inicio(BO):obtieneListaBodegas");

        BodegaDTO[] bodegaDTOs = generalDAO.obtieneListaBodegas(intCodVendedor, strCodOperadora);

        loggerDebug("Fin(BO):obtieneListaBodegas");

        return bodegaDTOs;
    }

    /**
     * permite obtener una lista de usos de series
     *
     * @param
     * @return UsoDTO[]
     * @throws GestionLimiteConsumoException
     */
    public UsoDTO[] obtieneListaUsos() throws GestionLimiteConsumoException {
        loggerDebug("Inicio(BO):obtieneListaUsos");

        UsoDTO[] usoDTOs = generalDAO.obtieneListaUsos();

        loggerDebug("Fin(BO):obtieneListaUsos");

        return usoDTOs;
    }

    /**
     * permite obtener una lista de estados de series
     *
     * @param
     * @return EstadoDTO[]
     * @throws GestionLimiteConsumoException
     */
    public EstadoDTO[] obtieneListaEstados() throws GestionLimiteConsumoException {
        loggerDebug("Inicio(BO):obtieneListaEstados");

        EstadoDTO[] estadoDTOs = generalDAO.obtieneListaEstados();

        loggerDebug("Fin(BO):obtieneListaEstados");

        return estadoDTOs;
    }

    /**
     * permite obtener una lista de prorrogas de contrato
     *
     * @param
     * @return ProrrogaDTO[]
     * @throws GestionLimiteConsumoException
     */
    public ProrrogaDTO[] obtieneListaProrrogas() throws GestionLimiteConsumoException {
        loggerDebug("Inicio(BO):obtieneListaProrrogas");

        ProrrogaDTO[] prorrogaDTOs = generalDAO.obtieneListaProrrogas();

        loggerDebug("Fin(BO):obtieneListaProrrogas");

        return prorrogaDTOs;
    }

    /**
     * permite obtener una lista de articulos a la venta
     *
     * @param
     * @return ArticuloDTO[]
     * @throws GestionLimiteConsumoException
     */
    public ArticuloDTO[] obtieneListaArticulos(String strTipTerminal, String strCodTecnologia) throws GestionLimiteConsumoException {
        loggerDebug("Inicio(BO):obtieneListaArticulos");

        ArticuloDTO[] articuloDTOs = generalDAO.obtieneListaArticulos(strTipTerminal, strCodTecnologia);

        loggerDebug("Fin(BO):obtieneListaArticulos");

        return articuloDTOs;
    }

    /**
     * permite obtener una lista de categorias tributarias para realizar la
     * venta
     *
     * @param
     * @return CatTributariaDTO[]
     * @throws GestionLimiteConsumoException
     */
    public CatTributariaDTO[] obtieneListaCategorias(Long lonCodCliente) throws GestionLimiteConsumoException {

        loggerDebug("Inicio(BO):obtieneListaCategorias");

        CatTributariaDTO[] catTributaroiaDTOs = generalDAO.obtieneListaCategorias(lonCodCliente);

        loggerDebug("Fin(BO):obtieneListaCategorias");

        return catTributaroiaDTOs;
    }

    /**
     * obtiene el indicador de abono asociado a la modalidad de la venta
     *
     * @param
     * @return IndicadorAbonoOutDTO
     * @throws GestionLimiteConsumoException
     */
    public IndicadorAbonoOutDTO obtieneIndicadorAbono(IndicadorAbonoInDTO pIndicadorAbonoInDTO) throws GestionLimiteConsumoException {

        loggerDebug("Inicio(BO):obtieneIndicadorAbono");

        IndicadorAbonoOutDTO result = generalDAO.obtieneIndicadorAbono(pIndicadorAbonoInDTO);

        loggerDebug("Fin(BO):obtieneListaCategorias");

        return result;
    }

    /**
     * obtiene el indicador de venta externa asociado al vendedor
     *
     * @param
     * @return IndicadorVtaExternaVendedorOutDTO
     * @throws GestionLimiteConsumoException
     */
    public IndicadorVtaExternaVendedorOutDTO obtieneIndicadorVtaExternaVendedor(IndicadorVtaExternaVendedorInDTO pIndicadorVtaExternaVendedorInDTO)

        throws GestionLimiteConsumoException {

        loggerDebug("Inicio(BO):obtieneIndicadorVtaExternaVendedor");

        IndicadorVtaExternaVendedorOutDTO result = generalDAO.obtieneIndicadorVtaExternaVendedor(pIndicadorVtaExternaVendedorInDTO);

        loggerDebug("Fin(BO):obtieneIndicadorVtaExternaVendedor");

        return result;
    }

    /**
     * obtiene informacion de la modalidad de pago
     *
     * @param
     * @return ModalidadDTO
     * @throws GestionLimiteConsumoException
     */
    public ModalidadDTO obtieneDatosModalidad(ModalidadDTO pModalidadDTO) throws GestionLimiteConsumoException {
        loggerInfo("Inicio(BO):obtieneDatosModalidad");

        ModalidadDTO modalidadDTO = generalDAO.obtieneDatosModalidad(pModalidadDTO);

        loggerInfo("Fin(BO):obtieneDatosModalidad");

        return modalidadDTO;
    }

    /**
     * obtiene informacion de la modalidad de pago
     *
     * @param
     * @return boolean
     * @throws GestionLimiteConsumoException
     */
    public boolean obtieneBPLista(AbonadoDTO abonadoDTO, SerieDTO serieDTO) throws GestionLimiteConsumoException {
        ParametroDTO parametroDTO = new ParametroDTO();
        parametroDTO.setStrNombreParametro(getValorInterno("parametro.grupo.tecnologico.gsm"));
        parametroDTO = obtieneParametros(parametroDTO);
        String strGrupoTecGSM = parametroDTO.getStrValorParametro();

        parametroDTO = new ParametroDTO();
        parametroDTO.setStrNombreParametro(getValorInterno("parametro.simcard.gsm"));
        parametroDTO = obtieneParametros(parametroDTO);
        String strTipSimCard = parametroDTO.getStrValorParametro();

        parametroDTO = new ParametroDTO();
        parametroDTO.setStrNombreParametro(getValorInterno("parametro.politica.simcard"));
        parametroDTO = obtieneParametros(parametroDTO);
        String strPolSimcard = parametroDTO.getStrValorParametro();

        boolean bPLista;

        if (abonadoDTO.getStrCodTecnologia().equals(strGrupoTecGSM) && serieDTO.getStrTipTerminal().equals(strTipSimCard) && "0".equals(strPolSimcard)) {
            bPLista = true;
        } else {
            bPLista = generalDAO.obtieneBPLista(abonadoDTO.getLonNumAbonado(), serieDTO.getStrTipTerminal());
        }
        return bPLista;
    }
    
    //inicio incedencia 169415 09/06/2011 FDL
    public String obtieneEstadoVenta(Long num_Abonado) throws GestionLimiteConsumoException {
        loggerInfo("Inicio(BO):obtieneEstadoVenta");

        String estadoVenta = generalDAO.obtieneEstadoVenta(num_Abonado);

        loggerInfo("Fin(BO):obtieneEstadoVenta");

        return estadoVenta;
    }
    //fin incedencia 169415 09/06/2011 FDL
}
