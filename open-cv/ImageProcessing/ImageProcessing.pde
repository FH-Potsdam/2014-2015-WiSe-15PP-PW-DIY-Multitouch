/**
 * Image Processing
 * This sketch does some image filtering to prepare the image for blob segmentation
 *
 * It uses the OpenCV for Processing library by Greg Borenstein
 * https://github.com/atduskgreg/opencv-processing
 * 
 * @author: Jordi Tost @jorditost
 * @modified: 26/09/2014
 * 
 * University of Applied Sciences Potsdam, 2014
 */
 
import gab.opencv.*;
import java.awt.Rectangle;
import processing.video.*;

OpenCV opencv;
Capture video;
PImage src, preProcessedImage, processedImage, contoursImage;
ArrayList<Contour> contours;

float contrast = 1.35;
int brightness = 0;
int threshold = 75;
boolean useAdaptiveThreshold = false; // use basic thresholding
int thresholdBlockSize = 489;
int thresholdConstant = 45;
int blurSize = 4;
int blobSizeThreshold = 20;

void setup() {
  frameRate(15);
  
  video = new Capture(this, 640, 480);
  //video = new Capture(this, 640, 480, "USB2.0 PC CAMERA");
  video.start();
  
  opencv = new OpenCV(this, 640, 480);
  contours = new ArrayList<Contour>();
  
  size(opencv.width, opencv.height, P2D);
}

void draw() {
  
  // Read last captured frame
  if (video.available()) {
    video.read();
  }
  
  // Load the new frame of our camera in to OpenCV
  opencv.loadImage(video);
  src = opencv.getSnapshot();
  
  ///////////////////////////////
  // <1> PRE-PROCESS IMAGE
  // - Grey channel 
  // - Brightness / Contrast
  ///////////////////////////////
  
  // Gray channel
  opencv.gray();
  
  //opencv.brightness(brightness);
  opencv.contrast(contrast);
  
  // Save snapshot for display
  preProcessedImage = opencv.getSnapshot();
  
  ///////////////////////////////
  // <2> PROCESS IMAGE
  // - Threshold
  // - Noise Supression
  ///////////////////////////////
  
  // Adaptive threshold - Good when non-uniform illumination
  if (useAdaptiveThreshold) {
    
    // Block size must be odd and greater than 3
    if (thresholdBlockSize%2 == 0) thresholdBlockSize++;
    if (thresholdBlockSize < 3) thresholdBlockSize = 3;
    
    opencv.adaptiveThreshold(thresholdBlockSize, thresholdConstant);
    
  // Basic threshold - range [0, 255]
  } else {
    opencv.threshold(threshold);
  }

  // Invert (black bg, white blobs)
  opencv.invert();
  
  // Reduce noise - Dilate and erode to close holes
  opencv.dilate();
  opencv.erode();
  
  // Blur
  opencv.blur(blurSize);
  
  // Save snapshot for display
  processedImage = opencv.getSnapshot();
  
  ///////////////////////////////
  // <3> FIND CONTOURS  
  ///////////////////////////////
  
  // Passing 'true' sorts them by descending area.
  contours = opencv.findContours(true, true);
  
  // Save snapshot for display
  contoursImage = opencv.getSnapshot();
  
  // Display images
  displayImages();
    
  // Display contours in the lower right window
  pushMatrix();
    scale(0.5);
    translate(src.width, src.height);
  
    displayContours();
    displayContoursBoundingBoxes();
      
  popMatrix();
}

///////////////////////
// Display Functions
///////////////////////

void displayImages() {
  
  pushMatrix();
  scale(0.5);
  image(src, 0, 0);
  image(preProcessedImage, width, 0);
  image(processedImage, 0, height);
  image(src, width, height);
  popMatrix();
  
  stroke(255);
  fill(255);
  text("Source", 10, 25); 
  text("Pre-processed Image", src.width/2 + 10, 25); 
  text("Processed Image", 10, src.height/2 + 25); 
  text("Tracked Points", src.width/2 + 10, src.height/2 + 25);
}

void displayContours() {
  
  for (int i=0; i<contours.size(); i++) {
  
    Contour contour = contours.get(i);

    noFill();
    stroke(0, 255, 0);
    strokeWeight(3);
    contour.draw();
  }
}

void displayContoursBoundingBoxes() {
  
  for (int i=0; i<contours.size(); i++) {
    
    Contour contour = contours.get(i);
    Rectangle r = contour.getBoundingBox();
    
    if (//(contour.area() > 0.9 * src.width * src.height) ||
        (r.width < blobSizeThreshold || r.height < blobSizeThreshold))
      continue;
    
    stroke(255, 0, 0);
    fill(255, 0, 0, 150);
    strokeWeight(2);
    rect(r.x, r.y, r.width, r.height);
  }
}


