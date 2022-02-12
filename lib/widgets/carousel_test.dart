import 'package:carousel_slider/carousel_slider.dart';
import 'package:fyp3/imports.dart';

class CarouselTest extends StatefulWidget {
  const CarouselTest({Key? key}) : super(key: key);

  @override
  State<CarouselTest> createState() => _CarouselTestState();
}

class _CarouselTestState extends State<CarouselTest> {
  Stream<DocumentSnapshot> balanceData =
      FirebaseFirestore.instance.collection('users').doc(uid).snapshots();

  static String? get uid => FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: balanceData,
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        return carouselView(context, snapshot);
      },
    );
  }

  Widget carouselView(BuildContext context, snapshot) {
    List<int> list = [1, 2, 3, 4, 5];
    return Container(
      // borderRadius: const BorderRadius.all(Radius.circular(40)),
      child: CarouselSlider(
        options: CarouselOptions(viewportFraction: 1, autoPlay: true, enlargeCenterPage: true),
        items: list
            .map((item) => ClipRRect(
          borderRadius:
          const BorderRadius.all(Radius.circular(40)),
          child: Container(
            child: Center(child: Text(item.toString())),
            color: Colors.green,
          ),
        ))
            .toList(),
      ),
    );
  }
}
