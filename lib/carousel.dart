import 'package:fyp3/widgets/expenses.dart';

import 'imports.dart';

class Carousel extends StatefulWidget {
  const Carousel({Key? key}) : super(key: key);

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  List<Widget> children = [
    BalanceCard(),
    SizedBox(width: 10,),
    ExpensesCard(),
    // ContainerCard(),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
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
