import 'package:firebase_auth/firebase_auth.dart';


// class AuthService {
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

//   Stream<User?> get onAuthStateChanged => _firebaseAuth.authStateChanges();

//   // GET UID
//   Future<String> getCurrentUID() async {
//     return _firebaseAuth.currentUser!.uid;
//   }
// }








// class AuthService {
//     final FirebaseAuth _auth = FirebaseAuth.instance;

//   Future registerUser(String email, String password) async {
//     try {
//       UserCredential user =
//           // await FirebaseAuth.instance.createUserWithEmailAndPassword(
//             await _auth.createUserWithEmailAndPassword(
//         email: email.trim(),
//         password: password.trim(),
//       );
//       return user;
//     } on FirebaseAuthException catch (e) {
//       print(e);
//     }
//   }





// }


//   // final FirebaseAuth _auth = FirebaseAuth.instance;

// // email password sign in--
//   Future signInWithUsernameAndPassword(String email, String password) async {
//     await FirebaseAuth.instance
//         .signInWithEmailAndPassword(email: email, password: password);
//   }

//   Future registerUser(String email, String password) async {
//     UserCredential user =
//         await FirebaseAuth.instance.createUserWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//     return user;
//   }
// }
