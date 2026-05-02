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



class SceneEvents_1 extends SceneScript
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
			_mensajeTimer = {var __askCheat:Bool=false; #if js try{if(untyped __js__("window._stencylCheatT===true")){untyped Engine._cheatKeyPressed=true; untyped __js__("window._stencylCheatT=false;");}}catch(_e3:Dynamic){} #end var __tByInput:Bool=(Input.check("cheatkey")||isKeyDown("T")); var __tByJs:Bool=(untyped Engine._cheatKeyPressed==true); if(__tByJs) untyped Engine._cheatKeyPressed=false; if(untyped Engine._cheatPromptShown!=true && (__tByInput||__tByJs)){__askCheat=true; untyped Engine._cheatPromptShown=true;} #if js if(__askCheat){ try{ var _ans:Dynamic=untyped __js__("window.prompt('Estas listo para lo que se viene?','')"); var _txt:String=(_ans==null)?"":Std.string(_ans); if(StringTools.trim(_txt)=="APOCAMON"){untyped Engine._cheatUnlocked=true; untyped Engine._playerApocamons=[29,41,47,45,43]; _mensajeHUD="TRUCO ACTIVADO: LIBRO COMPLETO"; _mensajeTimer=240;} }catch(_e:Dynamic){} } #end var nt:Float=_mensajeTimer-1; if(nt<0)nt=0; var p=getActor(0); var n=getActor(7); var po=getActor(5); var fog:haxe.io.Bytes=untyped Engine._fogData; if(p!=null){var blocked:Bool=false; var kL:Bool=Input.check("left")||isKeyDown("A")||isKeyDown("LEFT"); var kR:Bool=Input.check("right")||isKeyDown("D")||isKeyDown("RIGHT"); var kU:Bool=Input.check("up")||isKeyDown("W")||isKeyDown("UP"); var kD:Bool=Input.check("down")||isKeyDown("S")||isKeyDown("DOWN"); var sp:Float=0.8; if(untyped Engine._l1MusicKick==null) untyped Engine._l1MusicKick=true; if(untyped Engine._l1MusicKick==true && (kL||kR||kU||kD||Input.check("enterkey")||Input.check("cheatkey")||__tByJs)){var _m69=getSound(69); if(_m69!=null)_m69.stopInstances(); loopSound(getSound(69)); untyped Engine._l1MusicKick=false;} var vx:Float=0; var vy:Float=0; if(!blocked){if(kL&&!kR){vx-=sp;}else if(kR&&!kL){vx+=sp;} if(kU&&!kD){vy-=sp;}else if(kD&&!kU){vy+=sp;}} var _px:Float=(untyped Engine._l1Px==null)?p.getXCenter():cast(untyped Engine._l1Px,Float); var _py:Float=(untyped Engine._l1Py==null)?p.getYCenter():cast(untyped Engine._l1Py,Float); _px+=vx; _py+=vy; untyped Engine._l1Px=_px; untyped Engine._l1Py=_py; p.setXCenter(_px); p.setYCenter(_py); p.setXVelocity(0); p.setYVelocity(0); p.setAngularVelocity(0); if(Reflect.hasField(p,"setAngle")) untyped p.setAngle(0); if(Reflect.hasField(p,"setRotation")) untyped p.setRotation(0); if(!blocked){ if(vx<0){p.setAnimation("Izquierda");} else if(vx>0){p.setAnimation("Derecha");} else if(vy<0){p.setAnimation("Arriba");} else if(vy>0){p.setAnimation("Abajo");} }}  if(p!=null&&fog!=null){var pcx:Int=Std.int(p.getXCenter()/16); var pcy:Int=Std.int(p.getYCenter()/16); for(cy in (pcy-2)...(pcy+3)){for(cx in (pcx-2)...(pcx+3)){if(cx>=0&&cx<80&&cy>=0&&cy<45){fog.set(cy*80+cx,1);}}}} untyped Engine._pendingBattle=false; var pending:Bool=false; var dialog:Bool=(untyped Engine._dialogActive==true); if(dialog){nt=20; _mensajeHUD=Std.string(untyped Engine._dialogText); var dAuto:Int=(untyped Engine._dialogAuto==null)?0:Std.parseInt(Std.string(untyped Engine._dialogAuto)); if(dAuto>0){dAuto-=1; if(dAuto<0)dAuto=0; untyped Engine._dialogAuto=dAuto;} if(dAuto<=0){untyped Engine._dialogActive=false; untyped Engine._playerMedallas=_medallas; if(p!=null){untyped Engine._savedPlayerX=p.getXCenter(); untyped Engine._savedPlayerY=p.getYCenter();} stopAllSounds();var _s69b=getSound(69);if(_s69b!=null)_s69b.stopInstances();switchScene(5,null,createCrossfadeTransition(4));}}  if(!dialog&&p!=null&&n!=null){var dxG:Float=p.getXCenter()-n.getXCenter(); var dyG:Float=p.getYCenter()-n.getYCenter(); var near:Bool=(dxG*dxG+dyG*dyG)<8100; if(near&&!_firedNpc){_firedNpc=true; if(_medallas>=10){_medallas=0; _permisoPortal=true; _mensajeHUD="GUARDIA: Toma! La necesitaras. Nos vemos del otro lado. Habilidad: CAMINAR POR AGUAS BAJAS";}else{_mensajeHUD="GUARDIA: Vuelve cuando tengas suficientes medallas!";} nt=240;}else if(!near){_firedNpc=false;}} if(!dialog&&p!=null&&po!=null){var dxP:Float=p.getXCenter()-po.getXCenter(); var dyP:Float=p.getYCenter()-po.getYCenter(); var near2:Bool=(dxP*dxP+dyP*dyP)<8100; if(near2){if(_permisoPortal&&!_firedPortal){_firedPortal=true; _mensajeHUD="En 5 segundos seras teletransportado..."; nt=300; stopAllSounds();switchScene(GameModel.get().scenes.get(3).getID(),null,createCrossfadeTransition(5));}else if(!_permisoPortal&&!_firedPortal){_firedPortal=true; _mensajeHUD="Para pasar, necesitaras el poder unico que te dara el guardia."; nt=240;}}else{_firedPortal=false;}} var npcIds=[9,10,11,12,13,14,15,16,17,18]; var npcTypeIds=[9,10,11,12,13,14,15,16,17,18]; var texts=["NPC: EY TU! Ven aqui!","NPC: OYE! Vamos a pelear!","NPC: Shhh... los escuchas en la noche? Yo si.","NPC: No cruces el pozo del sur. Nunca.","NPC: Yo tenia familia. Ahora tengo este bidon.","NPC: Cuidado con el Guardia. No regala nada.","NPC: El aire de afuera mata lento. Respira poco.","NPC: Dicen que el Portal lleva a un lugar mejor. Mentira.","NPC: No bajes la guardia, forastero.","NPC: Aqui nadie sonrie gratis, forastero."]; var flagArr:Array<Bool>=untyped Engine._firedNpcs; if(flagArr==null){flagArr=[false,false,false,false,false,false,false,false,false,false]; untyped Engine._firedNpcs=flagArr;} if(!dialog&&p!=null){for(i in 0...npcIds.length){var _deadNow:Array<Int>=untyped Engine._defeatedNpcs; if(_deadNow!=null&&Lambda.has(_deadNow,npcIds[i])){var _dn=getActor(npcIds[i]); if(_dn!=null){_dn.disableActorDrawing(); _dn.setLocation(-9999,-9999); _dn.setXVelocity(0); _dn.setYVelocity(0);} flagArr[i]=true; continue;} var npc=getActor(npcIds[i]); if(npc!=null){var nx0:Float=npc.getXCenter(); var ny0:Float=npc.getYCenter(); if(nx0<0||nx0>1280||ny0<0||ny0>736){continue;} var dx:Float=p.getXCenter()-nx0; var dy:Float=p.getYCenter()-ny0; var nearN:Bool=(Math.abs(dx)<=64)&&(dy>-115)&&(dy<-80); if(nearN&&!flagArr[i]){untyped Engine._dbgDetect="NPC"+(i+1)+" | px="+Std.int(p.getXCenter())+" py="+Std.int(p.getYCenter())+" | nx="+Std.int(nx0)+" ny="+Std.int(ny0)+" | dx="+Std.int(dx)+" dy="+Std.int(dy); flagArr[i]=true; if(fog!=null){var rx:Int=Std.int(Math.random()*77); var ry:Int=Std.int(Math.random()*42); for(fcy in ry...(ry+4)){for(fcx in rx...(rx+4)){if(fcx>=0&&fcx<80&&fcy>=0&&fcy<45){fog.set(fcy*80+fcx,1);}}}} untyped Engine._battleEnemyAid=npcTypeIds[i]; untyped Engine._battleEnemyInstanceId=npcIds[i]; untyped Engine._battleReturnSceneId=1; untyped Engine._dialogText=texts[i]; var _stopL1Mus=getSound(69);if(_stopL1Mus!=null)_stopL1Mus.stopInstances(); untyped Engine._dialogActive=true; untyped Engine._dialogAuto=8.0; nt=300;} else if(!nearN){flagArr[i]=false;}}}} var tk:Int=((untyped Engine._l1Tick==null)?0:cast(untyped Engine._l1Tick,Int))+1; untyped Engine._l1Tick=tk; if((tk%30)==0){trace("[L1LOG] dialog="+(untyped Engine._dialogActive==true)+" pending="+(untyped Engine._pendingBattle==true)+" shift="+(Input.check("runshift")||isKeyDown("SHIFT")));} nt;};
		}
	}
	/* ========================= When Drawing ========================= */
	public function _event_Drawing(g:G, x:Float, y:Float):Void
	{
		if(wrapper.enabled && true)
		{
			{ var fog:haxe.io.Bytes = untyped Engine._fogData; if(fog != null){ g.fillColor = 0x000000; for(cy in 0...45){ for(cx in 0...80){ if(fog.get(cy*80 + cx) == 0){ g.fillRect(cx*16, cy*16, 16, 16); } } } } var _pam:Dynamic = untyped Engine._playerApocamons; var _apn:Int = (_pam==null) ? 0 : _pam.length; g.fillColor = 0xFFFFFF; g.fillRect(0, 0, 160, 56); g.fillColor = 0xFFFFFF; g.drawString("Apocamons="+_apn, 6, 6); g.drawString("Medallas="+_medallas, 6, 30);  }
			if((_mensajeTimer > 0))
			{
				g.fillColor = Utils.convertColor(Utils.getColorRGB(255, 255, 255));
				g.fillRect(10, 64, 1260, 44);
				g.fillColor = Utils.convertColor(Utils.getColorRGB(0, 0, 0));
				g.drawString(_mensajeHUD, 18, 72);
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
		stopAllSounds();var _s69=getSound(69);if(_s69!=null)_s69.stopInstances();
		setVolumeForAllSounds(5/100);
		loopSound(getSound(69));
		_medallas = 0;
		_permisoPortal = false;
		_firedNpc = false;
		_firedPortal = false;
		_mensajeHUD = "";
		_mensajeTimer = 0;
		if(untyped Engine._fogData==null){untyped Engine._fogData=haxe.io.Bytes.alloc(3600);} try{ Input.addKeyToControl(87,"up"); Input.addKeyToControl(83,"down"); Input.addKeyToControl(65,"left"); Input.addKeyToControl(68,"right"); Input.addKeyToControl(13,"enterkey"); Input.addKeyToControl(16,"runshift"); Input.addKeyToControl(37,"left"); Input.addKeyToControl(38,"up"); Input.addKeyToControl(39,"right"); Input.addKeyToControl(40,"down"); Input.addKeyToControl(84,"cheatkey"); Input.addKeyToControl(116,"cheatkey"); if(untyped Engine._firedNpcs==null){untyped Engine._firedNpcs=[false,false,false,false,false,false,false,false,false,false];} var _md:Dynamic=untyped Engine._playerMedallas; if(_md!=null){_medallas=Std.parseInt(Std.string(_md));} var _dead:Array<Int>=untyped Engine._defeatedNpcs; if(_dead!=null){for(_did in _dead){var _da=getActor(_did);if(_da!=null){_da.disableActorDrawing();_da.setLocation(-9999,-9999);_da.setXVelocity(0);_da.setYVelocity(0);}}} var _sx:Dynamic=untyped Engine._savedPlayerX; var _sy:Dynamic=untyped Engine._savedPlayerY; if(_sx!=null&&_sy!=null){var _pl=getActor(0); if(_pl!=null){_pl.setLocation(cast(_sx,Float),cast(_sy,Float));} untyped Engine._savedPlayerX=null; untyped Engine._savedPlayerY=null;} var _pl2=getActor(0); if(_pl2!=null){_pl2.disableBehavior("4-Way Movement"); _pl2.setAngularVelocity(0);} untyped Engine._pendingBattle=false; untyped Engine._dialogActive=false; untyped Engine._dialogText=""; untyped Engine._dialogAuto=0; untyped Engine._npcBattleTimer=0; untyped Engine._l1MusicKick=true; untyped Engine._dialogAuto=0; untyped Engine._pendingBattleDelay=0; untyped Engine._dialogAuto=0; #if js try{untyped __js__("window.focus(); if(document && document.activeElement){document.activeElement.blur();} if(document && document.body){document.body.focus();}");}catch(_e:Dynamic){} try{untyped __js__("if(!window.__l1CheatKeyHook){window.__l1CheatKeyHook=true; window.addEventListener('keydown', function(e){ if(e && ((e.key&&e.key.toLowerCase&&e.key.toLowerCase()=='t') || e.keyCode===84)){ window._stencylCheatT=true; } });}"); if(untyped __js__("window._stencylCheatT===true")){untyped Engine._cheatKeyPressed=true; untyped __js__("window._stencylCheatT=false;");}}catch(_e2:Dynamic){} #end }catch(e:Dynamic){trace("[L1LOG] init err: "+e);}
		if(untyped Engine._cheatUnlocked==true){untyped Engine._playerApocamons=[29,41,47,45,43];}
		
		addListener(engine.whenUpdated, _event_Chequeo);
		addListener(engine.whenDrawing, _event_Drawing);
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}