package user.libreria.clases
{
	import mx.collections.ArrayCollection;
	import mx.controls.AdvancedDataGrid;
	import mx.controls.Alert;
	
	/*
	import org.alivepdf.colors.RGBColor;
	import org.alivepdf.data.Grid;
	import org.alivepdf.display.Display;
	import org.alivepdf.drawing.Joint;
	import org.alivepdf.layout.Orientation;
	import org.alivepdf.layout.Size;
	import org.alivepdf.layout.Unit;
	import org.alivepdf.pdf.PDF;
	import org.alivepdf.saving.Method;
	import org.alivepdf.fonts.FontFamily;
	*/
	
	public class UtilDataGrid
	{
		public function UtilDataGrid()
		{
		}

		[Embed(source="/recursosInterfaz/imagenes/iconos/alert/warning.png")]
	    static public var iconWarning:Class; 		
		
		static public function sumarColumnaDatagrid(ac:ArrayCollection, nomColumna:String):Number	{
			
			var total:Number = 0;
			for(var fila:Number=0; fila < ac.length; fila++)
				total+= ac[fila][nomColumna];
			
			return total;
			
		} // sumarColumnaDatagrid
		
		// ------------------------------------------------------------------------------------------
		// Autor : Gabriel Galetti
		// Version : 1.0
		// Fecha : 26/01/09
		// ------------------------------------------------------------------------------------------
		static public function anchosColumnas(grid:AdvancedDataGrid):Array {
			
			var anchoCol:int; 
			var anchoColsGrid:Array = new Array();
	  		for (var i:int=0; i < grid.columns.length; i++)	{
	  			anchoCol = grid.columns[i].width/4;
	  			anchoColsGrid.push(anchoCol);
	  		}
	  		
	  		return anchoColsGrid;
	  					
		} // anchosColumnas
		
		/*
		
		// ------------------------------------------------------------------------------------------
		// Autor : Gabriel Galetti
		// Version : 1.1
		// Fecha : 22/10/08
		// ------------------------------------------------------------------------------------------
		static public function copyDatagridToClipboard(grid:AdvancedDataGrid):void	{

			if (grid.selectedIndices.length==0) {
				Alert.show("No se han seleccionado filas de la grilla.","Advertencia del sistema", Alert.OK);
				return;
			}
			
			var rows:Array = new Array(grid.selectedIndices);
			var colArray:Array = new Array();
			
			var tabla:String = new String();
			tabla = "<table border=1 width='100%'>";

			tabla = tabla + "<tr bgcolor='" + StringUtil.getValor("ExcelBgColorTitulos","VALOR") + "'>";
			var colum:AdvancedDataGridColumn = new AdvancedDataGridColumn();
			for( var col:int = 0; col < grid.columns.length; col++ )	{
				colum = grid.columns[col];
				if (colum.width > 0)	{
					tabla = tabla + "<td>" + colum.headerText + "</td>";
					colArray.push(colum.dataField);
				} // if
			}
			tabla = tabla + "</tr>";
	
			for( var i:int = 0; i < rows[0].length; i++ )	{
				tabla = tabla + "<tr bgcolor='" + StringUtil.getValor("ExcelBgColorDatos","VALOR") + "'>"
				var row:Object = new Object();
				row = grid.dataProvider[rows[0][i]];
				
				for (var colIndice:int = 0; colIndice < colArray.length; colIndice++)	{
					if (row[colArray[colIndice]] != null)
						tabla = tabla + "<td>" + row[colArray[colIndice]] + "</td>";
					else
						tabla = tabla + "<td></td>";
				} // for

				tabla = tabla + "</tr>";
			}  // for
		
			tabla = tabla + "</table>";
			System.setClipboard(tabla);
			Alert.show("Se guardaron las filas seleccionadas en el portapapeles  para ser pegadas en Excel.","Advertencia del sistema", Alert.OK);

		} // copyDatagridToClipboard

		*/
	
		// ------------------------------------------------------------------------------------------
		// Autor : Gabriel Galetti
		// Version : 1.0
		// Fecha : 22/10/08
		// ------------------------------------------------------------------------------------------
			
		static public function selectAll(grid:AdvancedDataGrid, cantidad:int):void	{

			var everything:Array = new Array();
			for( var i:int = 0; i < cantidad; i++ ){
				everything[i] = i;
			}
			grid.selectedIndices = everything;				

		} // selectAll

		// ------------------------------------------------------------------------------------------
		// Autor : Gabriel Galetti
		// Version : 1.0
		// Fecha : 22/10/08
		// ------------------------------------------------------------------------------------------

		static public function selectNone(grid:AdvancedDataGrid):void	{
			grid.selectedIndices = []; 
		} // selectNone


		// ------------------------------------------------------------------------------------------
		// Autor : Gabriel Galetti
		// Version : 1.0
		// Fecha : 23/01/08
		// ------------------------------------------------------------------------------------------
/*
		static public function exportDatagridToPdf(url:String, grid:AdvancedDataGrid, pantalla:*, titulo:String, subTitulo:String, anchoColsGrid:Array  ):void	{

			if (grid.selectedIndices.length==0) {
				Alert.show( "No se han seleccionado filas de la grilla.", 
						"Advertencia", 
						mx.controls.Alert.OK,
						pantalla,
						null,
						iconWarning,
						mx.controls.Alert.OK );
				return;
			} // if

			var rows:Array = new Array(grid.selectedIndices);
			var colArray:Array = new Array();
	
			var pdf:PDF = new PDF( Orientation.PORTRAIT, Unit.MM, Size.LETTER );
			pdf.setDisplayMode ( Display.FULL_WIDTH ); 
 			pdf.addPage();

			pdf.setXY(10,10);
			pdf.setFont( FontFamily.HELVETICA, "B", 12 );                                   
			pdf.writeText(15, titulo)
			pdf.newLine(10);
			pdf.setFont( FontFamily.HELVETICA, "B", 10 );                                   
			pdf.writeText(15, subTitulo)
			pdf.newLine(10);
			pdf.newLine(10);

			// Imprimir encabezados
			var anchoCol:int; 
			for( var col:int = 0; col < grid.columns.length; col++ )
				if (grid.columns[col].visible)	{
					pdf.addCell(parseInt(anchoColsGrid[col]), 10, grid.columns[col].headerText, 1, 0);
					colArray.push(grid.columns[col].dataField);
				} // if
		
			// Imprimir la data
			for( var i:int = 0; i < rows[0].length; i++ )	{
				var row:Object = new Object();
				row = grid.dataProvider[rows[0][i]];
				
				pdf.newLine(7);
				for (var colIndice:int = 0; colIndice < colArray.length; colIndice++)	{
					pdf.setFont(FontFamily.HELVETICA, '', 7);
  					pdf.textStyle ( new RGBColor ( 0x000000 ) );

					if (row[colArray[colIndice]] != null)
						pdf.addCell(anchoColsGrid[colIndice], 7, row[colArray[colIndice]], 1, 0);
					else	
						pdf.addCell(anchoColsGrid[colIndice], 7, "", 1, 0);
				} // for
			}  // for
		
			pdf.end();
			pdf.save( Method.REMOTE, url, "consulta.pdf" );				

		} // exportDatagridToPdf
*/		

	    // ------------------------------------------------------------------------------------------
		// Autor : Gabriel Moraga
		// Version : 2.0
		// Fecha : 05/08/2010
		// ------------------------------------------------------------------------------------------

		static public function copyDatagridToClipboard(grid:AdvancedDataGrid, nombre:String):void
		{
			
			if(grid.dataProvider.length < 1){
	        	Alert.show("No existen datos en la tabla para ser exportados.","Avertencia");
	         	return;
	        }
			
			var finalNombre:String;
			
			finalNombre = nombre + ".xls";
			
	    	ExcelExport.fromGrid(grid, finalNombre, null);
	    }
	    
	    // ------------------------------------------------------------------------------------------
		// Autor : Gabriel Moraga
		// Version : 2.0
		// Fecha : 26/08/2010
		// ------------------------------------------------------------------------------------------

		static public function exportAdvancedDataGrid(grid1:AdvancedDataGrid, grid2:AdvancedDataGrid, grid3:AdvancedDataGrid, nombre:String, rp1:String, rp2:String, rp3:String):void
		{
			
			var excelOk:int = 0;
			var rp1OK:Boolean = true;
			var rp2OK:Boolean = true;
			var rp3OK:Boolean = true;
			
			if(grid1.dataProvider.length < 1){
	        	excelOk = excelOk + 1;
	        	rp1OK = false;
	        }
	        if(grid2.dataProvider.length < 1){
	        	excelOk = excelOk + 1;
	        	rp2OK = false;
	        }
	        if(grid3.dataProvider.length < 1){
	        	excelOk = excelOk + 1;
	        	rp3OK = false;
	        }
			
			if(excelOk == 3){
				Alert.show("No existen datos en las tablas para ser exportados.","Avertencia");
	         	return;
			}
			trace("rp1OK:"+rp1OK);
			trace("rp2OK:"+rp2OK);
			trace("rp3OK:"+rp3OK);
			var finalNombre:String;
			
			finalNombre = nombre + ".xls";
			
	    	ExcelExport.fromGridMulti(grid1, grid2, grid3, finalNombre, null, rp1, rp2, rp3, rp1OK, rp2OK, rp3OK);
	    }

	} // UtilDataGrid
	
}