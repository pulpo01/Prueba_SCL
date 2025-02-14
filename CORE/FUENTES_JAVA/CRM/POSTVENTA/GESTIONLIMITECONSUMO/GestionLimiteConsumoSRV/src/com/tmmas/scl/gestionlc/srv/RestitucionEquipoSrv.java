package com.tmmas.scl.gestionlc.srv;

import java.util.Date;

import com.tmmas.scl.gestionlc.bo.AbonadoBO;
import com.tmmas.scl.gestionlc.bo.ClienteBO;
import com.tmmas.scl.gestionlc.bo.GeneralBO;
import com.tmmas.scl.gestionlc.bo.OOSSBO;
import com.tmmas.scl.gestionlc.bo.PlanTarifarioBO;
import com.tmmas.scl.gestionlc.bo.SerieBO;
import com.tmmas.scl.gestionlc.bo.SiniestroBO;
import com.tmmas.scl.gestionlc.bo.UsuarioBO;
import com.tmmas.scl.gestionlc.bo.VendedorBO;
import com.tmmas.scl.gestionlc.common.dto.AbonadoDTO;
import com.tmmas.scl.gestionlc.common.dto.ClienteDTO;
import com.tmmas.scl.gestionlc.common.dto.ContratoDTO;
import com.tmmas.scl.gestionlc.common.dto.DatosGeneralesSiniestroDTO;
import com.tmmas.scl.gestionlc.common.dto.EquipoAntiguoDTO;
import com.tmmas.scl.gestionlc.common.dto.FolioDTO;
import com.tmmas.scl.gestionlc.common.dto.InterfazAbonadoDTO;
import com.tmmas.scl.gestionlc.common.dto.ModalidadDTO;
import com.tmmas.scl.gestionlc.common.dto.ParametroDTO;
import com.tmmas.scl.gestionlc.common.dto.PlanTarifarioDTO;
import com.tmmas.scl.gestionlc.common.dto.ProductoDTO;
import com.tmmas.scl.gestionlc.common.dto.RestriccionesDTO;
import com.tmmas.scl.gestionlc.common.dto.SerieDTO;
import com.tmmas.scl.gestionlc.common.dto.SiniestroDTO;
import com.tmmas.scl.gestionlc.common.dto.UsuarioDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.CargaRestitucionEquipoInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.CargaRestitucionEquipoOutDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.CargaSeguimientoSiniestroInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.CargaSeguimientoSiniestroOutDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.CargaSeleccionEquipoInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.CargaSeleccionEquipoOutDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.EjecutaCierreRestitucionInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.EjecutaCierreRestitucionOutDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.EjecutaRestitucionEquipoInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.EjecutaRestitucionEquipoOutDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.RecargaCboCuotasInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.RecargaCboCuotasOutDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.RecargaCboModalidadInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.RecargaCboModalidadOutDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.RecargaListSeriesInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.RecargaListSeriesOutDTO;
import com.tmmas.scl.gestionlc.common.exception.GestionLimiteConsumoException;
import com.tmmas.scl.gestionlc.srv.common.GestionLimiteConsumoAbstractSRV;

public class RestitucionEquipoSrv extends GestionLimiteConsumoAbstractSRV {

    private AbonadoBO abonadoBO = new AbonadoBO();
    private UsuarioBO usuarioBO = new UsuarioBO();
    private VendedorBO vendedorBO = new VendedorBO();
    private SiniestroBO siniestroBO = new SiniestroBO();
    private GeneralBO generalBO = new GeneralBO();
    private SerieBO serieBO = new SerieBO();
    private OOSSBO oossBO = new OOSSBO();
    private ClienteBO clienteBO = new ClienteBO();
    private PlanTarifarioBO planTarifarioBO = new PlanTarifarioBO();

