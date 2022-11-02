import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:untitled1/models/post.dart';
import 'package:untitled1/pages/imagePicker.dart';
import 'package:untitled1/services/remote_service.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  List<Post>? posts;
  var isLoaded = false;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData()async {
    posts = await RemoteService().getPosts();
    if (posts != null)
    {
     setState(() {
       isLoaded= true;
     });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DATA_API',

        ),
      ),
      body: Stack(
        children: [
          Visibility(
          visible: isLoaded,
          child: Container(
            padding: const EdgeInsets.all(1),
            child: ListView.builder(
              itemCount: posts?.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Container(
                        child: ImagePickerExample(),
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.transparent,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(posts![index].name,
                              maxLines: 15,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 24,
                              fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(posts![index].email?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 15,
                              fontWeight: FontWeight.normal
                              ),
                            ),
                            Text(posts![index].address.city?? "",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 15,
                                  fontWeight: FontWeight.normal
                              ),
                            ),
                            Text(posts![index].company?.name?? "",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 15,
                              fontWeight: FontWeight.normal
                              ),
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ],
     ),
    );
  }
}

