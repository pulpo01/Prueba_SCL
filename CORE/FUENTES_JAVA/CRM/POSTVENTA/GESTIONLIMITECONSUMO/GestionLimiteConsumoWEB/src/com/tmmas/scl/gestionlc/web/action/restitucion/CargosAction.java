package com.tmmas.scl.gestionlc.web.action.restitucion;

import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.scl.framework.aplicationDomain.dto.UsuarioSistemaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.CargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoVendedorDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.IngresoVentaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosDescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioEquipoNuevoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioTerminalDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.UsuarioDTO;
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CargosObtenidosDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CuotasProductoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.DatosGeneralesDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.PlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.TerminalDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.BusquedaFormasPagoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.BusquedaTiposDocumentoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.DocumentoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.FormaPagoListDTO;
import com.tmmas.scl.gestionlc.common.dto.TablaCargosDTO;
import com.tmmas.scl.gestionlc.common.dto.TiposDescuentoDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.IndicadorVtaExternaVendedorInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.IndicadorVtaExternaVendedorOutDTO;
import com.tmmas.scl.gestionlc.common.exception.GestionLimiteConsumoException;
import com.tmmas.scl.gestionlc.ejb.session.GestLimCon;
import com.tmmas.scl.gestionlc.ejb.session.RestitucionEquipo;
import com.tmmas.scl.gestionlc.web.action.base.AbstractAction;
import com.tmmas.scl.gestionlc.web.form.restitucion.CargosForm;
import com.tmmas.scl.gestionlc.web.form.restitucion.RestitucionEquipoForm;
import com.tmmas.scl.gestionlc.web.form.restitucion.SeleccionEquipoForm;
import com.tmmas.scl.gestionlc.web.helper.GestionLimiteConsumoLocator;

public class CargosAction extends AbstractAction {

    private GestionLimiteConsumoLocator locator;

    private final String sRESUMEN = "resumen";
    private final String sCONTROLNAVEGACION = "controlNavegacion";
    private final Integer iTIPPANOCA = 0;
    private final Integer iTIPCAMBIOSERIECOMODATO = 15;
    private final Integer iTIPCAMBIOSERIECOMODVTA = 17;
    private final Integer iTIPCAMBIOSERIEVTACOMOD = 18;
    private final Integer iTIPCAMBIOSERIEGARANTIA = 19;
    private final Integer iTIPCARGOEQUIPO = 23;
    private final Integer iTIPCARGOSIMCARD = 26;

    protected ActionForward doPerform(ActionMapping pMapping, ActionForm pForm, HttpServletRequest pRequest, HttpServletResponse pHttpResponse)

