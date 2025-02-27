# Installation des Packets :

install.packages("ggplot2")  # Pour la visualisation
install.packages("deSolve")  # Pour la résolution d’équations différentielles
library(ggplot2)
library(deSolve)


# Paramètres du modèle
alpha <- 0.33   # Élasticité du capital
s <- 0.1        # Taux d'épargne
delta <- 0.05   # Taux de dépréciation
A <- 1          # Progrès technologique initial
L <- 1          # Population initiale
Tmax <- 100     # Nombre d'années de simulation



# Définition de la fonction de production
production <- function(K, A, L, alpha) {
  return(K^alpha * (A * L)^(1 - alpha))
}


# Initialisation des vecteurs de stockage
K <- numeric(Tmax)  # Stockage du capital pour chaque année
Y <- numeric(Tmax)  # Stockage du PIB pour chaque année
K[1] <- 1  # Le capital initial est fixé à 1




# Boucle de simulation : évolution du capital et du PIB
for (t in 1:(Tmax - 1)) {
  Y[t] <- production(K[t], A, L, alpha)  # Calcul du PIB
  K[t + 1] <- (1 - delta) * K[t] + s * Y[t]  # Évolution du capital
}


# Calcul du PIB pour la dernière année Y[Tmax] :
Y[Tmax] <- production(K[Tmax], A, L, alpha)



# Création d'un graphique avec ggplot
data <- data.frame(Année = 1:Tmax, Capital = K, PIB = Y)


# On trace le graphique :
ggplot(data, aes(x = Année)) +
  geom_line(aes(y = Capital, color = "Capital")) +
  geom_line(aes(y = PIB, color = "PIB")) +
  labs(title = "Évolution du capital et du PIB dans le modèle de Solow",
       x = "Année", y = "Valeur") +
  scale_color_manual(values = c("Capital" = "blue", "PIB" = "red"))







