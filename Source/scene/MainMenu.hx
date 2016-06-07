package scene;

import haxe.ui.toolkit.events.UIEvent;
import haxe.ui.toolkit.controls.Button;
import haxe.ui.toolkit.core.Toolkit;
import flash.events.Event;
import openfl.Assets;
import openfl.media.Sound;

/**
* Main Menu
**/
class MainMenu extends FullScreen  {
    var sound:Sound;
    public function new() {
        super();
        //Layout
        view = Toolkit.processXmlResource("assets/ui/layout/main-menu.xml");
        //trace("WTF");
        //onClick-Events

        view.findChild("start", Button, true).onClick = function(e:UIEvent){ new LevelMenu().show();};
        view.findChild("options", Button, true).onClick = function(e:UIEvent){  /*new OptionsScene().show();*/  };
        view.findChild("about", Button, true).onClick = function(e:UIEvent){    /*new AboutScene().show();*/    };
        view.findChild("quit", Button, true).onClick = function(e:UIEvent){ trace("exit"); };
        var soundExt:String;
        #if flash
            soundExt= "mp3";
        #else
            soundExt= "ogg";
        #end
        sound = Assets.getSound ("assets/sounds/What-Is-Love."+soundExt);
        var channel = sound.play(0);
        channel.addEventListener(Event.SOUND_COMPLETE,function(e:Event):Void {
            channel.stop();
            channel = sound.play(0);
        });
    }

}