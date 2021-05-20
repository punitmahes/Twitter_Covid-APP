import 'package:covidarmy/cities.dart';
import 'package:covidarmy/twitter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:tweet_ui/tweet_ui.dart';
import 'package:twitter_api/twitter_api.dart';
import 'dart:convert';
import 'package:tweet_ui/models/api/tweet.dart';
import 'package:tweet_ui/models/api/user.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: AutoComplete(),
      ),
    );
  }
}

Image appLogo = new Image(
    image: new ExactAssetImage("assets/images/covid.png"),
    height: 28.0,
    width: 20.0,
    alignment: FractionalOffset.center);

class AutoComplete extends StatefulWidget {
  @override
  _AutoCompleteState createState() => new _AutoCompleteState();
}

class _AutoCompleteState extends State<AutoComplete> {
  _AutoCompleteState();
  List<String> requirements = [
    'Oxygen Bed',
    'ICU Bed',
    'Oxygen Concentators',
    'Remdesevir',
    'Tocilizumab',
    'Favipiravir',
    'Bed',
    'Plasma',
    'Ambulance',
    'Home ICU',
    'Helpline',
  ];
  void _loadData() async {
    await CityView.loadcities();
  }
  void _loadtweets() async {
    await Twitter.LoadTweets();
}
  bool neednotempty = true;
  String city = "";
  String need = "";
  String all = "";

  @override
  void initState() {
    _loadData();
    super.initState();
    startTime();
  }
  final controller_need = TextEditingController();
  startTime() async {
    var duration = new Duration(seconds: 6);

  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                alignment: Alignment.topCenter,
                margin: const EdgeInsets.fromLTRB(10.0,100,10,10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white10,
                        offset: const Offset(
                          5.0,
                          5.0,
                        ),
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                      ),
                    ]),
                child: Column(

                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Icon(
                                  Icons.location_pin,
                                  color: Colors.blueAccent,
                                  textDirection: TextDirection.ltr,
                                  size: 30,
                                )),
                            SizedBox(width: 20),
                            Text(
                              "Choose your city",
                              textDirection: TextDirection.ltr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10.0,10,10,20),
                        child: SimpleAutoCompleteTextField(
                          key: null,
                          suggestions: CityView.CityName,
                          textSubmitted: (value) {
                            city = value;
                            all = city +" " +  need;
                          },
                          clearOnSubmit: false,
                          style: new TextStyle(
                              color: Colors.black,
                              fontSize: 16.0, fontWeight: FontWeight.bold, height: 1),
                          decoration: new InputDecoration(
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.lightBlueAccent, width: 2.0),
                            ),
                            hoverColor: Colors.grey,
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                            filled: true,
                          ),
                        ),
                      ),
                    ])),
            Container(
                alignment: Alignment.topCenter,
                margin: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white10,
                        offset: const Offset(
                          5.0,
                          5.0,
                        ),
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                      ),
                    ]),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Icon(
                                  Icons.local_hospital_rounded,
                                  color: Colors.blueAccent,
                                  textDirection: TextDirection.ltr,
                                  size: 30,
                                )),
                            SizedBox(width: 20),
                            Text(
                              "Choose resources",
                              textDirection: TextDirection.ltr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 20.0),
                        child: SimpleAutoCompleteTextField(
                          key: null,
                          suggestions: requirements,
                          textSubmitted: (value) {
                            need = value;
                            all = need +" "+ city;
                            if(value == ''){
                              setState(() {
                                neednotempty = false;
                              });
                            }
                            else{
                              setState(() {
                                neednotempty = true;
                              });
                            }
                          },
                          clearOnSubmit: false,
                          style: new TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0, height: 1),
                          decoration: new InputDecoration(
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.lightBlueAccent, width: 2.0),
                            ),
                            hoverColor: Colors.grey,
                            contentPadding:
                                EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                            filled: true,
                          ),
                        ),
                      ),
                    ])),
            Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: (){
                  //Navigate to twitter page with tweets
                    Navigator.push(
                        context,
                        PageRouteBuilder(pageBuilder: (_, __, ___) => TweetPage(text: all)),
                  );

                  print("Pressed enter with city = $city and need = $need");
                },
                child: Text('Submit'),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blueAccent),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    minimumSize:
                        MaterialStateProperty.all<Size>(Size(40.0, 40.0)),
                shadowColor: MaterialStateProperty.all<Color>(Colors.blue)),
              ),
            )
          ],
        ),
      ),
    );
  }
}


