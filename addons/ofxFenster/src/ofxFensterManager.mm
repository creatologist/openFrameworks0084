#include "ofxFensterManager.h"
#include "ofAppRunner.h"
#include <ofGLProgrammableRenderer.h>

#ifdef TARGET_LINUX
#include "ofIcon.h"
#include "ofImage.h"
#define GLFW_EXPOSE_NATIVE_X11
#ifndef TARGET_OPENGLES
#define GLFW_EXPOSE_NATIVE_GLX
#else
#define GLFW_EXPOSE_NATIVE_EGL
#endif
#include "GLFW/glfw3native.h"
#include <X11/Xatom.h>
#include "Poco/URI.h"
#elif defined(TARGET_OSX)
#include <Cocoa/Cocoa.h>
#include <Carbon/Carbon.h>
#define GLFW_EXPOSE_NATIVE_COCOA
#define GLFW_EXPOSE_NATIVE_NSGL
#include "GLFW/glfw3native.h"
#elif defined(TARGET_WIN32)
#define GLFW_EXPOSE_NATIVE_WIN32
#define GLFW_EXPOSE_NATIVE_WGL
#include <GLFW/glfw3native.h>
#endif

#include "ofSystemUtils.cpp"

void ofGLReadyCallback();

ofxFensterManager* ofxFensterManager::instance = NULL;



void ofxFensterManager::setup(int w, int h, int screenMode)
{
    ofxFensterManager* manager = get();
    //ofSetupOpenGL(manager->getMainWindow(), w, h, OF_WINDOW);			// <-------- setup the GL context
    ofGLReadyCallback();
}

ofxFensterManager::ofxFensterManager()
{
    //mainWindow = ofxFensterPtr(new ofxFenster());
    //addWindow(mainWindow.get());
}

ofxFensterManager::~ofxFensterManager()
{
}

void ofxFensterManager::update() {

    for(vector<ofxFenster*>::iterator it = windows.begin(); it != windows.end(); it++)
    {
        //(*it)->display();
        ofNotifyEvent((*it)->onUpdate, blankArgs );
    }
}

void ofxFensterManager::draw() {
    
    int it_count = 0;
    //cout << "windows.size(): " << windows.size() << endl;
    int max = windows.size();
    for(vector<ofxFenster*>::iterator it = windows.begin(); it != windows.begin() + windows.size(); )
    {
        //if ( i != 0 ) (*it)->display();
        
        if ( it_count >= max ) {
            cout << "window (null): " << it_count << endl;
            //cout << "windows.size(): " << windows.size() << endl;
            //cout << "windows.end(): " << (int)windows.end() << endl;
            it++;
        } else {
            //cout << "window: " << it_count << endl;
            //glfwMakeContextCurrent( (*it)->windowP );
            
            if ( (*it)->getIsActive() ) {
                (*it)->display();
                if ( glfwWindowShouldClose((*it)->windowP) ) {
                    get()->closeWindow( (*it)->get() );
                    //it = windows.erase( it );
                }
                it++;
            } else if ( (*it)->shouldErase ) {
                it = windows.erase( it );
            }
        }
        
        it_count++;
        
    }
    
    
    //cout << "totalWindows: " << it_count << endl;
    it_count = 0;
    
    /*for(vector<ofxFenster*>::iterator it = windowsF.begin(); it != windowsF.end(); it++, i++)
    {
        if ( i != 0 ) (*it)->display();
        //ofEventArgs args;
        //ofNotifyEvent((*it)->onDraw, blankArgs );
        //ofNotifyEvent((*it)->onUpdate, args);
        //(&it).display();
    }*/
    
    /*typedef map<int, ofxFenster*>::iterator it_type;
    int i = 0;
    for(it_type iterator = windowsF.begin(); iterator != windowsF.end(); iterator++, i++) {
        // iterator->first = key
        // iterator->second = value
        // Repeat if you also want to iterate through the second map.
        if ( i != 0 ) iterator->second->display();
        
    }*/
}

void ofxFensterManager::runAppViaInfiniteLoop(ofBaseApp* appPtr)
{
    if ( running ) return;
    running = true;
    
    //ofNotifySetup();

    while(true)
    {
        //ofNotifyUpdate();

        /*for(vector<ofxFensterPtr>::iterator it = windows.begin(); it != windows.end(); it++)
        {
            //(*it)->display(*it == mainWindow);
            //(*it)->display();
            //ofEventArgs args;
            //ofNotifyEvent((*it)->onSetup, args);
            //(*it)->display(*it == mainWindow);
        }*/

        //glfwPollEvents();
    }
}

