/**
 * WSSEGPortalService.as
 * This file was auto-generated from WSDL by the Apache Axis2 generator modified by Adobe
 * Any change made to this file will be overwritten when the code is re-generated.
 */
 /**
  * Usage example: to use this service from within your Flex application you have two choices:
  * Use it via Actionscript only
  * Use it via MXML tags
  * Actionscript sample code:
  * Step 1: create an instance of the service; pass it the LCDS destination string if any
  * var myService:WSSEGPortal= new WSSEGPortal();
  * Step 2: for the desired operation add a result handler (a function that you have already defined previously)  
  * myService.addcargarReposicionSrvCelularEventListener(myResultHandlingFunction);
  * Step 3: Call the operation as a method on the service. Pass the right values as arguments:
  * myService.cargarReposicionSrvCelular(mynumAbonado,mynomUsuarioSCL,mycodEvento);
  *
  * MXML sample code:
  * First you need to map the package where the files were generated to a namespace, usually on the <mx:Application> tag, 
  * like this: xmlns:srv="generated.webservices.orquestador.*"
  * Define the service and within its tags set the request wrapper for the desired operation
  * <srv:WSSEGPortal id="myService">
  *   <srv:cargarReposicionSrvCelular_request_var>
  *		<srv:CargarReposicionSrvCelular_request numAbonado=myValue,nomUsuarioSCL=myValue,codEvento=myValue/>
  *   </srv:cargarReposicionSrvCelular_request_var>
  * </srv:WSSEGPortal>
  * Then call the operation for which you have set the request wrapper value above, like this:
  * <mx:Button id="myButton" label="Call operation" click="myService.cargarReposicionSrvCelular_send()" />
  */
