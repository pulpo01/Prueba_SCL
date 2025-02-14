

	[Embed(source="recursosInterfaz/imagenes/iconos/tools.gif")]
	  public const icon1:Class;
  			
	[Embed(source="recursosInterfaz/imagenes/iconos/selectAll.png")]
	  public const icon2:Class;
	  
	[Embed(source="recursosInterfaz/imagenes/iconos/grabar.png")]
	  public const icon3:Class;
	  
	[Embed(source="recursosInterfaz/imagenes/iconos/pdf.png")]
	  public const icon4:Class;
	  
	[Embed(source="recursosInterfaz/imagenes/iconos/imprimir.png")]
	  public const icon5:Class;

	[Embed(source="recursosInterfaz/imagenes/iconos/columnas.png")]
	  public const icon6:Class;
	  
	[Embed(source="recursosInterfaz/imagenes/iconos/menu.png")]
	  public const iconMenu:Class;

	[Embed(source="recursosInterfaz/imagenes/iconos/alert/warning.png")]
        public var iconWarning:Class; 		

	// Componentes de las consultas
	public var infoCuenta:Class = InformacionCuenta;
	public var infoCliente:Class = InformacionCliente;
	public var infoAbonado:Class = InformacionAbonado;
	public var direcClientes:Class = DireccionesCliente;
	public var ctaCteCliente:Class = CuentaCorrienteCliente;
	public var oossEjectutadas:Class = OOSSEjecutadas;
	public var beneficiosAbonado:Class = BeneficiosAbonado;
	public var listadoProductos:Class = ListadoProductos;
	public var datosEquipoAbonado:Class = DatosEquipoAbonado;
	public var limiteConsumoAbonado:Class = LimiteConsumoAbonado;
	public var detalleLlamadasAbonado:Class = DetalleLlamadasAbonado;
	public var cambioPassword:Class = CambioPassword;
	public var modificacionDirecciones:Class = ModificacionDirecciones;
	public var oossAgendadas:Class = OOSSAgendadas;
	
	// Flag si debe hacer cambio de accordion despues de una busqueda
	public var flagSwitchAccordion:Boolean = false;
	// Para saber si se esta mostrando o no para no volverla a cargar
	public var flagProgressBar:Boolean = false;
	
	public var searchingPopUpView:Class = BarraDeProgreso2;
	
	public var popUpWindowCuenta:IFlexDisplayObject;
	public var popUpWindowCliente:IFlexDisplayObject;
	public var popUpWindowAbonado:IFlexDisplayObject;
	public var popUpWindow:IFlexDisplayObject;
	
	public var popUpParent:DisplayObject;
	public var mensajeAcumulado:String = "";
		
	// Flag para sincronizar el texto del path cuando se hace doble click y recargan varias grillas a la vez
	public var nivelClick:String = "";
	
	[Bindable]
    public var arrowScrollPolicy:String = ScrollPolicy.AUTO;
            
    [Bindable]
    public var vertScrollPolicy:String = ScrollPolicy.OFF;

	[Bindable]
	public var dsGridCliente:Array = new Array();

	[Bindable]		
	public var dsGridCuenta:Array = new Array();

	[Bindable]
	public var dsGridAbonado:Array = new Array();

	[Bindable]
   	public var servicio:HTTPService = new HTTPService();

	[Bindable]
	public var codOOSSMenu:String = "";

	[Bindable]
	public var modulo:IModuleInfo;

	public var wsORQ:WSSEGPortal = new WSSEGPortal();
	public var wsORQOOSS:WSSEGPortal = new WSSEGPortal();
       
       