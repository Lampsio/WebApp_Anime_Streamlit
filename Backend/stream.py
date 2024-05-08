import streamlit as st
import gatunek , tworca , studio ,postac , anime , aktor, odcinek , zapytanie
import OdcbyAni as oba

##########################[GATUNEK]#########################

# Ładuj dane dla gatunku
df_gatunek, cursor_gatunek, connection_gatunek = gatunek.load_data()

# Wyświetl DataFrame w Streamlit
st.write(df_gatunek)

# Dodaj nowy gatunek
gatunek.add_gatunek(cursor_gatunek, connection_gatunek)

# Usuń gatunek
gatunek.delete_gatunek(cursor_gatunek, connection_gatunek)

# Edytuj gatunek
gatunek.edit_gatunek(cursor_gatunek, connection_gatunek)



##########################[ANIME]#########################


# Ładuj dane dla anime
df_anime, cursor_anime, connection_anime = anime.load_data()

# Wyświetl DataFrame w Streamlit
st.write(df_anime)

# Dodaj nowe anime
anime.add_anime(cursor_anime, connection_anime)

# Usuń anime
anime.delete_anime(cursor_anime, connection_anime)



##########################[AKTOR]#########################


# Ładuj dane dla aktora
df_aktor, cursor_aktor, connection_aktor = aktor.load_data()

# Wyświetl DataFrame w Streamlit
st.write(df_aktor)

# Dodaj nowego aktora
aktor.add_aktor(cursor_aktor, connection_aktor)

# Usuń aktora
aktor.delete_aktor(cursor_aktor, connection_aktor)


##########################[ODCINEK]#########################


# Ładuj dane dla aktora
df_odcinek, cursor_odcinek, connection_odcinek = odcinek.load_data()

# Wyświetl DataFrame w Streamlit
st.write(df_odcinek)

# Dodaj nowego aktora
odcinek.add_odcinek(cursor_odcinek, connection_odcinek)

# Usuń aktora
odcinek.delete_odcinek(cursor_odcinek, connection_odcinek)

# Ładuj dane
df, cursor, connection = oba.load_data()

# Wybierz anime z listy
anime_options = [f"{id} - {tytul}" for id, tytul in df.values]
selected_anime = st.selectbox('Wybierz Anime', anime_options)

# Wyświetl odcinki dla wybranego anime
df_episodes = oba.display_episodes(cursor, selected_anime.split(' - ')[0])
st.write(df_episodes)

##########################[POSTAC]#########################

# Ładuj dane dla aktora
df_postac, cursor_postac, connection_postac = postac.load_data()

# Wyświetl DataFrame w Streamlit
st.write(df_postac)

# Dodaj nową postac
postac.add_postac(cursor_postac, connection_postac)

# Usuń postac
postac.delete_postac(cursor_postac, connection_postac)

# Edytuj postac
postac.edit_postac(cursor_postac, connection_postac)

##########################[STUDIO]#########################

# Ładuj dane dla aktora
df_studio, cursor_studio, connection_studio = studio.load_data()

# Wyświetl DataFrame w Streamlit
st.write(df_studio)

# Dodaj nowe studio
studio.add_studio(cursor_studio, connection_studio)

# Usuń studio
studio.delete_studio(cursor_studio, connection_studio)

# Edytuj studio
studio.edit_studio(cursor_studio, connection_studio)


##########################[TWORCA]#########################

# Ładuj dane dla aktora
df_tworca, cursor_tworca, connection_tworca = tworca.load_data()

# Wyświetl DataFrame w Streamlit
st.write(df_tworca)

# Dodaj nowego tworce
tworca.add_tworca(cursor_tworca, connection_tworca)

# Usuń tworca
tworca.delete_tworca(cursor_tworca, connection_tworca)

# Edytuj tworca
tworca.edit_tworca(cursor_tworca, connection_tworca)


##########################[ZAPYTANIA]#########################

df_zapytanie, cursor_zapytanie, connection_zapytanie = zapytanie.load_data()

st.subheader('Wybierz Dany gatunek do prezentacji:')

# Wybierz gatunek z listy
genre_options = [tytul for tytul in df_zapytanie["tytul"]]
selected_genre = st.selectbox('Wybierz Gatunek', genre_options)

# Wykonaj zapytania SQL dla wybranego gatunku
df_creators = zapytanie.query_creators(cursor_zapytanie, selected_genre)
df_top_rated_anime = zapytanie.query_top_rated_anime(cursor_zapytanie, selected_genre)

st.subheader('Twórcy, którzy pracowali przy anime należącym do danego gatunku:')
st.write(df_creators)

st.subheader('Anime z najwyższą oceną w danym gatunku:')
st.write(df_top_rated_anime)

#####[Operacje na wprowadzanie liczb]#####

st.subheader('Operacje na wprowadzanie liczb')

st.subheader('Studio, które wyprodukowało najwięcej anime w danym roku:')

# Wybierz rok
selected_year = st.text_input('Podaj rok', value='2006')

# Wykonaj zapytanie SQL dla wybranego roku
df_most_anime_produced = zapytanie.query_most_anime_produced(cursor_zapytanie, selected_year)

st.write(df_most_anime_produced)

st.subheader('Anime, które miały najwięcej odcinków wyemitowanych w danym miesiącu:')

# Wybierz miesiąc
selected_month = st.text_input('Podaj miesiąc', value='5')

# Wykonaj zapytanie SQL dla wybranego miesiąca
df_most_episodes_aired = zapytanie.query_most_episodes_aired(cursor_zapytanie, selected_month)

st.write(df_most_episodes_aired)

####[zapytania na wyświetlanie]####

st.subheader('Zapytania na Wyświetlanie danych (liczba , Srednia)')

st.subheader('Twórcy, którzy pracowali przy największej liczbie anime:')

# Wykonaj zapytania SQL
df_most_anime_creators = zapytanie.query_most_anime_creators(cursor)
st.write(df_most_anime_creators)

st.subheader('Studio, które wyprodukowało anime z najwyższą średnią oceną odcinków:')

df_highest_rated_studio = zapytanie.query_highest_rated_studio(cursor)
st.write(df_highest_rated_studio)