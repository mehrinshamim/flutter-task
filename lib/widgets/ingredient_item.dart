// lib/widgets/ingredient_item.dart
import 'package:flutter/material.dart';

class IngredientItem extends StatefulWidget {
  final String name;
  final int quantity;

  const IngredientItem({Key? key, required this.name, required this.quantity})
    : super(key: key);

  @override
  _IngredientItemState createState() => _IngredientItemState();
}

class _IngredientItemState extends State<IngredientItem> {
  bool isSelected = false;
  int quantity = 0;

  @override
  void initState() {
    super.initState();
    quantity = widget.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Ingredient image
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[200],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                'https://picsum.photos/seed/${widget.name.hashCode}/40/40',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 12),

          // Ingredient name
          Expanded(
            child: Text(
              widget.name,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
          ),

          // Checkbox
          Checkbox(
            value: isSelected,
            onChanged: (value) {
              setState(() {
                isSelected = value ?? false;
              });
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),

          // Quantity controls
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            child: Text(
              '$quantity',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
            icon: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Icon(Icons.add, size: 16),
            ),
            onPressed: () {
              setState(() {
                quantity++;
              });
            },
            constraints: BoxConstraints(),
            padding: EdgeInsets.zero,
            iconSize: 24,
          ),
        ],
      ),
    );
  }
}