ofxFenster* ofxFensterManager::createWindow(int w, int h, int screenMode)
{
    
    for(vector<ofxFenster*>::iterator it = get()->windows.begin(); it < get()->windows.end(); it++)
    {
        (*it)->setIsFocused( false );
    }
    ofGetAppPtr()->setIsFocused( false );
    
    focusedWindow = createWindow(0, 0, w, h, screenMode);
    focusedWindow->setIsFocused( true );
    return focusedWindow;
}

ofxFenster* ofxFensterManager::createWindow(int x, int y, int w, int h, int screenMode)
{
    ofxFenster* fenster = new ofxFenster();
    setupWindow(fenster, x, y, w, h, screenMode);
    //return ofxFensterPtr(fenster);
    return fenster;
}

void ofxFensterManager::setupWindow(ofxFenster* window, int w, int h, int screenMode)
{
    
    setupWindow(window, 0, 0, w, h, screenMode);
}

void ofxFensterManager::closeWindow( ofxFenster* window_, bool justRestoreAppFocus_ ){
    //window_->closeWindow();
    
    if ( !justRestoreAppFocus_ ) {
        for(vector<ofxFenster*>::iterator it = get()->windows.begin(); it < get()->windows.end(); it++)
        {
            //
            if ( (*it) == window_ ) {
                (*it)->setIsFocused( false );
                (*it)->closeWindow();
            }
        }
    }
    
    
    
    ofGetAppPtr()->setIsFocused( true );
#ifdef TARGET_OSX
    //restoreAppWindowFocus();
    restoreAppWindowFocus();
#endif
    //int index = window_->getFensterManagerIndex();
    
    /*for (vector< ofxFensterPtr >::iterator it = windowsSwap.begin(); it != windowsSwap.end(); it++)
    {
        delete (*it);
    }*/
    //windowsSwap.clear();
    
    /*windowsSwap.clear();
    
    int i = 0;
    for(vector<ofxFensterPtr>::iterator it = windows.begin(); it != windows.end(); it++, i++ )
    {
        
        if ( (*it)->getIsActive() ) {
            windowsSwap.push_back( (*it) );
        }
        
    }
    windows.swap( windowsSwap );*/
    //delete windows[ windows.begin() + index ];
    //delete windows.begin() + index;
    //windows.erase( windows.begin() + index );
    //windows.clear();
    //cout << "window.size(): " << windows.size() << endl;
    //cout << "windowsSwap.size(): " << windowsSwap.size() << endl;
    //windows.erase(windows.begin()+index);
    
    //windows.shrink_to_fit();
    
};

void ofxFensterManager::closeWindow( int index_ ){
    ofGetAppPtr()->setIsFocused( true );
    
    windows.at( index_ )->closeWindow();
};

void ofxFensterManager::setupWindow(ofxFenster* window, int x, int y, int w, int h, int screenMode)
{
    for(vector<ofxFenster*>::iterator it = get()->windows.begin(); it < get()->windows.end(); it++)
    {
        (*it)->setIsFocused( false );
    }
    ofGetAppPtr()->setIsFocused( false );
    window->setIsFocused( true );
    
    window->setupOpenGL(w, h, screenMode);
    window->setWindowPosition(x, y);
    window->initializeWindow();
    window->setFensterManagerIndex( windows.size() );
    addWindow(window);
    ofNotifyEvent(window->onSetup, blankArgs);
    //window->setup();
    //runAppViaInfiniteLoop( this );
}

void ofxFensterManager::addWindow(ofxFenster* window)
{
    //cout << windowsF.size() << endl;
    //cout << "ADD WINDOW: " << windows.size() << endl;
    //windows.push_back(ofxFensterPtr(window));
    windows.push_back( window );
    //windowsF.push_back( window );
    //windowsF[ windowsF.size() ] = window;
}

ofxFenster* ofxFensterManager::getMainWindow()
{
    //if ( windows.size() < 1 ) return NULL;
    //return mainWindow;
    return NULL;
}

ofxFensterManager* ofxFensterManager::get()
{
    if(instance == NULL)
    {
        instance = new ofxFensterManager();
    }

    return instance;
}

