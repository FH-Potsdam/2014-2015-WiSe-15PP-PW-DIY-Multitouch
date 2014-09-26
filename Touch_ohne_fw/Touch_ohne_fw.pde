import processing.video.*; // Lybrary für Kamera
Capture cam; // Variable für Kamera
ArrayList <Particle> agents; // Arrai für Partikel

void setup() {
  size(640, 480); // Dokumentgröße
  String[] cameras = Capture.list(); // An den PC Angeschloßene Kameras
  agents = new ArrayList<Particle>(); // Array für Partikel
  
  if (cameras.length == 0) { // Wenn keine Kameras angeschloßen sind...
    println("There are no cameras available for capture."); // Fehler ausgeben
    exit(); // Script beenden
  } else { // Wenn Kameras angeschloßen sind
    println("Available cameras:"); // Zeile ausgeben
    for (int i = 0; i < cameras.length; i++) { // Kameras durchlaufen
      println(cameras[i]); // Namen der Kameras ausgeben
    }
    
    cam = new Capture(this, cameras[1]); // cameras[x] enthält die nummer der gewünschten Kamera
    cam.start();  // Kamera einschalten
  }      
}

void draw() { 
  if (cam.available() == true) { // Prüfen ob Kamera verfügbar ist
    cam.read(); // Bild der Kamera einlesen
  } 
  cam.filter(THRESHOLD, 0.3); // Einen Threshold von 0,3 auf das Kamerabild anwenden...
  cam.filter(BLUR, 4); // ... weichzeichnen...
  cam.filter(THRESHOLD, 0.2); // ...und erneut einen Threshold anwenden...
  cam.filter(INVERT); // Und das Bild invertieren.
  //cam.scale(1, -1); // Bild spiegeln, funktioniert offensichtlich nicht.
  
  image(cam, 0, 0); // Bearbeitetes Kamerabild ausgeben
   
  for (int px_x = 0; px_x < 640; px_x+=10){ // Jedes zehnte vertikale Pixel durchlaufen
    for (int px_y = 0; px_y < 480; px_y+=10){ // Und jedes zehnte horizontale Pixel
        if(get(px_x,px_y) >= -10){ // wenn der ausgelesene Pixel weiß ist...
          //stroke(204, 102, 0); // farbe für Kontur setzen
          //point(px_x,px_y); // Pixel farbig markieren
          agents.add(new Particle(px_x,px_y)); // Partikel hinzufügen
          } // Ende if Pixel weiß
        } // Ende for px_y
      } // Ende for px_x
      
  for (int k = 0; k < agents.size();k++) { // Array der Partikel durchlaufen
    agents.get(k).run(); // Jeden Partikel bewegen
  } // Ende Partikel Array
  
} // Ende Draw


class Particle { // Partikel Klasse

  float x = 0;
  float y = 0;

  Particle(float _x, float _y) {
    x = _x;
    y = _y;
  } // Constructor

  void display() {
    stroke(random(255)); // Heligkeit der Kontur
    pushMatrix();
    translate(x, y);
    ellipse(0, 0, 2, 2); // 2x2px Elipse zeichnen
    popMatrix();
  } // display

  void move() {
    x += random(-10, 10); // Bewegung links/rechts
    y += random(-50, 0); // Bewegung hoch/runter

    x = constrain(x, 0, width); // Bewegungsspielraum x
    y = constrain(y, 0, height); // Bewegungsspielraum y
  } // move

  void run() {
    display(); // Partikel anzeigen
    move(); // Partikel weiter bewegen
  } // run
} // Ende Partikel Klasse