    public CargaSeguimientoSiniestroOutDTO cargarSeguimientoSiniestro(CargaSeguimientoSiniestroInDTO inDTO) throws GestionLimiteConsumoException {
        loggerInfo("Inicio(SRV):cargarSeguimientoSiniestro");
        CargaSeguimientoSiniestroOutDTO outDTO = new CargaSeguimientoSiniestroOutDTO();

        AbonadoDTO abonadoDTO = new AbonadoDTO();
        UsuarioDTO usuarioDTO = new UsuarioDTO();

        try {
            inDTO.setStrNomUsuario(inDTO.getStrNomUsuario().toUpperCase());
            abonadoDTO.setLonNumAbonado(inDTO.getLonNumAbonado());
            abonadoDTO = abonadoBO.obtenerDatosAbonado(abonadoDTO);

            if (abonadoDTO.getShoCodUso().equals(Short.valueOf("3"))) {
                throw new GestionLimiteConsumoException("Abonado con uso Prepago. No es posible continuar con la restitución.", 0);
            }
            abonadoBO.validarOOSSPendiente(abonadoDTO, getValorInterno("COD.OS.RESTITUCION"));

            usuarioDTO.setStrNomUsuario(inDTO.getStrNomUsuario());
            usuarioDTO = usuarioBO.obtenerDatosUsuario(usuarioDTO);

            validarRestricciones(abonadoDTO);

            if (usuarioDTO.getIntCodVendedor() == null) {
                throw new GestionLimiteConsumoException("El usuario no esta dado de alta como vendedor.", 0);
            }
            if (usuarioDTO.getStrCodTipComis() == null || "".equals(usuarioDTO.getStrCodTipComis())) {
                throw new GestionLimiteConsumoException("El usuario no esta dado de alta como comisionista.", 0);
            }

            vendedorBO.validarEstadoVendedor(usuarioDTO);

            abonadoBO.validarAvisoSiniestro(abonadoDTO);

            outDTO.setLonNumTerminal(abonadoDTO.getLonNumCelular());
            outDTO.setSiniestroDTOs(abonadoBO.obtenerSiniestros(abonadoDTO));
            outDTO.setStrNomUsuario(usuarioDTO.getStrNomUsuario());
            outDTO.setStrFechaActual(generalBO.getSysdateAsString(getValorInterno("parametro.formato.fecha1")));

        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            throw new GestionLimiteConsumoException("Sucedio un error inesperado durante la ejecucion.", 0);
        }
        loggerInfo("Fin(SRV):cargarSeguimientoSiniestro");
        return outDTO;
    }

    public CargaRestitucionEquipoOutDTO cargarRestitucionEquipo(CargaRestitucionEquipoInDTO inDTO) throws GestionLimiteConsumoException {
        loggerInfo("Inicio(SRV):cargarRestitucionEquipo");
        CargaRestitucionEquipoOutDTO outDTO = new CargaRestitucionEquipoOutDTO();
        AbonadoDTO abonadoDTO = new AbonadoDTO();
        SiniestroDTO siniestroDTO = new SiniestroDTO();
        UsuarioDTO usuarioDTO = new UsuarioDTO();

        try {
            /**
             * Se verifica que el vendedor este en condiciones de realizar la
             * transaccion
             */
            usuarioDTO.setStrNomUsuario(inDTO.getStrNomUsuario().toUpperCase());
            usuarioDTO = usuarioBO.obtenerDatosUsuario(usuarioDTO);

            vendedorBO.validarEstadoVendedor(usuarioDTO);

            vendedorBO.bloqueaDesbloqueaVendedor(usuarioDTO, "B");

            siniestroDTO.setLonNumSiniestro(inDTO.getLonNumSiniestro());
            siniestroDTO = siniestroBO.obtenerDatosSiniestro(siniestroDTO);
            siniestroBO.validaOrdenRestitucion(siniestroDTO, inDTO.getShoCantSiniestros());

            abonadoDTO.setLonNumAbonado(inDTO.getLonNumAbonado());
            abonadoDTO = abonadoBO.obtenerDatosAbonado(abonadoDTO);

            siniestroBO.validaFechas(siniestroDTO, inDTO.getStrFecRestitucion());

            abonadoBO.validarRecambio(abonadoDTO, usuarioDTO);

            ProductoDTO productoDTO = serieBO.obtieneInfoProductoAbonado(abonadoDTO.getLonNumAbonado(), siniestroDTO.getStrTipTerminal());

            ContratoDTO contratoDTO = new ContratoDTO();
            contratoDTO.setStrCodTipContrato(abonadoDTO.getStrCodTipContrato());
            contratoDTO = generalBO.obtieneDetalleContrato(contratoDTO);

            ParametroDTO parametroDTO = new ParametroDTO();
            parametroDTO.setStrNombreParametro(getValorInterno("parametro.despliegue.contrato"));
            parametroDTO = generalBO.obtieneParametros(parametroDTO);

            EquipoAntiguoDTO equipoAntiguoDTO = new EquipoAntiguoDTO();
            equipoAntiguoDTO.setStrDesContrato(contratoDTO.getStrDesTipContrato());
            equipoAntiguoDTO.setStrDesUso(productoDTO.getStrDesUso());
            equipoAntiguoDTO.setStrDesEquipo(productoDTO.getStrDesEquipo());
            equipoAntiguoDTO.setStrNumSerie(productoDTO.getStrNumSerie());
            equipoAntiguoDTO.setStrModalidadVenta(productoDTO.getStrDesModVenta());
            equipoAntiguoDTO.setStrProcedencia(productoDTO.getStrDesProcequi());
            equipoAntiguoDTO.setStrSerieMec(productoDTO.getStrNumSerieMec());
            equipoAntiguoDTO.setStrTipTerminal(productoDTO.getStrDesTerminal());
            equipoAntiguoDTO.setStrPropiedad(productoDTO.getStrIndPropiedad());
            outDTO.setEquipoAntiguoDTO(equipoAntiguoDTO);
            outDTO.setContratoDTOs(generalBO.obtieneListaContratos(usuarioDTO.getStrNomUsuario(), getValorInterno("parametro.programa.gre"), abonadoDTO
                    .getStrIndEqPrestado()));
            outDTO.setProrrogaDTOs(generalBO.obtieneListaProrrogas());
            outDTO.setCatTributariaDTOs(generalBO.obtieneListaCategorias(abonadoDTO.getLonCodCliente()));
            outDTO.setLonNumCelular(abonadoDTO.getLonNumCelular());
            outDTO.setStrNomUsuario(usuarioDTO.getStrNomUsuario());
            outDTO.setStrFolioContrato(obtenerFolioContrato());
            outDTO.setStrDespIngContrato(parametroDTO.getStrValorParametro());

        } catch (GestionLimiteConsumoException e) {
            loggerInfo(e.getDescripcionEvento());
            if (usuarioDTO.getIntCodVendedor() != null) {
                vendedorBO.bloqueaDesbloqueaVendedor(usuarioDTO, "D");
            }
            throw e;
        } catch (Exception e) {
            if (usuarioDTO.getIntCodVendedor() != null) {
                vendedorBO.bloqueaDesbloqueaVendedor(usuarioDTO, "D");
            }
            throw new GestionLimiteConsumoException("Sucedio un error inesperado durante la ejecucion.", 0);
        }
        loggerInfo("Fin(SRV):cargarRestitucionEquipo");
        return outDTO;
    }