//------------------------------------------------------------
void ofxFensterManager::mouse_cb(GLFWwindow* windowP_, int button, int state, int mods)
{
    ofLogVerbose("ofxFenster") << "mouse button: " << button;

#ifdef TARGET_OSX

    //we do this as unlike glut, glfw doesn't report right click for ctrl click or middle click for alt click
    if(ofGetKeyPressed(OF_KEY_CONTROL) && button == GLFW_MOUSE_BUTTON_LEFT)
    {
        button = GLFW_MOUSE_BUTTON_RIGHT;
    }

    if(ofGetKeyPressed(OF_KEY_ALT) && button == GLFW_MOUSE_BUTTON_LEFT)
    {
        button = GLFW_MOUSE_BUTTON_MIDDLE;
    }

#endif

    switch(button)
    {
    case GLFW_MOUSE_BUTTON_LEFT:
        button = OF_MOUSE_BUTTON_LEFT;
        break;

    case GLFW_MOUSE_BUTTON_RIGHT:
        button = OF_MOUSE_BUTTON_RIGHT;
        break;

    case GLFW_MOUSE_BUTTON_MIDDLE:
        button = OF_MOUSE_BUTTON_MIDDLE;
        break;
    }

    ofxFenster* fenster = get()->getFensterByGlfwHandle(windowP_);

    if(state == GLFW_PRESS)
    {
        if(fenster == get()->mainWindow)
        {
            ofNotifyMousePressed(ofGetMouseX(), ofGetMouseY(), button);
        }

        fenster->buttonPressed = true;

        ofMouseEventArgs args;
        args.x = fenster->curMouseX;
        args.y = fenster->curMouseY;
        args.button = button;  // button setup fix
        args.type = ofMouseEventArgs::Pressed;
        ofNotifyEvent(fenster->onMousePressed, args);
    }
    else if(state == GLFW_RELEASE)
    {
        if(fenster == get()->mainWindow)
        {
            ofNotifyMouseReleased(ofGetMouseX(), ofGetMouseY(), button);
        }

        fenster->buttonPressed = false;

        ofMouseEventArgs args;
        args.x = fenster->curMouseX;
        args.y = fenster->curMouseY;
        args.button = button; // button setup fix
        args.type = ofMouseEventArgs::Released;
        ofNotifyEvent(fenster->onMouseReleased, args);
    }

    fenster->buttonInUse = button;
}

//------------------------------------------------------------
static void rotateMouseXY(ofOrientation orientation, double &x, double &y)
{
    int savedY;

    switch(orientation)
    {
    case OF_ORIENTATION_180:
        x = ofGetWidth() - x;
        y = ofGetHeight() - y;
        break;

    case OF_ORIENTATION_90_RIGHT:
        savedY = y;
        y = x;
        x = ofGetWidth() - savedY;
        break;

    case OF_ORIENTATION_90_LEFT:
        savedY = y;
        y = ofGetHeight() - x;
        x = savedY;
        break;

    case OF_ORIENTATION_DEFAULT:
    default:
        break;
    }
}

//------------------------------------------------------------
void ofxFensterManager::motion_cb(GLFWwindow* windowP_, double x, double y)
{
    rotateMouseXY(ofGetOrientation(), x, y);

    ofxFenster* fenster = get()->getFensterByGlfwHandle(windowP_);

    fenster->curMouseX = x;
    fenster->curMouseY = y;

    if(!fenster->buttonPressed)
    {
        if(fenster == get()->mainWindow)
        {
            ofNotifyMouseMoved(x, y);
        }

        ofMouseEventArgs args;
        args.x = fenster->curMouseX;
        args.y = fenster->curMouseY;
        args.type = ofMouseEventArgs::Moved;
        ofNotifyEvent(fenster->onMouseMoved, args);
    }
    else
    {
        if(fenster == get()->mainWindow)
        {
            ofNotifyMouseDragged(x, y, fenster->buttonInUse);
        }

        ofMouseEventArgs args;
        args.x = fenster->curMouseX;
        args.y = fenster->curMouseY;
        args.type = ofMouseEventArgs::Dragged;
        ofNotifyEvent(fenster->onMouseDragged, args);
    }

}

//------------------------------------------------------------
void ofxFensterManager::scroll_cb(GLFWwindow* windowP_, double x, double y)
{
    cout << "scrolling" << endl;
    ofxFenster* fenster = get()->getFensterByGlfwHandle(windowP_);
    int button;

    if(y == 1)
    {
        button = OF_MOUSE_BUTTON_4;
    }
    else if(y == -1)
    {
        button = OF_MOUSE_BUTTON_5;
    }

    if(fenster == get()->mainWindow)
    {
        ofNotifyMousePressed(ofGetMouseX(), ofGetMouseY(), button);
    }

    fenster->buttonPressed = true;

    ofMouseEventArgs args;
    args.x = fenster->curMouseX;
    args.y = fenster->curMouseY;
    args.type = ofMouseEventArgs::Pressed;
    args.button = button;
    fenster->buttonInUse = button;
    ofNotifyEvent(fenster->onMousePressed, args);
}

