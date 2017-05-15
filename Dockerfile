FROM openjdk:8-jre-alpine

# install yeoman
#RUN npm install -g yo
# install JHipster
#RUN npm install -g generator-jhipster@1.10.2
# Install Bower & Grunt RUN
#RUN npm install -g bower grunt-cli
# Installer le gestionnaire de dépendances JS
#RUN npm install -g yarn

# On copie nos fichiers locaux dans le container
# Il faudrait mettre le même que -v de docker run lancé la première fois mais si on peut mettre /gordon il créer un autre volume de destination
COPY . /gordon

ENV JHIPSTER_SLEEP 0

RUN ./mvnw -Pprod package -DskipTests=true

# Renomme le package war
ADD *.war /app.war
# On modifie la date de modification pour que docker le prenne en compte
RUN sh -c 'touch /app.war'
# Spring Boot travaille dans ce dossier au besoin
VOLUME /tmp
# Container ecoute le port 8080 (bien ajouté -p dans le docker run pour le rendre accessible)
EXPOSE 8080
#CMD echo "The application will start in ${JHIPSTER_SLEEP}s..." && \
#    sleep ${JHIPSTER_SLEEP} && \
#    java -Djava.security.egd=file:/dev/./urandom -jar /app.war
#ENTRYPOINT ["java","-jar","app.war"]
# Djava.security.egd=file:/dev/./urandom permet de reduire le temps de démarrage de tomcat
ENV JAVA_OPTS=""
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /app.war" ]
