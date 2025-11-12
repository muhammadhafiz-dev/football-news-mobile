import 'package:flutter/material.dart';
import 'package:football_news/models/news_entry.dart';

class NewsEntryCard extends StatelessWidget {
  final NewsEntry news;
  final VoidCallback onTap;

  const NewsEntryCard({
    super.key,
    required this.news,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasThumbnail = news.thumbnail != null && news.thumbnail.toString().isNotEmpty;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(color: Colors.grey.shade300),
          ),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ✅ Thumbnail
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: hasThumbnail
                      ? Image.network(
                          'http://127.0.0.1:8000/proxy-image/?url=${Uri.encodeComponent(news.thumbnail.toString())}',
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            height: 150,
                            color: Colors.grey[300],
                            child: const Center(child: Icon(Icons.broken_image)),
                          ),
                        )
                      : Container(
                          height: 150,
                          width: double.infinity,
                          color: Colors.grey[200],
                          child: const Center(
                            child: Icon(Icons.image_not_supported, size: 40, color: Colors.grey),
                          ),
                        ),
                ),

                const SizedBox(height: 10),

                Text(
                  news.title.isNotEmpty ? news.title : "(No title)",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),

                Text("Category: ${news.category}", style: const TextStyle(color: Colors.black54)),

                const SizedBox(height: 8),

                Text(
                  news.content.length > 100
                      ? '${news.content.substring(0, 100)}...'
                      : news.content,
                  style: const TextStyle(color: Colors.black87),
                ),

                if (news.isFeatured) ...[
                  const SizedBox(height: 8),
                  const Text('FEATURED',
                      style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
