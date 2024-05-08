import psycopg2
import pandas as pd
import streamlit as st

def load_data():
    connection = psycopg2.connect("postgresql://postgres:admin@localhost:5432/AnimeDB")
    cursor = connection.cursor()
    cursor.execute("SELECT * FROM studio")
    st.subheader('Lista Studi')
    results = cursor.fetchall()
    df = pd.DataFrame(results, columns=["id", "nazwa", "opis", "kraj", "rok_zalozenia"])
    return df, cursor, connection

def add_studio(cursor, connection):
    st.subheader('Dodaj Studio:')
    new_nazwa = st.text_input('Nazwa studia')
    new_opis = st.text_input('Opis studia')
    new_kraj = st.text_input('Kraj studia')
    new_rok_zalozenia = st.text_input('Rok założenia studia')

    if st.button('Dodaj studio'):
        cursor.execute("INSERT INTO studio (nazwa, opis, kraj, rok_zalozenia) VALUES (%s, %s, %s, %s)", (new_nazwa, new_opis, new_kraj, new_rok_zalozenia))
        connection.commit()
        st.success('Dodano nowe studio')
        st.rerun()

def edit_studio(cursor, connection):
    st.subheader('Edytuj Studio')
    edit_id = st.text_input('ID studia do edycji')
    new_nazwa = st.text_input('Nowa nazwa studia')
    new_opis = st.text_input('Nowy opis studia')
    new_kraj = st.text_input('Nowy kraj studia')
    new_rok_zalozenia = st.text_input('Nowy rok założenia studia')

    if st.button('Edytuj studio'):
        cursor.execute("UPDATE studio SET nazwa = %s, opis = %s, kraj = %s, rok_zalozenia = %s WHERE id = %s", (new_nazwa, new_opis, new_kraj, new_rok_zalozenia, edit_id))
        connection.commit()
        st.success('Zaktualizowano studio')
        st.rerun()

def delete_studio(cursor, connection):
    st.subheader('Usuń Studio:')
    delete_id = st.text_input('ID studia do usunięcia')

    if st.button('Usuń studio'):
        cursor.execute("DELETE FROM studio WHERE id = %s", (delete_id,))
        connection.commit()
        st.success('Usunięto studio')
        st.rerun()