        throws Exception {

        CargosForm cargosForm = (CargosForm) pForm;

        HttpSession sesion = pRequest.getSession();

        locator = new GestionLimiteConsumoLocator();
//        gestLimCon = locator.getGestLimConFacade();
//        beanLocal = locator.getRestitucionEquipoFacade();

        String userName = (String) sesion.getAttribute("UserName");

        ClienteDTO datosCliente = (ClienteDTO) sesion.getAttribute("datosCliente");

        RestitucionEquipoForm restitucionEquipoForm = (RestitucionEquipoForm) sesion.getAttribute("RestitucionEquipoForm");

        ObtencionCargosDTO obtencionCargos = new ObtencionCargosDTO();

        long lonCodCliente = datosCliente.getCodCliente();
        String strModalidadPago = restitucionEquipoForm.getStrCodModPago();
        String strCuotas = restitucionEquipoForm.getStrCodCuota();

        String botonSeleccionado = cargosForm.getBotonSeleccionado();

        if (botonSeleccionado != null && "siguiente".equals(botonSeleccionado)) {
            // //CargosForm a= (CargosForm)form;

            // obtener secuencia de venta

            if ((cargosForm.getNumVenta() == 0) && "NO".equals(cargosForm.getRbCiclo())) {
                // OBTENER SECUENCIA DE VENTA
                loggerDebug("getRbCiclo " + cargosForm.getRbCiclo());
                SecuenciaDTO secuencia = new SecuenciaDTO();
                secuencia.setNomSecuencia("GA_SEQ_VENTA");

                // REGISTRO DE VENTA
                IngresoVentaDTO venta = new IngresoVentaDTO();
                
                long numeroDeVenta = locator.obtenerSecuencia(secuencia).getNumSecuencia();
                // session.setAttribute("numeroDeVenta", ""+numeroDeVenta);
                loggerDebug("Inmediato numeroDeVenta " + numeroDeVenta);
                venta.setNumVenta(numeroDeVenta);
                venta.setCodCliente(lonCodCliente);
                venta.setNomUsuarioVenta(userName);
                venta.setCodModVenta(Integer.parseInt(strModalidadPago));
                venta.setCodCuota(strCuotas);
                venta.setCodTipDocumento(Integer.parseInt(cargosForm.getCbNumCuotas().trim()));

                cargosForm.setNumVenta(venta.getNumVenta());
                
                locator.registrarVenta(venta);
            } else {
                loggerDebug("getRbCiclo SI");
            }

            // Filtrar los seleccionados //CAMBIAR : Validar que los cargos no
            // sean nulos
            // CargosDTO[] cargos =
            // sessionData.getCargosObtenidos().getOcacionales().getCargos();
            // CargosDTO[] cargos =
            // sessionData.getCargosObtenidos().getOcacionales().getCargos()==null?null:sessionData.getCargosObtenidos().getOcacionales().getCargos();
            CargosDTO[] cargos;
            if (cargosForm.getCargosMerge() == null) {
                cargos = null;
            } else {
                cargos = cargosForm.getCargosMerge().getCargos();
            }

            List cargosList = new ArrayList();
            String codConcepto = null;
            String codConceptoTabla = null;
            int maxCargos;
            if (cargos == null) {
                maxCargos = 0;
            } else {
                maxCargos = cargos.length;
            }
            for (int i = 0; i < maxCargos; i++) {
                codConcepto = cargos[i].getPrecio().getCodigoConcepto();
                if (codConcepto == null) {
                    codConcepto = "";
                } else {
                    codConcepto = codConcepto;
                }
                for (int j = 0; cargosForm.getSelectedValorCheck() != null && j < cargosForm.getSelectedValorCheck().length; j++) {
                    codConceptoTabla = cargosForm.getSelectedValorCheck()[j];
                    if (codConcepto.equals(codConceptoTabla)) {
                        cargosList.add(cargos[i]);
                    }
                }

                /*
                 * if(aplicaCargo(cargos[i].getPrecio().getCodigoConcepto(),cargosForm
                 * )){ cargosList.add(cargos[i]); }
                 */
            }
            CargosDTO[] cargosAprobados = new CargosDTO[cargosList.size()];
            for (int cont = 0; cont < cargosList.size(); cont++) {
                cargosAprobados[cont] = (CargosDTO) cargosList.get(cont);
            }
            ObtencionCargosDTO obtCargosDTO = new ObtencionCargosDTO();
            obtCargosDTO.setCargos(cargosAprobados);
            // cargosForm.getCargosSeleccionados().setCargos(cargosAprobados);
            cargosForm.setCargosSeleccionados(obtCargosDTO);

            // AplicarDescuentos
            if (cargosForm.getCargosSeleccionados() != null && cargosForm.getCargosSeleccionados().getCargos() != null) {
                for (int i = 0; i < cargosForm.getCargosSeleccionados().getCargos().length; i++) {
                    String concCargoSelec = cargosForm.getCargosSeleccionados().getCargos()[i].getPrecio().getCodigoConcepto();
                    if (concCargoSelec == null) {
                        concCargoSelec = "";
                    } else {
                        concCargoSelec = concCargoSelec;
                    }
                    for (int j = 0; j < cargosForm.getTablaCargos().length; j++) {
                        String codConcepTabla = cargosForm.getTablaCargos()[j].getCodConcepto();
                        if (codConcepTabla == null) {
                            codConcepTabla = "";
                        } else {
                            codConcepTabla = codConcepTabla;
                        }
                        if (concCargoSelec.equals(codConcepTabla)) {
                            String impTotalOrg = cargosForm.getTablaCargos()[j].getImporteTotalOriginal();
                            if (impTotalOrg == null) {
                                impTotalOrg = "0.0";
                            } else {
                                impTotalOrg = impTotalOrg;
                            }
                            String saldo = cargosForm.getTablaCargos()[j].getSaldo();
                            if (saldo == null) {
                                saldo = "0.0";
                            } else {
                                saldo = saldo;
                            }

                            if (!saldo.equals(impTotalOrg)) {
                                cargosForm.getCargosSeleccionados().getCargos()[i].setDescuento(obtenerDescuentos(cargosForm.getCargosSeleccionados().getCargos()[i].getPrecio()
                                        .getCodigoConcepto(), cargosForm.getTablaCargos(), cargosForm.getCargosSeleccionados().getCargos()[i].getDescuento()));
                            }
                        }
                    }
                }
            }

            cargosForm.setBotonSeleccionado("retrocedio");
            sesion.setAttribute("CargosForm", cargosForm);
            boolean existCargosSeleccionados;
            if (cargosForm.getCargosSeleccionados() == null || cargosForm.getCargosSeleccionados().getCargos() == null
                    || cargosForm.getCargosSeleccionados().getCargos().length == 0) {
                existCargosSeleccionados = false;
            } else {
                existCargosSeleccionados = true;
            }

            if (!existCargosSeleccionados) {
                sesion.setAttribute("CargosForm", cargosForm);
                return pMapping.findForward(sRESUMEN);
            }

            if (cargosForm.getCumpleDescuento() != null && "SI".equalsIgnoreCase(cargosForm.getCumpleDescuento())) {
                cargosForm.setCumpleDescuento("NO");
                sesion.setAttribute("cumpleDescuento", "SI");
                sesion.setAttribute("ultimaPagina", "cargos");
                sesion.setAttribute("CargosForm", cargosForm);
                return pMapping.findForward(sCONTROLNAVEGACION);
            }

            if (cargosForm.getRbCiclo().equalsIgnoreCase("NO")) {
                sesion.setAttribute("ultimaPagina", "cargos");
                sesion.setAttribute("CargosForm", cargosForm);
                return pMapping.findForward(sCONTROLNAVEGACION);
            }
            sesion.setAttribute("ultimaPagina", "cargos");
            sesion.setAttribute("CargosForm", cargosForm);
            return pMapping.findForward(sCONTROLNAVEGACION);
        }

        // #################################################################33

        UsuarioDTO usuario = new UsuarioDTO();
        usuario.setNombre(userName);
        loggerDebug("obtenerVendedor():antes");

        UsuarioDTO vendedor = locator.obtenerVendedor(usuario);

        sesion.setAttribute("vendedor", vendedor);

        loggerDebug("obtenerVendedor():despues");

        DescuentoVendedorDTO descVend = new DescuentoVendedorDTO();
        descVend.setCodVendedor(vendedor.getCodigo());
        descVend = locator.obtenerDescuentoVendedor(descVend);
        pRequest.setAttribute("indCreaDesc", String.valueOf(descVend.getIndCreaDescuento()));
        pRequest.setAttribute("rangoInf", String.valueOf(descVend.getRangoInfPorcDescuento()));
        pRequest.setAttribute("rangoSup", String.valueOf(descVend.getRangoSupPorcDescuento()));

        loggerDebug("descVend.getIndCreaDescuento()     [" + descVend.getIndCreaDescuento() + "]");
        loggerDebug("descVend.getRangoInfPorcDescuento()[" + descVend.getRangoInfPorcDescuento() + "]");
        loggerDebug("descVend.getRangoSupPorcDescuento()[" + descVend.getRangoSupPorcDescuento() + "]");

        // Obtiene cantidad de decimales usados en facturación
        ParametroDTO paramGral = null;
        ParametroDTO param = new ParametroDTO();
        param.setNomParametro(getValorInterno("parametro.decimal.facturacion").trim());
        param.setCodModulo(getValorInterno("codigo.modulo.GE").trim());
        param.setCodProducto(Integer.parseInt(getValorInterno("parametro.codigo.producto.uno").trim()));        
        paramGral = locator.obtenerParametroGeneral(param);
        sesion.setAttribute("numDecimalesFormulario", paramGral.getValor());
        loggerDebug("paramGral.getValor()[" + paramGral.getValor() + "]");

        // Llamada al obtenerTiposDocumentos
        DocumentoListDTO documentosList;
        BusquedaTiposDocumentoDTO tiposDocumento = new BusquedaTiposDocumentoDTO();
        tiposDocumento.setCodCliente(lonCodCliente);        
        documentosList = locator.obtenerTiposDocumento(tiposDocumento);
        pRequest.setAttribute("documentosList", Arrays.asList(documentosList.getDocumentos()));
        cargosForm.setDocumentosList(Arrays.asList(documentosList.getDocumentos()));

        // Llamada al obtenerFormasPago
        BusquedaFormasPagoDTO formasPago = new BusquedaFormasPagoDTO();
        formasPago.setCodCliente(lonCodCliente);

        long numeroDeVenta = 0;
        AbonadoDTO datosAbonado = (AbonadoDTO) sesion.getAttribute("datosAbonado");

        if (datosAbonado != null && datosAbonado.getNumVenta() != 0) {
            numeroDeVenta = datosAbonado.getNumVenta();
        } else {
            SecuenciaDTO secuencia = new SecuenciaDTO();
            secuencia.setNomSecuencia("GA_SEQ_VENTA");            
            numeroDeVenta = locator.obtenerSecuencia(secuencia).getNumSecuencia();
        }

        loggerDebug("Aciclo numeroDeVenta " + numeroDeVenta);

        formasPago.setNumVenta(numeroDeVenta);
        FormaPagoListDTO formaPagoList;        
        formaPagoList = locator.obtenerFormasPago(formasPago);

        pRequest.setAttribute("formaPagoList", Arrays.asList(formaPagoList.getFormasPago()));
        cargosForm.setFormaPagoList(Arrays.asList(formaPagoList.getFormasPago()));

        // Obtener tiposDescuento
        pRequest.setAttribute("tipDescuentosList", obtenerTiposDescuentos());
        cargosForm.setTipDescuentosList(obtenerTiposDescuentos());

        // Llamada al obtenerCuotas
        CuotasProductoDTO[] cuotasProducto = null; 
        cuotasProducto = locator.obtenerCuotasProducto();

        pRequest.setAttribute("cuotasList", Arrays.asList(cuotasProducto));
        cargosForm.setCuotasList(Arrays.asList(cuotasProducto));

        // String archivo =
        // System.getProperty("user.dir")+getValorInterno("ruta.xml")+getValorInterno("xml.valoresdefecto");
        // ParseoXML parseo=new ParseoXML();
        // loggerDebug("leyendo y parseando XML configuración:antes");
        //
        // ValoresJSPPorDefectoDTO definicionPagina=parseo.cargaXML(archivo);
        // loggerDebug("leyendo y parseando XML configuracion:despues");
        //
        // XMLDefault objetoXML = new XMLDefault();
        // ValoresJSPPorDefectoDTO objetoXMLSession = new
        // ValoresJSPPorDefectoDTO();
        // SeccionDTO seccion = new SeccionDTO();
        // objetoXMLSession = definicionPagina;
        // seccion = objetoXML.obtenerSeccion(objetoXMLSession, "cargosPAG",
        // "CondicionesComercialesSS");

        // ---------------------------------------------------------------------------
        // Seteo de controles de formulario
        // ---------------------------------------------------------------------------
        // seteo control habilitado
        // if
        // (seccion.obtControl("CargosCicloRB").getHabilitado().equals("SI")){
        pRequest.setAttribute("Hab_CargosCicloRB", "false"); // para habilitar
        // los radios que
        // seleccionen si
        // es a ciclo o no
        // }else{
        // pRequest.setAttribute("Hab_CargosCicloRB", "true");
        // }

        // seteo control visible
        // pRequest.setAttribute("Vis_CargosCicloRB",
        // String.valueOf(seccion.obtControl("CargosCicloRB").getVisible()));
        pRequest.setAttribute("Vis_CargosCicloRB", "SI"); // para mostrar los
        // radios que
        // seleccionen si es a
        // ciclo o no
        // ---------------------------------------------------------------------------

        if (cargosForm.getRbCiclo() == null) {
            cargosForm.setRbCiclo("NO");
        }

        // TODO determinar como se define si los cargos son a ciclo o no
        // Se selecciona de la pantalla de cargos
        // if (!sessionData.isExistVendUsuario()) {
        // cargosForm.setRbCiclo("NO");
        // }

        float total = 0;

        sesion.setAttribute("recalculado", "NO");

        try {
            loggerDebug("Ejecutando Cargos");

            obtencionCargos = ejecutandoCargos(pRequest, cargosForm);

            // loggerDebug("mergeCargos Cargos");
            // obtencionCargos = mergeCargos(obtencionCargos,
            // sessionData.getCargosObtenidos() == null ? null
            // : sessionData.getCargosObtenidos().getOcacionales());

            cargosForm.setCargosMerge(obtencionCargos);

        } catch (GestionLimiteConsumoException gEx) {

            // desreservar la serie
            loggerDebug("Desreservando la serie");
            Long lonNumTransacReserva = (Long) pRequest.getSession().getAttribute("LonNumTransacReserva");

            loggerDebug("NUMERO_TRANSACCION: " + lonNumTransacReserva);

            if (lonNumTransacReserva != null) {                
                locator.rollbackReservaSerie(lonNumTransacReserva);
            }

            loggerDebug("Desbloquear el vendedor");

            UsuarioSistemaDTO usuarioSistemaDTO = (UsuarioSistemaDTO) pRequest.getSession().getAttribute("usuarioSistema");

            if (usuarioSistemaDTO != null && usuarioSistemaDTO.getCod_vendedor() > 0) {

                loggerDebug("CODIGO_VENDEDOR: " + usuarioSistemaDTO.getCod_vendedor());

                com.tmmas.scl.gestionlc.common.dto.UsuarioDTO usuarioDTO = new com.tmmas.scl.gestionlc.common.dto.UsuarioDTO();

                usuarioDTO.setIntCodVendedor(Integer.valueOf((int) usuarioSistemaDTO.getCod_vendedor()));
                
                locator.desbloquearVendedor(usuarioDTO);

                loggerDebug("VENDEDOR DESBLOQUEADO");
            }

            loggerError("cod_error: " + gEx.getCodigo());
            loggerError("des_error: " + gEx.getDescripcionEvento());
            loggerError("evento_error: " + gEx.getCodigoEvento());
            loggerError("Message_error: " + gEx.getMessage());
            loggerError("Cause_error: " + gEx.getCause());

            String strCodigoError = gEx.getCodigo();
            String strDescripcionError = gEx.getDescripcionEvento();

            StringTokenizer st = new StringTokenizer(strDescripcionError, "|");
            StringBuffer sb = new StringBuffer();

            while (st.hasMoreTokens()) {
                sb.append(st.nextToken());
                sb.append("<BR/>");
            }

            int strNumeroEvento = gEx.getCodigoEvento();

            pRequest.setAttribute("strCodigoError", strCodigoError);

            if (sb.toString().length() > 0) {
                pRequest.setAttribute("strDescripcionError", sb.toString());
            } else {
                pRequest.setAttribute("strDescripcionError", strDescripcionError);
            }

            pRequest.setAttribute("strNumeroEvento", strNumeroEvento);

            return pMapping.findForward("errorCargos");
        } catch (Exception e) {

            loggerError(e);
            loggerDebug("e.getMessage: " + e.getMessage()); // RRG COL
            // 07-07-2009 96723
            loggerDebug("e.getCause: " + e.getCause()); // RRG COL 07-07-2009
            // 96723
            // StringBuffer layout = new StringBuffer();
            // loggerDebug("Exception Cargos Action se procede a cambiar estado de la serie solicitada a disponible para reserva");

            // delegate.guardaMensajesError(request,
            // "Error en el Módulo de Cargos", layout.toString());
            // return pMapping.findForward("globalError");
            throw e;
        }

        // GS
        CargosObtenidosDTO cargosObtenidos = new CargosObtenidosDTO();
        cargosObtenidos.setOcacionales(cargosForm.getCargosMerge());
        if (cargosObtenidos == null || cargosObtenidos.getOcacionales() == null || cargosObtenidos.getOcacionales().getCargos() == null
                || cargosObtenidos.getOcacionales().getCargos().length == 0) {
            sesion.setAttribute("CargosForm", cargosForm);
            return pMapping.findForward(sRESUMEN);
        }

        // sessionData.setCargosObtenidos(cargosObtenidos);

        ObtencionCargosDTO cargosAgrupados = agruparCargos(obtencionCargos);

        TablaCargosDTO[] tablaCargosDTO = null;
        if (cargosAgrupados != null && cargosAgrupados.getCargos() != null) {
            tablaCargosDTO = new TablaCargosDTO[cargosAgrupados.getCargos().length];
            String[] valorChecks = new String[cargosAgrupados.getCargos().length];
            for (int i = 0; i < cargosAgrupados.getCargos().length; i++) {
                tablaCargosDTO[i] = new TablaCargosDTO();
                tablaCargosDTO[i].setAutManDes(cargosAgrupados.getCargos()[i].getPrecio().getIndicadorAutMan());
                tablaCargosDTO[i].setDescripcion(cargosAgrupados.getCargos()[i].getPrecio().getDescripcionConcepto());
                tablaCargosDTO[i].setCantidad(String.valueOf(cargosAgrupados.getCargos()[i].getCantidad()));
                tablaCargosDTO[i].setImporteTotal(String.valueOf(cargosAgrupados.getCargos()[i].getPrecio().getMonto()
                        * cargosAgrupados.getCargos()[i].getCantidad()));
                tablaCargosDTO[i].setImporteTotalOriginal(String.valueOf(cargosAgrupados.getCargos()[i].getPrecio().getMonto()));

                tablaCargosDTO[i].setMoneda(cargosAgrupados.getCargos()[i].getPrecio().getUnidad().getDescripcion());
                tablaCargosDTO[i].setCodConcepto(cargosAgrupados.getCargos()[i].getPrecio().getCodigoConcepto());
                if (cargosAgrupados.getCargos()[i].getDescuento() != null && cargosAgrupados.getCargos()[i].getDescuento().length > 0
                        && cargosAgrupados.getCargos()[i].getDescuento()[0] != null) {
                    tablaCargosDTO[i].setCodConceptoDescuento(cargosAgrupados.getCargos()[i].getDescuento()[0].getCodigoConcepto());
                    loggerDebug("COD CONCEPTO DESCUENTO :" + tablaCargosDTO[i].getCodConceptoDescuento());
                }
                String tipDescuento;
                String tipoDescuentoAplicar;
                if (cargosAgrupados.getCargos()[i] != null && cargosAgrupados.getCargos()[i].getDescuento() != null
                        && cargosAgrupados.getCargos()[i].getDescuento().length > 0 && cargosAgrupados.getCargos()[i].getDescuento()[0] != null
                        && cargosAgrupados.getCargos()[i].getDescuento()[0].getTipo() != null) {
                    tipDescuento = cargosAgrupados.getCargos()[i].getDescuento()[0].getTipo();
                    // Esto siempre es 1 debido a q es automático.
                    if (tipDescuento == null) {
                        tipDescuento = "";
                    } else {
                        tipDescuento = tipDescuento;
                    }
                    tipoDescuentoAplicar = cargosAgrupados.getCargos()[i].getDescuento()[0].getTipoAplicacion();
                    if (tipoDescuentoAplicar == null) {
                        tipoDescuentoAplicar = "";
                    } else {
                        tipoDescuentoAplicar = tipoDescuentoAplicar;
                    }
                    loggerDebug("Tipo de Descuento Automatico en el cargo  " + i + " : " + tipoDescuentoAplicar);
                    if (tipoDescuentoAplicar.equalsIgnoreCase("0")) {
                        tipoDescuentoAplicar = "Monto";
                    } else if (tipoDescuentoAplicar.equalsIgnoreCase("1")) {
                        tipoDescuentoAplicar = "Porcentaje";
                    }
                } else {
                    tipoDescuentoAplicar = "N/A";
                }
                tablaCargosDTO[i].setTipoDescuentoAut(tipoDescuentoAplicar);

                String descuentoUnit;
                if (cargosAgrupados.getCargos()[i] != null && cargosAgrupados.getCargos()[i].getDescuento() != null
                        && cargosAgrupados.getCargos()[i].getDescuento().length > 0 && cargosAgrupados.getCargos()[i].getDescuento()[0] != null) {
                    descuentoUnit = String.valueOf(cargosAgrupados.getCargos()[i].getDescuento()[0].getMonto());
                } else {
                    descuentoUnit = "0";
                }
                tablaCargosDTO[i].setDescuentoUnitarioAut(descuentoUnit);

                valorChecks[i] = String.valueOf(i);
                String saldo = "0";

                float cantDescUnit;
                if (descuentoUnit == null) {
                    cantDescUnit = 0;
                } else {
                    cantDescUnit = Float.parseFloat(descuentoUnit);
                }
                float impTotal;
                if (tablaCargosDTO[i].getImporteTotal() == null) {
                    impTotal = 0;
                } else {
                    impTotal = Float.parseFloat(tablaCargosDTO[i].getImporteTotal());
                }

                if ("Monto".equals(tipoDescuentoAplicar)) {
                    saldo = String.valueOf(impTotal - cantDescUnit);
                } else if ("Porcentaje".equals(tipoDescuentoAplicar)) {
                    saldo = String.valueOf(impTotal - (impTotal / 100) * cantDescUnit);
                } else {
                    saldo = String.valueOf(impTotal);
                }
                tablaCargosDTO[i].setSaldo(saldo);
                total = total + Float.parseFloat(saldo);
                tablaCargosDTO[i].setValorCheck(String.valueOf(i));

            }
            ArrayList listaCheckSeleccionados = new ArrayList();
            for (int i = 0; i < tablaCargosDTO.length; i++) {
                if ("A".equalsIgnoreCase(tablaCargosDTO[i].getAutManDes())) {
                    listaCheckSeleccionados.add(String.valueOf(tablaCargosDTO[i].getCodConcepto()));
                }
            }
            // String [] checks = new String[tablaCargosDTO.length];
            /*
             * for(int i = 0; i<tablaCargosDTO.length;i++){
             * checks[i]=(String)listaCheckSeleccionados.get(i); }
             */
            String[] checks = new String[listaCheckSeleccionados.size()];
            for (int i = 0; i < listaCheckSeleccionados.size(); i++) {
                checks[i] = (String) listaCheckSeleccionados.get(i);
            }

            cargosForm.setSelectedValorCheck(checks);
            cargosForm.setTotal(String.valueOf(total));
            cargosForm.setTablaCargos(tablaCargosDTO);

        } // fin if (cargosAgrupados!=null){

        sesion.setAttribute("CargosForm", cargosForm);
        return pMapping.findForward("success");

    }

