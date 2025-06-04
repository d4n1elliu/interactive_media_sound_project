import ddf.minim.*;
import ddf.minim.analysis.*;
import processing.core.PApplet;
import ddf.minim.effects.*;

Minim minim;
AudioPlayer jPop; //Song
PImage backgroundImage;
boolean songPlaying = false;
float frequencyScale = 0.1;
float volume = 1.0; // Initial volume
FFT fft;

void setup(){
  size(1600, 900);
  backgroundImage = loadImage("jujutsu kaisen.jpg");
  noSmooth();
  minim = new Minim(this);
  
  //Load up audio file
  jPop = minim.loadFile("Where_Our_Blue_Is-[HiyoriOST].mp3");
  
   // Initialize FFT for frequency analysis
  fft = new FFT(jPop.bufferSize(), jPop.sampleRate());
  fft.linAverages(255); // Adjust the number of frequency bands as needed

}

void draw(){
  
  //Setting background image
  background(backgroundImage);
  
  //Showing frequency on screen
  displayFrequency();
  
  //Drawing the buttons
  drawButtons();
  
  //Calling the mouse hoving function
  mouseHover();
  
  //Adjusting volume
  volumeAdjust();
}

void volumeAdjust(){
  float adjustedVolume = map(mouseX, 0, width, 0.0, 100.0);
  jPop.setVolume(adjustedVolume);
  fill(255);
  text("Volume: " + adjustedVolume, 20, 40);
}

void displayFrequency(){
  
  // Analyze the audio to get frequency data
   fft.forward(jPop.mix);
  // Draw frequency waves in the background
  stroke(238, 8, 138);
  for (int i = 0; i < fft.avgSize(); i++) {
    float x = map(i, 0, fft.avgSize(), 0, width);
    float h = map(fft.getAvg(i), 0, 1, 0, height) * frequencyScale;
    line(x, height, x, height - h);
  }
}

void drawButtons(){
  
  // Check if the mouse is over the start button
  boolean startButton = mouseX > 50 && mouseX < 100 && mouseY > 90 && mouseY < 130;
  // Check if the mouse is over the pause button
  boolean pauseButton = mouseX > 50 && mouseX < 100 && mouseY > 140 && mouseY < 180;
  // Check if the mouse is over the Replay button
  boolean replayButton = mouseX > 50 && mouseX < 100 && mouseY > 190 && mouseY < 230;

  //Draw the start button
  fill(startButton ? color(0, 255, 0) : color(100));
  rect(50, 100, 100, 30);
  fill(255, 0, 0);
  text("Start", 90, 120);
  
  // Draw the pause button
  fill(pauseButton ? color(255, 0, 0) : color(100));
  rect(50, 150, 100, 30);
  fill(0, 255, 0);
  text("Pause", 90, 170);
  
  //Drawing the Replay button
  fill(replayButton ? color(128, 0, 128) : color(100));
  rect(50, 200, 100, 30);
  fill(218, 165, 32);
  text("Replay", 90, 220);
}
void mouseHover() {
  // Check if the mouse is over the start button
  boolean startButton = mouseX > 50 && mouseX < 120 && mouseY > 90 && mouseY < 130;
  // Check if the mouse is over the pause button
  boolean pauseButton = mouseX > 50 && mouseX < 140 && mouseY > 140 && mouseY < 180;
  // Check if the mouse is over the replay button
  boolean replayButton = mouseX > 50 && mouseX < 100 && mouseY > 190 && mouseY < 230;
  
  // Handle button clicks
  if (startButton) {
    if (!songPlaying) {
      jPop.play();
    }
    songPlaying = true;
  }
  else if (pauseButton) {
    if (songPlaying) {
      jPop.pause();
    } 
    songPlaying = false;
  }
  else if (replayButton) { 
    if (!songPlaying) {
      {
        jPop.rewind(); // Restart the song from the beginning
        jPop.play(); // Start playing the song
      } 
      songPlaying = true;
    } 
  }
  // Handle button clicks
  if (startButton) {
    if (!songPlaying) {
      jPop.play();
    }
    songPlaying = true;
  }
  else if (pauseButton) {
    if (songPlaying) {
      jPop.pause();
    } 
    songPlaying = false;
  }
  else if (replayButton) { 
    if (!songPlaying) {
      jPop.rewind();
      jPop.play();
    } 
    songPlaying = true;
  }
}

void stop() {
  jPop.close();
  minim.stop();
  super.stop();
}