class TweetPage extends StatefulWidget {
  final String text;
  const TweetPage({Key key,@required this.text}) : super(key: key);

  @override
  _TweetPageState createState() => _TweetPageState(this.text);
}

class _TweetPageState extends State<TweetPage> {
  static String consumerApiKey = "cmoztpo7eFsVZt7M2QQLdRo57";
  static String consumerApiSecret = "pqDVprbXokCLU5DPNOGCj8Cv756u1nWNG5MrVjho4751WE5rlj";
  static String accessToken = "1170326033205100545-cajORkQW2lKIu9frEyYl8jWDsx3or6";
  static String accessTokenSecret = "vtRO2ZHrY2UVw9z7mifSeiD8vEbPIRq7gd0gu0pIIp0mL";
  bool isLoading = false;
  final _twitterOauth = new twitterApi( //key information requered for requests to the twitter api
      consumerKey: consumerApiKey,
      consumerSecret: consumerApiSecret,
      token: accessToken,
      tokenSecret: accessTokenSecret
  );
  List <Twitter_> twitter_list;
  final String query;
  _TweetPageState(this.query);


  Future searchTweets(String query) async {
    Future twitterRequest = _twitterOauth.getTwitterRequest(
      // Http Method
      "GET", //GET request
      // Endpoint you are trying to reach
      "search/tweets.json",
      // The options for the request
      options: {
        "q": query,
        "lang": "en", //english
        "count": "100", //100 tweet Max amount for free
        "tweet_mode": "extended", // Used to prevent truncating tweets
      },
    );
    var res = await twitterRequest;
    twitter_list = new List<Twitter_>();
    var tweets = json.decode(res.body);
    Map<String, dynamic> map = json.decode(res.body);
    List<dynamic> data = map["statuses"];
    print(tweets['statuses']);
    for(int i = 0;i<tweets['statuses'].length;i++){
      String check = tweets['statuses'][i]['full_text'];
      Twitter_ neww = Twitter_(check,"1");
      setState(() {
        twitter_list.add(neww);
      });

    }
  }

    void initState(){
      searchTweets(query);
      super.initState();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
          appBar: getAppBar(),
          body: Column(
            children: [
              Expanded(
                  child:  ListView.builder(
                      itemCount: twitter_list.length,
                      itemBuilder: (context,index){
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: Text("$index",style: TextStyle(fontWeight: FontWeight.bold),),
                            title: Text(twitter_list[index].body_text,
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontStyle: FontStyle.italic),),
                            tileColor: Colors.grey,
                            contentPadding: EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                            selected: true,

                          ),
                        );
                      })
              ),
            ],
          ),

        );
      }

}
  

  AppBar getAppBar() {
    return AppBar(
      leading: Builder(builder: (BuildContext context) {
        return IconButton(
          icon: Icon(
            Icons.home_rounded,
            color: Colors.blueAccent,
          ),
          splashColor: null,
          onPressed: () {},
        );
      }),
      title: Image.asset(
        "assets/images/covid.png",
        fit: BoxFit.contain,
        height: 30,
        alignment: Alignment.center,
      ),
      toolbarHeight: 50,
      actions: [
        IconButton(
            onPressed: () => {},
            icon: Icon(
              Icons.filter_alt_outlined,
              color: Colors.blueAccent,
            )),
      ],
      backgroundColor: Colors.white,
      centerTitle: true,
    );
  }

  //Class for Twitter
class Twitter_ {
  String body_text ;
  String id_name;

  Twitter_(String val1,String Val2){
    body_text = val1;
    id_name = Val2;
}
}

//my list view
class Data {
  String needs;
  Data({this.needs});
}
