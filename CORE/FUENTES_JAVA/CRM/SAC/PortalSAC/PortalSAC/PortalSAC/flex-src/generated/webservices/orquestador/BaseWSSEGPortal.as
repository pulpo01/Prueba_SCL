/**
 * BaseWSSEGPortalService.as
 * This file was auto-generated from WSDL by the Apache Axis2 generator modified by Adobe
 * Any change made to this file will be overwritten when the code is re-generated.
 */
package generated.webservices.orquestador
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import mx.controls.treeClasses.DefaultDataDescriptor;
	import mx.utils.ObjectUtil;
	import mx.utils.ObjectProxy;
	import mx.messaging.events.MessageFaultEvent;
	import mx.messaging.MessageResponder;
	import mx.messaging.messages.SOAPMessage;
	import mx.messaging.messages.ErrorMessage;
   	import mx.messaging.ChannelSet;
	import mx.messaging.channels.DirectHTTPChannel;
	import mx.rpc.*;
	import mx.rpc.events.*;
	import mx.rpc.soap.*;
	import mx.rpc.wsdl.*;
	import mx.rpc.xml.*;
	import mx.rpc.soap.types.*;
	import mx.collections.ArrayCollection;
	import mx.utils.Base64Encoder;
	import user.libreria.clases.Utilidades;
	
	import flash.external.ExternalInterface;
	import user.libreria.clases.StringUtil;
	import flash.net.navigateToURL;
	
	/**
	 * Base service implementation, extends the AbstractWebService and adds specific functionality for the selected WSDL
	 * It defines the options and properties for each of the WSDL's operations
	 */ 
	public class BaseWSSEGPortal extends AbstractWebService
    {
		private var results:Object;
		private var schemaMgr:SchemaManager;
		private var BaseWSSEGPortalService:WSDLService;
		private var BaseWSSEGPortalPortType:WSDLPortType;
		private var BaseWSSEGPortalBinding:WSDLBinding;
		private var BaseWSSEGPortalPort:WSDLPort;
		private var currentOperation:WSDLOperation;
		private var internal_schema:BaseWSSEGPortalSchema;

		

		// ------ AUTENTICACION ----
		// HGG 09/12/08
		private var usuario:String;
		private var password:String;
	
		public function setUsuario(user:String):void	{
			this.usuario = user;
		}
		
		public function getUsaurio():String	{
			return this.usuario;
		}
		
		public function setPassword(pass:String):void	{
			this.password = pass;
		}
		
		public function getPassword():String	{
			return this.password;
		}
		// -----------------------
	
	
		
	
		/**
		 * Constructor for the base service, initializes all of the WSDL's properties
		 * @param [Optional] The LCDS destination (if available) to use to contact the server
		 * @param [Optional] The URL to the WSDL end-point
		 */
		public function BaseWSSEGPortal(destination:String=null, rootURL:String=null)
		{
			super(destination, rootURL);
			if(destination == null)
			{
				//no destination available; must set it to go directly to the target
				this.useProxy = false;
			}
			else
			{
				//specific destination requested; must set proxying to true
				this.useProxy = true;
			}
			
			if(rootURL != null)
			{
				this.endpointURI = rootURL;
			} 
			else 
			{
				this.endpointURI = null;
			}
			internal_schema = new BaseWSSEGPortalSchema();
			schemaMgr = new SchemaManager();
			for(var i:int;i<internal_schema.schemas.length;i++)
			{
				internal_schema.schemas[i].targetNamespace=internal_schema.targetNamespaces[i];
				schemaMgr.addSchema(internal_schema.schemas[i]);
			}
BaseWSSEGPortalService = new WSDLService("BaseWSSEGPortalService");
			BaseWSSEGPortalPort = new WSDLPort("BaseWSSEGPortalPort",BaseWSSEGPortalService);
        	BaseWSSEGPortalBinding = new WSDLBinding("BaseWSSEGPortalBinding");
	        BaseWSSEGPortalPortType = new WSDLPortType("BaseWSSEGPortalPortType");
       		BaseWSSEGPortalBinding.portType = BaseWSSEGPortalPortType;
       		BaseWSSEGPortalPort.binding = BaseWSSEGPortalBinding;
       		BaseWSSEGPortalService.addPort(BaseWSSEGPortalPort);
       		BaseWSSEGPortalPort.endpointURI = "http://localhost:7002/WSPortalSeguridad/services/WSSEGPortal";
       		if(this.endpointURI == null)
       		{
       			this.endpointURI = BaseWSSEGPortalPort.endpointURI; 
       		} 
       		
			var requestMessage:WSDLMessage;
			var responseMessage:WSDLMessage;
			//define the WSDLOperation: new WSDLOperation(methodName)
            var cargarReposicionSrvCelular:WSDLOperation = new WSDLOperation("cargarReposicionSrvCelular");
				//input message for the operation
    	        requestMessage = new WSDLMessage("cargarReposicionSrvCelular");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","numAbonado"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","nomUsuarioSCL"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codEvento"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","cargarReposicionSrvCelular");
                
                responseMessage = new WSDLMessage("cargarReposicionSrvCelularResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsfranquicias.scl.tmmas.com/xsd","CargaReposicionSrvCelDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","cargarReposicionSrvCelularResponse");
			cargarReposicionSrvCelular.inputMessage = requestMessage;
	        cargarReposicionSrvCelular.outputMessage = responseMessage;
            cargarReposicionSrvCelular.schemaManager = this.schemaMgr;
            cargarReposicionSrvCelular.soapAction = "urn:cargarReposicionSrvCelular";
            cargarReposicionSrvCelular.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(cargarReposicionSrvCelular);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var cuentasXNombre:WSDLOperation = new WSDLOperation("cuentasXNombre");
				//input message for the operation
    	        requestMessage = new WSDLMessage("cuentasXNombre");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","descCuenta"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","cuentasXNombre");
                
                responseMessage = new WSDLMessage("cuentasXNombreResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoCuentasDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","cuentasXNombreResponse");
			cuentasXNombre.inputMessage = requestMessage;
	        cuentasXNombre.outputMessage = responseMessage;
            cuentasXNombre.schemaManager = this.schemaMgr;
            cuentasXNombre.soapAction = "urn:cuentasXNombre";
            cuentasXNombre.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(cuentasXNombre);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var getDocsFactCliente:WSDLOperation = new WSDLOperation("getDocsFactCliente");
				//input message for the operation
    	        requestMessage = new WSDLMessage("getDocsFactCliente");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","obj"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","GetDocsClienteINDTO")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","getDocsFactCliente");
                
                responseMessage = new WSDLMessage("getDocsFactClienteResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoDocCtaCteClienteDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","getDocsFactClienteResponse");
			getDocsFactCliente.inputMessage = requestMessage;
	        getDocsFactCliente.outputMessage = responseMessage;
            getDocsFactCliente.schemaManager = this.schemaMgr;
            getDocsFactCliente.soapAction = "urn:getDocsFactCliente";
            getDocsFactCliente.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(getDocsFactCliente);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var abonadosXCelular:WSDLOperation = new WSDLOperation("abonadosXCelular");
				//input message for the operation
    	        requestMessage = new WSDLMessage("abonadosXCelular");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","numCelular"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","abonadosXCelular");
                
                responseMessage = new WSDLMessage("abonadosXCelularResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoAbonadosDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","abonadosXCelularResponse");
			abonadosXCelular.inputMessage = requestMessage;
	        abonadosXCelular.outputMessage = responseMessage;
            abonadosXCelular.schemaManager = this.schemaMgr;
            abonadosXCelular.soapAction = "urn:abonadosXCelular";
            abonadosXCelular.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(abonadosXCelular);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var ejecutarCambioPlanPostPagoIndividual:WSDLOperation = new WSDLOperation("ejecutarCambioPlanPostPagoIndividual");
				//input message for the operation
    	        requestMessage = new WSDLMessage("ejecutarCambioPlanPostPagoIndividual");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","entrada"),null,new QName("http://dto.common.wsfranquicias.scl.tmmas.com/xsd","EjecucionCambioPlanPostPagoIndividualDTO")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","ejecutarCambioPlanPostPagoIndividual");
                
                responseMessage = new WSDLMessage("ejecutarCambioPlanPostPagoIndividualResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsfranquicias.scl.tmmas.com/xsd","EjecucionCambioPlanPostPagoIndividualDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","ejecutarCambioPlanPostPagoIndividualResponse");
			ejecutarCambioPlanPostPagoIndividual.inputMessage = requestMessage;
	        ejecutarCambioPlanPostPagoIndividual.outputMessage = responseMessage;
            ejecutarCambioPlanPostPagoIndividual.schemaManager = this.schemaMgr;
            ejecutarCambioPlanPostPagoIndividual.soapAction = "urn:ejecutarCambioPlanPostPagoIndividual";
            ejecutarCambioPlanPostPagoIndividual.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(ejecutarCambioPlanPostPagoIndividual);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var obtenerCamposDireccion:WSDLOperation = new WSDLOperation("obtenerCamposDireccion");
				//input message for the operation
    	        requestMessage = new WSDLMessage("");
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="";
			requestMessage.encoding.useStyle="literal";
                
                responseMessage = new WSDLMessage("obtenerCamposDireccionResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoCamposDireccionDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","obtenerCamposDireccionResponse");
			obtenerCamposDireccion.inputMessage = requestMessage;
	        obtenerCamposDireccion.outputMessage = responseMessage;
            obtenerCamposDireccion.schemaManager = this.schemaMgr;
            obtenerCamposDireccion.soapAction = "urn:obtenerCamposDireccion";
            obtenerCamposDireccion.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(obtenerCamposDireccion);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var cargaCambioDatosCliente:WSDLOperation = new WSDLOperation("cargaCambioDatosCliente");
				//input message for the operation
    	        requestMessage = new WSDLMessage("cargaCambioDatosCliente");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codCliente"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","nomUsuarioSCL"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codEvento"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","cargaCambioDatosCliente");
                
                responseMessage = new WSDLMessage("cargaCambioDatosClienteResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.wsseguridad.scl.tmmas.com/xsd","CargaCambioDatosClienteSACDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","cargaCambioDatosClienteResponse");
			cargaCambioDatosCliente.inputMessage = requestMessage;
	        cargaCambioDatosCliente.outputMessage = responseMessage;
            cargaCambioDatosCliente.schemaManager = this.schemaMgr;
            cargaCambioDatosCliente.soapAction = "urn:cargaCambioDatosCliente";
            cargaCambioDatosCliente.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(cargaCambioDatosCliente);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var cargarAbonoLimiteConsumo:WSDLOperation = new WSDLOperation("cargarAbonoLimiteConsumo");
				//input message for the operation
    	        requestMessage = new WSDLMessage("cargarAbonoLimiteConsumo");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codSujeto"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","tipoAbono"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","nomUsuarioSCL"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codEvento"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","cargarAbonoLimiteConsumo");
                
                responseMessage = new WSDLMessage("cargarAbonoLimiteConsumoResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsfranquicias.scl.tmmas.com/xsd","CargaAbonoLimConDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","cargarAbonoLimiteConsumoResponse");
			cargarAbonoLimiteConsumo.inputMessage = requestMessage;
	        cargarAbonoLimiteConsumo.outputMessage = responseMessage;
            cargarAbonoLimiteConsumo.schemaManager = this.schemaMgr;
            cargarAbonoLimiteConsumo.soapAction = "urn:cargarAbonoLimiteConsumo";
            cargarAbonoLimiteConsumo.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(cargarAbonoLimiteConsumo);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var ejecutarReposicionSrvCelular:WSDLOperation = new WSDLOperation("ejecutarReposicionSrvCelular");
				//input message for the operation
    	        requestMessage = new WSDLMessage("ejecutarReposicionSrvCelular");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","entrada"),null,new QName("http://dto.common.wsfranquicias.scl.tmmas.com/xsd","EjecucionReposicionSrvCelDTO")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","ejecutarReposicionSrvCelular");
                
                responseMessage = new WSDLMessage("ejecutarReposicionSrvCelularResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsfranquicias.scl.tmmas.com/xsd","EjecucionReposicionSrvCelDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","ejecutarReposicionSrvCelularResponse");
			ejecutarReposicionSrvCelular.inputMessage = requestMessage;
	        ejecutarReposicionSrvCelular.outputMessage = responseMessage;
            ejecutarReposicionSrvCelular.schemaManager = this.schemaMgr;
            ejecutarReposicionSrvCelular.soapAction = "urn:ejecutarReposicionSrvCelular";
            ejecutarReposicionSrvCelular.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(ejecutarReposicionSrvCelular);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var getDocsAjustesCliente:WSDLOperation = new WSDLOperation("getDocsAjustesCliente");
				//input message for the operation
    	        requestMessage = new WSDLMessage("getDocsAjustesCliente");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","obj"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","GetDocsClienteINDTO")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","getDocsAjustesCliente");
                
                responseMessage = new WSDLMessage("getDocsAjustesClienteResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoDocCtaCteClienteDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","getDocsAjustesClienteResponse");
			getDocsAjustesCliente.inputMessage = requestMessage;
	        getDocsAjustesCliente.outputMessage = responseMessage;
            getDocsAjustesCliente.schemaManager = this.schemaMgr;
            getDocsAjustesCliente.soapAction = "urn:getDocsAjustesCliente";
            getDocsAjustesCliente.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(getDocsAjustesCliente);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var cargarCambioPlanPostPagoIndividual:WSDLOperation = new WSDLOperation("cargarCambioPlanPostPagoIndividual");
				//input message for the operation
    	        requestMessage = new WSDLMessage("cargarCambioPlanPostPagoIndividual");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","numAbonado"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","nomUsuarioSCL"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codEvento"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","cargarCambioPlanPostPagoIndividual");
                
                responseMessage = new WSDLMessage("cargarCambioPlanPostPagoIndividualResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsfranquicias.scl.tmmas.com/xsd","CargaCambioPlanPostPagoIndividualDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","cargarCambioPlanPostPagoIndividualResponse");
			cargarCambioPlanPostPagoIndividual.inputMessage = requestMessage;
	        cargarCambioPlanPostPagoIndividual.outputMessage = responseMessage;
            cargarCambioPlanPostPagoIndividual.schemaManager = this.schemaMgr;
            cargarCambioPlanPostPagoIndividual.soapAction = "urn:cargarCambioPlanPostPagoIndividual";
            cargarCambioPlanPostPagoIndividual.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(cargarCambioPlanPostPagoIndividual);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var obtenerReporteIngrStatusEqui:WSDLOperation = new WSDLOperation("obtenerReporteIngrStatusEqui");
				//input message for the operation
    	        requestMessage = new WSDLMessage("obtenerReporteIngrStatusEqui");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","fechaDesde"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","fechaHasta"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","obtenerReporteIngrStatusEqui");
                
                responseMessage = new WSDLMessage("obtenerReporteIngrStatusEquiResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoReporteIngrStatusEquiDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","obtenerReporteIngrStatusEquiResponse");
			obtenerReporteIngrStatusEqui.inputMessage = requestMessage;
	        obtenerReporteIngrStatusEqui.outputMessage = responseMessage;
            obtenerReporteIngrStatusEqui.schemaManager = this.schemaMgr;
            obtenerReporteIngrStatusEqui.soapAction = "urn:obtenerReporteIngrStatusEqui";
            obtenerReporteIngrStatusEqui.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(obtenerReporteIngrStatusEqui);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var servSumplemetariosXAbonado:WSDLOperation = new WSDLOperation("servSumplemetariosXAbonado");
				//input message for the operation
    	        requestMessage = new WSDLMessage("servSumplemetariosXAbonado");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","numAbonado"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","nomUsuarioSCL"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codEvento"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","servSumplemetariosXAbonado");
                
                responseMessage = new WSDLMessage("servSumplemetariosXAbonadoResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoServSuplementariosDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","servSumplemetariosXAbonadoResponse");
			servSumplemetariosXAbonado.inputMessage = requestMessage;
	        servSumplemetariosXAbonado.outputMessage = responseMessage;
            servSumplemetariosXAbonado.schemaManager = this.schemaMgr;
            servSumplemetariosXAbonado.soapAction = "urn:servSumplemetariosXAbonado";
            servSumplemetariosXAbonado.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(servSumplemetariosXAbonado);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var filtrarDetDocAjusteCReversionCargos:WSDLOperation = new WSDLOperation("filtrarDetDocAjusteCReversionCargos");
				//input message for the operation
    	        requestMessage = new WSDLMessage("filtrarDetDocAjusteCReversionCargos");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","entrada"),null,new QName("http://dto.wsseguridad.scl.tmmas.com/xsd","FiltroDetDocAjusteCCargosSACDTO")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","filtrarDetDocAjusteCReversionCargos");
                
                responseMessage = new WSDLMessage("filtrarDetDocAjusteCReversionCargosResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.wsseguridad.scl.tmmas.com/xsd","FiltroDetDocAjusteCCargosSACDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","filtrarDetDocAjusteCReversionCargosResponse");
			filtrarDetDocAjusteCReversionCargos.inputMessage = requestMessage;
	        filtrarDetDocAjusteCReversionCargos.outputMessage = responseMessage;
            filtrarDetDocAjusteCReversionCargos.schemaManager = this.schemaMgr;
            filtrarDetDocAjusteCReversionCargos.soapAction = "urn:filtrarDetDocAjusteCReversionCargos";
            filtrarDetDocAjusteCReversionCargos.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(filtrarDetDocAjusteCReversionCargos);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var getDetalleCuenta:WSDLOperation = new WSDLOperation("getDetalleCuenta");
				//input message for the operation
    	        requestMessage = new WSDLMessage("getDetalleCuenta");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codCuenta"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","nomUsuarioSCL"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codEvento"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","getDetalleCuenta");
                
                responseMessage = new WSDLMessage("getDetalleCuentaResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","DetalleCuentaDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","getDetalleCuentaResponse");
			getDetalleCuenta.inputMessage = requestMessage;
	        getDetalleCuenta.outputMessage = responseMessage;
            getDetalleCuenta.schemaManager = this.schemaMgr;
            getDetalleCuenta.soapAction = "urn:getDetalleCuenta";
            getDetalleCuenta.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(getDetalleCuenta);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var filtrarDetDocAjusteCExcepcionCargos:WSDLOperation = new WSDLOperation("filtrarDetDocAjusteCExcepcionCargos");
				//input message for the operation
    	        requestMessage = new WSDLMessage("filtrarDetDocAjusteCExcepcionCargos");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","entrada"),null,new QName("http://dto.wsseguridad.scl.tmmas.com/xsd","FiltroDetDocAjusteCCargosSACDTO")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","filtrarDetDocAjusteCExcepcionCargos");
                
                responseMessage = new WSDLMessage("filtrarDetDocAjusteCExcepcionCargosResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.wsseguridad.scl.tmmas.com/xsd","FiltroDetDocAjusteCCargosSACDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","filtrarDetDocAjusteCExcepcionCargosResponse");
			filtrarDetDocAjusteCExcepcionCargos.inputMessage = requestMessage;
	        filtrarDetDocAjusteCExcepcionCargos.outputMessage = responseMessage;
            filtrarDetDocAjusteCExcepcionCargos.schemaManager = this.schemaMgr;
            filtrarDetDocAjusteCExcepcionCargos.soapAction = "urn:filtrarDetDocAjusteCExcepcionCargos";
            filtrarDetDocAjusteCExcepcionCargos.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(filtrarDetDocAjusteCExcepcionCargos);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var detallePlanTarifario:WSDLOperation = new WSDLOperation("detallePlanTarifario");
				//input message for the operation
    	        requestMessage = new WSDLMessage("detallePlanTarifario");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codPlanTarifario"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","detallePlanTarifario");
                
                responseMessage = new WSDLMessage("detallePlanTarifarioResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","DetallePlanTarifarioDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","detallePlanTarifarioResponse");
			detallePlanTarifario.inputMessage = requestMessage;
	        detallePlanTarifario.outputMessage = responseMessage;
            detallePlanTarifario.schemaManager = this.schemaMgr;
            detallePlanTarifario.soapAction = "urn:detallePlanTarifario";
            detallePlanTarifario.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(detallePlanTarifario);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var cargarCambioEquipoGSM:WSDLOperation = new WSDLOperation("cargarCambioEquipoGSM");
				//input message for the operation
    	        requestMessage = new WSDLMessage("cargarCambioEquipoGSM");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","numAbonado"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","nomUsuarioSCL"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codEvento"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","cargarCambioEquipoGSM");
                
                responseMessage = new WSDLMessage("cargarCambioEquipoGSMResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsfranquicias.scl.tmmas.com/xsd","CargaCambioEquipoGSMDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","cargarCambioEquipoGSMResponse");
			cargarCambioEquipoGSM.inputMessage = requestMessage;
	        cargarCambioEquipoGSM.outputMessage = responseMessage;
            cargarCambioEquipoGSM.schemaManager = this.schemaMgr;
            cargarCambioEquipoGSM.soapAction = "urn:cargarCambioEquipoGSM";
            cargarCambioEquipoGSM.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(cargarCambioEquipoGSM);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var ejecucionServicioCargos:WSDLOperation = new WSDLOperation("ejecucionServicioCargos");
				//input message for the operation
    	        requestMessage = new WSDLMessage("ejecucionServicioCargos");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","entrada"),null,new QName("http://dto.common.wsfranquicias.scl.tmmas.com/xsd","EjecucionServicioCargosDTO")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","ejecucionServicioCargos");
                
                responseMessage = new WSDLMessage("ejecucionServicioCargosResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsfranquicias.scl.tmmas.com/xsd","EjecucionServicioCargosDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","ejecucionServicioCargosResponse");
			ejecucionServicioCargos.inputMessage = requestMessage;
	        ejecucionServicioCargos.outputMessage = responseMessage;
            ejecucionServicioCargos.schemaManager = this.schemaMgr;
            ejecucionServicioCargos.soapAction = "urn:ejecucionServicioCargos";
            ejecucionServicioCargos.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(ejecucionServicioCargos);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var gruposXNomUsuario:WSDLOperation = new WSDLOperation("gruposXNomUsuario");
				//input message for the operation
    	        requestMessage = new WSDLMessage("gruposXNomUsuario");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","nomUsuario"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","gruposXNomUsuario");
                
                responseMessage = new WSDLMessage("gruposXNomUsuarioResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoGruposDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","gruposXNomUsuarioResponse");
			gruposXNomUsuario.inputMessage = requestMessage;
	        gruposXNomUsuario.outputMessage = responseMessage;
            gruposXNomUsuario.schemaManager = this.schemaMgr;
            gruposXNomUsuario.soapAction = "urn:gruposXNomUsuario";
            gruposXNomUsuario.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(gruposXNomUsuario);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var cargarAnulacionSiniestro:WSDLOperation = new WSDLOperation("cargarAnulacionSiniestro");
				//input message for the operation
    	        requestMessage = new WSDLMessage("cargarAnulacionSiniestro");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","numAbonado"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","nomUsuarioSCL"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codEvento"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","cargarAnulacionSiniestro");
                
                responseMessage = new WSDLMessage("cargarAnulacionSiniestroResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsfranquicias.scl.tmmas.com/xsd","CargaAnulacionSiniestroDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","cargarAnulacionSiniestroResponse");
			cargarAnulacionSiniestro.inputMessage = requestMessage;
	        cargarAnulacionSiniestro.outputMessage = responseMessage;
            cargarAnulacionSiniestro.schemaManager = this.schemaMgr;
            cargarAnulacionSiniestro.soapAction = "urn:cargarAnulacionSiniestro";
            cargarAnulacionSiniestro.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(cargarAnulacionSiniestro);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var ejecutarCambioSIMCard:WSDLOperation = new WSDLOperation("ejecutarCambioSIMCard");
				//input message for the operation
    	        requestMessage = new WSDLMessage("ejecutarCambioSIMCard");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","entrada"),null,new QName("http://dto.common.wsfranquicias.scl.tmmas.com/xsd","EjecucionCambioSIMCardDTO")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","ejecutarCambioSIMCard");
                
                responseMessage = new WSDLMessage("ejecutarCambioSIMCardResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsfranquicias.scl.tmmas.com/xsd","EjecucionCambioSIMCardDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","ejecutarCambioSIMCardResponse");
			ejecutarCambioSIMCard.inputMessage = requestMessage;
	        ejecutarCambioSIMCard.outputMessage = responseMessage;
            ejecutarCambioSIMCard.schemaManager = this.schemaMgr;
            ejecutarCambioSIMCard.soapAction = "urn:ejecutarCambioSIMCard";
            ejecutarCambioSIMCard.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(ejecutarCambioSIMCard);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var detalleLlamadas:WSDLOperation = new WSDLOperation("detalleLlamadas");
				//input message for the operation
    	        requestMessage = new WSDLMessage("detalleLlamadas");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codCliente"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","numAbonado"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codCiclo"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","tipoLlamada"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","detalleLlamadas");
                
                responseMessage = new WSDLMessage("detalleLlamadasResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoDetalleLlamadosDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","detalleLlamadasResponse");
			detalleLlamadas.inputMessage = requestMessage;
	        detalleLlamadas.outputMessage = responseMessage;
            detalleLlamadas.schemaManager = this.schemaMgr;
            detalleLlamadas.soapAction = "urn:detalleLlamadas";
            detalleLlamadas.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(detalleLlamadas);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var esPrimerLogin:WSDLOperation = new WSDLOperation("esPrimerLogin");
				//input message for the operation
    	        requestMessage = new WSDLMessage("esPrimerLogin");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","nomUsuario"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","esPrimerLogin");
                
                responseMessage = new WSDLMessage("esPrimerLoginResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://www.w3.org/2001/XMLSchema","boolean")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","esPrimerLoginResponse");
			esPrimerLogin.inputMessage = requestMessage;
	        esPrimerLogin.outputMessage = responseMessage;
            esPrimerLogin.schemaManager = this.schemaMgr;
            esPrimerLogin.soapAction = "urn:esPrimerLogin";
            esPrimerLogin.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(esPrimerLogin);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var cargaNumFrecuentes:WSDLOperation = new WSDLOperation("cargaNumFrecuentes");
				//input message for the operation
    	        requestMessage = new WSDLMessage("cargaNumFrecuentes");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","numAbonado"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","nomUsuarioSCL"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codEvento"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","cargaNumFrecuentes");
                
                responseMessage = new WSDLMessage("cargaNumFrecuentesResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.wsseguridad.scl.tmmas.com/xsd","CargaCambioNumFrecuentesSACDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","cargaNumFrecuentesResponse");
			cargaNumFrecuentes.inputMessage = requestMessage;
	        cargaNumFrecuentes.outputMessage = responseMessage;
            cargaNumFrecuentes.schemaManager = this.schemaMgr;
            cargaNumFrecuentes.soapAction = "urn:cargaNumFrecuentes";
            cargaNumFrecuentes.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(cargaNumFrecuentes);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var clientesXCodCliente:WSDLOperation = new WSDLOperation("clientesXCodCliente");
				//input message for the operation
    	        requestMessage = new WSDLMessage("clientesXCodCliente");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codCliente"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","clientesXCodCliente");
                
                responseMessage = new WSDLMessage("clientesXCodClienteResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoClientesDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","clientesXCodClienteResponse");
			clientesXCodCliente.inputMessage = requestMessage;
	        clientesXCodCliente.outputMessage = responseMessage;
            clientesXCodCliente.schemaManager = this.schemaMgr;
            clientesXCodCliente.soapAction = "urn:clientesXCodCliente";
            clientesXCodCliente.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(clientesXCodCliente);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var obtenerOoSsProceso:WSDLOperation = new WSDLOperation("obtenerOoSsProceso");
				//input message for the operation
    	        requestMessage = new WSDLMessage("obtenerOoSsProceso");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","nomUsuario"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","obtenerOoSsProceso");
                
                responseMessage = new WSDLMessage("obtenerOoSsProcesoResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoOrdenesProcesoDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","obtenerOoSsProcesoResponse");
			obtenerOoSsProceso.inputMessage = requestMessage;
	        obtenerOoSsProceso.outputMessage = responseMessage;
            obtenerOoSsProceso.schemaManager = this.schemaMgr;
            obtenerOoSsProceso.soapAction = "urn:obtenerOoSsProceso";
            obtenerOoSsProceso.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(obtenerOoSsProceso);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var ajustesXCodCliente:WSDLOperation = new WSDLOperation("ajustesXCodCliente");
				//input message for the operation
    	        requestMessage = new WSDLMessage("ajustesXCodCliente");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codCliente"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","ajustesXCodCliente");
                
                responseMessage = new WSDLMessage("ajustesXCodClienteResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoAjustesDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","ajustesXCodClienteResponse");
			ajustesXCodCliente.inputMessage = requestMessage;
	        ajustesXCodCliente.outputMessage = responseMessage;
            ajustesXCodCliente.schemaManager = this.schemaMgr;
            ajustesXCodCliente.soapAction = "urn:ajustesXCodCliente";
            ajustesXCodCliente.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(ajustesXCodCliente);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var cambiosPlanAbonadoPospago:WSDLOperation = new WSDLOperation("cambiosPlanAbonadoPospago");
				//input message for the operation
    	        requestMessage = new WSDLMessage("cambiosPlanAbonadoPospago");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","numOS"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","cambiosPlanAbonadoPospago");
                
                responseMessage = new WSDLMessage("cambiosPlanAbonadoPospagoResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoCambiosPlanTarifDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","cambiosPlanAbonadoPospagoResponse");
			cambiosPlanAbonadoPospago.inputMessage = requestMessage;
	        cambiosPlanAbonadoPospago.outputMessage = responseMessage;
            cambiosPlanAbonadoPospago.schemaManager = this.schemaMgr;
            cambiosPlanAbonadoPospago.soapAction = "urn:cambiosPlanAbonadoPospago";
            cambiosPlanAbonadoPospago.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(cambiosPlanAbonadoPospago);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var consultaOoSsProceso:WSDLOperation = new WSDLOperation("consultaOoSsProceso");
				//input message for the operation
    	        requestMessage = new WSDLMessage("consultaOoSsProceso");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","nomUsuario"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","consultaOoSsProceso");
                
                responseMessage = new WSDLMessage("consultaOoSsProcesoResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://www.w3.org/2001/XMLSchema","boolean")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","consultaOoSsProcesoResponse");
			consultaOoSsProceso.inputMessage = requestMessage;
	        consultaOoSsProceso.outputMessage = responseMessage;
            consultaOoSsProceso.schemaManager = this.schemaMgr;
            consultaOoSsProceso.soapAction = "urn:consultaOoSsProceso";
            consultaOoSsProceso.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(consultaOoSsProceso);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var ingresoAtencion:WSDLOperation = new WSDLOperation("ingresoAtencion");
				//input message for the operation
    	        requestMessage = new WSDLMessage("ingresoAtencion");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","resgistroAtencionDTO"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ResgistroAtencionDTO")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","ingresoAtencion");
                
                responseMessage = new WSDLMessage("ingresoAtencionResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ResulTransaccionDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","ingresoAtencionResponse");
			ingresoAtencion.inputMessage = requestMessage;
	        ingresoAtencion.outputMessage = responseMessage;
            ingresoAtencion.schemaManager = this.schemaMgr;
            ingresoAtencion.soapAction = "urn:ingresoAtencion";
            ingresoAtencion.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(ingresoAtencion);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var decirHelloWorld:WSDLOperation = new WSDLOperation("decirHelloWorld");
				//input message for the operation
    	        requestMessage = new WSDLMessage("");
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="";
			requestMessage.encoding.useStyle="literal";
                
                responseMessage = new WSDLMessage("decirHelloWorldResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","decirHelloWorldResponse");
			decirHelloWorld.inputMessage = requestMessage;
	        decirHelloWorld.outputMessage = responseMessage;
            decirHelloWorld.schemaManager = this.schemaMgr;
            decirHelloWorld.soapAction = "urn:decirHelloWorld";
            decirHelloWorld.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(decirHelloWorld);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var cambiarDireccionesCliente:WSDLOperation = new WSDLOperation("cambiarDireccionesCliente");
				//input message for the operation
    	        requestMessage = new WSDLMessage("cambiarDireccionesCliente");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","dto"),null,new QName("http://dto.wsseguridad.scl.tmmas.com/xsd","ListadoDireccionesSACDTO")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","cambiarDireccionesCliente");
                
                responseMessage = new WSDLMessage("cambiarDireccionesClienteResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.wsseguridad.scl.tmmas.com/xsd","ListadoOrdenesServicioSACDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","cambiarDireccionesClienteResponse");
			cambiarDireccionesCliente.inputMessage = requestMessage;
	        cambiarDireccionesCliente.outputMessage = responseMessage;
            cambiarDireccionesCliente.schemaManager = this.schemaMgr;
            cambiarDireccionesCliente.soapAction = "urn:cambiarDireccionesCliente";
            cambiarDireccionesCliente.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(cambiarDireccionesCliente);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var consultaAtencion:WSDLOperation = new WSDLOperation("consultaAtencion");
				//input message for the operation
    	        requestMessage = new WSDLMessage("");
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="";
			requestMessage.encoding.useStyle="literal";
                
                responseMessage = new WSDLMessage("consultaAtencionResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListaAtencionClienteDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","consultaAtencionResponse");
			consultaAtencion.inputMessage = requestMessage;
	        consultaAtencion.outputMessage = responseMessage;
            consultaAtencion.schemaManager = this.schemaMgr;
            consultaAtencion.soapAction = "urn:consultaAtencion";
            consultaAtencion.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(consultaAtencion);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var obtenerCausalCambio:WSDLOperation = new WSDLOperation("obtenerCausalCambio");
				//input message for the operation
    	        requestMessage = new WSDLMessage("");
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="";
			requestMessage.encoding.useStyle="literal";
                
                responseMessage = new WSDLMessage("obtenerCausalCambioResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListaCausalCambioDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","obtenerCausalCambioResponse");
			obtenerCausalCambio.inputMessage = requestMessage;
	        obtenerCausalCambio.outputMessage = responseMessage;
            obtenerCausalCambio.schemaManager = this.schemaMgr;
            obtenerCausalCambio.soapAction = "urn:obtenerCausalCambio";
            obtenerCausalCambio.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(obtenerCausalCambio);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var cambiarPassword:WSDLOperation = new WSDLOperation("cambiarPassword");
				//input message for the operation
    	        requestMessage = new WSDLMessage("cambiarPassword");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","usuario"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","passwordActual"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","passwordNueva"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","cambiarPassword");
                
                responseMessage = new WSDLMessage("cambiarPasswordResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://www.w3.org/2001/XMLSchema","boolean")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","cambiarPasswordResponse");
			cambiarPassword.inputMessage = requestMessage;
	        cambiarPassword.outputMessage = responseMessage;
            cambiarPassword.schemaManager = this.schemaMgr;
            cambiarPassword.soapAction = "urn:cambiarPassword";
            cambiarPassword.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(cambiarPassword);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var direccionesXCodCliente:WSDLOperation = new WSDLOperation("direccionesXCodCliente");
				//input message for the operation
    	        requestMessage = new WSDLMessage("direccionesXCodCliente");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codCliente"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","nomUsuarioSCL"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codEvento"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","direccionesXCodCliente");
                
                responseMessage = new WSDLMessage("direccionesXCodClienteResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoDireccionesDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","direccionesXCodClienteResponse");
			direccionesXCodCliente.inputMessage = requestMessage;
	        direccionesXCodCliente.outputMessage = responseMessage;
            direccionesXCodCliente.schemaManager = this.schemaMgr;
            direccionesXCodCliente.soapAction = "urn:direccionesXCodCliente";
            direccionesXCodCliente.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(direccionesXCodCliente);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var cargarAbonoLimiteConsumoSS:WSDLOperation = new WSDLOperation("cargarAbonoLimiteConsumoSS");
				//input message for the operation
    	        requestMessage = new WSDLMessage("cargarAbonoLimiteConsumoSS");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codSujeto"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","tipoAbono"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","tipoOOSS"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","nomUsuarioSCL"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codEvento"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","cargarAbonoLimiteConsumoSS");
                
                responseMessage = new WSDLMessage("cargarAbonoLimiteConsumoSSResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsfranquicias.scl.tmmas.com/xsd","CargaAbonoLimiteConsumoServicioSuplementarioDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","cargarAbonoLimiteConsumoSSResponse");
			cargarAbonoLimiteConsumoSS.inputMessage = requestMessage;
	        cargarAbonoLimiteConsumoSS.outputMessage = responseMessage;
            cargarAbonoLimiteConsumoSS.schemaManager = this.schemaMgr;
            cargarAbonoLimiteConsumoSS.soapAction = "urn:cargarAbonoLimiteConsumoSS";
            cargarAbonoLimiteConsumoSS.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(cargarAbonoLimiteConsumoSS);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var ejecutarSuspensionSrvCelular:WSDLOperation = new WSDLOperation("ejecutarSuspensionSrvCelular");
				//input message for the operation
    	        requestMessage = new WSDLMessage("ejecutarSuspensionSrvCelular");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","entrada"),null,new QName("http://dto.common.wsfranquicias.scl.tmmas.com/xsd","EjecucionSuspensionSrvCelDTO")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","ejecutarSuspensionSrvCelular");
                
                responseMessage = new WSDLMessage("ejecutarSuspensionSrvCelularResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsfranquicias.scl.tmmas.com/xsd","EjecucionSuspensionSrvCelDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","ejecutarSuspensionSrvCelularResponse");
			ejecutarSuspensionSrvCelular.inputMessage = requestMessage;
	        ejecutarSuspensionSrvCelular.outputMessage = responseMessage;
            ejecutarSuspensionSrvCelular.schemaManager = this.schemaMgr;
            ejecutarSuspensionSrvCelular.soapAction = "urn:ejecutarSuspensionSrvCelular";
            ejecutarSuspensionSrvCelular.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(ejecutarSuspensionSrvCelular);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var cargaServicioCargos:WSDLOperation = new WSDLOperation("cargaServicioCargos");
				//input message for the operation
    	        requestMessage = new WSDLMessage("cargaServicioCargos");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","entrada"),null,new QName("http://dto.common.wsfranquicias.scl.tmmas.com/xsd","CargaServicioCargosDTO")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","ventaSimcard"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","cargaServicioCargos");
                
                responseMessage = new WSDLMessage("cargaServicioCargosResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsfranquicias.scl.tmmas.com/xsd","CargaServicioCargosDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","cargaServicioCargosResponse");
			cargaServicioCargos.inputMessage = requestMessage;
	        cargaServicioCargos.outputMessage = responseMessage;
            cargaServicioCargos.schemaManager = this.schemaMgr;
            cargaServicioCargos.soapAction = "urn:cargaServicioCargos";
            cargaServicioCargos.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(cargaServicioCargos);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var oossEjecutadasXCodCuenta:WSDLOperation = new WSDLOperation("oossEjecutadasXCodCuenta");
				//input message for the operation
    	        requestMessage = new WSDLMessage("oossEjecutadasXCodCuenta");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codCuenta"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","nomUsuarioSCL"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codEvento"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","oossEjecutadasXCodCuenta");
                
                responseMessage = new WSDLMessage("oossEjecutadasXCodCuentaResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoOrdenesServicioDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","oossEjecutadasXCodCuentaResponse");
			oossEjecutadasXCodCuenta.inputMessage = requestMessage;
	        oossEjecutadasXCodCuenta.outputMessage = responseMessage;
            oossEjecutadasXCodCuenta.schemaManager = this.schemaMgr;
            oossEjecutadasXCodCuenta.soapAction = "urn:oossEjecutadasXCodCuenta";
            oossEjecutadasXCodCuenta.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(oossEjecutadasXCodCuenta);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var consultaOrdenServicio:WSDLOperation = new WSDLOperation("consultaOrdenServicio");
				//input message for the operation
    	        requestMessage = new WSDLMessage("consultaOrdenServicio");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codOOSS"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","numTransaccion"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","nomUsuarioSCL"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","consultaOrdenServicio");
                
                responseMessage = new WSDLMessage("consultaOrdenServicioResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.wsseguridad.scl.tmmas.com/xsd","ConsultarOrdenServicioSACDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","consultaOrdenServicioResponse");
			consultaOrdenServicio.inputMessage = requestMessage;
	        consultaOrdenServicio.outputMessage = responseMessage;
            consultaOrdenServicio.schemaManager = this.schemaMgr;
            consultaOrdenServicio.soapAction = "urn:consultaOrdenServicio";
            consultaOrdenServicio.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(consultaOrdenServicio);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var facturasXCodCliente:WSDLOperation = new WSDLOperation("facturasXCodCliente");
				//input message for the operation
    	        requestMessage = new WSDLMessage("facturasXCodCliente");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codCliente"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","nomUsuarioSCL"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codEvento"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","facturasXCodCliente");
                
                responseMessage = new WSDLMessage("facturasXCodClienteResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoFacturasDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","facturasXCodClienteResponse");
			facturasXCodCliente.inputMessage = requestMessage;
	        facturasXCodCliente.outputMessage = responseMessage;
            facturasXCodCliente.schemaManager = this.schemaMgr;
            facturasXCodCliente.soapAction = "urn:facturasXCodCliente";
            facturasXCodCliente.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(facturasXCodCliente);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var pagoLimiteConsumoXClienteAbonado:WSDLOperation = new WSDLOperation("pagoLimiteConsumoXClienteAbonado");
				//input message for the operation
    	        requestMessage = new WSDLMessage("pagoLimiteConsumoXClienteAbonado");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codCliente"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","numAbonado"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","nomUsuarioSCL"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codEvento"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","pagoLimiteConsumoXClienteAbonado");
                
                responseMessage = new WSDLMessage("pagoLimiteConsumoXClienteAbonadoResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoPagosLimiteConsumoDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","pagoLimiteConsumoXClienteAbonadoResponse");
			pagoLimiteConsumoXClienteAbonado.inputMessage = requestMessage;
	        pagoLimiteConsumoXClienteAbonado.outputMessage = responseMessage;
            pagoLimiteConsumoXClienteAbonado.schemaManager = this.schemaMgr;
            pagoLimiteConsumoXClienteAbonado.soapAction = "urn:pagoLimiteConsumoXClienteAbonado";
            pagoLimiteConsumoXClienteAbonado.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(pagoLimiteConsumoXClienteAbonado);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var pagosXCodCliente:WSDLOperation = new WSDLOperation("pagosXCodCliente");
				//input message for the operation
    	        requestMessage = new WSDLMessage("pagosXCodCliente");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codCliente"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","nomUsuarioSCL"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codEvento"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","pagosXCodCliente");
                
                responseMessage = new WSDLMessage("pagosXCodClienteResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoPagosDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","pagosXCodClienteResponse");
			pagosXCodCliente.inputMessage = requestMessage;
	        pagosXCodCliente.outputMessage = responseMessage;
            pagosXCodCliente.schemaManager = this.schemaMgr;
            pagosXCodCliente.soapAction = "urn:pagosXCodCliente";
            pagosXCodCliente.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(pagosXCodCliente);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var cambiosPlanCliente:WSDLOperation = new WSDLOperation("cambiosPlanCliente");
				//input message for the operation
    	        requestMessage = new WSDLMessage("cambiosPlanCliente");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","numOS"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","cambiosPlanCliente");
                
                responseMessage = new WSDLMessage("cambiosPlanClienteResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoCambiosPlanTarifDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","cambiosPlanClienteResponse");
			cambiosPlanCliente.inputMessage = requestMessage;
	        cambiosPlanCliente.outputMessage = responseMessage;
            cambiosPlanCliente.schemaManager = this.schemaMgr;
            cambiosPlanCliente.soapAction = "urn:cambiosPlanCliente";
            cambiosPlanCliente.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(cambiosPlanCliente);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var ejecutarAjusteCExcepcionCargos:WSDLOperation = new WSDLOperation("ejecutarAjusteCExcepcionCargos");
				//input message for the operation
    	        requestMessage = new WSDLMessage("ejecutarAjusteCExcepcionCargos");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","entrada"),null,new QName("http://dto.wsseguridad.scl.tmmas.com/xsd","EjecucionAjusteCExcepcionCargosSACDTO")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","ejecutarAjusteCExcepcionCargos");
                
                responseMessage = new WSDLMessage("ejecutarAjusteCExcepcionCargosResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsfranquicias.scl.tmmas.com/xsd","EjecucionAjusteCExcepcionCargosDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","ejecutarAjusteCExcepcionCargosResponse");
			ejecutarAjusteCExcepcionCargos.inputMessage = requestMessage;
	        ejecutarAjusteCExcepcionCargos.outputMessage = responseMessage;
            ejecutarAjusteCExcepcionCargos.schemaManager = this.schemaMgr;
            ejecutarAjusteCExcepcionCargos.soapAction = "urn:ejecutarAjusteCExcepcionCargos";
            ejecutarAjusteCExcepcionCargos.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(ejecutarAjusteCExcepcionCargos);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var beneficiosXClienteAbonado:WSDLOperation = new WSDLOperation("beneficiosXClienteAbonado");
				//input message for the operation
    	        requestMessage = new WSDLMessage("beneficiosXClienteAbonado");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codCliente"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","numAbonado"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","nomUsuarioSCL"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codEvento"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","beneficiosXClienteAbonado");
                
                responseMessage = new WSDLMessage("beneficiosXClienteAbonadoResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoBeneficiosDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","beneficiosXClienteAbonadoResponse");
			beneficiosXClienteAbonado.inputMessage = requestMessage;
	        beneficiosXClienteAbonado.outputMessage = responseMessage;
            beneficiosXClienteAbonado.schemaManager = this.schemaMgr;
            beneficiosXClienteAbonado.soapAction = "urn:beneficiosXClienteAbonado";
            beneficiosXClienteAbonado.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(beneficiosXClienteAbonado);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var insertComentarioPvIorserv:WSDLOperation = new WSDLOperation("insertComentarioPvIorserv");
				//input message for the operation
    	        requestMessage = new WSDLMessage("insertComentarioPvIorserv");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","comentario"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","numOoss"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","insertComentarioPvIorserv");
                
                responseMessage = new WSDLMessage("insertComentarioPvIorservResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ResulTransaccionDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","insertComentarioPvIorservResponse");
			insertComentarioPvIorserv.inputMessage = requestMessage;
	        insertComentarioPvIorserv.outputMessage = responseMessage;
            insertComentarioPvIorserv.schemaManager = this.schemaMgr;
            insertComentarioPvIorserv.soapAction = "urn:insertComentarioPvIorserv";
            insertComentarioPvIorserv.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(insertComentarioPvIorserv);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var realizarBloqueoRobo:WSDLOperation = new WSDLOperation("realizarBloqueoRobo");
				//input message for the operation
    	        requestMessage = new WSDLMessage("realizarBloqueoRobo");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","dto"),null,new QName("http://dto.wsseguridad.scl.tmmas.com/xsd","RealizarBloqueoRoboSACINDTO")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","realizarBloqueoRobo");
                
                responseMessage = new WSDLMessage("realizarBloqueoRoboResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.wsseguridad.scl.tmmas.com/xsd","RealizarBloqueoRoboSACOUTDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","realizarBloqueoRoboResponse");
			realizarBloqueoRobo.inputMessage = requestMessage;
	        realizarBloqueoRobo.outputMessage = responseMessage;
            realizarBloqueoRobo.schemaManager = this.schemaMgr;
            realizarBloqueoRobo.soapAction = "urn:realizarBloqueoRobo";
            realizarBloqueoRobo.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(realizarBloqueoRobo);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var cuentasXNumIdent:WSDLOperation = new WSDLOperation("cuentasXNumIdent");
				//input message for the operation
    	        requestMessage = new WSDLMessage("cuentasXNumIdent");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","numIdent"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","cuentasXNumIdent");
                
                responseMessage = new WSDLMessage("cuentasXNumIdentResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoCuentasDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","cuentasXNumIdentResponse");
			cuentasXNumIdent.inputMessage = requestMessage;
	        cuentasXNumIdent.outputMessage = responseMessage;
            cuentasXNumIdent.schemaManager = this.schemaMgr;
            cuentasXNumIdent.soapAction = "urn:cuentasXNumIdent";
            cuentasXNumIdent.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(cuentasXNumIdent);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var ejecutarCambioNumFrecuente:WSDLOperation = new WSDLOperation("ejecutarCambioNumFrecuente");
				//input message for the operation
    	        requestMessage = new WSDLMessage("ejecutarCambioNumFrecuente");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","entrada"),null,new QName("http://dto.wsseguridad.scl.tmmas.com/xsd","EjecucionCambioNumFrecuentesSACDTO")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","ejecutarCambioNumFrecuente");
                
                responseMessage = new WSDLMessage("ejecutarCambioNumFrecuenteResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.wsseguridad.scl.tmmas.com/xsd","EjecucionCambioNumFrecuentesSACDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","ejecutarCambioNumFrecuenteResponse");
			ejecutarCambioNumFrecuente.inputMessage = requestMessage;
	        ejecutarCambioNumFrecuente.outputMessage = responseMessage;
            ejecutarCambioNumFrecuente.schemaManager = this.schemaMgr;
            ejecutarCambioNumFrecuente.soapAction = "urn:ejecutarCambioNumFrecuente";
            ejecutarCambioNumFrecuente.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(ejecutarCambioNumFrecuente);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var obtenerReportePresEquiInt:WSDLOperation = new WSDLOperation("obtenerReportePresEquiInt");
				//input message for the operation
    	        requestMessage = new WSDLMessage("obtenerReportePresEquiInt");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","fechaDesde"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","fechaHasta"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","obtenerReportePresEquiInt");
                
                responseMessage = new WSDLMessage("obtenerReportePresEquiIntResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoReportePresEquiIntDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","obtenerReportePresEquiIntResponse");
			obtenerReportePresEquiInt.inputMessage = requestMessage;
	        obtenerReportePresEquiInt.outputMessage = responseMessage;
            obtenerReportePresEquiInt.schemaManager = this.schemaMgr;
            obtenerReportePresEquiInt.soapAction = "urn:obtenerReportePresEquiInt";
            obtenerReportePresEquiInt.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(obtenerReportePresEquiInt);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var crearUsuario:WSDLOperation = new WSDLOperation("crearUsuario");
				//input message for the operation
    	        requestMessage = new WSDLMessage("crearUsuario");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","usuario"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","password"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","passwordConfirmada"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","crearUsuario");
                
                responseMessage = new WSDLMessage("crearUsuarioResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://www.w3.org/2001/XMLSchema","boolean")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","crearUsuarioResponse");
			crearUsuario.inputMessage = requestMessage;
	        crearUsuario.outputMessage = responseMessage;
            crearUsuario.schemaManager = this.schemaMgr;
            crearUsuario.soapAction = "urn:crearUsuario";
            crearUsuario.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(crearUsuario);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var obtenerListDatosAbonados:WSDLOperation = new WSDLOperation("obtenerListDatosAbonados");
				//input message for the operation
    	        requestMessage = new WSDLMessage("obtenerListDatosAbonados");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codCliente"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","obtenerListDatosAbonados");
                
                responseMessage = new WSDLMessage("obtenerListDatosAbonadosResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoAbonadosDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","obtenerListDatosAbonadosResponse");
			obtenerListDatosAbonados.inputMessage = requestMessage;
	        obtenerListDatosAbonados.outputMessage = responseMessage;
            obtenerListDatosAbonados.schemaManager = this.schemaMgr;
            obtenerListDatosAbonados.soapAction = "urn:obtenerListDatosAbonados";
            obtenerListDatosAbonados.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(obtenerListDatosAbonados);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var getDetalleAbonado:WSDLOperation = new WSDLOperation("getDetalleAbonado");
				//input message for the operation
    	        requestMessage = new WSDLMessage("getDetalleAbonado");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","numAbonado"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","nomUsuarioSCL"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codEvento"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","getDetalleAbonado");
                
                responseMessage = new WSDLMessage("getDetalleAbonadoResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","DetalleAbonadoDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","getDetalleAbonadoResponse");
			getDetalleAbonado.inputMessage = requestMessage;
	        getDetalleAbonado.outputMessage = responseMessage;
            getDetalleAbonado.schemaManager = this.schemaMgr;
            getDetalleAbonado.soapAction = "urn:getDetalleAbonado";
            getDetalleAbonado.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(getDetalleAbonado);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var productosXCodCliente:WSDLOperation = new WSDLOperation("productosXCodCliente");
				//input message for the operation
    	        requestMessage = new WSDLMessage("productosXCodCliente");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codCliente"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","nomUsuarioSCL"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codEvento"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","productosXCodCliente");
                
                responseMessage = new WSDLMessage("productosXCodClienteResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoProductosDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","productosXCodClienteResponse");
			productosXCodCliente.inputMessage = requestMessage;
	        productosXCodCliente.outputMessage = responseMessage;
            productosXCodCliente.schemaManager = this.schemaMgr;
            productosXCodCliente.soapAction = "urn:productosXCodCliente";
            productosXCodCliente.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(productosXCodCliente);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var oossEjecutadasXCodCliente:WSDLOperation = new WSDLOperation("oossEjecutadasXCodCliente");
				//input message for the operation
    	        requestMessage = new WSDLMessage("oossEjecutadasXCodCliente");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codCliente"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","nomUsuarioSCL"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codEvento"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","oossEjecutadasXCodCliente");
                
                responseMessage = new WSDLMessage("oossEjecutadasXCodClienteResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoOrdenesServicioDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","oossEjecutadasXCodClienteResponse");
			oossEjecutadasXCodCliente.inputMessage = requestMessage;
	        oossEjecutadasXCodCliente.outputMessage = responseMessage;
            oossEjecutadasXCodCliente.schemaManager = this.schemaMgr;
            oossEjecutadasXCodCliente.soapAction = "urn:oossEjecutadasXCodCliente";
            oossEjecutadasXCodCliente.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(oossEjecutadasXCodCliente);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var productosXNumAbonado:WSDLOperation = new WSDLOperation("productosXNumAbonado");
				//input message for the operation
    	        requestMessage = new WSDLMessage("productosXNumAbonado");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","numAbonado"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","nomUsuarioSCL"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codEvento"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","productosXNumAbonado");
                
                responseMessage = new WSDLMessage("productosXNumAbonadoResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoProductosDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","productosXNumAbonadoResponse");
			productosXNumAbonado.inputMessage = requestMessage;
	        productosXNumAbonado.outputMessage = responseMessage;
            productosXNumAbonado.schemaManager = this.schemaMgr;
            productosXNumAbonado.soapAction = "urn:productosXNumAbonado";
            productosXNumAbonado.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(productosXNumAbonado);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var cargaValidaOSUsuario:WSDLOperation = new WSDLOperation("cargaValidaOSUsuario");
				//input message for the operation
    	        requestMessage = new WSDLMessage("cargaValidaOSUsuario");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","usuario"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","cargaValidaOSUsuario");
                
                responseMessage = new WSDLMessage("cargaValidaOSUsuarioResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","MenuDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","cargaValidaOSUsuarioResponse");
			cargaValidaOSUsuario.inputMessage = requestMessage;
	        cargaValidaOSUsuario.outputMessage = responseMessage;
            cargaValidaOSUsuario.schemaManager = this.schemaMgr;
            cargaValidaOSUsuario.soapAction = "urn:cargaValidaOSUsuario";
            cargaValidaOSUsuario.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(cargaValidaOSUsuario);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var cargarCambioSIMCard:WSDLOperation = new WSDLOperation("cargarCambioSIMCard");
				//input message for the operation
    	        requestMessage = new WSDLMessage("cargarCambioSIMCard");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","numAbonado"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","nomUsuarioSCL"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codEvento"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","cargarCambioSIMCard");
                
                responseMessage = new WSDLMessage("cargarCambioSIMCardResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsfranquicias.scl.tmmas.com/xsd","CargaCambioSIMCardDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","cargarCambioSIMCardResponse");
			cargarCambioSIMCard.inputMessage = requestMessage;
	        cargarCambioSIMCard.outputMessage = responseMessage;
            cargarCambioSIMCard.schemaManager = this.schemaMgr;
            cargarCambioSIMCard.soapAction = "urn:cargarCambioSIMCard";
            cargarCambioSIMCard.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(cargarCambioSIMCard);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var obtenerReporteCambioEquiGene:WSDLOperation = new WSDLOperation("obtenerReporteCambioEquiGene");
				//input message for the operation
    	        requestMessage = new WSDLMessage("obtenerReporteCambioEquiGene");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","fechaDesde"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","fechaHasta"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codCausalCam"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","obtenerReporteCambioEquiGene");
                
                responseMessage = new WSDLMessage("obtenerReporteCambioEquiGeneResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoReporteCamEquiGenDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","obtenerReporteCambioEquiGeneResponse");
			obtenerReporteCambioEquiGene.inputMessage = requestMessage;
	        obtenerReporteCambioEquiGene.outputMessage = responseMessage;
            obtenerReporteCambioEquiGene.schemaManager = this.schemaMgr;
            obtenerReporteCambioEquiGene.soapAction = "urn:obtenerReporteCambioEquiGene";
            obtenerReporteCambioEquiGene.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(obtenerReporteCambioEquiGene);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var obtenerDatosAbonado:WSDLOperation = new WSDLOperation("obtenerDatosAbonado");
				//input message for the operation
    	        requestMessage = new WSDLMessage("obtenerDatosAbonado");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","numAbonado"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","obtenerDatosAbonado");
                
                responseMessage = new WSDLMessage("obtenerDatosAbonadoResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","AbonadoDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","obtenerDatosAbonadoResponse");
			obtenerDatosAbonado.inputMessage = requestMessage;
	        obtenerDatosAbonado.outputMessage = responseMessage;
            obtenerDatosAbonado.schemaManager = this.schemaMgr;
            obtenerDatosAbonado.soapAction = "urn:obtenerDatosAbonado";
            obtenerDatosAbonado.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(obtenerDatosAbonado);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var umtsAbonadosXCodCliente:WSDLOperation = new WSDLOperation("umtsAbonadosXCodCliente");
				//input message for the operation
    	        requestMessage = new WSDLMessage("umtsAbonadosXCodCliente");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codCliente"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","umtsAbonadosXCodCliente");
                
                responseMessage = new WSDLMessage("umtsAbonadosXCodClienteResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoUmtsAbonadosDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","umtsAbonadosXCodClienteResponse");
			umtsAbonadosXCodCliente.inputMessage = requestMessage;
	        umtsAbonadosXCodCliente.outputMessage = responseMessage;
            umtsAbonadosXCodCliente.schemaManager = this.schemaMgr;
            umtsAbonadosXCodCliente.soapAction = "urn:umtsAbonadosXCodCliente";
            umtsAbonadosXCodCliente.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(umtsAbonadosXCodCliente);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var cargarAjusteCExcepcionCargos:WSDLOperation = new WSDLOperation("cargarAjusteCExcepcionCargos");
				//input message for the operation
    	        requestMessage = new WSDLMessage("cargarAjusteCExcepcionCargos");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codCliente"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","nomUsuarioSCL"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","pwd"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codEvento"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","cargarAjusteCExcepcionCargos");
                
                responseMessage = new WSDLMessage("cargarAjusteCExcepcionCargosResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.wsseguridad.scl.tmmas.com/xsd","CargaAjusteCExcepcionCargosSACDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","cargarAjusteCExcepcionCargosResponse");
			cargarAjusteCExcepcionCargos.inputMessage = requestMessage;
	        cargarAjusteCExcepcionCargos.outputMessage = responseMessage;
            cargarAjusteCExcepcionCargos.schemaManager = this.schemaMgr;
            cargarAjusteCExcepcionCargos.soapAction = "urn:cargarAjusteCExcepcionCargos";
            cargarAjusteCExcepcionCargos.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(cargarAjusteCExcepcionCargos);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var obtenerDatosDireccionCliente:WSDLOperation = new WSDLOperation("obtenerDatosDireccionCliente");
				//input message for the operation
    	        requestMessage = new WSDLMessage("obtenerDatosDireccionCliente");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","pIn"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","DatosDireccionClienteINDTO")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","obtenerDatosDireccionCliente");
                
                responseMessage = new WSDLMessage("obtenerDatosDireccionClienteResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","DireccionPorClienteDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","obtenerDatosDireccionClienteResponse");
			obtenerDatosDireccionCliente.inputMessage = requestMessage;
	        obtenerDatosDireccionCliente.outputMessage = responseMessage;
            obtenerDatosDireccionCliente.schemaManager = this.schemaMgr;
            obtenerDatosDireccionCliente.soapAction = "urn:obtenerDatosDireccionCliente";
            obtenerDatosDireccionCliente.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(obtenerDatosDireccionCliente);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var ejecutarAbonoLimiteConsumoSS:WSDLOperation = new WSDLOperation("ejecutarAbonoLimiteConsumoSS");
				//input message for the operation
    	        requestMessage = new WSDLMessage("ejecutarAbonoLimiteConsumoSS");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","entrada"),null,new QName("http://dto.common.wsfranquicias.scl.tmmas.com/xsd","EjecucionAbonoLimiteConsumoServicioSuplementarioDTO")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","ejecutarAbonoLimiteConsumoSS");
                
                responseMessage = new WSDLMessage("ejecutarAbonoLimiteConsumoSSResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsfranquicias.scl.tmmas.com/xsd","EjecucionAbonoLimiteConsumoServicioSuplementarioDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","ejecutarAbonoLimiteConsumoSSResponse");
			ejecutarAbonoLimiteConsumoSS.inputMessage = requestMessage;
	        ejecutarAbonoLimiteConsumoSS.outputMessage = responseMessage;
            ejecutarAbonoLimiteConsumoSS.schemaManager = this.schemaMgr;
            ejecutarAbonoLimiteConsumoSS.soapAction = "urn:ejecutarAbonoLimiteConsumoSS";
            ejecutarAbonoLimiteConsumoSS.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(ejecutarAbonoLimiteConsumoSS);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var ejecucionCambioDatosCliente:WSDLOperation = new WSDLOperation("ejecucionCambioDatosCliente");
				//input message for the operation
    	        requestMessage = new WSDLMessage("ejecucionCambioDatosCliente");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","entrada"),null,new QName("http://dto.wsseguridad.scl.tmmas.com/xsd","EjecucionCambioDatosClienteSACDTO")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","ejecucionCambioDatosCliente");
                
                responseMessage = new WSDLMessage("ejecucionCambioDatosClienteResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.wsseguridad.scl.tmmas.com/xsd","EjecucionCambioDatosClienteSACDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","ejecucionCambioDatosClienteResponse");
			ejecucionCambioDatosCliente.inputMessage = requestMessage;
	        ejecucionCambioDatosCliente.outputMessage = responseMessage;
            ejecucionCambioDatosCliente.schemaManager = this.schemaMgr;
            ejecucionCambioDatosCliente.soapAction = "urn:ejecucionCambioDatosCliente";
            ejecucionCambioDatosCliente.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(ejecucionCambioDatosCliente);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var consultasXCodGrupo:WSDLOperation = new WSDLOperation("consultasXCodGrupo");
				//input message for the operation
    	        requestMessage = new WSDLMessage("consultasXCodGrupo");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codGrupo"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codPrograma"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","numVersion"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","consultasXCodGrupo");
                
                responseMessage = new WSDLMessage("consultasXCodGrupoResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoConsultasDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","consultasXCodGrupoResponse");
			consultasXCodGrupo.inputMessage = requestMessage;
	        consultasXCodGrupo.outputMessage = responseMessage;
            consultasXCodGrupo.schemaManager = this.schemaMgr;
            consultasXCodGrupo.soapAction = "urn:consultasXCodGrupo";
            consultasXCodGrupo.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(consultasXCodGrupo);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var cargarSuspensionSrvCelular:WSDLOperation = new WSDLOperation("cargarSuspensionSrvCelular");
				//input message for the operation
    	        requestMessage = new WSDLMessage("cargarSuspensionSrvCelular");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","numAbonado"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","nomUsuarioSCL"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codEvento"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","cargarSuspensionSrvCelular");
                
                responseMessage = new WSDLMessage("cargarSuspensionSrvCelularResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsfranquicias.scl.tmmas.com/xsd","CargaSuspensionSrvCelDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","cargarSuspensionSrvCelularResponse");
			cargarSuspensionSrvCelular.inputMessage = requestMessage;
	        cargarSuspensionSrvCelular.outputMessage = responseMessage;
            cargarSuspensionSrvCelular.schemaManager = this.schemaMgr;
            cargarSuspensionSrvCelular.soapAction = "urn:cargarSuspensionSrvCelular";
            cargarSuspensionSrvCelular.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(cargarSuspensionSrvCelular);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var getDetalleCliente:WSDLOperation = new WSDLOperation("getDetalleCliente");
				//input message for the operation
    	        requestMessage = new WSDLMessage("getDetalleCliente");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codCliente"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","nomUsuarioSCL"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codEvento"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","getDetalleCliente");
                
                responseMessage = new WSDLMessage("getDetalleClienteResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","DetalleClienteDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","getDetalleClienteResponse");
			getDetalleCliente.inputMessage = requestMessage;
	        getDetalleCliente.outputMessage = responseMessage;
            getDetalleCliente.schemaManager = this.schemaMgr;
            getDetalleCliente.soapAction = "urn:getDetalleCliente";
            getDetalleCliente.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(getDetalleCliente);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var getDetalleEquipo:WSDLOperation = new WSDLOperation("getDetalleEquipo");
				//input message for the operation
    	        requestMessage = new WSDLMessage("getDetalleEquipo");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","numAbonado"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","nomUsuarioSCL"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codEvento"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","getDetalleEquipo");
                
                responseMessage = new WSDLMessage("getDetalleEquipoResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","EquipoSimcardDetalleDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","getDetalleEquipoResponse");
			getDetalleEquipo.inputMessage = requestMessage;
	        getDetalleEquipo.outputMessage = responseMessage;
            getDetalleEquipo.schemaManager = this.schemaMgr;
            getDetalleEquipo.soapAction = "urn:getDetalleEquipo";
            getDetalleEquipo.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(getDetalleEquipo);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var getDeudaCliente:WSDLOperation = new WSDLOperation("getDeudaCliente");
				//input message for the operation
    	        requestMessage = new WSDLMessage("getDeudaCliente");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codCliente"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","getDeudaCliente");
                
                responseMessage = new WSDLMessage("getDeudaClienteResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","DeudaClienteDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","getDeudaClienteResponse");
			getDeudaCliente.inputMessage = requestMessage;
	        getDeudaCliente.outputMessage = responseMessage;
            getDeudaCliente.schemaManager = this.schemaMgr;
            getDeudaCliente.soapAction = "urn:getDeudaCliente";
            getDeudaCliente.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(getDeudaCliente);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var consultaCuenta:WSDLOperation = new WSDLOperation("consultaCuenta");
				//input message for the operation
    	        requestMessage = new WSDLMessage("consultaCuenta");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codCuenta"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","consultaCuenta");
                
                responseMessage = new WSDLMessage("consultaCuentaResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoAbonadosDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","consultaCuentaResponse");
			consultaCuenta.inputMessage = requestMessage;
	        consultaCuenta.outputMessage = responseMessage;
            consultaCuenta.schemaManager = this.schemaMgr;
            consultaCuenta.soapAction = "urn:consultaCuenta";
            consultaCuenta.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(consultaCuenta);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var solicitaUrlDominioPuerto:WSDLOperation = new WSDLOperation("solicitaUrlDominioPuerto");
				//input message for the operation
    	        requestMessage = new WSDLMessage("solicitaUrlDominioPuerto");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","strCodOrdenServ"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","solicitaUrlDominioPuerto");
                
                responseMessage = new WSDLMessage("solicitaUrlDominioPuertoResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","MuestraURLDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","solicitaUrlDominioPuertoResponse");
			solicitaUrlDominioPuerto.inputMessage = requestMessage;
	        solicitaUrlDominioPuerto.outputMessage = responseMessage;
            solicitaUrlDominioPuerto.schemaManager = this.schemaMgr;
            solicitaUrlDominioPuerto.soapAction = "urn:solicitaUrlDominioPuerto";
            solicitaUrlDominioPuerto.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(solicitaUrlDominioPuerto);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var cargarAjusteCReversionCargos:WSDLOperation = new WSDLOperation("cargarAjusteCReversionCargos");
				//input message for the operation
    	        requestMessage = new WSDLMessage("cargarAjusteCReversionCargos");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codCliente"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","nomUsuarioSCL"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","pwd"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codEvento"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","cargarAjusteCReversionCargos");
                
                responseMessage = new WSDLMessage("cargarAjusteCReversionCargosResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.wsseguridad.scl.tmmas.com/xsd","CargaAjusteCReversionCargosSACDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","cargarAjusteCReversionCargosResponse");
			cargarAjusteCReversionCargos.inputMessage = requestMessage;
	        cargarAjusteCReversionCargos.outputMessage = responseMessage;
            cargarAjusteCReversionCargos.schemaManager = this.schemaMgr;
            cargarAjusteCReversionCargos.soapAction = "urn:cargarAjusteCReversionCargos";
            cargarAjusteCReversionCargos.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(cargarAjusteCReversionCargos);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var oossEjecutadasXNumAbonado:WSDLOperation = new WSDLOperation("oossEjecutadasXNumAbonado");
				//input message for the operation
    	        requestMessage = new WSDLMessage("oossEjecutadasXNumAbonado");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","numAbonado"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","nomUsuarioSCL"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codEvento"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","oossEjecutadasXNumAbonado");
                
                responseMessage = new WSDLMessage("oossEjecutadasXNumAbonadoResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoOrdenesServicioDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","oossEjecutadasXNumAbonadoResponse");
			oossEjecutadasXNumAbonado.inputMessage = requestMessage;
	        oossEjecutadasXNumAbonado.outputMessage = responseMessage;
            oossEjecutadasXNumAbonado.schemaManager = this.schemaMgr;
            oossEjecutadasXNumAbonado.soapAction = "urn:oossEjecutadasXNumAbonado";
            oossEjecutadasXNumAbonado.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(oossEjecutadasXNumAbonado);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var ssXDefectoXNumAbonado:WSDLOperation = new WSDLOperation("ssXDefectoXNumAbonado");
				//input message for the operation
    	        requestMessage = new WSDLMessage("ssXDefectoXNumAbonado");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","numAbonado"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","ssXDefectoXNumAbonado");
                
                responseMessage = new WSDLMessage("ssXDefectoXNumAbonadoResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoServSuplementariosDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","ssXDefectoXNumAbonadoResponse");
			ssXDefectoXNumAbonado.inputMessage = requestMessage;
	        ssXDefectoXNumAbonado.outputMessage = responseMessage;
            ssXDefectoXNumAbonado.schemaManager = this.schemaMgr;
            ssXDefectoXNumAbonado.soapAction = "urn:ssXDefectoXNumAbonado";
            ssXDefectoXNumAbonado.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(ssXDefectoXNumAbonado);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var ejecutarCambioEquipoGSM:WSDLOperation = new WSDLOperation("ejecutarCambioEquipoGSM");
				//input message for the operation
    	        requestMessage = new WSDLMessage("ejecutarCambioEquipoGSM");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","entrada"),null,new QName("http://dto.common.wsfranquicias.scl.tmmas.com/xsd","EjecucionCambioEquipoGSMDTO")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","ejecutarCambioEquipoGSM");
                
                responseMessage = new WSDLMessage("ejecutarCambioEquipoGSMResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsfranquicias.scl.tmmas.com/xsd","EjecucionCambioEquipoGSMDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","ejecutarCambioEquipoGSMResponse");
			ejecutarCambioEquipoGSM.inputMessage = requestMessage;
	        ejecutarCambioEquipoGSM.outputMessage = responseMessage;
            ejecutarCambioEquipoGSM.schemaManager = this.schemaMgr;
            ejecutarCambioEquipoGSM.soapAction = "urn:ejecutarCambioEquipoGSM";
            ejecutarCambioEquipoGSM.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(ejecutarCambioEquipoGSM);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var getDocsPagosCliente:WSDLOperation = new WSDLOperation("getDocsPagosCliente");
				//input message for the operation
    	        requestMessage = new WSDLMessage("getDocsPagosCliente");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","obj"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","GetDocsClienteINDTO")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","getDocsPagosCliente");
                
                responseMessage = new WSDLMessage("getDocsPagosClienteResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoDocCtaCteClienteDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","getDocsPagosClienteResponse");
			getDocsPagosCliente.inputMessage = requestMessage;
	        getDocsPagosCliente.outputMessage = responseMessage;
            getDocsPagosCliente.schemaManager = this.schemaMgr;
            getDocsPagosCliente.soapAction = "urn:getDocsPagosCliente";
            getDocsPagosCliente.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(getDocsPagosCliente);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var getDocsCtaCteCliente:WSDLOperation = new WSDLOperation("getDocsCtaCteCliente");
				//input message for the operation
    	        requestMessage = new WSDLMessage("getDocsCtaCteCliente");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","obj"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","GetDocsClienteINDTO")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","nomUsuarioSCL"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codEvento"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","getDocsCtaCteCliente");
                
                responseMessage = new WSDLMessage("getDocsCtaCteClienteResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoDocCtaCteClienteDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","getDocsCtaCteClienteResponse");
			getDocsCtaCteCliente.inputMessage = requestMessage;
	        getDocsCtaCteCliente.outputMessage = responseMessage;
            getDocsCtaCteCliente.schemaManager = this.schemaMgr;
            getDocsCtaCteCliente.soapAction = "urn:getDocsCtaCteCliente";
            getDocsCtaCteCliente.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(getDocsCtaCteCliente);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var cambiarDireccionCliente:WSDLOperation = new WSDLOperation("cambiarDireccionCliente");
				//input message for the operation
    	        requestMessage = new WSDLMessage("cambiarDireccionCliente");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","dto"),null,new QName("http://dto.wsseguridad.scl.tmmas.com/xsd","DireccionSACDTO")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","cambiarDireccionCliente");
                
                responseMessage = new WSDLMessage("cambiarDireccionClienteResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.wsseguridad.scl.tmmas.com/xsd","ConsultarOrdenServicioSACDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","cambiarDireccionClienteResponse");
			cambiarDireccionCliente.inputMessage = requestMessage;
	        cambiarDireccionCliente.outputMessage = responseMessage;
            cambiarDireccionCliente.schemaManager = this.schemaMgr;
            cambiarDireccionCliente.soapAction = "urn:cambiarDireccionCliente";
            cambiarDireccionCliente.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(cambiarDireccionCliente);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var ssXDefectoXCodCliente:WSDLOperation = new WSDLOperation("ssXDefectoXCodCliente");
				//input message for the operation
    	        requestMessage = new WSDLMessage("ssXDefectoXCodCliente");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codCliente"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","ssXDefectoXCodCliente");
                
                responseMessage = new WSDLMessage("ssXDefectoXCodClienteResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoServSuplementariosDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","ssXDefectoXCodClienteResponse");
			ssXDefectoXCodCliente.inputMessage = requestMessage;
	        ssXDefectoXCodCliente.outputMessage = responseMessage;
            ssXDefectoXCodCliente.schemaManager = this.schemaMgr;
            ssXDefectoXCodCliente.soapAction = "urn:ssXDefectoXCodCliente";
            ssXDefectoXCodCliente.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(ssXDefectoXCodCliente);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var servSuplXOOSS:WSDLOperation = new WSDLOperation("servSuplXOOSS");
				//input message for the operation
    	        requestMessage = new WSDLMessage("servSuplXOOSS");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","numOOSS"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","servSuplXOOSS");
                
                responseMessage = new WSDLMessage("servSuplXOOSSResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoServSuplxOOSSDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","servSuplXOOSSResponse");
			servSuplXOOSS.inputMessage = requestMessage;
	        servSuplXOOSS.outputMessage = responseMessage;
            servSuplXOOSS.schemaManager = this.schemaMgr;
            servSuplXOOSS.soapAction = "urn:servSuplXOOSS";
            servSuplXOOSS.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(servSuplXOOSS);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var limiteConsumoXClienteAbonado:WSDLOperation = new WSDLOperation("limiteConsumoXClienteAbonado");
				//input message for the operation
    	        requestMessage = new WSDLMessage("limiteConsumoXClienteAbonado");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codCliente"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","numAbonado"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","nomUsuarioSCL"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codEvento"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","limiteConsumoXClienteAbonado");
                
                responseMessage = new WSDLMessage("limiteConsumoXClienteAbonadoResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoLimiteConsumoDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","limiteConsumoXClienteAbonadoResponse");
			limiteConsumoXClienteAbonado.inputMessage = requestMessage;
	        limiteConsumoXClienteAbonado.outputMessage = responseMessage;
            limiteConsumoXClienteAbonado.schemaManager = this.schemaMgr;
            limiteConsumoXClienteAbonado.soapAction = "urn:limiteConsumoXClienteAbonado";
            limiteConsumoXClienteAbonado.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(limiteConsumoXClienteAbonado);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var cargaOSGenericaAbonado:WSDLOperation = new WSDLOperation("cargaOSGenericaAbonado");
				//input message for the operation
    	        requestMessage = new WSDLMessage("cargaOSGenericaAbonado");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","numAbonado"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","nomUsuarioSCL"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codEvento"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","cargaOSGenericaAbonado");
                
                responseMessage = new WSDLMessage("cargaOSGenericaAbonadoResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.wsseguridad.scl.tmmas.com/xsd","CargaOSGenericaDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","cargaOSGenericaAbonadoResponse");
			cargaOSGenericaAbonado.inputMessage = requestMessage;
	        cargaOSGenericaAbonado.outputMessage = responseMessage;
            cargaOSGenericaAbonado.schemaManager = this.schemaMgr;
            cargaOSGenericaAbonado.soapAction = "urn:cargaOSGenericaAbonado";
            cargaOSGenericaAbonado.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(cargaOSGenericaAbonado);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var obtenerParametroKiosco:WSDLOperation = new WSDLOperation("obtenerParametroKiosco");
				//input message for the operation
    	        requestMessage = new WSDLMessage("");
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="";
			requestMessage.encoding.useStyle="literal";
                
                responseMessage = new WSDLMessage("obtenerParametroKioscoResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ParametrosKioscoDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","obtenerParametroKioscoResponse");
			obtenerParametroKiosco.inputMessage = requestMessage;
	        obtenerParametroKiosco.outputMessage = responseMessage;
            obtenerParametroKiosco.schemaManager = this.schemaMgr;
            obtenerParametroKiosco.soapAction = "urn:obtenerParametroKiosco";
            obtenerParametroKiosco.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(obtenerParametroKiosco);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var cuentasXCodigo:WSDLOperation = new WSDLOperation("cuentasXCodigo");
				//input message for the operation
    	        requestMessage = new WSDLMessage("cuentasXCodigo");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codCuenta"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","cuentasXCodigo");
                
                responseMessage = new WSDLMessage("cuentasXCodigoResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoCuentasDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","cuentasXCodigoResponse");
			cuentasXCodigo.inputMessage = requestMessage;
	        cuentasXCodigo.outputMessage = responseMessage;
            cuentasXCodigo.schemaManager = this.schemaMgr;
            cuentasXCodigo.soapAction = "urn:cuentasXCodigo";
            cuentasXCodigo.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(cuentasXCodigo);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var clientesXNombre:WSDLOperation = new WSDLOperation("clientesXNombre");
				//input message for the operation
    	        requestMessage = new WSDLMessage("clientesXNombre");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","nombre"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","clientesXNombre");
                
                responseMessage = new WSDLMessage("clientesXNombreResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoClientesDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","clientesXNombreResponse");
			clientesXNombre.inputMessage = requestMessage;
	        clientesXNombre.outputMessage = responseMessage;
            clientesXNombre.schemaManager = this.schemaMgr;
            clientesXNombre.soapAction = "urn:clientesXNombre";
            clientesXNombre.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(clientesXNombre);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var cambiosPlanAbonadoPrepago:WSDLOperation = new WSDLOperation("cambiosPlanAbonadoPrepago");
				//input message for the operation
    	        requestMessage = new WSDLMessage("cambiosPlanAbonadoPrepago");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","numOS"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","cambiosPlanAbonadoPrepago");
                
                responseMessage = new WSDLMessage("cambiosPlanAbonadoPrepagoResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoCambiosPlanTarifDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","cambiosPlanAbonadoPrepagoResponse");
			cambiosPlanAbonadoPrepago.inputMessage = requestMessage;
	        cambiosPlanAbonadoPrepago.outputMessage = responseMessage;
            cambiosPlanAbonadoPrepago.schemaManager = this.schemaMgr;
            cambiosPlanAbonadoPrepago.soapAction = "urn:cambiosPlanAbonadoPrepago";
            cambiosPlanAbonadoPrepago.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(cambiosPlanAbonadoPrepago);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var getDetalleDireccion:WSDLOperation = new WSDLOperation("getDetalleDireccion");
				//input message for the operation
    	        requestMessage = new WSDLMessage("getDetalleDireccion");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codDireccion"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codTipDireccion"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","getDetalleDireccion");
                
                responseMessage = new WSDLMessage("getDetalleDireccionResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","DetalleDireccionDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","getDetalleDireccionResponse");
			getDetalleDireccion.inputMessage = requestMessage;
	        getDetalleDireccion.outputMessage = responseMessage;
            getDetalleDireccion.schemaManager = this.schemaMgr;
            getDetalleDireccion.soapAction = "urn:getDetalleDireccion";
            getDetalleDireccion.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(getDetalleDireccion);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var ejecutarAbonoLimiteConsumo:WSDLOperation = new WSDLOperation("ejecutarAbonoLimiteConsumo");
				//input message for the operation
    	        requestMessage = new WSDLMessage("ejecutarAbonoLimiteConsumo");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","entrada"),null,new QName("http://dto.common.wsfranquicias.scl.tmmas.com/xsd","EjecucionAbonoLimConDTO")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","ejecutarAbonoLimiteConsumo");
                
                responseMessage = new WSDLMessage("ejecutarAbonoLimiteConsumoResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsfranquicias.scl.tmmas.com/xsd","EjecucionAbonoLimConDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","ejecutarAbonoLimiteConsumoResponse");
			ejecutarAbonoLimiteConsumo.inputMessage = requestMessage;
	        ejecutarAbonoLimiteConsumo.outputMessage = responseMessage;
            ejecutarAbonoLimiteConsumo.schemaManager = this.schemaMgr;
            ejecutarAbonoLimiteConsumo.soapAction = "urn:ejecutarAbonoLimiteConsumo";
            ejecutarAbonoLimiteConsumo.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(ejecutarAbonoLimiteConsumo);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var clientesXCuenta:WSDLOperation = new WSDLOperation("clientesXCuenta");
				//input message for the operation
    	        requestMessage = new WSDLMessage("clientesXCuenta");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codCuenta"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","clientesXCuenta");
                
                responseMessage = new WSDLMessage("clientesXCuentaResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoClientesDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","clientesXCuentaResponse");
			clientesXCuenta.inputMessage = requestMessage;
	        clientesXCuenta.outputMessage = responseMessage;
            clientesXCuenta.schemaManager = this.schemaMgr;
            clientesXCuenta.soapAction = "urn:clientesXCuenta";
            clientesXCuenta.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(clientesXCuenta);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var ejecutarAnulacionSiniestro:WSDLOperation = new WSDLOperation("ejecutarAnulacionSiniestro");
				//input message for the operation
    	        requestMessage = new WSDLMessage("ejecutarAnulacionSiniestro");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","entrada"),null,new QName("http://dto.common.wsfranquicias.scl.tmmas.com/xsd","EjecucionAnulacionSiniestroDTO")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","ejecutarAnulacionSiniestro");
                
                responseMessage = new WSDLMessage("ejecutarAnulacionSiniestroResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsfranquicias.scl.tmmas.com/xsd","EjecucionAnulacionSiniestroDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","ejecutarAnulacionSiniestroResponse");
			ejecutarAnulacionSiniestro.inputMessage = requestMessage;
	        ejecutarAnulacionSiniestro.outputMessage = responseMessage;
            ejecutarAnulacionSiniestro.schemaManager = this.schemaMgr;
            ejecutarAnulacionSiniestro.soapAction = "urn:ejecutarAnulacionSiniestro";
            ejecutarAnulacionSiniestro.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(ejecutarAnulacionSiniestro);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var ejecutarAjusteCReversionCargos:WSDLOperation = new WSDLOperation("ejecutarAjusteCReversionCargos");
				//input message for the operation
    	        requestMessage = new WSDLMessage("ejecutarAjusteCReversionCargos");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","entrada"),null,new QName("http://dto.wsseguridad.scl.tmmas.com/xsd","EjecucionAjusteCReversionCargosSACDTO")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","ejecutarAjusteCReversionCargos");
                
                responseMessage = new WSDLMessage("ejecutarAjusteCReversionCargosResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsfranquicias.scl.tmmas.com/xsd","EjecucionAjusteCReversionCargosDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","ejecutarAjusteCReversionCargosResponse");
			ejecutarAjusteCReversionCargos.inputMessage = requestMessage;
	        ejecutarAjusteCReversionCargos.outputMessage = responseMessage;
            ejecutarAjusteCReversionCargos.schemaManager = this.schemaMgr;
            ejecutarAjusteCReversionCargos.soapAction = "urn:ejecutarAjusteCReversionCargos";
            ejecutarAjusteCReversionCargos.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(ejecutarAjusteCReversionCargos);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var numerosFrecuentesXPlan:WSDLOperation = new WSDLOperation("numerosFrecuentesXPlan");
				//input message for the operation
    	        requestMessage = new WSDLMessage("numerosFrecuentesXPlan");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","numAbonado"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","numerosFrecuentesXPlan");
                
                responseMessage = new WSDLMessage("numerosFrecuentesXPlanResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoNumerosFrecuentesDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","numerosFrecuentesXPlanResponse");
			numerosFrecuentesXPlan.inputMessage = requestMessage;
	        numerosFrecuentesXPlan.outputMessage = responseMessage;
            numerosFrecuentesXPlan.schemaManager = this.schemaMgr;
            numerosFrecuentesXPlan.soapAction = "urn:numerosFrecuentesXPlan";
            numerosFrecuentesXPlan.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(numerosFrecuentesXPlan);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var obtenerOoSsAgendadas:WSDLOperation = new WSDLOperation("obtenerOoSsAgendadas");
				//input message for the operation
    	        requestMessage = new WSDLMessage("obtenerOoSsAgendadas");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","numDato"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","tipoDato"),null,new QName("http://www.w3.org/2001/XMLSchema","int")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","obtenerOoSsAgendadas");
                
                responseMessage = new WSDLMessage("obtenerOoSsAgendadasResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoOrdenesAgendadasDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","obtenerOoSsAgendadasResponse");
			obtenerOoSsAgendadas.inputMessage = requestMessage;
	        obtenerOoSsAgendadas.outputMessage = responseMessage;
            obtenerOoSsAgendadas.schemaManager = this.schemaMgr;
            obtenerOoSsAgendadas.soapAction = "urn:obtenerOoSsAgendadas";
            obtenerOoSsAgendadas.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(obtenerOoSsAgendadas);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var ccXCodCliente:WSDLOperation = new WSDLOperation("ccXCodCliente");
				//input message for the operation
    	        requestMessage = new WSDLMessage("ccXCodCliente");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codCliente"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","nomUsuarioSCL"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codEvento"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","ccXCodCliente");
                
                responseMessage = new WSDLMessage("ccXCodClienteResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoCuentasCorrientesDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","ccXCodClienteResponse");
			ccXCodCliente.inputMessage = requestMessage;
	        ccXCodCliente.outputMessage = responseMessage;
            ccXCodCliente.schemaManager = this.schemaMgr;
            ccXCodCliente.soapAction = "urn:ccXCodCliente";
            ccXCodCliente.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(ccXCodCliente);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var abonadosXCliente:WSDLOperation = new WSDLOperation("abonadosXCliente");
				//input message for the operation
    	        requestMessage = new WSDLMessage("abonadosXCliente");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","codCliente"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","abonadosXCliente");
                
                responseMessage = new WSDLMessage("abonadosXClienteResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoAbonadosDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","abonadosXClienteResponse");
			abonadosXCliente.inputMessage = requestMessage;
	        abonadosXCliente.outputMessage = responseMessage;
            abonadosXCliente.schemaManager = this.schemaMgr;
            abonadosXCliente.soapAction = "urn:abonadosXCliente";
            abonadosXCliente.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(abonadosXCliente);
			//define the WSDLOperation: new WSDLOperation(methodName)
            var insertComentario:WSDLOperation = new WSDLOperation("insertComentario");
				//input message for the operation
    	        requestMessage = new WSDLMessage("insertComentario");
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","comentario"),null,new QName("http://www.w3.org/2001/XMLSchema","string")));
            				requestMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","numOoss"),null,new QName("http://www.w3.org/2001/XMLSchema","long")));
                requestMessage.encoding = new WSDLEncoding();
                requestMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
			requestMessage.encoding.useStyle="literal";
	            requestMessage.isWrapped = true;
	            requestMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","insertComentario");
                
                responseMessage = new WSDLMessage("insertComentarioResponse");
            				responseMessage.addPart(new WSDLMessagePart(new QName("http://wsservices.wsseguridad.scl.tmmas.com","return"),null,new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ResulTransaccionDTO")));
                responseMessage.encoding = new WSDLEncoding();
                responseMessage.encoding.namespaceURI="http://wsservices.wsseguridad.scl.tmmas.com";
                responseMessage.encoding.useStyle="literal";				
				
	            responseMessage.isWrapped = true;
	            responseMessage.wrappedQName = new QName("http://wsservices.wsseguridad.scl.tmmas.com","insertComentarioResponse");
			insertComentario.inputMessage = requestMessage;
	        insertComentario.outputMessage = responseMessage;
            insertComentario.schemaManager = this.schemaMgr;
            insertComentario.soapAction = "urn:insertComentario";
            insertComentario.style = "document";
            BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.addOperation(insertComentario);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsfranquicias.scl.tmmas.com/xsd","CargaCambioPlanPostPagoIndividualDTO"),generated.webservices.orquestador.CargaCambioPlanPostPagoIndividualDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://firma.vo.common.wsfranquicias.scl.tmmas.com/xsd","NotaDebitoVO"),generated.webservices.orquestador.NotaDebitoVO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.wsseguridad.scl.tmmas.com/xsd","EjecucionAjusteCExcepcionCargosSACDTO"),generated.webservices.orquestador.EjecucionAjusteCExcepcionCargosSACDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://wsservices.wsseguridad.scl.tmmas.com","Exception"),generated.webservices.orquestador.Exception);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","LimiteConsumoDTO"),generated.webservices.orquestador.LimiteConsumoDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoLimiteConsumoDTO"),generated.webservices.orquestador.ListadoLimiteConsumoDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.wsseguridad.scl.tmmas.com/xsd","CargaAjusteCExcepcionCargosSACDTO"),generated.webservices.orquestador.CargaAjusteCExcepcionCargosSACDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://firma.vo.common.wsfranquicias.scl.tmmas.com/xsd","NumeroFrecuenteFijoVO"),generated.webservices.orquestador.NumeroFrecuenteFijoVO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoGruposDTO"),generated.webservices.orquestador.ListadoGruposDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","PagoLimiteConsumoDTO"),generated.webservices.orquestador.PagoLimiteConsumoDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ServSuplementarioDTO"),generated.webservices.orquestador.ServSuplementarioDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://firma.vo.common.wsfranquicias.scl.tmmas.com/xsd","TiposTerminalesVO"),generated.webservices.orquestador.TiposTerminalesVO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","MuestraURLDTO"),generated.webservices.orquestador.MuestraURLDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsfranquicias.scl.tmmas.com/xsd","OOSSDTO"),generated.webservices.orquestador.OOSSDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","PagoDTO"),generated.webservices.orquestador.PagoDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://firma.bancarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd","SistemaPagoVO"),generated.webservices.orquestador.SistemaPagoVO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","DetalleLlamadaDTO"),generated.webservices.orquestador.DetalleLlamadaDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsfranquicias.scl.tmmas.com/xsd","CargaCambioSIMCardDTO"),generated.webservices.orquestador.CargaCambioSIMCardDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsfranquicias.scl.tmmas.com/xsd","EjecucionSuspensionSrvCelDTO"),generated.webservices.orquestador.EjecucionSuspensionSrvCelDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://firma.generales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd","PaisVO"),generated.webservices.orquestador.PaisVO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","OOSSXAbonadoDTO"),generated.webservices.orquestador.OOSSXAbonadoDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsfranquicias.scl.tmmas.com/xsd","CargaAbonoLimConDTO"),generated.webservices.orquestador.CargaAbonoLimConDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoNumerosFrecuentesDTO"),generated.webservices.orquestador.ListadoNumerosFrecuentesDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://firma.vo.common.wsfranquicias.scl.tmmas.com/xsd","DetalleAjusteVO"),generated.webservices.orquestador.DetalleAjusteVO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoClientesDTO"),generated.webservices.orquestador.ListadoClientesDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","CambioPlanTarifDTO"),generated.webservices.orquestador.CambioPlanTarifDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://firma.personales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd","TipoIdentificacionVO"),generated.webservices.orquestador.TipoIdentificacionVO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://firma.vo.common.wsfranquicias.scl.tmmas.com/xsd","CargosVO"),generated.webservices.orquestador.CargosVO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://firma.vo.common.wsfranquicias.scl.tmmas.com/xsd","OrigenPagoVO"),generated.webservices.orquestador.OrigenPagoVO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoOrdenesProcesoDTO"),generated.webservices.orquestador.ListadoOrdenesProcesoDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoConsultasDTO"),generated.webservices.orquestador.ListadoConsultasDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListaCausalCambioDTO"),generated.webservices.orquestador.ListaCausalCambioDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","EquipoSimcardDetalleDTO"),generated.webservices.orquestador.EquipoSimcardDetalleDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","DeudaClienteDTO"),generated.webservices.orquestador.DeudaClienteDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ResulTransaccionDTO"),generated.webservices.orquestador.ResulTransaccionDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsfranquicias.scl.tmmas.com/xsd","EjecucionCambioEquipoGSMDTO"),generated.webservices.orquestador.EjecucionCambioEquipoGSMDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ReporteCamEquiGenDTO"),generated.webservices.orquestador.ReporteCamEquiGenDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoDireccionesDTO"),generated.webservices.orquestador.ListadoDireccionesDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.wsseguridad.scl.tmmas.com/xsd","CargaAjusteCReversionCargosSACDTO"),generated.webservices.orquestador.CargaAjusteCReversionCargosSACDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","DireccionDTO"),generated.webservices.orquestador.DireccionDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoServSuplementariosDTO"),generated.webservices.orquestador.ListadoServSuplementariosDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://exception.common.wsportal.scl.tmmas.com/xsd","PortalSACException"),generated.webservices.orquestador.PortalSACException);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.wsseguridad.scl.tmmas.com/xsd","CargaOSGenericaDTO"),generated.webservices.orquestador.CargaOSGenericaDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.wsseguridad.scl.tmmas.com/xsd","ListadoOrdenesServicioSACDTO"),generated.webservices.orquestador.ListadoOrdenesServicioSACDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoCamposDireccionDTO"),generated.webservices.orquestador.ListadoCamposDireccionDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://bancarios.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd","CargaCambioDatosBancariosDTO"),generated.webservices.orquestador.CargaCambioDatosBancariosDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.wsseguridad.scl.tmmas.com/xsd","DetalleDocumentoSACVO"),generated.webservices.orquestador.DetalleDocumentoSACVO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsfranquicias.scl.tmmas.com/xsd","EjecucionAnulacionSiniestroDTO"),generated.webservices.orquestador.EjecucionAnulacionSiniestroDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.wsseguridad.scl.tmmas.com/xsd","FoliosFacturasSACVO"),generated.webservices.orquestador.FoliosFacturasSACVO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","FacturaDTO"),generated.webservices.orquestador.FacturaDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.wsseguridad.scl.tmmas.com/xsd","EjecucionCambioNumFrecuentesSACDTO"),generated.webservices.orquestador.EjecucionCambioNumFrecuentesSACDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://firma.personales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd","TipoIdiomaVO"),generated.webservices.orquestador.TipoIdiomaVO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsfranquicias.scl.tmmas.com/xsd","EjecucionServicioCargosDTO"),generated.webservices.orquestador.EjecucionServicioCargosDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","DetalleDireccionDTO"),generated.webservices.orquestador.DetalleDireccionDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","OOSSXClienteDTO"),generated.webservices.orquestador.OOSSXClienteDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://firma.bancarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd","SucursalVO"),generated.webservices.orquestador.SucursalVO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://generales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd","EjecucionCambioDatosGeneralesClienteDTO"),generated.webservices.orquestador.EjecucionCambioDatosGeneralesClienteDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","DatosDireccionClienteINDTO"),generated.webservices.orquestador.DatosDireccionClienteINDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.wsseguridad.scl.tmmas.com/xsd","DireccionSACDTO"),generated.webservices.orquestador.DireccionSACDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ServSuplXOOSSDTO"),generated.webservices.orquestador.ServSuplXOOSSDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsfranquicias.scl.tmmas.com/xsd","CargaServicioCargosDTO"),generated.webservices.orquestador.CargaServicioCargosDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.wsseguridad.scl.tmmas.com/xsd","CargaCambioDatosClienteSACDTO"),generated.webservices.orquestador.CargaCambioDatosClienteSACDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoDetalleLlamadosDTO"),generated.webservices.orquestador.ListadoDetalleLlamadosDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","NumeroFrecuenteDTO"),generated.webservices.orquestador.NumeroFrecuenteDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsfranquicias.scl.tmmas.com/xsd","CargaCambioEquipoGSMDTO"),generated.webservices.orquestador.CargaCambioEquipoGSMDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsfranquicias.scl.tmmas.com/xsd","EjecucionReposicionSrvCelDTO"),generated.webservices.orquestador.EjecucionReposicionSrvCelDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","DetalleClienteDTO"),generated.webservices.orquestador.DetalleClienteDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://firma.bancarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd","TiposTarjetaVO"),generated.webservices.orquestador.TiposTarjetaVO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://firma.personales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd","TipoInformacionPersonalVO"),generated.webservices.orquestador.TipoInformacionPersonalVO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ParametrosKioscoDTO"),generated.webservices.orquestador.ParametrosKioscoDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://personales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd","CargaCambioDatosPersonalesClienteDTO"),generated.webservices.orquestador.CargaCambioDatosPersonalesClienteDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://firma.vo.common.wsfranquicias.scl.tmmas.com/xsd","CausasPagoVO"),generated.webservices.orquestador.CausasPagoVO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.wsseguridad.scl.tmmas.com/xsd","DetalleAjusteSACVO"),generated.webservices.orquestador.DetalleAjusteSACVO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","CausalCambioDTO"),generated.webservices.orquestador.CausalCambioDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoPagosDTO"),generated.webservices.orquestador.ListadoPagosDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsfranquicias.scl.tmmas.com/xsd","EjecucionCambioPlanPostPagoIndividualDTO"),generated.webservices.orquestador.EjecucionCambioPlanPostPagoIndividualDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://firma.vo.common.wsfranquicias.scl.tmmas.com/xsd","AbonoLimiteConsumoServicioSuplementarioVO"),generated.webservices.orquestador.AbonoLimiteConsumoServicioSuplementarioVO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","MenuDTO"),generated.webservices.orquestador.MenuDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoAbonadosDTO"),generated.webservices.orquestador.ListadoAbonadosDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","GetDocsClienteINDTO"),generated.webservices.orquestador.GetDocsClienteINDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://firma.generales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd","ActividadVO"),generated.webservices.orquestador.ActividadVO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://firma.tributarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd","CategoriaImpositivaVO"),generated.webservices.orquestador.CategoriaImpositivaVO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","OOSSAgendadaDTO"),generated.webservices.orquestador.OOSSAgendadaDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://firma.vo.common.wsfranquicias.scl.tmmas.com/xsd","BloqueArticulosVO"),generated.webservices.orquestador.BloqueArticulosVO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.wsseguridad.scl.tmmas.com/xsd","FiltroDetDocAjusteCCargosSACDTO"),generated.webservices.orquestador.FiltroDetDocAjusteCCargosSACDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://bancarios.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd","EjecucionCambioDatosBancariosDTO"),generated.webservices.orquestador.EjecucionCambioDatosBancariosDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","DireccionPorClienteDTO"),generated.webservices.orquestador.DireccionPorClienteDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoOrdenesAgendadasDTO"),generated.webservices.orquestador.ListadoOrdenesAgendadasDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoBeneficiosDTO"),generated.webservices.orquestador.ListadoBeneficiosDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ReporteIngrStatusEquiDTO"),generated.webservices.orquestador.ReporteIngrStatusEquiDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsfranquicias.scl.tmmas.com/xsd","EjecucionCambioSIMCardDTO"),generated.webservices.orquestador.EjecucionCambioSIMCardDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","AtencionClienteDTO"),generated.webservices.orquestador.AtencionClienteDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.wsseguridad.scl.tmmas.com/xsd","CargaCambioNumFrecuentesSACDTO"),generated.webservices.orquestador.CargaCambioNumFrecuentesSACDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://firma.cambionumerosfrecuentes.vo.common.wsfranquicias.scl.tmmas.com/xsd","NumFrecuentesFirmaVO"),generated.webservices.orquestador.NumFrecuentesFirmaVO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsfranquicias.scl.tmmas.com/xsd","CargaReposicionSrvCelDTO"),generated.webservices.orquestador.CargaReposicionSrvCelDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://firma.vo.common.wsfranquicias.scl.tmmas.com/xsd","PlanTarifarioVO"),generated.webservices.orquestador.PlanTarifarioVO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","OOSSEjecutadaDTO"),generated.webservices.orquestador.OOSSEjecutadaDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://firma.vo.common.wsfranquicias.scl.tmmas.com/xsd","NotaCreditoVO"),generated.webservices.orquestador.NotaCreditoVO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","BeneficioDTO"),generated.webservices.orquestador.BeneficioDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","DetalleAbonadoDTO"),generated.webservices.orquestador.DetalleAbonadoDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","GrupoDTO"),generated.webservices.orquestador.GrupoDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoOrdenesServicioDTO"),generated.webservices.orquestador.ListadoOrdenesServicioDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","DetalleCuentaDTO"),generated.webservices.orquestador.DetalleCuentaDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","CuentaCorrienteDTO"),generated.webservices.orquestador.CuentaCorrienteDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoAjustesDTO"),generated.webservices.orquestador.ListadoAjustesDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","UmtsAbonadoDTO"),generated.webservices.orquestador.UmtsAbonadoDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://firma.generales.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd","OficinaVO"),generated.webservices.orquestador.OficinaVO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://firma.vo.common.wsfranquicias.scl.tmmas.com/xsd","SiniestrosVO"),generated.webservices.orquestador.SiniestrosVO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoPagosLimiteConsumoDTO"),generated.webservices.orquestador.ListadoPagosLimiteConsumoDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsfranquicias.scl.tmmas.com/xsd","EjecucionAbonoLimiteConsumoServicioSuplementarioDTO"),generated.webservices.orquestador.EjecucionAbonoLimiteConsumoServicioSuplementarioDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoReportePresEquiIntDTO"),generated.webservices.orquestador.ListadoReportePresEquiIntDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","CampoDireccionDTO"),generated.webservices.orquestador.CampoDireccionDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoReporteCamEquiGenDTO"),generated.webservices.orquestador.ListadoReporteCamEquiGenDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoReporteIngrStatusEquiDTO"),generated.webservices.orquestador.ListadoReporteIngrStatusEquiDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoCuentasDTO"),generated.webservices.orquestador.ListadoCuentasDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://personales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd","EjecucionCambioDatosPersonalesClienteDTO"),generated.webservices.orquestador.EjecucionCambioDatosPersonalesClienteDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://firma.vo.common.wsfranquicias.scl.tmmas.com/xsd","CausasCambioVO"),generated.webservices.orquestador.CausasCambioVO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoProductosDTO"),generated.webservices.orquestador.ListadoProductosDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ProductoDTO"),generated.webservices.orquestador.ProductoDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","DocCtaCteClienteDTO"),generated.webservices.orquestador.DocCtaCteClienteDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://firma.vo.common.wsfranquicias.scl.tmmas.com/xsd","BloqueSuspensionesActivasVO"),generated.webservices.orquestador.BloqueSuspensionesActivasVO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsfranquicias.scl.tmmas.com/xsd","EjecucionAjusteCReversionCargosDTO"),generated.webservices.orquestador.EjecucionAjusteCReversionCargosDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://firma.vo.common.wsfranquicias.scl.tmmas.com/xsd","ServicioSuspensionVO"),generated.webservices.orquestador.ServicioSuspensionVO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://firma.bancarios.cambiodatoscliente.vo.common.wsfranquicias.scl.tmmas.com/xsd","BancosVO"),generated.webservices.orquestador.BancosVO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.wsseguridad.scl.tmmas.com/xsd","ListadoDireccionesSACDTO"),generated.webservices.orquestador.ListadoDireccionesSACDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","CuentaDTO"),generated.webservices.orquestador.CuentaDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","OOSSXUsuarioDTO"),generated.webservices.orquestador.OOSSXUsuarioDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://firma.vo.common.wsfranquicias.scl.tmmas.com/xsd","CausasSuspensionVO"),generated.webservices.orquestador.CausasSuspensionVO);
							SchemaTypeRegistry.getInstance().registerCollectionClass(new QName("http://tributario.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd","CargaCambioDatosTributariosClienteDTO"),generated.webservices.orquestador.CargaCambioDatosTributariosClienteDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://vo.common.wsfranquicias.scl.tmmas.com/xsd","ComunesAjusteCExcepcionCargosVO"),generated.webservices.orquestador.ComunesAjusteCExcepcionCargosVO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://firma.vo.common.wsfranquicias.scl.tmmas.com/xsd","NumeroFrecuenteMovilVO"),generated.webservices.orquestador.NumeroFrecuenteMovilVO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsfranquicias.scl.tmmas.com/xsd","CargaAnulacionSiniestroDTO"),generated.webservices.orquestador.CargaAnulacionSiniestroDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ConsultaDTO"),generated.webservices.orquestador.ConsultaDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.wsseguridad.scl.tmmas.com/xsd","ConsultarOrdenServicioSACDTO"),generated.webservices.orquestador.ConsultarOrdenServicioSACDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsfranquicias.scl.tmmas.com/xsd","CargaAbonoLimiteConsumoServicioSuplementarioDTO"),generated.webservices.orquestador.CargaAbonoLimiteConsumoServicioSuplementarioDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoDocCtaCteClienteDTO"),generated.webservices.orquestador.ListadoDocCtaCteClienteDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://numeroIdentificacion.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd","EjecucionCambioDatosIdentificacionClienteDTO"),generated.webservices.orquestador.EjecucionCambioDatosIdentificacionClienteDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoCuentasCorrientesDTO"),generated.webservices.orquestador.ListadoCuentasCorrientesDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoUmtsAbonadosDTO"),generated.webservices.orquestador.ListadoUmtsAbonadosDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://tributario.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd","EjecucionCambioDatosTributariosClienteDTO"),generated.webservices.orquestador.EjecucionCambioDatosTributariosClienteDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.wsseguridad.scl.tmmas.com/xsd","RealizarBloqueoRoboSACOUTDTO"),generated.webservices.orquestador.RealizarBloqueoRoboSACOUTDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://firma.cambionumerosfrecuentes.vo.common.wsfranquicias.scl.tmmas.com/xsd","TipoNumFrecuenteFirmaVO"),generated.webservices.orquestador.TipoNumFrecuenteFirmaVO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsfranquicias.scl.tmmas.com/xsd","EjecucionAbonoLimConDTO"),generated.webservices.orquestador.EjecucionAbonoLimConDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ValorCampoDireccionDTO"),generated.webservices.orquestador.ValorCampoDireccionDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://firma.vo.common.wsfranquicias.scl.tmmas.com/xsd","BloqueUsosVO"),generated.webservices.orquestador.BloqueUsosVO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://firma.vo.common.wsfranquicias.scl.tmmas.com/xsd","TiposContratosVO"),generated.webservices.orquestador.TiposContratosVO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","AjusteDTO"),generated.webservices.orquestador.AjusteDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsfranquicias.scl.tmmas.com/xsd","CargaSuspensionSrvCelDTO"),generated.webservices.orquestador.CargaSuspensionSrvCelDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","AbonadoDTO"),generated.webservices.orquestador.AbonadoDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListaAtencionClienteDTO"),generated.webservices.orquestador.ListaAtencionClienteDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.wsseguridad.scl.tmmas.com/xsd","RealizarBloqueoRoboSACINDTO"),generated.webservices.orquestador.RealizarBloqueoRoboSACINDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","OOSSProcesoDTO"),generated.webservices.orquestador.OOSSProcesoDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ResgistroAtencionDTO"),generated.webservices.orquestador.ResgistroAtencionDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoServSuplxOOSSDTO"),generated.webservices.orquestador.ListadoServSuplxOOSSDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","DetallePlanTarifarioDTO"),generated.webservices.orquestador.DetallePlanTarifarioDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsfranquicias.scl.tmmas.com/xsd","EjecucionAjusteCExcepcionCargosDTO"),generated.webservices.orquestador.EjecucionAjusteCExcepcionCargosDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.wsseguridad.scl.tmmas.com/xsd","EjecucionAjusteCReversionCargosSACDTO"),generated.webservices.orquestador.EjecucionAjusteCReversionCargosSACDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://generales.cambiodatoscliente.dto.common.wsfranquicias.scl.tmmas.com/xsd","CargaCambioDatosGeneralesClienteDTO"),generated.webservices.orquestador.CargaCambioDatosGeneralesClienteDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ClienteDTO"),generated.webservices.orquestador.ClienteDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoCambiosPlanTarifDTO"),generated.webservices.orquestador.ListadoCambiosPlanTarifDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ListadoFacturasDTO"),generated.webservices.orquestador.ListadoFacturasDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://exception.framework.cl.tmmas.com/xsd","GeneralException"),generated.webservices.orquestador.GeneralException);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.wsseguridad.scl.tmmas.com/xsd","EjecucionCambioDatosClienteSACDTO"),generated.webservices.orquestador.EjecucionCambioDatosClienteSACDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","OOSSXCuentaDTO"),generated.webservices.orquestador.OOSSXCuentaDTO);
							SchemaTypeRegistry.getInstance().registerClass(new QName("http://dto.common.wsportal.scl.tmmas.com/xsd","ReportePresEquiIntDTO"),generated.webservices.orquestador.ReportePresEquiIntDTO);
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param numAbonado* @param nomUsuarioSCL* @param codEvento
		 * @return Asynchronous token
		 */
		public function cargarReposicionSrvCelular(numAbonado:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["numAbonado"] = numAbonado;
	            out["nomUsuarioSCL"] = nomUsuarioSCL;
	            out["codEvento"] = codEvento;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("cargarReposicionSrvCelular");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param descCuenta
		 * @return Asynchronous token
		 */
		public function cuentasXNombre(descCuenta:String):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["descCuenta"] = descCuenta;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("cuentasXNombre");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param obj
		 * @return Asynchronous token
		 */
		public function getDocsFactCliente(obj:GetDocsClienteINDTO):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["obj"] = obj;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("getDocsFactCliente");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param numCelular
		 * @return Asynchronous token
		 */
		public function abonadosXCelular(numCelular:Number):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["numCelular"] = numCelular;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("abonadosXCelular");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param entrada
		 * @return Asynchronous token
		 */
		public function ejecutarCambioPlanPostPagoIndividual(entrada:EjecucionCambioPlanPostPagoIndividualDTO):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["entrada"] = entrada;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("ejecutarCambioPlanPostPagoIndividual");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 
		 * @return Asynchronous token
		 */
		public function obtenerCamposDireccion():AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("obtenerCamposDireccion");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param codCliente* @param nomUsuarioSCL* @param codEvento
		 * @return Asynchronous token
		 */
		public function cargaCambioDatosCliente(codCliente:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["codCliente"] = codCliente;
	            out["nomUsuarioSCL"] = nomUsuarioSCL;
	            out["codEvento"] = codEvento;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("cargaCambioDatosCliente");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param codSujeto* @param tipoAbono* @param nomUsuarioSCL* @param codEvento
		 * @return Asynchronous token
		 */
		public function cargarAbonoLimiteConsumo(codSujeto:Number,tipoAbono:String,nomUsuarioSCL:String,codEvento:String):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["codSujeto"] = codSujeto;
	            out["tipoAbono"] = tipoAbono;
	            out["nomUsuarioSCL"] = nomUsuarioSCL;
	            out["codEvento"] = codEvento;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("cargarAbonoLimiteConsumo");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param entrada
		 * @return Asynchronous token
		 */
		public function ejecutarReposicionSrvCelular(entrada:EjecucionReposicionSrvCelDTO):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["entrada"] = entrada;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("ejecutarReposicionSrvCelular");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param obj
		 * @return Asynchronous token
		 */
		public function getDocsAjustesCliente(obj:GetDocsClienteINDTO):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["obj"] = obj;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("getDocsAjustesCliente");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param numAbonado* @param nomUsuarioSCL* @param codEvento
		 * @return Asynchronous token
		 */
		public function cargarCambioPlanPostPagoIndividual(numAbonado:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["numAbonado"] = numAbonado;
	            out["nomUsuarioSCL"] = nomUsuarioSCL;
	            out["codEvento"] = codEvento;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("cargarCambioPlanPostPagoIndividual");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param fechaDesde* @param fechaHasta
		 * @return Asynchronous token
		 */
		public function obtenerReporteIngrStatusEqui(fechaDesde:String,fechaHasta:String):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["fechaDesde"] = fechaDesde;
	            out["fechaHasta"] = fechaHasta;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("obtenerReporteIngrStatusEqui");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param numAbonado* @param nomUsuarioSCL* @param codEvento
		 * @return Asynchronous token
		 */
		public function servSumplemetariosXAbonado(numAbonado:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["numAbonado"] = numAbonado;
	            out["nomUsuarioSCL"] = nomUsuarioSCL;
	            out["codEvento"] = codEvento;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("servSumplemetariosXAbonado");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param entrada
		 * @return Asynchronous token
		 */
		public function filtrarDetDocAjusteCReversionCargos(entrada:FiltroDetDocAjusteCCargosSACDTO):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["entrada"] = entrada;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("filtrarDetDocAjusteCReversionCargos");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param codCuenta* @param nomUsuarioSCL* @param codEvento
		 * @return Asynchronous token
		 */
		public function getDetalleCuenta(codCuenta:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["codCuenta"] = codCuenta;
	            out["nomUsuarioSCL"] = nomUsuarioSCL;
	            out["codEvento"] = codEvento;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("getDetalleCuenta");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param entrada
		 * @return Asynchronous token
		 */
		public function filtrarDetDocAjusteCExcepcionCargos(entrada:FiltroDetDocAjusteCCargosSACDTO):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["entrada"] = entrada;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("filtrarDetDocAjusteCExcepcionCargos");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param codPlanTarifario
		 * @return Asynchronous token
		 */
		public function detallePlanTarifario(codPlanTarifario:String):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["codPlanTarifario"] = codPlanTarifario;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("detallePlanTarifario");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param numAbonado* @param nomUsuarioSCL* @param codEvento
		 * @return Asynchronous token
		 */
		public function cargarCambioEquipoGSM(numAbonado:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["numAbonado"] = numAbonado;
	            out["nomUsuarioSCL"] = nomUsuarioSCL;
	            out["codEvento"] = codEvento;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("cargarCambioEquipoGSM");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param entrada
		 * @return Asynchronous token
		 */
		public function ejecucionServicioCargos(entrada:EjecucionServicioCargosDTO):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["entrada"] = entrada;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("ejecucionServicioCargos");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param nomUsuario
		 * @return Asynchronous token
		 */
		public function gruposXNomUsuario(nomUsuario:String):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["nomUsuario"] = nomUsuario;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("gruposXNomUsuario");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param numAbonado* @param nomUsuarioSCL* @param codEvento
		 * @return Asynchronous token
		 */
		public function cargarAnulacionSiniestro(numAbonado:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["numAbonado"] = numAbonado;
	            out["nomUsuarioSCL"] = nomUsuarioSCL;
	            out["codEvento"] = codEvento;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("cargarAnulacionSiniestro");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param entrada
		 * @return Asynchronous token
		 */
		public function ejecutarCambioSIMCard(entrada:EjecucionCambioSIMCardDTO):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["entrada"] = entrada;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("ejecutarCambioSIMCard");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param codCliente* @param numAbonado* @param codCiclo* @param tipoLlamada
		 * @return Asynchronous token
		 */
		public function detalleLlamadas(codCliente:Number,numAbonado:Number,codCiclo:Number,tipoLlamada:String):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["codCliente"] = codCliente;
	            out["numAbonado"] = numAbonado;
	            out["codCiclo"] = codCiclo;
	            out["tipoLlamada"] = tipoLlamada;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("detalleLlamadas");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param nomUsuario
		 * @return Asynchronous token
		 */
		public function esPrimerLogin(nomUsuario:String):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["nomUsuario"] = nomUsuario;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("esPrimerLogin");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param numAbonado* @param nomUsuarioSCL* @param codEvento
		 * @return Asynchronous token
		 */
		public function cargaNumFrecuentes(numAbonado:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["numAbonado"] = numAbonado;
	            out["nomUsuarioSCL"] = nomUsuarioSCL;
	            out["codEvento"] = codEvento;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("cargaNumFrecuentes");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param codCliente
		 * @return Asynchronous token
		 */
		public function clientesXCodCliente(codCliente:Number):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["codCliente"] = codCliente;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("clientesXCodCliente");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param nomUsuario
		 * @return Asynchronous token
		 */
		public function obtenerOoSsProceso(nomUsuario:String):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["nomUsuario"] = nomUsuario;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("obtenerOoSsProceso");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param codCliente
		 * @return Asynchronous token
		 */
		public function ajustesXCodCliente(codCliente:Number):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["codCliente"] = codCliente;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("ajustesXCodCliente");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param numOS
		 * @return Asynchronous token
		 */
		public function cambiosPlanAbonadoPospago(numOS:Number):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["numOS"] = numOS;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("cambiosPlanAbonadoPospago");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param nomUsuario
		 * @return Asynchronous token
		 */
		public function consultaOoSsProceso(nomUsuario:String):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["nomUsuario"] = nomUsuario;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("consultaOoSsProceso");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param resgistroAtencionDTO
		 * @return Asynchronous token
		 */
		public function ingresoAtencion(resgistroAtencionDTO:ResgistroAtencionDTO):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["resgistroAtencionDTO"] = resgistroAtencionDTO;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("ingresoAtencion");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 
		 * @return Asynchronous token
		 */
		public function decirHelloWorld():AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("decirHelloWorld");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param dto
		 * @return Asynchronous token
		 */
		public function cambiarDireccionesCliente(dto:ListadoDireccionesSACDTO):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["dto"] = dto;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("cambiarDireccionesCliente");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 
		 * @return Asynchronous token
		 */
		public function consultaAtencion():AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("consultaAtencion");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 
		 * @return Asynchronous token
		 */
		public function obtenerCausalCambio():AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("obtenerCausalCambio");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param usuario* @param passwordActual* @param passwordNueva
		 * @return Asynchronous token
		 */
		public function cambiarPassword(usuario:String,passwordActual:String,passwordNueva:String):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["usuario"] = usuario;
	            out["passwordActual"] = passwordActual;
	            out["passwordNueva"] = passwordNueva;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("cambiarPassword");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param codCliente* @param nomUsuarioSCL* @param codEvento
		 * @return Asynchronous token
		 */
		public function direccionesXCodCliente(codCliente:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["codCliente"] = codCliente;
	            out["nomUsuarioSCL"] = nomUsuarioSCL;
	            out["codEvento"] = codEvento;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("direccionesXCodCliente");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param codSujeto* @param tipoAbono* @param tipoOOSS* @param nomUsuarioSCL* @param codEvento
		 * @return Asynchronous token
		 */
		public function cargarAbonoLimiteConsumoSS(codSujeto:Number,tipoAbono:String,tipoOOSS:String,nomUsuarioSCL:String,codEvento:String):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["codSujeto"] = codSujeto;
	            out["tipoAbono"] = tipoAbono;
	            out["tipoOOSS"] = tipoOOSS;
	            out["nomUsuarioSCL"] = nomUsuarioSCL;
	            out["codEvento"] = codEvento;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("cargarAbonoLimiteConsumoSS");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param entrada
		 * @return Asynchronous token
		 */
		public function ejecutarSuspensionSrvCelular(entrada:EjecucionSuspensionSrvCelDTO):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["entrada"] = entrada;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("ejecutarSuspensionSrvCelular");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param entrada* @param ventaSimcard
		 * @return Asynchronous token
		 */
		public function cargaServicioCargos(entrada:CargaServicioCargosDTO,ventaSimcard:String):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["entrada"] = entrada;
	            out["ventaSimcard"] = ventaSimcard;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("cargaServicioCargos");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param codCuenta* @param nomUsuarioSCL* @param codEvento
		 * @return Asynchronous token
		 */
		public function oossEjecutadasXCodCuenta(codCuenta:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["codCuenta"] = codCuenta;
	            out["nomUsuarioSCL"] = nomUsuarioSCL;
	            out["codEvento"] = codEvento;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("oossEjecutadasXCodCuenta");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param codOOSS* @param numTransaccion* @param nomUsuarioSCL
		 * @return Asynchronous token
		 */
		public function consultaOrdenServicio(codOOSS:Number,numTransaccion:String,nomUsuarioSCL:String):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["codOOSS"] = codOOSS;
	            out["numTransaccion"] = numTransaccion;
	            out["nomUsuarioSCL"] = nomUsuarioSCL;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("consultaOrdenServicio");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param codCliente* @param nomUsuarioSCL* @param codEvento
		 * @return Asynchronous token
		 */
		public function facturasXCodCliente(codCliente:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["codCliente"] = codCliente;
	            out["nomUsuarioSCL"] = nomUsuarioSCL;
	            out["codEvento"] = codEvento;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("facturasXCodCliente");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param codCliente* @param numAbonado* @param nomUsuarioSCL* @param codEvento
		 * @return Asynchronous token
		 */
		public function pagoLimiteConsumoXClienteAbonado(codCliente:Number,numAbonado:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["codCliente"] = codCliente;
	            out["numAbonado"] = numAbonado;
	            out["nomUsuarioSCL"] = nomUsuarioSCL;
	            out["codEvento"] = codEvento;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("pagoLimiteConsumoXClienteAbonado");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param codCliente* @param nomUsuarioSCL* @param codEvento
		 * @return Asynchronous token
		 */
		public function pagosXCodCliente(codCliente:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["codCliente"] = codCliente;
	            out["nomUsuarioSCL"] = nomUsuarioSCL;
	            out["codEvento"] = codEvento;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("pagosXCodCliente");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param numOS
		 * @return Asynchronous token
		 */
		public function cambiosPlanCliente(numOS:Number):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["numOS"] = numOS;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("cambiosPlanCliente");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param entrada
		 * @return Asynchronous token
		 */
		public function ejecutarAjusteCExcepcionCargos(entrada:EjecucionAjusteCExcepcionCargosSACDTO):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["entrada"] = entrada;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("ejecutarAjusteCExcepcionCargos");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param codCliente* @param numAbonado* @param nomUsuarioSCL* @param codEvento
		 * @return Asynchronous token
		 */
		public function beneficiosXClienteAbonado(codCliente:Number,numAbonado:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["codCliente"] = codCliente;
	            out["numAbonado"] = numAbonado;
	            out["nomUsuarioSCL"] = nomUsuarioSCL;
	            out["codEvento"] = codEvento;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("beneficiosXClienteAbonado");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param comentario* @param numOoss
		 * @return Asynchronous token
		 */
		public function insertComentarioPvIorserv(comentario:String,numOoss:Number):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["comentario"] = comentario;
	            out["numOoss"] = numOoss;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("insertComentarioPvIorserv");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param dto
		 * @return Asynchronous token
		 */
		public function realizarBloqueoRobo(dto:RealizarBloqueoRoboSACINDTO):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["dto"] = dto;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("realizarBloqueoRobo");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param numIdent
		 * @return Asynchronous token
		 */
		public function cuentasXNumIdent(numIdent:String):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["numIdent"] = numIdent;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("cuentasXNumIdent");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param entrada
		 * @return Asynchronous token
		 */
		public function ejecutarCambioNumFrecuente(entrada:EjecucionCambioNumFrecuentesSACDTO):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["entrada"] = entrada;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("ejecutarCambioNumFrecuente");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param fechaDesde* @param fechaHasta
		 * @return Asynchronous token
		 */
		public function obtenerReportePresEquiInt(fechaDesde:String,fechaHasta:String):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["fechaDesde"] = fechaDesde;
	            out["fechaHasta"] = fechaHasta;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("obtenerReportePresEquiInt");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param usuario* @param password* @param passwordConfirmada
		 * @return Asynchronous token
		 */
		public function crearUsuario(usuario:String,password:String,passwordConfirmada:String):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["usuario"] = usuario;
	            out["password"] = password;
	            out["passwordConfirmada"] = passwordConfirmada;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("crearUsuario");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param codCliente
		 * @return Asynchronous token
		 */
		public function obtenerListDatosAbonados(codCliente:Number):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["codCliente"] = codCliente;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("obtenerListDatosAbonados");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param numAbonado* @param nomUsuarioSCL* @param codEvento
		 * @return Asynchronous token
		 */
		public function getDetalleAbonado(numAbonado:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["numAbonado"] = numAbonado;
	            out["nomUsuarioSCL"] = nomUsuarioSCL;
	            out["codEvento"] = codEvento;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("getDetalleAbonado");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param codCliente* @param nomUsuarioSCL* @param codEvento
		 * @return Asynchronous token
		 */
		public function productosXCodCliente(codCliente:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["codCliente"] = codCliente;
	            out["nomUsuarioSCL"] = nomUsuarioSCL;
	            out["codEvento"] = codEvento;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("productosXCodCliente");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param codCliente* @param nomUsuarioSCL* @param codEvento
		 * @return Asynchronous token
		 */
		public function oossEjecutadasXCodCliente(codCliente:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["codCliente"] = codCliente;
	            out["nomUsuarioSCL"] = nomUsuarioSCL;
	            out["codEvento"] = codEvento;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("oossEjecutadasXCodCliente");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param numAbonado* @param nomUsuarioSCL* @param codEvento
		 * @return Asynchronous token
		 */
		public function productosXNumAbonado(numAbonado:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["numAbonado"] = numAbonado;
	            out["nomUsuarioSCL"] = nomUsuarioSCL;
	            out["codEvento"] = codEvento;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("productosXNumAbonado");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param usuario
		 * @return Asynchronous token
		 */
		public function cargaValidaOSUsuario(usuario:String):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["usuario"] = usuario;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("cargaValidaOSUsuario");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param numAbonado* @param nomUsuarioSCL* @param codEvento
		 * @return Asynchronous token
		 */
		public function cargarCambioSIMCard(numAbonado:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["numAbonado"] = numAbonado;
	            out["nomUsuarioSCL"] = nomUsuarioSCL;
	            out["codEvento"] = codEvento;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("cargarCambioSIMCard");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param fechaDesde* @param fechaHasta* @param codCausalCam
		 * @return Asynchronous token
		 */
		public function obtenerReporteCambioEquiGene(fechaDesde:String,fechaHasta:String,codCausalCam:String):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["fechaDesde"] = fechaDesde;
	            out["fechaHasta"] = fechaHasta;
	            out["codCausalCam"] = codCausalCam;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("obtenerReporteCambioEquiGene");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param numAbonado
		 * @return Asynchronous token
		 */
		public function obtenerDatosAbonado(numAbonado:Number):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["numAbonado"] = numAbonado;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("obtenerDatosAbonado");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param codCliente
		 * @return Asynchronous token
		 */
		public function umtsAbonadosXCodCliente(codCliente:Number):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["codCliente"] = codCliente;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("umtsAbonadosXCodCliente");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param codCliente* @param nomUsuarioSCL* @param pwd* @param codEvento
		 * @return Asynchronous token
		 */
		public function cargarAjusteCExcepcionCargos(codCliente:Number,nomUsuarioSCL:String,pwd:String,codEvento:String):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["codCliente"] = codCliente;
	            out["nomUsuarioSCL"] = nomUsuarioSCL;
	            out["pwd"] = pwd;
	            out["codEvento"] = codEvento;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("cargarAjusteCExcepcionCargos");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param pIn
		 * @return Asynchronous token
		 */
		public function obtenerDatosDireccionCliente(pIn:DatosDireccionClienteINDTO):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["pIn"] = pIn;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("obtenerDatosDireccionCliente");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param entrada
		 * @return Asynchronous token
		 */
		public function ejecutarAbonoLimiteConsumoSS(entrada:EjecucionAbonoLimiteConsumoServicioSuplementarioDTO):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["entrada"] = entrada;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("ejecutarAbonoLimiteConsumoSS");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param entrada
		 * @return Asynchronous token
		 */
		public function ejecucionCambioDatosCliente(entrada:EjecucionCambioDatosClienteSACDTO):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["entrada"] = entrada;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("ejecucionCambioDatosCliente");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param codGrupo* @param codPrograma* @param numVersion
		 * @return Asynchronous token
		 */
		public function consultasXCodGrupo(codGrupo:String,codPrograma:String,numVersion:String):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["codGrupo"] = codGrupo;
	            out["codPrograma"] = codPrograma;
	            out["numVersion"] = numVersion;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("consultasXCodGrupo");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param numAbonado* @param nomUsuarioSCL* @param codEvento
		 * @return Asynchronous token
		 */
		public function cargarSuspensionSrvCelular(numAbonado:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["numAbonado"] = numAbonado;
	            out["nomUsuarioSCL"] = nomUsuarioSCL;
	            out["codEvento"] = codEvento;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("cargarSuspensionSrvCelular");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param codCliente* @param nomUsuarioSCL* @param codEvento
		 * @return Asynchronous token
		 */
		public function getDetalleCliente(codCliente:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["codCliente"] = codCliente;
	            out["nomUsuarioSCL"] = nomUsuarioSCL;
	            out["codEvento"] = codEvento;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("getDetalleCliente");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param numAbonado* @param nomUsuarioSCL* @param codEvento
		 * @return Asynchronous token
		 */
		public function getDetalleEquipo(numAbonado:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["numAbonado"] = numAbonado;
	            out["nomUsuarioSCL"] = nomUsuarioSCL;
	            out["codEvento"] = codEvento;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("getDetalleEquipo");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param codCliente
		 * @return Asynchronous token
		 */
		public function getDeudaCliente(codCliente:Number):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["codCliente"] = codCliente;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("getDeudaCliente");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param codCuenta
		 * @return Asynchronous token
		 */
		public function consultaCuenta(codCuenta:Number):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["codCuenta"] = codCuenta;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("consultaCuenta");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param strCodOrdenServ
		 * @return Asynchronous token
		 */
		public function solicitaUrlDominioPuerto(strCodOrdenServ:String):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["strCodOrdenServ"] = strCodOrdenServ;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("solicitaUrlDominioPuerto");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param codCliente* @param nomUsuarioSCL* @param pwd* @param codEvento
		 * @return Asynchronous token
		 */
		public function cargarAjusteCReversionCargos(codCliente:Number,nomUsuarioSCL:String,pwd:String,codEvento:String):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["codCliente"] = codCliente;
	            out["nomUsuarioSCL"] = nomUsuarioSCL;
	            out["pwd"] = pwd;
	            out["codEvento"] = codEvento;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("cargarAjusteCReversionCargos");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param numAbonado* @param nomUsuarioSCL* @param codEvento
		 * @return Asynchronous token
		 */
		public function oossEjecutadasXNumAbonado(numAbonado:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["numAbonado"] = numAbonado;
	            out["nomUsuarioSCL"] = nomUsuarioSCL;
	            out["codEvento"] = codEvento;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("oossEjecutadasXNumAbonado");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param numAbonado
		 * @return Asynchronous token
		 */
		public function ssXDefectoXNumAbonado(numAbonado:Number):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["numAbonado"] = numAbonado;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("ssXDefectoXNumAbonado");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param entrada
		 * @return Asynchronous token
		 */
		public function ejecutarCambioEquipoGSM(entrada:EjecucionCambioEquipoGSMDTO):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["entrada"] = entrada;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("ejecutarCambioEquipoGSM");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param obj
		 * @return Asynchronous token
		 */
		public function getDocsPagosCliente(obj:GetDocsClienteINDTO):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["obj"] = obj;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("getDocsPagosCliente");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param obj* @param nomUsuarioSCL* @param codEvento
		 * @return Asynchronous token
		 */
		public function getDocsCtaCteCliente(obj:GetDocsClienteINDTO,nomUsuarioSCL:String,codEvento:String):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["obj"] = obj;
	            out["nomUsuarioSCL"] = nomUsuarioSCL;
	            out["codEvento"] = codEvento;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("getDocsCtaCteCliente");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param dto
		 * @return Asynchronous token
		 */
		public function cambiarDireccionCliente(dto:DireccionSACDTO):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["dto"] = dto;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("cambiarDireccionCliente");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param codCliente
		 * @return Asynchronous token
		 */
		public function ssXDefectoXCodCliente(codCliente:Number):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["codCliente"] = codCliente;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("ssXDefectoXCodCliente");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param numOOSS
		 * @return Asynchronous token
		 */
		public function servSuplXOOSS(numOOSS:Number):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["numOOSS"] = numOOSS;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("servSuplXOOSS");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param codCliente* @param numAbonado* @param nomUsuarioSCL* @param codEvento
		 * @return Asynchronous token
		 */
		public function limiteConsumoXClienteAbonado(codCliente:Number,numAbonado:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["codCliente"] = codCliente;
	            out["numAbonado"] = numAbonado;
	            out["nomUsuarioSCL"] = nomUsuarioSCL;
	            out["codEvento"] = codEvento;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("limiteConsumoXClienteAbonado");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param numAbonado* @param nomUsuarioSCL* @param codEvento
		 * @return Asynchronous token
		 */
		public function cargaOSGenericaAbonado(numAbonado:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["numAbonado"] = numAbonado;
	            out["nomUsuarioSCL"] = nomUsuarioSCL;
	            out["codEvento"] = codEvento;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("cargaOSGenericaAbonado");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 
		 * @return Asynchronous token
		 */
		public function obtenerParametroKiosco():AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("obtenerParametroKiosco");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param codCuenta
		 * @return Asynchronous token
		 */
		public function cuentasXCodigo(codCuenta:Number):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["codCuenta"] = codCuenta;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("cuentasXCodigo");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param nombre
		 * @return Asynchronous token
		 */
		public function clientesXNombre(nombre:String):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["nombre"] = nombre;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("clientesXNombre");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param numOS
		 * @return Asynchronous token
		 */
		public function cambiosPlanAbonadoPrepago(numOS:Number):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["numOS"] = numOS;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("cambiosPlanAbonadoPrepago");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param codDireccion* @param codTipDireccion
		 * @return Asynchronous token
		 */
		public function getDetalleDireccion(codDireccion:Number,codTipDireccion:String):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["codDireccion"] = codDireccion;
	            out["codTipDireccion"] = codTipDireccion;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("getDetalleDireccion");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param entrada
		 * @return Asynchronous token
		 */
		public function ejecutarAbonoLimiteConsumo(entrada:EjecucionAbonoLimConDTO):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["entrada"] = entrada;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("ejecutarAbonoLimiteConsumo");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param codCuenta
		 * @return Asynchronous token
		 */
		public function clientesXCuenta(codCuenta:Number):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["codCuenta"] = codCuenta;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("clientesXCuenta");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param entrada
		 * @return Asynchronous token
		 */
		public function ejecutarAnulacionSiniestro(entrada:EjecucionAnulacionSiniestroDTO):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["entrada"] = entrada;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("ejecutarAnulacionSiniestro");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param entrada
		 * @return Asynchronous token
		 */
		public function ejecutarAjusteCReversionCargos(entrada:EjecucionAjusteCReversionCargosSACDTO):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["entrada"] = entrada;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("ejecutarAjusteCReversionCargos");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param numAbonado
		 * @return Asynchronous token
		 */
		public function numerosFrecuentesXPlan(numAbonado:Number):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["numAbonado"] = numAbonado;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("numerosFrecuentesXPlan");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param numDato* @param tipoDato
		 * @return Asynchronous token
		 */
		public function obtenerOoSsAgendadas(numDato:Number,tipoDato:Number):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["numDato"] = numDato;
	            out["tipoDato"] = tipoDato;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("obtenerOoSsAgendadas");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param codCliente* @param nomUsuarioSCL* @param codEvento
		 * @return Asynchronous token
		 */
		public function ccXCodCliente(codCliente:Number,nomUsuarioSCL:String,codEvento:String):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["codCliente"] = codCliente;
	            out["nomUsuarioSCL"] = nomUsuarioSCL;
	            out["codEvento"] = codEvento;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("ccXCodCliente");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param codCliente
		 * @return Asynchronous token
		 */
		public function abonadosXCliente(codCliente:Number):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["codCliente"] = codCliente;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("abonadosXCliente");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
		/**
		 * Performs the low level call to the server for the operation
		 * It passes along the headers and the operation arguments
		 * @param comentario* @param numOoss
		 * @return Asynchronous token
		 */
		public function insertComentario(comentario:String,numOoss:Number):AsyncToken
		{
			var headerArray:Array = new Array();
            var out:Object = new Object();
            out["comentario"] = comentario;
	            out["numOoss"] = numOoss;
	            currentOperation = BaseWSSEGPortalService.getPort("BaseWSSEGPortalPort").binding.portType.getOperation("insertComentario");
            var pc:PendingCall = new PendingCall(out,headerArray);
            call(currentOperation,out,pc.token,pc.headers);
            return pc.token;
		}
        /**
         * Performs the actual call to the remove server
         * It SOAP-encodes the message using the schema and WSDL operation options set above and then calls the server using 
         * an async invoker
         * It also registers internal event handlers for the result / fault cases
         * @private
         */
        private function call(operation:WSDLOperation,args:Object,token:AsyncToken,headers:Array=null):void
        {
	    	var enc:SOAPEncoder = new SOAPEncoder();
	        var soap:Object = new Object;
	        var message:SOAPMessage = new SOAPMessage();
	        enc.wsdlOperation = operation;
	        soap = enc.encodeRequest(args,headers);
	        message.setSOAPAction(operation.soapAction);
	        message.body = soap.toString();
	        message.url=endpointURI;
            var inv:AsyncRequest = new AsyncRequest();
            inv.destination = super.destination;
            //we need this to handle multiple asynchronous calls 
            var wrappedData:Object = new Object();
            wrappedData.operation = currentOperation;
            wrappedData.returnToken = token;
            if(!this.useProxy)
            {
            	var dcs:ChannelSet = new ChannelSet();	
	        	dcs.addChannel(new DirectHTTPChannel("direct_http_channel"));
            	inv.channelSet = dcs;
            }                
            var processRes:AsyncResponder = new AsyncResponder(processResult,faultResult,wrappedData);
			
		    // ------------------ AUTENTICACION begin ------------------------
			var encoder : Base64Encoder = new Base64Encoder();
			encoder.encode(getUsaurio() + ":" + getPassword());
			var encodedCredentials : String = encoder.flush();
			if (message.httpHeaders == null)
			message.httpHeaders = {};
			message.httpHeaders["Authorization"] = "Basic " + encodedCredentials;
			         
			// ------------------ AUTENTICACION end ------------------------

          	inv.invoke(message,processRes);
            
		}
        
        /**
         * Internal event handler to process a successful operation call from the server
         * The result is decoded using the schema and operation settings and then the events get passed on to the actual facade that the user employs in the application 
         * @private
         */
		private function processResult(result:Object,wrappedData:Object):void
           {
           		var headers:Object;
           		var token:AsyncToken = wrappedData.returnToken;
                var currentOperation:WSDLOperation = wrappedData.operation;
                var decoder:SOAPDecoder = new SOAPDecoder();
                decoder.resultFormat = "object";
                decoder.headerFormat = "object";
                decoder.multiplePartsFormat = "object";
                decoder.ignoreWhitespace = true;
                decoder.makeObjectsBindable=false;
                decoder.wsdlOperation = currentOperation;
                decoder.schemaManager = currentOperation.schemaManager;
                var body:Object = result.message.body;
                var stringResult:String = String(body);
                if(stringResult == null  || stringResult == "")
                	return;
                var soapResult:SOAPResult = decoder.decodeResponse(result.message.body);
                if(soapResult.isFault)
                {
	                var faults:Array = soapResult.result as Array;
	                for each (var soapFault:Fault in faults)
	                {
		                var soapFaultEvent:FaultEvent = FaultEvent.createEvent(soapFault,token,null);
		                token.dispatchEvent(soapFaultEvent);
	                }
                } else {
					// ------------------------------------------------------------------------------------------
					// Autor : Gabriel Galetti
					// Version : 1.2
					// Fecha : 18/12/08
					// ------------------------------------------------------------------------------------------
					var bodyXML:XML = new XML(result.message.body);
			        // ------------------------------------------------------------------------------------------
			
			        result = soapResult.result;
			        headers = soapResult.headers;
			        
					// ------------------------------------------------------------------------------------------
					// Autor : Gabriel Galetti
					// Version : 1.3
					// Fecha : 18/12/08
					// ------------------------------------------------------------------------------------------
			         try {
				         if (Utilidades.buscarElementoEnXML(bodyXML, "desError") != "")
							result.desError = Utilidades.buscarElementoEnXML(bodyXML, "desError");
				
						 if (Utilidades.buscarElementoEnXML(bodyXML, "codError") != "")
							result.codError = Utilidades.buscarElementoEnXML(bodyXML, "codError");
				
				         if (Utilidades.buscarElementoEnXML(bodyXML, "numTransaccion") != "")
							result.numTransaccion = Utilidades.buscarElementoEnXML(bodyXML, "numTransaccion");
				
				         if (Utilidades.buscarElementoEnXML(bodyXML, "nroOOSS") != "")
				            result.nroOOSS = Utilidades.buscarElementoEnXML(bodyXML, "nroOOSS");
			         }
			         catch (error:*){}
			        // ------------------------------------------------------------------------------------------           	
	                var event:ResultEvent = ResultEvent.createEvent(result,token,null);
	                event.headers = headers;
	                token.dispatchEvent(event);
                }
           }
           	/**
           	 * Handles the cases when there are errors calling the operation on the server
           	 * This is not the case for SOAP faults, which is handled by the SOAP decoder in the result handler
           	 * but more critical errors, like network outage or the impossibility to connect to the server
           	 * The fault is dispatched upwards to the facade so that the user can do something meaningful 
           	 * @private
           	 */
			private function faultResult(error:MessageFaultEvent,token:Object):void
			{
				//when there is a network error the token is actually the wrappedData object from above	
				if(!(token is AsyncToken))
					token = token.returnToken;
				token.dispatchEvent(new FaultEvent(FaultEvent.FAULT,true,true,new Fault(error.faultCode,error.faultString,error.faultDetail)));
			}
		}
	}

	import mx.rpc.AsyncToken;
	import mx.rpc.AsyncResponder;
	import mx.rpc.wsdl.WSDLBinding;
                
    /**
     * Internal class to handle multiple operation call scheduling
     * It allows us to pass data about the operation being encoded / decoded to and from the SOAP encoder / decoder units. 
     * @private
     */
    class PendingCall
    {
		public var args:*;
		public var headers:Array;
		public var token:AsyncToken;
		
		public function PendingCall(args:Object, headers:Array=null)
		{
			this.args = args;
			this.headers = headers;
			this.token = new AsyncToken(null);
		}
	}