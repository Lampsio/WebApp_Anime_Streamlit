import psycopg2
import pandas as pd
import streamlit as st

def load_data():
    connection = psycopg2.connect("postgresql://postgres:admin@localhost:5432/AnimeDB")
    cursor = connection.cursor()
    cursor.execute("SELECT tytul FROM Gatunek")
    results = cursor.fetchall()
    df = pd.DataFrame(results, columns=["tytul"])
    return df, cursor, connection

def query_creators(cursor, genre):
    cursor.execute("SELECT tw.imie, tw.nazwisko, a.tytul, g.tytul FROM tworca tw JOIN Anime a ON a.tworca_id = tw.id JOIN Gatunek g ON a.gatunek_id = g.id WHERE g.tytul = %s", (genre,))
    results = cursor.fetchall()
    df = pd.DataFrame(results, columns=["Imię", "Nazwisko", "Tytuł Anime", "Gatunek"])
    return df

def query_top_rated_anime(cursor, genre):
    cursor.execute("SELECT a.tytul, a.ocena, g.tytul FROM Anime a JOIN Gatunek g ON a.gatunek_id = g.id GROUP BY a.tytul, a.ocena, g.tytul HAVING g.tytul = %s ORDER BY a.ocena DESC LIMIT 5", (genre,))
    results = cursor.fetchall()
    df = pd.DataFrame(results, columns=["Tytuł Anime", "Ocena", "Gatunek"])
    return df


def query_most_anime_produced(cursor, year):
    cursor.execute("SELECT g.tytul, COUNT(*) AS liczba_anime FROM Gatunek g JOIN Anime a ON a.gatunek_id = g.id WHERE EXTRACT(YEAR FROM a.data_premiery) = %s GROUP BY g.tytul ORDER BY liczba_anime DESC", (year,))
    results = cursor.fetchall()
    df = pd.DataFrame(results, columns=["Tytuł Gatunku", "Liczba Anime"])
    return df

def query_most_episodes_aired(cursor, month):
    cursor.execute("SELECT a.tytul, COUNT(*) AS liczba_odcinkow FROM Anime a JOIN odcinek o ON a.id = o.anime_id WHERE EXTRACT(MONTH FROM o.data_premiery) = %s GROUP BY a.tytul ORDER BY liczba_odcinkow DESC", (month,))
    results = cursor.fetchall()
    df = pd.DataFrame(results, columns=["Tytuł Anime", "Liczba Odcinków"])
    return df

def query_most_anime_creators(cursor):
    cursor.execute("SELECT tw.imie, tw.nazwisko, COUNT(*) AS liczba_anime FROM tworca tw JOIN Anime a ON a.tworca_id = tw.id GROUP BY tw.imie, tw.nazwisko ORDER BY liczba_anime DESC")
    results = cursor.fetchall()
    df = pd.DataFrame(results, columns=["Imię", "Nazwisko", "Liczba Anime"])
    return df

def query_highest_rated_studio(cursor):
    cursor.execute("SELECT s.nazwa, AVG(o.ocena) AS srednia_ocena FROM studio s JOIN studio_anime sa ON s.id = sa.studio_id JOIN Anime a ON sa.anime_studio_id = a.id JOIN odcinek o ON a.id = o.anime_id GROUP BY s.nazwa ORDER BY srednia_ocena DESC")
    results = cursor.fetchall()
    df = pd.DataFrame(results, columns=["Nazwa Studia", "Średnia Ocena"])
    return df