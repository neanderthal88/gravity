void play(){
  audio[0].pause(); audio[0].rewind();
  if( !audio[1].isPlaying() ){ audio[1].rewind(); audio[1].play(); }
  
  // draw background
  for(int i=0; i < parallax_img.length; i++){ parallax_img[i].display(); parallax_img[i].update(); }
  
  level = 1;
  
  keep_score = true;
  
  if(menu_opacity >= 50) menu_opacity -= 10;
  else menu_opacity = 0;
  fill(0, menu_opacity);
  rect(0,0, width, height);
    
  // set up worlds
  world.step();
  world.draw();
  
  reverseWorld.step();
  reverseWorld.draw();
  
  time_running = true;
  if( (totalTime - currentTime) == 0 ){ 
    audio[7].play(); audio[7].rewind();
    game_state = "lose";
  }
  if( (totalTime - currentTime) != 0 && score >= goal ){
    audio[6].play(); audio[6].rewind();
    game_state = "win";
  }
  
  // draw collectibles
  for( int i=0; i < collectibles.length; i++ ){ collectibles[i].display(); collectibles[i].update(); }
    
  levels();    // level settings
  topbar();    // draw topbar
  keyInputs(); // key inputs
}

void pause(){
  // draw background
  for(int i=0; i < parallax_img.length; i++) parallax_img[i].display();
  
  // set up worlds
  world.step();
  world.draw();
  
  reverseWorld.step();
  reverseWorld.draw();
  
  // stop motion
  myReverseBox.setVelocity( 0, 0 );
  myBox.setVelocity( 0, 0 );
  
  // pause time
  if(time_running){
    timeSoFar = millis()-startTime;
    time_running = false;
  }
    
  // draw collectibles
  for( int i=0; i < collectibles.length; i++ ) collectibles[i].display();
    
  levels();    // level settings
  topbar();    // draw topbar
  
  if     ( pause_selection == "resume" )  selection_y = 255;
  else if( pause_selection == "restart" ) selection_y = 303;
  else if( pause_selection == "exit" )    selection_y = 350;
  
  if( current_selection_y < selection_y && pause_select_down ){ current_selection_y += 7; }
  else pause_select_down = false;
  if( current_selection_y > selection_y && !pause_select_down ){ current_selection_y -= 7; }
  
  if( pause_opacity < 150 ) pause_opacity += 5;
  fill(0, pause_opacity);
  rect(0,0, width, height);
  
  image(pauseHover_img,0, current_selection_y);
  image(pause_img,0,0);
}

void restart(){
  score = 0;
  for( int i=0; i < collectibles.length; i++ ) collectibles[i].resetpos();
  
  myBox.setPosition( 100, height/2 );
  myBox.setVelocity( 10, -10);
  
  myReverseBox.setPosition( 600, height/2 );
  myReverseBox.setVelocity( 10, -10 );
  
  currentTime = 0;
  startTime = millis();
  timeSoFar = 0;
  
  lose_opacity = 0;
  pause_opacity = 0;
  
  for(int i=0; i < parallax_img.length; i++ ) parallax_img[i].xpos = 0;
}

