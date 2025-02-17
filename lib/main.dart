import 'package:expanse_management/presentation/widgets/bottom_navbar.dart';
import 'package:expanse_management/domain/models/category_model.dart';
import 'package:expanse_management/domain/models/transaction_model.dart' ;
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firestoreBase;
import 'package:flutter/material.dart';

// Future<void> clearData() async {
//   final appDocumentDirectory =
//       await path_provider.getApplicationDocumentsDirectory();
//   Hive.init(appDocumentDirectory.path);
//   await Hive.deleteFromDisk();
// }

const FirebaseOptions firebaseConfig=FirebaseOptions(
                                                      apiKey: "AIzaSyDtaQPvP2Q_cX1QfelBo5MY6qjmrfFPJUw",
                                                      authDomain: "flutterfinancemanager.firebaseapp.com",
                                                      projectId: "flutterfinancemanager",
                                                      storageBucket: "flutterfinancemanager.firebasestorage.app",
                                                      messagingSenderId: "292027849955",
                                                      appId: "1:292027849955:web:d3f707bcd72878aaa639d6"
                                                    );
void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await clearData();
  await Hive.initFlutter();
  Hive.registerAdapter(TransactionAdapter());
  Hive.registerAdapter(CategoryModelAdapter());
  await Hive.openBox<Transaction>('transactions');
  await Hive.openBox<CategoryModel>('categories');
  print("initializing firebase");
  await Firebase.initializeApp(options: firebaseConfig);
  print("firebase initialized");
  await uploadTestData();
  runApp(const MyApp());

}

Future<void> uploadTestData() async {
  // Get an instance of Firestore
  firestoreBase.FirebaseFirestore firestore = firestoreBase.FirebaseFirestore.instance;

  try {
    // Uploading a document with some test data
    await firestore.collection('testData').add({
      'message': 'This is a test message from main function!',
      'createdAt': firestoreBase.FieldValue.serverTimestamp(),
      'isTest': true,
    });

    print("Test data uploaded successfully!");
  } catch (e) {
    print("Error uploading test data: $e");
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Bottom(),
    );
  }
}
