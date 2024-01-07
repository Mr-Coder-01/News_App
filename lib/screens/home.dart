import 'package:flutter/material.dart';
import 'package:new_app/models/article_model.dart';
import 'package:new_app/screens/article_screen.dart';
import 'package:new_app/services/news.dart';
import 'package:new_app/services/slider_data.dart';
import '../models/category_model.dart';
import '../models/slider_model.dart';
import '../services/data.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<CategoryModel> categories=[];
  List<SliderModel> sliders=[];
  List<ArticleModel> articles=[];
  bool _loading= true;
  int activeIndex= 0;
  @override
  void initState(){
    categories= getCategories();
    getSlider();
    getNews();
    super.initState();
  }
  // To get data for sliders
  getSlider() async{
    Sliders slider= Sliders();
    await slider.getSlider();
    sliders= slider.sliders;
  }
  // to get news
  getNews() async{
     News newsclass= News();
     await newsclass.getNews();
     articles= newsclass.news;
     setState(() {
       _loading= false;
     });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News',
          style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
        centerTitle: true,
        elevation: 0.0,),
      body: _loading? Center(child: CircularProgressIndicator()): SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20.0),
                height: 70,
                child: ListView.builder( // the top category cards
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context,index){
                    return CategoryTile(
                      image: categories[index].image,
                      categoryName: categories[index].categoryName,);
              }),),
              const SizedBox(height: 30.0,),
              // breaking news section
              const Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Breaking News', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18.0),),
                    Text('View all', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500, fontSize: 16.0),),
                  ],
                ),
              ),
              const SizedBox(height: 20.0,),
              // slider for the breaking news
              CarouselSlider.builder(itemCount: 5, itemBuilder: (context, index, realIndex){
                String? res= sliders[index].urlToImage;
                String? res1= sliders[index].title;
                return buildImage(res!, index, res1!);
              }, options: CarouselOptions(height: 250,autoPlay: true, enlargeCenterPage: true, enlargeStrategy: CenterPageEnlargeStrategy.height, onPageChanged: (index,reason){
                   setState(() {
                     activeIndex= index;
                   });
              })),
              const SizedBox(height: 30.0,),
              Center(child: buildIndicator()),
              const SizedBox(height: 30.0,),
              // Trending news section
              const Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Trending News', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 24.0, fontFamily: 'Pacifico'),),
                    Text('View all', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500, fontSize: 16.0),),
                  ],
                ),
              ),
              const SizedBox(height: 10.0,),
              // the trending news
              Container(
                child: ListView.builder(shrinkWrap: true, physics: const ClampingScrollPhysics() , itemCount: articles.length ,itemBuilder: (context, index){
                  return BlogTile(imageUrl: articles[index].urlToImage!, title: articles[index].title!, desc: articles[index].description!, url: articles[index].url!);
                }),
              ),
            ],
          ),
        ),
      ),
    );

  }
  // the slider widget used for breaking news
  Widget buildImage(String image, int index, String name)=> Container(
    margin: const EdgeInsets.symmetric(horizontal: 5.0),
    child: Stack(
      children:[
        ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(imageUrl: image,height: 250, fit: BoxFit.cover, width: MediaQuery.of(context).size.width,),),
        Container(
          height: 250,
          padding: const EdgeInsets.only(left: 10.0),
          margin: const EdgeInsets.only(top: 170.0),
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10),)),
          child: Text(name, style: const TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),), )
      ]
    ),
  );
  Widget buildIndicator()=> AnimatedSmoothIndicator(activeIndex: activeIndex, count: 5, effect: const SlideEffect(dotWidth: 15, dotHeight: 15, activeDotColor: Colors.blue));
}
// the breaking news tile
class CategoryTile extends StatelessWidget {
  final image, categoryName;
   const CategoryTile({super.key,this.image, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: Stack(
        children: [
          ClipRRect(
              borderRadius:BorderRadius.circular(6),
              child: Image.asset(image, width: 120,height: 70,fit: BoxFit.cover,)),
          Container(
            width: 120,
            height: 70,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(6),color: Colors.black38,),
            child: Center(child: Text(categoryName, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),)),
          )
        ],
      ),
    );
  }

}

//the trending news class
class BlogTile extends StatelessWidget {
  String imageUrl, title, desc, url;
  BlogTile({required this.imageUrl, required this.title, required this.desc, required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
         Navigator.push(context, MaterialPageRoute(builder: (context)=> ArticleScreen(blogUrl:url)));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10.0,),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Material(
            elevation: 3.0,
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(imageUrl: imageUrl, height: 120, width: 120, fit: BoxFit.cover,))),
                  const SizedBox(width: 8.0,),
                  Column(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width/1.7,
                          child: Text(title,maxLines: 2,style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 17.0),)),
                      const SizedBox(height: 7.0,),
                      Container(
                          width: MediaQuery.of(context).size.width/1.7,
                          child: Text(desc,maxLines: 3, style: const TextStyle(color: Colors.black38, fontWeight: FontWeight.w500, fontSize: 16.0),)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


