import 'package:commwatch/blocs/datamodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

FirebaseAuth auth = FirebaseAuth.instance;
CollectionReference settings =
    FirebaseFirestore.instance.collection('settings');
CollectionReference history = FirebaseFirestore.instance.collection('history');
CollectionReference community =
    FirebaseFirestore.instance.collection('community');
CollectionReference devices = FirebaseFirestore.instance.collection('devices');
CollectionReference alerts = FirebaseFirestore.instance.collection('alerts');
CollectionReference calerts = FirebaseFirestore.instance.collection('calerts');

class AuthBloc extends Object {
  Future<bool> loadAuthState() async {
    return auth.currentUser != null;
  }

  Future<String?> signupWithEmail(model) async {
    String? result = "success";
    try {
      await auth.createUserWithEmailAndPassword(
          email: model.email, password: model.password);
    } on FirebaseAuthException catch (e) {
      result = e.message;
    }
    return result;
  }

  Future<String?> loginWithEmail(model) async {
    String? result = "success";
    try {
      await auth.signInWithEmailAndPassword(
          email: model.email, password: model.password);
    } on FirebaseAuthException catch (e) {
      result = e.message;
    }
    return result;
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<String?> resetPassword(model) async {
    String? result = "success";
    try {
      await auth.sendPasswordResetEmail(email: model.email);
    } on FirebaseAuthException catch (e) {
      result = e.message;
    }
    return result;
  }

  Future<bool?> logout() async {
    bool? result = false;
    try {
      await auth.signOut();
      result = true;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      result = false;
    }
    return result;
  }

  Future setData(String coll, model) async {
    bool? result = false;
    try {
      if (coll == "settings") {
        return settings.doc(auth.currentUser?.uid).set({
          'userType': model.userType,
          'name': model.name,
          'email': model.email,
          'phone': model.phone,
          'address': model.address,
          'ephone1': model.ephone1,
          'uid': auth.currentUser?.uid, // uid
        });
      }
      if (coll == "history") {
        return history.add({
          'dttm': model.dttm,
          'prompt': model.prompt,
          'res': model.res,
          'like': model.like,
          'unlike': model.unlike,
          'bookmark': model.bookmark,
          'file': model.file,
          'uid': auth.currentUser?.uid, // uid
        });
      }
      if (coll == "community") {
        return community.doc(auth.currentUser?.uid).set({
          'name': model.name,
          'uid': auth.currentUser?.uid, // uid
        });
      }
      if (coll == "devices") {
        return devices.add({
          'type': model.type,
          'mfg': model.mfg,
          'api': model.api,
          'license': model.license,
          'description': model.description,
          'uid': auth.currentUser?.uid, // uid
        });
      }
      result = true;
    } on FirebaseAuthException catch (e) {
      result = false;
    }
    return result;
  }

  Future getData(String coll) async {
    if (auth.currentUser != null) {
      if (coll == "settings")
        return await settings.doc(auth.currentUser?.uid).get();
      if (coll == "history")
        return await history.doc(auth.currentUser?.uid).get();
      if (coll == "community")
        return await community.doc(auth.currentUser?.uid).get();
    }
  }

  Future<List<dynamic>> getDocs(String coll) async {
    if (auth.currentUser != null) {
      if (coll == "history") {
        List docList = [];
        List testNewList = [];
        try {
          await history
              .where('uid', isEqualTo: auth.currentUser?.uid)
              .where('dttm',
                  isLessThan: DateTime.now().add(new Duration(days: 20)))
              .get()
              .then((value) {
            // print(value.docs.toList());

            for (final child in value.docs) {
              docList.add(child.id);
            }
          });

          for (final index in docList) {
            final docRef = history.doc(index);
            testNewList.add(await docRef.get().then((DocumentSnapshot doc) {
              // print(doc.data());
              final docData = doc.data();
              return docData;
            }));
          }

          /* print(docList);
          print(testNewList); */
          return await testNewList;
        } catch (e) {
          print(e.toString());
          throw ('something is wrong');
        }
      }
      if (coll == "alerts") {
        List docList = [];
        List testNewList = [];
        try {
          await alerts
              .where('uid', isEqualTo: auth.currentUser?.uid)
              .where('dttm',
                  isLessThan: DateTime.now().add(new Duration(days: 20)))
              .get()
              .then((value) {
            // print(value.docs.toList());

            for (final child in value.docs) {
              docList.add(child.id);
            }
          });

          for (final index in docList) {
            final docRef = alerts.doc(index);
            testNewList.add(await docRef.get().then((DocumentSnapshot doc) {
              // print(doc.data());
              final docData = doc.data();
              return docData;
            }));
          }

          /* print(docList);
          print(testNewList); */
          return await testNewList;
        } catch (e) {
          print(e.toString());
          throw ('something is wrong');
        }
      }
      if (coll == "devices") {
        List docListd = [];
        List testNewListd = [];
        try {
          await devices
              .where('uid', isEqualTo: auth.currentUser?.uid)
              .get()
              .then((value) {
            // print(value.docs.toList());

            for (final child in value.docs) {
              docListd.add(child.id);
            }
          });

          for (final index in docListd) {
            final docRef = devices.doc(index);
            testNewListd.add(await docRef.get().then((DocumentSnapshot doc) {
              // print(doc.data());
              final docData = doc.data();
              return docData;
            }));
          }

          /* print(docListd);
          print(testNewListd); */
          return await testNewListd;
        } catch (e) {
          print(e.toString());
          throw ('something is wrong');
        }
      }
    }
    return [];
  }

  Future getPrompt(PromptDataModel model) async {
    setData("history", model);
    if (auth.currentUser != null) {
      return "here are the prompt results. please see Gemini API calls are served through Firebase cloud functions and is disabled to save on costs.";
    }
  }
}

final authBloc = AuthBloc();

// google location API sample output
// https://maps.googleapis.com/maps/api/geocode/json?address=1600+Amphitheatre+Parkway,+Mountain+View,+CA&key=YOUR_API_KEY

// {
//     "results": [
//         {
//             "address_components": [
//                 {
//                     "long_name": "1600",
//                     "short_name": "1600",
//                     "types": [
//                         "street_number"
//                     ]
//                 },
//                 {
//                     "long_name": "Amphitheatre Parkway",
//                     "short_name": "Amphitheatre Pkwy",
//                     "types": [
//                         "route"
//                     ]
//                 },
//                 {
//                     "long_name": "Mountain View",
//                     "short_name": "Mountain View",
//                     "types": [
//                         "locality",
//                         "political"
//                     ]
//                 },
//                 {
//                     "long_name": "Santa Clara County",
//                     "short_name": "Santa Clara County",
//                     "types": [
//                         "administrative_area_level_2",
//                         "political"
//                     ]
//                 },
//                 {
//                     "long_name": "California",
//                     "short_name": "CA",
//                     "types": [
//                         "administrative_area_level_1",
//                         "political"
//                     ]
//                 },
//                 {
//                     "long_name": "United States",
//                     "short_name": "US",
//                     "types": [
//                         "country",
//                         "political"
//                     ]
//                 },
//                 {
//                     "long_name": "94043",
//                     "short_name": "94043",
//                     "types": [
//                         "postal_code"
//                     ]
//                 },
//                 {
//                     "long_name": "1351",
//                     "short_name": "1351",
//                     "types": [
//                         "postal_code_suffix"
//                     ]
//                 }
//             ],
//             "formatted_address": "1600 Amphitheatre Pkwy, Mountain View, CA 94043, USA",
//             "geometry": {
//                 "location": {
//                     "lat": 37.4222804,
//                     "lng": -122.0843428
//                 },
//                 "location_type": "ROOFTOP",
//                 "viewport": {
//                     "northeast": {
//                         "lat": 37.4237349802915,
//                         "lng": -122.083183169709
//                     },
//                     "southwest": {
//                         "lat": 37.4210370197085,
//                         "lng": -122.085881130292
//                     }
//                 }
//             },
//             "place_id": "ChIJRxcAvRO7j4AR6hm6tys8yA8",
//             "plus_code": {
//                 "compound_code": "CWC8+W7 Mountain View, CA",
//                 "global_code": "849VCWC8+W7"
//             },
//             "types": [
//                 "street_address"
//             ]
//         }
//     ],
//     "status": "OK"
// }
