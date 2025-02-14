package user.libreria.clases

{
	import mx.collections.ArrayCollection;
	import mx.controls.AdvancedDataGrid;
	import mx.controls.Alert;
	import mx.controls.advancedDataGridClasses.AdvancedDataGridColumn;
	import mx.core.Application;
	import mx.printing.*;
	
	public class Impresion	{
		// ------------------------------------------------------------------------------------------
		// Autor : Adobe
		// Adaptacion : Gabriel Galetti
		// Version : 1.1
		// Fecha : 22/10/08
		// ------------------------------------------------------------------------------------------
			
		static public function imprimirDatagrid(aplicacion:mx.core.Application, datagrid:mx.controls.AdvancedDataGrid, titulo:String):void {

            // Creo el array con las columnas visibles
            var colArray:Array = new Array();
        	
        	for(var col:int=0; col < datagrid.columns.length; col++)	{
	            var colDatagrid:AdvancedDataGridColumn = new AdvancedDataGridColumn();
            	colDatagrid = datagrid.columns[col];
        		if (colDatagrid.visible)	{
    				var colum:AdvancedDataGridColumn = new AdvancedDataGridColumn();            

					colum.headerText = colDatagrid.headerText;
					colum.dataField = colDatagrid.dataField;
					colArray.push(colum);
					colum = null;
				} // for 
				colDatagrid = null;
        	} // for
            
            
            // Si no hay columnas visibles entonces hay que mostrar un mensaje de error.
			if (colArray.length == 0)	{
				Alert.show("La grilla a imprimir no dispone de columnas de datos", "Error en la Aplicación");
				return;
			} // if
			
		    var printJob:FlexPrintJob = new FlexPrintJob();
            if (printJob.start()) {
                // Create a FormPrintView control as a child of the current view.
                var thePrintView:FormPrintView = new FormPrintView();
                aplicacion.addChild(thePrintView);
            	
                //Set the print view properties.
                thePrintView.width=printJob.pageWidth;
                thePrintView.height=printJob.pageHeight;
                thePrintView.prodTotal = 0;
                thePrintView.dataGrid.dataProvider = datagrid.dataProvider;
				
				thePrintView.dataGrid.columns = [];
				thePrintView.dataGrid.columns = colArray;
                
                // Create a single-page image.
                thePrintView.showPage("single");
                // If the print image's data grid can hold all the provider's rows,
                // add the page to the print job.
                if(!thePrintView.dataGrid.validNextPage)
                {
                    printJob.addObject(thePrintView);
                }
                // Otherwise, the job requires multiple pages.
                else
                {
                    // Create the first page and add it to the print job.
                    thePrintView.showPage("first");
                    printJob.addObject(thePrintView);
                    thePrintView.pageNumber++;
                    // Loop through the following code until all pages are queued.
                    while(true)
                    {
                        // Move the next page of data to the top of the print grid.
                        thePrintView.dataGrid.nextPage();
                        thePrintView.showPage("last");
                        // If the page holds the remaining data, or if the last page
                        // was completely filled by the last grid data, queue it for printing.
                        // Test if there is data for another PrintDataGrid page.
                        if(!thePrintView.dataGrid.validNextPage)
                        {
                            // This is the last page; queue it and exit the print loop.
                            printJob.addObject(thePrintView);
                            break;
                        }
                        else
                        // This is not the last page. Queue a middle page.
                        {
                            thePrintView.showPage("middle");
                            printJob.addObject(thePrintView);
                            thePrintView.pageNumber++;
                        } // else
                    } // while
                } // else
                // All pages are queued; remove the FormPrintView control to free memory.
                Application.application.removeChild(thePrintView);
            } // if
            
            // Send the job to the printer.
            printJob.send();

		}  // imprimirDatagrid
	
	// ------------------------------------------------------------------------------------------
	
	} // class
}	// package