abstract class LoginStates{}
class LoginInitialState extends LoginStates{}
class LoginLoadingState extends LoginStates{}
class LoginSuccessfulState extends LoginStates{}
class LoginErrorState extends LoginStates{}
class LoginErrorDataInputState extends LoginStates{}
class LoginNumberNotExistDataInputState extends LoginStates{}
class TimeCompleted extends LoginStates{}

class CodeNotSentState extends LoginStates{}
