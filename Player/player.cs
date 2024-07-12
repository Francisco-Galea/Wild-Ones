using Godot;
using System;

public partial class Player : CharacterBody2D
{
	private bool _isMyTurn = true;
	public const float Speed = 300.0f;
	public const float JumpVelocity = -400.0f;
	public float _gravity;
	
	public override void _Ready()
	{
		_gravity = ProjectSettings.GetSetting("physics/2d/default_gravity").AsSingle();
	}
	
	public override void _PhysicsProcess(double delta)
	{
		HandleMovement(delta);
		if (_isMyTurn)
		{
			
			//HandleMovement(delta);
		}
	}
	
	 private void HandleMovement(double delta)
	{
		Vector2 velocity = Velocity;

		// Apply gravity if not on floor.
		if (!IsOnFloor())
			velocity.Y += _gravity * (float)delta;

		// Handle jump.
		if (Input.IsActionJustPressed("ui_accept") && IsOnFloor())
			velocity.Y = JumpVelocity;

		// Handle horizontal movement.
		float inputDirection = Input.GetActionStrength("ui_right") - Input.GetActionStrength("ui_left");
		velocity.X = inputDirection * Speed;

		Velocity = velocity;
		MoveAndSlide();
	}
	
	public void SetTurn(bool isMyTurn)
	{
		_isMyTurn = isMyTurn;
		if (_isMyTurn)
		{
			GD.Print("Turno iniciado para el jugador: " + Name);
		}
		else
		{
			GD.Print("Turno finalizado para el jugador: " + Name);
		}
	}
	
}
