import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  // title & sub title
  Widget _buildTitleText() {
    return Column(
      children: [
        // 상단 spacing
        SizedBox(height: 40.0),
        // main title
        Text(
          'title',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5.0),
        // sub title
        Text(
          'it is a sub title',
          style: TextStyle(
            fontSize: 10.0,
          ),
        ),
        SizedBox(height: 40.0),
      ],
    );
  }

  // text field 공용 const
  final _kLabelStyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );

  final _kBoxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(10.0),
    boxShadow: [
      BoxShadow(
        color: Colors.white24,
        blurRadius: 6.0,
        offset: Offset(0, 2),
      ),
    ],
  );

  final _kHintTextStyle = TextStyle(fontSize: 10.0, color: Colors.grey);

  // email 입력
  var _email = '';
  var _emailError = '';

  Widget _buildEmailTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('email', style: _kLabelStyle),
        Container(
            height: 30.0,
            decoration: _kBoxDecoration,
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: 'enter email address', hintStyle: _kHintTextStyle),
              onChanged: (value) {
                if (_emailError.isNotEmpty) {
                  setState(() {
                    _emailError = '';
                  });
                }

                setState(() {
                  _email = value;
                });
              },
            )),
        SizedBox(height: 5.0),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Text(
            _emailError,
            style: TextStyle(fontSize: 10.0, color: Colors.red),
          )
        ]),
        SizedBox(height: 10.0),
      ],
    );
  }

  // password 입력
  var _password = '';
  var _passwordError = '';

  Widget _buildPasswordTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('password', style: _kLabelStyle),
        Container(
            height: 30.0,
            decoration: _kBoxDecoration,
            child: TextField(
              obscureText: true, // 비밀번호 char 사용
              decoration: InputDecoration(
                hintText: 'enter password',
                hintStyle: _kHintTextStyle,
              ),
              onChanged: (value) {
                if (_passwordError.isNotEmpty) {
                  setState(() {
                    _passwordError = '';
                  });
                }

                setState(() {
                  _password = value;
                });
              },
            )),
        SizedBox(height: 5.0),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Text(
            _passwordError,
            style: TextStyle(fontSize: 10.0, color: Colors.red),
          )
        ]),
        SizedBox(height: 10.0),
      ],
    );
  }

  // forgot password 링크
  Widget _buildForgotPasswordText() {
    void _showForgotPasswordAlert() {
      Widget okButton = TextButton(
          child: Text('ok'),
          onPressed: () {
            Navigator.pop(context);
          });

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('forgot password?'),
              content: Text('What a shame..🤣'),
              actions: [okButton],
            );
          });
    }

    return Column(
      children: [
        Container(
            alignment: Alignment.centerRight,
            child: InkWell(
                child: Text(
                  'forgot password?',
                  style: TextStyle(
                      fontSize: 10.0, decoration: TextDecoration.underline),
                ),
                onTap: () => _showForgotPasswordAlert())),
        SizedBox(height: 30.0)
      ],
    );
  }

  // login 버튼
  Widget _buildLoginButton() {
    void _showLoginAlert() {
      // empty email
      if (_email.isEmpty == true) {
        setState(() {
          _emailError = 'no email address';
        });
        return;
      }
      // invalid email
      if (RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
              .hasMatch(_email) ==
          false) {
        setState(() {
          _emailError = 'invalid email address';
        });
        return;
      }

      // empty password
      if (_password.isEmpty == true) {
        setState(() {
          _passwordError = 'no password';
        });
        return;
      }
      // invalid password
      if (RegExp(r'^(?=.*[A-Z].*[A-Z])(?=.*[!@#$&*])(?=.*[0-9].*[0-9])(?=.*[a-z].*[a-z].*[a-z]).{8}$')
              .hasMatch(_password) ==
          false) {
        // ^                         Start anchor
        // (?=.*[A-Z].*[A-Z])        Ensure string has two uppercase letters.
        // (?=.*[!@#$&*])            Ensure string has one special case letter.
        // (?=.*[0-9].*[0-9])        Ensure string has two digits.
        // (?=.*[a-z].*[a-z].*[a-z]) Ensure string has three lowercase letters.
        // .{8}                      Ensure string is of length 8.
        // $                         End anchor.
        setState(() {
          _passwordError = 'invalid password';
        });
        return;
      }

      Widget okButton = TextButton(
          child: Text("ok"),
          onPressed: () {
            Navigator.pop(context);
          });

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Login info'),
              content: Text('id: ' + _email + '\r\npw: ' + _password),
              actions: [okButton],
            );
          });
    }

    return Column(
      children: [
        Container(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => _showLoginAlert(),
            child: Text('sign in'),
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(0.0), // flat 하게
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0))),
              backgroundColor: MaterialStateProperty.all(Colors.black),
            ),
          ),
        ),
        SizedBox(height: 10.0)
      ],
    );
  }

  // sns 버튼
  Widget _buildSocialButtons() {
    final _kSocialTextStyle =
        TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold);

    void _showSocialAlert() {
      Widget okButton = TextButton(
          child: Text('ok'),
          onPressed: () {
            Navigator.pop(context);
          });

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Login info'),
              content: Text('id: ' + _email + '\r\npw: ' + _password),
              actions: [okButton],
            );
          });
    }

    Widget _buildSocialButton(String assetName) {
      return Row(
        children: [
          GestureDetector(
            onTap: () => _showSocialAlert(),
            child: Container(
              height: 40.0,
              width: 40.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 6.0,
                    )
                  ],
                  image: DecorationImage(
                    image: AssetImage(assetName),
                    scale: 0.5,
                  )),
            ),
          ),
          SizedBox(width: 10.0)
        ],
      );
    }

    return Column(
      children: [
        Text('- or -', style: _kSocialTextStyle),
        SizedBox(height: 10.0),
        Text('sign in with', style: _kSocialTextStyle),
        SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialButton('assets/image/google.png'),
            _buildSocialButton('assets/image/facebook.png'),
            _buildSocialButton('assets/image/kakaotalk.png')
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // scrollable 영역
          SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 50.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _buildTitleText(),
                      _buildEmailTextField(),
                      _buildPasswordTextField(),
                      _buildForgotPasswordText(),
                      _buildLoginButton(),
                      _buildSocialButtons(),
                    ],
                  ))),
        ],
      ),
    );
  }
}
