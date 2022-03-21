#FROM vp914/kk_java
FROM vp914/kk_app
COPY ./setenv.sh /konakart/bin/
RUN chmod +x /konakart/bin/setenv.sh
#CMD /konakart/bin/startkonakart.sh && tail -F /konakart/logs/catalina.out /konakart/logs/KonaKart.log
ENTRYPOINT "/entrypoint.sh"
EXPOSE 8780 8783