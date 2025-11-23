import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent_connect/core/providers/auth_provider.dart';
import 'package:rent_connect/core/providers/home_provider.dart';

import 'foryou.dart';
import 'nearme.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  //crollController de kiem soat viec cuon trang
  bool _collapsed = false;
  final ScrollController _scrollController = ScrollController();
  String? url;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final offset = _scrollController.offset;
      final newColapsed = offset > 110;
      if (newColapsed != _collapsed) {
        setState(() => _collapsed = newColapsed);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                expandedHeight: 250,
                backgroundColor: Colors.white,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 160,
                        decoration: const BoxDecoration(
                          color: Colors.amberAccent,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 35),
                              child: Row(
                                children: [
                                  ref
                                      .watch(homeProvier)
                                      .when(
                                        data: (user) {
                                          return Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(48),
                                                child: Container(
                                                  width: 45,
                                                  height: 45,
                                                  color: Colors.blue,
                                                  child: Image.network(
                                                    user!.avatar!,
                                                    fit: BoxFit.cover,
                                                    errorBuilder:
                                                        (
                                                          context,
                                                          error,
                                                          stackTrace,
                                                        ) {
                                                          return Icon(
                                                            Icons
                                                                .person_outlined,
                                                          );
                                                        },
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    user != null
                                                        ? "xin chao ${user.name}"
                                                        : "xin chao khach",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Bạn muốn thuê trọ như nào?",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          );
                                        },
                                        error: (err, stack) =>
                                            Center(child: Text("Lỗi: $err")),
                                        loading: () => const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      ),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      //code thong bao (chua lam :>>>)
                                    },
                                    icon: const Icon(
                                      Icons.notifications_outlined,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 40),
                            InkWell(
                              onTap: () {
                                // dieu huong toi trang tim kiem
                              },
                              child: Container(
                                height: 60,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(18),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      spreadRadius: 2,
                                      blurRadius: 6,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Tim tro'),
                                      Icon(Icons.search_outlined),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(70),
                  child: Column(
                    children: [
                      //keo man hinh len
                      if (_collapsed)
                        Row(
                          children: [
                            const SizedBox(width: 10),
                            ref
                                .watch(homeProvier)
                                .when(
                                  data: (user) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(48),
                                      child: Container(
                                        height: 45,
                                        width: 45,
                                        child: Image.network(
                                          user!.avatar!,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                                return Icon(
                                                  Icons.person_outlined,
                                                );
                                              },
                                        ),
                                      ),
                                    );
                                  },
                                  error: (err, stack) =>
                                      Center(child: Text("Lỗi: $err")),
                                  loading: () => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  //dieu huong toi trang tim kiem
                                },
                                child: Container(
                                  height: 45,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Tim tro'),
                                        Icon(Icons.search_outlined),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.notifications_outlined),
                            ),
                          ],
                        ),
                      const SizedBox(height: 10,),
                      const TabBar(tabs:
                      [Tab(text: "Dành cho bạn"),
                        Tab(text: "Gần bạn"),
                        Tab(text: "Mới nhất"),])
                    ],
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(children: [ForYou(), NearMe()]),
        ),
      ),
    );
  }
}
