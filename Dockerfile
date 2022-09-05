FROM python:3-alpine
COPY mycode.py /
CMD ["python3", "./mycode"]