import 'package:car_world_system/sources/model/userLogin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSingInProvider {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static GoogleSignIn googleSignIn = GoogleSignIn();

  static Future<UserLogin?> signInWithGoogle() async {
    await Firebase.initializeApp();

    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult =
        await _auth.signInWithCredential(credential);
    final User? user = authResult.user;

    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User? currentUser = _auth.currentUser;
      assert(user.uid == currentUser!.uid);

      print('signInWithGoogle succeeded: $user');

      UserLogin userLogin = new UserLogin(
        email: user.email.toString(),
        fullName: user.displayName.toString(),
        image: user.photoURL.toString(),
        phone: user.phoneNumber.toString(),
        deviceToken: "",
      );

      return userLogin;
    }
    return null;
  }

  static Future<void> signOutGoogle() async {
    await googleSignIn.signOut();

    print("User Signed Out");
  }
}