    private ObtencionCargosDTO ejecutandoCargos(HttpServletRequest pRequest, CargosForm pCargosForm) throws RemoteException, GestionLimiteConsumoException {

        ObtencionCargosDTO result = new ObtencionCargosDTO();

        Integer intTipPantalla = (Integer) pRequest.getSession().getAttribute("IntTipPantalla");

        loggerDebug("TIPOPANTALLA: " + intTipPantalla);

        if (iTIPPANOCA.equals(intTipPantalla)) {

            loggerDebug("ejecutando PANTALLA iTIPPANOCA");

            String strTipStock = (String) pRequest.getSession().getAttribute("strTipStock");
            loggerDebug("TIP_STOCK: " + strTipStock);

            ObtencionCargosDTO obtenerCargosTipo1DTO = obtenerCargosTipo1(pRequest, pCargosForm);

            result = mergeCargos(obtenerCargosTipo1DTO, result);

            if (!"4".equals(strTipStock)) { // CodStock

                ObtencionCargosDTO obtencionCargosSimcard = obtenerCargosSimcardRestitucion(pRequest, pCargosForm);

                result = mergeCargos(obtencionCargosSimcard, result);

            }

        } else if (iTIPCAMBIOSERIECOMODATO.equals(intTipPantalla)) {

            loggerDebug("ejecutando PANTALLA iTIPCAMBIOSERIECOMODATO");

            String strTipStock = (String) pRequest.getSession().getAttribute("strTipStock");
            loggerDebug("TIP_STOCK: " + strTipStock);

            ObtencionCargosDTO obtenerCargosEstadoDTO = obtenerCargosEstado(pRequest, pCargosForm);

            result = mergeCargos(obtenerCargosEstadoDTO, result);

            ObtencionCargosDTO obtencionCargosHabilitacion = obtenerCargosHabilitacion(pRequest, pCargosForm);

            result = mergeCargos(obtencionCargosHabilitacion, result);

            if (!"4".equals(strTipStock)) { // CodStock

                ObtencionCargosDTO obtencionCargosSimcard = obtenerCargosSimcardRestitucion(pRequest, pCargosForm);

                result = mergeCargos(obtencionCargosSimcard, result);
            }

        } else if (iTIPCAMBIOSERIECOMODVTA.equals(intTipPantalla)) {

            loggerDebug("ejecutando PANTALLA iTIPCAMBIOSERIECOMODVTA");

            String strTipStock = (String) pRequest.getSession().getAttribute("strTipStock");
            loggerDebug("TIP_STOCK: " + strTipStock);

            ObtencionCargosDTO obtenerCargosEstadoDTO = obtenerCargosEstado(pRequest, pCargosForm);

            result = mergeCargos(obtenerCargosEstadoDTO, result);

            if (!"4".equals(strTipStock)) { // CodStock

                ObtencionCargosDTO obtencionCargosTerminal = obtenerCargosTerminalRestitucion(pRequest, pCargosForm);

                result = mergeCargos(obtencionCargosTerminal, result);

            }

            if (!"4".equals(strTipStock)) { // CodStock

                ObtencionCargosDTO obtencionCargosSimcard = obtenerCargosSimcardRestitucion(pRequest, pCargosForm);

                result = mergeCargos(obtencionCargosSimcard, result);

            }

        } else if (iTIPCAMBIOSERIEVTACOMOD.equals(intTipPantalla)) {

            loggerDebug("ejecutando PANTALLA iTIPCAMBIOSERIEVTACOMOD");

            ObtencionCargosDTO obtencionCargosHabilitacion = obtenerCargosHabilitacion(pRequest, pCargosForm);

            result = mergeCargos(obtencionCargosHabilitacion, result);

            String strTipStock = (String) pRequest.getSession().getAttribute("strTipStock");
            loggerDebug("TIP_STOCK: " + strTipStock);

            if (!"4".equals(strTipStock)) { // CodStock

                ObtencionCargosDTO obtencionCargosSimcard = obtenerCargosSimcardRestitucion(pRequest, pCargosForm);

                result = mergeCargos(obtencionCargosSimcard, result);

            }

        } else if (iTIPCAMBIOSERIEGARANTIA.equals(intTipPantalla)) {

            loggerDebug("ejecutando PANTALLA iTIPCAMBIOSERIEGARANTIA");

            ObtencionCargosDTO obtencionCargosDifGarantiaDTO = obtenerCargosDiferenciaGarantia(pRequest, pCargosForm);

            result = mergeCargos(obtencionCargosDifGarantiaDTO, result);

            ParametroDTO parametro = new ParametroDTO();
            parametro.setCodModulo(getValorInterno("parametro.codigo.modulo.al"));
            parametro.setCodProducto(Integer.parseInt(getValorInterno("parametro.codigo.producto.uno")));
            parametro.setNomParametro(getValorInterno("parametro.simcard.gsm"));

            parametro = locator.obtenerParametroGeneral(parametro);

            String strTipTerminal = (String) pRequest.getSession().getAttribute("strTipTerminal");

            loggerDebug("TIP_TERMINAL_SELECCIONADO: " + strTipTerminal);
            loggerDebug("TIP_TERMINAL_SIMCARD: " + parametro.getValor());

            if (parametro.getValor().equals(strTipTerminal)) {

                ObtencionCargosDTO obtencionCargosSimcard = obtenerCargosSimcardRestitucion(pRequest, pCargosForm);

                result = mergeCargos(obtencionCargosSimcard, result);
            }

        } else if (iTIPCARGOEQUIPO.equals(intTipPantalla)) {

            loggerDebug("ejecutando PANTALLA iTIPCARGOEQUIPO");

            String strIndValorar = (String) pRequest.getSession().getAttribute("strIndValorar");
            loggerDebug("IND_VALORAR: " + strIndValorar);

            String strTipStock = (String) pRequest.getSession().getAttribute("strTipStock");
            loggerDebug("TIP_STOCK: " + strTipStock);

//             strIndValorar = "1";

            if (!"0".equals(strIndValorar)) {

                if (!"4".equals(strTipStock)) { // CodStock
                    ObtencionCargosDTO obtencionCargosTerminal = obtenerCargosTerminalRestitucion(pRequest, pCargosForm);

                    result = mergeCargos(obtencionCargosTerminal, result);
                }

            }

            // TODO DESCOMENTAR SI SE APLICA LA TECNOLOGIA TDMA
            // if(!"4".equals(strTipStock)){ //CodStock
            //
            // ObtencionCargosDTO obtencionCargosSimcard =
            // obtenerCargosSimcardRestitucion(pRequest, pCargosForm);
            //
            // result = mergeCargos(obtencionCargosSimcard , result);
            //
            // }

        } else if (iTIPCARGOSIMCARD.equals(intTipPantalla)) {

            loggerDebug("ejecutando PANTALLA iTIPCARGOSIMCARD");

            String strTipStock = (String) pRequest.getSession().getAttribute("strTipStock");
            loggerDebug("TIP_STOCK: " + strTipStock);

            if (!"4".equals(strTipStock)) { // CodStock

                ObtencionCargosDTO obtencionCargosSimcard = obtenerCargosSimcardRestitucion(pRequest, pCargosForm);

                result = mergeCargos(obtencionCargosSimcard, result);
            }

        } else {
            loggerDebug("no coincide la pantalla");
        }

        return result;
    }

