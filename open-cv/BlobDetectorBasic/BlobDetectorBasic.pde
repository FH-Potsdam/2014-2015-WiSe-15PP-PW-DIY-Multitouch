/**
 * Blob Detection
 * Uses the OpenCV for Processing library by Greg Borenstein
 * https://github.com/atduskgreg/opencv-processing
 * 
 * @Author: Jordi Tost @jorditost
 *
 * University of Applied Sciences Potsdam, 2014
 */
 
import gab.opencv.*;
import java.awt.Rectangle;
import processing.video.*;

Capture video;
StageDetector stage;
ArrayList<Rectangle> stageElements;

Boolean realtimeUpdate = true;

void setup() {
  stage = new StageDetector(this, 640, 480, "USB2.0 Camera");
  //stage = new StageDetector(this, 640, 480, CAPTURE);
  //stage = new StageDetector(this, "after4.jpg");
  //stage.setSource(KINECT);
  //stage.setMethod(IMAGE_DIFF);
  stage.setMethod(EDGES);
  stage.setEdgesThreshold(100);
  
  stage.setBlobSizeThreshold(20);
  
  size(stage.width, stage.height);
  frameRate(30);
  
  stageElements = stage.detect();
}

void draw() {
  
  if (stage.method == EDGES && realtimeUpdate) {
    stage.detect();
  }
  
  stage.display();
  //stage.displayBackground();
  stage.displayBoundingBoxes();
  stage.displayContours();
}

void keyPressed() { 
  /*if (key == ENTER) {
    println(">>>>> DETECT!");
    stageElements = stage.detect();
  }*/
  
  if (key == ENTER) {
    stage.initBackground();
    if (stage.method == EDGES) {
      stage.detect();
    }
    
  } else if (key == ' ') {
    
    if (stage.method == IMAGE_DIFF) {
      stage.initStage();
      stage.detect();
    }
  }
}