//------------------------------------------------------------
void ofxFensterManager::drop_cb(GLFWwindow* windowP_, int numFiles, const char** dropString)
{
    string drop = *dropString;
    ofDragInfo drag;
    drag.position.set(ofGetMouseX(), ofGetMouseY());
    drag.files = ofSplitString(drop, "\n", true);
#ifdef TARGET_LINUX

    for(int i = 0; i < (int)drag.files.size(); i++)
    {
        drag.files[i] = Poco::URI(drag.files[i]).getPath();
    }

#endif
    ofNotifyDragEvent(drag);
}

void ofxFensterManager::focus_cb(GLFWwindow* windowP_, int focused ) {
    //cout << "FOCUS CHANGED" << endl;
    bool found = false;
    
    //ofGetAppPtr()->isFocused = true;
    ofGetAppPtr()->setIsFocused( true );
    
    if ( focused ) {
        ofGetAppPtr()->setIsFocused( false );
        for(vector<ofxFenster*>::iterator it = get()->windows.begin(); it < get()->windows.end(); it++)
        {
            if ( windowP_ == (*it)->windowP ) {
                (*it)->setIsFocused( true );
                found = true;
            } else {
                (*it)->setIsFocused( false );
            }
        }
    } else {
        
        
        for(vector<ofxFenster*>::iterator it = get()->windows.begin(); it < get()->windows.end(); it++)
        {
            if ( windowP_ == (*it)->windowP ) {
                (*it)->setIsFocused( false );
                found = true;
            }
        }
        
        
    }
    
    
    //cout << found << endl;
    
    
    
    
    if ( focused == GL_TRUE ) {
        //cout << "FOCUS" << endl;
    } else {
        //cout << "UNFOCUS" << endl;
    }
};

