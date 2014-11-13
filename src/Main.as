package 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import com.utils.DisplayUtil;
	
	/**
	 * ...
	 * @author Cesar
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);

			// Your code...
			// Vacio el contenedor con el método clear de la clase
			vaciar();

			// Instancio y ubico mis elementos
			var elemento1:MovieClip = new mc_3();
			var elemento2:MovieClip = new mc_4();
			var elemento3:MovieClip = new mc_5();

			elemento1.x = 150;
			elemento1.y = 150;

			elemento2.x = 75;
			elemento2.y = 10;
			elemento2.name = "yoquedo";

			elemento3.x = 20;
			elemento3.y = 200;

			// Los agrego al stage con el metodo addChildren de la clase
			var array_elementos:Array = new Array();
			array_elementos.push(elemento1, elemento2, elemento3);			
			DisplayUtil.addChildren(mc_contenedor, array_elementos);

			// Elimino la estrella
			btn_estrella.addEventListener(MouseEvent.CLICK, eliminarEstrella);

			// Elimino todos los elementos
			btn_vaciar.addEventListener(MouseEvent.CLICK, vaciar);

			// Distribuyo los elementos en el eje X
			btn_layoutx.addEventListener(MouseEvent.CLICK, distribuirX);
			
			// Distribuyo los elementos en el eje Y
			btn_layouty.addEventListener(MouseEvent.CLICK, distribuirY);
			
			// Filtro ciertos elementos
			btn_filtrar.addEventListener(MouseEvent.CLICK, filtrar);
			
			// Muevo los elementos de un contenedor a otro
			btn_mover.addEventListener(MouseEvent.CLICK, mover);
			
			// Reseteo los elementos
			btn_reset.addEventListener(MouseEvent.CLICK, init);			
		}
		
		private function mover(e:MouseEvent):void 
		{
			DisplayUtil.kidnapChildren(mc_contenedor, mc_contenedor_2);
		}
		
		private function filtrar(e:MouseEvent):void 
		{
			// Para la prueba quiero solo aquellos cuyo nombre sea "yoquedo" y estén en la posicion x = 75
			var test:Array = DisplayUtil.filterChildren(mc_contenedor, { name:"yoquedo", x:75 } );
			
			trace(test);
		}
		
		private function distribuirX(e:MouseEvent):void 
		{
			DisplayUtil.layoutX(mc_contenedor);
		}

		private function distribuirY(e:MouseEvent):void 
		{
			DisplayUtil.layoutY(mc_contenedor);
		}

		private function vaciar(e:MouseEvent = null):void 
		{
			DisplayUtil.clear(mc_contenedor);
			DisplayUtil.clear(mc_contenedor_2);
		}

		private function eliminarEstrella(e:MouseEvent):void 
		{
			DisplayUtil.remove(mc_estrella);
		}		
	}	
}