    public RecargaCboModalidadOutDTO recargarCboModalidad(RecargaCboModalidadInDTO inDTO) throws GestionLimiteConsumoException {
        loggerInfo("Inicio(SRV):recargarCboModalidad");
        RecargaCboModalidadOutDTO outDTO = new RecargaCboModalidadOutDTO();
        ContratoDTO contratoDTO = new ContratoDTO();
        UsuarioDTO usuarioDTO = new UsuarioDTO();
        AbonadoDTO abonadoDTO = new AbonadoDTO();

        try {
            abonadoDTO.setLonNumAbonado(inDTO.getLonNumAbonado());
            abonadoDTO = abonadoBO.obtenerDatosAbonado(abonadoDTO);

            usuarioDTO.setStrNomUsuario(inDTO.getStrNomUsuario().toUpperCase());
            usuarioDTO = usuarioBO.obtenerDatosUsuario(usuarioDTO);

            contratoDTO.setStrCodTipContrato(inDTO.getStrCodTipContrato());
            contratoDTO = generalBO.obtieneDetalleContrato(contratoDTO);

            outDTO.setModalidadDTOs(generalBO.obtieneListaModalidad(usuarioDTO, getValorInterno("parametro.programa.gpa"), contratoDTO, abonadoDTO
                    .getStrCodPlanTarif()));

        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            throw new GestionLimiteConsumoException("Sucedio un error inesperado durante la ejecucion.");
        }
        loggerInfo("Fin(SRV):recargarCboModalidad");
        return outDTO;
    }

    public RecargaCboCuotasOutDTO recargarCboCuotas(RecargaCboCuotasInDTO inDTO) throws GestionLimiteConsumoException {
        loggerInfo("Inicio(SRV):recargarCboCuotas");
        RecargaCboCuotasOutDTO outDTO = new RecargaCboCuotasOutDTO();
        try {

            outDTO.setCuotaDTOs(generalBO.obtieneListaCuotas(inDTO.getStrNomUsuario(), inDTO.getShoCodModVenta()));

        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            throw new GestionLimiteConsumoException("Sucedio un error inesperado durante la ejecucion.");
        }
        loggerInfo("Fin(SRV):recargarCboCuotas");
        return outDTO;
    }

