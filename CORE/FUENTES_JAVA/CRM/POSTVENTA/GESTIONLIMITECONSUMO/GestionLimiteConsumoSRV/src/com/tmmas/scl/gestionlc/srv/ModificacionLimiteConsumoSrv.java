package com.tmmas.scl.gestionlc.srv;

import com.tmmas.scl.gestionlc.bo.AbonadoBO;
import com.tmmas.scl.gestionlc.bo.GeneralBO;
import com.tmmas.scl.gestionlc.bo.LimiteConsumoBO;
import com.tmmas.scl.gestionlc.bo.PlanTarifarioBO;
import com.tmmas.scl.gestionlc.bo.SegmentacionBO;
import com.tmmas.scl.gestionlc.common.dto.AbonadoDTO;
import com.tmmas.scl.gestionlc.common.dto.LimiteConsumoInDTO;
import com.tmmas.scl.gestionlc.common.dto.LimiteConsumoOutDTO;
import com.tmmas.scl.gestionlc.common.dto.LimitePendienteInDTO;
import com.tmmas.scl.gestionlc.common.dto.LimitePendienteOutDTO;
import com.tmmas.scl.gestionlc.common.dto.ParametroDTO;
import com.tmmas.scl.gestionlc.common.dto.PlanTarifarioInDTO;
import com.tmmas.scl.gestionlc.common.dto.PlanTarifarioOutDTO;
import com.tmmas.scl.gestionlc.common.dto.RestriccionesDTO;
import com.tmmas.scl.gestionlc.common.dto.SegmentacionInDTO;
import com.tmmas.scl.gestionlc.common.dto.SegmentacionOutDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.CargaAbonoLimiteConsumoOutDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.CargaModificacionLimiteConsumoInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.CargaModificacionLimiteConsumoOutDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.EjecutaModificacionLimiteConsumoInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.EjecutaModificacionLimiteConsumoOutDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.WSAbonadoMLCDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.WSCargaModificacionLimiteConsumoInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.WSCargaModificacionLimiteConsumoOutDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.WSEjecutaModificacionLimiteConsumoInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.WSEjecutaModificacionLimiteConsumoOutDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.WSLimiteConsumoMLCDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.WSSegmentacionMLCDTO;
import com.tmmas.scl.gestionlc.common.exception.GestionLimiteConsumoException;
import com.tmmas.scl.gestionlc.srv.common.GestionLimiteConsumoAbstractSRV;

public class ModificacionLimiteConsumoSrv extends GestionLimiteConsumoAbstractSRV {

    private AbonadoBO abonadoBO = new AbonadoBO();
    private GeneralBO generalBO = new GeneralBO();
    private LimiteConsumoBO limiteConsumoBO = new LimiteConsumoBO();
    private SegmentacionBO segmentacionBO = new SegmentacionBO();
    private PlanTarifarioBO planTarifarioBO = new PlanTarifarioBO();

