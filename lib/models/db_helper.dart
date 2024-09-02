import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:news_updates/models/article_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'news_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE articles(id INTEGER PRIMARY KEY AUTOINCREMENT, author TEXT, title TEXT, description TEXT, url TEXT, urlToImage TEXT, content TEXT, publishedAt TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<void> insertArticle(ArticleModel article) async {
    final db = await database;
    await db.insert(
      'articles',
      article.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ArticleModel>> fetchArticles() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('articles');

    return List.generate(maps.length, (i) {
      return ArticleModel.fromMap(maps[i]);
    });
  }
}
