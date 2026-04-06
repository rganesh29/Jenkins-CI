FROM python:3.12-alpine
WORKDIR /home
COPY /app-code/bkd/* .
RUN pip install --no-cache-dir -r requirements.txt
EXPOSE 5000
CMD [ "python3", "app.py",]