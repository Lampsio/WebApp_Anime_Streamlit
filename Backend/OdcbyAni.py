import psycopg2
import streamlit as st
import pandas as pd

def load_data():
    # Ustaw połączenie
    connection = psycopg2.connect(
        "postgresql://postgres:admin@localhost:5432/AnimeDB"
    )

    # Utwórz kursor
    cursor = connection.cursor()

    # Wykonaj zapytanie SQL
    cursor.execute("SELECT id, tytul FROM Anime")

    st.subheader('Lista Gatunków wedlug Anime')

    # Pobierz wyniki
    results = cursor.fetchall()

    # Zamień wyniki na DataFrame
    df = pd.DataFrame(results, columns=["id", "tytul"])

    return df, cursor, connection

def display_episodes(cursor, anime_id):
    # Wykonaj zapytanie SQL
    cursor.execute("SELECT nr_odcinka, tytul FROM odcinek WHERE anime_id = %s", (anime_id,))

    # Pobierz wyniki
    results = cursor.fetchall()

    # Zamień wyniki na DataFrame
    df = pd.DataFrame(results, columns=["nr_odcinka", "tytul"])

    return df
