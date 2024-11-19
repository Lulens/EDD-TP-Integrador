# Cargar librerías necesarias
library(dplyr)
library(ggplot2)

# Cargar el archivo
file_path <- "C:/Users/Lucia Baez/Documents/UCA/Primer año/Exploracion de Datos/TP Integrador/World_Airports.csv"
data <- read.csv(file_path)

# --- Parte 1: Frecuencias Absolutas y Relativas ---
# Calcular frecuencias absolutas y relativas de la columna `type`
freq_table <- data %>%
  group_by(type) %>%
  summarise(
    Absolute_Frequency = n(),
    Relative_Frequency = n() / nrow(data)
  ) %>%
  mutate(Relative_Frequency_Percent = Relative_Frequency * 100)

print("Tabla de frecuencias:")
print(freq_table)

# --- Parte 2: ECDF para columna métrica ---
# Crear ECDF para `elevation_ft`
elevation_ecdf <- ecdf(data$elevation_ft)

# Graficar la ECDF
ggplot(data, aes(x = elevation_ft)) +
  stat_ecdf(geom = "step", color = "blue") +
  labs(
    title = "Empirical Cumulative Distribution Function (ECDF)",
    x = "Elevation (ft)",
    y = "Cumulative Probability"
  ) +
  theme_minimal()

# --- Parte 3: Agrupación de datos métricos ---
# Agrupar la columna `elevation_ft` en intervalos
data <- data %>%
  mutate(Elevation_Group = cut(elevation_ft, breaks = c(-Inf, 0, 1000, 5000, 10000, Inf), 
                               labels = c("<= 0", "1-1000", "1001-5000", "5001-10000", "> 10000")))

# Tabla de frecuencias por grupo
elevation_freq_table <- data %>%
  group_by(Elevation_Group) %>%
  summarise(
    Absolute_Frequency = n(),
    Relative_Frequency = n() / nrow(data)
  ) %>%
  mutate(Relative_Frequency_Percent = Relative_Frequency * 100)

print("Frecuencia por grupos de elevación:")
print(elevation_freq_table)

# --- Parte 4: Graficar distribución agrupada ---
ggplot(elevation_freq_table, aes(x = Elevation_Group, y = Absolute_Frequency, fill = Elevation_Group)) +
  geom_bar(stat = "identity") +
  labs(
    title = "Distribución de Frecuencias por Grupo de Elevación",
    x = "Grupo de Elevación (ft)",
    y = "Frecuencia Absoluta"
  ) +
  theme_minimal()
