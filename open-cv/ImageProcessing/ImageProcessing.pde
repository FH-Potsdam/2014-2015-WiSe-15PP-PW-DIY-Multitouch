import gab.opencv.*;
import java.awt.Rectangle;
import processing.video.*;

OpenCV opencv;
Capture video;
PImage src, processedImage, processedImage2, contoursImage;
ArrayList<Contour> contours;
int threshold = 75;
int blobSizeThreshold = 20;

void setup() {
  frameRate(15);
  
  video = new Capture(this, 640, 480, "USB2.0 Camera");
  video.start();
  
  opencv = new OpenCV(this, 640, 480);
  size(opencv.width, opencv.height, P2D);
  contours = new ArrayList<Contour>();
}

void draw() {
  
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
  
  // Gray channel
  opencv.gray();
  
  // <1> PRE-PROCESS IMAGE
  
  // Filter the image based on threshold - range [0, 255]
  opencv.threshold(threshold);

  // Invert (black bg, white blobs)
  opencv.invert();
  
  // Reduce noise - Erode contracts white areas of the image
  opencv.erode();
  
  // Dilate and erode to close holes
  //opencv.dilate();
  //opencv.erode();
  
  // Save snapshot for display
  processedImage = opencv.getSnapshot();
  
  // <2> MORE PROCESSING
  
  // Reduce noise - Dilate and erode to close holes
  //opencv.erode();
  //opencv.dilate();
  
  // Blur
  opencv.blur(4);
  
  // Save snapshot for display
  processedImage2 = opencv.getSnapshot();
  
  // <3> FIND CONTOURS in our range image - Passing 'true' sorts them by descending area.
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
  image(processedImage, width, 0);
  image(processedImage2, 0, height);
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