void instructions(){
  audio[0].pause(); audio[0].rewind();
  
  level = 0;
  currentTime = 0;
  startTime = millis();
  timeSoFar = 0;
  
  // draw background
  for(int i=0; i < parallax_img.length; i++){ parallax_img[i].display(); parallax_img[i].update(); }
  
  if(menu_opacity >= 50) menu_opacity -= 10;
  else menu_opacity = 0;
  fill(0, menu_opacity);
  rect(0,0, width, height);
    
  // set up worlds
  world.step();
  world.draw();
  
  reverseWorld.step();
  reverseWorld.draw();
  
  time_running = true;
  if( (totalTime - currentTime) == 0 ) game_state = "lose";
  if( (totalTime - currentTime) != 0 && score >= goal ) game_state = "win";
  
  // draw collectibles
  for( int i=0; i < collectibles.length; i++ ){ collectibles[i].display(); collectibles[i].update(); }
    
  levels();    // level settings
  topbar();    // draw topbar
  keyInputs(); // key inputs
  
  textAlign(CENTER);
  rectMode(CENTER);
  text("TUTORIAL", width/2, 50 );
  
  if( instruct_scene == 0 ){
    keep_score = false;
    image( instructions[1], 0, 0 );
    if (greeny > 0) { greenTest = 0;  } //test if opacity needs to go down
    else if (greeny < -3) { greenTest = 1; } //test if opacity needs to go up
    if (greenTest == 1) { greeny += 0.5; } //increase opacity
    else if (greenTest == 0) { greeny -= 0.5; } //decrease opacity
    image( instructions[0], 0, greeny );
    myBox.setPosition( 100, height/2 );
    myReverseBox.setPosition( 600, height/2 );
  }
  else if( instruct_scene == 1 ){
    keep_score = false;
    image( instructions[2], 0, 0 );
    if (greeny > 0) { greenTest = 0;  } //test if opacity needs to go down
    else if (greeny < -3) { greenTest = 1; } //test if opacity needs to go up
    if (greenTest == 1) { greeny += 0.5; } //increase opacity
    else if (greenTest == 0) { greeny -= 0.5; } //decrease opacity
    image( instructions[0], 30, greeny );
    myBox.setPosition( 100, height/2 );
    myReverseBox.setPosition( 600, height/2 );
  }
  else if( instruct_scene == 2 ){
    keep_score = false;
    image( instructions[3], 0, 0 );
    if (greeny > 0) { greenTest = 0;  } //test if opacity needs to go down
    else if (greeny < -3) { greenTest = 1; } //test if opacity needs to go up
    if (greenTest == 1) { greeny += 0.5; } //increase opacity
    else if (greenTest == 0) { greeny -= 0.5; } //decrease opacity
    image( instructions[0], 30, greeny );
    myReverseBox.setPosition( 600, height/2 );
  }
  else if( instruct_scene == 3 ){
    keep_score = false;
    image( instructions[4], 0, 0 );
    if (greeny > 0) { greenTest = 0;  } //test if opacity needs to go down
    else if (greeny < -3) { greenTest = 1; } //test if opacity needs to go up
    if (greenTest == 1) { greeny += 0.5; } //increase opacity
    else if (greenTest == 0) { greeny -= 0.5; } //decrease opacity
    image( instructions[0], 30, greeny );
    myReverseBox.setPosition( 600, height/2 );
  }
  else if( instruct_scene == 4 ){
    keep_score = false;
    image( instructions[5], 0, 0 );
    if (greeny > 0) { greenTest = 0;  } //test if opacity needs to go down
    else if (greeny < -3) { greenTest = 1; } //test if opacity needs to go up
    if (greenTest == 1) { greeny += 0.5; } //increase opacity
    else if (greenTest == 0) { greeny -= 0.5; } //decrease opacity
    image( instructions[0], 0, greeny );
    myBox.setVelocity( 0, 0 );
  }
  else if( instruct_scene == 5 ){
    keep_score = false;
    image( instructions[6], 0, 0 );
    if (greeny > 0) { greenTest = 0;  } //test if opacity needs to go down
    else if (greeny < -3) { greenTest = 1; } //test if opacity needs to go up
    if (greenTest == 1) { greeny += 0.5; } //increase opacity
    else if (greenTest == 0) { greeny -= 0.5; } //decrease opacity
    image( instructions[0], 0, greeny );
    myBox.setVelocity( 0, 0 );
  }
  else if( instruct_scene == 6 ){
    keep_score = false;
    image( instructions[7], 0, 0 );
    if (greeny > 0) { greenTest = 0;  } //test if opacity needs to go down
    else if (greeny < -3) { greenTest = 1; } //test if opacity needs to go up
    if (greenTest == 1) { greeny += 0.5; } //increase opacity
    else if (greenTest == 0) { greeny -= 0.5; } //decrease opacity
    image( instructions[0], 0, greeny );
    myBox.setVelocity( 0, 0 );
  }
  else if( instruct_scene == 7 ){
    keep_score = false;
    image( instructions[8], 0, 0 );
    if (greeny > 0) { greenTest = 0;  } //test if opacity needs to go down
    else if (greeny < -3) { greenTest = 1; } //test if opacity needs to go up
    if (greenTest == 1) { greeny += 0.5; } //increase opacity
    else if (greenTest == 0) { greeny -= 0.5; } //decrease opacity
    image( instructions[0], 0, greeny );
  }
  else if( instruct_scene == 8 ){
    keep_score = true;
    image( instructions[9], 0, 0 );
    if (greeny > 0) { greenTest = 0;  } //test if opacity needs to go down
    else if (greeny < -3) { greenTest = 1; } //test if opacity needs to go up
    if (greenTest == 1) { greeny += 0.5; } //increase opacity
    else if (greenTest == 0) { greeny -= 0.5; } //decrease opacity
    image( instructions[0], 0, greeny );
  }
  else if( instruct_scene == 9 ){
    keep_score = true;
    image( instructions[10], 0, 0 );
    if (greeny > 0) { greenTest = 0;  } //test if opacity needs to go down
    else if (greeny < -3) { greenTest = 1; } //test if opacity needs to go up
    if (greenTest == 1) { greeny += 0.5; } //increase opacity
    else if (greenTest == 0) { greeny -= 0.5; } //decrease opacity
    image( instructions[0], 0, greeny );
  }
  else if( instruct_scene == 10 ){
    keep_score = true;
    
    image( instructions[10], 0, 0 );
    if (greeny > 0) { greenTest = 0;  } //test if opacity needs to go down
    else if (greeny < -3) { greenTest = 1; } //test if opacity needs to go up
    if (greenTest == 1) { greeny += 0.5; } //increase opacity
    else if (greenTest == 0) { greeny -= 0.5; } //decrease opacity
    image( instructions[0], 0, greeny );
    
    instruct_opacity += 10;
    fill(0, instruct_opacity);
    rectMode(CORNER);
    rect(0,0, width, height);
    
    if( instruct_opacity >= 200 ){ instruct_scene = 0; game_state = "menu"; }
  }
  
  rectMode(CORNER);
  textAlign(CORNER);
}
