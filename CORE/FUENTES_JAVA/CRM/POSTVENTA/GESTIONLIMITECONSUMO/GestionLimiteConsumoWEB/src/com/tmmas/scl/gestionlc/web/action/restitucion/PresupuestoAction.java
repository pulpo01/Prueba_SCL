package com.tmmas.scl.gestionlc.web.action.restitucion;

import java.io.File;
import java.rmi.RemoteException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.scl.framework.ProductDomain.dto.ModalidadPagoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.CargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ContratoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DocumentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.GaVentasDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ImpuestosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.UsuarioDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CabeceraArchivoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegCargosDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegistroFacturacionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.VendedorDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PresupuestoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ResultadoRegCargosDTO;
import com.tmmas.scl.gestionlc.common.dto.TablaCargosDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.IndicadorAbonoInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.IndicadorAbonoOutDTO;
import com.tmmas.scl.gestionlc.common.exception.GestionLimiteConsumoException;
import com.tmmas.scl.gestionlc.ejb.session.GestLimCon;
import com.tmmas.scl.gestionlc.web.action.base.AbstractAction;
import com.tmmas.scl.gestionlc.web.form.restitucion.CargosForm;
import com.tmmas.scl.gestionlc.web.form.restitucion.PresupuestoForm;
import com.tmmas.scl.gestionlc.web.form.restitucion.RestitucionEquipoForm;
import com.tmmas.scl.gestionlc.web.helper.GestionLimiteConsumoLocator;
import com.tmmas.scl.gestionlc.web.helper.Utilidades;
import com.tmmas.scl.operations.crm.fab.customerinterfacemanagement.common.helper.Util;

public class PresupuestoAction extends AbstractAction {

    private static final String SIGUIENTE = "controlNavegacion";
    private static final String ANTERIOR = "controlNavegacion";
    private static final String PAGINA = "presupuesto";
    private String textoMensajeRestricciones;

    private GestionLimiteConsumoLocator locator;

    protected ActionForward doPerform(ActionMapping pMapping, ActionForm pForm, HttpServletRequest pRequest, HttpServletResponse pHttpResponse)

