Einfache Toucherkennung mit Webcam und Pappkarton
======================================

## Beschreibung

Beim ausführen des Scriptes können mit dem Finger auf einem Papier-Touchpad Partiekl gezeichnet werden.

## Funktion
Das Script liest die Webcam aus und wendet auf das Bild Threshold und Blur Filter an. Das Ergebnis ist ein Schwarz/Weiß-Bild, welches dort Weiß ist, wo der Finger das Papier berührt.
Anschließend wird das Bild in einem 10x10 Pixel Raster abgetastet. Dort wo das Bild in diesem Raster weiß ist werden Partikel erzeugt.




