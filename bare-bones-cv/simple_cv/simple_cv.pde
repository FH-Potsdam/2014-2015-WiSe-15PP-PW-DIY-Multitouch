// bare_bones_cv
// written by Juri Wolf @Amerlander
// minor edits by Fabian @Fabiantheblind Moron Zirfas

import processing.video.*; // Library for camera
Capture cam; // new capture object
ArrayList <Particle> agents; // ArrayLsit for particles

void setup() {
  size(640, 480); // canvas size
  String[] cameras = Capture.list(); // get all attached cameras
  agents = new ArrayList<Particle>(); // init the arraylist

  if (cameras.length == 0) { // if there is no cam...
    println("There are no cameras available for capture."); // discribe the error
    exit(); // and end the programm
  } else {  
    // yay there is a camera
    println("Available cameras:"); // Print all cameras
    for (int i = 0; i < cameras.length; i++) { // loop the possible cameras
      println(cameras[i]); // list it
    }

    cam = new Capture(this, cameras[1]); // cameras[x] contains the desired cam
    cam.start();  // start the capture
  }
}

void draw() { 
  fill(0); // delete the background by drawing a rectangle
  noStroke();
  rect(0, 0, width, height); // this is the rectangle
  if (cam.available() == true) { // allways check if the camera is there
    cam.read(); // read the imaoge
  } 
  cam.filter(THRESHOLD, 0.3); // apply threshold filter of 0,3 
  cam.filter(BLUR, 4); // apply blur
  cam.filter(THRESHOLD, 0.2); //more threshold
  cam.filter(INVERT); // invert the image
  // if you want to see the source image 
  // uncomment the following line
  // image(cam, 0, 0); // source image for tracing

  for (int px_x = 0; px_x < 640; px_x+=10) { // vertical every tenth pixel
    for (int px_y = 0; px_y < 480; px_y+=10) { // horizontal every tenth pixel
      if (cam.get(px_x, px_y) >= -10) { // if the pixel value is white...

        agents.add(new Particle(px_x, px_y)); // add a particle
      } // End if white
    } // End for px_y
  } // End for px_x

  for (int k = 0; k < agents.size (); k++) { // loop the particles
    agents.get(k).run(); // move each particle
  } // End of particle update loop
} // End Draw


class Particle {

  float x = 0;// his x pos
  float y = 0;//his y pos
  // Constructor
  Particle(float _x, float _y) {
    x = _x;
    y = _y;
  } //end Constructor

  void display() {
    stroke(220); 
    // every particle lifes in his own world
    // push the matrix and translate it to his xy coordiante
    pushMatrix();
    translate(x, y);
    // draw the particle at 0,0 of his world
    ellipse(0, 0, 2, 2); // draw an ellipse

    popMatrix(); // set the world back
  } // display

  void move() {
    x += random(-10, 10); // movement to left right
    y += random(-50, 0); // Bewegung up down

    x = constrain(x, 0, width); // keep x on screen
    y = constrain(y, 0, height); // keep y on screen
  } // move

  void run() {
    // call all its inner functions together
    //
    display();
    move();
  } // run
} // End particle class 

