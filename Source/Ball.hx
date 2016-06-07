import scene.LevelMenu;
import flash.geom.Point;
import flash.events.Event;
import openfl.Assets;
import openfl.media.Sound;

class Ball extends DynamicObject {

    var color:Int;

    public function new(xCord:Float, yCord:Float, color:Int) {
        super(30, 30, new Point(1, 1), 0.08);
        this.color = color;
        draw();
        this.x = xCord;
        this.y = yCord;
        addEventListener(Event.ENTER_FRAME, enterFrameEvents);
    }

    public override function draw():Void {
        this.graphics.beginFill(color);
        this.graphics.drawCircle(0, 0, 10);
        this.graphics.endFill();
    }

    public override function move(direction:Point):Void{
        var rightW:Wall = Main.getInstance().get__board()._rightWall;
        var leftW:Wall = Main.getInstance().get__board()._leftWall;
        var bottomtW:Wall = Main.getInstance().get__board()._bottomWall;
        var topW:Wall = Main.getInstance().get__board()._topWall;

        //trace(x + " " + y + " " + topW.wWidth + " " + rightW.wWidth);
        //if the ball hits the right side
        if(x >= topW.widthO) {
            speed.x *= -1;
        }
        //if the ball hits the left side
        if(x <= 0) {
            speed.x *= -1;
        }
        //if the ball hits the bottom
        if(y >= rightW.heightO) {
            speed.y *= -1;
            Assets.getSound("assets/sounds/gameover.ogg").play();
            new LevelMenu().show();
        }
        //if the ball hits the top
        if(y <= 0) {
            speed.y *= -1;
        }
    }

    public function calcBallAngle(paddle:GameObject):Void{
        //Hack to prevent the colision to bug
        y -= 1;
        //ballPosition is the position of the ball is on the paddle
        var ballPosition:Int = Math.round(x - paddle.x);
        //trace("Ball: " + x + ":" + y);
        //trace("Padd: " + paddle.x + ":" + paddle.y);

        //hitPercent converts ballPosition into a percent
        //All the way to the left is -.5
        //All the way to the right is .5
        //The center is 0
        var hitPercent:Int = Math.round(((ballPosition / (paddle.widthO - 15)) - .5)*4);
        //Gets the hitPercent and makes it a larger number so the
        //ball actually bounces
        speed.x = hitPercent * 0.3;
        //Making the ball bounce back up
        speed.y *= -1;
    }


    private function enterFrameEvents(event:Event):Void{
        move(null);
    }
}
