
import pyodbc

server = 'CA-C-00657\\SQLEXPRESS'
database = 'Python'

cnxn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER='+server+';DATABASE='+database+';Trusted_Connection=yes') #cria o obj conector com os argumentos inseridos, indicando driver, server e database


cursor = cnxn.cursor()

cursor.execute(f"CREATE TABLE ALUNO (ID INT, NOME VARCHAR(255))") 
cursor.commit()
