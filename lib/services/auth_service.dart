import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zelow/pages/auth/verification_page.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signIn(
    String email,
    String password,
    BuildContext context,
    Function(String) onError,
    Function(bool) onLoading,
  ) async {
    Timer? timer;
    try {
      onLoading(true);

      timer = Timer(Duration(minutes: 1), () {
        if (context.mounted) {
          onLoading(false);
          onError('Periksa koneksi anda/gunakan koneksi yang stabil');
        }
      });

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        DocumentSnapshot userDoc =
            await _firestore.collection('user').doc(user.uid).get();
        if (userDoc.exists) {
          String role = userDoc.get('role');
          if (role == 'user') {
            Navigator.pushReplacementNamed(context, '/home_page_user');
          } else if (role == 'umkm') {
            Navigator.pushReplacementNamed(context, '/home_page_umkm');
          } else {
            if (context.mounted) {
              onError('Role tidak dikenali');
            }
          }
        } else {
          if (context.mounted) {
            onError('Akun anda belum terdaftar, silahkan hubungi admin');
          }
        }
      }
    } catch (e) {
      if (context.mounted) {
        onError('Error signing in: $e');
      }
    } finally {
      timer?.cancel();
      if (context.mounted) {
        onLoading(false);
      }
    }
  }

  Future<void> signUp(
    String email,
    String password,
    String fullname,
    String username,
    String role,
    BuildContext context,
    Function(String) onError,
    Function(bool) onLoading,
  ) async {
    Timer? timer;
    try {
      onLoading(true);

      timer = Timer(Duration(minutes: 1), () {
        if (context.mounted) {
          onLoading(false);
          onError('Periksa koneksi anda/gunakan koneksi yang stabil');
        }
      });

      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;
      if (user != null) {
        await user.sendEmailVerification();

        await _firestore.collection('user').doc(user.uid).set({
          'email': email,
          'fullname': fullname,
          'username': username,
          'role': role,
          'isVerified': false,
        });

        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => VerificationPage(user: user),
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        onError('Error signing up: $e');
      }
    } finally {
      timer?.cancel();
      if (context.mounted) {
        onLoading(false);
      }
    }
  }

  Future<void> resendVerificationEmail(User user) async {
    try {
      await user.sendEmailVerification();
    } catch (e) {
      throw Exception("Gagal mengirim ulang email: $e");
    }
  }

  Future<bool> isEmailVerified(User user) async {
    await user.reload();
    return user.emailVerified;
  }

  void checkEmailVerifiedPeriodically(
    User user,
    Function(bool) onVerified,
    BuildContext context,
  ) {
    Timer.periodic(const Duration(seconds: 3), (timer) async {
      await user.reload();
      User? updatedUser = FirebaseAuth.instance.currentUser;

      if (updatedUser != null && updatedUser.emailVerified) {
        timer.cancel();

        await FirebaseFirestore.instance
            .collection('user')
            .doc(updatedUser.uid)
            .update({'isVerified': true});

        DocumentSnapshot userDoc =
            await FirebaseFirestore.instance
                .collection('user')
                .doc(updatedUser.uid)
                .get();
        if (userDoc.exists) {
          String role = userDoc.get('role');

          if (context.mounted) {
            if (role == 'user') {
              Navigator.pushReplacementNamed(context, '/home_page_user');
            } else if (role == 'umkm') {
              Navigator.pushReplacementNamed(context, '/home_page_umkm');
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Role tidak dikenali")),
              );
            }
          }
        }

        onVerified(true);
      }
    });
  }

  Future<void> sendPasswordResetOTP(
    String email,
    Function(String) onError,
    Function(bool) onLoading,
  ) async {
    try {
      onLoading(true);

      var userQuery =
          await _firestore
              .collection('user')
              .where('email', isEqualTo: email)
              .get();

      if (userQuery.docs.isEmpty) {
        onError('Email tidak ditemukan');
        return;
      }

      String otpCode = (Random().nextInt(900000) + 100000).toString();

      await _firestore.collection('password_reset').doc(email).set({
        'otp': otpCode,
        'expiresAt': DateTime.now().add(Duration(minutes: 5)),
      });

      print("OTP untuk reset password: $otpCode");

      onLoading(false);
    } catch (e) {
      onError('Gagal mengirim OTP: $e');
      onLoading(false);
    }
  }

  Future<bool> verifyOTP(String email, String enteredOTP) async {
    var otpDoc = await _firestore.collection('password_reset').doc(email).get();

    if (!otpDoc.exists) return false;

    String savedOTP = otpDoc.get('otp');
    DateTime expiresAt = otpDoc.get('expiresAt').toDate();

    if (savedOTP == enteredOTP && DateTime.now().isBefore(expiresAt)) {
      return true;
    }

    return false;
  }

  Future<void> resetPassword(
    String email,
    String newPassword,
    Function(String) onError,
    Function(bool) onLoading,
  ) async {
    try {
      onLoading(true);

      User? user = _auth.currentUser;

      if (user != null) {
        await user.updatePassword(newPassword);
        onLoading(false);
      } else {
        onError("User tidak ditemukan atau belum login.");
      }
    } catch (e) {
      onError("Gagal mengubah password: $e");
      onLoading(false);
    }
  }

  Future<void> logout(BuildContext context) async {
    try {
      await _auth.signOut();
      Navigator.pushReplacementNamed(context, '/login_page');
    } catch (e) {
      print('Error signing out: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error signing out: $e')));
    }
  }
}
