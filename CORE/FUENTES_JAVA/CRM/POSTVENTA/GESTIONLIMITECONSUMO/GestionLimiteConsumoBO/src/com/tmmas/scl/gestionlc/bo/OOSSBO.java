package com.tmmas.scl.gestionlc.bo;

import com.tmmas.scl.gestionlc.bo.common.GestionLimiteConsumoAbstractBO;
import com.tmmas.scl.gestionlc.common.dto.AbonadoDTO;
import com.tmmas.scl.gestionlc.common.dto.CausaCambioDTO;
import com.tmmas.scl.gestionlc.common.dto.ContratoDTO;
import com.tmmas.scl.gestionlc.common.dto.EquipAboSerDTO;
import com.tmmas.scl.gestionlc.common.dto.FolioDTO;
import com.tmmas.scl.gestionlc.common.dto.InterfazAbonadoDTO;
import com.tmmas.scl.gestionlc.common.dto.ModalidadDTO;
import com.tmmas.scl.gestionlc.common.dto.OOSSDTO;
import com.tmmas.scl.gestionlc.common.dto.ParametroDTO;
import com.tmmas.scl.gestionlc.common.dto.SerieDTO;
import com.tmmas.scl.gestionlc.common.dto.SiniestroDTO;
import com.tmmas.scl.gestionlc.common.dto.UsuarioDTO;
import com.tmmas.scl.gestionlc.common.exception.GestionLimiteConsumoException;
import com.tmmas.scl.gestionlc.dao.OOSSDAO;

public class OOSSBO extends GestionLimiteConsumoAbstractBO {

    private static Integer iTIPPANOCA = 0;
    private static Integer iTIPCAMBIOSERIECOMODATO = 15;
    private static Integer iTIPCAMBIOSERIECOMODVTA = 17;
    private static Integer iTIPCAMBIOSERIEVTACOMOD = 18;
    private static Integer iTIPCAMBIOSERIEGARANTIA = 19;
    private static Integer iTIPCARGOEQUIPO = 23;
    private static Integer iTIPCARGOSIMCARD = 26;
    private OOSSDAO oossDAO = new OOSSDAO();

    /**
     * inserta en la tabla GA_MODABOCEL
     * 
     * @param
     * @return void
     * @throws GestionLimiteConsumoException
     */
    public void insertaModabocel(AbonadoDTO abonadoDTO, String strCodOperacion, SiniestroDTO siniestroDTO, UsuarioDTO usuarioDTO, String strCodCauCambio,
            ContratoDTO contratoDTO) throws GestionLimiteConsumoException {

        loggerInfo("Inicio(BO):insertaModabocel");

        oossDAO.insertaModabocel(abonadoDTO, strCodOperacion, siniestroDTO, usuarioDTO, strCodCauCambio, contratoDTO);

        loggerInfo("Fin(BO):insertaModabocel");

    }

    /**
     * llama a P_INTERFASES_ABONADO
     * 
     * @param
     * @return InterfazAbonadoDTO
     * @throws GestionLimiteConsumoException
     */
    public InterfazAbonadoDTO ejecutaInterfasesAbonados(InterfazAbonadoDTO pInterfazAbonadoDTO) throws GestionLimiteConsumoException {
        loggerInfo("Inicio(BO):ejecutaInterfasesAbonados");

        InterfazAbonadoDTO interfazAbonadoDTO = oossDAO.ejecutaInterfasesAbonados(pInterfazAbonadoDTO);

        loggerInfo("Fin(BO):ejecutaInterfasesAbonados");
        return interfazAbonadoDTO;
    }

    /**
     * consulta Folio
     * 
     * @param
     * @return FolioDTO
     * @throws GestionLimiteConsumoException
     */
    public FolioDTO cosultaFolio(UsuarioDTO pUsuarioDTO, String pStrCodCatTribut, Integer pIntOpcion, FolioDTO pFolioDTO, Integer pIntRangoInicial)

        throws GestionLimiteConsumoException {
        loggerInfo("Inicio(BO):cosultaFolio");

        FolioDTO folioDTO = oossDAO.cosultaFolio(pUsuarioDTO, pStrCodCatTribut, pIntOpcion, pFolioDTO, pIntRangoInicial);

        loggerInfo("Fin(BO):cosultaFolio");
        return folioDTO;
    }

