// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  int? id;
  String? name;
  String? contact;
  String? description;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'contact': contact,
      'description': description,
    };
  }
}
