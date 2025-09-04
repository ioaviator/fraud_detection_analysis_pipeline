

def create_table(db, sql_file='sql/commands/create_tables.sql'):
  
  with open(sql_file, 'r') as f:
    sql = f.read()
  
  db.execute(sql)

  print(f"Executing create tables SQL queries from {sql_file} ")

  return True