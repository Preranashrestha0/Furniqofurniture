// ignore_for_file: camel_case_types

class Newsapi {
  String? status;
  int? totalResults;
  List<Articles>? articles;

  Newsapi({this.status, this.totalResults, this.articles});

  Newsapi.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalResults = json['totalResults'];
    if (json['articles'] != null) {
      articles = <Articles>[];
      json['articles'].forEach((v) {
        articles!.add(Articles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['totalResults'] = this.totalResults;
    if (this.articles != null) {
      data['articles'] = this.articles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Articles {
  Source? source;
  String? description;
  String? url;
  String? urlToImage = 'https://firebasestorage.googleapis.com/v0/b/furniqo.appspot.com/o/images%2F1703400537976.jpg?alt=media&token=ab5d71bb-0300-4a25-9858-b26b5563f123';

  Articles(
      {this.source,
        this.description,
        this.url});

  Articles.fromJson(Map<String, dynamic> json) {
    source =
    json['source'] != null ? Source.fromJson(json['source']) : null;
    description = json['description'];
    url = json['url'];
    urlToImage = json['urlToImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.source != null) {
      data['source'] = this.source!.toJson();
    }
    data['description'] = this.description;
    data['url'] = this.url;
    data['urlToImage'] = this.urlToImage;
    return data;
  }
}

class Source {
  String? id;
  String? name;

  Source({this.id, this.name});

  Source.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}