package com.tmmas.scl.gestionlc.srv;

import com.tmmas.scl.gestionlc.bo.AbonadoBO;
import com.tmmas.scl.gestionlc.bo.GeneralBO;
import com.tmmas.scl.gestionlc.bo.LimiteConsumoBO;
import com.tmmas.scl.gestionlc.common.dto.AbonadoDTO;
import com.tmmas.scl.gestionlc.common.dto.LimiteConsumoUmbralDTO;
import com.tmmas.scl.gestionlc.common.dto.LimiteConsumoUmbralInDTO;
import com.tmmas.scl.gestionlc.common.dto.LimiteConsumoUtilizadoDTO;
import com.tmmas.scl.gestionlc.common.dto.LimiteConsumoUtilizadoInDTO;
import com.tmmas.scl.gestionlc.common.dto.MontoMaximoLimiteConsumoInDTO;
import com.tmmas.scl.gestionlc.common.dto.ParametroDTO;
import com.tmmas.scl.gestionlc.common.dto.RestriccionesDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.CargaAbonoLimiteConsumoInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.CargaAbonoLimiteConsumoOutDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.EjecucionAbonoLimiteConsumoInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.EjecucionAbonoLimiteConsumoOutDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.WSAbonadoALCDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.WSCargaAbonoLimiteConsumoInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.WSCargaAbonoLimiteConsumoOutDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.WSEjecutaAbonoLimiteConsumoInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.WSEjecutaAbonoLimiteConsumoOutDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.WSLimiteConsumoALCDTO;
import com.tmmas.scl.gestionlc.common.exception.GestionLimiteConsumoException;
import com.tmmas.scl.gestionlc.srv.common.GestionLimiteConsumoAbstractSRV;

public class AbonoLimiteConsumoSrv extends GestionLimiteConsumoAbstractSRV {

    private AbonadoBO abonadoBO = new AbonadoBO();
    private LimiteConsumoBO limiteConsumoBO = new LimiteConsumoBO();
    private GeneralBO generalBO = new GeneralBO();

    /**
     * permite obtener los datos para la primera pantalla del abono limite de
     * consumo
     * 
     * @param p_in
     * @return
     * @throws GestionLimiteConsumoException
     */
    public CargaAbonoLimiteConsumoOutDTO cargaAbonoLimiteConsumo(CargaAbonoLimiteConsumoInDTO in) throws GestionLimiteConsumoException {

        CargaAbonoLimiteConsumoOutDTO result = new CargaAbonoLimiteConsumoOutDTO();

        // obtener los datos del abonado

        AbonadoDTO abonadoDTO = new AbonadoDTO();
        abonadoDTO.setLonNumAbonado(in.getLonNumAbonado());

        abonadoDTO = abonadoBO.obtenerDatosAbonado(abonadoDTO);

        result.setAbonado(abonadoDTO);

        // validaciones
        validaciones(abonadoDTO);

        // obtener los datos del limite de consumo y umbral

        LimiteConsumoUmbralInDTO limiteConsumoUmbralINDTO = new LimiteConsumoUmbralInDTO();
        limiteConsumoUmbralINDTO.setLonNunAbonado(abonadoDTO.getLonNumAbonado());
        limiteConsumoUmbralINDTO.setLonCodCliente(abonadoDTO.getLonCodCliente());

        LimiteConsumoUmbralDTO limiteConsumoUmbralDTO = limiteConsumoBO.obtenerLimiteConsumoUmbral(limiteConsumoUmbralINDTO);

        result.setLimiteConsumoUmbral(limiteConsumoUmbralDTO);

        // obtener los datos del nivel de consumo

        LimiteConsumoUtilizadoInDTO limiteConsumoUtilizadoINDTO = new LimiteConsumoUtilizadoInDTO();

        limiteConsumoUtilizadoINDTO.setLonCodCliente(abonadoDTO.getLonCodCliente());
        limiteConsumoUtilizadoINDTO.setLonNunAbonado(abonadoDTO.getLonNumAbonado());

        if (limiteConsumoUmbralDTO != null) {
            limiteConsumoUtilizadoINDTO.setStrCodUmbral(limiteConsumoUmbralDTO.getStrCodigoUmbral());
        }

        limiteConsumoUtilizadoINDTO.setLonCodCiclo(Long.valueOf(abonadoDTO.getShoCodCiclo()));

        LimiteConsumoUtilizadoDTO limiteConsumoUtilizadoDTO = limiteConsumoBO.obtenerLimiteConsumoUtilizado(limiteConsumoUtilizadoINDTO);

        result.setLimiteConsumoUtilizado(limiteConsumoUtilizadoDTO);

        // obtener las descripcion del grupo tecnologico y codigo situacion del
        // abonado

        String strDescGrupoTecnologico = generalBO.obtieneDescGrupoTecnologico(abonadoDTO.getStrCodTecnologia());

        result.setStrDescGrupoTecnologico(strDescGrupoTecnologico);

        String strDescSituacion = generalBO.obtieneDescSituacion(abonadoDTO.getStrCodSituacion());

        result.setStrDescSituacion(strDescSituacion);

        // obtener el monto maximo a ingresar como abono de limite consumo
        MontoMaximoLimiteConsumoInDTO montoMaximoLimiteConsumoINDTO = new MontoMaximoLimiteConsumoInDTO();
        montoMaximoLimiteConsumoINDTO.setLonCodCliente(abonadoDTO.getLonCodCliente());
        montoMaximoLimiteConsumoINDTO.setLonNunAbonado(abonadoDTO.getLonNumAbonado());

        Double douMontoMaximo = limiteConsumoBO.obtieneMontoMaximoAbonoLimiteConsumo(montoMaximoLimiteConsumoINDTO);

        // Double douMontoMaximo = new Double("100.01");

        loggerDebug("douMontoMaximo: " + douMontoMaximo);

        if (douMontoMaximo == null || douMontoMaximo.doubleValue() <= -1) {
            throw new GestionLimiteConsumoException("ERR.0005", 0);
        }

        result.setDouMontoMaximoAbono(douMontoMaximo);

        // obtener la cantidad de decimales permitidos por la operadora
        String strValorNumeroDecimal = getValorInterno("parametro.valor.numero.decimal");
        loggerDebug("codigoUsoHibrido: " + strValorNumeroDecimal);

        ParametroDTO parametroIn = new ParametroDTO();
        parametroIn.setStrNombreParametro(strValorNumeroDecimal);

        ParametroDTO parametroOut = generalBO.obtieneParametros(parametroIn);

        loggerDebug("Valor Parametro: " + parametroOut.getStrValorParametro());

        result.setStrCantidadDecimal(parametroOut.getStrValorParametro());

        return result;
    }

