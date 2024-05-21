using Godot;
using System;

public partial class player : CharacterBody2D
{
	private String name = "Dinosaur";
	private int hp = 100;	
	private const float Gravity = 1000f;
	private const int WalkSpeed = 140;
	

	public override void _PhysicsProcess(double delta)
    {
        var velocity = Velocity;

        velocity.Y += (float)delta * Gravity;

        if (Input.IsActionPressed("Left"))
        {
            velocity.X = -WalkSpeed;
        }
        else if (Input.IsActionPressed("Right"))
        {
            velocity.X = WalkSpeed;
        }
		
        else
        {
            velocity.X = 0;
        }

        Velocity = velocity;

        MoveAndSlide();
    }

   


}
