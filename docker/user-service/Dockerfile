FROM python:3.10-slim
WORKDIR /app
COPY . /app
RUN pip install pymongo opentelemetry-api opentelemetry-sdk
CMD ["python", "simulate_mongo_scenarios.py"]
