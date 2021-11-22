abstract class JoyLoginStates {}

class JoyLoginInitialState extends JoyLoginStates {}

class JoyLoginLoadingState extends JoyLoginStates {}

class JoyLoginSuccessState extends JoyLoginStates {
  final String uId;

  JoyLoginSuccessState(this.uId);
}

class JoyLoginErrorState extends JoyLoginStates {
  final String error;

  JoyLoginErrorState(this.error);
}

class JoyChangePasswordVisibilityState extends JoyLoginStates {}
