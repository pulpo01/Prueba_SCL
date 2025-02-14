/**
 * CargaCambioDatosTributariosClienteDTO.as
 * This file was auto-generated from WSDL by the Apache Axis2 generator modified by Adobe
 * Any change made to this file will be overwritten when the code is re-generated.
 */
package generated.webservices.orquestador
{
	import mx.utils.ObjectProxy;
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	import mx.collections.ICollectionView;
	import mx.rpc.soap.types.*;
	/**
	 * Typed array collection
	 */

	public class CargaCambioDatosTributariosClienteDTO extends ArrayCollection
	{
		/**
		 * Constructor - initializes the array collection based on a source array
		 */
        
		public function CargaCambioDatosTributariosClienteDTO(source:Array = null)
		{
			super(source);
		}
        
        
		public function addCategoriaImpositivaVOAt(item:CategoriaImpositivaVO,index:int):void 
		{
			addItemAt(item,index);
		}

		public function addCategoriaImpositivaVO(item:CategoriaImpositivaVO):void 
		{
			addItem(item);
		} 

		public function getCategoriaImpositivaVOAt(index:int):CategoriaImpositivaVO 
		{
			return getItemAt(index) as CategoriaImpositivaVO;
		}

		public function getCategoriaImpositivaVOIndex(item:CategoriaImpositivaVO):int 
		{
			return getItemIndex(item);
		}

		public function setCategoriaImpositivaVOAt(item:CategoriaImpositivaVO,index:int):void 
		{
			setItemAt(item,index);
		}

		public function asIList():IList 
		{
			return this as IList;
		}
        
		public function asICollectionView():ICollectionView 
		{
			return this as ICollectionView;
		}
	}
}
