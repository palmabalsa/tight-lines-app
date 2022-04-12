
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Fish Data API'),
//       ),
//       body: 
//       Center(
//         child: Column(
//           children: [
//             Text('FIsh DAta from Django DB'),
//             ElevatedButton(
//               onPressed: fetchFishData, 
//               child: Text('get fishy data')),
//             FutureBuilder<FishData>(
//               future: fishy,
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   return Text(snapshot.data!.location + ' ' + snapshot.data!.fishSpecies + ' ' + snapshot.data!.fishCondition);
//                 } else if (snapshot.hasError) {
//                   return Text('${snapshot.error}');
//                 }

//                 // By default, show a loading spinner.
//                 return Text('not working');
//               },
//             )


            

//           ],)
//       ),

//       );
      
//   }
// }