    public CargaSeleccionEquipoOutDTO cargarSeleccionEquipo(CargaSeleccionEquipoInDTO inDTO) throws GestionLimiteConsumoException {
        loggerInfo("Inicio(SRV):cargarSeleccionEquipo");
        CargaSeleccionEquipoOutDTO outDTO = new CargaSeleccionEquipoOutDTO();

        UsuarioDTO usuarioDTO = new UsuarioDTO();
        try {
            AbonadoDTO abonadoDTO = new AbonadoDTO();
            abonadoDTO.setLonNumAbonado(inDTO.getLonNumAbonado());
            abonadoDTO = abonadoBO.obtenerDatosAbonado(abonadoDTO);

            ClienteDTO clienteDTO = new ClienteDTO();
            clienteDTO.setLonCodCliente(abonadoDTO.getLonCodCliente());
            clienteDTO = clienteBO.obtenerOperadoraCliente(clienteDTO);

            usuarioDTO.setStrNomUsuario(inDTO.getStrNomUsuario());
            usuarioDTO = usuarioBO.obtenerDatosUsuario(usuarioDTO);

            SiniestroDTO siniestroDTO = new SiniestroDTO();
            siniestroDTO.setLonNumSiniestro(inDTO.getLonNumSiniestro());
            siniestroDTO = siniestroBO.obtenerDatosSiniestro(siniestroDTO);

            outDTO.setBodegaDTOs(generalBO.obtieneListaBodegas(usuarioDTO.getIntCodVendedor(), clienteDTO.getStrCodOperadora()));
            outDTO.setEstadoDTOs(generalBO.obtieneListaEstados());
            outDTO.setUsoDTOs(generalBO.obtieneListaUsos());
            outDTO.setArticuloDTOs(generalBO.obtieneListaArticulos(siniestroDTO.getStrTipTerminal(), abonadoDTO.getStrCodTecnologia()));

        } catch (GestionLimiteConsumoException e) {
            if (usuarioDTO.getIntCodVendedor() != null) {
                vendedorBO.bloqueaDesbloqueaVendedor(usuarioDTO, "D");
            }
            throw e;
        } catch (Exception e) {
            if (usuarioDTO.getIntCodVendedor() != null) {
                vendedorBO.bloqueaDesbloqueaVendedor(usuarioDTO, "D");
            }
            throw new GestionLimiteConsumoException("Sucedio un error inesperado durante la ejecucion.");
        }
        loggerInfo("Fin(SRV):cargarSeleccionEquipo");
        return outDTO;
    }

    public RecargaListSeriesOutDTO recargaListSeries(RecargaListSeriesInDTO inDTO) throws GestionLimiteConsumoException {
        loggerInfo("Inicio(SRV):recargaListSeries");
        RecargaListSeriesOutDTO outDTO = new RecargaListSeriesOutDTO();

        PlanTarifarioDTO planTarifarioDTO = new PlanTarifarioDTO();
        AbonadoDTO abonadoDTO = new AbonadoDTO();
        try {
            abonadoDTO.setLonNumAbonado(inDTO.getLonNumAbonado());
            abonadoDTO = abonadoBO.obtenerDatosAbonado(abonadoDTO);

            planTarifarioDTO.setStrCodPlanTarif(abonadoDTO.getStrCodPlanTarif());
            planTarifarioDTO = planTarifarioBO.getDetallePlanTarifario(planTarifarioDTO);

            ParametroDTO parametroDTO = new ParametroDTO();
            parametroDTO.setStrNombreParametro(getValorInterno("parametro.codigo.operacion.re"));
            parametroDTO = generalBO.obtieneParametros(parametroDTO);

            ContratoDTO contratoDTO = new ContratoDTO();
            contratoDTO.setStrCodTipContrato(inDTO.getConsultaSeriesDTO().getStrCodTipContrato());
            contratoDTO = generalBO.obtieneDetalleContrato(contratoDTO);

            SiniestroDTO siniestroDTO = new SiniestroDTO();
            siniestroDTO.setLonNumSiniestro(inDTO.getLonNumSiniestro());
            siniestroDTO = siniestroBO.obtenerDatosSiniestro(siniestroDTO);

            inDTO.getConsultaSeriesDTO().setIntIndCausa(Integer.valueOf(parametroDTO.getStrValorParametro()));
            inDTO.getConsultaSeriesDTO().setIntNumMeses(Integer.valueOf(contratoDTO.getStrMesesMinimo()));
            inDTO.getConsultaSeriesDTO().setStrCodOperacion(getValorInterno("parametro.codigo.operacion.re"));
            inDTO.getConsultaSeriesDTO().setStrTipTerminal(siniestroDTO.getStrTipTerminal());
            inDTO.getConsultaSeriesDTO().setStrCodCategoria(planTarifarioDTO.getStrCodCategoria());

            outDTO.setSerieDTOs(serieBO.obtieneListadoSeries(inDTO.getConsultaSeriesDTO()));

        } catch (GestionLimiteConsumoException e) {
            throw e;
        } catch (Exception e) {
            throw new GestionLimiteConsumoException("Sucedio un error inesperado durante la ejecucion.");
        }
        loggerInfo("Fin(SRV):recargaListSeries");
        return outDTO;
    }

