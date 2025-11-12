from fastapi import FastAPI
import requests

app = FastAPI()

USER_SERVICE = "http://user-service.internal.local"
ORDER_SERVICE = "http://order-service.internal.local"

@app.get("/")
def root():
    return {"status": "API Gateway running"}

@app.get("/users")
def list_users():
    return requests.get(f"{USER_SERVICE}/users").json()

@app.post("/users")
def create_user(user: dict):
    return requests.post(f"{USER_SERVICE}/users", json=user).json()

@app.get("/orders")
def list_orders():
    return requests.get(f"{ORDER_SERVICE}/orders").json()

@app.post("/orders")
def create_order(order: dict):
    return requests.post(f"{ORDER_SERVICE}/orders", json=order).json()
