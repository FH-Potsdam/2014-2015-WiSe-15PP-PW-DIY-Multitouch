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
int blobSizeThreshold = 20;

void setup() {
  frameRate(15);
  
  //video = new Capture(this, 640, 480);
  video = new Capture(this, 640, 480, "USB2.0 PC CAMERA");
  video.start();
  
  opencv = new OpenCV(this, 640, 480);
  size(opencv.width, opencv.height, P2D);
  contours = new ArrayList<Contour>();
}

void draw() {
  
  //brightness = (int)map(mouseX, 0, width, -255, 255);
  //contrast = map(mouseX, 0, width, 0.0, 10.0);
  //println("brightness: " + brightness + ", contrast: " + contrast);
  
  //threshold = (int)map(mouseX, 0, width, 0, 255);
  //println("Image threshold: " + threshold);
  
  //blobSizeThreshold = (int) map(mouseX, 0, width, 0, 80);
  //println("Blob size threshold: " + blobSizeThreshold);
  
  // Read last captured frame
  if (video.available()) {
    video.read();
  }
  
  // Load the new frame of our camera in to OpenCV
  //opencv.useColor();
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
  
  //int blockSize = (int)map(mouseX, 0, width, 1, 700);
  //if (blockSize%2 == 0) blockSize++;
  //if (blockSize < 3) blockSize = 3;
  //println("block size: " + blockSize);
  
  //int c = (int)map(mouseY, 0, height, -100, 100);
  //println("c: " + c);
  //opencv.adaptiveThreshold(489, 45); // 489, 45 - 491, 1
  
  // Filter the image based on threshold - range [0, 255]
  opencv.threshold(threshold);

  // Invert (black bg, white blobs)
  opencv.invert();
  
  // Reduce noise - Dilate and erode to close holes
  opencv.dilate();
  opencv.erode();
  
  // Blur
  opencv.blur(4);
  
  // Save snapshot for display
  processedImage = opencv.getSnapshot();
  
  ///////////////////////////////
  // <3> FIND CONTOURS  
  ///////////////////////////////
  
  // Passing 'true' sorts them by descending area.
  contours = opencv.findContours(true, true);
  
  // Save snapshot for display
  contoursImage = opencv.getSnapshot();
  
  // Draw
  displayImages();
  //displayContours();
  displayContoursBoundingBoxes();
}

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
  text("Contours", src.width/2 + 10, src.height/2 + 25);
}

void displayContours() {
    
  pushMatrix();
  scale(0.5);
  translate(width, height);
  
  noFill();
  strokeWeight(3);
  
  // Contours
  for (Contour contour : contours) {

    noFill();
    stroke(0, 255, 0);
    strokeWeight(3);
    contour.draw();
  }
  popMatrix();
}

void displayContoursBoundingBoxes() {
  
  pushMatrix();
  scale(0.5);
  translate(width, height);
  
  noFill();
  strokeWeight(3);
  
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
  popMatrix();
}


