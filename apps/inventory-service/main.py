from flask import Flask, jsonify
import random
import time

from opentelemetry import trace
from opentelemetry.instrumentation.flask import FlaskInstrumentor
from opentelemetry.sdk.resources import SERVICE_NAME, Resource
from opentelemetry.sdk.trace import TracerProvider
from opentelemetry.sdk.trace.export import BatchSpanProcessor
from opentelemetry.exporter.otlp.proto.http.trace_exporter import OTLPSpanExporter

# Tracing setup
trace.set_tracer_provider(
    TracerProvider(
        resource=Resource.create({SERVICE_NAME: "inventory-service"})
    )
)
tracer = trace.get_tracer(__name__)
span_processor = BatchSpanProcessor(OTLPSpanExporter(endpoint="http://localhost:4318/v1/traces"))
trace.get_tracer_provider().add_span_processor(span_processor)

# Flask app setup
app = Flask(__name__)
FlaskInstrumentor().instrument_app(app)

@app.route("/inventory", methods=["GET"])
def get_inventory():
    with tracer.start_as_current_span("check_inventory"):
        items = {"itemA": 100, "itemB": 50}
        time.sleep(1)
        return jsonify(items)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5004)
