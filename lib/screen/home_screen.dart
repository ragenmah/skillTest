import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skilltest/blocs/form_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  // final TextEditingController _passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<FormBloc>(context);

    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(title: Text("Question 4 Solution")),
      body: Container(margin: EdgeInsets.all(24), child: myForm(bloc)),
    ));
  }

  Widget myForm(FormBloc bloc) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildNameField(bloc),
            _buildPhoneNumber(bloc),
            _buildEmailField(bloc),
            _buildPasswordField(bloc),
            _buildConfirmPasswordField(bloc),
            _buildSubmitButton(bloc)
          ],
        ),
      ),
    );
  }

  Widget _buildNameField(FormBloc bloc) {
    return StreamBuilder(
      stream: bloc.nameStream,
      builder: (context, snapshot) => TextFormField(
        decoration: InputDecoration(
          icon: Icon(
            Icons.supervised_user_circle,
            color: Colors.grey,
          ),
          labelText: "Your Name",
          labelStyle: TextStyle(color: Colors.white),
          errorText: snapshot.error,
        ),
        keyboardType: TextInputType.text,
        style: TextStyle(fontSize: 18, color: Colors.white),
        cursorColor: Colors.white,
        onChanged: bloc.changeName,
        onSaved: (String value) {
          // _user.displayName = value;
        },
      ),
    );
  }

  Widget _buildPhoneNumber(FormBloc bloc) {
    return StreamBuilder(
      stream: bloc.phoneStream,
      builder: (context, snapshot) => TextFormField(
        decoration: InputDecoration(
          icon: Icon(
            Icons.phone,
            color: Colors.grey,
          ),
          labelText: "Phone Number",
          labelStyle: TextStyle(color: Colors.white),
          errorText: snapshot.error,
        ),
        maxLength: 10,
        keyboardType: TextInputType.phone,
        style: TextStyle(fontSize: 18, color: Colors.white),
        cursorColor: Colors.white,
        onChanged: bloc.changePhone,
        onSaved: (String value) {
          // _url = value;
        },
      ),
    );
  }

  Widget _buildEmailField(FormBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (context, snapshot) => TextFormField(
        decoration: InputDecoration(
            labelText: "Email",
            labelStyle: TextStyle(color: Colors.white),
            hintText: 'example@example.com',
            errorText: snapshot.error,
            icon: new Icon(
              Icons.mail,
              color: Colors.grey,
            )),
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(fontSize: 18, color: Colors.white),
        cursorColor: Colors.white,
        onChanged: bloc.changeEmail,
        onSaved: (String value) {
          // _user.email = value;
        },
      ),
    );
  }

  Widget _buildPasswordField(FormBloc bloc) {
    return StreamBuilder(
      stream: bloc.passStream,
      builder: (context, snapshot) => TextFormField(
        decoration: InputDecoration(
          labelText: "Password",
          labelStyle: TextStyle(color: Colors.white),
          // hintText: 'Password',

          icon: new Icon(
            Icons.lock,
            color: Colors.grey,
          ),
          errorText: snapshot.error,
        ),
        style: TextStyle(fontSize: 16, color: Colors.white),
        cursorColor: Colors.white,
        obscureText: true,
        onChanged: bloc.changePass,
        // validator: (String value) {
        //   if (value.isEmpty) {
        //     return 'Password is required';
        //   }
        //   if (value.length >= 6) {
        //     return ' Password should be at least 6 characters';
        //   }

        //   return null;
        // },
        onSaved: (String value) {
          // _user.password = value;
        },
      ),
    );
  }

  Widget _buildConfirmPasswordField(FormBloc bloc) {
    return StreamBuilder(
      stream: bloc.conPassStream,
      builder: (context, snapshot) => TextFormField(
        decoration: InputDecoration(
          labelText: "Confirm Password",
          labelStyle: TextStyle(color: Colors.white),
          icon: new Icon(
            Icons.lock,
            color: Colors.grey,
          ),
          errorText: snapshot.error,
        ),
        style: TextStyle(fontSize: 16, color: Colors.white),
        cursorColor: Colors.white,
        obscureText: true,
        onChanged: bloc.changeConPass,
        // validator: (String value) {
        //   if (_passwordController.text != value) {
        //     return 'Passwords do not match';
        //   }

        //   return null;
        // },
      ),
    );
  }

  Widget _buildSubmitButton(FormBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValid,
      builder: (context, snapshot) => Container(
        padding: const EdgeInsets.only(left: 150.0, top: 40.0),
        child: new RaisedButton(
          child: const Text('Submit'),
          onPressed: !snapshot.hasData ? null : bloc.afterSubmit,
        ),
      ),
    );
  }
}
