import psycopg2
import pandas as pd
import streamlit as st

def load_data():
    connection = psycopg2.connect("postgresql://postgres:admin@localhost:5432/AnimeDB")
    cursor = connection.cursor()
    cursor.execute("SELECT * FROM studio")
    st.subheader('Lista Tworcow')
    results = cursor.fetchall()
    df = pd.DataFrame(results, columns=["id", "nazwa", "opis", "kraj", "rok_zalozenia"])
    return df, cursor, connection

def add_tworca(cursor, connection):
    st.subheader('Dodaj Tworce:')
    new_imie = st.text_input('Imię twórcy')
    new_nazwisko = st.text_input('Nazwisko twórcy')
    new_rola = st.text_input('Rola twórcy')
    new_data_urodzenia = st.date_input('Data urodzenia twórcy')
    new_biografia = st.text_input('Biografia twórcy')

    if st.button('Dodaj twórcę'):
        cursor.execute("INSERT INTO tworca (imie, nazwisko, rola, data_urodzenia, biografia) VALUES (%s, %s, %s, %s, %s)", (new_imie, new_nazwisko, new_rola, new_data_urodzenia, new_biografia))
        connection.commit()
        st.success('Dodano nowego twórcę')
        st.rerun()

def edit_tworca(cursor, connection):
    st.subheader('Edytuj Tworce:')
    edit_id = st.text_input('ID twórcy do edycji')
    new_imie = st.text_input('Nowe imię twórcy')
    new_nazwisko = st.text_input('Nowe nazwisko twórcy')
    new_rola = st.text_input('Nowa rola twórcy')
    new_data_urodzenia = st.date_input('Nowa data urodzenia twórcy')
    new_biografia = st.text_input('Nowa biografia twórcy')

    if st.button('Edytuj twórcę'):
        cursor.execute("UPDATE tworca SET imie = %s, nazwisko = %s, rola = %s, data_urodzenia = %s, biografia = %s WHERE id = %s", (new_imie, new_nazwisko, new_rola, new_data_urodzenia, new_biografia, edit_id))
        connection.commit()
        st.success('Zaktualizowano twórcę')
        st.rerun()

def delete_tworca(cursor, connection):
    st.subheader('Usuń Tworce:')
    delete_id = st.text_input('ID twórcy do usunięcia')

    if st.button('Usuń twórcę'):
        cursor.execute("DELETE FROM tworca WHERE id = %s", (delete_id,))
        connection.commit()
        st.success('Usunięto twórcę')
        st.rerun()