    public EjecutaRestitucionEquipoOutDTO ejecutarRestitucionEquipo(EjecutaRestitucionEquipoInDTO inDTO) throws GestionLimiteConsumoException {
        EjecutaRestitucionEquipoOutDTO outDTO = new EjecutaRestitucionEquipoOutDTO();
        loggerInfo("Inicio(SRV):ejecutarRestitucionEquipo");
        UsuarioDTO usuarioDTO = new UsuarioDTO();
        AbonadoDTO abonadoDTO = new AbonadoDTO();
        SiniestroDTO siniestroDTO = new SiniestroDTO();
        SerieDTO serieDTO = new SerieDTO();
        FolioDTO folioDTO = new FolioDTO();
        InterfazAbonadoDTO interfazAbonadoDTO = new InterfazAbonadoDTO();
        // try {
        usuarioDTO.setStrNomUsuario(inDTO.getStrNomUsuario().toUpperCase());
        usuarioDTO = usuarioBO.obtenerDatosUsuario(usuarioDTO);

        abonadoDTO.setLonNumAbonado(inDTO.getLonNumAbonado());
        abonadoDTO = abonadoBO.obtenerDatosAbonado(abonadoDTO);

        siniestroDTO.setLonNumSiniestro(inDTO.getLonNumSiniestro());
        siniestroDTO = siniestroBO.obtenerDatosSiniestro(siniestroDTO);

        serieDTO.setStrNumSerie(inDTO.getStrNumSerie());
        serieDTO.setShoCodUso(inDTO.getShoCodUso());
        serieDTO.setStrTipTerminal(siniestroDTO.getStrTipTerminal());
        serieDTO = serieBO.obtieneDatosSerie(serieDTO);

        oossBO.cosultaFolio(usuarioDTO, inDTO.getStrCodCatTribut(), Integer.valueOf(getValorInterno("parametro.BusquedaSinRango")), folioDTO, Integer
                .valueOf(0));

        /** INSERTA GA_RESERVART **/
        outDTO.setLonNumTransacReserva(serieBO.reservaArticulo(serieDTO, usuarioDTO));
        /** RESERVA STOCK **/
        String strNumTransaccion = generalBO.obtieneNextValSecuencia(getValorInterno("parametro.nombre.seq.transacabo"));
        serieBO.actualizaStock(serieDTO, null, getValorInterno("movimiento.reserva.venta"), strNumTransaccion);

        ejecInterface(interfazAbonadoDTO, abonadoDTO, inDTO.getStrCodModVenta());

        outDTO.setIntTipPantalla(oossBO.defineTipPantalla(Short.valueOf(inDTO.getStrCodModVenta()), abonadoDTO, inDTO.getStrCodTipContrato(), serieDTO));
        String strIndComodatoOLD;
        if (abonadoDTO.getStrIndEqPrestado() == null || "".equals(abonadoDTO.getStrIndEqPrestado())) {
            strIndComodatoOLD = "0";
        } else {
            strIndComodatoOLD = abonadoDTO.getStrIndEqPrestado();
        }
        outDTO.setStrIndComodato(strIndComodatoOLD);
        outDTO.setStrTipStock(serieDTO.getStrTipStock());

        /*
         * } catch (GestionLimiteConsumoException e) { loggerError(e); if
         * (usuarioDTO.getIntCodVendedor() != null)
         * vendedorBO.bloqueaDesbloqueaVendedor(usuarioDTO, "D"); if
         * (outDTO.getLonNumTransacReserva() != null)
         * serieBO.rollbackReservaSerie(outDTO.getLonNumTransacReserva()); throw
         * e; } catch (Exception e) { if (usuarioDTO.getIntCodVendedor() !=
         * null) vendedorBO.bloqueaDesbloqueaVendedor(usuarioDTO, "D"); if
         * (outDTO.getLonNumTransacReserva() != null)
         * serieBO.rollbackReservaSerie(outDTO.getLonNumTransacReserva());
         * loggerError(e); throw newGestionLimiteConsumoException(
         * "Sucedio un error inesperado durante la ejecucion."); }
         */
        loggerInfo("Fin(SRV):ejecutarRestitucionEquipo");
        return outDTO;
    }

