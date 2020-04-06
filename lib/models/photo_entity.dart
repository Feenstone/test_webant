class Photo{
  var data;
  int id;
  String name;
  String description;
  bool newest;
  bool popular;
  String imageName;
  var image;

  Photo({this.id, this.name, this.description, this.newest, this.popular, this.imageName,this.data,this.image});

  factory Photo.fromJson(Map<String, dynamic> json){
    return Photo(
      data: json['data'],
      id: json['id'],
      name: json['name'],
      description: json['description'],
      newest: json['new'],
      popular: json['popular'],
      image: json['image']['name'],
    );
  }
}