    /**
     * permite obtener los cargos y descuentos asociados a la simcard
     * 
     * @param pRequest
     * @param pCargosForm
     * @return
     * @throws RemoteException
     * @throws GestionLimiteConsumoException
     */
    private ObtencionCargosDTO obtenerCargosSimcardRestitucion(HttpServletRequest pRequest, CargosForm pCargosForm) throws RemoteException,
            GestionLimiteConsumoException {

        loggerDebug("ejecutando obtenerCargosSimcardRestitucion");

        ParametrosObtencionCargosDTO paramObtCargos = new ParametrosObtencionCargosDTO();

        ClienteDTO datosCliente = (ClienteDTO) pRequest.getSession().getAttribute("datosCliente");
        String userName = (String) pRequest.getSession().getAttribute("UserName");
        AbonadoDTO datosAbonado = (AbonadoDTO) pRequest.getSession().getAttribute("datosAbonado");
        RestitucionEquipoForm restitucionEquipoForm = (RestitucionEquipoForm) pRequest.getSession().getAttribute("RestitucionEquipoForm");
        SeleccionEquipoForm seleccionEquipoForm = (SeleccionEquipoForm) pRequest.getSession().getAttribute("SeleccionEquipoForm");
        String strTipStock = (String) pRequest.getSession().getAttribute("StrTipStock");
        UsuarioSistemaDTO usuarioSistema = (UsuarioSistemaDTO) pRequest.getSession().getAttribute("usuarioSistema");

        paramObtCargos.setTipoPantalla(getValorInterno("codigo.tipo.pantalla.reglas.simcard.restitucion"));

        IndicadorVtaExternaVendedorInDTO indicadorVtaExternaVendedorInDTO = new IndicadorVtaExternaVendedorInDTO();
        indicadorVtaExternaVendedorInDTO.setLonCodVendedor(Long.valueOf(usuarioSistema.getCod_vendedor()).longValue());

        IndicadorVtaExternaVendedorOutDTO indVtaExtVendedorOutDTO = locator.obtieneIndicadorVtaExternaVendedor(indicadorVtaExternaVendedorInDTO);

        validaResult(indVtaExtVendedorOutDTO.getIEvento(), indVtaExtVendedorOutDTO.getStrCodError(), indVtaExtVendedorOutDTO.getStrDesError());

        if (indVtaExtVendedorOutDTO.getIntIndicadorVtaExterna().intValue() == 1) {
            // si el indicador de venta externa del vendedor es 1, entonces se
            // envía un 0
            // para que el frameworkCargos transforme el valor a 1
            paramObtCargos.setIndicadorTipoVenta(0);
        } else {
            paramObtCargos.setIndicadorTipoVenta(1);
        }

        paramObtCargos.setNombreUsuario(userName);

        long codCliente = datosCliente.getCodCliente();
        paramObtCargos.setCodigoClienteOrigen(String.valueOf(codCliente));
        paramObtCargos.setCodigoClienteDestino(String.valueOf(codCliente));

        paramObtCargos.setCodigoPlanTarifOrigen(datosAbonado.getCodPlanTarif());
        paramObtCargos.setCodigoPlanTarifDestino(datosAbonado.getCodPlanTarif());
        loggerDebug("codigo tipo Plan tarif: " + datosAbonado.getCodPlanTarif());
        paramObtCargos.setEstadoSimcard("7");

        paramObtCargos.setNumeroMesesContrato(Integer.parseInt(restitucionEquipoForm.getStrCodTipContrato()));
        if ("0".equals(restitucionEquipoForm.getStrCodTipContrato())) {
            paramObtCargos.setIndCiclo("0");
        } else {
            paramObtCargos.setIndCiclo("1");
        }

        paramObtCargos.setNumSerieSimcard(seleccionEquipoForm.getStrNumSerie());
        paramObtCargos.setCodArticulo(String.valueOf(seleccionEquipoForm.getIntCodArticulo()));
        paramObtCargos.setCodUso(String.valueOf(seleccionEquipoForm.getIntCodUso()));
        paramObtCargos.setTipoStock(strTipStock);

        // Creo la coleccion de abonados
        String[] codAbonado = new String[1];
        codAbonado[0] = String.valueOf(datosAbonado.getNumAbonado());
        paramObtCargos.setAbonados(codAbonado);

        paramObtCargos.setCodigoModalidadVenta(restitucionEquipoForm.getStrCodModPago()); // contado

        // paramObtCargos.setTipoContrato(sessionData.getTipoContrato());
        // Recupero el plan tarifario desde el abonado
        // ini-Proyecto p-mix-09003 OCB;
        paramObtCargos.setNumOsRenova(null);
        paramObtCargos.setOrdenServicio(getValorInterno("COD.OS.RESTITUCION"));
        // fin-Proyecto p-mix-09003 OCB;

        String codTipContrato = restitucionEquipoForm.getStrCodTipContrato();
        paramObtCargos.setTipoContrato(codTipContrato); // INC-79469; COL;
        // 10-03-2009; AVC

        if (codTipContrato == null || "".equals(codTipContrato)) {
            codTipContrato = "0";
        } else {
            codTipContrato =  codTipContrato.trim();
        }

        ParametroDTO parametroCausa = new ParametroDTO();
        parametroCausa.setNomParametro(getValorInterno("parametro.causa.restitucion"));
        parametroCausa.setCodModulo(getValorInterno("parametro.codigo.modulo.ga"));
        parametroCausa.setCodProducto(Integer.valueOf(getValorInterno("parametro.codigo.producto.uno")).intValue());
        
        parametroCausa = locator.obtenerParametroGeneral(parametroCausa);

        paramObtCargos.setCodCausaCambioPlan(parametroCausa.getValor());

        loggerDebug("ejecutando obtencionCargos");
        
        ObtencionCargosDTO obtencionCargos = locator.obtencionCargos(paramObtCargos);

        return obtencionCargos;

    }

