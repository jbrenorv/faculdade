import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:freckt_cliente/models/cliente.model.dart';
import 'package:freckt_cliente/utils/consts.dart';
import 'package:freckt_cliente/utils/templates/avatar_template.dart';
import 'package:freckt_cliente/views/chat.dart';
import 'package:freckt_cliente/views/loading.dart';
import 'package:freckt_cliente/views/something_went_wrong.dart';

class Chats extends StatefulWidget {
  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  final ScrollController listScrollController = ScrollController();
  final model = ClienteModel();

  Widget itemChat(Map<String, dynamic> data) {
    return Container(
      child: FlatButton(
        child: Row(
          children: <Widget>[
            AvatarTemplate(url: data['fretistaPhotoUrl']),
            Flexible(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        data['fretistaName'],
                      ),
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                    ),
                    //Container(
                    //  child: Text(
                    //    data['vehicles'][0]['marca'],
                    //    style: TextStyle(color: primaryColor),
                    //  ),
                    //  alignment: Alignment.centerLeft,
                    //  margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                    //)
                  ],
                ),
                margin: EdgeInsets.only(left: 20.0),
              ),
            ),
          ],
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Chat(
                fretistaId: data['fretistaId'],
                fretistaName: data['fretistaName'],
                fretistaPhotoUrl: data['fretistaPhotoUrl'],
              ),
            ),
          );
        },
        color: Consts.greyColor2,
        padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
      margin: EdgeInsets.all(5.0),
    );
  }

  Widget loadChats() {
    final fretistas = FirebaseFirestore.instance.collection('messages');

    return StreamBuilder(
      stream: fretistas
          .where('clienteId', isEqualTo: model.getUserId)
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return SomethingWentWrong(snapshot.error.toString());
        }

        if (!snapshot.hasData) {
          return Loading();
        } else {
          if (snapshot.data.docs.isEmpty)
            return Center(child: Text('Você não possui conversas'));
          else
            return ListView.builder(
              padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 50.0),
              itemBuilder: (context, index) =>
                  itemChat(snapshot.data.docs[index].data()),
              itemCount: snapshot.data.docs.length,
              controller: listScrollController,
            );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) => loadChats();
}