    public Integer defineTipPantalla(Short shoCodModVenta, AbonadoDTO abonadoDTO, String strCodTipContrato, SerieDTO serieDTO)

        throws GestionLimiteConsumoException {
        GeneralBO generalBO = new GeneralBO();
        Integer intTipPantalla = null;

        ParametroDTO parametroDTO = new ParametroDTO();
        parametroDTO.setStrNombreParametro("COD_CAUSA_RESTI");
        parametroDTO = generalBO.obtieneParametros(parametroDTO);

        CausaCambioDTO causaCambioDTO = new CausaCambioDTO();
        causaCambioDTO.setStrCodCausaCambio(getValorInterno("parametro.codigo.operacion.re"));
        causaCambioDTO = generalBO.obtieneDatosCausaCambio(causaCambioDTO);

        ModalidadDTO modalidadDTO = new ModalidadDTO();
        // modalidadDTO.setShoCodCauPago(shoCodModVenta);
        modalidadDTO.setShoCodModVenta(shoCodModVenta);
        modalidadDTO = generalBO.obtieneDatosModalidad(modalidadDTO);

        ContratoDTO contratoDTO = new ContratoDTO();
        contratoDTO.setStrCodTipContrato(strCodTipContrato);
        contratoDTO = generalBO.obtieneDetalleContrato(contratoDTO);

        parametroDTO = new ParametroDTO();
        parametroDTO.setStrNombreParametro("COD_SIMCARD_GSM");
        parametroDTO = generalBO.obtieneParametros(parametroDTO);
        String strTipSimCard = parametroDTO.getStrValorParametro();

        parametroDTO = new ParametroDTO();
        parametroDTO.setStrNombreParametro("GRUPO_TEC_GSM");
        parametroDTO = generalBO.obtieneParametros(parametroDTO);
        String strTecGSM = parametroDTO.getStrValorParametro();

        // IIf(Trim$(g_tAbonado.sIndEqPrestado) = "", 0,
        // g_tAbonado.sIndEqPrestado)
        String strIndComodatoOLD;
        if (abonadoDTO.getStrIndEqPrestado() == null || "".equals(abonadoDTO.getStrIndEqPrestado())) {
            strIndComodatoOLD = "0";
        } else {
            strIndComodatoOLD = abonadoDTO.getStrIndEqPrestado();
        }
        // If IndDevAlm = "0" Then
        if (causaCambioDTO.getShoIndDevAlmacen() == null || causaCambioDTO.getShoIndDevAlmacen().shortValue() == 0) {

            // If sIndCuotas <> "2" Then 'No es arriendo
            if (modalidadDTO.getShoIndCuotas().shortValue() != 2) {
                if ("1".equals(strIndComodatoOLD) && "1".equals(contratoDTO.getStrIndComodato()) && !serieDTO.getStrTipTerminal().equals(strTipSimCard)) {
                    intTipPantalla = iTIPCAMBIOSERIECOMODATO;
                } else if ("1".equals(strIndComodatoOLD) && !"1".equals(contratoDTO.getStrIndComodato())) {
                    intTipPantalla = iTIPCAMBIOSERIECOMODVTA;
                } else if (!"1".equals(strIndComodatoOLD) && "1".equals(contratoDTO.getStrIndComodato())) {
                    intTipPantalla = iTIPCAMBIOSERIEVTACOMOD;
                } else if (abonadoDTO.getStrCodTecnologia().equals(strTecGSM) && serieDTO.getStrTipTerminal().equals(strTipSimCard)) {
                    intTipPantalla = iTIPCARGOSIMCARD;
                } else {
                    intTipPantalla = iTIPCARGOEQUIPO;
                }
            } else if (modalidadDTO.getShoIndCuotas().shortValue() == 2) {
                intTipPantalla = iTIPPANOCA;
            }
        } else {
            intTipPantalla = iTIPCAMBIOSERIEGARANTIA;
        }

        return intTipPantalla;
    }