    /**
     * permite obtener los cargos y descuentos asociados al terminal
     * 
     * @param pRequest
     * @param pCargosForm
     * @return
     * @throws RemoteException
     * @throws GestionLimiteConsumoException
     */
    private ObtencionCargosDTO obtenerCargosTerminalRestitucion(HttpServletRequest pRequest, CargosForm pCargosForm) throws RemoteException,
            GestionLimiteConsumoException {

        loggerDebug("ejecutando obtenerCargosTerminalRestitucion");

        ParametrosObtencionCargosDTO paramObtCargos = new ParametrosObtencionCargosDTO();

        ClienteDTO datosCliente = (ClienteDTO) pRequest.getSession().getAttribute("datosCliente");
        String userName = (String) pRequest.getSession().getAttribute("UserName");
        AbonadoDTO datosAbonado = (AbonadoDTO) pRequest.getSession().getAttribute("datosAbonado");
        RestitucionEquipoForm restitucionEquipoForm = (RestitucionEquipoForm) pRequest.getSession().getAttribute("RestitucionEquipoForm");
        SeleccionEquipoForm seleccionEquipoForm = (SeleccionEquipoForm) pRequest.getSession().getAttribute("SeleccionEquipoForm");
        String strTipStock = (String) pRequest.getSession().getAttribute("StrTipStock");
        UsuarioSistemaDTO usuarioSistema = (UsuarioSistemaDTO) pRequest.getSession().getAttribute("usuarioSistema");

        paramObtCargos.setTipoPantalla(getValorInterno("codigo.tipo.pantalla.reglas.terminal.restitucion"));

        IndicadorVtaExternaVendedorInDTO indicadorVtaExternaVendedorInDTO = new IndicadorVtaExternaVendedorInDTO();
        indicadorVtaExternaVendedorInDTO.setLonCodVendedor(Long.valueOf(usuarioSistema.getCod_vendedor()).longValue());
        
        IndicadorVtaExternaVendedorOutDTO indVtaExtVendedorOutDTO = locator.obtieneIndicadorVtaExternaVendedor(indicadorVtaExternaVendedorInDTO);

        validaResult(indVtaExtVendedorOutDTO.getIEvento(), indVtaExtVendedorOutDTO.getStrCodError(), indVtaExtVendedorOutDTO.getStrDesError());

        if (indVtaExtVendedorOutDTO.getIntIndicadorVtaExterna().intValue() == 1) {
            // si el indicador de venta externa del vendedor es 1, entonces se
            // envía un 0
            // para que el frameworkCargos transforme el valor a 1
            paramObtCargos.setIndicadorTipoVenta(0);
        } else {
            paramObtCargos.setIndicadorTipoVenta(1);
        }

        paramObtCargos.setNombreUsuario(userName);

        long codCliente = datosCliente.getCodCliente();
        paramObtCargos.setCodigoClienteOrigen(String.valueOf(codCliente));
        paramObtCargos.setCodigoClienteDestino(String.valueOf(codCliente));

        paramObtCargos.setCodigoPlanTarifOrigen(datosAbonado.getCodPlanTarif());
        paramObtCargos.setCodigoPlanTarifDestino(datosAbonado.getCodPlanTarif());
        loggerDebug("codigo tipo Plan tarif: " + datosAbonado.getCodPlanTarif());
        paramObtCargos.setEstadoSimcard("7");

        paramObtCargos.setNumeroMesesContrato(Integer.parseInt(restitucionEquipoForm.getStrCodTipContrato()));
        if ("0".equals(restitucionEquipoForm.getStrCodTipContrato())) {
            paramObtCargos.setIndCiclo("0");
        } else {
            paramObtCargos.setIndCiclo("1");
        }

        paramObtCargos.setNumSerieSimcard(seleccionEquipoForm.getStrNumSerie());
        paramObtCargos.setNumImei(seleccionEquipoForm.getStrNumSerie());
        paramObtCargos.setCodArticulo(String.valueOf(seleccionEquipoForm.getIntCodArticulo()));
        paramObtCargos.setCodUso(String.valueOf(seleccionEquipoForm.getIntCodUso()));
        paramObtCargos.setTipoStock(strTipStock);

        // Creo la coleccion de abonados
        String[] codAbonado = new String[1];
        codAbonado[0] = String.valueOf(datosAbonado.getNumAbonado());
        paramObtCargos.setAbonados(codAbonado);

        paramObtCargos.setCodigoModalidadVenta(restitucionEquipoForm.getStrCodModPago()); // contado

        // paramObtCargos.setTipoContrato(sessionData.getTipoContrato());
        // Recupero el plan tarifario desde el abonado
        // ini-Proyecto p-mix-09003 OCB;
        paramObtCargos.setNumOsRenova(null);
        paramObtCargos.setOrdenServicio(getValorInterno("COD.OS.RESTITUCION"));
        // fin-Proyecto p-mix-09003 OCB;

        String codTipContrato = restitucionEquipoForm.getStrCodTipContrato();
        paramObtCargos.setTipoContrato(codTipContrato); // INC-79469; COL;
        // 10-03-2009; AVC

        if (codTipContrato == null || "".equals(codTipContrato)) {
            codTipContrato = "0";
        } else {
            codTipContrato = codTipContrato.trim();
        }

        ParametroDTO parametroCausa = new ParametroDTO();
        parametroCausa.setNomParametro(getValorInterno("parametro.causa.restitucion"));
        parametroCausa.setCodModulo(getValorInterno("parametro.codigo.modulo.ga"));
        parametroCausa.setCodProducto(Integer.valueOf(getValorInterno("parametro.codigo.producto.uno")).intValue());
        parametroCausa = locator.obtenerParametroGeneral(parametroCausa);

        paramObtCargos.setCodCausaCambioPlan(parametroCausa.getValor());

        // tenologia del Abonado
        String codTecnologia = datosAbonado.getCodTecnologia();
        if (codTecnologia == null) {
            codTecnologia = "";
        } else {
            codTecnologia = codTecnologia;
        }

        paramObtCargos.setCodigoTecnologia(codTecnologia);

        paramObtCargos.setNumeroMesesProrroga(Integer.valueOf(restitucionEquipoForm.getStrCodMesProrroga()).intValue());

        // se setea en 1 ya que no se manejaran equipos analogos y no hay
        // promocion celular
        paramObtCargos.setPromoCelular(1);

        loggerDebug("ejecutando obtencionCargos...");

        ObtencionCargosDTO obtencionCargos = locator.obtencionCargos(paramObtCargos);

        return obtencionCargos;

    }

