FROM openjdk:8-jre-alpine

# On copie nos fichiers locaux dans le container
# Il faudrait mettre le même que -v de docker run lancé la première fois mais si on peut mettre /gordon il créer un autre volume de destination
COPY . /coocotte

ENV JHIPSTER_SLEEP 0

#RUN cd coocotte && ls -l
# Renomme le package war
ADD coocotte/target/*.war /app.war

# On modifie la date de modification pour que docker le prenne en compte
RUN sh -c 'touch /app.war'

# Spring Boot travaille dans ce dossier au besoin
VOLUME /tmp

# Container ecoute le port 8080 (bien ajouté -p dans le docker run pour le rendre accessible)
EXPOSE 8080

# Djava.security.egd=file:/dev/./urandom permet de reduire le temps de démarrage de tomcat
ENV JAVA_OPTS=""
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /app.war" ]
