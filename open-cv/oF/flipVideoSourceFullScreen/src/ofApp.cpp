#include "ofApp.h"

using namespace cv;
using namespace ofxCv;

void ofApp::setup() {
	cam.initGrabber(640, 480);
	image.allocate(640, 480, OF_IMAGE_GRAYSCALE);
}

void ofApp::update() {
	cam.update();
	if(cam.isFrameNew()) {
        image.setFromPixels(cam.getPixelsRef());
        image.mirror(false, true);
		image.update();
	}
}

void ofApp::draw() {
	//cam.draw(0, 0);
    float imgWidth = ofGetScreenWidth();
    float imgHeight = float(480.0/640.0) * imgWidth;
    
	image.draw(0, -0.5*(imgHeight-ofGetScreenHeight()), imgWidth, imgHeight);
    
    // to map a circle, for example
    ofMap
}
