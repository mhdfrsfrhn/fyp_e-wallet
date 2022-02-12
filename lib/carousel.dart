import 'package:fyp3/widgets/expenses.dart';

import 'imports.dart';

class Carousel extends StatefulWidget {
  const Carousel({Key? key}) : super(key: key);

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  List<Widget> children = [
    SizedBox(width: 20),
    BalanceCard(),
    SizedBox(width: 20),
    ExpensesCard(),
    SizedBox(width: 20),
    // ContainerCard(),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        // padding: EdgeInsets.only(right: 10),
        height: 150,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: const PageScrollPhysics(), // this for snapping
          itemCount: children.length,
          itemBuilder: (_, index) => children[index],
        ),
      ),
    );
  }
}