    public EjecutaCierreRestitucionOutDTO ejecutarCierreOOSS(EjecutaCierreRestitucionInDTO inDTO) throws GestionLimiteConsumoException {
        EjecutaCierreRestitucionOutDTO outDTO = new EjecutaCierreRestitucionOutDTO();
        loggerInfo("Inicio(SRV):ejecutarCierreOOSS");

        UsuarioDTO usuarioDTO = new UsuarioDTO();
        AbonadoDTO abonadoDTO = new AbonadoDTO();
        ModalidadDTO modalidadDTO = new ModalidadDTO();
        SiniestroDTO siniestroDTO = new SiniestroDTO();
        ContratoDTO contratoDTO = new ContratoDTO();
        ParametroDTO parametroDTO = new ParametroDTO();
        SerieDTO serieDTO = new SerieDTO();
        DatosGeneralesSiniestroDTO generalesSiniestroDTO = new DatosGeneralesSiniestroDTO();
        InterfazAbonadoDTO interfazAbonadoDTO = new InterfazAbonadoDTO();

        String strCodOperacion = "RE";

        // try {
        usuarioDTO.setStrNomUsuario(inDTO.getStrNomUsuario().toUpperCase());
        usuarioDTO = usuarioBO.obtenerDatosUsuario(usuarioDTO);

        abonadoDTO.setLonNumAbonado(inDTO.getLonNumAbonado());
        abonadoDTO = abonadoBO.obtenerDatosAbonado(abonadoDTO);

        SiniestroDTO[] siniestroDTOs = abonadoBO.obtenerSiniestros(abonadoDTO);
        siniestroDTO.setLonNumSiniestro(inDTO.getLonNumSiniestro());
        siniestroDTO = siniestroBO.obtenerDatosSiniestro(siniestroDTO);

        serieDTO.setStrNumSerie(inDTO.getStrNumSerie());
        serieDTO.setShoCodUso(inDTO.getShoCodUso());
        serieDTO.setStrTipTerminal(siniestroDTO.getStrTipTerminal());
        serieDTO = serieBO.obtieneDatosSerie(serieDTO);

        modalidadDTO.setShoCodModVenta(Short.valueOf(inDTO.getStrCodModVenta()));
        modalidadDTO = generalBO.obtieneDatosModalidad(modalidadDTO);

        contratoDTO.setStrCodTipContrato(inDTO.getStrCodTipContrato());
        contratoDTO = generalBO.obtieneDetalleContrato(contratoDTO);

        String strNumeroContrato = null;
        String strNumeroAnexo = null;
        if (inDTO.getStrNumContrato() == null || "".equals(inDTO.getStrNumContrato())) {
            String strCorrelativoContrato = generalBO.obtieneNextValSecuencia(getValorInterno("parametro.nombre.seq.contrato"));
            while ((strCorrelativoContrato.length()) < 9) {
                strCorrelativoContrato = "0" + strCorrelativoContrato;
            }
            strNumeroContrato = "CL-" + strCorrelativoContrato + inDTO.getStrFolioContrato();
        } else {
            strNumeroContrato = "CL-" + inDTO.getStrNumContrato() + inDTO.getStrFolioContrato();
        }
        strNumeroAnexo = strNumeroContrato.substring(0, strNumeroContrato.length() - 1) + "1";

        generalesSiniestroDTO = siniestroBO.obtenerCodCargosBasicos(siniestroDTO, abonadoDTO);
        String strCantSiniestros = String.valueOf(siniestroDTOs.length);
        boolean bChequeaTerminal = siniestroBO.chequeaTerminal(Short.valueOf(strCantSiniestros), siniestroDTO.getStrTipTerminal(), abonadoDTO
                .getStrCodTecnologia());
        if (bChequeaTerminal) {
            if (!generalesSiniestroDTO.getStrCargoBasOri().equals(generalesSiniestroDTO.getStrCargoBasAnt())) {
                ejecutarPLCargoBasico(interfazAbonadoDTO, abonadoDTO, inDTO.getStrCodModVenta());
            }
        }

        parametroDTO.setStrNombreParametro(getValorInterno("parametro.causa.restitucion"));
        parametroDTO = generalBO.obtieneParametros(parametroDTO);

        oossBO.insertaModabocel(abonadoDTO, strCodOperacion, siniestroDTO, usuarioDTO, parametroDTO.getStrValorParametro(), contratoDTO);

        boolean bPLista = generalBO.obtieneBPLista(abonadoDTO, serieDTO);

        if ("T".equals(serieDTO.getStrTipTerminal())) {
            oossBO.insertaEquipAboSerEqui(serieDTO, inDTO.getLonNumTransacReserva(), false, abonadoDTO, bPLista, inDTO.getStrCodModVenta(), contratoDTO
                    .getStrIndComodato(), null);
        } else {
            oossBO.insertaEquipAboSerSim(serieDTO, inDTO.getLonNumTransacReserva(), false, abonadoDTO, bPLista, inDTO.getStrCodModVenta(), contratoDTO
                    .getStrIndComodato(), null);
        }

        oossBO.actualizarAbonado(abonadoDTO, serieDTO, "I", contratoDTO, bChequeaTerminal, strNumeroContrato, strNumeroAnexo);

        oossBO.insertaContrato(abonadoDTO, contratoDTO, strNumeroContrato, strNumeroAnexo);

        parametroDTO = new ParametroDTO();
        parametroDTO.setStrNombreParametro(getValorInterno("parametro.simcard.gsm"));
        parametroDTO = generalBO.obtieneParametros(parametroDTO);
        String strTipSimCard = parametroDTO.getStrValorParametro();

        if (serieDTO.getStrTipStock() != null && !"".equals(serieDTO.getStrTipStock())) {
            if (modalidadDTO.getShoIndCuotas().shortValue() == 2 || "1".equals(contratoDTO.getStrIndComodato())) {
                if (!serieDTO.getStrTipTerminal().equals(strTipSimCard)) {
                    oossBO.movBodegaSalidaTemporal(serieDTO, inDTO.getLonNumVenta());
                } else {
                    oossBO.movBodegaSalidaDefinitiva(serieDTO, null);
                }
            } else {
                if (!serieDTO.getStrTipStock().equals(getValorInterno("parametro.tipStock.activofijo"))) {
                    if (!serieDTO.getStrTipTerminal().equals(strTipSimCard)) {
                        oossBO.movBodegaSalidaDefinitiva(serieDTO, null);
                    } else {
                        oossBO.movBodegaSalidaDefinitiva(serieDTO, inDTO.getLonNumVenta());
                    }
                }
            }
            serieBO.desReservaArticulo(inDTO.getLonNumTransacReserva());
        }

        String strSecICC2 = generalBO.obtieneNextValSecuencia(getValorInterno("parametro.nombre.iccnumos"));
        String strSecICC1 = generalBO.obtieneNextValSecuencia(getValorInterno("parametro.nombre.iccnumos"));

        String strNumOS = generalBO.obtieneNextValSecuencia(getValorInterno("parametro.nombre.seq.numos"));
        oossBO.insertaMovimiento(abonadoDTO, siniestroDTO, serieDTO, Long.valueOf(strNumOS), getValorInterno("COD.OS.RESTITUCION"), Long.valueOf(strSecICC1),
                usuarioDTO.getStrNomUsuario(), Long.valueOf(strSecICC2));

        outDTO.setLonNumOOSS(oossBO.insertaCiOrServ(inDTO.getStrComentario(), inDTO.getStrNomUsuario(), abonadoDTO.getLonNumAbonado(), inDTO.getLonNumVenta(),
                strNumOS));

        if (bChequeaTerminal) {
            oossBO.rehabilitarSuspension(abonadoDTO, siniestroDTO, Long.valueOf(strNumOS), getValorInterno("COD.OS.RESTITUCION"), Long.valueOf(strSecICC1),
                    usuarioDTO.getStrNomUsuario(), getValorInterno("parametro.codigo.actabo.rt"));

            oossBO.cambiarEstadoMovimientoICC(Long.valueOf(strSecICC2));
        }
        loggerDebug("antes de ejecucion siniestroBO.restituirSiniestro(siniestroDTO)");
        siniestroBO.restituirSiniestro(siniestroDTO);
        loggerDebug("fin de ejecucion siniestroBO.restituirSiniestro(siniestroDTO)");
        siniestroBO.pasoHistorico(siniestroDTO);

        if (usuarioDTO.getIntCodVendedor() != null) {

            vendedorBO.bloqueaDesbloqueaVendedor(usuarioDTO, "D");
        }

        /*
         * } catch (GestionLimiteConsumoException e) { if
         * (inDTO.getLonNumTransacReserva() != null)
         * serieBO.rollbackReservaSerie(inDTO.getLonNumTransacReserva());
         * loggerInfo(e.getDescripcionEvento()); throw e; } catch (Exception e)
         * { if (inDTO.getLonNumTransacReserva() != null)
         * serieBO.rollbackReservaSerie(inDTO.getLonNumTransacReserva()); throw
         * newGestionLimiteConsumoException(
         * "Sucedio un error inesperado durante la ejecucion.", 0); } finally {
         * if (usuarioDTO.getIntCodVendedor() != null)
         * vendedorBO.bloqueaDesbloqueaVendedor(usuarioDTO, "D"); }
         */
        loggerInfo("Fin(SRV):ejecutarCierreOOSS");
        return outDTO;
    }

