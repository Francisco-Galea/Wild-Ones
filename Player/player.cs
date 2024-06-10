using Godot;
using System;

public partial class player : CharacterBody2D
{
	private String name = "Dinosaur";
	private int hp = 100;
	private const float Gravity = 1000f;
	private const int WalkSpeed = 140;
	private const int jump = 300;
	
	
	public override void _PhysicsProcess(double delta)
	{
		var animatedSprite2D = GetNode<AnimatedSprite2D>("AnimatedSprite2D");
		var velocity = Velocity;
		
		velocity.Y += (float)delta * Gravity;
		
		
		if (Input.IsActionPressed("Left") && Input.IsActionPressed("Jump") && IsOnFloor())
		{
			velocity.X = -WalkSpeed;
			velocity.Y = -jump;
			
		}
		else if (Input.IsActionPressed("Right") && Input.IsActionPressed("Jump") && IsOnFloor())
		{
			velocity.X = WalkSpeed;
			velocity.Y = -jump;
		}
		else if (Input.IsActionPressed("Left"))
		{
			velocity.X = -WalkSpeed;
			animatedSprite2D.FlipH = velocity.X < 0;
			animatedSprite2D.Animation = "Move";
		}
		else if (Input.IsActionPressed("Right"))
		{
			velocity.X = WalkSpeed;
			animatedSprite2D.FlipH = velocity.X < 0;
			animatedSprite2D.Animation = "Move";
		}
		else if(Input.IsActionPressed("Jump") && IsOnFloor())
		{
			velocity.Y = -jump;
			animatedSprite2D.Animation = "Jump";
		}
		else
		{
			velocity.X = 0;
		}
		
		if (velocity.X == 0)
{
	animatedSprite2D.Animation = "Iddle";
	
	// See the note below about boolean assignment.
	
}



		Velocity = velocity;

		MoveAndSlide();
	}
	}
	
