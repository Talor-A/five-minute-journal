import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:june_lake/model/user.dart';
import 'package:rxdart/rxdart.dart';

abstract class AuthState {
  get user;
}

class LoggedIn extends AuthState {
  User user;

  LoggedIn(this.user);
}

class LoggedOut extends AuthState {
  get user => null;
}

class Loading extends AuthState {
  get user => null;
}

class AuthService {
  final FirebaseAuth _firebaseAuth;
  BehaviorSubject<AuthState> status;

  AuthService(this._firebaseAuth) {
    status = BehaviorSubject<AuthState>.seeded(Loading());

    listen();
  }
  listen() async {
    await for (FirebaseUser u in _firebaseAuth.onAuthStateChanged) {
      if (u != null) {
        DocumentSnapshot snap =
            await Firestore.instance.collection('users').document(u.uid).get();
        User user = User.fromFirestore(snap);
        print(user);
        status.add(LoggedIn(user));
      } else {
        status.add(LoggedOut());
      }
    }
  }

  Future<AuthResult> signIn(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<AuthResult> signUp({String email, String password}) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  bool isSignedIn() {
    return this.status.value is LoggedIn;
  }

  User getCurrentUser() => this.status.value.user;
}

final AuthService auth = AuthService(FirebaseAuth.instance);
