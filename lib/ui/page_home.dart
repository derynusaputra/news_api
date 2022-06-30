import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapi/models/api_user.dart';
import 'package:newsapi/models/repository.dart';
import 'package:newsapi/ui/page_detail.dart';
import 'package:intl/intl.dart';

// import 'dar';
class PageHome extends StatefulWidget {
  const PageHome({Key? key}) : super(key: key);

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  final Repository repository = Repository();
  ApiUser? apiUser;
  List<Article> articles = [];

  Future<dynamic> getData() async {
    apiUser = await repository.getData();
    return apiUser;
  }

  addData() async {}
  // star

  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            getData();
          },
          child: Icon(Icons.replay_outlined),
        ),
        appBar: AppBar(
          title: Text('NEWSAPI BY DERY'),
          centerTitle: true,
        ),
        body: FutureBuilder<dynamic>(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var data = apiUser!.articles!.length;
              final List<Widget> myChat = List.generate(data, (index) {
                DateTime currentTime = apiUser!.articles![index].publishedAt!;
                String formattedDate =
                    DateFormat('yyyy-MM-dd – kk:mm').format(currentTime);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(width: 1),
                    ),
                    onTap: () {
                      Get.to(PageDetail(), arguments: [
                        apiUser!.articles![index].url,
                        apiUser!.articles![index].source!.name,
                        apiUser!.articles![index].description,
                      ]);
                      // Get.toNamed(Routes.CHAT_ROOM);
                    },
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage(
                          "${apiUser!.articles![index].urlToImage != null ? apiUser!.articles![index].urlToImage : "http://bppl.kkp.go.id/uploads/publikasi/karya_tulis_ilmiah/default.jpg"}"),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${formattedDate}",
                          style: TextStyle(fontSize: 11),
                        ),
                        Text("${apiUser!.articles![index].source!.name}"),
                      ],
                    ),
                    subtitle:
                        Text("Status ${apiUser!.articles![index].description}"),
                    trailing: Chip(label: Text('${index + 1}')),
                  ),
                );
              }).toList();
              // for (int i = 0; i < data; i++) {}
              return ListView.builder(
                  itemCount: data,
                  itemBuilder: (context, index) => myChat[index]);
            }
            return Center(child: CircularProgressIndicator());
          },
        ));
  }
}
