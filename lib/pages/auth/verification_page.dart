import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zelow/components/constant.dart';
import 'package:zelow/services/auth_service.dart';

class VerificationPage extends StatefulWidget {
  final User user;

  const VerificationPage({super.key, required this.user});

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final AuthService _authService = AuthService();
  int _timerSeconds = 30;
  bool _canResendCode = false;
  String _email = "Loading...";
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _email = widget.user.email ?? "Unknown";
    _startResendTimer();

    _authService.checkEmailVerifiedPeriodically(widget.user, (isVerified) {
      if (isVerified && mounted) {}
    }, context);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startResendTimer() {
    setState(() {
      _canResendCode = false;
      _timerSeconds = 30;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerSeconds > 0) {
        setState(() {
          _timerSeconds--;
        });
      } else {
        timer.cancel();
        setState(() {
          _canResendCode = true;
        });
      }
    });
  }

  Future<void> _resendVerificationEmail() async {
    try {
      await _authService.resendVerificationEmail(widget.user);
      _startResendTimer();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email verifikasi dikirim ulang")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Verifikasi',
          style: blackTextStyle.copyWith(
            fontSize: MediaQuery.of(context).size.width * 0.05,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Verification Page',
              style: blackTextStyle.copyWith(
                fontSize: MediaQuery.of(context).size.width * 0.06,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 7),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: blackTextStyle.copyWith(
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  fontWeight: FontWeight.normal,
                ),
                children: [
                  const TextSpan(
                    text: 'We’ve sent an Email with an activation code to ',
                  ),
                  TextSpan(
                    text: _email,
                    style: blackTextStyle.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            if (!_canResendCode)
              Text(
                '00:${_timerSeconds.toString().padLeft(2, '0')}',
                style: blackTextStyle.copyWith(
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  fontWeight: FontWeight.w400,
                ),
              ),
            if (_canResendCode)
              GestureDetector(
                onTap: _resendVerificationEmail,
                child: Text(
                  'Resend Email',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
