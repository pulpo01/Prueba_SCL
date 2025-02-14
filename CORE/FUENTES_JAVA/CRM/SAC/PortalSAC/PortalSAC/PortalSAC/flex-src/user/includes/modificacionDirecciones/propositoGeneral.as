	// ----------------------------------------------------------------------------------------
	// Create by HGG 
	// Date 16-08-2009
	// Version 1.0
	// ----------------------------------------------------------------------------------------
	import mx.controls.Alert;
	import user.libreria.clases.StringUtil;
	
	private function cerrar():void {
		parentDocument.vbOOSS.enabled = false;
		parentDocument.vb1.enabled=true;
		parentDocument.tab1.selectedIndex=0;
		this.visible=false;
		return;
	} // cerrar

	// ----------------------------------------------------------------------------------------
	// Create by HGG 
	// Date 16-08-2009
	// Version 1.0
	// ----------------------------------------------------------------------------------------

	// Si se terminaron de orquestar todos los servicios de la pagina entonces se oculta el scrollbar
	private function hideScrollBar():void	{
	
		flagCarga--;
		if (flagCarga==0)
			PopUpManager.removePopUp(popUpWindow);
		
	} // hideScrollBar
	

	// ----------------------------------------------------------------------------------------
	// Create by HGG 
	// Date 19-08-2009
	// Version 1.1
	// ----------------------------------------------------------------------------------------
	
	private function seteaIndiceListbox(listbox:ComboBox, atributo:String, codigo:String):void	{
		
		var cont:Number = 0;
		while (cont < listbox.dataProvider.length)	{
			if (listbox.dataProvider[cont][atributo] == codigo)	{
				listbox.selectedIndex = cont;
				cont = listbox.dataProvider.length;
			}
			cont++;
		} // while

	}	// seteaIndiceListbox
	
	// ----------------------------------------------------------------------------------------
	// Create by HGG 
	// Date 24-08-2009
	// Version 1.0
	// ----------------------------------------------------------------------------------------
	private function validaCambios():Boolean	{
		
		if (flagCambios && 
			cboReparto.selectedIndex > 0 &&
			cboCiudad.selectedIndex > 0 &&
			cboDepartamento.selectedIndex > 0 &&
			cboCiudad.selectedIndex > 0 &&
			StringUtil.trim(txtCalle.text).length>0 &&
			StringUtil.trim(txtComentario.text).length>0) 
			return true;				
		
		return false;

	}	// validaCambios
	
	// ----------------------------------------------------------------------------------------
	// Create by HGG 
	// Date 24-08-2009
	// Version 1.0
	// ----------------------------------------------------------------------------------------
	private function seteaFlagCambios():void	{
		
		flagCambios=true

	}	// seteaFlagCambios
	
	// ----------------------------------------------------------------------------------------
	// Create by HGG 
	// Date 24-08-2009
	// Version 1.0
	// ----------------------------------------------------------------------------------------
	private function validaConUsuario():void	{
		
		if (flagCambios)	{
			Alert.yesLabel = "SI";
			Alert.noLabel = "NO";
			Alert.show( "Se han producido cambios en la dirección del cliente, si continúa los perderá.\nDesea proseguir?", 
						"Advertencia", 
						Alert.YES|Alert.NO,
						this,
						selectDireccion,
						iconWarning,
						mx.controls.Alert.OK );
		} // if
		else
		{
			executeWS("click");
		}
			
	}	// validaConUsuario
	
	// ----------------------------------------------------------------------------------------
	// Create by HGG 
	// Date 24-08-2009
	// Version 1.0
	// ----------------------------------------------------------------------------------------
	private function selectDireccion(evento:CloseEvent):void	{
		
		if (evento.detail==Alert.YES)	{
			flagCambios=false;
			executeWS("click");
		} // if

	}	// selectDireccion
	