    /**
     * inserta en la tabla GA_EQUIPABOSER para restitucion de Equipo
     * 
     * @param
     * @return void
     * @throws GestionLimiteConsumoException
     */
    public void insertaEquipAboSerEqui(SerieDTO serieDTO, Long lonNumMovimiento, boolean bHayCargos, AbonadoDTO abonadoDTO, boolean bPLista,
            String strCodModVenta, String strIndComodato, Short shoCodCuota) throws GestionLimiteConsumoException {
        loggerInfo("Inicio(BO):insertaEquipAboSerEqui");

        EquipAboSerDTO equipAboSerDTO = new EquipAboSerDTO();
        GeneralBO generalBO = new GeneralBO();

        ModalidadDTO modalidadDTO = new ModalidadDTO();
        modalidadDTO.setShoCodModVenta(Short.valueOf(strCodModVenta));
        modalidadDTO = generalBO.obtieneDatosModalidad(modalidadDTO);

        equipAboSerDTO.setbHayCargos(bHayCargos);
        equipAboSerDTO.setbPLista(bPLista);
        equipAboSerDTO.setIntCodArticulo(serieDTO.getIntCodArticulo());
        equipAboSerDTO.setIntCodBodega(serieDTO.getIntCodBodega());
        equipAboSerDTO.setLonNumAbonado(abonadoDTO.getLonNumAbonado());
        equipAboSerDTO.setLonNumMovimiento(lonNumMovimiento);
        equipAboSerDTO.setShoCodEstado(serieDTO.getShoCodEstado());
        equipAboSerDTO.setShoCodUso(serieDTO.getShoCodUso());
        equipAboSerDTO.setShoIndComodato(Short.valueOf(strIndComodato));
        equipAboSerDTO.setStrCodTecnologia(abonadoDTO.getStrCodTecnologia());
        equipAboSerDTO.setStrDesArticulo(serieDTO.getStrDesArticulo());
        equipAboSerDTO.setStrIndProcEqui(abonadoDTO.getStrIndProcEqui());
        if (modalidadDTO.getShoIndCuotas() != null && modalidadDTO.getShoIndCuotas().equals(Short.valueOf("0"))) {
            equipAboSerDTO.setStrIndPropiedad("C");
        } else {
            equipAboSerDTO.setStrIndPropiedad("E");
        }
        equipAboSerDTO.setStrNumSerie(serieDTO.getStrNumSerie());
        equipAboSerDTO.setStrNumSerieMec(serieDTO.getStrNumSerieMec());
        equipAboSerDTO.setStrTipStock(serieDTO.getStrTipStock());
        equipAboSerDTO.setStrTipTerminal(serieDTO.getStrTipTerminal());
        equipAboSerDTO.setShoTipDto(null);
        equipAboSerDTO.setDouImporte(null);
        equipAboSerDTO.setDouValDto(null);
        equipAboSerDTO.setShoCodModVenta(modalidadDTO.getShoCodModVenta());
        equipAboSerDTO.setStrCodCausa(getValorInterno("parametro.codigo.operacion.re"));
        equipAboSerDTO.setShoCodCuota(shoCodCuota);

        oossDAO.insertaEquipAboSerEqui(equipAboSerDTO);

        loggerInfo("Fin(BO):insertaEquipAboSerEqui");

    }

    /**
     * inserta en la tabla CI_ORSERV
     * 
     * @param
     * @return Long
     * @throws GestionLimiteConsumoException
     */
    public Long insertaCiOrServ(String strComentario, String strNomUsuario, Long lonNumAbonado, Long lonNumCargo, String strSecuencia)