    /**
     * permite obtener los datos para el WS
     * 
     * @param p_in
     * @return
     * @throws GestionLimiteConsumoException
     */
    public WSCargaAbonoLimiteConsumoOutDTO cargaAbonoLimiteConsumoWS(WSCargaAbonoLimiteConsumoInDTO pIn) throws GestionLimiteConsumoException {

        loggerDebug("Inicio cargaAbonoLimiteConsumoWS");
        WSCargaAbonoLimiteConsumoOutDTO result = null;
        CargaAbonoLimiteConsumoInDTO cargaAbonoLimiteConsumoInDTO = new CargaAbonoLimiteConsumoInDTO();
        CargaAbonoLimiteConsumoOutDTO cargaAbonoLimiteConsumoOutDTO = new CargaAbonoLimiteConsumoOutDTO();

        cargaAbonoLimiteConsumoInDTO.setLonNumAbonado(Long.valueOf(pIn.getStrNumAbonado()));
        cargaAbonoLimiteConsumoOutDTO = cargaAbonoLimiteConsumo(cargaAbonoLimiteConsumoInDTO);

        // inicio incidencia 169415 09/06/2011 FDL
        String estadoVenta;

        Long numAbonado = Long.valueOf(pIn.getStrNumAbonado());
        estadoVenta = generalBO.obtieneEstadoVenta(numAbonado);

        loggerDebug("************************************");
        loggerDebug("Estado Venta: " + estadoVenta);
        loggerDebug("************************************");

        cargaAbonoLimiteConsumoOutDTO.setGetStrEstadoVenta(estadoVenta);
        
        // validaciones para el WS
        validacionesWS(cargaAbonoLimiteConsumoOutDTO);
        // inicio incidencia 169415 09/06/2011 FDL

        // carga los datos en WSCargaAbonoLimiteConsumoOutDTO
        result = new WSCargaAbonoLimiteConsumoOutDTO();
        result.setWsAbonadoALCDTO(cargaAboandoWS(pIn, cargaAbonoLimiteConsumoOutDTO));
        result.setWsLimiteConsumoALCDTO(cargaLimiteConsumoWS(cargaAbonoLimiteConsumoOutDTO));

        loggerDebug("Fin cargaAbonoLimiteConsumoWS");
        return result;
    }

