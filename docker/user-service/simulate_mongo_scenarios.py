from pymongo import MongoClient
from opentelemetry.trace import get_current_span

client = MongoClient("mongodb://mongo:27017")
try:
    db = client.test
    db.users.find_one()
    trace_id = get_current_span().get_span_context().trace_id
    print(f"[INFO] Mongo query succeeded | trace_id={trace_id}")
except Exception as e:
    trace_id = get_current_span().get_span_context().trace_id
    print(f"[ERROR] MongoDB failure: {str(e)} | trace_id={trace_id}")
