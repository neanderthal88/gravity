import fisica.*;
import ddf.minim.*;
Minim minim;
AudioPlayer[] audio = new AudioPlayer[8]; 

FWorld world, reverseWorld;                        // fisica worlds
FCircle myBox, myReverseBox;                       // fisica bodies
Collectible[] collectibles = new Collectible[14];  // collectible objects
Parallax[] parallax_img = new Parallax[3];         // parallax images

boolean[] downKeys = new boolean[4];               // keys down

int startTime;                                     // start time
int timeSoFar;                                     // passed time
int totalTime = 90;                                // time limit
int currentTime;                                   // time remaining
boolean time_running;

int score;                                         // game score
int goal = 2000;                                   // goal score
String score_str;                                  // game score string
String goal_str;                                   // goal score string
String game_state = "menu";                        // game state
int level = 1;                                     // game level
int game_world = 1;                                // game world

float myBox_x = 40;                                // initialize box x
float myBox_y = 80;                                // initialize box y
float myReverseBox_x = 500;                        // initialize reverse box x
float myReverseBox_y = 80;                         // initialize reverse box y

PImage myBox_img, myReverseBox_img;                // player images
PImage myBoxHit_img;                               // player hit image
PImage pause_img;                                  // pause bg image
PImage pauseHover_img;                             // pause hover image

PImage start_img;                                  // start bg image
PImage startGreen_img, startRed_img;               // start green red chars
PImage start2_img;
int txtopacity = 150;                              // start text opacity
int txtopacity_test, greenTest;                    // text opacity test
int menu_opacity = 50;                             // menu opacity
float greeny;                                      // start green guy y pos
boolean menu_transition;                           // menu is transitioning?
boolean menu2_started;                             // second menu?
boolean menu_select_down;                          // direction of menu selection
String menu_selection = "start";                   // start menu selecion
int current_menu_selection_y = 425;                // current ypos of menu selection

String pause_selection = "resume";                 // pause menu selecion
int selection_y;                                   // ypos of selection
int current_selection_y = 255;                     // current ypos of selection
int pause_opacity;                                 // opacity of pause screen
boolean pause_select_down;                         // direction of pause selection
                  
int lose_opacity;                                  // opacity of quit screen
PImage gameOver_img;                               // game over image
String quit_selection = "restart";                 // quit selection
boolean quit_select_down;                          // direction of quit selection

PImage win_img;                                    // game win image
String win_selection = "continue";                 // win selection
boolean win_select_down;                           // direction of win selection

boolean keep_score = true;
int instruct_scene;
int instruct_opacity;
PImage instructions[] = new PImage[11];

PFont font;

void setup(){
  size(1100, 600);
  smooth();
  
  minim = new Minim(this); 
  audio[0] = minim.loadFile("Podington_Bear_-_Wolf.mp3"); audio[0].loop(); //BG
  audio[1] = minim.loadFile("Podington_Bear_-_Twirp_Posse.mp3"); audio[1].loop();
  audio[2] = minim.loadFile("blip.mp3"); 
  audio[3] = minim.loadFile("enter.mp3"); 
  audio[4] = minim.loadFile("pickupcoin.wav");
  audio[5] = minim.loadFile("hurt.wav");
  audio[6] = minim.loadFile("win.mp3");
  audio[7] = minim.loadFile("lose.wav");
  
  Fisica.init(this);
  font = loadFont("Consolas-Bold-48.vlw");
  startTime = millis()/1000;
  
  // load in player images
  myBox_img =         loadImage("img/myBox.png");
  myReverseBox_img =  loadImage("img/myReverseBox.png");
  myBoxHit_img =      loadImage("img/myBox_hit.png");
  pause_img =         loadImage("img/pause.png");
  pauseHover_img =    loadImage("img/pause-hover.png");
  gameOver_img =      loadImage("img/quit.png");
  start_img =         loadImage("img/start.png");
  win_img =           loadImage("img/win.png");
  startGreen_img =    loadImage("img/start_green.png");
  startRed_img =      loadImage("img/start_red.png");
  start2_img =        loadImage("img/start2.png");
  
  parallax_img[0] = new Parallax( "sky", 0, 0 );
  parallax_img[2] = new Parallax( "foreground", 1, 284 );
  parallax_img[1] = new Parallax( "mg", 0.5, 0 );
  
  for( int i=0; i < instructions.length; i++ ) instructions[i] = loadImage("img/instructions/" + i + ".png");
    
  // set up the world
  world = new FWorld();
  world.setEdges( 0, 60, width/2, height-20, color(255,0) );
  
  reverseWorld = new FWorld();
  reverseWorld.setEdges( width/2, 60, width, height-20, color(255,0) );
  reverseWorld.setGravity(0, -100);
  
  // set up collectibles
  for( int i=0; i < (collectibles.length)/2; i++ ) collectibles[i] = new Collectible(world, width/2 );
  for( int i = (collectibles.length)/2; i < collectibles.length; i++ ) collectibles[i] = new Collectible(reverseWorld, width );
  
  playerSetup();
}


void draw(){
  textFont(font, 20);
  
  // operate timer
  if( time_running ) currentTime = ( millis() - startTime ) / 1000;
  else{ startTime = millis() - timeSoFar; currentTime = timeSoFar / 1000; }
  
  if     ( game_state == "play" )  play();
  else if( game_state == "pause" ) pause();
  else if( game_state == "lose" )  lose();
  else if( game_state == "menu" )  menu();
  else if( game_state == "win" )   win();
  else if( game_state == "instructions" ) instructions();
}

int pulse(int visible, int test, int max, int min, float change){
  if (visible > max) { test = 0;  } //test if opacity needs to go down
  else if (visible < min) { test = 1; } //test if opacity needs to go up
  if (test == 1) { visible += change; } //increase opacity
  else if (test == 0) { visible -= change; } //decrease opacity
  return visible;
}
