import "package:cloud_firestore/cloud_firestore.dart";

class GetRecipesService {
  
 

  getallData() {
    return Firestore.instance.collection("India").snapshots();
  }

  getfavourite() {
    return Firestore.instance
        .collection("India")
        .orderBy('favouriteCount', descending: true)
        .snapshots();
  }

  getLatest() {
    return Firestore.instance
        .collection("India")
        .orderBy('timeStamp', descending: true)
        .snapshots();
  }

  getByCategory(String category) {
    return Firestore.instance
        .collection("India")
        .where("category", isEqualTo: category)
        .snapshots();
  }

  favCountincrement( int count, DocumentSnapshot snapshot){

    count++;
    snapshot.reference.updateData({"favouriteCount":count});

        

  }

  
}
