import sqlite3
import time
import datetime
import random

conn = sqlite3.connect('userInfo.db')
c = conn.cursor()

def create_table():
	c.execute('CREATE TABLE IF NOT EXISTS userInfo(email TEXT, password TEXT)')

def data_entry():
	c.execute("INSERT INTO userInfo VALUES('kyle@gmail.com', 'password123')")
	conn.commit()
	c.close()
	conn.close()


#create_table()
data_entry()