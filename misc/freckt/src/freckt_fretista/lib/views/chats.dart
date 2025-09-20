import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:freckt_fretista/models/fretista.model.dart';
import 'package:freckt_fretista/utils/consts.dart';
import 'package:freckt_fretista/utils/templates/avatar_template.dart';
import 'package:freckt_fretista/views/chat.dart';
import 'package:freckt_fretista/views/loading.dart';
import 'package:freckt_fretista/views/something_went_wrong.dart';

class Chats extends StatefulWidget {
  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  final ScrollController listScrollController = ScrollController();
  final model = FretistaModel();

  Widget itemChat(Map<String, dynamic> data) {
    return Container(
      child: FlatButton(
        child: Row(
          children: <Widget>[
            AvatarTemplate(url: data['clientePhotoUrl']),
            Flexible(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        data['clienteName'],
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
                clienteId: data['clienteId'],
                clienteName: data['clienteName'],
                clientePhotoUrl: data['clientePhotoUrl'],
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
          .where('fretistaId', isEqualTo: model.getUserId)
          .orderBy('timestamp', descending: true)
          .snapshots(),

      //FirebaseFirestore.instance
      //    .collection('messages')
      //    .doc(groupChatId)
      //    .collection(groupChatId)
      //    .orderBy('timestamp', descending: true)
      //    .limit(_limit)
      //    .snapshots(),
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

          //ListView(
          //    padding: EdgeInsets.all(5.0),
          //    children: snapshot.data.docs.map((doc) {
          //      final data = doc.data();
          //
          //      return itemChat(data);
          //    }).toList(),
          //  )
          //: Center(
          //    child: Text('Aguardando mensagens...'),
          //  );
        }
      },
      //if (!snapshot.hasData) {
      //  return Loading();
      //} else {
      //listMessage.addAll(snapshot.data.documents);
      //return ListView.builder(
      //  padding: EdgeInsets.all(10.0),
      //  itemBuilder: (context, index) =>
      //      buildItem(index, snapshot.data.documents[index]),
      //  itemCount: snapshot.data.documents.length,
      //  reverse: true,
      //  controller: listScrollController,
      //);
    );

    /*return FutureBuilder(
      future: fretistas.where('fretistaId', isEqualTo: model.getUserId).get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return SomethingWentWrong(snapshot.error.toString());
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return snapshot.hasData
              ? ListView(
                  padding: EdgeInsets.all(5.0),
                  children: snapshot.data.docs.map((doc) {
                    final data = doc.data();

                    return itemChat(data);
                  }).toList(),
                )
              : Center(
                  child: Text('Aguardando mensagens...'),
                );
        }
        return Loading();
      },
    );*/
  }

  @override
  Widget build(BuildContext context) => loadChats();
  //{
  //return Container(
  //  child: loadChats(),
  //);

  /*Scaffold(
      appBar: AppBar(
        backgroundColor: Consts.frecktThemeColor,
        leading: IconButton(
          color: Colors.white,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Mensagens'),
      ),
      body: Container(
        child: loadChats(),
      ),
    );*/
  //}
}
