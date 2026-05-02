package scripts;

import com.stencyl.graphics.G;
import com.stencyl.graphics.BitmapWrapper;
import com.stencyl.graphics.ScaleMode;

import com.stencyl.behavior.Script;
import com.stencyl.behavior.Script.*;
import com.stencyl.behavior.ActorScript;
import com.stencyl.behavior.SceneScript;
import com.stencyl.behavior.TimedTask;

import com.stencyl.models.Actor;
import com.stencyl.models.GameModel;
import com.stencyl.models.actor.Animation;
import com.stencyl.models.actor.ActorType;
import com.stencyl.models.actor.Collision;
import com.stencyl.models.actor.Group;
import com.stencyl.models.Scene;
import com.stencyl.models.Sound;
import com.stencyl.models.Region;
import com.stencyl.models.Font;

import com.stencyl.Config;
import com.stencyl.Engine;
import com.stencyl.Input;
import com.stencyl.Key;
import com.stencyl.utils.motion.*;
import com.stencyl.utils.Utils;

import openfl.ui.Mouse;
import openfl.display.Graphics;
import openfl.display.BlendMode;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.filters.BitmapFilter;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.events.TouchEvent;
import openfl.net.URLLoader;

import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2Fixture;
import box2D.dynamics.joints.B2Joint;
import box2D.collision.shapes.B2Shape;

import com.stencyl.graphics.shaders.BasicShader;
import com.stencyl.graphics.shaders.GrayscaleShader;
import com.stencyl.graphics.shaders.SepiaShader;
import com.stencyl.graphics.shaders.InvertShader;
import com.stencyl.graphics.shaders.GrainShader;
import com.stencyl.graphics.shaders.ExternalShader;
import com.stencyl.graphics.shaders.InlineShader;
import com.stencyl.graphics.shaders.BlurShader;
import com.stencyl.graphics.shaders.SharpenShader;
import com.stencyl.graphics.shaders.ScanlineShader;
import com.stencyl.graphics.shaders.CSBShader;
import com.stencyl.graphics.shaders.HueShader;
import com.stencyl.graphics.shaders.TintShader;
import com.stencyl.graphics.shaders.BloomShader;



class SceneEvents_3 extends SceneScript
{
	public var _habloConNPC:Bool;
	public var _medallas:Float;
	public var _permisoPortal:Bool;
	public var _firedNpc:Bool;
	public var _firedPortal:Bool;
	public var _mensajeHUD:String;
	public var _mensajeTimer:Float;
	
	/* ======================== When Updating ========================= */
	public function _event_Chequeo(elapsedTime:Float):Void
	{
		if(wrapper.enabled && true)
		{
			var p=getActor(0); var g=getActor(7); var po=getActor(5); var fog:haxe.io.Bytes=untyped Engine._fogData; if(fog==null){fog=haxe.io.Bytes.alloc(3600); untyped Engine._fogData=fog;} var mt:Int=(untyped Engine._l2MsgTimer==null)?0:Std.parseInt(Std.string(untyped Engine._l2MsgTimer)); if(mt>0){mt--; if(mt<0)mt=0; untyped Engine._l2MsgTimer=mt;} if(p!=null){var pcx:Int=Std.int(p.getXCenter()/16); var pcy:Int=Std.int(p.getYCenter()/16); for(cy in (pcy-2)...(pcy+3)){for(cx in (pcx-2)...(pcx+3)){if(cx>=0&&cx<80&&cy>=0&&cy<45){fog.set(cy*80+cx,1);}}}} if(untyped Engine._dialogActive==true){var dAuto:Int=(untyped Engine._dialogAuto==null)?0:Std.parseInt(Std.string(untyped Engine._dialogAuto)); if(dAuto>0){dAuto--; if(dAuto<0)dAuto=0; untyped Engine._dialogAuto=dAuto;} if(dAuto<=0){untyped Engine._dialogActive=false; if(untyped Engine._pendingBattle==true){untyped Engine._pendingBattle=false; if(p!=null){untyped Engine._savedPlayerX=p.getXCenter(); untyped Engine._savedPlayerY=p.getYCenter();} untyped Engine._battleReturnSceneId=3; stopAllSounds(); switchScene(5,null,createCrossfadeTransition(4));}} return;} if(p==null) return; var npcIds=[75,77,79,81,83,85]; var pool=[29,41,43,45,47]; var fired:Dynamic=untyped Engine._l2NpcFired; var texts:Dynamic=untyped Engine._l2Texts; for(i in 0...npcIds.length){var npc=getActor(npcIds[i]); if(npc==null) continue; var dx:Float=p.getXCenter()-npc.getXCenter(); var dy:Float=p.getYCenter()-npc.getYCenter(); var near:Bool=(Math.abs(dx)<=140)&&(Math.abs(dy)<=140); if(near){ if(!fired[i]){fired[i]=true; var rx:Int=Std.random(77); var ry:Int=Std.random(42); for(fcy in 0...4){for(fcx in 0...4){if((rx+fcx)>=0&&(rx+fcx)<80&&(ry+fcy)>=0&&(ry+fcy)<45){fog.set((ry+fcy)*80+(rx+fcx),1);}}} untyped Engine._battleEnemyAid=pool[Std.random(pool.length)]; untyped Engine._battleEnemyInstanceId=npcIds[i]; untyped Engine._pendingBattle=false; untyped Engine._dialogActive=false; untyped Engine._savedPlayerX=p.getXCenter(); untyped Engine._savedPlayerY=p.getYCenter(); untyped Engine._battleReturnSceneId=3; stopAllSounds(); switchScene(5,null,createCrossfadeTransition(4)); } return;} else {fired[i]=false;}} if(g!=null&&mt<=0){var dxg:Float=p.getXCenter()-g.getXCenter(); var dyg:Float=p.getYCenter()-g.getYCenter(); if((dxg*dxg+dyg*dyg)<1600){var md:Int=(untyped Engine._playerMedallas==null)?0:Std.parseInt(Std.string(untyped Engine._playerMedallas)); if(md>=3){if(untyped Engine._l2PermisoPortal!=true) untyped Engine._playerMedallas=0; untyped Engine._l2PermisoPortal=true; untyped Engine._l2Hud="GUARDIAN: Ya sabes el trato. Con 3 monedas, puedes cruzar.";} else {untyped Engine._l2Hud="GUARDIAN: Te faltan monedas. Necesitas 3 para abrir el paso.";} untyped Engine._pendingBattle=false; untyped Engine._battleEnemyInstanceId=-1; untyped Engine._l2MsgTimer=180; return;}} if(po!=null&&mt<=0){var dxp:Float=p.getXCenter()-po.getXCenter(); var dyp:Float=p.getYCenter()-po.getYCenter(); if((dxp*dxp+dyp*dyp)<1600){if(untyped Engine._l2PermisoPortal==true){stopAllSounds(); switchScene(GameModel.get().scenes.get(4).getID(),null,createCrossfadeTransition(5)); return;} else {untyped Engine._l2Hud="PORTAL: Aun no puedes pasar. El guardian decide el cruce."; untyped Engine._pendingBattle=false; untyped Engine._battleEnemyInstanceId=-1; untyped Engine._l2MsgTimer=150; return;}}} 
		}
	}
	/* ========================= When Drawing ========================= */
	public function _event_Drawing(g:G, x:Float, y:Float):Void
	{
		if(wrapper.enabled && true)
		{
			{var fog:haxe.io.Bytes=untyped Engine._fogData; if(fog!=null){g.fillColor=0x000000; for(cy in 0...45){for(cx in 0...80){if(fog.get(cy*80+cx)==0){g.fillRect(cx*16,cy*16,16,16);}}}} var mt:Int=(untyped Engine._l2MsgTimer==null)?0:Std.parseInt(Std.string(untyped Engine._l2MsgTimer)); if(mt>0){g.fillColor=0xFFFFFF; g.fillRect(10,64,1260,44); g.fillColor=0x000000; g.drawString(Std.string(untyped Engine._l2Hud),18,72);} if(untyped Engine._dialogActive==true){g.fillColor=0xFFFFFF; g.fillRect(10,64,1260,44); g.fillColor=0x000000; g.drawString(Std.string(untyped Engine._dialogText),18,72);}}
		}
	}
	
