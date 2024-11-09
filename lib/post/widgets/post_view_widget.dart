import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PostViewWidget extends StatelessWidget {
  final String profileImageUrl;
  final String userName;
  final String timestamp;
  final String postText;
  final String postImageUrl;
  final int likeCount;
  final int commentCount;
  final int shareCount;

  PostViewWidget({
    required this.profileImageUrl,
    required this.userName,
    required this.timestamp,
    required this.postText,
    required this.postImageUrl,
    required this.likeCount,
    required this.commentCount,
    required this.shareCount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      // margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(profileImageUrl),
                  radius: 20,
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      timestamp,
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
                Spacer(),
                Icon(Icons.more_horiz),
              ],
            ),
          ),
          SizedBox(height: 2),

          // Post Text
          if (postText.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Text(
                postText,
                style: TextStyle(fontSize: 14),
              ),
            ),
            SizedBox(height: 10),
          ],

          // Post Image
          if (postImageUrl != null && postImageUrl.isNotEmpty)
            ClipRRect(
              // Uncomment this line if you need rounded corners
              // borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: postImageUrl,
                width: double.infinity, // Set the image to take full width
                fit: BoxFit
                    .cover, // Ensure the image covers the full width and height
                // placeholder: (context, url) => CircularProgressIndicator(
                //   strokeWidth: 2.0,
                //   valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                // ),
                errorWidget: (context, url, error) =>
                    SizedBox.shrink(), // Show nothing on error
              ),
            ),

          SizedBox(height: 10),

          // Reaction Section
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (likeCount != null && likeCount > 0)
                  Row(
                    children: [
                      Container(
                        width: 20, // Adjust size as needed
                        height: 20, // Adjust size as needed
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(1), // Background color
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.thumb_up_alt,
                          color: Colors.white,
                          size: 13,
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        "$likeCount",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ],
                  ),
                Row(
                  children: [
                    Text("$commentCount Comments",
                        style: TextStyle(color: Colors.grey[700])),
                    SizedBox(width: 10),
                    Text("$shareCount Shares",
                        style: TextStyle(color: Colors.grey[700])),
                  ],
                ),
              ],
            ),
          ),

          // Divider(),

          // Like, Comment, Share Buttons
          Padding(
            padding:
                const EdgeInsets.only(top: 16, bottom: 8, left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: _PostButton(
                    icon: Icons.thumb_up_alt_outlined,
                    label: 'Like',
                  ),
                  onTap: (){
                    likeCount ;
                  },
                ),
                _PostButton(icon: Icons.comment_outlined, label: 'Comment'),
                _PostButton(icon: Icons.share_outlined, label: 'Share'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PostButton extends StatelessWidget {
  final IconData icon;
  final String label;

  _PostButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[700], size: 20),
          SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }
}
