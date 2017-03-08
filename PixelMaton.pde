/**
 * PixelMaton
 */
 
import processing.video.*;
import java.util.Date;
import java.io.InputStreamReader;

int cellSize = 8;

int cols, rows;

Capture video;

float brght=0;

int effect=1;

int bcol=0;

int s1=51;
int s2=71;
int s3=88;
int s4=120;
int s5=140;
int s6=180;
int s7=220;
int s8=255;

boolean captureScreen=false;


void setup() {
  size(640, 480);

  cols = width / cellSize;
  rows = height / cellSize;
  colorMode(RGB, 255, 255, 255, 100);
  rectMode(CENTER);

  String[] cameras = Capture.list();
  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      print(i);
      print(" ");
      println(cameras[i]);
    }
  }

  video = new Capture(this, width, height,cameras[80]);
  video.start();  
  background(0);
}


void draw() { 
  if (video.available()) {
    
    video.read();
    video.loadPixels();
    
    background(255, 255, 255);

    for (int i = 0; i < cols;i++) {
      for (int j = 0; j < rows;j++) {


        int x = i * cellSize;
        int y = j * cellSize;
        int loc = (video.width - x - 1) + y*video.width;

        color c = video.pixels[loc];
        brght=brightness(c);

        if (brght<s1)
          bcol=0;
        else if (brght<s2)
          bcol=50;
        else if (brght<s3)
          bcol=60;
        else if (brght<s4)
          bcol=80;
        else if (brght<s5)
          fill(90);
        else if (brght<s6)
          bcol=130;          
        else if (brght<s7)
          bcol=180;
        else if (brght<=s8)
          bcol=255;

        fill(bcol);
        
        float sz = (bcol / 255.0) * cellSize;

        
        if (effect==1) 
        {
          noStroke();
          rect(x, y, cellSize, cellSize);
        }
        else if (effect==2)
        {
          noStroke();
          ellipse(x, y, cellSize, cellSize);
        }
        else if (effect==3)
        {
          stroke(0);
          rect(x, y, cellSize, cellSize); 
        }
        else if (effect==4)
        {
          stroke(0);
          ellipse(x, y, cellSize, cellSize);
        }
        else if (effect==5)
        {
          //TODO
        }
        else if (effect==6)
        {
          //TODO
        }        
      }
    }
  }
  

    

    
    if (captureScreen) {
      set(0, height - video.height, video);
    }
}


void keyPressed() {
  switch (key) {
    case 'w': saveFrame(); break;
    case 'c': captureScreen = !captureScreen; break;
    
    case 'a': effect=1; break;
    case 'z': effect=2; break;
    case 'e': effect=3; break;
    case 'r': effect=4; break;    
    case 't': effect=5; break;
    case 'y': effect=6; break;      
    
    case ' ':
  {
    //on save et on imprime
        String fileName = new Date().getTime() +".png";
    saveFrame("c:\\BMP\\"+fileName);
    saveFrame("c:\\BMP\\img.png");
    try {
      String[] command = new String[1];
      command[0]="c:\\print.bat";
    Process p = exec(command); 
    BufferedReader in = new BufferedReader(new InputStreamReader(p.getInputStream()));
    String line = null;
    while ((line = in.readLine()) != null) {
      System.out.println(line);
    }//fin while
  } // fin try
  catch (IOException e) { // gestion exception
    e.printStackTrace();
  } // fin catch
  break;
  }

  }
}