//------------------------------------------------------------
void ofxFensterManager::keyboard_cb(GLFWwindow* windowP_, int key, int scancode, unsigned int codepoint, int action, int mods)
{

    ofLogVerbose("ofxFenster") << "key: " << key << " state: " << action;

    switch(key)
    {
    case GLFW_KEY_ESCAPE:
        key = OF_KEY_ESC;
        break;

    case GLFW_KEY_F1:
        key = OF_KEY_F1;
        break;

    case GLFW_KEY_F2:
        key = OF_KEY_F2;
        break;

    case GLFW_KEY_F3:
        key = OF_KEY_F3;
        break;

    case GLFW_KEY_F4:
        key = OF_KEY_F4;
        break;

    case GLFW_KEY_F5:
        key = OF_KEY_F5;
        break;

    case GLFW_KEY_F6:
        key = OF_KEY_F6;
        break;

    case GLFW_KEY_F7:
        key = OF_KEY_F7;
        break;

    case GLFW_KEY_F8:
        key = OF_KEY_F8;
        break;

    case GLFW_KEY_F9:
        key = OF_KEY_F9;
        break;

    case GLFW_KEY_F10:
        key = OF_KEY_F10;
        break;

    case GLFW_KEY_F11:
        key = OF_KEY_F11;
        break;

    case GLFW_KEY_F12:
        key = OF_KEY_F12;
        break;

    case GLFW_KEY_LEFT:
        key = OF_KEY_LEFT;
        break;

    case GLFW_KEY_RIGHT:
        key = OF_KEY_RIGHT;
        break;

    case GLFW_KEY_UP:
        key = OF_KEY_UP;
        break;

    case GLFW_KEY_DOWN:
        key = OF_KEY_DOWN;
        break;

    case GLFW_KEY_PAGE_UP:
        key = OF_KEY_PAGE_UP;
        break;

    case GLFW_KEY_PAGE_DOWN:
        key = OF_KEY_PAGE_DOWN;
        break;

    case GLFW_KEY_HOME:
        key = OF_KEY_HOME;
        break;

    case GLFW_KEY_END:
        key = OF_KEY_END;
        break;

    case GLFW_KEY_INSERT:
        key = OF_KEY_INSERT;
        break;

    case GLFW_KEY_LEFT_SHIFT:
        key = OF_KEY_LEFT_SHIFT;
        break;

    case GLFW_KEY_LEFT_CONTROL:
        key = OF_KEY_LEFT_CONTROL;
        break;

    case GLFW_KEY_LEFT_ALT:
        key = OF_KEY_LEFT_ALT;
        break;

    case GLFW_KEY_LEFT_SUPER:
        key = OF_KEY_LEFT_SUPER;
        break;

    case GLFW_KEY_RIGHT_SHIFT:
        key = OF_KEY_RIGHT_SHIFT;
        break;

    case GLFW_KEY_RIGHT_CONTROL:
        key = OF_KEY_RIGHT_CONTROL;
        break;

    case GLFW_KEY_RIGHT_ALT:
        key = OF_KEY_RIGHT_ALT;
        break;

    case GLFW_KEY_RIGHT_SUPER:
        key = OF_KEY_RIGHT_SUPER;
        break;

    case GLFW_KEY_BACKSPACE:
        key = OF_KEY_BACKSPACE;
        break;

    case GLFW_KEY_DELETE:
        key = OF_KEY_DEL;
        break;

    case GLFW_KEY_ENTER:
        key = OF_KEY_RETURN;
        break;

    case GLFW_KEY_KP_ENTER:
        key = OF_KEY_RETURN;
        break;

    case GLFW_KEY_TAB:
        key = OF_KEY_TAB;
        break;

    default:
        break;
    }

    //GLFW defaults to uppercase - OF users are used to lowercase
    //we look and see if shift is being held to toggle upper/lowecase
    if(key >= 65 && key <= 90 && !ofGetKeyPressed(OF_KEY_SHIFT))
    {
        key += 32;
    }

    ofxFenster* fenster = get()->getFensterByGlfwHandle(windowP_);

    if(action == GLFW_PRESS || action == GLFW_REPEAT)
    {
        if(fenster == get()->mainWindow)
        {
            ofNotifyKeyPressed(key);
        }

        ofKeyEventArgs args;
        args.key = key;
        args.type = ofKeyEventArgs::Pressed;
        ofNotifyEvent(fenster->onKeyPressed, args);

        if(key == OF_KEY_ESC)  				// "escape"
        {
           if ( get()->escapeQuitsApp ) ofExit();
        }
    }
    else if(action == GLFW_RELEASE)
    {
        if(fenster == get()->mainWindow)
        {
            ofNotifyKeyReleased(key);
        }

        ofKeyEventArgs args;
        args.key = key;
        args.type = ofKeyEventArgs::Pressed;
        ofNotifyEvent(fenster->onKeyReleased, args);
    }
}

//------------------------------------------------------------
void ofxFensterManager::resize_cb(GLFWwindow* windowP_, int w, int h)
{
    //if ( windows.size() < 1 ) return;
    ofxFenster* fenster = get()->getFensterByGlfwHandle(windowP_);
    fenster->windowW = w;
    fenster->windowH = h;
    //cout << h << endl;

    if(fenster == get()->mainWindow)
    {
        ofNotifyWindowResized(w, h);
    }

    fenster->nFramesSinceWindowResized = 0;

    ofResizeEventArgs args;
    args.width = w;
    args.height = h;
    ofNotifyEvent(fenster->onWindowResize, args);
}

void ofxFensterManager::exit() {
    
    for(vector<ofxFenster*>::iterator it = windows.begin(); it != windows.begin() + windows.size(); it++ )
    {
        
        get()->closeWindow( (*it) );
        (*it)->exit();

    }
    
    glfwTerminate();
};

void ofxFensterManager::exit_cb(GLFWwindow* windowP_)
{
    cout << "exit_cb" << endl;
    //ofxFensterPtr fenster = get()->getFensterByGlfwHandle(windowP_);
    //ofLogWarning("ofxFenster", "WINDOW CLOSING NOT YET HANDLED PROPERY");
    ofxFenster* fenster = get()->getFensterByGlfwHandle(windowP_);
    //ofEventArgs args;
    //ofNotifyEvent(fenster->onClose, args);
    //fenster->close();
    fenster->exit();
}

ofxFenster* ofxFensterManager::getFensterByGlfwHandle(GLFWwindow* windowP)
{
    if ( windows.size() < 1 ) return NULL;
    for(vector<ofxFenster*>::iterator it = windows.begin(); it < windows.end(); it++)
    {
        if((*it)->getGlfwPtr() == windowP)
        {
            return *it;
        }
    }

    //return mainWindow;
    return NULL;
}
