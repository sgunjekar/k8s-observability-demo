# Placeholder for simulate_mongo_scenarios.py
import time
import random
from pymongo import MongoClient, errors

SCENARIOS = [
    "connection_timeout",
    "auth_failure",
    "slow_query",
    "write_failure",
    "read_failure",
    "db_does_not_exist",
    "collection_not_found",
    "high_latency",
    "intermittent_failure",
    "bulk_insert_failure"
]

def run_scenario(scenario):
    print(f"Running MongoDB scenario: {scenario}")
    try:
        if scenario == "connection_timeout":
            client = MongoClient("mongodb://localhost:27018", serverSelectionTimeoutMS=1000)
            client.server_info()  # Should timeout

        elif scenario == "auth_failure":
            client = MongoClient("mongodb://wrongUser:wrongPass@localhost:27017")
            client.server_info()

        elif scenario == "slow_query":
            time.sleep(5)
            client = MongoClient("mongodb://localhost:27017")
            db = client.testdb
            db.collection.find_one()

        elif scenario == "write_failure":
            client = MongoClient("mongodb://localhost:27017")
            db = client.testdb
            raise errors.WriteError("Simulated write failure")

        elif scenario == "read_failure":
            client = MongoClient("mongodb://localhost:27017")
            db = client.testdb
            raise errors.OperationFailure("Simulated read failure")

        elif scenario == "db_does_not_exist":
            client = MongoClient("mongodb://localhost:27017")
            db = client.nonexistent
            db.collection.find_one()

        elif scenario == "collection_not_found":
            client = MongoClient("mongodb://localhost:27017")
            db = client.testdb
            db.nonexistent.find_one()

        elif scenario == "high_latency":
            start = time.time()
            time.sleep(3)
            duration = time.time() - start
            print(f"High latency operation took {duration:.2f} seconds")

        elif scenario == "intermittent_failure":
            if random.random() > 0.5:
                raise errors.NetworkTimeout("Simulated network timeout")
            else:
                print("Request succeeded")

        elif scenario == "bulk_insert_failure":
            client = MongoClient("mongodb://localhost:27017")
            db = client.testdb
            docs = [{'_id': 1}, {'_id': 1}]  # Duplicate _id
            db.collection.insert_many(docs)

    except Exception as e:
        print(f"Scenario '{scenario}' failed: {e}")


if __name__ == "__main__":
    for scenario in SCENARIOS:
        run_scenario(scenario)
        time.sleep(2)
