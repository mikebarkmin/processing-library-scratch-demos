class RestartButton extends Button {
  RestartButton() {
    super("assets/buttons/restart/");
  }

  void onDown() {
    startGame();
  }
}
