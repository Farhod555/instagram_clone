import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/auth/sign_up_state.dart';
import 'package:instagram_clone/model/user_model.dart';
import 'package:instagram_clone/service/auth_service.dart';
import 'package:instagram_clone/service/db_service.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInit());

  void signUp(String fullName, String email, String password) async {
    emit(AuthLoading());
    final response = await AuthService.signUpUser(fullName, email, password);

    if(response != null){
      UserModel user = UserModel(fullName, email);
      DBService.saveUser(user);
      emit(AuthSuccess());
    } else {
      emit(AuthError('Something is wrong'));
    }
  }


  Future<void> signIn(String email, String password) async {
    emit(AuthLoading());
    final responce = await AuthService.signInUser(email, password);


    if(responce != null){
      emit(AuthSuccess());
    } else {
      emit(AuthError('Something is wrong'));
    }
    }
  }
