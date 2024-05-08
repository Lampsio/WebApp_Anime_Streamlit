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
    cursor.execute("SELECT * FROM gatunek")

    # Pobierz wyniki
    results = cursor.fetchall()

    st.subheader('Lista Gatunków')

    # Zamień wyniki na DataFrame
    df = pd.DataFrame(results, columns=["id", "tytul", "opis"])

    return df, cursor, connection

def add_gatunek(cursor, connection):
    # Dodawanie nowego gatunku
    st.subheader('Dodaj nowy gatunek')
    new_tytul = st.text_input('Tytuł')
    new_opis = st.text_input('Opis')

    if st.button('Dodaj'):
        # Dodaj nowy gatunek do bazy danych
        cursor.execute("INSERT INTO gatunek (tytul, opis) VALUES (%s, %s)", (new_tytul, new_opis))
        connection.commit()
        st.success('Dodano nowy gatunek')
        st.rerun()

def delete_gatunek(cursor, connection):
    # Usuwanie istniejącego gatunku
    st.subheader('Usuń istniejący gatunek')
    delete_id = st.text_input('ID gatunku do usunięcia', key='delete_gatunek_id')

    if st.button('Usuń gatunek'):
        # Usuń gatunek z bazy danych
        cursor.execute("DELETE FROM gatunek WHERE id = %s", (delete_id,))
        connection.commit()
        st.success('Usunięto gatunek')
        st.rerun()

def edit_gatunek(cursor, connection):
    # Edycja istniejącego gatunku
    st.subheader('Edytuj istniejący gatunek')
    edit_id = st.text_input('ID gatunku do edycji', key='edit_gatunek_id')
    edit_tytul = st.text_input('Nowy tytuł gatunku', key='edit_gatunek_tytul')
    edit_opis = st.text_input('Nowy opis gatunku', key='edit_gatunek_opis')

    if st.button('Edytuj gatunek'):
        # Edytuj gatunek w bazie danych
        cursor.execute("UPDATE gatunek SET tytul = %s, opis = %s WHERE id = %s", (edit_tytul, edit_opis, edit_id))
        connection.commit()
        st.success('Zaktualizowano gatunek')
        st.rerun()
