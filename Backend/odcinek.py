import streamlit as st
import psycopg2
import pandas as pd

def load_data(anime_id=None):
    # Ustaw połączenie
    connection = psycopg2.connect(
        "postgresql://postgres:admin@localhost:5432/AnimeDB"
    )

    # Utwórz kursor
    cursor = connection.cursor()

    # Wykonaj zapytanie SQL
    if anime_id:
        cursor.execute("SELECT * FROM odcinek WHERE anime_id = %s", (anime_id,))
    else:
        cursor.execute("SELECT * FROM odcinek")

    st.subheader('Lista Odcinków')

    # Pobierz wyniki
    results = cursor.fetchall()

    # Zamień wyniki na DataFrame
    df = pd.DataFrame(results, columns=["id", "nr_odcinka", "tytul", "opis", "data_premiery", "dlugosc_odcinka", "anime_id", "ocena"])

    return df, cursor, connection

def add_odcinek(cursor, connection):
    # Dodawanie nowego odcinka
    st.subheader('Dodaj nowy odcinek')
    new_nr_odcinka = st.number_input('Numer odcinka', min_value=1)
    new_tytul = st.text_input('Tytuł odcinka')
    new_opis = st.text_input('Opis odcinka')
    new_data_premiery = st.date_input('Data premiery odcinka')
    new_dlugosc_odcinka = st.number_input('Długość odcinka', min_value=1)

    # Pobierz listę anime
    cursor.execute("SELECT id, tytul FROM Anime")
    anime = cursor.fetchall()
    anime_options = [f"{id} - {tytul}" for id, tytul in anime]
    new_anime_id = st.selectbox('Anime', anime_options, key='new_anime_id')

    new_ocena = st.number_input('Ocena odcinka', min_value=0.0, max_value=10.0, step=0.1)

    if st.button('Dodaj odcinek'):
        # Dodaj nowy odcinek do bazy danych
        cursor.execute("INSERT INTO odcinek (nr_odcinka, tytul, opis, data_premiery, dlugosc_odcinka, anime_id, ocena) VALUES (%s, %s, %s, %s, %s, %s, %s)", (new_nr_odcinka, new_tytul, new_opis, new_data_premiery, new_dlugosc_odcinka, new_anime_id.split(' - ')[0], new_ocena))
        connection.commit()
        st.success('Dodano nowy odcinek')
        st.rerun()

def delete_odcinek(cursor, connection):
    # Usuwanie istniejącego odcinka
    st.subheader('Usuń istniejący odcinek')
    delete_id = st.text_input('ID odcinka do usunięcia', key='delete_odcinek_id')

    if st.button('Usuń odcinek'):
        # Usuń odcinek z bazy danych
        cursor.execute("DELETE FROM odcinek WHERE id = %s", (delete_id,))
        connection.commit()
        st.success('Usunięto odcinek')
        st.rerun()