    private void validarRestricciones(AbonadoDTO abonadoDTO) throws GestionLimiteConsumoException {
        RestriccionesDTO restriccionesDTO = new RestriccionesDTO();
        restriccionesDTO.setStrSecuencia(generalBO.obtieneNextValSecuencia(getValorInterno("parametro.nombre.seq.transacabo")));
        restriccionesDTO.setStrCodModulo(getValorInterno("parametro.codigo.modulo.ga"));
        restriccionesDTO.setStrCodProducto(getValorInterno("parametro.codigo.producto.uno"));
        restriccionesDTO.setStrCodActAbo(getValorInterno("parametro.codigo.actabo.fs"));
        restriccionesDTO.setStrEvento(getValorInterno("parametro.evento.formload.4"));
        restriccionesDTO.setStrNumAbonado(abonadoDTO.getLonNumAbonado().toString());
        restriccionesDTO.setStrCodCliente(abonadoDTO.getLonCodCliente().toString());
        restriccionesDTO.setStrCodOs(getValorInterno("COD.OS.RESTITUCION"));
        restriccionesDTO.setStrCodModGener(getValorInterno("parametro.codigo.modgener.osf"));
        restriccionesDTO.setStrPrograma(getValorInterno("parametro.programa.gpa"));
        restriccionesDTO.setStrNumVenta(abonadoDTO.getLonNumVenta().toString());
        generalBO.ejecutaModeloRestriccion(restriccionesDTO);

    }