        throws GestionLimiteConsumoException {
        loggerInfo("Inicio(BO):insertaCiOrServ");

        GeneralBO generalBO = new GeneralBO();
        OOSSDTO oossDTO = new OOSSDTO();
        oossDTO.setStrComentario(strComentario);
        oossDTO.setStrUsuario(strNomUsuario);
        oossDTO.setShoTipInter(Short.valueOf(getValorInterno("parametro.tip.inter.abonado")));
        oossDTO.setLonCodInter(lonNumAbonado);
        oossDTO.setLonNumCargo(lonNumCargo);
        oossDTO.setStrFecha(generalBO.getSysdateAsString(getValorInterno("parametro.formato.fecha1")));
        oossDTO.setStrCodOS(getValorInterno("COD.OS.RESTITUCION"));
        oossDTO.setLonNumMovimiento(null);
        oossDTO.setLonNumOS(Long.valueOf(strSecuencia));
        oossDTO.setShoCodProducto(Short.valueOf(getValorInterno("parametro.codigo.producto.uno")));
        oossDTO.setStrCodModulo(getValorInterno("parametro.codigo.modulo.GC"));
        oossDTO.setStrIdGestor(null);
        oossDAO.insertaCiOrServ(oossDTO);

        loggerInfo("Fin(BO):insertaCiOrServ");

        return oossDTO.getLonNumOS();
    }

    /**
     * inserta en la tabla GA_EQUIPABOSER para restitucion de Simcard
     * 
     * @param
     * @return void
     * @throws GestionLimiteConsumoException
     */
    public void insertaEquipAboSerSim(SerieDTO serieDTO, Long lonNumMovimiento, boolean bHayCargos, AbonadoDTO abonadoDTO, boolean bPLista,
            String strCodModVenta, String strIndComodato, Short shoCodCuota) throws GestionLimiteConsumoException {
        loggerInfo("Inicio(BO):insertaEquipAboSerSim");

        EquipAboSerDTO equipAboSerDTO = new EquipAboSerDTO();
        GeneralBO generalBO = new GeneralBO();

        ModalidadDTO modalidadDTO = new ModalidadDTO();
        modalidadDTO.setShoCodModVenta(Short.valueOf(strCodModVenta));
        modalidadDTO = generalBO.obtieneDatosModalidad(modalidadDTO);

        equipAboSerDTO.setbHayCargos(bHayCargos);
        equipAboSerDTO.setbPLista(bPLista);
        equipAboSerDTO.setIntCodArticulo(serieDTO.getIntCodArticulo());
        equipAboSerDTO.setIntCodBodega(serieDTO.getIntCodBodega());
        equipAboSerDTO.setLonNumAbonado(abonadoDTO.getLonNumAbonado());
        equipAboSerDTO.setLonNumMovimiento(lonNumMovimiento);
        equipAboSerDTO.setShoCodEstado(serieDTO.getShoCodEstado());
        equipAboSerDTO.setShoCodUso(serieDTO.getShoCodUso());
        equipAboSerDTO.setShoIndComodato(Short.valueOf(strIndComodato));
        equipAboSerDTO.setStrCodTecnologia(abonadoDTO.getStrCodTecnologia());
        equipAboSerDTO.setStrDesArticulo(serieDTO.getStrDesArticulo());
        equipAboSerDTO.setStrIndProcEqui(abonadoDTO.getStrIndProcEqui());
        if (modalidadDTO.getShoIndCuotas() != null && modalidadDTO.getShoIndCuotas().equals(Short.valueOf("0"))) {
            equipAboSerDTO.setStrIndPropiedad("C");
        } else {
            equipAboSerDTO.setStrIndPropiedad("E");
        }
        equipAboSerDTO.setStrNumSerie(serieDTO.getStrNumSerie());
        equipAboSerDTO.setStrNumSerieMec(serieDTO.getStrNumSerieMec());
        equipAboSerDTO.setStrTipStock(serieDTO.getStrTipStock());
        equipAboSerDTO.setStrTipTerminal(serieDTO.getStrTipTerminal());
        equipAboSerDTO.setShoTipDto(null);
        equipAboSerDTO.setDouImporte(null);
        equipAboSerDTO.setDouValDto(null);
        equipAboSerDTO.setShoCodModVenta(modalidadDTO.getShoCodModVenta());
        equipAboSerDTO.setStrCodCausa(getValorInterno("parametro.codigo.operacion.re"));
        equipAboSerDTO.setShoCodCuota(shoCodCuota);

        oossDAO.insertaEquipAboSerSimc(equipAboSerDTO);

        loggerInfo("Fin(BO):insertaEquipAboSerSim");

    }

