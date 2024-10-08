import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/tabs/bottomPages/mainzillapage.dart';
import 'package:travel_app/tabs/bottomPages/placeshow.dart';

class DivisionPage extends StatefulWidget {
  //const DivisionPage({Key? key}) : super(key: key);
  var _divisons;
  DivisionPage(this._divisons);
  //print(this._divisons);

  @override
  _DivisionPageState createState() => _DivisionPageState();
}

class _DivisionPageState extends State<DivisionPage> {
  List _divisions = [];
  List<String> currentdivison = [];
  List<String> Dhaka = [
    "কিশোরগঞ্জ",
    "গাজীপুর",
    "টাঙ্গাইল",
    "ফরিদপুর",
    "নারায়ণগঞ্জ",
    "নরসিংদী",
    "মুন্সীগঞ্জ",
    "ঢাকা"
  ];
  List<String> Chittagong = [
    "কক্সবাজার",
    "ফেনী",
    "চাঁদপুর",
    "ব্রাহ্মণবাড়িয়া",
    "বান্দরবান",
    "রাঙ্গামাটি",
    "খাগড়াছড়ি",
    "চট্টগ্রাম"
  ];
  List<String> Rajshahi = [
    "বগুড়া",
    "চাপাইনবাবগঞ্জ",
    "জয়পুরহাট",
    "নওগাঁ",
    "নাটোর",
    "রাজশাহী",
    "পাবনা",
    "সিরাজগঞ্জ"
  ];
  List<String> Khulna = [
    "কুষ্টিয়া",
    "চুয়াডাঙ্গা",
    "যশোর",
    "সাতক্ষীরা",
    "বাগেরহাট",
    "মাগুরা",
    "খুলনা"
  ];
  List<String> Barisal = [
    "বরগুনা",
    "ভোলা",
    "ঝালকাঠি",
    "পাটুয়াখালি",
    "পিরোজপুর",
    "বরিশাল"
  ];
  List<String> Mymensingh = [
    "নেত্রকোনা",
    "জামালপুর",
    "শেরপুর",
    "ময়মনসিংহ",
  ];
  List<String> Rangpur = [
    "দিনাজপুর",
    "গাইবান্ধা",
    "কুড়িগ্রাম",
    "লালমনিরহাট",
    "পঞ্চগড়",
    "ঠাকুরগাঁও",
    "রংপুর"
  ];
  List<String> Sylhet = ["হবিগঞ্জ", "মৌলভীবাজার", "সুনামগঞ্জ", "সিলেট"];

  fetchDivision1() async {
    var _firestoreInstance = FirebaseFirestore.instance;

    for (int i = 0; i < currentdivison.length; i++) {
      QuerySnapshot qn =
          await _firestoreInstance.collection(currentdivison[i]).get();
      setState(() {
        for (int i = 0; i < qn.docs.length; i++) {
          List<String> descriptionComment = [];
          List<int> rating = [];
          List<String> emails = [];
          double avg = 0;
          for (int j = 0; j < qn.docs[i]["comment"]?.length; j++) {
            // print(qn.docs[i]["comment"].length);
            String temp = qn.docs[i]["comment"][j]["description"];
            descriptionComment.add(temp);
          }
          for (int j = 0; j < qn.docs[i]["comment"]?.length; j++) {
            // print(qn.docs[i]["comment"].length);
            int temp = qn.docs[i]["comment"][j]["rating"];
            avg += temp;
            rating.add(temp);
          }
          avg /= qn.docs[i]["comment"].length;
          print(avg);

          for (int j = 0; j < qn.docs[i]["comment"]?.length; j++) {
            // print(qn.docs[i]["comment"].length);
            String temp = qn.docs[i]["comment"][j]["email"];
            emails.add(temp);
          }
          _divisions.add({
            "description": qn.docs[i]["description"],
            "divison": qn.docs[i]["divison"],
            "img": qn.docs[i]["img"],
            "placeName": qn.docs[i]["placeName"],
            "roadmap": qn.docs[i]["roadmap"],
            "zilla": qn.docs[i]["zilla"],
            "descriptionComment": descriptionComment,
            "rating": rating,
            "emails": emails,
            "avg": avg
          });
        }
      });
    }

    // return qn.docs;
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    checkdivision(widget._divisons);
    fetchDivision1();
    // fetchProducts();
    super.initState();
  }

  void checkdivision(_divisons) {
    if (_divisons == "ঢাকা") {
      currentdivison = Dhaka;
    }
    if (_divisons == "চট্টগ্রাম") {
      currentdivison = Chittagong;
    }
    if (_divisons == "রাজশাহী") {
      currentdivison = Rajshahi;
    }
    if (_divisons == "খুলনা") {
      currentdivison = Khulna;
    }
    if (_divisons == "বরিশাল") {
      currentdivison = Barisal;
    }
    if (_divisons == "ময়মনসিংহ") {
      currentdivison = Mymensingh;
    }
    if (_divisons == "রংপুর") {
      currentdivison = Rangpur;
    }
    if (_divisons == "সিলেট") {
      currentdivison = Sylhet;
    }
  }

  @override
  Widget build(BuildContext context) {
    //print(widget._divisons);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.greenAccent,
            title: Text(widget._divisons),
          ),
          body: SafeArea(
              child: Column(
            children: [
              Expanded(
                child: (Center(
                    child: Container(
                  color: Color.fromARGB(255, 237, 244, 234),
                  child: ListView.builder(
                      itemCount: currentdivison.length,
                      // scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                          child: Container(
                            decoration: BoxDecoration(
                            border: Border.all(
                              color: Color.fromARGB(255, 234, 226, 226),
                              width: 1,
                            ),
                          ),
                            child: ListTile(
                              title: Text(currentdivison[index]),
                            ),
                          ),
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      MyzillaPage(currentdivison[index]))),
                        );
                      }),
                ))),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'দর্শনীয় স্থান',
                style: TextStyle(fontSize: 18),
              ),
              Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _divisions.length,
                      //gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
                      itemBuilder: (_, index) {
                        return GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        Placeshow(_divisions[index]))),
                            child: Card(
                              elevation: 4.0,
                              margin: EdgeInsets.all(8.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      _divisions[index]["img"],
                                      width: 300.0,
                                      height: 200.0,
                                      fit: BoxFit.fitWidth,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "${_divisions[index]["placeName"]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        // height: 6.5,
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          Text("রেটিং"),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            child: Row(
                                              children: List.generate(5, (p) {
                                                return InkWell(
                                                  onTap: () {},
                                                  child: Icon(
                                                    _divisions[index]['avg'] !=
                                                                null &&
                                                            _divisions[index]
                                                                    ['avg'] >
                                                                p
                                                        ? Icons.star
                                                        : Icons.star_border,
                                                    color: Colors.greenAccent,
                                                  ),
                                                );
                                              }),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Text(
                                    //     "${_divisions[index]["description"]?.substring(0, 20)}"),
                                    // Text("${_divisions[index]["roadmap"]}"),
                                    // Text("${_divisions[index]["rating"]}"),
                                  ],
                                ),
                              ),
                            )
                            //     Card(
                            //   elevation: 3,
                            //   child: Column(children: [
                            //     Image.network(_divisions[index]["img"]),
                            //     Text("${_divisions[index]["placeName"]}"),
                            //     Text("${_divisions[index]["description"]}"),
                            //     Text("${_divisions[index]["roadmap"]}"),
                            //     Text("${_divisions[index]["rating"]}"),
                            //   ]),
                            // ),
                            );
                      }))
            ],
          ))),
    );
  }
}