import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TodayHistoryItem extends StatelessWidget {
  final String? imagePath;
  final String? itemName; // New parameter for extra text
  final int? count; // New parameter for count

  const TodayHistoryItem({
    this.imagePath,
    this.itemName, // Initialize extraText parameter
    this.count, // Initialize count parameter
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        elevation: 4, // Add elevation to the card
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          width: 170,
          child: Stack(
            fit: StackFit.expand,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  imagePath!,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black54
                      .withOpacity(0.65), // Add black overlay color
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Add some space between texts
                  Text(
                    '$count', // Display the count specific to this item
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'SF Pro',
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    itemName!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontFamily: 'SF Pro',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TodayHistory extends StatelessWidget {
  const TodayHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: getUserId(), // Call function to get user ID
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        String userId = snapshot.data!.id; // Fetch user ID
        return _buildHistoryWidget(userId);
      },
    );
  }

  Future<DocumentSnapshot> getUserId() async {
    // Check if the user is logged in
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // User is logged in, get the user ID from Firebase Authentication
      String userId = user.uid;

      // Retrieve the user document from Firestore
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      // Return the user document snapshot
      return userSnapshot;
    } else {
      // User is not logged in, return a default user ID or handle it accordingly
      // For demonstration purposes, returning a dummy document snapshot
      return FirebaseFirestore.instance
          .collection('users')
          .doc('defaultUserId')
          .get();
    }
  }

  Widget _buildHistoryWidget(String userId) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('detectedspecies')
          .doc(userId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        int detectedSpeciesCount = (snapshot.data!.data() as Map<String, dynamic>?)?.containsKey('countIs') ?? false
            ? snapshot.data!.get('countIs')
            : 0;
        int rareSpeciesCount = (snapshot.data!.data() as Map<String, dynamic>?)?.containsKey('rareCount') ?? false
            ? snapshot.data!.get('rareCount')
            : 0;
        int postSpeciesCount = (snapshot.data!.data() as Map<String, dynamic>?)?.containsKey('postCount') ?? false
            ? snapshot.data!.get('postCount')
            : 0;
        int articleViewCount = (snapshot.data!.data() as Map<String, dynamic>?)?.containsKey('articleCount') ?? false
            ? snapshot.data!.get('articleCount')
            : 0;

        return Container(
          height: 130, // Set the height of each card
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              TodayHistoryItem(
                imagePath: 'assets/images/image_0.jpg',
                itemName: 'Detected Species',
                count:
                    detectedSpeciesCount, // Pass the dynamic count for Detected Species
              ),
              TodayHistoryItem(
                imagePath: 'assets/images/image_1.jpg',
                itemName: 'Rare Species',
                count: rareSpeciesCount, // Static count for other items
              ),
              TodayHistoryItem(
                imagePath: 'assets/images/image_2.jpg',
                itemName: 'Community',
                count: postSpeciesCount, // Static count for other items
              ),
              TodayHistoryItem(
                imagePath: 'assets/images/image_3.jpg',
                itemName: 'Articles',
                count: articleViewCount, // Static count for other items
              ),
            ],
          ),
        );
      },
    );
  }
}