    /**
     * Permite la carga de los datos para la Modificacion Limite de Consumo
     * 
     * @param pIn
     * @throws GestionLimiteConsumoException
     */
    public CargaModificacionLimiteConsumoOutDTO cargarModificacionLimiteConsumo(CargaModificacionLimiteConsumoInDTO pIn) throws GestionLimiteConsumoException {

        loggerDebug("Inicio CargaModificacionLimiteConsumoOutDTO");
        CargaModificacionLimiteConsumoOutDTO result = null;

        // busqueda de datos de abonado
        LimiteConsumoInDTO limiteConsumoInDTO = null;
        SegmentacionInDTO segmentacionINDTO = null;
        PlanTarifarioInDTO planTarifarioInDTO = null;

        AbonadoDTO abonadoDTO = new AbonadoDTO();

        abonadoDTO.setLonNumAbonado(pIn.getLonNumAbonado());
        abonadoDTO = abonadoBO.obtenerDatosAbonado(abonadoDTO);

        // obtiene ciclo pendiente
        abonadoDTO = abonadoBO.obtenerCicloPendiente(abonadoDTO);

        // busqueda del numero decimal de tabla GED_PARAMETRO
        String strValorNumeroDecimal = getValorInterno("parametro.valor.numero.decimal");
        loggerDebug("Numero Decimal String: " + strValorNumeroDecimal);
        loggerDebug("Numero Decimal Properties: " + getValorInterno("parametro.valor.numero.decimal"));

        ParametroDTO parametroIn = new ParametroDTO();

        parametroIn.setStrNombreParametro(strValorNumeroDecimal);

        ParametroDTO parametroOut = generalBO.obtieneParametros(parametroIn);

        loggerDebug("Valor Parametro: " + parametroOut.getStrValorParametro());

        // busqueda que verifica si existen modificacion de limite de consumo
        // pendiente
        LimitePendienteInDTO limitePendienteInDTO = new LimitePendienteInDTO();
        limitePendienteInDTO.setLonCodCliente(abonadoDTO.getLonCodCliente());
        limitePendienteInDTO.setLonNunAbonado(abonadoDTO.getLonNumAbonado());

        LimitePendienteOutDTO limitePendienteOutDTO = limiteConsumoBO.obtenerLimitePendiente(limitePendienteInDTO);

        loggerDebug("Limite Pendiente: " + limitePendienteOutDTO.getIntLimPendiente());

        // busqueda de datos para el limite de consumo
        LimiteConsumoOutDTO limiteConsumoOutDTO = null;

        limiteConsumoOutDTO = new LimiteConsumoOutDTO();
        limiteConsumoInDTO = new LimiteConsumoInDTO();
        limiteConsumoInDTO.setLonNumAbonado(pIn.getLonNumAbonado());
        limiteConsumoOutDTO = limiteConsumoBO.obtenerLimiteConsumo(limiteConsumoInDTO);

        // busqueda de datos para segmentacion
        SegmentacionOutDTO segmentacionOutDTO = null;

        segmentacionOutDTO = new SegmentacionOutDTO();
        segmentacionINDTO = new SegmentacionInDTO();
        segmentacionINDTO.setLonCodCliente(abonadoDTO.getLonCodCliente());
        segmentacionOutDTO = segmentacionBO.obtieneSegmentacion(segmentacionINDTO);

        if (segmentacionOutDTO == null) {

            throw new GestionLimiteConsumoException("ERR.0012", 0);
        }

        loggerDebug("segmentacionOutDTO.getStrCodColor()" + segmentacionOutDTO.getStrCodColor());
        loggerDebug("segmentacionOutDTO.getStrDescColor()" + segmentacionOutDTO.getStrDescColor());
        loggerDebug("segmentacionOutDTO.getStrCodSegmento()" + segmentacionOutDTO.getStrCodSegmento());
        loggerDebug("segmentacionOutDTO.getStrDescSegmento()" + segmentacionOutDTO.getStrDescSegmento());
        // busqueda datos para el plan tarifario
        PlanTarifarioOutDTO planTarifarioOutDTO = null;

        planTarifarioOutDTO = new PlanTarifarioOutDTO();
        planTarifarioInDTO = new PlanTarifarioInDTO();
        planTarifarioInDTO.setStrCodPlanTarif(abonadoDTO.getStrCodPlanTarif());
        planTarifarioOutDTO = planTarifarioBO.obtienePlanTarifario(planTarifarioInDTO);

        // validaciones
        validaciones(abonadoDTO, planTarifarioOutDTO, limiteConsumoOutDTO, segmentacionOutDTO);

        result = new CargaModificacionLimiteConsumoOutDTO();

        // se carga el objeto que tendra los datos de carga
        result.setAbonado(abonadoDTO);
        result.setLimiteConsumo(limiteConsumoOutDTO);
        result.setSegmentacion(segmentacionOutDTO);
        result.setPlanTarifario(planTarifarioOutDTO);
        result.setStrNumDecimal(parametroOut.getStrValorParametro());
        result.setIntLimPendiente(limitePendienteOutDTO.getIntLimPendiente());

        loggerDebug("Inicio CargaModificacionLimiteConsumoOutDTO");
        return result;

    }