    /**
     * permite obtener los cargos y descuentos asociados al terminal
     * 
     * @param pRequest
     * @param pCargosForm
     * @return
     * @throws RemoteException
     * @throws GestionLimiteConsumoException
     */
    private ObtencionCargosDTO obtenerCargosDiferenciaGarantia(HttpServletRequest pRequest, CargosForm pCargosForm) throws RemoteException,
            GestionLimiteConsumoException {

        ObtencionCargosDTO result = new ObtencionCargosDTO();

        AbonadoDTO datosAbonado = (AbonadoDTO) pRequest.getSession().getAttribute("datosAbonado");
        ClienteDTO datosCliente = (ClienteDTO) pRequest.getSession().getAttribute("datosCliente");
        UsuarioAbonadoDTO usuarioAbonado = (UsuarioAbonadoDTO) pRequest.getSession().getAttribute("usuarioAbonado");
        SeleccionEquipoForm seleccionEquipoForm = (SeleccionEquipoForm) pRequest.getSession().getAttribute("SeleccionEquipoForm");
        RestitucionEquipoForm restitucionEquipoForm = (RestitucionEquipoForm) pRequest.getSession().getAttribute("RestitucionEquipoForm");
        String strIndComodato = (String) pRequest.getSession().getAttribute("StrIndComodato");
        String strTipStock = (String) pRequest.getSession().getAttribute("StrTipStock");

        ParametroDTO parametro = new ParametroDTO();
        parametro.setCodModulo(getValorInterno("parametro.codigo.modulo.ga"));
        parametro.setCodProducto(Integer.parseInt(getValorInterno("parametro.codigo.producto.uno")));
        // parametro.setNomParametro(getValorInterno("parametro.grupo.tecnologico.gsm"));

        // parametro=gestLimCon.obtenerParametroGeneral(parametro);

        // String paramTechGSM=parametro.getValor();
        // paramTechGSM=paramTechGSM==null?"":paramTechGSM;

        // tenologia del Abonado
        // String codTecnologia=datosAbonado.getCodTecnologia();
        // codTecnologia=codTecnologia==null?"":codTecnologia;

        String numSerieTermAnt = datosAbonado.getNumSerie();

        // if (!codTecnologia.equals(paramTechGSM)){
        // numSerieTermAnt=datosAbonado.getNumSerie();
        // }

        if (numSerieTermAnt == null) {
            numSerieTermAnt = "";
        } else {
            numSerieTermAnt = numSerieTermAnt;
        }

        loggerDebug("numSerieTermAnt: " + numSerieTermAnt);

        float valorEquipoActual = 0;
        // obtener el precio del equipo actual
        TerminalDTO terminalDTOAnt = new TerminalDTO();
        terminalDTOAnt.setNumeroSerie(numSerieTermAnt);
        terminalDTOAnt.setCodigoArticulo(String.valueOf(usuarioAbonado.getCodArtEquipo()));

        PrecioTerminalDTO precioTerminalDTOAnt = locator.getRecPrecioEquipoActual(terminalDTOAnt);

        if (precioTerminalDTOAnt.getTipDescto() != null && precioTerminalDTOAnt.getTipDescto().trim().length() > 0) {

            if ("0".equals(precioTerminalDTOAnt.getTipDescto())) {

                valorEquipoActual = precioTerminalDTOAnt.getMonto() - Float.parseFloat(precioTerminalDTOAnt.getValDescto());

            } else {

                valorEquipoActual = precioTerminalDTOAnt.getMonto()
                        - ((precioTerminalDTOAnt.getMonto() * Float.parseFloat(precioTerminalDTOAnt.getValDescto())) / 100);

            }
        } else {

            valorEquipoActual = precioTerminalDTOAnt.getMonto();
        }

        // obtener el valor del equipo nuevo
        PrecioEquipoNuevoDTO precioEquipoNuevoDTO = new PrecioEquipoNuevoDTO();
        precioEquipoNuevoDTO.setNumAbonado(datosAbonado.getNumAbonado());
        precioEquipoNuevoDTO.setCodPlanTarif(datosAbonado.getCodPlanTarif());
        precioEquipoNuevoDTO.setCodArticulo(new Long(seleccionEquipoForm.getIntCodArticulo()));
        precioEquipoNuevoDTO.setCodProducto(Integer.valueOf(getValorInterno("parametro.codigo.producto.uno")));
        precioEquipoNuevoDTO.setCodModVenta(Integer.valueOf(restitucionEquipoForm.getStrCodModPago()));
        precioEquipoNuevoDTO.setCodUso(seleccionEquipoForm.getIntCodUso());
        precioEquipoNuevoDTO.setCodEstado(seleccionEquipoForm.getIntCodEstado());
        precioEquipoNuevoDTO.setNumMeses(Integer.valueOf(restitucionEquipoForm.getStrCodMesProrroga()));

        precioEquipoNuevoDTO.setIndComodato(strIndComodato);
        precioEquipoNuevoDTO.setTipStock(Integer.valueOf(strTipStock));

        PrecioTerminalDTO precioTerminalDTONew = locator.getRecPrecioEquipoNuevo(precioEquipoNuevoDTO);

        float valorEquipoNuevo = 0;
        float valorDiferencia = 0;
        valorEquipoNuevo = precioTerminalDTONew.getMonto();

        if (valorEquipoNuevo > valorEquipoActual) {

            valorDiferencia = valorEquipoNuevo - valorEquipoActual;

            loggerDebug("VALOR_DIFERENCIA: " + valorDiferencia);

            ParametrosObtencionCargosDTO paramObtCargos = new ParametrosObtencionCargosDTO();
            paramObtCargos.setTipoPantalla(getValorInterno("codigo.tipo.pantalla.reglas.dif.garantia"));

            long codCliente = datosCliente.getCodCliente();
            paramObtCargos.setCodigoClienteOrigen(String.valueOf(codCliente));

            // Creo la coleccion de abonados
            String[] codAbonado = new String[1];
            codAbonado[0] = String.valueOf(datosAbonado.getNumAbonado());
            paramObtCargos.setAbonados(codAbonado);

            paramObtCargos.setValorDiferencia(new Double(valorDiferencia));
            
            result = locator.obtencionCargos(paramObtCargos);
        }

        return result;
    }

