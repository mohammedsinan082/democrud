
import 'package:democrud/features/auth/controller/repository/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authControllerProvider=Provider(
        (ref)=> AuthController(authRepository: ref.read(authRepositoryProvider))
);

class AuthController{
  final AuthRepository _authRepository;
  AuthController({
    required AuthRepository authRepository
  }) : _authRepository =authRepository;

  void signInWithGoogle(BuildContext context){
    _authRepository.signInWithGoogle(context);
  }

}