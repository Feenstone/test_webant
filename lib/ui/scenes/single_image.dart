import 'package:flutter/material.dart';
import 'package:test_webant/resources/app_colors.dart';

class SingleImage extends StatelessWidget {
  final data;

  const SingleImage({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List tags = data['tags'];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.titleColor,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              Image.network(
                data["url"],
                fit: BoxFit.fitWidth,
              ),
              SizedBox(
                height: 11,
              ),
              Row(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      data['name'],
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                    ),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      data['watchCount'] > 999 ? "999+" : data['watchCount'].toString(),
                      style: TextStyle(
                          fontSize: 12.0, color: AppColors.formFieldColor),
                    ),
                  ),
                  Icon(Icons.remove_red_eye,
                  color: AppColors.formFieldColor,
                  size: 12,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      data['author'],
                      style: TextStyle(
                          fontSize: 15.0, color: AppColors.formFieldColor),
                    ),
                  ),
                  Spacer(flex: 1,),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      data['uploadDate'],
                      style: TextStyle(
                          fontSize: 12.0, color: AppColors.formFieldColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(data['description'] ??= ' ',
                style: TextStyle(fontSize: 15),),
              ),
              SizedBox(height: 15,),
              GridView.builder(
                shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 150,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 79.86 /  24.79
                  ),
                  itemCount: tags.length,
                  itemBuilder: (context, index){
                    return Container(
                      height: 25,
                      child: Center(child: Text(tags[index].toString(),
                      style: TextStyle(fontSize: 18, color: Colors.white),)),
                      decoration: BoxDecoration(
                        color: AppColors.appBarButtonColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    );
              }),
            ],
          )),
    );
  }
}
