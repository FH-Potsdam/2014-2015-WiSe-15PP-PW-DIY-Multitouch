#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
    cam.setVerbose(true);
    cam.initGrabber(320, 240);
    colorImg.allocate(320,240);
    grayImage.allocate(320,240);
	finder.setup("haarcascade_frontalface_default.xml");
}

//--------------------------------------------------------------
void ofApp::update(){
    
    cam.update();
    if (cam.isFrameNew()) {
        colorImg.setFromPixels(cam.getPixels(), 320,240);
        grayImage = colorImg;
        finder.findHaarObjects(grayImage);
    }
}

//--------------------------------------------------------------
void ofApp::draw(){
	//cam.draw(0, 0);
    
    ofSetHexColor(0xffffff);
    colorImg.draw(0,0, 640, 480);
    
	ofNoFill();
    ofPushMatrix();
    ofScale(2, 2);
	for(unsigned int i = 0; i < finder.blobs.size(); i++) {
		ofRectangle cur = finder.blobs[i].boundingRect;
		ofRect(cur.x, cur.y, cur.width, cur.height);
	}
    ofPopMatrix();
}