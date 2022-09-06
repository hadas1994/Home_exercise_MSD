FROM python:3-alpine
COPY 1.py /
RUN pip install flask=="2.1.2"
EXPOSE 5000
CMD ["python3", "./1.py"]