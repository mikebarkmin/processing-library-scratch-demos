class PlayButton extends Button {
  PlayButton() {
    super("assets/buttons/play/");
  }
  
  void onDown() {
    startGame();
  }
}
