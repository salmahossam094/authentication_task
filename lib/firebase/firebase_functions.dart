import 'package:authentication_task/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseFunctions {
  static CollectionReference<UserModel> getUsersCollections() {
    return FirebaseFirestore.instance
        .collection("Users")
        .withConverter<UserModel>(
          fromFirestore: (snapshot, options) =>
              UserModel.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
  }

  static Future<void> createAccount(String userName, String email,
      String password, Function created, Function onError) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserModel userModel =
          UserModel(userName: userName, email: email, id: credential.user!.uid);
      addUserToFirestore(userModel).then((value) {
        created();
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        onError(e.message);
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        onError(e.message);
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> addUserToFirestore(UserModel userModel) {
    var collection = getUsersCollections();
    var docRef = collection.doc(userModel.id);
    return docRef.set(userModel);
  }

  static Future<void> login(
      String email, String password, Function logged, Function onError) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      logged();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        onError(e.message);
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        onError(e.message);
      }
    }
  }
}
