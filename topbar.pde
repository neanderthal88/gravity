void topbar(){
  fill( 255 );
  
  score_str = nf(score, 4);
  goal_str  = nf(goal, 4);
  
  text("SCORE: " + score_str, 15, 30);
  text("GOAL:  " + goal_str, 15, 50 );
  
  textAlign(CENTER);
  text("LEVEL: " + game_world + "-" + level, width/2, 30 );
  textAlign(CORNER);
  
  text("TIME: " + (totalTime - currentTime), width - 150, 30 );
}