    private String obtenerFolioContrato() {
        Date date = new Date();
        String strYear = String.valueOf(date.getYear() + 1900);
        String strCorrelativo = "-" + strYear.substring(2, 4) + "-00000";
        return strCorrelativo;
    }

    private InterfazAbonadoDTO ejecInterface(InterfazAbonadoDTO pInterfazAbonadoDTO, AbonadoDTO pAbonadoDTO, String pStrCodModVenta)

        throws GestionLimiteConsumoException {
        pInterfazAbonadoDTO.setStrActabo(getValorInterno("parametro.codigo.actabo.interface"));
        pInterfazAbonadoDTO.setStrProducto(getValorInterno("parametro.codigo.producto.uno"));
        pInterfazAbonadoDTO.setStrAbonado(pAbonadoDTO.getLonNumAbonado().toString());
        pInterfazAbonadoDTO.setStrOrigen(" ");
        pInterfazAbonadoDTO.setStrDestino(pStrCodModVenta);
        pInterfazAbonadoDTO.setStrVar3(" ");

        InterfazAbonadoDTO interfazAbonadoDTO = oossBO.ejecutaInterfasesAbonados(pInterfazAbonadoDTO);

        return interfazAbonadoDTO;
    }

    private InterfazAbonadoDTO ejecutarPLCargoBasico(InterfazAbonadoDTO interfazAbonadoDTO, AbonadoDTO abonadoDTO, String strCodModVenta)

        throws GestionLimiteConsumoException {
        interfazAbonadoDTO.setStrActabo(getValorInterno("parametro.codigo.actabo.CargoBasico"));
        interfazAbonadoDTO.setStrProducto(getValorInterno("parametro.codigo.producto.uno"));
        interfazAbonadoDTO.setStrAbonado(abonadoDTO.getLonNumAbonado().toString());
        oossBO.ejecutaInterfasesAbonados(interfazAbonadoDTO);

        return interfazAbonadoDTO;
    }

    public void desbloqueaVendedor(UsuarioDTO usuarioDTO) throws GestionLimiteConsumoException {

        loggerInfo("Inicio(SRV):desbloqueaVendedor");
        String desbloqueo = getValorInterno("parametro.desbloqueo.vendedor");
        vendedorBO.bloqueaDesbloqueaVendedor(usuarioDTO, desbloqueo);

        loggerInfo("Fin (SRV):desbloqueaVendedor");

    }

    /**
     * rollback reserva de serie
     * 
     * @param
     * @return
     * @throws GestionLimiteConsumoException
     */
    public void rollbackReservaSerie(Long lonNumTransaccion) throws GestionLimiteConsumoException {
        loggerDebug("Inicio(SRV):rollbackReservaSerie");

        serieBO.rollbackReservaSerie(lonNumTransaccion);

        loggerDebug("Fin(SRV):rollbackReservaSerie");
    }
}