	public function new(dummy:Int, dummy2:Engine)
	{
		super();
		nameMap.set("habloConNPC", "_habloConNPC");
		_habloConNPC = false;
		nameMap.set("medallas", "_medallas");
		_medallas = 0.0;
		nameMap.set("permisoPortal", "_permisoPortal");
		_permisoPortal = false;
		nameMap.set("firedNpc", "_firedNpc");
		_firedNpc = false;
		nameMap.set("firedPortal", "_firedPortal");
		_firedPortal = false;
		nameMap.set("mensajeHUD", "_mensajeHUD");
		_mensajeHUD = "";
		nameMap.set("mensajeTimer", "_mensajeTimer");
		_mensajeTimer = 0.0;
		
	}
	
	override public function init()
	{
		/* ======================== When Creating ========================= */
		setVolumeForAllSounds(5/100);
		loopSound(getSound(70));
		stopAllSounds(); var _s70=getSound(70); if(_s70!=null){_s70.stopInstances(); loopSound(_s70);} if(untyped Engine._fogData==null){untyped Engine._fogData=haxe.io.Bytes.alloc(3600);} Input.addKeyToControl(87,"up"); Input.addKeyToControl(83,"down"); Input.addKeyToControl(65,"left"); Input.addKeyToControl(68,"right"); Input.addKeyToControl(37,"left"); Input.addKeyToControl(38,"up"); Input.addKeyToControl(39,"right"); Input.addKeyToControl(40,"down"); var p=getActor(0); if(p!=null){p.setAngularVelocity(0);} if(untyped Engine._l2NpcFired==null) untyped Engine._l2NpcFired=[false,false,false,false,false,false]; if(untyped Engine._l2Texts==null) untyped Engine._l2Texts=["El mundo seco fue un error. El agua ordena todo.","Cuando suba la marea, el ruido de la guerra va a callar.","Nosotros no huimos del agua, la llamamos.","Cada compuerta que abrimos acerca el nuevo mundo.","En tierra firme solo crece polvo y hambre.","Bajo agua nadie manda, solo sobrevive.","El plan es inundar todo, sin volver atras.","Las ciudades viejas no merecen seguir en pie.","Cuando llegue la gran marea, van a entender.","No buscamos paz, buscamos profundidad.","El barro es el primer paso, el oceano es el final.","Estamos sembrando agua donde antes hubo fuego.","El futuro respira por branquias, no por humo.","Tu mundo seco se termina en esta costa.","No es desastre: es correccion de la superficie."]; untyped Engine._dialogActive=false; untyped Engine._dialogText=""; untyped Engine._dialogAuto=0; untyped Engine._pendingBattle=false; untyped Engine._l2MsgTimer=0;
		
		addListener(engine.whenUpdated, _event_Chequeo);
		addListener(engine.whenDrawing, _event_Drawing);
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}