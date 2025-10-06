import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class EmployeeCardShimmer extends StatelessWidget {
  const EmployeeCardShimmer({super.key, this.isLastItem = false});

  final bool isLastItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: isLastItem ? 24 : 16),
      width: 326,
      margin: const EdgeInsets.symmetric(horizontal: 25),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.grey[300]!, width: 1),
              ),
              color: Colors.grey[300],
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Container(height: 16, width: 120, color: Colors.white),
                    const SizedBox(height: 4),
                    Container(height: 14, width: 180, color: Colors.white),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        4,
                            (index) => Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Container(
                            height: 14,
                            width: double.infinity,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: -20,
              right: 20,
              child: CircleAvatar(
                radius: 34,
                backgroundColor: Colors.grey[300],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