        throws Exception {
        locator = new GestionLimiteConsumoLocator();
//        gestLimCon = locator.getGestLimConFacade();

        loggerDebug("executeAction:PresupuestoAction");

        HttpSession session = pRequest.getSession(false);

        PresupuestoForm formPresupuesto = (PresupuestoForm) pForm;

        session.removeAttribute("numeroVenta");

        CargosForm cargosForm = new CargosForm();

        if (session.getAttribute("CargosForm") != null) {
            cargosForm = (CargosForm) session.getAttribute("CargosForm");
        }

        RestitucionEquipoForm restitucionEquipoForm = (RestitucionEquipoForm) session.getAttribute("RestitucionEquipoForm");

        // TODO obtener valores para las siguientes variables
        ClienteDTO datosCliente = (ClienteDTO) session.getAttribute("datosCliente");

        AbonadoDTO datosAbonado = (AbonadoDTO) session.getAttribute("datosAbonado");

        long lonCodCliente = datosCliente.getCodCliente();
        String strCodTipContrato = datosAbonado.getCodTipContrato();
        String userName = (String) session.getAttribute("UserName");
        String strDesCuenta = datosCliente.getDesCuenta();
        String strNombres = datosCliente.getNombres();

        if (formPresupuesto.getAccion() != null && !((String) session.getAttribute("accionAutDesc")).equalsIgnoreCase("")) {

            loggerDebug("accionAutDesc         [" + session.getAttribute("accionAutDesc") + "]");
            loggerDebug("formPresup.getAccion()[" + formPresupuesto.getAccion() + "]");

            session.setAttribute("ultimaPagina", "Presupuesto");
            if (formPresupuesto.getAccion().equalsIgnoreCase("Siguiente")) {
                formPresupuesto.setAccion("");
                session.setAttribute("accionAutDesc", "Siguiente");

                // cierro la ventana
                PresupuestoDTO presup = new PresupuestoDTO();
                presup.setNumVenta(cargosForm.getNumVenta());
                String impTotal = Utilidades.eliminaCaracterdeCadena(',', cargosForm.getTotal());
                presup.setNumProceso(formPresupuesto.getNumProceso());

                cierreVenta(presup, lonCodCliente, Float.parseFloat(impTotal), formPresupuesto.getMontoAbono(), (String) session.getAttribute("numSecuencia"));
                loggerDebug("SIGUIENTE        [" + SIGUIENTE + "]");
                return pMapping.findForward(SIGUIENTE);

            } else if (formPresupuesto.getAccion().equalsIgnoreCase("Anterior")) {

                formPresupuesto.setAccion("");
                session.setAttribute("accionAutDesc", "Anterior");
                RegistroFacturacionDTO registro = new RegistroFacturacionDTO();
                registro.setNumeroProcesoFacturacion(String.valueOf(formPresupuesto.getNumProceso()));
                /**
                 * @author rlozano
                 * @description se retorna a Cero el total de los cargos
                 *              seleccionados;
                 */
                // cargosForm.setNumVenta(0);
                cargosForm.setTotal("0");
                cargosForm.setRbCiclo("NO");
                registro.setNumeroVenta(String.valueOf(cargosForm.getNumVenta()));
                loggerDebug("eliminarPresupuesto:antes");
                locator.eliminarPresupuesto(registro);
                loggerDebug("eliminarPresupuesto:despues");
                loggerDebug("ANTERIOR        [" + ANTERIOR + "]");
                session.removeAttribute("seRegistroCargosInmediatos");
                return pMapping.findForward(ANTERIOR);

            } else if (formPresupuesto.getAccion().equalsIgnoreCase("Imprimir")) {
                String rutaReporte = System.getProperty("user.dir") + getValorInterno("ruta.reportes") + getValorInterno("reporte.presupuesto");

                loggerDebug("RUTA_REPORTE : " + rutaReporte);

                Map parametros = new HashMap();
                // numero venta
                parametros.put("numeroVenta", String.valueOf(cargosForm.getNumVenta()));
                // producto
                parametros.put("descripcionProducto", "CELULAR");
                // tipo contrato
                ContratoDTO contrato = new ContratoDTO();
                contrato.setCodProducto(Integer.parseInt(getValorInterno("parametro.codigo.producto.uno")));
                contrato.setCodigoTipoContrato(strCodTipContrato);                
                contrato = locator.obtenerTipoContrato(contrato);
                parametros.put("tipoContrato", contrato.getDescripcionTipoContrato());
                // modalidad venta
                ModalidadPagoDTO modalidad = new ModalidadPagoDTO();
                // modalidad.setCodigoModalidadPago(cargosForm.getCbModPago());
                modalidad.setCodigoModalidadPago(restitucionEquipoForm.getStrCodModPago());
                modalidad = locator.obtenerModalidadPago(modalidad);
                parametros.put("descripcionModalidadVenta", modalidad.getDescripcionModalidadPago());
                // vendedor
                UsuarioDTO usuario = new UsuarioDTO();
                usuario.setNombre(userName);                
                usuario = locator.obtenerVendedor(usuario);
                VendedorDTO vendedor = new VendedorDTO();
                vendedor.setCodigoVendedor(String.valueOf(usuario.getCodigo()));                
                vendedor = locator.obtenerVendedor(vendedor);
                parametros.put("nombreVendedor", vendedor.getNombreVendedor());
                // obtener cuenta
                parametros.put("cuenta", strDesCuenta);
                // obtener cliente
                parametros.put("nombreCliente", strNombres);
                // tipo documento
                parametros.put("descripcionTipoDocumento", (String) session.getAttribute("glsTipoDocumento"));
                // detalle cargos
                PresupuestoDTO presup = new PresupuestoDTO();
                presup.setNumProceso(formPresupuesto.getNumProceso());
                // presup.setNumProceso(7930591);                
                presup = locator.obtenerDetallePresupuesto(presup);

                List presupuesto = new ArrayList();
                for (int i = 0; i < presup.getDetalle().length; i++) {
                    presupuesto.add(presup.getDetalle()[i]);
                }

                // DataSource
                JRBeanCollectionDataSource ds = new JRBeanCollectionDataSource(presupuesto);
                ServletOutputStream servletOutputStream = pHttpResponse.getOutputStream();

                DecimalFormat df = new DecimalFormat();
                StringBuffer mascaraNumero = new StringBuffer();
                mascaraNumero.append(getValorInterno("formato.numero.reporte"));
                df.applyPattern(mascaraNumero.toString());
                parametros.put("mascaraNumeros", df);

                File reportFile = new File(rutaReporte);
                loggerDebug("Estado reporte :Existe=" + reportFile.exists() + ", Largo=" + reportFile.length());

                byte[] bytes = JasperRunManager.runReportToPdf(reportFile.getPath(), parametros, ds);

                pHttpResponse.setContentType("application/pdf");
                pHttpResponse.setContentLength(bytes.length);
                pHttpResponse.setHeader("Content-disposition", "attachment; filename=" + "Factura.pdf");
                ServletOutputStream ouputStream = pHttpResponse.getOutputStream();
                ouputStream.write(bytes, 0, bytes.length);
                ouputStream.flush();
                ouputStream.close();

            }

        } else {
            session.setAttribute("accionAutDesc", "primeraCarga");
            // ObtencionCargosDTO obtencionCargos = cargosForm.getCargosMerge();
            // //Arreglo de Cargos a Registrar CargosDTO
            ObtencionCargosDTO obtencionCargos = cargosForm.getCargosSeleccionados(); // Arreglo
            // de
            // Cargos
            // a
            // Registrar
            // CargosDTO

            long codCliente = lonCodCliente; // Codigo del Cliente

            int codPlanCom;
            // sessionData.getCliente().getCodPlanCom(); //Plan Comercial
            // Cliente
            ClienteDTO clienteTMP = new ClienteDTO();
            clienteTMP.setCodCliente(codCliente);            
            clienteTMP = locator.obtenerPlanComercial(clienteTMP);
            codPlanCom = clienteTMP.getCodPlanCom();

            boolean aCiclo = false; // sessionData.getCargosObtenidos().isACiclo();
            // //facturaCiclo
            long numVenta = cargosForm.getNumVenta(); // numVenta
            String codTipoDocumento = cargosForm.getCbTipoDocumento();
            String glsTipoDocumento = " ";
            String tipoFoliacion = " ";

            // buscar glosa de documento y tipo foliacion:
            List listaTiposDoc = cargosForm.getDocumentosList();
            if (listaTiposDoc != null) {
                Iterator ite = listaTiposDoc.iterator();
                while (ite.hasNext()) {
                    DocumentoDTO doc = (DocumentoDTO) ite.next();
                    if (doc.getCodigo().equals(codTipoDocumento)) {
                        glsTipoDocumento = doc.getDescripcion(); // glosa tipo
                        // documento
                        // (Boleta/Factura)
                        tipoFoliacion = doc.getTipoFoliacion();
                        break;
                    }
                }
            }

            try {

                // llamar a ejecutar cargos
                ResultadoRegCargosDTO resultadoRegistroCargos = new ResultadoRegCargosDTO();
                RegCargosDTO retValConst = new RegCargosDTO();

                loggerDebug("construirRegistroCargos:antes");                
                retValConst = locator.construirRegistroCargos(obtencionCargos);

                if (retValConst != null && retValConst.getCargos() != null && retValConst.getCargos().length > 0) {
                    loggerDebug("construirRegistroCargos, numero de cargos construidos[" + retValConst.getCargos().length + "]");
                } else {
                    loggerDebug("construirRegistroCargos, no hay cargos construidos");
                }

                loggerDebug("construirRegistroCargos:despues");

                CabeceraArchivoDTO objetoSesion = new CabeceraArchivoDTO();
                objetoSesion.setPlanComercialCliente(String.valueOf(codPlanCom));
                objetoSesion.setCodigoCliente(String.valueOf(codCliente));
                objetoSesion.setFacturaCiclo(aCiclo);
                objetoSesion.setNumeroVenta(numVenta);

                SecuenciaDTO secuencia = new SecuenciaDTO();
                secuencia.setNomSecuencia("GA_SEQ_TRANSACABO");
                
                long numSecuencia = locator.obtenerSecuencia(secuencia).getNumSecuencia();
                loggerDebug("objetoSesion.setNumeroTransaccionVenta numSecuencia[" + numSecuencia + "]");
                session.setAttribute("numSecuencia", String.valueOf(numSecuencia));
                objetoSesion.setNumeroTransaccionVenta(numSecuencia);

                objetoSesion.setCodigoDocumento(codTipoDocumento);
                objetoSesion.setCodModalidadVenta(cargosForm.getCbModPago());

                // TODO : Obtener vendedor
                UsuarioDTO usuario = new UsuarioDTO();
                usuario.setNombre(userName);                
                usuario = locator.obtenerVendedor(usuario);
                objetoSesion.setCodigoVendedor(String.valueOf(usuario.getCodigo()));
                objetoSesion.setNombreUsuario(userName); // COL
                // 94740|25-06-2009|SAQL

                retValConst.setObjetoSesion(objetoSesion);

                // registra cargos y devuelve presupuesto
                loggerDebug("parametrosRegistrarCargos:antes");                
                resultadoRegistroCargos = locator.parametrosRegistrarCargos(retValConst);
                // resultadoRegistroCargos.setNumeroProceso("88888888");
                // resultadoRegistroCargos.setTotalImpuestos(1256);
                loggerDebug("parametrosRegistrarCargos:despues");

                session.setAttribute("seRegistroCargosInmediatos", "SI");

                session.setAttribute("resultadoRegistroCargos", resultadoRegistroCargos);

                // obtener numero de proceso
                loggerDebug("NUMERO_PROCESO: " + resultadoRegistroCargos.getNumeroProceso());
                formPresupuesto.setNumProceso(Long.parseLong(resultadoRegistroCargos.getNumeroProceso()));

                // lo cargo para validar si hay que cargar el popup o no
                // CambioDeSerieForm cambioSerieForm =
                // (CambioDeSerieForm)session.getAttribute("CambioDeSerieForm");
                IndicadorAbonoInDTO indicadorAbonoInDTO = new IndicadorAbonoInDTO();
                indicadorAbonoInDTO.setIntCodModVenta(Integer.valueOf(restitucionEquipoForm.getStrCodModPago()));

                // OBTENER ESTE INDICADOR ESTA MAL, SE DEBE SELECCIONAR SI ES
                // ABONO
                // DIFERIDO DESDE LA PANTALLA DE RESTITUCION                
                IndicadorAbonoOutDTO indicadorAbonoOutDTO = locator.obtieneIndicadorAbono(indicadorAbonoInDTO);

                validaResult(indicadorAbonoOutDTO.getIEvento(), indicadorAbonoOutDTO.getStrCodError(), indicadorAbonoOutDTO.getStrDesError());

                if (indicadorAbonoOutDTO.getIntIndicadorAbono().intValue() == 1) {
                    String strAbonoDiferido = "SI"; // cambioSerieForm.getAbonoDiferido()
                    formPresupuesto.setRbCiclo(strAbonoDiferido);
                } else {
                    String strAbonoDiferido = "NO"; // cambioSerieForm.getAbonoDiferido()
                    formPresupuesto.setRbCiclo(strAbonoDiferido);
                }
                // FIN ERROR ABONO DIFERIDO

                // obtener presupuesto
                ImpuestosDTO impuesto = new ImpuestosDTO();
                // *************para probar***********
                // formPresupuesto.setNumProceso(2417725);
                TablaCargosDTO[] tablaCargosDTO = null;
                List cargos = new ArrayList();
                String[] totalesPresupuesto = new String[4];

                float importeTotal = 0;

                if (cargosForm != null) {

                    tablaCargosDTO = cargosForm.getTablaCargos();
                    impuesto.setTotalImpuestos(resultadoRegistroCargos.getTotalImpuestos());

                    PresupuestoDTO presup = new PresupuestoDTO();
                    presup.setNumProceso(formPresupuesto.getNumProceso());                    
                    presup = locator.obtenerDetallePresupuesto(presup);
                    float valorImporteTotal = 0;
                    float valorImpuestos = 0;
                    float valorImporteDescuentos = 0;
                    float valorImporteBase = 0;
                    for (int k = 0; k < presup.getDetalle().length; k++) {
                        valorImporteTotal = valorImporteTotal + presup.getDetalle()[k].getImpTotal();
                        valorImpuestos = valorImpuestos + presup.getDetalle()[k].getImpImpuesto();
                        valorImporteDescuentos = valorImporteDescuentos + presup.getDetalle()[k].getImpDcto();
                        valorImporteBase = valorImporteBase + presup.getDetalle()[k].getImpBase();
                    }

                    if (tablaCargosDTO != null) {

                        for (int i = 0; i < tablaCargosDTO.length; i++) {
                            if (aplicaCargo(tablaCargosDTO[i].getCodConcepto(), cargosForm)) {
                                cargos.add(tablaCargosDTO[i]);
                            }
                        }

                        TablaCargosDTO[] cargosAprobados = new TablaCargosDTO[cargos.size()];
                        for (int a = 0; a < cargos.size(); a++) {
                            cargosAprobados[a] = (TablaCargosDTO) cargos.get(a);
                        }

                        tablaCargosDTO = cargosAprobados;
                        float saldo = 0;
                        importeTotal = 0;
                        float totalDscto = 0;

                        for (int j = 0; j < tablaCargosDTO.length; j++) {
                            saldo = saldo + Float.parseFloat(tablaCargosDTO[j].getSaldo());
                            importeTotal = importeTotal + Float.parseFloat(tablaCargosDTO[j].getImporteTotal());
                            String tipdesAut = tablaCargosDTO[j].getTipoDescuentoAut();
                            if (tipdesAut == null) {
                                tipdesAut = "";
                            } else {
                                tipdesAut = tipdesAut;
                            }
                            if ("0".equals(tipdesAut)) {
                                tipdesAut = "Monto";
                            } else {
                                if ("1".equals(tipdesAut)) {
                                    tipdesAut = "Porcentaje";
                                } else {
                                    tipdesAut = "N/A";
                                }
                            }
                            tablaCargosDTO[j].setTipoDescuentoAut(tipdesAut);

                        }

                        String numDecimales = (String) session.getAttribute("numDecimalesFormulario");
                        totalesPresupuesto[0] = Util.formatearNumeroMoneda(String.valueOf(valorImporteBase), numDecimales);
                        totalesPresupuesto[1] = Util.formatearNumeroMoneda(String.valueOf(valorImpuestos), numDecimales);
                        totalesPresupuesto[2] = Util.formatearNumeroMoneda(String.valueOf(-valorImporteDescuentos), numDecimales);
                        totalesPresupuesto[3] = Util.formatearNumeroMoneda(String.valueOf(valorImporteTotal), numDecimales);
                        loggerDebug("Total Conceptos          :" + totalesPresupuesto[0]);
                        loggerDebug("Total Impuesto           :" + totalesPresupuesto[1]);
                        loggerDebug("Total Descuentos         :" + totalesPresupuesto[2]);
                        loggerDebug("Total Presupuesto        :" + totalesPresupuesto[3]);

                    } else {

                        totalesPresupuesto[0] = "0";
                        totalesPresupuesto[1] = "0";
                        totalesPresupuesto[2] = "0";
                        totalesPresupuesto[3] = "0";

                    }

                    session.setAttribute("totalesPresupuesto", totalesPresupuesto);
                    // //cierre venta
                    // PresupuestoDTO presup=new PresupuestoDTO();
                    presup.setNumVenta(numVenta);
                    presup.setNumProceso(numSecuencia);
                    cierreVenta(presup, lonCodCliente, valorImporteTotal, formPresupuesto.getMontoAbono(), String.valueOf(numSecuencia));

                }

            } catch (Exception e) {
                // textoMensajeRestricciones="Error al Registrar Cargos o Prebilling";
                // delegate.guardaMensajesError(pRequest,
                // "Error en el Módulo de Cargos o Prebilling",
                // textoMensajeRestricciones);
                // return mapping.findForward("error");
                throw e;
            }

            // dejar en request valores
            session.setAttribute("numeroVenta", String.valueOf(cargosForm.getNumVenta()));

            session.setAttribute("glsTipoDocumento", glsTipoDocumento);
        } // fin if

        loggerDebug("execute():end");
        return pMapping.findForward(PAGINA);

    }