    /**
     * permite ejecutar el abono de limite de consumo; abono, insercion
     * ci_orserv
     * 
     * @param pIn
     * @throws GestionLimiteConsumoException
     */
    public EjecucionAbonoLimiteConsumoOutDTO ejecutarAbonoLimiteConsumo(EjecucionAbonoLimiteConsumoInDTO pIn) throws GestionLimiteConsumoException {

        EjecucionAbonoLimiteConsumoOutDTO result = new EjecucionAbonoLimiteConsumoOutDTO();

        // obtener el num OOSS
        String strNomSeqNumOoSs = getValorInterno("parametro.nombre.seq.numos");
        loggerDebug("strNomSeqNumOoSs: " + strNomSeqNumOoSs);

        String valueSeqNumOoSs = generalBO.obtieneNextValSecuencia(strNomSeqNumOoSs);
        loggerDebug("valueSeqNumOoSs: " + valueSeqNumOoSs);

        pIn.setStrCodModulo(getValorInterno("parametro.codigo.modulo.GC"));
        pIn.setStrNumTarea(getValorInterno("parametro.numero.tarea.8542"));
        pIn.setLonNumOOSS(Long.valueOf(valueSeqNumOoSs));
        pIn.setStrCodOOSS(getValorInterno("COD.OS.ABONOLIMITECONSUMO"));
        pIn.setIntCodProducto(Integer.valueOf(getValorInterno("parametro.codigo.producto.uno")));

        limiteConsumoBO.ejecutarAbonoLimiteConsumo(pIn);

        result.setStrNumOOSS(pIn.getLonNumOOSS().toString());

        return result;
    }

    /**
     * permite ejecutar el abono de limite de consumo; abono, insercion
     * ci_orserv
     * 
     * @param pIn
     * @throws GestionLimiteConsumoException
     */
    public WSEjecutaAbonoLimiteConsumoOutDTO ejecutarAbonoLimiteConsumoWS(WSEjecutaAbonoLimiteConsumoInDTO pIn) throws GestionLimiteConsumoException {

        WSEjecutaAbonoLimiteConsumoOutDTO result = new WSEjecutaAbonoLimiteConsumoOutDTO();
        WSCargaAbonoLimiteConsumoInDTO wsCargaAbonoLimiteConsumoInDTO = new WSCargaAbonoLimiteConsumoInDTO();
        CargaAbonoLimiteConsumoInDTO cargaAbonoLimiteConsumoInDTO = new CargaAbonoLimiteConsumoInDTO();
        CargaAbonoLimiteConsumoOutDTO cargaAbonoLimiteConsumoOutDTO = new CargaAbonoLimiteConsumoOutDTO();
        EjecucionAbonoLimiteConsumoInDTO ejecucionAbonoLimiteConsumoInDTO = new EjecucionAbonoLimiteConsumoInDTO();

        // wsCargaAbonoLimiteConsumoInDTO.setStrNumAbonado(pIn.getStrNumAbonado());
        cargaAbonoLimiteConsumoInDTO.setLonNumAbonado(Long.valueOf(pIn.getStrNumAbonado()));
        cargaAbonoLimiteConsumoOutDTO = cargaAbonoLimiteConsumo(cargaAbonoLimiteConsumoInDTO);

        // inicio incidencia 169415 09/06/2011 FDL
        String estadoVenta;
        Long numAbonado = Long.valueOf(pIn.getStrNumAbonado());
        estadoVenta = generalBO.obtieneEstadoVenta(numAbonado);

        loggerDebug("************************************");
        loggerDebug("Estado Venta: " + estadoVenta);
        loggerDebug("************************************");

        cargaAbonoLimiteConsumoOutDTO.setGetStrEstadoVenta(estadoVenta);
        
        // validaciones para el WS
        validacionesWS(cargaAbonoLimiteConsumoOutDTO);
        // fin incidencia 169415 09/06/2011 FDL

        ejecucionAbonoLimiteConsumoInDTO = cargaEjecucionAbonoLimiteConsumoWS(pIn, cargaAbonoLimiteConsumoOutDTO);

        loggerDebug("Ingresa a LimiteConsumoBO");
        limiteConsumoBO.ejecutarAbonoLimiteConsumo(ejecucionAbonoLimiteConsumoInDTO);
        loggerDebug("Sale LimiteConsumoBO");

        result.setStrNumOOSS(ejecucionAbonoLimiteConsumoInDTO.getLonNumOOSS().toString());

        return result;
    }