    /**
     * actualiza abonado
     * 
     * @param
     * @return void
     * @throws GestionLimiteConsumoException
     */
    public void actualizarAbonado(AbonadoDTO abonadoDTO, SerieDTO serieDTO, String strIndProcequi, ContratoDTO contratoDTO, boolean bCheckTerminal,
            String strNumContrato, String strNumAnexo) throws GestionLimiteConsumoException {

        loggerDebug("Inicio(BO):actualizarAbonado");
        oossDAO.actualizarAbonado(abonadoDTO, serieDTO, strIndProcequi, contratoDTO, bCheckTerminal, strNumContrato, strNumAnexo);
        loggerDebug("Inicio(BO):actualizarAbonado");

    }

    /**
     * inserta contrato abonado
     * 
     * @param
     * @return void
     * @throws GestionLimiteConsumoException
     */
    public void insertaContrato(AbonadoDTO abonadoDTO, ContratoDTO contratoDTO, String strNumContrato, String strNumAnexo) throws GestionLimiteConsumoException {
        loggerDebug("Inicio(BO):insertaContrato");
        oossDAO.insertaContrato(abonadoDTO, contratoDTO, strNumContrato, strNumAnexo);
        loggerDebug("Inicio(BO):insertaContrato");
    }

    /**
     * inserta movimiento
     * 
     * @param
     * @return void
     * @throws GestionLimiteConsumoException
     */
    public void insertaMovimiento(AbonadoDTO abonadoDTO, SiniestroDTO siniestroDTO, SerieDTO serieDTO, Long lonNumOS, String strCodOS, Long lonNumSecIccAnt,
            String strNomUsuario, Long lonNumSecIcc) throws GestionLimiteConsumoException {
        loggerDebug("Inicio(BO):insertaMovimiento");
        oossDAO.insertaMovimiento(abonadoDTO, siniestroDTO, serieDTO, lonNumOS, strCodOS, lonNumSecIccAnt, strNomUsuario, lonNumSecIcc);
        loggerDebug("Inicio(BO):insertaMovimiento");
    }

    /**
     * rehabilita serie Suspendida
     * 
     * @param
     * @return void
     * @throws GestionLimiteConsumoException
     */
    public void rehabilitarSuspension(AbonadoDTO abonadoDTO, SiniestroDTO siniestroDTO, Long lonNumOS, String strCodOS, Long lonNumSecIcc,
            String strNomUsuario, String strActabo) throws GestionLimiteConsumoException {

        loggerDebug("Inicio(DAO):rehabilitarSuspension");

        oossDAO.rehabilitarSuspension(abonadoDTO, siniestroDTO, lonNumOS, strCodOS, lonNumSecIcc, strNomUsuario, strActabo);

        loggerDebug("Fin(DAO):rehabilitarSuspension");
    }

    /**
     * cambia estado movimiento icc
     * 
     * @param
     * @return void
     * @throws GestionLimiteConsumoException
     */
    public void cambiarEstadoMovimientoICC(Long lonNumSecIcc) throws GestionLimiteConsumoException {

        loggerDebug("Inicio(DAO):cambiarEstadoMovimientoICC");

        oossDAO.cambiarEstadoMovimientoICC(lonNumSecIcc);

        loggerDebug("Fin(DAO):rehabilitarSuspension");
    }

