import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IngredientItem extends StatelessWidget {
  final String name;
  final int quantity;
  final String? imageUrl;
  final String? imagePath; // Added image path parameter

  const IngredientItem({
    Key? key,
    required this.name,
    required this.quantity,
    this.imageUrl,
    this.imagePath, // Add this parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20), // Increased from 16 to 20
      padding: EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 20,
      ), // Increased padding
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child:
                imagePath != null
                    ? Image.asset(
                      imagePath!,
                      height: 50,
                      width: 50,
                      fit: BoxFit.contain,
                    )
                    : Icon(Icons.restaurant, color: Colors.grey[400], size: 30),
          ),
          SizedBox(width: 20), // Increased from 16
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18, // Increased from 16
                color: Color(0xFF2D3E40),
              ),
            ),
          ),
          Row(
            children: [
              Container(
                width: 32, 
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white, 
                  borderRadius: BorderRadius.circular(6),
                ),
                child: SvgPicture.asset(
                  'assets/icons/Negative.svg',
                  colorFilter: ColorFilter.mode(
                    quantity == 1 ? Colors.grey : Color(0xFF70B9BE),
                    BlendMode.srcIn,
                  ),
                  height: 24,
                  width: 24,
                ),
              ),
              SizedBox(width: 20), 
              Text(
                quantity.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF2D3E40),
                ),
              ),
              SizedBox(width: 20), 
              Container(
                width: 32, 
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white, 
                  borderRadius: BorderRadius.circular(6),
                  // Removed border property
                ),
                child: SvgPicture.asset(
                  'assets/icons/Plus.svg',
                  colorFilter: ColorFilter.mode(
                    Color(0xFF70B9BE),
                    BlendMode.srcIn,
                  ),
                  height: 24,
                  width: 24,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
