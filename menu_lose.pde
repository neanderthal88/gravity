/**
 * Menu state: navigate to start or instructions
 * Lose state: display game over
 * Win state: increase level
 */
 
void menu(){
  image( start_img, 0, 0 );
  audio[1].pause(); audio[1].rewind();
  audio[0].play(); 
  
  // transition in after instructions
  if(instruct_opacity >= 50) instruct_opacity -= 10;
  else instruct_opacity = 0;
  fill(0, instruct_opacity);
  rect(0,0, width, height);
  
  // enter text
  textAlign(CENTER);
  if (txtopacity > 220) { txtopacity_test = 0;  } //test if opacity needs to go down
  else if (txtopacity < 120) { txtopacity_test = 1; } //test if opacity needs to go up
  if (txtopacity_test == 1) { txtopacity += 8; } //increase opacity
  else if (txtopacity_test == 0) { txtopacity -= 8; } //decrease opacity
  if( !menu2_started ){
    fill(0, txtopacity);
    textSize(24);
    text("PRESS ENTER", width/2, 440);
    textAlign(CORNER);
  }
  
  if( menu2_started ){
    if     ( menu_selection == "start" )  selection_y = 425;
    else if( menu_selection == "instructions" ) selection_y = 467;
    
    if( current_menu_selection_y < selection_y && menu_select_down ){ current_menu_selection_y += 7; }
    else menu_select_down = false;
    if( current_menu_selection_y > selection_y && !menu_select_down ){ current_menu_selection_y -= 7; }
    
    image(pauseHover_img,0, current_menu_selection_y);
    image(start2_img, 0, 0);
  } // End menu 2
  
  if (greeny > 0) { greenTest = 0;  } //test if opacity needs to go down
  else if (greeny < -10) { greenTest = 1; } //test if opacity needs to go up
  if (greenTest == 1) { greeny += 0.5; } //increase opacity
  else if (greenTest == 0) { greeny -= 0.5; } //decrease opacity
  image( startGreen_img, 0, greeny );
  image( startRed_img, 0, greeny );
  
  // menu_transition = true if enter is hit on menu screen
  if( menu_transition ){
    menu_opacity += 10;
    fill(0, menu_opacity);
    rect(0,0, width, height);
      
    if( menu_opacity >= 190 ){
      if( menu_selection == "start") game_state = "play";
      else if( menu_selection == "instructions") game_state = "instructions"; 
      menu_transition = false; 
      menu2_started = false;
    }
  } // End menu transition
}

void lose(){
  // draw background
  for(int i=0; i < parallax_img.length; i++) parallax_img[i].display();
    
  // set up worlds
  world.step();
  world.draw();
  
  reverseWorld.step();
  reverseWorld.draw();
  
  // player animation
  myReverseBox.setVelocity( 0, 80 );
  myBox.setVelocity( 0, 80 );
  
  // pause time
  if(time_running){
    timeSoFar = millis()-startTime;
    time_running = false;
  }
    
  // draw collectibles
  for( int i=0; i < collectibles.length; i++ ){ collectibles[i].display(); collectibles[i].update(); }
    
  levels();    // level settings
  topbar();    // draw topbar
  
  if( lose_opacity < 150 ) lose_opacity += 5;
  fill(0, lose_opacity);
  rect(0,0, width, height);
  
  if     ( quit_selection == "restart" )  selection_y = 255;
  else if( quit_selection == "exit" )     selection_y = 303;
  
  if( current_selection_y < selection_y && quit_select_down ){ current_selection_y += 7; }
  else quit_select_down = false;
  if( current_selection_y > selection_y && !quit_select_down ){ current_selection_y -= 7; }
  
  image(pauseHover_img,0, current_selection_y);
  image(gameOver_img, 0, 0);
}

void win(){
  // draw background
  for(int i=0; i < parallax_img.length; i++) parallax_img[i].display();
  
  // set up worlds
  world.step();
  world.draw();
  
  reverseWorld.step();
  reverseWorld.draw();
  
  // pause time
  if(time_running){
    timeSoFar = millis()-startTime;
    time_running = false;
  }
    
  // draw collectibles
  for( int i=0; i < collectibles.length; i++ ){ collectibles[i].display(); collectibles[i].update(); }
    
  levels();    // level settings
  topbar();    // draw topbar
  
  if     ( win_selection == "continue" )  selection_y = 255;
  else if( win_selection == "exit" )     selection_y = 303;
  
  if( current_selection_y < selection_y && win_select_down ){ current_selection_y += 7; }
  else win_select_down = false;
  if( current_selection_y > selection_y && !win_select_down ){ current_selection_y -= 7; }
  
  image(pauseHover_img,0, current_selection_y);
  image(win_img, 0, 0);
}
