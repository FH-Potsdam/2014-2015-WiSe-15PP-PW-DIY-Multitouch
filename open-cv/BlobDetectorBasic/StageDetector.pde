/**
 * StageDetector Class
 * Uses the OpenCV for Processing library by Greg Borenstein
 * https://github.com/atduskgreg/opencv-processing
 * 
 * @Author: Jordi Tost @jorditost
 * @Author URI: jorditost.com
 *
 * University of Applied Sciences Potsdam, 2014
 */
 
import gab.opencv.*;
import SimpleOpenNI.*;
import java.awt.Rectangle;
import processing.video.*;

// Video Source
static int IMAGE_SRC            = 1;
static int CAPTURE              = 2;
static int KINECT               = 3;

// Detection method
static int EDGES                = 1;
static int IMAGE_DIFF           = 2;

class StageDetector {
  
  PApplet parent;
  
  OpenCV opencv;
  SimpleOpenNI kinect;
  Capture video;
  
  int source = CAPTURE;
  int method = EDGES;
  
  // Public vars
  public int width, height;
  public Boolean backgroundInitialized = false;
  public Boolean stageInitialized = false;
  
  // Private vars
  private PImage background, stage;
  private ArrayList<Contour> contours;
  private ArrayList<Rectangle> stageElements;
  
  private int edgesThreshold     = 95; // 40: Natural light
  private int blobSizeThreshold  = 20;
  private int imageDiffThreshold = 80;
  
  
  //////////////////
  // Constructors
  //////////////////
  
  StageDetector(PApplet theParent, int requestWidth, int requestHeight, int theSource) {
    
    parent = theParent;
    
    width = requestWidth;
    height = requestHeight;
    
    opencv = new OpenCV(parent, width, height);
    
    source = theSource;
    
    if (source == CAPTURE) {
      video = new Capture(parent, width, height);
      video.start();
    } else if (source == KINECT) {
      kinect = new SimpleOpenNI(parent);
      kinect.enableRGB();
    }
  }
  
  // Custom capture device as source
  StageDetector(PApplet theParent, int requestWidth, int requestHeight, String cameraName) {
    
    parent = theParent;
    
    width = requestWidth;
    height = requestHeight;
    
    opencv = new OpenCV(parent, width, height);
    source = CAPTURE;
    
    video = new Capture(parent, requestWidth, requestHeight, cameraName);
    video.start();
  }
  
  // Image as source
  StageDetector(PApplet theParent, String imageSrc) {
    
    parent = theParent;
    
    source = IMAGE_SRC;
    
    background = loadImage(imageSrc);
   
    width = background.width;
    height = background.height;
    
    opencv = new OpenCV(parent, background);
    //opencv = new OpenCV(parent, width, height);
  }
  
  
  /////////////////
  // Set Methods
  /////////////////
  
  void setSource(int theSource) {
    source = theSource;
    
    opencv = new OpenCV(parent, width, height);
    
    if (source == CAPTURE) {
      video = new Capture(parent, width, height);
      video.start();
    } else if (source == KINECT) {
      kinect = new SimpleOpenNI(parent);
      kinect.enableRGB();
    }
  }
  
  void setMethod(int theMethod) {
    method = theMethod;
  }
  
  void setEdgesThreshold(int value) {
    edgesThreshold = value;
    if (method != EDGES) {
      println("You're assigning a threshold for a wrong detection method!");
    }
  }
  
  void setBlobSizeThreshold(int value) {
    blobSizeThreshold = value;
  }
  
  void setImageDiffThreshold(int value) {
    edgesThreshold = value;
    if (method != IMAGE_DIFF) {
      println("You're assigning a threshold for a wrong detection method!");
    }  
  }
  
  
  ////////////////////
  // Detect Methods
  ////////////////////
  
