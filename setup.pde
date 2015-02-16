/**
 * Setup for both controllable players
 */

void playerSetup(){
  // normal gravity circle
  myBox = new FCircle( 50 );
  myBox.setRestitution( 0.5 );
  myBox.setPosition( 100, height/2 );
  myBox.setVelocity( 10, -10);
  myBox.setFillColor(color(random(255), random(255), random(255)));
  myBox.attachImage( myBox_img );
  world.add(myBox);
  
  // reverse gravity circle
  myReverseBox = new FCircle( 50 );
  myReverseBox.setRestitution( 0.5 );
  myReverseBox.setPosition( 600, height/2 );
  myReverseBox.setVelocity( 10, -10 );
  myReverseBox.setFillColor( color(random(255), random(255), random(255)) );
  myReverseBox.attachImage( myReverseBox_img );
  reverseWorld.add(myReverseBox);
}
