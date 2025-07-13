import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // Mesaj gönderme
  static Future<void> sendMessage(String message) async {
    final user = _auth.currentUser;
    if (user == null) return;

    await _firestore.collection('messages').add({
      'message': message,
      'senderId': user.uid,
      'senderEmail': user.email,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  // Mesajları dinleme
  static Stream<QuerySnapshot> getMessages() {
    return _firestore
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  // Etkinlik ekleme
  static Future<void> addEvent(String title, String description, DateTime date) async {
    final user = _auth.currentUser;
    if (user == null) return;

    await _firestore.collection('events').add({
      'title': title,
      'description': description,
      'date': Timestamp.fromDate(date),
      'userId': user.uid,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // Etkinlikleri getirme
  static Stream<QuerySnapshot> getEvents() {
    final user = _auth.currentUser;
    if (user == null) return const Stream.empty();

    return _firestore
        .collection('events')
        .where('userId', isEqualTo: user.uid)
        .orderBy('date')
        .snapshots();
  }

  // Anı ekleme
  static Future<void> addMemory(String title, String description, String imageUrl) async {
    final user = _auth.currentUser;
    if (user == null) return;

    await _firestore.collection('memories').add({
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'userId': user.uid,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // Anıları getirme
  static Stream<QuerySnapshot> getMemories() {
    return _firestore
        .collection('memories')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  // Kullanıcı profili güncelleme
  static Future<void> updateUserProfile(Map<String, dynamic> data) async {
    final user = _auth.currentUser;
    if (user == null) return;

    await _firestore.collection('users').doc(user.uid).set(data, SetOptions(merge: true));
  }

  // Kullanıcı profilini getirme
  static Future<DocumentSnapshot> getUserProfile() async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('Kullanıcı oturum açmamış');

    return await _firestore.collection('users').doc(user.uid).get();
  }
}