import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:skilltest/blocs/validation_mixin.dart';
import 'package:rxdart/subjects.dart';

import 'package:fluttertoast/fluttertoast.dart';

class FormBloc with ValidationMixin {
  final _nameController = BehaviorSubject<String>();
  final _phoneController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _confirmPasswordController = BehaviorSubject<String>();

//get
  Stream<String> get nameStream =>
      _nameController.stream.transform(nameTransformer);
  Stream<int> get phoneStream =>
      _phoneController.stream.transform(phoneTransformer);
  Stream<String> get emailStream =>
      _emailController.stream.transform(emailTransformer);
  Stream<String> get passStream =>
      _passwordController.stream.transform(passwordTransformer);
  Stream<String> get conPassStream => _confirmPasswordController.stream
          .transform(confirmPasswordTransformer)
          .doOnData((String confirmPassword) {
        if (0 != _passwordController.value.compareTo(confirmPassword)) {
          _confirmPasswordController.addError("Passwords do not match");
        }
      });

//set
  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changePhone => _phoneController.sink.add;
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePass => _passwordController.sink.add;
  Function(String) get changeConPass => _confirmPasswordController.sink.add;

  Stream<bool> get formValid => Rx.combineLatest5(
        nameStream,
        emailStream,
        phoneStream,
        passStream,
        conPassStream,
        (
          nameStream,
          emailStream,
          phoneStream,
          passStream,
          conPassStream,
        ) =>
            true,
      );

  void afterSubmit() {
    String email = _emailController.value;
    String phone = _phoneController.value;
    print("Email address $email and password is $phone");

    Fluttertoast.showToast(
      msg: "Your form has been received!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      webBgColor: "#e74c3c",
      timeInSecForIosWeb: 5,
    );
  }

  dispose() {
    _emailController.close();
    _phoneController.close();
    _nameController.close();
    _passwordController.close();
    _confirmPasswordController.close();
  }
}
