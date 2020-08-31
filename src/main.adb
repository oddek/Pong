with Board;
with MicroBit.Display;
with MicroBit.Time;
with MicroBit.Buttons;
use MicroBit.Buttons;
with HAL;
use HAL;

procedure Main is
   buttonSub : Boolean := false;
   LastBallMove : MicroBit.Time.Time_Ms := MicroBit.Time.Clock;
   BallCycle : MicroBit.Time.Time_Ms := 1000;
   PaddleCycle : MicroBit.Time.Time_Ms := 100;
   GameOver : Boolean := false;
begin
   --


   loop
      if MicroBit.Buttons.State (Button_A) = Pressed then
         Board.MovePaddle(0);
      end if;
      if MicroBit.Buttons.State (Button_B) = Pressed then
         Board.MovePaddle(1);
      end if;

      if MicroBit.Time.Clock - LastBallMove > BallCycle then
         GameOver := Board.MoveBall;
         LastBallMove := MicroBit.Time.Clock;
      end if;
      exit when GameOver;

      Board.DisplayBoard;

      MicroBit.Time.Delay_Ms(100);

   end loop;

   MicroBit.Display.Clear;
   loop
      MicroBit.Display.Display("Game Over!");
   end loop;

end Main;


