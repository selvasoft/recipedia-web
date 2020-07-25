import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:recipedia/Models/Recipe.dart';
import 'package:recipedia/Constants/Api.dart' as urls;
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class RecipeDetails extends StatefulWidget {
  Recipe recipe;
  RecipeDetails({@required this.recipe});
  @override
  _RecipeDetailsState createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: Color(0xff262a46),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(40),
                              bottomRight: Radius.circular(40))),
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.share,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.favorite_border,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    )
                                  ],
                                ),
                              ]),
                        ),
                      )),
                  Hero(
                    tag: 'recipe' + widget.recipe.sId,
                    child: Align(
                        child: widget.recipe.recipePic != null
                            ? Padding(
                                padding: EdgeInsets.only(top: 100.0),
                                child: ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl: urls.imagesURL +
                                        "${widget.recipe.recipePic}",
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      width: 150,
                                      height: 150,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.fill,
                                      )),
                                    ),
                                    placeholder: (context, url) =>
                                        Shimmer.fromColors(
                                      baseColor: Colors.grey[400],
                                      highlightColor: Colors.white,
                                      child: Container(width: 150),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.only(top: 50.0),
                                child: ClipOval(
                                    child: Image.asset(
                                  "assets/background-app.jpg",
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.fill,
                                )))),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Text(
                  '${widget.recipe.title}',
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  style: new TextStyle(
                    fontSize: 20.0,
                    color: new Color(0xFF212121),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: RatingBar(
                        itemSize: 25.0,
                        initialRating: widget.recipe.rating ?? 3.5,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.redAccent,
                        ),
                        onRatingUpdate: (rating) {},
                      )),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.fastfood,
                          color:
                              widget.recipe.isVeg ? Colors.green : Colors.red),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          widget.recipe.isVeg ? 'Veg' : 'Non-Veg',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          style: new TextStyle(
                            fontSize: 15.0,
                            color:
                                widget.recipe.isVeg ? Colors.green : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                          height: 20,
                          width: 10,
                          child: VerticalDivider(
                            color: Colors.grey,
                            thickness: 2,
                          )),
                      Icon(
                        Icons.timer,
                        color: Color(0xff262a46),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          widget.recipe.time != null
                              ? '${widget.recipe.time}' + ' Min'
                              : '30 Min',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          style: new TextStyle(
                            fontSize: 15.0,
                            color: Color(0xff262a46),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Ingredients',
                  overflow: TextOverflow.ellipsis,
                  style: new TextStyle(
                    fontSize: 18.0,
                    color: new Color(0xFF212121),
                  ),
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.recipe.ingredients.length,
                  itemBuilder: (context, pos) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 32),
                      child:
                          Row(children: [Text(widget.recipe.ingredients[pos])]),
                    );
                  }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Steps',
                  overflow: TextOverflow.ellipsis,
                  style: new TextStyle(
                    fontSize: 18.0,
                    color: new Color(0xFF212121),
                  ),
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.recipe.steps.length,
                  itemBuilder: (context, pos) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 32),
                      child: Row(children: [
                        Text('Step ${pos + 1}: ${widget.recipe.steps[pos]}')
                      ]),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}