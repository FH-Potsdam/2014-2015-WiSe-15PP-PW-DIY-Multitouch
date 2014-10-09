#pragma once

#include "ofMain.h"
#include "ofxCvHaarFinder.h"

class ofApp : public ofBaseApp{
	public:
		void setup();
		void update();
		void draw();

		ofxCvColorImage     colorImg;
        ofxCvGrayscaleImage grayImage;
		ofxCvHaarFinder     finder;
        ofVideoGrabber      cam;
};