  // Returns an array with bounding boxes
  public ArrayList<Rectangle> detect() {
    
    // Edge Detection
    if (method == EDGES) {
      
      if (source == CAPTURE && video != null) {
        
        if (video.available()) {
          video.read();
        }
        //opencv.useColor();
        opencv.loadImage(video);
        background = opencv.getSnapshot();
      
      } else if (source == KINECT && kinect != null) {
        kinect.update();
        opencv.loadImage(kinect.rgbImage());
        background = opencv.getSnapshot();
      }
      
      opencv.useColor(HSB);
      opencv.setGray(opencv.getS().clone());
      opencv.threshold(edgesThreshold);
      opencv.erode();
      //opencv.invert();
      
    // Image Different (we need 2 images)
    } else if (method == IMAGE_DIFF) {
       
      if (backgroundInitialized) {
 
        pushMatrix();
        scale(0.5);
        image(background, 0, 0);
        popMatrix();
    
        if (stageInitialized) {
      
          // Diff
          opencv.loadImage(background);
          opencv.diff(stage);
      
          // Calculate Threshold
          opencv.threshold(imageDiffThreshold);
          
          // Reduce noise
          opencv.erode();
          //opencv.invert();
      
          // Contours
          contours = opencv.findContours(true,true);
        
          // Edges
          /*opencv.loadImage(thresholdImage);
          
          // Dilate and erode to close holes
          opencv.dilate();
          opencv.erode();
          opencv.findCannyEdges(20,75);*/
        }
      }
    }
    
    contours = opencv.findContours(true, true);
    
    // Get stage elements from contours
    return getStageElements(contours);
  }
  
  // Function that filters stage elements from a given countours array
  // Returns cloned array for perform manipulation outside
  private ArrayList<Rectangle> getStageElements(ArrayList<Contour> contoursArray) {
    
    ArrayList<Rectangle> clonedStageElements = new ArrayList<Rectangle>();
    stageElements = new ArrayList<Rectangle>();
    
    for (Contour contour : contoursArray) {
      noFill();
      stroke(0, 255, 0);
      strokeWeight(3);
      contour.draw();
      
      Rectangle r = contour.getBoundingBox();
      
      if (//(contour.area() > 0.9 * src.width * src.height) ||
          (r.width < blobSizeThreshold || r.height < blobSizeThreshold))
        continue;
      
      stageElements.add(r);
      clonedStageElements.add((Rectangle)(r.clone()));
    }
    
    return clonedStageElements;
  }
  
  
  ///////////////////////////////////////////////
  // Recalculate Background & Stage key images
  ///////////////////////////////////////////////
  
  // When a key is pressed, capture the background image into the backgroundPixels
  // buffer, by copying each of the current frame's pixels into it.
  public void initBackground() {
    println("Background Initialized");
    
    if (source == CAPTURE && video != null) {
      
      if (video.available()) {
        video.read();
      }
      
      //opencv.useColor();
      opencv.loadImage(video);
      background = opencv.getSnapshot();
    
    } else if (source == KINECT && kinect != null) {
      kinect.update();
      opencv.loadImage(kinect.rgbImage());
      background = opencv.getSnapshot();
    }
    
    // Reset stage
    stage = null;
    
    backgroundInitialized = true;
  }
  
  public void initStage() {
    println("Stage Initialized");
    
    if (source == CAPTURE && video.available()) {
      video.read();
      //opencv.useColor();
      opencv.loadImage(video);
      stage = opencv.getSnapshot();
    
    } else if (source == KINECT && kinect != null) {
      kinect.update();
      opencv.loadImage(kinect.rgbImage());
      stage = opencv.getSnapshot();
    }
  
    stageInitialized = true;
  }
  
  
  ///////////////////////
  // Display Functions
  ///////////////////////
  
  public void display() {
    
    if (source == CAPTURE) {
     
      if (video.available()) {
        video.read(); 
      }
      
      image(video, 0, 0);
      
    } else if (source == KINECT) {
      
      kinect.update();
      image(kinect.rgbImage(), 0, 0);
      
    } else if (source == IMAGE_SRC) {
      image(background, 0, 0);
    }
  }
  
  public void displayBackground() {
    if (stage != null) {
      image(stage, 0, 0);
    } else if (background != null) {
      image(background, 0, 0);
    }
  }
  
  void displayContours() {
    
    if (contours == null || contours.size() == 0) 
      return;
      
    noFill();
    strokeWeight(3);
    
    // Contours
    for (Contour contour : contours) {
      noFill();
      stroke(0, 255, 0);
      strokeWeight(3);
      contour.draw();
    } 
  }
  void displayBoundingBoxes() {
  
    if (contours == null || contours.size() == 0) 
      return;
      
    noFill();
    strokeWeight(3);
    
    // Detected stage elements
    for (Rectangle r : stageElements) {  
      stroke(255, 0, 0);
      fill(255, 0, 0, 150);
      strokeWeight(2);
      rect(r.x, r.y, r.width, r.height);
    }
  }
}