    /**
     * permite obtener los cargos Tipo 1
     * 
     * @param pRequest
     * @param pCargosForm
     * @return
     * @throws RemoteException
     * @throws GestionLimiteConsumoException
     */
    private ObtencionCargosDTO obtenerCargosTipo1(HttpServletRequest pRequest, CargosForm pCargosForm) throws RemoteException, GestionLimiteConsumoException {

        AbonadoDTO datosAbonado = (AbonadoDTO) pRequest.getSession().getAttribute("datosAbonado");
        ClienteDTO datosCliente = (ClienteDTO) pRequest.getSession().getAttribute("datosCliente");

        ParametrosObtencionCargosDTO paramObtCargos = new ParametrosObtencionCargosDTO();

        paramObtCargos.setTipoPantalla(getValorInterno("codigo.tipo.pantalla.servicios.ocasionales"));

        // ini-Proyecto p-mix-09003 OCB;
        paramObtCargos.setNumOsRenova(null);
        // fin-Proyecto p-mix-09003 OCB;

        // Creo la coleccion de abonados
        String[] codAbonado = new String[1];
        codAbonado[0] = String.valueOf(datosAbonado.getNumAbonado());
        paramObtCargos.setAbonados(codAbonado);

        long codCliente = datosCliente.getCodCliente();
        paramObtCargos.setCodigoClienteOrigen(String.valueOf(codCliente));
        paramObtCargos.setCodigoClienteDestino(String.valueOf(codCliente));

        paramObtCargos.setCodigoPlanTarifDestino(null);

        String codPlanTarifOrig = null;

        if (datosAbonado != null && datosAbonado.getCodPlanTarif() != null) {
            codPlanTarifOrig = datosAbonado.getCodPlanTarif();
        }

        paramObtCargos.setCodigoPlanTarifOrigen(codPlanTarifOrig);

        paramObtCargos.setCodActabo(getValorInterno("parametro.codigo.actabo.re"));

        paramObtCargos.setTipoPantallaPrevio(null);

        paramObtCargos.setOrdenServicio(getValorInterno("COD.OS.RESTITUCION"));

        paramObtCargos.setCodPlanServ(datosAbonado.getCodPlanServ());

        ParametroDTO parametroCausa = new ParametroDTO();
        parametroCausa.setNomParametro(getValorInterno("parametro.causa.restitucion"));        
        parametroCausa = locator.obtenerParametroGeneral(parametroCausa);

        paramObtCargos.setCodCausaCambioPlan(parametroCausa.getValor());

        ObtencionCargosDTO result = locator.obtencionCargos(paramObtCargos);

        return result;
    }

    /**
     * permite obtener los cargos por habilitacion
     * 
     * @param pRequest
     * @param pCargosForm
     * @return
     * @throws RemoteException
     * @throws GestionLimiteConsumoException
     */
    private ObtencionCargosDTO obtenerCargosHabilitacion(HttpServletRequest pRequest, CargosForm pCargosForm) throws RemoteException,
            GestionLimiteConsumoException {

        String strIndComodato = (String) pRequest.getSession().getAttribute("StrIndComodato");
        RestitucionEquipoForm restitucionEquipoForm = (RestitucionEquipoForm) pRequest.getSession().getAttribute("RestitucionEquipoForm");
        String strTipStock = (String) pRequest.getSession().getAttribute("StrTipStock");
        SeleccionEquipoForm seleccionEquipoForm = (SeleccionEquipoForm) pRequest.getSession().getAttribute("SeleccionEquipoForm");
        UsuarioSistemaDTO usuarioSistema = (UsuarioSistemaDTO) pRequest.getSession().getAttribute("usuarioSistema");

        ParametrosObtencionCargosDTO paramObtCargos = new ParametrosObtencionCargosDTO();

        paramObtCargos.setTipoPantalla(getValorInterno("codigo.tipo.pantalla.reglas.habilitacion"));

        paramObtCargos.setIndComodato(Integer.valueOf(strIndComodato));

        paramObtCargos.setCodigoModalidadVenta(restitucionEquipoForm.getStrCodModPago());

        paramObtCargos.setTipoStock(strTipStock);

        paramObtCargos.setCodArticulo(String.valueOf(seleccionEquipoForm.getIntCodArticulo()));

        paramObtCargos.setCodUso(String.valueOf(seleccionEquipoForm.getIntCodUso()));

        paramObtCargos.setNumeroMesesContrato(Integer.valueOf(restitucionEquipoForm.getStrCodTipContrato()));

        paramObtCargos.setCodigoPlanTarifDestino(null);

        paramObtCargos.setCodigoVendedor(String.valueOf(usuarioSistema.getCod_vendedor()));

        String codTipContrato = restitucionEquipoForm.getStrCodTipContrato();
        paramObtCargos.setTipoContrato(codTipContrato);
        
        ObtencionCargosDTO result = locator.obtencionCargos(paramObtCargos);

        return result;
    }

    /**
     * permite obtener los cargos por Estado de devolucion de equipo
     * 
     * @param pRequest
     * @param pCargosForm
     * @return
     * @throws RemoteException
     * @throws GestionLimiteConsumoException
     */
    private ObtencionCargosDTO obtenerCargosEstado(HttpServletRequest pRequest, CargosForm pCargosForm) throws RemoteException, GestionLimiteConsumoException {

        UsuarioAbonadoDTO usuarioAbonado = (UsuarioAbonadoDTO) pRequest.getSession().getAttribute("usuarioAbonado");
        RestitucionEquipoForm restitucionEquipoForm = (RestitucionEquipoForm) pRequest.getSession().getAttribute("RestitucionEquipoForm");
        UsuarioSistemaDTO usuarioSistema = (UsuarioSistemaDTO) pRequest.getSession().getAttribute("usuarioSistema");

        ParametrosObtencionCargosDTO paramObtCargos = new ParametrosObtencionCargosDTO();

        paramObtCargos.setTipoPantalla(getValorInterno("codigo.tipo.pantalla.reglas.estado.devolucion"));

        paramObtCargos.setIndComodato(Integer.valueOf(getValorInterno("parametro.comodato")));

        paramObtCargos.setParametrosDescuentoDTO(new ParametrosDescuentoDTO());

        paramObtCargos.getParametrosDescuentoDTO().setEquipoEstado(getValorInterno("codigo.devolucion.equipo.D"));

        PlanTarifarioDTO planTarifarioDTO = new PlanTarifarioDTO();
        planTarifarioDTO.setCodPlanTarif(usuarioAbonado.getCodPlantarif());
        PlanTarifarioDTO planTarif = locator.getCategoriaPlanTarifario(planTarifarioDTO);

        paramObtCargos.getParametrosDescuentoDTO().setCodigoCategoria(planTarif.getCodigoCategoria());

        String codTipContrato = restitucionEquipoForm.getStrCodTipContrato();
        paramObtCargos.setTipoContrato(codTipContrato);

        paramObtCargos.setNumeroMesesContrato(Integer.parseInt(restitucionEquipoForm.getStrCodTipContrato()));

        paramObtCargos.getParametrosDescuentoDTO().setCodigoAntiguedad(getValorInterno("codigo.antiguedad"));

        paramObtCargos.getParametrosDescuentoDTO().setCodigoOperacion(getValorInterno("parametro.codigo.operacion.re"));

        paramObtCargos.getParametrosDescuentoDTO().setIndicadorCiclo(getValorInterno("indicador.ciclo"));

        paramObtCargos.getParametrosDescuentoDTO().setCodigoVendedor(String.valueOf(usuarioSistema.getCod_vendedor()));
        
        ObtencionCargosDTO result = locator.obtencionCargos(paramObtCargos);

        return result;
    }

    /**
     * @param cargosNuevos
     *            Cargos obtenidos desde el método
     * @param cargosAntiguos
     *            Cargos obtenidos hasta el momento
     * @return ObtencionCargosDTO que contiene cargosNuevos y cargosAntiguos
     *         como un unico dto
     */
    private ObtencionCargosDTO mergeCargos(ObtencionCargosDTO pCargosNuevos, ObtencionCargosDTO pCargosAntiguos) {
        if (pCargosAntiguos == null || pCargosAntiguos.getCargos() == null || pCargosAntiguos.getCargos().length == 0) {
            return pCargosNuevos;
        }

        if (pCargosNuevos.getCargos() == null || pCargosNuevos.getCargos().length == 0) {
            return pCargosAntiguos;
        }

        ArrayList cargos = new ArrayList();
        cargos.addAll(Arrays.asList(pCargosNuevos.getCargos()));
        cargos.addAll(Arrays.asList(pCargosAntiguos.getCargos()));

        CargosDTO[] cargosMerge = new CargosDTO[cargos.size()];
        for (int f = 0; f < cargos.size(); f++) {
            cargosMerge[f] = new CargosDTO();
            cargosMerge[f] = (CargosDTO) cargos.get(f);
        }
        pCargosAntiguos.setCargos(cargosMerge);
        return pCargosAntiguos;
    }

