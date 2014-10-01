/**
 * CameraCheck
 * Simple sketch that prints the list of available cameras and initiates a live capture
 * 
 * Modified by Jordi Tost @jorditost from:
 * http://www.processing.org/reference/libraries/video/Capture.html
 *
 * @updated: 25/09/2014
 */
 
import processing.video.*;

Capture cam;

void setup() {
  size(640, 480);

  String[] cameras = Capture.list();
  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    // This will print a list of the available cameras 
    // the Build-in camera (FaceTime HD Camera in Mac) 
    // and an USB Camera, if there is any connected.
    // For each, different size/fps options will be prompt
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
    
    // 1. The camera can be initialized directly using an 
    // element from the array returned by list():
    cam = new Capture(this, cameras[0]);
    
    // 2. CHANGE TO THIS:
    // Select the camera by its size, name and fps
    // You can check this values in the cameras list
    // Sintax: Capture(parent, requestWidth, requestHeight, cameraName, frameRate)
    //cam = new Capture(this, 640, 480, "USB2.0 PC CAMERA");
    
    cam.start();     
  }      
}

void draw() {
  if (cam.available() == true) {
    cam.read();
  }
  image(cam, 0, 0);
  // The following does the same, and is faster when just drawing the image
  // without any additional resizing, transformations, or tint.
  //set(0, 0, cam);
}
