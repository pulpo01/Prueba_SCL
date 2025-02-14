package user.libreria.clases
{
   import com.as3xls.xls.ExcelFile;
   import com.as3xls.xls.Sheet;
   
   import flash.errors.IllegalOperationError;
   import flash.net.FileReference;
   import flash.utils.ByteArray;
   
   import mx.charts.chartClasses.ChartBase;
   import mx.collections.ArrayCollection;
   import mx.collections.ICollectionView;
   import mx.collections.IViewCursor;
   import mx.collections.XMLListCollection;
   import mx.controls.AdvancedDataGrid;
   import mx.controls.Alert;
   import mx.controls.DataGrid;
   import mx.controls.OLAPDataGrid;

   /**
    *
    * Lista de funciones
    * <list>
    *  fromGrid:          Exporta un datagrid a un excel de forma automática
    *  fromChart:         Exporta un gráfico a un excel de forma automática
    *  fromObject:       Exporta un listado de objetos XML, XMLList, Array o ICollectionView
    *  export:            Exporta los datos q se le pasen delegando a la tarea a la funcion
    *                   correspondiente dependiendo el proveedor de datos
    * </list>

    * 

    */

    

   public class ExcelExport

   {

      public function ExcelExport()

      {

         throw new IllegalOperationError("Class \"ExcelExporterUtil\" is static. You can't instance this");

      }

      

      //-----------------------------

      // Public function

      //-----------------------------

      /**

       * 

       * Exporta los datos de un datagrid hacia un Excel.

       * Toma el dataProvider del mismo y las columnas para su exportación.

       * 

       * @param grid                Referencia al DataGrid, AdvancedDataGrid u OLAPDataGrid

       * @param defaultName         Nombre default con el q se va a generar el archivo excel

       * @param params            Parámetros opcionales

       *                         {

       *                            extraDataBefore:Listado de columnas extras (a colocar antes de las columnas del datagrid) 

       *                                        a las columnas del datagrid. Su dato se encuentra en el dataprovider 

       *                                        del datagrid.

       *                                        Formato:

       *                                        [{header:"nombre del header", value:"propiedad del objeto que contiene el valor"}]

       *                            extraDataAfter:Listado de columnas extras (a colocar luego de las columnas del datagrid)

       *                                        a las columnas del datagrid. Su dato se encuentra en el dataprovider 

       *                                        del datagrid.

       *                                        Formato:

       *                                        [{header:"nombre del header", value:"propiedad del objeto que contiene el valor"}]

       *                         }

       * 

       */

      static public function fromGrid(grid:*, defaultName:String, params:Object):void 

      {

         if ( !(grid is DataGrid) && !(grid is AdvancedDataGrid) && !(grid is OLAPDataGrid) )

            return;

         

         if (grid == null || grid.dataProvider == null || defaultName == null || defaultName == "")

            throw new ArgumentError("ExcelExporterUtil.datagridToExcel. Error in arguments");

         
		if( null != params){
			
	         var colsValues2:Array = (params.hasOwnProperty("colsValues"))?params.colsValues:[];
	
	         var extraSeriesBefore:Array = (params.hasOwnProperty("extraDataBefore"))?params.extraDataBefore:[];
	
	         if ( extraSeriesBefore.length > 0 && colsValues2.length > 0 )
	
	            extraSeriesBefore = extraSeriesAfter.concat(colsValues2);
	
	         else if (extraSeriesBefore.length == 0 && colsValues2.length > 0 )
	
	            extraSeriesBefore = colsValues2;
	
	         var extraSeriesAfter:Array = (params.hasOwnProperty("extraDataAfter"))?params.extraDataAfter:[];
	         
		}

         var colsValues:Array = ExcelExport.generateColsValues(

                                                   grid.columns, 

                                                   "headerText", 

                                                   "dataField", 

                                                   extraSeriesBefore, 

                                                   extraSeriesAfter

                                                   );



         if ( colsValues.length == 0 )

            return;

            

         ExcelExport.fromObject(grid.dataProvider, defaultName, {colsValues:colsValues});

      }

      

      /**

       * 

       * Exporta los datos de un gráfico de flex hacia un Excel.

       * Toma el dataProvider del mismo y las series para su exportación.

       * 

       * @param chart                Referencia al datagrid

       * @param defaultName         Nombre default con el q se va a generar el archivo excel

       * @param params            Parámetros opcionales

       *                         {

       *                            extraDataBefore:Listado de series extras (a colocar antes de las series del chart) 

       *                                        a las series del chart. Su dato se encuentra en el dataprovider 

       *                                        del datagrid.

       *                                        Formato:

       *                                        [{header:"nombre del header", value:"propiedad del objeto que contiene el valor"}]

       *                            extraDataAfter:Listado de series extras (a colocar luego de las series del chart)

       *                                        a las series del chart. Su dato se encuentra en el dataprovider 

       *                                        del chart.

       *                                        Formato:

       *                                        [{header:"nombre del header", value:"propiedad del objeto que contiene el valor"}]

       *                         }

       * 

       */

      static public function fromChart(chart:ChartBase, defaultName:String, params:Object):void

      {

         if ( chart == null || chart.dataProvider == null || chart.dataProvider.length < 1 || 

            chart.series == null || chart.series.length < 1 || 

            defaultName == null || defaultName == "" )

            throw new ArgumentError("ExcelExporterUtil.graphToExcel. Error in arguments");

         

         var colsValues2:Array = (params.hasOwnProperty("colsValues"))?params.colsValues:[];

         var extraColumsBefore:Array = (params.hasOwnProperty("extraDataBefore"))?params.extraDataBefore:[];

         if ( extraColumsBefore.length > 0 && colsValues2.length > 0 )

            extraColumsBefore = extraColumsBefore.concat(colsValues2);

         else if (extraColumsBefore.length == 0 && colsValues2.length > 0 )

            extraColumsBefore = colsValues2;

         var extraColumnsAfter:Array = (params.hasOwnProperty("extraDataAfter"))?params.extraDataAfter:[];

         

         var colsValues:Array = ExcelExport.generateColsValues(

                                                chart.series, 

                                                "displayName", 

                                                "yField", 

                                                extraColumsBefore, 

                                                extraColumnsAfter);

         if ( colsValues.length == 0 )

            return;

            

         ExcelExport.fromObject(chart.dataProvider, defaultName, {colsValues:colsValues});

      }

      

      /**

       * 

       * Export to Excell

       * 

       * @param obj          Objeto simple, XML, XMLList, Array, ArrayCollection o XMLListCollection

       *                   que se quiere exportar a excel

       * @param defaultName   Nombre default con el que se genera el excel exportToFile

       * @param params      Listado de objetos que indican cual es el nombre de la columna

       *                   y que propiedad del objeto se utiliza para sacar los datos de la columna

       *                   {header:"nombre del header", value:"propiedad del objeto que contiene el valor"}

       * 

       */

      static public function fromObject(obj:Object, defaultName:String, params:Object):void

      {

         if ( !(obj is XML) && !(obj is XMLList) && !(obj is XMLList) && !(obj is Array) && !(obj is ICollectionView) )

            return;

         

         var colsValues:Array = (params.hasOwnProperty("colsValues"))?params.colsValues:null;

         

         if ( colsValues == null || colsValues.length == 0 )

            return;

         

         var _dp:ICollectionView = ExcelExport.getDataProviderCollection(obj);

         if ( _dp == null )

            return;

            

         ExcelExport.exportToExcel(_dp, colsValues, defaultName);

      }

      

      /**

       * 

       * Realiza la exportacion de datos a excell

       * 

       * @param obj      Referencia a un objeto con datos a exportar

       * @param obj      Nombre default del archivo

       * @param params   Datos opcionales dependiendo de lo que se quiera exportar.

       * 

       */

      static public function export(obj:Object, defaultName:String, params:Object = null):void

      {

         if (obj == null || defaultName == null || defaultName == "")

         {

            return

         }

         else if ( obj is ChartBase )

         {

            ExcelExport.fromChart(

                     obj as ChartBase, 

                     defaultName, 

                     params

                     );

         }

         else if (obj is DataGrid || obj is AdvancedDataGrid || obj is OLAPDataGrid)

         {

            ExcelExport.fromGrid(

                        obj, 

                        defaultName, 

                        params

                        )

         } 

         else if (obj is XML || obj is XMLList || obj is Array || obj is ICollectionView)

         {

            ExcelExport.fromObject(

                        obj, 

                        defaultName,

                        params

                        );

         }

         

         return;

      }

      

      //-----------------------------

      // Private function

      //-----------------------------

      /**

       * 

       * Genera el archivo excel a partir de una colección de datos

       * 

       * @param obj          Colección de datos

       * @colsValues         Listado de objetos que indican cual es el nombre de la columna

       *                   y que propiedad del objeto se utiliza para sacar los datos de la columna

       *                   {header:"nombre del header", value:"propiedad del objeto que contiene el valor"}

       * @param defaultName   Nombre default con el que se genera el excel exportToFile

       * 

       */

      static private function exportToExcel(obj:ICollectionView, colsValues:Array, defaultName:String):void

      {

         if ( obj == null || colsValues == null || colsValues.length == 0)

            return;

         

         var rows:Number = 0;

         var cols:Number = 0;

         var cantCols:Number = colsValues.length;
         var sheet:Sheet = new Sheet();
  
         sheet.resize(obj.length+1, colsValues.length);

         for ( ; cols < cantCols; cols++)
		 {
		 	
		 	//Quita los acentos
			var newPalabraH:String = sinAcentos(colsValues[cols].header);
		 	sheet.setCell(rows, cols, newPalabraH);
            //sheet.setCell(rows, cols, colsValues[cols].header);
         }
         
         cols = 0;

         rows++;

         var cursor:IViewCursor = obj.createCursor();

         while ( !cursor.afterLast )
         {

            for (cols = 0 ; cols < cantCols; cols++)
			{

               if ( (cursor.current as Object).hasOwnProperty(colsValues[cols].value) ){
			
					//Quita los acentos
					var newPalabraL:String = sinAcentos(colsValues[cols].value);
					var newValor:String = "";
					if( null != ((cursor.current as Object)[newPalabraL]) ){
						newValor = sinAcentos(((cursor.current as Object)[newPalabraL]).toString());
					}else{
						newValor = "-";
					}
					
					//Se valida que no convierta hexadecimal
					newValor = valFormatoDato(newValor, newPalabraL);
					
					sheet.setCell(rows, cols, newValor);
					//sheet.setCell(rows, cols, Formatter.format(newValor, "Text"));
					 
                    //sheet.setCell(rows, cols, (cursor.current as Object)[colsValues[cols].value]);
                   
				}
				
            }


            rows++;

            cursor.moveNext();

         }

         var xls:ExcelFile = new ExcelFile();

         xls.sheets.addItem(sheet);
 
         var bytes:ByteArray = xls.saveToByteArray();
		 
		try{
        	var fr:FileReference = new FileReference();
		}catch (error:Error) {
			Alert.show("Debe cerrar el archivo Excel.","Avertencia");
		}
		
         fr.save(bytes, defaultName);
      
      }

      /**

       * 

       * A partir de un elemento pasado se genera un ICollectionView

       * para su correcto recorrido

       * 

       * @param obj         Objeto a convertir a ICollectionView

       * 

       * 

       * @return referencia a un ICollectionView. 

       * 

       */

      static private function getDataProviderCollection(obj:Object):ICollectionView

      {

         if ( (obj is Number && isNaN(obj as Number)) || (!(obj is Number) && obj == null))

         {

            return null;

         }

         else if ( obj is ICollectionView )

         {

            return obj as ICollectionView;

         }

         else if ( obj is Array )

         {

            return new ArrayCollection(obj as Array);

         }

         else if ( obj is XMLList )

         {

            return new XMLListCollection(obj as XMLList);

         }

         else if ( obj is XML )

         {

            var col:XMLListCollection = new XMLListCollection();

            col.addItem(obj);

            return col;

         }

         else if ( obj is Object )

         {

            return new ArrayCollection([obj]);

         }

         else

         {

            return null;

         }

      }

      

      /**

       * {header:nombre de la columna, value:nombre de la propiedad del objeto}

       */

      static private function generateColsValues(dp:Array, headerName:String, valueName:String, extraColumsBefore:Array = null, extraColumnsAfter:Array = null):Array

      {

         var cant:Number = dp.length;

         var colsValues:Array = [];

         var fieldT:String;

         var headerT:String;

         

         for (var i:Number = 0; i < cant; i++)

         {

            if (dp[i].hasOwnProperty(headerName) && dp[i].hasOwnProperty(valueName))

            {

               headerT = dp[i][headerName];

               fieldT = dp[i][valueName];

               if ( fieldT == null || fieldT == "" || headerT == null || headerT == "" || dp[i].visible == false )

                  continue; 

               colsValues.push({

                           header:headerT,

                           value:fieldT

               });

            }

         }

         

         if ( extraColumsBefore && extraColumsBefore.length > 0 )

            colsValues = extraColumsBefore.concat(colsValues)

         if ( extraColumnsAfter && extraColumnsAfter.length > 0 )

            colsValues = colsValues.concat(extraColumnsAfter);

         

         return colsValues;

      }
      

	/* 
	 * Gabriel Moraga L.
	 * 05/08/2010
	 * Funcion para quitar los ancentos
	 *
	 */

	static private function sinAcentos(textoConAcentos:String):String {
			
			var texto1:String=textoConAcentos as String;
			//texto1=textoConAcentos.toLowerCase();
			var acentos:Array=new Array("á","é","í","ó","ú","ñ","Ñ");
			var sinAcentos:Array=new Array("a","e","i","o","u","n","N");
			
			for (var i:Number = 0; i < acentos.length; i++) {
				texto1=quitarAcentos(texto1,acentos[i],sinAcentos[i]);
			}
			
			return texto1;
	}
		
	static private function quitarAcentos(texto:String,letraSplit:String,letraCambio:String):String {
			
			var letras:Array=texto.split(letraSplit);
			var nuevoTexto:String=new String();
			
			for (var i:Number = 0;i < letras.length;i++) {
				nuevoTexto+=letras[i];
				nuevoTexto+=letraCambio;
			}
			
			nuevoTexto=nuevoTexto.substring(0,nuevoTexto.length-1);
			return nuevoTexto;
		
	}
	
	//Valida un campo para no conbertirlo en hexadecimal
	static private function valFormatoDato(texto:String, headtxt:String):String {
			trace("INICIO valFormatoDato:"+texto);
			//Si la variable no es NULL
			if(null != texto){
				trace("1");
				var nuevoTexto:String;
				//SI el largo es mayor a 10
				 if(texto.length>10){
				 	trace("2");
				 	var flag:Boolean = true;
				 	trace("3");
				 	try{
				 		trace("4");
				 		var numero:Number = new Number(texto);
				 	}catch (error:Error) {
				 		trace("5");
				 		flag = false;
					}
				 	trace("6 HEAD:"+headtxt);
				 	//SI es un numero
				 	if(flag && (headtxt == 'equiAntSerie' || headtxt == 'equiCamSerie' || headtxt == 'equiSerie') ){
				 		trace("7");
				 		nuevoTexto = "'"+texto+"";
				 		trace("FIN 1 valFormatoDato:"+nuevoTexto);
				 		return nuevoTexto;
				 	}else{
				 		trace("8");
				 		trace("FIN 2 valFormatoDato:"+texto);
				 		return texto;
				 	}
				 }else{
				 	trace("FIN 3 valFormatoDato:"+texto);
				 	return texto;
				 }
			
				
			}else{
				trace("FIN 4 valFormatoDato:"+texto);
				return texto;
			}
			
		
	}
		
	//Copia de del metodo fromGrid con modificacion de parametros

	static public function fromGridMulti(grid1:*, grid2:*, grid3:*, defaultName:String, params:Object, nomTit1:String, nomTit2:String, nomTit3:String, rp1OK:Boolean, rp2OK:Boolean, rp3OK:Boolean):void 

      {

         if ( !(grid1 is DataGrid) && !(grid1 is AdvancedDataGrid) && !(grid1 is OLAPDataGrid) )
            return;

		 if ( !(grid2 is DataGrid) && !(grid2 is AdvancedDataGrid) && !(grid2 is OLAPDataGrid) )
            return;
            
         if ( !(grid3 is DataGrid) && !(grid3 is AdvancedDataGrid) && !(grid3 is OLAPDataGrid) )
            return;
         
         if (grid1 == null || grid1.dataProvider == null || defaultName == null || defaultName == "")
            throw new ArgumentError("ExcelExporterUtil.datagridToExcel. Error in arguments");

		 if (grid2 == null || grid2.dataProvider == null)
            throw new ArgumentError("ExcelExporterUtil.datagridToExcel. Error in arguments");
            
         if (grid3 == null || grid3.dataProvider == null)
            throw new ArgumentError("ExcelExporterUtil.datagridToExcel. Error in arguments");
		
		if( null != params){
			
	         var colsValuesN:Array = (params.hasOwnProperty("colsValues"))?params.colsValues:[];
	
	         var extraSeriesBefore:Array = (params.hasOwnProperty("extraDataBefore"))?params.extraDataBefore:[];
	
	         if ( extraSeriesBefore.length > 0 && colsValuesN.length > 0 )
	
	            extraSeriesBefore = extraSeriesAfter.concat(colsValuesN);
	
	         else if (extraSeriesBefore.length == 0 && colsValuesN.length > 0 )
	
	            extraSeriesBefore = colsValuesN;
	
	         var extraSeriesAfter:Array = (params.hasOwnProperty("extraDataAfter"))?params.extraDataAfter:[];
	         
		}

         var colsValues1:Array = ExcelExport.generateColsValues(grid1.columns, "headerText", "dataField", extraSeriesBefore, extraSeriesAfter);
                                                   
         var colsValues2:Array = ExcelExport.generateColsValues(grid2.columns, "headerText", "dataField", extraSeriesBefore,  extraSeriesAfter);

		 var colsValues3:Array = ExcelExport.generateColsValues(grid3.columns, "headerText", "dataField", extraSeriesBefore,  extraSeriesAfter);

         if ( colsValues1.length == 0 )
            return;

         if ( colsValues2.length == 0 )
            return;
            
         if ( colsValues3.length == 0 )
            return;

         ExcelExport.fromObjectMulti(grid1.dataProvider, grid2.dataProvider, grid3.dataProvider, defaultName, {colsValues:colsValues1}, {colsValues:colsValues2}, {colsValues:colsValues3}, nomTit1, nomTit2, nomTit3, rp1OK, rp2OK, rp3OK );

      }


	  //Copia de del metodo fromObject con modificacion de parametros

	  static public function fromObjectMulti(obj1:Object, obj2:Object, obj3:Object, defaultName:String, params1:Object, params2:Object, params3:Object, nomTit1:String, nomTit2:String, nomTit3:String, rp1OK:Boolean, rp2OK:Boolean, rp3OK:Boolean):void

      {
      	
         if ( !(obj1 is XML) && !(obj1 is XMLList) && !(obj1 is XMLList) && !(obj1 is Array) && !(obj1 is ICollectionView) )
            return;
            
         if ( !(obj2 is XML) && !(obj2 is XMLList) && !(obj2 is XMLList) && !(obj2 is Array) && !(obj2 is ICollectionView) )
            return;

         if ( !(obj3 is XML) && !(obj3 is XMLList) && !(obj3 is XMLList) && !(obj3 is Array) && !(obj3 is ICollectionView) )
            return;

         var colsValues1:Array = (params1.hasOwnProperty("colsValues"))?params1.colsValues:null;

		 var colsValues2:Array = (params2.hasOwnProperty("colsValues"))?params2.colsValues:null;
		
		 var colsValues3:Array = (params3.hasOwnProperty("colsValues"))?params3.colsValues:null;
         
        

         if ( colsValues1 == null || colsValues1.length == 0 )
            return;
           
         if ( colsValues2 == null || colsValues2.length == 0 )
            return;
            
         if ( colsValues3 == null || colsValues3.length == 0 )
            return;

         var _dp1:ICollectionView = ExcelExport.getDataProviderCollection(obj1);
         
         var _dp2:ICollectionView = ExcelExport.getDataProviderCollection(obj2);
          
         var _dp3:ICollectionView = ExcelExport.getDataProviderCollection(obj3);

         if ( _dp1 == null )
            return;
            
         if ( _dp2 == null )
            return;
            
         if ( _dp3 == null )
            return;

         ExcelExport.exportToExcelMulti(_dp1, _dp2, _dp3, colsValues1, colsValues2, colsValues3, defaultName, nomTit1, nomTit2, nomTit3, rp1OK, rp2OK, rp3OK);

      }

	   //Copia de del metodo exportToExcel con modificacion de parametros

	   static private function exportToExcelMulti(obj1:ICollectionView, obj2:ICollectionView, obj3:ICollectionView, colsValues1:Array, colsValues2:Array, colsValues3:Array, defaultName:String, nomTit1:String, nomTit2:String, nomTit3:String, rp1OK:Boolean, rp2OK:Boolean, rp3OK:Boolean):void

      {
      	
        if ( obj1 == null || colsValues1 == null || colsValues1.length == 0)
            return;
	
		if ( obj2 == null || colsValues2 == null || colsValues2.length == 0)
            return;
            
        if ( obj3 == null || colsValues3 == null || colsValues3.length == 0)
            return;
         
		 var sheet:Sheet = new Sheet();
  		 var totalFila:Number = ( rp1OK ? obj1.length+1 : 0 ) + ( rp2OK ? obj2.length+1 : 0 ) + ( rp3OK ? obj3.length+1 : 0 )
  		 var totalColumna:Number = (rp1OK ? colsValues1.length : 0 ) + ( rp2OK ? colsValues2.length : 0 ) + ( rp3OK ? colsValues3.length : 0 )
         sheet.resize(totalFila+10, totalColumna+10);
         
         var rows:Number = 1;
         var cols:Number = 0;
         var colsReal:Number = 0;
         var colsRealFila:Number = 0;
         var cantCols:Number = 0;

		 var newPalabraH:String = "";
		 var newPalabraL:String = "";
		 
		 var newValor:String = "";
		
		 var cursor:IViewCursor = null;

		 if(rp1OK){

			/* Inicio Primera grilla */
	
	         cantCols = colsValues1.length;
	
			 //Titulo Grilla 1
			 sheet.setCell(0, cols, nomTit1);
	
	         for ( ; cols < cantCols; cols++)
			 {
			 	//Quita los acentos
				newPalabraH = sinAcentos(colsValues1[cols].header);
			 	sheet.setCell(rows, cols, newPalabraH);
	            //sheet.setCell(rows, cols, colsValues[cols].header);
	         }
	         colsReal = cols + 2;
	         cols = 0;
	         rows++;
	
	         cursor = obj1.createCursor();
	
	         while ( !cursor.afterLast )
	         {
	            for (cols = 0 ; cols < cantCols; cols++)
				{
	               if ( (cursor.current as Object).hasOwnProperty(colsValues1[cols].value) ){
						//Quita los acentos
						newPalabraL = sinAcentos(colsValues1[cols].value);
						
						if( null != ((cursor.current as Object)[newPalabraL]) ){
							newValor = sinAcentos(((cursor.current as Object)[newPalabraL]).toString());
						}else{
							newValor = "-";
						}
						
						//Se valida que no convierta hexadecimal
						newValor = valFormatoDato(newValor, newPalabraL);
						
						sheet.setCell(rows, cols, newValor);
	                    //sheet.setCell(rows, cols, (cursor.current as Object)[colsValues[cols].value]);
					}
	            }
	
	            rows++;
	            cursor.moveNext();
	         }
	
			/* Fin Primera grilla */
		}
		
		if(rp2OK){
			/* Inicio Seguda grilla */
	
	         rows = 1;
	         cols = 0;
	         cantCols = 0;
	
			 newPalabraH = "";
			 newPalabraL = "";
			
			 cursor = null;
			 
	         cantCols = colsValues2.length;
	
			 colsRealFila = colsReal;
	
			 //Titulo Grilla 2
			 sheet.setCell(0, colsReal, nomTit2);
	
	         for ( ; cols < cantCols; cols++, colsReal++)
			 {
			 	//Quita los acentos
				newPalabraH = sinAcentos(colsValues2[cols].header);
			 	sheet.setCell(rows, colsReal, newPalabraH);
	            //sheet.setCell(rows, cols, colsValues[cols].header);
	         }
	         
	         colsReal = colsRealFila;
	         
	         cols = 0;
	         rows++;
				
	         cursor = obj2.createCursor();
	
	         while ( !cursor.afterLast )
	         {
	         	
	         	colsRealFila = colsReal;
	         	
	            for ( cols = 0 ; cols < cantCols; cols++, colsRealFila++)
				{
	               if ( (cursor.current as Object).hasOwnProperty(colsValues2[cols].value) ){
						//Quita los acentos
						newPalabraL = sinAcentos(colsValues2[cols].value);
						
						if( null != ((cursor.current as Object)[newPalabraL]) ){
							newValor = sinAcentos(((cursor.current as Object)[newPalabraL]).toString());
						}else{
							newValor = "-";
						}
						
						//Se valida que no convierta hexadecimal
						newValor = valFormatoDato(newValor, newPalabraL);
						
						sheet.setCell(rows, colsRealFila, newValor);
	                    //sheet.setCell(rows, cols, (cursor.current as Object)[colsValues[cols].value]);
					}
	            }
	
	            rows++;
	            cursor.moveNext();
	         }
	         
			colsReal = colsRealFila + 2;
			
			/* Fin Segunda grilla */
		}
		
		if(rp3OK){
			/* Inicio Tercera grilla */
	
	         rows = 1;
	         cols = 0;
	         cantCols = 0;
	
			 newPalabraH = "";
			 newPalabraL = "";
			
			 cursor = null;
	
	         cantCols = colsValues3.length;
	
			 colsRealFila = colsReal;
	
			 //Titulo Grilla 3
	         sheet.setCell(0, colsReal, nomTit3);
	
	         for ( ; cols < cantCols; cols++, colsReal++)
			 {
			 	//Quita los acentos
				newPalabraH = sinAcentos(colsValues3[cols].header);
			 	sheet.setCell(rows, colsReal, newPalabraH);
	            //sheet.setCell(rows, cols, colsValues[cols].header);
	         }
	      
	         colsReal = colsRealFila;
	      
	         cols = 0;
	         rows++;
	
	         cursor = obj3.createCursor();
	
	         while ( !cursor.afterLast )
	         {
	         	
	         	colsRealFila = colsReal;
	         	
	            for (cols = 0 ; cols < cantCols; cols++, colsRealFila++)
				{
	               if ( (cursor.current as Object).hasOwnProperty(colsValues3[cols].value) ){
						//Quita los acentos
						newPalabraL = sinAcentos(colsValues3[cols].value);

						if( null != ((cursor.current as Object)[newPalabraL]) ){
							newValor = sinAcentos(((cursor.current as Object)[newPalabraL]).toString());
						}else{
							newValor = "-";
						}

						//Se valida que no convierta hexadecimal
						newValor = valFormatoDato(newValor, newPalabraL);

						sheet.setCell(rows, colsRealFila, newValor);
	                    //sheet.setCell(rows, cols, (cursor.current as Object)[colsValues[cols].value]);
					}
	            }
	
	            rows++;
	            cursor.moveNext();
	         }
	
			/* Fin Tercera grilla */
		 }
		 
         var xls:ExcelFile = new ExcelFile();

         xls.sheets.addItem(sheet);
 
         var bytes:ByteArray = xls.saveToByteArray();
		 
		try{
        	var fr:FileReference = new FileReference();
		}catch (error:Error) {
			Alert.show("Debe cerrar el archivo Excel.","Avertencia");
		}
		
         fr.save(bytes, defaultName);
         
      
      }

   }

}