    private ObtencionCargosDTO agruparCargos(ObtencionCargosDTO obt) {
        ObtencionCargosDTO cargosObt = new ObtencionCargosDTO();
        List cargos = new ArrayList();
        if (obt != null && obt.getCargos() != null && obt.getCargos().length != 0) {
            for (int i = 0; i < obt.getCargos().length; i++) {
                if (obt.getCargos()[i].getPrecio() != null && obt.getCargos()[i].getPrecio().getCodigoConcepto() != null) {
                    int existeCargo = existeCodConcepto(obt.getCargos()[i].getPrecio().getCodigoConcepto(), cargos);
                    if (existeCargo == -1) {
                        cargos.add(obt.getCargos()[i]);
                    } else {
                        ((CargosDTO) cargos.get(existeCargo)).setCantidad(((CargosDTO) cargos.get(existeCargo)).getCantidad() + 1);
                    }
                }
            }
        }

        if (cargos.size() != 0) {
            Iterator iterator = cargos.iterator();
            CargosDTO[] x = new CargosDTO[cargos.size()];
            for (int a = 0; iterator.hasNext(); a++) {
                x[a] = (CargosDTO) iterator.next();
            }
            cargosObt.setCargos(x);
        }
        return cargosObt;
    }

    private int existeCodConcepto(String codConcepto, List cargos) {
        for (int i = 0; i < cargos.size(); i++) {
            if (codConcepto.equalsIgnoreCase(((CargosDTO) cargos.get(i)).getPrecio().getCodigoConcepto())) {
                return i;
            }
        }
        return -1;
    }

    private List obtenerTiposDescuentos() {
        TiposDescuentoDTO[] tipDesc = new TiposDescuentoDTO[3];
        tipDesc[0] = new TiposDescuentoDTO();
        tipDesc[0].setCodTipoDescuento(String.valueOf(2));
        tipDesc[0].setDescTipoDescuento("");
        tipDesc[1] = new TiposDescuentoDTO();
        tipDesc[1].setCodTipoDescuento(String.valueOf(0));
        tipDesc[1].setDescTipoDescuento("Monto");
        tipDesc[2] = new TiposDescuentoDTO();
        tipDesc[2].setCodTipoDescuento(String.valueOf(1));
        tipDesc[2].setDescTipoDescuento("Porcentaje");
        return Arrays.asList(tipDesc);
    }

    public DescuentoDTO[] obtenerDescuentos(String codConcepto, TablaCargosDTO[] tablaCargos, DescuentoDTO[] arregloDescuentos) throws Exception {
        boolean yaEntro = false;
        DescuentoDTO[] retorno = null;
        DescuentoDTO descuentoNuevo = null;
        DescuentoDTO descuentoAutomatico = null;
        List listDescuentos = new ArrayList();

        /**
         * @author: rlozano
         * @Description:Recorremos la tabla web para encontrar el registro
         *                         correspondiente mediante el codConcepto
         */
        for (int i = 0; i < tablaCargos.length; i++) {
            // nos ubicamos en el registro
            String montoDescManual = null;
            String montoDescAutom = null;
            if (tablaCargos[i].getCodConcepto().equalsIgnoreCase(codConcepto)) {
                // verificamos q existan decuentos manuales y descuentos
                // automaticos
                montoDescManual = tablaCargos[i].getDescuentoUnitarioMan();
                if (montoDescManual == null || "".equals(montoDescManual)) {
                    montoDescManual = "0";
                } else {
                    montoDescManual = montoDescManual.trim();
                }
                montoDescAutom = tablaCargos[i].getDescuentoUnitarioAut();
                if (montoDescAutom == null || "".equals(montoDescAutom)) {
                    montoDescAutom = "0";
                } else {
                    montoDescAutom = montoDescAutom.trim();
                }
                String tipoMontoAutom = null;
                if (!"0".equals(montoDescAutom)) {
                    descuentoAutomatico = new DescuentoDTO();
                    descuentoAutomatico.setCodigoConcepto(tablaCargos[i].getCodConceptoDescuento());
                    descuentoAutomatico.setCodigoConceptoCargo(codConcepto);
                    tipoMontoAutom = tablaCargos[i].getTipoDescuentoAut();
                    if (tipoMontoAutom == null) {
                        tipoMontoAutom = "";
                    } else {
                        tipoMontoAutom = tipoMontoAutom.trim();
                    }
                    if ("Porcentaje".equals(tipoMontoAutom)) {
                        tipoMontoAutom = "1";
                    } else {
                        tipoMontoAutom = tipoMontoAutom;
                    }
                    if ("Monto".equals(tipoMontoAutom)) {
                        tipoMontoAutom = "0";
                    } else {
                        tipoMontoAutom = tipoMontoAutom;
                    }
                    tablaCargos[i].setTipoDescuentoAut(tipoMontoAutom);
                    descuentoAutomatico.setTipoAplicacion(tipoMontoAutom); // si
                    // es
                    // monto
                    // /
                    // porcentaje
                    descuentoAutomatico.setTipo("1");
                    int cantidad = Integer.parseInt(tablaCargos[i].getCantidad());
                    if ("0".equalsIgnoreCase(tablaCargos[i].getTipoDescuentoAut())) { // importe*/
                        descuentoAutomatico.setMonto(Float.parseFloat(tablaCargos[i].getDescuentoUnitarioAut()) / cantidad);
                    } else { // porcentaje
                        descuentoAutomatico.setMonto(Float.parseFloat(tablaCargos[i].getDescuentoUnitarioAut()));
                    }
                    listDescuentos.add(descuentoAutomatico);
                }

                // Creamos registro para descuento Manual
                if (!"0".equals(montoDescManual)) {
                    yaEntro = true;
                    descuentoNuevo = new DescuentoDTO();
                    descuentoNuevo.setCodigoConceptoCargo(codConcepto);
                    descuentoNuevo.setTipoAplicacion(tablaCargos[i].getTipoDescuentoManual()); // si
                    // es
                    // monto
                    // porcentaje
                    descuentoNuevo.setTipo("0");

                    int cantidad = Integer.parseInt(tablaCargos[i].getCantidad());
                    if ("0".equalsIgnoreCase(tablaCargos[i].getTipoDescuentoManual())) { // importe*/
                        descuentoNuevo.setMonto(Float.parseFloat(montoDescManual) / cantidad);
                    } else { // porcentaje
                        descuentoNuevo.setMonto(Float.parseFloat(montoDescManual));
                    }

                    /**
                     * @author : rlozano
                     * @descripcion : Se procede a crear cod concepto para el
                     *              decuento manual siempre y cuando no existan
                     *              descuentos automaticos asociados
                     */

                    if ("0".equals(montoDescAutom)) {
                        SecuenciaDTO secuencia = new SecuenciaDTO();
                        secuencia.setNomSecuencia("GA_SEQ_TRANSACABO");                        
                        long numSecuencia = locator.obtenerSecuencia(secuencia).getNumSecuencia();
                        DescuentoDTO descuento = new DescuentoDTO();
                        descuento.setNumTransaccion(String.valueOf(numSecuencia));
                        descuento.setCodigoConceptoCargo(tablaCargos[i].getCodConcepto());
                        // inserta concepto en ga_transacabo
                        locator.insertarConceptoDescuento(descuento);
                        DatosGeneralesDTO param = new DatosGeneralesDTO();
                        param.setSecuencia(numSecuencia);
                        // obtiene codigo desde ga_transacabo                     
                        descuento = locator.obtenerCodConceptoDescuento(param);
                        String codigoDef = descuento.getCodigoConcepto();
                        loggerDebug("codigoDef=[" + codigoDef + "]");

                        // elimina registro insertado                        
                        locator.eliminaCodConceptoDescuento(numSecuencia);

                        descuentoNuevo.setCodigoConcepto(codigoDef);
                        // retorno[0]=descuentoNuevo;
                        // (-)evera 26/09/2007
                    } else {
                        descuentoNuevo.setCodigoConcepto(tablaCargos[i].getCodConceptoDescuento());
                        // corresponde al automático
                    }
                    listDescuentos.add(descuentoNuevo);
                }
            } else if (tablaCargos[i].getCodConcepto().equalsIgnoreCase(codConcepto)) {
                if (arregloDescuentos != null && arregloDescuentos.length > 0) {
                    if (arregloDescuentos[0].getTipoAplicacion() != null && "0".equals(arregloDescuentos[0].getTipoAplicacion())
                            && tablaCargos[i].getDescuentoUnitarioMan() != null && "".equals(tablaCargos[i].getDescuentoUnitarioMan().trim())) {
                        // tablaCargos[i].setDescuentoUnitarioMan(null);
                        retorno = null;
                    } else {
                        retorno = arregloDescuentos;
                    }
                }
            }
            if (retorno != null && yaEntro) {
                tablaCargos[i].setCodConceptoDescuento(retorno[0].getCodigoConcepto());
                yaEntro = false;
            }
        }
        if (!listDescuentos.isEmpty()) {
            retorno = (DescuentoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(listDescuentos.toArray(), DescuentoDTO.class);
        }
        // Verificar;
        return retorno;
    }

}
