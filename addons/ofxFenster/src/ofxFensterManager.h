#ifndef OFXFENSTERMANAGER_H
#define OFXFENSTERMANAGER_H

#include "ofMain.h"
#include "ofTypes.h"
#include "ofxFenster.h"
#include "ofBaseApp.h"

typedef ofPtr<ofxFenster> ofxFensterPtr;

class ofxFensterManager: public ofAppGLFWWindow
{
public:
    ofxFenster* createWindow(int x, int y, int w, int h, int screenMode = OF_WINDOW);
    ofxFenster* createWindow(int w = 1280, int h = 720, int screenMode = OF_WINDOW);
    void setupWindow(ofxFenster* window, int x, int y, int w, int h, int screenMode = OF_WINDOW);
    void setupWindow(ofxFenster* window, int w = 1280, int h = 720, int screenMode = OF_WINDOW);
    void closeWindow( ofxFenster* window_ );
    void closeWindow( int index_ );
    
    ofxFenster* getMainWindow();
    void runAppViaInfiniteLoop(ofBaseApp * appPtr);
    
    void update();
    void draw();
    void exit();
    ofEventArgs blankArgs;

    static ofxFensterManager* get();
    static void setup(int w = 1280, int h = 720, int screenMode = OF_WINDOW);

private:
    ofxFenster* getFensterByGlfwHandle(GLFWwindow* windowP);
    void addWindow(ofxFenster* window);
    
    bool running = false;

    static void mouse_cb(GLFWwindow* windowP_, int button, int state, int mods);
    static void motion_cb(GLFWwindow* windowP_, double x, double y);
    static void keyboard_cb(GLFWwindow* windowP_, int key, int scancode, unsigned int codepoint, int action, int mods);
    static void resize_cb(GLFWwindow* windowP_, int w, int h);
    static void exit_cb(GLFWwindow* windowP_);
    static void scroll_cb(GLFWwindow* windowP_, double x, double y);
    static void drop_cb(GLFWwindow* windowP_, int numFiles, const char** dropString);

    ofxFensterManager();
    ~ofxFensterManager();

    static ofxFensterManager* instance;

    //std::vector<ofxFensterPtr> windows;
    vector<ofxFenster*> windows;
    //std::vector<ofxFensterPtr> windowsSwap;

    //std::vector<ofxFenster*> windowsF;
    //map< int, ofxFenster* > windowsF;
    //map< int, ofxFenster* > windows;
    
    //ofxFensterPtr mainWindow;
    ofxFenster* mainWindow;

    friend class ofxFenster;
};

#endif // OFXFENSTERMANAGER_H
