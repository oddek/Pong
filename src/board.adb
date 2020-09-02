with MicroBit.Display;
package body Board is
   
   GridSizeX : constant Integer := 4;
   GridSizeY : constant Integer := 4;
   
   subtype Paddle_Type is Natural range 0 .. GridSizeY;
   
   Paddle1 : Paddle_Type := 1;
   Paddle2 : Paddle_type := 0;
   
   subtype X_Coord is Natural range 0 .. GridSizeX;
   subtype Y_Coord is Natural range 0 .. GridSizeY;
   type X_Dir_Type is (left, right);
   type Y_Dir_Type is (up, down, none);
   
   type Ball_Type is
      record
         X : X_Coord := 1;
         Y : Y_Coord := 2;
         X_Dir : X_Dir_Type := left;
         Y_Dir : Y_Dir_Type := up;
      end record;
   
   Ball : Ball_Type;
   
   --All this random stuff is a horrible solution, but i could not get the Ada libraries to work with the microbit.
   RandomIndex : Integer := 0;
   RandomNum : Integer := 0;
   type Arr_Type is array (0 .. 99) of Natural;
   procedure GenerateRandom is
      MyRands : constant Arr_Type := (1,	2,	1,	2,	1,
                                      0,	2,	1,	1,	0,
                                      2,	0,	1,	2,	2,
                                      0,	1,	1,	0,	1,
                                      2,	0,	2,	1,	0,
                                      1,	2,	0,	0,	1,
                                      0,	1,	2,	1,	1,
                                      0,	0,	1,	0,	0,
                                      1,	2,	1,	1,	0,
                                      2,	0,	2,	0,	0,
                                      0,	0,	0,	2,	1,
                                      1,	2,	0,	1,	1,
                                      0,	2,	0,	1,	0,
                                      0,	0,	1,	2,	0,
                                      1,	0,	2,	0,	0,
                                      0,	2,	1,	0,	0,
                                      0,	0,	2,	1,	0,
                                      0,	1,	0,	2,	0,
                                      1,	0,	1,	0,	1,
                                      1,	1,	1,	1,	0);
   begin
      RandomIndex := RandomIndex + 1;
      if RandomIndex >= 99 then
         RandomIndex := 0;
      end if;
      RandomNum := MyRands(RandomIndex);
   end GenerateRandom;
   
   function MoveBall return Boolean is
   begin
      if Ball.X = (X_Coord'First) or (Ball.X = X_Coord'Last) then
         if (Ball.Y /= Paddle1 and Ball.X = X_Coord'First) or (Ball.Y /= Paddle2 and Ball.X = X_Coord'Last) then
            return true;
         end if;
         Ball.X_Dir := X_Dir_Type'Val((X_Dir_Type'Pos(Ball.X_Dir) + 1) mod 2);
         GenerateRandom;
         Ball.Y_Dir := Y_Dir_Type'Val(RandomNum);
      end if;           
      
      if Ball.Y = Y_Coord'First then
         Ball.Y_Dir := down;
      elsif Ball.Y = Y_Coord'Last then
         Ball.Y_Dir := up;
      end if;
            
      if Ball.X_Dir = X_Dir_Type'First then
         Ball.X := Ball.X - 1;
      else
         Ball.X := Ball.X + 1;
      end if;
      
      if Ball.Y_Dir = Y_Dir_Type'First then
         Ball.Y := Ball.Y - 1;
      elsif Ball.Y_Dir = Y_Dir_Type'Last then
         null;
      else
         Ball.Y := Ball.Y + 1;    
      end if;
      
      return false;
   end MoveBall;
   
   procedure DisplayBoard is
   begin
      MicroBit.Display.Clear;
      MicroBit.Display.Set(X_Coord'First, Paddle1);
      MicroBit.Display.Set(X_Coord'Last, Paddle2);
      MicroBit.Display.Set(Ball.X, Ball.Y);
   end DisplayBoard;
   
   procedure MovePaddle(i : Integer) is
   begin
      if i = 0 then
         Paddle1 := (Paddle1 + 1) mod 5;
      else
         Paddle2 := (Paddle2 + 1) mod 5;
      end if;
   end MovePaddle;

begin
   null; 
end Board;
