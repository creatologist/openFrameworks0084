#pragma once

#include "ofAppRunner.h"
#include "ofPoint.h"
#include "ofEvents.h"
#include "ofBaseTypes.h"


#define GLFW_INCLUDE_NONE

#if (_MSC_VER)
#include <GLFW/glfw3.h>
#else
#include "GLFW/glfw3.h"
#endif

#include "ofAppGLFWWindow.h"

class ofBaseApp : public ofBaseSoundInput, public ofBaseSoundOutput {
    
	public:
        ofBaseApp() {
            mouseX = mouseY = 0;
        }
    virtual ~ofBaseApp(){
    }
    
    bool isCustom() {
        return false;
    }
    
    ofBaseApp* getBaseApp() {
        return this;
    }
    
    bool _isFocused = false;
    virtual bool getIsFocused() {
        return _isFocused;
        /*if ( isFocused ) return true;
        else return false;*/
    }
    void setIsFocused( bool b_ ) {
        _isFocused = b_;
    };
    
		

		virtual void setup(){}
		virtual void update(){}
		virtual void draw(){}
		virtual void exit(){}

		virtual void windowResized(int w, int h){}

		virtual void keyPressed( int key ){}
		virtual void keyReleased( int key ){}
    
        ofEvent<ofVec2f> onScroll;
    
    static void scroll_cb(GLFWwindow* windowP_, double x, double y){
        //cout << x << "," << y << endl;
        if ( y < 0 ) ofNotifyScrollDown(x, -y);
        else if ( y > 0 ) ofNotifyScrollUp(x, -y);
    };

    
    void scrolling( double x, double y ) {
        //cout << x << ", " << y << endl;
    }

		virtual void mouseMoved( int x, int y ){}
		virtual void mouseDragged( int x, int y, int button ){}
		virtual void mousePressed( int x, int y, int button ){}
		virtual void mouseReleased(int x, int y, int button ){}
    
		
		virtual void dragEvent(ofDragInfo dragInfo) { }
		virtual void gotMessage(ofMessage msg){ }
	
		virtual void windowEntry ( int state ) { }
		
		int mouseX, mouseY;			// for processing heads

		virtual void setup(ofEventArgs & args){
			setup();
		}
		virtual void update(ofEventArgs & args){
			update();
		}
		virtual void draw(ofEventArgs & args){
			draw();
		}
		virtual void exit(ofEventArgs & args){
			exit();
		}

		virtual void windowResized(ofResizeEventArgs & resize){
			windowResized(resize.width,resize.height);
		}

		virtual void keyPressed( ofKeyEventArgs & key ){
			keyPressed(key.key);
		}
		virtual void keyReleased( ofKeyEventArgs & key ){
			keyReleased(key.key);
		}
    
        virtual void scrolling( ofScrollEventArgs & scroll ){
            scrolling( scroll.x, scroll.y );
        }

		virtual void mouseMoved( ofMouseEventArgs & mouse ){
			mouseX=mouse.x;
			mouseY=mouse.y;
			mouseMoved(mouse.x,mouse.y);
		}
		virtual void mouseDragged( ofMouseEventArgs & mouse ){
			mouseX=mouse.x;
			mouseY=mouse.y;
			mouseDragged(mouse.x,mouse.y,mouse.button);
		}
		virtual void mousePressed( ofMouseEventArgs & mouse ){
			mouseX=mouse.x;
			mouseY=mouse.y;
			mousePressed(mouse.x,mouse.y,mouse.button);
		}
		virtual void mouseReleased(ofMouseEventArgs & mouse){
			mouseX=mouse.x;
			mouseY=mouse.y;
			mouseReleased(mouse.x,mouse.y,mouse.button);
		}
		virtual void windowEntry(ofEntryEventArgs & entry){
			windowEntry(entry.state);
		}
		virtual void dragged(ofDragInfo & drag){
			dragEvent(drag);
		}
		virtual void messageReceived(ofMessage & message){
			gotMessage(message);
		}
private:
    bool _initScrolling;
    bool _scrollingActive;
};



