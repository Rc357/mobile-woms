import 'package:app/model/model_service_card.dart';
import 'package:flutter/material.dart';

class TypeOfServiceCard extends StatefulWidget {
  final selectedData;
  const TypeOfServiceCard({
    Key? key,
    required this.selectedData,
  }) : super(key: key);

  @override
  _TypeOfServiceCardState createState() => _TypeOfServiceCardState();
}

class _TypeOfServiceCardState extends State<TypeOfServiceCard> {
  int? selectedIndex;
  @override
  Widget build(BuildContext context) {
    List<CardItem> items = [
      CardItem(
          urlImage: 'assets/service_images/cleanse_n_detox_facial.jpeg',
          title: "Cleanse and Detox Facial",
          price: "\$100.00",
          isSelected: false),
      CardItem(
          urlImage: "assets/service_images/hydrafacial_deluxe_clarifying.jpeg",
          title: "Hydrafacial - Deluxe Clarifying",
          price: "\$200.00",
          isSelected: false),
      CardItem(
          urlImage: "assets/service_images/hydrafacial_deluxe_restorative.jpeg",
          title: "Hydrafacial - Deluxe Restorative",
          price: "\$200.00",
          isSelected: false),
      CardItem(
          urlImage: "assets/service_images/hydrafacial_platinum.jpeg",
          title: "Hydrafacial - Platinum",
          price: "\$250.00",
          isSelected: false),
      CardItem(
          urlImage: "assets/service_images/hydrafacial_signature.jpeg",
          title: "Hydrafacial - Signature",
          price: "\$150.00",
          isSelected: false),
      CardItem(
          urlImage: "assets/service_images/illuminate_n_renew_facial.jpeg",
          title: "Illuminate and Renew Facial",
          price: "\$150.00",
          isSelected: false),
      CardItem(
          urlImage: "assets/service_images/laser_consultation.jpeg",
          title: "Laser Consultation",
          price: "\$0.00",
          isSelected: false),
      CardItem(
          urlImage: "assets/service_images/luxe_glow_anti_aging_facial.jpeg",
          title: "Luxe Glow Anti-Aging Facial",
          price: "\$135.00",
          isSelected: false),
      CardItem(
          urlImage: "assets/service_images/teeth_whitening.jpeg",
          title: "Teeth Whitening",
          price: "\$100.00",
          isSelected: false),
      CardItem(
          urlImage: "assets/service_images/small_body_part_laser.jpeg",
          title: "Small Body Part Laser ONE TIME",
          price: "\$50.00",
          isSelected: false),
      CardItem(
          urlImage: "assets/service_images/large_body_part_laser.jpeg",
          title: "Large Body Part Laser ONE TIME",
          price: "\$150.00",
          isSelected: false),
      CardItem(
          urlImage: "assets/service_images/full_body_laser.jpeg",
          title: "Full Body Part Laser ONE TIME",
          price: "\$500.00",
          isSelected: false),
    ];

    return Container(
        height: 256,
        child: ListView.separated(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Container(
                key: UniqueKey(),
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 3,
                      color:
                          (selectedIndex == index) ? Colors.green : Colors.red,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: buildCard(item: items[index], isSel: index)),
            separatorBuilder: (context, _) => SizedBox(
                  width: 15,
                ),
            itemCount: items.length));
  }

  Widget samp() {
    return Container();
  }

  Widget buildCard({
    required CardItem item,
    required int isSel,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          print("object");
          print("item.title");
          print(item.title);
          widget.selectedData(item);
          selectedIndex = isSel;
        });
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              width: 5,
              color: Colors.white,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        width: 200,
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                child: Image.asset(
                  item.urlImage,
                  fit: BoxFit.contain,
                  width: 300,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                child: Column(
                  children: [
                    Center(
                        child: Text(
                      item.title,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(color: Colors.pink.shade900, fontSize: 18),
                    )),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      item.price,
                      style:
                          TextStyle(color: Colors.pink.shade700, fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
