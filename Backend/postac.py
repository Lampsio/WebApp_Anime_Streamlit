import psycopg2
import pandas as pd
import streamlit as st

def load_data():
    connection = psycopg2.connect("postgresql://postgres:admin@localhost:5432/AnimeDB")
    cursor = connection.cursor()
    cursor.execute("SELECT * FROM studio")
    st.subheader('Lista Postaci')
    results = cursor.fetchall()
    df = pd.DataFrame(results, columns=["id", "nazwa", "opis", "kraj", "rok_zalozenia"])
    return df, cursor, connection

def add_postac(cursor, connection):
    st.subheader('Dodaj nową Postac:')
    new_imie = st.text_input('Imię postaci')
    new_nazwisko = st.text_input('Nazwisko postaci')
    new_plec = st.text_input('Płeć postaci')
    new_url_zdjecie = st.text_input('URL zdjęcia postaci')
    new_gatunek = st.text_input('Gatunek postaci')
    new_anime_id = st.text_input('ID anime')
    new_aktor_id = st.text_input('ID aktora')

    if st.button('Dodaj postać'):
        cursor.execute("INSERT INTO postac (imie, nazwisko, plec, url_zdjecie, gatunek, anime_id, aktor_id) VALUES (%s, %s, %s, %s, %s, %s, %s)", (new_imie, new_nazwisko, new_plec, new_url_zdjecie, new_gatunek, new_anime_id, new_aktor_id))
        connection.commit()
        st.success('Dodano nową postać')
        st.rerun()

def edit_postac(cursor, connection):
    st.subheader('Edytuj Postac:')
    edit_id = st.text_input('ID postaci do edycji')
    new_imie = st.text_input('Nowe imię postaci')
    new_nazwisko = st.text_input('Nowe nazwisko postaci')
    new_plec = st.text_input('Nowa płeć postaci')
    new_url_zdjecie = st.text_input('Nowe URL zdjęcia postaci')
    new_gatunek = st.text_input('Nowy gatunek postaci')
    new_anime_id = st.text_input('Nowe ID anime')
    new_aktor_id = st.text_input('Nowe ID aktora')

    if st.button('Edytuj postać'):
        cursor.execute("UPDATE postac SET imie = %s, nazwisko = %s, plec = %s, url_zdjecie = %s, gatunek = %s, anime_id = %s, aktor_id = %s WHERE id = %s", (new_imie, new_nazwisko, new_plec, new_url_zdjecie, new_gatunek, new_anime_id, new_aktor_id, edit_id))
        connection.commit()
        st.success('Zaktualizowano postać')
        st.rerun()

def delete_postac(cursor, connection):
    st.subheader('Usun Postac')
    delete_id = st.text_input('ID postaci do usunięcia')

    if st.button('Usuń postać'):
        cursor.execute("DELETE FROM postac WHERE id = %s", (delete_id,))
        connection.commit()
        st.success('Usunięto postać')
        st.rerun()
