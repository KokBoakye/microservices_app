from fastapi import FastAPI
from models import Order
from database import DB
import requests

app = FastAPI()

USER_SERVICE_URL = "http://localhost:8001/users"

@app.post("/orders")
def create_order(order: Order):
    # validate user
    users = requests.get(USER_SERVICE_URL).json()
    if not any(u["id"] == order.user_id for u in users):
        return {"error": "User does not exist"}

    DB["orders"].append(order.dict())
    return order

@app.get("/orders")
def list_orders():
    return DB["orders"]
