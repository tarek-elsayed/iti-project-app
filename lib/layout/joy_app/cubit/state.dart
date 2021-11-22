
import 'package:jooy/models/Restaurant_model.dart';
import 'package:jooy/models/hotel_model.dart';
import 'package:jooy/models/places_model.dart';
import 'package:jooy/models/rent_model.dart';
import 'package:jooy/models/user_model.dart';

abstract class JoyStates{}


class JoyInitialStates extends JoyStates{}

class JoyGetUserSuccessStates extends JoyStates{
  final UserModel userModel;

  JoyGetUserSuccessStates(this.userModel);
}

class JoyGetUserLoadingStates extends JoyStates{}

class JoyGetUserErrorStates extends JoyStates{
  final String error;

  JoyGetUserErrorStates(this.error);
}

class HomeInitialState extends JoyStates{}

class HomeChangeBottomNavState extends JoyStates{}

class JoyLoadingHomeDataState extends JoyStates {}
class JoySuccessHomeDataState extends JoyStates {}
class JoyErrorHomeDataState extends JoyStates {}

// class JoySuccessFavouritesState extends JoyStates {}
//
// class JoySuccessChangeFavouritesState extends JoyStates {
//   // final ChangeFavouritesModel model;
//
//   // JoySuccessChangeFavouritesState(this.model);
// }
//
// class JoyErrorFavouritesState extends JoyStates {}
//
// class JoySuccessGetFavouritesState extends JoyStates {}
//
// class JoyLoadingGetFavouritesState extends JoyStates {}
//
// class JoyErrorGetFavouritesState extends JoyStates {}


class JoySetRestaurantFavouritesState extends JoyStates{}
class JoySetHotelFavouritesState extends JoyStates{}

class JoySetHotelFavouritesSuccessState extends JoyStates{}
class JoySetRestaurantFavouritesSuccessState extends JoyStates{}

class JoySuccessGetAllHotelsState extends JoyStates {}

class JoyLoadingGetAllHotelsState extends JoyStates {}

class JoyErrorGetAllHotelsState extends JoyStates {

  final String error;
  JoyErrorGetAllHotelsState(this.error);
}


class JoySuccessGetAllRestaurantState extends JoyStates {

}

class JoyLoadingGetAllRestaurantState extends JoyStates {}

class JoyErrorGetAllRestaurantState extends JoyStates {

  final String error;
  JoyErrorGetAllRestaurantState(this.error);
}


class JoySuccessGetHotelsState extends JoyStates {
  final HotelModel model;
  JoySuccessGetHotelsState(this.model);
}

class JoyLoadingGetHotelsState extends JoyStates {}

class JoyErrorGetHotelsState extends JoyStates {

  final String error;
  JoyErrorGetHotelsState(this.error);
}


class JoySuccessGetPlacesState extends JoyStates {
  final PlacesModel model;
  JoySuccessGetPlacesState(this.model);
}

class JoyLoadingGetPlacesState extends JoyStates {}

class JoyErrorGetPlacesState extends JoyStates {

  final String error;
  JoyErrorGetPlacesState(this.error);
}



class JoySuccessGetRestaurantState extends JoyStates {
final RestaurantModel model;
JoySuccessGetRestaurantState(this.model);
}

class JoyLoadingGetRestaurantState extends JoyStates {}

class JoyErrorGetRestaurantState extends JoyStates {

  final String error;
  JoyErrorGetRestaurantState(this.error);
}


class JoySuccessProfileImageState extends JoyStates {}

class JoyErrorProfileImageState extends JoyStates {}

class JoySuccessUplodeProfileImageState extends JoyStates {}

class JoyErrorUplodeProfileImageState extends JoyStates {}

class JoyErrorUpdateUserImageState extends JoyStates {}






class JoySuccessGetAllPlacesState extends JoyStates {}

class JoyLoadingGetAllPlacesState extends JoyStates {}

class JoyErrorGetAllPlacesState extends JoyStates {

  final String error;
  JoyErrorGetAllPlacesState(this.error);
}


class JoySuccessGetAllRentState extends JoyStates {
  // final RestaurantModel model;
  // JoySuccessGetAllRestaurantState(this.model);
}

class JoyLoadingGetAllRentState extends JoyStates {}

class JoyErrorGetAllRentState extends JoyStates {

  final String error;
  JoyErrorGetAllRentState(this.error);
}


class JoySuccessGetRentState extends JoyStates {
  final RentModel model;
  JoySuccessGetRentState(this.model);
}

class JoyLoadingGetRentState extends JoyStates {}

class JoyErrorGetRentState extends JoyStates {

  final String error;
  JoyErrorGetRentState(this.error);
}
