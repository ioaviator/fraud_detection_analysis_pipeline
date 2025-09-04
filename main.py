from sql.db_connect import db_connect
from sql.create_table import create_table

def main():
  db_cursor,db_conn = db_connect()
  # print(db_conn)
  create_table(db_cursor)

  db_conn.commit()
  db_cursor.close()
  db_conn.close()

  print('done')

  return True

if __name__ == "__main__":
  main()