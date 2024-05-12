import 'package:flutter/material.dart';
import 'package:vdoc/screens/chat_page.dart';
import 'package:vdoc/services/auth_service.dart';
import 'package:vdoc/services/chat_service.dart';
import 'package:vdoc/widgets/drawer_widget.dart';

import '../widgets/user_tile.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // chat & auth service
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      drawer: const DrawerWidget(),
      body: _buildUserList(),
    );
  }


  // Build a List of Users Except for the current logged in User
  Widget _buildUserList(){
    return StreamBuilder(
        stream: _chatService.getUsersStream(),
        builder: (context, snapshot) {
          // error
          if (snapshot.hasError) {
            return const Text("Error");
          }

          // Loading...
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading...");
          }

          // Return List view
          return ListView(
            children: snapshot.data!
                .map<Widget>((userData) => _buildUserListItem(userData, context)).toList(),
          );
        },
        );
  }


  // Build individual list tile for user
  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    // display all users except current user
    if (userData["email"] != _authService.getCurrentUser()!.email){
      return UserTile(
        text: userData["email"],
        onTap: (){
          // tapped on a user -> go to chat page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverEmail: userData["email"],
                receiverID: userData["uid"],
              ),
            ),
          );
        },
      );
    } else {
      return Container ();
    }
  }
}
