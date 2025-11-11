from fastapi import FastAPI
from models import User
from database import DB

app = FastAPI()

@app.post("/users")
def create_user(user: User):
    DB["users"].append(user.dict())
    return user

@app.get("/users")
def list_users():
    return DB["users"]