    /**
     * contiene las validaciones a aplicar a la OOSS
     * 
     * @param abonadoDTO
     * @throws GestionLimiteConsumoException
     */
    private void validaciones(AbonadoDTO abonadoDTO) throws GestionLimiteConsumoException {

        // validar que sea abonado postpago
        String strCodigoProducto = getValorInterno("parametro.codigo.producto.uno");
        loggerDebug("codigoProducto: " + strCodigoProducto);

        String strCodigoModulo = getValorInterno("parametro.codigo.modulo.ga");
        loggerDebug("codigoModulo: " + strCodigoModulo);

        String strParametroCodigoHibrido = getValorInterno("parametro.codigo.uso.hibrido");
        loggerDebug("codigoUsoHibrido: " + strParametroCodigoHibrido);

        ParametroDTO parametroIn = new ParametroDTO();

        parametroIn.setStrNombreParametro(strParametroCodigoHibrido);
        parametroIn.setStrCodigoModulo(strCodigoModulo);
        parametroIn.setIntCodigoProducto(Integer.valueOf(strCodigoProducto));

        ParametroDTO parametroOut = generalBO.obtieneParametros(parametroIn);

        String strCodigoUsoHibrido = parametroOut.getStrValorParametro();
        loggerDebug("valor codigoUsoHibrido: " + strCodigoUsoHibrido);

        String strCodUsoAbonado = String.valueOf(abonadoDTO.getShoCodUso());
        loggerDebug("strCodUsoAbonado: " + strCodUsoAbonado);

        if (strCodUsoAbonado.equals(strCodigoUsoHibrido)) {
            throw new GestionLimiteConsumoException("ERR.0007", 0);
        }

        // ejecutar modelo de restriccion
        RestriccionesDTO restriccionesDTO = new RestriccionesDTO();

        String strNomSeqTransacabo = getValorInterno("parametro.nombre.seq.transacabo");
        loggerDebug("strNomSeqTransacabo: " + strNomSeqTransacabo);

        String valueSeqTransacabo = generalBO.obtieneNextValSecuencia(strNomSeqTransacabo);
        loggerDebug("valueSeqTransacabo: " + valueSeqTransacabo);

        restriccionesDTO.setStrSecuencia(valueSeqTransacabo);
        restriccionesDTO.setStrCodModulo(getValorInterno("parametro.codigo.modulo.ga"));
        restriccionesDTO.setStrCodProducto(String.valueOf(abonadoDTO.getShoCodProducto()));
        restriccionesDTO.setStrCodActAbo(getValorInterno("parametro.codigo.actabo.oa"));
        restriccionesDTO.setStrEvento(getValorInterno("parametro.evento.formload"));
        restriccionesDTO.setStrPrograma(getValorInterno("parametro.programa.gpa"));
        restriccionesDTO.setStrCodActAboDet(getValorInterno("parametro.codigo.actabo.oa"));
        restriccionesDTO.setStrNumAbonado(String.valueOf(abonadoDTO.getLonNumAbonado()));
        restriccionesDTO.setStrCodCliente(String.valueOf(abonadoDTO.getLonCodCliente()));
        restriccionesDTO.setStrCodModGener(getValorInterno("parametro.codigo.modgener.osf"));
        restriccionesDTO.setStrNumVenta(String.valueOf(abonadoDTO.getLonNumVenta()));
        restriccionesDTO.setStrCodOs(getValorInterno("COD.OS.ABONOLIMITECONSUMO"));
        restriccionesDTO.setStrCodModuloDet(getValorInterno("parametro.codigo.modulo.GC"));
        restriccionesDTO.setStrNumId(getValorInterno("parametro.numero.tarea.8542"));

        generalBO.ejecutaModeloRestriccion(restriccionesDTO);

        // validar que el abonado no posea plan tarifario de tipo empresa
        if ("E".equals(abonadoDTO.getStrTipPlanTarif())) {

            throw new GestionLimiteConsumoException("ERR.0006", 0);

        }

    }

    /**
     * contiene las validaciones a aplicar a la OOSS para los WS
     * 
     * @param cargaAbonoLimiteConsumoOutDTO
     * @throws GestionLimiteConsumoException
     */
    private void validacionesWS(CargaAbonoLimiteConsumoOutDTO cargaAbonoLimiteConsumoOutDTO) throws GestionLimiteConsumoException {

        if (!"AAA".equals(cargaAbonoLimiteConsumoOutDTO.getAbonado().getStrCodSituacion()) && !"SAA".equals(cargaAbonoLimiteConsumoOutDTO.getAbonado().getStrCodSituacion())) {

            throw new GestionLimiteConsumoException("ERR.0029", 0);
        }

        if (!"AC".equals(cargaAbonoLimiteConsumoOutDTO.getGetStrEstadoVenta())) {

            throw new GestionLimiteConsumoException("ERR.0030", 0, getValorInterno("ERR.0030") + " " + cargaAbonoLimiteConsumoOutDTO.getAbonado().getLonNumVenta() + " "
                    + getValorInterno("ERR.0031"));

        }

    }

