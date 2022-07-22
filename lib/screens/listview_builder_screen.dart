import 'package:fl_components/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ListViewBuilderScreen extends StatefulWidget {
   
  const ListViewBuilderScreen({Key? key}) : super(key: key);

  @override
  State<ListViewBuilderScreen> createState() => _ListViewBuilderScreenState();
}

class _ListViewBuilderScreenState extends State<ListViewBuilderScreen> {

  final List<int> imagesIds = [1,2,3,4,5,6,7,8,9,10];
  final ScrollController scrollController = ScrollController();
  bool isLoading = false;

  // Required to override, to listen the scroll
  @override
  void initState() {
    super.initState();
    
    scrollController.addListener(() {
        print(' ${scrollController.position.pixels}, ${scrollController.position.maxScrollExtent} ');
        if ( (scrollController.position.pixels + 500) >= scrollController.position.maxScrollExtent )  {
          // add5();        // Add more elements to chek, once you scroll to the bottom
          fetchData();      // Fetch new elements more slowly
        }
    });
  }

  Future fetchData() async {

    if ( isLoading ) return;

    isLoading = true;
    setState(() {});

    await Future.delayed( const Duration( seconds: 3 ));    // Delay the load of data once you are scrolling

    add5();

    isLoading = false;
    setState(() {});

    if ( scrollController.position.pixels + 100 <= scrollController.position.maxScrollExtent ) return;

    // Once the fetch data has been loaded and you are at the bottom --> Move the scroll automatically
    scrollController.animateTo(
      scrollController.position.pixels + 120, 
      duration: const Duration( milliseconds: 300 ), 
      curve: Curves.fastOutSlowIn
    );
    
  }

  void add5() {
    final lastId = imagesIds.last;
    imagesIds.addAll(
      [1,2,3,4,5].map((e) => lastId + e )
    );
    setState(() {});
  }

  Future<void> onRefresh() async {
    await Future.delayed( const Duration( seconds: 2 ));    
    final lastId = imagesIds.last;
    imagesIds.clear();
    imagesIds.add(lastId + 1);
    add5();
  }

  @override
  Widget build(BuildContext context) {

    // Get device's size
    final size = MediaQuery.of(context).size;

    return Scaffold(
      // appBar     In this case, we don't specify it, because we want to fulfill all the height
      body: MediaQuery.removePadding(     // Allows remove padding let, although you haven't specified the appBar
        context: context,
        removeTop: true,
        removeBottom: true,
        child: Stack(         // Similar to Colum or Row
          children: [

            // Widget to refresh, even if you scroll to the top, fetching new images
            RefreshIndicator(
              color: AppTheme.primary,
              onRefresh: onRefresh,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                controller: scrollController,   // Any Widget which allows making scroll, has got a controller to check how far is from the last element of the list
                itemCount: imagesIds.length,
                itemBuilder: (BuildContext context, int index) {
                  return FadeInImage(
                    width: double.infinity,     // Avoid problems in which the loadingImage's dimension != and finalImage's dimension
                    height: 300,
                    fit: BoxFit.cover,
                    placeholder: const AssetImage('assets/jar-loading.gif'), 
                    image: NetworkImage('https://picsum.photos/500/300?image=${ imagesIds[index] }')
                  );
                },
              ),
            ),

            // Widget to indicate to the user that it's loading / fetching the data
            if ( isLoading )
              // Widget to indicate the position of a widget into a Stack
              Positioned(
                bottom: 40,
                left: size.width * 0.5 - 30,
                child: const _LoadingIcon()
              )
          ],
        ),
      ),
    );
  }
}

class _LoadingIcon extends StatelessWidget {
  const _LoadingIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        shape: BoxShape.circle
      ),
      child: const CircularProgressIndicator( color: AppTheme.primary )
    );
  }
}