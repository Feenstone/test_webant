import 'package:flutter/material.dart';
import 'package:test_webant/data/SingleImage.dart';

class CommonUI{

 static ScrollController _scrollController = new ScrollController();

 static Column noInternetConnection(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Container(
              height: 150,
              width: 150,
              child: Image(image: AssetImage('assets/no_internet.png'), fit: BoxFit.fill,)
          ),
        ),
        SizedBox(height: 8),
        Align(
          alignment: Alignment.center,
          child: Text('Oh shucks!',
            style: TextStyle(
                fontSize: 20.0,
                color: Color(0xFF2F1767)
            ),
          ),
        ),
        SizedBox(height: 8),
        Align(
          alignment: Alignment.center,
          child: Text(('Slow or no internet connection.'+'\n'+'Please check your internet settings'),
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 12,
                color: Color(0xFF4A4A4A)
            ),
          ),
        )
      ],
    );
  }

 static GridView photoGridView(data){
   return GridView.builder(
     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
       crossAxisCount: 2,
       childAspectRatio: 180/128,
       mainAxisSpacing: 4.0,
       crossAxisSpacing: 4.0,
     ),
     itemCount: data.length,
     itemBuilder: (context, index){
       return Card(
         semanticContainer: true,
         elevation: 5.7,
         clipBehavior: Clip.antiAliasWithSaveLayer,
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(8),
         ),
         margin: EdgeInsets.all(8.0),
         child:GestureDetector(
           child: Image.network(('http://gallery.dev.webant.ru/media/' + data[index].image),fit: BoxFit.cover,),
           onTap: () => _navigateToImage(context, data[index].id),
         ),
       );
     },
     controller: _scrollController,
   );
 }

 static void _navigateToImage(BuildContext context, int id) {
   Navigator.of(context).push(
     MaterialPageRoute(
       builder: (context) => SingleImage(imageId: id),
     ),
   );
 }

}