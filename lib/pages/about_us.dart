import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(
                    child: Text(
                      'About Us',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontFamily: 'SF Pro',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),

              Text(
                'Our Mission',
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'SF Pro',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'At Wildlife Conservation AI, our mission is to leverage cutting-edge artificial intelligence technology to protect and preserve endangered species and their habitats.',
                style: TextStyle(fontSize: 16.0,fontFamily: 'SF Pro',),
              ),
              SizedBox(height: 20.0),
              Text(
                'How We Use AI',
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'SF Pro',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                '1. Species Identification: We utilize AI-powered image recognition algorithms to identify species from camera trap images, helping us monitor wildlife populations efficiently.',
                style: TextStyle(fontSize: 16.0,fontFamily: 'SF Pro',),
              ),
              Text(
                '2. Habitat Monitoring: AI algorithms analyze satellite imagery to track changes in habitat and detect potential threats such as deforestation and habitat loss.',
                style: TextStyle(fontSize: 16.0,fontFamily: 'SF Pro',),
              ),
              Text(
                '3. Wildlife Protection: Our AI systems help us predict and prevent poaching activities by analyzing patterns and identifying high-risk areas.',
                style: TextStyle(fontSize: 16.0,fontFamily: 'SF Pro',),
              ),
              SizedBox(height: 20.0),
              Text(
                'Our Team',
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'SF Pro',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              // Cards for team members
              TeamMemberCard(
                name: 'Suyash Kusumkar',
                imageUrl: 'assets/images/suyash_kusumkar.jpg',
              ),
              TeamMemberCard(
                name: 'Mansi Kodgire',
                imageUrl: 'assets/images/mansi_kodgire.jpg',
              ),
              TeamMemberCard(
                name: 'Mahesh Babar',
                imageUrl: 'assets/images/mahesh_babar.jpg',
              ),
              TeamMemberCard(
                name: 'Sejal Zarekar',
                imageUrl: 'assets/images/sejal_zarekar.jpg',
              ),
              SizedBox(height: 20.0),
              Text(
                'Contact Us',
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'SF Pro',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Have questions or want to get involved? Reach out to us at contact@wildlifeconservationai.org',
                style: TextStyle(fontSize: 16.0,fontFamily: 'SF Pro',),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TeamMemberCard extends StatelessWidget {
  final String name;
  final String imageUrl;

  const TeamMemberCard({
    required this.name,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(imageUrl),
        ),
        title: Text(name, style: TextStyle(fontFamily: 'SF Pro', fontWeight: FontWeight.w600),),
      ),
    );
  }
}
