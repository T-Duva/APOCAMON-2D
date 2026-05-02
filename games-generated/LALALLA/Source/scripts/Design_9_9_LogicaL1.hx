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



class Design_9_9_LogicaL1 extends SceneScript
{
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
			_mensajeTimer = {var nt:Float = _mensajeTimer - 1; if(nt < 0) nt = 0; if(untyped Engine._introPromptActive==null){untyped Engine._introPromptActive=true;untyped Engine._introPromptInput="";untyped Engine._introPromptLatch={};} var p = getActor(0); var n = getActor(7); var po = getActor(5); var introActive:Bool=(untyped Engine._introPromptActive==true); var introInput:String=Std.string((untyped Engine._introPromptInput==null)?"":untyped Engine._introPromptInput); var l:Dynamic=untyped Engine._introPromptLatch; if(l==null){l={};untyped Engine._introPromptLatch=l;} if(introActive){ var cap=function(k:String,o:String){var d:Bool=isKeyDown(k); var w:Bool=(Reflect.field(l,k)==true); if(d && !w){introInput += o;} Reflect.setField(l,k,d);}; for(ch in ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]){cap(ch,ch);} for(num in ["0","1","2","3","4","5","6","7","8","9"]){cap(num,num);} cap("SPACE"," "); var bd:Bool=isKeyDown("BACKSPACE"); var bw:Bool=(Reflect.field(l,"BACKSPACE")==true); if(bd && !bw && introInput.length>0){introInput=introInput.substr(0,introInput.length-1);} Reflect.setField(l,"BACKSPACE",bd); var ed:Bool=isKeyDown("ENTER"); var ew:Bool=(Reflect.field(l,"ENTER")==true); if(ed && !ew){if(StringTools.trim(introInput).toUpperCase()=="APOCAMON"){untyped Engine._playerApocamons=[29,41,47,45,43]; _mensajeHUD="TRUCO ACTIVADO: LIBRO COMPLETO"; nt=240;} untyped Engine._introPromptActive=false;} Reflect.setField(l,"ENTER",ed); untyped Engine._introPromptInput=introInput; if(nt<2)nt=2; _mensajeHUD="Hola estas preparado para lo que se viene? RESPUESTA: "+introInput+"_"; } else { if(p != null && n != null){var near = Math.abs(p.getX()-n.getX())<60 && Math.abs(p.getY()-n.getY())<60; if(near && !_firedNpc){_firedNpc = true; if(_medallas >= 10){_medallas = 0; _permisoPortal = true; _mensajeHUD = "GUARDIA: Toma! La necesitaras. Nos vemos del otro lado. Habilidad: CAMINAR POR AGUAS BAJAS";}else{_mensajeHUD = "GUARDIA: Vuelve cuando tengas suficientes medallas!";} nt = 240;} else if(!near){_firedNpc = false;}} if(p != null && po != null){var near2 = Math.abs(p.getX()-po.getX())<60 && Math.abs(p.getY()-po.getY())<60; if(near2){if(_permisoPortal && !_firedPortal){_firedPortal = true; _mensajeHUD = "En 5 segundos seras teletransportado..."; nt = 300; stopAllSounds();switchScene(GameModel.get().scenes.get(3).getID(), null, createCrossfadeTransition(5));} else if(!_permisoPortal && !_firedPortal){_firedPortal = true; _mensajeHUD = "Para pasar, necesitaras el poder unico que te dara el guardia."; nt = 240;}} else {_firedPortal = false;}} } nt;};
		}
	}
	/* ========================= When Drawing ========================= */
	public function _event_Drawing(g:G, x:Float, y:Float):Void
	{
		if(wrapper.enabled && true)
		{
			if((_mensajeTimer > 0))
			{
				g.fillColor = Utils.convertColor(Utils.getColorRGB(255, 255, 255));
				g.fillRect(10, 10, 1240, 40);
				g.fillColor = Utils.convertColor(Utils.getColorRGB(0, 0, 0));
				g.drawString(_mensajeHUD, 18, 18);
			}
		}
	}
	
	public function new(dummy:Int, dummy2:Engine)
	{
		super();
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
		_medallas = 0;
		_permisoPortal = false;
		_firedNpc = false;
		_firedPortal = false;
		_mensajeHUD = "";
		_mensajeTimer = 0;
		
		addListener(engine.whenUpdated, _event_Chequeo);
		addListener(engine.whenDrawing, _event_Drawing);
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}