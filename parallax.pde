/**
 * Parallax (img-file-name, parallax-speed, y-position) 
 * Allows parallaxing graphics.
 */

class Parallax{
  float xpos, ypos;
  float speed;
  
  PImage img;
  
  Parallax(String x, float s, float y){
    img = loadImage("img/" + x + ".png");
    speed = s;
    ypos = y;
  }
  
  void display(){
    image( img, xpos, ypos );
  }
  
  void update(){
    xpos -= speed;
  }
}
