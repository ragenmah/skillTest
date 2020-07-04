import 'dart:async';

class ValidationMixin {
  final emailTransformer = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      // if (email.isEmpty) {
      //   // return 'Email is required';
      //   sink.addError("Email is required");
      // }
      if ((email.contains("@") && email.contains(".")) &&
          RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
              .hasMatch(email)) {
        sink.add(email);
      } else {
        sink.addError("Please enter valid email address");
      }
    },
  );

  final passwordTransformer = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      if (password.length > 4) {
        sink.add(password);
      } else {
        sink.addError("Password must be at least 5 charactes long");
      }
    },
  );
  final confirmPasswordTransformer =
      StreamTransformer<String, String>.fromHandlers(
    handleData: (cpassword, sink) {
      if (cpassword.length > 4) {
        sink.add(cpassword);
      } else {
        sink.addError("Password must be at least 5 charactes long");
      }
    },
  );
  final nameTransformer = StreamTransformer<String, String>.fromHandlers(
    handleData: (name, sink) {
      if (name.length > 4) {
        sink.add(name);
      } else {
        sink.addError("Name must be at least 5 charactes long");
      }
    },
  );
  final phoneTransformer = StreamTransformer<String, int>.fromHandlers(
    handleData: (phone, sink) {
      if (phone.length < 10) {
        sink.addError("Phone number must be of 10 digits");
      } else {
        sink.add(int.parse(phone));
      }
    },
  );
}
