using Godot;
using System;
using System.Collections.Generic;

public partial class TurnManager : Node2D
{
	[Export]
	public float TurnDuration = 30.0f;
	private List<Player> _players = new List<Player>();
	private int _currentPlayerIndex = 0;
	private Timer _turnTimer;

	public override void _Ready()
	{
		_turnTimer = GetNode<Timer>("Timer"); 
		//_turnTimer.Connect("timeout", this, nameof(_on_timer_timeout));
		
		var playerNodes = GetNode<Node>("Players").GetChildren();

		foreach (Node node in playerNodes)
		{
			if (node is Player player)
			{
				_players.Add(player);
				player.SetTurn(false);
			}
		}

		if (_players.Count > 0)
		{
			StartNextTurn();
		}
	}

	private void StartNextTurn()
	{
		_players[_currentPlayerIndex].SetTurn(true);
		//_turnTimer.Start(TurnDuration);
	}

	
	private void _on_timer_timeout()
	{
		_players[_currentPlayerIndex].SetTurn(false);
		_currentPlayerIndex = (_currentPlayerIndex + 1) % _players.Count;
		StartNextTurn();
	}
	
}



