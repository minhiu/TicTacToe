import controlP5.*;

ControlP5 cp5;

int myColorBackground = color(0,0,0);
int myColor = color(0,0,0);
int knobValue = 100;
int sliderValue = 100;

Knob myKnobA;
Slider abc;


void setup() {
  size(1400,200);
  smooth();
  noStroke();
  
  cp5 = new ControlP5(this);
  
  myKnobA = cp5.addKnob("knob")
               .setRange(0,255)
               .setValue(50)
               .setPosition(100,120)
               .setRadius(20)
               .setDragDirection(Knob.VERTICAL)
               ;
               
     cp5.addSlider("sliderValue")
     .setPosition(100,50)
     .setRange(0,255)
     ;
}

void draw() {
  background(myColorBackground);
  fill(knobValue);
  rect(0,0,width,height/2);
  
  fill(sliderValue);
  rect(0,0,width,100);
  
  fill(myColor);
  rect(0,280,width,70);
}


void knob(int theValue) {
  myColorBackground = color(theValue);
  println("a knob event. setting background to "+theValue);
}


void slider(float theColor) {
  myColor = color(theColor);
  println("a slider event. setting background to "+theColor);
}



void keyPressed() {
  switch(key) {
    case('1'):myKnobA.setValue(180);break;
    case('2'):myKnobA.shuffle();;break;
  }
  
}
