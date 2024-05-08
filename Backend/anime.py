import streamlit as st
import psycopg2
import pandas as pd

def load_data():
    # Ustaw połączenie
    connection = psycopg2.connect(
        "postgresql://postgres:admin@localhost:5432/AnimeDB"
    )

    # Utwórz kursor
    cursor = connection.cursor()

    # Wykonaj zapytanie SQL
    cursor.execute("SELECT * FROM Anime")

    # Pobierz wyniki
    results = cursor.fetchall()

    st.subheader('Lista Anime')

    # Zamień wyniki na DataFrame
    df = pd.DataFrame(results, columns=["id", "tytul", "opis", "liczba_odcinkow", "typ", "data_premiery", "url_strony", "tworca_id", "gatunek_id", "ocena"])

    return df, cursor, connection

def add_anime(cursor, connection):
    # Dodawanie nowego anime
    st.subheader('Dodaj nowe anime')
    new_tytul = st.text_input('Tytuł Anime')
    new_opis = st.text_input('Opis Anime')
    new_liczba_odcinkow = st.number_input('Liczba odcinków', min_value=1)
    new_typ = st.text_input('Typ Anime')
    new_data_premiery = st.date_input('Data premiery Anime')
    new_url_strony = st.text_input('URL strony Anime')

    # Pobierz listę gatunków
    cursor.execute("SELECT id, tytul FROM gatunek")
    gatunki = cursor.fetchall()
    gatunki_options = [f"{id} - {tytul}" for id, tytul in gatunki]
    new_gatunek_id = st.selectbox('Gatunek Anime', gatunki_options)

    # Pobierz listę twórców
    cursor.execute("SELECT id, imie FROM tworca")
    tworcy = cursor.fetchall()
    tworcy_options = [f"{id} - {imie}" for id, imie in tworcy]
    new_tworca_id = st.selectbox('Twórca Anime', tworcy_options)

    new_ocena = st.number_input('Ocena Anime', min_value=0.0, max_value=10.0, step=0.1)

    if st.button('Dodaj Anime'):
        # Dodaj nowe anime do bazy danych
        cursor.execute("INSERT INTO Anime (tytul, opis, liczba_odcinkow, typ, data_premiery, url_strony, tworca_id, gatunek_id, ocena) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)", (new_tytul, new_opis, new_liczba_odcinkow, new_typ, new_data_premiery, new_url_strony, new_tworca_id.split(' - ')[0], new_gatunek_id.split(' - ')[0], new_ocena))
        connection.commit()
        st.success('Dodano nowe anime')
        st.rerun()

def delete_anime(cursor, connection):
    # Usuwanie istniejącego anime
    st.subheader('Usuń istniejące anime')
    delete_id = st.text_input('ID anime do usunięcia', key='delete_anime_id')

    if st.button('Usuń anime'):
        # Usuń anime z bazy danych
        cursor.execute("DELETE FROM Anime WHERE id = %s", (delete_id,))
        connection.commit()
        st.success('Usunięto anime')
        st.rerun()