    /**
     * Permite la carga de los datos para la Modificacion Limite de Consumo
     * 
     * @param pIn
     * @throws GestionLimiteConsumoException
     */
    public WSCargaModificacionLimiteConsumoOutDTO cargarModificacionLimiteConsumoWS(WSCargaModificacionLimiteConsumoInDTO pIn) throws GestionLimiteConsumoException {

        loggerDebug("Inicio cargarModificacionLimiteConsumoWS");
        WSCargaModificacionLimiteConsumoOutDTO result = null;
        CargaModificacionLimiteConsumoInDTO cargaModificacionLimiteConsumoInDTO = new CargaModificacionLimiteConsumoInDTO();
        CargaModificacionLimiteConsumoOutDTO cargaModificacionLimiteConsumoOutDTO = new CargaModificacionLimiteConsumoOutDTO();
        
        cargaModificacionLimiteConsumoInDTO.setLonNumAbonado(Long.valueOf(pIn.getStrNumAbonado()));
        cargaModificacionLimiteConsumoOutDTO = cargarModificacionLimiteConsumo(cargaModificacionLimiteConsumoInDTO);
        
        //inicio incidencia 169415 09/06/2011 FDL
        String estadoVenta;
        Long numAbonado = Long.valueOf(pIn.getStrNumAbonado());
        estadoVenta = generalBO.obtieneEstadoVenta(numAbonado);
        
        loggerDebug("************************************");
        loggerDebug("Estado Venta: "+estadoVenta);
        loggerDebug("************************************");
        
        cargaModificacionLimiteConsumoOutDTO.setStrEstadoVenta(estadoVenta);
        
        //validaciones para el WS
        validacionesWS(cargaModificacionLimiteConsumoOutDTO);
        //inicio incidencia 169415 09/06/2011 FDL
        
        // carga los datos en WSCargaModificacionLimiteConsumoOutDTO
        result = new WSCargaModificacionLimiteConsumoOutDTO();
        result.setWsAbonadoDTO(cargaAbonadoWS(cargaModificacionLimiteConsumoOutDTO));
        result.setWsLimiteConsumoDTO(cargaLimiteConsumoWS(cargaModificacionLimiteConsumoOutDTO));
        result.setWsSegmentacionDTO(cargaSegmentacionWS(cargaModificacionLimiteConsumoOutDTO));

        loggerDebug("Fin cargarModificacionLimiteConsumoWS");
        return result;

    }

    /**
     * Permite ejecutar y finalizar la Modificacion Limite de Consumo
     * 
     * @param pIn
     * @throws GestionLimiteConsumoException
     */
    public EjecutaModificacionLimiteConsumoOutDTO ejecutarModificacionLimiteConsumo(EjecutaModificacionLimiteConsumoInDTO pIn)
        throws GestionLimiteConsumoException {

        EjecutaModificacionLimiteConsumoOutDTO result = new EjecutaModificacionLimiteConsumoOutDTO();

        // obtener el num OOSS
        String strNomSeqNumOoSs = getValorInterno("parametro.nombre.seq.numos");
        loggerDebug("strNomSeqNumOoSs: " + strNomSeqNumOoSs);

        String valueSeqNumOoSs = generalBO.obtieneNextValSecuencia(strNomSeqNumOoSs);
        loggerDebug("valueSeqNumOoSs: " + valueSeqNumOoSs);

        pIn.setLonNumOOSS(Long.valueOf(valueSeqNumOoSs));
        pIn.setStrCodOOSS(getValorInterno("COD.OS.MODIFICACIONLIMITECONSUMO"));
        pIn.setIntCodProducto(Integer.valueOf(getValorInterno("parametro.codigo.producto.uno")));

        loggerDebug("Ingresa a LimiteConsumoBO");
        limiteConsumoBO.ejecutaModificacionLimiteConsumo(pIn);
        loggerDebug("Sale LimiteConsumoBO");

        result.setStrNumOOSS(pIn.getLonNumOOSS().toString());

        return result;

    }

