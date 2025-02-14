	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Galetti
	// Version : 1.0
	// Fecha : 07/10/08
	// ------------------------------------------------------------------------------------------
		 	
	private function filtrarCuentas():void	{
	
		if (acGridCuenta!=null)	{
			acGridCuenta.filterFunction = filtroGrillaCuentas;
			acGridCuenta.refresh();
		} 
	}
	
	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Galetti
	// Version : 1.0
	// Fecha : 17/12/08
	// ------------------------------------------------------------------------------------------
		 	
	private function filtrarClientes():void	{
	
		if (acGridCliente!=null)	{
			acGridCliente.filterFunction = filtroGrillaClientes;
			acGridCliente.refresh();
		}
	}
	
	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Galetti
	// Version : 1.0
	// Fecha : 07/10/08
	// ------------------------------------------------------------------------------------------
		 	
	private function filtrarAbonados():void	{
		if (acGridAbonado!=null)	{
			acGridAbonado.filterFunction = filtroGrillaAbonados;
			acGridAbonado.refresh();
		}
	}
	
	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Galetti
	// Version : 1.1
	// Fecha : 17/12/08
	// ------------------------------------------------------------------------------------------
	
	private function filtroGrillaClientes(item:Object):Boolean 	{
		var campo:String;
	
		switch(cboFiltroClientes.selectedItem.data)	{
			case 1:	
				if  (item.codCliente.toString().toUpperCase().indexOf(txtFiltroClientes.text.toUpperCase()) >= 0)	
					return true;
				else
					return false;
			case 2:								
				if  (item.nomCliente.toString().toUpperCase().indexOf(txtFiltroClientes.text.toUpperCase()) >= 0)	
					return true;
				else
					return false;
			case 3:								
				if  (item.tipPersona.toString().toUpperCase().indexOf(txtFiltroClientes.text.toUpperCase()) >= 0)	
					return true;
				else
					return false;
			
		} // switch
			 
		return true;
		 
	} // procesarFiltro
	
	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Galetti
	// Version : 1.1
	// Fecha : 17/12/08
	// ------------------------------------------------------------------------------------------
	
	private function filtroGrillaCuentas(item:Object):Boolean 	{
	
		switch(cboFiltroCuentas.selectedItem.data)	{
			case 1:	
				if  (item.codCuenta.toString().toUpperCase().indexOf(txtFiltroCuentas.text.toUpperCase()) >= 0)	
					return true;
				else
					return false;
			case 2:								
				if  (item.desCuenta.toString().toUpperCase().indexOf(txtFiltroCuentas.text.toUpperCase()) >= 0)	
					return true;
				else
					return false;
			
		} // switch
			 
		return true;
		 
	} // procesarFiltro
	
	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Galetti
	// Version : 1.1
	// Fecha : 17/12/08
	// ------------------------------------------------------------------------------------------
	
	private function filtroGrillaAbonados(item:Object):Boolean 	{
		var campo:String;
	
		switch(cboFiltroAbonados.selectedItem.data)	{
			case 1:	
				if  (item.numCelular.toString().toUpperCase().indexOf(txtFiltroAbonados.text.toUpperCase()) >= 0)	
					return true;
				else
					return false;
			case 2:								
				if  (item.numAbonado.toString().toUpperCase().indexOf(txtFiltroAbonados.text.toUpperCase()) >= 0)	
					return true;
				else
					return false;
			
		} // switch
			 
		return true;
		 
	} // procesarFiltro
	
	
	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Galetti
	// Version : 1.0
	// Fecha : 19/12/08
	// ------------------------------------------------------------------------------------------

	private function changeCombo(combo:ComboBox, grid:String):void	{

		switch (grid)	{
			case "cuentas":
				switch (combo.selectedItem.data)	{
					case 0:
						txtFiltroCuentas.text = "";
						if (acGridCuenta != null) acGridCuenta.refresh();						
						break;
					default:
						filtrarCuentas();
				} // switch
				break;
			case "clientes":
				switch (combo.selectedItem.data)	{
					case 0:
						txtFiltroClientes.text = "";
						if (acGridCliente != null) acGridCliente.refresh();						
						break;
					default:
						filtrarClientes();
				} // switch
				
				break;
			case "abonados":
				switch (combo.selectedItem.data)	{
					case 0:
						txtFiltroAbonados.text = "";
						if (acGridAbonado != null) acGridAbonado.refresh();						
						break;
					default:
						filtrarAbonados();
				} // switch
							
		} // switch

	} // changeCombo
	
	// ------------------------------------------------------------------------------------------
	// Atajo si presiona ENTER 
  	private function submit(event:KeyboardEvent, nivel:String):void	{
  		
  		var evento:flash.events.MouseEvent = new flash.events.MouseEvent(MouseEvent.CLICK, false, false);
  		switch(nivel)	{
  			case "cuenta":
	  			if (event.charCode.toString() == "13") btnBuscarCuenta.dispatchEvent(evento);
  				break;
  			case "cliente":
  				if (event.charCode.toString() == "13") btnBuscarCliente.dispatchEvent(evento);
  				break;	
  			case "abonado":
  				if (event.charCode.toString() == "13") btnBuscarAbonado.dispatchEvent(evento);
  		} // switch
  		
  	} // submit