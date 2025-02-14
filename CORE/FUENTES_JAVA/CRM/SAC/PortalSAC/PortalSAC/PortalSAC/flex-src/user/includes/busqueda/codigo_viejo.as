/*					
		switch (opcion)	{
			// Cuentas
			case "buscarPorCuenta":
				switch (subOpcion)	{
					case "numCtaBtn":
						var codCuenta:Number = parseInt(txtSearchCuenta.text);
						orquestaBusquedaCuentas(subOpcion, codCuenta, true, true);
						break;
						
					case "nomCuentaBtn":
						var nomCuenta:String = txtSearchCuenta.text;
						orquestaBusquedaCuentas(subOpcion, nomCuenta, true, true);
						break;
						
					case "numIdentifBtn":
						var numIdentif:String = txtSearchCuenta.text;
						orquestaBusquedaCuentas(subOpcion, numIdentif, true, true);
						break;
						
					case "cuentaClick":
						var codCuentaClick:Number = parseInt(gridCuentas.selectedItem.codCuenta);
						orquestaBusquedaCuentas(subOpcion, codCuentaClick, true, true);
				} // switch
				
				break;
	
			// Clientes
			case "buscarPorCliente":
				switch (subOpcion)	{
					case "numCliBtn":
						var codCliente:Number = parseInt(txtSearchCliente.text);
						orquestaBusquedaClientes(subOpcion, codCliente, true);
						break;
						
					case "nomCliBtn":
						var nomCliente:String = txtSearchCliente.text;
						orquestaBusquedaClientes(subOpcion, nomCliente, true);
						break;
						
					case "clienteClick":
						var codClienteClick:Number = parseInt(gridClientes.selectedItem.codCliente);
						
						// Si la grilla no tiene cuentas, entonces hay que buscar y no cambiar
						if (dsGridCuenta.length > 0)
							orquestaBusquedaClientes(subOpcion, codClienteClick, true);
						else
							orquestaBusquedaClientes(subOpcion, codClienteClick, false);
				} // switch
				
				break;
			
			// Abonados	
			case "buscarPorAbonado":
				switch (subOpcion)	{
					case "numCeluBtn":
						var numCelular:Number = parseInt(txtSearchAbonado.text);
						orquestaBusquedaAbonados(subOpcion, numCelular);
						break;
						
					case "desdeAbonadoClick":
						orquestaBusquedaAbonados(subOpcion, "");
						break;
						
					case "desdeClienteClick":
						var codClienteGridClienteClick:Number = parseInt(gridClientes.selectedItem.codCliente);
						orquestaBusquedaAbonados(subOpcion, codClienteGridClienteClick);
				} // switch
				
		} // switch
	*/