    /**
     * Permite ejecutar y finalizar la Modificacion Limite de Consumo
     * 
     * @param pIn
     * @throws GestionLimiteConsumoException
     */
    public WSEjecutaModificacionLimiteConsumoOutDTO ejecutarModificacionLimiteConsumoWS(WSEjecutaModificacionLimiteConsumoInDTO pIn)
        throws GestionLimiteConsumoException {

        WSCargaModificacionLimiteConsumoInDTO wsCargaModificacionLimiteConsumoInDTO = new WSCargaModificacionLimiteConsumoInDTO();
        CargaModificacionLimiteConsumoInDTO cargaModificacionLimiteConsumoInDTO = new CargaModificacionLimiteConsumoInDTO();
        CargaModificacionLimiteConsumoOutDTO cargaModificacionLimiteConsumoOutDTO = new CargaModificacionLimiteConsumoOutDTO();
        WSEjecutaModificacionLimiteConsumoOutDTO result = new WSEjecutaModificacionLimiteConsumoOutDTO();
        EjecutaModificacionLimiteConsumoInDTO ejecutaModificacionLimiteConsumoInDTO = new EjecutaModificacionLimiteConsumoInDTO();
        
        // wsCargaModificacionLimiteConsumoInDTO.setStrNumAbonado(pIn.getStrNumAbonado());
        cargaModificacionLimiteConsumoInDTO.setLonNumAbonado(Long.valueOf(pIn.getStrNumAbonado()));
        cargaModificacionLimiteConsumoOutDTO = cargarModificacionLimiteConsumo(cargaModificacionLimiteConsumoInDTO);
        
      //inicio incidencia 169415 09/06/2011 FDL
        String estadoVenta;
        
        Long numAbonado = Long.valueOf(pIn.getStrNumAbonado());
        estadoVenta = generalBO.obtieneEstadoVenta(numAbonado);
        
        loggerDebug("************************************");
        loggerDebug("Estado Venta: "+estadoVenta);
        loggerDebug("************************************");
        
        cargaModificacionLimiteConsumoOutDTO.setStrEstadoVenta(estadoVenta);
        
        //validaciones para el WS
        validacionesWS(cargaModificacionLimiteConsumoOutDTO);
        //fin incidencia 169415 09/06/2011 FDL
        
        ejecutaModificacionLimiteConsumoInDTO = cargaEjecucionModificacionLimiteConsumoWS(pIn, cargaModificacionLimiteConsumoOutDTO);

        loggerDebug("Ingresa a LimiteConsumoBO");
        limiteConsumoBO.ejecutaModificacionLimiteConsumo(ejecutaModificacionLimiteConsumoInDTO);
        loggerDebug("Sale LimiteConsumoBO");

        result.setStrNumOOSS(ejecutaModificacionLimiteConsumoInDTO.getLonNumOOSS().toString());

        return result;

    }

    /**
     * contiene las validaciones a aplicar a la OOSS
     * 
     * @param abonadoDTO
     * @throws GestionLimiteConsumoException
     */
    private void validaciones(AbonadoDTO abonadoDTO, PlanTarifarioOutDTO planTarifarioOutDTO, LimiteConsumoOutDTO limiteConsumoOutDTO, SegmentacionOutDTO segmentacionOutDTO)
        throws GestionLimiteConsumoException {

        loggerDebug("Inicio metodo validaciones de ModificacionLimiteConsumoSRV");

        // validar que sea abonado postpago
        String strNomSeqTransacabo = getValorInterno("parametro.nombre.seq.transacabo");
        loggerDebug("strNomSeqTransacabo: " + strNomSeqTransacabo);

        String valueSeqTransacabo = generalBO.obtieneNextValSecuencia(strNomSeqTransacabo);
        loggerDebug("valueSeqTransacabo: " + valueSeqTransacabo);

        // ejecutar modelo de restriccion
        RestriccionesDTO restriccionesDTO = new RestriccionesDTO();

        // Entrada sParametros
        restriccionesDTO.setStrSecuencia(valueSeqTransacabo);
        restriccionesDTO.setStrCodModulo(getValorInterno("parametro.codigo.modulo.ga"));
        restriccionesDTO.setStrCodProducto(String.valueOf(abonadoDTO.getShoCodProducto()));
        restriccionesDTO.setStrCodActAbo(getValorInterno("parametro.codigo.actabo.ia"));
        restriccionesDTO.setStrEvento(getValorInterno("parametro.evento.formload"));
        restriccionesDTO.setStrPrograma(getValorInterno("parametro.programa.mlc"));
        restriccionesDTO.setStrCodActAboDet(getValorInterno("parametro.codigo.actabo.ia"));
        restriccionesDTO.setStrCodModGener(getValorInterno("parametro.codigo.modgener.osf"));
        restriccionesDTO.setStrCodOs(getValorInterno("COD.OS.MODIFICACIONLIMITECONSUMO"));
        restriccionesDTO.setStrCodModuloDet(getValorInterno("parametro.codigo.modulo.GC"));
        restriccionesDTO.setStrNumId(getValorInterno("parametro.numero.tarea.8542"));

        // Entrada sParametros
        generalBO.ejecutaModeloRestriccion(restriccionesDTO);

        loggerDebug("TipPlanTarif: " + abonadoDTO.getStrTipPlanTarif());
        // validar que el abonado no posea plan tarifario de tipo empresa
        if ("E".equals(abonadoDTO.getStrTipPlanTarif())) {

            throw new GestionLimiteConsumoException("ERR.0006", 0);
        }

        // El sistema valida que el campo COD_TIPLAN sea igual a 2
        if (!"2".equals(planTarifarioOutDTO.getStrTipPlan())) {

            throw new GestionLimiteConsumoException("ERR.0010", 0);
        }

        // El sistema valida que el objeto limiteConsumoOutDTO tenga datos
        if (limiteConsumoOutDTO == null) {

            throw new GestionLimiteConsumoException("ERR.0011", 0, getValorInterno("ERR.0011") + " " + planTarifarioOutDTO.getStrCodCargoBasico() + getValorInterno("ERR.0014"));
        }

        // El sistema valida que el codigo de color o el codigo de segmento sean
        // distintos de vacio
        if ("".equals(segmentacionOutDTO.getStrCodColor()) || "".equals(segmentacionOutDTO.getStrCodSegmento())) {

            throw new GestionLimiteConsumoException("ERR.0012", 0);
        }

        if (abonadoDTO.getIntSolPendienteCiclo() > 0) {

            throw new GestionLimiteConsumoException("ERR.0015", 0);
        }

        loggerDebug("Fin metodo validaciones de ModificacionLimiteConsumoSRV");

    }
    
