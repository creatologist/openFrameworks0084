#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
    ofSetLogLevel(OF_LOG_VERBOSE);
    
    camWidth = 640;
    camHeight = 480;
    vidGrabber.listVideoDevices();
    vidGrabber.initGrabber(camWidth, camHeight);
    //serial.listDevices();
    //return;
    //vidGrabber.initGrabber(camWidth, camHeight);
    //vidGrabber.initGrabberWithoutPreview();
    
    int deviceId = 0;
    vector<string> availableCams = vidGrabber.listVideoDevices();
    cout << availableCams.size() << endl;
    
    for(int i = 0; i < availableCams.size(); i++){
        /*if(availableCams.at(i) == cameraName){
            deviceId = i;
        }*/
        cout << i << endl;
        
    }
    deviceId = 1;
    
    vidGrabber.setDeviceID(deviceId);
}

//--------------------------------------------------------------
void ofApp::update(){
    vidGrabber.update();
    if(vidGrabber.isFrameNew())
    {
        tex.loadData(vidGrabber.getPixelsRef());
    }
}

//--------------------------------------------------------------
void ofApp::draw(){
    tex.draw(0,0, camWidth, camHeight);
}

//--------------------------------------------------------------
void ofApp::keyPressed(int key){

}

//--------------------------------------------------------------
void ofApp::keyReleased(int key){

}

//--------------------------------------------------------------
void ofApp::mouseMoved(int x, int y ){

}

//--------------------------------------------------------------
void ofApp::mouseDragged(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mouseReleased(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::windowResized(int w, int h){

}

//--------------------------------------------------------------
void ofApp::gotMessage(ofMessage msg){

}

//--------------------------------------------------------------
void ofApp::dragEvent(ofDragInfo dragInfo){ 

}

//--------------------------------------------------------------
void ofApp::exit(){
    cout << "exit" << endl;
    vidGrabber.close();
}
