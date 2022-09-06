FROM python:3-alpine
ADD 1.py /
EXPOSE 5000
CMD ["python3", "./1.py"]