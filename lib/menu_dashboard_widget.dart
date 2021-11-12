import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

final TextStyle menuFontStyle= TextStyle(color: Colors.white,fontSize: 20);
final Color backgroundColor=Color(0xFF343442);

class MenuDashboard extends StatefulWidget {
  @override
 //State<MenuDashboard> createState() => _MenuDashboardState();
  _MenuDashboardState createState() => _MenuDashboardState();
}

class _MenuDashboardState extends State<MenuDashboard> with SingleTickerProviderStateMixin{

  late double ekranYuksekligi,ekranGenisligi;
   bool menuAcikmi=false;
   late AnimationController _controller;
   late Animation<double> _scaleAnimation;
  late Animation<double> _scaleMenuAnimation;
   late Animation<Offset> _menuOffsetAnimation;
   final Duration _duration = Duration(milliseconds: 300);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this, duration: _duration);
    _scaleAnimation = Tween(begin: 1.0, end: 0.6).animate(_controller);
    _scaleMenuAnimation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _menuOffsetAnimation = Tween(begin: Offset(-1,0),end: Offset(0,0)).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

  }
   @override
  void dispose() {
  _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ekranYuksekligi=MediaQuery.of(context).size.height;
    ekranGenisligi=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backgroundColor,
    body: SafeArea(
      child: Stack(
        children: <Widget>[
          menuOlustur(context),
          dashBoardOlustur(context),
        ],
      ),
    ),
    );
  }

  Widget menuOlustur(BuildContext context) {
    return SlideTransition(
      position: _menuOffsetAnimation,
      child: ScaleTransition(
      scale: _scaleMenuAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FlatButton.icon(
                onPressed: null,
                icon: Icon(
                  Icons.restaurant_menu,
                  color: Colors.purple,
                ),
                label: Text(
                  "Dashboard",
                  style: menuFontStyle,
                ),
              ),
              FlatButton.icon(
                onPressed: null,
                icon: Icon(
                  Icons.message,
                  color: Colors.purple,
                ),
                label: Text(
                  "Messages",
                  style: menuFontStyle,
                ),
              ),
              FlatButton.icon(
                onPressed: null,
                icon: Icon(
                  Icons.accessibility_new,
                  color: Colors.purple,
                ),
                label: Text(
                  "Utility Bills",
                  style: menuFontStyle,
                ),
              ),
              FlatButton.icon(
                onPressed: null,
                icon: Icon(
                  Icons.transform,
                  color: Colors.purple,
                ),
                label: Text(
                  "Funds Transfer",
                  style: menuFontStyle,
                ),
              ),
              FlatButton.icon(
                onPressed: null,
                icon: Icon(
                  Icons.build,
                  color: Colors.purple,
                ),
                label: Text(
                  "Branches",
                  style: menuFontStyle,
                ),
              ),
            ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dashBoardOlustur(BuildContext context) {
    return AnimatedPositioned(
      duration: _duration,
      top: 0,
      bottom: 0,
      left: menuAcikmi ? 0.4*ekranGenisligi : 0,
      right: menuAcikmi ? -0.4*ekranGenisligi : 0,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          borderRadius: menuAcikmi ? BorderRadius.all(Radius.circular(40)):null,
        elevation: 8,
         color: Colors.greenAccent,
         child: SingleChildScrollView(
           child: Container(
             padding: EdgeInsets.only(left: 16,right: 16,top: 8),
             child: Column(
               children: <Widget>[
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: <Widget>[
                   InkWell(
                     onTap: (){
                       setState(() {
                         if(menuAcikmi){
                           _controller.reverse();
                         }else{
                           _controller.forward();
                         }
                         menuAcikmi = !menuAcikmi;

                       });
                     },
                     child: Icon(
                       Icons.menu,color:Colors.white,),
                   ),
                   Text("My Cards", style: TextStyle(color: Colors.white,fontSize: 24),),
                   Icon(Icons.add_circle_outline,color: Colors.white,),
                 ],
                 ),
                 Container(
                   margin: EdgeInsets.only(top: 10),
                   height: 200,
                   child: PageView(
                    scrollDirection: Axis.horizontal,
                     children: <Widget>[
                       Container(
                         child: Image.network(
                           "https://images.unsplash.com/photo-1528557692780-8e7be39eafab?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80",
                           fit: BoxFit.cover,
                         ),
                         width: 200,
                         margin: EdgeInsets.symmetric(horizontal: 2),
                       ),
                       Container(
                         child: Image.network(
                           "https://images.unsplash.com/photo-1524721696987-b9527df9e512?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80",
                           fit: BoxFit.cover,
                         ),
                         width: 200,
                         margin: EdgeInsets.symmetric(horizontal: 2),
                       ),
                       Container(
                         child: Image.network(
                           "https://images.unsplash.com/photo-1528557692780-8e7be39eafab?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80",
                           fit: BoxFit.cover,
                         ),
                         width: 200,
                         margin: EdgeInsets.symmetric(horizontal: 2),
                       ),
                     ],
                   ),
                 ),
                 SizedBox(
                   height: 10,),
                 ListView.separated(
                     shrinkWrap: true,
                     physics: BouncingScrollPhysics(),
                     itemBuilder: (context,index){
                   return ListTile(
                     leading: Icon(Icons.person),
                     title: Text("TestVerisi $index"),
                     trailing: Icon(Icons.add),
                   );
                 }, separatorBuilder: (context,index){
                   return Divider();
                 }, itemCount: 50)
               ],
             ),
           ),
         ),
        ),
      ),
    );
  }
}
