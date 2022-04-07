class DataBaseTable {
  static String tableProfile = '''
      CREATE TABLE IF NOT EXISTS profile(
        cnic TEXT PRIMARY KEY NOT NULL,
        first_name TEXT NOT NULL,
        last_name TEXT NOT NULL,
        image TEXT,
        gender TEXT NOT NULL,
        country TEXT NOT NULL,
        description TEXT NOT NULL,
        created_date INTEGER NOT NULL,
        updated_date INTEGER NOT NULL
      )
      ''';
}
