import 'package:flutter/material.dart';
import 'package:the_vet_app/src/pages/add_animal.dart';
import 'package:the_vet_app/src/pages/home_screen.dart';
import 'package:the_vet_app/src/pages/user_profile.dart';

class Routes {
  /// Route names
  static const String home = '/';
  static const String userProfile = '/user-profile';
  static const String addPet = '/add-pet';
  static const String editPet = '/edit-pet';

  /// Route generator
  static Route routes(RouteSettings settings) {
    MaterialPageRoute buildRoute(Widget widget) {
      return MaterialPageRoute(builder: (_) => widget, settings: settings);
    }

    switch (settings.name) {
      case home:
        return buildRoute(const HomeScreen());
      case userProfile:
        return buildRoute(const UserProfileScreen());
      case addPet:
        return buildRoute(const AddPetScreen());
      case editPet:
        final Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
        return buildRoute(AddPetScreen(
          name: args['name'],
          age: args['age'],
          weight: args['weight'],
          id: args['id'],
        ));
      default:
        throw Exception('La ruta: ${settings.name} no existe');
    }
  }
}
