import 'dart:io';

import 'package:baader/data/services/register_services.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  void register(
    String firstName,
    String lastName,
    String email,
    String passWord,
    String phone,
    File image,
  ) {
    emit(
      RegisterLoading(),
    );

    try {
      RegisterService()
          .register(
        firstName,
        lastName,
        email,
        passWord,
        phone,
        image,
      )
          .then(
        (value) {
          if (value != 'fail') {
            emit(
              RegisterSuccess(token: value),
            );
          } else {
            emit(
              RegisterFail(
                errmsg: value,
              ),
            );
          }
        },
      );
    } catch (e) {
      emit(
        RegisterFail(
          errmsg: e.toString(),
        ),
      );
    }
  }
}