    public WSAbonadoALCDTO cargaAboandoWS(WSCargaAbonoLimiteConsumoInDTO wsCargaAbonoLimiteConsumoInDTO, CargaAbonoLimiteConsumoOutDTO cargaAbonoLimiteConsumoOutDTO) {

        WSAbonadoALCDTO result = new WSAbonadoALCDTO();

        result.setLonNumAbonado(Long.valueOf(wsCargaAbonoLimiteConsumoInDTO.getStrNumAbonado()));
        result.setLonNumCelular(cargaAbonoLimiteConsumoOutDTO.getAbonado().getLonNumCelular());
        result.setStrNumSerie(cargaAbonoLimiteConsumoOutDTO.getAbonado().getStrNumSerie());
        result.setStrCodTecnologia(cargaAbonoLimiteConsumoOutDTO.getAbonado().getStrCodTecnologia());
        result.setStrCodSituacion(cargaAbonoLimiteConsumoOutDTO.getAbonado().getStrCodSituacion());
        result.setStrDescGrupoTecnologico(cargaAbonoLimiteConsumoOutDTO.getStrDescGrupoTecnologico());
        result.setStrDescSituacion(cargaAbonoLimiteConsumoOutDTO.getStrDescSituacion());

        return result;

    }

    public WSLimiteConsumoALCDTO cargaLimiteConsumoWS(CargaAbonoLimiteConsumoOutDTO cargaAbonoLimiteConsumoOutDTO) {

        WSLimiteConsumoALCDTO result = new WSLimiteConsumoALCDTO();

        result.setStrCodLimiteConsumo(cargaAbonoLimiteConsumoOutDTO.getAbonado().getStrCodLimConsumo());
        result.setStrDescLimiteConsumo(cargaAbonoLimiteConsumoOutDTO.getLimiteConsumoUmbral().getStrDescLimiteConsumo());
        result.setStrCodigoUmbral(cargaAbonoLimiteConsumoOutDTO.getLimiteConsumoUmbral().getStrCodigoUmbral());
        result.setStrDescUmbral(cargaAbonoLimiteConsumoOutDTO.getLimiteConsumoUmbral().getStrDescUmbral());
        result.setDouMontoUtilizado(cargaAbonoLimiteConsumoOutDTO.getLimiteConsumoUtilizado().getDouMonto());
        result.setDouMontoMaximo(cargaAbonoLimiteConsumoOutDTO.getDouMontoMaximoAbono());

        return result;

    }

    public EjecucionAbonoLimiteConsumoInDTO cargaEjecucionAbonoLimiteConsumoWS(WSEjecutaAbonoLimiteConsumoInDTO wsEjecutaAbonoLimiteConsumoInDTO,
            CargaAbonoLimiteConsumoOutDTO cargaAbonoLimiteConsumoOutDTO) throws GestionLimiteConsumoException {

        EjecucionAbonoLimiteConsumoInDTO result = new EjecucionAbonoLimiteConsumoInDTO();

        result.setLonCodCliente(cargaAbonoLimiteConsumoOutDTO.getAbonado().getLonCodCliente());
        result.setLonNumAbonado(Long.valueOf(wsEjecutaAbonoLimiteConsumoInDTO.getStrNumAbonado()));
        result.setDouAbono(Double.valueOf(wsEjecutaAbonoLimiteConsumoInDTO.getStrAbono()));
        result.setStrUsuario(wsEjecutaAbonoLimiteConsumoInDTO.getStrUserName());
        result.setStrCodModulo(getValorInterno("parametro.codigo.modulo.GC"));
        result.setStrNumTarea(getValorInterno("parametro.numero.tarea.8542"));

        String strNomSeqNumOoSs = getValorInterno("parametro.nombre.seq.numos");
        loggerDebug("strNomSeqNumOoSs: " + strNomSeqNumOoSs);

        String valueSeqNumOoSs = generalBO.obtieneNextValSecuencia(strNomSeqNumOoSs);
        loggerDebug("valueSeqNumOoSs: " + valueSeqNumOoSs);

        result.setLonNumOOSS(Long.valueOf(valueSeqNumOoSs));
        result.setStrCodOOSS(getValorInterno("COD.OS.ABONOLIMITECONSUMO"));
        result.setIntCodProducto(Integer.valueOf(getValorInterno("parametro.codigo.producto.uno")));
        result.setLonCodInter(Long.valueOf(wsEjecutaAbonoLimiteConsumoInDTO.getStrNumAbonado()));
        result.setStrComentario(wsEjecutaAbonoLimiteConsumoInDTO.getStrComentario());

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