    /**
     * Movimientos 6_7 ARRIENDO (2) Salida temporal del equipo (devolución de
     * equipo arrendado sin n° de celular)
     */
    public void movBodegaSalidaTemporal(SerieDTO serieNuevaDTO, Long lonNumVenta) throws GestionLimiteConsumoException {
        SerieBO serieBO = new SerieBO();
        GeneralBO generalBO = new GeneralBO();
        SerieDTO auxSerieDTO = new SerieDTO();

        auxSerieDTO.setStrTipStock(getValorInterno("parametro.tipStock.activofijo"));
        auxSerieDTO.setIntCodBodega(serieNuevaDTO.getIntCodBodega());
        auxSerieDTO.setIntCodArticulo(serieNuevaDTO.getIntCodArticulo());
        auxSerieDTO.setShoCodUso(serieNuevaDTO.getShoCodUso());
        auxSerieDTO.setShoCodEstado(serieNuevaDTO.getShoCodEstado());
        auxSerieDTO.setStrNumSerie(serieNuevaDTO.getStrNumSerie());

        String strNumTransaccion = generalBO.obtieneNextValSecuencia(getValorInterno("parametro.nombre.seq.transacabo"));
        serieBO.actualizaStock(serieNuevaDTO, lonNumVenta, getValorInterno("tipMovimiento.interal.6"), strNumTransaccion);

        ParametroDTO parametroDTO = new ParametroDTO();
        parametroDTO.setStrNombreParametro(getValorInterno("parametro.Bodega.Comodato"));
        parametroDTO = generalBO.obtieneParametros(parametroDTO);

        auxSerieDTO.setIntCodBodega(Integer.valueOf(parametroDTO.getStrValorParametro()));
        auxSerieDTO.setShoCodEstado(Short.valueOf(getValorInterno("parametro.estado.interal.8")));

        strNumTransaccion = generalBO.obtieneNextValSecuencia(getValorInterno("parametro.nombre.seq.transacabo"));
        serieBO.actualizaStock(serieNuevaDTO, null, getValorInterno("tipMovimiento.interal.7"), strNumTransaccion);
    }

    /**
     * Movimiento 1 Salida definitiva de SimCard
     */
    public void movBodegaSalidaDefinitiva(SerieDTO serieNuevaDTO, Long lonNumVenta) throws GestionLimiteConsumoException {
        SerieBO serieBO = new SerieBO();
        GeneralBO generalBO = new GeneralBO();
        SerieDTO auxSerieDTO = new SerieDTO();

        auxSerieDTO.setStrTipStock(serieNuevaDTO.getStrTipStock());
        auxSerieDTO.setIntCodBodega(serieNuevaDTO.getIntCodBodega());
        auxSerieDTO.setIntCodArticulo(serieNuevaDTO.getIntCodArticulo());
        auxSerieDTO.setShoCodUso(serieNuevaDTO.getShoCodUso());
        auxSerieDTO.setShoCodEstado(serieNuevaDTO.getShoCodEstado());
        auxSerieDTO.setStrNumSerie(serieNuevaDTO.getStrNumSerie());

        String strNumTransaccion = generalBO.obtieneNextValSecuencia(getValorInterno("parametro.nombre.seq.transacabo"));
        serieBO.actualizaStock(serieNuevaDTO, lonNumVenta, getValorInterno("tipMovimiento.interal.1"), strNumTransaccion);
    }

    /*
     * OK 9
     */
    private void movBodegaAnulacionVenta(SerieDTO serieDTO, Long lonNumVenta) throws GestionLimiteConsumoException {
        SerieBO serieBO = new SerieBO();
        GeneralBO generalBO = new GeneralBO();
        SerieDTO auxSerieDTO = new SerieDTO();

        CausaCambioDTO causaCambioDTO = new CausaCambioDTO();
        causaCambioDTO.setStrCodCausaCambio(getValorInterno("parametro.codigo.operacion.re"));
        causaCambioDTO = generalBO.obtieneDatosCausaCambio(causaCambioDTO);

        auxSerieDTO.setStrTipStock(serieDTO.getStrTipStock());
        auxSerieDTO.setIntCodBodega(serieDTO.getIntCodBodega());
        auxSerieDTO.setIntCodArticulo(serieDTO.getIntCodArticulo());
        auxSerieDTO.setShoCodUso(serieDTO.getShoCodUso());
        auxSerieDTO.setShoCodEstado(causaCambioDTO.getShoCodEstadoDev());
        auxSerieDTO.setStrNumSerie(serieDTO.getStrNumSerie());

        String strNumTransaccion = generalBO.obtieneNextValSecuencia(getValorInterno("parametro.nombre.seq.transacabo"));
        serieBO.actualizaStock(serieDTO, lonNumVenta, getValorInterno("tipMovimiento.interal.9"), strNumTransaccion);
    }

