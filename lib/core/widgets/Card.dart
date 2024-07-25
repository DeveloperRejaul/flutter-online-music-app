import 'package:flutter/material.dart';
import 'package:flutter_online_music_app/core/constants/colors.dart';

class MusicCard extends StatelessWidget {
  final String img;
  final String name;
  final String title;
  final Color color;
  final bool isFavorite;
  final void Function()? onPressed;
  final void Function()? onFavorite;
  const MusicCard({
    super.key,
    required this.img,
    required this.name,
    required this.title,
    required this.color,
    this.onPressed,
    this.onFavorite,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final double imageHeight = 170;

    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: imageHeight,
            width: imageHeight,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(img),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: -8,
                  right: -6,
                  child: IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_outline,
                      color: AppColors.light100,
                    ),
                    onPressed: onFavorite,
                  ),
                ),
                Positioned(
                  bottom: 8,
                  left: 0,
                  child: GestureDetector(
                    onTap: onPressed,
                    child: Row(
                      children: [
                        Container(
                          color: color,
                          height: 20,
                          width: 10,
                        ),
                        SizedBox(width: 10),
                        Text(
                          name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.light400,
                            fontSize: 15,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: onPressed,
            child: Container(
              height: 15,
              width: imageHeight,
              color: color,
            ),
          ),
          GestureDetector(
            onTap: onPressed,
            child: SizedBox(
              width: imageHeight,
              child: Text(
                title,
                maxLines: 2,
                style: TextStyle(
                  color: AppColors.light800,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
