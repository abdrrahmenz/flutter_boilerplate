import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../core.dart';

/// Error page displayed when route is not found (404)
class ErrorPage extends StatelessWidget {
  const ErrorPage({
    super.key,
    this.error,
  });

  final Exception? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Not Found'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 80,
                color: Colors.red,
              ),
              const SizedBox(height: 24),
              Text(
                'Page not found :(',
                style: context.h3?.copyWith(
                  fontSize: 24,
                  fontWeight: .bold,
                ),
                textAlign: .center,
              ),
              const SizedBox(height: 16),
              if (error != null)
                Text(
                  error.toString(),
                  style: context.bodyMedium?.copyWith(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  textAlign: .center,
                ),
              const SizedBox(height: 32),
              ShadButton(
                onPressed: () {
                  context.go('/home');
                },
                child: const Text('Go to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
