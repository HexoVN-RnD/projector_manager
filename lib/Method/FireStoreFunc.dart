import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:responsive_dashboard/main.dart';

void fetchData() async {
  QuerySnapshot querySnapshot = await firestore.collection('users').get();
  List<DocumentSnapshot> documents = querySnapshot.docs;
  // Xử lý dữ liệu tại đây
}


void addData() async {
  DocumentReference documentRef = firestore.collection('users').doc('newUser');
  await documentRef.set({'name': 'John Doe', 'age': 25});
  // Ghi dữ liệu thành công
}