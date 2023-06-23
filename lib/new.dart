// Center(
//         child: SizedBox(
//           height: 1000,
//           child: CarouselSlider(
//             items: db.data
//                 .map((e) => Task(
//                     checkbox: e[1],
//                     index: db.data.indexOf(e),
//                     taskName: e[0],
//                     onChanged: (_) => checkBoxFunc(db.data.indexOf(e)),
//                     deleteFunc: (context) => deleteTask(db.data.indexOf(e))))
//                 .toList(),
//             options: CarouselOptions(
//                 initialPage: 0,
//                 scrollDirection: Axis.vertical,
//                 enableInfiniteScroll: false),
//           ),
//         ),
//       )