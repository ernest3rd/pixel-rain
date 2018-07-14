import processing.core.*;

Ground ground;
Rain rain;

boolean toggle = true;
boolean mouseDown = false;
boolean[] keydown = new boolean[255];

void setup(){
  size(640,480);
  frameRate(60);
  
  ground = new Ground(0, 0, width, height);
  rain = new Rain(10);
  rain.addCollider(ground);

  background(230,245,255);
  loadPixels();
}

void draw(){
  background(230,245,255);
  loadPixels();
  
  if(mouseDown){
    if(keydown[17]){
      mouseDown = false;
      rain.circle(mouseX, mouseY, 50, rain.odd);
    }
    else if(keydown[16]){
      mouseDown = false;
      rain.circle(mouseX, mouseY, 1, rain.odd);
    }
    else{
      ground.circle(mouseX, mouseY, 20, 0);
    }
  }
  
  rain.update();
  
  ground.draw(pixels);
  rain.draw(pixels);
    
  updatePixels();
  
  //println(frameRate);
}

void mousePressed(){
  mouseDown = true;
}

void mouseReleased(){
  mouseDown = false;
}

void keyPressed(){
  keydown[keyCode] = true;
  if(keyCode == 32){
    toggle = !toggle;
    if(toggle){
      frameRate(60);
    }
    else {
      frameRate(10);
    }
  }
}

void keyReleased(){
  println(keyCode);
  keydown[keyCode] = false;
}
