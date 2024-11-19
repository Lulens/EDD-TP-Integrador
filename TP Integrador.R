library(dplyr)
library(readr)
library(stringr)

# Cargar el archivo CSV
file_path <- "C:/Users/Lucia Baez/Documents/UCA/Primer año/Exploracion de Datos/TP Integrador/World_Airports.csv"
data <- read_csv(file_path)

# Limpiar el dataset
data_cleaned <- data %>%
  # Quitar espacios al inicio y al final de todas las columnas de texto
  mutate(across(where(is.character), ~ str_trim(.))) %>%
  # Eliminar filas con valores NA o vacíos en todas las columnas usando if_any()
  filter(if_all(everything(), ~ !is.na(.) & . != ""))

# Guardar el archivo limpio
write_csv(data_cleaned, "World_Airports_cleaned.csv")
