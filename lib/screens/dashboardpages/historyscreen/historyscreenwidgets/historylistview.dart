import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';

class CustomListViewItem extends StatelessWidget {
  const CustomListViewItem({
    required Key key,
    required this.title,
    required this.detectedSpeciesLabel,
  }) : super(key: key);

  final String title;
  final String detectedSpeciesLabel;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: 80,
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title.capitalizeFirst ?? 'Unknown', // Capitalize the title
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    Text(
                      'User ID: $detectedSpeciesLabel',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListViewBuilderHistory extends StatelessWidget {
  const ListViewBuilderHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUserID = FirebaseAuth.instance.currentUser?.uid;

    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection('detectedspecies').get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show Lottie animation while data is being fetched
          return Center(
            child: Lottie.asset('assets/loading_animation.json', width: 150, height: 150),
          );
        }
        if (snapshot.hasError) {
          print("Error fetching user documents: ${snapshot.error}");
          return Text('Error fetching data. Please try again later.');
        }

        final userDocuments = snapshot.data!.docs;
        final currentUserDocuments = userDocuments.where((doc) => doc.id == currentUserID).toList();

        if (currentUserDocuments.isEmpty) {
          // Show Lottie animation when no data is found for the current user
          return Column(
            children: [
              Lottie.asset('assets/datanotfound.json', width: 150, height: 150),
              Text('Oh no! No data found for the current user.', style: TextStyle(color: Colors.grey), ),
            ],
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: currentUserDocuments.length,
          itemBuilder: (context, userIndex) {
            final userDoc = currentUserDocuments[userIndex];
            final speciesCollection = userDoc.reference.collection('species');
            return FutureBuilder<QuerySnapshot>(
              future: speciesCollection.get(),
              builder: (context, speciesSnapshot) {
                if (speciesSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (speciesSnapshot.hasError) {
                  print("Error fetching species documents: ${speciesSnapshot.error}");
                  return Text('Error fetching data. Please try again later.');
                }
                final speciesDocuments = speciesSnapshot.data!.docs;

                if (speciesDocuments.isEmpty) {
                  return Text('Oh no! No data found for the current user.');
                }

                // Build a list of CustomListViewItem widgets for each species detection
                final detections = speciesDocuments.map((speciesDoc) {
                  final label = speciesDoc['label'] as String?;
                  final timeStamp = speciesDoc['timestamp'] as Timestamp?;
                  // Access the 'label' field from the document data
                  return CustomListViewItem(
                    title: label ?? 'Unknown', // Use label as the title
                    detectedSpeciesLabel: userDoc.id, // Use userId as detectedSpeciesLabel
                    key: Key('${userDoc.id}_item_${speciesDoc.id}'),
                  );
                }).toList();

                // Add a ListTile to display the user ID as a header
                detections.insert(
                  0,
                  CustomListViewItem(
                    title: 'User ID: ${userDoc.id}',
                    detectedSpeciesLabel: '', // Provide an empty label or remove this parameter from CustomListViewItem constructor if not needed
                    key: Key('${userDoc.id}_list_tile'),
                  ),
                );

                return Column(
                  children: detections,
                );
              },
            );
          },
        );
      },
    );
  }
}
