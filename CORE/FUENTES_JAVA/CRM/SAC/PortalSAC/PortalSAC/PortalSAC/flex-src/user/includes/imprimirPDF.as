
	private function imprimirPDF()	{

		var printToPDF:PrintToPDF = new  PrintToPDF();

		printToPDF.grid = grid;
		printToPDF.pantalla = this;
		printToPDF.titulo = "OOSS Ejecutadas";
		printToPDF.subTitulo = subTitulo;
		printToPDF.anchoColsGrid = anchoColsGrid;
		printToPDF.url = StringUtil.getValor("AppServerRootURL","VALOR")+StringUtil.getValor("urlGeneraPDF","VALOR");
		
		UtilDataGrid.exportDatagridToPdf(printToPDF);	
	} // imprimirPDF
	
	// --------------------------------------------------------------------------------