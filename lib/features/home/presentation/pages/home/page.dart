// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shamo_mobile/app/config.dart';
// import 'package:shamo_mobile/core/core.dart';
// import 'package:shamo_mobile/features/auth/auth.dart';
// import 'package:shamo_mobile/features/product/product.dart';
//
// part 'sections/category_section.dart';
// part 'sections/profile_section.dart';
// part 'sections/popular_section.dart';
// part 'sections/new_section.dart';
// part 'sections/product_section.dart';
// part 'sections/skeleton_product_section.dart';
//
// class HomePage extends StatelessWidget {
//   const HomePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<CategoryBloc, CategoryState>(
//       builder: (context, state) {
//         return Scaffold(
//           body: CustomScrollView(
//             slivers: [
//               SliverAppBar(
//                 backgroundColor: context.theme.scaffoldBackgroundColor,
//                 expandedHeight: 160,
//                 pinned: true,
//                 flexibleSpace: FlexibleSpaceBar(
//                   background: _ProfileSection(key: key),
//                   titlePadding: EdgeInsets.zero,
//                   expandedTitleScale: 1,
//                   title: _CategorySection(key: key),
//                 ),
//               ),
//               if (state.id.isEmpty) ...[
//                 SliverToBoxAdapter(
//                   child: _PopularSection(key: key),
//                 ),
//                 SliverToBoxAdapter(
//                   child: _NewSection(key: key),
//                 ),
//               ],
//               if (state.id.isNotEmpty)
//                 SliverToBoxAdapter(
//                   child: _ProductSection(key: key),
//                 ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