    /*
     * OK 7
     */
    private void movBodegaDevolucionSalidaTemp(SerieDTO serieDTO, Long lonNumVenta) throws GestionLimiteConsumoException {
        SerieBO serieBO = new SerieBO();
        GeneralBO generalBO = new GeneralBO();
        SerieDTO auxSerieDTO = new SerieDTO();

        CausaCambioDTO causaCambioDTO = new CausaCambioDTO();
        causaCambioDTO.setStrCodCausaCambio(getValorInterno("parametro.codigo.operacion.re"));
        causaCambioDTO = generalBO.obtieneDatosCausaCambio(causaCambioDTO);

        auxSerieDTO.setStrTipStock(serieDTO.getStrTipStock());
        auxSerieDTO.setIntCodBodega(serieDTO.getIntCodBodega());
        auxSerieDTO.setIntCodArticulo(serieDTO.getIntCodArticulo());
        auxSerieDTO.setShoCodUso(serieDTO.getShoCodUso());
        auxSerieDTO.setShoCodEstado(causaCambioDTO.getShoCodEstadoDev());
        auxSerieDTO.setStrNumSerie(serieDTO.getStrNumSerie());

        String strNumTransaccion = generalBO.obtieneNextValSecuencia(getValorInterno("parametro.nombre.seq.transacabo"));
        serieBO.actualizaStock(serieDTO, null, getValorInterno("tipMovimiento.interal.7"), strNumTransaccion);
    }

    /*
     * OK 2
     */
    private void movBodegaSalidaDefinitivaArriendo(SerieDTO serieDTO, Long lonNumVenta) throws GestionLimiteConsumoException {
        SerieBO serieBO = new SerieBO();
        GeneralBO generalBO = new GeneralBO();
        SerieDTO auxSerieDTO = new SerieDTO();

        CausaCambioDTO causaCambioDTO = new CausaCambioDTO();
        causaCambioDTO.setStrCodCausaCambio(getValorInterno("parametro.codigo.operacion.re"));
        causaCambioDTO = generalBO.obtieneDatosCausaCambio(causaCambioDTO);

        auxSerieDTO.setStrTipStock(serieDTO.getStrTipStock());
        auxSerieDTO.setIntCodBodega(serieDTO.getIntCodBodega());
        auxSerieDTO.setIntCodArticulo(serieDTO.getIntCodArticulo());
        auxSerieDTO.setShoCodUso(serieDTO.getShoCodUso());
        auxSerieDTO.setShoCodEstado(causaCambioDTO.getShoCodEstadoDev());
        auxSerieDTO.setStrNumSerie(serieDTO.getStrNumSerie());

        String strNumTransaccion = generalBO.obtieneNextValSecuencia(getValorInterno("parametro.nombre.seq.transacabo"));
        serieBO.actualizaStock(serieDTO, lonNumVenta, getValorInterno("tipMovimiento.interal.2"), strNumTransaccion);
    }

    /*
     * OK 7
     */
    private void movBodegaSalidaDefinivaCDevolucion(SerieDTO serieDTO, Long lonNumVenta) throws GestionLimiteConsumoException {
        SerieBO serieBO = new SerieBO();
        GeneralBO generalBO = new GeneralBO();
        SerieDTO auxSerieDTO = new SerieDTO();

        ParametroDTO parametroDTO = new ParametroDTO();
        parametroDTO.setStrNombreParametro(getValorInterno("parametro.cod.Est.revision"));
        parametroDTO = generalBO.obtieneParametros(parametroDTO);

        auxSerieDTO.setStrTipStock(serieDTO.getStrTipStock());
        auxSerieDTO.setIntCodBodega(serieDTO.getIntCodBodega());
        auxSerieDTO.setIntCodArticulo(serieDTO.getIntCodArticulo());
        auxSerieDTO.setShoCodUso(serieDTO.getShoCodUso());
        auxSerieDTO.setStrNumSerie(serieDTO.getStrNumSerie());
        auxSerieDTO.setShoCodEstado(Short.valueOf(parametroDTO.getStrValorParametro()));

        String strNumTransaccion = generalBO.obtieneNextValSecuencia(getValorInterno("parametro.nombre.seq.transacabo"));
        serieBO.actualizaStock(serieDTO, null, getValorInterno("tipMovimiento.interal.7"), strNumTransaccion);

    }

}
