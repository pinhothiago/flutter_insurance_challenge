import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InsuranceCard extends StatelessWidget {
  final String type;
  final IconData icon;

  const InsuranceCard({super.key, required this.type, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(4),
        onTap: () => _handleTap(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Theme.of(context).primaryColor),
            const SizedBox(height: 8),
            Text(
              type,
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _handleTap(BuildContext context) {
    if (type == 'Automóvel') {
      WebViewUtils.openUrl(
        context,
        'https://jsonplaceholder.typicode.com',
        title: 'Cotação de Automóvel',
      );
    }
  }
}

class WebViewUtils {
  static void openUrl(
    BuildContext context,
    String url, {
    required String title,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebViewPage(title: title, url: url),
      ),
    );
  }
}

class WebViewPage extends StatefulWidget {
  final String title;
  final String url;

  const WebViewPage({super.key, required this.title, required this.url});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: WebViewWidget(controller: _controller),
    );
  }
}
