import 'package:flutter/material.dart';
import 'package:test_webant/Resources/AppColors/app_colors.dart';
import 'package:test_webant/Ui/Scenes/single_image.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomGridView{

  GridView photoGridView(data, scrollController){
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
           child: CachedNetworkImage(
             imageUrl: ('http://gallery.dev.webant.ru/media/' + data[index].image),
             fit: BoxFit.cover,
             placeholder: (context, url) => Center(child: CircularProgressIndicator()),
             errorWidget: (context, url, error) => Icon(Icons.error),
           ),
           onTap: () => _navigateToImage(context, data[index].id),
         ),
       );
     },
     controller: scrollController,
   );
 }

  void _navigateToImage(BuildContext context, int id) {
   Navigator.of(context).push(
     MaterialPageRoute(
       builder: (context) => SingleImage(imageId: id),
     ),
   );
 }

}