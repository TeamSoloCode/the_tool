import 'package:flutter/material.dart';

class CustomExpansionPanel extends StatefulWidget {
  final Widget header;
  final Widget body;
  final Duration animationDuration;

  CustomExpansionPanel({
    required this.header,
    required this.body,
    this.animationDuration = const Duration(milliseconds: 200),
  });

  @override
  _CustomExpansionPanelState createState() => _CustomExpansionPanelState();
}

class _CustomExpansionPanelState extends State<CustomExpansionPanel>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;

      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TickerMode(
      enabled: TickerMode.of(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: _toggleExpansion,
            child: widget.header,
          ),
          AnimatedSize(
            duration: widget.animationDuration,
            child: AnimatedContainer(
              duration: widget.animationDuration,
              curve: Curves.easeInOut,
              height: _isExpanded ? null : 0.0,
              child: _isExpanded ? widget.body : null,
            ),
          ),
        ],
      ),
    );
  }
}
