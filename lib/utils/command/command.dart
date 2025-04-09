class CommandState {
  CommandState({
    this.isIdle = false,
    this.isRunning = false,
    this.isComplete = false,
    this.isError = false,
  });

  bool isIdle;
  bool isRunning;
  bool isComplete;
  bool isError;
}
