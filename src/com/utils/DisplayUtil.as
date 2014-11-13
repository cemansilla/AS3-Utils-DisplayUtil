package com.utils {
	/**
	 * Esta clase provee métodos para manipular elementos en el Stage
	 * Es una clase estática por lo que no hay que instanciarla
	 * 
	 * Ejemplo de uso:
		 * DisplayUtil.clear(contenedor); 	// Vacia un contenedor
		 * DisplayUtil.remove(elemento);	// Elimina un elemento de su contenedor
	 */
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	/**
	 * ...
	 * @author Cesar
	 */
	public class DisplayUtil {
		
		/**
		 * Elimina un elemento de su contenedor
		 * @param	obj
		 */
		public static  function remove(obj:Object):void {
			if (obj) {
				if (obj is DisplayObject) {
					if (obj.parent) {
						try {
							obj.parent.removeChild(obj);
						} catch (e:Error) {
							// No se puede remover el objeto
							// No es un hijo de un DisplayObject
							trace("remove err (1)");
						}
					} else {
						// No se puede remover el objeto
						// Parent es null
						trace("remove err (2)");
					}
				} else {
					// No se puede remover el objeto
					// No es un hijo de un DisplayObject
					trace("remove err (3)");
				}
			} else {
				// No se puede remover el objeto
				// Objeto null o no existe
				trace("remove err (4)");
			}
		}

		/**
		 * Elimina todos los hijos que contenga el objeto pasado como parámetro
		 * @param	obj
		 */
		public static function clear(obj:DisplayObjectContainer):void {
			while ( obj.numChildren ) {
				obj.removeChildAt( obj.numChildren - 1 );
			}
		}

		/**
		 * Distribuye los elementos del contenedor en el eje X
		 * @param	parent
		 * @param	init
		 * @param	space
		 * @return  DisplayObjectContainer
		 */
		public static function layoutX( parent:DisplayObjectContainer, init:int=0, space:int = 5 ):DisplayObjectContainer {
			return DisplayUtil.layout( parent, init, space );
		}

		/**
		 * Distribuye los elementos del contenedor en el eje Y
		 * @param	parent
		 * @param	init
		 * @param	space
		 * @return  DisplayObjectContainer
		 */
		public static function layoutY( parent:DisplayObjectContainer, init:int=0, space:int = 5 ):DisplayObjectContainer {
			return DisplayUtil.layout( parent, init, space, false );
		}

		/**
		 * Distribuye los elementos del contenedor en un eje cartesiano
		 * @param	parent
		 * @param	init
		 * @param	space
		 * @return  DisplayObjectContainer
		 */
		public static function layout( parent:DisplayObjectContainer, init:int=0, space:int = 5, useX:Boolean = true ):DisplayObjectContainer {
			
			if ( parent.numChildren == 0 ) return parent;
			
			var axis:String = useX ? "x" : "y";
			var prop:String = useX ? "width" : "height";
			
			var n:int = init;
			for (var i:int = 0; i < parent.numChildren; i++) 
			{
				var item:DisplayObject = parent.getChildAt(i);
					item[axis] = n;
					n += item[prop] + space;				
			}
			return parent;
		}
		
		/**
		 * Filtra objetos de un contenedor que cumplan con todas las propiedades requeridas
		 * @param	parent
		 * @param	params
		 * @return  Array
		 */
		public static function filterChildren( parent:DisplayObjectContainer, params:Object ):Array {
			var filter:Array = [];
			for (var i:int = 0; i < parent.numChildren; i++) 
			{
				var item = parent.getChildAt(i);
				var lometo = true;
				for ( var propiedad:String in params ) {
					//trace( item, item[propiedad], params, params[propiedad] );
					if ( item[ propiedad ] != params[ propiedad ] ) {
						lometo = false;
						break;
					}
				}
				if ( lometo ) filter.push( item );
			}
			return filter;
		}
		
		/**
		 * Agrega a un contenedor los elementos pasados como parámetro en el array
		 * 
		 * @param	parent
		 * @param	children
		 * @return  DisplayObjectContainer
		 */
		public static function addChildren( parent:DisplayObjectContainer, children:Array ):DisplayObjectContainer {
			for (var i:int = 0; i < children.length; i++) 
			{
				var item:DisplayObject = children[i];
				parent.addChild( item );				
			}
			return parent;
		}
		
		/**
		 * Lleva los elementos de un contenedor a otro
		 * @param	parent
		 * @param	parent2
		 */
		public static function kidnapChildren( parent:DisplayObjectContainer, parent2:DisplayObjectContainer ):void {
			var hijos = DisplayUtil.filterChildren( parent, { } )
			DisplayUtil.addChildren( parent2, hijos );
		}
	}
 
}