    /**
     * contiene las validaciones a aplicar a la OOSS para los WS
     * 
     * @param cargaModificacionLimiteConsumoOutDTO
     * @throws GestionLimiteConsumoException
     */
    private void validacionesWS(CargaModificacionLimiteConsumoOutDTO cargaModificacionLimiteConsumoOutDTO) throws GestionLimiteConsumoException {
        
        if (!"AAA".equals(cargaModificacionLimiteConsumoOutDTO.getAbonado().getStrCodSituacion()) && !"SAA".equals(cargaModificacionLimiteConsumoOutDTO.getAbonado().getStrCodSituacion())) {

            throw new GestionLimiteConsumoException("ERR.0029", 0);

        }
        
        if (!"AC".equals(cargaModificacionLimiteConsumoOutDTO.getStrEstadoVenta())) {

            throw new GestionLimiteConsumoException("ERR.0030", 0, getValorInterno("ERR.0030") + " " +  cargaModificacionLimiteConsumoOutDTO.getAbonado().getLonNumVenta() + " " + getValorInterno("ERR.0031"));

        }

    }

    public WSAbonadoMLCDTO cargaAbonadoWS(CargaModificacionLimiteConsumoOutDTO cargaModificacionLimiteConsumoOutDTO) {

        WSAbonadoMLCDTO result = new WSAbonadoMLCDTO();

        result.setLonNumAbonado(cargaModificacionLimiteConsumoOutDTO.getAbonado().getLonNumAbonado());
        result.setLonNumCelular(cargaModificacionLimiteConsumoOutDTO.getAbonado().getLonNumCelular());
        result.setStrTipPlanTarif(cargaModificacionLimiteConsumoOutDTO.getAbonado().getStrTipPlanTarif());
        result.setStrCodCargoBasico(cargaModificacionLimiteConsumoOutDTO.getPlanTarifario().getStrCodCargoBasico());
        result.setStrDescPlanTarifario(cargaModificacionLimiteConsumoOutDTO.getPlanTarifario().getStrDescPlanTarifario());

        return result;

    }

    public WSLimiteConsumoMLCDTO cargaLimiteConsumoWS(CargaModificacionLimiteConsumoOutDTO cargaModificacionLimiteConsumoOutDTO) {

        WSLimiteConsumoMLCDTO result = new WSLimiteConsumoMLCDTO();

        result.setDouMontoMaximo(cargaModificacionLimiteConsumoOutDTO.getLimiteConsumo().getDouMontoMaximo());
        result.setDouMontoMinimo(cargaModificacionLimiteConsumoOutDTO.getLimiteConsumo().getDouMontoMinimo());
        result.setStrCodLimConsumo(cargaModificacionLimiteConsumoOutDTO.getAbonado().getStrCodLimConsumo());
        result.setStrDescripcion(cargaModificacionLimiteConsumoOutDTO.getLimiteConsumo().getStrDescripcion());
        result.setStrRangoLimiteConsumo(cargaModificacionLimiteConsumoOutDTO.getLimiteConsumo().getStrDescMontMinMax());
        result.setStrFechaDesde(cargaModificacionLimiteConsumoOutDTO.getLimiteConsumo().getStrFechaDesde());
        result.setStrFechaHasta(cargaModificacionLimiteConsumoOutDTO.getLimiteConsumo().getStrFechaHasta());

        return result;

    }

