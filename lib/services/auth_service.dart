import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zelow/pages/auth/verification_page.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

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
          'userId': user.uid,
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

  Future<void> sendPasswordResetEmail(
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

      await _auth.sendPasswordResetEmail(email: email);
      onLoading(false);
    } catch (e) {
      onError('Gagal mengirim email reset password: $e');
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

  Future<void> signInWithGoogle(
    BuildContext context,
    Function(String) onError,
    Function(bool) onLoading,
  ) async {
    onLoading(true);
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        onLoading(false);
        return; // user batal login
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );
      User? user = userCredential.user;

      if (user != null) {
        // Cek apakah user sudah ada di firestore
        DocumentSnapshot userDoc =
            await _firestore.collection('user').doc(user.uid).get();

        if (!userDoc.exists) {
          // Kalau belum ada, buat dokumen baru dengan default role user
          await _firestore.collection('user').doc(user.uid).set({
            'email': user.email,
            'fullname': user.displayName ?? '',
            'username': user.email?.split('@')[0] ?? '',
            'role': 'user',
            'isVerified': user.emailVerified,
          });
        }

        // Ambil role dari firestore
        userDoc = await _firestore.collection('user').doc(user.uid).get();
        String role = userDoc.get('role');

        if (context.mounted) {
          if (role == 'user') {
            Navigator.pushReplacementNamed(context, '/home_page_user');
          } else if (role == 'umkm') {
            Navigator.pushReplacementNamed(context, '/home_page_umkm');
          } else {
            onError('Role tidak dikenali');
          }
        }
      }
    } catch (e) {
      if (context.mounted) {
        onError('Error login dengan Google: $e');
      }
    } finally {
      if (context.mounted) {
        onLoading(false);
      }
    }
  }

  Future<void> signInWithFacebook(
    BuildContext context,
    Function(String) onError,
    Function(bool) onLoading,
  ) async {
    onLoading(true);
    try {
      // Lakukan login dengan Facebook
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'], // Izin yang dibutuhkan
      );

      if (result.status == LoginStatus.success) {
        // Dapatkan access token
        final AccessToken? accessToken = result.accessToken;
        if (accessToken == null) {
          onLoading(false);
          onError('Gagal mendapatkan token Facebook');
          return;
        }

        // Buat credential untuk Firebase
        final OAuthCredential credential = FacebookAuthProvider.credential(
          accessToken.tokenString,
        );

        // Login ke Firebase dengan credential
        UserCredential userCredential = await _auth.signInWithCredential(
          credential,
        );
        User? user = userCredential.user;

        if (user != null) {
          // Cek apakah user sudah ada di Firestore
          DocumentSnapshot userDoc =
              await _firestore.collection('user').doc(user.uid).get();

          if (!userDoc.exists) {
            // Jika belum ada, buat dokumen baru dengan default role 'user'
            await _firestore.collection('user').doc(user.uid).set({
              'email': user.email ?? '',
              'fullname': user.displayName ?? '',
              'username': user.email?.split('@')[0] ?? '',
              'role': 'user',
              'isVerified': user.emailVerified,
            });
          }

          // Ambil role dari Firestore
          userDoc = await _firestore.collection('user').doc(user.uid).get();
          String role = userDoc.get('role');

          if (context.mounted) {
            if (role == 'user') {
              Navigator.pushReplacementNamed(context, '/home_page_user');
            } else if (role == 'umkm') {
              Navigator.pushReplacementNamed(context, '/home_page_umkm');
            } else {
              onError('Role tidak dikenali');
            }
          }
        }
      } else {
        onLoading(false);
        onError('Login Facebook dibatalkan atau gagal: ${result.message}');
      }
    } catch (e) {
      if (context.mounted) {
        onError('Error login dengan Facebook: $e');
      }
    } finally {
      if (context.mounted) {
        onLoading(false);
      }
    }
  }
}
