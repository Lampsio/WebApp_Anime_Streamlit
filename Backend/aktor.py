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
    cursor.execute("SELECT * FROM aktor")

    # Pobierz wyniki
    results = cursor.fetchall()

    st.subheader('Lista Aktorów')

    # Zamień wyniki na DataFrame
    df = pd.DataFrame(results, columns=["id", "imie", "nazwisko", "kraj", "rok_urodzenia", "biografia"])

    return df, cursor, connection

def add_aktor(cursor, connection):
    # Dodawanie nowego aktora
    st.subheader('Dodaj nowego aktora')
    new_imie = st.text_input('Imię aktora')
    new_nazwisko = st.text_input('Nazwisko aktora')
    new_kraj = st.text_input('Kraj pochodzenia aktora')
    new_rok_urodzenia = st.date_input('Rok urodzenia aktora')
    new_biografia = st.text_input('Biografia aktora')

    if st.button('Dodaj aktora'):
        # Dodaj nowego aktora do bazy danych
        cursor.execute("INSERT INTO aktor (imie, nazwisko, kraj, rok_urodzenia, biografia) VALUES (%s, %s, %s, %s, %s)", (new_imie, new_nazwisko, new_kraj, new_rok_urodzenia, new_biografia))
        connection.commit()
        st.success('Dodano nowego aktora')
        st.rerun()

def delete_aktor(cursor, connection):
    # Usuwanie istniejącego aktora
    st.subheader('Usuń istniejącego aktora')
    delete_id = st.text_input('ID aktora do usunięcia', key='delete_aktor_id')

    if st.button('Usuń aktora'):
        # Usuń aktora z bazy danych
        cursor.execute("DELETE FROM aktor WHERE id = %s", (delete_id,))
        connection.commit()
        st.success('Usunięto aktora')
        st.rerun()
