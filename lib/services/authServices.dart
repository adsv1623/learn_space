import 'package:firebase_auth/firebase_auth.dart';
import 'package:learn_space/module/userData.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  // return user Uid
  userData _userFromfirebaseUser(User user){
    return user!=null ? userData(userId:user.uid ): null;
  }

  // Sign In with Email & Password
  Future signInWithEmailAndPassword(String _email, String _password) async {
       try{
          UserCredential result = await _auth.signInWithEmailAndPassword(email: _email, password: _password);
          User firebaseUser = result.user;
          return _userFromfirebaseUser(firebaseUser);
       }catch(e){
         print('Error At authService L69 :  '+e.toString());
       }
  }

  //SignUp
  Future signUpWithEmailAndPassword(String _email,String _password) async{
    try{
        UserCredential result = await _auth.createUserWithEmailAndPassword(email: _email, password: _password);
        User firebaseUser = result.user;
        return _userFromfirebaseUser(firebaseUser);
    }catch(e){
      print('Error At authService L75 :  '+e.toString());
    }
  }

  /// reset Password
  Future resetPassword(String _email)async{
    try{
        return await _auth.sendPasswordResetEmail(email: _email);
    }catch(e){
      print('Error At authService L75 :  '+e.toString());
    }
  }

// SignOut
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print('Error At authService L96 :  '+e.toString());
    }
  }
}
