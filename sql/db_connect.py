import psycopg2
import os
from dotenv import load_dotenv

load_dotenv()

def db_connect():
    try:
        db_conn = psycopg2.connect(
            host=os.getenv('HOST', 'localhost'),
            port=os.getenv('PORT', 5434),
            database=os.getenv('DATABASE', 'FinGuard_db'),
            user=os.getenv('USER', 'admin'),
            password=os.getenv('PASSWORD', 'admin')
        )
        db_cursor = db_conn.cursor()
    
        return db_cursor, db_conn
    
    except Exception as e:
        print("Database connection failed:", e) 
        return None

