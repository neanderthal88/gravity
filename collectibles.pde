/**
 * Classes:
 * Collectible (Fisica World, World-Width)
 * Objects that the player can collect. Can be "good" or "bad" state.
 *
 * Object (Fisica World)
 * Objects that the player collides into.
 */

class Collectible{
  float xpos, ypos;
  float thresh = 30;
  float opacity;
  float opacity_test;
  
  color tempcolor = color(0);
  
  String state = "good";
  
  PImage img = loadImage("img/enemy.png");
  
  Collectible(FWorld world, int world_width){
    xpos = random( world_width - width/2, world_width );
    ypos = random( 70, height - 30 );
  }
  
  void display(){
    fill(tempcolor);
    noStroke();
    
    imageMode(CENTER);
    image(img, xpos, ypos);
    ellipse( xpos, ypos, 10, 10 );
    imageMode(CORNER);
    
  }
  
  void update(){
    if( xpos > -10 ) xpos -= 2;
    else if (game_state != "lose" ) resetpos();
    
    if( state == "good" ){ tempcolor = color(255); }      
    else if( state == "bad" ){ 
      if (opacity > 100) { opacity_test = 0;  } //test if opacity needs to go down
      else if (opacity < 50) { opacity_test = 1; } //test if opacity needs to go up
      if (opacity_test == 1) { opacity += 5; } //increase opacity
      else if (opacity_test == 0) { opacity -= 5; } //decrease opacity
      
      if( opacity < 100 ) opacity++;
      tempcolor = color(0, opacity);
    }
    
    collision();
  }
  void collision(){
    float box_dist     = dist( myBox.getX(), myBox.getY(), xpos, ypos );
    float rev_box_dist = dist( myReverseBox.getX(), myReverseBox.getY(), xpos, ypos );
    if( rev_box_dist < thresh ){ state = "bad"; }
    if( box_dist < thresh){ 
      if( state == "good" && keep_score ){ 
        score += 100;
        audio[4].play(); audio[4].rewind(); 
      }
      else if( state == "bad" && keep_score ){ 
        score -= 300; 
        audio[5].play(); audio[5].rewind();
      }
      resetpos();
    }
  }
  
  void resetpos(){
    xpos = random( width, width + 400 );
    ypos = random( 70, height - 30 );
    state = "good";
  }
}

class Obstacle{
  FBox box;
  float xpos, ypos;
  
  Obstacle(FWorld world){
    xpos = random( width/2 - 10 );
    ypos = random( height );
    
    box = new FBox( 10, 10 );
    box.setPosition( xpos, ypos );
    box.setStatic(true);
    world.add(box);    
  }
  
  void display(){
    ellipse( xpos, ypos, 10, 10 );
  }
}