    public WSSegmentacionMLCDTO cargaSegmentacionWS(CargaModificacionLimiteConsumoOutDTO cargaModificacionLimiteConsumoOutDTO) {

        WSSegmentacionMLCDTO result = new WSSegmentacionMLCDTO();

        result.setStrCodColor(cargaModificacionLimiteConsumoOutDTO.getSegmentacion().getStrCodColor());
        result.setStrDescColor(cargaModificacionLimiteConsumoOutDTO.getSegmentacion().getStrDescColor());
        result.setStrCodSegmento(cargaModificacionLimiteConsumoOutDTO.getSegmentacion().getStrCodSegmento());
        result.setStrDescSegmento(cargaModificacionLimiteConsumoOutDTO.getSegmentacion().getStrDescSegmento());

        return result;

    }

    public EjecutaModificacionLimiteConsumoInDTO cargaEjecucionModificacionLimiteConsumoWS(WSEjecutaModificacionLimiteConsumoInDTO wsEjecutaModificacionLimiteConsumoInDTO,
            CargaModificacionLimiteConsumoOutDTO cargaModificacionLimiteConsumoOutDTO) throws GestionLimiteConsumoException {

        EjecutaModificacionLimiteConsumoInDTO result = new EjecutaModificacionLimiteConsumoInDTO();

        result.setLonCodCliente(cargaModificacionLimiteConsumoOutDTO.getAbonado().getLonCodCliente());
        result.setLonNumAbonado(Long.valueOf(wsEjecutaModificacionLimiteConsumoInDTO.getStrNumAbonado()));
        result.setDouDetalleMonto(Double.valueOf(wsEjecutaModificacionLimiteConsumoInDTO.getStrMonto()));

        String respuestContinuar = getValorInterno("parametro.valor.true");

        result.setStrRespContinuar(respuestContinuar.toLowerCase());
        result.setStrCodPlanTarif(cargaModificacionLimiteConsumoOutDTO.getAbonado().getStrCodPlanTarif());
        result.setStrCodLimConsumo(cargaModificacionLimiteConsumoOutDTO.getLimiteConsumo().getStrCodLimCons());
        result.setStrUsuarioBd(wsEjecutaModificacionLimiteConsumoInDTO.getStrUserName());
        result.setStrComentario(wsEjecutaModificacionLimiteConsumoInDTO.getStrComentario());

        String strNomSeqNumOoSs = getValorInterno("parametro.nombre.seq.numos");
        loggerDebug("strNomSeqNumOoSs: " + strNomSeqNumOoSs);

        String valueSeqNumOoSs = generalBO.obtieneNextValSecuencia(strNomSeqNumOoSs);
        loggerDebug("valueSeqNumOoSs: " + valueSeqNumOoSs);

        result.setLonNumOOSS(Long.valueOf(valueSeqNumOoSs));
        result.setStrCodOOSS(getValorInterno("COD.OS.MODIFICACIONLIMITECONSUMO"));
        result.setIntCodProducto(Integer.valueOf(getValorInterno("parametro.codigo.producto.uno")));
        result.setLonCodInter(cargaModificacionLimiteConsumoOutDTO.getAbonado().getLonNumAbonado());

        return result;

    }

    public int obtieneDecimales() throws GestionLimiteConsumoException {

        int result;

        String strValorNumeroDecimal = getValorInterno("parametro.valor.numero.decimal");

        ParametroDTO parametroIn = new ParametroDTO();
        parametroIn.setStrNombreParametro(strValorNumeroDecimal);
        ParametroDTO parametroOut = generalBO.obtieneParametros(parametroIn);

        result = Integer.valueOf(parametroOut.getStrValorParametro());

        return result;
    }

}
