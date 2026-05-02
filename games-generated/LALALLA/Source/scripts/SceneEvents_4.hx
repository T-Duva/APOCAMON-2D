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



class SceneEvents_4 extends SceneScript
{
	public var _habloConNPC:Bool;
	
	/* ======================== Actor of Type ========================= */
	public function _event_EntersRegion(a:Actor):Void
	{
		if(wrapper.enabled && sameAsAny(getActorType(0), a.getType(), a.getGroup()))
		{
			switchScene(GameModel.get().scenes.get(2).getID(), createFadeOut(6, Utils.getColorRGB(0, 0, 0)), createFadeIn(5, Utils.getColorRGB(204, 204, 204)));
		}
	}
	/* ========================= Type & Type ========================== */
	public function _event_TypeType(event:Collision):Void
	{
		if(wrapper.enabled && true)
		{
			if(_habloConNPC)
			{
				switchScene(GameModel.get().scenes.get(4).getID(), null, createCrossfadeTransition(5));
			}
			else
			{
				#if com.stencyl.native
				com.stencyl.native.Native.showAlert(("" + "PROHIBIDO PASAR"), "Primero consigue todas las medallas necesarias");
				#end
			}
		}
	}
	
	public function new(dummy:Int, dummy2:Engine)
	{
		super();
		nameMap.set("habloConNPC", "_habloConNPC");
		_habloConNPC = false;
		
	}
	
	override public function init()
	{
		/* ======================== When Creating ========================= */
		engine.cameraFollow(getActor(0));
		/* ======================== When Creating ========================= */
		setVolumeForAllSounds(5/100);
		playSound(getSound(71));
		
		addListener(getLastCreatedRegion().whenActorEntered, _event_EntersRegion);
		addListenerWithKey2(engine.whenCollidedEvents, getActorType(0).ID, getActorType(5).ID, _event_TypeType);
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}