package generated.webservices.orquestador
{
	import mx.rpc.AsyncToken;
	import flash.events.EventDispatcher;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.events.FaultEvent;
	import flash.utils.ByteArray;
	import mx.rpc.soap.types.*;

    /**
     * Dispatches when a call to the operation cargarReposicionSrvCelular completes with success
     * and returns some data
     * @eventType CargarReposicionSrvCelularResultEvent
     */
    [Event(name="CargarReposicionSrvCelular_result", type="generated.webservices.orquestador.CargarReposicionSrvCelularResultEvent")]
    
    /**
     * Dispatches when a call to the operation cuentasXNombre completes with success
     * and returns some data
     * @eventType CuentasXNombreResultEvent
     */
    [Event(name="CuentasXNombre_result", type="generated.webservices.orquestador.CuentasXNombreResultEvent")]
    
    /**
     * Dispatches when a call to the operation getDocsFactCliente completes with success
     * and returns some data
     * @eventType GetDocsFactClienteResultEvent
     */
    [Event(name="GetDocsFactCliente_result", type="generated.webservices.orquestador.GetDocsFactClienteResultEvent")]
    
    /**
     * Dispatches when a call to the operation abonadosXCelular completes with success
     * and returns some data
     * @eventType AbonadosXCelularResultEvent
     */
    [Event(name="AbonadosXCelular_result", type="generated.webservices.orquestador.AbonadosXCelularResultEvent")]
    
    /**
     * Dispatches when a call to the operation ejecutarCambioPlanPostPagoIndividual completes with success
     * and returns some data
     * @eventType EjecutarCambioPlanPostPagoIndividualResultEvent
     */
    [Event(name="EjecutarCambioPlanPostPagoIndividual_result", type="generated.webservices.orquestador.EjecutarCambioPlanPostPagoIndividualResultEvent")]
    
    /**
     * Dispatches when a call to the operation obtenerCamposDireccion completes with success
     * and returns some data
     * @eventType ObtenerCamposDireccionResultEvent
     */
    [Event(name="ObtenerCamposDireccion_result", type="generated.webservices.orquestador.ObtenerCamposDireccionResultEvent")]
    
    /**
     * Dispatches when a call to the operation cargaCambioDatosCliente completes with success
     * and returns some data
     * @eventType CargaCambioDatosClienteResultEvent
     */
    [Event(name="CargaCambioDatosCliente_result", type="generated.webservices.orquestador.CargaCambioDatosClienteResultEvent")]
    
    /**
     * Dispatches when a call to the operation cargarAbonoLimiteConsumo completes with success
     * and returns some data
     * @eventType CargarAbonoLimiteConsumoResultEvent
     */
    [Event(name="CargarAbonoLimiteConsumo_result", type="generated.webservices.orquestador.CargarAbonoLimiteConsumoResultEvent")]
    
    /**
     * Dispatches when a call to the operation ejecutarReposicionSrvCelular completes with success
     * and returns some data
     * @eventType EjecutarReposicionSrvCelularResultEvent
     */
    [Event(name="EjecutarReposicionSrvCelular_result", type="generated.webservices.orquestador.EjecutarReposicionSrvCelularResultEvent")]
    
    /**
     * Dispatches when a call to the operation getDocsAjustesCliente completes with success
     * and returns some data
     * @eventType GetDocsAjustesClienteResultEvent
     */
    [Event(name="GetDocsAjustesCliente_result", type="generated.webservices.orquestador.GetDocsAjustesClienteResultEvent")]
    
    /**
     * Dispatches when a call to the operation cargarCambioPlanPostPagoIndividual completes with success
     * and returns some data
     * @eventType CargarCambioPlanPostPagoIndividualResultEvent
     */
    [Event(name="CargarCambioPlanPostPagoIndividual_result", type="generated.webservices.orquestador.CargarCambioPlanPostPagoIndividualResultEvent")]
    
    /**
     * Dispatches when a call to the operation obtenerReporteIngrStatusEqui completes with success
     * and returns some data
     * @eventType ObtenerReporteIngrStatusEquiResultEvent
     */
    [Event(name="ObtenerReporteIngrStatusEqui_result", type="generated.webservices.orquestador.ObtenerReporteIngrStatusEquiResultEvent")]
    
    /**
     * Dispatches when a call to the operation servSumplemetariosXAbonado completes with success
     * and returns some data
     * @eventType ServSumplemetariosXAbonadoResultEvent
     */
    [Event(name="ServSumplemetariosXAbonado_result", type="generated.webservices.orquestador.ServSumplemetariosXAbonadoResultEvent")]
    
    /**
     * Dispatches when a call to the operation filtrarDetDocAjusteCReversionCargos completes with success
     * and returns some data
     * @eventType FiltrarDetDocAjusteCReversionCargosResultEvent
     */
    [Event(name="FiltrarDetDocAjusteCReversionCargos_result", type="generated.webservices.orquestador.FiltrarDetDocAjusteCReversionCargosResultEvent")]
    
    /**
     * Dispatches when a call to the operation getDetalleCuenta completes with success
     * and returns some data
     * @eventType GetDetalleCuentaResultEvent
     */
    [Event(name="GetDetalleCuenta_result", type="generated.webservices.orquestador.GetDetalleCuentaResultEvent")]
    
    /**
     * Dispatches when a call to the operation filtrarDetDocAjusteCExcepcionCargos completes with success
     * and returns some data
     * @eventType FiltrarDetDocAjusteCExcepcionCargosResultEvent
     */
    [Event(name="FiltrarDetDocAjusteCExcepcionCargos_result", type="generated.webservices.orquestador.FiltrarDetDocAjusteCExcepcionCargosResultEvent")]
    
    /**
     * Dispatches when a call to the operation detallePlanTarifario completes with success
     * and returns some data
     * @eventType DetallePlanTarifarioResultEvent
     */
    [Event(name="DetallePlanTarifario_result", type="generated.webservices.orquestador.DetallePlanTarifarioResultEvent")]
    
    /**
     * Dispatches when a call to the operation cargarCambioEquipoGSM completes with success
     * and returns some data
     * @eventType CargarCambioEquipoGSMResultEvent
     */
    [Event(name="CargarCambioEquipoGSM_result", type="generated.webservices.orquestador.CargarCambioEquipoGSMResultEvent")]
    
    /**
     * Dispatches when a call to the operation ejecucionServicioCargos completes with success
     * and returns some data
     * @eventType EjecucionServicioCargosResultEvent
     */
    [Event(name="EjecucionServicioCargos_result", type="generated.webservices.orquestador.EjecucionServicioCargosResultEvent")]
    
    /**
     * Dispatches when a call to the operation gruposXNomUsuario completes with success
     * and returns some data
     * @eventType GruposXNomUsuarioResultEvent
     */
    [Event(name="GruposXNomUsuario_result", type="generated.webservices.orquestador.GruposXNomUsuarioResultEvent")]
    
    /**
     * Dispatches when a call to the operation cargarAnulacionSiniestro completes with success
     * and returns some data
     * @eventType CargarAnulacionSiniestroResultEvent
     */
    [Event(name="CargarAnulacionSiniestro_result", type="generated.webservices.orquestador.CargarAnulacionSiniestroResultEvent")]
    
    /**
     * Dispatches when a call to the operation ejecutarCambioSIMCard completes with success
     * and returns some data
     * @eventType EjecutarCambioSIMCardResultEvent
     */
    [Event(name="EjecutarCambioSIMCard_result", type="generated.webservices.orquestador.EjecutarCambioSIMCardResultEvent")]
    
    /**
     * Dispatches when a call to the operation detalleLlamadas completes with success
     * and returns some data
     * @eventType DetalleLlamadasResultEvent
     */
    [Event(name="DetalleLlamadas_result", type="generated.webservices.orquestador.DetalleLlamadasResultEvent")]
    
    /**
     * Dispatches when a call to the operation esPrimerLogin completes with success
     * and returns some data
     * @eventType EsPrimerLoginResultEvent
     */
    [Event(name="EsPrimerLogin_result", type="generated.webservices.orquestador.EsPrimerLoginResultEvent")]
    
    /**
     * Dispatches when a call to the operation cargaNumFrecuentes completes with success
     * and returns some data
     * @eventType CargaNumFrecuentesResultEvent
     */
    [Event(name="CargaNumFrecuentes_result", type="generated.webservices.orquestador.CargaNumFrecuentesResultEvent")]
    
    /**
     * Dispatches when a call to the operation clientesXCodCliente completes with success
     * and returns some data
     * @eventType ClientesXCodClienteResultEvent
     */
    [Event(name="ClientesXCodCliente_result", type="generated.webservices.orquestador.ClientesXCodClienteResultEvent")]
    
    /**
     * Dispatches when a call to the operation obtenerOoSsProceso completes with success
     * and returns some data
     * @eventType ObtenerOoSsProcesoResultEvent
     */
    [Event(name="ObtenerOoSsProceso_result", type="generated.webservices.orquestador.ObtenerOoSsProcesoResultEvent")]
    
    /**
     * Dispatches when a call to the operation ajustesXCodCliente completes with success
     * and returns some data
     * @eventType AjustesXCodClienteResultEvent
     */
    [Event(name="AjustesXCodCliente_result", type="generated.webservices.orquestador.AjustesXCodClienteResultEvent")]
    
    /**
     * Dispatches when a call to the operation cambiosPlanAbonadoPospago completes with success
     * and returns some data
     * @eventType CambiosPlanAbonadoPospagoResultEvent
     */
    [Event(name="CambiosPlanAbonadoPospago_result", type="generated.webservices.orquestador.CambiosPlanAbonadoPospagoResultEvent")]
    
    /**
     * Dispatches when a call to the operation consultaOoSsProceso completes with success
     * and returns some data
     * @eventType ConsultaOoSsProcesoResultEvent
     */
    [Event(name="ConsultaOoSsProceso_result", type="generated.webservices.orquestador.ConsultaOoSsProcesoResultEvent")]
    
    /**
     * Dispatches when a call to the operation ingresoAtencion completes with success
     * and returns some data
     * @eventType IngresoAtencionResultEvent
     */
    [Event(name="IngresoAtencion_result", type="generated.webservices.orquestador.IngresoAtencionResultEvent")]
    
    /**
     * Dispatches when a call to the operation decirHelloWorld completes with success
     * and returns some data
     * @eventType DecirHelloWorldResultEvent
     */
    [Event(name="DecirHelloWorld_result", type="generated.webservices.orquestador.DecirHelloWorldResultEvent")]
    
    /**
     * Dispatches when a call to the operation cambiarDireccionesCliente completes with success
     * and returns some data
     * @eventType CambiarDireccionesClienteResultEvent
     */
    [Event(name="CambiarDireccionesCliente_result", type="generated.webservices.orquestador.CambiarDireccionesClienteResultEvent")]
    
    /**
     * Dispatches when a call to the operation consultaAtencion completes with success
     * and returns some data
     * @eventType ConsultaAtencionResultEvent
     */
    [Event(name="ConsultaAtencion_result", type="generated.webservices.orquestador.ConsultaAtencionResultEvent")]
    
    /**
     * Dispatches when a call to the operation obtenerCausalCambio completes with success
     * and returns some data
     * @eventType ObtenerCausalCambioResultEvent
     */
    [Event(name="ObtenerCausalCambio_result", type="generated.webservices.orquestador.ObtenerCausalCambioResultEvent")]
    
    /**
     * Dispatches when a call to the operation cambiarPassword completes with success
     * and returns some data
     * @eventType CambiarPasswordResultEvent
     */
    [Event(name="CambiarPassword_result", type="generated.webservices.orquestador.CambiarPasswordResultEvent")]
    
    /**
     * Dispatches when a call to the operation direccionesXCodCliente completes with success
     * and returns some data
     * @eventType DireccionesXCodClienteResultEvent
     */
    [Event(name="DireccionesXCodCliente_result", type="generated.webservices.orquestador.DireccionesXCodClienteResultEvent")]
    
    /**
     * Dispatches when a call to the operation cargarAbonoLimiteConsumoSS completes with success
     * and returns some data
     * @eventType CargarAbonoLimiteConsumoSSResultEvent
     */
    [Event(name="CargarAbonoLimiteConsumoSS_result", type="generated.webservices.orquestador.CargarAbonoLimiteConsumoSSResultEvent")]
    
    /**
     * Dispatches when a call to the operation ejecutarSuspensionSrvCelular completes with success
     * and returns some data
     * @eventType EjecutarSuspensionSrvCelularResultEvent
     */
    [Event(name="EjecutarSuspensionSrvCelular_result", type="generated.webservices.orquestador.EjecutarSuspensionSrvCelularResultEvent")]
    
    /**
     * Dispatches when a call to the operation cargaServicioCargos completes with success
     * and returns some data
     * @eventType CargaServicioCargosResultEvent
     */
    [Event(name="CargaServicioCargos_result", type="generated.webservices.orquestador.CargaServicioCargosResultEvent")]
    
    /**
     * Dispatches when a call to the operation oossEjecutadasXCodCuenta completes with success
     * and returns some data
     * @eventType OossEjecutadasXCodCuentaResultEvent
     */
    [Event(name="OossEjecutadasXCodCuenta_result", type="generated.webservices.orquestador.OossEjecutadasXCodCuentaResultEvent")]
    
    /**
     * Dispatches when a call to the operation consultaOrdenServicio completes with success
     * and returns some data
     * @eventType ConsultaOrdenServicioResultEvent
     */
    [Event(name="ConsultaOrdenServicio_result", type="generated.webservices.orquestador.ConsultaOrdenServicioResultEvent")]
    
    /**
     * Dispatches when a call to the operation facturasXCodCliente completes with success
     * and returns some data
     * @eventType FacturasXCodClienteResultEvent
     */
    [Event(name="FacturasXCodCliente_result", type="generated.webservices.orquestador.FacturasXCodClienteResultEvent")]
    
    /**
     * Dispatches when a call to the operation pagoLimiteConsumoXClienteAbonado completes with success
     * and returns some data
     * @eventType PagoLimiteConsumoXClienteAbonadoResultEvent
     */
    [Event(name="PagoLimiteConsumoXClienteAbonado_result", type="generated.webservices.orquestador.PagoLimiteConsumoXClienteAbonadoResultEvent")]
    
    /**
     * Dispatches when a call to the operation pagosXCodCliente completes with success
     * and returns some data
     * @eventType PagosXCodClienteResultEvent
     */
    [Event(name="PagosXCodCliente_result", type="generated.webservices.orquestador.PagosXCodClienteResultEvent")]
    
    /**
     * Dispatches when a call to the operation cambiosPlanCliente completes with success
     * and returns some data
     * @eventType CambiosPlanClienteResultEvent
     */
    [Event(name="CambiosPlanCliente_result", type="generated.webservices.orquestador.CambiosPlanClienteResultEvent")]
    
    /**
     * Dispatches when a call to the operation ejecutarAjusteCExcepcionCargos completes with success
     * and returns some data
     * @eventType EjecutarAjusteCExcepcionCargosResultEvent
     */
    [Event(name="EjecutarAjusteCExcepcionCargos_result", type="generated.webservices.orquestador.EjecutarAjusteCExcepcionCargosResultEvent")]
    
    /**
     * Dispatches when a call to the operation beneficiosXClienteAbonado completes with success
     * and returns some data
     * @eventType BeneficiosXClienteAbonadoResultEvent
     */
    [Event(name="BeneficiosXClienteAbonado_result", type="generated.webservices.orquestador.BeneficiosXClienteAbonadoResultEvent")]
    
    /**
     * Dispatches when a call to the operation insertComentarioPvIorserv completes with success
     * and returns some data
     * @eventType InsertComentarioPvIorservResultEvent
     */
    [Event(name="InsertComentarioPvIorserv_result", type="generated.webservices.orquestador.InsertComentarioPvIorservResultEvent")]
    
    /**
     * Dispatches when a call to the operation realizarBloqueoRobo completes with success
     * and returns some data
     * @eventType RealizarBloqueoRoboResultEvent
     */
    [Event(name="RealizarBloqueoRobo_result", type="generated.webservices.orquestador.RealizarBloqueoRoboResultEvent")]
    
    /**
     * Dispatches when a call to the operation cuentasXNumIdent completes with success
     * and returns some data
     * @eventType CuentasXNumIdentResultEvent
     */
    [Event(name="CuentasXNumIdent_result", type="generated.webservices.orquestador.CuentasXNumIdentResultEvent")]
    
    /**
     * Dispatches when a call to the operation ejecutarCambioNumFrecuente completes with success
     * and returns some data
     * @eventType EjecutarCambioNumFrecuenteResultEvent
     */
    [Event(name="EjecutarCambioNumFrecuente_result", type="generated.webservices.orquestador.EjecutarCambioNumFrecuenteResultEvent")]
    
    /**
     * Dispatches when a call to the operation obtenerReportePresEquiInt completes with success
     * and returns some data
     * @eventType ObtenerReportePresEquiIntResultEvent
     */
    [Event(name="ObtenerReportePresEquiInt_result", type="generated.webservices.orquestador.ObtenerReportePresEquiIntResultEvent")]
    
    /**
     * Dispatches when a call to the operation crearUsuario completes with success
     * and returns some data
     * @eventType CrearUsuarioResultEvent
     */
    [Event(name="CrearUsuario_result", type="generated.webservices.orquestador.CrearUsuarioResultEvent")]
    
    /**
     * Dispatches when a call to the operation obtenerListDatosAbonados completes with success
     * and returns some data
     * @eventType ObtenerListDatosAbonadosResultEvent
     */
    [Event(name="ObtenerListDatosAbonados_result", type="generated.webservices.orquestador.ObtenerListDatosAbonadosResultEvent")]
    
    /**
     * Dispatches when a call to the operation getDetalleAbonado completes with success
     * and returns some data
     * @eventType GetDetalleAbonadoResultEvent
     */
    [Event(name="GetDetalleAbonado_result", type="generated.webservices.orquestador.GetDetalleAbonadoResultEvent")]
    
    /**
     * Dispatches when a call to the operation productosXCodCliente completes with success
     * and returns some data
     * @eventType ProductosXCodClienteResultEvent
     */
    [Event(name="ProductosXCodCliente_result", type="generated.webservices.orquestador.ProductosXCodClienteResultEvent")]
    
    /**
     * Dispatches when a call to the operation oossEjecutadasXCodCliente completes with success
     * and returns some data
     * @eventType OossEjecutadasXCodClienteResultEvent
     */
    [Event(name="OossEjecutadasXCodCliente_result", type="generated.webservices.orquestador.OossEjecutadasXCodClienteResultEvent")]
    
    /**
     * Dispatches when a call to the operation productosXNumAbonado completes with success
     * and returns some data
     * @eventType ProductosXNumAbonadoResultEvent
     */
    [Event(name="ProductosXNumAbonado_result", type="generated.webservices.orquestador.ProductosXNumAbonadoResultEvent")]
    
    /**
     * Dispatches when a call to the operation cargaValidaOSUsuario completes with success
     * and returns some data
     * @eventType CargaValidaOSUsuarioResultEvent
     */
    [Event(name="CargaValidaOSUsuario_result", type="generated.webservices.orquestador.CargaValidaOSUsuarioResultEvent")]
    
    /**
     * Dispatches when a call to the operation cargarCambioSIMCard completes with success
     * and returns some data
     * @eventType CargarCambioSIMCardResultEvent
     */
    [Event(name="CargarCambioSIMCard_result", type="generated.webservices.orquestador.CargarCambioSIMCardResultEvent")]
    
    /**
     * Dispatches when a call to the operation obtenerReporteCambioEquiGene completes with success
     * and returns some data
     * @eventType ObtenerReporteCambioEquiGeneResultEvent
     */
    [Event(name="ObtenerReporteCambioEquiGene_result", type="generated.webservices.orquestador.ObtenerReporteCambioEquiGeneResultEvent")]
    
    /**
     * Dispatches when a call to the operation obtenerDatosAbonado completes with success
     * and returns some data
     * @eventType ObtenerDatosAbonadoResultEvent
     */
    [Event(name="ObtenerDatosAbonado_result", type="generated.webservices.orquestador.ObtenerDatosAbonadoResultEvent")]
    
    /**
     * Dispatches when a call to the operation umtsAbonadosXCodCliente completes with success
     * and returns some data
     * @eventType UmtsAbonadosXCodClienteResultEvent
     */
    [Event(name="UmtsAbonadosXCodCliente_result", type="generated.webservices.orquestador.UmtsAbonadosXCodClienteResultEvent")]
    
    /**
     * Dispatches when a call to the operation cargarAjusteCExcepcionCargos completes with success
     * and returns some data
     * @eventType CargarAjusteCExcepcionCargosResultEvent
     */
    [Event(name="CargarAjusteCExcepcionCargos_result", type="generated.webservices.orquestador.CargarAjusteCExcepcionCargosResultEvent")]
    
    /**
     * Dispatches when a call to the operation obtenerDatosDireccionCliente completes with success
     * and returns some data
     * @eventType ObtenerDatosDireccionClienteResultEvent
     */
    [Event(name="ObtenerDatosDireccionCliente_result", type="generated.webservices.orquestador.ObtenerDatosDireccionClienteResultEvent")]
    
    /**
     * Dispatches when a call to the operation ejecutarAbonoLimiteConsumoSS completes with success
     * and returns some data
     * @eventType EjecutarAbonoLimiteConsumoSSResultEvent
     */
    [Event(name="EjecutarAbonoLimiteConsumoSS_result", type="generated.webservices.orquestador.EjecutarAbonoLimiteConsumoSSResultEvent")]
    
    /**
     * Dispatches when a call to the operation ejecucionCambioDatosCliente completes with success
     * and returns some data
     * @eventType EjecucionCambioDatosClienteResultEvent
     */
    [Event(name="EjecucionCambioDatosCliente_result", type="generated.webservices.orquestador.EjecucionCambioDatosClienteResultEvent")]
    
    /**
     * Dispatches when a call to the operation consultasXCodGrupo completes with success
     * and returns some data
     * @eventType ConsultasXCodGrupoResultEvent
     */
    [Event(name="ConsultasXCodGrupo_result", type="generated.webservices.orquestador.ConsultasXCodGrupoResultEvent")]
    
    /**
     * Dispatches when a call to the operation cargarSuspensionSrvCelular completes with success
     * and returns some data
     * @eventType CargarSuspensionSrvCelularResultEvent
     */
    [Event(name="CargarSuspensionSrvCelular_result", type="generated.webservices.orquestador.CargarSuspensionSrvCelularResultEvent")]
    
    /**
     * Dispatches when a call to the operation getDetalleCliente completes with success
     * and returns some data
     * @eventType GetDetalleClienteResultEvent
     */
    [Event(name="GetDetalleCliente_result", type="generated.webservices.orquestador.GetDetalleClienteResultEvent")]
    
    /**
     * Dispatches when a call to the operation getDetalleEquipo completes with success
     * and returns some data
     * @eventType GetDetalleEquipoResultEvent
     */
    [Event(name="GetDetalleEquipo_result", type="generated.webservices.orquestador.GetDetalleEquipoResultEvent")]
    
    /**
     * Dispatches when a call to the operation getDeudaCliente completes with success
     * and returns some data
     * @eventType GetDeudaClienteResultEvent
     */
    [Event(name="GetDeudaCliente_result", type="generated.webservices.orquestador.GetDeudaClienteResultEvent")]
    
    /**
     * Dispatches when a call to the operation consultaCuenta completes with success
     * and returns some data
     * @eventType ConsultaCuentaResultEvent
     */
    [Event(name="ConsultaCuenta_result", type="generated.webservices.orquestador.ConsultaCuentaResultEvent")]
    
    /**
     * Dispatches when a call to the operation solicitaUrlDominioPuerto completes with success
     * and returns some data
     * @eventType SolicitaUrlDominioPuertoResultEvent
     */
    [Event(name="SolicitaUrlDominioPuerto_result", type="generated.webservices.orquestador.SolicitaUrlDominioPuertoResultEvent")]
    
    /**
     * Dispatches when a call to the operation cargarAjusteCReversionCargos completes with success
     * and returns some data
     * @eventType CargarAjusteCReversionCargosResultEvent
     */
    [Event(name="CargarAjusteCReversionCargos_result", type="generated.webservices.orquestador.CargarAjusteCReversionCargosResultEvent")]
    
    /**
     * Dispatches when a call to the operation oossEjecutadasXNumAbonado completes with success
     * and returns some data
     * @eventType OossEjecutadasXNumAbonadoResultEvent
     */
    [Event(name="OossEjecutadasXNumAbonado_result", type="generated.webservices.orquestador.OossEjecutadasXNumAbonadoResultEvent")]
    
    /**
     * Dispatches when a call to the operation ssXDefectoXNumAbonado completes with success
     * and returns some data
     * @eventType SsXDefectoXNumAbonadoResultEvent
     */
    [Event(name="SsXDefectoXNumAbonado_result", type="generated.webservices.orquestador.SsXDefectoXNumAbonadoResultEvent")]
    
    /**
     * Dispatches when a call to the operation ejecutarCambioEquipoGSM completes with success
     * and returns some data
     * @eventType EjecutarCambioEquipoGSMResultEvent
     */
    [Event(name="EjecutarCambioEquipoGSM_result", type="generated.webservices.orquestador.EjecutarCambioEquipoGSMResultEvent")]
    
    /**
     * Dispatches when a call to the operation getDocsPagosCliente completes with success
     * and returns some data
     * @eventType GetDocsPagosClienteResultEvent
     */
    [Event(name="GetDocsPagosCliente_result", type="generated.webservices.orquestador.GetDocsPagosClienteResultEvent")]
    
    /**
     * Dispatches when a call to the operation getDocsCtaCteCliente completes with success
     * and returns some data
     * @eventType GetDocsCtaCteClienteResultEvent
     */
    [Event(name="GetDocsCtaCteCliente_result", type="generated.webservices.orquestador.GetDocsCtaCteClienteResultEvent")]
    
    /**
     * Dispatches when a call to the operation cambiarDireccionCliente completes with success
     * and returns some data
     * @eventType CambiarDireccionClienteResultEvent
     */
    [Event(name="CambiarDireccionCliente_result", type="generated.webservices.orquestador.CambiarDireccionClienteResultEvent")]
    
    /**
     * Dispatches when a call to the operation ssXDefectoXCodCliente completes with success
     * and returns some data
     * @eventType SsXDefectoXCodClienteResultEvent
     */
    [Event(name="SsXDefectoXCodCliente_result", type="generated.webservices.orquestador.SsXDefectoXCodClienteResultEvent")]
    
    /**
     * Dispatches when a call to the operation servSuplXOOSS completes with success
     * and returns some data
     * @eventType ServSuplXOOSSResultEvent
     */
    [Event(name="ServSuplXOOSS_result", type="generated.webservices.orquestador.ServSuplXOOSSResultEvent")]
    
    /**
     * Dispatches when a call to the operation limiteConsumoXClienteAbonado completes with success
     * and returns some data
     * @eventType LimiteConsumoXClienteAbonadoResultEvent
     */
    [Event(name="LimiteConsumoXClienteAbonado_result", type="generated.webservices.orquestador.LimiteConsumoXClienteAbonadoResultEvent")]
    
    /**
     * Dispatches when a call to the operation cargaOSGenericaAbonado completes with success
     * and returns some data
     * @eventType CargaOSGenericaAbonadoResultEvent
     */
    [Event(name="CargaOSGenericaAbonado_result", type="generated.webservices.orquestador.CargaOSGenericaAbonadoResultEvent")]
    
    /**
     * Dispatches when a call to the operation obtenerParametroKiosco completes with success
     * and returns some data
     * @eventType ObtenerParametroKioscoResultEvent
     */
    [Event(name="ObtenerParametroKiosco_result", type="generated.webservices.orquestador.ObtenerParametroKioscoResultEvent")]
    
    /**
     * Dispatches when a call to the operation cuentasXCodigo completes with success
     * and returns some data
     * @eventType CuentasXCodigoResultEvent
     */
    [Event(name="CuentasXCodigo_result", type="generated.webservices.orquestador.CuentasXCodigoResultEvent")]
    
    /**
     * Dispatches when a call to the operation clientesXNombre completes with success
     * and returns some data
     * @eventType ClientesXNombreResultEvent
     */
    [Event(name="ClientesXNombre_result", type="generated.webservices.orquestador.ClientesXNombreResultEvent")]
    
    /**
     * Dispatches when a call to the operation cambiosPlanAbonadoPrepago completes with success
     * and returns some data
     * @eventType CambiosPlanAbonadoPrepagoResultEvent
     */
    [Event(name="CambiosPlanAbonadoPrepago_result", type="generated.webservices.orquestador.CambiosPlanAbonadoPrepagoResultEvent")]
    
    /**
     * Dispatches when a call to the operation getDetalleDireccion completes with success
     * and returns some data
     * @eventType GetDetalleDireccionResultEvent
     */
    [Event(name="GetDetalleDireccion_result", type="generated.webservices.orquestador.GetDetalleDireccionResultEvent")]
    
    /**
     * Dispatches when a call to the operation ejecutarAbonoLimiteConsumo completes with success
     * and returns some data
     * @eventType EjecutarAbonoLimiteConsumoResultEvent
     */
    [Event(name="EjecutarAbonoLimiteConsumo_result", type="generated.webservices.orquestador.EjecutarAbonoLimiteConsumoResultEvent")]
    
    /**
     * Dispatches when a call to the operation clientesXCuenta completes with success
     * and returns some data
     * @eventType ClientesXCuentaResultEvent
     */
    [Event(name="ClientesXCuenta_result", type="generated.webservices.orquestador.ClientesXCuentaResultEvent")]
    
    /**
     * Dispatches when a call to the operation ejecutarAnulacionSiniestro completes with success
     * and returns some data
     * @eventType EjecutarAnulacionSiniestroResultEvent
     */
    [Event(name="EjecutarAnulacionSiniestro_result", type="generated.webservices.orquestador.EjecutarAnulacionSiniestroResultEvent")]
    
    /**
     * Dispatches when a call to the operation ejecutarAjusteCReversionCargos completes with success
     * and returns some data
     * @eventType EjecutarAjusteCReversionCargosResultEvent
     */
    [Event(name="EjecutarAjusteCReversionCargos_result", type="generated.webservices.orquestador.EjecutarAjusteCReversionCargosResultEvent")]
    
    /**
     * Dispatches when a call to the operation numerosFrecuentesXPlan completes with success
     * and returns some data
     * @eventType NumerosFrecuentesXPlanResultEvent
     */
    [Event(name="NumerosFrecuentesXPlan_result", type="generated.webservices.orquestador.NumerosFrecuentesXPlanResultEvent")]
    
    /**
     * Dispatches when a call to the operation obtenerOoSsAgendadas completes with success
     * and returns some data
     * @eventType ObtenerOoSsAgendadasResultEvent
     */
    [Event(name="ObtenerOoSsAgendadas_result", type="generated.webservices.orquestador.ObtenerOoSsAgendadasResultEvent")]
    
    /**
     * Dispatches when a call to the operation ccXCodCliente completes with success
     * and returns some data
     * @eventType CcXCodClienteResultEvent
     */
    [Event(name="CcXCodCliente_result", type="generated.webservices.orquestador.CcXCodClienteResultEvent")]
    
    /**
     * Dispatches when a call to the operation abonadosXCliente completes with success
     * and returns some data
     * @eventType AbonadosXClienteResultEvent
     */
    [Event(name="AbonadosXCliente_result", type="generated.webservices.orquestador.AbonadosXClienteResultEvent")]
    
    /**
     * Dispatches when a call to the operation insertComentario completes with success
     * and returns some data
     * @eventType InsertComentarioResultEvent
     */
    [Event(name="InsertComentario_result", type="generated.webservices.orquestador.InsertComentarioResultEvent")]
    
	/**
	 * Dispatches when the operation that has been called fails. The fault event is common for all operations
	 * of the WSDL
	 * @eventType mx.rpc.events.FaultEvent
	 */
    [Event(name="fault", type="mx.rpc.events.FaultEvent")]

	public class WSSEGPortal extends EventDispatcher implements IWSSEGPortal
	{
    	private var _baseService:BaseWSSEGPortal;

		
		// --- HGG 09/12/08
   		public function setearCredenciales(user:String, pass:String):void	{
        	_baseService.setUsuario(user);
        	_baseService.setPassword(pass);
        }
		
		// --- HGG 12/01/09
   		public function setearEndpoint(endpoint:String):void	{
        	_baseService.endpointURI = endpoint;
        }
        
        /**
         * Constructor for the facade; sets the destination and create a baseService instance
         * @param The LCDS destination (if any) associated with the imported WSDL
         */  
        public function WSSEGPortal(destination:String=null,rootURL:String=null)
        {
        	_baseService = new BaseWSSEGPortal(destination,rootURL);
        }
        
		//stub functions for the cargarReposicionSrvCelular operation
          

        /**
         * @see IWSSEGPortal#cargarReposicionSrvCelular()
         */
        public function cargarReposicionSrvCelular(numAbonado:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.cargarReposicionSrvCelular(numAbonado,nomUsuarioSCL,codEvento);
            _internal_token.addEventListener("result",_cargarReposicionSrvCelular_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#cargarReposicionSrvCelular_send()
		 */    
        public function cargarReposicionSrvCelular_send():AsyncToken
        {
        	return cargarReposicionSrvCelular(_cargarReposicionSrvCelular_request.numAbonado,_cargarReposicionSrvCelular_request.nomUsuarioSCL,_cargarReposicionSrvCelular_request.codEvento);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _cargarReposicionSrvCelular_request:CargarReposicionSrvCelular_request;
		/**
		 * @see IWSSEGPortal#cargarReposicionSrvCelular_request_var
		 */
		[Bindable]
		public function get cargarReposicionSrvCelular_request_var():CargarReposicionSrvCelular_request
		{
			return _cargarReposicionSrvCelular_request;
		}
		
		/**
		 * @private
		 */
		public function set cargarReposicionSrvCelular_request_var(request:CargarReposicionSrvCelular_request):void
		{
			_cargarReposicionSrvCelular_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _cargarReposicionSrvCelular_lastResult:CargaReposicionSrvCelDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#cargarReposicionSrvCelular_lastResult
		 */	  
		public function get cargarReposicionSrvCelular_lastResult():CargaReposicionSrvCelDTO
		{
			return _cargarReposicionSrvCelular_lastResult;
		}
		/**
		 * @private
		 */
		public function set cargarReposicionSrvCelular_lastResult(lastResult:CargaReposicionSrvCelDTO):void
		{
			_cargarReposicionSrvCelular_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addcargarReposicionSrvCelular()
		 */
		public function addcargarReposicionSrvCelularEventListener(listener:Function):void
		{
			addEventListener(CargarReposicionSrvCelularResultEvent.CargarReposicionSrvCelular_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _cargarReposicionSrvCelular_populate_results(event:ResultEvent):void
		{
			var e:CargarReposicionSrvCelularResultEvent = new CargarReposicionSrvCelularResultEvent();
		            e.result = event.result as CargaReposicionSrvCelDTO;
		                       e.headers = event.headers;
		             cargarReposicionSrvCelular_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the cuentasXNombre operation
          

        /**
         * @see IWSSEGPortal#cuentasXNombre()
         */
        public function cuentasXNombre(descCuenta:String):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.cuentasXNombre(descCuenta);
            _internal_token.addEventListener("result",_cuentasXNombre_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#cuentasXNombre_send()
		 */    
        public function cuentasXNombre_send():AsyncToken
        {
        	return cuentasXNombre(_cuentasXNombre_request.descCuenta);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _cuentasXNombre_request:CuentasXNombre_request;
		/**
		 * @see IWSSEGPortal#cuentasXNombre_request_var
		 */
		[Bindable]
		public function get cuentasXNombre_request_var():CuentasXNombre_request
		{
			return _cuentasXNombre_request;
		}
		
		/**
		 * @private
		 */
		public function set cuentasXNombre_request_var(request:CuentasXNombre_request):void
		{
			_cuentasXNombre_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _cuentasXNombre_lastResult:ListadoCuentasDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#cuentasXNombre_lastResult
		 */	  
		public function get cuentasXNombre_lastResult():ListadoCuentasDTO
		{
			return _cuentasXNombre_lastResult;
		}
		/**
		 * @private
		 */
		public function set cuentasXNombre_lastResult(lastResult:ListadoCuentasDTO):void
		{
			_cuentasXNombre_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addcuentasXNombre()
		 */
		public function addcuentasXNombreEventListener(listener:Function):void
		{
			addEventListener(CuentasXNombreResultEvent.CuentasXNombre_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _cuentasXNombre_populate_results(event:ResultEvent):void
		{
			var e:CuentasXNombreResultEvent = new CuentasXNombreResultEvent();
		            e.result = event.result as ListadoCuentasDTO;
		                       e.headers = event.headers;
		             cuentasXNombre_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the getDocsFactCliente operation
          

        /**
         * @see IWSSEGPortal#getDocsFactCliente()
         */
        public function getDocsFactCliente(obj:GetDocsClienteINDTO):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.getDocsFactCliente(obj);
            _internal_token.addEventListener("result",_getDocsFactCliente_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#getDocsFactCliente_send()
		 */    
        public function getDocsFactCliente_send():AsyncToken
        {
        	return getDocsFactCliente(_getDocsFactCliente_request.obj);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _getDocsFactCliente_request:GetDocsFactCliente_request;
		/**
		 * @see IWSSEGPortal#getDocsFactCliente_request_var
		 */
		[Bindable]
		public function get getDocsFactCliente_request_var():GetDocsFactCliente_request
		{
			return _getDocsFactCliente_request;
		}
		
		/**
		 * @private
		 */
		public function set getDocsFactCliente_request_var(request:GetDocsFactCliente_request):void
		{
			_getDocsFactCliente_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _getDocsFactCliente_lastResult:ListadoDocCtaCteClienteDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#getDocsFactCliente_lastResult
		 */	  
		public function get getDocsFactCliente_lastResult():ListadoDocCtaCteClienteDTO
		{
			return _getDocsFactCliente_lastResult;
		}
		/**
		 * @private
		 */
		public function set getDocsFactCliente_lastResult(lastResult:ListadoDocCtaCteClienteDTO):void
		{
			_getDocsFactCliente_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addgetDocsFactCliente()
		 */
		public function addgetDocsFactClienteEventListener(listener:Function):void
		{
			addEventListener(GetDocsFactClienteResultEvent.GetDocsFactCliente_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _getDocsFactCliente_populate_results(event:ResultEvent):void
		{
			var e:GetDocsFactClienteResultEvent = new GetDocsFactClienteResultEvent();
		            e.result = event.result as ListadoDocCtaCteClienteDTO;
		                       e.headers = event.headers;
		             getDocsFactCliente_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the abonadosXCelular operation
          

        /**
         * @see IWSSEGPortal#abonadosXCelular()
         */
        public function abonadosXCelular(numCelular:Number):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.abonadosXCelular(numCelular);
            _internal_token.addEventListener("result",_abonadosXCelular_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#abonadosXCelular_send()
		 */    
        public function abonadosXCelular_send():AsyncToken
        {
        	return abonadosXCelular(_abonadosXCelular_request.numCelular);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _abonadosXCelular_request:AbonadosXCelular_request;
		/**
		 * @see IWSSEGPortal#abonadosXCelular_request_var
		 */
		[Bindable]
		public function get abonadosXCelular_request_var():AbonadosXCelular_request
		{
			return _abonadosXCelular_request;
		}
		
		/**
		 * @private
		 */
		public function set abonadosXCelular_request_var(request:AbonadosXCelular_request):void
		{
			_abonadosXCelular_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _abonadosXCelular_lastResult:ListadoAbonadosDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#abonadosXCelular_lastResult
		 */	  
		public function get abonadosXCelular_lastResult():ListadoAbonadosDTO
		{
			return _abonadosXCelular_lastResult;
		}
		/**
		 * @private
		 */
		public function set abonadosXCelular_lastResult(lastResult:ListadoAbonadosDTO):void
		{
			_abonadosXCelular_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addabonadosXCelular()
		 */
		public function addabonadosXCelularEventListener(listener:Function):void
		{
			addEventListener(AbonadosXCelularResultEvent.AbonadosXCelular_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _abonadosXCelular_populate_results(event:ResultEvent):void
		{
			var e:AbonadosXCelularResultEvent = new AbonadosXCelularResultEvent();
		            e.result = event.result as ListadoAbonadosDTO;
		                       e.headers = event.headers;
		             abonadosXCelular_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the ejecutarCambioPlanPostPagoIndividual operation
          

        /**
         * @see IWSSEGPortal#ejecutarCambioPlanPostPagoIndividual()
         */
        public function ejecutarCambioPlanPostPagoIndividual(entrada:EjecucionCambioPlanPostPagoIndividualDTO):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.ejecutarCambioPlanPostPagoIndividual(entrada);
            _internal_token.addEventListener("result",_ejecutarCambioPlanPostPagoIndividual_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#ejecutarCambioPlanPostPagoIndividual_send()
		 */    
        public function ejecutarCambioPlanPostPagoIndividual_send():AsyncToken
        {
        	return ejecutarCambioPlanPostPagoIndividual(_ejecutarCambioPlanPostPagoIndividual_request.entrada);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _ejecutarCambioPlanPostPagoIndividual_request:EjecutarCambioPlanPostPagoIndividual_request;
		/**
		 * @see IWSSEGPortal#ejecutarCambioPlanPostPagoIndividual_request_var
		 */
		[Bindable]
		public function get ejecutarCambioPlanPostPagoIndividual_request_var():EjecutarCambioPlanPostPagoIndividual_request
		{
			return _ejecutarCambioPlanPostPagoIndividual_request;
		}
		
		/**
		 * @private
		 */
		public function set ejecutarCambioPlanPostPagoIndividual_request_var(request:EjecutarCambioPlanPostPagoIndividual_request):void
		{
			_ejecutarCambioPlanPostPagoIndividual_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _ejecutarCambioPlanPostPagoIndividual_lastResult:EjecucionCambioPlanPostPagoIndividualDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#ejecutarCambioPlanPostPagoIndividual_lastResult
		 */	  
		public function get ejecutarCambioPlanPostPagoIndividual_lastResult():EjecucionCambioPlanPostPagoIndividualDTO
		{
			return _ejecutarCambioPlanPostPagoIndividual_lastResult;
		}
		/**
		 * @private
		 */
		public function set ejecutarCambioPlanPostPagoIndividual_lastResult(lastResult:EjecucionCambioPlanPostPagoIndividualDTO):void
		{
			_ejecutarCambioPlanPostPagoIndividual_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addejecutarCambioPlanPostPagoIndividual()
		 */
		public function addejecutarCambioPlanPostPagoIndividualEventListener(listener:Function):void
		{
			addEventListener(EjecutarCambioPlanPostPagoIndividualResultEvent.EjecutarCambioPlanPostPagoIndividual_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _ejecutarCambioPlanPostPagoIndividual_populate_results(event:ResultEvent):void
		{
			var e:EjecutarCambioPlanPostPagoIndividualResultEvent = new EjecutarCambioPlanPostPagoIndividualResultEvent();
		            e.result = event.result as EjecucionCambioPlanPostPagoIndividualDTO;
		                       e.headers = event.headers;
		             ejecutarCambioPlanPostPagoIndividual_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the obtenerCamposDireccion operation
          

        /**
         * @see IWSSEGPortal#obtenerCamposDireccion()
         */
        public function obtenerCamposDireccion():AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.obtenerCamposDireccion();
            _internal_token.addEventListener("result",_obtenerCamposDireccion_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#obtenerCamposDireccion_send()
		 */    
        public function obtenerCamposDireccion_send():AsyncToken
        {
        	return obtenerCamposDireccion();
        }
              
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _obtenerCamposDireccion_lastResult:ListadoCamposDireccionDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#obtenerCamposDireccion_lastResult
		 */	  
		public function get obtenerCamposDireccion_lastResult():ListadoCamposDireccionDTO
		{
			return _obtenerCamposDireccion_lastResult;
		}
		/**
		 * @private
		 */
		public function set obtenerCamposDireccion_lastResult(lastResult:ListadoCamposDireccionDTO):void
		{
			_obtenerCamposDireccion_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addobtenerCamposDireccion()
		 */
		public function addobtenerCamposDireccionEventListener(listener:Function):void
		{
			addEventListener(ObtenerCamposDireccionResultEvent.ObtenerCamposDireccion_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _obtenerCamposDireccion_populate_results(event:ResultEvent):void
		{
			var e:ObtenerCamposDireccionResultEvent = new ObtenerCamposDireccionResultEvent();
		            e.result = event.result as ListadoCamposDireccionDTO;
		                       e.headers = event.headers;
		             obtenerCamposDireccion_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the cargaCambioDatosCliente operation
          

        /**
         * @see IWSSEGPortal#cargaCambioDatosCliente()
         */
        public function cargaCambioDatosCliente(codCliente:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.cargaCambioDatosCliente(codCliente,nomUsuarioSCL,codEvento);
            _internal_token.addEventListener("result",_cargaCambioDatosCliente_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#cargaCambioDatosCliente_send()
		 */    
        public function cargaCambioDatosCliente_send():AsyncToken
        {
        	return cargaCambioDatosCliente(_cargaCambioDatosCliente_request.codCliente,_cargaCambioDatosCliente_request.nomUsuarioSCL,_cargaCambioDatosCliente_request.codEvento);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _cargaCambioDatosCliente_request:CargaCambioDatosCliente_request;
		/**
		 * @see IWSSEGPortal#cargaCambioDatosCliente_request_var
		 */
		[Bindable]
		public function get cargaCambioDatosCliente_request_var():CargaCambioDatosCliente_request
		{
			return _cargaCambioDatosCliente_request;
		}
		
		/**
		 * @private
		 */
		public function set cargaCambioDatosCliente_request_var(request:CargaCambioDatosCliente_request):void
		{
			_cargaCambioDatosCliente_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _cargaCambioDatosCliente_lastResult:CargaCambioDatosClienteSACDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#cargaCambioDatosCliente_lastResult
		 */	  
		public function get cargaCambioDatosCliente_lastResult():CargaCambioDatosClienteSACDTO
		{
			return _cargaCambioDatosCliente_lastResult;
		}
		/**
		 * @private
		 */
		public function set cargaCambioDatosCliente_lastResult(lastResult:CargaCambioDatosClienteSACDTO):void
		{
			_cargaCambioDatosCliente_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addcargaCambioDatosCliente()
		 */
		public function addcargaCambioDatosClienteEventListener(listener:Function):void
		{
			addEventListener(CargaCambioDatosClienteResultEvent.CargaCambioDatosCliente_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _cargaCambioDatosCliente_populate_results(event:ResultEvent):void
		{
			var e:CargaCambioDatosClienteResultEvent = new CargaCambioDatosClienteResultEvent();
		            e.result = event.result as CargaCambioDatosClienteSACDTO;
		                       e.headers = event.headers;
		             cargaCambioDatosCliente_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the cargarAbonoLimiteConsumo operation
          

        /**
         * @see IWSSEGPortal#cargarAbonoLimiteConsumo()
         */
        public function cargarAbonoLimiteConsumo(codSujeto:Number,tipoAbono:String,nomUsuarioSCL:String,codEvento:String):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.cargarAbonoLimiteConsumo(codSujeto,tipoAbono,nomUsuarioSCL,codEvento);
            _internal_token.addEventListener("result",_cargarAbonoLimiteConsumo_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#cargarAbonoLimiteConsumo_send()
		 */    
        public function cargarAbonoLimiteConsumo_send():AsyncToken
        {
        	return cargarAbonoLimiteConsumo(_cargarAbonoLimiteConsumo_request.codSujeto,_cargarAbonoLimiteConsumo_request.tipoAbono,_cargarAbonoLimiteConsumo_request.nomUsuarioSCL,_cargarAbonoLimiteConsumo_request.codEvento);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _cargarAbonoLimiteConsumo_request:CargarAbonoLimiteConsumo_request;
		/**
		 * @see IWSSEGPortal#cargarAbonoLimiteConsumo_request_var
		 */
		[Bindable]
		public function get cargarAbonoLimiteConsumo_request_var():CargarAbonoLimiteConsumo_request
		{
			return _cargarAbonoLimiteConsumo_request;
		}
		
		/**
		 * @private
		 */
		public function set cargarAbonoLimiteConsumo_request_var(request:CargarAbonoLimiteConsumo_request):void
		{
			_cargarAbonoLimiteConsumo_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _cargarAbonoLimiteConsumo_lastResult:CargaAbonoLimConDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#cargarAbonoLimiteConsumo_lastResult
		 */	  
		public function get cargarAbonoLimiteConsumo_lastResult():CargaAbonoLimConDTO
		{
			return _cargarAbonoLimiteConsumo_lastResult;
		}
		/**
		 * @private
		 */
		public function set cargarAbonoLimiteConsumo_lastResult(lastResult:CargaAbonoLimConDTO):void
		{
			_cargarAbonoLimiteConsumo_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addcargarAbonoLimiteConsumo()
		 */
		public function addcargarAbonoLimiteConsumoEventListener(listener:Function):void
		{
			addEventListener(CargarAbonoLimiteConsumoResultEvent.CargarAbonoLimiteConsumo_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _cargarAbonoLimiteConsumo_populate_results(event:ResultEvent):void
		{
			var e:CargarAbonoLimiteConsumoResultEvent = new CargarAbonoLimiteConsumoResultEvent();
		            e.result = event.result as CargaAbonoLimConDTO;
		                       e.headers = event.headers;
		             cargarAbonoLimiteConsumo_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the ejecutarReposicionSrvCelular operation
          

        /**
         * @see IWSSEGPortal#ejecutarReposicionSrvCelular()
         */
        public function ejecutarReposicionSrvCelular(entrada:EjecucionReposicionSrvCelDTO):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.ejecutarReposicionSrvCelular(entrada);
            _internal_token.addEventListener("result",_ejecutarReposicionSrvCelular_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#ejecutarReposicionSrvCelular_send()
		 */    
        public function ejecutarReposicionSrvCelular_send():AsyncToken
        {
        	return ejecutarReposicionSrvCelular(_ejecutarReposicionSrvCelular_request.entrada);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _ejecutarReposicionSrvCelular_request:EjecutarReposicionSrvCelular_request;
		/**
		 * @see IWSSEGPortal#ejecutarReposicionSrvCelular_request_var
		 */
		[Bindable]
		public function get ejecutarReposicionSrvCelular_request_var():EjecutarReposicionSrvCelular_request
		{
			return _ejecutarReposicionSrvCelular_request;
		}
		
		/**
		 * @private
		 */
		public function set ejecutarReposicionSrvCelular_request_var(request:EjecutarReposicionSrvCelular_request):void
		{
			_ejecutarReposicionSrvCelular_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _ejecutarReposicionSrvCelular_lastResult:EjecucionReposicionSrvCelDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#ejecutarReposicionSrvCelular_lastResult
		 */	  
		public function get ejecutarReposicionSrvCelular_lastResult():EjecucionReposicionSrvCelDTO
		{
			return _ejecutarReposicionSrvCelular_lastResult;
		}
		/**
		 * @private
		 */
		public function set ejecutarReposicionSrvCelular_lastResult(lastResult:EjecucionReposicionSrvCelDTO):void
		{
			_ejecutarReposicionSrvCelular_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addejecutarReposicionSrvCelular()
		 */
		public function addejecutarReposicionSrvCelularEventListener(listener:Function):void
		{
			addEventListener(EjecutarReposicionSrvCelularResultEvent.EjecutarReposicionSrvCelular_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _ejecutarReposicionSrvCelular_populate_results(event:ResultEvent):void
		{
			var e:EjecutarReposicionSrvCelularResultEvent = new EjecutarReposicionSrvCelularResultEvent();
		            e.result = event.result as EjecucionReposicionSrvCelDTO;
		                       e.headers = event.headers;
		             ejecutarReposicionSrvCelular_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the getDocsAjustesCliente operation
          

        /**
         * @see IWSSEGPortal#getDocsAjustesCliente()
         */
        public function getDocsAjustesCliente(obj:GetDocsClienteINDTO):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.getDocsAjustesCliente(obj);
            _internal_token.addEventListener("result",_getDocsAjustesCliente_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#getDocsAjustesCliente_send()
		 */    
        public function getDocsAjustesCliente_send():AsyncToken
        {
        	return getDocsAjustesCliente(_getDocsAjustesCliente_request.obj);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _getDocsAjustesCliente_request:GetDocsAjustesCliente_request;
		/**
		 * @see IWSSEGPortal#getDocsAjustesCliente_request_var
		 */
		[Bindable]
		public function get getDocsAjustesCliente_request_var():GetDocsAjustesCliente_request
		{
			return _getDocsAjustesCliente_request;
		}
		
		/**
		 * @private
		 */
		public function set getDocsAjustesCliente_request_var(request:GetDocsAjustesCliente_request):void
		{
			_getDocsAjustesCliente_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _getDocsAjustesCliente_lastResult:ListadoDocCtaCteClienteDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#getDocsAjustesCliente_lastResult
		 */	  
		public function get getDocsAjustesCliente_lastResult():ListadoDocCtaCteClienteDTO
		{
			return _getDocsAjustesCliente_lastResult;
		}
		/**
		 * @private
		 */
		public function set getDocsAjustesCliente_lastResult(lastResult:ListadoDocCtaCteClienteDTO):void
		{
			_getDocsAjustesCliente_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addgetDocsAjustesCliente()
		 */
		public function addgetDocsAjustesClienteEventListener(listener:Function):void
		{
			addEventListener(GetDocsAjustesClienteResultEvent.GetDocsAjustesCliente_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _getDocsAjustesCliente_populate_results(event:ResultEvent):void
		{
			var e:GetDocsAjustesClienteResultEvent = new GetDocsAjustesClienteResultEvent();
		            e.result = event.result as ListadoDocCtaCteClienteDTO;
		                       e.headers = event.headers;
		             getDocsAjustesCliente_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the cargarCambioPlanPostPagoIndividual operation
          

        /**
         * @see IWSSEGPortal#cargarCambioPlanPostPagoIndividual()
         */
        public function cargarCambioPlanPostPagoIndividual(numAbonado:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.cargarCambioPlanPostPagoIndividual(numAbonado,nomUsuarioSCL,codEvento);
            _internal_token.addEventListener("result",_cargarCambioPlanPostPagoIndividual_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#cargarCambioPlanPostPagoIndividual_send()
		 */    
        public function cargarCambioPlanPostPagoIndividual_send():AsyncToken
        {
        	return cargarCambioPlanPostPagoIndividual(_cargarCambioPlanPostPagoIndividual_request.numAbonado,_cargarCambioPlanPostPagoIndividual_request.nomUsuarioSCL,_cargarCambioPlanPostPagoIndividual_request.codEvento);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _cargarCambioPlanPostPagoIndividual_request:CargarCambioPlanPostPagoIndividual_request;
		/**
		 * @see IWSSEGPortal#cargarCambioPlanPostPagoIndividual_request_var
		 */
		[Bindable]
		public function get cargarCambioPlanPostPagoIndividual_request_var():CargarCambioPlanPostPagoIndividual_request
		{
			return _cargarCambioPlanPostPagoIndividual_request;
		}
		
		/**
		 * @private
		 */
		public function set cargarCambioPlanPostPagoIndividual_request_var(request:CargarCambioPlanPostPagoIndividual_request):void
		{
			_cargarCambioPlanPostPagoIndividual_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _cargarCambioPlanPostPagoIndividual_lastResult:CargaCambioPlanPostPagoIndividualDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#cargarCambioPlanPostPagoIndividual_lastResult
		 */	  
		public function get cargarCambioPlanPostPagoIndividual_lastResult():CargaCambioPlanPostPagoIndividualDTO
		{
			return _cargarCambioPlanPostPagoIndividual_lastResult;
		}
		/**
		 * @private
		 */
		public function set cargarCambioPlanPostPagoIndividual_lastResult(lastResult:CargaCambioPlanPostPagoIndividualDTO):void
		{
			_cargarCambioPlanPostPagoIndividual_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addcargarCambioPlanPostPagoIndividual()
		 */
		public function addcargarCambioPlanPostPagoIndividualEventListener(listener:Function):void
		{
			addEventListener(CargarCambioPlanPostPagoIndividualResultEvent.CargarCambioPlanPostPagoIndividual_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _cargarCambioPlanPostPagoIndividual_populate_results(event:ResultEvent):void
		{
			var e:CargarCambioPlanPostPagoIndividualResultEvent = new CargarCambioPlanPostPagoIndividualResultEvent();
		            e.result = event.result as CargaCambioPlanPostPagoIndividualDTO;
		                       e.headers = event.headers;
		             cargarCambioPlanPostPagoIndividual_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the obtenerReporteIngrStatusEqui operation
          

        /**
         * @see IWSSEGPortal#obtenerReporteIngrStatusEqui()
         */
        public function obtenerReporteIngrStatusEqui(fechaDesde:String,fechaHasta:String):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.obtenerReporteIngrStatusEqui(fechaDesde,fechaHasta);
            _internal_token.addEventListener("result",_obtenerReporteIngrStatusEqui_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#obtenerReporteIngrStatusEqui_send()
		 */    
        public function obtenerReporteIngrStatusEqui_send():AsyncToken
        {
        	return obtenerReporteIngrStatusEqui(_obtenerReporteIngrStatusEqui_request.fechaDesde,_obtenerReporteIngrStatusEqui_request.fechaHasta);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _obtenerReporteIngrStatusEqui_request:ObtenerReporteIngrStatusEqui_request;
		/**
		 * @see IWSSEGPortal#obtenerReporteIngrStatusEqui_request_var
		 */
		[Bindable]
		public function get obtenerReporteIngrStatusEqui_request_var():ObtenerReporteIngrStatusEqui_request
		{
			return _obtenerReporteIngrStatusEqui_request;
		}
		
		/**
		 * @private
		 */
		public function set obtenerReporteIngrStatusEqui_request_var(request:ObtenerReporteIngrStatusEqui_request):void
		{
			_obtenerReporteIngrStatusEqui_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _obtenerReporteIngrStatusEqui_lastResult:ListadoReporteIngrStatusEquiDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#obtenerReporteIngrStatusEqui_lastResult
		 */	  
		public function get obtenerReporteIngrStatusEqui_lastResult():ListadoReporteIngrStatusEquiDTO
		{
			return _obtenerReporteIngrStatusEqui_lastResult;
		}
		/**
		 * @private
		 */
		public function set obtenerReporteIngrStatusEqui_lastResult(lastResult:ListadoReporteIngrStatusEquiDTO):void
		{
			_obtenerReporteIngrStatusEqui_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addobtenerReporteIngrStatusEqui()
		 */
		public function addobtenerReporteIngrStatusEquiEventListener(listener:Function):void
		{
			addEventListener(ObtenerReporteIngrStatusEquiResultEvent.ObtenerReporteIngrStatusEqui_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _obtenerReporteIngrStatusEqui_populate_results(event:ResultEvent):void
		{
			var e:ObtenerReporteIngrStatusEquiResultEvent = new ObtenerReporteIngrStatusEquiResultEvent();
		            e.result = event.result as ListadoReporteIngrStatusEquiDTO;
		                       e.headers = event.headers;
		             obtenerReporteIngrStatusEqui_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the servSumplemetariosXAbonado operation
          

        /**
         * @see IWSSEGPortal#servSumplemetariosXAbonado()
         */
        public function servSumplemetariosXAbonado(numAbonado:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.servSumplemetariosXAbonado(numAbonado,nomUsuarioSCL,codEvento);
            _internal_token.addEventListener("result",_servSumplemetariosXAbonado_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#servSumplemetariosXAbonado_send()
		 */    
        public function servSumplemetariosXAbonado_send():AsyncToken
        {
        	return servSumplemetariosXAbonado(_servSumplemetariosXAbonado_request.numAbonado,_servSumplemetariosXAbonado_request.nomUsuarioSCL,_servSumplemetariosXAbonado_request.codEvento);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _servSumplemetariosXAbonado_request:ServSumplemetariosXAbonado_request;
		/**
		 * @see IWSSEGPortal#servSumplemetariosXAbonado_request_var
		 */
		[Bindable]
		public function get servSumplemetariosXAbonado_request_var():ServSumplemetariosXAbonado_request
		{
			return _servSumplemetariosXAbonado_request;
		}
		
		/**
		 * @private
		 */
		public function set servSumplemetariosXAbonado_request_var(request:ServSumplemetariosXAbonado_request):void
		{
			_servSumplemetariosXAbonado_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _servSumplemetariosXAbonado_lastResult:ListadoServSuplementariosDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#servSumplemetariosXAbonado_lastResult
		 */	  
		public function get servSumplemetariosXAbonado_lastResult():ListadoServSuplementariosDTO
		{
			return _servSumplemetariosXAbonado_lastResult;
		}
		/**
		 * @private
		 */
		public function set servSumplemetariosXAbonado_lastResult(lastResult:ListadoServSuplementariosDTO):void
		{
			_servSumplemetariosXAbonado_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addservSumplemetariosXAbonado()
		 */
		public function addservSumplemetariosXAbonadoEventListener(listener:Function):void
		{
			addEventListener(ServSumplemetariosXAbonadoResultEvent.ServSumplemetariosXAbonado_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _servSumplemetariosXAbonado_populate_results(event:ResultEvent):void
		{
			var e:ServSumplemetariosXAbonadoResultEvent = new ServSumplemetariosXAbonadoResultEvent();
		            e.result = event.result as ListadoServSuplementariosDTO;
		                       e.headers = event.headers;
		             servSumplemetariosXAbonado_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the filtrarDetDocAjusteCReversionCargos operation
          

        /**
         * @see IWSSEGPortal#filtrarDetDocAjusteCReversionCargos()
         */
        public function filtrarDetDocAjusteCReversionCargos(entrada:FiltroDetDocAjusteCCargosSACDTO):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.filtrarDetDocAjusteCReversionCargos(entrada);
            _internal_token.addEventListener("result",_filtrarDetDocAjusteCReversionCargos_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#filtrarDetDocAjusteCReversionCargos_send()
		 */    
        public function filtrarDetDocAjusteCReversionCargos_send():AsyncToken
        {
        	return filtrarDetDocAjusteCReversionCargos(_filtrarDetDocAjusteCReversionCargos_request.entrada);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _filtrarDetDocAjusteCReversionCargos_request:FiltrarDetDocAjusteCReversionCargos_request;
		/**
		 * @see IWSSEGPortal#filtrarDetDocAjusteCReversionCargos_request_var
		 */
		[Bindable]
		public function get filtrarDetDocAjusteCReversionCargos_request_var():FiltrarDetDocAjusteCReversionCargos_request
		{
			return _filtrarDetDocAjusteCReversionCargos_request;
		}
		
		/**
		 * @private
		 */
		public function set filtrarDetDocAjusteCReversionCargos_request_var(request:FiltrarDetDocAjusteCReversionCargos_request):void
		{
			_filtrarDetDocAjusteCReversionCargos_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _filtrarDetDocAjusteCReversionCargos_lastResult:FiltroDetDocAjusteCCargosSACDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#filtrarDetDocAjusteCReversionCargos_lastResult
		 */	  
		public function get filtrarDetDocAjusteCReversionCargos_lastResult():FiltroDetDocAjusteCCargosSACDTO
		{
			return _filtrarDetDocAjusteCReversionCargos_lastResult;
		}
		/**
		 * @private
		 */
		public function set filtrarDetDocAjusteCReversionCargos_lastResult(lastResult:FiltroDetDocAjusteCCargosSACDTO):void
		{
			_filtrarDetDocAjusteCReversionCargos_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addfiltrarDetDocAjusteCReversionCargos()
		 */
		public function addfiltrarDetDocAjusteCReversionCargosEventListener(listener:Function):void
		{
			addEventListener(FiltrarDetDocAjusteCReversionCargosResultEvent.FiltrarDetDocAjusteCReversionCargos_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _filtrarDetDocAjusteCReversionCargos_populate_results(event:ResultEvent):void
		{
			var e:FiltrarDetDocAjusteCReversionCargosResultEvent = new FiltrarDetDocAjusteCReversionCargosResultEvent();
		            e.result = event.result as FiltroDetDocAjusteCCargosSACDTO;
		                       e.headers = event.headers;
		             filtrarDetDocAjusteCReversionCargos_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the getDetalleCuenta operation
          

        /**
         * @see IWSSEGPortal#getDetalleCuenta()
         */
        public function getDetalleCuenta(codCuenta:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.getDetalleCuenta(codCuenta,nomUsuarioSCL,codEvento);
            _internal_token.addEventListener("result",_getDetalleCuenta_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#getDetalleCuenta_send()
		 */    
        public function getDetalleCuenta_send():AsyncToken
        {
        	return getDetalleCuenta(_getDetalleCuenta_request.codCuenta,_getDetalleCuenta_request.nomUsuarioSCL,_getDetalleCuenta_request.codEvento);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _getDetalleCuenta_request:GetDetalleCuenta_request;
		/**
		 * @see IWSSEGPortal#getDetalleCuenta_request_var
		 */
		[Bindable]
		public function get getDetalleCuenta_request_var():GetDetalleCuenta_request
		{
			return _getDetalleCuenta_request;
		}
		
		/**
		 * @private
		 */
		public function set getDetalleCuenta_request_var(request:GetDetalleCuenta_request):void
		{
			_getDetalleCuenta_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _getDetalleCuenta_lastResult:DetalleCuentaDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#getDetalleCuenta_lastResult
		 */	  
		public function get getDetalleCuenta_lastResult():DetalleCuentaDTO
		{
			return _getDetalleCuenta_lastResult;
		}
		/**
		 * @private
		 */
		public function set getDetalleCuenta_lastResult(lastResult:DetalleCuentaDTO):void
		{
			_getDetalleCuenta_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addgetDetalleCuenta()
		 */
		public function addgetDetalleCuentaEventListener(listener:Function):void
		{
			addEventListener(GetDetalleCuentaResultEvent.GetDetalleCuenta_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _getDetalleCuenta_populate_results(event:ResultEvent):void
		{
			var e:GetDetalleCuentaResultEvent = new GetDetalleCuentaResultEvent();
		            e.result = event.result as DetalleCuentaDTO;
		                       e.headers = event.headers;
		             getDetalleCuenta_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the filtrarDetDocAjusteCExcepcionCargos operation
          

        /**
         * @see IWSSEGPortal#filtrarDetDocAjusteCExcepcionCargos()
         */
        public function filtrarDetDocAjusteCExcepcionCargos(entrada:FiltroDetDocAjusteCCargosSACDTO):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.filtrarDetDocAjusteCExcepcionCargos(entrada);
            _internal_token.addEventListener("result",_filtrarDetDocAjusteCExcepcionCargos_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#filtrarDetDocAjusteCExcepcionCargos_send()
		 */    
        public function filtrarDetDocAjusteCExcepcionCargos_send():AsyncToken
        {
        	return filtrarDetDocAjusteCExcepcionCargos(_filtrarDetDocAjusteCExcepcionCargos_request.entrada);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _filtrarDetDocAjusteCExcepcionCargos_request:FiltrarDetDocAjusteCExcepcionCargos_request;
		/**
		 * @see IWSSEGPortal#filtrarDetDocAjusteCExcepcionCargos_request_var
		 */
		[Bindable]
		public function get filtrarDetDocAjusteCExcepcionCargos_request_var():FiltrarDetDocAjusteCExcepcionCargos_request
		{
			return _filtrarDetDocAjusteCExcepcionCargos_request;
		}
		
		/**
		 * @private
		 */
		public function set filtrarDetDocAjusteCExcepcionCargos_request_var(request:FiltrarDetDocAjusteCExcepcionCargos_request):void
		{
			_filtrarDetDocAjusteCExcepcionCargos_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _filtrarDetDocAjusteCExcepcionCargos_lastResult:FiltroDetDocAjusteCCargosSACDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#filtrarDetDocAjusteCExcepcionCargos_lastResult
		 */	  
		public function get filtrarDetDocAjusteCExcepcionCargos_lastResult():FiltroDetDocAjusteCCargosSACDTO
		{
			return _filtrarDetDocAjusteCExcepcionCargos_lastResult;
		}
		/**
		 * @private
		 */
		public function set filtrarDetDocAjusteCExcepcionCargos_lastResult(lastResult:FiltroDetDocAjusteCCargosSACDTO):void
		{
			_filtrarDetDocAjusteCExcepcionCargos_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addfiltrarDetDocAjusteCExcepcionCargos()
		 */
		public function addfiltrarDetDocAjusteCExcepcionCargosEventListener(listener:Function):void
		{
			addEventListener(FiltrarDetDocAjusteCExcepcionCargosResultEvent.FiltrarDetDocAjusteCExcepcionCargos_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _filtrarDetDocAjusteCExcepcionCargos_populate_results(event:ResultEvent):void
		{
			var e:FiltrarDetDocAjusteCExcepcionCargosResultEvent = new FiltrarDetDocAjusteCExcepcionCargosResultEvent();
		            e.result = event.result as FiltroDetDocAjusteCCargosSACDTO;
		                       e.headers = event.headers;
		             filtrarDetDocAjusteCExcepcionCargos_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the detallePlanTarifario operation
          

        /**
         * @see IWSSEGPortal#detallePlanTarifario()
         */
        public function detallePlanTarifario(codPlanTarifario:String):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.detallePlanTarifario(codPlanTarifario);
            _internal_token.addEventListener("result",_detallePlanTarifario_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#detallePlanTarifario_send()
		 */    
        public function detallePlanTarifario_send():AsyncToken
        {
        	return detallePlanTarifario(_detallePlanTarifario_request.codPlanTarifario);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _detallePlanTarifario_request:DetallePlanTarifario_request;
		/**
		 * @see IWSSEGPortal#detallePlanTarifario_request_var
		 */
		[Bindable]
		public function get detallePlanTarifario_request_var():DetallePlanTarifario_request
		{
			return _detallePlanTarifario_request;
		}
		
		/**
		 * @private
		 */
		public function set detallePlanTarifario_request_var(request:DetallePlanTarifario_request):void
		{
			_detallePlanTarifario_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _detallePlanTarifario_lastResult:DetallePlanTarifarioDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#detallePlanTarifario_lastResult
		 */	  
		public function get detallePlanTarifario_lastResult():DetallePlanTarifarioDTO
		{
			return _detallePlanTarifario_lastResult;
		}
		/**
		 * @private
		 */
		public function set detallePlanTarifario_lastResult(lastResult:DetallePlanTarifarioDTO):void
		{
			_detallePlanTarifario_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#adddetallePlanTarifario()
		 */
		public function adddetallePlanTarifarioEventListener(listener:Function):void
		{
			addEventListener(DetallePlanTarifarioResultEvent.DetallePlanTarifario_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _detallePlanTarifario_populate_results(event:ResultEvent):void
		{
			var e:DetallePlanTarifarioResultEvent = new DetallePlanTarifarioResultEvent();
		            e.result = event.result as DetallePlanTarifarioDTO;
		                       e.headers = event.headers;
		             detallePlanTarifario_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the cargarCambioEquipoGSM operation
          

        /**
         * @see IWSSEGPortal#cargarCambioEquipoGSM()
         */
        public function cargarCambioEquipoGSM(numAbonado:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.cargarCambioEquipoGSM(numAbonado,nomUsuarioSCL,codEvento);
            _internal_token.addEventListener("result",_cargarCambioEquipoGSM_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#cargarCambioEquipoGSM_send()
		 */    
        public function cargarCambioEquipoGSM_send():AsyncToken
        {
        	return cargarCambioEquipoGSM(_cargarCambioEquipoGSM_request.numAbonado,_cargarCambioEquipoGSM_request.nomUsuarioSCL,_cargarCambioEquipoGSM_request.codEvento);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _cargarCambioEquipoGSM_request:CargarCambioEquipoGSM_request;
		/**
		 * @see IWSSEGPortal#cargarCambioEquipoGSM_request_var
		 */
		[Bindable]
		public function get cargarCambioEquipoGSM_request_var():CargarCambioEquipoGSM_request
		{
			return _cargarCambioEquipoGSM_request;
		}
		
		/**
		 * @private
		 */
		public function set cargarCambioEquipoGSM_request_var(request:CargarCambioEquipoGSM_request):void
		{
			_cargarCambioEquipoGSM_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _cargarCambioEquipoGSM_lastResult:CargaCambioEquipoGSMDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#cargarCambioEquipoGSM_lastResult
		 */	  
		public function get cargarCambioEquipoGSM_lastResult():CargaCambioEquipoGSMDTO
		{
			return _cargarCambioEquipoGSM_lastResult;
		}
		/**
		 * @private
		 */
		public function set cargarCambioEquipoGSM_lastResult(lastResult:CargaCambioEquipoGSMDTO):void
		{
			_cargarCambioEquipoGSM_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addcargarCambioEquipoGSM()
		 */
		public function addcargarCambioEquipoGSMEventListener(listener:Function):void
		{
			addEventListener(CargarCambioEquipoGSMResultEvent.CargarCambioEquipoGSM_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _cargarCambioEquipoGSM_populate_results(event:ResultEvent):void
		{
			var e:CargarCambioEquipoGSMResultEvent = new CargarCambioEquipoGSMResultEvent();
		            e.result = event.result as CargaCambioEquipoGSMDTO;
		                       e.headers = event.headers;
		             cargarCambioEquipoGSM_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the ejecucionServicioCargos operation
          

        /**
         * @see IWSSEGPortal#ejecucionServicioCargos()
         */
        public function ejecucionServicioCargos(entrada:EjecucionServicioCargosDTO):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.ejecucionServicioCargos(entrada);
            _internal_token.addEventListener("result",_ejecucionServicioCargos_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#ejecucionServicioCargos_send()
		 */    
        public function ejecucionServicioCargos_send():AsyncToken
        {
        	return ejecucionServicioCargos(_ejecucionServicioCargos_request.entrada);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _ejecucionServicioCargos_request:EjecucionServicioCargos_request;
		/**
		 * @see IWSSEGPortal#ejecucionServicioCargos_request_var
		 */
		[Bindable]
		public function get ejecucionServicioCargos_request_var():EjecucionServicioCargos_request
		{
			return _ejecucionServicioCargos_request;
		}
		
		/**
		 * @private
		 */
		public function set ejecucionServicioCargos_request_var(request:EjecucionServicioCargos_request):void
		{
			_ejecucionServicioCargos_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _ejecucionServicioCargos_lastResult:EjecucionServicioCargosDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#ejecucionServicioCargos_lastResult
		 */	  
		public function get ejecucionServicioCargos_lastResult():EjecucionServicioCargosDTO
		{
			return _ejecucionServicioCargos_lastResult;
		}
		/**
		 * @private
		 */
		public function set ejecucionServicioCargos_lastResult(lastResult:EjecucionServicioCargosDTO):void
		{
			_ejecucionServicioCargos_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addejecucionServicioCargos()
		 */
		public function addejecucionServicioCargosEventListener(listener:Function):void
		{
			addEventListener(EjecucionServicioCargosResultEvent.EjecucionServicioCargos_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _ejecucionServicioCargos_populate_results(event:ResultEvent):void
		{
			var e:EjecucionServicioCargosResultEvent = new EjecucionServicioCargosResultEvent();
		            e.result = event.result as EjecucionServicioCargosDTO;
		                       e.headers = event.headers;
		             ejecucionServicioCargos_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the gruposXNomUsuario operation
          

        /**
         * @see IWSSEGPortal#gruposXNomUsuario()
         */
        public function gruposXNomUsuario(nomUsuario:String):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.gruposXNomUsuario(nomUsuario);
            _internal_token.addEventListener("result",_gruposXNomUsuario_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#gruposXNomUsuario_send()
		 */    
        public function gruposXNomUsuario_send():AsyncToken
        {
        	return gruposXNomUsuario(_gruposXNomUsuario_request.nomUsuario);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _gruposXNomUsuario_request:GruposXNomUsuario_request;
		/**
		 * @see IWSSEGPortal#gruposXNomUsuario_request_var
		 */
		[Bindable]
		public function get gruposXNomUsuario_request_var():GruposXNomUsuario_request
		{
			return _gruposXNomUsuario_request;
		}
		
		/**
		 * @private
		 */
		public function set gruposXNomUsuario_request_var(request:GruposXNomUsuario_request):void
		{
			_gruposXNomUsuario_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _gruposXNomUsuario_lastResult:ListadoGruposDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#gruposXNomUsuario_lastResult
		 */	  
		public function get gruposXNomUsuario_lastResult():ListadoGruposDTO
		{
			return _gruposXNomUsuario_lastResult;
		}
		/**
		 * @private
		 */
		public function set gruposXNomUsuario_lastResult(lastResult:ListadoGruposDTO):void
		{
			_gruposXNomUsuario_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addgruposXNomUsuario()
		 */
		public function addgruposXNomUsuarioEventListener(listener:Function):void
		{
			addEventListener(GruposXNomUsuarioResultEvent.GruposXNomUsuario_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _gruposXNomUsuario_populate_results(event:ResultEvent):void
		{
			var e:GruposXNomUsuarioResultEvent = new GruposXNomUsuarioResultEvent();
		            e.result = event.result as ListadoGruposDTO;
		                       e.headers = event.headers;
		             gruposXNomUsuario_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the cargarAnulacionSiniestro operation
          

        /**
         * @see IWSSEGPortal#cargarAnulacionSiniestro()
         */
        public function cargarAnulacionSiniestro(numAbonado:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.cargarAnulacionSiniestro(numAbonado,nomUsuarioSCL,codEvento);
            _internal_token.addEventListener("result",_cargarAnulacionSiniestro_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#cargarAnulacionSiniestro_send()
		 */    
        public function cargarAnulacionSiniestro_send():AsyncToken
        {
        	return cargarAnulacionSiniestro(_cargarAnulacionSiniestro_request.numAbonado,_cargarAnulacionSiniestro_request.nomUsuarioSCL,_cargarAnulacionSiniestro_request.codEvento);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _cargarAnulacionSiniestro_request:CargarAnulacionSiniestro_request;
		/**
		 * @see IWSSEGPortal#cargarAnulacionSiniestro_request_var
		 */
		[Bindable]
		public function get cargarAnulacionSiniestro_request_var():CargarAnulacionSiniestro_request
		{
			return _cargarAnulacionSiniestro_request;
		}
		
		/**
		 * @private
		 */
		public function set cargarAnulacionSiniestro_request_var(request:CargarAnulacionSiniestro_request):void
		{
			_cargarAnulacionSiniestro_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _cargarAnulacionSiniestro_lastResult:CargaAnulacionSiniestroDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#cargarAnulacionSiniestro_lastResult
		 */	  
		public function get cargarAnulacionSiniestro_lastResult():CargaAnulacionSiniestroDTO
		{
			return _cargarAnulacionSiniestro_lastResult;
		}
		/**
		 * @private
		 */
		public function set cargarAnulacionSiniestro_lastResult(lastResult:CargaAnulacionSiniestroDTO):void
		{
			_cargarAnulacionSiniestro_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addcargarAnulacionSiniestro()
		 */
		public function addcargarAnulacionSiniestroEventListener(listener:Function):void
		{
			addEventListener(CargarAnulacionSiniestroResultEvent.CargarAnulacionSiniestro_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _cargarAnulacionSiniestro_populate_results(event:ResultEvent):void
		{
			var e:CargarAnulacionSiniestroResultEvent = new CargarAnulacionSiniestroResultEvent();
		            e.result = event.result as CargaAnulacionSiniestroDTO;
		                       e.headers = event.headers;
		             cargarAnulacionSiniestro_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the ejecutarCambioSIMCard operation
          

        /**
         * @see IWSSEGPortal#ejecutarCambioSIMCard()
         */
        public function ejecutarCambioSIMCard(entrada:EjecucionCambioSIMCardDTO):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.ejecutarCambioSIMCard(entrada);
            _internal_token.addEventListener("result",_ejecutarCambioSIMCard_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#ejecutarCambioSIMCard_send()
		 */    
        public function ejecutarCambioSIMCard_send():AsyncToken
        {
        	return ejecutarCambioSIMCard(_ejecutarCambioSIMCard_request.entrada);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _ejecutarCambioSIMCard_request:EjecutarCambioSIMCard_request;
		/**
		 * @see IWSSEGPortal#ejecutarCambioSIMCard_request_var
		 */
		[Bindable]
		public function get ejecutarCambioSIMCard_request_var():EjecutarCambioSIMCard_request
		{
			return _ejecutarCambioSIMCard_request;
		}
		
		/**
		 * @private
		 */
		public function set ejecutarCambioSIMCard_request_var(request:EjecutarCambioSIMCard_request):void
		{
			_ejecutarCambioSIMCard_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _ejecutarCambioSIMCard_lastResult:EjecucionCambioSIMCardDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#ejecutarCambioSIMCard_lastResult
		 */	  
		public function get ejecutarCambioSIMCard_lastResult():EjecucionCambioSIMCardDTO
		{
			return _ejecutarCambioSIMCard_lastResult;
		}
		/**
		 * @private
		 */
		public function set ejecutarCambioSIMCard_lastResult(lastResult:EjecucionCambioSIMCardDTO):void
		{
			_ejecutarCambioSIMCard_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addejecutarCambioSIMCard()
		 */
		public function addejecutarCambioSIMCardEventListener(listener:Function):void
		{
			addEventListener(EjecutarCambioSIMCardResultEvent.EjecutarCambioSIMCard_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _ejecutarCambioSIMCard_populate_results(event:ResultEvent):void
		{
			var e:EjecutarCambioSIMCardResultEvent = new EjecutarCambioSIMCardResultEvent();
		            e.result = event.result as EjecucionCambioSIMCardDTO;
		                       e.headers = event.headers;
		             ejecutarCambioSIMCard_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the detalleLlamadas operation
          

        /**
         * @see IWSSEGPortal#detalleLlamadas()
         */
        public function detalleLlamadas(codCliente:Number,numAbonado:Number,codCiclo:Number,tipoLlamada:String):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.detalleLlamadas(codCliente,numAbonado,codCiclo,tipoLlamada);
            _internal_token.addEventListener("result",_detalleLlamadas_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#detalleLlamadas_send()
		 */    
        public function detalleLlamadas_send():AsyncToken
        {
        	return detalleLlamadas(_detalleLlamadas_request.codCliente,_detalleLlamadas_request.numAbonado,_detalleLlamadas_request.codCiclo,_detalleLlamadas_request.tipoLlamada);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _detalleLlamadas_request:DetalleLlamadas_request;
		/**
		 * @see IWSSEGPortal#detalleLlamadas_request_var
		 */
		[Bindable]
		public function get detalleLlamadas_request_var():DetalleLlamadas_request
		{
			return _detalleLlamadas_request;
		}
		
		/**
		 * @private
		 */
		public function set detalleLlamadas_request_var(request:DetalleLlamadas_request):void
		{
			_detalleLlamadas_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _detalleLlamadas_lastResult:ListadoDetalleLlamadosDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#detalleLlamadas_lastResult
		 */	  
		public function get detalleLlamadas_lastResult():ListadoDetalleLlamadosDTO
		{
			return _detalleLlamadas_lastResult;
		}
		/**
		 * @private
		 */
		public function set detalleLlamadas_lastResult(lastResult:ListadoDetalleLlamadosDTO):void
		{
			_detalleLlamadas_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#adddetalleLlamadas()
		 */
		public function adddetalleLlamadasEventListener(listener:Function):void
		{
			addEventListener(DetalleLlamadasResultEvent.DetalleLlamadas_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _detalleLlamadas_populate_results(event:ResultEvent):void
		{
			var e:DetalleLlamadasResultEvent = new DetalleLlamadasResultEvent();
		            e.result = event.result as ListadoDetalleLlamadosDTO;
		                       e.headers = event.headers;
		             detalleLlamadas_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the esPrimerLogin operation
          

        /**
         * @see IWSSEGPortal#esPrimerLogin()
         */
        public function esPrimerLogin(nomUsuario:String):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.esPrimerLogin(nomUsuario);
            _internal_token.addEventListener("result",_esPrimerLogin_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#esPrimerLogin_send()
		 */    
        public function esPrimerLogin_send():AsyncToken
        {
        	return esPrimerLogin(_esPrimerLogin_request.nomUsuario);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _esPrimerLogin_request:EsPrimerLogin_request;
		/**
		 * @see IWSSEGPortal#esPrimerLogin_request_var
		 */
		[Bindable]
		public function get esPrimerLogin_request_var():EsPrimerLogin_request
		{
			return _esPrimerLogin_request;
		}
		
		/**
		 * @private
		 */
		public function set esPrimerLogin_request_var(request:EsPrimerLogin_request):void
		{
			_esPrimerLogin_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _esPrimerLogin_lastResult:Boolean;
		[Bindable]
		/**
		 * @see IWSSEGPortal#esPrimerLogin_lastResult
		 */	  
		public function get esPrimerLogin_lastResult():Boolean
		{
			return _esPrimerLogin_lastResult;
		}
		/**
		 * @private
		 */
		public function set esPrimerLogin_lastResult(lastResult:Boolean):void
		{
			_esPrimerLogin_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addesPrimerLogin()
		 */
		public function addesPrimerLoginEventListener(listener:Function):void
		{
			addEventListener(EsPrimerLoginResultEvent.EsPrimerLogin_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _esPrimerLogin_populate_results(event:ResultEvent):void
		{
			var e:EsPrimerLoginResultEvent = new EsPrimerLoginResultEvent();
		            e.result = event.result as Boolean;
		                       e.headers = event.headers;
		             esPrimerLogin_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the cargaNumFrecuentes operation
          

        /**
         * @see IWSSEGPortal#cargaNumFrecuentes()
         */
        public function cargaNumFrecuentes(numAbonado:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.cargaNumFrecuentes(numAbonado,nomUsuarioSCL,codEvento);
            _internal_token.addEventListener("result",_cargaNumFrecuentes_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#cargaNumFrecuentes_send()
		 */    
        public function cargaNumFrecuentes_send():AsyncToken
        {
        	return cargaNumFrecuentes(_cargaNumFrecuentes_request.numAbonado,_cargaNumFrecuentes_request.nomUsuarioSCL,_cargaNumFrecuentes_request.codEvento);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _cargaNumFrecuentes_request:CargaNumFrecuentes_request;
		/**
		 * @see IWSSEGPortal#cargaNumFrecuentes_request_var
		 */
		[Bindable]
		public function get cargaNumFrecuentes_request_var():CargaNumFrecuentes_request
		{
			return _cargaNumFrecuentes_request;
		}
		
		/**
		 * @private
		 */
		public function set cargaNumFrecuentes_request_var(request:CargaNumFrecuentes_request):void
		{
			_cargaNumFrecuentes_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _cargaNumFrecuentes_lastResult:CargaCambioNumFrecuentesSACDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#cargaNumFrecuentes_lastResult
		 */	  
		public function get cargaNumFrecuentes_lastResult():CargaCambioNumFrecuentesSACDTO
		{
			return _cargaNumFrecuentes_lastResult;
		}
		/**
		 * @private
		 */
		public function set cargaNumFrecuentes_lastResult(lastResult:CargaCambioNumFrecuentesSACDTO):void
		{
			_cargaNumFrecuentes_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addcargaNumFrecuentes()
		 */
		public function addcargaNumFrecuentesEventListener(listener:Function):void
		{
			addEventListener(CargaNumFrecuentesResultEvent.CargaNumFrecuentes_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _cargaNumFrecuentes_populate_results(event:ResultEvent):void
		{
			var e:CargaNumFrecuentesResultEvent = new CargaNumFrecuentesResultEvent();
		            e.result = event.result as CargaCambioNumFrecuentesSACDTO;
		                       e.headers = event.headers;
		             cargaNumFrecuentes_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the clientesXCodCliente operation
          

        /**
         * @see IWSSEGPortal#clientesXCodCliente()
         */
        public function clientesXCodCliente(codCliente:Number):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.clientesXCodCliente(codCliente);
            _internal_token.addEventListener("result",_clientesXCodCliente_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#clientesXCodCliente_send()
		 */    
        public function clientesXCodCliente_send():AsyncToken
        {
        	return clientesXCodCliente(_clientesXCodCliente_request.codCliente);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _clientesXCodCliente_request:ClientesXCodCliente_request;
		/**
		 * @see IWSSEGPortal#clientesXCodCliente_request_var
		 */
		[Bindable]
		public function get clientesXCodCliente_request_var():ClientesXCodCliente_request
		{
			return _clientesXCodCliente_request;
		}
		
		/**
		 * @private
		 */
		public function set clientesXCodCliente_request_var(request:ClientesXCodCliente_request):void
		{
			_clientesXCodCliente_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _clientesXCodCliente_lastResult:ListadoClientesDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#clientesXCodCliente_lastResult
		 */	  
		public function get clientesXCodCliente_lastResult():ListadoClientesDTO
		{
			return _clientesXCodCliente_lastResult;
		}
		/**
		 * @private
		 */
		public function set clientesXCodCliente_lastResult(lastResult:ListadoClientesDTO):void
		{
			_clientesXCodCliente_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addclientesXCodCliente()
		 */
		public function addclientesXCodClienteEventListener(listener:Function):void
		{
			addEventListener(ClientesXCodClienteResultEvent.ClientesXCodCliente_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _clientesXCodCliente_populate_results(event:ResultEvent):void
		{
			var e:ClientesXCodClienteResultEvent = new ClientesXCodClienteResultEvent();
		            e.result = event.result as ListadoClientesDTO;
		                       e.headers = event.headers;
		             clientesXCodCliente_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the obtenerOoSsProceso operation
          

        /**
         * @see IWSSEGPortal#obtenerOoSsProceso()
         */
        public function obtenerOoSsProceso(nomUsuario:String):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.obtenerOoSsProceso(nomUsuario);
            _internal_token.addEventListener("result",_obtenerOoSsProceso_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#obtenerOoSsProceso_send()
		 */    
        public function obtenerOoSsProceso_send():AsyncToken
        {
        	return obtenerOoSsProceso(_obtenerOoSsProceso_request.nomUsuario);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _obtenerOoSsProceso_request:ObtenerOoSsProceso_request;
		/**
		 * @see IWSSEGPortal#obtenerOoSsProceso_request_var
		 */
		[Bindable]
		public function get obtenerOoSsProceso_request_var():ObtenerOoSsProceso_request
		{
			return _obtenerOoSsProceso_request;
		}
		
		/**
		 * @private
		 */
		public function set obtenerOoSsProceso_request_var(request:ObtenerOoSsProceso_request):void
		{
			_obtenerOoSsProceso_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _obtenerOoSsProceso_lastResult:ListadoOrdenesProcesoDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#obtenerOoSsProceso_lastResult
		 */	  
		public function get obtenerOoSsProceso_lastResult():ListadoOrdenesProcesoDTO
		{
			return _obtenerOoSsProceso_lastResult;
		}
		/**
		 * @private
		 */
		public function set obtenerOoSsProceso_lastResult(lastResult:ListadoOrdenesProcesoDTO):void
		{
			_obtenerOoSsProceso_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addobtenerOoSsProceso()
		 */
		public function addobtenerOoSsProcesoEventListener(listener:Function):void
		{
			addEventListener(ObtenerOoSsProcesoResultEvent.ObtenerOoSsProceso_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _obtenerOoSsProceso_populate_results(event:ResultEvent):void
		{
			var e:ObtenerOoSsProcesoResultEvent = new ObtenerOoSsProcesoResultEvent();
		            e.result = event.result as ListadoOrdenesProcesoDTO;
		                       e.headers = event.headers;
		             obtenerOoSsProceso_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the ajustesXCodCliente operation
          

        /**
         * @see IWSSEGPortal#ajustesXCodCliente()
         */
        public function ajustesXCodCliente(codCliente:Number):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.ajustesXCodCliente(codCliente);
            _internal_token.addEventListener("result",_ajustesXCodCliente_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#ajustesXCodCliente_send()
		 */    
        public function ajustesXCodCliente_send():AsyncToken
        {
        	return ajustesXCodCliente(_ajustesXCodCliente_request.codCliente);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _ajustesXCodCliente_request:AjustesXCodCliente_request;
		/**
		 * @see IWSSEGPortal#ajustesXCodCliente_request_var
		 */
		[Bindable]
		public function get ajustesXCodCliente_request_var():AjustesXCodCliente_request
		{
			return _ajustesXCodCliente_request;
		}
		
		/**
		 * @private
		 */
		public function set ajustesXCodCliente_request_var(request:AjustesXCodCliente_request):void
		{
			_ajustesXCodCliente_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _ajustesXCodCliente_lastResult:ListadoAjustesDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#ajustesXCodCliente_lastResult
		 */	  
		public function get ajustesXCodCliente_lastResult():ListadoAjustesDTO
		{
			return _ajustesXCodCliente_lastResult;
		}
		/**
		 * @private
		 */
		public function set ajustesXCodCliente_lastResult(lastResult:ListadoAjustesDTO):void
		{
			_ajustesXCodCliente_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addajustesXCodCliente()
		 */
		public function addajustesXCodClienteEventListener(listener:Function):void
		{
			addEventListener(AjustesXCodClienteResultEvent.AjustesXCodCliente_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _ajustesXCodCliente_populate_results(event:ResultEvent):void
		{
			var e:AjustesXCodClienteResultEvent = new AjustesXCodClienteResultEvent();
		            e.result = event.result as ListadoAjustesDTO;
		                       e.headers = event.headers;
		             ajustesXCodCliente_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the cambiosPlanAbonadoPospago operation
          

        /**
         * @see IWSSEGPortal#cambiosPlanAbonadoPospago()
         */
        public function cambiosPlanAbonadoPospago(numOS:Number):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.cambiosPlanAbonadoPospago(numOS);
            _internal_token.addEventListener("result",_cambiosPlanAbonadoPospago_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#cambiosPlanAbonadoPospago_send()
		 */    
        public function cambiosPlanAbonadoPospago_send():AsyncToken
        {
        	return cambiosPlanAbonadoPospago(_cambiosPlanAbonadoPospago_request.numOS);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _cambiosPlanAbonadoPospago_request:CambiosPlanAbonadoPospago_request;
		/**
		 * @see IWSSEGPortal#cambiosPlanAbonadoPospago_request_var
		 */
		[Bindable]
		public function get cambiosPlanAbonadoPospago_request_var():CambiosPlanAbonadoPospago_request
		{
			return _cambiosPlanAbonadoPospago_request;
		}
		
		/**
		 * @private
		 */
		public function set cambiosPlanAbonadoPospago_request_var(request:CambiosPlanAbonadoPospago_request):void
		{
			_cambiosPlanAbonadoPospago_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _cambiosPlanAbonadoPospago_lastResult:ListadoCambiosPlanTarifDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#cambiosPlanAbonadoPospago_lastResult
		 */	  
		public function get cambiosPlanAbonadoPospago_lastResult():ListadoCambiosPlanTarifDTO
		{
			return _cambiosPlanAbonadoPospago_lastResult;
		}
		/**
		 * @private
		 */
		public function set cambiosPlanAbonadoPospago_lastResult(lastResult:ListadoCambiosPlanTarifDTO):void
		{
			_cambiosPlanAbonadoPospago_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addcambiosPlanAbonadoPospago()
		 */
		public function addcambiosPlanAbonadoPospagoEventListener(listener:Function):void
		{
			addEventListener(CambiosPlanAbonadoPospagoResultEvent.CambiosPlanAbonadoPospago_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _cambiosPlanAbonadoPospago_populate_results(event:ResultEvent):void
		{
			var e:CambiosPlanAbonadoPospagoResultEvent = new CambiosPlanAbonadoPospagoResultEvent();
		            e.result = event.result as ListadoCambiosPlanTarifDTO;
		                       e.headers = event.headers;
		             cambiosPlanAbonadoPospago_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the consultaOoSsProceso operation
          

        /**
         * @see IWSSEGPortal#consultaOoSsProceso()
         */
        public function consultaOoSsProceso(nomUsuario:String):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.consultaOoSsProceso(nomUsuario);
            _internal_token.addEventListener("result",_consultaOoSsProceso_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#consultaOoSsProceso_send()
		 */    
        public function consultaOoSsProceso_send():AsyncToken
        {
        	return consultaOoSsProceso(_consultaOoSsProceso_request.nomUsuario);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _consultaOoSsProceso_request:ConsultaOoSsProceso_request;
		/**
		 * @see IWSSEGPortal#consultaOoSsProceso_request_var
		 */
		[Bindable]
		public function get consultaOoSsProceso_request_var():ConsultaOoSsProceso_request
		{
			return _consultaOoSsProceso_request;
		}
		
		/**
		 * @private
		 */
		public function set consultaOoSsProceso_request_var(request:ConsultaOoSsProceso_request):void
		{
			_consultaOoSsProceso_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _consultaOoSsProceso_lastResult:Boolean;
		[Bindable]
		/**
		 * @see IWSSEGPortal#consultaOoSsProceso_lastResult
		 */	  
		public function get consultaOoSsProceso_lastResult():Boolean
		{
			return _consultaOoSsProceso_lastResult;
		}
		/**
		 * @private
		 */
		public function set consultaOoSsProceso_lastResult(lastResult:Boolean):void
		{
			_consultaOoSsProceso_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addconsultaOoSsProceso()
		 */
		public function addconsultaOoSsProcesoEventListener(listener:Function):void
		{
			addEventListener(ConsultaOoSsProcesoResultEvent.ConsultaOoSsProceso_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _consultaOoSsProceso_populate_results(event:ResultEvent):void
		{
			var e:ConsultaOoSsProcesoResultEvent = new ConsultaOoSsProcesoResultEvent();
		            e.result = event.result as Boolean;
		                       e.headers = event.headers;
		             consultaOoSsProceso_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the ingresoAtencion operation
          

        /**
         * @see IWSSEGPortal#ingresoAtencion()
         */
        public function ingresoAtencion(resgistroAtencionDTO:ResgistroAtencionDTO):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.ingresoAtencion(resgistroAtencionDTO);
            _internal_token.addEventListener("result",_ingresoAtencion_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#ingresoAtencion_send()
		 */    
        public function ingresoAtencion_send():AsyncToken
        {
        	return ingresoAtencion(_ingresoAtencion_request.resgistroAtencionDTO);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _ingresoAtencion_request:IngresoAtencion_request;
		/**
		 * @see IWSSEGPortal#ingresoAtencion_request_var
		 */
		[Bindable]
		public function get ingresoAtencion_request_var():IngresoAtencion_request
		{
			return _ingresoAtencion_request;
		}
		
		/**
		 * @private
		 */
		public function set ingresoAtencion_request_var(request:IngresoAtencion_request):void
		{
			_ingresoAtencion_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _ingresoAtencion_lastResult:ResulTransaccionDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#ingresoAtencion_lastResult
		 */	  
		public function get ingresoAtencion_lastResult():ResulTransaccionDTO
		{
			return _ingresoAtencion_lastResult;
		}
		/**
		 * @private
		 */
		public function set ingresoAtencion_lastResult(lastResult:ResulTransaccionDTO):void
		{
			_ingresoAtencion_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addingresoAtencion()
		 */
		public function addingresoAtencionEventListener(listener:Function):void
		{
			addEventListener(IngresoAtencionResultEvent.IngresoAtencion_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _ingresoAtencion_populate_results(event:ResultEvent):void
		{
			var e:IngresoAtencionResultEvent = new IngresoAtencionResultEvent();
		            e.result = event.result as ResulTransaccionDTO;
		                       e.headers = event.headers;
		             ingresoAtencion_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the decirHelloWorld operation
          

        /**
         * @see IWSSEGPortal#decirHelloWorld()
         */
        public function decirHelloWorld():AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.decirHelloWorld();
            _internal_token.addEventListener("result",_decirHelloWorld_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#decirHelloWorld_send()
		 */    
        public function decirHelloWorld_send():AsyncToken
        {
        	return decirHelloWorld();
        }
              
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _decirHelloWorld_lastResult:String;
		[Bindable]
		/**
		 * @see IWSSEGPortal#decirHelloWorld_lastResult
		 */	  
		public function get decirHelloWorld_lastResult():String
		{
			return _decirHelloWorld_lastResult;
		}
		/**
		 * @private
		 */
		public function set decirHelloWorld_lastResult(lastResult:String):void
		{
			_decirHelloWorld_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#adddecirHelloWorld()
		 */
		public function adddecirHelloWorldEventListener(listener:Function):void
		{
			addEventListener(DecirHelloWorldResultEvent.DecirHelloWorld_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _decirHelloWorld_populate_results(event:ResultEvent):void
		{
			var e:DecirHelloWorldResultEvent = new DecirHelloWorldResultEvent();
		            e.result = event.result as String;
		                       e.headers = event.headers;
		             decirHelloWorld_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the cambiarDireccionesCliente operation
          

        /**
         * @see IWSSEGPortal#cambiarDireccionesCliente()
         */
        public function cambiarDireccionesCliente(dto:ListadoDireccionesSACDTO):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.cambiarDireccionesCliente(dto);
            _internal_token.addEventListener("result",_cambiarDireccionesCliente_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#cambiarDireccionesCliente_send()
		 */    
        public function cambiarDireccionesCliente_send():AsyncToken
        {
        	return cambiarDireccionesCliente(_cambiarDireccionesCliente_request.dto);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _cambiarDireccionesCliente_request:CambiarDireccionesCliente_request;
		/**
		 * @see IWSSEGPortal#cambiarDireccionesCliente_request_var
		 */
		[Bindable]
		public function get cambiarDireccionesCliente_request_var():CambiarDireccionesCliente_request
		{
			return _cambiarDireccionesCliente_request;
		}
		
		/**
		 * @private
		 */
		public function set cambiarDireccionesCliente_request_var(request:CambiarDireccionesCliente_request):void
		{
			_cambiarDireccionesCliente_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _cambiarDireccionesCliente_lastResult:ListadoOrdenesServicioSACDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#cambiarDireccionesCliente_lastResult
		 */	  
		public function get cambiarDireccionesCliente_lastResult():ListadoOrdenesServicioSACDTO
		{
			return _cambiarDireccionesCliente_lastResult;
		}
		/**
		 * @private
		 */
		public function set cambiarDireccionesCliente_lastResult(lastResult:ListadoOrdenesServicioSACDTO):void
		{
			_cambiarDireccionesCliente_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addcambiarDireccionesCliente()
		 */
		public function addcambiarDireccionesClienteEventListener(listener:Function):void
		{
			addEventListener(CambiarDireccionesClienteResultEvent.CambiarDireccionesCliente_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _cambiarDireccionesCliente_populate_results(event:ResultEvent):void
		{
			var e:CambiarDireccionesClienteResultEvent = new CambiarDireccionesClienteResultEvent();
		            e.result = event.result as ListadoOrdenesServicioSACDTO;
		                       e.headers = event.headers;
		             cambiarDireccionesCliente_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the consultaAtencion operation
          

        /**
         * @see IWSSEGPortal#consultaAtencion()
         */
        public function consultaAtencion():AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.consultaAtencion();
            _internal_token.addEventListener("result",_consultaAtencion_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#consultaAtencion_send()
		 */    
        public function consultaAtencion_send():AsyncToken
        {
        	return consultaAtencion();
        }
              
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _consultaAtencion_lastResult:ListaAtencionClienteDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#consultaAtencion_lastResult
		 */	  
		public function get consultaAtencion_lastResult():ListaAtencionClienteDTO
		{
			return _consultaAtencion_lastResult;
		}
		/**
		 * @private
		 */
		public function set consultaAtencion_lastResult(lastResult:ListaAtencionClienteDTO):void
		{
			_consultaAtencion_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addconsultaAtencion()
		 */
		public function addconsultaAtencionEventListener(listener:Function):void
		{
			addEventListener(ConsultaAtencionResultEvent.ConsultaAtencion_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _consultaAtencion_populate_results(event:ResultEvent):void
		{
			var e:ConsultaAtencionResultEvent = new ConsultaAtencionResultEvent();
		            e.result = event.result as ListaAtencionClienteDTO;
		                       e.headers = event.headers;
		             consultaAtencion_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the obtenerCausalCambio operation
          

        /**
         * @see IWSSEGPortal#obtenerCausalCambio()
         */
        public function obtenerCausalCambio():AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.obtenerCausalCambio();
            _internal_token.addEventListener("result",_obtenerCausalCambio_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#obtenerCausalCambio_send()
		 */    
        public function obtenerCausalCambio_send():AsyncToken
        {
        	return obtenerCausalCambio();
        }
              
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _obtenerCausalCambio_lastResult:ListaCausalCambioDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#obtenerCausalCambio_lastResult
		 */	  
		public function get obtenerCausalCambio_lastResult():ListaCausalCambioDTO
		{
			return _obtenerCausalCambio_lastResult;
		}
		/**
		 * @private
		 */
		public function set obtenerCausalCambio_lastResult(lastResult:ListaCausalCambioDTO):void
		{
			_obtenerCausalCambio_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addobtenerCausalCambio()
		 */
		public function addobtenerCausalCambioEventListener(listener:Function):void
		{
			addEventListener(ObtenerCausalCambioResultEvent.ObtenerCausalCambio_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _obtenerCausalCambio_populate_results(event:ResultEvent):void
		{
			var e:ObtenerCausalCambioResultEvent = new ObtenerCausalCambioResultEvent();
		            e.result = event.result as ListaCausalCambioDTO;
		                       e.headers = event.headers;
		             obtenerCausalCambio_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the cambiarPassword operation
          

        /**
         * @see IWSSEGPortal#cambiarPassword()
         */
        public function cambiarPassword(usuario:String,passwordActual:String,passwordNueva:String):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.cambiarPassword(usuario,passwordActual,passwordNueva);
            _internal_token.addEventListener("result",_cambiarPassword_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#cambiarPassword_send()
		 */    
        public function cambiarPassword_send():AsyncToken
        {
        	return cambiarPassword(_cambiarPassword_request.usuario,_cambiarPassword_request.passwordActual,_cambiarPassword_request.passwordNueva);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _cambiarPassword_request:CambiarPassword_request;
		/**
		 * @see IWSSEGPortal#cambiarPassword_request_var
		 */
		[Bindable]
		public function get cambiarPassword_request_var():CambiarPassword_request
		{
			return _cambiarPassword_request;
		}
		
		/**
		 * @private
		 */
		public function set cambiarPassword_request_var(request:CambiarPassword_request):void
		{
			_cambiarPassword_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _cambiarPassword_lastResult:Boolean;
		[Bindable]
		/**
		 * @see IWSSEGPortal#cambiarPassword_lastResult
		 */	  
		public function get cambiarPassword_lastResult():Boolean
		{
			return _cambiarPassword_lastResult;
		}
		/**
		 * @private
		 */
		public function set cambiarPassword_lastResult(lastResult:Boolean):void
		{
			_cambiarPassword_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addcambiarPassword()
		 */
		public function addcambiarPasswordEventListener(listener:Function):void
		{
			addEventListener(CambiarPasswordResultEvent.CambiarPassword_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _cambiarPassword_populate_results(event:ResultEvent):void
		{
			var e:CambiarPasswordResultEvent = new CambiarPasswordResultEvent();
		            e.result = event.result as Boolean;
		                       e.headers = event.headers;
		             cambiarPassword_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the direccionesXCodCliente operation
          

        /**
         * @see IWSSEGPortal#direccionesXCodCliente()
         */
        public function direccionesXCodCliente(codCliente:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.direccionesXCodCliente(codCliente,nomUsuarioSCL,codEvento);
            _internal_token.addEventListener("result",_direccionesXCodCliente_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#direccionesXCodCliente_send()
		 */    
        public function direccionesXCodCliente_send():AsyncToken
        {
        	return direccionesXCodCliente(_direccionesXCodCliente_request.codCliente,_direccionesXCodCliente_request.nomUsuarioSCL,_direccionesXCodCliente_request.codEvento);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _direccionesXCodCliente_request:DireccionesXCodCliente_request;
		/**
		 * @see IWSSEGPortal#direccionesXCodCliente_request_var
		 */
		[Bindable]
		public function get direccionesXCodCliente_request_var():DireccionesXCodCliente_request
		{
			return _direccionesXCodCliente_request;
		}
		
		/**
		 * @private
		 */
		public function set direccionesXCodCliente_request_var(request:DireccionesXCodCliente_request):void
		{
			_direccionesXCodCliente_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _direccionesXCodCliente_lastResult:ListadoDireccionesDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#direccionesXCodCliente_lastResult
		 */	  
		public function get direccionesXCodCliente_lastResult():ListadoDireccionesDTO
		{
			return _direccionesXCodCliente_lastResult;
		}
		/**
		 * @private
		 */
		public function set direccionesXCodCliente_lastResult(lastResult:ListadoDireccionesDTO):void
		{
			_direccionesXCodCliente_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#adddireccionesXCodCliente()
		 */
		public function adddireccionesXCodClienteEventListener(listener:Function):void
		{
			addEventListener(DireccionesXCodClienteResultEvent.DireccionesXCodCliente_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _direccionesXCodCliente_populate_results(event:ResultEvent):void
		{
			var e:DireccionesXCodClienteResultEvent = new DireccionesXCodClienteResultEvent();
		            e.result = event.result as ListadoDireccionesDTO;
		                       e.headers = event.headers;
		             direccionesXCodCliente_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the cargarAbonoLimiteConsumoSS operation
          

        /**
         * @see IWSSEGPortal#cargarAbonoLimiteConsumoSS()
         */
        public function cargarAbonoLimiteConsumoSS(codSujeto:Number,tipoAbono:String,tipoOOSS:String,nomUsuarioSCL:String,codEvento:String):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.cargarAbonoLimiteConsumoSS(codSujeto,tipoAbono,tipoOOSS,nomUsuarioSCL,codEvento);
            _internal_token.addEventListener("result",_cargarAbonoLimiteConsumoSS_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#cargarAbonoLimiteConsumoSS_send()
		 */    
        public function cargarAbonoLimiteConsumoSS_send():AsyncToken
        {
        	return cargarAbonoLimiteConsumoSS(_cargarAbonoLimiteConsumoSS_request.codSujeto,_cargarAbonoLimiteConsumoSS_request.tipoAbono,_cargarAbonoLimiteConsumoSS_request.tipoOOSS,_cargarAbonoLimiteConsumoSS_request.nomUsuarioSCL,_cargarAbonoLimiteConsumoSS_request.codEvento);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _cargarAbonoLimiteConsumoSS_request:CargarAbonoLimiteConsumoSS_request;
		/**
		 * @see IWSSEGPortal#cargarAbonoLimiteConsumoSS_request_var
		 */
		[Bindable]
		public function get cargarAbonoLimiteConsumoSS_request_var():CargarAbonoLimiteConsumoSS_request
		{
			return _cargarAbonoLimiteConsumoSS_request;
		}
		
		/**
		 * @private
		 */
		public function set cargarAbonoLimiteConsumoSS_request_var(request:CargarAbonoLimiteConsumoSS_request):void
		{
			_cargarAbonoLimiteConsumoSS_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _cargarAbonoLimiteConsumoSS_lastResult:CargaAbonoLimiteConsumoServicioSuplementarioDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#cargarAbonoLimiteConsumoSS_lastResult
		 */	  
		public function get cargarAbonoLimiteConsumoSS_lastResult():CargaAbonoLimiteConsumoServicioSuplementarioDTO
		{
			return _cargarAbonoLimiteConsumoSS_lastResult;
		}
		/**
		 * @private
		 */
		public function set cargarAbonoLimiteConsumoSS_lastResult(lastResult:CargaAbonoLimiteConsumoServicioSuplementarioDTO):void
		{
			_cargarAbonoLimiteConsumoSS_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addcargarAbonoLimiteConsumoSS()
		 */
		public function addcargarAbonoLimiteConsumoSSEventListener(listener:Function):void
		{
			addEventListener(CargarAbonoLimiteConsumoSSResultEvent.CargarAbonoLimiteConsumoSS_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _cargarAbonoLimiteConsumoSS_populate_results(event:ResultEvent):void
		{
			var e:CargarAbonoLimiteConsumoSSResultEvent = new CargarAbonoLimiteConsumoSSResultEvent();
		            e.result = event.result as CargaAbonoLimiteConsumoServicioSuplementarioDTO;
		                       e.headers = event.headers;
		             cargarAbonoLimiteConsumoSS_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the ejecutarSuspensionSrvCelular operation
          

        /**
         * @see IWSSEGPortal#ejecutarSuspensionSrvCelular()
         */
        public function ejecutarSuspensionSrvCelular(entrada:EjecucionSuspensionSrvCelDTO):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.ejecutarSuspensionSrvCelular(entrada);
            _internal_token.addEventListener("result",_ejecutarSuspensionSrvCelular_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#ejecutarSuspensionSrvCelular_send()
		 */    
        public function ejecutarSuspensionSrvCelular_send():AsyncToken
        {
        	return ejecutarSuspensionSrvCelular(_ejecutarSuspensionSrvCelular_request.entrada);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _ejecutarSuspensionSrvCelular_request:EjecutarSuspensionSrvCelular_request;
		/**
		 * @see IWSSEGPortal#ejecutarSuspensionSrvCelular_request_var
		 */
		[Bindable]
		public function get ejecutarSuspensionSrvCelular_request_var():EjecutarSuspensionSrvCelular_request
		{
			return _ejecutarSuspensionSrvCelular_request;
		}
		
		/**
		 * @private
		 */
		public function set ejecutarSuspensionSrvCelular_request_var(request:EjecutarSuspensionSrvCelular_request):void
		{
			_ejecutarSuspensionSrvCelular_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _ejecutarSuspensionSrvCelular_lastResult:EjecucionSuspensionSrvCelDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#ejecutarSuspensionSrvCelular_lastResult
		 */	  
		public function get ejecutarSuspensionSrvCelular_lastResult():EjecucionSuspensionSrvCelDTO
		{
			return _ejecutarSuspensionSrvCelular_lastResult;
		}
		/**
		 * @private
		 */
		public function set ejecutarSuspensionSrvCelular_lastResult(lastResult:EjecucionSuspensionSrvCelDTO):void
		{
			_ejecutarSuspensionSrvCelular_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addejecutarSuspensionSrvCelular()
		 */
		public function addejecutarSuspensionSrvCelularEventListener(listener:Function):void
		{
			addEventListener(EjecutarSuspensionSrvCelularResultEvent.EjecutarSuspensionSrvCelular_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _ejecutarSuspensionSrvCelular_populate_results(event:ResultEvent):void
		{
			var e:EjecutarSuspensionSrvCelularResultEvent = new EjecutarSuspensionSrvCelularResultEvent();
		            e.result = event.result as EjecucionSuspensionSrvCelDTO;
		                       e.headers = event.headers;
		             ejecutarSuspensionSrvCelular_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the cargaServicioCargos operation
          

        /**
         * @see IWSSEGPortal#cargaServicioCargos()
         */
        public function cargaServicioCargos(entrada:CargaServicioCargosDTO,ventaSimcard:String):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.cargaServicioCargos(entrada,ventaSimcard);
            _internal_token.addEventListener("result",_cargaServicioCargos_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#cargaServicioCargos_send()
		 */    
        public function cargaServicioCargos_send():AsyncToken
        {
        	return cargaServicioCargos(_cargaServicioCargos_request.entrada,_cargaServicioCargos_request.ventaSimcard);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _cargaServicioCargos_request:CargaServicioCargos_request;
		/**
		 * @see IWSSEGPortal#cargaServicioCargos_request_var
		 */
		[Bindable]
		public function get cargaServicioCargos_request_var():CargaServicioCargos_request
		{
			return _cargaServicioCargos_request;
		}
		
		/**
		 * @private
		 */
		public function set cargaServicioCargos_request_var(request:CargaServicioCargos_request):void
		{
			_cargaServicioCargos_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _cargaServicioCargos_lastResult:CargaServicioCargosDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#cargaServicioCargos_lastResult
		 */	  
		public function get cargaServicioCargos_lastResult():CargaServicioCargosDTO
		{
			return _cargaServicioCargos_lastResult;
		}
		/**
		 * @private
		 */
		public function set cargaServicioCargos_lastResult(lastResult:CargaServicioCargosDTO):void
		{
			_cargaServicioCargos_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addcargaServicioCargos()
		 */
		public function addcargaServicioCargosEventListener(listener:Function):void
		{
			addEventListener(CargaServicioCargosResultEvent.CargaServicioCargos_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _cargaServicioCargos_populate_results(event:ResultEvent):void
		{
			var e:CargaServicioCargosResultEvent = new CargaServicioCargosResultEvent();
		            e.result = event.result as CargaServicioCargosDTO;
		                       e.headers = event.headers;
		             cargaServicioCargos_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the oossEjecutadasXCodCuenta operation
          

        /**
         * @see IWSSEGPortal#oossEjecutadasXCodCuenta()
         */
        public function oossEjecutadasXCodCuenta(codCuenta:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.oossEjecutadasXCodCuenta(codCuenta,nomUsuarioSCL,codEvento);
            _internal_token.addEventListener("result",_oossEjecutadasXCodCuenta_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#oossEjecutadasXCodCuenta_send()
		 */    
        public function oossEjecutadasXCodCuenta_send():AsyncToken
        {
        	return oossEjecutadasXCodCuenta(_oossEjecutadasXCodCuenta_request.codCuenta,_oossEjecutadasXCodCuenta_request.nomUsuarioSCL,_oossEjecutadasXCodCuenta_request.codEvento);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _oossEjecutadasXCodCuenta_request:OossEjecutadasXCodCuenta_request;
		/**
		 * @see IWSSEGPortal#oossEjecutadasXCodCuenta_request_var
		 */
		[Bindable]
		public function get oossEjecutadasXCodCuenta_request_var():OossEjecutadasXCodCuenta_request
		{
			return _oossEjecutadasXCodCuenta_request;
		}
		
		/**
		 * @private
		 */
		public function set oossEjecutadasXCodCuenta_request_var(request:OossEjecutadasXCodCuenta_request):void
		{
			_oossEjecutadasXCodCuenta_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _oossEjecutadasXCodCuenta_lastResult:ListadoOrdenesServicioDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#oossEjecutadasXCodCuenta_lastResult
		 */	  
		public function get oossEjecutadasXCodCuenta_lastResult():ListadoOrdenesServicioDTO
		{
			return _oossEjecutadasXCodCuenta_lastResult;
		}
		/**
		 * @private
		 */
		public function set oossEjecutadasXCodCuenta_lastResult(lastResult:ListadoOrdenesServicioDTO):void
		{
			_oossEjecutadasXCodCuenta_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addoossEjecutadasXCodCuenta()
		 */
		public function addoossEjecutadasXCodCuentaEventListener(listener:Function):void
		{
			addEventListener(OossEjecutadasXCodCuentaResultEvent.OossEjecutadasXCodCuenta_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _oossEjecutadasXCodCuenta_populate_results(event:ResultEvent):void
		{
			var e:OossEjecutadasXCodCuentaResultEvent = new OossEjecutadasXCodCuentaResultEvent();
		            e.result = event.result as ListadoOrdenesServicioDTO;
		                       e.headers = event.headers;
		             oossEjecutadasXCodCuenta_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the consultaOrdenServicio operation
          

        /**
         * @see IWSSEGPortal#consultaOrdenServicio()
         */
        public function consultaOrdenServicio(codOOSS:Number,numTransaccion:String,nomUsuarioSCL:String):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.consultaOrdenServicio(codOOSS,numTransaccion,nomUsuarioSCL);
            _internal_token.addEventListener("result",_consultaOrdenServicio_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#consultaOrdenServicio_send()
		 */    
        public function consultaOrdenServicio_send():AsyncToken
        {
        	return consultaOrdenServicio(_consultaOrdenServicio_request.codOOSS,_consultaOrdenServicio_request.numTransaccion,_consultaOrdenServicio_request.nomUsuarioSCL);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _consultaOrdenServicio_request:ConsultaOrdenServicio_request;
		/**
		 * @see IWSSEGPortal#consultaOrdenServicio_request_var
		 */
		[Bindable]
		public function get consultaOrdenServicio_request_var():ConsultaOrdenServicio_request
		{
			return _consultaOrdenServicio_request;
		}
		
		/**
		 * @private
		 */
		public function set consultaOrdenServicio_request_var(request:ConsultaOrdenServicio_request):void
		{
			_consultaOrdenServicio_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _consultaOrdenServicio_lastResult:ConsultarOrdenServicioSACDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#consultaOrdenServicio_lastResult
		 */	  
		public function get consultaOrdenServicio_lastResult():ConsultarOrdenServicioSACDTO
		{
			return _consultaOrdenServicio_lastResult;
		}
		/**
		 * @private
		 */
		public function set consultaOrdenServicio_lastResult(lastResult:ConsultarOrdenServicioSACDTO):void
		{
			_consultaOrdenServicio_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addconsultaOrdenServicio()
		 */
		public function addconsultaOrdenServicioEventListener(listener:Function):void
		{
			addEventListener(ConsultaOrdenServicioResultEvent.ConsultaOrdenServicio_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _consultaOrdenServicio_populate_results(event:ResultEvent):void
		{
			var e:ConsultaOrdenServicioResultEvent = new ConsultaOrdenServicioResultEvent();
		            e.result = event.result as ConsultarOrdenServicioSACDTO;
		                       e.headers = event.headers;
		             consultaOrdenServicio_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the facturasXCodCliente operation
          

        /**
         * @see IWSSEGPortal#facturasXCodCliente()
         */
        public function facturasXCodCliente(codCliente:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.facturasXCodCliente(codCliente,nomUsuarioSCL,codEvento);
            _internal_token.addEventListener("result",_facturasXCodCliente_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#facturasXCodCliente_send()
		 */    
        public function facturasXCodCliente_send():AsyncToken
        {
        	return facturasXCodCliente(_facturasXCodCliente_request.codCliente,_facturasXCodCliente_request.nomUsuarioSCL,_facturasXCodCliente_request.codEvento);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _facturasXCodCliente_request:FacturasXCodCliente_request;
		/**
		 * @see IWSSEGPortal#facturasXCodCliente_request_var
		 */
		[Bindable]
		public function get facturasXCodCliente_request_var():FacturasXCodCliente_request
		{
			return _facturasXCodCliente_request;
		}
		
		/**
		 * @private
		 */
		public function set facturasXCodCliente_request_var(request:FacturasXCodCliente_request):void
		{
			_facturasXCodCliente_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _facturasXCodCliente_lastResult:ListadoFacturasDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#facturasXCodCliente_lastResult
		 */	  
		public function get facturasXCodCliente_lastResult():ListadoFacturasDTO
		{
			return _facturasXCodCliente_lastResult;
		}
		/**
		 * @private
		 */
		public function set facturasXCodCliente_lastResult(lastResult:ListadoFacturasDTO):void
		{
			_facturasXCodCliente_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addfacturasXCodCliente()
		 */
		public function addfacturasXCodClienteEventListener(listener:Function):void
		{
			addEventListener(FacturasXCodClienteResultEvent.FacturasXCodCliente_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _facturasXCodCliente_populate_results(event:ResultEvent):void
		{
			var e:FacturasXCodClienteResultEvent = new FacturasXCodClienteResultEvent();
		            e.result = event.result as ListadoFacturasDTO;
		                       e.headers = event.headers;
		             facturasXCodCliente_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the pagoLimiteConsumoXClienteAbonado operation
          

        /**
         * @see IWSSEGPortal#pagoLimiteConsumoXClienteAbonado()
         */
        public function pagoLimiteConsumoXClienteAbonado(codCliente:Number,numAbonado:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.pagoLimiteConsumoXClienteAbonado(codCliente,numAbonado,nomUsuarioSCL,codEvento);
            _internal_token.addEventListener("result",_pagoLimiteConsumoXClienteAbonado_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#pagoLimiteConsumoXClienteAbonado_send()
		 */    
        public function pagoLimiteConsumoXClienteAbonado_send():AsyncToken
        {
        	return pagoLimiteConsumoXClienteAbonado(_pagoLimiteConsumoXClienteAbonado_request.codCliente,_pagoLimiteConsumoXClienteAbonado_request.numAbonado,_pagoLimiteConsumoXClienteAbonado_request.nomUsuarioSCL,_pagoLimiteConsumoXClienteAbonado_request.codEvento);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _pagoLimiteConsumoXClienteAbonado_request:PagoLimiteConsumoXClienteAbonado_request;
		/**
		 * @see IWSSEGPortal#pagoLimiteConsumoXClienteAbonado_request_var
		 */
		[Bindable]
		public function get pagoLimiteConsumoXClienteAbonado_request_var():PagoLimiteConsumoXClienteAbonado_request
		{
			return _pagoLimiteConsumoXClienteAbonado_request;
		}
		
		/**
		 * @private
		 */
		public function set pagoLimiteConsumoXClienteAbonado_request_var(request:PagoLimiteConsumoXClienteAbonado_request):void
		{
			_pagoLimiteConsumoXClienteAbonado_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _pagoLimiteConsumoXClienteAbonado_lastResult:ListadoPagosLimiteConsumoDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#pagoLimiteConsumoXClienteAbonado_lastResult
		 */	  
		public function get pagoLimiteConsumoXClienteAbonado_lastResult():ListadoPagosLimiteConsumoDTO
		{
			return _pagoLimiteConsumoXClienteAbonado_lastResult;
		}
		/**
		 * @private
		 */
		public function set pagoLimiteConsumoXClienteAbonado_lastResult(lastResult:ListadoPagosLimiteConsumoDTO):void
		{
			_pagoLimiteConsumoXClienteAbonado_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addpagoLimiteConsumoXClienteAbonado()
		 */
		public function addpagoLimiteConsumoXClienteAbonadoEventListener(listener:Function):void
		{
			addEventListener(PagoLimiteConsumoXClienteAbonadoResultEvent.PagoLimiteConsumoXClienteAbonado_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _pagoLimiteConsumoXClienteAbonado_populate_results(event:ResultEvent):void
		{
			var e:PagoLimiteConsumoXClienteAbonadoResultEvent = new PagoLimiteConsumoXClienteAbonadoResultEvent();
		            e.result = event.result as ListadoPagosLimiteConsumoDTO;
		                       e.headers = event.headers;
		             pagoLimiteConsumoXClienteAbonado_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the pagosXCodCliente operation
          

        /**
         * @see IWSSEGPortal#pagosXCodCliente()
         */
        public function pagosXCodCliente(codCliente:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.pagosXCodCliente(codCliente,nomUsuarioSCL,codEvento);
            _internal_token.addEventListener("result",_pagosXCodCliente_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#pagosXCodCliente_send()
		 */    
        public function pagosXCodCliente_send():AsyncToken
        {
        	return pagosXCodCliente(_pagosXCodCliente_request.codCliente,_pagosXCodCliente_request.nomUsuarioSCL,_pagosXCodCliente_request.codEvento);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _pagosXCodCliente_request:PagosXCodCliente_request;
		/**
		 * @see IWSSEGPortal#pagosXCodCliente_request_var
		 */
		[Bindable]
		public function get pagosXCodCliente_request_var():PagosXCodCliente_request
		{
			return _pagosXCodCliente_request;
		}
		
		/**
		 * @private
		 */
		public function set pagosXCodCliente_request_var(request:PagosXCodCliente_request):void
		{
			_pagosXCodCliente_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _pagosXCodCliente_lastResult:ListadoPagosDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#pagosXCodCliente_lastResult
		 */	  
		public function get pagosXCodCliente_lastResult():ListadoPagosDTO
		{
			return _pagosXCodCliente_lastResult;
		}
		/**
		 * @private
		 */
		public function set pagosXCodCliente_lastResult(lastResult:ListadoPagosDTO):void
		{
			_pagosXCodCliente_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addpagosXCodCliente()
		 */
		public function addpagosXCodClienteEventListener(listener:Function):void
		{
			addEventListener(PagosXCodClienteResultEvent.PagosXCodCliente_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _pagosXCodCliente_populate_results(event:ResultEvent):void
		{
			var e:PagosXCodClienteResultEvent = new PagosXCodClienteResultEvent();
		            e.result = event.result as ListadoPagosDTO;
		                       e.headers = event.headers;
		             pagosXCodCliente_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the cambiosPlanCliente operation
          

        /**
         * @see IWSSEGPortal#cambiosPlanCliente()
         */
        public function cambiosPlanCliente(numOS:Number):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.cambiosPlanCliente(numOS);
            _internal_token.addEventListener("result",_cambiosPlanCliente_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#cambiosPlanCliente_send()
		 */    
        public function cambiosPlanCliente_send():AsyncToken
        {
        	return cambiosPlanCliente(_cambiosPlanCliente_request.numOS);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _cambiosPlanCliente_request:CambiosPlanCliente_request;
		/**
		 * @see IWSSEGPortal#cambiosPlanCliente_request_var
		 */
		[Bindable]
		public function get cambiosPlanCliente_request_var():CambiosPlanCliente_request
		{
			return _cambiosPlanCliente_request;
		}
		
		/**
		 * @private
		 */
		public function set cambiosPlanCliente_request_var(request:CambiosPlanCliente_request):void
		{
			_cambiosPlanCliente_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _cambiosPlanCliente_lastResult:ListadoCambiosPlanTarifDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#cambiosPlanCliente_lastResult
		 */	  
		public function get cambiosPlanCliente_lastResult():ListadoCambiosPlanTarifDTO
		{
			return _cambiosPlanCliente_lastResult;
		}
		/**
		 * @private
		 */
		public function set cambiosPlanCliente_lastResult(lastResult:ListadoCambiosPlanTarifDTO):void
		{
			_cambiosPlanCliente_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addcambiosPlanCliente()
		 */
		public function addcambiosPlanClienteEventListener(listener:Function):void
		{
			addEventListener(CambiosPlanClienteResultEvent.CambiosPlanCliente_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _cambiosPlanCliente_populate_results(event:ResultEvent):void
		{
			var e:CambiosPlanClienteResultEvent = new CambiosPlanClienteResultEvent();
		            e.result = event.result as ListadoCambiosPlanTarifDTO;
		                       e.headers = event.headers;
		             cambiosPlanCliente_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the ejecutarAjusteCExcepcionCargos operation
          

        /**
         * @see IWSSEGPortal#ejecutarAjusteCExcepcionCargos()
         */
        public function ejecutarAjusteCExcepcionCargos(entrada:EjecucionAjusteCExcepcionCargosSACDTO):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.ejecutarAjusteCExcepcionCargos(entrada);
            _internal_token.addEventListener("result",_ejecutarAjusteCExcepcionCargos_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#ejecutarAjusteCExcepcionCargos_send()
		 */    
        public function ejecutarAjusteCExcepcionCargos_send():AsyncToken
        {
        	return ejecutarAjusteCExcepcionCargos(_ejecutarAjusteCExcepcionCargos_request.entrada);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _ejecutarAjusteCExcepcionCargos_request:EjecutarAjusteCExcepcionCargos_request;
		/**
		 * @see IWSSEGPortal#ejecutarAjusteCExcepcionCargos_request_var
		 */
		[Bindable]
		public function get ejecutarAjusteCExcepcionCargos_request_var():EjecutarAjusteCExcepcionCargos_request
		{
			return _ejecutarAjusteCExcepcionCargos_request;
		}
		
		/**
		 * @private
		 */
		public function set ejecutarAjusteCExcepcionCargos_request_var(request:EjecutarAjusteCExcepcionCargos_request):void
		{
			_ejecutarAjusteCExcepcionCargos_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _ejecutarAjusteCExcepcionCargos_lastResult:EjecucionAjusteCExcepcionCargosDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#ejecutarAjusteCExcepcionCargos_lastResult
		 */	  
		public function get ejecutarAjusteCExcepcionCargos_lastResult():EjecucionAjusteCExcepcionCargosDTO
		{
			return _ejecutarAjusteCExcepcionCargos_lastResult;
		}
		/**
		 * @private
		 */
		public function set ejecutarAjusteCExcepcionCargos_lastResult(lastResult:EjecucionAjusteCExcepcionCargosDTO):void
		{
			_ejecutarAjusteCExcepcionCargos_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addejecutarAjusteCExcepcionCargos()
		 */
		public function addejecutarAjusteCExcepcionCargosEventListener(listener:Function):void
		{
			addEventListener(EjecutarAjusteCExcepcionCargosResultEvent.EjecutarAjusteCExcepcionCargos_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _ejecutarAjusteCExcepcionCargos_populate_results(event:ResultEvent):void
		{
			var e:EjecutarAjusteCExcepcionCargosResultEvent = new EjecutarAjusteCExcepcionCargosResultEvent();
		            e.result = event.result as EjecucionAjusteCExcepcionCargosDTO;
		                       e.headers = event.headers;
		             ejecutarAjusteCExcepcionCargos_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the beneficiosXClienteAbonado operation
          

        /**
         * @see IWSSEGPortal#beneficiosXClienteAbonado()
         */
        public function beneficiosXClienteAbonado(codCliente:Number,numAbonado:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.beneficiosXClienteAbonado(codCliente,numAbonado,nomUsuarioSCL,codEvento);
            _internal_token.addEventListener("result",_beneficiosXClienteAbonado_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#beneficiosXClienteAbonado_send()
		 */    
        public function beneficiosXClienteAbonado_send():AsyncToken
        {
        	return beneficiosXClienteAbonado(_beneficiosXClienteAbonado_request.codCliente,_beneficiosXClienteAbonado_request.numAbonado,_beneficiosXClienteAbonado_request.nomUsuarioSCL,_beneficiosXClienteAbonado_request.codEvento);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _beneficiosXClienteAbonado_request:BeneficiosXClienteAbonado_request;
		/**
		 * @see IWSSEGPortal#beneficiosXClienteAbonado_request_var
		 */
		[Bindable]
		public function get beneficiosXClienteAbonado_request_var():BeneficiosXClienteAbonado_request
		{
			return _beneficiosXClienteAbonado_request;
		}
		
		/**
		 * @private
		 */
		public function set beneficiosXClienteAbonado_request_var(request:BeneficiosXClienteAbonado_request):void
		{
			_beneficiosXClienteAbonado_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _beneficiosXClienteAbonado_lastResult:ListadoBeneficiosDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#beneficiosXClienteAbonado_lastResult
		 */	  
		public function get beneficiosXClienteAbonado_lastResult():ListadoBeneficiosDTO
		{
			return _beneficiosXClienteAbonado_lastResult;
		}
		/**
		 * @private
		 */
		public function set beneficiosXClienteAbonado_lastResult(lastResult:ListadoBeneficiosDTO):void
		{
			_beneficiosXClienteAbonado_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addbeneficiosXClienteAbonado()
		 */
		public function addbeneficiosXClienteAbonadoEventListener(listener:Function):void
		{
			addEventListener(BeneficiosXClienteAbonadoResultEvent.BeneficiosXClienteAbonado_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _beneficiosXClienteAbonado_populate_results(event:ResultEvent):void
		{
			var e:BeneficiosXClienteAbonadoResultEvent = new BeneficiosXClienteAbonadoResultEvent();
		            e.result = event.result as ListadoBeneficiosDTO;
		                       e.headers = event.headers;
		             beneficiosXClienteAbonado_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the insertComentarioPvIorserv operation
          

        /**
         * @see IWSSEGPortal#insertComentarioPvIorserv()
         */
        public function insertComentarioPvIorserv(comentario:String,numOoss:Number):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.insertComentarioPvIorserv(comentario,numOoss);
            _internal_token.addEventListener("result",_insertComentarioPvIorserv_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#insertComentarioPvIorserv_send()
		 */    
        public function insertComentarioPvIorserv_send():AsyncToken
        {
        	return insertComentarioPvIorserv(_insertComentarioPvIorserv_request.comentario,_insertComentarioPvIorserv_request.numOoss);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _insertComentarioPvIorserv_request:InsertComentarioPvIorserv_request;
		/**
		 * @see IWSSEGPortal#insertComentarioPvIorserv_request_var
		 */
		[Bindable]
		public function get insertComentarioPvIorserv_request_var():InsertComentarioPvIorserv_request
		{
			return _insertComentarioPvIorserv_request;
		}
		
		/**
		 * @private
		 */
		public function set insertComentarioPvIorserv_request_var(request:InsertComentarioPvIorserv_request):void
		{
			_insertComentarioPvIorserv_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _insertComentarioPvIorserv_lastResult:ResulTransaccionDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#insertComentarioPvIorserv_lastResult
		 */	  
		public function get insertComentarioPvIorserv_lastResult():ResulTransaccionDTO
		{
			return _insertComentarioPvIorserv_lastResult;
		}
		/**
		 * @private
		 */
		public function set insertComentarioPvIorserv_lastResult(lastResult:ResulTransaccionDTO):void
		{
			_insertComentarioPvIorserv_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addinsertComentarioPvIorserv()
		 */
		public function addinsertComentarioPvIorservEventListener(listener:Function):void
		{
			addEventListener(InsertComentarioPvIorservResultEvent.InsertComentarioPvIorserv_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _insertComentarioPvIorserv_populate_results(event:ResultEvent):void
		{
			var e:InsertComentarioPvIorservResultEvent = new InsertComentarioPvIorservResultEvent();
		            e.result = event.result as ResulTransaccionDTO;
		                       e.headers = event.headers;
		             insertComentarioPvIorserv_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the realizarBloqueoRobo operation
          

        /**
         * @see IWSSEGPortal#realizarBloqueoRobo()
         */
        public function realizarBloqueoRobo(dto:RealizarBloqueoRoboSACINDTO):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.realizarBloqueoRobo(dto);
            _internal_token.addEventListener("result",_realizarBloqueoRobo_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#realizarBloqueoRobo_send()
		 */    
        public function realizarBloqueoRobo_send():AsyncToken
        {
        	return realizarBloqueoRobo(_realizarBloqueoRobo_request.dto);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _realizarBloqueoRobo_request:RealizarBloqueoRobo_request;
		/**
		 * @see IWSSEGPortal#realizarBloqueoRobo_request_var
		 */
		[Bindable]
		public function get realizarBloqueoRobo_request_var():RealizarBloqueoRobo_request
		{
			return _realizarBloqueoRobo_request;
		}
		
		/**
		 * @private
		 */
		public function set realizarBloqueoRobo_request_var(request:RealizarBloqueoRobo_request):void
		{
			_realizarBloqueoRobo_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _realizarBloqueoRobo_lastResult:RealizarBloqueoRoboSACOUTDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#realizarBloqueoRobo_lastResult
		 */	  
		public function get realizarBloqueoRobo_lastResult():RealizarBloqueoRoboSACOUTDTO
		{
			return _realizarBloqueoRobo_lastResult;
		}
		/**
		 * @private
		 */
		public function set realizarBloqueoRobo_lastResult(lastResult:RealizarBloqueoRoboSACOUTDTO):void
		{
			_realizarBloqueoRobo_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addrealizarBloqueoRobo()
		 */
		public function addrealizarBloqueoRoboEventListener(listener:Function):void
		{
			addEventListener(RealizarBloqueoRoboResultEvent.RealizarBloqueoRobo_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _realizarBloqueoRobo_populate_results(event:ResultEvent):void
		{
			var e:RealizarBloqueoRoboResultEvent = new RealizarBloqueoRoboResultEvent();
		            e.result = event.result as RealizarBloqueoRoboSACOUTDTO;
		                       e.headers = event.headers;
		             realizarBloqueoRobo_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the cuentasXNumIdent operation
          

        /**
         * @see IWSSEGPortal#cuentasXNumIdent()
         */
        public function cuentasXNumIdent(numIdent:String):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.cuentasXNumIdent(numIdent);
            _internal_token.addEventListener("result",_cuentasXNumIdent_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#cuentasXNumIdent_send()
		 */    
        public function cuentasXNumIdent_send():AsyncToken
        {
        	return cuentasXNumIdent(_cuentasXNumIdent_request.numIdent);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _cuentasXNumIdent_request:CuentasXNumIdent_request;
		/**
		 * @see IWSSEGPortal#cuentasXNumIdent_request_var
		 */
		[Bindable]
		public function get cuentasXNumIdent_request_var():CuentasXNumIdent_request
		{
			return _cuentasXNumIdent_request;
		}
		
		/**
		 * @private
		 */
		public function set cuentasXNumIdent_request_var(request:CuentasXNumIdent_request):void
		{
			_cuentasXNumIdent_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _cuentasXNumIdent_lastResult:ListadoCuentasDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#cuentasXNumIdent_lastResult
		 */	  
		public function get cuentasXNumIdent_lastResult():ListadoCuentasDTO
		{
			return _cuentasXNumIdent_lastResult;
		}
		/**
		 * @private
		 */
		public function set cuentasXNumIdent_lastResult(lastResult:ListadoCuentasDTO):void
		{
			_cuentasXNumIdent_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addcuentasXNumIdent()
		 */
		public function addcuentasXNumIdentEventListener(listener:Function):void
		{
			addEventListener(CuentasXNumIdentResultEvent.CuentasXNumIdent_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _cuentasXNumIdent_populate_results(event:ResultEvent):void
		{
			var e:CuentasXNumIdentResultEvent = new CuentasXNumIdentResultEvent();
		            e.result = event.result as ListadoCuentasDTO;
		                       e.headers = event.headers;
		             cuentasXNumIdent_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the ejecutarCambioNumFrecuente operation
          

        /**
         * @see IWSSEGPortal#ejecutarCambioNumFrecuente()
         */
        public function ejecutarCambioNumFrecuente(entrada:EjecucionCambioNumFrecuentesSACDTO):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.ejecutarCambioNumFrecuente(entrada);
            _internal_token.addEventListener("result",_ejecutarCambioNumFrecuente_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#ejecutarCambioNumFrecuente_send()
		 */    
        public function ejecutarCambioNumFrecuente_send():AsyncToken
        {
        	return ejecutarCambioNumFrecuente(_ejecutarCambioNumFrecuente_request.entrada);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _ejecutarCambioNumFrecuente_request:EjecutarCambioNumFrecuente_request;
		/**
		 * @see IWSSEGPortal#ejecutarCambioNumFrecuente_request_var
		 */
		[Bindable]
		public function get ejecutarCambioNumFrecuente_request_var():EjecutarCambioNumFrecuente_request
		{
			return _ejecutarCambioNumFrecuente_request;
		}
		
		/**
		 * @private
		 */
		public function set ejecutarCambioNumFrecuente_request_var(request:EjecutarCambioNumFrecuente_request):void
		{
			_ejecutarCambioNumFrecuente_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _ejecutarCambioNumFrecuente_lastResult:EjecucionCambioNumFrecuentesSACDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#ejecutarCambioNumFrecuente_lastResult
		 */	  
		public function get ejecutarCambioNumFrecuente_lastResult():EjecucionCambioNumFrecuentesSACDTO
		{
			return _ejecutarCambioNumFrecuente_lastResult;
		}
		/**
		 * @private
		 */
		public function set ejecutarCambioNumFrecuente_lastResult(lastResult:EjecucionCambioNumFrecuentesSACDTO):void
		{
			_ejecutarCambioNumFrecuente_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addejecutarCambioNumFrecuente()
		 */
		public function addejecutarCambioNumFrecuenteEventListener(listener:Function):void
		{
			addEventListener(EjecutarCambioNumFrecuenteResultEvent.EjecutarCambioNumFrecuente_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _ejecutarCambioNumFrecuente_populate_results(event:ResultEvent):void
		{
			var e:EjecutarCambioNumFrecuenteResultEvent = new EjecutarCambioNumFrecuenteResultEvent();
		            e.result = event.result as EjecucionCambioNumFrecuentesSACDTO;
		                       e.headers = event.headers;
		             ejecutarCambioNumFrecuente_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the obtenerReportePresEquiInt operation
          

        /**
         * @see IWSSEGPortal#obtenerReportePresEquiInt()
         */
        public function obtenerReportePresEquiInt(fechaDesde:String,fechaHasta:String):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.obtenerReportePresEquiInt(fechaDesde,fechaHasta);
            _internal_token.addEventListener("result",_obtenerReportePresEquiInt_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#obtenerReportePresEquiInt_send()
		 */    
        public function obtenerReportePresEquiInt_send():AsyncToken
        {
        	return obtenerReportePresEquiInt(_obtenerReportePresEquiInt_request.fechaDesde,_obtenerReportePresEquiInt_request.fechaHasta);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _obtenerReportePresEquiInt_request:ObtenerReportePresEquiInt_request;
		/**
		 * @see IWSSEGPortal#obtenerReportePresEquiInt_request_var
		 */
		[Bindable]
		public function get obtenerReportePresEquiInt_request_var():ObtenerReportePresEquiInt_request
		{
			return _obtenerReportePresEquiInt_request;
		}
		
		/**
		 * @private
		 */
		public function set obtenerReportePresEquiInt_request_var(request:ObtenerReportePresEquiInt_request):void
		{
			_obtenerReportePresEquiInt_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _obtenerReportePresEquiInt_lastResult:ListadoReportePresEquiIntDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#obtenerReportePresEquiInt_lastResult
		 */	  
		public function get obtenerReportePresEquiInt_lastResult():ListadoReportePresEquiIntDTO
		{
			return _obtenerReportePresEquiInt_lastResult;
		}
		/**
		 * @private
		 */
		public function set obtenerReportePresEquiInt_lastResult(lastResult:ListadoReportePresEquiIntDTO):void
		{
			_obtenerReportePresEquiInt_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addobtenerReportePresEquiInt()
		 */
		public function addobtenerReportePresEquiIntEventListener(listener:Function):void
		{
			addEventListener(ObtenerReportePresEquiIntResultEvent.ObtenerReportePresEquiInt_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _obtenerReportePresEquiInt_populate_results(event:ResultEvent):void
		{
			var e:ObtenerReportePresEquiIntResultEvent = new ObtenerReportePresEquiIntResultEvent();
		            e.result = event.result as ListadoReportePresEquiIntDTO;
		                       e.headers = event.headers;
		             obtenerReportePresEquiInt_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the crearUsuario operation
          

        /**
         * @see IWSSEGPortal#crearUsuario()
         */
        public function crearUsuario(usuario:String,password:String,passwordConfirmada:String):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.crearUsuario(usuario,password,passwordConfirmada);
            _internal_token.addEventListener("result",_crearUsuario_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#crearUsuario_send()
		 */    
        public function crearUsuario_send():AsyncToken
        {
        	return crearUsuario(_crearUsuario_request.usuario,_crearUsuario_request.password,_crearUsuario_request.passwordConfirmada);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _crearUsuario_request:CrearUsuario_request;
		/**
		 * @see IWSSEGPortal#crearUsuario_request_var
		 */
		[Bindable]
		public function get crearUsuario_request_var():CrearUsuario_request
		{
			return _crearUsuario_request;
		}
		
		/**
		 * @private
		 */
		public function set crearUsuario_request_var(request:CrearUsuario_request):void
		{
			_crearUsuario_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _crearUsuario_lastResult:Boolean;
		[Bindable]
		/**
		 * @see IWSSEGPortal#crearUsuario_lastResult
		 */	  
		public function get crearUsuario_lastResult():Boolean
		{
			return _crearUsuario_lastResult;
		}
		/**
		 * @private
		 */
		public function set crearUsuario_lastResult(lastResult:Boolean):void
		{
			_crearUsuario_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addcrearUsuario()
		 */
		public function addcrearUsuarioEventListener(listener:Function):void
		{
			addEventListener(CrearUsuarioResultEvent.CrearUsuario_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _crearUsuario_populate_results(event:ResultEvent):void
		{
			var e:CrearUsuarioResultEvent = new CrearUsuarioResultEvent();
		            e.result = event.result as Boolean;
		                       e.headers = event.headers;
		             crearUsuario_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the obtenerListDatosAbonados operation
          

        /**
         * @see IWSSEGPortal#obtenerListDatosAbonados()
         */
        public function obtenerListDatosAbonados(codCliente:Number):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.obtenerListDatosAbonados(codCliente);
            _internal_token.addEventListener("result",_obtenerListDatosAbonados_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#obtenerListDatosAbonados_send()
		 */    
        public function obtenerListDatosAbonados_send():AsyncToken
        {
        	return obtenerListDatosAbonados(_obtenerListDatosAbonados_request.codCliente);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _obtenerListDatosAbonados_request:ObtenerListDatosAbonados_request;
		/**
		 * @see IWSSEGPortal#obtenerListDatosAbonados_request_var
		 */
		[Bindable]
		public function get obtenerListDatosAbonados_request_var():ObtenerListDatosAbonados_request
		{
			return _obtenerListDatosAbonados_request;
		}
		
		/**
		 * @private
		 */
		public function set obtenerListDatosAbonados_request_var(request:ObtenerListDatosAbonados_request):void
		{
			_obtenerListDatosAbonados_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _obtenerListDatosAbonados_lastResult:ListadoAbonadosDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#obtenerListDatosAbonados_lastResult
		 */	  
		public function get obtenerListDatosAbonados_lastResult():ListadoAbonadosDTO
		{
			return _obtenerListDatosAbonados_lastResult;
		}
		/**
		 * @private
		 */
		public function set obtenerListDatosAbonados_lastResult(lastResult:ListadoAbonadosDTO):void
		{
			_obtenerListDatosAbonados_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addobtenerListDatosAbonados()
		 */
		public function addobtenerListDatosAbonadosEventListener(listener:Function):void
		{
			addEventListener(ObtenerListDatosAbonadosResultEvent.ObtenerListDatosAbonados_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _obtenerListDatosAbonados_populate_results(event:ResultEvent):void
		{
			var e:ObtenerListDatosAbonadosResultEvent = new ObtenerListDatosAbonadosResultEvent();
		            e.result = event.result as ListadoAbonadosDTO;
		                       e.headers = event.headers;
		             obtenerListDatosAbonados_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the getDetalleAbonado operation
          

        /**
         * @see IWSSEGPortal#getDetalleAbonado()
         */
        public function getDetalleAbonado(numAbonado:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.getDetalleAbonado(numAbonado,nomUsuarioSCL,codEvento);
            _internal_token.addEventListener("result",_getDetalleAbonado_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#getDetalleAbonado_send()
		 */    
        public function getDetalleAbonado_send():AsyncToken
        {
        	return getDetalleAbonado(_getDetalleAbonado_request.numAbonado,_getDetalleAbonado_request.nomUsuarioSCL,_getDetalleAbonado_request.codEvento);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _getDetalleAbonado_request:GetDetalleAbonado_request;
		/**
		 * @see IWSSEGPortal#getDetalleAbonado_request_var
		 */
		[Bindable]
		public function get getDetalleAbonado_request_var():GetDetalleAbonado_request
		{
			return _getDetalleAbonado_request;
		}
		
		/**
		 * @private
		 */
		public function set getDetalleAbonado_request_var(request:GetDetalleAbonado_request):void
		{
			_getDetalleAbonado_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _getDetalleAbonado_lastResult:DetalleAbonadoDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#getDetalleAbonado_lastResult
		 */	  
		public function get getDetalleAbonado_lastResult():DetalleAbonadoDTO
		{
			return _getDetalleAbonado_lastResult;
		}
		/**
		 * @private
		 */
		public function set getDetalleAbonado_lastResult(lastResult:DetalleAbonadoDTO):void
		{
			_getDetalleAbonado_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addgetDetalleAbonado()
		 */
		public function addgetDetalleAbonadoEventListener(listener:Function):void
		{
			addEventListener(GetDetalleAbonadoResultEvent.GetDetalleAbonado_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _getDetalleAbonado_populate_results(event:ResultEvent):void
		{
			var e:GetDetalleAbonadoResultEvent = new GetDetalleAbonadoResultEvent();
		            e.result = event.result as DetalleAbonadoDTO;
		                       e.headers = event.headers;
		             getDetalleAbonado_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the productosXCodCliente operation
          

        /**
         * @see IWSSEGPortal#productosXCodCliente()
         */
        public function productosXCodCliente(codCliente:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.productosXCodCliente(codCliente,nomUsuarioSCL,codEvento);
            _internal_token.addEventListener("result",_productosXCodCliente_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#productosXCodCliente_send()
		 */    
        public function productosXCodCliente_send():AsyncToken
        {
        	return productosXCodCliente(_productosXCodCliente_request.codCliente,_productosXCodCliente_request.nomUsuarioSCL,_productosXCodCliente_request.codEvento);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _productosXCodCliente_request:ProductosXCodCliente_request;
		/**
		 * @see IWSSEGPortal#productosXCodCliente_request_var
		 */
		[Bindable]
		public function get productosXCodCliente_request_var():ProductosXCodCliente_request
		{
			return _productosXCodCliente_request;
		}
		
		/**
		 * @private
		 */
		public function set productosXCodCliente_request_var(request:ProductosXCodCliente_request):void
		{
			_productosXCodCliente_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _productosXCodCliente_lastResult:ListadoProductosDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#productosXCodCliente_lastResult
		 */	  
		public function get productosXCodCliente_lastResult():ListadoProductosDTO
		{
			return _productosXCodCliente_lastResult;
		}
		/**
		 * @private
		 */
		public function set productosXCodCliente_lastResult(lastResult:ListadoProductosDTO):void
		{
			_productosXCodCliente_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addproductosXCodCliente()
		 */
		public function addproductosXCodClienteEventListener(listener:Function):void
		{
			addEventListener(ProductosXCodClienteResultEvent.ProductosXCodCliente_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _productosXCodCliente_populate_results(event:ResultEvent):void
		{
			var e:ProductosXCodClienteResultEvent = new ProductosXCodClienteResultEvent();
		            e.result = event.result as ListadoProductosDTO;
		                       e.headers = event.headers;
		             productosXCodCliente_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the oossEjecutadasXCodCliente operation
          

        /**
         * @see IWSSEGPortal#oossEjecutadasXCodCliente()
         */
        public function oossEjecutadasXCodCliente(codCliente:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.oossEjecutadasXCodCliente(codCliente,nomUsuarioSCL,codEvento);
            _internal_token.addEventListener("result",_oossEjecutadasXCodCliente_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#oossEjecutadasXCodCliente_send()
		 */    
        public function oossEjecutadasXCodCliente_send():AsyncToken
        {
        	return oossEjecutadasXCodCliente(_oossEjecutadasXCodCliente_request.codCliente,_oossEjecutadasXCodCliente_request.nomUsuarioSCL,_oossEjecutadasXCodCliente_request.codEvento);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _oossEjecutadasXCodCliente_request:OossEjecutadasXCodCliente_request;
		/**
		 * @see IWSSEGPortal#oossEjecutadasXCodCliente_request_var
		 */
		[Bindable]
		public function get oossEjecutadasXCodCliente_request_var():OossEjecutadasXCodCliente_request
		{
			return _oossEjecutadasXCodCliente_request;
		}
		
		/**
		 * @private
		 */
		public function set oossEjecutadasXCodCliente_request_var(request:OossEjecutadasXCodCliente_request):void
		{
			_oossEjecutadasXCodCliente_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _oossEjecutadasXCodCliente_lastResult:ListadoOrdenesServicioDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#oossEjecutadasXCodCliente_lastResult
		 */	  
		public function get oossEjecutadasXCodCliente_lastResult():ListadoOrdenesServicioDTO
		{
			return _oossEjecutadasXCodCliente_lastResult;
		}
		/**
		 * @private
		 */
		public function set oossEjecutadasXCodCliente_lastResult(lastResult:ListadoOrdenesServicioDTO):void
		{
			_oossEjecutadasXCodCliente_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addoossEjecutadasXCodCliente()
		 */
		public function addoossEjecutadasXCodClienteEventListener(listener:Function):void
		{
			addEventListener(OossEjecutadasXCodClienteResultEvent.OossEjecutadasXCodCliente_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _oossEjecutadasXCodCliente_populate_results(event:ResultEvent):void
		{
			var e:OossEjecutadasXCodClienteResultEvent = new OossEjecutadasXCodClienteResultEvent();
		            e.result = event.result as ListadoOrdenesServicioDTO;
		                       e.headers = event.headers;
		             oossEjecutadasXCodCliente_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the productosXNumAbonado operation
          

        /**
         * @see IWSSEGPortal#productosXNumAbonado()
         */
        public function productosXNumAbonado(numAbonado:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.productosXNumAbonado(numAbonado,nomUsuarioSCL,codEvento);
            _internal_token.addEventListener("result",_productosXNumAbonado_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#productosXNumAbonado_send()
		 */    
        public function productosXNumAbonado_send():AsyncToken
        {
        	return productosXNumAbonado(_productosXNumAbonado_request.numAbonado,_productosXNumAbonado_request.nomUsuarioSCL,_productosXNumAbonado_request.codEvento);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _productosXNumAbonado_request:ProductosXNumAbonado_request;
		/**
		 * @see IWSSEGPortal#productosXNumAbonado_request_var
		 */
		[Bindable]
		public function get productosXNumAbonado_request_var():ProductosXNumAbonado_request
		{
			return _productosXNumAbonado_request;
		}
		
		/**
		 * @private
		 */
		public function set productosXNumAbonado_request_var(request:ProductosXNumAbonado_request):void
		{
			_productosXNumAbonado_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _productosXNumAbonado_lastResult:ListadoProductosDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#productosXNumAbonado_lastResult
		 */	  
		public function get productosXNumAbonado_lastResult():ListadoProductosDTO
		{
			return _productosXNumAbonado_lastResult;
		}
		/**
		 * @private
		 */
		public function set productosXNumAbonado_lastResult(lastResult:ListadoProductosDTO):void
		{
			_productosXNumAbonado_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addproductosXNumAbonado()
		 */
		public function addproductosXNumAbonadoEventListener(listener:Function):void
		{
			addEventListener(ProductosXNumAbonadoResultEvent.ProductosXNumAbonado_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _productosXNumAbonado_populate_results(event:ResultEvent):void
		{
			var e:ProductosXNumAbonadoResultEvent = new ProductosXNumAbonadoResultEvent();
		            e.result = event.result as ListadoProductosDTO;
		                       e.headers = event.headers;
		             productosXNumAbonado_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the cargaValidaOSUsuario operation
          

        /**
         * @see IWSSEGPortal#cargaValidaOSUsuario()
         */
        public function cargaValidaOSUsuario(usuario:String):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.cargaValidaOSUsuario(usuario);
            _internal_token.addEventListener("result",_cargaValidaOSUsuario_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#cargaValidaOSUsuario_send()
		 */    
        public function cargaValidaOSUsuario_send():AsyncToken
        {
        	return cargaValidaOSUsuario(_cargaValidaOSUsuario_request.usuario);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _cargaValidaOSUsuario_request:CargaValidaOSUsuario_request;
		/**
		 * @see IWSSEGPortal#cargaValidaOSUsuario_request_var
		 */
		[Bindable]
		public function get cargaValidaOSUsuario_request_var():CargaValidaOSUsuario_request
		{
			return _cargaValidaOSUsuario_request;
		}
		
		/**
		 * @private
		 */
		public function set cargaValidaOSUsuario_request_var(request:CargaValidaOSUsuario_request):void
		{
			_cargaValidaOSUsuario_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _cargaValidaOSUsuario_lastResult:MenuDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#cargaValidaOSUsuario_lastResult
		 */	  
		public function get cargaValidaOSUsuario_lastResult():MenuDTO
		{
			return _cargaValidaOSUsuario_lastResult;
		}
		/**
		 * @private
		 */
		public function set cargaValidaOSUsuario_lastResult(lastResult:MenuDTO):void
		{
			_cargaValidaOSUsuario_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addcargaValidaOSUsuario()
		 */
		public function addcargaValidaOSUsuarioEventListener(listener:Function):void
		{
			addEventListener(CargaValidaOSUsuarioResultEvent.CargaValidaOSUsuario_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _cargaValidaOSUsuario_populate_results(event:ResultEvent):void
		{
			var e:CargaValidaOSUsuarioResultEvent = new CargaValidaOSUsuarioResultEvent();
		            e.result = event.result as MenuDTO;
		                       e.headers = event.headers;
		             cargaValidaOSUsuario_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the cargarCambioSIMCard operation
          

        /**
         * @see IWSSEGPortal#cargarCambioSIMCard()
         */
        public function cargarCambioSIMCard(numAbonado:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.cargarCambioSIMCard(numAbonado,nomUsuarioSCL,codEvento);
            _internal_token.addEventListener("result",_cargarCambioSIMCard_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#cargarCambioSIMCard_send()
		 */    
        public function cargarCambioSIMCard_send():AsyncToken
        {
        	return cargarCambioSIMCard(_cargarCambioSIMCard_request.numAbonado,_cargarCambioSIMCard_request.nomUsuarioSCL,_cargarCambioSIMCard_request.codEvento);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _cargarCambioSIMCard_request:CargarCambioSIMCard_request;
		/**
		 * @see IWSSEGPortal#cargarCambioSIMCard_request_var
		 */
		[Bindable]
		public function get cargarCambioSIMCard_request_var():CargarCambioSIMCard_request
		{
			return _cargarCambioSIMCard_request;
		}
		
		/**
		 * @private
		 */
		public function set cargarCambioSIMCard_request_var(request:CargarCambioSIMCard_request):void
		{
			_cargarCambioSIMCard_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _cargarCambioSIMCard_lastResult:CargaCambioSIMCardDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#cargarCambioSIMCard_lastResult
		 */	  
		public function get cargarCambioSIMCard_lastResult():CargaCambioSIMCardDTO
		{
			return _cargarCambioSIMCard_lastResult;
		}
		/**
		 * @private
		 */
		public function set cargarCambioSIMCard_lastResult(lastResult:CargaCambioSIMCardDTO):void
		{
			_cargarCambioSIMCard_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addcargarCambioSIMCard()
		 */
		public function addcargarCambioSIMCardEventListener(listener:Function):void
		{
			addEventListener(CargarCambioSIMCardResultEvent.CargarCambioSIMCard_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _cargarCambioSIMCard_populate_results(event:ResultEvent):void
		{
			var e:CargarCambioSIMCardResultEvent = new CargarCambioSIMCardResultEvent();
		            e.result = event.result as CargaCambioSIMCardDTO;
		                       e.headers = event.headers;
		             cargarCambioSIMCard_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the obtenerReporteCambioEquiGene operation
          

        /**
         * @see IWSSEGPortal#obtenerReporteCambioEquiGene()
         */
        public function obtenerReporteCambioEquiGene(fechaDesde:String,fechaHasta:String,codCausalCam:String):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.obtenerReporteCambioEquiGene(fechaDesde,fechaHasta,codCausalCam);
            _internal_token.addEventListener("result",_obtenerReporteCambioEquiGene_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#obtenerReporteCambioEquiGene_send()
		 */    
        public function obtenerReporteCambioEquiGene_send():AsyncToken
        {
        	return obtenerReporteCambioEquiGene(_obtenerReporteCambioEquiGene_request.fechaDesde,_obtenerReporteCambioEquiGene_request.fechaHasta,_obtenerReporteCambioEquiGene_request.codCausalCam);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _obtenerReporteCambioEquiGene_request:ObtenerReporteCambioEquiGene_request;
		/**
		 * @see IWSSEGPortal#obtenerReporteCambioEquiGene_request_var
		 */
		[Bindable]
		public function get obtenerReporteCambioEquiGene_request_var():ObtenerReporteCambioEquiGene_request
		{
			return _obtenerReporteCambioEquiGene_request;
		}
		
		/**
		 * @private
		 */
		public function set obtenerReporteCambioEquiGene_request_var(request:ObtenerReporteCambioEquiGene_request):void
		{
			_obtenerReporteCambioEquiGene_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _obtenerReporteCambioEquiGene_lastResult:ListadoReporteCamEquiGenDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#obtenerReporteCambioEquiGene_lastResult
		 */	  
		public function get obtenerReporteCambioEquiGene_lastResult():ListadoReporteCamEquiGenDTO
		{
			return _obtenerReporteCambioEquiGene_lastResult;
		}
		/**
		 * @private
		 */
		public function set obtenerReporteCambioEquiGene_lastResult(lastResult:ListadoReporteCamEquiGenDTO):void
		{
			_obtenerReporteCambioEquiGene_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addobtenerReporteCambioEquiGene()
		 */
		public function addobtenerReporteCambioEquiGeneEventListener(listener:Function):void
		{
			addEventListener(ObtenerReporteCambioEquiGeneResultEvent.ObtenerReporteCambioEquiGene_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _obtenerReporteCambioEquiGene_populate_results(event:ResultEvent):void
		{
			var e:ObtenerReporteCambioEquiGeneResultEvent = new ObtenerReporteCambioEquiGeneResultEvent();
		            e.result = event.result as ListadoReporteCamEquiGenDTO;
		                       e.headers = event.headers;
		             obtenerReporteCambioEquiGene_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the obtenerDatosAbonado operation
          

        /**
         * @see IWSSEGPortal#obtenerDatosAbonado()
         */
        public function obtenerDatosAbonado(numAbonado:Number):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.obtenerDatosAbonado(numAbonado);
            _internal_token.addEventListener("result",_obtenerDatosAbonado_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#obtenerDatosAbonado_send()
		 */    
        public function obtenerDatosAbonado_send():AsyncToken
        {
        	return obtenerDatosAbonado(_obtenerDatosAbonado_request.numAbonado);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _obtenerDatosAbonado_request:ObtenerDatosAbonado_request;
		/**
		 * @see IWSSEGPortal#obtenerDatosAbonado_request_var
		 */
		[Bindable]
		public function get obtenerDatosAbonado_request_var():ObtenerDatosAbonado_request
		{
			return _obtenerDatosAbonado_request;
		}
		
		/**
		 * @private
		 */
		public function set obtenerDatosAbonado_request_var(request:ObtenerDatosAbonado_request):void
		{
			_obtenerDatosAbonado_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _obtenerDatosAbonado_lastResult:AbonadoDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#obtenerDatosAbonado_lastResult
		 */	  
		public function get obtenerDatosAbonado_lastResult():AbonadoDTO
		{
			return _obtenerDatosAbonado_lastResult;
		}
		/**
		 * @private
		 */
		public function set obtenerDatosAbonado_lastResult(lastResult:AbonadoDTO):void
		{
			_obtenerDatosAbonado_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addobtenerDatosAbonado()
		 */
		public function addobtenerDatosAbonadoEventListener(listener:Function):void
		{
			addEventListener(ObtenerDatosAbonadoResultEvent.ObtenerDatosAbonado_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _obtenerDatosAbonado_populate_results(event:ResultEvent):void
		{
			var e:ObtenerDatosAbonadoResultEvent = new ObtenerDatosAbonadoResultEvent();
		            e.result = event.result as AbonadoDTO;
		                       e.headers = event.headers;
		             obtenerDatosAbonado_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the umtsAbonadosXCodCliente operation
          

        /**
         * @see IWSSEGPortal#umtsAbonadosXCodCliente()
         */
        public function umtsAbonadosXCodCliente(codCliente:Number):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.umtsAbonadosXCodCliente(codCliente);
            _internal_token.addEventListener("result",_umtsAbonadosXCodCliente_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#umtsAbonadosXCodCliente_send()
		 */    
        public function umtsAbonadosXCodCliente_send():AsyncToken
        {
        	return umtsAbonadosXCodCliente(_umtsAbonadosXCodCliente_request.codCliente);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _umtsAbonadosXCodCliente_request:UmtsAbonadosXCodCliente_request;
		/**
		 * @see IWSSEGPortal#umtsAbonadosXCodCliente_request_var
		 */
		[Bindable]
		public function get umtsAbonadosXCodCliente_request_var():UmtsAbonadosXCodCliente_request
		{
			return _umtsAbonadosXCodCliente_request;
		}
		
		/**
		 * @private
		 */
		public function set umtsAbonadosXCodCliente_request_var(request:UmtsAbonadosXCodCliente_request):void
		{
			_umtsAbonadosXCodCliente_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _umtsAbonadosXCodCliente_lastResult:ListadoUmtsAbonadosDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#umtsAbonadosXCodCliente_lastResult
		 */	  
		public function get umtsAbonadosXCodCliente_lastResult():ListadoUmtsAbonadosDTO
		{
			return _umtsAbonadosXCodCliente_lastResult;
		}
		/**
		 * @private
		 */
		public function set umtsAbonadosXCodCliente_lastResult(lastResult:ListadoUmtsAbonadosDTO):void
		{
			_umtsAbonadosXCodCliente_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addumtsAbonadosXCodCliente()
		 */
		public function addumtsAbonadosXCodClienteEventListener(listener:Function):void
		{
			addEventListener(UmtsAbonadosXCodClienteResultEvent.UmtsAbonadosXCodCliente_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _umtsAbonadosXCodCliente_populate_results(event:ResultEvent):void
		{
			var e:UmtsAbonadosXCodClienteResultEvent = new UmtsAbonadosXCodClienteResultEvent();
		            e.result = event.result as ListadoUmtsAbonadosDTO;
		                       e.headers = event.headers;
		             umtsAbonadosXCodCliente_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the cargarAjusteCExcepcionCargos operation
          

        /**
         * @see IWSSEGPortal#cargarAjusteCExcepcionCargos()
         */
        public function cargarAjusteCExcepcionCargos(codCliente:Number,nomUsuarioSCL:String,pwd:String,codEvento:String):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.cargarAjusteCExcepcionCargos(codCliente,nomUsuarioSCL,pwd,codEvento);
            _internal_token.addEventListener("result",_cargarAjusteCExcepcionCargos_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#cargarAjusteCExcepcionCargos_send()
		 */    
        public function cargarAjusteCExcepcionCargos_send():AsyncToken
        {
        	return cargarAjusteCExcepcionCargos(_cargarAjusteCExcepcionCargos_request.codCliente,_cargarAjusteCExcepcionCargos_request.nomUsuarioSCL,_cargarAjusteCExcepcionCargos_request.pwd,_cargarAjusteCExcepcionCargos_request.codEvento);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _cargarAjusteCExcepcionCargos_request:CargarAjusteCExcepcionCargos_request;
		/**
		 * @see IWSSEGPortal#cargarAjusteCExcepcionCargos_request_var
		 */
		[Bindable]
		public function get cargarAjusteCExcepcionCargos_request_var():CargarAjusteCExcepcionCargos_request
		{
			return _cargarAjusteCExcepcionCargos_request;
		}
		
		/**
		 * @private
		 */
		public function set cargarAjusteCExcepcionCargos_request_var(request:CargarAjusteCExcepcionCargos_request):void
		{
			_cargarAjusteCExcepcionCargos_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _cargarAjusteCExcepcionCargos_lastResult:CargaAjusteCExcepcionCargosSACDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#cargarAjusteCExcepcionCargos_lastResult
		 */	  
		public function get cargarAjusteCExcepcionCargos_lastResult():CargaAjusteCExcepcionCargosSACDTO
		{
			return _cargarAjusteCExcepcionCargos_lastResult;
		}
		/**
		 * @private
		 */
		public function set cargarAjusteCExcepcionCargos_lastResult(lastResult:CargaAjusteCExcepcionCargosSACDTO):void
		{
			_cargarAjusteCExcepcionCargos_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addcargarAjusteCExcepcionCargos()
		 */
		public function addcargarAjusteCExcepcionCargosEventListener(listener:Function):void
		{
			addEventListener(CargarAjusteCExcepcionCargosResultEvent.CargarAjusteCExcepcionCargos_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _cargarAjusteCExcepcionCargos_populate_results(event:ResultEvent):void
		{
			var e:CargarAjusteCExcepcionCargosResultEvent = new CargarAjusteCExcepcionCargosResultEvent();
		            e.result = event.result as CargaAjusteCExcepcionCargosSACDTO;
		                       e.headers = event.headers;
		             cargarAjusteCExcepcionCargos_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the obtenerDatosDireccionCliente operation
          

        /**
         * @see IWSSEGPortal#obtenerDatosDireccionCliente()
         */
        public function obtenerDatosDireccionCliente(pIn:DatosDireccionClienteINDTO):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.obtenerDatosDireccionCliente(pIn);
            _internal_token.addEventListener("result",_obtenerDatosDireccionCliente_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#obtenerDatosDireccionCliente_send()
		 */    
        public function obtenerDatosDireccionCliente_send():AsyncToken
        {
        	return obtenerDatosDireccionCliente(_obtenerDatosDireccionCliente_request.pIn);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _obtenerDatosDireccionCliente_request:ObtenerDatosDireccionCliente_request;
		/**
		 * @see IWSSEGPortal#obtenerDatosDireccionCliente_request_var
		 */
		[Bindable]
		public function get obtenerDatosDireccionCliente_request_var():ObtenerDatosDireccionCliente_request
		{
			return _obtenerDatosDireccionCliente_request;
		}
		
		/**
		 * @private
		 */
		public function set obtenerDatosDireccionCliente_request_var(request:ObtenerDatosDireccionCliente_request):void
		{
			_obtenerDatosDireccionCliente_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _obtenerDatosDireccionCliente_lastResult:DireccionPorClienteDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#obtenerDatosDireccionCliente_lastResult
		 */	  
		public function get obtenerDatosDireccionCliente_lastResult():DireccionPorClienteDTO
		{
			return _obtenerDatosDireccionCliente_lastResult;
		}
		/**
		 * @private
		 */
		public function set obtenerDatosDireccionCliente_lastResult(lastResult:DireccionPorClienteDTO):void
		{
			_obtenerDatosDireccionCliente_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addobtenerDatosDireccionCliente()
		 */
		public function addobtenerDatosDireccionClienteEventListener(listener:Function):void
		{
			addEventListener(ObtenerDatosDireccionClienteResultEvent.ObtenerDatosDireccionCliente_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _obtenerDatosDireccionCliente_populate_results(event:ResultEvent):void
		{
			var e:ObtenerDatosDireccionClienteResultEvent = new ObtenerDatosDireccionClienteResultEvent();
		            e.result = event.result as DireccionPorClienteDTO;
		                       e.headers = event.headers;
		             obtenerDatosDireccionCliente_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the ejecutarAbonoLimiteConsumoSS operation
          

        /**
         * @see IWSSEGPortal#ejecutarAbonoLimiteConsumoSS()
         */
        public function ejecutarAbonoLimiteConsumoSS(entrada:EjecucionAbonoLimiteConsumoServicioSuplementarioDTO):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.ejecutarAbonoLimiteConsumoSS(entrada);
            _internal_token.addEventListener("result",_ejecutarAbonoLimiteConsumoSS_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#ejecutarAbonoLimiteConsumoSS_send()
		 */    
        public function ejecutarAbonoLimiteConsumoSS_send():AsyncToken
        {
        	return ejecutarAbonoLimiteConsumoSS(_ejecutarAbonoLimiteConsumoSS_request.entrada);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _ejecutarAbonoLimiteConsumoSS_request:EjecutarAbonoLimiteConsumoSS_request;
		/**
		 * @see IWSSEGPortal#ejecutarAbonoLimiteConsumoSS_request_var
		 */
		[Bindable]
		public function get ejecutarAbonoLimiteConsumoSS_request_var():EjecutarAbonoLimiteConsumoSS_request
		{
			return _ejecutarAbonoLimiteConsumoSS_request;
		}
		
		/**
		 * @private
		 */
		public function set ejecutarAbonoLimiteConsumoSS_request_var(request:EjecutarAbonoLimiteConsumoSS_request):void
		{
			_ejecutarAbonoLimiteConsumoSS_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _ejecutarAbonoLimiteConsumoSS_lastResult:EjecucionAbonoLimiteConsumoServicioSuplementarioDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#ejecutarAbonoLimiteConsumoSS_lastResult
		 */	  
		public function get ejecutarAbonoLimiteConsumoSS_lastResult():EjecucionAbonoLimiteConsumoServicioSuplementarioDTO
		{
			return _ejecutarAbonoLimiteConsumoSS_lastResult;
		}
		/**
		 * @private
		 */
		public function set ejecutarAbonoLimiteConsumoSS_lastResult(lastResult:EjecucionAbonoLimiteConsumoServicioSuplementarioDTO):void
		{
			_ejecutarAbonoLimiteConsumoSS_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addejecutarAbonoLimiteConsumoSS()
		 */
		public function addejecutarAbonoLimiteConsumoSSEventListener(listener:Function):void
		{
			addEventListener(EjecutarAbonoLimiteConsumoSSResultEvent.EjecutarAbonoLimiteConsumoSS_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _ejecutarAbonoLimiteConsumoSS_populate_results(event:ResultEvent):void
		{
			var e:EjecutarAbonoLimiteConsumoSSResultEvent = new EjecutarAbonoLimiteConsumoSSResultEvent();
		            e.result = event.result as EjecucionAbonoLimiteConsumoServicioSuplementarioDTO;
		                       e.headers = event.headers;
		             ejecutarAbonoLimiteConsumoSS_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the ejecucionCambioDatosCliente operation
          

        /**
         * @see IWSSEGPortal#ejecucionCambioDatosCliente()
         */
        public function ejecucionCambioDatosCliente(entrada:EjecucionCambioDatosClienteSACDTO):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.ejecucionCambioDatosCliente(entrada);
            _internal_token.addEventListener("result",_ejecucionCambioDatosCliente_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#ejecucionCambioDatosCliente_send()
		 */    
        public function ejecucionCambioDatosCliente_send():AsyncToken
        {
        	return ejecucionCambioDatosCliente(_ejecucionCambioDatosCliente_request.entrada);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _ejecucionCambioDatosCliente_request:EjecucionCambioDatosCliente_request;
		/**
		 * @see IWSSEGPortal#ejecucionCambioDatosCliente_request_var
		 */
		[Bindable]
		public function get ejecucionCambioDatosCliente_request_var():EjecucionCambioDatosCliente_request
		{
			return _ejecucionCambioDatosCliente_request;
		}
		
		/**
		 * @private
		 */
		public function set ejecucionCambioDatosCliente_request_var(request:EjecucionCambioDatosCliente_request):void
		{
			_ejecucionCambioDatosCliente_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _ejecucionCambioDatosCliente_lastResult:EjecucionCambioDatosClienteSACDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#ejecucionCambioDatosCliente_lastResult
		 */	  
		public function get ejecucionCambioDatosCliente_lastResult():EjecucionCambioDatosClienteSACDTO
		{
			return _ejecucionCambioDatosCliente_lastResult;
		}
		/**
		 * @private
		 */
		public function set ejecucionCambioDatosCliente_lastResult(lastResult:EjecucionCambioDatosClienteSACDTO):void
		{
			_ejecucionCambioDatosCliente_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addejecucionCambioDatosCliente()
		 */
		public function addejecucionCambioDatosClienteEventListener(listener:Function):void
		{
			addEventListener(EjecucionCambioDatosClienteResultEvent.EjecucionCambioDatosCliente_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _ejecucionCambioDatosCliente_populate_results(event:ResultEvent):void
		{
			var e:EjecucionCambioDatosClienteResultEvent = new EjecucionCambioDatosClienteResultEvent();
		            e.result = event.result as EjecucionCambioDatosClienteSACDTO;
		                       e.headers = event.headers;
		             ejecucionCambioDatosCliente_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the consultasXCodGrupo operation
          

        /**
         * @see IWSSEGPortal#consultasXCodGrupo()
         */
        public function consultasXCodGrupo(codGrupo:String,codPrograma:String,numVersion:String):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.consultasXCodGrupo(codGrupo,codPrograma,numVersion);
            _internal_token.addEventListener("result",_consultasXCodGrupo_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#consultasXCodGrupo_send()
		 */    
        public function consultasXCodGrupo_send():AsyncToken
        {
        	return consultasXCodGrupo(_consultasXCodGrupo_request.codGrupo,_consultasXCodGrupo_request.codPrograma,_consultasXCodGrupo_request.numVersion);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _consultasXCodGrupo_request:ConsultasXCodGrupo_request;
		/**
		 * @see IWSSEGPortal#consultasXCodGrupo_request_var
		 */
		[Bindable]
		public function get consultasXCodGrupo_request_var():ConsultasXCodGrupo_request
		{
			return _consultasXCodGrupo_request;
		}
		
		/**
		 * @private
		 */
		public function set consultasXCodGrupo_request_var(request:ConsultasXCodGrupo_request):void
		{
			_consultasXCodGrupo_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _consultasXCodGrupo_lastResult:ListadoConsultasDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#consultasXCodGrupo_lastResult
		 */	  
		public function get consultasXCodGrupo_lastResult():ListadoConsultasDTO
		{
			return _consultasXCodGrupo_lastResult;
		}
		/**
		 * @private
		 */
		public function set consultasXCodGrupo_lastResult(lastResult:ListadoConsultasDTO):void
		{
			_consultasXCodGrupo_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addconsultasXCodGrupo()
		 */
		public function addconsultasXCodGrupoEventListener(listener:Function):void
		{
			addEventListener(ConsultasXCodGrupoResultEvent.ConsultasXCodGrupo_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _consultasXCodGrupo_populate_results(event:ResultEvent):void
		{
			var e:ConsultasXCodGrupoResultEvent = new ConsultasXCodGrupoResultEvent();
		            e.result = event.result as ListadoConsultasDTO;
		                       e.headers = event.headers;
		             consultasXCodGrupo_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the cargarSuspensionSrvCelular operation
          

        /**
         * @see IWSSEGPortal#cargarSuspensionSrvCelular()
         */
        public function cargarSuspensionSrvCelular(numAbonado:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.cargarSuspensionSrvCelular(numAbonado,nomUsuarioSCL,codEvento);
            _internal_token.addEventListener("result",_cargarSuspensionSrvCelular_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#cargarSuspensionSrvCelular_send()
		 */    
        public function cargarSuspensionSrvCelular_send():AsyncToken
        {
        	return cargarSuspensionSrvCelular(_cargarSuspensionSrvCelular_request.numAbonado,_cargarSuspensionSrvCelular_request.nomUsuarioSCL,_cargarSuspensionSrvCelular_request.codEvento);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _cargarSuspensionSrvCelular_request:CargarSuspensionSrvCelular_request;
		/**
		 * @see IWSSEGPortal#cargarSuspensionSrvCelular_request_var
		 */
		[Bindable]
		public function get cargarSuspensionSrvCelular_request_var():CargarSuspensionSrvCelular_request
		{
			return _cargarSuspensionSrvCelular_request;
		}
		
		/**
		 * @private
		 */
		public function set cargarSuspensionSrvCelular_request_var(request:CargarSuspensionSrvCelular_request):void
		{
			_cargarSuspensionSrvCelular_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _cargarSuspensionSrvCelular_lastResult:CargaSuspensionSrvCelDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#cargarSuspensionSrvCelular_lastResult
		 */	  
		public function get cargarSuspensionSrvCelular_lastResult():CargaSuspensionSrvCelDTO
		{
			return _cargarSuspensionSrvCelular_lastResult;
		}
		/**
		 * @private
		 */
		public function set cargarSuspensionSrvCelular_lastResult(lastResult:CargaSuspensionSrvCelDTO):void
		{
			_cargarSuspensionSrvCelular_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addcargarSuspensionSrvCelular()
		 */
		public function addcargarSuspensionSrvCelularEventListener(listener:Function):void
		{
			addEventListener(CargarSuspensionSrvCelularResultEvent.CargarSuspensionSrvCelular_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _cargarSuspensionSrvCelular_populate_results(event:ResultEvent):void
		{
			var e:CargarSuspensionSrvCelularResultEvent = new CargarSuspensionSrvCelularResultEvent();
		            e.result = event.result as CargaSuspensionSrvCelDTO;
		                       e.headers = event.headers;
		             cargarSuspensionSrvCelular_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the getDetalleCliente operation
          

        /**
         * @see IWSSEGPortal#getDetalleCliente()
         */
        public function getDetalleCliente(codCliente:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.getDetalleCliente(codCliente,nomUsuarioSCL,codEvento);
            _internal_token.addEventListener("result",_getDetalleCliente_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#getDetalleCliente_send()
		 */    
        public function getDetalleCliente_send():AsyncToken
        {
        	return getDetalleCliente(_getDetalleCliente_request.codCliente,_getDetalleCliente_request.nomUsuarioSCL,_getDetalleCliente_request.codEvento);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _getDetalleCliente_request:GetDetalleCliente_request;
		/**
		 * @see IWSSEGPortal#getDetalleCliente_request_var
		 */
		[Bindable]
		public function get getDetalleCliente_request_var():GetDetalleCliente_request
		{
			return _getDetalleCliente_request;
		}
		
		/**
		 * @private
		 */
		public function set getDetalleCliente_request_var(request:GetDetalleCliente_request):void
		{
			_getDetalleCliente_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _getDetalleCliente_lastResult:DetalleClienteDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#getDetalleCliente_lastResult
		 */	  
		public function get getDetalleCliente_lastResult():DetalleClienteDTO
		{
			return _getDetalleCliente_lastResult;
		}
		/**
		 * @private
		 */
		public function set getDetalleCliente_lastResult(lastResult:DetalleClienteDTO):void
		{
			_getDetalleCliente_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addgetDetalleCliente()
		 */
		public function addgetDetalleClienteEventListener(listener:Function):void
		{
			addEventListener(GetDetalleClienteResultEvent.GetDetalleCliente_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _getDetalleCliente_populate_results(event:ResultEvent):void
		{
			var e:GetDetalleClienteResultEvent = new GetDetalleClienteResultEvent();
		            e.result = event.result as DetalleClienteDTO;
		                       e.headers = event.headers;
		             getDetalleCliente_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the getDetalleEquipo operation
          

        /**
         * @see IWSSEGPortal#getDetalleEquipo()
         */
        public function getDetalleEquipo(numAbonado:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.getDetalleEquipo(numAbonado,nomUsuarioSCL,codEvento);
            _internal_token.addEventListener("result",_getDetalleEquipo_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#getDetalleEquipo_send()
		 */    
        public function getDetalleEquipo_send():AsyncToken
        {
        	return getDetalleEquipo(_getDetalleEquipo_request.numAbonado,_getDetalleEquipo_request.nomUsuarioSCL,_getDetalleEquipo_request.codEvento);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _getDetalleEquipo_request:GetDetalleEquipo_request;
		/**
		 * @see IWSSEGPortal#getDetalleEquipo_request_var
		 */
		[Bindable]
		public function get getDetalleEquipo_request_var():GetDetalleEquipo_request
		{
			return _getDetalleEquipo_request;
		}
		
		/**
		 * @private
		 */
		public function set getDetalleEquipo_request_var(request:GetDetalleEquipo_request):void
		{
			_getDetalleEquipo_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _getDetalleEquipo_lastResult:EquipoSimcardDetalleDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#getDetalleEquipo_lastResult
		 */	  
		public function get getDetalleEquipo_lastResult():EquipoSimcardDetalleDTO
		{
			return _getDetalleEquipo_lastResult;
		}
		/**
		 * @private
		 */
		public function set getDetalleEquipo_lastResult(lastResult:EquipoSimcardDetalleDTO):void
		{
			_getDetalleEquipo_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addgetDetalleEquipo()
		 */
		public function addgetDetalleEquipoEventListener(listener:Function):void
		{
			addEventListener(GetDetalleEquipoResultEvent.GetDetalleEquipo_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _getDetalleEquipo_populate_results(event:ResultEvent):void
		{
			var e:GetDetalleEquipoResultEvent = new GetDetalleEquipoResultEvent();
		            e.result = event.result as EquipoSimcardDetalleDTO;
		                       e.headers = event.headers;
		             getDetalleEquipo_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the getDeudaCliente operation
          

        /**
         * @see IWSSEGPortal#getDeudaCliente()
         */
        public function getDeudaCliente(codCliente:Number):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.getDeudaCliente(codCliente);
            _internal_token.addEventListener("result",_getDeudaCliente_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#getDeudaCliente_send()
		 */    
        public function getDeudaCliente_send():AsyncToken
        {
        	return getDeudaCliente(_getDeudaCliente_request.codCliente);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _getDeudaCliente_request:GetDeudaCliente_request;
		/**
		 * @see IWSSEGPortal#getDeudaCliente_request_var
		 */
		[Bindable]
		public function get getDeudaCliente_request_var():GetDeudaCliente_request
		{
			return _getDeudaCliente_request;
		}
		
		/**
		 * @private
		 */
		public function set getDeudaCliente_request_var(request:GetDeudaCliente_request):void
		{
			_getDeudaCliente_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _getDeudaCliente_lastResult:DeudaClienteDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#getDeudaCliente_lastResult
		 */	  
		public function get getDeudaCliente_lastResult():DeudaClienteDTO
		{
			return _getDeudaCliente_lastResult;
		}
		/**
		 * @private
		 */
		public function set getDeudaCliente_lastResult(lastResult:DeudaClienteDTO):void
		{
			_getDeudaCliente_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addgetDeudaCliente()
		 */
		public function addgetDeudaClienteEventListener(listener:Function):void
		{
			addEventListener(GetDeudaClienteResultEvent.GetDeudaCliente_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _getDeudaCliente_populate_results(event:ResultEvent):void
		{
			var e:GetDeudaClienteResultEvent = new GetDeudaClienteResultEvent();
		            e.result = event.result as DeudaClienteDTO;
		                       e.headers = event.headers;
		             getDeudaCliente_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the consultaCuenta operation
          

        /**
         * @see IWSSEGPortal#consultaCuenta()
         */
        public function consultaCuenta(codCuenta:Number):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.consultaCuenta(codCuenta);
            _internal_token.addEventListener("result",_consultaCuenta_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#consultaCuenta_send()
		 */    
        public function consultaCuenta_send():AsyncToken
        {
        	return consultaCuenta(_consultaCuenta_request.codCuenta);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _consultaCuenta_request:ConsultaCuenta_request;
		/**
		 * @see IWSSEGPortal#consultaCuenta_request_var
		 */
		[Bindable]
		public function get consultaCuenta_request_var():ConsultaCuenta_request
		{
			return _consultaCuenta_request;
		}
		
		/**
		 * @private
		 */
		public function set consultaCuenta_request_var(request:ConsultaCuenta_request):void
		{
			_consultaCuenta_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _consultaCuenta_lastResult:ListadoAbonadosDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#consultaCuenta_lastResult
		 */	  
		public function get consultaCuenta_lastResult():ListadoAbonadosDTO
		{
			return _consultaCuenta_lastResult;
		}
		/**
		 * @private
		 */
		public function set consultaCuenta_lastResult(lastResult:ListadoAbonadosDTO):void
		{
			_consultaCuenta_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addconsultaCuenta()
		 */
		public function addconsultaCuentaEventListener(listener:Function):void
		{
			addEventListener(ConsultaCuentaResultEvent.ConsultaCuenta_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _consultaCuenta_populate_results(event:ResultEvent):void
		{
			var e:ConsultaCuentaResultEvent = new ConsultaCuentaResultEvent();
		            e.result = event.result as ListadoAbonadosDTO;
		                       e.headers = event.headers;
		             consultaCuenta_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the solicitaUrlDominioPuerto operation
          

        /**
         * @see IWSSEGPortal#solicitaUrlDominioPuerto()
         */
        public function solicitaUrlDominioPuerto(strCodOrdenServ:String):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.solicitaUrlDominioPuerto(strCodOrdenServ);
            _internal_token.addEventListener("result",_solicitaUrlDominioPuerto_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#solicitaUrlDominioPuerto_send()
		 */    
        public function solicitaUrlDominioPuerto_send():AsyncToken
        {
        	return solicitaUrlDominioPuerto(_solicitaUrlDominioPuerto_request.strCodOrdenServ);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _solicitaUrlDominioPuerto_request:SolicitaUrlDominioPuerto_request;
		/**
		 * @see IWSSEGPortal#solicitaUrlDominioPuerto_request_var
		 */
		[Bindable]
		public function get solicitaUrlDominioPuerto_request_var():SolicitaUrlDominioPuerto_request
		{
			return _solicitaUrlDominioPuerto_request;
		}
		
		/**
		 * @private
		 */
		public function set solicitaUrlDominioPuerto_request_var(request:SolicitaUrlDominioPuerto_request):void
		{
			_solicitaUrlDominioPuerto_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _solicitaUrlDominioPuerto_lastResult:MuestraURLDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#solicitaUrlDominioPuerto_lastResult
		 */	  
		public function get solicitaUrlDominioPuerto_lastResult():MuestraURLDTO
		{
			return _solicitaUrlDominioPuerto_lastResult;
		}
		/**
		 * @private
		 */
		public function set solicitaUrlDominioPuerto_lastResult(lastResult:MuestraURLDTO):void
		{
			_solicitaUrlDominioPuerto_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addsolicitaUrlDominioPuerto()
		 */
		public function addsolicitaUrlDominioPuertoEventListener(listener:Function):void
		{
			addEventListener(SolicitaUrlDominioPuertoResultEvent.SolicitaUrlDominioPuerto_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _solicitaUrlDominioPuerto_populate_results(event:ResultEvent):void
		{
			var e:SolicitaUrlDominioPuertoResultEvent = new SolicitaUrlDominioPuertoResultEvent();
		            e.result = event.result as MuestraURLDTO;
		                       e.headers = event.headers;
		             solicitaUrlDominioPuerto_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the cargarAjusteCReversionCargos operation
          

        /**
         * @see IWSSEGPortal#cargarAjusteCReversionCargos()
         */
        public function cargarAjusteCReversionCargos(codCliente:Number,nomUsuarioSCL:String,pwd:String,codEvento:String):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.cargarAjusteCReversionCargos(codCliente,nomUsuarioSCL,pwd,codEvento);
            _internal_token.addEventListener("result",_cargarAjusteCReversionCargos_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#cargarAjusteCReversionCargos_send()
		 */    
        public function cargarAjusteCReversionCargos_send():AsyncToken
        {
        	return cargarAjusteCReversionCargos(_cargarAjusteCReversionCargos_request.codCliente,_cargarAjusteCReversionCargos_request.nomUsuarioSCL,_cargarAjusteCReversionCargos_request.pwd,_cargarAjusteCReversionCargos_request.codEvento);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _cargarAjusteCReversionCargos_request:CargarAjusteCReversionCargos_request;
		/**
		 * @see IWSSEGPortal#cargarAjusteCReversionCargos_request_var
		 */
		[Bindable]
		public function get cargarAjusteCReversionCargos_request_var():CargarAjusteCReversionCargos_request
		{
			return _cargarAjusteCReversionCargos_request;
		}
		
		/**
		 * @private
		 */
		public function set cargarAjusteCReversionCargos_request_var(request:CargarAjusteCReversionCargos_request):void
		{
			_cargarAjusteCReversionCargos_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _cargarAjusteCReversionCargos_lastResult:CargaAjusteCReversionCargosSACDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#cargarAjusteCReversionCargos_lastResult
		 */	  
		public function get cargarAjusteCReversionCargos_lastResult():CargaAjusteCReversionCargosSACDTO
		{
			return _cargarAjusteCReversionCargos_lastResult;
		}
		/**
		 * @private
		 */
		public function set cargarAjusteCReversionCargos_lastResult(lastResult:CargaAjusteCReversionCargosSACDTO):void
		{
			_cargarAjusteCReversionCargos_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addcargarAjusteCReversionCargos()
		 */
		public function addcargarAjusteCReversionCargosEventListener(listener:Function):void
		{
			addEventListener(CargarAjusteCReversionCargosResultEvent.CargarAjusteCReversionCargos_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _cargarAjusteCReversionCargos_populate_results(event:ResultEvent):void
		{
			var e:CargarAjusteCReversionCargosResultEvent = new CargarAjusteCReversionCargosResultEvent();
		            e.result = event.result as CargaAjusteCReversionCargosSACDTO;
		                       e.headers = event.headers;
		             cargarAjusteCReversionCargos_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the oossEjecutadasXNumAbonado operation
          

        /**
         * @see IWSSEGPortal#oossEjecutadasXNumAbonado()
         */
        public function oossEjecutadasXNumAbonado(numAbonado:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.oossEjecutadasXNumAbonado(numAbonado,nomUsuarioSCL,codEvento);
            _internal_token.addEventListener("result",_oossEjecutadasXNumAbonado_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#oossEjecutadasXNumAbonado_send()
		 */    
        public function oossEjecutadasXNumAbonado_send():AsyncToken
        {
        	return oossEjecutadasXNumAbonado(_oossEjecutadasXNumAbonado_request.numAbonado,_oossEjecutadasXNumAbonado_request.nomUsuarioSCL,_oossEjecutadasXNumAbonado_request.codEvento);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _oossEjecutadasXNumAbonado_request:OossEjecutadasXNumAbonado_request;
		/**
		 * @see IWSSEGPortal#oossEjecutadasXNumAbonado_request_var
		 */
		[Bindable]
		public function get oossEjecutadasXNumAbonado_request_var():OossEjecutadasXNumAbonado_request
		{
			return _oossEjecutadasXNumAbonado_request;
		}
		
		/**
		 * @private
		 */
		public function set oossEjecutadasXNumAbonado_request_var(request:OossEjecutadasXNumAbonado_request):void
		{
			_oossEjecutadasXNumAbonado_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _oossEjecutadasXNumAbonado_lastResult:ListadoOrdenesServicioDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#oossEjecutadasXNumAbonado_lastResult
		 */	  
		public function get oossEjecutadasXNumAbonado_lastResult():ListadoOrdenesServicioDTO
		{
			return _oossEjecutadasXNumAbonado_lastResult;
		}
		/**
		 * @private
		 */
		public function set oossEjecutadasXNumAbonado_lastResult(lastResult:ListadoOrdenesServicioDTO):void
		{
			_oossEjecutadasXNumAbonado_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addoossEjecutadasXNumAbonado()
		 */
		public function addoossEjecutadasXNumAbonadoEventListener(listener:Function):void
		{
			addEventListener(OossEjecutadasXNumAbonadoResultEvent.OossEjecutadasXNumAbonado_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _oossEjecutadasXNumAbonado_populate_results(event:ResultEvent):void
		{
			var e:OossEjecutadasXNumAbonadoResultEvent = new OossEjecutadasXNumAbonadoResultEvent();
		            e.result = event.result as ListadoOrdenesServicioDTO;
		                       e.headers = event.headers;
		             oossEjecutadasXNumAbonado_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the ssXDefectoXNumAbonado operation
          

        /**
         * @see IWSSEGPortal#ssXDefectoXNumAbonado()
         */
        public function ssXDefectoXNumAbonado(numAbonado:Number):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.ssXDefectoXNumAbonado(numAbonado);
            _internal_token.addEventListener("result",_ssXDefectoXNumAbonado_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#ssXDefectoXNumAbonado_send()
		 */    
        public function ssXDefectoXNumAbonado_send():AsyncToken
        {
        	return ssXDefectoXNumAbonado(_ssXDefectoXNumAbonado_request.numAbonado);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _ssXDefectoXNumAbonado_request:SsXDefectoXNumAbonado_request;
		/**
		 * @see IWSSEGPortal#ssXDefectoXNumAbonado_request_var
		 */
		[Bindable]
		public function get ssXDefectoXNumAbonado_request_var():SsXDefectoXNumAbonado_request
		{
			return _ssXDefectoXNumAbonado_request;
		}
		
		/**
		 * @private
		 */
		public function set ssXDefectoXNumAbonado_request_var(request:SsXDefectoXNumAbonado_request):void
		{
			_ssXDefectoXNumAbonado_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _ssXDefectoXNumAbonado_lastResult:ListadoServSuplementariosDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#ssXDefectoXNumAbonado_lastResult
		 */	  
		public function get ssXDefectoXNumAbonado_lastResult():ListadoServSuplementariosDTO
		{
			return _ssXDefectoXNumAbonado_lastResult;
		}
		/**
		 * @private
		 */
		public function set ssXDefectoXNumAbonado_lastResult(lastResult:ListadoServSuplementariosDTO):void
		{
			_ssXDefectoXNumAbonado_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addssXDefectoXNumAbonado()
		 */
		public function addssXDefectoXNumAbonadoEventListener(listener:Function):void
		{
			addEventListener(SsXDefectoXNumAbonadoResultEvent.SsXDefectoXNumAbonado_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _ssXDefectoXNumAbonado_populate_results(event:ResultEvent):void
		{
			var e:SsXDefectoXNumAbonadoResultEvent = new SsXDefectoXNumAbonadoResultEvent();
		            e.result = event.result as ListadoServSuplementariosDTO;
		                       e.headers = event.headers;
		             ssXDefectoXNumAbonado_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the ejecutarCambioEquipoGSM operation
          

        /**
         * @see IWSSEGPortal#ejecutarCambioEquipoGSM()
         */
        public function ejecutarCambioEquipoGSM(entrada:EjecucionCambioEquipoGSMDTO):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.ejecutarCambioEquipoGSM(entrada);
            _internal_token.addEventListener("result",_ejecutarCambioEquipoGSM_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#ejecutarCambioEquipoGSM_send()
		 */    
        public function ejecutarCambioEquipoGSM_send():AsyncToken
        {
        	return ejecutarCambioEquipoGSM(_ejecutarCambioEquipoGSM_request.entrada);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _ejecutarCambioEquipoGSM_request:EjecutarCambioEquipoGSM_request;
		/**
		 * @see IWSSEGPortal#ejecutarCambioEquipoGSM_request_var
		 */
		[Bindable]
		public function get ejecutarCambioEquipoGSM_request_var():EjecutarCambioEquipoGSM_request
		{
			return _ejecutarCambioEquipoGSM_request;
		}
		
		/**
		 * @private
		 */
		public function set ejecutarCambioEquipoGSM_request_var(request:EjecutarCambioEquipoGSM_request):void
		{
			_ejecutarCambioEquipoGSM_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _ejecutarCambioEquipoGSM_lastResult:EjecucionCambioEquipoGSMDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#ejecutarCambioEquipoGSM_lastResult
		 */	  
		public function get ejecutarCambioEquipoGSM_lastResult():EjecucionCambioEquipoGSMDTO
		{
			return _ejecutarCambioEquipoGSM_lastResult;
		}
		/**
		 * @private
		 */
		public function set ejecutarCambioEquipoGSM_lastResult(lastResult:EjecucionCambioEquipoGSMDTO):void
		{
			_ejecutarCambioEquipoGSM_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addejecutarCambioEquipoGSM()
		 */
		public function addejecutarCambioEquipoGSMEventListener(listener:Function):void
		{
			addEventListener(EjecutarCambioEquipoGSMResultEvent.EjecutarCambioEquipoGSM_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _ejecutarCambioEquipoGSM_populate_results(event:ResultEvent):void
		{
			var e:EjecutarCambioEquipoGSMResultEvent = new EjecutarCambioEquipoGSMResultEvent();
		            e.result = event.result as EjecucionCambioEquipoGSMDTO;
		                       e.headers = event.headers;
		             ejecutarCambioEquipoGSM_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the getDocsPagosCliente operation
          

        /**
         * @see IWSSEGPortal#getDocsPagosCliente()
         */
        public function getDocsPagosCliente(obj:GetDocsClienteINDTO):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.getDocsPagosCliente(obj);
            _internal_token.addEventListener("result",_getDocsPagosCliente_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#getDocsPagosCliente_send()
		 */    
        public function getDocsPagosCliente_send():AsyncToken
        {
        	return getDocsPagosCliente(_getDocsPagosCliente_request.obj);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _getDocsPagosCliente_request:GetDocsPagosCliente_request;
		/**
		 * @see IWSSEGPortal#getDocsPagosCliente_request_var
		 */
		[Bindable]
		public function get getDocsPagosCliente_request_var():GetDocsPagosCliente_request
		{
			return _getDocsPagosCliente_request;
		}
		
		/**
		 * @private
		 */
		public function set getDocsPagosCliente_request_var(request:GetDocsPagosCliente_request):void
		{
			_getDocsPagosCliente_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _getDocsPagosCliente_lastResult:ListadoDocCtaCteClienteDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#getDocsPagosCliente_lastResult
		 */	  
		public function get getDocsPagosCliente_lastResult():ListadoDocCtaCteClienteDTO
		{
			return _getDocsPagosCliente_lastResult;
		}
		/**
		 * @private
		 */
		public function set getDocsPagosCliente_lastResult(lastResult:ListadoDocCtaCteClienteDTO):void
		{
			_getDocsPagosCliente_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addgetDocsPagosCliente()
		 */
		public function addgetDocsPagosClienteEventListener(listener:Function):void
		{
			addEventListener(GetDocsPagosClienteResultEvent.GetDocsPagosCliente_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _getDocsPagosCliente_populate_results(event:ResultEvent):void
		{
			var e:GetDocsPagosClienteResultEvent = new GetDocsPagosClienteResultEvent();
		            e.result = event.result as ListadoDocCtaCteClienteDTO;
		                       e.headers = event.headers;
		             getDocsPagosCliente_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the getDocsCtaCteCliente operation
          

        /**
         * @see IWSSEGPortal#getDocsCtaCteCliente()
         */
        public function getDocsCtaCteCliente(obj:GetDocsClienteINDTO,nomUsuarioSCL:String,codEvento:String):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.getDocsCtaCteCliente(obj,nomUsuarioSCL,codEvento);
            _internal_token.addEventListener("result",_getDocsCtaCteCliente_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#getDocsCtaCteCliente_send()
		 */    
        public function getDocsCtaCteCliente_send():AsyncToken
        {
        	return getDocsCtaCteCliente(_getDocsCtaCteCliente_request.obj,_getDocsCtaCteCliente_request.nomUsuarioSCL,_getDocsCtaCteCliente_request.codEvento);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _getDocsCtaCteCliente_request:GetDocsCtaCteCliente_request;
		/**
		 * @see IWSSEGPortal#getDocsCtaCteCliente_request_var
		 */
		[Bindable]
		public function get getDocsCtaCteCliente_request_var():GetDocsCtaCteCliente_request
		{
			return _getDocsCtaCteCliente_request;
		}
		
		/**
		 * @private
		 */
		public function set getDocsCtaCteCliente_request_var(request:GetDocsCtaCteCliente_request):void
		{
			_getDocsCtaCteCliente_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _getDocsCtaCteCliente_lastResult:ListadoDocCtaCteClienteDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#getDocsCtaCteCliente_lastResult
		 */	  
		public function get getDocsCtaCteCliente_lastResult():ListadoDocCtaCteClienteDTO
		{
			return _getDocsCtaCteCliente_lastResult;
		}
		/**
		 * @private
		 */
		public function set getDocsCtaCteCliente_lastResult(lastResult:ListadoDocCtaCteClienteDTO):void
		{
			_getDocsCtaCteCliente_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addgetDocsCtaCteCliente()
		 */
		public function addgetDocsCtaCteClienteEventListener(listener:Function):void
		{
			addEventListener(GetDocsCtaCteClienteResultEvent.GetDocsCtaCteCliente_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _getDocsCtaCteCliente_populate_results(event:ResultEvent):void
		{
			var e:GetDocsCtaCteClienteResultEvent = new GetDocsCtaCteClienteResultEvent();
		            e.result = event.result as ListadoDocCtaCteClienteDTO;
		                       e.headers = event.headers;
		             getDocsCtaCteCliente_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the cambiarDireccionCliente operation
          

        /**
         * @see IWSSEGPortal#cambiarDireccionCliente()
         */
        public function cambiarDireccionCliente(dto:DireccionSACDTO):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.cambiarDireccionCliente(dto);
            _internal_token.addEventListener("result",_cambiarDireccionCliente_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#cambiarDireccionCliente_send()
		 */    
        public function cambiarDireccionCliente_send():AsyncToken
        {
        	return cambiarDireccionCliente(_cambiarDireccionCliente_request.dto);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _cambiarDireccionCliente_request:CambiarDireccionCliente_request;
		/**
		 * @see IWSSEGPortal#cambiarDireccionCliente_request_var
		 */
		[Bindable]
		public function get cambiarDireccionCliente_request_var():CambiarDireccionCliente_request
		{
			return _cambiarDireccionCliente_request;
		}
		
		/**
		 * @private
		 */
		public function set cambiarDireccionCliente_request_var(request:CambiarDireccionCliente_request):void
		{
			_cambiarDireccionCliente_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _cambiarDireccionCliente_lastResult:ConsultarOrdenServicioSACDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#cambiarDireccionCliente_lastResult
		 */	  
		public function get cambiarDireccionCliente_lastResult():ConsultarOrdenServicioSACDTO
		{
			return _cambiarDireccionCliente_lastResult;
		}
		/**
		 * @private
		 */
		public function set cambiarDireccionCliente_lastResult(lastResult:ConsultarOrdenServicioSACDTO):void
		{
			_cambiarDireccionCliente_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addcambiarDireccionCliente()
		 */
		public function addcambiarDireccionClienteEventListener(listener:Function):void
		{
			addEventListener(CambiarDireccionClienteResultEvent.CambiarDireccionCliente_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _cambiarDireccionCliente_populate_results(event:ResultEvent):void
		{
			var e:CambiarDireccionClienteResultEvent = new CambiarDireccionClienteResultEvent();
		            e.result = event.result as ConsultarOrdenServicioSACDTO;
		                       e.headers = event.headers;
		             cambiarDireccionCliente_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the ssXDefectoXCodCliente operation
          

        /**
         * @see IWSSEGPortal#ssXDefectoXCodCliente()
         */
        public function ssXDefectoXCodCliente(codCliente:Number):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.ssXDefectoXCodCliente(codCliente);
            _internal_token.addEventListener("result",_ssXDefectoXCodCliente_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#ssXDefectoXCodCliente_send()
		 */    
        public function ssXDefectoXCodCliente_send():AsyncToken
        {
        	return ssXDefectoXCodCliente(_ssXDefectoXCodCliente_request.codCliente);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _ssXDefectoXCodCliente_request:SsXDefectoXCodCliente_request;
		/**
		 * @see IWSSEGPortal#ssXDefectoXCodCliente_request_var
		 */
		[Bindable]
		public function get ssXDefectoXCodCliente_request_var():SsXDefectoXCodCliente_request
		{
			return _ssXDefectoXCodCliente_request;
		}
		
		/**
		 * @private
		 */
		public function set ssXDefectoXCodCliente_request_var(request:SsXDefectoXCodCliente_request):void
		{
			_ssXDefectoXCodCliente_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _ssXDefectoXCodCliente_lastResult:ListadoServSuplementariosDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#ssXDefectoXCodCliente_lastResult
		 */	  
		public function get ssXDefectoXCodCliente_lastResult():ListadoServSuplementariosDTO
		{
			return _ssXDefectoXCodCliente_lastResult;
		}
		/**
		 * @private
		 */
		public function set ssXDefectoXCodCliente_lastResult(lastResult:ListadoServSuplementariosDTO):void
		{
			_ssXDefectoXCodCliente_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addssXDefectoXCodCliente()
		 */
		public function addssXDefectoXCodClienteEventListener(listener:Function):void
		{
			addEventListener(SsXDefectoXCodClienteResultEvent.SsXDefectoXCodCliente_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _ssXDefectoXCodCliente_populate_results(event:ResultEvent):void
		{
			var e:SsXDefectoXCodClienteResultEvent = new SsXDefectoXCodClienteResultEvent();
		            e.result = event.result as ListadoServSuplementariosDTO;
		                       e.headers = event.headers;
		             ssXDefectoXCodCliente_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the servSuplXOOSS operation
          

        /**
         * @see IWSSEGPortal#servSuplXOOSS()
         */
        public function servSuplXOOSS(numOOSS:Number):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.servSuplXOOSS(numOOSS);
            _internal_token.addEventListener("result",_servSuplXOOSS_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#servSuplXOOSS_send()
		 */    
        public function servSuplXOOSS_send():AsyncToken
        {
        	return servSuplXOOSS(_servSuplXOOSS_request.numOOSS);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _servSuplXOOSS_request:ServSuplXOOSS_request;
		/**
		 * @see IWSSEGPortal#servSuplXOOSS_request_var
		 */
		[Bindable]
		public function get servSuplXOOSS_request_var():ServSuplXOOSS_request
		{
			return _servSuplXOOSS_request;
		}
		
		/**
		 * @private
		 */
		public function set servSuplXOOSS_request_var(request:ServSuplXOOSS_request):void
		{
			_servSuplXOOSS_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _servSuplXOOSS_lastResult:ListadoServSuplxOOSSDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#servSuplXOOSS_lastResult
		 */	  
		public function get servSuplXOOSS_lastResult():ListadoServSuplxOOSSDTO
		{
			return _servSuplXOOSS_lastResult;
		}
		/**
		 * @private
		 */
		public function set servSuplXOOSS_lastResult(lastResult:ListadoServSuplxOOSSDTO):void
		{
			_servSuplXOOSS_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addservSuplXOOSS()
		 */
		public function addservSuplXOOSSEventListener(listener:Function):void
		{
			addEventListener(ServSuplXOOSSResultEvent.ServSuplXOOSS_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _servSuplXOOSS_populate_results(event:ResultEvent):void
		{
			var e:ServSuplXOOSSResultEvent = new ServSuplXOOSSResultEvent();
		            e.result = event.result as ListadoServSuplxOOSSDTO;
		                       e.headers = event.headers;
		             servSuplXOOSS_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the limiteConsumoXClienteAbonado operation
          

        /**
         * @see IWSSEGPortal#limiteConsumoXClienteAbonado()
         */
        public function limiteConsumoXClienteAbonado(codCliente:Number,numAbonado:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.limiteConsumoXClienteAbonado(codCliente,numAbonado,nomUsuarioSCL,codEvento);
            _internal_token.addEventListener("result",_limiteConsumoXClienteAbonado_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#limiteConsumoXClienteAbonado_send()
		 */    
        public function limiteConsumoXClienteAbonado_send():AsyncToken
        {
        	return limiteConsumoXClienteAbonado(_limiteConsumoXClienteAbonado_request.codCliente,_limiteConsumoXClienteAbonado_request.numAbonado,_limiteConsumoXClienteAbonado_request.nomUsuarioSCL,_limiteConsumoXClienteAbonado_request.codEvento);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _limiteConsumoXClienteAbonado_request:LimiteConsumoXClienteAbonado_request;
		/**
		 * @see IWSSEGPortal#limiteConsumoXClienteAbonado_request_var
		 */
		[Bindable]
		public function get limiteConsumoXClienteAbonado_request_var():LimiteConsumoXClienteAbonado_request
		{
			return _limiteConsumoXClienteAbonado_request;
		}
		
		/**
		 * @private
		 */
		public function set limiteConsumoXClienteAbonado_request_var(request:LimiteConsumoXClienteAbonado_request):void
		{
			_limiteConsumoXClienteAbonado_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _limiteConsumoXClienteAbonado_lastResult:ListadoLimiteConsumoDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#limiteConsumoXClienteAbonado_lastResult
		 */	  
		public function get limiteConsumoXClienteAbonado_lastResult():ListadoLimiteConsumoDTO
		{
			return _limiteConsumoXClienteAbonado_lastResult;
		}
		/**
		 * @private
		 */
		public function set limiteConsumoXClienteAbonado_lastResult(lastResult:ListadoLimiteConsumoDTO):void
		{
			_limiteConsumoXClienteAbonado_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addlimiteConsumoXClienteAbonado()
		 */
		public function addlimiteConsumoXClienteAbonadoEventListener(listener:Function):void
		{
			addEventListener(LimiteConsumoXClienteAbonadoResultEvent.LimiteConsumoXClienteAbonado_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _limiteConsumoXClienteAbonado_populate_results(event:ResultEvent):void
		{
			var e:LimiteConsumoXClienteAbonadoResultEvent = new LimiteConsumoXClienteAbonadoResultEvent();
		            e.result = event.result as ListadoLimiteConsumoDTO;
		                       e.headers = event.headers;
		             limiteConsumoXClienteAbonado_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the cargaOSGenericaAbonado operation
          

        /**
         * @see IWSSEGPortal#cargaOSGenericaAbonado()
         */
        public function cargaOSGenericaAbonado(numAbonado:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.cargaOSGenericaAbonado(numAbonado,nomUsuarioSCL,codEvento);
            _internal_token.addEventListener("result",_cargaOSGenericaAbonado_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#cargaOSGenericaAbonado_send()
		 */    
        public function cargaOSGenericaAbonado_send():AsyncToken
        {
        	return cargaOSGenericaAbonado(_cargaOSGenericaAbonado_request.numAbonado,_cargaOSGenericaAbonado_request.nomUsuarioSCL,_cargaOSGenericaAbonado_request.codEvento);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _cargaOSGenericaAbonado_request:CargaOSGenericaAbonado_request;
		/**
		 * @see IWSSEGPortal#cargaOSGenericaAbonado_request_var
		 */
		[Bindable]
		public function get cargaOSGenericaAbonado_request_var():CargaOSGenericaAbonado_request
		{
			return _cargaOSGenericaAbonado_request;
		}
		
		/**
		 * @private
		 */
		public function set cargaOSGenericaAbonado_request_var(request:CargaOSGenericaAbonado_request):void
		{
			_cargaOSGenericaAbonado_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _cargaOSGenericaAbonado_lastResult:CargaOSGenericaDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#cargaOSGenericaAbonado_lastResult
		 */	  
		public function get cargaOSGenericaAbonado_lastResult():CargaOSGenericaDTO
		{
			return _cargaOSGenericaAbonado_lastResult;
		}
		/**
		 * @private
		 */
		public function set cargaOSGenericaAbonado_lastResult(lastResult:CargaOSGenericaDTO):void
		{
			_cargaOSGenericaAbonado_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addcargaOSGenericaAbonado()
		 */
		public function addcargaOSGenericaAbonadoEventListener(listener:Function):void
		{
			addEventListener(CargaOSGenericaAbonadoResultEvent.CargaOSGenericaAbonado_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _cargaOSGenericaAbonado_populate_results(event:ResultEvent):void
		{
			var e:CargaOSGenericaAbonadoResultEvent = new CargaOSGenericaAbonadoResultEvent();
		            e.result = event.result as CargaOSGenericaDTO;
		                       e.headers = event.headers;
		             cargaOSGenericaAbonado_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the obtenerParametroKiosco operation
          

        /**
         * @see IWSSEGPortal#obtenerParametroKiosco()
         */
        public function obtenerParametroKiosco():AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.obtenerParametroKiosco();
            _internal_token.addEventListener("result",_obtenerParametroKiosco_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#obtenerParametroKiosco_send()
		 */    
        public function obtenerParametroKiosco_send():AsyncToken
        {
        	return obtenerParametroKiosco();
        }
              
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _obtenerParametroKiosco_lastResult:ParametrosKioscoDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#obtenerParametroKiosco_lastResult
		 */	  
		public function get obtenerParametroKiosco_lastResult():ParametrosKioscoDTO
		{
			return _obtenerParametroKiosco_lastResult;
		}
		/**
		 * @private
		 */
		public function set obtenerParametroKiosco_lastResult(lastResult:ParametrosKioscoDTO):void
		{
			_obtenerParametroKiosco_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addobtenerParametroKiosco()
		 */
		public function addobtenerParametroKioscoEventListener(listener:Function):void
		{
			addEventListener(ObtenerParametroKioscoResultEvent.ObtenerParametroKiosco_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _obtenerParametroKiosco_populate_results(event:ResultEvent):void
		{
			var e:ObtenerParametroKioscoResultEvent = new ObtenerParametroKioscoResultEvent();
		            e.result = event.result as ParametrosKioscoDTO;
		                       e.headers = event.headers;
		             obtenerParametroKiosco_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the cuentasXCodigo operation
          

        /**
         * @see IWSSEGPortal#cuentasXCodigo()
         */
        public function cuentasXCodigo(codCuenta:Number):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.cuentasXCodigo(codCuenta);
            _internal_token.addEventListener("result",_cuentasXCodigo_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#cuentasXCodigo_send()
		 */    
        public function cuentasXCodigo_send():AsyncToken
        {
        	return cuentasXCodigo(_cuentasXCodigo_request.codCuenta);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _cuentasXCodigo_request:CuentasXCodigo_request;
		/**
		 * @see IWSSEGPortal#cuentasXCodigo_request_var
		 */
		[Bindable]
		public function get cuentasXCodigo_request_var():CuentasXCodigo_request
		{
			return _cuentasXCodigo_request;
		}
		
		/**
		 * @private
		 */
		public function set cuentasXCodigo_request_var(request:CuentasXCodigo_request):void
		{
			_cuentasXCodigo_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _cuentasXCodigo_lastResult:ListadoCuentasDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#cuentasXCodigo_lastResult
		 */	  
		public function get cuentasXCodigo_lastResult():ListadoCuentasDTO
		{
			return _cuentasXCodigo_lastResult;
		}
		/**
		 * @private
		 */
		public function set cuentasXCodigo_lastResult(lastResult:ListadoCuentasDTO):void
		{
			_cuentasXCodigo_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addcuentasXCodigo()
		 */
		public function addcuentasXCodigoEventListener(listener:Function):void
		{
			addEventListener(CuentasXCodigoResultEvent.CuentasXCodigo_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _cuentasXCodigo_populate_results(event:ResultEvent):void
		{
			var e:CuentasXCodigoResultEvent = new CuentasXCodigoResultEvent();
		            e.result = event.result as ListadoCuentasDTO;
		                       e.headers = event.headers;
		             cuentasXCodigo_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the clientesXNombre operation
          

        /**
         * @see IWSSEGPortal#clientesXNombre()
         */
        public function clientesXNombre(nombre:String):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.clientesXNombre(nombre);
            _internal_token.addEventListener("result",_clientesXNombre_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#clientesXNombre_send()
		 */    
        public function clientesXNombre_send():AsyncToken
        {
        	return clientesXNombre(_clientesXNombre_request.nombre);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _clientesXNombre_request:ClientesXNombre_request;
		/**
		 * @see IWSSEGPortal#clientesXNombre_request_var
		 */
		[Bindable]
		public function get clientesXNombre_request_var():ClientesXNombre_request
		{
			return _clientesXNombre_request;
		}
		
		/**
		 * @private
		 */
		public function set clientesXNombre_request_var(request:ClientesXNombre_request):void
		{
			_clientesXNombre_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _clientesXNombre_lastResult:ListadoClientesDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#clientesXNombre_lastResult
		 */	  
		public function get clientesXNombre_lastResult():ListadoClientesDTO
		{
			return _clientesXNombre_lastResult;
		}
		/**
		 * @private
		 */
		public function set clientesXNombre_lastResult(lastResult:ListadoClientesDTO):void
		{
			_clientesXNombre_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addclientesXNombre()
		 */
		public function addclientesXNombreEventListener(listener:Function):void
		{
			addEventListener(ClientesXNombreResultEvent.ClientesXNombre_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _clientesXNombre_populate_results(event:ResultEvent):void
		{
			var e:ClientesXNombreResultEvent = new ClientesXNombreResultEvent();
		            e.result = event.result as ListadoClientesDTO;
		                       e.headers = event.headers;
		             clientesXNombre_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the cambiosPlanAbonadoPrepago operation
          

        /**
         * @see IWSSEGPortal#cambiosPlanAbonadoPrepago()
         */
        public function cambiosPlanAbonadoPrepago(numOS:Number):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.cambiosPlanAbonadoPrepago(numOS);
            _internal_token.addEventListener("result",_cambiosPlanAbonadoPrepago_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#cambiosPlanAbonadoPrepago_send()
		 */    
        public function cambiosPlanAbonadoPrepago_send():AsyncToken
        {
        	return cambiosPlanAbonadoPrepago(_cambiosPlanAbonadoPrepago_request.numOS);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _cambiosPlanAbonadoPrepago_request:CambiosPlanAbonadoPrepago_request;
		/**
		 * @see IWSSEGPortal#cambiosPlanAbonadoPrepago_request_var
		 */
		[Bindable]
		public function get cambiosPlanAbonadoPrepago_request_var():CambiosPlanAbonadoPrepago_request
		{
			return _cambiosPlanAbonadoPrepago_request;
		}
		
		/**
		 * @private
		 */
		public function set cambiosPlanAbonadoPrepago_request_var(request:CambiosPlanAbonadoPrepago_request):void
		{
			_cambiosPlanAbonadoPrepago_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _cambiosPlanAbonadoPrepago_lastResult:ListadoCambiosPlanTarifDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#cambiosPlanAbonadoPrepago_lastResult
		 */	  
		public function get cambiosPlanAbonadoPrepago_lastResult():ListadoCambiosPlanTarifDTO
		{
			return _cambiosPlanAbonadoPrepago_lastResult;
		}
		/**
		 * @private
		 */
		public function set cambiosPlanAbonadoPrepago_lastResult(lastResult:ListadoCambiosPlanTarifDTO):void
		{
			_cambiosPlanAbonadoPrepago_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addcambiosPlanAbonadoPrepago()
		 */
		public function addcambiosPlanAbonadoPrepagoEventListener(listener:Function):void
		{
			addEventListener(CambiosPlanAbonadoPrepagoResultEvent.CambiosPlanAbonadoPrepago_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _cambiosPlanAbonadoPrepago_populate_results(event:ResultEvent):void
		{
			var e:CambiosPlanAbonadoPrepagoResultEvent = new CambiosPlanAbonadoPrepagoResultEvent();
		            e.result = event.result as ListadoCambiosPlanTarifDTO;
		                       e.headers = event.headers;
		             cambiosPlanAbonadoPrepago_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the getDetalleDireccion operation
          

        /**
         * @see IWSSEGPortal#getDetalleDireccion()
         */
        public function getDetalleDireccion(codDireccion:Number,codTipDireccion:String):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.getDetalleDireccion(codDireccion,codTipDireccion);
            _internal_token.addEventListener("result",_getDetalleDireccion_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#getDetalleDireccion_send()
		 */    
        public function getDetalleDireccion_send():AsyncToken
        {
        	return getDetalleDireccion(_getDetalleDireccion_request.codDireccion,_getDetalleDireccion_request.codTipDireccion);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _getDetalleDireccion_request:GetDetalleDireccion_request;
		/**
		 * @see IWSSEGPortal#getDetalleDireccion_request_var
		 */
		[Bindable]
		public function get getDetalleDireccion_request_var():GetDetalleDireccion_request
		{
			return _getDetalleDireccion_request;
		}
		
		/**
		 * @private
		 */
		public function set getDetalleDireccion_request_var(request:GetDetalleDireccion_request):void
		{
			_getDetalleDireccion_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _getDetalleDireccion_lastResult:DetalleDireccionDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#getDetalleDireccion_lastResult
		 */	  
		public function get getDetalleDireccion_lastResult():DetalleDireccionDTO
		{
			return _getDetalleDireccion_lastResult;
		}
		/**
		 * @private
		 */
		public function set getDetalleDireccion_lastResult(lastResult:DetalleDireccionDTO):void
		{
			_getDetalleDireccion_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addgetDetalleDireccion()
		 */
		public function addgetDetalleDireccionEventListener(listener:Function):void
		{
			addEventListener(GetDetalleDireccionResultEvent.GetDetalleDireccion_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _getDetalleDireccion_populate_results(event:ResultEvent):void
		{
			var e:GetDetalleDireccionResultEvent = new GetDetalleDireccionResultEvent();
		            e.result = event.result as DetalleDireccionDTO;
		                       e.headers = event.headers;
		             getDetalleDireccion_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the ejecutarAbonoLimiteConsumo operation
          

        /**
         * @see IWSSEGPortal#ejecutarAbonoLimiteConsumo()
         */
        public function ejecutarAbonoLimiteConsumo(entrada:EjecucionAbonoLimConDTO):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.ejecutarAbonoLimiteConsumo(entrada);
            _internal_token.addEventListener("result",_ejecutarAbonoLimiteConsumo_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#ejecutarAbonoLimiteConsumo_send()
		 */    
        public function ejecutarAbonoLimiteConsumo_send():AsyncToken
        {
        	return ejecutarAbonoLimiteConsumo(_ejecutarAbonoLimiteConsumo_request.entrada);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _ejecutarAbonoLimiteConsumo_request:EjecutarAbonoLimiteConsumo_request;
		/**
		 * @see IWSSEGPortal#ejecutarAbonoLimiteConsumo_request_var
		 */
		[Bindable]
		public function get ejecutarAbonoLimiteConsumo_request_var():EjecutarAbonoLimiteConsumo_request
		{
			return _ejecutarAbonoLimiteConsumo_request;
		}
		
		/**
		 * @private
		 */
		public function set ejecutarAbonoLimiteConsumo_request_var(request:EjecutarAbonoLimiteConsumo_request):void
		{
			_ejecutarAbonoLimiteConsumo_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _ejecutarAbonoLimiteConsumo_lastResult:EjecucionAbonoLimConDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#ejecutarAbonoLimiteConsumo_lastResult
		 */	  
		public function get ejecutarAbonoLimiteConsumo_lastResult():EjecucionAbonoLimConDTO
		{
			return _ejecutarAbonoLimiteConsumo_lastResult;
		}
		/**
		 * @private
		 */
		public function set ejecutarAbonoLimiteConsumo_lastResult(lastResult:EjecucionAbonoLimConDTO):void
		{
			_ejecutarAbonoLimiteConsumo_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addejecutarAbonoLimiteConsumo()
		 */
		public function addejecutarAbonoLimiteConsumoEventListener(listener:Function):void
		{
			addEventListener(EjecutarAbonoLimiteConsumoResultEvent.EjecutarAbonoLimiteConsumo_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _ejecutarAbonoLimiteConsumo_populate_results(event:ResultEvent):void
		{
			var e:EjecutarAbonoLimiteConsumoResultEvent = new EjecutarAbonoLimiteConsumoResultEvent();
		            e.result = event.result as EjecucionAbonoLimConDTO;
		                       e.headers = event.headers;
		             ejecutarAbonoLimiteConsumo_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the clientesXCuenta operation
          

        /**
         * @see IWSSEGPortal#clientesXCuenta()
         */
        public function clientesXCuenta(codCuenta:Number):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.clientesXCuenta(codCuenta);
            _internal_token.addEventListener("result",_clientesXCuenta_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#clientesXCuenta_send()
		 */    
        public function clientesXCuenta_send():AsyncToken
        {
        	return clientesXCuenta(_clientesXCuenta_request.codCuenta);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _clientesXCuenta_request:ClientesXCuenta_request;
		/**
		 * @see IWSSEGPortal#clientesXCuenta_request_var
		 */
		[Bindable]
		public function get clientesXCuenta_request_var():ClientesXCuenta_request
		{
			return _clientesXCuenta_request;
		}
		
		/**
		 * @private
		 */
		public function set clientesXCuenta_request_var(request:ClientesXCuenta_request):void
		{
			_clientesXCuenta_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _clientesXCuenta_lastResult:ListadoClientesDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#clientesXCuenta_lastResult
		 */	  
		public function get clientesXCuenta_lastResult():ListadoClientesDTO
		{
			return _clientesXCuenta_lastResult;
		}
		/**
		 * @private
		 */
		public function set clientesXCuenta_lastResult(lastResult:ListadoClientesDTO):void
		{
			_clientesXCuenta_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addclientesXCuenta()
		 */
		public function addclientesXCuentaEventListener(listener:Function):void
		{
			addEventListener(ClientesXCuentaResultEvent.ClientesXCuenta_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _clientesXCuenta_populate_results(event:ResultEvent):void
		{
			var e:ClientesXCuentaResultEvent = new ClientesXCuentaResultEvent();
		            e.result = event.result as ListadoClientesDTO;
		                       e.headers = event.headers;
		             clientesXCuenta_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the ejecutarAnulacionSiniestro operation
          

        /**
         * @see IWSSEGPortal#ejecutarAnulacionSiniestro()
         */
        public function ejecutarAnulacionSiniestro(entrada:EjecucionAnulacionSiniestroDTO):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.ejecutarAnulacionSiniestro(entrada);
            _internal_token.addEventListener("result",_ejecutarAnulacionSiniestro_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#ejecutarAnulacionSiniestro_send()
		 */    
        public function ejecutarAnulacionSiniestro_send():AsyncToken
        {
        	return ejecutarAnulacionSiniestro(_ejecutarAnulacionSiniestro_request.entrada);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _ejecutarAnulacionSiniestro_request:EjecutarAnulacionSiniestro_request;
		/**
		 * @see IWSSEGPortal#ejecutarAnulacionSiniestro_request_var
		 */
		[Bindable]
		public function get ejecutarAnulacionSiniestro_request_var():EjecutarAnulacionSiniestro_request
		{
			return _ejecutarAnulacionSiniestro_request;
		}
		
		/**
		 * @private
		 */
		public function set ejecutarAnulacionSiniestro_request_var(request:EjecutarAnulacionSiniestro_request):void
		{
			_ejecutarAnulacionSiniestro_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _ejecutarAnulacionSiniestro_lastResult:EjecucionAnulacionSiniestroDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#ejecutarAnulacionSiniestro_lastResult
		 */	  
		public function get ejecutarAnulacionSiniestro_lastResult():EjecucionAnulacionSiniestroDTO
		{
			return _ejecutarAnulacionSiniestro_lastResult;
		}
		/**
		 * @private
		 */
		public function set ejecutarAnulacionSiniestro_lastResult(lastResult:EjecucionAnulacionSiniestroDTO):void
		{
			_ejecutarAnulacionSiniestro_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addejecutarAnulacionSiniestro()
		 */
		public function addejecutarAnulacionSiniestroEventListener(listener:Function):void
		{
			addEventListener(EjecutarAnulacionSiniestroResultEvent.EjecutarAnulacionSiniestro_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _ejecutarAnulacionSiniestro_populate_results(event:ResultEvent):void
		{
			var e:EjecutarAnulacionSiniestroResultEvent = new EjecutarAnulacionSiniestroResultEvent();
		            e.result = event.result as EjecucionAnulacionSiniestroDTO;
		                       e.headers = event.headers;
		             ejecutarAnulacionSiniestro_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the ejecutarAjusteCReversionCargos operation
          

        /**
         * @see IWSSEGPortal#ejecutarAjusteCReversionCargos()
         */
        public function ejecutarAjusteCReversionCargos(entrada:EjecucionAjusteCReversionCargosSACDTO):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.ejecutarAjusteCReversionCargos(entrada);
            _internal_token.addEventListener("result",_ejecutarAjusteCReversionCargos_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#ejecutarAjusteCReversionCargos_send()
		 */    
        public function ejecutarAjusteCReversionCargos_send():AsyncToken
        {
        	return ejecutarAjusteCReversionCargos(_ejecutarAjusteCReversionCargos_request.entrada);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _ejecutarAjusteCReversionCargos_request:EjecutarAjusteCReversionCargos_request;
		/**
		 * @see IWSSEGPortal#ejecutarAjusteCReversionCargos_request_var
		 */
		[Bindable]
		public function get ejecutarAjusteCReversionCargos_request_var():EjecutarAjusteCReversionCargos_request
		{
			return _ejecutarAjusteCReversionCargos_request;
		}
		
		/**
		 * @private
		 */
		public function set ejecutarAjusteCReversionCargos_request_var(request:EjecutarAjusteCReversionCargos_request):void
		{
			_ejecutarAjusteCReversionCargos_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _ejecutarAjusteCReversionCargos_lastResult:EjecucionAjusteCReversionCargosDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#ejecutarAjusteCReversionCargos_lastResult
		 */	  
		public function get ejecutarAjusteCReversionCargos_lastResult():EjecucionAjusteCReversionCargosDTO
		{
			return _ejecutarAjusteCReversionCargos_lastResult;
		}
		/**
		 * @private
		 */
		public function set ejecutarAjusteCReversionCargos_lastResult(lastResult:EjecucionAjusteCReversionCargosDTO):void
		{
			_ejecutarAjusteCReversionCargos_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addejecutarAjusteCReversionCargos()
		 */
		public function addejecutarAjusteCReversionCargosEventListener(listener:Function):void
		{
			addEventListener(EjecutarAjusteCReversionCargosResultEvent.EjecutarAjusteCReversionCargos_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _ejecutarAjusteCReversionCargos_populate_results(event:ResultEvent):void
		{
			var e:EjecutarAjusteCReversionCargosResultEvent = new EjecutarAjusteCReversionCargosResultEvent();
		            e.result = event.result as EjecucionAjusteCReversionCargosDTO;
		                       e.headers = event.headers;
		             ejecutarAjusteCReversionCargos_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the numerosFrecuentesXPlan operation
          

        /**
         * @see IWSSEGPortal#numerosFrecuentesXPlan()
         */
        public function numerosFrecuentesXPlan(numAbonado:Number):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.numerosFrecuentesXPlan(numAbonado);
            _internal_token.addEventListener("result",_numerosFrecuentesXPlan_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#numerosFrecuentesXPlan_send()
		 */    
        public function numerosFrecuentesXPlan_send():AsyncToken
        {
        	return numerosFrecuentesXPlan(_numerosFrecuentesXPlan_request.numAbonado);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _numerosFrecuentesXPlan_request:NumerosFrecuentesXPlan_request;
		/**
		 * @see IWSSEGPortal#numerosFrecuentesXPlan_request_var
		 */
		[Bindable]
		public function get numerosFrecuentesXPlan_request_var():NumerosFrecuentesXPlan_request
		{
			return _numerosFrecuentesXPlan_request;
		}
		
		/**
		 * @private
		 */
		public function set numerosFrecuentesXPlan_request_var(request:NumerosFrecuentesXPlan_request):void
		{
			_numerosFrecuentesXPlan_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _numerosFrecuentesXPlan_lastResult:ListadoNumerosFrecuentesDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#numerosFrecuentesXPlan_lastResult
		 */	  
		public function get numerosFrecuentesXPlan_lastResult():ListadoNumerosFrecuentesDTO
		{
			return _numerosFrecuentesXPlan_lastResult;
		}
		/**
		 * @private
		 */
		public function set numerosFrecuentesXPlan_lastResult(lastResult:ListadoNumerosFrecuentesDTO):void
		{
			_numerosFrecuentesXPlan_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addnumerosFrecuentesXPlan()
		 */
		public function addnumerosFrecuentesXPlanEventListener(listener:Function):void
		{
			addEventListener(NumerosFrecuentesXPlanResultEvent.NumerosFrecuentesXPlan_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _numerosFrecuentesXPlan_populate_results(event:ResultEvent):void
		{
			var e:NumerosFrecuentesXPlanResultEvent = new NumerosFrecuentesXPlanResultEvent();
		            e.result = event.result as ListadoNumerosFrecuentesDTO;
		                       e.headers = event.headers;
		             numerosFrecuentesXPlan_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the obtenerOoSsAgendadas operation
          

        /**
         * @see IWSSEGPortal#obtenerOoSsAgendadas()
         */
        public function obtenerOoSsAgendadas(numDato:Number,tipoDato:Number):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.obtenerOoSsAgendadas(numDato,tipoDato);
            _internal_token.addEventListener("result",_obtenerOoSsAgendadas_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#obtenerOoSsAgendadas_send()
		 */    
        public function obtenerOoSsAgendadas_send():AsyncToken
        {
        	return obtenerOoSsAgendadas(_obtenerOoSsAgendadas_request.numDato,_obtenerOoSsAgendadas_request.tipoDato);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _obtenerOoSsAgendadas_request:ObtenerOoSsAgendadas_request;
		/**
		 * @see IWSSEGPortal#obtenerOoSsAgendadas_request_var
		 */
		[Bindable]
		public function get obtenerOoSsAgendadas_request_var():ObtenerOoSsAgendadas_request
		{
			return _obtenerOoSsAgendadas_request;
		}
		
		/**
		 * @private
		 */
		public function set obtenerOoSsAgendadas_request_var(request:ObtenerOoSsAgendadas_request):void
		{
			_obtenerOoSsAgendadas_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _obtenerOoSsAgendadas_lastResult:ListadoOrdenesAgendadasDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#obtenerOoSsAgendadas_lastResult
		 */	  
		public function get obtenerOoSsAgendadas_lastResult():ListadoOrdenesAgendadasDTO
		{
			return _obtenerOoSsAgendadas_lastResult;
		}
		/**
		 * @private
		 */
		public function set obtenerOoSsAgendadas_lastResult(lastResult:ListadoOrdenesAgendadasDTO):void
		{
			_obtenerOoSsAgendadas_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addobtenerOoSsAgendadas()
		 */
		public function addobtenerOoSsAgendadasEventListener(listener:Function):void
		{
			addEventListener(ObtenerOoSsAgendadasResultEvent.ObtenerOoSsAgendadas_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _obtenerOoSsAgendadas_populate_results(event:ResultEvent):void
		{
			var e:ObtenerOoSsAgendadasResultEvent = new ObtenerOoSsAgendadasResultEvent();
		            e.result = event.result as ListadoOrdenesAgendadasDTO;
		                       e.headers = event.headers;
		             obtenerOoSsAgendadas_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the ccXCodCliente operation
          

        /**
         * @see IWSSEGPortal#ccXCodCliente()
         */
        public function ccXCodCliente(codCliente:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.ccXCodCliente(codCliente,nomUsuarioSCL,codEvento);
            _internal_token.addEventListener("result",_ccXCodCliente_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#ccXCodCliente_send()
		 */    
        public function ccXCodCliente_send():AsyncToken
        {
        	return ccXCodCliente(_ccXCodCliente_request.codCliente,_ccXCodCliente_request.nomUsuarioSCL,_ccXCodCliente_request.codEvento);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _ccXCodCliente_request:CcXCodCliente_request;
		/**
		 * @see IWSSEGPortal#ccXCodCliente_request_var
		 */
		[Bindable]
		public function get ccXCodCliente_request_var():CcXCodCliente_request
		{
			return _ccXCodCliente_request;
		}
		
		/**
		 * @private
		 */
		public function set ccXCodCliente_request_var(request:CcXCodCliente_request):void
		{
			_ccXCodCliente_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _ccXCodCliente_lastResult:ListadoCuentasCorrientesDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#ccXCodCliente_lastResult
		 */	  
		public function get ccXCodCliente_lastResult():ListadoCuentasCorrientesDTO
		{
			return _ccXCodCliente_lastResult;
		}
		/**
		 * @private
		 */
		public function set ccXCodCliente_lastResult(lastResult:ListadoCuentasCorrientesDTO):void
		{
			_ccXCodCliente_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addccXCodCliente()
		 */
		public function addccXCodClienteEventListener(listener:Function):void
		{
			addEventListener(CcXCodClienteResultEvent.CcXCodCliente_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _ccXCodCliente_populate_results(event:ResultEvent):void
		{
			var e:CcXCodClienteResultEvent = new CcXCodClienteResultEvent();
		            e.result = event.result as ListadoCuentasCorrientesDTO;
		                       e.headers = event.headers;
		             ccXCodCliente_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the abonadosXCliente operation
          

        /**
         * @see IWSSEGPortal#abonadosXCliente()
         */
        public function abonadosXCliente(codCliente:Number):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.abonadosXCliente(codCliente);
            _internal_token.addEventListener("result",_abonadosXCliente_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#abonadosXCliente_send()
		 */    
        public function abonadosXCliente_send():AsyncToken
        {
        	return abonadosXCliente(_abonadosXCliente_request.codCliente);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _abonadosXCliente_request:AbonadosXCliente_request;
		/**
		 * @see IWSSEGPortal#abonadosXCliente_request_var
		 */
		[Bindable]
		public function get abonadosXCliente_request_var():AbonadosXCliente_request
		{
			return _abonadosXCliente_request;
		}
		
		/**
		 * @private
		 */
		public function set abonadosXCliente_request_var(request:AbonadosXCliente_request):void
		{
			_abonadosXCliente_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _abonadosXCliente_lastResult:ListadoAbonadosDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#abonadosXCliente_lastResult
		 */	  
		public function get abonadosXCliente_lastResult():ListadoAbonadosDTO
		{
			return _abonadosXCliente_lastResult;
		}
		/**
		 * @private
		 */
		public function set abonadosXCliente_lastResult(lastResult:ListadoAbonadosDTO):void
		{
			_abonadosXCliente_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addabonadosXCliente()
		 */
		public function addabonadosXClienteEventListener(listener:Function):void
		{
			addEventListener(AbonadosXClienteResultEvent.AbonadosXCliente_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _abonadosXCliente_populate_results(event:ResultEvent):void
		{
			var e:AbonadosXClienteResultEvent = new AbonadosXClienteResultEvent();
		            e.result = event.result as ListadoAbonadosDTO;
		                       e.headers = event.headers;
		             abonadosXCliente_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//stub functions for the insertComentario operation
          

        /**
         * @see IWSSEGPortal#insertComentario()
         */
        public function insertComentario(comentario:String,numOoss:Number):AsyncToken
        {
         	var _internal_token:AsyncToken = _baseService.insertComentario(comentario,numOoss);
            _internal_token.addEventListener("result",_insertComentario_populate_results);
            _internal_token.addEventListener("fault",throwFault); 
            return _internal_token;
		}
        /**
		 * @see IWSSEGPortal#insertComentario_send()
		 */    
        public function insertComentario_send():AsyncToken
        {
        	return insertComentario(_insertComentario_request.comentario,_insertComentario_request.numOoss);
        }
              
		/**
		 * Internal representation of the request wrapper for the operation
		 * @private
		 */
		private var _insertComentario_request:InsertComentario_request;
		/**
		 * @see IWSSEGPortal#insertComentario_request_var
		 */
		[Bindable]
		public function get insertComentario_request_var():InsertComentario_request
		{
			return _insertComentario_request;
		}
		
		/**
		 * @private
		 */
		public function set insertComentario_request_var(request:InsertComentario_request):void
		{
			_insertComentario_request = request;
		}
		
	  		/**
		 * Internal variable to store the operation's lastResult
		 * @private
		 */
        private var _insertComentario_lastResult:ResulTransaccionDTO;
		[Bindable]
		/**
		 * @see IWSSEGPortal#insertComentario_lastResult
		 */	  
		public function get insertComentario_lastResult():ResulTransaccionDTO
		{
			return _insertComentario_lastResult;
		}
		/**
		 * @private
		 */
		public function set insertComentario_lastResult(lastResult:ResulTransaccionDTO):void
		{
			_insertComentario_lastResult = lastResult;
		}
		
		/**
		 * @see IWSSEGPortal#addinsertComentario()
		 */
		public function addinsertComentarioEventListener(listener:Function):void
		{
			addEventListener(InsertComentarioResultEvent.InsertComentario_RESULT,listener);
		}
			
		/**
		 * @private
		 */
        private function _insertComentario_populate_results(event:ResultEvent):void
		{
			var e:InsertComentarioResultEvent = new InsertComentarioResultEvent();
		            e.result = event.result as ResulTransaccionDTO;
		                       e.headers = event.headers;
		             insertComentario_lastResult = e.result;
		             dispatchEvent(e);
	        		}
		
		//service-wide functions
		/**
		 * @see IWSSEGPortal#getWebService()
		 */
		public function getWebService():BaseWSSEGPortal
		{
			return _baseService;
		}
		
		/**
		 * Set the event listener for the fault event which can be triggered by each of the operations defined by the facade
		 */
		public function addWSSEGPortalFaultEventListener(listener:Function):void
		{
			addEventListener("fault",listener);
		}
		
		/**
		 * Internal function to re-dispatch the fault event passed on by the base service implementation
		 * @private
		 */
		 
		 private function throwFault(event:FaultEvent):void
		 {
		 	dispatchEvent(event);
		 }
    }
}
