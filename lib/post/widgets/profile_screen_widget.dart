import 'package:flutter/material.dart';
import 'package:product_flutter_app/cors/constants/constants.dart';
import 'package:product_flutter_app/data/remote/api_url.dart';

class ProfileScreenWidget extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String? imagePath;

  ProfileScreenWidget({
    required this.firstName,
    required this.lastName,
    this.imagePath,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip
              .none, // Allows the profile image to overflow outside the cover container
          children: [
            Container(
              height: 200,
              color: Colors.grey[850], // Placeholder color for cover photo
              child: Center(
                child: TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.camera_alt, color: Colors.white),
                  label: Text(
                    "Add cover photo",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 140, // Adjust this value for better positioning
              left: MediaQuery.of(context).size.width / 2 -
                  50, // Centers the profile image horizontally
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors
                    .white, // Adding a background color if you want a border around the profile image
                child: CircleAvatar(
                  radius:
                      48, // Slightly smaller radius to create a border effect
                  backgroundImage: imagePath != null ? NetworkImage("${ApiUrl.postGetImagePath}${imagePath}") : AssetImage(
                      Constants.iconNoImage), // Placeholder for profile image
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 60),
        Text(
          "${firstName} ${lastName}",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          "1.2K friends",
          style: TextStyle(color: Colors.grey[400]),
        ),
        SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.add, color: Colors.white),
                label: Text(
                  "Add to story",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                ),
              ),
              // SizedBox(width: 8),
              // ElevatedButton.icon(
              //   onPressed: () {},
              //   icon: Icon(Icons.edit, color: Colors.white),
              //   label: Text("Edit profile"),
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.blue,
              //     padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              //   ),
              // ),
              OutlinedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.edit, color: Colors.white),
                label: Text(
                  "Edit profile",
                  style: TextStyle(color: Colors.white),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.blue),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                ),
              ),
              // SizedBox(width: 8),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.blue),
                  padding:
                      EdgeInsets.all(8), // Adjust padding for a square button
                  shape: CircleBorder(), // Makes the button circular
                ),
                child: Icon(Icons.more_horiz, color: Colors.white),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildTabButton("Posts"),
              buildTabButton("Photos"),
              buildTabButton("Videos"),
            ],
          ),
        ),
        Divider(color: Colors.grey[800]),
        buildDetailItem(Icons.link, "http://linkedin.com/in/kongkin"),
        buildDetailItem(Icons.home, "Lives in Phnom Penh"),
        buildDetailItem(Icons.location_on, "From Siem Reap"),
        buildDetailItem(Icons.favorite, "Married with Smeī"),
        buildDetailItem(Icons.rss_feed, "Followed by 686 people"),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: OutlinedButton(
            onPressed: () {},
            child: Text(
              "Edit public details",
              style: TextStyle(color: Colors.blue),
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.blue),
              padding: EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget buildTabButton(String title) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
              color: Colors.blue, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Container(
          height: 2,
          width: 40,
          color: Colors.blue,
          margin: EdgeInsets.only(top: 6),
        ),
      ],
    );
  }

  Widget buildDetailItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[400], size: 20),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
