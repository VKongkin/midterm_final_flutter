import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_flutter_app/post/modules/post/view_model/post_view_model.dart';
import 'package:product_flutter_app/routes/app_routes.dart';

class PostViewWidget extends StatelessWidget {
  final String profileImageUrl;
  final String userName;
  final String timestamp;
  final String postText;
  final String postImageUrl;
  final int likeCount;
  final int commentCount;
  final int shareCount;
  final int postId;
  final String postTitle;
  final String firstName;
  final String lastName;
  VoidCallback? onTapEdit;

  PostViewWidget({
    required this.profileImageUrl,
    required this.userName,
    required this.timestamp,
    required this.postText,
    required this.postImageUrl,
    required this.likeCount,
    required this.commentCount,
    required this.shareCount,
    required this.postId,
    required this.postTitle,
    this.onTapEdit,
    required this.firstName,
    required this.lastName,
  });

  @override
  Widget build(BuildContext context) {
    var viewModel = Get.put(PostViewModel());
    return Card(
      color: Colors.white,
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
                      "$firstName $lastName",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      timestamp,
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
                Spacer(),
                PopupMenuButton<String>(
                  icon: Icon(Icons.more_horiz),
                  onSelected: (String value) {
                    // Handle the selected menu action here
                    if (value == 'Edit') {
                      // onTapEdit;
                      viewModel.onUpdate(postId.toString());
                      // Tver update post ot ton der te

                      // Implement edit post functionality
                      print("EDIT CLICKED ${postId}");
                      // Get.toNamed(RouteName.postAppFormCreatePath);
                    } else if (value == 'Delete') {
                      print("DELETE CLICKED ${postId}");
                      viewModel.onDeletePost(postId);
                      // Implement delete post functionality
                    }
                    // Add more cases for other actions
                  },
                  itemBuilder: (BuildContext context) => [
                    PopupMenuItem(
                      value: 'Edit',
                      child: ListTile(
                        leading: Icon(Icons.edit),
                        title: Text('Edit post'),
                      ),
                    ),
                    PopupMenuItem(
                      value: 'Delete',
                      child: ListTile(
                        leading: Icon(Icons.delete),
                        title: Text('Delete post'),
                      ),
                    ),
                    PopupMenuItem(
                      value: 'Save',
                      child: ListTile(
                        leading: Icon(Icons.bookmark),
                        title: Text('Save post'),
                      ),
                    ),
                    PopupMenuItem(
                      value: 'Privacy',
                      child: ListTile(
                        leading: Icon(Icons.lock),
                        title: Text('Edit privacy'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 2),

          // Post Text
          if (postTitle.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Text(
                postTitle,
                style: TextStyle(fontSize: 14),
              ),
            ),
            SizedBox(height: 10),
          ],

          // Post Text
          if (postText.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Text(
                postText,
                style: TextStyle(fontSize: 14,color: Colors.grey[600]),
              ),
            ),
            SizedBox(height: 10),
          ],

          // Post Image
          if (postImageUrl != null && postImageUrl.isNotEmpty)
            ClipRRect(
              child: CachedNetworkImage(
                imageUrl: postImageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => SizedBox.shrink(),
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
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(1),
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
                  onTap: () {
                    // Handle like action
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
