


abstract class JoyRegisterStates{}

class JoyRegisterInitialState extends JoyRegisterStates{}
class JoyRegisterLoadingState extends JoyRegisterStates{}
class JoyRegisterSuccessState extends JoyRegisterStates{

}
class JoyRegisterErrorState extends JoyRegisterStates{
  final String error;
  JoyRegisterErrorState(this.error);
}



class JoyCreateUserLoadingState extends JoyRegisterStates{}
class JoyCreateUserSuccessState extends JoyRegisterStates{

}
class JoyCreateUserErrorState extends JoyRegisterStates{
  final String error;
  JoyCreateUserErrorState(this.error);
}




class JoyChangePasswordRegisterVisibilityState extends JoyRegisterStates{}