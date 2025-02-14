
/**
 * Service.as
 * This file was auto-generated from WSDL by the Apache Axis2 generator modified by Adobe
 * Any change made to this file will be overwritten when the code is re-generated.
 */
package generated.webservices.orquestador{
	import mx.rpc.AsyncToken;
	import flash.utils.ByteArray;
	import mx.rpc.soap.types.*;
               
    public interface IWSSEGPortal
    {
    	//Stub functions for the cargarReposicionSrvCelular operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param numAbonado
    	 * @param nomUsuarioSCL
    	 * @param codEvento
    	 * @return An AsyncToken
    	 */
    	function cargarReposicionSrvCelular(numAbonado:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function cargarReposicionSrvCelular_send():AsyncToken;
        
        /**
         * The cargarReposicionSrvCelular operation lastResult property
         */
        function get cargarReposicionSrvCelular_lastResult():CargaReposicionSrvCelDTO;
		/**
		 * @private
		 */
        function set cargarReposicionSrvCelular_lastResult(lastResult:CargaReposicionSrvCelDTO):void;
       /**
        * Add a listener for the cargarReposicionSrvCelular operation successful result event
        * @param The listener function
        */
       function addcargarReposicionSrvCelularEventListener(listener:Function):void;
       
       
        /**
         * The cargarReposicionSrvCelular operation request wrapper
         */
        function get cargarReposicionSrvCelular_request_var():CargarReposicionSrvCelular_request;
        
        /**
         * @private
         */
        function set cargarReposicionSrvCelular_request_var(request:CargarReposicionSrvCelular_request):void;
                   
    	//Stub functions for the cuentasXNombre operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param descCuenta
    	 * @return An AsyncToken
    	 */
    	function cuentasXNombre(descCuenta:String):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function cuentasXNombre_send():AsyncToken;
        
        /**
         * The cuentasXNombre operation lastResult property
         */
        function get cuentasXNombre_lastResult():ListadoCuentasDTO;
		/**
		 * @private
		 */
        function set cuentasXNombre_lastResult(lastResult:ListadoCuentasDTO):void;
       /**
        * Add a listener for the cuentasXNombre operation successful result event
        * @param The listener function
        */
       function addcuentasXNombreEventListener(listener:Function):void;
       
       
        /**
         * The cuentasXNombre operation request wrapper
         */
        function get cuentasXNombre_request_var():CuentasXNombre_request;
        
        /**
         * @private
         */
        function set cuentasXNombre_request_var(request:CuentasXNombre_request):void;
                   
    	//Stub functions for the getDocsFactCliente operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param obj
    	 * @return An AsyncToken
    	 */
    	function getDocsFactCliente(obj:GetDocsClienteINDTO):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function getDocsFactCliente_send():AsyncToken;
        
        /**
         * The getDocsFactCliente operation lastResult property
         */
        function get getDocsFactCliente_lastResult():ListadoDocCtaCteClienteDTO;
		/**
		 * @private
		 */
        function set getDocsFactCliente_lastResult(lastResult:ListadoDocCtaCteClienteDTO):void;
       /**
        * Add a listener for the getDocsFactCliente operation successful result event
        * @param The listener function
        */
       function addgetDocsFactClienteEventListener(listener:Function):void;
       
       
        /**
         * The getDocsFactCliente operation request wrapper
         */
        function get getDocsFactCliente_request_var():GetDocsFactCliente_request;
        
        /**
         * @private
         */
        function set getDocsFactCliente_request_var(request:GetDocsFactCliente_request):void;
                   
    	//Stub functions for the abonadosXCelular operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param numCelular
    	 * @return An AsyncToken
    	 */
    	function abonadosXCelular(numCelular:Number):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function abonadosXCelular_send():AsyncToken;
        
        /**
         * The abonadosXCelular operation lastResult property
         */
        function get abonadosXCelular_lastResult():ListadoAbonadosDTO;
		/**
		 * @private
		 */
        function set abonadosXCelular_lastResult(lastResult:ListadoAbonadosDTO):void;
       /**
        * Add a listener for the abonadosXCelular operation successful result event
        * @param The listener function
        */
       function addabonadosXCelularEventListener(listener:Function):void;
       
       
        /**
         * The abonadosXCelular operation request wrapper
         */
        function get abonadosXCelular_request_var():AbonadosXCelular_request;
        
        /**
         * @private
         */
        function set abonadosXCelular_request_var(request:AbonadosXCelular_request):void;
                   
    	//Stub functions for the ejecutarCambioPlanPostPagoIndividual operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param entrada
    	 * @return An AsyncToken
    	 */
    	function ejecutarCambioPlanPostPagoIndividual(entrada:EjecucionCambioPlanPostPagoIndividualDTO):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function ejecutarCambioPlanPostPagoIndividual_send():AsyncToken;
        
        /**
         * The ejecutarCambioPlanPostPagoIndividual operation lastResult property
         */
        function get ejecutarCambioPlanPostPagoIndividual_lastResult():EjecucionCambioPlanPostPagoIndividualDTO;
		/**
		 * @private
		 */
        function set ejecutarCambioPlanPostPagoIndividual_lastResult(lastResult:EjecucionCambioPlanPostPagoIndividualDTO):void;
       /**
        * Add a listener for the ejecutarCambioPlanPostPagoIndividual operation successful result event
        * @param The listener function
        */
       function addejecutarCambioPlanPostPagoIndividualEventListener(listener:Function):void;
       
       
        /**
         * The ejecutarCambioPlanPostPagoIndividual operation request wrapper
         */
        function get ejecutarCambioPlanPostPagoIndividual_request_var():EjecutarCambioPlanPostPagoIndividual_request;
        
        /**
         * @private
         */
        function set ejecutarCambioPlanPostPagoIndividual_request_var(request:EjecutarCambioPlanPostPagoIndividual_request):void;
                   
    	//Stub functions for the obtenerCamposDireccion operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @return An AsyncToken
    	 */
    	function obtenerCamposDireccion():AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function obtenerCamposDireccion_send():AsyncToken;
        
        /**
         * The obtenerCamposDireccion operation lastResult property
         */
        function get obtenerCamposDireccion_lastResult():ListadoCamposDireccionDTO;
		/**
		 * @private
		 */
        function set obtenerCamposDireccion_lastResult(lastResult:ListadoCamposDireccionDTO):void;
       /**
        * Add a listener for the obtenerCamposDireccion operation successful result event
        * @param The listener function
        */
       function addobtenerCamposDireccionEventListener(listener:Function):void;
       
       
    	//Stub functions for the cargaCambioDatosCliente operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param codCliente
    	 * @param nomUsuarioSCL
    	 * @param codEvento
    	 * @return An AsyncToken
    	 */
    	function cargaCambioDatosCliente(codCliente:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function cargaCambioDatosCliente_send():AsyncToken;
        
        /**
         * The cargaCambioDatosCliente operation lastResult property
         */
        function get cargaCambioDatosCliente_lastResult():CargaCambioDatosClienteSACDTO;
		/**
		 * @private
		 */
        function set cargaCambioDatosCliente_lastResult(lastResult:CargaCambioDatosClienteSACDTO):void;
       /**
        * Add a listener for the cargaCambioDatosCliente operation successful result event
        * @param The listener function
        */
       function addcargaCambioDatosClienteEventListener(listener:Function):void;
       
       
        /**
         * The cargaCambioDatosCliente operation request wrapper
         */
        function get cargaCambioDatosCliente_request_var():CargaCambioDatosCliente_request;
        
        /**
         * @private
         */
        function set cargaCambioDatosCliente_request_var(request:CargaCambioDatosCliente_request):void;
                   
    	//Stub functions for the cargarAbonoLimiteConsumo operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param codSujeto
    	 * @param tipoAbono
    	 * @param nomUsuarioSCL
    	 * @param codEvento
    	 * @return An AsyncToken
    	 */
    	function cargarAbonoLimiteConsumo(codSujeto:Number,tipoAbono:String,nomUsuarioSCL:String,codEvento:String):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function cargarAbonoLimiteConsumo_send():AsyncToken;
        
        /**
         * The cargarAbonoLimiteConsumo operation lastResult property
         */
        function get cargarAbonoLimiteConsumo_lastResult():CargaAbonoLimConDTO;
		/**
		 * @private
		 */
        function set cargarAbonoLimiteConsumo_lastResult(lastResult:CargaAbonoLimConDTO):void;
       /**
        * Add a listener for the cargarAbonoLimiteConsumo operation successful result event
        * @param The listener function
        */
       function addcargarAbonoLimiteConsumoEventListener(listener:Function):void;
       
       
        /**
         * The cargarAbonoLimiteConsumo operation request wrapper
         */
        function get cargarAbonoLimiteConsumo_request_var():CargarAbonoLimiteConsumo_request;
        
        /**
         * @private
         */
        function set cargarAbonoLimiteConsumo_request_var(request:CargarAbonoLimiteConsumo_request):void;
                   
    	//Stub functions for the ejecutarReposicionSrvCelular operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param entrada
    	 * @return An AsyncToken
    	 */
    	function ejecutarReposicionSrvCelular(entrada:EjecucionReposicionSrvCelDTO):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function ejecutarReposicionSrvCelular_send():AsyncToken;
        
        /**
         * The ejecutarReposicionSrvCelular operation lastResult property
         */
        function get ejecutarReposicionSrvCelular_lastResult():EjecucionReposicionSrvCelDTO;
		/**
		 * @private
		 */
        function set ejecutarReposicionSrvCelular_lastResult(lastResult:EjecucionReposicionSrvCelDTO):void;
       /**
        * Add a listener for the ejecutarReposicionSrvCelular operation successful result event
        * @param The listener function
        */
       function addejecutarReposicionSrvCelularEventListener(listener:Function):void;
       
       
        /**
         * The ejecutarReposicionSrvCelular operation request wrapper
         */
        function get ejecutarReposicionSrvCelular_request_var():EjecutarReposicionSrvCelular_request;
        
        /**
         * @private
         */
        function set ejecutarReposicionSrvCelular_request_var(request:EjecutarReposicionSrvCelular_request):void;
                   
    	//Stub functions for the getDocsAjustesCliente operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param obj
    	 * @return An AsyncToken
    	 */
    	function getDocsAjustesCliente(obj:GetDocsClienteINDTO):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function getDocsAjustesCliente_send():AsyncToken;
        
        /**
         * The getDocsAjustesCliente operation lastResult property
         */
        function get getDocsAjustesCliente_lastResult():ListadoDocCtaCteClienteDTO;
		/**
		 * @private
		 */
        function set getDocsAjustesCliente_lastResult(lastResult:ListadoDocCtaCteClienteDTO):void;
       /**
        * Add a listener for the getDocsAjustesCliente operation successful result event
        * @param The listener function
        */
       function addgetDocsAjustesClienteEventListener(listener:Function):void;
       
       
        /**
         * The getDocsAjustesCliente operation request wrapper
         */
        function get getDocsAjustesCliente_request_var():GetDocsAjustesCliente_request;
        
        /**
         * @private
         */
        function set getDocsAjustesCliente_request_var(request:GetDocsAjustesCliente_request):void;
                   
    	//Stub functions for the cargarCambioPlanPostPagoIndividual operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param numAbonado
    	 * @param nomUsuarioSCL
    	 * @param codEvento
    	 * @return An AsyncToken
    	 */
    	function cargarCambioPlanPostPagoIndividual(numAbonado:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function cargarCambioPlanPostPagoIndividual_send():AsyncToken;
        
        /**
         * The cargarCambioPlanPostPagoIndividual operation lastResult property
         */
        function get cargarCambioPlanPostPagoIndividual_lastResult():CargaCambioPlanPostPagoIndividualDTO;
		/**
		 * @private
		 */
        function set cargarCambioPlanPostPagoIndividual_lastResult(lastResult:CargaCambioPlanPostPagoIndividualDTO):void;
       /**
        * Add a listener for the cargarCambioPlanPostPagoIndividual operation successful result event
        * @param The listener function
        */
       function addcargarCambioPlanPostPagoIndividualEventListener(listener:Function):void;
       
       
        /**
         * The cargarCambioPlanPostPagoIndividual operation request wrapper
         */
        function get cargarCambioPlanPostPagoIndividual_request_var():CargarCambioPlanPostPagoIndividual_request;
        
        /**
         * @private
         */
        function set cargarCambioPlanPostPagoIndividual_request_var(request:CargarCambioPlanPostPagoIndividual_request):void;
                   
    	//Stub functions for the obtenerReporteIngrStatusEqui operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param fechaDesde
    	 * @param fechaHasta
    	 * @return An AsyncToken
    	 */
    	function obtenerReporteIngrStatusEqui(fechaDesde:String,fechaHasta:String):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function obtenerReporteIngrStatusEqui_send():AsyncToken;
        
        /**
         * The obtenerReporteIngrStatusEqui operation lastResult property
         */
        function get obtenerReporteIngrStatusEqui_lastResult():ListadoReporteIngrStatusEquiDTO;
		/**
		 * @private
		 */
        function set obtenerReporteIngrStatusEqui_lastResult(lastResult:ListadoReporteIngrStatusEquiDTO):void;
       /**
        * Add a listener for the obtenerReporteIngrStatusEqui operation successful result event
        * @param The listener function
        */
       function addobtenerReporteIngrStatusEquiEventListener(listener:Function):void;
       
       
        /**
         * The obtenerReporteIngrStatusEqui operation request wrapper
         */
        function get obtenerReporteIngrStatusEqui_request_var():ObtenerReporteIngrStatusEqui_request;
        
        /**
         * @private
         */
        function set obtenerReporteIngrStatusEqui_request_var(request:ObtenerReporteIngrStatusEqui_request):void;
                   
    	//Stub functions for the servSumplemetariosXAbonado operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param numAbonado
    	 * @param nomUsuarioSCL
    	 * @param codEvento
    	 * @return An AsyncToken
    	 */
    	function servSumplemetariosXAbonado(numAbonado:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function servSumplemetariosXAbonado_send():AsyncToken;
        
        /**
         * The servSumplemetariosXAbonado operation lastResult property
         */
        function get servSumplemetariosXAbonado_lastResult():ListadoServSuplementariosDTO;
		/**
		 * @private
		 */
        function set servSumplemetariosXAbonado_lastResult(lastResult:ListadoServSuplementariosDTO):void;
       /**
        * Add a listener for the servSumplemetariosXAbonado operation successful result event
        * @param The listener function
        */
       function addservSumplemetariosXAbonadoEventListener(listener:Function):void;
       
       
        /**
         * The servSumplemetariosXAbonado operation request wrapper
         */
        function get servSumplemetariosXAbonado_request_var():ServSumplemetariosXAbonado_request;
        
        /**
         * @private
         */
        function set servSumplemetariosXAbonado_request_var(request:ServSumplemetariosXAbonado_request):void;
                   
    	//Stub functions for the filtrarDetDocAjusteCReversionCargos operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param entrada
    	 * @return An AsyncToken
    	 */
    	function filtrarDetDocAjusteCReversionCargos(entrada:FiltroDetDocAjusteCCargosSACDTO):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function filtrarDetDocAjusteCReversionCargos_send():AsyncToken;
        
        /**
         * The filtrarDetDocAjusteCReversionCargos operation lastResult property
         */
        function get filtrarDetDocAjusteCReversionCargos_lastResult():FiltroDetDocAjusteCCargosSACDTO;
		/**
		 * @private
		 */
        function set filtrarDetDocAjusteCReversionCargos_lastResult(lastResult:FiltroDetDocAjusteCCargosSACDTO):void;
       /**
        * Add a listener for the filtrarDetDocAjusteCReversionCargos operation successful result event
        * @param The listener function
        */
       function addfiltrarDetDocAjusteCReversionCargosEventListener(listener:Function):void;
       
       
        /**
         * The filtrarDetDocAjusteCReversionCargos operation request wrapper
         */
        function get filtrarDetDocAjusteCReversionCargos_request_var():FiltrarDetDocAjusteCReversionCargos_request;
        
        /**
         * @private
         */
        function set filtrarDetDocAjusteCReversionCargos_request_var(request:FiltrarDetDocAjusteCReversionCargos_request):void;
                   
    	//Stub functions for the getDetalleCuenta operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param codCuenta
    	 * @param nomUsuarioSCL
    	 * @param codEvento
    	 * @return An AsyncToken
    	 */
    	function getDetalleCuenta(codCuenta:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function getDetalleCuenta_send():AsyncToken;
        
        /**
         * The getDetalleCuenta operation lastResult property
         */
        function get getDetalleCuenta_lastResult():DetalleCuentaDTO;
		/**
		 * @private
		 */
        function set getDetalleCuenta_lastResult(lastResult:DetalleCuentaDTO):void;
       /**
        * Add a listener for the getDetalleCuenta operation successful result event
        * @param The listener function
        */
       function addgetDetalleCuentaEventListener(listener:Function):void;
       
       
        /**
         * The getDetalleCuenta operation request wrapper
         */
        function get getDetalleCuenta_request_var():GetDetalleCuenta_request;
        
        /**
         * @private
         */
        function set getDetalleCuenta_request_var(request:GetDetalleCuenta_request):void;
                   
    	//Stub functions for the filtrarDetDocAjusteCExcepcionCargos operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param entrada
    	 * @return An AsyncToken
    	 */
    	function filtrarDetDocAjusteCExcepcionCargos(entrada:FiltroDetDocAjusteCCargosSACDTO):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function filtrarDetDocAjusteCExcepcionCargos_send():AsyncToken;
        
        /**
         * The filtrarDetDocAjusteCExcepcionCargos operation lastResult property
         */
        function get filtrarDetDocAjusteCExcepcionCargos_lastResult():FiltroDetDocAjusteCCargosSACDTO;
		/**
		 * @private
		 */
        function set filtrarDetDocAjusteCExcepcionCargos_lastResult(lastResult:FiltroDetDocAjusteCCargosSACDTO):void;
       /**
        * Add a listener for the filtrarDetDocAjusteCExcepcionCargos operation successful result event
        * @param The listener function
        */
       function addfiltrarDetDocAjusteCExcepcionCargosEventListener(listener:Function):void;
       
       
        /**
         * The filtrarDetDocAjusteCExcepcionCargos operation request wrapper
         */
        function get filtrarDetDocAjusteCExcepcionCargos_request_var():FiltrarDetDocAjusteCExcepcionCargos_request;
        
        /**
         * @private
         */
        function set filtrarDetDocAjusteCExcepcionCargos_request_var(request:FiltrarDetDocAjusteCExcepcionCargos_request):void;
                   
    	//Stub functions for the detallePlanTarifario operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param codPlanTarifario
    	 * @return An AsyncToken
    	 */
    	function detallePlanTarifario(codPlanTarifario:String):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function detallePlanTarifario_send():AsyncToken;
        
        /**
         * The detallePlanTarifario operation lastResult property
         */
        function get detallePlanTarifario_lastResult():DetallePlanTarifarioDTO;
		/**
		 * @private
		 */
        function set detallePlanTarifario_lastResult(lastResult:DetallePlanTarifarioDTO):void;
       /**
        * Add a listener for the detallePlanTarifario operation successful result event
        * @param The listener function
        */
       function adddetallePlanTarifarioEventListener(listener:Function):void;
       
       
        /**
         * The detallePlanTarifario operation request wrapper
         */
        function get detallePlanTarifario_request_var():DetallePlanTarifario_request;
        
        /**
         * @private
         */
        function set detallePlanTarifario_request_var(request:DetallePlanTarifario_request):void;
                   
    	//Stub functions for the cargarCambioEquipoGSM operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param numAbonado
    	 * @param nomUsuarioSCL
    	 * @param codEvento
    	 * @return An AsyncToken
    	 */
    	function cargarCambioEquipoGSM(numAbonado:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function cargarCambioEquipoGSM_send():AsyncToken;
        
        /**
         * The cargarCambioEquipoGSM operation lastResult property
         */
        function get cargarCambioEquipoGSM_lastResult():CargaCambioEquipoGSMDTO;
		/**
		 * @private
		 */
        function set cargarCambioEquipoGSM_lastResult(lastResult:CargaCambioEquipoGSMDTO):void;
       /**
        * Add a listener for the cargarCambioEquipoGSM operation successful result event
        * @param The listener function
        */
       function addcargarCambioEquipoGSMEventListener(listener:Function):void;
       
       
        /**
         * The cargarCambioEquipoGSM operation request wrapper
         */
        function get cargarCambioEquipoGSM_request_var():CargarCambioEquipoGSM_request;
        
        /**
         * @private
         */
        function set cargarCambioEquipoGSM_request_var(request:CargarCambioEquipoGSM_request):void;
                   
    	//Stub functions for the ejecucionServicioCargos operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param entrada
    	 * @return An AsyncToken
    	 */
    	function ejecucionServicioCargos(entrada:EjecucionServicioCargosDTO):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function ejecucionServicioCargos_send():AsyncToken;
        
        /**
         * The ejecucionServicioCargos operation lastResult property
         */
        function get ejecucionServicioCargos_lastResult():EjecucionServicioCargosDTO;
		/**
		 * @private
		 */
        function set ejecucionServicioCargos_lastResult(lastResult:EjecucionServicioCargosDTO):void;
       /**
        * Add a listener for the ejecucionServicioCargos operation successful result event
        * @param The listener function
        */
       function addejecucionServicioCargosEventListener(listener:Function):void;
       
       
        /**
         * The ejecucionServicioCargos operation request wrapper
         */
        function get ejecucionServicioCargos_request_var():EjecucionServicioCargos_request;
        
        /**
         * @private
         */
        function set ejecucionServicioCargos_request_var(request:EjecucionServicioCargos_request):void;
                   
    	//Stub functions for the gruposXNomUsuario operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param nomUsuario
    	 * @return An AsyncToken
    	 */
    	function gruposXNomUsuario(nomUsuario:String):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function gruposXNomUsuario_send():AsyncToken;
        
        /**
         * The gruposXNomUsuario operation lastResult property
         */
        function get gruposXNomUsuario_lastResult():ListadoGruposDTO;
		/**
		 * @private
		 */
        function set gruposXNomUsuario_lastResult(lastResult:ListadoGruposDTO):void;
       /**
        * Add a listener for the gruposXNomUsuario operation successful result event
        * @param The listener function
        */
       function addgruposXNomUsuarioEventListener(listener:Function):void;
       
       
        /**
         * The gruposXNomUsuario operation request wrapper
         */
        function get gruposXNomUsuario_request_var():GruposXNomUsuario_request;
        
        /**
         * @private
         */
        function set gruposXNomUsuario_request_var(request:GruposXNomUsuario_request):void;
                   
    	//Stub functions for the cargarAnulacionSiniestro operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param numAbonado
    	 * @param nomUsuarioSCL
    	 * @param codEvento
    	 * @return An AsyncToken
    	 */
    	function cargarAnulacionSiniestro(numAbonado:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function cargarAnulacionSiniestro_send():AsyncToken;
        
        /**
         * The cargarAnulacionSiniestro operation lastResult property
         */
        function get cargarAnulacionSiniestro_lastResult():CargaAnulacionSiniestroDTO;
		/**
		 * @private
		 */
        function set cargarAnulacionSiniestro_lastResult(lastResult:CargaAnulacionSiniestroDTO):void;
       /**
        * Add a listener for the cargarAnulacionSiniestro operation successful result event
        * @param The listener function
        */
       function addcargarAnulacionSiniestroEventListener(listener:Function):void;
       
       
        /**
         * The cargarAnulacionSiniestro operation request wrapper
         */
        function get cargarAnulacionSiniestro_request_var():CargarAnulacionSiniestro_request;
        
        /**
         * @private
         */
        function set cargarAnulacionSiniestro_request_var(request:CargarAnulacionSiniestro_request):void;
                   
    	//Stub functions for the ejecutarCambioSIMCard operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param entrada
    	 * @return An AsyncToken
    	 */
    	function ejecutarCambioSIMCard(entrada:EjecucionCambioSIMCardDTO):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function ejecutarCambioSIMCard_send():AsyncToken;
        
        /**
         * The ejecutarCambioSIMCard operation lastResult property
         */
        function get ejecutarCambioSIMCard_lastResult():EjecucionCambioSIMCardDTO;
		/**
		 * @private
		 */
        function set ejecutarCambioSIMCard_lastResult(lastResult:EjecucionCambioSIMCardDTO):void;
       /**
        * Add a listener for the ejecutarCambioSIMCard operation successful result event
        * @param The listener function
        */
       function addejecutarCambioSIMCardEventListener(listener:Function):void;
       
       
        /**
         * The ejecutarCambioSIMCard operation request wrapper
         */
        function get ejecutarCambioSIMCard_request_var():EjecutarCambioSIMCard_request;
        
        /**
         * @private
         */
        function set ejecutarCambioSIMCard_request_var(request:EjecutarCambioSIMCard_request):void;
                   
    	//Stub functions for the detalleLlamadas operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param codCliente
    	 * @param numAbonado
    	 * @param codCiclo
    	 * @param tipoLlamada
    	 * @return An AsyncToken
    	 */
    	function detalleLlamadas(codCliente:Number,numAbonado:Number,codCiclo:Number,tipoLlamada:String):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function detalleLlamadas_send():AsyncToken;
        
        /**
         * The detalleLlamadas operation lastResult property
         */
        function get detalleLlamadas_lastResult():ListadoDetalleLlamadosDTO;
		/**
		 * @private
		 */
        function set detalleLlamadas_lastResult(lastResult:ListadoDetalleLlamadosDTO):void;
       /**
        * Add a listener for the detalleLlamadas operation successful result event
        * @param The listener function
        */
       function adddetalleLlamadasEventListener(listener:Function):void;
       
       
        /**
         * The detalleLlamadas operation request wrapper
         */
        function get detalleLlamadas_request_var():DetalleLlamadas_request;
        
        /**
         * @private
         */
        function set detalleLlamadas_request_var(request:DetalleLlamadas_request):void;
                   
    	//Stub functions for the esPrimerLogin operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param nomUsuario
    	 * @return An AsyncToken
    	 */
    	function esPrimerLogin(nomUsuario:String):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function esPrimerLogin_send():AsyncToken;
        
        /**
         * The esPrimerLogin operation lastResult property
         */
        function get esPrimerLogin_lastResult():Boolean;
		/**
		 * @private
		 */
        function set esPrimerLogin_lastResult(lastResult:Boolean):void;
       /**
        * Add a listener for the esPrimerLogin operation successful result event
        * @param The listener function
        */
       function addesPrimerLoginEventListener(listener:Function):void;
       
       
        /**
         * The esPrimerLogin operation request wrapper
         */
        function get esPrimerLogin_request_var():EsPrimerLogin_request;
        
        /**
         * @private
         */
        function set esPrimerLogin_request_var(request:EsPrimerLogin_request):void;
                   
    	//Stub functions for the cargaNumFrecuentes operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param numAbonado
    	 * @param nomUsuarioSCL
    	 * @param codEvento
    	 * @return An AsyncToken
    	 */
    	function cargaNumFrecuentes(numAbonado:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function cargaNumFrecuentes_send():AsyncToken;
        
        /**
         * The cargaNumFrecuentes operation lastResult property
         */
        function get cargaNumFrecuentes_lastResult():CargaCambioNumFrecuentesSACDTO;
		/**
		 * @private
		 */
        function set cargaNumFrecuentes_lastResult(lastResult:CargaCambioNumFrecuentesSACDTO):void;
       /**
        * Add a listener for the cargaNumFrecuentes operation successful result event
        * @param The listener function
        */
       function addcargaNumFrecuentesEventListener(listener:Function):void;
       
       
        /**
         * The cargaNumFrecuentes operation request wrapper
         */
        function get cargaNumFrecuentes_request_var():CargaNumFrecuentes_request;
        
        /**
         * @private
         */
        function set cargaNumFrecuentes_request_var(request:CargaNumFrecuentes_request):void;
                   
    	//Stub functions for the clientesXCodCliente operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param codCliente
    	 * @return An AsyncToken
    	 */
    	function clientesXCodCliente(codCliente:Number):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function clientesXCodCliente_send():AsyncToken;
        
        /**
         * The clientesXCodCliente operation lastResult property
         */
        function get clientesXCodCliente_lastResult():ListadoClientesDTO;
		/**
		 * @private
		 */
        function set clientesXCodCliente_lastResult(lastResult:ListadoClientesDTO):void;
       /**
        * Add a listener for the clientesXCodCliente operation successful result event
        * @param The listener function
        */
       function addclientesXCodClienteEventListener(listener:Function):void;
       
       
        /**
         * The clientesXCodCliente operation request wrapper
         */
        function get clientesXCodCliente_request_var():ClientesXCodCliente_request;
        
        /**
         * @private
         */
        function set clientesXCodCliente_request_var(request:ClientesXCodCliente_request):void;
                   
    	//Stub functions for the obtenerOoSsProceso operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param nomUsuario
    	 * @return An AsyncToken
    	 */
    	function obtenerOoSsProceso(nomUsuario:String):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function obtenerOoSsProceso_send():AsyncToken;
        
        /**
         * The obtenerOoSsProceso operation lastResult property
         */
        function get obtenerOoSsProceso_lastResult():ListadoOrdenesProcesoDTO;
		/**
		 * @private
		 */
        function set obtenerOoSsProceso_lastResult(lastResult:ListadoOrdenesProcesoDTO):void;
       /**
        * Add a listener for the obtenerOoSsProceso operation successful result event
        * @param The listener function
        */
       function addobtenerOoSsProcesoEventListener(listener:Function):void;
       
       
        /**
         * The obtenerOoSsProceso operation request wrapper
         */
        function get obtenerOoSsProceso_request_var():ObtenerOoSsProceso_request;
        
        /**
         * @private
         */
        function set obtenerOoSsProceso_request_var(request:ObtenerOoSsProceso_request):void;
                   
    	//Stub functions for the ajustesXCodCliente operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param codCliente
    	 * @return An AsyncToken
    	 */
    	function ajustesXCodCliente(codCliente:Number):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function ajustesXCodCliente_send():AsyncToken;
        
        /**
         * The ajustesXCodCliente operation lastResult property
         */
        function get ajustesXCodCliente_lastResult():ListadoAjustesDTO;
		/**
		 * @private
		 */
        function set ajustesXCodCliente_lastResult(lastResult:ListadoAjustesDTO):void;
       /**
        * Add a listener for the ajustesXCodCliente operation successful result event
        * @param The listener function
        */
       function addajustesXCodClienteEventListener(listener:Function):void;
       
       
        /**
         * The ajustesXCodCliente operation request wrapper
         */
        function get ajustesXCodCliente_request_var():AjustesXCodCliente_request;
        
        /**
         * @private
         */
        function set ajustesXCodCliente_request_var(request:AjustesXCodCliente_request):void;
                   
    	//Stub functions for the cambiosPlanAbonadoPospago operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param numOS
    	 * @return An AsyncToken
    	 */
    	function cambiosPlanAbonadoPospago(numOS:Number):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function cambiosPlanAbonadoPospago_send():AsyncToken;
        
        /**
         * The cambiosPlanAbonadoPospago operation lastResult property
         */
        function get cambiosPlanAbonadoPospago_lastResult():ListadoCambiosPlanTarifDTO;
		/**
		 * @private
		 */
        function set cambiosPlanAbonadoPospago_lastResult(lastResult:ListadoCambiosPlanTarifDTO):void;
       /**
        * Add a listener for the cambiosPlanAbonadoPospago operation successful result event
        * @param The listener function
        */
       function addcambiosPlanAbonadoPospagoEventListener(listener:Function):void;
       
       
        /**
         * The cambiosPlanAbonadoPospago operation request wrapper
         */
        function get cambiosPlanAbonadoPospago_request_var():CambiosPlanAbonadoPospago_request;
        
        /**
         * @private
         */
        function set cambiosPlanAbonadoPospago_request_var(request:CambiosPlanAbonadoPospago_request):void;
                   
    	//Stub functions for the consultaOoSsProceso operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param nomUsuario
    	 * @return An AsyncToken
    	 */
    	function consultaOoSsProceso(nomUsuario:String):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function consultaOoSsProceso_send():AsyncToken;
        
        /**
         * The consultaOoSsProceso operation lastResult property
         */
        function get consultaOoSsProceso_lastResult():Boolean;
		/**
		 * @private
		 */
        function set consultaOoSsProceso_lastResult(lastResult:Boolean):void;
       /**
        * Add a listener for the consultaOoSsProceso operation successful result event
        * @param The listener function
        */
       function addconsultaOoSsProcesoEventListener(listener:Function):void;
       
       
        /**
         * The consultaOoSsProceso operation request wrapper
         */
        function get consultaOoSsProceso_request_var():ConsultaOoSsProceso_request;
        
        /**
         * @private
         */
        function set consultaOoSsProceso_request_var(request:ConsultaOoSsProceso_request):void;
                   
    	//Stub functions for the ingresoAtencion operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param resgistroAtencionDTO
    	 * @return An AsyncToken
    	 */
    	function ingresoAtencion(resgistroAtencionDTO:ResgistroAtencionDTO):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function ingresoAtencion_send():AsyncToken;
        
        /**
         * The ingresoAtencion operation lastResult property
         */
        function get ingresoAtencion_lastResult():ResulTransaccionDTO;
		/**
		 * @private
		 */
        function set ingresoAtencion_lastResult(lastResult:ResulTransaccionDTO):void;
       /**
        * Add a listener for the ingresoAtencion operation successful result event
        * @param The listener function
        */
       function addingresoAtencionEventListener(listener:Function):void;
       
       
        /**
         * The ingresoAtencion operation request wrapper
         */
        function get ingresoAtencion_request_var():IngresoAtencion_request;
        
        /**
         * @private
         */
        function set ingresoAtencion_request_var(request:IngresoAtencion_request):void;
                   
    	//Stub functions for the decirHelloWorld operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @return An AsyncToken
    	 */
    	function decirHelloWorld():AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function decirHelloWorld_send():AsyncToken;
        
        /**
         * The decirHelloWorld operation lastResult property
         */
        function get decirHelloWorld_lastResult():String;
		/**
		 * @private
		 */
        function set decirHelloWorld_lastResult(lastResult:String):void;
       /**
        * Add a listener for the decirHelloWorld operation successful result event
        * @param The listener function
        */
       function adddecirHelloWorldEventListener(listener:Function):void;
       
       
    	//Stub functions for the cambiarDireccionesCliente operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param dto
    	 * @return An AsyncToken
    	 */
    	function cambiarDireccionesCliente(dto:ListadoDireccionesSACDTO):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function cambiarDireccionesCliente_send():AsyncToken;
        
        /**
         * The cambiarDireccionesCliente operation lastResult property
         */
        function get cambiarDireccionesCliente_lastResult():ListadoOrdenesServicioSACDTO;
		/**
		 * @private
		 */
        function set cambiarDireccionesCliente_lastResult(lastResult:ListadoOrdenesServicioSACDTO):void;
       /**
        * Add a listener for the cambiarDireccionesCliente operation successful result event
        * @param The listener function
        */
       function addcambiarDireccionesClienteEventListener(listener:Function):void;
       
       
        /**
         * The cambiarDireccionesCliente operation request wrapper
         */
        function get cambiarDireccionesCliente_request_var():CambiarDireccionesCliente_request;
        
        /**
         * @private
         */
        function set cambiarDireccionesCliente_request_var(request:CambiarDireccionesCliente_request):void;
                   
    	//Stub functions for the consultaAtencion operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @return An AsyncToken
    	 */
    	function consultaAtencion():AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function consultaAtencion_send():AsyncToken;
        
        /**
         * The consultaAtencion operation lastResult property
         */
        function get consultaAtencion_lastResult():ListaAtencionClienteDTO;
		/**
		 * @private
		 */
        function set consultaAtencion_lastResult(lastResult:ListaAtencionClienteDTO):void;
       /**
        * Add a listener for the consultaAtencion operation successful result event
        * @param The listener function
        */
       function addconsultaAtencionEventListener(listener:Function):void;
       
       
    	//Stub functions for the obtenerCausalCambio operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @return An AsyncToken
    	 */
    	function obtenerCausalCambio():AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function obtenerCausalCambio_send():AsyncToken;
        
        /**
         * The obtenerCausalCambio operation lastResult property
         */
        function get obtenerCausalCambio_lastResult():ListaCausalCambioDTO;
		/**
		 * @private
		 */
        function set obtenerCausalCambio_lastResult(lastResult:ListaCausalCambioDTO):void;
       /**
        * Add a listener for the obtenerCausalCambio operation successful result event
        * @param The listener function
        */
       function addobtenerCausalCambioEventListener(listener:Function):void;
       
       
    	//Stub functions for the cambiarPassword operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param usuario
    	 * @param passwordActual
    	 * @param passwordNueva
    	 * @return An AsyncToken
    	 */
    	function cambiarPassword(usuario:String,passwordActual:String,passwordNueva:String):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function cambiarPassword_send():AsyncToken;
        
        /**
         * The cambiarPassword operation lastResult property
         */
        function get cambiarPassword_lastResult():Boolean;
		/**
		 * @private
		 */
        function set cambiarPassword_lastResult(lastResult:Boolean):void;
       /**
        * Add a listener for the cambiarPassword operation successful result event
        * @param The listener function
        */
       function addcambiarPasswordEventListener(listener:Function):void;
       
       
        /**
         * The cambiarPassword operation request wrapper
         */
        function get cambiarPassword_request_var():CambiarPassword_request;
        
        /**
         * @private
         */
        function set cambiarPassword_request_var(request:CambiarPassword_request):void;
                   
    	//Stub functions for the direccionesXCodCliente operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param codCliente
    	 * @param nomUsuarioSCL
    	 * @param codEvento
    	 * @return An AsyncToken
    	 */
    	function direccionesXCodCliente(codCliente:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function direccionesXCodCliente_send():AsyncToken;
        
        /**
         * The direccionesXCodCliente operation lastResult property
         */
        function get direccionesXCodCliente_lastResult():ListadoDireccionesDTO;
		/**
		 * @private
		 */
        function set direccionesXCodCliente_lastResult(lastResult:ListadoDireccionesDTO):void;
       /**
        * Add a listener for the direccionesXCodCliente operation successful result event
        * @param The listener function
        */
       function adddireccionesXCodClienteEventListener(listener:Function):void;
       
       
        /**
         * The direccionesXCodCliente operation request wrapper
         */
        function get direccionesXCodCliente_request_var():DireccionesXCodCliente_request;
        
        /**
         * @private
         */
        function set direccionesXCodCliente_request_var(request:DireccionesXCodCliente_request):void;
                   
    	//Stub functions for the cargarAbonoLimiteConsumoSS operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param codSujeto
    	 * @param tipoAbono
    	 * @param tipoOOSS
    	 * @param nomUsuarioSCL
    	 * @param codEvento
    	 * @return An AsyncToken
    	 */
    	function cargarAbonoLimiteConsumoSS(codSujeto:Number,tipoAbono:String,tipoOOSS:String,nomUsuarioSCL:String,codEvento:String):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function cargarAbonoLimiteConsumoSS_send():AsyncToken;
        
        /**
         * The cargarAbonoLimiteConsumoSS operation lastResult property
         */
        function get cargarAbonoLimiteConsumoSS_lastResult():CargaAbonoLimiteConsumoServicioSuplementarioDTO;
		/**
		 * @private
		 */
        function set cargarAbonoLimiteConsumoSS_lastResult(lastResult:CargaAbonoLimiteConsumoServicioSuplementarioDTO):void;
       /**
        * Add a listener for the cargarAbonoLimiteConsumoSS operation successful result event
        * @param The listener function
        */
       function addcargarAbonoLimiteConsumoSSEventListener(listener:Function):void;
       
       
        /**
         * The cargarAbonoLimiteConsumoSS operation request wrapper
         */
        function get cargarAbonoLimiteConsumoSS_request_var():CargarAbonoLimiteConsumoSS_request;
        
        /**
         * @private
         */
        function set cargarAbonoLimiteConsumoSS_request_var(request:CargarAbonoLimiteConsumoSS_request):void;
                   
    	//Stub functions for the ejecutarSuspensionSrvCelular operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param entrada
    	 * @return An AsyncToken
    	 */
    	function ejecutarSuspensionSrvCelular(entrada:EjecucionSuspensionSrvCelDTO):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function ejecutarSuspensionSrvCelular_send():AsyncToken;
        
        /**
         * The ejecutarSuspensionSrvCelular operation lastResult property
         */
        function get ejecutarSuspensionSrvCelular_lastResult():EjecucionSuspensionSrvCelDTO;
		/**
		 * @private
		 */
        function set ejecutarSuspensionSrvCelular_lastResult(lastResult:EjecucionSuspensionSrvCelDTO):void;
       /**
        * Add a listener for the ejecutarSuspensionSrvCelular operation successful result event
        * @param The listener function
        */
       function addejecutarSuspensionSrvCelularEventListener(listener:Function):void;
       
       
        /**
         * The ejecutarSuspensionSrvCelular operation request wrapper
         */
        function get ejecutarSuspensionSrvCelular_request_var():EjecutarSuspensionSrvCelular_request;
        
        /**
         * @private
         */
        function set ejecutarSuspensionSrvCelular_request_var(request:EjecutarSuspensionSrvCelular_request):void;
                   
    	//Stub functions for the cargaServicioCargos operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param entrada
    	 * @param ventaSimcard
    	 * @return An AsyncToken
    	 */
    	function cargaServicioCargos(entrada:CargaServicioCargosDTO,ventaSimcard:String):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function cargaServicioCargos_send():AsyncToken;
        
        /**
         * The cargaServicioCargos operation lastResult property
         */
        function get cargaServicioCargos_lastResult():CargaServicioCargosDTO;
		/**
		 * @private
		 */
        function set cargaServicioCargos_lastResult(lastResult:CargaServicioCargosDTO):void;
       /**
        * Add a listener for the cargaServicioCargos operation successful result event
        * @param The listener function
        */
       function addcargaServicioCargosEventListener(listener:Function):void;
       
       
        /**
         * The cargaServicioCargos operation request wrapper
         */
        function get cargaServicioCargos_request_var():CargaServicioCargos_request;
        
        /**
         * @private
         */
        function set cargaServicioCargos_request_var(request:CargaServicioCargos_request):void;
                   
    	//Stub functions for the oossEjecutadasXCodCuenta operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param codCuenta
    	 * @param nomUsuarioSCL
    	 * @param codEvento
    	 * @return An AsyncToken
    	 */
    	function oossEjecutadasXCodCuenta(codCuenta:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function oossEjecutadasXCodCuenta_send():AsyncToken;
        
        /**
         * The oossEjecutadasXCodCuenta operation lastResult property
         */
        function get oossEjecutadasXCodCuenta_lastResult():ListadoOrdenesServicioDTO;
		/**
		 * @private
		 */
        function set oossEjecutadasXCodCuenta_lastResult(lastResult:ListadoOrdenesServicioDTO):void;
       /**
        * Add a listener for the oossEjecutadasXCodCuenta operation successful result event
        * @param The listener function
        */
       function addoossEjecutadasXCodCuentaEventListener(listener:Function):void;
       
       
        /**
         * The oossEjecutadasXCodCuenta operation request wrapper
         */
        function get oossEjecutadasXCodCuenta_request_var():OossEjecutadasXCodCuenta_request;
        
        /**
         * @private
         */
        function set oossEjecutadasXCodCuenta_request_var(request:OossEjecutadasXCodCuenta_request):void;
                   
    	//Stub functions for the consultaOrdenServicio operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param codOOSS
    	 * @param numTransaccion
    	 * @param nomUsuarioSCL
    	 * @return An AsyncToken
    	 */
    	function consultaOrdenServicio(codOOSS:Number,numTransaccion:String,nomUsuarioSCL:String):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function consultaOrdenServicio_send():AsyncToken;
        
        /**
         * The consultaOrdenServicio operation lastResult property
         */
        function get consultaOrdenServicio_lastResult():ConsultarOrdenServicioSACDTO;
		/**
		 * @private
		 */
        function set consultaOrdenServicio_lastResult(lastResult:ConsultarOrdenServicioSACDTO):void;
       /**
        * Add a listener for the consultaOrdenServicio operation successful result event
        * @param The listener function
        */
       function addconsultaOrdenServicioEventListener(listener:Function):void;
       
       
        /**
         * The consultaOrdenServicio operation request wrapper
         */
        function get consultaOrdenServicio_request_var():ConsultaOrdenServicio_request;
        
        /**
         * @private
         */
        function set consultaOrdenServicio_request_var(request:ConsultaOrdenServicio_request):void;
                   
    	//Stub functions for the facturasXCodCliente operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param codCliente
    	 * @param nomUsuarioSCL
    	 * @param codEvento
    	 * @return An AsyncToken
    	 */
    	function facturasXCodCliente(codCliente:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function facturasXCodCliente_send():AsyncToken;
        
        /**
         * The facturasXCodCliente operation lastResult property
         */
        function get facturasXCodCliente_lastResult():ListadoFacturasDTO;
		/**
		 * @private
		 */
        function set facturasXCodCliente_lastResult(lastResult:ListadoFacturasDTO):void;
       /**
        * Add a listener for the facturasXCodCliente operation successful result event
        * @param The listener function
        */
       function addfacturasXCodClienteEventListener(listener:Function):void;
       
       
        /**
         * The facturasXCodCliente operation request wrapper
         */
        function get facturasXCodCliente_request_var():FacturasXCodCliente_request;
        
        /**
         * @private
         */
        function set facturasXCodCliente_request_var(request:FacturasXCodCliente_request):void;
                   
    	//Stub functions for the pagoLimiteConsumoXClienteAbonado operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param codCliente
    	 * @param numAbonado
    	 * @param nomUsuarioSCL
    	 * @param codEvento
    	 * @return An AsyncToken
    	 */
    	function pagoLimiteConsumoXClienteAbonado(codCliente:Number,numAbonado:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function pagoLimiteConsumoXClienteAbonado_send():AsyncToken;
        
        /**
         * The pagoLimiteConsumoXClienteAbonado operation lastResult property
         */
        function get pagoLimiteConsumoXClienteAbonado_lastResult():ListadoPagosLimiteConsumoDTO;
		/**
		 * @private
		 */
        function set pagoLimiteConsumoXClienteAbonado_lastResult(lastResult:ListadoPagosLimiteConsumoDTO):void;
       /**
        * Add a listener for the pagoLimiteConsumoXClienteAbonado operation successful result event
        * @param The listener function
        */
       function addpagoLimiteConsumoXClienteAbonadoEventListener(listener:Function):void;
       
       
        /**
         * The pagoLimiteConsumoXClienteAbonado operation request wrapper
         */
        function get pagoLimiteConsumoXClienteAbonado_request_var():PagoLimiteConsumoXClienteAbonado_request;
        
        /**
         * @private
         */
        function set pagoLimiteConsumoXClienteAbonado_request_var(request:PagoLimiteConsumoXClienteAbonado_request):void;
                   
    	//Stub functions for the pagosXCodCliente operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param codCliente
    	 * @param nomUsuarioSCL
    	 * @param codEvento
    	 * @return An AsyncToken
    	 */
    	function pagosXCodCliente(codCliente:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function pagosXCodCliente_send():AsyncToken;
        
        /**
         * The pagosXCodCliente operation lastResult property
         */
        function get pagosXCodCliente_lastResult():ListadoPagosDTO;
		/**
		 * @private
		 */
        function set pagosXCodCliente_lastResult(lastResult:ListadoPagosDTO):void;
       /**
        * Add a listener for the pagosXCodCliente operation successful result event
        * @param The listener function
        */
       function addpagosXCodClienteEventListener(listener:Function):void;
       
       
        /**
         * The pagosXCodCliente operation request wrapper
         */
        function get pagosXCodCliente_request_var():PagosXCodCliente_request;
        
        /**
         * @private
         */
        function set pagosXCodCliente_request_var(request:PagosXCodCliente_request):void;
                   
    	//Stub functions for the cambiosPlanCliente operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param numOS
    	 * @return An AsyncToken
    	 */
    	function cambiosPlanCliente(numOS:Number):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function cambiosPlanCliente_send():AsyncToken;
        
        /**
         * The cambiosPlanCliente operation lastResult property
         */
        function get cambiosPlanCliente_lastResult():ListadoCambiosPlanTarifDTO;
		/**
		 * @private
		 */
        function set cambiosPlanCliente_lastResult(lastResult:ListadoCambiosPlanTarifDTO):void;
       /**
        * Add a listener for the cambiosPlanCliente operation successful result event
        * @param The listener function
        */
       function addcambiosPlanClienteEventListener(listener:Function):void;
       
       
        /**
         * The cambiosPlanCliente operation request wrapper
         */
        function get cambiosPlanCliente_request_var():CambiosPlanCliente_request;
        
        /**
         * @private
         */
        function set cambiosPlanCliente_request_var(request:CambiosPlanCliente_request):void;
                   
    	//Stub functions for the ejecutarAjusteCExcepcionCargos operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param entrada
    	 * @return An AsyncToken
    	 */
    	function ejecutarAjusteCExcepcionCargos(entrada:EjecucionAjusteCExcepcionCargosSACDTO):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function ejecutarAjusteCExcepcionCargos_send():AsyncToken;
        
        /**
         * The ejecutarAjusteCExcepcionCargos operation lastResult property
         */
        function get ejecutarAjusteCExcepcionCargos_lastResult():EjecucionAjusteCExcepcionCargosDTO;
		/**
		 * @private
		 */
        function set ejecutarAjusteCExcepcionCargos_lastResult(lastResult:EjecucionAjusteCExcepcionCargosDTO):void;
       /**
        * Add a listener for the ejecutarAjusteCExcepcionCargos operation successful result event
        * @param The listener function
        */
       function addejecutarAjusteCExcepcionCargosEventListener(listener:Function):void;
       
       
        /**
         * The ejecutarAjusteCExcepcionCargos operation request wrapper
         */
        function get ejecutarAjusteCExcepcionCargos_request_var():EjecutarAjusteCExcepcionCargos_request;
        
        /**
         * @private
         */
        function set ejecutarAjusteCExcepcionCargos_request_var(request:EjecutarAjusteCExcepcionCargos_request):void;
                   
    	//Stub functions for the beneficiosXClienteAbonado operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param codCliente
    	 * @param numAbonado
    	 * @param nomUsuarioSCL
    	 * @param codEvento
    	 * @return An AsyncToken
    	 */
    	function beneficiosXClienteAbonado(codCliente:Number,numAbonado:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function beneficiosXClienteAbonado_send():AsyncToken;
        
        /**
         * The beneficiosXClienteAbonado operation lastResult property
         */
        function get beneficiosXClienteAbonado_lastResult():ListadoBeneficiosDTO;
		/**
		 * @private
		 */
        function set beneficiosXClienteAbonado_lastResult(lastResult:ListadoBeneficiosDTO):void;
       /**
        * Add a listener for the beneficiosXClienteAbonado operation successful result event
        * @param The listener function
        */
       function addbeneficiosXClienteAbonadoEventListener(listener:Function):void;
       
       
        /**
         * The beneficiosXClienteAbonado operation request wrapper
         */
        function get beneficiosXClienteAbonado_request_var():BeneficiosXClienteAbonado_request;
        
        /**
         * @private
         */
        function set beneficiosXClienteAbonado_request_var(request:BeneficiosXClienteAbonado_request):void;
                   
    	//Stub functions for the insertComentarioPvIorserv operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param comentario
    	 * @param numOoss
    	 * @return An AsyncToken
    	 */
    	function insertComentarioPvIorserv(comentario:String,numOoss:Number):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function insertComentarioPvIorserv_send():AsyncToken;
        
        /**
         * The insertComentarioPvIorserv operation lastResult property
         */
        function get insertComentarioPvIorserv_lastResult():ResulTransaccionDTO;
		/**
		 * @private
		 */
        function set insertComentarioPvIorserv_lastResult(lastResult:ResulTransaccionDTO):void;
       /**
        * Add a listener for the insertComentarioPvIorserv operation successful result event
        * @param The listener function
        */
       function addinsertComentarioPvIorservEventListener(listener:Function):void;
       
       
        /**
         * The insertComentarioPvIorserv operation request wrapper
         */
        function get insertComentarioPvIorserv_request_var():InsertComentarioPvIorserv_request;
        
        /**
         * @private
         */
        function set insertComentarioPvIorserv_request_var(request:InsertComentarioPvIorserv_request):void;
                   
    	//Stub functions for the realizarBloqueoRobo operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param dto
    	 * @return An AsyncToken
    	 */
    	function realizarBloqueoRobo(dto:RealizarBloqueoRoboSACINDTO):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function realizarBloqueoRobo_send():AsyncToken;
        
        /**
         * The realizarBloqueoRobo operation lastResult property
         */
        function get realizarBloqueoRobo_lastResult():RealizarBloqueoRoboSACOUTDTO;
		/**
		 * @private
		 */
        function set realizarBloqueoRobo_lastResult(lastResult:RealizarBloqueoRoboSACOUTDTO):void;
       /**
        * Add a listener for the realizarBloqueoRobo operation successful result event
        * @param The listener function
        */
       function addrealizarBloqueoRoboEventListener(listener:Function):void;
       
       
        /**
         * The realizarBloqueoRobo operation request wrapper
         */
        function get realizarBloqueoRobo_request_var():RealizarBloqueoRobo_request;
        
        /**
         * @private
         */
        function set realizarBloqueoRobo_request_var(request:RealizarBloqueoRobo_request):void;
                   
    	//Stub functions for the cuentasXNumIdent operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param numIdent
    	 * @return An AsyncToken
    	 */
    	function cuentasXNumIdent(numIdent:String):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function cuentasXNumIdent_send():AsyncToken;
        
        /**
         * The cuentasXNumIdent operation lastResult property
         */
        function get cuentasXNumIdent_lastResult():ListadoCuentasDTO;
		/**
		 * @private
		 */
        function set cuentasXNumIdent_lastResult(lastResult:ListadoCuentasDTO):void;
       /**
        * Add a listener for the cuentasXNumIdent operation successful result event
        * @param The listener function
        */
       function addcuentasXNumIdentEventListener(listener:Function):void;
       
       
        /**
         * The cuentasXNumIdent operation request wrapper
         */
        function get cuentasXNumIdent_request_var():CuentasXNumIdent_request;
        
        /**
         * @private
         */
        function set cuentasXNumIdent_request_var(request:CuentasXNumIdent_request):void;
                   
    	//Stub functions for the ejecutarCambioNumFrecuente operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param entrada
    	 * @return An AsyncToken
    	 */
    	function ejecutarCambioNumFrecuente(entrada:EjecucionCambioNumFrecuentesSACDTO):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function ejecutarCambioNumFrecuente_send():AsyncToken;
        
        /**
         * The ejecutarCambioNumFrecuente operation lastResult property
         */
        function get ejecutarCambioNumFrecuente_lastResult():EjecucionCambioNumFrecuentesSACDTO;
		/**
		 * @private
		 */
        function set ejecutarCambioNumFrecuente_lastResult(lastResult:EjecucionCambioNumFrecuentesSACDTO):void;
       /**
        * Add a listener for the ejecutarCambioNumFrecuente operation successful result event
        * @param The listener function
        */
       function addejecutarCambioNumFrecuenteEventListener(listener:Function):void;
       
       
        /**
         * The ejecutarCambioNumFrecuente operation request wrapper
         */
        function get ejecutarCambioNumFrecuente_request_var():EjecutarCambioNumFrecuente_request;
        
        /**
         * @private
         */
        function set ejecutarCambioNumFrecuente_request_var(request:EjecutarCambioNumFrecuente_request):void;
                   
    	//Stub functions for the obtenerReportePresEquiInt operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param fechaDesde
    	 * @param fechaHasta
    	 * @return An AsyncToken
    	 */
    	function obtenerReportePresEquiInt(fechaDesde:String,fechaHasta:String):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function obtenerReportePresEquiInt_send():AsyncToken;
        
        /**
         * The obtenerReportePresEquiInt operation lastResult property
         */
        function get obtenerReportePresEquiInt_lastResult():ListadoReportePresEquiIntDTO;
		/**
		 * @private
		 */
        function set obtenerReportePresEquiInt_lastResult(lastResult:ListadoReportePresEquiIntDTO):void;
       /**
        * Add a listener for the obtenerReportePresEquiInt operation successful result event
        * @param The listener function
        */
       function addobtenerReportePresEquiIntEventListener(listener:Function):void;
       
       
        /**
         * The obtenerReportePresEquiInt operation request wrapper
         */
        function get obtenerReportePresEquiInt_request_var():ObtenerReportePresEquiInt_request;
        
        /**
         * @private
         */
        function set obtenerReportePresEquiInt_request_var(request:ObtenerReportePresEquiInt_request):void;
                   
    	//Stub functions for the crearUsuario operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param usuario
    	 * @param password
    	 * @param passwordConfirmada
    	 * @return An AsyncToken
    	 */
    	function crearUsuario(usuario:String,password:String,passwordConfirmada:String):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function crearUsuario_send():AsyncToken;
        
        /**
         * The crearUsuario operation lastResult property
         */
        function get crearUsuario_lastResult():Boolean;
		/**
		 * @private
		 */
        function set crearUsuario_lastResult(lastResult:Boolean):void;
       /**
        * Add a listener for the crearUsuario operation successful result event
        * @param The listener function
        */
       function addcrearUsuarioEventListener(listener:Function):void;
       
       
        /**
         * The crearUsuario operation request wrapper
         */
        function get crearUsuario_request_var():CrearUsuario_request;
        
        /**
         * @private
         */
        function set crearUsuario_request_var(request:CrearUsuario_request):void;
                   
    	//Stub functions for the obtenerListDatosAbonados operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param codCliente
    	 * @return An AsyncToken
    	 */
    	function obtenerListDatosAbonados(codCliente:Number):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function obtenerListDatosAbonados_send():AsyncToken;
        
        /**
         * The obtenerListDatosAbonados operation lastResult property
         */
        function get obtenerListDatosAbonados_lastResult():ListadoAbonadosDTO;
		/**
		 * @private
		 */
        function set obtenerListDatosAbonados_lastResult(lastResult:ListadoAbonadosDTO):void;
       /**
        * Add a listener for the obtenerListDatosAbonados operation successful result event
        * @param The listener function
        */
       function addobtenerListDatosAbonadosEventListener(listener:Function):void;
       
       
        /**
         * The obtenerListDatosAbonados operation request wrapper
         */
        function get obtenerListDatosAbonados_request_var():ObtenerListDatosAbonados_request;
        
        /**
         * @private
         */
        function set obtenerListDatosAbonados_request_var(request:ObtenerListDatosAbonados_request):void;
                   
    	//Stub functions for the getDetalleAbonado operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param numAbonado
    	 * @param nomUsuarioSCL
    	 * @param codEvento
    	 * @return An AsyncToken
    	 */
    	function getDetalleAbonado(numAbonado:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function getDetalleAbonado_send():AsyncToken;
        
        /**
         * The getDetalleAbonado operation lastResult property
         */
        function get getDetalleAbonado_lastResult():DetalleAbonadoDTO;
		/**
		 * @private
		 */
        function set getDetalleAbonado_lastResult(lastResult:DetalleAbonadoDTO):void;
       /**
        * Add a listener for the getDetalleAbonado operation successful result event
        * @param The listener function
        */
       function addgetDetalleAbonadoEventListener(listener:Function):void;
       
       
        /**
         * The getDetalleAbonado operation request wrapper
         */
        function get getDetalleAbonado_request_var():GetDetalleAbonado_request;
        
        /**
         * @private
         */
        function set getDetalleAbonado_request_var(request:GetDetalleAbonado_request):void;
                   
    	//Stub functions for the productosXCodCliente operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param codCliente
    	 * @param nomUsuarioSCL
    	 * @param codEvento
    	 * @return An AsyncToken
    	 */
    	function productosXCodCliente(codCliente:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function productosXCodCliente_send():AsyncToken;
        
        /**
         * The productosXCodCliente operation lastResult property
         */
        function get productosXCodCliente_lastResult():ListadoProductosDTO;
		/**
		 * @private
		 */
        function set productosXCodCliente_lastResult(lastResult:ListadoProductosDTO):void;
       /**
        * Add a listener for the productosXCodCliente operation successful result event
        * @param The listener function
        */
       function addproductosXCodClienteEventListener(listener:Function):void;
       
       
        /**
         * The productosXCodCliente operation request wrapper
         */
        function get productosXCodCliente_request_var():ProductosXCodCliente_request;
        
        /**
         * @private
         */
        function set productosXCodCliente_request_var(request:ProductosXCodCliente_request):void;
                   
    	//Stub functions for the oossEjecutadasXCodCliente operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param codCliente
    	 * @param nomUsuarioSCL
    	 * @param codEvento
    	 * @return An AsyncToken
    	 */
    	function oossEjecutadasXCodCliente(codCliente:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function oossEjecutadasXCodCliente_send():AsyncToken;
        
        /**
         * The oossEjecutadasXCodCliente operation lastResult property
         */
        function get oossEjecutadasXCodCliente_lastResult():ListadoOrdenesServicioDTO;
		/**
		 * @private
		 */
        function set oossEjecutadasXCodCliente_lastResult(lastResult:ListadoOrdenesServicioDTO):void;
       /**
        * Add a listener for the oossEjecutadasXCodCliente operation successful result event
        * @param The listener function
        */
       function addoossEjecutadasXCodClienteEventListener(listener:Function):void;
       
       
        /**
         * The oossEjecutadasXCodCliente operation request wrapper
         */
        function get oossEjecutadasXCodCliente_request_var():OossEjecutadasXCodCliente_request;
        
        /**
         * @private
         */
        function set oossEjecutadasXCodCliente_request_var(request:OossEjecutadasXCodCliente_request):void;
                   
    	//Stub functions for the productosXNumAbonado operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param numAbonado
    	 * @param nomUsuarioSCL
    	 * @param codEvento
    	 * @return An AsyncToken
    	 */
    	function productosXNumAbonado(numAbonado:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function productosXNumAbonado_send():AsyncToken;
        
        /**
         * The productosXNumAbonado operation lastResult property
         */
        function get productosXNumAbonado_lastResult():ListadoProductosDTO;
		/**
		 * @private
		 */
        function set productosXNumAbonado_lastResult(lastResult:ListadoProductosDTO):void;
       /**
        * Add a listener for the productosXNumAbonado operation successful result event
        * @param The listener function
        */
       function addproductosXNumAbonadoEventListener(listener:Function):void;
       
       
        /**
         * The productosXNumAbonado operation request wrapper
         */
        function get productosXNumAbonado_request_var():ProductosXNumAbonado_request;
        
        /**
         * @private
         */
        function set productosXNumAbonado_request_var(request:ProductosXNumAbonado_request):void;
                   
    	//Stub functions for the cargaValidaOSUsuario operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param usuario
    	 * @return An AsyncToken
    	 */
    	function cargaValidaOSUsuario(usuario:String):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function cargaValidaOSUsuario_send():AsyncToken;
        
        /**
         * The cargaValidaOSUsuario operation lastResult property
         */
        function get cargaValidaOSUsuario_lastResult():MenuDTO;
		/**
		 * @private
		 */
        function set cargaValidaOSUsuario_lastResult(lastResult:MenuDTO):void;
       /**
        * Add a listener for the cargaValidaOSUsuario operation successful result event
        * @param The listener function
        */
       function addcargaValidaOSUsuarioEventListener(listener:Function):void;
       
       
        /**
         * The cargaValidaOSUsuario operation request wrapper
         */
        function get cargaValidaOSUsuario_request_var():CargaValidaOSUsuario_request;
        
        /**
         * @private
         */
        function set cargaValidaOSUsuario_request_var(request:CargaValidaOSUsuario_request):void;
                   
    	//Stub functions for the cargarCambioSIMCard operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param numAbonado
    	 * @param nomUsuarioSCL
    	 * @param codEvento
    	 * @return An AsyncToken
    	 */
    	function cargarCambioSIMCard(numAbonado:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function cargarCambioSIMCard_send():AsyncToken;
        
        /**
         * The cargarCambioSIMCard operation lastResult property
         */
        function get cargarCambioSIMCard_lastResult():CargaCambioSIMCardDTO;
		/**
		 * @private
		 */
        function set cargarCambioSIMCard_lastResult(lastResult:CargaCambioSIMCardDTO):void;
       /**
        * Add a listener for the cargarCambioSIMCard operation successful result event
        * @param The listener function
        */
       function addcargarCambioSIMCardEventListener(listener:Function):void;
       
       
        /**
         * The cargarCambioSIMCard operation request wrapper
         */
        function get cargarCambioSIMCard_request_var():CargarCambioSIMCard_request;
        
        /**
         * @private
         */
        function set cargarCambioSIMCard_request_var(request:CargarCambioSIMCard_request):void;
                   
    	//Stub functions for the obtenerReporteCambioEquiGene operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param fechaDesde
    	 * @param fechaHasta
    	 * @param codCausalCam
    	 * @return An AsyncToken
    	 */
    	function obtenerReporteCambioEquiGene(fechaDesde:String,fechaHasta:String,codCausalCam:String):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function obtenerReporteCambioEquiGene_send():AsyncToken;
        
        /**
         * The obtenerReporteCambioEquiGene operation lastResult property
         */
        function get obtenerReporteCambioEquiGene_lastResult():ListadoReporteCamEquiGenDTO;
		/**
		 * @private
		 */
        function set obtenerReporteCambioEquiGene_lastResult(lastResult:ListadoReporteCamEquiGenDTO):void;
       /**
        * Add a listener for the obtenerReporteCambioEquiGene operation successful result event
        * @param The listener function
        */
       function addobtenerReporteCambioEquiGeneEventListener(listener:Function):void;
       
       
        /**
         * The obtenerReporteCambioEquiGene operation request wrapper
         */
        function get obtenerReporteCambioEquiGene_request_var():ObtenerReporteCambioEquiGene_request;
        
        /**
         * @private
         */
        function set obtenerReporteCambioEquiGene_request_var(request:ObtenerReporteCambioEquiGene_request):void;
                   
    	//Stub functions for the obtenerDatosAbonado operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param numAbonado
    	 * @return An AsyncToken
    	 */
    	function obtenerDatosAbonado(numAbonado:Number):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function obtenerDatosAbonado_send():AsyncToken;
        
        /**
         * The obtenerDatosAbonado operation lastResult property
         */
        function get obtenerDatosAbonado_lastResult():AbonadoDTO;
		/**
		 * @private
		 */
        function set obtenerDatosAbonado_lastResult(lastResult:AbonadoDTO):void;
       /**
        * Add a listener for the obtenerDatosAbonado operation successful result event
        * @param The listener function
        */
       function addobtenerDatosAbonadoEventListener(listener:Function):void;
       
       
        /**
         * The obtenerDatosAbonado operation request wrapper
         */
        function get obtenerDatosAbonado_request_var():ObtenerDatosAbonado_request;
        
        /**
         * @private
         */
        function set obtenerDatosAbonado_request_var(request:ObtenerDatosAbonado_request):void;
                   
    	//Stub functions for the umtsAbonadosXCodCliente operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param codCliente
    	 * @return An AsyncToken
    	 */
    	function umtsAbonadosXCodCliente(codCliente:Number):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function umtsAbonadosXCodCliente_send():AsyncToken;
        
        /**
         * The umtsAbonadosXCodCliente operation lastResult property
         */
        function get umtsAbonadosXCodCliente_lastResult():ListadoUmtsAbonadosDTO;
		/**
		 * @private
		 */
        function set umtsAbonadosXCodCliente_lastResult(lastResult:ListadoUmtsAbonadosDTO):void;
       /**
        * Add a listener for the umtsAbonadosXCodCliente operation successful result event
        * @param The listener function
        */
       function addumtsAbonadosXCodClienteEventListener(listener:Function):void;
       
       
        /**
         * The umtsAbonadosXCodCliente operation request wrapper
         */
        function get umtsAbonadosXCodCliente_request_var():UmtsAbonadosXCodCliente_request;
        
        /**
         * @private
         */
        function set umtsAbonadosXCodCliente_request_var(request:UmtsAbonadosXCodCliente_request):void;
                   
    	//Stub functions for the cargarAjusteCExcepcionCargos operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param codCliente
    	 * @param nomUsuarioSCL
    	 * @param pwd
    	 * @param codEvento
    	 * @return An AsyncToken
    	 */
    	function cargarAjusteCExcepcionCargos(codCliente:Number,nomUsuarioSCL:String,pwd:String,codEvento:String):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function cargarAjusteCExcepcionCargos_send():AsyncToken;
        
        /**
         * The cargarAjusteCExcepcionCargos operation lastResult property
         */
        function get cargarAjusteCExcepcionCargos_lastResult():CargaAjusteCExcepcionCargosSACDTO;
		/**
		 * @private
		 */
        function set cargarAjusteCExcepcionCargos_lastResult(lastResult:CargaAjusteCExcepcionCargosSACDTO):void;
       /**
        * Add a listener for the cargarAjusteCExcepcionCargos operation successful result event
        * @param The listener function
        */
       function addcargarAjusteCExcepcionCargosEventListener(listener:Function):void;
       
       
        /**
         * The cargarAjusteCExcepcionCargos operation request wrapper
         */
        function get cargarAjusteCExcepcionCargos_request_var():CargarAjusteCExcepcionCargos_request;
        
        /**
         * @private
         */
        function set cargarAjusteCExcepcionCargos_request_var(request:CargarAjusteCExcepcionCargos_request):void;
                   
    	//Stub functions for the obtenerDatosDireccionCliente operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param pIn
    	 * @return An AsyncToken
    	 */
    	function obtenerDatosDireccionCliente(pIn:DatosDireccionClienteINDTO):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function obtenerDatosDireccionCliente_send():AsyncToken;
        
        /**
         * The obtenerDatosDireccionCliente operation lastResult property
         */
        function get obtenerDatosDireccionCliente_lastResult():DireccionPorClienteDTO;
		/**
		 * @private
		 */
        function set obtenerDatosDireccionCliente_lastResult(lastResult:DireccionPorClienteDTO):void;
       /**
        * Add a listener for the obtenerDatosDireccionCliente operation successful result event
        * @param The listener function
        */
       function addobtenerDatosDireccionClienteEventListener(listener:Function):void;
       
       
        /**
         * The obtenerDatosDireccionCliente operation request wrapper
         */
        function get obtenerDatosDireccionCliente_request_var():ObtenerDatosDireccionCliente_request;
        
        /**
         * @private
         */
        function set obtenerDatosDireccionCliente_request_var(request:ObtenerDatosDireccionCliente_request):void;
                   
    	//Stub functions for the ejecutarAbonoLimiteConsumoSS operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param entrada
    	 * @return An AsyncToken
    	 */
    	function ejecutarAbonoLimiteConsumoSS(entrada:EjecucionAbonoLimiteConsumoServicioSuplementarioDTO):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function ejecutarAbonoLimiteConsumoSS_send():AsyncToken;
        
        /**
         * The ejecutarAbonoLimiteConsumoSS operation lastResult property
         */
        function get ejecutarAbonoLimiteConsumoSS_lastResult():EjecucionAbonoLimiteConsumoServicioSuplementarioDTO;
		/**
		 * @private
		 */
        function set ejecutarAbonoLimiteConsumoSS_lastResult(lastResult:EjecucionAbonoLimiteConsumoServicioSuplementarioDTO):void;
       /**
        * Add a listener for the ejecutarAbonoLimiteConsumoSS operation successful result event
        * @param The listener function
        */
       function addejecutarAbonoLimiteConsumoSSEventListener(listener:Function):void;
       
       
        /**
         * The ejecutarAbonoLimiteConsumoSS operation request wrapper
         */
        function get ejecutarAbonoLimiteConsumoSS_request_var():EjecutarAbonoLimiteConsumoSS_request;
        
        /**
         * @private
         */
        function set ejecutarAbonoLimiteConsumoSS_request_var(request:EjecutarAbonoLimiteConsumoSS_request):void;
                   
    	//Stub functions for the ejecucionCambioDatosCliente operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param entrada
    	 * @return An AsyncToken
    	 */
    	function ejecucionCambioDatosCliente(entrada:EjecucionCambioDatosClienteSACDTO):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function ejecucionCambioDatosCliente_send():AsyncToken;
        
        /**
         * The ejecucionCambioDatosCliente operation lastResult property
         */
        function get ejecucionCambioDatosCliente_lastResult():EjecucionCambioDatosClienteSACDTO;
		/**
		 * @private
		 */
        function set ejecucionCambioDatosCliente_lastResult(lastResult:EjecucionCambioDatosClienteSACDTO):void;
       /**
        * Add a listener for the ejecucionCambioDatosCliente operation successful result event
        * @param The listener function
        */
       function addejecucionCambioDatosClienteEventListener(listener:Function):void;
       
       
        /**
         * The ejecucionCambioDatosCliente operation request wrapper
         */
        function get ejecucionCambioDatosCliente_request_var():EjecucionCambioDatosCliente_request;
        
        /**
         * @private
         */
        function set ejecucionCambioDatosCliente_request_var(request:EjecucionCambioDatosCliente_request):void;
                   
    	//Stub functions for the consultasXCodGrupo operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param codGrupo
    	 * @param codPrograma
    	 * @param numVersion
    	 * @return An AsyncToken
    	 */
    	function consultasXCodGrupo(codGrupo:String,codPrograma:String,numVersion:String):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function consultasXCodGrupo_send():AsyncToken;
        
        /**
         * The consultasXCodGrupo operation lastResult property
         */
        function get consultasXCodGrupo_lastResult():ListadoConsultasDTO;
		/**
		 * @private
		 */
        function set consultasXCodGrupo_lastResult(lastResult:ListadoConsultasDTO):void;
       /**
        * Add a listener for the consultasXCodGrupo operation successful result event
        * @param The listener function
        */
       function addconsultasXCodGrupoEventListener(listener:Function):void;
       
       
        /**
         * The consultasXCodGrupo operation request wrapper
         */
        function get consultasXCodGrupo_request_var():ConsultasXCodGrupo_request;
        
        /**
         * @private
         */
        function set consultasXCodGrupo_request_var(request:ConsultasXCodGrupo_request):void;
                   
    	//Stub functions for the cargarSuspensionSrvCelular operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param numAbonado
    	 * @param nomUsuarioSCL
    	 * @param codEvento
    	 * @return An AsyncToken
    	 */
    	function cargarSuspensionSrvCelular(numAbonado:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function cargarSuspensionSrvCelular_send():AsyncToken;
        
        /**
         * The cargarSuspensionSrvCelular operation lastResult property
         */
        function get cargarSuspensionSrvCelular_lastResult():CargaSuspensionSrvCelDTO;
		/**
		 * @private
		 */
        function set cargarSuspensionSrvCelular_lastResult(lastResult:CargaSuspensionSrvCelDTO):void;
       /**
        * Add a listener for the cargarSuspensionSrvCelular operation successful result event
        * @param The listener function
        */
       function addcargarSuspensionSrvCelularEventListener(listener:Function):void;
       
       
        /**
         * The cargarSuspensionSrvCelular operation request wrapper
         */
        function get cargarSuspensionSrvCelular_request_var():CargarSuspensionSrvCelular_request;
        
        /**
         * @private
         */
        function set cargarSuspensionSrvCelular_request_var(request:CargarSuspensionSrvCelular_request):void;
                   
    	//Stub functions for the getDetalleCliente operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param codCliente
    	 * @param nomUsuarioSCL
    	 * @param codEvento
    	 * @return An AsyncToken
    	 */
    	function getDetalleCliente(codCliente:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function getDetalleCliente_send():AsyncToken;
        
        /**
         * The getDetalleCliente operation lastResult property
         */
        function get getDetalleCliente_lastResult():DetalleClienteDTO;
		/**
		 * @private
		 */
        function set getDetalleCliente_lastResult(lastResult:DetalleClienteDTO):void;
       /**
        * Add a listener for the getDetalleCliente operation successful result event
        * @param The listener function
        */
       function addgetDetalleClienteEventListener(listener:Function):void;
       
       
        /**
         * The getDetalleCliente operation request wrapper
         */
        function get getDetalleCliente_request_var():GetDetalleCliente_request;
        
        /**
         * @private
         */
        function set getDetalleCliente_request_var(request:GetDetalleCliente_request):void;
                   
    	//Stub functions for the getDetalleEquipo operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param numAbonado
    	 * @param nomUsuarioSCL
    	 * @param codEvento
    	 * @return An AsyncToken
    	 */
    	function getDetalleEquipo(numAbonado:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function getDetalleEquipo_send():AsyncToken;
        
        /**
         * The getDetalleEquipo operation lastResult property
         */
        function get getDetalleEquipo_lastResult():EquipoSimcardDetalleDTO;
		/**
		 * @private
		 */
        function set getDetalleEquipo_lastResult(lastResult:EquipoSimcardDetalleDTO):void;
       /**
        * Add a listener for the getDetalleEquipo operation successful result event
        * @param The listener function
        */
       function addgetDetalleEquipoEventListener(listener:Function):void;
       
       
        /**
         * The getDetalleEquipo operation request wrapper
         */
        function get getDetalleEquipo_request_var():GetDetalleEquipo_request;
        
        /**
         * @private
         */
        function set getDetalleEquipo_request_var(request:GetDetalleEquipo_request):void;
                   
    	//Stub functions for the getDeudaCliente operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param codCliente
    	 * @return An AsyncToken
    	 */
    	function getDeudaCliente(codCliente:Number):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function getDeudaCliente_send():AsyncToken;
        
        /**
         * The getDeudaCliente operation lastResult property
         */
        function get getDeudaCliente_lastResult():DeudaClienteDTO;
		/**
		 * @private
		 */
        function set getDeudaCliente_lastResult(lastResult:DeudaClienteDTO):void;
       /**
        * Add a listener for the getDeudaCliente operation successful result event
        * @param The listener function
        */
       function addgetDeudaClienteEventListener(listener:Function):void;
       
       
        /**
         * The getDeudaCliente operation request wrapper
         */
        function get getDeudaCliente_request_var():GetDeudaCliente_request;
        
        /**
         * @private
         */
        function set getDeudaCliente_request_var(request:GetDeudaCliente_request):void;
                   
    	//Stub functions for the consultaCuenta operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param codCuenta
    	 * @return An AsyncToken
    	 */
    	function consultaCuenta(codCuenta:Number):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function consultaCuenta_send():AsyncToken;
        
        /**
         * The consultaCuenta operation lastResult property
         */
        function get consultaCuenta_lastResult():ListadoAbonadosDTO;
		/**
		 * @private
		 */
        function set consultaCuenta_lastResult(lastResult:ListadoAbonadosDTO):void;
       /**
        * Add a listener for the consultaCuenta operation successful result event
        * @param The listener function
        */
       function addconsultaCuentaEventListener(listener:Function):void;
       
       
        /**
         * The consultaCuenta operation request wrapper
         */
        function get consultaCuenta_request_var():ConsultaCuenta_request;
        
        /**
         * @private
         */
        function set consultaCuenta_request_var(request:ConsultaCuenta_request):void;
                   
    	//Stub functions for the solicitaUrlDominioPuerto operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param strCodOrdenServ
    	 * @return An AsyncToken
    	 */
    	function solicitaUrlDominioPuerto(strCodOrdenServ:String):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function solicitaUrlDominioPuerto_send():AsyncToken;
        
        /**
         * The solicitaUrlDominioPuerto operation lastResult property
         */
        function get solicitaUrlDominioPuerto_lastResult():MuestraURLDTO;
		/**
		 * @private
		 */
        function set solicitaUrlDominioPuerto_lastResult(lastResult:MuestraURLDTO):void;
       /**
        * Add a listener for the solicitaUrlDominioPuerto operation successful result event
        * @param The listener function
        */
       function addsolicitaUrlDominioPuertoEventListener(listener:Function):void;
       
       
        /**
         * The solicitaUrlDominioPuerto operation request wrapper
         */
        function get solicitaUrlDominioPuerto_request_var():SolicitaUrlDominioPuerto_request;
        
        /**
         * @private
         */
        function set solicitaUrlDominioPuerto_request_var(request:SolicitaUrlDominioPuerto_request):void;
                   
    	//Stub functions for the cargarAjusteCReversionCargos operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param codCliente
    	 * @param nomUsuarioSCL
    	 * @param pwd
    	 * @param codEvento
    	 * @return An AsyncToken
    	 */
    	function cargarAjusteCReversionCargos(codCliente:Number,nomUsuarioSCL:String,pwd:String,codEvento:String):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function cargarAjusteCReversionCargos_send():AsyncToken;
        
        /**
         * The cargarAjusteCReversionCargos operation lastResult property
         */
        function get cargarAjusteCReversionCargos_lastResult():CargaAjusteCReversionCargosSACDTO;
		/**
		 * @private
		 */
        function set cargarAjusteCReversionCargos_lastResult(lastResult:CargaAjusteCReversionCargosSACDTO):void;
       /**
        * Add a listener for the cargarAjusteCReversionCargos operation successful result event
        * @param The listener function
        */
       function addcargarAjusteCReversionCargosEventListener(listener:Function):void;
       
       
        /**
         * The cargarAjusteCReversionCargos operation request wrapper
         */
        function get cargarAjusteCReversionCargos_request_var():CargarAjusteCReversionCargos_request;
        
        /**
         * @private
         */
        function set cargarAjusteCReversionCargos_request_var(request:CargarAjusteCReversionCargos_request):void;
                   
    	//Stub functions for the oossEjecutadasXNumAbonado operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param numAbonado
    	 * @param nomUsuarioSCL
    	 * @param codEvento
    	 * @return An AsyncToken
    	 */
    	function oossEjecutadasXNumAbonado(numAbonado:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function oossEjecutadasXNumAbonado_send():AsyncToken;
        
        /**
         * The oossEjecutadasXNumAbonado operation lastResult property
         */
        function get oossEjecutadasXNumAbonado_lastResult():ListadoOrdenesServicioDTO;
		/**
		 * @private
		 */
        function set oossEjecutadasXNumAbonado_lastResult(lastResult:ListadoOrdenesServicioDTO):void;
       /**
        * Add a listener for the oossEjecutadasXNumAbonado operation successful result event
        * @param The listener function
        */
       function addoossEjecutadasXNumAbonadoEventListener(listener:Function):void;
       
       
        /**
         * The oossEjecutadasXNumAbonado operation request wrapper
         */
        function get oossEjecutadasXNumAbonado_request_var():OossEjecutadasXNumAbonado_request;
        
        /**
         * @private
         */
        function set oossEjecutadasXNumAbonado_request_var(request:OossEjecutadasXNumAbonado_request):void;
                   
    	//Stub functions for the ssXDefectoXNumAbonado operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param numAbonado
    	 * @return An AsyncToken
    	 */
    	function ssXDefectoXNumAbonado(numAbonado:Number):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function ssXDefectoXNumAbonado_send():AsyncToken;
        
        /**
         * The ssXDefectoXNumAbonado operation lastResult property
         */
        function get ssXDefectoXNumAbonado_lastResult():ListadoServSuplementariosDTO;
		/**
		 * @private
		 */
        function set ssXDefectoXNumAbonado_lastResult(lastResult:ListadoServSuplementariosDTO):void;
       /**
        * Add a listener for the ssXDefectoXNumAbonado operation successful result event
        * @param The listener function
        */
       function addssXDefectoXNumAbonadoEventListener(listener:Function):void;
       
       
        /**
         * The ssXDefectoXNumAbonado operation request wrapper
         */
        function get ssXDefectoXNumAbonado_request_var():SsXDefectoXNumAbonado_request;
        
        /**
         * @private
         */
        function set ssXDefectoXNumAbonado_request_var(request:SsXDefectoXNumAbonado_request):void;
                   
    	//Stub functions for the ejecutarCambioEquipoGSM operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param entrada
    	 * @return An AsyncToken
    	 */
    	function ejecutarCambioEquipoGSM(entrada:EjecucionCambioEquipoGSMDTO):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function ejecutarCambioEquipoGSM_send():AsyncToken;
        
        /**
         * The ejecutarCambioEquipoGSM operation lastResult property
         */
        function get ejecutarCambioEquipoGSM_lastResult():EjecucionCambioEquipoGSMDTO;
		/**
		 * @private
		 */
        function set ejecutarCambioEquipoGSM_lastResult(lastResult:EjecucionCambioEquipoGSMDTO):void;
       /**
        * Add a listener for the ejecutarCambioEquipoGSM operation successful result event
        * @param The listener function
        */
       function addejecutarCambioEquipoGSMEventListener(listener:Function):void;
       
       
        /**
         * The ejecutarCambioEquipoGSM operation request wrapper
         */
        function get ejecutarCambioEquipoGSM_request_var():EjecutarCambioEquipoGSM_request;
        
        /**
         * @private
         */
        function set ejecutarCambioEquipoGSM_request_var(request:EjecutarCambioEquipoGSM_request):void;
                   
    	//Stub functions for the getDocsPagosCliente operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param obj
    	 * @return An AsyncToken
    	 */
    	function getDocsPagosCliente(obj:GetDocsClienteINDTO):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function getDocsPagosCliente_send():AsyncToken;
        
        /**
         * The getDocsPagosCliente operation lastResult property
         */
        function get getDocsPagosCliente_lastResult():ListadoDocCtaCteClienteDTO;
		/**
		 * @private
		 */
        function set getDocsPagosCliente_lastResult(lastResult:ListadoDocCtaCteClienteDTO):void;
       /**
        * Add a listener for the getDocsPagosCliente operation successful result event
        * @param The listener function
        */
       function addgetDocsPagosClienteEventListener(listener:Function):void;
       
       
        /**
         * The getDocsPagosCliente operation request wrapper
         */
        function get getDocsPagosCliente_request_var():GetDocsPagosCliente_request;
        
        /**
         * @private
         */
        function set getDocsPagosCliente_request_var(request:GetDocsPagosCliente_request):void;
                   
    	//Stub functions for the getDocsCtaCteCliente operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param obj
    	 * @param nomUsuarioSCL
    	 * @param codEvento
    	 * @return An AsyncToken
    	 */
    	function getDocsCtaCteCliente(obj:GetDocsClienteINDTO,nomUsuarioSCL:String,codEvento:String):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function getDocsCtaCteCliente_send():AsyncToken;
        
        /**
         * The getDocsCtaCteCliente operation lastResult property
         */
        function get getDocsCtaCteCliente_lastResult():ListadoDocCtaCteClienteDTO;
		/**
		 * @private
		 */
        function set getDocsCtaCteCliente_lastResult(lastResult:ListadoDocCtaCteClienteDTO):void;
       /**
        * Add a listener for the getDocsCtaCteCliente operation successful result event
        * @param The listener function
        */
       function addgetDocsCtaCteClienteEventListener(listener:Function):void;
       
       
        /**
         * The getDocsCtaCteCliente operation request wrapper
         */
        function get getDocsCtaCteCliente_request_var():GetDocsCtaCteCliente_request;
        
        /**
         * @private
         */
        function set getDocsCtaCteCliente_request_var(request:GetDocsCtaCteCliente_request):void;
                   
    	//Stub functions for the cambiarDireccionCliente operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param dto
    	 * @return An AsyncToken
    	 */
    	function cambiarDireccionCliente(dto:DireccionSACDTO):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function cambiarDireccionCliente_send():AsyncToken;
        
        /**
         * The cambiarDireccionCliente operation lastResult property
         */
        function get cambiarDireccionCliente_lastResult():ConsultarOrdenServicioSACDTO;
		/**
		 * @private
		 */
        function set cambiarDireccionCliente_lastResult(lastResult:ConsultarOrdenServicioSACDTO):void;
       /**
        * Add a listener for the cambiarDireccionCliente operation successful result event
        * @param The listener function
        */
       function addcambiarDireccionClienteEventListener(listener:Function):void;
       
       
        /**
         * The cambiarDireccionCliente operation request wrapper
         */
        function get cambiarDireccionCliente_request_var():CambiarDireccionCliente_request;
        
        /**
         * @private
         */
        function set cambiarDireccionCliente_request_var(request:CambiarDireccionCliente_request):void;
                   
    	//Stub functions for the ssXDefectoXCodCliente operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param codCliente
    	 * @return An AsyncToken
    	 */
    	function ssXDefectoXCodCliente(codCliente:Number):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function ssXDefectoXCodCliente_send():AsyncToken;
        
        /**
         * The ssXDefectoXCodCliente operation lastResult property
         */
        function get ssXDefectoXCodCliente_lastResult():ListadoServSuplementariosDTO;
		/**
		 * @private
		 */
        function set ssXDefectoXCodCliente_lastResult(lastResult:ListadoServSuplementariosDTO):void;
       /**
        * Add a listener for the ssXDefectoXCodCliente operation successful result event
        * @param The listener function
        */
       function addssXDefectoXCodClienteEventListener(listener:Function):void;
       
       
        /**
         * The ssXDefectoXCodCliente operation request wrapper
         */
        function get ssXDefectoXCodCliente_request_var():SsXDefectoXCodCliente_request;
        
        /**
         * @private
         */
        function set ssXDefectoXCodCliente_request_var(request:SsXDefectoXCodCliente_request):void;
                   
    	//Stub functions for the servSuplXOOSS operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param numOOSS
    	 * @return An AsyncToken
    	 */
    	function servSuplXOOSS(numOOSS:Number):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function servSuplXOOSS_send():AsyncToken;
        
        /**
         * The servSuplXOOSS operation lastResult property
         */
        function get servSuplXOOSS_lastResult():ListadoServSuplxOOSSDTO;
		/**
		 * @private
		 */
        function set servSuplXOOSS_lastResult(lastResult:ListadoServSuplxOOSSDTO):void;
       /**
        * Add a listener for the servSuplXOOSS operation successful result event
        * @param The listener function
        */
       function addservSuplXOOSSEventListener(listener:Function):void;
       
       
        /**
         * The servSuplXOOSS operation request wrapper
         */
        function get servSuplXOOSS_request_var():ServSuplXOOSS_request;
        
        /**
         * @private
         */
        function set servSuplXOOSS_request_var(request:ServSuplXOOSS_request):void;
                   
    	//Stub functions for the limiteConsumoXClienteAbonado operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param codCliente
    	 * @param numAbonado
    	 * @param nomUsuarioSCL
    	 * @param codEvento
    	 * @return An AsyncToken
    	 */
    	function limiteConsumoXClienteAbonado(codCliente:Number,numAbonado:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function limiteConsumoXClienteAbonado_send():AsyncToken;
        
        /**
         * The limiteConsumoXClienteAbonado operation lastResult property
         */
        function get limiteConsumoXClienteAbonado_lastResult():ListadoLimiteConsumoDTO;
		/**
		 * @private
		 */
        function set limiteConsumoXClienteAbonado_lastResult(lastResult:ListadoLimiteConsumoDTO):void;
       /**
        * Add a listener for the limiteConsumoXClienteAbonado operation successful result event
        * @param The listener function
        */
       function addlimiteConsumoXClienteAbonadoEventListener(listener:Function):void;
       
       
        /**
         * The limiteConsumoXClienteAbonado operation request wrapper
         */
        function get limiteConsumoXClienteAbonado_request_var():LimiteConsumoXClienteAbonado_request;
        
        /**
         * @private
         */
        function set limiteConsumoXClienteAbonado_request_var(request:LimiteConsumoXClienteAbonado_request):void;
                   
    	//Stub functions for the cargaOSGenericaAbonado operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param numAbonado
    	 * @param nomUsuarioSCL
    	 * @param codEvento
    	 * @return An AsyncToken
    	 */
    	function cargaOSGenericaAbonado(numAbonado:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function cargaOSGenericaAbonado_send():AsyncToken;
        
        /**
         * The cargaOSGenericaAbonado operation lastResult property
         */
        function get cargaOSGenericaAbonado_lastResult():CargaOSGenericaDTO;
		/**
		 * @private
		 */
        function set cargaOSGenericaAbonado_lastResult(lastResult:CargaOSGenericaDTO):void;
       /**
        * Add a listener for the cargaOSGenericaAbonado operation successful result event
        * @param The listener function
        */
       function addcargaOSGenericaAbonadoEventListener(listener:Function):void;
       
       
        /**
         * The cargaOSGenericaAbonado operation request wrapper
         */
        function get cargaOSGenericaAbonado_request_var():CargaOSGenericaAbonado_request;
        
        /**
         * @private
         */
        function set cargaOSGenericaAbonado_request_var(request:CargaOSGenericaAbonado_request):void;
                   
    	//Stub functions for the obtenerParametroKiosco operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @return An AsyncToken
    	 */
    	function obtenerParametroKiosco():AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function obtenerParametroKiosco_send():AsyncToken;
        
        /**
         * The obtenerParametroKiosco operation lastResult property
         */
        function get obtenerParametroKiosco_lastResult():ParametrosKioscoDTO;
		/**
		 * @private
		 */
        function set obtenerParametroKiosco_lastResult(lastResult:ParametrosKioscoDTO):void;
       /**
        * Add a listener for the obtenerParametroKiosco operation successful result event
        * @param The listener function
        */
       function addobtenerParametroKioscoEventListener(listener:Function):void;
       
       
    	//Stub functions for the cuentasXCodigo operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param codCuenta
    	 * @return An AsyncToken
    	 */
    	function cuentasXCodigo(codCuenta:Number):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function cuentasXCodigo_send():AsyncToken;
        
        /**
         * The cuentasXCodigo operation lastResult property
         */
        function get cuentasXCodigo_lastResult():ListadoCuentasDTO;
		/**
		 * @private
		 */
        function set cuentasXCodigo_lastResult(lastResult:ListadoCuentasDTO):void;
       /**
        * Add a listener for the cuentasXCodigo operation successful result event
        * @param The listener function
        */
       function addcuentasXCodigoEventListener(listener:Function):void;
       
       
        /**
         * The cuentasXCodigo operation request wrapper
         */
        function get cuentasXCodigo_request_var():CuentasXCodigo_request;
        
        /**
         * @private
         */
        function set cuentasXCodigo_request_var(request:CuentasXCodigo_request):void;
                   
    	//Stub functions for the clientesXNombre operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param nombre
    	 * @return An AsyncToken
    	 */
    	function clientesXNombre(nombre:String):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function clientesXNombre_send():AsyncToken;
        
        /**
         * The clientesXNombre operation lastResult property
         */
        function get clientesXNombre_lastResult():ListadoClientesDTO;
		/**
		 * @private
		 */
        function set clientesXNombre_lastResult(lastResult:ListadoClientesDTO):void;
       /**
        * Add a listener for the clientesXNombre operation successful result event
        * @param The listener function
        */
       function addclientesXNombreEventListener(listener:Function):void;
       
       
        /**
         * The clientesXNombre operation request wrapper
         */
        function get clientesXNombre_request_var():ClientesXNombre_request;
        
        /**
         * @private
         */
        function set clientesXNombre_request_var(request:ClientesXNombre_request):void;
                   
    	//Stub functions for the cambiosPlanAbonadoPrepago operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param numOS
    	 * @return An AsyncToken
    	 */
    	function cambiosPlanAbonadoPrepago(numOS:Number):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function cambiosPlanAbonadoPrepago_send():AsyncToken;
        
        /**
         * The cambiosPlanAbonadoPrepago operation lastResult property
         */
        function get cambiosPlanAbonadoPrepago_lastResult():ListadoCambiosPlanTarifDTO;
		/**
		 * @private
		 */
        function set cambiosPlanAbonadoPrepago_lastResult(lastResult:ListadoCambiosPlanTarifDTO):void;
       /**
        * Add a listener for the cambiosPlanAbonadoPrepago operation successful result event
        * @param The listener function
        */
       function addcambiosPlanAbonadoPrepagoEventListener(listener:Function):void;
       
       
        /**
         * The cambiosPlanAbonadoPrepago operation request wrapper
         */
        function get cambiosPlanAbonadoPrepago_request_var():CambiosPlanAbonadoPrepago_request;
        
        /**
         * @private
         */
        function set cambiosPlanAbonadoPrepago_request_var(request:CambiosPlanAbonadoPrepago_request):void;
                   
    	//Stub functions for the getDetalleDireccion operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param codDireccion
    	 * @param codTipDireccion
    	 * @return An AsyncToken
    	 */
    	function getDetalleDireccion(codDireccion:Number,codTipDireccion:String):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function getDetalleDireccion_send():AsyncToken;
        
        /**
         * The getDetalleDireccion operation lastResult property
         */
        function get getDetalleDireccion_lastResult():DetalleDireccionDTO;
		/**
		 * @private
		 */
        function set getDetalleDireccion_lastResult(lastResult:DetalleDireccionDTO):void;
       /**
        * Add a listener for the getDetalleDireccion operation successful result event
        * @param The listener function
        */
       function addgetDetalleDireccionEventListener(listener:Function):void;
       
       
        /**
         * The getDetalleDireccion operation request wrapper
         */
        function get getDetalleDireccion_request_var():GetDetalleDireccion_request;
        
        /**
         * @private
         */
        function set getDetalleDireccion_request_var(request:GetDetalleDireccion_request):void;
                   
    	//Stub functions for the ejecutarAbonoLimiteConsumo operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param entrada
    	 * @return An AsyncToken
    	 */
    	function ejecutarAbonoLimiteConsumo(entrada:EjecucionAbonoLimConDTO):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function ejecutarAbonoLimiteConsumo_send():AsyncToken;
        
        /**
         * The ejecutarAbonoLimiteConsumo operation lastResult property
         */
        function get ejecutarAbonoLimiteConsumo_lastResult():EjecucionAbonoLimConDTO;
		/**
		 * @private
		 */
        function set ejecutarAbonoLimiteConsumo_lastResult(lastResult:EjecucionAbonoLimConDTO):void;
       /**
        * Add a listener for the ejecutarAbonoLimiteConsumo operation successful result event
        * @param The listener function
        */
       function addejecutarAbonoLimiteConsumoEventListener(listener:Function):void;
       
       
        /**
         * The ejecutarAbonoLimiteConsumo operation request wrapper
         */
        function get ejecutarAbonoLimiteConsumo_request_var():EjecutarAbonoLimiteConsumo_request;
        
        /**
         * @private
         */
        function set ejecutarAbonoLimiteConsumo_request_var(request:EjecutarAbonoLimiteConsumo_request):void;
                   
    	//Stub functions for the clientesXCuenta operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param codCuenta
    	 * @return An AsyncToken
    	 */
    	function clientesXCuenta(codCuenta:Number):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function clientesXCuenta_send():AsyncToken;
        
        /**
         * The clientesXCuenta operation lastResult property
         */
        function get clientesXCuenta_lastResult():ListadoClientesDTO;
		/**
		 * @private
		 */
        function set clientesXCuenta_lastResult(lastResult:ListadoClientesDTO):void;
       /**
        * Add a listener for the clientesXCuenta operation successful result event
        * @param The listener function
        */
       function addclientesXCuentaEventListener(listener:Function):void;
       
       
        /**
         * The clientesXCuenta operation request wrapper
         */
        function get clientesXCuenta_request_var():ClientesXCuenta_request;
        
        /**
         * @private
         */
        function set clientesXCuenta_request_var(request:ClientesXCuenta_request):void;
                   
    	//Stub functions for the ejecutarAnulacionSiniestro operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param entrada
    	 * @return An AsyncToken
    	 */
    	function ejecutarAnulacionSiniestro(entrada:EjecucionAnulacionSiniestroDTO):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function ejecutarAnulacionSiniestro_send():AsyncToken;
        
        /**
         * The ejecutarAnulacionSiniestro operation lastResult property
         */
        function get ejecutarAnulacionSiniestro_lastResult():EjecucionAnulacionSiniestroDTO;
		/**
		 * @private
		 */
        function set ejecutarAnulacionSiniestro_lastResult(lastResult:EjecucionAnulacionSiniestroDTO):void;
       /**
        * Add a listener for the ejecutarAnulacionSiniestro operation successful result event
        * @param The listener function
        */
       function addejecutarAnulacionSiniestroEventListener(listener:Function):void;
       
       
        /**
         * The ejecutarAnulacionSiniestro operation request wrapper
         */
        function get ejecutarAnulacionSiniestro_request_var():EjecutarAnulacionSiniestro_request;
        
        /**
         * @private
         */
        function set ejecutarAnulacionSiniestro_request_var(request:EjecutarAnulacionSiniestro_request):void;
                   
    	//Stub functions for the ejecutarAjusteCReversionCargos operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param entrada
    	 * @return An AsyncToken
    	 */
    	function ejecutarAjusteCReversionCargos(entrada:EjecucionAjusteCReversionCargosSACDTO):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function ejecutarAjusteCReversionCargos_send():AsyncToken;
        
        /**
         * The ejecutarAjusteCReversionCargos operation lastResult property
         */
        function get ejecutarAjusteCReversionCargos_lastResult():EjecucionAjusteCReversionCargosDTO;
		/**
		 * @private
		 */
        function set ejecutarAjusteCReversionCargos_lastResult(lastResult:EjecucionAjusteCReversionCargosDTO):void;
       /**
        * Add a listener for the ejecutarAjusteCReversionCargos operation successful result event
        * @param The listener function
        */
       function addejecutarAjusteCReversionCargosEventListener(listener:Function):void;
       
       
        /**
         * The ejecutarAjusteCReversionCargos operation request wrapper
         */
        function get ejecutarAjusteCReversionCargos_request_var():EjecutarAjusteCReversionCargos_request;
        
        /**
         * @private
         */
        function set ejecutarAjusteCReversionCargos_request_var(request:EjecutarAjusteCReversionCargos_request):void;
                   
    	//Stub functions for the numerosFrecuentesXPlan operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param numAbonado
    	 * @return An AsyncToken
    	 */
    	function numerosFrecuentesXPlan(numAbonado:Number):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function numerosFrecuentesXPlan_send():AsyncToken;
        
        /**
         * The numerosFrecuentesXPlan operation lastResult property
         */
        function get numerosFrecuentesXPlan_lastResult():ListadoNumerosFrecuentesDTO;
		/**
		 * @private
		 */
        function set numerosFrecuentesXPlan_lastResult(lastResult:ListadoNumerosFrecuentesDTO):void;
       /**
        * Add a listener for the numerosFrecuentesXPlan operation successful result event
        * @param The listener function
        */
       function addnumerosFrecuentesXPlanEventListener(listener:Function):void;
       
       
        /**
         * The numerosFrecuentesXPlan operation request wrapper
         */
        function get numerosFrecuentesXPlan_request_var():NumerosFrecuentesXPlan_request;
        
        /**
         * @private
         */
        function set numerosFrecuentesXPlan_request_var(request:NumerosFrecuentesXPlan_request):void;
                   
    	//Stub functions for the obtenerOoSsAgendadas operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param numDato
    	 * @param tipoDato
    	 * @return An AsyncToken
    	 */
    	function obtenerOoSsAgendadas(numDato:Number,tipoDato:Number):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function obtenerOoSsAgendadas_send():AsyncToken;
        
        /**
         * The obtenerOoSsAgendadas operation lastResult property
         */
        function get obtenerOoSsAgendadas_lastResult():ListadoOrdenesAgendadasDTO;
		/**
		 * @private
		 */
        function set obtenerOoSsAgendadas_lastResult(lastResult:ListadoOrdenesAgendadasDTO):void;
       /**
        * Add a listener for the obtenerOoSsAgendadas operation successful result event
        * @param The listener function
        */
       function addobtenerOoSsAgendadasEventListener(listener:Function):void;
       
       
        /**
         * The obtenerOoSsAgendadas operation request wrapper
         */
        function get obtenerOoSsAgendadas_request_var():ObtenerOoSsAgendadas_request;
        
        /**
         * @private
         */
        function set obtenerOoSsAgendadas_request_var(request:ObtenerOoSsAgendadas_request):void;
                   
    	//Stub functions for the ccXCodCliente operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param codCliente
    	 * @param nomUsuarioSCL
    	 * @param codEvento
    	 * @return An AsyncToken
    	 */
    	function ccXCodCliente(codCliente:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function ccXCodCliente_send():AsyncToken;
        
        /**
         * The ccXCodCliente operation lastResult property
         */
        function get ccXCodCliente_lastResult():ListadoCuentasCorrientesDTO;
		/**
		 * @private
		 */
        function set ccXCodCliente_lastResult(lastResult:ListadoCuentasCorrientesDTO):void;
       /**
        * Add a listener for the ccXCodCliente operation successful result event
        * @param The listener function
        */
       function addccXCodClienteEventListener(listener:Function):void;
       
       
        /**
         * The ccXCodCliente operation request wrapper
         */
        function get ccXCodCliente_request_var():CcXCodCliente_request;
        
        /**
         * @private
         */
        function set ccXCodCliente_request_var(request:CcXCodCliente_request):void;
                   
    	//Stub functions for the abonadosXCliente operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param codCliente
    	 * @return An AsyncToken
    	 */
    	function abonadosXCliente(codCliente:Number):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function abonadosXCliente_send():AsyncToken;
        
        /**
         * The abonadosXCliente operation lastResult property
         */
        function get abonadosXCliente_lastResult():ListadoAbonadosDTO;
		/**
		 * @private
		 */
        function set abonadosXCliente_lastResult(lastResult:ListadoAbonadosDTO):void;
       /**
        * Add a listener for the abonadosXCliente operation successful result event
        * @param The listener function
        */
       function addabonadosXClienteEventListener(listener:Function):void;
       
       
        /**
         * The abonadosXCliente operation request wrapper
         */
        function get abonadosXCliente_request_var():AbonadosXCliente_request;
        
        /**
         * @private
         */
        function set abonadosXCliente_request_var(request:AbonadosXCliente_request):void;
                   
    	//Stub functions for the insertComentario operation
    	/**
    	 * Call the operation on the server passing in the arguments defined in the WSDL file
    	 * @param comentario
    	 * @param numOoss
    	 * @return An AsyncToken
    	 */
    	function insertComentario(comentario:String,numOoss:Number):AsyncToken;
        /**
         * Method to call the operation on the server without passing the arguments inline.
         * You must however set the _request property for the operation before calling this method
         * Should use it in MXML context mostly
         * @return An AsyncToken
         */
        function insertComentario_send():AsyncToken;
        
        /**
         * The insertComentario operation lastResult property
         */
        function get insertComentario_lastResult():ResulTransaccionDTO;
		/**
		 * @private
		 */
        function set insertComentario_lastResult(lastResult:ResulTransaccionDTO):void;
       /**
        * Add a listener for the insertComentario operation successful result event
        * @param The listener function
        */
       function addinsertComentarioEventListener(listener:Function):void;
       
       
        /**
         * The insertComentario operation request wrapper
         */
        function get insertComentario_request_var():InsertComentario_request;
        
        /**
         * @private
         */
        function set insertComentario_request_var(request:InsertComentario_request):void;
                   
        /**
         * Get access to the underlying web service that the stub uses to communicate with the server
         * @return The base service that the facade implements
         */
        function getWebService():BaseWSSEGPortal;
	}
}