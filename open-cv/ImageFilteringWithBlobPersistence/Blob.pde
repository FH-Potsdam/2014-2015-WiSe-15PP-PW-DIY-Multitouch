/**
 * Blob Class
 *
 * Based on this example by Daniel Shiffman:
 * http://shiffman.net/2011/04/26/opencv-matching-faces-over-time/
 * 
 * @author: Jordi Tost @jorditost
 * @modified: 06/10/2014
 * 
 * University of Applied Sciences Potsdam, 2014
 */

class Blob {
  
  // A Rectangle
  Rectangle r;
  
  // Am I available to be matched?
  boolean available;
  
  // Should I be deleted?
  boolean delete;
  
  // How long should I live if I have disappeared?
  int initTimer = 5; //127;
  int timer;
  
  // Unique ID for each blob
  int id;
  
  // Make me
  Blob(int newID, int x, int y, int w, int h) {
    r = new Rectangle(x,y,w,h);
    available = true;
    delete = false;
    id = newID;
    timer = initTimer;
  }

  // Show me
  void display() {
    float opacity = map(timer, 0, initTimer, 0, 127);
    fill(0,0,255,opacity);
    stroke(0,0,255);
    rect(r.x, r.y, r.width, r.height);
    fill(255,2*opacity);
    textSize(26);
    text(""+id, r.x+10, r.y+30);
  }

  // Give me a new location / size
  // Oooh, it would be nice to lerp here!
  void update(Rectangle newR) {
    r = (Rectangle) newR.clone();
  }

  // Count me down, I am gone
  void countDown() {    
    timer--;
    println("coundown - ID: " + id + ", timer: " + timer);
  }

  // I am deed, delete me
  boolean dead() {
    if (timer < 0) return true;
    return false;
  }
}

