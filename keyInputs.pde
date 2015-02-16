/**
 * Key Inputs: Actions on key press and key release.
 * Array downKeys[] allows for multi-key input.
 */

void keyInputs(){
  /** keyboard inputs
    * 0 = right
    * 1 = left
    * 2 = up
    * 3 = down
    **/
  if ( downKeys[0] ){ 
    myBox.adjustVelocity( 10, 0 );
    myReverseBox.adjustVelocity( 10, 0 );
  }
  if ( downKeys[1] ){ 
    myBox.adjustVelocity( -10, 0 );
    myReverseBox.adjustVelocity( -10, 0 );
  }
  if ( downKeys[2] ){ 
    myBox.adjustVelocity( 0, -20 );
    myReverseBox.adjustVelocity( 0, -20 );
  }
  if ( downKeys[3] ){ 
    myBox.adjustVelocity( 0, 20 );
    myReverseBox.adjustVelocity( 0, 20 );
  }
}



void keyPressed(){  
  if( key == CODED ){
    if     ( keyCode == RIGHT ) { downKeys[0] = true; } 
    else if( keyCode == LEFT )  { downKeys[1] = true; } 
    else if( keyCode == UP )    { 
      downKeys[2] = true; 
      
      if( game_state == "pause"){
        if     ( pause_selection == "exit" )  pause_selection = "restart";
        else if( pause_selection == "restart" ) pause_selection = "resume";
      }
      
      else if( game_state == "lose"){
        if ( quit_selection == "exit" )  quit_selection = "restart";
      }
      
      else if( game_state == "win"){
        if ( win_selection == "exit" )  win_selection = "continue";
      }
      else if( game_state == "menu" ){
        if ( menu2_started ){
          if( menu_selection == "instructions" ) menu_selection = "start";
        }
      }
    } 
    
    else if( keyCode == DOWN )  { 
      downKeys[3] = true; 
      
      if( game_state == "pause"){
        if     ( pause_selection == "resume" )  pause_selection = "restart";
        else if( pause_selection == "restart" ) pause_selection = "exit";
        pause_select_down = true;
      }
      
      else if( game_state == "lose"){
        if ( quit_selection == "restart" )  quit_selection = "exit";
        quit_select_down = true;
      }
      
      else if( game_state == "win"){
        if ( win_selection == "continue" )  win_selection = "exit";
        win_select_down = true;
      }
      else if( game_state == "menu"){
        if( menu2_started ){
          if ( menu_selection == "start" )  menu_selection = "instructions";
          menu_select_down = true;
        }
      }
    } // End if keyCode == DOWN
  } // End if( key == CODED )
  
  if( key == ENTER || key == RETURN ){     
    if ( game_state == "pause" ){ 
      if     ( pause_selection == "resume"  ){ game_state = "play"; }
      else if( pause_selection == "restart" ){ restart(); game_state = "play"; }
      else if( pause_selection == "exit" ){ restart(); game_state = "menu"; }
      pause_opacity = 0;
    }
    else if ( game_state == "lose" ){ 
      if( quit_selection == "restart" ){ restart(); game_state = "play"; }
      else if( quit_selection == "exit" ){ restart(); game_state = "menu"; }
      lose_opacity = 0;
    }
    else if ( game_state == "win" ){ 
      if( win_selection == "continue" ){ restart(); game_state = "play"; }
      else if( win_selection == "exit" ){ restart(); game_state = "menu"; }
    }
    else if( game_state == "play" ) game_state = "pause";
    else if( game_state == "menu" ){ 
      if( menu2_started ){ menu_transition = true; }  
      menu2_started = true;    
    }
    else if( game_state == "instructions" ){
      instruct_scene++;
      menu_selection = "start";
      if( instruct_scene >= 11 ){ instruct_scene = 0; restart(); }
    }
    
    // reset selections once a choice is made
    current_menu_selection_y = 425;
    current_selection_y = 255; 
    
    if( game_state != "instructions" ){ audio[3].play(); audio[3].rewind(); }
    else{ audio[2].play(); audio[2].rewind(); }
  } // End ENTER pressed
} // End keyPressed

void keyReleased(){
  if( key == CODED ){
    if     ( keyCode == RIGHT ) { downKeys[0] = false; } 
    else if( keyCode == LEFT )  { downKeys[1] = false; } 
    else if( keyCode == UP )    { downKeys[2] = false; } 
    else if( keyCode == DOWN )  { downKeys[3] = false; }
  }
}
