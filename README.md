2014-2015-WiSe-15PP-PW-DIY-Multitouch
=====================================

DIY (Multi) Touch (less) Human Computer Interaction (Projektwochen)  

An open-ended exploration of touch, multitouch, computervision- and capacitive systems. In the foreground is an effective but low-cost implementation that can be ported to other projects, no material battle. Depending on the amount of participants one of the technologies mentioned is researched in groups, prototyped and applied. The aim is an exhibition at the end of the project weeks. 



##Timetable:   

__Day 1 || Mo 06.10 LW 126:__  

- Introduction Juri, Jordi, Fabian  
- Introduction project  
- Brief and incomplete history of MT  
- Example MT projects  
- Form groups
- Workshop Touch Box  
- excercise

__Day || 2 - 5 Di 07.10 - Fr 10.10 LW 126:__  

- development and prototyping LW 126

__Day 6 - 10 || Mo 13.10 - Do 16.10 Home & Foyer:__

- development and prototyping home and LW corridor

__Day 10 || Fr. 17.10 Foyer:__

- Exhibition 


###Software:

#### Processing Libs & Docs

- [Processing Libs Directory](http://processing.org/reference/libraries/)
- [Processing Video Lib](http://processing.org/reference/libraries/video/index.html)
- [Processing TUIO Lib](http://prdownloads.sourceforge.net/reactivision/TUIO_Processing-1.4.zip?download)
- [Camera Input Example](http://www.processing.org/reference/libraries/video/Capture.html)

#### Computer Vision / Blob Detection

- [OpenCV for Processing](https://github.com/atduskgreg/opencv-processing): Processing Computer Vision library and examples. This includes, brightness and contrast operations, image filtering, contour and edges detection, marker detection, background substraction and more CV operations.
- [Blobscanner](https://github.com/robdanet/blobscanner): Blob detection lib for Processing
- [flob](http://s373.net/code/flob/): Alternative to OpenCV. For Processing and openFrameworks
- [BlobDetection](http://www.v3ga.net/processing/BlobDetection/): Blob detection lib for Processing (Old. Last updated Oct. 2012)

#### Software Communication Protocol

- [TUIO](http://tuio.org/)

#### Arduino Libs & Docs  

- [oscuino](http://cnmat.berkeley.edu/oscuino)  

###Hardware:

####Cameras

#####PS3 Eye Camera
- Inexpensive - 9€ aprox. Check [here](http://www.amazon.de/dp/B000W3YQ1Y/ref=pe_386171_51767411_TE_M3T1_dp_1)
- High Resolution/Frame Rate - 320x240 resolution 125fps max, 640x480 resolution 75fps
- Best camera for building optical MT tracking systems because of its amazing camera sensor and ease of modification.

Source: [http://www.peauproductions.com/cameras.html](http://www.peauproductions.com/cameras.html)

We expirenced some issues using the PSEye3 camera with Processing under Mac OSX. Mountain Lion seems not to work at all.  
- To use the camera with Mac OSX 10.9.4 you need to use Processing 1.5.1 or 2.0.3 which you can [download here](https://code.google.com/p/processing/downloads/list).  
- Install [Mac OSX: macam driver](http://webcam-osx.sourceforge.net/)  

- and a [hacky solution](http://forum.processing.org/one/topic/ps3-eyecam-under-osx-10-8.html) for Mountain Lion (did not work yet).  
- [Windows driver](http://codelaboratories.com/products/eye/driver/)


###Useful Links   
Links for things.

####Camera Hack: 

- [Hack PS3 Eyecam](http://createdigitalmotion.com/2009/08/trick-out-your-ps3-eye-webcam-best-cam-for-vision-augmented-reality/)  

####Physical:

- [Knock Sensor Tutorial (Piezo)](http://www.arduino.cc/en/Tutorial/KnockSensor)  
- [Knock Tutorial (Piezo)](http://arduino.cc/en/Tutorial/Knock)  
- [Digitalio Capacitiv Paperclip](https://github.com/fabiantheblind/digitalio/tree/master/capacitive_touch_paperclip)  
- [Paperclip based on this](http://www.instructables.com/id/Turn-a-pencil-drawing-into-a-capacitive-sensor-for/?ALLSTEPS)
- [CapacitiveSensor Library (ProjectPage)](https://www.pjrc.com/teensy/td_libs_CapacitiveSensor.html)
- [CapacitiveSensor Library (Github)](https://github.com/PaulStoffregen/CapacitiveSensor)
- [CapSense Library Demo Video](https://www.youtube.com/watch?v=BHQPqQ_5ulc)

####Optical (Color Tracking / Blob Detection):

- [Tangible Color Music Instrument (oF)](http://www.creativeapplications.net/sound/tangible-color-music-instrument-openframeworks-sound/)
- [Prototyp von dem vorheringen Projekt](http://www.ryanraffa.com/parsons/thesis/category/prototypes/5-tangible-player/)
- [Und die Masterarbeit](http://www.ryanraffa.com/parsons/thesis/category/papers/)

- [Scrapple by Golan Levin](http://www.flong.com/projects/scrapple/)

- [Trackmate (MIT)](http://tangible.media.mit.edu/project/trackmate/) is an inexpensive, do-it-yourself tangible tracking system that allows your computer to recognize tagged objects and their corresponding position, rotation, and color information when placed on a surface. Trackmate sends all object data viaLusidOSC (a protocol layer for unique spatial input devices), allowing any LusidOSC-based application to work with the system.

####Capacitive: 
- [DragDrop – Ein haptisch interaktives Kinderspeil](http://www.designmadeingermany.de/2013/25478/)
[Capstones, Zebrawidgets & Lumino (Hasso Plattner Institute Potsdam)](http://www.hpi.uni-potsdam.de/baudisch/projects/lumino.html)
- [CAPSTONES AND ZEBRAWIDGETS](http://stefaniemueller.org/capstones-and-zebrawidgets/)

- [TOUCHÉ (Disney Research)](http://www.disneyresearch.com/project/touche-touch-and-gesture-sensing-for-the-real-world/)
- [Capacitive Fingerprinting: User Differentiation Through Capacitive Sensing](http://chrisharrison.net/index.php/Research/CapacitiveFingerprinting)

####Augmented Multitouch – Sound

- [Augmenting Touch throught acoustic sensing](http://plopesresearch.levelup.webfactional.com/?project=rich-touch-acoustics)
- [TapSense – Chris Harrison](http://www.cmu.edu/news/stories/archives/2011/october/oct19_tapsense.html)

####Augmentation – Misc

- [Chris Harrison - The Rich-Touch Revolution is Coming (opening keynote der TEI'14)](http://www.tei-conf.org/14/program/keynote_harrison.php)
- [About Chris Harrison](http://www.chrisharrison.net/index.php/Research/Welcome)
- [WorldKit: Ad Hoc Interactive Applications on Everyday Surfaces](http://chrisharrison.net/index.php/Research/WorldKit)

####Sketch-Interaction (Augmented Drawings / Gesten)
- [SketchSynth](http://www.creativeapplications.net/openframeworks/sketchsynth-drawable-user-interface-by-billy-keyes/)
- [Drawn by Zach Liebermann](https://www.youtube.com/watch?v=xwkGC-U8cU4)
- [Scribbling - Development Prototype #1 Jordi Tost](https://vimeo.com/82286680)

####Misc
- [Jordi Tost "Augmented Multitouch" Pinboard](http://www.pinterest.com/jorditost/augmented-multitouch/)


Copyright (c)  2014 FH-Potsdam, Juri Wolf, Jordi Tost, Fabian Morón Zirfas  
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software  without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to  permit persons to whom the Software is furnished to do so, subject to the following conditions:  
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.  
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A  PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF  CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.  

see also [http://www.opensource.org/licenses/mit-license.php](http://www.opensource.org/licenses/mit-license.php)  



