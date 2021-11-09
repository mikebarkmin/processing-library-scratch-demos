add_library('sound')
add_library('scratch')


# Setup-Funktion wird zur Initalisierung einer Processing Anwendung benötigt.
def setup():
  size(480, 360)
  # Initalisierung der Scratch-Bibliothek. Notwendig, damit die Bibliothek die Referenz zum Processing-Objekt kennt.
  # Die "this"-Referenz auf das Processing-Objekt ist nur in
  # Processing-Methoden vorhanden, daher kann die Initalisierung erst hier
  # stattfinden.
  ScratchStage.init(this)
  stage = ScratchStage.getInstance()

  # Ein PumpkinSprite-Objekt erzeugen
  pumpkin = PumpkinSprite()
  # Ein BatSprite-Objekt erzeugen
  bat = BatSprite()
  
  stage.addSprite(pumpkin)
  stage.addSprite(bat)

# Ohne draw Methode würde es nur ein Standbild geben.
def draw():
    pass

# Die beiden Klassen könnten auch in eigene Dateinen ausgelagert werden.

# Definition der Klasse PumpkinSprite in Anlehnung an das Scratch-Objekt
class PumpkinSprite(ScratchSprite):

    def __init__(self):
        # Hinzufügen des ersten Kostüms.
        self.addCostume("pumpkin01", "pumpkin01.png")
        # Hinzufügen des zweiten Kostüms.
        self.addCostume("pumpkin02", "pumpkin02.png")
        # Die initalie Position setzen.
        self.setPosition(100, 100)
        # Den Sprite verkleiner, da die Bilder zu groß sind.
        self.setSize(20)
        # Der Sprite soll an den Rändern abprallen.
        self.setOnEdgeBounce(True)

    # Methode um auf das Drücken von Tasten zu reagieren.
    def whenKeyPressed(self, keyCode):
        if (keyCode == 32):
            self.move(20)


    def run(self):
        if self.getTimer().everyMillis(600):                    
            self.nextCostume()

class BatSprite(ScratchSprite):
    def __init__(self):
        # Hinzufügen des ersten Kostüms.
        self.addCostume("bat01", "bat01.png")
        # Hinzufügen des zweiten Kostüms.
        self.addCostume("bat02", "bat02.png")
        # Die initiale Position setzen.
        self.setPosition(300, 100)
        # Den Sprite verkleiner, da die Bilder zu groß sind.
        self.setSize(20)

    # Methode um auf die Bewegung der Maus zu reagieren.
    def whenMouseMoved(self, x, y):
        self.setPosition(x, y)

    def run(self):
        # Alle 600 ms soll das Kostüm gewechselt werden.
        if self.getTimer().everyMillis(600):
            self.nextCostume()
