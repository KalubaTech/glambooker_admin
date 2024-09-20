import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:glambooker_admin/controllers/client_controller.dart';
import 'package:glambooker_admin/models/client_model.dart';

import '../views/auth/sign_in.dart';
import '../views/pages_anchor.dart';


class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  ClientController _clientController = Get.find();


  // Sign up with email and password
  Future<User?> signUpWithEmailAndPassword(String email, String password, String name, String phone) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      Map<String,dynamic> data = {
        "uid":userCredential.user!.uid,
        "email":userCredential.user!.email,
        "phone":phone,
        "displayName":name
      };

      await _firebaseFirestore.collection('client').add(data);

      ClientModel _client = ClientModel(uid: userCredential.user!.uid, email: email, name: name, phone: phone,picture: '');

      _clientController.client.value = _client;
      _clientController.update();

      Get.offAll(()=>PagesAnchor());

    return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print("Error: $e");
      return null;
    }
  }

  // Sign in with email and password
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      print(userCredential!.user);
      var _clientData = await _firebaseFirestore.collection('client').where('uid',isEqualTo: userCredential.user!.uid).get();
      var doc = _clientData.docs.first.data();

      print(doc);

      ClientModel _clientModel = ClientModel(
          uid: _clientData.docs.first.id,
          email: email,
          name: doc['displayName'],
          phone: doc['phone'],
          picture: ''
      );

      _clientController.client.value = _clientModel;
      _clientController.update();

      Get.off(()=>PagesAnchor());

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print("Error: $e");
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
    Get.offAll(()=>SignIn(), transition: Transition.fadeIn);
  }

  // Get the currently signed-in user
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