    public boolean aplicaCargo(String codConcepto, CargosForm cargosForm) {
        TablaCargosDTO[] tablaCargos = cargosForm.getTablaCargos();
        ObtencionCargosDTO cargosSelecionados = cargosForm.getCargosSeleccionados();
        String codConceptoCargo = null;
        boolean retValue = false;
        if (cargosSelecionados != null && cargosSelecionados.getCargos() != null) {
            CargosDTO[] cargos = cargosSelecionados.getCargos();
            for (int i = 0; i < cargos.length; i++) {
                codConceptoCargo = cargos[i].getPrecio().getCodigoConcepto();
                if (codConcepto.equals(codConceptoCargo)) {
                    retValue = true;
                }
            }
        }
        return retValue;

    }

    public void cierreVenta(PresupuestoDTO presupuestoDTO, long codCliente, float impTotal, Float montoAbono, String numSecuencia) {

        try {
            if (presupuestoDTO.getNumVenta() > 0) {

                GaVentasDTO gaVentasDTO = new GaVentasDTO();
                gaVentasDTO.setNumVenta(new Long(presupuestoDTO.getNumVenta()));
                // gaVentasDTO.setNumTransaccion(new
                // Long(presupuestoDTO.getNumProceso()));
                gaVentasDTO.setNumProceso(Long.getLong("" + presupuestoDTO.getNumProceso()));
                gaVentasDTO.setCodCliente(new Long(codCliente));
                gaVentasDTO.setImpVenta(new Float(impTotal));
                gaVentasDTO.setAciclo(false);
                gaVentasDTO.setCuotas(false);
                gaVentasDTO.setCheque(true); // parametro para la ejecucion del
                // update caso C
                gaVentasDTO.setTrajCredito(false); // parametro para la
                                                   // ejecucion
                // del update caso C
                gaVentasDTO.setNumTransaccion(new Long(numSecuencia));
                // montoAbono es el tomado en el popup de ingreso de monto de
                // abono
                float valorMontoAbono;
                if (montoAbono == null) {
                    valorMontoAbono = new Float("0.0");
                } else {
                    valorMontoAbono = montoAbono;
                }
                gaVentasDTO.setImpAbono(valorMontoAbono);
                gaVentasDTO.setIndAbono(Long.valueOf(getValorInterno("indicador_abono_venta")));
              
                locator.cierreVenta(gaVentasDTO);

            }
        } catch (GestionLimiteConsumoException e) {
            e.printStackTrace();
            loggerError(e);

//        } catch (RemoteException e) {
//            // TODO Auto-generated catch block
//            e.printStackTrace();
        }
    }

}
