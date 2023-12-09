
import 'package:democrud/features/auth/controller/repository/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/riverpod_auth_repository.dart';




final riverpodAuthControllerProvider=Provider(
        (ref)=> AuthController(authRepository: ref.read(authRepositoryProvider1))
);

class AuthController{
  final RiverpodAuthRepository _authRepository;
  AuthController({
    required RiverpodAuthRepository authRepository
  }) : _authRepository =authRepository;

  void signInWithGoogle(BuildContext context){
    _authRepository.signInWithGoogle(context);
  }

  signOutRiverpod(BuildContext context) async {
    _authRepository.signOutRiverpod(context);
  }

}